-- Script for Assignment 2

-- Creating database with full name
CREATE DATABASE aditcamassignment2;


-- Connecting to database 
\c aditcamassignment2

-- Relation schemas and instances for assignment 2


CREATE TABLE IF NOT EXISTS Student(sid integer,
                     sname text,
                     birthYear integer,
                     primary key (sid));

CREATE TABLE IF NOT EXISTS Book(bno integer,
                  title text,
                  price integer,
                  primary key (bno));

CREATE TABLE IF NOT EXISTS Major(major text,
                   primary key (major));


CREATE TABLE IF NOT EXISTS Buys(sid integer,
                  bno integer,
                  primary key (sid,bno),
                  foreign key (sid) references Student(sid),
                  foreign key (bno) references Book(bno));


CREATE TABLE IF NOT EXISTS hasMajor(sid integer,
                      major text,
                      primary key (sid, major),
                      foreign key (sid) references Student (sid),
                      foreign key (major) references Major (major));


CREATE TABLE IF NOT EXISTS Cites(bno1 integer,
                   bno2 integer,
                   primary key (bno1,bno2),
                   foreign key (bno1) references Book(bno),
                   foreign key (bno2) references Book(bno));

DELETE FROM Cites;
DELETE FROM hasMajor;
DELETE FROM Buys;
DELETE FROM Major;
DELETE FROM Book;
DELETE FROM Student;


INSERT INTO Student VALUES
 (1001,'Jean',1999),
 (1002,'Vidya',1999),
 (1003,'Anna',2001),
 (1004,'Qin',2001),
 (1005,'Megan',1999),
 (1006,'Ryan',1995),
 (1007,'Danielle',1997),
 (1008,'Emma',2000),
 (1009,'Hasan',2000),
 (1010,'Linda',1995),
 (1011,'Nick',1999),
 (1012,'Eric',1999),
 (1013,'Lisa',1998),
 (1014,'Deepa',2000),
 (1015,'Chris',1998),
 (1016,'YinYue',1995),
 (1017,'Latha',1997),
 (1018,'Arif',2000),
 (1019,'John',2003),
 (1020,'Margaret',1997);


INSERT INTO Book VALUES
 (2001,'Databases',20),
 (2002,'AI',20),
 (2003,'DataScience',25),
 (2004,'Databases',25),
 (2005,'Programming',30),
 (2006,'Complexity',30),
 (2007,'AI',20),
 (2008,'Algorithms',40),
 (2009,'Networks',40),
 (2010,'AI',30),
 (2011,'Logic',25),
 (2012,'Physics',45),
 (2013,'Physics',30);



INSERT INTO Buys VALUES
 (1003,2001),
 (1010,2007),
 (1011,2010),
 (1014,2007),
 (1010,2005),
 (1011,2003),
 (1008,2006),
 (1009,2003),
 (1006,2003),
 (1007,2008),
 (1017,2004),
 (1017,2003),
 (1004,2001),
 (1007,2006),
 (1005,2007),
 (1005,2011),
 (1013,2004),
 (1002,2009),
 (1009,2011),
 (1018,2011),
 (1015,2004),
 (1001,2011),
 (1013,2006),
 (1015,2002),
 (1005,2002),
 (1008,2009),
 (1014,2009),
 (1002,2002),
 (1001,2002),
 (1009,2001),
 (1006,2006),
 (1015,2007),
 (1019,2008),
 (1006,2002),
 (1018,2008),
 (1003,2004),
 (1006,2011),
 (1013,2005),
 (1003,2010),
 (1008,2008),
 (1007,2009),
 (1016,2008),
 (1011,2002),
 (1004,2005),
 (1004,2009),
 (1006,2010),
 (1001,2010),
 (1001,2006),
 (1009,2010),
 (1019,2002),
 (1004,2010),
 (1018,2010),
 (1009,2006),
 (1008,2003),
 (1018,2005),
 (1004,2002),
 (1011,2004),
 (1007,2002),
 (1015,2005),
 (1012,2001),
 (1017,2010),
 (1002,2001),
 (1016,2010),
 (1010,2003),
 (1003,2008),
 (1017,2005),
 (1016,2006),
 (1011,2007),
 (1006,2009),
 (1001,2005),
 (1007,2005),
 (1005,2004),
 (1013,2008),
 (1005,2008),
 (1004,2011),
 (1009,2009),
 (1013,2001),
 (1015,2006),
 (1003,2002),
 (1016,2001),
 (1006,2007),
 (1016,2011),
 (1006,2008),
 (1007,2003),
 (1015,2003),
 (1011,2011),
 (1010,2006),
 (1012,2009),
 (1001,2001),
 (1011,2001),
 (1013,2002),
 (1012,2007),
 (1002,2010),
 (1012,2010),
 (1001,2007),
 (1005,2003),
 (1011,2005),
 (1014,2011),
 (1011,2006),
 (1009,2002),
 (1008,2001),
 (1002,2003),
 (1002,2005),
 (1009,2008),
 (1008,2002),
 (1006,2001),
 (1008,2007),
 (1012,2002),
 (1017,2008),
 (1019,2009),
 (1010,2010),
 (1003,2011),
 (1017,2006),
 (1013,2011),
 (1006,2004),
 (1016,2004),
 (1019,2001),
 (1002,2006),
 (1018,2006),
 (1010,2009),
 (1010,2008),
 (1003,2007),
 (1009,2007),
 (1002,2007),
 (1018,2009),
 (1004,2004),
 (1018,2001),
 (1007,2001),
 (1004,2003),
 (1010,2001),
 (1008,2010),
 (1008,2005),
 (1015,2001),
 (1012,2003),
 (1005,2006),
 (1007,2010),
 (1010,2004),
 (1015,2010),
 (1017,2002),
 (1013,2003),
 (1001,2008),
 (1016,2002),
 (1005,2005),
 (1016,2009),
 (1012,2004),
 (1009,2004),
 (1020,2012),
 (1020,2013);



