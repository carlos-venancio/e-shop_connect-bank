# E-Shop Connect - Sistema de Comércio Eletrônico

A E-ShopConnect, é uma empresa de comércio eletrônico deseja criar um banco de dados para
gerenciar suas operações. Eles lidam com a venda de uma ampla variedade de produtos de várias lojas.
Eles têm compradores registrados, vendedores registrados e uma variedade de produtos em oferta.
Cada compra é registrada como um pedido contendo itens individuais.
A empresa deseja armazenar informações sobre cartões bancários associados aos compradores para
processar os pagamentos. Existem dois tipos de cartões bancários: cartões de crédito e cartões de
débito.
A empresa também coleta informações de endereço dos compradores para efetuar a entrega dos
produtos.
Você contratado pela empresa para projetar e criar o banco de dados para a empresa de comércio
eletrônico com as entidades e relacionamentos fornecidos. Você deve garantir que as chaves primárias
e estrangeiras sejam definidas corretamente, além de cuidar das relações entre as entidades. Além
disso, também deve estar preparado para realizar consultas, como buscar todos os pedidos de um
determinado comprador ou calcular o valor total de um pedido. Eles podem criar consultas para
recuperar informações sobre os produtos mais vendidos, avaliações de clientes e detalhes das lojas.

## Consultas realizadas
 * Consultar todos os produtos existentes na loja;
 * Consultar os nomes de todos os usuários;
 * Consultar as lojas que vendem produtos;
 * Consultar os endereços relacionando com os clientes;
 * Consultar todos os produtos do tipo laptop;
 * Consultar o endereço, hora de inicio (start time) e hora final (end time) dos pontos de serviço da mesma cidade que o usuário cujo ID é 5.
 * Consultar a quantidade total de produtos que foram colocados no carrinho (shopping cart), considerando a loja com ID (sid) igual a 8.
 * Consultar os comentários do produto 123456789.

## Descrição das tabelas
 
 ### 1. Tabela User: Armazena informações básicas sobre os usuários registrados no sistema, incluindo compradores e vendedores.
 
 User (userId, name, phoneNum):
 
 userId: Chave primária, identificador único do usuário.
 name: Nome do usuário.
 phoneNum: Número de telefone do usuário
 
 ### 2. Tabela Buyer: Relaciona os usuários como compradores.
 
 Buyer (userId):
 
 userId: Chave estrangeira referenciando a tabela "User". 

### 3. Tabela Seller: Relaciona os usuários como vendedores.
 
 Seller (userId):
 
 userId: Chave estrangeira referenciando a tabela "User".

 ### 4. Tabela Bank Card: Armazena informações sobre os cartões bancários associados aos compradores.
 
 Bank Card (cardNumber, userId, bank, expiryDate):
 
 cardNumber: Chave primária, número do cartão bancário.
 bank: Nome do banco associado ao cartão.
 expiryDate: Data de validade do cartão. 

### 5. Tabela Credit Card: Armazena informações específicas sobre os cartões de crédito.
 
 Credit Card (cardNumber, organization):

 cardNumber: Chave primária, número do cartão de crédito. 
userId: Chave estrangeira referenciando a tabela "User".
 organization: Organização emissora do cartão. 
 
### 6. Tabela Debit Card: Armazena informações específicas sobre os cartões de débito.
 
 Debit Card (cardNumber):
 
 cardNumber: Chave primária, número do cartão de débito. 
userId: Chave estrangeira referenciando a tabela "User".
 organization: Organização emissora do cartão. 
 
### 7. Tabela Store: Representa informações sobre as lojas que vendem os produtos.
 
 Store (sid, name, startTime, customerGrade, streetAddr, city, province):
 
 sid: Chave primária, identificador único da loja.
 name: Nome da loja.
 startTime: Horário de funcionamento da loja.
 customerGrade: Classificação da loja pelos clientes.
 streetAddr: Endereço da rua da loja.
 city: Cidade da loja.
 province: Província/estado da loja.
 
 ### 8. Tabela Product: Armazena detalhes sobre os produtos oferecidos pelas lojas. 
 
Product (pid, sid, name, brand, type, amount, price, color, modelNumber):
 pid: Chave primária, identificador único do produto.
 sid: Chave estrangeira referenciando a tabela "Store".
 name: Nome do produto.
 brand: Marca do produto.
 type: Tipo/categoria do produto.
 amount: Quantidade disponível do produto.
 price: Preço do produto. 
color: Cor do produto. 
modelNumber: Número do modelo do produto. 

### 9. Tabela Order Item: Registra os itens individuais presentes em um pedido junto com seus preços. 

