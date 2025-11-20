CREATE TABLE Customers(
    customers_id INT PRIMARY KEY,
    full_name VARCHAR(255),
    email VARCHAR(255)
);

CREATE TABLE Orders(
    order_id INT PRIMARY KEY,
    date_order DATE,
    customers_id INT,
    FOREIGN KEY (customers_id) REFERENCES Customers (customers_id)
);

CREATE TABLE Products(
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    price INT
);

CREATE TABLE Product_in_order(
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders (order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
