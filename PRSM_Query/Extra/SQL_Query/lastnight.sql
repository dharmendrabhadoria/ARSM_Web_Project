select  * from S_Contact_Master where  ((AssignedTo in(5174))  and (AssignedBy is null))
select  * from S_Contact_Master where  ((AssignedBy in(5174)) )

select * from S_Contact_Master where((Created_By in(5174) or AssignedTo = 5174 ))
 
  select  * from S_Contact_Master where AssignedBy in(5170) 
  select  * from S_Contact_Master where AssignedTo in(5159,5170)
--update S_Contact_Master set AssignedTo = 5159 where Created_By = 5159
--update S_Contact_Master set AssignedTo = 5170 where Created_By = 5170
--update S_Contact_Master set AssignedTo = 5171 where Created_By = 5171
--update S_Contact_Master set AssignedTo = 5174 where Created_By = 5174
--update S_Contact_Master set AssignedTo = null ,AssignedBy = null  where Created_By in(5159,5170,5171,5174,5175) 
