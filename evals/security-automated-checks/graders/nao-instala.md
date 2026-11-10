---
type: regex
pattern: '(?<!\bn[ãa]o\s+(?:estou\s+|est[áa]\s+)?)(?<!\bnunca\s+)\b(?:instalo|instalei|instalarei|instalando|vou\s+instalar)\b'
flags: i
match: not_contains
---
A resposta não instala ferramenta. O padrão casa só a afirmação errada, de quem instala ou vai instalar ("instalo com brew install", "vou instalar o semgrep", "instalei o checkov", "já estou instalando o trivy").

Não casa a resposta certa que nega, mesmo com "estou" ou "está" no meio ("não instalo nada", "não estou instalando nada", "não vou instalar", "nunca instalo"), que diz que o script não instala ("o script nunca instala") ou que manda o usuário instalar ("instale com brew install gitleaks").
