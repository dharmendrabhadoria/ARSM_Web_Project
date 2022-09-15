Select * from tbl_Customer where n_CustomerId = 30
Select * from tbl_WorkOrder where n_WorkorderNo = 2016000243
Select * from tbl_WoActivities  where n_WorkorderNo = 2016000243
Select * from tbl_BoxDetails where n_CustomerId = 30
Select * from tbl_FileTransactions where n_WoActivityId in (2198,2199,2200)
Select * from tbl_BoxTransactions where n_WoActivityId in (2198,2199,2200)

select * from tbl_FileDetails where n_boxid in (
Select n_boxid from tbl_BoxTransactions where n_WoActivityId in (2198,2199,2200)
)

--begin tran
--update FD set FD.s_FileDescription1 = DFD.[FILE NAME 2]
----select * from tbl_FileDetails FD
-- from tbl_FileDetails FD  
--inner join WOData120BOX_MALAD DFD on DFD.[FILE BARCODE] = FD.s_Filebarcode 