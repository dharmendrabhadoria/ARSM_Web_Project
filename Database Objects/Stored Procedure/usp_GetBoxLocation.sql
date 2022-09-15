
/*
SP Name: usp_GetBoxLocation
Description: This procedure is used to get box location
Created By:  Rajendra Pawar
Creation Date: 22 Sept 2014
Alter Date 30-Oct 2014
Alter Reason- Added parameters @ps_BoxLocationCode ,@pn_CustomerId ,@pn_CompanyGroupId for filtering
*/
If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_GetBoxLocation') 
Begin
   Drop Procedure usp_GetBoxLocation
End 
Go

Create Procedure usp_GetBoxLocation  
(@pn_WareHouseId  TinyInt    ,  
 @ps_BoxLocationCode Varchar(15),  
 @pn_CustomerId   Int     ,   
 @pn_CompanyGroupId  SmallInt   
)  
As    
Begin    
  Set NoCount On   
   Select  TBD.n_BoxId      As 'BoxId'     ,  
     TBD.s_BoxBarCode         As 'BoxBarCode',    
              TMBL.s_BoxLocationCode   As 'BoxLocationCode',  
              TBD.n_WareHouseId     As 'WareHouseId'     ,  
              TBD.n_CustomerId     As 'CustomerId'    ,  
              TC.n_CompanyGroupId    As 'CompanyGroupId'   
      From tbl_boxdetails TBD    
    Inner Join   
        tbl_MapBoxLocation TMBL On TBD.n_BoxId=TMBL.n_BoxId  
    Inner Join   
        tbl_Customer TC  On TC.n_CustomerId = TBD.n_CustomerId       
   Inner Join   
        tbl_CompanyGroup TCG  On TC.n_CompanyGroupId = TCG.n_CompanyGroupId       
      Where   
        TBD.n_WareHouseId =    Case  @pn_WareHouseId    When 0 Then TBD.n_WareHouseId    Else   @pn_WareHouseId  End    
            And  
        TCG.n_CompanyGroupId = Case @pn_CompanyGroupId  When 0 Then TCG.n_CompanyGroupId  Else  @pn_CompanyGroupId End  
      And  
        TBD.n_CustomerId = Case @pn_CustomerId  When 0 Then TBD.n_CustomerId Else @pn_CustomerId End  
      And  
  Rtrim(ltrim(Isnull(TMBL.s_BoxLocationCode,''))) = Case Isnull(@ps_BoxLocationCode,'')  
               When '-1'   Then TMBL.s_BoxLocationCode   
                Else  
                  @ps_BoxLocationCode End     
        
                    
End  
GO





