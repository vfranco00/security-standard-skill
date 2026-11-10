# Níveis e perfis

O nível diz até onde o projeto quer chegar; o perfil diz que regras a mais o cliente ou o dado trazem. Os dois decidem que controles do catálogo entram em `lacunas.md` (regra do `SKILL.md`, passo 5). Entre parênteses, as siglas das linhas de `fontes.md`, com URL e data da conferência.

## Os três níveis

Os níveis são cumulativos: Essencial ⊂ Fornecedor ⊂ Big tech. Cada controle tem um `Nível mínimo`, o primeiro nível em que ele é exigido. O projeto tem um nível alvo (`nivel_alvo` no `config.yml`), e entram os controles com nível mínimo até ele.

| Nível | O que é | Referências |
|---|---|---|
| Essencial | O mínimo que um cliente grande exige em contrato e a base legal de qualquer projeto brasileiro. Fica perto do Implementation Group 1 do CIS, que o próprio CIS descreve como higiene cibernética essencial e padrão mínimo emergente para toda empresa, e do que os códigos e guias de grandes empresas para fornecedores repetem. LGPD, Res. CD/ANPD 15/2024 e Marco Civil entram aqui. | `CIS-IG1`; `IFOOD-CODIGO`, `GERDAU-NORMA`, `NATURA-GUIA`, `RAIZEN-CODIGO`; `LGPD`, `ANPD-RES15`, `MARCO-CIVIL` |
| Fornecedor | O que passa numa avaliação de fornecedor: o questionário (CAIQ v4.1, SIG Lite ou SIG Core) e o anexo de segurança, cobrindo os temas do Anexo A da ISO/IEC 27001:2022 e os critérios do SOC 2 (TSC 2017). | `CSA-CCM`, `SIG`, `SIG-FAQ`, `ISO-27001`, `AICPA-TSC` |
| Big tech | Práticas internas que Google, Microsoft e AWS documentam: ninguém com acesso permanente à produção (o acesso é temporário, aprovado e justificado), revisão do código por outra pessoa e build verificável como etapas obrigatórias antes da produção. | `MS-ACESSO`, `GOOG-ACESSO`, `AWS-NITRO`, `GOOG-BAB`, `SLSA` |

### Como escolher o nível alvo

- **Essencial** é o ponto de partida de todo projeto. Enquanto faltar controle Essencial, ele vem antes dos outros no plano.
- **Fornecedor** quando um cliente grande vai avaliar o fornecedor (questionário, anexo de segurança, due diligence, pedido de relatório) ou quando o projeto tem perfil `financeiro`, `seguros` ou `setor-publico`. Nesses três, a norma faz o cliente avaliar o prestador antes de contratar: verificação prévia (Res. CMN 4.893, art. 12), certificação independente ou due diligence (Circular SUSEP 638, art. 10, II, e art. 11, § 1º) e requisitos para habilitar o provedor (IN GSI/PR 5/2021, arts. 20 e 25).
- **Big tech** quando o cliente pede por escrito práticas desse nível, ou quando a empresa decide chegar lá depois de fechar o Fornecedor.
- Sem resposta do usuário: Essencial, com "a confirmar" no `STATUS.md`.

## Os cinco perfis

- Um perfil liga todo controle cujo campo `Perfis` o contém. `todos` marca o controle que vale para qualquer projeto; não é perfil do projeto.
- Sem perfil, entram só os controles `todos`. Um projeto pode ter vários perfis.
- O perfil não passa por cima do nível: controle de perfil com nível mínimo acima do nível alvo fica de fora. Por isso, um controle que a norma do perfil exige de todo fornecedor tem `Nível mínimo: Essencial`, e assim não some de um projeto Essencial que tem o perfil. Nível mais alto só para o que a norma do perfil gradua ou para o que vai além dela.
- `cartoes` e `saude` não têm piso de nível: o projeto pode ficar no Essencial com esses perfis. Com `financeiro`, `seguros` ou `setor-publico`, a skill propõe ao menos Fornecedor (veja "Como escolher o nível alvo").
- Regra de perfil dentro do `Parâmetro`: um controle `todos` pode ter, no trecho de um nível, regra que só vale num perfil ("no perfil X", "só no perfil X"). Exemplo: o IAM-09 é Essencial por causa do perfil `cartoes`, e a regra geral dele começa no Fornecedor.
  - Quando o trecho do nível alvo só traz regra "no perfil X" e o projeto não tem o perfil X, a linha fica `não se aplica`, tipo `declarada` (a lista de perfis é declaração do usuário no `config.yml`), com o motivo "regra só do perfil X".
  - Com o perfil X, a regra do perfil vale em qualquer nível alvo, junto da regra do próprio nível.
