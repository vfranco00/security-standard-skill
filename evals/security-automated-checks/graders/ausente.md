---
type: regex
pattern: '\bausentes?\b|n[ãa]o\s+(?:est[áa]\s+|est[ãa]o\s+|foi\s+|foram\s+)?instalad|\binstale\b|sem\s+instalar|comando\s+de\s+instala[çc][ãa]o'
flags: i
---
A resposta trata a ferramenta que falta: diz que ela está ausente (AUSENTE, ausente, não instalada) ou que a skill só informa como instalar (instale com, o comando de instalação, sem instalar). Quem confere que a resposta não instala nada é o `nao-instala.md`.
