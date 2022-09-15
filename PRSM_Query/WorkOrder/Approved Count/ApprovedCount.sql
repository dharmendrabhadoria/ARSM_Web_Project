select * from tbl_WoActivities where  n_WorkorderNo = 2018000004   
------Box Count----1
--begin tran

--update tbl_WoActivities set n_BoxCount = 15 where n_WoActivityId = 4038 and n_WorkOrderNo = 2018000004

----commit tran

--------File Count----2

--update tbl_WoActivities set n_FileCount = 2028 where n_WoActivityId = 4037 and n_WorkOrderNo = 2018000004

----commit tran

------Other Count----3

--update tbl_WoActivities set n_FileCount = 1 where n_WoActivityId = 4039 and n_WorkOrderNo = 2018000004

--commit tran


----Other Transactions ----4
--begin tran

--insert into tbl_OtherTransactions  (n_WoActivityId      ,n_ServiceCount		    ,n_Amount	 ,s_Remarks  ,d_ModifiedDate				,n_ModifiedBy)
--            Values                 (3770		     	,1				        , 2900       ,''		 ,getdate()	, 1			 )
--commit tran


--begin tran

--update tbl_FileDetails set n_ApproveStatus =146 , d_CheckerDate ='2016-08-04 18:14:06.330', n_CheckerBy = 1

--from tbl_FileDetails FD
--inner join tbl_BoxDetails TB on TB.n_BoxId =FD.n_BoxId
--inner join tbl_BoxTransactions TBT  on TB.n_BoxId =TBT.n_BoxId
--inner join tbl_WoActivities TWA on TWA.n_WoActivityId =TBT.n_WoActivityId
--where n_WorkorderNo = 2016000098  

--commit tran