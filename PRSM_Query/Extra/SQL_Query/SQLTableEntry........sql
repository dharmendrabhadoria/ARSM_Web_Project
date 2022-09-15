
---------------Fresh Pickup---------------------------
select * from tbl_Customer 

select * from tbl_WorkOrder  where n_CustomerId = 192

select * from tbl_WoActivities where n_WorkOrderNo = 2015001359

select * from tbl_Activity where n_ActivityId in (1,2,3)

select * from tbl_ServiceCategory where n_ServiceCategoryId = 5

--Box--
select * from tbl_BoxDetails where   s_BoxBarCode like '%box1359%' 

select * from tbl_BoxTransactions where  n_BoxId = 10793

--file--
select * from tbl_FileDetails where n_BoxId = 10793

select * from tbl_FileTransactions where n_FileId in( 66095,66096)

--Status--
select * from tbl_ApplicationCodeMaster

------------------Retrieval--------------

select * from tbl_Customer 

select * from tbl_WorkOrder  where n_CustomerId = 192

select * from tbl_WoActivities where n_WorkOrderNo = 2015001360

select * from tbl_Activity where n_ActivityId in (11,17)

select * from tbl_ServiceCategory where n_ServiceCategoryId = 6

--Box--
select * from tbl_BoxDetails where   s_BoxBarCode like '%box1359%' 

select * from tbl_BoxTransactions where  n_BoxId = 10793

--file--
select * from tbl_FileDetails where n_BoxId = 10793

select * from tbl_FileTransactions where n_FileId in( 66095,66096)

--Status--
select * from tbl_ApplicationCodeMaster

------------Restore-------------------
select * from tbl_Customer 

select * from tbl_WorkOrder  where n_CustomerId = 192

select * from tbl_WoActivities where n_WorkOrderNo = 2015001369

select * from tbl_Activity where n_ActivityId in (14,16)

select * from tbl_ServiceCategory where n_ServiceCategoryId = 6

--Box--
select * from tbl_BoxDetails where   s_BoxBarCode like '%box1359%' 

select * from tbl_BoxTransactions where  n_BoxId = 10793

--file--
select * from tbl_FileDetails where n_BoxId = 10793

select * from tbl_FileTransactions where n_FileId in( 66095,66096)

--Status--
select * from tbl_ApplicationCodeMaster

