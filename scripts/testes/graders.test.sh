#!/usr/bin/env bash
# Testa a sintaxe dos graders dos evals (evals/*/graders/*.md) pelo esquema do claude plugin eval: type só regex
# ou tool_used; regex com pattern, compilado com as flags no RegExp do JavaScript (o motor do eval), e match
# contains, not_contains ou count:N; tool_used com tool e input_match que compila. Graders quebrados de exemplo
# têm de ser reprovados. Uso: bash scripts/testes/graders.test.sh (de qualquer diretório). Última linha: TESTE OK.
set -eu

testes=$(cd "$(dirname "$0")" && pwd)
repositorio=$(dirname "$(dirname "$testes")")
tmp=$(mktemp -d "${TMPDIR:-/tmp}/graders.XXXXXX")
trap 'rm -rf "$tmp"' EXIT

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
# contem <texto>: confere a saída do último espera_saida.
contem() { case $saida in *"$1"*) ;; *) falhou "a saída não tem: $1" ;; esac; }

# conferir <grader.md>...: imprime ERRO <arquivo>: <motivo> e sai com 1, ou <n> graders válidos e sai com 0.
conferir() {
  node - "$@" << 'EOF'
const fs = require("fs");

// O valor de uma linha do frontmatter como o YAML o lê: entre aspas simples ('' vale uma aspa) ou texto simples
// até o primeiro " #". Para as outras formas (aspas duplas, bloco, lista, mapa), null.
function lerValor(bruto) {
  const simples = /^'((?:[^']|'')*)'(?:\s+#.*)?$/.exec(bruto);
  if (simples) return simples[1].replace(/''/g, "'");
  if (/^["'[\]{}|>&*!%@`]/.test(bruto)) return null;
  return bruto.replace(/\s+#.*$/, "");
}

const erros = [];
let validos = 0;
for (const arquivo of process.argv.slice(2)) {
  const antes = erros.length;
  const erro = (motivo) => erros.push(`ERRO ${arquivo}: ${motivo}`);
  const linhas = fs.readFileSync(arquivo, "utf8").split(/\r?\n/);
  const fim = linhas.indexOf("---", 1);
  if (linhas[0] !== "---" || fim < 0) {
    erro("frontmatter sem os delimitadores ---");
    continue;
  }
  const campos = {};
  for (const linha of linhas.slice(1, fim)) {
    if (!linha.trim() || linha.trimStart().startsWith("#")) continue;
    const achado = /^([a-z_]+):(?:[ \t]+(.*))?$/.exec(linha);
    const valor = achado ? lerValor((achado[2] || "").trim()) : null;
    if (valor === null) erro(`linha que o teste não lê (chave: valor, com texto simples ou aspas simples): ${linha}`);
    else if (achado[1] in campos) erro(`chave repetida: ${achado[1]}`);
    else campos[achado[1]] = valor;
  }
  const compila = (chave, flags) => {
    try {
      new RegExp(campos[chave], flags);
    } catch (e) {
      erro(`${chave} não compila no RegExp do JavaScript: ${e.message}`);
    }
  };
  if (!["regex", "tool_used"].includes(campos.type)) erro(`type "${campos.type ?? ""}" fora do conjunto (regex, tool_used)`);
  if (campos.type === "regex" && !campos.pattern) erro("grader regex sem pattern");
  if (campos.type === "tool_used" && !campos.tool) erro("grader tool_used sem tool");
  if ("pattern" in campos) compila("pattern", campos.flags ?? "");
  if ("input_match" in campos) compila("input_match", "");
  if ("match" in campos && !/^(contains|not_contains|count:\d+)$/.test(campos.match)) {
    erro(`match "${campos.match}" fora do conjunto (contains, not_contains, count:N)`);
  }
  if (erros.length === antes) validos++;
}
console.log(erros.length ? erros.join("\n") : `${validos} graders válidos`);
process.exit(erros.length ? 1 : 0);
EOF
}

# Os graders do repositório passam.
shopt -s nullglob
set -- "$repositorio"/evals/*/graders/*.md
[ $# -gt 0 ] || falhou "nenhum grader em evals/*/graders/"
espera_saida 0 conferir "$@"
contem "$# graders válidos"

# Graders quebrados: tipo que não existe, padrão que não compila e match fora do conjunto; padrão sem aspas que o
# YAML lê como lista; tool_used sem tool e com input_match que não compila.
printf '%s\n' '---' 'type: regexx' "pattern: '['" 'match: talvez' '---' > "$tmp/quebrado.md"
printf '%s\n' '---' 'type: regex' 'pattern: [A-Z]{3}-\d{2}' '---' > "$tmp/sem-aspas.md"
printf '%s\n' '---' 'type: tool_used' "input_match: '(skill'" '---' > "$tmp/ferramenta.md"
espera_saida 1 conferir "$tmp/quebrado.md" "$tmp/sem-aspas.md" "$tmp/ferramenta.md"
contem 'quebrado.md: type "regexx" fora do conjunto'
contem "quebrado.md: pattern não compila"
contem 'quebrado.md: match "talvez" fora do conjunto'
contem "sem-aspas.md: linha que o teste não lê"
contem "sem-aspas.md: grader regex sem pattern"
contem "ferramenta.md: grader tool_used sem tool"
contem "ferramenta.md: input_match não compila"

echo "TESTE OK"
