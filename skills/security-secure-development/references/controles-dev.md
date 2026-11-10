# Controles DEV: desenvolvimento seguro

Os 26 controles da família DEV, no formato de `docs/formato-dos-controles.md`. Os níveis são cumulativos (Essencial ⊂ Fornecedor ⊂ Big tech): quem mira o Fornecedor cumpre os controles Essencial e Fornecedor, com o parâmetro do Fornecedor onde ele muda. No Parâmetro, "no perfil X" (ou "Perfis X, Y e Z:", quando a regra é de mais de um perfil) marca o que só vale quando o projeto tem aquele perfil; essas regras ficam no trecho Essencial, porque valem em qualquer nível alvo. Número sem fonte primária leva "(proposta)", e requisito de norma de um perfil adotado para todos os perfis também. No Essencial ficam controles que o CIS v8.1 põe nos grupos IG2 e IG3 (por exemplo, o 16.12): são requisitos do L1 do ASVS ou se cumprem com ferramenta gratuita, e essa escolha é proposta da skill. Os requisitos do OWASP ASVS 5.0 aparecem pelo identificador (no relatório, com a versão: v5.0.0-1.2.4) e com paráfrase própria, sem o texto do padrão (licença CC BY-SA 4.0). No Mapa, os valores de CAIQ (como `IAM-13`) são identificadores do CCM/CAIQ v4.1, não controles deste catálogo; os de CAIQ foram conferidos na lista oficial do CAIQ v4.1, da CSA, e os de CIS v8.1, na planilha oficial do CIS que liga o CIS ao CCM. Temas que outra família fixa vêm citados pelo id de lá: o que não entra no log no DAT-11, a guarda dos logs no OPS-05, o suporte de sistema operacional, banco e runtime no OPS-08 e a conta e a rede da produção no OPS-14.

### DEV-01 — Modelagem de ameaças das funcionalidades sensíveis
- **Enunciado:** Faça o modelo de ameaças de cada funcionalidade sensível antes de implementá-la e reveja-o quando ela mudar.
- **Nível mínimo:** Fornecedor
- **Perfis:** todos
- **Parâmetro:** Fornecedor: modelo escrito (fluxo de dados, ameaças, mitigação e dono de cada ameaça) para toda funcionalidade que toca autenticação, autorização, pagamento, dado pessoal ou integração externa, revisto no PR que muda essa funcionalidade (proposta); Big tech: modelo de ameaças de todo serviço ou funcionalidade nova, entregue com o pedido de revisão de segurança antes do lançamento (DEV-08), como na AWS
- **Por quê:** Falha de desenho (OWASP A06:2025, Insecure Design) não aparece na varredura de código e custa caro depois de implementada. O modelo diz de que controles cada funcionalidade precisa e alimenta a revisão de lançamento.
- **Fontes:**
  - primária — NIST SP 800-218 (SSDF v1.1), tarefa PW.1.1: modelagem de ameaças, de ataques ou da superfície de ataque para avaliar o risco do software — https://csrc.nist.gov/pubs/sp/800/218/final — conferida em 2026-11-09
  - primária — AWS Security Blog, Security Guardians: o pedido de revisão de segurança antes do lançamento leva o modelo de ameaças — https://aws.amazon.com/blogs/security/how-aws-built-the-security-guardians-program-a-mechanism-to-distribute-security-ownership — conferida em 2026-11-09
  - primária — OWASP Top 10:2025, A06 Insecure Design — https://owasp.org/Top10/2025/ — conferida em 2026-11-09
- **Como verificar:** Liste as funcionalidades sensíveis e peça o modelo de cada uma, com data, ameaças, mitigação e dono; confira que a data é posterior à última mudança grande da funcionalidade.
- **Como implementar:** Para cada funcionalidade sensível, desenhe o fluxo de dados, liste as ameaças (por exemplo, pelas categorias STRIDE), decida a mitigação e o dono de cada uma e guarde o modelo no repositório, numa pasta que não vai para o cliente; reveja-o no PR que muda a funcionalidade.
- **Evidência:** Os modelos com data e o link do PR que os revisou; a lista deles em `.security-standard/evidencias/`.
- **Mapa:** CAIQ: AIS-04, TVM-04; SIG: —; ISO: A.8.25, A.8.27; SOC2: —; CSF: ID.RA-03, ID.RA-04; CIS: 16.14; ASVS: —

### DEV-02 — Revisão por outra pessoa e branch protegida
- **Enunciado:** Exija que toda mudança na branch principal entre por pull request aprovado por uma pessoa diferente do autor, com a branch protegida contra push direto.
- **Nível mínimo:** Essencial
- **Perfis:** todos
- **Parâmetro:** Essencial: branch principal protegida, sem push direto, sem force push e sem apagar, com pelo menos 1 aprovação de pessoa diferente do autor (SDL da Microsoft; revisão por duas pessoas da trilha Source do SLSA; PCI DSS 6.2.3.1, quando a revisão é manual) e nova aprovação quando o código muda depois dela (no SLSA, a aprovação vale para a revisão final); no perfil cartoes, a mudança revisada à mão também aprovada pela gestão antes do lançamento (PCI DSS 6.2.3.1); Fornecedor: as regras valem também para administradores, os checks do DEV-03 são obrigatórios para o merge e caminhos sensíveis pedem a aprovação do dono definido no CODEOWNERS (proposta); Big tech: o deploy só aceita código revisado e submetido, conferido no deploy e de novo pelo menos uma vez por dia, e a saída de emergência exige justificativa e avisa a segurança e o dono do serviço (Binary Authorization for Borg)
- **Por quê:** Uma pessoa sozinha não deve conseguir pôr código na produção: a revisão pega erro e código malicioso, e a proteção impede pular a revisão. Google e Microsoft exigem revisor diferente do autor, e a PCI DSS também, quando a revisão é manual.
- **Fontes:**
  - primária — Google Cloud, Binary Authorization for Borg: revisão de pelo menos um engenheiro além do autor, aplicada no deploy e conferida todo dia — https://docs.cloud.google.com/docs/security/binary-authorization-for-borg — conferida em 2026-11-09
  - primária — Microsoft Learn, Security development and operations overview: revisão manual por outro revisor antes da branch de release — https://learn.microsoft.com/en-us/compliance/assurance/assurance-security-development-and-operation — conferida em 2026-11-09
  - primária — SLSA 1.2, Source Track, requisito de revisão por duas pessoas (autor e revisor diferentes; vale a revisão final) — https://slsa.dev/spec/v1.2/source-requirements — conferida em 2026-11-09
  - primária — PCI DSS v4.0, tradução oficial em português, requisito 6.2.3.1 (revisão por pessoa que não é o autor do código) — https://listings.pcisecuritystandards.org/documents/PCI-DSS-v4_0-PT.pdf — conferida em 2026-11-09
  - primária — GitHub Docs, About protected branches: opções da proteção e planos em que ela existe — https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches — conferida em 2026-11-09
- **Como verificar:** Leia as regras da branch principal (Settings → Branches ou Rules, ou o JSON do `gh api` guardado pela `security-automated-checks`) e confira PR obrigatório, aprovações, descarte da aprovação antiga, bloqueio de force push e, no Fornecedor, "Do not allow bypassing the above settings" e os checks obrigatórios; confira uma amostra de PRs recentes.
- **Como implementar:** Ligue a proteção (ou um ruleset) na branch principal com as opções do Parâmetro e copie `assets/CODEOWNERS` para `.github/CODEOWNERS`, com os donos reais. Em repositório privado no plano gratuito do GitHub, a proteção de branch e o CODEOWNERS não existem: registre o controle como parcial e a revisão como processo declarado. Em equipe de uma pessoa só, registre o controle como parcial e compense com os checks obrigatórios do DEV-03 e uma revisão por pessoa de fora a cada release (proposta).
- **Evidência:** Exportação das regras de proteção (JSON do `gh api` ou captura de tela) com data e uma amostra de PRs com o revisor, em `.security-standard/evidencias/`.
- **Mapa:** CAIQ: CCC-04; SIG: —; ISO: A.8.4, A.8.32; SOC2: —; CSF: PR.PS-06; CIS: 16.1; ASVS: —

### DEV-03 — SAST, SCA e varredura de segredos no CI
- **Enunciado:** Rode análise estática do código (SAST), análise das dependências (SCA) e varredura de segredos em todo pull request e na branch principal, e bloqueie o merge quando elas acharem algo.
- **Nível mínimo:** Essencial
- **Perfis:** todos
- **Parâmetro:** Essencial: as três verificações em todo PR e em todo push na branch principal, e a SCA também uma vez por semana; o merge fica bloqueado por qualquer segredo, achado do SAST ou vulnerabilidade conhecida de dependência, salvo exceção registrada com motivo, dono e data de fim dentro do prazo do DEV-09 (proposta); Fornecedor: o resultado das execuções da branch principal guardado junto de cada release (proposta); Big tech: análise estática automática das mudanças antes da produção, com regras próprias para as classes de falha do produto (o Zoncolan, da Meta, roda em milhares de mudanças por dia), e achado das ferramentas automáticas corrigido antes de a build ser aprovada para release (SDL da Microsoft)
- **Por quê:** Injeção, dependência vulnerável e chave esquecida no código são falhas que as ferramentas pegam antes do merge, quando corrigir ainda é barato. Ferramentas abertas fazem as três verificações sem custo; os recursos equivalentes do GitHub em repositório privado são pagos.
- **Fontes:**
  - primária — Microsoft Learn, Security development and operations overview: análise estática e varredura de credenciais no pipeline, com os achados corrigidos antes da release — https://learn.microsoft.com/en-us/compliance/assurance/assurance-security-development-and-operation — conferida em 2026-11-09
  - primária — Meta Engineering, Zoncolan: análise estática em milhares de mudanças por dia antes da produção — https://engineering.fb.com/2019/08/15/security/zoncolan/ — conferida em 2026-11-09
  - primária — NIST SP 800-218 (SSDF v1.1), tarefas PW.7.2 e PW.4.4: análise do código e detecção automática de vulnerabilidades conhecidas nos componentes — https://csrc.nist.gov/pubs/sp/800/218/final — conferida em 2026-11-09
  - primária — GitHub Docs, About code scanning: em repositório privado, exige licença do GitHub Code Security — https://docs.github.com/en/code-security/concepts/code-scanning/code-scanning — conferida em 2026-11-09
  - primária — GitHub Docs, About secret scanning: em repositório privado de organização, exige o GitHub Secret Protection — https://docs.github.com/en/code-security/concepts/secret-security/secret-scanning — conferida em 2026-11-09
  - primária — gitleaks-action, README: chave de licença gratuita, obtida no site do gitleaks, exigida em conta de organização — https://github.com/gitleaks/gitleaks-action — conferida em 2026-11-09
