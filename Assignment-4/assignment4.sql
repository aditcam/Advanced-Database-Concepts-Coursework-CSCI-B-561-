--Script for Assignment 4

--Creating database

CREATE DATABASE team41;

--Connecting to database
\c team41

-- Creating relation schemas 

-- drop TABLE Person CASCADE;
-- drop table Company CASCADE;
-- drop table worksFor CASCADE;
-- drop table Knows CASCADE;


DROP TABLE IF EXISTS Company;
DROP TABLE IF EXISTS worksFor;
DROP TABLE IF EXISTS Knows;
DROP TABLE IF EXISTS Person;

CREATE TABLE Person(pid INTEGER, name TEXT);
CREATE TABLE Company(cname TEXT,city TEXT);
CREATE TABLE worksFor(pid INTEGER, cname TEXT);
CREATE TABLE Knows(pid1 INTEGER, pid2 INTEGER);

DROP TABLE IF EXISTS Company_test;
DROP TABLE IF EXISTS worksFor_test;
DROP TABLE IF EXISTS Knows_test;
DROP TABLE IF EXISTS Person_test;

CREATE TABLE Person_test(pid INTEGER, name TEXT,primary key(pid));
CREATE TABLE Company_test(cname TEXT,city TEXT,primary key (cname,city));
CREATE TABLE worksFor_test(pid INTEGER, cname TEXT,primary key(pid));
ALTER TABLE worksfor_test ADD FOREIGN KEY(pid) REFERENCES Person_test(pid) on delete cascade;
CREATE TABLE Knows_test(pid1 INTEGER, pid2 INTEGER, primary key(pid1,pid2));
ALTER TABLE knows_test ADD FOREIGN KEY(pid1) REFERENCES Person_test(pid) on delete cascade;
ALTER TABLE knows_test ADD FOREIGN KEY(pid2) REFERENCES Person_test(pid) on delete cascade;

INSERT INTO person_test values (1,'Bhavik'),(2,'Prajwal'),(3,'Aditya'),(4,'Srikar');
INSERT INTO Company_test values ('Uber','Austin'),('Google','Seattle'),('Amazon','Chicago'),('Nike','Portland'),('Facebook','New York');
INSERT INTO worksFor_test values (1,'Google'),(2,'Nike'),(3,'Amazon'),(4,'Nike');
INSERT INTO knows_test values (1,2),(1,3),(1,4),(2,3),(2,4);


select * from person_test;
select * from company_test;
select * from worksFor_test;
select * from knows_test;

-- testing primary key constraint for the relation person

insert into person_test values (1,'Ann');

-- testing foreign key constraint for relation knows

insert into knows_test values(1,5);

-- testing cascade delete foreign key constraint
select * from person_test;
delete from person_test where pid = 1;
select * from knows_test; 

\qecho 'Problem 1'		

----------- PRIMARY KEY CONSTRAINT FOR RELATION PERSON INSERT -----------

-- Trigger Funciton for primary key constraint for the relation Person

create or replace function person_constraint_check()
returns trigger as 
$$
begin
	if new.pid in (select pid from person) THEN
		raise exception 'pid already exists';
	end if;
	return new;
end;
$$ language 'plpgsql';

-- Trigger definition to validate the constraint using the trigger function declared 
--above before inserting the values into the Person relation

create trigger insert_values_person
before insert
on person 
for each row
execute procedure person_constraint_check();

----------- PRIMARY KEY AND FOREIGN KEY CONSTRAINT FOR RELATION KNOWS INSERT -----------

-- Trigger Funciton for primary key constraint for the relation Person

create or replace function knows_constraint_check()
returns trigger as 
$$
begin
	if new.pid1 in (select pid from person) AND new.pid2 in (select pid from person) 
	THEN
		if not exists (select k.pid1,k.pid2 from knows k where (new.pid1,new.pid2) in (select pid1,pid2 from knows)) 
		then
			return new;
		ELSE
			raise exception 'primary key constraint violated pid1,pid2 already exists in the knows table';
		end if;
	else 
		raise exception 'foreign key constraint violated pid not present in person table';
	end if;
	return null;
end;
$$ language 'plpgsql';

-- Trigger definition to validate the constraint using the trigger function declared 
-- above before inserting the values into the Person relation

create trigger insert_values_knows
before insert
on knows
for each row
execute procedure knows_constraint_check();

----------- PRIMARY KEY AND FOREIGN KEY CONSTRAINT FOR RELATION person DELETE -----------

-- writing trigger to delete values on Person with cascading delete semantics

create or replace function person_delete() 
returns trigger as
$$
begin 
	DELETE FROM knows where pid1 = OLD.pid or pid2= OLD.pid;
	return old;
end;
$$ language 'plpgsql';

create trigger delete_values_person
before DELETE 
on person
for each row
execute procedure person_delete(); 

-- TESTING THE QUERIES 

-- Populating the tables 

INSERT INTO person values (1,'Bhavik'),(2,'Prajwal'),(3,'Aditya'),(4,'Srikar');
INSERT INTO Company values ('Uber','Austin'),('Google','Seattle'),('Amazon','Chicago'),('Nike','Portland'),('Facebook','New York');
INSERT INTO worksFor values (1,'Google'),(2,'Nike'),(3,'Amazon'),(4,'Nike');
INSERT INTO knows values (1,2),(1,3),(1,4),(2,3),(2,4);

-- testing primary key constraint for the relation person

delete from person where name = 'Ann';
insert into person values (1,'Ann');

-- testing foreign key constraint for relation knows

insert into knows values(1,5);
insert into knows values(1,2);

-- testing cascade delete foreign key constraint
select * from person;
delete from person where pid = 1;
select * from knows; 

\qecho 'Problem 2'	

----------- PRIMARY KEY AND FOREIGN KEY CONSTRAINT FOR RELATION WORKSFOR INSERT -----------

-- Trigger Funciton for primary key constraint for the relation Worksfor

create or replace function worksfor_constraint_check()
returns trigger as 
$$
begin
	if new.cname not in (select distinct cname from company) 
	THEN 
		raise exception 'foreign key constraint violated company not present in company table';
	end if;
	return new;
end;
$$ language 'plpgsql';

-- Trigger definition to validate the constraint using the trigger function declared 
-- above before inserting the values into the Person relation

create trigger insert_values_worksfor
before insert
on worksfor
for each row
execute procedure worksfor_constraint_check();

----------- PRIMARY KEY AND FOREIGN KEY CONSTRAINT FOR RELATION COMPANY DELETE -----------

-- writing trigger to delete values on Company with cascading delete semantics

create or replace function company_delete() 
returns trigger as
$$
begin 
	DELETE FROM worksfor where cname = OLD.cname;
	return old;
end;
$$ language 'plpgsql';

create trigger delete_values_company
before DELETE 
on company
for each row
execute procedure company_delete(); 

-- testing enforcement of the foreign key constraint on insert into the relation worksFor

insert into worksfor values (1,'Oracle');


-- testing foreign key cascade delete constraint for relation 

select * from company;
delete from company where cname = 'Google';
select * from worksfor;



\qecho 'Problem 3'
