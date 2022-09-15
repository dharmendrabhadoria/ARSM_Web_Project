
/*
SP Name: usp_GetRowMaster
Description: This stored procedure is used to get the Row Details.  
Created By:  Rajendra Pawar
Creation Date: 24-Feb-2015
*/
If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_GetRowMaster') 
Begin
   Drop Procedure usp_GetRowMaster
End 
Go

Create Procedure usp_GetRowMaster
(
@Pn_WareHouseId TinyInt ,
@pn_RowId SmallInt    
)
As
Begin
  SET NOCOUNT ON
  Begin Try
	Begin
		Select
		 RM.n_RowId				 As 'RowId'					, RM.s_RowName	  As 'RowName' 
      , RM.n_WareHouseId		 As 'WareHouseId'			, RM.n_NoofShelf  As 'NoofShelf' 
      , RM.n_NoOfLocationPerSelf As 'NoOfLocationPerSelf'   , RM.s_Remark	  As 'Remark',
        WH.s_WarehouseName		 As 'WarehouseName' 	 
		From  tbl_RowMaster RM
			Inner Join
		tbl_WareHouseMaster WH 
		On RM.n_WareHouseId = WH.n_WareHouseId 
		Where
		 RM.n_WareHouseId		= Case @Pn_WareHouseId When 0 Then  	WH.n_WareHouseId Else @Pn_WareHouseId End
				And
		 RM.n_RowId		= Case @pn_RowId       When	0  Then		RM.n_RowId  	 Else @pn_RowId	End 
		Order By WH.s_WarehouseName,RM.n_RowId
	End
 End Try  
 Begin Catch  
 Exec usp_GetErrorInfo  
 End Catch 					  											  
End
Go