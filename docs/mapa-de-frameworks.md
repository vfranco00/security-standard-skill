# Mapa de frameworks

> Gerado por `scripts/gerar-catalogo.py` a partir de `skills/*/references/controles-*.md`. Não edite à mão: mude o bloco do controle e rode o script de novo.

Só identificadores e títulos curtos, nenhum texto dos frameworks; `—` quando o controle não tem correspondente. Versões: CCM/CAIQ v4.1; SIG 2026 (só domínios); ISO/IEC 27001:2022 com a Amd 1:2024; SOC 2 TSC 2017 (pontos de foco de 2022); NIST CSF 2.0; CIS Controls v8.1; OWASP ASVS 5.0. Nas chaves SOC2 e SIG, `—` quer dizer "não conferido em fonte oficial gratuita nesta versão", e não só "não há correspondente"; os ids da ISO/IEC 27001 foram conferidos pela OLIR 155 do NIST.

| Id | CAIQ | SIG | ISO | SOC2 | CSF | CIS | ASVS |
|---|---|---|---|---|---|---|---|
| IAM-01 | IAM-13 | — | A.8.5 | — | PR.AA-03 | 6.3, 6.4, 6.5 | — |
| IAM-02 | IAM-12 | — | A.5.16 | — | PR.AA-01 | 5.6, 6.7 | — |
| IAM-03 | IAM-10 | — | A.8.2 | — | PR.AA-05 | 6.1 | — |
| IAM-04 | IAM-05, IAM-08 | — | A.5.15, A.5.18, A.8.2 | — | PR.AA-05 | 5.1, 5.3, 5.4, 6.8 | — |
| IAM-05 | IAM-10 | — | A.8.2 | — | PR.AA-05 | — | — |
| IAM-06 | IAM-14 | — | A.5.17 | — | PR.AA-01 | — | V13.3 |
| IAM-07 | IAM-14 | — | A.5.17 | — | PR.AA-01 | 4.7 | — |
| IAM-08 | IAM-07 | — | A.5.18, A.6.5 | — | PR.AA-05, GV.RR-04 | 6.2 | — |
| IAM-09 | IAM-03, IAM-05 | — | A.5.16, A.8.2 | — | PR.AA-01, PR.AA-05 | 5.5 | — |
| IAM-10 | IAM-10, IAM-13 | — | A.8.2, A.8.5 | — | PR.AA-03, PR.AA-05 | 5.4, 6.5 | — |
| IAM-11 | IAM-02, IAM-13, IAM-14 | — | A.5.17, A.8.5 | — | PR.AA-03 | 5.2, 6.5 | V6.2 |
| IAM-12 | LOG-03, LOG-04, LOG-09, LOG-10 | — | A.8.15, A.8.16 | — | PR.PS-04, DE.CM-03 | 8.2, 8.5 | — |
| IAM-13 | UEM-05 | — | A.8.1 | — | PR.AA-03 | 13.5 | — |
| IAM-14 | IAM-07, IAM-13 | — | A.5.18 | — | PR.AA-05 | 6.2, 6.4 | — |
| DAT-01 | DSP-03, DSP-04 | — | A.5.9, A.5.12, A.5.13 | — | ID.AM-05, ID.AM-07 | 3.2, 3.7 | V14.1 |
| DAT-02 | CEK-03 | — | A.8.1, A.8.24 | — | PR.DS-01 | 3.6, 3.9, 3.11 | V11.3 |
| DAT-03 | CEK-03, I&S-03 | — | A.8.20, A.8.24 | — | PR.DS-02 | 3.10 | V12, V3.4 |
| DAT-04 | CEK-08, CEK-10, CEK-12 | — | A.8.24 | — | PR.DS-01 | 3.11 | V11.1, V13.3 |
| DAT-05 | CEK-11, CEK-21 | — | A.8.24, A.8.31 | — | PR.DS-01 | 16.8 | V11.1 |
| DAT-06 | BCR-08 | — | A.8.13 | — | PR.DS-11, RC.RP-03 | 11.1, 11.2, 11.3, 11.4, 11.5 | — |
| DAT-07 | BCR-02, BCR-09 | — | A.5.30 | — | GV.OC-04, PR.IR-03 | 11.1 | — |
| DAT-08 | DSP-16 | — | A.5.33, A.8.10 | — | ID.AM-08 | 3.4, 3.5 | V14.2 |
| DAT-09 | DSP-19 | — | A.5.23, A.5.34 | — | GV.SC-05 | — | — |
| DAT-10 | DSP-15 | — | A.8.11, A.8.33 | — | — | 16.8 | — |
| DAT-11 | DSP-17, LOG-07, LOG-08 | — | A.8.11, A.8.15 | — | PR.PS-04 | — | V16.2, V14.2 |
| DAT-12 | DSP-02, IPY-04 | — | A.5.20, A.8.10 | — | GV.SC-10 | 3.5 | — |
| DAT-13 | DSP-10 | — | A.5.14 | — | PR.DS-02 | 3.10 | — |
| DAT-14 | DSP-08, DSP-17 | — | A.5.34, A.8.11 | — | PR.DS-01 | — | — |
| DAT-15 | DSP-11 | — | A.5.34, A.8.10 | — | ID.AM-08 | 3.5 | — |
| DEV-01 | AIS-04, TVM-04 | — | A.8.25, A.8.27 | — | ID.RA-03, ID.RA-04 | 16.14 | — |
| DEV-02 | CCC-04 | — | A.8.4, A.8.32 | — | PR.PS-06 | 16.1 | — |
| DEV-03 | AIS-05, TVM-03, TVM-06 | — | A.8.8, A.8.28, A.8.29 | — | ID.RA-01, PR.PS-06 | 16.12 | — |
| DEV-04 | TVM-06 | — | A.8.8 | — | ID.RA-01, PR.PS-02 | 16.5 | V15.1, V15.2 |
| DEV-05 | STA-08, STA-09 | — | A.5.9 | — | ID.AM-02 | 16.4 | V15.1 |
| DEV-06 | AIS-06 | — | A.8.25 | — | PR.PS-06, ID.RA-09 | — | — |
| DEV-07 | — | — | A.8.25, A.8.31 | — | PR.PS-06, PR.IR-01 | — | — |
| DEV-08 | AIS-04 | — | A.5.8, A.8.29 | — | PR.PS-06 | 16.1 | — |
| DEV-09 | AIS-07, TVM-08, TVM-09 | — | A.8.8 | — | ID.RA-01, ID.RA-06 | 7.2, 16.6 | V15.1, V15.2 |
| DEV-10 | — | — | A.8.8 | — | ID.RA-08 | 16.2 | — |
| DEV-11 | — | — | — | — | ID.RA-08 | — | — |
| DEV-12 | I&S-05 | — | A.8.31 | — | PR.IR-01 | 16.8 | — |
| DEV-13 | CCC-01 | — | A.8.9, A.8.32 | — | PR.PS-01 | 4.1 | — |
| DEV-14 | AIS-05 | — | A.8.29 | — | PR.PS-06, ID.IM-02 | 16.12 | — |
| DEV-15 | — | — | A.5.17 | — | PR.AA-01 | — | V13.3 |
| DEV-16 | CCC-03 | — | A.8.15, A.8.32 | — | PR.PS-04, ID.RA-07 | 8.2 | — |
| DEV-17 | HRS-11 | — | A.6.3 | — | PR.AT-02 | 16.9 | — |
| DEV-18 | AIS-02 | — | A.8.26 | — | PR.PS-06 | 16.1 | V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15, V16, V17 |
| DEV-19 | TVM-06 | — | A.8.8 | — | PR.PS-02 | 2.2, 16.5 | V15.1 |
| DEV-20 | AIS-04 | — | A.8.28 | — | PR.PS-06 | 16.1 | — |
| DEV-21 | IAM-13 | — | A.8.5 | — | PR.AA-03 | 6.3 | V6 |
| DEV-22 | IAM-02, IAM-14 | — | A.5.17, A.8.24 | — | PR.AA-01, PR.DS-01 | — | V11.4 |
| DEV-23 | AIS-08, I&S-06, IAM-15 | — | A.5.15, A.8.3 | — | PR.AA-05 | 6.8 | V8 |
| DEV-24 | AIS-04 | — | A.8.28 | — | PR.PS-06 | 16.11 | V1.2 |
| DEV-25 | AIS-04 | — | A.8.28 | — | PR.PS-06 | — | V3.3, V3.5 |
| DEV-26 | — | — | A.5.32 | — | GV.OC-03 | — | — |
| OPS-01 | I&S-04, AIS-02 | — | A.8.9 | — | PR.PS-01 | 4.1, 4.7, 4.8, 16.7 | — |
| OPS-02 | I&S-03 | — | A.8.20, A.8.22 | — | PR.IR-01 | 3.12, 12.2, 13.4 | — |
| OPS-03 | I&S-09 | — | A.8.20 | — | PR.IR-01 | 4.4, 13.10 | V13.4 |
| OPS-04 | AIS-02, CEK-03 | — | A.8.24, A.8.26 | — | PR.DS-02, PR.PS-01 | 3.10 | V3.4, V12.1, V12.2 |
| OPS-05 | LOG-02, LOG-07, LOG-09 | — | A.8.15 | — | PR.PS-04 | 8.1, 8.2, 8.9, 8.10 | V16.1, V16.3 |
| OPS-06 | LOG-02, LOG-04, LOG-06, LOG-10 | — | A.8.15, A.8.17 | — | PR.PS-04 | 8.4 | V16.2, V16.4 |
| OPS-07 | LOG-03, LOG-05, LOG-14 | — | A.8.16 | — | DE.CM-01, DE.CM-09, DE.AE-02 | 8.11, 13.1 | — |
| OPS-08 | TVM-03, TVM-08 | — | A.8.8 | — | ID.RA-01, PR.PS-02 | 2.2, 7.3, 7.4, 7.5, 7.6, 7.7 | — |
| OPS-09 | CCC-06, CCC-07 | — | A.8.9, A.5.23 | — | PR.PS-01 | 4.1, 4.2 | — |
| OPS-10 | DCS-07, UEM-04 | — | A.5.9 | — | ID.AM-01, ID.AM-02 | 1.1, 1.3, 2.1 | — |
| OPS-11 | I&S-09, I&S-02 | — | A.8.6, A.8.20 | — | PR.IR-04, DE.CM-01 | 13.10 | — |
| OPS-12 | AIS-08 | — | A.8.6 | — | PR.IR-04 | — | V2.4 |
| OPS-13 | BCR-10 | — | A.5.30 | — | PR.IR-03, ID.IM-02 | — | — |
| OPS-14 | I&S-05 | — | A.8.31, A.8.22 | — | PR.IR-01 | 16.8 | — |
| OPS-15 | I&S-03, IAM-13 | — | A.8.2, A.8.5 | — | PR.AA-03, PR.IR-01 | 4.6, 12.8 | — |
| OPS-16 | TVM-07 | — | A.8.8 | — | ID.RA-01, ID.IM-02 | 18.1, 18.2, 18.3, 18.5 | — |
| IRC-01 | SEF-01, SEF-03 | — | A.5.24, A.5.26 | — | ID.IM-04, RS.MA-01 | 17.1, 17.4, 17.5 | — |
| IRC-02 | SEF-06, SEF-07 | — | A.5.25 | — | DE.AE-08, RS.MA-02, RS.MA-03 | 17.9 | — |
| IRC-03 | SEF-08 | — | A.5.26, A.5.5 | — | RS.CO-02, RS.CO-03, GV.SC-08 | 17.6 | — |
| IRC-04 | SEF-09 | — | A.5.26 | — | RS.AN-06, RC.RP-06 | — | — |
| IRC-05 | — | — | A.5.27 | — | RS.AN-03, ID.IM-03 | 17.8 | — |
| IRC-06 | SEF-04, BCR-06 | — | A.5.24, A.5.30 | — | ID.IM-02 | 17.7 | — |
| IRC-07 | BCR-01, BCR-02, BCR-03, BCR-04, BCR-09 | — | A.5.29, A.5.30 | — | ID.IM-04, RC.RP-01, RC.RP-04 | 11.1 | — |
| IRC-08 | BCR-07, SEF-03 | — | A.5.26 | — | RS.CO-02, RS.CO-03, RC.CO-03, RC.CO-04 | 17.6 | — |
| IRC-09 | SEF-10 | — | A.6.8 | — | RS.MA-02, GV.SC-08 | 17.2, 17.3 | — |
| IRC-10 | SEF-03 | — | A.5.27 | — | ID.IM-03, ID.IM-04 | 17.8 | — |
| IRC-11 | SEF-08 | — | A.5.26, A.5.34 | — | RS.CO-02 | 17.6 | — |
| GOV-01 | GRC-01, GRC-03, GRC-04 | — | A.5.1 | — | GV.PO-01, GV.PO-02 | — | — |
| GOV-02 | GRC-05, GRC-06 | — | A.5.2, A.5.4 | — | GV.RR-01, GV.RR-02, GV.RR-03 | — | — |
| GOV-03 | GRC-06, IAM-04, HRS-09 | — | A.5.2, A.5.3 | — | GV.RR-02, PR.AA-05 | — | — |
| GOV-04 | HRS-11, HRS-12, HRS-13 | — | A.6.3 | — | PR.AT-01, PR.AT-02 | 14.1, 14.2, 14.6, 14.9 | — |
| GOV-05 | GRC-02 | — | cl. 6.1.2, cl. 6.1.3, cl. 8.2 | — | GV.RM-06, ID.RA-05, ID.RA-06 | — | — |
| GOV-06 | STA-01, STA-08, STA-10, STA-11, STA-14, DSP-13 | — | A.5.19, A.5.20, A.5.21, A.5.22 | — | GV.SC-04, GV.SC-05, GV.SC-06, GV.SC-07, GV.SC-10, ID.AM-04 | 15.1, 15.2, 15.4, 15.5 | — |
| GOV-07 | DSP-13, DSP-14 | — | — | — | GV.SC-02 | — | — |
| GOV-08 | HRS-01 | — | A.6.1 | — | GV.RR-04 | — | — |
| GOV-09 | HRS-07, HRS-08, HRS-10 | — | A.6.2, A.6.6 | — | GV.RR-04 | — | — |
| GOV-10 | HRS-02, UEM-01, UEM-04, UEM-05, UEM-06, UEM-07, UEM-09, UEM-13 | — | A.5.10, A.6.7, A.8.1 | — | ID.AM-01, PR.PS-01, PR.PS-05 | 1.1, 4.3, 7.3, 7.4, 10.1 | — |
| GOV-11 | A&A-02 | — | — | — | — | — | — |
| GOV-12 | STA-04, STA-11 | — | — | — | GV.SC-02 | — | — |
| GOV-13 | STA-11, A&A-04 | — | A.5.20, A.5.31 | — | GV.OC-03, GV.SC-05 | — | V6.2 |
| GOV-14 | STA-13, A&A-01, A&A-05, A&A-06 | — | cl. 9.2, A.5.35, A.5.36 | — | ID.IM-01, GV.OV-03 | — | — |
| GOV-15 | TVM-12, SEF-05 | — | cl. 9.1, cl. 9.3 | — | GV.OV-01, GV.OV-03, GV.RR-01 | — | — |
| GOV-16 | — | — | — | — | GV.RM-04 | — | — |
| GOV-17 | GRC-07, A&A-04 | — | A.5.31 | — | GV.OC-03 | — | — |
