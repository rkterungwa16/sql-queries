DROP SCHEMA IF EXISTS cashtoken_core;
CREATE SCHEMA cashtoken_core;
USE cashtoken_core;

CREATE TABLE users (
  id INT NOT NULL AUTO_INCREMENT,
  phone_number VARCHAR(45),
  access_token VARCHAR(255),
  password VARCHAR(8),
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (id)
);

-- One user can be of different types
-- One type can have different users

CREATE TABLE user_roles (
    users_id INT NOT NULL,
    roles_id INT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (users_id, roles_id),
    FOREIGN KEY (users_id) REFERENCES users (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (roles_id) REFERENCES roles (id) ON DELETE RESTRICT ON UPDATE CASCADE
)

CREATE TABLE roles (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(45),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
)

-- A profile belongs to one user
-- A user has one profile
-- A profile has one address
-- An address belongs to one profile
-- If user is deleted a profile is deleted
-- If a user is updated, a profile is updated
-- If address is deleted profile is not deleted
-- If address is updated profile is updated
CREATE TABLE profiles (
  user_id INT NOT NULL,
  first_name VARCHAR(45),
  last_name VARCHAR(45),
  brand_name VARCHAR(45),
  dob DATE,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (id),
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE,
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- A user has one address
-- An address only belongs to one user
-- If a user is deleted address associated is deleted
CREATE TABLE addresses (
    user_id INT NOT NULL,
    local_govt VARCHAR(45),
    state VARCHAR(45),
    street VARCHAR(45),
    country VARCHAR(45),
    zip_code VARCHAR(45),
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id),
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE
)

-- a user has a profile
-- a profile belongs to one user
-- a user is of more than one type
-- a type has more than one users

-- a user has one cashtoken
-- a price pool has more than one cashtokens
-- one cashtoken belongs to one price pool

-- I buy a cashtoken for 3000 Naira
-- user has one cashtoken
-- user has more than one payment for cashtoken
-- A user can have more than one price pool
-- A price pool can belong to more than one users

-- a user can have more than one payments
-- a payment can only belong to one user
-- a price pool can have more than one payment

CREATE TABLE pools (
    id INT NOT NULL,
    price DECIMAL(17,2),
    is_active TINYINT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
)

-- If a user is deleted, delete cashtoken,
-- if price pool is deleted delete cashtoken
CREATE TABLE cashtokens (
    user_id INT NOT NULL,
    pool_id INT NOT NULL,
    value INT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, pool_id),
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (pool_id) REFERENCES pools (id) ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE payments (
    user_id INT NOT NULL,
    pool_id INT NOT NULL,
    amount DECIMAL(17,2),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, pool_id),
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (pool_id) REFERENCES pools (id) ON DELETE CASCADE ON UPDATE CASCADE
)

-- I make payment for current pool_id
-- create transaction for payment and cashtoken
-- both payment and cashtoken are acid
