#!/usr/bin/env bash
# Testa o verificar.sh da security-automated-checks em projetos temporários, um deles com chaves e uma senha falsas.
# Uso: bash scripts/testes/verificar.test.sh (de qualquer diretório). Última linha: TESTE OK.
# Com o PATH normal, roda as ferramentas instaladas só sobre os projetos temporários; os valores de exemplo do
# config.yml deixam o curl e o gh api parados. Os outros casos rodam só com os utilitários que o script usa,
# às vezes com ferramentas de mentira na frente, que não saem da máquina.
set -eu

testes=$(cd "$(dirname "$0")" && pwd)
repositorio=$(dirname "$(dirname "$testes")")
[ -f "$repositorio/skills/security-automated-checks/scripts/verificar.sh" ] ||
  { echo "FALHOU: skills/security-automated-checks/scripts/verificar.sh não existe" >&2; exit 1; }
tmp=$(mktemp -d "${TMPDIR:-/tmp}/verificar.XXXXXX")
trap 'rm -rf "$tmp"' EXIT
# Os temporários das ferramentas (caches do Semgrep e do Checkov) ficam dentro da pasta do teste.
mkdir "$tmp/tmp"
export TMPDIR="$tmp/tmp"
# O PATH "sem ferramentas" só tem os utilitários que o script, os ganchos e as ferramentas de mentira usam: nenhum
# varredor que more em /usr/bin (como no Linux) entra nesses casos.
utilitarios=$tmp/utilitarios
mkdir "$utilitarios"
for comando in awk bash cat date dirname git grep head ls mkdir mv python3 rm sed sleep touch tr; do
  ln -s "$(command -v "$comando")" "$utilitarios/$comando"
done
# A pasta-base da skill e a raiz do projeto com espaço, como `Application Support` no macOS.
cp -R "$repositorio/skills/security-automated-checks" "$tmp/pasta base"
verificar="$tmp/pasta base/scripts/verificar.sh"
projeto="$tmp/projeto de teste"
hoje=$(date +%Y-%m-%d)
base="$projeto/.security-standard/evidencias/$hoje"
rodadas=0
padrao='(AKIA[0-9A-Z]{16}|-----BEGIN [A-Z ]*PRIVATE KEY|sk-[A-Za-z0-9]{20,})'
# Os valores de exemplo são montados em partes, para nenhum varredor achar chave neste arquivo. A chave de exemplo,
# com o fim EXAMPLE, é ignorada pelas ferramentas; a segunda chave e a senha falsa, não.
fim=IOSFODNN7EXAMPLE
chave="AKIA$fim"
parte=Z3MPLQ7RT2VW5XYB
chave2="AKIA$parte"
privada="PRIVATE KEY"
senha="SenhaFalsa$parte"

falhou() { echo "FALHOU: $1" >&2; exit 1; }

# espera_saida <código> <comando...>: roda o comando, mostra a saída (fica em $saida) e confere o código.
espera_saida() {
  esperado=$1
  shift
  codigo=0
  saida=$("$@" 2>&1) || codigo=$?
  [ -z "$saida" ] || echo "$saida"
  [ "$codigo" -eq "$esperado" ] || falhou "'$*' saiu com $codigo (esperado: $esperado)"
}
# contem e nao_contem <texto>: conferem a saída do último espera_saida.
contem() { case $saida in *"$1"*) ;; *) falhou "a saída não tem: $1" ;; esac; }
nao_contem() { case $saida in *"$1"*) falhou "a saída tem: $1" ;; esac; }
# rodada <comando...>: roda o comando (o verificar.sh no projeto), espera saída 0 e põe em $ev a pasta da rodada:
# a do dia na primeira, depois <dia>-2, <dia>-3... (a evidência do dia nunca é regravada).
rodada() {
  rodadas=$((rodadas + 1))
  ev=$base
  [ "$rodadas" -eq 1 ] || ev=$base-$rodadas
  espera_saida 0 "$@"
  [ -f "$ev/resumo.md" ] || falhou "a rodada $rodadas não gravou $ev/resumo.md"
}
# sem_ferramentas <argumentos...>: uma rodada no projeto só com os utilitários, sem os varredores.
sem_ferramentas() { rodada env PATH="$utilitarios" bash "$verificar" "$@" "$projeto"; }
# config <linhas...>: grava o config.yml do projeto, uma linha por argumento.
config() { printf '%s\n' "$@" > "$projeto/.security-standard/config.yml"; }
# resumo_tem <texto>: o resumo.md da rodada tem o texto.
resumo_tem() { grep -qF -- "$1" "$ev/resumo.md" || falhou "o resumo.md não tem: $1"; }
# sem_segredo: nenhum arquivo da pasta da rodada tem padrão de chave.
sem_segredo() {
  if grep -E -r -q "$padrao" "$ev"; then falhou "padrão de segredo em: $(grep -E -r -l "$padrao" "$ev")"; fi
}
# sem_texto <texto>: nenhum arquivo da pasta da rodada tem o texto.
sem_texto() {
  if grep -r -F -q -- "$1" "$ev"; then falhou "\"$1\" em: $(grep -r -F -l -- "$1" "$ev")"; fi
}

