-- Table: Customer
CREATE TABLE Customer (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20)
);

-- Table: AddressType
CREATE TABLE AddressType (
    address_type_id SERIAL PRIMARY KEY,
    address_type VARCHAR(20) NOT NULL
);

-- Table: Address
CREATE TABLE Address (
    address_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    street1 VARCHAR(255) NOT NULL,
    street2 VARCHAR(255),
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100),
    postal_code VARCHAR(20),
    country_cd CHAR(2) NOT NULL,
    address_type_id INT,

    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON DELETE CASCADE,
    CONSTRAINT fk_address_type FOREIGN KEY (address_type_id) REFERENCES AddressType(address_type_id)
);
