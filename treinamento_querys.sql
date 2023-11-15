USE eshop_connect;

-- 16.Encontre o nome e o endereço das lojas com uma classificação de cliente superior a 4.

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
-- 24. Encontre o total de pedidos pagos com cartão de crédito versus cartão de débito.
-- 25. Liste as marcas que não têm produtos na loja com ID 1.
-- 26. Calcule a quantidade média de produtos disponíveis em todas as lojas.
-- 27. Encontre os nomes das lojas que não têm produtos em estoque.
-- 28. Liste os nomes dos vendedores que gerenciam uma loja localizada em "São Paulo".
-- 29. Encontre o número total de produtos de uma marca específica (por exemplo, "Sony") disponíveis em todas as lojas.
-- 30. Calcule o valor total de todas as compras feitas por um comprador específico (por exemplo, userid = 1).
