/*
SP Name: usp_InsertUpdateRateCard
Description: This procedure is used to Add/update in the tbl_RateCard.  
Created By:  Vipul
Creation Date: 07 July 2014
===================================================================
 Alter  Date	   Alter  By		Change Description
=================================================================== 
 14 Augest 2014    Rajendra Pawar   Added From Date and To Date  parameter
*/
If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_InsertUpdateRateCard') 
Begin
   Drop Procedure usp_InsertUpdateRateCard
End 
Go

Create Procedure usp_InsertUpdateRateCard
(
	@pn_RateCardId			Int,
	@pn_CustomerId			Int,
	@pn_ActivityId			Smallint,
	@pn_Rate				Decimal(10,2),
	@pn_UserId				Smallint,
	@d_FromDate				DateTime,
	@d_Todate				DateTime
)
As  
Begin  
 SET NOCOUNT ON  
 Begin Try
	 If(@pn_RateCardId = 0)
		Begin
			Insert Into tbl_RateCard
				   (n_CustomerId,		n_ActivityId,		n_Rate,	  d_FromDate,	d_Todate ,						
					d_ModifiedDate,		n_UserId)
			Values
				   (@pn_CustomerId,		@pn_ActivityId,		@pn_Rate, @d_FromDate,	@d_Todate ,			
					GETDATE(),			@pn_UserId)  
		End
	 Else
		Begin
			Update  tbl_RateCard
				Set n_Rate			=	@pn_Rate,
					d_ModifiedDate	=	GETDATE(),
					n_UserId		=	@pn_UserId, 
					d_FromDate		=	@d_FromDate,
					d_Todate		=	@d_Todate
			Where	n_CustomerId	=	@pn_CustomerId	And
			    	n_RateCardId	=	@pn_RateCardId
		End
 End Try  
 Begin Catch  
 Exec usp_GetErrorInfo  
 End Catch                                   
End
Go