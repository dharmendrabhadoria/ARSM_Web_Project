/*
SP Name: usp_GetFileBarCodeCount
Description: This stored procedure is used to get the Box Bar code Details.  
Created By:  Ajay
Creation Date: 12-01-2015
*/
If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_GetFileBarCodeCount') 
Begin
   Drop Procedure usp_GetFileBarCodeCount
End 
Go
Create Procedure [dbo].[usp_GetFileBarCodeCount]
@Pn_CustomerId Int      
As  
 Begin    
	SET NOCOUNT ON   
	
	 Declare @nFileStatus  SmallInt
	 Select @nFileStatus = n_AppCodeId  From tbl_ApplicationCodeMaster  Where s_AppCode = 'BOXFILE_STATUS'  And  s_AppCodeName ='In'
	Select  count(TFD.n_FileId)   As   'FileCount'
	From tbl_FileDetails TFD 
 		Inner Join 
	tbl_BoxDetails  TBD  On  TFD.n_BoxId  = TBD.n_BoxId 
    Where     TBD.n_CustomerId     =   @Pn_CustomerId     And  
			   TFD.n_Status        =   @nFileStatus

 End 
 Go