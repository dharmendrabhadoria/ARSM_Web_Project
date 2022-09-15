--exec [usp_GetInvoice] 12,2015,12,2015,10,42,0                                                            
--exec [usp_GetInvoice]  6,2016,6,2016,30,63,2016000061                                                         
CREATE Procedure [dbo].[usp_GetInvoice]                                                                          
(@pn_Month    Int,                                                                          
@pn_Year    Int,                                                              
@pn_ToMonth Int,                                                              
@pn_ToYear Int,                                                                          
@pn_CustomerId   Int,                                                                   
@pn_CustGroupId int,                                                          
@Invoice_No    Int  = null                                                                 
)                                                                          
As                                                                          
Begin--Begin Proc [usp_GetInvoice]                                                                           
 Declare @MonthYear As Int;                                                                           
 If (LEN(@pn_Month) <= 1)                                                                          
  Begin                                                                          
   Set @MonthYear = Convert (Int, Convert (Varchar (4), @pn_Year) + '0' + Convert (Varchar (2), @pn_Month));                                                                          
  End                                                                          
  Else                                                                          
     Begin                                                                          
    Set @MonthYear = Convert (Int, Convert (Varchar (4), @pn_Year) + Convert (Varchar (2), @pn_Month));                                                                          
   End                                                               
   Declare @ToMonthYear As Int;                                                               
   If (LEN(@pn_ToMonth) <= 1)                                                                          
  Begin                                                                          
   Set @ToMonthYear = Convert (Int, Convert (Varchar (4), @pn_ToYear) + '0' + Convert (Varchar (2), @pn_ToMonth));                                                                          
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
     Select @ToDate = Convert (Datetime, Substring(Convert (Varchar, @MonthYear), 1, 4) + '-' + Substring(Convert (Varchar, @MonthYear), 5, 6) + '-' + '15' + ' 23:59:59'),                                                                          
           @FromDate   = Convert (Datetime, Substring(Convert (Varchar, @MonthYear), 1, 4) + '-' + Substring(Convert (Varchar, @MonthYear), 5, 6) + '-' + '1' + ' 00:00:00');                                                                            
  Set @RMCExistBoxCount = 0;                                                                          
     Set @RMCNewBoxCount = 0;                                                                          
     Set @RMCBoxCountAfter15 = 0;                                                                   
                                                                     
    --set @FromDate = @FromDate + ' 00:00:00'                                                                
                                                          
     print @FromDate                                                                
     print @ToDate                                                                      
                                                                            
 Select @RMCExistBoxCount = Isnull(COUNT(*), 0)                                                                          
 From   tbl_BoxDetails                                                                
 Where  n_CustomerId = @pn_CustomerId                                           
 And                                                                           
   n_Status Not In (Select n_AppCodeId                                                              
        From   tbl_ApplicationCodeMaster                                                                          
        Where  s_AppCode = 'BOXFILE_STATUS'                                                                          
             And                                                                           
        (s_AppCodeName = 'Permanent Out' or s_AppCodeName = 'Destroyed'))                                                                          
            And                                                                           
              Convert(Date,d_ModifiedDate)  <=Convert(Date,@ToDate)                                                                           
          And                                                                   
          n_BoxId Not In (Select n_BoxId                                                                          
              From   tbl_BoxDetails                                                                        
              Where  ( Convert(Date,d_ModifiedDate) >= Convert(Date,@FromDate)And Convert(Date,d_ModifiedDate) <= Convert(Date,@ToDate) ));                                                                          
                                                                
                                              
 --Temporary arrangement as per request from Sejjal Madam, Parag Sutar, Rohit Gupta                                                                                 
--  if (@pn_Month = 2  and @pn_Year = 2016 and @pn_CustomerId = 20 and (@Invoice_No is not null and @Invoice_No=2015000153))                                                                
--Begin                                                                
-- set @RMCExistBoxCount = @RMCExistBoxCount + 100                                                                 
-- print @RMCExistBoxCount;                                                                
--end                                                  
   if (@pn_Month = 3  and @pn_Year = 2016 and @pn_CustomerId = 20 and (@Invoice_No is not null and @Invoice_No=2015000170 ))                                                                
