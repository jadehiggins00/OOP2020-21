-- Databases I
-- Practical Class Week 4 Solutions


--1.	Write a query to return the name of each event and the name of the sport it belongs to (using a USING join).
select eventname, sportname 
from event
join sport using (sportcode);

--2.	Write a query to return the name of each event and the name of the sport it belongs to but only output events in Athletics and Swimming 
-- (use a join with a WHERE clause and match on the sport name not the sport code).
select eventname, sportname 
from event
join sport using (sportcode)
where sportname='Athletics' or sportname='Swimming';

--3.	Change the SQL you wrote for 2. to sort your output in ascending order of event name.
select eventname, sportname 
from event
join sport using (sportcode)
where sportname='Athletics' or sportname='Swimming'
order by eventname asc;

--4.	Write a query to return for each event its name and the ID of each competitor that competed in it (using ON in the join).
select eventname, compid 
from eventresult
join event on (eventid=eventno);

--5.	Change the SQL you wrote for 5. to include the name of the competitor rather than the competitor ID (you need another join).

select eventname, compname 
from eventresult
join event on (eventid=eventno)
join competitor using (compid);

--6.	Find the names of all competitors who finished in third position in their events. Include the name of the event and the
-- finishing position in the output (join with a WHERE clause).
select compname, eventname, position
from eventresult
join event on (eventid=eventno)
join competitor using (compid)
where position =3 ;

--7.	For all competitors who have a letter u in the 4th position of their email address, output their name, email address, 
-- the name of the events they competed in and the position they finished in those events.
select compname, compemail,eventname, position
from eventresult
join event on (eventid=eventno)
join competitor using (compid)
where compemail like '___u%';

/*
8.	Suppose we want to record details of Teams in our data. The data we want to record are a numeric team identifier, a team name (e.g. USA, Ireland, China etc.),  and its IAAF federation name.  The team ID will be recorded as part of each competitors record.
Each competitor belongs to one team and each team can have many competitors.
Write the SQL to create and amend any structures needed and to insert and update any data needed.
(You need to CREATE a Table, INSERT data,  ALTER a table (to add a column), UPDATE that table and ALTER a table to add a foreign key).
*/
--create the table
Drop table Team;
Create table Team(
teamID number(4),
teamName varchar2(40),
Federation varchar2 (20),
constraint team_pk primary key  (teamID)
);
--insert the data
insert into team (teamid, teamname, federation) values (1,	'USA',	'NACAC');
insert into team (teamid, teamname, federation) values (2,	'Canada',	'NACAC');
insert into team (teamid, teamname, federation) values (3,	'Jamaica	',	'NACAC');
commit;
--add a column to competitor
Alter table competitor add teamno number(4);
--update the values in competitor
update competitor set teamno=3 where compid  =1;
update competitor set teamno=1 where compid = 2;
update competitor set teamno=2 where compid=3;
Commit;

--alter the table to add a foreign key
alter table competitor  add constraint comp_team_fk FOREIGN KEY  (teamno) REFERENCES team (teamid);

--9.A.
select compname from competitor where teamno is null;

--9.B.
select compname from competitor where teamno is not null;

--10.	Write a query to return for each team the names of all competitors plus their email address, sorted in order of team name ascending.
select teamname, compname, compemail
from competitor
join team on (teamno=teamid)
order by teamname asc;

