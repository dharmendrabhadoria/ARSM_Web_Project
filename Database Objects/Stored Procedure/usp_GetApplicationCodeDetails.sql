/*
Sp Name      : usp_GetApplicationCodeDetails 
Purpose      : To get the details like Role,Page Name etc.
Created By   : Ajay Tiwari 
Created Date : 5 July-2014
*/
If Exists (Select 1 From sysobjects Where Type = 'P' AND  name = 'usp_GetApplicationCodeDetails')
Begin
	Drop Procedure usp_GetApplicationCodeDetails
End
Go

Create Procedure usp_GetApplicationCodeDetails  
(@ps_AppCode    varchar(20),
 @ps_AppCodeName Varchar(50)
)
As  
Begin  
	SET NOCOUNT ON
	Select	n_AppCodeId	As	'AppCodeId'	,	s_AppCodeName As	'AppCodeName'
	From tbl_ApplicationCodeMaster 	
	Where	   s_AppCode	 = @ps_AppCode 
				And 
		       s_AppCodeName = Case     @ps_AppCodeName 
							   When  '' Then  s_AppCodeName
							   Else			  @ps_AppCodeName End
							   
End  
Go

