/*
Lab 4
by Jade Higgins
26/10/2020

*/


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


--LAB 4

-- Retrieve all the data
-- PART 1 Write a query to return the name of each event and the name of the sport it belongs to
-- using a USING join
select eventName, sportsName
from eventDetails join sportsDetails using (sportsID);


--PART 2 do the same as part 1 however show only swimming and athletics 
-- use a join with a WHERE clause and match on the sport name not the sport code
-- REMEMBER - when matching with characters, you must be aware of the case used
select eventName,sportsName
from eventDetails,sportsDetails
where sportsName LIKE 'Athletics' or sportsName LIKE 'Swimming';

--PART 3 change the SQl you wrote for 2. to sort your output in ascending order
-- of event name
select eventName,sportsName
from eventDetails,
sportsDetails where sportsName like 'Athletics' or sportsName like 'Swimming'
order by eventName ASC;

--PART 4 write a query to return for each event its name and the ID of each 
-- competitor that competed in it 
-- using ON in the join
select eventName, competitorID
from compResult
join eventDetails on eventDetails.eventID = compResult.eventID;

--PART 5 Chnage the sql you wrote for 4. to include the name of the competitor
-- rather than the compeitor ID (you need another join)
select eventName, competitorName
from compResult
join eventDetails on eventDetails.eventID = compResult.eventID
join competitor using (competitorID);

--PART 6 find the names of all competitors who finished in third positon
-- in their events. include the name of the event and the finishing
-- position in the output (join with a WHERE clause)
select competitorName, eventName, compPos
from compResult
join eventDetails on eventDetails.eventID = compResult.eventID
join competitor using (competitorID)
where compPos =3 ;

-- PART 7
-- For all the competitors who have a letter U in the fourth position of their 
-- email address, output their name , email address, the name of the events they
-- competed in and the position they finished in those events
select competitorName, competitorEmail, eventName, compPos
from compResult
join eventDetails on eventDetails.eventID = compResult.eventID
join competitor using (competitorID)
where competitorEmail like '___u%' ;

/*
PART 8
Suppose we want to record details of Teams in our data. The data we want to record are a numeric team identifier, a team name (e.g. USA, Ireland, China etc.),  and its IAAF federation name. 
The team ID will be recorded as part of each competitors record.
Each competitor belongs to one team and each team can have many competitors.
Write the SQL to create and amend any structures needed and to insert and update any data needed.
(You need to CREATE a Table, INSERT data,  ALTER a table (to add a column), UPDATE that table and ALTER a table to add a foreign key).
*/
DROP TABLE team;
CREATE TABLE team (
    teamID number(4),
    teamName VARCHAR2(30),
    fedName VARCHAR2(30),
    CONSTRAINT team_PK PRIMARY KEY (teamID)
);

--insert data into the table
insert into team (teamID, teamName, fedName) values (1,'USA','NACAC');
insert into team (teamID, teamName, fedName) values (2,'IRELAND','NACAC');
insert into team (teamID, teamName, fedName) values (3,'CHINA','NACAC');
commit;
-- ALTER THE TABLE
-- add teamno number 4
alter table competitor add teamno NUMBER(4);
--update the values in competitor
update competitor
set teamno = 3 
where competitorID = 1;

update competitor 
set teamno = 1
where competitorID = 2;

update competitor 
set teamno = 2 
where competitorID = 3;
commit;

--alter the table to add a foreign key
alter table competitor add constraint comp_team_fk FOREIGN KEY (teamno) REFERENCES team (teamID);

-- PART 9A 
-- Write a query to return the name of each of the competitors where the 
-- the teamno has the value NULL, include teamno in the output
select competitorName
from competitor 
where teamno is NULL;

--PART 10
-- Write a query to return for each team the names of all competitors plus
-- their email address, sorted in order of team name ascending
select teamName,competitorName, competitorEmail
from competitor
join team on (teamno=teamID)
order by teamName ASC;





