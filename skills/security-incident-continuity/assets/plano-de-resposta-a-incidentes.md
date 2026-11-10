> Gerado pela security-standard-skill em {{data}} · revisar antes de usar

# Plano de resposta a incidentes de segurança

Plano do produto {{produto}}, da empresa {{empresa}}. Os ids entre parênteses são os controles da skill `security-incident-continuity`. Este documento pode ir para o cliente em `docs/seguranca/plano-de-resposta-a-incidentes.md`; nele ficam só papéis e canais de grupo. Nomes, telefones pessoais e os contatos de cada cliente ficam no Anexo A, guardado em `.security-standard/contatos-de-incidente.md` e tirado da cópia compartilhada. Nunca escreva aqui senha, token, chave nem dado de titular.

- Versão: {{versão}} · Aprovado por: {{cargo}} em {{data_da_aprovacao}}
- Última revisão: {{data_da_revisao}} · Próxima: {{data_da_proxima_revisao}} (a cada 12 meses e a cada troca de pessoa-chave ou de fornecedor crítico; IRC-01)
- Nível alvo: {{nivel_alvo}} · Perfis: {{perfis}}

## 1. Papéis (IRC-01)

| Papel | O que faz | Cargo | Substituto |
|---|---|---|---|
| Responsável pelo incidente | declara o incidente, coordena a resposta, decide a escalada e o encerramento | {{cargo}} | {{cargo}} |
| Técnico | investiga, preserva as evidências, contém, erradica e recupera | {{cargo}} | {{cargo}} |
| Comunicação (porta-voz) | prepara e envia os avisos aprovados e fala com a imprensa (IRC-08) | {{cargo}} | {{cargo}} |
| Jurídico ou encarregado | avalia o risco relevante, revisa os avisos e, quando somos controlador, conduz a comunicação à ANPD e aos titulares | {{cargo}} | {{cargo}} |

Plantão: {{como acionar; a cobertura e a escala seguem o OPS-07; no perfil cartoes, pessoal designado 24x7 (PCI DSS 12.10.3)}}.

## 2. Nosso papel em cada atividade

O papel decide quem comunica a ANPD e os titulares: o controlador comunica (LGPD, art. 48); o operador segue as instruções dele (art. 39) e o avisa no prazo e pelo canal do contrato.

| Atividade ou base de dados | Papel (controlador ou operador) | Controlador, quando somos operador | Cláusula de aviso do contrato (prazo e canal) |
|---|---|---|---|
| {{ex.: dados que os clientes guardam no produto}} | {{operador}} | {{cliente}} | {{prazo e canal}} |
| {{ex.: cadastro dos nossos usuários e funcionários}} | {{controlador}} | — | — |

Porte do controlador, que é o que dobra os prazos (Res. CD/ANPD nº 2/2022, arts. 2º e 3º): {{quando somos controlador, agente de pequeno porte ou não, com a prova do enquadramento; quando somos operador, o nosso porte não muda o prazo do cliente}}.

## 3. Quando declarar incidente e gravidade (IRC-02)

- **Incidente:** evento adverso confirmado que viola a confidencialidade, a integridade, a disponibilidade ou a autenticidade dos dados ou do serviço. Tentativa sem acesso a dados (varredura de portas, login que falhou, negação de serviço barrada) fica registrada como evento, sem aviso.
- **Declare cedo:** {{condições; ex.: precisa de outra equipe, o cliente vê o problema ou não se resolveu depois de uma hora de análise}}.

| Gravidade | Critério | Acionamento e escalada |
|---|---|---|
| Crítico | {{ex.: dados pessoais ou de cliente expostos, ransomware, produção parada}} | {{ex.: plantão na hora; responsável e direção avisados}} |
| Alto | {{...}} | {{...}} |
| Baixo | {{...}} | {{...}} |

