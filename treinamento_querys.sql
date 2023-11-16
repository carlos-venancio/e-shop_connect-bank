-- 1.Selecione todos os nomes e números de telefone dos usuários.

SELECT userName, phoneNumber FROM users;

-- 2.Liste os nomes dos compradores.

SELECT userName FROM users 
WHERE userId IN (SELECT * FROM buyer); 

-- 3.Liste os nomes dos vendedores.

SELECT userName FROM users 
WHERE userId IN (SELECT * FROM seller); 

-- 4.Encontre todas as informações de cartão de crédito dos usuários.

SELECT bank.cardNumber, bank.expiryDate, bank.bank, credito.userId, credito.organizationBank 
FROM bankcard AS bank 
JOIN creditcard AS credito ON bank.cardNumber = credito.cardNumber;

-- ex 4.2
SELECT bank.cardNumber, bank.expiryDate, bank.bank, debito.userId
FROM bankcard AS bank
JOIN debitcard AS debito ON bank.cardNumber = debito.cardNumber;

-- 5.Selecione os nomes dos produtos e seus preços.

SELECT pName, price FROM product;

-- 6.Liste  todos  os  produtos  de  uma  determinada  marca  (por  exemplo, "Samsung").

SELECT * FROM product WHERE brand = "Asus";

-- 7.Encontre o número de itens em cada pedido.

SELECT pk_orderNumber as 'pedido', SUM(quantity) as 'qtd_itens'
FROM contain 
GROUP BY pk_orderNumber;

-- 8.Calcule o total de vendas por loja

SELECT 	fk_sid, 
		s.name, 
		COUNT(*) 
FROM payment as p
JOIN contain as c	 ON c.pk_orderNumber = p.fk_orderNumber
JOIN order_item as oi ON oi.pk_itemId = c.fk_itemid
JOIN product as pd ON pd.pk_pid = oi.fk_pid
JOIN store as s ON s.pk_sid = pd.fk_sid
GROUP BY pd.fk_sid;

SELECT * FROM Store;
-- 9.Liste as avaliações dos produtos (grade) com seus nomes e conteúdo de usuário.

SELECT p.name, cmm.grade, cmm.content
FROM comments as cmm
INNER JOIN product as p
ON p.pk_pid = fk_pid;


-- 10.Selecione os nomes dos compradores que fizeram pedidos.

SELECT DISTINCT u.name as "Nome do comprador"
FROM payment as p
INNER JOIN credit_card as cc ON cc.pk_cardNumber = p.fk_cardNumber
INNER JOIN users as u ON u.pk_userId = cc.fk_userId;

-- 11.Encontre os vendedores que gerenciam várias lojas.

SELECT 	u.name,
		COUNT(m.fk_sid) as TOTAL
FROM users as u
INNER JOIN seller 	as s 	ON s.pk_userId = u.pk_userId
INNER JOIN manager 	as m 	ON s.pk_userId = m.pk_userId
GROUP BY u.name
HAVING TOTAL > 1;

-- 12.Liste os nomes das lojas que oferecem produtos de uma determinada marca (por exemplo, "Apple").

SELECT DISTINCT 
	s.pk_sid, 
    s.name 
FROM store as s 
INNER JOIN product AS p ON fk_sid = s.pk_sid
WHERE p.fk_brand = 'Microsoft';

-- 13.Encontre  as  informações  de  entrega  de  um  pedido  específico  (por exemplo, orderNumber = 123).

SELECT 	d.fk_orderNumber,
		a.name,
        a.city,
        a.contactPhoneNumber,
        a.streetAddr as 'Rua',
        a.postalCode
FROM deliver_to as d
INNER JOIN address as a ON a.pk_addrid = d.fk_addrid
WHERE fk_orderNumber LIKE 12992012;

-- 14.Calcule o valor médio das compras dos compradores.

SELECT AVG(totalAmount) as TOTAL
FROM orders
WHERE paymentState = 'paid';

-- 15.Liste as marcas que têm pontos de serviço em uma determinada cidade (por exemplo, "Nova York").

SELECT DISTINCT 
				ass.fk_brandName, 	
                sp.city 
FROM after_sales_service_at as ass -- pega as marcas que venderam os produtos
INNER JOIN service_point as sp ON sp.pk_spid = ass.fk_spid -- pega a city que foi feita a transação
WHERE SP.city = 'Montreal';


-- 16.Encontre o nome e o endereço das lojas com uma classificação de cliente superior a 4.

SELECT 	name,
		CONCAT(streetAddr),
        customerGrade
FROM store
WHERE customerGrade > 4;

-- 17. Liste os produtos com estoque esgotado.
SELECT name, amount 
FROM product
WHERE amount = 0;

-- 18. Encontre os produtos mais caros em cada marca.
SELECT fk_brand as brand, MAX(price) 
FROM product
GROUP BY fk_brand;

			-- Verificação com a Microsoft
			SELECT name, fk_brand, price
			FROM product
			WHERE fk_brand = "Microsoft"
			ORDER BY price DESC; 

