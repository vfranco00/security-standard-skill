> Gerado pela security-standard-skill em {{data}} · revisar antes de usar

# Registro de riscos, fornecedores e obrigações

Interno: fica em `.security-standard/registro-de-riscos.md` e não vai para `docs/seguranca/`. Avaliação completa em {{data}} · próxima: {{no máximo 12 meses depois}} · responsável: {{responsável pela segurança (GOV-02)}}.

Registro só de acréscimo: nenhuma linha é apagada e o arquivo nunca é regravado inteiro; a reavaliação de um risco, de um fornecedor ou de uma obrigação entra como linha nova, com a data, e a anterior fica. Como `.security-standard/` fica fora do git, guarde uma cópia durável deste registro num lugar com backup (repositório privado ou sistema de documentos da empresa); a cópia da pasta é a de trabalho.

## 1. Riscos (GOV-05)

Escala, proposta da skill: probabilidade 1 (rara), 2 (possível) ou 3 (provável); impacto 1 (baixo), 2 (médio: atraso, retrabalho, cliente insatisfeito) ou 3 (alto: vazamento de dado de cliente, parada longa, perda de contrato). Nível = probabilidade × impacto: 1 a 2 baixo, 3 a 4 médio, 6 a 9 alto.

Tratamento: mitigar (com o controle do catálogo), transferir (contrato ou seguro, GOV-16), evitar (deixar de fazer) ou aceitar. Risco aceito tem o nome de quem aceitou na direção e a data até quando vale.

Comece pelas linhas `ausente` e `parcial` de `lacunas.md` e por três perguntas: o que tira o sistema do ar, o que vaza dado de cliente e o que trava uma venda.

| id | risco | ativo ou processo | probabilidade | impacto | nível | tratamento | controle | dono | prazo | aceito por e até quando | revisto em |
|---|---|---|---|---|---|---|---|---|---|---|---|
| R-01 | {{o que pode acontecer e por quê}} | {{onde}} | {{1 a 3}} | {{1 a 3}} | {{nível}} | {{tratamento}} | {{id do controle}} | {{quem}} | {{data}} | {{nome e data, só se aceito}} | {{data}} |

## 2. Fornecedores (GOV-06)

Criticidade, proposta da skill: alta, quando o fornecedor trata dado de cliente ou acessa a produção e a falha dele afeta clientes; média, quando trata dado interno ou a parada dele atrapalha a operação; baixa, quando não trata dado nem tem acesso.

| fornecedor | serviço | dados e acesso | país (DAT-09) | criticidade | evidência de segurança lida (tipo, data e validade) | contrato ou termos (segurança, confidencialidade, aviso de incidente, acordo de tratamento) | na lista pública? (GOV-07) | última avaliação | próxima | contato |
|---|---|---|---|---|---|---|---|---|---|---|
| {{nome}} | {{o que faz}} | {{dados e tipo de acesso}} | {{país, região}} | {{alta, média ou baixa}} | {{relatório SOC 2, certificado ISO/IEC 27001 ou questionário; data; validade}} | {{o que o contrato prevê}} | {{sim ou não}} | {{data}} | {{data}} | {{nome ou e-mail}} |

## 3. Obrigações legais e contratuais (GOV-17)

Cada linha diz se a obrigação se aplica e por quê. O resultado se registra como `atendido` com evidência em `lacunas.md`, nunca como "aprovado" ou "conforme". As linhas de consumo vão ao jurídico; este catálogo não tem controle de segurança para elas.

| obrigação | origem | aplica-se? (sim ou não, e por quê) | o que exige | responsável | controle ou evidência | revista em |
|---|---|---|---|---|---|---|
| Proteção de dados pessoais | Lei 13.709/2018 (LGPD) | {{sim, se trata dado pessoal}} | {{segurança, direitos dos titulares, comunicação de incidente; o mapa dos dados e o registro das operações ficam na `lgpd-mapeamento-e-registro`, e o resto nas demais skills da `lgpd-skill`, se instalada}} | {{quem}} | {{ids}} | {{data}} |
| Registros de acesso e políticas de uso | Lei 12.965/2014 (Marco Civil da Internet), arts. 7º, XI, e 15 | {{sim, se é aplicação de internet com fins econômicos}} | {{registros de acesso guardados por 6 meses; políticas de uso públicas e claras}} | {{quem}} | OPS-05 | {{data}} |
| Consumidor | Lei 8.078/1990 (CDC) e, na contratação por comércio eletrônico, Decreto 7.962/2013 | {{sim, se há cliente, pessoa física ou jurídica, que usa o produto como destinatário final (CDC, art. 2º)}} | {{informação clara, com preço e tributos (CDC, art. 6º, III); arrependimento em 7 dias na contratação fora do estabelecimento (CDC, art. 49); regras do comércio eletrônico (decreto)}} | {{jurídico}} | {{evidência, sem controle de segurança}} | {{data}} |
| Cliente do setor financeiro | Res. CMN 4.893/2021 e Res. BCB 85/2021 | {{perfil financeiro}} | {{cláusulas do art. 17}} | {{quem}} | GOV-13 | {{data}} |
| Cliente do setor de seguros | Circular SUSEP 638/2021 | {{perfil seguros}} | {{exigências do art. 11}} | {{quem}} | GOV-13 | {{data}} |
| Órgão público federal | IN GSI/PR 5/2021 | {{perfil setor-publico}} | {{arts. 18, 19, 20 e 25}} | {{quem}} | GOV-13 | {{data}} |
| Dados de cartão | PCI DSS v4.0.1 | {{perfil cartoes}} | {{requisitos do escopo do cartão}} | {{quem}} | {{controles com o perfil cartoes}} | {{data}} |
| Crianças e adolescentes | Lei 15.211/2025 (ECA Digital) | {{se o produto pode ser usado por menores}} | {{detalhe na `lgpd-criancas-e-adolescentes`, da `lgpd-skill`, se instalada}} | {{quem}} | {{ids}} | {{data}} |
| Contratos com clientes | anexos de segurança e acordos de tratamento | {{sim, um por cliente com anexo}} | {{o que cada anexo exige}} | {{quem}} | GOV-12 | {{data}} |
