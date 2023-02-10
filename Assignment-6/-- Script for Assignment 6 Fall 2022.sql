-- Script for Assignment 6  Fall 2022

-- Creating database with full name

CREATE DATABASE team41_a6;


-- Connecting to database 
\c team41_a6
\qecho 'Section 2 Sorting and Select Experiments'
\qecho 'Problem 3'

create or replace function SetOfIntegers(n int, l int, u int)
returns table (x int) as
$$
select floor(random() * (u-l+1) + l)::int from generate_series(1,n);
$$ language sql;

create or replace function makeS (n integer)
returns void as
$$
begin
drop table if exists S;
create table S (x int);
insert into S select * from SetOfIntegers(n,1,n);
end;
$$ language plpgsql;

-- The function queryPlan returns the query plan for the given sqlStatement                                                                  

create or replace function queryPlan (sqlStatement text)
returns table (queryPlanRow text) as
$$
begin
 return  query execute 'explain analyze ' || sqlStatement;
end;
$$ language plpgsql;

-- The function extractExecutionTime extracts the execution time of
-- the query plan for the given sqlStatement

create or replace function extractExecutionTime(sqlStatement text)
returns       float as
$$
   select substring(q.queryPlan,'([0-9.]+)')::float
   from   (select queryPlan from queryPlan(sqlStatement)) q
   where  q.queryPlan like '%Exec%';
$$ language sql;


-- The function runExperiment runs 'n' experiment for the
-- given queryStatement and returns their average execution time

create or replace function runExperiment(n int, queryStatement text) 
returns float as
$$
    select avg((select * from extractExecutionTime(queryStatement)))
    from   generate_series(1,n);
$$ language sql;

-- The 'experiment' function creates m relation S, with |S| = 10^k for k
-- in [k_1,k_2] and runs the (scan) query `SELECT x FROM S' n times.
-- Then the function returns the average execution times of these n
-- runs.

create or replace function experiment(m int, k_1 int, k_2 int, n int, sqlstatement text)
returns table(s int, e numeric) as
$$
begin
   drop table if exists executionTimeTable;
   create table executionTimeTable (size int, executionTime    float);   
   
   for i in 1..m loop
     for k in k_1..k_2 loop
      perform makeS(floor(power(10,k))::int);
      insert into executionTimeTable values(floor(power(10,k))::int, (select runexperiment(n,sqlstatement)));
    end loop;
   end loop;
   return query select size::int, round(avg(executiontime)::numeric,3)
                from   executionTimeTable 
                group by(size) order by 1;
end;
$$ language plpgsql;

-- The 'experiment' function creates m relation S, with |S| = 10^k for k                                                                     
-- in [k_1,k_2] and runs the (scan) query `SELECT x FROM S' n times.                                                                         
-- Then the function returns the average execution times of these n                                                                          
-- runs.      

create or replace function experiment_scanning_sorting(m int, k_1 int, k_2 int, n int, sqlstatement1 text, sqlstatement2 text)
returns table(s int, t1 numeric, t2 numeric) as
$$
begin
   drop table if exists executionTimeTable;
   create table executionTimeTable (size int, time1    float,  time2    float);

   for i in 1..m loop
     for k in k_1..k_2 loop
      perform makeS(floor(power(10,k))::int);
      insert into executionTimeTable values(floor(power(10,k))::int, 
                                            (select runexperiment(n,sqlstatement1)),
                                            (select runexperiment(n,sqlstatement2)));
    end loop;
   end loop;
   return query select size::int, round(avg(time1)::numeric,3), round(avg(time2)::numeric,3) 
                from   executionTimeTable
                group by(size) order by 1;
end;
$$ language plpgsql;

-- Performing the experiment for different working sizes and also avoiding the use of parallel workers by setting parameters below

\qecho '3b'

\qecho ' --------- Working Memory = 64kB --------- '

set work_mem = '64kB';
set max_parallel_workers = 0;

select s as "size of relation S", 
       t1 as "avg execution time to scan S (in ms)",
       t2 as "avg execution time to sort S (in ms)"
