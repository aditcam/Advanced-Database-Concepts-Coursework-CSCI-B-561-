-- Creating database with full name


CREATE DATABASE dirkassignment;

-- Connecting to database 
\c dirkassignment;

-- Relation schemas and instances for assignment 1

\qecho 'Problem 1'

-- Provide 4 conceptually different examples that illustrate how the
-- presence or absence of primary and foreign keys affect insert and
-- deletes in these relations.  To solve this problem, you will need to
-- experiment with the relation schemas and instances for this
-- assignment.  For example, you should consider altering primary keys
-- and foreign key constraints and then consider various sequences of
-- insert and delete operations.  You may need to change some of the
-- relation instances to observe the desired effects.  Certain inserts
-- and deletes should succeed but other should generate error
-- conditions.  (Consider the lecture notes about keys, foreign keys,
-- and inserts and deletes as a guide to solve this problem.)

-- CREATE TABLES WITH NO CONSTRAINTS Q1
-- CREATE TABLES WITH NO CONSTRAINTS Q1
CREATE TABLE STUDENT_Q1
(
	ID INT,
	NAME VARCHAR(50),
	BOOKID INT
);

CREATE TABLE BOOKS_Q1
(
	ID INT,
	BOOKNAME VARCHAR(50)
);

-- INSERT DUMMY DATA INTO BOTH TABLES

INSERT INTO STUDENT_Q1 VALUES(1,'Jerry',123);
INSERT INTO STUDENT_Q1 VALUES(2,'Elaine',329);
INSERT INTO STUDENT_Q1 VALUES(3,'George',100);
INSERT INTO STUDENT_Q1 VALUES(4,'Cosmo',007);
INSERT INTO STUDENT_Q1 VALUES(5,'Newman',009);

INSERT  INTO BOOKS_Q1 VALUES(123,'Harry Potter and the Philosophers Stone');
INSERT  INTO BOOKS_Q1 VALUES(100,'Harry Potter and the Chamber of Secrets');
INSERT  INTO BOOKS_Q1 VALUES(329,'Percy Jackson : The Sea of Monsters');
INSERT  INTO BOOKS_Q1 VALUES(007,'The Alchemist');
INSERT  INTO BOOKS_Q1 VALUES(009,'The White Tiger');

-- Part 1) NO PRIMARY KEY (WE CAN INSERT DUPLICATE RECORDS) ==> NO ERROR

INSERT INTO STUDENT_Q1 VALUES(4,'Cosmo',007);

SELECT * FROM STUDENT_Q1; -- DUPLICATE COLUMNS CAN BE SEEN IN THE STUDENT_Q1 TABLE

DELETE FROM STUDENT_Q1 WHERE ID = 4;
INSERT INTO STUDENT_Q1 VALUES(4,'Cosmo',007);

-- Part 2) ADD A PRIMARY KEY AND TRY CREATING A DUPLICATE RECORD ==> THROWS ERROR

ALTER TABLE STUDENT_Q1 ADD PRIMARY KEY(ID);
ALTER TABLE BOOKS_Q1 ADD PRIMARY KEY(ID);
INSERT INTO STUDENT_Q1 VALUES(4,'Cosmo',007);


-- Part 3) DELETE A BOOK FROM THE BOOKS_Q1 TABLE THAT IS HELD BY A STUDENT ==> NO ERROR (IDEALLY WE SHOULD NOT PERMIT THIS DELETE)

DELETE FROM BOOKS_Q1 WHERE ID = 9;
INSERT INTO BOOKS_Q1 VALUES(009,'The White Tiger');

-- Part 4)  ADD A FOREIGN KEY CONSTRAINT AND THEN DELETE A BOOK CURRENTLY HELD BY A STUDENT ==> THROWS AN ERROR (DELETE NOT PERMITTED AS THERE IS A DEPENDENCY GENERATED DUE TO THE FOREIGN KEY CONSTRAINT)

ALTER TABLE STUDENT_Q1 ADD FOREIGN KEY(BOOKID) REFERENCES BOOKS_Q1(ID);
DELETE FROM BOOKS_Q1 WHERE ID = 9;

