/*
SP Name: usp_GetClientWiseFileDetails
Description: This stored procedure is used to get the  File Details.  
Created By:  Sunil pandey
Creation Date: 18-02-2015 
*/
If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_GetClientWiseFileDetails') 
Begin
   Drop Procedure usp_GetClientWiseFileDetails
End 
Go
Create Procedure [dbo].[usp_GetClientWiseFileDetails]
(
@pn_CustomerId   Int,
@pn_Month        Int,  
@pn_Year         Int,
@ps_WorkOrderNos  Varchar(Max) 
)    
As  
Begin  

 SET NOCOUNT ON  
  Create Table #Workorders(WorkOrderNo Int)
  	
	 If( Rtrim(ltrim(@ps_WorkOrderNos)) <>'')
	 Begin
 		Declare @docHandle	Int; 
		Declare @S			Nvarchar(Max)
		Set @S = CONVERT(Nvarchar(Max),@ps_WorkOrderNos)                 
		                
	   Exec sp_xml_preparedocument @docHandle Output, @S; 
	   Insert Into #Workorders
			  Select * From OpenXml(@docHandle, '/NewDataSet/Root',2) With #Workorders               
	   Exec sp_xml_removedocument @docHandle;   
	 End
	
	    
 Select            T.s_BoxBarCode              As 'Box BarCode' ,
                   TF.s_FileBarCode            As 'File BarCode',
                   TF.s_FileName               As 'FileName'    ,
                   TF.s_Year                   As 'Year'        ,
   CONVERT(Varchar,TF.d_FromDate ,103)         As 'From Date'   ,
   CONVERT(Varchar,TF.d_EndDate ,103)          As 'To Date'     ,
                   TF.s_Label1                 As 'Label1'      ,
                   TF.s_Label2                 As 'Label2'      ,
                   TF.s_Label3                 As 'Label3'      ,
                   APCD.s_AppCodeName          As 'Dept'        ,
                   APCS.s_AppCodeName          As 'Status'      ,
                   BR.s_Address+BR.s_Address2  As 'PickUp' 
From tbl_FileDetails  TF 
			Inner Join  
		(Select 
				TB.s_BoxBarCode,
				TBT.* From 
		 tbl_BoxTransactions TBT 
				Inner join 
		tbl_BoxDetails TB  On TBT.n_BoxId = TB.n_BoxId 
		Where TBT.n_WoActivityId IN(Select 
										n_WoActivityId
									From tbl_WoActivities 
								    Where n_WorkorderNo 
								    IN(Select WorkOrderNo  From #Workorders))) As T  ON TF.n_BoxId = T.n_BoxId 
Left  Join  tbl_ApplicationCodeMaster APCD on TF.n_DepartmentId = APCD.n_AppCodeId  
Left  Join  tbl_ApplicationCodeMaster APCS on TF.n_Status = APCS.n_AppCodeId  
Left  Join  tbl_PickupAddress  BR on TF.n_BranchId  = BR.n_PickupAddressId
Drop table #Workorders        
End  

Go