
select n_WoActivityId,n_ActivityId,n_BoxCount,n_FileCount
from tbl_WoActivities
where n_WorkOrderNo = 2015001096

update tbl_WoActivities set TFT.n_FileId,TFD.n_BoxId










declare @n_BoxId  int = n_BoxId


declare @n_WorkOrderNo  int = 2015001096
declare @n_ApproveStatus int = 121

select TFT.n_FileId,TFD.s_FileBarCode,TFD.n_BoxId,TBD.s_BoxBarCode,TACM.s_AppCodeName
from  tbl_WoActivities TWA
join tbl_FileTransactions TFT
on TFT.n_WoActivityId = TWA.n_WoActivityId
join tbl_FileDetails TFD
on TFD.n_FileId= TFT.n_FileId
join tbl_BoxDetails TBD
on TBD.n_BoxId = TFD.n_BoxId 
join tbl_ApplicationCodeMaster TACM
on TACM.n_AppCodeId = TFD.n_ApproveStatus 
where TWA.n_WorkOrderNo = @n_WorkOrderNo And TFD.n_ApproveStatus= @n_ApproveStatus








select * from tbl_WorkOrder
select * from tbl_WoActivities