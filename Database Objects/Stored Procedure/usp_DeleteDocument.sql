/*
SP Name: usp_DeleteDocument
Description: This stored procedure is used to Delete the Document Details.  
Created By:  Vipul
Creation Date: 25 July 2014
*/
If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_DeleteDocument') 
Begin
   Drop Procedure usp_DeleteDocument
End 
Go

Create Procedure usp_DeleteDocument
(@pn_DocumentId Int)    
As   
Begin  
SET NOCOUNT ON  
	Begin Try
		Begin
			Delete From tbl_Document 		
			Where n_DocumentId	=	@pn_DocumentId
		End
	End Try  
	Begin Catch  
		Exec usp_GetErrorInfo  
	End Catch
End
Go