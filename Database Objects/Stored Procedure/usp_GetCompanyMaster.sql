/*
SP Name       : usp_GetCompanyMaster
Purpose       : This stored procedure is used to get the company master.
Created By    : Vikas Verma
Creation Date : 20 September 2014
*/
If Exists (Select 1 From sysobjects Where Type = 'P' AND  name = 'usp_GetCompanyMaster')
Begin
	Drop Procedure usp_GetCompanyMaster
End
Go

Create Procedure usp_GetCompanyMaster  
(@pn_CompanyMasterId SmallInt)    
As  
Begin  
 SET NOCOUNT ON  
 Select 
       CM.n_CompanyMasterId   As 'CompanyMasterId'     , CM.s_CMName			As 'CMName'  
      , CM.n_IndustryId       As 'IndustryId'          , CM.s_RegisterAddress   As 'RegisterAddress'  
      , CM.n_StateId		  As 'StateId'             , CM.n_CityId			As 'CityId' 
      , CM.s_PinCode          As 'PinCode'             , CM.s_Email             As 'Email'
      , CM.s_Telephone        As 'PhoneNumber'         , CM.s_Fax               As 'FaxNumber'         
      , CM.s_CorpAddress      As 'CorpAddress'         , CM.n_CorpStateId       As 'CorpStateId'        
      , CM.n_CorpCityId       As 'CorpCityId'          , CM.s_CorpPinCode       As 'CorpPinCode'     
      , CM.s_CorpEmail        As 'CorpEmail'           , CM.s_CorpTelephone     As 'CorpPhoneNumber'        
      , CM.s_CorpFax          As 'CorpFaxNumber'       , CM.s_PANNumber         As 'PANNumber'          
      , CM.s_TANNumber		  As 'TANNumber'           , CM.s_CINNumber			As 'CINNumber'	                      	
      , CM.s_VATNumber        As 'VATNumber'           , CM.s_SalesTaxNo        As 'SalesNumber' 
      , CM.n_UserId			  As 'UserId'              , APC.s_AppCodeName	    As 'Industry'	 
  From tbl_CompanyMaster CM 
			Inner Join
	   tbl_ApplicationCodeMaster APC On CM.n_IndustryId = APC.n_AppCodeId 
  Where n_CompanyMasterId =Case  @pn_CompanyMasterId    
        When  0 Then n_CompanyMasterId  
        Else  @pn_CompanyMasterId End  
			And
		APC.s_AppCode ='INDUSTRY' 	
  Order by s_CMName asc          
End  
Go




