/*
SP Name: usp_GetContractNumber
Description: This stored procedure is used to get the RateCard.  
Created By:  Ajay
Creation Date: 13 Sept 2014

*/
If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_GetContractNumber') 
Begin
   Drop Procedure usp_GetContractNumber
End 
Go

Create Procedure usp_GetContractNumber
As  
Begin  
	 Set NoCount On 
	 Begin Try 
		Declare @ContractNo Int
		Declare @ContractYear Int
		Select @ContractNo = Convert(Int,  CONVERT(Varchar, DATEPART(YEAR,GETDATE()))+'000001')

		If Exists(Select 1  From tbl_ContractMaster )
		Begin
		Select @ContractYear =  CONVERT(Int,Substring(CONVERT(varchar,n_ContractNo),1,4)) From tbl_ContractMaster
		Select @ContractNo =  (MAX(n_ContractNo) +1 ) From tbl_ContractMaster
		If(@ContractYear ! = DATEPART(YEAR,GETDATE()))
		Begin
		Select @ContractNo = Convert(Int,  CONVERT(Varchar, DATEPART(YEAR,GETDATE()))+'000001')
		End
		End
		Select @ContractNo	
	 End Try
	 Begin Catch  
        Exec usp_GetErrorInfo  
     End Catch                          
End

Go