Begin                                                                
 set @RMCExistBoxCount = @RMCExistBoxCount + 100                        
 print @RMCExistBoxCount;                                                          end                                
                                          
--  if (@pn_Month = 2  and @pn_Year = 2016 and @pn_CustomerId = 10 and (@Invoice_No is not null and @Invoice_No=2015000146))                                                                
--Begin                                                                
-- set @RMCExistBoxCount = @RMCExistBoxCount + 519                                                          
-- print @RMCExistBoxCount;                                                                
--end                                    
                                  
  if (@pn_Month = 3  and @pn_Year = 2016 and @pn_CustomerId = 10 and (@Invoice_No is not null and @Invoice_No=2015000163))                                                          
Begin                                                                
 set @RMCExistBoxCount = @RMCExistBoxCount + 27                          
 print @RMCExistBoxCount;                                                               
end                                            
                                        
 if (@pn_Month = 2  and @pn_Year = 2016 and @pn_CustomerId = 19 and (@Invoice_No is not null and @Invoice_No=2015000152))                                                                
Begin                                                                
 set @RMCExistBoxCount = @RMCExistBoxCount + 454                                                          
 print @RMCExistBoxCount;                                                                
end                                                   
 if (@pn_Month = 4  and @pn_Year = 2016 and @pn_CustomerId = 10 and (@Invoice_No is not null and @Invoice_No=2016000019))                                                                
Begin                           
 set @RMCExistBoxCount = 0                              
 print @RMCExistBoxCount;                                                                
end                                      
                            
   if (@pn_Month = 4  and @pn_Year = 2016 and @pn_CustomerId = 20 and (@Invoice_No is not null and @Invoice_No=2016000016 ))                                                                
Begin                                                                
 set @RMCExistBoxCount = @RMCExistBoxCount + 100                                                                 
 print @RMCExistBoxCount;                                                                
end                                     
                            
  if (@pn_Month = 4  and @pn_Year = 2016 and @pn_CustomerId = 10 and (@Invoice_No is not null and @Invoice_No=2016000018))                                                                
Begin                                                                
 set @RMCExistBoxCount = @RMCExistBoxCount + 27                                                          
 print @RMCExistBoxCount;                                                               
end                            
                          
 if (@pn_Month = 8  and @pn_Year = 2016 and @pn_CustomerId = 20 and (@Invoice_No is not null and @Invoice_No=2016000108 ))                                                                
Begin                                                                
 set @RMCExistBoxCount = @RMCExistBoxCount + 75                                                                 
 print @RMCExistBoxCount;                                                                
end                       
                      
 if (@pn_Month = 8 and @pn_Year = 2016 and @pn_CustomerId = 19 and (@Invoice_No is not null and @Invoice_No=2016000107))                                                                
Begin                                                                
 set @RMCExistBoxCount = @RMCExistBoxCount + 96                                                          
 print @RMCExistBoxCount;                                                                
end                
 if (@pn_Month = 8  and @pn_Year = 2016 and @pn_CustomerId = 31 and (@Invoice_No is not null and @Invoice_No=2016000115))                                                                
Begin                                                                
 set @RMCExistBoxCount = @RMCExistBoxCount + 38                                                          
 print @RMCExistBoxCount;                                                                
end              
 if (@pn_Month = 6  and @pn_Year = 2016 and @pn_CustomerId = 31 and (@Invoice_No is not null and @Invoice_No=2016000065))                                                                
Begin                                                                
 set @RMCExistBoxCount = 0                                                         
 print @RMCExistBoxCount;                                                             
