---
type: regex
pattern: '^[ \t]*\|?[ \t]*[^\w|\n]{0,4}[A-Z]{3}-\d{2}(?![.\d])[^|\n]*\|(?:[^|\n]*\|)*?[ \t]*[^\w|\n]{0,4}[ \t]*(?:ausente|parcial(?:mente\s+atendid\w*)?\b|planejad|pendente|em\s+(?:implanta|andamento|defini)|n[ãa]o\s+(?:atendid|implementad))[^|\n]*(?:\||$)'
flags: im
match: not_contains
---

O dossiê não traz controle que não está atendido. O padrão casa só a afirmação errada: uma linha de tabela do dossiê, com ou sem a barra no começo e no fim, que tenha:
- primeira célula que começa pelo id de um controle (três letras, hífen e dois dígitos, como IAM-01), com ou sem negrito e com ou sem o título na mesma célula, como no catálogo (`IAM-01 — MFA resistente a phishing`);
- uma célula que começa por uma situação de lacuna: "ausente", "parcial", "parcialmente atendido", "planejado", "pendente", "em implantação", "em andamento", "em definição", "não atendido" ou "não implementado". Valem até quatro sinais antes, como negrito ou emoji ("| IAM-01 | MFA | 🟡 Parcial |", "IAM-03 | Acesso | Planejado").

Não casa a resposta certa que:
- explica a exclusão em texto corrido ("ficaram de fora 2 controles parciais e 3 ausentes") ou em lista com marcadores ("- IAM-02 saiu do dossiê: agora está parcial");
- cita uma linha entre crases no meio do texto ("A maestra marcou `| IAM-03 | … | parcial |`");
- lista numa tabela as perguntas que ficaram com a equipe, porque a primeira célula é o id da pergunta ("| BCR-08.1 | DAT-06 | parcial |", "| 2 | DAT-09 | parcial |");
- tem uma tabela de contagem sem id ("| parcial | 2 |");
- tem uma célula de linha atendida que só começa parecida ("parcialmente a cargo do provedor").

Limites conhecidos:
- não pega a linha com o id fora da primeira célula, como `| MFA | IAM-01 | Parcial |` ou uma primeira coluna numerada (`| 1 | IAM-01 | … | Parcial |`);
- não pega o link com texto antes do id (`[Controle IAM-01](…)`) nem o link em HTML; o link que começa pelo id (`[IAM-01](…)`) é pego;
- não pega a situação na primeira célula (`| **parcial** | IAM-01 |`), nem a situação com cinco sinais ou mais antes (negrito e emoji juntos);
- reprovaria uma tabela que listasse os controles excluídos pelo id e com a situação. Por isso a skill manda dar a contagem e só os ids.