SELECT * FROM STUDENT_Q1;
SELECT * FROM BOOKS_Q1;

-- Relation schemas and instances for assignment 1
 
CREATE TABLE Student(sid integer,
                     sname text,
                     homeCity text,
                     primary key (sid));

CREATE TABLE Department(deptName text,
                        mainOffice text,
                        primary key (deptName));

CREATE TABLE Major(major text,
                   primary key (major));


CREATE TABLE employedBy(sid integer,
                        deptName text,
                        salary integer,
                        primary key (sid),
                        foreign key (sid) references Student (sid),
                        foreign key (deptName) references Department(deptName));


CREATE TABLE departmentLocation(deptName text,
                                building text,
                                primary key (deptName, building),
                                foreign key (deptName) references Department (deptName));


CREATE TABLE studentMajor(sid integer,
                          major text,
                          primary key (sid, major),
                          foreign key (sid) references Student (sid),
                          foreign key (major) references Major (major));


CREATE TABLE hasFriend(sid1 integer,
                       sid2 integer,
                       primary key(sid1,sid2),
                       foreign key (sid1) references Student (sid),
                       foreign key (sid2) references Student (sid));


INSERT INTO Student VALUES
     (1001,'Jean','Cupertino'),
     (1002,'Vidya', 'Cupertino'),
     (1003,'Anna', 'Seattle'),
     (1004,'Qin', 'Seattle'),
     (1005,'Megan', 'MountainView'),
     (1006,'Ryan', 'Chicago'),
     (1007,'Danielle','LosGatos'),
     (1008,'Emma', 'Bloomington'),
     (1009,'Hasan', 'Bloomington'),
     (1010,'Linda', 'Chicago'),
     (1011,'Nick', 'MountainView'),
     (1012,'Eric', 'Cupertino'),
     (1013,'Lisa', 'Indianapolis'), 
     (1014,'Deepa', 'Bloomington'), 
     (1015,'Chris', 'Denver'),
     (1016,'YinYue', 'Chicago'),
     (1017,'Latha', 'LosGatos'),
     (1018,'Arif', 'Bloomington'),
     (1019,'John', 'NewYork');


INSERT INTO Department VALUES
     ('CS', 'LuddyHall'),
     ('DataScience', 'LuddyHall'),
     ('Mathematics', 'RawlesHall'),
     ('Physics', 'SwainHall'),
     ('Biology', 'JordanHall'),
     ('Chemistry', 'ChemistryBuilding'),
     ('Astronomy', 'SwainHall');


INSERT INTO employedBy VALUES
     (1001,'CS', 65000),
     (1002,'CS', 45000),
     (1003,'DataScience', 55000),
     (1004,'DataScience', 55000),
     (1005,'Mathematics', 60000),
     (1006,'DataScience', 55000),
     (1007,'Physics', 50000),
     (1008,'DataScience', 50000),
     (1009,'CS',60000),
     (1010,'DataScience', 55000),
     (1011,'Mathematics', 70000), 
     (1012,'CS', 50000),
     (1013,'Physics', 55000),
     (1014,'CS', 50000), 
     (1015,'DataScience', 60000),
     (1016,'DataScience', 55000),
     (1017,'Physics', 60000),
     (1018,'CS', 50000),
     (1019,'Biology', 50000);

INSERT INTO departmentLocation VALUES
   ('CS', 'LindleyHall'),
   ('DataScience', 'LuddyHall'),
   ('DataScience', 'Kinsey'),
   ('DataScience', 'WellsLibrary'),
   ('Mathematics', 'RawlesHall'),
   ('Physics', 'SwainHall'),
   ('Physics', 'ChemistryBuilding'),
   ('Biology', 'JordanHall'),
   ('CS', 'LuddyHall'),
   ('Mathematics', 'SwainHall'),
   ('Physics', 'RawlesHall'),
   ('Biology', 'MultiDisciplinaryBuilding'),
   ('Chemistry', 'ChemistryBuilding');

INSERT INTO Major VALUES
   ('CS'),
   ('DataScience'),
   ('Physics'),
   ('Chemistry'),
   ('Biology');

