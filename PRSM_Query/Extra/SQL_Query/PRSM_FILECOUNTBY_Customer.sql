
select tcd_ot.s_customername 'CustomerName',Twr.n_workorderno 'WorkordeNo',tbd_ot.s_boxbarcode 'Box Barcode',Tbl_File.s_filebarcode'File Barcode',CONVERT(VARCHAR(11),Twr.d_modificationdate, 106)'Workorder Close Date' from tbl_woactivities TwA_OT
JOIN 
(
select distinct TC.s_CustomerName,FD.n_boxid,FD.s_filebarcode,max(TWA.n_woactivityid) As n_WoActivityId --max(TWA.d_Modificationdate)
from tbl_customer TC
inner join tbl_WorkOrder TWO on TWO.n_CustomerId = TC.n_CustomerId 
inner join tbl_woactivities TWA on TWA.n_WorkOrderNo =  TWO.n_WorkOrderNo
inner join tbl_FileTransactions FT on FT.n_WoActivityId = TWA.n_WoActivityId
inner join tbl_filedetails FD on FD.n_FileId = FT.n_FileId
inner join tbl_activity TA on TA.n_activityid = TWA.n_activityid
where FD.n_status ='50' 
group by TC.s_CustomerName,FD.n_boxid,FD.s_filebarcode
) 
Tbl_File on TwA_OT.n_WoActivityId=Tbl_File.n_WoActivityId
join tbl_Workorder Twr on Twr.n_WorkOrderNo=TwA_OT.n_WorkOrderNo
join tbl_boxdetails tbd_ot on tbd_ot.n_Boxid=Tbl_File.n_boxid
join tbl_customer tcd_ot on tcd_ot.n_customerid=tbd_ot.n_customerid

order by tcd_ot.s_customername 



select tcd_ot.s_customername 'CustomerName',Twr.n_workorderno 'WorkordeNo',tbd_ot.s_boxbarcode 'Box Barcode',Tbl_File.s_filebarcode'File Barcode',CONVERT(VARCHAR(11),Twr.d_modificationdate, 106)'Workorder Close Date',DATEDIFF(d,Twr.d_modificationdate,getdate())'No of Days'  from tbl_woactivities TwA_OT 
JOIN 
(
select distinct TC.s_CustomerName,FD.n_boxid,FD.s_filebarcode,max(TWA.n_woactivityid) As n_WoActivityId --max(TWA.d_Modificationdate)
from tbl_customer TC
inner join tbl_WorkOrder TWO on TWO.n_CustomerId = TC.n_CustomerId 
inner join tbl_woactivities TWA on TWA.n_WorkOrderNo =  TWO.n_WorkOrderNo
inner join tbl_FileTransactions FT on FT.n_WoActivityId = TWA.n_WoActivityId
inner join tbl_filedetails FD on FD.n_FileId = FT.n_FileId
inner join tbl_activity TA on TA.n_activityid = TWA.n_activityid
where FD.n_status ='50' 
group by TC.s_CustomerName,FD.n_boxid,FD.s_filebarcode
) 
Tbl_File on TwA_OT.n_WoActivityId=Tbl_File.n_WoActivityId
join tbl_Workorder Twr on Twr.n_WorkOrderNo=TwA_OT.n_WorkOrderNo
join tbl_boxdetails tbd_ot on tbd_ot.n_Boxid=Tbl_File.n_boxid
join tbl_customer tcd_ot on tcd_ot.n_customerid=tbd_ot.n_customerid

order by tcd_ot.s_customername 












select TC.s_CustomerName ,count( distinct FD.s_filebarcode)'Out Files'
from tbl_customer TC
inner join tbl_WorkOrder TWO on TWO.n_CustomerId = TC.n_CustomerId 
inner join tbl_woactivities TWA on TWA.n_WorkOrderNo =  TWO.n_WorkOrderNo
inner join tbl_FileTransactions FT on FT.n_WoActivityId = TWA.n_WoActivityId
inner join tbl_filedetails FD on FD.n_FileId = FT.n_FileId
where FD.n_status ='50'
group by TC.s_CustomerName 







