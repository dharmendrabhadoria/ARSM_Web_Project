
--select DATEDIFF(d,'2018-04-16 00:00:00','2018-04-14 00:00:00')
--Select * from tbl_workorder where n_workorderno = 2018000082 
--Select * from tbl_customer
--update tbl_workorder set d_WoDate='2018-04-14 00:00:00.000'  where n_workorderno = 2018000082 
declare @n_WorkOrderNo int = 2018000082
declare @datediff int = -2



/*CHANGE THE WORKORDER TABLE*/
/*before*/
select * from tbl_workorder where n_workorderno = @n_WorkOrderNo 
update tbl_workorder set d_modificationdate = dateadd(day , @datediff , d_modificationdate)   where n_workorderno  = @n_WorkOrderNo 
update tbl_workorder set d_WoDate = dateadd(day , @datediff , d_WoDate)   where n_workorderno  = @n_WorkOrderNo 
/*after*/
select * from tbl_workorder where n_workorderno = @n_WorkOrderNo 




/*CHANGE THE WOACTIVITIES TABLE*/
/*before*/
select * from tbl_woactivities where n_workorderno = @n_WorkOrderNo
update tbl_woactivities set d_modificationdate = dateadd(day , @datediff , d_modificationdate)  where n_workorderno = @n_WorkOrderNo
/*after*/
select * from tbl_woactivities where n_workorderno = @n_WorkOrderNo





/*CHANGE THE FILETRANSACTIONS TABLE*/
/*before*/
select * from tbl_filetransactions where n_woactivityid in 
(select n_woactivityid  from tbl_woactivities where n_workorderno  = @n_WorkOrderNo)

update tbl_filetransactions set d_modifieddate = dateadd(day , @datediff , d_modifieddate) 
where n_woactivityid in 
(select n_woactivityid  from tbl_woactivities where n_workorderno  = @n_WorkOrderNo)

/*after*/
select * from tbl_filetransactions where n_woactivityid in 
(select n_woactivityid  from tbl_woactivities where n_workorderno  = @n_WorkOrderNo)




/*CHANGE THE BOXTRANSACTIONS TABLE*/
/*before*/
select * from tbl_boxtransactions where n_woactivityid in 
(select n_woactivityid  from tbl_woactivities where n_workorderno  = @n_WorkOrderNo)

update tbl_boxtransactions set d_modifieddate = dateadd(day , @datediff , d_modifieddate)  
 where n_woactivityid in 
(select n_woactivityid  from tbl_woactivities where n_workorderno  = @n_WorkOrderNo)

/*after */
select * from tbl_boxtransactions where n_woactivityid in 
(select n_woactivityid  from tbl_woactivities where n_workorderno  = @n_WorkOrderNo)




/*CHANGE THE FILEDETAILS TABLE*/
/*before*/
select * from tbl_filedetails where n_fileid in 
(select n_fileid from tbl_filetransactions where n_woactivityid in 
(select n_woactivityid  from tbl_woactivities where n_workorderno  = @n_WorkOrderNo ))

update tbl_filedetails set d_modifieddate = dateadd(day , @datediff , d_modifieddate) , d_CheckerDate = dateadd(day , @datediff , d_CheckerDate) 
 where n_fileid in 
(select n_fileid from tbl_filetransactions where n_woactivityid in 
(select n_woactivityid  from tbl_woactivities where n_workorderno = @n_WorkOrderNo))

/*after */
select * from tbl_filedetails where n_fileid in 
(select n_fileid from tbl_filetransactions where n_woactivityid in 
(select n_woactivityid  from tbl_woactivities where n_workorderno  = @n_WorkOrderNo ))




/*CHANGE THE BOXDETAILS TABLE*/
/*before*/
select TBD.d_ModifiedDate from tbl_boxdetails TBD 
join tbl_boxtransactions TBT on TBD.n_boxid  = TBT.n_Boxid 
join tbl_Woactivities TWA on TWA.n_woactivityid = TBT.n_woactivityid 
where TWA.n_workorderno = @n_WorkOrderNo 

update TBD set TBD.d_modifieddate = dateadd(day , @datediff , TBD.d_modifieddate)
from  tbl_boxdetails TBD 
join tbl_boxtransactions TBT on TBD.n_boxid  = TBT.n_Boxid 
join tbl_Woactivities TWA on TWA.n_woactivityid = TBT.n_woactivityid 
where TWA.n_workorderno = @n_WorkOrderNo 


/*after*/
select TBD.d_ModifiedDate from tbl_boxdetails TBD 
join tbl_boxtransactions TBT on TBD.n_boxid  = TBT.n_Boxid 
join tbl_Woactivities TWA on TWA.n_woactivityid = TBT.n_woactivityid 
