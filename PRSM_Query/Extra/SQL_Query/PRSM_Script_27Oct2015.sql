CREATE TABLE [tbl_BoxInfo](
	[BOX_BARCODE] [varchar](255) NULL
) ON [PRIMARY]
Go
CREATE TABLE [tbl_FileInfo](
	[FILE_BARCODE] [varchar](255) NULL,
	[BOX_BARCODE] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[usp_ApproveFileDetails]    Script Date: 10/27/2015 18:44:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_ApproveFileDetails]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_ApproveFileDetails]
GO
/****** Object:  StoredProcedure [dbo].[usp_getMakerSearchData]    Script Date: 10/27/2015 18:44:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_getMakerSearchData]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_getMakerSearchData]
GO
/****** Object:  StoredProcedure [dbo].[Usp_InsertUpdateBoxDetails_2]    Script Date: 10/27/2015 18:44:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Usp_InsertUpdateBoxDetails_2]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Usp_InsertUpdateBoxDetails_2]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetWOBoxFileCount]    Script Date: 10/27/2015 18:44:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_GetWOBoxFileCount]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_GetWOBoxFileCount]
GO
/****** Object:  StoredProcedure [dbo].[usp_LoginDetails]    Script Date: 10/27/2015 18:44:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_LoginDetails]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_LoginDetails]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetCustomerWiseData_App]    Script Date: 10/27/2015 18:44:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_GetCustomerWiseData_App]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_GetCustomerWiseData_App]
GO
/****** Object:  StoredProcedure [dbo].[usp_xlImp_ValidateTempData]    Script Date: 10/27/2015 18:44:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_xlImp_ValidateTempData]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_xlImp_ValidateTempData]
GO
/****** Object:  StoredProcedure [dbo].[usp_xlRetr_ValidateFile]    Script Date: 10/27/2015 18:44:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_xlRetr_ValidateFile]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_xlRetr_ValidateFile]
GO
/****** Object:  StoredProcedure [dbo].[usp_xlRetr_ValidateBox]    Script Date: 10/27/2015 18:44:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_xlRetr_ValidateBox]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_xlRetr_ValidateBox]
GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateLocationCodeByBarCode]    Script Date: 10/27/2015 18:44:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_UpdateLocationCodeByBarCode]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_UpdateLocationCodeByBarCode]
GO
/****** Object:  StoredProcedure [dbo].[USP_GetServiceRequestDetails]    Script Date: 10/27/2015 18:44:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USP_GetServiceRequestDetails]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[USP_GetServiceRequestDetails]
GO
/****** Object:  StoredProcedure [dbo].[USP_DemoGetServiceRequestByCustomer]    Script Date: 10/27/2015 18:44:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USP_DemoGetServiceRequestByCustomer]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[USP_DemoGetServiceRequestByCustomer]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetEmailIds]    Script Date: 10/27/2015 18:44:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_GetEmailIds]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_GetEmailIds]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetEmailIds]    Script Date: 10/27/2015 18:44:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_GetEmailIds]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'  
CREATE Procedure [dbo].[usp_GetEmailIds]      
@emailtype varchar(20) = null
As      
Begin      
SET NOCOUNT ON        
Select   
	s_EmailId As ''EmailId'',   
	s_EmailType As ''EmailType'' ,  
	n_ForCustomer,  
	n_ForAdmin  
From    
	tbl_EmailIds   
Where   
	b_IsActive=1  
	And (@emailtype is null or @emailtype = '''' or s_EmailType = @emailtype )
End ' 
END
GO
/****** Object:  StoredProcedure [dbo].[USP_DemoGetServiceRequestByCustomer]    Script Date: 10/27/2015 18:44:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USP_DemoGetServiceRequestByCustomer]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/*    
Created Date - 18APR2015    
Created Purpose - This procedure fetches all service requests which belongs to provided customer.    
*/    
CREATE PROCEDURE [dbo].[USP_DemoGetServiceRequestByCustomer]    
(@n_RequestNo INT)    
As    
Begin    
    
  select distinct CR.n_RequestNo as ''ServiceRequestNo'',TCUM.s_EmailId CustomerEmail,CR.n_CustomerId,TC.s_CustomerName CustomerName,TCG.s_CGName CompanyGroup ,TCUM.s_CustomerUserName CustomerUserName  
  from tbl_Customer TC  
  join tbl_CompanyGroup TCG on TCG.n_CompanyGroupId = TC.n_CompanyGroupId  
  --join tbl_WareHouseMaster TWH on TWH.n_WareHouseId = TCG.n_CorpCityId  
  JOIN tbl_CustomerRequest CR ON CR.n_CustomerId  = TC.n_CustomerId  
  JOIN tbl_ApplicationCodeMaster ACM ON CR.n_Status=ACM.n_AppCodeId    
  join tbl_CustomerUserMaster TCUM on CR.n_ModifiedBy = TCUM.n_CustomerUserId   
  JOIN tbl_CustomerUserDetails CUD ON CR.n_CustomerId =CUD.n_CustomerId    
  Where ACM.s_AppCode=''REQUEST_STATUS'' AND ACM.s_AppCodeName=''Open''    
  AND CR.n_WorkOrderNo IS NULL AND n_RequestNo=@n_RequestNo
    
   
End  
  
  
  ' 
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetServiceRequestDetails]    Script Date: 10/27/2015 18:44:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USP_GetServiceRequestDetails]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[USP_GetServiceRequestDetails]
 @pn_WorkOrderNo int,
 @pn_WorkOrderStatus int = null 
 as
 begin
/* PROCEDURE CONSTANTS */      
Declare @Status_WorkOrder_Open int = (Select n_AppCodeId From tbl_applicationcodemaster Where s_AppCode = ''WORKORDER_STATUS'' And s_AppCodeName = ''Open'' )        
Declare @Status_WorkOrder_Closed int = (Select n_AppCodeId From tbl_applicationcodemaster Where s_AppCode = ''WORKORDER_STATUS'' And s_AppCodeName = ''Closed'' )      

