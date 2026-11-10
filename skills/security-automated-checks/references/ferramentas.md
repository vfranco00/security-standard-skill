# Ferramentas da verificação automática

O `scripts/verificar.sh` roda, sobre a raiz do projeto, só as ferramentas que já estão instaladas (detectadas com `command -v`) e grava as saídas numa pasta nova a cada rodada, que aqui se chama `<ev>`: `.security-standard/evidencias/<AAAA-MM-DD>/` ou, se essa já existe (uma rodada anterior do dia, ou documentos do usuário), `<AAAA-MM-DD>-2/`, `-3/` e assim por diante. As pastas de `evidencias/` são registro: o script nunca regrava nem apaga o que já está nelas. Num repositório git em que `.security-standard/` não está no `.gitignore`, o resumo traz `CONFERIR .security-standard/ fora do .gitignore`, porque um `git add -A` levaria a evidência ao repositório. A coluna "Como instalar" é informação para o usuário: a skill nunca executa esses comandos.

## O que cada ferramenta cobre e o comando usado

| Ferramenta | Cobre | Comando passivo (como está no script) | Roda quando | Como instalar (só informado) |
|---|---|---|---|---|
| gitleaks | segredos no histórico do git | `gitleaks detect --source . --redact --no-banner --report-format json --report-path <ev>/gitleaks.json` | o projeto é um repositório git | `brew install gitleaks`, ou o binário da página de releases |
| Semgrep | análise estática do código (SAST) com o conjunto `p/default` | `semgrep scan --config p/default --json -o <ev>/semgrep.json --metrics off --exclude .security-standard` | sempre | `pipx install semgrep` ou `uv tool install semgrep` |
| Trivy | dependências vulneráveis, segredos, configuração (Dockerfile e infraestrutura como código) e licenças | `trivy fs --config /dev/null --secret-config <ev>/nenhum-trivy-secret.yaml --skip-dirs .security-standard --scanners vuln,secret,misconfig,license --format json -o <ev>/trivy.json .` | sempre | `brew install trivy` |
| osv-scanner | dependências vulneráveis, pelos lockfiles e manifestos | `osv-scanner scan source -r . --format json > <ev>/osv.json` | sempre | `brew install osv-scanner` ou `go install github.com/google/osv-scanner/v2/cmd/osv-scanner@latest` |
| Checkov | infraestrutura como código e Dockerfile | `checkov -d . -o json --compact --skip-download > <ev>/checkov.json` | o projeto não tem `.checkov.yaml` nem `.checkov.yml` na raiz | `pip3 install checkov` ou `brew install checkov` |
| npm audit | dependências do npm | `npm audit --json > <ev>/npm-audit.json` | há `package-lock.json` | vem com o Node.js |
| pip-audit | dependências do Python do ambiente ativo | `pip-audit -f json > <ev>/pip-audit.json` | há `requirements.txt` ou `pyproject.toml` | `python -m pip install pip-audit` |
| curl | cabeçalhos HTTP do próprio sistema | `curl -g -sI -L --max-time 20 <url_publica> > <ev>/cabecalhos.txt` | `url_publica` com `https://`, na forma aceita | vem com o sistema |
| gh | proteção da branch principal no GitHub | `gh api repos/<dono>/<nome>/branches/<principal>/protection > <ev>/branch-protection.json` | `repositorio_github` válido e `gh auth status` com saída 0 | `brew install gh` |
| gancho_externo | o comando só leitura que o usuário indicou | `bash -c "<gancho_externo>"`, com as duas saídas em `<ev>/gancho.txt` | valor no `config.yml` e a opção `--com-gancho` | — |

Antes do `gh api .../protection`, o script lê a branch principal com `gh api repos/<dono>/<nome> --jq .default_branch`. A saída de erro de cada ferramenta vai para `<ev>/<arquivo>.log`, que só fica quando ela dá erro. Sete opções protegem a rodada:
- o `-g` desliga a expansão de `[]` e `{}` do `curl`, que transformaria um endereço em vários, até de outros servidores;
- o `--compact` tira do JSON do Checkov os trechos de código, e o `--skip-download` impede o Checkov de falar com a Prisma Cloud;
- o `--config /dev/null` faz o Trivy ignorar o `trivy.yaml` do projeto, e o `--secret-config`, com um caminho que não existe na pasta nova da rodada, o `trivy-secret.yaml` (com `/dev/null`, o Trivy sai com FATAL);
- o `--skip-dirs .security-standard` do Trivy e o `--exclude .security-standard` do Semgrep deixam de fora a pasta interna, com as rodadas anteriores e os documentos do usuário, que contariam como achado do projeto. No git, o `.gitignore` já a tira do Semgrep, e o Checkov 3.3.10 não lê a pasta.

