/*
SP Name       : usp_GetUserMaster
Purpose       : This stored procedure is used to get user detail by user id.
Created By    : Ajay Tiwari
Creation Date : 5th july 2014
*/

If Exists (Select 1 From sysobjects Where Type = 'P' AND  name = 'usp_GetUserMaster')
Begin
	Drop Procedure usp_GetUserMaster
End
Go

Create Procedure [dbo].[usp_GetUserMaster]
(
 @pn_UserId Int  
)  
As
Begin
SET NOCOUNT ON  
Select TU.n_UserId		    As	'UserId'		,	TU.s_FirstName	   As  'FirstName'		, TU.s_MiddleName  As  'MiddleName'	   ,
		   TU.s_LastName	As  'LastName'		,	TU.d_BirthDate     As  'BirthDate'      , TU.n_Department  As  'Department'	   ,
		   TU.s_Password    As  'Password'		,   TU.b_LoginStatus   As  'Status'         ,
		   TU.n_IsActive    As  'IsActive'		,   TU.n_UserRole      As  'UserRole'       , TR.s_AppCodeName  As  'RoleName'      ,
		   TD.s_AppCodeName As  'DepartmentName',   TU.s_UserName      As  'UserName'       , TU.s_EmailId      As  'EmailId'
	From tbl_UserMaster TU 
		 Left Join tbl_ApplicationCodeMaster  TR On
					TU.n_UserRole   = TR.n_AppCodeId  
		Left Join  tbl_ApplicationCodeMaster  TD On
					TU.n_Department = TD.n_AppCodeId  
	Where n_UserId = Case    @pn_UserId  When  0 
					 Then    n_UserId    Else @pn_UserId 
					 End
End
Go


 