end                   
-- if (@pn_Month = 6  and @pn_Year = 2016 and @pn_CustomerId = 30 and (@Invoice_No is not null and @Invoice_No=2016000061))                                                                
--Begin                                                                
-- set @RMCExistBoxCount = @RMCExistBoxCount + 34                                                          
-- print @RMCExistBoxCount;                                                                
--end                              
-- Temporary --                                               
                                                                            
 Set @s_ActivityName = Case                                                         
 When @RMCExistBoxCount > 0                                                                          
    And                                  
  @RMCExistBoxCount <= 250 Then '1 to 250 Standard Box (1.50 Cubic Ft)'                                                                           
 When @RMCExistBoxCount > 250                                                                          
       And                                                                           
  @RMCExistBoxCount <= 1000 Then '250 to 1000 Standard Box (1.50 Cubic Ft)'                                                                           
 When @RMCExistBoxCount > 1000                     
    And                                                                          
  @RMCExistBoxCount <= 2500 Then '1001 to 2500 Standard Box (1.50 Cubic Ft)'                                                            
 When @RMCExistBoxCount > 2500 Then '2501 & Above Standard Box (1.50 Cubic Ft)'                                                                           
 Else ''                                                                           
 End;                                                                          
                                                                           
    Select @RMCEXISTBOXCOUNTCHARGES = Isnull(TR.n_Rate, 0)                                                                           
 From   tbl_Activity As A                                                                          
     Inner Join                                                                          
     tbl_RateCard As TR                                                                          
     On A.n_ActivityId = TR.n_ActivityId                                        
 Where  A.n_ServiceCategoryId In (Select n_ServiceCategoryId                                                                          
          From   tbl_ServiceCategory                                                                   
          Where  s_SCName = 'Record Management Charges')                                                            
     And A.s_ActivityName = @s_ActivityName                                                                          
     And TR.n_CustomerId = @pn_CustomerId;                                                                                       
 Select @RMCNewBoxCount = Isnull(COUNT(*), 0)                                                                          
   From   tbl_BoxDetails               
   Where  n_CustomerId = @pn_CustomerId                                                                          
      And                                                                           
    n_Status Not In (Select n_AppCodeId                          
 From   tbl_ApplicationCodeMaster                                                                         
         Where  s_AppCode = 'BOXFILE_STATUS'                                                                          
             And                                                                           
       (s_AppCodeName = 'Permanent Out'  or s_AppCodeName = 'Destroyed'))And                                                                           
                                 (d_ModifiedDate>= @FromDate                                                                           
             And                                                                          
            d_ModifiedDate<= @ToDate )                                                                        
          --And                                                                           
          --n_BoxId Not In (Select n_BoxId                                                                          
          --    From   tbl_BoxDetails                                                                          
          --    Where  Convert(Date,d_ModifiedDate) Between Convert(Date,@FromDate)And Convert(Date,@ToDate) );                                                                          
 Set @s_ActivityName1 = Case                                                                          
 When @RMCNewBoxCount > 0                                                                          
    And                                                        
  @RMCNewBoxCount <= 250 Then '1 to 250 Standard Box (1.50 Cubic Ft)'                                                                           
 When @RMCNewBoxCount > 250                                                                          
       And                                                                        
  @RMCNewBoxCount <= 1000 Then '250 to 1000 Standard Box (1.50 Cubic Ft)'                                                                           
 When @RMCNewBoxCount > 1000                                                                          
   And                                                                          
  @RMCNewBoxCount <= 2500 Then '1001 to 2500 Standard Box (1.50 Cubic Ft)'                                                     
 When @RMCNewBoxCount > 2500 Then '2501 & Above Standard Box (1.50 Cubic Ft)'                                                                           
 Else ''                                                                           
 End;                                                                          
    Select @RMCNEWBOXCOUNTCHARGES = Isnull(TR.n_Rate, 0)                                                                           
 From   tbl_Activity As A                                                          
     Inner Join                                                                          
     tbl_RateCard As TR                                                                          
     On A.n_ActivityId = TR.n_ActivityId                            
 Where  A.n_ServiceCategoryId In (Select n_ServiceCategoryId                                                                          
          From   tbl_ServiceCategory                                                                          
          Where  s_SCName = 'Record Management Charges')                                                                          
     And A.s_ActivityName = @s_ActivityName1                                                                          
     And TR.n_CustomerId = @pn_CustomerId;                                                                          
                                                                          
  Select @RMCBoxCountAfter15 = Isnull(COUNT(*), 0)                                                                          
  From   tbl_BoxDetails                                                                 
  Where  n_CustomerId = @pn_CustomerId                                                                          
      And                     
    n_Status Not In (Select n_AppCodeId                                                                          
         From   tbl_ApplicationCodeMaster                                                                          
         Where  s_AppCode = 'BOXFILE_STATUS'                                                                          
             And                                                                           
     (s_AppCodeName = 'Permanent Out' or s_AppCodeName = 'Destroyed') )And                                                                           
                                 d_ModifiedDate>=@ToDate                                                                           
                                                                                  
   Create Table #TempOrders(n_OrderId TinyInt , n_ServiceCategoryId TinyInt)                                         
   Insert Into #TempOrders(n_OrderId, n_ServiceCategoryId)                                                                           
         Select 1     , n_ServiceCategoryId From tbl_ServiceCategory Where s_SCName ='Record Management Charges'                                                                          
        Union                                         
            Select 2     , n_ServiceCategoryId From tbl_ServiceCategory Where s_SCName ='File Pick Up'                                                                     
      Union                                                                          
       Select 3     , n_ServiceCategoryId From tbl_ServiceCategory Where s_SCName ='Retrieval'                                                                           
         Union                                                          
      Select 4     , n_ServiceCategoryId From tbl_ServiceCategory Where s_SCName ='Permanent Return'                                                                            
        Union                                                                          
      Select 5     , n_ServiceCategoryId From tbl_ServiceCategory Where s_SCName ='Other services'                                                                            
       Union                                                                          
      Select 6     , n_ServiceCategoryId From tbl_ServiceCategory Where s_SCName ='Destruction'                                                                            
       Union                                                                          
      Select 7     , n_ServiceCategoryId From tbl_ServiceCategory Where s_SCName ='In-House management'                                                                            
                                                                                
                                                                                 
  Create Table #TempSummary(n_ServiceCategoryId TinyInt,s_SCName Varchar(50),Amount Decimal(10,2))                          
  Insert Into #TempSummary(n_ServiceCategoryId,s_SCName,Amount )                                                                           
    Select  TC.n_ServiceCategoryId,  TC.s_SCName 'Service ',                                                                          
         Sum( (TID.n_Amount) *(TID.n_ActivityCount)) [Total Amount]                                 
       From  tbl_InvoiceSummary TI Inner Join                                                                           
    tbl_InvoiceDetails TID   ON TI.n_InvoiceNo = TID.n_InvoiceNo                                                                            
               Inner Join                                                                          
            tbl_WoActivities TW On TID.n_WoActivityId = TW.n_WoActivityId                                                                           
          Inner Join                                                                           
             tbl_Activity     TA On TW.n_ActivityId = TA.n_ActivityId            
              Inner Join                                                                          
   tbl_ServiceCategory  TC  ON TA.n_ServiceCategoryId = TC.n_ServiceCategoryId                                                        
             Where /*TI.n_CustomerId  = @pn_CustomerId                                                                           
            And                                                                          
             TI.n_MonthYear = @MonthYear*/                                 
                (TI.n_CustomerId = @pn_CustomerId or @pn_CustomerId = 0)                                                             
 --AND (CG.n_CompanyGroupId = @pn_CustGroupId or @pn_CustGroupId = 0)                                                            
 And TI.n_MonthYear between @MonthYear and @ToMonthYear                                                          
 And (TI.n_InvoiceNo = @Invoice_No or( @Invoice_No is null or @Invoice_No = 0) )                          
                                                                          
   Group by TC.s_SCName,TC.n_ServiceCategoryId                                                                           
  Declare @TotalExistBoxAmount Decimal(10,2)                                                                           
  Set @TotalExistBoxAmount=@RMCExistBoxCount*IsNUll(@RMCEXISTBOXCOUNTCHARGES,0);                                                                             
  Declare @TotalNewBoxAmount Decimal(10,2)                                                                           
  Set @TotalNewBoxAmount=@RMCNewBoxCount*IsNUll(@RMCNEWBOXCOUNTCHARGES,0);                                                               
                                      
    --Temporary arrangement as per request from Sejjal Madam, Parag Sutar, Rohit Gupta                                                                 
                                                       
