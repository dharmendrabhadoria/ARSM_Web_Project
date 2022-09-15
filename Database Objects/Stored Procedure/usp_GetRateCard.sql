/*
SP Name: usp_GetRateCard
Description: This stored procedure is used to get the RateCard.  
Created By:  Vipul
Creation Date: 07 July 2014
===================================================================
 Alter  Date	   Alter  By		Change Description
=================================================================== 
 14 Augest 2014    Rajendra Pawar   Added From Date and To Date in select statement
*/
If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_GetRateCard') 
Begin
   Drop Procedure usp_GetRateCard
End 
Go
Create Procedure usp_GetRateCard
(@pn_CustomerId		Int,
 @pn_ActivityId       SmallInt)  
As
Begin
  SET NOCOUNT ON
  Begin Try
	If Exists (Select 1 From tbl_RateCard Where n_CustomerId	=	@pn_CustomerId)
		Begin
		Select 			
				ROW_NUMBER() over (order by A.n_ActivityId)	As		'Sr No.',
				A.n_ActivityId								As		'ActivityId',
				SC.s_SCName									As		'Category',
				A.s_ActivityName							As		'Activity',					
				RC.n_Rate									As		'Rate',
				RC.n_RateCardId								As		'RateCardId',
				RC.d_FromDate								As		'FromDate'  ,	
				RC.d_Todate									As		'Todate' 	
			From 
				tbl_Activity A
					Inner Join
				tbl_ServiceCategory  SC  On A.n_ServiceCategoryId	=	SC.n_ServiceCategoryId
					Left Join
				tbl_RateCard RC    On A.n_ActivityId		        =	RC.n_ActivityId        And
				RC.n_CustomerId=@pn_CustomerId
			Where 
				Isnull(A.b_IsShowinRateCard,0) = 1	
				And A.n_ActivityId =
				 Case @pn_ActivityId
				 When 0 then A.n_ActivityId 
				 else @pn_ActivityId end			

		End
	Else
		Begin
			Select 
				ROW_NUMBER() over (order by A.n_ActivityId)	As		'Sr No.',
				A.n_ActivityId								As		'ActivityId',
				SC.s_SCName									As		'Category',
				A.s_ActivityName							As		'Activity',
				'0.00'										As		'Rate',
				''											As		'RateCardId', 
				''											As		'FromDate',
				''											As		'Todate'
			From 
				tbl_Activity A
					Inner Join
				tbl_ServiceCategory  SC  
					On A.n_ServiceCategoryId	=	SC.n_ServiceCategoryId
					Where  Isnull(A.b_IsShowinRateCard,0) = 1	
					And A.n_ActivityId =
				 Case @pn_ActivityId
				 When 0 then A.n_ActivityId 
				 else @pn_ActivityId end
				
		End
 End Try  
 Begin Catch  
 Exec usp_GetErrorInfo  
 End Catch 					  											  
End
Go


