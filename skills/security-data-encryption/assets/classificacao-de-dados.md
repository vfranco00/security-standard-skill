> Gerado pela security-standard-skill em {{data}} · revisar antes de usar

# Classificação de dados

Documento interno: tem o inventário dos dados e das chaves e fica em `.security-standard/classificacao-de-dados.md`, fora de `docs/seguranca/`. Se o arquivo já existe, atualize-o no lugar; nunca copie este modelo por cima. Os ids entre parênteses são os controles da skill `security-data-encryption`.

Nunca escreva aqui o valor de uma chave, senha ou token, nem um dado pessoal de exemplo: registre só o nome, o tipo e onde fica.

- Projeto: {{projeto}}
- Nível alvo: {{nivel_alvo}} · Perfis: {{perfis}}
- Responsável: {{responsavel}}
- Última revisão do esquema: {{data_da_revisao}} · Próxima: {{data_da_proxima_revisao}} (ao menos uma vez por ano, DAT-01)

## 1. Classes (DAT-01)

| Classe | O que entra | Exemplos |
|---|---|---|
| Pública | o que pode sair da empresa sem dano | página do site, documentação pública, preços |
| Interna | o que toda a equipe pode ver, mas não sai da empresa | processos, documentação interna, métricas sem dado pessoal |
| Confidencial | dado pessoal comum, dado de cliente, contrato, código-fonte | nome, e-mail, telefone, CPF, endereço, dados do contrato |
| Restrita | dado pessoal sensível (LGPD, art. 5º, II), dado de criança ou adolescente, dado de cartão, credenciais e chaves | saúde, biometria, número do cartão, senha, token, chave privada |

No perfil `setor-publico`, use também as classes do órgão; a informação classificada em grau de sigilo não vai para a nuvem (IN GSI/PR 5/2021, art. 17).

## 2. Regras de proteção por classe (DAT-01, a partir do Fornecedor)

| Regra | Pública | Interna | Confidencial | Restrita |
|---|---|---|---|---|
| Criptografia em repouso (DAT-02) | padrão do provedor | padrão do provedor | padrão do provedor | padrão do provedor e, no campo, pela aplicação (DAT-14) |
| Em trânsito e troca de arquivos (DAT-03, DAT-13) | TLS | TLS | TLS; arquivo só por canal cifrado | TLS; arquivo só por canal cifrado e com registro |
| Quem acessa | todos | a equipe | quem precisa pela função | quem precisa pela função, com registro de acesso |
| Logs (DAT-11) | livre | livre | mascarado | nunca |
| Ambientes de teste (DAT-10) | livre | livre | mascarado ou sintético | só sintético |
| Envio a terceiros | livre | com acordo | com acordo e canal cifrado | com acordo, canal cifrado e aprovação |
| Guarda (DAT-08) | tabela de guarda | tabela de guarda | tabela de guarda | tabela de guarda |

A partir do Fornecedor, a eliminação por prazo é automática para toda classe (DAT-08).

## 3. Inventário dos dados (DAT-01, DAT-02, DAT-09)

Uma linha por lugar onde há dado pessoal ou confidencial: banco (tabela ou campo), bucket, fila, log, cópia de segurança, planilha ou fornecedor. Atualize a cada mudança que crie ou mova esse dado.

| Onde fica | Ambiente | Dados | Classe | De quem (titulares) | Criptografia em repouso e chave (DAT-02, DAT-04) | País e região (DAT-09) | Prazo de guarda (DAT-08) | Dono |
|---|---|---|---|---|---|---|---|---|
| {{lugar}} | {{produção, homologação ou desenvolvimento}} | {{dados}} | {{classe}} | {{titulares}} | {{algoritmo e quem gerencia a chave}} | {{país e região}} | {{prazo, ver a seção 5}} | {{pessoa}} |

## 4. Chaves de criptografia (DAT-04, DAT-05)

| Chave (nome, nunca o valor) | Ambiente | Finalidade | Dados que pode proteger | Onde fica (KMS, HSM ou cofre) | Rotação automática ou troca por chave nova (dias) e última troca | Quem administra |
|---|---|---|---|---|---|---|
| {{nome}} | {{ambiente}} | {{cifrar campos, assinar tokens, cifrar cópias}} | {{dados}} | {{local}} | {{período e data}} | {{pessoa ou equipe}} |

Nenhuma chave aparece em dois ambientes (DAT-05). Chave fora do KMS, do HSM ou do cofre é lacuna do DAT-04.

## 5. Tabela de guarda (DAT-08)

| Tipo de dado | Prazo | Motivo (lei, contrato ou finalidade) | No fim do prazo | Rotina que elimina ou anonimiza | Última execução |
|---|---|---|---|---|---|
| Registros de acesso à aplicação (o conteúdo de cada registro está na família OPS) | 6 meses, no mínimo | Marco Civil, art. 15, quando a empresa é provedor de aplicação | eliminar | {{rotina}} | {{data}} |
| {{tipo de dado}} | {{prazo}} | {{motivo}} | {{eliminar ou anonimizar}} | {{rotina}} | {{data}} |

Peça ao jurídico os prazos fiscais, trabalhistas e de contrato antes de fechar a tabela. Dado sem motivo para ficar é eliminado (LGPD, arts. 15 e 16). O conteúdo e a guarda dos registros de acesso e dos logs de segurança ficam com a família OPS.

## 6. Histórico de revisões

Só acrescente linhas; nunca regrave as anteriores.

| Data | Quem revisou | O que mudou |
|---|---|---|
| {{data}} | {{pessoa}} | {{mudança}} |
