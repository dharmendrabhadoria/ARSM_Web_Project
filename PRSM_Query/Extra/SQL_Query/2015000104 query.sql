select * from tbl_workorder where n_WorkorderNo = 2015000104

--begin tran
--update tbl_workorder set d_WoDate = '2015-10-14 00:00:00.000' ,d_ModificationDate = '2015-10-14 15:41:07.510'  where n_WorkorderNo = 2015000104
--commit

select * from tbl_WoActivities where n_WorkorderNo = 2015000104 
--n_WoActivityId in(435,436,437)

--begin tran
--update tbl_WoActivities set d_ModificationDate = '2015-10-14 15:41:07.517' ,d_ActivityDate = '2015-10-14 00:00:00.000' where n_WorkorderNo = 2015000104
--commit

select * from tbl_FileTransactions where n_WoActivityId in(435,436,437)
--6145 rows

--begin tran
--update tbl_FileTransactions set d_ModifiedDate = '2015-10-14 11:08:07.503'  where n_WoActivityId in(435,436,437)
--commit

select 
TFT.n_FileId ,
TFD.d_ModifiedDate

from tbl_FileTransactions TFT
join
tbl_FileDetails TFD
on TFD.n_FileId = TFT.n_FileId
where  n_WoActivityId in(435,436,437)
--6145 rows

--begin tran
--update  tbl_FileDetails set d_ModifiedDate = '2015-10-14 11:08:07.503'
--from tbl_FileTransactions TFT
--join
--tbl_FileDetails TFD
--on TFD.n_FileId = TFT.n_FileId
--where  n_WoActivityId in(435,436,437)
--commit

select * from tbl_BoxTransactions   where n_WoActivityId in(435,436,437)
--1000 rows

--begin tran
--update tbl_BoxTransactions set d_ModifiedDate = '2015-10-14 11:08:07.503'  where n_WoActivityId in(435,436,437)
--commit

select 
TBT.n_BoxId ,
TBD.d_ModifiedDate

from tbl_BoxTransactions TBT
join
tbl_BoxDetails TBD
on TBD.n_BoxId = TBT.n_BoxId
where  n_WoActivityId in(435,436,437)
--1000 rows

--begin tran
--update  tbl_BoxDetails set d_ModifiedDate = '2015-10-14 11:08:07.503'
--from tbl_BoxTransactions TBT
--join
--tbl_BoxDetails TBD
--on TBD.n_BoxId = TBT.n_BoxId
--where  n_WoActivityId in(435,436,437)
--commit


--------------------------------------------------------------------------------------------------------------------------------
                                        --update manual
--select * from tbl_invoicesummary where n_InvoiceNo = 2015000083--begin tran--update tbl_invoicesummary set n_StorageCharges = 41615.00,n_InvoiceAmount = 125757.00,n_TotalAmount = 125757.00  where n_InvoiceNo = 2015000083--commit--select * from tbl_workorder where n_WorkorderNo = 2015000104--select * from tbl_WoActivities where n_WorkorderNo = 2015000105

--begin
--tran
--update tbl_WoActivities set n_FileCount = 6225 where n_WoActivityId = 438
--commit

--inert

--select * from tbl_invoicedetails  where n_InvoiceNo = 2015000083--begin--tran--insert into tbl_invoicedetails(n_InvoiceNo,n_WoActivityId,n_ActivityCount,n_Amount) values(2015000083,435,6146,1.00)----insert into tbl_invoicedetails (n_InvoiceNo,n_WoActivityId,n_ActivityCount,n_Amount) values(2015000083,436,0,0)--insert into tbl_invoicedetails (n_InvoiceNo,n_WoActivityId,n_ActivityCount,n_Amount) values(2015000083,437,1,15790.00)--commit
--begin--tran--insert into tbl_invoicedetails(n_InvoiceNo,n_WoActivityId,n_ActivityCount,n_Amount) values(2015000083,438,6225,1.00)--insert into tbl_invoicedetails (n_InvoiceNo,n_WoActivityId,n_ActivityCount,n_Amount) values(2015000083,439,665,45.00)--insert into tbl_invoicedetails (n_InvoiceNo,n_WoActivityId,n_ActivityCount,n_Amount) values(2015000083,440,1,14227.00)--commit-- rollback -- --update tbl_invoicedetails set n_ActivityCount = 1 where  n_InvoiceDetailId = 903-- --update tbl_invoicedetails set n_ActivityCount = 1 where  n_InvoiceDetailId = 912
--select * from tbl_invoicesummary where n_InvoiceNo = 2015000083--begin tran--update tbl_invoicesummary set n_StorageCharges = 41615.00,n_InvoiceAmount = 125757.00,n_TotalAmount = 125757.00  where n_InvoiceNo = 2015000083--commit