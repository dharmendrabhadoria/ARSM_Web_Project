using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using PRSMDAL; 
namespace PRSMBAL
{
    public class TransactionBAL
    {
        PRSMDAL.TransactionDAL objTransactionDAL = new PRSMDAL.TransactionDAL();


        #region [Work Order]
        public string AddUpdateWorkOrder(WorkOrder objWorkOrder)
        {
            return objTransactionDAL.AddUpdateWorkOrder(objWorkOrder);
        }

        public string AddUpdateWorkOrderActivities(string WoList, int WoActivityId, int ModifiedBy, int ActivityStatus, int? BoxCount, int? FileCount, int WorkorderNo)
        {
            return objTransactionDAL.AddUpdateWorkOrderActivities(WoList, WoActivityId, ModifiedBy, ActivityStatus, BoxCount, FileCount, WorkorderNo);
        }
        public DataSet GetWorkOrderNumber()
        {
            return objTransactionDAL.GetWorkOrderNumber();
        }

        public DataSet GetBoxbarCode(int iCustomerId, Int16 iBoxStatus)
        {
            return objTransactionDAL.GetBoxbarCode(iCustomerId, iBoxStatus);
        }

        public DataSet GetFileBarCode(int iCustomerId,int iBoxId,Int16 iFileStatus)
        {
            return objTransactionDAL.GetFileBarCode(iCustomerId, iBoxId, iFileStatus);
        }

        public DataSet GetFileBarCodeCount(int iCustomerId)
        {
            return objTransactionDAL.GetFileBarCodeCount(iCustomerId);
        } 

        public DataSet GetWorkOrder(int WorkorderNo,int iCompGroupId , int ICustomerId, int WareHouseId, int Status, DateTime? FromDate, DateTime? ToDate)
        {
            return objTransactionDAL.GetWorkOrder(WorkorderNo,iCompGroupId, ICustomerId, WareHouseId, Status, FromDate, ToDate);
        }
        public DataSet GetBoxFileDetailsByWONo(int WorkorderNo)
        {
            return objTransactionDAL.GetBoxFileDetailsByWONo(WorkorderNo);
        }
        public DataSet GetFileRetrivalRestoreByWONo(int WorkorderNo, int IsBoxesFiles)
        {
            return objTransactionDAL.GetFileRetrivalRestoreByWorkOrderNo(WorkorderNo, IsBoxesFiles);
        }

        public DataSet GetFileRetrievalOtherServicesDetailsByWoNo(int WorkorderNo)
        {
            return objTransactionDAL.GetFileRetrievalOtherServicesDetailsByWoNo(WorkorderNo);
        }

        public DataSet GetBoxFileDetailsByWONo_Paging(int WorkorderNo, int PageIndex, int PageSize)
        {
            return objTransactionDAL.GetBoxFileDetailsByWONo_Paging(WorkorderNo, PageIndex, PageSize);
        }

        public DataSet GetWoActivity(int WoActivityId, int WorkOrderNo, int ActivityStatus, string sPageName, int nServiceCategoryId)
        {
            return objTransactionDAL.GetWoActivity(WoActivityId, WorkOrderNo, ActivityStatus, sPageName, nServiceCategoryId);
        }
        public DataSet GetCompanyImage(int WorkOrderNo)
        {
            return objTransactionDAL.GetCompanyImage(WorkOrderNo);
        }
        public DataSet GetRetrivalBoxFileDetails(int iWorkOrderNo, int iWorkOrderActivityId, Int16 IsBoxFile, int nServiceCategoryId)
        {
            return objTransactionDAL.GetRetrivalBoxFileDetails(iWorkOrderNo, iWorkOrderActivityId, IsBoxFile, nServiceCategoryId);
        }
        public string InsertOtherTransactions(int OtherTransactionId,  int ActivityId, int ServiceCount, string OtherRemarks, int UserId,decimal Amount)
        {
            return objTransactionDAL.InsertOtherTransactions(OtherTransactionId, ActivityId, ServiceCount, OtherRemarks, UserId,Amount);
        }
        public DataSet GetWoActivitiesByServiceCategory(int WorkOrderNo, string sPageName, int nServiceCategoryId)
        {
            return objTransactionDAL.GetWoActivitiesByServiceCategory(WorkOrderNo, sPageName, nServiceCategoryId);
        }
        #endregion
       

        #region [BOX]
        public DataSet GetBoxDetails(int BoxId, int ICustomerId, Int16 WareHouseId, Int16 status)
        {
            return objTransactionDAL.GetBoxDetails(BoxId, ICustomerId, WareHouseId, status);
        }

        public DataSet InsertUpdateBoxDetails(int iCustomerId, Int16 iWareHouseId, string xmlBoxLabel, int iWoActivityId, Int16 iModifiedBy, Byte iIsnew)
        {
            return objTransactionDAL.InsertUpdateBoxDetails(iCustomerId, iWareHouseId, xmlBoxLabel, iWoActivityId, iModifiedBy, iIsnew);
        }

