---
name: security-incident-continuity
description: Prepara a resposta a incidentes e a continuidade de um projeto de software no padrão que grandes clientes cobram de fornecedores, com os controles IRC-01 a IRC-11, cada um com nível (Essencial, Fornecedor, Big tech), parâmetro e fonte. Cobre plano de resposta com papéis e contatos, classificação, aviso ao cliente, à ANPD e aos titulares (3 dias úteis, pelo controlador), registro de incidentes por 5 anos, pós-incidente, exercício anual, plano de continuidade com RPO e RTO, comunicação de crise, contato de segurança e aprendizado que volta ao catálogo, com modelos dos dois planos e do registro. Use para escrever o plano de incidentes, saber quem avisar e em quanto tempo ou responder às perguntas de incidente e continuidade de um questionário; a lgpd-skill, se instalada, cuida do detalhe da ANPD e dos titulares (incident response plan, breach notification, data breach, business continuity, disaster recovery, RPO, RTO, tabletop exercise, postmortem, crisis communication, security contact).
license: MIT
metadata:
  version: "0.1.0"
  catalogo: "2026-11-09"
---

# Resposta a incidentes e continuidade

Prepara a empresa para o incidente antes que ele aconteça e diz, quando ele acontece, quem avisa quem e em quanto tempo. Trabalha com 11 controles, IRC-01 a IRC-11, em `references/controles-irc.md`: cada um com nível mínimo, perfis, parâmetro verificável e fontes com tipo, URL e data.

## Quando usar

- Pedido para escrever ou revisar o plano de resposta a incidentes ou o plano de continuidade, ou para saber quem avisar e em quanto tempo.
- Questionário de segurança (CAIQ, SIG, anexo de um cliente) com perguntas de incidente, aviso, registro, continuidade, RPO e RTO, exercício ou contato de segurança.
- Incidente acontecendo agora (credencial vazada, dados enviados à pessoa errada, ransomware, acesso indevido, sistema fora do ar): o passo 3 do Roteiro vem primeiro.
- A skill `security-standard` (a maestra) chegou à família IRC no plano.
- Cliente banco, instituição de pagamento, seguradora ou órgão público, ou sistema com dado de cartão ou de saúde: os perfis somam regras aos controles.

## O que esta skill não faz

- Não comunica nada a ninguém: prepara o plano, os prazos e os rascunhos. Quem comunica é o controlador: à ANPD, pelo encarregado ou por representante constituído (Res. CD/ANPD nº 15/2024, art. 6º, § 5º), e aos titulares (art. 9º, caput). O operador segue as instruções do controlador (LGPD, art. 39) e o avisa no prazo e pelo canal do contrato, porque a Res. CD/ANPD nº 15/2024 não fixa prazo para esse aviso.
- Não dá a palavra final sobre o risco relevante nem sobre a decisão de não comunicar: o encarregado ou um advogado revisa antes.
- Não faz perícia, contenção técnica nem teste contra sistema de terceiros, e não lê contas de nuvem: registra o que foi feito, com o tipo da evidência.
- Não trata a LGPD em detalhe: a avaliação do risco relevante, a comunicação à ANPD e o aviso aos titulares ficam com a `lgpd-skill` (skill `lgpd-incidentes`), se instalada; sem ela, esta skill dá o mínimo da seção "Quem avisamos e em quanto tempo". O registro do art. 10 da Res. CD/ANPD nº 15/2024 fica sempre também aqui (IRC-04).
- Não repete o que é de outras famílias: backup e restauração (DAT-06), RPO e RTO (DAT-07), devolução dos dados no fim do contrato (DAT-12), monitoramento e plantão (OPS-07), teste de recuperação da infraestrutura (OPS-13), `SECURITY.md` e `security.txt` (DEV-10). Cita esses ids.
- Não certifica nem afirma conformidade com a PCI DSS ou com norma do BCB, da SUSEP ou do GSI: diz o que está atendido, com evidência, e o que falta.

## Roteiro

