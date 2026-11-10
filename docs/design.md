# Desenho da security-standard-skill

Versão 0.1.0, de 09/11/2026. O formato dos blocos de controle está em [formato-dos-controles.md](formato-dos-controles.md). O catálogo e o mapa, gerados dos blocos, estão em [catalogo-de-controles.md](catalogo-de-controles.md) e [mapa-de-frameworks.md](mapa-de-frameworks.md).

## 1. Intenção e porquê

Uma skill que leve um projeto de software ao padrão de segurança que as big techs praticam por dentro e que as grandes empresas (bancos, seguradoras, indústria, varejo, plataformas, órgãos públicos) exigem de quem lhes fornece software, e que prove isso com evidências, do jeito que uma avaliação de fornecedor pede.

O porquê: quem vende software para uma empresa grande recebe um questionário de segurança (CAIQ, SIG, anexo de compliance, requisitos mínimos) e precisa responder com fatos. As exigências publicadas pelas big techs e pelas grandes empresas convergem: MFA resistente a phishing, nenhum acesso permanente à produção, criptografia por padrão, revisão de código por outra pessoa, correção de vulnerabilidade com prazo, logs guardados, plano de incidente com prazo de aviso, backup testado, fornecedor controlado. Hoje isso está espalhado em normas e relatórios; a skill junta tudo num catálogo de controles com fonte, verifica o projeto, ajuda a corrigir e monta o dossiê. É para a comunidade, sem marca de empresa.

## 2. Metas

1. **Catálogo de controles com fonte e parâmetro.** Cada controle tem: identificador, enunciado, nível mínimo, parâmetro (por nível, quando varia), por que existe, fontes com URL e tipo, como verificar, como implementar, evidência a guardar e mapa para os frameworks.
2. **Três níveis cumulativos** (Essencial ⊂ Fornecedor ⊂ Big tech): **Essencial** é o mínimo que grandes clientes exigem em contrato (próximo ao CIS IG1 e aos códigos de fornecedores publicados); **Fornecedor** passa numa avaliação de fornecedor (temas do Anexo A da ISO/IEC 27001:2022, critérios do SOC 2, CAIQ v4.1); **Big tech** reproduz práticas internas de Google, Microsoft e AWS (sem acesso permanente, proveniência de build, logs de segurança por 2 anos, revisão a quatro olhos obrigatória).
3. **Perfis que ligam controles a mais.** Além do nível, o inventário marca o perfil do cliente e do dado: `financeiro` (Res. CMN 4.893 e 5.274, Res. BCB 85 e 538), `seguros` (Circular SUSEP 638), `setor-publico` (IN GSI/PR 5/2021), `cartoes` (PCI DSS 4.0.1 para quem trata cartão por provedor) e `saude`. O Brasil é a jurisdição base: Marco Civil (arts. 13 e 15), ANPD (Res. 15/2024) e LGPD entram no Essencial de qualquer projeto brasileiro.
4. **Análise de lacunas do projeto real**: lê código, configuração, CI, infraestrutura como código e documentação; pergunta o que não dá para ler; classifica cada controle como atendido, parcial, ausente ou não se aplica, sempre com a evidência e o tipo dela (verificada pelo agente, documento anexado ou declaração do usuário).
5. **Plano priorizado e ajuda para executar**: ordem por risco e esforço, com o que destrava a venda primeiro; para cada lacuna, o "como implementar" do controle; modelos prontos dos documentos que os controles pedem (política de segurança, plano de resposta a incidentes, continuidade e recuperação, lista de subprocessadores, matriz de acessos, política de correção por gravidade, SECURITY.md, política de divulgação); mudanças no repositório do usuário (workflow de CI com SAST, SCA e segredos; CODEOWNERS; Dependabot ou Renovate; proteção de branch) propostas e aplicadas só com aprovação explícita.
6. **Dossiê de segurança para clientes**: documento neutro, compartilhável, que responde ao que uma avaliação de fornecedor pede (arquitetura, controles, certificações, subprocessadores, incidentes, continuidade, privacidade) e banco de respostas mapeado por identificador a CAIQ v4.1, ISO/IEC 27001:2022 Anexo A (conferida pela OLIR 155 do NIST), NIST CSF 2.0 e CIS Controls v8.1. Nesta versão, o Mapa não traz ids de SOC 2 nem de SIG, que não foram conferidos em fonte oficial gratuita: as duas chaves ficam `—`, e a pergunta de questionário identificada só por id de SOC 2 ou de SIG fica com a equipe. Em português por padrão, com saída em inglês sob pedido.
7. **Verificação automática opcional**, local e passiva: ferramentas abertas já instaladas (Semgrep, gitleaks, Trivy, osv-scanner, npm audit ou pip-audit, Checkov), checagem de cabeçalhos HTTP do próprio sistema e leitura das proteções do repositório pelo `gh api`; ganchos para toolkits externos declarados em configuração. Nada se instala (a ferramenta que falta só tem o comando de instalação informado); nada roda contra terceiros; nada lê conta de nuvem na v1.
8. **Qualidade comprovada**: `claude plugin validate --strict`, `skills-ref validate`, evals, e conferência das fontes do catálogo antes de qualquer versão pública.
9. **Instalável em qualquer agente** que lê o formato Agent Skills: plugin do Claude Code, extensão do Gemini CLI e manifestos do Codex e do Cursor.