**Risco ou dano relevante aos titulares** (só em incidente com dado pessoal; Res. CD/ANPD nº 15/2024, art. 5º). Há quando as duas condições estão presentes: (a) o incidente pode afetar significativamente interesses e direitos fundamentais dos titulares; e (b) envolve ao menos um destes critérios: dado sensível; dado de criança, de adolescente ou de idoso; dado financeiro; dado de autenticação; dado protegido por sigilo legal, judicial ou profissional; ou dados em larga escala. Anote as duas condições, a conclusão e o motivo no registro (IRC-04). A avaliação cabe dentro do prazo, que já está correndo.

## 4. Passos

No incidente em curso, conter vem primeiro: estancar o dano, depois restaurar o serviço, preservando a evidência (IRC-01).

1. **Conter, sem apagar.** Revogue e troque as credenciais expostas, isole da rede o que foi afetado e bloqueie o acesso indevido; prefira isolar a desligar, para não perder a memória que a investigação usa. Guarde os registros, as cópias e os snapshots junto, sem atrasar a contenção: eles são obrigatórios antes de apagar ou restaurar, não antes de isolar. Roteiros prontos (Fornecedor): {{credencial vazada, ransomware, vazamento de dados de cliente, conta de nuvem comprometida, indisponibilidade do provedor}}.
2. **Classificar e contar os prazos.** Gravidade e, com dado pessoal, risco relevante (seção 3); datas-limite pela seção 5.
3. **Registrar.** Acrescente a entrada no fim do registro de incidentes, com o código ({{INC-AAAA-NN}}), a data e a hora em que soubemos do incidente e a data em que soubemos que dados pessoais foram afetados (IRC-04).
4. **Avisar.** Pela seção 5, nos prazos dela.
5. **Erradicar e recuperar.** Remova a causa e volte a operar pelo plano de continuidade, dentro do RPO e do RTO do DAT-07.
6. **Encerrar.** Critério: {{ex.: causa removida, serviço normal, avisos feitos}}. Depois, o relatório pós-incidente (seção 7).

## 5. Quem avisamos e em quanto tempo (IRC-03, IRC-11)

Os prazos em dias úteis contam do conhecimento, pelo controlador, de que o incidente afetou dados pessoais (Res. CD/ANPD nº 15/2024, art. 6º, § 1º, e art. 9º, caput), não da data do incidente nem do fim da apuração. Conte pelo lado seguro: sem o dia do conhecimento, com o do vencimento e sem contar com prorrogação; a regra mais próxima é a da Res. CD/ANPD nº 1/2021, art. 8º, que se aplica no que couber (Res. CD/ANPD nº 15/2024, art. 11, parágrafo único), e a contagem exata é ponto de revisão jurídica. Apague as linhas dos perfis que o projeto não tem.

| Quem avisa | Quem recebe | Quando | Prazo | Canal |
|---|---|---|---|---|
| Nós, como operador | o cliente (controlador) | todo incidente que afete os dados ou o serviço dele | imediatamente, assim que soubermos; se o contrato não fixar prazo, até 24 horas de quando soubemos (proposta) | {{canal do contrato}} |
| Nós, como controlador | ANPD | incidente com risco ou dano relevante aos titulares | 3 dias úteis (6 se formos agente de pequeno porte); complemento fundamentado em até 20 dias úteis da comunicação (40 no pequeno porte) | canal indicado no sítio da ANPD, pelo encarregado, com o documento do vínculo, ou por representante constituído, com o instrumento de poderes, no mesmo prazo |
| Nós, como controlador | titulares afetados | o mesmo incidente | 3 dias úteis (6 se formos agente de pequeno porte); declaração à ANPD até 3 dias úteis depois do fim desse prazo | {{e-mail, aplicativo, carta}} |
| Nós (perfil financeiro) | a instituição cliente | incidente que afete o serviço dela | a tempo de ela registrar, analisar e comunicar o Banco Central de forma tempestiva | {{canal do contrato}} |
| Nós (perfil seguros) | a seguradora cliente | incidente relevante | a tempo de ela comunicar à SUSEP em até 5 dias úteis do conhecimento | {{canal do contrato}} |
| Nós (perfil setor-publico) | o órgão cliente | incidente cibernético contra os serviços ou os dados sob nossa custódia | imediatamente | {{canal do contrato}} |
| Nós (perfil cartoes) | bandeiras e adquirentes | {{conforme os procedimentos das bandeiras}} | {{...}} | {{...}} |