- `financeiro`, `seguros` e `setor-publico` vêm do setor do cliente; `cartoes` e `saude` vêm do dado que o sistema trata.
- As normas de `financeiro`, `seguros` e `setor-publico` regulam o cliente, não a software house: obrigam o cliente a exigir do fornecedor o que está abaixo, e é isso que chega no questionário e no contrato. A skill nunca afirma que o fornecedor cumpre a norma.

### `financeiro`

- **Quando ligar:** o cliente é instituição autorizada a funcionar pelo Banco Central, como banco ou financeira (Res. CMN 4.893, art. 1º), ou é instituição de pagamento, corretora ou distribuidora de títulos e valores mobiliários, corretora de câmbio ou prestadora de serviços de ativos virtuais (Res. BCB 85, art. 1º, texto consolidado).
- **Normas:** Res. CMN 4.893/2021 (`CMN-4893`) e Res. BCB 85/2021 (`BCB-85`), as duas no texto consolidado do portal do BCB, que já traz as alterações posteriores, entre elas as das Res. CMN 5.274/2025 (`CMN-5274`) e Res. BCB 538/2025 (`BCB-538`). Os artigos citados abaixo têm o mesmo número e a mesma matéria nos dois textos consolidados.
- **O que o cliente cobra do fornecedor:**
  - antes de contratar serviço relevante de processamento, armazenamento de dados ou nuvem, o que inclui o aplicativo que o prestador executa pela internet com recursos dele (art. 13, III), a instituição verifica se o prestador garante: cumprimento da lei; acesso da instituição aos dados; confidencialidade, integridade, disponibilidade e recuperação; as certificações que a instituição exigir; acesso a relatórios de auditoria independente; informações para monitorar o serviço; segregação dos dados dos clientes da instituição; e qualidade do controle de acesso (art. 12, II). No aplicativo pela internet, a instituição exige do prestador controles que reduzam o efeito de vulnerabilidades na liberação de versões novas (art. 12, § 3º);
  - o contrato prevê, entre outras cláusulas: países e regiões onde os dados ficam; segurança na transmissão e no armazenamento; segregação e controle de acesso; transferência e exclusão dos dados no fim do contrato; acesso a informações, certificações e relatórios de auditoria; aviso de subcontratação de serviço relevante; acesso do Banco Central aos contratos, à documentação, aos dados e às cópias de segurança; e aviso de limitações que afetem o serviço (art. 17);
  - a política de segurança cibernética da instituição traz procedimentos e controles de prevenção e tratamento de incidentes para os prestadores que manuseiam dados ou informações sensíveis ou que são relevantes para as operações da instituição (art. 3º, V, "b"), em nível compatível com o da própria instituição (art. 3º, § 5º).
- **Liga:** os controles com `financeiro` em `Perfis`.

### `seguros`

