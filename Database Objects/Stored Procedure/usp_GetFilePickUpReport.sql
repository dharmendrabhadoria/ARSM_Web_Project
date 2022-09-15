
/*
SP Name       : usp_GetFilePickUpReport
Purpose       : This stored procedure is used to get the file pickup report.
Created By    : Rajendra Pawar
Creation Date : 30-01-2015
*/
If Exists (Select 1 From sysobjects Where Type = 'P' AND  name = 'usp_GetFilePickUpReport')
Begin
	Drop Procedure usp_GetFilePickUpReport
End
Go    
  
CREATE Procedure usp_GetFilePickUpReport        
(    
@pn_CGroupId     Int      ,    
@pn_CustomerId   Int      ,      
@pn_WareHouseId  TinyInt  ,   
@pn_DeptId   SmallInt ,        
@pn_PickupAddressId   Int ,        
@pd_FromDate     DateTime ,      
@pd_ToDate       DateTime  ,  
@IsDateRange  TinyInt  ,  -- 1 For DateWise 2 For Periodicwise  
@Year    Int       , --     
@pn_ReportBy  TinyInt       , -- 1 Client 2 -Work Order   
@Perodicwise  TinyInt  -- 1 -Monthly 2- Quartly 3 - Half Yearly 4- Yearly  
)  
As        
Begin        
 SET NOCOUNT ON   
 Declare @n_ActivityId SmallInt  
 Select @n_ActivityId =n_ActivityId From tbl_Activity Where s_ActivityName='Bar-coding & Data Entry (File & Box)'  
  If @pd_FromDate Is Null      
   Set @pd_FromDate = Convert(Datetime,'01-01-1900',101)      
                
   If @pd_ToDate Is Null      
   Set @pd_ToDate = Convert(Datetime,Getdate(),101)    
        
   Create Table #FilPickupDetails(    WorkorderNo  Int   ,  WorkOrderDate DateTime,     
           CustomerName Varchar(200),  BoxBarCode Varchar(16),  
           FileBarCode  Varchar(16) , FilePickUpDate DateTime,  
           Department   Varchar(100),  PickUpAddress Varchar(200))  
 Insert Into #FilPickupDetails(WorkorderNo,WorkOrderDate,CustomerName,BoxBarCode,FileBarCode,FilePickUpDate,Department,PickUpAddress)               
 Select  
    WO.n_WorkorderNo                  As 'WorkorderNo'          ,  WO.d_WoDate   As 'WorkOrderDate'  ,  
    TC.s_CustomerName       As 'CustomerName'         ,           
    TB.s_BoxBarCode       As 'BoxBarCode'    , TF.s_FileBarCode As 'FileBarCode'  ,  
    TWA.d_ActivityDate       As 'FilePickUpDate'   ,   
    IsNull(TAP.s_AppCodeName,'')    As 'Department'    ,  Isnull(TP.s_Address1,'')+ ' ' +Isnull(TP.s_Address2,'')        As 'PickUpAddress'   
            
 From     tbl_WorkOrder WO       
        Inner Join  
       tbl_WoActivities TWA   On WO.n_WorkorderNo = TWA.n_WorkOrderNo    
        Inner Join   
       tbl_Activity    TA     On TWA.n_ActivityId  = TA.n_ActivityId    
      Inner Join       
       tbl_Customer TC      On WO.n_CustomerId = TC.n_CustomerId      
      Inner Join   
       tbl_CompanyGroup TCG On TCG.n_CompanyGroupId =TC.n_CompanyGroupId  
      Inner Join      
       tbl_WareHouseMaster TWM On WO.n_WareHouseId = TWM.n_WareHouseId          
      Inner Join        
       tbl_ApplicationCodeMaster ACM On ACM.n_AppCodeId= WO.n_Status    
      Left Join      
       tbl_ApplicationCodeMaster  TAP   On  TWA.n_DepartmentId = TAP.n_AppCodeId    
        Left  Join  
    tbl_PickupAddress    TP     On  TWA.n_PickupAddressId   =  TP.n_PickupAddressId      
     Inner Join                 
    tbl_BoxDetails      TB     On  TB.n_CustomerId = WO.n_CustomerId   
     Inner Join  
    tbl_FileDetails        TF     On  TB.n_BoxId = TF.n_BoxId   
     Inner Join  
    tbl_FileTransactions        TFT     On   TFT.n_FileId = TF.n_FileId And  TFT.n_WoActivityId = TWA.n_WoActivityId    
 Where TWA.n_ActivityId  = @n_ActivityId    
      And  
    TCG.n_CompanyGroupId=Case @pn_CGroupId When 0 Then TCG.n_CompanyGroupId  Else @pn_CGroupId  End  
      And      
    TC.n_CustomerId = Case @pn_CustomerId            When  0 Then TC.n_CustomerId        Else  @pn_CustomerId End           
      And       
    TWM.n_WareHouseId = Case @pn_WareHouseId           When  0 Then TWM.n_WareHouseId      Else  @pn_WareHouseId End      
      And    
    WO.d_WoDate between @pd_FromDate And @pd_ToDate    
      And   
    DATEPART(Year ,TWA.d_ModificationDate) = Case @IsDateRange When 1 Then DATEPART(Year ,TWA.d_ModificationDate) Else @Year End   
   
 Select  
  CustomerName, Count(FileBarCode) TotalPickUpFiles    
 From #FilPickupDetails Group by CustomerName  
   
 Select  
  WorkorderNo, Count(FileBarCode) TotalPickUpFiles    
 From #FilPickupDetails Group by WorkorderNo  
   
  
 Select  
  Department, Count(FileBarCode) TotalPickUpFiles    
 From #FilPickupDetails Group by Department  
Select  
  WorkorderNo  , Convert(varchar,WorkOrderDate,103) As WorkOrderDate ,  
  CustomerName , BoxBarCode,  
  FileBarCode  , CONVERT(Varchar,FilePickUpDate,103) As FilePickUpDate,  
  Department  ,PickUpAddress  
 From #FilPickupDetails  
   
 Select  
  Isnull(Count(FileBarCode),0) As GrandTotal    
 From #FilPickupDetails  
 Drop table #FilPickupDetails  
End   
Go