Prazo previsto em legislação específica fica ressalvado (Res. CD/ANPD nº 15/2024, art. 6º, caput). Com a `lgpd-skill` instalada, a avaliação e os rascunhos das seções 5.1 e 5.2 saem da skill `lgpd-incidentes`; sem ela, use as listas abaixo e peça a revisão do encarregado ou de um advogado antes de enviar.

### 5.1 Comunicação à ANPD (só quando somos controlador)

As 12 informações (Res. CD/ANPD nº 15/2024, art. 6º, § 2º):

1. natureza e categoria dos dados pessoais afetados;
2. número de titulares afetados, separando crianças, adolescentes e idosos, quando houver;
3. medidas técnicas e de segurança que protegiam os dados, antes e depois do incidente, sem expor segredo comercial ou industrial;
4. riscos do incidente e possíveis impactos aos titulares;
5. motivos da demora, se a comunicação sair depois do prazo;
6. medidas tomadas ou a tomar para reverter ou mitigar os efeitos sobre os titulares;
7. data da ocorrência, quando for possível saber, e data do conhecimento pelo controlador;
8. dados do encarregado ou de quem represente o controlador;
9. identificação do controlador e, se for o caso, declaração de que é agente de pequeno porte;
10. identificação do operador, quando houver;
11. descrição do incidente, com a causa principal, se for possível identificá-la;
12. total de titulares cujos dados são tratados nas atividades atingidas.

Envio: pelo formulário e no canal que a ANPD indica no sítio dela (hoje, peticionamento eletrônico no SEI!ANPD, com formulário preliminar ou completo), pelo encarregado, com o documento que comprova o vínculo dele, ou por representante constituído, com o instrumento de poderes. Os documentos vão junto, no mesmo prazo; sem eles, a ANPD pode apurar o incidente (Res. CD/ANPD nº 15/2024, art. 6º, §§ 4º a 7º).

### 5.2 Aviso aos titulares (só quando somos controlador)

As 7 informações (Res. CD/ANPD nº 15/2024, art. 9º): natureza e categoria dos dados afetados; medidas técnicas e de segurança que os protegiam; riscos e possíveis impactos aos titulares; motivos da demora, se houver; medidas para reverter ou mitigar os efeitos, quando cabíveis; data do conhecimento do incidente; contato para informações e, quando houver, o do encarregado.

- Linguagem simples; aviso direto e individual pelos meios de costume (telefone, e-mail, mensagem eletrônica ou carta) quando der para identificar os titulares (§§ 1º e 2º).
- Se não der: aviso pelos meios de divulgação de que dispomos, como sítio eletrônico, aplicativos, mídias sociais e canais de atendimento, de modo que permita o conhecimento amplo, por no mínimo 3 meses (§ 3º). Jornal, rádio ou TV só se a ANPD determinar a ampla divulgação (art. 19).
- Recomendações ao titular, como trocar a senha, podem ser consideradas boa prática (§ 5º).

### 5.3 Aviso ao cliente (quando somos operador)

- O que já se sabe e o que ainda está em apuração; data e hora em que soubemos do incidente.
- Natureza do incidente e dados e recursos do cliente afetados; número de titulares afetados e total de titulares nas atividades atingidas, quando soubermos.
- Medidas tomadas e a tomar; medidas recomendadas ao cliente.
- Contato técnico e hora da próxima atualização.
- Não comunicamos a ANPD nem os titulares por conta própria: o controlador decide (LGPD, art. 39).

## 6. Comunicação de crise (IRC-08)

