--select  * from INTERSTELLAR_29028112017
--select * from tbl_Customer where n_CustomerId = 38
--select * from  tbl_WorkOrder order by n_WorkorderNo desc 
--select * from  tbl_WorkOrder where n_WorkorderNo = 2017000277
--Select * from tbl_WoActivities  where n_WorkorderNo = 2017000277
--select * from  tbl_WoActivities where n_WorkorderNo = 2018000031
--Select * from tbl_BoxFileRetrivaldetails where n_workOrderActivity in (3948,3949,3950)
--Select * from tbl_BoxFileRetrivaldetails where n_workOrderActivity in (4110,4111,4112)
--Select * from tbl_OtherTransactions where n_WoActivityId in (3948,3949,3950)
--Select * from tbl_Activity
--Select * from tbl_ApplicationCodeMaster


---start---
Declare @n_WorkorderNo int = 2018000031
Declare @ModificationDate datetime = getdate()
Declare @n_CustomerId int = 38
Declare @n_Status int = 47

Declare @n_FileCount_Big int = 7574
Declare @n_FileCount_Small int = 455

insert into tbl_WorkOrder(
							n_WorkorderNo,
							d_WoDate,
							n_CustomerId,
							s_Remark,
							n_WareHouseId,
							n_Status,
							d_ModificationDate,	
							n_ModifiedBy,
							n_RequestNo
						 ) 
					values(
							@n_WorkorderNo		,
							@ModificationDate	,
							@n_CustomerId		,
							''					,	
							1					,
							@n_Status			,
							@ModificationDate	,
							1			,
							NULL
						)

--23	Scanning & Email (Big Amt)
--27    Document Searching & Insertion
--33    File Retrieval
--Select * from tbl_Activity
--Select * from tbl_ApplicationCodeMaster

Insert into tbl_WoActivities(n_WorkOrderNo	,	n_ActivityId,	n_ActivityStatus,	n_BoxCount	,	n_FileCount					,	s_Remark	,	d_ModificationDate		,	n_ModifiedBy	)
values(						@n_WorkorderNo		,	23			,	53				,	0			,@n_FileCount_Big			,''				,	@ModificationDate		,	1				)

Insert into tbl_WoActivities(n_WorkOrderNo	,	n_ActivityId,	n_ActivityStatus,	n_BoxCount	,	n_FileCount					,	s_Remark	,	d_ModificationDate		,	n_ModifiedBy	)
values(						@n_WorkorderNo		,	27			,	53				,	0			,@n_FileCount_Small			,''				,	@ModificationDate		,	1				)

Insert into tbl_WoActivities(n_WorkOrderNo	,	n_ActivityId,	n_ActivityStatus,	n_BoxCount	,	n_FileCount					,	s_Remark	,	d_ModificationDate		,	n_ModifiedBy	)
values(						@n_WorkorderNo		,	33			,	53				,	0			,@n_FileCount_Small			,''				,	@ModificationDate		,	1				)


Declare @n_workOrderActivity int = (Select n_WoActivityId  from tbl_WoActivities  where n_WorkorderNo = @n_WorkorderNo and n_ActivityId = 33 )


Insert into tbl_BoxFileRetrivaldetails (n_IsBoxFile,n_workOrderActivity,s_BoxBarCode,s_FileBarCode,n_ModifiedBy,d_ModifiedDate)
select 2,@n_workOrderActivity,BD.S_BoxBarCode,FD.s_FileBarCode,1,@ModificationDate from tbl_FileDetails FD
inner join Tbl_BoxDetails BD on BD.n_BoxID = FD.n_BoxID 
inner join INTER_06022018 D on D.[FILE BARCODE] = FD.s_FileBarCode
Where n_CustomerID = @n_CustomerId


---End---