## 3. Não metas e antimetas

Não metas (v1):
- Não é scanner nem pentest; orquestra scanners abertos se existirem.
- Não certifica (ISO, SOC 2) nem afirma conformidade; mostra o que falta para quem for buscar certificação.
- Não altera contas de nuvem nem configurações de produção; para o repositório do usuário, altera só o que ele aprovar.
- Não lê contas de nuvem nem provedores de identidade (AWS, GCP, Azure, Vercel, Entra, Google Workspace). Para essas evidências, a v1 aceita documento ou declaração; roteiros de leitura que o próprio usuário executa ficam para a v1.1.
- Não reproduz texto de framework licenciado (ver 4).
- Não trata a LGPD em detalhe: aponta a `lgpd-skill` como companheira opcional e cobre só a interface (aviso de incidente, operador, retenção).
- Não cobre hardware, IoT nem aplicativos nativos além do essencial.

Antimetas:
- Controle sem parâmetro ("use criptografia forte") ou sem fonte.
- Lista de 200 itens sem prioridade.
- Dizer "conforme" sem evidência, ou apresentar declaração como verificação.
- Publicar lacunas, saídas de scanner ou segredos num documento que sai da empresa.
- Depender de ferramenta paga ou de toolkit privado de alguém.
- Empresa, produto ou cliente específico como exemplo; os exemplos são genéricos, e big techs e grandes empresas aparecem só com documento oficial delas.

## 4. Restrições

Especificação Agent Skills; empacotamento como plugin do Claude Code com marketplace no repositório; SKILL.md abaixo de 500 linhas; português do Brasil com `description` bilíngue; MIT; neutralidade.

Fontes e licenças:
- Afirmação de exigência pede fonte **primária**: documentação oficial das big techs, texto dos frameworks e normas (ISO, AICPA, NIST, CIS, CSA, OWASP, PCI SSC, BCB, SUSEP, GSI, ANPD, Planalto) ou documento publicado por uma grande empresa para fornecedores. Fonte secundária sozinha não sustenta uma exigência; onde só há secundária ou não há parâmetro público, o controle traz o parâmetro como **proposta da skill**, rotulada, com a justificativa.
- Cada fonte tem tipo (`primária`, `secundária`, `proposta`), URL e data da conferência. URL de loja (ISO, PCI) vale como referência à norma, não como fonte de texto; o catálogo só cita o número do controle e parafraseia com palavras próprias.
- **Nenhum texto de framework licenciado entra no repositório** (SIG é pago; ISO é paga; CIS Controls é CC BY-NC-ND; OWASP ASVS é CC BY-SA; TSC é da AICPA; CCM e CAIQ têm termos próprios da CSA). O mapa usa só identificadores e títulos curtos; as respostas do banco são texto nosso sobre o nosso controle. Versões fixadas: CCM/CAIQ v4.1, SIG 2026 (só domínios), ISO/IEC 27001:2022 com a Amd 1:2024, TSC 2017 com pontos de foco de 2022, NIST CSF 2.0, CIS Controls v8.1, OWASP ASVS 5.0, PCI DSS 4.0.1.

