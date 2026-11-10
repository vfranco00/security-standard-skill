---
name: security-customer-evidence
description: Monta o dossiê de segurança e as respostas a questionários de segurança que o projeto manda a clientes, a partir do estado interno em .security-standard/lacunas.md — só os controles atendidos e com evidência, cada um com o tipo (verificada, documento ou declarada), sob o cabeçalho de autoavaliação, gravados em docs/seguranca/, em português ou em inglês. Use quando o usuário pedir o dossiê, o documento ou o pacote de segurança para mandar a um cliente, quando chegar um questionário ou anexo de segurança para responder (CAIQ, SIG ou o do próprio cliente) ou quando a maestra security-standard chegar ao passo do dossiê (security dossier, trust package, security questionnaire answers, vendor security assessment, customer evidence, CAIQ, SIG). Nunca põe lacuna nem plano no dossiê e nunca afirma conformidade ou certificação que a empresa não tem.
license: MIT
metadata:
  version: "0.1.0"
  catalogo: "2026-11-09"
---

# Dossiê de segurança para clientes

Transforma o estado de segurança que a maestra gravou em `.security-standard/` no que se manda ao cliente: o dossiê de segurança e as respostas ao questionário, em `docs/seguranca/`. Só entra o controle `atendido` e com evidência, sempre com o tipo dela; o que falta continua no plano interno.

## Quando usar

- O usuário quer mandar a um cliente o dossiê, o documento ou o pacote de segurança do produto, em português ou em inglês.
- Chegou um questionário ou anexo de segurança (CAIQ v4.1, SIG ou o do próprio cliente) para responder.
- A `security-standard` (a maestra) chegou ao passo 8, o dossiê.
- O estado mudou (controle novo `atendido`, evidência nova) e o dossiê precisa de versão nova.

## O que esta skill não faz

- Não avalia controle nem muda `.security-standard/`: lê o estado que a maestra e as skills das famílias gravaram e escreve só em `docs/seguranca/`.
- Não inventa estado: sem `.security-standard/lacunas.md`, não monta dossiê de memória nem de exemplo.
- Não põe em `docs/seguranca/` linha `parcial`, `ausente` ou `não se aplica`, item sem evidência, nada do plano, achado aberto, saída de ferramenta, caminho de `evidencias/`, versão de dependência, nome de conta, de bucket ou de banco, endereço interno, nome de cliente, nome ou contato de pessoa, segredo ou valor de variável de ambiente (`../security-standard/references/interno-e-compartilhavel.md`).
- Não afirma conformidade nem certificação: certificado ou relatório só entra com o documento, e o certificado só dentro da validade; sem documento, "nenhuma".
- Não trata a LGPD: a seção de privacidade aponta os documentos que a `lgpd-skill` gera, se estiver instalada.
- Não copia texto de framework licenciado (perguntas do CAIQ e do SIG, controles da ISO, critérios do SOC 2): usa o identificador e escreve com palavras próprias.
- Não manda nada ao cliente: grava os arquivos para a equipe revisar.

## Roteiro