INSERT INTO studentMajor VALUES
 (1001,'CS'),
 (1001,'DataScience'),
 (1002,'CS'),
 (1002,'DataScience'),
 (1004,'DataScience'),
 (1004,'CS'),
 (1005,'DataScience'),
 (1005,'CS'),
 (1005,'Physics'),
 (1006,'CS'),
 (1006,'Chemistry'),
 (1007,'Chemistry'),
 (1007,'CS'),
 (1009,'Chemistry'),
 (1009,'Physics'),
 (1010,'Physics'),
 (1011,'Physics'),
 (1011,'Chemistry'),
 (1011,'DataScience'),
 (1011,'CS'),
 (1012,'DataScience'),
 (1012,'Chemistry'),
 (1012,'CS'),
 (1013,'CS'),
 (1013,'DataScience'),
 (1013,'Chemistry'),
 (1013,'Physics'),
 (1014,'Chemistry'),
 (1014,'DataScience'),
 (1014,'Physics'),
 (1015,'CS'),
 (1015,'DataScience'),
 (1016,'Chemistry'),
 (1016,'DataScience'),
 (1017,'Physics'),
 (1017,'CS'),
 (1018,'DataScience'),
 (1019,'Physics');

INSERT INTO hasFriend VALUES
 (1001,1008),
 (1001,1012),
 (1001,1014),
 (1001,1019),
 (1002,1001),
 (1002,1002),
 (1002,1011),
 (1002,1014),
 (1002,1015),
 (1003,1004),
 (1004,1002),
 (1004,1003),
 (1004,1012),
 (1004,1013),
 (1004,1014),
 (1004,1019),
 (1005,1015),
 (1006,1003),
 (1006,1004),
 (1006,1006),
 (1007,1008),
 (1007,1013),
 (1007,1016),
 (1007,1017),
 (1008,1001),
 (1008,1007),
 (1008,1015),
 (1008,1019),
 (1009,1001),
 (1009,1005),
 (1009,1013),
 (1010,1008),
 (1010,1013),
 (1010,1014),
 (1011,1005),
 (1011,1009),
 (1011,1010),
 (1011,1011),
 (1012,1011),
 (1013,1002),
 (1013,1007),
 (1013,1018),
 (1014,1005),
 (1014,1006),
 (1014,1012),
 (1014,1017),
 (1015,1002),
 (1015,1003),
 (1015,1005),
 (1015,1011),
 (1015,1015),
 (1015,1018),
 (1016,1004),
 (1016,1006),
 (1016,1015),
 (1017,1013),
 (1017,1014),
 (1017,1019),
 (1018,1004),
 (1018,1007),
 (1018,1009),
 (1018,1010),
 (1018,1013),
 (1019,1001),
 (1019,1006),
 (1019,1008),
 (1019,1013);


-- Problem 1

-- Provide 4 conceptually different examples that illustrate how the
-- presence or absence of primary and foreign keys affect insert and
-- deletes in these relations.  To solve this problem, you will need to
-- experiment with the relation schemas and instances for this
-- assignment.  For example, you should consider altering primary keys
-- and foreign key constraints and then consider various sequences of
-- insert and delete operations.  You may need to change some of the
-- relation instances to observe the desired effects.  Certain inserts
-- and deletes should succeed but other should generate error
-- conditions.  (Consider the lecture notes about keys, foreign keys,
-- and inserts and deletes as a guide to solve this problem.)

/*
\qecho 'Problem 1 conceptual example 1'
INSERT INTO Department VALUES ('CS', 'SwainHall');

\qecho 'Problem 1 conceptual example 2'
INSERT INTO employedBy VALUES ('1001', 'CS', 10000);

\qecho 'Problem 1 conceptual example 3'
DELETE FROM Student WHERE sid = 1001;

\qecho 'Problem 1 conceptual example 4'
DELETE FROM Major WHERE Major = 'CS';
*/


\qecho 'Problem 2'
-- Find each pair (d, m) where d is the name of a department and m is a
-- major of a student who is employed by that department and who earns a
-- salary of at least 20000.

