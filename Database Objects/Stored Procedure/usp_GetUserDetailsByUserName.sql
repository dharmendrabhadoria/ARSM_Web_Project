    /*
SP Name		  : usp_GetUserDetailsByUserName
Purpose		  : Get user details by user name and password
Created By	  : Ajay Tiwari
Creation Date : 05-July-2014
*/
If Exists (Select 1 From sysobjects Where type = 'P' AND  name = 'usp_GetUserDetailsByUserName')
Begin
	Drop Procedure usp_GetUserDetailsByUserName
End
Go

Create Procedure usp_GetUserDetailsByUserName
(  
 @ps_UserName  Varchar(15)  ,
 @ps_Password  Varchar(100)     
)    
As  
Begin
SET NOCOUNT ON    
  Select TU.n_UserId	  As  'UserId'        ,   TU.s_FirstName	  As  'FirstName'  , TU.s_MiddleName  As  'MiddleName'    ,  
		 TU.s_LastName	  As  'LastName'      ,   TU.d_BirthDate      As  'BirthDate'  , TU.n_Department  As  'Department'    ,  
		 TU.s_Password    As  'Password'	  ,   TU.b_LoginStatus	  As  'Status'     ,  
		 TU.n_IsActive	  As  'IsActive'	  ,   TU.n_UserRole       As  'UserRole'   , TR.s_AppCodeName As  'RoleName'      ,  
		 TD.s_AppCodeName As  'DepartmentName',   TU.s_UserName		  As  'UserName'   , TU.s_EmailId		  As  'EmailId'	   
 From tbl_UserMaster TU
	  Left Join tbl_ApplicationCodeMaster   TR On  
      TU.n_UserRole   = TR.n_AppCodeId    
	  Left Join  tbl_ApplicationCodeMaster  TD On  
      TU.n_Department = TD.n_AppCodeId 
 Where s_UserName	= @ps_UserName  And
	   s_Password	= @ps_Password         
End  
Go