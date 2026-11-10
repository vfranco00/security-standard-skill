---
type: regex
pattern: '\bSLSA\b(?:\s+v?1\.\d)?\s+(?:Build\s+)?(?:L|Level\s*|n[íi]vel\s*)[1-3]\b|\bn[íi]vel\s*[1-3]\s+do\s+SLSA\b'
flags: i
---

A resposta dá o nível de build do SLSA (L1, L2 ou L3), não só o nome do SLSA.
