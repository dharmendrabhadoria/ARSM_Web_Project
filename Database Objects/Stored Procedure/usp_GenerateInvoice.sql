
/*
SP Name: usp_GenerateInvoice
Description: This procedure is used to Add records  in the tbl_Invoice summary and Invoice details.  
Created By:  Rajendra Pawar
Creation Date: 10 Sept 2014
*/
If Exists (Select 1 From   sysobjects Where  Type = 'P'  And name = 'usp_GenerateInvoice')
    Begin
        Drop Procedure usp_GenerateInvoice;
    End
Go 
Create Procedure usp_GenerateInvoice
(  
@pn_Month    TinyInt,   
@pn_Year    Int  ,  
@pn_WareHouseId   TinyInt,   
@pXmlCustomerList Varchar (Max),  
@n_UserId    SmallInt  
)  
As  
Begin  
 Set Nocount On;  
 Begin Transaction;  
  Begin Try  
   /*Global variables*/  
   Declare @n_MonthYear As Int;  
   If (LEN(@pn_Month) <= 1)  
   Begin  
    Set @n_MonthYear = Convert(Int,Convert(Varchar(4),@pn_Year)+'0'+Convert(Varchar(2),@pn_Month));  
   End  
        Else  
   Begin  
    Set @n_MonthYear = Convert(Int,Convert(Varchar(4),@pn_Year)+Convert(Varchar(2),@pn_Month));  
   End 
     
        Create Table #TempxmlCustomerIDs  
        (  
            n_Id         Int Identity (1, 1),  
            n_CustomerId Int ,
           n_PickupAddressId    Int             
        );  
          
        Declare @docHandle As Int;  
        Execute sp_xml_preparedocument @docHandle Output, @pXmlCustomerList;  
          
        Insert Into #TempxmlCustomerIDs  
        Select *  
        From   Openxml (@docHandle, '/NewDataSet/Root', 2) With #TempxmlCustomerIDs;  
        Execute sp_xml_removedocument @docHandle;  
        
        Delete From #TempxmlCustomerIDs  
        Where n_CustomerId In( Select n_CustomerId From tbl_InvoiceSummary Where n_MonthYear = @n_MonthYear)  
        
        Create Table #TempMonthlyActivity  
        (  
            n_SrNo               Int             Identity (1, 1),  
            n_CustomerId         Int            ,  
            n_PickupAddressId    Int            ,  
            n_WorkorderNo        Int            ,  
            n_WoActivityId       Int            ,  
            n_ActivityId         Smallint       ,  
            d_ActivityDate       Datetime       ,  
            n_TotalActivityCount Int            ,  
            n_AmountPerFile      Decimal (10, 2)  
          
        );      
            Insert Into #TempMonthlyActivity (n_CustomerId     ,n_PickupAddressId    ,n_WorkorderNo ,  
           n_WoActivityId   ,n_ActivityId      ,d_ActivityDate)  
         Select  Wo.n_CustomerId  ,Isnull(WA.n_PickupAddressId,0) ,WA.n_WorkOrderNo,  
           WA.n_WoActivityId,WA.n_ActivityId  ,WA.d_ModificationDate  
         From 
          #TempxmlCustomerIDs  As T 
           Inner Join  
           tbl_WorkOrder  As Wo   On T.n_CustomerId = Wo.n_CustomerId  
           Left Join  
            tbl_WoActivities     As WA On Wo.n_WorkorderNo = WA.n_WorkOrderNo  
        Where  DATEPART(Month, WA.d_ModificationDate) = @pn_Month  
             And  
            DATEPART(Year, WA.d_ModificationDate)  = @pn_Year  
                And  
           WA.n_ActivityStatus = (Select Top 1 n_AppCodeId   
                From tbl_ApplicationCodeMaster  
                Where  s_AppCode = 'ACTIVITY_STATUS'  
                   And  
                 s_AppCodeName = 'Closed') ;  
             
             
			Update  #TempMonthlyActivity  
			Set n_AmountPerFile = TR.n_Rate  
				From    tbl_RateCard As TR  
						Inner Join  
						#TempMonthlyActivity As TA           On TR.n_CustomerId = TA.n_CustomerId  
						   And   
					  TR.n_ActivityId = TA.n_ActivityId;  
			Create Table #DeliveryActivity(n_ActivityId SmallInt) 
			Insert Into #DeliveryActivity(n_ActivityId) 
			Select n_ActivityId From  tbl_Activity Where s_ActivityName In(
			'Hand Delivery Charges Regular [(Within 24 hours) Max 4 box files / One Full Box]',
			'Hand Delivery Charges Express [(Within 12 hours) Max 4 box files / One Full Box]')
          
          
                
        Update  #TempMonthlyActivity  
            Set n_TotalActivityCount = Isnull(TW.n_BoxCount, 0) + Isnull(TW.n_FileCount, 0)  
        From    tbl_WoActivities As TW  
                Inner Join  
                #TempMonthlyActivity As TA  
                On TW.n_WoActivityId = TA.n_WoActivityId
        Where TW.n_ActivityId Not In(Select n_ActivityId  From #DeliveryActivity)  
        
        Update  #TempMonthlyActivity  
            Set n_TotalActivityCount =  TW.n_BoxCount  + Case   Isnull(TW.n_FileCount ,0)%4
										 When 0 Then 
												(Isnull(TW.n_FileCount,0)/4 ) 
												 Else
												(Isnull(TW.n_FileCount,0)/4 ) + 1	  End  
        From    tbl_WoActivities As TW  
                Inner Join  
                #TempMonthlyActivity As TA  
                On TW.n_WoActivityId = TA.n_WoActivityId
        Where TW.n_ActivityId  In(Select n_ActivityId  From #DeliveryActivity)       
         Drop Table #DeliveryActivity      
        Update  #TempMonthlyActivity  
			Set n_TotalActivityCount = TW.n_ServiceCount ,n_AmountPerFile = TW.n_Amount  
		From    tbl_OtherTransactions As TW  
		  Inner Join  
					#TempMonthlyActivity As TA              On TW.n_WoActivityId = TA.n_WoActivityId  
		  Inner Join  
					tbl_WoActivities   As TWA      On TA.n_ActivityId  = TWA.n_ActivityId;           
         
         Update T 
				Set T.n_PickupAddressId = TPickup.n_PickupAddressId
		 From #TempMonthlyActivity	T  
				Inner join (
							Select  n_CustomerId		   As 'n_CustomerId',
									Min(n_PickupAddressId) As  n_PickupAddressId  
							From tbl_PickupAddress Group by n_CustomerId)
						 As			TPickup On T.n_CustomerId = TPickup.n_CustomerId 
		Where Isnull(T.n_PickupAddressId,0) = 0
      
          Update T 
				Set T.n_PickupAddressId = TPickup.n_PickupAddressId
		 From #TempxmlCustomerIDs	T  
				Inner join (
							Select  n_CustomerId		   As 'n_CustomerId',
									Min(n_PickupAddressId) As  n_PickupAddressId  
							From tbl_PickupAddress Group by n_CustomerId)
						 As			TPickup On T.n_CustomerId = TPickup.n_CustomerId 
		Where Isnull(T.n_PickupAddressId,0) = 0
         
         
          /*New Invoice Series will Start From April 2015*/        
        /*Declare @InvoiceNo   As Int;  
		Declare @InvoiceYear As Int;  
                Select @InvoiceNo = Isnull((Max(n_InvoiceNo) + 1), 
           Convert (Int, Convert (Varchar, DATEPART(YEAR, GETDATE())) + '000001'))  
    From   tbl_InvoiceSummary  
   Select @InvoiceYear =  CONVERT(Int,Substring(CONVERT(varchar,(Select MAX(n_InvoiceNo)  From tbl_InvoiceSummary)),1,4))
    If (@InvoiceYear != DATEPART(YEAR, GETDATE()))  
                 Begin  
                     Select @InvoiceNo = Convert (Int, Convert (Varchar, DATEPART(YEAR, GETDATE())) + '000001');  
                 End
          */         
    Create Table #RMActivity(n_ActivityId Int ,n_UptoBoxCount Int )  
    Insert Into #RMActivity(n_ActivityId ,n_UptoBoxCount  )  
        Select  n_ActivityId ,Case s_ActivityName   
                 When  
                  '1 to 250 Standard Box (1.50 Cubic Ft)'    Then   250  
                 When   
                  '250 to 1000 Standard Box (1.50 Cubic Ft)' Then  1000    
                 When  
                  '1001 to 2500 Standard Box (1.50 Cubic Ft)' Then  2500    
                 When   
                  '2501 & Above Standard Box (1.50 Cubic Ft)' Then  2501  
                 Else 0 End  
        From tbl_Activity Where   n_ServiceCategoryId = (Select   Top 1 n_ServiceCategoryId  
                     From  tbl_ServiceCategory  
                     Where    s_SCName = 'Record Management Charges');  
      
    Declare @nHigherEducationValue   As Decimal (9, 2),   @nEduTaxValue As Decimal (8, 2),  
       @nServiceTaxValue As Decimal (8, 2),   @nOtherTaxValue As Decimal (8, 2);  
        
    Create Table #TempTaxes(TaxName varchar(50),TaxValue Decimal(5,2))  
     Insert Into #TempTaxes(TaxName ,TaxValue)   
         Select AP.s_AppCodeName,Isnull(T.n_TaxValue, 0 )  
        From   tbl_TaxMaster As T  
            Inner Join  
            tbl_ApplicationCodeMaster As AP  On AP.n_AppCodeId =  T.n_TaxId   
            Where s_AppCode = 'TAX_NAME'  
              
    Select  @nHigherEducationValue   = TaxValue From #TempTaxes  Where TaxName   = 'HIGHER EDUCATION'  
    Select  @nEduTaxValue  = TaxValue From #TempTaxes  Where TaxName             = 'EDUCATION CESS'  
    Select  @nServiceTaxValue = TaxValue From #TempTaxes  Where TaxName          = 'SERVICE TAX'  
    Select  @nOtherTaxValue   = TaxValue From #TempTaxes  Where TaxName          = 'OTHER TAX'  
      
    Declare @FromDate As Date;  
                Declare @ToDate As Date;  
                Select @FromDate = Convert (Date, Substring(Convert (Varchar, @n_MonthYear), 1, 4) + '-' + Substring(Convert (Varchar, @n_MonthYear), 5, 6) + '-' + '15'),  
                         @ToDate = Convert (Date, Substring(Convert (Varchar, @n_MonthYear), 1, 4) + '-' + Substring(Convert (Varchar, @n_MonthYear), 5, 6) + '-' + '1');  
                         Set @ToDate =  DATEADD(Month, 1, @ToDate);   
                         Set @ToDate = DATEADD(day,-1,@ToDate)   
                   Create Table #TempExistInvoice ( Id    Int Identity (1, 1), n_CustomerId   Int ,  
               s_CustomerName Varchar (100)  , Result   Varchar (100)  );    
                 
       Insert Into #TempExistInvoice (n_CustomerId, s_CustomerName, Result)                   
           Select  TC.n_CustomerId, s_CustomerName, 'Invoice already exist'  
                             From   tbl_Customer       As TC   
											Inner Join  
									  (Select TI.n_CustomerId    
									   From tbl_InvoiceSummary TI    
									   Inner Join #TempxmlCustomerIDs TCS 
									   On TI.n_CustomerId = TCS.n_CustomerId 
               Where     n_MonthYear = @n_MonthYear)   As TIS  On TC.n_CustomerId = TIS.n_CustomerId        
                 
                Create Table #tbl_InvoiceSummary (Id			     Int  Identity(1,1),  
												  n_InvoiceNo        Int         ,  d_ModifiedDate  Date          , n_MonthYear		    Int  ,   
												  n_WareHouseId      TinyInt      , n_CustomerId    Int           , n_PickupAddressId   Int ,   
												  n_StorageCharges   Decimal(10,2), n_InvoiceAmount Decimal(10,2) , n_HigherEducation   Decimal(5,2),   
												  n_ServiceTax       Decimal(5,2) , n_EduTax		Decimal(5,2)  , n_OtherTax          Decimal(5,2),  
												  n_TotalAmount      Decimal(10,2), n_ModifiedBy    SmallInt      , n_TransAmount       Decimal(10,2),  
												  n_RecordMangementTotalBoxes Int )  
              
    Insert Into #tbl_InvoiceSummary(d_ModifiedDate ,n_MonthYear      ,n_WareHouseId,  
									n_CustomerId ,n_PickupAddressId  ,n_ModifiedBy)  
						 Select     GetDate()    ,@n_MonthYear		 ,@pn_WareHouseId  ,  
									TC.n_CustomerId  ,Isnull(TPL.n_PickupAddressId,TC.n_PickupAddressId)  ,@n_UserId   
						 From  #TempxmlCustomerIDs    As TC   
						   Left Join   
						   ( Select  
							  n_CustomerId,Min(n_PickupAddressId) As n_PickupAddressId   
							 From #TempMonthlyActivity  Group by n_CustomerId )   As  TPL On TC.n_CustomerId = TPL.n_CustomerId           
				                           
							;With TemptblTBoxcount As(  
							Select  
							 TB .n_CustomerId, Isnull(COUNT(TB.n_BoxId), 0)BoxCount  
							From   tbl_BoxDetails TB Inner Join  #TempxmlCustomerIDs TPL  On TB.n_CustomerId = TPL.n_CustomerId  
						   Where    
						   TB.n_Status Not In (Select   
								   n_AppCodeId  
									  From   tbl_ApplicationCodeMaster  
								Where  s_AppCode = 'BOXFILE_STATUS'    And  
									   s_AppCodeName = 'Permanent Out')  
						   And   
						 TB.d_ModifiedDate <= @ToDate  
						   And   
						 TB.n_BoxId Not In ( Select   
							   n_BoxId  
							  From   tbl_BoxDetails  
							  Where  d_ModifiedDate Between @FromDate And @ToDate)  
						 Group by TB .n_CustomerId)  
            
   Update #tbl_InvoiceSummary  Set  n_RecordMangementTotalBoxes  = TemptblTBoxcount.BoxCount ,  
               n_StorageCharges     = Isnull(TR.n_Rate, 0) * Isnull(TemptblTBoxcount.BoxCount,0)     
            From #tbl_InvoiceSummary TI   
       Left Join  
                TemptblTBoxcount  On TI.n_CustomerId  = TemptblTBoxcount.n_CustomerId   
       Inner Join                                 
               tbl_RateCard     TR   On TemptblTBoxcount.n_CustomerId = TR.n_CustomerId   
                   Inner Join                                 
               tbl_Activity        TA On TR.n_ActivityId = TA.n_ActivityId   
       And    
    TA.n_ActivityId  In  
         (Select    
           Top 1 n_ActivityId    
          From #RMActivity  
           Where n_UptoBoxCount = Case When TemptblTBoxcount.BoxCount  < =  250 Then 250  
                When TemptblTBoxcount.BoxCount  >  250 And TemptblTBoxcount.BoxCount  < =  1000  Then 1000  
                When TemptblTBoxcount.BoxCount  >  1000 And TemptblTBoxcount.BoxCount  < =  2500  Then 2500  
                When TemptblTBoxcount.BoxCount  >  2500  Then 2501 Else 0 End)  
                
   Create Table #TempTransAmount  
                        (  
                         n_CustomerId Int,   Amount Decimal (10, 2)  
                        );  
   ;With TemptblAmount As( Select  n_CustomerId,   
           Sum(Isnull(n_TotalActivityCount, 0)) * SUM(Isnull(n_AmountPerFile, 0) )As Amount  
         From     #TempMonthlyActivity  
         Group By n_CustomerId, n_WoActivityId)  
   Insert Into #TempTransAmount (n_CustomerId  ,Amount)   
         Select n_CustomerId ,Sum(Amount) From TemptblAmount Group by n_CustomerId  
       
   Update #tbl_InvoiceSummary   
      Set n_TransAmount    = ISNULL(TTA.Amount,0), 
		  n_StorageCharges = ISNULL(n_StorageCharges,0), 	 
          n_InvoiceAmount = ISNULL(n_StorageCharges,0) + (ISNULL(TTA.Amount,0)),  
          n_HigherEducation   = (@nHigherEducationValue     * (ISNULL(n_StorageCharges,0) + (ISNULL(TTA.Amount,0))))  / 100,  
          n_OtherTax  = (@nOtherTaxValue     * (ISNULL(n_StorageCharges,0) + (ISNULL(TTA.Amount,0)))) / 100,  
          n_ServiceTax = (@nServiceTaxValue   * (ISNULL(n_StorageCharges,0) + (ISNULL(TTA.Amount,0)))) / 100,  
          n_EduTax  = (@nEduTaxValue       * (ISNULL(n_StorageCharges,0) + (ISNULL(TTA.Amount,0)))) / 100  
            From #tbl_InvoiceSummary  TI  
      Left Join  
     #TempTransAmount TTA  On TI.n_CustomerId = TTA.n_CustomerId   
     
     /* Old Invoice Series Numbers n_InvoiceNo = InvoiceNo+id */
     Declare @CurrentInvoiceNo Int
     Declare @RunningInvoiceNo Varchar(6)
     Select @RunningInvoiceNo = s_AppCodeName    From tbl_ApplicationCodeMaster  Where  s_AppCode = 'LASTINVOICE'
    Update #tbl_InvoiceSummary   
     Set n_TotalAmount =  (n_InvoiceAmount + n_HigherEducation + n_OtherTax + n_ServiceTax + n_EduTax ),  
     n_InvoiceNo    = CONVERT(Int, @RunningInvoiceNo)+Id
					  
       
   Insert Into tbl_InvoiceSummary (n_InvoiceNo    , d_ModifiedDate  ,  n_MonthYear        , n_WareHouseId ,n_CustomerId ,  
              n_PickupAddressId , n_StorageCharges, n_InvoiceAmount , n_HigherEducation   ,n_ServiceTax  ,  
              n_EduTax    , n_OtherTax     , n_TotalAmount   , n_ModifiedBy , n_TransAmount)  
        Select  n_InvoiceNo    , GETDATE() , n_MonthYear   , n_WareHouseId,n_CustomerId ,  
              n_PickupAddressId , n_StorageCharges, n_InvoiceAmount , n_HigherEducation   ,n_ServiceTax ,  
              n_EduTax    , n_OtherTax     , n_TotalAmount   , n_ModifiedBy , n_TransAmount  
              From #tbl_InvoiceSummary   
              
     Insert Into tbl_InvoiceDetails (n_InvoiceNo, n_WoActivityId, n_ActivityCount, n_Amount)  
                        Select distinct  TI.n_InvoiceNo ,  
                               n_WoActivityId,  
                               Isnull(n_TotalActivityCount, 0),  
                               Isnull(n_AmountPerFile, 0)  
                        From   #TempMonthlyActivity TA Inner Join  
                               #tbl_InvoiceSummary  TI  On  TA.n_CustomerId = TI.n_CustomerId   
                       Where Isnull(TA.n_WoActivityId,0) != 0  
                  If Exists(Select 1 From   #tbl_InvoiceSummary)           
           Begin     
			   Update tbl_ApplicationCodeMaster 
												Set s_AppCodeName = (Select Top 1  n_InvoiceNo From  #tbl_InvoiceSummary Order by 1 desc)
			   Where  s_AppCode = 'LASTINVOICE' 
			End               
                           
     If ((Select COUNT(*)  
             From   #TempExistInvoice) > 0)  
            Begin  
                Select Id,  
                       s_CustomerName As CustomerName,  
                       Result  
                From   #TempExistInvoice;  
                End  
 Drop table #TempTaxes                  
    Drop table #TempxmlCustomerIDs                     
    Drop table #TempExistInvoice  
    Drop table #RMActivity                               
    Drop table #TempTransAmount                                    
    Drop table #TempMonthlyActivity  
    Drop table #tbl_InvoiceSummary  
   Commit Transaction;  
  End Try  
 Begin Catch  
   Rollback;  
   Execute usp_GetErrorInfo ;  
 End Catch  
End     
  
Go