- **Como verificar:** Abra `.github/workflows/` e confira que há job de SAST, de SCA e de segredos disparado em `pull_request` e em `push` na branch principal, com agendamento semanal da SCA, e que os três estão entre os checks obrigatórios da proteção de branch.
- **Como implementar:** Copie `assets/ci-seguranca.yml` para `.github/workflows/` (Semgrep, gitleaks e osv-scanner, gratuitos e sem conta; o modelo não foi executado no GitHub Actions nesta versão), veja os três jobs rodarem num pull request de teste, torne-os obrigatórios na proteção de branch e registre as exceções em arquivo versionado (no osv-scanner, `osv-scanner.toml` com motivo e data de fim).
- **Evidência:** Links das execuções do workflow em PRs recentes e a lista dos checks obrigatórios, com data, em `.security-standard/evidencias/`.
- **Mapa:** CAIQ: AIS-05, TVM-03, TVM-06; SIG: —; ISO: A.8.8, A.8.28, A.8.29; SOC2: —; CSF: ID.RA-01, PR.PS-06; CIS: 16.12; ASVS: —

### DEV-04 — Política de dependências e atualização automática
- **Enunciado:** Defina por escrito de onde vêm as dependências e em que prazo elas são atualizadas, e ligue a atualização automática.
- **Nível mínimo:** Essencial
- **Perfis:** todos
- **Parâmetro:** Essencial: arquivo de trava (lockfile) versionado, prazos de atualização documentados (ASVS 15.1.1, L1) e nenhum componente fora deles (15.2.1, L1), com Dependabot ou Renovate verificando toda semana cada ecossistema do repositório e as actions do GitHub (proposta); no perfil cartoes, inventário do software sob medida e dos componentes de terceiros incorporados nele, mantido para gerir as vulnerabilidades e as correções (PCI DSS 6.3.2); Fornecedor: componentes só de repositórios definidos, confiáveis e mantidos (ASVS 15.1.2, L2), actions fixadas pelo SHA completo do commit (GitHub) e dependência nova aprovada no PR que a acrescenta (proposta); Big tech: todas as dependências, inclusive as transitivas, vêm do repositório esperado, sem risco de confusão de dependência (ASVS 15.2.4, L3), e os pipelines usam modelos centrais que bloqueiam destinos maliciosos conhecidos (na Microsoft, 93% dos pipelines de build críticos e 90% dos de release, segundo a SFI)
- **Por quê:** Falhas da cadeia de suprimentos de software são o terceiro risco do OWASP Top 10:2025. Dependência velha acumula falha conhecida; dependência de origem sem controle abre a porta para pacote malicioso.
- **Fontes:**
  - primária — OWASP ASVS 5.0.0, V15 Secure Coding and Architecture (15.1.1, 15.1.2, 15.2.1 e 15.2.4) — https://github.com/OWASP/ASVS/blob/v5.0.0/5.0/en/0x24-V15-Secure-Coding-and-Architecture.md — conferida em 2026-11-09
  - primária — GitHub Docs, Secure use reference: fixar actions pelo SHA completo do commit — https://docs.github.com/en/actions/reference/security/secure-use — conferida em 2026-11-09
  - primária — Microsoft Learn, What's new in Microsoft Secure Future Initiative: pipelines em modelos centrais que bloqueiam destinos maliciosos conhecidos — https://learn.microsoft.com/en-us/security/zero-trust/sfi/secure-future-initiative-whats-new — conferida em 2026-11-09
  - primária — OWASP Top 10:2025, A03 Software Supply Chain Failures — https://owasp.org/Top10/2025/ — conferida em 2026-11-09
  - primária — PCI DSS v4.0, tradução oficial em português, requisito 6.3.2, para o perfil cartoes (inventário do software sob medida e dos componentes de terceiros incorporados nele) — https://listings.pcisecuritystandards.org/documents/PCI-DSS-v4_0-PT.pdf — conferida em 2026-11-09
  - primária — GitHub Docs, Supported ecosystems and repositories: no ecossistema github-actions, o Dependabot atualiza só as actions referenciadas pelo repositório, não as imagens do Docker Hub nem do Container registry — https://docs.github.com/en/code-security/reference/supply-chain-security/supported-ecosystems-and-repositories — conferida em 2026-11-09
  - primária — Renovate Docs, gerenciador github-actions: atualiza também a imagem do campo `container:` dos jobs — https://docs.renovatebot.com/modules/manager/github-actions/ — conferida em 2026-11-09
- **Como verificar:** Confira o lockfile versionado, o `.github/dependabot.yml` (ou `renovate.json`) com todos os ecossistemas do repositório, a política escrita com os prazos e se há PR de atualização parado além do prazo.
- **Como implementar:** Copie `assets/dependabot.yml` para `.github/dependabot.yml` e deixe um bloco por ecossistema; ligue os alertas e as atualizações de segurança do Dependabot nas configurações do repositório; escreva os prazos na política do DEV-09. As imagens de `container:` do `assets/ci-seguranca.yml` o Dependabot não atualiza: use o Renovate ou confira a versão e o digest de cada uma a cada trimestre (proposta).
- **Evidência:** O `dependabot.yml`, a política com os prazos e a lista dos PRs de atualização abertos e fechados no trimestre, em `.security-standard/evidencias/`.
- **Mapa:** CAIQ: TVM-06; SIG: —; ISO: A.8.8; SOC2: —; CSF: ID.RA-01, PR.PS-02; CIS: 16.5; ASVS: V15.1, V15.2

### DEV-05 — SBOM de cada release
- **Enunciado:** Gere e guarde a lista de materiais do software (SBOM) de cada release, num formato padrão.
- **Nível mínimo:** Fornecedor
- **Perfis:** todos
- **Parâmetro:** Fornecedor: SBOM em SPDX ou CycloneDX gerado pelo pipeline a cada release, com as dependências transitivas, guardado junto da release e entregue a quem adquire o software quando ele pedir (ASVS 15.1.2, L2; SSDF PS.3.2); os dois formatos são escolha da skill (proposta); Big tech: componentes de todo build detectados de forma automática e conferidos contra vulnerabilidades e obrigações legais (Component Governance, da Microsoft), com nova conferência do SBOM em produção pelo menos uma vez por dia (proposta)
- **Por quê:** Quando sai uma falha grave numa biblioteca, o SBOM responde logo se o produto a usa e em que versão. O SSDF manda disponibilizar esses dados a quem adquire o software.
- **Fontes:**
  - primária — OWASP ASVS 5.0.0, V15 (15.1.2: inventário dos componentes de terceiros, como um SBOM) — https://github.com/OWASP/ASVS/blob/v5.0.0/5.0/en/0x24-V15-Secure-Coding-and-Architecture.md — conferida em 2026-11-09
  - primária — NIST SP 800-218 (SSDF v1.1), tarefa PS.3.2: dados de proveniência de todos os componentes de cada release, como num SBOM — https://csrc.nist.gov/pubs/sp/800/218/final — conferida em 2026-11-09
  - primária — Microsoft Learn, Security development and operations overview: Component Governance detecta os componentes de código aberto de cada build, as vulnerabilidades e as obrigações legais — https://learn.microsoft.com/en-us/compliance/assurance/assurance-security-development-and-operation — conferida em 2026-11-09
- **Como verificar:** Peça o SBOM da última release e confira formato, data, versão do produto e se ele traz as dependências transitivas.
- **Como implementar:** Gere o SBOM no job de release com uma ferramenta aberta (por exemplo, Syft ou Trivy) ou exporte-o pelo grafo de dependências do GitHub, e anexe-o à release.
- **Evidência:** O SBOM de cada release, com data e hash, guardado com a release; cópia do último em `.security-standard/evidencias/`.
- **Mapa:** CAIQ: STA-08, STA-09; SIG: —; ISO: A.5.9; SOC2: —; CSF: ID.AM-02; CIS: 16.4; ASVS: V15.1