- **Quando ligar:** o cliente é seguradora, entidade aberta de previdência complementar, sociedade de capitalização ou ressegurador local (Circular SUSEP 638, art. 1º).
- **Normas:** Circular SUSEP 638/2021 (`SUSEP-638`), com a alteração da Res. Susep 90/2026 (`SUSEP-RES90`), que mudou o art. 10, III, e o parágrafo único, e não o art. 11.
- **O que o cliente cobra do fornecedor** (art. 11): cumprir a lei; dar informações e recursos para o monitoramento do serviço; ter processos, procedimentos e controles de segurança cibernética não inferiores aos da própria supervisionada para o mesmo grau de sensibilidade; segregar os dados da supervisionada e dos clientes dela; avisar a subcontratação de serviço relevante; transferir e excluir os dados no fim do contrato; e não embaraçar a SUSEP, que pode consultar os dados, as informações do serviço e os contratos (§ 3º). Em serviço relevante, a supervisionada exige certificação independente do serviço ou faz due diligence (§ 1º). Fora do contrato de adesão, essas exigências vão escritas no contrato (§ 4º).
- **Liga:** os controles com `seguros` em `Perfis`.

### `setor-publico`

- **Quando ligar:** o cliente é órgão ou entidade da administração pública federal que usa solução de computação em nuvem (IN GSI/PR 5/2021, art. 1º). Com outro ente público, pergunte que norma o edital ou o contrato cita.
- **Norma:** IN GSI/PR nº 5/2021 (`GSI-IN5`). A IN fala do "provedor de serviço de nuvem"; confirme com o órgão se ele enquadra o SaaS assim.
- **O que o cliente cobra do fornecedor:**
  - dados hospedados em território brasileiro, com ao menos uma cópia de segurança atualizada no Brasil (art. 18);
  - no contrato: termo de confidencialidade que impede o provedor de usar, transferir ou liberar os dados do órgão a empresas, nacionais ou estrangeiras, e a países ou governos estrangeiros; direitos exclusivos do órgão sobre as informações e as cópias; proibição de usar as informações para propaganda, para otimizar mecanismos de inteligência artificial ou em outro uso secundário não autorizado; política de segurança do provedor de acordo com a lei brasileira; devolução integral e eliminação no fim do contrato (art. 19);
  - do provedor, entre outros requisitos: gestão de riscos; controle de acesso com suporte a MFA e a SSO; testes de invasão periódicos e programa de correção de vulnerabilidades; continuidade e recuperação de desastres; TLS; criptografia que aceite chave gerada e guardada pelo órgão; separação lógica dos dados; descarte seguro; aviso imediato de incidente (art. 20);
  - relatórios SOC 2 tipo I e tipo II de auditoria anual independente (art. 20, XIV), condição para participar da licitação e para renovar o contrato (art. 25).
- **Liga:** os controles com `setor-publico` em `Perfis`.

### `cartoes`

- **Quando ligar:** o sistema armazena, processa ou transmite dados de cartão, ou pode afetar a segurança do ambiente desses dados, por exemplo a página que gera ou embute o formulário de pagamento de um provedor (PCI DSS, Informação de Aplicabilidade; FAQ 1588, para a página com o formulário embutido).
- **Normas:** PCI DSS v4.0.1 (`PCI-DSS`), com a numeração da tradução oficial da v4.0 (`PCI-DSS-PT`); FAQs 1588 e 1293 (`PCI-FAQ-1588`, `PCI-FAQ-1293`). Cabe às bandeiras e aos adquirentes dizer se a empresa precisa cumprir ou validar a conformidade (Informação de Aplicabilidade); a skill não valida.
- **Liga:** os controles com `cartoes` em `Perfis`.

### `saude`

- **Quando ligar:** o sistema trata dado referente à saúde, que a LGPD classifica como dado pessoal sensível (art. 5º, II), por exemplo atestado, exame, laudo ou prontuário.
- **Normas:** LGPD (`LGPD`): dado sensível só se trata nas hipóteses do art. 11. Res. CD/ANPD 15/2024 (`ANPD-RES15`): o incidente pode acarretar risco ou dano relevante quando puder afetar significativamente interesses e direitos fundamentais dos titulares e, cumulativamente, envolver ao menos um critério, entre eles dado pessoal sensível (art. 5º, caput e I).
- **Liga:** os controles com `saude` em `Perfis`. A base legal do tratamento é assunto da `lgpd-skill`, se instalada.