# O projeto: um repositório git com a chave de exemplo, a segunda chave e a senha falsa no Dockerfile e no .tf.
mkdir -p "$projeto/.security-standard"
printf 'AWS_KEY=%s\n' "$chave" > "$projeto/.env.exemplo"
printf 'OUTRA=%s\n' "$chave2" > "$projeto/config.txt"
printf 'FROM alpine:3.18\nENV DB_PASSWORD=%s\nUSER root\n' "$senha" > "$projeto/Dockerfile"
printf 'resource "aws_db_instance" "db" {\n  engine   = "mysql"\n  password = "%s"\n}\n' "$senha" > "$projeto/main.tf"
printf '.security-standard/\n' > "$projeto/.gitignore"
git -C "$projeto" init -q
git -C "$projeto" add -A
git -C "$projeto" -c user.name=teste -c user.email=teste@exemplo.invalid -c commit.gpgsign=false \
  -c core.hooksPath=/dev/null commit -q --no-verify -m "projeto de teste"

echo "caso: sem ferramentas, com o modelo do config.yml da maestra"
cp "$repositorio/skills/security-standard/assets/config.yml" "$projeto/.security-standard/config.yml"
sem_ferramentas
contem "AUSENTE gitleaks (instale com:"
contem "AUSENTE semgrep (instale com:"
resumo_tem "AUSENTE gitleaks (instale com:"
resumo_tem "PULADO npm audit (sem package-lock.json)"
resumo_tem "PULADO curl (url_publica vazia ou de exemplo no config.yml)"
resumo_tem "PULADO gh api (repositorio_github vazio ou de exemplo no config.yml)"
resumo_tem "PULADO gancho_externo (gancho_externo vazio ou de exemplo no config.yml)"
sem_segredo
nao_contem "fora do .gitignore"

echo "caso: segunda rodada no mesmo dia (a pasta do dia e o documento do usuário ficam como estão)"
primeira=$ev
cp "$primeira/resumo.md" "$tmp/resumo-da-primeira.md"
printf 'documento do usuário\n-----BEGIN CERTIFICATE-----\n' > "$primeira/documento-do-usuario.txt"
cp "$primeira/documento-do-usuario.txt" "$tmp/documento-do-usuario.txt"
config "gancho_externo: echo outra rodada"
sem_ferramentas
contem ".security-standard/evidencias/${ev##*/}/"
cmp -s "$tmp/resumo-da-primeira.md" "$primeira/resumo.md" || falhou "a segunda rodada regravou o resumo.md da primeira"
cmp -s "$tmp/documento-do-usuario.txt" "$primeira/documento-do-usuario.txt" ||
  falhou "a segunda rodada mexeu no documento do usuário"

echo "caso: valor que é só comentário depois de ' #', com --com-gancho"
config "url_publica: # nenhum por enquanto" "repositorio_github: # nenhum por enquanto" \
  "gancho_externo:   # nenhum por enquanto"
sem_ferramentas --com-gancho
resumo_tem "PULADO curl (url_publica vazia ou de exemplo no config.yml)"
resumo_tem "PULADO gh api (repositorio_github vazio ou de exemplo no config.yml)"
resumo_tem "PULADO gancho_externo (gancho_externo vazio ou de exemplo no config.yml)"
[ ! -e "$ev/gancho.txt" ] || falhou "o gancho rodou com o valor vazio"

echo "caso: PATH normal, com os valores de exemplo antigos do config.yml e comentário depois de ' #'"
# Sem o corte no ' #', a url_publica deixaria de ser o exemplo e o curl rodaria. O gh fica sem sessão
# (configuração vazia, sem token): se o owner/repo deixasse de ser exemplo, nada iria ao GitHub.
# Com as ferramentas instaladas, o gitleaks e o Trivy acham a segunda chave e o Trivy e o Checkov acham a senha do
# Dockerfile e do .tf; a chave e a senha não podem ficar na evidência. Sem as ferramentas (como no CI), estas
# conferências não têm o que olhar, e os casos das ferramentas de mentira cobrem o mesmo.
config "nivel_alvo: Essencial" "# url_publica: http://127.0.0.1:9" "url_publica: https://... # exemplo" \
  "repositorio_github: owner/repo" "gancho_externo: <comando só leitura>" "excluir:"
