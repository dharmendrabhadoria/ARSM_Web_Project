/*
SP Name       : usp_GetErrorInfo
Purpose       : To select error information
Created By    :	Rajendra Pawar
Creation Date : 3- July-2014
*/

If Exists (Select 1 From sysobjects Where type = 'P' AND  name = 'usp_GetErrorInfo')
Begin
	Drop Procedure usp_GetErrorInfo
End
Go

Create Procedure usp_GetErrorInfo
As
SET NOCOUNT ON  
Select
	 ERROR_NUMBER()		AS ErrorNumber,
     ERROR_SEVERITY()	AS ErrorSeverity,
     ERROR_STATE()		AS ErrorState,
     ERROR_PROCEDURE()	AS ErrorProcedure,
     ERROR_LINE()		AS ErrorLine,
     ERROR_MESSAGE()	AS ErrorMessage
Go