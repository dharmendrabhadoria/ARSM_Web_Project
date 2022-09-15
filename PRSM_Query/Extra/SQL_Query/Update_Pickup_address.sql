
select * from  tbl_Customer where  n_CustomerId = 30

select * from tbl_PickupAddress where n_PickupAddressId in (51, 52)

select * from  tbl_AuthorisedPersons where n_PickupAddressId in (51, 52)

select * from tbl_WoActivities TWA where TWA.n_WorkOrderNo in(2016000090,2016000092,2016000096)


--Insert into tbl_PickupAddress ( n_CustomerId , s_Address															,	n_StateId	, n_CityId		,	n_DepartmentId		,	s_PinCode	,	d_ModifiedDate				,	n_UserId	,	s_Address1								,	s_Address2				    ) values
--							  (	30			 ,  '101/ 102, Chheda Apt., First Floor,Liberty Garden Cross Road No.3'	,	21			,	1			,	 4					,	400064		,	'2016-07-12 11:15:31.270'	,		1		,	'101/ 102, Chheda Apt., First Floor,'	,	'Liberty Garden Cross Road No.3')

--Insert into tbl_AuthorisedPersons	(	n_PickupAddressId	,	s_AuthorisedPerson		,	s_PhoneNumber	,	s_Email				,	s_MobileNo		,	d_ModifiedDate				,	n_UserId	) values
--									(		52			,	'Nilesh P. Joshi '		,	'02228813490 '	,	'gm@maladbank.com'	,	'2228825273'	,	'2016-07-12 11:15:31.270'	,		1		)

--begin tran

--update tbl_WoActivities  set n_PickupAddressId = 52 where n_WorkOrderNo in(2016000090,2016000092,2016000096)


--commit