### DEV-06 — Proveniência e assinatura das releases (SLSA)
- **Enunciado:** Gere a proveniência de build de cada release e assine-a no nível do SLSA que o nível alvo pede.
- **Nível mínimo:** Essencial
- **Perfis:** todos
- **Parâmetro:** Essencial: SLSA Build L1, proveniência gerada automaticamente pelo build e distribuída com o artefato; Fornecedor: SLSA Build L2, build em plataforma hospedada que gera e assina a proveniência, e quem consome confere a assinatura; Big tech: SLSA Build L3, plataforma endurecida em que uma execução não interfere em outra e o segredo de assinatura fica fora do alcance dos passos do build, com o deploy recusando artefato sem proveniência válida (Binary Authorization for Borg). A correspondência entre os níveis do SLSA e os desta skill é proposta (proposta)
- **Por quê:** A proveniência diz de que código e de que build saiu cada artefato, e a assinatura impede trocar o artefato no caminho. O Google barra no deploy o que não tem proveniência assinada, e o SLSA é o padrão aberto que nasceu dessa prática.
- **Fontes:**
  - primária — SLSA 1.2, Build Track Basics (Build L1, L2 e L3) — https://slsa.dev/spec/v1.2/build-track-basics — conferida em 2026-11-09
  - primária — Google Cloud, Binary Authorization for Borg: proveniência assinada e verificação no deploy — https://docs.cloud.google.com/docs/security/binary-authorization-for-borg — conferida em 2026-11-09
  - primária — GitHub Docs, Artifact attestations: o atestado sozinho dá SLSA Build L2, e o fluxo reutilizável chega ao L3 — https://docs.github.com/en/actions/concepts/security/artifact-attestations — conferida em 2026-11-09
  - primária — GitHub Docs, Using artifact attestations: em repositório privado, só no GitHub Enterprise Cloud — https://docs.github.com/en/actions/how-tos/secure-your-work/use-artifact-attestations/use-artifact-attestations — conferida em 2026-11-09
- **Como verificar:** Pegue a última release e confira se ela traz a proveniência; no Fornecedor, confira a assinatura (no GitHub, `gh attestation verify <artefato> --repo <dono>/<repositório>`); no Big tech, confira que o deploy recusa artefato sem proveniência válida.
- **Como implementar:** No L1, grave no job de release um arquivo com commit, workflow, execução e hash de cada artefato. No L2, use `actions/attest-build-provenance` no job de release (repositório público ou GitHub Enterprise Cloud); fora disso, use outra ferramenta aberta de proveniência SLSA e confira se ela publica dados do repositório num registro público de transparência. No L3, faça o build num fluxo reutilizável isolado e verifique a proveniência no deploy.
- **Evidência:** A proveniência e a assinatura da última release e a saída da verificação, em `.security-standard/evidencias/`.
- **Mapa:** CAIQ: AIS-06; SIG: —; ISO: A.8.25; SOC2: —; CSF: PR.PS-06, ID.RA-09; CIS: —; ASVS: —

### DEV-07 — Build isolado de pessoas e de outros builds
- **Enunciado:** Construa os artefatos de produção só na plataforma de CI, em ambiente isolado de quem escreve o código e dos outros builds.
- **Nível mínimo:** Essencial
- **Perfis:** todos
- **Parâmetro:** Essencial: release de produção só sai do CI, nunca da máquina de uma pessoa (proposta); Fornecedor: runner novo e limpo a cada job, como os hospedados pelo GitHub, e nenhum runner próprio (self-hosted) em repositório público (GitHub); Big tech: build em ambiente isolado e travado, separado das pessoas que o disparam (Binary Authorization for Borg), com execuções que não interferem umas nas outras (SLSA Build L3)
- **Por quê:** Build feito na máquina de alguém herda o malware e as mudanças locais dessa máquina, e ninguém consegue provar o que foi para a produção. Runner reaproveitado guarda o resto de um build para o seguinte.
- **Fontes:**
  - primária — Google Cloud, Binary Authorization for Borg: build em ambiente isolado e travado, separado das pessoas — https://docs.cloud.google.com/docs/security/binary-authorization-for-borg — conferida em 2026-11-09
  - primária — SLSA 1.2, Build Track Basics (Build L3: execuções isoladas umas das outras) — https://slsa.dev/spec/v1.2/build-track-basics — conferida em 2026-11-09
  - primária — GitHub Docs, Secure use reference: runners hospedados efêmeros e limpos; runner próprio quase nunca em repositório público — https://docs.github.com/en/actions/reference/security/secure-use — conferida em 2026-11-09
- **Como verificar:** Confira no workflow de release o `runs-on` (runner hospedado ou efêmero) e pergunte quem já publicou release fora do CI; compare o hash do artefato publicado com o do CI.
- **Como implementar:** Leve o build e a publicação das releases para o CI, use runners hospedados ou efêmeros e tire das pessoas a credencial de publicação, que fica só no CI (DEV-15).
- **Evidência:** O workflow de release e a lista das últimas releases com o link da execução que gerou cada uma, em `.security-standard/evidencias/`.
- **Mapa:** CAIQ: —; SIG: —; ISO: A.8.25, A.8.31; SOC2: —; CSF: PR.PS-06, PR.IR-01; CIS: —; ASVS: —

### DEV-08 — Revisão de segurança antes de lançar
- **Enunciado:** Faça uma revisão de segurança registrada, com poder de barrar, antes de lançar funcionalidade sensível ou serviço novo.
- **Nível mínimo:** Fornecedor
- **Perfis:** todos
- **Parâmetro:** Fornecedor: revisão por pessoa que não participou do desenho (SSDF PW.2.1) antes de lançar toda funcionalidade sensível do DEV-01, com o modelo de ameaças, os achados das ferramentas, as pendências e a decisão registrados (proposta); Big tech: revisão independente por engenheiro de segurança de aplicações em todo serviço ou funcionalidade nova, com poder de decidir se lança ou não (AWS), e revisão final de segurança e privacidade das funcionalidades novas e mudanças relevantes (SDL da Microsoft)
- **Por quê:** A revisão de código olha a mudança; a de lançamento olha o conjunto: desenho, ameaças, achados e o que ficou pendente. Sem poder de barrar, a pressa do prazo vence.
- **Fontes:**
  - primária — NIST SP 800-218 (SSDF v1.1), tarefa PW.2.1: revisão do desenho por pessoa qualificada que não participou dele — https://csrc.nist.gov/pubs/sp/800/218/final — conferida em 2026-11-09
  - primária — AWS Security Blog, Security Guardians: revisão independente obrigatória com engenheiro de segurança de aplicações antes do lançamento — https://aws.amazon.com/blogs/security/how-aws-built-the-security-guardians-program-a-mechanism-to-distribute-security-ownership — conferida em 2026-11-09
  - primária — AWS Security Blog, How the unique culture of security at AWS makes a difference: o revisor decide se cada release sai ou não — https://aws.amazon.com/blogs/security/how-the-unique-culture-of-security-at-aws-makes-a-difference — conferida em 2026-11-09
  - primária — Microsoft Learn, Security development and operations overview: revisão final de segurança e privacidade antes da release — https://learn.microsoft.com/en-us/compliance/assurance/assurance-security-development-and-operation — conferida em 2026-11-09
- **Como verificar:** Pegue os três últimos lançamentos de funcionalidade sensível e peça o registro da revisão: quem revisou, quando, achados, pendências e decisão.
- **Como implementar:** Crie um modelo de revisão no PR ou numa issue (modelo de ameaças, achados do CI, testes, pendências com prazo e decisão) e defina quem revisa; no Big tech, a revisão vira etapa obrigatória do processo de lançamento.
- **Evidência:** Os registros de revisão com data e decisão, em `.security-standard/evidencias/`.
- **Mapa:** CAIQ: AIS-04; SIG: —; ISO: A.5.8, A.8.29; SOC2: —; CSF: PR.PS-06; CIS: 16.1; ASVS: —

### DEV-09 — Prazos de correção por gravidade
- **Enunciado:** Corrija cada vulnerabilidade dentro do prazo da gravidade dela e registre toda exceção com motivo, dono e data de fim.
- **Nível mínimo:** Essencial
- **Perfis:** todos
- **Parâmetro:** Gravidade pela escala do CVSS da FIRST: crítica de 9,0 a 10,0; alta de 7,0 a 8,9; média de 4,0 a 6,9; baixa de 0,1 a 3,9. Prazos em dias corridos, contados da publicação da correção do componente ou da confirmação do achado em código próprio (proposta); no caso do KEV, da entrada no catálogo ou da detecção no sistema, o que vier primeiro (BOD 26-04). Essencial: crítica em até 30 dias (PCI DSS v4.0.1, 6.3.3); alta em até 30 dias, como pedia a PCI DSS v4.0 antes de a v4.0.1 deixar a alta no prazo da entidade (proposta); média e baixa em até 90 dias, com base no exemplo de três meses da PCI DSS 6.3.3 (proposta); vulnerabilidade do catálogo KEV da CISA em até 14 dias (o maior prazo para KEV na Tabela 1 da BOD 26-04). Fornecedor: crítica em até 14 dias e média em até 60 dias (proposta); alta e baixa como no Essencial; KEV em até 3 dias quando o sistema está exposto à internet e a exploração é automatizável ou dá controle total, e também quando, sem exposição, a exploração é automatizável e dá controle total (linhas 1, 2, 3 e 9 da Tabela 1 da BOD 26-04), e a triagem forense que a tabela pede fica para o Big tech (proposta). Big tech: o menor prazo entre o do Fornecedor e o da Tabela 1 da BOD 26-04 (3, 14 ou 60 dias conforme exposição, KEV, automação e impacto técnico, com triagem forense nos casos que a tabela marca), e nada além de 90 dias (proposta). A PCI DSS obriga quem trata cartão e a BOD 26-04 obriga órgãos federais dos EUA; usá-las como régua de todo fornecedor é proposta da skill (proposta)
- **Por quê:** Sem prazo, vulnerabilidade conhecida fica aberta até alguém explorá-la. A PCI DSS v4.0.1 fixa 30 dias para as críticas, e a CISA mede a urgência pela exploração ativa e pela exposição do sistema. O ASVS pede, já no L1, prazos documentados e cumpridos para os componentes de terceiros.
- **Fontes:**
  - primária — PCI SSC, Just Published: PCI DSS v4.0.1: o prazo de 30 dias do requisito 6 volta a valer só para vulnerabilidades críticas — https://blog.pcisecuritystandards.org/just-published-pci-dss-v4-0-1 — conferida em 2026-11-09
  - primária — PCI DSS v4.0, tradução oficial em português, requisito 6.3.3: na v4.0, críticos e altos em um mês e os demais no prazo da entidade, por exemplo três meses — https://listings.pcisecuritystandards.org/documents/PCI-DSS-v4_0-PT.pdf — conferida em 2026-11-09
  - primária — CISA, BOD 26-04 Prioritizing Security Updates Based on Risk, Tabela 1 (10/06/2026; revogou as BOD 19-02 e 22-01) — https://www.cisa.gov/news-events/directives/bod-26-04-prioritizing-security-updates-based-risk — conferida em 2026-11-09
  - primária — CISA, Known Exploited Vulnerabilities Catalog — https://www.cisa.gov/known-exploited-vulnerabilities-catalog — conferida em 2026-11-09
  - primária — FIRST, CVSS v4.0 Specification Document, escala qualitativa de gravidade (Tabela 22) — https://www.first.org/cvss/v4.0/specification-document — conferida em 2026-11-09
  - primária — OWASP ASVS 5.0.0, V15 (15.1.1 e 15.2.1: prazos de correção documentados e cumpridos, L1) — https://github.com/OWASP/ASVS/blob/v5.0.0/5.0/en/0x24-V15-Secure-Coding-and-Architecture.md — conferida em 2026-11-09
