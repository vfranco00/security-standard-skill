---
name: security-governance-vendors
description: Governança de segurança e gestão de fornecedores no padrão que grandes clientes cobram de fornecedores de software, com os controles GOV-01 a GOV-17, cada um com nível (Essencial, Fornecedor, Big tech), parâmetro e fonte. Cobre política aprovada e revista todo ano, responsável nomeado, papéis e segregação de funções, treinamento anual, registro de riscos, fornecedores, lista pública de subprocessadores com aviso de mudança, antecedentes dentro da lei, confidencialidade, uso aceitável e dispositivos, roteiro de certificação ISO 27001 ou SOC 2, compromissos publicados, cláusulas que BCB, SUSEP e GSI fazem o cliente exigir, auditoria interna, métricas, seguro cibernético e leis do produto. Use quando perguntarem que documentos de governança um cliente grande pede, ao montar a política ou a lista de subprocessadores, ou na avaliação de fornecedor (security governance, vendor management, third-party risk, subprocessors, background check, NDA, acceptable use, risk register, ISO 27001, SOC 2, cyber insurance).
license: MIT
metadata:
  version: "0.1.0"
  catalogo: "2026-11-09"
---

# Governança e fornecedores

Monta a governança de segurança que um grande cliente pede de quem lhe vende software: a política, os responsáveis, as pessoas, os riscos, os fornecedores e os subprocessadores, os compromissos com os clientes e as cláusulas que as normas do cliente regulado exigem. Trabalha com 17 controles, GOV-01 a GOV-17, em `references/controles-gov.md`: cada um com nível mínimo, perfis, parâmetro verificável e fontes com tipo, URL e data.

## Quando usar

- Pergunta sobre que documentos de governança um cliente grande pede e o que vai em cada um.
- Questionário de segurança (CAIQ, SIG, anexo do cliente) com perguntas de política, responsáveis, treinamento, antecedentes, confidencialidade, riscos, fornecedores, subprocessadores, certificações, auditoria ou seguro.
- Montar a política de segurança, a lista pública de subprocessadores ou o registro de riscos.
- Cliente de banco, seguradora ou órgão federal manda o contrato com as cláusulas da norma dele.
- A skill `security-standard` (a maestra) chegou à família GOV no plano.

## O que esta skill não faz

- Não certifica nem afirma conformidade: o roteiro de certificação é meta, e nenhum documento gerado diz que a empresa é certificada ou está em conformidade sem o certificado ou o relatório vigente.
- Não dá parecer jurídico: verificação de antecedentes, cláusulas de contrato e obrigações de consumo passam pelo jurídico; a skill diz o que a fonte diz e marca o ponto.
- Não faz a governança da LGPD: com a `lgpd-skill` instalada, carregue a skill dela que trata do caso, a `lgpd-encarregado-e-governanca` (encarregado e programa de governança), a `lgpd-mapeamento-e-registro` (mapa de dados e registro das operações de tratamento), a `lgpd-relatorio-de-impacto` (relatório de impacto), a `lgpd-operador-e-contratos` (acordo de operador e suboperador) ou a `lgpd-transferencia-internacional` (transferência internacional).
- Não repete regra técnica de outra família: acessos (IAM), dados e criptografia (DAT), desenvolvimento (DEV), operação e logs (OPS), incidentes e continuidade (IRC). Os controles GOV citam o id de lá.
- Não lê contas de nuvem, de RH nem de fornecedores, não contrata seguro e não assina contrato: pede documento ou declaração e registra o tipo da evidência.

## Roteiro

