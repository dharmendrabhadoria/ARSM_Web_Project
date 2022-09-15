
/*
SP Name: usp_GetWorkOrderNumber
Description: This procedure is used to get latest work order number
Created By:  Ajay Tiwari
Creation Date: 23 August 2014
*/
If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_GetWorkOrderNumber') 
Begin
   Drop Procedure usp_GetWorkOrderNumber
End 
Go

CREATE Procedure usp_GetWorkOrderNumber

As  
Begin  
	 Set NoCount On 
	 Begin Try 
		Declare @WorkorderNo Int
		Declare @WorkOrderYear Int
		Select @WorkorderNo = Convert(Int,  CONVERT(Varchar, DATEPART(YEAR,GETDATE()))+'000001')

		If Exists(Select 1  From tbl_WorkOrder )
		Begin
		Select @WorkOrderYear =  CONVERT(Int,Substring(CONVERT(varchar,n_WorkorderNo),1,4)) From tbl_WorkOrder
		Select @WorkorderNo =  (MAX(n_WorkorderNo) +1 ) From tbl_WorkOrder
		If(@WorkOrderYear ! = DATEPART(YEAR,GETDATE()))
		Begin
		Select @WorkorderNo = Convert(Int,  CONVERT(Varchar, DATEPART(YEAR,GETDATE()))+'000001')
		End
		End
		Select @WorkorderNo	
	 End Try
	 Begin Catch  
        Exec usp_GetErrorInfo  
     End Catch       
	                   
End


GO


