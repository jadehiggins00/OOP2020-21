/*
Lab 5


*/
DROP TABLE appliance CASCADE CONSTRAINTS ;
DROP TABLE appRepair CASCADE CONSTRAINTS ;
DROP TABLE customerTab CASCADE CONSTRAINTS ;

CREATE TABLE appliance (
    
    serialNo NUMBER(6),
    appDesc VARCHAR(50) NOT NULL,
    appSaleDate DATE NOT NULL,
    guaranteeLength NUMBER(2) DEFAULT 2 NOT NULL,
    CONSTRAINT chk_guarantee CHECK (guaranteeLength between 1 and 10),
    CONSTRAINT appliance_PK PRIMARY KEY (serialNo)
 
);

CREATE TABLE appRepair (
    
    serialNo NUMBER(6),
    repairDate DATE NOT NULL,
    repairDesc VARCHAR(50) NOT NULL,
    repairCost NUMBER(7,3),
    CONSTRAINT chk_cost CHECK (repairCost between 60.50 and 160.50),
    CONSTRAINT apprepair_PK PRIMARY KEY (serialNo, repairDate),
    CONSTRAINT apprepair_app_FK FOREIGN KEY (serialNo) REFERENCES appliance (serialNo)

);

--creating a customer table PART 1
CREATE TABLE customerTab (
    custID NUMBER(4),
    custName VARCHAR2(50) NOT NULL,
    custPhone NUMBER(30),
    custEmail VARCHAR2(30),
    CONSTRAINT chk_email CHECK ( custEmail like '%@%.com'),
    CONSTRAINT customerTab_PK PRIMARY KEY (custID)
    
);





--inserting the data into appliance
INSERT INTO appliance (serialNo, appDesc, appSaleDate, guaranteeLength) VALUES (9001, 'DVD Player', '01 Jan 2018', 2);
INSERT INTO appliance (serialNo, appDesc, appSaleDate, guaranteeLength) VALUES (9002, 'Fridge Freezer', '31 May 2018', 5);
INSERT INTO appliance (serialNo, appDesc, appSaleDate) VALUES (9003, '48 TV', '12 Jun 2018');

--inserting the data into appRepair
INSERT INTO appRepair (serialNo, repairDate, repairDesc, repairCost) VALUES (9001, '01 Mar 2018', 'DVD Stuck', 67.50);
INSERT INTO appRepair (serialNo, repairDate, repairDesc, repairCost) VALUES (9002, '04 Jun 2018', 'Constantly Defrosting', 60.70);
INSERT INTO appRepair (serialNo, repairDate, repairDesc, repairCost) VALUES (9003, '16 Aug 2016', 'Blurred Output', 102.50);

--PART 2 inserting data into customrTab
INSERT INTO customerTab (custID, custName, custPhone, custEmail) VALUES (1001, 'A. Green', 014022849, 'agreen@mail.com');
INSERT INTO customerTab (custID, custName, custPhone, custEmail) VALUES (1002, 'J. Keogh', 022037896, 'jkeogh@mail.com');
INSERT INTO customerTab (custID, custName, custPhone) VALUES (1003, 'K. Jones', 033338888);



--PART 3 
--alter the table to add in a new column - customer_id 
ALTER TABLE appRepair ADD customer_id NUMBER(4);

--PART 4 update the values
UPDATE appRepair 
SET customer_id = 1001
WHERE serialNo = 9001;

UPDATE appRepair
SET customer_id = 1002
WHERE serialNo = 9002;

UPDATE appRepair
SET customer_id = 1003
WHERE serialNo = 9003;



--PART 5 adding a constraint foreign key
ALTER TABLE appRepair ADD CONSTRAINT app_cust_FK FOREIGN KEY (customer_id) REFERENCES customerTab (custID);

COMMIT;

--PART 6
SELECT UPPER(custName) "CUSTOMER NAME "FROM customerTab;

--PART 7
SELECT customer_id, custName, custEmail
FROM appRepair
JOIN customerTab ON customerTab.custID = appRepair.customer_id;

--PART 8
SELECT serialNo, custName, custEmail, appDesc, appSaleDate
FROM appRepair
JOIN customerTab ON customerTab.custID = appRepair.customer_id
JOIN appliance USING (serialNo);

--PART 9
SELECT 'The repair to appliance '|| serialNo || ' ' ||   appDesc || ' ,sold on' || appSaleDate || 'to ' ||  upper(custName) ||
', to solve the issue' || repairDesc || 'it will cost ' || repairCost || 'euro'
from appRepair
JOIN customerTab ON customerTab.custID = appRepair.customer_id
JOIN appliance USING (serialNo);

COMMIT;