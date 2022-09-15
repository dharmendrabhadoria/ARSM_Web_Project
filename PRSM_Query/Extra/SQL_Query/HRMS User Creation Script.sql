
begin tran 
declare @IsManager int  = 3 -- 1 -> Area Manager, 2->Manager ; 3-> Executive 

declare @EmpCode varchar(20) = 'EM00010596' --ensure unique
--select * from UserMaster where ReferenceEmployeeCode = @EmpCode 
declare @empname varchar(150)  = 'Gautam Gambhir' 
--select * from usermaster where employeename like '%' + @empname   + '%'

--if ( OK) 
	BEGIN --IF OK
			declare @password varchar(20) = '10596'  
			declare @Gender varchar(1) = 'M'
			declare @ManagerId bigint =  5156
			declare @department int = 64  -- 64 operations; 83 sales --  52--IT Infrastructure --7 Admin  select * from hrms_department_master where  DepartmentName like '%Admin%'

			declare @roleid_Sales  bigint = 146 
			declare @roleid_Operation  bigint = 147 
			declare @roleid_Manager  bigint = 148 

			declare @RoleId bigint = @roleid_Manager
			declare @ServiceId_Tour smallint = 27 


			/*
			1	HRMS_Entity_Master
			2	HRMS_Location_Master
			3	HRMS_Department_Master
			4	EmployeeGroup
			5	HRMS_BusinessUnit_Master
			6	HRMS_DESIGNATION_MASTER
			7	HRMS_GRADE_MASTER
			*/

			Insert into UserMaster(ReferenceEmployeeCode,EmployeeName,UserName,UserPassword,EmploymentTypeId,Gender,StartDate,CreationDate,RoleId,IsDefaultPassword)
			Values(@EmpCode ,@empname, @empcode , @password,1,@Gender,GETDATE(),GETDATE(),0,1)

			declare @empid bigint = scope_identity()

			select @empid 

			Insert into  EmployeeSecurityMapping (EmployeeID,SPID,isActive)
			Values(@empid,1,1)

			if ( @IsManager != 1  )  
				begin 
					Insert into ApprovalLevelHirarchyAssign (EmployeeId,LevelId,ApprovalEmployeeId,StartDate,CreationDate,ApprovalSequence)
					Values(@ManagerId , 1,@empid,GETDATE(),GETDATE(),1)

				insert into UserSegmentDetails (EmployeeId,SegmentId,StartDate,CreationDate)
				Values(@empid,1,GETDATE(),GETDATE())


				insert into UserSegmentDetails (EmployeeId,SegmentId,StartDate,CreationDate)
				Values(@empid,2,GETDATE(),GETDATE())

				insert into UserSegmentDetails (EmployeeId,SegmentId,StartDate,CreationDate)
				Values(@empid,3,GETDATE(),GETDATE())

				insert into UserSegmentDetails (EmployeeId,SegmentId,StartDate,CreationDate)
				Values(@empid,5,GETDATE(),GETDATE())

				insert into UserSegmentDetails (EmployeeId,SegmentId,StartDate,CreationDate)
				Values(@empid,7,GETDATE(),GETDATE())

				-------
				declare @userSegmentdetaiid bigint = (select UserSegmentDetailId from UserSegmentDetails
				where EmployeeId = @empid and SegmentId = 1) 
				select @userSegmentdetaiid
				Insert into UserSegementLineItem (UserSegmentDetailId,IDNo,StartDate,CreationDate)
				Values(@userSegmentdetaiid,11,GETDATE(),GETDATE())
				-------
			if ( @IsManager = 3) 
				begin 
				Insert into ApprovalLevelHirarchyAssign (EmployeeId,LevelId,ApprovalEmployeeId,StartDate,CreationDate,ApprovalSequence)
					Values(@ManagerId , 1,@empid,GETDATE(),GETDATE(),1)

				-------
				declare @userSegmentdetaiid_dept bigint = (select UserSegmentDetailId from UserSegmentDetails
				where EmployeeId = @empid and SegmentId = 3) 
				select @userSegmentdetaiid
				Insert into UserSegementLineItem (UserSegmentDetailId,IDNo,StartDate,CreationDate)
				Values(@userSegmentdetaiid_dept,@department,GETDATE(),GETDATE())
				-------
				end 

			end 

			Insert into S_User_Service_Mapping(UserId,ServiceID)values(@empid,@ServiceId_Tour)
			Update UserMaster set RoleId = @RoleId where EmployeeId = @empid

	END --IF OK
--rollback 
--commit 

