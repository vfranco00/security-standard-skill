# Fontes do catálogo

Fontes primárias que os controles do catálogo e as referências das skills citam: documentação oficial das big techs, textos e páginas oficiais dos frameworks, normas e decisões brasileiras, documentação das plataformas e ferramentas que os controles usam e documentos que grandes empresas publicam para os seus fornecedores. O bloco de cada controle, em `skills/*/references/controles-*.md`, traz as próprias fontes com tipo, URL e data; esta tabela é a visão consolidada. A regra das fontes está em `docs/formato-dos-controles.md`.

- Cada URL foi aberta com `curl` na data da última coluna. As que recusam robôs estão em `scripts/fontes-ignorar.txt`, com a justificativa, e trazem "recusa robôs" na última coluna.
- "Página atual" é documento vivo, sem número de versão: vale o texto da data da conferência.
- Norma paga (ISO) ou com licença própria (PCI DSS v4.0.1, SIG, CIS Controls, CCM/CAIQ, TSC) entra pela página oficial de referência. O catálogo cita só o identificador e parafraseia, sem copiar texto.

## Big techs

| Sigla | Documento | Emissor | Versão ou data | URL | Conferida em |
|---|---|---|---|---|---|
| GOOG-INFRA | Google infrastructure security design overview | Google Cloud | página atual | https://docs.cloud.google.com/docs/security/infrastructure/design | 2026-11-09 |
| GOOG-ACESSO | Privileged access in Google Cloud | Google Cloud | página atual | https://docs.cloud.google.com/docs/security/privileged-access-management | 2026-11-09 |
| GOOG-BEYONDPROD | BeyondProd | Google Cloud | página atual | https://docs.cloud.google.com/docs/security/beyondprod | 2026-11-09 |
| GOOG-BAB | Binary Authorization for Borg | Google Cloud | página atual | https://docs.cloud.google.com/docs/security/binary-authorization-for-borg | 2026-11-09 |
| GOOG-CRIPTO | Default encryption at rest | Google Cloud | página atual | https://docs.cloud.google.com/docs/security/encryption/default-encryption | 2026-11-09 |
| GOOG-KMS | Recommended practices for using CMEKs | Google Cloud | página atual | https://docs.cloud.google.com/kms/docs/cmek-recommended-practices | 2026-11-09 |
| GOOG-AUDIT | Cloud Audit Logs overview | Google Cloud | página atual | https://docs.cloud.google.com/logging/docs/audit | 2026-11-09 |
| GOOG-MFA | 2-step verification requirement for Google Cloud | Google Cloud | página atual | https://docs.cloud.google.com/docs/authentication/mfa-requirement | 2026-11-09 |
| GOOG-DPA | Cloud Data Processing Addendum | Google Cloud | versão vigente | https://cloud.google.com/terms/data-processing-addendum | 2026-11-09 |
| GOOG-SUB | Google Cloud Platform Subprocessors | Google Cloud | página atual | https://cloud.google.com/terms/subprocessors | 2026-11-09 |
| GOOG-SRE | Site Reliability Engineering, cap. 26: Data Integrity: What You Read Is What You Wrote | Google | livro de 2016 | https://sre.google/sre-book/data-integrity/ | 2026-11-09 |
| GOOG-VRP | VRP 2025 Year in Review | Google | 31/03/2026 | https://blog.google/security/vrp-2025-year-in-review/ | 2026-11-09 |
| GOOG-INCIDENTES | Data incident response process | Google Cloud | página atual | https://docs.cloud.google.com/docs/security/incident-response | 2026-11-09 |
| GOOG-SA | Best practices for using service accounts securely | Google Cloud | página atual | https://docs.cloud.google.com/iam/docs/best-practices-service-accounts | 2026-11-09 |
| GOOG-SA-CHAVES | Best practices for managing service account keys | Google Cloud | página atual | https://docs.cloud.google.com/iam/docs/best-practices-for-managing-service-account-keys | 2026-11-09 |
| GOOG-SUPERADMIN | Super administrator account best practices | Google Cloud | página atual | https://docs.cloud.google.com/resource-manager/docs/super-admin-best-practices | 2026-11-09 |
| GOOG-CONTATOS | Essential Contacts overview | Google Cloud | página atual | https://docs.cloud.google.com/resource-manager/docs/managing-notification-contacts | 2026-11-09 |
| GOOG-ATIVOS | Cloud Asset Inventory overview | Google Cloud | página atual | https://docs.cloud.google.com/asset-inventory/docs/overview | 2026-11-09 |
| GOOG-IAP | Use IAP for TCP forwarding | Google Cloud | página atual | https://docs.cloud.google.com/iap/docs/using-tcp-forwarding | 2026-11-09 |
| GOOG-ARMOR | Cloud Armor overview | Google Cloud | página atual | https://docs.cloud.google.com/armor/docs/cloud-armor-overview | 2026-11-09 |
| GOOG-ARMOR-TAXA | Cloud Armor: Rate limiting overview | Google Cloud | página atual | https://docs.cloud.google.com/armor/docs/rate-limiting-overview | 2026-11-09 |
| GOOG-DR | Disaster recovery planning guide | Google Cloud | página atual | https://docs.cloud.google.com/architecture/dr-scenarios-planning-guide | 2026-11-09 |
| GOOG-APIGEE-DR | Apigee: Business continuity planning and disaster recovery | Google Cloud | página atual | https://docs.cloud.google.com/apigee/docs/api-platform/reference/business-continuity | 2026-11-09 |
| GOOG-RETENCAO | How Google retains data we collect | Google | página atual | https://policies.google.com/technologies/retention?hl=en | 2026-11-09 |
| GOOG-SRE-MONITORAMENTO | Site Reliability Engineering, cap. 6: Monitoring Distributed Systems | Google | livro de 2016 | https://sre.google/sre-book/monitoring-distributed-systems/ | 2026-11-09 |
| GOOG-SRE-INCIDENTES | Site Reliability Engineering, cap. 14: Managing Incidents | Google | livro de 2016 | https://sre.google/sre-book/managing-incidents/ | 2026-11-09 |
| GOOG-SRE-POSTMORTEM | Site Reliability Engineering, cap. 15: Postmortem Culture: Learning from Failure | Google | livro de 2016 | https://sre.google/sre-book/postmortem-culture/ | 2026-11-09 |
| GOOG-P0 | Project Zero, Vulnerability Disclosure Policy | Google | página atual | https://projectzero.google/vulnerability-disclosure-policy.html | 2026-11-09 |
| GOOG-OSSFUZZ-IA | OSS-Fuzz, AI patches (beta) | Google | página atual | https://google.github.io/oss-fuzz/ai-patches-beta/ | 2026-11-09 |
| MS-MFA | Plan for mandatory Microsoft Entra multifactor authentication (MFA) | Microsoft Learn | página atual | https://learn.microsoft.com/en-us/entra/identity/authentication/concept-mandatory-multifactor-authentication | 2026-11-09 |
| MS-SFI | What's new in Microsoft Secure Future Initiative (SFI) | Microsoft Learn | página atual | https://learn.microsoft.com/en-us/security/zero-trust/sfi/secure-future-initiative-whats-new | 2026-11-09 |
| MS-ACESSO | Microsoft 365 service engineer access control | Microsoft Learn | página atual | https://learn.microsoft.com/en-us/compliance/assurance/assurance-microsoft-365-service-engineer-access-control | 2026-11-09 |
| MS-LOCKBOX | Customer Lockbox requests | Microsoft Learn | página atual | https://learn.microsoft.com/en-us/purview/customer-lockbox-requests | 2026-11-09 |
| MS-PESSOAL | Personnel management overview | Microsoft Learn | página atual | https://learn.microsoft.com/en-us/compliance/assurance/assurance-human-resources | 2026-11-09 |
| MS-ANTECEDENTES | Microsoft cloud background check | Microsoft Learn | página atual | https://learn.microsoft.com/en-us/compliance/assurance/assurance-cloud-background-check | 2026-11-09 |
| MS-SDL | Security development and operations overview | Microsoft Learn | página atual | https://learn.microsoft.com/en-us/compliance/assurance/assurance-security-development-and-operation | 2026-11-09 |
| MS-CRIPTO | Azure data encryption at rest | Microsoft Learn | página atual | https://learn.microsoft.com/en-us/azure/security/fundamentals/encryption-atrest | 2026-11-09 |
| MS-AUDIT | Learn about auditing solutions in Microsoft Purview | Microsoft Learn | página atual | https://learn.microsoft.com/en-us/purview/audit-solutions-overview | 2026-11-09 |
| MS-INCIDENTES | Security incident management overview | Microsoft Learn | página atual | https://learn.microsoft.com/en-us/compliance/assurance/assurance-incident-management | 2026-11-09 |
| MS-FORNECEDORES | Supplier management overview | Microsoft Learn | página atual | https://learn.microsoft.com/en-us/compliance/assurance/assurance-supplier-management | 2026-11-09 |
| MS-DPA | Microsoft Products and Services Data Protection Addendum (DPA) | Microsoft | versão vigente | https://www.microsoft.com/licensing/docs/view/Microsoft-Products-and-Services-Data-Protection-Addendum-DPA | 2026-11-09 (recusa robôs) |
| MS-SSPA | Supplier Security and Privacy Assurance (SSPA) Program Guide | Microsoft | v12, mar/2026 | https://cdn-dynmedia-1.microsoft.com/is/content/microsoftcorp/microsoft/accex/documents/presentations/FY26-SSPA-Program-Guide-v12_en-US.pdf | 2026-11-09 |
| MS-DPR | Microsoft Supplier Data Protection Requirements (DPR) | Microsoft | v12, mar/2026 | https://cdn-dynmedia-1.microsoft.com/is/content/microsoftcorp/microsoft/accex/documents/presentations/FY26-Microsoft-Supplier-Data-Protection-Requirements-v12_en-US.pdf | 2026-11-09 |
| MS-SFI-RELATORIO | Secure Future Initiative, relatório de progresso de julho de 2026 | Microsoft | jul/2026 | https://cdn-dynmedia-1.microsoft.com/is/content/microsoftcorp/microsoft/bade/documents/products-and-services/en-us/security/July-2026-SFI-Progress-Report.pdf | 2026-11-09 |
| MS-MFA-ADMIN | Require phishing-resistant multifactor authentication for Microsoft Entra administrator roles | Microsoft Learn | página atual | https://learn.microsoft.com/en-us/entra/identity/conditional-access/policy-admin-phish-resistant-mfa | 2026-11-09 |
| MS-EMERGENCIA | Manage emergency access admin accounts | Microsoft Learn | página atual | https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/security-emergency-access | 2026-11-09 |
| MS-PIM | Configure Microsoft Entra role settings in PIM | Microsoft Learn | página atual | https://learn.microsoft.com/en-us/entra/id-governance/privileged-identity-management/pim-how-to-change-default-settings | 2026-11-09 |
| MS-MONITORAMENTO | Audit logging and monitoring overview | Microsoft Learn | página atual | https://learn.microsoft.com/en-us/compliance/assurance/assurance-security-monitoring | 2026-11-09 |
| MS-VULN | Threat and vulnerability management | Microsoft Learn | página atual | https://learn.microsoft.com/en-us/compliance/assurance/assurance-vulnerability-management | 2026-11-09 |
| MS-CONTINUIDADE | Resiliency and continuity | Microsoft Learn | página atual | https://learn.microsoft.com/en-us/compliance/assurance/assurance-resiliency-and-continuity | 2026-11-09 |
| MS-DDOS | Azure DDoS Protection overview | Microsoft Learn | página atual | https://learn.microsoft.com/en-us/azure/ddos-protection/ddos-protection-overview | 2026-11-09 |
| MS-AZURE-STATUS | Azure status history | Microsoft Azure | página atual | https://azure.status.microsoft/en-us/status/history/ | 2026-11-09 |
| MS-MCSB-AM | Microsoft cloud security benchmark: Asset Management | Microsoft Learn | página atual | https://learn.microsoft.com/en-us/security/benchmark/azure/mcsb-asset-management | 2026-11-09 |
| MS-MCSB-LT | Microsoft cloud security benchmark: Logging and threat detection | Microsoft Learn | página atual | https://learn.microsoft.com/en-us/security/benchmark/azure/mcsb-logging-threat-detection | 2026-11-09 |
| MS-MCSB-NS | Microsoft cloud security benchmark: Network Security | Microsoft Learn | página atual | https://learn.microsoft.com/en-us/security/benchmark/azure/mcsb-network-security | 2026-11-09 |
| MS-MCSB-PV | Microsoft cloud security benchmark: Posture and Vulnerability Management | Microsoft Learn | página atual | https://learn.microsoft.com/en-us/security/benchmark/azure/mcsb-posture-vulnerability-management | 2026-11-09 |
| AWS-DPA | AWS Data Processing Addendum | AWS | versão vigente | https://d1.awsstatic.com/legal/aws-dpa/aws-dpa.pdf | 2026-11-09 |
| AWS-MFA-ROOT | AWS IAM now enforces MFA for root users across all account types | AWS | 17/06/2025 | https://aws.amazon.com/about-aws/whats-new/2025/06/aws-iam-mfa-root-users-across-all-account-types | 2026-11-09 |
| AWS-NITRO | The Security Design of the AWS Nitro System: No AWS operator access (whitepaper) | AWS | página atual | https://docs.aws.amazon.com/whitepapers/latest/security-design-of-aws-nitro-system/no-aws-operator-access.html | 2026-11-09 |
| AWS-S3-CRIPTO | Amazon S3 Encrypts New Objects By Default | AWS | 05/01/2023 | https://aws.amazon.com/blogs/aws/amazon-s3-encrypts-new-objects-by-default/ | 2026-11-09 |
| AWS-KMS | Data protection in AWS Key Management Service | AWS | página atual | https://docs.aws.amazon.com/kms/latest/developerguide/data-protection.html | 2026-11-09 |
| AWS-KMS-ROTACAO | Rotate AWS KMS keys | AWS | página atual | https://docs.aws.amazon.com/kms/latest/developerguide/rotate-keys.html | 2026-11-09 |
| AWS-CLOUDTRAIL | Working with CloudTrail event history | AWS | página atual | https://docs.aws.amazon.com/awscloudtrail/latest/userguide/view-cloudtrail-events.html | 2026-11-09 |
| AWS-WA-APPSEC | AWS Well-Architected Framework, Security Pillar: Application security | AWS | página atual | https://docs.aws.amazon.com/wellarchitected/latest/security-pillar/application-security.html | 2026-11-09 |
| AWS-GUARDIANS | How AWS built the Security Guardians program, a mechanism to distribute security ownership | AWS | 18/08/2023 | https://aws.amazon.com/blogs/security/how-aws-built-the-security-guardians-program-a-mechanism-to-distribute-security-ownership | 2026-11-09 |
| AWS-CULTURA | How the unique culture of security at AWS makes a difference | AWS | 17/04/2024 | https://aws.amazon.com/blogs/security/how-the-unique-culture-of-security-at-aws-makes-a-difference | 2026-11-09 |
| AWS-SUB | Amazon Web Services (AWS) Sub-processors | AWS | página atual | https://aws.amazon.com/compliance/sub-processors/ | 2026-11-09 |
| AWS-VULN | Vulnerability Reporting | AWS | página atual | https://aws.amazon.com/security/vulnerability-reporting/ | 2026-11-09 |
| AWS-RAIZ | Root user best practices for your AWS account | AWS | página atual | https://docs.aws.amazon.com/IAM/latest/UserGuide/root-user-best-practices.html | 2026-11-09 |
| AWS-SH-IAM | Security Hub CSPM controls for AWS Identity and Access Management | AWS | página atual | https://docs.aws.amazon.com/securityhub/latest/userguide/iam-controls.html | 2026-11-09 |
| AWS-SH-FSBP | AWS Foundational Security Best Practices standard in Security Hub CSPM | AWS | página atual | https://docs.aws.amazon.com/securityhub/latest/userguide/fsbp-standard.html | 2026-11-09 |
| AWS-CLOUDTRAIL-INTEGRIDADE | Validating CloudTrail log file integrity | AWS | página atual | https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-log-file-validation-intro.html | 2026-11-09 |
| AWS-HEALTH | AWS Health Dashboard | AWS | página atual | https://docs.aws.amazon.com/health/latest/ug/aws-health-dashboard-status.html | 2026-11-09 |
| AWS-SHIELD | AWS Shield Standard overview | AWS | página atual | https://docs.aws.amazon.com/waf/latest/developerguide/ddos-standard-summary.html | 2026-11-09 |
| AWS-DDOS | AWS Best Practices for DDoS Resiliency (whitepaper) | AWS | ago/2026 | https://docs.aws.amazon.com/whitepapers/latest/aws-best-practices-ddos-resiliency/aws-best-practices-ddos-resiliency.html | 2026-11-09 |
| AWS-WA-SEC01-BP01 | AWS Well-Architected Framework, Security Pillar: SEC01-BP01 Separate workloads using accounts | AWS | página atual | https://docs.aws.amazon.com/wellarchitected/latest/security-pillar/sec_securely_operate_multi_accounts.html | 2026-11-09 |
| AWS-WA-SEC02-BP02 | AWS Well-Architected Framework, Security Pillar: SEC02-BP02 Use temporary credentials | AWS | página atual | https://docs.aws.amazon.com/wellarchitected/latest/security-pillar/sec_identities_unique.html | 2026-11-09 |
| AWS-WA-SEC02-BP03 | AWS Well-Architected Framework, Security Pillar: SEC02-BP03 Store and use secrets securely | AWS | página atual | https://docs.aws.amazon.com/wellarchitected/latest/security-pillar/sec_identities_secrets.html | 2026-11-09 |
| AWS-WA-SEC02-BP04 | AWS Well-Architected Framework, Security Pillar: SEC02-BP04 Rely on a centralized identity provider | AWS | página atual | https://docs.aws.amazon.com/wellarchitected/latest/security-pillar/sec_identities_identity_provider.html | 2026-11-09 |
| AWS-WA-SEC03-BP03 | AWS Well-Architected Framework, Security Pillar: SEC03-BP03 Establish emergency access process | AWS | página atual | https://docs.aws.amazon.com/wellarchitected/latest/security-pillar/sec_permissions_emergency_process.html | 2026-11-09 |
| AWS-WA-SEC05-BP01 | AWS Well-Architected Framework, Security Pillar: SEC05-BP01 Create network layers | AWS | página atual | https://docs.aws.amazon.com/wellarchitected/latest/security-pillar/sec_network_protection_create_layers.html | 2026-11-09 |
| AWS-WA-SEC05-BP02 | AWS Well-Architected Framework, Security Pillar: SEC05-BP02 Control traffic flow within your network layers | AWS | página atual | https://docs.aws.amazon.com/wellarchitected/latest/security-pillar/sec_network_protection_layered.html | 2026-11-09 |
| AWS-WA-SEC06-BP01 | AWS Well-Architected Framework, Security Pillar: SEC06-BP01 Perform vulnerability management | AWS | página atual | https://docs.aws.amazon.com/wellarchitected/latest/security-pillar/sec_protect_compute_vulnerability_management.html | 2026-11-09 |
| AWS-WA-SEC06-BP02 | AWS Well-Architected Framework, Security Pillar: SEC06-BP02 Provision compute from hardened images | AWS | página atual | https://docs.aws.amazon.com/wellarchitected/latest/security-pillar/sec_protect_compute_hardened_images.html | 2026-11-09 |
| AWS-WA-SEC06-BP03 | AWS Well-Architected Framework, Security Pillar: SEC06-BP03 Reduce manual management and interactive access | AWS | página atual | https://docs.aws.amazon.com/wellarchitected/latest/security-pillar/sec_protect_compute_reduce_manual_management.html | 2026-11-09 |
| AWS-WA-SEC10-BP01 | AWS Well-Architected Framework, Security Pillar: SEC10-BP01 Identify key personnel and external resources | AWS | página atual | https://docs.aws.amazon.com/wellarchitected/latest/security-pillar/sec_incident_response_identify_personnel.html | 2026-11-09 |
| AWS-WA-SEC10-BP02 | AWS Well-Architected Framework, Security Pillar: SEC10-BP02 Develop incident management plans | AWS | página atual | https://docs.aws.amazon.com/wellarchitected/latest/security-pillar/sec_incident_response_develop_management_plans.html | 2026-11-09 |
| AWS-WA-SEC10-BP03 | AWS Well-Architected Framework, Security Pillar: SEC10-BP03 Prepare forensic capabilities | AWS | página atual | https://docs.aws.amazon.com/wellarchitected/latest/security-pillar/sec_incident_response_prepare_forensic.html | 2026-11-09 |
| AWS-WA-SEC10-BP04 | AWS Well-Architected Framework, Security Pillar: SEC10-BP04 Develop and test security incident response playbooks | AWS | página atual | https://docs.aws.amazon.com/wellarchitected/latest/security-pillar/sec_incident_response_playbooks.html | 2026-11-09 |
| AWS-WA-SEC10-BP07 | AWS Well-Architected Framework, Security Pillar: SEC10-BP07 Run simulations | AWS | página atual | https://docs.aws.amazon.com/wellarchitected/latest/security-pillar/sec_incident_response_run_game_days.html | 2026-11-09 |
| AWS-WA-SEC10-BP08 | AWS Well-Architected Framework, Security Pillar: SEC10-BP08 Establish a framework for learning from incidents | AWS | página atual | https://docs.aws.amazon.com/wellarchitected/latest/security-pillar/sec_incident_response_establish_incident_framework.html | 2026-11-09 |
| AWS-WA-REL09-BP04 | AWS Well-Architected Framework, Reliability Pillar: REL09-BP04 Perform periodic recovery of the data to verify backup integrity and processes | AWS | página atual | https://docs.aws.amazon.com/wellarchitected/latest/reliability-pillar/rel_backing_up_data_periodic_recovery_testing_data.html | 2026-11-09 |
| AWS-WA-REL13-BP01 | AWS Well-Architected Framework, Reliability Pillar: REL13-BP01 Define recovery objectives for downtime and data loss | AWS | página atual | https://docs.aws.amazon.com/wellarchitected/latest/reliability-pillar/rel_planning_for_recovery_objective_defined_recovery.html | 2026-11-09 |
| AWS-WA-REL13-BP02 | AWS Well-Architected Framework, Reliability Pillar: REL13-BP02 Use defined recovery strategies to meet the recovery objectives | AWS | página atual | https://docs.aws.amazon.com/wellarchitected/latest/reliability-pillar/rel_planning_for_recovery_disaster_recovery.html | 2026-11-09 |
| AWS-WA-REL13-BP03 | AWS Well-Architected Framework, Reliability Pillar: REL13-BP03 Test disaster recovery implementation to validate the implementation | AWS | página atual | https://docs.aws.amazon.com/wellarchitected/latest/reliability-pillar/rel_planning_for_recovery_dr_tested.html | 2026-11-09 |
| APPLE-ADP | Apple Platform Security: Advanced Data Protection for iCloud | Apple | página atual | https://support.apple.com/guide/security/advanced-data-protection-for-icloud-sec973254c5f/web | 2026-11-09 |
| APPLE-CERT | Apple internet services security certifications | Apple | página atual | https://support.apple.com/guide/certifications/apc34d2c0468b/web | 2026-11-09 |
| APPLE-BOUNTY | A major evolution of Apple Security Bounty | Apple | 10/10/2025 | https://security.apple.com/blog/apple-security-bounty-evolved/ | 2026-11-09 |
| META-ZONCOLAN | Zoncolan: Using static analysis to prevent security issues | Meta | 15/08/2019 | https://engineering.fb.com/2019/08/15/security/zoncolan/ | 2026-11-09 |
| META-PYSA | Pysa: Open Source static analysis for Python code | Meta | 07/08/2020 | https://engineering.fb.com/2020/08/07/security/pysa/ | 2026-11-09 |
| META-BOUNTY | Celebrating 15 years of Meta's Bug Bounty Program | Meta | 26/11/2025 | https://bugbounty.meta.com/blog/15th-anniversary-2025/ | 2026-11-09 |

