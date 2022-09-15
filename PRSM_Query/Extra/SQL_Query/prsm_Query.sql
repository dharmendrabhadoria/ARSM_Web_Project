----customer-----
select * from tbl_Customer where s_CustomerName ='candrantw'
--------WO------
select * from tbl_WorkOrder
where n_CustomerId = 176
-----WO Activies---
select * from tbl_WoActivities where n_ActivityId in (9,11)
--where n_WorkorderNo = 2015000925
where n_WoActivityId = 3294
---Box Detail---
select * from tbl_BoxDetails where   s_BoxBarCode like '%SAS%' 

where n_CustomerId = 180
---Box Transaction---
select * from tbl_BoxTransactions
where n_BoxId = 3939

select * from tbl_BoxTransactions
where n_BoxId = 2
---File Detail---
select * from tbl_FileDetails
where n_BoxId = 3939
select * from tbl_FileDetails where  s_FileBarCode like '%SBS%' 
where n_BoxId = 3927


---FileTransaction---
select * from tbl_FileTransactions
where n_FileId = 49389

select * from tbl_FileTransactions
where n_FileId = 49372
---Activity---
select * from tbl_Activity
where n_ActivityId = 11
select * from tbl_Activity
where n_ActivityId = 2
select * from tbl_Activity
where n_ActivityId = 17

--Service Category---
select * from tbl_ServiceCategory
where n_ServiceCategoryId = 5

select * from tbl_ApplicationCodeMaster

declare @WORKORDER_STATUS int;
select @WORKORDER_STATUS =  n_AppCodeId From tbl_ApplicationCodeMaster Where s_AppCode = 'WORKORDER_STATUS' and s_AppCodeName = 'Closed'
              
select TFT.n_FileId,TFT.n_WoActivityId,TFT.d_ModifiedDate
from tbl_FileTransactions TFT
inner join 
(
select MAX(d_ModifiedDate) d_ModifiedDate,n_FileId
from tbl_FileTransactions
group by n_FileId
) s2
on TFT.n_FileId = s2.n_FileId
and TFT.d_ModifiedDate = s2.d_ModifiedDate
inner join tbl_FileDetails TFD on TFD.n_FileId = TFT.n_FileId
inner join tbl_WoActivities TWA on TWA.n_WoActivityId = TFT.n_WoActivityId
inner join tbl_WorkOrder TWO on TWO.n_WorkorderNo = TWA.n_WorkOrderNo
where TWO.n_Status = @WORKORDER_STATUS
order by TFT.n_FileId




select * from tbl_FileTransactions where n_FileId = 66018
66018
66017

d_ModifiedDate
2015-12-09 12:44:52.173
52171
