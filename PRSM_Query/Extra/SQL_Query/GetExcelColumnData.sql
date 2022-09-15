select BD.s_BoxBarCode 'Box Barcode',    
    FD.s_FileBarCode 'File BarCode',     
    BD.s_LocationCode  'Box Location',     
    FD.s_FileName 'FileName1',        
    FD.s_FileDescription1  'FileName2',
    ACMD.s_AppCodeName 'Department',
    FD.s_Year 'Year' , 
    CONVERT(Varchar(10), Convert(Date,d_FromDate,103),103) 'FromDate',                        
    CONVERT(Varchar(10), Convert(Date,d_EndDate ,103),103) 'ToDate' ,
    FD.s_Label1 'File Type',FD.s_Label2 'From No',FD.s_Label3 'To No' 
    ,CONVERT(Varchar(10), Convert(Date,d_DestructionDueDate,103),103) 'Destruction Due Date',                                                   
    ACM_File_Status.s_AppCodeName  'FILE_Status',  
    ACM_Box_Status.s_AppCodeName  'BOX_Status',                              
    WO.n_WorkorderNo 'WorkorderNo',
    TPA.s_Address 'PickupAddress'                                                
    from               
    tbl_WorkOrder WO                                 
    Inner Join tbl_WoActivities WOA On WOA.n_WorkOrderNo =  WO.n_WorkorderNo             
    inner join tbl_FileTransactions ft on ft.n_WoActivityId=WOA.n_WoActivityId            
    inner join tbl_FileDetails fd on fd.n_FileId=ft.n_FileId            
    inner join tbl_BoxDetails bd on bd.n_BoxId=fd.n_BoxId                      
    inner Join tbl_PickupAddress PA On  WOA.n_PickupAddressId = PA.n_PickupAddressId                                          
    inner join tbl_Customer C on C.n_CustomerId=BD.n_CustomerId                                                          
    inner join tbl_ApplicationCodeMaster ACM_File_Status on ACM_File_Status.n_AppCodeId=FD.n_Status 
    inner join tbl_ApplicationCodeMaster ACM_Box_Status on ACM_Box_Status.n_AppCodeId= bd.n_Status                        
    inner join tbl_ApplicationCodeMaster ACMD on ACMD.n_AppCodeId=FD.n_DepartmentId 
    inner Join tbl_PickupAddress TPA on TPA.n_PickupAddressId = WOA.n_PickupAddressId               
    where C.n_CustomerId = 10
    and WOA.n_ActivityId in (1,2,3)