select e.deptName, sm.major
from employedby e, studentmajor sm
where e.sid = sm.sid and e.salary >=20000
UNION
select e.deptName, sm.major
from employedby e, studentmajor sm
where e.sid = sm.sid and e.salary >=20000


\qecho 'Problem 3'
-- Find each pair (s1,s2) of sids of different students who have the same
-- (set of) friends who work for the CS department.
select s1.sid, s2.sid
from student s1, student s2
where 
s1.sid <> s2.sid 
and 
not exists 
(
	select sid2 
	from hasFriend h,employedby e
	where s1.sid = h.sid1 and h.sid2 = e.sid and e.deptname='CS'
	except
	select sid2 
	from hasFriend h,employedby e
	where s2.sid = h.sid1 and h.sid2 = e.sid and e.deptname='CS'
)
and 
not exists 
(
	select sid2 
	from hasFriend h,employedby e
	where s2.sid = h.sid1 and h.sid2 = e.sid and e.deptname='CS'
	except
	select sid2 
	from hasFriend h,employedby e
	where s1.sid = h.sid1 and h.sid2 = e.sid and e.deptname='CS'
)

\qecho 'Problem 4'
-- Find each major for which there exists a student with that major and
-- who does not only have friends who also have that major.
-- unoptimized soln
-- select m.major
-- from major m
-- where exists (
-- 	select s.sid
-- 	from student s, studentmajor sm
-- 	where 
-- 	s.sid = sm.sid 
-- 	and 
-- 	sm.major = m.major
-- 	and
-- 	sm.major in (	
-- 		select sm1.major
-- 		from studentmajor sm1,hasfriend h
-- 		where 
-- 		h.sid1 = s.sid and h.sid2 = sm1.sid
-- 	)
-- 	and
-- 	exists(select sm1.major
-- 		from studentmajor sm1,hasfriend h
-- 		where 
-- 		h.sid1 = s.sid and h.sid2 = sm1.sid
-- 		except
-- 		select major from major where major = m.major)
-- )
-- -- Optimized soln
-- select m.major
-- from major m
-- where exists (
-- 	select s.sid
-- 	from student s, studentmajor sm
-- 	where 
-- 	s.sid = sm.sid 
-- 	and 
-- 	sm.major = m.major
-- 	and
-- 	sm.major in (	
-- 		select sm1.major
-- 		from studentmajor sm1,hasfriend h
-- 		where 
-- 		h.sid1 = s.sid and h.sid2 = sm1.sid
-- 	)
-- 	and
-- 	exists(select sm1.major
-- 		from studentmajor sm1,hasfriend h
-- 		where 
-- 		h.sid1 = s.sid and h.sid2 = sm1.sid and sm1.major <> m.major)
-- )

-- Final Solution
select m.major
from major m
where exists (
	select sm.sid
	from studentmajor sm 
	where
	sm.major = m.major
	and
	sm.major in (	
		select sm1.major
		from studentmajor sm1,hasfriend h
		where 
		h.sid1 = sm.sid and h.sid2 = sm1.sid
	)
	and
	exists(select sm1.major
		from studentmajor sm1,hasfriend h
		where 
		h.sid1 = sm.sid and h.sid2 = sm1.sid and sm1.major <> m.major)
)


\qecho 'Problem 13'

-- Part 1 

select s1.sid, s1.sname
from student s1
where
true = any(select d.deptname = w.deptname 
		   and s1.sid = w.sid 
		   and d.mainoffice = 'LuddyHall'
		   and true = any(select s1.sid = hf.sid1 and s2.sid = hf.sid2
				   from hasfriend hf, student s2
				   where s2.homecity <> 'Bloomington')
		   from department d, employedby w)

  -- Part 2 

select s1.sid, s1.sname
from student s1
where exists(
	select 1 
	from department d, employedby w
	where d.deptname = w.deptname 
	and s1.sid = w.sid 
	and d.mainoffice = 'LuddyHall'
	and true = any(select s1.sid = hf.sid1 and s2.sid = hf.sid2
				   from hasfriend hf, student s2
				   where s2.homecity <> 'Bloomington')
	)

 -- Part 3