## Frameworks e programas públicos

| Sigla | Documento | Emissor | Versão ou data | URL | Conferida em |
|---|---|---|---|---|---|
| NIST-CSF | The NIST Cybersecurity Framework (CSF) 2.0 (NIST CSWP 29) | NIST | 2.0, 26/02/2024 | https://nvlpubs.nist.gov/nistpubs/CSWP/NIST.CSWP.29.pdf | 2026-11-09 |
| NIST-SSDF | SP 800-218, Secure Software Development Framework (SSDF) | NIST | v1.1, fev/2022 (a v1.2 está em rascunho) | https://csrc.nist.gov/pubs/sp/800/218/final | 2026-11-09 |
| NIST-800-63B | SP 800-63B-4, Digital Identity Guidelines: Authentication and Authenticator Management | NIST | revisão 4, final de jul/2025 | https://pages.nist.gov/800-63-4/sp800-63b.html | 2026-11-09 |
| NIST-800-207 | SP 800-207, Zero Trust Architecture | NIST | final, ago/2020 | https://nvlpubs.nist.gov/nistpubs/specialpublications/NIST.SP.800-207.pdf | 2026-11-09 |
| SLSA | SLSA, Build Track Basics (níveis do build) | OpenSSF | 1.2 | https://slsa.dev/spec/v1.2/build-track-basics | 2026-11-09 |
| SLSA-FONTE | SLSA, Source Track: Requirements for producing source | OpenSSF | 1.2 | https://slsa.dev/spec/v1.2/source-requirements | 2026-11-09 |
| OPENSSF-IA | Security-Focused Guide for AI Code Assistant Instructions | OpenSSF (Best Practices Working Group) | página atual | https://best.openssf.org/Security-Focused-Guide-for-AI-Code-Assistant-Instructions | 2026-11-09 |
| OWASP-TOP10 | OWASP Top 10:2025 | OWASP | 2025 | https://owasp.org/Top10/2025/ | 2026-11-09 |
| OWASP-TOP10-A02 | OWASP Top 10:2025, A02 Security Misconfiguration | OWASP | 2025 | https://owasp.org/Top10/2025/A02_2025-Security_Misconfiguration/ | 2026-11-09 |
| OWASP-TOP10-A09 | OWASP Top 10:2025, A09 Security Logging and Alerting Failures | OWASP | 2025 | https://owasp.org/Top10/2025/A09_2025-Security_Logging_and_Alerting_Failures/ | 2026-11-09 |
| OWASP-ASVS | OWASP Application Security Verification Standard (página do projeto) | OWASP | 5.0.0, 30/05/2025 | https://owasp.org/www-project-application-security-verification-standard/ | 2026-11-09 |
| ASVS-NIVEIS | ASVS 5.0.0, What is the ASVS (níveis L1, L2 e L3) | OWASP | 5.0.0 | https://github.com/OWASP/ASVS/blob/v5.0.0/5.0/en/0x03-What-is-the-ASVS.md | 2026-11-09 |
| ASVS-V1 | ASVS 5.0.0, V1 Encoding and Sanitization | OWASP | 5.0.0 | https://github.com/OWASP/ASVS/blob/v5.0.0/5.0/en/0x10-V1-Encoding-and-Sanitization.md | 2026-11-09 |
| ASVS-V2 | ASVS 5.0.0, V2 Validation and Business Logic | OWASP | 5.0.0 | https://github.com/OWASP/ASVS/blob/v5.0.0/5.0/en/0x11-V2-Validation-and-Business-Logic.md | 2026-11-09 |
| ASVS-V3 | ASVS 5.0.0, V3 Web Frontend Security | OWASP | 5.0.0 | https://github.com/OWASP/ASVS/blob/v5.0.0/5.0/en/0x12-V3-Web-Frontend-Security.md | 2026-11-09 |
| ASVS-V6 | ASVS 5.0.0, V6 Authentication | OWASP | 5.0.0 | https://github.com/OWASP/ASVS/blob/v5.0.0/5.0/en/0x15-V6-Authentication.md | 2026-11-09 |
| ASVS-V8 | ASVS 5.0.0, V8 Authorization | OWASP | 5.0.0 | https://github.com/OWASP/ASVS/blob/v5.0.0/5.0/en/0x17-V8-Authorization.md | 2026-11-09 |
| ASVS-V11 | ASVS 5.0.0, V11 Cryptography | OWASP | 5.0.0 | https://github.com/OWASP/ASVS/blob/v5.0.0/5.0/en/0x20-V11-Cryptography.md | 2026-11-09 |
| ASVS-V12 | ASVS 5.0.0, V12 Secure Communication | OWASP | 5.0.0 | https://github.com/OWASP/ASVS/blob/v5.0.0/5.0/en/0x21-V12-Secure-Communication.md | 2026-11-09 |
| ASVS-V13 | ASVS 5.0.0, V13 Configuration | OWASP | 5.0.0 | https://github.com/OWASP/ASVS/blob/v5.0.0/5.0/en/0x22-V13-Configuration.md | 2026-11-09 |
| ASVS-V14 | ASVS 5.0.0, V14 Data Protection | OWASP | 5.0.0 | https://github.com/OWASP/ASVS/blob/v5.0.0/5.0/en/0x23-V14-Data-Protection.md | 2026-11-09 |
| ASVS-V15 | ASVS 5.0.0, V15 Secure Coding and Architecture | OWASP | 5.0.0 | https://github.com/OWASP/ASVS/blob/v5.0.0/5.0/en/0x24-V15-Secure-Coding-and-Architecture.md | 2026-11-09 |
| ASVS-V16 | ASVS 5.0.0, V16 Security Logging and Error Handling | OWASP | 5.0.0 | https://github.com/OWASP/ASVS/blob/v5.0.0/5.0/en/0x25-V16-Security-Logging-and-Error-Handling.md | 2026-11-09 |
| OWASP-SAMM | OWASP SAMM, The Model | OWASP | v2 | https://owaspsamm.org/model/ | 2026-11-09 |
| OWASP-API | OWASP API Security Top 10, API1:2023 Broken Object Level Authorization | OWASP | 2023 | https://api-security.owasp.org/editions/2023/en/0xa1-broken-object-level-authorization/ | 2026-11-09 |
| OWASP-API4 | OWASP API Security Top 10, API4:2023 Unrestricted Resource Consumption | OWASP | 2023 | https://api-security.owasp.org/editions/2023/en/0xa4-unrestricted-resource-consumption/ | 2026-11-09 |
| OWASP-SENHAS | OWASP Cheat Sheet Series, Password Storage | OWASP | página atual | https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html | 2026-11-09 |
| ISO-27001 | ISO/IEC 27001:2022 (página da norma; texto pago) | ISO/IEC | edição 3, out/2022 | https://www.iso.org/standard/27001 | 2026-11-09 (recusa robôs) |
| ISO-27001-AMD1 | ISO/IEC 27001:2022/Amd 1:2024, Climate action changes (página da emenda) | ISO/IEC | fev/2024 | https://www.iso.org/standard/88435.html | 2026-11-09 (recusa robôs) |
| AICPA-TSC | 2017 Trust Services Criteria (With Revised Points of Focus – 2022) | AICPA & CIMA | TSC 2017, pontos de foco de 2022 | https://www.aicpa-cima.com/resources/download/2017-trust-services-criteria-with-revised-points-of-focus-2022 | 2026-11-09 |
| CIS-V81 | CIS Critical Security Controls Version 8.1 | CIS | v8.1 | https://www.cisecurity.org/controls/v8-1 | 2026-11-09 |
| CIS-IG1 | CIS Critical Security Controls, Implementation Group 1 | CIS | v8.1 | https://www.cisecurity.org/controls/implementation-groups/ig1 | 2026-11-09 |
| CIS-CCM | Cloud Security Alliance (CSA) Cloud Controls Matrix (CCM) v4.1: mapeamento oficial do CIS v8.1 para o CCM v4.1, com a planilha | CIS | página publicada em 06/11/2026; planilha atualizada em ago/2026 | https://www.cisecurity.org/insights/white-papers/cloud-security-alliance-cloud-controls-matrix-ccm-v4-1-cis-controls | 2026-11-09 |
| CIS-BENCHMARKS | CIS Benchmarks (guias de configuração segura) | CIS | página atual | https://www.cisecurity.org/cis-benchmarks | 2026-11-09 (recusa robôs) |
| CSA-CCM | Cloud Controls Matrix (CCM), com o CAIQ | CSA | v4.1 | https://cloudsecurityalliance.org/ccm/ | 2026-11-09 |
| SIG | SIG EV, domínios de controle do SIG | Shared Assessments | SIG 2026 (só domínios) | https://sharedassessments.org/sig-ev/ | 2026-11-09 (recusa robôs) |
| SIG-FAQ | SIG FAQ (SIG Lite e SIG Core) | Shared Assessments | página atual | https://sharedassessments.org/sig-faq/ | 2026-11-09 (recusa robôs) |
| PCI-DSS | Just Published: PCI DSS v4.0.1 | PCI SSC | v4.0.1, 11/06/2024 | https://blog.pcisecuritystandards.org/just-published-pci-dss-v4-0-1 | 2026-11-09 |
| PCI-DSS-PT | PCI DSS v4.0, tradução oficial em português | PCI SSC | v4.0, mar/2022 (a v4.0.1 manteve a numeração) | https://listings.pcisecuritystandards.org/documents/PCI-DSS-v4_0-PT.pdf | 2026-11-09 |
| PCI-FAQ-1588 | FAQ 1588, critério de elegibilidade do SAQ A sobre scripts na página de pagamento | PCI SSC | página atual | https://pcisecuritystandards.org/faqs/1588 | 2026-11-09 |
| PCI-FAQ-1293 | FAQ 1293, origem dos elementos da página de pagamento no SAQ A e no SAQ A-EP | PCI SSC | página atual | https://www.pcisecuritystandards.org/faqs/1293/ | 2026-11-09 |
| OPENCHAIN | OpenChain ISO/IEC 5230, License Compliance | OpenChain Project | ISO/IEC 5230:2020 | https://openchainproject.org/license-compliance | 2026-11-09 |
| CISA-PLEDGE | Secure by Design Pledge | CISA | página atual (sete metas) | https://www.cisa.gov/securebydesign/pledge | 2026-11-09 (recusa robôs) |
| CISA-KEV | Known Exploited Vulnerabilities Catalog | CISA | página atual | https://www.cisa.gov/known-exploited-vulnerabilities-catalog | 2026-11-09 (recusa robôs) |
| CISA-BOD-26-04 | BOD 26-04: Prioritizing Security Updates Based on Risk | CISA | 10/06/2026 | https://www.cisa.gov/news-events/directives/bod-26-04-prioritizing-security-updates-based-risk | 2026-11-09 (recusa robôs) |
| CISA-DDOS | Understanding and Responding to Distributed Denial-of-Service Attacks | CISA, FBI e MS-ISAC | 21/03/2024 | https://www.cisa.gov/sites/default/files/publications/understanding-and-responding-to-ddos-attacks_508c.pdf | 2026-11-09 (recusa robôs) |
| FIRST-CVSS | CVSS v4.0 Specification Document | FIRST | v4.0, publicada em 01/11/2023 | https://www.first.org/cvss/v4.0/specification-document | 2026-11-09 |
| FIRST-CVSS-31 | CVSS v3.1 Specification Document, seção 5 (escala qualitativa) | FIRST | v3.1 | https://www.first.org/cvss/v3.1/specification-document | 2026-11-10 |
| RFC-9116 | RFC 9116, A File Format to Aid in Security Vulnerability Disclosure (security.txt) | IETF | abr/2022 | https://www.rfc-editor.org/rfc/rfc9116.html | 2026-11-09 |

