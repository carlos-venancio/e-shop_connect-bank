USE eshop_connect;
SELECT * FROM product;


DELIMITER \

# 1 - Crie  uma  stored  procedure  que  retorne  todos  os  usuários  que  são compradores.

CREATE PROCEDURE getBuyer()

BEGIN 
	SELECT * FROM users 
    WHERE pk_userId IN (SELECT * FROM buyer);
END\

CALL getBuyer\

# 2 - Crie uma stored procedure que insira um novo produto na tabela Product.

CREATE PROCEDURE insertProduct(
	IN p_fk_sid	INT,
    IN p_name		VARCHAR(80),
    IN p_fk_brand VARCHAR(20),
    IN p_type     VARCHAR(20),
    IN p_amount 	INT,
    IN p_price	DECIMAL(10,2),
    IN p_color 	VARCHAR(20),
    IN p_modelNumber VARCHAR(50)
)
BEGIN
	INSERT INTO product (fk_sid, name,fk_brand, type, amount, price, color, modelNumber) VALUES (p_fk_sid, p_name,p_fk_brand, p_type, p_amount, p_price, p_color, p_modelNumber);
END\


CALL insertProduct(8,"SmartWatch Microsoft","Microsoft","relógio", 20, 25000,"black", "95096090")\

# 3 - Crie uma stored procedure que atualize a quantidade de um produto com base no seu ID.

CREATE PROCEDURE updateQuantify(
	IN p_amount INT,
    IN p_pk_pid INT
)

	BEGIN
		UPDATE product
		SET amount = p_amount
		WHERE pk_pid = p_pk_pid;
        
        SELECT * 
        FROM product
		WHERE pk_pid = p_pk_pid;
	END\

CALL updateQuantify(10,1)\

# 4 - Crie uma stored procedure que retorne o total de vendas para uma loja específica.
CREATE PROCEDURE totalVendasPorLoja(
	IN p_fk_sid INT
)
BEGIN 
	SELECT SUM(c.quantity * amount) as total_vendas
	FROM product
	JOIN order_item AS oi ON oi.fk_pid = pk_pid
	JOIN contain AS c ON c.fk_itemId = oi.pk_itemId
	WHERE fk_sid = p_fk_sid;
END\

CALL totalVendasPorLoja(8)\

# 5 - Crie  uma  stored  procedure  que  liste  todos  os  produtos  de  uma determinada marca.

CREATE PROCEDURE produtoDeMarca(
	IN p_fk_brand VARCHAR(20)
)

BEGIN
	SELECT name, fk_brand
	FROM product
    WHERE lower(fk_brand) = lower(p_fk_brand);
END\

CALL produtoDeMarca('Microsoft')\

# 6 - Crie  uma  stored  procedure  que  insira  um  novo  comentário  de  um comprador para um produto.

CREATE PROCEDURE addComment(
	IN p_fk_userId INT,
    IN p_fk_pid INT,
    IN p_grade FLOAT,
    IN p_content VARCHAR(300)
)

BEGIN
	INSERT INTO comments (creationTime,fk_userId,fk_pid,grade,content)
    VALUES (NOW(),p_fk_userId, p_fk_pid, p_grade, p_content);
    
    SELECT * 
    FROM comments
    ORDER BY creationTime DESC;
END\

CALL addComment(5,1,4.5, "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum elementum est in auctor aliquet. Mauris ullamcorper vel est id vulputate. Aenean pretium mauris a lectus feugiat, ac eleifend leo rutrum.")\

# 7 - Crie uma stored procedure que retorne todos os pedidos feitos por um comprador específico.

CREATE PROCEDURE pedidoUser(
	IN p_fk_usderId INT
)

BEGIN		
	SELECT *
	FROM bank_card 
	JOIN payment ON fk_cardNumber = pk_cardNumber
	JOIN orders AS o ON pk_orderNumber = fk_orderNumber
	WHERE pk_cardNumber IN (
		SELECT pk_cardNumber
		FROM (
			SELECT fk_userId, pk_cardNumber
			FROM credit_card
			UNION
			SELECT fk_userId, pk_cardNumber
			FROM debit_card
		) as cartoes
		WHERE fk_userId = p_fk_userId
	);
END\

CALL pedidoUser (5)\


-- 8. Crie uma stored procedure que cancele um pedido com base no número do pedido.

CREATE PROCEDURE toCancelOrder(
	IN p_pk_orderNumber INT
)

BEGIN
	UPDATE orders
    SET paymentState = 'canceled'
    WHERE pk_orderNumber = p_pk_orderNumber;
    
    SELECT * 
    FROM orders
    WHERE pk_orderNumber = p_pk_orderNumber;
