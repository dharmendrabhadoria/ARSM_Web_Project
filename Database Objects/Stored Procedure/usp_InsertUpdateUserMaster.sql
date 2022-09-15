/*
SP Name       : usp_InsertUpdateUserMaster
Description   : This procedure is used to Add/update in the usermaster.  
Changed/Created By    : Ajay Tiwari
Creation Date : 05 july 2014
*/

If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_InsertUpdateUserMaster') 
Begin
   Drop Procedure usp_InsertUpdateUserMaster 
End 
Go

Create Procedure usp_InsertUpdateUserMaster  
(@pn_UserId		Int	              ,
@ps_FirstName   Varchar(25)       ,
@ps_MiddleName	Varchar(25)		  ,
@ps_LastName	Varchar(25)		  ,
@pd_BirthDate	Date	          ,
@pn_Department	SmallInt	      ,
@ps_UserName    Varchar(15)       ,
@ps_EmailId		Varchar(50)       ,
@ps_Password    Varchar(100)      ,
@pb_LoginStatus Bit               ,
@pn_IsActive    TinyInt           ,
@pn_UserRole    SmallInt )
As  
Begin  
 SET NOCOUNT ON  
 Begin Try
	If Exists (Select 1 From tbl_UserMaster Where n_UserId = @pn_UserId )
		Begin
			Update tbl_UserMaster Set s_FirstName    = @ps_FirstName	,	s_MiddleName  =  @ps_MiddleName   , 
									  s_LastName     = @ps_LastName		,	d_BirthDate   = @pd_BirthDate     ,
									  n_Department   = @pn_Department	,	s_UserName    = @ps_UserName      ,
									  s_Password     = @ps_Password		,	b_LoginStatus = @pb_LoginStatus	  ,
									  n_IsActive     = @pn_IsActive		,   n_UserRole    = @pn_UserRole      ,
									  d_ModifiedDate = Getdate()		,	s_EmailId	  = @ps_EmailId	
			Where n_UserId = @pn_UserId 
	    End	
	    Else
	    Begin
			Insert Into tbl_UserMaster
			   ( s_FirstName  ,	s_MiddleName  ,	 s_LastName    ,		d_BirthDate   ,	n_Department       ,  s_UserName   ,
			     s_EmailId    ,s_Password       ,b_LoginStatus ,		n_IsActive    ,	n_UserRole		   ,  d_ModifiedDate)
			Values
			   (@ps_FirstName ,	@ps_MiddleName,	@ps_LastName	  ,	@pd_BirthDate ,	@pn_Department     ,  @ps_UserName ,
			     @ps_EmailId  ,	@ps_Password  ,	@pb_LoginStatus   ,	@pn_IsActive  ,	@pn_UserRole	   ,  Getdate()  )		
	    End
 End Try  
 Begin Catch  
	 Exec usp_GetErrorInfo  
 End Catch  
End  
Go