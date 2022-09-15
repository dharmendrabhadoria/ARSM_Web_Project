
select * from tbl_Activity where n_ActivityId in(16,17,52,53)   


--update tbl_Activity
--set s_ActivityName ='Retrievals Hand Delivery Charges Regular [(Within 24 hours) Max 4 box files / One Full Box]'
--where n_ActivityId = 16 

--update tbl_Activity
--set s_ActivityName ='Retrievals Hand Delivery Charges Express [(Within 12 hours) Max 4 box files / One Full Box]'
--where n_ActivityId = 17  

--update tbl_Activity
--set s_ActivityName ='Restore   Hand Delivery Charges Regular [(Within 24 hours) Max 4 box files / One Full Box]'
--where n_ActivityId = 52 

--update tbl_Activity
--set s_ActivityName ='Restore   Hand Delivery Charges Express [(Within 12 hours) Max 4 box files / One Full Box]'
--where n_ActivityId = 53 

--update tbl_Activity set s_Remark = '',b_IsEdit = 0,n_Unit=3,n_UnitCount=1,b_IsShowinRateCard=1 where n_ActivityId = 52
--update tbl_Activity set s_Remark = '',b_IsEdit = 0,n_Unit=3,n_UnitCount=1,b_IsShowinRateCard=1 where n_ActivityId = 53

select * from tbl_WorkOrder where n_WorkorderNo = 2016000006

select * from tbl_WoActivities where n_WorkorderNo = 2016000006

 select * from tbl_PagewiseActivity   
 
insert into tbl_PagewiseActivity ( n_PageId,n_ActivityId) values(69	,52)
insert into tbl_PagewiseActivity ( n_PageId,n_ActivityId) values(69	,53)
 