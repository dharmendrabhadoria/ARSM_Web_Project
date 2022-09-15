/* Table Creation Script
Project Name: Panoramic Record Storage and Management System
Database Name: PRSM
Created Date:25-Jun-2014
*/

If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_ApplicationCodeMaster')
Begin
Create Table tbl_ApplicationCodeMaster
(n_AppCodeId	SmallInt		Identity(1,1),
s_AppCode		Varchar(20)		Not Null	 ,
s_AppCodeName	Varchar(50)		Not Null)
End
Go	

Alter Table tbl_ApplicationCodeMaster Add Constraint pk_AppCodeId_ApplicationCodeMaster Primary Key(n_AppCodeId)
Go

If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_UserMaster')
Begin
Create Table tbl_UserMaster
(n_UserId		SmallInt	      Identity(1,1) ,
s_FirstName     Varchar(25)   Not Null		,
s_MiddleName	Varchar(25)	  Null			,
s_LastName		Varchar(25)	  Not Null		,
d_BirthDate		Date	      Not Null		,
n_Department	SmallInt	  Not Null		,
s_UserName      Varchar(15)   Not Null		, 
s_EmailId       Varchar(50)   Not Null		, 
s_Password      Varchar(100)  Not Null		,
b_LoginStatus   Bit           Not Null		, -- 1-Loged in/0-out
n_IsActive      TinyInt       Not Null		, -- 1-Active /0-Inactive
n_UserRole      SmallInt      Not Null		,
d_ModifiedDate  DateTime      Not Null)
End
Go

Alter Table tbl_UserMaster Add Constraint pk_UserId_UserMaster Primary Key(n_UserId)
Go

Alter Table tbl_UserMaster Add Constraint fk_Department_UserMaster Foreign Key(n_Department)
 References tbl_ApplicationCodeMaster(n_AppCodeId)
Go

Alter Table tbl_UserMaster Add Constraint fk_UserRole_UserMaster Foreign Key(n_UserRole)
 References tbl_ApplicationCodeMaster(n_AppCodeId)
 Go

If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_CountryMaster')
Begin
Create Table tbl_CountryMaster
(n_CountryId    TinyInt      Identity(1,1),
s_CountryName   Varchar(40)  Not Null	   
)
End
Go

Alter Table tbl_CountryMaster Add Constraint pk_CountryId_CountryMaster Primary Key(n_CountryId)
Go

 If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_StateMaster')
Begin
Create Table tbl_StateMaster
(n_StateId      SmallInt      Identity(1,1),
s_StateName     Varchar(40)   Not Null	   ,
n_CountryId     TinyInt       Not Null	     
)
End
Go

Alter Table tbl_StateMaster Add Constraint pk_StateId_StateMaster Primary Key(n_StateId)
Go 

Alter Table tbl_StateMaster Add Constraint fk_CountryId_StateMaster Foreign Key(n_CountryId)
References tbl_CountryMaster(n_CountryId)
Go


If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_CityMaster')
Begin
Create Table tbl_CityMaster
(n_CityId      SmallInt    Identity(1,1),
s_CityName     Varchar(40) Not Null		,
n_StateId      SmallInt    Not Null		,
d_ModifiedDate DateTime    Not Null		,
n_UserId       SmallInt     Not Null	)
End
Go	

Alter Table tbl_CityMaster Add Constraint pk_CityId_CityMaster Primary Key(n_CityId)
Go

Alter Table tbl_CityMaster Add Constraint fk_StateId_CityMaster Foreign Key(n_StateId)
 References tbl_StateMaster(n_StateId)
Go

Alter Table tbl_CityMaster Add Constraint fk_UserId_CityMaster Foreign Key(n_UserId)
 References tbl_UserMaster(n_UserId)
Go

If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_ServiceCategory')
Begin
Create Table tbl_ServiceCategory
(n_ServiceCategoryId	TinyInt			Identity(1,1),
 s_SCName				Varchar(50)		Not Null	 ,
 s_Remark				Varchar(200)				 ,
 b_IsEdit				Bit				Not Null	 , --0= Not Edit 1=Edit
 d_ModifiedDate		    DateTime		Not Null	 ,
 n_UserId				SmallInt                     ,
 n_DisplayOrder		    TinyInt)
End
Go

Alter Table tbl_ServiceCategory Add Constraint pk_ServiceCategoryId_ServiceCategory Primary Key(n_ServiceCategoryId)
Go

Alter Table tbl_ServiceCategory Add Constraint fk_UserId_ServiceCategory Foreign Key(n_UserId)
 References tbl_UserMaster(n_UserId)
 Go


If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_Activity')
Begin
Create Table tbl_Activity
(n_ActivityId		    SmallInt			Identity(1,1),
 s_ActivityName			Varchar(100)		Not Null	 ,
 n_ServiceCategoryId	TinyInt				Not Null	 ,
 s_Remark				Varchar(200)					 ,
 b_IsEdit				Bit					Not Null	 , --0= Not Edit 1=Edit
 n_Unit				    Tinyint							 , /* 1 - 'Per Box Per Month' 2 - 'Per File' 3 - 'Per Box' 4 - 'Per Unit'  */ 
 n_UnitCount			Tinyint							 ,
 b_IsShowinRateCard	    Bit								 , 
 d_ModifiedDate		    DateTime			Not Null	 ,
 n_UserId				SmallInt						 
 
 )
End
Go

Alter Table tbl_Activity Add Constraint pk_ActivityId_Activity Primary Key(n_ActivityId)
Go

