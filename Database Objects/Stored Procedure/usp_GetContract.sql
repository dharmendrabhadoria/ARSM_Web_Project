/*
SP Name: usp_GetContract
Description: This stored procedure is used to get the Contract Details.  
Created By:  Vipul
Creation Date: 23 July 2014
*/
If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_GetContract') 
Begin
   Drop Procedure usp_GetContract
End 
Go

Create Procedure usp_GetContract 
(@pn_ContractId Int)    
As  
Begin  
SET NOCOUNT ON  
	Begin Try
		Begin
			Select	C.n_ContractId					As 'ContractId',		C.n_ContractNo      As	'ContractNo', 
					CM.s_CustomerName				As 'CustomerName',		C.d_FromDate        As	'FromDate',
					C.d_EndDate						As 'EndDate',			C.s_Remark          As	'Remark',
					UM.s_FirstName + UM.s_LastName  As 'SalesPerson',		C.n_SalesPersonId	As	'SalesPersonId',
					CM.n_CustomerId					As 'CustomerId'
			From tbl_ContarctMaster C 
			Inner Join 
			tbl_Customer     CM 
			On CM.n_CustomerId		=	C.n_CustomerId
			Inner Join 
			tbl_UserMaster   UM 
			On UM.n_UserId			=	C.n_SalesPersonId
			Where n_ContractId		=	Case  @pn_ContractId    
										When  0 Then n_ContractId  
										Else			@pn_ContractId End  			
			Order By C.s_ContractNo Asc
		End
	End Try  
	Begin Catch  
	Exec usp_GetErrorInfo  
	End Catch
End
Go