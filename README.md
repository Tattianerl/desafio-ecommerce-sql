# 📦 Projeto de Banco de Dados para E-commerce

Este projeto tem como objetivo a criação de um banco de dados relacional para um sistema de E-commerce. A modelagem foi realizada com base em conceitos de modelagem conceitual e lógica, utilizando o modelo EER (Entidade-Relacionamento Estendido) e aplicando refinamentos importantes para a representação de um cenário realista e completo.  
[Modelo - EER](./assets/EER-Ecommerce.png)

## 🧠 Contexto do Projeto

O sistema de e-commerce precisa lidar com diferentes tipos de clientes (Pessoa Física e Jurídica), produtos, vendedores, fornecedores, estoques, pagamentos, pedidos e entregas. A modelagem garante integridade referencial e normalização adequada para evitar redundâncias e garantir a consistência dos dados.

## 📐 Estrutura Lógica do Banco

- **Pessoa**: Entidade genérica com dados comuns, como nome, email, telefone e endereço.
- **Pessoa Física e Pessoa Jurídica**: Subtipos exclusivos de pessoa, cada uma com identificadores próprios (CPF e CNPJ).
- **Cliente**: Pode ser uma pessoa física ou jurídica, mas nunca ambas ao mesmo tempo (exclusividade garantida).
- **Vendedor e Fornecedor**: Associados a pessoas jurídicas, com relacionamento separado e reutilização de dados.
- **Produto**: Catálogo com atributos como categoria, preço, estoque e avaliação.
- **Relacionamento Produto x Fornecedor/Vendedor**: Permite múltiplos fornecedores e vendedores para o mesmo produto.
- **Pedido**: Representa uma compra feita por um cliente, com produtos associados.
- **Pagamento**: Cada pedido pode conter um ou mais registros de pagamento.
- **Entrega (Shipping e Delivery)**: Gerencia o processo de envio e entrega do pedido, com rastreamento e status detalhado.
- **Estoque**: Localização e quantidade de produtos disponíveis, com controle atualizado.

## 🛠️ Tecnologias Utilizadas

- SQL padrão (MySQL)
- Modelagem relacional baseada em EER
- Script de criação com constraints (`PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, `ENUM`, etc.)

## 📊 Consultas SQL (queries)

No projeto estão incluídas consultas SQL que respondem perguntas do negócio, como:

- Quantos pedidos foram feitos por cada cliente?
- Algum vendedor também é fornecedor?
- Relação de produtos, fornecedores e seus estoques?
- Quais os nomes dos fornecedores e os produtos fornecidos?

As queries utilizam cláusulas como:

- `SELECT`, `WHERE`, `ORDER BY`, `GROUP BY`, `HAVING`, `JOIN`, `CASE`, `COUNT`, `SUM`, entre outras.

## 🚀 Como Executar

1. Crie um banco de dados no MySQL.
2. Execute o script SQL presente no arquivo `Desafio Ecommerce Sql.sql`.
3. Insira os dados de teste.
4. Execute as queries para validar a estrutura e extrair informações.

## 📝 Licença

Este projeto é parte de um desafio de projeto para prática e avaliação dos conhecimentos em modelagem e SQL.

---
