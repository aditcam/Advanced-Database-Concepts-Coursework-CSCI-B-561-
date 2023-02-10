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


\qecho 'Section 3 Indexes and Indexing'
\qecho 'Problem 5'

drop  table if exists Student cascade;
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

\qecho 'Problem 5.c'
select * from FindStudents('and not', 'c202', 'A');

-- Connect to default database
\c postgres

-- Drop database created for this assignment
DROP DATABASE team41_a6;
