CREATE DATABASE IF NOT EXISTS eshop_connect;

USE eshop_connect;

-- Criação de tabelas

-- Tabelas de dados dos produtos

CREATE TABLE IF NOT EXISTS store (
	pk_sid 			INT,
    name 			VARCHAR(30),
    startDate 		TIME,
    customerGrade	INT,
    streetAddr		VARCHAR(50),
    city 			VARCHAR(30),
    province 		VARCHAR(30),

	PRIMARY KEY (pk_sid)
);


CREATE TABLE IF NOT EXISTS brand (
	pk_brandName	VARCHAR(20),
    
    PRIMARY KEY(pk_brandName)
);

-- Deve ser executada antes de after_sales_service_at
CREATE TABLE IF NOT EXISTS service_point(
	pk_spid 		INT AUTO_INCREMENT,
    streetaddr		VARCHAR(40),
    city			VARCHAR(30),
    province 		VARCHAR(20),
    startTime		TIME,
    endTime			TIME,
    
    PRIMARY KEY (pk_spid)
);

CREATE TABLE IF NOT EXISTS after_sales_service_at(
	fk_brandName	VARCHAR(20),
    fk_spid			INT,
    
    PRIMARY KEY (fk_brandName,fk_spid),
    FOREIGN KEY (fk_brandName) REFERENCES brand(pk_brandName),
    FOREIGN KEY (fk_spid) REFERENCES service_point (pk_spid)
); 

CREATE TABLE IF NOT EXISTS product (
	pk_pid 	INT,
    fk_sid 	INT,
    name 	VARCHAR(20),
    fk_brand 	VARCHAR(20),
    type 	VARCHAR(20) NOT NULL,
    amount	INT NOT NULL,
    price	DECIMAL(10,2) NOT NULL,
    color 	VARCHAR(20),
    modelNumber VARCHAR(50),
    
    PRIMARY KEY (pk_pid),
    FOREIGN KEY (fk_sid) REFERENCES store(pk_sid),
    FOREIGN KEY (fk_brand) REFERENCES brand(pk_brandName)
);


-- Tabelas de dados dos usuarios
CREATE TABLE IF NOT EXISTS users (
	pk_userId		INT PRIMARY KEY,
    name 			VARCHAR(50) NOT NULL,
    phoneNumber 	CHAR(12) NOT NULL
);

CREATE TABLE IF NOT EXISTS seller (
	pk_userId 	INT,
    
    PRIMARY KEY (pk_userId),
    FOREIGN KEY (pk_userId) REFERENCES users(pk_userId)
);

CREATE TABLE IF NOT EXISTS buyer (
	pk_userId 	INT,
    
    PRIMARY KEY (pk_userId),
    FOREIGN KEY (pk_userId) REFERENCES users(pk_userId)
);

CREATE TABLE IF NOT EXISTS address(
	pk_addrid 		INT,
    fk_userId		INT NOT NULL,
    name		VARCHAR(50),
    city		VARCHAR(40),
    postalCode 	VARCHAR(30),
    streetAddr	VARCHAR(30),
    province 	VARCHAR(40),
    contactPhoneNumber	CHAR(12),
    
    PRIMARY KEY (pk_addrid),
    FOREIGN KEY (fk_userId) REFERENCES users(pk_userId)
);

CREATE TABLE IF NOT EXISTS manager (
	pk_userId		INT,
    fk_sid			INT,
    setUpTime		DATE,
    
    PRIMARY KEY (pk_userId, fk_sid),
    FOREIGN KEY (pk_userId) REFERENCES users(pk_userId),
    FOREIGN KEY (fk_sid) REFERENCES store(pk_sid)
);

-- Tabelas de dados do banco dos usuarios

CREATE TABLE IF NOT EXISTS bank_Card(
	pk_cardNumber 	VARCHAR(25),
    bank			VARCHAR(20) NOT NULL,
    expiryDate 		DATE NOT NULL,

	PRIMARY KEY (pk_cardNumber)
);