INSERT INTO Major VALUES
   ('CS'),
   ('DataScience'),
   ('Math'),
   ('Physics'),
   ('Chemistry'),
   ('English');

INSERT INTO hasMajor VALUES
 (1001,'CS'),
 (1001,'DataScience'),
 (1002,'CS'),
 (1002,'DataScience'),
 (1004,'DataScience'),
 (1004,'CS'),
 (1005,'DataScience'),
 (1005,'CS'),
 (1005,'Math'),
 (1006,'CS'),
 (1006,'Physics'),
 (1007,'Physics'),
 (1007,'CS'),
 (1009,'Physics'),
 (1009,'Math'),
 (1010,'Math'),
 (1011,'Math'),
 (1011,'Physics'),
 (1011,'DataScience'),
 (1011,'CS'),
 (1012,'DataScience'),
 (1012,'Physics'),
 (1012,'CS'),
 (1013,'CS'),
 (1013,'Physics'),
 (1013,'Math'),
 (1014,'Physics'),
 (1014,'DataScience'),
 (1014,'Math'),
 (1015,'CS'),
 (1015,'DataScience'),
 (1016,'Physics'),
 (1016,'DataScience'),
 (1017,'Math'),
 (1017,'CS'),
 (1018,'DataScience'),
 (1019,'Math'),
 (1020,'Chemistry');


INSERT INTO Cites VALUES
 (2004,2003),
 (2006,2003),
 (2009,2003),
 (2009,2004),
 (2009,2006),
 (2008,2007),
 (2010,2008),
 (2010,2007),
 (2010,2003),
 (2002,2001),
 (2009,2001),
 (2011,2003),
 (2011,2005),
 (2001,2004),
 (2012,2013);

create table PC(parent integer,
                child integer);

insert into PC values
 (1,2),
 (1,3),
 (1,4),
 (2,5),
 (2,6),
 (3,7),
 (5,8),
 (8,9),
 (8,10),
 (8,11),
 (7,12),
 (7,13),
 (12,14),
 (14,15);

\qecho 'Problem 3'

-- Find the bno and title of each book that is bought by a student who
-- is (strictly) younger than each student who majors in Chemistry and
-- who also bought that book.


\qecho 'Problem 3.c'

-- Express this query in Pure SQL by only using the ‘true = some’ or
-- ‘true = all’ subquery expressions. You can not use the set operations
-- INTERSECT, UNION, and EXCEPT.

-- DROP VIEW TT;


-- CREATE OR REPLACE VIEW TT AS
-- 	(SELECT S.SID,
-- 			S.BIRTHYEAR,
-- 			B.BNO
-- 		FROM STUDENT S,
-- 			HASMAJOR HM,
-- 			BUYS B
-- 		WHERE S.SID = HM.SID
-- 			AND S.SID = B.SID
-- 			AND HM.MAJOR = 'Chemistry');


-- SELECT B.BNO,
-- 	B.TITLE
-- FROM BOOK B
-- WHERE TRUE = ALL
-- 		(SELECT S.BIRTHYEAR < TT.BIRTHYEAR
-- 			FROM STUDENT S,
-- TT
-- 			WHERE S.SID <> TT.SID
-- 				AND TT.BNO = B.BNO);

create view tt as (select 1);

SELECT B.BNO,B.TITLE FROM BOOK B
WHERE TRUE = SOME (SELECT B.BNO = BS.BNO FROM BUYS BS,STUDENT S
				   WHERE BS.SID = S.SID 
				   AND TRUE = ALL(SELECT S.SID <> S1.SID
								  AND S.BIRTHYEAR > S1.BIRTHYEAR 
								  FROM STUDENT S1,HASMAJOR HM
								  WHERE HM.SID = S1.SID 
								  AND HM.SID = BS.SID
								  AND HM.MAJOR = 'Chemistry'));
		    
\qecho 'Problem 3.d'

-- Express this query in Pure SQL by only using the ‘exists’ or ‘not
-- exists’ subquery expressions. You can not use the set operations
-- INTERSECT, UNION, and EXCEPT.

-- DROP VIEW TT;

-- CREATE OR REPLACE VIEW TT AS
-- 	(SELECT S.SID,
-- 			S.BIRTHYEAR,
-- 			B.BNO
-- 		FROM STUDENT S,
-- 			HASMAJOR HM,
-- 			BUYS B
-- 		WHERE S.SID = HM.SID
-- 			AND S.SID = B.SID
-- 			AND HM.MAJOR = 'Chemistry');