## O que o `config.yml` liga

O script lê `.security-standard/config.yml` linha a linha, como a maestra: só a linha que começa com `chave:`. Depois de `chave:`, o valor vai até o primeiro ` #` (espaço seguido de `#`), que abre comentário como no YAML, e só então se aparam os espaços das pontas: `url_publica: # nenhum por enquanto` dá vazio. Valor vazio ou de exemplo do modelo (começa com `<`, `https://...` ou `owner/repo`) conta como vazio e vira uma linha `PULADO` no resumo.

Forma não suportada vira `PULADO <item> (forma não suportada no config.yml; use <forma certa>)`, mesmo com `--com-gancho`, e nenhum comando é montado:

- a chave repetida;
- a chave seguida de linha recuada ou de lista (`- …`, com ou sem recuo);
- a linha da chave com aspas (`"` ou `'`) ou colchetes (`[` ou `]`) em qualquer lugar, inclusive dentro do comando do gancho (`gancho_externo: touch "a b"`) e no comentário depois do ` #`, como na regra da maestra;
- o valor que começa com um indicador do YAML: `|` e `>` abrem um bloco, com o texto nas linhas de baixo, e `&`, `*`, `!`, `%`, `@`, crase, `{` e `?` têm outro sentido. Lido como comando, `gancho_externo: >-` criaria um arquivo `-` na raiz, e `>2` zeraria um arquivo `2`.

O script não adivinha o valor; quem corrige a linha é o usuário.

- `url_publica`: o endereço do próprio sistema, com `https://`, o endereço e o caminho, sem colchetes, chaves, aspas nem espaços. Outra forma, inclusive `http://`, fica `PULADO`. O `-L` segue os redirecionamentos que o próprio sistema mandar.
- `repositorio_github`: `dono/nome`; o dono só com letras, dígitos e `-`, e o nome só com letras, dígitos, `-`, `.` e `_`, sem ser `.` nem `..`. O `gh api` lê só esse repositório.
- `gancho_externo`: um comando só leitura de uma ferramenta já instalada, numa linha, sem aspas nem colchetes. Ele vem de um arquivo dentro do repositório, e uma mudança nesse arquivo trocaria o comando: por isso só roda com `--com-gancho`, depois de o usuário ver o comando, como o script o lê, e aceitar. Sem a opção, o resumo diz `PULADO gancho_externo (rode com --com-gancho depois de conferir o comando)`.

## Arquivos do projeto que mudam as ferramentas

Um arquivo da raiz do projeto pode mudar o que a ferramenta faz. Por isso a skill pede que o usuário conheça o repositório, e o script trata cada caso assim:

- `.checkov.yaml` ou `.checkov.yml`: o Checkov o lê na pasta varrida e na pasta atual, mesmo com `--config-file` (na 3.3.10, o leitor de configuração junta esses arquivos ao informado). Com `external-checks-dir`, ele executa o Python da pasta indicada; a ajuda do próprio Checkov avisa que essa opção roda código Python e só serve para pasta confiável. Com um desses arquivos na raiz, o Checkov não roda, e o resumo diz `CONFERIR checkov (…)`.
- `trivy.yaml`: o Trivy o lê na pasta atual por padrão. Ele muda o que é varrido e o que é ignorado, e o `server.addr` põe o Trivy em modo cliente, mandando a análise ao servidor indicado. O script passa `--config /dev/null`, e o Trivy não lê o do projeto.
- `trivy-secret.yaml`: o Trivy o lê na pasta atual por padrão, e o `disable-rules` dele desliga regras de segredo (um `trivy-secret.yaml` de duas linhas zera o achado de um token). O script passa `--secret-config` com um caminho que não existe, na pasta nova da rodada, e o Trivy usa as regras próprias.
- `.gitleaks.toml`, `.gitleaksignore`, `.semgrepignore`, `.trivyignore` e `osv-scanner.toml`: podem silenciar achados. `.npmrc`: troca o registro para onde o `npm audit` manda a árvore de dependências. As ferramentas os leem.

O resumo lista num aviso `CONFERIR` os arquivos desta seção que existirem na raiz, inclusive o `trivy.yaml` e o `trivy-secret.yaml`: o CI do projeto pode usá-los e chegar a outro resultado. Leia-os antes de a evidência valer como `verificada`.