## Normas e decisões brasileiras

| Sigla | Documento | Emissor | Versão ou data | URL | Conferida em |
|---|---|---|---|---|---|
| CMN-4893 | Resolução CMN nº 4.893, política de segurança cibernética e contratação de processamento, armazenamento de dados e nuvem (texto consolidado) | CMN (portal do BCB) | 26/02/2021 | https://www.bcb.gov.br/estabilidadefinanceira/exibenormativo?tipo=Resolu%C3%A7%C3%A3o%20CMN&numero=4893 | 2026-11-09 |
| CMN-5274 | Resolução CMN nº 5.274, que altera a Resolução CMN nº 4.893 | CMN (portal do BCB) | 18/12/2025 | https://www.bcb.gov.br/estabilidadefinanceira/exibenormativo?tipo=Resolu%C3%A7%C3%A3o%20CMN&numero=5274 | 2026-11-09 |
| BCB-85 | Resolução BCB nº 85, mesma matéria para as instituições autorizadas pelo BCB (texto consolidado) | BCB | 08/04/2021 | https://www.bcb.gov.br/estabilidadefinanceira/exibenormativo?tipo=Resolu%C3%A7%C3%A3o%20BCB&numero=85 | 2026-11-09 |
| BCB-538 | Resolução BCB nº 538, que altera a Resolução BCB nº 85 | BCB | 18/12/2025 | https://www.bcb.gov.br/estabilidadefinanceira/exibenormativo?tipo=Resolu%C3%A7%C3%A3o%20BCB&numero=538 | 2026-11-09 |
| SUSEP-638 | Circular SUSEP nº 638, requisitos de segurança cibernética (texto original) | SUSEP | 27/07/2021; alterada pela Res. Susep 90/2026 | https://www2.susep.gov.br/safe/scripts/bnweb/bnmapi.exe?router=upload%2F25121 | 2026-11-09 |
| SUSEP-RES90 | Resolução Susep nº 90, que altera a Circular SUSEP nº 638 (art. 10, III, e parágrafo único) | SUSEP (Diário Oficial da União) | 18/08/2026, publicada em 20/08/2026 | https://www.in.gov.br/en/web/dou/-/resolucao-susep-n-90-de-18-de-agosto-de-2026-726687726 | 2026-11-09 (recusa robôs) |
| GSI-IN5 | Instrução Normativa GSI/PR nº 5, requisitos mínimos de segurança da informação para uso de nuvem na administração pública federal | GSI/PR (Diário Oficial da União) | 30/08/2021 | https://www.in.gov.br/en/web/dou/-/instrucao-normativa-n-5-de-30-de-agosto-de-2021-341649684 | 2026-11-09 (recusa robôs) |
| LGPD | Lei nº 13.709 (LGPD), art. 5º, II, art. 11, art. 18, VI, e arts. 46 a 49 (texto compilado) | Presidência da República (Planalto) | 14/08/2018, texto compilado | https://www.planalto.gov.br/ccivil_03/_ato2015-2018/2018/lei/l13709compilado.htm (texto); ficha no Senado: https://legis.senado.leg.br/norma/27457334 | 2026-11-09 (texto recusa robôs) |
| ANPD-RES15 | Resolução CD/ANPD nº 15, regulamento de comunicação de incidente de segurança, arts. 5º e 10 | ANPD (Diário Oficial da União) | 24/04/2024 | https://www.in.gov.br/en/web/dou/-/resolucao-cd/anpd-n-15-de-24-de-abril-de-2024-556243024 | 2026-11-09 (recusa robôs) |
| ANPD-RES2 | Resolução CD/ANPD nº 2, regulamento de aplicação da LGPD para agentes de tratamento de pequeno porte, art. 14, II (na redação da Res. CD/ANPD nº 15/2024), e art. 16 | ANPD | 27/01/2022 | https://www.gov.br/anpd/pt-br/acesso-a-informacao/institucional/atos-normativos/regulamentacoes_anpd/resolucao-cd-anpd-no-2-de-27-de-janeiro-de-2022 | 2026-11-09 |
| ANPD-RES1 | Resolução CD/ANPD nº 1, regulamento do processo de fiscalização e do processo administrativo sancionador, art. 8º (contagem dos prazos) | ANPD | 28/10/2021 | https://www.gov.br/anpd/pt-br/acesso-a-informacao/institucional/atos-normativos/regulamentacoes_anpd/resolucao-cd-anpd-no1-2021 | 2026-11-09 |
| ANPD-CIS | Comunicação de Incidente de Segurança (canal oficial da ANPD para o controlador) | ANPD | página atual | https://www.gov.br/anpd/pt-br/canais_atendimento/agente-de-tratamento/comunicado-de-incidente-de-seguranca-cis | 2026-11-09 |
| ANPD-GUIA | Guia orientativo de segurança da informação para agentes de tratamento de pequeno porte | ANPD | v1.0, out/2021 (arquivo atualizado no portal em 23/01/2025) | https://www.gov.br/anpd/pt-br/documentos-e-publicacoes/guia-vf.pdf | 2026-11-09 |
| ANPD-CHECKLIST | Checklist de medidas de segurança que acompanha o guia para agentes de tratamento de pequeno porte | ANPD | out/2021 (arquivo atualizado no portal em 23/01/2025) | https://www.gov.br/anpd/pt-br/documentos-e-publicacoes/checklist-vf.pdf | 2026-11-09 |
| ANPD-GUIA-AGENTES | Guia orientativo para definições dos agentes de tratamento de dados pessoais e do encarregado | ANPD | v2.0 (página atualizada no portal em 23/01/2025) | https://www.gov.br/anpd/pt-br/centrais-de-conteudo/materiais-educativos-e-publicacoes/guia-orientativo-para-definicoes-dos-agentes-de-tratamento-de-dados-pessoais-e-do-encarregado | 2026-11-09 |
| MARCO-CIVIL | Lei nº 12.965 (Marco Civil da Internet), arts. 13 e 15 | Presidência da República (Planalto) | 23/04/2014 | https://www.planalto.gov.br/ccivil_03/_ato2011-2014/2014/lei/l12965.htm (texto); ficha no Senado: https://legis.senado.leg.br/norma/584776 | 2026-11-09 (texto recusa robôs) |
| DEC-8771 | Decreto nº 8.771, que regulamenta o Marco Civil da Internet, arts. 13 e 15-A | Presidência da República (Planalto) | 11/05/2016; alterado pelo Decreto 12.975/2026, que acrescentou o art. 15-A e manteve a redação do art. 13 | https://www.planalto.gov.br/ccivil_03/_ato2015-2018/2016/decreto/d8771.htm (texto); ficha no Senado: https://legis.senado.leg.br/norma/414662 | 2026-11-09 (texto recusa robôs) |
| CDC | Lei nº 8.078 (Código de Defesa do Consumidor), texto compilado | Presidência da República (Planalto) | 11/09/1990, texto compilado | https://www.planalto.gov.br/ccivil_03/leis/l8078compilado.htm (texto); ficha no Senado: https://legis.senado.leg.br/norma/549954 | 2026-11-09 (texto recusa robôs) |
| DEC-7962 | Decreto nº 7.962, que regulamenta o CDC na contratação no comércio eletrônico | Presidência da República (Planalto) | 15/03/2013 | https://www.planalto.gov.br/ccivil_03/_ato2011-2014/2013/decreto/d7962.htm (texto); ficha no Senado: https://legis.senado.leg.br/norma/413161 | 2026-11-09 (texto recusa robôs) |
| TST-TEMA-1 | Acórdão do Incidente de Recurso de Revista Repetitivo, Tema 1 (IRR-243000-58.2013.5.13.0023): exigência de certidão de antecedentes criminais de candidato a emprego | TST (SBDI-1) | 20/04/2017 | https://jurisprudencia-backend.tst.jus.br/rest/documentos/5d363bef6f69adf2686d26571472a5d9 | 2026-11-09 |

