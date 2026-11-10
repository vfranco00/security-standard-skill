---
name: security-standard
description: Ponto de entrada do padrão de segurança de um projeto de software (security standard, security baseline, vendor security assessment, security questionnaire, gap analysis, remediation plan). Use quando o usuário perguntar por onde começar com segurança, quando um cliente grande (banco, seguradora, órgão público, empresa grande) for avaliar a segurança do produto, quando chegar um questionário ou anexo de segurança (CAIQ, SIG) ou quando ele quiser saber o estado e o plano de segurança do projeto. Faz o inventário, escolhe o nível alvo (Essencial, Fornecedor ou Big tech) e os perfis (financeiro, seguros, setor-publico, cartoes, saude), chama as skills de cada família na ordem, grava lacunas e plano em .security-standard/ e separa o que vai para o cliente em docs/seguranca/.
license: MIT
metadata:
  version: "0.1.0"
  catalogo: "2026-11-09"
---

# Padrão de segurança do projeto

Entrada única do plugin. Leva o projeto do inventário ao plano e às evidências: escolhe o nível alvo e os perfis, seleciona os controles do catálogo, chama a skill de cada família na ordem e guarda o estado em `.security-standard/`. O que sai para o cliente fica em `docs/seguranca/`.

## Quando usar

- O usuário pergunta por onde começar com segurança, ou qual é o estado de segurança do projeto.
- Um cliente grande vai avaliar o fornecedor: questionário (CAIQ, SIG), anexo de segurança, due diligence, pedido de relatório.
- O usuário quer um plano para chegar ao nível de fornecedor ou ao de big tech.
- Existe `.security-standard/STATUS.md` e é hora de retomar.
- Pergunta de uma família só (só acessos, só o CI) vai direto à skill da família; esta entra quando o pedido cobre o projeto inteiro.

## O que esta skill não faz

- Não certifica nem afirma conformidade com ISO, SOC 2, PCI DSS ou norma do BCB, da SUSEP ou do GSI: mostra o que falta e o que está provado.
- Não cria controle nem identificador fora do catálogo; controle, parâmetro e fonte estão nas skills de cada família.
- Não lê conta de nuvem nem provedor de identidade; o que mora lá entra por documento ou declaração.
- Não instala ferramenta nem roda nada contra sistema de terceiros; a verificação automática é da `security-automated-checks`, só com o que já está instalado.
- Não muda o repositório do usuário além de criar `.security-standard/` e acrescentar ao `.gitignore` o trecho da pasta interna. Workflow de CI, CODEOWNERS e proteção de branch passam pela skill da família e só com aprovação explícita.
- Não escreve em `docs/seguranca/`: o dossiê é da `security-customer-evidence`.
- Não trata a LGPD em detalhe: aponta a `lgpd-skill` (github.com/vfranco00/lgpd-skill), se instalada.

## Roteiro

O detalhe de cada passo está em `references/roteiro.md`. Ao fim de cada passo, atualize `.security-standard/STATUS.md` (modelo `assets/STATUS.md`). Se o `STATUS.md` já existe, leia-o e retome do primeiro passo pendente ou em andamento; tente de novo cada família `não instalada`. Arquivo que já existe em `.security-standard/` ou em `docs/seguranca/` é atualizado no lugar, mantendo o conteúdo e mostrando ao usuário o que mudou, e nunca é regravado a partir do modelo. Registro só recebe entradas novas (`references/roteiro.md`, "Arquivo que já existe"). Nos comandos, todo caminho que parte da pasta-base desta skill (a pasta deste `SKILL.md`) vai com a pasta-base entre aspas, porque ela pode ter espaço, como `Application Support` no macOS.

