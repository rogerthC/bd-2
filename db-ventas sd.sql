CREATE SCHEMA users;
CREATE SCHEMA store;
CREATE SCHEMA buys;
CREATE SCHEMA sale;
CREATE SCHEMA promotion;

CREATE TABLE sale.sale(
	id SERIAL,
	id_user INTEGER NOT NULL,
	id_client INTEGER NOT NULL,
	id_detail INTEGER NOT NULL,
	date_sale DATE DEFAULT CURRENT_TIMESTAMP,
	stock INTEGER NULL,

	CONSTRAINT pk_sale PRIMARY KEY(id),
	CONSTRAINT fk_users_user FOREIGN KEY(id_user) REFERENCES users.users(id),
	CONSTRAINT fk_sale_client FOREIGN KEY(id_client) REFERENCES sale.client(id),
	CONSTRAINT fk_sale_detail FOREIGN KEY(id_detail) REFERENCES sale.sale_detail(id),
	CONSTRAINT stock_valid CHECK (stock>=0)
);

CREATE TABLE sale.client(
	id SERIAL,
	name_client TEXT NOT NULL,

	CONSTRAINT pk_client PRIMARY KEY(id)
);

CREATE TABLE sale.sale_detail(
	id SERIAL,
	id_item INTEGER NOT NULL,
	cost_detail INTEGER NOT NULL,
	amount INTEGER NULL,

	CONSTRAINT pk_detail PRIMARY KEY(id),
	CONSTRAINT fk_store_item FOREIGN KEY(id_item) REFERENCES store.item(id),
	CONSTRAINT amount_valid CHECK (amount>=0)
);

CREATE TABLE store.store(
	id SERIAL,
	id_user INTEGER NOT NULL,
	id_item INTEGER NOT NULL,
	date_store DATE DEFAULT CURRENT_TIMESTAMP,
	motion CHAR(1) NOT NULL,
	amount_store INTEGER NULL,
	final_amount INTEGER NULL,

	CONSTRAINT pk_store PRIMARY KEY(id),
	CONSTRAINT fk_users_user FOREIGN KEY(id_user) REFERENCES users.users(id),
	CONSTRAINT fk_store_item FOREIGN KEY(id_item) REFERENCES store.item(id),
	CONSTRAINT motion_valid CHECK (motion IN ('i', 's')),
	CONSTRAINT amount_valid CHECK (amount_store>=0)
);

CREATE TABLE store.item(
	id SERIAL,
	name_item TEXT NOT NULL,
	description_item TEXT NOT NULL,

	CONSTRAINT pk_item PRIMARY KEY(id)
);
CREATE TABLE users.users(
	id SERIAL,
	name_user TEXT NOT NULL,
	password_user TEXT NOT NULL,

	CONSTRAINT pk_user PRIMARY KEY(id)
);

CREATE TABLE users.employee(
	id SERIAL,
	id_users INTEGER NOT NULL,
	name_employee TEXT NOT NULL,
	ap_paterno TEXT NULL,
	ap_materno TEXT NULL,

	CONSTRAINT pk_users_employee PRIMARY KEY(id),
	CONSTRAINT fk_users_user FOREIGN KEY(id_users) REFERENCES users.users(id)
);

CREATE TABLE users.contrat(
	id SERIAL,
	id_employee INTEGER NOT NULL,
	id_position INTEGER NOT NULL,
	date_contract DATE DEFAULT CURRENT_TIMESTAMP,
	type_contract TEXT NOT NULL,
	time_contrat INTEGER,
	
	CONSTRAINT pk_users_contract PRIMARY KEY(id),
	CONSTRAINT fk_uers_employee FOREIGN KEY(id_employee) REFERENCES users.employee(id),
	CONSTRAINT fk_uers_position FOREIGN KEY(id_position) REFERENCES users.position(id),
	CONSTRAINT time_valid CHECK (time_contrat>0)
);

CREATE TABLE users.position(
	id SERIAL,
	name_position TEXT,
	description_position TEXT,

	CONSTRAINT pk_users_position PRIMARY KEY(id)
);

CREATE TABLE users.area(
	id SERIAL,
	id_users_employee INTEGER NOT NULL,
	id_users_area INTEGER NOT NULL,

	CONSTRAINT pk_users_assing_area PRIMARY KEY(id),
	CONSTRAINT fk_uers_employee FOREIGN KEY(id_users_employee) REFERENCES users.employee(id),
	CONSTRAINT fk_uers_area FOREIGN KEY(id_users_area) REFERENCES users.area(id)
);

CREATE TABLE users.control_access(
	id SERIAL,
	id_user INTEGER NOT NULL,
	admin_control_access TEXT NULL,
	buys_control_access TEXT NULL,
	sale_control_access TEXT NULL,
	store_control_access TEXT NULL,

	CONSTRAINT pk_users_control_access PRIMARY KEY(id),
	CONSTRAINT fk_users_user FOREIGN KEY(id_user) REFERENCES users.users(id)
);

CREATE TABLE buys.buys(
	id SERIAL,
	id_user INTEGER NOT NULL,
	id_buys_detail INTEGER NOT NULL,
	id_buys_supplier INTEGER NOT NULL,
	date_buys DATE DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT pk_buys PRIMARY KEY(id),
	CONSTRAINT fk_users_user FOREIGN KEY(id_user) REFERENCES users.users(id),
	CONSTRAINT fk_buys_detail FOREIGN KEY(id_buys_detail) REFERENCES buys.buys_detail(id),
	CONSTRAINT fk_buys_supplier FOREIGN KEY(id_buys_supplier) REFERENCES buys.buys_supplier(id)
);

CREATE TABLE buys.buys_detail(
	id SERIAL,
	id_item INTEGER NOT NULL,
	cost_detail INTEGER NOT NULL,
	amount_detail INTEGER NULL,

	CONSTRAINT pk_detail PRIMARY KEY(id),
	CONSTRAINT fk_store_item FOREIGN KEY(id_item) REFERENCES store.item(id),
	CONSTRAINT cost_valid CHECK (cost_detail>=0),
	CONSTRAINT amount_valid CHECK (amount_detail>=0)
);

CREATE TABLE buys.buys_supplier(
	id SERIAL,
	supplier_name TEXT NOT NULL,
	company_name TEXT NOT NULL,
	email TEXT NOT NULL,
	number_phone TEXT NOT NULL,

	CONSTRAINT pk_buys_supplier PRIMARY KEY(id)
);

CREATE TABLE promotion.promotion(
	id SERIAL,
	id_item INTEGER NOT NULL,
	date_promotion DATE DEFAULT CURRENT_TIMESTAMP,
	amount_promotion INTEGER NULL,
	discount INTEGER NULL,
	
	CONSTRAINT pk_promotion PRIMARY KEY(id),
	CONSTRAINT fk_store_item FOREIGN KEY(id_item) REFERENCES store.item(id),
	CONSTRAINT amount_valid CHECK (amount_promotion>=0),
	CONSTRAINT discount_valid CHECK (discount>0)
);

