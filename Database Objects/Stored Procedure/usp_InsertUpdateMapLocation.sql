/*
SP Name       : usp_InsertUpdateMapLocation
Purpose       : This stored procedure is used to add/update Page functionality with page.  
Created By    : Rajendra Pawar
Creation Date : 28 Aug 2014
*/

If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_InsertUpdateMapLocation') 
Begin
   Drop Procedure usp_InsertUpdateMapLocation 
End 
Go

Create Procedure usp_InsertUpdateMapLocation  
(
 @px_MapLocationList     Varchar(max)                  
)  
As  
Begin  
 SET NOCOUNT ON  
 Begin Try
   Create Table #tempBoxCodes (BoxId Int,LocationCode Varchar(15) )
   Declare @docHandle Int;                
   Exec sp_xml_preparedocument @docHandle Output, @px_MapLocationList;                
   Insert Into #tempBoxCodes Select * From OpenXml(@docHandle, '/NewDataSet/Root',2) With #tempBoxCodes               
   Exec sp_xml_removedocument @docHandle; 
   Update tbl_BoxDetails
			 Set s_LocationCode  =  T.LocationCode
    From tbl_BoxDetails TB  
				Inner Join
		 #tempBoxCodes T  ON TB.n_BoxId = T.BoxId 
		 
   Update tbl_MapBoxLocation
		   Set s_BoxLocationCode = T.LocationCode  
   From tbl_MapBoxLocation TB  
				Inner Join
		 #tempBoxCodes T  ON TB.n_BoxId = T.BoxId 
 End Try  
 Begin Catch  
	 Exec usp_GetErrorInfo  
 End Catch  
End  
Go