Declare @Status_ServiceRequest_Open int = (Select n_AppCodeId From tbl_applicationcodemaster Where s_AppCode = ''REQUEST_STATUS'' And s_AppCodeName = ''Open'' )        
Declare @Status_ServiceRequest_Closed int = (Select n_AppCodeId From tbl_applicationcodemaster Where s_AppCode = ''REQUEST_STATUS'' And s_AppCodeName = ''Closed'' )      
/* PROCEDURE CONSTANTS */ 

Select 
	TWO.n_WorkorderNo, 
	TWO.n_Status WorkOrderStatus,
	TACM.s_AppCodeName ,
	TCR.n_RequestNo,
	TCR.n_Status ServiceRequestStatus,  
	TACM_SR.s_AppCodeName, 
	TCU.s_EmailId CustomerEmail,
	TCU.s_CustomerUserName CustomerUserName
From 
	tbl_WorkOrder TWO 
	join tbl_CustomerRequest TCR on TWO.n_WorkorderNo = TCR.n_WorkOrderNo 
	join tbl_CustomerUserMaster TCU on TCU.n_CustomerUserId = TCR.n_ModifiedBy 
	join tbl_ApplicationCodeMaster TACM on TWO.n_Status = TACM.n_AppCodeId 
	join tbl_ApplicationCodeMaster TACM_SR on TACM_SR.n_AppCodeId = TCR.n_Status 
Where 
	TWO.n_WorkorderNo = @pn_WorkOrderNo
	and (@pn_WorkOrderStatus is null or TWO.n_Status = @pn_WorkOrderStatus) 
end

' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateLocationCodeByBarCode]    Script Date: 10/27/2015 18:44:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_UpdateLocationCodeByBarCode]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_UpdateLocationCodeByBarCode]  
	-- Add the parameters for the stored procedure here
	  @ps_xmlBoxLocDetails   Varchar(Max)  
AS
BEGIN
  Create Table #TempxmlBarcodeDetails  
   (   
    Id       Int   Identity(1,1)   ,
    BoxBarCode     Varchar(16)   , LocationBarCode    Varchar(50) ,    
	UserID   Int   
      
   )   
  
  Declare @docHandle Int;    
  Exec sp_xml_preparedocument @docHandle Output, @ps_xmlBoxLocDetails;    
  Insert Into #TempxmlBarcodeDetails Select * From OpenXml(@docHandle, ''/NewDataSet/BoxRackLocatioList'',2) With #TempxmlBarcodeDetails   
  Exec sp_xml_removedocument @docHandle;  
  
     Update  tbl_BoxDetails  
    Set s_LocationCode     =    T.LocationBarcode  ,  
    d_ModifiedDate        = GETDATE(),  
    n_ModifiedBy     = T.UserID  
    From tbl_BoxDetails TFD   
       Inner join   
       #TempxmlBarcodeDetails T On   
       TFD.s_BoxBarCode = T.BoxBarCode   
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	Create Table #TempResult  
		(   
		SrNo   Int   Identity(1,1) , 
		BoxCode      Varchar(16) null , Result  Varchar(100)                   
		)  

		--Updated Boxes
		Insert Into #TempResult Select   T.BoxBarCode ,''Success''       
		From #TempxmlBarcodeDetails T   
		Inner Join  tbl_BoxDetails TF On TF.s_BoxBarCode = T.BoxBarCode   
	    
	    --Not Found Boxes
		Insert Into #TempResult Select   T.BoxBarCode ,''Box Not Found''      
		From #TempxmlBarcodeDetails T   
		Left Join  tbl_BoxDetails TF On TF.s_BoxBarCode = T.BoxBarCode   
		Where TF.s_BoxBarCode  Is   Null  
      select * from #TempResult
    -- Insert statements for procedure here
	 
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_xlRetr_ValidateBox]    Script Date: 10/27/2015 18:44:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_xlRetr_ValidateBox]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_xlRetr_ValidateBox]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @retTable Table (ErrorMsg varchar(250))  
	declare @Status_Box_Out int = (Select n_AppCodeId From tbl_applicationcodemaster Where s_AppCode = ''BOXFILE_STATUS'' And s_AppCodeName = ''Out'' )

if exists ( select * from tbl_BoxInfo where [BOX_BARCODE] is null )   
begin   
 insert @retTable (ErrorMsg)   
 select ''Box bar code is blank for '' + convert ( varchar(10) , count(*))    + '' rows.''  from tbl_BoxInfo     
 where [BOX_BARCODE] is null     
end   

----BEGIN
insert @retTable (ErrorMsg)   
Select ''Box bar code is duplicate for '' + Rtrim(ltrim([BOX_BARCODE]))     
From tbl_BoxInfo      
Group by  [BOX_BARCODE]  having COUNT( Rtrim(ltrim([BOX_BARCODE]))) > 1
----END  

--insert @retTable (ErrorMsg)    
--Select ''Box bar code is duplicate for '' +  Rtrim(ltrim(BOX_BARCODE))         
--From tbl_BoxInfo          
--Group by  BOX_BARCODE  having COUNT( Rtrim(ltrim(BOX_BARCODE))) > 1    

if exists (Select TB.BOX_BARCODE from tbl_BoxInfo TB left join tbl_BoxDetails  TBD on TB.BOX_BARCODE = TBD.s_BoxBarCode where TBD.s_BoxBarCode is null  )
begin  
insert @retTable (ErrorMsg)  
	Select ''Box ''  + TB.BOX_BARCODE  + '' does not exist in the system.'' 
	from tbl_BoxInfo TB left join tbl_BoxDetails  TBD on TB.BOX_BARCODE = TBD.s_BoxBarCode where TBD.s_BoxBarCode is null
