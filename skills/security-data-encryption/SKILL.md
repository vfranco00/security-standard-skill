---
name: security-data-encryption
description: Protege os dados de um sistema no padrão que grandes clientes cobram de fornecedores e que as big techs praticam, com os controles DAT-01 a DAT-15, cada um com nível (Essencial, Fornecedor, Big tech), parâmetro e fonte. Cobre classificação, criptografia em repouso e em trânsito (TLS 1.2 ou superior), chaves em KMS ou HSM com rotação de 90 a 365 dias, backup imutável com restauração testada, RPO e RTO medidos, tabela de guarda, localização dos dados, mascaramento em teste, logs sem segredos, devolução no fim do contrato, troca de arquivos, pseudonimização e eliminação a pedido do titular. Use quando perguntarem que regras de criptografia, chaves e backup um grande cliente vai exigir, ao responder essas perguntas num questionário de segurança ou ao preparar a avaliação de fornecedor (data protection, encryption at rest, encryption in transit, key management, KMS, HSM, key rotation, backup, restore test, RPO, RTO, data retention, data deletion, data residency, data masking).
license: MIT
metadata:
  version: "0.1.0"
  catalogo: "2026-11-09"
---

# Dados e criptografia

Leva a proteção dos dados do sistema ao padrão que um grande cliente cobra na avaliação de fornecedor e que as big techs praticam por dentro: classificação, criptografia, chaves, cópias de segurança, recuperação, guarda e eliminação. Trabalha com 15 controles, DAT-01 a DAT-15, em `references/controles-dat.md`: cada um com nível mínimo, perfis, parâmetro verificável e fontes com tipo, URL e data.

## Quando usar

- Pergunta sobre o que um cliente grande vai exigir de criptografia, chaves, backup, recuperação, retenção ou eliminação de dados.
- Questionário de segurança (CAIQ, SIG, anexo de um cliente) com perguntas de criptografia em repouso e em trânsito, gestão de chaves, backup, RPO e RTO, localização dos dados, dados em teste, devolução no fim do contrato ou eliminação.
- A skill `security-standard` (a maestra) chegou à família DAT no plano.
- Cliente do setor financeiro, de seguros ou do setor público pede as cláusulas de localização, transmissão, armazenamento, devolução e exclusão dos dados.

## O que esta skill não faz

- Não lê contas de nuvem, consoles de banco nem cofres de chaves e não roda comando neles: pede exportação, captura ou declaração e registra o tipo da evidência.
- Não restaura cópia, não apaga dado, não troca chave e não muda configuração de produção: propõe a mudança, e o usuário aplica. Arquivo do repositório (infraestrutura como código, CI) só muda com aprovação explícita.
- Não cobre senhas, tokens e chaves de API das pessoas e das integrações (família IAM), os cabeçalhos de segurança além do HSTS, o conteúdo e a guarda dos logs e a recriação da infraestrutura (família OPS), nem o plano de continuidade do negócio (família IRC).
- Não certifica nem afirma conformidade: diz o que está atendido, com evidência, e o que falta.
- Não trata a LGPD em detalhe (base legal, transferência internacional, atendimento ao titular); para isso existe a `lgpd-skill`, se estiver instalada.

## Roteiro

