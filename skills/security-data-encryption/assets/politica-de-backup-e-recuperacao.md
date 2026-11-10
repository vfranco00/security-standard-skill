> Gerado pela security-standard-skill em {{data}} · revisar antes de usar

# Política de backup e recuperação

{{empresa}} · versão {{versao}} · aprovada por {{aprovador}} em {{data_de_aprovacao}} · próxima revisão: {{data_da_proxima_revisao}}

Esta política fica em `.security-standard/politica-de-backup-e-recuperacao.md`; se o arquivo já existe, atualize-o no lugar e nunca copie este modelo por cima. Para mandá-la ao cliente, grave uma cópia em `docs/seguranca/`, atualizando a que já existir, sem a seção 8 e sem nome de banco, bucket, conta ou endereço interno. Os ids entre parênteses são os controles da skill `security-data-encryption`.

## 1. Objetivo e alcance

Proteger os dados de produção de {{sistema}} contra perda, corrupção, exclusão por engano e ransomware, e definir em quanto tempo e com que perda máxima eles voltam. Vale para: {{bancos de dados, arquivos, configurações e o lugar dos segredos (nunca o valor)}}.

## 2. Objetivos de recuperação (DAT-07)

| Sistema ou serviço | Crítico? | RPO (perda máxima de dados) | RTO (tempo máximo para voltar) | De onde vem o número (contrato, cliente ou padrão da skill) |
|---|---|---|---|---|
| {{sistema}} | {{sim ou não}} | {{RPO}} | {{RTO}} | {{origem}} |

O objetivo é o do contrato, quando ele fixa um. Sem número no contrato, use o do DAT-07 para o nível alvo e diga de onde ele vem: o RTO de 72 h do Fornecedor vem da exigência da Microsoft a fornecedores, e os demais números padrão são proposta da skill.

## 3. Cópias (DAT-06)

| Dado | Tipo de cópia (automática do banco, ponto no tempo, exportação) | Frequência | Onde fica (outra conta, projeto ou provedor; país e região) | Cifrada e com que chave | Imutável ou offline? | Retenção |
|---|---|---|---|---|---|---|
| {{dado}} | {{tipo}} | {{frequência que cumpre o RPO}} | {{destino}} | {{sim, chave no KMS}} | {{sim ou não}} | {{prazo}} |

Regras:

- Toda cópia é automática, completa e cifrada, com a chave no KMS (DAT-04), e é protegida como o dado original.
- Ao menos uma cópia fica isolada: fora do armazenamento principal, com credencial diferente da do sistema e sem sincronização em tempo real.
- A partir do nível Fornecedor, ao menos uma cópia é imutável ou offline: nem a conta administrativa do sistema consegue apagá-la antes do prazo.
- No perfil `setor-publico`, ao menos uma cópia atualizada fica no Brasil.

## 4. Testes de restauração (DAT-06, DAT-07)

- Frequência: {{uma vez por ano no Essencial (proposta da skill); a cada 3 meses no Fornecedor, com o teste do plano de recuperação inteiro uma vez por ano; automática e contínua no Big tech}}.
- Como: restaurar num ambiente separado, conferir os dados com consultas de controle, medir o tempo até o sistema funcionar (RTO medido) e a idade do dado mais novo recuperado (RPO medido) e, no fim, apagar o ambiente de teste.
- Resultado acima do objetivo abre uma correção, com dono e prazo.
- O registro de cada teste vai para a seção 8.

## 5. Roteiro de recuperação (DAT-07)

Passo a passo que uma pessoa que não conhece o sistema consiga seguir dentro do RTO:

1. {{como declarar a recuperação e quem avisar}}
2. {{onde achar a cópia certa e como escolher o ponto de restauração}}
3. {{como restaurar o banco e os arquivos}}
4. {{como apontar o sistema para os dados restaurados}}
5. {{como conferir que o sistema e os dados estão certos}}
6. {{como reaplicar as eliminações feitas depois da data da cópia (seção 6)}}

## 6. Eliminação e cópias (DAT-08, DAT-12, DAT-15)

- O dado eliminado por prazo ou a pedido do titular sai das cópias quando elas vencem, no prazo de retenção da seção 3.
- Antes de uma cópia restaurada voltar ao uso, as eliminações feitas depois da data dela são reaplicadas.
- No fim do contrato de um cliente, as cópias com os dados dele entram na eliminação, depois de ele confirmar que recebeu os dados íntegros.

## 7. Papéis

| Papel | Quem | O que faz |
|---|---|---|
| Dono da política | {{pessoa}} | aprova e revê ao menos uma vez por ano e a cada mudança de sistema, provedor ou contrato |
| Responsável pelas cópias | {{pessoa}} | configura as cópias e acompanha as falhas |
| Quem testa a restauração | {{pessoa}} | faz o teste, mede e registra |

## 8. Registro dos testes (interno, não vai ao cliente)

Só acrescente linhas: nunca regrave nem apague as anteriores, que são a evidência do DAT-06 e do DAT-07.

| Data | Cópia usada | Quem fez | RTO medido | RPO medido | Dentro do objetivo? | Problemas e correções |
|---|---|---|---|---|---|---|
| {{data}} | {{cópia}} | {{pessoa}} | {{tempo}} | {{idade do dado}} | {{sim ou não}} | {{o que mudou}} |