select s1.sid, s1.sname
from student s1
where
true in (select d.deptname = w.deptname 
		   and s1.sid = w.sid 
		   and d.mainoffice = 'LuddyHall'
		   and true in (select s1.sid = hf.sid1 and s2.sid = hf.sid2
				   from hasfriend hf, student s2
				   where s2.homecity <> 'Bloomington')
		   from department d, employedby w)

\qecho 'Problem 14'
 -- Part 1
 select s1.sid
from student s1
where true = all(select true = any(select sm1.sid = s1.sid 
				 and sm2.sid = s2.sid 
				 and sm1.major = sm2.major 
				 and sm1.sid <> sm2.sid
				 from studentmajor sm1, studentmajor sm2)
				 from student s2, hasfriend hf
				 where hf.sid1=s1.sid and hf.sid2=s2.sid 
				)

-- Part 2
select s1.sid
from student s1
where true = all(select true in (select sm1.sid = s1.sid 
				 and sm2.sid = s2.sid 
				 and sm1.major = sm2.major 
				 and sm1.sid <> sm2.sid
				 from studentmajor sm1, studentmajor sm2)
				 
				 from student s2, hasfriend hf
				 where hf.sid1=s1.sid and hf.sid2=s2.sid 
				)

-- Part 3
select s1.sid
from student s1
where true = all(select exists(select 1 
							   from studentmajor sm1, studentmajor sm2 
							   where sm1.sid = s1.sid 
							   and sm2.sid = s2.sid 
							   and sm1.major = sm2.major 
							   and  sm1.sid <> sm2.sid
							  )
				 from student s2, hasfriend hf
				 where hf.sid1=s1.sid and hf.sid2=s2.sid 
				)


\qecho 'Problem 15'
-- Part 1
select s1.sid, s2.sid
from student s1,student s2
where s1.sid<>s2.sid
and true=all(select true = any(select f2.sid1 = s2.sid and f1.sid2 = f2.sid2 from hasfriend f2)
			from hasfriend f1
			where s1.sid=f1.sid1)
			
-- Part 2
select s1.sid, s2.sid
from student s1,student s2
where s1.sid<>s2.sid
and true=all(select true = any(select f2.sid1 = s2.sid and f1.sid2 = f2.sid2 from hasfriend f2) or s1.sid<>f1.sid1
			from hasfriend f1)
			
-- Part 3
select s1.sid, s2.sid
from student s1,student s2
where s1.sid<>s2.sid
and not true=any(select true = all(select f2.sid1 <> s2.sid or f1.sid2 <> f2.sid2 from hasfriend f2)
			from hasfriend f1
			where s1.sid=f1.sid1)

\qecho 'Problem 22.b'
-- Some major has fewer than 2 students with that major.
select exists(
	select m.major 
	from major m
	where not exists(
		select sm1.sid <> sm2.sid
		from studentmajor sm1, studentmajor sm2
		where sm1.major = sm2.major and sm1.major = m.major
	)
)

\qecho 'Problem 23.b'
-- Each student who works for a department has a friend who also works
-- for that department and who earns the same salary
select true = all (select true = all(
	select eb1.deptname = eb2.deptname 
	and eb1.salary = eb2.salary 
	and eb2.sid = hf.sid2
	and eb1.sid = hf.sid1
	from employedby eb2, hasfriend hf
)
from employedby eb1 )

\qecho 'Problem 24.b'
-- All students working in a same department share a major and earn the
-- same salary.
SELECT true= all(SELECT sm1.sid = eb1.sid and sm2.sid =eb2.sid and eb1.deptName= eb2.deptName 
			    and sm1.major= sm2.major and eb1.salary=eb2.salary and eb1.sid<>eb2.sid and sm1.sid<>sm2.sid
			    FROM studentMajor sm1, studentMajor sm2, employedBy eb1, employedBy eb2);


-- Connect to default database
-- \c postgres;

-- Drop database created for this assignment
-- DROP DATABASE dirkassignment;





