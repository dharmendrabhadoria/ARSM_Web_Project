
/*
SP Name		  : tr_WoActivities
Purpose		  : To insert the record in tbl_AuditWoActivities if any record is updated,deleted in the original table tbl_WoActivities  
Created By	  : Ajay Tiwari
Creation Date : 19-Jan-2015
*/

If Exists (Select 1 From sys.triggers Where  Name = 'tr_WoActivities')
Begin
	Drop Trigger tr_WoActivities
End
Go

Create Trigger tr_WoActivities 
 	On tbl_WoActivities After Update,Delete
 As
 Begin
 
 Insert Into tbl_AuditWoActivities(
       n_WoActivityId     ,n_WorkOrderNo        ,n_ActivityId
      ,n_ActivityStatus   ,n_BoxCount          ,n_FileCount
      ,s_Remark           ,d_ModificationDate  ,n_ModifiedBy
      ,n_DepartmentId     ,d_ActivityDate      ,n_PickupAddressId) 
          
 Select n_WoActivityId     ,n_WorkOrderNo        ,n_ActivityId
      ,n_ActivityStatus   ,n_BoxCount          ,n_FileCount
      ,s_Remark           ,d_ModificationDate  ,n_ModifiedBy
      ,n_DepartmentId     ,d_ActivityDate      ,n_PickupAddressId 
	From Deleted
 End
Go






 