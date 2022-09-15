/*
SP Name: usp_InsertUpdateDocument
Description: This procedure is used to Add/update in the tbl_Document.  
Created By:  Vipul
Creation Date: 23 July 2014
*/
If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_InsertUpdateDocument') 
Begin
   Drop Procedure usp_InsertUpdateDocument
End 
Go

Create Procedure usp_InsertUpdateDocument
(
	@pn_DocumentId			Int,
	@pn_ContractId			Int,
	@ps_DocumentName		Varchar(50),
	@ps_Filepath			Varchar(250),
	@pn_UserId				SmallInt
)
As  
Begin  
 SET NOCOUNT ON  
 Begin Try
	If (@pn_DocumentId = 0)
		Begin					
			Insert Into tbl_ContractDocument
				(n_ContractId,		s_DocumentName,		s_Filepath,
				 n_UserId,			d_ModifiedDate)
			Values
				(@pn_ContractId,	@ps_DocumentName,	@ps_Filepath,		
				 @pn_UserId,		GETDATE())
		End
	Else
		Begin
			Update	tbl_ContractDocument
			Set		n_ContractId        =   @pn_ContractId,
					s_DocumentName		=	@ps_DocumentName,
					s_Filepath		    =	@ps_Filepath,	
					d_ModifiedDate		=	GETDATE(),				
					n_UserId	     	=	@pn_UserId				
			Where	n_DocumentId		=   @pn_DocumentId	
		End
 End Try
 Begin Catch
	 Exec usp_GetErrorInfo
 End Catch
End
Go