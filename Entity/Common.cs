using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Entity
{
    public class Common
    {
    }
    public class Autocomplete
    {
        public string label { get; set; }
        public int value { get; set; }
        public Autocomplete()
        {
            //
            // TODO: Add constructor logic here
            //
        }
    }

    public class ApllicationCodeMasterr
    {
        public int AppCodeId { get; set; }
        public string AppCode { get; set; }
        public string AppCodeName { get; set; }
    }

    public class CountryMaster
    {
        public int CountryId { get; set; }
        public string CountryName { get; set; }
    }
    public class State
    {
        public int StateId { get; set; }
        public int CountryId { get; set; }
        public string StateName { get; set; }
    }

    public class City
    {
        public int CityId { get; set; }
        public string CityName { get; set; }
        public int StateId { get; set; }
        public int UserId { get; set; }
    }

    public class UserMaster
    { 
        public int UserId { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public DateTime BirthDate { get; set; }
        public int Department { get; set; }
        public string UserName { get; set; }
        public string EmailId { get; set; }
        public string Password { get; set; }
        public Boolean LoginStatus { get; set; }
        public int IsActive { get; set; }
        public int UserRole { get; set; }
    }
    public class ServiceCategory
    {
        public int ServiceCategoryId { get; set; }
        public string SCName { get; set; }
        public string Remark { get; set; }
        public Byte IsEdit { get; set; }
        public int UserId { get; set; }
        public int DisplayOrder { get; set; }
    }
    public class Activity
    {
        public int ActivityId { get; set; }
        public int ServiceCategoryId { get; set; }
        public string ActivityName { get; set; }
        public string Remark { get; set; }
        public Byte IsEdit { get; set; }
        public int UserId { get; set; }
        public string SCName { get; set; }
        public int Unit { get; set; }
        public int UnitCount { get; set; }
        public Byte IsShowinRateCard { get; set;}
    }

    public class CompanyGroup
    {
        public int CompanyGroupId { get; set; }
        public string CGName { get; set; }
        public int IndustryId { get; set; }
        public string RegisterAddress { get; set; }
        public int StateId { get; set; }
        public int CityId { get; set; }
        public string PinCode { get; set; }
        public string CorporateAddress { get; set; }
        public int CorporateStateId { get; set; }
        public int CorporateCityId { get; set; }
        public string CorporatePinCode { get; set; }
        public string PANNumber { get; set; }
        public string TANNumber { get; set; }
        public string ContactPerson { get; set; }
        public string PhoneNumber { get; set; }
        public string MobileNumber { get; set; }
        public string Email { get; set; }
        public string ContactPerson1 { get; set; }
        public string PhoneNumber1 { get; set; }
        public string MobileNumber1 { get; set; }
        public string Email1 { get; set; }
        public int UserId { get; set; }
        public string RegAddress1 { get; set; }
        public string RegAddress2 { get; set; }
        public string CorpAddress1 { get; set; }
        public string CorpAddress2 { get; set; }
    }
    public class CompanyMaster
    {
        public int CompanyMasterId { get; set; }
        public string CMName { get; set; }
        public int IndustryId { get; set; }
        public string RegisterAddress { get; set; }
        public int StateId { get; set; }
        public int CityId { get; set; }
        public string PinCode { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string Fax { get; set; }
        public string CorporateAddress { get; set; }
        public int CorporateStateId { get; set; }
        public int CorporateCityId { get; set; }
        public string CorporatePinCode { get; set; }
        public string CorporateEmail { get; set; }
        public string CorporatePhone { get; set; }
        public string CorporateFax { get; set; }
        public string PANNumber { get; set; }
        public string TANNumber { get; set; }
        public string CINNumber { get; set; }
        public string VATNumber { get; set; }
        public string SALESTaxNumber { get; set; }  
        public int UserId { get; set; }
    }
    public class Customer
    {
        public int CustomerId { get; set; }
        public string CustomerName { get; set; }
        public int CompanyGroupId { get; set; }
        public string BillingAddress { get; set; }
        public int StateId { get; set; }
        public int CityId { get; set; }
        public int UserId { get; set; }
        public string CustPinCode { get; set; }
        public string BillingAddress1 { get; set; }
        public string BillingAddress2 { get; set; }
        public string BillingMode { get; set; }
    }
    public class PickupAddress
    {
        public int PickupAddressId { get; set; }
        public int CustomerId { get; set; }
        public string Address { get; set; }
        public int StateId { get; set; }
        public int CityId { get; set; }
        public int DepartmentId { get; set; }
        public string Department { get; set; }
        public string AuthorisedPerson { get; set; }
        public string PhoneNumber { get; set; }
        public string Email { get; set; }
        public int UserId { get; set; }
        public string PickUpPinCode{get;set;}
    }
    public class RateCard
    {
        public int RateCardId { get; set; }
        public int CustomerId { get; set; }
        public int ActivityId { get; set; }
        public Decimal Rate { get; set; }
        public int UserId { get; set; }
        public DateTime FromDate { get; set; }
        public DateTime Todate { get; set; }
    }
    public class WareHouse
    {
        public int WareHouseId { get; set; }
        public string WarehouseName { get; set; }
        public string WarehouseCode { get; set; }
        public int TotalRows { get; set; }
        public string Address { get; set; }
        public int StateId { get; set; }
        public int CityId { get; set; }
        public int UserId { get; set; }
        public string Address1 { get; set; }
        public string Address2 { get; set; }
    }
    public class RackMaster
    {
        public Int16 RackId { get; set; }
        public string RackName { get; set; }
        public string RowName { get; set; }
        public Int16 WareHouseId { get; set; }
        public Int16 NoOfShelf { get; set; }
        public Int16 NoOfBoxePerShelf { get; set; }
        public int BoxStartNo { get; set; }
        public string Remark { get; set; }
        public decimal Height { get; set; }
        public decimal Width { get; set; }
        public decimal Depth { get; set; }
        public int UserId { get; set; }
        public int NoofRacks { get; set; }
        public Int16 RowId { get; set; }
        public int BoxEndNo { get; set; }
    }

    public class ContractMaster
    {
        public int ContractId { get; set; }
        public int ContractNo { get; set; }
        public int CustomerId { get; set; }
        public DateTime FromDate { get; set; }
        public DateTime EndDate { get; set; }
        public Int16 SalesPersonId { get; set; }
        public string Remark { get; set; }
        public Int16 UserId { get; set; }
        public string DocumentName { get; set; }
        public string Filepath { get; set; }
    }

    public class Document
    {
        public int DocumentId { get; set; }
        public int ContractId { get; set; }
        public int CustomerId { get; set; }
        public string DocumentName { get; set; }
        public string Filepath { get; set; }
        public Int16 UserId { get; set; }
    }
    public class ServiceRequest
    {
        public int SRId { get; set; }
        public string ServiceNo { get; set; }
        public DateTime SRDate { get; set; }
        public int CGid { get; set; }
        public string CGName { get; set; }
        public string Customer { get; set; }
        public int CustomerId { get; set; }
        public int ServiceCategoryId { get; set; }
        public string SCName { get; set; }
        public int NoofBoxes { get; set; }
        public int NoofFiles { get; set; }
        public string Remark { get; set; }
        public int ServiceStatusid { get; set; }
        public string ServiceStatus { get; set; }
        public List<Activity> lstActivity { get; set; }
    }
    public class WorkOrder
    {
        public int WorkorderNo { get; set; }
        public DateTime WoDate { get; set; }
        public int CustomerId { get; set; }
        public string Remark { get; set; }
        public int wareHouseId { get; set; }
        public int PickupAddressId { get; set; }
        public string Customer { get; set; }
        public string Status { get; set; }
        public int StatuseId { get; set; }
        public Int16 UserId { get; set; }
        public List<WoActivites> lstActivity { get; set; }
        public string x_WorkorderList { get; set; }
        public string x_RetrivalFileBoxList { get; set; }
        public int ActivityStatus { get; set; }
        public int ServiceRequestNo { get; set; }
       }

    public class WoActivites
    {
        public int WorkorderNo { get; set; }
        public int CustomerId { get; set; }
        public string Remark { get; set; }
        public string ActivityStatus { get; set; }
        public byte ActivityStatuseId { get; set; }
    }
    //Reports
    public class FilePickUpReport
    {
        public int Reportby { get; set; }
        public int WareHouseId { get; set; }
        public int CompanyGroupId { get; set; }
        public int? CustomerId { get; set; }
        public int PickupAddressId { get; set; }
        public int DepartmentId { get; set; }
        public DateTime? FromDate { get; set; }
        public DateTime? ToDate { get; set; }
        public int Periodically { get; set; }
        public int year { get; set; }
        public int IsDateRange { get; set; }
        public int Month { get; set; }
        public byte ReportType { get; set; }
        public byte ClientOrDept { get; set; }
        
    }

    public class ClientWiseFileDetailsReport
    {
        public int CustomerId { get; set; }
        public int year { get; set; }
        public int Month { get; set; }
        public string WorkOrderNo { get; set; }
    }

    public class ClientWiseInventoryReport
    {
        public Int16 WareHouseId { get; set; }
        public int CustomerId { get; set; }
        public int CompanyGroupId { get; set; }
        public DateTime? FromDate { get; set; }
        public DateTime? ToDate { get; set; }
    }

    public class RowMaster
    {
        public Int16 RowId { get; set; }
        public string RowName { get; set; }
        public Int16 WareHouseId { get; set; }
        public Int16 NoofShelf { get; set; }
        public Int16 NoOfLocationPerSelf { get; set; }
        public string Remark { get; set; }
        public Int16 UserId { get; set; }
    }
    public class InventryReportAsOnDate
    {
        public Int16 WareHouseId { get; set; }        
        public Int16 Report_type { get; set; }
        public Int16 Year { get; set; }
        public Int32 CustomerID { get; set; }
        public DateTime? FromDate { get; set; }
        public DateTime? ToDate { get; set; }
    }

    public class OtherServicesReport
    {
        public int ActivityId { get; set; }
        public int CustomerId { get; set; }
        public DateTime? FromDate { get; set; }
        public DateTime? ToDate { get; set; }
        public Byte IsSummary{get;set; }

    }

    public class FreshEntrySearch
    {
        public int WareHouseId { get; set; }
        public int CompanyGroupId { get; set; }
        public int CustomerId { get; set; }
        public string FileBarcode { get; set; }
        public string FileName { get; set; }
        public int Department { get; set; }
        public string label1 { get; set; }
        public string label2 { get; set; }
        public string label3 { get; set; }
        public int Type { get; set; }
        public string FileDesc2 { get; set; }
    }

    public class MakerSearch
    {
        public int FileId { get; set; }
        public int WareHouseId { get; set; }
        public int WorkOrderNo { get; set; }
        //public int CustomerId { get; set; }
        public int PickupAddressId { get; set; }
        public string BoxBarcode { get; set; }
        public string FileBarcode { get; set; }        
        public int Department { get; set; }
        public string FileDesc1 { get; set; }
        public string FileDesc2 { get; set; }
        public string FileType { get; set; }
        public string year { get; set; }
        public string FromDate { get; set; }
        public string ToDate { get; set; }
        public string FromNum { get; set; }
        public string ToNum { get; set; }
        public string DestructionDueDate { get; set; }
        public int BranchID { get; set; }
        public int WoActivityId { get; set; }
        public int CustId { get; set; }
        public int ModifiedBy { get; set; }
        public string BoxLocationCode { get; set; }
        public int BoxStatus { get; set; }
        public string ImageDrive { get; set; }
        public string ImageFolder { get; set; }
        
    }
        
}
