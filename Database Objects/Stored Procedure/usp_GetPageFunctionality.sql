/*
Sp Name      :usp_GetPageFunctionality 
Purpose      :To get the page functionality eg. Insert, Delete details by using page functionid.  
Created By   :Rajendra Pawar 
Created Date :28 AUG-2014
*/
If Exists (Select 1 From sysobjects Where Type = 'P' AND  name = 'usp_GetPageFunctionality')
Begin
	Drop Procedure usp_GetPageFunctionality
End
Go
Create Procedure usp_GetPageFunctionality
(
 @pn_PageFunctionId SmallInt ,
 @pn_PageId			SmallInt
)  
As  
Begin  
	SET NOCOUNT ON
	Select n_PageFunctionId	As 'PageFunctionId'   , n_PageId	As	'PageId' , 
		   s_Functionality  As 'Functionality'    , b_Enable    As  'Enable' ,
		   b_IsMenu			As 'IsMenu'     
	From tbl_PageFunctionality
	Where
	b_IsMenu =0
			And
	 n_PageFunctionId = Case @pn_PageFunctionId When 0 
													 Then n_PageFunctionId
													 Else @pn_PageFunctionId  End
		   And
		   n_PageId = Case @pn_PageId When 0 
													 Then n_PageId
													 Else @pn_PageId  End 
							
End  
Go

