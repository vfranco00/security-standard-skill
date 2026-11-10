# Banco de respostas: questionário de segurança

Como responder a um questionário de segurança (CAIQ v4.1, SIG ou o do próprio cliente) com o estado do projeto. Para cada pergunta: ache o controle do catálogo pelo campo `Mapa`, confira se o controle entrou na seleção e se a evidência cobre a pergunta e responda com palavras próprias, marcando o tipo da evidência. O modelo é `assets/respostas-questionario.md`, e o arquivo vai para `docs/seguranca/respostas-<questionário>.md` (passo 5 do `SKILL.md`).

O método não depende de nenhuma família estar completa: pergunta sem controle no catálogo, ou com controle de família não avaliada, fica com a equipe.

## 1. Prepare

- Peça o questionário em texto: Markdown, CSV ou colado na conversa. Se for planilha, peça ao usuário que exporte em CSV a aba das perguntas; a skill não instala nada para ler planilha.
- Pergunte qual questionário e qual versão o cliente mandou (por exemplo, CAIQ v4.1 ou v4.0.3) e anote se as perguntas têm id. A versão decide como casar as perguntas (seção 2).
- Tenha à mão a saída do passo 2 do `SKILL.md`: as linhas que entram e as que ficaram de fora, com a situação.

## 2. Ache o controle de cada pergunta

O `Mapa` de cada bloco dos catálogos traz os ids de outros frameworks, nesta ordem: CAIQ, SIG, ISO, SOC2, CSF, CIS e ASVS. Nesta versão, as chaves `SIG` e `SOC2` vêm `—` nos 99 controles, porque esses ids não foram conferidos em fonte oficial gratuita. Os catálogos ficam em `"<pasta-base>"/../security-*/references/controles-*.md` (tabela do `SKILL.md`). As versões e as fontes são as siglas de `../security-standard/references/fontes.md`.

| A pergunta traz | Procure na chave do `Mapa` | Exemplo |
|---|---|---|
| id de pergunta do CAIQ v4.1 (sigla CSA-CCM) | `CAIQ`, com o id do controle do CCM v4.1: o id da pergunta sem o ponto e o número do fim. Na v4.1, o domínio `IVS` virou `I&S`: procure os dois | pergunta `BCR-08.3` → `BCR-08`; `I&S-09.1` → `I&S-09` ou `IVS-09` |
| domínio ou id do SIG 2026 (sigla SIG) | nenhuma: nesta versão a chave `SIG` vem `—`, e a pergunta fica com a equipe (abaixo) | `Access Control` |
| controle do Anexo A da ISO/IEC 27001:2022 (sigla ISO-27001) | `ISO` | `A.8.5` |
| critério do SOC 2 (sigla AICPA-TSC) | nenhuma: nesta versão a chave `SOC2` vem `—`, e a pergunta fica com a equipe (abaixo) | `CC6.1` |
| subcategoria do NIST CSF 2.0 (sigla NIST-CSF) | `CSF` | `PR.AA-03` |
| salvaguarda do CIS Controls v8.1 (sigla CIS-V81) | `CIS` | `6.3` |
| requisito do OWASP ASVS 5.0 (sigla OWASP-ASVS) | `ASVS` | `V6.2` |
| nenhum id | nenhuma: compare o assunto da pergunta com o título e o enunciado dos controles | MFA, cópia de segurança, teste de intrusão |

Pergunta identificada só por id do SOC 2 ou do SIG não recebe resposta: fica com a equipe, com o motivo "o `Mapa` desta versão não traz ids do SOC 2" (ou "do SIG"). Se a mesma pergunta traz também um id do CAIQ v4.1 ou da ISO/IEC 27001:2022, case por ele, como nas linhas acima. A correspondência pelo tema só passa pelas chaves `CAIQ` e `ISO`: o controle candidato vai à mensagem ao usuário marcado "a conferir", nunca como resposta no arquivo.

O formato do id do CAIQ foi conferido na planilha oficial do CAIQ v4.1 (CAIQv4.1.0), baixada do site da CSA em 2026-11-09. Nela, cada pergunta tem o id do controle do CCM seguido de ponto e de um número, e os 17 domínios incluem `I&S` e não `IVS`.

Cuidados com o CAIQ:
- Os ids do `Mapa` são do CAIQ v4.1. Questionário de outra versão, como a v4.0.x, que numera parte do IAM de outro jeito, ou que não diz a versão, se casa pelo assunto, não pelo id.
- Confirme cada candidato pelo título. A planilha do CAIQ traz, ao lado da pergunta, o título do controle do CCM, e ele tem de bater com o título e o enunciado do controle do catálogo.
- O id da pergunta e o do catálogo podem coincidir sem ser o mesmo controle. `IAM-13` no CAIQ v4.1 é autenticação forte; no catálogo, é dispositivo identificado para acessar a produção.

