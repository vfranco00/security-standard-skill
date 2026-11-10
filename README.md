# security-standard-skill

## O que é

Padrão de segurança para projetos de software, no nível das big techs e das exigências das grandes empresas a fornecedores: catálogo de controles com fonte, análise de lacunas, plano priorizado, modelos de políticas, dossiê de segurança para clientes e verificação automática com ferramentas abertas.

Plugin de skills no formato aberto [Agent Skills](https://github.com/agentskills/agentskills): cada pasta de `skills/` traz um `SKILL.md` com as instruções e, em `references/`, o material de apoio com as fontes. Tudo em português do Brasil, só com ferramentas gratuitas, para o Claude Code e para outros agentes que leem o formato.

O desenho (metas, não metas e escolhas) está em [docs/design.md](docs/design.md).

## Instalação

### Claude Code

Dentro do Claude Code (não testado):

```text
/plugin install security-standard-skill --marketplace vfranco00/security-standard-skill
```

Ou pelo terminal. O teste usou o caminho de um clone local no lugar de `vfranco00/security-standard-skill`:

```bash
claude plugin marketplace add vfranco00/security-standard-skill
claude plugin install security-standard-skill@security-standard-skill
```

### Gemini CLI

```bash
gemini extensions install https://github.com/vfranco00/security-standard-skill
```

Não testado. O teste usou um clone local: `gemini extensions link <pasta do clone> --consent`.

### Codex e Cursor

Pelo manifesto de cada agente: `.codex-plugin/plugin.json` (Codex) e `.cursor-plugin/plugin.json` (Cursor). Formato pela documentação oficial; ainda não testados (ver "Agentes testados").

### Manual

Copie as pastas de `skills/` para a pasta de skills do seu agente (no Claude Code, `~/.claude/skills/`).

### Agentes testados

| Agente | Situação em 10/11/2026 |
|---|---|
| Claude Code 2.1.312 | testado: `claude plugin marketplace add <pasta do clone>` e `claude plugin install security-standard-skill@security-standard-skill`, com as 9 skills; o `/plugin install` de dentro do app e o `marketplace add` pelo nome no GitHub não foram testados |
| Gemini CLI 0.59.0 | testado: `gemini extensions link <pasta do clone> --consent`, com as 9 skills; o `gemini extensions install` pela URL do GitHub não foi testado |
| Codex | não testado |
| Cursor | não testado |

## Como usar

Peça em linguagem natural. O agente lê a `description` de cada skill e carrega a que combina com o pedido. No Claude Code, também dá para chamar uma skill pelo nome: `/security-standard-skill:<skill>`.

A entrada é a `security-standard`: ela faz o inventário do projeto, escolhe o nível alvo e os perfis, chama as outras skills na ordem e grava lacunas e plano em `.security-standard/`. O que vai para o cliente fica em `docs/seguranca/`.

## Skills

| Skill | Para quê |
|---|---|
| `security-standard` | Ponto de entrada: inventário, nível alvo (Essencial, Fornecedor ou Big tech), perfis (`financeiro`, `seguros`, `setor-publico`, `cartoes`, `saude`), ordem das skills, lacunas e plano priorizado, e a separação entre o interno e o que vai para o cliente. |
| `security-identity-access` | Identidade e acessos (IAM-01 a IAM-14): MFA resistente a phishing, SSO, acesso à produção sem privilégio permanente, menor privilégio e revisão de acessos, contas de emergência e de serviço, segredos em cofre e revogação no desligamento, com a matriz de acessos. |
| `security-data-encryption` | Dados e criptografia (DAT-01 a DAT-15): classificação, criptografia em repouso e em trânsito, chaves em KMS ou HSM com rotação, backup imutável com restauração testada, RPO e RTO, guarda, localização e eliminação dos dados. |
| `security-secure-development` | Desenvolvimento seguro (DEV-01 a DEV-26): revisão por outra pessoa e proteção de branch, SAST, SCA e segredos no CI, dependências, SBOM, proveniência SLSA, prazos de correção por gravidade, SECURITY.md, OWASP Top 10:2025 e ASVS 5.0. |
| `security-infra-operations` | Infraestrutura e operação (OPS-01 a OPS-16): hardening, segmentação e zero trust, TLS e cabeçalhos, logs com retenção por nível e os prazos do Marco Civil, monitoramento e alerta, vulnerabilidades e patches, postura da nuvem e IaC, teste de intrusão. |
| `security-incident-continuity` | Incidentes e continuidade (IRC-01 a IRC-11): plano de resposta com papéis e prazos de aviso, registro de incidentes por 5 anos, pós-incidente, exercício anual e continuidade com RPO e RTO; a `lgpd-skill`, se instalada, cuida do aviso à ANPD e aos titulares. |
| `security-governance-vendors` | Governança e fornecedores (GOV-01 a GOV-17): política revista todo ano, responsável nomeado, treinamento, registro de riscos, fornecedores e lista de subprocessadores, e roteiro de certificação ISO 27001 ou SOC 2. |
| `security-customer-evidence` | Dossiê de segurança e respostas a questionários (CAIQ, SIG ou o do cliente) em `docs/seguranca/`, só com os controles atendidos e com evidência, marcando o tipo dela (verificada, documento ou declarada); nunca põe lacuna no dossiê. |
| `security-automated-checks` | Verificação local e passiva com as ferramentas abertas já instaladas (gitleaks, Semgrep, Trivy, osv-scanner, Checkov, npm audit, pip-audit, cabeçalhos HTTP e proteção da branch); nunca instala nada. O osv-scanner, o npm audit e o pip-audit mandam o nome e a versão das dependências a serviços públicos de vulnerabilidade. Grava as saídas em `.security-standard/evidencias/`, pasta interna, fora do git, sem os trechos de código, e apaga o arquivo com chave da AWS, chave privada ou `sk-…`; o que não se garante está em `skills/security-automated-checks/references/ferramentas.md`. |

## Catálogo de controles

Cada controle é um bloco em `skills/<skill>/references/controles-<familia>.md`, com enunciado, nível mínimo, perfis, parâmetro, fontes, como verificar, como implementar, evidência e mapa para os frameworks (formato em [docs/formato-dos-controles.md](docs/formato-dos-controles.md)). O catálogo completo e o mapa são gerados dos blocos: [docs/catalogo-de-controles.md](docs/catalogo-de-controles.md) e [docs/mapa-de-frameworks.md](docs/mapa-de-frameworks.md).

Nesta versão, o Mapa não traz ids de SOC 2 nem de SIG: as duas chaves ficam `—`, porque não foram conferidas em fonte oficial gratuita. Os ids da ISO/IEC 27001 foram conferidos pela OLIR 155 do NIST. Por isso, a pergunta de questionário identificada só por id de SOC 2 ou de SIG não casa com nenhum controle e fica com a equipe.

Contagem de 09/11/2026, pelo nível mínimo (o primeiro nível em que o controle é exigido). Os níveis são cumulativos (Essencial ⊂ Fornecedor ⊂ Big tech), e muitos controles trazem um parâmetro por nível, mais exigente nos níveis de cima.

| Família | Essencial | Fornecedor | Big tech | Total |
|---|---|---|---|---|
| IAM | 11 | 2 | 1 | 14 |
| DAT | 14 | 1 | 0 | 15 |
| DEV | 19 | 6 | 1 | 26 |
| OPS | 13 | 3 | 0 | 16 |
| IRC | 8 | 3 | 0 | 11 |
| GOV | 14 | 3 | 0 | 17 |
| **Total** | **79** | **18** | **2** | **99** |
| **Acumulado** | 79 | 97 | 99 | — |

Cinco dos 79 controles Essencial só valem com um perfil: IAM-11, IAM-14 e GOV-13, que têm o perfil no campo Perfis, e IAM-09 e OPS-16, cujo trecho Essencial só traz regra de perfil. Num projeto sem perfil, o Essencial tem 74 controles que se aplicam.

## Fontes

Cada controle traz as fontes no campo Fontes do bloco, com o tipo (`primária`, `secundária` ou `proposta`), a URL oficial e a data da conferência. Exigência só com fonte primária; parâmetro sem fonte primária leva `(proposta)`. A tabela consolidada das fontes fica em `skills/security-standard/references/fontes.md`. Nenhum texto de framework licenciado (SIG, ISO, CIS, ASVS, TSC, CCM/CAIQ) está no repositório: só identificadores, títulos curtos e paráfrase própria. Fontes conferidas em 09/11/2026.

## Testes e validação

```bash
bash scripts/lint-skills.sh                 # frontmatter, name, tamanho e termos proibidos
python3 scripts/lint-controles.py           # formato de cada bloco de controle
python3 scripts/gerar-catalogo.py           # gera o catálogo e o mapa em docs/
bash scripts/testes/lint-controles.test.sh  # teste do linter e do gerador
bash scripts/testes/verificar.test.sh       # teste do verificar.sh da security-automated-checks
bash scripts/testes/graders.test.sh         # sintaxe dos graders dos evals (precisa do Node.js)
bash scripts/verificar-fontes.sh            # toda URL das fontes responde
claude plugin validate --strict .           # manifesto e skills
```

URL oficial que recusa robôs entra em `scripts/fontes-ignorar.txt`, com a justificativa. O CI (`.github/workflows/validar.yml`) roda esses passos a cada push e pull request (o `claude plugin validate` só avisa), confere que o catálogo e o mapa de `docs/` batem com os blocos e roda o `shellcheck` dos scripts e dos testes e o `skills-ref validate` de cada skill. Os casos de avaliação ficam em `evals/` (ver `evals/README.md`).

## Contribuindo

Ver [CONTRIBUTING.md](CONTRIBUTING.md).

## Licença

MIT. Ver [LICENSE](LICENSE).

## English summary

`security-standard-skill` is a free, MIT-licensed plugin of Agent Skills written in Brazilian Portuguese (keywords: `["seguranca","security","appsec","devsecops","iso-27001","soc-2","nist-csf","cis-controls","owasp","vendor-assessment","fornecedor","compliance"]`). Install it in Claude Code with `claude plugin marketplace add vfranco00/security-standard-skill` and `claude plugin install security-standard-skill@security-standard-skill`, in Gemini CLI with `gemini extensions install https://github.com/vfranco00/security-standard-skill`, or copy the folders in `skills/` to your agent's skills folder. The Codex and Cursor manifests follow the official documentation and have not been tested yet. Description (in Portuguese): Padrão de segurança para projetos de software, no nível das big techs e das exigências das grandes empresas a fornecedores: catálogo de controles com fonte, análise de lacunas, plano priorizado, modelos de políticas, dossiê de segurança para clientes e verificação automática com ferramentas abertas.