INSERT INTO users.users (name_user, password_user) VALUES
('Daniela', 'password123'),
('Bob', 'password123'),
('Noemi', 'password123'),
('David', 'password123'),
('Eve', 'password123'),
('Frank', 'password123'),
('Grace', 'password123'),
('Hannah', 'password123'),
('Ivy', 'password123'),
('Jack', 'password123'),
('Karen', 'password123'),
('Leo', 'password123'),
('Mason', 'password123'),
('Nina', 'password123'),
('Oscar', 'password123'),
('Paul', 'password123'),
('Quincy', 'password123'),
('Rachel', 'password123'),
('Samuel', 'password123'),
('Tina', 'password123'),
('Uma', 'password123'),
('Vera', 'password123'),
('Will', 'password123'),
('Xander', 'password123'),
('Yara', 'password123'),
('Zane', 'password123'),
('Amelia', 'password123'),
('Ben', 'password123'),
('Catherine', 'password123'),
('Daniel', 'password123'),
('Ella', 'password123'),
('Felix', 'password123'),
('George', 'password123'),
('Holly', 'password123'),
('Iris', 'password123'),
('Jake', 'password123'),
('Kelsey', 'password123'),
('Liam', 'password123'),
('Maya', 'password123'),
('Nate', 'password123'),
('Olivia', 'password123'),
('Penny', 'password123');


SELECT * FROM users.users;


INSERT INTO store.item (name_item, description_item) VALUES
('Item A', 'Description for Item A'),
('Item B', 'Description for Item B'),
('Item C', 'Description for Item C'),
('Item D', 'Description for Item D'),
('Item E', 'Description for Item E'),
('Item F', 'Description for Item F'),
('Item G', 'Description for Item G'),
('Item H', 'Description for Item H'),
('Item I', 'Description for Item I'),
('Item J', 'Description for Item J'),
('Item K', 'Description for Item K'),
('Item L', 'Description for Item L'),
('Item M', 'Description for Item M'),
('Item N', 'Description for Item N'),
('Item O', 'Description for Item O'),
('Item P', 'Description for Item P'),
('Item Q', 'Description for Item Q'),
('Item R', 'Description for Item R'),
('Item S', 'Description for Item S'),
('Item T', 'Description for Item T'),
('Item U', 'Description for Item U'),
('Item V', 'Description for Item V'),
('Item W', 'Description for Item W'),
('Item X', 'Description for Item X'),
('Item Y', 'Description for Item Y'),
('Item Z', 'Description for Item Z'),
('Item AA', 'Description for Item AA'),
('Item AB', 'Description for Item AB'),
('Item AC', 'Description for Item AC'),
('Item AD', 'Description for Item AD'),
('Item AE', 'Description for Item AE'),
('Item AF', 'Description for Item AF'),
('Item AG', 'Description for Item AG'),
('Item AH', 'Description for Item AH'),
('Item AI', 'Description for Item AI'),
('Item AJ', 'Description for Item AJ'),
('Item AK', 'Description for Item AK'),
('Item AL', 'Description for Item AL'),
('Item AM', 'Description for Item AM'),
('Item AN', 'Description for Item AN'),
('Item AO', 'Description for Item AO'),
('Item AP', 'Description for Item AP');


SELECT * FROM store.item;


INSERT INTO sale.client (name_client) VALUES
('Client A'),
('Client B'),
('Client C'),
('Client D'),
('Client E'),
('Client F'),
('Client G'),
('Client H'),
('Client I'),
('Client J'),
('Client K'),
('Client L'),
('Client M'),
('Client N'),
('Client O'),
('Client P'),
('Client Q'),
('Client R'),
('Client S'),
('Client T'),
('Client U'),
('Client V'),
('Client W'),
('Client X'),
('Client Y'),
('Client Z'),
('Client AA'),
('Client AB'),
('Client AC'),
('Client AD'),
('Client AE'),
('Client AF'),
('Client AG'),
('Client AH'),
('Client AI'),
('Client AJ'),
('Client AK'),
('Client AL'),
('Client AM'),
('Client AN'),
('Client AO'),
('Client AP'),
('Client AQ'),
('Client AR'),
('Client AS'),
('Client AT'),
('Client AU'),
('Client AV'),
('Client AW'),
('Client AX'),
('Client AY'),
('Client AZ'),
('Client BA'),
('Client BB'),
('Client BC'),
('Client BD'),
('Client BE'),
('Client BF'),
('Client BG'),
('Client BH'),
('Client BI'),
('Client BJ'),
('Client BK'),
('Client BL'),
('Client BM'),
('Client BN'),
('Client BO'),
('Client BP'),
('Client BQ'),
('Client BR'),
('Client BS'),
('Client BT'),
('Client BU'),
('Client BV'),
('Client BW'),
('Client BX'),
('Client BY'),
('Client BZ'),
('Client CA'),
('Client CB'),
('Client CC'),
('Client CD'),
('Client CE'),
('Client CF'),
('Client CG'),
('Client CH'),
('Client CI'),
('Client CJ'),
('Client CK'),
('Client CL'),
('Client CM'),
('Client CN'),
('Client CO'),
('Client CP'),
('Client CQ'),
('Client CR'),
('Client CS'),
('Client CT'),
('Client CU'),
('Client CV'),
('Client CW'),
('Client CX'),
('Client CY'),
('Client CZ');



SELECT * FROM sale.client;



INSERT INTO sale.sale_detail (id_item, cost_detail, amount) VALUES
(1, 100, 2),
(2, 150, 3),
(3, 200, 1),
(4, 50, 5),
(5, 300, 4),
(6, 120, 6),
(7, 75, 2),
(8, 250, 1),
(9, 180, 3),
(10, 220, 2),
(11, 110, 5),
(12, 130, 2),
(13, 160, 3),
(14, 140, 4),
(15, 90, 6),
(16, 175, 2),
(17, 210, 1),
(18, 195, 3),
(19, 85, 7),
(20, 125, 4),
(21, 300, 2),
(22, 50, 6),
(23, 170, 5),
(24, 240, 1),
(25, 160, 4),
(26, 100, 3),
(27, 210, 2),
(28, 220, 5),
(29, 190, 3),
(30, 150, 6),
(31, 180, 4),
(32, 120, 2),
(33, 230, 3),
(34, 140, 5),
(35, 110, 4),
(36, 80, 6),
(37, 70, 3),
(38, 60, 5),
(39, 140, 2),
(40, 200, 6),
(41, 250, 4),
(42, 130, 2),
(43, 220, 3),
(44, 180, 5),
(45, 90, 7),
(46, 160, 3),
(47, 130, 4),
(48, 240, 2),
(49, 175, 6),
(50, 190, 5),
(51, 200, 4),
(52, 160, 2),
(53, 230, 5),
(54, 100, 6),
(55, 150, 4),
(56, 210, 2),
(57, 180, 6),
(58, 250, 3),
(59, 190, 2),
(60, 120, 4),
(61, 130, 3),
(62, 160, 5),
(63, 220, 2),
(64, 140, 6),
(65, 175, 3),
(66, 100, 5),
(67, 110, 2),
(68, 150, 7),
(69, 200, 4),
(70, 240, 1),
(71, 250, 6),
(72, 230, 4),
(73, 120, 3),
(74, 180, 5),
(75, 130, 2),
(76, 170, 6),
(77, 140, 3),
(78, 160, 4),
(79, 100, 7),
(80, 180, 2);



SELECT * FROM sale.sale_detail;


