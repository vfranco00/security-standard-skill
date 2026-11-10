---
type: regex
pattern: '`financeiro`|\bperfi[ls]\b(?!\s+de\s+(?:acesso|usu[áa]rios?))[^\n]{0,40}\bfinanceiro\b|\bfinanceiro\b[^\n]{0,20}\(perfil\)|\bperfis?\s*:[^\n]*\bfinanceiro\b'
flags: i
---

A resposta liga o perfil financeiro, porque o cliente é do setor financeiro. Não basta repetir o setor financeiro do prompt nem citar perfil de acesso ou de usuário.
