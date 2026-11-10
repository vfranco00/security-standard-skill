---
name: security-identity-access
description: Organiza identidade e acessos de um projeto de software no padrão que grandes clientes cobram de fornecedores e que as big techs praticam, com os controles IAM-01 a IAM-14, cada um com nível (Essencial, Fornecedor, Big tech), parâmetro e fonte. Cobre MFA resistente a phishing, SSO, acesso à produção sem privilégio permanente, menor privilégio e revisão trimestral, contas de emergência, segredos em cofre, rotação de credenciais, revogação no desligamento, contas de serviço, conta raiz da nuvem, registro de acesso administrativo, dispositivo gerenciado, senhas da PCI DSS e acesso ao cliente financeiro, com a matriz de acessos. Use para organizar os acessos da equipe à produção, responder perguntas de acesso de um questionário de segurança ou preparar a avaliação de um grande cliente (identity and access management, phishing-resistant MFA, SSO, least privilege, access review, just-in-time access, break-glass, secrets management, offboarding, service accounts, root account).
license: MIT
metadata:
  version: "0.1.0"
  catalogo: "2026-11-09"
---

# Identidade e acessos

Leva os acessos da equipe à produção ao padrão que um grande cliente cobra na avaliação de fornecedor e que as big techs praticam por dentro. Trabalha com 14 controles, IAM-01 a IAM-14, em `references/controles-iam.md`: cada um com nível mínimo, perfis, parâmetro verificável e fontes com tipo, URL e data.

## Quando usar

- Pedido para organizar, revisar ou documentar os acessos da equipe à produção, à nuvem, ao repositório de código ou ao banco de dados.
- Questionário de segurança (CAIQ, SIG, anexo de um cliente) com perguntas de controle de acesso, MFA, contas privilegiadas, desligamento, segredos ou contas de serviço.
- A skill `security-standard` (a maestra) chegou à família IAM no plano.
- Cliente do setor financeiro pede a lista de quem acessa o ambiente dele ou cobra MFA no acesso externo.

## O que esta skill não faz

- Não lê contas de nuvem nem provedores de identidade e não roda comando neles: pede exportação, captura ou declaração e registra o tipo da evidência.
- Não muda configuração de conta nem de produção: propõe a mudança, e o usuário aplica. Arquivo do repositório (infraestrutura como código, CI) só muda com aprovação explícita.
- Não cobre a autenticação dos usuários finais do sistema (login, guarda de senhas, sessão), que é da `security-secure-development`, nem a retenção dos logs, que é da `security-infra-operations`.
- Não certifica nem afirma conformidade: diz o que está atendido, com evidência, e o que falta.
- Não trata a LGPD em detalhe; para isso existe a `lgpd-skill`, se estiver instalada.

## Roteiro