-- SELECT B.BNO,
-- 	B.TITLE
-- FROM BOOK B
-- WHERE NOT EXISTS
-- 		(SELECT 1
-- 			FROM STUDENT S,
-- TT
-- 			WHERE S.SID <> TT.SID
-- 				AND TT.BNO = B.BNO
-- 				AND S.BIRTHYEAR >= TT.BIRTHYEAR);
				 
SELECT B.BNO,
	B.TITLE
FROM BOOK B
WHERE EXISTS
		(SELECT 1
			FROM BUYS BS,STUDENT S
			WHERE BS.SID = S.SID
				AND B.BNO = BS.BNO
				AND NOT EXISTS
					(SELECT S.SID <> S1.SID
						AND S.BIRTHYEAR > S1.BIRTHYEAR
						FROM STUDENT S1,HASMAJOR HM
						WHERE HM.SID = S1.SID
							AND HM.MAJOR = 'Chemistry'
							AND HM.SID = BS.SID));

\qecho 'Problem 3.e'

-- Express this query in Pure SQL by only using the `in' or `not in' subquery
-- expressions. You can not use the set operations INTERSECT, UNION, and
-- EXCEPT.

-- DROP view tt;
-- create or replace view tt as (
-- select s.sid,s.birthyear,b.bno
-- from student s,hasmajor hm,buys b
-- where s.sid = hm.sid and s.sid = b.sid and hm.major = 'Chemistry');

-- SELECT b.bno,b.title
-- FROM book b
-- WHERE  1 not in (select 1
-- 				 from student s,tt
-- 				 where s.sid<>tt.sid and tt.bno=b.bno and s.birthyear>=tt.birthyear);

SELECT B.BNO,B.TITLE
FROM BOOK B
WHERE B.BNO IN
		(SELECT BS.BNO
			FROM BUYS BS,STUDENT S
			WHERE BS.SID = S.SID
				AND S.SID NOT IN
					(SELECT S1.SID
						FROM STUDENT S1,HASMAJOR HM
						WHERE HM.SID = S1.SID
							AND HM.MAJOR = 'Chemistry'
							AND HM.SID = BS.SID
							AND S.BIRTHYEAR <= S1.BIRTHYEAR));
							
\qecho 'Problem 3.f'

-- Express this query in Pure SQL without using subquery expressions. Now
-- you can use the set operations INTERSECT, UNION, and EXCEPT.

DROP view chem_student_books_3f;
create or replace view chem_student_books_3f as (
select s.sid,s.birthyear,b.bno,b.title
from student s,hasmajor hm,buys bs,book b 
where s.sid = hm.sid and s.sid = bs.sid and hm.major = 'Chemistry' and b.bno = bs.bno);

DROP view all_student_books_3f;
create or replace view all_student_books_3f as (
select s.sid,s.birthyear,b.bno,b.title
from student s,buys bs,book b
where s.sid = bs.sid and b.bno = bs.bno);

select bno,title
from book b
except (
	select t1.bno, t1.title from
	all_student_books_3f t1, chem_student_books_3f t2
	where t1.birthyear >= t2.birthyear and t1.bno = t2.bno
);

\qecho 'Problem 4'

-- Find each student-book pair (s, b) where s is the sid of a student who
-- majors in CS and who bought each book that costs no more than
-- book b.

\qecho 'Problem 4.b'

-- Express this query in Pure SQL by only using the ‘true = some’ or
-- ‘true = all’ subquery expressions. You can not use the set operations
-- INTERSECT, UNION, and EXCEPT.

create or replace view student_cs_4b as (
select s.sid,b.bno, b.price
from student s, buys bs, book b, hasmajor hm
where s.sid = bs.sid and bs.bno = b.bno and hm.sid = s.sid and hm.major='CS'
	);

CREATE OR REPLACE FUNCTION books_below_price(price integer)
  RETURNS TABLE (bno INTEGER) AS
$func$
    SELECT bno 
	FROM book
	WHERE price <= $1
$func$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION student_books(sid integer)
  RETURNS TABLE (bno INTEGER) AS
$func$
    SELECT bno 
	FROM student_cs_4b
	WHERE sid = $1
$func$ LANGUAGE sql;

SELECT tt.sid, tt.bno
FROM student_cs_4b tt 
WHERE not true = some(select true
				from books_below_price(tt.price) t1
				where not true = some (select true 
							  from student_books(tt.sid) t2
							 where t1.bno = t2.bno )) order by 1,2;

\qecho 'Problem 4.c'

-- Express this query in Pure SQL by only using the ‘exists’ or ‘not
-- exists’ subquery expressions. You can not use the set operations
-- INTERSECT, UNION, and EXCEPT.d

create or replace view student_cs_4c as (
select s.sid,b.bno, b.price
from student s, buys bs, book b, hasmajor hm
where s.sid = bs.sid and bs.bno = b.bno and hm.sid = s.sid and hm.major='CS'
	);

CREATE OR REPLACE FUNCTION books_below_price(price integer)
  RETURNS TABLE (bno INTEGER) AS
