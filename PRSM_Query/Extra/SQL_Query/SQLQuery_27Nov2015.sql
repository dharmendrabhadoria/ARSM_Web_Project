
/****** Object:  StoredProcedure [dbo].[usp_ApproveFileDetails]    Script Date: 11/27/2015 18:38:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_ApproveFileDetails]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_ApproveFileDetails]
GO
/****** Object:  StoredProcedure [dbo].[usp_CheckFPCountForCloseWOActivity]    Script Date: 11/27/2015 18:38:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_CheckFPCountForCloseWOActivity]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_CheckFPCountForCloseWOActivity]
GO
/****** Object:  StoredProcedure [dbo].[usp_EditMakerSearchData]    Script Date: 11/27/2015 18:38:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_EditMakerSearchData]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_EditMakerSearchData]
GO
/****** Object:  StoredProcedure [dbo].[Usp_InsertUpdateFileDetails_2]    Script Date: 11/27/2015 18:38:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Usp_InsertUpdateFileDetails_2]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Usp_InsertUpdateFileDetails_2]
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertUpdateWorkOrder]    Script Date: 11/27/2015 18:38:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_InsertUpdateWorkOrder]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_InsertUpdateWorkOrder]
GO
/****** Object:  StoredProcedure [dbo].[usp_LoginDetails]    Script Date: 11/27/2015 18:38:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_LoginDetails]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_LoginDetails]
GO
/****** Object:  StoredProcedure [dbo].[usp_xlRetr_ValidateFile]    Script Date: 11/27/2015 18:38:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_xlRetr_ValidateFile]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_xlRetr_ValidateFile]
GO
/****** Object:  StoredProcedure [dbo].[usp_GenerateInvoice_RSC_NewLogic]    Script Date: 11/27/2015 18:38:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_GenerateInvoice_RSC_NewLogic]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_GenerateInvoice_RSC_NewLogic]
GO
/****** Object:  StoredProcedure [dbo].[USP_GetServiceRequestForWO]    Script Date: 11/27/2015 18:38:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USP_GetServiceRequestForWO]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[USP_GetServiceRequestForWO]
GO
/****** Object:  StoredProcedure [dbo].[USP_GetServiceRequestForWO]    Script Date: 11/27/2015 18:38:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USP_GetServiceRequestForWO]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/*
exec USP_GetServiceRequestForWO 2015000327
*/          
CREATE PROCEDURE [dbo].[USP_GetServiceRequestForWO]          
(                
@pn_ServiceRequestNo  Int          
)                    
As                  
Begin                  
 SET NOCOUNT ON               
 --set @pn_ServiceRequestNo=2015000022          
 select distinct SC.s_SCName,SC.n_ServiceCategoryId           
  from tbl_CustomerRequestActivities CRA           
   JOIN tbl_Activity ACT ON CRA.n_ActivityId =ACT.n_ActivityId          
   JOIN tbl_ServiceCategory SC ON ACT.n_ServiceCategoryId =SC.n_ServiceCategoryId          
 Where CRA.n_RequestNo = @pn_ServiceRequestNo          
           
 /*Following part fetches records for File Pick up Service Category*/          
 --select DPT.s_AppCodeName as ''Department'',CRA.n_BoxCount as ''No. of Boxes'', CRA.n_FileCount as ''No. of Files'',PA.s_Address as ''PickUp Address''           
 --  from tbl_CustomerRequestActivities CRA           
 -- JOIN tbl_ApplicationCodeMaster DPT ON CRA.n_DepartmentId = DPT.n_AppCodeId AND DPT.s_AppCode=''DEPARTMENT''          
 -- JOIN tbl_PickupAddress PA ON CRA.n_PickupAddressId =PA.n_PickupAddressId          
 --Where CRA.n_RequestNo =@pn_ServiceRequestNo AND           
 --CRA.n_ActivityId IN (select n_ActivityId From tbl_Activity Where n_ServiceCategoryId =5) /*5-File Pick Up*/          
           
 select distinct DPT.s_AppCodeName as ''Department'',CRA.n_BoxCount as ''No. of Boxes'', CRA.n_FileCount as ''No. of Files'',PA.s_Address as ''PickUp Address'',CRA.d_ActivityDate as ''Date'',CRA.n_DepartmentId as ''DeptId'',PA.n_PickupAddressId as ''PickAddressID''/*CO
  
NVERT(Varchar(20),CRA.d_ActivityDate ,113) as ''Date'' */      
 Into #tblll          
   from tbl_CustomerRequestActivities CRA           
  JOIN tbl_ApplicationCodeMaster DPT ON CRA.n_DepartmentId = DPT.n_AppCodeId AND DPT.s_AppCode=''DEPARTMENT''          
  JOIN tbl_PickupAddress PA ON CRA.n_PickupAddressId =PA.n_PickupAddressId          
 Where CRA.n_RequestNo =@pn_ServiceRequestNo AND           
 CRA.n_ActivityId IN (select n_ActivityId From tbl_Activity Where n_ServiceCategoryId =5) /*5-File Pick Up*/          
           
 select [Department],SUM([No. of Boxes]) as ''No. of Boxes'', SUM([No. of Files]) as ''No. of Files'', [PickUp Address],[Date],[DeptId],[PickAddressID] from #tblll          
 Group by [Department],[PickUp Address],[Date],[DeptId],[PickAddressID]          
           
           
 /*Following part fetches records for Retreival Service Category*/          
           
 select PA.s_Address as ''PickUp Address'', PA.n_PickupAddressId  as ''PickUpAddressId''  ,ACT.s_ActivityName as ''Activity Name'' , ACT.n_ActivityId          
  --, CRA.n_BoxCount as ''Box Bar Code'', CRA.n_FileCount as ''File Bar Code''          
  , BXFL.s_BoxBarCode as ''Box Bar Code'', BXFL.s_FileBarCode as ''File Bar Code''          
   from tbl_CustomerRequestActivities CRA           
  JOIN tbl_PickupAddress PA ON CRA.n_PickupAddressId =PA.n_PickupAddressId           
  JOIN (select n_ActivityId,s_ActivityName from tbl_Activity Where n_ServiceCategoryId = 6          
  AND s_ActivityName not like ''%hand%'') ACT ON CRA.n_ActivityId =ACT.n_ActivityId          
  JOIN tbl_BoxFileRetrivaldetailsServiceRequest BXFL ON CRA.n_RequestActivityId = BXFL.n_ServiceRequestActivity          
 Where CRA.n_RequestNo =@pn_ServiceRequestNo       /*6-Retrieval*/          
           
           
 /*Following part fetches records for Other Services Category*/          
           
           
 declare @Count int          
 declare @AuditRoomCharges int            
           
 select @AuditRoomCharges = n_ActivityId From tbl_Activity Where s_ActivityName = ''Audit Room Charges''          
           
 select @Count =SUM(CRA.n_FileCount ) FROM tbl_CustomerRequestActivities CRA           
  JOIN (select n_ActivityId,s_ActivityName from tbl_Activity Where n_ServiceCategoryId = 3) ACT ON CRA.n_ActivityId =ACT.n_ActivityId              
 Where CRA.n_RequestNo =@pn_ServiceRequestNo          
 AND CRA.n_ActivityId <> @AuditRoomCharges          
           
 if(@Count>0)          
 Begin          
  select  ACT.s_ActivityName as ''Activity Name'', CRA.n_FileCount as ''No. of Services''          
    from tbl_CustomerRequestActivities CRA           
   JOIN (select n_ActivityId,s_ActivityName from tbl_Activity Where n_ServiceCategoryId = 3) ACT ON CRA.n_ActivityId =ACT.n_ActivityId          
  Where CRA.n_RequestNo =@pn_ServiceRequestNo       /*3-Other services*/           
  UNION          
  select  ''Document Searching & Insertion'' as ''Activity Name'', @Count as ''No. of Services''          
  UNION          
  select  ''File Retrieval'' as ''Activity Name'', @Count as ''No. of Services''          
 End          
 Else          
 Begin           
  select  ACT.s_ActivityName as ''Activity Name'', CRA.n_FileCount as ''No. of Services''          
from tbl_CustomerRequestActivities CRA           
   JOIN (select n_ActivityId,s_ActivityName from tbl_Activity Where n_ServiceCategoryId = 3) ACT ON CRA.n_ActivityId =ACT.n_ActivityId          
  Where CRA.n_RequestNo =@pn_ServiceRequestNo       /*3-Other services*/           
 End          
           
End ' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GenerateInvoice_RSC_NewLogic]    Script Date: 11/27/2015 18:38:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_GenerateInvoice_RSC_NewLogic]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/*
EXEC usp_GenerateInvoice_RSC_NewLogic 09 , 2015  , 1 , 1
*/
CREATE Proc [dbo].[usp_GenerateInvoice_RSC_NewLogic]
(
@pn_Month    TinyInt,             
@pn_Year    Int,            
@pn_WareHouseId   TinyInt,             
--@pXmlCustomerList Varchar (Max),            
@n_UserId    SmallInt       
)
As
Begin --BEGIN PROC 
/*
1. CHECK IF INVOICE IS ALREADY GENERATED FOR THIS CUSTOMER
2. INVOICE NO CHANGED TO DECIMAL
3. CHECK THE DATA TYPE OF FIELDS in @tbl_InvoiceSummary
4. CHECK THE DATA TYPE OF FIELDS in @tbl_InvoiceDetails 
*/
    Set Nocount On;            
    Begin Transaction;            
	Begin Try 
	    /* Global Declares*/
	    Declare @cutoffdays int = 15 /* the cutoff date; all transactions before this date will be charged */
	    Declare @Status_ActivityClosed int = (Select Top 1 n_AppCodeId From tbl_ApplicationCodeMaster Where  s_AppCode = ''ACTIVITY_STATUS'' And s_AppCodeName = ''Closed'')
	    Declare @InvoiceStartDate date = Convert(Date ,Convert(varchar(10) , @pn_Year) + ''/'' + Convert(varchar(10) , @pn_Month) +  ''/01'')
	    Declare @InvoiceEndDate date = DateAdd(d , @cutoffdays, @invoiceStartDate) 
	    Select @InvoiceStartDate
	    Select @InvoiceEndDate
	    Declare @n_InvoiceNo decimal  
	    /* Global Declares*/	    

--------INVOICE NO GENERATION LOGIC-----------------	    	    	    
	    /*GENERATE THE BASE INVOICE NO*/
	    /*THIS LOGIC GENERATES BASE INVOICE NO. LATER, THE ID OF THE tempInvoiceSummary IS ADDED TO THIS NUMBER TO GET THE ACTUAL INVOICE NO */
	    Declare @n_InvoiceYear As Int;            
	    Select 
		@n_InvoiceNo = Isnull((Max(n_InvoiceNo) + 0),           
		Convert (Int, Convert (Varchar, DATEPART(YEAR, GETDATE())) + ''000000''))            
	    From 
		tbl_InvoiceSummary            
	    --select @InvoiceNo 
	    Select @n_InvoiceYear =  CONVERT(Int,Substring(CONVERT(varchar,(Select MAX(n_InvoiceNo)  From tbl_InvoiceSummary)),1,4))          
	    
	    If (@n_InvoiceYear != DATEPART(YEAR, GETDATE()))            
	    Begin            
		Select @n_InvoiceNo = Convert (Int, Convert (Varchar, DATEPART(YEAR, GETDATE())) + ''000000'');            
	    End  	    
	    /*GENERATE THE BASE INVOICE NO*/
--------INVOICE NO GENERATION LOGIC-----------------	    	    	    	    
	    
--------INVOICE DETAILS-----------------------------	    
	    /* CHARGE THE TRANSACTIONS*/
	    /*GET ALL THE CLOSED ACTIVITIES WITHIN START DATE AND END DATE*/
	    --Select * from tbl_invoicedetails 
	    declare @tbl_InvoiceDetails table (
		[n_InvoiceNo] [int],
		[n_WoActivityId] [int],
		[n_ActivityCount] [int],
		[n_Amount] [decimal](9, 2),
		
		
		n_WorkorderNo int , n_CustomerId int , d_ModificationDate  datetime , s_ActivityName varchar(100),
	    n_Rate decimal(8,2) , n_BoxCount int  , n_FileCount int , n_ActivityAmount decimal(8,2) ,
	    [s_Remark] [varchar](500)
	    )
	    
	    insert @tbl_InvoiceDetails ([n_InvoiceNo],[n_WoActivityId],[n_ActivityCount],[n_Amount],
	    	n_WorkorderNo, n_CustomerId  , d_ModificationDate, s_ActivityName,
	    n_Rate, n_BoxCount, n_FileCount, n_ActivityAmount)
	    Select 
	    /* FIELDS REQUIRED FOR tbl_InvoiceDetails */
	    @n_InvoiceNo as n_InvoiceNo  , TWA.n_WoActivityId ,  TWA.n_BoxCount  + TWA.n_FileCount as n_ActivityCount , TR.n_Rate as n_Amount ,  
	    /* FIELDS REQUIRED FOR tbl_InvoiceDetails */
	    
	    /* FIELDS NOT REQD IN OUTPUT */
	    TWO.n_WorkorderNo, TWO.n_CustomerId, TWA.d_ModificationDate , TACT.s_ActivityName 
	    ,TR.n_Rate , TWA.n_BoxCount , TWA.n_FileCount , TR.n_Rate * (TWA.n_BoxCount  + TWA.n_FileCount ) 
	     from 
		tbl_WoActivities TWA
		join tbl_WorkOrder TWO on TWO.n_WorkorderNo = TWA.n_WorkOrderNo 
		join tbl_RateCard TR on TR.n_ActivityId = TWA.n_ActivityId and TR.n_CustomerId = TWO.n_CustomerId  
		join tbl_Activity TACT on TACT.n_ActivityId = TWA.n_ActivityId 
	    Where 
		TWA.d_ModificationDate >= @InvoiceStartDate /* d_ModifiedDate between Invoice Start and End Dates */
		And TWA.d_ModificationDate <= @InvoiceEndDate
		And TWA.n_ActivityStatus = @Status_ActivityClosed /*CLOSED ACTIVITIES ONLY */
		
		--select * from tbl_RateCard 
		--select * from tbl_invoicesummary 
		--select * from tbl_invoicedetails
		select * from @tbl_invoicedetails
	    /* CHARGE THE TRANSACTIONS*/
--------INVOICE DETAILS-----------------------------	    

--------INVOICE SUMMARY-----------------------------	
/* WORKING HERE */
	    declare @Tax_HigherEducation decimal(5,2) ,@Tax_EducationCess decimal(5,2), @Tax_ServiceTax decimal(5,2) , @Tax_OtherTax decimal(5,2) 
	    set @Tax_HigherEducation = (select n_TaxValue from tbl_TaxMaster where n_taxId = (select n_AppCodeId from tbl_applicationcodemaster where s_AppCodeName = ''Higher Education''))
	    set @Tax_EducationCess = (select n_TaxValue from tbl_TaxMaster where n_taxId = (select n_AppCodeId from tbl_applicationcodemaster where s_AppCodeName = ''EDUCATION CESS''))
	    set @Tax_ServiceTax = (select n_TaxValue from tbl_TaxMaster where n_taxId = (select n_AppCodeId from tbl_applicationcodemaster where s_AppCodeName = ''SERVICE TAX''))
	    set @Tax_OtherTax = (select n_TaxValue from tbl_TaxMaster where n_taxId = (select n_AppCodeId from tbl_applicationcodemaster where s_AppCodeName = ''OTHER TAX''))
	    select @Tax_HigherEducation,@Tax_EducationCess , @Tax_ServiceTax , @Tax_OtherTax 

