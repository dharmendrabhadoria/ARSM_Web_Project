/*
SP Name		  : usp_GetState
Purpose		  : To Get State name.
Created By	  : Rajendra Pawar
Creation Date : 5-July-2014
*/
If Exists (Select 1 From sysobjects Where type = 'P' AND  name = 'usp_GetState')
Begin
	Drop Procedure usp_GetState
End
Go

Create Procedure usp_GetState(@pn_CountryId Int)  
As  
Begin 
SET NOCOUNT ON  
if(@pn_CountryId=0) 
 Select  n_StateId    As  'StateId' ,   
         s_StateName  As  'StateName'           
    From tbl_StateMaster       
    Order By s_StateName   
   Else
     Select  n_StateId    As  'State Id' ,   
         s_StateName  As  'State Name'           
    From tbl_StateMaster  Where n_CountryId= @pn_CountryId     
    Order By s_StateName     
End  
Go
