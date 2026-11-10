# Avaliações (evals)

Um caso por skill, no formato do `claude plugin eval`, com o pedido e os graders em arquivos:

```text
evals/<skill>/prompt.md      # o pedido, com max_turns e allowed_tools no frontmatter
evals/<skill>/graders/*.md   # um grader por arquivo
```

Graders só dos tipos `tool_used` (por exemplo, `tool_used: Skill`, a skill foi carregada) e `regex` (presença do que é certo; com `match: not_contains`, ausência do que é errado). Nada de grader `llm`.

Os casos ficam escritos, com a sintaxe dos graders conferida por `bash scripts/testes/graders.test.sh` (também no CI), mas não são executados neste repositório, porque cada execução é paga. Quem instalar o plugin pode rodá-los por conta própria:

```bash
claude plugin eval .
```

Cada caso é uma execução completa do Claude na sua conta, 3 vezes por padrão (`--runs` muda), e o modo padrão roda cada caso também sem o plugin, para comparar (`--ablation none` desliga). `--max-cost-usd <valor>` põe um teto no custo. Os resultados vão para `evals/results/`, que o git ignora; `--no-publish` mantém o relatório só na sua máquina.

## Limitação

- `security-customer-evidence`: o caso não traz fixture. Sem `.security-standard/lacunas.md`, o agente não tem estado avaliado, e o eval cobre só esse caso, o pedido sem estado. Ele não exercita a skill tirando do dossiê os controles ausentes ou parciais de um estado real.
