USE eshop_connect;

# 1. Selecionar todos os produtos
SELECT * FROM product;

# 2. Selecionar o nome de todos os usuarios
SELECT name FROM users;

# 3. Retornar todos os contéudos dos comentários dos produtos
SELECT content FROM comments;

# 4. Qual endereço do usuário cujo id é igual a 21
SELECT name,streetAddr FROM address WHERE fk_userId = 21;

# 5. Qual o endereço da loja cujo id é 39
SELECT name,streetAddr FROM store WHERE pk_sid = 39;

# 6. Os pedido com id 74892932 e 84822131
SELECT pk_orderNumber, paymentState FROM orders WHERE pk_orderNumber IN (84821231,74892932);
