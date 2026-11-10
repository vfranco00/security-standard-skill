> Gerado pela security-standard-skill em {{data}} · revisar antes de usar

# Checklist de hardening e operação

Documento interno: tem endereços, portas e configuração da produção e fica em `.security-standard/checklist-de-hardening.md`, fora de `docs/seguranca/`. Os ids entre parênteses são os controles da skill `security-infra-operations`; o parâmetro completo de cada nível e de cada perfil está no controle. Nunca escreva aqui senha, chave, token nem outro segredo.

- Projeto: {{projeto}}
- Nível alvo: {{nivel_alvo}} · Perfis: {{perfis}}
- Responsável pelo checklist: {{responsavel}}
- Última conferência completa: {{data_da_conferencia}} · Próxima: {{data_da_proxima_conferencia}}

Em cada linha, situação: `sim`, `parcial`, `não` ou `não se aplica`. Evidência: o arquivo em `.security-standard/evidencias/<AAAA-MM-DD>/` e o tipo (`verificada`, `documento`, `declarada`, ou `—` quando a pergunta ficou sem resposta). Exceção: motivo, dono e data de fim. Linha de nível acima do alvo fica `não se aplica`.

## 1. Inventário e superfície pública (OPS-10, OPS-03)

| Item | Nível | Situação | Evidência e tipo | Exceção |
|---|---|---|---|---|
| Inventário com contas de nuvem, serviços, servidores, bancos, filas, domínios, endereços públicos, repositórios e serviços de terceiros, cada um com dono, ambiente, exposição e classe dos dados, conferido inteiro ao menos a cada 6 meses (OPS-10) | Essencial | {{situação}} | {{evidência}} | {{exceção}} |
| Descoberta automática dos recursos ao menos uma vez por dia, pelas APIs do provedor e pela infraestrutura como código, com detecção de recurso fora do inventário (OPS-10) | Fornecedor | {{situação}} | {{evidência}} | {{exceção}} |
| Lista dos endereços e portas públicos por ambiente: só as portas do serviço público abertas a qualquer origem (numa aplicação web, a 443, com a 80 só redirecionando) (OPS-03) | Essencial | {{situação}} | {{evidência}} | {{exceção}} |
| Nenhuma pasta de controle de versão servida (OPS-03) | Essencial | {{situação}} | {{evidência}} | {{exceção}} |
| WAF na frente da aplicação web e da API, com as regras gerenciadas ligadas (OPS-03) | Essencial | {{situação}} | {{evidência}} | {{exceção}} |
| WAF em modo de bloqueio; depuração, listagem de diretórios, TRACE e documentação interna fechados na produção (OPS-03) | Fornecedor | {{situação}} | {{evidência}} | {{exceção}} |

## 2. Componentes (OPS-01, OPS-08)

Uma linha por tipo de componente: sistema operacional, imagem de contêiner, banco, servidor web, função, serviço gerenciado.

| Componente | Guia adotado (CIS Benchmark ou do fabricante) | Imagem base e registro | Desnecessários desligados e senhas padrão trocadas | Varredura (ferramenta e data) | Atualização automática ou reconstrução | Versão e fim do suporte | Situação | Exceção |
|---|---|---|---|---|---|---|---|---|
| {{componente}} | {{guia}} | {{imagem e registro}} | {{sim, ou o que falta}} | {{ferramenta e data}} | {{como e quando}} | {{versão e data}} | {{situação}} | {{exceção}} |

| Item | Nível | Situação | Evidência e tipo | Exceção |
|---|---|---|---|---|
| Padrão de configuração de cada componente revisto ao menos uma vez por ano ou depois de mudança significativa (OPS-01) | Essencial | {{situação}} | {{evidência}} | {{exceção}} |
| Correções automáticas do sistema operacional e das aplicações ao menos uma vez por mês; nada fora do suporte do fabricante (OPS-08) | Essencial | {{situação}} | {{evidência}} | {{exceção}} |
| Varredura automatizada dos ativos internos ao menos a cada 3 meses e dos expostos à internet ao menos uma vez por mês; vulnerabilidades detectadas corrigidas em ciclo ao menos mensal, nos prazos do DEV-09 (OPS-08) | Fornecedor | {{situação}} | {{evidência}} | {{exceção}} |

## 3. Rede e ambientes (OPS-02, OPS-14)