--select * from tbl_InvoiceSummary 


	    /* !!CHECK THE DATA TYPE OF FIELDS !!*/
	    declare @tbl_InvoiceSummary table ( n_InvoiceNo int , n_MonthYear int,n_WareHouseId int , n_CustomerId int, n_PickupAddressId int , 
			    n_StorageCharges int, n_TransAmount int , n_InvoiceAmount int , n_ServiceTax int , n_EduTax int, n_HigherEducation int, 
			    n_OtherTax int , n_TotalAmount int, d_ModifiedDate datetime , n_ModifiedBy int, s_Remark varchar(50) 
			    )
	    
	    /* CHARGE RMC*/
	    
	    insert @tbl_InvoiceSummary(
	    n_InvoiceNo, n_MonthYear,n_WareHouseId, n_CustomerId, n_PickupAddressId, 
	    n_StorageCharges, n_TransAmount, 
	    --n_InvoiceAmount, n_ServiceTax, n_EduTax,n_HigherEducation, 
	    --n_OtherTax, n_TotalAmount, 
	    d_ModifiedDate, n_ModifiedBy, s_Remark
	    ) 
	    Select 
		@n_InvoiceNo n_InvoiceNo,
		@pn_Year * 100  + @pn_Month n_MonthYear,
		@pn_WareHouseId n_WareHouseId, 
		TWO.n_CustomerID  ,
		1 as n_PickupAddressId , 
		0.00 as n_StorageCharges, 
		0.00 as n_TransAmount ,
		--0.00 as n_InvoiceAmount, 
		--0.00 as n_ServiceTax, 
		--0.00 as n_EduTax, 
		--0.00 as n_HigherEducation,		
		--0.00 as n_OtherTax, 
		--0.00 as n_TotalAmount, 
		GETDATE() as d_ModifiedDate, 
		1 as n_ModifiedBy ,
		'''' as s_Remark 
	    From 
		tbl_WorkOrder TWO 
		select ''here 1'' 
		select * from @tbl_InvoiceSummary 
		--select * from @tbl_InvoiceDetails join @tbl_InvoiceSummary on @tbl_InvoiceDetails.n_CustomerId = @tbl_InvoiceSummary.n_CustomerId 
		update @tbl_InvoiceSummary  set n_TransAmount =  tca.n_ActivityAmount from  @tbl_InvoiceSummary tis join (
		select n_CustomerId , SUM(n_ActivityAmount) as n_ActivityAmount  from @tbl_InvoiceDetails group by n_CustomerId ) tca on tca.n_CustomerId = tis.n_CustomerId  
		
		--update @tbl_InvoiceSummary set n_InvoiceAmount = n_StorageCharges + n_TransAmount 
		--update @tbl_InvoiceSummary set n_ServiceTax = (n_InvoiceAmount * @Tax_ServiceTax) /100
		--update @tbl_InvoiceSummary set n_EduTax = (n_InvoiceAmount * @Tax_EducationCess ) /100
		--update @tbl_InvoiceSummary set n_HigherEducation =(n_InvoiceAmount * @Tax_HigherEducation ) /100
		--update @tbl_InvoiceSummary set n_OtherTax = (n_InvoiceAmount * @Tax_OtherTax) /100
		--update @tbl_InvoiceSummary set n_TotalAmount = n_InvoiceAmount + n_ServiceTax + n_EduTax + n_HigherEducation + n_OtherTax 
	
			select ''here 2'' 
		select * from @tbl_InvoiceSummary 
	    /* CHARGE RMC*/	    	    	    
--------INVOICE SUMMARY-----------------------------	    	    	    
	    Commit Transaction            
	End Try            
	Begin Catch            
	    Rollback;            
	    Execute usp_GetErrorInfo ;            
	End Catch              
End  --END PROC' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_xlRetr_ValidateFile]    Script Date: 11/27/2015 18:38:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_xlRetr_ValidateFile]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_xlRetr_ValidateFile]    
(    
@custid int    
)    
    
AS    
BEGIN    
     
 SET NOCOUNT ON;    
 declare @retTable Table (ErrorMsg varchar(250))      
 declare @Status_File_Out int = (Select n_AppCodeId From tbl_applicationcodemaster Where s_AppCode = ''BOXFILE_STATUS'' And s_AppCodeName = ''Out'' )    
 declare @Status_File_In int = (Select n_AppCodeId From tbl_applicationcodemaster Where s_AppCode = ''BOXFILE_STATUS'' And s_AppCodeName = ''In'' )                        
 Declare @Status_Permanent_Out int =(Select n_AppCodeId From tbl_applicationcodemaster Where s_AppCode = ''BOXFILE_STATUS'' And s_AppCodeName = ''Out'' )    
 Declare @Status_Destroy int=(Select n_AppCodeId from tbl_ApplicationCodeMaster where s_AppCode=''BOXFILE_STATUS'' AND s_AppCode=''OUT'')    
 Declare @Activity_FileRetrievalRegular int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''File Retrievals  Regular (Within 24 hours)'')                 
 Declare @Activity_FileRetrievalExpress int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''File Retrievals  Express (Within 12 hours)'')     
 Declare @Status int = (Select n_AppCodeId From tbl_ApplicationCodeMaster Where s_AppCodeName =''Open'' and s_AppCode=''WORKORDER_STATUS'')     
 --Declare @Activity_BoxRestoreRegular int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''Box  Restore Regular (Within 24 hours)'')                 
 --Declare @Activity_BoxRestoreExpress int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''Box  Restore Express (Within 12 hours)'')    
if ((select COUNT(*) from tbl_FileInfo)=0)         
	 Begin        
	  insert @retTable(ErrorMsg)        
	  select ''There are no rows in excel sheet''        
	 End  
	 
 if exists ( select * from tbl_FileInfo where [FILE_BARCODE] is null )       
begin      
 insert @retTable (ErrorMsg)       
 --select       
select ''File bar code is blank for '' + convert(varchar(10) , count(*)) + '' rows.'' from tbl_FileInfo         
 where [FILE_BARCODE]  is null       
end      
      
  insert @retTable (ErrorMsg)      
select ''File Barcode  '' + FI.FILE_BARCODE  + '' in Excel file does not match with customer selected'' from tbl_FileInfo FI    
Join    
tbl_FileDetails TFD    
ON TFD.s_FileBarCode=FI.FILE_BARCODE    
Join    
tbl_BoxDetails TBD    
on TBD.n_BoxId=TFD.n_BoxId     
where TBD.n_CustomerId <> @custid   
         
      
insert @retTable (ErrorMsg)       
Select ''File bar code is duplicate for '' +  Rtrim(ltrim([FILE_BARCODE]))         
From tbl_FileInfo          
Group by   Rtrim(ltrim([FILE_BARCODE])) having COUNT( Rtrim(ltrim([FILE_BARCODE]))) > 1     
          
    
if exists (Select TF.FILE_BARCODE  from tbl_FileInfo TF left join tbl_filedetails TFD on TF.FILE_BARCODE = TFD.s_FileBarCode where TFD.s_FileBarCode is null  )    
begin      
insert @retTable (ErrorMsg)      
 Select ''File ''  + TF.FILE_BARCODE + '' does not exist in the system.''      
 from tbl_FileInfo TF left join tbl_filedetails TFD on TF.FILE_BARCODE = TFD.s_FileBarCode where TFD.s_FileBarCode is null     
end     
    
insert @retTable (ErrorMsg)      
select ''File'' + TFD.s_FileBarCode + ''is already retrieved''  from tbl_FileInfo TFI    
join tbl_FileDetails TFD on TFD.s_FileBarCode = TFI.FILE_BARCODE     
where TFD.n_Status = @Status_File_Out     
    
insert @retTable (ErrorMsg)     
select ''File '' + TFI.FILE_BARCODE + '' is alreay included for retrieval in work order no. '' + CONVERT(varchar(20) , TWO.n_WorkOrderNo ) from   
 tbl_WorkOrder TWO   
 join tbl_WoActivities TWA on TWA.n_WorkOrderNo = TWO.n_WorkorderNo   
 join tbl_BoxFileRetrivaldetails TBR  on TBR.n_workOrderActivity = TWA.n_WoActivityId   
 join tbl_FileInfo TFI on TFI.FILE_BARCODE = TBR.s_FileBarCode   
where   
 TWO.n_CustomerId = @custid   
 and TWO.n_Status = @Status   
 and TWA.n_ActivityId in(@Activity_FileRetrievalRegular,@Activity_FileRetrievalExpress)      
    
insert @retTable (ErrorMsg)       
Select ''Invalid File bar code '' +  [FILE_BARCODE]         
From tbl_FileInfo          
Where ([FILE_BARCODE] like ''%-%'' OR [FILE_BARCODE] like ''%`%'' OR [FILE_BARCODE] like ''%!%''      
 OR [FILE_BARCODE] like ''%@%'' OR [FILE_BARCODE] like ''%#%'' OR [FILE_BARCODE] like ''%$%''      
 OR ([FILE_BARCODE] like ''%\%%'' ESCAPE ''\'') OR [FILE_BARCODE] like ''%^%'' OR [FILE_BARCODE] like ''%&%''      
 OR [FILE_BARCODE] like ''%*%'' OR [FILE_BARCODE] like ''%(%'' OR [FILE_BARCODE] like ''%)%''      
 OR ([FILE_BARCODE] like ''%\_%'' ESCAPE ''\'') OR [FILE_BARCODE] like ''%+%'' OR [FILE_BARCODE] like ''%=%''      
 OR [FILE_BARCODE] like ''%|%'' OR [FILE_BARCODE] like ''%\%'' OR [FILE_BARCODE] like ''%?%''      
 OR [FILE_BARCODE] like ''%:%'' OR [FILE_BARCODE] like ''%;%'' OR [FILE_BARCODE] like ''%''''%''      
 OR [FILE_BARCODE] like ''%"%'' OR [FILE_BARCODE] like ''%<%'' OR [FILE_BARCODE] like ''%>%''      
 OR [FILE_BARCODE] like ''%,%'' OR [FILE_BARCODE] like ''%.%'' OR [FILE_BARCODE] like ''%/%''         
 OR [FILE_BARCODE] like ''%~%''          
 )         
     
 insert @retTable (ErrorMsg)       
