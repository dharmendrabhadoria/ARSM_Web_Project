

select * from tbl_workorder TWO join tbl_WOActivities TWA on TWO.n_workorderno = TWA.n_workorderno 
where TWO.n_Status=48 
and TWA.n_activityid in (8,9,10,11)

order by TWO.n_workorderno 


declare @date1 datetime = '2013-04-01 00:00:00'
declare @date2 datetime = '2014-03-31 23:59:59'

declare @date3 datetime = '2014-04-01 00:00:00'
declare @date4 datetime = '2015-03-31 23:59:59'

declare @date5 datetime = '2015-04-01 00:00:00'
declare @date6 datetime = '2016-03-31 23:59:59'


select * from tbl_workorder TWO join tbl_WOActivities TWA on TWO.n_workorderno = TWA.n_workorderno 
where TWO.n_Status=48 
and TWA.n_activityid in (8,9,10,11)
and   TWO.d_modificationdate >= @date1 and TWO.d_modificationdate <= @date2
order by TWO.n_workorderno 

select * from tbl_workorder TWO join tbl_WOActivities TWA on TWO.n_workorderno = TWA.n_workorderno 
where TWO.n_Status=48 
and TWA.n_activityid in (8,9,10,11)
and   TWO.d_modificationdate >= @date3 and TWO.d_modificationdate <= @date4
order by TWO.n_workorderno 

select * from tbl_workorder TWO join tbl_WOActivities TWA on TWO.n_workorderno = TWA.n_workorderno 
where TWO.n_Status=48 
and TWA.n_activityid in (8,9,10,11)
and   TWO.d_modificationdate >= @date5 and TWO.d_modificationdate <= @date6
order by TWO.n_workorderno 