if (@pn_Month = 12  and @pn_Year = 2015 and @pn_CustomerId = 10 and (@Invoice_No is not null and @Invoice_No=2015000119))                                                                
Begin                                                                
 set @TotalNewBoxAmount = 0                                                        
 set @TotalExistBoxAmount = 0                                                       
 set @RMCExistBoxCount =0                                                      
 set @RMCNewBoxCount = 0                                                                        
end                 
            
if (@pn_Month = 06  and @pn_Year = 2016 and @pn_CustomerId = 31 and (@Invoice_No is not null and @Invoice_No=2016000065))                                                                
Begin       
 set @TotalNewBoxAmount = 0                                                        
 set @TotalExistBoxAmount = 0                                                       
 set @RMCExistBoxCount =0                                                      
 set @RMCNewBoxCount = 0                                                                        
end                                                                 
-- Temporary --                                                       
                                                       
Select TI.n_InvoiceNo As 'InvoiceNo', TI.n_MonthYear As 'MonthYear', TI.n_WareHouseId As 'WareHouseId',                                                      
 TI.n_CustomerId As 'CustomerId', TI.n_PickupAddressId As 'PickupAddressId', TI.n_StorageCharges as 'StorageCharges',                                                            
     TI.n_TransAmount As 'TransAmount' ,TI.n_InvoiceAmount As 'InvoiceAmount', TI.n_HigherEducation  As 'HigherEducation',                                                            
     TI.n_ServiceTax As 'ServiceTax', TI.n_EduTax As 'EduTax', TI.n_OtherTax As 'OtherTax', TI.n_TotalAmount   As 'TotalAmount',                                                             
