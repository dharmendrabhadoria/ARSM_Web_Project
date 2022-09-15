/*
SP Name       : usp_GetCustomerbyCustomerId
Purpose       : This stored procedure is used to get the customer details.
Created By    : Rajendra Pawar
Creation Date : 18 July 2014
Modified By   : Sunil Pandey(05-Jan-2015)Adding two columns s_BillingAddress1,s_BillingAddress2
*/
If Exists (Select 1 From sysobjects Where Type = 'P' AND  name = 'usp_GetCustomerbyCustomerId')
Begin
	Drop Procedure usp_GetCustomerbyCustomerId
End
Go

Create Procedure usp_GetCustomerbyCustomerId
(@pn_CustomerId int)    
As  
Begin 
 
SET NOCOUNT ON  
SELECT 
C.n_CustomerId      		As	'CustomerId'	   ,   C.s_CustomerName			                             As	 'CustomerName'   ,
CG.s_CGName					As  'CompanyGroupName' ,   C.s_BillingAddress1 + ' ' + C.s_BillingAddress2	     AS	 'BillingAddress' ,
SM.n_StateId 				As  'StateId'          ,   CM.n_CityId	 	                                     As  'CityId'         ,
SM.s_StateName 				As  'StateName'        ,   CM.s_CityName 	 	                                 As  'CityName'		  ,
C.s_PinCode				    As	'PinCode'          ,   CG.n_CompanyGroupId		                             As  'CompanyGroupId' ,
s_BillingAddress1           As  'BillingAddress1'  ,   s_BillingAddress2                                     As  'BillingAddress2'              	  
FROM tbl_Customer  C 
Inner Join tbl_CompanyGroup CG   On  C.n_CompanyGroupId = CG.n_CompanyGroupId
Inner Join tbl_StateMaster  SM   On	 C.n_StateId = SM.n_StateId 
Inner Join tbl_CityMaster   CM    On C.n_CityId  = CM.n_CityId 
Where  C.n_CustomerId =   Case @pn_CustomerId  When  0 Then C.n_CustomerId  Else   @pn_CustomerId End	
End  
Go