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
    public class ReportDAL
    {
        SqlConnection Connection;
        DataSet dsresult;
        public ReportDAL()
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
        public DataSet GetFilePickUpSummary(FilePickUpReport ObjFilePickup)
        {
            SqlParameter[] param = new SqlParameter[4];
            param[0] = new SqlParameter("@pn_CustomerId", ObjFilePickup.CustomerId);
            param[1] = new SqlParameter("@pd_FromDate", ObjFilePickup.FromDate);
            param[2] = new SqlParameter("@pd_ToDate", ObjFilePickup.ToDate);
            param[3] = new SqlParameter("@pn_ClientOrDept", ObjFilePickup.ClientOrDept);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETFILEPICKUPREPORTSUMMARY, param);
            return dsresult;
        }      

        public DataSet GetFilePickUpDetails(FilePickUpReport ObjFilePickup)
        {
            SqlParameter[] param = new SqlParameter[4];
            param[0] = new SqlParameter("@pn_CustomerId", ObjFilePickup.CustomerId);
            param[1] = new SqlParameter("@Pn_DeptId", ObjFilePickup.DepartmentId);
            param[2] = new SqlParameter("@pd_FromDate", ObjFilePickup.FromDate);
            param[3] = new SqlParameter("@pd_ToDate", ObjFilePickup.ToDate);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETFILEPICKUPDETAILSREPORT, param);
            return dsresult;
        }

        public DataSet GetClientWiseFileDetails(ClientWiseFileDetailsReport ObjClientWieseFileDet)
        {
            SqlParameter[] param = new SqlParameter[4];
            param[0] = new SqlParameter("@pn_CustomerId", ObjClientWieseFileDet.CustomerId);
            param[1] = new SqlParameter("@pn_Month", ObjClientWieseFileDet.Month);
            param[2] = new SqlParameter("@pn_Year", ObjClientWieseFileDet.year);
            param[3] = new SqlParameter("@ps_WorkOrderNos", ObjClientWieseFileDet.WorkOrderNo);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETCLIENTWISEFILEDET, param);
            return dsresult;
        }

        public DataSet GetClientWiseInventoryReport(ClientWiseInventoryReport ObjClientInventory)
        {
            SqlParameter[] param = new SqlParameter[5];
            param[0] = new SqlParameter("@pn_WareHouseId", ObjClientInventory.WareHouseId);
            param[1] = new SqlParameter("@pn_CustomerId", ObjClientInventory.CustomerId);
            param[2] = new SqlParameter("@pn_CompanyGroupId", ObjClientInventory.CompanyGroupId);
            param[3] = new SqlParameter("@pd_FromDate", ObjClientInventory.FromDate);
            param[4] = new SqlParameter("@pd_EndDate", ObjClientInventory.ToDate);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETCLIENTWISEINVENTORY, param);
            return dsresult;
        }

        public DataSet GetFileRetrievalRestoreSummary(FilePickUpReport ObjFilePickup)
        {
            SqlParameter[] param = new SqlParameter[3];
            //param[0] = new SqlParameter("@pn_CGroupId", ObjFilePickup.CompanyGroupId);
            param[0] = new SqlParameter("@pn_CustomerId", ObjFilePickup.CustomerId);
            //param[1] = new SqlParameter("@Pn_DeptId", ObjFilePickup.DepartmentId);
            param[1] = new SqlParameter("@pd_FromDate", ObjFilePickup.FromDate);
            param[2] = new SqlParameter("@pd_ToDate", ObjFilePickup.ToDate);

            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure,
                uspCommonConstants.GETFILERETRIEVALRESTOREREPORTSUMMARY, param);
            return dsresult;
        }

        public DataSet GetFileRetrievalRestoreDetails(FilePickUpReport ObjFilePickup)
        {
            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@pn_CustomerId", ObjFilePickup.CustomerId);
            //param[1] = new SqlParameter("@Pn_DeptId", ObjFilePickup.DepartmentId);
            param[1] = new SqlParameter("@pd_FromDate", ObjFilePickup.FromDate);
            param[2] = new SqlParameter("@pd_ToDate", ObjFilePickup.ToDate);

            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETFILERETRIEVALRESTOREDETAILSREPORT, param);
            return dsresult;
        }
        public DataSet GetInventoryDataAsOnDate(InventryReportAsOnDate ObjInvReport)
        {
            SqlParameter[] param = new SqlParameter[6];

            param[0] = new SqlParameter("@pn_ReportType", ObjInvReport.Report_type);
            param[1] = new SqlParameter("@n_WareHouseId", ObjInvReport.WareHouseId);
            param[2] = new SqlParameter("@n_Year", ObjInvReport.Year);
            param[3] = new SqlParameter("@pn_CustomerId", ObjInvReport.CustomerID);
            param[4] = new SqlParameter("@pd_FromDate", ObjInvReport.FromDate);
            param[5] = new SqlParameter("@pd_ToDate", ObjInvReport.ToDate);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETINVENTORYRPORTASONDATE, param);
            return dsresult;
        }

        public DataSet GetWareHouseName()
        {
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETTOPONEWAREHOUSE);
            return dsresult;
        }

        public DataSet GetOtherServicesReport(OtherServicesReport ObjOtherServices)
        {
            SqlParameter[] param = new SqlParameter[5];
            param[0] = new SqlParameter("@pn_WoActivityId", ObjOtherServices.ActivityId);
            param[1] = new SqlParameter("@pn_CustomerId", ObjOtherServices.CustomerId);
            param[2] = new SqlParameter("@pd_FromDate", ObjOtherServices.FromDate);
            param[3] = new SqlParameter("@pd_ToDate", ObjOtherServices.ToDate);
            param[4] = new SqlParameter("@pb_IsSummary", ObjOtherServices.IsSummary);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETOTHERSERVIESREPORT, param);
            return dsresult;
        }

        public DataSet GetServiceCompletionSummary(Int16 WarHouseId, int CompanyGroupId, int CustomerId,DateTime? FromDate, DateTime? ToDate)
        {
            SqlParameter[] param = new SqlParameter[5];
            param[0] = new SqlParameter("@pn_WareHouseId", WarHouseId);
            param[1] = new SqlParameter("@pn_CGroupId", CompanyGroupId);
            param[2] = new SqlParameter("@pn_CustomerId", CustomerId);
            param[3] = new SqlParameter("@pd_FromDate", FromDate);
            param[4] = new SqlParameter("@pd_ToDate", ToDate);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETSERVICECOMPLETIONSUMMARY, param);
            return dsresult;
        }


        public DataSet GetSrvcCompletionReport(Int16 WarHouseId, int CompanyGroupId, int CustomerId, int iWorkOrderNo, DateTime? FromDate, DateTime? ToDate)
        {
            SqlParameter[] param = new SqlParameter[6];
            param[0] = new SqlParameter("@pn_WareHouseId", WarHouseId);
            param[1] = new SqlParameter("@pn_CGroupId", CompanyGroupId);
            param[2] = new SqlParameter("@pn_CustomerId", CustomerId);
            param[3] = new SqlParameter("@Pn_WorkOrderNo", iWorkOrderNo);
            param[4] = new SqlParameter("@pd_FromDate", FromDate);
            param[5] = new SqlParameter("@pd_ToDate", ToDate);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETSERVICECOMPLETIONREPORT, param);
            return dsresult;
        }
        public DataSet GetInvYearWiseBoxFileDetails(string ReportType, int CustomerId, int Year)
        {
            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@ps_ReportType", ReportType);
            param[1] = new SqlParameter("@pn_CustomerId", CustomerId);
            param[2] = new SqlParameter("@pn_Year", Year);


            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETYEARWISEBOXFILEDETAILS, param);
            return dsresult;
        }
        public DataSet GetResRetDetails(int intCustomerId, string strCommandType, int intWorkOrderNo)
        {
            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@n_CustomerId", intCustomerId);
            param[1] = new SqlParameter("@strCommandType", strCommandType);
            param[2] = new SqlParameter("@intWoNo", intWorkOrderNo);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETRESTORERETRIEVALDETAILS, param);
            return dsresult;
        }

    }
}
