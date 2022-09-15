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
    public class MasterDAL
    {
        SqlConnection Connection;
        DataSet dsresult;
        public MasterDAL()
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

        #region [Application Code]
        public DataSet GetApplicationCodeDetails(string AppCode, string AppCodeName)
        {
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@ps_AppCode", AppCode);
            param[1] = new SqlParameter("@ps_AppCodeName", AppCodeName);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETAPPLICATIONCODEDETAILS, param);
            return dsresult;
        }

        public DataSet GetState(Int16 CountryId)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@pn_CountryId", CountryId);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETSTATE, param);
            return dsresult;
        }
        public DataSet GetCity(int StateId)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@pn_StateId", StateId);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETCITY, param);
            return dsresult;
        }
        #endregion
        #region [Service Category]
        public List<ServiceCategory> GetServiceCategory(byte bServiceCategoryId)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@pn_ServiceCategoryId", bServiceCategoryId);
            List<ServiceCategory> lstCategory = new List<ServiceCategory>();
            SqlDataReader dr;
            dr = SqlHelper.ExecuteReader(Conn, CommandType.StoredProcedure, uspCommonConstants.GETSERVICECATEGORY, param);
            if (dr != null)
            {
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        lstCategory.Add(new ServiceCategory
                        {
                            SCName = Convert.ToString(dr["SCName"]),
                            ServiceCategoryId = Convert.ToInt16(dr["ServiceCategoryId"]),
                            Remark = Convert.ToString(dr["Remark"]),
                            IsEdit = Convert.ToByte(dr["IsEdit"]),
                            DisplayOrder = Convert.ToInt16(dr["DisplayOrder"])
                        });
                    }
                }
                dr.Close();
                dr.Dispose();
            }
            return lstCategory;
        }
        public DataSet  GetServiceCategoryById(byte bServiceCategoryId)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@pn_ServiceCategoryId", bServiceCategoryId);
            List<ServiceCategory> lstCategory = new List<ServiceCategory>();

            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETSERVICECATEGORY, param);
            return dsresult;
        }

        public string AddUpdateServiceCategory(ServiceCategory ObjServiceCategory)
        {
            SqlParameter[] param = new SqlParameter[5];

            param[0] = new SqlParameter("@pn_ServiceCategoryId", ObjServiceCategory.ServiceCategoryId);
            param[1] = new SqlParameter("@ps_SCName", ObjServiceCategory.SCName);
            param[2] = new SqlParameter("@ps_Remark", ObjServiceCategory.Remark);
            param[3] = new SqlParameter("@pb_IsEdit", ObjServiceCategory.IsEdit );
            param[4] = new SqlParameter("@pn_UserId", ObjServiceCategory.UserId);

            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.ADDUPDATESERVICECATEGORY, param);

            if (dsresult.Tables.Count == 0)
            {
                return "Record saved successfully.";
            }
            else
            {
                ErrorHandler.WriteLog(dsresult);
                return dsresult.Tables[0].Rows[0][5].ToString();
            }
        }
        #endregion
               #region [Activity]
        public List<Activity> GetActivity(int iActivityId)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@pn_ActivityId", iActivityId);
            List<Activity> lstActivity = new List<Activity>();
            SqlDataReader dr;
            dr = SqlHelper.ExecuteReader(Conn, CommandType.StoredProcedure, uspCommonConstants.GETACTIVITY, param);
            if (dr != null)
            {
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        lstActivity.Add(new Activity
                        {
                            ActivityId = Convert.ToInt32(dr["ActivityId"]),
                            ActivityName = Convert.ToString(dr["ActivityName"]),
                            SCName = Convert.ToString(dr["SCName"]),
                            ServiceCategoryId = Convert.ToInt16(dr["ServiceCategoryId"]),
                            Remark = Convert.ToString(dr["Remark"]),
                            IsEdit = Convert.ToByte(dr["IsEdit"]),
                            Unit   =Convert.ToInt32(dr["Unit"]),
                            UnitCount=Convert.ToInt32(dr["UnitCount"]),
                            IsShowinRateCard = Convert.ToByte(dr["ShowinRateCard"])
                        });
                    }
                }
                dr.Close();
                dr.Dispose();
            }
            return lstActivity;

        }


        public string AddUpdateActivity(Activity ObjActivity)
        {
            SqlParameter[] param = new SqlParameter[9];

            param[0] = new SqlParameter("@pn_ActivityId", ObjActivity.ActivityId);
            param[1] = new SqlParameter("@pn_ServiceCategoryId", ObjActivity.ServiceCategoryId);
            param[2] = new SqlParameter("@ps_ActivityName", ObjActivity.ActivityName);
            param[3] = new SqlParameter("@ps_Remark", ObjActivity.Remark);
            param[4] = new SqlParameter("@pb_IsEdit", ObjActivity.IsEdit);
            param[5] = new SqlParameter("@pn_UserId", ObjActivity.UserId);
            param[6] = new SqlParameter("@pn_Unit", ObjActivity.Unit);
            param[7] = new SqlParameter("@pn_UnitCount", ObjActivity.UnitCount);
            param[8] = new SqlParameter("@pb_IsShowinRateCard", ObjActivity.IsShowinRateCard);

            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.ADDUPDATEACTIVITY, param);

            if (dsresult.Tables.Count == 0)
            {
                return "Record saved successfully.";
            }
            else
            {
                ErrorHandler.WriteLog(dsresult);
                return dsresult.Tables[0].Rows[0][5].ToString();
            }
        }

        public DataSet GetActivitybyCategory(int iServiceCategoryId)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@pn_ServiceCategoryId", iServiceCategoryId);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETACTIVITYBYCATEGORY, param);
            return dsresult;
        }

       #endregion
        #region [Company Group]
        public DataSet GetCompanyGroup(int ICompanyGroupId)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@pn_CompanyGroupId", ICompanyGroupId);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETCOMPANYGROUP, param);
            return dsresult;
        }


        public Int16 AddUpdateCompanyGroup(CompanyGroup objCompanyGroup)
        {
            Int16 IsCGExist = 0;
            try
            {

                SqlParameter[] param = new SqlParameter[27];
                param[0] = new SqlParameter("@pn_CompanyGroupId", objCompanyGroup.CompanyGroupId);
                param[1] = new SqlParameter("@ps_CGName", objCompanyGroup.CGName);
                param[2] = new SqlParameter("@pn_IndustryId", objCompanyGroup.IndustryId);
                param[3] = new SqlParameter("@ps_RegisterAddress", objCompanyGroup.RegisterAddress);
                param[4] = new SqlParameter("@pn_StateId", objCompanyGroup.StateId);
                param[5] = new SqlParameter("@pn_CityId", objCompanyGroup.CityId);
                param[6] = new SqlParameter("@ps_PinCode", objCompanyGroup.PinCode);
                param[7] = new SqlParameter("@ps_CorpAddress", objCompanyGroup.CorporateAddress);
                param[8] = new SqlParameter("@pn_CorpStateId", objCompanyGroup.CorporateStateId);
                param[9] = new SqlParameter("@pn_CorpCityId", objCompanyGroup.CorporateCityId);
                param[10] = new SqlParameter("@ps_CorpPinCode", objCompanyGroup.CorporatePinCode);
                param[11] = new SqlParameter("@ps_PANNumber", objCompanyGroup.PANNumber);
                param[12] = new SqlParameter("@ps_TANNumber", objCompanyGroup.TANNumber);
                param[13] = new SqlParameter("@ps_ContactPerson", objCompanyGroup.ContactPerson);
                param[14] = new SqlParameter("@ps_PhoneNumber", objCompanyGroup.PhoneNumber);
                param[15] = new SqlParameter("@ps_MobileNumber", objCompanyGroup.MobileNumber);
                param[16] = new SqlParameter("@ps_Email", objCompanyGroup.Email);
                param[17] = new SqlParameter("@ps_ContactPerson1", objCompanyGroup.ContactPerson1);
                param[18] = new SqlParameter("@ps_PhoneNumber1", objCompanyGroup.PhoneNumber1);
                param[19] = new SqlParameter("@ps_MobileNumber1", objCompanyGroup.MobileNumber1);
                param[20] = new SqlParameter("@ps_Email1", objCompanyGroup.Email1);
                param[21] = new SqlParameter("@pn_UserId", objCompanyGroup.UserId);
                param[22] = new SqlParameter("@pn_IsCGNameExist", SqlDbType.SmallInt);
                param[22].Direction = ParameterDirection.Output;
                param[22].Value = 0;
                param[23] = new SqlParameter("@ps_RegAddress1", objCompanyGroup.RegAddress1);
                param[24] = new SqlParameter("@ps_RegAddress2", objCompanyGroup.RegAddress2);
                param[25] = new SqlParameter("@ps_CorpAddress1", objCompanyGroup.CorpAddress1);
                param[26] = new SqlParameter("@ps_CorpAddress2", objCompanyGroup.CorpAddress2);

                SqlHelper.ExecuteNonQuery(Conn, CommandType.StoredProcedure, uspCommonConstants.INSERTUPDATECOMPANYGROUP, param);
                IsCGExist = Convert.ToInt16(param[22].Value);

            }
            catch (Exception ex)
            {
                ErrorHandler.WriteLog(ex);
            }
            return IsCGExist;
        }
        #endregion
        #region [Company Master]
        public DataSet GetCompanyMaster(int ICompanyMasterId)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@pn_CompanyMasterId", ICompanyMasterId);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETCOMPANYMASTER, param);
            return dsresult;
        }
        public Int16 AddUpdateCompanyMaster(CompanyMaster objCompanyMaster)
        {
            Int16 IsCGExist = 0;
            try
            {

                SqlParameter[] param = new SqlParameter[24];
                param[0] = new SqlParameter("@pn_CompanyMasterId", objCompanyMaster.CompanyMasterId);
                param[1] = new SqlParameter("@ps_CMName", objCompanyMaster.CMName);
                param[2] = new SqlParameter("@pn_IndustryId", objCompanyMaster.IndustryId);
                param[3] = new SqlParameter("@ps_RegisterAddress", objCompanyMaster.RegisterAddress);
                param[4] = new SqlParameter("@pn_StateId", objCompanyMaster.StateId);
                param[5] = new SqlParameter("@pn_CityId", objCompanyMaster.CityId);
                param[6] = new SqlParameter("@ps_PinCode", objCompanyMaster.PinCode);
                param[7] = new SqlParameter("@ps_Email", objCompanyMaster.Email);
                param[8] = new SqlParameter("@ps_Telephone", objCompanyMaster.Phone);
                param[9] = new SqlParameter("@ps_Fax", objCompanyMaster.Fax);
                param[10] = new SqlParameter("@ps_CorpAddress", objCompanyMaster.CorporateAddress);
                param[11] = new SqlParameter("@pn_CorpStateId", objCompanyMaster.CorporateStateId);
                param[12] = new SqlParameter("@pn_CorpCityId", objCompanyMaster.CorporateCityId);
                param[13] = new SqlParameter("@ps_CorpPinCode", objCompanyMaster.CorporatePinCode);
                param[14] = new SqlParameter("@ps_CorpEmail", objCompanyMaster.CorporateEmail);
                param[15] = new SqlParameter("@ps_CorpTelephone", objCompanyMaster.CorporatePhone);
                param[16] = new SqlParameter("@ps_CorpFax", objCompanyMaster.CorporateFax);
                param[17] = new SqlParameter("@ps_PANNumber", objCompanyMaster.PANNumber);
                param[18] = new SqlParameter("@ps_TANNumber", objCompanyMaster.TANNumber);
                param[19] = new SqlParameter("@ps_CINNumber", objCompanyMaster.CINNumber);
                param[20] = new SqlParameter("@ps_VATNumber", objCompanyMaster.VATNumber);
                param[21] = new SqlParameter("@ps_SalesTaxNo", objCompanyMaster.SALESTaxNumber);  
                param[22] = new SqlParameter("@pn_UserId", objCompanyMaster.UserId);
                param[23] = new SqlParameter("@pn_IsCGNameExist", SqlDbType.SmallInt);
                param[23].Direction = ParameterDirection.Output;
                param[23].Value = 0;
                SqlHelper.ExecuteNonQuery(Conn, CommandType.StoredProcedure, uspCommonConstants.INSERTUPDATECOMPANYMASTER, param);
                IsCGExist = Convert.ToInt16(param[23].Value);

            }
            catch (Exception ex)
            {
                ErrorHandler.WriteLog(ex);
            }
            return IsCGExist;
        }

        #endregion
        #region ["User Master"]
        public string InsertUpdateUserDetails(UserMaster objUser)
        {
            SqlParameter[] param = new SqlParameter[12];
            param[0] = new SqlParameter("@pn_UserId", objUser.UserId);
            param[1] = new SqlParameter("@ps_FirstName", objUser.FirstName);
            param[2] = new SqlParameter("@ps_MiddleName", objUser.MiddleName);
            param[3] = new SqlParameter("@ps_LastName", objUser.LastName);
            param[4] = new SqlParameter("@pd_BirthDate", objUser.BirthDate);
            param[5] = new SqlParameter("@pn_Department", objUser.Department);
            param[6] = new SqlParameter("@ps_UserName", objUser.UserName);
            param[7] = new SqlParameter("@ps_EmailId", objUser.EmailId);
            param[8] = new SqlParameter("@ps_Password", objUser.Password);
            param[9] = new SqlParameter("@pb_LoginStatus", objUser.LoginStatus);
            param[10] = new SqlParameter("@pn_IsActive", objUser.IsActive);
            param[11] = new SqlParameter("@pn_UserRole", objUser.UserRole);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.INSERTUPDATEUSERDETAILS, param);
            if (dsresult.Tables.Count == 0)
                return "Record saved successfully.";
            else
            {
                ErrorHandler.WriteLog(dsresult);
                return "Error while saving a record. Please try again.";
            }

        }

        public DataSet GetUserDetails(int UserId)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@pn_UserId", UserId);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETUSERDETAILS, param);
            return dsresult;
        }

        public DataSet GetUserDetailsByUserName(string UseName, string Password)
        {
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@ps_UserName", UseName);
            param[1] = new SqlParameter("@ps_Password", Password);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETUSERDETAILSBYUSERNAME, param);
            return dsresult;
        }

        public Int16 IsUserNameExist(int nUserId, string strUserName)
        {
            Int16 Result = 0;
            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@pn_UserId", nUserId);
            param[1] = new SqlParameter("@ps_UserName", strUserName);
            param[2] = new SqlParameter("@pn_ReturnValue", SqlDbType.SmallInt);
            param[2].Direction = ParameterDirection.Output;
            try
            {
                SqlHelper.ExecuteNonQuery(Conn, CommandType.StoredProcedure, uspCommonConstants.ISUSERNAMEEXIST, param);
                Result = Convert.ToInt16(param[2].Value.ToString());
            }
            catch (SqlException ex)
            {
                ErrorHandler.WriteLog(ex);
                Result = 3;
            }
            return Result;
        }
        #endregion
        #region [RateCard]
        public DataSet GetCustomer(int ICompanyGroupId)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@pn_CompanyGroupId", ICompanyGroupId);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETCUSTOMER, param);
            return dsresult;
        }

        public DataSet GetRateCard(int ICustomerId, int IActivityId)
        {
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@pn_CustomerId", ICustomerId);
            param[1] = new SqlParameter("@pn_ActivityId", IActivityId);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETRATECARD, param);
            return dsresult;
        }

        public string InsertUpdateRateCard(RateCard objRate)
        {
            SqlParameter[] param = new SqlParameter[7];
            param[0] = new SqlParameter("@pn_RateCardId", objRate.RateCardId);
            param[1] = new SqlParameter("@pn_CustomerId", objRate.CustomerId);
            param[2] = new SqlParameter("@pn_ActivityId", objRate.ActivityId);
            param[3] = new SqlParameter("@pn_Rate", objRate.Rate);
            param[4] = new SqlParameter("@pn_UserId", objRate.UserId);
            param[5] = new SqlParameter("@d_FromDate", objRate.FromDate);
            param[6] = new SqlParameter("@d_Todate", objRate.Todate);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.INSERTUPDATERATECARD, param);
            if (dsresult.Tables.Count == 0)
                return "Record saved successfully.";
            else
            {
                ErrorHandler.WriteLog(dsresult);
                return "Error while saving a record. Please try again.";
            }
        }
        #endregion
        #region [Customer]
        public int AddUpdateCustomer(Customer objCustomer)
        {
            int Result = 0;
            try
            {
                SqlParameter[] param = new SqlParameter[12];
                param[0] = new SqlParameter("@pn_CustomerId", objCustomer.CustomerId);
                param[1] = new SqlParameter("@ps_CustomerName", objCustomer.CustomerName);
                param[2] = new SqlParameter("@pn_CompanyGroupId", objCustomer.CompanyGroupId);
                param[3] = new SqlParameter("@ps_BillingAddress", objCustomer.BillingAddress);
                param[4] = new SqlParameter("@pn_StateId", objCustomer.StateId);
                param[5] = new SqlParameter("@pn_CityId", objCustomer.CityId);
                param[6] = new SqlParameter("@pn_UserId", objCustomer.UserId);
                param[7] = new SqlParameter("@ps_PinCode", objCustomer.CustPinCode);
                param[8] = new SqlParameter("@ps_BillingAddress1", objCustomer.BillingAddress1);
                param[9] = new SqlParameter("@ps_BillingAddress2", objCustomer.BillingAddress2);
                param[10] = new SqlParameter("@pn_BillingMode", objCustomer.BillingMode);
                param[11] = new SqlParameter("@pn_MaxCustId", SqlDbType.Int);
                param[11].Direction = ParameterDirection.Output;
                param[11].Value = 0;
                SqlHelper.ExecuteNonQuery(Conn, CommandType.StoredProcedure, uspCommonConstants.ADDUPDATECUSTOMER, param);
                Result = Convert.ToInt32(param[11].Value);
            }
            catch (SqlException ex)
            {
                ErrorHandler.WriteLog(ex);
            }
            return Result;
        }
        public string AddUpdatePickupAddress(string strxmlPickupAddress, int iCustomerId)
        {
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@ps_xmlPickupAddress", strxmlPickupAddress);
            param[1] = new SqlParameter("@pn_CustomerId"     ,  iCustomerId);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.ADDUPDATEPICKUPADDRESS, param);
            if (dsresult.Tables.Count == 0)
            {
                return "Record saved successfully.";
            }
            else
            {
                ErrorHandler.WriteLog(dsresult);
                return "Error in saving";
            }
        }
        public DataSet GetCustomerByWarehouseId(int iCustomerId)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@n_WareHouseId", iCustomerId);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETCUSTOMERBYWAREHOUSEID, param);
            return dsresult;
        }
        public DataSet GetCustomerByCustomerId(int iCustomerId)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@pn_CustomerId", iCustomerId);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETCUSTOMERBYCUSTOMERID, param);
            return dsresult;
        }
        public DataSet GetCOMPANYNAMEBYWHID(int iWHID)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@n_WareHouseId", iWHID);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETCOMPANYNAMEBYWHID, param);
            return dsresult;
        }
        public DataSet GetPickUpAddress(int iCustomerId)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@pn_CustomerId", iCustomerId);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETCUSTOMERPICKUPADDRESS, param);
            return dsresult;
        }
        
        public DataSet GetPickUpAddressOnWO(int WorkOrderNo)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@WorkOrderNo", WorkOrderNo);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETPICKUPADDRESSOnWO, param);
            return dsresult;
        }


        public DataSet GetAuthorisedPerson(int iPickupAddressId)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@n_PickupAddressId", iPickupAddressId);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETAUTHORISEDPERSON, param);
            return dsresult;
        }
        #endregion
        #region [CityMaster]
        public string AddUpdateCityMaster(City objCityMaster)
        {
            SqlParameter[] param = new SqlParameter[4];
            param[0] = new SqlParameter("@pn_CityId", objCityMaster.CityId);
            param[1] = new SqlParameter("@ps_CityName", objCityMaster.CityName);
            param[2] = new SqlParameter("@pn_StateId", objCityMaster.StateId);
            param[3] = new SqlParameter("@pn_UserId", objCityMaster.UserId);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.INSERTUPDATECITYMASTER, param);
            if (dsresult.Tables.Count == 0)
            {
                return "Record saved successfully.";
            }
            else
            {
                ErrorHandler.WriteLog(dsresult);
                return dsresult.Tables[0].Rows[0][5].ToString();
            }
        }
        #endregion
        #region [WareHouse]
        public DataSet GetWareHouse(int IWareHouseId)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@pn_WareHouseId", IWareHouseId);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETWAREHOUSE, param);
            return dsresult;
        }
        public int AddUpdateWareHouseMaster(WareHouse objWareHouse)
        {
            int Result = 0;
            try
            {
                SqlParameter[] param = new SqlParameter[11];
                param[0] = new SqlParameter("@pn_WareHouseId", objWareHouse.WareHouseId);
                param[1] = new SqlParameter("@ps_WarehouseName", objWareHouse.WarehouseName);
                param[2] = new SqlParameter("@ps_WarehouseCode", objWareHouse.WarehouseCode);
                param[3] = new SqlParameter("@pn_TotalRows", objWareHouse.TotalRows);
                param[4] = new SqlParameter("@ps_Address", objWareHouse.Address);
                param[5] = new SqlParameter("@pn_StateId", objWareHouse.StateId);
                param[6] = new SqlParameter("@pn_CityId", objWareHouse.CityId);
                param[7] = new SqlParameter("@pn_UserId", objWareHouse.UserId);
                param[8] = new SqlParameter("@pn_IsWareHouseExist", SqlDbType.Int);
                param[8].Direction = ParameterDirection.Output;
                param[8].Value = 0;
                param[9] = new SqlParameter("@ps_Address1", objWareHouse.Address1);
                param[10] = new SqlParameter("@ps_Address2", objWareHouse.Address2);
                dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.INSERTUPDATEWAREHOUSEMASTER, param);
                if (param[8].Value != null && param[8].Value.ToString().Trim() != "")
                    Result = Convert.ToInt32(param[8].Value);
            }
            catch (SqlException ex)
            {
                ErrorHandler.WriteLog(ex);
            }
            return Result;
        }
        public DataSet GetRackMasterByWareHouseId(Int16 iWareHouseId)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@pn_WareHouseId", iWareHouseId);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETRACKMASTERBYWAREHOUSEID, param);
            return dsresult;
        }
        #endregion
        #region [Rack Master]
        public DataSet GetRackMaster(Int16 iRackId)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@pn_RackId", iRackId);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETRACKMASTER, param);
            return dsresult;
        }
       
        public int AddUpdateRackMaster(RackMaster objRackMaster)
        {
            int Result = 0;
            try
            {
                SqlParameter[] param = new SqlParameter[15];
                param[0] = new SqlParameter("@pn_RackId", objRackMaster.RackId);
                param[1] = new SqlParameter("@ps_RowName", objRackMaster.RowName);
                param[2] = new SqlParameter("@pn_WareHouseId", objRackMaster.WareHouseId);
                param[3] = new SqlParameter("@pn_NoofShelf", objRackMaster.NoOfShelf);
                param[4] = new SqlParameter("@pn_NoofBoxesPerShelf", objRackMaster.NoOfBoxePerShelf);
                param[5] = new SqlParameter("@pn_BoxStartNo", objRackMaster.BoxStartNo);
                param[6] = new SqlParameter("@ps_Remark", objRackMaster.Remark);
                param[7] = new SqlParameter("@pn_Height", objRackMaster.Height);
                param[8] = new SqlParameter("@pn_Width", objRackMaster.Width);
                param[9] = new SqlParameter("@pn_Depth", objRackMaster.Depth);
                param[10] = new SqlParameter("@pn_UserId", objRackMaster.UserId);
                param[11] = new SqlParameter("@pn_NoofRacks", objRackMaster.NoofRacks);
                param[12] = new SqlParameter("@pn_IsRackExist", SqlDbType.Int);
                param[12].Direction = ParameterDirection.Output;
                param[12].Value = 0;
                param[13] = new SqlParameter("@pn_BoxEndNo", objRackMaster.BoxEndNo);
                param[14] = new SqlParameter("@pn_RowId", objRackMaster.RowId);
                dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.ADDUPDATERACKMASTER, param);
                if (param[12].Value != null && param[12].Value.ToString().Trim() != "")
                    Result = Convert.ToInt32(param[12].Value);
            }
            catch (Exception ex)
            {
                ErrorHandler.WriteLog(ex);
            }
            return Result;
        }
        public DataSet GetMaxWarehouseRowNumberAndBoxStartNo(Int16 iWareHouseId)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@pn_WareHouseId", iWareHouseId);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETWAREHOUSEMAXROWIDANDBOXSTARTNO, param);
            return dsresult;
        }
        #endregion
        #region [Contract Master]
        public string AddUpdateContractMaster(ContractMaster objContractMaster)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[9];
                param[0] = new SqlParameter("@pn_ContractId", objContractMaster.ContractId);
                param[1] = new SqlParameter("@pn_ContractNo", objContractMaster.ContractNo);
                param[2] = new SqlParameter("@pn_CustomerId", objContractMaster.CustomerId);
                param[3] = new SqlParameter("@pd_FromDate", objContractMaster.FromDate);
                param[4] = new SqlParameter("@pd_EndDate", objContractMaster.EndDate);
                param[5] = new SqlParameter("@ps_Remark", objContractMaster.Remark);
                param[6] = new SqlParameter("@ps_DocumentName", objContractMaster.DocumentName);
                param[7] = new SqlParameter("@ps_Filepath", objContractMaster.Filepath);
                param[8] = new SqlParameter("@pn_UserId", objContractMaster.UserId);
                dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.INSERTUPDATECONTRACTMASTER, param);
                if (dsresult.Tables.Count == 0)
                    return "Record saved successfully.";
                else
                {
                    ErrorHandler.WriteLog(dsresult);
                    return "Error while saving a record. Please try again.";
                }
            }
            catch (Exception ex)
            {
                ErrorHandler.WriteLog(ex);
                return "Error while saving a record. Please try again.";
            }
        }

        public DataSet GetContract(int ContractId)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@pn_ContractId", ContractId);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETCONTRACT, param);
            return dsresult;
        }
        public DataSet GetContractOnCustomer(int ICustomerId)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@pn_CustomerId", ICustomerId);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETCONTRACTONCUSTOMER, param);
            return dsresult;
        }
        public string InsertUpdateDocument(Document objDocument)
        {
            SqlParameter[] param = new SqlParameter[5];
            param[0] = new SqlParameter("@pn_DocumentId", objDocument.DocumentId);
            param[1] = new SqlParameter("@pn_ContractId", objDocument.ContractId);
            param[2] = new SqlParameter("@ps_DocumentName", objDocument.DocumentName);
            param[3] = new SqlParameter("@ps_Filepath", objDocument.Filepath);
            param[4] = new SqlParameter("@pn_UserId", objDocument.UserId);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.INSERTUPDATEDOCUMENT, param);
            if (dsresult.Tables.Count == 0)
                return "Record saved successfully.";
            else
            {
                ErrorHandler.WriteLog(dsresult);
                return "Error while saving a record. Please try again.";
            }
        }
        public DataSet GetDocument(int ContractId)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@pn_ContractId", ContractId);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETDOCUMENT, param);
            return dsresult;
        }
        public int DeleteDocument(int DocumentId)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@pn_DocumentId", DocumentId);
            return SqlHelper.ExecuteNonQuery(Conn, CommandType.StoredProcedure, uspCommonConstants.DELETEDOCUMENT, param);
        }

        public DataSet GetContractNumber()
        {
            try
            {
                SqlParameter[] param = new SqlParameter[0];
                dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETCONTRACTNUMBER, param);
            }
            catch (Exception ex)
            {
                ErrorHandler.WriteLog(ex);
            }
            return dsresult;
        }
        #endregion
        #region [Box Location]
        public DataSet GetBoxLocation(int iWareHouseId, string BoxLocationCode, int iCustomerId, int iCompanyGroupId)
        {
            SqlParameter[] param = new SqlParameter[4];
            param[0] = new SqlParameter("@pn_WareHouseId", iWareHouseId);
            param[1] = new SqlParameter("@ps_BoxLocationCode", BoxLocationCode);
            param[2] = new SqlParameter("@pn_CustomerId", iCustomerId);
            param[3] = new SqlParameter("@pn_CompanyGroupId", iCompanyGroupId);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETBOXLOCATION, param);
            return dsresult;
        }

        public string UpdateMaplocation(string strx_MapLocationList)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@px_MapLocationList", strx_MapLocationList);

                dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.INSERTUPDATEMAPLOCATION, param);
                if (dsresult.Tables.Count == 0)
                    return "Record saved successfully.";
                else
                {
                    ErrorHandler.WriteLog(dsresult);
                    return "Error while saving a record. Please try again.";
                }
            }
            catch (Exception ex)
            {
                ErrorHandler.WriteLog(ex);
                return "Error while saving a record. Please try again.";
            }
        }

        #endregion

        #region Location and Row Master 25/02/2015
        public DataSet GetRowMaster(Int16 iWareHouseId,Int16 iRowId)
        {
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@Pn_WareHouseId", iWareHouseId);
            param[1] = new SqlParameter("@pn_RowId", iRowId);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETROWMASTER, param);
            return dsresult;
        }

        public DataSet GetLocationDetails(Int16 iWareHouseId, Int16 iRowId,string strLocationCode)
        {
            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@Pn_WareHouseId", iWareHouseId);
            param[1] = new SqlParameter("@pn_RowId", iRowId);
            param[2] = new SqlParameter("@s_LocationCode", strLocationCode);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETLOCATIONDETAILS, param);
            return dsresult;
        }

        public string Genratelocation(Int16 iRowId)
        {
          
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@pn_RowId", iRowId);
                dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GENRATELOCATION, param);
                
                if (dsresult.Tables.Count == 0)
                    return "Record saved successfully.";
                else
                {
                    if (dsresult.Tables[0].Columns.Contains("AlreadyExistMessage"))
                    {
                        return "Record already exist for selected row";
                    }
                    ErrorHandler.WriteLog(dsresult);
                    return "Error while saving a record. Please try again.";
                }
           
        }

        public string AddUpdateRowMaster(RowMaster ObjRowMaster)
        {
            SqlParameter[] param = new SqlParameter[7];
            param[0] = new SqlParameter("@pn_RowId", ObjRowMaster.RowId);
            param[1] = new SqlParameter("@ps_RowName", ObjRowMaster.RowName);
            param[2] = new SqlParameter("@pn_WareHouseId", ObjRowMaster.WareHouseId);
            param[3] = new SqlParameter("@pn_NoofShelf", ObjRowMaster.NoofShelf);
            param[4] = new SqlParameter("@pn_NoOfLocationPerSelf", ObjRowMaster.NoOfLocationPerSelf);
            param[5] = new SqlParameter("@ps_Remark", ObjRowMaster.Remark);
            param[6] = new SqlParameter("@pn_UserId", ObjRowMaster.UserId);

            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.INSERTUPDATEROWMASTER, param);

            if (dsresult.Tables.Count == 0)
            {
                return "Record saved successfully.";
            }
            else
            {
                ErrorHandler.WriteLog(dsresult);
                return dsresult.Tables[0].Rows[0][7].ToString();
            }
        }


        public DataSet ValidateAndMapLocations( Int16 isValidate, string strxmlLocation)
        {
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@StrxmlLocation", strxmlLocation);
            param[1] = new SqlParameter("@IsValidate", isValidate);

            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.MAPLOCATIONS, param);
            return dsresult;
        }