1. **Leia o catálogo.** Abra `references/controles-gov.md`. Cada bloco traz Enunciado, Nível mínimo, Perfis, Parâmetro, Por quê, Fontes, Como verificar, Como implementar, Evidência e Mapa. Os níveis são cumulativos: o Fornecedor soma ao Essencial, e o Big tech soma aos dois. O que só vale com um perfil aparece no trecho Essencial do Parâmetro como "no perfil X". Número seguido de `(proposta)` é proposta da skill; nunca o apresente como exigência.
2. **Leia o estado do projeto.** Se existir `.security-standard/config.yml`, leia só as linhas `chave: valor` (a que começa com `#` é comentário, e o valor vai até o primeiro ` #`, de modo que `perfis: # nenhum` é vazio): `nivel_alvo`, `perfis` e `excluir`, em que o motivo vem no próprio valor, como `GOV-16 (motivo — …)`. Valor vazio, ou que ainda é exemplo (`<...>`, `https://...`, `owner/repo`), conta como não informado, com aviso ao usuário. Leia também `inventario.md` e `lacunas.md`. Sem `.security-standard/`, sugira começar pela `security-standard`; se o usuário quiser só esta família, crie a pasta, acrescente `.security-standard/` ao `.gitignore` e pergunte o nível alvo e o setor dos clientes. Se for só uma pergunta, sem projeto para ler, responda já, com o nível alvo pela regra da maestra (`../security-standard/references/niveis-e-perfis.md`): Fornecedor quando um cliente grande vai avaliar o fornecedor ou quando o cliente é banco, instituição de pagamento, seguradora ou órgão público; sem pista, Essencial. Diga que é suposição e mostre as regras "no perfil X" como condicionais.
3. **Selecione os controles.** Entram os de nível mínimo até o nível alvo e com `Perfis` igual a `todos` ou com um perfil do projeto: GOV-11, GOV-15 e GOV-16 só a partir do Fornecedor; GOV-13 só com `financeiro`, `seguros` ou `setor-publico`. Os listados em `excluir` entram como `não se aplica`, com o motivo.
4. **Leia o que dá para ler.** No repositório: políticas e documentos existentes, `docs/seguranca/`, `SECURITY.md`, contratos e anexos-modelo, e as integrações (SDKs, nomes das variáveis de ambiente, nunca os valores, e provedores da infraestrutura como código) para montar a lista de fornecedores e de subprocessadores. O que for lido assim é evidência `verificada`.
5. **Pergunte o resto de uma vez.** Numa lista só, pelo Como verificar de cada bloco: quem é o responsável e o substituto; se há política aprovada e quando foi revista; treinamento e termos de confidencialidade assinados; o que se confere na admissão; dispositivos usados e como são gerenciados; fornecedores, contratos e evidências deles; a quem os clientes são vendidos (empresas, banco, seguradora, órgão federal, consumidor final); roteiro de certificação; última revisão dos controles; métricas levadas à direção; seguro. O que vier anexado é `documento`; o que for só resposta é `declarada`.
6. **Preencha os modelos, sem sobrescrever nada.** Antes de copiar um modelo, confira se o arquivo de destino já existe. Se existe, atualize no lugar, mantendo o que está lá, e mostre ao usuário o que mudou; nunca o regrave a partir do modelo. Os registros (riscos, fornecedores, obrigações, exceções e revisões ou auditorias) só recebem entradas novas e nunca são regravados inteiros: a reavaliação de um risco entra como linha nova, com a data, e a linha anterior fica.
   - `assets/politica-de-seguranca-da-informacao.md`: depois de aprovada, vai para `docs/seguranca/politica-de-seguranca-da-informacao.md` (é o que o cliente recebe), sem nome de conta, recurso ou fornecedor que o cliente não precise ver. Se a `lgpd-encarregado-e-governanca` já gerou a política simplificada de segurança (`.lgpd/governanca/politica-simplificada-de-seguranca.md`), esta política a incorpora por referência, e a skill nunca apaga nem altera o arquivo da `lgpd-skill`.
   - `assets/lista-de-subprocessadores.md`: vai para `docs/seguranca/lista-de-subprocessadores.md` ou para uma página do produto.
   - `assets/registro-de-riscos.md`: fica em `.security-standard/registro-de-riscos.md`, interno, com os riscos (GOV-05), os fornecedores (GOV-06) e as obrigações legais e contratuais (GOV-17). Como `.security-standard/` fica fora do git, guarde uma cópia durável do registro num lugar com backup (repositório privado ou sistema de documentos da empresa); a cópia da pasta é a de trabalho.
   - Troque `{{data}}` e os demais `{{campos}}`; apague a linha "Gerado pela security-standard-skill" depois de revisar.