mkdir "$tmp/gh"
rodada env -u GH_TOKEN -u GITHUB_TOKEN GH_CONFIG_DIR="$tmp/gh" bash "$verificar" "$projeto"
if grep -r -q AKIA "$ev"; then falhou "AKIA nos arquivos de evidência: $(grep -r -l AKIA "$ev")"; fi
sem_segredo
sem_texto "$senha"
resumo_tem "PULADO curl (url_publica vazia ou de exemplo no config.yml)"
resumo_tem "PULADO gh api (repositorio_github vazio ou de exemplo no config.yml)"
resumo_tem "PULADO gancho_externo (gancho_externo vazio ou de exemplo no config.yml)"
for arquivo in cabecalhos.txt branch-protection.json gancho.txt; do
  [ ! -e "$ev/$arquivo" ] || falhou "$arquivo existe, mas o valor do config.yml era de exemplo"
done

echo "caso: gancho definido, sem --com-gancho"
config "gancho_externo: touch gancho-rodou; echo saida do gancho # comentário"
sem_ferramentas
contem "PULADO gancho_externo (rode com --com-gancho depois de conferir o comando)"
resumo_tem "PULADO gancho_externo (rode com --com-gancho depois de conferir o comando)"
[ ! -e "$projeto/gancho-rodou" ] || falhou "o gancho rodou sem --com-gancho"
[ ! -e "$ev/gancho.txt" ] || falhou "há gancho.txt sem --com-gancho"

echo "caso: gancho definido, com --com-gancho"
sem_ferramentas --com-gancho
[ -e "$projeto/gancho-rodou" ] || falhou "o gancho não rodou com --com-gancho"
grep -qx "saida do gancho" "$ev/gancho.txt" || falhou "o gancho.txt não tem a saída do gancho"
resumo_tem "| gancho_externo | rodou | gancho.txt |"
nao_contem "PULADO gancho_externo"

# Os ganchos dos casos abaixo não têm aspas nem colchetes: linha de chave com eles é forma não suportada.
echo "caso: gancho que imprime chave da AWS, chave privada ou sk-..., com --com-gancho"
for segredo in "AWS_KEY=$chave" "-----BEGIN OPENSSH $privada-----" "OPENAI=sk-teste0123456789$fim"; do
  config "gancho_externo: echo $segredo"
  sem_ferramentas --com-gancho
  contem "APAGADO gancho.txt"
  [ ! -e "$ev/gancho.txt" ] || falhou "o gancho.txt com segredo não foi apagado"
  sem_segredo
done

echo "caso: gancho que imprime um certificado público (só chave privada é apagada)"
config "gancho_externo: echo -----BEGIN CERTIFICATE-----"
sem_ferramentas --com-gancho
grep -qx -- "-----BEGIN CERTIFICATE-----" "$ev/gancho.txt" || falhou "a saída com o certificado público foi apagada"

echo "caso: gancho que grava um arquivo com chave na pasta da rodada (a varredura final da pasta)"
config "gancho_externo: d=\$(ls -td .security-standard/evidencias/*/ | head -n 1); echo AWS_KEY=$chave > \${d}extra.txt"
sem_ferramentas --com-gancho
contem "APAGADO extra.txt"
[ ! -e "$ev/extra.txt" ] || falhou "o extra.txt com chave não foi apagado"
sem_segredo

echo "caso: gancho que grava na pasta da rodada um nome com quebra de linha (a varredura não sai da pasta)"
printf 'AWS_KEY=%s\n' "$chave2" > "$projeto/alvo.txt"
# Sem aspas: o printf %b monta o nome com a quebra de linha, e o IFS vazio impede que a quebra divida o nome.
config "gancho_externo: d=\$(ls -td .security-standard/evidencias/*/ | head -n 1); printf -v n %b x\\\\nalvo.txt; IFS=; echo AWS_KEY=$chave2 > \$d\$n"
sem_ferramentas --com-gancho
[ -f "$projeto/alvo.txt" ] || falhou "a varredura apagou o alvo.txt da raiz do projeto, fora da pasta da rodada"
contem "APAGADO x?alvo.txt"
sem_segredo
rm "$projeto/alvo.txt"

echo "caso: gancho em forma não suportada, mesmo com --com-gancho (aspas ou colchetes em qualquer lugar da linha, chave repetida e lista)"
for forma in "gancho_externo: \"echo visivel\" ; touch marca-aspas-duplas" "gancho_externo: 'touch marca-aspas'" \
  "gancho_externo: [touch, marca-colchete]" "gancho_externo: touch \"marca-aspas-dentro\"" \
  "gancho_externo: touch marca-colchete-dentro; test -n [x]" \
  "gancho_externo: touch marca-primeira
gancho_externo: touch marca-segunda" \
  "gancho_externo:
  - touch marca-lista"; do
  printf '%s\n' "$forma" > "$projeto/.security-standard/config.yml"
  sem_ferramentas --com-gancho
  resumo_tem "PULADO gancho_externo (forma não suportada no config.yml"
  for marca in "$projeto"/marca-*; do [ ! -e "$marca" ] || falhou "o gancho em forma não suportada rodou: $marca"; done
  [ ! -e "$ev/gancho.txt" ] || falhou "há gancho.txt com o gancho em forma não suportada"
