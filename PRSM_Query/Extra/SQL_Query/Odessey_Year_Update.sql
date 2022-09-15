

select * from WOData_Odessey88 WO
join tbl_FileDetails TFD on WO.[FILE BARCODE] = TFD.s_FileBarCode

select  WO.[FILE BARCODE],
--WO.[FILE NAME 1],
--TFD.s_Filename
WO.[YEAR],
TFD.s_Year
--WO.[FROM DATE],
--TFD.d_FromDate

--WO.[TO DATE],
--WO.[FILE TYPE]

 from WOData_Odessey88 WO
join tbl_FileDetails TFD on WO.[FILE BARCODE] = TFD.s_FileBarCode


--begin tran
--update TFD set TFD.s_Year = WO.[YEAR]
--select TFD.s_Year,WO.[YEAR]--,TFD.d_FromDate, WO.[FROM DATE],TFD.d_EndDate,WO.[TO DATE]
--,TFD.s_Label1,WO.[FILE TYPE]
--from WOData_Odessey88 WO
--join tbl_FileDetails TFD on WO.[FILE BARCODE] = TFD.s_FileBarCode

--(233 row(s) affected)

--(233 row(s) affected)

--rollback tran

--commit tran