$func$
    SELECT bno 
	FROM book
	WHERE price <= $1
$func$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION student_books(sid integer)
  RETURNS TABLE (bno INTEGER) AS
$func$
    SELECT bno 
	FROM student_cs_4c
	WHERE sid = $1
$func$ LANGUAGE sql;

SELECT tt.sid, tt.bno
FROM student_cs_4c tt 
WHERE not exists(select t1.bno
				from books_below_price(tt.price) t1
				where not exists (select 1 
							  from student_books(tt.sid) t2
							 where t1.bno = t2.bno )) order by 1,2;


\qecho 'Problem 4.d'

-- Express this query in Pure SQL by only using the `in' or `not in' subquery
-- expressions. You can not use the set operations INTERSECT, UNION, and
-- EXCEPT.

create or replace view student_cs_4d as (
select s.sid,b.bno, b.price
from student s, buys bs, book b, hasmajor hm
where s.sid = bs.sid and bs.bno = b.bno and hm.sid = s.sid and hm.major='CS'
	);

CREATE OR REPLACE FUNCTION books_below_price(price integer)
  RETURNS TABLE (bno INTEGER) AS
$func$
    SELECT bno 
	FROM book
	WHERE price <= $1
$func$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION student_books(sid integer)
  RETURNS TABLE (bno INTEGER) AS
$func$
    SELECT bno 
	FROM student_cs_4d
	WHERE sid = $1
$func$ LANGUAGE sql;


SELECT tt.sid, tt.bno
FROM student_cs_4d tt 
WHERE false not in (select false
	  from books_below_price(tt.price) t1
	  where t1.bno not in (select t2.bno from student_books(tt.sid) t2)) order by 1,2;

\qecho 'Problem 4.e'

-- Express this query in Pure SQL without using subquery expressions. Now
-- you can use the set operations INTERSECT, UNION, and EXCEPT.

-- DROP view tt;
-- create or replace view tt as (
-- select s.sid,b.bno, b.price
-- from student s, buys bs, book b, hasmajor hm
-- where s.sid = bs.sid and bs.bno = b.bno and hm.sid = s.sid and hm.major='CS'
-- 	);

-- DROP view tt1;
-- create or replace view tt1 as (
-- select tt.sid,tt.bno
-- 	from tt
-- 	where exists ((select t1.bno from books_below_price(tt.price) t1) except (select t2.bno from student_books(tt.sid) t2))
-- 	);

-- CREATE OR REPLACE FUNCTION books_below_price(price integer)
--   RETURNS TABLE (bno INTEGER) AS
-- $func$
--     SELECT bno 
-- 	FROM book
-- 	WHERE price <= $1
-- $func$ LANGUAGE sql;

-- CREATE OR REPLACE FUNCTION student_books(sid integer)
--   RETURNS TABLE (bno INTEGER) AS
-- $func$
--     SELECT bno 
-- 	FROM tt
-- 	WHERE sid = $1
-- $func$ LANGUAGE sql;

-- SELECT tt.sid, tt.bno
-- FROM tt
-- EXCEPT
-- SELECT tt1.sid,tt1.bno
-- FROM tt1;


-- Correct solution 

DROP view if EXISTS student_bought_books ;
create or replace view student_bought_books as (
select s.sid,b.bno,b.price
from student s,buys bs, book b, hasmajor hm
where bs.sid = s.sid and b.bno = bs.bno and hm.sid = s.sid and hm.major = 'CS'
);

DROP view if EXISTS student_bought_books_all_combi ;
create or replace view student_bought_books_all_combi as (
select s.sid,b.bno,b.price
from student s,book b
);

select sid,bno
from student_bought_books
except
(	
	select sbb.sid,sbb.bno
	from student_bought_books sbb,
	( select sid,bno,price
		  from student_bought_books_all_combi 
		  except 
		  select sid,bno,price
		  from student_bought_books
		 ) diff
	where sbb.sid = diff.sid and sbb.price >= diff.price
);


\qecho 'Problem 5'

-- Find the sid and name of each student who bought all-but-one book that
-- cost strictly more than $30.

\qecho 'Problem 5.b'

-- Express this query in Pure SQL by only using the ‘true = some’ or
-- ‘true = all’ subquery expressions. You can not use the set operations
-- INTERSECT, UNION, and EXCEPT.


DROP VIEW IF EXISTS STUDENT_MISSED_BOOKS_GT_30_5B;
DROP VIEW IF EXISTS STUDENT_BOUGHT_BOOKS_GT_30_5B ;
DROP VIEW IF EXISTS STUDENT_BOUGHT_BOOKS_ALL_COMBI_GT_30_5B;

CREATE OR REPLACE VIEW STUDENT_BOUGHT_BOOKS_ALL_COMBI_GT_30_5B AS
	(SELECT S.SID,
			S.SNAME,
			B.BNO,
			B.PRICE
		FROM STUDENT S,
			BOOK B
		WHERE B.PRICE > 30 );

CREATE OR REPLACE VIEW STUDENT_BOUGHT_BOOKS_GT_30_5B AS
	(SELECT S.SID,
			S.SNAME,
			B.BNO,
			B.PRICE
		FROM STUDENT S,
			BUYS BS,
			BOOK B
		WHERE BS.SID = S.SID
			AND B.BNO = BS.BNO
			AND B.PRICE > 30 );