        #endregion
        #region
        public DataSet getFreshPickupData(FreshEntrySearch objSearch)
        {

            return objTransactionDAL.getFreshPickupData(objSearch);

        }
        #endregion
        #region [File]
        public DataSet InsertUpdateFileDetails(int iCustomerId, Int16 iWareHouseId, string xmlFileLabel, int iWoActivityId, Byte iIsnew, Int16 iModifiedBy)
        {
            return objTransactionDAL.InsertUpdateFileDetails(iCustomerId,iWareHouseId, xmlFileLabel, iWoActivityId, iIsnew, iModifiedBy);
        }

        public DataSet GetFileDetails(int iFileId, int iCustomerId, Int16 iWareHouseId, Int16 istatus, string FileBasecodes)
        {
            return objTransactionDAL.GetFileDetails(iFileId, iCustomerId, iWareHouseId, istatus, FileBasecodes);
        }
        public DataSet GetFileDetailsbyWoActivityId(int iWoActivityId)
        {
            return objTransactionDAL.GetFileDetailsbyWoActivityId(iWoActivityId);
        }
        #endregion
        #region [INVOICE]
        public DataSet GetTaxMasterDetails(int TaxId)
        {

            return objTransactionDAL.GetTaxMasterDetails(TaxId);
        }
        public DataSet GetProviderDetails(int CustomerId)
        {

            return objTransactionDAL.GetProviderDetails(CustomerId);
        }

        public DataSet GetHeaderFooterDetails(int ProviderID,string Filed)
        {

            return objTransactionDAL.GetHeaderFooterDetails(ProviderID, Filed);
        }
        public DataSet GenerateInvoice(int iMonth, int iYear, Int16 iWareHouseId, string strXmlCustomerList, Int16 iModifiedBy)
        {
            return objTransactionDAL.GenerateInvoice(iMonth,iYear, iWareHouseId, strXmlCustomerList, iModifiedBy);
        }
        public DataSet GetInvoice(int iMonth, int iYear, int iToMonth, int iToYear, int iCustomerId, int iGroupID,int iInvoice_No)
        {
            return objTransactionDAL.GetInvoice(iMonth, iYear, iToMonth, iToYear, iCustomerId, iGroupID, iInvoice_No);
        }
        public DataSet GetInvoiceList(int iMonth, int iYear, int iToMonth, int iToYear, int iCustomerId, int iGroupID)
        {
            return objTransactionDAL.GetInvoiceList(iMonth, iYear, iToMonth, iToYear, iCustomerId, iGroupID);
        }
        public DataSet USP_DemoInvoice(int n_InvoiceNo)
        {
            return objTransactionDAL.USP_DemoInvoice(n_InvoiceNo);
        }
        public DataSet GetInvoiceList_New(int iMonth, int iYear, int iToMonth, int iToYear, int iCustomerId, int iGroupID)
        {
            return objTransactionDAL.GetInvoiceList_New(iMonth, iYear, iToMonth, iToYear, iCustomerId, iGroupID);
        }
        public DataSet USP_GenerateInvoice_GST(int iMonth, int iYear, Int16 iWareHouseId, string strXmlCustomerList, Int16 iModifiedBy)
        {
            return objTransactionDAL.USP_GenerateInvoice_GST(iMonth, iYear, iWareHouseId, strXmlCustomerList, iModifiedBy);
        }
        public DataSet GetInvoice_New(int iMonth, int iYear, int iToMonth, int iToYear, int iCustomerId, int iGroupID, int WHID, int iInvoice_No)
        {
            return objTransactionDAL.GetInvoice_New(iMonth, iYear, iToMonth, iToYear, iCustomerId, iGroupID, WHID, iInvoice_No);
        }

        public DataSet GetCUSTOMERSERCH(int iCustomerId)
        {
            return objTransactionDAL.GetCUSTOMERSERCH(iCustomerId);
        }
        #endregion


        #region [Maker-Checker]
        public DataTable GetNoneApprovedWorkOrderNo()
        {
            return objTransactionDAL.GetNoneApprovedWorkOrderNo();
        }
        public DataTable GetCustmerCompanyWareHouseDataByWorkOrderNo(Int64 iWoOrderNo)
        {
            return objTransactionDAL.GetCustmerCompanyWareHouseDataByWorkOrderNo(iWoOrderNo);
        }
        public DataSet GetBoxFileDataByWorkOrderNo(Int64 iWoOrderNo)
        {
            return objTransactionDAL.GetBoxFileDataByWorkOrderNo(iWoOrderNo);
        }

        public DataSet UpdateBoxDetails(int iCustomerId, Int16 iWareHouseId, string xmlBoxLabel, Int32 iWono, Int16 iModifiedBy, Byte iIsnew)
        {
            return objTransactionDAL.UpdateBoxDetails(iCustomerId, iWareHouseId, xmlBoxLabel, iWono, iModifiedBy, iIsnew);
        }


