> Gerado pela security-standard-skill em {{data}} · revisar antes de usar

# Registro de incidentes de segurança

Registro interno (IRC-04): fica em `.security-standard/registro-de-incidentes.md` como cópia de trabalho, com a cópia oficial num lugar durável e com backup ({{onde fica a cópia oficial}}), e nunca vai para `docs/seguranca/`. Entra todo incidente declarado (IRC-02), comunicado ou não. Anote só números e categorias de titulares, nunca a lista de pessoas, e nenhum segredo.

- Base: no incidente com dado pessoal em que somos controlador, a Res. CD/ANPD nº 15/2024, art. 10 (conteúdo mínimo e guarda por no mínimo 5 anos contados da data do registro, inclusive do incidente não comunicado). Os outros incidentes e as entradas como operador seguem o mesmo prazo (proposta).
- Toda entrada com dado pessoal traz aqui os oito itens do art. 10, § 1º, mesmo com a `lgpd-skill` instalada. Se existir `.lgpd/incidentes/registro.md` (ou `registro-lgpd-skill.md`) com o mesmo incidente, acrescente a referência a ele pelo código; sem a pasta `.lgpd/`, este registro é a prova, e nada fica só na conversa.
- Só acrescente: nenhuma entrada é regravada, e nenhuma é apagada antes da data de "Guardar até". Para completar ou corrigir uma entrada (complemento à ANPD, data de um aviso, causa achada depois), acrescente uma linha nova e datada na seção "Atualizações", no fim do registro, com o código do incidente.

## Índice

| Código | Data do registro | Data do conhecimento | Gravidade | Dado pessoal? | Nosso papel | Risco relevante? | Avisos (cliente, ANPD, titulares) | Guardar até |
|---|---|---|---|---|---|---|---|---|
| {{INC-AAAA-NN}} | {{data}} | {{data}} | {{crítico, alto ou baixo}} | {{sim ou não}} | {{controlador ou operador}} | {{sim, não ou não se aplica}} | {{datas, ou "não"}} | {{data do registro + 5 anos, no mínimo}} |

## {{INC-AAAA-NN}}: {{título curto}}

- Data do registro: {{data}}
- Nosso papel: {{controlador}} ou {{operador; controlador avisado em data, pelo canal}}
- Porte do controlador, que é o que dobra os prazos: {{agente de pequeno porte ou não}} (Res. CD/ANPD nº 2/2022, arts. 2º e 3º)
- Gravidade (IRC-02): {{...}}

### Conteúdo mínimo (Res. CD/ANPD nº 15/2024, art. 10, § 1º)

| Inciso | Item | Preenchimento |
|---|---|---|
| I | Data do conhecimento do incidente | {{data e hora em que se soube que dados pessoais foram afetados}} |
| II | Descrição geral das circunstâncias | {{o que aconteceu, como e quando}} |
| III | Natureza (geral ou sensível) e categoria dos dados afetados | {{...}} |
| IV | Número de titulares afetados | {{número}} |
| V | Avaliação do risco e possíveis danos aos titulares | {{condição (a): pode afetar significativamente interesses e direitos fundamentais? por quê. Condição (b): qual critério do art. 5º, I a VI? Conclusão}} |
| VI | Medidas de correção e mitigação, quando houver | {{...}} |
| VII | Forma e conteúdo da comunicação, se houve comunicação à ANPD e aos titulares | {{datas, meios e onde está o texto}} |
| VIII | Motivos da ausência de comunicação, quando for o caso | {{...}} |

### Avisos e prazos (IRC-03, IRC-11)

Conte os dias úteis como no IRC-03: pelo lado seguro, sem o dia do conhecimento, com o do vencimento e sem contar com prorrogação.

| Aviso | Prazo | Conta a partir de | Data-limite | Feito em |
|---|---|---|---|---|
| Ao cliente (somos operador) | imediatamente; até 24 horas se o contrato não fixar prazo (proposta) | quando soubemos do incidente | {{data}} | {{data e canal}} |
| À ANPD (somos controlador) | 3 dias úteis; 6 se formos agente de pequeno porte | conhecimento de que dados pessoais foram afetados | {{data}} | {{data e protocolo}} |
| Aos titulares (somos controlador) | 3 dias úteis; 6 se formos agente de pequeno porte | conhecimento de que dados pessoais foram afetados | {{data}} | {{data e meios}} |
| Complemento à ANPD | até 20 dias úteis; 40 no agente de pequeno porte | data da comunicação | {{data}} | {{data}} |
| Declaração à ANPD do aviso aos titulares | até 3 dias úteis | fim do prazo do aviso aos titulares | {{data}} | {{data}} |
| Perfis do projeto (instituição financeira, seguradora, órgão, bandeiras) | {{conforme o IRC-03}} | {{...}} | {{data}} | {{data}} |

### Encerramento

- Relatório pós-incidente (IRC-05): {{onde está}} · Controles envolvidos (IRC-10): {{ids}}
- Revisado por: {{encarregado ou advogado}}, em {{data}}
- Guardar até: {{data do registro + 5 anos, ou mais}}

## Atualizações

Uma linha por complemento ou correção, sempre no fim, sem mexer na entrada original.

| Data | Código | O que foi acrescentado ou corrigido | Quem |
|---|---|---|---|
| {{data}} | {{INC-AAAA-NN}} | {{ex.: complemento fundamentado enviado à ANPD, com o protocolo; causa principal identificada}} | {{cargo}} |