CREATE TABLE IF NOT EXISTS credit_card (
	pk_cardNumber 	VARCHAR(25),
    userId			INT,
    organization	VARCHAR(50) NOT NULL,
    
    PRIMARY KEY (pk_cardNumber),
    FOREIGN KEY (pk_cardNumber) REFERENCES bank_Card(pk_cardNumber),
    FOREIGN KEY (userId) REFERENCES users(pk_userId)
);

CREATE TABLE IF NOT EXISTS debit_card (
	pk_cardNumber 	VARCHAR(25),
    fk_userId			INT,
    
    PRIMARY KEY (pk_cardNumber),
    FOREIGN KEY (pk_cardNumber) REFERENCES bank_Card(pk_cardNumber),
    FOREIGN KEY (fk_userId) REFERENCES users(pk_userId)
);


-- Tabelas de controle dos pedidos

CREATE TABLE IF NOT EXISTS order_item (
	pk_itemId		INT,
    fk_pid			INT,
    price			DECIMAL(10,2),
    creationTime	DATETIME,
    
    PRIMARY KEY (pk_itemId),
    FOREIGN KEY (fk_pid) REFERENCES product(pk_pid)
);

CREATE TABLE IF NOT EXISTS orders (
	pk_orderNumber 	INT,
    creationTime 	DATE,
    paymentState	VARCHAR(12),
    totalAmount		DECIMAL(10,2),
    
    PRIMARY KEY (pk_orderNumber)
);

CREATE TABLE IF NOT EXISTS contain (
    pk_orderNumber	INT NOT NULL,
    fk_itemId 		INT NOT NULL,
    quantity 		INT,

    PRIMARY KEY(pk_orderNumber,fk_itemId),
    FOREIGN KEY(pk_orderNumber) REFERENCES orders(pk_orderNumber),
    FOREIGN KEY(fk_itemId ) REFERENCES order_item(pk_itemId)
);


CREATE TABLE IF NOT EXISTS payment (
	fk_orderNumber	INT NOT NULL,
    fk_cardNumber	VARCHAR(25) NOT NULL,
    payTime			DATE,
    
	PRIMARY KEY (fk_cardNumber,fk_orderNumber),
    FOREIGN KEY (fk_orderNumber) REFERENCES orders(pk_orderNumber),
    FOREIGN KEY (fk_cardNumber)  REFERENCES bank_Card(pk_cardNumber)
);

-- Tabelas de dados adicionais dos usuarios, como comentario

CREATE TABLE IF NOT EXISTS comments (
	creationTime 	DATETIME,
    fk_userId		INT,
    fk_pid			INT,	
    grade			FLOAT,
    content			VARCHAR(100),
    
    PRIMARY KEY (creationTime,fk_userId,fk_pid), -- cria uma chave primaria combinando os valores dentro do parentese
    FOREIGN KEY (fk_userId) REFERENCES buyer(pk_userId),
    FOREIGN KEY (fk_pid) 	REFERENCES product(pk_pid)
);


-- Tabelas de entregas do pedido 

CREATE TABLE IF NOT EXISTS save_to_shopping_cart(
	pk_userId		INT,
    pK_pid			INT,
    addTime			TIME,
    quantify		INT,
    
    PRIMARY KEY (pk_userId,pK_pid),
    FOREIGN KEY (pk_userId) REFERENCES users(pk_userId),
    FOREIGN KEY (pk_pid) REFERENCES product(pk_pid)
);

CREATE TABLE IF NOT EXISTS deliver_to (
	fk_addrid			INT,
    fk_orderNumber		INT NOT NULL,
    timeDelivered		DATE,
    
    PRIMARY KEY (fk_addrid,fk_orderNumber),
    FOREIGN KEY (fk_addrid) REFERENCES address(pk_addrid),
    FOREIGN KEY (fk_orderNumber) REFERENCES orders(pk_orderNumber)
);

SHOW TABLES;