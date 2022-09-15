
select distinct rtrim(ltrim([BOX BARCODE])) from INTER_06022018
--Box 5
select distinct rtrim(ltrim([FILE BARCODE])) from INTER_06022018
--455


--In system Box and File

select * from tbl_BoxDetails where s_BoxBarCode in (select distinct rtrim(ltrim([BOX BARCODE])) from INTER_06022018)
--Box 5
select * from tbl_FileDetails where s_FileBarCode in (select distinct rtrim(ltrim([FILE BARCODE])) from INTER_06022018)
--455


--Missing  Box and File
 

 select * from LAN_06022018 where [BOX BARCODE] not in (
 
														select s_BoxBarCode from tbl_BoxDetails 
														where s_BoxBarCode in (select distinct rtrim(ltrim([BOX BARCODE])) 
														from LAN_06022018)

														)
--Box 0

 --select * from LAN_06022018 where [FILE BARCODE] not in (
 
	--													select s_FileBarCode from tbl_FileDetails 
	--													where s_FileBarCode in (select  ltrim([FILE BARCODE])
	--													from LAN_06022018)

	--													)

-- Not Working

--select * from LAN_06022018 where [FILE BARCODE] not in (

--select [File Barcode] from [2024_Lan]

--)

--select * from tbl_FileDetails where rtrim(s_FileBarCode) in('FLB523004')
--select * from tbl_BoxDetails where rtrim(s_BoxBarCode) in('GA32806')





--File 4
				