INSERT INTO sale.sale (date_sale, stock, id_client, id_user, id_detail) VALUES
(CURRENT_DATE, 10, 1, 1, 1),
(CURRENT_DATE, 20, 2, 2, 2),
(CURRENT_DATE, 15, 3, 3, 3),
(CURRENT_DATE, 5, 4, 4, 4),
(CURRENT_DATE, 30, 5, 5, 5),
(CURRENT_DATE, 25, 6, 6, 6),
(CURRENT_DATE, 10, 7, 7, 7),
(CURRENT_DATE, 40, 8, 8, 8),
(CURRENT_DATE, 35, 9, 9, 9),
(CURRENT_DATE, 50, 10, 10, 10),
(CURRENT_DATE, 15, 11, 11, 11),
(CURRENT_DATE, 25, 12, 12, 12),
(CURRENT_DATE, 30, 13, 13, 13),
(CURRENT_DATE, 40, 14, 14, 14),
(CURRENT_DATE, 35, 15, 15, 15),
(CURRENT_DATE, 45, 16, 16, 16),
(CURRENT_DATE, 50, 17, 17, 17),
(CURRENT_DATE, 20, 18, 18, 18),
(CURRENT_DATE, 10, 19, 19, 19),
(CURRENT_DATE, 25, 20, 20, 20),
(CURRENT_DATE, 30, 21, 21, 21),
(CURRENT_DATE, 40, 22, 22, 22),
(CURRENT_DATE, 15, 23, 23, 23),
(CURRENT_DATE, 20, 24, 24, 24),
(CURRENT_DATE, 30, 25, 25, 25),
(CURRENT_DATE, 45, 26, 26, 26),
(CURRENT_DATE, 50, 27, 27, 27),
(CURRENT_DATE, 20, 28, 28, 28),
(CURRENT_DATE, 10, 29, 29, 29),
(CURRENT_DATE, 25, 30, 30, 30),
(CURRENT_DATE, 40, 31, 31, 31),
(CURRENT_DATE, 35, 32, 32, 32),
(CURRENT_DATE, 50, 33, 33, 33),
(CURRENT_DATE, 20, 34, 34, 34),
(CURRENT_DATE, 10, 35, 35, 35),
(CURRENT_DATE, 25, 36, 36, 36),
(CURRENT_DATE, 30, 37, 37, 37),
(CURRENT_DATE, 45, 38, 38, 38),
(CURRENT_DATE, 50, 39, 39, 39),
(CURRENT_DATE, 10, 40, 40, 40),
(CURRENT_DATE, 20, 41, 41, 41),
(CURRENT_DATE, 30, 42, 42, 42),
(CURRENT_DATE, 40, 43, 43, 43),
(CURRENT_DATE, 35, 44, 44, 44),
(CURRENT_DATE, 50, 45, 45, 45),
(CURRENT_DATE, 20, 46, 46, 46),
(CURRENT_DATE, 25, 47, 47, 47),
(CURRENT_DATE, 35, 48, 48, 48),
(CURRENT_DATE, 30, 49, 49, 49),
(CURRENT_DATE, 45, 50, 50, 50),
(CURRENT_DATE, 40, 51, 51, 51),
(CURRENT_DATE, 25, 52, 52, 52),
(CURRENT_DATE, 30, 53, 53, 53),
(CURRENT_DATE, 50, 54, 54, 54),
(CURRENT_DATE, 35, 55, 55, 55),
(CURRENT_DATE, 45, 56, 56, 56),
(CURRENT_DATE, 40, 57, 57, 57),
(CURRENT_DATE, 30, 58, 58, 58),
(CURRENT_DATE, 25, 59, 59, 59),
(CURRENT_DATE, 10, 60, 60, 60),
(CURRENT_DATE, 20, 61, 61, 61),
(CURRENT_DATE, 30, 62, 62, 62),
(CURRENT_DATE, 40, 63, 63, 63),
(CURRENT_DATE, 25, 64, 64, 64),
(CURRENT_DATE, 10, 65, 65, 65),
(CURRENT_DATE, 20, 66, 66, 66),
(CURRENT_DATE, 30, 67, 67, 67),
(CURRENT_DATE, 45, 68, 68, 68),
(CURRENT_DATE, 50, 69, 69, 69),
(CURRENT_DATE, 25, 70, 70, 70),
(CURRENT_DATE, 40, 71, 71, 71),
(CURRENT_DATE, 35, 72, 72, 72),
(CURRENT_DATE, 30, 73, 73, 73),
(CURRENT_DATE, 20, 74, 74, 74),
(CURRENT_DATE, 10, 75, 75, 75),
(CURRENT_DATE, 25, 76, 76, 76),
(CURRENT_DATE, 40, 77, 77, 77),
(CURRENT_DATE, 30, 78, 78, 78),
(CURRENT_DATE, 50, 79, 79, 79),
(CURRENT_DATE, 35, 80, 80, 80);


SELECT * FROM sale.sale;


INSERT INTO store.store (date_store, amount_store, final_amount, id_item, id_user, motion) VALUES
(CURRENT_DATE, 100, 120, 1, 1, 'i'),
(CURRENT_DATE, 200, 150, 2, 2, 's'),
(CURRENT_DATE, 50, 60, 3, 3, 'i'),
(CURRENT_DATE, 70, 50, 4, 4, 's'),
(CURRENT_DATE, 300, 320, 5, 5, 'i'),
(CURRENT_DATE, 100, 80, 6, 6, 's'),
(CURRENT_DATE, 150, 160, 7, 7, 'i'),
(CURRENT_DATE, 250, 200, 8, 8, 's'),
(CURRENT_DATE, 180, 200, 9, 9, 'i'),
(CURRENT_DATE, 220, 180, 10, 10, 's'),
(CURRENT_DATE, 130, 110, 11, 11, 'i'),
(CURRENT_DATE, 190, 170, 12, 12, 's'),
(CURRENT_DATE, 250, 270, 13, 13, 'i'),
(CURRENT_DATE, 80, 60, 14, 14, 's'),
(CURRENT_DATE, 150, 140, 15, 15, 'i'),
(CURRENT_DATE, 220, 210, 16, 16, 's'),
(CURRENT_DATE, 170, 150, 17, 17, 'i'),
(CURRENT_DATE, 100, 120, 18, 18, 's'),
(CURRENT_DATE, 180, 200, 19, 19, 'i'),
(CURRENT_DATE, 250, 230, 20, 20, 's'),
(CURRENT_DATE, 130, 150, 21, 21, 'i'),
(CURRENT_DATE, 200, 180, 22, 22, 's'),
(CURRENT_DATE, 120, 100, 23, 23, 'i'),
(CURRENT_DATE, 180, 170, 24, 24, 's'),
(CURRENT_DATE, 150, 130, 25, 25, 'i'),
(CURRENT_DATE, 100, 80, 26, 26, 's'),
(CURRENT_DATE, 250, 270, 27, 27, 'i'),
(CURRENT_DATE, 130, 110, 28, 28, 's'),
(CURRENT_DATE, 170, 180, 29, 29, 'i'),
(CURRENT_DATE, 200, 190, 30, 30, 's'),
(CURRENT_DATE, 50, 60, 31, 31, 'i'),
(CURRENT_DATE, 100, 120, 32, 32, 's'),
(CURRENT_DATE, 150, 140, 33, 33, 'i'),
(CURRENT_DATE, 220, 210, 34, 34, 's'),
(CURRENT_DATE, 170, 150, 35, 35, 'i'),
(CURRENT_DATE, 180, 160, 36, 36, 's'),
(CURRENT_DATE, 250, 240, 37, 37, 'i'),
(CURRENT_DATE, 120, 100, 38, 38, 's'),
(CURRENT_DATE, 150, 130, 39, 39, 'i'),
(CURRENT_DATE, 220, 210, 40, 40, 's'),
(CURRENT_DATE, 170, 150, 41, 41, 'i'),
(CURRENT_DATE, 100, 120, 42, 42, 's'),
(CURRENT_DATE, 180, 170, 43, 43, 'i'),
(CURRENT_DATE, 200, 190, 44, 44, 's'),
(CURRENT_DATE, 150, 140, 45, 45, 'i'),
(CURRENT_DATE, 250, 240, 46, 46, 's'),
(CURRENT_DATE, 120, 100, 47, 47, 'i'),
(CURRENT_DATE, 170, 150, 48, 48, 's'),
(CURRENT_DATE, 200, 180, 49, 49, 'i'),
(CURRENT_DATE, 50, 60, 50, 50, 's'),
(CURRENT_DATE, 100, 120, 51, 51, 'i'),
(CURRENT_DATE, 150, 140, 52, 52, 's'),
(CURRENT_DATE, 200, 190, 53, 53, 'i'),
(CURRENT_DATE, 220, 210, 54, 54, 's'),
(CURRENT_DATE, 180, 160, 55, 55, 'i');