Alter Table tbl_Activity Add Constraint fk_ServiceCategoryId_Activity Foreign Key(n_ServiceCategoryId)
 References tbl_ServiceCategory(n_ServiceCategoryId)
Go

Alter Table tbl_Activity Add Constraint fk_UserId_Activity Foreign Key(n_UserId)
 References tbl_UserMaster(n_UserId)
 Go
 
If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_CompanyGroup')
Begin
Create Table tbl_CompanyGroup
(n_CompanyGroupId		SmallInt			Identity(1,1),
 s_CGName				Varchar(100)		Not Null	 ,
 n_IndustryId			SmallInt			Not Null	 ,
 s_RegisterAddress		Varchar(200)					 ,
 n_StateId				SmallInt			Not Null	 ,
 n_CityId				SmallInt			Not Null	 ,
 s_PinCode              Varchar(8)          Not Null     ,
 s_CorpAddress		    Varchar(200)					 ,
 n_CorpStateId			SmallInt			Not Null	 ,
 n_CorpCityId			SmallInt			Not Null	 ,
 s_CorpPinCode          Varchar(8)          Not Null     ,
 s_PANNumber			Varchar(10)						 ,
 s_TANNumber			Varchar(25)						 ,
 s_ContactPerson		Varchar(50)						 ,
 s_PhoneNumber			Varchar(15)	        Not Null	 ,
 s_MobileNumber         Varchar(10)         Not Null     , 
 s_Email				Varchar(50)						 ,
 s_ContactPerson1		Varchar(50)						 ,
 s_PhoneNumber1			Varchar(15)						 ,
 s_MobileNumber1        Varchar(10)         Not Null     ,
 s_Email1				Varchar(50)						 ,
 d_ModifiedDate		    DateTime			Not Null	 ,
 n_UserId				SmallInt                         ,
 s_RegAddress1          Varchar(50)         Not Null     ,
 s_RegAddress2          Varchar(50)         Not Null     ,
 s_CorpAddress1         Varchar(50)         Not Null     ,
 s_CorpAddress2         Varchar(50)         Not Null  
 )
End
Go

Alter Table tbl_CompanyGroup Add Constraint pk_CompanyGroupId_CompanyGroup Primary Key(n_CompanyGroupId)
Go

Alter Table tbl_CompanyGroup Add Constraint fk_IndustryId_CompanyGroup Foreign Key(n_IndustryId)
 References tbl_ApplicationCodeMaster(n_AppCodeId)
Go

Alter Table tbl_CompanyGroup Add Constraint fk_StateId_CompanyGroup Foreign Key(n_StateId)
 References tbl_StateMaster(n_StateId)
Go

Alter Table tbl_CompanyGroup Add Constraint fk_CorpCityId_CompanyGroup Foreign Key(n_CorpCityId)
 References tbl_CityMaster(n_CityId)
Go

Alter Table tbl_CompanyGroup Add Constraint fk_CorpStateId_CompanyGroup Foreign Key(n_CorpStateId)
 References tbl_StateMaster(n_StateId)
Go

Alter Table tbl_CompanyGroup Add Constraint fk_UserId_CompanyGroup Foreign Key(n_UserId)
 References tbl_UserMaster(n_UserId)
 Go
 
 If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_Customer')
Begin
Create Table tbl_Customer
(n_CustomerId			Int					Identity(1,1),
 s_CustomerName		    Varchar(100)		Not Null	 ,
 n_CompanyGroupId		SmallInt			Not Null	 ,
 s_BillingAddress		Varchar(200)		Not Null	 ,
 n_StateId				SmallInt			Not Null	 ,
 n_CityId				SmallInt			Not Null	 ,
 s_PinCode				Varchar(8)			Not Null	 ,
 d_ModifiedDate		    DateTime			Not Null	 ,
 n_UserId				SmallInt            Not Null     ,	            
 s_BillingAddress1      Varchar(50)         Not Null     ,
 s_BillingAddress2      Varchar(50)         Not Null
 )
End
Go

Alter Table tbl_Customer Add Constraint pk_CustomerId_Customer Primary Key(n_CustomerId)
Go
Alter Table tbl_Customer Add Constraint fk_CompanyGroupId_Customer Foreign Key(n_CompanyGroupId)
 References tbl_CompanyGroup(n_CompanyGroupId)
Go

Alter Table tbl_Customer Add Constraint fk_StateId_Customer Foreign Key(n_StateId)
 References tbl_StateMaster(n_StateId)
Go

Alter Table tbl_Customer Add Constraint fk_CityId_Customer Foreign Key(n_CityId)
 References tbl_CityMaster(n_CityId)
Go

Alter Table tbl_Customer Add Constraint fk_UserId_Customer Foreign Key(n_UserId)
 References tbl_UserMaster(n_UserId)
 Go
 
If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_PickupAddress')
Begin
Create Table tbl_PickupAddress
(
 n_PickupAddressId		Int					Identity(1,1),
 n_CustomerId			Int					Not Null	 ,
 s_Address			    Varchar(200)					 ,
 n_StateId				SmallInt			Not Null	 ,
 n_CityId				SmallInt			Not Null	 ,
 n_DepartmentId			SmallInt			Not Null	 ,
 s_PinCode				Varchar(8)			Not Null	 , 
 d_ModifiedDate		    DateTime			Not Null	 ,
 n_UserId				SmallInt            Not Null	 ,    
 s_Address1             Varchar(50)         Not Null     ,
 s_Address2             Varchar(50)         Not Null     
 )
End
Go

Alter Table tbl_PickupAddress Add Constraint pk_PickupAddressId_PickupAddress Primary Key(n_PickupAddressId)
Go

