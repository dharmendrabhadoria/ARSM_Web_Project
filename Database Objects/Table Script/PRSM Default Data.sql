Insert Into tbl_ApplicationCodeMaster(s_AppCode ,s_AppCodeName)  Values ( 'ROLE'	   ,  'ADMIN')
Insert Into tbl_ApplicationCodeMaster(s_AppCode ,s_AppCodeName)  Values ( 'ROLE'	   ,  'OPERATION')
Insert Into tbl_ApplicationCodeMaster(s_AppCode ,s_AppCodeName)  Values ( 'DEPARTMENT' ,  'ACCOUNTS')
Insert Into tbl_ApplicationCodeMaster(s_AppCode ,s_AppCodeName)  Values ( 'DEPARTMENT' ,  'ADMIN')
Insert Into tbl_ApplicationCodeMaster(s_AppCode ,s_AppCodeName)  Values ( 'DEPARTMENT' ,  'CARGO')
Insert Into tbl_ApplicationCodeMaster(s_AppCode ,s_AppCodeName)  Values ( 'DEPARTMENT' ,  'CUSTOMER SUPPORT')
Insert Into tbl_ApplicationCodeMaster(s_AppCode ,s_AppCodeName)  Values ( 'DEPARTMENT' ,  'EXCISE')
Insert Into tbl_ApplicationCodeMaster(s_AppCode ,s_AppCodeName)  Values ( 'DEPARTMENT' ,  'HR')
Insert Into tbl_ApplicationCodeMaster(s_AppCode ,s_AppCodeName)  Values ( 'DEPARTMENT' ,  'IMPORT/EXPORT')
Insert Into tbl_ApplicationCodeMaster(s_AppCode ,s_AppCodeName)  Values ( 'DEPARTMENT' ,  'IT')
Insert Into tbl_ApplicationCodeMaster(s_AppCode ,s_AppCodeName)  Values ( 'DEPARTMENT' ,  'LAB')
Insert Into tbl_ApplicationCodeMaster(s_AppCode ,s_AppCodeName)  Values ( 'DEPARTMENT' ,  'LOGISTICS')
Insert Into tbl_ApplicationCodeMaster(s_AppCode ,s_AppCodeName)  Values ( 'DEPARTMENT' ,  'MARKETING')
Insert Into tbl_ApplicationCodeMaster(s_AppCode ,s_AppCodeName)  Values ( 'DEPARTMENT' ,  'OPERATIONS')
Insert Into tbl_ApplicationCodeMaster(s_AppCode ,s_AppCodeName)  Values ( 'DEPARTMENT' ,  'PRODUCTION')
Insert Into tbl_ApplicationCodeMaster(s_AppCode ,s_AppCodeName)  Values ( 'DEPARTMENT' ,  'PURCHASE')
Insert Into tbl_ApplicationCodeMaster(s_AppCode ,s_AppCodeName)  Values ( 'DEPARTMENT' ,  'R&D')
Insert Into tbl_ApplicationCodeMaster(s_AppCode ,s_AppCodeName)  Values ( 'DEPARTMENT' ,  'SALES')
Insert Into tbl_ApplicationCodeMaster(s_AppCode ,s_AppCodeName)  Values ( 'DEPARTMENT' ,  'OIL & GAS SUPPORT SERVICES')
Insert Into tbl_ApplicationCodeMaster(s_AppCode ,s_AppCodeName)  Values ( 'DEPARTMENT' ,  'Others')

