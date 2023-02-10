-- Script for Assignment 6  Fall 2022

-- Creating database with full name

CREATE DATABASE team41_a6;


-- Connecting to database 
\c team41_a6

\qecho 'Section 1 Data Generation'
\qecho 'Problem 1'


create table P (outcome integer, probability float);

create or replace view samples as (
select outcome,probability,sum(probability) over (partition by batch order by outcome) as cumulativep 
	from (select *,0 as batch from P) as x
);

create or replace function RelationOverProbabilityFunction(n integer, l1 integer, u1 integer, l2 integer,u2 integer)
returns table(x integer,y integer) as
$$
with p_distribution as (
select min(outcome) from samples,(select random() x from generate_series(1,n)) y
	where y.x < cumulativep group by y.x
)
select floor(random()*(u1-l1+1)+1)::int x,min::int y from p_distribution;
$$language sql;

insert into P values
(1,0.125),
(2,0.125),
(3,0.125),
(4,0.125),
(5,0.125),
(6,0.125),
(7,0.125),
(8,0.125);

select * from RelationOverProbabilityFunction(100, 1, 150, 1, 8);

delete from P;

insert into P values
(1,0.25),
(2,0.05),
(3,0.10),
(4,0.10),
(5,0.15),
(6,0.05),
(7,0.10),
(8,0.20);

select * from RelationOverProbabilityFunction(100, 1, 150, 1, 8);

delete from P;

\qecho 'Problem 2'

DROP TABLE IF EXISTS skill;
create table Skill (skill text);
INSERT INTO Skill VALUES
   ('Programming'),
   ('AI'),
   ('Networks'),
   ('Databases');
						
DROP TABLE IF EXISTS pmfSkill;
create table pmfSkill(skill text, prob float);
insert into pmfSkill values 
    ('Programming', 0.1),
    ( 'AI', 0.2),
    ( 'Networks', 0.3),
	('Databases',0.4);
SELECT * FROM pmfskill;

CREATE OR REPLACE FUNCTION personskillgenerator(n int, l int, u int) 
RETURNS TABLE (pid int, skill text) as
$$
with skillindex(skill, rn) as (SELECT skill, ROW_NUMBER() OVER (ORDER BY 1) AS rn 
							   FROM   Skill),
pmf as (select si.rn AS outcome,ps.prob AS probability 
		from pmfskill ps
		INNER JOIN skillindex si ON ps.skill=si.skill),
	
cumdist as (select pmf.outcome,
				   (SUM (probability) OVER (ORDER BY pmf.outcome))-probability AS lbound,
				   SUM (probability) OVER (ORDER BY pmf.outcome) as ubound
                                        from   pmf pmf),
q as (select floor(random() * (u-l+1) + l)::int as x, random() as y    
         from   generate_series(1,n))
select q.x as pid, si.skill
from   q,
       cumdist cd,
       skillindex si
where  lbound <= y and y < ubound and
       cd.outcome = si.rn
group by (x,si.skill);
$$ language sql;

WITH q as
(
select * from personskillgenerator(10,1,20)
),
count_dist AS
(SELECT skill,COUNT(*) as count_rec
FROM q
GROUP BY 1
),
sum_rec AS
(SELECT *,SUM(count_rec)OVER(ORDER BY 1) AS total_rec
FROM count_dist)
SELECT *,ROUND((count_rec/total_rec),2) AS prob FROM sum_rec;

drop table if exists Student cascade;
create table Student(sid text,
                     sname text,
                     major text,
                     byear int,
                     primary key(sid));

drop table if exists Enroll cascade;
create table Enroll (sid text,
                     cno text,
                     grade text);

insert into Student values 
 ('s100','Eric','CS',1988),
 ('s101','Nick','Math',1991),
 ('s102','Chris','Biology',1977),
 ('s103','Dinska','CS',1978),
 ('s104','Zanna','Math',2001),
 ('s105','Vince','CS',2001);


insert into Enroll values 
 ('s100','c200','A'),
 ('s100','c201','B'),
 ('s100','c202','A'),
 ('s101','c200','B'),
 ('s101','c201','A'),
 ('s101','c202','A'),
 ('s101','c301','C'),
 ('s101','c302','A'),
 ('s102','c200','B'),
 ('s102','c202','A'),
 ('s102','c301','B'),
 ('s102','c302','A'),
 ('s103','c201','A'),
 ('s104','c201','D');

