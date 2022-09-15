--exec usp_GetWarehouseMaxRowIdAndBoxStartNo 1
/*
SP Name: usp_GetWarehouseMaxRowIdAndBoxStartNo
Description: This procedure is used to get latest Inovice number
Created By:  Rajendra PAwar
Creation Date: 20 Sept 2014
*/
If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_GetWarehouseMaxRowIdAndBoxStartNo') 
Begin
   Drop Procedure usp_GetWarehouseMaxRowIdAndBoxStartNo
End 
Go

CREATE Procedure usp_GetWarehouseMaxRowIdAndBoxStartNo
(@pn_WareHouseId  TinyInt)
As  
Begin  
	 Set NoCount On 
	 Declare @RowId TinyInt, @BoxStartNo Int
	 Set @RowId = 0
	 Set @BoxStartNo = 0
	Select @RowId = Isnull(MAX(n_RowId),0)  From tbl_RackMaster Where n_WareHouseId = @pn_WareHouseId 
   Select @BoxStartNo =  Isnull(MAX(n_BoxEndNo ),0) From tbl_RackMaster  Where n_WareHouseId =  @pn_WareHouseId  
																						And
																				   n_RowId = @RowId
  Select 	@RowId + 1 As  RowId , @BoxStartNo + 1  As BoxStartNo																			  
  																				  
	                 
End


GO


