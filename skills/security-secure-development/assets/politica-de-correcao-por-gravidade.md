> Gerado pela security-standard-skill em {{data}} · revisar antes de usar

# Política de correção de vulnerabilidades por gravidade

Empresa: {{nome}} · Sistema: {{sistema}} · Versão: {{1.0}} · Aprovada por {{responsável}} em {{data da aprovação}} · Revista uma vez por ano e quando um prazo for descumprido.

## 1. Objetivo

Definir em quanto tempo corrigimos cada vulnerabilidade conhecida dos nossos sistemas e das dependências deles, e como registramos as exceções.

## 2. Alcance

Código próprio, dependências de terceiros (bibliotecas, imagens de contêiner, actions do CI), infraestrutura e serviços usados por {{sistema}}.

## 3. Gravidade

Usamos a escala qualitativa do CVSS, da FIRST:

| Gravidade | Nota CVSS |
|---|---|
| Crítica | 9,0 a 10,0 |
| Alta | 7,0 a 8,9 |
| Média | 4,0 a 6,9 |
| Baixa | 0,1 a 3,9 |

Achado sem nota publicada recebe a nota de quem faz a triagem, com o vetor CVSS registrado. A vulnerabilidade que está no catálogo KEV da CISA (exploração ativa conhecida) segue as linhas próprias da tabela, qualquer que seja a nota. Para cada CVE, a CISA também publica se a exploração é automatizável e se dá controle total ou parcial do sistema.

## 4. Prazos

Em dias corridos, contados da publicação da correção pelo fornecedor do componente ou da confirmação do achado em código próprio. Nas linhas do KEV, o prazo conta da entrada da vulnerabilidade no catálogo ou da detecção dela no nosso sistema, o que vier primeiro, como na BOD 26-04. Vale a coluna do nível alvo: {{Essencial, Fornecedor ou Big tech}}.

| Situação | Essencial | Fornecedor | Big tech |
|---|---|---|---|
| No KEV, exposta à internet, exploração automatizável ou com controle total | 14 dias | 3 dias | 3 dias, com triagem forense quando há controle total |
| No KEV, sem exposição, exploração automatizável e com controle total | 14 dias | 3 dias | 3 dias, com triagem forense |
| No KEV, demais casos | 14 dias | 14 dias | 14 dias |
| Fora do KEV, crítica | 30 dias | 14 dias | o menor entre 14 dias e o prazo da BOD 26-04 |
| Fora do KEV, alta | 30 dias | 30 dias | o menor entre 30 dias e o prazo da BOD 26-04 |
| Fora do KEV, média | 90 dias | 60 dias | o menor entre 60 dias e o prazo da BOD 26-04 |
| Fora do KEV, baixa | 90 dias | 90 dias | o menor entre 90 dias e o prazo da BOD 26-04 |

Prazo da Tabela 1 da BOD 26-04 da CISA para o que está fora do KEV, usado na coluna Big tech:

| Exposta à internet | Exploração automatizável | Controle | Prazo |
|---|---|---|---|
| sim | sim | total | 3 dias |
| sim | sim | parcial | 14 dias |
| sim | não | total | 14 dias |
| sim | não | parcial | 60 dias |
| não | sim | total ou parcial | 60 dias |
| não | não | total ou parcial | na próxima atualização do sistema |

De onde vêm os números: 30 dias para a crítica é o requisito 6.3.3 da PCI DSS v4.0.1. Os 14 dias para todo o KEV, na coluna Essencial, são o maior prazo que a Tabela 1 da BOD 26-04 da CISA (10/06/2026) dá a uma vulnerabilidade do catálogo; os dias das linhas do KEV nas colunas Fornecedor e Big tech e os prazos da BOD na coluna Big tech vêm das linhas da Tabela 1. A triagem forense que a tabela pede em alguns casos fica só na coluna Big tech. Os demais números, e essa divisão entre as colunas, são escolha desta política. A PCI DSS obriga quem trata cartão e a BOD 26-04 obriga órgãos federais dos EUA: aqui as duas servem de régua.

## 5. Exceções

Quando não for possível corrigir no prazo:

1. registre a exceção com o identificador da vulnerabilidade, o motivo, a medida que reduz o risco enquanto isso, o dono e a data de fim;
2. a exceção vale no máximo {{90 dias}} e é aprovada por {{responsável}};
3. em vulnerabilidade do KEV ou crítica, avise {{responsável}} no mesmo dia;
4. guarde a exceção em arquivo versionado (por exemplo, `osv-scanner.toml`, com motivo e data de fim) ou no rastreador de issues;
5. o registro de exceções só recebe entradas novas: a exceção encerrada ganha a data real de fim, sem que a linha seja apagada.

## 6. Responsáveis

- Triagem e nota de gravidade: {{papel}}.
- Correção: o time dono do componente.
- Acompanhamento dos prazos e relatório mensal: {{papel}}.

## 7. Medida

Todo mês: vulnerabilidades abertas por gravidade, quantas passaram do prazo, exceções em vigor e tempo médio de correção por gravidade.
