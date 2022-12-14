
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertUpdateFileDetails]    Script Date: 11/05/2015 18:01:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_InsertUpdateFileDetails]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_InsertUpdateFileDetails]
GO
/****** Object:  StoredProcedure [dbo].[Usp_InsertUpdateFileDetails_2]    Script Date: 11/05/2015 18:01:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Usp_InsertUpdateFileDetails_2]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Usp_InsertUpdateFileDetails_2]
GO
/****** Object:  StoredProcedure [dbo].[usp_EditMakerSearchData]    Script Date: 11/05/2015 18:01:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_EditMakerSearchData]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_EditMakerSearchData]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetPickupAddressOnWO]    Script Date: 11/05/2015 18:01:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_GetPickupAddressOnWO]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_GetPickupAddressOnWO]
GO
/****** Object:  StoredProcedure [dbo].[usp_xlImp_ValidateTempData]    Script Date: 11/05/2015 18:01:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_xlImp_ValidateTempData]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_xlImp_ValidateTempData]
GO
/****** Object:  StoredProcedure [dbo].[usp_xlRetr_ValidateBox]    Script Date: 11/05/2015 18:01:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_xlRetr_ValidateBox]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_xlRetr_ValidateBox]
GO
/****** Object:  StoredProcedure [dbo].[usp_xlRetr_ValidateFile]    Script Date: 11/05/2015 18:01:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_xlRetr_ValidateFile]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_xlRetr_ValidateFile]
GO
/****** Object:  StoredProcedure [dbo].[usp_xlRetr_ValidateFile]    Script Date: 11/05/2015 18:01:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_xlRetr_ValidateFile]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'    
/*    
select * from tbl_customer order by s_customername    
select * from tbl_fileinfo     
[usp_xlRetr_ValidateFile] 192    
    
select * from tbl_filedetails TFD      
join tbl_boxdetails TBD on TFD.n_boxid = TBD.n_boxid    
where s_filebarcode in (''a12'')    
*/    
CREATE PROCEDURE [dbo].[usp_xlRetr_ValidateFile]    
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
/****** Object:  StoredProcedure [dbo].[usp_xlRetr_ValidateBox]    Script Date: 11/05/2015 18:01:09 ******/
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
(
@custid int
)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @retTable Table (ErrorMsg varchar(250))  
	declare @Status_Box_Out int = (Select n_AppCodeId From tbl_applicationcodemaster Where s_AppCode = ''BOXFILE_STATUS'' And s_AppCodeName = ''Out'' )
    Declare @Status int = (Select n_AppCodeId From tbl_ApplicationCodeMaster Where s_AppCode=''WORKORDER_STATUS'' and  s_AppCodeName =''Open'') 
	Declare @Activity_BoxRetrievalRegular int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''Box Retrievals   Regular (Within 24 hours)'')             
	Declare @Activity_BoxRetrievalExpress int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''Box Retrievals   Express (Within 12 hours)'') 
	 
	if ((select COUNT(*) from tbl_BoxInfo)=0)         
	 Begin        
	  insert @retTable(ErrorMsg)        
	  select ''There are no rows in excel sheet''        
	 End  

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
 

insert @retTable (ErrorMsg)  
select ''BOX Barcode  '' + BI.BOX_BARCODE  + '' already exist for Customer '' + TC.s_CustomerName  from tbl_BoxInfo BI
Join
tbl_BoxDetails TBD
ON TBD.s_BoxBarCode=BI.BOX_BARCODE
Join
tbl_Customer TC
on TC.n_CustomerId=TBD.n_CustomerId
where TC.n_CustomerId <> @custid

insert @retTable (ErrorMsg) 
	select ''Box '' + TBI.BOX_BARCODE + '' is alreay included for retrieval in work order no. '' + CONVERT(varchar(20) , TWO.n_WorkOrderNo ) from 
	tbl_WorkOrder TWO 
	join tbl_WoActivities TWA on TWA.n_WorkOrderNo = TWO.n_WorkorderNo 
	join tbl_BoxFileRetrivaldetails TBR  on TBR.n_workOrderActivity = TWA.n_WoActivityId 
	join tbl_BoxInfo TBI on TBI.BOX_BARCODE = TBR.s_BoxBarCode 