1. **Leia o catálogo.** Abra `references/controles-dat.md`. Cada bloco traz Enunciado, Nível mínimo, Perfis, Parâmetro, Por quê, Fontes, Como verificar, Como implementar, Evidência e Mapa. Os níveis são cumulativos: o Fornecedor soma ao Essencial, e o Big tech soma aos dois. Os 15 controles valem para `todos`; o que só vale com um perfil aparece no trecho Essencial do Parâmetro como "no perfil X", porque vale em qualquer nível alvo. Número seguido de `(proposta)` é proposta da skill, sem fonte primária para o número; nunca o apresente como exigência.
2. **Leia o estado do projeto.** Se existir `.security-standard/`, leia `config.yml` (`nivel_alvo`, `perfis`, `excluir`), `inventario.md` e `lacunas.md`. Se não existir, sugira começar pela `security-standard`, que cria a pasta, o `.gitignore` e o inventário. Se o usuário quiser só esta família, crie `.security-standard/`, acrescente `.security-standard/` ao `.gitignore` e pergunte o nível alvo e os perfis do cliente e do dado. Se for só uma pergunta, sem projeto para ler, responda já, com o nível alvo pela regra da maestra (`../security-standard/references/niveis-e-perfis.md`): Fornecedor quando um cliente grande vai avaliar o fornecedor ou quando o cliente é banco, instituição de pagamento, seguradora ou órgão público; sem pista, Essencial. Diga que é uma suposição, mostre as regras "no perfil X" como condicionais e pergunte quais perfis valem.
3. **Selecione os controles.** Entram os de nível mínimo até o nível alvo; o DAT-05 só entra a partir do Fornecedor. Em cada controle, aplique o Parâmetro do nível alvo e, em qualquer nível alvo, as regras "no perfil X" dos perfis do projeto: `financeiro` (DAT-07, DAT-09), `setor-publico` (DAT-01, DAT-04, DAT-06, DAT-09) e `cartoes` (DAT-02, DAT-04, DAT-08, DAT-10, DAT-13); `saude` traz dado sensível, que liga a regra Essencial do DAT-14. As cláusulas que as normas de `financeiro`, `seguros` e `setor-publico` fazem o cliente exigir (transmissão e armazenamento, países e regiões, devolução e exclusão no fim do contrato) já estão nas regras gerais do DAT-02, do DAT-09, do DAT-12 e do DAT-13. Os listados em `excluir` ficam como `não se aplica`, tipo `declarada`, com o motivo que vem dentro do valor (`DAT-03 (motivo — …)`), como manda a maestra.
4. **Leia o que dá para ler, sem acessar contas.** No repositório: esquema e migrações do banco (dados pessoais, campos sensíveis, pseudonimização), infraestrutura como código (criptografia, chaves, rotação, cópias, bloqueio de exclusão, regiões), configuração das conexões (TLS com o banco), configuração do framework ou do provedor (HSTS), código de log, roteiros de sementes e de mascaramento, rotinas de eliminação e a função de exportação de dados. Em `.security-standard/evidencias/`: os cabeçalhos e a varredura de segredos da `security-automated-checks`, se houver. O que for lido assim é evidência `verificada`.
5. **Pergunte o resto de uma vez, por controle.** Use o Como verificar de cada bloco, numa lista só: processo de recuperação, configuração e retenção das cópias e o registro do último teste de restauração; RPO e RTO do contrato; regiões dos dados, das cópias e dos subprocessadores; chaves e rotação no KMS; como os arquivos vão e voltam do cliente; registro dos pedidos de eliminação; procedimento de saída de cliente. O que vier anexado é `documento`; o que for só resposta é `declarada`.
6. **Preencha os modelos, sem sobrescrever.** Os modelos são `assets/classificacao-de-dados.md` (classes, regras por classe, inventário dos dados, chaves e tabela de guarda) e `assets/politica-de-backup-e-recuperacao.md`, e vão para `.security-standard/` com o mesmo nome. Antes de copiar, confira se o arquivo já existe. Se não existe, copie o modelo e troque `{{data}}` pela data de hoje. Se existe, atualize-o no lugar, mantendo o que está lá, e mostre ao usuário o que mudou; nunca copie o modelo por cima. O registro dos testes de restauração (seção 8 da política) e o histórico de revisões só recebem linhas novas e nunca são regravados inteiros. Preencha com o que foi lido e respondido; os dois ficam internos. Se o usuário quiser mandar a política de backup ao cliente, siga a mesma regra em `docs/seguranca/politica-de-backup-e-recuperacao.md`, sem o registro dos testes e sem nome de banco, bucket, conta ou endereço interno.
7. **Registre as lacunas.** Em `.security-standard/lacunas.md`, uma linha por controle selecionado, no formato da maestra: `id | título | nível | situação | tipo de evidência | evidência | próxima ação`. Situação: `atendido`, `parcial`, `ausente` ou `não se aplica`; tipo de evidência: `verificada`, `documento`, `declarada` ou `—`, este só em linha `ausente` quando o usuário não respondeu. Nunca marque `atendido` sem a evidência e o tipo dela; backup sem registro de restauração no prazo do nível (1 ano no Essencial, 3 meses no Fornecedor) não é `atendido`.
8. **Guarde as evidências.** Em `.security-standard/evidencias/<AAAA-MM-DD>/`, com o id no nome do arquivo (`DAT-06-teste-de-restauracao.md`). Se a pasta do dia tem `resumo.md`, ela é de uma rodada da `security-automated-checks`: use a próxima sem `resumo.md` (`<AAAA-MM-DD>-2/`, `-3/`). Se o nome do arquivo já existe, acrescente `-2`; nada que já está em `evidencias/` é regravado. Nunca grave o valor de uma chave, senha ou token, nem o dado pessoal achado num log: registre o nome, o padrão e a contagem.
9. **Proponha as próximas ações.** Para cada lacuna, use o Como implementar do bloco, na ordem do plano da maestra: primeiro o risco alto que destrava a venda, depois o Essencial que falta, depois o Fornecedor e por fim o Big tech. No Essencial, vêm antes a cópia isolada e testada (DAT-06), a criptografia em repouso e em trânsito (DAT-02, DAT-03), as chaves fora do código (DAT-04) e os segredos fora dos logs (DAT-11). O plano consolidado fica em `.security-standard/plano.md`.
10. **Responda ao usuário.** Cite cada controle pelo id, com o nível, o parâmetro do nível alvo e o tipo das fontes (`primária`, `secundária` ou `proposta`); diga quais números são proposta da skill. Numa pergunta solta, organize por nível (o que o Essencial exige, o que o Fornecedor soma e o Big tech numa linha), ponha as regras "no perfil X" no fim, como condicionais, e termine com as perguntas que faltam. O dossiê para o cliente sai da `security-customer-evidence`, só com o que está atendido.

