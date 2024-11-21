#task1
CREATE VIEW OrdersView AS
SELECT OrderID, Quantity, TotalCost AS Cost
FROM orders
WHERE Quantity > 2;

SELECT * FROM OrdersView;

#task2
SELECT c.CustomerID, c.FullName, o.OrderID, o.TotalCost, m.Speciality, m.Main
FROM customers c
JOIN orders o ON c.CustomerID = o.CustomerID
JOIN menu m ON o.OrderID = m.OrderID
WHERE o.TotalCost > 150
ORDER BY o.TotalCost;

#task3
SELECT Speciality, Starter, Main, Dessert
FROM menu
WHERE OrderID IN (
    SELECT OrderID
    FROM orders
    GROUP BY OrderID
    HAVING COUNT(*) > 2
);

#procedures
#task1
DELIMITER //

CREATE PROCEDURE GetMaxQuantity()
BEGIN
    SELECT MAX(Quantity) AS MaxQuantity FROM orders;
END//

DELIMITER ;

CALL GetMaxQuantity();

#task2
DELIMITER //

CREATE PROCEDURE GetOrderDetail (IN inputCustomerID VARCHAR(100))
BEGIN
    SELECT OrderID, Quantity, TotalCost
    FROM Orders
    WHERE CustomerID = inputCustomerID;
END //

DELIMITER ;

SET @id = '1';
CALL GetOrderDetail(@id);

#task3
DELIMITER //

CREATE PROCEDURE CancelOrder(IN input_OrderID VARCHAR(100))
BEGIN
    DECLARE order_exists INT;
    
    SELECT COUNT(*) INTO order_exists FROM orders WHERE OrderID = input_OrderID;
    
    IF order_exists > 0 THEN
        DELETE FROM menu WHERE OrderID = input_OrderID;
        DELETE FROM orders WHERE OrderID = input_OrderID;
        DELETE FROM shipping WHERE OrderID = input_OrderID;
        SELECT 'Order canceled successfully';
    ELSE
        SELECT 'Order not found';
    END IF;
    
END //

DELIMITER ;

CALL CancelOrder('ID_DEL_PEDIDO_A_CANCELAR'); #id pedido a cancelar



