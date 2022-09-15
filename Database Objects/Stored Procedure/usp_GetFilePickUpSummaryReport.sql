/*
SP Name       : usp_GetFilePickUpSummaryReport
Purpose       : This stored procedure is used to get the file pickup summary report eithr customer wise or department wise
Created By    : Chetan Patel
Creation Date : 26-02-2015
*/

If Exists (Select 1 From sysobjects Where Type = 'P' AND  name = 'usp_GetFilePickUpSummaryReport')
Begin
	Drop Procedure usp_GetFilePickUpSummaryReport
End
Go 

Create Procedure usp_GetFilePickUpSummaryReport
(@pn_CustomerId		Int,
@pd_FromDate		Date,
@pd_ToDate			Date,
@pn_ClientOrDept	Bit)  -- 0 = Client wise, 1 = Department wise
As
Begin      
 SET NOCOUNT ON      
       
 Declare @nBoxActivityId  SmallInt      
 Declare @nFileActivityId SmallInt      
 Declare @WOStatus   SmallInt      
       
 Select @nBoxActivityId = n_ActivityId       
 From tbl_Activity       
 Where s_ActivityName = 'New Standard Box Cost (1.50 Cubic Ft.)'      
       
 Select @nFileActivityId = n_ActivityId       
 From tbl_Activity       
 Where s_ActivityName = 'Bar-coding & Data Entry (File & Box)'      
       
 Select @WOStatus = n_AppCodeId       
 From tbl_ApplicationCodeMaster       
 Where s_AppCode = 'WORKORDER_STATUS' And s_AppCodeName = 'Closed'      
       
 Set @pd_FromDate = ISNULL(@pd_FromDate,Convert(Datetime,'01-01-1900',101))      
 Set @pd_ToDate  = ISNULL(@pd_ToDate, GETDATE())      
       
 If @pn_ClientOrDept = 0      
 Begin      
  Create Table #tempFilePickupSummary      
  (n_CustomerId  Int,      
  s_CustomerName  Varchar(100),      
  n_NoOfBoxes   Int,      
  n_NoOfFiles   Int)       
      
  Insert Into #tempFilePickupSummary Select C.n_CustomerId, C.s_CustomerName,COUNT(BT.n_BoxId),0       
  From tbl_Customer C Inner Join tbl_WorkOrder WO On C.n_CustomerId = WO.n_CustomerId      
  Inner Join tbl_WoActivities WA On WO.n_WorkorderNo = WA.n_WorkOrderNo      
  Inner Join tbl_BoxTransactions BT On BT.n_WoActivityId = WA.n_WoActivityId      
  Where WA.n_ActivityId = @nBoxActivityId       
    And       
     WO.n_CustomerId = ISNULL(@pn_CustomerId,WO.n_CustomerId)       
    And        
     WO.n_Status = @WOStatus        
    And       
     WO.d_ModificationDate Between @pd_FromDate And @pd_ToDate        
  Group by C.n_CustomerId, C.s_CustomerName        
      
  UPdate temp      
  Set n_NoOfFiles = T.n_FileCount      
  From #tempFilePickupSummary temp Inner Join      
  (Select COUNT(FT.n_FileId) As n_FileCount,tFPS.n_CustomerId      
  From #tempFilePickupSummary tFPS Inner Join tbl_WorkOrder WO On tFPS.n_CustomerId = WO.n_CustomerId      
   Inner Join tbl_WoActivities WA On WO.n_WorkorderNo = WA.n_WorkOrderNo      
   Inner Join tbl_FileTransactions FT On WA.n_WoActivityId = FT.n_WoActivityId      
  Where WO.n_Status = @WOStatus And WA.n_ActivityId = @nFileActivityId      
  And WO.d_ModificationDate Between @pd_FromDate And @pd_ToDate      
  Group by tFPS.n_CustomerId) T On T.n_CustomerId = temp.n_CustomerId      
        
  Select n_CustomerId, s_CustomerName, n_NoOfBoxes, n_NoOfFiles  From #tempFilePickupSummary   
  Select Sum(n_NoOfBoxes) As 'NoOfBoxes', Sum(n_NoOfFiles) As 'NoOfFiles' From #tempFilePickupSummary         
 End      
 Else      
 Begin      
  Create Table #tempFilePickupDeptWise      
  (n_DeptId  SmallInt ,      
  s_DeptName  Varchar(100),      
  n_NoOfBoxes  Int,      
  n_NoOfFiles  Int)      
        
  Insert Into #tempFilePickupDeptWise Select FD.n_DepartmentId, AC.s_AppCodeName, COUNT(Distinct BD.n_BoxId), 0      
  From tbl_FileDetails FD Inner Join tbl_BoxDetails BD On FD.n_BoxId = BD.n_BoxId      
   Inner Join tbl_WorkOrder WO On WO.n_CustomerId = BD.n_CustomerId      
   Inner Join tbl_ApplicationCodeMaster AC On FD.n_DepartmentId = AC.n_AppCodeId      
  Where AC.s_AppCode = 'DEPARTMENT' And WO.n_CustomerId = ISNULL(@pn_CustomerId,WO.n_CustomerId)      
  And WO.d_ModificationDate Between @pd_FromDate And @pd_ToDate      
  Group By n_DepartmentId, AC.s_AppCodeName      
        
  UPdate temp      
  Set n_NoOfFiles = T.n_FileCount      
  From #tempFilePickupDeptWise temp Inner Join      
  (Select COUNT(Distinct FT.n_FileId) As n_FileCount, tFPS.n_DeptId      
  From #tempFilePickupDeptWise tFPS Inner Join tbl_FileDetails FD On FD.n_DepartmentId = tFPS.n_DeptId      
  Inner Join tbl_FileTransactions FT On FT.n_FileId = FD.n_FileId      
  Inner Join tbl_WoActivities WA On FT.n_WoActivityId = WA.n_WoActivityId      
  Inner Join tbl_WorkOrder WO On WA.n_WorkOrderNo = WO.n_WorkorderNo         
  Where WO.n_Status = @WOStatus And WA.n_ActivityId = @nFileActivityId      
  And WO.d_ModificationDate Between @pd_FromDate And @pd_ToDate      
   And WO.n_CustomerId = ISNULL(@pn_CustomerId,WO.n_CustomerId)      
  Group by tFPS.n_DeptId) T On T.n_DeptId = temp.n_DeptId      
        
  Select n_DeptId, s_DeptName, n_NoOfBoxes, n_NoOfFiles From #tempFilePickupDeptWise     
  Select Sum(n_NoOfBoxes) As 'NoOfBoxes', Sum(n_NoOfFiles) As 'NoOfFiles' From #tempFilePickupDeptWise      
        
 End      
       
End 

Go

