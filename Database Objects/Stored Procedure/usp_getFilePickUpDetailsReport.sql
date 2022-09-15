
/*
SP Name       : usp_getFilePickUpDetailsReport
Purpose       : This stored procedure is used to get the file pickup report.
Created By    : Ajay Tiwari
Creation Date : 17-02-2015
*/
If Exists (Select 1 From sysobjects Where Type = 'P' AND  name = 'usp_getFilePickUpDetailsReport')
Begin
	Drop Procedure usp_getFilePickUpDetailsReport
End
Go    
Create Procedure usp_getFilePickUpDetailsReport 
(
@pn_CustomerId   Int      ,    
@pn_DeptId		 SmallInt ,        
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
      
  Create Table #tempWorkOrderDetails (n_WONo Int, n_BoxCount Int, n_FileCount Int)    
      
  Insert Into #tempWorkOrderDetails    
     Select     
      Distinct n_WorkOrderNo, 0, 0     
    From tbl_WoActivities WA     
      Inner Join    
            tbl_Activity AC   On WA.n_ActivityId         =  AC.n_ActivityId    
      Left Join     
      tbl_ServiceCategory SC On AC.n_ServiceCategoryId =  SC.n_ServiceCategoryId    
       Where SC.s_SCName = 'File Pick Up'     
       And     
       WA.d_ModificationDate Between @pd_FromDate And @pd_ToDate    
    
    Update TW    
    Set TW.n_BoxCount = T.n_BoxCount    
    From #tempWorkOrderDetails TW Inner Join      
    (Select WA.n_WorkOrderNo, COUNT(BT.n_BoxId) As n_BoxCount    
    From    
    #tempWorkOrderDetails TWD     
    Inner Join     
    tbl_WoActivities WA             On  TWD.n_WONo           =   WA.n_WorkOrderNo    
     Inner Join     
    tbl_BoxTransactions BT          On  WA.n_WoActivityId    =   BT.n_WoActivityId    
    Group By WA.n_WorkOrderNo) As T On  TW.n_WONo            =   T.n_WorkOrderNo    
      
    
    Update TW    
    Set TW.n_FileCount = T.n_FileCount    
    From #tempWorkOrderDetails TW Inner Join      
    (Select WA.n_WorkOrderNo, COUNT(FT.n_FileId) As n_FileCount    
    From    
    #tempWorkOrderDetails TWD Inner Join tbl_WoActivities WA  On TWD.n_WONo = WA.n_WorkOrderNo    
     Inner Join     
    tbl_FileTransactions FT  On WA.n_WoActivityId = FT.n_WoActivityId    
    Group By WA.n_WorkOrderNo) As T On TW.n_WONo = T.n_WorkOrderNo    
             
    Select T.n_WONo   As 'WorkOrderNo', CONVERT(Varchar, WO.d_WoDate,103) As 'WorkOrderDate', TC.s_CustomerName As 'CustomerName', T.n_BoxCount As 'NoOfBoxes', T.n_FileCount As 'NoOfFiles'    
    From #tempWorkOrderDetails T    
      Inner Join     
    tbl_WorkOrder WO            On T.n_WONo = WO.n_WorkorderNo     
       Inner Join    
     tbl_Customer TC            On  WO.n_CustomerId = TC.n_CustomerId    
                
    Where     
    TC.n_CustomerId       =  Case @pn_CustomerId  When  0   Then  TC.n_CustomerId       Else @pn_CustomerId End      
      
    Select  Sum(T.n_BoxCount) As 'NoOfBoxes', Sum(T.n_FileCount) As 'NoOfFiles'    
    From #tempWorkOrderDetails T    
      
    Drop Table #tempWorkOrderDetails    
    
End 
Go