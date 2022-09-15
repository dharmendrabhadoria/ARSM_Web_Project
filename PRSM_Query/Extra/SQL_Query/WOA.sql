select * from tbl_WorkOrder where n_CustomerId = 176 


Declare @n_CustomerId int = 176

Select
	TWO.n_WorkorderNo
	-- ,
	--TWA.n_ActivityId , 
	--TA.s_ActivityName  
From 
	tbl_WorkOrder  TWO 
	join tbl_WoActivities TWA on TWO.n_WorkorderNo = TWA.n_WorkOrderNo 
	join tbl_Activity TA on TA.n_ActivityId = TWA.n_ActivityId 
Where 
	n_CustomerId = @n_CustomerId 
	And TWA.n_ActivityId in ( 1,2,3) 
Group By TWO.n_WorkOrderNo

select * from tbl_Activity




select * from tbl_customerusermaster 

select * from tbl_CustomerUserDetails 