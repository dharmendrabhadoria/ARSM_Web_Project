
select * from COPYDATA_10Apr


select s_BoxBarcode from COPYDATA_10Apr

--begin tran
--update BD set  BD.s_LocationCode = t.Location
----select TC.n_CustomerId,TC.s_CustomerName,BD.n_BoxId,BD.s_BoxBarcode,BD.s_LocationCode
--from tbl_BoxDetails BD
--left join tbl_Customer TC on TC.n_CustomerId =  BD.n_CustomerId
--left join COPYDATA_10Apr t on t.s_BoxBarcode = BD.s_BoxBarcode 
--where BD.s_BoxBarcode in(select s_BoxBarcode from COPYDATA_10Apr)

--Null
select TC.n_CustomerId,TC.s_CustomerName,BD.n_BoxId,BD.s_BoxBarcode,BD.s_LocationCode
from tbl_BoxDetails BD
left join tbl_Customer TC on TC.n_CustomerId =  BD.n_CustomerId
where (BD.s_LocationCode is  null or BD.s_LocationCode = '')

commit
	