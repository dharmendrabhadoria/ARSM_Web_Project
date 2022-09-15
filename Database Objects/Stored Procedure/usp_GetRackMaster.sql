/*
SP Name: usp_GetRackMaster
Description: This stored procedure is used to get the Rack Details.  
Created By:  Vipul
Creation Date: 17 July 2014
vikas verma: (19 August 2014) Altered RackName to RowName and retrieved one more field NoofRacks   
*/
If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_GetRackMaster') 
Begin
   Drop Procedure usp_GetRackMaster
End 
Go

Create Procedure usp_GetRackMaster
@pn_RackId SmallInt    
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
				RM.n_NoofRacks             As   'NoofRacks'   ,
				RM.n_RowId				   As   'RowId'		 ,			RM.n_BoxEndNo		 As		'BoxEndNo'	
		From tbl_RackMaster RM
			Inner Join
		tbl_WareHouseMaster WH 
		On RM.n_WareHouseId		=	WH.n_WareHouseId
		Where n_RackId			=	Case   @pn_RackId    
		When		0				Then   n_RackId  
		Else  @pn_RackId			End 
		Order By WH.s_WarehouseName,RM.n_RowId
	End
 End Try  
 Begin Catch  
 Exec usp_GetErrorInfo  
 End Catch 					  											  
End
Go