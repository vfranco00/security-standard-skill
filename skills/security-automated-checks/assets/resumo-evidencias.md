> Gerado pela security-standard-skill em {{data}} · revisar antes de usar

# Resumo das verificações automáticas

Interno: fica em `.security-standard/evidencias/{{pasta}}/`, fora do git, e não vai para `docs/seguranca/`. A pasta foi criada por esta rodada: as anteriores e os documentos do usuário ficam nas pastas deles, sem mudança. Rodaram só as ferramentas já instaladas, de forma passiva e local, sobre o próprio projeto. Os JSON do Trivy, do Checkov e do Semgrep ficam sem os trechos de código, e o arquivo com chave da AWS, chave privada ou `sk-…` foi apagado. A saída do gancho só passa por essa última conferência.

| ferramenta | situação | arquivo | achados por gravidade |
|---|---|---|---|
| {{ferramenta}} | {{rodou, ausente, pulado ou erro (saída N)}} | {{arquivo desta pasta, ou —}} | {{total e contagem por gravidade, com os rótulos da ferramenta, ou —}} |

## Avisos

- {{AUSENTE <ferramenta> (instale com: …), PULADO <item> (motivo), CONFERIR <item> (motivo), ERRO <ferramenta> (saída N; veja <arquivo>), APAGADO <arquivo> (motivo) ou INTERROMPIDO <ferramenta> (motivo)}}