where 
	TWO.n_CustomerId = @custid 
	and TWO.n_Status = @Status 
	and TWA.n_ActivityId in(@Activity_BoxRetrievalRegular,@Activity_BoxRetrievalExpress)


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
/****** Object:  StoredProcedure [dbo].[usp_xlImp_ValidateTempData]    Script Date: 11/05/2015 18:01:09 ******/
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
CREATE PROCEDURE [dbo].[usp_xlImp_ValidateTempData]            
(@n_WorkOrderNo int)          
AS            
BEGIN             
 SET NOCOUNT ON;            
           
 Declare @retTable Table (ErrorMsg varchar(250))          
         
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
        
update tempdata set CLIENTNAME = RTRIM(LTRIM(CLIENTNAME))        
        
 if exists ( select * from TempData where CLIENTNAME is null )           
 begin           
  insert @retTable (ErrorMsg)           
  select ''Customer name blank for '' + convert( varchar(50) ,COUNT(*)) + '' rows'' from TempData           
  where CLIENTNAME is null           
 end          
        
        
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
            
  
          
 Insert @retTable (ErrorMsg)           
 Select     
  distinct ''Customer '' + td.CLIENTNAME + '' does not exist.''          
 From     
  TempData td           
  left join tbl_Customer cust on td.CLIENTNAME = cust.s_CustomerName           
 Where     
  cust.s_CustomerName is null and td.CLIENTNAME is not null          
       
 If exists ( select * from TempData where [BOX BARCODE] is null )           
 Begin           
 Insert @retTable (ErrorMsg)           
 Select     
  ''Box bar code is blank for '' + convert ( varchar(10) , count(*))    + '' rows.''  from TempData             
 Where     
  [BOX BARCODE] is null             
 End           
        
if exists ( select * from TempData where [FILE BARCODE] is null )           
Begin          
Insert @retTable (ErrorMsg)           
Select           
(Select ''File bar code is blank for '' + convert(varchar(10) , count(*)) + '' rows.'' from TempData             
Where [FILE BARCODE]  is null )             
End           
      