CREATE OR REPLACE VIEW STUDENT_MISSED_BOOKS_GT_30_5B AS
	(SELECT SID,
			SNAME,
			BNO,
			PRICE
		FROM STUDENT_BOUGHT_BOOKS_ALL_COMBI_GT_30_5B T1
		WHERE NOT true = some
				(SELECT T1.BNO = T2.BNO
					FROM STUDENT_BOUGHT_BOOKS_GT_30_5B T2
					WHERE T2.SID = T1.SID
				));

SELECT DISTINCT SID,
	SNAME
FROM STUDENT_BOUGHT_BOOKS_GT_30_5B T3
WHERE true = all (
		(SELECT false
			FROM STUDENT_MISSED_BOOKS_GT_30_5B T1,
				STUDENT_MISSED_BOOKS_GT_30_5B T2
			WHERE T1.SID = T2.SID
				AND T1.BNO < T2.BNO
				AND T3.SID=T2.SID));

\qecho 'Problem 5.c'

-- Express this query in Pure SQL by only using the ‘exists’ or ‘not
-- exists’ subquery expressions. You can not use the set operations
-- INTERSECT, UNION, and EXCEPT.

DROP VIEW IF EXISTS STUDENT_MISSED_BOOKS_GT_30_5C;
DROP VIEW IF EXISTS STUDENT_BOUGHT_BOOKS_GT_30_5C ;
DROP VIEW IF EXISTS STUDENT_BOUGHT_BOOKS_ALL_COMBI_GT_30_5C;

CREATE OR REPLACE VIEW STUDENT_BOUGHT_BOOKS_ALL_COMBI_GT_30_5C AS
	(SELECT S.SID,
			S.SNAME,
			B.BNO,
			B.PRICE
		FROM STUDENT S,
			BOOK B
		WHERE B.PRICE > 30 );

CREATE OR REPLACE VIEW STUDENT_BOUGHT_BOOKS_GT_30_5C AS
	(SELECT S.SID,
			S.SNAME,
			B.BNO,
			B.PRICE
		FROM STUDENT S,
			BUYS BS,
			BOOK B
		WHERE BS.SID = S.SID
			AND B.BNO = BS.BNO
			AND B.PRICE > 30 );

CREATE OR REPLACE VIEW STUDENT_MISSED_BOOKS_GT_30_5C AS
	(SELECT SID,
			SNAME,
			BNO,
			PRICE
		FROM STUDENT_BOUGHT_BOOKS_ALL_COMBI_GT_30_5C T1
		WHERE NOT EXISTS
				(SELECT 1
					FROM STUDENT_BOUGHT_BOOKS_GT_30_5C T2
					WHERE T2.SID = T1.SID
						AND T2.BNO = T1.BNO));

SELECT DISTINCT SID,
	SNAME
FROM STUDENT_BOUGHT_BOOKS_GT_30_5C T3
WHERE NOT EXISTS (
		(SELECT T1.SID,
				T1.SNAME
			FROM STUDENT_MISSED_BOOKS_GT_30_5C T1,
				STUDENT_MISSED_BOOKS_GT_30_5C T2
			WHERE T1.SID = T2.SID
				AND T1.BNO < T2.BNO
				AND T3.SID=T2.SID));

-- DROP VIEW TT;


-- CREATE OR REPLACE VIEW TT AS
-- 	(SELECT S.SID,
-- 			B.BNO,
-- 			B.PRICE
-- 		FROM STUDENT S,
-- 			BUYS BS,
-- 			BOOK B
-- 		WHERE S.SID = BS.SID
-- 			AND BS.BNO = B.BNO );


-- CREATE OR REPLACE FUNCTION STUDENT_BOOKS_GT_30(SID integer) RETURNS TABLE (BNO INTEGER) AS $func$
-- 		SELECT bno
-- 		FROM tt
-- 		WHERE sid = $1 and tt.price>30
-- 	$func$ LANGUAGE SQL;


-- CREATE OR REPLACE VIEW BOOKS_GT_30 AS
-- 	(SELECT BNO
-- 		FROM BOOK
-- 		WHERE PRICE > 30);


-- SELECT STU.SID,
-- 	STU.SNAME
-- FROM STUDENT STU
-- WHERE NOT EXISTS
-- 		(WITH A AS
-- 				(SELECT *
-- 					FROM BOOKS_GT_30),
-- 				B AS
-- 				(SELECT *
-- 					FROM STUDENT_BOOKS_GT_30(STU.SID)),
-- 				S AS
-- 				(SELECT A1.BNO
-- 					FROM A A1
-- 					WHERE NOT EXISTS
-- 							(SELECT B1.BNO
-- 								FROM B B1
-- 								WHERE B1.BNO = A1.BNO)),
-- 				AA AS
-- 				(SELECT A1.BNO
-- 					FROM A A1,
-- 						A A2
-- 					WHERE A1.BNO <> A2.BNO
-- 						AND A1.BNO < A2.BNO),
-- 				SS AS
-- 				(SELECT S1.BNO
-- 					FROM S S1,
-- 						S S2
-- 					WHERE S1.BNO <> S2.BNO
-- 						AND S1.BNO < S2.BNO),
-- 				X AS
-- 				(SELECT AA1.BNO
-- 					FROM AA AA1
-- 					WHERE NOT EXISTS
-- 							(SELECT SS1.BNO
-- 								FROM SS SS1
-- 								WHERE SS1.BNO = AA1.BNO)) SELECT *
-- 			FROM
-- 				(SELECT AA1.BNO
-- 					FROM AA AA1
-- 					WHERE NOT EXISTS
-- 							(SELECT X1.BNO
-- 								FROM X X1
-- 								WHERE X1.BNO = AA1.BNO)) TEMP_)


