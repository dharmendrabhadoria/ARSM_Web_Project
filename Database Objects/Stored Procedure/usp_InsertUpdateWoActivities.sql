/*
Version 1.1
Created By Ajay Tiwari 24 Feb-2015
*/

If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_InsertUpdateWoActivities') 
Begin
   Drop Procedure usp_InsertUpdateWoActivities
End 
Go

Create  Procedure usp_InsertUpdateWoActivities
(              
 @px_WorkorderList     NVarchar(max)   ,                
 @pn_WoActivityId      Int            ,              
 @pn_ModifiedBy        SmallInt       ,          
 @pn_ActivityStatus    SmallInt	      ,
 @pn_BoxCount		   Int		      ,
 @pn_FileCount		   Int			  ,		
 @pn_WorkorderNo	   Int            ,
 @px_RetrvalBoxFile   NVarchar(max)   ,     
 @IsLogError		 TinyInt   Output                          
)              
As              
Begin              
   Set NoCount On                  
   Begin Try              
    If(@pn_WoActivityId = 0)              
    Begin            
    Create Table #WorkorderActivity(SrNo		Int,		 ActivityId			Int,	       ActivityStatus   Int,
									Remark		Varchar(500),NoOfBox			Int,	       NoOfFile		    Int,
								    WorkOrderNo Int			,d_ModificationDate DateTime,      UserId			Int,
								    DepartmentId SmallInt	,ActivityDate       varchar(20),   PickUpAddressId  Int,
																	    )               
    Create Table #RetrivalBoxList(SrNo Int, ActivityId Int, BoxBarCode varchar(16),FileBarCode varchar(16) NULL,PickUpAddressId Int)
	Declare @docHandle	Int; 
	Declare @docHandle1 Int; 
	Declare @S			Nvarchar(Max)
	Declare @S1			Nvarchar(Max)
	Set @S = CONVERT(Nvarchar(Max),@px_WorkorderList)                 
	Set @S1= CONVERT(Nvarchar(Max),@px_RetrvalBoxFile)                 
   Exec sp_xml_preparedocument @docHandle Output, @S; 
   Insert Into #WorkorderActivity
		  Select * From OpenXml(@docHandle, '/NewDataSet/Root',2) With #WorkorderActivity               
   Exec sp_xml_removedocument @docHandle;                 
   
   Exec sp_xml_preparedocument @docHandle1 Output, @S1;
   Insert Into #RetrivalBoxList 
		  Select * From OpenXml(@docHandle1, '/NewDataSet/Root',2) With #RetrivalBoxList               
   Exec sp_xml_removedocument @docHandle1;  
    If((Select COUNT(*) From #WorkorderActivity)>0) 
     Begin 
     Insert Into tbl_WoActivities( n_WorkOrderNo  ,	n_ActivityId , n_ActivityStatus 	,  n_BoxCount,
								   n_FileCount	 ,	s_Remark     , d_ModificationDate   ,  n_ModifiedBy ,  n_DepartmentId ,  d_ActivityDate , n_PickupAddressId)              
							Select	@pn_WorkorderNo     ,  ActivityId         ,ActivityStatus,     
								    ISNULL(NoOfBox,0)   ,  ISNULL(NoOfFile,0)    
									,Remark,GETDATE()   ,  UserId,
									Case DepartmentId When 0 Then  Null Else DepartmentId End, 
									Case ActivityDate When '' Then Null Else convert(date,ActivityDate,103) End,
								    Case PickUpAddressId When 0 Then Null Else PickUpAddressId End
       From #WorkorderActivity     
      End           
    Drop table #WorkorderActivity   
      If((Select COUNT(*) From #RetrivalBoxList)>0)
      Begin
         Insert Into tbl_BoxFileRetrivaldetails
           (n_IsBoxFile
           ,n_workOrderActivity
           ,s_BoxBarCode
           ,s_FileBarCode
           ,n_ModifiedBy
           ,d_ModifiedDate)   
           Select  Case  Rtrim(ltrim(RB.FileBarCode)) When '' Then 1 Else 2 End	,TWA.n_WoActivityId,
				  RB.BoxBarCode    ,    isnull(RB.FileBarCode,NULL),
				  @pn_ModifiedBy   ,    GETDATE()
           From  #RetrivalBoxList RB 
					Inner Join
			     tbl_BoxDetails TBD     On RB.BoxBarCode=TBD.s_BoxBarCode
			         Left Join
			     tbl_FileDetails TFD    On TBD.n_BoxId=TFD.n_BoxId And
			     isnull(RB.FileBarCode,Null)   =  Case  When RB.FileBarCode is null Then NULL Else TFD.s_FileBarCode End 
			          Left Join
				 tbl_WoActivities TWA On RB.ActivityId = TWA.n_ActivityId And isnull(TWA.n_PickupAddressId,0)=isnull(RB.PickUpAddressId,0)
         Where TWA.n_WorkOrderNo = @pn_WorkorderNo
        End   
       Drop table #RetrivalBoxList
           
    End              
    Else              
    Begin   
     Declare @WorkOrderNo Int  
      Create Table #WorkorderUpdateActivity(WorkOrderNo Int			, WoActivityId		Int,
											NoOfBox	  Int           , NoOfFile		    Int
								      )
		Declare @docHandleUpdate	Int; 
		Declare @UpdateActivities		Nvarchar(Max)
	
		Set @UpdateActivities = CONVERT(Nvarchar(Max),@px_WorkorderList)                 
		Exec sp_xml_preparedocument @docHandleUpdate Output, @UpdateActivities; 
		  Insert Into #WorkorderUpdateActivity
		  Select * From OpenXml(@docHandleUpdate, '/NewDataSet/Root',2) With #WorkorderUpdateActivity               
		  Exec sp_xml_removedocument @docHandleUpdate;   
    If((Select COUNT(*) From #WorkorderUpdateActivity) >0)
    Begin
    	Update	T  Set T.n_ActivityStatus = @pn_Activitystatus ,T.n_ModifiedBy = @pn_ModifiedBy ,
									   T.n_BoxCount	   = TWA.NoOfBox		,T.n_FileCount =  TWA.NoOfFile  ,
									   T.d_ModificationDate = GETDATE() 
		From tbl_WoActivities T
				Inner Join
			#WorkorderUpdateActivity   TWA on T.n_WoActivityId = TWA.WoActivityId and T.n_WorkOrderNo= TWA.WorkOrderNo  						                                  
		Set  @WorkOrderNo =( Select Top 1 WorkOrderNo From #WorkorderUpdateActivity )
    End
    Else
    Begin
             
		Update	tbl_WoActivities  Set n_ActivityStatus = @pn_Activitystatus ,n_ModifiedBy = @pn_ModifiedBy ,
									   n_BoxCount	   = @pn_BoxCount		,n_FileCount =  @pn_FileCount  ,d_ModificationDate = GETDATE()                                
		Where n_WoActivityId = @pn_WoActivityId    
		 
	Select @WorkOrderNo = n_WorkOrderNo From tbl_WoActivities Where n_WoActivityId =  @pn_WoActivityId   
	End	
	
  
	Declare @WoACTStatus  SmallInt  
	Select @WoACTStatus = n_AppCodeId  
			From tbl_ApplicationCodeMaster 
			Where s_AppCode ='ACTIVITY_STATUS' And UPPER(s_AppCodeName) = Upper('Closed')  
	Declare @WoStatus  SmallInt  
	Select @WoStatus = n_AppCodeId  
			From tbl_ApplicationCodeMaster 
			Where s_AppCode ='WORKORDER_STATUS' And UPPER(s_AppCodeName) = Upper('Closed')  
    Declare @TotalClosed Int   
	Set @TotalClosed = 0  
    Select @TotalClosed = COUNT(*) 
			From tbl_WoActivities 
			Where n_WorkOrderNo = @WorkOrderNo   
					 And
				  n_ActivityStatus = @WoACTStatus   
		Declare @TotalCount Int   
		Set @TotalCount = (Select COUNT(*) From tbl_WoActivities Where n_WorkOrderNo = @WorkOrderNo)  
		 If(@TotalClosed = @TotalCount)  
		 Begin  
		 Update tbl_WorkOrder Set n_Status = @WoStatus, n_ModifiedBy=@pn_ModifiedBy ,d_ModificationDate = GETDATE() 
		 Where n_WorkorderNo = @WorkOrderNo    
		 End   
 	Drop table #WorkorderUpdateActivity
	End
   End Try              
   Begin Catch   
    Set @IsLogError = 1;              
    --Exec usp_GetErrorInfo                
   End Catch                     
End 

GO


If Exists (Select 1 From sysobjects Where Type = 'P' AND  name = 'usp_getFilePickUpSummary')
Begin
	Drop Procedure usp_getFilePickUpSummary
End
Go    
Create Procedure usp_getFilePickUpSummary 
(
@pn_CGroupId     Int      ,  
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

		Create Table #FilPickupDetails(    
		CustomerName Varchar(200) Null   ,  BoxBarCode Varchar(16) Null,
		FileBarCode  Varchar(16)  Null   ,  NoOfBoxes int Null,NoOfFiles Int Null)					
		Create Table #ShowBoxFileDetails(    
		CustomerName Varchar(200) Null  , NoOfBoxes int Null,NoOfFiles Int Null)
		 Create Table #temp(    
		CustomerName Varchar(200) Null ,NoOfFiles Int Null)
		
	   Create Table #ShowBoxFileDetailsDepartmentWise(    
		CustomerName Varchar(200) Null,Department Varchar(100) Null ,NoOfBoxes Int Null,NoOfFiles Int Null)
		
	   Create Table #DepartmentWise(    
		CustomerName Varchar(200) Null,Department Varchar(100) Null ,NoOfFiles Int Null)
								
		Insert Into #ShowBoxFileDetails(CustomerName,NoOfBoxes)	
		Select TC.s_CustomerName    As 'CustomerName'   ,COUNT(TB.s_BoxBarCode)  As 'NoOfBoxes'
        From	
		tbl_Customer         TC 
		    Left Join 
		tbl_CompanyGroup     TCG    On TCG.n_CompanyGroupId =TC.n_CompanyGroupId
		    Inner Join
		tbl_BoxDetails 		 TB	    On TC.n_CustomerId=TB.n_CustomerId
		Where TCG.n_CompanyGroupId  = Case  @pn_CGroupId       When 0 Then TCG.n_CompanyGroupId  Else @pn_CGroupId      End
		     And 
		TC.n_CustomerId             = Case @pn_CustomerId      When  0 Then TC.n_CustomerId      Else  @pn_CustomerId   End
		    And 
		TB.d_ModifiedDate Between @pd_FromDate And @pd_ToDate
		Group By TC.s_CustomerName 
		
		    Insert Into #FilPickupDetails(CustomerName,NoOfFiles)	
			Select TC.s_CustomerName    As 'CustomerName'	  ,COUNT(1)  As 'NoOfFiles'
			From	
			tbl_Customer         TC 
			 Left Join 
			tbl_CompanyGroup     TCG    On TCG.n_CompanyGroupId =TC.n_CompanyGroupId
			Inner Join
			tbl_BoxDetails 		 TB	    On TC.n_CustomerId=TB.n_CustomerId
			Inner Join
			tbl_FileDetails	     TF     On	 isnull(TB.n_BoxId,0) = isnull(TF.n_BoxId,0) 
			Left Join
			tbl_ApplicationCodeMaster  TACM  On TACM.n_AppCodeId=TF.n_DepartmentId

			Where TCG.n_CompanyGroupId  = Case  @pn_CGroupId     When 0 Then TCG.n_CompanyGroupId Else @pn_CGroupId      End
			And 
			TC.n_CustomerId             = Case @pn_CustomerId    When  0 Then TC.n_CustomerId     Else  @pn_CustomerId   End
			And
			TACM.n_AppCodeId            = Case  @pn_DeptId       When 0 Then TACM.n_AppCodeId     Else @pn_DeptId        End
			And 
			TB.d_ModifiedDate Between @pd_FromDate And @pd_ToDate
			Group By TC.s_CustomerName, TB.s_BoxBarCode
			
			Insert Into #temp(CustomerName,NoOfFiles)	
			Select CustomerName,SUM(NoOfFiles) As 'NoOfFiles' From #FilPickupDetails 
			Group By CustomerName
			
			Update  #ShowBoxFileDetails  
			Set   #ShowBoxFileDetails.NoOfFiles    = T.NoOfFiles
			From #ShowBoxFileDetails 
			Inner Join
			#temp T On #ShowBoxFileDetails.CustomerName=T.CustomerName
		    Select * from #ShowBoxFileDetails
		
		    Insert Into #DepartmentWise(CustomerName,Department,NoOfFiles) 
			Select TC.s_CustomerName As 'CustomerName', isnull(TACM.s_AppCodeName,'') As 'Department'	  ,COUNT(1)  As 'NoOfFiles'
			From	
			tbl_Customer         TC 
			Left Join 
			tbl_CompanyGroup     TCG    On TCG.n_CompanyGroupId =TC.n_CompanyGroupId
			Inner Join
			tbl_BoxDetails 		 TB	    On TC.n_CustomerId=TB.n_CustomerId
			Left Join
			tbl_FileDetails	     TF     On	 isnull(TB.n_BoxId,0) = isnull(TF.n_BoxId,0) 
			Left Join
			tbl_ApplicationCodeMaster  TACM  On TACM.n_AppCodeId=TF.n_DepartmentId

			Where TCG.n_CompanyGroupId  =  Case  @pn_CGroupId     When 0 Then TCG.n_CompanyGroupId Else  @pn_CGroupId      End
			And 
			TC.n_CustomerId             =  Case  @pn_CustomerId   When 0 Then TC.n_CustomerId      Else   @pn_CustomerId   End
			And
			TACM.n_AppCodeId            =  Case  @pn_DeptId      When 0 Then TACM.n_AppCodeId      Else  TACM.n_AppCodeId  End
			--And
			--TF.d_FromDate Between @pd_FromDate And @pd_ToDate
			Group By   TC.s_CustomerName,TACM.s_AppCodeName
			
			Create Table #DepartmentData(CustomerName Varchar(100) Null, Department varchar(100) Null,NoOfFiles Int Null)
			Insert Into #DepartmentData
            Select CustomerName,Department,SUM(NoOfFiles) As 'NoOfFiles'  from #DepartmentWise
            Group By CustomerName,Department
			-------------Deptwise
	     	Select Department,NoOfFiles From #DepartmentData
	        Drop Table #FilPickupDetails
			Drop Table #ShowBoxFileDetails
End    
  
Go


If Exists (Select 1 From sysobjects Where Type = 'P' AND  name = 'usp_getFilePickUpDetails')
Begin
	Drop Procedure usp_getFilePickUpDetails
End
Go    
Create Procedure usp_getFilePickUpDetails 
(
@pn_CGroupId     Int      ,  
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

		Create Table #tempWorkOrderDetails
		(n_WONo Int, n_BoxCount Int, n_FileCount Int)

		Insert Into #tempWorkOrderDetails Select Distinct n_WorkOrderNo, 0, 0 
		From tbl_WoActivities WA 
		     Inner Join
		 tbl_Activity AC 	 On WA.n_ActivityId         =  AC.n_ActivityId
			  Left Join 
	   tbl_ServiceCategory SC On AC.n_ServiceCategoryId =  SC.n_ServiceCategoryId
	   Where SC.s_SCName = 'File Pick Up' 
	   And WA.d_ModificationDate Between @pd_FromDate And @pd_ToDate

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
		      
		Select T.n_WONo   As 'WorkOrderNo', WO.d_WoDate As 'WorkOrderDate', TC.s_CustomerName As 'CustomerName', T.n_BoxCount As 'NoOfBoxes', T.n_FileCount As 'NoOfFiles'
		From #tempWorkOrderDetails T
		     Inner Join 
		tbl_WorkOrder WO            On T.n_WONo = WO.n_WorkorderNo 
			  Inner Join
	     tbl_Customer TC            On  WO.n_CustomerId = TC.n_CustomerId
	         Left Join 
		tbl_CompanyGroup     TCG    On TCG.n_CompanyGroupId =TC.n_CompanyGroupId
		Where	
		TCG.n_CompanyGroupId  =  Case @pn_CGroupId    When  0  Then  TCG.n_CompanyGroupId  Else @pn_CGroupId  End
		And
		TC.n_CustomerId       =  Case @pn_CustomerId  When  0   Then  TC.n_CustomerId       Else @pn_CustomerId End		
		Drop Table #tempWorkOrderDetails

End    
  
Go