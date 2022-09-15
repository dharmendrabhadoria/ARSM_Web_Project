/*
SP Name: usp_InsertUpdateCustomer
Description: This procedure is used to Add/update in the tbl_Customer.  
Created By:  Vipul More
Creation Date: 08 July 2014
Modified By:(Sunil Pandey 02-Jan-2015)Adding two new columns name Address1,Address2

*/
If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_InsertUpdateCustomer') 
Begin
   Drop Procedure usp_InsertUpdateCustomer
End 
Go
Create Procedure usp_InsertUpdateCustomer
(
	@pn_CustomerId				Int          ,
	@ps_CustomerName			Varchar(100) ,
	@pn_CompanyGroupId			Smallint     ,
	@ps_BillingAddress			Varchar(200) ,
	@pn_StateId					Smallint     ,
	@pn_CityId					Smallint     ,
	@ps_PinCode		            Varchar(8)   ,
	@pn_UserId					Smallint     ,
	@ps_BillingAddress1         Varchar(50)  ,
	@ps_BillingAddress2         Varchar(50)  ,
	@pn_MaxCustId               Int output  
)
As  
Begin  
 SET NOCOUNT ON  
 Declare @MaxCustId Int
 Begin Try
	 If(@pn_CustomerId = 0)
		Begin
			If Exists (Select 1 From tbl_Customer Where s_CustomerName	=	@ps_CustomerName)
				Begin
					Set @pn_MaxCustId	=     -1
				End
			Else
				Begin
					Insert Into tbl_Customer
						   (s_CustomerName,			n_CompanyGroupId,		s_BillingAddress,		n_StateId,
							n_CityId,				d_ModifiedDate,			n_UserId       ,        s_PinCode,
							s_BillingAddress1  ,    s_BillingAddress2)
					Values
						   (@ps_CustomerName  ,		@pn_CompanyGroupId ,		@ps_BillingAddress,		@pn_StateId,
							@pn_CityId        ,		GETDATE()          ,		@pn_UserId        ,     @ps_PinCode,
							@ps_BillingAddress1      ,     @ps_BillingAddress2)
							Set @pn_MaxCustId=      @@IDENTITY         
				End
		End
	 Else
		Begin
			If Exists ( Select 1 From tbl_Customer 
						Where s_CustomerName	=	@ps_CustomerName and n_CustomerId	!=		@pn_CustomerId)
				Begin
					Set @pn_MaxCustId	=     -1
				End
			Else
			Begin
				Update  tbl_Customer
					Set s_CustomerName		=	@ps_CustomerName  ,
						n_CompanyGroupId	=	@pn_CompanyGroupId,
						--s_BillingAddress	=	@ps_BillingAddress,
						n_StateId			=	@pn_StateId,
						n_CityId			=	@pn_CityId ,
						d_ModifiedDate		=	GETDATE()  ,
						n_UserId			=	@pn_UserId ,
						s_PinCode           =   @ps_PinCode,
						s_BillingAddress1   =   @ps_BillingAddress1,
						s_BillingAddress2   =   @ps_BillingAddress2
				Where	n_CustomerId	    =	@pn_CustomerId
				
				Select @pn_MaxCustId = @pn_CustomerId 
			End
		End
	
 End Try  
 Begin Catch  
 Exec usp_GetErrorInfo  
 End Catch                                   
End