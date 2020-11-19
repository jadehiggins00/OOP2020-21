
-- Lab 3
DROP TABLE compResult CASCADE CONSTRAINTS PURGE;
DROP TABLE eventDetails CASCADE CONSTRAINTS PURGE;
DROP TABLE competitor CASCADE CONSTRAINTS PURGE;
DROP TABLE sportsDetails CASCADE CONSTRAINTS PURGE;

--creating the tables
CREATE TABLE sportsDetails(
    sportsID NUMBER(4),
    sportsName VARCHAR2 (30) NOT NULL,
    CONSTRAINT sportDetails_PK PRIMARY KEY (sportsID), 
    CONSTRAINT sportsName_uniq UNIQUE(sportsName)
);


CREATE TABLE competitor(
    competitorID NUMBER(9),
    competitorName VARCHAR2(30),
    competitorEmail VARCHAR(30),
    CONSTRAINT competitor_PK PRIMARY KEY (competitorID), --primary key
    CONSTRAINT competitorEmail_chk CHECK(competitorEmail like '%@%.com'), -- this is to ensure that the email contains a @ and ends with .com
    CONSTRAINT competitorEmail_uniq UNIQUE(competitorEmail) -- this is to ensure that the email is unique
    
);

CREATE TABLE eventDetails(
    eventID NUMBER(4),
    eventName VARCHAR2(30) NOT NULL,
    eventDate DATE NOT NULL, 
    sportsID NUMBER(4),
    CONSTRAINT eventDetails_pk PRIMARY KEY (eventID),
    CONSTRAINT eventDetails_sportsDetails_fk FOREIGN KEY (sportsID) REFERENCES sportsDetails(sportsID)
);


-- This table will hold the foreign keys and position of each athlete
CREATE TABLE compResult(
    eventID NUMBER(4),
    competitorID NUMBER(4),
    compPos NUMBER(4),
    CONSTRAINT eventenrol_pk PRIMARY KEY (eventID, competitorID),
    CONSTRAINT eventen_eventDetails_fk FOREIGN KEY (eventID) REFERENCES eventDetails (eventID),
    CONSTRAINT eventen_competitor_fk FOREIGN KEY (competitorID) REFERENCES competitor (competitorID),
    CONSTRAINT compPos_chk CHECK (compPos between 1 and 8)
 
);

-- INSERTING DATA
--inserting data into sports table
INSERT INTO sportsDetails (sportsID, sportsName) VALUES(1, 'Athletics');
INSERT INTO sportsDetails (sportsID, sportsName) VALUES(2, 'Swimming');

-- Inserting information into events table
INSERT INTO eventDetails (eventID, eventName, eventDate, sportsID) VALUES (1,  '100m Mens Final', '14 AUG 2016',  1);
INSERT INTO eventDetails (eventID, eventName, eventDate, sportsID) VALUES (2,  '100m Womens Final', '13 AUG 2016',  1);
INSERT INTO eventDetails (eventID, eventName, eventDate, sportsID) VALUES (3,  '100m Mens Freestyle Final', '10 AUG 2016', 1);

--Inserting data into the competitor table
INSERT INTO competitor (competitorID, competitorName,competitorEmail) VALUES (1, 'Usain Bolt',  'UB@jam.com');
INSERT INTO competitor (competitorID, competitorName,competitorEmail) VALUES (2, 'Justin Gatlin',  'JB@usa.com');
INSERT INTO competitor (competitorID, competitorName,competitorEmail) VALUES (3, 'Andre De Grasse',  'ADG@can.com');

INSERT INTO competitor (competitorID, competitorName,competitorEmail) VALUES (4, 'Elaine Thompson',  'ET@jam.com');
INSERT INTO competitor (competitorID, competitorName,competitorEmail) VALUES (5, 'Tori Bowie',  'TB@usa.com');
INSERT INTO competitor (competitorID, competitorName,competitorEmail) VALUES (6, 'Shelly-Ann Fraser-Price',  'SAFP@jam.com');

INSERT INTO competitor (competitorID, competitorName,competitorEmail) VALUES (7, 'Kyle Chambers',  'KC@aus.com');
INSERT INTO competitor (competitorID, competitorName,competitorEmail) VALUES (8, 'Peter Timmers',  'PT@bel.com');
INSERT INTO competitor (competitorID, competitorName,competitorEmail) VALUES (9, 'Nathan Adrian',  'NA@usa.com');

--inserting values into the events table
INSERT INTO compResult (eventID, competitorID,compPos) VALUES (1,1,1);
INSERT INTO compResult (eventID, competitorID,compPos) VALUES (1,2,2);
INSERT INTO compResult (eventID, competitorID,compPos) VALUES (1,3,3);

INSERT INTO compResult (eventID, competitorID,compPos) VALUES (2,4,1);
INSERT INTO compResult (eventID, competitorID,compPos) VALUES (2,5,2);
INSERT INTO compResult (eventID, competitorID,compPos) VALUES (2,6,3);

INSERT INTO compResult (eventID, competitorID,compPos) VALUES (3,7,1);
INSERT INTO compResult (eventID, competitorID,compPos) VALUES (3,8,2);
INSERT INTO compResult (eventID, competitorID,compPos) VALUES (3,9,3);
COMMIT;

-- TESTING IMPLEMENTATION
-- PART1 find the name and date of all events
SELECT eventName, eventDate from eventDetails;

--PART 2 add a sort to the SQL for 1. to sort in event name order
SELECT eventName, eventDate from eventDetails order by eventName;

--PART3 find the name of competitors
SELECT competitorName from competitor;

--PART 4 find the competitor no. of all competitors who finished in position 1 or position 3 in their events 
-- include the position in the output
--SELECT competitorID, compPos from compResult where compPos in (1,3);
SELECT competitorID, compPos from compResult where compPos =1 or compPos =3;

--PART 5 Find all the competitors with usa in their email address and include the email in the output
SELECT competitorName, competitorEmail from competitor where competitorEmail like '%usa%';