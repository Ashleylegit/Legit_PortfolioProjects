---Creating a new database

CREATE DATABASE Printing

---CREATING THE TITLES TABLE

CREATE TABLE Titles(
Title_Id varchar(6) PRIMARY KEY NOT NULL
,Title varchar(80) NOT NULL
,Type char(12) NOT NULL
,Pub_Id char(4) NULL
,Price money NULL
,Advance money NULL
,Royalty int NULL
,YTD_Sales int NULL
,Notes varchar(200) NULL
,PubDate datetime NULL
)

---CREATING FOREGN KEY
ALTER TABLE Titles
ADD CONSTRAINT FK_Pub_Id_Titles
FOREIGN KEY (Pub_Id) REFERENCES Publishers(Pub_Id);

---Creating an Index for the type and advance column
CREATE INDEX idx_Advance_Type
ON Titles (Advance, Type);

---Create a script to update the length for title from 80 to 90
UPDATE Titles
SET title = LEFT(title, 90)
WHERE LEN(title) > 90;



--CREATING THE PUBLISHERS TABLE
CREATE TABLE Publishers(
Pub_Id char(4) PRIMARY KEY NOT NULL
,Pub_Name varchar(40) NULL
,City varchar(20) NULL
,State char(2) NULL
,Country char(4) NULL
)

---CREATING A SALES TABLE
CREATE TABLE Sales(
Stor_Id char(4) PRIMARY KEY CLUSTERED NOT NULL
,Ord_Num varchar(20) NOT NULL
,Ord_Date Datetime NOT NULL
,Qty smallint NOT NULL
,Payterms varchar(12) NOT NULL
,Title_Id varchar(6) NOT NULL
)
---Dropping the primary key because the stor_Id is not unique
ALTER TABLE Sales
DROP CONSTRAINT PK__Sales__347B83C4708D3F3F;

---Finding the exact constraint to drop primary key
SELECT constraint_name
FROM information_schema.key_column_usage
WHERE table_name = 'Sales' AND constraint_name LIKE 'PK%';


---CREATING A PRIMARY KEY in the Sales table Ord_Num
ALTER TABLE Sales
ADD CONSTRAINT PK_Ord_Num_Sales PRIMARY KEY CLUSTERED (Ord_Num)

---CREATING FOREGN KEY
ALTER TABLE Sales
ADD CONSTRAINT FK_TitleId_Sales 
FOREIGN KEY (Title_Id) REFERENCES Titles(Title_Id);

---CREATING TITLEAUTHOR TABLE

CREATE TABLE TitleAuthor(
au_Id varchar(11) NOT NULL
,Title_Id varchar(6) NOT NULL
,au_Ord tinyint NULL
,royaltyper int NULL
)

---CREATING FOREGN KEY
ALTER TABLE TitleAuthor
ADD CONSTRAINT FK_TitleId_TitleAuthor
FOREIGN KEY (Title_Id) REFERENCES Titles(Title_Id);


---CREATING TABLES FOR AUTHORS

CREATE TABLE Authors(
au_Id varchar(11) PRIMARY KEY NOT NULL
,au_Iname varchar(40) NOT NULL
,au_fname varchar(20) NOT NULL
,Phone char (12) NOT NULL
,Address varchar(40) NULL
,City varchar(20) NULL
,State char(2) NULL
,Zip char(5) NULL
,Contract bit NOT NULL
)


---CREATING FOREGN KEY
ALTER TABLE TitleAuthor
ADD CONSTRAINT FK_au_Id_TitleAuthor
FOREIGN KEY (au_Id) REFERENCES Authors(au_Id);



----Deleting records from a table
DELETE FROM Publishers
WHERE pub_Id = '736'

DELETE FROM Publishers
WHERE pub_Name = 'New Moon Books'

DELETE FROM Publishers
WHERE City = 'Boston'

DELETE FROM Publishers
WHERE State = 'MA'

DELETE FROM Publishers
WHERE Country = 'USA'


