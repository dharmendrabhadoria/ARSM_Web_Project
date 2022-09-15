--exec usp_GetPageFunctionalityByRoleAndPageId 81,1
/*
SP Name: usp_GetPageFunctionalityByRoleAndPageId
Created By:  Rajendra Pawar
Creation Date: 10 Sept 2014
*/
If Exists (Select 1
           From   sysobjects
           Where  Type = 'P'
                  And name = 'usp_GetPageFunctionalityByRoleAndPageId')
    Begin
        Drop Procedure usp_GetPageFunctionalityByRoleAndPageId;
    End


Go 
Create Procedure usp_GetPageFunctionalityByRoleAndPageId    
(    
 @pn_PageId Int ,    
 @pn_RoleId Int    
)      
As      
Begin      
 SET NOCOUNT ON    
 Select APC.s_AppCodeName  As  'PageName'    , PF.n_PageId       As 'PageId'   ,     
     PF.n_PageFunctionId  As 'PageFunctionId'   , PF.s_Functionality  As 'Functionality'  ,    
     PF.b_Enable   As   'Enable'     , Isnull(TR.n_Enable,0)             As  'IsEnableForRole'     
 From tbl_ApplicationCodeMaster APC     
   Inner Join tbl_PageFunctionality  PF    
        On APC.n_AppCodeId  = PF.n_PageId          
   Left Join tbl_RoleWiseAccess TR    
                 On PF.n_PageFunctionId =  TR.n_PageFunctionId     AND    TR.n_RoleId = @pn_RoleId       
 Where APC.s_AppCode = 'Page_Name'        
    And    
   PF.b_IsMenu = 0      
    And    
   PF.n_PageId = @pn_PageId         
    --And    
       --  TR.n_RoleId = @pn_RoleId    
End 
GO