1. **Leia o catálogo.** Abra `references/controles-iam.md`. Cada bloco traz Enunciado, Nível mínimo, Perfis, Parâmetro, Por quê, Fontes, Como verificar, Como implementar, Evidência e Mapa. Os níveis são cumulativos: o Fornecedor soma ao Essencial, e o Big tech soma aos dois. Número seguido de `(proposta)` é proposta da skill, sem fonte primária para o número; nunca o apresente como exigência.
2. **Leia o estado do projeto.** Se existir `.security-standard/`, leia `config.yml` (`nivel_alvo`, `perfis`, `excluir`), `inventario.md` e `lacunas.md`. Se não existir, sugira começar pela `security-standard`, que cria a pasta, o `.gitignore` e o inventário. Se o usuário quiser só esta família, crie `.security-standard/`, acrescente `.security-standard/` ao `.gitignore` e pergunte o nível alvo e os perfis do cliente e do dado. Se for só uma pergunta, sem projeto para ler, responda já, com o nível alvo pela regra da maestra (Fornecedor quando um cliente grande vai avaliar o fornecedor; sem pista, Essencial): diga que é uma suposição, mostre o IAM-11 e o IAM-14 como condicionais aos perfis e pergunte quais perfis valem.
3. **Selecione os controles.** Entram os de nível mínimo até o nível alvo e com Perfis `todos` ou com um dos perfis do projeto: `cartoes` liga o IAM-11, e `financeiro` liga o IAM-14. As orações "no perfil X" do trecho Essencial (`cartoes` no IAM-04, IAM-07, IAM-08 e IAM-09; `financeiro` no IAM-12) valem em qualquer nível alvo quando o projeto tem o perfil. No IAM-09, o trecho Essencial só traz a regra do perfil `cartoes`: num projeto Essencial sem esse perfil, a linha dele fica `não se aplica`, tipo `declarada` (a lista de perfis é declaração do usuário no `config.yml`), com o motivo "regra só do perfil cartoes". A partir do Fornecedor, a regra geral do IAM-09 vale também no perfil `cartoes` e não admite a exceção de uso interativo que o Essencial do perfil aceita. Controle listado em `excluir` fica como `não se aplica`, tipo `declarada`, com o motivo que vem dentro do valor no `config.yml` (`IAM-07 (motivo — …)`) na evidência.
4. **Leia o que dá para ler, sem acessar contas.** No repositório: infraestrutura como código (papéis, políticas de MFA, contas de serviço), workflows de CI (como os segredos chegam), arquivos `.env` e de credenciais versionados, `.gitignore`. Em `.security-standard/evidencias/`: a varredura de segredos da `security-automated-checks`, se houver. O que for lido assim é evidência `verificada`.
5. **Pergunte o resto de uma vez, por controle.** Use o Como verificar de cada bloco. Peça exportações (relatório de métodos de MFA, contas e papéis por sistema, registro da última revisão, pedidos de elevação, configuração da conta raiz). O que vier anexado é `documento`; o que for só resposta é `declarada`; pergunta sem resposta deixa o controle `ausente`, com tipo `—`.
6. **Monte a matriz de acessos.** Antes de copiar, confira se `.security-standard/matriz-de-acessos.md` já existe. Se não existe, copie para lá `assets/matriz-de-acessos.md` e troque `{{data}}` pela data de hoje. Se existe, atualize-a no lugar, mantendo o que está lá, e mostre ao usuário o que mudou; nunca copie o modelo por cima. As seções de elevações, revisões e desligamentos (4, 7 e 8) são registro: só recebem linhas novas e nunca são regravadas inteiras. Preencha com o que foi lido e respondido. Ela tem nomes e fica interna.
7. **Registre as lacunas.** Em `.security-standard/lacunas.md`, uma linha por controle selecionado, no formato da maestra: `id | título | nível | situação | tipo de evidência | evidência | próxima ação`. Situação: `atendido`, `parcial`, `ausente` ou `não se aplica`. Tipo de evidência: `verificada`, `documento`, `declarada` ou `—` (só em `ausente`, quando o usuário não respondeu). Nunca marque `atendido` sem a evidência e o tipo dela.
8. **Guarde as evidências.** Em `.security-standard/evidencias/<AAAA-MM-DD>/`, com o id no nome do arquivo (`IAM-01-metodos-de-mfa.csv`). Se a pasta do dia tem `resumo.md`, ela é de uma rodada da `security-automated-checks`: use a próxima sem `resumo.md` (`<AAAA-MM-DD>-2/`, `-3/`). Se o nome do arquivo já existe, acrescente `-2`; nada que já está em `evidencias/` é regravado. Corte os valores antes de salvar: nenhuma senha, chave, token ou código de recuperação.
9. **Proponha as próximas ações.** Para cada lacuna, use o Como implementar do bloco, na ordem do plano da maestra: primeiro o risco alto que destrava a venda, depois o Essencial que falta, depois o Fornecedor e por fim o Big tech. No Essencial, MFA (IAM-01), desligamento (IAM-08), segredos (IAM-06) e conta raiz (IAM-10) vêm antes. O plano consolidado fica em `.security-standard/plano.md`.
10. **Responda ao usuário.** Cite cada controle pelo id, com o nível, o parâmetro do nível alvo e o tipo das fontes (`primária`, `secundária` ou `proposta`); diga quais números são proposta da skill. Nada desta skill vai para `docs/seguranca/`: o dossiê para o cliente sai da `security-customer-evidence`, só com o que está atendido. Ao cliente financeiro que pedir a lista de quem acessa o ambiente dele (IAM-14), entregue só o recorte daquele cliente.

