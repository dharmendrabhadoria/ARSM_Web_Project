


--NO OF boxes

select * from tbl_workorder TWO 
    join tbl_Woactivities TWA on TWO.n_WorkOrderno = TWA.n_workorderno 
where TWA.n_activityid = 1

select sum(n_boxcount) from tbl_workorder TWO 
    join tbl_Woactivities TWA on TWO.n_WorkOrderno = TWA.n_workorderno 
where TWA.n_activityid = 1

--11187 total 


select * from tbl_boxdetails  --11187

declare @date1 datetime = '2013-04-01 00:00:00'
declare @date2 datetime = '2014-03-31 23:59:59'

declare @date3 datetime = '2014-04-01 00:00:00'
declare @date4 datetime = '2015-03-31 23:59:59'

declare @date5 datetime = '2015-04-01 00:00:00'
declare @date6 datetime = '2016-03-31 23:59:59'



select sum(n_boxcount) from tbl_workorder TWO 
    join tbl_Woactivities TWA on TWO.n_WorkOrderno = TWA.n_workorderno 
where TWA.n_activityid = 1
and  TWO.d_modificationdate >= @date1 and TWO.d_modificationdate <= @date2
and TWO.n_Status = 48 

select sum(n_boxcount) from tbl_workorder TWO 
    join tbl_Woactivities TWA on TWO.n_WorkOrderno = TWA.n_workorderno 
where TWA.n_activityid = 1
and  TWO.d_modificationdate >= @date3 and TWO.d_modificationdate <= @date4
and TWO.n_Status = 48 

select sum(n_boxcount) from tbl_workorder TWO 
    join tbl_Woactivities TWA on TWO.n_WorkOrderno = TWA.n_workorderno 
where TWA.n_activityid = 1
and  TWO.d_modificationdate >= @date5 and TWO.d_modificationdate <= @date6
and TWO.n_Status = 48 

--select * from tbl_workorder where d_modifieddate > @date1 and d_modifieddate < @date2
