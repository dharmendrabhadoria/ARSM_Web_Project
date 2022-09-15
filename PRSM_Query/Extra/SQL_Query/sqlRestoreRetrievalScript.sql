
Declare @n_WorkOrderNo int=2016000101 
Declare @d_ModifiedDate datetime='2015-08-10 00:00:00.000'



select * from tbl_WorkOrder WHERE n_WorkOrderNo=@n_WorkOrderNo 

--update tbl_WorkOrder set d_ModificationDate=@d_ModifiedDate where n_WorkOrderNo=@n_WorkOrderNo 


select * from tbl_WoActivities WHERE n_WorkOrderNo=@n_WorkOrderNo 

--update tbl_WoActivities set d_ModificationDate=@d_ModifiedDate where n_WorkOrderNo=@n_WorkOrderNo 


select TWA.n_WorkOrderNo WorkorderNo,TFT.d_ModifiedDate ModificationDate
from tbl_WoActivities TWA join tbl_FileTransactions TFT
on TWA.n_WoActivityId=TFT.n_WoActivityId
WHERE n_WorkOrderNo=2016000101 


select TWA.n_WorkOrderNo WorkorderNo,TBT.d_ModifiedDate ModificationDate
from tbl_WoActivities TWA join tbl_BoxTransactions TBT
on TWA.n_WoActivityId=TBT.n_WoActivityId
WHERE n_WorkOrderNo=@n_WorkOrderNo

--Update TBT set d_ModifiedDate=@d_ModifiedDate 
--from tbl_WoActivities TWA join tbl_BoxTransactions TBT
--on TWA.n_WoActivityId=TBT.n_WoActivityId
--WHERE n_WorkOrderNo=@n_WorkOrderNo



select TWA.n_WorkOrderNo WorkorderNo,TBFT.d_ModifiedDate ModificationDate
from tbl_WoActivities TWA join tbl_BoxFileRetrivaldetails TBFT
on TWA.n_WoActivityId=TBFT.n_workOrderActivity
WHERE n_WorkOrderNo=@n_WorkOrderNo