Insert Into tbl_ApplicationCodeMaster (s_AppCode, s_AppCodeName) Values ('INDUSTRY','Pharmaceuticals')
Insert Into tbl_ApplicationCodeMaster (s_AppCode, s_AppCodeName) Values ('INDUSTRY','Chemicals')
Insert Into tbl_ApplicationCodeMaster (s_AppCode, s_AppCodeName) Values ('INDUSTRY','Laboratory')
Insert Into tbl_ApplicationCodeMaster (s_AppCode, s_AppCodeName) Values ('INDUSTRY','Healthcare')
Insert Into tbl_ApplicationCodeMaster (s_AppCode, s_AppCodeName) Values ('INDUSTRY','Hospital')
Insert Into tbl_ApplicationCodeMaster (s_AppCode, s_AppCodeName) Values ('INDUSTRY','Stock Broking')
Insert Into tbl_ApplicationCodeMaster (s_AppCode, s_AppCodeName) Values ('INDUSTRY','Insurance & Genral Asurance')
Insert Into tbl_ApplicationCodeMaster (s_AppCode, s_AppCodeName) Values ('INDUSTRY','Finance & Investment ')
Insert Into tbl_ApplicationCodeMaster (s_AppCode, s_AppCodeName) Values ('INDUSTRY','Manufacturing')
Insert Into tbl_ApplicationCodeMaster (s_AppCode, s_AppCodeName) Values ('INDUSTRY','Engineering')
Insert Into tbl_ApplicationCodeMaster (s_AppCode, s_AppCodeName) Values ('INDUSTRY','Bank')
Insert Into tbl_ApplicationCodeMaster (s_AppCode, s_AppCodeName) Values ('INDUSTRY','Chartered Accountant & Taxation ')
Insert Into tbl_ApplicationCodeMaster (s_AppCode, s_AppCodeName) Values ('INDUSTRY','Law / Legal')
Insert Into tbl_ApplicationCodeMaster (s_AppCode, s_AppCodeName) Values ('INDUSTRY','Builders , Real Estate, Construction')
Insert Into tbl_ApplicationCodeMaster (s_AppCode, s_AppCodeName) Values ('INDUSTRY','Architecture')
Insert Into tbl_ApplicationCodeMaster (s_AppCode, s_AppCodeName) Values ('INDUSTRY','Shipping & Logistics')
Insert Into tbl_ApplicationCodeMaster (s_AppCode, s_AppCodeName) Values ('INDUSTRY','Offshore')
Insert Into tbl_ApplicationCodeMaster (s_AppCode, s_AppCodeName) Values ('INDUSTRY','Garment & Textile')
Insert Into tbl_ApplicationCodeMaster (s_AppCode, s_AppCodeName) Values ('INDUSTRY','Retail')
Insert Into tbl_ApplicationCodeMaster (s_AppCode, s_AppCodeName) Values ('INDUSTRY','Advertisement')
Insert Into tbl_ApplicationCodeMaster (s_AppCode, s_AppCodeName) Values ('INDUSTRY','Entertainment & Media')
Insert Into tbl_ApplicationCodeMaster (s_AppCode, s_AppCodeName) Values ('INDUSTRY','Electrical / Power')
Insert Into tbl_ApplicationCodeMaster (s_AppCode, s_AppCodeName) Values ('INDUSTRY','Educational Institute')
Insert Into tbl_ApplicationCodeMaster (s_AppCode, s_AppCodeName) Values ('INDUSTRY','BPO / KPO')
Insert Into tbl_ApplicationCodeMaster (s_AppCode, s_AppCodeName) Values ('INDUSTRY','Paints')
Insert Into tbl_ApplicationCodeMaster (s_AppCode, s_AppCodeName) Values ('INDUSTRY','IT')
Go
Insert Into tbl_ApplicationCodeMaster(s_AppCode,s_AppCodeName) Values( 'WORKORDER_STATUS'	,'Open' )
Insert Into tbl_ApplicationCodeMaster(s_AppCode,s_AppCodeName) Values( 'WORKORDER_STATUS' ,'Closed' )
Insert Into tbl_ApplicationCodeMaster(s_AppCode,s_AppCodeName) Values( 'BOXFILE_STATUS' ,'In' )
Insert Into tbl_ApplicationCodeMaster(s_AppCode,s_AppCodeName) Values( 'BOXFILE_STATUS' ,'Out' )
Insert Into tbl_ApplicationCodeMaster(s_AppCode,s_AppCodeName) Values( 'BOXFILE_STATUS' ,'Permanent Out' )
Insert Into tbl_ApplicationCodeMaster(s_AppCode,s_AppCodeName) Values( 'BOXFILE_STATUS' ,'Destroy' )
Insert Into tbl_ApplicationCodeMaster(s_AppCode,s_AppCodeName) Values( 'ACTIVITY_STATUS' ,'Open' )
Insert Into tbl_ApplicationCodeMaster(s_AppCode,s_AppCodeName) Values( 'ACTIVITY_STATUS' ,'Closed' )
Insert Into tbl_ApplicationCodeMaster(s_AppCode,s_AppCodeName)  Values('TAX_NAME','HIGHER EDUCATION')
Insert Into tbl_ApplicationCodeMaster(s_AppCode,s_AppCodeName)  Values('TAX_NAME','EDUCATION CESS')
Insert Into tbl_ApplicationCodeMaster(s_AppCode,s_AppCodeName)  Values('TAX_NAME','SERVICE TAX')
Insert Into tbl_ApplicationCodeMaster(s_AppCode,s_AppCodeName)  Values('TAX_NAME','OTHER TAX')
Go
Declare @n_UserRole SmallInt
Declare @n_Department SmallInt
Set @n_UserRole = (Select Top 1 n_AppCodeId  From tbl_ApplicationCodeMaster Where s_AppCode = 'ROLE' And  s_AppCodeName = 'ADMIN' )
Set @n_Department = (Select Top 1 n_AppCodeId  From tbl_ApplicationCodeMaster Where s_AppCode = 'DEPARTMENT' And  s_AppCodeName = 'PURCHASE' )

Insert Into tbl_UserMaster (s_FirstName , s_MiddleName ,s_LastName    , d_BirthDate ,n_Department
							,s_EmailId  , s_Password   ,b_LoginStatus , n_IsActive  ,n_UserRole ,d_ModifiedDate,s_UserName  )
			Values
							('Admin'   , '-'		  ,'A'		     , GetDate()      , @n_Department
							,'admin@prsm.com', 'P5VAyRvJIdQ='   ,0		   , 1		  ,	@n_UserRole ,GetDate(),'prsmadmin' )