SELECT * FROM store.store;


INSERT INTO users.employee (id_users, name_employee, ap_paterno, ap_materno) VALUES
(1, 'Alice Employee', 'Smith', 'Johnson'),
(2, 'Bob Employee', 'Johnson', 'Williams'),
(3, 'Charlie Employee', 'Williams', 'Brown'),
(4, 'David Employee', 'Brown', 'Jones'),
(5, 'Eve Employee', 'Jones', 'Miller'),
(6, 'Frank Employee', 'Miller', 'Davis'),
(7, 'Grace Employee', 'Davis', 'Garcia'),
(8, 'Hannah Employee', 'Garcia', 'Rodriguez'),
(9, 'Ivy Employee', 'Rodriguez', 'Martinez'),
(10, 'Jack Employee', 'Martinez', 'Hernandez'),
(11, 'Karen Employee', 'Hernandez', 'Lopez'),
(12, 'Leo Employee', 'Lopez', 'Gonzalez'),
(13, 'Mia Employee', 'Gonzalez', 'Perez'),
(14, 'Nathan Employee', 'Perez', 'Wilson'),
(15, 'Olivia Employee', 'Wilson', 'Anderson'),
(16, 'Paul Employee', 'Anderson', 'Thomas'),
(17, 'Quinn Employee', 'Thomas', 'Taylor'),
(18, 'Rita Employee', 'Taylor', 'Moore'),
(19, 'Sam Employee', 'Moore', 'Jackson'),
(20, 'Tina Employee', 'Jackson', 'Martin'),
(21, 'Ursula Employee', 'Martin', 'Lee'),
(22, 'Victor Employee', 'Lee', 'Perez'),
(23, 'Wendy Employee', 'Perez', 'White'),
(24, 'Xander Employee', 'White', 'Harris'),
(25, 'Yvonne Employee', 'Harris', 'Clark'),
(26, 'Zane Employee', 'Clark', 'Lewis'),
(27, 'Amy Employee', 'Lewis', 'Young'),
(28, 'Brian Employee', 'Young', 'Walker'),
(29, 'Catherine Employee', 'Walker', 'Hall'),
(30, 'Daniel Employee', 'Hall', 'Allen'),
(31, 'Emily Employee', 'Allen', 'Sanchez'),
(32, 'Frankie Employee', 'Sanchez', 'King'),
(33, 'George Employee', 'King', 'Scott'),
(34, 'Holly Employee', 'Scott', 'Green'),
(35, 'Ian Employee', 'Green', 'Adams'),
(36, 'Jackie Employee', 'Adams', 'Baker'),
(37, 'Kevin Employee', 'Baker', 'Nelson'),
(38, 'Lily Employee', 'Nelson', 'Carter'),
(39, 'Mason Employee', 'Carter', 'Mitchell'),
(40, 'Nina Employee', 'Mitchell', 'Perez'),
(41, 'Oscar Employee', 'Perez', 'Roberts'),
(42, 'Penny Employee', 'Roberts', 'Evans'),
(43, 'Quincy Employee', 'Evans', 'Gonzalez'),
(44, 'Rachel Employee', 'Gonzalez', 'Cook'),
(45, 'Steven Employee', 'Cook', 'Murphy'),
(46, 'Tina Employee', 'Murphy', 'Bailey'),
(47, 'Ursula Employee', 'Bailey', 'Rivera'),
(48, 'Vince Employee', 'Rivera', 'Cooper'),
(49, 'Will Employee', 'Cooper', 'Reed'),
(50, 'Xena Employee', 'Reed', 'Ward'),
(51, 'Yasmine Employee', 'Ward', 'Flores'),
(52, 'Zoe Employee', 'Flores', 'Stewart'),
(53, 'Aaron Employee', 'Stewart', 'Morris'),
(54, 'Brandon Employee', 'Morris', 'Nguyen'),
(55, 'Carmen Employee', 'Nguyen', 'Rogers'),
(56, 'Dustin Employee', 'Rogers', 'Peterson'),
(57, 'Elena Employee', 'Peterson', 'Gray'),
(58, 'Felix Employee', 'Gray', 'James'),
(59, 'Gina Employee', 'James', 'Bennett'),
(60, 'Harry Employee', 'Bennett', 'Wood'),
(61, 'Isabella Employee', 'Wood', 'Barnes'),
(62, 'Jacob Employee', 'Barnes', 'Hawkins'),
(63, 'Kara Employee', 'Hawkins', 'Chavez'),
(64, 'Liam Employee', 'Chavez', 'Kim'),
(65, 'Maya Employee', 'Kim', 'Grant'),
(66, 'Noah Employee', 'Grant', 'Dixon'),
(67, 'Olga Employee', 'Dixon', 'Graham'),
(68, 'Pauline Employee', 'Graham', 'Simmons'),
(69, 'Quincy Employee', 'Simmons', 'Rodriguez'),
(70, 'Rachel Employee', 'Rodriguez', 'Parker'),
(71, 'Samuel Employee', 'Parker', 'Alexander'),
(72, 'Troy Employee', 'Alexander', 'Henderson'),
(73, 'Uma Employee', 'Henderson', 'Cole'),
(74, 'Vera Employee', 'Cole', 'Ward'),
(75, 'Willow Employee', 'Ward', 'Fisher'),
(76, 'Xander Employee', 'Fisher', 'Graham'),
(77, 'Yara Employee', 'Graham', 'Reed'),
(78, 'Zane Employee', 'Reed', 'Cook'),
(79, 'Amos Employee', 'Cook', 'Morgan'),
(80, 'Brianna Employee', 'Morgan', 'Bell');

SELECT * FROM users.employee;


