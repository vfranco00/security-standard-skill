#!/usr/bin/env bash
# Confere cada skills/*/SKILL.md e procura os termos proibidos no repositório inteiro
# (menos .git/, scripts/termos-proibidos.txt e evals/results/).
# Imprime OK <skill> ou ERRO <skill>: <motivo>; sai com 1 se houver erro.
set -eu
cd "$(dirname "$0")/.."
shopt -s nullglob

erro=0
falhou() { echo "ERRO $1: $2"; erro=1; ok=0; }

# valor <campo> <frontmatter>: o valor de uma linha do campo, sem aspas.
valor() {
  printf '%s\n' "$2" | sed -n "s/^$1:[[:space:]]*//p" | head -n 1 |
    sed -e 's/[[:space:]]*$//' -e 's/^"\(.*\)"$/\1/' -e "s/^'\(.*\)'\$/\1/"
}

set -- skills/*/SKILL.md
[ $# -gt 0 ] || echo "nenhuma skill"

for arquivo in "$@"; do
  skill=$(basename "$(dirname "$arquivo")")
  ok=1
  fim=$(awk 'NR > 1 && $0 == "---" { print NR; exit }' "$arquivo")
  if [ "$(head -n 1 "$arquivo")" != "---" ] || [ -z "$fim" ]; then
    falhou "$skill" "frontmatter sem os delimitadores ---"
    continue
  fi
  frontmatter=$(sed -n "2,$((fim - 1))p" "$arquivo")

  nome=$(valor name "$frontmatter")
  [ "$nome" = "$skill" ] || falhou "$skill" "name \"$nome\" difere do nome da pasta"
  if ! printf '%s' "$nome" | grep -Eq '^[a-z0-9]+(-[a-z0-9]+)*$' || [ ${#nome} -gt 64 ]; then
    falhou "$skill" "name \"$nome\" fora do padrão (minúsculas, dígitos e hífens; de 1 a 64 caracteres)"
  fi

  descricao=$(valor description "$frontmatter")
  if printf '%s\n' "$frontmatter" | grep -Eq '^description:[[:space:]]*[>|]'; then
    falhou "$skill" "description em bloco YAML (> ou |); a regra é uma linha só"
  fi
  caracteres=$(printf '%s' "$descricao" | LC_ALL=C.UTF-8 wc -m | tr -d ' ')
  { [ "$caracteres" -ge 1 ] && [ "$caracteres" -le 1024 ]; } ||
    falhou "$skill" "description com $caracteres caracteres (aceito: de 1 a 1024)"

  linhas=$(awk 'END { print NR }' "$arquivo")
  [ "$linhas" -lt 500 ] || falhou "$skill" "SKILL.md com $linhas linhas (aceito: menos de 500)"

  if [ "$ok" -eq 1 ]; then echo "OK $skill"; fi
done

# Termos: a lista pública do repositório e, se TERMOS_PRIVADOS apontar para um arquivo
# legível, a lista privada, que fica fora do repositório. Linhas vazias e linhas que começam com # não contam.
listas=(scripts/termos-proibidos.txt)
if [ -n "${TERMOS_PRIVADOS:-}" ]; then
  if [ -f "$TERMOS_PRIVADOS" ] && [ -r "$TERMOS_PRIVADOS" ]; then
    listas+=("$TERMOS_PRIVADOS")
    echo "termos privados: conferidos ($(grep -c -v -e '^#' -e '^[[:space:]]*$' "$TERMOS_PRIVADOS"))"
  else
    falhou "termos privados" "TERMOS_PRIVADOS ($TERMOS_PRIVADOS) não é um arquivo legível"
  fi
fi

status=0
termos=$(grep -h -v -e '^#' -e '^[[:space:]]*$' "${listas[@]}") || status=$?
[ "$status" -le 1 ] || falhou neutralidade "não consegui ler a lista de termos"

# Onde procurar: o repositório inteiro, menos .git/, a própria lista pública e evals/results/.
arquivos=()
while IFS= read -r -d '' caminho; do arquivos+=("$caminho"); done < <(
  find . -path ./.git -prune -o -path ./scripts/termos-proibidos.txt -prune \
    -o -path ./evals/results -prune -o -type f -print0)

# Duas passadas sobre os mesmos arquivos: no locale do ambiente (o -i dobra a caixa dos acentos)
# e com LC_ALL=C (casa bytes e acha o termo em linha com UTF-8 inválido; o -i só dobra ASCII).
# Em cada uma, status 2 (não leu) e status 0 sem nada impresso (achou e não mostrou) são erro.
achados=""
if [ -n "$termos" ] && [ ${#arquivos[@]} -gt 0 ]; then
  for lc in "" C; do
    status=0
    saida=$(env ${lc:+"LC_ALL=$lc"} grep -a -H -i -F -n -o -f /dev/stdin "${arquivos[@]}" <<< "$termos") || status=$?
    if [ "$status" -gt 1 ]; then
      falhou neutralidade "o grep${lc:+ com LC_ALL=$lc} não conseguiu ler todos os arquivos"
    elif [ "$status" -eq 0 ] && [ -z "$saida" ]; then
      falhou neutralidade "o grep${lc:+ com LC_ALL=$lc} achou um termo proibido e não mostrou onde"
    fi
    achados="$achados$saida"$'\n'
  done
fi
achados=$(printf '%s' "$achados" | awk 'NF && !visto[$0]++')
if [ -n "$achados" ]; then
  printf '%s\n' "$achados" | sed -E 's|^\./||; s/^([^:]*:[0-9]+):(.*)$/ERRO \1: termo proibido "\2"/'
  erro=1
fi

exit "$erro"
