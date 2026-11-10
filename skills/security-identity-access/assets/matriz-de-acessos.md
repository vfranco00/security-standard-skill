> Gerado pela security-standard-skill em {{data}} · revisar antes de usar

# Matriz de acessos

Documento interno: tem nomes e acessos e fica em `.security-standard/matriz-de-acessos.md`, fora de `docs/seguranca/`. Se o arquivo já existe, atualize-o no lugar; nunca copie este modelo por cima. Atualize a cada entrada, mudança de função, saída e revisão; as seções 4, 7 e 8 são registro: só recebem linhas novas e nunca são regravadas inteiras. Os ids entre parênteses são os controles da skill `security-identity-access`.

Nunca escreva aqui senha, chave, token, código de recuperação nem outro segredo: registre só onde a credencial fica e quem pode usá-la.

- Projeto: {{projeto}}
- Nível alvo: {{nivel_alvo}} · Perfis: {{perfis}}
- Responsável pela matriz: {{responsavel}}
- Última revisão completa: {{data_da_revisao}} · Próxima: {{data_da_proxima_revisao}} (IAM-04)

## 1. Sistemas

| Sistema | Tipo (nuvem, provedor de identidade, repositório, banco, CI, monitoramento, outro) | Entra por SSO? (IAM-02) | MFA exigido e tipo (IAM-01) | Onde ficam os registros de acesso (IAM-12) | Dono do sistema |
|---|---|---|---|---|---|
| {{sistema}} | {{tipo}} | {{sim, ou não e o motivo}} | {{qualquer segundo fator ou resistente a phishing}} | {{destino dos registros}} | {{pessoa}} |

## 2. Papéis

| Papel | Sistemas | O que permite | Privilegiado? | Quem aprova a concessão (IAM-03, IAM-04) |
|---|---|---|---|---|
| {{papel}} | {{sistemas}} | {{leitura, escrita, administração}} | {{sim ou não}} | {{pessoa ou papel}} |

## 3. Pessoas e acessos

| Pessoa | Vínculo (empregado, prestador, terceiro) | Função | Papel em cada sistema | Privilégio permanente na produção? (IAM-03) | Método de MFA (IAM-01) | Dispositivo gerenciado? (IAM-13) | Concedido em e aprovado por | Última revisão (IAM-04) |
|---|---|---|---|---|---|---|---|---|
| {{pessoa}} | {{vínculo}} | {{função}} | {{sistema: papel}} | {{sim ou não}} | {{método}} | {{sim ou não}} | {{data e aprovador}} | {{data}} |

## 4. Elevações de acesso à produção (IAM-03)

| Início (data e hora) | Pessoa | Sistema e papel | Justificativa ou chamado | Aprovador | Expira em | Encerrada em |
|---|---|---|---|---|---|---|
| {{início}} | {{pessoa}} | {{sistema e papel}} | {{motivo}} | {{outra pessoa}} | {{fim previsto}} | {{fim real}} |

## 5. Contas de serviço, chaves de API e tokens (IAM-09, IAM-07)

| Conta, chave ou token | Sistema | Finalidade | Dono | Escopo | Criada em | Última revisão (IAM-04) | Última troca | Último uso | Pessoa entra com a credencial dela? |
|---|---|---|---|---|---|---|---|---|---|
| {{nome}} | {{sistema}} | {{para quê}} | {{pessoa}} | {{permissões}} | {{data}} | {{data}} | {{data}} | {{data}} | {{não; só no Essencial do perfil cartoes, a exceção aprovada com prazo}} |

## 6. Conta raiz e contas de emergência (IAM-10, IAM-05)

| Conta | Provedor | Fator | Onde fica a credencial (o local, nunca o valor) | Quem pode usar | Alerta de login configurado? | Último teste | Último uso e revisão |
|---|---|---|---|---|---|---|---|
| {{conta}} | {{provedor}} | {{tipo de fator}} | {{local}} | {{pessoas}} | {{sim ou não}} | {{data}} | {{data e resultado}} |

## 7. Revisões de acesso (IAM-04)

| Data | Revisor | Escopo (sistemas, pessoas, contas de serviço) | Acessos mantidos | Acessos retirados | Próxima revisão |
|---|---|---|---|---|---|
| {{data}} | {{pessoa}} | {{escopo}} | {{quantidade}} | {{quais}} | {{data}} |

## 8. Desligamentos (IAM-08)

| Pessoa | Comunicação da saída (data e hora) | Sistema | Acesso retirado em (data e hora) | Segredos compartilhados trocados | Conferido por |
|---|---|---|---|---|---|
| {{pessoa}} | {{data e hora}} | {{sistema}} | {{data e hora}} | {{quais, ou nenhum}} | {{pessoa}} |

## 9. Acessos a ambientes de clientes (IAM-14, perfil financeiro)

| Cliente | Pessoa | Sistemas do cliente | Função | Validade do contrato | MFA no acesso externo | Lista enviada ao cliente em | Retirada pedida em |
|---|---|---|---|---|---|---|---|
| {{cliente}} | {{pessoa}} | {{sistemas}} | {{função}} | {{data}} | {{método}} | {{data}} | {{data, quando houver}} |
