/*
SP Name: usp_InsertUpdateBoxDetails
Description: This procedure is used to Add/update in the tbl_boxDetails.  
Created By:  Ajay Tiwari
Creation Date: 23 August 2014
Alter by : Rajendra pawar 
Alter Date : 03 Nov -2014
Reason : Added transaction 
*/

If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_InsertUpdateBoxDetails') 
Begin
   Drop Procedure usp_InsertUpdateBoxDetails
End 
Go

CREATE Procedure usp_InsertUpdateBoxDetails  
(  
  @pn_CustomerId       Int         ,       
  @pn_WareHouseId      TinyInt       ,      
  @ps_xmlBoxLabel      Varchar(max)  ,  
  @pn_WoActivityId   Int   ,   
  @pn_ModifiedBy       SmallInt  ,  
  @IsNew      Bit   --0 = New 1 = Update  
)  
As    
Begin    

 SET NOCOUNT ON    
 Begin Tran
 Begin Try  
   
  Create Table #tempBoxLabel  
  (   Id         Int Identity(1,1) Not Null ,   
   BoxBarCode     Varchar(16)       Null     ,    
   BoxId          Int               Null     ,          
   BoxLocCode     Varchar(15)       Null     ,        
   boxStatus      SmallInt)   
     
  Declare @docHandle Int;    
  Exec sp_xml_preparedocument @docHandle Output, @ps_xmlBoxLabel;    
  Insert Into #tempBoxLabel Select * From OpenXml(@docHandle, '/NewDataSet/Root',2) With #tempBoxLabel   
  Exec sp_xml_removedocument @docHandle;  
    
 If(@IsNew = 0)   
 Begin  
  Declare @BoxStatus  SmallInt  
  Select  @BoxStatus = n_AppCodeId  From tbl_ApplicationCodeMaster Where s_AppCode = 'BOXFILE_STATUS' And s_AppCodeName ='In'   
  --Result for duplicate box code   
  Create Table #resultduplicate(BoxId Int, BoxBarCode varchar(16),BoxLOcation varchar(15),Result varchar(100))  
  Insert into #resultduplicate(BoxId,BoxBarCode,BoxLOcation ,Result)  
  Select TB.n_BoxId,  
      TB.s_BoxBarCode As 'BoxBarCode',  
      Tb.s_LocationCode  'LocationCode',  
      'Box already exist'    
  From  tbl_BoxDetails  TB   
  Right Join   
  #tempBoxLabel T      on  
  TB.s_BoxBarCode  = T.BoxBarCode   
  Where Isnull(TB.n_BoxId,0) != 0  
  /*Insert into #resultduplicate(BoxId,BoxBarCode,BoxLOcation ,Result)  
  Select Isnull(TB.n_BoxId,0),    
      T.BoxBarCode  As 'BoxBarCode',  
      TB.s_BoxLocationCode 'LocationCode',  
      'Location already mapped'    
  From  tbl_MapBoxLocation  TB   
  Right Join   
  #tempBoxLabel T      on  
  TB.s_BoxLocationCode  = T.BoxLocCode   
  Where Isnull(TB.n_BoxId,0) != 0*/  
    
  --Result for duplicate loc code   
    
  Insert Into tbl_BoxDetails  
     (s_BoxBarCode        ,  s_LocationCode    ,    
      n_CustomerId        ,  n_WareHouseId     ,  
      n_Status            ,  d_ModifiedDate    ,  
      n_ModifiedBy)   
  
  Select T.BoxBarCode      ,   
        T.BoxLocCode       ,   @pn_CustomerId ,   
        @pn_WareHouseId   ,   @BoxStatus     ,  
      GetDate()       ,   @pn_ModifiedBy  
     From #tempBoxLabel T  
           Left Join   
   tbl_BoxDetails TB  On  TB.s_BoxBarCode  = T.BoxBarCode  
    Where T.BoxBarCode  Not In( Select BoxBarCode From #resultduplicate)   
    
    
  Insert Into tbl_MapBoxLocation(n_BoxId  , s_BoxLocationCode)     
  Select TB.n_BoxId,TB.s_LocationCode     
  From #tempBoxLabel T  
           Inner Join   
  tbl_BoxDetails TB  On  TB.s_BoxBarCode  = T.BoxBarCode  
  Where T.BoxBarCode  Not In( Select BoxBarCode From #resultduplicate)   
      
      
   Insert Into tbl_BoxTransactions(n_BoxId , n_WoActivityId    ,  d_ModifiedDate    ,n_ModifiedBy)  
      Select distinct  n_BoxId     AS 'BoxId'    , @pn_WoActivityId   ,  GETDATE()   ,@pn_ModifiedBy     
      From tbl_BoxDetails TB  
   Inner Join   
   #tempBoxLabel  T On TB.s_BoxBarCode  = T.BoxBarCode    
   Where T.BoxBarCode  Not In( Select BoxBarCode From #resultduplicate)   
   Select distinct  BoxBarCode,BoxLOcation ,Result From #resultduplicate  
  End  
  Else  
  Begin  
    
  Update  tbl_BoxDetails  
   Set   
   n_Status         = boxStatus     ,  
   d_ModifiedDate   = GETDATE()     ,  
   n_ModifiedBy     = @pn_ModifiedBy  
   From tbl_BoxDetails TBD   
     Inner join   
   #tempBoxLabel T  
   On TBD.n_BoxId = T.BoxId
     
  ---Delete box location code from tbl_MapBoxLocation  
  Declare @PermanentOutSttaus  SmallInt  
  Select  @PermanentOutSttaus = n_AppCodeId  From tbl_ApplicationCodeMaster Where s_AppCode = 'BOXFILE_STATUS' And s_AppCodeName ='PERMANENT OUT'   
  ---Print @PermanentOutSttaus  
  -- update box location code by null in case of PermanentOutSttaus  
  Update  tbl_BoxDetails  
  Set   
  s_LocationCode  = Case When n_Status = @PermanentOutSttaus Then null   
                    Else      s_LocationCode   End  
  From tbl_BoxDetails TBD   
     Inner join   
   #tempBoxLabel T  On  
   TBD.n_BoxId = T.BoxId   
     
  Delete TMBLC From tbl_MapBoxLocation TMBLC   
     Left Join    
  tbl_BoxDetails TBxD On   
  TMBLC.n_BoxId=TBxD.n_BoxId  
     Inner Join   
  #tempBoxLabel T     On   
  TBxD.n_BoxId = T.BoxId    
  Where  TBxD.n_Status=@PermanentOutSttaus  
       
  Update  tbl_FileDetails  
   Set   
   n_Status           = boxStatus   ,  
   d_ModifiedDate     = GETDATE()   ,  
   n_ModifiedBy       = @pn_ModifiedBy  
   From tbl_FileDetails TFD   
   Inner join   
      tbl_BoxDetails  TBD  On TFD.n_BoxId = TBD.n_BoxId   
   Inner join   
   #tempBoxLabel T  
   On TFD.n_BoxId = T.BoxId   
     
   Insert Into tbl_BoxTransactions   (n_BoxId     ,n_WoActivityId   , d_ModifiedDate    ,n_ModifiedBy)  
   Select    n_BoxId AS 'BoxId' ,@pn_WoActivityId ,GETDATE()   ,@pn_ModifiedBy     
   From  tbl_BoxDetails TB  
             Inner Join  
   #tempBoxLabel  T   On   
   T.BoxId = TB.n_BoxId   
     
  End  
      Drop table #tempBoxLabel  
      Commit Tran
 End Try    
 Begin Catch   
 Rollback  Tran 
 Exec usp_GetErrorInfo    
 End Catch                                     
End  