INSERT INTO users.position (name_position, description_position) VALUES
('Manager', 'Manager Description'),
('Assistant', 'Assistant Description'),
('Salesperson', 'Salesperson Description'),
('Technician', 'Technician Description'),
('Support', 'Support Description'),
('Driver', 'Driver Description'),
('Cleaner', 'Cleaner Description'),
('Security', 'Security Description'),
('HR', 'HR Description'),
('Intern', 'Intern Description'),
('Accountant', 'Accountant Description'),
('Engineer', 'Engineer Description'),
('Designer', 'Designer Description'),
('Developer', 'Developer Description'),
('Consultant', 'Consultant Description'),
('Architect', 'Architect Description'),
('Administrator', 'Administrator Description'),
('Supervisor', 'Supervisor Description'),
('Coordinator', 'Coordinator Description'),
('Operator', 'Operator Description'),
('Director', 'Director Description'),
('Executive', 'Executive Description'),
('Assistant Director', 'Assistant Director Description'),
('Lead Technician', 'Lead Technician Description'),
('Junior Developer', 'Junior Developer Description'),
('Senior Developer', 'Senior Developer Description'),
('Senior Consultant', 'Senior Consultant Description'),
('Junior Consultant', 'Junior Consultant Description'),
('Project Manager', 'Project Manager Description'),
('Product Manager', 'Product Manager Description'),
('Business Analyst', 'Business Analyst Description'),
('Customer Support', 'Customer Support Description'),
('Logistics', 'Logistics Description'),
('Quality Control', 'Quality Control Description'),
('Product Designer', 'Product Designer Description'),
('Marketing Specialist', 'Marketing Specialist Description'),
('Sales Manager', 'Sales Manager Description'),
('IT Specialist', 'IT Specialist Description'),
('Financial Analyst', 'Financial Analyst Description'),
('Marketing Director', 'Marketing Director Description'),
('Creative Director', 'Creative Director Description'),
('Research Analyst', 'Research Analyst Description'),
('Operations Manager', 'Operations Manager Description'),
('Financial Director', 'Financial Director Description'),
('Chief Executive Officer', 'Chief Executive Officer Description'),
('Chief Operating Officer', 'Chief Operating Officer Description'),
('Chief Financial Officer', 'Chief Financial Officer Description'),
('Chief Marketing Officer', 'Chief Marketing Officer Description'),
('Chief Technology Officer', 'Chief Technology Officer Description'),
('Legal Advisor', 'Legal Advisor Description'),
('Public Relations Specialist', 'Public Relations Specialist Description'),
('Product Owner', 'Product Owner Description'),
('Business Development Manager', 'Business Development Manager Description'),
('Data Scientist', 'Data Scientist Description'),
('Machine Learning Engineer', 'Machine Learning Engineer Description'),
('Cloud Engineer', 'Cloud Engineer Description'),
('HR Manager', 'HR Manager Description'),
('HR Assistant', 'HR Assistant Description'),
('Content Manager', 'Content Manager Description'),
('Social Media Manager', 'Social Media Manager Description'),
('SEO Specialist', 'SEO Specialist Description'),
('Copywriter', 'Copywriter Description'),
('Customer Service Manager', 'Customer Service Manager Description'),
('Marketing Assistant', 'Marketing Assistant Description'),
('Field Technician', 'Field Technician Description'),
('Warehouse Manager', 'Warehouse Manager Description'),
('Maintenance Manager', 'Maintenance Manager Description'),
('Product Tester', 'Product Tester Description'),
('Supply Chain Manager', 'Supply Chain Manager Description'),
('Inventory Manager', 'Inventory Manager Description'),
('Business Consultant', 'Business Consultant Description'),
('Data Analyst', 'Data Analyst Description'),
('Event Planner', 'Event Planner Description'),
('Procurement Manager', 'Procurement Manager Description'),
('Brand Manager', 'Brand Manager Description'),
('Partnership Manager', 'Partnership Manager Description'),
('Legal Counsel', 'Legal Counsel Description'),
('Tax Advisor', 'Tax Advisor Description'),
('Recruiter', 'Recruiter Description'),
('Facilities Manager', 'Facilities Manager Description'),
('Digital Marketing Manager', 'Digital Marketing Manager Description'),
('Program Manager', 'Program Manager Description'),
('E-commerce Manager', 'E-commerce Manager Description'),
('Supply Chain Coordinator', 'Supply Chain Coordinator Description'),
('Executive Assistant', 'Executive Assistant Description'),
('Team Lead', 'Team Lead Description'),
('Talent Acquisition Specialist', 'Talent Acquisition Specialist Description'),
('Sales Director', 'Sales Director Description'),
('Regional Manager', 'Regional Manager Description'),
('Operations Specialist', 'Operations Specialist Description'),
('Sustainability Manager', 'Sustainability Manager Description'),
('Corporate Trainer', 'Corporate Trainer Description'),
('Customer Success Manager', 'Customer Success Manager Description'),
('HR Specialist', 'HR Specialist Description');

SELECT * FROM users.position;


INSERT INTO users.contrat (id_employee, id_position, type_contract, time_contrat) VALUES
(1, 1, 'Full-Time', 12),
(2, 2, 'Part-Time', 6),
(3, 3, 'Full-Time', 18),
(4, 4, 'Temporary', 3),
(5, 5, 'Full-Time', 24),
(6, 6, 'Intern', 6),
(7, 7, 'Part-Time', 12),
(8, 8, 'Full-Time', 36),
(9, 9, 'Temporary', 12),
(10, 10, 'Part-Time', 6),
(11, 11, 'Full-Time', 24),
(12, 12, 'Part-Time', 12),
(13, 13, 'Temporary', 6),
(14, 14, 'Full-Time', 18),
(15, 15, 'Intern', 12),
(16, 16, 'Part-Time', 9),
(17, 17, 'Full-Time', 30),
(18, 18, 'Temporary', 12),
(19, 19, 'Part-Time', 18),
(20, 20, 'Full-Time', 36),
(21, 21, 'Intern', 6),
(22, 22, 'Part-Time', 12),
(23, 23, 'Full-Time', 24),
(24, 24, 'Temporary', 18),
(25, 25, 'Full-Time', 12),
(26, 26, 'Intern', 6),
(27, 27, 'Part-Time', 9),
(28, 28, 'Full-Time', 18),
(29, 29, 'Temporary', 24),
(30, 30, 'Full-Time', 36),
(31, 31, 'Part-Time', 12),
(32, 32, 'Intern', 3),
(33, 33, 'Temporary', 6),
(34, 34, 'Full-Time', 24),
(35, 35, 'Part-Time', 18),
(36, 36, 'Full-Time', 30),
(37, 37, 'Temporary', 12),
(38, 38, 'Intern', 9),
(39, 39, 'Part-Time', 6),
(40, 40, 'Full-Time', 18),
(41, 41, 'Full-Time', 12),
(42, 42, 'Part-Time', 24),
(43, 43, 'Intern', 12),
(44, 44, 'Full-Time', 36),
(45, 45, 'Temporary', 6),
(46, 46, 'Part-Time', 18),
(47, 47, 'Full-Time', 9),
(48, 48, 'Temporary', 12),
(49, 49, 'Part-Time', 24),
(50, 50, 'Full-Time', 30),
(51, 51, 'Intern', 6),
(52, 52, 'Full-Time', 36),
(53, 53, 'Part-Time', 18),
(54, 54, 'Temporary', 9),
(55, 55, 'Full-Time', 12),
(56, 56, 'Intern', 18),
(57, 57, 'Part-Time', 6),
(58, 58, 'Full-Time', 24),
(59, 59, 'Temporary', 30),
(60, 60, 'Full-Time', 9),
(61, 61, 'Intern', 12),
(62, 62, 'Part-Time', 18),
(63, 63, 'Full-Time', 18),
(64, 64, 'Temporary', 6),
(65, 65, 'Full-Time', 30),
(66, 66, 'Part-Time', 24),
(67, 67, 'Intern', 9),
(68, 68, 'Temporary', 12),
(69, 69, 'Full-Time', 12),
(70, 70, 'Part-Time', 6),
(71, 71, 'Full-Time', 18),
(72, 72, 'Temporary', 9),
(73, 73, 'Intern', 6),
(74, 74, 'Full-Time', 24),
(75, 75, 'Part-Time', 18),
(76, 76, 'Temporary', 6),
(77, 77, 'Full-Time', 12),
(78, 78, 'Intern', 3),
(79, 79, 'Part-Time', 30),
(80, 80, 'Full-Time', 18);


SELECT * FROM users.contrat;

