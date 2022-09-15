/*
SP Name: usp_InsertUpdateWareHouseMaster

Description: This procedure is used to Add/update in the tbl_RowMaster.  
Created By:  Sunil Pandey
Creation Date: 25 Feb 2015
*/
If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_InsertUpdateRowMaster') 
Begin
   Drop Procedure usp_InsertUpdateRowMaster
End 
Go

Create Procedure usp_InsertUpdateRowMaster
(
	@pn_RowId		          Smallint,
	@ps_RowName   	          Char(2),
	@pn_WareHouseId	          TinyInt,
	@pn_NoofShelf             SmallInt,
	@pn_NoOfLocationPerSelf   SmallInt,
	@ps_Remark                Varchar(100),
	@pn_UserId		          Smallint
)
As  
Begin  
 SET NOCOUNT ON  
 Begin Try
	 If(@pn_RowId = 0)
		Begin
			Insert Into tbl_RowMaster
				   (s_RowName ,			n_WareHouseId,
				    n_NoofShelf,        n_NoOfLocationPerSelf,
				    s_Remark ,       	n_UserId,			
				    d_ModifiedDate)
			Values
				   (@ps_RowName,		@pn_WareHouseId,
				   @pn_NoofShelf,       @pn_NoOfLocationPerSelf,
				   @ps_Remark,       	@pn_UserId,	GETDATE())  
		End
	 Else
		Begin
			Update  tbl_RowMaster
				Set s_RowName		      =	@ps_RowName,
					n_WareHouseId		  =	@pn_WareHouseId,
					n_NoofShelf           = @pn_NoofShelf,
					n_NoOfLocationPerSelf = @pn_NoOfLocationPerSelf,
					s_Remark              = @ps_Remark, 
					n_UserId		      =	@pn_UserId,
					d_ModifiedDate	      =	GETDATE()
			Where	n_RowId	              =	@pn_RowId
		End
 End Try  
 Begin Catch  
 Exec usp_GetErrorInfo  
 End Catch                                   
End
Go