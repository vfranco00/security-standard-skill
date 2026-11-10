# Dossiê de segurança: seções e regras

O dossiê é o documento que o cliente lê na avaliação de fornecedor. Os modelos são `assets/dossie-de-seguranca.md` (português, o padrão) e `assets/security-dossier.md` (inglês, sob pedido), com as mesmas onze seções na mesma ordem. O dossiê atual fica sempre em `docs/seguranca/dossie-de-seguranca.md` ou `docs/seguranca/security-dossier.md`. Quando ele já existe, a versão anterior vai para `docs/seguranca/historico/`, sem ser apagada (passo 4 do `SKILL.md`).

## Regras para o documento inteiro

- **Cabeçalho fixo.** Logo abaixo do título fica a frase "Autoavaliação; itens marcados como declarados não foram verificados por terceiro." (em inglês: "Self-assessment; items marked as declared have not been verified by a third party."), seguida da legenda dos tipos de evidência do modelo. A frase não sai nem muda.
- **Só o atendido com evidência.** Toda afirmação sobre segurança vem de uma linha que entrou na seleção (passo 2 do `SKILL.md`) ou de um item de `inventario.md` com origem. O que não tem evidência não entra, nem como "em implantação", "em preparação", "planejado" ou "próximos passos".
- **Tipo em todo item.** Linha de `lacunas.md` leva o tipo dela. Item do inventário leva o tipo da origem: `lido em <arquivo>` é `verificada`, `documento <caminho>` é `documento` e `declarado pelo usuário em <data>` é `declarada`. Item `declarada` sai marcado como declarado na tabela e no texto, como "(declarada)".
- **Palavras próprias.** Diga o que é feito, por quem (a equipe ou o provedor) e com que frequência, a partir da evidência e do enunciado do controle. Número, prazo e frequência vêm só da evidência, nunca do parâmetro do catálogo nem de memória. Nada de texto de framework licenciado.
- **Nada interno.** Nunca entram:
  - caminho de `.security-standard/` ou de `evidencias/`, saída de ferramenta e achado aberto de teste ou de varredura;
  - versão de dependência;
  - nome de conta, de bucket, de banco ou de instância, e endereço interno (host ou IP);
  - nome de cliente;
  - nome ou contato de pessoa (nome, e-mail pessoal, CPF);
  - segredo ou valor de variável de ambiente.
- **Seção sem item.** As onze seções ficam no documento. A que não tem item com evidência leva só a frase "Sem item com evidência nesta versão." (em inglês: "No item with evidence in this version."). A mensagem final diz ao usuário quais seções saíram assim.
- **Sem conformidade.** O documento não diz que a empresa está conforme, em conformidade ou aderente a lei, norma ou framework. Certificação só aparece na seção 4, como fato tirado do documento (emissor, escopo, validade). Os ids da seção 3 são do catálogo da skill, não de norma; o dossiê não cita o `Mapa`.

## As seções

### 1. Visão geral e arquitetura

Para que serve o produto e quem o usa, pelo setor ou pelo tipo de cliente e nunca pelo nome, e os componentes (aplicação, banco de dados, autenticação, integrações) pelo tipo de tecnologia, sem versão. Fonte: Projeto e Stack de `inventario.md`. Não entram o nome do repositório, os nomes internos dos componentes nem os da tabela Clientes.

### 2. Hospedagem e localização dos dados

Onde ficam a aplicação, o banco de dados, os arquivos e as cópias de segurança: o provedor, o país e a região. Fontes: Hospedagem de `inventario.md` e a linha DAT-09 (localização dos dados), se entrou na seleção. Não entram conta, bucket, instância nem endereço.

### 3. Controles por família

Uma tabela por família, na ordem IAM, DAT, DEV, OPS, IRC e GOV, com as linhas da seleção: id, título, situação (`atendido`), tipo da evidência e como é atendido, com palavras próprias. A família sem linha na seleção leva a frase de seção sem item.

### 4. Certificações e relatórios

Certificado (por exemplo, ISO/IEC 27001) ou relatório (de teste de intrusão, de auditoria, SOC 2) só entra com o documento que o usuário entregou ou que está em `.security-standard/evidencias/`, e o certificado só dentro da validade: vencido não entra.

- Leia só os documentos desta seção e tire deles só o emissor, o escopo e a data ou a validade. O documento não vai junto, e o achado que ele traz também não.
- Sem documento, a linha diz "nenhuma" (ou "nenhum"), mesmo que o usuário afirme ter a certificação ou que ela esteja em preparação: o roteiro e a data-alvo (GOV-11) ficam no plano interno.
- Certificado ou relatório do provedor de nuvem é do provedor, não cobre o produto e não entra, mesmo guardado em `evidencias/`.
- A conferência do passo 6 mostra as linhas desta seção que não dizem "nenhuma", para comparar com os documentos.

### 5. Subprocessadores

Quem trata dados do cliente em nome da empresa: o fornecedor, a finalidade e o país e a região dos dados. Fonte: a lista de subprocessadores em `docs/seguranca/`, se já existir (vem da família GOV); senão, Hospedagem e Integrações de `inventario.md`, cada item com o tipo da origem. País ou região sem origem fica "a confirmar", e a pergunta vai para a mensagem final. Não entram conta, plano contratado nem valor.

### 6. Desenvolvimento seguro

De duas a cinco frases sobre o que as linhas DEV da seleção mostram: revisão de código, varredura no CI, prazos de correção, divulgação de vulnerabilidades. Cada frase leva o id e o tipo.

### 7. Resposta a incidentes e aviso ao cliente

O que as linhas IRC da seleção mostram: plano de resposta, canal e prazo de aviso ao cliente, registro de incidentes. Prazo de aviso só entra se estiver na evidência de uma linha da seleção; nunca de memória nem de norma.

### 8. Continuidade e recuperação

O que as linhas da seleção sobre cópia de segurança (DAT-06), RPO e RTO (DAT-07), teste de recuperação da infraestrutura (OPS-13) e continuidade (IRC) mostram, com os números medidos que a evidência traz. Nenhum número sem uma linha da seleção que o contenha.

### 9. Privacidade e LGPD

A seção não repete o programa de privacidade, que é da `lgpd-skill`. Ela aponta os documentos de privacidade que já existem e podem ir ao cliente, como a política de privacidade publicada e o canal do encarregado. Sem nenhum desses documentos, leva a frase de seção sem item, e a mensagem final sugere a `lgpd-skill`. Papel da empresa (controladora ou operadora) e base legal só entram se um documento de privacidade os trouxer.

### 10. Contato de segurança

O canal para relatar vulnerabilidade ou incidente: o e-mail ou o formulário de uma função, nunca de uma pessoa, o `SECURITY.md` ou o `security.txt` que a linha DEV-10 mostra, ou o canal que o usuário informar.

### 11. Data e versão

A data do documento, a versão, a data em que o estado foi avaliado (a de "Avaliado em" no `lacunas.md`) e o que mudou desde a versão anterior. Cada mudança de linha da seleção pede versão nova, com o nome de sempre; a anterior vai para `docs/seguranca/historico/`, com a versão e a data no nome, e não volta a ir a cliente. Em "O que mudou" entram os controles e as seções acrescentados ou atualizados. O controle que saiu do dossiê só aparece na mensagem ao usuário, que decide como tratar o assunto com o cliente.

## Variante em inglês

Mesmas seções, mesma ordem e mesmas regras. Na tabela da seção 3, a situação `atendido` vira `met`, e os tipos `verificada`, `documento` e `declarada` viram `verified`, `document` e `declared`. Os títulos dos controles são traduzidos com palavras próprias.
