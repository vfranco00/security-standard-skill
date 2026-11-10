---
name: security-infra-operations
description: Leva a infraestrutura e a operação de um sistema ao padrão que grandes clientes cobram de fornecedores, com os controles OPS-01 a OPS-16, cada um com nível (Essencial, Fornecedor, Big tech), parâmetro e fonte. Cobre hardening, segmentação e zero trust, WAF, TLS e cabeçalhos, logs com retenção por nível e os prazos do Marco Civil, integridade dos logs, monitoramento e alerta, vulnerabilidades e patches, postura da nuvem e IaC, inventário, DDoS, limites de taxa, teste de recuperação, produção isolada, acesso administrativo seguro e teste de intrusão anual por terceiro independente. Use para dizer o que um cliente exige de logs, monitoramento e hardening, preparar a avaliação de um banco ou seguradora ou responder às perguntas de infraestrutura de um questionário (infrastructure security, hardening, network segmentation, zero trust, WAF, logging, log retention, monitoring, alerting, vulnerability management, patching, CSPM, DDoS, rate limiting, penetration testing).
license: MIT
metadata:
  version: "0.1.0"
  catalogo: "2026-11-09"
---

# Infraestrutura e operações

Leva a infraestrutura e a operação da produção ao padrão que um grande cliente cobra na avaliação de fornecedor e que as big techs praticam por dentro. Trabalha com 16 controles, OPS-01 a OPS-16, em `references/controles-ops.md`: cada um com nível mínimo, perfis, parâmetro verificável e fontes com tipo, URL e data.

## Quando usar

- Pergunta sobre o que um cliente vai exigir de logs, monitoramento, hardening, rede, TLS, correções de segurança ou teste de intrusão.
- Questionário de segurança (CAIQ, SIG, anexo de um cliente) com perguntas de infraestrutura, operação, registros, vulnerabilidades, recuperação ou testes.
- A skill `security-standard` (a maestra) chegou à família OPS no plano.
- Cliente do setor financeiro, seguradora, órgão público ou sistema que trata dado de cartão: os perfis somam regras a vários controles, e os perfis financeiro, cartoes e setor-publico trazem o OPS-16 já para o Essencial.

## O que esta skill não faz

- Não lê conta de nuvem nem roda comando no provedor: pede exportação, captura ou declaração e registra o tipo da evidência.
- Não roda varredura, teste de intrusão, teste de carga nem ataque simulado contra nada, e não contrata o teste: diz o que pedir e confere o relatório. A verificação local e passiva (Trivy, Checkov, cabeçalhos do próprio domínio) é da `security-automated-checks`.
- Não muda configuração de produção nem de conta: propõe a mudança, e o usuário aplica. Arquivo do repositório (infraestrutura como código, Dockerfile, cabeçalhos, CI) só muda com aprovação explícita.
- Não cobre o que é de outras famílias: acesso de pessoas, MFA e registro do acesso administrativo (`security-identity-access`); prazos de correção por gravidade (DEV-09), separação de credenciais e dados por ambiente (DEV-12), separação dos dados de cada cliente (DEV-23) e proteção do login contra força bruta (DEV-21), na `security-secure-development`; TLS e HSTS (DAT-03), backup e restauração dos dados (DAT-06), RPO e RTO (DAT-07) e o que não pode entrar no log (DAT-11), na `security-data-encryption`; plano de incidentes e de continuidade (`security-incident-continuity`). O OPS cita esses ids em vez de repetir os números.
- Não certifica nem afirma conformidade com a PCI DSS ou com norma do BCB, da SUSEP ou do GSI: diz o que está atendido, com evidência, e o que falta.
- Não trata a LGPD em detalhe; para isso existe a `lgpd-skill`, se estiver instalada.

## Roteiro

