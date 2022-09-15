/*
SP Name       : usp_GetBoxFileDetailsByWoActivity
Purpose       : This stored procedure is used to get the work order activity details.
Created By    : Rajendra Pawar
Creation Date : 02 Sept 2014
*/
If Exists (Select 1 From sysobjects Where Type = 'P' AND  name = 'usp_GetBoxFileDetailsByWoActivity')
Begin
	Drop Procedure usp_GetBoxFileDetailsByWoActivity
End
Go

Create Procedure usp_GetBoxFileDetailsByWoActivity  
(@Pn_WoActivityId Int)    
As  
Begin    
 SET NOCOUNT ON    
  Declare @Pn_WorkOrderNo  Int , @Pn_PickupAddressId   Int  ;
   Set @Pn_PickupAddressId = 0
   
  Select
	   @Pn_WorkOrderNo = n_WorkOrderNo 
  From tbl_WoActivities Where n_WoActivityId = @Pn_WoActivityId    
  Select
    @Pn_PickupAddressId = n_PickupAddressId  
  From tbl_WoActivities
  Where n_WoActivityId = @Pn_WoActivityId  
  Declare @Pn_ActivityId  Int ,@Pn_ActivityIdFileCount Int  
  
   Select 
		@Pn_ActivityId =n_ActivityId 
   From tbl_Activity
   Where s_ActivityName = 'New Standard Box Cost (1.50 Cubic Ft.)'  
   
  Select
		 @Pn_ActivityIdFileCount = n_ActivityId 
  From tbl_Activity 
  Where s_ActivityName = 'Bar-coding & Data Entry (File & Box)'  
    
  Select 
  @Pn_WorkOrderNo = n_WorkOrderNo
  From tbl_WoActivities
  Where n_WoActivityId = @Pn_WoActivityId    
    
  Create table #tempWoActivityResult(WorkOrderNo   Int , WoActivityId   Int , BoxCount Int ,FileCount Int,   
            TotalBoxAdded Int , TotalFileAdded Int ,n_PickupAddressId Int    )  
  
  Insert Into #tempWoActivityResult(WorkOrderNo  , WoActivityId   , BoxCount   ,FileCount,n_PickupAddressId )   
          Select n_WorkOrderNo, n_WoActivityId , n_BoxCount ,n_FileCount,n_PickupAddressId  
          From tbl_WoActivities  
          Where n_WoActivityId = @Pn_WoActivityId     
       
   Update #tempWoActivityResult Set BoxCount =(Select  n_BoxCount  From tbl_WoActivities  Where n_ActivityId = @Pn_ActivityId and n_WorkOrderNo = @Pn_WorkOrderNo And n_PickupAddressId = @Pn_PickupAddressId )
   Update #tempWoActivityResult Set FileCount =(Select  FileCount  From tbl_WoActivities  Where n_ActivityId = @Pn_ActivityIdFileCount and n_WorkOrderNo = @Pn_WorkOrderNo And n_PickupAddressId = @Pn_PickupAddressId )
       
  Update #tempWoActivityResult Set TotalBoxAdded =  (Select ISNULL(Count(TB.n_BoxId),0)  
                    From tbl_BoxDetails  TB  
                  Inner Join  
                    tbl_BoxTransactions TBT On TB.n_BoxId = TBT.n_BoxId  
                    Inner Join   
                      (Select n_WoActivityId ,n_PickupAddressId  
                       From tbl_WoActivities   
                       Where  
                        n_ActivityId = @Pn_ActivityId   
                           And   
                       n_WorkOrderNo = @Pn_WorkOrderNo
                          And 
                       n_PickupAddressId  = @Pn_PickupAddressId
                         ) As TWA ON TBT.n_WoActivityId = TWA.n_WoActivityId      
                  )
                  
    Update #tempWoActivityResult Set TotalFileAdded  =  (Select ISNULL(Count(TF.n_FileId),0)  
                  From tbl_FileDetails								As TF  
							Inner Join  
						(Select 
							distinct n_FileId 
						 From tbl_FileTransactions
						 Where n_WoActivityId = @Pn_WoActivityId)   As TFT  On TF.n_FileId  =  TFT.n_FileId) 
                    
  Select WorkOrderNo , WoActivityId   , BoxCount  ,  
     FileCount    , TotalBoxAdded  , TotalFileAdded   
    From  #tempWoActivityResult                                 
    Select Distinct  TB.s_BoxBarCode     As  'Box BarCode'      ,   
					 TF.s_FileBarCode    As  'File BarCode'     ,    TF.s_FileName        As  'File Name'          ,  
					 s_Year              As  'Year'             ,    d_FromDate           As  'From Date'          ,
					 d_EndDate           As  'To Date'          ,    s_Label1             As  'Label1'             ,  
					s_Label2            As  'Label2'            ,    s_Label3             As  'Label3'			   ,	        
					TP.s_Address1 + ''+TP.s_Address2  As 'PickUp Address'   
  From  tbl_BoxDetails  TB  
           Inner Join  
       tbl_FileDetails TF       On TB.n_BoxId  = TF.n_BoxId   
      Inner Join  
     tbl_FileTransactions TFT  On TF.n_FileId = TFT.n_FileId    
      Inner Join  
     tbl_WoActivities TWOA    On  TFT.n_WoActivityId = TWOA.n_WoActivityId     
     left  Join
     tbl_PickupAddress  TP   On   Isnull(TP.n_PickupAddressId,0) = Isnull(TWOA.n_PickupAddressId,0)  
    Where TFT.n_WoActivityId =    Case @Pn_WoActivityId  When 0 Then  TFT.n_WoActivityId Else @Pn_WoActivityId End   
    Drop table #tempWoActivityResult       
End 
Go