END\

CALL toCancelOrder(12992012)\

-- 9. Crie uma stored procedure que retorne o total de itens em um pedido específico.

CREATE PROCEDURE amountOrder (
	IN p_pk_orderNumber INT
)

BEGIN    
    SELECT SUM(quantity)
    FROM contain
    WHERE pk_orderNumber = p_pk_orderNumber;
END\

CALL amountOrder(93042135)\

-- 10. Crie uma stored procedure que liste todos os produtos em estoque em uma determinada loja.

CREATE PROCEDURE productsStore (
	IN p_fk_sid INT
)

BEGIN    
    SELECT *
    FROM product
    WHERE fk_sid = p_fk_sid AND 
		  amount > 0;
END\

CALL productsStore(8)\


-- 11. Crie uma stored procedure que retorne o nome e a avaliação média de um produto específico.

CREATE PROCEDURE productGrade(
	IN p_pk_pid INT
)
BEGIN
	SELECT name, ROUND(AVG(grade),2) AS 'avaliacao_media'
    FROM product
    JOIN comments ON pk_pid = fk_pid
    WHERE fk_pid = 1;
END\

CALL productGrade(1)\


-- 12. Crie uma stored procedure que atualize o número de pontos de serviço de uma marca específica.

CREATE PROCEDURE increaseServicePoints(
    IN p_streetaddr		VARCHAR(40),
    IN p_city			VARCHAR(30),
    IN p_province 		VARCHAR(20),
    IN p_startTime		TIME,
    IN p_endTime			TIME,
    IN p_fk_brand			VARCHAR(20)
)

BEGIN
	INSERT INTO Service_Point(streetaddr,city,province,startTime,endTime) VALUES(p_streetaddr,p_city,p_province,p_startTime,p_endTime);
    
    INSERT INTO After_Sales_Service_At VALUES (p_fk_brand, (SELECT MAX(pk_spid) FROM Service_Point));
    
    SELECT * FROM After_Sales_Service_At;
END\

CALL increaseServicePoints('37 Sherbrook Street','Montreal','Quebec',CURRENT_TIME,'05:00:00','DELL')\

-- 13. Crie uma stored procedure que liste todos os pedidos feitos com um determinado cartão de crédito.

CREATE PROCEDURE listProductsByCard(
    IN p_fk_cardNumber		VARCHAR(25)
)

BEGIN   
    SELECT * 
    FROM orders
    JOIN payment ON pk_orderNumber = fk_orderNumber
    JOIN credit_card ON fk_cardNumber = pk_cardNumber
    WHERE pk_cardNumber = p_fk_cardNumber;
END\

CALL listProductsByCard('9238 2749 5738 5921')\

-- 14. Crie uma stored procedure que retorne o endereço de entrega de um pedido específico.

CREATE PROCEDURE checkOrderAddress(
    IN p_pk_orderNumber		INT
)

BEGIN   
	SELECT pk_orderNumber, streetAddr
    FROM orders
    JOIN deliver_to ON fk_orderNumber = pk_orderNumber
    JOIN address ON fk_addrid = pk_addrid
    WHERE pk_orderNumber = p_pk_orderNumber;
END\

CALL checkOrderAddress(12992012)\

-- 15. Crie uma stored procedure que retorne o nome e a quantidade total de produtos de uma determinada marca em todas as lojas.

CREATE PROCEDURE totalQuantityOfProducts(
    IN p_brand		VARCHAR(20)
)

BEGIN   
	SELECT p_brand, SUM(amount) As total
    FROM product
    WHERE fk_brand = p_brand;
END\

CALL totalQuantityOfProducts('Microsoft')\

DELIMITER ;

-- Lista de exercícios – Criação de Views

-- 1. View que lista o nome e número de telefone de todos os usuários.
CREATE VIEW view_users_contact AS
SELECT name, phoneNumber
FROM users;

SELECT * FROM view_users_contact;

-- 2. View que mostra os detalhes dos produtos, incluindo nome, tipo, e preço.
CREATE VIEW view_product_details AS
SELECT name, type, price
FROM product;

SELECT * FROM view_product_details;

-- 3. View que exibe os comentários dos compradores, incluindo nome do comprador, nome do produto e conteúdo do comentário.
CREATE VIEW view_buyer_comments AS
SELECT users.name AS buyer_name, product.name AS product_name, comments.content AS comment_content
FROM comments
JOIN users ON comments.fk_userId = users.pk_userId
JOIN product ON comments.fk_pid = product.pk_pid;

