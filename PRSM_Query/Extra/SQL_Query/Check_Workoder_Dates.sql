

select * from tbl_WorkOrder where n_WorkorderNo = 2016000058 

select * from tbl_WoActivities where n_WorkorderNo = 2016000058

select * from tbl_BoxTransactions TBT
inner join tbl_WoActivities TWA on TWA.n_WoActivityId =TBT.n_WoActivityId
where n_WorkorderNo = 2016000058

select * from tbl_BoxDetails TB 
inner join tbl_BoxTransactions TBT on TBT.n_BoxId =TB.n_BoxId
inner join tbl_WoActivities TWA on TWA.n_WoActivityId =TBT.n_WoActivityId
where n_WorkorderNo = 2016000058


select * from tbl_FileDetails FD
inner join tbl_BoxDetails TB on TB.n_BoxId =FD.n_BoxId
inner join tbl_BoxTransactions TBT  on TB.n_BoxId =TBT.n_BoxId
inner join tbl_WoActivities TWA on TWA.n_WoActivityId =TBT.n_WoActivityId
where n_WorkorderNo = 2016000058