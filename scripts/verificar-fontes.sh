#!/usr/bin/env bash
# Confere que toda URL das fontes das skills responde com 2xx ou 3xx.
# URL listada em scripts/fontes-ignorar.txt (URL<TAB>justificativa) é pulada com aviso.
# Imprime OK ou FALHA <código> <url>; sai com 1 se houver falha.
set -eu
cd "$(dirname "$0")/.."
shopt -s nullglob

set -- skills/*/references/fontes*.md skills/*/references/controles-*.md
urls=""
[ $# -eq 0 ] || urls=$(grep -E -o -h "https?://[^] )>\"'|]+" "$@" | sort -u)
if [ -z "$urls" ]; then
  echo "nenhuma URL"
  exit 0
fi

falha=0
while IFS= read -r url; do
  if justificativa=$(awk -F '\t' -v u="$url" '$1 == u { print $2; achou = 1; exit } END { exit !achou }' scripts/fontes-ignorar.txt); then
    echo "AVISO pulada $url: $justificativa"
    continue
  fi
  codigo=$(curl -sS -o /dev/null -L --max-time 20 -w '%{http_code}' "$url" || true)
  case $codigo in
    2??|3??) echo "OK $codigo $url" ;;
    *) echo "FALHA $codigo $url"; falha=1 ;;
  esac
done <<< "$urls"

exit "$falha"