1. **Leia o catálogo.** Abra `references/controles-irc.md`. Cada bloco traz Enunciado, Nível mínimo, Perfis, Parâmetro, Por quê, Fontes, Como verificar, Como implementar, Evidência e Mapa. Os níveis são cumulativos: o Fornecedor soma ao Essencial, e o Big tech soma aos dois. Os trechos `no perfil X`, dentro de um nível, somam regras quando o projeto tem o perfil; os do Essencial valem, portanto, em qualquer nível alvo. Número seguido de `(proposta)` é proposta da skill, sem fonte primária para o número; nunca o apresente como exigência.
2. **Leia o estado do projeto.** Se existir `.security-standard/`, leia `config.yml` (`nivel_alvo`, `perfis`, `excluir`), `inventario.md` e `lacunas.md`. Se não existir, sugira começar pela `security-standard`, que cria a pasta, o `.gitignore` e o inventário. Se o usuário quiser só esta família, crie `.security-standard/`, acrescente `.security-standard/` ao `.gitignore` e pergunte o nível alvo e os perfis. Se for só uma pergunta, sem projeto para ler, responda já, com o nível alvo pela regra da maestra (`../security-standard/references/niveis-e-perfis.md`): Fornecedor quando um cliente grande vai avaliar o fornecedor ou quando o cliente é banco, instituição de pagamento, seguradora ou órgão público; sem pista, Essencial. Diga que é uma suposição, mostre os trechos dos perfis como condicionais e pergunte quais perfis valem.
3. **Se o incidente está acontecendo, contenha já e depois conte o prazo.** A ordem é a do IRC-01: primeiro estancar o dano (SRE do Google, cap. 14).
   1. Na primeira resposta, mande conter sem apagar nada: revogar e trocar a credencial exposta, isolar da rede o que foi afetado e bloquear o acesso indevido. Prefira isolar a desligar, porque desligar perde a memória que a coleta forense usa (AWS SEC10-BP03).
   2. Preserve as evidências junto, sem atrasar a contenção: registros, cópias e snapshots são obrigatórios antes de apagar ou restaurar, não antes de isolar.
   3. Na mesma resposta, pergunte o que aconteceu, quando a equipe soube dele, quando soube que dados pessoais foram afetados, de quem são os dados e se o controlador é agente de pequeno porte (o porte que dobra os prazos é o do controlador). Dê as datas-limite pela tabela "Quem avisamos e em quanto tempo", com a contagem explicada abaixo dela.
   4. Acrescente a entrada no fim do registro (IRC-04); crie-o a partir do modelo só se o arquivo não existir.
   5. Os passos 4 a 12 ficam para depois do incidente.
