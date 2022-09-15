/*
Sp Name      :usp_GetDistinctPageFunctionality 
Purpose      :To get the distinct functionality eg.Add,Update,Delete to create heading.  
Created By   :Rajendra Pawar 
Created Date :28 Aug2014
*/
If Exists (Select 1 From sysobjects Where Type = 'P' AND  name = 'usp_GetDistinctPageFunctionality')
Begin
	Drop Procedure usp_GetDistinctPageFunctionality
End
Go
Create Procedure usp_GetDistinctPageFunctionality
As  
Begin  
	SET NOCOUNT ON
	Select  Distinct s_Functionality  As 'Functionality'  
	From tbl_PageFunctionality
	Where b_IsMenu = 0
							
End  
Go