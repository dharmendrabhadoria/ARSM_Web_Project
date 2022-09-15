

 ----Customer Details----
select Cust.s_CustomerName,BD.s_BoxBarCode,FD.s_FileBarCode,BD.s_LocationCode ,FD.s_FileName,FD.s_FileDescription1,ACM.s_AppCodeName 'Dept',FD.s_Year,FD.d_FromDate,FD.d_EndDate
      ,FD.s_Label1,FD.s_Label2,FD.s_Label3,FD.d_DestructionDueDate,TPU.s_Address
      from tbl_workorder TWO 
      join tbl_woactivities TWA on TWO.n_workorderno = TWA.n_workorderno 
      join tbl_boxtransactions TBT on TBT.n_woactivityid = TWA.n_woactivityid 
      join tbl_filedetails  FD on TBT.n_boxid = FD.n_boxid 
      join tbl_BoxDetails BD on BD.n_BoxId = FD.n_BoxId
      join tbl_pickupaddress TPU on TWA.n_pickupaddressid = TPU.n_pickupaddressid 
      join tbl_Customer Cust on Cust.n_CustomerId = BD.n_CustomerId 
      join tbl_ApplicationCodeMaster ACM on ACM.n_AppCodeId  = FD.n_DepartmentId
      where twa.n_activityid in (1,2,3) 
      and FD.n_Status in (49,50)
      and   TWO.n_customerid = 10 
      
 ----Box Count----    
select * from tbl_BoxDetails TB 
inner join tbl_BoxTransactions TBT on TBT.n_BoxId =TB.n_BoxId
inner join tbl_WoActivities TWA on TWA.n_WoActivityId =TBT.n_WoActivityId
inner join tbl_workorder TWO on TWO.n_workorderno = TWA.n_workorderno 
where TWO.n_customerid = 5 