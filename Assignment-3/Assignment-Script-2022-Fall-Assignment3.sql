-- Script for Assignment 3

-- Creating database with full name

CREATE DATABASE aditcam_assignment3;

-- Connecting to database 
\c aditcam_assignment3;

-- Relation schemas and instances for assignment 2

CREATE TABLE Person(pid integer,
                    pname text,
                    city text,
                    primary key (pid));

CREATE TABLE Company(cname text,
                     headquarter text,
                     primary key (cname));

CREATE TABLE Skill(skill text,
                   primary key (skill));


CREATE TABLE worksFor(pid integer,
                      cname text,
                      salary integer,
                      primary key (pid),
                      foreign key (pid) references Person (pid),
                      foreign key (cname) references Company(cname));


CREATE TABLE companyLocation(cname text,
                             city text,
                             primary key (cname, city),
                             foreign key (cname) references Company (cname));


CREATE TABLE personSkill(pid integer,
                         skill text,
                         primary key (pid, skill),
                         foreign key (pid) references Person (pid) on delete cascade,
                         foreign key (skill) references Skill (skill) on delete cascade);


CREATE TABLE hasManager(eid integer,
                        mid integer,
                        primary key (eid, mid),
                        foreign key (eid) references Person (pid),
                        foreign key (mid) references Person (pid));

CREATE TABLE Knows(pid1 integer,
                   pid2 integer,
                   primary key(pid1, pid2),
                   foreign key (pid1) references Person (pid),
                   foreign key (pid2) references Person (pid));



INSERT INTO Person VALUES
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

INSERT INTO Company VALUES
     ('Apple', 'Cupertino'),
     ('Amazon', 'Seattle'),
     ('Google', 'MountainView'),
     ('Netflix', 'LosGatos'),
     ('Microsoft', 'Redmond'),
     ('IBM', 'NewYork'),
     ('ACM', 'NewYork'),
     ('Yahoo', 'Sunnyvale');


INSERT INTO worksFor VALUES
     (1001,'Apple', 65000),
     (1002,'Apple', 45000),
     (1003,'Amazon', 55000),
     (1004,'Amazon', 55000),
     (1005,'Google', 60000),
     (1006,'Amazon', 60000),
     (1007,'Netflix', 50000),
     (1008,'Amazon', 50000),
     (1009,'Apple',60000),
     (1010,'Amazon', 55000),
     (1011,'Google', 70000), 
     (1012,'Apple', 45000),
     (1013,'Yahoo', 55000),
     (1014,'Apple', 50000), 
     (1015,'Amazon', 60000),
     (1016,'Amazon', 55000),
     (1017,'Netflix', 60000),
     (1018,'Apple', 50000),
     (1019,'Microsoft', 50000);

INSERT INTO companyLocation VALUES
   ('Apple', 'Bloomington'),
   ('Amazon', 'Chicago'),
   ('Amazon', 'Denver'),
   ('Amazon', 'Columbus'),
   ('Google', 'NewYork'),
   ('Netflix', 'Indianapolis'),
   ('Netflix', 'Chicago'),
   ('Microsoft', 'Bloomington'),
   ('Apple', 'Cupertino'),
   ('Amazon', 'Seattle'),
   ('Google', 'MountainView'),
   ('Netflix', 'LosGatos'),
   ('Microsoft', 'Redmond'),
   ('IBM', 'NewYork'),
   ('Yahoo', 'Sunnyvale');

INSERT INTO Skill VALUES
   ('Programming'),
   ('AI'),
   ('Networks'),
   ('OperatingSystems'),
   ('Databases');

INSERT INTO personSkill VALUES
 (1001,'Programming'),
 (1001,'AI'),
 (1002,'Programming'),
 (1002,'AI'),
 (1004,'AI'),
 (1004,'Programming'),
 (1005,'AI'),
 (1005,'Programming'),
 (1005,'Networks'),
 (1006,'Programming'),
 (1006,'OperatingSystems'),
 (1007,'OperatingSystems'),
 (1007,'Programming'),
 (1009,'OperatingSystems'),
 (1009,'Networks'),
 (1010,'Networks'),
 (1011,'Networks'),
 (1011,'OperatingSystems'),
 (1011,'AI'),
 (1011,'Programming'),
 (1012,'AI'),
 (1012,'OperatingSystems'),
 (1012,'Programming'),
 (1013,'Programming'),
 (1013,'OperatingSystems'),
 (1013,'Networks'),
 (1014,'OperatingSystems'),
 (1014,'AI'),
 (1014,'Networks'),
 (1015,'Programming'),
 (1015,'AI'),
 (1016,'OperatingSystems'),
 (1016,'AI'),
 (1017,'Networks'),
 (1017,'Programming'),
 (1018,'AI'),
 (1019,'Networks');