7. **Registre as lacunas.** Em `.security-standard/lacunas.md`, uma linha por controle selecionado, no formato da maestra: `id | título | nível | situação | tipo de evidência | evidência | próxima ação`. Situação: `atendido`, `parcial`, `ausente` ou `não se aplica`. Tipo de evidência: `verificada`, `documento`, `declarada` ou `—` (só em `ausente`, quando o usuário não respondeu). Nunca marque `atendido` sem a evidência e o tipo dela. No GOV-11, `atendido` no Fornecedor é o roteiro escrito, não o certificado.
8. **Guarde as evidências.** Em `.security-standard/evidencias/<AAAA-MM-DD>/`, com o id no nome do arquivo (`GOV-09-termos.md`). Se a pasta do dia tem `resumo.md`, ela é de uma rodada da `security-automated-checks`: use a próxima sem `resumo.md` (`<AAAA-MM-DD>-2/`, `-3/`). Se o nome do arquivo já existe, acrescente `-2`; nada que já está em `evidencias/` é regravado. Da verificação de antecedentes, guarde só o registro de que foi feita, nunca a certidão; de contratos e apólices, só o resumo das cláusulas.
9. **Proponha as próximas ações.** Para cada lacuna, use o Como implementar do bloco, na ordem do plano da maestra: o risco alto que destrava a venda, o Essencial que falta, o Fornecedor e o Big tech. No Essencial, vêm antes a política e o responsável (GOV-01, GOV-02), a lista de fornecedores e de subprocessadores (GOV-06, GOV-07), os termos e o treinamento (GOV-09, GOV-04) e, com cliente regulado, as cláusulas (GOV-13).
10. **Responda ao usuário.** Numa pergunta sobre documentos, organize por documento: o que o cliente pede, o que vai dentro, os controles GOV que o sustentam (id, nível, parâmetro e tipo da fonte) e onde ele fica (interno ou `docs/seguranca/`). Ponha as regras "no perfil X" como condicionais, aponte as skills da `lgpd-skill` para os documentos da LGPD (encarregado, registro das operações, relatório de impacto, acordo de operador) e termine com as perguntas que faltam. O dossiê para o cliente sai da `security-customer-evidence`, só com o que está atendido.

## Controles desta skill

| Id | Título | Nível mínimo | Perfis |
|---|---|---|---|
| GOV-01 | Política de segurança aprovada e revista todo ano | Essencial | todos |
| GOV-02 | Responsável pela segurança nomeado | Essencial | todos |
| GOV-03 | Papéis definidos e funções separadas | Essencial | todos |
| GOV-04 | Treinamento na admissão e uma vez por ano | Essencial | todos |
| GOV-05 | Registro de riscos com dono e prazo | Essencial | todos |
| GOV-06 | Fornecedores avaliados, contratados com cláusulas e reavaliados | Essencial | todos |
| GOV-07 | Lista pública de subprocessadores e aviso de mudança | Essencial | todos |
| GOV-08 | Verificação de antecedentes dentro da lei | Essencial | todos |
| GOV-09 | Termo de confidencialidade antes do acesso | Essencial | todos |
| GOV-10 | Uso aceitável e dispositivos com o mínimo de segurança | Essencial | todos |
| GOV-11 | Roteiro de certificação ISO/IEC 27001 ou SOC 2 | Fornecedor | todos |
| GOV-12 | Compromissos com os clientes escritos e publicados | Essencial | todos |
| GOV-13 | Cláusulas que BCB, SUSEP e GSI fazem o cliente exigir | Essencial | financeiro, seguros, setor-publico |
| GOV-14 | Revisão anual dos controles e auditoria interna | Essencial | todos |
| GOV-15 | Métricas de segurança para a direção | Fornecedor | todos |
| GOV-16 | Seguro cibernético avaliado | Fornecedor | todos |
| GOV-17 | Obrigações legais e contratuais do produto registradas | Essencial | todos |

