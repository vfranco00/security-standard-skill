---
type: regex
pattern: '`financeiro`|\bperfi[ls]\b(?!\s+de\s+(?:acesso|usu[áa]rios?))[^\n]{0,40}\bfinanceiro\b|\bfinanceiro\b[^\n]{0,20}\(perfil\)|\bperfis?\s*:[^\n]*\bfinanceiro\b'
flags: i
---
A resposta liga o perfil financeiro, porque o cliente é um banco. Não basta citar dado financeiro, setor financeiro, perfil de acesso ou perfil de usuário.
