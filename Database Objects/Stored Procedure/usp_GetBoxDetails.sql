/*
SP Name       : usp_GetBoxDetails
Purpose       : This stored procedure is used to get the Box Details.
Created By    : Rajendra Pawar
Creation Date : 23 August 2014

*/
If Exists (Select 1 From sysobjects Where Type = 'P' AND  name = 'usp_GetBoxDetails')
Begin
	Drop Procedure usp_GetBoxDetails
End
Go
Create Procedure usp_GetBoxDetails  
(
@pn_BoxId		 Int, 	
@pn_CustomerId   Int,
@pn_WareHouseId  TinyInt,
@pn_Status		 SmallInt 
)    
As  
Begin  
 SET NOCOUNT ON  
  Select distinct  BO.n_BoxId	 As 'BoxId'		   ,BO.s_BoxBarCode      As 'BoxCode'		    , 
		 BO.n_CustomerId	     As 'CustomerId'   ,BO.n_WareHouseId     As 'WareHouseId'       ,
		 BO.n_LocationId		 As 'LocationId'    ,BO.s_LocationCode	 As 'LocationCode'	    ,
         BO.n_Status		     As 'BoxStatus'    ,ACM.s_AppCodeName    As  'BoxStatusName'    ,
         TC.s_CustomerName       As 'CustomerName' ,TWM.n_WareHouseId	 As 'WareHouseId'       ,
         TWM.s_WarehouseName     As 'WareHouseName',TWM.s_WarehouseCode  As 'WareHouseCode'
  From tbl_BoxDetails BO 
          Inner Join 
       tbl_Customer TC On BO.n_CustomerId = TC.n_CustomerId
          Inner Join 
       tbl_WareHouseMaster TWM On BO.n_WareHouseId = TWM.n_WareHouseId    
          Inner Join  
       tbl_ApplicationCodeMaster ACM On ACM.n_AppCodeId= BO.n_Status 
 Where BO.n_BoxId		  = Case @pn_BoxId				   When  0 Then BO.n_BoxId             Else  @pn_BoxId End
							And
		TC.n_CustomerId   = Case @pn_CustomerId	           When  0 Then TC.n_CustomerId        Else  @pn_CustomerId End     
							And 
		TWM.n_WareHouseId = Case @pn_WareHouseId           When  0 Then TWM.n_WareHouseId      Else  @pn_WareHouseId End
        					And 
       BO.n_Status        = Case @pn_Status                When  0 Then BO.n_Status			   Else  @pn_Status End        					
         
End  
Go


   