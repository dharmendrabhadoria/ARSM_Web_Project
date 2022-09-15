/*
SP Name		  : usp_GetCity
Purpose		  : To Get City name.
Created By	  : Rajendra Pawar
Creation Date : 05-Jully-2014
*/
If Exists (Select 1 From sysobjects Where type = 'P' AND  name = 'usp_GetCity')
Begin
	Drop Procedure usp_GetCity
End
Go

Create Procedure usp_GetCity
@pn_StateId TinyInt  
As
Begin
SET NOCOUNT ON  
	Select  A.n_CityId		As  'CityId',	
			A.s_CityName	As  'CityName',
			A.n_StateId		As  'StateId',
	        B.s_StateName	As	'StateName'
    From tbl_CityMaster A
    Inner Join
    tbl_StateMaster B
    On A.n_StateId	=	B.n_StateId
    Where A.n_StateId= Case @pn_StateId When 0
					Then A.n_StateId Else @pn_StateId End
    Order By s_CityName        
End
Go
