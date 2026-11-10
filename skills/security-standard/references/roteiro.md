# Roteiro da maestra

O caminho é sempre o mesmo: pasta interna → inventário → nível alvo e perfis → skills em ordem → lacunas → plano → evidências → dossiê. Os números abaixo são os passos do `SKILL.md`. O estado (`STATUS.md`, inventário, configuração, lacunas, plano, evidências e os arquivos internos das famílias: matriz de acessos, classificação de dados, política de backup e recuperação, checklist de hardening, registro e contatos de incidente e registro de riscos) fica em `.security-standard/`, e os registros de incidentes, de riscos, de acessos e de testes de restauração têm também uma cópia durável fora dela (`interno-e-compartilhavel.md`). O que vai para o cliente fica em `docs/seguranca/` (`interno-e-compartilhavel.md`): o dossiê, as respostas ao questionário e os documentos que as skills das famílias geram dos modelos delas (política de segurança, plano de resposta a incidentes, continuidade, lista de subprocessadores). Ao fim de cada passo, o `STATUS.md` muda junto.

## Retomar

Se `.security-standard/STATUS.md` existe, leia-o com `config.yml`, `lacunas.md` e `plano.md` e siga do primeiro passo `pendente` ou `em andamento`. Tente de novo cada família `não instalada` (passo 4): a skill pode ter sido instalada depois. Compare `nivel_alvo` e `perfis` do `config.yml` com o cabeçalho do `STATUS.md`. Se um perfil mudou, reveja o nível alvo com `niveis-e-perfis.md` e confirme com o usuário. Se o nível alvo ou um perfil mudou, refaça os passos 4 a 6 e mantenha a evidência dos controles que continuam selecionados.

## Arquivo que já existe

Vale para todo passo que grava, a partir de um modelo de `assets/`, um arquivo em `.security-standard/` ou em `docs/seguranca/`: `STATUS.md`, `inventario.md`, `config.yml`, `lacunas.md`, `plano.md` e os documentos das famílias.

- Antes de gravar, confira se o arquivo já existe. Se existe, atualize no lugar: mantenha o conteúdo, mude só o que o passo pede e mostre ao usuário o que mudou, com as linhas de antes e as de depois. Nunca o regrave a partir do modelo.
- Registro só recebe entradas novas e nunca é regravado inteiro. São registros o Histórico do `STATUS.md`, as pastas de `evidencias/` e os registros das famílias, como o `registro-de-incidentes.md`.
- Vale também sem `STATUS.md`. Um `config.yml` escrito à mão antes da skill, por exemplo, é lido no passo 3: os valores dele são o ponto de partida, e só muda a chave que o usuário confirmar.

## 1. Pasta interna

- Crie `.security-standard/` e `.security-standard/evidencias/`.
- Se o projeto usa git, confira se a pasta já está ignorada (`git check-ignore -q .security-standard/` sai com 0) ou leia o `.gitignore` da raiz. Se não está, acrescente ao fim do `.gitignore` (crie o arquivo se não existir), em linha nova, o conteúdo de `assets/gitignore-trecho.txt`: se o arquivo não terminar com quebra de linha, acrescente uma antes, senão a última regra gruda no comentário e deixa de valer. Não mude nenhuma outra linha.
- Rode `git status --porcelain` antes de mexer no `.gitignore` e de novo no fim do passo, e compare as duas saídas. Só pode mudar a linha do `.gitignore` e sumir linha de `.security-standard/`, quando a pasta já existia sem estar ignorada. Nada mais muda, e nenhuma linha de `.security-standard/` aparece depois. A árvore pode já ter outras mudanças do usuário; elas aparecem iguais nas duas.
- Diga ao usuário que a pasta interna guarda o que mostra as fraquezas do sistema e por isso fica fora do git, e que o que vai para o cliente mora em `docs/seguranca/` (`interno-e-compartilhavel.md`).

## 2. Inventário

Leia sem rodar nada; as exceções são detectar as ferramentas instaladas com `command -v` e, se o `gh` existir, conferir a sessão com `gh auth status`, só leitura:

