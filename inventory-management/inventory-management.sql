DROP SCHEMA IF EXISTS cinventory_management;
CREATE SCHEMA inventory_management;
USE inventory_management;

-- a user can have only one address
-- an address can only belong to one user
-- since an address only belongs to one user, foreign key is user id
CREATE TABLE addresses (
    id INT NOT NULL,
    local_govt VARCHAR(45),
    state VARCHAR(45),
    street VARCHAR(45),
    country VARCHAR(45),
    zip_code VARCHAR(45),
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE users (
  id INT NOT NULL AUTO_INCREMENT,
  address_id INT,
  phone_number VARCHAR(45),
  email VARCHAR(255),
  password VARCHAR(8),
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- a user has one profile
-- a user cannot not have more than one profile
-- a single profile cannot belong to more than one user
-- since profile belongs to a user. foreign key is user_id
CREATE TABLE profiles (
  user_id INT NOT NULL,
  address_id INT,
  first_name VARCHAR(45),
  last_name VARCHAR(45),
  brand_name VARCHAR(45),
  dob DATE,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (id),
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (addresses_id) REFERENCES addresses (id) ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- categories contains different products
CREATE TABLE categories (
    id INT NOT NULL,
    name VARCHAR(15),
    PRIMARY KEY (id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- a product belongs to a category
-- a category has many products
-- since a product can only belong to one category, foreign key is category
-- identify a unique product using its id
-- example egg, per crate, 1000 naira per crate, food category
-- delete a category and delete all products associated with it
-- update a category and update all products associated with it
CREATE TABLE products (
    id INT NOT NULL,
    categories_id INT NULL,
    name VARCHAR(15),
    unit_cost INT,
    unit_size VARCHAR(15), -- kg, bag, case, each
    PRIMARY KEY (id),
    FOREIGN KEY (categories_id) REFERENCES categories (id) ON DELETE CASCADE ON UPDATE CASCADE,
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- one stock has a product
-- one product can only belong to one stock
-- since one stock can only have one product, stock foreign key is product
-- quanity of stocks is based on unit size for a product
-- value of stock is quantity * unit_cost
-- if product is deleted then related stock will be deleted
CREATE TABLE stocks (
    products_id INT NOT NULL,
    quantity INT,
    value DECIMAL(17,2),
    PRIMARY KEY (products_id),
    FOREIGN KEY (products_id) REFERENCES products (id)   ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- transaction types purchases, sales
CREATE TABLE transaction_types (
    id INT NOT NULL,
    name VARCHAR(15),
    PRIMARY KEY (id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- transaction types purchases, sales
CREATE TABLE transactions (
    id INT NOT NULL,
    products_id INT NOT NULL,
    transaction_types_id INT NOT NULL,
    name VARCHAR(15),
    PRIMARY KEY (id),
    FOREIGN KEY (products_id) REFERENCES products (id)   ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (transaction_types_id) REFERENCES transaction_types (id)   ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
