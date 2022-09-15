
/*
SP Name		  : tr_FileDetails
Purpose		  : To insert the record in tbl_AuditFileDetails if any record is updated ,deleted in the original table tbl_FileDetails  
Created By	  : Vikas Verma
Creation Date : 24-September-2014
*/
If Exists (Select 1 From sys.triggers Where  Name = 'tr_FileDetails')
Begin
	Drop Trigger tr_FileDetails
End
Go

Create Trigger tr_FileDetails 
 	On tbl_FileDetails After Update,Delete
 As
 Begin
 	Insert Into tbl_AuditFileDetails
 		( n_FileId    , n_BoxId        ,s_FileBarCode ,  
          s_FileName  , n_BranchId    ,n_DepartmentId ,
          s_Year      , d_FromDate    ,d_EndDate      ,
          s_Label1    ,s_Label2       ,s_Label3       ,
          n_Status    ,d_ModifiedDate ,n_ModifiedBy  )
          
 	Select	n_FileId  ,n_BoxId       ,s_FileBarCode  ,
            s_FileName,n_BranchId    ,n_DepartmentId ,
            s_Year    ,d_FromDate    ,d_EndDate      ,
            s_Label1  ,s_Label2      ,s_Label3       ,
            n_Status  ,d_ModifiedDate,n_ModifiedBy
            
	From Deleted
 End
Go