## Controles desta skill

| Id | Título | Nível mínimo | Perfis |
|---|---|---|---|
| DAT-01 | Classificação dos dados | Essencial | todos |
| DAT-02 | Criptografia em repouso por padrão | Essencial | todos |
| DAT-03 | TLS 1.2 ou superior e cabeçalho HSTS | Essencial | todos |
| DAT-04 | Chaves em KMS ou HSM, com rotação de 90 a 365 dias | Essencial | todos |
| DAT-05 | Chaves separadas por ambiente e por finalidade | Fornecedor | todos |
| DAT-06 | Backup com cópia imutável e restauração testada | Essencial | todos |
| DAT-07 | RPO e RTO definidos e medidos | Essencial | todos |
| DAT-08 | Tabela de guarda e eliminação no prazo | Essencial | todos |
| DAT-09 | Localização dos dados declarada | Essencial | todos |
| DAT-10 | Mascaramento nos ambientes de teste | Essencial | todos |
| DAT-11 | Segredos e dados pessoais fora dos logs | Essencial | todos |
| DAT-12 | Devolução e eliminação no fim do contrato | Essencial | todos |
| DAT-13 | Transporte de arquivos entre as partes | Essencial | todos |
| DAT-14 | Pseudonimização onde cabe | Essencial | todos |
| DAT-15 | Eliminação a pedido do titular, com prazo e prova | Essencial | todos |

Tabela gerada a partir dos blocos de `references/controles-dat.md`; se um bloco mudar, a tabela muda junto. No campo Mapa dos blocos, `CAIQ: DSP-04` e afins são identificadores do CCM/CAIQ v4.1, não controles deste catálogo.

