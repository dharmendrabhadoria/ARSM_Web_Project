
/*
SP Name: usp_GetInvoiceNumber
Description: This procedure is used to get latest Inovice number
Created By:  Rajendra PAwar
Creation Date: 10 Sept 2014
*/
If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_GetInvoiceNumber') 
Begin
   Drop Procedure usp_GetInvoiceNumber
End 
Go

CREATE Procedure usp_GetInvoiceNumber

As  
Begin  
	 Set NoCount On 
	 Begin Try 
		Declare @InvoiceNo Int
		Declare @InvoiceYear Int
		Select @InvoiceNo = Convert(Int,  CONVERT(Varchar, DATEPART(YEAR,GETDATE()))+'000001')

		If Exists(Select 1  From tbl_InvoiceSummary  )
		Begin
		Select @InvoiceYear =  CONVERT(Int,Substring(CONVERT(varchar,n_InvoiceNumber),1,4)) From tbl_InvoiceSummary
		Select @InvoiceNo =  (MAX(n_InvoiceNumber) +1 ) From tbl_InvoiceSummary
		If(@InvoiceYear ! = DATEPART(YEAR,GETDATE()))
		Begin
		Select @InvoiceNo = Convert(Int,  CONVERT(Varchar, DATEPART(YEAR,GETDATE()))+'000001')
		End
		End
		Select @InvoiceNo	
	 End Try
	 Begin Catch  
        Exec usp_GetErrorInfo  
     End Catch       
	                   
End


GO