Go
Insert Into tbl_ApplicationCodeMaster Values('PAGE_NAME','Master')
Insert Into tbl_ApplicationCodeMaster Values('PAGE_NAME','Service Category')
Insert Into tbl_ApplicationCodeMaster Values('PAGE_NAME','Activity')
Insert Into tbl_ApplicationCodeMaster Values('PAGE_NAME','Company Group')
Insert Into tbl_ApplicationCodeMaster Values('PAGE_NAME','Customer')
Insert Into tbl_ApplicationCodeMaster Values('PAGE_NAME','Rate Card')
Insert Into tbl_ApplicationCodeMaster Values('PAGE_NAME','User Master')
Insert Into tbl_ApplicationCodeMaster Values('PAGE_NAME','City')
Insert Into tbl_ApplicationCodeMaster Values('PAGE_NAME','WareHouse')
Insert Into tbl_ApplicationCodeMaster Values('PAGE_NAME','Rack')
Insert Into tbl_ApplicationCodeMaster Values('PAGE_NAME','View Contract')
Insert Into tbl_ApplicationCodeMaster Values('PAGE_NAME','Transaction')
Insert Into tbl_ApplicationCodeMaster Values('PAGE_NAME','Work Order')
Insert Into tbl_ApplicationCodeMaster Values('PAGE_NAME','Fresh Pick-up')
Insert Into tbl_ApplicationCodeMaster Values('PAGE_NAME','Inward/Outward')
Insert Into tbl_ApplicationCodeMaster Values('PAGE_NAME','Permanent Return')
Insert Into tbl_ApplicationCodeMaster Values('PAGE_NAME','Other Services')
Insert Into tbl_ApplicationCodeMaster Values('PAGE_NAME','Monthly Invoice')
Insert Into tbl_ApplicationCodeMaster Values('PAGE_NAME','User')
Insert Into tbl_ApplicationCodeMaster Values('PAGE_NAME','User Rights')
Insert Into tbl_ApplicationCodeMaster Values('PAGE_NAME','Access Rights')
Insert Into tbl_ApplicationCodeMaster Values('PAGE_NAME','Bulk Access Rights')
Insert Into tbl_ApplicationCodeMaster Values('PAGE_NAME','Print BarCodes')
Insert Into tbl_ApplicationCodeMaster Values('PAGE_NAME','Company Master')
Insert Into tbl_ApplicationCodeMaster Values('PAGE_NAME','Box Location')
Insert Into tbl_ApplicationCodeMaster Values('PAGE_NAME','In House Management')
Insert Into tbl_ApplicationCodeMaster Values('PAGE_NAME','Generate Invoice')
select * from tbl_PageFunctionality
--Master--
Declare @pageId SmallInt
Select @pageId =  n_AppCodeId From  tbl_ApplicationCodeMaster Where s_AppCodeName = 'Master'
Insert Into tbl_PageFunctionality Values(@pageId,1,'Master',1,getdate())
--Service Category--
Select @pageId =  n_AppCodeId From  tbl_ApplicationCodeMaster Where s_AppCodeName = 'Service Category'
Insert Into tbl_PageFunctionality Values(@pageId,1,'Service Category',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Save',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Clear',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Edit',1,getdate())
--Activity--
Select @pageId =  n_AppCodeId From  tbl_ApplicationCodeMaster Where s_AppCodeName = 'Activity'
Insert Into tbl_PageFunctionality Values(@pageId,1,'Activity',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Save',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Clear',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Edit',1,getdate())
--Company Group--
Select @pageId =  n_AppCodeId From  tbl_ApplicationCodeMaster Where s_AppCodeName = 'Company Group'
Insert Into tbl_PageFunctionality Values(@pageId,1,'Company Group',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Save',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Clear',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Edit',1,getdate())
--Customer--
Select @pageId =  n_AppCodeId From  tbl_ApplicationCodeMaster Where s_AppCodeName = 'Customer'
Insert Into tbl_PageFunctionality Values(@pageId,1,'Customer',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Save',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Clear',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Add',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Search',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Edit',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Contract',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'RateCard',1,getdate())
--Rate Card--
Select @pageId =  n_AppCodeId From  tbl_ApplicationCodeMaster Where s_AppCodeName = 'Rate Card'
Insert Into tbl_PageFunctionality Values(@pageId,1,'Rate Card',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Save',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Clear',1,getdate())
--User Master--
Select @pageId =  n_AppCodeId From  tbl_ApplicationCodeMaster Where s_AppCodeName = 'User Master'
Insert Into tbl_PageFunctionality Values(@pageId,1,'User Master',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Save',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Clear',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Edit',1,getdate())
--City--
Select @pageId =  n_AppCodeId From  tbl_ApplicationCodeMaster Where s_AppCodeName = 'City'
Insert Into tbl_PageFunctionality Values(@pageId,1,'City',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Save',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Clear',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Edit',1,getdate())
--WareHouse--
Select @pageId =  n_AppCodeId From  tbl_ApplicationCodeMaster Where s_AppCodeName = 'WareHouse'
Insert Into tbl_PageFunctionality Values(@pageId,1,'WareHouse',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Save',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Clear',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Edit',1,getdate())
--Rack--
Select @pageId =  n_AppCodeId From  tbl_ApplicationCodeMaster Where s_AppCodeName = 'Rack'
Insert Into tbl_PageFunctionality Values(@pageId,1,'Rack',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Save',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Clear',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Edit',1,getdate())
--View Contract--
Select @pageId =  n_AppCodeId From  tbl_ApplicationCodeMaster Where s_AppCodeName = 'View Contract'
Insert Into tbl_PageFunctionality Values(@pageId,1,'View Contract',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'View',1,getdate())
--Transaction--
Select @pageId =  n_AppCodeId From  tbl_ApplicationCodeMaster Where s_AppCodeName = 'Transaction'
Insert Into tbl_PageFunctionality Values(@pageId,1,'Transaction',1,getdate())
--Work Order--
Select @pageId =  n_AppCodeId From  tbl_ApplicationCodeMaster Where s_AppCodeName = 'Work Order'
Insert Into tbl_PageFunctionality Values(@pageId,1,'Work Order',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Save',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Clear',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Add',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Search',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'View Details',1,getdate())
--Fresh Pick-up--
Select @pageId =  n_AppCodeId From  tbl_ApplicationCodeMaster Where s_AppCodeName = 'Fresh Pick-up'
Insert Into tbl_PageFunctionality Values(@pageId,1,'Fresh Pick-up',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Save',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Clear',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Add',1,getdate())
--Inward/Outward--
Select @pageId =  n_AppCodeId From  tbl_ApplicationCodeMaster Where s_AppCodeName = 'Inward/Outward'
Insert Into tbl_PageFunctionality Values(@pageId,1,'Inward/Outward',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Save',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Clear',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Search',1,getdate())
--Permanent Return--
Select @pageId =  n_AppCodeId From  tbl_ApplicationCodeMaster Where s_AppCodeName = 'Permanent Return'
Insert Into tbl_PageFunctionality Values(@pageId,1,'Permanent Return',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Save',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Clear',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Search',1,getdate())
--Other Services--
Select @pageId =  n_AppCodeId From  tbl_ApplicationCodeMaster Where s_AppCodeName = 'Other Services'
Insert Into tbl_PageFunctionality Values(@pageId,1,'Other Services',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Save',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Clear',1,getdate())
--Monthly Invoice--
Select @pageId =  n_AppCodeId From  tbl_ApplicationCodeMaster Where s_AppCodeName = 'Monthly Invoice'
Insert Into tbl_PageFunctionality Values(@pageId,1,'Monthly Invoice',1,getdate())
--Users--
Select @pageId =  n_AppCodeId From  tbl_ApplicationCodeMaster Where s_AppCodeName = 'User'
Insert Into tbl_PageFunctionality Values(@pageId,1,'User',1,getdate())
--User Rights--
Select @pageId =  n_AppCodeId From  tbl_ApplicationCodeMaster Where s_AppCodeName = 'User Rights'
Insert Into tbl_PageFunctionality Values(@pageId,1,'User Rights',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Save',1,getdate())
--Access Rights--
Select @pageId =  n_AppCodeId From  tbl_ApplicationCodeMaster Where s_AppCodeName = 'Access Rights'
Insert Into tbl_PageFunctionality Values(@pageId,1,'Access Rights',1,getdate())
--Bulk Access Rights--
Select @pageId =  n_AppCodeId From  tbl_ApplicationCodeMaster Where s_AppCodeName = 'Bulk Access Rights'
Insert Into tbl_PageFunctionality Values(@pageId,1,'Bulk Access Rights',1,getdate())
--Print BarCodes--
Select @pageId =  n_AppCodeId From  tbl_ApplicationCodeMaster Where s_AppCodeName = 'Print BarCodes'
Insert Into tbl_PageFunctionality Values(@pageId,1,'Print BarCodes',1,getdate())
--Company Master--
Select @pageId =  n_AppCodeId From  tbl_ApplicationCodeMaster Where s_AppCodeName = 'Company Master'
Insert Into tbl_PageFunctionality Values(@pageId,1,'Company Master',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Save',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Clear',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Edit',1,getdate())
--Box Location--
Select @pageId =  n_AppCodeId From  tbl_ApplicationCodeMaster Where s_AppCodeName = 'Box Location'
Insert Into tbl_PageFunctionality Values(@pageId,1,'Box Location',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Search',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Submit',1,getdate())-- Added 31-10-2014
--In House Management--
Select @pageId =  n_AppCodeId From  tbl_ApplicationCodeMaster Where s_AppCodeName = 'In House Management'
Insert Into tbl_PageFunctionality Values(@pageId,1,'In House Mangement',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Save',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Clear',1,getdate())
--Generate Invoice--
Select @pageId =  n_AppCodeId From  tbl_ApplicationCodeMaster Where s_AppCodeName = 'Generate Invoice'
Insert Into tbl_PageFunctionality Values(@pageId,1,'Generate Invoice',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Save',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Search',1,getdate())
Insert Into tbl_PageFunctionality Values(@pageId,0,'Clear',1,getdate())
Go



Insert Into  tbl_CountryMaster(s_CountryName )    Values ('India')
Go

Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'Andaman and Nicobar Islands')
Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'Andhra Pradesh')
Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'Arunachal Pradesh')
Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'Assam')
Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'Bihar')
Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'Chandigarh')
Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'Chhattisgarh')
Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'Dadra and Nagar Haveli')
Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'Daman and Diu')
Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'Delhi')
Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'Goa')
Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'Gujarat')
Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'Haryana')
Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'Himachal Pradesh')
Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'Jammu and Kashmir')
Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'Jharkhand')
Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'Karnataka')
Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'Kerala')
Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'Lakshadweep')
Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'Madhya Pradesh')
Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'Maharashtra')
Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'Manipur')
Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'Meghalaya')
Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'Mizoram')
Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'Nagaland')
Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'Orissa')
Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'Puducherry')
Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'Punjab')
Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'Rajasthan')
Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'Sikkim')
Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'Tamil Nadu')
Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'Telangana')
Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'Tripura')
Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'Uttar Pradesh')
Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'Uttarakhand')
Insert Into  tbl_StateMaster (n_CountryId , s_StateName   )    Values	( 1  , 'West Bengal')
Go

