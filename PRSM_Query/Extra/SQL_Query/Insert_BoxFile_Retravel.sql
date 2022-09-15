tbl_ApplicationCodeMaster

Select * from tbl_Customer where n_CustomerId = 20
Select * from tbl_WorkOrder where n_WorkorderNo = 2016000204 
Select * from tbl_WoActivities  where n_WorkorderNo = 2016000204 
Select * from tbl_BoxDetails where n_BoxId = 8943

Select * from tbl_FileTransactions where n_WoActivityId in (2094,2095)

Select * from tbl_FileDetails where s_FileBarCode = 'GAA196882'
n_FileId
99310
n_BoxId
8943
s_FileBarCode
GAA196882
s_BoxBarCode
GA19769
Select * from tbl_BoxFileRetrivaldetails where n_workOrderActivity in (2094,2095)

--begin tran
--Insert into tbl_BoxFileRetrivaldetails (n_IsBoxFile,n_workOrderActivity,s_BoxBarCode,s_FileBarCode,n_ModifiedBy,d_ModifiedDate)
--Values(2,	2094,'GA19769','GAA196882',1,'2016-11-24 14:34:19.687')

Select * from tbl_FileTransactions where n_WoActivityId in (2094,2095)

--Insert into tbl_FileTransactions (n_FileId,n_WoActivityId,d_ModifiedDate,n_ModifiedBy)
--Values(99310,2094,'2016-11-24 14:37:12.133',1)

--begin tran
--Update tbl_FileDetails set n_Status = 49 where n_FileId  = 99310
--commit