| Item | Nível | Situação | Evidência e tipo | Exceção |
|---|---|---|---|---|
| Produção numa conta, projeto ou assinatura só dela, com o estado da infraestrutura como código separado por ambiente (OPS-14) | Essencial | {{situação}} | {{evidência}} | {{exceção}} |
| Nenhuma rota, rede compartilhada ou relação de confiança que leve de outro ambiente à produção (OPS-14) | Essencial | {{situação}} | {{evidência}} | {{exceção}} |
| Banco e serviços internos sem endereço público; regras de rede que negam por padrão (OPS-02) | Essencial | {{situação}} | {{evidência}} | {{exceção}} |
| Camadas pública, de aplicação e de dados, com entrada e saída controladas e regras revistas a cada 6 meses (proposta) (OPS-02) | Fornecedor | {{situação}} | {{evidência}} | {{exceção}} |
| Políticas da organização que impedem desligar logs, abrir recurso ao público ou usar região não aprovada (OPS-14) | Fornecedor | {{situação}} | {{evidência}} | {{exceção}} |
| Chamadas entre serviços autenticadas pela identidade do serviço (OPS-02) | Big tech | {{situação}} | {{evidência}} | {{exceção}} |

## 4. Borda: TLS, cabeçalhos, DDoS e limites (OPS-04, OPS-11, OPS-12)

| Item | Nível | Situação | Evidência e tipo | Exceção |
|---|---|---|---|---|
| Todo endpoint público (site, API, painel, subdomínios) no TLS e no HSTS do DAT-03; certificado com renovação automática e alerta de vencimento (OPS-04, DAT-03) | Essencial | {{situação}} | {{evidência}} | {{exceção}} |
| CORS com origem fixa ou lista de origens confiáveis (OPS-04) | Essencial | {{situação}} | {{evidência}} | {{exceção}} |
| CSP global; `nosniff`; Referrer-Policy; `frame-ancestors` (OPS-04) | Fornecedor | {{situação}} | {{evidência}} | {{exceção}} |
| OCSP stapling; CSP por resposta com nonce ou hash e relatório; Cross-Origin-Opener-Policy (OPS-04) | Big tech | {{situação}} | {{evidência}} | {{exceção}} |
| Proteção contra DDoS de rede e de aplicação; origem aceitando só a CDN; roteiro de DDoS no plano de incidentes (OPS-11) | Fornecedor | {{situação}} | {{evidência}} | {{exceção}} |
| Limites de taxa por cliente e por IP em todo endpoint público; limites menores nas operações caras; tamanhos e tempos máximos (OPS-12) | Fornecedor | {{situação}} | {{evidência}} | {{exceção}} |

## 5. Administração (OPS-15)

| Item | Nível | Situação | Evidência e tipo | Exceção |
|---|---|---|---|---|
| Nenhuma porta de SSH, RDP, banco ou painel aberta à internet (OPS-15) | Essencial | {{situação}} | {{evidência}} | {{exceção}} |
| Administração só por canal cifrado com MFA (proxy com identidade, gerenciador de sessões, bastion ou VPN) e nenhum protocolo sem criptografia (OPS-15) | Essencial | {{situação}} | {{evidência}} | {{exceção}} |
| Rotina feita por automação; toda sessão interativa registrada comando a comando (OPS-15) | Fornecedor | {{situação}} | {{evidência}} | {{exceção}} |

## 6. Logs, relógio e alertas (OPS-05, OPS-06, OPS-07)

Uma linha por tipo de log (o inventário dos logs do OPS-05).

| Log | Camada | Destino | Retenção | Disponível para consulta imediata | Quem acessa | Situação |
|---|---|---|---|---|---|---|
| Registros de acesso à aplicação: data, hora, IP e porta de origem (mínimo de 6 meses) | {{camada}} | {{destino}} | {{prazo}} | {{prazo}} | {{pessoas ou papéis}} | {{situação}} |
| {{log}} | {{camada}} | {{destino}} | {{prazo}} | {{prazo}} | {{pessoas ou papéis}} | {{situação}} |

| Item | Nível | Situação | Evidência e tipo | Exceção |
|---|---|---|---|---|
| Logins, falhas de login, ações administrativas e erros de segurança centralizados fora do servidor que os gera (OPS-05) | Essencial | {{situação}} | {{evidência}} | {{exceção}} |
| Registros de conexão por 1 ano, só se a empresa provê conexão à internet (OPS-05) | Essencial | {{situação}} | {{evidência}} | {{exceção}} |
| Cada log excluído quando a finalidade acaba ou o prazo legal termina, com o prazo de cada tipo na tabela de guarda do DAT-08 (OPS-05) | Essencial | {{situação}} | {{evidência}} | {{exceção}} |
| Processo de gestão dos logs (coleta, revisão e retenção) escrito e revisto ao menos uma vez por ano (OPS-05) | Essencial | {{situação}} | {{evidência}} | {{exceção}} |
| Eventos de segurança de todas as camadas por ao menos 90 dias, sem encurtar os 6 meses dos registros de acesso (OPS-05) | Fornecedor | {{situação}} | {{evidência}} | {{exceção}} |
| Logs de segurança por 2 anos, com 6 meses disponíveis (OPS-05) | Big tech | {{situação}} | {{evidência}} | {{exceção}} |
| Relógio sincronizado com o serviço de hora do provedor ou com o NTP.br; logs em UTC ou com o fuso explícito (OPS-06) | Essencial | {{situação}} | {{evidência}} | {{exceção}} |
| Acesso aos registros só por pessoas designadas, com autenticação e registro de cada acesso; registros protegidos contra alteração (OPS-06) | Essencial | {{situação}} | {{evidência}} | {{exceção}} |
| Ao menos duas fontes de hora sincronizadas, onde houver suporte; logs num destino separado e imutável, com alerta quando o envio para (OPS-06) | Fornecedor | {{situação}} | {{evidência}} | {{exceção}} |
| Alertas de indisponibilidade vista de fora, pico de falhas de login, mudança crítica na nuvem, parada do envio de logs e certificado perto de vencer, com o tratamento registrado (OPS-07) | Essencial | {{situação}} | {{evidência}} | {{exceção}} |
| Detecção de ameaças do provedor ligada; alertas correlacionados; plantão definido para os alertas críticos, com escala; logs e eventos de segurança revistos toda semana (OPS-07) | Fornecedor | {{situação}} | {{evidência}} | {{exceção}} |

