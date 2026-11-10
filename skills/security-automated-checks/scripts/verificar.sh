#!/usr/bin/env bash
# Verificação automática da security-automated-checks: roda sobre o projeto só as ferramentas de segurança já
# instaladas, de forma passiva e local, guarda as saídas numa pasta nova, .security-standard/evidencias/<AAAA-MM-DD>/
# (ou <AAAA-MM-DD>-2/, -3/... se a do dia já existe), e imprime o resumo.md dela. Nunca instala nada: ferramenta
# ausente vira uma linha AUSENTE, e a saída é 0 (130 ou 143 se a rodada for interrompida).
# Uso: bash verificar.sh [--com-gancho] [raiz-do-projeto]
# O gancho_externo do config.yml só roda com --com-gancho, depois de o usuário conferir o comando.
set -eu

modelo="$(cd "$(dirname "$0")/.." && pwd)/assets/resumo-evidencias.md"
[ -f "$modelo" ] || { echo "ERRO: falta o modelo do resumo, $modelo" >&2; exit 1; }
com_gancho=0
raiz=.
for argumento in "$@"; do
  case $argumento in
    --com-gancho) com_gancho=1 ;;
    *) raiz=$argumento ;;
  esac
done
cd "$raiz"

# O que nunca fica guardado: chave da AWS, chave privada (PEM) e chave sk-... O certificado público não casa.
padrao='(AKIA[0-9A-Z]{16}|-----BEGIN [A-Z ]*PRIVATE KEY|sk-[A-Za-z0-9]{20,})'
# url_publica aceita: https://, o endereço e o caminho, sem colchetes, chaves, aspas nem espaços.
url_aceita=$'^https://[^][{}[:space:]"\'/]+(/[^][{}[:space:]"\']*)?$'
tabela=""
avisos=""
ferramenta=""
em_curso=""

# linha <ferramenta> <situação> <arquivo> <achados>: uma linha da tabela do resumo.
linha() { tabela="$tabela| $1 | $2 | $3 | $4 |"$'\n'; }
# aviso <texto>: uma linha da seção Avisos do resumo.
aviso() { avisos="$avisos- $1"$'\n'; }
# pulado <ferramenta> <motivo>: a ferramenta não rodou por causa do projeto ou do config.yml.
pulado() { linha "$1" pulado — —; aviso "PULADO $1 ($2)"; }
# nao_suportada <ferramenta> <forma certa>: a chave do config.yml está numa forma que o script não lê.
nao_suportada() { pulado "$1" "forma não suportada no config.yml; use $2"; }
# conferir <ferramenta> <motivo>: a ferramenta não rodou porque um arquivo do projeto pede leitura antes.
conferir() { linha "$1" pulado — —; aviso "CONFERIR $1 ($2)"; }

# tem <comando> <como instalar>: o comando está instalado; se não, a linha AUSENTE diz como instalar, sem instalar.
tem() {
  command -v "$1" > /dev/null 2>&1 && return 0
  linha "$1" ausente — —
  aviso "AUSENTE $1 (instale com: $2)"
  return 1
}

# le <chave>: lê a chave no .security-standard/config.yml como a maestra manda e põe o valor em $valor e a forma em
# $forma: "ok", "vazia" (vazio ou exemplo do modelo) ou "não suportada": chave repetida; chave seguida de linha
# recuada ou de lista; aspas ou colchetes em qualquer lugar da linha da chave, inclusive dentro do comando do gancho
# (a regra da maestra); ou valor que começa com um indicador do YAML (| e > abrem bloco, e & * ! % @ ` { ? têm outro
# sentido), que viraria outro comando. O valor vai do "chave:" até o primeiro " #", e só então se aparam os espaços.
le() {
  valor="" forma=vazia
  [ -f .security-standard/config.yml ] || return 0
  quantas=$(grep -c "^$1:" .security-standard/config.yml) || true
  [ "$quantas" -gt 0 ] || return 0
  if [ "$quantas" -gt 1 ] || grep "^$1:" .security-standard/config.yml | grep -q "[][\"']" || awk -v chave="$1:" '
    index($0, chave) == 1 {
      getline abaixo
      seguida = abaixo ~ /^[[:space:]]+[^[:space:]]/ || abaixo ~ /^-([[:space:]]|$)/
      exit
    }
    END { exit !seguida }' .security-standard/config.yml; then
    forma="não suportada"
    return 0
  fi
  valor=$(grep "^$1:" .security-standard/config.yml |
    sed -e 's/ #.*//' -e "s/^$1:[[:space:]]*//" -e 's/[[:space:]]*$//')
  case $valor in
    '' | '<'* | 'https://...' | 'owner/repo') valor="" ;;
    '|'* | '>'* | '&'* | '*'* | '!'* | '%'* | '@'* | '`'* | '{'* | '?'*) valor="" forma="não suportada" ;;
    *) forma=ok ;;
  esac
}