insert @retTable (ErrorMsg)           
Select ''File bar code is duplicate for '' +  Rtrim(ltrim([FILE BARCODE]))             
From TempData              
Group by  [FILE BARCODE]  having COUNT( Rtrim(ltrim([FILE BARCODE]))) > 1          
            
            
 insert @retTable (ErrorMsg)           
 Select     
  ''Invalid File bar code '' +  [FILE BARCODE]             
 From     
  TempData              
 Where     
  ([FILE BARCODE] like ''%-%'' OR [FILE BARCODE] like ''%`%'' OR [FILE BARCODE] like ''%!%''          
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
                   
 Insert @retTable (ErrorMsg)           
 Select     
  ''Invalid Box bar code '' +  [BOX BARCODE]             
 From     
  TempData              
 Where     
  ([BOX BARCODE] like ''%-%'' OR [BOX BARCODE] like ''%`%'' OR [BOX BARCODE] like ''%!%''          
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
           
 Insert @retTable (ErrorMsg)           
 Select ''Invalid Department Name '' +  [dept]             
 From     
  TempData              
 Where     
  ([dept] like ''%`%'' OR [dept] like ''%!%''          
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
 Select     
  ''File bar code already exists in the system '' +  td.[FILE BARCODE]          
 From     
  TempData td           
  inner join tbl_FileDetails tfd on td.[FILE BARCODE] = tfd.s_FileBarCode           
        
        
 Declare @customerid int = (select n_CustomerId from tbl_WorkOrder where n_WorkorderNo = @n_WorkOrderNo )         
 Insert @rettable(Errormsg)         
 Select         
  ''Box Barcode ''  + convert(varchar(50) , TD.[BOX BARCODE])  + '' is already used for customer '' + TC.s_CustomerName         
 From         
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
/****** Object:  StoredProcedure [dbo].[usp_GetPickupAddressOnWO]    Script Date: 11/05/2015 18:01:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_GetPickupAddressOnWO]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
  
    
-- [usp_GetPickupAddressOnWO]  2015000975     
 -- [usp_GetPickupAddressOnWO] 2015000817    
CREATE Procedure [dbo].[usp_GetPickupAddressOnWO]                 
@WorkOrderNo Int      
As            
Begin    
 SET NOCOUNT ON            
 Begin Try     
 Select distinct PA.n_PickupAddressId as ''PickupAddressId'', Isnull(PA.s_Address,'''') As ''PickUpAddress'',    
  --WOA.n_WoActivityId As ''WoActivityId'', 
  WOA.n_WorkOrderNo As ''WorkOrderNo'', PA.n_CustomerId ''CustomerId''   
  From tbl_WoActivities WOA          
   Inner Join tbl_WorkOrder WO On WOA.n_WorkOrderNo =  WO.n_WorkorderNo           
   inner  Join  tbl_PickupAddress PA On  WOA.n_PickupAddressId   =  PA.n_PickupAddressId     
  Where WOA.n_WorkOrderNo = Case @WorkOrderNo When 0 Then WOA.n_WorkOrderNo Else @WorkOrderNo End     
  --Order by Isnull(PA.s_Address,'' '')    
  End Try            
 Begin Catch            
 Exec usp_GetErrorInfo            
 End Catch                            
End' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_EditMakerSearchData]    Script Date: 11/05/2015 18:01:09 ******/
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
    --BD.s_LocationCode  ''Box Location'',      
    FD.s_FileBarCode ''File BarCode'',                      
    FD.s_FileName ''File Description1'',                        
    FD.s_FileDescription1 ''File Description2'', fd.n_DepartmentId ''DepartmentId'' ,      
    FD.s_Year ''Year'' ,CONVERT(Varchar(10), Convert(Date,FD.d_FromDate,103),103) ''FromDate''   ,                    
    CONVERT(Varchar(10), Convert(Date,FD.d_EndDate ,103),103) ''ToDate''  ,          
    FD.s_Label1 ''File Type'',      
    FD.s_Label2 ''From No'',FD.s_Label3 ''To No'',                        
    CONVERT(Varchar(10), Convert(Date,FD.d_DestructionDueDate,103),103) ''Destruction Due Date'' , FD.n_ModifiedBy ''ModifiedBy'' , 
    acm.s_AppCodeName  ''ApproveStatus''     
    from     tbl_FileDetails fd      
    inner join tbl_FileTransactions ft on fd.n_FileId=ft.n_FileId        
    inner join tbl_BoxDetails bd on bd.n_BoxId=fd.n_BoxId   
    inner join tbl_ApplicationCodeMaster ACM on ACM.n_AppCodeId=FD.n_ApproveStatus      
    where      
     (FD.n_FileId = @FileId)      
 end try                          
 begin catch                          
 end catch                        
END ' 
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_InsertUpdateFileDetails_2]    Script Date: 11/05/2015 18:01:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Usp_InsertUpdateFileDetails_2]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N' -- [Usp_InsertUpdateFileDetails_2] 0, ''SAS5013'', ''SAS50F4'', 3, ''FILE 1 Desc1'',''FILE 1 Desc2'', ''DGDT'', ''2014'', ''01-10-2012'', ''31-10-2013'' , ''11'', ''33'', ''31-10-2014'',259, 3986, 0         
        
 -- [Usp_InsertUpdateFileDetails_2] 49392, ''926_P1'', ''926_F1'', 3, ''926_F1 File'','''', '''', '''', '''', '''' , '''', '''', '''', 47, 0      
  -- [Usp_InsertUpdateFileDetails_2] 0, ''926_P1'', ''926_F6'', 108, ''926_F6 File'','''', '''', '''', '''', '''' , '''', '''', '''', 47, 0      
        
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
@isExist int out   
        
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
         
if exists(select n_FileId from tbl_FileDetails where n_FileId = @FileId )  --s_FileBarCode=@FileBarcode and n_FileId <> @FileId      
  begin       
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
 SET NOCOUNT ON       
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
    SET NOCOUNT OFF  
    Insert Into tbl_FileTransactions(n_FileId , n_WoActivityId ,d_ModifiedDate ,n_ModifiedBy) VALUES (SCOPE_IDENTITY(), @WoActivityId, GETDATE(), 1)
 end  
         
 end try                   
 begin catch                            
 end catch                          
END ' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertUpdateFileDetails]    Script Date: 11/05/2015 18:01:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_InsertUpdateFileDetails]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
  
/*  
update tempdata set [file barcode] = ''GAAb1f80''  
select * from tempdata   
exec usp_InsertUpdateFileDetails 180 , 1,   
''<NewDataSet><Root><SrNo>1</SrNo><FileId>0</FileId><BoxBarCode>GA16b1</BoxBarCode><FileBarCode>GAAb1f80</FileBarCode><sFileName/><DepartmentId>3</DepartmentId><sYear>2015</sYear><FromDate>2015-07-09T00:00:00</FromDate><EndDate>2015-07-11T00:00:00</EndDate
><Label1/><Label2/><Label3/></Root></NewDataSet>''  
,3439 , 1 , 0 , null , null ,null , 0   
*/  
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  
CREATE  Procedure [dbo].[usp_InsertUpdateFileDetails]    
(    
 @pn_CustomerId       Int         ,         
 @pn_WareHouseId      TinyInt       ,      
 @ps_xmlFileDetails   Varchar(Max)  ,    
 @pn_WoActivityId   Int   ,    
 @pn_ModifiedBy       SmallInt  ,     
 @IsNew      Bit , --0 = New 1 = Update     
  --@ImageName           varchar(100)='''',      
 @ImageExtenstion   varchar(10)=null,      
 @IMEINo     varchar(50)=null,      
 @MobileNo            varchar(15)=null    ,  
@IsExcelImport int = null   
)    
As      
Begin Tran    
 Begin Try    
    Create Table #TempxmlFileDetails    
   (     
    Id       Int   Identity(1,1)   , FileId     Int              ,    
    BoxBarCode     Varchar(16)           , FileBarCode    Varchar(16)      ,      
    sFileName       Varchar(255)          , DepartmentId   Int               ,     
    sYear         Varchar(30)           , FromDate       Varchar(20)       ,    
    EndDate         Varchar(20)           , Label1         Varchar(500)      ,          
    Label2          Varchar(500)    , Label3         Varchar(500)    ,       
    fileStatus     SmallInt     , FileRemarks   Varchar(200)    ,   
    FileDescription1 Varchar(255),DestructionDueDate  Varchar(20),  
    IsBoxExist     Bit, IsFileExist Bit        
   )     
    
  Declare @docHandle Int;      
  Exec sp_xml_preparedocument @docHandle Output, @ps_xmlFileDetails;      
  Insert Into #TempxmlFileDetails Select * From OpenXml(@docHandle, ''/NewDataSet/Root'',2) With #TempxmlFileDetails     
  Exec sp_xml_removedocument @docHandle;    
  ----Get Pick Address Id     
      
        Declare @BranchId  Int    
    Select @BranchId= n_PickupAddressId      
    From tbl_WoActivities Where  n_WoActivityId = @pn_WoActivityId    
        
  If(@IsNew = 0)    
 Begin    
  
  Declare @n_WorkOrderNo  Int    
  Select @n_WorkOrderNo= n_WorkOrderNo      
  From tbl_WoActivities Where  n_WoActivityId = @pn_WoActivityId    
  Declare @FileStatus  SmallInt    
  Select @FileStatus = n_AppCodeId  From tbl_ApplicationCodeMaster Where s_AppCode = ''BOXFILE_STATUS'' And s_AppCodeName =''In''    
  Update #TempxmlFileDetails Set IsBoxExist = 1   From #TempxmlFileDetails T     
  Left Join     
    tbl_BoxDetails TB  On  T.BoxBarCode = TB.s_BoxBarCode     
     Where Isnull(TB.s_BoxBarCode,'''') <> ''''    
  --For dispaly result--    
  Create Table #TempResult    
  (     
  SrNo   Int   Identity(1,1)   ,   FileCode        Varchar(16)   NULL,    
  BoxCode      Varchar(16) null , Result  Varchar(100)                     
  )    
  
  --Duplicate files     
  Insert Into #TempResult Select   T.FileBarCode ,'''',''File already exist''        
  From tbl_FileDetails TF     
  Inner Join #TempxmlFileDetails T On TF.s_FileBarCode = T.FileBarCode     
  Where TF.s_FileBarCode  Is not  Null    
  
  Update  #TempxmlFileDetails     
  Set IsFileExist = 1      
  From #TempxmlFileDetails T     
  Inner Join    
  tbl_BoxDetails  TB     On      
  T.BoxBarCode = TB.s_BoxBarCode    
  Left Join     
  tbl_FileDetails TF      On     
  T.FileBarCode = TF.s_FileBarCode     
  Where TF.s_FileBarCode  Is Null     
  
  Declare @ApproveStatus SmallInt   
  select @ApproveStatus= n_AppCodeId From tbl_ApplicationCodeMaster   
  Where s_AppCode = ''BOXFILE_STATUS'' And s_AppCodeName =''Pending''  
  
  Insert Into tbl_FileDetails (     n_BoxId, s_FileBarCode, s_FileName, n_BranchId, n_DepartmentId, s_Year,   
  d_FromDate,  d_EndDate ,    
  s_Label1, s_Label2, s_Label3, n_Status, d_ModifiedDate, n_ModifiedBy,  
  s_FileRemarks, s_FileDescription1,  
  d_DestructionDueDate, s_ImageExtention,      
  s_IMEINo, s_MobileNo, n_ApproveStatus   
  )              
  Select      TB.n_BoxId, FileBarCode, sFileName, @BranchId, DepartmentId, sYear,   
  Case When FromDate  =  '''' Then null else Convert(Date,FromDate,103)  End ,     
  Case When EndDate   =  '''' Then null else Convert(Date,EndDate,103)   End ,     
  Label1, Label2, Label3, @FileStatus, GETDATE(), @pn_ModifiedBy,  
  FileRemarks, FileDescription1,   
  Case When DestructionDueDate   =  '''' Then null else Convert(Date,DestructionDueDate,103)  End , @ImageExtenstion,   
  @IMEINo, @MobileNo, @ApproveStatus     
  From #TempxmlFileDetails T     
  Inner Join    
  tbl_BoxDetails  TB  On  T.BoxBarCode = TB.s_BoxBarCode    
  Left Join tbl_FileDetails TF On T.FileBarCode = TF.s_FileBarCode     
  Where TF.s_FileBarCode  Is Null     
  
  
  IF ( @IsExcelImport is not null )   
   Begin  
    Insert Into tbl_FileTransactions(n_FileId , n_WoActivityId ,d_ModifiedDate ,n_ModifiedBy)    
    Select   
     distinct  TF.n_FileId , @pn_WoActivityId , GETDATE() , @pn_ModifiedBy    
    From   
     #TempxmlFileDetails T     
     Inner Join tbl_BoxDetails  TB    On T.BoxBarCode = TB.s_BoxBarCode     
     Inner Join tbl_FileDetails  TF  On TB.n_BoxId = TF.n_BoxId     
     Inner Join TempData TD on rtrim(ltrim(TD.[FILE BARCODE])) = rtrim(ltrim(TF.s_FileBarCode))   
    Where   
     T.FileBarCode Not in   
      (Select distinct  FileCode From #TempResult where FileCode is not null  )    
     And TB.n_BoxId IN(  
          Select TBT.n_BoxId From tbl_BoxTransactions TBT     
          Inner join tbl_BoxDetails TB On TB.n_BoxId = TBT.n_BoxId     
          Where TBT.n_WoActivityId In(Select n_WoActivityId From tbl_WoActivities Where n_WorkOrderNo = @n_WorkOrderNo)    
         )       
   End   
   Else   
   Begin  
    Insert Into tbl_FileTransactions(n_FileId , n_WoActivityId ,d_ModifiedDate ,n_ModifiedBy)    
    Select   
     distinct  TF.n_FileId , @pn_WoActivityId , GETDATE() , @pn_ModifiedBy    
    From   
     #TempxmlFileDetails T     
     Inner Join tbl_BoxDetails  TB    On T.BoxBarCode = TB.s_BoxBarCode     
     Inner Join tbl_FileDetails  TF  On TB.n_BoxId = TF.n_BoxId     
    Where   
     T.FileBarCode Not in   
      (Select distinct  FileCode From #TempResult where FileCode is not null  )    
     And TB.n_BoxId IN(  
          Select TBT.n_BoxId From tbl_BoxTransactions TBT     
          Inner join tbl_BoxDetails TB On TB.n_BoxId = TBT.n_BoxId     
          Where TBT.n_WoActivityId In(Select n_WoActivityId From tbl_WoActivities Where n_WorkOrderNo = @n_WorkOrderNo)    
         )       
   End   
  
  Select distinct  BoxCode,FileCode,Result From #TempResult      
  End    
  Else    
     Begin    
            
      Update  tbl_FileDetails    
    Set n_Status     = fileStatus     ,    
    d_ModifiedDate        = GETDATE()      ,    
    n_ModifiedBy     = @pn_ModifiedBy    
    From tbl_FileDetails TFD     
       Inner join     
       #TempxmlFileDetails T On     
       TFD.n_FileId = T.FileId     
        
       Insert Into tbl_FileTransactions(n_FileId        , n_WoActivityId    ,    
                                              d_ModifiedDate  , n_ModifiedBy)      
     Select  TF.n_FileId , @pn_WoActivityId , GETDATE(), @pn_ModifiedBy      
     From #TempxmlFileDetails T    
        Inner Join       
     tbl_FileDetails  TF  On   TF.n_FileId =T.FileId    
    -------Permanent out the box when its all file out     
           
   Declare @PermanentOutSttaus  SmallInt      
   Select  @PermanentOutSttaus = n_AppCodeId  From tbl_ApplicationCodeMaster Where s_AppCode = ''BOXFILE_STATUS'' And s_AppCodeName =''PERMANENT OUT''       
     --    Select * From tbl_WoActivities Where n_WorkOrderNo in (2014000047)    
    
   Create Table #FileCount(n_BoxId Int, n_TotalFiles Int ,n_PermanertOutFiles Int )    
   Insert Into  #FileCount(n_BoxId , n_TotalFiles)    
       
   Select TF.n_BoxId,COUNT(TF.n_FileId )    
   From  #TempxmlFileDetails   T  Inner Join     
       tbl_FileDetails TF     
    On T.FileId = TF.n_FileId     
     Inner Join     
      tbl_BoxDetails      TB   On TF.n_BoxId = TB.n_BoxId     
           
   Group by TF.n_BoxId Order by TF.n_BoxId desc    
    
   Update  #FileCount     
   Set #FileCount.n_PermanertOutFiles = T.CountPermanertOutFiles    
   From #FileCount     
   Inner Join    
   (Select     
   TF.n_BoxId As n_BoxId,COUNT(TF.n_FileId )[CountPermanertOutFiles]      
     From      
      #TempxmlFileDetails  T1  Inner join  tbl_FileDetails TF   On T1.FileId = TF.n_FileId      
        Inner Join     
   tbl_BoxDetails  TB   On TF.n_BoxId  = TB.n_BoxId     
   Where TF.n_Status = @PermanentOutSttaus Group by TF.n_BoxId)T    
    On T.n_BoxId = #FileCount.n_BoxId     
       
   Update tbl_BoxDetails Set n_Status = @PermanentOutSttaus      
   From tbl_BoxDetails TB Inner Join #FileCount TF On  TB.n_BoxId = TF.n_BoxId     
   Where TF.n_TotalFiles = TF.n_PermanertOutFiles  And Isnull(TF.n_PermanertOutFiles,0) != 0     
       
            -----------------    
           End    
  Drop table #TempxmlFileDetails    
  commit Tran    
        
End Try      
Begin Catch      
 Rollback Tran    
 Exec usp_GetErrorInfo      
End Catch   
  ' 
END
GO