Alter Table tbl_PickupAddress Add Constraint fk_CustomerId_PickupAddress Foreign Key(n_CustomerId)
 References tbl_Customer(n_CustomerId)
Go

Alter Table tbl_PickupAddress Add Constraint fk_StateId_PickupAddress Foreign Key(n_StateId)
 References tbl_StateMaster(n_StateId)
Go

Alter Table tbl_PickupAddress Add Constraint fk_CityId_PickupAddress Foreign Key(n_CityId)
 References tbl_CityMaster(n_CityId)
Go

Alter Table tbl_PickupAddress Add Constraint fk_DepartmentId_PickupAddress Foreign Key(n_DepartmentId)
 References tbl_ApplicationCodeMaster(n_AppCodeId)
 Go
 
Alter Table tbl_PickupAddress Add Constraint fk_UserId_PickupAddress Foreign Key(n_UserId)
 References tbl_UserMaster(n_UserId)
 Go
 
 If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_AuthorisedPersons')
Begin
Create Table tbl_AuthorisedPersons
(n_AuthorisedPersonId   Int					Identity(1,1),
n_PickupAddressId		Int								 ,
s_AuthorisedPerson		Varchar(50)						 ,
s_PhoneNumber			Varchar(15)						 ,
s_Email					Varchar(50)						 ,
s_MobileNo			    Varchar(11)		                 ,
d_ModifiedDate		    DateTime			Not Null	 ,
n_UserId				SmallInt            Not Null	              
 )
End
Go
Alter Table tbl_AuthorisedPersons Add Constraint pk_AuthorisedPersonId_AuthorisedPersons Primary Key(n_AuthorisedPersonId)
Go
Alter Table tbl_AuthorisedPersons Add Constraint fk_PickupAddressId_AuthorisedPersons Foreign Key(n_PickupAddressId)
 References tbl_PickupAddress(n_PickupAddressId)
Go
Alter Table tbl_AuthorisedPersons Add Constraint fk_UserId_AuthorisedPersons Foreign Key(n_UserId)
 References tbl_UserMaster(n_UserId)
 Go
 
 
 If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_RateCard')
Begin
Create Table tbl_RateCard
(n_RateCardId		    Int				    Identity(1,1),
n_CustomerId			Int					Not Null	 ,
n_ActivityId			SmallInt			Not Null	 ,
n_Rate					Decimal(10,2)       Not Null	 ,
d_FromDate				DateTime			Not Null	 ,
d_Todate				DateTime			Not Null	 ,
d_ModifiedDate		    DateTime			Not Null	 ,
n_UserId				SmallInt
 )
End
Go

Alter Table tbl_RateCard Add Constraint pk_RateCardId_RateCard Primary Key(n_RateCardId)
Go
 
Alter Table tbl_RateCard Add Constraint fk_CustomerId_RateCard Foreign Key(n_CustomerId)
 References tbl_Customer(n_CustomerId)
 Go
 
Alter Table tbl_RateCard Add Constraint fk_ActivityId_RateCard Foreign Key(n_ActivityId)
 References tbl_Activity(n_ActivityId)
 Go

Alter Table tbl_RateCard Add Constraint fk_UserId_RateCard Foreign Key(n_UserId)
 References tbl_UserMaster(n_UserId)
 Go
 
 If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_AuditRateCard')
Begin
Create Table tbl_AuditRateCard
(n_RateCardId	Int		 ,
 n_CustomerId	Int		 ,
 n_ActivityId	SmallInt ,
n_Rate			Decimal(10, 2) ,
d_FromDate		DateTime			,
d_Todate		DateTime,
d_ModifiedDate	Datetime ,
n_UserId		SmallInt 
)
End
Go

If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_WareHouseMaster')
Begin
Create Table tbl_WareHouseMaster
(
n_WareHouseId			TinyInt					Identity(1,1)	 ,
 s_WarehouseName		Varchar(50)					Not Null	 ,
 s_WarehouseCode		Varchar(15)					Not Null	 ,
 n_TotalRows			SmallInt					Not Null	 ,
 s_Address			    Varchar(200)							 ,
 n_StateId				SmallInt					Not Null	 ,
 n_CityId				SmallInt					Not Null	 ,
 d_ModifiedDate		    DateTime					Not Null	 ,
 n_UserId				SmallInt                                 ,
 s_Address1             Varchar(50)                 Not Null     ,
 s_Address2             Varchar(50)                 Not Null
 )
End
Go
Alter Table tbl_WareHouseMaster Add Constraint pk_WareHouseId_WareHouseMaster Primary Key(n_WareHouseId)
Go

Alter Table tbl_WareHouseMaster Add Constraint fk_StateId_WareHouseMaster Foreign Key(n_StateId)
 References tbl_StateMaster(n_StateId)
Go

Alter Table tbl_WareHouseMaster Add Constraint fk_CityId_WareHouseMaster Foreign Key(n_CityId)
 References tbl_CityMaster(n_CityId)
Go
 
Alter Table tbl_WareHouseMaster Add Constraint fk_UserId_WareHouseMaster Foreign Key(n_UserId)
 References tbl_UserMaster(n_UserId)
 Go

 If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_RackMaster')