from experiment_scanning_sorting(3,1,8,3,'SELECT x FROM S', 'SELECT x FROM S ORDER BY 1');

\qecho ' --------- Working Memory = 4MB --------- '

VACUUM;

set work_mem = '4MB';

select s as "size of relation S", 
       t1 as "avg execution time to scan S (in ms)",
       t2 as "avg execution time to sort S (in ms)"
from experiment_scanning_sorting(3,1,8,3,'SELECT x FROM S', 'SELECT x FROM S ORDER BY 1');

\qecho ' --------- Working Memory = 32MB --------- '

VACUUM;


set work_mem = '32MB';

select s as "size of relation S", 
       t1 as "avg execution time to scan S (in ms)",
       t2 as "avg execution time to sort S (in ms)"
from experiment_scanning_sorting(3,1,8,3,'SELECT x FROM S', 'SELECT x FROM S ORDER BY 1');

\qecho ' --------- Working Memory = 256MB --------- '

VACUUM;


set work_mem = '256MB';

select s as "size of relation S", 
       t1 as "avg execution time to scan S (in ms)",
       t2 as "avg execution time to sort S (in ms)"
from experiment_scanning_sorting(3,1,8,3,'SELECT x FROM S', 'SELECT x FROM S ORDER BY 1');


\qecho '3c'

-- Setting working memory back to default 4MB

VACUUM;


set work_mem = '4MB';

create or replace function experiment_scanning_indexSort(m int, k_1 int, k_2 int, n int)
returns table(s int, t1 numeric, t2 numeric) as
$$
begin
   drop table if exists executionTimeTable;
   create table executionTimeTable (size int, time1    float,  time2    float);

   for i in 1..m loop
     for k in k_1..k_2 loop
      perform makeS(floor(power(10,k))::int);
      

      drop table if exists indexedS;

      create table indexedS(x integer);
      create index index_on_S on indexedS using btree(x);

      insert into executionTimeTable values(floor(power(10,k))::int, 
                                            (select runexperiment(n,'insert into indexedS select x from S')),
                                            (select runexperiment(n,'select true from indexedS where x between 1 and floor(power(10,'||k||'))::int')));
    end loop;
   end loop;
   return query select size::int, round(avg(time1)::numeric,3), round(avg(time2)::numeric,3) 
                from   executionTimeTable
                group by(size) order by 1;
end;
$$ language plpgsql;


select s as "size S",
       t1 as "avg execution time to create index indexedS (in ms)",
       t2 as "avg execution time for range query (in ms) (in ms)"
from experiment_scanning_indexSort(3,1,7,3);

\qecho 'Problem 4'

\qecho '4a'

VACUUM;

select s as "size of relation S", 
       t1 as "avg execution time to scan S (in ms)",
       t2 as "avg execution time to eliminate ducplicates in S (in ms)"
from experiment_scanning_sorting(3,1,8,3,'SELECT x FROM S', 'SELECT distinct x FROM S');

\qecho '4b'

VACUUM;

select s as "size of relation S", 
       t1 as "avg execution time to scan S (in ms)",
       t2 as "avg execution time to group by in S (in ms)"
from experiment_scanning_sorting(3,1,8,3,'SELECT x FROM S', 'SELECT x FROM S group by 1');

\qecho '4c'

VACUUM;

select makeS(power(10,4)::int);

\qecho 'Query Plan for DISTINCT clause'
explain analyze select distinct x from S;

\qecho 'Query Plan for GROUP BY clause'
explain analyze select x from S group by 1;

\qecho 'Problem 10'

--Creating the skill Table
DROP TABLE IF EXISTS Skill;
CREATE TABLE IF NOT EXISTS Skill(skill text,
                   primary key (skill));

INSERT INTO Skill VALUES
   ('Programming'),
   ('AI'),
   ('Networks'),
   ('OperatingSystems'),
   ('Databases');


--Generating Binary Relations
create or replace function
BinaryRelationOverIntegers(n int, l_1 int, u_1 int, l_2 int, u_2 int)
returns table (x int, y int) as
$$
select floor(random() * (u_1-l_1+1) + l_1)::int as x,
floor(random() * (u_2-l_2+1) + l_2)::int as y
from generate_series(1,n);
$$ language sql;