- **Como verificar:** Exporte as vulnerabilidades abertas (alertas do Dependabot, saída do osv-scanner, achados do SAST) com a data de detecção, conte as que passaram do prazo do nível alvo e confira cada exceção (motivo, dono, data de fim).
- **Como implementar:** Se `docs/seguranca/politica-de-correcao-por-gravidade.md` não existe, gere-a a partir do modelo `assets/politica-de-correcao-por-gravidade.md`, com a coluna do nível alvo; se existe, atualize-a no lugar, sem copiar o modelo por cima, mantendo o que está lá (inclusive quem aprovou e quando), e mostre ao usuário o que mudou; o registro de exceções só recebe entradas novas. Acompanhe os prazos no rastreador de issues; a cada varredura, cruze os achados com o catálogo KEV da CISA (há versão em JSON).
- **Evidência:** A política aprovada e o relatório mensal das vulnerabilidades com prazo, situação e exceções, em `.security-standard/evidencias/`.
- **Mapa:** CAIQ: AIS-07, TVM-08, TVM-09; SIG: —; ISO: A.8.8; SOC2: —; CSF: ID.RA-01, ID.RA-06; CIS: 7.2, 16.6; ASVS: V15.1, V15.2

### DEV-10 — SECURITY.md e política de divulgação de vulnerabilidades
- **Enunciado:** Publique como relatar uma vulnerabilidade, em quanto tempo você responde e o compromisso de não processar quem relata de boa-fé.
- **Nível mínimo:** Essencial
- **Perfis:** todos
- **Parâmetro:** Essencial: `SECURITY.md` no repositório com as versões cobertas e o canal privado de relato (GitHub) e resposta ao relato em até 3 dias úteis (proposta); Fornecedor: política de divulgação que autoriza testes de boa-fé, promete não recomendar nem mover ação judicial contra quem a segue e permite a divulgação coordenada (meta do pledge da CISA), e `security.txt` em `/.well-known/` com `Contact` e `Expires` (obrigatórios) e validade de menos de 1 ano, como a RFC 9116 recomenda; Big tech: confirmação do recebimento por uma pessoa em até 24 horas (AWS), CVE emitido a tempo para toda falha crítica ou de alto impacto que exija ação do cliente ou esteja sendo explorada (pledge da CISA) e prazo de divulgação coordenada de 90 dias (Project Zero, do Google)
- **Por quê:** Quem acha uma falha precisa de um canal e de segurança jurídica para avisar antes de divulgar. Sem isso, a falha chega pela imprensa ou por quem a explora.
- **Fontes:**
  - primária — CISA, Secure by Design Pledge: metas da política de divulgação e dos CVEs — https://www.cisa.gov/securebydesign/pledge — conferida em 2026-11-09
  - primária — IETF, RFC 9116, A File Format to Aid in Security Vulnerability Disclosure — https://www.rfc-editor.org/rfc/rfc9116.html — conferida em 2026-11-09
  - primária — AWS, Vulnerability Reporting: resposta de uma pessoa em 24 horas e porto seguro para a pesquisa de boa-fé — https://aws.amazon.com/security/vulnerability-reporting/ — conferida em 2026-11-09
  - primária — Google Project Zero, Vulnerability Disclosure Policy (90+30 dias) — https://projectzero.google/vulnerability-disclosure-policy.html — conferida em 2026-11-09
  - primária — GitHub Docs, Adding a security policy to your repository — https://docs.github.com/en/code-security/how-tos/report-and-fix-vulnerabilities/configure-vulnerability-reporting/add-security-policy — conferida em 2026-11-09
  - primária — GitHub Docs, Configuring private vulnerability reporting for a repository: recurso de repositório público — https://docs.github.com/en/code-security/how-tos/report-and-fix-vulnerabilities/configure-vulnerability-reporting/configure-for-a-repository — conferida em 2026-11-09
- **Como verificar:** Abra o `SECURITY.md` e `<seu-domínio>/.well-known/security.txt` e confira canal, prazo, compromisso de boa-fé e a data de `Expires`; meça o tempo de resposta dos relatos do último ano.
- **Como implementar:** Copie `assets/SECURITY.md`, preencha o canal e os prazos do nível alvo, ligue o relato privado de vulnerabilidades do GitHub se o repositório for público (no privado, use e-mail ou formulário) e publique o `security.txt` com os mesmos dados.
- **Evidência:** O `SECURITY.md`, o `security.txt` publicado e o registro dos tempos de resposta do ano, em `.security-standard/evidencias/`.
- **Mapa:** CAIQ: —; SIG: —; ISO: A.8.8; SOC2: —; CSF: ID.RA-08; CIS: 16.2; ASVS: —

### DEV-11 — Programa de recompensa por vulnerabilidades
- **Enunciado:** Mantenha um programa público de recompensa por vulnerabilidades, com escopo, regras e tabela de valores por gravidade.
- **Nível mínimo:** Big tech
- **Perfis:** todos
- **Parâmetro:** Big tech: programa público com escopo, regras de boa-fé, tabela de valores por gravidade e pagamento depois de validar o relato; os valores ficam com a empresa (proposta)
- **Por quê:** A recompensa atrai pesquisadores para o que as ferramentas internas não acham. Google e Apple pagam milhões de dólares por esses relatos.
- **Fontes:**
  - primária — Google, VRP 2025 Year in Review: mais de US$ 17 milhões pagos em 2025 — https://blog.google/security/vrp-2025-year-in-review/ — conferida em 2026-11-09
  - primária — Apple Security Research, Apple Security Bounty. Evolved.: prêmio máximo de US$ 2 milhões — https://security.apple.com/blog/apple-security-bounty-evolved/ — conferida em 2026-11-09
- **Como verificar:** Confira a página pública do programa (escopo, regras, valores e canal) e peça o número de relatos e de pagamentos do último ano.
- **Como implementar:** Comece pelo `SECURITY.md` e pela política de divulgação (DEV-10); quando houver orçamento e gente para triar, publique o programa, próprio ou numa plataforma de recompensa, com escopo pequeno no começo (proposta).
- **Evidência:** A página do programa e o relatório anual de relatos e pagamentos, em `.security-standard/evidencias/`.
- **Mapa:** CAIQ: —; SIG: —; ISO: —; SOC2: —; CSF: ID.RA-08; CIS: —; ASVS: —

### DEV-12 — Ambientes de desenvolvimento, teste e produção separados
- **Enunciado:** Separe da produção os ambientes de desenvolvimento e de teste, com credenciais, segredos e dados próprios.
- **Nível mínimo:** Essencial
- **Perfis:** todos
- **Parâmetro:** Essencial: conta e rede da produção separadas como no OPS-14, credenciais, segredos e banco próprios em cada ambiente, sem dado real da produção em desenvolvimento e teste (a cópia que for indispensável sai mascarada, como no DAT-10), nenhum segredo de produção em ambiente de pré-produção, inclusive deploy de preview (SSDF PO.5.1; PCI DSS 6.5.3), e dados e contas de teste removidos antes de ir para a produção (proposta: requisito da PCI DSS 6.5.6 adotado para todos os perfis); no perfil cartoes, papéis separados entre produção e pré-produção, para que só mudança revisada e aprovada chegue à produção (PCI DSS 6.5.4); Fornecedor: os mesmos papéis separados em todos os perfis (proposta: requisito da PCI DSS 6.5.4 adotado para todos os perfis); Big tech: credencial de pré-produção sem validade na produção, de modo que a pré-produção não consegue se autenticar em serviço de produção (Microsoft SFI; a conta e a rede da produção ficam no OPS-14)
- **Por quê:** O ambiente de teste é menos protegido e mais acessível; se ele alcança a produção, vira a porta de entrada. A separação também evita que um erro no teste apague dado real.
- **Fontes:**
  - primária — PCI DSS v4.0, tradução oficial em português, requisitos 6.5.3, 6.5.4 e 6.5.6 — https://listings.pcisecuritystandards.org/documents/PCI-DSS-v4_0-PT.pdf — conferida em 2026-11-09
  - primária — NIST SP 800-218 (SSDF v1.1), tarefa PO.5.1: separar e proteger cada ambiente do desenvolvimento — https://csrc.nist.gov/pubs/sp/800/218/final — conferida em 2026-11-09
  - primária — Microsoft Learn, Security development and operations overview: segregação dos ambientes de teste e de produção, testada nas auditorias SOC — https://learn.microsoft.com/en-us/compliance/assurance/assurance-security-development-and-operation — conferida em 2026-11-09
  - primária — Microsoft Learn, What's new in Microsoft Secure Future Initiative: autenticação de serviço a serviço vinda de fora da produção bloqueada — https://learn.microsoft.com/en-us/security/zero-trust/sfi/secure-future-initiative-whats-new — conferida em 2026-11-09
