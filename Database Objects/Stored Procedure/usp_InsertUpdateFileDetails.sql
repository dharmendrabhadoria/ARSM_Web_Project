
/*
SP Name: usp_InsertUpdateFileDetails
Description: This procedure is used to Add/update in the tbl_FileDetails.  
Created By:  Ajay Tiwari
Creation Date: 23 August 2014
Alter by : Rajendra pawar 
Alter Date : 03 Nov -2014
Reason : Added transaction and Where condition in insert file transaction not insert already added file code.  
*/

If Exists (Select 1 From sysobjects Where Type='P' AND name='usp_InsertUpdateFileDetails') 
Begin
   Drop Procedure usp_InsertUpdateFileDetails
End 
Go

Create  Procedure usp_InsertUpdateFileDetails
(
 @pn_CustomerId	      Int	        ,     
 @pn_WareHouseId      TinyInt       ,  
 @ps_xmlFileDetails   Varchar(Max)  ,
 @pn_WoActivityId	  Int			,
 @pn_ModifiedBy       SmallInt		,	
 @IsNew				  Bit	 --0 = New	1 = Update 
)
As  
Begin Tran
 Begin Try
	   Create Table #TempxmlFileDetails
			( 
				Id			    Int   Identity(1,1)   , FileId		   Int	             ,
				BoxBarCode	    Varchar(16)           , FileBarCode	   Varchar(16)	     ,  
				sFileName       Varchar(255)          , DepartmentId   Int               , 
				sYear	        Varchar(30)           , FromDate       Varchar(20)       ,
				EndDate         Varchar(20)           , Label1         Varchar(500)      ,     	
				Label2          Varchar(500)		  , Label3         Varchar(500)  	 ,	 	
				fileStatus	    SmallInt			  , IsBoxExist     Bit			     ,
				IsFileExist     Bit 	 	
			) 

		Declare @docHandle Int;  
		Exec sp_xml_preparedocument @docHandle Output, @ps_xmlFileDetails;  
		Insert Into #TempxmlFileDetails Select * From OpenXml(@docHandle, '/NewDataSet/Root',2) With #TempxmlFileDetails 
		Exec sp_xml_removedocument @docHandle;
		----Get Pick Address Id 
		
		 	    Declare @BranchId  Int
				Select @BranchId= n_PickupAddressId  
				From tbl_WoActivities Where  n_WoActivityId = @pn_WoActivityId
				
 	If(@IsNew = 0)
		Begin
		
		 Declare @n_WorkOrderNo  Int
				Select @n_WorkOrderNo= n_WorkOrderNo  
				From tbl_WoActivities Where  n_WoActivityId = @pn_WoActivityId
		    Declare @FileStatus  SmallInt
		    Select @FileStatus = n_AppCodeId  From tbl_ApplicationCodeMaster Where s_AppCode = 'BOXFILE_STATUS' And s_AppCodeName ='In'
		    Update #TempxmlFileDetails Set IsBoxExist = 1   From #TempxmlFileDetails T 
				    Left Join 
			       tbl_BoxDetails TB  On  T.BoxBarCode = TB.s_BoxBarCode 
	             Where Isnull(TB.s_BoxBarCode,'') <> ''
		    --For dispaly result--
		    Create Table #TempResult
			( 
				SrNo		 Int   Identity(1,1)   ,   FileCode	       Varchar(16)   NULL,
				BoxCode	     Varchar(16) null , Result  Varchar(100)                	
		    )
		    --Duplicate files 
		   Insert Into #TempResult Select   T.FileBarCode ,'','File already exist'    
		   From tbl_FileDetails TF 
			    Inner Join #TempxmlFileDetails T On TF.s_FileBarCode = T.FileBarCode 
		   Where TF.s_FileBarCode  Is not  Null
			    
		   Update  #TempxmlFileDetails 
		   Set IsFileExist = 1  
		   From #TempxmlFileDetails T 
				Inner Join
		   tbl_BoxDetails  TB     On  
		   T.BoxBarCode = TB.s_BoxBarCode
			    Left Join 
		   tbl_FileDetails TF      On 
		   T.FileBarCode = TF.s_FileBarCode 
		   Where TF.s_FileBarCode  Is Null 
			         
			Insert Into tbl_FileDetails
				      ( n_BoxId                       ,  s_FileBarCode            ,
						s_FileName                    ,  n_BranchId               ,
						n_DepartmentId                ,  s_Year                   ,
					    d_FromDate                    ,  d_EndDate                ,
						s_Label1                      ,  s_Label2                 ,
						s_Label3                      ,  n_Status                 ,
						d_ModifiedDate                ,  n_ModifiedBy)           
						            
			Select      TB.n_BoxId                    ,  FileBarCode              ,    
						sFileName                     ,  @BranchId                ,
						DepartmentId                  ,  sYear                    ,
					    Case When FromDate  =  '' Then null else Convert(Date,FromDate,103)  End , 
					    Case When EndDate   =  '' Then null else Convert(Date,EndDate,103)   End , 
						Label1                        ,  Label2                   ,
						Label3                        ,  @FileStatus              , 
						GETDATE()	                  ,  @pn_ModifiedBy 
		   From #TempxmlFileDetails T 
				Inner Join
		   tbl_BoxDetails  TB  On  T.BoxBarCode = TB.s_BoxBarCode
			    Left Join tbl_FileDetails TF On T.FileBarCode = TF.s_FileBarCode 
			Where TF.s_FileBarCode  Is Null 
		    Insert Into tbl_FileTransactions(n_FileId , n_WoActivityId ,d_ModifiedDate ,n_ModifiedBy)
			Select distinct  TF.n_FileId	,	@pn_WoActivityId	, GETDATE()	, @pn_ModifiedBy
			From #TempxmlFileDetails T 
			     Inner Join
			tbl_BoxDetails  TB    On T.BoxBarCode = TB.s_BoxBarCode 
			     Inner Join
			tbl_FileDetails  TF  On TB.n_BoxId = TF.n_BoxId 
			Where T.FileBarCode Not in (Select distinct  FileCode From #TempResult where FileCode is not null  )
			And TB.n_BoxId IN(Select TBT.n_BoxId From tbl_BoxTransactions TBT 
								Inner join 
			tbl_BoxDetails TB On TB.n_BoxId = TBT.n_BoxId 
		    Where TBT.n_WoActivityId In(Select n_WoActivityId From tbl_WoActivities Where n_WorkOrderNo = @n_WorkOrderNo)  )
			Select distinct  BoxCode,FileCode,Result From #TempResult  
		   End
		   Else
		   Begin
		      
		    Update  tbl_FileDetails
				Set n_Status		   =	fileStatus     ,
				d_ModifiedDate	       =	GETDATE()      ,
				n_ModifiedBy		   =	@pn_ModifiedBy
			 From tbl_FileDetails TFD 
			    Inner join 
		     #TempxmlFileDetails T	On 
		     TFD.n_FileId = T.FileId 
		  
		     Insert Into tbl_FileTransactions(n_FileId        , n_WoActivityId    ,
                                              d_ModifiedDate  , n_ModifiedBy)  
		   Select  TF.n_FileId , @pn_WoActivityId , GETDATE(), @pn_ModifiedBy  
		   From #TempxmlFileDetails T
		      Inner Join   
		   tbl_FileDetails  TF  On   TF.n_FileId =T.FileId
		  -------Permanent out the box when its all file out 
		     
			Declare @PermanentOutSttaus  SmallInt  
			Select  @PermanentOutSttaus = n_AppCodeId  From tbl_ApplicationCodeMaster Where s_AppCode = 'BOXFILE_STATUS' And s_AppCodeName ='PERMANENT OUT'   
	    --    Select * From tbl_WoActivities Where n_WorkOrderNo in (2014000047)

			Create Table #FileCount(n_BoxId Int, n_TotalFiles Int ,n_PermanertOutFiles Int )
			Insert Into  #FileCount(n_BoxId , n_TotalFiles)
			
			Select TF.n_BoxId,COUNT(TF.n_FileId )
			From  #TempxmlFileDetails   T  Inner Join 
							tbl_FileDetails TF 
			 On T.FileId = TF.n_FileId 
					Inner Join 
		    tbl_BoxDetails      TB   On TF.n_BoxId = TB.n_BoxId 
		     
			Group by TF.n_BoxId Order by TF.n_BoxId desc

			Update  #FileCount 
			Set #FileCount.n_PermanertOutFiles = T.CountPermanertOutFiles
			From #FileCount 
			Inner Join
			(Select 
			TF.n_BoxId As n_BoxId,COUNT(TF.n_FileId )[CountPermanertOutFiles]  
				 From  
		    #TempxmlFileDetails  T1  Inner join  tbl_FileDetails TF   On T1.FileId = TF.n_FileId  
								Inner Join 
			tbl_BoxDetails		TB   On TF.n_BoxId  = TB.n_BoxId 
			Where TF.n_Status = @PermanentOutSttaus Group by TF.n_BoxId)T
			 On T.n_BoxId = #FileCount.n_BoxId 
			
			Update tbl_BoxDetails Set n_Status = @PermanentOutSttaus  
			From tbl_BoxDetails TB Inner Join #FileCount TF On  TB.n_BoxId = TF.n_BoxId 
			Where TF.n_TotalFiles = TF.n_PermanertOutFiles  And Isnull(TF.n_PermanertOutFiles,0) != 0 
			
            -----------------
           End
	  	 Drop table #TempxmlFileDetails
	  
	  	 commit Tran
	  	
 End Try  
 Begin Catch  
Rollback Tran
 Exec usp_GetErrorInfo  
 End Catch
 
 GO