INSERT INTO buys.buys_supplier (supplier_name, company_name, email, number_phone) VALUES
('Supplier A', 'Company A', 'supplierA@company.com', '123456789'),
('Supplier B', 'Company B', 'supplierB@company.com', '234567890'),
('Supplier C', 'Company C', 'supplierC@company.com', '345678901'),
('Supplier D', 'Company D', 'supplierD@company.com', '456789012'),
('Supplier E', 'Company E', 'supplierE@company.com', '567890123'),
('Supplier F', 'Company F', 'supplierF@company.com', '678901234'),
('Supplier G', 'Company G', 'supplierG@company.com', '789012345'),
('Supplier H', 'Company H', 'supplierH@company.com', '890123456'),
('Supplier I', 'Company I', 'supplierI@company.com', '901234567'),
('Supplier J', 'Company J', 'supplierJ@company.com', '012345678'),
('Supplier K', 'Company K', 'supplierK@company.com', '123450987'),
('Supplier L', 'Company L', 'supplierL@company.com', '234561098'),
('Supplier M', 'Company M', 'supplierM@company.com', '345672109'),
('Supplier N', 'Company N', 'supplierN@company.com', '456783210'),
('Supplier O', 'Company O', 'supplierO@company.com', '567894321'),
('Supplier P', 'Company P', 'supplierP@company.com', '678905432'),
('Supplier Q', 'Company Q', 'supplierQ@company.com', '789016543'),
('Supplier R', 'Company R', 'supplierR@company.com', '890127654'),
('Supplier S', 'Company S', 'supplierS@company.com', '901238765'),
('Supplier T', 'Company T', 'supplierT@company.com', '012349876'),
('Supplier U', 'Company U', 'supplierU@company.com', '123450987'),
('Supplier V', 'Company V', 'supplierV@company.com', '234561098'),
('Supplier W', 'Company W', 'supplierW@company.com', '345672109'),
('Supplier X', 'Company X', 'supplierX@company.com', '456783210'),
('Supplier Y', 'Company Y', 'supplierY@company.com', '567894321'),
('Supplier Z', 'Company Z', 'supplierZ@company.com', '678905432'),
('Supplier AA', 'Company AA', 'supplierAA@company.com', '789016543'),
('Supplier AB', 'Company AB', 'supplierAB@company.com', '890127654'),
('Supplier AC', 'Company AC', 'supplierAC@company.com', '901238765'),
('Supplier AD', 'Company AD', 'supplierAD@company.com', '012349876'),
('Supplier AE', 'Company AE', 'supplierAE@company.com', '123450987'),
('Supplier AF', 'Company AF', 'supplierAF@company.com', '234561098'),
('Supplier AG', 'Company AG', 'supplierAG@company.com', '345672109'),
('Supplier AH', 'Company AH', 'supplierAH@company.com', '456783210'),
('Supplier AI', 'Company AI', 'supplierAI@company.com', '567894321'),
('Supplier AJ', 'Company AJ', 'supplierAJ@company.com', '678905432'),
('Supplier AK', 'Company AK', 'supplierAK@company.com', '789016543'),
('Supplier AL', 'Company AL', 'supplierAL@company.com', '890127654'),
('Supplier AM', 'Company AM', 'supplierAM@company.com', '901238765'),
('Supplier AN', 'Company AN', 'supplierAN@company.com', '012349876'),
('Supplier AO', 'Company AO', 'supplierAO@company.com', '123450987'),
('Supplier AP', 'Company AP', 'supplierAP@company.com', '234561098'),
('Supplier AQ', 'Company AQ', 'supplierAQ@company.com', '345672109'),
('Supplier AR', 'Company AR', 'supplierAR@company.com', '456783210'),
('Supplier AS', 'Company AS', 'supplierAS@company.com', '567894321'),
('Supplier AT', 'Company AT', 'supplierAT@company.com', '678905432'),
('Supplier AU', 'Company AU', 'supplierAU@company.com', '789016543'),
('Supplier AV', 'Company AV', 'supplierAV@company.com', '890127654'),
('Supplier AW', 'Company AW', 'supplierAW@company.com', '901238765'),
('Supplier AX', 'Company AX', 'supplierAX@company.com', '012349876'),
('Supplier AY', 'Company AY', 'supplierAY@company.com', '123450987'),
('Supplier AZ', 'Company AZ', 'supplierAZ@company.com', '234561098'),
('Supplier BA', 'Company BA', 'supplierBA@company.com', '345672109'),
('Supplier BB', 'Company BB', 'supplierBB@company.com', '456783210'),
('Supplier BC', 'Company BC', 'supplierBC@company.com', '567894321'),
('Supplier BD', 'Company BD', 'supplierBD@company.com', '678905432'),
('Supplier BE', 'Company BE', 'supplierBE@company.com', '789016543'),
('Supplier BF', 'Company BF', 'supplierBF@company.com', '890127654'),
('Supplier BG', 'Company BG', 'supplierBG@company.com', '901238765'),
('Supplier BH', 'Company BH', 'supplierBH@company.com', '012349876'),
('Supplier BI', 'Company BI', 'supplierBI@company.com', '123450987'),
('Supplier BJ', 'Company BJ', 'supplierBJ@company.com', '234561098'),
('Supplier BK', 'Company BK', 'supplierBK@company.com', '345672109'),
('Supplier BL', 'Company BL', 'supplierBL@company.com', '456783210'),
('Supplier BM', 'Company BM', 'supplierBM@company.com', '567894321'),
('Supplier BN', 'Company BN', 'supplierBN@company.com', '678905432'),
('Supplier BO', 'Company BO', 'supplierBO@company.com', '789016543'),
('Supplier BP', 'Company BP', 'supplierBP@company.com', '890127654'),
('Supplier BQ', 'Company BQ', 'supplierBQ@company.com', '901238765'),
('Supplier BR', 'Company BR', 'supplierBR@company.com', '012349876'),
('Supplier BS', 'Company BS', 'supplierBS@company.com', '123450987'),
('Supplier BT', 'Company BT', 'supplierBT@company.com', '234561098'),
('Supplier BU', 'Company BU', 'supplierBU@company.com', '345672109'),
('Supplier BV', 'Company BV', 'supplierBV@company.com', '456783210'),
('Supplier BW', 'Company BW', 'supplierBW@company.com', '567894321'),
('Supplier BX', 'Company BX', 'supplierBX@company.com', '678905432'),
('Supplier BY', 'Company BY', 'supplierBY@company.com', '789016543'),
('Supplier BZ', 'Company BZ', 'supplierBZ@company.com', '890127654'),
('Supplier CA', 'Company CA', 'supplierCA@company.com', '901238765'),
('Supplier CB', 'Company CB', 'supplierCB@company.com', '012349876'),
('Supplier CC', 'Company CC', 'supplierCC@company.com', '123450987'),
('Supplier CD', 'Company CD', 'supplierCD@company.com', '234561098'),
('Supplier CE', 'Company CE', 'supplierCE@company.com', '345672109'),
('Supplier CF', 'Company CF', 'supplierCF@company.com', '456783210'),
('Supplier CG', 'Company CG', 'supplierCG@company.com', '567894321'),
('Supplier CH', 'Company CH', 'supplierCH@company.com', '678905432'),
('Supplier CI', 'Company CI', 'supplierCI@company.com', '789016543'),
('Supplier CJ', 'Company CJ', 'supplierCJ@company.com', '890127654'),
('Supplier CK', 'Company CK', 'supplierCK@company.com', '901238765'),
('Supplier CL', 'Company CL', 'supplierCL@company.com', '012349876'),
('Supplier CM', 'Company CM', 'supplierCM@company.com', '123450987'),
('Supplier CN', 'Company CN', 'supplierCN@company.com', '234561098'),
('Supplier CO', 'Company CO', 'supplierCO@company.com', '345672109'),
('Supplier CP', 'Company CP', 'supplierCP@company.com', '456783210'),
('Supplier CQ', 'Company CQ', 'supplierCQ@company.com', '567894321'),
('Supplier CR', 'Company CR', 'supplierCR@company.com', '678905432'),
('Supplier CS', 'Company CS', 'supplierCS@company.com', '789016543'),
('Supplier CT', 'Company CT', 'supplierCT@company.com', '890127654'),
('Supplier CU', 'Company CU', 'supplierCU@company.com', '901238765'),
('Supplier CV', 'Company CV', 'supplierCV@company.com', '012349876'),
('Supplier CW', 'Company CW', 'supplierCW@company.com', '123450987'),
('Supplier CX', 'Company CX', 'supplierCX@company.com', '234561098'),
('Supplier CY', 'Company CY', 'supplierCY@company.com', '345672109'),
('Supplier CZ', 'Company CZ', 'supplierCZ@company.com', '456783210');


