--exec usp_GetLocationDetails 0,0, 'GA-01002%'
/*
SP Name: usp_GetLocationDetails
Description: This stored procedure is used to get the location Details.  
Created By:  Rajendra Pawar
Creation Date: 25-Feb-2015
*/
If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_GetLocationDetails') 
Begin
   Drop Procedure usp_GetLocationDetails
End 
Go

Create Procedure usp_GetLocationDetails
(
@Pn_WareHouseId	 TinyInt	,
@pn_RowId		 SmallInt	,
@s_LocationCode  Varchar(8) 
)
As
Begin
	 SET NOCOUNT ON

	Select  LM.n_LocationId			 As 'LocationId'	  ,	RM.n_RowId			  As 'RowId' 
		  , s_LocationCode			 As 'LocationCode'    , LM.n_BoxCount		  As 'BoxCount' 
		  , n_MaxBoxCount			 As 'MaxBoxCount'	  ,  WH.s_WarehouseName	  As 'WarehouseName',
		   RM.n_RowId				 As 'RowId'			  , RM.s_RowName		  As 'RowName' 
		  , RM.n_WareHouseId		 As 'WareHouseId'	  , RM.n_NoofShelf		  As 'NoofShelf' 
		  , RM.n_NoOfLocationPerSelf As 'NoOfLocationPerSelf'   , RM.s_Remark	  As 'Remark',
		  Isnull(STUFF( (SELECT ',' + TB.s_BoxBarCode 
                             FROM tbl_BoxDetails TB
                             Where TB.s_LocationCode = LM.s_LocationCode  
                             ORDER BY s_LocationCode
                             FOR XML PATH('')), 
                            1, 1, ''),'-') As BoxBarCodes 
	        
	From  tbl_LocationMaster  LM 
			Inner Join 
		  tbl_RowMaster		  RM  On LM.n_RowId = RM.n_RowId 
			Inner Join        
		 tbl_WareHouseMaster WH  On WH.n_WareHouseId = RM.n_WareHouseId 	
	Where
			 RM.n_WareHouseId		= Case @Pn_WareHouseId When 0 Then  	WH.n_WareHouseId Else @Pn_WareHouseId End
					And
			 RM.n_RowId		= Case @pn_RowId       When	0  Then		RM.n_RowId  	 Else @pn_RowId	End 
			 		And
			 LM.s_LocationCode Like  @s_LocationCode
			Order By WH.s_WarehouseName,RM.n_RowId	
		
End		 	