4. **Descubra o papel em cada atividade.** É operador quando trata dados em nome do cliente, o caso comum de quem vende software a empresas; é controlador quando decide sobre os dados, como no cadastro dos próprios clientes e usuários ou dos funcionários. O papel decide quem comunica a ANPD e os titulares. Pergunte se o controlador se enquadra como agente de pequeno porte: o dobro dos prazos usa o porte do controlador (Res. CD/ANPD nº 15/2024, art. 6º, § 8º, e art. 9º, § 6º), então o porte da empresa só conta quando ela é a controladora (Res. CD/ANPD nº 2/2022, arts. 2º e 3º: fica de fora quem faz tratamento de alto risco ou passa do limite de receita, inclusive pelo grupo econômico).
5. **Selecione os controles.** Entram os de nível mínimo até o nível alvo e com Perfis `todos` ou com um dos perfis do projeto. IRC-06, IRC-08 e IRC-10 começam no Fornecedor; os outros oito, no Essencial. Em cada controle, valem o parâmetro do nível alvo e os trechos dos perfis do projeto. Controle listado em `excluir` fica como `não se aplica`, tipo `declarada`, com o motivo do `config.yml` na evidência.
6. **Leia o que dá para ler, sem acessar contas.** No repositório: `docs/` e `docs/seguranca/` (plano existente, política de backup), `SECURITY.md`, a página de segurança do site e os contratos ou anexos de segurança versionados. Em `.security-standard/`: `politica-de-backup-e-recuperacao.md` (o RPO e o RTO do DAT-07) e as evidências. O que for lido assim é evidência `verificada`.
7. **Pergunte o resto de uma vez, por controle.** Use o Como verificar de cada bloco: plano atual, lista de contatos, cláusulas de aviso dos contratos, incidentes do último ano com as datas, último exercício e plano de continuidade. O que vier anexado é `documento`; o que for só resposta é `declarada`.
8. **Gere os documentos sem sobrescrever nada.** Antes de copiar um modelo de `assets/`, confira se o arquivo já existe no projeto. Se não existe, preencha o modelo (`plano-de-resposta-a-incidentes.md`, `plano-de-continuidade.md` ou `registro-de-incidentes.md`), trocando `{{data}}` pela data de hoje. Se existe, atualize-o no lugar, mantendo o que está lá, e mostre ao usuário o que mudou. O registro de incidentes e os relatórios pós-incidente e de exercícios só recebem entradas novas: nunca regrave o que já está escrito. Mostre os planos ao usuário e, com a aprovação dele, grave-os em `docs/seguranca/`, que pode ir para o cliente, só com papéis e canais de grupo; nessa cópia, as seções 7 e 8 do plano ficam só com o modelo e, por relatório ou exercício, a data, o tipo e "relatório interno feito", e os relatórios preenchidos vão para `.security-standard/evidencias/<AAAA-MM-DD>/`. O Anexo A do plano (nomes, telefones pessoais, contatos por cliente) vai para `.security-standard/contatos-de-incidente.md`. O registro vai para `.security-standard/registro-de-incidentes.md`, sempre com o conteúdo mínimo do art. 10, mesmo com a `lgpd-skill` instalada, e com a referência ao registro de `.lgpd/incidentes/` quando ele existir; a cópia oficial fica num lugar durável (IRC-04).
9. **Registre as lacunas.** Em `.security-standard/lacunas.md`, uma linha por controle selecionado, no formato da maestra: `id | título | nível | situação | tipo de evidência | evidência | próxima ação`. Situação: `atendido`, `parcial`, `ausente` ou `não se aplica`. Tipo de evidência: `verificada`, `documento`, `declarada` ou `—` (pergunta sem resposta, só com `ausente`). Nunca marque `atendido` sem a evidência e o tipo dela.
10. **Guarde as evidências.** Em `.security-standard/evidencias/<AAAA-MM-DD>/`, com o id no nome do arquivo (`IRC-06-exercicio-de-mesa.md`). Se a pasta do dia tem `resumo.md`, ela é de uma rodada da `security-automated-checks`: use a próxima sem `resumo.md` (`<AAAA-MM-DD>-2/`, `-3/`). Se o nome do arquivo já existe, acrescente `-2`; nada que já está em `evidencias/` é regravado. Nada de nomes de titulares, segredos ou dados dos clientes.
11. **Proponha as próximas ações.** Para cada lacuna, use o Como implementar do bloco, na ordem do plano da maestra: primeiro o risco alto que destrava a venda, depois o Essencial que falta, depois o Fornecedor e por fim o Big tech. No Essencial, vêm antes o plano com os contatos (IRC-01), a tabela de avisos (IRC-03 e IRC-11), o registro (IRC-04) e o canal de segurança (IRC-09). O plano consolidado fica em `.security-standard/plano.md`.
12. **Responda ao usuário.** Cite cada controle pelo id, com o nível, o parâmetro do nível alvo, os trechos dos perfis do projeto e o tipo das fontes (`primária`, `secundária` ou `proposta`); diga quais números são proposta da skill. Para "quem avisamos e em quanto tempo", use a tabela abaixo, separando operador e controlador, e diga se a `lgpd-skill` está instalada.

## Quem avisamos e em quanto tempo

Os prazos em dias úteis contam do conhecimento, pelo controlador, de que o incidente afetou dados pessoais (Res. CD/ANPD nº 15/2024, art. 6º, § 1º, e art. 9º, caput), não da data do incidente nem do fim da apuração. Conte pelo lado seguro: sem o dia do conhecimento, com o do vencimento e sem contar com prorrogação. A regra oficial mais próxima é a da Res. CD/ANPD nº 1/2021, art. 8º (sem o dia do começo, com o do vencimento e prorrogação quando não há expediente na ANPD), que a Res. CD/ANPD nº 15/2024, art. 11, parágrafo único, aplica ao processo de comunicação no que couber; a contagem exata é ponto de revisão jurídica.

