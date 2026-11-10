> Gerado pela security-standard-skill em {{data}} · revisar antes de usar

# Política de segurança da informação

{{empresa}} · versão {{versao}} · aprovada por {{aprovador}} em {{data_de_aprovacao}} · próxima revisão: {{data_da_proxima_revisao, no máximo 12 meses depois}}

Esta política vai para `docs/seguranca/politica-de-seguranca-da-informacao.md`: é o documento que o cliente recebe. A lista de ciência das pessoas, as exceções aprovadas e as verificações de antecedentes ficam em `.security-standard/evidencias/`, nunca aqui. Os ids entre parênteses são os controles do catálogo da security-standard-skill. A política descreve o que a empresa faz; não afirma certificação nem conformidade com norma.

## 1. Objetivo e alcance

Proteger a confidencialidade, a integridade e a disponibilidade das informações de {{empresa}} e dos clientes dela. Vale para {{produto e sistemas}}, para toda pessoa da equipe e para todo prestador com acesso a sistemas ou dados. {{Se a empresa tem a política simplificada de segurança da LGPD, escreva: Esta política incorpora, por referência, a política simplificada de segurança de <data>. Se não tem, apague este trecho.}}

## 2. Aprovação, divulgação e revisão (GOV-01)

- Quem dirige a empresa aprova cada versão.
- Toda pessoa e todo prestador com acesso lê e aceita a política na entrada e a cada versão nova.
- A política é revista ao menos uma vez por ano e a cada mudança relevante: produto novo, nuvem nova, cliente regulado ou incidente grave.
- As normas por tema (seção 6) seguem a mesma revisão.

## 3. Responsáveis (GOV-02, GOV-03)

- Responsável pela segurança da informação: {{nome ou função}}. Substituto: {{nome ou função}}.
- Atribuições: manter esta política, o registro de riscos, a avaliação dos fornecedores, o plano de resposta a incidentes e as respostas aos questionários dos clientes. Tem autoridade para suspender uma entrega insegura.
- Encarregado pelo tratamento de dados pessoais (LGPD): {{nome ou "a designar"}}. É uma designação à parte; a `lgpd-encarregado-e-governanca`, da `lgpd-skill`, se instalada, trata dela.

| Atividade | Executa | Aprova | É informado |
|---|---|---|---|
| Política e normas | {{quem}} | {{quem dirige a empresa}} | toda a equipe |
| Conceder e retirar acessos | {{quem}} | {{outra pessoa}} | {{quem}} |
| Deploy na produção | {{quem}} | {{revisor diferente do autor}} | {{quem}} |
| Cópias de segurança e restauração | {{quem}} | {{quem}} | {{quem}} |
| Incidentes | {{quem}} | {{quem}} | {{clientes, conforme contrato}} |
| Fornecedores e subprocessadores | {{quem}} | {{quem}} | {{clientes, pela lista pública}} |
| Respostas a questionários de clientes | {{quem}} | {{responsável pela segurança}} | {{quem}} |
| Registro de riscos e aceite de risco | {{quem}} | {{quem dirige a empresa}} | {{quem}} |

Separação de funções: ninguém concede acesso a si mesmo (IAM-03, IAM-04) nem aprova o próprio código para a produção (DEV-02), e quem administra a produção não apaga nem altera os registros de auditoria sem deixar rastro (OPS-06). Onde a equipe não permite separar: {{controle compensatório, por exemplo revisão posterior por outra pessoa, com data}}.

## 4. Pessoas (GOV-04, GOV-08, GOV-09)

- **Antes do primeiro acesso:** conferimos {{identidade, referências profissionais e o que mais a função pedir}}. Certidão de antecedentes criminais só para as funções em que a lei a preveja ou em que a natureza do ofício ou a fidúcia especial a justifique, depois de revisão jurídica: {{funções e motivo, ou "nenhuma"}}. Guardamos só o registro de que a verificação foi feita.
- **Confidencialidade:** toda pessoa e todo prestador assina o termo de confidencialidade antes do primeiro acesso. O dever continua depois do fim do vínculo.
- **Treinamento:** na admissão e ao menos uma vez por ano, com phishing e engenharia social, senhas e MFA, como reconhecer e avisar um incidente, manuseio dos dados pela classe, uso aceitável e as obrigações da LGPD. Subcontratados que atendem clientes também fazem.
- **Saída:** os acessos saem no mesmo dia da saída (IAM-08), e a pessoa recebe por escrito o lembrete do dever de confidencialidade.
- **Descumprimento:** sujeita a {{medidas, conforme o contrato de trabalho ou de prestação e a lei}}.

## 5. Uso aceitável e dispositivos (GOV-10)

- Equipamentos, contas e dados da empresa e dos clientes servem só ao trabalho. Software só o autorizado: {{lista ou regra}}. Mídia removível: {{proibida ou restrita a}}.
- Dado de cliente nunca vai para conta, serviço ou aparelho pessoal fora desta regra.
- Todo computador ou celular que acessa dados de clientes ou a produção está no inventário e tem atualização automática do sistema e dos aplicativos, antimalware ativo, bloqueio de tela em até 10 minutos no computador e em até 2 minutos no celular, disco cifrado e MFA nas contas.
- Dispositivo pessoal só acessa dados da empresa se cumprir o mesmo mínimo.
- Perda ou roubo: avise {{canal}} na hora, para o bloqueio ou o apagamento remoto.

## 6. Regras por tema

Cada tema tem uma norma com dono e revisão anual: {{onde ficam as normas}}.

- **Acesso e senhas (família IAM):** {{conta individual, MFA, menor privilégio, revisão periódica dos acessos, segredos fora do código}}.
- **Dados e criptografia (família DAT):** {{classificação, criptografia em repouso e em trânsito, chaves em KMS, cópias de segurança testadas, guarda e eliminação}}.
- **Desenvolvimento seguro (família DEV):** {{revisão por outra pessoa, varreduras no CI, prazos de correção por gravidade, política de divulgação}}.
- **Operação e registros (família OPS):** {{hardening, logs com retenção, monitoramento, correções da infraestrutura}}.
- **Incidentes e continuidade (família IRC):** {{plano de resposta, aviso aos clientes, continuidade e recuperação}}.
- **Fornecedores (GOV-06, GOV-07):** avaliamos a segurança antes de contratar e reavaliamos ao menos uma vez por ano; contratamos com cláusulas de segurança e de proteção de dados; publicamos a lista de subprocessadores e avisamos os clientes antes de mudá-la.

## 7. Riscos e obrigações (GOV-05, GOV-17)

Mantemos um registro interno dos riscos de segurança, com dono e prazo, e a lista das leis, normas e contratos que se aplicam ao produto, revistos ao menos uma vez por ano: {{LGPD, Marco Civil da Internet e o que mais se aplicar}}.

## 8. Revisão dos controles (GOV-14)

Ao menos uma vez por ano reavaliamos os controles de segurança com as evidências renovadas, e os achados entram no plano com dono e prazo.

## 9. Exceções

Exceção a esta política só por pedido escrito, com o risco, a medida que o compensa, quem aprovou e até quando vale, registrada pelo responsável pela segurança.

## 10. Histórico de versões

| Versão | Data | O que mudou | Aprovado por |
|---|---|---|---|
| {{versao}} | {{data}} | {{mudança}} | {{aprovador}} |
