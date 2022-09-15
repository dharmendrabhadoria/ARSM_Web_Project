/*
SP Name: usp_GetDocument
Description: This stored procedure is used to get the Document Details.  
Created By:  Vipul
Creation Date: 23 July 2014
*/
If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_GetDocument') 
Begin
   Drop Procedure usp_GetDocument
End 
Go

Create Procedure usp_GetDocument
(@pn_ContractId Int)    
As   
Begin  
SET NOCOUNT ON  
	Begin Try
		Begin
			Select  D.n_DocumentId       As	'DocumentId',			D.n_ContractId		As	'ContractId',
					D.s_DocumentName     As	'DocumentName',			D.s_Filepath		As	'FilePath'             
			From tbl_Document D 		
			Where n_ContractId	=	Case  @pn_ContractId   
									When  0		Then n_ContractId  
									Else			@pn_ContractId End  			
			Order By D.s_DocumentName Asc
		End
	End Try  
	Begin Catch  
	Exec usp_GetErrorInfo  
	End Catch
End
Go