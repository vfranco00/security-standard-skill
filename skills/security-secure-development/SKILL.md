---
name: security-secure-development
description: Desenvolvimento seguro no padrão das big techs e das exigências de grandes clientes, com 26 controles com fonte e parâmetro por nível (DEV-01 a DEV-26) — revisão por outra pessoa e proteção de branch, SAST, SCA e segredos no CI, dependências e Dependabot, SBOM, proveniência SLSA, prazos de correção por gravidade, SECURITY.md e divulgação de vulnerabilidades, OWASP Top 10:2025 e ASVS 5.0, autenticação, senhas, autorização, injeção, CSRF e licenças. Use para montar o pipeline de segurança do repositório GitHub ou a política de correção de vulnerabilidades. Keywords secure development, SDLC, AppSec, DevSecOps, CI security pipeline, GitHub Actions, code review, branch protection, SAST, SCA, secret scanning, SBOM, SLSA, vulnerability remediation SLA, vulnerability disclosure policy, OWASP ASVS.
license: MIT
metadata:
  version: "0.1.0"
  catalogo: "2026-11-09"
---

# Desenvolvimento seguro

Leva o processo de desenvolvimento de um projeto ao nível alvo (Essencial, Fornecedor ou Big tech) com os 26 controles da família DEV. Cada controle traz o parâmetro de cada nível, as fontes com URL e data, como verificar, como implementar e a evidência a guardar. Os modelos de `assets/` montam o pipeline de segurança no GitHub e a política de correção de vulnerabilidades.

## Quando usar

- Montar ou revisar o pipeline de segurança do repositório: SAST, SCA, varredura de segredos, Dependabot, CODEOWNERS e proteção de branch.
- Escrever a política de correção de vulnerabilidades por gravidade, o `SECURITY.md` ou a política de divulgação.
- Responder às perguntas de desenvolvimento seguro de um questionário de cliente (CAIQ, SIG, anexo de segurança).
- Avaliar SBOM, proveniência (SLSA), revisão de código gerado por IA ou os controles da aplicação: autenticação, senhas, autorização, injeção, cookies e CSRF.
- Quando a maestra `security-standard` chegar à família DEV.

## O que esta skill não faz

- Não roda scanner: quem roda as ferramentas instaladas é a `security-automated-checks`.
- Não grava nada no repositório do usuário nem muda configuração do GitHub sem aprovação explícita.
- Não instala ferramenta nem roda nada contra sistema de terceiros.
- Não certifica nem afirma conformidade com ASVS, SLSA, PCI DSS ou qualquer outra norma: registra cada controle como atendido, parcial, ausente ou não se aplica, com a evidência e o tipo dela.
- Não copia o texto do ASVS (CC BY-SA 4.0) nem de outro framework licenciado: cita o identificador e escreve com palavras próprias.
- Não cobre os acessos da equipe (família IAM), criptografia e backup (DAT), hardening, logs e teste de intrusão anual (OPS), incidentes (IRC) nem políticas gerais e fornecedores (GOV).

## Roteiro