## Como ler cada resultado

- **Resumo.** `<ev>/resumo.md` (modelo em `assets/resumo-evidencias.md`) diz o nome da pasta da rodada e tem uma linha por ferramenta: `rodou`, `ausente`, `pulado` ou `erro (saída N)`, o arquivo e o total de achados, com a contagem por gravidade quando o JSON traz a gravidade, nos rótulos da própria ferramenta. Depois vêm os avisos: `AUSENTE` (com o comando de instalação), `PULADO`, `CONFERIR`, `ERRO`, `APAGADO` e `INTERROMPIDO`.
- **gitleaks.** Lista de achados; `[]` é nenhum segredo no histórico. Cada achado traz `RuleID`, `File`, `Commit`, autor e e-mail do commit; `Secret` e `Match` vêm como `REDACTED`. Saída 1 é "vazamento ou erro": o script separa os dois pela presença do relatório. O `detect` foi substituído por `gitleaks git` na v8.19.0 e continua aceito, só escondido da ajuda. Fora de um repositório git ele não lê nada e devolve `[]`; por isso o script pula. Numa pasta sem git, o usuário pode pôr `gitleaks dir . --redact --no-banner` como `gancho_externo`.
- **Semgrep.** Achados em `results`, com a regra em `check_id`, o arquivo, as linhas e a gravidade em `extra.severity` (`ERROR`, `WARNING`, `INFO`). O script tira `lines` (com login no Semgrep, é o trecho de código), `metavars`, `dataflow_trace`, os campos de correção e as mensagens, que podem citar o código; o `check_id` e o `metadata` da regra explicam o achado. A saída 0 vale mesmo com achados; 2 ou mais é falha. O `--config auto` entra no registro do Semgrep com a URL do projeto, e as métricas no padrão (`auto`) vão para o servidor sempre que as regras vêm dele: por isso o script usa o `p/default` com `--metrics off`.
- **Trivy.** `Results` com `Vulnerabilities`, `Secrets`, `Misconfigurations` e `Licenses`, cada achado com `Severity`. O segredo já vem mascarado com asteriscos, mas o achado de configuração traz a linha de código inteira, com a senha de um `ENV` do `Dockerfile` ou de um `.tf`: o script tira `Code`, `RenderedCause` e `Match`, e ficam a regra, o alvo, as linhas, a gravidade e a mensagem (que cita o nome da variável, não o valor). Na licença, a gravidade vem da classificação: proibida é `CRITICAL`, restrita `HIGH`, recíproca `MEDIUM`, de aviso, permissiva ou sem restrição `LOW`, e desconhecida `UNKNOWN`. Licença `LOW` não é problema; confira as `CRITICAL`, `HIGH` e `UNKNOWN` contra a lista do DEV-26.
- **osv-scanner.** `results` → `packages` → `groups`, um grupo por vulnerabilidade, com a nota CVSS em `max_severity` (campos observados na saída da 2.5.1). O resumo converte a nota pela escala qualitativa do CVSS v3.1: `CRITICAL` de 9,0 a 10,0, `HIGH` de 7,0 a 8,9, `MEDIUM` de 4,0 a 6,9 e `LOW` de 0,1 a 3,9. Saída 0: sem vulnerabilidade; 1: com vulnerabilidade; 127: erro; 128: nenhum manifesto de dependência, que o resumo mostra como `PULADO`. Arquivos ignorados pelo `.gitignore` ficam de fora.
- **Checkov.** Um bloco por tipo de verificação (`terraform`, `dockerfile` e outros), com `results.failed_checks`. O `code_block` de cada verificação, aprovada ou não, trazia o código com a senha: o `--compact` (documentado para a saída de tela; no JSON da 3.3.10 também tira o código) e o script, que remove `code_block` e `fixed_definition`, deixam só a verificação, o arquivo e as linhas. Sem chave da plataforma, a gravidade vem vazia (observado na 3.3.10) e o resumo dá só o total. Arquivo que o Checkov não conseguiu ler (um `.tf` fora de UTF-8, por exemplo) entra em `summary.parsing_errors`, não em `failed_checks`: o resumo dá `0 (+ 1 não lido(s): CONFERIR)` e um aviso `CONFERIR checkov`, porque o total não vale para esse arquivo. Saída 1 quando há falha.
- **npm audit.** `metadata.vulnerabilities` conta os pacotes por gravidade (`critical`, `high`, `moderate`, `low`, `info`). JSON com `error` (por exemplo, `ENOLOCK`, sem lockfile) vira `erro` no resumo. Saída diferente de 0 quando há vulnerabilidade.
- **pip-audit.** Sem argumento, audita o ambiente Python ativo: rode o script com o ambiente virtual do projeto ativado, ou o resultado é o do ambiente onde o pip-audit está. O `-r requirements.txt` resolve as dependências como um `pip install`, num ambiente temporário, e a skill não faz isso. O JSON não traz gravidade: o resumo dá o total de vulnerabilidades.
- **curl.** Com `-I` e `-L`, há um bloco de cabeçalhos por resposta; vale o último. O `-g` faz o curl pedir o endereço como está escrito. Confira o `Strict-Transport-Security` e o `max-age` (DAT-03); `Content-Security-Policy` com `frame-ancestors`, `X-Content-Type-Options: nosniff` e `Referrer-Policy` (OPS-04); e, em cada `Set-Cookie`, `Secure`, `HttpOnly` e `SameSite` (DEV-25). O `-I` não testa a versão do TLS: essa parte do DAT-03 é com a skill da família. Saída 28 é tempo esgotado (20 s).
- **gh api.** Saída 0: o JSON tem as regras da branch (revisão de pull request, checks obrigatórios, bloqueio de force push, regras para administradores). Saída 1: leia a mensagem da API, no `branch-protection.json` ou no `branch-protection.log`. `Branch not protected` quer dizer que a branch não tem proteção, e isso é a evidência do DEV-02 ausente, não falha da ferramenta. Outra mensagem (por exemplo, `Not Found`) pede conferir o acesso: ler a proteção exige permissão de administração do repositório (no token de acesso fino, "Administration" com leitura). Em repositório privado, a proteção de branch só existe nos planos pagos do GitHub; no gratuito, só em repositório público.
- **gancho.txt.** A saída do comando do usuário; quem lê é você, com a documentação da ferramenta do gancho.

