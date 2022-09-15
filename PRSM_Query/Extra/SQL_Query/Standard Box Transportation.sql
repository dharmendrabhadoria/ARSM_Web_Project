select * from tbl_invoicesummary_New where n_InvoiceNo = 2017000010
select * from tbl_invoicedetails_New where n_InvoiceNo = 2017000010
Select * from tbl_WoActivities  where n_WorkorderNo = 2017000101

select * from tbl_OtherTransactions where n_WoActivityId = 3481
--begin tran
--update tbl_OtherTransactions set n_ServiceCount = 54 where n_OtherTransId =1600

--begin tran
--update tbl_invoicedetails_New set n_ActivityCount = 54 where n_InvoiceDetailId = 953
--commit

--begin tran
--update tbl_WoActivities set n_FileCount = 54 where n_WoActivityId = 3481