- **Como verificar:** Peça ao usuário a lista dos ambientes com a conta, o banco, a origem dos dados e os nomes das variáveis de cada um e compare os nomes: segredo de produção não pode aparecer em preview nem em desenvolvimento, e dado da produção só entra mascarado (DAT-10). Quem abre o painel da nuvem ou da hospedagem é o usuário, e valor de segredo nunca se imprime.
- **Como implementar:** Separe a conta da produção como pede o OPS-14, use segredos por ambiente (DEV-15), gere os dados de desenvolvimento e de teste como no DAT-10 e restrinja quem faz deploy em produção.
- **Evidência:** Inventário dos ambientes com conta, banco e escopo dos segredos (só nomes, nunca valores), com data, em `.security-standard/evidencias/`.
- **Mapa:** CAIQ: I&S-05; SIG: —; ISO: A.8.31; SOC2: —; CSF: PR.IR-01; CIS: 16.8; ASVS: —

### DEV-13 — Configuração como código, revisada como código
- **Enunciado:** Guarde no repositório a configuração da infraestrutura, do CI e da aplicação e altere-a só por pull request revisado.
- **Nível mínimo:** Fornecedor
- **Perfis:** todos
- **Parâmetro:** Fornecedor: workflows de CI, infraestrutura como código e configuração da aplicação (nomes das variáveis, sem valores secretos) versionados e alterados só por PR revisado, como o código (SSDF PS.1.1; SDL da Microsoft); Big tech: nenhuma configuração de produção muda sem revisão, inclusive flags e parâmetros do deploy (Binary Authorization for Borg), e mudança manual no console gera alerta (proposta)
- **Por quê:** Configuração errada abre tanto quanto código errado, e a mudança feita direto no console não deixa registro nem passa por outra pessoa. A configuração insegura é o segundo risco do OWASP Top 10:2025.
- **Fontes:**
  - primária — NIST SP 800-218 (SSDF v1.1), tarefa PS.1.1: guardar código e configuração como código em repositório com acesso mínimo — https://csrc.nist.gov/pubs/sp/800/218/final — conferida em 2026-11-09
  - primária — Microsoft Learn, Security development and operations overview: o revisor confere também configurações e dependências — https://learn.microsoft.com/en-us/compliance/assurance/assurance-security-development-and-operation — conferida em 2026-11-09
  - primária — Google Cloud, Binary Authorization for Borg: configurações passam pela mesma revisão que o código — https://docs.cloud.google.com/docs/security/binary-authorization-for-borg — conferida em 2026-11-09
  - primária — OWASP Top 10:2025, A02 Security Misconfiguration — https://owasp.org/Top10/2025/ — conferida em 2026-11-09
- **Como verificar:** Peça ao usuário a lista do que está configurado fora do repositório (painel da nuvem, do CI, da hospedagem) e veja se há equivalente versionado; o histórico de mudanças manuais vem do log de auditoria do provedor, que o próprio usuário consulta e entrega, sem valor de segredo.
- **Como implementar:** Leve a configuração para o repositório (infraestrutura como código, `.github/`, arquivo de exemplo das variáveis sem valores) e aplique-a pelo CI; restrinja a edição manual da produção aos administradores.
- **Evidência:** A lista do que está versionado e do que ainda está fora, com o plano de migração, em `.security-standard/evidencias/`.
- **Mapa:** CAIQ: CCC-01; SIG: —; ISO: A.8.9, A.8.32; SOC2: —; CSF: PR.PS-01; CIS: 4.1; ASVS: —

### DEV-14 — Testes de segurança automatizados
- **Enunciado:** Mantenha testes automatizados que provem os controles de segurança da aplicação e rode-os no CI.
- **Nível mínimo:** Fornecedor
- **Perfis:** todos
- **Parâmetro:** Fornecedor: testes no CI que provam autenticação, autorização (inclusive o acesso de um cliente ao dado de outro, DEV-23) e validação de entrada das funções sensíveis, mais teste dinâmico (DAST) de linha de base contra a homologação a cada release (proposta), e cada vulnerabilidade corrigida ganha um teste que impede a volta (SSDF PW.8.2); Big tech: frameworks automatizados de teste de API e teste de intrusão na revisão de lançamento (AWS)
- **Por quê:** A ferramenta genérica não conhece as regras do negócio: só um teste escrito para o sistema prova que o cliente A não vê o dado do cliente B. O teste de regressão impede que a falha corrigida volte.
- **Fontes:**
  - primária — NIST SP 800-218 (SSDF v1.1), tarefa PW.8.2: teste dinâmico na suíte automatizada e testes das vulnerabilidades já relatadas — https://csrc.nist.gov/pubs/sp/800/218/final — conferida em 2026-11-09
  - primária — AWS Security Blog, How the unique culture of security at AWS makes a difference: frameworks automatizados de teste de API e teste de intrusão antes do lançamento — https://aws.amazon.com/blogs/security/how-the-unique-culture-of-security-at-aws-makes-a-difference — conferida em 2026-11-09
  - primária — AWS Well-Architected, Security Pillar, SEC11-BP02: automatizar os testes em todo o ciclo de desenvolvimento e de release — https://docs.aws.amazon.com/wellarchitected/latest/security-pillar/application-security.html — conferida em 2026-11-09
- **Como verificar:** Procure no repositório os testes de autorização e de autenticação das funções sensíveis, veja se rodam no CI e peça o último relatório do DAST.
- **Como implementar:** Escreva testes de acesso negado (outro papel, outro cliente, sem login) para cada rota sensível e rode um DAST aberto de linha de base (por exemplo, o ZAP) contra a homologação no pipeline de release.
- **Evidência:** A lista dos testes de segurança, a última execução no CI e o relatório do DAST, com data, em `.security-standard/evidencias/`.
- **Mapa:** CAIQ: AIS-05; SIG: —; ISO: A.8.29; SOC2: —; CSF: PR.PS-06, ID.IM-02; CIS: 16.12; ASVS: —

### DEV-15 — Segredos no CI
- **Enunciado:** Guarde os segredos do pipeline no cofre do CI, com o menor escopo possível, e prefira credencial de curta duração a chave fixa.
- **Nível mínimo:** Essencial
- **Perfis:** todos
- **Parâmetro:** Essencial: segredos só no cofre do CI, nunca no código nem no artefato de build, regra que o ASVS põe no L2 (13.3.1) e a skill traz para o Essencial (proposta), e o `GITHUB_TOKEN` só com leitura do conteúdo por padrão, com permissão maior só no job que precisa (GitHub); Fornecedor: acesso à nuvem por OIDC, com token de curta duração no lugar de chave fixa (GitHub), e segredos de produção separados num ambiente que exige aprovação para uso (proposta); Big tech: os segredos de longa duração do pipeline trocados por credenciais gerenciadas pelo sistema, como identidades gerenciadas (Microsoft SFI)
- **Por quê:** O pipeline guarda as chaves da produção; quem compromete uma action ou um log leva tudo. Token com pouco poder e credencial que expira logo limitam o estrago.
- **Fontes:**
  - primária — OWASP ASVS 5.0.0, V13 Configuration (13.3.1: cofre de segredos; segredo fora do código e dos artefatos) — https://github.com/OWASP/ASVS/blob/v5.0.0/5.0/en/0x22-V13-Configuration.md — conferida em 2026-11-09
  - primária — GitHub Docs, Secure use reference: permissão mínima do GITHUB_TOKEN, só leitura do conteúdo por padrão — https://docs.github.com/en/actions/reference/security/secure-use — conferida em 2026-11-09
  - primária — GitHub Docs, OpenID Connect: token de curta duração direto do provedor de nuvem — https://docs.github.com/en/actions/concepts/security/openid-connect — conferida em 2026-11-09
  - primária — Microsoft Learn, What's new in Microsoft Secure Future Initiative: sair dos segredos de longa duração para credenciais gerenciadas pelo sistema — https://learn.microsoft.com/en-us/security/zero-trust/sfi/secure-future-initiative-whats-new — conferida em 2026-11-09
- **Como verificar:** Procure segredos no repositório (DEV-03) e confira o `permissions:` de cada workflow, o uso de OIDC e a lista dos nomes dos segredos por ambiente; o que não pode aparecer nos logs, inclusive nos do CI, é regra do DAT-11.
- **Como implementar:** Ponha `permissions: contents: read` no topo de cada workflow, como no `assets/ci-seguranca.yml`; troque as chaves de nuvem por OIDC; separe os segredos de produção num ambiente com aprovação.
- **Evidência:** A lista dos segredos do CI por ambiente (só nomes, nunca valores) e os workflows com `permissions:`, em `.security-standard/evidencias/`.
- **Mapa:** CAIQ: —; SIG: —; ISO: A.5.17; SOC2: —; CSF: PR.AA-01; CIS: —; ASVS: V13.3

