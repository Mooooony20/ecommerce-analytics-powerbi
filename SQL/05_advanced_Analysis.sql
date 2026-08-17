USE Ecommerce_Analytics;

GO

--  Analysis 1. Order Revenue Analysis

SELECT

    o.OrderID,

    c.CustomerName,

    o.OrderDate,

    o.TotalAmounts

FROM ecommerce.Orders o

JOIN ecommerce.Customers c

    ON o.CustomerID = c.CustomerID

ORDER BY o.TotalAmounts DESC;

-- Analysis 2. Top Selling Products

SELECT
    P.ProductName,
    SUM(od.Quantity) AS TotalQuantitySold,
    Sum(od.Quantity * od.UnitPrice)AS TotalRevenue
FROM ecommerce.OrderDetails od
JOIN ecommerce.Products P
     ON od.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalQuantitySold DESC;

-- Analysis 3. Revenue by Category

SELECT
    p.Category,
    SUM(od.Quantity * od.UnitPrice) AS TotalRevenue
FROM ecommerce.OrderDetails od
JOIN ecommerce.Products p
     ON od.ProductID = p.ProductID
GROUP BY p.Category
ORDER BY TotalRevenue DESC;

-- Analysis 4. Customer Analysis

SELECT
    c.CustomerID,
    c.CustomerName,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(od.Quantity * od.UnitPrice) AS TotalSpent
FROM ecommerce.Customers c
JOIN ecommerce.Orders o
     ON c.CustomerID = o.CustomerID
JOIN ecommerce.OrderDetails od
     ON o.OrderID = od.OrderID
GROUP BY 
     c.CustomerId,
     c.CustomerName
ORDER BY 
     TotalSpent DESC;

-- Analysis 5. Top 5 Customers

SELECT Top 5
    c.CustomerID,
    c.CustomerName,
    SUM(od.Quantity * od.UnitPrice) AS TotalSpent
FROM ecommerce.Customers c
JOIN ecommerce.Orders o
     ON c.CustomerID = o.CustomerID
JOIN ecommerce.OrderDetails od
     ON o.OrderID = od.OrderID
GROUP BY 
     c.CustomerId,
     c.CustomerName
ORDER BY 
     TotalSpent DESC;

-- Analysis 6. Montly Sale Trend

SELECT Top 5
    FORMAT(Orders.OrderDate , 'yyyy-MM') AS SaleMonth,
    SUM(od.Quantity * od.UnitPrice) AS MonthlyRevenue
FROM ecommerce.Orders As Orders
JOIN ecommerce.OrderDetails od
     ON Orders.OrderID = od.OrderID
GROUP BY 
     FORMAT(Orders.OrderDate, 'yyyy-MM')
ORDER BY 
     SaleMonth;           

-- Analysis 7. Product Performance Ranking


WITH ProductSales AS
(
    SELECT 
        p.ProductID,
        p.ProductName,
        SUM(od.Quantity * od.UnitPrice) AS TotalRevenue
    FROM ecommerce.Products p
    JOIN ecommerce.OrderDetails od
         ON p.ProductID = od.ProductID
    GROUP BY 
         p.ProductID,
         p.ProductName
)
SELECT 
    ProductId,
    ProductName,
    TotalRevenue,
    RANK() OVER (ORDER BY TotalRevenue DESC) AS ProductRank
FROM productsales;

-- Analysis 8. Customer Rankin
SELECT 
        c.CustomerID,
        c.CustomerName,
        SUM(o.TotalAmounts) AS TotalSpent,
        RANK() OVER (ORDER BY Sum(o.TotalAmounts) DESC) AS CustomerRank
FROM ecommerce.Customers c
JOIN ecommerce.Orders o
        ON c.CustomerID = o.CustomerID
GROUP BY 
         c.CustomerID,
         c.CustomerName; 
     
-- Analysis 9. Runing Total
SELECT
    OrderDate,
    SUM(TotalAmounts) AS DailyRevenue,
    SUM(SUM(TotalAmounts)) OVER (
        ORDER BY OrderDate
    ) AS RunningTotal
FROM ecommerce.Orders
GROUP BY OrderDate
ORDER By OrderDate;

-- Analysis 10.Monthly Growth Analysis
WITH MonthlyRevenue AS
(
    SELECT
        YEAR(OrderDate) AS SalesYear,
        MONTH(OrderDate) AS SalesMonth,
        SUM(TotalAmounts) AS MonthlyRevenue
    FROM ecommerce.Orders
    GROUP BY 
        YEAR(OrderDate),
        MONTH(OrderDate)
)

SELECT
    SalesYear,
    SalesMonth,
    MonthlyRevenue,
    LAG(MonthlyRevenue) OVER (
        ORDER BY SalesYear, SalesMonth
    ) AS PreviousMonthRevenue,
    MonthlyRevenue -
    LAG(MonthlyREvenue) OVER (
        ORDER BY SalesYear, SalesMonth
    ) AS RevenueGrowth
FROM MonthlyRevenue
ORDER BY SalesYear, SalesMonth;

-- Analysis 11.Customer Segmentation
SELECT
    c.CustomerId,
    c.CustomerName,
    SUM(o.TotalAmounts) AS TotalSpent,
    CASE
        WHEN SUM(o.TotalAmounts) >= 1000 THEN 'High Value Customer'
        WHEN SUM(o.TotalAmounts) >= 500 THEN 'Medium Value Customer'
        ELSE 'Low Value Customer'
    END AS CustomerSegment
FROM ecommerce.Customers c
JOIN ecommerce.Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerId,
    c.CustomerName
ORDER BY 
    TotalSpent DESC;

-- Analysis 12.RFM Customer Analysis
WITH CustomerRFM AS
(
    SELECT 
        c.CustomerID,
        c.CustomerName,
        MAX(o.OrderDate) AS LastPurchaseDate,
        COUNT (o.OrderID) AS Frequency,
        SUM(o.TotalAmounts) AS Monetary
    FROM ecommerce.Customers c
    JOIN ecommerce.Orders o
        ON c.CustomerID = o.CustomerID
    GROUP BY
        c.CustomerID,
        c.CustomerName
)

SELECT *
FROM CustomerRFM