SELECT * FROM buys.buys_supplier;


INSERT INTO buys.buys_detail (id_item, cost_detail, amount_detail) VALUES
(1, 50, 100),
(2, 60, 200),
(3, 70, 150),
(4, 80, 50),
(5, 90, 300),
(6, 100, 250),
(7, 110, 120),
(8, 120, 100),
(9, 130, 300),
(10, 140, 150),
(11, 150, 200),
(12, 160, 250),
(13, 170, 150),
(14, 180, 100),
(15, 190, 50),
(16, 200, 75),
(17, 210, 120),
(18, 220, 180),
(19, 230, 140),
(20, 240, 110),
(21, 250, 130),
(22, 260, 170),
(23, 270, 90),
(24, 280, 60),
(25, 290, 200),
(26, 300, 220),
(27, 310, 50),
(28, 320, 110),
(29, 330, 180),
(30, 340, 160),
(31, 350, 90),
(32, 360, 100),
(33, 370, 120),
(34, 380, 140),
(35, 390, 230),
(36, 400, 250),
(37, 410, 75),
(38, 420, 60),
(39, 430, 80),
(40, 440, 110),
(41, 450, 190),
(42, 460, 220),
(43, 470, 150),
(44, 480, 130),
(45, 490, 180),
(46, 500, 120),
(47, 510, 160),
(48, 520, 140),
(49, 530, 170),
(50, 540, 200),
(51, 550, 110),
(52, 560, 100),
(53, 570, 80),
(54, 580, 120),
(55, 590, 150),
(56, 600, 180),
(57, 610, 130),
(58, 620, 200),
(59, 630, 220),
(60, 640, 90),
(61, 650, 250),
(62, 660, 150),
(63, 670, 180),
(64, 680, 200),
(65, 690, 120),
(66, 700, 100),
(67, 710, 150),
(68, 720, 180),
(69, 730, 200),
(70, 740, 250),
(71, 750, 170),
(72, 760, 220),
(73, 770, 190),
(74, 780, 140),
(75, 790, 100),
(76, 800, 60),
(77, 810, 50),
(78, 820, 120),
(79, 830, 130),
(80, 840, 110);


SELECT * FROM buys.buys_detail;


INSERT INTO buys.buys (id_user, id_buys_detail, id_buys_supplier) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 6),
(7, 7, 7),
(8, 8, 8),
(9, 9, 9),
(10, 10, 10),
(11, 11, 11),
(12, 12, 12),
(13, 13, 13),
(14, 14, 14),
(15, 15, 15),
(16, 16, 16),
(17, 17, 17),
(18, 18, 18),
(19, 19, 19),
(20, 20, 20),
(21, 21, 21),
(22, 22, 22),
(23, 23, 23),
(24, 24, 24),
(25, 25, 25),
(26, 26, 26),
(27, 27, 27),
(28, 28, 28),
(29, 29, 29),
(30, 30, 30),
(31, 31, 31),
(32, 32, 32),
(33, 33, 33),
(34, 34, 34),
(35, 35, 35),
(36, 36, 36),
(37, 37, 37),
(38, 38, 38),
(39, 39, 39),
(40, 40, 40),
(41, 41, 41),
(42, 42, 42),
(43, 43, 43),
(44, 44, 44),
(45, 45, 45),
(46, 46, 46),
(47, 47, 47),
(48, 48, 48),
(49, 49, 49),
(50, 50, 50),
(51, 51, 51),
(52, 52, 52),
(53, 53, 53),
(54, 54, 54),
(55, 55, 55),
(56, 56, 56),
(57, 57, 57),
(58, 58, 58),
(59, 59, 59),
(60, 60, 60),
(61, 61, 61),
(62, 62, 62),
(63, 63, 63),
(64, 64, 64),
(65, 65, 65),
(66, 66, 66),
(67, 67, 67),
(68, 68, 68),
(69, 69, 69),
(70, 70, 70),
(71, 71, 71),
(72, 72, 72),
(73, 73, 73),
(74, 74, 74),
(75, 75, 75),
(76, 76, 76),
(77, 77, 77),
(78, 78, 78),
(79, 79, 79),
(80, 80, 80);

SELECT * FROM buys.buys;


INSERT INTO promotion.promotion (id_item, amount_promotion, discount) VALUES
(1, 50, 10),
(2, 100, 15),
(3, 75, 20),
(4, 150, 25),
(5, 200, 30),
(6, 250, 35),
(7, 300, 40),
(8, 50, 5),
(9, 75, 10),
(10, 100, 15),
(11, 110, 12),
(12, 120, 18),
(13, 130, 20),
(14, 140, 25),
(15, 160, 28),
(16, 170, 30),
(17, 180, 32),
(18, 190, 35),
(19, 200, 38),
(20, 210, 40),
(21, 220, 15),
(22, 230, 18),
(23, 240, 22);

SELECT * FROM promotion.promotion;

TRUNCATE TABLE promotion.promotion RESTART IDENTITY CASCADE;
TRUNCATE TABLE buys.buys RESTART IDENTITY CASCADE;
TRUNCATE TABLE buys.buys_detail RESTART IDENTITY CASCADE;
TRUNCATE TABLE buys.buys_supplier RESTART IDENTITY CASCADE;
TRUNCATE TABLE sale.sale RESTART IDENTITY CASCADE;
TRUNCATE TABLE sale.sale_detail RESTART IDENTITY CASCADE;
TRUNCATE TABLE sale.client RESTART IDENTITY CASCADE;
TRUNCATE TABLE store.store RESTART IDENTITY CASCADE;
TRUNCATE TABLE store.item RESTART IDENTITY CASCADE;
TRUNCATE TABLE users.control_access RESTART IDENTITY CASCADE;
TRUNCATE TABLE users.employee RESTART IDENTITY CASCADE;
TRUNCATE TABLE users.contrat RESTART IDENTITY CASCADE;
TRUNCATE TABLE users.position RESTART IDENTITY CASCADE;
TRUNCATE TABLE users.area RESTART IDENTITY CASCADE;
TRUNCATE TABLE users.users RESTART IDENTITY CASCADE;



 SELECT 
    s.id AS product_id,               -- ID del producto
    s.name_item AS product_name,       -- Nombre del producto
    s.description_item AS product_description,  -- Descripción del producto
    p.id AS promotion_id,              -- ID de la promoción
    p.date_promotion AS promotion_date, -- Fecha de la promoción
    p.amount_promotion AS promotion_amount, -- Cantidad de la promoción
    p.discount AS promotion_discount  -- Descuento de la promoción
