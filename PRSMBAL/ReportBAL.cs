using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using PRSMDAL ; 


namespace PRSMBAL
{
   public class ReportBAL
    {
       PRSMDAL.ReportDAL objReportDAL = new PRSMDAL.ReportDAL();
       public DataSet GetFilePickUpSummary(FilePickUpReport ObjFilePickup)
       {
           return objReportDAL.GetFilePickUpSummary(ObjFilePickup);
       }

       public DataSet GetFilePickUpDetails(FilePickUpReport ObjFilePickup)
       {
           return objReportDAL.GetFilePickUpDetails(ObjFilePickup);
       }

       public DataSet GetClientWiseFileDetails(ClientWiseFileDetailsReport ObjClientWieseFileDet)
       {
           return objReportDAL.GetClientWiseFileDetails(ObjClientWieseFileDet);
       }

       public DataSet GetClientWiseInventoryDetails(ClientWiseInventoryReport ObjClientInventory)
       {
           return objReportDAL.GetClientWiseInventoryReport(ObjClientInventory);
       }

       public DataSet GetInventoryDataAsOnDate(InventryReportAsOnDate ObjInvReport)
       {
           return objReportDAL.GetInventoryDataAsOnDate(ObjInvReport);
       }

       public DataSet GetFileRetrievalRestoreSummary(FilePickUpReport ObjFilePickup)
       {
           return objReportDAL.GetFileRetrievalRestoreSummary(ObjFilePickup);
       }
       public DataSet GetFileRetrievalRestoreDetails(FilePickUpReport ObjFilePickup)
       {
           return objReportDAL.GetFileRetrievalRestoreDetails(ObjFilePickup);
       }
       public DataSet GetWareHouseName()
       {
           return objReportDAL.GetWareHouseName();
       }
       public DataSet GetOtherServicesReport(OtherServicesReport ObjFilePickup)
       {
           return objReportDAL.GetOtherServicesReport(ObjFilePickup);
       }

       public DataSet GetServiceCompletionSummary(Int16 WarHouseId, int CompanyGroupId, int CustomerId, DateTime? FromDate, DateTime? ToDate)
       {
           return objReportDAL.GetServiceCompletionSummary(WarHouseId, CompanyGroupId, CustomerId, FromDate, ToDate);
       }
       public DataSet GetSrvcCompletionReport(Int16 WarHouseId, int CompanyGroupId, int CustomerId, int iWorkOrderNo, DateTime? FromDate, DateTime? ToDate)
       {
           return objReportDAL.GetSrvcCompletionReport(WarHouseId, CompanyGroupId, CustomerId, iWorkOrderNo, FromDate, ToDate);
       }
       public DataSet GetInvYearWiseBoxFileDetails(string ReportType, int CustomerId, int Year)
       {
           return objReportDAL.GetInvYearWiseBoxFileDetails(ReportType, CustomerId, Year);
       }
       public DataSet GetResRetDetails(int intCustomerId, string strCommandType, int intWorkOrderNo)
       {
           return objReportDAL.GetResRetDetails(intCustomerId, strCommandType, intWorkOrderNo);
       }
    }
    
}
