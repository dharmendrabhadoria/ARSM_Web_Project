
/*
SP Name       : usp_GetWoActivitiesByServiceCategory
Purpose       : This stored procedure is used to get the Work Order Activities for the display in PDF or view details.
Created By    : Rajendra Pawar
Creation Date : 22 01 2015

*/
If Exists (Select 1 From sysobjects Where Type = 'P' AND  name = 'usp_GetWoActivitiesByServiceCategory')
Begin
	Drop Procedure usp_GetWoActivitiesByServiceCategory
End
Go
Create Procedure usp_GetWoActivitiesByServiceCategory 
( 
	@pn_WorkOrderNo	       Int	      ,
	@ps_PageName           Varchar(100),
	@n_ServiceCategoryId   TinyInt
)    
As  
Begin  
 SET NOCOUNT ON  
 Begin Try
 
 Declare @PageId Int
 Set @PageId=0
 SELECT @PageId =ISNULL(n_AppCodeId,0) FROM tbl_ApplicationCodeMaster 
 Where s_AppCodeName=@ps_PageName
Declare @ActivityIdStanderedBox SmallInt ,@ActivityIdSBarCodeing SmallInt;
Select @ActivityIdStanderedBox =n_ActivityId  From tbl_Activity Where s_ActivityName = 'New Standard Box Cost (1.50 Cubic Ft.)'
Select @ActivityIdSBarCodeing = n_ActivityId  From tbl_Activity Where s_ActivityName = 'Bar-coding & Data Entry (File & Box)'
 Create Table  #TemmBoxCount(n_BoxCount Int  ,n_PickupAddressId Int)
  Insert Into #TemmBoxCount(n_BoxCount  ,n_PickupAddressId)
 (Select 
					  n_BoxCount,n_PickupAddressId 
				 From tbl_WoActivities TWA 
							 Inner Join 
					 tbl_Activity TA  On TWA.n_ActivityId = TA.n_ActivityId 
					  
				Where n_WorkOrderNo = @pn_WorkOrderNo 
							And
					  TA.n_ServiceCategoryId = @n_ServiceCategoryId 
							And 
			  TA.n_ActivityId = @ActivityIdStanderedBox) 
 
 Select  WOA.n_WoActivityId		 As 'WoActivityId'     , TBA.n_ServiceCategoryId                   As 'ServiceCategoryId'   ,
		 WOA.n_WorkOrderNo       As 'WorkOrderNo'      , TBA.s_ActivityName                        As 'ActivityName'        ,
         WOA.n_ActivityStatus    As 'ActivityStatus'   , WOA.n_ActivityId                          As 'ActivityId'          ,
         WOA.s_Remark            As 'Remark'           , TBox.n_BoxCount						   As 'BoxCount'		    ,
         WOA.n_FileCount	     As 'FileCount'        , ACM.s_AppCodeName                         As 'WoActivityStatus'    ,
		 Isnull(APC.s_AppCodeName,'') As 'Department'  , CONVERT(Varchar, WOA.d_ActivityDate,103)  As 'ActivityDate'		,
		 SC.s_SCName			 As 'SCName'           , Isnull(TP.s_Address,'')		           As 'PickUpAddress'  ,
	     WOA.n_PickupAddressId   AS 'PickupAddressId'  , TAP.s_AuthorisedPerson					   As 'AuthorisedPerson'	,
	     TAP .s_MobileNo		 As 'AuthPMobileNo'    ,UM.s_FirstName + ' '+ UM.s_LastName        As  'ModifiedBy'         ,
	     CONVERT(Varchar,WOA.d_ModificationDate,103)   As 'ModificationDate'    
  From  tbl_WoActivities WOA
			Inner Join 
		tbl_WorkOrder					WO   On  WOA.n_WorkOrderNo   =  WO.n_WorkorderNo 
			Left  Join
	    tbl_PickupAddress				TP   On  WOA.n_PickupAddressId   =  TP.n_PickupAddressId    
			Inner Join 
		tbl_Activity			 TBA  On  WOA.n_ActivityId    = TBA.n_ActivityId 
			Inner Join	
		tbl_PagewiseActivity	 TPA  On  WOA.n_ActivityId    = TPA.n_ActivityId
			Inner Join	 
        tbl_ApplicationCodeMaster ACM On WOA.n_ActivityStatus = ACM.n_AppCodeId
         	Inner Join
				#TemmBoxCount TBox On WOA.n_PickupAddressId = TBox.n_PickupAddressId  		
				Inner Join
        tbl_ServiceCategory		  SC  On SC.n_ServiceCategoryId = 	TBA.n_ServiceCategoryId 	
        Inner Join
        tbl_UserMaster UM On WOA.n_ModifiedBy = UM.n_UserId
           Left Join 
         tbl_ApplicationCodeMaster APC ON Isnull(WOA.n_DepartmentId,0) = APC.n_AppCodeId 
       Left Join
(Select
 Min(n_AuthorisedPersonId) [AuthorisedPersonId] ,n_PickupAddressId 
     From tbl_AuthorisedPersons  Group by n_PickupAddressId  ) TAuthPickUp
       On TBox.n_PickupAddressId = TAuthPickUp.n_PickupAddressId
     Left Join
   tbl_AuthorisedPersons  TAP On TAuthPickUp.AuthorisedPersonId = TAP.n_AuthorisedPersonId     
  Where 
		WOA.n_WorkOrderNo      = Case  @pn_WorkOrderNo  	  When  0 Then  WOA.n_WorkOrderNo      Else @pn_WorkOrderNo     End 
			And
		TPA.n_PageId           =  Case  @PageId	              When  0 Then  ACM.n_AppCodeId        Else @PageId             End 	
			And
		SC.n_ServiceCategoryId   =  Case  @n_ServiceCategoryId	              When  0 Then  SC.n_ServiceCategoryId        Else @n_ServiceCategoryId             End 	
		And 
		TBA.n_ActivityId = @ActivityIdSBarCodeing
		Drop table #TemmBoxCount
		End Try  
 Begin Catch  
 Exec usp_GetErrorInfo  
 End Catch  																
End   
Go

