/*
SP Name       : usp_GetWorkOrder
Purpose       : This stored procedure is used to get the Work Order.
Created By    : Vikas Verma
Creation Date : 21 August 2014
Modified By   : Sunil Pandey(12-Jan-2015)Adding Billing address column
*/
If Exists (Select 1 From sysobjects Where Type = 'P' AND  name = 'usp_GetWorkOrder')
Begin
	Drop Procedure usp_GetWorkOrder
End
Go    
CREATE Procedure [dbo].[usp_GetWorkOrder]      
(    
@pn_WorkorderNo  Int      ,   
@pn_CGroupId     Int      ,  
@pn_CustomerId   Int      ,    
@pn_WareHouseId  TinyInt  ,    
@pn_Status       SmallInt ,  
@pd_FromDate     DateTime ,    
@pd_ToDate       DateTime         
)        
As      
Begin      
 SET NOCOUNT ON   
   
 If @pd_FromDate Is Null    
     Set @pd_FromDate = Convert(Datetime,'01-01-1900',101)    
             
  If @pd_ToDate Is Null    
     Set @pd_ToDate = Convert(Datetime,Getdate(),101)     
     
 Select  WO.n_WorkorderNo                  As 'WorkorderNo'          ,  TCG.s_CGName                                        As 'CGName'          ,       
         CONVERT(Varchar,WO.d_WoDate,103)  As 'WorkOrderDate'        ,  TC.n_CustomerId                                     As 'CustomerId'      ,    
         TC.s_CustomerName                 As 'CustomerName'         ,  TWM.n_WareHouseId                                   As 'WareHouseId'     ,    
         TWM.s_WarehouseName               As 'WareHouseName'        ,  TWM.s_WarehouseCode                                 As 'WareHouseCode'   ,    
         WO.s_Remark                       As 'Remarks'              ,  WO.n_WareHouseId                                    As 'WareHouseId'     ,    
         WO.n_Status                       As 'WoStatusId'           ,  ACM.s_AppCodeName                                   As 'WoStatus'        ,
         ''                                As 'Address'              ,  CONVERT(Varchar,WO.d_ModificationDate,103)          As 'ModificationDate',
	     TC.s_BillingAddress1 + ' ' +
	     TC.s_BillingAddress2 + ' ' + ISNULL(CM.s_CityName,'') + ' ' + ISNULL(SM.s_StateName,'')  As 'BillingAddress'
  From tbl_WorkOrder WO     
          Inner Join     
       tbl_Customer TC On WO.n_CustomerId = TC.n_CustomerId    
          Inner Join 
       tbl_CompanyGroup TCG On TCG.n_CompanyGroupId =TC.n_CompanyGroupId
          Inner Join    
       tbl_WareHouseMaster TWM On WO.n_WareHouseId = TWM.n_WareHouseId        
          Inner Join      
       tbl_ApplicationCodeMaster ACM On ACM.n_AppCodeId= WO.n_Status  
           Left Join
       tbl_CityMaster CM On  TC.n_CityId = CM.n_CityId    
         Left Join
       tbl_StateMaster SM On  TC.n_StateId = CM.n_CityId           
            
      Where TCG.n_CompanyGroupId=Case @pn_CGroupId When 0 Then TCG.n_CompanyGroupId  Else @pn_CGroupId  End
      And 
      WO.n_WorkorderNo=Case @pn_WorkorderNo      When  0 Then WO.n_WorkorderNo       Else  @pn_WorkorderNo End    
       And    
      TC.n_CustomerId = Case @pn_CustomerId            When  0 Then TC.n_CustomerId        Else  @pn_CustomerId End         
       And     
      TWM.n_WareHouseId = Case @pn_WareHouseId           When  0 Then TWM.n_WareHouseId      Else  @pn_WareHouseId End    
             And     
       WO.n_Status        = Case @pn_Status                When  0 Then WO.n_Status      Else  @pn_Status End                 
         
       And  
         WO.d_WoDate between @pd_FromDate And @pd_ToDate                          
       Order by Wo.n_WorkorderNo     
             
End 

Go