Select ''Invalid Box bar code'' +  [BOX_BARCODE]         
From tbl_BoxInfo          
Where ([BOX_BARCODE] like ''%-%'' OR [BOX_BARCODE] like ''%`%'' OR [BOX_BARCODE] like ''%!%''      
 OR [BOX_BARCODE] like ''%@%'' OR [BOX_BARCODE] like ''%#%'' OR [BOX_BARCODE] like ''%$%''      
 OR ([BOX_BARCODE] like ''%\%%'' ESCAPE ''\'')  OR [BOX_BARCODE] like ''%^%'' OR [BOX_BARCODE] like ''%&%''      
 OR [BOX_BARCODE] like ''%*%'' OR [BOX_BARCODE] like ''%(%'' OR [BOX_BARCODE] like ''%)%''      
 OR ([BOX_BARCODE] like ''%\_%'' ESCAPE ''\'') OR [BOX_BARCODE] like ''%+%'' OR [BOX_BARCODE] like ''%=%''      
 OR [BOX_BARCODE] like ''%|%'' OR [BOX_BARCODE] like ''%\%'' OR [BOX_BARCODE] like ''%?%''      
 OR [BOX_BARCODE] like ''%:%'' OR [BOX_BARCODE] like ''%;%'' OR [BOX_BARCODE] like ''%''''%''      
 OR [BOX_BARCODE] like ''%"%'' OR [BOX_BARCODE] like ''%<%'' OR [BOX_BARCODE] like ''%>%''      
 OR [BOX_BARCODE] like ''%,%'' OR [BOX_BARCODE] like ''%.%'' OR [BOX_BARCODE] like ''%/%''         
 OR [BOX_BARCODE] like ''%~%''          
 )       
 Select ErrorMsg as [Error Message] from @retTable      
     
 select TFI.FILE_BARCODE FileBarCode , TBT.s_BoxBarCode BoxBarCode    
  from tbl_fileinfo TFI join tbl_filedetails TFD on TFI.FILE_BARCODE = TFD.s_FileBarCode     
 join tbl_BoxDetails TBT on TBT.n_BoxId = TFD.n_BoxId     
 END' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_LoginDetails]    Script Date: 11/27/2015 18:38:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_LoginDetails]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N' 
--usp_LoginDetails ''prsmadmin'',''P5VAyRvJIdQ=''      
        
CREATE procedure [dbo].[usp_LoginDetails]    --usp_LoginDetails ''Test'',''password''                    
(@UserName varchar(100),                        
@Pwd varchar(100)                        
)                
as                         
begin                    
if exists(select 1 from tbl_UserMaster where  s_UserName=@UserName and s_Password=@Pwd)                    
Begin               
select ''Success'' as Status,''Online Login Success'' as Message, n_UserId UserId,s_UserName UserName,            
 s_FirstName +'' '' +s_LastName Name  from tbl_UserMaster where  s_UserName=@UserName and s_Password=@Pwd            
                       
 select distinct  top 10            
 WO.n_WorkorderNo,                    
 WM.s_WarehouseName ''Ware House'',                    
 WM.n_WareHouseId,                    
 CG.s_CGName as ''Company Group'',                    
 CG.n_CompanyGroupId,                    
 CM.s_CustomerName as ''Customer'' ,                    
 CM.n_CustomerId                    
 from tbl_WorkOrder WO                    
  inner join tbl_Customer CM on CM.n_CustomerId=WO.n_CustomerId                    
  inner join tbl_CompanyGroup CG on CG.n_CompanyGroupId=CM.n_CompanyGroupId                    
  inner join tbl_WareHouseMaster WM on WM.n_WareHouseId=WO.n_WareHouseId     
  left join  tbl_ApplicationCodeMaster ACM ON WO.n_Status = ACM.n_AppCodeId    
  inner join tbl_WoActivities TWA on WO.n_WorkorderNo = TWA.n_WorkorderNo   
  where ACM.s_AppCodeName =''Open''   and TWA.n_ActivityId in ( 1,2,3)   
  and WO.d_WoDate>=''15-Sep-2015 00:00:00''    
   order by n_WorkorderNo  desc      
                    
-- select n_CustomerId,n_Status,n_WorkorderNo INTO #OpenWOCustomer From tbl_WorkOrder WO JOIN                        
-- tbl_ApplicationCodeMaster ACM ON WO.n_Status = ACM.n_AppCodeId  AND ACM.s_AppCode=''WORKORDER_STATUS''                          
-- where ACM.s_AppCodeName =''Open''                        
                         
-- select n_WorkorderNo From #OpenWOCustomer                        
----Company Group                        
-- select distinct CG.s_CGName, CG.n_CompanyGroupId from tbl_CompanyGroup CG JOIN                           
-- tbl_Customer C ON CG.n_CompanyGroupId=C.n_CompanyGroupId JOIN                          
-- #OpenWOCustomer TEMP ON C.n_CustomerId =TEMP.n_CustomerId                        
-- --Customer                        
-- select distinct C.s_CustomerName,C.n_CustomerId FROM tbl_Customer C JOIN                          
-- #OpenWOCustomer TEMP ON C.n_CustomerId =TEMP.n_CustomerId                        
                          
-- select distinct  DEPT.s_AppCodeName from tbl_WoActivities ACT JOIN                        
-- #OpenWOCustomer TT ON ACT.n_WorkOrderNo =TT.n_WorkorderNo JOIN                        
-- tbl_ApplicationCodeMaster DEPT ON ACT.n_DepartmentId =DEPT.n_AppCodeId AND DEPT.s_AppCode=''DEPARTMENT''                          
                         
--select n_WareHouseId,s_WarehouseName from tbl_WareHouseMaster                      
-- drop table #OpenWOCustomer                     
select s_AppCodeName,n_AppCodeId from tbl_ApplicationCodeMaster where s_AppCode=''DEPARTMENT''                 
              
--Begin                
 select n_UserId UserId,s_UserName UserName,s_Password Password,n_IsActive IsActive,s_FirstName FirstName,s_LastName LastName from tbl_UserMaster                  
End                
else              
select ''Failed'' as Status,''Invalid Login.'' as Message , 0 as UserId,'''' as  UserName, '''' as Name              
              
end' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertUpdateWorkOrder]    Script Date: 11/27/2015 18:38:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_InsertUpdateWorkOrder]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/*

EXEC [usp_InsertUpdateWorkOrder]  

*/

CREATE PROCEDURE [dbo].[usp_InsertUpdateWorkOrder]  
(  
    @pn_WorkorderNo   Int OutPut    ,   
    @pd_WoDate       DateTime    ,  
    @pn_CustomerId      Int           ,  
    @ps_Remark           Varchar(500)     ,  
    @pn_WareHouseId      TinyInt          ,  
    @px_WorkorderList    NVarchar(max)    ,  
    @pn_ActivityStatus   SmallInt         ,                 
    @pn_Status           SmallInt         ,               
    @pn_ModifiedBy       SmallInt         ,  
    @px_RetrvalBoxFile   NVarchar(max)    ,  
    @pn_ServiceRequestNo Int  
)  
As    
Begin --BEGIN PROC     
    Set NoCount On   
    Begin Transaction;  
    Begin Try   
 Declare @WorkorderNo Int  
 Declare @WorkOrderYear Int  
  
 If Exists(Select 1  From tbl_WorkOrder )  
 Begin  
     Select @WorkOrderYear =  CONVERT(Int,Substring(CONVERT(varchar,(Select MAX(n_WorkorderNo)  From tbl_WorkOrder)),1,4)) From tbl_WorkOrder  
  
     If(@WorkOrderYear ! = DATEPART(YEAR,GETDATE()))  
     Begin  
  Select @WorkorderNo = Convert(Int,  CONVERT(Varchar, DATEPART(YEAR,GETDATE()))+''000001'')  
     End  
     Else  
  Select @WorkorderNo =  (MAX(n_WorkorderNo) +1 ) From tbl_WorkOrder  
     End  
 Else  
 Begin  
     Select @WorkorderNo = Convert(Int,  CONVERT(Varchar, DATEPART(YEAR,GETDATE()))+''000001'')  
 End  
  
  print @WorkorderNo 
  
 IF(@pn_ServiceRequestNo=0) --this condition true when WO not created against Service Request [PURE WO]  
 BEGIN  
     Select @pn_WorkorderNo = @WorkorderNo    
     Insert Into tbl_WorkOrder  
     (n_WorkorderNo,  
     d_WoDate,     n_CustomerId,  
     s_Remark,     n_WareHouseId,  
     n_Status,     d_ModificationDate,  
     n_ModifiedBy)  
     Values  
     (  
     @WorkorderNo,  
     @pd_WoDate,     @pn_CustomerId,  
     @ps_Remark,     @pn_WareHouseId,  
     @pn_Status,     GETDATE(),               
     @pn_ModifiedBy               
     )  
  
     Declare @IsErrorinWoActivity TinyInt   
     Set @IsErrorinWoActivity = 0       
     exec usp_InsertUpdateWoActivities @px_WorkorderList , 0,@pn_ModifiedBy,@pn_ActivityStatus,0,0,@pn_WorkorderNo,  
     @px_RetrvalBoxFile,@IsErrorinWoActivity Output  
 END  
 ELSE --this condition came when WO created against Service Request [SR WO]  
 BEGIN    
              
     Select @pn_WorkorderNo = @WorkorderNo    
     Insert Into tbl_WorkOrder  
     (n_WorkorderNo,  
     d_WoDate,     n_CustomerId,  
     s_Remark,     n_WareHouseId,  
     n_Status,     d_ModificationDate,  
     n_ModifiedBy, n_RequestNo )  
     Values  
     (  
     @WorkorderNo,  
     @pd_WoDate,     @pn_CustomerId,  
     @ps_Remark,     @pn_WareHouseId,  
     @pn_Status,     GETDATE(),               
     @pn_ModifiedBy, @pn_ServiceRequestNo  
     )  
     Set @IsErrorinWoActivity = 0  
  
     declare @Count int  
     declare @AuditRoomCharges int    
     declare @DocSrch int, @FileRetreival int  
  
     select @DocSrch =n_ActivityId From tbl_Activity Where s_ActivityName =''Document Searching & Insertion''  
     select @FileRetreival =n_ActivityId From tbl_Activity Where s_ActivityName =''File Retrieval''  
  
     select @AuditRoomCharges = n_ActivityId From tbl_Activity Where s_ActivityName = ''Audit Room Charges''  
  
     select @Count =SUM(CRA.n_FileCount ) FROM tbl_CustomerRequestActivities CRA   
     JOIN (select n_ActivityId,s_ActivityName from tbl_Activity Where n_ServiceCategoryId = 3) ACT ON CRA.n_ActivityId =ACT.n_ActivityId      
     Where CRA.n_RequestNo =@pn_ServiceRequestNo  
     AND CRA.n_ActivityId <> @AuditRoomCharges  
                  
     --Insert Into tbl_WoActivities(n_WorkOrderNo,n_ActivityId,n_BoxCount,n_FileCount,s_Remark,d_ModificationDate,  
     --n_ModifiedBy,n_DepartmentId,d_ActivityDate,n_PickupAddressId,n_ActivityStatus)  
  
     --select @WorkorderNo,n_ActivityId,n_BoxCount,n_FileCount,s_Remark,GETDATE(),@pn_ModifiedBy,n_DepartmentId,d_ActivityDate,  
     --n_PickupAddressId,ACMWO.n_AppCodeId From tbl_CustomerRequestActivities CRA JOIN  
     --tbl_ApplicationCodeMaster ACM ON CRA.n_ActivityStatus =ACM.n_AppCodeId JOIN  
     --tbl_ApplicationCodeMaster ACMWO ON ACM.s_AppCodeName = ACMWO.s_AppCodeName AND ACMWO.s_AppCode=''ACTIVITY_STATUS''  
     --Where n_RequestNo =@pn_ServiceRequestNo  
       --Declare @IsErrorinWoActivity TinyInt   

     Set @IsErrorinWoActivity = 0       
     exec usp_InsertUpdateWoActivities @px_WorkorderList , 0,@pn_ModifiedBy,@pn_ActivityStatus,0,0,@pn_WorkorderNo,  
     @px_RetrvalBoxFile,@IsErrorinWoActivity Output  

     if(@Count>0)  
     Begin  
	  Insert Into tbl_WoActivities(n_WorkOrderNo,n_ActivityId,n_BoxCount,n_FileCount,s_Remark,d_ModificationDate,  
	  n_ModifiedBy,n_DepartmentId,d_ActivityDate,n_PickupAddressId,n_ActivityStatus)  
                           
	  select top 1 @WorkorderNo,@DocSrch,0,@Count,s_Remark,GETDATE(),@pn_ModifiedBy,null,null,  
	  null,n_ActivityStatus From tbl_WoActivities Where n_WorkOrderNo=@WorkorderNo  
	  UNION  
	  select top 1 @WorkorderNo,@FileRetreival,0,@Count,s_Remark,GETDATE(),@pn_ModifiedBy,null,null,  
	  null,n_ActivityStatus From tbl_WoActivities Where n_WorkOrderNo=@WorkorderNo  
     End
  print ''Updating tbl_CustomerRequest''   
  print @pn_WorkorderNo
  print @pn_ServiceRequestNo
     Update tbl_CustomerRequest Set n_WorkOrderNo=@pn_WorkorderNo Where n_RequestNo=@pn_ServiceRequestNo  
  print ''Updated '' 
     Insert Into tbl_BoxFileRetrivaldetails (n_IsBoxFile,n_workOrderActivity,s_BoxBarCode,s_FileBarCode,n_ModifiedBy,d_ModifiedDate)   
  
     select A.n_IsBoxFile,W.n_WoActivityId, s_BoxBarCode,s_FileBarCode,@pn_ModifiedBy,GETDATE() from tbl_BoxFileRetrivaldetailsServiceRequest A   
     JOIN  
     (  select n_RequestActivityId,n_ActivityId  from tbl_CustomerRequestActivities Where n_RequestNo =  
     (select n_RequestNo from tbl_CustomerRequest Where n_WorkOrderNo =@pn_WorkorderNo)  
     AND n_ActivityId IN (select n_ActivityId From tbl_Activity Where s_ActivityName not like ''%hand%'')  
     ) B ON A.n_ServiceRequestActivity=B.n_RequestActivityId  
     JOIN tbl_WoActivities W ON n_WorkOrderNo=@pn_WorkorderNo AND W.n_ActivityId IN   
     (select n_ActivityId From tbl_Activity Where s_ActivityName not like ''%hand%'')  
     AND W.n_ActivityId =B.n_ActivityId       
     print ''End of Loop'' 
 END  
 If(@IsErrorinWoActivity =1)  
 Begin  
     RAISERROR (''Error In Inserting Work Order Activity.'',  
     16, -- Severity.  
     1 -- State.  
     );  
 End  
 Else  
 Begin                                                       
         COMMIT TRANSACTION;  
 End  
    End Try  
    Begin Catch    
 Exec usp_GetErrorInfo    
 IF @@TRANCOUNT > 0  
 ROLLBACK TRANSACTION;  
    End Catch    
End --END PROC' 
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_InsertUpdateFileDetails_2]    Script Date: 11/27/2015 18:38:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Usp_InsertUpdateFileDetails_2]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N' -- [Usp_InsertUpdateFileDetails_2] 0, ''SAS5013'', ''SAS50F4'', 3, ''FILE 1 Desc1'',''FILE 1 Desc2'', ''DGDT'', ''2014'', ''01-10-2012'', ''31-10-2013'' , ''11'', ''33'', ''31-10-2014'',259, 3986, 0           
          
 -- [Usp_InsertUpdateFileDetails_2] 49392, ''926_P1'', ''926_F1'', 3, ''926_F1 File'','''', '''', '''', '''', '''' , '''', '''', '''', 47, 0        
  -- [Usp_InsertUpdateFileDetails_2] 0, ''1231_B1'', ''1231_file2'', 111, '''','''', '''', '''', '''', '''' , '''', '''', '''', 268, 4153 ,0,0       
          
CREATE procedure [dbo].[Usp_InsertUpdateFileDetails_2]          
@FileId int,          
@BoxBarcode nvarchar(250),                            
@FileBarcode nvarchar(250),                                              
@Department int,               
@FileDesc1 nvarchar(250),                              
@FileDesc2 nvarchar(250),              
@FileType varchar(15),                
@Year varchar(15) ,              
@FromDate varchar(30),                           
@ToDate varchar(30),                        
@FromNum varchar(15),                           
@ToNum varchar(15),              
@DestructionDueDate varchar(30),      
@BranchId int,     
@WoActivityId int,       
@isExist int out ,    
@IsNew      Bit  --0 = New 1 = Update                
AS                            
BEGIN           
        
/* PROCEDURE CONSTANTS */                    
Declare @Activity_NewBoxCost int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''New Standard Box Cost (1.50 Cubic Ft.)'')                     
Declare @Activity_BarcodingDataEntry int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''Bar-coding & Data Entry (File & Box)'')                     
Declare @Activity_StandardBoxTransportation int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''Standard Box Transportation'')                     
Declare @Activity_FileRetrievalRegular int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''File Retrievals  Regular (Within 24 hours)'')                     
Declare @Activity_FileRetrievalExpress int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''File Retrievals  Express (Within 12 hours)'')                     
Declare @Activity_FileRestoreRegular int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''File Restore Regular (Within 24 hours)'')                     
Declare @Activity_FileRestoreExpress int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''File Restore Express (Within 12 hours)'')                     
Declare @Status_WorkOrder_Open int = (Select n_AppCodeId From tbl_applicationcodemaster Where s_AppCode = ''WORKORDER_STATUS'' And s_AppCodeName = ''Open'')             
Declare @Status_WorkOrder_Closed int = (Select n_AppCodeId From tbl_applicationcodemaster Where s_AppCode = ''WORKORDER_STATUS'' And s_AppCodeName = ''Closed'')          
Declare @Status_in int = (Select n_AppCodeId From tbl_applicationcodemaster Where s_AppCode = ''BOXFILE_STATUS'' And s_AppCodeName = ''In'')          
Declare @Status_Out int = (Select n_AppCodeId From tbl_applicationcodemaster Where s_AppCode = ''BOXFILE_STATUS'' And s_AppCodeName = ''Out'')          
Declare @ApproveStatus_Approved int = (Select n_AppCodeId From tbl_applicationcodemaster Where s_AppCode = ''BOXFILE_STATUS'' And s_AppCodeName = ''Approved'')          
Declare @ApproveStatus_Reject int = (Select n_AppCodeId From tbl_applicationcodemaster Where s_AppCode = ''BOXFILE_STATUS'' And s_AppCodeName = ''Reject'')            
Declare @ApproveStatus_Pending int = (Select n_AppCodeId From tbl_applicationcodemaster Where s_AppCode = ''BOXFILE_STATUS'' And s_AppCodeName = ''Pending'')               
/* PROCEDURE CONSTANTS */       
--select ''1''          
       if exists(select n_FileId from tbl_FileDetails where s_FileBarCode = @FileBarcode ) and @IsNew = 0
       begin
      -- select ''11''
       set @isExist = -1
       return
       end 
--select ''2''                     
 begin try          
 if (@Department=0 or @Department='''')                                                                                                         
 set @Department=Null          
 if(@FileDesc1='''' or @FileDesc1 is null )                                                                                                                                                                  
 set @FileDesc1=null         
 if(@FileDesc2='''' or @FileDesc2 is null )                                                                                                                                                                  
 set @FileDesc2=null            
 if(@FileType='''' or @FileType is null )                                                                
 set @FileType=null           
  if(@Year='''' or @Year is null )                                                                                                                                                                  
 set @Year=null        
     
 if(@FromDate='''' or @FromDate is null )                                                             
 set @FromDate=null    
 else  
 set @FromDate = convert(datetime, @FromDate, 103)   
         
  if(@ToDate='''' or @ToDate is null )                                                                                                                                                                  
 set @ToDate=null   
 else  
 set @ToDate = convert(datetime, @ToDate, 103)   
          
  if(@FromNum='''' or @FromNum is null )                                                                                                                                                                  
 set @FromNum=null          
  if(@ToNum='''' or @ToNum is null )                                                                                                                                                                  
 set @ToNum=null          
 if(@DestructionDueDate='''' or @DestructionDueDate is null )                                                                                                                                                                  
 set @DestructionDueDate= null  
else   
set @DestructionDueDate = convert(datetime, @DestructionDueDate, 103)       
--select ''3''                       
   declare @BoxId int          
    --select @BoxId=n_BoxId from tbl_FileDetails where n_FileId = @FileId                     
-- if exists (select n_FileId from tbl_FileDetails where s_FileBarCode=''926_F1'' and n_FileId <> 49392)          
      
 -- if @FileId=0                                                                                                                                                      
 --begin           
 --select @BoxId=n_BoxId from tbl_BoxDetails where s_BoxBarCode = @BoxBarcode         
 ----print n_BoxId                          
 --INSERT INTO [dbo].[tbl_FileDetails] (          
 --          [n_BoxId], [s_FileBarCode], [s_FileName], [n_BranchId], [n_DepartmentId], [s_Year], [d_FromDate], [d_EndDate], [s_Label1], [s_Label2],          
 --           [s_Label3], [n_Status], [d_ModifiedDate], [n_ModifiedBy], [n_ApproveStatus], [s_FileDescription1] ,[d_DestructionDueDate]             
 --          )          
 --    VALUES (                                                                                                                        
 --   @BoxId, @FileBarcode, @FileDesc1, @BranchId ,@Department, @Year, @FromDate, @ToDate, @FileType, @FromNum, @ToNum, @Status_in,    
 --     GETDATE(), 1, @ApproveStatus_Pending, @FileDesc2, @DestructionDueDate          
 --    )          
 --   set @isExist = 0          
 --end           
--select ''4''                     
if exists(select n_FileId from tbl_FileDetails where n_FileId = @FileId )  --s_FileBarCode=@FileBarcode and n_FileId <> @FileId        
  begin  
  --select ''5''                 
  select @BoxId=n_BoxId from tbl_FileDetails where n_FileId = @FileId                             
 UPDATE [dbo].[tbl_FileDetails]          
   SET [n_BoxId] = @BoxId          
      ,[s_FileBarCode] = @FileBarcode          
      ,[s_FileName] = @FileDesc1          
      --,[n_BranchId] = <n_BranchId, int,>          
      ,[n_DepartmentId] = @Department          
      ,[s_Year] = @Year          
      ,[d_FromDate] = convert(datetime, @FromDate, 103)            
      ,[d_EndDate] = convert(datetime, @ToDate, 103)          
      ,[s_Label1] = @FileType          
      ,[s_Label2] = @FromNum          
   ,[s_Label3] = @ToNum          
      ,[n_Status] = @Status_in          
      ,[d_ModifiedDate] = GETDATE()          
      ,[n_ModifiedBy] = 1          
      ,[n_ApproveStatus] = @ApproveStatus_Pending          
      ,[s_FileDescription1] = @FileDesc2          
      ,[d_DestructionDueDate] = convert(datetime, @DestructionDueDate, 103)          
 WHERE n_FileId=@FileId and s_FileBarCode=@FileBarcode          
 set @isExist = 1    
 print   @isExist         
 end    
        
 else             
 begin     
 --select ''6''           
 
 select @BoxId=n_BoxId from tbl_BoxDetails where s_BoxBarCode = @BoxBarcode                              
 INSERT INTO [dbo].[tbl_FileDetails] (          
           [n_BoxId], [s_FileBarCode], [s_FileName], [n_BranchId], [n_DepartmentId], [s_Year], [d_FromDate], [d_EndDate], [s_Label1], [s_Label2],          
            [s_Label3], [n_Status], [d_ModifiedDate], [n_ModifiedBy], [n_ApproveStatus], [s_FileDescription1] ,[d_DestructionDueDate]             
           )          
     VALUES (                                                                                                                        
    @BoxId, @FileBarcode, @FileDesc1, @BranchId ,@Department, @Year, @FromDate, @ToDate, @FileType, @FromNum, @ToNum, @Status_in,    
      GETDATE(), 1, @ApproveStatus_Pending, @FileDesc2, @DestructionDueDate          
     )          
    set @isExist = 0     
     print   @isExist      
    --SET @FileId=SCOPE_IDENTITY()    
    --print @FileId    
    --select ''7''          
    Insert Into tbl_FileTransactions(n_FileId , n_WoActivityId ,d_ModifiedDate ,n_ModifiedBy) VALUES (SCOPE_IDENTITY(), @WoActivityId, GETDATE(), 1)  
 end    
--select ''8''                     
 end try                     
 begin catch                              
 end catch  
  --       select ''9''           
END ' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_EditMakerSearchData]    Script Date: 11/27/2015 18:38:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_EditMakerSearchData]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'      
      
           
                  
CREATE PROCEDURE [dbo].[usp_EditMakerSearchData] -- usp_EditMakerSearchData 65665           
@FileId int          
AS                            
BEGIN           
/* PROCEDURE CONSTANTS */                    
Declare @Activity_NewBoxCost int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''New Standard Box Cost (1.50 Cubic Ft.)'')                     
Declare @Activity_BarcodingDataEntry int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''Bar-coding & Data Entry (File & Box)'')                     
Declare @Activity_StandardBoxTransportation int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''Standard Box Transportation'')                     
Declare @Activity_FileRetrievalRegular int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''File Retrievals  Regular (Within 24 hours)'')                     
Declare @Activity_FileRetrievalExpress int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''File Retrievals  Express (Within 12 hours)'')                     
Declare @Activity_FileRestoreRegular int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''File Restore Regular (Within 24 hours)'')                     
Declare @Activity_FileRestoreExpress int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''File Restore Express (Within 12 hours)'')                     
Declare @Status_WorkOrder_Open int = (Select n_AppCodeId From tbl_applicationcodemaster Where s_AppCode = ''WORKORDER_STATUS'' And s_AppCodeName = ''Open'' )             
Declare @Status_WorkOrder_Closed int = (Select n_AppCodeId From tbl_applicationcodemaster Where s_AppCode = ''WORKORDER_STATUS'' And s_AppCodeName = ''Closed'' )                   
/* PROCEDURE CONSTANTS */           
 begin try                              
   select          
  distinct fd.n_FileId ''FileId'',           
    BD.s_BoxBarCode ''Box Barcode'', 
    BD.n_BoxId ''Box Id'',                            
    --BD.s_LocationCode  ''Box Location'', 
     BD.n_CustomerId ''Customer Id'',  
    Tc.n_CompanyGroupId ''Group Id'',                        
    --BD.s_LocationCode  ''Box Location'', 
    fd.s_ImageExtention ''Image Extention'',           
    FD.s_FileBarCode ''File BarCode'',                          
    FD.s_FileName ''File Description1'',                            
    FD.s_FileDescription1 ''File Description2'', fd.n_DepartmentId ''DepartmentId'' ,          
    --FD.s_Year ''Year'' ,CONVERT(Varchar(10), Convert(Date,FD.d_FromDate,103),103) ''FromDate''   ,     
    FD.s_Year ''Year'' ,CONVERT(Varchar(20),FD.d_FromDate,113) ''FromDate''   ,                     
    --CONVERT(Varchar(10), Convert(Date,FD.d_EndDate ,103),103) ''ToDate''  ,  
    CONVERT(Varchar(20),FD.d_EndDate ,113) ''ToDate''  ,               
    FD.s_Label1 ''File Type'',          
    FD.s_Label2 ''From No'',FD.s_Label3 ''To No'',                            
    CONVERT(Varchar(20), FD.d_DestructionDueDate,113) ''Destruction Due Date'' , FD.n_ModifiedBy ''ModifiedBy'' ,     
    acm.s_AppCodeName  ''ApproveStatus''         
    from     tbl_FileDetails fd          
    inner join tbl_FileTransactions ft on fd.n_FileId=ft.n_FileId            
    inner join tbl_BoxDetails bd on bd.n_BoxId=fd.n_BoxId       
    inner join tbl_ApplicationCodeMaster ACM on ACM.n_AppCodeId=FD.n_ApproveStatus  
     join tbl_Customer Tc on Tc.n_CustomerId = bd.n_CustomerId         
    where          
     (FD.n_FileId = @FileId)          
 end try                              
 begin catch                              
 end catch                            
END ' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_CheckFPCountForCloseWOActivity]    Script Date: 11/27/2015 18:38:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_CheckFPCountForCloseWOActivity]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE Procedure [dbo].[usp_CheckFPCountForCloseWOActivity]  
(  
 @WORKORDER int  
 ,@TYPE int  
)  
As  
Begin  
  
 declare @SC int  
 Create Table #RESULT (Pending bit, MSG varchar(500))  
  
 IF (@TYPE=1)    --type is for File Pick Up Service of Work Order  
 Begin  
  Declare @WOFPBX int, @WOFPFL int, @AFPBX int, @AFPFL int  
  
  select @SC = n_ServiceCategoryId from tbl_ServiceCategory Where s_SCName like ''%File Pick Up%''  
  
  select @WOFPBX = SUM(n_BoxCount) From tbl_WoActivities Where n_WorkOrderNo = @WORKORDER AND n_ActivityId   
  = (select n_ActivityId from tbl_Activity where n_ServiceCategoryId = @SC AND s_ActivityName like ''%New Standard Box Cost (1.50 Cubic Ft.)%'')  
  select @WOFPFL =SUM(n_FileCount) From tbl_WoActivities Where n_WorkOrderNo = @WORKORDER AND n_ActivityId = 2  
  
  select  @AFPBX = COUNT(distinct FD.n_boxID),@AFPFL = COUNT(distinct FD.n_fileID)  from   
  (select n_boxID,n_fileID from tbl_FileDetails Where d_CheckerDate IS NOT NULL AND n_CheckerBy IS NOT NULL) FD   --n_BoxId,n_FileId,  
  JOIN   
  (select n_BoxId,n_WoActivityId from tbl_BoxTransactions ) BT ON FD.n_BoxId=BT.n_BoxId  
  JOIN  
  (select n_WoActivityId from tbl_WoActivities Where n_WorkOrderNo = @WORKORDER AND n_ActivityId = 1) WOA ON BT.n_WoActivityId = WOA.n_WoActivityId  
  
  --select @WOFPBX ''FilePickUpBoxes'',@WOFPFL ''FilePickUpFiles''  
  --UNION ALL  
  --select  @AFPBX ''AppFilePickUpBoxes'',@AFPFL ''AppFilePickUpFiles''  
  
  if(@WOFPBX = @AFPBX )  
  Begin  
   Insert Into #RESULT (Pending,MSG)  
   select 1 as ''Pending'','''' as ''MSG''  --BOXES OK  
  End  
  else  
  Begin  
   Insert Into #RESULT (Pending,MSG)  
   select 0 as ''Pending'',''Box Counts in Word Order (''+ CONVERT(Varchar(10),@WOFPBX)+  '') and Maker/Checker (''+ CONVERT(Varchar(10),@AFPBX)+ '') Do Not Match ''  as ''MSG''  
  End  
     
  if(@WOFPFL = @AFPFL)  
  Begin  
   Insert Into #RESULT (Pending,MSG)  
   select 1 as ''Pending'','''' as ''MSG''  --FILES OK  
  End  
  else  
  Begin  
   Insert Into #RESULT (Pending,MSG)  
   select 0 as ''Pending'',''File Counts in Work Order (''+CONVERT(Varchar(10),@WOFPFL)+'') and Maker/Checker (''+CONVERT(Varchar(10),@AFPFL) + '') Do Not Match'' as ''MSG''  
  End  
 End  
 IF (@TYPE=2)       --type is for Other Services (File Pick Up) Service of Work Order  
 Begin  
  declare @ACTID int  
  
  select @SC = n_ServiceCategoryId from tbl_ServiceCategory Where s_SCName like ''%Other services%''  
     
  select @ACTID =n_ActivityId from tbl_Activity where n_ServiceCategoryId = @SC AND s_ActivityName like ''%File Retrieval%''  
  IF EXISTS(select n_WoActivityId from tbl_WoActivities Where n_WorkOrderNo = @WORKORDER AND n_ActivityId = @ACTID)  
  Begin  
   IF EXISTS (select n_Amount From tbl_OtherTransactions OT JOIN  
   (select n_WoActivityId from tbl_WoActivities Where n_WorkOrderNo = @WORKORDER AND n_ActivityId = @ACTID) WOA ON OT.n_WoActivityId = WOA.n_WoActivityId)  
   Begin  
    Insert Into #RESULT (Pending,MSG)  
    select 1 as ''Pending'', '''' as ''MSG''  
   End  
   Else  
   Begin  
    Insert Into #RESULT (Pending,MSG)  
    select 0 as ''Pending'', ''Other services (File Retreival) file count transactions are pending''  
   End  
  End  
  else  
  Begin  
   Insert Into #RESULT (Pending,MSG)  
   select 1 as ''Pending'', '''' as ''MSG''  
  End  
 End  
   
 IF (@TYPE=3)       --type is for Retreival Service of Work Order  
 Begin  
   Create Table #RetreivalWOActivities  (IID int identity(1,1),n_WoActivityId int, STS char(1) default ''N'', FB char(1),FC int, BC int)  
     
   Insert Into #RetreivalWOActivities (n_WoActivityId,FB,FC,BC)  
     
   select n_WoActivityId,Case When n_BoxCount =0 AND n_FileCount >0 Then ''F'' When n_BoxCount >0 AND n_FileCount =0 Then ''B''  
   When n_BoxCount >0 AND n_FileCount >0 Then ''A'' End as FB, n_FileCount, n_BoxCount  
   From tbl_WoActivities WOA JOIN  
   ( select n_ActivityId from tbl_Activity Where n_ServiceCategoryId = (   
   select n_ServiceCategoryId from tbl_ServiceCategory Where s_SCName like ''%Retrieval%'')   
   AND s_ActivityName not like ''%hand%'') ACT ON WOA.n_ActivityId=ACT.n_ActivityId AND WOA.n_WorkOrderNo =@WORKORDER  
     
   declare @MAX int , @COUNT int=1, @FC int, @BC int  
     
   select @MAX = COUNT(*) From #RetreivalWOActivities  
   while(@COUNT <=@MAX)  
   Begin  
   if exists(select n_WoActivityId  From #RetreivalWOActivities Where IID=@COUNT AND FB=''F'')  
   Begin  
    if exists (select n_WoActivityId from tbl_FileTransactions Where n_WoActivityId = (select n_WoActivityId  From #RetreivalWOActivities Where IID=@COUNT))  
    BEGIN  
     Update #RetreivalWOActivities set STS=''Y'' Where IID=@COUNT  
    END  
   END  
     
   if exists(select n_WoActivityId  From #RetreivalWOActivities Where IID=@COUNT AND FB=''B'')  
   Begin  
    if exists (select n_WoActivityId from tbl_BoxTransactions Where n_WoActivityId = (select n_WoActivityId  From #RetreivalWOActivities Where IID=@COUNT))  
    BEGIN  
     Update #RetreivalWOActivities set STS=''Y'' Where IID=@COUNT  
    END  
   END  
     
   if exists(select n_WoActivityId  From #RetreivalWOActivities Where IID=@COUNT AND FB=''A'')  
   Begin  
    if exists (select n_WoActivityId from tbl_FileTransactions Where n_WoActivityId = (select n_WoActivityId  From #RetreivalWOActivities Where IID=@COUNT))  
    BEGIN  
     Update #RetreivalWOActivities set STS=''Y'' Where IID=@COUNT  
    END   
    else  
    Begin  
     if exists (select n_WoActivityId from tbl_BoxTransactions Where n_WoActivityId = (select n_WoActivityId  From #RetreivalWOActivities Where IID=@COUNT))  
     BEGIN  
      Update #RetreivalWOActivities set STS=''Y'' Where IID=@COUNT  
     END   
    End  
   End  
   set @COUNT=@COUNT+1  
   End  
   IF Exists(select STS From #RetreivalWOActivities Where STS=''N'' AND FB =''F'')     
   Begin  
   Select @FC =FC From #RetreivalWOActivities Where STS=''N'' AND FB =''F''  
   Insert Into #RESULT (Pending,MSG)  
   select 0 as ''Pending'', ''In Retreival -''+ CONVERT(Varchar(10),@FC)+'' file transactions pending''  
   End  
   IF Exists(select STS From #RetreivalWOActivities Where STS=''N'' AND FB =''B'')     
   Begin  
   Select @BC =BC From #RetreivalWOActivities Where STS=''N'' AND FB =''B''  
   Insert Into #RESULT (Pending,MSG)  
   select 0 as ''Pending'', ''In Retreival -''+ CONVERT(Varchar(10),@BC)+'' Box transactions pending''  
   End  
   --drop table #RetreivalWOActivities  
 End  
  select * from #RESULT  
  --select * from #RetreivalWOActivities  
  drop table #RESULT  
End' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_ApproveFileDetails]    Script Date: 11/27/2015 18:38:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_ApproveFileDetails]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/*************************************************************************************************/    
    
/*************************************************************************************************/    
CREATE Procedure [dbo].[usp_ApproveFileDetails]              
(              
 @pn_CustomerId       Int         ,                   
 @pn_WareHouseId      TinyInt       ,                
 @ps_xmlFileDetails   nVarchar(Max)  ,              
 @pn_WoNo   Int   ,              
 @pn_ModifiedBy       SmallInt  ,               
 @IsNew      Bit  --0 = Approved  1 = Update               
)              
As      
Begin-- Begin Proc [usp_ApproveFileDetails]              
Begin Tran              
 Begin Try          
       
  DECLARE @xmlR [nvarchar](MAX)        
            
    Create Table #TempxmlFileDetails              
   (               
    BoxId     Int              ,              
    BoxBarCode    Varchar(16)  , FileBarCode    Varchar(16)      ,           
    FileId     Int              ,                
    sFileName     Varchar(255)          , Department varchar(50)   ,          
    sYear         Varchar(30)           , FromDate       Varchar(20)       ,              
    EndDate       Varchar(20)           , Label1         Varchar(500)      ,                    
    Label2        Varchar(500)    , Label3         Varchar(500)    ,                 
    FileRemarks   Varchar(200) Null,                               
    FileStatus    Varchar(15) Null  ,  DepartmentId   Int                 
   )               
              
  Declare @docHandle Int;      
  SET @xmlR = REPLACE(@ps_xmlFileDetails,''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'','''')                
  --Exec sp_xml_preparedocument @docHandle Output, @ps_xmlFileDetails;                
  Exec sp_xml_preparedocument @docHandle Output, @xmlR;                
  Insert Into #TempxmlFileDetails           
  Select * From OpenXml(@docHandle, ''/NewDataSet/Root'',2) With #TempxmlFileDetails               
  Exec sp_xml_removedocument @docHandle;           
               
  ----Get Pick Address Id               
                
   IF @IsNew =0             
  begin            
                     
  Update  tbl_FileDetails              
  Set s_FileRemarks     = case when  FileStatus = ''Reject'' then FileRemarks else null end    ,          
  n_ApproveStatus = (Select   n_AppCodeId  From tbl_ApplicationCodeMaster ACM Where s_AppCode = ''BOXFILE_STATUS''             
  And s_AppCodeName = T.FileStatus ) ,                
  d_CheckerDate   = case when  FileStatus = ''Approved'' then GETDATE() else null end      ,                  
  n_CheckerBy     = case when  FileStatus = ''Approved'' then @pn_ModifiedBy else null end                   
  From tbl_FileDetails TFD               
  Inner join               
  #TempxmlFileDetails T On               
  TFD.n_FileId = T.FileId               
                  
   Drop table #TempxmlFileDetails   
   
/* LOGIC FOR UPDATING FILE AND BOX COUNTS IN WOACTIVITES */
/* THIS NEEDS TO BE REVISITED TO MAKE IT SIMPLE       */
     
   Declare @Activity_NewBoxCost int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''New Standard Box Cost (1.50 Cubic Ft.)'')           
   Declare @Activity_BarcodingDataEntry int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''Bar-coding & Data Entry (File & Box)'')           
   Declare @Activity_StandardBoxTransportation int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''Standard Box Transportation'')      
   Declare @Status_File_Approved int =  ( Select   n_AppCodeId  From tbl_ApplicationCodeMaster ACM Where s_AppCode = ''BOXFILE_STATUS'' And s_AppCodeName = ''Approved'' ) 

/* PREVIOUS ONE COMMENTED */     
   --declare @filecount int  
   --declare @boxcount int  
   --select @filecount = dbo.fn_GetWOBoxFileCount (@pn_WoNo , ''File'',''Approved'' )      
   --select @boxcount = dbo.fn_GetWOBoxFileCount ( @pn_WoNo , ''Box'' , '''' )        

     
   --update tbl_WoActivities   
   --set n_FileCount=@filecount  
   --where n_WorkOrderNo= @pn_WoNo  And n_ActivityId in (@Activity_BarcodingDataEntry)   
     
   --update tbl_WoActivities   
   --set n_BoxCount=@boxcount  
   --where n_WorkOrderNo= @pn_WoNo  And n_ActivityId in (@Activity_NewBoxCost,@Activity_StandardBoxTransportation)  
/* PREVIOUS ONE COMMENTED */        
   
update tbl_WoActivities set n_FileCount = ApprovedFileCount 
from tbl_WoActivities join  ( 
       select n_WoActivityId  , n_activityid ,
     (select COUNT(TFT.n_FileId) from tbl_WoActivities TWA 
     join tbl_FileTransactions TFT on TWA.n_WoActivityId = TFT.n_WoActivityId 
     join tbl_FileDetails TFD on TFD.n_FileId = TFT.n_FileId 
     where TWA.n_WorkOrderNo = @pn_WoNo   and 
     TFD.n_ApproveStatus = @Status_File_Approved  and 
     TWA.n_WoActivityId = TWAA.n_WoActivityId
     )  ApprovedFileCount
     from tbl_WoActivities TWAA 
     where TWAA.n_WorkOrderNo  = @pn_WoNo  and n_ActivityId = @Activity_BarcodingDataEntry ) A on tbl_WoActivities.n_WoActivityId = A.n_WoActivityId 
     
     
     
update tbl_WoActivities set n_BoxCount  = BoxCount 
from tbl_WoActivities join  ( 
       select n_WoActivityId  , n_activityid ,
     (select COUNT(TBT.n_BoxId) from tbl_WoActivities TWA 
     join tbl_BoxTransactions TBT on TWA.n_WoActivityId = TBT.n_WoActivityId 
     join tbl_BoxDetails TBD on TBD.n_BoxId = TBT.n_BoxId 
     where TWA.n_WorkOrderNo = @pn_WoNo   and 
     TWA.n_WoActivityId = TWAA.n_WoActivityId
     )  BoxCount
     from tbl_WoActivities TWAA 
     where TWAA.n_WorkOrderNo  = @pn_WoNo  and n_ActivityId = @Activity_NewBoxCost  ) A on tbl_WoActivities.n_WoActivityId = A.n_WoActivityId      
     

update tbl_WoActivities set  n_BoxCount  = (select TWAA.n_BoxCount from tbl_WoActivities TWAA where TWAA.n_WorkOrderNo = tbl_WoActivities.n_WorkOrderNo and TWAA.n_PickupAddressId = tbl_WoActivities.n_PickupAddressId and TWAA.n_ActivityId =@Activity_NewBoxCost) where n_WorkOrderNo = @pn_WoNo  and n_ActivityId = @Activity_StandardBoxTransportation     
   
/*-----------UPDATE THE FILE /BOX COUNTS FINISHED HERE------------------*/         
  END               
   commit Tran              
                  
 End Try                
 Begin Catch                
 Rollback Tran              
 Exec usp_GetErrorInfo                
 End Catch     
End--End Proc [usp_ApproveFileDetails]    
/*************************************************************************************************/ 


select dbo.fn_GetWOBoxFileCount (2015001305 , ''File'',''Approved'' )      ' 
END
GO
