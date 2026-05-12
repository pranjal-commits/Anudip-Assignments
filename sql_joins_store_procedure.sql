mysql> use company;
Database changed
mysql> desc department;
+-----------+-------------+------+-----+---------+-------+
| Field     | Type        | Null | Key | Default | Extra |
+-----------+-------------+------+-----+---------+-------+
| dept_id   | varchar(10) | NO   | PRI | NULL    |       |
| dept_name | varchar(30) | NO   |     | NULL    |       |
+-----------+-------------+------+-----+---------+-------+
2 rows in set (0.00 sec)

mysql> insert into department values('101','hr'),('102','IT');
Query OK, 2 rows affected (0.01 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> insert into department values('103','marketing'),('104','finance');
Query OK, 2 rows affected (0.01 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> select * from department;
+---------+-----------+
| dept_id | dept_name |
+---------+-----------+
| 101     | hr        |
| 102     | IT        |
| 103     | marketing |
| 104     | finance   |
+---------+-----------+
4 rows in set (0.00 sec)

mysql> create table employee(emp_id int primary key not null, emp_name varchar(30) not null, dept_id int ,foreign key references department (dept_id));
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'references department (dept_id))' at line 1
mysql> create table employee(emp_id int primary key not null, emp_name varchar(30) not null, dept_id int ,foreign key (dept_id) references department (dept_id));
ERROR 3780 (HY000): Referencing column 'dept_id' and referenced column 'dept_id' in foreign key constraint 'employee_ibfk_1' are incompatible.
mysql> create table employee(emp_id int primary key not null, emp_name varchar(30) not null, dept_id varchar(10) ,foreign key (dept_id) references department (dept_id));
Query OK, 0 rows affected (0.07 sec)

mysql> desc employee;
+----------+-------------+------+-----+---------+-------+
| Field    | Type        | Null | Key | Default | Extra |
+----------+-------------+------+-----+---------+-------+
| emp_id   | int         | NO   | PRI | NULL    |       |
| emp_name | varchar(30) | NO   |     | NULL    |       |
| dept_id  | varchar(10) | YES  | MUL | NULL    |       |
+----------+-------------+------+-----+---------+-------+
3 rows in set (0.00 sec)

mysql> insert into employee values(1, 'ram', '101'),(2, 'mahendra', '102');
Query OK, 2 rows affected (0.01 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> insert into employee values(3, 'archita', '103'),(4, 'aaditya', '104');
Query OK, 2 rows affected (0.01 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> select * from employee;
+--------+----------+---------+
| emp_id | emp_name | dept_id |
+--------+----------+---------+
|      1 | ram      | 101     |
|      2 | mahendra | 102     |
|      3 | archita  | 103     |
|      4 | aaditya  | 104     |
+--------+----------+---------+
4 rows in set (0.00 sec)

mysql> select emp_name, dept_name from employee inner join department on employee.dept_id;
+----------+-----------+
| emp_name | dept_name |
+----------+-----------+
| aaditya  | hr        |
| archita  | hr        |
| mahendra | hr        |
| ram      | hr        |
| aaditya  | IT        |
| archita  | IT        |
| mahendra | IT        |
| ram      | IT        |
| aaditya  | marketing |
| archita  | marketing |
| mahendra | marketing |
| ram      | marketing |
| aaditya  | finance   |
| archita  | finance   |
| mahendra | finance   |
| ram      | finance   |
+----------+-----------+
16 rows in set (0.01 sec)

mysql> select emp_name, dept_name from employee inner join department on employee.dept_id=department.dept.id;
ERROR 1054 (42S22): Unknown column 'department.dept.id' in 'on clause'
mysql> select emp_name, dept_name from employee inner join department on employee.dept_id=department.dept_id;
+----------+-----------+
| emp_name | dept_name |
+----------+-----------+
| ram      | hr        |
| mahendra | IT        |
| archita  | marketing |
| aaditya  | finance   |
+----------+-----------+
4 rows in set (0.00 sec)

mysql> select emp_name, dept_name from employee left join department on employee.dept_id=department.dept_id;
+----------+-----------+
| emp_name | dept_name |
+----------+-----------+
| ram      | hr        |
| mahendra | IT        |
| archita  | marketing |
| aaditya  | finance   |
+----------+-----------+
4 rows in set (0.00 sec)

mysql> select emp_name, dept_name from employee right join department on employee.dept_id=department.dept_id;
+----------+-----------+
| emp_name | dept_name |
+----------+-----------+
| ram      | hr        |
| mahendra | IT        |
| archita  | marketing |
| aaditya  | finance   |
+----------+-----------+
4 rows in set (0.00 sec)

mysql> select emp_name, dept_name from employee full join department;
+----------+-----------+
| emp_name | dept_name |
+----------+-----------+
| aaditya  | hr        |
| archita  | hr        |
| mahendra | hr        |
| ram      | hr        |
| aaditya  | IT        |
| archita  | IT        |
| mahendra | IT        |
| ram      | IT        |
| aaditya  | marketing |
| archita  | marketing |
| mahendra | marketing |
| ram      | marketing |
| aaditya  | finance   |
| archita  | finance   |
| mahendra | finance   |
| ram      | finance   |
+----------+-----------+
16 rows in set, 1 warning (0.01 sec)

mysql> select emp_name, dept_name from employee cross join department;
+----------+-----------+
| emp_name | dept_name |
+----------+-----------+
| aaditya  | hr        |
| archita  | hr        |
| mahendra | hr        |
| ram      | hr        |
| aaditya  | IT        |
| archita  | IT        |
| mahendra | IT        |
| ram      | IT        |
| aaditya  | marketing |
| archita  | marketing |
| mahendra | marketing |
| ram      | marketing |
| aaditya  | finance   |
| archita  | finance   |
| mahendra | finance   |
| ram      | finance   |
+----------+-----------+
16 rows in set (0.00 sec)

mysql> select * from employee cross join department;
+--------+----------+---------+---------+-----------+
| emp_id | emp_name | dept_id | dept_id | dept_name |
+--------+----------+---------+---------+-----------+
|      4 | aaditya  | 104     | 101     | hr        |
|      3 | archita  | 103     | 101     | hr        |
|      2 | mahendra | 102     | 101     | hr        |
|      1 | ram      | 101     | 101     | hr        |
|      4 | aaditya  | 104     | 102     | IT        |
|      3 | archita  | 103     | 102     | IT        |
|      2 | mahendra | 102     | 102     | IT        |
|      1 | ram      | 101     | 102     | IT        |
|      4 | aaditya  | 104     | 103     | marketing |
|      3 | archita  | 103     | 103     | marketing |
|      2 | mahendra | 102     | 103     | marketing |
|      1 | ram      | 101     | 103     | marketing |
|      4 | aaditya  | 104     | 104     | finance   |
|      3 | archita  | 103     | 104     | finance   |
|      2 | mahendra | 102     | 104     | finance   |
|      1 | ram      | 101     | 104     | finance   |
+--------+----------+---------+---------+-----------+
16 rows in set (0.00 sec)

mysql> create database sp_ex;
Query OK, 1 row affected (0.02 sec)

mysql> use sp_ex;
Database changed
mysql> create table employee(id int not null, name varchar(30) not null, dept varchar(30) not null, salary int not null);
Query OK, 0 rows affected (0.06 sec)

mysql> desc employee;
+--------+-------------+------+-----+---------+-------+
| Field  | Type        | Null | Key | Default | Extra |
+--------+-------------+------+-----+---------+-------+
| id     | int         | NO   |     | NULL    |       |
| name   | varchar(30) | NO   |     | NULL    |       |
| dept   | varchar(30) | NO   |     | NULL    |       |
| salary | int         | NO   |     | NULL    |       |
+--------+-------------+------+-----+---------+-------+
4 rows in set (0.01 sec)

mysql> insert into employee values(1, 'pranjal', 'hr', 500000),(2, 'mahendra', 'IT',200000);
Query OK, 2 rows affected (0.01 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> insert into employee values(3, 'SAMARTH', 'hr', 30000),(4, 'AADITYA', 'FINANCE',50000);
Query OK, 2 rows affected (0.01 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> select * from employee;
+----+----------+---------+--------+
| id | name     | dept    | salary |
+----+----------+---------+--------+
|  1 | pranjal  | hr      | 500000 |
|  2 | mahendra | IT      | 200000 |
|  3 | SAMARTH  | hr      |  30000 |
|  4 | AADITYA  | FINANCE |  50000 |
+----+----------+---------+--------+
4 rows in set (0.00 sec)

mysql> DELIMITER //
mysql>
mysql> CREATE PROCEDURE Getdemo()
    -> BEGIN
    ->     SELECT * FROM Employee;
    -> END //
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql> DELIMITER ;
mysql> call getdemo();
+----+----------+---------+--------+
| id | name     | dept    | salary |
+----+----------+---------+--------+
|  1 | pranjal  | hr      | 500000 |
|  2 | mahendra | IT      | 200000 |
|  3 | SAMARTH  | hr      |  30000 |
|  4 | AADITYA  | FINANCE |  50000 |
+----+----------+---------+--------+
4 rows in set (0.01 sec)

Query OK, 0 rows affected (0.03 sec)

mysql> DELIMITER //
mysql>
mysql> CREATE PROCEDURE AddEmp(
    ->     IN  id INT,
    ->     IN name VARCHAR(50),
    ->     IN dept VARCHAR(50),
    ->     IN salary INT
    -> )
    -> BEGIN
    ->     INSERT INTO Employee(id, name, dept, salary)
    ->     VALUES(id, name, dept, salary);
    -> END //
Query OK, 0 rows affected (0.01 sec)

mysql> DELIMITER //
mysql>
mysql> CREATE PROCEDURE GetEmployeeCount(OUT total INT)
    -> BEGIN
    ->     SELECT COUNT(*) INTO total
    ->     FROM Employee;
    -> END //
Query OK, 0 rows affected (0.02 sec)

mysql>
mysql> DELIMITER ;
mysql>
mysql> CALL GETEMPLOYEECOUNT(@TOTAL);
Query OK, 1 row affected (0.02 sec)

mysql> SELECT @TOTAL;
+--------+
| @TOTAL |
+--------+
|      5 |
+--------+
1 row in set (0.01 sec)

mysql>