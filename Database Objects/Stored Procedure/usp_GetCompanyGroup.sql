/*
SP Name       : usp_GetCompanyGroup
Purpose       : This stored procedure is used to get the company group.
Created By    : Rajendra Pawar
Creation Date : 05 July 2014
vikas verma: (13 August 2014) Added three new parameters ContactPerson1,PhoneNumber1,Email1
vikas verma: (12 Septemer 2014) Added seven new parameters CorpAddress,CorpStateId,CorpCityId,PinCode,CorpPincode,MobileNumber,MobileNumber1 
Sunil Pandey(07-Jan-2015)Added four columns like s_RegAddress1,s_RegAddress2,s_CorpAddress1 and s_CorpAddress2
*/
If Exists (Select 1 From sysobjects Where Type = 'P' AND  name = 'usp_GetCompanyGroup')
Begin
	Drop Procedure usp_GetCompanyGroup
End
Go

Create Procedure usp_GetCompanyGroup  
(@pn_CompanyGroupId SmallInt)    
As  
Begin  
 SET NOCOUNT ON  
 Select  CG.n_CompanyGroupId  As 'CompanyGroupId'      , CG.s_CGName			                     As 'CGName'  
      , CG.n_IndustryId       As 'IndustryId'          , CG.s_RegAddress1 + ' ' + CG.s_RegAddress2   As 'RegisterAddress'  
      , CG.n_StateId		  As 'StateId'             , CG.n_CityId			                     As 'CityId' 
      , CG.s_PinCode          As 'PinCode'             , CG.s_CorpAddress1 + ' ' + CG.s_CorpAddress2 As 'CorpAddress'
      , CG.n_CorpStateId      As 'CorpStateId'         , CG.n_CorpCityId							 As 'CorpCityId'
      , CG.s_CorpPinCode      As 'CorpPinCode'         , CG.s_PANNumber								 As 'PANNumber'          
      , CG.s_TANNumber		  As 'TANNumber'           , CG.s_ContactPerson							 As 'ContactPerson'       
      , CG.s_PhoneNumber	  As 'PhoneNumber'         , CG.s_MobileNumber							 As 'MobileNumber'
      , CG.s_Email			  As 'Email'			   , CG.s_ContactPerson1						 As 'ContactPerson1'
      , CG.s_PhoneNumber1	  As 'PhoneNumber1'        , CG.s_MobileNumber1							 As 'MobileNumber1'   
      , CG.s_Email1			  As 'Email1'              , CG.n_UserId								 As 'UserId'               
      , APC.s_AppCodeName	  As 'Industry'	           , CG.s_RegAddress1                            As 'RegAddress1'
      , CG.s_RegAddress2      As 'RegAddress2'         , CG.s_CorpAddress1                           As 'CorpAddress1'
      , CG.s_CorpAddress2     As 'CorpAddress2'
                 
  From tbl_CompanyGroup CG 
			Inner Join
	   tbl_ApplicationCodeMaster APC On CG.n_IndustryId = APC.n_AppCodeId 
  Where n_CompanyGroupId =Case  @pn_CompanyGroupId    
        When  0 Then n_CompanyGroupId  
        Else  @pn_CompanyGroupId End  
			And
		APC.s_AppCode ='INDUSTRY' 	
  Order by s_CGName asc          
End  
Go