| O quê | Onde olhar |
|---|---|
| Stack | `package.json`, `requirements.txt`, `pyproject.toml`, `go.mod`, `Gemfile`, `pom.xml`, `composer.json`, arquivos de lock, configuração do framework |
| Hospedagem | `vercel.json`, `netlify.toml`, `Dockerfile`, `docker-compose.yml`, `fly.toml`, `render.yaml`, `app.yaml`, `Procfile` |
| Infraestrutura como código | `*.tf`, `cdk.json`, `Pulumi.yaml`, `serverless.yml`, pastas `k8s/`, `helm/` e `charts/` |
| CI e repositório | `.github/workflows/`, `.gitlab-ci.yml`, `bitbucket-pipelines.yml`, `.circleci/`, `.github/dependabot.yml`, `renovate.json`, `CODEOWNERS`, `SECURITY.md` |
| Dados | esquema e migrações (`prisma/schema.prisma`, `migrations/`, `*.sql`, modelos do ORM), formulários e integrações |
| Documentos | `docs/`, `README` e as políticas que já existirem |
| Ferramentas instaladas | `command -v gitleaks semgrep trivy osv-scanner checkov npm pip-audit gh`: só detecta, nunca instala; `gh auth status`, só leitura |

Depois de ler, pergunte numa lista só:

1. Quem são os clientes e de que setor (banco, instituição de pagamento, seguradora, órgão federal, outro)? Algum mandou questionário, anexo de segurança ou minuta de contrato? Qual é o prazo?
2. Que dados o sistema trata, e de quem? Há dado de saúde, de cartão, financeiro, de criança ou de adolescente?
3. Quantas pessoas há na equipe, quem responde por segurança e quem tem acesso à produção?
4. Onde ficam as contas de nuvem, do repositório e de identidade, e o que já está ligado nelas (por exemplo, MFA)? A resposta entra como declaração ou documento, porque a skill não lê essas contas.
5. A empresa já tem certificação, relatório de auditoria ou teste de intrusão? De quando?

Grave `inventario.md` a partir do modelo, ou atualize o que já existe ("Arquivo que já existe"), com a origem de cada item: `lido em <arquivo>`, `declarado pelo usuário em <data>` ou `documento <caminho>`.

## 3. Nível alvo e perfis

- Proponha o nível e os perfis com `niveis-e-perfis.md`, com o motivo de cada escolha em uma linha, e confirme com o usuário.
- Antes de ler um `config.yml` que já existe, confira a forma. A leitura só entende cada chave numa linha só, `chave: valor`, com os itens separados por vírgula na mesma linha, como `perfis: financeiro, saude`.
  - A forma não é suportada quando a linha de uma chave tem colchetes (`[` ou `]`) ou aspas (`"` ou `'`), ou quando as linhas logo abaixo dela começam com `- `, com ou sem recuo.
  - Nesse caso, avise o usuário, mostre a forma certa de cada chave assim e peça a correção antes de seguir. Com o OK dele, você pode corrigir no lugar, mostrando o antes e o depois.
  - A skill não adivinha o valor.
