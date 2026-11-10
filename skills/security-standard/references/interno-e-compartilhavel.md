# Interno e compartilhável

O projeto do usuário ganha duas pastas, com regras opostas.

| | `.security-standard/` (interno) | `docs/seguranca/` (compartilhável) |
|---|---|---|
| Para quem | a equipe | o cliente e quem avalia o fornecedor |
| O que guarda | `STATUS.md`, `inventario.md`, `config.yml`, `lacunas.md`, `plano.md`, `evidencias/<AAAA-MM-DD>/` e os arquivos internos das famílias: `matriz-de-acessos.md` (IAM), `classificacao-de-dados.md` e `politica-de-backup-e-recuperacao.md` (DAT), `checklist-de-hardening.md` (OPS), `registro-de-incidentes.md` e `contatos-de-incidente.md` (IRC) e `registro-de-riscos.md` (GOV) | o dossiê de segurança, as respostas ao questionário e os documentos gerados dos modelos (política de segurança, plano de resposta a incidentes, continuidade, lista de subprocessadores) |
| No git | fora: a maestra acrescenta `.security-standard/` ao `.gitignore` | dentro, como qualquer documento do projeto |
| Quem escreve | a maestra e as skills das famílias | a `security-customer-evidence` e as skills que geram documentos dos modelos |

## Por que o interno fica fora do git

- `lacunas.md` e `plano.md` mostram onde o sistema é fraco.
- `evidencias/` guarda saída de ferramenta, que pode citar arquivo, dependência vulnerável ou nome de conta.
- `inventario.md` descreve contas, acessos e fornecedores.
- `registro-de-incidentes.md` descreve incidentes, e `contatos-de-incidente.md` tem nomes e telefones da equipe.
- `matriz-de-acessos.md` diz quem acessa o quê; `classificacao-de-dados.md`, `politica-de-backup-e-recuperacao.md` e `checklist-de-hardening.md` dizem onde estão os dados e as cópias e como o ambiente é protegido; `registro-de-riscos.md` lista os riscos, inclusive os aceitos.

O registro de incidentes precisa de uma cópia durável fora da pasta interna, num lugar com backup (repositório privado ou sistema de documentos da empresa). A pasta fica fora do git, e o registro de incidente é guardado por, no mínimo, cinco anos a partir da data do registro (Res. CD/ANPD nº 15/2024, art. 10; `ANPD-RES15` em `fontes.md`). O mesmo vale para os outros registros que provam um controle ao longo do tempo: o `registro-de-riscos.md`, as seções de registro da `matriz-de-acessos.md` (4, elevações; 7, revisões; 8, desligamentos: IAM-03, IAM-04 e IAM-08) e o registro dos testes da `politica-de-backup-e-recuperacao.md` (seção 8: DAT-06). A cópia em `.security-standard/` é a de trabalho.

Quem quiser versionar `lacunas.md` e `plano.md` num repositório privado troca a linha do `.gitignore` por estas três. Com a pasta inteira ignorada, o git não reinclui arquivo de dentro dela; com `/*`, reinclui os dois e mantém o resto de fora.

```gitignore
.security-standard/*
!.security-standard/lacunas.md
!.security-standard/plano.md
```

## O que nunca vai para `docs/seguranca/`

- linha `ausente` ou `parcial`, e nada do plano;
- saída de ferramenta, achado de varredura, versão vulnerável;
- identificador de conta, nome de bucket ou de banco de dados, endereço interno, segredo ou valor de variável de ambiente;
- afirmação de conformidade ou de certificação que a empresa não tem.

## Como o atendido chega ao cliente

A `security-customer-evidence` lê `lacunas.md`, pega só as linhas `atendido` e escreve o dossiê dizendo se cada evidência é verificada, documento ou declarada. O que falta continua no plano interno.
