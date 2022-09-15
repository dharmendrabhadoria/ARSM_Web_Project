
select * from tbl_invoicesummary_New where n_InvoiceNo = 2016000191
select * from tbl_invoicedetails_New where n_InvoiceNo = 2016000191

--begin tran
--update tbl_invoicesummary_New set n_InvoiceAmount=17146.50,N_TotalAmount= 19718.47 where n_InvoiceNo=2016000191
--update tbl_invoicesummary_New set n_StorageCharges= 17146.50 where n_InvoiceNo=2016000191
----update tbl_invoicesummary_New set n_TransAmount=0 where n_InvoiceNo=2016000191
--update tbl_invoicesummary_New set n_ServiceTax=2400.51,n_EduTax = 85.73,n_HigherEducation= 85.73 where n_InvoiceNo=2016000191
--commit