        public DataSet UpdateFileDetails(int iCustomerId, Int16 iWareHouseId, string xmlFileLabel, Int32 iWono, Int16 iModifiedBy, Byte iIsnew)
        {
            return objTransactionDAL.UpdateFileDetails(iCustomerId, iWareHouseId, xmlFileLabel, iWono, iModifiedBy, iIsnew);
        }

        public DataSet ApproveBoxDetails(int iCustomerId, Int16 iWareHouseId, string xmlBoxLabel, Int32 iWono, Int16 iModifiedBy, Byte iIsnew)
        {
            return objTransactionDAL.ApproveBoxDetails(iCustomerId, iWareHouseId, xmlBoxLabel, iWono, iModifiedBy, iIsnew);
        }
        public DataSet ApproveFileDetails(int iCustomerId, Int16 iWareHouseId, string xmlFileDetails, Int32 iWono, Int16 iModifiedBy, Byte iIsnew)
        {
            return objTransactionDAL.ApproveFileDetails(iCustomerId, iWareHouseId, xmlFileDetails, iWono, iModifiedBy, iIsnew);
        }


        public DataSet InsertUpdateMakerBoxDetails(int iCustomerId, Int16 iWareHouseId, string xmlBoxLabel, int iWoActivityId, Int16 iModifiedBy, Byte iIsnew)
        {
            return objTransactionDAL.InsertUpdateMakerBoxDetails(iCustomerId, iWareHouseId, xmlBoxLabel, iWoActivityId, iModifiedBy, iIsnew);
        }


        public DataSet InsertUpdateMakerFileDetails(int iCustomerId, Int16 iWareHouseId, string xmlFileLabel, int iWoActivityId, Byte iIsnew, Int16 iModifiedBy)
        {
            return objTransactionDAL.InsertUpdateMakerFileDetails(iCustomerId, iWareHouseId, xmlFileLabel, iWoActivityId, iIsnew, iModifiedBy);
        }

        public int GetPendingFreshFilePickupCountByWorkorderNo(Int32 n_WorkOrderNo)
        {
            return objTransactionDAL.GetPendingFreshFilePickupCountByWorkorderNo(n_WorkOrderNo);
        }

        #endregion

        public DataSet GetServiceRequest_Close(int ServiceRequestNo, int iCompGroupId, int ICustomerId, int WareHouseId, int Status, DateTime? FromDate, DateTime? ToDate)
        {
            return objTransactionDAL.GetServiceRequest_Close(ServiceRequestNo, iCompGroupId, ICustomerId, WareHouseId, Status, FromDate, ToDate);
        }
        public DataSet UpdateServiceRequestActivityStatus(int ServiceRequestNo)
        {
            return objTransactionDAL.UpdateServiceRequestActivityStatus(ServiceRequestNo);
        }
        public DataSet CheckFilePickupAllApproved(int WorkOrderNo, int typ)
        {
            return objTransactionDAL.CheckFilePickupAllApproved(WorkOrderNo,typ);
        
        }

        public DataSet getMakerSearchData(MakerSearch objMakerSearch, int Fstatus)
        {

            //return objTransactionDAL.getMakerSearchData(objSearch);
            return objTransactionDAL.getMakerSearchData(objMakerSearch, Fstatus);

        }

        #region FilePickupUpload
        public DataSet xlImp_CheckDepartment()
        {
            return objTransactionDAL.xlImp_CheckDepartment();
        }
        public DataSet Customerworkorder(int IWareHouseId)
        {
            return objTransactionDAL.GetCustomer_workorder(IWareHouseId);
        }
        //public DataSet ValidateTempData(int n_WorkOrderNo)
        //{

        //    return objTransactionDAL.GetxlImp_ValidateTempData(n_WorkOrderNo);

        //}
        #endregion FilePickupUpload

        public bool InsertUpdFileDetails(MakerSearch objMakerSearch, out int isExist, bool isNew)
        {
            bool Status;
            Status = objTransactionDAL.InsertUpdFileDetails(objMakerSearch, out isExist, isNew);
            return Status;
        }

        public DataSet GetWoActivityId(int WorkOrderNo, int ActivityId)
        {
            return objTransactionDAL.GetWoActivityId(WorkOrderNo,ActivityId);

        }

        public DataSet GetEmailIds()
        {
            return objTransactionDAL.GetEmailIds();
        }
        //public int GetPendingFreshFilePickupCountByWorkorderNo(Int32 n_WorkOrderNo)
        //{
        //    return objTransactionDAL.GetPendingFreshFilePickupCountByWorkorderNo(n_WorkOrderNo);
        //}

        public bool InsertUpdBoxDetails(MakerSearch objMakerSearch, out int isExist)
        {
            bool Status;
            Status = objTransactionDAL.InsertUpdBoxDetails(objMakerSearch, out isExist);
            return Status;
        }
    }
}
