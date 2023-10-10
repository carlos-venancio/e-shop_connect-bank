USE eshop_connect;

SHOW TABLES;

SHOW COLUMNS FROM users;

# 1. Selecione todos os nomes e números de telefone dos usuários.
SELECT name, phoneNumber FROM users ORDER BY name; 

# 2. Liste os nomes dos compradores.
SELECT pk_userId, name FROM users WHERE pk_userId IN (
	SELECT pk_userId FROM buyer
); -- os resultados de buyer são interpretados como uma array de elementos


# 3. Liste os nomes dos vendedores.

SELECT pk_userId, name FROM users WHERE pk_userId IN (
	SELECT pk_userId FROM seller
);

# 4. Encontre todas as informações de cartão de crédito dos usuários.

ALTER TABLE credit_card
RENAME COLUMN userid to fk_userId;

# 5. Selecione os nomes dos produtos e seus preços.
SELECT name,price FROM product;

# 6. Liste todos os produtos de uma determinada marca (por exemplo, "Samsung").
SELECT name,fk_brand 
FROM product 
WHERE fk_brand = 'Dell';

# 7. Encontre o número de itens em cada pedido.

SELECT	pk_orderNumber as pedido,
		SUM(quantity) AS quantidade
FROM contain
GROUP BY pk_orderNumber;

# 8. Calcule o total de vendas por loja.

SELECT 
	s.name as Loja,
   SUM(p.price) as valor 
FROM order_item as oi
JOIN product as p
ON p.pk_pid = fk_pid
JOIN store as s
ON s.pk_sid = p.fk_sid
GROUP BY s.pk_sid;

# 9. Liste as avaliações dos produtos (grade) com seus nomes e conteúdo de usuário.

SELECT grade, content
FROM comments as c
LEFT JOIN product as p
ON c.fk_pid = p.pk_pid;

# 10. Selecione os nomes dos compradores que fizeram pedidos.

SELECT *
FROM payment as p
LEFT JOIN bank_card as bc
ON bc.pk_cardNumber = p.fk_orderNumber;

# 11. Encontre os vendedores que gerenciam várias lojas.
# 12. Liste os nomes das lojas que oferecem produtos de uma determinada marca (por exemplo, "Apple").
# 13. Encontre as informações de entrega de um pedido específico (por exemplo, orderNumber = 123).
# 14. Calcule o valor médio das compras dos compradores.
# 15. Liste as marcas que têm pontos de serviço em uma determinada cidade (por exemplo, "Nova York").
# 16. Encontre o nome e o endereço das lojas com uma classificação de cliente superior a 4.
# 17. Liste os produtos com estoque esgotado.
# 18. Encontre os produtos mais caros em cada marca.
# 19. Calcule o total de pedidos em que um determinado cartão de crédito (por exemplo, cardNumber = '1234567890') foi usado.
# 20. Liste os nomes e números de telefone dos usuários que não fizeram pedidos.
# 21. Liste os nomes dos produtos que foram revisados por compradores com uma classificação superior a 4.
# 22. Encontre os nomes dos vendedores que não gerenciam nenhuma loja.
# 23. Liste os nomes dos compradores que fizeram pelo menos 3 pedidos.
# 24. Encontre o total de pedidos pagos com cartão de crédito versus cartão de débito.
# 25. Liste as marcas (brandName) que não têm produtos na loja com ID 1.
# 26. Calcule a quantidade média de produtos disponíveis em todas as lojas.
# 27. Encontre os nomes das lojas que não têm produtos em estoque (amount = 0).
# 28. Liste os nomes dos vendedores que gerenciam uma loja localizada em "São Paulo".
# 29. Encontre o número total de produtos de uma marca específica (por exemplo, "Sony") disponíveis em todas as lojas.
# 30. Calcule o valor total de todas as compras feitas por um comprador específico (por exemplo, userid = 1).