1. **Estado.** Leia `.security-standard/lacunas.md`. Se ele não existir, pare: diga que não há estado avaliado, não grave nada e mande o usuário à `security-standard`, que faz o inventário, avalia os controles e grava as lacunas. Diga também, em duas frases, o que o dossiê terá depois: só os controles atendidos, cada um com o tipo da evidência (verificada, documento ou declarada, e o declarado sai marcado como declarado), gravados em `docs/seguranca/`. Se ele existir, leia também `.security-standard/inventario.md` e a lista de arquivos de `.security-standard/evidencias/`. Dos certificados e relatórios dessa lista, leia só o emissor, o escopo e a data ou a validade (seção 4 do dossiê).
2. **Seleção.** Entra só a linha com situação `atendido`, tipo `verificada`, `documento` ou `declarada` e evidência com texto (não só `—` ou `-`). Ficam `fora` as linhas `parcial`, `ausente` e `não se aplica`. É `inválida` a linha `atendido` sem tipo válido ou sem evidência e a linha com situação fora das quatro (como `Atendido`). Ela não entra, e o usuário fica sabendo que a maestra tem de corrigi-la. Com o terminal, este comando classifica cada linha e marca `ilegível` a linha de tabela com id que ele não conseguiu ler; leia essa linha à mão:

   ```bash
   awk -F'|' '
     /^\|[[:space:]]*[*`]*[A-Z]{3}-[0-9]{2}[*`]*[[:space:]]*\|/ {
       for (i = 2; i <= 7; i++) gsub(/^[[:space:]]+|[[:space:]]+$/, "", $i)
       id = $2; gsub(/[*`]/, "", id)
       if ($5 == "atendido" && $6 ~ /^(verificada|documento|declarada)$/ && $7 ~ /[[:alnum:]]/) r = "entra"
       else if ($5 == "parcial" || $5 == "ausente" || $5 == "não se aplica") r = "fora"
       else r = "inválida"
       print r, id, $5, $6; next
     }
     /^[[:space:]]*\|.*[A-Z]{3}-[0-9]{2}/ { print "ilegível", "linha " NR }
   ' .security-standard/lacunas.md
   ```

3. **Perguntas.** Pergunte numa lista só o que o inventário não traz: língua (português; inglês sob pedido); nome da empresa e do produto e versão do documento; contato de segurança; certificação ou relatório que a empresa tenha, com o documento; documentos de privacidade que podem ir ao cliente; questionário a responder, com o arquivo e a versão. Sem resposta, siga com o que há e repita a pergunta na mensagem final.
4. **Dossiê.** O dossiê atual tem sempre o nome `docs/seguranca/dossie-de-seguranca.md` (em inglês, `docs/seguranca/security-dossier.md`), e as versões anteriores ficam em `docs/seguranca/historico/`.
   - Se o arquivo não existe, copie para ele `assets/dossie-de-seguranca.md` (em inglês, `assets/security-dossier.md`).
   - Se existe, não o sobrescreva nem apague. Mova-o para `docs/seguranca/historico/` com a versão e a data do cabeçalho dele no nome (`dossie-de-seguranca-v1.0-2026-11-09.md`; sem elas, a data de hoje). Use `mv -n` e, se o nome já existir lá, acrescente `-2`. Antes de gravar a nova, confira que o arquivo movido saiu do lugar com `test ! -e <arquivo movido>`. O arquivo é `docs/seguranca/dossie-de-seguranca.md`, `docs/seguranca/security-dossier.md` ou, no passo 5, `docs/seguranca/respostas-<questionário>.md`. Com o destino ocupado, o `mv -n` do macOS sai com 0 e deixa o arquivo onde estava.
   - Depois grave a versão nova com o nome de sempre, a partir do modelo. Ela leva a versão acima da anterior e as linhas da seção 11 da anterior. Da anterior, traga também o que a equipe preencheu e não vem do estado: empresa, produto, contato e documentos de privacidade.

   Troque `{{data}}` e `{{date}}` pela data de hoje e preencha seção a seção pelas regras de `references/dossie.md`. As onze seções ficam no documento, mesmo sem item. Escreva com palavras próprias, a partir da evidência e do enunciado do controle, sem detalhe interno; todo item `declarada` sai marcado como declarado.
5. **Questionário.** Se houver questionário, siga `references/banco-de-respostas.md`. As respostas de cada questionário ficam em `docs/seguranca/respostas-<questionário>.md`, com o nome curto e a versão dele (`respostas-caiq-v4.1.md`), nunca o nome do cliente. Questionário novo começa na versão 1.0, a partir de `assets/respostas-questionario.md`. Se o arquivo do mesmo questionário já existe, faça como no passo 4: a versão anterior vai para `docs/seguranca/historico/`, e a nova fica com o nome de sempre. Só sai resposta de controle `atendido` cuja evidência cobre a pergunta inteira; o resto fica com a equipe.
6. **Conferência.** Antes de entregar, rode os cinco comandos nos arquivos que gravou nesta vez.
   - Os comandos 1a, 1b, 3 e 4 têm de sair vazios.
   - Cada linha do comando 2 só passa em dois casos: tem em `.security-standard/evidencias/` o documento da empresa que a sustenta (certificado na validade ou relatório), ou é o e-mail de uma função. Certificado ou relatório do provedor não vale.
   - Todo achado é corrigido no arquivo antes de entregar, nunca só avisado. Depois de corrigir, rode de novo.

   ```bash
   # 1a. situação que não é atendido, achado aberto, caminho ou endereço interno, CPF e segredo, em toda linha
   grep -s -H -n -i -E '(^|[^[:alnum:]])(ausente|parcial|n(ã|a)o se aplica|planejad|pendente|em (implanta|andamento|defini|prepara)|n(ã|a)o (atendid|implementad)|partial|absent|not met|planned|in progress|in preparation|roadmap)|achados? (altos?|cr(í|i)ticos?|abertos?|em aberto)|open findings?|CVE-[0-9]{4}|\.security-standard|evidencias/|s3://|gs://|arn:aws:|\.internal|[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}|[0-9]{3}\.[0-9]{3}\.[0-9]{3}-[0-9]{2}|AKIA[0-9A-Z]{16}|-----BEGIN|sk-[A-Za-z0-9]{20,}|sk_live_|gh[pousr]_[A-Za-z0-9]{20,}|github_pat_|xox[abposr]-|AIza[0-9A-Za-z_-]{20,}|eyJ[A-Za-z0-9_-]{10,}\.|://[^/[:space:]:@]+:[^/[:space:]@]+@|(senha|password|passwd|secret|token|api[_-]?key)[^:=]{0,20}[:=]' <arquivos que gravou>
   # 1b. conformidade e certificação fora das linhas de certificação e de relatório da seção 4
   grep -s -H -n -i -E 'aderen|compliance|compliant|comply|conform|certificad|certified' <arquivos que gravou> | grep -v -i -E ':[0-9]+:- (Certifica|Relat|Report)'
   # 2. linhas de certificação e de relatório que não dizem "nenhuma", e todo e-mail
   grep -s -H -n -i -E '^- (Certifica|Relat|Report)|[[:alnum:]._%+-]+@[[:alnum:].-]+\.[[:alpha:]]{2,}' <arquivos que gravou> | grep -v -i -E ':[0-9]+:- [^:]+: (nenhuma|nenhum|none)\.?$'
   # 3. ids que não entraram (fora, inválida e ilegível), separados por |
   grep -s -H -n -E '(^|[^[:alnum:]-])(<ids, como IAM-01|DAT-06>)([^.[:alnum:]]|[.]([^0-9]|$)|$)' <arquivos que gravou>
   # 4. nomes internos da evidência das linhas que entraram e do inventário: conta, bucket, banco, instância, host, IP, repositório, pessoa, cliente
   grep -s -H -n -i -F -e '<nome 1>' -e '<nome 2>' <arquivos que gravou>
   ```

   O comando 3 não confunde a pergunta `IAM-07.1` de um questionário com o controle `IAM-07`.
7. **Resposta ao usuário.**
   - Diga quais arquivos gravou e quantos controles entraram, por tipo de evidência.
   - Se havia versão anterior:
     - diga para onde ela foi em `historico/`, que foi substituída e que não deve mais ir a cliente;
     - compare as duas com `diff -u <anterior> <nova>` e dê os ids dos controles que entraram, dos que saíram e dos que mudaram de tipo, e o texto da equipe que ficou só na anterior;
     - avise que controle que saiu pede atenção: se a versão anterior já foi a um cliente, ela afirma algo que deixou de ser verdade;
     - liste as respostas de outros questionários que citam um id que saiu, porque elas podem estar dizendo "sim" por ele: `grep -s -l -E '(^|[^[:alnum:]-])(<ids que saíram>)([^.[:alnum:]]|[.]([^0-9]|$)|$)' docs/seguranca/respostas-*.md`.
   - Diga quantos controles ficaram de fora, por situação, sem listar os `parcial` e os `ausente` (a lista está em `.security-standard/plano.md`), e nomeie as linhas `inválida` e `ilegível`, que a maestra corrige.
   - Aponte as seções sem item com evidência e as perguntas sem resposta.
   - Lembre que a equipe revisa os arquivos e apaga a linha "Gerado pela security-standard-skill" antes de mandar ao cliente, também na versão em inglês.
   - Lembre também que o cabeçalho de autoavaliação vai junto quando as respostas passam para a planilha do cliente.

## Controles desta skill

Esta skill não tem família nem controles próprios. Lê as linhas de `lacunas.md`, que a maestra grava a partir dos catálogos das seis famílias. O id e o título de cada linha vêm do catálogo. O campo `Mapa` de cada bloco liga o controle aos ids do CAIQ v4.1, da ISO/IEC 27001:2022, do NIST CSF 2.0, do CIS v8.1 e do OWASP ASVS 5.0, e é o que o banco de respostas usa. Nesta versão, as chaves do SIG e do SOC 2 vêm `—`: a pergunta identificada só por esses ids fica com a equipe (`references/banco-de-respostas.md`). Os caminhos da tabela partem da pasta-base desta skill (a pasta deste `SKILL.md`), nunca da raiz do projeto do usuário.

| Família | Skill dona | Catálogo | Seções do dossiê |
|---|---|---|---|
| IAM | `security-identity-access` | `../security-identity-access/references/controles-iam.md` | 3 |
| DAT | `security-data-encryption` | `../security-data-encryption/references/controles-dat.md` | 2, 3 e 8 |
| DEV | `security-secure-development` | `../security-secure-development/references/controles-dev.md` | 3, 6 e 10 |
| OPS | `security-infra-operations` | `../security-infra-operations/references/controles-ops.md` | 3, 4 e 8 |
| IRC | `security-incident-continuity` | `../security-incident-continuity/references/controles-irc.md` | 3, 7 e 8 |
| GOV | `security-governance-vendors` | `../security-governance-vendors/references/controles-gov.md` | 3 e 5 |

Família não avaliada não impede o dossiê: ela só não tem linha em `lacunas.md`, e as seções que dependem dela saem sem item.

## Erros comuns

- Pôr no dossiê linha `parcial` ou `ausente`, com esse nome ou como "em implantação", "em preparação", "planejado" ou "próximos passos".
- Apresentar como fato o que é `declarada`, ou chamar de verificado o que só a empresa afirma.
- Tirar ou suavizar o cabeçalho de autoavaliação.
- Montar dossiê de exemplo quando não há `lacunas.md`.
- Dar a certificação do provedor de nuvem como se fosse da empresa, ou citar certificação sem o documento.
- Escrever prazo de aviso, RPO, RTO ou frequência que não está na evidência de uma linha `atendido`.
- Responder "sim" no questionário só porque o `Mapa` liga a pergunta a um controle atendido, sem conferir se a evidência cobre a pergunta inteira.
- Levar ao cliente versão de dependência, nome de conta, bucket ou banco, caminho de `evidencias/` ou saída de ferramenta.
- Copiar para `docs/seguranca/` o texto das perguntas do CAIQ ou do SIG.
- Resumir o programa de privacidade em vez de apontar os documentos da `lgpd-skill`.
- Mandar ao cliente sem a revisão da equipe, com a linha "Gerado pela security-standard-skill" no topo.

## Arquivos

- `references/dossie.md`: as onze seções do dossiê, de onde vem cada uma e o que nunca entra.
- `references/banco-de-respostas.md`: como casar uma pergunta com um controle pelo `Mapa` e responder com palavras próprias, marcando o tipo da evidência.
- `assets/dossie-de-seguranca.md` e `assets/security-dossier.md`: modelos do dossiê, em português e em inglês, com as mesmas seções.
- `assets/respostas-questionario.md`: modelo das respostas ao questionário.
- No projeto do usuário: lê `.security-standard/lacunas.md`, `.security-standard/inventario.md` e a lista de `.security-standard/evidencias/`; grava `docs/seguranca/dossie-de-seguranca.md`, `docs/seguranca/security-dossier.md` e `docs/seguranca/respostas-<questionário>.md`. A versão anterior de cada um vai para `docs/seguranca/historico/` sem ser apagada.
- Skills vizinhas: `security-standard` (maestra, que cria o estado), as skills das seis famílias (tabela acima) e a `lgpd-skill` (privacidade).