--Generates a PersonSkill Table Table
create or replace function GeneratepersonSkillRelation(n int, l int, u int)
returns table (pid int, skill text) as
$$
with skillNumber(skill, index) as (select skill, row_number() over (order by skill)
from Skill),
pS as (select x, y
from BinaryRelationOverIntegers(n,l,u,1, (select count(1) from Skill)::int))
select x as pid, skill
from pS join skillNumber on y = index
group by (x, skill) order by 1,2;
$$ language sql;


-- The function queryPlan returns the query plan for the given sqlStatement

create or replace function queryPlan (sqlStatement text) 
returns table (queryPlanRow text) as
$$
begin
 return  query execute 'explain analyze ' || sqlStatement;
end;
$$ language plpgsql;

-- The function extractExecutionTime extracts the execution time of
-- the query plan for the given sqlStatement

create or replace function extractExecutionTime(sqlStatement text)
returns       float as
$$
   select substring(q.queryPlan,'([0-9.]+)')::float
   from   (select queryPlan from queryPlan(sqlStatement)) q
   where  q.queryPlan like '%Exec%';
$$ language sql;

-- The function runExperiment runs 'n' experiment for the
-- given queryStatement and returns their average execution time

create or replace function runExperiment(n int, queryStatement text) 
returns float as
$$
    select avg((select * from extractExecutionTime(queryStatement)))
    from   generate_series(1,n);
$$ language sql;

create or replace function runExperiment_index(n int, queryStatement text) 
returns float as
$$
	--drop index if exists skill_index;
	create index skill_index on S(skill);
    select avg((select * from extractExecutionTime(queryStatement)))
    from   generate_series(1,n);
$$ language sql;

-- Make S function
create or replace function makeS (n integer)
returns void as
$$
begin
drop table if exists S;
create table S (pid int,skill text);
insert into S select * from GeneratepersonSkillRelation(n,1,n);
end;
$$ language plpgsql;

