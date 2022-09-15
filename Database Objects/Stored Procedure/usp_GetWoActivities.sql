/*
SP Name       : usp_GetWoActivities
Purpose       : This stored procedure is used to get the Work Order Activities.
Created By    : Vikas Verma
Creation Date : 21 August 2014

*/
If Exists (Select 1 From sysobjects Where Type = 'P' AND  name = 'usp_GetWoActivities')
Begin
	Drop Procedure usp_GetWoActivities
End
Go
Create Procedure usp_GetWoActivities  
(	@pn_WoActivityId       Smallint   ,
	@pn_WorkOrderNo	       Int	      ,
	@pn_ActivityStatus	   SmallInt   ,
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

 
 Select  WOA.n_WoActivityId		 As 'WoActivityId'     , TBA.n_ServiceCategoryId                   As 'ServiceCategoryId'   ,
		 WOA.n_WorkOrderNo       As 'WorkOrderNo'      , TBA.s_ActivityName                        As 'ActivityName'        ,
         WOA.n_ActivityStatus    As 'ActivityStatus'   , WOA.n_ActivityId                          As 'ActivityId'          ,
         WOA.s_Remark            As 'Remark'           , WOA.n_BoxCount							   As 'BoxCount'		    ,
         WOA.n_FileCount	     As 'FileCount'        , ACM.s_AppCodeName                         As 'WoActivityStatus'    ,
		 Isnull(APC.s_AppCodeName,'') As 'Department'  , CONVERT(Varchar, WOA.d_ActivityDate,103)  As 'ActivityDate'		,
		 SC.s_SCName			 As 'SCName'           , Isnull(TP.s_Address,'')		           As 'PickUpAddress'  ,
	     WOA.n_PickupAddressId   AS 'PickupAddressId'      
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
        tbl_ServiceCategory		  SC  On SC.n_ServiceCategoryId = 	TBA.n_ServiceCategoryId 	
           Left Join 
         tbl_ApplicationCodeMaster APC ON Isnull(WOA.n_DepartmentId,0) = APC.n_AppCodeId    
  Where WOA.n_WoActivityId       = Case  @pn_WoActivityId       When  0 Then  WOA.n_WoActivityId       Else @pn_WoActivityId    End
			And
		WOA.n_WorkOrderNo      = Case  @pn_WorkOrderNo  	  When  0 Then  WOA.n_WorkOrderNo      Else @pn_WorkOrderNo     End 
			And
		WOA.n_ActivityStatus   = Case  @pn_ActivityStatus	  When  0 Then  WOA.n_ActivityStatus   Else @pn_ActivityStatus  End 	 
			And
		TPA.n_PageId           =  Case  @PageId	              When  0 Then  ACM.n_AppCodeId        Else @PageId             End 	
			And
		SC.n_ServiceCategoryId   =  Case  @n_ServiceCategoryId	              When  0 Then  SC.n_ServiceCategoryId        Else @n_ServiceCategoryId             End 	
		
		Order by Isnull(TP.s_Address,''), WOA.n_ActivityId
		End Try  
 Begin Catch  
 Exec usp_GetErrorInfo  
 End Catch  																
End   
Go

