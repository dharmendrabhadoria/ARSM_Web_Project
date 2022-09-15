-- 2135 18 Destruction  =  Box Count
-- 2136 19 Retrieval for Destruction = Box Count + File Count
select * from tbl_Customer
select * from  tbl_WorkOrder where n_WorkOrderNo = 2016000219
select * from tbl_WoActivities where n_WorkOrderNo = 2016000219

Select * from tbl_Activity
Select * from tbl_ApplicationCodeMaster
Select * from tbl_BoxDetails
Select * from tbl_BoxTransactions  where n_WoActivityId in(2136)
Select * from tbl_FileDetails
Select * from tbl_FileTransactions where n_WoActivityId in(2135)
Select * from tbl_BoxFileRetrivaldetails  where n_workOrderActivity in(2136)

Select * from MHDestruction
--------------------------------------------------------------------------------------
--begin tran 
--insert into tbl_WorkOrder(n_WorkorderNo,	d_WoDate,	n_CustomerId,	s_Remark,	n_WareHouseId,	n_Status,	d_ModificationDate,	n_ModifiedBy,	n_RequestNo) 
--			values      (2016000219,	getdate(),	10	,'',	1,	47,	getdate(),	1	,NULL)
--commit
--------------------------------------------------------------------------------------
--begin tran
--Insert into tbl_WoActivities(n_WorkOrderNo	,	n_ActivityId,	n_ActivityStatus,	n_BoxCount	,	n_FileCount	,	s_Remark	,	d_ModificationDate	,	n_ModifiedBy	,	n_DepartmentId	,	d_ActivityDate		,	n_PickupAddressId)
--values(						2016000219		,	19			,	53				,	496			,4687			,''				,getdate()				,	1				,	NULL			,	NULL				,	16)
--commit
--------------------------------------------------------------------------------------
--- 18 Destruction Entry

--begin tran
--Insert into tbl_FileTransactions (n_FileId,	n_WoActivityId,	d_ModifiedDate,	n_ModifiedBy)
--Select FD.n_FileID,2135,getdate(),1 from tbl_FileDetails FD
--inner join MHDestruction D_FD
--on D_FD.[File Barcode] = FD.s_FileBarCode
--Commit
--------------------------------------------------------------------------------------
--- 19 Retrieval for Destruction Entry

--begin tran
--Insert into tbl_BoxFileRetrivaldetails (n_IsBoxFile,n_workOrderActivity,s_BoxBarCode,s_FileBarCode,n_ModifiedBy,d_ModifiedDate)
--Select 2,2136,D_FD.[Box Barcode],FD.s_FileBarCode,1,getdate() from tbl_FileDetails FD
--inner join MHDestruction D_FD
--on D_FD.[File Barcode] = FD.s_FileBarCode
--Commit
--------------------------------------------------------------------------------------
--begin tran
--Insert into tbl_BoxTransactions (n_BoxId,	n_WoActivityId,	d_ModifiedDate,	n_ModifiedBy)
--Select distinct BD.n_boxID,2136,getdate(),1  from tbl_BoxDetails BD
--inner join MHDestruction D_BD
--on D_BD.[Box Barcode] = BD.s_BoxBarCode
--Commit
--------------------------------------------------------------------------------------
--begin tran
--update tbl_FileDetails set n_Status = 52 where n_fileid in (
--Select n_fileid from tbl_FileDetails where n_fileid in (
--49977,
--131384,
--131395,
--131399,
--132759)
--)
--commit
--------------------------------------------------------------------------------------
--begin tran
--update tbl_BoxDetails set n_Status = 52 where n_Boxid in (
--Select n_Boxid from  tbl_BoxDetails where n_BoxId in(
--3095,
--11366	
--)
--)
--commit
--------------------------------------------------------------------------------------