## 5. Como se constrói

### 5.1 Repositório

Manifestos (`.claude-plugin/`, `.codex-plugin/`, `.cursor-plugin/`, `gemini-extension.json`), `scripts/` (lint das skills, conferência das fontes, linter e gerador do catálogo), `.github/workflows/validar.yml`, `evals/` e, em `docs/`: `catalogo-de-controles.md` (visão completa, gerada das referências das skills por script), `mapa-de-frameworks.md` (controle × identificadores dos frameworks), `formato-dos-controles.md` e este `design.md`. A referência cruzada à `lgpd-skill` vale só "se instalada"; nunca para outro plugin.

### 5.2 As skills

Uma maestra e oito especializadas.

| Skill | Faz | Famílias |
|---|---|---|
| `security-standard` | Entrada única: inventário (stack, hospedagem, dados tratados, perfis do cliente), nível alvo, ordem das skills, estado em `.security-standard/STATUS.md`, plano priorizado; cria o `.gitignore` da pasta interna e explica a separação interno × compartilhável | roteamento, plano |
| `security-identity-access` | MFA resistente a phishing, SSO, nenhum acesso permanente à produção (JIT e aprovação), menor privilégio, contas de emergência, segredos fora do código, revogação de acesso no mesmo dia, contas de serviço; modelo de matriz de acessos | IAM |
| `security-data-encryption` | Classificação de dados, criptografia em repouso e em trânsito por padrão, chaves (KMS/HSM, rotação de 90 a 365 dias), backup imutável e testado com RPO e RTO, retenção e eliminação, localização dos dados | DAT |
| `security-secure-development` | Modelagem de ameaças, revisão por outra pessoa e proteção de branch, SAST, SCA e segredos no CI, política de dependências, SBOM e proveniência (níveis SLSA), assinatura de releases, revisão de segurança antes de lançar, prazos de correção por gravidade, política de divulgação (SECURITY.md) e recompensa; modelos de workflow de CI, CODEOWNERS, Dependabot, SECURITY.md | DEV |
| `security-infra-operations` | Hardening, segmentação e zero trust, TLS e cabeçalhos, logs (retenção por nível; Marco Civil), monitoramento e alerta, gestão de vulnerabilidades e patches, postura de nuvem e IaC, teste de recuperação | OPS |
| `security-incident-continuity` | Plano de resposta com papéis e prazos de aviso (contrato com o cliente; ANPD via `lgpd-skill` se instalada), registro de incidentes por 5 anos, pós-incidente, continuidade e recuperação com RPO e RTO, exercício anual; modelos de plano de resposta e de continuidade | IRC |
| `security-governance-vendors` | Política de segurança revista ao menos uma vez por ano, responsável nomeado, treinamento, registro de riscos, gestão de fornecedores e subprocessadores (lista, aviso de mudança, acordo), roteiro de certificação (ISO 27001, SOC 2), compromissos para clientes; modelos de política e de lista de subprocessadores | GOV |
| `security-customer-evidence` | Gera o dossiê e o banco de respostas em `docs/seguranca/`, a partir do estado interno, só com o que está atendido (marcando o tipo: verificada, documento ou declarada); o que falta vai para o plano interno, nunca para o dossiê; português por padrão, inglês sob pedido | evidências |
| `security-automated-checks` | Descobre as ferramentas abertas instaladas e roda só as passivas e locais (gitleaks com `--redact`); guarda as saídas em `.security-standard/evidencias/`, com data, sem os trechos de código, e apaga o arquivo com chave da AWS, chave privada ou `sk-…` (o que não se garante está em `references/ferramentas.md` da skill); lê `.security-standard/config.yml` para ganchos externos (um comando por gancho, só leitura); lê proteções do repositório pelo `gh api` quando o usuário já está autenticado; nunca instala nada nem roda contra terceiros | verificação |