\qecho 'Problem 5.d'

-- Express this query in Pure SQL by only using the `in' or `not in' subquery
-- expressions. You can not use the set operations INTERSECT, UNION, and
-- EXCEPT.

DROP VIEW IF EXISTS STUDENT_MISSED_BOOKS_GT_30_5D;
DROP VIEW IF EXISTS STUDENT_BOUGHT_BOOKS_GT_30_5D ;
DROP VIEW IF EXISTS STUDENT_BOUGHT_BOOKS_ALL_COMBI_GT_30_5D;
CREATE OR REPLACE VIEW STUDENT_BOUGHT_BOOKS_ALL_COMBI_GT_30_5D AS
	(SELECT S.SID,
			S.SNAME,
			B.BNO,
			B.PRICE
		FROM STUDENT S,
			BOOK B
		WHERE B.PRICE > 30 );

CREATE OR REPLACE VIEW STUDENT_BOUGHT_BOOKS_GT_30_5D AS
	(SELECT S.SID,
			S.SNAME,
			B.BNO,
			B.PRICE
		FROM STUDENT S,
			BUYS BS,
			BOOK B
		WHERE BS.SID = S.SID
			AND B.BNO = BS.BNO
			AND B.PRICE > 30 );

CREATE OR REPLACE VIEW STUDENT_MISSED_BOOKS_GT_30_5D AS
	(SELECT SID,
			SNAME,
			BNO,
			PRICE
		FROM STUDENT_BOUGHT_BOOKS_ALL_COMBI_GT_30_5D T1
	 	WHERE 1 not in (select 1
					   from STUDENT_BOUGHT_BOOKS_GT_30_5D T2
					   where T2.SID = T1.SID and T2.BNO = T1.BNO));

SELECT distinct SID,
	SNAME
FROM STUDENT_BOUGHT_BOOKS_GT_30_5D
WHERE SID not in (
		(SELECT T1.SID
			FROM STUDENT_MISSED_BOOKS_GT_30_5D T1,STUDENT_MISSED_BOOKS_GT_30_5D T2 
		 WHERE T1.SID = T2.SID
			AND T1.BNO < T2.BNO));		 


\qecho 'Problem 5.e'

-- Express this query in Pure SQL without using subquery expressions. Now
-- you can use the set operations INTERSECT, UNION, and EXCEPT.

DROP VIEW IF EXISTS STUDENT_MISSED_BOOKS_GT_30_5E;
DROP VIEW IF EXISTS STUDENT_BOUGHT_BOOKS_GT_30_5E ;
DROP VIEW IF EXISTS STUDENT_BOUGHT_BOOKS_ALL_COMBI_GT_30_5E;
CREATE OR REPLACE VIEW STUDENT_BOUGHT_BOOKS_ALL_COMBI_GT_30_5E AS
	(SELECT S.SID,
			S.SNAME,
			B.BNO,
			B.PRICE
		FROM STUDENT S,
			BOOK B
		WHERE B.PRICE > 30 );

CREATE OR REPLACE VIEW STUDENT_BOUGHT_BOOKS_GT_30_5E AS
	(SELECT S.SID,
			S.SNAME,
			B.BNO,
			B.PRICE
		FROM STUDENT S,
			BUYS BS,
			BOOK B
		WHERE BS.SID = S.SID
			AND B.BNO = BS.BNO
			AND B.PRICE > 30 );

CREATE OR REPLACE VIEW STUDENT_MISSED_BOOKS_GT_30_5E AS
	(SELECT SID,
			SNAME,
			BNO,
			PRICE
		FROM STUDENT_BOUGHT_BOOKS_ALL_COMBI_GT_30_5E
		EXCEPT SELECT SID,
			SNAME,
			BNO,
			PRICE
		FROM STUDENT_BOUGHT_BOOKS_GT_30_5E);

SELECT SID,
	SNAME
FROM STUDENT_BOUGHT_BOOKS_GT_30_5E
EXCEPT (
		(SELECT T1.SID,
				T1.SNAME
			FROM STUDENT_MISSED_BOOKS_GT_30_5E T1
			JOIN STUDENT_MISSED_BOOKS_GT_30_5E T2 ON T1.SID = T2.SID
			AND T1.BNO < T2.BNO)) order by 1;


\qecho 'Problem 10.b'

-- Find the bno and title of each book that was bought by exactly one
-- student.

