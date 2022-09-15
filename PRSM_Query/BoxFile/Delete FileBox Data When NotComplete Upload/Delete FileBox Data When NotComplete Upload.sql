--Select * from tbl_Customer where n_CustomerId = 10
--Select * from tbl_WorkOrder where n_WorkorderNo = 2018000028
--Select * from tbl_WoActivities  where n_WorkorderNo = 2018000028

declare @ID1 int = 4062
declare @ID2 int = 4063
declare @ID3 int = 4064

--delete from tbl_MapBoxLocation where n_boxid in (
--Select n_boxid from tbl_BoxTransactions where n_WoActivityId in (@ID1,@ID2,@ID3)
--)

--delete from tbl_FileTransactions where n_WoActivityId in (@ID1,@ID2,@ID3)

--delete from tbl_FileDetails where n_boxid in (
--Select n_boxid from tbl_BoxTransactions where n_WoActivityId in (@ID1,@ID2,@ID3)
--)

--delete from tbl_BoxDetails where n_boxid in (
--Select n_boxid from tbl_BoxTransactions where n_WoActivityId in (@ID1,@ID2,@ID3)
--)

--delete from tbl_BoxTransactions where n_WoActivityId in (@ID1,@ID2,@ID3)