INSERT INTO hasManager VALUES
 (1004, 1003),
 (1006, 1003),
 (1015, 1003),
 (1016, 1004),
 (1016, 1006),
 (1008, 1015),
 (1010, 1008),
 (1013, 1007),
 (1017, 1013),
 (1002, 1001),
 (1009, 1001),
 (1014, 1012),
 (1011, 1005);


INSERT INTO Knows VALUES
 (1011,1009),
 (1007,1016),
 (1011,1010),
 (1003,1004),
 (1006,1004),
 (1002,1014),
 (1009,1005),
 (1018,1009),
 (1007,1017),
 (1017,1019),
 (1019,1013),
 (1016,1015),
 (1001,1012),
 (1015,1011),
 (1019,1006),
 (1013,1002),
 (1018,1004),
 (1013,1007),
 (1014,1006),
 (1004,1014),
 (1001,1014),
 (1010,1013),
 (1010,1014),
 (1004,1019),
 (1018,1007),
 (1014,1005),
 (1015,1018),
 (1014,1017),
 (1013,1018),
 (1007,1008),
 (1005,1015),
 (1017,1014),
 (1015,1002),
 (1018,1013),
 (1018,1010),
 (1001,1008),
 (1012,1011),
 (1002,1015),
 (1007,1013),
 (1008,1007),
 (1004,1002),
 (1015,1005),
 (1009,1013),
 (1004,1012),
 (1002,1011),
 (1004,1013),
 (1008,1001),
 (1008,1019),
 (1019,1008),
 (1001,1019),
 (1019,1001),
 (1004,1003),
 (1006,1003),
 (1015,1003),
 (1016,1004),
 (1016,1006),
 (1008,1015),
 (1010,1008),
 (1017,1013),
 (1002,1001),
 (1009,1001),
 (1011,1005),
 (1014,1012);


\qecho 'Problem 1'

\qecho 'Problem 1.a'

-- Write an RA expression in standard notation that expresses this
-- if-then-else query

create table if not EXISTS E1 (x integer);
create table if not EXISTS E2 (x integer);
create table if not EXISTS F (c text);

select *
from (
	select e1.* 
	from E1 e1
	except
	select E1.*
	from F cross join E1
) q
union 
select *
from (
	select  distinct e2.* 
	from E2 e2 cross join F
) q;

create or replace view q1 as (
	select *
from (
	select e1.* 
	from E1 e1
	except
	select E1.*
	from F cross join E1
) q
union 
select *
from (
	select  distinct e2.* 
	from E2 e2 cross join F
) q
);

\qecho 'Problem 1.b'

-- Test you solution for the following E1, E2, and F

create table if not EXISTS E1 (x integer);
create table if not EXISTS E2 (x integer);
create table if not EXISTS F (c text);


insert into E1 values (1), (2);
insert into E2 values (3), (4);
-- Note F is the empty set

select * from q1;


\qecho 'Problem 1.c'

-- Test you solution for the following E1, E2, and F

insert into F values ('a'), ('b'), ('c');

-- Note that F is not an empty set.

select * from q1;
drop view q1;
drop table F;

\qecho 'Problem 2'

-- Consider the following boolean SQL query:

create table F(x integer, y integer);

select true = all (select p1 = p2
                   from   F p1, F p2
                   where  p1.x = p2.x)  "isaFunction";

\qecho 'Problem 2.a'

-- Using the insights you gained from Problem 1, write an RA SQL query
-- that expresses the above boolean SQL query.

select distinct * from ((select true) union (select p1 = p2
			  from F p1 cross join F p2 where p1.x = p2.x)) "isaFunction"

create or replace view q2 as (select distinct * from ((select true) union (select p1 = p2
			  from F p1 cross join F p2 where p1.x = p2.x)) "isaFunction");

select * from F;
\qecho 'Problem 2.b'

-- Test your query for F = {}

select * from q2;

\qecho 'Problem 2.c'

-- Test your query for F = {(1,10),(2,20)}

insert into F values (1,10), (2,20);

select * from q2;

\qecho 'Problem 2.d'

