using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using PRSMDAL;
using Microsoft.ApplicationBlocks.Data;
namespace UserRoleWiseAcess
{
    public class UserRolewiseAcess
    {
        SqlConnection Connection;
        DataSet ds;
        public UserRolewiseAcess()
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

        public DataSet GetApplicationCodeDetails(string AppCode, string AppCodeName)
        {
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@ps_AppCode", AppCode);
            param[1] = new SqlParameter("@ps_AppCodeName", AppCodeName);
            ds = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETAPPLICATIONCODEDETAILS, param);
            return ds;
        }

        public DataSet GetPageFuncationality(int PageFunctionId, int PageId)
        {
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@pn_PageFunctionId", PageFunctionId);
            param[1] = new SqlParameter("@pn_PageId", PageId);
            ds = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETPAGEFUNCATIONALITY, param);
            return ds;
        }

        public DataSet GetDistinctPageFuncationality()
        {

            ds = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETDISTINCTPAGEFUNCATIONALITY);
            return ds;
        }

        public DataSet GetPageFunctionalityByRoleAndPageId(int PageId, int RoleId)
        {
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@pn_PageId", PageId);
            param[1] = new SqlParameter("@pn_RoleId", RoleId);
            ds = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETPAGEFUNCTIONALITYBYROLEANDPAGEID, param);
            return ds;
        }

        public DataSet GetRolewiseAcess(int RoleId)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@pn_RoleId", RoleId);
            ds = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETROLEWISEACESS, param);
            return ds;
        }

        public DataSet GetMenu(int RoleId)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@pn_RoleId", RoleId);
            ds = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETMENU, param);
            return ds;
        }

        public string InsertUpdatePageFunctionality(int PageFunctionId, int PageId, string Functionality, byte b_Enable)
        {
            SqlParameter[] param = new SqlParameter[4];
            param[0] = new SqlParameter("@pn_PageFunctionId", PageFunctionId);
            param[1] = new SqlParameter("@pn_PageId", PageId);
            param[2] = new SqlParameter("@ps_Functionality", Functionality);
            param[3] = new SqlParameter("@pb_Enable", b_Enable);
            ds = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETPAGEFUNCATIONALITY, param);
            if (ds.Tables.Count == 0)
                return "Record saved successfully.";
            else
            {
                return "Error in record saving";
            }
        }

        public string InsertUpdateRoleWiseAccess(int RoleId, string XmlRolewiseAcess)
        {
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@pn_RoleId", RoleId);
            param[1] = new SqlParameter("@ps_XmlRolewiseAcess", XmlRolewiseAcess);
            ds = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.INSERTUPDATEROLEWISEACCESS, param);
            if (ds.Tables.Count == 0)
                return "Record saved successfully.";
            else
            {
                return "Error in record saving";
            }
        }
    }
}
