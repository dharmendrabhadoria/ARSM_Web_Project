/*
SP Name: usp_InsertUpdateBoxLocation
Description: This Procedure is used to create the box location after row created for the warehouse.  
Created By:  RajEndra Pawar
Creation Date: 22 September 2014
*/
IF EXISTS (Select 1
           From    sysobjects
           Where   Type = 'P'
                  AND name = 'usp_InsertUpdateBoxLocation')
    Begin
        DROP Procedure usp_InsertUpdateBoxLocation;
    End
 
 
GO
Create Procedure usp_InsertUpdateBoxLocation
@pn_WareHouseId TinyInt, @pn_rackId SmallInt, @pn_rowId SmallInt
AS
Begin
    Set NOCOUNT ON;
    Begin TRY
		
        Declare   @n_BoxStartNo AS Int;
        Declare   @s_WareHouseId AS Char (2);
        Declare   @s_rowId AS Char (2);
        
        Select @s_WareHouseId = Convert(Char(2),@pn_WareHouseId)  , @s_rowId= Convert(Char(2),@pn_rowId) 
        IF ((Select len(@pn_WareHouseId)) <= 1)
            Begin
                Select @s_WareHouseId = '0' + Convert (Varchar (5), @pn_WareHouseId);
            End
        IF ((Select len(@pn_rowId)) <= 1)
            Begin
                Select @s_rowId = '0' + Convert (Varchar (5), @pn_rowId);
            End
        Declare   @n_NoofShelf AS SmallInt;
        Declare   @n_NoofBoxesPerShelf AS SmallInt;
        Declare   @n_NoofRacks AS Int;
        Declare   @Rackcount AS Int;
        Declare   @n_NoofShelfCount AS Int;
        Declare   @n_NoofBoxesPerShelfCount AS Int;
        Select @n_NoofRacks = n_NoofRacks,
               @n_NoofShelf = n_NoofShelf,
               @n_NoofBoxesPerShelf = n_NoofBoxesPerShelf,
               @n_BoxStartNo = n_BoxStartNo
        From    tbl_RackMaster
        Where   n_rackId = @pn_rackId
               AND n_WareHouseId = @pn_WareHouseId;
        Create Table #TemLocationCode(n_BoxLocationNo Int ,s_BoxLocationId Varchar(15)) 
        Set @Rackcount = 1;
        While (@Rackcount <= @n_NoofRacks)
            Begin
                Declare   @s_RackNo AS Varchar (3);
                Select @s_RackNo = Convert (Varchar (2), @Rackcount);    
                IF ((Select len(@Rackcount)) <= 1)
                    Begin
                        Select @s_RackNo = '0' + Convert (Varchar (2), @Rackcount);
                    End
                    
                Set @n_NoofShelfCount = 1;
                While (@n_NoofShelfCount <= @n_NoofShelf)
                    Begin
                        Declare   @s_ShelfNo AS Varchar (2);
                        Select @s_ShelfNo = Convert (Varchar (2), @n_NoofShelfCount);
                        IF ((Select len(@n_NoofShelfCount)) <= 1)
                            Begin
                                Select @s_ShelfNo = '0' + Convert (Varchar (2), @n_NoofShelfCount);
                            End
                            
                        Set @n_NoofBoxesPerShelfCount = 1;
                        While (@n_NoofBoxesPerShelfCount <= @n_NoofBoxesPerShelf)
                            Begin
                                Declare   @s_BoxNo AS Varchar (3);
                                IF ((Select len(@n_NoofBoxesPerShelfCount)) = 1)
                                    Begin
                                        Select @s_BoxNo = '00' + Convert (Varchar (2), @n_NoofBoxesPerShelfCount);
                                    End
                                IF ((Select len(@n_NoofBoxesPerShelfCount)) = 2)
                                    Begin
                                        Select @s_BoxNo = '0' + Convert (Varchar (3), @n_NoofBoxesPerShelfCount);
                                    End
                                Declare   @s_BoxLocationId AS Varchar (15);
                                Select @s_BoxLocationId = (@s_WareHouseId + @s_rowId + Convert (Varchar (2), @s_RackNo) + Convert (Varchar (2), @s_ShelfNo) + Convert (Varchar (3), @s_BoxNo));
                              
                                Insert Into #TemLocationCode (n_BoxLocationNo, s_BoxLocationId)
                                Select @n_BoxStartNo,
                                       @s_BoxLocationId;
                                Set @n_NoofBoxesPerShelfCount = @n_NoofBoxesPerShelfCount + 1;
                                Set @n_BoxStartNo = @n_BoxStartNo + 1;
                            End
                        Set @n_NoofShelfCount = @n_NoofShelfCount + 1;
                    End
                Set @Rackcount = @Rackcount + 1;
            End
      Insert Into tbl_BoxLocation(n_BoxLocationNo ,s_BoxLocationId,n_WareHouseId)      
        Select  n_BoxLocationNo,
				s_BoxLocationId,
				@pn_WareHouseId 
        From    #TemLocationCode;
    End TRY
    Begin CATCH
        EXECUTE usp_GetErrorInfo ;
    End CATCH
End