Insert Into tbl_CityMaster (s_CityName ,n_StateId ,n_UserId ,d_ModifiedDate) Values 	( 'Mumbai'			 ,  21 , 1 , GetDate()  )
Insert Into tbl_CityMaster (s_CityName ,n_StateId ,n_UserId ,d_ModifiedDate) Values 	( 'Pune'			 ,  21 , 1 , GetDate()  )
Insert Into tbl_CityMaster (s_CityName ,n_StateId ,n_UserId ,d_ModifiedDate) Values 	( 'Nagpur'			 ,  21 , 1 , GetDate()  )
Insert Into tbl_CityMaster (s_CityName ,n_StateId ,n_UserId ,d_ModifiedDate) Values 	( 'Thane'			 ,  21 , 1 , GetDate()  )
Insert Into tbl_CityMaster (s_CityName ,n_StateId ,n_UserId ,d_ModifiedDate) Values 	( 'Pimpri-Chinchwad' ,  21 , 1 , GetDate()  )
Insert Into tbl_CityMaster (s_CityName ,n_StateId ,n_UserId ,d_ModifiedDate) Values 	( 'Nashik'			 ,  21 , 1 , GetDate()  )
Insert Into tbl_CityMaster (s_CityName ,n_StateId ,n_UserId ,d_ModifiedDate) Values 	( 'Kalyan-Dombivali' ,   21 , 1 , GetDate()  )
Insert Into tbl_CityMaster (s_CityName ,n_StateId ,n_UserId ,d_ModifiedDate) Values 	( 'Vasai-Virar'		 ,   21 , 1 , GetDate()  )
Insert Into tbl_CityMaster (s_CityName ,n_StateId ,n_UserId ,d_ModifiedDate) Values 	( 'Aurangabad'		 ,   21 , 1 , GetDate()  )
Insert Into tbl_CityMaster (s_CityName ,n_StateId ,n_UserId ,d_ModifiedDate) Values 	( 'Solapur'			 ,   21 , 1 , GetDate()  )
Insert Into tbl_CityMaster (s_CityName ,n_StateId ,n_UserId ,d_ModifiedDate) Values 	( 'Bhiwandi'		 ,   21 , 1 , GetDate()  )
Insert Into tbl_CityMaster (s_CityName ,n_StateId ,n_UserId ,d_ModifiedDate) Values 	( 'Amravati'		 ,   21 , 1 , GetDate()  )
Insert Into tbl_CityMaster (s_CityName ,n_StateId ,n_UserId ,d_ModifiedDate) Values 	( 'Nanded'			 ,   21 , 1 , GetDate()  )
Insert Into tbl_CityMaster (s_CityName ,n_StateId ,n_UserId ,d_ModifiedDate) Values 	( 'Jalgaon'			 ,   21 , 1 , GetDate()  )
Insert Into tbl_CityMaster (s_CityName ,n_StateId ,n_UserId ,d_ModifiedDate) Values 	( 'Ratnagiri'		 ,   21 , 1 , GetDate())
Go