1. **Leia o catálogo.** Abra `references/controles-ops.md`. Cada bloco traz Enunciado, Nível mínimo, Perfis, Parâmetro, Por quê, Fontes, Como verificar, Como implementar, Evidência e Mapa. Os níveis são cumulativos: o Fornecedor soma ao Essencial, e o Big tech soma aos dois. As linhas `Perfil financeiro:`, `Perfil cartoes:` e as outras, no fim do Parâmetro, somam regras quando o projeto tem o perfil, em qualquer nível. Número seguido de `(proposta)` é proposta da skill, sem fonte primária para o número; nunca o apresente como exigência.
2. **Leia o estado do projeto.** Se existir `.security-standard/`, leia `config.yml` (`nivel_alvo`, `perfis`, `excluir`), `inventario.md` e `lacunas.md`. Se não existir, sugira começar pela `security-standard`, que cria a pasta, o `.gitignore` e o inventário. Se o usuário quiser só esta família, crie `.security-standard/`, acrescente `.security-standard/` ao `.gitignore` e pergunte o nível alvo e os perfis do cliente e do dado. Se for só uma pergunta, sem projeto para ler, responda já, com o nível alvo pela regra da maestra (`../security-standard/references/niveis-e-perfis.md`): Fornecedor quando um cliente grande vai avaliar o fornecedor ou quando o cliente é banco, instituição de pagamento, seguradora ou órgão público; sem pista, Essencial. Diga que é uma suposição, mostre as linhas dos perfis como condicionais e pergunte quais perfis valem.
3. **Selecione os controles.** Entram os de nível mínimo até o nível alvo; os 16 têm Perfis `todos`. No OPS-16, o trecho Essencial só traz as linhas dos perfis `financeiro`, `cartoes` e `setor-publico`: num projeto Essencial sem nenhum deles, a linha fica `não se aplica`, tipo `declarada` (a lista de perfis é declaração do usuário no `config.yml`), com o motivo "regra só dos perfis financeiro, cartoes e setor-publico"; a partir do Fornecedor, o teste anual vale para todo projeto. Em cada controle selecionado, valem o parâmetro do nível alvo e as linhas dos perfis do projeto. Controle listado em `excluir` fica como `não se aplica`, tipo `declarada`, com o motivo do `config.yml` na evidência.
4. **Leia o que dá para ler, sem acessar contas.** No repositório: infraestrutura como código (Terraform, CloudFormation, Pulumi, manifestos do Kubernetes), Dockerfiles, configuração do servidor web, da CDN ou do framework (cabeçalhos, TLS, limites de taxa) e workflows de CI. Em `.security-standard/evidencias/`: as saídas da `security-automated-checks` (Trivy, Checkov, conferência de cabeçalhos), se houver. O que for lido assim é evidência `verificada`.
5. **Pergunte o resto de uma vez, por controle.** Use o Como verificar de cada bloco. Peça exportações: regras de firewall e da borda, configuração do WAF e da proteção contra DDoS, inventário de ativos, inventário e retenção dos logs, regras de alerta, relatório de postura da nuvem, registro do último teste de recuperação e relatório do último teste de intrusão. O que vier anexado é `documento`; o que for só resposta é `declarada`; a pergunta que ficar sem resposta deixa o controle `ausente`, com tipo `—`.
6. **Preencha o checklist de hardening.** Se `.security-standard/checklist-de-hardening.md` ainda não existe, copie `assets/checklist-de-hardening.md` para lá e troque `{{data}}` pela data de hoje. Se já existe, nunca o regrave: atualize no lugar, mantendo o que está lá, e mostre ao usuário o que mudou; a tabela de testes (seção 8) só recebe linhas novas. Preencha com o que foi lido e respondido. O checklist tem endereços, portas e configuração da produção e fica interno.
7. **Registre as lacunas.** Em `.security-standard/lacunas.md`, uma linha por controle selecionado, no formato da maestra: `id | título | nível | situação | tipo de evidência | evidência | próxima ação`. Situação: `atendido`, `parcial`, `ausente` ou `não se aplica`. Tipo de evidência: `verificada`, `documento`, `declarada` ou `—` (pergunta sem resposta, só com `ausente`). Nunca marque `atendido` sem a evidência e o tipo dela.
8. **Guarde as evidências.** Em `.security-standard/evidencias/<AAAA-MM-DD>/`, com o id no nome do arquivo (`OPS-05-retencao-dos-logs.json`). Se a pasta do dia tem `resumo.md`, ela é de uma rodada da `security-automated-checks`: use a próxima sem `resumo.md` (`<AAAA-MM-DD>-2/`, `-3/`). Se o nome do arquivo já existe, acrescente `-2`; nada que já está em `evidencias/` é regravado. Corte antes de salvar: nenhum segredo, token, chave ou senha; nas amostras de log, troque endereços IP e identificadores de pessoas por marcadores.
9. **Proponha as próximas ações.** Para cada lacuna, use o Como implementar do bloco, na ordem do plano da maestra: primeiro o risco alto que destrava a venda, depois o Essencial que falta, depois o Fornecedor e por fim o Big tech. No Essencial, vêm antes a porta de administração ou de banco aberta à internet (OPS-03, OPS-15), a guarda dos registros de acesso pelo prazo do Marco Civil (OPS-05) e as correções atrasadas (OPS-08). O plano consolidado fica em `.security-standard/plano.md`.
10. **Responda ao usuário.** Cite cada controle pelo id, com o nível, o parâmetro do nível alvo, as linhas dos perfis do projeto e o tipo das fontes (`primária`, `secundária` ou `proposta`); diga quais números são proposta da skill. Nada desta skill vai para `docs/seguranca/`: o dossiê para o cliente sai da `security-customer-evidence`, só com o que está atendido, e do teste de intrusão vai só o resumo executivo.

