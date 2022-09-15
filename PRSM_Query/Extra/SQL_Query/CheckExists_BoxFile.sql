Select * from tbl_Customer where n_CustomerId = 7
Select * from tbl_WorkOrder where n_WorkorderNo = 2016000215
Select * from tbl_WoActivities  where n_WorkorderNo = 2016000215
Select * from tbl_BoxDetails where n_CustomerId = 7
Select * from tbl_FileTransactions where n_WoActivityId in (2123,2124,2125)
--tbl_FileTransactions
--tbl_MapBoxLocation
--tbl_BoxDetails



--begin tran
----Select * from tbl_BoxTransactions where n_WoActivityId in (2123,2124,2125)
--delete from tbl_BoxDetails where n_BoxId in (
--19392,
--19393,
--19394,
--19395,
--19396
--)
--Commit