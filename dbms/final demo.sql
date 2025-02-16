CREATE TABLE Emp (
    eid INT PRIMARY KEY,
    ename VARCHAR(50),
    age INT,
    salary DECIMAL(10, 2),
    address VARCHAR(100)
);
CREATE TABLE Works (
    eid INT,
    did INT,
    pct_time DECIMAL(5, 2),
    PRIMARY KEY (eid, did),
    FOREIGN KEY (eid) REFERENCES Emp(eid),
    FOREIGN KEY (did) REFERENCES Dept(did)
);

CREATE TABLE Dept (
    did INT PRIMARY KEY,
    budget DECIMAL(10, 2),
    managerid INT,
    dname VARCHAR(50),
    dloc VARCHAR(100),
    FOREIGN KEY (managerid) REFERENCES Emp(eid)
);



CREATE PROCEDURE procedure_emp IS
BEGIN
   DELETE FROM Emp
   WHERE age > 60;
   DBMS_OUTPUT.PUT_LINE('Employees over the age of 60 have been deleted.');
END;
/

CREATE PROCEDURE cursor_emp_sixty IS
   CURSOR emp_cursor IS
      SELECT eid FROM Emp WHERE age > 60;
	   v_eid NUMBER Emp.eid;

BEGIN
   OPEN emp_cursor; 

   LOOP
      FETCH emp_cursor INTO v_eid; 

      EXIT WHEN emp_cursor%NOTFOUND;  
      DELETE FROM Emp WHERE eid = v_eid;
   END LOOP;

   CLOSE emp_cursor;
END;
/



