create table employee(
emp_id int primary key,
first_name varchar(15),
last_name varchar(20),
birth_date date,
sex varchar(1),
salary int,
super_id int,
branch_id int
);
create table brach(
branch_id int primary key,
branch_name varchar(15),
mgr_id int,
mgr_start_date date,
 FOREIGN key(mgr_id) references  employee(emp_id) ON DELETE SET NULL
);
create table clientt(
client_id int primary key,
client_name varchar(30),
branch_id int,
 FOREIGN key(branch_id) references  brach(branch_id) ON DELETE SET NULL
);
ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES brach(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;
create table work_with(
  emp_id INT,
  client_id INT,
  total_sales INT,
  PRIMARY KEY(emp_id, client_id),
  FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ,
  FOREIGN KEY(client_id) REFERENCES clientt(client_id) 
);
create table brachsupplier(
branch_id int ,
supplier_name varchar(25),
supply_type varchar(30),
 PRIMARY KEY(branch_id, supplier_name),
foreign key(branch_id) references brach(branch_id)
);
insert into employee values(100,'David','Wallace','1967-11-17','M',250000,null,null);
INSERT INTO brach VALUES(1, 'Corporate', 100, '2006-02-09');

UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

INSERT INTO brach VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO brach VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

INSERT INTO brachsupplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO brachsupplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO brachsupplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO brachsupplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO brachsupplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO brachsupplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO brachsupplier VALUES(3, 'Stamford Lables', 'Custom Forms');

INSERT INTO clientt VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO clientt VALUES(401, 'Lackawana Country', 2);
INSERT INTO clientt VALUES(402, 'FedEx', 3);
INSERT INTO clientt VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO clientt VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO clientt VALUES(405, 'Times Newspaper', 3);
INSERT INTO clientt VALUES(406, 'FedEx', 2);

INSERT INTO work_with VALUES(105, 400, 55000);
INSERT INTO work_with VALUES(102, 401, 267000);
INSERT INTO work_with VALUES(108, 402, 22500);
INSERT INTO work_with VALUES(107, 403, 5000);
INSERT INTO work_with VALUES(108, 403, 12000);
INSERT INTO work_with VALUES(105, 404, 33000);
INSERT INTO work_with VALUES(107, 405, 26000);
INSERT INTO work_with VALUES(102, 406, 15000);
INSERT INTO work_with VALUES(105, 406, 130000);

SELECT *
FROM employee
ORDER BY salary DESC;
SELECT *
FROM employee
LIMIT 5;
SELECT first_name AS forename, last_name AS surname
FROM employee;
SELECT COUNT(super_id)
FROM employee;
SELECT *
FROM employee;

SELECT COUNT(emp_id)
FROM employee
WHERE sex = 'F' AND birth_date > '1970-01-01';
SELECT employee.emp_id, employee.first_name, brach.branch_name
FROM employee
JOIN brach
ON employee.emp_id = brach.mgr_id;
SELECT first_name,last_name,
    (select branch_name from brach
        where emp_id=mgr_id) as branch_name from employee;
SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee.emp_id IN (
	SELECT works_with.emp_id
	FROM works_with
	WHERE works_with.total_sales > 30000
);


SELECT clientt.client_id
FROM clientt
WHERE clientt.branch_id = (
	SELECT brach.branch_id
	FROM brach
	WHERE brach.mgr_id = 102
);