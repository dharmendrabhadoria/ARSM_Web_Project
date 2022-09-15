
select * from UserMaster  order by ReferenceEmployeeCode desc

select * from UserMaster where EmployeeId = 5147 --Prathmesh P Padwal(AM)//5155	Sunil M Parab

select * from UserMaster where EmployeeId = 5141 --Rohit P Patil(M)//5156 Kishore M Kate
select * from UserMaster where EmployeeId = 5142 --Vipul P More(S)// 5157 Preeti M Patil //5165	Suraj M Godse	
select * from UserMaster where EmployeeId = 5143 --Sachin P Sarate(O)//5158	Pratap M Deshmukh //5164 Shushant M Kumbhar	

select * from UserMaster where EmployeeId = 5144 --Shubhangi P Koutkar(M)
select * from UserMaster where EmployeeId = 5145 --Sagar P Ipar(S)
select * from UserMaster where EmployeeId = 5146 --Satish P Pawar(O)
------------------------------Check--------------------------------------------------------------
select * from UserMaster where EmployeeId = 5142 
select * from UserMaster where EmployeeId = 5172 

select * from UserSegmentDetails where EmployeeId = 5142
select * from UserSegmentDetails where EmployeeId = 5172	    	

select * from UserSegementLineItem where UserSegmentDetailId Between 25694 and 25698
select * from UserSegementLineItem where UserSegmentDetailId Between 25799 and 25803

select * from  ApprovalLevelHirarchyAssign  where EmployeeId = 5142 
select * from  ApprovalLevelHirarchyAssign  where EmployeeId = 5172    	     

-------------------------------------------------------------------------------
--select * from UserSegmentDetails where EmployeeId = 5156

--begin tran
--delete from ApprovalLevelHirarchyAssign where  AprrovalLevelId = 1203
--commit

--begin tran
--update ApprovalLevelHirarchyAssign set ApprovalEmployeeId = 5170  where AprrovalLevelId = 1202
--commit

--begin tran
--update UserSegementLineItem set  UserSegmentDetailId = 25766 where UserSegementLineId = 32046
--commit

--update UserSegementLineItem set UserSegmentDetailId = 25801 where UserSegementLineId = 32056

--insert into ApprovalLevelHirarchyAssign (EmployeeId,LevelId,ApprovalEmployeeId,StartDate,EndDate,CreationDate,CreatedBy,LastUpdateDate,LastUpdatedBy,ApprovalSequence) values
--(5172,	1,	5171,	'2016-10-26',	NULL,	'2016-10-26 15:12:37.963'	,NULL,	NULL,	NULL,	1)