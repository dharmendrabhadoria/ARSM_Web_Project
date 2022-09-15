/*
SP Name: usp_InsertUpdateCompanyMaster
Description: This procedure is used to Add/update in the tbl_CompanyMaster.  
Created By:  Vikas Verma
Creation Date: 20 September 2014
*/
If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_InsertUpdateCompanyMaster') 
Begin
   Drop Procedure usp_InsertUpdateCompanyMaster
End 
Go

Create Procedure usp_InsertUpdateCompanyMaster
(
	@pn_CompanyMasterId			SmallInt,
	@ps_CMName					VarChar(50),
	@pn_IndustryId				SmallInt,
	@ps_RegisterAddress			VarChar(200),
	@pn_StateId					SmallInt,
	@pn_CityId					SmallInt,
	@ps_PinCode		            VarChar(8),
	@ps_Email                   VarChar(50),
    @ps_Telephone               VarChar(15),   
    @ps_Fax                     VarChar(15), 
	@ps_CorpAddress		        VarChar(200),
	@pn_CorpStateId		        SmallInt,
	@pn_CorpCityId			    SmallInt,
	@ps_CorpPinCode		        VarChar(8),
	@ps_CorpEmail               VarChar(50),
    @ps_CorpTelephone           VarChar(15),   
    @ps_CorpFax                 VarChar(15), 
	@ps_PANNumber				VarChar(10),
	@ps_TANNumber				VarChar(25),
	@ps_CINNumber			    VarChar(17), 	
    @ps_VATNumber               VarChar(25),
    @ps_SalesTaxNo              VarChar(25),	
	@pn_UserId					SmallInt,
	@pn_IsCGNameExist           SmallInt Output  
)
As  
Begin  
 SET NOCOUNT ON  
 Begin Try
	 If(@pn_CompanyMasterId = 0)
		Begin
		 If Not Exists( Select	s_CMName	 
		            From  tbl_CompanyMaster 
		            Where s_CMName	=	@ps_CMName	)
		 Begin
	     Insert Into tbl_CompanyMaster
				   (s_CMName,
					n_IndustryId,				s_RegisterAddress,
					n_StateId,					n_CityId,
					s_PinCode,					s_Email,
					s_Telephone,               	s_Fax,                     
					s_CorpAddress,              n_CorpStateId,         
					n_CorpCityId,	            s_CorpPinCode, 
					s_CorpEmail,                s_CorpTelephone,             
					s_CorpFax,                  s_PANNumber,
					s_TANNumber,                s_CINNumber,
					s_VATNumber,                s_SAlesTaxNo,
					d_ModifiedDate,      	    n_UserId)
			Values
				   (@ps_CMName	,
					@pn_IndustryId,				@ps_RegisterAddress,
					@pn_StateId,				@pn_CityId,
					@ps_PinCode,                @ps_Email,
					@ps_Telephone,              @ps_Fax,                  
					@ps_CorpAddress,            @pn_CorpStateId,   
					@pn_CorpCityId,             @ps_CorpPinCode,   
					@ps_CorpEmail,              @ps_CorpTelephone,                    
					@ps_CorpFax,                @ps_PANNumber,
					@ps_TANNumber, 				@ps_CINNumber,       
					@ps_VATNumber,              @ps_SalesTaxNo,        
					GETDATE(),					@pn_UserId) 
					Set @pn_IsCGNameExist=0  
		End
		Else
		Begin
		Set @pn_IsCGNameExist=1 			
		End
		End
	 Else
		Begin
		 If Not Exists( Select	 s_CMName	 
		                From tbl_CompanyMaster 
		                Where	 s_CMName		   =	@ps_CMName		 and 
		                         n_CompanyMasterId  <>	@pn_CompanyMasterId)
		    Begin        
			Update  tbl_CompanyMaster
				Set s_CMName			=	@ps_CMName,
					n_IndustryId		=	@pn_IndustryId,
					s_RegisterAddress	=	@ps_RegisterAddress,
					n_StateId			=	@pn_StateId,
					n_CityId			=	@pn_CityId,
					s_PinCode           =   @ps_PinCode,
					s_Email				=	@ps_Email,
					s_Telephone         =   @ps_Telephone,					
					s_Fax               =   @ps_Fax,  
					s_CorpAddress       =   @ps_CorpAddress,      
					n_CorpStateId       =   @pn_CorpStateId,        
					n_CorpCityId        =   @pn_CorpCityId,	        
					s_CorpPinCode       =   @ps_CorpPinCode,
				    s_CorpEmail			=	@ps_CorpEmail,
					s_CorpTelephone     =   @ps_CorpTelephone,					
					s_CorpFax           =   @ps_CorpFax,  
					s_PANNumber			=	@ps_PANNumber,
					s_TANNumber			=	@ps_TANNumber,
					s_CINNumber         =   @ps_CINNumber,
					s_VATNumber         =   @ps_VATNumber,
					s_SalesTaxNo        =   @ps_SalesTaxNo,					
					d_ModifiedDate		=	GETDATE(),
					n_UserId			=	@pn_UserId
			Where	n_CompanyMasterId	=	@pn_CompanyMasterId
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