--Putting records in the database in chrological order Starting with Publishers

INSERT INTO Publishers (pub_Id, pub_Name, City, State, Country)
VALUES
('736', 'New Moon Books', 'Boston', 'MA', 'USA')
,('877', 'Binnet & Hardley', 'Washington', 'DC', 'USA')
,('1389', 'Algodata Infosystems', 'Berkeley', 'CA', 'USA')
,('1622', 'Five Lakes Publishing', 'Chicago', 'IL', 'USA')
,('1756','Ramona Publishers', 'Dallas', 'TX', 'USA')
,('9901', 'GGG&G', 'M•nchen', 'NU', 'Germ')
,('9952', 'Scootney Books', 'New York', 'NY', 'USA')
,('9999', 'Lucerne Publishing', 'Paris', 'NU', 'Fran')

---Inserting records cont.. then inserting records in the Authors Table

INSERT INTO Authors (au_Id, au_Iname, au_fname, phone, address, city, state, zip, contract)
VALUES
('172-32-1176', 'White', 'Johnson', '408 496-7223', '10932 Bigge Rd.', 'Menlo Park', 'CA', '94025', '1'),
('213-46-8915', 'Green', 'Marjorie', '415 986-7020', '309 63rd St. #411', 'Oakland', 'CA', '94618', '1'),
('238-95-7766', 'Carson', 'Cheryl', '415 548-7723', '589 Darwin Ln.', 'Berkeley', 'CA', '94705', '1'),
('267-41-2394', 'O''Leary', 'Michael', '408 286-2428', '22 Cleveland Av. #14', 'San Jose', 'CA', '95128', '1'),
('274-80-9391', 'Straight', 'Dean', '415 834-2919', '5420 College Av.', 'Oakland', 'CA', '94609', '1'),
('341-22-1782', 'Smith', 'Meander', '913 843-0462', '10 Mississippi Dr.', 'Lawrence', 'KS', '66044', '0'),
('409-56-7008', 'Bennet', 'Abraham', '415 658-9932', '6223 Bateman St.', 'Berkeley', 'CA', '94705', '1'),
('427-17-2319', 'Dull', 'Ann', '415 836-7128', '3410 Blonde St.', 'Palo Alto', 'CA', '94301', '1'),
('472-27-2349', 'Gringlesby', 'Burt', '707 938-6445', 'PO Box 792', 'Covelo', 'CA', '95428', '1'),
('486-29-1786', 'Locksley', 'Charlene', '415 585-4620', '18 Broadway Av.', 'San Francisco', 'CA', '94130', '1'),
('527-72-3246', 'Greene', 'Morningstar', '615 297-2723', '22 Graybar House Rd.', 'Nashville', 'TN', '37215', '0'),
('648-92-1872', 'Blotchet-Halls', 'Reginald', '503 745-6402', '55 Hillsdale Bl.', 'Corvallis', 'OR', '97330', '1'),
('672-71-3249', 'Yokomoto', 'Akiko', '415 935-4228', '3 Silver Ct.', 'Walnut Creek', 'CA', '94595', '1'),
('712-45-1867', 'del Castillo', 'Innes', '615 996-8275', '2286 Cram Pl. #86', 'Ann Arbor', 'MI', '48105', '1'),
('722-51-5454', 'DeFrance', 'Michel', '219 547-9982', '3 Balding Pl.', 'Gary', 'IN', '46403', '1'),
('724-08-9931', 'Stringer', 'Dirk', '415 843-2991', '5420 Telegraph Av.', 'Oakland', 'CA', '94609', '0'),
('724-80-9391', 'MacFeather', 'Stearns', '415 354-7128', '44 Upland Hts.', 'Oakland', 'CA', '94612', '1'),
('756-30-7391', 'Karsen', 'Livia', '415 534-9219', '5720 McAuley St.', 'Oakland', 'CA', '94609', '1'),
('807-91-6654', 'Panteley', 'Sylvia', '301 946-8853', '1956 Arlington Pl.', 'Rockville', 'MD', '20853', '1'),
('846-92-7186', 'Hunter', 'Sheryl', '415 836-7128', '3410 Blonde St.', 'Palo Alto', 'CA', '94301', '1'),
('893-72-1158', 'McBadden', 'Heather', '707 448-4982', '301 Putnam', 'Vacaville', 'CA', '95688', '0'),
('899-46-2035', 'Ringer', 'Anne', '801 826-0752', '67 Seventh Av.', 'Salt Lake City', 'UT', '84152', '1'),
('998-72-3567', 'Ringer', 'Albert', '801 826-0752', '67 Seventh Av.', 'Salt Lake City', 'UT', '84152', '1');


