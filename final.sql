create user dbfinal identified by khader;

GRANT ALL PRIVILEGES ON dbfinal;

create table  SalaryScales(
          ScaleCode number(10) primary key,
          ScaleName varchar2(50),
          ScaleDescription varchar2(255),
	  MinSalary number(15),
	  MaxSalary number(15));

create table Employees(
          EmployeeId number(10) primary key,
          FirstName varchar2(50),
          LastName varchar2(50),
    Gender varchar2(6),
          DOB Date);

create table Allowances(
          AllowanceId number(10) primary key,
          AllowanceName varchar2(60),
          AllowDescription varchar2(255),
	  Amount number(20)
);

create table Positions(
          PositionId number(10) primary key,
          PositionName varchar2(50),
          PositionDescription varchar2(255),
	  ScaleCode number(10),
          constraint sal_pos_fk foreign key (ScaleCode)
          references SalaryScales(ScaleCode));



create table EmployeePosition(
          EmpPosId number(10) primary key,
          PositionId number(10),
    EmployeeId number(10),
          StartDate Date,
    EndDate Date,
    Comments varchar2(255),
          constraint emppo_pos_fk foreign key (PositionId)
          references Positions(PositionId),
          constraint emppo_Emp_fk foreign key (EmployeeId)
          references Employees(EmployeeId)
);





create table PositionAllowances(
          PosAllowId number(10) primary key,
          PositionId number(10),
         AllowanceId number(10),
          constraint posall_pos_fk foreign key (PositionId)
          references Positions(PositionId),
          constraint posall_all_fk foreign key (AllowanceId)
          references Allowances(AllowanceId)
);

create table Vehicles(
          VechileId number(10) primary key,
          RegistrationNo number(20),
Year number(4),
Make varchar2(50),
Model varchar2(60),
Color varchar2(20),
PositionId number(10),
          constraint ve_pos_fk foreign key (PositionId)
          references Positions(PositionId)
);


CREATE SEQUENCE id_seq
INCREMENT BY 5
START WITH 10
MAXVALUE 500;
-- 15
insert into SalaryScales
    (ScaleCode, ScaleName, ScaleDescription, MinSalary, MaxSalary) VALUES (id_seq.NEXTVAL, 'ScaleName1', 'ScaleDescription1', 1, 10);
-- 20
insert into SalaryScales
    (ScaleCode, ScaleName, ScaleDescription, MinSalary, MaxSalary) VALUES (id_seq.NEXTVAL, 'ScaleName2', 'ScaleDescription2', 2, 20);
-- 25
insert into Employees
    (EmployeeId, FirstName, LastName, Gender, DOB) VALUES (id_seq.NEXTVAL, 'FirstName1', 'LastName1', 'Male', sysdate);
-- 30
insert into Employees
    (EmployeeId, FirstName, LastName, Gender, DOB) VALUES (id_seq.NEXTVAL, 'FirstName2', 'LastName2', 'Male', sysdate);
-- 35
insert into Allowances
    (AllowanceId, AllowanceName, AllowDescription, Amount) VALUES (id_seq.NEXTVAL, 'AllowanceName1', 'AllowDescription1', 1);
-- 40
insert into Allowances
    (AllowanceId, AllowanceName, AllowDescription, Amount) VALUES (id_seq.NEXTVAL, 'AllowanceName2', 'AllowDescription2', 2);
-- 45
insert into Positions 
    (PositionId, PositionName, PositionDescription, ScaleCode)
    VALUES (id_seq.NEXTVAL, 'posName1', 'posDesc1', 1);
-- 50
insert into Positions 
    (PositionId, PositionName, PositionDescription, ScaleCode)
    VALUES (id_seq.NEXTVAL, 'posName2', 'posDesc2', 2);

insert into EmployeePosition
    (EmpPosId, PositionId, EmployeeId, StartDate, EndDate, Comments) VALUES (id_seq.NEXTVAL, 45, 25, sysdate, sysdate, 'Comments1');

insert into EmployeePosition
    (EmpPosId, PositionId, EmployeeId, StartDate, EndDate, Comments) VALUES (id_seq.NEXTVAL, 50, 30, sysdate, sysdate, 'Comments2');

insert into PositionAllowances
    (PosAllowId, PositionId, AllowanceId) VALUES (id_seq.NEXTVAL, 45, 35);

insert into PositionAllowances
    (PosAllowId, PositionId, AllowanceId) VALUES (id_seq.NEXTVAL, 50, 40);

insert into Vehicles
    (VechileId, RegistrationNo, Year, Make, Model, Color, PositionId) VALUES (id_seq.NEXTVAL, 1, 2021, 'make1', 'model1', 'color1', 1);

insert into Vehicles
    (VechileId, RegistrationNo, Year, Make, Model, Color, PositionId) VALUES (id_seq.NEXTVAL, 2, 2022, 'make2', 'model2', 'color2', 2);


select EmployeeId, Gender, LastName from Employees where Gender = 'male';

select FirstName, EndDate, PositionName 
from Employees, Positions, EmployeePosition
where Employees.EmployeeId = EmployeePosition.EmployeeId
and EmployeePosition.PositionId = Positions.PositionId
order by FirstName DESC;

select MinSalary - MaxSalary from SalaryScales;

select * from Vehicles 
where Color IN('red', 'blue', 'green')
and upper(PositionName) LIKE '%r%';

select Positions.PositionName 
from Positions, Allowances, PositionAllowances
where Positions.PositionId = PositionAllowances.PositionId
and PositionAllowances.AllowanceId = Allowances.AllowanceId;

delete from Vehicles where year = '2010';

update Allowances set Amount = 5
    WHERE AllowanceId NOT IN (SELECT AllowanceId FROM PositionAllowances);

create or replace view v1 as
select ScaleDescription, MinSalary, MaxSalary, PositionName 
from SalaryScales, Positions
where SalaryScales.ScaleCode = Positions.ScaleCode;

CREATE or replace VIEW union_view AS
select DBO from Employees 
UNION
select StartDate from EmployeePosition;

create synonyms emp from employees;

drop table SalaryScales;
drop table Employees;
drop table Allowances;
drop table Positions;
drop table EmployeePosition;
drop table PositionAllowances;
drop table Vehicles;

REVOKE All PRIVILEGES FROM dbfinal;