Insert Into tbl_ServiceCategory (s_SCName,s_Remark,b_IsEdit,d_ModifiedDate,n_UserId) Values( 'Destruction'			,  NULL , 0 , GetDate() , 1 )
Insert Into tbl_ServiceCategory (s_SCName,s_Remark,b_IsEdit,d_ModifiedDate,n_UserId) Values( 'In-House management' ,  NULL , 0 , GetDate() , 1 )
Insert Into tbl_ServiceCategory (s_SCName,s_Remark,b_IsEdit,d_ModifiedDate,n_UserId) Values( 'Other services'		,  NULL , 0 , GetDate() , 1 )
Insert Into tbl_ServiceCategory (s_SCName,s_Remark,b_IsEdit,d_ModifiedDate,n_UserId) Values( 'Permanent Return'		,  NULL , 0 , GetDate() , 1 )
Insert Into tbl_ServiceCategory (s_SCName,s_Remark,b_IsEdit,d_ModifiedDate,n_UserId) Values( 'File Pick Up'			,  NULL , 0 , GetDate() , 1 )
Insert Into tbl_ServiceCategory (s_SCName,s_Remark,b_IsEdit,d_ModifiedDate,n_UserId) Values( 'Retrieval'			,  NULL , 0 , GetDate() , 1 )
Insert Into tbl_ServiceCategory (s_SCName,s_Remark,b_IsEdit,d_ModifiedDate,n_UserId) Values( 'Record Management Charges'			,  NULL , 0 , GetDate() , 1 )
Go

Go
/* 1 - 'Per Box Per Month' 2 - 'Per File' 3 - 'Per Box' 4 - 'Per Unit' 
 */	
 Declare @UserId Int
Select Top 1 @UserId = n_UserId   From tbl_UserMaster 
Declare @CategoryId Int ;   Select @CategoryId = n_ServiceCategoryId   From tbl_ServiceCategory Where   s_SCName  = 'File Pick Up' 				
Insert Into tbl_Activity (s_ActivityName,n_ServiceCategoryId,s_Remark		 ,b_IsEdit,n_Unit,
						  n_UnitCount	,b_IsShowinRateCard ,d_ModifiedDate  ,n_UserId) 
Values ( 'New Standard Box Cost (1.50 Cubic Ft.)', 
			@CategoryId,
			NULL ,
			 0 ,1,1,1, GetDate() , @UserId )	
			 GO
			  Declare @UserId Int
Select Top 1 @UserId = n_UserId   From tbl_UserMaster 

Declare @CategoryId Int ;   Select @CategoryId = n_ServiceCategoryId   From tbl_ServiceCategory Where   s_SCName  = 'File Pick Up' 							 
Insert Into tbl_Activity (s_ActivityName,n_ServiceCategoryId,s_Remark		 ,b_IsEdit,n_Unit,
						  n_UnitCount	,b_IsShowinRateCard ,d_ModifiedDate  ,n_UserId) 
 Values ( 'Bar-coding & Data Entry (File & Box)',
		   @CategoryId,
		    NULL ,
		   0 ,1,1,1, GetDate() , @UserId )	
		    GO
			  Declare @UserId Int
Select Top 1 @UserId = n_UserId   From tbl_UserMaster 
Declare @CategoryId Int ;   Select @CategoryId = n_ServiceCategoryId   From tbl_ServiceCategory Where   s_SCName  = 'File Pick Up' 							 
Insert Into tbl_Activity (s_ActivityName,n_ServiceCategoryId,s_Remark		 ,b_IsEdit,n_Unit,
						  n_UnitCount	,b_IsShowinRateCard ,d_ModifiedDate  ,n_UserId) 
 Values( 'Standard Box Transportation ',
		 @CategoryId,
		 NULL , 
		  0 ,1,1,1, GetDate() , @UserId )	
		  GO
		  			  Declare @UserId Int
Select Top 1 @UserId = n_UserId   From tbl_UserMaster 
Declare @CategoryId Int ; 
 Select @CategoryId = n_ServiceCategoryId   From tbl_ServiceCategory Where   s_SCName  = 'Record Management Charges' 				
 Select @CategoryId
Insert Into tbl_Activity (s_ActivityName,n_ServiceCategoryId,s_Remark		 ,b_IsEdit,n_Unit,
						  n_UnitCount	,b_IsShowinRateCard ,d_ModifiedDate  ,n_UserId) 
						   Values ( '1 to 250 Standard Box (1.50 Cubic Ft)',
						    @CategoryId, 
						    NULL ,
						    0 ,1,1,1, GetDate() , @UserId )
