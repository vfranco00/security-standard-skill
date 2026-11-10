---
name: security-automated-checks
description: Verificação automática de segurança, passiva, do repositório com as ferramentas abertas já instaladas — segredos no histórico do git, SAST, dependências vulneráveis (consultadas em bases públicas pelo nome e pela versão), infraestrutura como código, licenças, cabeçalhos HTTP do próprio sistema e proteção da branch no GitHub. Use quando o usuário pedir para rodar as verificações automáticas de segurança, varrer o repositório ou guardar evidência verificada dos controles. Roda o scripts/verificar.sh, que nunca instala nada (ferramenta ausente vira AUSENTE, com o comando de instalação só informado), grava as saídas sem os trechos de código e sem arquivo com padrão de chave em .security-standard/evidencias/ com a data e diz que controle cada resultado ajuda a verificar. Keywords automated security checks, security scan, secret scanning, SAST, SCA, dependency audit, IaC scanning, license scanning, security headers, branch protection, gitleaks, Semgrep, Trivy, osv-scanner, Checkov, npm audit, pip-audit.
license: MIT
metadata:
  version: "0.1.0"
  catalogo: "2026-11-09"
---

# Verificação automática de segurança

Roda sobre o repositório do usuário só as ferramentas abertas que já estão instaladas, de forma passiva, guarda as saídas como evidência com data e diz que controle cada resultado ajuda a verificar. Pela rede saem só as consultas às bases públicas de vulnerabilidade, com o nome e a versão das dependências (osv-scanner, npm audit e pip-audit), e o download das regras e das bases do Semgrep e do Trivy (`references/ferramentas.md`, "Rede"). Tudo passa pelo `scripts/verificar.sh`; como ler cada ferramenta está em `references/ferramentas.md`.

## Quando usar

- O usuário pede para rodar as verificações automáticas de segurança, varrer o repositório, procurar segredos, dependências vulneráveis ou falhas de configuração em Dockerfile e infraestrutura como código.
- A maestra `security-standard` chega ao passo 7 (evidências), ou a skill de uma família pede o resultado de uma varredura (gitleaks no IAM-06, `gh api` no DEV-02, Trivy no OPS-08, cabeçalhos no DAT-03 e no OPS-04).
- O usuário quer conferir os cabeçalhos HTTP do próprio sistema ou a proteção da branch principal no GitHub.
- Só em repositório cujo conteúdo o usuário conhece. Num pull request de terceiros ou num clone desconhecido, mostre antes os arquivos de configuração das ferramentas que estiverem na raiz (lista em `references/ferramentas.md`, "Arquivos do projeto que mudam as ferramentas").

## O que esta skill não faz

- Não instala ferramenta: a que falta vira `AUSENTE <ferramenta> (instale com: …)`, e instalar fica com o usuário.
- Não roda nada contra sistema de terceiros nem faz varredura ativa (DAST, varredura de portas, teste de intrusão). O `curl` lê só os cabeçalhos da `url_publica`, o endereço do próprio sistema; o `gh api` lê só a proteção do `repositorio_github`.
- Não lê conta de nuvem nem muda o repositório, o CI ou a configuração do GitHub.
- Não guarda trecho de código: os JSON do Trivy, do Checkov e do Semgrep ficam sem eles (é onde fica a senha de um `Dockerfile` ou de um `.tf`), e arquivo da rodada com chave da AWS, chave privada ou `sk-…` é apagado. A saída do gancho é texto livre e só passa por essa conferência de padrões.
- Não roda o Checkov quando a raiz tem `.checkov.yaml` ou `.checkov.yml` (`CONFERIR`), porque esse arquivo pode fazê-lo executar código do repositório; e o Trivy não lê o `trivy.yaml` nem o `trivy-secret.yaml` do projeto. Os outros arquivos de configuração das ferramentas no projeto continuam valendo e aparecem num aviso `CONFERIR`.
- Não regrava nem apaga o que já está em `.security-standard/evidencias/` (rodadas anteriores, documentos do usuário): cada rodada vai para uma pasta nova.
- Não roda o `gancho_externo` sem o usuário ver o comando e aceitar.
- Não escreve em `lacunas.md` nem em `docs/seguranca/`: a evidência vai para a maestra, que atualiza `lacunas.md`. Também não afirma conformidade nem certificação.

## Roteiro