### 5.3 Esquema do catálogo

- Identificadores por família (`IAM-01`, `DAT-03`, ...), entre 80 e 120 controles; o nível não multiplica identificadores.
- Campos de cada controle, em `references/controles-<familia>.md` da skill dona, num bloco fixo: id e título; enunciado; nível mínimo (Essencial, Fornecedor ou Big tech); perfis (`todos`, ou `financeiro`, `seguros`, `setor-publico`, `cartoes`, `saude`); parâmetro (único, ou um por nível quando varia); por quê; fontes (lista com tipo, URL e data); como verificar (pergunta, comando ou arquivo a ler); como implementar; evidência; mapa (CAIQ, SIG, ISO, SOC 2, CSF, CIS, ASVS por identificador).
- `scripts/lint-controles.py` confere o bloco de cada controle (campos presentes e em ordem, nível e perfis válidos, ao menos uma fonte, tipo de fonte, URL e data) e `scripts/gerar-catalogo.py` gera `docs/catalogo-de-controles.md` e `docs/mapa-de-frameworks.md`.

### 5.4 Artefatos no projeto do usuário

- **Interno, `.security-standard/`** (a maestra o acrescenta ao `.gitignore` e explica; o usuário pode versionar `lacunas.md` e `plano.md` se quiser): `STATUS.md`, `inventario.md`, `lacunas.md` (controle × situação × tipo de evidência × evidência), `plano.md`, `evidencias/` (saídas de ferramentas redigidas, com data), `config.yml` (nível alvo, perfis, ganchos externos, exclusões justificadas).
- **Compartilhável, `docs/seguranca/`**: `dossie-de-seguranca.md`, `respostas-questionario.md`, e os documentos gerados dos modelos (política de segurança, plano de resposta, continuidade, subprocessadores). Sem lacunas, sem saídas de scanner, sem identificadores de conta.

### 5.5 Testes

- `evals/`: um caso por skill, com `tool_used: Skill` e graders `regex` para o id do controle, o nível, o tipo de fonte e a ausência de lacuna no dossiê; nada de grader `llm`. O `claude plugin eval` roda cada caso com e sem o plugin (linha de base). Os evals não são executados neste repositório, porque cada execução é paga; quem instalar pode rodá-los por conta própria. A sintaxe dos graders é conferida por `scripts/testes/graders.test.sh`.
- As fontes do catálogo passam por conferência independente antes de cada versão.
- CI (só ferramentas gratuitas): `claude plugin validate --strict` (só avisa), `skills-ref validate`, linter do catálogo e o teste dele, guarda do catálogo gerado em `docs/`, teste do `verificar.sh`, teste dos graders, `scripts/verificar-fontes.sh` (URLs respondem) e `shellcheck` nos scripts e nos testes.

## 6. Escolhas de desenho

- Nomes das skills em inglês (`security-*`) com conteúdo em português, porque o tema é global e a busca por nome é em inglês.
- Brasil como jurisdição base e perfis de cliente (`financeiro`, `seguros`, `setor-publico`, `cartoes`, `saude`) que ligam controles a mais.
- Níveis cumulativos, com parâmetro por nível no mesmo controle.
- Nenhum texto de framework licenciado no repositório: só identificadores e paráfrase própria. Se um dia houver licença do SIG, o banco de respostas pode ganhar os textos.
- Parâmetro sem fonte primária entra como "proposta da skill", rotulado, em vez de ficar de fora.
- Nada de leitura de conta de nuvem na v1; evidência de IAM por documento ou declaração, e roteiros que o próprio usuário executa na v1.1.
- Declaração do usuário conta como evidência, sempre marcada como declarada e distinta da verificada, no estilo de autoavaliação.
- Pasta interna `.security-standard/` fora do git por padrão; o que sai para o cliente mora em `docs/seguranca/`.
- Dossiê em português por padrão, com inglês sob pedido.
