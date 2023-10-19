-- ex 1
SELECT userName, phoneNumber FROM users;

-- ex 2
SELECT userName FROM users 
WHERE userId IN (SELECT * FROM buyer); 

-- ex 3
SELECT userName FROM users 
WHERE userId IN (SELECT * FROM seller); 

-- ex 4.1
SELECT bank.cardNumber, bank.expiryDate, bank.bank, credito.userId, credito.organizationBank 
FROM bankcard AS bank
JOIN creditcard AS credito
ON bank.cardNumber = credito.cardNumber;

-- ex4.2
SELECT bank.cardNumber, bank.expiryDate, bank.bank, debito.userId
FROM bankcard AS bank
JOIN debitcard AS debito
ON bank.cardNumber = debito.cardNumber;

-- ex 5
SELECT pName, price FROM product;

-- ex 6 
SELECT * FROM product WHERE brand = "Asus";

-- ex 7
SELECT quantity, orderNumber 
FROM contain 
WHERE orderNumber IN (SELECT orderNumber FROM orders);

-- 8.Calcule o total de vendas por loja


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