Nas linhas do Planalto, o texto recusa robôs e está em `scripts/fontes-ignorar.txt`; ao lado vai a ficha oficial da norma no Senado, que o `verificar-fontes.sh` confere. A ficha do Decreto 8.771/2016 lista as mudanças do Decreto 12.975/2026 (art. 1º alterado; arts. 15-A, 16-A a 16-P, 19-A e 20-A acrescentados), e o art. 13 não aparece entre os dispositivos alterados; no texto compilado do Planalto, o art. 13 segue na redação original. Nas linhas do Diário Oficial da União, o texto não responde ao `curl` do script e também está em `scripts/fontes-ignorar.txt`.

## Plataformas e ferramentas

| Sigla | Documento | Emissor | Versão ou data | URL | Conferida em |
|---|---|---|---|---|---|
| GITHUB-BRANCHES | About protected branches | GitHub Docs | página atual | https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches | 2026-11-09 |
| GITHUB-CODE-SCANNING | Code scanning | GitHub Docs | página atual | https://docs.github.com/en/code-security/concepts/code-scanning/code-scanning | 2026-11-09 |
| GITHUB-SECRET-SCANNING | Secret scanning | GitHub Docs | página atual | https://docs.github.com/en/code-security/concepts/secret-security/secret-scanning | 2026-11-09 |
| GITHUB-DEPENDABOT | Dependabot supported ecosystems and repositories | GitHub Docs | página atual | https://docs.github.com/en/code-security/reference/supply-chain-security/supported-ecosystems-and-repositories | 2026-11-09 |
| GITHUB-ACTIONS-SEGURO | Secure use reference (GitHub Actions) | GitHub Docs | página atual | https://docs.github.com/en/actions/reference/security/secure-use | 2026-11-09 |
| GITHUB-OIDC | OpenID Connect (GitHub Actions) | GitHub Docs | página atual | https://docs.github.com/en/actions/concepts/security/openid-connect | 2026-11-09 |
| GITHUB-ATESTADOS | Artifact attestations | GitHub Docs | página atual | https://docs.github.com/en/actions/concepts/security/artifact-attestations | 2026-11-09 |
| GITHUB-ATESTADOS-USO | Using artifact attestations to establish provenance for builds | GitHub Docs | página atual | https://docs.github.com/en/actions/how-tos/secure-your-work/use-artifact-attestations/use-artifact-attestations | 2026-11-09 |
| GITHUB-SECURITY-MD | Adding a security policy to your repository | GitHub Docs | página atual | https://docs.github.com/en/code-security/how-tos/report-and-fix-vulnerabilities/configure-vulnerability-reporting/add-security-policy | 2026-11-09 |
| GITHUB-PVR | Configuring private vulnerability reporting for a repository | GitHub Docs | página atual | https://docs.github.com/en/code-security/how-tos/report-and-fix-vulnerabilities/configure-vulnerability-reporting/configure-for-a-repository | 2026-11-09 |
| GITHUB-COPILOT | Application card: GitHub Copilot inline suggestions | GitHub Docs | página atual | https://docs.github.com/en/copilot/responsible-use/inline-suggestions | 2026-11-09 |
| RENOVATE-ACTIONS | Automated Dependency Updates for GitHub Actions | Renovate Docs | página atual | https://docs.renovatebot.com/modules/manager/github-actions/ | 2026-11-09 |
| GITLEAKS-ACTION | gitleaks-action (README) | Gitleaks | página atual | https://github.com/gitleaks/gitleaks-action | 2026-11-09 |
| HSTS-PRELOAD | HSTS Preload List Submission (lista de pré-carregamento do HSTS mantida pelo Chrome) | Google (Chrome) | página atual | https://hstspreload.org/ | 2026-11-09 |
| NTP-BR | NTP.br, hora legal brasileira pela internet | NIC.br | página atual | https://ntp.br/ | 2026-11-09 |
| GITLEAKS | gitleaks (README) | Gitleaks | página atual | https://github.com/gitleaks/gitleaks | 2026-11-10 |
| SEMGREP-INICIO | Semgrep: Quickstart | Semgrep | página atual | https://semgrep.dev/docs/getting-started/quickstart | 2026-11-10 |
| SEMGREP-CLI | Semgrep: CLI reference | Semgrep | página atual | https://semgrep.dev/docs/cli-reference | 2026-11-10 |
| TRIVY-INSTALACAO | Trivy: Installation | Trivy | página atual | https://trivy.dev/docs/latest/getting-started/installation/ | 2026-11-10 |
| TRIVY-FS | Trivy: Filesystem | Trivy | página atual | https://trivy.dev/docs/latest/guide/target/filesystem/ | 2026-11-10 |
| TRIVY-SEGREDO | Trivy: Secret | Trivy | página atual | https://trivy.dev/docs/latest/guide/scanner/secret/ | 2026-11-10 |
| TRIVY-LICENCA | Trivy: License | Trivy | página atual | https://trivy.dev/docs/latest/guide/scanner/license/ | 2026-11-10 |
| TRIVY-CONFIG | Trivy: Config file | Trivy | página atual | https://trivy.dev/docs/latest/references/configuration/config-file/ | 2026-11-10 |
| OSV-INSTALACAO | OSV-Scanner: Installation | Google (OSV-Scanner) | página atual | https://google.github.io/osv-scanner/installation/ | 2026-11-10 |
| OSV-FONTE | OSV-Scanner: Project Source Scanning | Google (OSV-Scanner) | página atual | https://google.github.io/osv-scanner/usage/scan-source | 2026-11-10 |
| OSV-SAIDA | OSV-Scanner: Output | Google (OSV-Scanner) | página atual | https://google.github.io/osv-scanner/output/ | 2026-11-10 |
| CHECKOV-INSTALACAO | Checkov: Installing Checkov | Checkov | página atual | https://www.checkov.io/2.Basics/Installing%20Checkov.html | 2026-11-10 |
| CHECKOV-CLI | Checkov: CLI Command Reference | Checkov | página atual | https://www.checkov.io/2.Basics/CLI%20Command%20Reference.html | 2026-11-10 |
| NPM-AUDIT | npm-audit (CLI v11) | npm Docs | página atual | https://docs.npmjs.com/cli/v11/commands/npm-audit | 2026-11-10 |
| NPM-INSTALACAO | Downloading and installing Node.js and npm | npm Docs | página atual | https://docs.npmjs.com/downloading-and-installing-node-js-and-npm | 2026-11-10 |
| PIP-AUDIT | pip-audit (README) | PyPA | página atual | https://github.com/pypa/pip-audit | 2026-11-10 |
| GH-INSTALACAO | GitHub CLI: instalação no macOS (docs/install_macos.md) | GitHub CLI | página atual | https://github.com/cli/cli/blob/trunk/docs/install_macos.md | 2026-11-10 |
| GH-API | GitHub CLI manual: gh api | GitHub CLI | página atual | https://cli.github.com/manual/gh_api | 2026-11-10 |
| GH-AUTH-STATUS | GitHub CLI manual: gh auth status | GitHub CLI | página atual | https://cli.github.com/manual/gh_auth_status | 2026-11-10 |
| GITHUB-REST-BRANCHES | REST API endpoints for protected branches | GitHub Docs | página atual | https://docs.github.com/en/rest/branches/branch-protection | 2026-11-10 |
| CURL-MANUAL | curl man page (curl - How To Use) | curl | página atual | https://curl.se/docs/manpage.html | 2026-11-10 |