-- 19. Calcule o total de pedidos em que um determinado cartão de crédito foi usado.
SELECT cc.pk_cardNumber, COUNT(*) as "qtd_pedidos"
FROM payment as p
INNER JOIN bank_card as bc ON p.fk_cardNumber = bc.pk_cardNumber
INNER JOIN credit_card as cc ON cc.pk_cardNumber = bc.pk_cardNumber
WHERE cc.pk_cardNumber = "9238 2749 5738 5921";


-- 20. Liste os nomes e números de telefone dos usuários que não fizeram pedidos.
SELECT pk_userId, phoneNumber
FROM users
WHERE pk_userId NOT IN (
		SELECT distinct userId
		FROM payment as p
		INNER JOIN bank_card as bc ON p.fk_cardNumber = bc.pk_cardNumber
		INNER JOIN credit_card as cc ON cc.pk_cardNumber = bc.pk_cardNumber
        
		UNION
        
		SELECT distinct fk_userId
		FROM payment as p
		INNER JOIN bank_card as bc ON p.fk_cardNumber = bc.pk_cardNumber
		INNER JOIN debit_card as dc ON dc.pk_cardNumber = bc.pk_cardNumber
	);

-- 21. Liste os nomes dos produtos que foram revisados por compradores com uma classificação superior a 4.

SELECT p.name, round(AVG(grade),2) as 'grade'
FROM comments as c
INNER JOIN product as p ON p.pk_pid = c.fk_pid
WHERE grade > 4
GROUP BY fk_pid
ORDER BY fk_pid;

-- 22. Encontre os nomes dos vendedores que não gerenciam nenhuma loja.

SELECT s.pk_userId
FROM seller as s
LEFT JOIN manager as m ON m.pk_userId = s.pk_userId
WHERE m.pk_userId is NULL;


-- 23. Liste os nomes dos compradores que fizeram pelo menos 3 pedidos.

SELECT u.name,
	   fk_userId, 
       COUNT(*) as 'qtd_pedido'

FROM (
	-- Leva em consideração tanto pedidos feitos no crédito como no débito
	SELECT fk_userId
	FROM payment as p
	INNER JOIN debit_card as dc ON  p.fk_cardNumber = dc.pk_cardNumber

	UNION ALL

	SELECT userId
	FROM payment as p
	INNER JOIN credit_card As cc ON p.fk_cardNumber = cc.pk_cardNumber
) AS tabela_users

INNER JOIN users as u ON u.pk_userId = tabela_users.fk_userId
GROUP BY fk_userId
HAVING 	qtd_pedido > 3;


-- SELECT * FROM payment
-- WHERE fk_cardNumber = '9238 2749 5738 5921'; Verifica quantos pedidos existe para um cartão especifico, no caso o do usuario 12

-- 24. Encontre o total de pedidos pagos com cartão de crédito versus cartão de débito.

SELECT 	COUNT(cc.pk_cardNumber) as qtd_credito,
		COUNT(dc.pk_cardNumber) as qtd_debito
FROM payment as p
LEFT JOIN debit_card as dc ON  p.fk_cardNumber = dc.pk_cardNumber
LEFT JOIN credit_card As cc ON p.fk_cardNumber = cc.pk_cardNumber;

-- 25. Liste as marcas que não têm produtos na loja com ID 1.

SELECT *
FROM brand
WHERE pk_brandName NOT IN  (
	SELECT DISTINCT fk_brand
	FROM product
	WHERE fk_sid = 1
);

-- 26. Calcule a quantidade média de produtos disponíveis em todas as lojas.

SELECT ROUND(AVG(amount),2)
FROM product;

-- 27. Encontre os nomes das lojas que não têm produtos em estoque.

SELECT s.name 'loja', p.name as 'produto'
FROM product as p
INNER JOIN store as s ON s.pk_sid = p.fk_sid
WHERE p.amount = 0
ORDER BY s.name;


-- 28. Liste os nomes dos vendedores que gerenciam uma loja localizada em "São Paulo".

SELECT u.name, s.city
FROM manager as m
INNER JOIN store as s ON m.fk_sid = s.pk_sid
INNER JOIN users as u ON u.pk_userId = m.pk_userId
WHERE s.city = "Montreal";

-- 29. Encontre o número total de produtos de uma marca específica (por exemplo, "Sony") disponíveis em todas as lojas.

SELECT fk_brand, SUM(amount)
FROM product
WHERE fk_brand =  "Microsoft";

-- 30. Calcule o valor total de todas as compras feitas por um comprador específico (por exemplo, userid = 1).

SELECT SUM(totalAmount)
FROM payment as p
INNER JOIN orders as o ON o.pk_orderNumber = fk_orderNumber
WHERE fk_cardNumber IN (
	-- verifica quais os cartões do usuário
	SELECT pk_cardNumber
	FROM credit_card
	WHERE userId = 12

	UNION

	SELECT pk_cardNumber
	FROM debit_card
	WHERE fk_userId = 12

);

