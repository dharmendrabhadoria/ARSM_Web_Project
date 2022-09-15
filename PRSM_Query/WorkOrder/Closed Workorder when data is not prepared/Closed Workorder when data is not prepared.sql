
select * from tbl_WorkOrder where  n_WorkorderNo = 2018000026 
select * from tbl_WoActivities where  n_WorkorderNo = 2018000026 
select * from tbl_ApplicationCodeMaster  
 
------Box Count----1
--begin tran
--update tbl_WoActivities set n_BoxCount = 276 where n_WoActivityId = 4057 and n_WorkOrderNo = 2018000026

--update tbl_WoActivities set n_ActivityStatus = 54  where n_WorkOrderNo = 2018000026

--update tbl_WorkOrder set n_Status = 48  where  n_WorkorderNo = 2018000026 
--Commit


