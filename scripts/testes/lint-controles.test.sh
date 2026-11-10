#!/usr/bin/env bash
# Testa o lint-controles.py e o gerar-catalogo.py com a fixture controles-exemplo.md.
# Uso: bash scripts/testes/lint-controles.test.sh (de qualquer diretório). Última linha: TESTE OK.
set -eu

testes=$(cd "$(dirname "$0")" && pwd)
scripts=$(dirname "$testes")
fixture="$testes/controles-exemplo.md"
tmp=$(mktemp -d "${TMPDIR:-/tmp}/lint-controles.XXXXXX")
trap 'rm -rf "$tmp"' EXIT
validos="$tmp/validos.md"

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
# lint <código> <arquivo>: roda o linter num arquivo.
lint() { espera_saida "$1" python3 "$scripts/lint-controles.py" "$2"; }
# variante <nome> <expressões do sed...>: a fixture válida com uma mudança, em $tmp/<nome>.md.
variante() {
  nome=$1
  shift
  sed "$@" "$validos" > "$tmp/$nome.md"
}

# A fixture inteira: o IAM-03 não tem Fontes e tem nível Alto.
lint 1 "$fixture"
contem "ERRO IAM-03: falta o campo Fontes"
contem 'ERRO IAM-03: nível mínimo "Alto"'
nao_contem "ERRO IAM-01"
nao_contem "ERRO IAM-02"

# Sem o IAM-03, os dois blocos passam.
sed '/^### IAM-03/,$d' "$fixture" > "$validos"
lint 0 "$validos"
contem "2 controles válidos"

# Uma regra por caso: cada mudança sozinha faz o linter sair com 1.
variante ordem -e '/^- \*\*Parâmetro:\*\*/{h;d;}' -e '/^- \*\*Por quê:\*\*/G'
lint 1 "$tmp/ordem.md"
contem "ERRO IAM-01: campos fora da ordem"

variante sem-campo -e '/^- \*\*Evidência:\*\*/d'
lint 1 "$tmp/sem-campo.md"
contem "ERRO IAM-01: falta o campo Evidência"

variante solta -e '/^- \*\*Mapa:\*\*/a\
Linha solta dentro do bloco.'
lint 1 "$tmp/solta.md"
contem "ERRO IAM-01: linha fora de um campo"

variante id -e 's/^### IAM-02/### IAM-2/'
lint 1 "$tmp/id.md"
contem "ERRO IAM-2: id fora do padrão"

variante sequencia -e 's/^### IAM-02/### IAM-04/'
lint 1 "$tmp/sequencia.md"
contem "ERRO IAM-04: fora da sequência da família IAM (esperado: IAM-02)"

variante repetido -e 's/^### IAM-02/### IAM-01/'
lint 1 "$tmp/repetido.md"
contem "ERRO IAM-01: id repetido"

variante perfis -e 's/^- \*\*Perfis:\*\* todos$/- **Perfis:** bancos/'
lint 1 "$tmp/perfis.md"
contem 'ERRO IAM-01: perfis "bancos"'

variante tipo -e 's/^  - primária — PCI/  - oficial — PCI/'
lint 1 "$tmp/tipo.md"
contem 'ERRO IAM-01: fonte 1: tipo "oficial"'

variante url -e 's|— https://learn.microsoft.com|— learn.microsoft.com|'
lint 1 "$tmp/url.md"
contem "ERRO IAM-01: fonte 2: URL"

variante data -e 's|conferida em 2026-11-09|conferida em 09/11/2026|'
lint 1 "$tmp/data.md"
contem "ERRO IAM-01: fonte 1: data"

# Sem fonte primária, o Parâmetro tem de terminar com (proposta): o IAM-02 termina, o IAM-01 não.
variante sem-primaria -e 's/^  - primária —/  - secundária —/'
lint 1 "$tmp/sem-primaria.md"
contem "ERRO IAM-01: sem fonte primária"
nao_contem "ERRO IAM-02"

variante mapa -e 's/; ASVS: —$//'
lint 1 "$tmp/mapa.md"
contem "ERRO IAM-01: Mapa fora do formato"

printf '# Só o título\n' > "$tmp/sem-blocos.md"
lint 1 "$tmp/sem-blocos.md"
contem "nenhum bloco de controle"

lint 1 "$tmp/nao-existe.md"
contem "arquivo não encontrado"