## Erros comuns

- **Dizer que a lei fixa técnica, algoritmo ou frequência.** A LGPD pede medidas de segurança aptas a proteger os dados (art. 46), sem nomear técnica; a norma do BCB pede mecanismos de criptografia e gestão de cópias de segurança (Res. CMN 4.893, art. 3º, § 2º, II e VII); nenhuma diz AES-256 nem backup diário. O número vem do Parâmetro do controle, com o tipo da fonte.
- **Prometer "dados no Brasil" a todo cliente.** A exigência de hospedagem e de cópia no país é do setor público federal (DAT-09); para os demais, declare onde os dados estão.
- **Dar o backup por atendido sem restauração registrada no prazo do nível.** A prova é o teste (DAT-06), e a partir do Fornecedor ele mede o RTO e o RPO (DAT-07).
- **Ler `no protocols available` como recusa do TLS 1.1.** No OpenSSL 3, é o próprio cliente que não tenta; o teste do DAT-03 usa `-cipher 'DEFAULT@SECLEVEL=0'` e lê a saída.
- **Esperar que toda chave gire sozinha.** A rotação automática do KMS vale para a chave simétrica com material gerado por ele; a de assinatura, a importada, a externa e a guardada em cofre se trocam com prazo (DAT-04).
- **Guardar a cópia de segurança na mesma conta e com a mesma credencial do sistema.** Quem invade ou cifra o sistema apaga a cópia junto (DAT-06).
- **Confundir rotação de chave com troca de senha.** Os 90 a 365 dias valem para chaves de criptografia (DAT-04); senhas e tokens são da IAM.
- **Usar a mesma chave em produção e em desenvolvimento** (DAT-05), ou copiar a produção para a homologação sem mascarar "só desta vez" (DAT-10).
- **Eliminar no fim do contrato antes de o cliente confirmar que recebeu os dados íntegros** (DAT-12), ou esquecer as cópias de segurança e os subprocessadores na eliminação a pedido (DAT-15).
- **Restaurar uma cópia antiga sem reaplicar as eliminações feitas depois dela** (DAT-15).
- **Tratar todo pedido do titular como direito de eliminação.** A lei o dá para o dado tratado com consentimento, o desnecessário, excessivo ou tratado em desconformidade e o que ele forneceu à aplicação, ao fim da relação; o que a lei manda guardar fica, com o motivo (DAT-15).
- **Copiar um modelo por cima de um arquivo que já existe em `.security-standard/`, ou regravar o registro dos testes.** O que estava lá se perde, e a pasta fica fora do git.
- **Apresentar declaração como verificação**, ou citar número `(proposta)` como exigência.
- **Pôr o inventário, as chaves, o registro dos testes ou o que achou num log em `docs/seguranca/`.**

## Arquivos

- `references/controles-dat.md`: os 15 controles; fonte de verdade da família.
- `assets/classificacao-de-dados.md`: modelo das classes, das regras por classe, do inventário dos dados, das chaves e da tabela de guarda.
- `assets/politica-de-backup-e-recuperacao.md`: modelo da política de cópias, com objetivos de RPO e RTO, testes de restauração, roteiro de recuperação e eliminação nas cópias.
- No projeto do usuário: `.security-standard/classificacao-de-dados.md`, `.security-standard/politica-de-backup-e-recuperacao.md`, as linhas DAT de `.security-standard/lacunas.md` e `.security-standard/evidencias/<AAAA-MM-DD>/`.
- Skills vizinhas: `security-standard` (maestra), `security-identity-access` (senhas, tokens e segredos), `security-infra-operations` (borda pública e cabeçalhos, logs e recriação da infraestrutura), `security-incident-continuity` (continuidade do negócio), `security-governance-vendors` (subprocessadores), `security-automated-checks` (cabeçalhos e varredura de segredos) e `security-customer-evidence` (dossiê).
