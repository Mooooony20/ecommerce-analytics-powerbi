
USE Ecommerce_Analytics;
GO

--Analysis 13: SQL View for POwer BI
--View 1: Sale Overview
CREATE OR ALTER VIEW ecommerce.vw_SalesOverview
AS
SELECT
	COUNT(OrderID) AS TotalOrders,
	SUM(TotalAmounts) AS TotalRevenue,
	AVG(TotalAmounts) AS AverageOrderValue
FROM ecommerce.Orders;
GO

--Test View 1
SELECT *
FROM ecommerce.vw_SalesOverview;
GO

--View 2: Customer Performace
CREATE OR ALTER VIEW ecommerce.vw_CustomerPerformance
AS
SELECT
	c.CustomerId,
	c.customerName,
	COUNT(o.OrderID) AS TotalOrders,
	SUM(o.TotalAmounts) AS TotalRevenue,
	AVG(o.TotalAmounts) AS AverageOrderValue
FROM ecommerce.Customers c
JOIN ecommerce.Orders o
	ON c.CustomerID = o.CustomerID
GROUP BY
	c.CustomerID,
	c.CustomerName;
GO

--Test View 2
SELECT *
FROM ecommerce.vw_CustomerPerformance;
GO

--View 3: Product Performace
CREATE OR ALTER VIEW ecommerce.vw_ProductPerformance
AS
SELECT
	p.ProductId,
	p.ProductName,
	p.Category,
	SUM(od.Quantity) AS TotalQuantitySold,
	SUM(od.Quantity * od.UnitPrice) AS TotalRevenue
FROM ecommerce.Products p
JOIN ecommerce.OrderDetails od
	ON p.ProductID = od.ProductID
GROUP BY
	p.ProductId,
	p.ProductName,
	p.Category;
GO

--Test View 3
SELECT *
FROM ecommerce.vw_ProductPerformance;
GO



--View 4: CustomerSegmentation


DROP VIEW IF EXISTS dbo.vw_CustomerSegmentation
GO

CREATE VIEW dbo.vw_CustomerSegmentation AS
SELECT
		CustomerId,
		MAX(OrderDate) AS LastPurchaseDate,
		Count(OrderID) AS TotalOrders,
		SUM(TotalAmounts) AS TotalRevenue,
		AVG(TotalAmounts) AS AverageOrderValue
FROM Ecommerce.Orders
GROUP BY CustomerID;
GO
--Test View 4
SELECT *
FROM dbo.vw_CustomerSegmentation
ORDER BY TotalRevenue DESC;
GO