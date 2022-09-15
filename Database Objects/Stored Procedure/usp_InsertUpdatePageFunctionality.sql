/*
SP Name       : usp_InsertUpdatePageFunctionality
Purpose       : This stored procedure is used to add/update Page functionality with page.  
Created By    : Rajendra Pawar
Creation Date : 28 Aug 2014
*/

If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_InsertUpdatePageFunctionality') 
Begin
   Drop Procedure usp_InsertUpdatePageFunctionality 
End 
Go

Create Procedure usp_InsertUpdatePageFunctionality  
(
@pn_PageFunctionId  SmallInt     ,
@pn_PageId           SmallInt    ,
@ps_Functionality    Varchar(20) ,
@pb_Enable           Bit         
)  
As  
Begin  
 SET NOCOUNT ON  
 Begin Try
	If Exists (Select 1 From tbl_PageFunctionality Where n_PageFunctionId = @pn_PageFunctionId )
		Begin
			Update tbl_PageFunctionality Set n_PageId = @pn_PageId,s_Functionality = @ps_Functionality,
											 b_Enable = @pb_Enable,d_ModifiedDate  = GETDATE() 
			Where n_PageFunctionId = @pn_PageFunctionId
	    End	
	    Else
	    Begin
			Insert Into tbl_PageFunctionality
				(n_PageId   , s_Functionality   ,b_Enable   ,  d_ModifiedDate)
			Values
				(@pn_PageId , @ps_Functionality ,@pb_Enable ,  GetDate())	
	    End
 End Try  
 Begin Catch  
	 Exec usp_GetErrorInfo  
 End Catch  
End  
Go