
/*
SP Name		  : tr_BoxDetails
Purpose		  : To insert the record in tbl_AuditBoxDetails if any record is updated,deleted in the original table tbl_BoxDetails  
Created By	  : Vikas Verma
Creation Date : 24-September-2014
*/

If Exists (Select 1 From sys.triggers Where  Name = 'tr_BoxDetails')
Begin
	Drop Trigger tr_BoxDetails
End
Go

Create Trigger tr_BoxDetails 
 	On tbl_BoxDetails After Update,Delete
 As
 Begin
 
 	Insert Into tbl_AuditBoxDetails
 		( n_BoxId       , s_BoxBarCode  , s_LocationCode ,
 		  n_CustomerId  , n_WareHouseId , n_Status       ,
 		  d_ModifiedDate ,n_ModifiedBy)
          
 	Select	n_BoxId        ,s_BoxBarCode   ,s_LocationCode ,
 	        n_CustomerId   ,n_WareHouseId  ,n_Status       ,
 	        d_ModifiedDate ,n_ModifiedBy  
            
	From Deleted
 End
Go






 