/*
SP Name: usp_InsertUpdateCityMaster
Description: This procedure is used to Add/update in the tbl_CityMaster.  
Created By:  Vipul
Creation Date: 08 July 2014
*/
If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_InsertUpdateCityMaster') 
Begin
   Drop Procedure usp_InsertUpdateCityMaster
End 
Go

Create Procedure usp_InsertUpdateCityMaster
(
	@pn_CityId		Smallint,
	@ps_CityName	Varchar(40),
	@pn_StateId		Smallint,
	@pn_UserId		Smallint
)
As  
Begin  
 SET NOCOUNT ON  
 Begin Try
	 If(@pn_CityId = 0)
		Begin
			Insert Into tbl_CityMaster
				   (s_CityName,			n_StateId,
					n_UserId,			d_ModifiedDate)
			Values
				   (@ps_CityName,		@pn_StateId,
					@pn_UserId,			GETDATE())  
		End
	 Else
		Begin
			Update  tbl_CityMaster
				Set s_CityName		=	@ps_CityName,
					n_StateId		=	@pn_StateId,
					n_UserId		=	@pn_UserId,
					d_ModifiedDate	=	GETDATE()
			Where	n_CityId		=	@pn_CityId
		End
 End Try  
 Begin Catch  
 Exec usp_GetErrorInfo  
 End Catch                                   
End
Go