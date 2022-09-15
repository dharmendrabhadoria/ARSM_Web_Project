/*
SP Name       : usp_GetContractbyCustomerId
Purpose       : This stored procedure is used to get the customer details.
Created By    : Ajay Tiwari
Creation Date : 20 August 2014
*/
If Exists (Select 1 From sysobjects Where Type = 'P' AND  name = 'usp_GetContractbyCustomerId')
Begin
	Drop Procedure usp_GetContractbyCustomerId
End
Go

Create Procedure usp_GetContractbyCustomerId 
(@pn_CustomerId int)    
As  
Begin 
 SET NOCOUNT ON  
	SELECT 
	cm.n_CustomerId      		As	'CustomerId'	   ,   cm.n_ContractId			 As	 'ContractId'   ,
	cm.n_ContractNo			    As  'ContractNo'       ,   cm.s_Remark	             AS	 'Remark'       ,
	cm.s_DocumentName 			As  'DocumentName'     ,   cm.s_Filepath	 	     As  'Filepath'     ,
	cm.d_FromDate      		    As	'FromDate'	       ,   cm.d_EndDate			     As	 'EndDate'      ,
	cm.n_UserId			        As  'UserId'                	  
	FROM tbl_ContractMaster  cm
	Where  CM.n_CustomerId =   Case @pn_CustomerId  When  0 Then CM.n_CustomerId 
	Else   @pn_CustomerId End			
End 
Go