Insert Into tbl_Activity (s_ActivityName,n_ServiceCategoryId,s_Remark		 ,b_IsEdit,n_Unit,
						  n_UnitCount	,b_IsShowinRateCard ,d_ModifiedDate  ,n_UserId) 
			Values ( '250 to 1000 Standard Box (1.50 Cubic Ft)',
		    @CategoryId,
		    NULL ,
		    0 ,1,1,1, GetDate() , @UserId )
Insert Into tbl_Activity (s_ActivityName,n_ServiceCategoryId,s_Remark,b_IsEdit,n_Unit, n_UnitCount,b_IsShowinRateCard,d_ModifiedDate,n_UserId) 
						   Values 
						   ( '1001 to 2500 Standard Box (1.50 Cubic Ft)',
						    @CategoryId,
						     NULL , 
						     0 ,1,1,1, GetDate() , @UserId )	
Insert Into tbl_Activity (s_ActivityName,n_ServiceCategoryId,s_Remark		 ,b_IsEdit,n_Unit,
						  n_UnitCount	,b_IsShowinRateCard ,d_ModifiedDate  ,n_UserId) 
						   Values ( '2501 & Above Standard Box (1.50 Cubic Ft)',
						    @CategoryId,
						    NULL ,
						    0 ,1,1,1, GetDate() , @UserId )	
						        	
Go
		  			  Declare @UserId Int
Select Top 1 @UserId = n_UserId   From tbl_UserMaster 
Declare @CategoryId Int ; 

 Select  @CategoryId = n_ServiceCategoryId   From tbl_ServiceCategory Where   s_SCName  = 'Retrieval' 				
Insert Into tbl_Activity (s_ActivityName,n_ServiceCategoryId,s_Remark,b_IsEdit,n_Unit, n_UnitCount,b_IsShowinRateCard,d_ModifiedDate,n_UserId)  Values ( 'File Retrievals  Regular (Within 24 hours)', @CategoryId, NULL ,0 ,2,1,1, GetDate() , @UserId )	
Insert Into tbl_Activity (s_ActivityName,n_ServiceCategoryId,s_Remark,b_IsEdit,n_Unit, n_UnitCount,b_IsShowinRateCard,d_ModifiedDate,n_UserId)  Values ( 'File Retrievals  Express (Within 12 hours)', @CategoryId, NULL ,0 ,2,1,1, GetDate() , @UserId )	
Insert Into tbl_Activity (s_ActivityName,n_ServiceCategoryId,s_Remark,b_IsEdit,n_Unit, n_UnitCount,b_IsShowinRateCard,d_ModifiedDate,n_UserId)  Values ( 'Box Retrievals   Regular (Within 24 hours)', @CategoryId, NULL ,0 ,3,1,1, GetDate() , @UserId )	
Insert Into tbl_Activity (s_ActivityName,n_ServiceCategoryId,s_Remark,b_IsEdit,n_Unit, n_UnitCount,b_IsShowinRateCard,d_ModifiedDate,n_UserId)  Values ( 'Box Retrievals   Express (Within 12 hours)', @CategoryId, NULL ,0 ,3,1,1, GetDate() , @UserId )	

Insert Into tbl_Activity (s_ActivityName,n_ServiceCategoryId,s_Remark,b_IsEdit,n_Unit, n_UnitCount,b_IsShowinRateCard,d_ModifiedDate,n_UserId)  Values ( 'File Restore Regular (Within 24 hours)', @CategoryId, NULL ,0 ,2,1,1, GetDate() , @UserId )	
Insert Into tbl_Activity (s_ActivityName,n_ServiceCategoryId,s_Remark,b_IsEdit,n_Unit, n_UnitCount,b_IsShowinRateCard,d_ModifiedDate,n_UserId)  Values ( 'File Restore Express (Within 12 hours)', @CategoryId, NULL ,0 ,2,1,1, GetDate() , @UserId )	
Insert Into tbl_Activity (s_ActivityName,n_ServiceCategoryId,s_Remark,b_IsEdit,n_Unit, n_UnitCount,b_IsShowinRateCard,d_ModifiedDate,n_UserId)  Values ( 'Box  Restore Regular (Within 24 hours)', @CategoryId, NULL ,0 ,3,1,1, GetDate() , @UserId )	
Insert Into tbl_Activity (s_ActivityName,n_ServiceCategoryId,s_Remark,b_IsEdit,n_Unit, n_UnitCount,b_IsShowinRateCard,d_ModifiedDate,n_UserId)  Values ( 'Box  Restore Express (Within 12 hours)', @CategoryId, NULL ,0 ,3,1,1, GetDate() , @UserId )	

Insert Into tbl_Activity (s_ActivityName,n_ServiceCategoryId,s_Remark,b_IsEdit,n_Unit, n_UnitCount,b_IsShowinRateCard,d_ModifiedDate,n_UserId)  Values ( 'Hand Delivery Charges Regular [(Within 24 hours) Max 4 box files / One Full Box]', @CategoryId, NULL ,0 ,1,1,1, GetDate() , @UserId )	
Insert Into tbl_Activity (s_ActivityName,n_ServiceCategoryId,s_Remark,b_IsEdit,n_Unit, n_UnitCount,b_IsShowinRateCard,d_ModifiedDate,n_UserId)  Values ( 'Hand Delivery Charges Express [(Within 12 hours) Max 4 box files / One Full Box]', @CategoryId, NULL ,0 ,1,1,1, GetDate() , @UserId )	
Go
		  			  Declare @UserId Int
Select Top 1 @UserId = n_UserId   From tbl_UserMaster 
Declare @CategoryId Int ; 

 Select @CategoryId = n_ServiceCategoryId   From tbl_ServiceCategory Where   s_SCName  = 'Destruction' 				