Begin
Create Table tbl_RackMaster
(n_rackId			SmallInt	 Identity(1,1)	,
s_RowName			Varchar(50)  Not Null		,
n_WareHouseId		TinyInt		 Not Null		,
n_NoofShelf			SmallInt	 Not Null		,	
n_NoofBoxesPerShelf	SmallInt	 Not Null		,
n_BoxStartNo		Int			 Not Null		,
n_BoxEndNo			Int			 Not Null		,
s_Remark			Varchar(200)				,
n_Height			Decimal(5,2) Not Null		,
n_Width				Decimal(5,2) Not Null		,
n_Depth				Decimal(5,2) Not Null		,
n_NoofRacks         Int          Not Null       ,
n_RowId				Int			 Not Null		,
d_ModifiedDate		DateTime	 Not Null		,
n_UserId			SmallInt	 Not Null       
)
End

Go
Alter Table tbl_RackMaster Add Constraint pk_rackId_RackMaster Primary Key(n_rackId)
Go

Alter Table tbl_RackMaster Add Constraint fk_WareHouseId_RackMaster Foreign Key(n_WareHouseId)
 References tbl_WareHouseMaster(n_WareHouseId)
Go
 
Alter Table tbl_RackMaster Add Constraint fk_UserId_RackMaster Foreign Key(n_UserId)
 References tbl_UserMaster(n_UserId)
Go
 
 If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_ContractMaster')
Begin
Create Table tbl_ContractMaster
(n_ContractId		Int			 Identity(1,1),
n_ContractNo        Int          Not Null	 ,
n_CustomerId	    Int	         Not Null	 ,
d_FromDate		    DateTime	 Not Null	 ,
d_EndDate		    DateTime	 Not Null	 ,
s_Remark            Varchar(250) Null	     ,
s_DocumentName      Varchar(50)   Null       ,
s_Filepath          Varchar(250)  Null       , 
d_ModifiedDate      DateTime     Not Null    ,
n_UserId            SmallInt     Not Null	 
)
End
Go

Alter Table tbl_ContractMaster Add Constraint pk_ContractId_ContractMaster Primary Key(n_ContractId)
Go
Alter Table tbl_ContractMaster Add Constraint fk_CustomerId_ContractMaster Foreign Key(n_CustomerId)
References tbl_Customer(n_CustomerId)
Go

 Alter Table tbl_ContractMaster Add Constraint fk_UserId_ContractMaster Foreign Key(n_UserId)
 References tbl_UserMaster(n_UserId)
 Go
 
If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_WorkOrder')
Begin
Create Table tbl_WorkOrder
(n_WorkorderNo	    Int		      Not Null     ,
 d_WoDate		    DateTime	  Not Null     ,
 n_CustomerId	    Int	          Not Null     ,
 s_Remark           Varchar(500)  Not Null     ,
 n_WareHouseId      TinyInt       Not Null     ,
 n_Status           SmallInt      Not Null     ,
 d_ModificationDate DateTime      Not Null     ,
 n_ModifiedBy       SmallInt      Not Null     
 )  
End
Go

Alter Table tbl_WorkOrder Add Constraint pk_WorkorderNo_WorkOrder Primary Key(n_WorkorderNo)
Go
Alter Table tbl_WorkOrder Add Constraint fk_CustomerId_WorkOrder Foreign Key(n_CustomerId)
 References tbl_Customer(n_CustomerId)
Go
Alter Table tbl_WorkOrder Add Constraint fk_WareHouseId_WorkOrder Foreign Key(n_WareHouseId)
 References tbl_WareHouseMaster(n_WareHouseId)
Go
Alter Table tbl_WorkOrder Add Constraint fk_Status_WorkOrder Foreign Key(n_Status)
 References tbl_ApplicationCodeMaster(n_AppCodeId)
Go
Alter Table tbl_WorkOrder Add Constraint fk_ModifiedBy_WorkOrder Foreign Key(n_ModifiedBy)
 References tbl_UserMaster(n_UserId)
Go

If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_WoActivities')
Begin
Create Table tbl_WoActivities
(n_WoActivityId	    Int		     Identity(1,1),
 n_WorkOrderNo		Int		     Not Null     ,
 n_ActivityId	    SmallInt	 Not Null     ,
 n_ActivityStatus   SmallInt     Not Null     ,
 n_BoxCount         Int          Null         ,
 n_FileCount        Int          Null         ,
 s_Remark           Varchar(500) Not Null     ,
 d_ModificationDate DateTime     Not Null     ,
 n_ModifiedBy       SmallInt     Not Null     ,
 n_DepartmentId	    SmallInt	 Null         ,
 d_ActivityDate	    DateTime	 Null         ,
 n_PickUpAddressId  Int          Null         
 )
End
Go

Alter Table tbl_WoActivities Add Constraint pk_WoActivityId_WoActivities Primary Key(n_WoActivityId)
Go

Alter Table tbl_WoActivities Add Constraint fk_WorkOrderNo_WoActivities Foreign Key(n_WorkOrderNo)
 References tbl_WorkOrder(n_WorkOrderNo)
Go

Alter Table tbl_WoActivities Add Constraint fk_ActivityId_WoActivities Foreign Key(n_ActivityId)
 References tbl_Activity(n_ActivityId)
Go

Alter Table tbl_WoActivities Add Constraint fk_ActivityStatus_WoActivities Foreign Key(n_ActivityStatus)
 References tbl_ApplicationCodeMaster(n_AppCodeId)
Go

Alter Table tbl_WoActivities Add Constraint fk_CreatedBy_WoActivities  Foreign Key(n_ModifiedBy)
 References tbl_UserMaster(n_UserId)
Go

If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_BoxDetails')
Begin
Create Table tbl_BoxDetails
(n_BoxId		    Int		      Identity(1,1),
 s_BoxBarCode		Varchar(16)	  Not Null     ,
 s_LocationCode     Varchar(15)   Null         ,
 n_CustomerId	    Int	          Not Null     ,
 n_WareHouseId      TinyInt       Not Null     ,
 n_Status           SmallInt      Not Null     , -- Application code Master BOXFILE_STATUS
 d_ModifiedDate		DateTime      Not Null     ,
 n_ModifiedBy       SmallInt      Not Null
 )  
