
select * from tbl_Customer

select * from tbl_WorkOrder where n_WorkOrderNo  = 2017000288
select * from tbl_WorkOrder where n_WorkOrderNo  = 2018000002
    
select * from tbl_WoActivities where n_WorkOrderNo  = 2017000288  
select * from tbl_WoActivities where n_WorkOrderNo = 2018000002 

--3973 File
--3974 Box

--3992
--3993
--select * from tbl_ApplicationCodeMaster
select * from tbl_FileTransactions where n_WoActivityId = 3973
select * from tbl_BoxTransactions where n_WoActivityId = 3974

select * from tbl_FileDetails where n_BoxId in(27561,27562,27563) order by s_FileBarCode asc

select * from tbl_BoxDetails where n_BoxId in(27561,27562,27563)

select * from tbl_FileTransactions where n_FileId in
(
	select n_FileId from tbl_FileDetails where n_BoxId in(27561,27562,27563) 
)


select * from tbl_BoxTransactions where n_BoxId in
(
	select n_BoxId from tbl_BoxDetails where n_BoxId in(27561,27562,27563) 
)

--begin tran
--update tbl_FileDetails set n_ApproveStatus = 148 ,d_CheckerDate = null,n_CheckerBy= null,d_ModifiedDate= '' where n_FileId in
--( 
--	select n_FileId from tbl_FileDetails where n_BoxId in(27561,27562,27563) 
--)

--begin tran
--update tbl_FileTransactions set n_WoActivityId = 3992 ,d_ModifiedDate= '' where n_FileId in
--( 
--	select n_FileId from tbl_FileDetails where n_BoxId in(27561,27562,27563) 
--)

--begin tran
--update tbl_BoxDetails set n_CustomerId = 22  where n_BoxId in(27561,27562,27563)

--begin tran
--update tbl_BoxTransactions set n_WoActivityId = 3993 where n_BoxId in
--(
--	select n_BoxId from tbl_BoxDetails where n_BoxId in(27561,27562,27563) 
--)

--begin tran
--update tbl_FileDetails set d_ModifiedDate= '2018-01-05 11:28:52.663', n_ModifiedBy =1 where n_FileId in
--( 
--	select n_FileId from tbl_FileDetails where n_BoxId in(27561,27562,27563) 
--)
--begin tran
--update tbl_FileTransactions set d_ModifiedDate= '2018-01-05 11:28:52.663' , n_ModifiedBy =1 where  n_FileId in
--(
--	select n_FileId from tbl_FileDetails where n_BoxId in(27561,27562,27563) 
--)
--begin tran
--update tbl_BoxDetails set d_ModifiedDate= '2018-01-05 11:28:52.663'  , n_ModifiedBy =1 where n_BoxId in(27561,27562,27563)
--begin tran
--update tbl_BoxTransactions set d_ModifiedDate= '2018-01-05 11:28:52.663' , n_ModifiedBy =1 where n_BoxId in
--(
--	select n_BoxId from tbl_BoxDetails where n_BoxId in(27561,27562,27563) 
--)

--update  tbl_WoActivities SET d_ModificationDate= '2018-01-05 11:28:52.663',d_ActivityDate='2018-01-05 11:28:52.663' where n_WorkOrderNo  = 2018000002  

--update tbl_WorkOrder SET d_ModificationDate= '2018-01-05 11:28:52.663' where n_WorkOrderNo  = 2018000002  
--commit