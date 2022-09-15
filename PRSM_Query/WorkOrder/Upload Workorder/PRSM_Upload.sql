
--step 1

alter table WOData_2017000241_B add  n_departmentid smallint
alter table WOData_2017000241_B add  n_BoxId bigint

--step 2

--If Not Exist Then
--insert into tbl_ApplicationCodeMaster (s_AppCode,s_AppCodeName)values('DEPARTMENT','DEATH')

--begin tran
--update WOData_2017000241_B set n_departmentid = app.n_AppCodeId
----select distinct wo.[DEPT], app.s_AppCodeName, app.n_AppCodeId, wo.n_departmentid
--from WOData_2017000241_B wo 
--inner join tbl_ApplicationCodeMaster app on wo.[DEPT] = app.s_AppCodeName and app.s_AppCode ='DEPARTMENT'
--------rollback tran
----commit tran

--step 3
--select * from tbl_customer 
--select * from tbl_WoActivities Where n_WorkorderNo = 2017000207
--select * from tbl_FileTransactions where n_WoActivityId in (550,551,552)
--select * from tbl_boxdetails order by d_ModifiedDate desc
--select * from tbl_boxdetails where d_ModifiedDate ='2017-10-24 14:34:23.000'

begin tran
insert into tbl_boxdetails (s_BoxBarCode,s_LocationCode,n_CustomerId,n_WareHouseId,n_Status,d_ModifiedDate,n_ModifiedBy)
select 
distinct [BOX BARCODE],
null,
5,
1,
49,
getdate(),
1
from WOData_2017000241_B 
----rollback tran
----commit tran

--begin tran
--insert into tbl_BoxTransactions (n_BoxId,n_WoActivityId,d_ModifiedDate,n_ModifiedBy)
--select 
--n_boxid,3760,'2017-10-24 14:34:23.000',1
--from tbl_boxdetails where d_modifieddate = '2017-10-24 14:34:23.000'
----rollback tran
--commit tran

----step 4

--begin tran 
----select wo.[BOX BARCODE], box.s_BoxBarCode, box.n_BoxId
--Update WOData_2017000241_B set n_BoxId = box.n_BoxId
--from WOData_2017000241_B wo 
--inner join tbl_BoxDetails box on wo.[BOX BARCODE] = box.s_BoxBarCode 
------rollback tran
--commit tran

--step 5

--begin tran
--insert into tbl_FileDetails(n_BoxId,s_FileBarCode,s_FileName,n_BranchId,n_DepartmentId,s_Year,d_FromDate,d_EndDate,
--s_Label1,s_Label2,s_Label3, n_Status,
--d_ModifiedDate,n_ModifiedBy,n_ApproveStatus,--s_FileRemarks,d_CheckerDate,n_CheckerBy,
--s_FileDescription1--,d_DestructionDueDate,s_ImageName,s_ImageExtention,s_IMEINo,s_MobileNo)
--)
--select n_BoxId, [FILE BARCODE],[FILE NAME 1],2,n_DepartmentId, [YEAR],[FROM DATE],[TO DATE],
--[FILE TYPE],[FROM NO],[TO NO],49, 
--'2017-10-24 14:34:23.000', 1, 146,
--[FILE NAME 2]
--from WOData_2017000241_B

----rollback tran
----commit tran

--step 6

--begin tran
--insert into tbl_FileTransactions(n_FileId,n_WoActivityId,d_ModifiedDate,n_ModifiedBy)

--select fil.n_FileId,3759,'2017-10-24 14:34:23.000',1 
--from tbl_FileDetails fil
--inner join tbl_BoxTransactions box on fil.n_BoxId = box.n_BoxId
--inner join tbl_WoActivities wo on box.n_WoActivityId = wo.n_WoActivityId
--where wo.n_WorkorderNo = 2017000207

--rollback tran
--commit tran

---Approved---

--begin tran

--Update tbl_FileDetails  set n_ApproveStatus = 146 ,d_CheckerDate ='2017-10-24 14:34:23.000',n_CheckerBy = 1
--from tbl_FileDetails FD
--inner join tbl_BoxDetails TB on TB.n_BoxId =FD.n_BoxId
--inner join tbl_BoxTransactions TBT  on TB.n_BoxId =TBT.n_BoxId
--inner join tbl_WoActivities TWA on TWA.n_WoActivityId =TBT.n_WoActivityId
--where n_WorkorderNo = 2017000207

--commit tran