End
Go

Alter Table tbl_BoxDetails Add Constraint pk_BoxId_BoxDetails Primary Key(n_BoxId)
Go

Alter Table tbl_BoxDetails Add Constraint fk_CustomerId_BoxDetails Foreign Key(n_CustomerId)
 References tbl_Customer(n_CustomerId)
Go

Alter Table tbl_BoxDetails Add Constraint fk_WareHouseId_BoxDetails Foreign Key(n_WareHouseId)
 References tbl_WareHouseMaster(n_WareHouseId)
Go

Alter Table tbl_BoxDetails Add Constraint fk_Status_BoxDetails Foreign Key(n_Status)
 References tbl_ApplicationCodeMaster(n_AppCodeId)
Go

Alter Table tbl_BoxDetails Add Constraint fk_ModifiedBy_BoxDetails Foreign Key(n_ModifiedBy)
 References tbl_UserMaster(n_UserId)
Go

If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_BoxTransactions')
Begin
Create Table tbl_BoxTransactions
(
 n_BoxTransId		Int		      Identity(1,1),
 n_BoxId		    Int		      Not Null     ,
 n_WoActivityId	    Int	          Not Null     ,
 d_ModifiedDate		DateTime      Not Null     ,
 n_ModifiedBy       SmallInt      Not Null
 )  
End
Go
Alter Table tbl_BoxTransactions Add Constraint pk_BoxTransId_BoxTransactions Primary Key(n_BoxTransId)
Go

Alter Table tbl_BoxTransactions Add Constraint fk_BoxId_BoxTransactions Foreign Key(n_BoxId)
 References tbl_BoxDetails(n_BoxId)
Go

Alter Table tbl_BoxTransactions Add Constraint fk_WoActivityId_BoxTransactions Foreign Key(n_WoActivityId)
 References tbl_WoActivities(n_WoActivityId)
Go

Alter Table tbl_BoxTransactions Add Constraint fk_ModifiedBy_BoxTransactions Foreign Key(n_ModifiedBy)
 References tbl_UserMaster(n_UserId)
Go

If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_FileDetails')
Begin
Create Table tbl_FileDetails
(n_FileId		    Int		      Identity(1,1),
 n_BoxId            Int           Not Null     ,
 s_FileBarCode		Varchar(16)	  Not Null     ,
 s_FileName         Varchar(255)   Null         ,
 n_BranchId         Int           Not Null     , 
 n_DepartmentId     SmallInt      Not Null     , 
 s_Year             Varchar(30)   Null         ,
 d_FromDate         DateTime      Null         , 
 d_EndDate          DateTime      Null         ,
 s_Label1           Varchar(100)  Null         , 
 s_Label2           Varchar(100)  Null         ,  
 s_Label3           Varchar(100)  Null         , 
 n_Status           SmallInt      Not Null     , -- Application code Master BOXFILE_STATUS
 d_ModifiedDate		DateTime      Not Null     ,
 n_ModifiedBy       SmallInt      Not Null
 )  
End
Go

Alter Table tbl_FileDetails Add Constraint pk_FileId_FileDetails Primary Key(n_FileId)
Go

Alter Table tbl_FileDetails Add Constraint fk_BoxId_FileDetails Foreign Key(n_BoxId)
 References tbl_BoxDetails(n_BoxId)
Go

Alter Table tbl_FileDetails Add Constraint fk_Status_FileDetails  Foreign Key(n_Status)
 References tbl_ApplicationCodeMaster(n_AppCodeId)
Go

Alter Table tbl_FileDetails Add Constraint fk_ModifiedBy_FileDetails Foreign Key(n_ModifiedBy)
 References tbl_UserMaster(n_UserId)
Go

If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_FileTransactions')
Begin
Create Table tbl_FileTransactions
(
 n_FileTransId		Int		      Identity(1,1),
 n_FileId		    Int		      Not Null     ,
 n_WoActivityId	    Int	          Not Null     ,
 d_ModifiedDate		DateTime      Not Null     ,
 n_ModifiedBy       SmallInt      Not Null
 )  
End
Go
Alter Table tbl_FileTransactions Add Constraint pk_FileTransId_FileTransactions Primary Key(n_FileTransId)
Go

Alter Table tbl_FileTransactions Add Constraint fk_FileId_FileTransactions Foreign Key(n_FileId)
 References tbl_FileDetails(n_FileId)
Go

Alter Table tbl_FileTransactions Add Constraint fk_WoActivityId_FileTransactions Foreign Key(n_WoActivityId)
 References tbl_WoActivities(n_WoActivityId)
Go

Alter Table tbl_FileTransactions Add Constraint fk_ModifiedBy_FileTransactions Foreign Key(n_ModifiedBy)
 References tbl_UserMaster(n_UserId)
Go

If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_PageFunctionality')
Begin
Create Table tbl_PageFunctionality
(n_PageFunctionId  SmallInt     Identity(1,1),
n_PageId           SmallInt     Not Null,
b_IsMenu		   Bit			Not Null,	
s_Functionality    Varchar(50)  Not Null,
b_Enable           Bit          Not Null,
d_ModifiedDate     DateTime     Not Null)
End
Go

Alter Table tbl_PageFunctionality Add Constraint pk_PageFunctionId_PageFunctionality Primary Key(n_PageFunctionId)
Go

