select * from [20171228_Brics]

select * from tbl_BoxDetails where s_BoxBarCode = 'GA32323'

select * from tbl_FileDetails where n_BoxId = 27468

select * from tbl_FileTransactions where n_FileId in (

	select n_FileId from tbl_FileDetails where n_BoxId = 27468

)



--insert into tbl_FileDetails(n_BoxId,s_FileBarCode,s_FileName,n_BranchId,n_DepartmentId,s_Year,d_FromDate,d_EndDate,
--s_Label1,s_Label2,s_Label3, n_Status,
--d_ModifiedDate,n_ModifiedBy,n_ApproveStatus,s_FileRemarks,d_CheckerDate,n_CheckerBy,
--s_FileDescription1
--)

--select 
--	   27468
--      ,[FILE BARCODE]
--	  ,[FILE NAME 1]
--	  ,40
--	  ,90
--	  ,NULL
--	  ,NULL
--	  ,NULL
--	  ,[FILE TYPE]
--	  ,NULL
--	  ,NULL
--	  ,49
--	  ,'2017-12-28 13:32:37.703'
--	  ,1
--	  ,146
--      ,NULL
--	  ,'2017-12-28 13:39:45.670'
--	  ,1
--      ,[FILE NAME 2]
--	  from [20171228_Brics]  tbl_FileDetails 






--insert into tbl_FileTransactions(n_FileId,n_WoActivityId,d_ModifiedDate,n_ModifiedBy)

--select n_FileId,3962,'2017-12-28 13:32:51.927',1 from tbl_FileDetails where n_FileId not in (

 
--	select n_FileId from tbl_FileTransactions where n_FileId in (

--		select n_FileId from tbl_FileDetails where n_BoxId = 27468

--	)

--)
--and n_BoxId = 27468