# repositorio_aceito <valor>: dono/nome, sem metacaractere e sem "." ou ".." no lugar do nome.
repositorio_aceito() {
  printf '%s' "$1" | grep -Eq '^[A-Za-z0-9-]+/[A-Za-z0-9._-]+$' || return 1
  case $1 in */. | */..) return 1 ;; esac
}

# limpa <arquivo>...: apaga o arquivo que tiver padrão de chave e avisa; o valor não fica guardado.
limpa() {
  for f in "$@"; do
    if [ -f "$f" ] && grep -E -q "$padrao" "$f"; then
      rm -f "$f"
      aviso "APAGADO $(printf '%s' "${f##*/}" | tr '\n\r' '??') (tinha padrão de chave)"
    fi
  done
}

# varre: tira da pasta da rodada os restos (.parcial, .limpo) e todo arquivo com padrão de chave. Os nomes vêm
# separados por NUL, e só se apaga o que, pelo caminho real, está dentro da pasta da rodada.
varre() {
  rm -f "$ev"/*.parcial "$ev"/*.limpo
  dentro=$(cd "$ev" && pwd -P)
  while IFS= read -r -d '' arquivo; do
    pasta=$(cd "$(dirname "$arquivo")" && pwd -P) || continue
    case $pasta/ in "$dentro"/*) limpa "$arquivo" ;; esac
  done < <(grep -E -r -l --null "$padrao" "$ev")
}

# nomes <arquivo>...: os nomes dos arquivos que existem, separados por vírgula.
nomes() {
  lista=""
  for f in "$@"; do [ ! -e "$f" ] || lista="$lista${lista:+, }${f##*/}"; done
  printf '%s' "$lista"
}

# sem_codigo <ferramenta> <arquivo>: tira do JSON do Trivy, do Checkov ou do Semgrep os trechos de código (onde
# fica a senha de um Dockerfile ou de um .tf, por exemplo) e mantém regra, arquivo, linha e gravidade. Falha
# fechada: sem o "ok" do Python (JSON ilegível, erro ao gravar, Python ausente ou interrompido), o arquivo é
# apagado, e a função sai com 1.
sem_codigo() {
  case $1 in trivy | checkov | semgrep) ;; *) return 0 ;; esac
  if ! command -v python3 > /dev/null 2>&1; then
    motivo="sem python3 para tirar os trechos de código"
  elif [ "$(json_sem_codigo "$1" "$2")" = ok ]; then
    return 0
  else
    motivo="não deu para tirar os trechos de código do JSON"
  fi
  rm -f "$2" "$2.limpo"
  aviso "APAGADO ${2##*/} ($motivo)"
  return 1
}

# json_sem_codigo <ferramenta> <arquivo>: o Python do sem_codigo; imprime "ok" só quando o arquivo ficou sem os
# trechos de código, e "ilegível" (depois de apagá-lo) em qualquer erro.
json_sem_codigo() {
  python3 -I - "$1" "$2" << 'PY' || true
import json
import os
import sys

ferramenta, caminho = sys.argv[1], sys.argv[2]
# Campos com trecho de código, em qualquer nível do JSON da ferramenta.
campos = {
    "trivy": {"Code", "RenderedCause", "Match"},
    "checkov": {"code_block", "fixed_definition"},
    "semgrep": {"lines", "metavars", "dataflow_trace", "fix", "fixed_lines", "rendered_fix", "message"},
}[ferramenta]


def sem(no):
    if isinstance(no, dict):
        return {chave: sem(valor) for chave, valor in no.items() if chave not in campos}
    if isinstance(no, list):
        return [sem(valor) for valor in no]
    return no


try:
    with open(caminho, encoding="utf-8") as arquivo:
        dados = json.load(arquivo)
    with open(caminho + ".limpo", "w", encoding="utf-8") as arquivo:
        json.dump(sem(dados), arquivo, ensure_ascii=False, indent=1)
    os.replace(caminho + ".limpo", caminho)
except Exception:
    # Qualquer erro (aninhado fundo demais, surrogate solto, disco cheio): o arquivo não fica.
    for resto in (caminho, caminho + ".limpo"):
        try:
            os.remove(resto)
        except OSError:
            pass
    print("ilegível")
else:
    print("ok")
PY
}