Order Item (itemid, pid, price, creationTime): 

itemid: Chave primária, identificador único do item do pedido.
 pid: Chave estrangeira referenciando a tabela "Product".
 price: Preço do item no pedido.
 creationTime: Horário de criação do item do pedido. 
 
### 10. Tabela Order: Registra informações sobre os pedidos feitos pelos compradores, incluindo status de pagamento e valor total.

 Order (orderNumber, creationTime, paymentStatus, totalAmount):
 
 orderNumber: Chave primária, identificador único do pedido.
 creationTime: Horário de criação do pedido.
 paymentStatus: Status de pagamento do pedido.
 totalAmount: Valor total do pedido. 
 
### 11. Tabela Address: Armazena os endereços de entrega dos compradores.

 Address (addrid, userid, name, city, postalCode, streetAddr, province, contactPhoneNumber):
 
 addrid: Chave primária, identificador único do endereço.
 userid: Chave estrangeira referenciando a tabela "User".
 name: Nome associado ao endereço.
 city: Cidade do endereço.
 postalCode: Código postal do endereço.
 streetAddr: Endereço da rua.
 province: Província/estado do endereço.
 contactPhoneNumber: Número de telefone de contato no endereço
 
 ### 12. Tabela Brand: Armazena os nomes das marcas do produtos.

 Brand(brandName):
 
 brandName: Chave primária, identificador das marcas.
 
 ### 13. Tabela Comments: é uma tabela que parece estar relacionada a comentários feitos por usuários sobre produtos específicos em um sistema de comércio eletrônico. Vou descrever essa tabela com base nas informações fornecidas:
 
 creationTime: Esta coluna armazena a data e hora em que o comentário foi criado. É uma
 informação obrigatória (NOT NULL).
 userid: Esta coluna armazena o identificador único do usuário que fez o comentário. É uma
 informação obrigatória (NOT NULL) e funciona como uma chave estrangeira que se refere à tabela
 "Buyer" para identificar o usuário.
 pid: Esta coluna armazena o identificador único do produto sobre o qual o comentário foi feito. É
 uma informação obrigatória (NOT NULL) e funciona como uma chave estrangeira que se refere à
 tabela "Product" para identificar o produto.
 grade: Esta coluna pode armazenar uma pontuação ou classificação atribuída ao produto no
 comentário. É do tipo FLOAT e pode conter valores decimais.
 content : Esta coluna armazena o conteúdo do comentário feito pelo usuário. É uma coluna de texto
 com um limite de 500 caracteres.
 
 ### 14. Tabela ServicePoint: parece ser destinada a armazenar informações sobre pontos de serviço ou locais de atendimento em algum contexto. Vou descrevê-la com base nas informações fornecidas:
 
 spid (INT NOT NULL): Esta coluna armazena o identificador único do ponto de serviço. É uma
 informação obrigatória (NOT NULL) e serve como a chave primária da tabela, garantindo a unicidade
 de cada registro.
 streetaddr: Esta coluna armazena o endereço da rua onde o ponto de serviço está localizado. É uma
 coluna de texto com um limite de 40 caracteres.
 city : Esta coluna armazena o nome da cidade onde o ponto de serviço está localizado. É uma
 coluna de texto com um limite de 30 caracteres.
 province: Esta coluna armazena o nome da província ou estado onde o ponto de serviço está
 localizado. É uma coluna de texto com um limite de 20 caracteres.