-- Test your query for F = {(1,10),(1,20),(2,20)}

insert into F values (1,20);

select * from q2;


\qecho 'Problem 6'

/*
Consider the query “Find the pid and pname of each persons who knows
no-one who works for the Apple company.” 

A possible way to write this
query in Pure SQL is
*/

select p.pid, p.pname
from   Person p
where  false = all (select exists (select 1
                                   from   worksFor w
                                   where  p1.pid = w.pid and w.cname = 'Apple') and
                           (p.pid,p1.pid) = some (select k.pid1, k.pid2
                                                  from   Knows k)                                            
                    from   Person p1);

\qecho 'Problem 6a.'

-- Using the Pure SQL to RA SQL translation algorithm, translate this
-- Pure SQL query to an equivalent RA SQL query.  Show the translation
-- steps you used to obtain your solution.

	

\qecho 'Problem 6b.'

-- Using Approach 2, optimize this RA SQL query and provide the optimized
-- expression in RA SQL.  Specify at least three conceptually different
-- rewrite rules that you used during the optimization.






\qecho 'Problem 7a.'

/*
Find each pair $(c,p)$ where $c$ is the cname of a company and $p$ is
the pid of a person who works for that company and who earns strictly
more than all other persons who work for that company and who earns
more than 60000


A possible way to write this
query in Pure SQL is*/

select c.cname, p.pid
from   Company c, Person p
where  p.pid in (select w.pid
                 from   worksFor w
                 where  w.cname = c.cname and
                        true = all (select w1.salary <= 60000
                                    from   worksFor w1
                                    where  p.pid != w1.pid and 
                                           w1.cname = c.cname and
                                           w.salary <= w1.salary));

-- Using the Pure SQL to RA SQL translation algorithm, translate this
-- Pure SQL query to an equivalent RA SQL query.  Show the translation
-- steps you used to obtain your solution.


\qecho 'Problem 7b.'


-- Using Approach 2, optimize this RA SQL query and provide the optimized
-- expression in RA SQL.  Specify at least three conceptually different
-- rewrite rules that you used during the optimization.



\qecho 'Problem 8a.'

/*Find the pid of each person who has all-but-one job skill

A possible way to write this
query in Pure SQL is*/

select p.pid
from   person p
where  exists (select 1
               from   skill s
               where  not (p.pid, s.skill) in (select ps.pid, ps.skill
                                               from   personSkill ps)) and
       true = all (select s1.skill = s2.skill
                   from   skill s1, skill s2
                   where  (p.pid, s1.skill) not in (select ps.pid, ps.skill 
                                                    from   personSkill ps) and
                          (p.pid, s2.skill) not in (select ps.pid, ps.skill 
                                                    from   personSkill ps));
		    
-- Using the Pure SQL to RA SQL translation algorithm, translate this
-- Pure SQL query to an equivalent RA SQL query.  Show the translation
-- steps you used to obtain your solution.



\qecho 'Problem 8b.'

-- Using Approach 2, optimize this RA SQL query and provide the optimized
-- expression in RA SQL.  Specify at least three conceptually different
-- rewrite rules that you used during the optimization.



\qecho 'Problem 9a.'

/*
Consider the query ``\emph{Find the cname of each company that (1) is
not located in Chicago, (2) employs at least one person and (3) whose
workers who make strictly less 60000 neither have the programming
skill nor the AI skill

A possible way to write this
query in Pure SQL is*/

select c.cname
from   company c
where  c.cname in (select w.cname
                   from   worksfor w 
                   where  not exists (select 1
                                      from   companyLocation cl 
                                      where  w.cname = cl.cname and 
                                             cl.city = 'Chicago')) and
       true = all (select p.pid not in (select ps.pid
                                         from   personSkill ps
                                         where  ps.skill = 'Programming' or
                                                ps.skill = 'AI')
                   from   Person p
                   where  p.pid in (select w.pid
                                     from   worksFor w
                                     where  w.cname = c.cname and
                                            w.salary < 60000));

-- Using the Pure SQL to RA SQL translation algorithm, translate this
-- Pure SQL query to an equivalent RA SQL query.  Show the translation
-- steps you used to obtain your solution.


\qecho 'Problem 9b.'
	       
-- Using Approach 2, optimize this RA SQL query and provide the optimized
-- expression in RA SQL.  Specify at least three conceptually different
-- rewrite rules that you used during the optimization.

	 