| Quem avisa | Quem recebe | Quando | Prazo | Controle |
|---|---|---|---|---|
| Fornecedor que trata os dados do cliente (operador) | o cliente, pelo canal do contrato | todo incidente que afete os dados ou o serviço dele | imediatamente, assim que souber; se o contrato não fixar prazo, até 24 horas de quando soube (proposta) | IRC-03 |
| Controlador | ANPD, no canal que ela indica, pelo encarregado (com o documento do vínculo) ou por representante (com o instrumento de poderes), entregues no mesmo prazo | incidente que possa acarretar risco ou dano relevante aos titulares (art. 5º: as duas condições juntas) | 3 dias úteis; 6 se o controlador for agente de pequeno porte; complemento em 20 dias úteis (40 no pequeno porte) | IRC-03 |
| Controlador | titulares afetados | o mesmo incidente | 3 dias úteis; 6 se o controlador for agente de pequeno porte; se não der para avisar cada um, pelos meios de divulgação de que dispõe, por no mínimo 3 meses; declaração à ANPD até 3 dias úteis depois do fim do prazo | IRC-11 |
| Controlador (e o operador, como prova do aviso, por proposta da skill) | registro de incidentes | todo incidente, comunicado ou não | guarda por no mínimo 5 anos da data do registro | IRC-04 |
| Fornecedor (perfil financeiro) | instituição autorizada pelo BCB | incidente que afete o serviço dela | a tempo de ela registrar, analisar e comunicar o BCB de forma tempestiva; limitações do serviço informadas sempre | IRC-03 |
| Fornecedor (perfil seguros) | seguradora | incidente relevante | a tempo de ela comunicar à SUSEP em até 5 dias úteis do conhecimento | IRC-03 |
| Fornecedor de nuvem (perfil setor-publico) | órgão federal | incidente cibernético contra os serviços ou os dados sob custódia | imediatamente | IRC-03 |
| Quem trata dado de cartão (perfil cartoes) | bandeiras e adquirentes | o que o plano de resposta prevê | pelos procedimentos das bandeiras | IRC-01 e IRC-03 |

- **Com a `lgpd-skill`.** Se a skill `lgpd-incidentes` estiver disponível, carregue-a para avaliar o risco relevante e montar a comunicação à ANPD (12 informações) e o aviso aos titulares (7 informações). Esta skill fica com o plano, o aviso ao cliente, a continuidade e o resto da família. O registro daqui (IRC-04) guarda sempre o conteúdo mínimo do art. 10, com ou sem a pasta `.lgpd/` iniciada, e só acrescenta a referência ao registro de `.lgpd/incidentes/` quando ele existe: assim nada fica só na conversa.
- **Sem a `lgpd-skill`.** Use a tabela acima e as listas da seção 5 de `assets/plano-de-resposta-a-incidentes.md`: as 12 informações à ANPD (Res. CD/ANPD nº 15/2024, art. 6º, § 2º) e as 7 ao titular (art. 9º). A comunicação vai com o documento que comprova o vínculo do encarregado ou com o instrumento de poderes do representante, entregue no mesmo prazo; sem ele, a ANPD pode apurar o incidente (art. 6º, §§ 5º a 7º). Prazo previsto em legislação específica fica ressalvado (art. 6º, caput), e a ANPD pode determinar, caso a caso, que o agente de pequeno porte cumpra as obrigações flexibilizadas (Res. CD/ANPD nº 2/2022, art. 16). Diga ao usuário que a `lgpd-skill` cobre o detalhe e marque o rascunho para revisão do encarregado ou de um advogado.

## Controles desta skill

| Id | Título | Nível mínimo | Perfis |
|---|---|---|---|
| IRC-01 | Plano de resposta a incidentes com papéis e contatos | Essencial | todos |
| IRC-02 | Classificação de incidentes | Essencial | todos |
| IRC-03 | Prazos de aviso ao cliente e à ANPD | Essencial | todos |
| IRC-04 | Registro de incidentes por 5 anos | Essencial | todos |
| IRC-05 | Pós-incidente com causa e ação | Essencial | todos |
| IRC-06 | Exercício anual de resposta e de continuidade | Fornecedor | todos |
| IRC-07 | Plano de continuidade com RPO e RTO | Essencial | todos |
| IRC-08 | Comunicação de crise | Fornecedor | todos |
| IRC-09 | Contato de segurança publicado | Essencial | todos |
| IRC-10 | Aprendizado alimenta o catálogo | Fornecedor | todos |
| IRC-11 | Aviso de incidente aos titulares | Essencial | todos |

Tabela gerada a partir dos blocos de `references/controles-irc.md`; se um bloco mudar, a tabela muda junto. As regras dos perfis `financeiro`, `seguros`, `setor-publico`, `cartoes` e `saude` estão no Parâmetro de cada bloco, nos trechos `no perfil X`. No campo Mapa, `CAIQ: SEF-07` e afins são identificadores do CCM/CAIQ v4.1, não controles deste catálogo.

## Erros comuns