# Cabeçalho de controle que não começa com "### " é erro, em vez de sumir com os campos.
# O caso que sumia sem erro: um bloco completo com "## " no fim do arquivo.
{ cat "$validos"; sed -n '/^### IAM-02/,$p' "$validos" | sed 's/^### IAM-02/## IAM-03/'; } > "$tmp/bloco-nivel-2.md"
lint 1 "$tmp/bloco-nivel-2.md"
contem "ERRO IAM-03: cabeçalho fora do formato"
for prefixo in '## ' '#### ' '###' $'###\t' $'###\xc2\xa0'; do
  echo "caso: cabeçalho com o prefixo $(printf %q "$prefixo")"
  sed "s/^### IAM-02/${prefixo}IAM-02/" "$validos" > "$tmp/cabecalho.md"
  lint 1 "$tmp/cabecalho.md"
  contem "ERRO IAM-02: cabeçalho fora do formato"
done
# De 1 a 3 espaços antes do ### ainda fazem um título no Markdown. O caso que sumia sem erro: o bloco
# depois de uma seção ##, sem bloco aberto para levar a linha como continuação de campo.
for recuo in ' ' '  ' '   '; do
  echo "caso: cabeçalho com ${#recuo} espaço(s) antes do ###"
  { cat "$validos"; printf '## Anexo\n'; sed -n '/^### IAM-02/,$p' "$validos" | sed "s/^### IAM-02/${recuo}### IAM-03/"; } > "$tmp/recuo.md"
  lint 1 "$tmp/recuo.md"
  contem "ERRO IAM-03: cabeçalho fora do formato"
done

variante titulo -e 's/^### IAM-02 — /### IAM-02 - /'
lint 1 "$tmp/titulo.md"
contem "ERRO IAM-02: cabeçalho fora do formato"

variante desconhecido -e '/^- \*\*Mapa:\*\*/a\
- **Notas:** campo que o formato não tem.'
lint 1 "$tmp/desconhecido.md"
contem "ERRO IAM-01: campo desconhecido: Notas"

variante campo-repetido -e '/^- \*\*Enunciado:\*\*/p'
lint 1 "$tmp/campo-repetido.md"
contem "ERRO IAM-01: campo repetido: Enunciado"

variante vazio -e 's/^- \*\*Por quê:\*\* .*/- **Por quê:**/'
lint 1 "$tmp/vazio.md"
contem "ERRO IAM-01: campo Por quê vazio"

variante perfis-repetidos -e 's/^- \*\*Perfis:\*\* financeiro, seguros$/- **Perfis:** financeiro, financeiro/'
lint 1 "$tmp/perfis-repetidos.md"
contem 'ERRO IAM-02: perfis "financeiro, financeiro"'

variante sem-fonte -e '/^  - primária — Res\. CMN/d'
lint 1 "$tmp/sem-fonte.md"
contem "ERRO IAM-02: Fontes sem nenhuma fonte"

variante tres-partes -e 's/ — conferida em 2026-11-09$//'
lint 1 "$tmp/tres-partes.md"
contem "ERRO IAM-01: fonte 1 fora do formato"

variante sem-titulo -e 's/— PCI DSS v4.0, tradução oficial em português, requisito 8.4 — /—  — /'
lint 1 "$tmp/sem-titulo.md"
contem "ERRO IAM-01: fonte 1: sem título"

variante data-inexistente -e 's/conferida em 2026-11-09/conferida em 2026-02-30/'
lint 1 "$tmp/data-inexistente.md"
contem 'ERRO IAM-01: fonte 1: data "2026-02-30" não existe'

# Entrada: arquivo fora de UTF-8, texto em NFD, arquivo com BOM, pasta no lugar de arquivo e família fora das seis.
printf 'texto em latin-1: \351\n' > "$tmp/latin1.md"
lint 1 "$tmp/latin1.md"
contem "não é UTF-8"
nao_contem "Traceback"

python3 -c 'import sys, unicodedata; sys.stdout.buffer.write(unicodedata.normalize("NFD", open(sys.argv[1], encoding="utf-8").read()).encode("utf-8"))' \
  "$validos" > "$tmp/nfd.md"
! cmp -s "$validos" "$tmp/nfd.md" || falhou "a cópia em NFD saiu igual à fixture"
lint 0 "$tmp/nfd.md"
contem "2 controles válidos"

