
/*
Sp Name      :usp_GetMenu 
Purpose      :To get the Menu and SubMenu using RoleId
Created By   :Rajendra Pawar 
Created Date :28 Aug-2014
*/
If Exists (Select 1 From sysobjects Where Type = 'P' AND  name = 'usp_GetMenu')
Begin
	Drop Procedure usp_GetMenu
End
Go
Create Procedure usp_GetMenu
(
 @pn_RoleId SmallInt
)  
As  
Begin  
	SET NOCOUNT ON
	
	Create Table #Temp( n_PageId Int)
	Insert Into  #Temp( n_PageId)
	Select Distinct  TF.n_PageId As 'PageId'
    From  tbl_PageFunctionality TF 
		  Inner Join
		  tbl_RoleWiseAccess    TR On	
		  TF.n_PageFunctionId  = TR.n_PageFunctionId
		  Where TR.n_Enable =1 
		        AND  
		        TR.n_RoleId = @pn_RoleId
		
	Select TF.n_PageFunctionId	As 'MenuId'  ,	 TF.n_PageId	  As	'PageId'  , 
		   TF.s_Functionality   As 'Menu'    ,   TF.b_Enable      As    'Enable'  
	From tbl_PageFunctionality TF
		 Inner Join
		 #Temp    T On 	
		 TF.n_PageId = T.n_PageId 
	Where TF.b_IsMenu	=  1	 
		 
							
End  
Go