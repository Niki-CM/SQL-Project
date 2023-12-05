use employee;

#1.Create a database named employee, 
#then import data_science_team.csv proj_table.csv and emp_record_table.csv into the employee database
# from the given resources.


select * from emp_record_table;
select * from proj_table;

select * from data_science_team;

describe emp_record_table;
describe proj_table;
describe data_science_team ;

#2.Create an ER diagram for the given employee database.

#3.Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT from the employee record table
# and make a list of employees and details of their department.
select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT from  emp_record_table;


#4.Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: 

#4a:less than two

select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT,EMP_RATING
from emp_record_table
where EMP_RATING <2;

#4b:greater than four 
select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT,EMP_RATING
from emp_record_table
where EMP_RATING >4;

#4c:between two and four
select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT,EMP_RATING
from emp_record_table
where EMP_RATING  BETWEEN 2 AND 4;

#5.Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance department from the employee table and then give the resultant column alias as NAME.
SELECT CONCAT(FIRST_NAME," ",LAST_NAME) AS NAME 
FROM EMP_RECORD_TABLE 
WHERE DEPT="FINANCE";


#6.Write a query to list only those employees who have someone reporting to them.
# Also, show the number of reporters (including the President).
SELECT e.emp_id, e.first_name, e.last_name, COUNT(r.emp_id) AS num_reporters
FROM emp_record_table e
JOIN emp_record_table r ON e.emp_id = r.manager_id
GROUP BY e.emp_id, e.first_name, e.last_name;

#7.Write a query to list down all the employees from the healthcare and finance departments using union. 
#Take data from the employee record table.

SELECT emp_id, first_name, last_name,dept
FROM emp_record_table
where dept="finance"
UNION
SELECT emp_id, first_name, last_name,dept
FROM emp_record_table
where dept="healthcare";

#8.Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept.
# Also include the respective employee rating along with the max emp rating for the department.

SELECT e.EMP_ID, e.FIRST_NAME, e.LAST_NAME, e.ROLE, e.DEPT, e.EMP_RATING, d.MAX_EMP_RATING
FROM emp_record_table e
JOIN (
    SELECT DEPT, MAX(EMP_RATING) AS MAX_EMP_RATING
    FROM emp_record_table
    GROUP BY DEPT
) d ON e.DEPT = e.DEPT;

#9.Write a query to calculate the minimum and the maximum salary of the employees in each role.
 #Take data from the employee record table.
 
 select max(salary),min(salary),role from emp_record_table
 group by role;
 
 #10.Write a query to assign ranks to each employee based on their experience. 
 #Take data from the employee record table.
 SELECT EMP_ID, FIRST_NAME, LAST_NAME, EXP, 
       DENSE_RANK() OVER (ORDER BY EXP DESC) AS RANK_ASSIGN
FROM emp_record_table;

#11.Write a query to create a view that displays employees in various countries
# whose salary is more than six thousand. Take data from the employee record table.

SELECT EMP_ID,FIRST_NAME,DEPT,SALARY FROM EMP_RECORD_TABLE WHERE SALARY >6000;

#12.Write a nested query to find employees with experience of more than ten years.
# Take data from the employee record table.

SELECT EMP_ID,FIRST_NAME,DEPT,SALARY,EXP FROM EMP_RECORD_TABLE
WHERE EXP >(SELECT 10
    FROM DUAL);
    
    
#13.Write a query to create a stored procedure to retrieve the details of the employees
 #whose experience is more than three years. Take data from the employee record table.
 
 DELIMITER //
 CREATE PROCEDURE NEW_EXP(IN VAR INT)
 BEGIN
 SELECT EMP_ID,FIRST_NAME,DEPT,SALARY,EXP FROM EMP_RECORD_TABLE 
 WHERE EXP >VAR;
END //
DELIMITER ;

CALL NEW_EXP(3);

#14.Write a query using stored functions in the project table
# to check whether the job profile assigned to each employee 
#in the data science team matches the organization’s set standard

#The standard being:

#For an employee with experience less than or equal to 2 years assign 'JUNIOR DATA SCIENTIST',

#For an employee with the experience of 2 to 5 years assign 'ASSOCIATE DATA SCIENTIST',

#For an employee with the experience of 5 to 10 years assign 'SENIOR DATA SCIENTIST',

#For an employee with the experience of 10 to 12 years assign 'LEAD DATA SCIENTIST',

#For an employee with the experience of 12 to 16 years assign 'MANAGER'.

SELECT 
    EMP_ID, FIRST_NAME, LAST_NAME, EXP,
    CASE
        WHEN EXP <= 2 THEN 'JUNIOR DATA SCIENTIST'
        WHEN EXP > 2 AND EXP <= 5 THEN 'ASSOCIATE DATA SCIENTIST'
        WHEN EXP > 5 AND EXP <= 10 THEN 'SENIOR DATA SCIENTIST'
        WHEN EXP > 10 AND EXP <= 12 THEN 'LEAD DATA SCIENTIST'
        WHEN EXP > 12 AND EXP <= 16 THEN 'MANAGER'
        ELSE 'N/A'
    END AS JOB_PROFILE
FROM DATA_SCIENCE_TEAM;


#16.Write a query to calculate the bonus for all the employees, based on their ratings and salaries
# (Use the formula: 5% of salary * employee rating).

SELECT EMP_ID, FIRST_NAME, LAST_NAME, SALARY, EMP_RATING, 
       0.05 * SALARY * EMP_RATING AS BONUS
FROM emp_record_table;

#17.Write a query to calculate the average salary distribution based on the continent and country. 
#Take data from the employee record table.

SELECT CONTINENT, COUNTRY, AVG(SALARY) AS AVERAGE_SALARY
FROM emp_record_table
GROUP BY CONTINENT, COUNTRY;




 