Select * from tbl_WorkOrder where n_WorkorderNo = 2018000001 
Select * from tbl_WoActivities  where n_WorkorderNo = 2018000001 
select * from tbl_BoxFileRetrivaldetails where n_workOrderActivity = 3990
select * from tbl_ApplicationCodeMaster

select * from tbl_FileDetails  where s_FileBarCode = 'GAA439590'
select * from tbl_FileDetails  where s_FileBarCode = 'GAA245469'
select * from tbl_FileDetails  where s_FileBarCode = 'GAA245524'


select * from  tbl_FileTransactions where n_WoActivityId in (3990,3991)


--begin tran
--Insert into tbl_BoxFileRetrivaldetails (n_IsBoxFile,n_workOrderActivity,s_BoxBarCode,s_FileBarCode,n_ModifiedBy,d_ModifiedDate)
--Values(2,	3990,'GA27125','GAA439590',1,'2018-01-02 17:23:16.587')

--Insert into tbl_FileTransactions (n_FileId,n_WoActivityId,d_ModifiedDate,n_ModifiedBy)
--Values(274677,3990,'2018-01-02 17:23:16.587',1)

--Update tbl_FileDetails set n_Status = 50 where n_FileId  = 274677

--update tbl_WoActivities set n_FileCount = 7 where n_WoActivityId = 3991

commit