1. Leia `.security-standard/config.yml` e `.security-standard/STATUS.md`, se existirem. No `config.yml`, leia só as linhas `chave: valor` (a que começa com `#` é comentário): `nivel_alvo`, `perfis` e `excluir`, em que cada controle excluído traz o motivo no próprio valor, depois de um travessão, como `DEV-11 (motivo — sem orçamento para recompensa)`. O valor vai até o primeiro ` #` (espaço seguido de `#`), e só então se aparam os espaços: `perfis: # nenhum por enquanto` dá valor vazio. Valor vazio ou que começa com `<` conta como não informado, com aviso ao usuário. Sem nível alvo, pergunte; se o usuário não souber, use Essencial e diga isso na resposta.
2. Leia `references/controles-dev.md`. Os níveis são cumulativos: no Fornecedor valem os controles Essencial e Fornecedor, com o parâmetro do Fornecedor onde ele muda. Os 26 controles valem para todos os perfis. Cite sempre o id (DEV-01 a DEV-26), o parâmetro do nível alvo e a fonte; o que o controle marca como proposta é apresentado como proposta. Pedido de pipeline: no Essencial, DEV-02, DEV-03, DEV-04, DEV-06, DEV-07, DEV-15, DEV-16 e DEV-20; no Fornecedor e no Big tech, também DEV-05 (SBOM), DEV-13 (configuração como código), DEV-14 (testes e DAST) e DEV-26 (licenças), que o `assets/ci-seguranca.yml` não cobre. Pedido de política de correção: DEV-09 e DEV-10. Os demais controles do nível alvo, como o DEV-18 e os de aplicação (DEV-21 a DEV-25), entram em `lacunas.md`.
3. Leia o repositório, só para ler: `.github/workflows/`, `.github/dependabot.yml` ou `renovate.json`, `.github/CODEOWNERS`, `SECURITY.md`, os arquivos de trava das dependências, `.gitleaks.toml`, `osv-scanner.toml`, os testes de segurança e o código de autenticação, autorização, senhas, consultas e cookies. Aproveite o que a `security-automated-checks` já gravou em `.security-standard/evidencias/` (por exemplo, a proteção de branch lida pelo `gh api`). Painel de nuvem e de hospedagem quem abre é o usuário, e valor de segredo nunca se imprime: compare só nomes. Teste ativo, como os do "Como verificar" do DEV-21, do DEV-23 e do DEV-25, só roda em homologação, com o OK do usuário, nunca em produção.
4. Pergunte o que não dá para ler: plano do GitHub e visibilidade do repositório (a proteção de branch em repositório privado e os atestados de proveniência dependem do plano), quem revisa os PRs, como é feito o deploy, treinamento, uso de ferramentas de IA e o canal de relato de vulnerabilidades.
5. Para cada controle do nível alvo, grave uma linha em `.security-standard/lacunas.md` (`id | título | nível | situação | tipo de evidência | evidência | próxima ação`), com a situação atendido, parcial, ausente ou não se aplica e o tipo de evidência verificada, documento ou declarada, ou `—` só na linha ausente em que o usuário não respondeu. O controle listado em `excluir` entra como não se aplica, tipo declarada, com o motivo do `config.yml` na evidência. Se o `lacunas.md` já existe, atualize só as linhas DEV e mantenha as das outras famílias. Nunca marque atendido sem evidência.
6. Proponha as mudanças a partir de `assets/`: `ci-seguranca.yml` em `.github/workflows/`, `dependabot.yml` e `CODEOWNERS` em `.github/` e `SECURITY.md` na raiz. Antes de copiar cada modelo, confira se o arquivo de destino já existe. Se existe, atualize no lugar, mantendo o que está lá, e mostre ao usuário o que mudou; nunca sobrescreva arquivo do usuário. Em todos os casos, mostre o conteúdo e peça aprovação antes de gravar. Preencha os `{{campos}}`, troque `main` pela branch principal e apague a linha "Gerado pela security-standard-skill" depois de revisado. O `ci-seguranca.yml` não foi executado no GitHub Actions nesta versão: veja os três jobs rodarem num pull request de teste antes de torná-los obrigatórios (DEV-02).
7. Gere a política de correção a partir de `assets/politica-de-correcao-por-gravidade.md`, com a coluna do nível alvo, em `docs/seguranca/politica-de-correcao-por-gravidade.md`, que pode ir para o cliente. Antes de gravar, confira se o arquivo já existe. Se existe, atualize no lugar, mantendo o que está lá (inclusive quem aprovou e quando), e mostre ao usuário o que mudou; o registro de exceções só recebe entradas novas e nunca é regravado inteiro. Grave só com a aprovação do usuário.
8. Liste para o usuário as opções de proteção de branch a ligar (DEV-02) e os checks obrigatórios (os três jobs do `ci-seguranca.yml`). Mudar a configuração do GitHub fica com ele, ou com você só depois de aprovação explícita.
9. Leve as lacunas para `.security-standard/plano.md` (a ordem do plano é a da maestra) e atualize `.security-standard/STATUS.md`. Lacuna, saída de scanner e segredo nunca vão para `docs/seguranca/`.

## Controles desta skill

