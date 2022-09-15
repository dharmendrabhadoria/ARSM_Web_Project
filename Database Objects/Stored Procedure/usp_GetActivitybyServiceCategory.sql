/*
SP Name       : usp_GetActivitybyServiceCategory
Purpose       : This stored procedure is used to get the Get all Activity for using service category.
Created By    : Rajendra Pawar
Creation Date : 16 July 2014
*/
If Exists (Select 1 From sysobjects Where Type = 'P' AND  name = 'usp_GetActivitybyServiceCategory')
Begin
	Drop Procedure usp_GetActivitybyServiceCategory
End
Go

Create Procedure usp_GetActivitybyServiceCategory
(@pn_ServiceCategoryId SmallInt )  
As
Begin
  SET NOCOUNT ON
  Select TA.n_ActivityId		   As 'ActivityId'	      , TA.s_ActivityName As 'ActivityName'
      ,TA.n_ServiceCategoryId      As 'ServiceCategoryId' , TSC.s_SCName      As 'SCName' 
      ,TA.s_Remark				   As 'Remark'			  , TA.b_IsEdit		  As 'IsEdit'
  From tbl_Activity TA  
	    Inner Join
	  tbl_ServiceCategory  TSC  On TA.n_ServiceCategoryId = TSC.n_ServiceCategoryId
  Where TA.n_ServiceCategoryId = @pn_ServiceCategoryId And TA.b_IsShowinRateCard=1
  Order by TSC.s_SCName,TA.s_ActivityName						  
											  
End
Go

