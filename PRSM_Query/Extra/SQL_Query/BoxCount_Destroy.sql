select s_boxbarcode , A.FileCount TotalFileCount, B.FileCount FilesToBeDestroyed,  A.FileCount - B.FileCount  FileCountDifference from 
(select 
TBD.n_boxid , TBD.s_boxbarcode , count(TFD.n_Fileid) FileCount
from 
tbl_boxdetails TBD 
join tbl_FileDetails TFD on TBD.n_Boxid = TFD.n_BoxId 
where 
	TBD.n_customerid = 10 
	and TBD.n_Status <> 52
group by TBD.n_boxid , TBD.s_boxbarcode ) A 
join 
--order by  count(TFD.n_Fileid)  desc
(
select [Box Barcode] , count([File BARCODE])  FileCount
 from dbo.DiscardDataSheet_12Oct2016
group by [Box barcode] 
) B on A.s_boxbarcode = B.[Box Barcode]
order by A.FileCount - B.FileCount  Desc