TI.d_ModifiedDate As 'InvoiceDate', TC.s_CustomerName  As 'CustomerName', TC.s_BillingAddress As 'BillingAddress',                                                            
     TC.s_BillingAddress1 As 'BillingAddress1', TC.s_BillingAddress2 As 'BillingAddress2', ST.s_StateName As 'StateName',                                                            
     CM.s_CityName As 'CityName', TC.s_PinCode As 'PinCode', @RMCExistBoxCount As 'ExistingBox',                                                            
     @RMCNewBoxCount As 'NBoxCountBefore15', @RMCBoxCountAfter15 As 'NBoxAF15',                                                                          
     case when @RMCEXISTBOXCOUNTCHARGES = 0 then @RMCNEWBOXCOUNTCHARGES else @RMCEXISTBOXCOUNTCHARGES end   As 'RecordMangementCharges',                                                                        
     @RMCNEWBOXCOUNTCHARGES As 'RMCNewRate', @RMCExistBoxCount+@RMCNewBoxCount As 'RecordMangementTotalBoxes',                                                             
     @TotalExistBoxAmount As 'TotalExistBoxAmount', @TotalNewBoxAmount As 'TotalNewBoxAmount'                                                                          
 From tbl_InvoiceSummary TI                                                                          
 Inner Join tbl_Customer  TC On TI.n_CustomerId = TC.n_CustomerId                                                                           
 inner join tbl_CompanyGroup CG on TC.n_CompanyGroupId = CG.n_CompanyGroupId                                                             
    Left Join tbl_StateMaster ST On ST.n_StateId = TC.n_StateId                                                                           
    Left Join tbl_CityMaster CM  On  TC.n_CityId = CM.n_CityId                                              
 Where                                                             
 (TI.n_CustomerId = @pn_CustomerId or @pn_CustomerId = 0)                                                             
 AND (CG.n_CompanyGroupId = @pn_CustGroupId or @pn_CustGroupId = 0)                                                            
 And TI.n_MonthYear between @MonthYear and @ToMonthYear                                                          
 And (TI.n_InvoiceNo = @Invoice_No or( @Invoice_No is null or @Invoice_No = 0) )                                                                          
                                             
