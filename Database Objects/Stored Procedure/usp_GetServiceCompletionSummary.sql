
/*
SP Name       : usp_GetServiceCompletionSummary
Purpose       : This stored procedure is used to get the details for requested services.
Created By    : Ajay Tiwari
Creation Date : 11-03-2015
*/
If Exists (Select 1 From sysobjects Where Type = 'P' AND  name = 'usp_GetServiceCompletionSummary')
Begin
	Drop Procedure usp_GetServiceCompletionSummary
End
Go    

Create Procedure usp_GetServiceCompletionSummary
(
@pn_WareHouseId	 SmallInt ,     
@pn_CGroupId     Int      ,  
@pn_CustomerId   Int      ,
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
      
	Create Table #TempServiceCompl(CustomerName Varchar(200) ,TotalWoNo  Int Null,TotalService Int,ComletedService Int Null)
	Insert Into #TempServiceCompl  
	Select [CustomerName] As  'CustomerName',SUM([Count]) As TotalWoNo ,0,0From(
	Select  distinct  TC.s_CustomerName  [CustomerName] ,
	WO.n_WorkorderNo     As 'WorkorderNo'   
	,(1) [Count]
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
      TWM.n_WareHouseId    = Case @pn_WareHouseId     When  0 Then TWM.n_WareHouseId      Else  @pn_WareHouseId End    
           And
      TCG.n_CompanyGroupId = Case @pn_CGroupId        When  0 Then TCG.n_CompanyGroupId   Else @pn_CGroupId  End  
           And   
      TC.n_CustomerId      = Case @pn_CustomerId     When  0 Then TC.n_CustomerId         Else  @pn_CustomerId End 
      	And
	  WO.d_ModificationDate Between @pd_FromDate And @pd_ToDate
	)xx Group By CustomerName
	
	--update total service 
	
	Update  MainTable  
	Set  MainTable.TotalService   =  T.TotalService
	From #TempServiceCompl MainTable
	Inner Join (
    Select [CustomerName] As  'CustomerName',  SUM([Count]) [TotalService] From(
    Select  distinct  SC.s_SCName  As 'RequestedService', TC.s_CustomerName  [CustomerName] 
   ,(1) [Count] 
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
	   TWM.n_WareHouseId    = Case @pn_WareHouseId     When  0 Then TWM.n_WareHouseId      Else  @pn_WareHouseId End    
			   And
	    TCG.n_CompanyGroupId = Case @pn_CGroupId        When  0 Then TCG.n_CompanyGroupId   Else @pn_CGroupId  End  
			   And   
		TC.n_CustomerId      = Case @pn_CustomerId     When  0 Then TC.n_CustomerId         Else  @pn_CustomerId End  
		)X Group By CustomerName)T On MainTable.CustomerName  =   T.CustomerName
      
    ------update total service complted in main table
    
	Update  Temp  
	Set  Temp.ComletedService   =  T.SComletedService
	From #TempServiceCompl Temp
	Inner Join (
    Select [CustomerName] As  'CustomerName',  SUM([Count]) [SComletedService] From(
    Select  distinct  SC.s_SCName  As 'RequestedService', TC.s_CustomerName  [CustomerName] 
   ,(1) [Count] 
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
	   TWM.n_WareHouseId    = Case @pn_WareHouseId     When  0 Then TWM.n_WareHouseId      Else  @pn_WareHouseId End    
			   And
	    TCG.n_CompanyGroupId = Case @pn_CGroupId        When  0 Then TCG.n_CompanyGroupId   Else @pn_CGroupId  End  
			   And   
		TC.n_CustomerId      = Case @pn_CustomerId     When  0 Then TC.n_CustomerId         Else  @pn_CustomerId End 
		And WO.n_Status=46     ----Closed status
	)X Group By CustomerName)T On Temp.CustomerName  =   T.CustomerName
	Select * From #TempServiceCompl
	Select SUM(TotalWoNo) As 'TotalWOCount',Sum(TotalService) As 'TotalServiceCount',Sum(TotalService) As 'TotalCompletionServiceCount' From #TempServiceCompl
    Drop Table #TempServiceCompl
End    
  
Go
  
Go