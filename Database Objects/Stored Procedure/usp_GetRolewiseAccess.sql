/*
SP Name       : usp_GetRolewiseAccess
Purpose       : This stored procedure is used to get rolewise access  details by using role id.
Created By    : Rajendra Pawar
Creation Date : 28 Aug 2014
*/
If Exists (Select 1 From sysobjects Where Type = 'P' AND  name = 'usp_GetRolewiseAccess')
Begin
	Drop Procedure usp_GetRolewiseAccess
End
Go

Create Procedure usp_GetRolewiseAccess
(
 @pn_RoleId SmallInt  
)  
As
Begin
	Create Table #tempRoleWiseAccess(n_RoleWiseAccessId Integer,n_RoleId smallint,
									 n_PageFunctionId   smallint,n_Enable bit)
									 
	Insert Into #tempRoleWiseAccess (n_RoleWiseAccessId	,	n_RoleId	,	n_PageFunctionId	,	n_Enable)
							Select   n_RoleWiseAccessId	,	n_RoleId	,	n_PageFunctionId	,	n_Enable
							From   tbl_RoleWiseAccess
							Where  n_RoleId = @pn_RoleId And n_Enable =  1
											
	Select			T.n_RoleId			As 'RoleId'			, T.n_PageFunctionId		As	'PageFunctionId',
					PF.n_PageId			As 'PageId'			, APC.s_AppCodeName	        As  'PageName'		, 
					PF.b_IsMenu			As 'IsMenu'			, PF.s_Functionality		As 'Functionality' 	 
	From #tempRoleWiseAccess T 
		 Inner Join tbl_PageFunctionality	  PF    On T.n_PageFunctionId   =  PF.n_PageFunctionId  			
		 Inner Join tbl_ApplicationCodeMaster APC	On PF.n_PageId		    =  APC.n_AppCodeId  
	Where APC.s_AppCode = 'Page_Name' 
		  And 
		  PF.b_Enable   = 1  		
			
End
Go