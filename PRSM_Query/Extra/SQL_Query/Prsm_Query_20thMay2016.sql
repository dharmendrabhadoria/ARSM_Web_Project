Select * from tbl_Filedetails where d_ModifiedDate >='2016-05-20'

Select * from tbl_Boxdetails where s_boxbarcode='GA23201'

Select * from tbl_Boxdetails where s_boxbarcode='GA23263'

Select * from tbl_Boxdetails where s_boxbarcode='GA23265'

Select * from tbl_boxdetails where d_ModifiedDate >='2016-05-19'

--------------------------------------------------------------------

select * from tbl_filetransactions where n_Fileid in (Select n_fileid from tbl_Filedetails where d_ModifiedDate >='2016-05-20')

-----------------------------------------------------------------------------------------------
select * from tbl_workorder where n_workorderno=2014000004

select * from tbl_woactivities where n_workorderno=2014000004

select * from tbl_filetransactions where n_woactivityid in (10,11,12)

-------------------------------------------------------------------
select * from tbl_woactivities where n_workorderno=2016000048

select * from tbl_workorder where n_workorderno=2016000048

update tbl_workorder set d_wodate='2016-05-12 11:53:04.953' where n_workorderno=2016000048


select * from tbl_filetransactions where n_Fileid in (Select n_fileid from tbl_Filedetails where d_ModifiedDate >='2016-05-20')

--Insert into tbl_filetransactions(n_FileId,n_woactivityid,d_Modifieddate,n_Modifiedby)
--Select n_fileid,673,getdate(),1 from tbl_Filedetails where d_ModifiedDate >='2016-05-20'

------------------------------------------------------------------------------
Select * from tbl_boxdetails where d_ModifiedDate >='2016-05-19'

select * from tbl_woactivities where n_workorderno=2016000048

select * from tbl_Boxtransactions where n_woactivityid in (671,672,673)

-------------------------------------------------------------------------------
select * from tbl_woactivities where n_workorderno=2014000001
select * from tbl_Boxtransactions where n_woactivityid in (1,2,3)

---------------------------------------------------------------------------------
Select * from tbl_Filedetails where d_ModifiedDate >='2016-05-20'

update tbl_Filedetails set n_approvestatus=146,d_checkerdate=getdate(),n_checkerby=1 where d_ModifiedDate >='2016-05-20'



----------------------------------------------------
--select * from tbl_Activity

--2=File count=2291
--1,3=Box count=109

--update tbl_woactivities set n_Filecount=2291 where n_woactivityid=671


--update tbl_woactivities set n_boxcount=109 where n_woactivityid=672

--update tbl_woactivities set n_boxcount=109 where n_woactivityid=673

--usp_InsertClientData


--Select * from tbl_Filedetails where d_ModifiedDate >='2016-05-20'

--Update tbl_Filedetails set s_FileBarCode='A'+ s_FileBarCode where d_ModifiedDate >='2016-05-20'

--Select * from tbl_Boxdetails where d_ModifiedDate >='2016-05-20'


--Update tbl_Boxdetails set s_BoxBarCode='A'+ s_BoxBarCode where d_ModifiedDate >='2016-05-20'