-- Express this query in RA SQL.
CREATE OR REPLACE VIEW STUDENT_BOOKS_10B AS
	(SELECT S.SID,
			B.BNO,
			B.TITLE
		FROM STUDENT S 
        NATURAL JOIN BUYS BS
        NATURAL JOIN BOOK B);

SELECT BNO,TITLE
FROM STUDENT_BOOKS_10B
EXCEPT
SELECT T1.BNO,
	T1.TITLE
FROM STUDENT_BOOKS_10B T1
JOIN STUDENT_BOOKS_10B T2 ON T1.BNO = T2.BNO
AND T1.SID <> T2.SID;


\qecho 'Problem 11.b'

-- Find each pair (m, b) where m is a major and b is the bno of a book
-- bought by a student who has major m and such that the price of b is
-- the lowest among the set of books bought by students with major m

-- Express this query in RA SQL.

CREATE OR REPLACE VIEW MAJOR_BOOKS_11B AS
	(SELECT HM.MAJOR,B.BNO FROM BOOK B
		JOIN BUYS BS ON B.BNO = BS.BNO
		JOIN HASMAJOR HM ON BS.SID = HM.SID
		);
		
CREATE OR REPLACE VIEW MAJOR_BOOKS_NOT_CHEAPEST_11B AS
	(SELECT M.MAJOR,
			B2.BNO
		FROM MAJOR M
		JOIN HASMAJOR HM ON HM.MAJOR = M.MAJOR
		JOIN BUYS BS ON HM.SID = BS.SID
		JOIN BOOK B1 ON (B1.BNO = BS.BNO)
		JOIN BOOK B2 ON (B1.PRICE < B2.PRICE));
		
SELECT MAJOR,BNO 
FROM
(	
	SELECT * FROM MAJOR_BOOKS_11B 
	EXCEPT
	SELECT * FROM MAJOR_BOOKS_NOT_CHEAPEST_11B
) temp_
order by 1,2;
		

\qecho 'Problem 12.b'

-- Find the bno and title of each book that is bought by a student who is
-- (strictly) younger than each student who majors in Chemistry and who
-- also bought that book.

-- Express this query in RA SQL.

create or replace view chem_student_books_12b as (
select s.sid,s.birthyear,b.bno,b.title
from student s 
join hasmajor hm on s.sid = hm.sid
join buys bs on s.sid = bs.sid
join book b on b.bno = bs.bno
where hm.major = 'Chemistry');

create or replace view all_student_books_12b as (
select s.sid,s.birthyear,b.bno,b.title
from student s join buys bs on s.sid = bs.sid join book b on b.bno = bs.bno
);

select bno,title
from book b
except (
	select t1.bno, t1.title from
	all_student_books_12b t1, chem_student_books_12b t2
	where t1.birthyear >= t2.birthyear and t1.bno = t2.bno
) order by 1;

\qecho 'Problem 13.b'

-- Find each student-book pair (s, b) where s is the sid of a student who
-- majors in CS and who bought each book that costs no more than
-- book b.


-- Express this query in RA SQL.

DROP view if EXISTS student_bought_books ;
create or replace view student_bought_books as (
select s.sid,b.bno,b.price
from student s
join buys bs 
on bs.sid = s.sid
join book b
on b.bno = bs.bno
join hasmajor hm
on hm.sid = s.sid
where hm.major = 'CS'
);

DROP view if EXISTS student_bought_books_all_combi ;
create or replace view student_bought_books_all_combi as (
select s.sid,b.bno,b.price
from student s
CROSS join book b
);

select sid,bno
from student_bought_books
except
(	
	select sbb.sid,sbb.bno
	from student_bought_books sbb
	join ( select sid,bno,price
		  from student_bought_books_all_combi 
		  except 
		  select sid,bno,price
		  from student_bought_books
		 ) diff
	on sbb.sid = diff.sid and sbb.price >= diff.price
) order by 1,2;


\qecho 'Problem 14.b'

-- Find the sid and name of each student who bought all-but-one book that
-- cost strictly more than $30.
DROP view if EXISTS student_missed_books_gt_30;
DROP view if EXISTS student_bought_books_gt_30 ;
DROP view if EXISTS student_bought_books_all_combi_gt_30;
create or replace view student_bought_books_all_combi_gt_30 as (
select s.sid,s.sname,b.bno,b.price
from student s
CROSS join book b
where b.price > 30
);

create or replace view student_bought_books_gt_30 as (
select s.sid,s.sname,b.bno,b.price
from student s 
join buys bs
ON bs.sid = s.sid
join 
book b
	on b.bno = bs.bno
where b.price > 30
);

create or replace view student_missed_books_gt_30 as (
		select sid,sname,bno,price
		from student_bought_books_all_combi_gt_30
		except
		select sid,sname,bno,price
		from student_bought_books_gt_30);

select sid,sname
from student_bought_books_gt_30
except 
(
	(
		select t1.sid,t1.sname
		from student_missed_books_gt_30 t1
		join student_missed_books_gt_30 t2
		on t1.sid = t2.sid and t1.bno<t2.bno
	)
) order by 1;


\qecho 'Problem 27'

