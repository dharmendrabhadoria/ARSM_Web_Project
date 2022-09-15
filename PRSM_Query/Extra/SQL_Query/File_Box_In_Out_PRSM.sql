select count(*) from tbl_boxdetails where n_status in (49)
select count(*) from tbl_boxdetails where n_status in (50)



select count(*) from tbl_filedetails where n_status in (49 )--127507
select count(*) from tbl_filedetails where n_status in (50 )--120



select  * from tbl_WoActivities 
select * from tbl_WorkOrder
select * from tbl_ApplicationCodeMaster 
select * from tbl_customer


select count(tbd.n_status)'In Boxes'
from tbl_boxdetails tbd
where n_status='49'

--Query to find out InBox---
select tbl_customer.s_CustomerName,count(tbl_boxdetails.n_status)'In Boxes'from tbl_boxdetails 
join tbl_customer 
on tbl_boxdetails.n_customerid=tbl_customer.n_customerId
where n_status='49'
group by tbl_customer.s_CustomerName

--Query to find In Files---
select count(tfd.n_status)'In Files'
from tbl_filedetails tfd
where n_status in (49)
--127507

--Query to find out Files---
select count(tfd.n_status)'Out Files'
from tbl_filedetails tfd
where n_status in (50)
--119

---Query to find count of out files whose status is 50-----
select TC.s_CustomerName ,count( distinct FD.s_filebarcode)'Out Files'
from tbl_customer TC
inner join tbl_WorkOrder TWO on TWO.n_CustomerId = TC.n_CustomerId 
inner join tbl_woactivities TWA on TWA.n_WorkOrderNo =  TWO.n_WorkOrderNo
inner join tbl_FileTransactions FT on FT.n_WoActivityId = TWA.n_WoActivityId
inner join tbl_filedetails FD on FD.n_FileId = FT.n_FileId
where FD.n_status ='50'
group by TC.s_CustomerName 

-----Query to find out workorder no for particular customer for Out File 

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










