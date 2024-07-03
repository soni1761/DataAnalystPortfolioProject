
create database hr_analyst ;
use hr_analyst;
select count(*) from hr_1;
select count(*) from hr_2;
select * from hr_1;
select * from hr_2;


#KPI 1- Average Attrition rate for all departments
select department,
CONCAT(ROUND((SUM(CASE Attrition WHEN 'yes' THEN 1 ELSE 0 END) / COUNT(employeecount)) * 100, 2), '%') AS Average_Attrition_rate
from hr_1
group by department
order by department;

#KPI 2- Average Hourly rate of Male Research Scientist
select Gender,Jobrole, avg(HourlyRate) as Average_Hourly_rate 
from hr_1
where gender='male' and jobrole="research scientist";

#KPI 3-Attrition rate Vs Monthly income stats
select floor(monthlyincome/10000)*10000 as income_bin,
CONCAT(ROUND((SUM(CASE Attrition WHEN 'yes' THEN 1 ELSE 0 END) / COUNT(employeecount)) * 100, 2), '%') AS Average_Attrition_rate
from hr_1
inner join hr_2
on hr_1.EmployeeNumber = hr_2.`Employee ID`
group by income_bin
order by income_bin;

#KPI 4- Average working years for each Department
select hr_1.Department, avg(hr_2.YearsAtCompany) as Average_working_year
from hr_1
inner join hr_2
on hr_1.EmployeeNumber= hr_2. `Employee ID`
group by hr_1.Department;

#KPI 5- Job Role Vs Work life balance
SELECT 
    JobRole,
    CASE
        WHEN worklifebalance = 1 THEN 'Excellent'
        WHEN worklifebalance = 2 THEN 'Good'
        WHEN worklifebalance = 3 THEN 'Average'
        WHEN worklifebalance = 4 THEN 'Poor'
        ELSE 'null'
    END AS work_life_balance
FROM 
    hr_1
INNER JOIN 
    hr_2 ON hr_1.EmployeeNumber = hr_2.`Employee ID`;


#KPI 6- Attrition rate Vs Year since last promotion relation
select distinct YearsSinceLastPromotion,
CONCAT(ROUND((SUM(CASE Attrition WHEN 'yes' THEN 1 ELSE 0 END) / COUNT(employeecount)) * 100, 2), '%') AS Average_Attrition_rate
from hr_1
inner join hr_2
on hr_1.EmployeeNumber= hr_2.`Employee ID`
group by YearsSinceLastPromotion
order by YearsSinceLastPromotion;