# Com o BOM do UTF-8 antes do primeiro bloco, o bloco não se perde.
{ printf '\357\273\277'; sed -n '/^### IAM-01/,$p' "$validos"; } > "$tmp/bom.md"
lint 0 "$tmp/bom.md"
contem "2 controles válidos"

lint 1 "$tmp"
contem "é uma pasta"

variante familia -e 's/^### IAM-/### ZZZ-/'
lint 1 "$tmp/familia.md"
contem "ERRO ZZZ-01: família ZZZ fora das seis (IAM, DAT, DEV, OPS, IRC, GOV)"

# Nenhuma função do linter reatribui um parâmetro dela (o ler() trocava o texto que recebe por uma linha).
espera_saida 0 python3 - "$scripts/lint-controles.py" << 'EOF'
import ast
import sys

with open(sys.argv[1], encoding="utf-8") as arquivo:
    arvore = ast.parse(arquivo.read())
for funcao in ast.walk(arvore):
    if isinstance(funcao, ast.FunctionDef):
        argumentos = funcao.args
        parametros = {a.arg for a in argumentos.posonlyargs + argumentos.args + argumentos.kwonlyargs}
        for no in ast.walk(funcao):
            if isinstance(no, ast.Name) and isinstance(no.ctx, ast.Store) and no.id in parametros:
                print(f"{funcao.name}() reatribui o parâmetro {no.id} (linha {no.lineno})")
                sys.exit(1)
EOF

# O gerador lê skills/*/references/controles-*.md da raiz em que está: roda numa cópia com a fixture válida.
raiz="$tmp/raiz"
mkdir -p "$raiz/scripts" "$raiz/skills/exemplo/references"
cp "$scripts/lint-controles.py" "$scripts/gerar-catalogo.py" "$raiz/scripts/"
cp "$validos" "$raiz/skills/exemplo/references/controles-iam.md"
espera_saida 0 python3 "$raiz/scripts/gerar-catalogo.py"
cp "$raiz/docs/catalogo-de-controles.md" "$tmp/catalogo-antes.md"
cp "$raiz/docs/mapa-de-frameworks.md" "$tmp/mapa-antes.md"
espera_saida 0 python3 "$raiz/scripts/gerar-catalogo.py"
cmp -s "$tmp/catalogo-antes.md" "$raiz/docs/catalogo-de-controles.md" || falhou "o catálogo mudou de uma execução para a outra"
cmp -s "$tmp/mapa-antes.md" "$raiz/docs/mapa-de-frameworks.md" || falhou "o mapa mudou de uma execução para a outra"
grep -qF '| IAM | 1 | 1 | 0 | 2 |' "$raiz/docs/catalogo-de-controles.md" || falhou "o catálogo não tem a contagem por nível do IAM"
grep -qF '| IAM-02 | Revisão dos acessos de terceiros | Fornecedor | financeiro, seguros | a cada 90 dias (proposta) | exemplo |' \
  "$raiz/docs/catalogo-de-controles.md" || falhou "o catálogo não tem a linha do IAM-02"
grep -qF '| IAM-01 | — | Access Control | — | — | PR.AA-03 | — | — |' \
  "$raiz/docs/mapa-de-frameworks.md" || falhou "o mapa não tem a linha do IAM-01"
[ ! -e "$raiz/scripts/__pycache__" ] || falhou "o gerador deixou scripts/__pycache__"

# Título sem id, com 1 a 3 espaços antes, também fecha o bloco: o texto recuado depois dele não entra no Mapa.
printf '  ## Anexo\n  Texto do anexo, recuado.\n' >> "$raiz/skills/exemplo/references/controles-iam.md"
espera_saida 0 python3 "$raiz/scripts/gerar-catalogo.py"
grep -qF '| IAM-02 | — | Access Control | — | — | PR.AA-05 | — | — |' \
  "$raiz/docs/mapa-de-frameworks.md" || falhou "o texto depois do título recuado entrou no Mapa do IAM-02"

# Com um bloco inválido, o gerador mostra o erro e não escreve nada.
rm -r "$raiz/docs"
cp "$fixture" "$raiz/skills/exemplo/references/controles-iam.md"
espera_saida 1 python3 "$raiz/scripts/gerar-catalogo.py"
contem "ERRO IAM-03"
[ ! -e "$raiz/docs" ] || falhou "o gerador escreveu docs/ com erro nos blocos"

echo "TESTE OK"
