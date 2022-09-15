--begin tran 

--update tbl_boxdetails set n_status = 49 where 
--s_boxbarcode in 
--(
select n_boxId  from 
(

select 
TBD.n_boxId , 
count ( TFD.n_fileid ) TotalFiles ,
sum ( case when TFD.n_status = 52 then 1 else 0 end ) as NoOfDestroyedFiles
 from tbl_boxdetails TBD 
join tbl_filedetails TFD on TBD.n_boxid = TFD.n_boxid
where TBD.n_boxid in (
Select distinct n_boxid from tbl_FileDetails 
where  n_fileid in (Select n_fileid from tbl_FileTransactions where n_WoActivityId in (2135,2136))
)
group by TBD.n_boxId 
--order by count ( TFD.n_fileid ) desc
)  A 
where TotalFiles -Noofdestroyedfiles  > 0 
--)

--commit