CREATE TABLE emp (
    eid INT PRIMARY KEY,
    ename VARCHAR(100) NOT NULL,
    cid INT,
    salary INT NOT NULL,
    city VARCHAR(100) NOT NULL,
    FOREIGN KEY (cid) REFERENCES company(cid) ON DELETE CASCADE
);

INSERT INTO emp (eid,ename, cid, salary, city) 
VALUES (1,'Alice', 1, 90000, 'City1'), 
       (2,'Bob', 2, 110000, 'Indore');

CREATE TABLE company (
    cid INT PRIMARY KEY,
    cname VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL
);
INSERT INTO company (cid,cname, city) 
VALUES (1,'A', 'City1'), 
       (2,'B', 'Indore');
CREATE TABLE works (
    eid INT,
    pid INT,
    hours INT NOT NULL,
    PRIMARY KEY (eid, pid),
    FOREIGN KEY (eid) REFERENCES emp(eid) ON DELETE CASCADE,
    FOREIGN KEY (pid) REFERENCES project(pid) ON DELETE CASCADE
);
INSERT INTO works (eid, pid, hours) 
VALUES (1, 1, 40), 
       (2, 2, 35);



CREATE TABLE project (
    pid INT PRIMARY KEY,
    pname VARCHAR(100) NOT NULL,
    cid INT,
    budget INT NOT NULL,
    FOREIGN KEY (cid) REFERENCES company(cid) ON DELETE CASCADE
);
INSERT INTO project (pid,pname, cid, budget) 
VALUES (1,'AI', 1, 1500000), 
       (2,'DBMS', 2, 1000000);

SELECT e.eid, e.ename
FROM emp e
JOIN works w ON e.eid = w.eid
JOIN project p ON w.pid = p.pid
WHERE p.budget > 1000000;


SELECT e1.ename, e1.city, e1.salary
FROM emp e1
WHERE e1.salary = (
    SELECT MAX(e2.salary)
    FROM emp e2
    WHERE e2.city = e1.city
);