- Se `config.yml` já existe, mesmo escrito à mão e sem `STATUS.md`, não o grave a partir do modelo. Depois de conferir a forma, leia-o, use os valores dele como ponto de partida da proposta e mude no lugar só a chave que o usuário confirmar, mostrando a linha de antes e a de depois. Senão, grave `config.yml` a partir de `assets/config.yml`. Ponha em cada chave o valor do projeto; os exemplos ficam só nos comentários e nunca vão para o valor. A chave que não se aplica fica vazia (por exemplo, `url_publica:`). `perfis` lista só os perfis do projeto, nunca `todos`. Em `excluir`, cada id leva o motivo dentro do valor, depois de um travessão, sem dois-pontos e sem ` #` no motivo, separados por vírgula: `excluir: IAM-07 (motivo — …), DAT-03 (motivo — …)`. Dois-pontos seguido de espaço deixa o arquivo inválido como YAML, e ` #` corta o valor ali. Motivo em comentário `#` não vale, porque quem lê o arquivo descarta o comentário.
- Para ler o `config.yml` (na seleção do passo 5 e na retomada), use só as linhas que começam com `chave:`. O valor é o que vem depois de `chave:` até o primeiro ` #` (espaço seguido de #), que abre comentário como no YAML, ou até o fim da linha. Só então se aparam os espaços das pontas. Assim, `perfis: # nenhum por enquanto` dá valor vazio.
- `url_publica` é o endereço do próprio sistema, nunca o de terceiros; `repositorio_github` é `dono/nome`; `gancho_externo` é um comando só de leitura que o usuário indicou. A `security-automated-checks` lê essas três chaves.
- Sem resposta e sem `config.yml`, o modelo sem edição já é o padrão: `nivel_alvo: Essencial`, `perfis:` vazio. Com um `config.yml`, vale o que está nele ("Arquivo que já existe"). Registre "a confirmar" em Perguntas em aberto no `STATUS.md`.

## 4. Skills em ordem

Ordem: IAM, DAT, DEV, OPS, IRC, GOV (tabela do `SKILL.md`). Para cada família:

1. Liste no catálogo da família os controles selecionados pela regra do `SKILL.md`, passo 5. O catálogo fica em `"<pasta-base>"/../<skill>/references/controles-<família>.md`, sendo `<pasta-base>` a pasta desta skill, sempre entre aspas nos comandos, porque pode ter espaço; a raiz do projeto do usuário não serve de ponto de partida.
2. Carregue a skill dona e siga o roteiro dela: ela diz o que ler, o que perguntar e qual modelo usar para cada documento.
3. Junte as perguntas da família numa lista só; não pergunte controle por controle.
4. Cada controle avaliado vira uma linha no formato de `assets/lacunas.md`.

Só registre a família como `não instalada` no `STATUS.md` depois de procurar a pasta dela a partir da pasta-base desta skill, ou de a skill da família não carregar. Nesse caso, a família fica de fora e você avisa o usuário. Quem quer evidência verificada já na primeira passada roda o passo 7 antes deste.

## 5. Lacunas

A seleção é a regra do `SKILL.md`, passo 5. Se `lacunas.md` já existe, atualize as linhas no lugar e mantenha a evidência que continua valendo ("Arquivo que já existe"). Antes de gravar `lacunas.md`, confira:

- uma linha por controle selecionado e nenhuma a mais, na ordem das famílias (IAM, DAT, DEV, OPS, IRC, GOV) e, dentro delas, do id;
- todo `atendido` e todo `parcial` com tipo e evidência; a evidência diz o quê, onde e quando (arquivo lido, caminho em `evidencias/` ou "declarado pelo usuário em <data>") e, no `atendido`, o que prova o `Parâmetro` do nível alvo (data, frequência ou número), e não só "sim";
- todo `não se aplica` com o motivo;
- nenhum segredo, token ou valor de variável de ambiente na evidência; só o nome;
- pergunta sem resposta deixa a linha `ausente`, tipo `—` (o usuário não declarou nada), evidência "sem resposta em <data>", e entra em Perguntas em aberto no `STATUS.md`.

Conte as linhas por situação e por nível e passe a contagem para o `STATUS.md`.

## 6. Plano

Se `plano.md` já existe, atualize no lugar e mantenha dono, prazo e situação dos itens que continuam ("Arquivo que já existe"). Toda linha `ausente` ou `parcial` entra uma vez, no primeiro grupo em que couber:

1. **Risco alto que destrava a venda:** o que o cliente pediu por escrito (questionário, anexo, contrato) e o que deixa o dado exposto ou sem volta agora (segredo no código, acesso administrativo sem MFA, nenhuma cópia de segurança).
2. **Essencial que falta.**
3. **Fornecedor que falta.**
4. **Big tech que falta** (só existe com nível alvo Big tech).

Dentro do grupo, primeiro o que tem prazo do cliente; depois, o de menor esforço. O que fazer vem do `Como implementar` do controle e dos modelos da skill dona. Mudança no repositório do usuário (workflow de CI, CODEOWNERS, Dependabot ou Renovate, proteção de branch) entra no plano como proposta e só é aplicada com aprovação explícita.

## 7. Evidências

- Ofereça a `security-automated-checks`: ela roda só ferramentas já instaladas, sem varredura ativa, e grava cada rodada numa pasta nova em `.security-standard/evidencias/` (`<AAAA-MM-DD>/`, `<AAAA-MM-DD>-2/`…). As ferramentas de dependências consultam bases públicas de vulnerabilidade com o nome e a versão de cada pacote.
- Documento que o usuário entregar (política, relatório, exportação de configuração) vai para `.security-standard/evidencias/<AAAA-MM-DD>/`, sem segredo. Se essa pasta tem `resumo.md`, ela é de uma rodada: use a próxima sem `resumo.md`. Se o nome do arquivo já existe, acrescente `-2`; nada que já está em `evidencias/` é regravado.
- Atualize a linha do controle: `verificada` quando a ferramenta ou você leu no projeto; `documento` quando há o arquivo; `declarada` quando só há a palavra do usuário; `—` enquanto a pergunta segue sem resposta. Item do plano que ficou `feito` só muda a linha para `atendido` com a evidência.

## 8. Dossiê

Quando o usuário for mandar algo ao cliente, chame a `security-customer-evidence`. Ela lê `lacunas.md` e escreve em `docs/seguranca/` só os controles `atendido`, dizendo o tipo de cada evidência. Lacuna e plano não saem da pasta interna.
