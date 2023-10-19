SHOW DATABASES;

USE eshop_connect;

--  A. consultar todos os produtos existentes

SELECT pk_pid, name 
FROM product;

-- B. consultar o nome de todos os usuários

SELECT pk_userId, name 
FROM users;

-- C. consultar as lojas que vendem os produtos

SELECT * FROM product;
SELECT 	p.name as "Nome do produto", 
		s.pk_sid,
		s.name as "Nome da loja"
FROM product as p
INNER JOIN store as s
ON s.pk_sid = p.fk_sid;

-- D. consultas os endereços relacionados com os cliente

SELECT 	u.name as "Cliente" ,
		a.streetAddr  as "Endereço"
FROM address as a
RIGHT JOIN users as u ON u.pk_userId = a.fk_userId
ORDER BY a.fk_userId;

-- E. consultar todos os produtos do tipo "laptop"

SELECT name, type 
FROM product
WHERE type = 'laptop';

-- F. consultar o endereço, hora de inicio (start time) e hora final (end time) dos pontos de serviço da mesma cidade que o usuário cujo ID é 5.

SELECT 	sp.city
		fk_userId,
		sp.streetAddr, 
		startTime, 
        endTime 
FROM service_point AS sp
JOIN address AS a ON a.city = sp.city
WHERE fk_userId = 5; 


/* 
SELECT 	city
		streetAddr, 
		startTime, 
        endTime 
FROM service_point as sp
WHERE city IN (
	SELECT city
    FROM address 
    WHERE fk_userId = 5
);

*/

-- G. consultar a quantidade total de produtos que foram colocados no carrinho (shopping cart), considerando a loja com ID (sid) igual a 8.

SELECT COUNT(*)
FROM save_to_shopping_cart as sc
LEFT JOIN product as p ON sc.pk_pid = p.pk_pid
WHERE p.fk_sid = 8;

-- H. consultar os comentários do produto 123456789.

SELECT fk_userId, fk_pid, grade
FROM comments
WHERE fk_pid = 123456789;