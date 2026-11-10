> Gerado pela security-standard-skill em {{data}} · revisar antes de usar

# Dossiê de segurança: {{produto}}

{{empresa}} · versão {{versão}} · {{data}}

**Autoavaliação; itens marcados como declarados não foram verificados por terceiro.**

Tipos de evidência:

- `verificada`: conferida pela própria empresa no código, na configuração ou nos registros do sistema; não é auditoria de terceiro.
- `documento`: sustentada por um documento da empresa, como política aprovada, registro de teste ou relatório.
- `declarada`: afirmação da empresa, sem verificação.

Este documento descreve só o que está implantado e tem evidência na data em que o estado foi avaliado (seção 11).

## 1. Visão geral e arquitetura

{{para que serve o produto e quem o usa, pelo setor ou pelo tipo de cliente, nunca pelo nome}}

| Componente | Tecnologia | Tipo de evidência |
|---|---|---|
| {{aplicação, banco de dados, autenticação ou integração}} | {{tecnologia, sem versão}} | {{verificada, documento ou declarada}} |

## 2. Hospedagem e localização dos dados

| Componente | Provedor | País e região | Tipo de evidência |
|---|---|---|---|
| {{aplicação, banco de dados, arquivos ou cópias de segurança}} | {{provedor}} | {{país e região}} | {{verificada, documento ou declarada}} |

## 3. Controles por família

Só os controles atendidos e com evidência. Os ids são do catálogo da security-standard-skill de {{catálogo}}.

### Identidade e acesso (IAM)

| Id | Controle | Situação | Tipo de evidência | Como é atendido |
|---|---|---|---|---|
| {{id}} | {{título}} | atendido | {{verificada, documento ou declarada}} | {{o que é feito, por quem e com que frequência}} |

### Dados e criptografia (DAT)

| Id | Controle | Situação | Tipo de evidência | Como é atendido |
|---|---|---|---|---|
| {{id}} | {{título}} | atendido | {{verificada, documento ou declarada}} | {{o que é feito, por quem e com que frequência}} |

### Desenvolvimento seguro (DEV)

| Id | Controle | Situação | Tipo de evidência | Como é atendido |
|---|---|---|---|---|
| {{id}} | {{título}} | atendido | {{verificada, documento ou declarada}} | {{o que é feito, por quem e com que frequência}} |

### Infraestrutura e operação (OPS)

| Id | Controle | Situação | Tipo de evidência | Como é atendido |
|---|---|---|---|---|
| {{id}} | {{título}} | atendido | {{verificada, documento ou declarada}} | {{o que é feito, por quem e com que frequência}} |

### Incidentes e continuidade (IRC)

| Id | Controle | Situação | Tipo de evidência | Como é atendido |
|---|---|---|---|---|
| {{id}} | {{título}} | atendido | {{verificada, documento ou declarada}} | {{o que é feito, por quem e com que frequência}} |

### Governança e fornecedores (GOV)

| Id | Controle | Situação | Tipo de evidência | Como é atendido |
|---|---|---|---|---|
| {{id}} | {{título}} | atendido | {{verificada, documento ou declarada}} | {{o que é feito, por quem e com que frequência}} |

## 4. Certificações e relatórios

- Certificações: {{nenhuma; ou cada certificado entregue, com o emissor, o escopo e a validade}}.
- Relatórios: {{nenhum; ou cada relatório entregue (teste de intrusão, auditoria, SOC 2), com o emissor, o escopo e a data}}.

## 5. Subprocessadores

| Subprocessador | Finalidade | País e região dos dados | Tipo de evidência |
|---|---|---|---|
| {{fornecedor}} | {{o que faz com os dados}} | {{país e região}} | {{verificada, documento ou declarada}} |

## 6. Desenvolvimento seguro

{{o que as linhas DEV atendidas mostram, cada frase com o id e o tipo da evidência}}

## 7. Resposta a incidentes e aviso ao cliente

{{o que as linhas IRC atendidas mostram (plano de resposta, canal e prazo de aviso ao cliente), cada frase com o id e o tipo da evidência}}

## 8. Continuidade e recuperação

{{o que as linhas atendidas de cópia de segurança, RPO e RTO, teste de recuperação e continuidade mostram, com os números medidos, cada frase com o id e o tipo da evidência}}

## 9. Privacidade e LGPD

{{documentos de privacidade que podem ir ao cliente, como a política de privacidade publicada e o canal do encarregado, gerados com a lgpd-skill, se estiver instalada}}

## 10. Contato de segurança

{{canal para relatar vulnerabilidade ou incidente: e-mail ou formulário de uma função, SECURITY.md ou security.txt}}

## 11. Data e versão

| Versão | Data | Estado avaliado em | O que mudou |
|---|---|---|---|
| {{versão}} | {{data}} | {{data de "Avaliado em" no lacunas.md}} | {{primeira versão, ou o que mudou desde a anterior}} |
