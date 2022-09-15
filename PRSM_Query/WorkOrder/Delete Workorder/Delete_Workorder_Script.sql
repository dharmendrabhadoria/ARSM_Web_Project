select * from tbl_Customer where n_CustomerId = 28
select * from tbl_WorkOrder where n_WorkorderNo = 2018000035

declare @pn_WorkOrderNo int =2018000035


	
/*CHANGE THE BoxFileRetivaldetails TABLE*/
	select * from tbl_BoxFileRetrivaldetails where n_workOrderactivity in (
			
	select TWA.n_WOActivityId  		
		from tbl_WorkOrder TWO 	
			join  tbl_WOActivities TWA on TWO.n_WorkOrderNo = TWA.n_WorkOrderNo 
		where TWO.n_WorkOrderNo = @pn_WorkOrderNo 	
	) 	
	delete from tbl_BoxFileRetrivaldetails where n_workOrderactivity in (
			
	select TWA.n_WOActivityId  		
		from tbl_WorkOrder TWO 	
			join  tbl_WOActivities TWA on TWO.n_WorkOrderNo = TWA.n_WorkOrderNo 
		where TWO.n_WorkOrderNo = @pn_WorkOrderNo 	
	) 	
/*CHANGE THE OtherTransactions TABLE*/
	select * from tbl_othertransactions where n_woactivityid in ( --no rec						
	
	select TWA.n_WOActivityId  		
		from tbl_WorkOrder TWO 	
			join  tbl_WOActivities TWA on TWO.n_WorkOrderNo = TWA.n_WorkOrderNo 
		where TWO.n_WorkOrderNo = @pn_WorkOrderNo 	
	) 	
delete from tbl_othertransactions where n_woactivityid in ( --no rec						
	select TWA.n_WOActivityId  		
		from tbl_WorkOrder TWO 	
			join  tbl_WOActivities TWA on TWO.n_WorkOrderNo = TWA.n_WorkOrderNo 
		where TWO.n_WorkOrderNo = @pn_WorkOrderNo 	
	)  		
		
		
/*CHANGE THE BoxTransactions TABLE*/
	select * from tbl_boxtransactions where n_woactivityid in (  -- no rec																
	
	select TWA.n_WOActivityId  		
		from tbl_WorkOrder TWO 	
			join  tbl_WOActivities TWA on TWO.n_WorkOrderNo = TWA.n_WorkOrderNo 
		where TWO.n_WorkOrderNo = @pn_WorkOrderNo 	
	) 	
	delete from tbl_boxtransactions  where n_woactivityid in (  -- no rec																
	
	select TWA.n_WOActivityId  		
		from tbl_WorkOrder TWO 	
			join  tbl_WOActivities TWA on TWO.n_WorkOrderNo = TWA.n_WorkOrderNo 
		where TWO.n_WorkOrderNo = @pn_WorkOrderNo 	
	) 		
		
		
/*CHANGE THE FileTransactions TABLE*/
	select * from tbl_filetransactions where n_woactivityid in ( 
																		
	select TWA.n_WOActivityId  		
		from tbl_WorkOrder TWO 	
			join  tbl_WOActivities TWA on TWO.n_WorkOrderNo = TWA.n_WorkOrderNo 
		where TWO.n_WorkOrderNo = @pn_WorkOrderNo 	
	) 	
	delete from tbl_filetransactions  where n_woactivityid in ( 
																		
	select TWA.n_WOActivityId  		
		from tbl_WorkOrder TWO 	
			join  tbl_WOActivities TWA on TWO.n_WorkOrderNo = TWA.n_WorkOrderNo 
		where TWO.n_WorkOrderNo = @pn_WorkOrderNo 	
	) 		

delete from tbl_woactivities where n_woactivityid in ( 
																		
	select TWA.n_WOActivityId  		
		from tbl_WorkOrder TWO 	
			join  tbl_WOActivities TWA on TWO.n_WorkOrderNo = TWA.n_WorkOrderNo 
		where TWO.n_WorkOrderNo = @pn_WorkOrderNo 	
	) 	
	
	delete from tbl_workorder 	where n_WorkOrderNo = @pn_WorkOrderNo 