### DEV-16 — Registro de deploy
- **Enunciado:** Registre de forma automática cada deploy em produção: quem fez, quando, que versão e quem aprovou.
- **Nível mínimo:** Essencial
- **Perfis:** todos
- **Parâmetro:** Essencial: todo deploy em produção registrado automaticamente com autor, data e hora, commit ou versão e aprovação (proposta), e guardado com os eventos de segurança, pelo prazo que o processo de logs do OPS-05 define (CIS 8.1, IG1); no perfil cartoes, toda mudança em produção com motivo, impacto na segurança, aprovação documentada, teste e procedimento de volta (PCI DSS 6.5.1); Fornecedor: o registro de deploy guardado por ao menos 90 dias, como no OPS-05, e a mesma regra de mudança em todos os perfis (proposta: requisito da PCI DSS 6.5.1 adotado para todos os perfis); Big tech: o uso da saída de emergência registrado com a justificativa e avisado à segurança e ao dono do serviço, e o que está rodando conferido contra a política pelo menos uma vez por dia (Binary Authorization for Borg)
- **Por quê:** Quando algo quebra ou vaza, a primeira pergunta é o que mudou e quem mudou. Sem registro não há resposta nem prova para o cliente.
- **Fontes:**
  - primária — PCI DSS v4.0, tradução oficial em português, requisito 6.5.1, para o perfil cartoes (mudança em produção com motivo, impacto na segurança, aprovação, teste e volta) — https://listings.pcisecuritystandards.org/documents/PCI-DSS-v4_0-PT.pdf — conferida em 2026-11-09
  - primária — Google Cloud, Binary Authorization for Borg: registro e aviso do deploy de emergência e verificação diária — https://docs.cloud.google.com/docs/security/binary-authorization-for-borg — conferida em 2026-11-09
  - primária — CIS Critical Security Controls v8.1, salvaguardas 8.1, do IG1, e 8.10, do IG2, no mapeamento oficial do CIS para o CCM v4.1 (processo escrito de gestão dos logs de auditoria, com a coleta, a revisão e a retenção, revisto ao menos uma vez por ano; logs de auditoria guardados por ao menos 90 dias) — https://www.cisecurity.org/insights/white-papers/cloud-security-alliance-cloud-controls-matrix-ccm-v4-1-cis-controls — conferida em 2026-11-09
- **Como verificar:** Peça a lista dos deploys de produção dos últimos 90 dias e confira autor, versão e aprovação de cada um; compare com o histórico de deploys que o usuário exporta da hospedagem para achar deploy sem registro.
- **Como implementar:** Faça o deploy de produção só pelo CI, com um ambiente de produção que exige aprovação, e exporte o histórico de deploys (do GitHub ou da hospedagem) para o destino central dos logs do OPS-05, com a mesma guarda.
- **Evidência:** Exportação do histórico de deploys com data, em `.security-standard/evidencias/`.
- **Mapa:** CAIQ: CCC-03; SIG: —; ISO: A.8.15, A.8.32; SOC2: —; CSF: PR.PS-04, ID.RA-07; CIS: 8.2; ASVS: —

### DEV-17 — Treinamento em desenvolvimento seguro
- **Enunciado:** Treine em desenvolvimento seguro toda pessoa que escreve ou revisa código, na entrada e depois periodicamente.
- **Nível mínimo:** Essencial
- **Perfis:** todos
- **Parâmetro:** Essencial: treinamento em codificação segura para o ambiente e as responsabilidades de cada pessoa, pelo menos uma vez por ano (CIS v8.1, 16.9), e também na admissão, cobrindo o OWASP Top 10:2025 (proposta); no perfil cartoes, pelo menos uma vez a cada 12 meses, sobre a segurança das linguagens usadas, o desenho seguro, a codificação segura e, se houver ferramenta de teste de segurança, o uso dela (PCI DSS 6.2.2); Fornecedor: treinamento por papel, com o resultado esperado de cada papel e revisão periódica da proficiência (SSDF PO.2.2), e registro de quem concluiu (proposta); Big tech: pessoas de referência em segurança dentro das equipes de produto, que fazem a primeira avaliação das revisões de segurança (Security Guardians, da AWS)
- **Por quê:** As ferramentas pegam parte das falhas; o resto depende de quem escreve e revisa saber o que procurar. O treinamento periódico acompanha as mudanças das linguagens e das ameaças.
- **Fontes:**
  - primária — CIS Critical Security Controls v8.1, salvaguarda 16.9, do IG2, no mapeamento oficial do CIS para o CCM v4.1 (treinamento de quem desenvolve em codificação segura, ao menos uma vez por ano) — https://www.cisecurity.org/insights/white-papers/cloud-security-alliance-cloud-controls-matrix-ccm-v4-1-cis-controls — conferida em 2026-11-09
  - primária — PCI DSS v4.0, tradução oficial em português, requisito 6.2.2, para o perfil cartoes — https://listings.pcisecuritystandards.org/documents/PCI-DSS-v4_0-PT.pdf — conferida em 2026-11-09
  - primária — NIST SP 800-218 (SSDF v1.1), tarefa PO.2.2: treinamento por papel — https://csrc.nist.gov/pubs/sp/800/218/final — conferida em 2026-11-09
  - primária — AWS Security Blog, Security Guardians — https://aws.amazon.com/blogs/security/how-aws-built-the-security-guardians-program-a-mechanism-to-distribute-security-ownership — conferida em 2026-11-09
- **Como verificar:** Peça a lista das pessoas que escrevem ou revisam código e o registro do último treinamento de cada uma, com data e conteúdo.
- **Como implementar:** Escolha um conteúdo aberto (por exemplo, o OWASP Top 10:2025 e os capítulos do ASVS que se aplicam ao sistema), faça a sessão na admissão e uma vez por ano e guarde a lista de presença.
- **Evidência:** Registro de treinamento por pessoa, com data e conteúdo, em `.security-standard/evidencias/`.
- **Mapa:** CAIQ: HRS-11; SIG: —; ISO: A.6.3; SOC2: —; CSF: PR.AT-02; CIS: 16.9; ASVS: —

### DEV-18 — OWASP Top 10:2025 e ASVS 5.0 como requisitos
- **Enunciado:** Use o OWASP ASVS 5.0, no nível que corresponde ao nível alvo, como lista de requisitos de segurança da aplicação, e o OWASP Top 10:2025 como lista mínima de riscos da revisão.
- **Nível mínimo:** Essencial
- **Perfis:** todos
- **Parâmetro:** Essencial: ASVS 5.0 L1; Fornecedor: ASVS 5.0 L2; Big tech: ASVS 5.0 L3. O ASVS deixa a escolha do nível à organização e descreve o L1 como o mínimo e o L2 como o nível que a maioria das aplicações deve buscar; a correspondência com os níveis desta skill é proposta (proposta)
- **Por quê:** O ASVS transforma "aplicação segura" em requisitos verificáveis, com identificador que se cita no questionário do cliente. O Top 10 é a lista de riscos que todo revisor deve conhecer.
- **Fontes:**
  - primária — OWASP ASVS 5.0.0, What is the ASVS (níveis L1, L2 e L3 e escolha do nível) — https://github.com/OWASP/ASVS/blob/v5.0.0/5.0/en/0x03-What-is-the-ASVS.md — conferida em 2026-11-09
  - primária — OWASP Application Security Verification Standard (página do projeto) — https://owasp.org/www-project-application-security-verification-standard/ — conferida em 2026-11-09
  - primária — OWASP Top 10:2025 — https://owasp.org/Top10/2025/ — conferida em 2026-11-09
- **Como verificar:** Peça a planilha dos requisitos do ASVS do nível alvo com a situação de cada um (atende, não atende, não se aplica) e a data; confira se a revisão de código usa o Top 10:2025.
- **Como implementar:** Tire os capítulos que não se aplicam (por exemplo, WebRTC ou OAuth, se o sistema não usa), marque a situação de cada requisito do nível e transforme os que faltam em tarefas; DEV-21 a DEV-25 trazem os requisitos de L1 mais cobrados.
- **Evidência:** A planilha do ASVS com data e com os requisitos citados pela versão (v5.0.0-<id>), em `.security-standard/evidencias/`.
- **Mapa:** CAIQ: AIS-02; SIG: —; ISO: A.8.26; SOC2: —; CSF: PR.PS-06; CIS: 16.1; ASVS: V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15, V16, V17

### DEV-19 — Linguagens, frameworks e bibliotecas com manutenção ativa
- **Enunciado:** Use só linguagens, frameworks e bibliotecas com suporte e manutenção ativos e troque o que se aproxima do fim do suporte antes da data.
- **Nível mínimo:** Essencial
- **Perfis:** todos
- **Parâmetro:** Essencial: nenhuma linguagem, framework ou biblioteca em versão fora do suporte de quem a mantém (CSF PR.PS-02), com o sistema operacional, o banco e o runtime da produção seguindo o OPS-08, e a lista das datas de fim de suporte revista a cada trimestre (proposta); Fornecedor: bibliotecas só de repositórios definidos, confiáveis e mantidos (ASVS 15.1.2, L2), e dependência direta sem versão nova há mais de 24 meses posta na lista de troca (proposta); Big tech: produto novo em linguagem com segurança de memória e plano de migração para o legado (pledge da CISA)
- **Por quê:** Componente sem manutenção não recebe correção quando aparece uma falha, e o prazo do DEV-09 fica impossível de cumprir. Linguagem com segurança de memória elimina uma classe inteira de falhas.
- **Fontes:**
  - primária — NIST CSF 2.0, PR.PS-02: software mantido, substituído e removido conforme o risco — https://nvlpubs.nist.gov/nistpubs/CSWP/NIST.CSWP.29.pdf — conferida em 2026-11-09
  - primária — OWASP ASVS 5.0.0, V15 (15.1.2: componentes de repositórios confiáveis e mantidos) — https://github.com/OWASP/ASVS/blob/v5.0.0/5.0/en/0x24-V15-Secure-Coding-and-Architecture.md — conferida em 2026-11-09
  - primária — CISA, Secure by Design Pledge: roteiro para linguagens com segurança de memória e produtos novos nelas — https://www.cisa.gov/securebydesign/pledge — conferida em 2026-11-09
- **Como verificar:** Liste linguagem, framework e bibliotecas principais com a versão em uso e a data de fim de suporte de cada um (sistema operacional, banco e runtime ficam no OPS-08); confira as dependências diretas sem versão nova há mais de 24 meses.
- **Como implementar:** Mantenha no repositório a lista das versões e das datas de fim de suporte e ponha cada troca no plano um trimestre antes da data (proposta).
- **Evidência:** A lista das versões e dos fins de suporte, com data, em `.security-standard/evidencias/`.
- **Mapa:** CAIQ: TVM-06; SIG: —; ISO: A.8.8; SOC2: —; CSF: PR.PS-02; CIS: 2.2, 16.5; ASVS: V15.1

