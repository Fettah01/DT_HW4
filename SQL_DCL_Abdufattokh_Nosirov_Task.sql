CREATE USER rentaluser WITH PASSWORD 'rentalpassword';
GRANT CONNECT ON DATABASE dvdrental TO rentaluser;
GRANT SELECT ON TABLE customer TO rentaluser;
SELECT * FROM customer;
CREATE ROLE rental;
GRANT rental TO rentaluser;
GRANT INSERT, UPDATE ON TABLE rental TO rental;
SET ROLE rentaluser
INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
VALUES ('2022-04-14', 134, 476, '2023-12-01', 2, CURRENT_TIMESTAMP);
UPDATE rental
SET rental_date = '2023-10-10'
WHERE rental_date = '2022-04-14';
RESET ROLE
REVOKE UPDATE ON TABLE rental FROM rental;
GRANT INSERT ON TABLE rental TO rental;
REVOKE INSERT ON TABLE rental FROM rental;
INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
VALUES ('2023-11-25', 454, 457, '2023-12-05', 1, CURRENT_TIMESTAMP);
CREATE ROLE client_MARY_SMITH;
GRANT SELECT ON TABLE rental TO client_MARY_SMITH;
GRANT SELECT ON TABLE payment TO client_MARY_SMITH;
ALTER TABLE rental ENABLE ROW LEVEL SECURITY;
ALTER TABLE payment ENABLE  ROW LEVEL SECURITY;
CREATE POLICY rental_rls
    ON rental
    FOR SELECT
    USING (customer_id = (SELECT customer_id FROM customer WHERE first_name = 'MARY' AND last_name = 'SMITH'));
CREATE POLICY payment_rls
    ON payment
    FOR SELECT
    USING (customer_id = (SELECT customer_id FROM customer WHERE first_name = 'MARY' AND last_name = 'SMITH'));
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name IN ('customer', 'rental', 'payment') AND column_name = 'customer_id';
