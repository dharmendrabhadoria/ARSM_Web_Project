/*
SP Name       : usp_InsertUpdateRoleWiseAccess
Purpose       : This stored procedure is used to add/update Rolewise acess with funcationality. 
Created By    : Rajendra Pawar
Creation Date : 28 AUG 2014
*/

If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_InsertUpdateRoleWiseAccess') 
Begin
   Drop Procedure usp_InsertUpdateRoleWiseAccess 
End 
Go

Create Procedure usp_InsertUpdateRoleWiseAccess    
(  
 @pn_RoleId             SmallInt ,  
 @ps_XmlRolewiseAcess   varchar(Max)  
)    
As    
Begin    
 SET NOCOUNT ON    
 Begin Try  
 Create Table #RoleWiseAccess (n_RoleId Int,n_PageFunctionId Int,n_Enable Bit )  
 Declare @docHandle int;  
 Exec sp_xml_preparedocument @docHandle Output, @ps_XmlRolewiseAcess;  
 Insert #RoleWiseAccess Select * From OpenXml(@docHandle, '/NewDataSet/Root',2) With #RoleWiseAccess   
 Exec sp_xml_removedocument @docHandle;  
    
 If Exists (Select 1 From tbl_RoleWiseAccess  Where n_RoleId = @pn_RoleId )  
 Begin  
    Update TR Set TR.n_Enable =	TempTR.n_Enable 
       From tbl_RoleWiseAccess TR Inner Join 
	   #RoleWiseAccess TempTR On
	   TR.n_RoleId		   = TempTR.n_RoleId And
	   TR.n_PageFunctionId = TempTR.n_PageFunctionId  
  Insert Into tbl_RoleWiseAccess  (  n_RoleId  , n_PageFunctionId  ,   n_Enable   ,d_ModifiedDate)    
							  Select n_RoleId  ,  n_PageFunctionId ,   n_Enable   ,GETDATE()   
								 From  #RoleWiseAccess   
								 Where  n_PageFunctionId Not in (Select n_PageFunctionId   
																	From  tbl_RoleWiseAccess Where n_RoleId=@pn_RoleId) 
    End   
    Else  
    Begin  
  Insert Into tbl_RoleWiseAccess  
   (n_RoleId , n_PageFunctionId , n_Enable  ,d_ModifiedDate)    
   Select n_RoleId ,   n_PageFunctionId ,   n_Enable  , GETDATE() From #RoleWiseAccess    
    End  
    Drop Table #RoleWiseAccess  
 End Try    
 Begin Catch    
  Exec usp_GetErrorInfo    
 End Catch    
   
End    
Go