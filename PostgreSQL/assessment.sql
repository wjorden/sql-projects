-- confirm tables do not already exits
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS contact;
DROP TABLE IF EXISTS address;

-- create employee table (date format is YYYY-MM-DD)
CREATE TABLE employee( id int NOT NULL PRIMARY KEY, fname varchar(255), lname varchar(255), age int, hiredate date);
-- insert employee data (some years were 2 digits, assumed 20xx for all as they were the leading years)
INSERT INTO employee(id, fname, lname, age, hiredate)
VALUES
(01, 'Alan', 'Palmer', 32, '2019-12-15'),
(02, 'Susan', 'Shepard', 28, '2015-07-21'),
(03, 'Justin', 'Ward', 43, '22017-08-24'),
(04, 'Alan', 'Smith', 30, '2017-06-22'),
(05, 'James', 'Betternot', 26, '2017-06-22'),
(06, 'Ralph', 'White', 44, '2017-06-23'),
(07, 'Leonard', 'Nimoy', 72, '2007-12-14'),
(08, 'Janice', 'Rand', 61, '2016-07-06'),
(09, 'Harry', 'Mudd', 65, '2020-07-06'),
(10, 'Hikaru', 'Sulu', 58, '2015-03-21'),
(11, 'James', 'Kirk', 59, '2014-01-02'),
(12, 'Leonard', 'McCoy', 65, '2015-08-21'),
(13, 'Pavel', 'Chekov', 44, '2014-10-15'),
(14, 'Christopher', 'Pike', 32, '2014-11-24'),
(15, 'Darth', 'Vader', 124, '2015-03-22'),
(16, 'Boba', 'Fett', 49, '2015-03-22'),
(17, 'Luke', 'Skywalker', 66, '2019-11-11'),
(18, 'Han', 'Solo', 73, '2012-02-03'),
(19, 'Kylo', 'Ren', 34, '2020-06-14'),
(20, 'Galen', 'Erso', 55, '2020-06-14');

-- Testing employee table
SELECT *
FROM employee;
-- DROP TABLE at end

-- create contact table (phone numbers set to 15 for scalability, stripping all non-numeric data)
CREATE TABLE contact(id int NOT NULL PRIMARY KEY, cellphone bigint, homephone bigint, email varchar(255));
-- insert contact data
INSERT INTO contact(id, cellphone, homephone, email)
VALUES(01, 5121325343, 5125234234, 'apalmer@yachtmail.com'),
(02, 5129739834, 5129847873, 'sshepard@yorkdevtraining.com'),
(03, 6453898502, 6459872345, 'jsward2007@yahoo.com'),
(04, 8763238756, 8763736548, 'alsmith999@gmail.com'),
(05, 8880345966, 8888567987, 'james.betternot@hotmail.com'),
(06, 3322827765, 3328760098, 'ralph.white264@aol.com');

-- Testing contact table
SELECT *
FROM contact;
-- DROP TABLE at end

-- create address table (state set a little larger for provinces)
CREATE TABLE address(id int NOT NULL PRIMARY KEY, address1 varchar(60), address2 varchar(60), city varchar(60), state varchar(5), zip int);
-- insert address data
INSERT INTO address(id, address1, address2, city, state, zip)
VALUES
(01, '1211 Sudan St', NULL, 'Mobile', 'AL', 36609),
(02, '4800 Barkshire Dr', NULL, 'Pace', 'FL', 32571),
(03, '12 Nutmeg Ct', NULL, 'Culver City', 'CA', 90211),
(04, '2142 Elmwood Pl', NULL, 'Johnson City', 'TN', 37112),
(05, '777 Heavenly Ln', 'Box 13', 'Pike City', 'MN', 50877);

-- Testing address table
SELECT * 
FROM address;
-- DROP TABLE at end

-- Now that the tables are made, query time!
-- 1. Create a query that joins (inner) employee and address tables on id and returns fname, lname, age, city, state where fname = Alan 
SELECT e.id, e.fname, e.lname, e.age, a.city, a.state
FROM employee e
JOIN address a
ON e.id = a.id
WHERE fname = 'Alan';

-- 2. Create a query that joins (inner) employee, address, and contact tables on id and returns fname, lname, age, city, state, email where email  =  james.betternot@hotmail.com

SELECT e.id, e.fname, e.lname, e.age, a.city, a.state, c.email
FROM employee e
JOIN address a
ON e.id = a.id
JOIN contact c
ON a.id = c.id
WHERE c.email = 'james.betternot@hotmail.com';

-- 3. Update Susan Shepard's cellphone to be 4383991212 using fname and lname in the where clause. You must use the employee table to find the name and the contact table to update the cellphone. (Hint: You can use a WHERE ??? = (select ??? from ??? where ??? = "???") to reference a value in the employee table that matches the record in the contact table you are updating.

-- update data
UPDATE contact
SET cellphone = 4383991212
WHERE contact.id = (
	SELECT e.id
	FROM employee e
	WHERE e.fname = 'Susan' AND e.lname = 'Shepard');

-- Check update
SELECT *
FROM contact
ORDER BY id;

-- 4. Create a query that returns all of Susan's data by name
SELECT e.fname, e.lname, e.age, e.hiredate, c.cellphone, c.homephone, c.email, a.address1, a.address2, a.city, a.state, a.zip
FROM employee e
JOIN contact c
ON c.id = e.id
JOIN address a
ON a.id = c.id
WHERE e.fname = 'Susan' AND e.lname = 'Shepard';

-- clean up db if tables are no longer needed
-- DROP TABLE address;
-- DROP TABLE contact;
-- DROP TABLE emplpoyee;