### DEV-20 — Código gerado por IA com as mesmas regras
- **Enunciado:** Submeta o código gerado ou alterado por ferramenta de IA às mesmas regras do código escrito por pessoas: revisão humana, verificações do CI e conferência das dependências que ela sugerir.
- **Nível mínimo:** Essencial
- **Perfis:** todos
- **Parâmetro:** Essencial: nenhum código de IA entra sem revisão humana e sem passar no CI (DEV-02 e DEV-03), e o agente de IA nunca aprova nem faz merge do próprio PR (proposta); dependência sugerida pela IA conferida quanto a existência, nome exato e origem antes de entrar (proposta); Fornecedor: PR aberto por agente identificado como tal e token do agente com o menor escopo, sem permissão de merge (proposta); Big tech: patch proposto por IA revisado por engenheiro designado antes do envio, como o Google faz no OSS-Fuzz enquanto o recurso está em beta
- **Por quê:** Código de IA pode compilar e ainda ter falha de segurança, e assistentes sugerem pacotes que não existem e que um atacante pode registrar. A revisão e as ferramentas não mudam por causa de quem escreveu.
- **Fontes:**
  - primária — OpenSSF, Security-Focused Guide for AI Code Assistant Instructions: código de IA não dispensa revisão, teste e análise estática; pacotes alucinados — https://best.openssf.org/Security-Focused-Guide-for-AI-Code-Assistant-Instructions — conferida em 2026-11-09
  - primária — GitHub Docs, Responsible use of GitHub Copilot inline suggestions: revisar e validar as sugestões e seguir as práticas de código seguro e de revisão — https://docs.github.com/en/copilot/responsible-use/inline-suggestions — conferida em 2026-11-09
  - primária — Google, OSS-Fuzz, AI-powered patches (beta): engenheiros revisam cada patch proposto por IA — https://google.github.io/oss-fuzz/ai-patches-beta/ — conferida em 2026-11-09
- **Como verificar:** Pergunte que ferramentas de IA a equipe usa e com que permissões; confira, em PRs recentes de agente, a aprovação humana e as verificações do CI; procure no histórico dependência que não existe no registro de pacotes.
- **Como implementar:** Aplique a proteção de branch (DEV-02) também aos PRs de agentes, dê ao agente um token sem permissão de merge e ponha na revisão a pergunta "esta dependência existe e é a esperada?".
- **Evidência:** A lista das ferramentas de IA com as permissões e uma amostra de PRs de agente com a aprovação humana, em `.security-standard/evidencias/`.
- **Mapa:** CAIQ: AIS-04; SIG: —; ISO: A.8.28; SOC2: —; CSF: PR.PS-06; CIS: 16.1; ASVS: —

### DEV-21 — Autenticação dos usuários do sistema
- **Enunciado:** Autentique os usuários do sistema com proteção contra força bruta e com autenticação multifator (MFA).
- **Nível mínimo:** Essencial
- **Perfis:** todos
- **Parâmetro:** Essencial: controles contra credential stuffing e força bruta documentados e aplicados (ASVS 6.1.1 e 6.3.1, L1), com no máximo 100 tentativas falhas seguidas por autenticador antes de desativá-lo (NIST SP 800-63B-4, 3.2.2), e MFA disponível para todo usuário (proposta); Fornecedor: MFA obrigatório para acessar o sistema (ASVS 6.3.3, L2); Big tech: pelo menos um fator de hardware resistente a phishing, como uma chave FIDO (exigência do L3 no ASVS 6.3.3; a passkey sincronizada pode não bastar)
- **Por quê:** Senha vazada em outro site é testada em massa contra o login (credential stuffing). Para a CISA, o MFA é a maior defesa contra ataques a senhas.
- **Fontes:**
  - primária — OWASP ASVS 5.0.0, V6 Authentication (6.1.1, 6.3.1 e 6.3.3) — https://github.com/OWASP/ASVS/blob/v5.0.0/5.0/en/0x15-V6-Authentication.md — conferida em 2026-11-09
  - primária — NIST SP 800-63B-4, seção 3.2.2 Rate Limiting (Throttling) — https://pages.nist.gov/800-63-4/sp800-63b.html — conferida em 2026-11-09
  - primária — CISA, Secure by Design Pledge: meta de aumentar o uso de MFA nos produtos — https://www.cisa.gov/securebydesign/pledge — conferida em 2026-11-09
- **Como verificar:** Com o OK do usuário e só em homologação, tente logins errados seguidos e veja o bloqueio ou o atraso; confira na configuração se o MFA está disponível (Essencial) ou obrigatório (Fornecedor) e quais fatores são aceitos.
- **Como implementar:** Use o provedor de identidade ou a biblioteca de autenticação do framework com limite de tentativas e MFA (TOTP, passkey ou chave FIDO2); no Big tech, exija chave FIDO2 de hardware. No perfil setor-publico, o SSO para os usuários do órgão segue o GOV-13.
- **Evidência:** A documentação dos controles contra força bruta, a configuração do MFA e o teste de bloqueio, com data, em `.security-standard/evidencias/`.
- **Mapa:** CAIQ: IAM-13; SIG: —; ISO: A.8.5; SOC2: —; CSF: PR.AA-03; CIS: 6.3; ASVS: V6

### DEV-22 — Senhas guardadas com função de hash de senha
- **Enunciado:** Guarde as senhas só com função de hash de senha, com sal e fator de custo, nunca em texto puro nem com hash rápido.
- **Nível mínimo:** Essencial
- **Perfis:** todos
- **Parâmetro:** Argon2id com no mínimo 19 MiB de memória, 2 iterações e paralelismo 1; em sistema legado com bcrypt, fator de trabalho 10 ou mais (o bcrypt usa só os primeiros 72 bytes da senha); se for exigido FIPS-140, PBKDF2-HMAC-SHA-256 com 600.000 iterações ou mais; sal com pelo menos 32 bits. O ASVS põe o requisito no L2 (11.4.2), e o NIST o exige de todo verificador ("SHALL"); a skill segue o NIST e o põe no Essencial
- **Por quê:** Quando o banco vaza, a senha guardada com hash rápido ou sem sal cai em pouco tempo. A função de hash de senha torna cada tentativa cara para o atacante.
- **Fontes:**
  - primária — NIST SP 800-63B-4, seção 3.1.1.2 Password Verifiers: senha com sal e hash por esquema adequado; sal de pelo menos 32 bits — https://pages.nist.gov/800-63-4/sp800-63b.html — conferida em 2026-11-09
  - primária — OWASP Cheat Sheet Series, Password Storage (parâmetros mínimos do Argon2id, do bcrypt e do PBKDF2) — https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html — conferida em 2026-11-09
  - primária — OWASP ASVS 5.0.0, V11 Cryptography (11.4.2, L2) — https://github.com/OWASP/ASVS/blob/v5.0.0/5.0/en/0x20-V11-Cryptography.md — conferida em 2026-11-09
- **Como verificar:** Leia o código de cadastro e de login e confira algoritmo e parâmetros; na homologação, olhe só o prefixo de um hash, que mostra o algoritmo e os parâmetros (por exemplo, `$argon2id$v=19$m=19456,t=2,p=1$` ou `$2b$10$`).
- **Como implementar:** Use a biblioteca de Argon2id da linguagem com os parâmetros mínimos e troque os hashes antigos no próximo login de cada usuário, como descreve a folha de dicas da OWASP.
- **Evidência:** O trecho do código com algoritmo e parâmetros e só o prefixo de um hash da homologação (por exemplo, `$argon2id$v=19$m=19456,t=2,p=1$`), nunca o hash inteiro nem hash da produção, em `.security-standard/evidencias/`.
- **Mapa:** CAIQ: IAM-02, IAM-14; SIG: —; ISO: A.5.17, A.8.24; SOC2: —; CSF: PR.AA-01, PR.DS-01; CIS: —; ASVS: V11.4