SELECT * FROM view_buyer_comments;

-- 4. View que mostra informações de entrega, incluindo endereço, cidade e data de entrega.
CREATE VIEW view_delivery_info AS
SELECT address.streetAddr, address.city, deliver_to.timeDelivered
FROM address
JOIN deliver_to ON address.pk_addrid = deliver_to.fk_addrid;

SELECT * FROM view_delivery_info;

-- 5. View que lista todas as lojas com suas classificações de cliente.
CREATE VIEW view_store_ratings AS
SELECT store.name, store.customerGrade
FROM store;

SELECT * FROM view_store_ratings;

-- 6. View que mostra os produtos agrupados por marca, incluindo a contagem de produtos em cada marca.
CREATE VIEW view_products_by_brand AS
SELECT fk_brand, COUNT(pk_pid) AS product_count
FROM product
GROUP BY fk_brand;

SELECT * FROM view_products_by_brand;

-- 7. View que exibe os pedidos com detalhes de pagamento, incluindo número do pedido, estado de pagamento e método de pagamento.
CREATE VIEW view_order_payment_details AS
SELECT orders.pk_orderNumber, orders.paymentState, payment.fk_cardNumber
FROM orders
JOIN payment ON orders.pk_orderNumber = payment.fk_orderNumber;

SELECT * FROM view_order_payment_details;

-- 8. View que lista os produtos em estoque, incluindo nome, quantidade e preço.
CREATE VIEW view_stock_products AS
SELECT product.name, product.amount, product.price
FROM product;

SELECT * FROM view_stock_products;

-- 9. View que mostra a quantidade total de itens em cada pedido.
CREATE VIEW view_total_items_per_order AS
SELECT orders.pk_orderNumber, SUM(contain.quantity) AS total_items
FROM orders
JOIN contain ON orders.pk_orderNumber = contain.pk_orderNumber
GROUP BY orders.pk_orderNumber;

SELECT * FROM view_total_items_per_order;

-- 10. View que exibe o total de vendas por loja, incluindo nome da loja e total de vendas.
CREATE VIEW view_total_sales_per_store AS
SELECT store.name AS store_name, SUM(orders.totalAmount) AS total_sales
FROM store
JOIN manager ON store.pk_sid = manager.fk_sid
JOIN orders ON manager.pk_userId = orders.pk_orderNumber
GROUP BY store.name;

SELECT * FROM view_total_sales_per_store;

-- 11. View que lista os produtos com suas avaliações médias.
CREATE VIEW view_product_avg_ratings AS
SELECT product.name, AVG(comments.grade) AS avg_rating
FROM product
LEFT JOIN comments ON product.pk_pid = comments.fk_pid
GROUP BY product.name;

SELECT * FROM view_product_avg_ratings;

-- 12. View que exibe informações de cartão de crédito, incluindo número do cartão e data de validade.
CREATE VIEW view_credit_card_info AS
SELECT credit_card.pk_cardNumber, credit_card.expiryDate
FROM credit_card;

SELECT * FROM view_credit_card_info;

-- 13. View que lista as marcas e a quantidade total de produtos de cada marca.
CREATE VIEW view_brand_product_count AS
SELECT brand.pk_brandName, COUNT(product.pk_pid) AS product_count
FROM brand
LEFT JOIN product ON brand.pk_brandName = product.fk_brand
GROUP BY brand.pk_brandName;

SELECT * FROM view_brand_product_count;

-- 14. View que mostra os produtos mais caros, incluindo nome e preço.
CREATE VIEW view_expensive_products AS
SELECT product.name, product.price
FROM product
ORDER BY product.price DESC
LIMIT 10; -- Exemplo: Mostra os 10 produtos mais caros.

SELECT * FROM view_expensive_products;

-- 15. View que exibe as informações de gerenciamento de loja, incluindo nome do vendedor e nome da loja.
CREATE VIEW view_store_management_info AS
SELECT users.name AS seller_name, store.name AS store_name
FROM users
JOIN manager ON users.pk_userId = manager.pk_userId
JOIN store ON manager.fk_sid = store.pk_sid;

SELECT * FROM view_store_management_info;

-- SELECT table_name
-- FROM information_schema.views
-- WHERE table_schema = DATABASE();

SELECT * FROM orders; -- WHERE fk_cardNumber = '4902 9212 3402 8831';
SHOW COLUMNS FROM orders;

SHOW PROCEDURE STATUS;
DROP PROCEDURE totalQuantityOfProducts;
DROP PROCEDURE insertProduct;
