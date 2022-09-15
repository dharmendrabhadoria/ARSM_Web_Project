/*
SP Name		  : tr_BoxLocation
Purpose		  : To insert the record in tbl_AuditBoxLocation if any record is updated in the original table tbl_BoxLocation  
Created By	  : Vikas Verma
Creation Date : 24-September-2014
*/
If Exists (Select 1 From sys.triggers Where  Name = 'tr_BoxLocation')
Begin
	Drop Trigger tr_BoxLocation
End
Go

Create Trigger tr_BoxLocation 
 	On tbl_BoxLocation After Update
 As
 Begin
 	Insert Into tbl_AuditBoxLocation
 		( n_BoxLocationId    , s_BoxLocationCode ,
          n_BoxLocationNo , s_BoxLocationId   ,
          s_BoxBarCode    , n_WareHouseId) 
          
 	Select	n_BoxLocationId    , s_BoxLocationCode ,
            n_BoxLocationNo , s_BoxLocationId   ,
            s_BoxBarCode    , n_WareHouseId
           
	From Deleted
 End
Go

