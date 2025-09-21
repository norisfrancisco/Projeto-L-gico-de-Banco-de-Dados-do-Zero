# Desafio de Projeto: Modelagem de Banco de Dados para Oficina Mecânica

Este projeto representa a implementação completa de um banco de dados relacional para o cenário de uma oficina mecânica, desenvolvido como parte do Desafio de Projeto da DIO. O trabalho abrange todo o ciclo de vida do projeto de dados, desde a modelagem lógica até a implementação física com SQL DDL, a população com dados realistas (DML) e a extração de insights através de consultas complexas (DQL).

O ambiente de desenvolvimento foi totalmente conteinerizado com Docker e Docker Compose, utilizando PostgreSQL como SGBD, o que garante um setup limpo, reprodutível e alinhado com as práticas modernas de desenvolvimento.

## Tecnologias e Ferramentas
* **Banco de Dados:** PostgreSQL 15
* **Ambiente:** Docker / Docker Compose
* **Linguagem:** SQL (DDL, DML, DQL)
* **Ferramentas:** VS Code, DBeaver, Git, GitHub

## Modelo Lógico

O esquema do banco de dados foi projetado para refletir as operações de uma oficina, com as seguintes entidades e relacionamentos principais:

* **Clientes e Veículos:** Um cliente pode ter múltiplos veículos, estabelecendo um relacionamento 1-para-N.
* **Equipes e Mecânicos:** A oficina organiza seus `Mecanicos` em `Equipes` especializadas, modelado com um relacionamento N-para-N.
* **Ordem de Serviço (OS):** É a entidade central que conecta um `Veiculo` (e seu `Cliente`) a uma `Equipe` responsável.
* **Serviços e Peças:** Cada Ordem de Serviço pode conter múltiplos `Serviços` (mão de obra) e consumir múltiplas `Peças` (produtos), ambos modelados como relacionamentos N-para-N.
* **Pagamentos:** Cada Ordem de Serviço pode ter um ou mais registros de pagamento associados.

Para uma visualização detalhada, consulte o arquivo `diagrama_relacional_oficina.png` neste repositório.

## Como Executar o Projeto

**Pré-requisitos:** Git e Docker (com Docker Compose) instalados.

**1. Clone o Repositório:**
```bash
git clone [https://github.com/norisfrancisco/Projeto-L-gico-de-Banco-de-Dados-do-Zero]
cd https://github.com/norisfrancisco
```

**2. Inicie o Ambiente Docker:**
Na raiz do projeto, execute o comando abaixo. Ele criará e iniciará um contêiner PostgreSQL com um banco de dados `oficina` pronto para uso.
```bash
docker-compose up -d
```

**3. Conecte com um Cliente SQL:**
Use uma ferramenta como o DBeaver para se conectar ao banco de dados com as seguintes credenciais:
- **Host:** `localhost`
- **Porta:** `5433`
- **Banco de Dados:** `oficina`
- **Usuário:** `admin`
- **Senha:** `password123`

**4. Crie e Popule o Banco de Dados:**
Execute os scripts SQL na seguinte ordem para construir o schema e inserir os dados:
1.  `script_ddl.sql`
2.  `script_dml_oficina.sql`

## Consultas de Exemplo (DQL)

O arquivo `script_dql_oficina.sql` contém consultas complexas para responder a perguntas de negócio, demonstrando o uso de `JOIN`, `GROUP BY`, `HAVING` e Common Table Expressions (CTEs). Exemplos incluem:
* Cálculo do valor total de cada Ordem de Serviço, somando peças e serviços.
* Identificação dos mecânicos mais produtivos com base no número de ordens de serviço concluídas.
