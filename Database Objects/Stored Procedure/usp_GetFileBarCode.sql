/*
SP Name: usp_GetFileBarCode
Description: This stored procedure is used to get the File Barcode Details.  
Created By:  Ajay
Creation Date: 12-12-2014 
*/
If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_GetFileBarCode') 
Begin
   Drop Procedure usp_GetFileBarCode
End 
Go
Create Procedure usp_GetFileBarCode
(
@Pn_CustomerId Int     ,
@Pn_BoxId      Int     ,
@pn_FileStatus  SmallInt  
)    
As  
 Begin    
	 SET NOCOUNT ON   
     Select FD.n_BoxId    As  'BoxId' , FD.s_FileBarCode   As 'FileBarCode'   ,
            FD.n_FileId   As  'FileId'
     From tbl_FileDetails FD 
        Inner Join 
    tbl_BoxDetails   BD On FD.n_BoxId=BD.n_BoxId Where BD.n_CustomerId   =  @Pn_CustomerId And
                                                        FD.n_BoxId       =  Case @Pn_BoxId	   When 0
																			Then FD.n_BoxId	Else @Pn_BoxId End  And 
													    FD.n_BoxId       =  Case @Pn_BoxId	   When 0
																			Then FD.n_BoxId	Else @Pn_BoxId End   And
												        FD.n_Status      =  Case @pn_FileStatus When 0
												                            Then FD.n_Status Else @pn_FileStatus  END 						
  End 
Go