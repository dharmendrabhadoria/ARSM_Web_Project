
declare @custid int = 196
declare @retTable Table (ErrorMsg varchar(250))  

insert @retTable (ErrorMsg) 
select 'File Barcode'+ FI.FILE_BARCODE+' in Excel file does not match with customer selected' 
from tbl_FileInfo FI
Join
tbl_FileDetails TFD
ON TFD.s_FileBarCode=FI.FILE_BARCODE
Join
tbl_BoxDetails TBD
on TBD.n_BoxId=TFD.n_BoxId	
where TBD.n_CustomerId <> @custid

Select ErrorMsg as [Error Message] from @retTable  

-----

declare @retTable Table (ErrorMsg varchar(250))  

insert @retTable (ErrorMsg) 
select 'File '+ TFD.s_FileBarCode + 'is already included in work order '+ CONVERT(varchar(20),TWO.n_WorkorderNo) + 'for retrieval.'
from tbl_Customer TC
join tbl_WorkOrder TWO
on TWO.n_CustomerId = TC.n_CustomerId
join tbl_WoActivities TWA
on TWA.n_WorkOrderNo  = TWO.n_WorkorderNo
join tbl_FileTransactions TFT
on TFT.n_WoActivityId = TWA.n_WoActivityId
join tbl_FileDetails TFD
on TFD.n_FileId = TFT.n_FileId
where TWO.n_Status= 45 and TWA.n_ActivityId in (8,9,10,11) and TWO.n_CustomerId = 190

Select ErrorMsg as [Error Message] from @retTable  



select * from tbl_FileInfo
select * from tbl_FileDetails
select * from tbl_BoxDetails

truncate table tbl_FileInfo