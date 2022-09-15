/*
SP Name: usp_GetCustomer
Description: This stored procedure is used to get the Customer Details.  
Created By:  Vipul
Creation Date: 07 July 2014
Modified By  : Sunil Pandey(05-Jan-2015)Adding two columns like s_BillingAddress1 and s_BillingAddress2 
*/
If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_GetCustomer') 
Begin
   Drop Procedure usp_GetCustomer
End 
Go

Create Procedure usp_GetCustomer
(@pn_CompanyGroupId SmallInt )  
As
Begin
  SET NOCOUNT ON
  Begin Try
	Begin
		Select	C.n_CustomerId										As		'CustomerId',
				C.s_CustomerName									As		'CustomerName',
				C.n_CompanyGroupId									As		'CompanyGroupId',
				CG.s_CGName											As		'CompanyGroupName',
				C.s_BillingAddress1 + ' ' + C.s_BillingAddress2		As		'BillingAddress',
				C.n_StateId											As		'StateId',
				C.n_CityId											As		'CityId',
				TS.s_StateName										As		'StateName',
				TC.s_CityName										As		'CityName',
				C.s_BillingAddress1									As      'BillingAddress1',
				C.s_BillingAddress2									As      'BillingAddress2'
		From tbl_Customer C
		Inner Join
		tbl_CompanyGroup CG
		On C.n_CompanyGroupId		=		CG.n_CompanyGroupId
		Inner Join
		tbl_StateMaster TS
		on C.n_StateId				=    TS.n_StateId 
		Inner Join
		tbl_CityMaster TC
		On C.n_CityId				=   TC.n_CityId  
		Where C.n_CompanyGroupId	=		Case @pn_CompanyGroupId 
											When 0 Then  	C.n_CompanyGroupId  
											Else			@pn_CompanyGroupId End 
		Order by C.s_CustomerName,CG.s_CGName
	End
 End Try  
 Begin Catch  
 Exec usp_GetErrorInfo  
 End Catch 					  											  
End
Go