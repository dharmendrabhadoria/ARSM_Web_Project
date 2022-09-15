/*
SP Name       : usp_GetServiceCategory
Purpose       : This stored procedure is used to get the service category.
Created By    : Rajendra Pawar
Creation Date : 04 July 2014
*/
If Exists (Select 1 From sysobjects Where Type = 'P' AND  name = 'usp_GetServiceCategory')
Begin
	Drop Procedure usp_GetServiceCategory
End
Go

Create Procedure usp_GetServiceCategory
(
 @pn_ServiceCategoryId TinyInt  
)  
As
Begin
 SET NOCOUNT ON
 Select n_ServiceCategoryId As 'ServiceCategoryId' , s_SCName  As 'SCName' ,
        s_Remark			As 'Remark'            , b_IsEdit  As 'IsEdit' ,
        n_UserId			As 'UserId'			   , n_DisplayOrder AS 'DisplayOrder'	
 From tbl_ServiceCategory
	Where n_ServiceCategoryId = Case  @pn_ServiceCategoryId
							    When  0 Then n_ServiceCategoryId
										Else @pn_ServiceCategoryId  End
	Order By n_DisplayOrder asc									
											  
End
Go