/*
SP Name: usp_InsertUpdateContractMaster
Description: This procedure is used to Add/update in the tbl_ContarctMaster.  
Created By:  Vipul
Creation Date: 23 July 2014
*/
If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_InsertUpdateContractMaster') 
Begin
   Drop Procedure usp_InsertUpdateContractMaster
End 
Go
Create Procedure usp_InsertUpdateContractMaster
(
	@pn_ContractId			Int,
	@pn_ContractNo			Int,
	@pn_CustomerId			SmallInt,
	@pd_FromDate			DateTime,
	@pd_EndDate				DateTime,
	@ps_Remark 				Varchar(250),
	@pn_UserId				SmallInt,
	@ps_DocumentName        Varchar(50),
    @ps_Filepath            Varchar(250)
)
As
Begin  
 SET NOCOUNT ON  
 Begin Try
	If (@pn_ContractId = 0)
		Begin					
			Insert Into tbl_ContractMaster
				(n_ContractNo     ,			n_CustomerId  ,		d_FromDate     , d_EndDate       ,				
				  s_Remark        ,			n_UserId      ,		d_ModifiedDate , s_DocumentName ,
				  s_Filepath) 
			Values
				(@pn_ContractNo   ,		@pn_CustomerId    ,	    @pd_FromDate  ,	@pd_EndDate      ,	    
				 @ps_Remark       ,			@pn_UserId    ,		GETDATE()     , @ps_DocumentName ,
				 @ps_Filepath)			
		End
	Else
		Begin		
			Update tbl_ContractMaster
				Set n_ContractNo			=   @pn_ContractNo,
					n_CustomerId			=	@pn_CustomerId,
					d_FromDate				=	@pd_FromDate,				
					d_EndDate	    		=	@pd_EndDate,
					s_Remark				=   @ps_Remark,	
					d_ModifiedDate			=	GETDATE(),				
					n_UserId	     		=	@pn_UserId,
					s_DocumentName          =   @ps_DocumentName,
					s_Filepath              =   @ps_Filepath				
				Where n_ContractId			=	@pn_ContractId	
		End
 End Try  
 Begin Catch  
 Exec usp_GetErrorInfo  
 End Catch                                   
End
Go