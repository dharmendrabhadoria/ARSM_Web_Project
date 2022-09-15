/*
SP Name: usp_InsertUpdateActivity
Description: This procedure is used to Add/update in the Activity.  
Created By:  Rajendra Pawar
Creation Date: 04 July 2014
 1 - 'Per Box Per Month'
 2 - 'Per File'
 3 - 'Per Box'
 4 - 'Per Unit' 
 
*/
If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_InsertUpdateActivity') 
Begin
   Drop Procedure usp_InsertUpdateActivity
End 
Go

Create Procedure usp_InsertUpdateActivity
(@pn_ActivityId		  SmallInt	   ,
@ps_ActivityName	  VarChar(100)  ,
@pn_ServiceCategoryId TinyInt	   ,
@ps_Remark			  Varchar(200) ,
@pb_IsEdit			  Bit	       ,
@pn_UserId			  SmallInt     ,
@pn_Unit              TinyInt      ,
@pn_UnitCount         TinyInt      ,
@pb_IsShowinRateCard  Bit 
)      
As  
Begin  
 SET NOCOUNT ON  
 Begin Try
	 If(@pn_ActivityId = 0)
		Begin
		Insert Into tbl_Activity
           ( s_ActivityName , n_ServiceCategoryId 
           , s_Remark       , b_IsEdit 
           , d_ModifiedDate , n_UserId
           , n_Unit         ,n_UnitCount
           , b_IsShowinRateCard)
         Values
           (@ps_ActivityName , @pn_ServiceCategoryId  
           ,@ps_Remark       , @pb_IsEdit  
           ,GETDATE()        , @pn_UserId 
           ,@pn_Unit         , @pn_UnitCount 
           ,@pb_IsShowinRateCard )
		End
		Else
		Begin
		Update  tbl_Activity
		   Set s_ActivityName		= @ps_ActivityName
			  ,n_ServiceCategoryId  = @pn_ServiceCategoryId
			  ,s_Remark		        = @ps_Remark
			  ,b_IsEdit		        = @pb_IsEdit
			  ,d_ModifiedDate       = GETDATE()
			  ,n_UserId		        = @pn_UserId
			  ,n_Unit               = @pn_Unit
			  ,n_UnitCount          = @pn_UnitCount			  
		 Where n_ActivityId         = @pn_ActivityId

		End
	 End Try  
 Begin Catch  
	 Exec usp_GetErrorInfo  
 End Catch  
 
End
Go