Insert Into tbl_Activity (s_ActivityName,n_ServiceCategoryId,s_Remark,b_IsEdit,n_Unit, n_UnitCount,b_IsShowinRateCard,d_ModifiedDate,n_UserId)  Values ( 'File Shredding', @CategoryId, NULL ,0 ,3,1,1, GetDate() , @UserId )	
Insert Into tbl_Activity (s_ActivityName,n_ServiceCategoryId,s_Remark,b_IsEdit,n_Unit, n_UnitCount,b_IsShowinRateCard,d_ModifiedDate,n_UserId)  Values ( 'Destruction – Miscellaneous service', @CategoryId, NULL ,0 ,3,1,1, GetDate() , @UserId )	

 Select @CategoryId =  n_ServiceCategoryId   From tbl_ServiceCategory Where   s_SCName  = 'Permanent Return' 				
Insert Into tbl_Activity (s_ActivityName,n_ServiceCategoryId,s_Remark,b_IsEdit,n_Unit, n_UnitCount,b_IsShowinRateCard,d_ModifiedDate,n_UserId)  Values ( 'File return', @CategoryId, NULL ,0 ,3,1,1, GetDate() , @UserId )	
Insert Into tbl_Activity (s_ActivityName,n_ServiceCategoryId,s_Remark,b_IsEdit,n_Unit, n_UnitCount,b_IsShowinRateCard,d_ModifiedDate,n_UserId)  Values ( 'Return transportation', @CategoryId, NULL ,0 ,4,1,1, GetDate() , @UserId )	
Insert Into tbl_Activity (s_ActivityName,n_ServiceCategoryId,s_Remark,b_IsEdit,n_Unit, n_UnitCount,b_IsShowinRateCard,d_ModifiedDate,n_UserId)  Values ( 'Return – Miscellaneous service', @CategoryId, NULL ,0 ,4,1,1, GetDate() , @UserId )	
Go
		  			  Declare @UserId Int
Select Top 1 @UserId = n_UserId   From tbl_UserMaster 
Declare @CategoryId Int ; 
 Select @CategoryId = n_ServiceCategoryId   From tbl_ServiceCategory Where   s_SCName  = 'Other services' 				
Insert Into tbl_Activity (s_ActivityName,n_ServiceCategoryId,s_Remark,b_IsEdit,n_Unit, n_UnitCount,b_IsShowinRateCard,d_ModifiedDate,n_UserId)  Values ( 'Scanning & Email', @CategoryId, NULL ,0 ,4,1,1, GetDate() , @UserId )	
Insert Into tbl_Activity (s_ActivityName,n_ServiceCategoryId,s_Remark,b_IsEdit,n_Unit, n_UnitCount,b_IsShowinRateCard,d_ModifiedDate,n_UserId)  Values ( 'Photocopy', @CategoryId, NULL , 0 ,4,1,1, GetDate() , @UserId )	
Insert Into tbl_Activity (s_ActivityName,n_ServiceCategoryId,s_Remark,b_IsEdit,n_Unit, n_UnitCount,b_IsShowinRateCard,d_ModifiedDate,n_UserId)  Values ( 'Fax – local', @CategoryId, NULL ,0 ,4,1,1, GetDate() , @UserId )	
Insert Into tbl_Activity (s_ActivityName,n_ServiceCategoryId,s_Remark,b_IsEdit,n_Unit, n_UnitCount,b_IsShowinRateCard,d_ModifiedDate,n_UserId)  Values ( 'Fax – STD', @CategoryId, NULL ,0 ,4,1,1, GetDate() , @UserId )	
Insert Into tbl_Activity (s_ActivityName,n_ServiceCategoryId,s_Remark,b_IsEdit,n_Unit, n_UnitCount,b_IsShowinRateCard,d_ModifiedDate,n_UserId)  Values ( 'Document Searching & Insertion', @CategoryId, NULL ,0 ,4,1,1, GetDate() , @UserId )	
Insert Into tbl_Activity (s_ActivityName,n_ServiceCategoryId,s_Remark,b_IsEdit,n_Unit, n_UnitCount,b_IsShowinRateCard,d_ModifiedDate,n_UserId)  Values ( 'Audit Room Charges', @CategoryId, NULL ,0 ,4,1,1, GetDate() , @UserId )	
				

 Select @CategoryId = n_ServiceCategoryId   From tbl_ServiceCategory Where   s_SCName  = 'In-House management' 				
Insert Into tbl_Activity (s_ActivityName,n_ServiceCategoryId,s_Remark,b_IsEdit,n_Unit, n_UnitCount,b_IsShowinRateCard,d_ModifiedDate,n_UserId)  Values ( 'In-house management  charges', @CategoryId, NULL ,0 ,4,1,0, GetDate() , @UserId )
Insert Into tbl_Activity (s_ActivityName,n_ServiceCategoryId,s_Remark,b_IsEdit,n_Unit, n_UnitCount,b_IsShowinRateCard,d_ModifiedDate,n_UserId)  Values ( 'IHM - Reimbursement of expense', @CategoryId, NULL ,0 ,4,1,0, GetDate() , @UserId )	
Insert Into tbl_Activity (s_ActivityName,n_ServiceCategoryId,s_Remark,b_IsEdit,n_Unit, n_UnitCount,b_IsShowinRateCard,d_ModifiedDate,n_UserId)  Values ( 'IHM – Extra service cost', @CategoryId, NULL ,0 ,4,1,0, GetDate() , @UserId )
Insert Into tbl_Activity (s_ActivityName,n_ServiceCategoryId,s_Remark,b_IsEdit,n_Unit, n_UnitCount,b_IsShowinRateCard,d_ModifiedDate,n_UserId)  Values ( 'IHM – Miscellaneous service', @CategoryId, NULL ,0 ,4,1,0, GetDate() , @UserId )
Go
----'Inward/Outward'
Declare @nPageId Int
SELECT @nPageId = n_AppCodeId 
FROM tbl_ApplicationCodeMaster Where s_AppCodeName  = 'Inward/Outward'
Print @nPageId

