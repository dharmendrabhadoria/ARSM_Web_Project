
/*
SP Name       : usp_getFilePickUpSummary
Purpose       : This stored procedure is used to get the file pickup report.
Created By    : Ajay Tiwari
Creation Date : 17-02-2015
*/
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

			Where TCG.n_CompanyGroupId  = Case  @pn_CGroupId      When 0 Then TCG.n_CompanyGroupId Else @pn_CGroupId      End
			And 
			TC.n_CustomerId             = Case  @pn_CustomerId    When 0 Then TC.n_CustomerId      Else  @pn_CustomerId    End
			And
			TACM.n_AppCodeId            = Case  @pn_DeptId        When 0 Then TACM.n_AppCodeId     Else @pn_DeptId        End
			And 
			TB.d_ModifiedDate Between @pd_FromDate And @pd_ToDate
			Group By TC.s_CustomerName, TB.s_BoxBarCode
			
			Insert Into #temp(CustomerName,NoOfFiles)	
			Select CustomerName,SUM(isnull(NoOfFiles,0)) As 'NoOfFiles' From #FilPickupDetails 
			Group By CustomerName
			
			Update  #ShowBoxFileDetails  
			Set   #ShowBoxFileDetails.NoOfFiles          =   T.NoOfFiles
			From #ShowBoxFileDetails 
			  Inner Join
			#temp T On #ShowBoxFileDetails.CustomerName  =   T.CustomerName
		    Select  CustomerName    ,   IsNull(NoOfBoxes,0)   'NoOfBoxes'  ,
		    IsNull(NoOfFiles,0)          As 'NoOfFiles'   From  #ShowBoxFileDetails
		
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