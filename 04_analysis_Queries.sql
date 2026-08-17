INSERT INTO ecommerce.Customers
(CoustomerName, Country, Age, RegistrationDate, Email)

VALUES
('John Smith','Canada',35,'2024-01-15','john.smith@email.com'),
('Sarah Brown','Canada',29,'2024-02-20','sarah.brown@email.com'),
('Ali Ahmadi','Iran',41,'2024-03-10','ali.ahmadi@email.com'),
('Emma Wilson','USA',32,'2024-04-05','emma.wilson@email.com'),
('David Miller','Canada',45,'2024-05-12','david.miller@email.com');


INSERT INTO ecommerce.Products
(ProductName, Brand, Category, Price)

VALUES
('Laptop','Dell','Electronics',1200),
('Smartphone','Apple','Electronics',999),
('Keyboard','Logitech','Accessories',80),
('Office Chair','Ikea','Furniture',250),
('Desk','Ikea','Furniture',400),
('Headphones','Sony','Electronics',150);

INSERT INTO ecommerce.Orders
(CustomerID, OrderDate, TotalAmounts)

VALUES
(1,'2024-06-01',1280),
(2,'2024-06-05',999),
(3,'2024-06-10',330),
(1,'2024-07-01',150),
(5,'2024-07-03',400);

INSERT INTO ecommerce.OrderDetails
(OrderID, ProductID, Quantity, UnitPrice)

VALUES
(2,1,1,1200),
(2,3,1,80),
(3,2,1,999),
(4,4,1,250),
(4,3,1,80),
(5,6,1,150),
(6,5,1,400);



