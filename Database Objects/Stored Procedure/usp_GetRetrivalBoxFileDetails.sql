/*
SP Name: usp_GetRetrivalBoxFileDetails
Description: This procedure is used to get BoxFileRetrivaldetails .  
Created By:  Rajendra Pawar
Creation Date: 30 Dec-2014
*/

If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_GetRetrivalBoxFileDetails') 
Begin
   Drop Procedure usp_GetRetrivalBoxFileDetails
End 
Go
Create Procedure [dbo].[usp_GetRetrivalBoxFileDetails] 
(              
 @pn_WorkorderNo	   Int      ,  
 @n_WoActivityId       Int      ,
 @n_IsBoxFile		   TinyInt	,   --  0 All , 1 Only Box  2 Only File      
 @n_ServiceCategoryId  TinyInt
)              
As              
Begin              
   
        IF(@n_IsBoxFile != 1)
           Begin 
			 Select   
				 TBF.n_workOrderActivity		As  'workOrderActivity' ,
				 TA.s_ActivityName				As  'ActivityName'      ,
				 TBF.s_BoxBarCode				As	'BoxBarCode'		, TBF.s_FileBarCode		  As 'FileBarCode',
				 Isnull(FO.n_FileId,0)			As  'FileId'			, FO.d_FromDate           As  'FromDate'  ,
				 FO.d_EndDate		            As  'Todate'				, FO.s_Year               As  'Year'	  ,
				 FO.s_Label1				    As  'Label1'            , FO.s_Label2             As  'Label2'    ,  
				 FO.s_Label3				    As  'Label3'            , FO.n_Status             As  'FileStatus',
				 FO.s_FileName				    As  'FileName'          , TWA.n_ActivityStatus    As  'ActivityStatus'   ,
				 ACM.s_AppCodeName	            As  'WoActivityStatus'  , TB.n_CustomerId         As  'CustomerId'		 ,
				 TB.n_BoxId						As  'BoxId'             , TB.n_Status		      As  'BoxStatus' ,
				 AM.s_AppCodeName			    As  'Department'		, 
				 TB.s_LocationCode              As  'LocationCode'      , TB.n_WareHouseId        As 'WareHouseId'      ,
				 Isnull(TP.s_Address,'')	    As 'PickUpAddress'      , isnull(TWA.n_PickupAddressId,0)   AS 'PickupAddressId'
				  
		   From tbl_BoxFileRetrivaldetails TBF
						 Inner Join
			 tbl_WoActivities			 TWA On TBF.n_workOrderActivity = TWA.n_WoActivityId 
						Inner Join	 
			 tbl_Activity				 TA  On TWA.n_ActivityId = TA.n_ActivityId   
					        
						Inner  Join 
		    tbl_BoxDetails				TB	 On TBF.s_BoxBarCode  =TB.s_BoxBarCode 
						Left  Join
			tbl_FileDetails				FO	 On FO.n_BoxId = TB.n_BoxId  AND TBF.s_FileBarCode = FO.s_FileBarCode 
						Inner Join 
			tbl_ApplicationCodeMaster   ACM  On TWA.n_ActivityStatus = ACM.n_AppCodeId	
						Left Join 
			tbl_ApplicationCodeMaster AM	 On AM.n_AppCodeId = FO.n_DepartmentId 
				  	Left Join	
             tbl_ServiceCategory		  SC  On SC.n_ServiceCategoryId = 	TA.n_ServiceCategoryId 	
                 left Join    	
	         tbl_PickupAddress			TP   On  TWA.n_PickupAddressId   =  TP.n_PickupAddressId    

			Where  
		    TWA.n_WorkOrderNo   = @pn_WorkorderNo 
									And
			TBF.n_workOrderActivity =   Case @n_WoActivityId 
			                             When 0 Then TBF.n_workOrderActivity 
			                             Else @n_WoActivityId End
									AND
			TBF.n_IsBoxFile         =  Case @n_IsBoxFile 
										 When 0 Then TBF.n_IsBoxFile 
										 Else	@n_IsBoxFile END  
								   And
		   SC.n_ServiceCategoryId    =  Case  @n_ServiceCategoryId  When  0 Then  SC.n_ServiceCategoryId  
		                                 Else @n_ServiceCategoryId   End 	
	       Order By TP.s_Address ASC
			End
		Else
			Begin
				Select distinct   TBF.s_BoxBarCode       As 'BoxBarCode'  ,  TBF.s_FileBarCode		  As  'FileBarCode',
								  BO.n_BoxId             As 'BoxId'       ,  BO.n_Status		      As  'BoxStatus'  ,
								  BO.s_LocationCode      As  'LocationCode'  
				From tbl_BoxFileRetrivaldetails TBF 
						Inner Join
				 tbl_WoActivities			 TWA On TBF.n_workOrderActivity = TWA.n_WoActivityId  And Rtrim(ltrim(TBF.s_FileBarCode)) = ''
															And
											 TWA.n_WorkOrderNo   = @pn_WorkorderNo 
					Inner Join 
				 tbl_BoxDetails				 BO	On TBF.s_BoxBarCode   = BO.s_BoxBarCode		
				Where   TBF.n_workOrderActivity  =   Case @n_WoActivityId   
										When 0 Then TBF.n_workOrderActivity   
										Else @n_WoActivityId End   		
 
		 End  									
			  								
End 

Go



