

/****** Object:  StoredProcedure [dbo].[usp_InsertUpdateCustomer]    Script Date: 09/29/2016 11:07:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_InsertUpdateCustomer]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE Procedure [dbo].[usp_InsertUpdateCustomer]  
(  
 @pn_CustomerId    Int          ,  
 @ps_CustomerName   Varchar(100) ,  
 @pn_CompanyGroupId   Smallint     ,  
 @ps_BillingAddress   Varchar(200) ,  
 @pn_StateId     Smallint     ,  
 @pn_CityId     Smallint     ,  
 @ps_PinCode              Varchar(8)   ,  
 @pn_UserId     Smallint     ,  
 @ps_BillingAddress1         Varchar(50)  ,  
 @ps_BillingAddress2         Varchar(50)  ,  
 @pn_BillingMode		smallint,
 @pn_MaxCustId               Int output    
)  
As    
Begin    
 SET NOCOUNT ON    
 Declare @MaxCustId Int  
 Begin Try  
  If(@pn_CustomerId = 0)  
  Begin  
   If Exists (Select 1 From tbl_Customer Where s_CustomerName = @ps_CustomerName)  
    Begin  
     Set @pn_MaxCustId =     -1  
    End  
   Else  
    Begin  
     Insert Into tbl_Customer  
         (s_CustomerName,   n_CompanyGroupId,  s_BillingAddress,  n_StateId,  
       n_CityId,    d_ModifiedDate,   n_UserId       ,        s_PinCode,  
       s_BillingAddress1  ,    s_BillingAddress2,n_BillingMode)  
     Values  
         (@ps_CustomerName  ,  @pn_CompanyGroupId ,  @ps_BillingAddress,  @pn_StateId,  
       @pn_CityId        ,  GETDATE()          ,  @pn_UserId        ,     @ps_PinCode,  
       @ps_BillingAddress1      ,     @ps_BillingAddress2,@pn_BillingMode)  
       Set @pn_MaxCustId=      @@IDENTITY           
    End  
  End  
  Else  
  Begin  
   If Exists ( Select 1 From tbl_Customer   
      Where s_CustomerName = @ps_CustomerName and n_CustomerId !=  @pn_CustomerId)  
    Begin  
     Set @pn_MaxCustId =     -1  
    End  
   Else  
   Begin  
    Update  tbl_Customer  
     Set s_CustomerName  = @ps_CustomerName  ,  
      n_CompanyGroupId = @pn_CompanyGroupId,  
      --s_BillingAddress = @ps_BillingAddress,  
      n_StateId   = @pn_StateId,  
      n_CityId   = @pn_CityId ,  
      d_ModifiedDate  = GETDATE()  ,  
      n_UserId   = @pn_UserId ,  
      s_PinCode           =   @ps_PinCode,  
      s_BillingAddress1   =   @ps_BillingAddress1,  
      s_BillingAddress2   =   @ps_BillingAddress2,
      n_BillingMode = @pn_BillingMode 
    Where n_CustomerId     = @pn_CustomerId  
      
    Select @pn_MaxCustId = @pn_CustomerId   
   End  
  End  
   
 End Try    
 Begin Catch    
 Exec usp_GetErrorInfo    
 End Catch                                     
End' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetCustomerbyWareHouseId]    Script Date: 09/29/2016 11:07:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_GetCustomerbyWareHouseId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'      
CREATE Procedure [dbo].[usp_GetCustomerbyWareHouseId]      
(@n_WareHouseId int)          
As        
Begin       
       
SET NOCOUNT ON        
SELECT       
Distinct C.n_CustomerId        As ''CustomerId''    ,   C.s_CustomerName                                As  ''CustomerName''   ,      
CG.s_CGName     As  ''CompanyGroupName'' ,   C.s_BillingAddress1 + '' '' + C.s_BillingAddress2      AS  ''BillingAddress'' ,      
SM.n_StateId     As  ''StateId''          ,   CM.n_CityId                                        As  ''CityId''         ,      
SM.s_StateName     As  ''StateName''        ,   CM.s_CityName                                     As  ''CityName''    ,      
C.s_PinCode        As ''PinCode''          ,   CG.n_CompanyGroupId                               As  ''CompanyGroupId'' ,      
s_BillingAddress1           As  ''BillingAddress1''  ,   s_BillingAddress2                                     As  ''BillingAddress2''                       
FROM tbl_Customer  C       
Inner Join tbl_CompanyGroup CG   On  C.n_CompanyGroupId = CG.n_CompanyGroupId      
Inner Join tbl_StateMaster  SM   On  C.n_StateId = SM.n_StateId       
Inner Join tbl_CityMaster   CM    On C.n_CityId  = CM.n_CityId       
--Where  C.n_CustomerId =   Case @pn_CustomerId  When  0 Then C.n_CustomerId  Else   @pn_CustomerId End    
Inner Join tbl_WorkOrder TWO On TWO.n_CustomerId = C.n_CustomerId    
Inner Join tbl_WareHouseMaster TWH On TWH.n_WareHouseId = TWO.n_WareHouseId    
Where (TWH.n_WareHouseId = @n_WareHouseId)   
End ' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetCompanyNameByWareHouseId]    Script Date: 09/29/2016 11:07:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_GetCompanyNameByWareHouseId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'          
CREATE Procedure [dbo].[usp_GetCompanyNameByWareHouseId]          
(@n_WareHouseId int)              
As            
Begin           
           
SET NOCOUNT ON            
SELECT           
Distinct CG.s_CGName As  ''CompanyGroupName'' ,CG.n_CompanyGroupId  
FROM tbl_Customer  C           
Inner Join tbl_CompanyGroup CG   On  C.n_CompanyGroupId = CG.n_CompanyGroupId          
Inner Join tbl_StateMaster  SM   On  C.n_StateId = SM.n_StateId           
Inner Join tbl_CityMaster   CM    On C.n_CityId  = CM.n_CityId           
--Where  C.n_CustomerId =   Case @pn_CustomerId  When  0 Then C.n_CustomerId  Else   @pn_CustomerId End        
Inner Join tbl_WorkOrder TWO On TWO.n_CustomerId = C.n_CustomerId        
Inner Join tbl_WareHouseMaster TWH On TWH.n_WareHouseId = TWO.n_WareHouseId        
Where (TWH.n_WareHouseId = @n_WareHouseId) 
ORDER  by CG.s_CGName ASC    
End ' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetInvoiceList]    Script Date: 09/29/2016 11:07:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_GetInvoiceList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[usp_GetInvoiceList] 
	(
	@pn_Month    Int,                          
	@pn_Year    Int,              
	@pn_ToMonth Int,              
	@pn_ToYear Int,                          
	@pn_CustomerId   Int,                   
	@pn_CustGroupId int        
	)
AS
BEGIN
	Declare @MonthYear As Int;       
	If (LEN(@pn_Month) <= 1)                          
  Begin                          
   Set @MonthYear = Convert (Int, Convert (Varchar (4), @pn_Year) + ''0'' + Convert (Varchar (2), @pn_Month));                          
  End                          
  Else                          
     Begin                          
    Set @MonthYear = Convert (Int, Convert (Varchar (4), @pn_Year) + Convert (Varchar (2), @pn_Month));                          
   End               
   Declare @ToMonthYear As Int;               
   If (LEN(@pn_ToMonth) <= 1)                          
  Begin                          
   Set @ToMonthYear = Convert (Int, Convert (Varchar (4), @pn_ToYear) + ''0'' + Convert (Varchar (2), @pn_ToMonth));                          
  End                          
  Else                          
     Begin                          
    Set @ToMonthYear = Convert (Int, Convert (Varchar (4), @pn_ToYear) + Convert (Varchar (2), @pn_ToMonth));                          
   End 
   
--select GetInvoiceList---
 Select TI.n_InvoiceNo As ''InvoiceNo'',TI.n_CustomerId As ''CustomerId'',TI.n_InvoiceAmount As ''InvoiceAmount'',
      TI.n_TotalAmount   As ''TotalAmount'',TI.d_ModifiedDate As ''InvoiceDate'', TC.s_CustomerName  As ''CustomerName'',
      TA.n_AccountId As ''AccountId''      
 From tbl_InvoiceSummary TI                          
 inner Join tbl_Customer  TC On TI.n_CustomerId = TC.n_CustomerId                           
 inner join tbl_CompanyGroup CG on TC.n_CompanyGroupId = CG.n_CompanyGroupId    
 left join  tbl_Accounts TA on TA.n_InvoiceNo = TI.n_InvoiceNo                  
 Where             
 (TI.n_CustomerId = @pn_CustomerId or @pn_CustomerId = 0)             
 AND (CG.n_CompanyGroupId = @pn_CustGroupId or @pn_CustGroupId = 0)            
 And TI.n_MonthYear between @MonthYear and @ToMonthYear  
 ----------------------------------------------
 
                      
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetInvoiceList_New]    Script Date: 09/29/2016 11:07:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_GetInvoiceList_New]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'              
--[dbo].[usp_GetInvoice_New] 1,2016,1,2016,200,37               
CREATE Procedure [dbo].[usp_GetInvoiceList_New]                            
(@pn_Month    Int,                            
@pn_Year    Int,                
@pn_ToMonth Int,                
@pn_ToYear Int,                            
@pn_CustomerId   Int,                     
@pn_CustGroupId int                    
)                            
As                            
Begin--Begin Proc [usp_GetInvoice]                   
    /*PROCEDURE CONSTANTS*/            
    declare @Status_File_In int = (select n_AppCodeId from tbl_ApplicationCodeMaster where s_AppCode = ''BOXFILE_STATUS'' and s_AppCodeName = ''In'')            
    declare @Status_WorkOrder_Closed int = (select n_AppCodeId from tbl_ApplicationCodeMaster where s_AppCode = ''WORKORDER_STATUS'' and s_AppCodeName = ''Closed'')            
    /*PROCEDURE CONSTANTS*/                      
    Declare @MonthYear As Int;                             
    If (LEN(@pn_Month) <= 1)                            
    Begin                            
        Set @MonthYear = Convert (Int, Convert (Varchar (4), @pn_Year) + ''0'' + Convert (Varchar (2), @pn_Month));                            
    End                            
    Else                            
    Begin                            
 Set @MonthYear = Convert (Int, Convert (Varchar (4), @pn_Year) + Convert (Varchar (2), @pn_Month));                            
    End               
                    
    Declare @ToMonthYear As Int;                 
    If (LEN(@pn_ToMonth) <= 1)                            
    Begin                            
 Set @ToMonthYear = Convert (Int, Convert (Varchar (4), @pn_ToYear) + ''0'' + Convert (Varchar (2), @pn_ToMonth));                            
    End                            
    Else                            
    Begin                            
 Set @ToMonthYear = Convert (Int, Convert (Varchar (4), @pn_ToYear) + Convert (Varchar (2), @pn_ToMonth));                            
    End                               
    Declare @RMCExistBoxCount Int                            
    Declare @RMCNewBoxCount Int                            
    Declare @RMCBoxCountAfter15 Int                            
    Declare @RMCEXISTBOXCOUNTCHARGES Decimal(10,2)=0.0                            
    Declare @RMCNEWBOXCOUNTCHARGES Decimal(10,2)=0.0                            
    Declare @RMCNEWBOXCOUNTCHARGESAFTER15 Decimal(10,2)=0.0                            
    Declare @s_ActivityName As Varchar (100);                            
    Declare @s_ActivityName1 As Varchar (100);                            
    Declare @FromDate As Datetime;                            
    Declare @ToDate As Datetime;                            
                  
    Select @ToDate = Convert (Datetime, Substring(Convert (Varchar, @MonthYear), 1, 4) + ''-'' + Substring(Convert (Varchar, @MonthYear), 5, 6) + ''-'' + ''15'' + '' 23:59:59''),                            
    @FromDate   = Convert (Datetime, Substring(Convert (Varchar, @MonthYear), 1, 4) + ''-'' + Substring(Convert (Varchar, @MonthYear), 5, 6) + ''-'' + ''1'' + '' 00:00:00'');                              
    Set @RMCExistBoxCount = 0;                            
    Set @RMCNewBoxCount = 0;                            
    Set @RMCBoxCountAfter15 = 0;                     
              
    --set @FromDate = @FromDate + '' 00:00:00''                  
              
    print @FromDate                  
    print @ToDate                        
                      
 Select @RMCExistBoxCount = Isnull(COUNT(*), 0)                                        
 From   tbl_BoxDetails  TBD             
 join tbl_BoxTransactions TBT on TBD.n_BoxId = TBT.n_BoxId             
 join tbl_WoActivities TWA on TWA.n_WoActivityId = TBT.n_WoActivityId             
 join tbl_WorkOrder TWO on TWA.n_WorkOrderNo = TWO.n_WorkorderNo             
 Where  TBD.n_CustomerId = @pn_CustomerId                                        
    And TBD.n_Status = @Status_File_In                                        
    And Convert(Date,TBD.d_ModifiedDate)  <=Convert(Date,@FromDate)            
    And TWO.n_Status = @Status_WorkOrder_Closed                                      
    And TBD.n_BoxId Not In (Select n_BoxId                     
    From   tbl_BoxDetails                                      
    Where  ( Convert(Date,TBD.d_ModifiedDate) >= Convert(Date,@FromDate)And Convert(Date,TBD.d_ModifiedDate) <= Convert(Date,@ToDate) ));                            
              
    -- Temporary arrangement as per request from Sejjal Madam, Parag Sutar, Rohit Gupta                   
    print @RMCExistBoxCount;                  
    if (@pn_Month = 9 and @pn_Year = 2015 and @pn_CustomerId = 10 )                  
    Begin                  
 set @RMCExistBoxCount = @RMCExistBoxCount + 3416                   
    print @RMCExistBoxCount;                  
    end                  
              
    -- Temporary --                  
                        
                   
                        
    Set @s_ActivityName = Case                            
    When @RMCExistBoxCount > 0                            
    And                             
    @RMCExistBoxCount <= 250 Then ''1 to 250 Standard Box (1.50 Cubic Ft)''                             
    When @RMCExistBoxCount > 250                            
    And                             
    @RMCExistBoxCount <= 1000 Then ''250 to 1000 Standard Box (1.50 Cubic Ft)''                    
    When @RMCExistBoxCount > 1000                            
    And                            
    @RMCExistBoxCount <= 2500 Then ''1001 to 2500 Standard Box (1.50 Cubic Ft)''                             
    When @RMCExistBoxCount > 2500 Then ''2501 & Above Standard Box (1.50 Cubic Ft)''                             
    Else ''''                             
    End;                            
                     
    Select @RMCEXISTBOXCOUNTCHARGES = Isnull(TR.n_Rate, 0)                             
    From   tbl_Activity As A                            
    Inner Join                            
    tbl_RateCard As TR                            
    On A.n_ActivityId = TR.n_ActivityId                            
    Where  A.n_ServiceCategoryId In (Select n_ServiceCategoryId                            
    From   tbl_ServiceCategory                            
    Where  s_SCName = ''Record Management Charges'')                            
    And A.s_ActivityName = @s_ActivityName                            
    And TR.n_CustomerId = @pn_CustomerId;                                         
                
                
    Select @RMCNewBoxCount = Isnull(COUNT(*), 0)                            
    From               
 tbl_BoxDetails  TBD             
 join tbl_BoxTransactions TBT on TBD.n_BoxId = TBT.n_BoxId             
 join tbl_WoActivities TWA on TWA.n_WoActivityId = TBT.n_WoActivityId             
 join tbl_WorkOrder TWO on TWA.n_WorkOrderNo = TWO.n_WorkorderNo                                 
    Where              
 TBD.n_CustomerId = @pn_CustomerId                            
 And TBD.n_Status = @Status_File_In             
 And TWO.n_Status = @Status_WorkOrder_Closed                  
 And (TBD.d_ModifiedDate>= @FromDate And TBD.d_ModifiedDate<= @ToDate  )                          
            
    Set @s_ActivityName1 = Case                            
    When @RMCNewBoxCount > 0                            
    And                             
    @RMCNewBoxCount <= 250 Then ''1 to 250 Standard Box (1.50 Cubic Ft)''                             
    When @RMCNewBoxCount > 250                            
    And                             
    @RMCNewBoxCount <= 1000 Then ''250 to 1000 Standard Box (1.50 Cubic Ft)''                             
    When @RMCNewBoxCount > 1000                            
    And                            
    @RMCNewBoxCount <= 2500 Then ''1001 to 2500 Standard Box (1.50 Cubic Ft)''                             
    When @RMCNewBoxCount > 2500 Then ''2501 & Above Standard Box (1.50 Cubic Ft)''                             
    Else ''''                             
    End;                            
    Select @RMCNEWBOXCOUNTCHARGES = Isnull(TR.n_Rate, 0)                             
    From   tbl_Activity As A               
    Inner Join                            
    tbl_RateCard As TR                            
    On A.n_ActivityId = TR.n_ActivityId                            
    Where  A.n_ServiceCategoryId In (Select n_ServiceCategoryId                            
    From   tbl_ServiceCategory                            
    Where  s_SCName = ''Record Management Charges'')                            
    And A.s_ActivityName = @s_ActivityName1                            
    And TR.n_CustomerId = @pn_CustomerId;                            
                    
    Select @RMCBoxCountAfter15 = Isnull(COUNT(*), 0)                            
    From   tbl_BoxDetails                            
    Where  n_CustomerId = @pn_CustomerId                            
    And                             
    n_Status Not In (Select n_AppCodeId                            
    From   tbl_ApplicationCodeMaster                            
    Where  s_AppCode = ''BOXFILE_STATUS''                            
    And                             
    s_AppCodeName = ''Permanent Out'')And                             
    d_ModifiedDate>=@ToDate        
    and d_ModifiedDate < DATEADD(M , 1 ,@FromDate)                             
                            
    Create Table #TempOrders(n_OrderId TinyInt , n_ServiceCategoryId TinyInt)                            
    Insert Into #TempOrders(n_OrderId, n_ServiceCategoryId)                             
    Select 1     , n_ServiceCategoryId From tbl_ServiceCategory Where s_SCName =''Record Management Charges''                            
    Union                            
    Select 2     , n_ServiceCategoryId From tbl_ServiceCategory Where s_SCName =''File Pick Up''                            
    Union                            
    Select 3     , n_ServiceCategoryId From tbl_ServiceCategory Where s_SCName =''Retrieval''                             
    Union                            
    Select 4     , n_ServiceCategoryId From tbl_ServiceCategory Where s_SCName =''Permanent Return''                              
    Union                            
    Select 5     , n_ServiceCategoryId From tbl_ServiceCategory Where s_SCName =''Other services''                              
    Union                            
    Select 6     , n_ServiceCategoryId From tbl_ServiceCategory Where s_SCName =''Destruction''                              
    Union                            
    Select 7     , n_ServiceCategoryId From tbl_ServiceCategory Where s_SCName =''In-House management''                              
                          
                           
    Create Table #TempSummary(n_ServiceCategoryId TinyInt,s_SCName Varchar(50),Amount Decimal(10,2))                                 
    Insert Into #TempSummary(n_ServiceCategoryId,s_SCName,Amount )                             
    Select  TC.n_ServiceCategoryId,  TC.s_SCName ''Service '',                            
    Sum( (TID.n_Amount) *(TID.n_ActivityCount)) [Total Amount]                             
    From  tbl_InvoiceSummary_New TI Inner Join                             
    tbl_InvoiceDetails_New TID   ON TI.n_InvoiceNo = TID.n_InvoiceNo                              
    Inner Join                            
    tbl_WoActivities TW On TID.n_WoActivityId = TW.n_WoActivityId                             
    Inner Join                             
    tbl_Activity     TA On TW.n_ActivityId = TA.n_ActivityId                                
    Inner Join                            
    tbl_ServiceCategory  TC  ON TA.n_ServiceCategoryId = TC.n_ServiceCategoryId                               
    Where TI.n_CustomerId  = @pn_CustomerId                             
    And                            
    TI.n_MonthYear = @MonthYear                   
    Group by TC.s_SCName,TC.n_ServiceCategoryId                             
    Declare @TotalExistBoxAmount Decimal(10,2)                             
    Set @TotalExistBoxAmount=@RMCExistBoxCount*IsNUll(@RMCEXISTBOXCOUNTCHARGES,0);                               
    Declare @TotalNewBoxAmount Decimal(10,2)                             
    Set @TotalNewBoxAmount=@RMCNewBoxCount*IsNUll(@RMCNEWBOXCOUNTCHARGES,0);                 
                               
    Select TI.n_InvoiceNo As ''InvoiceNo'', TI.n_MonthYear As ''MonthYear'', TI.n_WareHouseId As ''WareHouseId'',              
    TI.n_CustomerId As ''CustomerId'', TI.n_PickupAddressId As ''PickupAddressId'', TI.n_StorageCharges as ''StorageCharges'',              
    TI.n_TransAmount As ''TransAmount'' ,TI.n_InvoiceAmount As ''InvoiceAmount'', TI.n_HigherEducation  As ''HigherEducation'',              
    TI.n_ServiceTax As ''ServiceTax'', TI.n_EduTax As ''EduTax'', TI.n_OtherTax As ''OtherTax'', TI.n_TotalAmount   As ''TotalAmount'',               
    TI.d_ModifiedDate As ''InvoiceDate'', TC.s_CustomerName  As ''CustomerName'', TC.s_BillingAddress As ''BillingAddress'',              
    TC.s_BillingAddress1 As ''BillingAddress1'', TC.s_BillingAddress2 As ''BillingAddress2'', ST.s_StateName As ''StateName'',              
    CM.s_CityName As ''CityName'', TC.s_PinCode As ''PinCode'', @RMCExistBoxCount As ''ExistingBox'',              
    @RMCNewBoxCount As ''NBoxCountBefore15'', @RMCBoxCountAfter15 As ''NBoxAF15'',                            
    case when @RMCEXISTBOXCOUNTCHARGES = 0 then @RMCNEWBOXCOUNTCHARGES else @RMCEXISTBOXCOUNTCHARGES end   As ''RecordMangementCharges'',                          
    @RMCNEWBOXCOUNTCHARGES As ''RMCNewRate'', @RMCExistBoxCount+@RMCNewBoxCount + @RMCBoxCountAfter15 As ''RecordMangementTotalBoxes'',               
    @TotalExistBoxAmount As ''TotalExistBoxAmount'', @TotalNewBoxAmount As ''TotalNewBoxAmount'' ,           
    case when TC.n_BillingMode IS null then 1 else TC.n_BillingMode end As ''BillingMode'' , TA.n_AccountId As ''AccountId''                            
    From tbl_InvoiceSummary_New TI                            
    Inner Join tbl_Customer  TC On TI.n_CustomerId = TC.n_CustomerId                             
    inner join tbl_CompanyGroup CG on TC.n_CompanyGroupId = CG.n_CompanyGroupId   
    left join  tbl_Accounts TA on TA.n_InvoiceNo = TI.n_InvoiceNo              
    Left Join tbl_StateMaster ST On ST.n_StateId = TC.n_StateId                             
    Left Join tbl_CityMaster CM  On  TC.n_CityId = CM.n_CityId               
    Where               
    (TI.n_CustomerId = @pn_CustomerId or @pn_CustomerId = 0)               
    AND (CG.n_CompanyGroupId = @pn_CustGroupId or @pn_CustGroupId = 0)              
    And TI.n_MonthYear between @MonthYear and @ToMonthYear                            
                      
    Select  TS.n_ServiceCategoryId,TS.s_SCName,                            
    TS.Amount                            
    From  #TempSummary TS                             
    Left Join                            
    #TempOrders TOS On TS.n_ServiceCategoryId = TOS.n_ServiceCategoryId                               
    Order By TOS.n_OrderId asc                                
                        
    Select TID.n_InvoiceDetailId     As ''InvoiceDetailId''  , TID.n_InvoiceNo   As ''InvoiceNo'',                            
    TWO.n_WorkOrderNo      As ''WorkOrderNo''    , Case When CHARINDEX(''('',TA.s_ActivityName)>0                             
    Then Replace(SUBSTRING(TA.s_ActivityName,0,CHARINDEX (''('',TA.s_ActivityName)),''['','''')                            
    Else TA.s_ActivityName End   As ''ActivityName'',                             
    TID.n_WoActivityId         As ''WoActivityId''     , TID.n_ActivityCount  As ''ActivityCount'',                            
    TID.n_Amount           As ''Amount''     , Isnull(TID.n_Amount,0)* ISNULL(TID.n_ActivityCount,0) As TotalAmount,                            
    TWO.d_ModificationDate       As ''ActivityDate''   ,                            
    Case TA.n_Unit      When 1  Then   ''Per Box ''                             
   When 2  Then   ''Per File''                            
    When 3  Then   ''Per Trip''                            
    When 4  Then   ''Per Unit''                             
    Else '' '' End As Unit ,                            
    TA.n_ActivityId          As ''ActivityId''         , TA.n_ServiceCategoryId As ''ServiceCategoryId'',                            
    TC.s_SCName                                    
    Into #TempResult From tbl_InvoiceDetails_New  TID                           
    Inner Join                            
    tbl_WoActivities      TWO  On TID.n_WoActivityId      = TWO.n_WoActivityId                             
    Inner Join                              
    tbl_Activity   TA   On TWO.n_ActivityId        = TA.n_ActivityId                             
    Inner Join                              
    tbl_ServiceCategory TC   On TC.n_ServiceCategoryId  = TA.n_ServiceCategoryId                             
    Where TID.n_InvoiceNo In                    
    (Select n_InvoiceNo  From  tbl_InvoiceSummary_New TI Where TI.n_CustomerId = @pn_CustomerId                             
    And                             
    TI.n_MonthYear = @MonthYear  )                             
                  
    If OBJECT_ID(''tempdb.#tmpTable1'') IS NOT NULL                                
    Begin                            
 Update #TempResult Set  ActivityCount = TBO.n_ServiceCount,                            
 Amount    = TBO.n_Amount,                            
 TotalAmount   = (TBO.n_ServiceCount)* (TBO.n_Amount)                            
 From tbl_OtherTransactions TBO Inner Join #TempResult T On TBO.n_WoActivityId = T.WoActivityId                                                   
    End                            
                     
    Select TR.* From  #TempResult TR  Left  Join #TempOrders TTO On TR.ServiceCategoryId = TTO.n_ServiceCategoryId     Order by TTO.n_OrderId, WorkOrderNo,WoActivityId                            
                  
    Drop table #TempResult                            
    Drop Table #TempOrders                            
    Drop table #TempSummary           
          
  --select * from ufn_DateNoofboxAmount()      
  --select * from fn_CalculateStorageCharges_Daywise_Details(@pn_CustomerId,@pn_WarehouseId,@pn_Year,@pn_Month)                  
End--End Proc [usp_GetInvoice]' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[fn_Invoice_GetBoxCount_TillCutOffDate_ForOldLogic]    Script Date: 09/29/2016 11:07:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_Invoice_GetBoxCount_TillCutOffDate_ForOldLogic]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
/*
Select dbo.fn_Invoice_GetBoxCount_TillCutOffDate_ForOldLogic(1, 212, ''2015-01-16 00:00:00'')
Select dbo.fn_Invoice_GetBoxCount_TillCutOffDate_ForOldLogic(1, 212, ''2015-02-16 00:00:00'')
*/
CREATE Function [dbo].[fn_Invoice_GetBoxCount_TillCutOffDate_ForOldLogic](
@pn_WareHouseId int, @pn_CustomerId int , @pn_CutOffDate datetime
)
    Returns int
As 
Begin --Begin Func

Declare @Status_WorkOrder_Closed int = (select n_AppCodeId from tbl_applicationcodemaster where s_Appcode = ''WORKORDER_STATUS'' and s_AppCodeName = ''Closed'')        
Declare @Status_WOActivity_Closed int  = (select n_AppCodeId from tbl_applicationcodemaster where s_Appcode = ''ACTIVITY_STATUS'' and s_AppCodeName = ''Closed'')        
Declare @Activity_PU_NEWBOX_COST int = (select n_Activityid from tbl_Activity where s_ActivityName = ''New Standard Box Cost (1.50 Cubic Ft.)'')        
Declare @Activity_PU_BARCODING int = (select n_Activityid from tbl_Activity where s_ActivityName = ''Bar-coding & Data Entry (File & Box)'')        
Declare @Activity_PU_TRANSPORTATION int = (select n_Activityid from tbl_Activity where s_ActivityName = ''Standard Box Transportation '')        
Declare @Activity_RETR_FILE_REG int = (select n_Activityid from tbl_Activity where s_ActivityName = ''File Retrievals  Regular (Within 24 hours)'')        
Declare @Activity_RETR_FILE_EXPRESS int = (select n_Activityid from tbl_Activity where s_ActivityName = ''File Retrievals  Express (Within 12 hours)'')        
Declare @Activity_RETR_BOX_REG int = (select n_Activityid from tbl_Activity where s_ActivityName = ''Box Retrievals   Regular (Within 24 hours)'')        
Declare @Activity_RETR_BOX_EXPRESS int = (select n_Activityid from tbl_Activity where s_ActivityName = ''Box Retrievals   Express (Within 12 hours)'')        
Declare @Activity_REST_FILE_REG int = (select n_Activityid from tbl_Activity where s_ActivityName = ''File Restore Regular (Within 24 hours)'')        
Declare @Activity_REST_FILE_EXPRESS int = (select n_Activityid from tbl_Activity where s_ActivityName = ''File Restore Express (Within 12 hours)'')        
Declare @Activity_REST_BOX_REG int = (select n_Activityid from tbl_Activity where s_ActivityName = ''Box  Restore Regular (Within 24 hours)'')        
Declare @Activity_REST_BOX_EXPRESS int = (select n_Activityid from tbl_Activity where s_ActivityName = ''Box  Restore Express (Within 12 hours)'')        
Declare @Activity_RETR_HAND_DEL_REG int = (select n_Activityid from tbl_Activity where s_ActivityName = ''Retrievals Hand Delivery Charges Regular [(Within 24 hours) Max 4 box files / One Full Box]'')        
Declare @Activity_RETR_HAND_DEL_EXPRESS int = (select n_Activityid from tbl_Activity where s_ActivityName = ''Retrievals Hand Delivery Charges Express [(Within 12 hours) Max 4 box files / One Full Box]'')        

/* STEP 1 : GET NO OF BOXES PICKEDUP UPTO CutOffDate*/
Declare @NoOfBoxes_PU int = 0,@NoOfBoxes_RETR int = 0,@NoOfBoxes_REST int = 0;  
    
Select 
@NoOfBoxes_PU = COUNT(TBT.n_BoxId) 
from tbl_WorkOrder TWO 
join tbl_WoActivities TWA on TWO.n_WorkorderNo = TWA.n_WorkOrderNo 
join tbl_BoxTransactions TBT on TWA.n_WoActivityId = TBT.n_WoActivityId 
Where 
TWO.n_Status = @Status_WorkOrder_Closed
And TWA.n_ActivityStatus = @Status_WOActivity_Closed 
And TWA.n_ActivityId in (@Activity_PU_NEWBOX_COST,@Activity_PU_BARCODING,@Activity_PU_TRANSPORTATION)
And TWO.n_CustomerId = @pn_CustomerId 
And  (TWA.d_ModificationDate < @pn_CutOffDate)  

    
Select 
@NoOfBoxes_RETR = COUNT(TBT.n_BoxId) 
from tbl_WorkOrder TWO 
join tbl_WoActivities TWA on TWO.n_WorkorderNo = TWA.n_WorkOrderNo 
join tbl_BoxTransactions TBT on TWA.n_WoActivityId = TBT.n_WoActivityId 
Where 
TWO.n_Status = @Status_WorkOrder_Closed
And TWA.n_ActivityStatus = @Status_WOActivity_Closed 
And TWA.n_ActivityId in (@Activity_RETR_BOX_REG,@Activity_RETR_BOX_EXPRESS)
And TWO.n_CustomerId = @pn_CustomerId 
And TWA.d_ModificationDate < @pn_CutOffDate


Select 
@NoOfBoxes_REST = COUNT(TBT.n_BoxId) 
from tbl_WorkOrder TWO 
join tbl_WoActivities TWA on TWO.n_WorkorderNo = TWA.n_WorkOrderNo 
join tbl_BoxTransactions TBT on TWA.n_WoActivityId = TBT.n_WoActivityId 
Where 
TWO.n_Status = @Status_WorkOrder_Closed
And TWA.n_ActivityStatus = @Status_WOActivity_Closed 
And TWA.n_ActivityId in (@Activity_REST_BOX_REG,@Activity_REST_BOX_EXPRESS )
And TWO.n_CustomerId = @pn_CustomerId 
And TWA.d_ModificationDate < @pn_CutOffDate

Return @NoOfBoxes_PU + @NoOfBoxes_REST - @NoOfBoxes_RETR 
End --End Func' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[fn_Invoice_GetBoxCount_PreviousMonth]    Script Date: 09/29/2016 11:07:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_Invoice_GetBoxCount_PreviousMonth]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'/*
Select dbo.fn_Invoice_GetBoxCount_PreviousMonth(1, 192 , 2015, 12 , ''2015-12-01 00:00:00'')
*/
CREATE Function [dbo].[fn_Invoice_GetBoxCount_PreviousMonth](
@pn_WareHouseId int, @pn_CustomerId int , @pn_Year int, @pn_Month int,  
@pn_StartDate datetime
)
    Returns int
As 
Begin --Begin Func
    Declare @Status_WorkOrder_Closed int = (select n_AppCodeId from tbl_applicationcodemaster where s_Appcode = ''WORKORDER_STATUS'' and s_AppCodeName = ''Closed'')        
Declare @Status_WOActivity_Closed int  = (select n_AppCodeId from tbl_applicationcodemaster where s_Appcode = ''ACTIVITY_STATUS'' and s_AppCodeName = ''Closed'')        
Declare @Activity_PU_NEWBOX_COST int = (select n_Activityid from tbl_Activity where s_ActivityName = ''New Standard Box Cost (1.50 Cubic Ft.)'')        
Declare @Activity_PU_BARCODING int = (select n_Activityid from tbl_Activity where s_ActivityName = ''Bar-coding & Data Entry (File & Box)'')        
Declare @Activity_PU_TRANSPORTATION int = (select n_Activityid from tbl_Activity where s_ActivityName = ''Standard Box Transportation '')        
Declare @Activity_RETR_FILE_REG int = (select n_Activityid from tbl_Activity where s_ActivityName = ''File Retrievals  Regular (Within 24 hours)'')        
Declare @Activity_RETR_FILE_EXPRESS int = (select n_Activityid from tbl_Activity where s_ActivityName = ''File Retrievals  Express (Within 12 hours)'')        
Declare @Activity_RETR_BOX_REG int = (select n_Activityid from tbl_Activity where s_ActivityName = ''Box Retrievals   Regular (Within 24 hours)'')        
Declare @Activity_RETR_BOX_EXPRESS int = (select n_Activityid from tbl_Activity where s_ActivityName = ''Box Retrievals   Express (Within 12 hours)'')        
Declare @Activity_REST_FILE_REG int = (select n_Activityid from tbl_Activity where s_ActivityName = ''File Restore Regular (Within 24 hours)'')        
Declare @Activity_REST_FILE_EXPRESS int = (select n_Activityid from tbl_Activity where s_ActivityName = ''File Restore Express (Within 12 hours)'')        
Declare @Activity_REST_BOX_REG int = (select n_Activityid from tbl_Activity where s_ActivityName = ''Box  Restore Regular (Within 24 hours)'')        
Declare @Activity_REST_BOX_EXPRESS int = (select n_Activityid from tbl_Activity where s_ActivityName = ''Box  Restore Express (Within 12 hours)'')        
Declare @Activity_RETR_HAND_DEL_REG int = (select n_Activityid from tbl_Activity where s_ActivityName = ''Retrievals Hand Delivery Charges Regular [(Within 24 hours) Max 4 box files / One Full Box]'')        
Declare @Activity_RETR_HAND_DEL_EXPRESS int = (select n_Activityid from tbl_Activity where s_ActivityName = ''Retrievals Hand Delivery Charges Express [(Within 12 hours) Max 4 box files / One Full Box]'')        

declare @StartDate datetime = Convert(varchar(4) , @pn_Year) + ''-'' + Convert(varchar(2) , @pn_Month) + ''-'' + ''01'' + '' 00:00:00''           
declare @EndDate datetime = dateadd( d , -1, dateadd(m , 1, @StartDate)   )         


/* STEP 1 : GET NO OF BOXES PICKEDUP UPTO PREVIOUS MONTH */
Declare @NoOfBoxes_PU_PrevMonth int = 0,@NoOfBoxes_RETR_PrevMonth int = 0,@NoOfBoxes_REST_PrevMonth int = 0, @NoOfBoxes_PrevMonth int = 0;  
    
Select 
@NoOfBoxes_PU_PrevMonth = COUNT(TBT.n_BoxId) 
from tbl_WorkOrder TWO 
join tbl_WoActivities TWA on TWO.n_WorkorderNo = TWA.n_WorkOrderNo 
join tbl_BoxTransactions TBT on TWA.n_WoActivityId = TBT.n_WoActivityId 
Where 
TWO.n_Status = @Status_WorkOrder_Closed
And TWA.n_ActivityStatus = @Status_WOActivity_Closed 
And TWA.n_ActivityId in (@Activity_PU_NEWBOX_COST,@Activity_PU_BARCODING,@Activity_PU_TRANSPORTATION)
And TWO.n_CustomerId = @pn_CustomerId 
And  ( TWA.d_ActivityDate is not null  --This is true for Pick Up Work Orders Only 
    And TWA.d_ActivityDate < @StartDate)  
    
    
Select 
@NoOfBoxes_RETR_PrevMonth = COUNT(TBT.n_BoxId) 
from tbl_WorkOrder TWO 
join tbl_WoActivities TWA on TWO.n_WorkorderNo = TWA.n_WorkOrderNo 
join tbl_BoxTransactions TBT on TWA.n_WoActivityId = TBT.n_WoActivityId 
Where 
TWO.n_Status = @Status_WorkOrder_Closed
And TWA.n_ActivityStatus = @Status_WOActivity_Closed 
And TWA.n_ActivityId in (@Activity_RETR_BOX_REG,@Activity_RETR_BOX_EXPRESS)
And TWO.n_CustomerId = @pn_CustomerId 
And TWA.d_ModificationDate < @StartDate 


Select 
@NoOfBoxes_REST_PrevMonth = COUNT(TBT.n_BoxId) 
from tbl_WorkOrder TWO 
join tbl_WoActivities TWA on TWO.n_WorkorderNo = TWA.n_WorkOrderNo 
join tbl_BoxTransactions TBT on TWA.n_WoActivityId = TBT.n_WoActivityId 
Where 
TWO.n_Status = @Status_WorkOrder_Closed
And TWA.n_ActivityStatus = @Status_WOActivity_Closed 
And TWA.n_ActivityId in (@Activity_REST_BOX_REG,@Activity_REST_BOX_EXPRESS )
And TWO.n_CustomerId = @pn_CustomerId 
And TWA.d_ModificationDate < @StartDate 

Return @NoOfBoxes_PU_PrevMonth + @NoOfBoxes_REST_PrevMonth - @NoOfBoxes_RETR_PrevMonth 
End --End Func' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[fn_Invoice_GetBoxCount_DayOfMonth]    Script Date: 09/29/2016 11:07:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_Invoice_GetBoxCount_DayOfMonth]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'/*          
   select  dbo.fn_Invoice_GetBoxCount_DayOfMonth(1, 212, ''2015-07-01'' , ''2015-07-17'' ) 
   select  dbo.fn_Invoice_GetBoxCount_DayOfMonth(1, 212, ''2015-07-01'' , ''2015-07-18'' ) 
   select  dbo.fn_Invoice_GetBoxCount_DayOfMonth(1, 212, ''2015-07-01'' , ''2015-07-19'' ) 
   select  dbo.fn_Invoice_GetBoxCount_DayOfMonth(1, 212, ''2015-07-01'' , ''2015-07-20'' ) 
*/          
CREATE Function [dbo].[fn_Invoice_GetBoxCount_DayOfMonth](          
@pn_WareHouseId int, @pn_CustomerId int ,           
@pn_StartDate datetime, @pn_CurrentDate datetime          
)          
    Returns int          
As           
Begin --Begin Func          
    Declare @Status_WorkOrder_Closed int = (select n_AppCodeId from tbl_applicationcodemaster where s_Appcode = ''WORKORDER_STATUS'' and s_AppCodeName = ''Closed'')                  
    Declare @Status_WOActivity_Closed int  = (select n_AppCodeId from tbl_applicationcodemaster where s_Appcode = ''ACTIVITY_STATUS'' and s_AppCodeName = ''Closed'')                  
    Declare @Activity_PU_NEWBOX_COST int = (select n_Activityid from tbl_Activity where s_ActivityName = ''New Standard Box Cost (1.50 Cubic Ft.)'')                  
    Declare @Activity_PU_BARCODING int = (select n_Activityid from tbl_Activity where s_ActivityName = ''Bar-coding & Data Entry (File & Box)'')                  
    Declare @Activity_PU_TRANSPORTATION int = (select n_Activityid from tbl_Activity where s_ActivityName = ''Standard Box Transportation '')                  
    Declare @Activity_RETR_FILE_REG int = (select n_Activityid from tbl_Activity where s_ActivityName = ''File Retrievals  Regular (Within 24 hours)'')                  
    Declare @Activity_RETR_FILE_EXPRESS int = (select n_Activityid from tbl_Activity where s_ActivityName = ''File Retrievals  Express (Within 12 hours)'')                  
    Declare @Activity_RETR_BOX_REG int = (select n_Activityid from tbl_Activity where s_ActivityName = ''Box Retrievals   Regular (Within 24 hours)'')                  
    Declare @Activity_RETR_BOX_EXPRESS int = (select n_Activityid from tbl_Activity where s_ActivityName = ''Box Retrievals   Express (Within 12 hours)'')                  
    Declare @Activity_REST_FILE_REG int = (select n_Activityid from tbl_Activity where s_ActivityName = ''File Restore Regular (Within 24 hours)'')                  
    Declare @Activity_REST_FILE_EXPRESS int = (select n_Activityid from tbl_Activity where s_ActivityName = ''File Restore Express (Within 12 hours)'')                  
    Declare @Activity_REST_BOX_REG int = (select n_Activityid from tbl_Activity where s_ActivityName = ''Box  Restore Regular (Within 24 hours)'')                  
    Declare @Activity_REST_BOX_EXPRESS int = (select n_Activityid from tbl_Activity where s_ActivityName = ''Box  Restore Express (Within 12 hours)'')                  
    Declare @Activity_RETR_HAND_DEL_REG int = (select n_Activityid from tbl_Activity where s_ActivityName = ''Retrievals Hand Delivery Charges Regular [(Within 24 hours) Max 4 box files / One Full Box]'')                  
    Declare @Activity_RETR_HAND_DEL_EXPRESS int = (select n_Activityid from tbl_Activity where s_ActivityName = ''Retrievals Hand Delivery Charges Express [(Within 12 hours) Max 4 box files / One Full Box]'')                  
          
    --declare @StartDate datetime = Convert(varchar(4) , @pn_Year) + ''-'' + Convert(varchar(2) , @pn_Month) + ''-'' + ''01'' + '' 00:00:00''                     
    --declare @EndDate datetime = dateadd( d , -1, dateadd(m , 1, @StartDate)   )                   
          
          
/* STEP 1 : GET NO OF BOXES PICKEDUP UPTO PREVIOUS MONTH */          
Declare @NoOfBoxes_PU int = 0,@NoOfBoxes_RETR int = 0,@NoOfBoxes_REST int = 0, @NoOfBoxes int = 0;            
              
Select           
@NoOfBoxes_PU = COUNT(TBT.n_BoxId)           
from tbl_WorkOrder TWO           
join tbl_WoActivities TWA on TWO.n_WorkorderNo = TWA.n_WorkOrderNo           
join tbl_BoxTransactions TBT on TWA.n_WoActivityId = TBT.n_WoActivityId           
Where           
TWO.n_Status = @Status_WorkOrder_Closed          
And TWA.n_ActivityStatus = @Status_WOActivity_Closed           
And TWA.n_ActivityId in (@Activity_PU_NEWBOX_COST,@Activity_PU_BARCODING,@Activity_PU_TRANSPORTATION)          
And TWO.n_CustomerId = @pn_CustomerId           
And  ( TWA.d_ActivityDate is not null  --This is true for Pick Up Work Orders Only           
And ((TWA.d_ActivityDate >= @pn_StartDate) And datediff ( D, TWA.d_ActivityDate,@pn_CurrentDate) >=0))    
    --And TWA.d_ActivityDate >= @pn_StartDate And TWA.d_ActivityDate<= @pn_CurrentDate)            
              
/* STEP 2 : GET NO OF BOXES RETRIEVED */              
Select           
@NoOfBoxes_RETR = COUNT(TBT.n_BoxId)           
from tbl_WorkOrder TWO           
join tbl_WoActivities TWA on TWO.n_WorkorderNo = TWA.n_WorkOrderNo           
join tbl_BoxTransactions TBT on TWA.n_WoActivityId = TBT.n_WoActivityId           
Where           
TWO.n_Status = @Status_WorkOrder_Closed          
And TWA.n_ActivityStatus = @Status_WOActivity_Closed           
And TWA.n_ActivityId in (@Activity_RETR_BOX_REG,@Activity_RETR_BOX_EXPRESS)          
And TWO.n_CustomerId = @pn_CustomerId           
And TWA.d_ModificationDate >= @pn_StartDate And datediff ( d , TWA.d_ModificationDate ,@pn_CurrentDate) >= 0          
          
          
/* STEP 3 : GET NO OF BOXES RESTORED */                
Select           
@NoOfBoxes_REST = COUNT(TBT.n_BoxId)           
from tbl_WorkOrder TWO           
join tbl_WoActivities TWA on TWO.n_WorkorderNo = TWA.n_WorkOrderNo           
join tbl_BoxTransactions TBT on TWA.n_WoActivityId = TBT.n_WoActivityId           
Where           
TWO.n_Status = @Status_WorkOrder_Closed          
And TWA.n_ActivityStatus = @Status_WOActivity_Closed           
And TWA.n_ActivityId in (@Activity_REST_BOX_REG,@Activity_REST_BOX_EXPRESS )          
And TWO.n_CustomerId = @pn_CustomerId           
And TWA.d_ModificationDate >= @pn_StartDate And datediff ( d , TWA.d_ModificationDate ,@pn_CurrentDate) >= 0          
--And TWA.d_ModificationDate >= @pn_StartDate And TWA.d_ModificationDate <= @pn_CurrentDate          
          
set @NoOfBoxes = @NoOfBoxes_PU + @NoOfBoxes_REST - @NoOfBoxes_RETR           
          
/*          
Select @NoOfBoxes_PU_PrevMonth          
Select @NoOfBoxes_RETR_PrevMonth          
Select @NoOfBoxes_REST_PrevMonth          
Select @NoOfBoxes_PrevMonth           
*/          
          
    Return @NoOfBoxes           
End --End Func' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[fn_CalculateStorageCharges_Daywise_Details]    Script Date: 09/29/2016 11:07:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_CalculateStorageCharges_Daywise_Details]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'    
--select * from tbl_Customer     
--Declare @pn_WarehouseId int = 1     
--Declare @pn_Year int = 2015    
--Declare @pn_Month int = 12    
--Declare @pn_CustomerId int = 192    
--Declare @pn_CustomerId int = 210     
--Declare @pn_CustomerId int = 163    
/*    
Select * from dbo.fn_CalculateStorageCharges_Daywise_Details( 212, 1 , 2015, 7)     
Select * from dbo.fn_CalculateStorageCharges_Daywise_Details( 210, 1 , 2015, 10)     
Select * from dbo.fn_CalculateStorageCharges_Daywise_Details( 163, 1 , 2015, 12)     
*/    
CREATE Function [dbo].[fn_CalculateStorageCharges_Daywise_Details]    
(     
@pn_CustomerId int,               
@pn_WarehouseId int,               
@pn_Year int,               
@pn_Month int    
)    
returns @DayWiseTable table       
(            
DayDate datetime, NoOfRemainingDays int , PreviousNoOfBoxes int , DayNoOfBoxes int , DayTotalNoOfBoxes int ,            
n_BoxCount_Slab1 int,n_BoxCount_Slab2 int,n_BoxCount_Slab3 int,n_BoxCount_Slab4 int,            
n_DailyRate_Slab1 decimal(18,6) , n_DailyRate_Slab2 decimal(18,6) , n_DailyRate_Slab3 decimal(18,6) , n_DailyRate_Slab4 decimal(18,6)             
,DayCharges decimal(18,6)              
)       
As     
Begin  -- Begin Func    
declare @StartDate datetime = Convert(varchar(4) , @pn_Year) + ''-'' + Convert(varchar(2) , @pn_Month) + ''-'' + ''01'' + '' 00:00:00''               
declare @EndDate datetime = dateadd( d , -1, dateadd(m , 1, @StartDate)   )             
declare @NoOfDaysInMonth int = datediff(d,@startdate,@enddate)  + 1             
declare @PreviousNoOfBoxes int             
declare @slab1end int = 250,                
 @slab2end int = 1000,               
 @slab3end int = 2500             
declare @Activity_1to250Boxes int = (select n_activityid from tbl_Activity where s_ActivityName = ''1 to 250 Standard Box (1.50 Cubic Ft)'')              
declare @Activity_250to1000Boxes int = (select n_activityid from tbl_Activity where s_ActivityName = ''250 to 1000 Standard Box (1.50 Cubic Ft)'')              
declare @Activity_1000to2500Boxes int = (select n_activityid from tbl_Activity where s_ActivityName = ''1001 to 2500 Standard Box (1.50 Cubic Ft)'')              
declare @Activity_2501AndAboveBoxes int = (select n_activityid from tbl_Activity where s_ActivityName = ''2501 & Above Standard Box (1.50 Cubic Ft)'')               
    
--Select @NoOfBoxes_PU_PrevMonth    
--Select @NoOfBoxes_RETR_PrevMonth    
--Select @NoOfBoxes_REST_PrevMonth    
Declare @NoOfBoxes_PrevMonth int = 0      
Select @NoOfBoxes_PrevMonth = dbo.fn_Invoice_GetBoxCount_PreviousMonth(@pn_WarehouseId, @pn_CustomerId, @pn_Year , @pn_Month  ,@StartDate - 1)    
    
--LOOP THROUGH EACH DAY AND CALCULATE NUMBER OF BOXES     
Declare @LoopDate DateTime  = @StartDate    
While @LoopDate <=@EndDate     
    Begin  --LOOP BEGIN    
    Declare @loopboxcount int = 0     
    Select @loopboxcount = dbo.fn_Invoice_GetBoxCount_DayOfMonth(@pn_WarehouseId , @pn_CustomerId , @StartDate -1 , @LoopDate - 1)    
    Insert @DayWiseTable (DayDate, NoOfRemainingDays, PreviousNoOfBoxes, DayNoOfBoxes , DayTotalNoOfBoxes )             
 Select @LoopDate  ,datediff(d,@LoopDate,@enddate) + 1, @NoOfBoxes_PrevMonth , @loopboxcount , @NoOfBoxes_PrevMonth + @loopboxcount       
 Set @LoopDate = DATEADD( d , 1 , @LoopDate)     
    End    --LOOP END     
    
    
update @DayWiseTable set n_BoxCount_Slab1 = case when DayTotalNoOfBoxes <=@slab1end then DayTotalNoOfBoxes else @slab1end end  --where n_activityid = @Activity_1to250Boxes and DayTotalNoOfBoxes > -1              
update @DayWiseTable set n_BoxCount_Slab2 = case when DayTotalNoOfBoxes < @slab1end then 0 when DayTotalNoOfBoxes >@slab1end and DayTotalNoOfBoxes <=@slab2end  then DayTotalNoOfBoxes - @slab1end  else @slab2end-@slab1end end  --where n_activityid = @Activity_250to1000Boxes and DayTotalNoOfBoxes > -1              
update @DayWiseTable set n_BoxCount_Slab3 = case when DayTotalNoOfBoxes < @slab2end then 0 when DayTotalNoOfBoxes >@slab2end and DayTotalNoOfBoxes <=@slab3end  then DayTotalNoOfBoxes - @slab2end  else @slab3end - @slab2end  end  --where n_activityid = @Activity_1000to2500Boxes and DayTotalNoOfBoxes > -1              
update @DayWiseTable set n_BoxCount_Slab4 = case when DayTotalNoOfBoxes < @slab3end then 0 when DayTotalNoOfBoxes >@slab3end  then DayTotalNoOfBoxes - @slab3end end  --where n_activityid = @Activity_2501AndAboveBoxes and DayTotalNoOfBoxes > -1            
  
    
            
            
    update @DayWiseTable set n_DailyRate_Slab1 = ( select top 1 n_Rate From tbl_RateCard where n_CustomerId = @pn_CustomerID and n_ActivityId = @Activity_1to250Boxes order by d_Todate desc ) /@NoOfDaysInMonth            
    update @DayWiseTable set n_DailyRate_Slab2 = ( select top 1 n_Rate From tbl_RateCard where n_CustomerId = @pn_CustomerID and n_ActivityId = @Activity_250to1000Boxes order by d_Todate desc )  /@NoOfDaysInMonth            
    update @DayWiseTable set n_DailyRate_Slab3 = ( select top 1 n_Rate From tbl_RateCard where n_CustomerId = @pn_CustomerID and n_ActivityId = @Activity_1000to2500Boxes order by d_Todate desc )  /@NoOfDaysInMonth            
    update @DayWiseTable set n_DailyRate_Slab4 = ( select top 1 n_Rate From tbl_RateCard where n_CustomerId = @pn_CustomerID and n_ActivityId = @Activity_2501AndAboveBoxes order by d_Todate desc )  /@NoOfDaysInMonth            
            
    update @DayWiseTable set n_DailyRate_Slab1 = ( select top 1 n_Rate From tbl_RateCard where n_CustomerId = @pn_CustomerID and n_ActivityId = @Activity_1to250Boxes order by d_Todate desc )        
    update @DayWiseTable set n_DailyRate_Slab2 = ( select top 1 n_Rate From tbl_RateCard where n_CustomerId = @pn_CustomerID and n_ActivityId = @Activity_250to1000Boxes order by d_Todate desc )        
    update @DayWiseTable set n_DailyRate_Slab3 = ( select top 1 n_Rate From tbl_RateCard where n_CustomerId = @pn_CustomerID and n_ActivityId = @Activity_1000to2500Boxes order by d_Todate desc )        
    update @DayWiseTable set n_DailyRate_Slab4 = ( select top 1 n_Rate From tbl_RateCard where n_CustomerId = @pn_CustomerID and n_ActivityId = @Activity_2501AndAboveBoxes order by d_Todate desc )        

/*            
    update @DayWiseTable set DayCharges  = (n_BoxCount_Slab1 * n_DailyRate_Slab1  /@NoOfDaysInMonth    ) + (n_BoxCount_Slab2 * n_DailyRate_Slab2  /@NoOfDaysInMonth    )            
         + (n_BoxCount_Slab3 * n_DailyRate_Slab3  /@NoOfDaysInMonth    ) + (n_BoxCount_Slab4 * n_DailyRate_Slab4  /@NoOfDaysInMonth    )            
*/

/* change here for straight calculation logic */             
update @DayWiseTable set DayCharges = DayTotalNoOfBoxes * n_DailyRate_Slab1  /@NoOfDaysInMonth where DayTotalNoOfBoxes <=@slab1end
update @DayWiseTable set DayCharges = DayTotalNoOfBoxes * n_DailyRate_Slab2  /@NoOfDaysInMonth where DayTotalNoOfBoxes >@slab1end and DayTotalNoOfBoxes <=@slab2end  
update @DayWiseTable set DayCharges = DayTotalNoOfBoxes * n_DailyRate_Slab3  /@NoOfDaysInMonth where DayTotalNoOfBoxes >@slab2end and DayTotalNoOfBoxes <=@slab3end  
update @DayWiseTable set DayCharges = DayTotalNoOfBoxes * n_DailyRate_Slab4  /@NoOfDaysInMonth where DayTotalNoOfBoxes > @slab3end

/* change here for straight calculation logic */             
    return     
End --End Func ' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetInvoice_New]    Script Date: 09/29/2016 11:07:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_GetInvoice_New]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'--EXEC usp_getinvoice_new 6, 2015, 6, 2015, 212,103, 1 , 2015011007
-- EXEC usp_getinvoice_new 5, 2015, 5, 2015, 212,103, 1, 2015011007                            
--[dbo].[usp_GetInvoice_New] 1,2015,1,2016,null,null                             
CREATE Procedure [dbo].[usp_GetInvoice_New]                                          
(@pn_Month    Int,                                          
@pn_Year    Int,                              
@pn_ToMonth Int,                              
@pn_ToYear Int,                                          
@pn_CustomerId   Int,                                   
@pn_CustGroupId int,                  
@pn_WarehouseId int,                 
@Invoice_No    Int  = null                                
)                                          
As                                          
Begin--Begin Proc [usp_GetInvoice]                                 
    /*PROCEDURE CONSTANTS*/                          
    if ( (@pn_CustomerId = 0  or @pn_CustGroupId = 0 ) and @Invoice_No is null)          
 return  -1          
           
----------           
if ( @Invoice_No is not null)           
begin           
    Declare @n_InvoiceMonthYear int , @n_InvoiceCustomerId int , @n_InvoiceWareHouseId int  , @n_InvoiceGroupID int           
    select @n_InvoiceMonthYear = n_MonthYear , @n_InvoiceCustomerId = n_CustomerId , @n_InvoiceWareHouseId = n_WareHouseId from tbl_InvoiceSummary_New where n_InvoiceNo = @Invoice_No           
              
    set @pn_Month =  @n_InvoiceMonthYear %100          
    set @pn_Year = @n_InvoiceMonthYear /100           
    set @pn_ToMonth =  @n_InvoiceMonthYear %100          
    set @pn_ToYear = @n_InvoiceMonthYear /100           
    set @pn_CustomerId =@n_InvoiceCustomerId          
    set @pn_CustGroupId = (select n_CompanyGroupId  from tbl_Customer where n_CustomerId =  @pn_CustomerId)           
    set @pn_WarehouseId = @n_InvoiceWareHouseId          
end           
-------      
      
-------      
--PROC CONSTANTS      
Declare @Activity_NewBoxCost int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''New Standard Box Cost (1.50 Cubic Ft.)'')                         
Declare @Activity_BarcodingDataEntry int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''Bar-coding & Data Entry (File & Box)'')                         
Declare @Activity_StandardBoxTransportation int = (Select n_ActivityId From tbl_activity Where s_ActivityName =''Standard Box Transportation'')                         
-------           
    declare @Status_File_In int = (select n_AppCodeId from tbl_ApplicationCodeMaster where s_AppCode = ''BOXFILE_STATUS'' and s_AppCodeName = ''In'')                          
    declare @Status_WorkOrder_Closed int = (select n_AppCodeId from tbl_ApplicationCodeMaster where s_AppCode = ''WORKORDER_STATUS'' and s_AppCodeName = ''Closed'')                          
    /*PROCEDURE CONSTANTS*/                                    
    Declare @MonthYear As Int;                                           
    If (LEN(@pn_Month) <= 1)                                          
    Begin                                          
        Set @MonthYear = Convert (Int, Convert (Varchar (4), @pn_Year) + ''0'' + Convert (Varchar (2), @pn_Month));                                          
    End                                          
    Else                                          
    Begin                                          
 Set @MonthYear = Convert (Int, Convert (Varchar (4), @pn_Year) + Convert (Varchar (2), @pn_Month));                                          
    End                             
                                  
    Declare @ToMonthYear As Int;                               
    If (LEN(@pn_ToMonth) <= 1)                                          
    Begin                                          
 Set @ToMonthYear = Convert (Int, Convert (Varchar (4), @pn_ToYear) + ''0'' + Convert (Varchar (2), @pn_ToMonth));                                          
    End                                          
    Else                                          
    Begin                                          
 Set @ToMonthYear = Convert (Int, Convert (Varchar (4), @pn_ToYear) + Convert (Varchar (2), @pn_ToMonth));                                          
    End        
    Declare @RMCExistBoxCount Int                                          
    Declare @RMCNewBoxCount Int                                          
    Declare @RMCBoxCountAfter15 Int                                          
    Declare @RMCEXISTBOXCOUNTCHARGES Decimal(10,2)=0.0                                          
    Declare @RMCNEWBOXCOUNTCHARGES Decimal(10,2)=0.0                                          
    Declare @RMCNEWBOXCOUNTCHARGESAFTER15 Decimal(10,2)=0.0                                          
    Declare @s_ActivityName As Varchar (100);                                          
    Declare @s_ActivityName1 As Varchar (100);                                          
    Declare @FromDate As Datetime;                                          
    Declare @ToDate As Datetime;                                          
                                
    Select @ToDate = Convert (Datetime, Substring(Convert (Varchar, @MonthYear), 1, 4) + ''-'' + Substring(Convert (Varchar, @MonthYear), 5, 6) + ''-'' + ''15'' + '' 23:59:59''),                                          
    @FromDate   = Convert (Datetime, Substring(Convert (Varchar, @MonthYear), 1, 4) + ''-'' + Substring(Convert (Varchar, @MonthYear), 5, 6) + ''-'' + ''1'' + '' 00:00:00'');                                            
    Set @RMCExistBoxCount = 0;                                          
    Set @RMCNewBoxCount = 0;                                          
    Set @RMCBoxCountAfter15 = 0;                                   
                            
    --set @FromDate = @FromDate + '' 00:00:00''                                
                            
    print @FromDate                                
    print @ToDate                                      
  
/* THIS BOX COUNT IS USED ONLY IN OLD LOGIC */  
Select @RMCExistBoxCount = dbo.fn_Invoice_GetBoxCount_TillCutOffDate_ForOldLogic(@pn_WareHouseId, @pn_CustomerId , @ToDate )  
                                    
 --Select @RMCExistBoxCount = Isnull(COUNT(*), 0)                                                      
 --From   tbl_BoxDetails  TBD                           
 --join tbl_BoxTransactions TBT on TBD.n_BoxId = TBT.n_BoxId                           
 --join tbl_WoActivities TWA on TWA.n_WoActivityId = TBT.n_WoActivityId                           
 --join tbl_WorkOrder TWO on TWA.n_WorkOrderNo = TWO.n_WorkorderNo                           
 --Where  TBD.n_CustomerId = @pn_CustomerId                                                      
 --   And TBD.n_Status = @Status_File_In                                                      
 --   And Convert(Date,TBD.d_ModifiedDate)  <=Convert(Date,@FromDate)                          
 --   And TWO.n_Status = @Status_WorkOrder_Closed                                                    
 --   And TBD.n_BoxId Not In (Select n_BoxId                                   
 --   From   tbl_BoxDetails                                                    
 --   Where  ( Convert(Date,TBD.d_ModifiedDate) >= Convert(Date,@FromDate)And Convert(Date,TBD.d_ModifiedDate) <= Convert(Date,@ToDate) ));                                          
                            
    -- Temporary arrangement as per request from Sejjal Madam, Parag Sutar, Rohit Gupta                                 
    print @RMCExistBoxCount;                                
    if (@pn_Month = 9 and @pn_Year = 2015 and @pn_CustomerId = 10 )                                
    Begin                                
 set @RMCExistBoxCount = @RMCExistBoxCount + 3416                                 
    print @RMCExistBoxCount;                                
    end                                
                            
    -- Temporary --                                
                                      
             
                                      
    Set @s_ActivityName = Case                                          
    When @RMCExistBoxCount >= 0                                          
    And                                           
    @RMCExistBoxCount <= 250 Then ''1 to 250 Standard Box (1.50 Cubic Ft)''                                           
    When @RMCExistBoxCount > 250        
    And                                           
    @RMCExistBoxCount <= 1000 Then ''250 to 1000 Standard Box (1.50 Cubic Ft)''                                  
    When @RMCExistBoxCount > 1000                                          
    And                                          
    @RMCExistBoxCount <= 2500 Then ''1001 to 2500 Standard Box (1.50 Cubic Ft)''                                           
    When @RMCExistBoxCount > 2500 Then ''2501 & Above Standard Box (1.50 Cubic Ft)''                                           
    Else ''''                                           
    End;                                          
                                   
    Select @RMCEXISTBOXCOUNTCHARGES = Isnull(TR.n_Rate, 0)                                           
    From   tbl_Activity As A                                          
    Inner Join                                          
    tbl_RateCard As TR                                          
    On A.n_ActivityId = TR.n_ActivityId                                          
    Where  A.n_ServiceCategoryId In (Select n_ServiceCategoryId                                          
    From   tbl_ServiceCategory                                          
    Where  s_SCName = ''Record Management Charges'')                                          
    And A.s_ActivityName = @s_ActivityName                                     
    And TR.n_CustomerId = @pn_CustomerId;                                                       
                              
/* THIS IS NOT REQUIRED NOW SINCE WE DO NOT NEED BREAK UP OF THREE ENTRIES EXIST/NEW BEF 15/NEW AFT 12                            */  
 --   Select @RMCNewBoxCount = Isnull(COUNT(*), 0)                                          
 --   From                             
 --tbl_BoxDetails  TBD                           
 --join tbl_BoxTransactions TBT on TBD.n_BoxId = TBT.n_BoxId                           
 --join tbl_WoActivities TWA on TWA.n_WoActivityId = TBT.n_WoActivityId                           
 --join tbl_WorkOrder TWO on TWA.n_WorkOrderNo = TWO.n_WorkorderNo                                               
 --   Where                            
 --TBD.n_CustomerId = @pn_CustomerId                                          
 --And TBD.n_Status = @Status_File_In                           
 --And TWO.n_Status = @Status_WorkOrder_Closed                                
 --And (TBD.d_ModifiedDate>= @FromDate And TBD.d_ModifiedDate<= @ToDate  )                                        
                          
    Set @s_ActivityName1 = Case                                          
    When @RMCNewBoxCount >= 0                                          
    And                                           
    @RMCNewBoxCount <= 250 Then ''1 to 250 Standard Box (1.50 Cubic Ft)''                                           
    When @RMCNewBoxCount > 250                                          
    And                                           
    @RMCNewBoxCount <= 1000 Then ''250 to 1000 Standard Box (1.50 Cubic Ft)''                                           
    When @RMCNewBoxCount > 1000                                          
    And                                          
    @RMCNewBoxCount <= 2500 Then ''1001 to 2500 Standard Box (1.50 Cubic Ft)''                                           
    When @RMCNewBoxCount > 2500 Then ''2501 & Above Standard Box (1.50 Cubic Ft)''                                           
    Else ''''                                           
    End;                                          
    Select @RMCNEWBOXCOUNTCHARGES = Isnull(TR.n_Rate, 0)                                           
    From   tbl_Activity As A                             
    Inner Join                                          
    tbl_RateCard As TR                                          
    On A.n_ActivityId = TR.n_ActivityId                                          
    Where  A.n_ServiceCategoryId In (Select n_ServiceCategoryId                                          
    From   tbl_ServiceCategory                                          
    Where  s_SCName = ''Record Management Charges'')                                          
    And A.s_ActivityName = @s_ActivityName1                         
    And TR.n_CustomerId = @pn_CustomerId;    
  
/* THIS IS NOT REQUIRED NOW SINCE WE DO NOT NEED BREAK UP OF THREE ENTRIES EXIST/NEW BEF 15/NEW AFT 12                            */  
    --Select @RMCBoxCountAfter15 = Isnull(COUNT(*), 0)                                          
    --From   tbl_BoxDetails                                          
    --Where  n_CustomerId = @pn_CustomerId                                          
    --And                                           
    --n_Status Not In (Select n_AppCodeId                                          
    --From   tbl_ApplicationCodeMaster                                          
    --Where  s_AppCode = ''BOXFILE_STATUS''                                          
    --And                                           
    --s_AppCodeName = ''Permanent Out'')And                                           
    --d_ModifiedDate>=@ToDate                      
    --and d_ModifiedDate < DATEADD(M , 1 ,@FromDate)                                           
                                          
    Create Table #TempOrders(n_OrderId TinyInt , n_ServiceCategoryId TinyInt)                                          
    Insert Into #TempOrders(n_OrderId, n_ServiceCategoryId)                                           
    Select 1     , n_ServiceCategoryId From tbl_ServiceCategory Where s_SCName =''Record Management Charges''                           
    Union                                          
    Select 2     , n_ServiceCategoryId From tbl_ServiceCategory Where s_SCName =''File Pick Up''                                          
    Union                                          
    Select 3     , n_ServiceCategoryId From tbl_ServiceCategory Where s_SCName =''Retrieval''                  
    Union                                          
    Select 4     , n_ServiceCategoryId From tbl_ServiceCategory Where s_SCName =''Permanent Return''                                            
    Union                                          
    Select 5     , n_ServiceCategoryId From tbl_ServiceCategory Where s_SCName =''Other services''                                            
    Union                                          
    Select 6     , n_ServiceCategoryId From tbl_ServiceCategory Where s_SCName =''Destruction''                                            
    Union                                          
    Select 7     , n_ServiceCategoryId From tbl_ServiceCategory Where s_SCName =''In-House management''                                            
                                        
                                         
    Create Table #TempSummary(n_ServiceCategoryId TinyInt,s_SCName Varchar(50),Amount Decimal(10,2))                                               
    Insert Into #TempSummary(n_ServiceCategoryId,s_SCName,Amount )                                           
    Select  TC.n_ServiceCategoryId,  TC.s_SCName ''Service '',                                          
    Sum( (TID.n_Amount) *(TID.n_ActivityCount)) [Total Amount]                                     From  tbl_InvoiceSummary_New TI Inner Join                                           
    tbl_InvoiceDetails_New TID   ON TI.n_InvoiceNo = TID.n_InvoiceNo                                            
    Inner Join                                          
    tbl_WoActivities TW On TID.n_WoActivityId = TW.n_WoActivityId                                           
    Inner Join                  
    tbl_Activity     TA On TW.n_ActivityId = TA.n_ActivityId                                              
    Inner Join                                          
    tbl_ServiceCategory  TC  ON TA.n_ServiceCategoryId = TC.n_ServiceCategoryId                                             
    Where TI.n_CustomerId  = @pn_CustomerId                                           
    And                                          
    TI.n_MonthYear = @MonthYear                                 
    Group by TC.s_SCName,TC.n_ServiceCategoryId                                           
    Declare @TotalExistBoxAmount Decimal(10,2)                                           
    Set @TotalExistBoxAmount=@RMCExistBoxCount*IsNUll(@RMCEXISTBOXCOUNTCHARGES,0);                                             
    Declare @TotalNewBoxAmount Decimal(10,2)                                           
    Set @TotalNewBoxAmount=@RMCNewBoxCount*IsNUll(@RMCNEWBOXCOUNTCHARGES,0);                               
                                             
    Select TI.n_InvoiceNo As ''InvoiceNo'', TI.n_MonthYear As ''MonthYear'', TI.n_WareHouseId As ''WareHouseId'',TI.n_StorageCharges_Daywise As ''Daywise'',                            
    TI.n_CustomerId As ''CustomerId'', TI.n_PickupAddressId As ''PickupAddressId'', TI.n_StorageCharges as ''StorageCharges'',                            
    TI.n_TransAmount As ''TransAmount'' ,TI.n_InvoiceAmount As ''InvoiceAmount'', TI.n_HigherEducation  As ''HigherEducation'',                            
    TI.n_ServiceTax As ''ServiceTax'', TI.n_EduTax As ''EduTax'', TI.n_OtherTax As ''OtherTax'', TI.n_TotalAmount   As ''TotalAmount'',                            
    TI.d_ModifiedDate As ''InvoiceDate'', TC.s_CustomerName  As ''CustomerName'', TC.s_BillingAddress As ''BillingAddress'',                            
    TC.s_BillingAddress1 As ''BillingAddress1'', TC.s_BillingAddress2 As ''BillingAddress2'', ST.s_StateName As ''StateName'',                            
    CM.s_CityName As ''CityName'', TC.s_PinCode As ''PinCode'', @RMCExistBoxCount As ''ExistingBox'',                            
    @RMCNewBoxCount As ''NBoxCountBefore15'', @RMCBoxCountAfter15 As ''NBoxAF15'',                
    case when @RMCEXISTBOXCOUNTCHARGES = 0 then @RMCNEWBOXCOUNTCHARGES else @RMCEXISTBOXCOUNTCHARGES end   As ''RecordMangementCharges'',                                        
    @RMCNEWBOXCOUNTCHARGES As ''RMCNewRate'', @RMCExistBoxCount+@RMCNewBoxCount + @RMCBoxCountAfter15 As ''RecordMangementTotalBoxes'',                             
    @TotalExistBoxAmount As ''TotalExistBoxAmount'', @TotalNewBoxAmount As ''TotalNewBoxAmount'' ,                         
    case when TC.n_BillingMode IS null then 1 else TC.n_BillingMode end As ''BillingMode''                                           
    From tbl_InvoiceSummary_New TI                                          
    Inner Join tbl_Customer  TC On TI.n_CustomerId = TC.n_CustomerId                                           
    inner join tbl_CompanyGroup CG on TC.n_CompanyGroupId = CG.n_CompanyGroupId                             
    Left Join tbl_StateMaster ST On ST.n_StateId = TC.n_StateId                                           
    Left Join tbl_CityMaster CM  On  TC.n_CityId = CM.n_CityId                             
    Where                             
    (TI.n_CustomerId = @pn_CustomerId or @pn_CustomerId = 0)                             
    AND (CG.n_CompanyGroupId = @pn_CustGroupId or @pn_CustGroupId = 0)                            
    And TI.n_MonthYear between @MonthYear and @ToMonthYear                                          
                                    
    Select  TS.n_ServiceCategoryId,TS.s_SCName,                                          
    TS.Amount                                          
    From  #TempSummary TS                                           
    Left Join                                          
    #TempOrders TOS On TS.n_ServiceCategoryId = TOS.n_ServiceCategoryId                                             
    Order By TOS.n_OrderId asc                                              

    Select TID.n_InvoiceDetailId     As ''InvoiceDetailId''  , TID.n_InvoiceNo   As ''InvoiceNo'',                                          
    TWO.n_WorkOrderNo      As ''WorkOrderNo''    , Case When CHARINDEX(''('',TA.s_ActivityName)>0                                           
    Then Replace(SUBSTRING(TA.s_ActivityName,0,CHARINDEX (''('',TA.s_ActivityName)),''['','''')                                          
    Else TA.s_ActivityName End   As ''ActivityName'',                                           
    TID.n_WoActivityId         As ''WoActivityId''     , TID.n_ActivityCount  As ''ActivityCount'',                                          
    TID.n_Amount           As ''Amount''     , Isnull(TID.n_Amount,0)* ISNULL(TID.n_ActivityCount,0) As TotalAmount,                                          
    case when (TWO.n_ActivityId =@Activity_NewBoxCost or TWO.n_ActivityId =@Activity_BarcodingDataEntry  or TWO.n_ActivityId =@Activity_StandardBoxTransportation ) then TWO.d_ActivityDate       
 else TWO.d_ModificationDate end        As ''ActivityDate''   ,                                          
    Case TA.n_Unit      When 1  Then   ''Per Box ''                    
   When 2  Then   ''Per File''                                          
    When 3  Then   ''Per Trip''                                          
    When 4  Then   ''Per Unit''                                           
    Else '' '' End As Unit ,                                          
    TA.n_ActivityId          As ''ActivityId''         , TA.n_ServiceCategoryId As ''ServiceCategoryId'',                                          
    TC.s_SCName                                                  
    Into #TempResult From tbl_InvoiceDetails_New  TID                                         
    Inner Join                                          
    tbl_WoActivities      TWO  On TID.n_WoActivityId      = TWO.n_WoActivityId                                           
    Inner Join                                            
    tbl_Activity   TA   On TWO.n_ActivityId        = TA.n_ActivityId                                           
    Inner Join                                            
    tbl_ServiceCategory TC   On TC.n_ServiceCategoryId  = TA.n_ServiceCategoryId                 
     Where                              
	(@Invoice_No is null or @Invoice_No =0) 
	and TID.n_InvoiceNo in (Select n_InvoiceNo  From  tbl_InvoiceSummary TI Where TI.n_CustomerId = @pn_CustomerId And TI.n_MonthYear between @MonthYear and @ToMonthYear )                               
	Or (@Invoice_No is not null and @Invoice_No <> 0) 
	and TID.n_InvoiceNo = @Invoice_No                                                

    
    
    --Where TID.n_InvoiceNo In                                  
    --(Select n_InvoiceNo  From  tbl_InvoiceSummary_New TI Where TI.n_CustomerId = @pn_CustomerId                                           
    --And                                           
   --TI.n_MonthYear = @MonthYear  )                                           
                                
    If OBJECT_ID(''tempdb.#tmpTable1'') IS NOT NULL                                              
    Begin                                          
 Update #TempResult Set  ActivityCount = TBO.n_ServiceCount,                                          
 Amount    = TBO.n_Amount,                                          
 TotalAmount   = (TBO.n_ServiceCount)* (TBO.n_Amount)                                          
 From tbl_OtherTransactions TBO Inner Join #TempResult T On TBO.n_WoActivityId = T.WoActivityId                                                                 
    End                                          
    
    Select TR.* From  #TempResult TR  
    Left  Join #TempOrders TTO On TR.ServiceCategoryId = TTO.n_ServiceCategoryId
    Order by TR.WorkOrderNo , TR.WoActivityid    
                                
    Drop table #TempResult                                          
    Drop Table #TempOrders                                          
    Drop table #TempSummary                         
                        
  --select * from ufn_DateNoofboxAmount()                    
  select * from fn_CalculateStorageCharges_Daywise_Details(@pn_CustomerId,@pn_WarehouseId,@pn_Year,@pn_Month)                                
End--End Proc [usp_GetInvoice]' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[fn_CalculateStorageCharges_Daywise]    Script Date: 09/29/2016 11:07:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_CalculateStorageCharges_Daywise]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
/*      
select dbo.fn_CalculateStorageCharges_Daywise(5 ,1 ,2015,12)       
*/      
CREATE Function [dbo].[fn_CalculateStorageCharges_Daywise](      
@pn_CustomerId int,       
@pn_WarehouseId int,       
@pn_Year int,       
@pn_Month int       
)       
Returns Decimal(10,2)        
Begin --Begin Func       
    return (Select sum (DayCharges)  from dbo.fn_CalculateStorageCharges_Daywise_Details( @pn_CustomerId, @pn_WarehouseId , @pn_Year, @pn_Month) )
End  --End Func      
      ' 
END
GO
