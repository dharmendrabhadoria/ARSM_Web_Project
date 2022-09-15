--Exist WoActivity_ID (915,2010)
select * from tbl_Customer
select * from  tbl_WorkOrder
select * from tbl_WoActivities
Select * from tbl_Activity
Select * from tbl_ApplicationCodeMaster
Select * from tbl_BoxDetails
Select * from tbl_BoxTransactions  where n_WoActivityId in(2121)
Select * from tbl_FileDetails
Select * from tbl_FileTransactions where n_WoActivityId in(2010)
Select * from tbl_BoxFileRetrivaldetails  where n_workOrderActivity in(2121)

Select * from Metro_167_FileRestore

--begin tran
--insert into tbl_WorkOrder(n_WorkorderNo,	d_WoDate,	n_CustomerId,	s_Remark,	n_WareHouseId,	n_Status,	d_ModificationDate,	n_ModifiedBy,	n_RequestNo) 
--			values      (2016000214,	getdate(),	10	,'',	1,	48,	getdate(),	1	,NULL)
--commit

--begin tran
--Insert into tbl_WoActivities(n_WorkOrderNo	,	n_ActivityId,	n_ActivityStatus,	n_BoxCount	,	n_FileCount	,	s_Remark	,	d_ModificationDate	,	n_ModifiedBy	,	n_DepartmentId	,	d_ActivityDate		,	n_PickupAddressId)
--values(						2016000214		,	16			,	53				,	0			,167			,''				,getdate()				,	1				,	NULL			,	NULL				,	16)
--commit

--- File Restore  Regular (within 24 hours) activity

--begin tran
--Insert into tbl_FileTransactions (n_FileId,	n_WoActivityId,	d_ModifiedDate,	n_ModifiedBy)
--Select FD.n_FileID,2121,getdate(),1 from tbl_FileDetails FD
--inner join Metro_167_FileRestore D_FD
--on D_FD.[File Barcode] = FD.s_FileBarCode
--Commit

--begin tran
--Insert into tbl_BoxFileRetrivaldetails (n_IsBoxFile,n_workOrderActivity,s_BoxBarCode,s_FileBarCode,n_ModifiedBy,d_ModifiedDate)
--Select 2,2121,D_FD.[Box Barcode],FD.s_FileBarCode,1,getdate() from tbl_FileDetails FD
--inner join Metro_167_FileRestore D_FD
--on D_FD.[File Barcode] = FD.s_FileBarCode
--Commit


--begin tran
--update tbl_FileDetails set n_Status = 49, n_ApproveStatus = 146 ,d_CheckerDate = getdate(),n_CheckerBy = 1 where n_fileid in (
--Select n_fileid from tbl_FileDetails where n_fileid in (54352,
--54373,
--54374,
--54375,
--54377,
--54378,
--54379,
--54380,
--54550,
--54551,
--54553,
--54554,
--54555,
--54556,
--54557,
--54558,
--54559,
--54560,
--54561,
--54562,
--54563,
--54564,
--54565,
--54566,
--54567,
--54568,
--54569,
--54570,
--54573,
--54575,
--54580,
--54590,
--60784,
--60806,
--60837,
--60921,
--60933,
--60954,
--60956,
--60972,
--60977,
--60978,
--60989,
--60998,
--61032,
--61053,
--61059,
--61063,
--61065,
--61066,
--61067,
--61396,
--61397,
--61398,
--61399,
--61400,
--61401,
--61402,
--61403,
--61404,
--61411,
--61412,
--61418,
--61419,
--61420,
--61421,
--61422,
--61423,
--61424,
--61425,
--61426,
--61427,
--61428,
--61429,
--61430,
--61431,
--61433,
--61434,
--61435,
--61436,
--61437,
--61438,
--61439,
--61440,
--61446,
--61447,
--61448,
--61449,
--61450,
--61451,
--62310,
--62314,
--94087,
--94096,
--94098,
--94125,
--94134,
--94136,
--94137,
--94142,
--94150,
--94258,
--94259,
--94261,
--94270,
--94350,
--94358,
--94394,
--94410,
--94522,
--94550,
--94559,
--94598,
--94603,
--94606,
--94607,
--94610,
--94621,
--94627,
--94653,
--94722,
--94723,
--94764,
--94767,
--94769,
--94776,
--94778,
--94938,
--94941,
--94982,
--94988,
--95203,
--95213,
--95232,
--95249,
--95256,
--95267,
--95269,
--95275,
--95287,
--96917,
--96954,
--96956,
--96966,
--96968,
--96995,
--97079,
--97082,
--97089,
--97097,
--97115,
--97124,
--97147,
--97148,
--97152,
--97156,
--97199,
--97220,
--97222,
--97224,
--97236,
--97238,
--97300,
--97367,
--97413,
--97442,
--97454)


--)
--commit

--begin tran
--update tbl_WoActivities set n_ActivityStatus = 54 where n_WorkOrderNo = 2016000214
--commit

