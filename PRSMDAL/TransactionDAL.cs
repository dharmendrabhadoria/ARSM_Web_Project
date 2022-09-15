using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Microsoft.ApplicationBlocks.Data; 
using Entity;
using Utility; 

namespace PRSMDAL
{
    public class TransactionDAL
    {
        SqlConnection Connection;
        DataSet dsresult;
        public TransactionDAL()
        {

            Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PRSMDataBaseConnection"].ConnectionString);
        }
        private SqlConnection Conn
        {
            get
            {
                if (Connection == null)
                    Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PRSMDataBaseConnection"].ConnectionString);
                return Connection;
            }

        }
        #region
        public DataSet getFreshPickupData(FreshEntrySearch objSearch)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[11];
                param[0] = new SqlParameter("@WareHouseId", objSearch.WareHouseId);
                param[1] = new SqlParameter("@CustomerId", objSearch.CustomerId);
                param[2] = new SqlParameter("@CompanyGroupId", objSearch.CompanyGroupId);
                param[3] = new SqlParameter("@FileBarCode", objSearch.FileBarcode);
                param[4] = new SqlParameter("@FileName", objSearch.FileName);
                param[5] = new SqlParameter("@Department",objSearch.Department);
                param[6] = new SqlParameter("@label1", objSearch.label1);
                param[7] = new SqlParameter("@label2", objSearch.label2);
                param[8] = new SqlParameter("@label3", objSearch.label3);
                param[9] = new SqlParameter("@Type", objSearch.Type);
                param[10] = new SqlParameter("@FileDesc2", objSearch.FileDesc2);

                dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETFILEDETAILS, param);
            }
            catch (Exception ex)
            {
                ErrorHandler.WriteLog(ex);
            }
            return dsresult;
        }
        #endregion
        #region [Work Order]

        public string AddUpdateWorkOrder(WorkOrder objWorkOrder)
        {
            SqlParameter[] param = new SqlParameter[11];
            param[0] = new SqlParameter("@pn_WorkorderNo", objWorkOrder.WorkorderNo);
            param[0].Direction = ParameterDirection.Output;
            param[1] = new SqlParameter("@pd_WoDate", objWorkOrder.WoDate);
            param[2] = new SqlParameter("@pn_CustomerId", objWorkOrder.CustomerId);
            param[3] = new SqlParameter("@ps_Remark", objWorkOrder.Remark);
            param[4] = new SqlParameter("@pn_WareHouseId", objWorkOrder.wareHouseId);
            param[5] = new SqlParameter("@px_WorkorderList", objWorkOrder.x_WorkorderList);
            param[6] = new SqlParameter("@pn_ActivityStatus", objWorkOrder.ActivityStatus);
            param[7] = new SqlParameter("@pn_Status", objWorkOrder.StatuseId);
            param[8] = new SqlParameter("@pn_ModifiedBy", objWorkOrder.UserId);
            param[9] = new SqlParameter("@px_RetrvalBoxFile", objWorkOrder.x_RetrivalFileBoxList);
            param[10] = new SqlParameter("@pn_ServiceRequestNo", objWorkOrder.ServiceRequestNo);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.INSERTUPDATEWORKORDER, param);
            string StrMsg = "";
            if (dsresult.Tables.Count> 0)
                {
                if(dsresult.Tables[0].Columns.Contains("ErrorNumber"))
                    {
                        ErrorHandler.WriteLog(dsresult);
                        StrMsg = dsresult.Tables[0].Rows[0]["ErrorMessage"].ToString();
                    }
               }
                 if(!string.IsNullOrEmpty(Convert.ToString(param[0].Value))) 
                    {
                      StrMsg = "Record Saved Successfully with Work order No - " + Convert.ToInt32(param[0].Value) + ".";
                   }
            return StrMsg;
        }
        public string AddUpdateWorkOrderActivities(string WoList, int WoActivityId, int ModifiedBy, int ActivityStatus, int? BoxCount, int? FileCount, int WorkorderNo)
        {

            SqlParameter[] param = new SqlParameter[9];
            param[0] = new SqlParameter("@px_WorkorderList", WoList);
            param[1] = new SqlParameter("@pn_WoActivityId", WoActivityId);
            param[2] = new SqlParameter("@pn_ModifiedBy", ModifiedBy);
            param[3] = new SqlParameter("@pn_ActivityStatus", ActivityStatus);
            param[4] = new SqlParameter("@pn_BoxCount", BoxCount);
            param[5] = new SqlParameter("@pn_FileCount", FileCount);
            param[6] = new SqlParameter("@pn_WorkorderNo", WorkorderNo);
            param[7] = new SqlParameter("@px_RetrvalBoxFile", "<NewDataSet/>");
            param[8] = new SqlParameter("@IsLogError", 0); //Default IsLogError = 0 No error
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.INSERTUPDATEWORKORDERACTIVITIES, param);
            if (dsresult.Tables.Count == 0)
            {
                return "Record Saved Successfully.";
            }
            else
            {
                ErrorHandler.WriteLog(dsresult);
                return dsresult.Tables[0].Rows[0][5].ToString();
            }
        }
        public DataSet GetWorkOrderNumber()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[0];
                dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETWORKORDERNUMBER, param);
            }
            catch (Exception ex)
            {
                ErrorHandler.WriteLog(ex);
            }
            return dsresult;
        }
        public DataSet GetWorkOrder(int WorkorderNo,int iCompGroupId , int ICustomerId, int WareHouseId, int Status, DateTime? FromDate, DateTime? ToDate)
        {
            SqlParameter[] param = new SqlParameter[7];
            param[0] = new SqlParameter("@pn_WorkorderNo", WorkorderNo);
            param[1] = new SqlParameter("@pn_CGroupId", iCompGroupId);
            param[2] = new SqlParameter("@pn_CustomerId", ICustomerId);
            param[3] = new SqlParameter("@pn_WareHouseId", WareHouseId);
            param[4] = new SqlParameter("@pn_Status", Status);
            param[5] = new SqlParameter("@pd_FromDate", FromDate);
            param[6] = new SqlParameter("@pd_ToDate", ToDate);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETWORKORDER, param);
            return dsresult;
        }

        public DataSet GetBoxFileDetailsByWONo(int WorkorderNo)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@pn_WorkorderNo", WorkorderNo);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETBOXFILEDETAILSBYWONO, param);
            return dsresult;
        }


        public DataSet GetBoxFileDetailsByWONo_Paging(int WorkorderNo, int PageIndex, int PageSize)
        {
            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@pn_WorkorderNo", WorkorderNo);
            param[1] = new SqlParameter("@PageIndex", PageIndex);
            param[2] = new SqlParameter("@PageSize", PageSize);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETBOXFILEDETAILSBYWONOpaging, param);
            return dsresult;
        }

        public DataSet GetFileRetrivalRestoreByWorkOrderNo(int WorkorderNo, int IsBoxesFiles)
        {
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@Pn_WorkOrderNo", WorkorderNo);
            param[1] = new SqlParameter("@nBoxFileType", IsBoxesFiles);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETFILERETRIVALRESTOREBYWONO, param);
            return dsresult;
        }

        public DataSet GetFileRetrievalOtherServicesDetailsByWoNo(int WorkorderNo)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@Pn_WorkOrderNo", WorkorderNo);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETFILERETRIEVALOTHERSERVICESBYWONO, param);
            return dsresult;
        }

        public DataSet GetBoxbarCode(int iCustomerId, Int16 iBoxStatus)
        {
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@Pn_CustomerId", iCustomerId);
            param[1] = new SqlParameter("@pn_BoxStatus", iBoxStatus);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETBOXBARCODE, param);
            return dsresult;
        }


        public DataSet GetFileBarCode(int iCustomerId, int iBoxId, Int16 iFileStatus)
        {
            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@Pn_CustomerId", iCustomerId);
            param[1] = new SqlParameter("@Pn_BoxId", iBoxId);
            param[2] = new SqlParameter("@pn_FileStatus", iFileStatus);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETFILEBARCODE, param);
            return dsresult;
        }

        public DataSet GetFileBarCodeCount(int iCustomerId)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@Pn_CustomerId", iCustomerId);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETFILEBARCODECOUNT, param);
            return dsresult;
        }

        public DataSet GetWoActivity(int WoActivityId, int WorkOrderNo, int ActivityStatus, string sPageName, int nServiceCategoryId)
        {
            SqlParameter[] param = new SqlParameter[5];
            param[0] = new SqlParameter("@pn_WoActivityId", WoActivityId);
            param[1] = new SqlParameter("@pn_WorkOrderNo", WorkOrderNo);
            param[2] = new SqlParameter("@pn_ActivityStatus", ActivityStatus);
            param[3] = new SqlParameter("@ps_PageName", sPageName);
            param[4] = new SqlParameter("@n_ServiceCategoryId", nServiceCategoryId);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETWORKORDERACTIVITY, param);
            return dsresult;
        }
        public DataSet GetCompanyImage(int WorkOrderNo)
        {
            SqlParameter param = new SqlParameter();
            param = new SqlParameter("@n_WorkorderNo", WorkOrderNo);

            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.USP_GetCompanyImage, param);
            return dsresult;
        }
        public DataSet GetRetrivalBoxFileDetails(int iWorkOrderNo, int iWorkOrderActivityId, Int16 IsBoxFile, int nServiceCategoryId)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[4];
                param[0] = new SqlParameter("@pn_WorkOrderNo",iWorkOrderNo);
                param[1] = new SqlParameter("@n_WoActivityId", iWorkOrderActivityId);
                param[2] = new SqlParameter("@n_IsBoxFile", IsBoxFile);
                param[3] = new SqlParameter("@n_ServiceCategoryId", nServiceCategoryId);
                dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETRETRIVALBOXFILEDETAILS, param);
            }
            catch (Exception ex)
            {
                ErrorHandler.WriteLog(ex);
            }
            return dsresult;
        }


        public string InsertOtherTransactions(int OtherTransactionId, int ActivityId, int ServiceCount,string OtherRemarks,int UserId,decimal Amount)
        {

            SqlParameter[] param = new SqlParameter[6];
            param[0] = new SqlParameter("@pn_OtherTransId", OtherTransactionId);
            param[1] = new SqlParameter("@pn_WoActivityId", ActivityId);
            param[2] = new SqlParameter("@pn_ServiceCount", ServiceCount);
            param[3] = new SqlParameter("@ps_Remarks", OtherRemarks);
            param[4] = new SqlParameter("@pn_ModifiedBy", UserId);
            param[5] = new SqlParameter("@pn_Amount", Amount);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.INSERTOTHERTRANSACTIONS, param);
            if (dsresult.Tables.Count == 0)
            {
                return "Record Saved Successfully.";
            }
            else
            {
                return "Error In Saving Record.";
            }
        }

        public DataSet GetWoActivitiesByServiceCategory(int WorkOrderNo, string sPageName, int nServiceCategoryId)
        {
            SqlParameter[] param = new SqlParameter[3];

            param[0] = new SqlParameter("@pn_WorkOrderNo", WorkOrderNo);
            param[1] = new SqlParameter("@ps_PageName", sPageName);
            param[2] = new SqlParameter("@n_ServiceCategoryId", nServiceCategoryId);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETWORKORDERACTIVITYBYSERVICECATEGORY, param);
            return dsresult;
        }
        #endregion
        #region [Box Details]
        public DataSet GetBoxDetails(int BoxId, int ICustomerId, Int16 WareHouseId, Int16 status)
        {
            SqlParameter[] param = new SqlParameter[4];
            param[0] = new SqlParameter("@pn_BoxId", BoxId);
            param[1] = new SqlParameter("@pn_CustomerId", ICustomerId);
            param[2] = new SqlParameter("@pn_WareHouseId", WareHouseId);
            param[3] = new SqlParameter("@pn_Status", status);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETWOBOXDETAILS, param);
            return dsresult;
        }
        public DataSet  InsertUpdateBoxDetails(int iCustomerId, Int16 iWareHouseId, string xmlBoxDetails,int iWoActivityId, Int16 iModifiedBy,Byte iIsnew)
        {
            SqlParameter[] param = new SqlParameter[6];
            param[0] = new SqlParameter("@pn_CustomerId", iCustomerId);
            param[1] = new SqlParameter("@pn_WareHouseId", iWareHouseId);
            param[2] = new SqlParameter("@ps_xmlBoxLabel", xmlBoxDetails);
            param[3] = new SqlParameter("@pn_WoActivityId", iWoActivityId);
            param[4] = new SqlParameter("@pn_ModifiedBy",  iModifiedBy);
            param[5] = new SqlParameter("@IsNew", iIsnew);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.INSERTUPDATEBOXDETAILS, param);
            return dsresult;
        }
        #endregion
        #region [File Details]
        public DataSet GetFileDetails(int iFileId, int iCustomerId, Int16 iWareHouseId, Int16 istatus, string sFileCodes)
          {
              SqlParameter[] param = new SqlParameter[5];
              param[0] = new SqlParameter("@pn_FileId", iFileId);
              param[1] = new SqlParameter("@pn_CustomerId", iCustomerId);
              param[2] = new SqlParameter("@pn_WareHouseId", iWareHouseId);
              param[3] = new SqlParameter("@pn_Status", istatus);
              param[4] = new SqlParameter("ps_FileBarCodes", sFileCodes);

              dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETWOFILEDETAILS, param);
              return dsresult;

          }

          public DataSet InsertUpdateFileDetails(int iCustomerId, Int16 iWareHouseId, string xmlFileLabel, int iWoActivityId, Byte iIsnew, Int16 iModifiedBy)
          {
              SqlParameter[] param = new SqlParameter[6];
              param[0] = new SqlParameter("@pn_CustomerId", iCustomerId);
              param[1] = new SqlParameter("@pn_WareHouseId", iWareHouseId);
              param[2] = new SqlParameter("@ps_xmlFileDetails", xmlFileLabel);
              param[3] = new SqlParameter("@pn_WoActivityId", iWoActivityId);
              param[4] = new SqlParameter("@IsNew", iIsnew);
              param[5] = new SqlParameter("@pn_ModifiedBy", iModifiedBy);
              dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.INSERTUPDATEFILEDETAILS, param);
              return dsresult;
          }
          public DataSet GetFileDetailsbyWoActivityId(int iWoActivityId)
          {
              SqlParameter[] param = new SqlParameter[1];
              param[0] = new SqlParameter("@pn_WoActivityId", iWoActivityId);
              dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.USP_GETBOXFILEDETAILSBYWOACTIVITY, param);
              return dsresult;

          }

        #endregion

        #region [INVOICE]
          public DataSet GetTaxMasterDetails(int TaxId)
          {
              SqlParameter[] param = new SqlParameter[1];
              param[0] = new SqlParameter("@Pn_TaxId", TaxId);
              dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETTAXMASTERDETAILS, param);
              return dsresult;

          }

          public DataSet GetProviderDetails(int CustomerId)
          {
              SqlParameter[] param = new SqlParameter[1];
              param[0] = new SqlParameter("@CustomerId", CustomerId);
              dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETPROVIDERMASTERDETAILS, param);
              return dsresult;

          }

          public DataSet GetHeaderFooterDetails(int ProviderID, string Filed)
          {
              SqlParameter[] param = new SqlParameter[2];
              param[0] = new SqlParameter("@ProviderId", ProviderID);
              param[1] = new SqlParameter("@Filed", Filed);
              dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETHEADERFOOTERDETAILS, param);
              return dsresult;

          }


          public DataSet GenerateInvoice(int iMonth, int iYear, Int16 iWareHouseId, string strXmlCustomerList, Int16 iModifiedBy)
          {
              SqlParameter[] param = new SqlParameter[5];
              param[0] = new SqlParameter("@pn_Month", iMonth);
              param[1] = new SqlParameter("@pn_Year", iYear);
              param[2] = new SqlParameter("@pn_WareHouseId", iWareHouseId);
              param[3] = new SqlParameter("@pXmlCustomerList", strXmlCustomerList);
              param[4] = new SqlParameter("@n_UserId", iModifiedBy);
              dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GENERATEINVOICE, param);
              return dsresult;
          }

          public DataSet GetInvoice(int iMonth, int iYear, int iToMonth, int iToYear, int iCustomerId, int iGroupID, int iInvoice_No)
          {
              SqlParameter[] param = new SqlParameter[7];
              param[0] = new SqlParameter("@pn_Month", iMonth);
              param[1] = new SqlParameter("@pn_Year", iYear);
              param[2] = new SqlParameter("@pn_ToMonth", iToMonth);
              param[3] = new SqlParameter("@pn_ToYear", iToYear);
              param[4] = new SqlParameter("@pn_CustomerId", iCustomerId);
              param[5] = new SqlParameter("@pn_CustGroupId", iGroupID);
              param[6] = new SqlParameter("@Invoice_No", iInvoice_No);
              dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETINVOICE, param);
              return dsresult;
          }
          public DataSet GetInvoiceList(int iMonth, int iYear, int iToMonth, int iToYear, int iCustomerId, int iGroupID)
          {
              SqlParameter[] param = new SqlParameter[6];
              param[0] = new SqlParameter("@pn_Month", iMonth);
              param[1] = new SqlParameter("@pn_Year", iYear);
              param[2] = new SqlParameter("@pn_ToMonth", iToMonth);
              param[3] = new SqlParameter("@pn_ToYear", iToYear);
              param[4] = new SqlParameter("@pn_CustomerId", iCustomerId);
              param[5] = new SqlParameter("@pn_CustGroupId", iGroupID);
             
              dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETINVOICELIST, param);
              return dsresult;
          }
          public DataSet USP_DemoInvoice(int n_InvoiceNo)
          {
              SqlParameter[] param = new SqlParameter[1];
              param[0] = new SqlParameter("@n_InvoiceNo", n_InvoiceNo);
              dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.USP_DemoInvoice, param);
              return dsresult;
          }
          public DataSet GetInvoiceList_New(int iMonth, int iYear, int iToMonth, int iToYear, int iCustomerId, int iGroupID)
          {
              SqlParameter[] param = new SqlParameter[6];
              param[0] = new SqlParameter("@pn_Month", iMonth);
              param[1] = new SqlParameter("@pn_Year", iYear);
              param[2] = new SqlParameter("@pn_ToMonth", iToMonth);
              param[3] = new SqlParameter("@pn_ToYear", iToYear);
              param[4] = new SqlParameter("@pn_CustomerId", iCustomerId);
              param[5] = new SqlParameter("@pn_CustGroupId", iGroupID);

              dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETINVOICELIST_New, param);
              return dsresult;
          }

          public DataSet USP_GenerateInvoice_GST(int iMonth, int iYear, Int16 iWareHouseId, string strXmlCustomerList, Int16 iModifiedBy)
          {
              SqlParameter[] param = new SqlParameter[5];
              param[0] = new SqlParameter("@pn_Month", iMonth);
              param[1] = new SqlParameter("@pn_Year", iYear);
              param[2] = new SqlParameter("@pn_WareHouseId", iWareHouseId);
              param[3] = new SqlParameter("@pXmlCustomerList", strXmlCustomerList);
              param[4] = new SqlParameter("@n_UserId", iModifiedBy);
              dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.USP_GenerateInvoice_GST, param);
              return dsresult;
          }

          public DataSet GetInvoice_New(int iMonth, int iYear, int iToMonth, int iToYear, int iCustomerId, int iGroupID, int WHID, int iInvoice_No)
          {
              SqlParameter[] param = new SqlParameter[8];
              param[0] = new SqlParameter("@pn_Month", iMonth);
              param[1] = new SqlParameter("@pn_Year", iYear);
              param[2] = new SqlParameter("@pn_ToMonth", iToMonth);
              param[3] = new SqlParameter("@pn_ToYear", iToYear);
              param[4] = new SqlParameter("@pn_CustomerId", iCustomerId);
              param[5] = new SqlParameter("@pn_CustGroupId", iGroupID);
              param[6] = new SqlParameter("@pn_WarehouseId", WHID);
              param[7] = new SqlParameter("@Invoice_No", iInvoice_No);
              dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETINVOICE_NEW, param);
              return dsresult;
          }
          public DataSet GetCUSTOMERSERCH(int iCustomerId)
          {
              SqlParameter[] param = new SqlParameter[1];
              param[0] = new SqlParameter("@pn_CustomerId", iCustomerId);
              dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.CUSTOMERSERCH, param);
              return dsresult;
          }
        #endregion



        #region [MakerCheker]

          public DataTable GetNoneApprovedWorkOrderNo()
          {
              dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETNONEAPPROVEDWORKORDERNOFORFILEPICKUP);
              return dsresult.Tables[0];
          }


          public DataTable GetCustmerCompanyWareHouseDataByWorkOrderNo(Int64 iWoOrderNo)
          {
              SqlParameter[] param = new SqlParameter[1];
              param[0] = new SqlParameter("@pn_WorkorderNo", iWoOrderNo);
              dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETCUSTMERCOMPANYWAREHOUSEDATABYWORKORDERNO, param);
              return dsresult.Tables[0];

          }

          public DataSet GetBoxFileDataByWorkOrderNo(Int64 iWoOrderNo)
          {
              SqlParameter[] param = new SqlParameter[1];
              param[0] = new SqlParameter("@pn_WorkorderNo", iWoOrderNo);
              dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETBOXFILEDATABYWORKORDERNO, param);
              return dsresult;

          }

          public DataSet UpdateBoxDetails(int iCustomerId, Int16 iWareHouseId, string xmlBoxDetails, Int32 iWono, Int16 iModifiedBy, Byte iIsnew)
          {
              SqlParameter[] param = new SqlParameter[6];
              param[0] = new SqlParameter("@pn_CustomerId", iCustomerId);
              param[1] = new SqlParameter("@pn_WareHouseId", iWareHouseId);
              param[2] = new SqlParameter("@ps_xmlBoxLabel", xmlBoxDetails);
              param[3] = new SqlParameter("@pn_WoNo", iWono);
              param[4] = new SqlParameter("@pn_ModifiedBy", iModifiedBy);
              param[5] = new SqlParameter("@IsNew", iIsnew);
              dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.UPDATEBOXDETAILS, param);
              return dsresult;
          }
          public DataSet UpdateFileDetails(int iCustomerId, Int16 iWareHouseId, string xmlFileLabel, Int32 iWoNo, 
               Int16 iModifiedBy,Byte iIsnew)
          {
              SqlParameter[] param = new SqlParameter[6];
              param[0] = new SqlParameter("@pn_CustomerId", iCustomerId);
              param[1] = new SqlParameter("@pn_WareHouseId", iWareHouseId);
              param[2] = new SqlParameter("@ps_xmlFileDetails", xmlFileLabel);
              param[3] = new SqlParameter("@pn_WoNo", iWoNo);
              param[4] = new SqlParameter("@pn_ModifiedBy", iModifiedBy);
              param[5] = new SqlParameter("@IsNew", iIsnew);
             
              dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.UPDATEFILEDETAILS, param);
              return dsresult;
          }

          public DataSet ApproveBoxDetails(int iCustomerId, Int16 iWareHouseId, string xmlBoxDetails, Int32 iWono, Int16 iModifiedBy, Byte iIsnew)
          {
              SqlParameter[] param = new SqlParameter[6];
              param[0] = new SqlParameter("@pn_CustomerId", iCustomerId);
              param[1] = new SqlParameter("@pn_WareHouseId", iWareHouseId);
              param[2] = new SqlParameter("@ps_xmlBoxLabel", xmlBoxDetails);
              param[3] = new SqlParameter("@pn_WoNo", iWono);
              param[4] = new SqlParameter("@pn_ModifiedBy", iModifiedBy);
              param[5] = new SqlParameter("@IsNew", iIsnew);
              dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.APPROVEBOXDETAILS, param);
              return dsresult;
          }
          public DataSet ApproveFileDetails(int iCustomerId, Int16 iWareHouseId, string xmlFileDetails, Int32 iWono, Int16 iModifiedBy, Byte iIsnew)
          {
              SqlParameter[] param = new SqlParameter[6];
              param[0] = new SqlParameter("@pn_CustomerId", iCustomerId);
              param[1] = new SqlParameter("@pn_WareHouseId", iWareHouseId);
              param[2] = new SqlParameter("@ps_xmlFileDetails", xmlFileDetails);
              param[3] = new SqlParameter("@pn_WoNo", iWono);
              param[4] = new SqlParameter("@pn_ModifiedBy", iModifiedBy);
              param[5] = new SqlParameter("@IsNew", iIsnew);
              dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.APPROVEFILEDETAILS, param);
              return dsresult;
          }


          public DataSet InsertUpdateMakerBoxDetails(int iCustomerId, Int16 iWareHouseId, string xmlBoxDetails, int iWoActivityId, Int16 iModifiedBy, Byte iIsnew)
          {
              SqlParameter[] param = new SqlParameter[6];
              param[0] = new SqlParameter("@pn_CustomerId", iCustomerId);
              param[1] = new SqlParameter("@pn_WareHouseId", iWareHouseId);
              param[2] = new SqlParameter("@ps_xmlBoxLabel", xmlBoxDetails);
              param[3] = new SqlParameter("@pn_WoActivityId", iWoActivityId);
              param[4] = new SqlParameter("@pn_ModifiedBy", iModifiedBy);
              param[5] = new SqlParameter("@IsNew", iIsnew);
              dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.INSERTUPDATEMAKERBOXDETAILS, param);
              return dsresult;
          }

          public DataSet InsertUpdateMakerFileDetails(int iCustomerId, Int16 iWareHouseId, string xmlFileLabel, int iWoActivityId, Byte iIsnew, Int16 iModifiedBy)
          {
              SqlParameter[] param = new SqlParameter[6];
              param[0] = new SqlParameter("@pn_CustomerId", iCustomerId);
              param[1] = new SqlParameter("@pn_WareHouseId", iWareHouseId);
              param[2] = new SqlParameter("@ps_xmlFileDetails", xmlFileLabel);
              param[3] = new SqlParameter("@pn_WoActivityId", iWoActivityId);
              param[4] = new SqlParameter("@IsNew", iIsnew);
              param[5] = new SqlParameter("@pn_ModifiedBy", iModifiedBy);
              dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.INSERTUPDATEMAKERFILEDETAILS, param);
              return dsresult;
          }



          public int GetPendingFreshFilePickupCountByWorkorderNo(Int32 n_WorkOrderNo)
          {
              int nPendingCount = 0;
              string strQuery = "Select "+ uspCommonConstants.GETPENDINGFILECOUNTBYWORKORDERNO+"(" + n_WorkOrderNo + ")"; 

              SqlCommand cmd = new SqlCommand();
              cmd.Connection = Conn;

              cmd.CommandText = strQuery;

              cmd.CommandType = CommandType.Text;

              if(Connection.State == ConnectionState.Closed )
              Conn.Open();

              nPendingCount = (int)cmd.ExecuteScalar();

              if (Connection.State == ConnectionState.Open)
              Conn.Close();

              return nPendingCount;
               
          }




        #endregion
        
          public DataSet GetServiceRequest_Close(int ServiceRequestNo, int iCompGroupId, int ICustomerId, int WareHouseId, int Status, DateTime? FromDate, DateTime? ToDate)
          {
              SqlParameter[] param = new SqlParameter[7];
              param[0] = new SqlParameter("@pn_ServiceRequestNo", ServiceRequestNo);
              param[1] = new SqlParameter("@pn_CGroupId", iCompGroupId);
              param[2] = new SqlParameter("@pn_CustomerId", ICustomerId);
              param[3] = new SqlParameter("@pn_WareHouseId", WareHouseId);
              param[4] = new SqlParameter("@pn_Status", Status);
              param[5] = new SqlParameter("@pd_FromDate", FromDate);
              param[6] = new SqlParameter("@pd_ToDate", ToDate);
              dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETGETSERVICEREQUESTCLOSE, param);
              return dsresult;
          }

          public DataSet UpdateServiceRequestActivityStatus(int RequestActivityId)
          {
              SqlParameter[] param = new SqlParameter[1];
              param[0] = new SqlParameter("@pn_RequestActivityId", RequestActivityId);
              dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.UPDATESERVICEREQUESTACTIVITYSTATUS, param);
              return dsresult;
          }

          public DataSet CheckFilePickupAllApproved(int WorkOrderNo, int typ)
          {
              SqlParameter[] param = new SqlParameter[2];
              param[0] = new SqlParameter("@WORKORDER", WorkOrderNo);
              param[1] = new SqlParameter("@TYPE", typ);
              dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.CHECKWORKORDERFPAPPROVEDCOUNT, param);
              return dsresult;
          }

          #region
          public DataSet getMakerSearchData(MakerSearch objMakerSearch, int Fstatus)
          {
              try
              {
                  SqlParameter[] param = new SqlParameter[16];
                  param[0] = new SqlParameter("@WareHouseId", objMakerSearch.WareHouseId);
                  param[1] = new SqlParameter("@WorkOrderNo", objMakerSearch.WorkOrderNo);
                  param[2] = new SqlParameter("@PickupAddressId", objMakerSearch.PickupAddressId);
                  param[3] = new SqlParameter("@BoxBarcode", objMakerSearch.BoxBarcode);
                  param[4] = new SqlParameter("@FileBarcode", objMakerSearch.FileBarcode);
                  param[5] = new SqlParameter("@Department", objMakerSearch.Department);
                  param[6] = new SqlParameter("@FileDesc1", objMakerSearch.FileDesc1);
                  param[7] = new SqlParameter("@FileDesc2", objMakerSearch.FileDesc2);
                  param[8] = new SqlParameter("@FileType", objMakerSearch.FileType);

                  //if (objMakerSearch.year == 0)
                  //     param[9] = new SqlParameter("@Year", "");
                  //else
                  //    param[9] = new SqlParameter("@Year", objMakerSearch.year);

                  param[9] = new SqlParameter("@Year", objMakerSearch.year);

                  if(objMakerSearch.FromDate==null)
                      param[10] = new SqlParameter("@FromDate", "");
                  else
                  param[10] = new SqlParameter("@FromDate", objMakerSearch.FromDate);

                  if (objMakerSearch.ToDate == null)
                      param[11] = new SqlParameter("@ToDate", "");
                  else
                  param[11] = new SqlParameter("@ToDate", objMakerSearch.ToDate);

                  //if (objMakerSearch.FromNum == 0)
                  //    param[12] = new SqlParameter("@FromNum", "");
                  //else
                  //    param[12] = new SqlParameter("@FromNum", objMakerSearch.FromNum);

                  //if (objMakerSearch.ToNum == 0)
                  //    param[13] = new SqlParameter("@ToNum", "");
                  //else
                  //    param[13] = new SqlParameter("@ToNum", objMakerSearch.ToNum);

                  param[12] = new SqlParameter("@FromNum", objMakerSearch.FromNum);
                  param[13] = new SqlParameter("@ToNum", objMakerSearch.ToNum);

                  if (objMakerSearch.DestructionDueDate == null)
                      param[14] = new SqlParameter("@DestructionDueDate", "");
                  else
                  param[14] = new SqlParameter("@DestructionDueDate", objMakerSearch.DestructionDueDate);
                  param[15] = new SqlParameter("@Fstatus", Fstatus);
                  dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETMAKERSEARCHDATA, param);
              }
              catch (Exception ex)
              {
                  ErrorHandler.WriteLog(ex);
              }
              return dsresult;
          }
          #endregion


        #region FilePickupUpload
          public DataSet xlImp_CheckDepartment()
          {
              SqlParameter[] param = null;
              dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, "usp_xlImp_CheckDepartment", param);
              return dsresult;
          }

          //public DataSet GetxlImp_ValidateTempData(int n_WorkOrderNo)
          //{
          //    SqlParameter[] param = new SqlParameter[1];
          //    param[0] = new SqlParameter("@n_WorkOrderNo", n_WorkOrderNo);
          //    dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.XLIMPVALIDATETEMPDATA, param);
          //    return dsresult;
          //}
          public DataSet GetCustomer_workorder(int IWareHouseId)
          {
              SqlParameter[] param = new SqlParameter[1];
              param[0] = new SqlParameter("@WareHouseId", IWareHouseId);
              dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETCUSTOMERWORKORDER, param);
              return dsresult;
          }

        #endregion FilePickupUpload


          public bool InsertUpdFileDetails(MakerSearch objMakerSearch, out int isExist,bool isNew)
          {
              bool Status = false;
              isExist = 0;
              try
              {
                  SqlParameter[] param = new SqlParameter[17];
                  param[0] = new SqlParameter("@FileId", objMakerSearch.FileId);
                  param[1] = new SqlParameter("@BoxBarcode", objMakerSearch.BoxBarcode);
                  param[2] = new SqlParameter("@FileBarcode", objMakerSearch.FileBarcode);
                  param[3] = new SqlParameter("@Department", objMakerSearch.Department);
                  param[4] = new SqlParameter("@FileDesc1", objMakerSearch.FileDesc1);
                  param[5] = new SqlParameter("@FileDesc2", objMakerSearch.FileDesc2);
                  param[6] = new SqlParameter("@FileType", objMakerSearch.FileType);
                  param[7] = new SqlParameter("@Year", objMakerSearch.year);

                  if (objMakerSearch.FromDate == null)
                      param[8] = new SqlParameter("@FromDate", "");
                  else
                      param[8] = new SqlParameter("@FromDate", objMakerSearch.FromDate);

                  if (objMakerSearch.ToDate == null)
                      param[9] = new SqlParameter("@ToDate", "");
                  else
                      param[9] = new SqlParameter("@ToDate", objMakerSearch.ToDate);

                  param[10] = new SqlParameter("@FromNum", objMakerSearch.FromNum);
                  param[11] = new SqlParameter("@ToNum", objMakerSearch.ToNum);

                  if (objMakerSearch.DestructionDueDate == null)
                      param[12] = new SqlParameter("@DestructionDueDate", "");
                  else
                      param[12] = new SqlParameter("@DestructionDueDate", objMakerSearch.DestructionDueDate);
                  param[13] = new SqlParameter("@BranchId", objMakerSearch.BranchID);
                  param[14] = new SqlParameter("@WoActivityId", objMakerSearch.WoActivityId);

                  param[15] = new SqlParameter("@isExist", isExist);
                  param[16] = new SqlParameter("@IsNew", isNew);

                  //dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETMAKERSEARCHDATA, param);
                  isExist = (int)SqlHelper.ExecuteNonQuery(Conn, CommandType.StoredProcedure, uspCommonConstants.FILEINSERTUPDATE, param);
                  if (isExist == -1)
                  {
                      Status = false;
                  }
                  else
                  Status = true;
              }
              catch (Exception ex)
              {
                  throw ex;
              }
              finally
              {
                  Conn.Close();
              }
              return Status;
          }

          public DataSet GetWoActivityId(int WorkOrderNo, int ActivityId)
          {
              SqlParameter[] param = new SqlParameter[2];
              param[0] = new SqlParameter("@WorkOrderNo", WorkOrderNo);
              param[1] = new SqlParameter("@ActivityId", ActivityId);
              dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETWOACTIVITYID, param);
              return dsresult;

              //int nWoActivityId = 0;
              //string strQuery = "Select " + uspCommonConstants.GETWOACTIVITYID + "(" + WorkOrderNo + "," + ActivityId + ")";

              //SqlCommand cmd = new SqlCommand();
              //cmd.Connection = Conn;

              //cmd.CommandText = strQuery;

              //cmd.CommandType = CommandType.Text;

              //if (Connection.State == ConnectionState.Closed)
              //    Conn.Open();

              //nWoActivityId = (int)cmd.ExecuteScalar();

              //if (Connection.State == ConnectionState.Open)
              //    Conn.Close();

              //return nWoActivityId;


          }
          public DataSet GetEmailIds()
          {
              dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETEMAILIDS);
              return dsresult;
          }

          public bool InsertUpdBoxDetails(MakerSearch objMakerSearch, out int isExist)
          {
              bool Status = false;
              isExist = 0;
              try
              {
                  SqlParameter[] param = new SqlParameter[9];
                  param[0] = new SqlParameter("@pn_CustomerId", objMakerSearch.CustId);
                  param[1] = new SqlParameter("@pn_WareHouseId", objMakerSearch.WareHouseId);                  
                  param[2] = new SqlParameter("@pn_WoActivityId", objMakerSearch.WoActivityId);
                  param[3] = new SqlParameter("@pn_ModifiedBy", objMakerSearch.ModifiedBy);
                  param[4] = new SqlParameter("@ps_BoxBarcode", objMakerSearch.BoxBarcode);
                  param[5] = new SqlParameter("@ps_BoxLocationCode", objMakerSearch.BoxLocationCode);
                  param[6] = new SqlParameter("@ps_ImageDrive", objMakerSearch.ImageDrive);                  
                  param[7] = new SqlParameter("@ps_ImageFolder", objMakerSearch.ImageFolder);
                  param[8] = new SqlParameter("@isExist", isExist);

                  //dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETMAKERSEARCHDATA, param);
                  isExist = (int)SqlHelper.ExecuteNonQuery(Conn, CommandType.StoredProcedure, uspCommonConstants.BOXINSERTUPDATE, param);
                  if (isExist == -1)
                  {
                      Status = false;
                  }
                  else
                      Status = true;
              }
              catch (Exception ex)
              {
                  throw ex;
              }
              finally
              {
                  Conn.Close();
              }
              return Status;
          }
    }
}