end 

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
 
 insert @retTable (ErrorMsg)  
select ''Box'' + TBD.s_BoxBarCode + ''is already retrieved''  from tbl_BoxInfo TBI
join tbl_BoxDetails TBD on TBD.s_BoxBarCode = TBI.BOX_BARCODE 
where TBD.n_Status = @Status_Box_Out 
 
 select * from @retTable 
End
  

' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_xlRetr_ValidateFile]    Script Date: 10/27/2015 18:44:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_xlRetr_ValidateFile]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[usp_xlRetr_ValidateFile]
	
AS
BEGIN
	
	SET NOCOUNT ON;
	declare @retTable Table (ErrorMsg varchar(250))  
	declare @Status_File_Out int = (Select n_AppCodeId From tbl_applicationcodemaster Where s_AppCode = ''BOXFILE_STATUS'' And s_AppCodeName = ''Out'' )
	declare @Status_File_In int = (Select n_AppCodeId From tbl_applicationcodemaster Where s_AppCode = ''BOXFILE_STATUS'' And s_AppCodeName = ''In'' )                    
    Declare @Status_Permanent_Out int =(Select n_AppCodeId From tbl_applicationcodemaster Where s_AppCode = ''BOXFILE_STATUS'' And s_AppCodeName = ''Out'' )
    Declare @Status_Destroy int=(Select n_AppCodeId from tbl_ApplicationCodeMaster where s_AppCode=''BOXFILE_STATUS'' AND s_AppCode=''OUT'')
	
	if exists ( select * from tbl_FileInfo where [FILE_BARCODE] is null )   
begin  
 insert @retTable (ErrorMsg)   
 select   
 (select ''File bar code is blank for '' + convert(varchar(10) , count(*)) + '' rows.'' from tbl_FileInfo     
 where [FILE_BARCODE]  is null )     
end   
  
insert @retTable (ErrorMsg)   
Select ''File bar code is duplicate for '' +  Rtrim(ltrim([FILE_BARCODE]))     
From tbl_FileInfo      
Group by   Rtrim(ltrim([FILE_BARCODE])) having COUNT( Rtrim(ltrim([FILE_BARCODE]))) > 1 

if exists ( select * from tbl_BoxInfo where [BOX_BARCODE] is null )   
begin   
 insert @retTable (ErrorMsg)   
 select ''Box bar code is blank for '' + convert ( varchar(10) , count(*))    + '' rows.''  from tbl_BoxInfo     
 where [BOX_BARCODE] is null     
end   


insert @retTable (ErrorMsg)   
Select ''Box bar code is duplicate for '' + Rtrim(ltrim([BOX_BARCODE]))     
From tbl_BoxInfo      
Group by  [BOX_BARCODE]  having COUNT( Rtrim(ltrim([BOX_BARCODE]))) > 1

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


if exists (Select TB.BOX_BARCODE from tbl_FileInfo TB left join tbl_BoxDetails  TBD on TB.BOX_BARCODE = TBD.s_BoxBarCode where TBD.s_BoxBarCode is null  )
begin  
insert @retTable (ErrorMsg)  
	Select ''Box ''  + TB.BOX_BARCODE  + '' does not exist in the system.'' 
	from tbl_FileInfo TB left join tbl_BoxDetails  TBD on TB.BOX_BARCODE = TBD.s_BoxBarCode where TBD.s_BoxBarCode is null
end 

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
 END
    

 
' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_xlImp_ValidateTempData]    Script Date: 10/27/2015 18:44:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_xlImp_ValidateTempData]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'      
--[usp_xlImp_ValidateTempData] 2015000987    
-- =============================================        
-- Author:  <Author,,Name>        
-- Create date: <Create Date,,>        
-- Description: <Description,,>        
-- =============================================        
CREATE  pROCEDURE [dbo].[usp_xlImp_ValidateTempData]        
(@n_WorkOrderNo int)      
AS        
BEGIN         
 SET NOCOUNT ON;        
       
 declare @retTable Table (ErrorMsg varchar(250))      
     
 if ((select COUNT(*) from TempData)=0)     
Begin    
  insert @retTable(ErrorMsg)    
  select ''There are no rows in excel sheet''    
End     
      
   if ((Select count(distinct CLIENTNAME) from tempdata)>1)     
Begin    
  insert @retTable(ErrorMsg)    
  select ''Excel sheet contains data for more than one client''    
End     
    
if exists(      
select distinct td.CLIENTNAME from tempdata td      
left join       
(      
Select distinct tcw.s_CustomerName       
From tbl_WorkOrder two       
 join tbl_Customer tcw on tcw.n_CustomerId = two.n_CustomerId       
Where  two.n_WorkorderNo = @n_WorkOrderNo) A       
on td.CLIENTNAME = A.s_CustomerName       
where A.s_CustomerName is null       
 --select distinct td.CLIENTNAME, cust.s_CustomerName--, wo.n_WorkorderNo      
 --from tempdata td       
 --Left join tbl_Customer cust on ltrim(rtrim(td.CLIENTNAME)) = ltrim(rtrim(cust.s_CustomerName))      
 --Left join tbl_WorkOrder wo on cust.n_CustomerId = wo.n_CustomerId and  wo.n_WorkorderNo = @n_WorkOrderNo      
 )      
 Begin      
 insert @retTable (ErrorMsg)       
select distinct ''Customer Name '' + td.CLIENTNAME+ '' in Excel file does not match with customer selected in dropdown''        
 from tempdata td      
