/*
SP Name		  : tr_MapBoxLocation
Purpose		  : To insert the record in tbl_AuditMapBoxLocation if any record is updated or deleted in the original table tbl_MapBoxLocation  
Created By	  : Vikas Verma
Creation Date : 4-October-2014
*/
If Exists (Select 1 From sys.triggers Where  Name = 'tr_MapBoxLocation')
Begin
	Drop Trigger tr_MapBoxLocation
End
Go

Create Trigger tr_MapBoxLocation 
 	On tbl_MapBoxLocation After Update,Delete
 As
 Begin
 	Insert Into tbl_AuditMapBoxLocation
 		( n_MapBoxLocationId  ,
		  n_BoxId	          ,
          s_BoxLocationCode)		  
          
 	Select	n_MapBoxLocationId ,
 	        n_BoxId ,
            s_BoxLocationCode
           
	From Deleted
 End
Go