\qecho 'Problem 10a'

-- Consider the following Pure SQL query.

select p.pid, exists (select 1
                      from   hasManager hm1, hasManager hm2
                      where  hm1.mid = p.pid and hm2.mid = p.pid and
                             hm1.eid <> hm2.eid)
from   Person p;

-- This query returns a pair (p,t) if p is the pid of a person who
-- manages at least two persons and returns the pair (p,f) other- wise.11

-- Using the Pure SQL to RA SQL translation algorithm, translate this
-- Pure SQL query to an equivalent RA SQL query.  Show the translation
-- steps you used to obtain your solution.

\qecho 'Problem 10b'

-- Using Approach 2, optimize this RA SQL query and provide the optimized
-- expression in RA SQL.  Specify at least three conceptually different
-- rewrite rules that you used during the optimization.



\qecho 'Problem 11'

/*
Find each pair (c, a, l, u) where ‘c’ is the cname of a company that
pays each of its employees a salary between 50000 and 60000, ‘a′ is
the average salary of the employees who work for company ‘c’, ‘l’ is
the number of employees who earn a salary strictly below this average,
and ‘u’ is the number of employees who earn at least this average.
*/

CREATE OR REPLACE FUNCTION temp_func(pid integer)
  RETURNS TABLE (skills text) AS
  $func$
	select skill
	from personskill
	where pid = $1
$func$ LANGUAGE sql;



CREATE OR REPLACE FUNCTION q11_count_below_sal(avg_sal FLOAT,cname text)
  RETURNS TABLE (l INTEGER) AS
  $func$
  select count(*)
  from worksfor
  where cname = $2 and salary<$1
$func$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION q11_count_above_sal(avg_sal FLOAT,cname text)
  RETURNS TABLE (u INTEGER) AS
  $func$
  select count(*)
  from worksfor
  where cname = $2 and salary>=$1
$func$ LANGUAGE sql;

drop view if exists q11_cname_avg_sal;
create or replace view  q11_cname_avg_sal as (
select cname c, avg(salary) a
from worksfor
group by cname
having min(salary) >=50000 and max(salary) <= 60000);

select cas.*,
q11_count_below_sal(CAST(cas.a as FLOAT),CAST(cas.c as text)) l,
q11_count_above_sal(CAST(cas.a as FLOAT),CAST(cas.c as text)) u
from q11_cname_avg_sal cas
order by 1 ;
		   
\qecho 'Problem 12'

/*
Find each skill that is the skill of at least 3 persons who each know
at least 2 persons who work for Apple and whose salary is at most 50000.
*/

drop view if exists q12_apple_gt_50k;
create or replace view  q12_apple_gt_50k as 
(
	select pid
	from worksfor
	where cname='Apple' and salary <= 50000
);

drop view if exists q12_know_2_apple;
create or replace view  q12_know_2_apple as 
(
	select * from (select pid1
	from knows k
	join q12_apple_gt_50k t
	on k.pid2 = t.pid) q
	group by 1
	having count(*) > 1 

);

select distinct skill
from personskill ps
inner join q12_know_2_apple t
on t.pid1 = ps.pid
group by 1
having count(*) > 2;

\qecho 'Problem 13'


/*
Find the pid and name of each person p who has at least 3 job skills
in combined set of job skills of the persons who are managed by p.
*/

drop view if exists q13_mgr_emp_skills;
create or replace view  q13_mgr_emp_skills as (
select hm.mid,array_agg(distinct ps.skill) skill_lst
from hasmanager hm
inner join personskill ps
on hm.eid = ps.pid
group by 1);

drop view if exists q13_mgr_skills;
create or replace view  q13_mgr_skills as (
select hm.mid,array_agg(distinct ps.skill) skill_lst
from hasmanager hm
inner join personskill ps
on hm.mid = ps.pid
group by 1);

select t1.mid as pid, p.pname
from q13_mgr_skills t1 inner join q13_mgr_emp_skills t2
on t1.mid = t2.mid
inner join person p
on p.pid = t1.mid
where (select count(*) from (select unnest(t1.skill_lst) intersect select unnest(t2.skill_lst)) q) >= 3;



\qecho 'Problem 14'

/*
Find the cname of each company that employs at least 4 persons and
that pays the highest average salary among such companies.
*/

with t as(
select cname,avg(salary) as avgsal
from worksfor
group by cname
having count(pid) > 3)
select cname
from t
where t.avgsal = (select max(t1.avgsal) as avgsal from t t1);

				 
\qecho 'Problem 15'

