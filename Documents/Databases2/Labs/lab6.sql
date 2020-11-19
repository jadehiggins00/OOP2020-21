/*
lab Test 
Jade higgins



*/

--Practice Lab Test SETUP
--1. Drop tables and Create them
drop table lesson CASCADE CONSTRAINTS PURGE;
drop table student CASCADE CONSTRAINTS PURGE;
drop table instructor CASCADE CONSTRAINTS;


--Create student
Create table student (
sID number(6) , 
sName varchar2(50) not null, 
sAddress varchar2(50) not null,  
sEmail varchar(30) ,
sBalOwed number(7,2),
constraint chk_studentemail check (semail like '%@%'),
constraint student_pk primary key (sID)
);
-- Create lesson
Create table lesson(
studentId number(6),  
lessonDate date, 
lessonDuration number(2)
constraint ck_druation check (lessonDuration between 1 and 4),
constraint lesson_pk primary key (studentID,lessondate),
constraint lesson_student_fk foreign key (studentID) references student (sID)
);


--2. Inserts data into the student and lesson tables
insert into student (sID, sName, sAddress, sEmail, sBalOwed) values (1001,'D. Smith',	'11  The Hool, London','ds@mail.com', 170.05);
insert into student (sID, sName, sAddress,sBalOwed) values (1002, 'A.	Byrne',		'12, Blackrock Rd, Dublin', 50.00);
insert into student (sID, sName, sAddress, sEmail, sBalOwed) values (1003,	'X. Dobbs',		'10 Windings, Wicklow','xd@mail.com', 0.00);

insert into lesson( studentId, lessonDate, lessonDuration) values
(1001,	'01 Jun 2018',	2);
insert into lesson(studentId, lessonDate, lessonDuration) values
(1001,	'01 Sep 2018'	,3);
insert into lesson(studentId, lessonDate, lessonDuration) values
(1002,		'01 Jan 2018',	4);
commit;-- persist the data


--PART 1

create table instructor (

    instructorID NUMBER(4),
    instName VARCHAR2(50) NOT NULL,
    instEmail VARCHAR(30),
    lessonPrice NUMBER(7,2),
    constraint chk_lessonp check (lessonPrice between 42.00 and 65.00),
    constraint chk_instemail check (instEmail like '%@%'),
    constraint instructor_pk PRIMARY KEY (instructorID)
    
);

--inserting data
insert into instructor (instructorID, instName,instEmail,lessonPrice) values (1001, 'A. Golden','goldie@mail.com',47.50 );
insert into instructor (instructorID, instName,instEmail,lessonPrice) values (1002, 'J. Kearns','jk@mail.com',60.70 );
insert into instructor (instructorID, instName,instEmail,lessonPrice) values (1003, 'K. Jones','kj@mail.com',50.50 );

commit;

alter table lesson add instructor_id NUMBER(4);

update lesson
set instructor_id = 1001
where studentId = 1001;

update lesson
set instructor_id = 1002
where studentId = 1001;

update lesson
set instructor_id = 1002
where studentId = 1002;

alter table lesson add constraint lesson_inst_fk FOREIGN KEY (instructor_id) REFERENCES instructor (instructorID);

--part 6
select UPPER(sName)"Student Name", UPPER(sAddress) "Student Address", sEmail "Student Email"
from student;

--part 7
select sName"Student Name", sAddress"Student Address", instName "Instructor Name",lessonDate "Lesson Date"
from student
join instructor on instructorID = sID
join lesson ON studentId = instructorID
order by sName ASC;

-- PART 8
select 'The cost of '|| sName|| ' ' ||  'lesson with '|| instName || ' ,on ' || lessonDate ||  ' was ' ||  lessonPrice || ' , and lasted '|| lessonDuration|| ' hours ' 
from student
join instructor on instructorID = sID
join lesson on studentId = instructorID;

