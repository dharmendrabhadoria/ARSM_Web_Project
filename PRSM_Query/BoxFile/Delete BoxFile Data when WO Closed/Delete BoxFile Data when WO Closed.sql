


--Select * from tbl_BoxDetails where s_BoxBarCode in ('GA33213','GA33214','GA33215','GA33216','GA33217','GA33218')

Select n_BoxId  from tbl_BoxDetails where s_BoxBarCode in ('GA33213','GA33214','GA33215','GA33216','GA33217','GA33218')


--select * from tbl_FileDetails where n_boxid in (
--Select n_BoxId  from tbl_BoxDetails where s_BoxBarCode in ('GA33213','GA33214','GA33215','GA33216','GA33217','GA33218')
--)


select n_FileId from tbl_FileDetails where n_boxid in (
Select n_BoxId  from tbl_BoxDetails where s_BoxBarCode in ('GA33213','GA33214','GA33215','GA33216','GA33217','GA33218')
)

select  * from tbl_FileTransactions where n_Fileid in (
	select n_FileId from tbl_FileDetails where n_boxid in (
	Select n_BoxId  from tbl_BoxDetails where s_BoxBarCode in ('GA33213','GA33214','GA33215','GA33216','GA33217','GA33218') )
)


select  * from tbl_BoxTransactions where n_BoxId in (
	Select n_BoxId  from tbl_BoxDetails where s_BoxBarCode in ('GA33213','GA33214','GA33215','GA33216','GA33217','GA33218')
)

--begin tran
select * from tbl_MapBoxLocation where n_BoxId in (
	Select n_BoxId  from tbl_BoxDetails where s_BoxBarCode in ('GA33213','GA33214','GA33215','GA33216','GA33217','GA33218')
)
--commit


