/*
SP Name: usp_MapLocations
Description: This procedure is used to validate and  Add/update locations in the tbl_boxDetails.  
Created By:  Rajendra Pawar
Creation Date: 02 March 2015
*/

If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_MapLocations') 
Begin
   Drop Procedure usp_MapLocations
End 
Go

CREATE Procedure usp_MapLocations  
(  
 
  @StrxmlLocation  Varchar(Max) ,
   @IsValidate      TinyInt   --0 = Validate 1 = Insert 
)  
As    
Begin   
	--Main Table Insert/Update Location in tbl_BoxDetails 
 Create Table #TempIsertUpdateLocation(Id				Int  Identity(1,1),
									   BoxBarCode		Varchar(16) ,	  Location			Varchar(8)	,
									   LocationBoxCount Int			,	  BoxOrLocStatus	Varchar(10) ,
									   Remraks			Varchar(100) ,	  ModificationDate	DateTime )
	Declare @docHandle	Int; 
	Declare @SxmlData	Nvarchar(Max)
	Set @SxmlData = @StrxmlLocation
	Exec sp_xml_preparedocument @docHandle Output, @SxmlData; 
	
   Insert Into #TempIsertUpdateLocation
		  Select * From OpenXml(@docHandle, '/NewDataSet/Root',2) With #TempIsertUpdateLocation               
   Exec sp_xml_removedocument @docHandle;                 
   Delete From #TempIsertUpdateLocation Where Location Is null 
   Delete From #TempIsertUpdateLocation Where BoxBarCode Is null 
 Update #TempIsertUpdateLocation Set  BoxOrLocStatus = Null 
 									   
   Create Table #TempAlreadyLocation(Id    Int  Identity(1,1),  
									 BoxBarCode  Varchar(16) ,   Location   Varchar(8))
									 
  Insert Into #TempAlreadyLocation(BoxBarCode,Location) 
				 Select   
									 TB.s_BoxBarCode   , TB.s_LocationCode 
       From tbl_BoxDetails  TB   
			 Inner Join  
        #TempIsertUpdateLocation  T On TB.s_BoxBarCode = T.BoxBarCode  
       Where Isnull(TB.s_LocationCode,'')<>''  
				Union  
       Select   
           TB.s_BoxBarCode  , TB.s_LocationCode     
       From tbl_BoxDetails  TB   
			 Inner Join  
        #TempIsertUpdateLocation  T On TB.s_LocationCode = T.Location 
       Where Isnull(TB.s_LocationCode,'')<>''   
		
		Update 
		 TU Set TU.BoxOrLocStatus  = 'Invalid',
				TU.Remraks			= Isnull(TU.Remraks,'')+ ' '+'Box does not exist'
		From #TempIsertUpdateLocation TU 
		Inner Join
		(
		Select  T.Id, TB.s_BoxBarCode  From #TempIsertUpdateLocation T
					Left Join 
					tbl_BoxDetails      TB	 On TB.s_BoxBarCode = T.BoxBarCode  
					Where Isnull(TB.s_BoxBarCode,'') = '') TA  On TU.Id = TA.Id
				
		Update 
		 TU Set TU.BoxOrLocStatus = 'Invalid',	
				TU.Remraks		  = Isnull(TU.Remraks,'')+'Location does not exist'
		From #TempIsertUpdateLocation TU 
		Inner Join
		(
		Select  T.Id, TB.s_LocationCode  From #TempIsertUpdateLocation T
					Left Join 
					tbl_LocationMaster      TB	 On TB.s_LocationCode = T.Location  
					Where Isnull(TB.s_LocationCode,'') = '') TA  On TU.Id = TA.Id			  
	  
	  
	Update  TU Set 
				TU.BoxOrLocStatus = 'Invalid', 
				TU.Remraks ='Duplicate box found' 
	 From #TempIsertUpdateLocation TU   Inner Join
	 (
	  Select  Max(Id) As 'Id',
		BoxBarCode 
	From #TempIsertUpdateLocation AS T Group by BoxBarCode having COUNT(BoxBarCode) >1) TT on TU.Id = TT.Id
	  
		Update T   
		  Set T.BoxOrLocStatus = 'Invalid',  
			  T.Remraks		   = 'Box already mapped to  location'  
		From #TempIsertUpdateLocation  T Inner Join  
		(Select 
		BoxBarCode,
		COUNT(BoxBarCode) As 'Cnt' From 
		(  
	Select  
		BoxBarCode 
	From #TempIsertUpdateLocation  Where Isnull(BoxOrLocStatus,'') = ''
			Union All
	Select  
		BoxBarCode  
	From #TempAlreadyLocation )AS T Group by BoxBarCode having COUNT(BoxBarCode) >1) TT on T.BoxBarCode = TT.BoxBarCode 
		  
		  
		  Update  TU  
					Set LocationBoxCount = TT.CurrentBoxCount  
		   From #TempIsertUpdateLocation	TU
					 Inner join 
		  (
		  Select 
			Id ,
		Location,
		ROW_NUMBER() OVER (PARTITION BY Location order by Id ) AS 'CurrentBoxCount'  
  From
		(
		Select  1 As Id, 
			Location  
		From #TempAlreadyLocation
		Union All
		Select  Id,
			Location   
		 From #TempIsertUpdateLocation 
				
		) As T) As TT  On TU.Location = TT.Location And TU.Id = TT.Id


			Update TU 
					Set		TU.BoxOrLocStatus = 'Invalid',
							TU.Remraks		  = 'Location already contains 9 boxes' 
			From #TempIsertUpdateLocation  TU Where TU.LocationBoxCount >9 and  Isnull(TU.BoxOrLocStatus,'') ='' 

  If(@IsValidate = 0)
  Begin
	  Select distinct 
			  Tu.BoxBarCode		 ,  Tu.Location , 
			 Tu.LocationBoxCount , TU.BoxOrLocStatus	 ,   Tu.Remraks
	  From #TempIsertUpdateLocation T
			 Inner join
		  #TempIsertUpdateLocation Tu On T.BoxBarCode = Tu.BoxBarCode
											 And
										 T.Location = Tu.Location 
		  Order by TU.BoxOrLocStatus desc
		  
	  If(
	  (Select COUNT(*) From  #TempIsertUpdateLocation TU Where  Isnull(TU.BoxOrLocStatus,'')<> '')  = 0) 
 	  Select 'All entry are valid' As 'Message' 
  End	 
    Else
	 Begin
	  Update T Set T.s_LocationCode = TU.Location
	  From tbl_BoxDetails T 
				Inner Join
		   #TempIsertUpdateLocation TU On T.s_BoxBarCode = TU.BoxBarCode 
	  Where  Isnull(Rtrim(ltrim(TU.BoxOrLocStatus)),'')  =  '' 
	  
	  Update TL 
			Set TL.n_BoxCount = TCount.TotalBoxes 
	  From tbl_LocationMaster TL Inner join
	  (Select 
			Count(*) As 'TotalBoxes',
			T.s_LocationCode 
		From tbl_BoxDetails T Group by T.s_LocationCode ) As TCount	 On TL.s_LocationCode = TCount.s_LocationCode    
     End
	Drop table #TempAlreadyLocation
	Drop table #TempIsertUpdateLocation
End	
Go