Insert Into tbl_PagewiseActivity(n_PageId,n_ActivityId) 
Select @nPageId,n_ActivityId From tbl_Activity Where n_ServiceCategoryId
  In(Select Top 1 n_ServiceCategoryId  From tbl_ServiceCategory Where s_SCName  = 'Retrieval') 
Go
----'Permanent Return'
Declare @nPageId4 Int
SELECT @nPageId4 = n_AppCodeId 
FROM tbl_ApplicationCodeMaster Where s_AppCodeName  = 'Permanent Return'
Print @nPageId4
Insert Into tbl_PagewiseActivity(n_PageId,n_ActivityId) 
Select @nPageId4,n_ActivityId From tbl_Activity Where n_ServiceCategoryId  In(Select Top 1 n_ServiceCategoryId  From tbl_ServiceCategory Where  s_SCName  = 'Permanent Return' )
Go
----'Fresh Pick-up'
Declare @nPageId1 Int
SELECT @nPageId1 = n_AppCodeId 
FROM tbl_ApplicationCodeMaster Where s_AppCodeName  = 'Fresh Pick-up'
Print @nPageId1
Insert Into tbl_PagewiseActivity(n_PageId,n_ActivityId) 
Select @nPageId1,n_ActivityId From tbl_Activity Where n_ServiceCategoryId In(Select Top 1 n_ServiceCategoryId  From tbl_ServiceCategory Where  s_SCName  = 'File Pick Up' )
Go
----'Work Order'
Declare @nPageId5 Int
SELECT @nPageId5 = n_AppCodeId 
FROM tbl_ApplicationCodeMaster Where s_AppCodeName  = 'Work Order'
Print @nPageId5
Insert Into tbl_PagewiseActivity(n_PageId,n_ActivityId) 
Select @nPageId5,n_ActivityId From tbl_Activity 
Go
--'Other Services'
Declare @nPageId2 Int
SELECT @nPageId2 = n_AppCodeId 
FROM tbl_ApplicationCodeMaster Where s_AppCodeName  = 'Other Services'
--Print @nPageId2
Insert Into tbl_PagewiseActivity(n_PageId,n_ActivityId) 
Select @nPageId2,n_ActivityId From tbl_Activity Where   n_ServiceCategoryId In(Select Top 1 n_ServiceCategoryId  From tbl_ServiceCategory Where  s_SCName  = 'Other services' )

Go
--'In House Mangement'
Declare @nPageId3 Int
SELECT @nPageId3 = n_AppCodeId 
FROM tbl_ApplicationCodeMaster Where s_AppCodeName  = 'In House Management'
--Print @nPageId3
Insert Into tbl_PagewiseActivity(n_PageId,n_ActivityId) 
Select @nPageId3,n_ActivityId From tbl_Activity Where  n_ServiceCategoryId In(Select Top 1 n_ServiceCategoryId  From tbl_ServiceCategory Where  s_SCName  = 'In-House management' )
Go	
Update tbl_UserMaster sET s_Password  = 'P5VAyRvJIdQ='
Update tbl_UserMaster Set s_UserName  = 'prsmadmin'
Declare @pageId1 Int
Select @pageId1 =  n_AppCodeId From  tbl_ApplicationCodeMaster Where s_AppCodeName = 'User Rights'
Declare @n_RoleId SmallInt
Select @n_RoleId= n_UserRole  From tbl_UserMaster 
Declare @n_PageFunctionId SmallInt
Select @n_PageFunctionId = n_PageFunctionId  From tbl_PageFunctionality Where n_PageId In(@pageId1)
Insert Into tbl_RoleWiseAccess (n_RoleId,n_PageFunctionId,
n_Enable,d_ModifiedDate) Values
(@n_RoleId,@n_PageFunctionId,1,GETDATE())

Go


Declare @TaxId SmallInt
Declare @ModifedBy SmallInt
Select Top 1 @ModifedBy = n_UserId   From tbl_UserMaster 
Select @TaxId = n_AppCodeId  From tbl_ApplicationCodeMaster Where s_AppCode = 'TAX_NAME' and s_AppCodeName = 'HIGHER EDUCATION'
Insert Into tbl_TaxMaster
           (n_TaxId , n_TaxValue , d_FromDate     , d_Todate ,d_ModifiedDate, n_ModifiedBy)
     Values(@TaxId  , 0		 , GETDATE()      , Null     , GETDATE()    ,@ModifedBy)	
Select @TaxId = n_AppCodeId  From tbl_ApplicationCodeMaster Where s_AppCode = 'TAX_NAME' and s_AppCodeName = 'EDUCATION CESS'
Insert Into tbl_TaxMaster
           (n_TaxId , n_TaxValue , d_FromDate     , d_Todate ,d_ModifiedDate, n_ModifiedBy)
     Values(@TaxId  , 0		 , GETDATE()      , Null     , GETDATE()    ,@ModifedBy)	
Select @TaxId = n_AppCodeId  From tbl_ApplicationCodeMaster Where s_AppCode = 'TAX_NAME' and s_AppCodeName = 'SERVICE TAX'
Insert Into tbl_TaxMaster
           (n_TaxId , n_TaxValue , d_FromDate     , d_Todate ,d_ModifiedDate, n_ModifiedBy)
     Values(@TaxId  , 0		 , GETDATE()      , Null     , GETDATE()    ,@ModifedBy)	
Select @TaxId = n_AppCodeId  From tbl_ApplicationCodeMaster Where s_AppCode = 'TAX_NAME' and s_AppCodeName = 'OTHER TAX'
Insert Into tbl_TaxMaster
           (n_TaxId , n_TaxValue , d_FromDate     , d_Todate ,d_ModifiedDate, n_ModifiedBy)
     Values(@TaxId  , 0.0		 , GETDATE()      , Null     , GETDATE()    ,@ModifedBy)	

Go