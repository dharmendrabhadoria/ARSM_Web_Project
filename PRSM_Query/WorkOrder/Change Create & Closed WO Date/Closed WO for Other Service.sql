Select * from tbl_WoActivities  where n_WorkorderNo = 2017000281
Select * from tbl_WoActivities  where n_WorkorderNo = 2017000237

select * from tbl_OtherTransactions where n_WoActivityId in(3954,3955,3956)
select * from tbl_OtherTransactions where n_WoActivityId in(3840,3841,3842)

Select * from tbl_WoActivities wa 
left join tbl_WorkOrder w on w.n_WorkorderNo = wa.n_WorkOrderNo
where wa.n_WoActivityId in( select n_WoActivityId from tbl_OtherTransactions) and w.n_CustomerId = 31


--begin tran

--insert into tbl_OtherTransactions (n_WoActivityId,n_ServiceCount,n_Amount,s_Remarks,d_ModifiedDate,n_ModifiedBy)
----select  3955,405,5,'',getdate(),1
----select  3956,405,10,'',getdate(),1
--select  3954,28879,1,'',getdate(),1

--commit
