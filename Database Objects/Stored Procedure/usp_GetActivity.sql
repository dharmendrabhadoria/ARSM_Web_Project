/*
SP Name       : usp_GetActivity
Purpose       : This stored procedure is used to get the Get all or single Activity.
Created By    : Rajendra Pawar
Creation Date : 04 July 2014
 1 - 'Per Box Per Month'
 2 - 'Per File'
 3 - 'Per Box'
 4 - 'Per Unit' 
*/
If Exists (Select 1 From sysobjects Where Type = 'P' AND  name = 'usp_GetActivity')
Begin
	Drop Procedure usp_GetActivity
End
Go

Create Procedure usp_GetActivity
(@pn_ActivityId SmallInt )  
As
Begin
  SET NOCOUNT ON
  Select TA.n_ActivityId		   As 'ActivityId'	      , TA.s_ActivityName As 'ActivityName'
      ,TA.n_ServiceCategoryId      As 'ServiceCategoryId' , TSC.s_SCName      As 'SCName' 
      ,TA.s_Remark				   As 'Remark'			  , TA.b_IsEdit		  As 'IsEdit'
      ,TA.n_Unit                   As 'Unit'              , TA.n_UnitCount    As 'UnitCount'
      ,TA.b_IsShowinRateCard       As 'ShowinRateCard'   
  From tbl_Activity TA  
	    Inner Join
	  tbl_ServiceCategory  TSC  On TA.n_ServiceCategoryId = TSC.n_ServiceCategoryId
  Where TA.n_ActivityId = Case @pn_ActivityId 
						  When 0 Then  	TA.n_ActivityId    
						  Else			@pn_ActivityId End 
  Order by TSC.s_SCName,TA.s_ActivityName						  
											  
End
Go
usp_GetActivity 38
select * from tbl_InvoiceDetails