left join       
(      
Select distinct tcw.s_CustomerName       
From tbl_WorkOrder two       
 join tbl_Customer tcw on tcw.n_CustomerId = two.n_CustomerId       
Where  two.n_WorkorderNo = @n_WorkOrderNo) A       
on td.CLIENTNAME = A.s_CustomerName       
where A.s_CustomerName is null       
 --select distinct ''Customer Name '' + td.CLIENTNAME + '' in Excel file does not match with customer selected in dropdown''      
 --from tempdata td       
 --Left join tbl_Customer cust on ltrim(rtrim(td.CLIENTNAME)) = ltrim(rtrim(cust.s_CustomerName))      
 --Left join tbl_WorkOrder wo on cust.n_CustomerId = wo.n_CustomerId and  wo.n_WorkorderNo = @n_WorkOrderNo      
 End       
        
if exists ( select * from TempData where CLIENTNAME is null )       
begin       
 insert @retTable (ErrorMsg)       
 select ''Customer name blank for '' + convert( varchar(50) ,COUNT(*)) + '' rows'' from TempData       
 where CLIENTNAME is null       
end      
      
insert @retTable (ErrorMsg)       
select distinct ''Customer '' + td.CLIENTNAME + '' does not exist.''      
from TempData td       
left join tbl_Customer cust on td.CLIENTNAME = cust.s_CustomerName       
where cust.s_CustomerName is null and td.CLIENTNAME is not null      
       
if exists ( select * from TempData where [BOX BARCODE] is null )       
begin       
 insert @retTable (ErrorMsg)       
 select ''Box bar code is blank for '' + convert ( varchar(10) , count(*))    + '' rows.''  from TempData         
 where [BOX BARCODE] is null         
end       
        
if exists ( select * from TempData where [FILE BARCODE] is null )       
begin      
 insert @retTable (ErrorMsg)       
 select       
 (select ''File bar code is blank for '' + convert(varchar(10) , count(*)) + '' rows.'' from TempData         
 where [FILE BARCODE]  is null )         
end       
      
insert @retTable (ErrorMsg)       
Select ''File bar code is duplicate for '' +  Rtrim(ltrim([FILE BARCODE]))         
From TempData          
Group by  [FILE BARCODE]  having COUNT( Rtrim(ltrim([FILE BARCODE]))) > 1      
        
        
insert @retTable (ErrorMsg)       
Select ''Invalid File bar code '' +  [FILE BARCODE]         
From TempData          
Where ([FILE BARCODE] like ''%-%'' OR [FILE BARCODE] like ''%`%'' OR [FILE BARCODE] like ''%!%''      
 OR [FILE BARCODE] like ''%@%'' OR [FILE BARCODE] like ''%#%'' OR [FILE BARCODE] like ''%$%''      
 OR ([FILE BARCODE] like ''%\%%'' ESCAPE ''\'') OR [FILE BARCODE] like ''%^%'' OR [FILE BARCODE] like ''%&%''      
 OR [FILE BARCODE] like ''%*%'' OR [FILE BARCODE] like ''%(%'' OR [FILE BARCODE] like ''%)%''      
 OR ([FILE BARCODE] like ''%\_%'' ESCAPE ''\'') OR [FILE BARCODE] like ''%+%'' OR [FILE BARCODE] like ''%=%''      
 OR [FILE BARCODE] like ''%|%'' OR [FILE BARCODE] like ''%\%'' OR [FILE BARCODE] like ''%?%''      
 OR [FILE BARCODE] like ''%:%'' OR [FILE BARCODE] like ''%;%'' OR [FILE BARCODE] like ''%''''%''      
 OR [FILE BARCODE] like ''%"%'' OR [FILE BARCODE] like ''%<%'' OR [FILE BARCODE] like ''%>%''      
 OR [FILE BARCODE] like ''%,%'' OR [FILE BARCODE] like ''%.%'' OR [FILE BARCODE] like ''%/%''         
 OR [FILE BARCODE] like ''%~%''          
 )   
               
insert @retTable (ErrorMsg)       
Select ''Invalid Box bar code '' +  [BOX BARCODE]         
From TempData          
Where ([BOX BARCODE] like ''%-%'' OR [BOX BARCODE] like ''%`%'' OR [BOX BARCODE] like ''%!%''      
 OR [BOX BARCODE] like ''%@%'' OR [BOX BARCODE] like ''%#%'' OR [BOX BARCODE] like ''%$%''      
 OR ([BOX BARCODE] like ''%\%%'' ESCAPE ''\'')  OR [BOX BARCODE] like ''%^%'' OR [BOX BARCODE] like ''%&%''      
 OR [BOX BARCODE] like ''%*%'' OR [BOX BARCODE] like ''%(%'' OR [BOX BARCODE] like ''%)%''      
 OR ([BOX BARCODE] like ''%\_%'' ESCAPE ''\'') OR [BOX BARCODE] like ''%+%'' OR [BOX BARCODE] like ''%=%''      
 OR [BOX BARCODE] like ''%|%'' OR [BOX BARCODE] like ''%\%'' OR [BOX BARCODE] like ''%?%''      
 OR [BOX BARCODE] like ''%:%'' OR [BOX BARCODE] like ''%;%'' OR [BOX BARCODE] like ''%''''%''      
 OR [BOX BARCODE] like ''%"%'' OR [BOX BARCODE] like ''%<%'' OR [BOX BARCODE] like ''%>%''      
 OR [BOX BARCODE] like ''%,%'' OR [BOX BARCODE] like ''%.%'' OR [BOX BARCODE] like ''%/%''         
 OR [BOX BARCODE] like ''%~%''          
 )        
       
  insert @retTable (ErrorMsg)       
Select ''Invalid Department Name '' +  [dept]         
From TempData          
Where ([dept] like ''%`%'' OR [dept] like ''%!%''      
 OR [dept] like ''%@%'' OR [dept] like ''%#%'' OR [dept] like ''%$%''      
 OR ([dept] like ''%\%%'' ESCAPE ''\'') OR [dept] like ''%^%'' 
 OR [dept] like ''%*%'' OR [dept] like ''%(%'' OR [dept] like ''%)%''      
 OR ([dept] like ''%\_%'' ESCAPE ''\'') OR [dept] like ''%+%'' OR [dept] like ''%=%''      
 OR [dept] like ''%|%'' OR [dept] like ''%\%'' OR [dept] like ''%?%''      
 OR [dept] like ''%:%'' OR [dept] like ''%;%'' OR [dept] like ''%''''%''      
 OR [dept] like ''%"%'' OR [dept] like ''%<%'' OR [dept] like ''%>%''      
 OR [dept] like ''%,%'' OR [dept] like ''%.%'' OR [dept] like ''%~%''          
 )   
 --[dept] like ''%-%'' OR
 --OR [dept] like ''%/%'' 
 --OR [dept] like ''%&%''        
    
 insert @retTable (ErrorMsg)       
 select ''File bar code already exists in the system '' +  td.[FILE BARCODE]      
  from TempData td       
  inner join tbl_FileDetails tfd on td.[FILE BARCODE] = tfd.s_FileBarCode       
       
       
   declare @customerid int = (select n_CustomerId from tbl_WorkOrder where n_WorkorderNo = @n_WorkOrderNo )     
   insert @rettable(Errormsg)     
 select     
  ''Box Barcode ''  + convert(varchar(50) , TD.[BOX BARCODE])  + '' is already used for customer '' + TC.s_CustomerName     
 from     
  TempData TD     
  join tbl_BoxDetails TBD on ltrim(rtrim(TBD.s_BoxBarCode)) = ltrim(rtrim(TD.[BOX BARCODE]))    
  join tbl_Customer TC on TBD.n_CustomerId = TC.n_CustomerId     
 Where     
  TBD.n_CustomerId <> @customerid     