### DEV-23 — Autorização no servidor, por função e por objeto
- **Enunciado:** Autorize no servidor cada função e cada dado acessado, inclusive entre clientes diferentes, só com permissão explícita.
- **Nível mínimo:** Essencial
- **Perfis:** todos
- **Parâmetro:** Essencial: regras de acesso por função e por dado escritas (ASVS 8.1.1) e aplicadas no servidor, só com permissão explícita (8.2.1, 8.2.2 e 8.3.1, todos L1), de modo que o token de um cliente não abre o dado de outro (8.2.2; OWASP API1:2023); Perfis financeiro, seguros e setor-publico: em sistema multicliente, os dados de cada cliente identificados e separados dos dados dos outros clientes por controle lógico aplicado a toda leitura e escrita, ou por instalação dedicada, com controle de acesso que proteja esses dados, durante todo o contrato (Res. CMN 4.893 e Res. BCB 85, art. 12, II, "g" e "h", e art. 17, III; Circular SUSEP 638, art. 11, IV; IN GSI/PR 5/2021, art. 20, X, "a"); Fornecedor: isolamento entre clientes em sistema multicliente (8.4.1, L2) e restrição por campo (8.2.3, L2), com teste automatizado de acesso cruzado entre clientes (proposta); Big tech: decisões que levam em conta o contexto do acesso, como horário, local e dispositivo (8.2.4, L3)
- **Por quê:** Controle de acesso quebrado é o primeiro risco do OWASP Top 10:2025. A falha típica é trocar o id na URL e ver o dado de outro cliente.
- **Fontes:**
  - primária — OWASP ASVS 5.0.0, V8 Authorization — https://github.com/OWASP/ASVS/blob/v5.0.0/5.0/en/0x17-V8-Authorization.md — conferida em 2026-11-09
  - primária — OWASP API Security Top 10, API1:2023 Broken Object Level Authorization — https://api-security.owasp.org/editions/2023/en/0xa1-broken-object-level-authorization/ — conferida em 2026-11-09
  - primária — OWASP Top 10:2025, A01 Broken Access Control — https://owasp.org/Top10/2025/ — conferida em 2026-11-09
  - primária — Res. CMN 4.893/2021, texto consolidado, art. 12, II, "g" e "h", e art. 17, III, para o perfil financeiro (dados dos clientes da instituição identificados e segregados por controles físicos ou lógicos; qualidade dos controles de acesso; segregação mantida enquanto o contrato vigorar) — https://www.bcb.gov.br/estabilidadefinanceira/exibenormativo?tipo=Resolu%C3%A7%C3%A3o%20CMN&numero=4893 — conferida em 2026-11-09
  - primária — Res. BCB 85/2021, texto consolidado, art. 12, II, "g" e "h", e art. 17, III, para o perfil financeiro (mesmas regras, para os clientes e os usuários finais, na redação da Res. BCB 368/2024) — https://www.bcb.gov.br/estabilidadefinanceira/exibenormativo?tipo=Resolu%C3%A7%C3%A3o%20BCB&numero=85 — conferida em 2026-11-09
  - primária — Circular SUSEP 638/2021, art. 11, IV e § 4º, para o perfil seguros (dados da supervisionada e dos clientes dela segregados dos dados dos demais clientes do prestador; a exigência vai expressa no contrato) — https://www2.susep.gov.br/safe/scripts/bnweb/bnmapi.exe?router=upload%2F25121 — conferida em 2026-11-09
  - primária — IN GSI/PR nº 5/2021, art. 20, X, a, para o perfil setor-publico (dados e serviços do órgão isolados dos outros clientes por separação lógica) — https://www.in.gov.br/en/web/dou/-/instrucao-normativa-n-5-de-30-de-agosto-de-2021-341649684 — conferida em 2026-11-09
- **Como verificar:** Com o OK do usuário e só em homologação, com dois usuários de clientes diferentes, chame as rotas de leitura e de escrita de um com o token do outro e confira a recusa (403 ou 404); leia o documento das regras de acesso.
- **Como implementar:** Centralize a checagem numa camada que recebe usuário, ação e objeto, filtre toda consulta pelo cliente do usuário e escreva o teste de acesso cruzado (DEV-14).
- **Evidência:** O documento das regras, o desenho da separação dos dados por cliente (chave do cliente em toda tabela, com filtro na camada de dados, ou esquema ou banco por cliente) e o resultado dos testes de acesso cruzado, com data, em `.security-standard/evidencias/`. A cláusula do contrato sobre a segregação (Res. CMN 4.893, art. 17, III; Circular SUSEP 638, art. 11, § 4º) é do GOV-13.
- **Mapa:** CAIQ: AIS-08, I&S-06, IAM-15; SIG: —; ISO: A.5.15, A.8.3; SOC2: —; CSF: PR.AA-05; CIS: 6.8; ASVS: V8

### DEV-24 — Consultas parametrizadas e saída codificada
- **Enunciado:** Monte toda consulta ao banco com parâmetros e codifique toda saída conforme o contexto em que ela aparece.
- **Nível mínimo:** Essencial
- **Perfis:** todos
- **Parâmetro:** Consultas por parâmetro, ORM ou equivalente, também nos procedimentos armazenados (ASVS 1.2.4, L1); saída codificada conforme o contexto: HTML, atributo, CSS, cabeçalho HTTP, URL e JavaScript ou JSON (1.2.1 a 1.2.3, L1); regra de SAST para injeção e XSS que impede o merge (proposta)
- **Por quê:** Injeção e XSS são classes inteiras de falha que se evitam no desenho, e a CISA propõe reduzi-las em escala, com consultas parametrizadas e frameworks que escapam a saída. A injeção é o quinto risco do OWASP Top 10:2025.
- **Fontes:**
  - primária — OWASP ASVS 5.0.0, V1 Encoding and Sanitization (1.2.1 a 1.2.4) — https://github.com/OWASP/ASVS/blob/v5.0.0/5.0/en/0x10-V1-Encoding-and-Sanitization.md — conferida em 2026-11-09
  - primária — OWASP Top 10:2025, A05 Injection — https://owasp.org/Top10/2025/ — conferida em 2026-11-09
  - primária — CISA, Secure by Design Pledge: meta de reduzir classes de vulnerabilidade, com consultas parametrizadas e frameworks que evitam XSS — https://www.cisa.gov/securebydesign/pledge — conferida em 2026-11-09
- **Como verificar:** Procure no código concatenação de texto em consulta (SQL ou NoSQL) e saída sem escape (por exemplo, `dangerouslySetInnerHTML`, `innerHTML` ou o filtro `safe` do template) e confira as regras de injeção e XSS no SAST do CI.
- **Como implementar:** Use o ORM ou consultas preparadas e o motor de templates com escape automático; mantenha as regras de injeção e XSS do Semgrep (o conjunto `p/default` do `assets/ci-seguranca.yml` já as traz) e trate cada exceção na revisão.
- **Evidência:** A saída do SAST sem achado de injeção ou XSS aberto e a lista das exceções revisadas, com data, em `.security-standard/evidencias/`.
- **Mapa:** CAIQ: AIS-04; SIG: —; ISO: A.8.28; SOC2: —; CSF: PR.PS-06; CIS: 16.11; ASVS: V1.2

### DEV-25 — Cookies seguros e proteção contra CSRF
- **Enunciado:** Proteja os cookies e aceite nas funções sensíveis só requisições que comprovem vir do próprio sistema.
- **Nível mínimo:** Essencial
- **Perfis:** todos
- **Parâmetro:** Essencial: todo cookie com o atributo `Secure` e o prefixo `__Host-` ou `__Secure-` (ASVS 3.3.1, L1), e toda função sensível só aceita requisição que comprove ter vindo do próprio sistema, por token anti-CSRF ou por cabeçalho que exija a verificação prévia do CORS (3.5.1, L1); Fornecedor: `SameSite` definido conforme o propósito de cada cookie (3.3.2, L2) e `HttpOnly` no cookie de sessão (3.3.4, L2); o ASVS não fixa o valor do `SameSite`
- **Por quê:** Cookie sem `Secure` vaza em conexão sem TLS, e sem proteção contra CSRF outro site faz o navegador do usuário agir em nome dele. Os frameworks web da Meta põem o token anti-CSRF em todo formulário POST por padrão.
- **Fontes:**
  - primária — OWASP ASVS 5.0.0, V3 Web Frontend Security (3.3.1 a 3.3.4 e 3.5.1) — https://github.com/OWASP/ASVS/blob/v5.0.0/5.0/en/0x12-V3-Web-Frontend-Security.md — conferida em 2026-11-09
  - primária — Meta Engineering, Zoncolan: os frameworks web embutem e conferem o token anti-CSRF — https://engineering.fb.com/2019/08/15/security/zoncolan/ — conferida em 2026-11-09
- **Como verificar:** Inspecione os cabeçalhos `Set-Cookie` da homologação (atributos e prefixos) e, com o OK do usuário e só na homologação, tente uma requisição sensível vinda de outra origem, sem o token.
- **Como implementar:** Configure os atributos no framework de sessão e ligue a proteção anti-CSRF nativa do framework.
- **Evidência:** Os cabeçalhos `Set-Cookie` coletados e o resultado do teste de CSRF, com data, em `.security-standard/evidencias/`.
- **Mapa:** CAIQ: AIS-04; SIG: —; ISO: A.8.28; SOC2: —; CSF: PR.PS-06; CIS: —; ASVS: V3.3, V3.5

### DEV-26 — Licenças das dependências e dos conteúdos de terceiros
- **Enunciado:** Confira a licença de toda dependência e de todo conteúdo de terceiros antes de usá-los e mantenha a lista das licenças permitidas e proibidas.
- **Nível mínimo:** Fornecedor
- **Perfis:** todos
- **Parâmetro:** Fornecedor: lista de licenças permitidas e proibidas, conferida a cada build a partir do SBOM (DEV-05), com um inventário que inclui fontes, imagens e modelos de IA (proposta); Big tech: programa de conformidade de licenças de código aberto nos requisitos da ISO/IEC 5230 (OpenChain) e conferência automática das obrigações legais de cada componente no build (Component Governance, da Microsoft)
- **Por quê:** Licença copyleft ou ausente num componente pode obrigar a abrir o código ou impedir a venda do produto. A conferência automática pega o problema antes de o componente entrar.
- **Fontes:**
  - primária — OpenChain Project, ISO/IEC 5230 License Compliance: requisitos de um programa de conformidade de licenças de código aberto — https://openchainproject.org/license-compliance — conferida em 2026-11-09
  - primária — Microsoft Learn, Security development and operations overview: Component Governance confere as obrigações legais dos componentes de código aberto — https://learn.microsoft.com/en-us/compliance/assurance/assurance-security-development-and-operation — conferida em 2026-11-09
- **Como verificar:** Gere o relatório de licenças a partir do SBOM ou do osv-scanner e confira cada licença contra a lista; pergunte de onde vêm as fontes, as imagens e os modelos de IA e qual a licença de cada um.
- **Como implementar:** Escreva a lista (por exemplo, MIT, Apache-2.0 e BSD permitidas; GPL e AGPL só com revisão; componente sem licença proibido) e rode a conferência no CI (no osv-scanner, a opção `--licenses` com a lista das permitidas).
- **Evidência:** A lista de licenças e o último relatório da conferência, com data, em `.security-standard/evidencias/`.
- **Mapa:** CAIQ: —; SIG: —; ISO: A.5.32; SOC2: —; CSF: GV.OC-03; CIS: —; ASVS: —
