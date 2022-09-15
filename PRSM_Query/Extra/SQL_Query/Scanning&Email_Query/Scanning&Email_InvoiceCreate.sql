select  * from INTERSTELLAR_29028112017
select * from tbl_Customer where n_CustomerId = 38
select * from  tbl_WorkOrder order by n_WorkorderNo desc 
select * from  tbl_WorkOrder where n_WorkorderNo = 2017000277
Select * from tbl_WoActivities  where n_WorkorderNo = 2017000277
select * from  tbl_WoActivities where n_WorkorderNo = 2017000028
Select * from tbl_BoxFileRetrivaldetails where n_workOrderActivity in (2150,2151,2152)
Select * from tbl_BoxFileRetrivaldetails where n_workOrderActivity in (2284,2285,2286)
Select * from tbl_OtherTransactions where n_WoActivityId in (2150,2151,2152)
Select * from tbl_OtherTransactions where n_WoActivityId in (2284,2285,2286)
Select * from tbl_Activity
Select * from tbl_ApplicationCodeMaster

select * from tbl_InvoiceSummary_New  where n_InvoiceNo = 2016000207
select * from  tbl_InvoiceDetails_New where n_InvoiceNo = 2016000207

--begin tran
--insert into tbl_WorkOrder(n_WorkorderNo,	d_WoDate,	n_CustomerId,	s_Remark,	n_WareHouseId,	n_Status,	d_ModificationDate,	n_ModifiedBy,	n_RequestNo) 
--			values      (2017000278,	    getdate(),	38	,'',	1,	47,	getdate(),	1	,NULL)
----commit

--23	Scanning & Email (Big Amt)
--27    Document Searching & Insertion
--33    File Retrieval

--begin tran
--Insert into tbl_WoActivities(n_WorkOrderNo	,	n_ActivityId,	n_ActivityStatus,	n_BoxCount	,	n_FileCount	,	s_Remark	,	d_ModificationDate	,	n_ModifiedBy	,	n_DepartmentId	,	d_ActivityDate		,	n_PickupAddressId)
--values(						2017000278		,	23			,	53				,	0			,1824			,''				,'2017-11-28 12:42:28.617'				,	1				,	NULL			,	NULL				,	Null)

--Insert into tbl_WoActivities(n_WorkOrderNo	,	n_ActivityId,	n_ActivityStatus,	n_BoxCount	,	n_FileCount	,	s_Remark	,	d_ModificationDate	,	n_ModifiedBy	,	n_DepartmentId	,	d_ActivityDate		,	n_PickupAddressId)
--values(						2017000278		,	27			,	53				,	0			,290			,''				,'2017-11-28 12:42:28.617'			,	1				,	NULL			,	NULL				,	Null)

--Insert into tbl_WoActivities(n_WorkOrderNo	,	n_ActivityId,	n_ActivityStatus,	n_BoxCount	,	n_FileCount	,	s_Remark	,	d_ModificationDate	,	n_ModifiedBy	,	n_DepartmentId	,	d_ActivityDate		,	n_PickupAddressId)
--values(						2017000278		,	33			,	53				,	0			,290			,''				,'2017-11-28 12:42:28.617'			,	1				,	NULL			,	NULL				,	Null)

----commit

--begin tran
--Insert into tbl_BoxFileRetrivaldetails (n_IsBoxFile,n_workOrderActivity,s_BoxBarCode,s_FileBarCode,n_ModifiedBy,d_ModifiedDate)
--select 2,3950,BD.S_BoxBarCode,FD.s_FileBarCode,1,'2017-11-28 12:33:57.520' from tbl_FileDetails FD
--inner join Tbl_BoxDetails BD on BD.n_BoxID = FD.n_BoxID 
--inner join LANDMARK_48228112017 D on D.[FILE BARCODE] = FD.s_FileBarCode
--Where n_CustomerID = 38
----Commit

--begin tran
--Insert Into tbl_OtherTransactions(n_WoActivityId,n_Amount,s_Remarks,d_ModifiedDate,n_ModifiedBy,n_ServiceCount_Old,n_ServiceCount)
--Values(2151,0.00,'',GetDate(),1,1,2537)
--Commit


--begin tran
--Insert tbl_InvoiceSummary_New ( n_InvoiceNo , n_MonthYear, n_WareHouseId, n_customerId , n_pickupaddressid , n_StorageCharges, n_TransAmount , n_InvoiceAmount , n_ServiceTax, n_EduTax, n_OtherTax , n_TotalAmount , d_ModifiedDate, n_ModifiedBy , n_HigherEducation, s_Remark) 
--values  (						2016000207	,201611		,	1			,	32			,	1				,0.00				,0.00		,1228.00				,	171.92	,	6.14	,	6.14	,	1412.2		, Getdate()		,	1			,	0.00			,	NULL)


--begin tran
--Insert Into tbl_InvoiceDetails_New(n_InvoiceNo,n_WoActivityId,n_ActivityCount,n_Amount)
--Values(2016000207,2150,2537,0.00)
--Insert Into tbl_InvoiceDetails_New(n_InvoiceNo,n_WoActivityId,n_ActivityCount,n_Amount)
--Values(2016000207,2151,2537,0.00)
--Insert Into tbl_InvoiceDetails_New(n_InvoiceNo,n_WoActivityId,n_ActivityCount,n_Amount)
--Values(2016000207,2152,136445,0.90)

--Commit