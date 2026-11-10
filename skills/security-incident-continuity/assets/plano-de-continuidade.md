> Gerado pela security-standard-skill em {{data}} · revisar antes de usar

# Plano de continuidade do produto

Plano de continuidade do produto {{produto}}, da empresa {{empresa}} (IRC-07). O RPO e o RTO vêm do DAT-07; a restauração dos dados é testada no DAT-06, a da infraestrutura no OPS-13, e os roteiros são exercitados no IRC-06. Este documento pode ir para o cliente em `docs/seguranca/plano-de-continuidade.md`; nomes de contas, endereços internos, segredos e nomes de pessoas ficam fora dele.

- Versão: {{versão}} · Aprovado por: {{cargo}} em {{data_da_aprovacao}}
- Última revisão: {{data_da_revisao}} · Próxima: {{data_da_proxima_revisao}} (a cada 12 meses e a cada mudança de arquitetura ou de fornecedor crítico; IRC-07)
- Nível alvo: {{nivel_alvo}} · Perfis: {{perfis}}

## 1. Sistemas críticos e dependências

| Sistema | O que sustenta para o cliente | Dependências (nuvem e região, banco, fornecedores, pessoas) | RPO (DAT-07) | RTO (DAT-07) | Estratégia de recuperação (Fornecedor) |
|---|---|---|---|---|---|
| {{sistema}} | {{...}} | {{...}} | {{...}} | {{...}} | {{cópia e restauração, piloto, reserva aquecida ou várias regiões}} |

## 2. Análise de impacto no negócio (Fornecedor)

| Processo ou serviço | Impacto da parada (1 hora, 1 dia, 1 semana) | Clientes afetados | Tempo máximo tolerável | RPO e RTO que isso justifica |
|---|---|---|---|---|
| {{...}} | {{...}} | {{...}} | {{...}} | {{...}} |

## 3. Quem declara a contingência

- Declara: {{cargo}} · Substituto: {{cargo}}
- Critério: {{ex.: parada que vai passar do RTO, perda de dados, fornecedor crítico fora do ar}}
- Avisos: pela seção 5 do plano de resposta a incidentes (IRC-03) e pela comunicação de crise (IRC-08).

## 4. Roteiros por cenário

Em cada roteiro: gatilho, quem declara, passos de recuperação, tempo esperado contra o RTO e quem é avisado.

### 4.1 Perda da região ou da conta de nuvem

- Gatilho: {{...}}
- Passos: {{recriar a infraestrutura a partir da infraestrutura como código em outra região ou conta (OPS-13); restaurar os dados da cópia guardada fora da conta principal (DAT-06)}}
- Tempo esperado: {{...}} · RTO: {{...}}
- Quem é avisado: {{...}}

### 4.2 Perda ou cifragem dos dados (ransomware, exclusão)

- Gatilho: {{...}}
- Passos: {{isolar; preservar as evidências (plano de resposta, seção 4); restaurar da cópia imutável ou offline; conferir a integridade antes de voltar a operar}}
- Tempo esperado: {{...}} · RTO e RPO: {{...}}
- Quem é avisado: {{...}}

### 4.3 Parada de fornecedor crítico

| Fornecedor | O que faz para o produto | Alternativa ou modo degradado | Quem decide | Tempo para ativar |
|---|---|---|---|---|
| {{...}} | {{...}} | {{...}} | {{cargo}} | {{...}} |

### 4.4 Ausência de pessoa-chave

- Quem substitui cada papel: {{...}}
- Onde estão os roteiros e como funciona o acesso de emergência (IAM-05): {{...}}

### 4.5 Saída do cliente (Fornecedor)

- Formato e prazo da entrega de todos os dados do cliente para que ele troque de fornecedor (DAT-12): {{...}}
- Quem conduz: {{cargo}}

## 5. Regras dos perfis (apague as que não se aplicam)

- **financeiro:** o plano cobre a interrupção do serviço contratado e a substituição do fornecedor e cumpre o prazo de reinício que a instituição estipular (Res. CMN 4.893 e Res. BCB 85, art. 19, II, e art. 20, II). Prazo de reinício da instituição: {{...}}.
- **seguros:** a resposta entra no plano ao menos para ataques e outros eventos que danifiquem a infraestrutura de tecnologia ou os sistemas de comunicação críticos, acessem, modifiquem, excluam ou divulguem sem autorização dados relevantes ou interrompam serviço relevante de processamento ou de armazenamento de dados, e a seguradora define estratégia para substituir o prestador (Circular SUSEP 638, arts. 7º e 13).
- **setor-publico:** processos de gestão de continuidade e plano de recuperação de desastres com a restauração de plataforma, infraestrutura, aplicações e dados (IN GSI/PR 5/2021, art. 20, V e VI).

## 6. Testes e revisões

| Data | Tipo (exercício do IRC-06, restauração do DAT-06, recuperação do OPS-13) | Cenário | Tempo medido contra o RTO | Ações |
|---|---|---|---|---|
| {{data}} | {{...}} | {{...}} | {{...}} | {{...}} |