1. **Pasta interna.** Crie `.security-standard/` e `.security-standard/evidencias/`. Se o projeto usa git e a pasta ainda não está ignorada, acrescente ao `.gitignore`, em linha nova, o trecho de `assets/gitignore-trecho.txt`. Compare o `git status --porcelain` de antes e de depois do passo: só pode mudar a linha do `.gitignore` e sumir linha de `.security-standard/`, se a pasta já existia sem estar ignorada. Nada mais muda, e nenhuma linha de `.security-standard/` aparece depois. Explique ao usuário, em duas frases, a separação de `references/interno-e-compartilhavel.md`: `.security-standard/` é interno (lacunas, plano, evidências) e fica fora do git; `docs/seguranca/` é o que se compartilha com o cliente.
2. **Inventário.** Leia o projeto (lista em `references/roteiro.md`, passo 2) e pergunte numa lista só o que não dá para ler: setor dos clientes, questionário ou anexo recebido e prazo, dados tratados, equipe, contas de nuvem e de identidade. Grave `.security-standard/inventario.md` (modelo `assets/inventario.md`) com a origem de cada item.
3. **Nível alvo e perfis.** Leia `references/niveis-e-perfis.md`, proponha o nível alvo e os perfis com o motivo e confirme com o usuário. Se o `config.yml` já existe, mesmo escrito à mão e sem `STATUS.md`, confira antes a forma: cada chave numa linha só, sem colchetes, aspas nem lista em várias linhas (`references/roteiro.md`, passo 3). Depois, parta dos valores dele e mude no lugar só o que o usuário confirmar. Senão, grave `.security-standard/config.yml` a partir de `assets/config.yml`: ponha em cada chave o valor do projeto (os exemplos ficam só nos comentários) e deixe vazia a que não se aplica; em `excluir`, o motivo vai dentro do valor, como `IAM-07 (motivo — …)`. Na leitura, o valor vai de `chave:` até o primeiro ` #` (espaço seguido de #), e só então se aparam os espaços (`references/roteiro.md`, passo 3). Sem resposta e sem `config.yml`, o modelo sem edição já é o padrão (`nivel_alvo: Essencial`, nenhum perfil), com "a confirmar" no `STATUS.md`.
4. **Skills em ordem.** Para cada família da tabela abaixo, na ordem, carregue a skill dona e siga o roteiro dela para os controles selecionados (regra do passo 5). Só marque a família como `não instalada` depois de procurar a pasta dela a partir da pasta-base desta skill, nunca da raiz do projeto, ou de a skill não carregar. Nesse caso, avise o usuário, registre no `STATUS.md` e não avalie a família de memória.
5. **Lacunas.** Grave `.security-standard/lacunas.md` (modelo `assets/lacunas.md`), uma linha por controle selecionado:
   - entra o controle cujo `Nível mínimo` está no nível alvo ou abaixo (Essencial < Fornecedor < Big tech) **e** cujo `Perfis` é `todos` ou contém um perfil do `config.yml`;
   - controle listado em `excluir` fica com situação `não se aplica`, tipo `declarada` e, na evidência, o motivo que vem dentro do valor (`IAM-07 (motivo — …)`);
   - situação: `atendido`, `parcial`, `ausente` ou `não se aplica`; tipo de evidência: `verificada` (você leu no projeto), `documento` (o usuário entregou), `declarada` (só a palavra do usuário) ou `—` (pergunta sem resposta, só com `ausente`);
   - nunca `atendido` sem evidência e sem o tipo dela; onde não há o que ler nem documento, o tipo é `declarada` se o usuário respondeu e `—` se não respondeu;
   - a evidência do `atendido` traz o que prova o `Parâmetro` do nível alvo (data, frequência ou número), e não só "sim"; sem isso, a linha não fica `atendido`.
6. **Plano.** Grave `.security-standard/plano.md` (modelo `assets/plano.md`) com toda linha `ausente` ou `parcial`, uma vez só, no primeiro destes grupos em que couber: 1. risco alto que destrava a venda; 2. Essencial que falta; 3. Fornecedor que falta; 4. Big tech que falta. O que fazer vem do `Como implementar` do controle.
7. **Evidências.** Ofereça a `security-automated-checks` (só ferramentas já instaladas, sem varredura ativa; as de dependências consultam bases públicas de vulnerabilidade) e guarde os documentos do usuário em `.security-standard/evidencias/<AAAA-MM-DD>/`, ou na próxima pasta sem `resumo.md` se a do dia for de uma rodada, sem regravar arquivo que já existe (`references/roteiro.md`, passo 7). Atualize a linha do controle em `lacunas.md`: situação, tipo e evidência.
8. **Dossiê.** Quando o usuário for mandar algo ao cliente, chame a `security-customer-evidence`: ela escreve em `docs/seguranca/` só os controles `atendido`, com o tipo da evidência.

## Controles desta skill

A maestra não tem família própria: seleciona e consolida os controles das seis famílias. Cada catálogo fica na skill dona. Os caminhos da tabela partem da pasta-base desta skill (a pasta deste `SKILL.md`, que o agente recebe ao carregar a skill), nunca da raiz do projeto do usuário.

| Família | Skill dona | Catálogo | Controles |
|---|---|---|---|
| IAM | `security-identity-access` | `../security-identity-access/references/controles-iam.md` | 14 |
| DAT | `security-data-encryption` | `../security-data-encryption/references/controles-dat.md` | 15 |
| DEV | `security-secure-development` | `../security-secure-development/references/controles-dev.md` | 26 |
| OPS | `security-infra-operations` | `../security-infra-operations/references/controles-ops.md` | 16 |
| IRC | `security-incident-continuity` | `../security-incident-continuity/references/controles-irc.md` | 11 |
| GOV | `security-governance-vendors` | `../security-governance-vendors/references/controles-gov.md` | 17 |

São 99 controles no catálogo de 2026-11-09. Para selecionar sem ler cada bloco inteiro, busque só o cabeçalho, o nível mínimo e os perfis, trocando `<pasta-base>` pela pasta-base desta skill e mantendo as aspas em volta dela (fora das aspas, o `*` ainda acha os catálogos):

```bash
grep -E '^### [A-Z]{3}-[0-9]{2} |^- \*\*(Nível mínimo|Perfis):\*\*' "<pasta-base>"/../security-*/references/controles-*.md
```

Duas skills sem família fecham o roteiro: `security-automated-checks` (passo 7) e `security-customer-evidence` (passo 8).

## Erros comuns

- Marcar `atendido` sem evidência ou sem o tipo, ou chamar de verificada a palavra do usuário.
- Pôr lacuna, saída de ferramenta, nome de conta ou segredo em `docs/seguranca/`.
- Afirmar conformidade ou certificação que a empresa não tem; a skill mostra o que falta e o que está provado.
- Esquecer o perfil que vem do cliente: SaaS vendido a banco liga `financeiro`, mesmo sem dado financeiro no produto.
- Desligar `cartoes` porque o pagamento é de um provedor: a página que embute o formulário do provedor ainda conta (veja `references/niveis-e-perfis.md`).
- Confundir o nível mínimo, que é do controle, com o nível alvo, que é do projeto.
- Selecionar controle de perfil que o projeto não tem, ou deixar de fora um controle `todos`.
- Copiar para o valor de uma chave do `config.yml` o exemplo do comentário, ou excluir controle sem o motivo dentro do valor.
- Procurar os catálogos a partir da raiz do projeto do usuário e marcar as famílias como `não instalada`: o caminho parte da pasta-base desta skill.
- Inventar controle, parâmetro ou fonte fora do catálogo.
- Deixar `.security-standard/` fora do `.gitignore` e versionar as lacunas sem querer.

## Arquivos

- `references/roteiro.md`: os oito passos em detalhe (o que ler, o que perguntar, o que gravar e como conferir).
- `references/niveis-e-perfis.md`: os três níveis, os cinco perfis, o que cada perfil liga e como escolher o nível alvo.
- `references/interno-e-compartilhavel.md`: o que fica em `.security-standard/` e o que vai para `docs/seguranca/`.
- `references/fontes.md`: a tabela consolidada das fontes do catálogo, com as siglas citadas nas outras referências.
- `assets/STATUS.md`, `assets/inventario.md`, `assets/config.yml`, `assets/lacunas.md`, `assets/plano.md`: modelos dos arquivos de `.security-standard/`.
- `assets/gitignore-trecho.txt`: a linha que vai para o `.gitignore` do projeto.
