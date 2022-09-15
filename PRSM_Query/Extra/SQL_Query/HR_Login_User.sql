
select * from UserMaster  order by ReferenceEmployeeCode desc
--Step 1
--begin tran
--Insert into UserMaster(ReferenceEmployeeCode,EmployeeName,UserName,UserPassword,EmploymentTypeId,Gender,StartDate,CreationDate,RoleId,IsDefaultPassword)
--Values('EM00010611','Pavitra Kotiyan (PCL)','EM00010611','10611',1,'F','2017-01-12',GETDATE(),0,1)
--commit

--Step 2
select * from  EmployeeSecurityMapping where EmployeeId = 5192
--SecurityProfileMaster
--SpId SpName
--1    Admin Security Profile
--4	 MahapeIT PCL 
--7    HR Mahape  
--8	 ITPTTL B4H 

--All for manager & 7,8 for his under Employees 

--begin tran
--Insert into  EmployeeSecurityMapping (EmployeeID,SPID,isActive)
--Values(5192,1,1)
--Insert into  EmployeeSecurityMapping (EmployeeID,SPID,isActive)
--Values(5192,4,1)
--Insert into  EmployeeSecurityMapping (EmployeeID,SPID,isActive)
--Values(5192,7,1)
--Insert into  EmployeeSecurityMapping (EmployeeID,SPID,isActive)
--Values(5192,8,1)
--commit

--Step 3

--1786 Hitesh Shirish Kshatriya //Rohit P Patil 5141
select * from UserMaster  where EmployeeId = 5189
select * from  ApprovalLevelHirarchyAssign  where EmployeeId = 5189 

select * from UserMaster  where EmployeeId = 5141
select * from  ApprovalLevelHirarchyAssign  where EmployeeId = 5189 
-----------------------------------------------------------------------------------------
--1160 Reji  Prabhakaran //Vipul P More 5142  Sachin P Sarate 5143
select * from UserMaster  where EmployeeId = 5145 
select * from  ApprovalLevelHirarchyAssign  where EmployeeId = 5189 

--begin tran
--Insert into ApprovalLevelHirarchyAssign (EmployeeId,LevelId,ApprovalEmployeeId,StartDate,CreationDate,ApprovalSequence)
--Values(5192,1,5192,'2016-10-26',GETDATE(),1)
--commit

--Sept 4                 5 Entries 1,2,3,5,7

select * from UserSegmentDetails where EmployeeId = 5192

--begin tran
--insert into UserSegmentDetails (EmployeeId,SegmentId,StartDate,CreationDate)
--Values(5192,1,'2016-10-26',GETDATE())
--insert into UserSegmentDetails (EmployeeId,SegmentId,StartDate,CreationDate)
--Values(5192,2,'2016-10-26',GETDATE())
--insert into UserSegmentDetails (EmployeeId,SegmentId,StartDate,CreationDate)
--Values(5192,3,'2016-10-26',GETDATE())
--insert into UserSegmentDetails (EmployeeId,SegmentId,StartDate,CreationDate)
--Values(5192,5,'2016-10-26',GETDATE())
--insert into UserSegmentDetails (EmployeeId,SegmentId,StartDate,CreationDate)
--Values(5192,7,'2016-10-26',GETDATE())
--commit

--Step 5
--1.Pancard Clubs Limited (Entity)
--4.IT Division (Business)
--49.Information Technology (DEPT)
--8 Administration (DEPT)
select * from UserSegementLineItem where UserSegmentDetailId Between 25902 and 25906

begin tran
Insert into UserSegementLineItem (UserSegmentDetailId,IDNo,StartDate,CreationDate)
Values(25902,2,'2016-10-26',GETDATE())
Insert into UserSegementLineItem (UserSegmentDetailId,IDNo,StartDate,CreationDate)
Values(25905,4,'2016-10-26',GETDATE())
Insert into UserSegementLineItem (UserSegmentDetailId,IDNo,StartDate,CreationDate)
Values(25904,8,'2016-10-26',GETDATE())
----commit

--Step 6
select * from UserMaster order by ReferenceEmployeeCode desc
select * from RoleMaster where RoleId = 146

begin tran
Update UserMaster set RoleId = 148 where EmployeeId = 5189
commit

--Step 7
--begin tran
--Insert into S_User_Service_Mapping(UserId,ServiceID)values(5147,27)
--commit



