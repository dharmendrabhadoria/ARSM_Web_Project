/*
SP Name       : usp_GetOtherServicesReport
Purpose       : This stored procedure is used to get the other services report.
Created By    : Sunil Pandey
Creation Date : 09-03-2015
*/
If Exists (Select 1 From sysobjects Where Type = 'P' AND  name = 'usp_GetOtherServicesReport')
Begin
	Drop Procedure usp_GetOtherServicesReport
End
Go    
Create Procedure usp_GetOtherServicesReport 
(
@pn_WoActivityId Smallint ,
@pn_CustomerId   Int      ,    
@pd_FromDate     DateTime ,    
@pd_ToDate       DateTime ,
@pb_IsSummary    Bit --- 0- Other Services Summary,1-Other Services Details  
)    
As  
Begin  
  SET NOCOUNT ON  
  
	 If @pd_FromDate Is Null    
		 Set @pd_FromDate = Convert(Datetime,'01-01-1900',101)    
	             
	 If @pd_ToDate Is Null    
		Set @pd_ToDate = Convert(Datetime,Getdate(),101) 
		
	 Declare @ServiceCatgId    SmallInt
	 Declare @nServiceCatgId   SmallInt
	 Declare @ActivityStatus   SmallInt
	 Declare @nActivityStatus  SmallInt
       Select @ServiceCatgId    = n_ServiceCategoryId  From  tbl_ServiceCategory       Where s_SCName  = 'Other services'
		  Set @nServiceCatgId   = @ServiceCatgId
	   Select @ActivityStatus   = n_AppCodeId          From  tbl_ApplicationCodeMaster Where s_AppCode = 'WORKORDER_STATUS' And s_AppCodeName = 'Closed'  
          Set @nActivityStatus  = @ActivityStatus  
        
  if(@pb_IsSummary = 0)
   Begin    
  
        Create Table #OtherServiceReport([Customer Name] Varchar(100) Null,
	                 [Fax – local]                    Int Null, [Photocopy] Int Null,
	                 [Scanning & Email]               Int Null, [Fax – STD] Int Null,
	                 [Document Searching & Insertion] Int Null,
	                 [Audit Room Charges]             Int Null, [File Retrieval] Int Null)
	  Insert Into #OtherServiceReport([Customer Name],
	            [Fax – local]        , [Photocopy] ,[Scanning & Email],
	            [Fax – STD]          , [Document Searching & Insertion],
	            [Audit Room Charges] , [File Retrieval] )    
	 Select  
		*
		From  
		(  
		   Select TBA.s_ActivityName  As 'ActivityName',    WOA.n_FileCount As 'NoOfServices',
				  TC.s_CustomerName   As 'Customer Name'
		   From   tbl_Activity TBA   
			  Left Join     
		      tbl_WoActivities  WOA   On  WOA.n_ActivityId    =  TBA.n_ActivityId     
			  Inner Join     
		      tbl_WorkOrder     WO    On  WOA.n_WorkOrderNo   =  WO.n_WorkorderNo   
			  Inner Join   
		      tbl_Customer      TC    On  WO.n_CustomerId     =  TC.n_CustomerId  
		  Where  
			  WOA.n_WoActivityId    =  Case  @pn_WoActivityId   When  0   Then  WOA.n_WoActivityId    Else @pn_WoActivityId    End  
			  And  
			  TC.n_CustomerId       =  Case @pn_CustomerId      When  0   Then  TC.n_CustomerId       Else @pn_CustomerId End  
			  And  
			  TBA.n_ServiceCategoryId = @nServiceCatgId  
			  And   
			  WOA.d_ModificationDate Between @pd_FromDate And @pd_ToDate And WO.n_Status = @nActivityStatus  
		) x  
		Pivot  
		( Sum(NoOfServices) For ActivityName In ( [Fax – local], [Photocopy],[Scanning & Email],[Fax – STD],[Document Searching & Insertion],[Audit Room Charges],[File Retrieval]) ) As Piv            
		
	    Select * From #OtherServiceReport
        -----Get sum in one shot 
		Select  Sum(IsNull([Fax – local],0))                    As 'Fax – local'  ,      Sum(IsNull([Photocopy],0))      As 'Photocopy' ,
		        Sum(IsNull([Scanning & Email],0))               As 'Scanning & Email',   Sum(IsNull([Fax – STD],0))      As 'Fax – STD' ,
		        Sum(IsNull([Document Searching & Insertion],0)) As 'Document Searching & Insertion' ,
		        Sum(IsNull([Audit Room Charges],0))             As 'Audit Room Charges' ,Sum(IsNull([File Retrieval],0)) As 'File Retrieval' From #OtherServiceReport
		     
   End
     Else    
     Begin
         Create Table #OtherServiceReportDet([n_WorkorderNo]         Int Null                          , [d_WoDate]                       DateTime ,
                                             [Customer Name]         Varchar(100)                      , [Fax – local]                    Int Null,
                                             [Photocopy]             Int Null                          , [Scanning & Email]               Int Null, 
                                             [Fax – STD]             Int Null						   , [Document Searching & Insertion] Int Null,
	                                         [Audit Room Charges]    Int Null                          , [File Retrieval]                 Int Null)
	     Insert Into #OtherServiceReportDet([Customer Name]                                            , [n_WorkorderNo]                 , [d_WoDate] ,  
	                                        [Fax – local]            , [Photocopy]                     ,[Scanning & Email],
	                                        [Fax – STD]		         , [Document Searching & Insertion],
	                                        [Audit Room Charges]     , [File Retrieval] )        
		Select  
			* 
			From  
			(  
			   Select TBA.s_ActivityName  As 'ActivityName',  WOA.n_FileCount As 'NoOfServices',   TC.s_CustomerName As 'Customer Name',  
					  WOA.n_WorkorderNo   As 'WorkOrderNo',   WO.d_WoDate     As 'WorkOrderDate'  
			   From   tbl_Activity TBA   
				   Left Join     
			       tbl_WoActivities  WOA   On  WOA.n_ActivityId    =  TBA.n_ActivityId     
				   Inner Join     
			       tbl_WorkOrder     WO    On  WOA.n_WorkOrderNo   =  WO.n_WorkorderNo   
				   Inner Join   
			       tbl_Customer      TC    On  WO.n_CustomerId     =  TC.n_CustomerId  
			   Where  
				   WOA.n_WoActivityId    =  Case  @pn_WoActivityId   When  0   Then  WOA.n_WoActivityId    Else @pn_WoActivityId    End  
				   And  
				   TC.n_CustomerId       =  Case @pn_CustomerId      When  0   Then  TC.n_CustomerId       Else @pn_CustomerId End  
				   And  
				   TBA.n_ServiceCategoryId = @nServiceCatgId  
				   And   
				   WOA.d_ModificationDate Between @pd_FromDate And @pd_ToDate And WO.n_Status = @nActivityStatus  
			  ) x  
			Pivot  
			( Sum(NoOfServices) For ActivityName In ( [Fax – local], [Photocopy],[Scanning & Email],[Fax – STD],[Document Searching & Insertion],[Audit Room Charges],[File Retrieval]) ) As Piv  
			
			 Select [n_WorkorderNo] As 'WorkorderNo' ,CONVERT(Varchar, [d_WoDate],103) As 'WorkOrderDate', [Customer Name]  ,[Fax – local],[Photocopy],[Scanning & Email],[Fax – STD],[Document Searching & Insertion],[Audit Room Charges],[File Retrieval] From #OtherServiceReportDet Order By [d_WoDate] Desc
        -----Get sum in one shot 
	Select      Sum(IsNull([Fax – local],0))                    As 'Fax – local'  ,      Sum(IsNull([Photocopy],0))      As 'Photocopy' ,
		        Sum(IsNull([Scanning & Email],0))               As 'Scanning & Email',   Sum(IsNull([Fax – STD],0))      As 'Fax – STD' ,
		        Sum(IsNull([Document Searching & Insertion],0)) As 'Document Searching & Insertion' ,
		        Sum(IsNull([Audit Room Charges],0))             As 'Audit Room Charges' ,Sum(IsNull([File Retrieval],0)) As 'File Retrieval' From #OtherServiceReportDet
      End   
   End    
   Go




