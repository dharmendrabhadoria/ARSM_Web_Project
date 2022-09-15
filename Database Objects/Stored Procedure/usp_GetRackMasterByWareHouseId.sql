/*
SP Name: usp_GetRackMasterByWareHouseId
Description: This stored procedure is used to get the WareHouse Details by WareHouseId.  
Created By:  Vipul
Creation Date: 17 July 2014
Alter by :vikas verma
Alter Date: 18/08/2014  Added Noof Racks and  change RackName as RowName
*/
If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_GetRackMasterByWareHouseId') 
Begin
   Drop Procedure usp_GetRackMasterByWareHouseId
End 
Go

Create Procedure usp_GetRackMasterByWareHouseId
@pn_WareHouseId TinyInt    
As
Begin
  SET NOCOUNT ON
  Begin Try
	Begin
		Select	RM.n_RackId				   As	'RackId',				RM.s_RowName		 As     'RowName',
				WH.s_WarehouseName         As   'WareHouseName',		RM.n_NoofShelf	     As 	'NoofShelf',
				RM.n_NoofBoxesPerShelf     As   'NoofBoxesPerShelf',	RM.n_BoxStartNo      As     'BoxStartNo',
				RM.s_Remark				   As   'Remark',				RM.n_Height			 As		'Height',				
				RM.n_Width				   As   'Width',				RM.n_Depth			 As		'Depth',
				RM.d_ModifiedDate		   As	'ModifiedDate',			RM.n_UserId			 As		'UserId',
				RM.n_NoofRacks             As   'NoofRacks'
		From tbl_RackMaster RM
			Inner Join
		tbl_WareHouseMaster WH 
		On RM.n_WareHouseId		=	WH.n_WareHouseId
		Where RM.n_WareHouseId	=	Case   @pn_WareHouseId    
		When             0			Then   RM.n_WareHouseId  
		Else  @pn_WareHouseId		End 
	End
 End Try  
 Begin Catch  
 Exec usp_GetErrorInfo  
 End Catch 					  											  
End
Go