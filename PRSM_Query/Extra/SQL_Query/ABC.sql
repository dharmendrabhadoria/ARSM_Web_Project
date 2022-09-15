Select * from tbl_Customer where n_CustomerId = 10
Select * from tbl_WorkOrder where n_CustomerId = 10 order by n_WorkorderNo asc

Select * from tbl_WoActivities  where n_WorkorderNo = 2015000002
Select * from tbl_BoxDetails where n_CustomerId = 10
Select * from tbl_FileTransactions where n_WoActivityId in (2123,2124,2125)

Select * from tbl_ApplicationCodeMaster
 Select * from  tbl_Activity
Select * from tbl_WoActivities WAC  
left join tbl_WorkOrder WO on WAC.n_WorkorderNo = WO.n_WorkorderNo
where 
WO.n_CustomerId = 10 and n_ActivityId =1

Select * from tbl_FileDetails FD
Left Join tbl_BoxDetails BD
on BD.n_BoxID = FD.n_BoxID  where n_CustomerId = 10 And FD.n_Status = 51 

Select * from tbl_BoxDetails BD  
Left Join tbl_FileDetails FD
on BD.n_BoxID = FD.n_BoxID  where n_CustomerId = 10 And FD.n_Status = 52 