## Grandes empresas: documentos para fornecedores

| Sigla | Documento | Emissor | Versão ou data | URL | Conferida em |
|---|---|---|---|---|---|
| IFOOD-CODIGO | Código de Ética e Conduta para Terceiros (segurança da informação, §3.7) | iFood | 12/08/2022 | https://content.news.ifood.com.br/uploads/2023/04/lo_028_codigocondutaetica_terceiros_interativo_low.pdf | 2026-11-09 |
| IFOOD-ANEXO | Anexo de Compliance – Fornecedores | iFood | 20/08/2025 | https://institucional.ifood.com.br/wp-content/uploads/2025/08/anexo-de-compliance-ifood-fornecedores-08-25.pdf | 2026-11-09 |
| GERDAU-NORMA | Norma de Segurança da Informação para Terceiros | Gerdau | 08/03/2017 | https://gsn.gerdau.com/sites/gsn_gerdau/files/PDF/Norma-de-Seguranca-da-Informacao-para-Terceiros.pdf | 2026-11-09 |
| GERDAU-PTDP | Política de Tratamento de Dados Pessoais para Fornecedores e Parceiros | Gerdau | ago/2020 | https://www.gerdau.com/sites/default/files/2021-12/PTDP_Fornecedores_Parceiros.pdf | 2026-11-09 |
| NATURA-GUIA | Guia de Cibersegurança e Privacidade para Fornecedores | Natura | v2, 2026 | https://filemanager-cdn.mziq.com/published/119ea4f0-4493-4c9c-a74c-61687c1a275b/9e719e05-98d3-49da-8eb3-8aa6ff2e9e89_manual_de_cyber_fornecedor_v2_2026.pdf | 2026-11-09 |
| NATURA-CODIGO | Código Global de Conduta do Fornecedor | Natura Cosméticos | 28/03/2025 | https://api.mziq.com/mzfilemanager/v2/d/67c3b7d4-64ea-4c2f-b380-6596a2ac2fbf/83963877-9a40-fe21-5d59-79bd764d098a?origin=1 | 2026-11-09 |
| RAIZEN-PSI | PLT.01 Política de Segurança da Informação | Raízen | 01/04/2026 | https://www.raizen.com.br/items-files/item-184-politica-de-seguranca-da-informacao.pdf | 2026-11-09 |
| RAIZEN-CODIGO | Código de Conduta de Terceiros | Raízen | 2026 | https://www.raizen.com.br/items-files/item-1497-codigo-de-conduta-de-terceiros-treinamento-05052026.pdf | 2026-11-09 |
| 20F-ITAU | Form 20-F, Item 16K (cibersegurança) | Itaú Unibanco (SEC) | exercício de 2025 | https://www.sec.gov/Archives/edgar/data/1132597/000113259726000132/itub-20251231.htm | 2026-11-09 (recusa robôs) |
| 20F-BRADESCO | Form 20-F, Item 16K (cibersegurança) | Banco Bradesco (SEC) | exercício de 2025 | https://www.sec.gov/Archives/edgar/data/1160330/000129281426001753/bbdform20f_2025.htm | 2026-11-09 (recusa robôs) |
| 20F-VALE | Form 20-F, Item 16K (cibersegurança) | Vale (SEC) | exercício de 2025 | https://www.sec.gov/Archives/edgar/data/917851/000129281426001844/valeform20f_2025.htm | 2026-11-09 (recusa robôs) |
| 20F-GERDAU | Form 20-F, Item 16K (cibersegurança) | Gerdau (SEC) | exercício de 2025 | https://www.sec.gov/Archives/edgar/data/1073404/000110465926027678/ggb-20251231x20f.htm | 2026-11-09 (recusa robôs) |
| 20F-PETROBRAS | Form 20-F, Item 16K (cibersegurança) | Petrobras (SEC) | exercício de 2025 | https://www.sec.gov/Archives/edgar/data/1119639/000129281426002168/pbrform20f_2025.htm | 2026-11-09 (recusa robôs) |
| 20F-EMBRAER | Form 20-F, Item 16K (cibersegurança) | Embraer (SEC) | exercício de 2025 | https://www.sec.gov/Archives/edgar/data/1355444/000162828026021824/erj-20251231.htm | 2026-11-09 (recusa robôs) |
| 20F-AMBEV | Form 20-F, Item 16K (cibersegurança) | Ambev (SEC) | exercício de 2025 | https://www.sec.gov/Archives/edgar/data/1565025/000129281426000640/abevform20f_2025.htm | 2026-11-09 (recusa robôs) |
| 20F-NUBANK | Form 20-F, Item 16K (cibersegurança) | Nu Holdings (SEC) | exercício de 2025 | https://www.sec.gov/Archives/edgar/data/1691493/000129281426002166/nuform20f_2025.htm | 2026-11-09 (recusa robôs) |
| 20F-STONE | Form 20-F, Item 16K (cibersegurança) | StoneCo (SEC) | exercício de 2025 | https://www.sec.gov/Archives/edgar/data/1745431/000207097926000170/stne-20251231.htm | 2026-11-09 (recusa robôs) |