#endregion

        #region ["Customer User Master"]
        public string InsertUpdateCustomerUserDetails(int UserId,string FullName,string UserName,
            string EmailId, string Password, int CompGroupId, int IsActive, string CustomerIdValues, int n_Islocked,string d_AccountExpiryDate)
        {
            SqlParameter[] param = new SqlParameter[9];
            param[0] = new SqlParameter("@pn_CustomerUserId", UserId);
            param[1] = new SqlParameter("@ps_CustomerUserName", UserName);
            param[2] = new SqlParameter("@ps_Name", FullName);
            param[3] = new SqlParameter("@ps_EmailId", EmailId);
            param[4] = new SqlParameter("@ps_Password", Password);
            param[5] = new SqlParameter("@pn_IsActive", IsActive);
            param[6] = new SqlParameter("@pn_CustomerId", CustomerIdValues);
            param[7] = new SqlParameter("@pn_Islocked", n_Islocked);
            param[8] = new SqlParameter("@pd_AccountExpiryDate", d_AccountExpiryDate);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.INSERTUPDATECUSTOMERUSERDETAILS, param);

            if (UserId == 0)
            {
                return "Record saved successfully.";
            }
            else if (UserId != 0)
            {
                return "Record updated successfully.";
            }
            //if (dsresult.Tables.Count == 0)
            //    return "Record saved successfully.";
            else
            {
                ErrorHandler.WriteLog(dsresult);
                return "Error while saving a record. Please try again.";
            }

        }

        public DataSet GetCustomerUserDetails(int UserId)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@pn_UserId", UserId);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETCUSTOMERUSERDETAILS, param);
            return dsresult;
        }

        public DataSet GetCustomerUserDetailsByUserName(string UseName, string Password)
        {
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@ps_UserName", UseName);
            param[1] = new SqlParameter("@ps_Password", Password);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETCUSTOMERUSERDETAILSBYUSERNAME, param);
            return dsresult;
        }

        public Int16 IsCustomerUserNameExist(int nUserId, string strUserName)
        {
            Int16 Result = 0;
            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@pn_UserId", nUserId);
            param[1] = new SqlParameter("@ps_UserName", strUserName);
            param[2] = new SqlParameter("@pn_ReturnValue", SqlDbType.SmallInt);
            param[2].Direction = ParameterDirection.Output;
            try
            {
                SqlHelper.ExecuteNonQuery(Conn, CommandType.StoredProcedure, uspCommonConstants.ISCUSTOMERUSERNAMEEXIST, param);
                Result = Convert.ToInt16(param[2].Value.ToString());
            }
            catch (SqlException ex)
            {
                ErrorHandler.WriteLog(ex);
                Result = 3;
            }
            return Result;
        }

        public string  GetContractEndDate(int pn_CustomerId)
        {

            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@pn_CustomerId", pn_CustomerId);
            return (string)SqlHelper.ExecuteScalar(Conn, CommandType.StoredProcedure, uspCommonConstants.GETCONTRACTENDDATE, param);
            
        }

        #endregion


        #region "Service Request in Main"

        public DataSet GetServiceRequestByCustomer(int iCustomerId)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@n_CustomerId", iCustomerId);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETSERVICEREQUESTBYCUSTOMER, param);
            return dsresult;
        }

        public DataSet GetServiceRequestWorkOrder(int ServiceRequestNo)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@pn_ServiceRequestNo", ServiceRequestNo);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETSERVICEREQUESTWORKORDER, param);
            return dsresult;
        }
        #endregion
        //public DataSet DemoGetServiceRequestWorkOrder(int DemoServiceRequestNo)
        //{
        //    SqlParameter[] param = new SqlParameter[1];
        //    param[0] = new SqlParameter("@n_RequestNo", DemoServiceRequestNo);
        //    dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.DemoGETSERVICEREQUESTWORKORDER, param);
        //    return dsresult;
        //}
       
        public DataSet GetServiceReques(int iWorkOrderNo)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@pn_WorkOrderNo", iWorkOrderNo);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETSERVICEREQUESRDETAILS, param);
            return dsresult;
        }
        #region [Account Master]
        public DataSet GetInvoice(int ICustomerId)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@pn_CustomerId", ICustomerId);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETINVOICENO, param);
            return dsresult;
        }
        public DataSet GetPaymentType()
        {

            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETPAYMENTTYPE);
            return dsresult;
        }
        public DataSet GetPaymentStatus()
        {
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETPAYMENTSTATUS);
            return dsresult;
        }



        public int InsertUpdatePayment(int? n_AccountId, int? n_InvoiceNo, int? n_PaymentType,
            string s_TransactionNumber, string d_TransactionDate, string s_ClientBank,
            string s_ClientBranch, decimal? n_ClientAccountNo, int? n_ChequeNumber, string d_ChequeDate,
            decimal? n_TransactionAmount,decimal? n_TDS,decimal? n_AmtReceived, int? n_Status, string s_ReasonChequeBounced, string s_Remarks, int? n_ModifiedBy)
        {
            SqlParameter[] param = new SqlParameter[18];
            param[0] = new SqlParameter("@pn_AccountId", n_AccountId);
            param[1] = new SqlParameter("@pn_InvoiceNo", n_InvoiceNo);
            param[2] = new SqlParameter("@pn_PaymentType", n_PaymentType);
            param[3] = new SqlParameter("@ps_TransactionNumber", s_TransactionNumber);
            param[4] = new SqlParameter("@pd_TransactionDate", d_TransactionDate);
            param[5] = new SqlParameter("@ps_ClientBank", s_ClientBank);
            param[6] = new SqlParameter("@ps_ClientBranch", s_ClientBranch);
            param[7] = new SqlParameter("@pn_ClientAccountNo", n_ClientAccountNo);

            param[8] = new SqlParameter("@pn_ChequeNumber", n_ChequeNumber);
            param[9] = new SqlParameter("@pd_ChequeDate", d_ChequeDate);
            param[10] = new SqlParameter("@pn_TransactionAmount", n_TransactionAmount);
            param[11] = new SqlParameter("@pn_TDS", n_TDS);
            param[12] = new SqlParameter("@pn_AmtReceived", n_AmtReceived);

            param[13] = new SqlParameter("@pn_Status", n_Status);
            param[14] = new SqlParameter("@ps_ReasonChequeBounced", s_ReasonChequeBounced);
            param[15] = new SqlParameter("@ps_Remarks", s_Remarks);
            param[16] = new SqlParameter("@pn_ModifiedBy", n_ModifiedBy);
            param[17] = new SqlParameter("@pActionResult", SqlDbType.SmallInt);
            param[17].Direction = ParameterDirection.Output;
            param[17].Value = 0;

            SqlHelper.ExecuteNonQuery(Conn, CommandType.StoredProcedure, uspCommonConstants.INSERTUPDATEPAYMENT, param);
            return Convert.ToInt16(param[17].Value);
            
           
            //IsCGExist = Convert.ToInt16(param[22].Value);
        }


        public DataSet GetPaymentDetails()
        {
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETPAYMENTDETAILS);
            return dsresult;
        }


        public decimal GetInvoiceAmount(Int64 pn_InvoiceNo)
        {
            decimal Amount = 0;
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@pn_InvoiceNo", pn_InvoiceNo);
            Amount = (decimal)SqlHelper.ExecuteScalar(Conn, CommandType.StoredProcedure, uspCommonConstants.GETINVOICEAMOUNT, param);
            return Amount;
        }

        #endregion


        public DataSet GetCustomerWorkorder(int iwarehouseid)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@WareHouseId", iwarehouseid);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETCUSTWO, param);
            return dsresult;
        }

        public DataSet Select_MakerSearch_ForEdit(int Fid)
        {
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@FileId", Fid);
            dsresult = SqlHelper.ExecuteDataset(Conn, CommandType.StoredProcedure, uspCommonConstants.GETFILEFOREDIT, param);
            return dsresult;
        }

        public Int16 IsCityMasterExist(int nCityId, string strCityName, int ns_StateId)
        {
            Int16 Result = 0;
            SqlParameter[] param = new SqlParameter[4];
            param[0] = new SqlParameter("@n_CityId", nCityId);
            param[1] = new SqlParameter("@s_CityName", strCityName);
            param[2] = new SqlParameter("@n_StateId", ns_StateId);
            param[3] = new SqlParameter("@pn_ReturnValue", SqlDbType.SmallInt);
            param[3].Direction = ParameterDirection.Output;
            try
            {
                SqlHelper.ExecuteNonQuery(Conn, CommandType.StoredProcedure, uspCommonConstants.ISCITYMASTEREXIST, param);
                Result = Convert.ToInt16(param[3].Value.ToString());
            }
            catch (SqlException ex)
            {
                ErrorHandler.WriteLog(ex);
                Result = 4;
            }
            return Result;
        }

        public Int16 IsRowMasterNameExist(int nRowId, string strRowName, int nWareHouseId)
        {
            Int16 Result = 0;
            SqlParameter[] param = new SqlParameter[4];
            param[0] = new SqlParameter("@pn_RowId", nRowId);
            param[1] = new SqlParameter("@ps_RowName", strRowName);
            param[2] = new SqlParameter("@pn_WareHouseId", nWareHouseId);
            param[3] = new SqlParameter("@pn_ReturnValue", SqlDbType.SmallInt);
            param[3].Direction = ParameterDirection.Output;
            try
            {
                SqlHelper.ExecuteNonQuery(Conn, CommandType.StoredProcedure, uspCommonConstants.ISROWMASTERNAMEEXIST, param);
                Result = Convert.ToInt16(param[3].Value.ToString());
            }
            catch (SqlException ex)
            {
                ErrorHandler.WriteLog(ex);
                Result = 3;
            }
            return Result;
        }
    }
}