Tabela gerada a partir dos blocos de `references/controles-gov.md`; se um bloco mudar, a tabela muda junto. No campo Mapa dos blocos, `CAIQ: IAM-04` e afins são identificadores do CCM/CAIQ v4.1, não controles deste catálogo.

## Erros comuns

- **Afirmar certificação ou conformidade que não existe**, ou chamar de certificado o relatório SOC 2, que é relatório de auditor. Até o documento vigente existir, o dossiê e o anexo dizem "nenhuma", e o roteiro e a data-alvo ficam no plano interno (GOV-11, GOV-12).
- **Usar o certificado do provedor de nuvem como se fosse da empresa.** Ele cobre a infraestrutura do provedor, não o produto (GOV-11).
- **Pedir certidão de antecedentes de todos.** A tese do TST só a admite com previsão legal, natureza do ofício ou fidúcia especial; a regra diz para que função e passa pelo jurídico (GOV-08).
- **Confundir o responsável pela segurança com o encarregado da LGPD**, ou nomear o encarregado por aqui (GOV-02; `lgpd-encarregado-e-governanca`).
- **Apagar ou alterar a política simplificada da `lgpd-encarregado-e-governanca`**: a política do GOV-01 a incorpora por referência, e o arquivo da `lgpd-skill` fica como está.
- **Trocar subprocessador sem avisar**, ou esquecer o aviso de subcontratação que banco e seguradora exigem (GOV-07).
- **Copiar uma política pronta que descreve o que a empresa não faz**, ou prometer no anexo o que não está `atendido` (GOV-01, GOV-12).
- **No setor público, aplicar a regra de senha do NIST sem a da IN GSI/PR 5**, ou exigir troca periódica de quem entra pelo SSO do órgão, ou dar o SSO por cumprido com o MFA do DEV-21: o SSO e a gestão das contas pelo órgão se conferem no GOV-13.
- **Repetir no contrato regra que já tem controle em outra família**, em vez de citar o id (GOV-13 cita DAT, DEV, IAM, OPS e IRC).
- **Tratar o seguro como controle de segurança** ou como exigência (GOV-16).
- **Pôr registro de riscos, avaliação de fornecedores, resultado de verificação ou lista de ciência em `docs/seguranca/`.**
- **Apresentar declaração como verificação**, ou citar número `(proposta)` como exigência.

## Arquivos

- `references/controles-gov.md`: os 17 controles; fonte de verdade da família.
- `assets/politica-de-seguranca-da-informacao.md`: modelo da política, com responsáveis, matriz de responsabilidades, pessoas, uso aceitável e dispositivos, regras por tema e histórico de versões; compartilhável depois de aprovada.
- `assets/lista-de-subprocessadores.md`: modelo da lista pública, com o aviso de mudança e o histórico.
- `assets/registro-de-riscos.md`: modelo interno com os riscos, os fornecedores e as obrigações legais e contratuais.
- No projeto do usuário: `docs/seguranca/politica-de-seguranca-da-informacao.md`, `docs/seguranca/lista-de-subprocessadores.md`, `.security-standard/registro-de-riscos.md`, as linhas GOV de `.security-standard/lacunas.md` e `.security-standard/evidencias/<AAAA-MM-DD>/`.
- Skills vizinhas: `security-standard` (maestra), `security-identity-access` (acessos), `security-data-encryption` (dados, localização, devolução e transporte), `security-secure-development` (desenvolvimento e divulgação de vulnerabilidades), `security-infra-operations` (operação, logs e teste de intrusão), `security-incident-continuity` (incidentes e continuidade), `security-customer-evidence` (dossiê e banco de respostas) e as skills da `lgpd-skill`, se instalada (ver "O que esta skill não faz").
