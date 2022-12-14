
CREATE TABLE [dbo].[tbl_BoxInfo](
	[BOX_BARCODE] [varchar](255) NULL
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[tbl_FileInfo](
	[FILE_BARCODE] [varchar](255) NULL
) ON [PRIMARY]

GO

/****** Object:  StoredProcedure [dbo].[usp_InsertClientData]    Script Date: 10/14/2015 11:44:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_InsertClientData]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_InsertClientData]
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertUpdateFileDetails]    Script Date: 10/14/2015 11:44:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_InsertUpdateFileDetails]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_InsertUpdateFileDetails]
GO
/****** Object:  StoredProcedure [dbo].[usp_getMakerSearchData]    Script Date: 10/14/2015 11:44:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_getMakerSearchData]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_getMakerSearchData]
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertUpdateMakerFileDetails]    Script Date: 10/14/2015 11:44:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_InsertUpdateMakerFileDetails]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_InsertUpdateMakerFileDetails]
GO
/****** Object:  StoredProcedure [dbo].[usp_CheckFPCountForCloseWOActivity]    Script Date: 10/14/2015 11:44:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_CheckFPCountForCloseWOActivity]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_CheckFPCountForCloseWOActivity]
GO
/****** Object:  StoredProcedure [dbo].[usp_EditMakerSearchData]    Script Date: 10/14/2015 11:44:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_EditMakerSearchData]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_EditMakerSearchData]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetCustomer_WorkOrder]    Script Date: 10/14/2015 11:44:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_GetCustomer_WorkOrder]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_GetCustomer_WorkOrder]
GO
/****** Object:  StoredProcedure [dbo].[usp_LoginDetails]    Script Date: 10/14/2015 11:44:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_LoginDetails]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_LoginDetails]
GO
/****** Object:  StoredProcedure [dbo].[usp_xlImp_ValidateTempData]    Script Date: 10/14/2015 11:44:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_xlImp_ValidateTempData]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_xlImp_ValidateTempData]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetGetWoActivityID]    Script Date: 10/14/2015 11:44:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_GetGetWoActivityID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_GetGetWoActivityID]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetPickupAddressOnWO]    Script Date: 10/14/2015 11:44:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_GetPickupAddressOnWO]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_GetPickupAddressOnWO]
GO
/****** Object:  StoredProcedure [dbo].[usp_CheckBoxByBarCode]    Script Date: 10/14/2015 11:44:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_CheckBoxByBarCode]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_CheckBoxByBarCode]
GO
/****** Object:  StoredProcedure [dbo].[usp_CheckFileByBoxIDBarCode]    Script Date: 10/14/2015 11:44:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_CheckFileByBoxIDBarCode]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_CheckFileByBoxIDBarCode]
GO
/****** Object:  StoredProcedure [dbo].[Usp_InsertUpdateFileDetails_2]    Script Date: 10/14/2015 11:44:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Usp_InsertUpdateFileDetails_2]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Usp_InsertUpdateFileDetails_2]
GO
/****** Object:  StoredProcedure [dbo].[usp_xlRetr_ValidateBox]    Script Date: 10/14/2015 11:44:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_xlRetr_ValidateBox]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_xlRetr_ValidateBox]
GO
/****** Object:  StoredProcedure [dbo].[usp_xlRetr_ValidateFile]    Script Date: 10/14/2015 11:44:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_xlRetr_ValidateFile]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_xlRetr_ValidateFile]
GO
/****** Object:  StoredProcedure [dbo].[usp_xlImp_CheckDepartment]    Script Date: 10/14/2015 11:44:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_xlImp_CheckDepartment]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_xlImp_CheckDepartment]
GO
/****** Object:  StoredProcedure [dbo].[usp_xlImp_CheckDepartment]    Script Date: 10/14/2015 11:44:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_xlImp_CheckDepartment]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_xlImp_CheckDepartment]
AS
BEGIN 
	
SET NOCOUNT ON;

Select 
	Distinct dept 
From 
	TempData 
Where 
	dept Not In (
	Select s_appcodename From tbl_applicationcodemaster Where s_AppCode = ''DEPARTMENT'') 
   
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_xlRetr_ValidateFile]    Script Date: 10/14/2015 11:44:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_xlRetr_ValidateFile]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_xlRetr_ValidateFile]
	
AS
BEGIN
	
	SET NOCOUNT ON;
	declare @retTable Table (ErrorMsg varchar(250))  
	
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
 
 Select ErrorMsg as [Error Message] from @retTable  
 END
    

 
' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_xlRetr_ValidateBox]    Script Date: 10/14/2015 11:44:59 ******/
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

if exists ( select * from tbl_BoxInfo where [BOX_BARCODE] is null )   
begin   
 insert @retTable (ErrorMsg)   
 select ''Box bar code is blank for '' + convert ( varchar(10) , count(*))    + '' rows.''  from tbl_BoxInfo     
 where [BOX_BARCODE] is null     
end   

BEGIN
insert @retTable (ErrorMsg)   
Select ''Box bar code is duplicate for '' +  Rtrim(ltrim([BOX_BARCODE]))     
From tbl_BoxInfo      
Group by  [BOX_BARCODE]  having COUNT( Rtrim(ltrim([BOX_BARCODE]))) > 1
END  

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
 
 
 select * from @retTable 
End
  

' 
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_InsertUpdateFileDetails_2]    Script Date: 10/14/2015 11:44:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Usp_InsertUpdateFileDetails_2]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
    
 -- [Usp_InsertUpdateFileDetails_2] 49392, ''926_P1'', ''926_F1'', 3, ''926_F1 File'','''', '''', '''', '''', '''' , '''', '''', '''', 0  
  -- [Usp_InsertUpdateFileDetails_2] null, ''926_P1'', ''926_F3'', 108, ''926_F3 File'','''', '''', '''', '''', '''' , '''', '''', '''', 0  
    