| Id | Título | Nível mínimo | Perfis |
|---|---|---|---|
| DEV-01 | Modelagem de ameaças das funcionalidades sensíveis | Fornecedor | todos |
| DEV-02 | Revisão por outra pessoa e branch protegida | Essencial | todos |
| DEV-03 | SAST, SCA e varredura de segredos no CI | Essencial | todos |
| DEV-04 | Política de dependências e atualização automática | Essencial | todos |
| DEV-05 | SBOM de cada release | Fornecedor | todos |
| DEV-06 | Proveniência e assinatura das releases (SLSA) | Essencial | todos |
| DEV-07 | Build isolado de pessoas e de outros builds | Essencial | todos |
| DEV-08 | Revisão de segurança antes de lançar | Fornecedor | todos |
| DEV-09 | Prazos de correção por gravidade | Essencial | todos |
| DEV-10 | SECURITY.md e política de divulgação de vulnerabilidades | Essencial | todos |
| DEV-11 | Programa de recompensa por vulnerabilidades | Big tech | todos |
| DEV-12 | Ambientes de desenvolvimento, teste e produção separados | Essencial | todos |
| DEV-13 | Configuração como código, revisada como código | Fornecedor | todos |
| DEV-14 | Testes de segurança automatizados | Fornecedor | todos |
| DEV-15 | Segredos no CI | Essencial | todos |
| DEV-16 | Registro de deploy | Essencial | todos |
| DEV-17 | Treinamento em desenvolvimento seguro | Essencial | todos |
| DEV-18 | OWASP Top 10:2025 e ASVS 5.0 como requisitos | Essencial | todos |
| DEV-19 | Linguagens, frameworks e bibliotecas com manutenção ativa | Essencial | todos |
| DEV-20 | Código gerado por IA com as mesmas regras | Essencial | todos |
| DEV-21 | Autenticação dos usuários do sistema | Essencial | todos |
| DEV-22 | Senhas guardadas com função de hash de senha | Essencial | todos |
| DEV-23 | Autorização no servidor, por função e por objeto | Essencial | todos |
| DEV-24 | Consultas parametrizadas e saída codificada | Essencial | todos |
| DEV-25 | Cookies seguros e proteção contra CSRF | Essencial | todos |
| DEV-26 | Licenças das dependências e dos conteúdos de terceiros | Fornecedor | todos |

## Erros comuns

- Dizer que a PCI DSS exige 30 dias para toda vulnerabilidade, ou para as altas: na v4.0.1, o requisito 6.3.3 fixa 30 dias só para as críticas e deixa as demais no prazo da entidade. SOC 2 e ISO/IEC 27001 não fixam prazo.
- Citar a BOD 22-01 ou a BOD 19-02 da CISA: as duas foram revogadas pela BOD 26-04, de 10/06/2026, que mede o prazo pela exposição, pelo KEV, pela automação da exploração e pelo impacto técnico.
- Apresentar os prazos da PCI DSS ou da BOD 26-04 como obrigação de todo fornecedor: a PCI obriga quem trata cartão e a BOD obriga órgãos federais dos EUA. Aqui elas são régua, e o DEV-09 diz o que é proposta.
- Exigir SLSA Build L3 no Essencial, ou dizer que "o GitHub dá SLSA" sem olhar o plano: o atestado de proveniência do GitHub dá Build L2, chega ao L3 com fluxo reutilizável e, em repositório privado, só existe no GitHub Enterprise Cloud.
- Prometer proteção de branch ou CODEOWNERS em repositório privado no plano gratuito do GitHub: nesse plano, os dois só existem em repositório público. Registre o DEV-02 como parcial.
- Usar recurso pago sem avisar: code scanning e secret scanning do GitHub em repositório privado dependem de licença paga. O `gitleaks-action` não é pago, mas pede cadastro e chave em conta de organização. O `assets/ci-seguranca.yml` usa as imagens oficiais do Semgrep, do gitleaks e do osv-scanner, sem conta.
- Achar que o Dependabot mantém as imagens do `ci-seguranca.yml` em dia: ele atualiza só as actions de `uses:`. As três imagens se atualizam pelo Renovate ou à mão (DEV-04).
- Fixar action por tag (`@v4`): a tag pode mudar de commit. Fixe pelo SHA completo, com a versão em comentário, como no `assets/ci-seguranca.yml`.
- Copiar o texto dos requisitos do ASVS: cite o identificador com a versão (por exemplo, v5.0.0-1.2.4) e escreva com palavras próprias.
- Marcar um controle como atendido porque a ferramenta existe: vale a evidência (execução no PR, regra de proteção exportada, política aprovada) e o tipo dela.
- Escrever "conforme" ou "certificado" para o cliente: a skill registra "atendido com evidência", nunca conformidade.
- Gravar prazos estourados, lacunas ou saída de scanner em `docs/seguranca/`: lá só vai o que pode sair para o cliente.

## Arquivos

- `references/controles-dev.md`: os 26 controles DEV-01 a DEV-26, no formato de `docs/formato-dos-controles.md`.
- `assets/ci-seguranca.yml`: workflow do GitHub Actions com Semgrep (SAST), gitleaks (segredos) e osv-scanner (SCA), com `permissions: contents: read`, actions fixadas por SHA e imagens por digest.
- `assets/dependabot.yml`: atualização automática semanal das dependências e das actions (Dependabot v2).
- `assets/CODEOWNERS`: donos dos caminhos sensíveis, com marcadores no lugar dos nomes.
- `assets/SECURITY.md`: política de divulgação de vulnerabilidades, com canal, prazos e pesquisa de boa-fé.
- `assets/politica-de-correcao-por-gravidade.md`: prazos por gravidade e por nível, exceções, responsáveis e medida.
