# Como contribuir

Toda mudança segue quatro regras.

1. **Nenhuma citação sem fonte.** Toda lei, norma, guia ou documento citado numa skill tem uma linha na tabela consolidada `skills/security-standard/references/fontes.md`, com a URL oficial e a data da conferência. O que um controle cita fica também no campo Fontes do bloco dele, em `skills/<skill>/references/controles-<familia>.md`, com o tipo (formato em `docs/formato-dos-controles.md`).
2. **Rode `bash scripts/lint-skills.sh` antes do PR.** Se mexeu num controle, rode também `python3 scripts/lint-controles.py`; se mexeu em fontes, `bash scripts/verificar-fontes.sh`. O CI roda os três.
3. **Português do Brasil** no texto das skills e da documentação. A `description` pode trazer palavras-chave também em inglês.
4. **Neutralidade.** Nenhuma empresa, produto, cliente ou pessoa real como exemplo; provedor público só com documento oficial dele listado nas fontes.

Para propor, abra uma issue ou um pull request pequeno, com uma mudança por vez.