## Controles desta skill

| Id | Título | Nível mínimo | Perfis |
|---|---|---|---|
| IAM-01 | MFA resistente a phishing | Essencial | todos |
| IAM-02 | Conta individual e SSO | Essencial | todos |
| IAM-03 | Sem acesso permanente à produção | Fornecedor | todos |
| IAM-04 | Menor privilégio e revisão trimestral de acessos | Essencial | todos |
| IAM-05 | Contas de emergência guardadas e auditadas | Fornecedor | todos |
| IAM-06 | Segredos fora do código e em cofre | Essencial | todos |
| IAM-07 | Rotação de credenciais | Essencial | todos |
| IAM-08 | Revogação no mesmo dia do desligamento | Essencial | todos |
| IAM-09 | Contas de serviço com dono e escopo | Essencial | todos |
| IAM-10 | Conta raiz da nuvem protegida | Essencial | todos |
| IAM-11 | Senhas no padrão da PCI DSS 4.0.1 | Essencial | cartoes |
| IAM-12 | Registro de todo acesso administrativo | Essencial | todos |
| IAM-13 | Dispositivo identificado para acessar a produção | Big tech | todos |
| IAM-14 | Acesso da equipe ao ambiente do cliente financeiro | Essencial | financeiro |

Tabela gerada a partir dos blocos de `references/controles-iam.md`; se um bloco mudar, a tabela muda junto. No campo Mapa dos blocos, `CAIQ: IAM-14` e afins são identificadores do CCM/CAIQ v4.1, não controles deste catálogo.

## Erros comuns

- **Chamar de resistente a phishing o código por SMS, ligação ou aplicativo.** Não é: só resiste o fator criptográfico preso ao site, como chave FIDO2, passkey ou certificado (NIST SP 800-63B-4). O Fornecedor exige isso dos administradores; o Big tech, de todos (IAM-01).
- **Escrever "revogação em até 24 horas".** As fontes dizem no mesmo dia e de imediato (IAM-08).
- **Impor troca periódica da senha de pessoas.** O NIST proíbe; a troca a cada 90 dias só vale no perfil `cartoes`, quando a senha é o único fator (IAM-07, IAM-11).
- **Apagar o segredo do último commit e dar o caso por encerrado.** O histórico e as cópias guardam o valor: revogue e troque (IAM-06, IAM-07).
- **Tirar a conta de emergência do MFA.** Ela entra com um fator resistente a phishing próprio, diferente do usado no dia a dia (IAM-05).
- **Usar conta de serviço para entrar como pessoa, ou conta de pessoa para automação** (IAM-09).
- **Dar o perfil `financeiro` por resolvido com MFA.** As Res. CMN 4.893 e BCB 85 também cobram a revisão dos acessos de terceirizados: a lista de quem acessa o ambiente do cliente e o aviso de cada saída (IAM-14).
- **Apresentar declaração como verificação**, ou citar número `(proposta)` como exigência.
- **Pôr a matriz de acessos ou a lista de nomes em `docs/seguranca/`.**
- **Pedir ao usuário credencial para ler a conta dele**, ou rodar comando no provedor por ele: a evidência de conta vem por exportação, captura ou declaração.

## Arquivos

- `references/controles-iam.md`: os 14 controles; fonte de verdade da família.
- `assets/matriz-de-acessos.md`: modelo da matriz (sistemas, papéis, pessoas, elevações, contas de serviço, conta raiz e emergência, revisões, desligamentos e acessos a clientes).
- No projeto do usuário: `.security-standard/matriz-de-acessos.md`, as linhas IAM de `.security-standard/lacunas.md` e `.security-standard/evidencias/<AAAA-MM-DD>/`.
- Skills vizinhas: `security-standard` (maestra), `security-secure-development` (autenticação dos usuários do sistema e segredos no CI), `security-infra-operations` (retenção dos logs e canal do acesso administrativo), `security-automated-checks` (varredura de segredos) e `security-customer-evidence` (dossiê).
