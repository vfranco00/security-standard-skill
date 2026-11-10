# Controles de exemplo

Fixture do teste `lint-controles.test.sh`. Os blocos mostram o formato de `docs/formato-dos-controles.md`: valem como exemplo de formato, não de conteúdo, e não são controles do catálogo. IAM-01 e IAM-02 são válidos. IAM-03 é inválido de propósito (sem o campo Fontes e com nível fora do conjunto) e fica por último, para o teste tirá-lo com `sed`.

### IAM-01 — MFA nas contas administrativas
- **Enunciado:** Exija um segundo fator de autenticação em toda conta com acesso administrativo à nuvem, ao repositório e ao banco de dados.
- **Nível mínimo:** Essencial
- **Perfis:** todos
- **Parâmetro:** 100% das contas administrativas com segundo fator ativo
- **Por quê:** A senha sozinha cai com phishing e com vazamento de credenciais. O segundo fator barra a maior parte das tomadas de conta administrativa.
- **Fontes:**
  - primária — PCI DSS v4.0, tradução oficial em português, requisito 8.4 — https://listings.pcisecuritystandards.org/documents/PCI-DSS-v4_0-PT.pdf — conferida em 2026-11-09
  - primária — Microsoft Learn, MFA obrigatório para quem entra no portal do Azure e nos centros de administração do Entra e do Intune — https://learn.microsoft.com/en-us/entra/identity/authentication/concept-mandatory-multifactor-authentication — conferida em 2026-11-09
- **Como verificar:** Liste as contas administrativas da nuvem, do repositório e do banco e confira, na configuração de cada uma, que o segundo fator está ativo.
- **Como implementar:** Ligue o MFA obrigatório no provedor de identidade e no provedor de nuvem; registre cada exceção com dono e prazo.
- **Evidência:** Exportação da política de MFA, com data, em `.security-standard/evidencias/`.
- **Mapa:** CAIQ: —; SIG: Access Control; ISO: —; SOC2: —; CSF: PR.AA-03; CIS: —; ASVS: —

### IAM-02 — Revisão dos acessos de terceiros
- **Enunciado:** Revise a cada trimestre os acessos de prestadores e terceirizados e retire os que não forem mais necessários.
- **Nível mínimo:** Fornecedor
- **Perfis:** financeiro, seguros
- **Parâmetro:** a cada 90 dias (proposta)
- **Por quê:** O acesso de terceiro sobra quando o serviço acaba ou muda de pessoa. A norma pede revisão periódica e tempestiva sem fixar o prazo; o número de 90 dias é proposta da skill.
- **Fontes:**
  - primária — Res. CMN 4.893/2021, art. 3º, § 9º, II, na redação da Res. CMN 5.274/2025 (revisão periódica e tempestiva das permissões de acesso, em especial de terceirizados) — https://www.bcb.gov.br/estabilidadefinanceira/exibenormativo?tipo=Resolu%C3%A7%C3%A3o%20CMN&numero=5274 — conferida em 2026-11-09
- **Como verificar:** Peça a lista das contas de terceiros com a data da última revisão e confira que nenhuma passou de 90 dias.
- **Como implementar:** Agende a revisão trimestral; o dono de cada sistema confirma ou retira cada acesso de terceiro.
- **Evidência:** Planilha ou ata da revisão, com data e responsável, em `.security-standard/evidencias/`.
- **Mapa:** CAIQ: —; SIG: Access Control; ISO: —; SOC2: —; CSF: PR.AA-05; CIS: —; ASVS: —

### IAM-03 — Contas de serviço com dono
- **Enunciado:** Dê a cada conta de serviço um dono e o menor escopo que a tarefa pede.
- **Nível mínimo:** Alto
- **Perfis:** todos
- **Parâmetro:** 100% das contas de serviço com dono registrado
- **Por quê:** Conta de serviço sem dono não é revista nem desligada.
- **Como verificar:** Liste as contas de serviço e confira o dono de cada uma.
- **Como implementar:** Registre o dono e o escopo no inventário de contas.
- **Evidência:** Inventário das contas de serviço em `.security-standard/evidencias/`.
- **Mapa:** CAIQ: —; SIG: Access Control; ISO: —; SOC2: —; CSF: PR.AA-01; CIS: —; ASVS: —
