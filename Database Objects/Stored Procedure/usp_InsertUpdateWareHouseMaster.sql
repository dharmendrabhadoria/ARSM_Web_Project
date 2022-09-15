/*
SP Name: usp_InsertUpdateWareHouseMaster
Description: This procedure is used to Add/update in the tbl_WareHouseMaster.  
Created By:  Vipul
Creation Date: 14 July 2014
Modified By:Sunil Pandey(07-Jan-2015)Adding two columns like s_Address1 and s_Address2
*/
If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_InsertUpdateWareHouseMaster') 
Begin
   Drop Procedure usp_InsertUpdateWareHouseMaster
End 
Go

Create Procedure usp_InsertUpdateWareHouseMaster
(
	@pn_WareHouseId			Tinyint,
	@ps_WarehouseName		Varchar(50),
	@ps_WarehouseCode		Varchar(15),
	@pn_TotalRows			Smallint,
	@ps_Address				Varchar(200),
	@pn_StateId				Smallint,
	@pn_CityId				Smallint,
	@pn_UserId				Smallint,
	@pn_IsWareHouseExist	Int output,
	@ps_Address1            Varchar(50),
	@ps_Address2         	Varchar(50)
)
As  
Begin 
 
 SET NOCOUNT ON  
 Begin Try
	 If(@pn_WareHouseId = 0)
		Begin
			If Exists (Select 1 From tbl_WareHouseMaster Where s_WarehouseName	=	@ps_WarehouseName)
				Begin
					Set @pn_IsWareHouseExist	=     -1
				End
			Else
				Begin
					Insert Into tbl_WareHouseMaster
					   (s_WarehouseName,	s_WarehouseCode,	n_TotalRows,		s_Address,
						n_StateId,			n_CityId,			d_ModifiedDate,		n_UserId,
						s_Address1,         s_Address2)
					Values
					   (@ps_WarehouseName,	@ps_WarehouseCode,	@pn_TotalRows,		@ps_Address,
						@pn_StateId,		@pn_CityId,			GETDATE(),			@pn_UserId,
						 @ps_Address1,      @ps_Address2)
					Set @pn_IsWareHouseExist			=		@@IDENTITY 
				End				
		End
	 Else
		Begin
			If Exists ( Select 1 From tbl_WareHouseMaster 
						Where s_WarehouseName	=	@ps_WarehouseName and n_WareHouseId		!=	@pn_WareHouseId)
				Begin
					Set @pn_IsWareHouseExist	=     -1
				End
			Else
				Begin
					Update  tbl_WareHouseMaster
						Set s_WarehouseName		=	@ps_WarehouseName,	
							s_WarehouseCode		=	@ps_WarehouseCode,	
							n_TotalRows		    =	@pn_TotalRows,		
							--s_Address			=	@ps_Address,
							n_StateId			=	@pn_StateId,			
							n_CityId			=	@pn_CityId,			
							d_ModifiedDate		=	GETDATE(),		
							n_UserId			=	@pn_UserId,
							s_Address1          =   @ps_Address1,
							s_Address2          =   @ps_Address2
					Where	n_WareHouseId		=	@pn_WareHouseId
					Set @pn_IsWareHouseExist	=	@pn_WareHouseId 
				End
		End
 End Try  
 Begin Catch  
 Exec usp_GetErrorInfo  
 End Catch                                   
End
Go