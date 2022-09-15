
Select * from Sarvodaya_11302017

	Select * from tbl_BoxDetails where s_BoxBarCode in
	(

		Select [BOX BARCODE]  from Sarvodaya_11302017
	)
	Select * from tbl_BoxDetails where s_BoxBarCode in
	(

		Select [NEW BOX BARCODE]  from Sarvodaya_11302017
	)
--begin tran
--Update BD set BD.s_BoxBarCode = TB.[NEW BOX BARCODE] 
select BD.n_BoxId,BD.s_BoxBarCode,TB.[BOX BARCODE],TB.[NEW BOX BARCODE] 
from tbl_BoxDetails BD
inner join Sarvodaya_11302017 TB on TB.[BOX BARCODE] = BD.s_BoxBarCode
--commit