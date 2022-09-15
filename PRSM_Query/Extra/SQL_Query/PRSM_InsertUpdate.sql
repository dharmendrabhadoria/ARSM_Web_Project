

update tbl_Activity set s_ActivityName ='Retrievals Hand Delivery Charges Regular [(Within 24 hours) Max 4 box files / One Full Box]' where n_ActivityId = 16
update tbl_Activity set s_ActivityName ='Retrievals Hand Delivery Charges Express [(Within 12 hours) Max 4 box files / One Full Box]' where n_ActivityId = 17

insert into tbl_Activity (s_ActivityName ,n_ServiceCategoryId,b_IsEdit,	n_Unit,	n_UnitCount,	b_IsShowinRateCard,	d_ModifiedDate)
values('Restore   Hand Delivery Charges Regular [(Within 24 hours) Max 4 box files / One Full Box]',6,0	,3	,1	,1	,getdate())

insert into tbl_Activity (s_ActivityName ,n_ServiceCategoryId,b_IsEdit,	n_Unit,	n_UnitCount,	b_IsShowinRateCard,	d_ModifiedDate)
values('Restore   Hand Delivery Charges Express [(Within 12 hours) Max 4 box files / One Full Box]',6,0	,3	,1	,1	,getdate())


update tbl_ApplicationCodeMaster set s_AppCodeName='Service Tax @14%' where s_AppCode = 'TAX_NAME'and  n_AppCodeId = 55
update tbl_ApplicationCodeMaster set s_AppCodeName='Swachh Bharat Cess @0.5%' where s_AppCode = 'TAX_NAME'and  n_AppCodeId = 56
update tbl_ApplicationCodeMaster set s_AppCodeName='Krishi Kalyan Cess @0.5%' where s_AppCode = 'TAX_NAME'and  n_AppCodeId = 57

update tbl_TaxMaster set n_TaxValue= 14  ,d_ModifiedDate = getdate() where n_TaxMasterId = 1
update tbl_TaxMaster set n_TaxValue= 0.5 ,d_ModifiedDate = getdate() where n_TaxMasterId = 2
update tbl_TaxMaster set n_TaxValue= 0.5 ,d_ModifiedDate = getdate() where n_TaxMasterId = 3

insert into tbl_ApplicationCodeMaster(s_AppCode,s_AppCodeName) values('PAGE_NAME','Generate Invoice New')

Insert into tbl_PageFunctionality (n_PageId,b_IsMenu,s_Functionality,b_Enable,d_ModifiedDate)
Values(223,1,'Generate Invoice New',1,Getdate())
Insert into tbl_PageFunctionality (n_PageId,b_IsMenu,s_Functionality,b_Enable,d_ModifiedDate)
Values(223,1,'Save',1,Getdate())
Insert into tbl_PageFunctionality (n_PageId,b_IsMenu,s_Functionality,b_Enable,d_ModifiedDate)
Values(223,1,'Search',1,Getdate())
Insert into tbl_PageFunctionality (n_PageId,b_IsMenu,s_Functionality,b_Enable,d_ModifiedDate)
Values(223,1,'Clear',1,Getdate())

insert into tbl_RoleWiseAccess values(1,171,1,GETDATE())
insert into tbl_RoleWiseAccess values(1,172,1,GETDATE())

insert into tbl_RoleWiseAccess values(2,171,1,GETDATE())
insert into tbl_RoleWiseAccess values(2,172,1,GETDATE())