- **Segurar a contenção para contar prazos, abrir o registro ou tirar cópias.** No incidente em curso, contenha primeiro, sem apagar nada; as evidências se preservam junto, e são obrigatórias antes de apagar ou restaurar, não antes de isolar (passo 3).
- **Dar à ANPD o prazo de "2 dias úteis" ou de "72 horas".** O primeiro era a orientação antiga da ANPD; o segundo é do GDPR e de contratos de nuvem. A regra é 3 dias úteis (Res. CD/ANPD nº 15/2024, art. 6º), 6 no agente de pequeno porte.
- **Contar o prazo da data do incidente ou do fim da apuração.** Conta do conhecimento, pelo controlador, de que o incidente afetou dados pessoais (art. 6º, § 1º; art. 9º, caput).
- **Operador comunicar a ANPD ou os titulares por conta própria, ou esperar o fim da investigação para avisar o cliente.** O operador avisa o controlador já, com o que sabe, e segue as instruções dele (IRC-03, IRC-11).
- **Comunicar todo incidente por precaução, ou tratar dado sensível como risco relevante automático.** O art. 5º pede as duas condições juntas: poder afetar significativamente interesses e direitos fundamentais dos titulares e envolver ao menos um dos critérios.
- **Aplicar o dobro do pequeno porte a quem não se enquadra** (alto risco, receita acima do limite, grupo econômico: Res. CD/ANPD nº 2/2022, art. 3º), ou repetir a ressalva antiga do art. 14, II, que a Res. CD/ANPD nº 15/2024 tirou.
- **Dizer que o aviso coletivo aos titulares exige imprensa, rádio ou TV.** São os meios de divulgação de que o controlador dispõe; a ampla divulgação em meios de comunicação é providência que a ANPD pode determinar (Res. CD/ANPD nº 15/2024, art. 9º, § 3º, e art. 19).
- **Registrar só o incidente comunicado, ou guardar o registro só na pasta local ignorada pelo git.** Todo incidente entra, e a cópia oficial precisa durar 5 anos (IRC-04).
- **Apresentar as 24 horas do aviso ao cliente como exigência legal.** É proposta da skill para quando o contrato não fixa prazo; as fontes dizem "imediatamente".
- **Tratar a regra do BCB, da SUSEP ou do GSI como obrigação direta do fornecedor.** Elas obrigam o cliente, que as leva ao contrato; a skill nunca diz que o fornecedor cumpre a norma.
- **Usar RPO e RTO diferentes dos do DAT-07, ou chamar o teste de restauração de exercício de incidente.** O plano de continuidade usa os números do DAT-07; o exercício (IRC-06) testa pessoas e decisões, e o OPS-13 testa a infraestrutura.
- **Pôr nomes, telefones pessoais, contas, o registro de incidentes ou lacunas em `docs/seguranca/`.**

## Arquivos

- `references/controles-irc.md`: os 11 controles; fonte de verdade da família.
- `assets/plano-de-resposta-a-incidentes.md`: modelo do plano (papéis, papel por atividade, gravidade, passos, quem avisamos e em quanto tempo, com as 12 informações à ANPD e as 7 ao titular, comunicação de crise, relatório pós-incidente, exercícios e o Anexo A de contatos, interno).
- `assets/plano-de-continuidade.md`: modelo do plano de continuidade (sistemas críticos e dependências, RPO e RTO do DAT-07, análise de impacto, roteiros por cenário, saída do cliente, regras dos perfis e testes).
- `assets/registro-de-incidentes.md`: modelo do registro (índice, conteúdo mínimo da Res. CD/ANPD nº 15/2024, art. 10, avisos e prazos, guarda por 5 anos).
- No projeto do usuário: `docs/seguranca/plano-de-resposta-a-incidentes.md` e `docs/seguranca/plano-de-continuidade.md` (compartilháveis), `.security-standard/contatos-de-incidente.md`, `.security-standard/registro-de-incidentes.md`, as linhas IRC de `.security-standard/lacunas.md` e `.security-standard/evidencias/<AAAA-MM-DD>/`.
- Skills vizinhas: `security-standard` (maestra), `security-data-encryption` (DAT-06, DAT-07, DAT-12), `security-infra-operations` (OPS-07, OPS-13), `security-secure-development` (DEV-10), `security-customer-evidence` (dossiê) e, fora deste plugin, a `lgpd-skill` (skill `lgpd-incidentes`).
