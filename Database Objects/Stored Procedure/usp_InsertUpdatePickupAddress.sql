/*
SP Name: usp_InsertUpdatePickupAddress
Description: This procedure is used to Add/update in the CustomerpickupAddress.  
Alter By:  Ajay Tiwari
Creation Date: 12 Nov 2014
Modified By(02-Jan-2015 sunil Pandey)Adding two columns name s_Address1 and s_Address2 in tbl_PickupAddress
*/
If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_InsertUpdatePickupAddress') 
Begin
   Drop Procedure usp_InsertUpdatePickupAddress
End 
Go

Create Procedure usp_InsertUpdatePickupAddress
(
@ps_xmlPickupAddress Varchar(Max),
@pn_CustomerId       Int		 
)
As  
Begin  
 SET NOCOUNT ON  
 Begin Try
	  Create Table #tempPickUpAddress
			( 
				Id					Int		        Identity(1,1) ,		
				PickupAddressId		Int             Not Null      ,	  Address			    Varchar(200)    Not Null ,	
				AuthorisedPerson	Varchar(50)		Not Null	  ,   PhoneNumber		    Varchar(15)     Null     ,     	
				Email				Varchar(50)		Not Null	  ,   MobileNo		        Varchar(11)     Null	 ,
				AuthorisedPersonId	Int				Not Null      ,	
				AuthorisedPerson1	Varchar(50)     Null   	      ,	  PhoneNumber1			Varchar(15)     Null     , 	
				Email1				Varchar(50)     Null		  ,   MobileNo1 	        Varchar(11)     Null     ,
				DepartmentId		SmallInt	    Not Null      ,  
				StateId				SmallInt		Not Null      ,	 CityId		            SmallInt        Not Null , 
				UserId				Int				Not Null	  ,  AuthorisedPersonId1	Int		        Null	 ,
				PinCode		        Varchar(8)		Not Null	  ,  IsEdit				    Bit                      ,
				Address1            Varchar(50)     Not Null      ,  Address2               Varchar(50)     Not Null
			) 
			Declare @docHandle Int;  
			Exec sp_xml_preparedocument @docHandle Output, @ps_xmlPickupAddress;  
			Insert Into #tempPickUpAddress Select * From OpenXml(@docHandle, '/NewDataSet/Root',2) With #tempPickUpAddress 
			Exec sp_xml_removedocument @docHandle;
			
		Declare @TotalCount Int 
		Declare @IncCounter Int 
		Select @TotalCount = COUNT(*) From #tempPickUpAddress
		Set @IncCounter = 1
			While(@IncCounter <=  @TotalCount)
			Begin
			
			--Insert Pickup Address ------
			
			  Insert Into tbl_PickupAddress
						   (n_CustomerId,			s_Address,				n_StateId,			n_CityId,
							n_DepartmentId,			d_ModifiedDate,			n_UserId ,          s_PinCode,s_Address1,s_Address2)
			   Select 	@pn_CustomerId ,		    Address1+''+Address2,				StateId	,          CityId,
						DepartmentId   ,			GetDate()	  ,			UserId  ,          PinCode,
					    Address1       ,            Address2
			  From #tempPickUpAddress Where  Id = @IncCounter And Isnull(IsEdit,0) = 0
			  
			  
			  --Insert AuthorisedPersons1--
			  
			  Declare @PickupAddressId Int 
			  Select @PickupAddressId = @@IDENTITY From tbl_PickupAddress
			  
			  Insert Into tbl_AuthorisedPersons
					 (n_PickupAddressId	  ,s_AuthorisedPerson  ,s_PhoneNumber ,
					  s_Email             ,d_ModifiedDate	   ,n_UserId      ,
					  s_MobileNo)
					  
			   Select @PickupAddressId	  ,AuthorisedPerson	   ,PhoneNumber	,
					  Email				  ,GetDate()		   ,UserId      ,
					  MobileNo
			   From #tempPickUpAddress   Where  Id = @IncCounter And Isnull(IsEdit,0)  =  0  And  Email!  = ''
			   
			   -- --Insert AuthorisedPersons2--
			   
			   Insert Into tbl_AuthorisedPersons
					 (n_PickupAddressId	  ,     s_AuthorisedPerson  ,  s_PhoneNumber  ,
					 s_Email              ,     d_ModifiedDate	    ,  n_UserId       ,
					 s_MobileNo)
					 
			   Select @PickupAddressId	  ,   AuthorisedPerson1   , PhoneNumber1      ,
					  Email1			  ,   GetDate()		      , UserId            ,
					  MobileNo1
			   From #tempPickUpAddress   Where  Id   =  @IncCounter  And Isnull(IsEdit,0)  =  0 And  Email1! =  '' 
			   
			   Insert Into tbl_AuthorisedPersons
							 (n_PickupAddressId	   ,   s_AuthorisedPerson   ,  s_PhoneNumber ,
							  s_Email              ,   d_ModifiedDate	   ,  n_UserId       ,
							  s_MobileNo)
							  
			  Select PickupAddressId	          ,AuthorisedPerson1   ,PhoneNumber1  ,
							  Email1			  ,GetDate()		   ,UserId        ,
							  MobileNo1
			  From #tempPickUpAddress   Where  AuthorisedPersonId1  =   0     And  Isnull(IsEdit,0) = 1 And  
			                                   Email1!              =   ''    And  Id    = @IncCounter 
			
		     Set @IncCounter = @IncCounter +1
		   End
		   
		 -----------Update  pick up address part here
		 
		 Update  tbl_PickupAddress
					Set n_CustomerId			=	@pn_CustomerId,
						s_Address				=	Address1+''+Address2,
						n_StateId				=	StateId,
						n_CityId				=	CityId,
						n_DepartmentId			=	DepartmentId,
						d_ModifiedDate			=	GETDATE(),
						n_UserId				=	UserId    ,
						s_PinCode               =   PinCode   ,
					    s_Address1              =   Address1,
						s_Address2              =   Address2
			From tbl_PickupAddress TP 
				Inner join 
			 #tempPickUpAddress TPA
			  On TP.n_PickupAddressId = TPA.PickupAddressId 
			  
		  -----------Update  AuthorisedPersons1
		  
			Update  tbl_AuthorisedPersons
						Set 
							s_AuthorisedPerson			=	TPA.AuthorisedPerson,
							s_PhoneNumber				=	TPA.PhoneNumber		,
							s_Email						=	TPA.Email			,
							d_ModifiedDate				=	GETDATE()			,
							n_UserId					=	TPA.UserId          ,
							s_MobileNo					=	TPA.MobileNo        
			From tbl_AuthorisedPersons TA
					Inner join 
			#tempPickUpAddress TPA   On 
			TA.n_AuthorisedPersonId = TPA.AuthorisedPersonId  
			Where TPA.AuthorisedPerson! = '' And  TPA.Email! = ''	  
			
		   --------Update  AuthorisedPersons2--
		   
			Update  tbl_AuthorisedPersons
					Set 
						s_AuthorisedPerson			=	TPA.AuthorisedPerson1   ,
						s_PhoneNumber				=	TPA.PhoneNumber1		,
						s_Email						=	TPA.Email1			    ,
						d_ModifiedDate				=	GETDATE()		        ,
						n_UserId					=	TPA.UserId              ,
						s_MobileNo					=	TPA.MobileNo1        
			From tbl_AuthorisedPersons TA
				Inner join 
			#tempPickUpAddress TPA    On 
			TA.n_AuthorisedPersonId   =   TPA.AuthorisedPersonId1  
			Where TPA.AuthorisedPerson1!  =  '' And  TPA.Email1!  =  ''
			
	     	----------------Delete the auth person two only
	     	
			Delete TAuthP From tbl_AuthorisedPersons TAuthP
				Left join 
			#tempPickUpAddress TPickAddr     
			On TAuthP.n_AuthorisedPersonId     =   TPickAddr.AuthorisedPersonId1
			Where TAuthP.n_AuthorisedPersonId  =   TPickAddr.AuthorisedPersonId1 And	
			TPickAddr.Email1                   =   ''     And 	
			TPickAddr.MobileNo1                =   ''     And
			TPickAddr.AuthorisedPerson1        =   '' 
			 
			Drop table #tempPickUpAddress		  				

 End Try  
 Begin Catch  
 Exec usp_GetErrorInfo  
 End Catch                                   
End
Go
