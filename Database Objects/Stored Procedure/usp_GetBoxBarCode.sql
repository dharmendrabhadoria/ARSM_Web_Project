/*
SP Name: usp_GetBoxBarCode
Description: This stored procedure is used to get the Box Bar code Details.  
Created By:  Ajay
Creation Date: 12-12-2014 
*/
If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_GetBoxBarCode') 
Begin
   Drop Procedure usp_GetBoxBarCode
End 
Go
Create Procedure usp_GetBoxBarCode
(@Pn_CustomerId Int,
 @pn_BoxStatus SmallInt)    
As  
 Begin    
	 SET NOCOUNT ON 
	 Create Table #BoxDetails(BoxId Int ,BoxBarCode Varchar(16))
	 Insert Into #BoxDetails(BoxId  ,BoxBarCode )
     Select n_BoxId  As 'BoxId' , s_BoxBarCode  As 'BoxBarCode'
     From tbl_BoxDetails  Where n_CustomerId  = @Pn_CustomerId
     Select Distinct TB.BoxId,TB.BoxBarCode  From  #BoxDetails TB 
												Inner Join
     										 tbl_FileDetails TF  On TB.BoxId = TF.n_BoxId 
     										 Where TF.n_Status  = Case @pn_BoxStatus
																	When 0 Then n_Status Else @pn_BoxStatus END
										 		
            
            

 End 

Go