Com o terminal, este comando lista os controles cujo `Mapa` tem o id. Troque `<pasta-base>` pela pasta-base desta skill, mantendo as aspas em volta dela (fora das aspas, o `*` ainda acha os catálogos). Troque também `CAIQ` pela chave e `BCR-08` pelo id, com `[.]` no lugar de cada ponto (`A[.]8[.]5`, `PR[.]AA-03`), porque o `awk` lê `\.` como ponto qualquer. Para o domínio `I&S`, use `(I&S|IVS)-09`:

```bash
awk -v k='CAIQ:([^;]*[ ,])?BCR-08([^0-9]|$)' '/^### [A-Z]{3}-[0-9]{2} /{c=$2} /^- \*\*Mapa:\*\*/ && $0 ~ k {print c}' "<pasta-base>"/../security-*/references/controles-*.md
```

O `Mapa` liga temas parecidos, não iguais. Um controle pode cobrir só parte da pergunta, e a pergunta pode pedir mais do que ele (uma revisão anual, um teste, um registro). O `Mapa` aponta os candidatos, e quem decide é a leitura da pergunta, do enunciado e do parâmetro do controle e da evidência da linha em `lacunas.md`.

## 3. Decida a resposta

| O que há | Resposta |
|---|---|
| Controle que entrou na seleção, e a evidência cobre tudo o que a pergunta pede | "sim" (no CAIQ, `Yes`), com a descrição e o tipo da evidência |
| Controle que entrou na seleção, mas a pergunta pede mais do que a evidência mostra | nenhuma: a pergunta fica com a equipe, com o que falta |
| Controle `parcial`, `ausente` ou `não se aplica`, `atendido` sem tipo ou sem evidência, controle sem linha em `lacunas.md` (fora do nível alvo ou dos perfis, ou de família não avaliada) ou nenhum controle | nenhuma: a pergunta fica com a equipe, com a situação ou o motivo |

- Pergunta que precisa de mais de um controle só recebe resposta se todos os necessários entraram na seleção.
- Frequência, prazo ou número que a pergunta pede (anual, periódico, em 24 horas) só conta se estiver na evidência da linha; o título e o parâmetro do controle no catálogo não bastam.
- No CAIQ, o "sim" vale para a parte do controle do CCM que aquela pergunta pede, não para o controle inteiro (introdução da planilha oficial). Por isso a conferência da evidência é feita pergunta por pergunta.
- A skill nunca responde "sim" para cobrir lacuna e não escreve resposta negativa no arquivo. A equipe decide se responde "não", "não se aplica" ou com um prazo de implantação.

## 4. Escreva a resposta

- Descrição em uma a três frases, com palavras próprias: o que é feito, por quem e com que frequência ou desde quando, a partir da evidência e do enunciado do controle.
- Quando quem executa é o provedor (por exemplo, a criptografia padrão do banco gerenciado), a descrição diz isso. Na planilha do CAIQ, a responsabilidade vai na coluna que ela tem para isso; no arquivo, fica na descrição.
- Toda resposta leva o tipo da evidência na coluna dele. Quando é `declarada`, "Como fazemos" também termina com "(declarada)" (em inglês, "(declared)"), porque é esse texto que vai para a planilha do cliente.
- Nunca entram o texto da pergunta do CAIQ ou do SIG, que têm licença própria (no arquivo vão o id e um tema em palavras próprias), o detalhe interno que `references/dossie.md` proíbe e número que não está na evidência.
- A resposta segue a língua do questionário; em inglês, o modelo e os tipos são traduzidos como na variante em inglês de `references/dossie.md`.

## 5. Entregue

- Grave `docs/seguranca/respostas-<questionário>.md`, com o nome curto e a versão do questionário e nunca o nome do cliente, a partir de `assets/respostas-questionario.md`. Ponha uma linha por pergunta respondida, na ordem do questionário.
- Questionário novo começa na versão 1.0. Se o mesmo questionário volta, a versão anterior vai para `docs/seguranca/historico/` e a nova fica com o nome de sempre (passo 5 do `SKILL.md`). Outro questionário nunca é a versão anterior deste.
- Na mensagem ao usuário, liste as perguntas que ficaram com a equipe, com o id e o motivo: sem controle no catálogo; controle `parcial` ou `ausente`; `não se aplica`, com o motivo declarado; linha inválida; evidência que não cobre a pergunta; pergunta identificada só por id do SOC 2 ou do SIG, com o controle candidato pelo tema, se houver, marcado "a conferir". Essa lista não vai para `docs/seguranca/`.