CREATE procedure [dbo].[Usp_InsertUpdateFileDetails_2]    
@FileId int,    
@BoxBarcode nvarchar(250),                      
@FileBarcode nvarchar(250),                                        
@Department int,         
@FileDesc1 nvarchar(250),                        
@FileDesc2 nvarchar(250),        
@FileType varchar(15),          
@Year varchar(15) ,        
@FromDate varchar(15),                     
@ToDate varchar(15),                  
@FromNum varchar(15),                     
@ToNum varchar(15),        
@DestructionDueDate varchar(15),    
@isExist int out    
--@Transidsec int out          
    
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
  if(@ToDate='''' or @ToDate is null )                                                                                                                                                            
 set @ToDate=null    
  if(@FromNum='''' or @FromNum is null )                                                                                                                                                            
 set @FromNum=null    
  if(@ToNum='''' or @ToNum is null )                                                                                                                                                            
 set @ToNum=null    
 if(@DestructionDueDate='''' or @DestructionDueDate is null )                                                                                                                                                            
 set @DestructionDueDate=null    
       
   declare @BoxId int    
    --select @BoxId=n_BoxId from tbl_FileDetails where n_FileId = @FileId               
-- if exists (select n_FileId from tbl_FileDetails where s_FileBarCode=''926_F1'' and n_FileId <> 49392)    
 set @isExist = 0      
     
if exists(select n_FileId from tbl_FileDetails where n_FileId = @FileId OR s_FileBarCode=@FileBarcode )  --s_FileBarCode=@FileBarcode and n_FileId <> @FileId  
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
 end                       
     
 else                                                                                                                                                
 begin     
 select @BoxId=n_BoxId from tbl_BoxDetails where s_BoxBarCode = @BoxBarcode   
 --print n_BoxId                    
 INSERT INTO [dbo].[tbl_FileDetails] (    
           [n_BoxId], [s_FileBarCode], [s_FileName], [n_DepartmentId], [s_Year], [d_FromDate], [d_EndDate], [s_Label1], [s_Label2],    
            [s_Label3], [n_Status], [n_ApproveStatus], [s_FileDescription1] ,[d_DestructionDueDate]    
           )    
     VALUES (                                                                                                                  
    @BoxId, @FileBarcode, @FileDesc1, @Department, @Year, @FromDate, @ToDate, @FileType, @FromNum, @ToNum, @Status_in, @ApproveStatus_Pending,    
     @FileDesc2, @DestructionDueDate    
     )    
    set @isExist = 0    
 end     
    
     
 end try               
 begin catch                        
 end catch                      
END      ' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_CheckFileByBoxIDBarCode]    Script Date: 10/14/2015 11:44:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_CheckFileByBoxIDBarCode]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/****** Object:  StoredProcedure [dbo].[usp_CheckFileByBoxIDBarCode]   Script Date: 08/09/2015 09:50:43 ******/      
CREATE Procedure [dbo].[usp_CheckFileByBoxIDBarCode]          
(@BoxBarCode      Varchar(50),    
 @FileBarCode      Varchar(50),    
 @WorkOrderNo  Int ,     
 @ActivityID Int,          
 @BoxId    Int output ,    
 @FileId int output    
 )           
 As          
Begin          
   begin try      
   declare @n_FileId  int         
   declare @n_WoActivityId int     
   declare @n_FileStatus int     
   set @n_FileId=0;    
   Select @BoxId= n_BoxId From tbl_BoxDetails Where s_BoxBarCode  =  @BoxBarCode      
   Select @n_FileId= n_FileId From tbl_FileDetails Where s_FileBarCode=@FileBarCode    
   select @n_WoActivityId=n_WoActivityId from tbl_WoActivities where n_ActivityId=@ActivityID and n_WorkOrderNo=@WorkOrderNo    
   Select @n_FileStatus=n_AppCodeId  From tbl_ApplicationCodeMaster Where s_AppCode = ''BOXFILE_STATUS'' And s_AppCodeName =''In''    
   set @FileId=@n_FileId      
   select @BoxId BoxId,@FileId FileId,@n_WoActivityId WoActivityId,@n_FileStatus FileStatus       
      
    
      
        
        
   end try      
   begin catch      
 set @BoxId=0      
   end catch      
       
End ' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_CheckBoxByBarCode]    Script Date: 10/14/2015 11:44:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_CheckBoxByBarCode]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/****** Object:  StoredProcedure [dbo].[usp_CheckBoxByBarCode]  ''2014000001'',''GA10501'',''''   Script Date: 08/09/2015 09:50:43 ******/      
CREATE Procedure [dbo].[usp_CheckBoxByBarCode]          
(@BarCode      Varchar(50),    
 @WorkOrderNo  Int , 
 @ActivityID Int,          
 @BoxId    Int Output        
 )           
 As          
Begin          
   begin try      
   --declare @n_BoxId  int         
   declare @n_WoActivityId int  
      declare @n_BoxStatus int   
   set @BoxId =0;    
   Select @BoxId= n_BoxId From tbl_BoxDetails Where s_BoxBarCode  =  @BarCode      
   select @n_WoActivityId=n_WoActivityId from tbl_WoActivities where n_ActivityId=@ActivityID and n_WorkOrderNo=@WorkOrderNo  
    Select @n_BoxStatus=n_AppCodeId  From tbl_ApplicationCodeMaster Where s_AppCode = ''BOXFILE_STATUS'' And s_AppCodeName =''In''  
   --set @BoxId=@n_BoxId      
    select @BoxId BoxId,@n_WoActivityId WoActivityId,@n_BoxStatus BoxStatus      
      
    
      
        
        
   end try      
   begin catch      
 set @BoxId=0      
   end catch      
       
End ' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetPickupAddressOnWO]    Script Date: 10/14/2015 11:44:59 ******/
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
 Select PA.n_PickupAddressId as ''PickupAddressId'', Isnull(PA.s_Address,'''') As ''PickUpAddress'',  
  WOA.n_WoActivityId As ''WoActivityId'', WOA.n_WorkOrderNo As ''WorkOrderNo'', PA.n_CustomerId ''CustomerId'' 
  From tbl_WoActivities WOA        
   Inner Join tbl_WorkOrder WO On WOA.n_WorkOrderNo =  WO.n_WorkorderNo         
   inner  Join  tbl_PickupAddress PA On  WOA.n_PickupAddressId   =  PA.n_PickupAddressId   
  Where WOA.n_WorkOrderNo = Case @WorkOrderNo When 0 Then WOA.n_WorkOrderNo Else @WorkOrderNo End   
  Order by Isnull(PA.s_Address,'' '')  
  End Try          
 Begin Catch          
 Exec usp_GetErrorInfo          
 End Catch                          
End' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetGetWoActivityID]    Script Date: 10/14/2015 11:44:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_GetGetWoActivityID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- exec [usp_GetGetWoActivityID] 2015000975, 2

CREATE Procedure [dbo].[usp_GetGetWoActivityID]            
@WorkOrderNo  int ,
@ActivityId int                      
As            
Begin            
 SET NOCOUNT ON
   /* PROCEDURE CONSTANTS */              
Declare @Activity_NewBoxCost int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''New Standard Box Cost (1.50 Cubic Ft.)'')               
Declare @Activity_BarcodingDataEntry int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''Bar-coding & Data Entry (File & Box)'')
/* PROCEDURE CONSTANTS */
 begin try 