- Porta-voz: {{cargo}} · Substituto: {{cargo}} · Aprova cada mensagem externa: {{responsável pelo incidente, com o jurídico ou o encarregado}}.
- Canais por público: clientes {{...}}; titulares, pelo cliente controlador, ou por nós quando somos controlador {{...}}; reguladores {{...}}; equipe {{...}}; imprensa, só pelo porta-voz.
- Todo aviso diz o que se sabe, o que se fez, o que o cliente deve fazer e quando vem a próxima atualização; com o incidente crítico aberto, atualização ao menos a cada 24 horas (proposta).
- Mensagens-modelo: {{aviso inicial}}, {{atualização}}, {{encerramento}}.
- O que se diz em público sobre os dados de um cliente é combinado com ele.

## 7. Relatório pós-incidente (IRC-05, IRC-10)

Em até 10 dias úteis do encerramento (proposta), para todo incidente crítico ou alto e todo incidente com dado pessoal; escrito sem culpar pessoas. O relatório preenchido é interno: vai para `.security-standard/evidencias/<data>/`. Na cópia deste plano em `docs/seguranca/`, esta seção fica só com o modelo abaixo e, por relatório, a data, o tipo e "relatório interno feito". Acrescente uma linha por relatório, sem regravar as anteriores.

- Código e gravidade: {{INC-AAAA-NN}} · {{gravidade}}
- Linha do tempo: {{detecção, confirmação, conhecimento de dado pessoal afetado, contenção, avisos, recuperação, encerramento}}
- Causa principal: {{causa, ou "não identificada" e o motivo}}
- Impacto em clientes e titulares: {{...}}
- O que funcionou e o que falhou na resposta: {{...}}
- Controles envolvidos: {{ids do catálogo que falharam ou faltaram, ex.: IAM-06}}

| Ação | Dono | Prazo | Situação |
|---|---|---|---|
| {{...}} | {{cargo}} | {{data}} | {{aberta ou feita}} |

## 8. Exercícios e revisões (IRC-06)

O relatório de cada exercício, com o que falhou e as ações, é interno: vai para `.security-standard/evidencias/<data>/`. Na cópia deste plano em `docs/seguranca/`, cada exercício aparece só com a data, o tipo e "relatório interno feito". Acrescente uma linha por exercício, sem regravar as anteriores.

| Data | Tipo (mesa ou técnico) | Cenário | Participantes (cargos) | O que falhou | Ações |
|---|---|---|---|---|---|
| {{data}} | {{mesa}} | {{ex.: vazamento de dados de um cliente com o prazo de aviso correndo}} | {{...}} | {{...}} | {{...}} |

## Anexo A — Lista de contatos (interna; IRC-01, IRC-09)

Este anexo tem nomes e telefones: guarde-o em `.security-standard/contatos-de-incidente.md` e tire-o da cópia de `docs/seguranca/`. Confira os contatos a cada 12 meses e a cada troca (IRC-09).

| Quem | Papel ou organização | Canal (e-mail de grupo, telefone) | Horário | Conferido em |
|---|---|---|---|---|
| {{nome}} | {{papel do plano}} | {{...}} | {{...}} | {{data}} |
| {{contato do cliente que recebe os avisos}} | {{cliente}} | {{...}} | {{...}} | {{data}} |
| {{nosso contato para esse cliente}} | {{cliente}} | {{...}} | {{...}} | {{data}} |
| Suporte do provedor de nuvem | {{provedor}} | {{...}} | {{...}} | {{data}} |
| {{fornecedor crítico}} | {{...}} | {{...}} | {{...}} | {{data}} |
| ANPD | autoridade | canal indicado no sítio da ANPD, pelo encarregado ou por representante constituído, com o documento do vínculo ou o instrumento de poderes | — | {{data}} |
| Canal de segurança publicado (IRC-09) | nós | {{e-mail de grupo ou formulário}} | {{...}} | {{data}} |