1. **Raiz e pasta interna.** A raiz é a pasta do repositório do usuário. Confira que `.security-standard/` está fora do git (`git check-ignore -q .security-standard/` sai com 0); se não estiver, faça antes o passo 1 da maestra `security-standard`, que acrescenta o trecho ao `.gitignore`. Rodado sem isso, o script avisa com `CONFERIR .security-standard/ fora do .gitignore`.
2. **Configuração.** Leia `.security-standard/config.yml`, se existir, como o script lê (`references/ferramentas.md`, "O que o `config.yml` liga"): só a linha `chave:`; depois de `chave:`, o valor vai até o primeiro ` #` (espaço seguido de `#`), como no YAML, e só então se aparam os espaços, então `url_publica: # nenhum por enquanto` dá vazio; o exemplo do modelo também conta como vazio. As chaves usadas são `url_publica` (só `https://`), `repositorio_github` (`dono/nome`) e `gancho_externo`. São forma não suportada: a chave repetida; a chave seguida de linha recuada ou de lista (`- …`); a linha da chave com aspas ou colchetes em qualquer lugar, inclusive dentro do comando do gancho (`touch "a b"`), como na regra da maestra; e o valor que começa com um indicador do YAML (`|`, `>`, `&`, `*`, `!`, `%`, `@`, crase, `{`, `?`). O script pula a chave com esse aviso, mesmo com `--com-gancho`, e não monta comando nenhum. Mostre ao usuário a forma certa e peça a correção.
3. **Gancho.** Se `gancho_externo` tiver um comando numa forma suportada, mostre-o ao usuário exatamente como o script o lê (a linha `gancho_externo:` até o primeiro ` #`), diga que ele roda na raiz do projeto com a sessão dele e pergunte se pode rodar. Só depois do sim, passe `--com-gancho`. Sem resposta, rode sem a opção: o resumo diz `PULADO gancho_externo (rode com --com-gancho depois de conferir o comando)`.
4. **Rodar.** Com a pasta-base desta skill (a pasta deste `SKILL.md`) entre aspas, porque ela pode ter espaço: `bash "<pasta-base>/scripts/verificar.sh" "<raiz-do-projeto>"`, com `--com-gancho` antes da raiz só depois do sim. Antes, diga ao usuário que a rodada consulta bases públicas de vulnerabilidade com o nome e a versão das dependências. A rodada pode levar minutos num repositório médio (Semgrep, Trivy e Checkov): rode com tempo-limite de 10 minutos ou em segundo plano. Se ela for interrompida, o resumo da pasta diz `INTERROMPIDO`, e a saída da ferramenta em curso é apagada; rode de novo. Não instale nada nem rode as ferramentas por fora do script. Sem permissão para rodar comandos, passe ao usuário esse comando exato, diga o que ele faz (só as ferramentas instaladas rodam; a que falta vira `AUSENTE`, com o comando de instalação, e nada é instalado) e leia o `resumo.md` mais recente em `.security-standard/evidencias/` pela data de modificação (pelo nome, `-10` viria antes de `-2`), se houver.
5. **Ler.** Cada rodada grava numa pasta nova: `.security-standard/evidencias/<AAAA-MM-DD>/` ou, se essa já existe (uma rodada anterior do dia, ou documentos do usuário), `<AAAA-MM-DD>-2/`, `-3/` e assim por diante; o script nunca regrava nem apaga a evidência que já está lá. Ele imprime o `resumo.md` da pasta da rodada, que diz o nome dela (modelo em `assets/resumo-evidencias.md`): situação de cada ferramenta (`rodou`, `ausente`, `pulado`, `erro`), o arquivo e os achados por gravidade, e os avisos. Para o detalhe, abra os arquivos da tabela com `references/ferramentas.md`. Nunca copie para a resposta o valor de um segredo nem a linha em que ele aparece.
6. **Responder.** Diga ao usuário: o que rodou, com os achados por gravidade, os mais graves primeiro (arquivo, regra e pacote, sem valor); o que está `AUSENTE`, com o comando da linha "instale com" (instalar fica com ele); o que foi `PULADO` e por quê; o que pede `CONFERIR` (arquivo de configuração das ferramentas no projeto); os `ERRO`, com o arquivo para ver; o que foi `APAGADO`; e se a rodada foi interrompida (`INTERROMPIDO`).
7. **Evidência.** Diga que controle cada resultado ajuda a verificar (tabela abaixo) e entregue à maestra (passo 7 dela): a linha do controle em `.security-standard/lacunas.md` ganha o tipo `verificada` e, na evidência, o arquivo da pasta da rodada (por exemplo, `evidencias/<AAAA-MM-DD>-2/trivy.json`) e o que ele mostra. A ferramenta cobre só uma parte do "Como verificar" do controle; o resto (perguntas, documentos, o CI) continua com a skill da família. Fora da maestra, ofereça-a para levar as evidências ao `lacunas.md`.

## Controles desta skill

Esta skill não tem família própria: as saídas ajudam a verificar controles das famílias, cada um pelo "Como verificar" do próprio catálogo.