done

echo "caso: gancho com indicador de bloco ou outro indicador do YAML, ou com linha recuada abaixo (nenhum comando é montado)"
printf 'arquivo do usuário, que não pode ser zerado\n' > "$projeto/2"
cp "$projeto/2" "$tmp/arquivo-2"
for forma in "gancho_externo: >-
  touch marca-bloco" "gancho_externo: >2" "gancho_externo: |
  touch marca-literal" "gancho_externo: &ancora touch marca-ancora" "gancho_externo: *ancora" \
  "gancho_externo: !tag touch marca-tag" "gancho_externo: %touch marca-porcento" "gancho_externo: @touch marca-arroba" \
  "gancho_externo: \`touch marca-crase\`" "gancho_externo: {touch: marca-chaves}" "gancho_externo: ?touch marca-pergunta" \
  "gancho_externo: touch marca-recuada
  echo continua"; do
  printf '%s\n' "$forma" > "$projeto/.security-standard/config.yml"
  sem_ferramentas --com-gancho
  resumo_tem "PULADO gancho_externo (forma não suportada no config.yml"
  [ ! -e "$projeto/-" ] || falhou "o gancho >- criou o arquivo - na raiz do projeto"
  cmp -s "$tmp/arquivo-2" "$projeto/2" || falhou "o gancho >2 mexeu no arquivo 2 do usuário"
  for marca in "$projeto"/marca-*; do [ ! -e "$marca" ] || falhou "o gancho em forma não suportada rodou: $marca"; done
  [ ! -e "$ev/gancho.txt" ] || falhou "há gancho.txt com o gancho em forma não suportada"
done
rm "$projeto/2"

# curl e gh de mentira: registram cada chamada, e nada sai da máquina.
mkdir "$tmp/bin-rede"
cat > "$tmp/bin-rede/curl" << 'EOF'
#!/bin/sh
echo "curl $*" >> "$CHAMADAS"
printf 'HTTP/2 200\r\nstrict-transport-security: max-age=31536000\r\n\r\n'
EOF
cat > "$tmp/bin-rede/gh" << 'EOF'
#!/bin/sh
echo "gh $*" >> "$CHAMADAS"
case "$*" in
  "auth status") exit 0 ;;
  *" --jq .default_branch") echo main ;;
  */protection) echo '{"message":"Branch not protected"}'; echo 'gh: Branch not protected (HTTP 404)' >&2; exit 1 ;;
esac
EOF
chmod +x "$tmp/bin-rede/curl" "$tmp/bin-rede/gh"
com_rede() { : > "$tmp/chamadas.txt"; rodada env CHAMADAS="$tmp/chamadas.txt" PATH="$tmp/bin-rede:$utilitarios" bash "$verificar" "$projeto"; }

echo "caso: url_publica em forma não suportada (nenhum pedido sai do curl)"
for url in "https://sistema.exemplo.invalid/[1-3]" "https://{sistema,terceiro}.exemplo.invalid" \
  "http://sistema.exemplo.invalid" "\"https://sistema.exemplo.invalid\"" "https://sistema.exemplo.invalid/com espaco" \
  "sistema.exemplo.invalid"; do
  config "url_publica: $url"
  com_rede
  resumo_tem "PULADO curl (forma não suportada no config.yml"
  [ ! -s "$tmp/chamadas.txt" ] || falhou "o curl rodou com url_publica: $url"
done

echo "caso: repositorio_github em forma não suportada (o gh não é chamado)"
for repo in "dono/.." "dono/." "dono/nome;id" "\"dono/nome\"" "dono/nome/outro" "https://github.com/dono/nome"; do
  config "repositorio_github: $repo"
  com_rede
  resumo_tem "PULADO gh api (forma não suportada no config.yml"
  [ ! -s "$tmp/chamadas.txt" ] || falhou "o gh rodou com repositorio_github: $repo"
done

echo "caso: curl e gh de mentira (só o endereço e o repositório do config.yml, e o gh só depois do gh auth status)"
config "url_publica: https://sistema.exemplo.invalid" "repositorio_github: dono/nome"
com_rede
contem "| curl | rodou | cabecalhos.txt | — |"
contem "| gh api | erro (saída 1) | branch-protection.json, branch-protection.log | — |"
printf '%s\n' "curl -g -sI -L --max-time 20 https://sistema.exemplo.invalid" "gh auth status" \
  "gh api repos/dono/nome --jq .default_branch" "gh api repos/dono/nome/branches/main/protection" > "$tmp/esperado.txt"
cmp -s "$tmp/esperado.txt" "$tmp/chamadas.txt" || falhou "chamadas ao curl e ao gh: $(cat "$tmp/chamadas.txt")"

echo "caso: ferramentas de mentira num projeto fora do git (contagem, erro no JSON e gitleaks sem histórico)"
sem_git="$tmp/projeto sem git"
mkdir -p "$sem_git" "$tmp/bin-contagem"
printf '{}\n' > "$sem_git/package-lock.json"
cat > "$tmp/bin-contagem/gitleaks" << 'EOF'
#!/bin/sh
touch gitleaks-rodou
EOF
cat > "$tmp/bin-contagem/osv-scanner" << 'EOF'
#!/bin/sh
echo '{"results":[{"packages":[{"groups":[{"max_severity":"7.5"},{"max_severity":"5.3"},{"max_severity":""}]}]}]}'
exit 1
EOF
cat > "$tmp/bin-contagem/npm" << 'EOF'
#!/bin/sh
echo '{"error":{"code":"ENOLOCK","summary":"This command requires an existing lockfile."}}'
exit 1
EOF
chmod +x "$tmp/bin-contagem/gitleaks" "$tmp/bin-contagem/osv-scanner" "$tmp/bin-contagem/npm"
# GIT_CEILING_DIRECTORIES impede o git de achar um repositório acima da pasta temporária.
espera_saida 0 env GIT_CEILING_DIRECTORIES="$tmp" PATH="$tmp/bin-contagem:$utilitarios" bash "$verificar" "$sem_git"
contem "PULADO gitleaks (o projeto não é um repositório git, e o gitleaks detect lê o histórico do git)"
[ ! -e "$sem_git/gitleaks-rodou" ] || falhou "o gitleaks rodou fora de um repositório git"
contem "| osv-scanner | rodou | osv.json | 3 (CVSS HIGH 1, CVSS MEDIUM 1, CVSS sem nota 1) |"
contem "| npm audit | erro (ENOLOCK) | npm-audit.json | — |"
contem "ERRO npm audit (ENOLOCK; veja npm-audit.json)"
nao_contem "fora do .gitignore"

echo "caso: repositório git sem .security-standard/ no .gitignore (o resumo pede CONFERIR)"
# HOME e XDG_CONFIG_HOME de teste: um .gitignore global da máquina não esconde o caso.
sem_ignore="$tmp/projeto sem gitignore"
mkdir -p "$sem_ignore" "$tmp/casa"
env HOME="$tmp/casa" XDG_CONFIG_HOME="$tmp/casa" GIT_CONFIG_NOSYSTEM=1 git -C "$sem_ignore" init -q
espera_saida 0 env HOME="$tmp/casa" XDG_CONFIG_HOME="$tmp/casa" GIT_CONFIG_NOSYSTEM=1 PATH="$utilitarios" \
  bash "$verificar" "$sem_ignore"
contem "CONFERIR .security-standard/ fora do .gitignore"

echo "caso: Trivy, Checkov e Semgrep de mentira com a senha no trecho de código (o JSON fica sem o trecho)"
mkdir "$tmp/bin-codigo"
cat > "$tmp/bin-codigo/trivy" << 'EOF'
#!/bin/sh
echo "trivy $*" >> "$CHAMADAS"
while [ $# -gt 0 ]; do [ "$1" = -o ] && saida=$2; shift; done
printf '{"Results":[{"Target":"Dockerfile","Class":"config","Misconfigurations":[{"ID":"DS-0031","Severity":"HIGH","Message":"Possible exposure of secret env","CauseMetadata":{"StartLine":2,"EndLine":2,"Code":{"Lines":[{"Number":2,"Content":"ENV DB_PASSWORD=%s","Highlighted":"ENV DB_PASSWORD=%s"}]}}}]},{"Target":"config.txt","Class":"secret","Secrets":[{"RuleID":"generic-secret","Severity":"CRITICAL","StartLine":1,"EndLine":1,"Match":"TOKEN=%s","Code":{"Lines":[{"Number":1,"Content":"TOKEN=%s"}]}}]}]}' \
  "$SENHA_FALSA" "$SENHA_FALSA" "$SENHA_FALSA" "$SENHA_FALSA" > "$saida"
EOF
cat > "$tmp/bin-codigo/checkov" << 'EOF'
#!/bin/sh
echo "checkov $*" >> "$CHAMADAS"
printf '[{"check_type":"dockerfile","results":{"failed_checks":[{"check_id":"CKV_DOCKER_3","file_path":"/Dockerfile","severity":null,"code_block":[[2,"ENV DB_PASSWORD=%s"]],"fixed_definition":"ENV DB_PASSWORD=%s"}],"passed_checks":[{"check_id":"CKV_DOCKER_2","code_block":[[2,"ENV DB_PASSWORD=%s"]]}]},"summary":{"failed":1}}]' \
  "$SENHA_FALSA" "$SENHA_FALSA" "$SENHA_FALSA"
exit 1
EOF
cat > "$tmp/bin-codigo/semgrep" << 'EOF'
#!/bin/sh
echo "semgrep $*" >> "$CHAMADAS"
while [ $# -gt 0 ]; do [ "$1" = -o ] && saida=$2; shift; done
printf '{"results":[{"check_id":"regra.senha-no-codigo","path":"app.py","start":{"line":2},"end":{"line":2},"extra":{"severity":"ERROR","message":"senha %s no código","lines":"password = %s","metavars":{"$X":{"abstract_content":"%s"}},"metadata":{"cwe":["CWE-798"]}}}],"errors":[{"level":"warn","type":"Syntax","message":"erro perto de %s","path":"app.py"}]}' \
  "$SENHA_FALSA" "$SENHA_FALSA" "$SENHA_FALSA" "$SENHA_FALSA" > "$saida"
EOF
chmod +x "$tmp/bin-codigo/trivy" "$tmp/bin-codigo/checkov" "$tmp/bin-codigo/semgrep"
com_codigo="$tmp/projeto com codigo"
mkdir -p "$com_codigo/.security-standard"
: > "$tmp/chamadas.txt"
espera_saida 0 env CHAMADAS="$tmp/chamadas.txt" SENHA_FALSA="$senha" PATH="$tmp/bin-codigo:$utilitarios" \
  bash "$verificar" "$com_codigo"
ev="$com_codigo/.security-standard/evidencias/$hoje"
sem_texto "$senha"
grep -q DS-0031 "$ev/trivy.json" || falhou "o trivy.json perdeu o id da regra"
grep -q CKV_DOCKER_3 "$ev/checkov.json" || falhou "o checkov.json perdeu o id da verificação"
grep -q regra.senha-no-codigo "$ev/semgrep.json" || falhou "o semgrep.json perdeu o id da regra"
contem "| trivy | rodou | trivy.json | 2 (configuração HIGH 1, segredo CRITICAL 1) |"
contem "| checkov | rodou | checkov.json | 1 |"
contem "| semgrep | rodou | semgrep.json | 1 (ERROR 1) |"
grep -qx "checkov -d . -o json --compact --skip-download" "$tmp/chamadas.txt" ||
  falhou "o Checkov não rodou com --compact e --skip-download"
grep -q "^trivy fs --config /dev/null " "$tmp/chamadas.txt" || falhou "o Trivy não rodou com --config /dev/null"
# A pasta interna (rodadas anteriores e documentos do usuário) fica fora do Trivy e do Semgrep.
grep -q "^trivy fs .* --skip-dirs \.security-standard " "$tmp/chamadas.txt" ||
  falhou "o Trivy varre .security-standard/ (sem --skip-dirs)"
grep -q "^semgrep scan .* --exclude \.security-standard$" "$tmp/chamadas.txt" ||
  falhou "o Semgrep varre .security-standard/ fora do git (sem --exclude)"
# O --secret-config aponta para um caminho que não existe, na pasta nova da rodada.
grep -qF -- "--secret-config .security-standard/evidencias/$hoje/nenhum-trivy-secret.yaml " "$tmp/chamadas.txt" ||
  falhou "o Trivy não rodou com --secret-config na pasta da rodada"
[ ! -e "$ev/nenhum-trivy-secret.yaml" ] || falhou "o caminho do --secret-config existe"

echo "caso: JSON que o filtro não consegue limpar (aninhado fundo, surrogate solto, python3 quebrado): o arquivo é apagado"
mkdir "$tmp/bin-falha" "$tmp/bin-python-quebrado"
cat > "$tmp/bin-falha/trivy" << 'EOF'
#!/bin/sh
while [ $# -gt 0 ]; do [ "$1" = -o ] && saida=$2; shift; done
codigo='"CauseMetadata":{"Code":{"Lines":[{"Content":"ENV DB_PASSWORD=%s"}]}}'
if [ "$MODO_TRIVY" = fundo ]; then
  {
    printf "{\"Results\":[{\"Target\":\"Dockerfile\",\"Misconfigurations\":[{\"ID\":\"DS-0031\",\"Severity\":\"HIGH\",$codigo}]}],\"fundo\":" "$SENHA_FALSA"
    awk 'BEGIN { for (i = 0; i < 5000; i++) printf "["; for (i = 0; i < 5000; i++) printf "]" }'
    printf '}'
  } > "$saida"
elif [ "$MODO_TRIVY" = surrogate ]; then
  printf "{\"Results\":[{\"Target\":\"Dockerfile\",\"Misconfigurations\":[{\"ID\":\"DS-0031\",\"Severity\":\"HIGH\",\"Title\":\"x\\\\ud800\",$codigo}]}]}" \
    "$SENHA_FALSA" > "$saida"
else
  printf "{\"Results\":[{\"Target\":\"Dockerfile\",\"Misconfigurations\":[{\"ID\":\"DS-0031\",\"Severity\":\"HIGH\",$codigo}]}]}" \
    "$SENHA_FALSA" > "$saida"
fi
EOF
# Um python3 que sai sem imprimir nada: o shell só mantém o JSON com o "ok" do filtro.
cat > "$tmp/bin-python-quebrado/python3" << 'EOF'
#!/bin/sh
exit 1
EOF
chmod +x "$tmp/bin-falha/trivy" "$tmp/bin-python-quebrado/python3"
for modo in fundo surrogate quebrado; do
  falha="$tmp/projeto json $modo"
  mkdir -p "$falha/.security-standard"
  caminho="$tmp/bin-falha:$utilitarios"
  [ "$modo" != quebrado ] || caminho="$tmp/bin-falha:$tmp/bin-python-quebrado:$utilitarios"
  espera_saida 0 env MODO_TRIVY="$modo" SENHA_FALSA="$senha" PATH="$caminho" bash "$verificar" "$falha"
  ev="$falha/.security-standard/evidencias/$hoje"
  sem_texto "$senha"
  [ ! -e "$ev/trivy.json" ] || falhou "ficou o trivy.json que o Python não conseguiu limpar ($modo)"
  contem "APAGADO trivy.json (não deu para tirar os trechos de código"
  contem "| trivy | rodou | apagado | — |"
done

echo "caso: Checkov que não leu um arquivo (summary.parsing_errors): o resumo pede CONFERIR em vez de dar só o 0"
mkdir "$tmp/bin-leitura"
cat > "$tmp/bin-leitura/checkov" << 'EOF'
#!/bin/sh
printf '{"check_type":"terraform","results":{"failed_checks":[],"passed_checks":[],"parsing_errors":["/main.tf"]},"summary":{"passed":0,"failed":0,"skipped":0,"parsing_errors":1,"resource_count":0}}'
EOF
chmod +x "$tmp/bin-leitura/checkov"
latin1="$tmp/projeto latin1"
mkdir -p "$latin1/.security-standard"
printf 'resource "aws_s3_bucket" "b" {\n  bucket = "configura\347\343o"\n}\n' > "$latin1/main.tf"
espera_saida 0 env PATH="$tmp/bin-leitura:$utilitarios" bash "$verificar" "$latin1"
contem "| checkov | rodou | checkov.json | 0 (+ 1 não lido(s): CONFERIR) |"
contem "CONFERIR checkov (1 arquivo(s) que a ferramenta não conseguiu ler"
# O mesmo projeto, com o .tf em Latin-1, e as ferramentas instaladas.
espera_saida 0 env -u GH_TOKEN -u GITHUB_TOKEN GH_CONFIG_DIR="$tmp/gh" bash "$verificar" "$latin1"
if [ -f "$latin1/.security-standard/evidencias/$hoje-2/checkov.json" ]; then contem "CONFERIR checkov ("; fi

echo "caso: projeto com .checkov.yaml, trivy.yaml, trivy-secret.yaml e .npmrc (o Checkov não roda; o Trivy não lê os dois do projeto)"
com_conf="$tmp/projeto com configuracao"
mkdir -p "$com_conf/.security-standard" "$com_conf/verificacoes"
printf 'external-checks-dir:\n  - verificacoes\n' > "$com_conf/.checkov.yaml"
: > "$com_conf/verificacoes/__init__.py"
printf 'import pathlib\npathlib.Path("CODIGO-DO-REPOSITORIO-RODOU").touch()\n' > "$com_conf/verificacoes/marca.py"
printf 'server:\n  addr: http://127.0.0.1:9\n' > "$com_conf/trivy.yaml"
printf 'disable-rules:\n  - github-pat\n' > "$com_conf/trivy-secret.yaml"
token_fim=abcdefghij0123456789
printf 'TOKEN=ghp_%s%s\n' "$parte" "$token_fim" > "$com_conf/app.env"
printf 'registry=https://registro.exemplo.invalid/\n' > "$com_conf/.npmrc"
: > "$tmp/chamadas.txt"
espera_saida 0 env CHAMADAS="$tmp/chamadas.txt" SENHA_FALSA="$senha" PATH="$tmp/bin-codigo:$utilitarios" \
  bash "$verificar" "$com_conf"
contem "| checkov | pulado | — | — |"
contem "CONFERIR checkov (o projeto tem .checkov.yaml ou .checkov.yml"
contem "CONFERIR trivy.yaml, trivy-secret.yaml, .npmrc ("
if grep -q '^checkov ' "$tmp/chamadas.txt"; then falhou "o Checkov rodou com o .checkov.yaml do projeto"; fi
grep -q "^trivy fs --config /dev/null --secret-config " "$tmp/chamadas.txt" ||
  falhou "o Trivy não rodou com --config /dev/null e --secret-config"
# O mesmo projeto com as ferramentas instaladas: o Checkov de verdade executaria verificacoes/marca.py, e o Trivy
# de verdade, com o trivy-secret.yaml do projeto, não acharia o token.
espera_saida 0 env -u GH_TOKEN -u GITHUB_TOKEN GH_CONFIG_DIR="$tmp/gh" bash "$verificar" "$com_conf"
[ ! -e "$com_conf/CODIGO-DO-REPOSITORIO-RODOU" ] || falhou "o Checkov executou código do repositório"
if [ -f "$com_conf/.security-standard/evidencias/$hoje-2/trivy.json" ]; then
  grep -q github-pat "$com_conf/.security-standard/evidencias/$hoje-2/trivy.json" ||
    falhou "o trivy-secret.yaml do projeto silenciou o Trivy"
fi

echo "caso: rodada antiga com um token na pasta interna, num projeto fora do git (o Trivy e o Semgrep não a leem)"
# Com as ferramentas instaladas, sem a exclusão, o token da rodada antiga viraria achado do projeto. Sem elas (como
# no CI), o caso das ferramentas de mentira confere os argumentos.
antiga="$tmp/projeto com rodada antiga"
mkdir -p "$antiga/.security-standard/evidencias/2000-01-01"
printf 'TOKEN=ghp_%s%s\n' "$parte" "$token_fim" > "$antiga/.security-standard/evidencias/2000-01-01/documento.txt"
cp "$antiga/.security-standard/evidencias/2000-01-01/documento.txt" "$tmp/documento-antigo.txt"
espera_saida 0 env -u GH_TOKEN -u GITHUB_TOKEN GIT_CEILING_DIRECTORIES="$tmp" GH_CONFIG_DIR="$tmp/gh" \
  bash "$verificar" "$antiga"
for arquivo in trivy.json semgrep.json; do
  if [ -f "$antiga/.security-standard/evidencias/$hoje/$arquivo" ] &&
    grep -q 'security-standard' "$antiga/.security-standard/evidencias/$hoje/$arquivo"; then
    falhou "o $arquivo traz achado da pasta interna: $(grep -o '[^"]*security-standard[^"]*' "$antiga/.security-standard/evidencias/$hoje/$arquivo" | head -n 1)"
  fi
done
cmp -s "$tmp/documento-antigo.txt" "$antiga/.security-standard/evidencias/2000-01-01/documento.txt" ||
  falhou "a rodada mexeu na rodada antiga"

echo "caso: quatro rodadas ao mesmo tempo no mesmo projeto (cada uma na sua pasta)"
juntas="$tmp/projeto simultaneo"
mkdir -p "$juntas/.security-standard"
set --
for i in 1 2 3 4; do
  env PATH="$utilitarios" bash "$verificar" "$juntas" > "$tmp/juntas-$i.saida" 2>&1 &
  set -- "$@" "$!"
done
for pid in "$@"; do wait "$pid" || falhou "uma das rodadas simultâneas saiu com erro"; done
pastas=$(find "$juntas/.security-standard/evidencias" -mindepth 1 -maxdepth 1 ! -name '.*' | wc -l | tr -d ' ')
[ "$pastas" -eq 4 ] || falhou "quatro rodadas simultâneas gravaram em $pastas pasta(s)"
for pasta in "$juntas"/.security-standard/evidencias/*/; do
  [ -f "${pasta}resumo.md" ] || falhou "sem resumo.md em $pasta"
done

echo "caso: rodada interrompida (TERM) enquanto uma ferramenta imprime uma chave (nada fica sem a varredura)"
lento="$tmp/projeto lento"
mkdir -p "$lento/.security-standard" "$tmp/bin-lenta"
cat > "$tmp/bin-lenta/semgrep" << 'EOF'
#!/bin/sh
echo "AWS_KEY=$CHAVE_FALSA"
echo $$ > "$PID_LENTA"
exec sleep 30
EOF
chmod +x "$tmp/bin-lenta/semgrep"
env CHAVE_FALSA="$chave2" PID_LENTA="$tmp/lenta.pid" PATH="$tmp/bin-lenta:$utilitarios" \
  bash "$verificar" "$lento" > "$tmp/lento.saida" 2>&1 &
script=$!
espera=0
until [ -s "$tmp/lenta.pid" ]; do
  espera=$((espera + 1))
  [ "$espera" -le 300 ] || falhou "a ferramenta lenta não começou"
  sleep 0.1
done
kill -TERM "$(cat "$tmp/lenta.pid")" "$script" 2> /dev/null || true
codigo=0
wait "$script" || codigo=$?
cat "$tmp/lento.saida"
[ "$codigo" -eq 143 ] || falhou "a rodada interrompida saiu com $codigo (esperado: 143)"
ev="$lento/.security-standard/evidencias/$hoje"
for resto in "$ev"/*.parcial; do [ ! -e "$resto" ] || falhou "sobrou $resto"; done
[ ! -e "$ev/semgrep.json" ] || falhou "sobrou o semgrep.json da ferramenta interrompida"
sem_segredo
resumo_tem "INTERROMPIDO semgrep"

echo "TESTE OK"