--   if Exists (     
-- Select     
--  TD.[FILE BARCODE]     
-- From     
--  tbl_WoActivities TWA     
--  join tbl_FileTransactions TFT on TFT.n_WoActivityId = TWA.n_WoActivityId     
--  join tbl_FileDetails TFD on TFT.n_FileId = TFD.n_FileId     
--  join TempData TD on rtrim(ltrim(TD.[FILE BARCODE])) = rtrim(ltrim(TFD.s_FileBarCode))     
-- Where     
--  TWA.n_WorkOrderNo = @n_WorkOrderNo    
--)     
--Begin     
--    insert @retTable (ErrorMsg)       
-- Select     
--  ''File Bar Code '' + TD.[FILE BARCODE] + '' is already uploaded for Work Order '' + convert(varchar(15), @n_WorkOrderNo)    
-- From     
--  tbl_WoActivities TWA     
--  join tbl_FileTransactions TFT on TFT.n_WoActivityId = TWA.n_WoActivityId     
--  join tbl_FileDetails TFD on TFT.n_FileId = TFD.n_FileId     
--  join TempData TD on rtrim(ltrim(TD.[FILE BARCODE])) = rtrim(ltrim(TFD.s_FileBarCode))     
-- Where     
--  TWA.n_WorkOrderNo = @n_WorkOrderNo    
--End     
   insert @rettable(Errormsg)     
   select ''Length of File Bar Code Field of '' + [FILE BARCODE] + '' is '' + convert(varchar(10) , LEN([FILE BARCODE]))  + '', should be maximum 16''    
   from TempData where LEN([FILE BARCODE] ) > 16  
  
   insert @rettable(Errormsg)     
   select ''Length of Box Bar Code Field of '' + [Box BARCODE] + '' is '' + convert(varchar(10) , LEN([BOX BARCODE]))  + '', should be maximum 16''    
   from TempData where LEN([BOX BARCODE]) > 16  
     
   insert @rettable(Errormsg)     
   select ''Length of Location Field of '' + [LOCATION]  + '' is '' + convert(varchar(10) , LEN([LOCATION]))  + '', should be maximum 15''    
   from TempData where LEN([LOCATION]) > 15  
     
   insert @rettable(Errormsg)     
   select ''Length of FILE NAME 1 Field of '' + [FILE NAME 1]  + '' is '' + convert(varchar(10) , LEN([FILE NAME 1]))  + '', should be maximum 255''    
   from TempData where LEN([FILE NAME 1]) > 255  
     
   insert @rettable(Errormsg)     
   select ''Length of FILE NAME 1 Field of '' + [FILE NAME 2]  + '' is '' + convert(varchar(10) , LEN([FILE NAME 2]))  + '', should be maximum 255''    
   from TempData where LEN([FILE NAME 2]) > 255  
     
   insert @rettable(Errormsg)     
   select ''Length of Dept Field of '' + DEPT  + '' is '' + convert(varchar(10) , LEN(DEPT))  + '', should be maximum 50''    
   from TempData where LEN(DEPT) > 50  
     
   insert @rettable(Errormsg)     
   select ''Length of LABLE 1 ( FILE TYPE ) Field of '' + [LABLE 1 ( FILE TYPE )] + '' is '' + convert(varchar(10) , LEN([LABLE 1 ( FILE TYPE )]))  + '', should be maximum 100''    
   from TempData where LEN([LABLE 1 ( FILE TYPE )] ) > 100  
     
   insert @rettable(Errormsg)     
   select ''Length of LABLE 2 ( BRANCH NAME ) Field of '' + [LABLE 2 ( BRANCH NAME )] + '' is '' + convert(varchar(10) , LEN([LABLE 2 ( BRANCH NAME )]))  + '', should be maximum 100''    
   from TempData where LEN([LABLE 2 ( BRANCH NAME )] ) > 100  
     
   insert @rettable(Errormsg)     
   select ''Length of LABLE 3 ( FILLING SR NO ) Field of '' + [LABLE 3 ( FILLING SR NO )] + '' is '' + convert(varchar(10) , LEN([LABLE 3 ( FILLING SR NO )]))  + '', should be maximum 100''    
   from TempData where LEN([LABLE 3 ( FILLING SR NO )] ) > 100  
     
   insert @rettable(Errormsg)     
   select ''Length of LABLE 4 Field of '' + [LABLE 4] + '' is '' + convert(varchar(10) , LEN([LABLE 4]))  + '', should be maximum 100''    
   from TempData where LEN([LABLE 4] ) > 100  
  
 Select ErrorMsg as [Error Message] from @retTable        
       
END ' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetCustomerWiseData_App]    Script Date: 10/27/2015 18:44:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_GetCustomerWiseData_App]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'    
CREATE Procedure [dbo].[usp_GetCustomerWiseData_App]      
as      
begin      
  select  n_CustomerId,n_Status,n_WorkorderNo INTO #OpenWOCustomer From tbl_WorkOrder WO JOIN              
 tbl_ApplicationCodeMaster ACM ON WO.n_Status = ACM.n_AppCodeId  AND ACM.s_AppCode=''WORKORDER_STATUS''                
 where ACM.s_AppCodeName =''Open''      
  and WO.d_WoDate>=''15-Sep-2015 00:00:00''          
               
 select n_WorkorderNo From #OpenWOCustomer order by    n_WorkorderNo desc          
--Company Group              
 select distinct CG.s_CGName, CG.n_CompanyGroupId from tbl_CompanyGroup CG JOIN                 
 tbl_Customer C ON CG.n_CompanyGroupId=C.n_CompanyGroupId JOIN                
 #OpenWOCustomer TEMP ON C.n_CustomerId =TEMP.n_CustomerId              
 --Customer              
 select distinct C.s_CustomerName,C.n_CustomerId FROM tbl_Customer C JOIN                
 #OpenWOCustomer TEMP ON C.n_CustomerId =TEMP.n_CustomerId              
 order by C.n_CustomerId asc                
 select distinct  DEPT.s_AppCodeName from tbl_WoActivities ACT JOIN              
 #OpenWOCustomer TT ON ACT.n_WorkOrderNo =TT.n_WorkorderNo JOIN              
 tbl_ApplicationCodeMaster DEPT ON ACT.n_DepartmentId =DEPT.n_AppCodeId AND DEPT.s_AppCode=''DEPARTMENT''                
               
select n_WareHouseId,s_WarehouseName from tbl_WareHouseMaster            
 drop table #OpenWOCustomer           
end ' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_LoginDetails]    Script Date: 10/27/2015 18:44:06 ******/
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
                       
 select distinct  top 2            
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
/****** Object:  UserDefinedFunction [dbo].[fn_GetWOBoxFileCount]    Script Date: 10/27/2015 18:44:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_GetWOBoxFileCount]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'/*
select dbo.fn_GetWOBoxFileCount (2015000917 , ''File'','''' ) 
select dbo.fn_GetWOBoxFileCount (2015000917 , ''File'',''Approved'' ) 
select dbo.fn_GetWOBoxFileCount (2015000917 , ''File'',''Pending'' ) 
select dbo.fn_GetWOBoxFileCount ( 2015000917 , ''Box'' , '''' ) 
*/
CREATE Function [dbo].[fn_GetWOBoxFileCount] 
(
@pn_WorkOrderNo int , 
@ps_BoxFile varchar(10) , 
@ps_ApprovalStatus varchar(20) = null 
) 
Returns int
As 
Begin -- Begin Func
Declare @Activity_NewBoxCost int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''New Standard Box Cost (1.50 Cubic Ft.)'')       
Declare @Activity_BarcodingDataEntry int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''Bar-coding & Data Entry (File & Box)'')       
Declare @Activity_StandardBoxTransportation int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''Standard Box Transportation'')  
declare @n_ReturnCount int = -1 

	If ( @ps_BoxFile = ''File'') 
		Begin 
			Select
				@n_ReturnCount = count(TFT.n_FileId) 
			From 
				tbl_WOActivities TWA
				join tbl_FileTransactions TFT on TFT.n_WoActivityId = TWA.n_WoActivityId 
				join tbl_FileDetails TFD on TFT.n_fileId = TFD.n_FileId
				join tbl_ApplicationCodeMaster TACM on TACM.n_AppCodeId  = TFD.n_ApproveStatus
			Where 
				TWA.n_WorkOrderNo = @pn_WorkOrderNo 
				And TWA.n_ActivityId in ( @Activity_NewBoxCost,@Activity_BarcodingDataEntry,@Activity_StandardBoxTransportation) 		
				And (@ps_ApprovalStatus is null or @ps_ApprovalStatus = '''' or @ps_ApprovalStatus = TACM.s_AppCodeName)
		End 
	Else
		Begin
			Select
				@n_ReturnCount = count(TBT.n_BoxId) 
			From 
				tbl_WOActivities TWA
				join tbl_BoxTransactions TBT on TBT.n_WoActivityId = TWA.n_WoActivityId 
				
			Where 
				TWA.n_WorkOrderNo = @pn_WorkOrderNo 
				And TWA.n_ActivityId in ( @Activity_NewBoxCost,@Activity_BarcodingDataEntry,@Activity_StandardBoxTransportation) 		
		End 
return @n_ReturnCount		
	
End  --End Func' 
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_InsertUpdateBoxDetails_2]    Script Date: 10/27/2015 18:44:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Usp_InsertUpdateBoxDetails_2]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'    
        
 -- exec [Usp_InsertUpdateBoxDetails_2] 180, 1, 3373, 1, ''SSBox7'', ''SSBoxLoc'', '''', '''', 0
        
CREATE procedure [dbo].[Usp_InsertUpdateBoxDetails_2]
  @pn_CustomerId		Int				 ,           
  @pn_WareHouseId		TinyInt			 , 
  @pn_WoActivityId		Int				 ,		       
  @pn_ModifiedBy		SmallInt		 ,
  @ps_BoxBarcode		nvarchar(250)	 ,  
  @ps_BoxLocationCode	nvarchar(250)	 ,
  --@pn_BoxStatus			int				 , 
  @ps_ImageDrive		varchar(10)=''''	 ,
  @ps_ImageFolder		varchar(100)=''''	 ,
  @isExist				int out   
        
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
         
 begin try        
 
   declare @BoxId int 
   if not exists(select n_BoxId from tbl_BoxDetails where s_BoxBarCode = @ps_BoxBarcode )       
 begin    
 SET NOCOUNT ON       
 select @BoxId = n_BoxId from tbl_BoxDetails where s_BoxBarCode = @ps_BoxBarcode                            
 Insert Into tbl_BoxDetails      
     (
      s_BoxBarCode        ,  s_LocationCode    ,        
      n_CustomerId        ,  n_WareHouseId     ,      
      n_Status            ,  d_ModifiedDate    ,      
      n_ModifiedBy		  ,	 s_Drive		   ,	s_Folder
      )       
     VALUES (                                                                                                                      
		@ps_BoxBarcode, @ps_BoxLocationCode, @pn_CustomerId, @pn_WareHouseId, @Status_in,  
		GETDATE(), 1, @ps_ImageDrive, @ps_ImageFolder       
			)   
			set @BoxId =  SCOPE_IDENTITY()
    --print @BoxId 
     
    SET NOCOUNT OFF 
    
    Insert Into tbl_MapBoxLocation(n_BoxId, s_BoxLocationCode) Select n_BoxId, s_LocationCode from tbl_BoxDetails where n_BoxId = SCOPE_IDENTITY()  
    --set @BoxId =  SCOPE_IDENTITY()
    --print @BoxId
     Insert Into tbl_BoxTransactions ( n_BoxId, n_WoActivityId, d_ModifiedDate, n_ModifiedBy )      
						 Select	n_BoxId, @pn_WoActivityId, GETDATE(), @pn_ModifiedBy from tbl_BoxDetails		
						where n_BoxId= @BoxId
    set @isExist = 0   
       --print @BoxId 
       --print @isExist   
 end    
 end try                   
 begin catch                            
 end catch                          
END ' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_getMakerSearchData]    Script Date: 10/27/2015 18:44:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_getMakerSearchData]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
  
    
      
          
            
/*************************************************************************************************/              
  -- usp_getMakerSearchData 1,2015000975,0,'''','''',0,'''','''','''','''','''','''','''','''','''',123           
/*************************************************************************************************/              
CREATE PROCEDURE [dbo].[usp_getMakerSearchData] -- usp_getMakerSearchData 1,2015000926,0,'''','''',0,'''','''','''','''',null,null,'''','''','''',123                            
(                            
@WareHouseId int,                            
@WorkOrderNo int,                            
@PickupAddressId int,               
@BoxBarcode nvarchar(250),                          
@FileBarcode nvarchar(250),                                            
@Department int,             
@FileDesc1 nvarchar(250),                            
@FileDesc2 nvarchar(250),            
@FileType varchar(15),              
@Year varchar(15) ,            
@FromDate varchar(15) ='''',                         
@ToDate varchar(15) ='''',                      
@FromNum varchar(15),                         
@ToNum varchar(15),            
@DestructionDueDate varchar(15) = '''',     
@Fstatus int                     
)                            
AS                          
BEGIN          
print @FromDate          
if @FromDate=null          
set @FromDate=''''          
print @FromDate          
if @ToDate=null          
set @ToDate =''''          
if @DestructionDueDate= null          
set @DestructionDueDate=''''     
    
    
          
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
Declare @Status_in int = (Select n_AppCodeId From tbl_applicationcodemaster Where s_AppCode = ''BOXFILE_STATUS'' And s_AppCodeName = ''In'')          
Declare @Status_Out int = (Select n_AppCodeId From tbl_applicationcodemaster Where s_AppCode = ''BOXFILE_STATUS'' And s_AppCodeName = ''Out'')          
Declare @ApproveStatus_Approved int = (Select n_AppCodeId From tbl_applicationcodemaster Where s_AppCode = ''BOXFILE_STATUS'' And s_AppCodeName = ''Approved'')          
Declare @ApproveStatus_Reject int = (Select n_AppCodeId From tbl_applicationcodemaster Where s_AppCode = ''BOXFILE_STATUS'' And s_AppCodeName = ''Reject'')            
Declare @ApproveStatus_Pending int = (Select n_AppCodeId From tbl_applicationcodemaster Where s_AppCode = ''BOXFILE_STATUS'' And s_AppCodeName = ''Pending'')                  
/* PROCEDURE CONSTANTS */      
                
 begin try                            
   select distinct fd.n_FileId ''FileId'',       
   WM.s_WarehouseName as ''WareHouse'',                          
    CG.s_CGName as ''Company Group'',                          
    C.s_CustomerName ''Customer'',             
    WO.n_WorkorderNo ''WorkorderNo'',                      
    ACMD.s_AppCodeName ''Department'',         
    acm3.s_AppCodeName ''WO Status'',                     
    ACM.s_AppCodeName  ''Status'',     
    acm2.s_AppCodeName  ''FileStatus'' ,                        
    BD.s_BoxBarCode ''Box Barcode'',                          
    BD.s_LocationCode  ''Box Location'',                          
    --LM.s_LocationCode ''Location'',          
    --fd.n_FileId ''FileId'',           
    FD.s_FileBarCode ''File BarCode'',                        
    FD.s_FileName ''sFileName'',                          
    FD.s_FileDescription1 ''FileDescription1'',            
    FD.s_Label1 ''File Type'',FD.s_Label2 ''From No'',FD.s_Label3 ''To No''                          
    ,CONVERT(Varchar(10), Convert(Date,d_DestructionDueDate,103),103) ''Destruction Due Date''  ,                      
    FD.s_Year ''Year'' ,CONVERT(Varchar(10), Convert(Date,d_FromDate,103),103) ''FromDate''   ,                      
    CONVERT(Varchar(10), Convert(Date,d_EndDate ,103),103) ''ToDate'', fd.s_FileRemarks ''FileRemarks'' , ACMD.n_AppCodeId ''DepartmentId'' ,
    C.n_CustomerId   ''CustomerId''          
    from             
    tbl_WorkOrder WO            
                        
    Inner Join tbl_WoActivities WOA On WOA.n_WorkOrderNo =  WO.n_WorkorderNo           
    inner join tbl_FileTransactions ft on ft.n_WoActivityId=WOA.n_WoActivityId          
    inner join tbl_FileDetails fd on fd.n_FileId=ft.n_FileId          
    inner join tbl_BoxDetails bd on bd.n_BoxId=fd.n_BoxId                    
    inner Join tbl_PickupAddress PA On  WOA.n_PickupAddressId = PA.n_PickupAddressId           
    inner join tbl_WareHouseMaster WM on WM.n_WareHouseId=BD.n_WareHouseId                            
    inner join tbl_Customer C on C.n_CustomerId=BD.n_CustomerId                            
    inner join tbl_CompanyGroup CG on CG.n_CompanyGroupId=C.n_CompanyGroupId                            
    inner join tbl_ApplicationCodeMaster ACM on ACM.n_AppCodeId=FD.n_Status                          
    inner join tbl_ApplicationCodeMaster ACMD on ACMD.n_AppCodeId=FD.n_DepartmentId    
    inner join tbl_ApplicationCodeMaster ACM2 on ACM2.n_AppCodeId=FD.n_ApproveStatus    
    inner join tbl_ApplicationCodeMaster ACM3 on ACM3.n_AppCodeId=WO.n_Status    
              
    where           
     WOA.n_ActivityId in (@Activity_NewBoxCost, @Activity_BarcodingDataEntry, @Activity_StandardBoxTransportation)          
     and wo.n_Status = @Status_WorkOrder_Open and  n_ApproveStatus =  @Fstatus      
      --and  (n_ApproveStatus =  Case     @Fstatus         
      --    When  0 Then @ApproveStatus_Approved  else    @Fstatus end )      
    and (WM.n_WareHouseId=@WareHouseId) and (WO.n_WorkorderNo=@WorkOrderNo)            
    and (PA.n_PickupAddressId = @PickupAddressId or @PickupAddressId=0)            
    and (BD.s_BoxBarCode like ''%''+@BoxBarcode+''%'' or @BoxBarcode='''')              
    and (FD.s_FileBarCode like ''%''+@FileBarCode+''%'' or @FileBarCode='''')            
    and (FD.n_DepartmentId=@Department or @Department=0)                 
    and (FD.s_FileName like ''%''+@FileDesc1+''%'' or @FileBarCode is null OR @FileDesc1 ='''')            
    and (FD.s_FileDescription1 like ''%''+@FileDesc2+''%'' or @FileBarCode is null OR @FileDesc2 ='''')            
    and (FD.s_Label1 like ''%''+@FileType+''%'' or @FileType='''')             
    and (FD.s_Year = @Year OR @Year ='''')            
    --and (FD.d_FromDate = @FromDate  OR @FromDate = '''' OR @FromDate =null)                       
    --and (FD.d_EndDate = @ToDate OR @ToDate = '''' OR @ToDate =null)           
               
    and (           
    (FD.d_FromDate >= @FromDate and FD.d_EndDate <= @FromDate) or (@FromDate = null OR @ToDate = '''')           
    and          
    (FD.d_FromDate >= @ToDate and FD.d_EndDate <= @ToDate) or (@ToDate = null OR @ToDate = '''')          
   )          
    and (FD.s_Label2=@FromNum or @FromNum='''')                            
    and (FD.s_Label3=@ToNum or @ToNum='''')                       
    and (FD.d_DestructionDueDate = @DestructionDueDate OR @DestructionDueDate = '''' OR @DestructionDueDate =null)             
                          
 end try                  
 begin catch                            
 end catch                          
END          
/*************************************************************************************************/ ' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_ApproveFileDetails]    Script Date: 10/27/2015 18:44:06 ******/
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
   declare @filecount int
   declare @boxcount int
   select @filecount = dbo.fn_GetWOBoxFileCount (@pn_WoNo , ''File'',''Approved'' )    
   select @boxcount = dbo.fn_GetWOBoxFileCount ( @pn_WoNo , ''Box'' , '''' )      
   
   Declare @Activity_NewBoxCost int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''New Standard Box Cost (1.50 Cubic Ft.)'')         
   Declare @Activity_BarcodingDataEntry int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''Bar-coding & Data Entry (File & Box)'')         
   Declare @Activity_StandardBoxTransportation int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''Standard Box Transportation'')    
   
   update tbl_WoActivities 
   set n_FileCount=@filecount
   where n_WorkOrderNo= @pn_WoNo  And n_ActivityId in (@Activity_BarcodingDataEntry) 
   
   update tbl_WoActivities 
   set n_BoxCount=@boxcount
   where n_WorkOrderNo= @pn_WoNo  And n_ActivityId in (@Activity_NewBoxCost,@Activity_StandardBoxTransportation)
       
  END             
   commit Tran            
                
 End Try              
 Begin Catch              
 Rollback Tran            
 Exec usp_GetErrorInfo              
 End Catch   
End--End Proc [usp_ApproveFileDetails]  
/*************************************************************************************************/  ' 
END
GO
