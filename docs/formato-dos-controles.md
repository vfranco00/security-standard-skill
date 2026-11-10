# Formato dos controles

Cada controle do catálogo é um bloco de Markdown em `skills/<skill>/references/controles-<familia>.md`, dentro da skill dona da família. O bloco é a fonte de verdade do controle. A partir dos blocos, `scripts/lint-controles.py` confere o formato e `scripts/gerar-catalogo.py` gera `docs/catalogo-de-controles.md` e `docs/mapa-de-frameworks.md`.

## O bloco

Os campos vêm nesta ordem exata:

```
### IAM-01 — Título curto
- **Enunciado:** uma frase imperativa.
- **Nível mínimo:** Essencial | Fornecedor | Big tech
- **Perfis:** todos | financeiro, seguros, setor-publico, cartoes, saude (lista separada por vírgula)
- **Parâmetro:** valor único; ou `Essencial: ...; Fornecedor: ...; Big tech: ...`; termina com `(proposta)` quando não há fonte primária para o número
- **Por quê:** até 3 frases.
- **Fontes:**
  - primária | secundária | proposta — Título — URL — conferida em 2026-11-09
- **Como verificar:** pergunta, comando ou arquivo a ler.
- **Como implementar:** passos curtos ou referência a um `assets/*.md`.
- **Evidência:** o que guardar e onde.
- **Mapa:** CAIQ: ...; SIG: ...; ISO: A.x.y; SOC2: CCx.y; CSF: XX.YY-nn; CIS: n.n; ASVS: Vn.n (qualquer um pode ser `—`)
```

Dois blocos completos e válidos estão em `scripts/testes/controles-exemplo.md` (o IAM-03 de lá é o caso inválido do teste). A fixture vale como exemplo de formato, não de conteúdo: não copie dela fontes, parâmetros nem ids do Mapa.

## Os campos

| Campo | O que vai nele | O que o linter confere |
|---|---|---|
| Cabeçalho | `### `, o id, ` — ` e um título curto. O id é a família (três letras) e o número do controle na família. | Começa com `### ` (três `#` e um espaço comum). Id no padrão `^[A-Z]{3}-\d{2}$`, de uma das seis famílias (IAM, DAT, DEV, OPS, IRC, GOV), único no catálogo e em sequência na família (01, 02, 03, sem buraco), seguido de ` — ` e do título. |
| Enunciado | Uma frase imperativa: o que fazer, sem justificativa. | Não está vazio. |
| Nível mínimo | O primeiro nível em que o controle é exigido. Os níveis são cumulativos: Essencial ⊂ Fornecedor ⊂ Big tech. | Um de `Essencial`, `Fornecedor`, `Big tech`. |
| Perfis | `todos` quando vale para qualquer projeto; senão, os perfis do cliente ou do dado que ligam o controle. | `todos`, ou uma lista, separada por vírgula e sem repetição, de `financeiro`, `seguros`, `setor-publico`, `cartoes`, `saude`. |
| Parâmetro | O número ou o critério que torna o controle verificável: prazo, período, versão, percentual. Quando varia com o nível, `Essencial: ...; Fornecedor: ...; Big tech: ...`. | Termina com `(proposta)` quando nenhuma fonte do bloco é `primária`. |
| Por quê | O risco que o controle reduz, em até três frases. | Não está vazio. |
| Fontes | Uma fonte por linha recuada (veja a regra das fontes abaixo). | Ao menos uma; cada uma com tipo válido, título, URL que começa com `http://` ou `https://` e `conferida em AAAA-MM-DD` (data que existe). |
| Como verificar | A pergunta a fazer, o comando a rodar ou o arquivo a ler para saber se o controle está atendido. | Não está vazio. |
| Como implementar | Passos curtos, ou o modelo em `assets/` que resolve. | Não está vazio. |
| Evidência | O que guardar para provar o controle e onde (por exemplo, em `.security-standard/evidencias/`). | Não está vazio. |
| Mapa | Os identificadores do controle correspondente em cada framework, nesta ordem: CAIQ, SIG, ISO, SOC2, CSF, CIS, ASVS. | As sete chaves, nesta ordem, separadas por `;`, cada uma com valor; `—` quando não há correspondente. |

## A regra das fontes

- **Tipos.** `primária` é o documento do próprio emissor: a lei ou a norma (Planalto, BCB, SUSEP, GSI/PR, ANPD), o texto ou a página oficial do framework (NIST, OWASP, CIS, CSA, AICPA, ISO, PCI SSC, Shared Assessments, OpenSSF), a documentação oficial de uma big tech ou o documento que uma grande empresa publica para os fornecedores dela. `secundária` é análise, artigo ou reprodução de texto oficial feita por terceiro. `proposta` é o parâmetro que a skill propõe: o título traz a justificativa e a URL aponta para o documento em que a proposta se apoia (por exemplo, a norma que pede a prática sem fixar o número, ou a fonte secundária de onde veio o número).
- **Exigência só com fonte primária.** Fonte secundária sozinha não sustenta exigência. Quando nenhuma fonte do bloco é primária, o Parâmetro termina com `(proposta)` (o linter confere). Quando há fonte primária para a prática, mas não para o número, o Parâmetro também leva `(proposta)`; isso o linter não tem como conferir.
- **Divergência.** Quando as fontes divergem no número, o bloco cita as duas e diz no Parâmetro qual valor adotou.
- **URL e data.** Cada URL é aberta com `curl` antes de entrar. A data é a da conferência, no formato `AAAA-MM-DD`. URL oficial que recusa robôs vai para `scripts/fontes-ignorar.txt` (`URL<TAB>justificativa`), e o `scripts/verificar-fontes.sh` a pula com aviso.
- **Licenças.** Nenhum texto de framework licenciado (SIG, ISO, CIS, ASVS, TSC, CCM/CAIQ) entra no repositório: só o identificador, um título curto e a paráfrase com palavras próprias. A página de venda de uma norma paga (ISO, PCI) vale como referência à norma, não como fonte de texto.
- **Versões do Mapa.** CCM/CAIQ v4.1; SIG 2026 (só domínios); ISO/IEC 27001:2022 com a Amd 1:2024; SOC 2 TSC 2017 (pontos de foco de 2022); NIST CSF 2.0; CIS Controls v8.1; OWASP ASVS 5.0. Nas chaves SOC2 e SIG, `—` quer dizer "não conferido em fonte oficial gratuita nesta versão", e não só "não há correspondente"; os ids da ISO/IEC 27001 foram conferidos pela OLIR 155 do NIST.

## Como escrever o bloco

- O arquivo é UTF-8. O linter normaliza o texto para NFC, então tanto faz o acento vir composto ou decomposto.
- No arquivo de controles, `###` é só para controle. `#` e `##` ficam livres para o título do arquivo e para a introdução; texto entre dois blocos só depois de um `##`.
- Todo título cujo primeiro token é um id (AAA-00) é cabeçalho de controle. Com outro nível (`##`, `####`), sem o espaço ou com outro espaço (tabulação, espaço não separável), é erro.
- Cada campo começa com `- **Nome:** ` numa linha própria. Texto que continua o campo vai recuado (dois espaços); linha sem recuo que não é campo é erro.
- Cada fonte fica numa linha recuada que começa com `- `, com as quatro partes separadas por ` — `.
- No Mapa, mais de um identificador do mesmo framework vai separado por vírgula (`CSF: PR.AA-01, PR.AA-05`).
- Famílias e arquivos: IAM (`controles-iam.md`), DAT (`controles-dat.md`), DEV (`controles-dev.md`), OPS (`controles-ops.md`), IRC (`controles-irc.md`) e GOV (`controles-gov.md`).

## URLs e o verificador de fontes

- **Toda URL do arquivo é conferida, não só a das Fontes.** O `scripts/verificar-fontes.sh` extrai toda URL `http://` ou `https://` dos arquivos `controles-*.md`, e cada uma tem de responder. Um modelo como `curl -sI https://<seu-domínio>` em Como verificar vira FALHA no CI. Nos campos que não são Fontes, escreva o exemplo sem esquema, como `<seu-domínio>/.well-known/security.txt`.
- **URL nunca termina com pontuação nem fica entre crases**, em nenhum campo. O script leva junto o ponto final, a vírgula ou a crase que vem colada, e a URL falha.
- **A lista de ignorar casa a grafia exata.** O `scripts/fontes-ignorar.txt` compara a URL letra por letra. Um controle que cite uma URL dessa lista usa a mesma grafia de `skills/security-standard/references/fontes.md`; outra grafia do mesmo endereço não é pulada e vira FALHA.

## Como conferir

```bash
python3 scripts/lint-controles.py                       # todos os skills/*/references/controles-*.md
python3 scripts/lint-controles.py <arquivo>...          # só os arquivos indicados
python3 scripts/gerar-catalogo.py                       # docs/catalogo-de-controles.md e docs/mapa-de-frameworks.md
bash scripts/verificar-fontes.sh                        # toda URL das fontes responde
bash scripts/testes/lint-controles.test.sh              # teste do linter e do gerador
```

O linter imprime `ERRO <id>: <motivo> (arquivo:linha)` para cada problema e sai com 1, ou `<n> controles válidos` e sai com 0. O gerador confere os blocos antes e, se houver erro, não escreve nada. Os dois só usam a biblioteca padrão do Python 3.