Alter Table tbl_PageFunctionality Add Constraint fk_PageId_PageFunctionality Foreign Key(n_PageId)
 References tbl_ApplicationCodeMaster(n_AppCodeId)
Go

If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_RoleWiseAccess')
Begin
Create Table tbl_RoleWiseAccess
(n_RoleWiseAccessId  Integer   Identity(1,1),
n_RoleId             SmallInt  Not Null,
n_PageFunctionId     SmallInt  Not Null,
n_Enable             Bit       Not Null,
d_ModifiedDate       DateTime  Not Null)
End
Go

Alter Table tbl_RoleWiseAccess Add Constraint pk_RoleWiseAccessId_RoleWiseAccess Primary Key(n_RoleWiseAccessId)
Go

Alter Table tbl_RoleWiseAccess Add Constraint fk_RoleId_RoleWiseAccess Foreign Key(n_RoleId)
 References tbl_ApplicationCodeMaster(n_AppCodeId)
Go

Alter Table tbl_RoleWiseAccess Add Constraint fk_PageFunctionId_RoleWiseAccess Foreign Key(n_PageFunctionId)
 References tbl_PageFunctionality(n_PageFunctionId)
Go

If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_OtherTransactions')
Begin
Create Table tbl_OtherTransactions
(n_OtherTransId			 Int           Identity(1,1),
 n_WoActivityId	         Int	       Not Null,
 n_ServiceCount          SmallInt      Not Null,
 n_Amount		         Decimal(10,2) Not Null,
 s_Remarks               Varchar(500)  Not Null,
 d_ModifiedDate			 DateTime      Not Null ,
 n_ModifiedBy			 SmallInt      Not Null 
)
End
Go 
Alter Table tbl_OtherTransactions Add Constraint pk_OtherTransId_OtherTransactions Primary Key(n_OtherTransId)
Go
Alter Table tbl_OtherTransactions Add Constraint fk_WoActivityId_OtherTransactions Foreign Key(n_WoActivityId)
 References tbl_WoActivities(n_WoActivityId)
Go
Alter Table tbl_OtherTransactions Add Constraint fk_ModifiedBy_OtherTransactions Foreign Key(n_ModifiedBy)
 References tbl_UserMaster(n_UserId)
Go

If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_InvoiceSummary')
Begin
	Create Table tbl_InvoiceSummary
	   (n_InvoiceNo			Int			  Not Null  ,
	    n_MonthYear			Int			  Not Null	,
	    n_WareHouseId		TinyInt		  Not Null	,
	    n_CustomerId		Int			  Not Null	,
		n_PickupAddressId	Int			  Not Null	,
	    n_StorageCharges	Decimal(10,2) Not Null  ,
	    n_TransAmount		Decimal(10,2) Not Null  ,
	    n_InvoiceAmount	    Decimal(10,2) Not Null  ,
	    n_HigherEducation	Decimal(9,2)  Not Null  ,
	    n_ServiceTax		Decimal(8,2)  Null		,
	    n_EduTax	    	Decimal(8,2)  Null		,
	    n_OtherTax		    Decimal(8,2)  Null		,	
	    n_TotalAmount	    Decimal(10,2) Not Null  ,
	    d_ModifiedDate		DateTime      Not Null  ,
	    n_ModifiedBy        SmallInt      Not Null )
								    
End								    
Go 

Alter Table tbl_InvoiceSummary Add Constraint pk_InvoiceNo_InvoiceSummary  Primary Key(n_InvoiceNo)
Go
Alter Table tbl_InvoiceSummary Add Constraint fk_WareHouseId_InvoiceSummary    Foreign Key(n_WareHouseId)
 References tbl_WareHouseMaster (n_WareHouseId)
Go
Alter Table tbl_InvoiceSummary Add Constraint fk_CustomerId_InvoiceSummary     Foreign Key(n_CustomerId)
 References tbl_Customer (n_CustomerId)
Go
 Alter Table tbl_InvoiceSummary Add Constraint fk_PickupAddressId_InvoiceSummary Foreign Key(n_PickupAddressId)
 References tbl_PickupAddress(n_PickupAddressId)
Go

Alter Table tbl_InvoiceSummary Add Constraint fk_ModifiedBy_InvoiceSummary     Foreign Key(n_ModifiedBy)
 References tbl_UserMaster(n_UserId)
Go


If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_InvoiceDetails')
Begin
Create Table tbl_InvoiceDetails
					(n_InvoiceDetailId	BigInt Identity(1,1)  ,
					n_InvoiceNo			Int			 Not Null ,
					n_WoActivityId		Int			 Not Null ,
					n_ActivityCount		Int			 Not Null ,
					n_Amount			Decimal(9,2) Not Null )

End
Go 

Alter Table tbl_InvoiceDetails Add Constraint pk_InvoiceDetailId_InvoiceDetails Primary Key(n_InvoiceDetailId)
Go
Alter Table tbl_InvoiceDetails Add Constraint fk_InvoiceNo_InvoiceDetails    Foreign Key(n_InvoiceNo)
 References tbl_InvoiceSummary (n_InvoiceNo)
Go
Alter Table tbl_InvoiceDetails Add Constraint fk_WoActivityId_InvoiceDetails Foreign Key(n_WoActivityId)
 References tbl_WoActivities(n_WoActivityId)
Go	

If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_TaxMaster')
Begin
Create Table tbl_TaxMaster(n_TaxMasterId		Int Identity(1,1)	   ,
						   n_TaxId				SmallInt			   , -- From Application code Master
						   n_TaxValue			Decimal(5,2)  Not Null ,
						   d_FromDate			DateTime      Not Null ,
						   d_Todate				DateTime      Null	   ,
						   d_ModifiedDate		DateTime      Not Null ,
						   n_ModifiedBy         SmallInt      Not Null )
