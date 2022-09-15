Declare @n_CustomerId int = 2

Select
	--TWO.n_WorkorderNo
	
	TWA.n_ActivityId , 
	TA.s_ActivityName,
    TWA.n_BoxCount,
    TWA.n_FileCount

	--TBT.n_BoxTransId,
	--TB.n_BoxId

From 
	tbl_WorkOrder  TWO 
	join tbl_WoActivities TWA on TWO.n_WorkorderNo = TWA.n_WorkOrderNo 
	join tbl_Activity TA on TA.n_ActivityId = TWA.n_ActivityId
	--join tbl_BoxTransactions TBA on TBA.n_BoxId =TA.
Where 
	n_CustomerId = @n_CustomerId 
	And TWA.n_ActivityId in (1,2,3) 
Group By TWA.n_ActivityId

select 1895 + 56
select 17880 +423