FROM 
    store.item s
JOIN 
    promotion.promotion p ON s.id = p.id_item  -- Relaciona la promoción con el producto
ORDER BY 
    p.date_promotion DESC; 



    

SELECT 
    s.id AS sale_id,                      -- ID de la venta
    s.date_sale AS sale_date,              -- Fecha de la venta
    c.name_client AS client_name,          -- Nombre del cliente asociado a la venta
    sd.id_item AS product_id,              -- ID del producto vendido
    i.name_item AS product_name,           -- Nombre del producto vendido
    sd.cost_detail AS product_cost,        -- Costo del producto vendido
    sd.amount AS amount_sold,              -- Cantidad del producto vendido
    s.stock AS stock_after_sale            -- Stock después de la venta
FROM 
    sale.sale s
JOIN 
    sale.client c ON s.id_client = c.id   -- Relaciona la venta con el cliente
JOIN 
    sale.sale_detail sd ON s.id_detail = sd.id  -- Relaciona la venta con los detalles
JOIN 
    store.item i ON sd.id_item = i.id    -- Relaciona los detalles con los productos
WHERE 
    s.id_user = 1                         -- Reemplaza '1' con el ID del usuario específico
ORDER BY 
    s.date_sale DESC;                     -- Ordena las ventas por la fecha, de más reciente a más antigua



	SELECT 
    e.id AS employee_id,                   -- ID del empleado
    e.name_employee AS employee_name,       -- Nombre del empleado
    e.ap_paterno AS paternal_last_name,     -- Apellido paterno
    e.ap_materno AS maternal_last_name,     -- Apellido materno
    p.name_position AS position_name,       -- Nombre del cargo/posición
    p.description_position AS position_desc -- Descripción del cargo
FROM 
    users.employee e
JOIN 
    users.contrat c ON e.id = c.id_employee       -- Relaciona el empleado con su contrato
JOIN 
    users.position p ON c.id_position = p.id      -- Relaciona el contrato con la posición
WHERE 
    p.name_position = 'Cargo X';                 -- Reemplaza 'Cargo X' con el nombre del cargo deseado


SELECT 
    e.id AS employee_id,                    -- ID del empleado
    e.name_employee AS employee_name,        -- Nombre del empleado
    e.ap_paterno AS paternal_last_name,      -- Apellido paterno del empleado
    e.ap_materno AS maternal_last_name,      -- Apellido materno del empleado
    p.name_position AS position_name,        -- Nombre del cargo/posición
    p.description_position AS position_desc, -- Descripción del cargo
    b.id AS buy_id,                          -- ID de la compra
    b.date_buys AS buy_date                  -- Fecha de la compra
FROM 
    users.employee e
JOIN 
    users.contrat c ON e.id = c.id_employee         -- Relaciona el empleado con su contrato
JOIN 
    users.position p ON c.id_position = p.id        -- Relaciona el contrato con la posición
JOIN 
    buys.buys b ON b.id_user = e.id                 -- Relaciona la compra con el empleado
WHERE 
    b.id_user IS NOT NULL;                          -- Solo empleados que han realizado una compra



	SELECT 
    i.name_item,                                  -- Nombre del producto
    i.description_item,                           -- Descripción del producto
    COALESCE(SUM(CASE WHEN s.motion = 'i' THEN s.amount_store ELSE 0 END), 0) - 
    COALESCE(SUM(CASE WHEN s.motion = 's' THEN s.amount_store ELSE 0 END), 0) AS remaining_quantity -- Cantidad restante
FROM 
    store.item i
LEFT JOIN 
    store.store s ON i.id = s.id_item            -- Unir con la tabla de inventarios
WHERE 
    i.id = 1                                      -- Reemplaza con el ID del producto que deseas consultar
GROUP BY 
    i.id, i.name_item, i.description_item;        -- Agrupar por el producto



SELECT 
    bs.supplier_name,        -- Nombre del proveedor
    bs.company_name,         -- Nombre de la empresa del proveedor
    bs.email,                -- Correo electrónico del proveedor
    bs.number_phone          -- Número de teléfono del proveedor
FROM 
    buys.buys b
JOIN 
    buys.buys_detail bd ON b.id_buys_detail = bd.id  -- Correlacionamos id_buys_detail con id de buys_detail
JOIN 
    buys.buys_supplier bs ON b.id_buys_supplier = bs.id
JOIN 
    store.item i ON bd.id_item = i.id
WHERE 
    i.id = 1;  -- Reemplaza "1" con el ID del producto que deseas buscar


SELECT 
    SUM(sd.amount * sd.cost_detail) AS total_income  -- Sumar los ingresos (cantidad * precio)
FROM 
    sale.sale s
JOIN 
    sale.sale_detail sd ON s.id_detail = sd.id  -- Unir las tablas de ventas y detalles de ventas
WHERE 
    EXTRACT(MONTH FROM s.date_sale) = 3   -- Reemplaza el 3 con el mes deseado (1-12)
    AND EXTRACT(YEAR FROM s.date_sale) = 2025;  -- Reemplaza 2025 con el año deseado


SELECT 
    i.name_item,                          -- Nombre del producto
    SUM(sd.amount) AS total_sold          -- Suma de las cantidades vendidas
FROM 
    sale.sale s
JOIN 
    sale.sale_detail sd ON s.id_detail = sd.id   -- Unimos las tablas de ventas y detalles de ventas
JOIN 
    store.item i ON sd.id_item = i.id           -- Unimos con la tabla de productos
GROUP BY 
    i.name_item                                -- Agrupamos por producto
ORDER BY 
    total_sold DESC                            -- Ordenamos por la cantidad vendida de mayor a menor
LIMIT 1;                                        -- Limitamos a 1 para obtener solo el más vendido


SELECT 
    c.name_client,                         -- Nombre del cliente
    SUM(sd.amount) AS total_products_bought -- Suma de la cantidad de productos comprados
FROM 
    sale.sale s
JOIN 
    sale.sale_detail sd ON s.id_detail = sd.id  -- Unimos la tabla de ventas con los detalles de venta
JOIN 
    sale.client c ON s.id_client = c.id        -- Unimos la tabla de clientes
GROUP BY 
    c.name_client                             -- Agrupamos por cliente
ORDER BY 
    total_products_bought DESC                 -- Ordenamos de mayor a menor por la cantidad de productos comprados
LIMIT 1;                                       -- Limitamos a 1 para obtener al cliente que más productos ha comprado



SELECT 
    c.name_client,                                   -- Nombre del cliente
    SUM(sd.amount * sd.cost_detail) AS total_cost     -- Suma del costo total de las compras
FROM 
    sale.sale s
JOIN 
    sale.sale_detail sd ON s.id_detail = sd.id       -- Unimos la tabla de ventas con los detalles de venta
JOIN 
    sale.client c ON s.id_client = c.id              -- Unimos la tabla de clientes
GROUP BY 
    c.name_client                                    -- Agrupamos por cliente
ORDER BY 
    total_cost DESC                                  -- Ordenamos de mayor a menor por el costo total de compra
LIMIT 1;                                            -- Limitamos a 1 para obtener al cliente con el costo más alto



SELECT COUNT(*) AS total_clients
FROM sale.client;



SELECT sd.id_item, i.name_item, i.description_item, s.stock
FROM sale.sale s
JOIN sale.sale_detail sd ON s.id_detail = sd.id
JOIN store.item i ON sd.id_item = i.id
WHERE s.stock < 10;



