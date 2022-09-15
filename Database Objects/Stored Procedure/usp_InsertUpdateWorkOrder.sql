/*
SP Name: usp_InsertUpdateWorkOrder
Description: This procedure is used to Add/update in the workOrder.  
Created By:  Vikas Verma
Creation Date: 22 August 2014
*/
If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_InsertUpdateWorkOrder') 
Begin
   Drop Procedure usp_InsertUpdateWorkOrder
End 
Go

Create Procedure usp_InsertUpdateWorkOrder
(
	@pn_WorkorderNo		 Int OutPut		  ,	
    @pd_WoDate		     DateTime		  ,
    @pn_CustomerId	     Int	          ,
    @ps_Remark           Varchar(500)     ,
    @pn_WareHouseId      TinyInt          ,
    @px_WorkorderList    NVarchar(max)    ,
    @pn_ActivityStatus   SmallInt         ,               
    @pn_Status           SmallInt         ,             
    @pn_ModifiedBy       SmallInt         ,
	@px_RetrvalBoxFile   NVarchar(max)   
)
As  
Begin  
	 Set NoCount On 
	 Begin Transaction;
	 Begin Try 
		
		Declare @WorkorderNo Int
		Declare @WorkOrderYear Int
		

		If Exists(Select 1  From tbl_WorkOrder )
		Begin
			Select @WorkOrderYear =  CONVERT(Int,Substring(CONVERT(varchar,(Select MAX(n_WorkorderNo)  From tbl_WorkOrder)),1,4)) From tbl_WorkOrder
			
			If(@WorkOrderYear ! = DATEPART(YEAR,GETDATE()))
			Begin
				Select @WorkorderNo = Convert(Int,  CONVERT(Varchar, DATEPART(YEAR,GETDATE()))+'000001')
			End
			Else
				Select @WorkorderNo =  (MAX(n_WorkorderNo) +1 ) From tbl_WorkOrder
		End
		Else
			Select @WorkorderNo = Convert(Int,  CONVERT(Varchar, DATEPART(YEAR,GETDATE()))+'000001')
			Select @pn_WorkorderNo = @WorkorderNo		
			 Insert Into tbl_WorkOrder
			 (n_WorkorderNo,
			  d_WoDate,     n_CustomerId,
			  s_Remark,     n_WareHouseId,
			  n_Status,     d_ModificationDate,
			  n_ModifiedBy)
			  Values
			  (
			  @WorkorderNo,
			  @pd_WoDate,     @pn_CustomerId,
			  @ps_Remark,     @pn_WareHouseId,
			  @pn_Status,     GETDATE(),             
			  @pn_ModifiedBy             
			  )
			 
			  Declare @IsErrorinWoActivity TinyInt 
			  Set @IsErrorinWoActivity = 0
			 exec usp_InsertUpdateWoActivities @px_WorkorderList , 0,@pn_ModifiedBy,@pn_ActivityStatus,0,0,@pn_WorkorderNo,@px_RetrvalBoxFile,@IsErrorinWoActivity Output
	    
	    If(@IsErrorinWoActivity =1)
	    Begin
	    RAISERROR ('Error In Inserting Work Order Activity.',
               16, -- Severity.
               1 -- State.
               );
	    End
	    Else
	    Begin	                                                    
	   COMMIT TRANSACTION;
	   
	   End
	 End Try
	 Begin Catch  
        Exec usp_GetErrorInfo  
        IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
	End Catch  
	                   
End
Go