startTime: Esta coluna armazena o horário de abertura ou início de operação do ponto de serviço. É
 uma coluna de texto com um limite de 20 caracteres. Pode representar o horário de início do
 atendimento.
 endTime: Esta coluna armazena o horário de encerramento ou fim de operação do ponto de serviço.
 É uma coluna de texto com um limite de 20 caracteres. Pode representar o horário de encerramento
 do atendimento.
 
 ### 15. Tabela Save_to_Shopping_Cart: deve ser projetada para rastrear informações relacionadas à adição de produtos ao carrinho de compras de usuários em um sistema de comércio eletrônico.

 userid: Esta coluna armazena o identificador único do usuário que está adicionando itens ao
 carrinho de compras. É uma informação obrigatória (NOT NULL) e serve como chave estrangeira
 que se refere à tabela "Buyer" para identificar o usuário.
 pid: Esta coluna armazena o identificador único do produto que está sendo adicionado ao carrinho
 de compras. É uma informação obrigatória (NOT NULL) e serve como chave estrangeira que se
 refere à tabela "Product" para identificar o produto.
 addTime: Esta coluna armazena a data em que o produto foi adicionado ao carrinho de compras.
 Ela registra o momento em que a ação ocorreu.
 quantity: Esta coluna armazena a quantidade do produto que foi adicionada ao carrinho de
 compras. Indica quantas unidades do produto foram selecionadas.
 
 ### 16. Tabela Contain: deve ser destinada a registrar informações sobre os itens contidos em um pedido (order) em um sistema de gerenciamento de pedidos.
 
 orderNumber: Esta coluna armazena o número de identificação único do pedido ao qual os itens
 estão associados. É uma informação obrigatória (NOT NULL) e serve como chave estrangeira que
 se refere à tabela "Orders" para identificar o pedido ao qual os itens pertencem.
 itemid: Esta coluna armazena o número de identificação único do item que está sendo adicionado
 ao pedido. É uma informação obrigatória (NOT NULL) e serve como chave estrangeira que se refere
 à tabela "OrderItem" para identificar o item específico.
 quantity: Esta coluna armazena a quantidade do item que foi incluída no pedido. Indica quantas
 unidades do item estão presentes no pedido.
 
 ### 17. Tabela Payment: deve ser projetada para registrar informações sobre pagamentos feitos em um sistema de gerenciamento de pedidos, onde os pagamentos são associados a números de pedido e a números de cartão de crédito. Vou descrevê-la com base nas informações fornecidas:
 
 orderNumber (INT NOT NULL): Esta coluna armazena o número de identificação único do pedido ao
 qual o pagamento está associado. É uma informação obrigatória (NOT NULL) e serve como chave
 estrangeira que se refere à tabela "Orders" para identificar o pedido ao qual o pagamento pertence.
 creditcardNumber (VARCHAR(25) NOT NULL): Esta coluna armazena o número de cartão de crédito
 utilizado para efetuar o pagamento. É uma informação obrigatória (NOT NULL) e é do tipo VARCHAR
 com um limite de 25 caracteres, o que é adequado para armazenar números de cartão de crédito.
 payTime (DATE): Esta coluna armazena a data em que o pagamento foi efetuado. Ela registra o
 momento em que a transação de pagamento ocorreu.
 
 ### 18. Tabela Deliver_To: deve ser destinada a registrar informações sobre a entrega de pedidos a endereços específicos em um sistema de gerenciamento de pedidos. Vou descrevê-la com base nas informações fornecidas:
 
 addrid (INT NOT NULL): Esta coluna armazena o identificador único do endereço ao qual o pedido
 está sendo entregue. É uma informação obrigatória (NOT NULL) e serve como chave estrangeira
 que se refere à tabela "Address" para identificar o endereço de entrega.
 orderNumber (INT NOT NULL): Esta coluna armazena o número de identificação único do pedido
 que está sendo entregue. É uma informação obrigatória (NOT NULL) e serve como chave
 estrangeira que se refere à tabela "Orders" para identificar o pedido em questão.
 TimeDelivered (DATE): Esta coluna armazena a data em que o pedido foi efetivamente entregue no
 endereço especificado. Ela registra o momento da entrega.
 
### 19. Tabela Manage: deve estar relacionada à gestão de lojas (stores) por parte de vendedores (sellers) em um sistema. Vou descrevê-la com base nas informações fornecidas:

 userid (INT NOT NULL): Esta coluna armazena o identificador único do vendedor que está
 gerenciando a loja. É uma informação obrigatória (NOT NULL) e serve como chave estrangeira que
 se refere à tabela "Seller" para identificar o vendedor.
 sid (INT NOT NULL): Esta coluna armazena o identificador único da loja que está sendo gerenciada
 pelo vendedor. É uma informação obrigatória (NOT NULL) e, com base na sua descrição, deve
 funcionar como uma chave estrangeira que se refere à tabela "Store" para identificar a loja.
SetUpTime (DATE): Esta coluna armazena a data em que o vendedor iniciou ou configurou o
 gerenciamento da loja. Ela registra o momento em que a ação ocorreu.
 
 ### 20. Tabela After_Sales_Service_At: deve estar relacionada a informações sobre locais de serviço pós venda para determinadas marcas em pontos de serviço específicos. Vou descrevê-la com base nas  informações fornecidas:
 
 brandName (VARCHAR(20) NOT NULL): Esta coluna armazena o nome da marca para a qual o
 serviço pós-venda está disponível em um ponto de serviço específico. É uma informação obrigatória
 (NOT NULL).
 spid (INT NOT NULL): Esta coluna armazena o identificador único do ponto de serviço onde o
 serviço pós-venda para a marca é oferecido. É uma informação obrigatória (NOT NULL) e serve
 como chave estrangeira que se refere à tabela "ServicePoint" para identificar o ponto de serviço
 específico.
