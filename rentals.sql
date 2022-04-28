--Customer 'Angel' has rented 'SBA1111A' from today for 10 days. (Hint: You need to insert a rental record. Use a SELECT subquery to get the customer_id to do this you will need to use parenthesis for your subquery as one of your values. Use CURDATE() (or NOW()) for today, and DATE_ADD(CURDATE(), INTERVAL x unit) to compute a future date.)
INSERT INTO rental_records (rental_id, veh_reg_no, customer_id, start_date, end_date)
VALUES (NULL,'SBA1111A',(SELECT customer_id FROM Customers 
WHERE name = 'Angel'), CURDATE(), DATE_ADD(CURDATE(), INTERVAL 10 DAY), NULL); 

--Customer 'Kumar' has rented 'GA5555E' from tomorrow for 3 months.
INSERT INTO rental_records rental_records (rental_id, veh_reg_no, customer_id, start_date, end_date)
VALUES (NULL,'GA5555E', (SELECT customer_id FROM Customers 
WHERE name = 'Kumar'), DATE_ADD(CURDATE(), INTERVAL 1 DAY), 
DATE_ADD(CURDATE(), INTERVAL 3 MONTH), NULL); 

--List all rental records (start date, end date) with vehicle's registration number, brand, and customer name, sorted by vehicle's categories followed by start date.
SELECT start_date, end_date, veh_reg_no, brand, name
FROM rental_records
INNER JOIN Vehicles USING(veh_reg_no)
INNER JOIN Customers USING(customer_id)
ORDER BY category, start_date; 

--List all the expired rental records (end_date before CURDATE()).
SELECT * FROM rental_records WHERE end_date < CURDATE();

--List the vehicles rented out on '2012-01-10' (not available for rental), in columns of vehicle registration no, customer name, start date and end date. (Hint: the given date is in between the start_date and end_date.)
SELECT veh_reg_no, name, start_date, end_date
FROM rental_records
INNER JOIN Vehicles USING(veh_reg_no)
INNER JOIN Customers USING(customer_id)
WHERE '2012-01-10' BETWEEN start_date AND end_date; 

--List all vehicles rented out today, in columns registration number, customer name, start date, end date.
SELECT veh_reg_no, name, start_date, end_date FROM rental_records
INNER JOIN Vehicles Using(veh_reg_no)
INNER JOIN Customers Using(customer_id)
WHERE CURDATE() BETWEEN start_date AND End_date;

--Similarly, list the vehicles rented out (not available for rental) for the period from '2012-01-03' to '2012-01-18'. (Hint: start_date is inside the range; or end_date is inside the range; or start_date is before the range and end_date is beyond the range.)
SELECT veh_reg_no, name, start_date, end_date FROM rental_records
WHERE (start_date BETWEEN '2012-01-03' AND '2012-01-18') 
OR (end_date BETWEEN '2012-01-03' AND '2012-01-18') 
OR ((start_date < '2012-01-03') AND (end_date > '2012-01-18'));

--List the vehicles (registration number, brand and description) available for rental (not rented out) on '2012-01-10' (Hint: You could use a subquery based on a earlier query).
SELECT veh_reg_no, brand, Vehicles.desc FROM rental_records
INNER JOIN Vehicles Using(veh_reg_no)
WHERE NOT '2012-01-10' BETWEEN start_date AND end_date; 

--Similarly, list the vehicles available for rental for the period from '2012-01-03' to '2012-01-18'.
SELECT veh_reg_no, brand, Vehicles.desc FROM rental_records
INNER JOIN Vehicles USING(veh_reg_no)
WHERE NOT (start_date BETWEEN '2012-01-03' AND '2012-01-18') 
OR (end_date BETWEEN '2012-01-03' AND '2012-01-18') 
OR ((start_date < '2012-01-03') AND (end_date > '2012-01-18'));

--Similarly, list the vehicles available for rental from today for 10 days.
SELECT veh_reg_no, brand, Vehicles.desc FROM rental_records
INNER JOIN Vehicles USING(veh_reg_no)
WHERE (start_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 10 DAY)) 
OR (end_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 10 DAY)) 
OR ((start_date < CURDATE()) AND (end_date > DATE_ADD(CURDATE(), INTERVAL 10 DAY))); 