-- Associating tuple id with each tuple in enroll table

create or replace view enroll_tid as (
	select row_number() over (order by sid,cno) as tid,* 
	from Enroll
);

-- Create views to index tuple IDs on grade and cno

create or replace view indexOnCno as (
	select cno, array_agg(tid) as tid_lst
	from enroll_tid
	group by 1
);


create or replace view indexOnGrade as (
	select grade,array_agg(tid) as tid_lst 
	from enroll_tid
group by 1
	);

-- Set intersection $A\cap B$: (Based on Assignment 5 material)
create or replace function set_intersection(A anyarray, B anyarray) 
returns anyarray as
$$
   select array(select unnest(A) intersect select unnest(B) order by 1);
$$ language sql;

-- Function to answer Q5 queries

create or replace function FindStudents(booleanOperation text, cno text, grade text)
returns table (sid text, sname text, major text, byear int) as
$$
	begin
		return query EXECUTE 'select sid, sname, major, byear from student where sid in (
			select sid from enroll_tid where tid in (
				select unnest(set_intersection(iog.tid_lst,ioc.tid_lst)) 
					from indexOnGrade iog, indexOnCno ioc
					where ioc.cno =''' || cno ||'''' || booleanOperation || ' iog.grade = ''' || grade || '''
			)
		);';
	end;
$$ language plpgsql;


\qecho 'Problem 5.a'
select * from FindStudents('and', 'c202', 'A');

\qecho 'Problem 5.b'
select * from FindStudents('or', 'c202', 'A');

\qecho 'Problem 5.c'
select * from FindStudents('and not', 'c202', 'A');


\qecho 'Problem 6'


create or replace function get_vector_cno(cno anyelement) 
returns varbit as
$$
	select array_to_string(array_agg(CASE
					when cno = $1 THEN 1
					else 0
				 end
				),'')::varbit
	from enroll;
$$ language sql;

create or replace view bitmapIndexOnCno as 
(
	select distinct cno,get_vector_cno(cno) as bit_vector from enroll
);

create or replace function get_vector_grade(grade anyelement) 
returns varbit as
$$
	select array_to_string(array_agg(CASE
					when grade = $1 THEN 1
					else 0
				 end
				),'')::varbit
	from enroll;
$$ language sql;


create or replace view bitmapIndexOnGrade as 
(
	select distinct grade,get_vector_grade(grade) as bit_vector from enroll
);

drop function if exists get_bit_positions;
create or replace function get_bit_positions(varbit) returns 
table (tid integer) as $$
	with temp as (
	select substring($1 from i for 1) as bt, row_number() over() as tid
	from generate_series(1,length($1)) as i)
	select tid from temp where bt = b'1';
$$ language sql;

CREATE OR REPLACE FUNCTION get_tid(booleanOperation text, cno text, grade text)
RETURNS table (tid integer) as $$
BEGIN
    IF $1 = 'and' THEN
        RETURN QUERY
select get_bit_positions((select bit_vector from bitmapIndexOnGrade b where b.grade = $3) & (select bit_vector from bitmapIndexOnCno b where b.cno = $2));
    ELSIF $1 = 'or' THEN 
        RETURN QUERY
        SELECT get_bit_positions((select bit_vector from bitmapIndexOnGrade b where b.grade = $3) | (select bit_vector from bitmapIndexOnCno b where b.cno = $2));
	ELSE
		RETURN QUERY
		SELECT get_bit_positions(~(select bit_vector from bitmapIndexOnGrade b where b.grade = $3) & (select bit_vector from bitmapIndexOnCno b where b.cno = $2));
    END IF;
END;
$$ language plpgsql;
								 
create or replace function FindStudents(booleanOperation text, cno text, grade text)
returns table (sid text, sname text, major text, byear int) as
$$
	select * 
	from student
	where sid in (
		select sid from enroll_tid where tid in (
			select * from get_tid($1,$2,$3)
		)
	)
	
$$ language sql;		

\qecho 'Problem 6.a'
select * from FindStudents('and', 'c202', 'A');

\qecho 'Problem 6.b'
select * from FindStudents('or', 'c202', 'A');

\qecho 'Problem 6.c'
select * from FindStudents('and not', 'c202', 'A');

-- Connect to default database
\c postgres

-- Drop database created for this assignment
DROP DATABASE team41_a6;