# achados <ferramenta> <arquivo>: o total do JSON e a contagem por gravidade com os rótulos da ferramenta,
# "CONFERIR <n> <contagem>" quando a ferramenta não conseguiu ler n arquivos, ou "ERRO <motivo>" quando o JSON traz
# um erro; nada para saída que não é de varredura.
achados() {
  command -v python3 > /dev/null 2>&1 || { printf '— (sem python3 para contar)'; return 0; }
  python3 -I - "$1" "$2" << 'PY' || true
import json
import sys

ferramenta, caminho = sys.argv[1], sys.argv[2]
if ferramenta not in ("gitleaks", "semgrep", "trivy", "osv-scanner", "checkov", "npm audit", "pip-audit"):
    sys.exit()
contagem = {}
# Arquivos que a ferramenta não conseguiu ler (summary.parsing_errors do Checkov): o achado deles não está na contagem.
nao_lidos = 0


def conta(rotulo="", n=1):
    contagem[rotulo] = contagem.get(rotulo, 0) + n


def cvss(nota):
    # Escala qualitativa do CVSS v3.1 (FIRST, seção 5).
    try:
        nota = float(nota)
    except (TypeError, ValueError):
        return "CVSS sem nota"
    for limite, rotulo in ((9, "CRITICAL"), (7, "HIGH"), (4, "MEDIUM"), (0.1, "LOW")):
        if nota >= limite:
            return "CVSS " + rotulo
    return "CVSS NONE"


try:
    with open(caminho, encoding="utf-8") as arquivo:
        dados = json.load(arquivo)
    if ferramenta == "gitleaks":
        for _ in dados:
            conta()
    elif ferramenta == "semgrep":
        for achado in dados["results"]:
            conta(achado["extra"].get("severity", "?"))
    elif ferramenta == "trivy":
        classes = {"Vulnerabilities": "vulnerabilidade", "Secrets": "segredo",
                   "Misconfigurations": "configuração", "Licenses": "licença"}
        for resultado in dados.get("Results") or []:
            for chave, classe in classes.items():
                for achado in resultado.get(chave) or []:
                    conta(classe + " " + achado.get("Severity", "?"))
    elif ferramenta == "osv-scanner":
        for resultado in dados.get("results") or []:
            for pacote in resultado.get("packages") or []:
                for grupo in pacote.get("groups") or []:
                    conta(cvss(grupo.get("max_severity")))
    elif ferramenta == "checkov":
        for bloco in dados if isinstance(dados, list) else [dados]:
            for achado in (bloco.get("results") or {}).get("failed_checks") or []:
                conta(achado.get("severity") or "")
            nao_lidos += int((bloco.get("summary") or {}).get("parsing_errors") or 0)
    elif ferramenta == "npm audit":
        if "error" in dados:
            print("ERRO " + str(dados["error"].get("code", "erro do npm")))
            sys.exit()
        for gravidade, n in dados["metadata"]["vulnerabilities"].items():
            if gravidade != "total" and n:
                conta(gravidade, n)
    elif ferramenta == "pip-audit":
        for dependencia in dados["dependencies"]:
            for _ in dependencia.get("vulns") or []:
                conta()
except (OSError, ValueError, KeyError, TypeError, AttributeError):
    print("ERRO JSON fora do formato esperado")
    sys.exit()

ordem = ["CRITICAL", "HIGH", "ERROR", "MEDIUM", "MODERATE", "WARNING", "LOW", "INFO", "UNKNOWN", "NONE"]


def posicao(item):
    classe, _, gravidade = item[0].rpartition(" ")
    gravidade = gravidade.upper()
    return classe, ordem.index(gravidade) if gravidade in ordem else len(ordem), item[0]


total = sum(contagem.values())
texto = str(total)
if set(contagem) - {""}:
    partes = [f"{rotulo or 'sem gravidade'} {n}" for rotulo, n in sorted(contagem.items(), key=posicao)]
    texto = f"{total} ({', '.join(partes)})"
print(f"CONFERIR {nao_lidos} {texto}" if nao_lidos else texto)
PY
}

