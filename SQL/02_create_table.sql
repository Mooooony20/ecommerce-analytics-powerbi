USE Ecommerce_Analytics;
GO

CREATE SCHEMA ecommerce;
GO

CREATE TABLE ecommerce.Customers
(
   CustomerID INT IDENTITY(1,1) PRIMARY KEY,
   ProductName VARCHAR(100),
   Country VARCHAR(50),
   Age Int,
   RegistrationDate DATE,
   Email NVARCHAR(100)
);
GO

CREATE TABLE ecommerce.Products
(
   ProductID INT IDENTITY(1,1) PRIMARY KEY,
   ProductName VARCHAR(100),
   Brand VARCHAR(50),
   Category VARCHAR(50),
   Price DECIMAL(10,2)
);


CREATE TABLE ecommerce.Orders
(
   OrderID INT IDENTITY(1,1) PRIMARY KEY,
   CustomerID INT,
   OrderDate DATE,
   TotalAmounts DECIMAL(10,2)

   FOREIGN KEY (CustomerID)
   REFERENCES ecommerce.Customers(CustomerId)
);
GO

CREATE TABLE ecommerce.OrderDetails
(
OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
OrderID INT,
ProductID INT,
Quantity INT,
UnitPrice DECIMAL(10,2),

FOREIGN KEY (OrderID)
REFERENCES ecommerce.Orders(OrderID),

FOREIGN KEY (ProductID)
REFERENCES ecommerce.Products(ProductID)
);