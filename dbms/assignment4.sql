create table emp(
	eid int primary key,
	ename varchar(255),
	cid int ,
	salary int ,
	city varchar(255),
	 foreign key (cid) references company(cid) 
	on delete set null
)

create table company(
	cid int primary key,
	cname varchar(255),
	city varchar(255)
)

create table works(
	eid int ,
	pid int,
	hrs int,
	foreign key (eid) references emp(eid),
	foreign key (pid) references project(pid)
)

create table project (
	pid int primary key,
	pname varchar(255),
	cid int ,
	budget int,
	foreign key (cid) references company(cid)
)

select * from emp
where emp.salary > (select budget from project where pname = 'Tablet');


select * from emp e
left join works w
on w.eid = e.eid
where w.hrs > (select avg(hrs) from works group by pid having pid=2);


SELECT c.cname, SUM(p.budget) AS total_budget 
FROM company c 
JOIN project p ON c.cid = p.cid 
GROUP BY c.cname;


select ename from emp e
join works w
on w.eid = e.eid
where w.pid in (select pid from project where budget = (select max(budget) from project));


select max(salary) , e.cid from emp e 
left join company c
	on c.cid = e.cid
	group by e.cid;

select ename from emp e
left join works w
on w.eid = e.eid
join company c1 on c1.cid = e.cid
	group by e.eid
having count(pid) > (select avg(pcount) from (select count(pid) as pcount
	from project p
	join company c2 on c2.cid = p.cid
	where c1.cid = c2.cid)
	)


select * from emp e , works w
where w.eid not in (select w.eid from works
	join project on project.pid = works.pid
	where project.cid = e.cid
	)

SELECT c.cname 
FROM company c 
JOIN emp e ON c.cid = e.cid 
JOIN works w ON e.eid = w.eid 
GROUP BY c.cid 
HAVING COUNT(DISTINCT w.pid) > 3
ORDER BY COUNT(DISTINCT w.pid) DESC 
LIMIT 1;




INSERT INTO company (cid, cname, city) VALUES 
(1, 'ABC', 'Mumbai'), 
(2, 'XYZ', 'Delhi'), 
(3, 'DEF', 'Bangalore');

INSERT INTO project (pid, pname, cid, budget) VALUES 
(1, 'Tablet', 1, 50000), 
(2, 'Laptop', 2, 150000), 
(3, 'Mobile', 3, 250000);

INSERT INTO emp VALUES 
(1, 'John', 1, 40000, 'Mumbai'), 
(2, 'Alice', 2, 60000, 'Delhi'), 
(3, 'Bob', 1, 45000, 'Mumbai'), 
(4, 'Charlie', 3, 70000, 'Bangalore'), 
(5, 'David', 2, 30000, 'Delhi');

INSERT INTO works (eid, pid, hrs) VALUES 
(1, 1, 120), 
(2, 2, 100), 
(3, 1, 50), 
(4, 3, 200), 
(5, 2, 150);
