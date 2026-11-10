> Gerado pela security-standard-skill em {{data}} · revisar antes de usar

# Security dossier: {{product}}

{{company}} · version {{version}} · {{date}}

**Self-assessment; items marked as declared have not been verified by a third party.**

Evidence types:

- `verified`: checked by the company itself in the code, the configuration or the system records; it is not a third-party audit.
- `document`: backed by a company document, such as an approved policy, a test record or a report.
- `declared`: a statement by the company, not verified.

This document describes only what is in place and has evidence on the date the state was assessed (section 11).

## 1. Overview and architecture

{{what the product does and who uses it, by sector or type of customer, never by name}}

| Component | Technology | Evidence type |
|---|---|---|
| {{application, database, authentication or integration}} | {{technology, without version}} | {{verified, document or declared}} |

## 2. Hosting and data location

| Component | Provider | Country and region | Evidence type |
|---|---|---|---|
| {{application, database, files or backups}} | {{provider}} | {{country and region}} | {{verified, document or declared}} |

## 3. Controls by family

Only the controls that are met and have evidence. The ids come from the security-standard-skill catalog of {{catalog}}.

### Identity and access (IAM)

| Id | Control | Status | Evidence type | How it is met |
|---|---|---|---|---|
| {{id}} | {{title}} | met | {{verified, document or declared}} | {{what is done, by whom and how often}} |

### Data and encryption (DAT)

| Id | Control | Status | Evidence type | How it is met |
|---|---|---|---|---|
| {{id}} | {{title}} | met | {{verified, document or declared}} | {{what is done, by whom and how often}} |

### Secure development (DEV)

| Id | Control | Status | Evidence type | How it is met |
|---|---|---|---|---|
| {{id}} | {{title}} | met | {{verified, document or declared}} | {{what is done, by whom and how often}} |

### Infrastructure and operations (OPS)

| Id | Control | Status | Evidence type | How it is met |
|---|---|---|---|---|
| {{id}} | {{title}} | met | {{verified, document or declared}} | {{what is done, by whom and how often}} |

### Incidents and continuity (IRC)

| Id | Control | Status | Evidence type | How it is met |
|---|---|---|---|---|
| {{id}} | {{title}} | met | {{verified, document or declared}} | {{what is done, by whom and how often}} |

### Governance and vendors (GOV)

| Id | Control | Status | Evidence type | How it is met |
|---|---|---|---|---|
| {{id}} | {{title}} | met | {{verified, document or declared}} | {{what is done, by whom and how often}} |

## 4. Certifications and reports

- Certifications: {{none; or each certificate provided, with the issuer, the scope and the validity}}.
- Reports: {{none; or each report provided (penetration test, audit, SOC 2), with the issuer, the scope and the date}}.

## 5. Subprocessors

| Subprocessor | Purpose | Country and region of the data | Evidence type |
|---|---|---|---|
| {{vendor}} | {{what it does with the data}} | {{country and region}} | {{verified, document or declared}} |

## 6. Secure development

{{what the DEV rows that are met show, each sentence with the id and the evidence type}}

## 7. Incident response and customer notification

{{what the IRC rows that are met show (response plan, channel and deadline to notify the customer), each sentence with the id and the evidence type}}

## 8. Continuity and recovery

{{what the rows that are met on backup, RPO and RTO, recovery testing and continuity show, with the measured figures, each sentence with the id and the evidence type}}

## 9. Privacy and LGPD (Brazilian General Data Protection Law)

{{privacy documents that can go to the customer, such as the published privacy policy and the data protection officer channel, produced with the lgpd-skill, if installed}}

## 10. Security contact

{{channel to report a vulnerability or an incident: e-mail or form of a role, SECURITY.md or security.txt}}

## 11. Date and version

| Version | Date | State assessed on | What changed |
|---|---|---|---|
| {{version}} | {{date}} | {{date of "Avaliado em" in lacunas.md}} | {{first version, or what changed since the previous one}} |