# roda <ferramenta> <arquivo> <códigos de saída aceitos> <comando...>: roda o comando na raiz do projeto, com a
# saída de erro em <arquivo sem a extensão>.log. A evidência é o <arquivo> que o comando grava em $ev ou, se ele
# não grava, a saída padrão dele, sem os trechos de código. Rodou: código aceito e evidência não vazia; senão, erro,
# e o log fica.
roda() {
  ferramenta=$1 evidencia=$ev/$2 log=$ev/${2%.*}.log aceitos=" $3 "
  shift 3
  em_curso=$evidencia
  codigo=0
  "$@" > "$evidencia.parcial" 2> "$log" || codigo=$?
  if [ -e "$evidencia" ]; then rm -f "$evidencia.parcial"; else mv "$evidencia.parcial" "$evidencia"; fi
  [ -s "$evidencia" ] || rm -f "$evidencia"
  [ -s "$log" ] || rm -f "$log"
  filtro_apagou=0
  if [ -e "$evidencia" ] && ! sem_codigo "$ferramenta" "$evidencia"; then filtro_apagou=1; fi
  aceito=0
  case $aceitos in *" $codigo "*) aceito=1 ;; esac
  if [ "$ferramenta:$codigo" = osv-scanner:128 ]; then
    rm -f "$log"
    pulado osv-scanner "nenhum manifesto de dependência no projeto"
  elif [ "$aceito" -eq 1 ] && [ -e "$evidencia" ]; then
    rm -f "$log"
    limpa "$evidencia"
    if [ ! -e "$evidencia" ]; then
      linha "$ferramenta" rodou apagado —
    else
      resultado=$(achados "$ferramenta" "$evidencia")
      case $resultado in
        ERRO*)
          linha "$ferramenta" "erro (${resultado#ERRO })" "${evidencia##*/}" —
          aviso "ERRO $ferramenta (${resultado#ERRO }; veja ${evidencia##*/})"
          ;;
        CONFERIR*)
          resultado=${resultado#CONFERIR }
          nao_lidos=${resultado%% *}
          linha "$ferramenta" rodou "${evidencia##*/}" "${resultado#* } (+ $nao_lidos não lido(s): CONFERIR)"
          aviso "CONFERIR $ferramenta ($nao_lidos arquivo(s) que a ferramenta não conseguiu ler, como um arquivo fora de UTF-8; os achados deles não estão na contagem; veja summary.parsing_errors em ${evidencia##*/})"
          ;;
        *) linha "$ferramenta" rodou "${evidencia##*/}" "${resultado:-—}" ;;
      esac
    fi
  elif [ "$aceito" -eq 1 ] && [ "$filtro_apagou" -eq 1 ]; then
    rm -f "$log"
    linha "$ferramenta" rodou apagado —
  else
    limpa "$evidencia" "$log"
    arquivos=$(nomes "$evidencia" "$log")
    linha "$ferramenta" "erro (saída $codigo)" "${arquivos:-—}" —
    aviso "ERRO $ferramenta (saída $codigo${arquivos:+; veja $arquivos})"
  fi
  em_curso=""
}

