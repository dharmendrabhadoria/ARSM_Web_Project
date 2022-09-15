/*
SP Name: usp_InsertUpdateCompanyGroup
Description: This procedure is used to Add/update in the tbl_CompanyGroup.  
Created By:  Vipul More
Creation Date: 04 July 2014
vikas verma: (13 August 2014) Added three new parameters ContactPerson1,PhoneNumber1,Email1 
vikas verma: (12 Septemer 2014) Added seven new parameters CorpAddress,CorpStateId,CorpCityId,PinCode,CorpPincode,MobileNumber,MobileNumber1 
Modified By:Sunil Pandey(6-Jan-2015)Adding four new columns like s_RegAddress1,s_RegAddress2,s_CorpAddress1 and s_CorpAddress2
*/
If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_InsertUpdateCompanyGroup') 
Begin
   Drop Procedure usp_InsertUpdateCompanyGroup
End 
Go

Create Procedure usp_InsertUpdateCompanyGroup
(
	@pn_CompanyGroupId			SmallInt,
	@ps_CGName					VarChar(100),
	@pn_IndustryId				SmallInt,
	@ps_RegisterAddress			VarChar(200),
	@pn_StateId					SmallInt,
	@pn_CityId					SmallInt,
	@ps_PinCode		            VarChar(8),
	@ps_CorpAddress		        VarChar(200),
	@pn_CorpStateId		        SmallInt,
	@pn_CorpCityId			    SmallInt,
	@ps_CorpPinCode		        VarChar(8),
	@ps_PANNumber				VarChar(10),
	@ps_TANNumber				VarChar(25),
	@ps_ContactPerson			VarChar(50),
	@ps_PhoneNumber				VarChar(15),
	@ps_MobileNumber			VarChar(10),
	@ps_Email					VarChar(50),
	@ps_ContactPerson1			VarChar(50),
	@ps_PhoneNumber1			VarChar(15),
	@ps_MobileNumber1			VarChar(10),
	@ps_Email1					VarChar(50),
	@pn_UserId					SmallInt,
	@pn_IsCGNameExist           SmallInt Output,
	@ps_RegAddress1             Varchar(50),
	@ps_RegAddress2             Varchar(50),
	@ps_CorpAddress1            Varchar(50),
	@ps_CorpAddress2            Varchar(50)
)
As  
Begin  
 SET NOCOUNT ON  
 Begin Try
	 If(@pn_CompanyGroupId = 0)
		Begin
		 If Not Exists( Select	s_CGName	 
		            From  tbl_CompanyGroup 
		            Where s_CGName	=	@ps_CGName)
		 Begin
	     Insert Into tbl_CompanyGroup
				   (s_CGName,
					n_IndustryId,				s_RegisterAddress,
					n_StateId,					n_CityId,
					s_PinCode,					s_CorpAddress,      
					n_CorpStateId,              n_CorpCityId,	        
					s_CorpPinCode,              s_PANNumber,			
					s_TANNumber,                s_ContactPerson,
					s_PhoneNumber,              s_MobileNumber,
					s_Email,                    s_ContactPerson1,			
					s_PhoneNumber1,		        s_MobileNumber1,		
					s_Email1,					
					d_ModifiedDate,             n_UserId,
					s_RegAddress1,              s_RegAddress2,
					s_CorpAddress1,             s_CorpAddress2)
			Values
				   (@ps_CGName,
					@pn_IndustryId,				@ps_RegisterAddress,
					@pn_StateId,				@pn_CityId,
					@ps_PinCode,                @ps_CorpAddress,
					@pn_CorpStateId,            @pn_CorpCityId,
					@ps_CorpPinCode,            @ps_PANNumber,				
					@ps_TANNumber,              @ps_ContactPerson,			
					@ps_PhoneNumber,            @ps_MobileNumber,
					@ps_Email,                  @ps_ContactPerson1, 
					@ps_PhoneNumber1,           @ps_MobileNumber1,
					@ps_Email1,                 GETDATE(),
					@pn_UserId,                 @ps_RegAddress1,
					@ps_RegAddress2,            @ps_CorpAddress1,
					@ps_CorpAddress2) 
					Set @pn_IsCGNameExist=0  
		End
		Else
		Begin
		Set @pn_IsCGNameExist=1 			
		End
		End
	 Else
		Begin
		 If Not Exists( Select	 s_CGName	 
		                From tbl_CompanyGroup 
		                Where	 s_CGName		   =	@ps_CGName	 and 
		                         n_CompanyGroupId  <>	@pn_CompanyGroupId)
		    Begin        
			Update  tbl_CompanyGroup
				Set s_CGName			=	@ps_CGName,
					n_IndustryId		=	@pn_IndustryId,
					--s_RegisterAddress	=	@ps_RegisterAddress,
					n_StateId			=	@pn_StateId,
					n_CityId			=	@pn_CityId,
					s_PinCode           =   @ps_PinCode,
					--s_CorpAddress     =   @ps_CorpAddress,      
					n_CorpStateId       =   @pn_CorpStateId,        
					n_CorpCityId        =   @pn_CorpCityId,	        
					s_CorpPinCode       =   @ps_CorpPinCode,					 
					s_PANNumber			=	@ps_PANNumber,
					s_TANNumber			=	@ps_TANNumber,
					s_ContactPerson		=	@ps_ContactPerson,
					s_PhoneNumber		=	@ps_PhoneNumber,
					s_MobileNumber      =   @ps_MobileNumber,
					s_Email				=	@ps_Email,
					s_ContactPerson1	=	@ps_ContactPerson1,
					s_PhoneNumber1		=	@ps_PhoneNumber1,
					s_MobileNumber1     =   @ps_MobileNumber1,
					s_Email1			=	@ps_Email1,
					d_ModifiedDate		=	GETDATE(),
					n_UserId			=	@pn_UserId,
					s_RegAddress1       =   @ps_RegAddress1,
					s_RegAddress2       =   @ps_RegAddress2,
					s_CorpAddress1      =   @ps_CorpAddress1,
					s_CorpAddress2      =   @ps_CorpAddress2
			Where	n_CompanyGroupId	=	@pn_CompanyGroupId
		    Set    @pn_IsCGNameExist=0  
		End
		Else
		Begin
		   Set     @pn_IsCGNameExist=1 	
		End
		
		End
 End Try  
 Begin Catch  
 Exec usp_GetErrorInfo  
 End Catch                                   
End
Go