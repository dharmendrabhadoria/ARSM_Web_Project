using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PRSMDAL
{
    public class uspCommonConstants
    {
        //State-City-Country 

        internal const string GETSTATE = "usp_GetState";
        internal const string GETCITY = "usp_GetCity";
        internal const string ISCITYMASTEREXIST = "usp_CheckCityMaster";
        //Application details
        internal const string GETAPPLICATIONCODEDETAILS = "usp_GetApplicationCodeDetails";
        // Service Category
        internal const string GETSERVICECATEGORY        = "usp_GetServiceCategory";
        internal const string ADDUPDATESERVICECATEGORY  = "usp_InsertUpdateServiceCategory";
        // Activity 
        internal const string GETACTIVITY       = "usp_GetActivity";
        internal const string GETACTIVITYBYCATEGORY = "usp_GetActivitybyServiceCategory";
        internal const string ADDUPDATEACTIVITY = "usp_InsertUpdateActivity";
        //CompanyGroup
        internal const string GETCOMPANYGROUP          = "usp_GetCompanyGroup";
        internal const string INSERTUPDATECOMPANYGROUP = "usp_InsertUpdateCompanyGroup";
        //CompanyMaster
        internal const string GETCOMPANYMASTER = "usp_GetCompanyMaster";
        internal const string INSERTUPDATECOMPANYMASTER = "usp_InsertUpdateCompanyMaster";
        internal const string GETCOMPANYNAMEBYWHID = "usp_GetCompanyNameByWareHouseId";
        // UserMaster
        internal const string INSERTUPDATEUSERDETAILS = "usp_InsertUpdateUserMaster";
        internal const string GETUSERDETAILS = "usp_GetUserMaster";
        internal const string ISUSERNAMEEXIST = "usp_CheckUserName";
        internal const string GETUSERDETAILSBYUSERNAME = "usp_GetUserDetailsByUserName";

        //Rate Card
        internal const string GETRATECARD = "usp_GetRateCard";
        internal const string GETCUSTOMER = "usp_GetCustomer";
        internal const string INSERTUPDATERATECARD = "usp_InsertUpdateRateCard";
        //Customer
        internal const string ADDUPDATEPICKUPADDRESS = "usp_InsertUpdatePickupAddress";
        internal const string ADDUPDATECUSTOMER = "usp_InsertUpdateCustomer";
        internal const string GETCUSTOMERBYWAREHOUSEID = "usp_GetCustomerbyWareHouseId";
        internal const string GETCUSTOMERBYCUSTOMERID = "usp_GetCustomerbyCustomerId";
        internal const string GETCUSTOMERPICKUPADDRESS = "usp_GetPickUpAddress";
        internal const string GETPICKUPADDRESSOnWO = "usp_GetPickupAddressOnWO";
        internal const string GETAUTHORISEDPERSON = "usp_GetAuthorisedPerson";
        //City Master
        internal const string INSERTUPDATECITYMASTER = "usp_InsertUpdateCityMaster";
        //Ware House
        internal const string GETWAREHOUSE = "usp_GetWareHouse";
        internal const string INSERTUPDATEWAREHOUSEMASTER = "usp_InsertUpdateWareHouseMaster";
        internal const string GETRACKMASTERBYWAREHOUSEID = "usp_GetRackMasterByWareHouseId";
        //Rack Master
        internal const string GETRACKMASTER        = "usp_GetRackMaster";
        internal const string ADDUPDATERACKMASTER  = "usp_InsertUpdateRackMaster";
        internal const string GETWAREHOUSEMAXROWIDANDBOXSTARTNO = "usp_GetWarehouseMaxRowIdAndBoxStartNo";
        //Contract Master
        internal const string INSERTUPDATECONTRACTMASTER = "usp_InsertUpdateContractMaster";
        internal const string INSERTUPDATEDOCUMENT = "usp_InsertUpdateDocument";
        internal const string GETCONTRACT = "usp_GetContract";
        internal const string GETDOCUMENT = "usp_GetDocument";
        internal const string DELETEDOCUMENT = "usp_DeleteDocument";
        internal const string GETCONTRACTONCUSTOMER = "usp_GetContractbyCustomerId";
        internal const string GETCONTRACTNUMBER = "usp_GetContractNumber";
        //Work Order 
        internal const string INSERTUPDATEWORKORDER = "usp_InsertUpdateWorkOrder";
        internal const string INSERTUPDATEWORKORDERACTIVITIES = "usp_InsertUpdateWoActivities";
        internal const string GETWORKORDERNUMBER = "usp_GetWorkOrderNumber";
        internal const string GETWORKORDER = "usp_GetWorkOrder";
        internal const string GETWORKORDERACTIVITY = "usp_GetWoActivities";
        internal const string USP_GetCompanyImage = "USP_GetCompanyImage";
        internal const string GETBOXBARCODE  = "usp_GetBoxBarCode";
        internal const string GETFILEBARCODE = "usp_GetFileBarCode";
        internal const string GETFILEBARCODECOUNT = "usp_GetFileBarCodeCount";
        internal const string GETRETRIVALBOXFILEDETAILS = "usp_GetRetrivalBoxFileDetails";
        internal const string GETWORKORDERACTIVITYBYSERVICECATEGORY = "usp_GetWoActivitiesByServiceCategory";
        internal const string CHECKWORKORDERFPAPPROVEDCOUNT = "usp_CheckFPCountForCloseWOActivity";

        
        //Box file details 
        internal const string GETWOBOXDETAILS = "usp_GetBoxDetails";
        internal const string GETWOFILEDETAILS = "usp_GetFileDetails";
        internal const string INSERTUPDATEBOXDETAILS = "usp_InsertUpdateBoxDetails";
        internal const string INSERTUPDATEFILEDETAILS = "usp_InsertUpdateFileDetails";
        internal const string USP_GETBOXFILEDETAILSBYWOACTIVITY = "usp_GetBoxFileDetailsByWoActivity";
        internal const string GETBOXFILEDETAILSBYWONO = "usp_GetBoxFileDetailsByWoNo";
        internal const string GETBOXFILEDETAILSBYWONOpaging = "usp_GetBoxFileDetailsByWoNo_Paging";
        internal const string GETFILERETRIVALRESTOREBYWONO = "usp_GetFileRetrivalRestoreByWONo";
        internal const string GETFILERETRIEVALOTHERSERVICESBYWONO = "usp_GetFileRetrievalOtherServicesDetailsByWoNo";
        internal const string GETRESTORERETRIEVALDETAILS = "usp_ResRetDetails";
        //Page details
        internal const string GETPAGEFUNCATIONALITY = "usp_GetPageFunctionality";
        internal const string INSERTUPDATEPAGEFUNCTIONALITY = "usp_InsertUpdatePageFunctionality";
        internal const string GETDISTINCTPAGEFUNCATIONALITY = "usp_GetDistinctPageFunctionality";
        internal const string GETPAGEFUNCTIONALITYBYROLEANDPAGEID = "usp_GetPageFunctionalityByRoleAndPageId";       
        //Rolewise 
        internal const string GETROLEWISEACESS = "usp_GetRolewiseAcess";
        internal const string GETMENU = "usp_GetMenu";
        internal const string INSERTUPDATEROLEWISEACCESS = "usp_InsertUpdateRoleWiseAccess";
        //Other Services
        internal const string INSERTOTHERTRANSACTIONS = "usp_InsertOtherTransactions";
        //Invoice
        internal const string GETTAXMASTERDETAILS = "usp_GetTaxMasterDetails";
        internal const string GETPROVIDERMASTERDETAILS = "usp_GetProviderDetails";
        internal const string GETHEADERFOOTERDETAILS = "GetHeaderFooter";

        internal const string GENERATEINVOICE = "usp_GenerateInvoice";
        internal const string GETINVOICE          = "usp_GetInvoice";
        //internal const string GENERATEINVOICE_NEW = "usp_GenerateInvoice_New";
        internal const string USP_GenerateInvoice_GST = "USP_GenerateInvoice_GST";
        internal const string GETINVOICE_NEW = "usp_GetInvoice_New";
        internal const string CUSTOMERSERCH = "USP_CUSTOMERSERCH";
        internal const string GETINVOICELIST = "usp_GetInvoiceList";
        internal const string GETINVOICELIST_New = "usp_GetInvoiceList_New";
        internal const string USP_DemoInvoice = "USP_DemoInvoice";

        //Box Location
        internal const string GETBOXLOCATION = "usp_GetBoxLocation";
        internal const string INSERTUPDATEMAPLOCATION = "usp_InsertUpdateMapLocation";
        
        //Reports
        internal const string GETFILEPICKUPREPORTSUMMARY = "usp_GetFilePickUpSummaryReport";
        internal const string GETFILEPICKUPDETAILSREPORT = "usp_getFilePickUpDetailsReport";
        internal const string GETCLIENTWISEFILEDET = "usp_GetClientWiseFileDetails";
        internal const string GETCLIENTWISEINVENTORY = "usp_ClientWiseInventoryReport";
        internal const string GETYEARWISEBOXFILEDETAILS = "usp_GetYearWiseBoxFileDetails";
        //internal const string GETINVENTORYRPORTASONDATE = "usp_usp_getInventory_Report2";
        internal const string GETINVENTORYRPORTASONDATE = "USP_GetInventryData";
        internal const string GETTOPONEWAREHOUSE = "usp_getToponewarehouse";
        internal const string GETOTHERSERVIESREPORT = "usp_GetOtherServicesReport";

        //internal const string GETFILERETRIEVALRESTOREREPORTSUMMARY = "usp_getFileRetrivalRestoreSummary";
        internal const string GETFILERETRIEVALRESTOREREPORTSUMMARY = "usp_RetrivalRestoreReport";
        internal const string GETFILERETRIEVALRESTOREDETAILSREPORT = "usp_getFileRetrivalRestoreDetails";
        internal const string GETSERVICECOMPLETIONSUMMARY = "usp_GetServiceCompletionSummary";
        internal const string GETSERVICECOMPLETIONREPORT = "usp_GetServiceCompletionDetails";

        //Location and Row Master
        internal const string GETROWMASTER       = "usp_GetRowMaster";
        internal const string GETLOCATIONDETAILS = "usp_GetLocationDetails";
        internal const string GENRATELOCATION = "usp_GenrateLocation";
        internal const string INSERTUPDATEROWMASTER = "usp_InsertUpdateRowMaster";
        internal const string MAPLOCATIONS = "usp_MapLocations";
        internal const string ISROWMASTERNAMEEXIST = "usp_CheckRowMasterName";

        // Maker & Checker

        internal const string GETNONEAPPROVEDWORKORDERNOFORFILEPICKUP = "USP_GetNoneApprovedWorkOrderNoForFilePickup";
        internal const string GETCUSTMERCOMPANYWAREHOUSEDATABYWORKORDERNO = "USP_GetCustmerCompanyWareHouseDataByWorkOrderNo";
        internal const string GETBOXFILEDATABYWORKORDERNO = "USP_GetBoxFileDataByWorkOrderNo";
        internal const string UPDATEBOXDETAILS = "usp_UpdateBoxDetails";
        internal const string UPDATEFILEDETAILS = "usp_UpdateFileDetails";
        internal const string APPROVEBOXDETAILS = "usp_ApproveBoxDetails";
        internal const string APPROVEFILEDETAILS = "usp_ApproveFileDetails";
        internal const string INSERTUPDATEMAKERBOXDETAILS = "usp_InsertUpdateMakerBoxDetails";
        internal const string INSERTUPDATEMAKERFILEDETAILS = "usp_InsertUpdateMakerFileDetails";
        internal const string GETPENDINGFILECOUNTBYWORKORDERNO = "dbo.GetPendingFileCountByWorkOrderNo";

        // Customer User Master
        internal const string INSERTUPDATECUSTOMERUSERDETAILS = "USP_InsertUpdateCustomerUser";
        internal const string GETCUSTOMERUSERDETAILS = "usp_GetCustomerUserMaster";
        internal const string ISCUSTOMERUSERNAMEEXIST = "usp_CheckCustomerUserName";
        internal const string GETCUSTOMERUSERDETAILSBYUSERNAME = "usp_GetCustomerDetailsByUserName";
        internal const string GETCONTRACTENDDATE = "GetContractEndDate";
        
        //For File Search
        internal const string GETFILEDETAILS = "usp_getFileRecords";
        
        //SERVICE REQUEST
        internal const string GETGETSERVICEREQUESTCLOSE = "usp_GetServiceRequest_Close";
        internal const string UPDATESERVICEREQUESTACTIVITYSTATUS = "usp_UpdateServiceRequestActivityStatus";
        internal const string GETSERVICEREQUESTBYCUSTOMER = "USP_GetServiceRequestByCustomer";
        internal const string GETSERVICEREQUESTWORKORDER = "USP_GetServiceRequestForWO";
        //internal const string DemoGETSERVICEREQUESTWORKORDER = "USP_DemoGetServiceRequestByCustomer";
        internal const string GETSERVICEREQUESRDETAILS = "USP_GetServiceRequestDetails";
        
        // Account Master
        internal const string GETINVOICENO = "usp_GetInvoiceNo";
        internal const string GETPAYMENTTYPE = "usp_GetPaymentType";
        internal const string GETPAYMENTSTATUS = "GetPaymentStatus";
        internal const string INSERTUPDATEPAYMENT = "usp_InsertUpdatePayment";
        internal const string GETPAYMENTDETAILS = "GetPaymentDetails";
        internal const string GETINVOICEAMOUNT = "GetInvoiceAmount";
        internal const string GETCUSTWO = "usp_GetCustomer_WorkOrder";
        internal const string GETMAKERSEARCHDATA = "usp_getMakerSearchData";
        internal const string GETFILEFOREDIT = "usp_EditMakerSearchData";
        internal const string GETWOACTIVITYID = "usp_GetGetWoActivityID";

        //Customer Enquiry 
        internal const string GETEMAILIDS = "usp_GetEmailIds";
        internal const string FILEINSERTUPDATE = "Usp_InsertUpdateFileDetails_2";
        internal const string BOXINSERTUPDATE = "Usp_InsertUpdateBoxDetails_2";

        //FilePickupUpload
        //internal const string XLIMPVALIDATETEMPDATA = "usp_xlImp_ValidateTempData";
        internal const string GETCUSTOMERWORKORDER = "usp_GetCustomer_WorkOrder";

        
    }
}
