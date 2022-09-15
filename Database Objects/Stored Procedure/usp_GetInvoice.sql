

/*
SP Name: usp_GetInvoice
Description: This procedure is used to get the invoice of the customer
Created By:  Rajendra Pawar
Creation Date: 25 Sept 2014
*/
If Exists (Select 1
           From   sysobjects
           Where  Type = 'P'
                  And name = 'usp_GetInvoice')
    Begin
        Drop Procedure usp_GetInvoice;
    End


Go 

Create Procedure usp_GetInvoice
(@pn_Month		  Int,
@pn_Year		  Int,
@pn_CustomerId	  Int
)


As
Begin

	Declare @MonthYear As Int;    
	If (LEN(@pn_Month) <= 1)
		Begin
			Set @MonthYear = Convert (Int, Convert (Varchar (4), @pn_Year) + '0' + Convert (Varchar (2), @pn_Month));
		End
	 Else
	    Begin
			 Set @MonthYear = Convert (Int, Convert (Varchar (4), @pn_Year) + Convert (Varchar (2), @pn_Month));
		 End  
	 Declare @RecordMangementTotalBoxes Int 
	 Declare @RecordMangementCharges Decimal(10,2)
	 Declare @s_ActivityName As Varchar (100);
	 Declare @FromDate As Date;
     Declare @ToDate As Date;
     Select @FromDate = Convert (Date, Substring(Convert (Varchar, @MonthYear), 1, 4) + '-' + Substring(Convert (Varchar, @MonthYear), 5, 6) + '-' + '15'),
            @ToDate   = Convert (Date, Substring(Convert (Varchar, @MonthYear), 1, 4) + '-' + Substring(Convert (Varchar, @MonthYear), 5, 6) + '-' + '1');  
                         Set @ToDate =  DATEADD(Month, 1, @ToDate);   
                         Set @ToDate = DATEADD(day,-1,@ToDate) 
	 Set @RecordMangementCharges = 0
	 Set @RecordMangementTotalBoxes = 0;
	  Select @RecordMangementTotalBoxes = Isnull(COUNT(*), 0)
	  From   tbl_BoxDetails
	  Where  n_CustomerId = @pn_CustomerId
			   And 
			 n_Status Not In (Select n_AppCodeId
							  From   tbl_ApplicationCodeMaster
							  Where  s_AppCode = 'BOXFILE_STATUS'
											   And 
									 s_AppCodeName = 'Permanent Out')
											  And 
								   d_ModifiedDate <= @ToDate
											And 
								   n_BoxId Not In (Select n_BoxId
												   From   tbl_BoxDetails
												   Where  d_ModifiedDate Between @FromDate And @ToDate);
	Select @s_ActivityName = Case
	When @RecordMangementTotalBoxes > 0
				    And 
		 @RecordMangementTotalBoxes <= 250 Then '1 to 250 Standard Box (1.50 Cubic Ft)' 
	When @RecordMangementTotalBoxes > 250
			    	And 
	     @RecordMangementTotalBoxes <= 1000 Then '250 to 1000 Standard Box (1.50 Cubic Ft)' 
	When @RecordMangementTotalBoxes > 1000
				    And
		 @RecordMangementTotalBoxes <= 2500 Then '1001 to 2500 Standard Box (1.50 Cubic Ft)' 
	When @RecordMangementTotalBoxes > 2500 Then '2501 & Above Standard Box (1.50 Cubic Ft)' 
	Else '' 
	End;
	Select @RecordMangementCharges = Isnull(TR.n_Rate, 0) 
	From   tbl_Activity As A
		   Inner Join
		   tbl_RateCard As TR
		   On A.n_ActivityId = TR.n_ActivityId
	Where  A.n_ServiceCategoryId In (Select n_ServiceCategoryId
									 From   tbl_ServiceCategory
									 Where  s_SCName = 'Record Management Charges')
		   And A.s_ActivityName = @s_ActivityName
		   And TR.n_CustomerId = @pn_CustomerId;	            

		  Create Table #TempOrders(n_OrderId	TinyInt ,	n_ServiceCategoryId TinyInt)
		  Insert Into #TempOrders(n_OrderId, n_ServiceCategoryId) 
						   Select 1		   , n_ServiceCategoryId From tbl_ServiceCategory Where s_SCName ='Record Management Charges'
								Union
						   Select 2		   , n_ServiceCategoryId From tbl_ServiceCategory Where s_SCName ='File Pick Up'
								Union
						  Select 3		   , n_ServiceCategoryId From tbl_ServiceCategory Where s_SCName ='Retrieval' 
								Union
						 Select 4		   , n_ServiceCategoryId From tbl_ServiceCategory Where s_SCName ='Permanent Return'  
								Union
						 Select 5		   , n_ServiceCategoryId From tbl_ServiceCategory Where s_SCName ='Other services'  
								Union
						 Select 6		   , n_ServiceCategoryId From tbl_ServiceCategory Where s_SCName ='Destruction'  
								Union
						 Select 7		   , n_ServiceCategoryId From tbl_ServiceCategory Where s_SCName ='In-House management'  
						 
						 
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
										   Where TI.n_CustomerId  = @pn_CustomerId 
												And
										   TI.n_MonthYear = @MonthYear 
		 Group by TC.s_SCName,TC.n_ServiceCategoryId 
		             
	Select TI.n_InvoiceNo		 As 'InvoiceNo'		  ,TI.n_MonthYear		 As 'MonthYear'		    ,
		   TI.n_WareHouseId		 As 'WareHouseId'	  ,TI.n_CustomerId		 As 'CustomerId'		,
		   TI.n_PickupAddressId	 As 'PickupAddressId' ,TI.n_StorageCharges	 As 'StorageCharges'    ,
		   TI.n_TransAmount		 As 'TransAmount'     ,TI.n_InvoiceAmount	 As 'InvoiceAmount'     ,
		   TI.n_HigherEducation  As 'HigherEducation' ,TI.n_ServiceTax		 As 'ServiceTax'		,
		   TI.n_EduTax			 As 'EduTax'		  ,TI.n_OtherTax		 As 'OtherTax'		    ,
		   TI.n_TotalAmount		 As 'TotalAmount'	  ,TI.d_ModifiedDate	 As 'InvoiceDate'	    ,
		   TC.s_CustomerName	 As 'CustomerName'    ,TC.s_BillingAddress   As 'BillingAddress'    ,
		   TC.s_BillingAddress1  As 'BillingAddress1' ,TC.s_BillingAddress2  As 'BillingAddress2'   ,
		   ST.s_StateName		 As 'StateName'       ,CM.s_CityName         As 'CityName'			,
		   TC.s_PinCode			 As 'PinCode' ,
		   @RecordMangementTotalBoxes As 'RecordMangementTotalBoxes' ,
		   @RecordMangementCharges    As 'RecordMangementCharges'
	From tbl_InvoiceSummary TI
			Inner Join
		tbl_Customer 	TC On TI.n_CustomerId = TC.n_CustomerId 
			Left Join
		tbl_StateMaster ST On ST.n_StateId = TC.n_StateId 
			Left Join
		tbl_CityMaster CM  On  TC.n_CityId = CM.n_CityId 	
		
	Where TI.n_CustomerId = @pn_CustomerId 
			And
		  TI.n_MonthYear = @MonthYear 
		  
	 Select  TS.n_ServiceCategoryId,TS.s_SCName,
			 TS.Amount
	 From  #TempSummary TS 
			Left Join
		  #TempOrders TOS On TS.n_ServiceCategoryId = TOS.n_ServiceCategoryId   
	Order By TOS.n_OrderId asc		  
		  
	Select TID.n_InvoiceDetailId	    As 'InvoiceDetailId'  , TID.n_InvoiceNo		 As 'InvoiceNo',
		   TWO.n_WorkOrderNo		    As 'WorkOrderNo' 	  , Case When CHARINDEX('(',TA.s_ActivityName)>0 
		   Then Replace(SUBSTRING(TA.s_ActivityName,0,CHARINDEX ('(',TA.s_ActivityName)),'[','')
		   Else TA.s_ActivityName End  	As 'ActivityName', 
		   TID.n_WoActivityId	        As 'WoActivityId'     , TID.n_ActivityCount	 As 'ActivityCount',
		   TID.n_Amount			        As 'Amount'			  , Isnull(TID.n_Amount,0)* ISNULL(TID.n_ActivityCount,0) As TotalAmount,
		   TWO.d_ModificationDate       As 'ActivityDate'	  ,
		   Case TA.n_Unit		    When 1  Then   'Per Box ' 
									When 2  Then   'Per File'
									When 3  Then   'Per Trip'
									When 4  Then   'Per Unit' 
									Else ' ' End As Unit ,
		TA.n_ActivityId 	        As 'ActivityId'		       , TA.n_ServiceCategoryId As 'ServiceCategoryId',
		TC.s_SCName  						
  Into #TempResult	From tbl_InvoiceDetails		TID
		 Inner Join
		 tbl_WoActivities 	    TWO  On TID.n_WoActivityId = TWO.n_WoActivityId 
		 Inner Join		
		 tbl_Activity			TA   On TWO.n_ActivityId  = TA.n_ActivityId 
		 Inner Join		
		 tbl_ServiceCategory	TC   On TC.n_ServiceCategoryId   = TA.n_ServiceCategoryId 
    Where TID.n_InvoiceNo In
							(Select n_InvoiceNo  From  tbl_InvoiceSummary TI Where TI.n_CustomerId = @pn_CustomerId 
																					    	And	
		
																					TI.n_MonthYear = @MonthYear  )	
	If OBJECT_ID('tempdb.#tmpTable1') IS NOT NULL  	 
	Begin
	Update #TempResult Set  ActivityCount = TBO.n_ServiceCount,
							Amount		  = TBO.n_Amount,
							TotalAmount   = (TBO.n_ServiceCount)* (TBO.n_Amount)
	 From tbl_OtherTransactions TBO Inner Join #TempResult T On TBO.n_WoActivityId = T.WoActivityId  																					
	End
	
	 Select TR.* From  #TempResult TR  Left  Join #TempOrders TTO On TR.ServiceCategoryId = TTO.n_ServiceCategoryId     Order by TTO.n_OrderId, WorkOrderNo,WoActivityId
Drop table #TempResult
Drop Table #TempOrders
Drop table #TempSummary
End


Go