if (@pn_Month = 4  and @pn_Year = 2016 and @pn_CustomerId = 10 and (@Invoice_No is not null and @Invoice_No=2016000019))                                                                
    begin                                             
    Select 6 n_ServiceCategoryId , 'Destruction' s_SCName , 12800.00 Amount                                            
    end                                                                         
else if (@pn_Month = 2  and @pn_Year = 2016 and @pn_CustomerId = 20 and (@Invoice_No is not null and @Invoice_No=2015000153))                                                                
    begin                                             
    Select 5 n_ServiceCategoryId , 'File Pick Up' s_SCName , 118278.00 Amount                                            
    end                                            
else                                             
Begin                                     
  Select  TS.n_ServiceCategoryId,TS.s_SCName,                                                                          
    TS.Amount                                                                          
  From  #TempSummary TS                                                                           
   Left Join                                                                          
    #TempOrders TOS On TS.n_ServiceCategoryId = TOS.n_ServiceCategoryId                                                                             
 Order By TOS.n_OrderId asc                                                                              
End                                                                      
       --if(@Invoice_No is null)                                                          
       --Begin                                                              
   Select TID.n_InvoiceDetailId     As 'InvoiceDetailId'  , TID.n_InvoiceNo   As 'InvoiceNo',                                                        
     TWO.n_WorkOrderNo      As 'WorkOrderNo'    , Case When CHARINDEX('(',TA.s_ActivityName)>0                                                                           
     Then Replace(SUBSTRING(TA.s_ActivityName,0,CHARINDEX ('(',TA.s_ActivityName)),'[','')                                                                          
     Else TA.s_ActivityName End   As 'ActivityName',                                                                           
     TID.n_WoActivityId   As 'WoActivityId'     , TID.n_ActivityCount  As 'ActivityCount',                                                                          
     TID.n_Amount           As 'Amount'     , Isnull(TID.n_Amount,0)* ISNULL(TID.n_ActivityCount,0) As TotalAmount,                                                                          
     TWO.d_ModificationDate       As 'ActivityDate'   ,                                                                          
      Case TA.n_Unit      When 1  Then   'Per Box '                                                                           
          When 2  Then   'Per File'                                 
          When 3  Then   'Per Trip'                                                                          
          When 4  Then   'Per Unit'                                       
          When 6  Then   'Person-Hr'                                                                            
          Else ' ' End As Unit ,                                                          
  TA.n_ActivityId          As 'ActivityId'         , TA.n_ServiceCategoryId As 'ServiceCategoryId',                                                                          
  TC.s_SCName                                                                                  
  Into #TempResult From tbl_InvoiceDetails  TID                                                                          
   Inner Join                                                                          
   tbl_WoActivities      TWO  On TID.n_WoActivityId      = TWO.n_WoActivityId                                                                           
   Inner Join                                                                            
   tbl_Activity   TA   On TWO.n_ActivityId        = TA.n_ActivityId                                                           
   Inner Join                                                                            
   tbl_ServiceCategory TC   On TC.n_ServiceCategoryId  = TA.n_ServiceCategoryId                                                           
   Where                                                          
     (@Invoice_No is null or @Invoice_No =0) and TID.n_InvoiceNo in                   
                                                               
       (Select n_InvoiceNo  From  tbl_InvoiceSummary TI Where TI.n_CustomerId = @pn_CustomerId                              
                       And TI.n_MonthYear between @MonthYear and @ToMonthYear )                                                           