## Controles desta skill

| Id | Título | Nível mínimo | Perfis |
|---|---|---|---|
| OPS-01 | Hardening e imagens mínimas | Essencial | todos |
| OPS-02 | Segmentação da rede e zero trust | Essencial | todos |
| OPS-03 | Exposição mínima e firewall de aplicação | Essencial | todos |
| OPS-04 | TLS e cabeçalhos de segurança | Essencial | todos |
| OPS-05 | Logs centralizados com retenção por nível | Essencial | todos |
| OPS-06 | Relógio sincronizado e logs protegidos | Essencial | todos |
| OPS-07 | Monitoramento e alerta | Essencial | todos |
| OPS-08 | Vulnerabilidades e correções da infraestrutura | Essencial | todos |
| OPS-09 | Postura da nuvem e infraestrutura como código verificadas | Essencial | todos |
| OPS-10 | Inventário de ativos | Essencial | todos |
| OPS-11 | Proteção contra DDoS | Fornecedor | todos |
| OPS-12 | Limites de taxa | Fornecedor | todos |
| OPS-13 | Teste de recuperação da infraestrutura | Fornecedor | todos |
| OPS-14 | Produção isolada dos outros ambientes | Essencial | todos |
| OPS-15 | Acesso administrativo só por canal seguro | Essencial | todos |
| OPS-16 | Teste de intrusão anual por terceiro independente | Essencial | todos |

Tabela gerada a partir dos blocos de `references/controles-ops.md`; se um bloco mudar, a tabela muda junto. No campo Mapa dos blocos, `CAIQ: LOG-09` e afins são identificadores do CCM/CAIQ v4.1, não controles deste catálogo.

## Erros comuns