/*
Without using subquery expressions, find each pid of a person who
knows each person who earns the highest salary at company Amazon.
*/

drop view if exists q15_highearners_amz;
create or replace view  q15_highearners_amz as (
select pid 
from worksfor
where cname='Amazon'
except
select distinct wf1.pid
from worksfor wf1 join worksfor wf2
on wf1.pid <> wf2.pid and wf1.salary < wf2.salary and wf2.cname = 'Amazon' and wf1.cname = 'Amazon'
where wf2.cname = 'Amazon' and wf1.cname = 'Amazon');

select pid1
from knows k
join q15_highearners_amz ha
on k.pid2 = ha.pid
group by 1 
having count(pid1) = (select count(ha1.pid) from q15_highearners_amz ha1);


\qecho 'Problem 16'

/*Without using subquery expressions, find each pairs (p1,p2) of pids of
different persons such that if s is a job skill of p1 then s is not a 
job skill of person p2."*/

drop view if exists q16_pid_skill_lst;
create or replace view  q16_pid_skill_lst as (
select pid, array_agg(skill order by 1) as skill_lst
from personskill
group by 1
);

drop view if exists q16_pid_noskill_lst;
create or replace view  q16_pid_noskill_lst as (
select p.pid from person p except select ps.pid from personskill ps);

select * from q16_pid_noskill_lst;

select t1.pid,t2.pid
from q16_pid_skill_lst t1 
cross join q16_pid_skill_lst t2
where (select count(*) from (select unnest(t1.skill_lst) intersect select unnest(t2.skill_lst)) q) = 0
union
select t1.pid,t2.pid
from (select p.pid from q16_pid_noskill_lst p) t1
cross join (select distinct ps.pid from personskill ps) t2
union
select t1.pid,t2.pid
from (select distinct ps.pid from personskill ps) t1
cross join (select p.pid from q16_pid_noskill_lst p) t2
union
select t1.pid,t2.pid 
from q16_pid_noskill_lst t1 
cross join q16_pid_noskill_lst t2
where t1.pid<>t2.pid
order by 1,2;


\qecho 'Problem 17'

/* Find each pairs (p1,p2) of different pids of persons p1 and p2
and such that (1) the number of skills of person s1 is strictly less
than the number of skills of person s2 and (2) such that the gap
between these numbers is the largest among all such possible gaps.
 */
drop view if exists q17_pid_skill_diff;
drop view if exists q17_pid_skill_count;
create or replace view  q17_pid_skill_count as (
with tt as (select pid, array_agg(skill order by 1) as skill_lst
from personskill
group by 1)
	select pid, cardinality(tt.skill_lst) as skill_count from tt
UNION
	select pid, 0 as skill_count from q16_pid_noskill_lst
);


create or replace view  q17_pid_skill_diff as (
(select t1.pid as p1 ,t2.pid as p2, (t2.skill_count-t1.skill_count) as skill_diff
from q17_pid_skill_count t1
cross join q17_pid_skill_count t2
where t1.skill_count < t2.skill_count));

select p1,p2
from q17_pid_skill_diff t 
inner join (select max(skill_diff) as skill_diff from q17_pid_skill_diff) q
on t.skill_diff = q.skill_diff
order by 1;

\qecho 'Problem 18'

CREATE OR REPLACE FUNCTION salary_type(salary integer)
  RETURNS TABLE (type text) AS
$func$
SELECT 
CASE
WHEN salary < 50000 THEN 'low'
WHEN salary BETWEEN 50001 AND 60000 THEN 'meduim'
ELSE 'high'
END IF;
$func$ LANGUAGE sql;

drop view if exists q18_sal_type;
create or replace view  q18_sal_type as (
select cname, salary_type(salary) as type, count(*) as ctEmployees
from worksfor
group by 1,2
);

SELECT * from q18_sal_type;
CREATE TABLE IF NOT EXISTS temp(type text,
                     ctEmployees INTEGER);
					 
INSERT INTO temp VALUES ('high',0),('meduim',0),('low',0);

select cname,type, ctEmployees
from q18_sal_type
union
select q.*,0
from (select c.cname, temp.type
from company c cross join temp
except
select cname,type
from q18_sal_type) q;
-- Connect to default database
\c postgres

-- Drop database created for this assignment
DROP DATABASE aditcam_assignment3;
