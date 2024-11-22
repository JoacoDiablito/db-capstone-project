#CRUD OPERATIONS
#1
INSERT INTO bookings (BookingID, Date, TableNo, CustomerID) 
VALUES ('1', '2022-10-10', 5, '1'),
       ('2', '2022-11-12', 3, '3'),
       ('3', '2022-10-11', 2, '2'),
       ('4', '2022-10-13', 2, '1');
#2

DELIMITER //


CREATE PROCEDURE CheckBooking(IN booking_date DATE, IN table_number INT)
BEGIN
    DECLARE booking_count INT;

    SELECT COUNT(*) INTO booking_count
    FROM bookings
    WHERE Date = booking_date AND TableNo = table_number;

    IF booking_count > 0 THEN
        SELECT 'Table is already booked on the specified date' AS Message;
    ELSE
        SELECT 'Table is available for booking on the specified date' AS Message;
    END IF;
END //

DELIMITER ;

#call
CALL CheckBooking('2022-10-11', 2);

#3
DROP PROCEDURE AddValidBooking;
DELIMITER $$
CREATE PROCEDURE AddValidBooking(IN bookingDate DATE, IN tableNumber INT)
BEGIN
	DECLARE tableReserved INT;
	START TRANSACTION;
	SELECT COUNT(*) INTO tableReserved
	FROM bookings
	WHERE Date = bookingDate AND TableNo = tableNumber;
	IF tableReserved > 0 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Table already reserved for the selected date. Booking rejected.';
	ELSE
		INSERT INTO bookings (BookingID, CustomerID, Date, TableNo)
		VALUES (UUID(), CustomerID, bookingDate, tableNumber);
	END IF;
	COMMIT;
END $$

DELIMITER ;

#call
CALL AddValidBooking('2022-10-11', 2);customers

#actualizar y cancelar reservas

#1
DELIMITER $$

CREATE PROCEDURE AddBooking (IN bookingID VARCHAR(100), IN customerID VARCHAR(100), IN bookingDate DATE, IN tableNo INT)
BEGIN
    INSERT INTO bookings (BookingID, CustomerID, Date, TableNo)
    VALUES (bookingID, customerID, bookingDate, tableNo);
END $$

DELIMITER ;

#call
CALL AddBooking(9, 3, 4, "2022-12-30");

#2
DELIMITER $$

CREATE PROCEDURE UpdateBooking(IN bookingID VARCHAR(100), IN newDate DATE)
BEGIN
    UPDATE bookings
    SET Date = newDate
    WHERE BookingID = bookingID;
END $$

DELIMITER ;

#CALL
CALL UpdateBooking(9, "2022-12-17");

#3

DELIMITER $$

CREATE PROCEDURE CancelBooking(IN BookingID VARCHAR(100))
BEGIN
    DELETE FROM bookings WHERE BookingID = BookingID;
    SELECT 'Booking successfully cancelled' AS Result;
END $$

DELIMITER ;

#call

CALL CancelBooking(9);