End
Go 

Alter Table tbl_TaxMaster Add Constraint pk_TaxMasterId_TaxMaster Primary Key(n_TaxMasterId)
Go

Alter Table tbl_TaxMaster Add Constraint fk_TaxId_TaxMaster  Foreign Key(n_TaxId)
 References tbl_ApplicationCodeMaster(n_AppCodeId)
Go
		
Alter Table tbl_TaxMaster Add Constraint fk_ModifiedBy_TaxMaster  Foreign Key(n_ModifiedBy)
 References tbl_UserMaster(n_UserId)
Go	
	
Create Table tbl_PagewiseActivity(n_PageId SmallInt , n_ActivityId SmallInt)
Go
Alter Table tbl_PagewiseActivity Add Constraint fk_PageId_PagewiseActivity Foreign Key(n_PageId)
 References tbl_ApplicationCodeMaster(n_AppCodeId)
 Go
 Alter Table tbl_PagewiseActivity Add Constraint fk_ActivityId_PagewiseActivity Foreign Key(n_ActivityId)
  References tbl_Activity(n_ActivityId)
Go


If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_BoxLocation')
Begin
Create Table tbl_BoxLocation
	 (n_BoxLocationId	  Int Identity(1,1), s_BoxLocationCode  Varchar(15),
	 n_BoxLocationNo  Int		       , s_BoxLocationId    Varchar(15), 
	 s_BoxBarCode	  Varchar(16)      , n_WareHouseId      TinyInt    )
End
Go
							  
Alter Table tbl_BoxLocation Add Constraint pk_BoxLocationId_BoxLocation Primary Key(n_BoxLocationId)
Go

If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_CompanyMaster')
Begin
Create Table tbl_CompanyMaster
(n_CompanyMasterId		SmallInt			Identity(1,1),
 s_CMName				Varchar(50)			Not Null	 ,
 n_IndustryId			SmallInt			Not Null	 ,
 s_RegisterAddress		Varchar(200)		Not Null	 ,
 n_StateId				SmallInt			Not Null	 ,
 n_CityId				SmallInt			Not Null	 ,
 s_PinCode              Varchar(8)          Not Null     ,
 s_Email                Varchar(50)         Not Null     ,
 s_Telephone            Varchar(15)         Not Null     ,
 s_Fax                  Varchar(15)         Not Null     , 
 s_CorpAddress		    Varchar(200)		Not Null	 ,
 n_CorpStateId			SmallInt			Not Null	 ,
 n_CorpCityId			SmallInt			Not Null	 ,
 s_CorpPinCode          Varchar(8)          Not Null     ,
 s_CorpEmail            Varchar(50)         Not Null     ,
 s_CorpTelephone        Varchar(15)         Not Null     , 
 s_CorpFax              Varchar(15)         Not Null     , 
 s_PANNumber			Varchar(10)			Not Null	 ,
 s_TANNumber			Varchar(25)			Null		 ,
 s_CINNumber			Varchar(17)	        Null         , 	
 s_VATNumber            Varchar(25)         Null         ,
 s_SalesTaxNo           Varchar(25)         Null         ,
 d_ModifiedDate		    DateTime			Not Null	 ,
 n_UserId				SmallInt
 )
End
Go

Alter Table tbl_CompanyMaster Add Constraint pk_CompanyMasterId_CompanyMaster Primary Key(n_CompanyMasterId)
Go

Alter Table tbl_CompanyMaster Add Constraint fk_IndustryId_CompanyMaster Foreign Key(n_IndustryId)
 References tbl_ApplicationCodeMaster(n_AppCodeId)
Go

Alter Table tbl_CompanyMaster Add Constraint fk_StateId_CompanyMaster Foreign Key(n_StateId)
 References tbl_StateMaster(n_StateId)
Go

Alter Table tbl_CompanyMaster Add Constraint fk_CityId_CompanyMaster Foreign Key(n_CityId)
 References tbl_CityMaster(n_CityId)
Go


Alter Table tbl_CompanyMaster Add Constraint fk_CorpCityId_CompanyMaster Foreign Key(n_CorpCityId)
 References tbl_CityMaster(n_CityId)
Go

Alter Table tbl_CompanyMaster Add Constraint fk_CorpStateId_CompanyMaster Foreign Key(n_CorpStateId)
 References tbl_StateMaster(n_StateId)
Go

Alter Table tbl_CompanyMaster Add Constraint fk_UserId_CompanyMaster Foreign Key(n_UserId)
 References tbl_UserMaster(n_UserId)
 Go
 
  If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_MapBoxLocation')
Begin
Create Table tbl_MapBoxLocation	 ( n_MapBoxLocationId	   Int          Identity(1,1),
								   n_BoxId				   Int		    Null,
						           s_BoxLocationCode	   Varchar(15)  Null
						          )
End
Go
Alter Table tbl_MapBoxLocation Add Constraint pk_MapBoxLocationId_MapBoxLocation Primary Key(n_MapBoxLocationId)
Go
Alter Table tbl_MapBoxLocation Add Constraint fk_BoxId_MapBoxLocation Foreign Key(n_BoxId)
 References tbl_BoxDetails(n_BoxId)
Go
 
 If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_AuditMapBoxLocation')
Begin
Create Table tbl_AuditMapBoxLocation (n_MapBoxLocationId	   Int         Null ,
									  n_BoxId				  Int		   Null	,
							          s_BoxLocationCode		  Varchar(15)  Null
							          )