- **Dar 1 ano de logs como exigência legal de todo projeto.** O Marco Civil pede 6 meses dos registros de acesso a aplicações (art. 15); 1 ano é dos registros de conexão, só de quem provê acesso à internet (art. 13). No Fornecedor, os demais eventos de segurança ficam ao menos 90 dias (CIS v8.1, 8.10); os 12 meses da PCI DSS 10.5.1 só obrigam no perfil cartoes (OPS-05).
- **Ler a Res. CMN 4.893 como prazo único para todo log, ou dizer que ela não fala em 5 anos.** Os 5 anos do art. 23 cobrem os documentos da instituição e também os dados e registros dos mecanismos de acompanhamento e de controle do art. 21, entre eles as trilhas de auditoria (inciso VIII, com o art. 21, I); o art. 3º, § 7º, não fixa prazo para as trilhas do processamento. Pergunte ao cliente que prazo o contrato exige dos registros que o serviço gera (OPS-05).
- **Confiar na retenção padrão do provedor.** São 90 dias no histórico do CloudTrail e 180 no Purview Audit Standard: exporte os logs para cumprir o prazo do nível (OPS-05).
- **Esquecer a porta lógica de origem nos registros de acesso.** O Decreto 8.771, art. 15-A, incluído pelo Decreto 12.975/2026, pede a porta quando ela é necessária para identificar o terminal (OPS-05).
- **Tratar os números da PCI DSS como regra de todo projeto.** Varredura a cada 3 meses, correção crítica em um mês e 12 meses de log obrigam quem trata cartão. Fora do perfil cartoes, vale o maior entre a lei, o CIS v8.1 do nível (o IG1 no Essencial e o IG2 no Fornecedor) e a regra dos outros perfis do projeto, cada um no que ele cobre; o número da PCI só entra como proposta, onde nenhum deles fixa número.
- **Dizer que a Circular SUSEP 638 exige teste de intrusão anual.** Ela não fixa o teste nem a frequência; o teste anual por terceiro entra pelo Fornecedor (CIS v8.1, 18.2, e CCM, TVM-07), o nível que a skill propõe para o perfil seguros (OPS-16).
- **Achar que a regra do BCB obriga o fornecedor diretamente.** O art. 22-A obriga a instituição, e o teste tem de ser contratado por ela: o teste do próprio fornecedor não cumpre a regra. A cláusula é aceitar que o teste do cliente cubra o serviço; o relatório do fornecedor serve à verificação prévia (OPS-16).
- **Confundir varredura de vulnerabilidades com teste de intrusão.** A varredura acha o que já é conhecido (OPS-08); o teste de intrusão encadeia falhas e é feito por pessoa independente (OPS-16).
- **Pedir o pré-carregamento do HSTS.** O hstspreload.org não o recomenda mais; o que conta é o HSTS do DAT-03 em todo endpoint público (OPS-04).
- **Repetir com outro número um tema de outra família.** TLS e HSTS são do DAT-03, backup do DAT-06, RPO e RTO do DAT-07, o que não entra no log do DAT-11, os prazos de correção do DEV-09 e a separação dos dados de cada cliente do DEV-23: cite o id de lá.
- **Deixar SSH, RDP ou porta de banco aberta à internet com a desculpa da senha forte.** A porta sai da internet, e o acesso vai pelo canal do OPS-15.
- **Apresentar declaração como verificação**, ou citar número `(proposta)` como exigência.
- **Pôr em `docs/seguranca/` o relatório completo do teste de intrusão, saída de scanner, lista de endereços ou o checklist de hardening.**
- **Rodar varredura ou teste contra sistema de terceiros**, ou contra o próprio sistema sem autorização escrita de quem responde por ele.

## Arquivos

- `references/controles-ops.md`: os 16 controles; fonte de verdade da família.
- `assets/checklist-de-hardening.md`: modelo do checklist (inventário e superfície pública, componentes, rede e ambientes, borda, administração, logs e alertas, postura da nuvem, testes e o que cada perfil soma).
- No projeto do usuário: `.security-standard/checklist-de-hardening.md`, as linhas OPS de `.security-standard/lacunas.md` e `.security-standard/evidencias/<AAAA-MM-DD>/`.
- Skills vizinhas: `security-standard` (maestra), `security-identity-access` (MFA, acesso privilegiado por pedido, registro do acesso administrativo, dispositivo gerenciado), `security-secure-development` (prazos de correção do DEV-09, credenciais e dados por ambiente do DEV-12, login do DEV-21, separação dos dados de cada cliente do DEV-23, varredura no CI), `security-data-encryption` (TLS e HSTS do DAT-03, backup do DAT-06, RPO e RTO do DAT-07, o que não entra no log do DAT-11), `security-incident-continuity` (plano de incidentes, roteiro de DDoS e continuidade), `security-automated-checks` (Trivy, Checkov e cabeçalhos) e `security-customer-evidence` (dossiê).