---Creating the next records in the Titles table

INSERT INTO Titles (title_id, title, type, pub_id, price, advance, royalty, ytd_sales, notes, pubdate)
VALUES
('BU1032', 'The Busy Executive''s Database Guide', 'business', '1389', 19.99, 5000, 10, 4095, 'An overview of available database systems', '1991-06-12'),
('BU1111', 'Cooking with Computers:', 'business', '1389', 11.95, 5000, 10, 3876, 'Helpful hints on how to', '1991-06-09'),
('BU2075', 'You Can Combat', 'business', '736', 2.99, 10125, 24, 18722, 'The latest medical and psychological', '1991-06-30'),
('BU7832', 'Straight Talk About Computers', 'business', '1389', 19.99, 5000, 10, 4095, 'Annotated analysis of', '1991-06-22'),
('MC2222', 'Silicon Valley Gastronomic Treats', 'mod_cook', '877', 19.99, 0, 12, 2032, 'Favorite recipes for quick', '1991-06-09'),
('MC3021', 'The Gourmet Microwave', 'mod_cook', '877', 2.99, 15000, 24, 22246, 'Traditional French gourmet', '1991-06-18'),
('MC3026', 'The Psychology of Computer Cooking', 'UNDECIDED', '877', NULL, NULL, NULL, NULL, NULL, '2020-04-18'),
('PC1035', 'But Is It User Friendly?', 'popular_comp', '1389', 22.95, 7000, 16, 8780, 'A survey of software for', '1991-06-30'),
('PC8888', 'Secrets of Silicon Valley', 'popular_comp', '1389', 20, 8000, 10, 4095, 'Muckraking reporting on', '1994-06-12'),
('PC9999', 'Net Etiquette', 'popular_comp', '1389', NULL, NULL, NULL, NULL, 'A must-read for computer conferencing.', '2020-04-18'),
('PS1372', 'Computer Phobic', 'psychology', '877', 21.59, 7000, 10, 375, 'A must for the specialist, this book', '1991-10-21'),
('PS2091', 'Is Anger the Enemy?', 'psychology', '736', 10.95, 2275, 12, 2045, 'Carefully researched study', '1991-06-15'),
('PS2106', 'Life Without Fear', 'psychology', '736', 7, 6000, 10, 111, 'New exercise, meditation', '1991-10-05'),
('PS3333', 'Prolonged Data Deprivation: Four Case Studies', 'psychology', '736', 19.99, 2000, 10, 4072, 'What happens when the data runs dry', '1991-06-12'),
('PS7777', 'Emotional Security: A New Algorithm', 'psychology', '736', 7.99, 4000, 10, 3336, 'Protecting yourself and your', '1991-06-12'),
('TC3218', 'Onions, Leeks,', 'trad_cook', '877', 20.95, 7000, 10, 375, 'Profusely illustrated in color', '1991-10-21'),
('TC4203', 'Fifty Years in Buckingham Palace Kitchens', 'trad_cook', '877', 11.95, 4000, 14, 15096, 'More anecdotes from the Queen''s', '1991-06-12'),
('TC7777', 'Sushi, Anyone?', 'trad_cook', '877', 14.99, 8000, 10, 4095, 'Detailed instructions on', '1991-06-12');


---Creating the next records in the Titles table