## 7. Postura da nuvem e infraestrutura como código (OPS-09)

| Item | Nível | Situação | Evidência e tipo | Exceção |
|---|---|---|---|---|
| Ferramenta de postura do provedor ligada em cada conta, conferida a cada 3 meses (proposta), com os críticos corrigidos; linha de base da nuvem e da rede escrita e revista ao menos uma vez por ano (OPS-09) | Essencial | {{situação}} | {{evidência}} | {{exceção}} |
| Infraestrutura como código varrida no CI, com bloqueio em achado crítico ou alto (proposta); postura monitorada de forma contínua (OPS-09) | Fornecedor | {{situação}} | {{evidência}} | {{exceção}} |
| Política da organização que nega a configuração fora do padrão (OPS-09) | Big tech | {{situação}} | {{evidência}} | {{exceção}} |

## 8. Testes: recuperação e intrusão (OPS-13, OPS-16)

| Data | Teste | Escopo e cenário | Quem fez | Resultado (tempo medido contra o RTO do DAT-07, ou achados por gravidade) | Plano de ação | Próximo teste |
|---|---|---|---|---|---|---|
| {{data}} | {{recuperação ou intrusão}} | {{escopo}} | {{equipe ou empresa}} | {{resultado}} | {{ações, donos e prazos}} | {{data}} |

Esta tabela é um registro: numa nova passada, só recebe linhas novas, sem apagar nem reescrever as antigas. O teste de intrusão (OPS-16) entra a partir do Fornecedor, em todo projeto, e já no Essencial com os perfis `financeiro`, `cartoes` ou `setor-publico`. O relatório completo fica em `.security-standard/evidencias/`; ao cliente vai só o resumo executivo.

## 9. O que cada perfil soma

Marque só os perfis do projeto. O detalhe está na linha `Perfil` de cada controle.

| Perfil | O que soma | Controles |
|---|---|---|
| `cartoes` | padrões de configuração do escopo; controles de rede do ambiente de cartão revistos a cada 6 meses; WAF obrigatório; nas transmissões do PAN, só certificados confiáveis, válidos, não vencidos e não revogados, com inventário das chaves e dos certificados; 12 meses de log já no Essencial; servidores de hora designados e logs à prova de alteração; revisão diária e automatizada dos logs; varredura interna e externa (ASV) a cada 3 meses e correção crítica em um mês; inventário do escopo; pré-produção separada; administração cifrada; teste de intrusão interno e externo a cada 12 meses | OPS-01, OPS-02, OPS-03, OPS-04, OPS-05, OPS-06, OPS-07, OPS-08, OPS-10, OPS-14, OPS-15, OPS-16 |
| `financeiro` | segmentação que resguarde a produção; trilhas de auditoria fim a fim, com retenção por tipo de processamento e 5 anos para os registros dos mecanismos de controle, se o cliente pedir; monitoramento de conexões externas e de acesso privilegiado à noite e em dias não úteis; testes, varreduras e correção tempestiva; ciclo de vida dos recursos; o serviço nos testes de continuidade do cliente; MFA no acesso externo; o teste de intrusão anual e independente da instituição cobrindo o serviço | OPS-02, OPS-05, OPS-07, OPS-08, OPS-10, OPS-13, OPS-14, OPS-15, OPS-16 |
| `seguros` | logs das atividades dos usuários, das exceções e das falhas; monitoramento contínuo da rede; redução proativa de vulnerabilidades; o serviço no plano de continuidade do cliente | OPS-05, OPS-07, OPS-08, OPS-13 |
| `setor-publico` | fortalecimento da virtualização; tráfego de gerenciamento separado e dispositivos de segurança entre zonas; firewall especializado; registros guardados 1 ano pelo provedor e 5 anos à escolha do órgão; versões atuais e programa de correção; plano de recuperação de desastres; testes de penetração periódicos | OPS-01, OPS-02, OPS-03, OPS-05, OPS-08, OPS-13, OPS-15, OPS-16 |
