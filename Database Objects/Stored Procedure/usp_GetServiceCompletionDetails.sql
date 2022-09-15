
/*
SP Name       : usp_GetServiceCompletionDetails
Purpose       : This stored procedure is used to get the details for requested service which status is closed.
Created By    : Ajay Tiwari
Creation Date : 11-03-2015
*/
If Exists (Select 1 From sysobjects Where Type = 'P' AND  name = 'usp_GetServiceCompletionDetails')
Begin
	Drop Procedure usp_GetServiceCompletionDetails
End
Go    

Create Procedure usp_GetServiceCompletionDetails
(
@pn_WareHouseId	 SmallInt ,     
@pn_CGroupId     Int      ,  
@pn_CustomerId   Int      ,
@Pn_WorkOrderNo  Int      ,
@pd_FromDate     DateTime = null,      
@pd_ToDate       DateTime = null           
)     
As  
Begin  
  SET NOCOUNT ON  
  	If @pd_FromDate Is Null    
	 Set @pd_FromDate = Convert(Datetime,'01-01-1900',101)        
	If @pd_ToDate Is Null    
	 Set @pd_ToDate = Convert(Datetime,Getdate(),101) 
  Declare @Status  SmallInt  ----status for Only Closed Work Order
  Select @Status = n_AppCodeId  From tbl_ApplicationCodeMaster Where s_AppCode = 'WORKORDER_STATUS' And s_AppCodeName ='Closed'  Select  distinct TC.s_CustomerName                   As 'CustomerName'       ,  SC.s_SCName                       As 'RequestedService'   ,  
          WO.n_WorkorderNo                            As 'WorkorderNo'        ,  CONVERT(Varchar,WO.d_WoDate,103)   As  'WorkOrderDate'     ,
          CONVERT(Varchar,WO.d_ModificationDate,103)  As 'CompletionDate'     ,  TC.n_CustomerId                    As 'CustomerId'
  From tbl_WorkOrder WO       
  	        Inner Join 
	   tbl_WoActivities WA    On WO.n_WorkorderNo=WA.n_WorkOrderNo 
		 Inner Join
		tbl_Activity AC 	   On WA.n_ActivityId         =  AC.n_ActivityId
		   Left Join 
	    tbl_ServiceCategory SC On AC.n_ServiceCategoryId =  SC.n_ServiceCategoryId  
	       Left Join
       tbl_Customer TC On WO.n_CustomerId = TC.n_CustomerId      
          Inner Join   
       tbl_CompanyGroup TCG On TCG.n_CompanyGroupId =TC.n_CompanyGroupId  
          Inner Join      
       tbl_WareHouseMaster TWM On WO.n_WareHouseId = TWM.n_WareHouseId          
          Inner Join        
       tbl_ApplicationCodeMaster ACM On ACM.n_AppCodeId= WO.n_Status  
      Where 
      TWM.n_WareHouseId     = Case @pn_WareHouseId     When  0 Then TWM.n_WareHouseId     Else  @pn_WareHouseId End    
            And
      TCG.n_CompanyGroupId  = Case @pn_CGroupId        When  0 Then TCG.n_CompanyGroupId  Else @pn_CGroupId     End  
           And   
      TC.n_CustomerId       =  Case @pn_CustomerId     When  0 Then TC.n_CustomerId       Else  @pn_CustomerId  End         
           And
       WO.n_WorkorderNo     =  Case @Pn_WorkOrderNo    When  0 Then WO.n_WorkorderNo      Else  @Pn_WorkOrderNo End         
           And
	   WO.d_ModificationDate Between @pd_FromDate And @pd_ToDate
       And   WO.n_Status     = @Status                    
      Order by Wo.n_WorkorderNo   
 
End    
  
Go