## O que a evidência não guarda

- **Trecho de código.** Logo depois de cada ferramenta, antes de qualquer outra leitura, o script tira dos JSON do Trivy, do Checkov e do Semgrep os campos com código (lista nas ferramentas, acima). A falha é fechada: o JSON só fica se o filtro, em Python, confirmar a limpeza com `ok`. Em qualquer outro caso, o arquivo é apagado e vira `APAGADO`: JSON ilegível ou aninhado fundo demais, caractere que não se grava, disco cheio, Python ausente, quebrado ou interrompido.
- **Chave.** Em cada arquivo que a ferramenta gravou, o script procura a chave da AWS (`AKIA[0-9A-Z]{16}`), a chave privada (`-----BEGIN [A-Z ]*PRIVATE KEY`) e a chave `sk-[A-Za-z0-9]{20,}`. Arquivo com uma delas é apagado e vira `APAGADO` no resumo; a evidência daquela ferramenta fica sem arquivo, e o valor não é copiado para lugar nenhum. O certificado público (`-----BEGIN CERTIFICATE`, como na saída do `openssl s_client` do DAT-03) não casa e fica.
- **Varredura da pasta.** No fim, a pasta da rodada inteira passa pelo mesmo padrão, e o que casar (um arquivo que o gancho gravou nela, por exemplo) também é apagado. Os nomes vêm separados por NUL, então um nome com quebra de linha não vira outro caminho, e só se apaga o que, pelo caminho real, está dentro da pasta da rodada. As pastas anteriores e os documentos do usuário não são lidos nem tocados.
- **Rodada interrompida.** Com `INT` ou `TERM` (o Ctrl-C, ou o tempo-limite de quem chamou), o script apaga a saída da ferramenta em curso, passa a pasta pela varredura e grava o `resumo.md` com `INTERROMPIDO`; a saída é 130 ou 143. O Ctrl-C e o tempo-limite que sinaliza o grupo de processos param a ferramenta junto, e a limpeza é imediata. Com o `TERM` só no script, a limpeza espera a ferramenta em curso terminar, porque o bash só trata o sinal depois do comando em primeiro plano. Um `KILL` não deixa o script reagir: depois dele, apague a pasta da rodada interrompida à mão, se ela ficou sem `resumo.md`.

