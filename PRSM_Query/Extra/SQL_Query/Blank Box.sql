--14134 Tot
--10296 Null
--3838 No Null

select TC.n_CustomerId,TC.s_CustomerName,BD.n_BoxId,BD.s_BoxBarcode,BD.s_LocationCode
from tbl_BoxDetails BD
left join tbl_Customer TC on TC.n_CustomerId =  BD.n_CustomerId
where (BD.n_CustomerId = 10)

--not null
select TC.n_CustomerId,TC.s_CustomerName,BD.n_BoxId,BD.s_BoxBarcode,BD.s_LocationCode
from tbl_BoxDetails BD
left join tbl_Customer TC on TC.n_CustomerId =  BD.n_CustomerId
where (BD.s_LocationCode is not  null and BD.s_LocationCode != '')
and (BD.n_CustomerId = 10)

--Null
select TC.n_CustomerId,TC.s_CustomerName,BD.n_BoxId,BD.s_BoxBarcode,BD.s_LocationCode
from tbl_BoxDetails BD
left join tbl_Customer TC on TC.n_CustomerId =  BD.n_CustomerId
where (BD.s_LocationCode is  null or BD.s_LocationCode = '')
and (BD.n_CustomerId = 5)

select * from tbl_MapBoxLocation where s_BoxLocationCode is null or s_BoxLocationCode = ''
GA-04004