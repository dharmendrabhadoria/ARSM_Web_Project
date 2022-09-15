/*
SP Name: usp_InsertUpdateServiceCategory
Description: This procedure is used to Add/update in the ServiceCategory.  
Created By:  Rajendra Pawar
Creation Date: 04 Jully 2014
*/
If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_InsertUpdateServiceCategory') 
Begin
   Drop Procedure usp_InsertUpdateServiceCategory
End 
Go

Create Procedure usp_InsertUpdateServiceCategory
(@pn_ServiceCategoryId TinyInt     ,
@ps_SCName			   VarChar(50) ,
@ps_Remark			   VarChar(200),
@pb_IsEdit			   Bit	       ,
@pn_UserId			   SmallInt) 

As  
Begin  
 SET NOCOUNT ON  
 Begin Try
	 If(@pn_ServiceCategoryId = 0)
		Begin
		Insert Into tbl_ServiceCategory
			   (s_SCName  , s_Remark      ,
			    b_IsEdit  , d_ModifiedDate,  n_UserId)
	         Values
			   (@ps_SCName ,  @ps_Remark , 
			    @pb_IsEdit ,  GETDATE() ,      @pn_UserId)
			  
		End
		Else
		Begin
		Update  tbl_ServiceCategory
		   Set s_SCName = @ps_SCName, 
			   s_Remark = @ps_Remark, 
			   b_IsEdit = @pb_IsEdit, 
			   d_ModifiedDate = GETDATE(),
			   n_UserId = @pn_UserId
		 Where n_ServiceCategoryId = @pn_ServiceCategoryId

		End
	 End Try  
 Begin Catch  
	 Exec usp_GetErrorInfo  
 End Catch  
 End
 Go