O que não se garante: a saída do gancho é texto livre e só passa pela conferência das chaves; as mensagens das regras do Trivy e do Checkov ficam (elas citam nomes, não valores, nas versões testadas); o `gitleaks.json` guarda o autor, o e-mail e a mensagem de cada commit com achado, que são dado pessoal e podem citar o que foi commitado; o `cabecalhos.txt` guarda os cabeçalhos como o sistema os mandou, inclusive o valor de cada `Set-Cookie`; e o `<arquivo>.log` de uma ferramenta que falhou guarda a saída de erro dela sem tirar trechos de código, só com a conferência das chaves. A pasta é interna, fora do git, e nunca vai para `docs/seguranca/`.

## Rede

- gitleaks: só a máquina.
- Semgrep: baixa as regras do `p/default`; o `--metrics off` desliga as métricas de uso.
- Trivy: baixa a base de vulnerabilidades e o pacote de verificações de configuração; com `--config /dev/null`, não segue o `server.addr` de um `trivy.yaml` do projeto.
- osv-scanner: consulta a base OSV com as dependências que achou.
- Checkov: com o `--skip-download`, não fala com a Prisma Cloud; a saída fica sem os links de documentação.
- npm audit: manda ao registro configurado o nome e a versão de cada pacote da árvore.
- pip-audit: consulta o serviço de vulnerabilidades, o PyPI por padrão, com o nome e a versão das dependências.
- curl e gh: falam só com a `url_publica` (e os redirecionamentos dela, com o `-g` contra a expansão de `[]` e `{}`) e com a API do GitHub para o `repositorio_github`.

## Fontes

Conferidas em 2026-11-09, com a versão instalada para o teste entre parênteses.

| Ferramenta | Fonte | URL |
|---|---|---|
| gitleaks (8.30.1) | README: instalação, `--redact`, `--report-path`, códigos de saída, `detect` substituído na v8.19.0 | https://github.com/gitleaks/gitleaks |
| Semgrep (1.176.0) | Quickstart: instalação | https://semgrep.dev/docs/getting-started/quickstart |
| Semgrep | Referência da CLI: `--metrics`, `--config auto`, `p/default`, códigos de saída | https://semgrep.dev/docs/cli-reference |
| Trivy (0.74.0) | Instalação | https://trivy.dev/docs/latest/getting-started/installation/ |
| Trivy | Alvo filesystem e `--scanners` | https://trivy.dev/docs/latest/guide/target/filesystem/ |
| Trivy | Segredos: exemplo com o valor mascarado; `trivy-secret.yaml` lido da pasta atual, `--secret-config` e `disable-rules` | https://trivy.dev/docs/latest/guide/scanner/secret/ |
| Trivy | Licenças: classificação e gravidade | https://trivy.dev/docs/latest/guide/scanner/license/ |
| Trivy | Arquivo de configuração: `trivy.yaml` por padrão, `--config` e `server.addr` | https://trivy.dev/docs/latest/references/configuration/config-file/ |
| osv-scanner (2.5.1) | Instalação | https://google.github.io/osv-scanner/installation/ |
| osv-scanner | `scan source -r` e o `.gitignore` | https://google.github.io/osv-scanner/usage/scan-source |
| osv-scanner | Códigos de saída | https://google.github.io/osv-scanner/output/ |
| Checkov (3.3.10) | Instalação | https://www.checkov.io/2.Basics/Installing%20Checkov.html |
| Checkov | Referência da CLI: `-d`, `-o`, `--compact`, `--config-file`, `--external-checks-dir`, `--soft-fail`, `--skip-download` | https://www.checkov.io/2.Basics/CLI%20Command%20Reference.html |
| npm audit (npm 11.19.0) | Comando, lockfile, o que é enviado ao registro, código de saída | https://docs.npmjs.com/cli/v11/commands/npm-audit |
| npm | Instalação do Node.js e do npm | https://docs.npmjs.com/downloading-and-installing-node-js-and-npm |
| pip-audit | README: instalação, ambiente auditado, `-r`, serviço padrão, códigos de saída | https://github.com/pypa/pip-audit |
| gh (2.97.0) | Instalação no macOS | https://github.com/cli/cli/blob/trunk/docs/install_macos.md |
| gh | `gh api` | https://cli.github.com/manual/gh_api |
| gh | `gh auth status`: saída 1 quando a sessão tem problema | https://cli.github.com/manual/gh_auth_status |
| GitHub | REST, proteção de branch: códigos 200 e 404, permissão de administração e planos | https://docs.github.com/en/rest/branches/branch-protection |
| curl (8.7.1) | Manual: `-s`, `-I`, `-L`, `-g`, `--max-time` | https://curl.se/docs/manpage.html |
| FIRST | CVSS v3.1, seção 5: escala qualitativa | https://www.first.org/cvss/v3.1/specification-document |
