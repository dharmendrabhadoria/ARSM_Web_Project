
select s_boxbarcode  from tbl_boxdetails  group by s_boxbarcode having count(s_boxbarcode) > 1

select n_boxid from tbl_boxdetails where s_boxbarcode = 'GA24825'

select * from tbl_boxtransactions where n_boxid in ( 
select n_boxid  from tbl_boxdetails where d_modifieddate  = '2016-08-24 17:14:53.813' ) 

begin tran 
delete from tbl_boxtransactions where 
--select * from tbl_boxtransactions where 
n_boxid in ( 
select n_boxid  from tbl_boxdetails where d_modifieddate  = '2016-08-24 17:14:53.813' ) 


--select * from tbl_boxdetails 
delete from tbl_boxdetails 
where n_boxid in ( 
select n_boxid  from tbl_boxdetails where d_modifieddate  = '2016-08-24 17:14:53.813' ) 
--commit 
--rollback

delete  from tbl_MapBoxLocation
--select * from tbl_MapBoxLocation
where n_boxid in ( 
select n_boxid  from tbl_boxdetails where d_modifieddate  = '2016-08-24 17:14:53.813' ) 


select * from tbl_filedetails where n_boxid in ( 
select n_boxid  from tbl_boxdetails where d_modifieddate  = '2016-08-24 17:14:53.813' ) 


select * from tbl_filedetails where n_boxid in ( 
select n_boxid  from tbl_boxdetails where d_modifieddate  = '2016-08-24 11:09:49.990' ) 