Or (@Invoice_No is not null and @Invoice_No <> 0) and TID.n_InvoiceNo = @Invoice_No                                                           
                                                          
                                                                 
   --End                                                          
--  else                                                          
--  Begin                               
-- Select TID.n_InvoiceDetailId     As 'InvoiceDetailId'  , TID.n_InvoiceNo   As 'InvoiceNo',                                                             
--     TWO.n_WorkOrderNo      As 'WorkOrderNo'    , Case When CHARINDEX('(',TA.s_ActivityName)>0                                                                           
--     Then Replace(SUBSTRING(TA.s_ActivityName,0,CHARINDEX ('(',TA.s_ActivityName)),'[','')                                                                          
--     Else TA.s_ActivityName End   As 'ActivityName',                                                                           
--     TID.n_WoActivityId         As 'WoActivityId'     , TID.n_ActivityCount  As 'ActivityCount',                                                             
--     TID.n_Amount           As 'Amount'     , Isnull(TID.n_Amount,0)* ISNULL(TID.n_ActivityCount,0) As TotalAmount,                                                                        
--     TWO.d_ModificationDate       As 'ActivityDate'   ,                                                                          
--      Case TA.n_Unit      When 1  Then   'Per Box '                                                                           
-- When 2  Then   'Per File'                                     
--          When 3  Then 'Per Trip'                                                                          
--          When 4  Then   'Per Unit'                                                                           
--          Else ' ' End As Unit ,                                                                          
--  TA.n_ActivityId          As 'ActivityId'         , TA.n_ServiceCategoryId As 'ServiceCategoryId',                                                                          
--  TC.s_SCName                                                                                  
--  Into #TempResult1 From tbl_InvoiceDetails  TID                                                                          
--   Inner Join                                                                          
--   tbl_WoActivities      TWO  On TID.n_WoActivityId      = TWO.n_WoActivityId                                                               
--   Inner Join                                               
--   tbl_Activity   TA   On TWO.n_ActivityId        = TA.n_ActivityId                                                                           
--   Inner Join                                                                            
--   tbl_ServiceCategory TC   On TC.n_ServiceCategoryId  = TA.n_ServiceCategoryId                                                         
--    Where                                                         
--    TID.n_InvoiceNo = @Invoice_No                                            
--    select * into #TempResult from #TempResult1                                                          
--end                                                   
if (@pn_Month = 2 and @pn_Year = 2016 and @pn_CustomerId = 20 and (@Invoice_No is not null and @Invoice_No=2015000153))                                                                
Begin                                             
 Update #TempResult Set  ActivityCount = TBO.n_ServiceCount,                                                                          
       Amount    = TBO.n_Amount,                     
       TotalAmount   = (TBO.n_ServiceCount)* (TBO.n_Amount)                                                                          
  From tbl_OtherTransactions TBO Inner Join #TempResult T On TBO.n_WoActivityId = T.WoActivityId                                                          
End                                             
else                                             
Begin                                             
If OBJECT_ID('tempdb.#tmpTable1') IS NOT NULL                                                                              
 Begin                                                                          
Update #TempResult Set  ActivityCount = TBO.n_ServiceCount,                                                                          
       Amount    = TBO.n_Amount,                              
       TotalAmount   = (TBO.n_ServiceCount)* (TBO.n_Amount)                                                                          
  From tbl_OtherTransactions TBO Inner Join #TempResult T On TBO.n_WoActivityId = T.WoActivityId                                                          
 End                                            
End                                              
              
  Select TR.* From  #TempResult TR  Left  Join #TempOrders TTO On TR.ServiceCategoryId = TTO.n_ServiceCategoryId     Order by TTO.n_OrderId, WorkOrderNo,WoActivityId                                                                          
Drop table #TempResult                                                                          
Drop Table #TempOrders                                                                          
Drop table #TempSummary                                                                          
End--End Proc [usp_GetInvoice]