| Id | Título | Nível mínimo | Perfis | Ferramenta (arquivo na pasta da rodada) |
|---|---|---|---|---|
| IAM-06 | Segredos fora do código e em cofre | Essencial | todos | gitleaks (`gitleaks.json`), Trivy (`trivy.json`, segredos) |
| DAT-03 | TLS 1.2 ou superior e cabeçalho HSTS | Essencial | todos | curl (`cabecalhos.txt`, HSTS) |
| DAT-04 | Chaves em KMS ou HSM, com rotação de 90 a 365 dias | Essencial | todos | gitleaks (`gitleaks.json`), chave no histórico |
| DEV-02 | Revisão por outra pessoa e branch protegida | Essencial | todos | gh api (`branch-protection.json`) |
| DEV-09 | Prazos de correção por gravidade | Essencial | todos | osv-scanner, Trivy, npm audit, pip-audit e Semgrep: as vulnerabilidades abertas |
| DEV-15 | Segredos no CI | Essencial | todos | gitleaks (`gitleaks.json`) |
| DEV-24 | Consultas parametrizadas e saída codificada | Essencial | todos | Semgrep (`semgrep.json`), regras de injeção e XSS |
| DEV-25 | Cookies seguros e proteção contra CSRF | Essencial | todos | curl (`cabecalhos.txt`, `Set-Cookie`) |
| DEV-26 | Licenças das dependências e dos conteúdos de terceiros | Fornecedor | todos | Trivy (`trivy.json`, licenças) |
| OPS-01 | Hardening e imagens mínimas | Essencial | todos | Checkov (`checkov.json`), Trivy (`trivy.json`, configuração) |
| OPS-04 | TLS e cabeçalhos de segurança | Essencial | todos | curl (`cabecalhos.txt`) |
| OPS-08 | Vulnerabilidades e correções da infraestrutura | Essencial | todos | Trivy (`trivy.json`), osv-scanner (`osv.json`) |
| OPS-09 | Postura da nuvem e infraestrutura como código verificadas | Essencial | todos | Checkov (`checkov.json`), Trivy (`trivy.json`, configuração) |

O `gancho_externo` ajuda no controle que a ferramenta dele cobrir. Nenhuma execução local atende o DEV-03, que pede SAST, SCA e varredura de segredos no CI a cada pull request: isso se lê em `.github/workflows/`, com a skill `security-secure-development`. Para a lista dos controles selecionados, siga a maestra; os catálogos ficam em `"<pasta-base>"/../security-*/references/controles-*.md`.

## Erros comuns

- Instalar a ferramenta que falta, ou trocar o `pip-audit -f json` por `pip-audit -r requirements.txt`, que instala as dependências num ambiente temporário: a skill só informa o comando de instalação.
- Rodar o `gancho_externo` sem mostrar o comando e sem o sim do usuário: ele vem de um arquivo do repositório, e uma mudança nesse arquivo trocaria o que roda.
- Apontar o `curl` para endereço de terceiros, ou trocar a leitura de cabeçalhos por varredura ativa (ZAP, nmap, nikto): a skill só lê os cabeçalhos do próprio sistema.
- Copiar o valor de um segredo, ou a linha em que ele está, para a resposta, para `lacunas.md` ou para `docs/seguranca/`.
- Ler "0 achados" como controle atendido: a ferramenta cobre parte do "Como verificar"; o DEV-03, por exemplo, pede os jobs no CI, não uma execução local.
- Ler o `erro` do `gh api` com `Branch not protected` como falha da ferramenta: é a evidência de que a branch não tem proteção (DEV-02 ausente, `verificada`).
- Contar as licenças `LOW` do Trivy como problema: é a classificação das permissivas; conferem-se as `CRITICAL`, `HIGH` e `UNKNOWN`.
- Rodar o pip-audit fora do ambiente virtual do projeto e tomar o resultado como o do projeto: sem argumento, ele audita o ambiente Python ativo.
- Trocar o `p/default` por `--config auto` no Semgrep, ou tirar o `--metrics off`: o `auto` entra no registro com a URL do projeto.
- Pôr a saída das ferramentas em `docs/seguranca/` ou no git: ela fica em `.security-standard/evidencias/`, que é interna.
- Apagar ou regravar uma pasta de `evidencias/` para rodar de novo: as pastas são registro; a rodada nova vai sozinha para `<AAAA-MM-DD>-2/`, e a evidência citada no `lacunas.md` é a da pasta que o resumo indicar.
- Rodar o Checkov à mão num projeto com `.checkov.yaml`, ou tirar o `--config /dev/null` do Trivy, sem ler os arquivos do projeto: eles podem fazer a ferramenta executar código do repositório ou mandar dados a um servidor de fora.
- Dizer ao usuário que a evidência não guarda segredo nenhum: o que se garante é que os trechos de código saem dos JSON e que arquivo com chave da AWS, chave privada ou `sk-…` é apagado. A pasta continua interna.

## Arquivos

- `scripts/verificar.sh`: roda as ferramentas instaladas, grava numa pasta nova a cada rodada, tira dos JSON os trechos de código, apaga a saída com padrão de chave, grava e imprime o `resumo.md`. Uso: `bash "<pasta-base>/scripts/verificar.sh" [--com-gancho] "<raiz-do-projeto>"`; sai com 0 mesmo com ferramenta ausente.
- `references/ferramentas.md`: o que cada ferramenta cobre, o comando passivo, quando roda, como instalar (só informado), como ler a saída, o que vai pela rede e as fontes.
- `assets/resumo-evidencias.md`: o modelo do `resumo.md`, que o script preenche.