-- The 'experiment' function creates m relation S, with |S| = 10^k for k                                                                     
-- in [k_1,k_2] and runs the (scan) query `SELECT x FROM S' n times.                                                                         
-- Then the function returns the average execution times of these n                                                                          
-- runs.                                                                                                                                     

create or replace function experiment(m int, k_1 int, k_2 int, n int, sqlstatement text)
returns table(s int, e numeric) as
$$
begin
   drop table if exists executionTimeTable;
   create table executionTimeTable (size int, executionTime    float);

   for i in 1..m loop
     for k in k_1..k_2 loop
      perform makeS(floor(power(10,k))::int);
      insert into executionTimeTable values(floor(power(10,k))::int, (select runexperiment(n,sqlstatement)));
    end loop;
   end loop;
   return query select size::int, round(avg(executiontime)::numeric,3)
                from   executionTimeTable
                group by(size) order by 1;
end;
$$ language plpgsql;


--two sql statements function
create or replace function experiment_scanning_sorting(m int, k_1 int, k_2 int, n int, sqlstatement1 text, sqlstatement2 text)
returns table(s int, t1 numeric, t2 numeric) as
$$
begin
   drop table if exists executionTimeTable;
   create table executionTimeTable (size int, time1    float,  time2    float);

   for i in 1..m loop
     for k in k_1..k_2 loop
      perform makeS(floor(power(10,k))::int);
      insert into executionTimeTable values(floor(power(10,k))::int, 
                                            (select runexperiment(n,sqlstatement1)),                                    
											(select runexperiment_index(n,sqlstatement2)));
    end loop;
   end loop;
   return query select size::int, round(avg(time1)::numeric,3), round(avg(time2)::numeric,3) 
                from   executionTimeTable
                group by(size) order by 1;
end;
$$ language plpgsql;



select s as "size of relation S", 
       t1 as "avg execution time to scan S",
       t2 as "avg execution time to scan indexed S"
from experiment_scanning_sorting(5,4,6,10,'SELECT * FROM S where skill = ''AI''','SELECT * FROM S where skill = ''AI''');


\qecho 'Problem 11'


-- Creating worksFor table
create or replace function worksFor(p integer, c integer, s integer)
   returns table (pid integer, cname integer, salary integer) as
$$
 select * from (
   select x as pid, floor(random() * c + 1)::int as cname, floor(random() * s 
+1)*10000 as salary
   from   generate_series(1,p) x order by random()) q;
$$ language sql;

--using MakeS Function
create or replace function makeS (n integer)
returns void as
$$
begin
drop table if exists S;
create table S (pid integer,cname integer,salary integer);
insert into S select * from worksFor(n,10,7);
end;
$$ language plpgsql;


--modifying run experiment index function

create or replace function runExperiment_index(n int, queryStatement text) 
returns float as
$$
	create index salary_index on S(salary);
    select avg((select * from extractExecutionTime(queryStatement)))
    from   generate_series(1,n);
$$ language sql;

-- getting the time values

\qecho '11.a'
-- small range salaries
select s as "size of relation S", 
       t1 as "avg execution time to scan S",
       t2 as "avg execution time to scan indexed S"
from experiment_scanning_sorting(5,5,7,10,'SELECT * FROM S where (select min(salary) from S) <= salary and salary <= (select min(salary) from S);','SELECT * FROM S where (select min(salary) from S) <= salary and salary <= (select min(salary) from S);');

\qecho '11.b'
--intermediate salary range

select s as "size of relation S", 
       t1 as "avg execution time to scan S",
       t2 as "avg execution time to scan indexed S"
from experiment_scanning_sorting(5,5,7,10,'SELECT * FROM S where (select min(salary) from S) <= salary and salary <= (select avg(salary) from S);','SELECT * FROM S where (select min(salary) from S) <= salary and salary <= (select avg(salary) from S);');

\qecho '11.c'
--maximum range

select s as "size of relation S", 
       t1 as "avg execution time to scan S",
       t2 as "avg execution time to scan indexed S"
from experiment_scanning_sorting(5,5,7,10,'SELECT * FROM S where (select min(salary) from S) <= salary and salary <= (select max(salary) from S);','SELECT * FROM S where (select min(salary) from S) <= salary and salary <= (select max(salary) from S);');

\qecho 'Problem 12'

--creating index on pid and skill
create or replace function runExperiment_index(n int, queryStatement text) 
returns float as
$$
	create index pid_skill_index on S(pid,skill);
    select avg((select * from extractExecutionTime(queryStatement)))
    from   generate_series(1,n);
$$ language sql;

-- Make S function
create or replace function makeS (n integer)
returns void as
$$
begin
drop table if exists S;
create table S (pid int,skill text);
insert into S select * from GeneratepersonSkillRelation(n,1,n);
end;
$$ language plpgsql;

--Running the time experiment

select s as "size of relation S", 
       t1 as "avg execution time to scan S",
       t2 as "avg execution time to scan indexed S"
from experiment_scanning_sorting(5,5,7,10,'SELECT * FROM S where pid = 6 and skill = ''AI''','SELECT * FROM S where pid = 6 and skill = ''AI''');

\qecho 'Problem 13'

--Creating Person table
create or replace function Person(p int, c int)
   returns table (pid int, pname int) as
$$
 select * from (
   select x as pid, floor(random() * c + 1)::int as pname
   from   generate_series(1,p) x order by random()) q;
$$ language sql;

-- Make S function for Person
create or replace function makeS (n integer)
returns void as
$$
begin
drop table if exists S;
create table S (pid int,pname int);
insert into S select * from Person(n,n);
end;
$$ language plpgsql;


-- Make S function for PersonSkill
create or replace function makeS1 (n integer)
returns void as
$$
begin
drop table if exists S1;
create table S1 (pid int,skill text);
insert into S1 select * from GeneratepersonSkillRelation(n,1,n);
end;
$$ language plpgsql;

-- Modifying the experiment function
create or replace function experiment_scanning_sorting(m int, k_1 int, k_2 int, n int, sqlstatement1 text, sqlstatement2 text)
returns table(s int, t1 numeric, t2 numeric) as
$$
begin
   drop table if exists executionTimeTable;
   create table executionTimeTable (size int, time1    float,  time2    float);

   for i in 1..m loop
     for k in k_1..k_2 loop
      perform makeS(floor(power(10,k))::int);
	  perform makeS1(floor(power(10,k))::int);
      insert into executionTimeTable values(floor(power(10,k))::int, 
                                            (select runexperiment(n,sqlstatement1)),                                    
											(select runexperiment_index(n,sqlstatement2)));
    end loop;
   end loop;
   return query select size::int, round(avg(time1)::numeric,3), round(avg(time2)::numeric,3) 
                from   executionTimeTable
                group by(size) order by 1;
end;
$$ language plpgsql;

--indexing 
create or replace function runExperiment_index(n int, queryStatement text) 
returns float as
$$
	create index pid_index on S(pid);
	create index skill_index on S1(skill);
    select avg((select * from extractExecutionTime(queryStatement)))
    from   generate_series(1,n);
$$ language sql;


--Running the experiment 
select s as "size of relation S", 
       t1 as "avg execution time to scan S",
       t2 as "avg execution time to scan indexed S"
from experiment_scanning_sorting(5,4,6,10,'SELECT * FROM S where pid not in (select pid from S1 where skill = ''AI'')','SELECT * FROM S where pid not in (select pid from S1 where skill = ''AI'')');

\qecho 'Problem 14'

--Creating a binaryrelations function where pid1 != pid2


create or replace function knows(p int, c int)
   returns table (pid1 int, pid2 int) as
$$
   with temp_view as (select floor(random() * c + 2)::int as pid
   from   generate_series(1,p) x order by random())
   SELECT DISTINCT tv1.pid as pid1,tv2.pid as pid2
   FROM temp_view tv1,temp_view tv2
   WHERE tv1.pid<>tv2.pid
   LIMIT p
$$ language sql; 


--makeS for knows1
create or replace function makeS1 (n integer)
returns void as
$$
begin
drop table if exists S1;
create table S1 (pid1 int,pid2 int);
insert into S1 select * from knows(n,n);
end;
$$ language plpgsql;

-- Modifying the experiment function
create or replace function experiment_scanning_sorting(m int, k_1 int, k_2 int, n int, sqlstatement1 text, sqlstatement2 text)
returns table(s int, t1 numeric, t2 numeric) as
$$
begin
   drop table if exists executionTimeTable;
   create table executionTimeTable (size int, time1    float,  time2    float);

   for i in 1..m loop
     for k in k_1..k_2 loop
      perform makeS1(floor(power(10,k))::int);
      insert into executionTimeTable values(floor(power(10,k))::int, 
                                            (select runexperiment(n,sqlstatement1)),                                    
											(select runexperiment_index(n,sqlstatement2)));
    end loop;
   end loop;
   return query select size::int, round(avg(time1)::numeric,3), round(avg(time2)::numeric,3) 
                from   executionTimeTable
                group by(size) order by 1;
end;
$$ language plpgsql;

--indexing 
create or replace function runExperiment_index(n int, queryStatement text) 
returns float as
$$
	create unique index S1_pid_index on S1(pid1,pid2);
    select avg((select * from extractExecutionTime(queryStatement)))
    from   generate_series(1,n);
$$ language sql;

--Running the experiment 
select s as "size of relation S", 
       t1 as "avg execution time to scan S",
       t2 as "avg execution time to scan indexed S"
from experiment_scanning_sorting(5,1,4,10, 'select distinct k1.pid1, k3.pid2
from S1 k1,S1 k2,S1 k3
where k1.pid2 = k2.pid1 and k2.pid2 = k3.pid1', 'select distinct k1.pid1, k3.pid2
from S1 k1,S1 k2,S1 k3
where k1.pid2 = k2.pid1 and k2.pid2 = k3.pid1');

-- Connect to default database
\c postgres

-- Drop database created for this assignment
DROP DATABASE team41_a6;