/*
 Define a parameterized view
 ‘PurchasedBookLessPrice(sid int, price integer)’
 that returns, for a given student identi- fied by ‘sid’ and
a given ‘price’ value, the subrelation of ‘Book’ of books that are
bought by that student and that cost strictly less than ‘price’.

Test your view for the parameter values (1001,15), (1001,20),
(1001,50), and (1002,30).
*/

DROPif exists view tt;
create or replace view tt as (
select s.sid,b.*
from student s
join buys bs 
on bs.sid = s.sid
join book b
on b.bno = bs.bno);


CREATE OR REPLACE FUNCTION PurchasedBookLessPrice(sid integer, price integer)
  RETURNS TABLE (bno INTEGER,title text,price INTEGER) AS
$func$
    SELECT tt.bno,tt.title,tt.price
	FROM tt
	WHERE sid = $1 and tt.price<$2
$func$ LANGUAGE sql;

select * from PurchasedBookLessPrice(1001,15);
select * from PurchasedBookLessPrice(1001,30);
select * from PurchasedBookLessPrice(1001,50);
select * from PurchasedBookLessPrice(1002,30);

\qecho 'Problem 28'

/*
Define a parameterized view ‘CitedBookbyMajor(major text)’ that
returns for a major ‘major’ the subrelation of ‘Book’ of books that
are cited by a book bought by a the student who majors in ‘major’.

Test your view for each major.
*/

DROP view tt;
create or replace view tt as (
	(select bs.bno,hm.major
	from student s
	join buys bs
	on bs.sid = s.sid
	join hasmajor hm
	on hm.sid = s.sid)
	UNION
	(select bs.bno,hm.major
	from student s
	join buys bs
	on bs.sid = s.sid
	join hasmajor hm
	on hm.sid = s.sid)
);

CREATE OR REPLACE FUNCTION CitedBookbyMajor(major text)
  RETURNS TABLE (bno INTEGER,title text,price INTEGER) AS
$func$
	select *
	from book b
	where b.bno in (select c.bno2
				   from tt
				   join cites c
					on tt.bno = c.bno1
					where tt.major = $1
				   )
$func$ LANGUAGE sql;


select * from CitedBookbyMajor('Chemistry');
select * from CitedBookbyMajor('CS'); 
select * from CitedBookbyMajor('DataScience'); 
select * from CitedBookbyMajor('English');
select * from CitedBookbyMajor('Math'); 
select * from CitedBookbyMajor('Physics');

\qecho 'Problem 29'

/*
Define a parameterized view
‘JointlyBoughtBook(sid1 integer, sid2 integer)’
that returns the subrelation of ‘Book’ of books that are
bought by both the students with sids ‘sid1’ and ‘sid2’, respectively.

Test your view for the parameters (1001, 1002), (1001,1003), and
(1002,1003).
*/

DROP view tt;
create or replace view tt as (
select s.sid,b.*
from student s
join buys bs 
on bs.sid = s.sid
join book b
on b.bno = bs.bno);

CREATE OR REPLACE FUNCTION student_buys_books(sid integer)
  RETURNS TABLE (bno INTEGER,title text,price INTEGER) AS
$func$
    SELECT tt.bno,tt.title,tt.price
	FROM tt
	WHERE sid = $1
$func$ LANGUAGE sql;


CREATE OR REPLACE FUNCTION JointlyBoughtBook(sid1 integer,sid2 integer)
  RETURNS TABLE (bno INTEGER,title text,price INTEGER) AS
$func$
	select * from student_buys_books($1)
	intersect
	select * from student_buys_books($2)
$func$ LANGUAGE sql;

select * from JointlyBoughtBook(1001,1002);
select * from JointlyBoughtBook(1001,1003);
select * from JointlyBoughtBook(1002,1003);

\qecho 'Problem 30'

/*
Let PC(parent : integer,child : integer) be a rooted parent- child
tree. So a pair (n, m) in ‘PC’ indicates that node n is a parent of
node m. The ‘sameGeneration(n1, n2)’ binary relation is inductively
defined using the following two rules:

(1) If n is a node in PC, then the pair (n, n) is in the
sameGeneration relation. (Base rule)

(2) If n1 is the parent of m1 in PC and n2 is the parent of m2 in PC
and (n1,n2) is a pair in the sameGeneration relation then (m1, m2) is
a pair in the sameGeneration relation. (Inductive Rule)

Write a recursive view for the sameGeneration relation. Test your
view.
*/

CREATE OR REPLACE RECURSIVE VIEW SAMEGENERATION(N1,N2) AS
	(SELECT PC.PARENT,
			PC.PARENT
		FROM PC
		UNION 
	 SELECT PC.CHILD,
			PC.CHILD
		FROM PC
		UNION 
	 SELECT PC1.CHILD,
			PC2.CHILD
		FROM PC PC1,
			PC PC2,
			SAMEGENERATION S
		WHERE PC1.PARENT = S.N1
	 		AND PC2.PARENT = S.N2
			AND PC2.CHILD <> PC1.CHILD
			AND (PC1.PARENT <> PC2.PARENT
				 OR PC2.PARENT = PC1.PARENT)
	);

SELECT *
FROM SAMEGENERATION
ORDER BY 1,2;


-- Connect to default database
-- \c postgres

--
-- Drop database created for this assignment
DROP DATABASE aditcamassignment2;




