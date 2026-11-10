> Gerado pela security-standard-skill em {{data}} · revisar antes de usar

# Lacunas de segurança

Interno: não sai da empresa nem vai para `docs/seguranca/`. Nível alvo: {{nivel_alvo}}. Perfis: {{perfis}}. Avaliado em: {{data}}.

- Entra o controle com nível mínimo até o nível alvo e com `Perfis` igual a `todos` ou com um perfil do projeto; o controle de `excluir` entra como `não se aplica`, com o motivo.
- Quando o trecho do nível alvo no `Parâmetro` só traz regra "no perfil X" e o projeto não tem o perfil X, a linha fica `não se aplica`, tipo `declarada` (os perfis são declaração do usuário no `config.yml`), com o motivo "regra só do perfil X". Com o perfil X, a regra do perfil vale em qualquer nível alvo.
- situação: `atendido`, `parcial`, `ausente` ou `não se aplica`.
- tipo de evidência: `verificada` (lida no projeto pelo agente ou por ferramenta), `documento` (entregue pelo usuário, em `evidencias/`), `declarada` (só a palavra do usuário) ou `—` (pergunta sem resposta; só com `ausente`).
- Nenhuma linha fica `atendido` sem evidência e sem o tipo dela.

| id | título | nível | situação | tipo de evidência | evidência | próxima ação |
|---|---|---|---|---|---|---|
| {{id}} | {{título do controle}} | {{nível mínimo}} | {{situação}} | {{tipo}} | {{o quê, onde e quando}} | {{próxima ação, ou — quando atendido}} |
