

/* Total employees */
  select count(employeecount) as total_employee
  from hr_analytics;

/* Total Female And Female Percent */
  select gender, count(*) as total_female
  from hr_analytics
  where gender = 'Female'
  group by gender ;

  with employee as (
  select count(employeecount) as total_employee,
  row_number() over(order by count(employeecount)) rn
  from hr_analytics ),
  female as (
  select gender, count(*) as total_female,
  row_number() over(order by count(*)) rn
  from hr_analytics
  where gender = 'Female'
  group by gender )
  select round((total_female/total_employee)*100,2) as Percent_Female
  from employee e inner join 
  female f on e.rn=f.rn ;

 /* Total Male And Male Percent */
 
  select gender, count(*) as total_female
  from hr_analytics
  where gender = 'male'
  group by gender ;

  with employee as (
  select count(employeecount) as total_employee,
  row_number() over(order by count(employeecount)) rn
  from hr_analytics ),
  male as (
  select gender, count(*) as total_male,
  row_number() over(order by count(*)) rn
  from hr_analytics
  where gender = 'male'
  group by gender )
  select round((total_male/total_employee)*100,2) as Percent_male
  from employee e inner join 
  male f on e.rn=f.rn ;

/* Total Employee by Service Year */
  select YearsAtCompany as Service_Year, count(EmployeeCount) as total
  from hr_analytics
  group by YearsAtCompany
  order by total desc;

/* Total Employees by Job Levels */
  select JobLevel as Job_Level, count(EmployeeCount) as Total
  from hr_analytics
  group by JobLevel
  order by Total Desc;

/* Due For Promotion And Not Due For Promotion */
  with promotion as (
  select YearsSinceLastPromotion, case when YearsSinceLastPromotion >= 10 then 'Due For Promotion'
  else 'Not Due' end as Promotion_Status
  from hr_analytics )
  select Promotion_Status, count(*) as Total
  from promotion where Promotion_Status = 'Not Due'
  group by Promotion_Status;

  with promotion as (
  select YearsSinceLastPromotion, case when YearsSinceLastPromotion >= 10 then 'Due For Promotion'
  else 'Not Due' end as Promotion_Status
  from hr_analytics )
  select Promotion_Status, count(*) as Total
  from promotion where Promotion_Status = 'Due For Promotion'
  group by Promotion_Status;

/* Total Employee by Distance Status */
  with distance as (
  select DistanceFromHome, case when DistanceFromHome >= 20 then 'very far'
  when DistanceFromHome >= 10 then 'close'
  else 'very close' end as Distance_Status
  from hr_analytics )
  select Distance_Status, count(*) as Total
  from distance
  group by Distance_Status;

/* Retrenchment Status */
  with Retrenchment as (
  select YearsAtCompany, case when YearsAtCompany >= 18 then 'will be retrenched'
  else 'on service' end as Retrenchment_Status
  from hr_Analytics )
  select Retrenchment_Status, count(*) as Total
  from Retrenchment
  group by Retrenchment_Status;

/* Employee by Job Satisfaction Level */
  with Job_Satisfaction as (
  select JobSatisfaction, case when JobSatisfaction <= 2 then 'Low'
  when JobSatisfaction = 3 then 'Medium'
  else 'High' end as Job_Satisfaction_Level
  from hr_analytics )
  select Job_Satisfaction_Level, count(*) as Total
  from Job_Satisfaction
  group by Job_Satisfaction_Level ;
 
 /* Total Employee by Overtime */
  select OverTime, count(*) as Total
  from hr_analytics
  group by OverTime;
 
/* Due for Promotion and Retrenchment by Department */
 
 
  with Retrenchment as (
  select Department, YearsAtCompany, case when YearsAtCompany >= 18 then 'will be retrenched'
  else 'on service' end as Retrenchment_Status
  from hr_Analytics )
  select Department,  count(Retrenchment_Status) as will_be_retrenched
  from Retrenchment
  where Retrenchment_Status = 'will be retrenched'
  group by Department, Retrenchment_Status
  order by Department;

  with promotion as (
  select Department, YearsSinceLastPromotion, 
  case when YearsSinceLastPromotion >= 10 then 'Due For Promotion'
  else 'Not Due' end as Promotion_Status
  from hr_analytics )
  select Department,  count(Promotion_Status) as Due_For_Promotion
  from promotion where Promotion_Status = 'Due For Promotion'
  group by Department, Promotion_Status
  order by Department;

/* Total Employees by Job Roles, Due for Promotion and Due for Retrenchment */

  select JobRole, count(employeecount) as Total
  from hr_analytics
  group by JobRole ;

/* Employee Name */

  select `Emplyee name` as Employee_name
  from hr_employee;