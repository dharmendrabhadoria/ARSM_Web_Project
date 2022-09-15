
/*
SP Name: usp_GenrateLocation
Description: This Procedure is used to Genrate location by Rowise.  
Created By:  RajEndra Pawar
Creation Date: 24 Feb 2015
*/
IF EXISTS (Select 1
           From    sysobjects
           Where   Type = 'P'
                  AND name = 'usp_GenrateLocation')
    Begin
        DROP Procedure usp_GenrateLocation;
    End
Go

Create Procedure usp_GenrateLocation
(
 @pn_RowId SmallInt
 )
AS
Begin
    Set NOCOUNT ON;
 If  Exists (Select 1 From tbl_LocationMaster Where n_RowId = @pn_RowId) 
Begin
Select 'Record already exist for selected row' As 'AlreadyExistMessage'
End
Else
Begin
	
	Begin TRY
		Create Table #TempLocation(s_LocationCode Varchar(16))
		Declare @RowId Int 
		
		Declare @RowName  Char(2)
		Declare @n_NoofShelf SmallInt
		Declare @n_NoOfLocationPerSelf SmallInt
		Select 
				@RowId		 = n_RowId     ,@RowName				= s_RowName,
				@n_NoofShelf = n_NoofShelf ,@n_NoOfLocationPerSelf  = n_NoOfLocationPerSelf
		From tbl_RowMaster Where n_RowId = @pn_RowId
		
		Declare  @Counter  Int
		Declare  @InnerCounter  Int
		Set @Counter = 1;
		Set @InnerCounter = 1;

		 While((Select @Counter) <= @n_NoofShelf)
		 Begin
			 Set @InnerCounter = 1;
				 While(@InnerCounter < = @n_NoOfLocationPerSelf)
				 Begin 
						  Declare @LocationNum Varchar(8)
						  Set @LocationNum = 
						   @RowName+'-'+ 
									   Case  Len(@Counter) 
															When 1 Then '0'+ CONVERT(Varchar(2),@Counter) 
															Else   CONVERT(Varchar(2),@Counter)  End
									 +
									   Case  Len(@InnerCounter) When 1	 Then '00'+ CONVERT(Varchar(2),@InnerCounter) 
																When 2	 Then '0'+ CONVERT(Varchar(2),@InnerCounter)  
																Else  CONVERT(Varchar(2),@InnerCounter)  End
								 Insert Into #TempLocation(s_LocationCode) Values(@LocationNum)
								 
					  Set @InnerCounter = @InnerCounter + 1 
				 End
			 Set @Counter = @Counter +1 
		 End
		
		  ----MaxBoxCount always Set  9------------
			   INSERT INTO  tbl_LocationMaster
				   ( n_RowId
				   , s_LocationCode
				   , n_BoxCount
				   , n_MaxBoxCount)
			 Select
					 @RowId,
					 s_LocationCode,
					 0,
					 9 
			 From 
			   #TempLocation
			End TRY
			Begin CATCH
				EXECUTE usp_GetErrorInfo ;
			End CATCH
	End		
End
Go