# escreve_resumo: grava o resumo.md da pasta da rodada a partir do modelo.
escreve_resumo() {
  [ -n "$avisos" ] || aviso nenhum
  tabela=$tabela avisos=$avisos hoje=$hoje pasta=${ev##*/} awk '
    index($0, "| {{ferramenta}}") == 1 { printf "%s", ENVIRON["tabela"]; next }
    index($0, "- {{AUSENTE") == 1 { printf "%s", ENVIRON["avisos"]; next }
    { gsub(/[{][{]data[}][}]/, ENVIRON["hoje"]); gsub(/[{][{]pasta[}][}]/, ENVIRON["pasta"]); print }
  ' "$modelo" > "$ev/resumo.md"
}

# interrompe <código>: a rodada parou (INT ou TERM). Apaga a saída da ferramenta em curso, passa a pasta pela
# varredura, grava o resumo do que rodou e sai com o código.
interrompe() {
  trap - INT TERM
  if [ -n "$em_curso" ]; then
    rm -f "$em_curso" "$em_curso.parcial" "$em_curso.limpo" "${em_curso%.*}.log"
    aviso "INTERROMPIDO $ferramenta (a rodada parou durante esta ferramenta: a saída dela foi apagada, e as seguintes não rodaram)"
  else
    aviso "INTERROMPIDO (a rodada parou: as ferramentas seguintes não rodaram)"
  fi
  varre
  escreve_resumo
  exit "$1"
}

hoje=$(date +%Y-%m-%d)
# Cada rodada grava numa pasta nova, criada de uma vez pelo mkdir: se a do dia já existe (uma rodada anterior, uma
# rodada ao mesmo tempo ou documentos do usuário), vai para <AAAA-MM-DD>-2, -3 e assim por diante. O que já está em
# evidencias/ nunca é regravado nem apagado.
mkdir -p .security-standard/evidencias
ev=.security-standard/evidencias/$hoje
n=1
until mkdir "$ev" 2> /dev/null; do
  if [ ! -e "$ev" ] && [ ! -L "$ev" ]; then echo "ERRO: não consegui criar $ev" >&2; exit 1; fi
  n=$((n + 1))
  ev=.security-standard/evidencias/$hoje-$n
done
trap 'interrompe 130' INT
trap 'interrompe 143' TERM

# Arquivos de configuração das ferramentas na raiz: podem silenciar achados ou mudar o que a ferramenta faz.
configuracoes=""
for f in .gitleaks.toml .gitleaksignore .semgrepignore trivy.yaml trivy-secret.yaml .trivyignore osv-scanner.toml .npmrc; do
  [ ! -e "$f" ] || configuracoes="$configuracoes${configuracoes:+, }$f"
done
[ -z "$configuracoes" ] || aviso "CONFERIR $configuracoes (configuração das ferramentas no projeto, que pode silenciar achados ou mudar o que a ferramenta faz; leia antes de usar a evidência como verificada)"
# Num repositório git, a pasta interna tem de estar no .gitignore: sem isso, um git add -A levaria a evidência.
if git rev-parse --is-inside-work-tree > /dev/null 2>&1 && ! git check-ignore -q .security-standard/; then
  aviso "CONFERIR .security-standard/ fora do .gitignore (um git add -A levaria a evidência ao repositório; acrescente a linha do passo 1 da maestra security-standard)"
fi

# Fora de um repositório git, o gitleaks detect não lê nada e devolve uma lista vazia, que pareceria "sem segredo".
if ! tem gitleaks "brew install gitleaks"; then
  :
elif ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  pulado gitleaks "o projeto não é um repositório git, e o gitleaks detect lê o histórico do git"
else
  roda gitleaks gitleaks.json "0 1" \
    gitleaks detect --source . --redact --no-banner --report-format json --report-path "$ev/gitleaks.json"
fi
# A pasta interna (as rodadas anteriores e os documentos do usuário) fica fora da varredura do Semgrep e do Trivy:
# o que está nela contaria como achado do projeto. No git, o .gitignore já a tira do Semgrep; fora dele, o --exclude.
if tem semgrep "pipx install semgrep"; then
  roda semgrep semgrep.json 0 semgrep scan --config p/default --json -o "$ev/semgrep.json" --metrics off \
    --exclude .security-standard
fi
# O Trivy não lê o trivy.yaml do projeto (--config /dev/null), que pode até mandá-lo a um servidor de fora, nem o
# trivy-secret.yaml, que pode desligar regras de segredo: o --secret-config aponta para um caminho que não existe, na
# pasta nova da rodada (com /dev/null, o Trivy sai com FATAL).
if tem trivy "brew install trivy"; then
  roda trivy trivy.json 0 trivy fs --config /dev/null --secret-config "$ev/nenhum-trivy-secret.yaml" \
    --skip-dirs .security-standard --scanners vuln,secret,misconfig,license --format json -o "$ev/trivy.json" .
fi
if tem osv-scanner "brew install osv-scanner"; then
  roda osv-scanner osv.json "0 1" osv-scanner scan source -r . --format json
fi
# O Checkov lê o .checkov.yaml da pasta varrida mesmo com --config-file, e o external-checks-dir dele executa
# Python do projeto: com esse arquivo, o Checkov não roda. O --skip-download impede o Checkov de falar com a Prisma
# Cloud (a saída fica sem os links de documentação). A pasta interna ele não lê (conferido na 3.3.10).
if ! tem checkov "pip3 install checkov"; then
  :
elif [ -e .checkov.yaml ] || [ -e .checkov.yml ]; then
  conferir checkov "o projeto tem .checkov.yaml ou .checkov.yml, que o Checkov lê e que pode fazer ele executar código do repositório; o script não rodou o Checkov"
else
  roda checkov checkov.json "0 1" checkov -d . -o json --compact --skip-download
fi

if [ ! -f package-lock.json ]; then
  pulado "npm audit" "sem package-lock.json"
elif tem npm "o instalador do Node.js, que traz o npm"; then
  roda "npm audit" npm-audit.json "0 1" npm audit --json
fi
if [ ! -f requirements.txt ] && [ ! -f pyproject.toml ]; then
  pulado pip-audit "sem requirements.txt nem pyproject.toml"
elif tem pip-audit "python -m pip install pip-audit"; then
  roda pip-audit pip-audit.json "0 1" pip-audit -f json
fi

# Cabeçalhos HTTP: só o endereço do próprio sistema, da url_publica, sem a expansão de [] e {} do curl (-g).
le url_publica
if [ "$forma" = vazia ]; then
  pulado curl "url_publica vazia ou de exemplo no config.yml"
elif [ "$forma" != ok ] || ! printf '%s' "$valor" | grep -Eq "$url_aceita"; then
  nao_suportada curl "url_publica: https://<endereço do próprio sistema>, numa linha só, sem colchetes, chaves, aspas nem espaços"
elif tem curl "o gerenciador de pacotes do sistema"; then
  roda curl cabecalhos.txt 0 curl -g -sI -L --max-time 20 "$valor"
fi

# Proteção da branch principal: só o repositório do repositorio_github, só com a sessão do gh já aberta.
le repositorio_github
if [ "$forma" = vazia ]; then
  pulado "gh api" "repositorio_github vazio ou de exemplo no config.yml"
elif [ "$forma" != ok ] || ! repositorio_aceito "$valor"; then
  nao_suportada "gh api" "repositorio_github: dono/nome, numa linha só"
elif ! tem gh "brew install gh"; then
  :
elif ! gh auth status > /dev/null 2>&1; then
  pulado "gh api" "o gh não tem sessão válida; o usuário roda gh auth login"
else
  principal=$(gh api "repos/$valor" --jq .default_branch 2> /dev/null) || principal=""
  if [ -n "$principal" ]; then
    roda "gh api" branch-protection.json 0 gh api "repos/$valor/branches/$principal/protection"
  else
    linha "gh api" erro — —
    aviso "ERRO gh api (não li a branch principal do repositorio_github; confira o nome e o acesso)"
  fi
fi

# Gancho externo: um comando do config.yml, que só roda com --com-gancho e numa forma que o script lê sem dúvida.
le gancho_externo
if [ "$forma" = vazia ]; then
  pulado gancho_externo "gancho_externo vazio ou de exemplo no config.yml"
elif [ "$forma" != ok ]; then
  nao_suportada gancho_externo "gancho_externo: <comando>, numa linha só, sem aspas nem colchetes e sem repetir a chave"
elif [ "$com_gancho" -eq 0 ]; then
  pulado gancho_externo "rode com --com-gancho depois de conferir o comando"
else
  ferramenta=gancho_externo em_curso=$ev/gancho.txt
  codigo=0
  bash -c "$valor" > "$ev/gancho.txt" 2>&1 || codigo=$?
  [ -s "$ev/gancho.txt" ] || rm -f "$ev/gancho.txt"
  limpa "$ev/gancho.txt"
  arquivos=$(nomes "$ev/gancho.txt")
  if [ "$codigo" -eq 0 ]; then
    linha gancho_externo rodou "${arquivos:-—}" —
  else
    linha gancho_externo "erro (saída $codigo)" "${arquivos:-—}" —
    aviso "ERRO gancho_externo (saída $codigo${arquivos:+; veja $arquivos})"
  fi
  em_curso=""
fi

# A pasta é só desta rodada: o que ainda tiver padrão de chave (um arquivo que o gancho gravou nela, por exemplo)
# é apagado, e o grep -r da pasta fica vazio.
varre
escreve_resumo
cat "$ev/resumo.md"
