  /*
SP Name		  : usp_CheckUserName
Purpose		  : check user name alerady exist
Created By	  : Ajay Tiwari
Creation Date : 05-July-2014
*/
If Exists (Select 1 From sysobjects Where type = 'P' AND  name = 'usp_CheckUserName')
Begin
	Drop Procedure usp_CheckUserName
End
Go
  
Create Procedure usp_CheckUserName    
(@pn_UserId      Int         ,         
 @ps_UserName    Varchar(15) ,    
 @pn_ReturnValue TinyInt Output  
 )     
 As    
Begin    
 SET NOCOUNT ON       
 Set @pn_ReturnValue = 0    
     
 If (@pn_UserId=0)    
 Begin      
 If Exists (Select 1 From tbl_UserMaster Where s_UserName  =  @ps_UserName)    
 Begin    
 Set @pn_ReturnValue = 2    
 Return    
 End    
 End    
 Else    
 If Exists  (Select 1 From tbl_UserMaster Where n_UserId!=@pn_UserId And s_UserName  =  @ps_UserName)    
 Begin    
 Set @pn_ReturnValue = 2    
 Return     
 End    
End   
Go 