select  wa.n_WoActivityId ''WoActivityId'', wa.n_WorkOrderNo ''WorkOrderNo'', wa.n_ActivityId ''ActivityId''
from tbl_WoActivities wa
inner join tbl_WorkOrder wo on wo.n_WorkorderNo=wa.n_WorkOrderNo
inner join tbl_activity a on a.n_ActivityId=wa.n_ActivityId
where wa.n_WorkOrderNo=@WorkOrderNo and a.n_ActivityId = @ActivityId--in(@Activity_NewBoxCost, @Activity_BarcodingDataEntry)
end try              
 begin catch                        
 end catch                      
END ' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_xlImp_ValidateTempData]    Script Date: 10/14/2015 11:44:59 ******/
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
Where ([dept] like ''%-%'' OR [dept] like ''%`%'' OR [dept] like ''%!%''      
 OR [dept] like ''%@%'' OR [dept] like ''%#%'' OR [dept] like ''%$%''      
 OR ([dept] like ''%\%%'' ESCAPE ''\'') OR [dept] like ''%^%'' OR [dept] like ''%&%''      
 OR [dept] like ''%*%'' OR [dept] like ''%(%'' OR [dept] like ''%)%''      
 OR ([dept] like ''%\_%'' ESCAPE ''\'') OR [dept] like ''%+%'' OR [dept] like ''%=%''      
 OR [dept] like ''%|%'' OR [dept] like ''%\%'' OR [dept] like ''%?%''      
 OR [dept] like ''%:%'' OR [dept] like ''%;%'' OR [dept] like ''%''''%''      
 OR [dept] like ''%"%'' OR [dept] like ''%<%'' OR [dept] like ''%>%''      
 OR [dept] like ''%,%'' OR [dept] like ''%.%'' OR [dept] like ''%/%''         
 OR [dept] like ''%~%''          
 )   
      
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
/****** Object:  StoredProcedure [dbo].[usp_LoginDetails]    Script Date: 10/14/2015 11:44:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_LoginDetails]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'--select * from tbl_BoxDetails  
--select * from tbl_FileDetails  
  
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
                     
 select distinct  --top 10          
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
/****** Object:  StoredProcedure [dbo].[usp_GetCustomer_WorkOrder]    Script Date: 10/14/2015 11:44:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_GetCustomer_WorkOrder]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
  
-- exec [usp_GetCustomer_WorkOrder] 1  
  
CREATE Procedure [dbo].[usp_GetCustomer_WorkOrder]            
@WareHouseId  TinyInt                       
As            
Begin            
 SET NOCOUNT ON   
    --Declare @Status_WorkOrder_Open int = (Select n_AppCodeId From tbl_applicationcodemaster Where s_AppCode = ''WORKORDER_STATUS'' And s_AppCodeName = ''Open'')   
  
  
  /* PROCEDURE CONSTANTS */              
Declare @Activity_NewBoxCost int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''New Standard Box Cost (1.50 Cubic Ft.)'')               
Declare @Activity_BarcodingDataEntry int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''Bar-coding & Data Entry (File & Box)'')               
Declare @Activity_StandardBoxTransportation int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''Standard Box Transportation'') 
Declare @Status_WorkOrder_Open int = (Select n_AppCodeId From tbl_applicationcodemaster Where s_AppCode = ''WORKORDER_STATUS'' And s_AppCodeName = ''Open'' )       
             
/* PROCEDURE CONSTANTS */                    
 Select  distinct WO.n_WorkorderNo       As ''WorkorderNo''  ,TC.s_CustomerName + '' - '' + cast(WO.n_WorkorderNo as varchar) ''CustomerWorkorder''                 ,              
        TC.n_CustomerId                    As ''CustomerId''      ,TC.s_CustomerName              As ''CustomerName''  ,        
         TWM.n_WareHouseId                 As ''WareHouseId''     ,TWM.s_WarehouseName            As ''WareHouseName''   ,          
         WO.n_Status                       As ''WoStatusId''      ,ACM.s_AppCodeName              As ''WoStatus''	       
        --, WA.n_WoActivityId				   As ''WoActivityId''  
          
  From tbl_WorkOrder WO           
          Inner Join   
          tbl_WoActivities WA on WA.n_WorkOrderNo=WO.n_WorkorderNo
          Inner Join
       tbl_Customer TC On WO.n_CustomerId = TC.n_CustomerId          
          Inner Join  
       tbl_WareHouseMaster TWM On WO.n_WareHouseId = TWM.n_WareHouseId              
          Inner Join            
       tbl_ApplicationCodeMaster ACM On ACM.n_AppCodeId= WO.n_Status   
      Where   
      TWM.n_WareHouseId = Case @WareHouseId    When  0 Then TWM.n_WareHouseId      Else  @WareHouseId End   
      And WO.n_Status = @Status_WorkOrder_Open 
      and WA.n_ActivityId in (@Activity_NewBoxCost)
       Order by TC.s_CustomerName, Wo.n_WorkorderNo           
                   
End ' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_EditMakerSearchData]    Script Date: 10/14/2015 11:44:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_EditMakerSearchData]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

     
            
CREATE PROCEDURE [dbo].[usp_EditMakerSearchData] -- usp_EditMakerSearchData 100000     
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
    CONVERT(Varchar(10), Convert(Date,FD.d_DestructionDueDate,103),103) ''Destruction Due Date'' , FD.n_ModifiedBy ''ModifiedBy''   
    from     tbl_FileDetails fd    
    inner join tbl_FileTransactions ft on fd.n_FileId=ft.n_FileId      
    inner join tbl_BoxDetails bd on bd.n_BoxId=fd.n_BoxId    
    where    
     (FD.n_FileId = @FileId)    
 end try                        
 begin catch                        
 end catch                      
END ' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_CheckFPCountForCloseWOActivity]    Script Date: 10/14/2015 11:44:59 ******/
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

	IF (@TYPE=1)				--type is for File Pick Up Service of Work Order
	Begin
		Declare @WOFPBX int, @WOFPFL int, @AFPBX int, @AFPFL int

		select @SC = n_ServiceCategoryId from tbl_ServiceCategory Where s_SCName like ''%File Pick Up%''

		select @WOFPBX =n_BoxCount From tbl_WoActivities Where n_WorkOrderNo = @WORKORDER AND n_ActivityId 
		= (select n_ActivityId from tbl_Activity where n_ServiceCategoryId = @SC AND s_ActivityName like ''%New Standard Box Cost (1.50 Cubic Ft.)%'')
		select @WOFPFL =n_FileCount From tbl_WoActivities Where n_WorkOrderNo = @WORKORDER AND n_ActivityId = 2

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
			select 1 as ''Pending'','''' as ''MSG''		--BOXES OK
		End
		else
		Begin
			Insert Into #RESULT (Pending,MSG)
			select 0 as ''Pending'',''Box Counts in Word Order (''+ CONVERT(Varchar(10),@WOFPBX)+  '') and Maker/Checker (''+ CONVERT(Varchar(10),@AFPBX)+ '') Do Not Match ''  as ''MSG''
		End
			
		if(@WOFPFL = @AFPFL)
		Begin
			Insert Into #RESULT (Pending,MSG)
			select 1 as ''Pending'','''' as ''MSG''		--FILES OK
		End
		else
		Begin
			Insert Into #RESULT (Pending,MSG)
			select 0 as ''Pending'',''File Counts in Work Order (''+CONVERT(Varchar(10),@WOFPFL)+'') and Maker/Checker (''+CONVERT(Varchar(10),@AFPFL) + '') Do Not Match'' as ''MSG''
		End
	End
	IF (@TYPE=2)							--type is for Other Services (File Pick Up) Service of Work Order
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
	
	IF (@TYPE=3)							--type is for Retreival Service of Work Order
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
/****** Object:  StoredProcedure [dbo].[usp_InsertUpdateMakerFileDetails]    Script Date: 10/14/2015 11:44:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_InsertUpdateMakerFileDetails]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/*************************************************************************************************/  
 --exec [usp_InsertUpdateMakerFileDetails] 180, 1,
 -- ''<NewDataSet><Root><SrNo>1</SrNo><FileId>47599</FileId><BoxBarCode>BB1</BoxBarCode><FileBarCode>FF1</FileBarCode><sFileName>FILE 1 Desc1</sFileName>
 -- <DepartmentId>5</DepartmentId><sYear>2013</sYear><FromDate>01/01/2013</FromDate><EndDate>01/01/2013</EndDate><Label1>L1</Label1><Label2>L2</Label2>
 -- <Label3>L3</Label3><fileStatus>48</fileStatus><FileDesc2></FileDesc2><DestructionDueDate></DestructionDueDate></Root></NewDataSet>''
 --,3372, 1, 1
/*************************************************************************************************/  
CREATE Procedure [dbo].[usp_InsertUpdateMakerFileDetails]
(                      
 @pn_CustomerId       Int         ,                           
 @pn_WareHouseId      TinyInt       ,                        
 @ps_xmlFileDetails   Varchar(Max)  ,                      
 @pn_WoActivityId   Int   ,                      
 @pn_ModifiedBy       SmallInt  ,                       
 @IsNew      Bit  --0 = New 1 = Update                       
)                      
As                        
Begin--Begin Proc [usp_InsertUpdateMakerFileDetails]  
  
Begin Tran                      
 Begin Try                      
   Create Table #TempxmlFileDetails                      
   (                       
     Id             Int   Identity(1,1)   , FileId          Int        ,                      
     BoxBarCode     Varchar(20)           , FileBarCode     Varchar(16),                        
    sFileName       Varchar(255)          , Department      Varchar(20),                  
    sYear         Varchar(30)             , FromDate        Varchar(20),                      
    EndDate         Varchar(20)           , Label1          Varchar(500),                            
    Label2              Varchar(500)          , Label3          Varchar(500),                         
    fileStatus          SmallInt               , IsBoxExist      Bit         ,                      
    IsFileExist         Bit                   , DepartmentId    Int ,      
    FileDescription1  Varchar(255), DestructionDueDate   Varchar(20)                        
   )                       
                      
  Declare @docHandle Int;                        
  Exec sp_xml_preparedocument @docHandle Output, @ps_xmlFileDetails;                        
  Insert Into #TempxmlFileDetails Select * From OpenXml(@docHandle, ''/NewDataSet/Root'',2) With #TempxmlFileDetails                       
  Exec sp_xml_removedocument @docHandle;   
      
  ----Get Pick Address Id                       
                        
        Declare @BranchId  Int                      
    Select @BranchId= n_PickupAddressId                        
    From tbl_WoActivities Where  n_WoActivityId = @pn_WoActivityId                      
      --Select * From #TempxmlFileDetails                    
  If(@IsNew = 0)                      
  Begin                      
                        
   Declare @n_WorkOrderNo  Int                      
    Select @n_WorkOrderNo= n_WorkOrderNo                        
    From tbl_WoActivities Where  n_WoActivityId = @pn_WoActivityId                      
      Declare @FileStatus  SmallInt ,@ApproveStatus SmallInt                     
      Select @FileStatus = n_AppCodeId  From tbl_ApplicationCodeMaster Where s_AppCode     = ''BOXFILE_STATUS'' And s_AppCodeName =''In''                     
      Select  @ApproveStatus = n_AppCodeId  From tbl_ApplicationCodeMaster Where s_AppCode = ''BOXFILE_STATUS'' And s_AppCodeName =''Pending''                     
                           
      Update #TempxmlFileDetails Set IsBoxExist = 1   From #TempxmlFileDetails T                       
        Left Join                       
          tbl_BoxDetails TB  On  T.BoxBarCode = TB.s_BoxBarCode                       
              Where Isnull(TB.s_BoxBarCode,'''') <> ''''                      
      --For dispaly result--                      
      Create Table #TempResult                      
   (                       
    SrNo   Int   Identity(1,1)   ,   FileCode        Varchar(20)   NULL,                      
    BoxCode      Varchar(20) null , Result  Varchar(100)                                       
      )                      
      --Duplicate files                       
     Insert Into #TempResult               
     Select   T.FileBarCode ,T.BoxBarCode ,''File already exist''                   
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
   Insert Into tbl_FileDetails                      
          ( n_BoxId                       ,  s_FileBarCode            ,                      
      s_FileName                    ,  n_BranchId               ,                      
      n_DepartmentId                ,  s_Year                   ,                      
         d_FromDate    ,  d_EndDate                ,                      
      s_Label1                      ,  s_Label2                 ,                      
      s_Label3        ,  n_Status                 ,                      
      d_ModifiedDate                ,  n_ModifiedBy,n_ApproveStatus,s_FileDescription1,d_DestructionDueDate)                                 
                                        
   Select      TB.n_BoxId                    ,  FileBarCode              ,                          
      sFileName                     ,  @BranchId                ,                      
      DepartmentId               ,  sYear                    ,                      
         Case When FromDate  =  '''' Then null else Convert(Date,FromDate,103)  End ,                       
         Case When EndDate   =  '''' Then null else Convert(Date,EndDate,103)   End ,                       
      Label1                        ,  Label2                   ,                      
      Label3                        ,  @FileStatus              ,                       
      GETDATE()                   ,  @pn_ModifiedBy,@ApproveStatus,FileDescription1,      
       Case When DestructionDueDate   =  '''' Then null else Convert(Date,DestructionDueDate,103)    End                   
     From #TempxmlFileDetails T         
                         
    Inner Join                      
     tbl_BoxDetails  TB  On  T.BoxBarCode = TB.s_BoxBarCode                      
       Left Join tbl_FileDetails TF On T.FileBarCode = TF.s_FileBarCode                       
   Where TF.s_FileBarCode  Is Null                 
             
                Select      TB.n_BoxId                    ,  FileBarCode              ,                          
      sFileName                     ,  @BranchId                ,                      
      DepartmentId               ,  sYear                    ,                      
         Case When FromDate  =  '''' Then null else Convert(Date,FromDate,103)  End ,                       
         Case When EndDate   =  '''' Then null else Convert(Date,EndDate,103)   End ,                       
      Label1                        ,  Label2                   ,                      
      Label3                        ,  @FileStatus              ,                       
      GETDATE()                   ,  @pn_ModifiedBy,@ApproveStatus,FileDescription1,      
      Case When DestructionDueDate   =  '''' Then null else Convert(Date,DestructionDueDate,103)    End       
     From #TempxmlFileDetails T                       
    Inner Join                      
     tbl_BoxDetails  TB  On  T.BoxBarCode = TB.s_BoxBarCode                      
       Left Join tbl_FileDetails TF On T.FileBarCode = TF.s_FileBarCode                       
   Where TF.s_FileBarCode  Is Null          
         
      Insert Into tbl_FileTransactions(n_FileId , n_WoActivityId ,d_ModifiedDate ,n_ModifiedBy)                      
   Select distinct  TF.n_FileId , @pn_WoActivityId , GETDATE() , @pn_ModifiedBy                      
   From #TempxmlFileDetails T                       
        Inner Join                      
   tbl_BoxDetails  TB         On T.BoxBarCode = TB.s_BoxBarCode                       
        Inner Join                      
       tbl_BoxTransactions TBT   On TBT.n_BoxId=TB.n_BoxId                      
          Inner Join                      
      tbl_WoActivities TWA       On TWA.n_WoActivityId= TBT.n_WoActivityId  And TWA.n_WorkOrderNo = @n_WorkOrderNo                      
          Inner Join                      
   tbl_FileDetails  TF        On TB.n_BoxId = TF.n_BoxId                       
   Where T.FileBarCode Not in (Select distinct  FileCode From #TempResult where FileCode is not null  )           
   --and T.FileBarCode <> TF.s_FileBarCode        
      and TF.n_FileId not in (select distinct TFT.n_FileId from tbl_FileTransactions TFT)        
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
                             
      Insert Into tbl_FileTransactions(n_FileId   , n_WoActivityId    ,d_ModifiedDate ,n_ModifiedBy)                      
   Select  TF.n_FileId , @pn_WoActivityId , GETDATE()         , @pn_ModifiedBy                      
   From #TempxmlFileDetails T                       
        Inner Join                      
   tbl_BoxDetails  TB    On                      
   T.BoxBarCode = TB.s_BoxBarCode                       
        Inner Join                      
   tbl_FileDetails  TF  On                       
   TB.n_BoxId = TF.n_BoxId               
         
                          
           End                      
    Drop table #TempxmlFileDetails                      
                         
     commit Tran                      
       
 End Try                        
 Begin Catch                        
Rollback Tran                      
 Exec usp_GetErrorInfo                        
 End Catch   
End --End Proc [usp_InsertUpdateMakerFileDetails]   
/*************************************************************************************************/  ' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_getMakerSearchData]    Script Date: 10/14/2015 11:44:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_getMakerSearchData]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
  
      
        
/*************************************************************************************************/          
  -- usp_getMakerSearchData 1,2015000953,0,'''','''',0,'''','''','''','''','''','''','''','''','''',123       
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
    ACM.s_AppCodeName  ''File Status'', 
    acm2.s_AppCodeName ''Approve Status'',                     
    BD.s_BoxBarCode ''Box Barcode'',                      
    BD.s_LocationCode  ''Box Location'',                      
    --LM.s_LocationCode ''Location'',      
    --fd.n_FileId ''FileId'',       
    FD.s_FileBarCode ''File BarCode'',                    
    FD.s_FileName ''File Description1'',                      
    FD.s_FileDescription1 ''File Description2'',        
    FD.s_Label1 ''File Type'',FD.s_Label2 ''From No'',FD.s_Label3 ''To No''                      
    ,CONVERT(Varchar(10), Convert(Date,d_DestructionDueDate,103),103) ''Destruction Due Date''  ,                  
    FD.s_Year ''Year'' ,CONVERT(Varchar(10), Convert(Date,d_FromDate,103),103) ''FromDate''   ,                  
    CONVERT(Varchar(10), Convert(Date,d_EndDate ,103),103) ''ToDate''            
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
/****** Object:  StoredProcedure [dbo].[usp_InsertUpdateFileDetails]    Script Date: 10/14/2015 11:44:59 ******/
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
''<NewDataSet><Root><SrNo>1</SrNo><FileId>0</FileId><BoxBarCode>GA16b1</BoxBarCode><FileBarCode>GAAb1f80</FileBarCode><sFileName/><DepartmentId>3</DepartmentId><sYear>2015</sYear><FromDate>2015-07-09T00:00:00</FromDate><EndDate>2015-07-11T00:00:00</EndDate><Label1/><Label2/><Label3/></Root></NewDataSet>''
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

		Insert Into tbl_FileDetails ( 
		n_BoxId, s_FileBarCode, s_FileName, n_BranchId, n_DepartmentId, s_Year, 
		d_FromDate,  d_EndDate ,  
		s_Label1, s_Label2, s_Label3, n_Status, d_ModifiedDate, n_ModifiedBy,
		s_FileRemarks,	s_FileDescription1,
		d_DestructionDueDate, s_ImageExtention,    
		s_IMEINo, s_MobileNo--, n_ApproveStatus 
		)            
		Select      TB.n_BoxId, FileBarCode, sFileName, @BranchId, DepartmentId, sYear, 
		Case When FromDate  =  '''' Then null else Convert(Date,FromDate,103)  End ,   
		Case When EndDate   =  '''' Then null else Convert(Date,EndDate,103)   End ,   
		Label1, Label2, Label3, @FileStatus, GETDATE(), @pn_ModifiedBy,
		FileRemarks, FileDescription1, 
		Case When DestructionDueDate   =  '''' Then null else Convert(Date,DestructionDueDate,103)  End , @ImageExtenstion, 
		@IMEINo, @MobileNo--, @ApproveStatus   
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
/****** Object:  StoredProcedure [dbo].[usp_InsertClientData]    Script Date: 10/14/2015 11:44:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_InsertClientData]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/*  
EXEC [dbo].[usp_InsertClientData] 2015000488  
*/  
CREATE Procedure [dbo].[usp_InsertClientData]  
(  
@n_WorkOrderNo int   
)  
As        
Begin        
 Declare   
  @n_WareHouseId  TinyInt,        
  @n_BOXFILE_STATUS  SmallInt ,        
  @n_ModifiedBy   SmallInt ,        
  @n_WORKORDER_STATUS  SmallInt ,        
  @ACTIVITY_STATUS   SmallInt;        
            
Select @n_WareHouseId =  n_WareHouseId From tbl_WareHouseMaster Where s_WarehouseName like ''Bhiwandi%''        
 If(Isnull(@n_WareHouseId,0)=0)        
  Begin        
  Select ''WareHouse''        
  Return;        
  End       
 --Print @n_WareHouseId;    
          
Select @n_BOXFILE_STATUS  = n_AppCodeId From tbl_ApplicationCodeMaster Where s_AppCode = ''BOXFILE_STATUS'' And s_AppCodeName = ''In''        
Select @n_WORKORDER_STATUS  = n_AppCodeId From tbl_ApplicationCodeMaster Where s_AppCode = ''WORKORDER_STATUS'' And s_AppCodeName = ''Open''        
Select @ACTIVITY_STATUS  = n_AppCodeId  From  tbl_ApplicationCodeMaster Where s_AppCode = ''ACTIVITY_STATUS'' And s_AppCodeName = ''Open''       
  
                
   Set @n_ModifiedBy = (Select top 1        
        n_UserId         
      From tbl_UserMaster )        
        
      --print @n_ModifiedBy  
      --update deptpartmentid in tempdata
      Update TempData Set DeptId  = TB.n_AppCodeId  From TempData TA Inner Join tbl_ApplicationCodeMaster  TB On Rtrim(ltrim(TA.DEPT)) = Rtrim(ltrim(TB.s_AppCodeName))
      Where s_AppCode = ''DEPARTMENT'' And   TA.DEPT Is not  Null 
        
 /*Genrate  Work Order */        
  Create Table #CustomerList(Id Int Identity(1,1),n_CustomerId Int ,n_PickupAddressId Int)        
  Insert Into #CustomerList( n_CustomerId  ,n_PickupAddressId )        
  Select  Distinct TC.n_CustomerId,        
       TP.n_PickupAddressId         
  From  tbl_Customer TC        
     Inner  Join        
        TempData  T  On  Rtrim(Ltrim(TC.s_CustomerName)) =  Rtrim(Ltrim(T.[CLIENTNAME]))        
     Left Join         
 (Select        
        MIN(n_PickupAddressId ) As n_PickupAddressId,        
        n_CustomerId        
  From tbl_PickupAddress Group by n_CustomerId  )  As TP  On TC.n_CustomerId = TP.n_CustomerId         
Declare @CustCount   Int        
Declare @n_CustomerId Int        
Declare @n_PickupAddressId Int    
--Select * From #CustomerList      
  
 -------------------------------------Insert Work Order With Activity Completed--------------------------------------        
         
 --================================================Add Box Details==================================================        
Set  @CustCount = 1                  
While(@CustCount < = (Select Isnull(COUNT(*),0) From #CustomerList ))                  
Begin        
      
 Select @n_CustomerId = n_CustomerId  From #CustomerList Where Id = @CustCount        
 Select @n_PickupAddressId = n_PickupAddressId  From #CustomerList Where Id = @CustCount        
       
 Create Table #TempBOXD (BoxId Int  ,BoxBarCode Varchar(25),BoxLocId Int, BoxLocCode  Varchar(25))        
 Insert Into #TempBOXD ( BoxId,     BoxBarCode ,BoxLocId ,BoxLocCode)        
 Select Distinct   
  0,         
  T.[BOX BARCODE] ,        
  1,        
  T.LOCATION         
 From     
  tbl_Customer TC         
  Inner  Join TempData  T  On  Rtrim(Ltrim(TC.s_CustomerName)) =  Rtrim(Ltrim(T.[CLIENTNAME]))        
 Where   
  TC.n_CustomerId = @n_CustomerId         
    
 Select T.*,''BoxDetails'' From #TempBOXD T        
  
 DECLARE @xmldata XML        
 Declare @n_WoActivityId Int         
 SET @xmldata = (Select 1 As SrNo, 1 As BoxId,  BoxBarCode,BoxLocId,BoxLocCode From        
 #TempBOXD Where BoxBarCode Is not Null  FOR XML PATH (''Root''))        
 Select @xmldata        
 Declare @BoxXml Varchar(Max)        
 Set @BoxXml = ''<NewDataSet>''+CONVERT(Varchar(Max),@xmldata) +''</NewDataSet>''            
 Select @BoxXml        
 Select  top 1 @n_WoActivityId = n_WoActivityId  From tbl_WoActivities   Inner Join tbl_Activity TA On tbl_WoActivities.n_ActivityId = TA.n_ActivityId        
 Where   
  n_WorkOrderNo In(@n_WorkOrderNo)        
  And n_ActivityStatus = @ACTIVITY_STATUS    
  and TA.s_ActivityName = ''New Standard Box Cost (1.50 Cubic Ft.)''  
 Order by n_WoActivityId desc        
   
 If(Isnull(@n_WoActivityId,0) !=0)        
 Begin        
  Exec usp_InsertUpdateBoxDetails   @n_CustomerId,@n_WareHouseId,@BoxXml,@n_WoActivityId,@n_ModifiedBy,0        
 End        
     
 Create Table #TempFileDetails ( SrNo Int Identity(1,1),FileId Int  ,BoxBarCode Varchar(50),FileBarCode Varchar(50),        
  sFileName  Varchar(255),DepartmentId Int ,sYear Varchar(30), FromDate DateTime ,EndDate DateTime,        
  Label1 Varchar(500)   ,  Label2 Varchar(500),Label3 Varchar(500))        
  
  
 /* Prepare Data For Inserting in FileDetails*/  
 Insert Into #TempFileDetails(FileId,BoxBarCode,FileBarCode,sFileName,DepartmentId,sYear,FromDate,EndDate,Label1,Label2,Label3)                  
 Select Distinct   
  0,        
  T.[BOX BARCODE] ,        
  T.[FILE BARCODE] ,        
  '''' ,        
  Isnull(T.DeptId ,(Select Top 1 n_AppCodeId From tbl_ApplicationCodeMaster Where s_AppCode=''DEPARTMENT'' )),         
  T.[YEAR] ,         
  T.[FROM DATE],        
  T.[TO DATE],        
  '''',        
  '''',        
  ''''        
 From     
  TempData As T        
  Left  Join tbl_ApplicationCodeMaster TAD   On Rtrim(Ltrim(T.DEPT)) = Rtrim(Ltrim(TAD.s_AppCodeName))          
  Inner  Join tbl_Customer TC    On  Rtrim(Ltrim(TC.s_CustomerName)) =  Rtrim(Ltrim(T.[CLIENTNAME]))        
 Where   
  TC.n_CustomerId = @n_CustomerId        
  ANd T.[BOX BARCODE] Is not null              
  And  T.[FILE BARCODE] Is not null         
  
      
  
 /* Convert Above Data to Xml and insert to FileDetails */  
 DECLARE @xmldataFile XML        
 SET @xmldataFile = (Select SrNo,FileId,BoxBarCode,FileBarCode,sFileName,DepartmentId,sYear,FromDate,EndDate,Label1,Label2,Label3        
 From #TempFileDetails Where BOXBARCODE Is not Null And FileBarCode Is Not Null  FOR XML PATH (''Root''))        
  
 Declare @FileXml Varchar(Max)        
 Set @FileXml = ''<NewDataSet>''+CONVERT(Varchar(Max),@xmldataFile) +''</NewDataSet>''   
 Select    
  top 1 @n_WoActivityId = n_WoActivityId  From tbl_WoActivities    Inner Join tbl_Activity TA On tbl_WoActivities.n_ActivityId = TA.n_ActivityId       
 Where   
  n_WorkOrderNo In(@n_WorkOrderNo)        
  And n_ActivityStatus = @ACTIVITY_STATUS    
  and TA.s_ActivityName = ''Bar-coding & Data Entry (File & Box)''         
 exec usp_InsertUpdateFileDetails  @n_CustomerId,@n_WareHouseId,@FileXml,@n_WoActivityId,@n_ModifiedBy,0, null, null , null , 1        
 Drop Table #TempFileDetails        
 Drop Table #TempBOXD   
 select ''this is file xml''   
 Select @FileXml       
 select @n_CustomerId,@n_WareHouseId,@FileXml,@n_WoActivityId,@n_ModifiedBy,0        
 Set @CustCount = @CustCount+ 1                  
End        
  
/* UPDATE FileDetails to make file status ''Pending''*/  
Update    
 tbl_FileDetails   
Set   
 s_FileName = T.[FILE NAME 1],  
 s_Label1   = T.[LABLE 1 ( FILE TYPE )],        
 n_ApproveStatus = (select n_AppCodeId from tbl_applicationcodemaster where s_appcode = ''BOXFILE_STATUS'' and s_appcodename = ''Pending'' )   
From    
 tbl_FileDetails TF         
 Inner Join TempData T On TF.s_FileBarCode = T.[FILE BARCODE]   
                                 
End        
  ' 
END
GO
