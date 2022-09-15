/*
SP Name       : usp_GetTaxMasterDetails
Purpose       : This stored procedure is used to get the Tax Master Details.
Created By    : Rajendra Pawar
Creation Date : 23 Sept 2014

*/

If Exists (Select 1 From sysobjects Where Type = 'P' AND  name = 'usp_GetTaxMasterDetails')
Begin
	Drop Procedure usp_GetTaxMasterDetails
End
Go
Create Procedure usp_GetTaxMasterDetails 
(@Pn_TaxId Int)    
As  
Begin  
  SET NOCOUNT ON  
  Select TM.n_TaxId  	As 'TaxId'    ,  TAM.s_AppCodeName As 'TaxName' ,TM.n_TaxValue   AS 'TaxValue'  
  From  tbl_TaxMaster TM
	 Left Join 
  tbl_ApplicationCodeMaster TAM On 
  TM.n_TaxId=TAM.n_AppCodeId 
  Where TM.n_TaxId =    Case @Pn_TaxId  When 0 Then  TM.n_TaxId Else @Pn_TaxId End 
  Order By d_ModifiedDate Asc
    
End  
Go


   