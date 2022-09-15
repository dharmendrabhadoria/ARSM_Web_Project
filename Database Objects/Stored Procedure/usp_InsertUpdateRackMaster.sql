/*
SP Name: usp_InsertUpdateRackMaster
Description: This procedure is used to Add/update in the tbl_RackMaster.  
Created By:  Vipul
Creation Date: 14 July 2014
vikas verma: (19 August 2014) Altered RackName to RowName and added one parameter @pn_NoofRacks   
*/
If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_InsertUpdateRackMaster') 
Begin
   Drop Procedure usp_InsertUpdateRackMaster
End 
Go

Create Procedure usp_InsertUpdateRackMaster
(
	@pn_RackId		            SmallInt,
	@ps_RowName					VarChar(50),
	@pn_WareHouseId				SmallInt,
	@pn_NoofShelf			    SmallInt,
	@pn_NoofBoxesPerShelf		SmallInt,
	@pn_BoxStartNo		        Int,
	@pn_NoofRacks		        Int     ,
	@ps_Remark			        VarChar(200),
	@pn_Height			        Decimal(5,2),
	@pn_Width			        Decimal(5,2),
	@pn_Depth		            Decimal(5,2),
	@pn_UserId					SmallInt,
	@pn_IsRackExist				Int output,
	@pn_BoxEndNo				Int		  ,	
	@pn_RowId					TinyInt
)
As  
Begin
  
 SET NOCOUNT ON
 BEGIN TRANSACTION;
 Begin Try 
	If(@pn_RackId = 0)
		Begin
			If Exists (Select 1 From tbl_RackMaster Where s_RowName	=	@ps_RowName)
				Begin
					Set @pn_IsRackExist	=     -1
				End
			Else
				Begin
					 Insert Into tbl_RackMaster
						(s_RowName,		n_WareHouseId,		n_NoofShelf,	n_NoofBoxesPerShelf,	
						 n_BoxStartNo,		s_Remark,			n_Height,		n_Width  ,			
						 n_Depth,			d_ModifiedDate,		n_UserId,    n_NoofRacks ,
						 n_RowId,			n_BoxEndNo)
					Values		
						(@ps_RowName,		@pn_WareHouseId,	@pn_NoofShelf,	@pn_NoofBoxesPerShelf,
						 @pn_BoxStartNo,	@ps_Remark,			@pn_Height,		@pn_Width,
						 @pn_Depth     ,	GETDATE() ,			@pn_UserId,     @pn_NoofRacks,
						 @pn_RowId     ,	@pn_BoxEndNo )
				 Set @pn_rackId = @@IDENTITY		 
				exec usp_InsertUpdateBoxLocation @pn_WareHouseId,@pn_rackId,  @pn_rowId  		 
						 
						 
				End
				
	   End
	Else
	  Begin
			If Exists ( Select 1 From tbl_RackMaster 
						Where s_RowName	=	@ps_RowName and n_RackId		!=	@pn_RackId)
				Begin
					Set @pn_IsRackExist	=     -1
				End
			Else
				Begin
					Update	tbl_RackMaster 
						Set s_RowName				 =		@ps_RowName,
							n_WareHouseId			 =		@pn_WareHouseId,	
							n_NoofShelf				 =		@pn_NoofShelf,
							n_NoofBoxesPerShelf		 =		@pn_NoofBoxesPerShelf, 	
							n_BoxStartNo			 =		@pn_BoxStartNo,
							s_Remark				 =		@ps_Remark,
							n_Height				 =		@pn_Height,
							n_Width					 =		@pn_Width,
							n_Depth					 =		@pn_Depth,		
							d_ModifiedDate			 =		GETDATE(),
							n_UserId				 =		@pn_UserId,
							n_NoofRacks              =      @pn_NoofRacks,
							n_RowId					 =		@pn_RowId	 ,
							n_BoxEndNo				 =		@pn_BoxEndNo 
					Where   n_RackId				 =		@pn_RackId
				End
	  End
	    COMMIT TRANSACTION;
 End Try  
 Begin Catch  
 
 Exec usp_GetErrorInfo  
 IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
 End Catch                                   
End
Go