/*
SP Name: usp_GetWareHouse
Description: This stored procedure is used to get the WareHouse Details.  
Created By:  Vipul
Creation Date: 14 July 2014
Modified By:Sunil Pandey(07-Jan-2015)Adding two new columns like s_Address1 and Address2 
*/
If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_GetWareHouse') 
Begin
   Drop Procedure usp_GetWareHouse
End 
Go

Create Procedure usp_GetWareHouse
@pn_WareHouseId TinyInt    
As
Begin
  SET NOCOUNT ON
  Begin Try
	Begin
		Select  WH.n_WareHouseId					 As		'WareHouseId',
				WH.s_WarehouseName					 As		'WarehouseName',
				WH.s_WarehouseCode					 As		'WarehouseCode',
				WH.n_TotalRows						 As		'TotalRows',
				WH.s_Address1 + ' '+ WH.s_Address2 	 As		'Address',
				WH.n_StateId			             As		'StateId',
				WH.n_CityId							 As		'CityId',
				SM.s_StateName						 As		'StateName',
				CM.s_CityName						 As		'CityName',
				WH.s_Address1						 As     'Address1',
				WH.s_Address2						 As     'Address2'
				
		From tbl_WareHouseMaster WH
		Inner Join
		tbl_CityMaster CM
		On WH.n_CityId	=	CM.n_CityId
		Inner Join
		tbl_StateMaster SM
		On WH.n_StateId	=	SM.n_StateId
		Where WH.n_WareHouseId=	Case @pn_WareHouseId	When 0
								Then WH.n_WareHouseId	Else @pn_WareHouseId End
		Order By s_WarehouseName
	End
 End Try  
 Begin Catch  
 Exec usp_GetErrorInfo  
 End Catch 					  											  
End
Go