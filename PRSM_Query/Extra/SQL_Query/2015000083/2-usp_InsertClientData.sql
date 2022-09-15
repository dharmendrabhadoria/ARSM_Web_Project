
  --EXEC [dbo].[usp_InsertClientData] 2015000083
Alter Procedure [dbo].[usp_InsertClientData]
(
@n_WorkOrderNo int 
)
As      
Begin      
 Declare @n_WareHouseId  TinyInt,      
   @n_BOXFILE_STATUS  SmallInt ,      
   @n_ModifiedBy   SmallInt ,      
   @n_WORKORDER_STATUS  SmallInt ,      
   @ACTIVITY_STATUS   SmallInt;      
          
  Select @n_WareHouseId =  n_WareHouseId      
  From tbl_WareHouseMaster      
  Where s_WarehouseName like 'Bhiwandi%'      
  If(Isnull(@n_WareHouseId,0)=0)      
  Begin      
  Select 'WareHouse'      
  Return;      
  End     
  Print @n_WareHouseId;  
        
  Select      
    @n_BOXFILE_STATUS  = n_AppCodeId      
  From tbl_ApplicationCodeMaster       
  Where s_AppCode = 'BOXFILE_STATUS'       
     And       
     s_AppCodeName = 'In'      
     Print @n_BOXFILE_STATUS
     
 Select       
   @n_WORKORDER_STATUS  = n_AppCodeId      
 From tbl_ApplicationCodeMaster       
 Where s_AppCode = 'WORKORDER_STATUS'       
     And       
     s_AppCodeName = 'Open'      
     print @n_WORKORDER_STATUS
           
     Select      
     @ACTIVITY_STATUS  = n_AppCodeId      
  From  tbl_ApplicationCodeMaster       
  Where s_AppCode = 'ACTIVITY_STATUS'       
     And       
     s_AppCodeName = 'Open'     
     print @ACTIVITY_STATUS 
              
   Set @n_ModifiedBy = (Select top 1      
        n_UserId       
      From tbl_UserMaster )      
      
      print @n_ModifiedBy
      
 /*Genrate  Work Order */      
  Create Table #CustomerList(Id Int Identity(1,1),n_CustomerId Int ,n_PickupAddressId Int)      
  Insert Into #CustomerList( n_CustomerId  ,n_PickupAddressId )      
  Select  Distinct TC.n_CustomerId,      
       TP.n_PickupAddressId       
  From  tbl_Customer TC      
     Inner  Join      
        TempData  T  On  Rtrim(Ltrim(TC.s_CustomerName)) =  Rtrim(Ltrim(T.[CLIENTNAME]))      
     Left Join       
 (Select      
        MIN(n_PickupAddressId ) As n_PickupAddressId,      
        n_CustomerId      
  From tbl_PickupAddress Group by n_CustomerId  )  As TP  On TC.n_CustomerId = TP.n_CustomerId       
 Declare @CustCount   Int      
 Declare @n_CustomerId Int      
    Declare @n_PickupAddressId Int  
    Select * From #CustomerList    
     /*     
       Declare @n_ActivityId SmallInt,@n_ActivityId1 SmallInt,@n_ActivityId2 SmallInt;      
       Select @n_ActivityId = n_ActivityId    From tbl_Activity Where s_ActivityName = 'New Standard Box Cost (1.50 Cubic Ft.)'      
       Select @n_ActivityId1 = n_ActivityId    From tbl_Activity Where s_ActivityName = 'Bar-coding & Data Entry (File & Box)'      
       Select @n_ActivityId2 = n_ActivityId    From tbl_Activity Where s_ActivityName = 'Standard Box Transportation'      
       Select Isnull(@n_ActivityId,0)      
      
   Create Table #TempActivitylist      
     ( SrNo   Int Identity(1,1), ActivityId SmallInt,      
       ActivityStatus  SmallInt   ,  Remark  Varchar(5),      
       NoOfBox   SmallInt   , NoOfFile SmallInt  ,      
       WorkOrderNo  Int     , UserId  Int  )      
            
            
    Insert Into #TempActivitylist(ActivityId   ,ActivityStatus   ,Remark,NoOfBox,NoOfFile,WorkOrderNo,UserId)        
    Select   @n_ActivityId ,@ACTIVITY_STATUS ,''  ,  0      ,0   , 0   ,@n_ModifiedBy       
    Union        
    Select   @n_ActivityId1 ,@ACTIVITY_STATUS ,''  ,  0      ,0   , 0   ,@n_ModifiedBy       
    Union      
    Select   @n_ActivityId2 ,@ACTIVITY_STATUS ,''  ,  0      ,0   , 0   ,@n_ModifiedBy         
            
     DECLARE @xmldataActivity XML      
     SET @xmldataActivity = (Select SrNo,ActivityId   ,ActivityStatus   ,Remark,NoOfBox,NoOfFile,WorkOrderNo,UserId      
     From  #TempActivitylist  FOR XML PATH ('Root'))      
     --Select @xmldata      
     Declare @Activitylist Varchar(Max)      
     Set @Activitylist = '<NewDataSet>'+CONVERT(Varchar(Max),@xmldataActivity) +'</NewDataSet>'       
          
          
 Set  @CustCount = 1                
    While(@CustCount < = (Select Isnull(COUNT(*),0) From #CustomerList ))                
    Begin      
              
              
        Select @n_CustomerId = n_CustomerId  From #CustomerList Where Id = @CustCount      
        Select @n_PickupAddressId = n_PickupAddressId  From #CustomerList Where Id = @CustCount      
        Declare @Date DateTime      
        Select @Date =GETDATE()      
              
  Exec usp_InsertUpdateWorkOrder   0,      
          @Date,      
          @n_CustomerId,      
          '',      
          @n_WareHouseId,     
          @n_PickupAddressId,      
          @Activitylist,      
          @ACTIVITY_STATUS,      
          @n_WORKORDER_STATUS,      
          @n_ModifiedBy      
                 
  Set @CustCount = @CustCount+ 1                
  End      */
 -------------------------------------Insert Work Order With Activity Completed--------------------------------------      
       
 --================================================Add Box Details==================================================      
 Set  @CustCount = 1                
    While(@CustCount < = (Select Isnull(COUNT(*),0) From #CustomerList ))                
    Begin      
           
   Select @n_CustomerId = n_CustomerId  From #CustomerList Where Id = @CustCount      
   Select @n_PickupAddressId = n_PickupAddressId  From #CustomerList Where Id = @CustCount      
            
  Create Table #TempBOXD (BoxId Int  ,BoxBarCode Varchar(25),BoxLocId Int, BoxLocCode  Varchar(25))      
  Insert Into #TempBOXD ( BoxId,     BoxBarCode ,BoxLocId ,BoxLocCode)      
    Select Distinct 0,       
    T.[BOX BARCODE] ,      
     1,      
    T.LOCATION       
    From   tbl_Customer TC       
    Inner  Join      
     TempData  T  On  Rtrim(Ltrim(TC.s_CustomerName)) =  Rtrim(Ltrim(T.[CLIENTNAME]))      
     Where TC.n_CustomerId = @n_CustomerId       
     Select T.*,'BoxDetails' From #TempBOXD T      
    DECLARE @xmldata XML      
    Declare @n_WoActivityId Int       
          
    --Select 1 SrNo ,  BoxBarCode,BoxLocId,BoxLocCode From      
    --    #TempBOXD Where BoxBarCode Is not Null      
          
    SET @xmldata = (Select 1 As SrNo, 1 As BoxId,  BoxBarCode,BoxLocId,BoxLocCode From      
        #TempBOXD Where BoxBarCode Is not Null  FOR XML PATH ('Root'))      
    Select @xmldata      
    Declare @BoxXml Varchar(Max)      
    Set @BoxXml = '<NewDataSet>'+CONVERT(Varchar(Max),@xmldata) +'</NewDataSet>'          
    Select @BoxXml      
    --Declare @n_WorkOrderNo Int       
   --Set @n_WorkOrderNo =  (Select Top 1 n_WorkorderNo      
   --From tbl_WorkOrder      
   -- Where n_CustomerId = @n_CustomerId And n_WorkOrderNo In(2015000082) Order by n_WorkorderNo desc )      
    Select  top 1 @n_WoActivityId = n_WoActivityId  From tbl_WoActivities   Inner Join tbl_Activity TA On tbl_WoActivities.n_ActivityId = TA.n_ActivityId      
    Where n_WorkOrderNo In(@n_WorkOrderNo)      
         And       
         n_ActivityStatus = @ACTIVITY_STATUS  
         and
         TA.s_ActivityName = 'New Standard Box Cost (1.50 Cubic Ft.)'
       Order by n_WoActivityId desc      
       If(Isnull(@n_WoActivityId,0) !=0)      
       Begin      
       Exec usp_InsertUpdateBoxDetails   @n_CustomerId,@n_WareHouseId,@BoxXml,@n_WoActivityId,@n_ModifiedBy,0      
       End      
          
     Create Table #TempFileDetails ( SrNo Int Identity(1,1),FileId Int  ,BoxBarCode Varchar(50),FileBarCode Varchar(50),      
             sFileName  Varchar(255),DepartmentId Int ,sYear Varchar(30), FromDate DateTime ,EndDate DateTime,      
             Label1 Varchar(500)   ,  Label2 Varchar(500),Label3 Varchar(500))      
   Insert Into #TempFileDetails(FileId,BoxBarCode,FileBarCode,sFileName,DepartmentId,sYear,FromDate,EndDate,Label1,Label2,Label3)                
       Select Distinct  0,      
         T.[BOX BARCODE] ,      
           T.[FILE BARCODE] ,      
           ''    ,      
           Isnull(T.DeptId ,(Select Top 1 n_AppCodeId       
                 From tbl_ApplicationCodeMaster      
              Where s_AppCode='DEPARTMENT' )),       
         T.[YEAR] ,       
        T.[FROM DATE],      
        T.[TO DATE],      
        '',      
        '',      
        ''      
                
     From   TempData As T      
       Left  Join      
       tbl_ApplicationCodeMaster TAD   On Rtrim(Ltrim(T.DEPT)) = Rtrim(Ltrim(TAD.s_AppCodeName))        
       Inner  Join      
        tbl_Customer TC    On  Rtrim(Ltrim(TC.s_CustomerName)) =  Rtrim(Ltrim(T.[CLIENTNAME]))      
     Where TC.n_CustomerId = @n_CustomerId      
       ANd T.[BOX BARCODE] Is not null            
       And  T.[FILE BARCODE] Is not null       
           
    --Select * From #TempFileDetails      
      DECLARE @xmldataFile XML      
     SET @xmldataFile = (Select SrNo,FileId,BoxBarCode,FileBarCode,sFileName,DepartmentId,sYear,FromDate,EndDate,Label1,Label2,Label3      
     From      
         #TempFileDetails Where BOXBARCODE Is not Null And FileBarCode Is Not Null  FOR XML PATH ('Root'))      
     --Select @xmldata      
     Declare @FileXml Varchar(Max)      
     Set @FileXml = '<NewDataSet>'+CONVERT(Varchar(Max),@xmldataFile) +'</NewDataSet>' 
     Select  top 1 @n_WoActivityId = n_WoActivityId  From tbl_WoActivities    Inner Join tbl_Activity TA On tbl_WoActivities.n_ActivityId = TA.n_ActivityId     
    Where n_WorkOrderNo In(@n_WorkOrderNo)      
         And       
         n_ActivityStatus = @ACTIVITY_STATUS  
          and
         TA.s_ActivityName = 'Bar-coding & Data Entry (File & Box)'       
     exec usp_InsertUpdateFileDetails  @n_CustomerId,@n_WareHouseId,@FileXml,@n_WoActivityId,@n_ModifiedBy,0      
    Drop Table #TempFileDetails      
    Drop Table #TempBOXD 
    Select @FileXml     
          
 Set @CustCount = @CustCount+ 1                
    End      
     Update  tbl_FileDetails Set s_FileName = T.[FILE NAME 1] ,      
         s_Label1   = T.[LABLE 1 ( FILE TYPE )]      
     From  tbl_FileDetails TF       
   -- Inner join       
     --tbl_BoxDetails  TB On TF.n_BoxId = TB.n_BoxId        
      Inner Join      
     TempData T On TF.s_FileBarCode = T.[FILE BARCODE]  --And T.[BOX BARCODE] = TB.s_BoxBarCode       
                               
End      

