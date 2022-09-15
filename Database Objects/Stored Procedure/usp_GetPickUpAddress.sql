/*
SP Name       : usp_GetPickUpAddress
Purpose       : This stored procedure is used to get the pickup address of the customer.
Created By    : Rajendra Pawar
Creation Date : 18 July 2014
Modified By	  : Vipul on 15 Dec 2014 to get all pickup address if CutomerID	= 0
Modified By   : Sunil Pandey(4-01-2015)Adding two columns s_Address1 and s_Address2
*/
If Exists (Select 1 From sysobjects Where Type = 'P' AND  name = 'usp_GetPickUpAddress')
Begin
	Drop Procedure usp_GetPickUpAddress
End
Go
Create Procedure usp_GetPickUpAddress    
(@pn_CustomerId Int)      
As    
  Begin   
 SET NOCOUNT ON    
 Select  PA.n_PickupAddressId As  'PickupAddressId',  PA.s_Address1 + ' ' + s_Address2                                As   'Address'		,  PA.n_StateId       As    'StateId'    ,  
         PA.n_CityId          As   'CityId'        ,  PA.n_DepartmentId	   As   'DepartmentId'  ,  PA.s_PinCode	      As    'PinCode'       , 
         APC.s_AppCodeName    As   'Department'    ,  PA.s_Address1        As   'Address1'      ,  PA.s_Address2      As    'Address2'
 FROM tbl_PickupAddress  PA   
		Inner Join
	 tbl_ApplicationCodeMaster APC On    APC.n_AppCodeId = PA.n_DepartmentId  
 Where PA.n_CustomerId = Case	When @pn_CustomerId > 0 
								Then @pn_CustomerId 
								Else PA.n_CustomerId	End
 End    
Go



