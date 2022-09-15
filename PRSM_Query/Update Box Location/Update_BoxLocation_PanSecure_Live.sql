
--PanSecure--
select s_BoxBarCode from tbl_boxdetails B 
left join tbl_Customer C on C.n_CustomerId = B.n_CustomerId
where s_BoxBarCode in (

	select rtrim(ltrim([BOX BARCODE])) from PRSM_LIVE.dbo.Excel15122017
)

--155
-------------------------------------------------------------

select [BOX BARCODE] from PRSM_LIVE.dbo.Excel15122017 where rtrim(ltrim([BOX BARCODE])) not in (

select s_BoxBarCode from tbl_boxdetails

)
--46
--------------------------------------------------------------------------------------------



--begin tran
--update B set  B.s_LocationCode = t.Location
----select s_BoxBarCode
--from tbl_boxdetails B 
--left join PRSM_LIVE.dbo.Excel15122017 t on t.[BOX BARCODE] = B.s_BoxBarcode 
--left join tbl_Customer C on C.n_CustomerId = B.n_CustomerId
--where B.s_BoxBarCode in (

--	select rtrim(ltrim([BOX BARCODE])) from PRSM_LIVE.dbo.Excel15122017
--)

--commit