INSERT INTO TitleAuthor (au_Id, title_Id, au_Ord, royaltyper)
VALUES
('172-32-1176', 'PS3333', 1, 100),
('213-46-8915', 'BU1032', 2, 40),
('213-46-8915', 'BU2075', 1, 100),
('238-95-7766', 'PC1035', 1, 100),
('267-41-2394', 'BU1111', 2, 40),
('267-41-2394', 'TC7777', 2, 30),
('274-80-9391', 'BU7832', 1, 100),
('409-56-7008', 'BU1032', 1, 60),
('427-17-2319', 'PC8888', 1, 50),
('472-27-2349', 'TC7777', 3, 30),
('486-29-1786', 'PC9999', 1, 100),
('486-29-1786', 'PS7777', 1, 100),
('648-92-1872', 'TC4203', 1, 100),
('672-71-3249', 'TC7777', 1, 40),
('712-45-1867', 'MC2222', 1, 100),
('722-51-5454', 'MC3021', 1, 75),
('724-80-9391', 'BU1111', 1, 60),
('724-80-9391', 'PS1372', 2, 25),
('756-30-7391', 'PS1372', 1, 75),
('807-91-6654', 'TC3218', 1, 100),
('846-92-7186', 'PC8888', 2, 50),
('899-46-2035', 'MC3021', 2, 25),
('899-46-2035', 'PS2091', 2, 50),
('998-72-3567', 'PS2091', 1, 50),
('998-72-3567', 'PS2106', 1, 100);


---Creating the next records in the Sales table

INSERT INTO Sales (stor_id, ord_num, ord_date, qty, payterms, title_id)
VALUES
(6380, '6871', '00:00.0', 5, 'Net 60', 'BU1032'),
(6380, '722a', '00:00.0', 3, 'Net 60', 'PS2091'),
(7066, 'A2976', '00:00.0', 50, 'Net 30', 'PC8888'),
(7066, 'QA7442.3', '00:00.0', 75, 'ON invoice', 'PS2091'),
(7067, 'D4482', '00:00.0', 10, 'Net 60', 'PS2091'),
(7067, 'P2821', '00:00.0', 40, 'Net 30', 'TC3218'),
(7067, 'P2521', '00:00.0', 20, 'Net 30', 'TC4203'),
(7067, 'P2121', '00:00.0', 20, 'Net 30', 'TC7777'),
(7131, 'N914008', '00:00.0', 20, 'Net 30', 'PS2091'),
(7131, 'N914014', '00:00.0', 25, 'Net 30', 'MC3021'),
(7131, 'P3086a', '00:00.0', 20, 'Net 60', 'PS1372'),
(7131, 'P3187a', '00:00.0', 25, 'Net 60', 'PS2106'),
(7131, 'P3087a', '00:00.0', 15, 'Net 60', 'PS3333'),
(7131, 'P3097a', '00:00.0', 25, 'Net 60', 'PS7777'),
(7896, 'QQ2299', '00:00.0', 15, 'Net 60', 'BU7832'),
(7896, 'TQ456', '00:00.0', 10, 'Net 60', 'MC2222'),
(7896, 'X999', '00:00.0', 35, 'ON invoice', 'BU2075'),
(8042, '423LL922', '00:00.0', 15, 'ON invoice', 'MC3021'),
(8042, '423LL930', '00:00.0', 10, 'ON invoice', 'BU1032'),
(8042, 'P723', '00:00.0', 25, 'Net 30', 'BU1111'),
(8042, 'QA879.1', '00:00.0', 30, 'Net 30', 'PC1035');

---Updating our Authors table, last name of author has changed.
UPDATE Authors
SET au_Iname = 'Trudeau'
WHERE au_fname = 'Marjorie' AND au_Iname = 'Green';

---Delete records from title_author table where au_id is 172-32-1176
DELETE FROM TitleAuthor
WHERE au_id = '172-32-1176';

--All criterias have been met and it is time to Create the SQL Diagarm!