End
Go
 
 
 
 
 If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_AuditBoxLocation')
Begin
Create Table tbl_AuditBoxLocation (n_BoxLocationId	   Int         Null , s_BoxLocationCode  Varchar(15)   Null,
							       n_BoxLocationNo Int	       Null , s_BoxLocationId    Varchar(15)   Null, 
							       s_BoxBarCode	   Varchar(16) Null , n_WareHouseId      TinyInt       Null )
End
Go

If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_AuditFileDetails')
Begin
Create Table tbl_AuditFileDetails
(n_FileId		    Int		      Null         ,
 n_BoxId            Int           Null		   ,
 s_FileBarCode		Varchar(16)	  Null		   ,
 s_FileName         Varchar(255)   Null         ,
 n_BranchId         Int           Null         , 
 n_DepartmentId     SmallInt      Null         , 
 s_Year             Varchar(30)   Null         ,
 d_FromDate         DateTime      Null         , 
 d_EndDate          DateTime      Null         ,
 s_Label1           Varchar(100)  Null         , 
 s_Label2           Varchar(100)  Null         ,  
 s_Label3           Varchar(100)  Null         , 
 n_Status           SmallInt      Null         , -- Application code Master BOXFILE_STATUS
 d_ModifiedDate		DateTime      Null         ,
 n_ModifiedBy       SmallInt      Null
 )  
End
Go


If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_AuditBoxDetails')
Begin
Create Table tbl_AuditBoxDetails
(n_BoxId		    Int		      Null         ,
 s_BoxBarCode		Varchar(16)	  Null         ,
 s_LocationCode     Varchar(15)   Null         ,
 n_CustomerId	    Int	          Null         ,
 n_WareHouseId      TinyInt       Null         ,
 n_Status           SmallInt      Null         , -- Application code Master BOXFILE_STATUS
 d_ModifiedDate		DateTime      Null         ,
 n_ModifiedBy       SmallInt      Null
 )  
End
Go

If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_BoxFileRetrivaldetails')
Begin
Create Table tbl_BoxFileRetrivaldetails 
(n_BoxFileRetId      	Int					Identity(1,1),
 n_IsBoxFile            TinyInt		        Not Null	 ,
 n_workOrderActivity    Int			        Not Null	 ,
 s_BoxBarCode		    Varchar(16)		    Not Null	 ,
 s_FileBarCode          Varchar(16)		    Null	     ,
 n_ModifiedBy           SmallInt            Not Null     ,
 d_ModifiedDate		    DateTime			Not Null	            
 )
End

Alter Table tbl_BoxFileRetrivaldetails Add Constraint pk_BoxFileRetId_BoxFileRetrivaldetails  Primary Key(n_BoxFileRetId)
Go
Go
Alter Table tbl_BoxFileRetrivaldetails Add Constraint fk_ModifiedBy_BoxFileRetrivaldetails  Foreign Key(n_ModifiedBy)
 References tbl_UserMaster(n_UserId)
 Go
 
 
If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_AuditWoActivities')
Begin
Create Table tbl_AuditWoActivities
(n_WoActivityId	    Int		     NULL     ,
 n_WorkOrderNo		Int		     Null     ,
 n_ActivityId	    SmallInt	 Null     ,
 n_ActivityStatus   SmallInt     Null     ,
 n_BoxCount         Int          Null     ,
 n_FileCount        Int          Null     ,
 s_Remark           Varchar(500) Null     ,
 d_ModificationDate DateTime     Null     ,
 n_ModifiedBy       SmallInt     Null     ,
 n_DepartmentId	    SmallInt	 Null     ,
 d_ActivityDate	    DateTime	 Null     ,
 n_PickUpAddressId  Int          Null         
 )
End
Go
 
 Create Table tbl_LocationMaster
(n_LocationId		Int			Identity,
n_RowId				SmallInt	Not Null,
s_LocationCode		Varchar(8)	Not Null,
n_BoxCount			TinyInt		Not Null,
n_MaxBoxCount		TinyInt		Not Null)

Go
Alter Table tbl_LocationMaster Add Constraint pk_LocationId_LocationMaster Primary Key(n_LocationId)
Go

Alter Table tbl_LocationMaster Add Constraint fk_RowId_LocationMaster Foreign Key(n_RowId)
 References tbl_RowMaster(n_RowId)
Go
 
If Not Exists (Select 1 From sysobjects Where Type = 'U' AND  name = 'tbl_RowMaster')
Begin
Create Table tbl_RowMaster
(n_RowId			    SmallInt	 Identity(1,1)	,
s_RowName			    Char(2)      Not Null		,
n_WareHouseId		    TinyInt		 Not Null		,
n_NoofShelf			    SmallInt	 Not Null		,	
n_NoOfLocationPerSelf	SmallInt	 Not Null		,
s_Remark			    Varchar(100)				,
d_ModifiedDate		    DateTime	 Not Null		,
n_UserId			    SmallInt	 Not Null       
)
End

Go
Alter Table tbl_RowMaster Add Constraint pk_RowId_RowMaster Primary Key(n_RowId)
Go

Alter Table tbl_RowMaster Add Constraint fk_WareHouseId_RowMaster Foreign Key(n_WareHouseId)
 References tbl_WareHouseMaster(n_WareHouseId)
Go
 
Alter Table tbl_RowMaster Add Constraint fk_UserId_RowMaster Foreign Key(n_UserId)
 References tbl_UserMaster(n_UserId)
Go 

 


 





	
	 
	

	




 