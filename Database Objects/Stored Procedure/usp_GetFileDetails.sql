/*
SP Name       : usp_GetFileDetails
Purpose       : This stored procedure is used to get the Box Details.
Created By    : Rajendra Pawar
Creation Date : 23 August 2014

*/

If Exists (Select 1 From sysobjects Where Type = 'P' AND  name = 'usp_GetFileDetails')
Begin
	Drop Procedure usp_GetFileDetails
End
Go
Create Procedure usp_GetFileDetails  
(
@pn_FileId		 Int, 	
@pn_CustomerId   Int,
@pn_WareHouseId  TinyInt,
@pn_Status		 SmallInt ,
@ps_FileBarCodes Varchar(4000)
)    
As  
Begin    
 SET NOCOUNT ON  
   
    Create Table #tempFile1(FileCode Varchar(16))
	Insert INto #tempFile1(FileCode)
	Select * from [dbo].[str_Split](@ps_FileBarCodes,',')
   
  Select distinct  FO.n_FileId   As 'FileId'                ,  BO.s_BoxBarCode     As 'BoxBarCode'      ,   
   FO.s_FileBarCode              As 'FileBarCode'           ,  BO.n_CustomerId     As 'CustomerId'      ,
   FO.s_Year                     As 'Year'                  ,  FO.d_FromDate       As 'FromDate'        ,
   FO.d_EndDate                  As 'Todate'                ,  bo.s_LocationCode   As 'LocationCode'    ,
   BO.n_WareHouseId              As 'WareHouseId'           ,  FO.s_Label1         As 'Label1'          ,
   FO.s_Label2                   As 'Label2'                ,  FO.s_Label3         As 'Label3'          ,
   FO.n_Status                   As 'FileStatus'            ,  ACM.s_AppCodeName   As 'FileStatusName'  ,  
   TC.s_CustomerName             As 'CustomerName'          ,    
   TWM.s_WarehouseName           As 'WareHouseName'         ,  TWM.s_WarehouseCode As 'WareHouseCode'   ,
   AM.s_AppCodeName              AS 'Department'             , fo.s_FileName              As 'FileName'
  Into #Temp From tbl_FileDetails FO   
          Inner Join   
        tbl_BoxDetails BO On FO.n_BoxId   = BO.n_BoxId   
          Inner Join    
       tbl_Customer TC On BO.n_CustomerId = TC.n_CustomerId  
          Inner Join   
       tbl_WareHouseMaster TWM On BO.n_WareHouseId = TWM.n_WareHouseId      
          Inner Join    
       tbl_ApplicationCodeMaster ACM On ACM.n_AppCodeId = FO.n_Status  
         Inner Join 
       tbl_ApplicationCodeMaster AM On AM.n_AppCodeId = FO.n_DepartmentId  
       
  Where  FO.n_FileId    = Case @pn_FileId        When  0 Then FO.n_FileId            Else  @pn_FileId End  
       And  
   BO.n_CustomerId   = Case @pn_CustomerId             When  0 Then BO.n_CustomerId        Else  @pn_CustomerId End       
       And   
   TWM.n_WareHouseId = Case @pn_WareHouseId            When  0 Then TWM.n_WareHouseId      Else  @pn_WareHouseId End  
             And   
   FO.n_Status       = Case @pn_Status                 When  0 Then FO.n_Status         Else  @pn_Status End               
        
  If( Rtrim(ltrim(@ps_FileBarCodes)) <>'')
  Begin
  Select * From #Temp T Where FileBarCode In(Select Rtrim(ltrim(FileCode))  From #tempFile1 )
  End
  Else
  Begin
  Select * From #Temp
  End
  Drop table #Temp
  Drop tABLE #tempFile1
End    
  
Go


   
   