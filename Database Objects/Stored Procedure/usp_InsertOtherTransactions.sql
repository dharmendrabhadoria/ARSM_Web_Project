/*
SP Name: usp_InsertOtherTransactions
Description: This procedure is used to insert  in the tbl_OtherTransactions.  
Created By:  Vikas Verma
Creation Date: 1 September 2014
*/
If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_InsertOtherTransactions') 
Begin
   Drop Procedure usp_InsertOtherTransactions
End 
Go

Create Procedure usp_InsertOtherTransactions
(
@pn_OtherTransId           Int           ,
@pn_WoActivityId           Int           ,
@pn_ServiceCount           SmallInt      ,
@ps_Remarks                Varchar(500)  ,
@pn_ModifiedBy             SmallInt      ,
@pn_Amount                 Decimal(10,2)       
)      
As  
Begin    
 SET NOCOUNT ON    
 Begin Try  
  If Exists(Select 1 From tbl_OtherTransactions Where  n_WoActivityId = @pn_WoActivityId)  
   Begin  
    --return 'Record Already Exists';  
    Update tbl_OtherTransactions
     Set  n_ServiceCount = @pn_ServiceCount,
		  s_Remarks      = @ps_Remarks     ,     d_ModifiedDate = GetDate()		 ,
		  n_Amount		 = @pn_Amount     ,		 n_ModifiedBy =  @pn_ModifiedBy 
	Where 	 n_WoActivityId = @pn_WoActivityId
	
		Update tbl_WoActivities 
		Set n_FileCount      =   @pn_ServiceCount 
		Where n_WoActivityId  =  @pn_WoActivityId 
   End  
   Else  
   Begin  
    Insert Into tbl_OtherTransactions  
     (n_WoActivityId ,n_ServiceCount,s_Remarks ,d_ModifiedDate ,n_ModifiedBy ,n_Amount)   
     Values  
     (@pn_WoActivityId ,@pn_ServiceCount,@ps_Remarks,GETDATE(),@pn_ModifiedBy,@pn_Amount)  
     
		Update tbl_WoActivities 
		Set n_FileCount      =   @pn_ServiceCount 
		Where n_WoActivityId  =  @pn_WoActivityId 
		
   End  
 End Try    
 Begin Catch    
  Exec usp_GetErrorInfo    
 End Catch     
End  
Go



