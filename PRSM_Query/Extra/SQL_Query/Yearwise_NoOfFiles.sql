


--NO OF files

select * from tbl_workorder TWO 
    join tbl_Woactivities TWA on TWO.n_WorkOrderno = TWA.n_workorderno 
where TWA.n_activityid = 2

select sum(n_filecount) from tbl_workorder TWO 
    join tbl_Woactivities TWA on TWO.n_WorkOrderno = TWA.n_workorderno 
where TWA.n_activityid = 2

--129520 total 


--select * from tbl_filedetails  --130032 130736  

select n_fileid , count(n_fileid) from tbl_filedetails group by n_fileid 
order by count(n_fileid) desc

select * from tbl_filedetails where n_fileid not in (select n_fileid  from tbl_filetransactions )

select count(*) from tbl_filedetails



declare @date1 datetime = '2013-04-01 00:00:00'
declare @date2 datetime = '2014-03-31 23:59:59'

declare @date3 datetime = '2014-04-01 00:00:00'
declare @date4 datetime = '2015-03-31 23:59:59'

declare @date5 datetime = '2015-04-01 00:00:00'
declare @date6 datetime = '2016-03-31 23:59:59'

--select * from tbl_workorder where d_modifieddate > @date1 and d_modifieddate < @date2



 select count(0) from 
tbl_filedetails TFD 
inner join tbl_filetransactions TFT on TFD.n_fileid = TFT.n_Fileid 
inner join tbl_woactivities TWA on TWA.n_woactivityid = TFT.n_woactivityid 
inner join tbl_workorder TWO on TWA.n_workorderno = TWO.n_workorderno 
where 
 TWA.n_activityid  = 2
 and TWO.n_status = 48 
 and  TWO.d_modificationdate >= @date1 and TWO.d_modificationdate <= @date2
 
 
 select count(0) from 
tbl_filedetails TFD 
inner join tbl_filetransactions TFT on TFD.n_fileid = TFT.n_Fileid 
inner join tbl_woactivities TWA on TWA.n_woactivityid = TFT.n_woactivityid 
inner join tbl_workorder TWO on TWA.n_workorderno = TWO.n_workorderno 
where 
 TWA.n_activityid  = 2
 and TWO.n_status = 48 
 and  TWO.d_modificationdate >= @date3 and TWO.d_modificationdate <= @date4
 
 
 select count(0) from 
tbl_filedetails TFD 
inner join tbl_filetransactions TFT on TFD.n_fileid = TFT.n_Fileid 
inner join tbl_woactivities TWA on TWA.n_woactivityid = TFT.n_woactivityid 
inner join tbl_workorder TWO on TWA.n_workorderno = TWO.n_workorderno 
where 
 TWA.n_activityid  = 2
 and TWO.n_status = 48 
 and  TWO.d_modificationdate >= @date5 and TWO.d_modificationdate <= @date6