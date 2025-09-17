-- Question 1: Achieving 1NF

-- Original table ProductDetail has a multivalued column "Products"
-- Example: (101, John Doe, Laptop, Mouse)
-- To achieve 1NF: each row must represent a single product per order.

-- Create a new normalized table ProductDetail_1NF
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50)
);

-- Insert transformed data (each product gets its own row)
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product) VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');
-- Now each row has only one product (1NF achieved).
SELECT * FROM ProductDetail_1NF;


-- Question 2: Achieving 2NF

-- Original table OrderDetails (already in 1NF):
-- OrderID, CustomerName, Product, Quantity
-- Problem: CustomerName depends only on OrderID (partial dependency).
-- To achieve 2NF: separate data into two tables:
-- (a) Orders table (OrderID, CustomerName)
-- (b) OrderItems table (OrderID, Product, Quantity)

-- Create Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Create OrderItems table
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(50),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert data into Orders table
INSERT INTO Orders (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Insert data into OrderItems table
INSERT INTO OrderItems (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

-- Orders table now contains only OrderID -> CustomerName
-- OrderItems table ensures (OrderID + Product) -> Quantity
-- No partial dependencies remain (2NF achieved).
SELECT * FROM Orders;
SELECT * FROM OrderItems;
