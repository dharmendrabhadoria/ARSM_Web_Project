select * from tbl_workorder where n_workorderno  in (2016000070) 
/*
update tbl_workorder set d_modificationdate = '2015-10-14 18:14:06.330' where n_workorderno  in (2016000070) 
*/


select * from tbl_woactivities where n_workorderno in  (2016000070) 
/*
update tbl_woactivities set d_modificationdate = '2015-10-14 18:14:06.330'  where n_workorderno in  (2016000070) 
*/


select * from tbl_filetransactions where n_woactivityid in 
(select n_woactivityid  from tbl_woactivities where n_workorderno in  (2016000070) )
/*
update tbl_filetransactions set d_modifieddate = '2015-10-14 18:14:06.330' 
 where n_woactivityid in 
(select n_woactivityid  from tbl_woactivities where n_workorderno in  (2016000070) )
*/
select * from tbl_boxtransactions where n_woactivityid in 
(select n_woactivityid  from tbl_woactivities where n_workorderno in  (2016000070) )
/*
update tbl_boxtransactions set d_modifieddate = '2015-10-14 18:14:06.330' 
 where n_woactivityid in 
(select n_woactivityid  from tbl_woactivities where n_workorderno in  (2016000070) )
*/

select * from tbl_filedetails where n_fileid in 
(select n_fileid from tbl_filetransactions where n_woactivityid in 
(select n_woactivityid  from tbl_woactivities where n_workorderno in  (2016000070) ))
/*
update tbl_filedetails set d_modifieddate = '2015-10-14 18:14:06.330' , d_CheckerDate = '2015-10-14 18:14:06.330' 
 where n_fileid in 
(select n_fileid from tbl_filetransactions where n_woactivityid in 
(select n_woactivityid  from tbl_woactivities where n_workorderno in  (2016000070) ))
*/


select * from tbl_boxdetails where n_boxid in 
(select n_boxid from tbl_boxtransactions where n_woactivityid in 
(select n_woactivityid  from tbl_woactivities where n_workorderno in  (2016000070) ))
/*
update tbl_boxdetails set d_modifieddate = '2015-10-14 18:14:06.330' 
 where n_boxid in 
(select n_boxid from tbl_boxtransactions where n_woactivityid in 
(select n_woactivityid  from tbl_woactivities where n_workorderno in  (2016000070) ))
*/
