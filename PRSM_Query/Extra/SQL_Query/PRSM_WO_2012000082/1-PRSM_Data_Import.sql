
--STEP 1 : TAKE THE INITIAL COUNTS
Select count(*) From tbl_BoxDetails  --4585
Select count(*)  From tbl_FileDetails  -- select 59506
Select count(*) From tbl_FileTransactions  -- select 59800
Select * From tbl_WoActivities Where n_WorkOrderNo=2015000082 -- 3 rows 
--boxes against these woactivities
select * from tbl_BoxTransactions where n_WoActivityId in ( 358,359,360)   -- 0 boxes 

--GET ClientName , TotalBoxes and WOActivityID
--For this particular client you should get the above mentioned counts
Select 
	   TC.s_CustomerName As 'Client Name', COUNT(TB.n_BoxId )As 'TotalBoxes',TB.n_WoActivityId
From tbl_BoxTransactions TB
		Inner Join
	 tbl_WoActivities 	TW on TB.n_WoActivityId  = TW.n_WoActivityId 
	 		Inner Join
	 tbl_WorkOrder    TBW 	on TBW.n_WorkorderNo   = TW.n_WorkorderNo
	        Inner Join
	 tbl_Customer    TC    On TBW.n_CustomerId = TC.n_CustomerId  
Where TB.n_WoActivityId in ( 358,359,360)      
 Group By TB.n_WoActivityId ,TC.s_CustomerName 
 order by n_WoActivityId
 --0 rows 
 
 
--CHECK IF ANY FILES ARE ALREADY THERE FOR THE WOACTIVITES ABOVE 
Select 
	  TC.s_CustomerName As 'Client Name' ,COUNT(TB.n_FileId )As 'Total Files',TB.n_WoActivityId 
From tbl_FileTransactions TB
		Inner Join
	 tbl_WoActivities 	TW on TB.n_WoActivityId  = TW.n_WoActivityId 
	 		Inner Join
	 tbl_WorkOrder    TBW 	on TBW.n_WorkorderNo   = TW.n_WorkorderNo
	        Inner Join
	 tbl_Customer    TC    On TBW.n_CustomerId = TC.n_CustomerId      
Where TB.n_WoActivityId in ( 358,359,360) 	   
 Group By TB.n_WoActivityId ,TC.s_CustomerName 
 order by n_WoActivityId 
--0 rows

-- The table in which the data has been imported is your base table.
--Add the column DeptId in the base table and then get all the data from this table in tempdata
--rest of the actions will take place on tempdata.

--take a backup of tempdata if required before truncating the table
truncate table tempdata 
alter table wo_2015000082 add  DeptId smallint

insert tempdata 
select * from wo_2015000082

select * from tempdata 



--CHECK FOR PENDING BOX BAR CODES IN TEMPDATA  i.e. box bar codes that are in 
--temp data but not in tbl_boxdetails
Select Distinct [BOX BARCODE]   From TempData 
Where [BOX BARCODE]  Not in (Select s_BoxBarCode  From tbl_BoxDetails )

--142 Boxes Pending

--CHECK FOR PENDING FILE BAR CODES IN TEMPDATA  i.e. file bar codes that are in 
--temp data but not in tbl_filedetails
 Select Distinct [FILE BARCODE]    From TempData  Where ltrim(rtrim([FILE BARCODE]))  Not in (
 Select ltrim(rtrim(s_FileBarCode))   From tbl_FileDetails  )
--586 rows pending 


--CHECK FOR DUPLICATE FILE BAR CODE IN TEMP DATA
 Select  Rtrim(ltrim([FILE BARCODE]))as [FILE BARCODE],COUNT( Rtrim(ltrim([FILE BARCODE]))) 'Duplicate Count' 
 From TempData  
 Group by  [FILE BARCODE]  having COUNT( Rtrim(ltrim([FILE BARCODE]))) > 1
--NO DUPLICATES


--CHECK FOR ANY WRONG DATA IN TempData
 Select [FILE BARCODE] From TempData Where [FILE BARCODE] Is null
 Select * From TempData Where [FILE BARCODE] ='-'
 Select * From tbl_FileDetails Where s_FileBarCode ='-'
 
 --If the No on Files and Boxes are not set in tbl_WoActivities, then set them as per excel sheet
 --If the counts are already set then ignore
 --Update tbl_WoActivities  Set n_BoxCount =2 ,n_FileCount = 0   Where n_WoActivityId = 35
 -- Update tbl_WoActivities  Set n_FileCount = 586   Where n_WoActivityId = 358
 
 --ADD DeptId field if already not there in TempData
 --Alter table TempData Add DeptId SmallInt
 
 
--UPDATE TempData TO ADD DEPTID  

select distinct dept from tempdata where dept not in (
select s_appcodename from tbl_applicationcodemaster where s_AppCode = 'DEPARTMENT') 

--update tempdata set dept  = 'MICROBIOLOGY' where dept = 'MICRO BIOLOGY'
--(124 row(s) affected)

--check that Deptid  is null and n_appcodeid is not null 
select DeptID , n_AppCodeId From TempData TA Inner Join tbl_ApplicationCodeMaster  TB On Rtrim(ltrim(TA.DEPT)) = Rtrim(ltrim(TB.s_AppCodeName))
Where s_AppCode = 'DEPARTMENT' And   TA.DEPT Is not  Null 
 --update deptid
Update TempData Set DeptId  = TB.n_AppCodeId  From TempData TA Inner Join tbl_ApplicationCodeMaster  TB On Rtrim(ltrim(TA.DEPT)) = Rtrim(ltrim(TB.s_AppCodeName))
Where s_AppCode = 'DEPARTMENT' And   TA.DEPT Is not  Null 
--now both should be not null and match 
select DeptId , n_AppCodeId From TempData TA Inner Join tbl_ApplicationCodeMaster  TB On Rtrim(ltrim(TA.DEPT)) = Rtrim(ltrim(TB.s_AppCodeName))
Where s_AppCode = 'DEPARTMENT' And   TA.DEPT Is not  Null 
 
 
 --ANY OTHER CODE : ADD NEW DEPT, THEN UPDATE TempData, OR CHANGE DEPT NAMES, ETC
 
  update tempdata set clientname='METROPOLIS HEALTHCARE LIMITED'
 --Done!
 Select * from TempData 
 
 
 --DO THIS AFTER FILES ARE IMPORTED
 ---SET THE STATUS OF FILES AS TO BE APPROVED

update tbl_FileDetails set n_ApproveStatus = (select n_AppCodeId from tbl_applicationcodemaster where s_appcode = 'BOXFILE_STATUS' and s_appcodename = 'Pending' ) 
where n_fileid in 
(
select n_FileId from tbl_FileTransactions where d_ModifiedDate  > (getdate()-1)   )

