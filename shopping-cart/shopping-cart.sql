DROP SCHEMA IF EXISTS shopping_cart;
CREATE SCHEMA shopping_cart;
USE shopping_cart;

CREATE TABLE customers (
  id INT NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45),
  email VARCHAR(45),
  password VARCHAR(8),
  created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO customers (first_name, last_name, email, password)
VALUES ('Terungwa','Kombol','terungwakombol@gmail.com', '12345678');

INSERT INTO customers (first_name, last_name, email, password)
VALUES ('Richard','Kombol','richardkombol@gmail.com', '12345678');

CREATE TABLE categories (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(45),
  description VARCHAR(255),
  created_on TIMESTAMP  NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO categories (name, description)
VALUES ('phones & tablets','Mobile phones tablets smart phones');

INSERT INTO categories (name, description)
VALUES ('computing','Laptops desktops printers etc');

INSERT INTO categories (name, description)
VALUES ('electronics','Television, speakers');

INSERT INTO categories (name, description)
VALUES ('fashion','All types of clothes from children to adults, females and mail');

INSERT INTO categories (name, description)
VALUES ('gaming','video games consoles etc');

INSERT INTO categories (name, description)
VALUES ('grocery','fruits and vegetable etc');

-- If you delete a customer cart should be deleted
CREATE TABLE carts (
  customer_id INT NOT NULL,
  active BOOLEAN DEFAULT false,
  created_on TIMESTAMP  NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (customer_id),
  FOREIGN KEY (customer_id) REFERENCES customers (id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- If you delete a category, then products having that category should be deleted
CREATE TABLE products (
  id INT AUTO_INCREMENT,
  category_id INT NOT NULL,
  name VARCHAR(45),
  description VARCHAR(255),
  stock_quantity INT DEFAULT 0,
  created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (id),
  FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- If you delete a cart, then cart_items having that cart should be deleted
-- If you delete a product, then cart_items having that product should be deleted
CREATE TABLE cart_items (
  carts_id INT NOT NULL,
  products_id INT NOT NULL,
  quantity INT DEFAULT 0,
  created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (carts_id, products_id),
  FOREIGN KEY (carts_id) REFERENCES carts (customer_id) ON DELETE CASCADE,
  FOREIGN KEY (products_id) REFERENCES products (id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- List all Customers
SELECT * FROM customers;

-- Find customer whose email is terungwakombol@gmail.com
CREATE VIEW find_customer_id
AS
SELECT id FROM customers
WHERE email = 'terungwakombol@gmail.com';

CREATE VIEW find_category_id
AS
SELECT id FROM categories
WHERE name = 'phones & tablets';

-- Look into Stored Procedures, Functions and Variables
-- INSERT INTO products (category_id, name, description, stock_quantity)
-- VALUES (
--   SELECT id FROM find_category_id,
--   'Galaxy A30',
--   '6.4-Inch (4GB RAM, 64GB ROM) Android 9.0 Pie, (16MP + 5MP) + 16MP 4G LTE Dual Sim Smartphone - Black',
--   10);

--  - Honor/glory Play
--  - IPhone 7plus
--  - Mate23 Smart Phone
--  - Xiaomi Redmi Note 7
--  - S11 Lite
--  - HOT 7 Pro
--  - Galaxy A20
--  - Millet Redmi Note7pro
