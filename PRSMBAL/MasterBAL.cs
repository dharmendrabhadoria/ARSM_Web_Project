using System;
using System.Data ;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using PRSMDAL; 
namespace PRSMBAL
{
     public class MasterBAL
     {
         PRSMDAL.MasterDAL objMasterDAL = new PRSMDAL.MasterDAL();
         public static DataTable dsDocs;
         public static DataTable dsRack;
        
         #region [Application Code]
         public DataSet GetApplicationCodeDetails(string AppCode, string AppCodeName)
         {
             return objMasterDAL.GetApplicationCodeDetails(AppCode, AppCodeName);
         }

         public DataSet GetState(Int16 CountryId)
         {
             return objMasterDAL.GetState(CountryId);
         }

         public DataSet GetCity(int StateId)
         {
             return objMasterDAL.GetCity(StateId);
         }

         #endregion
         #region [ServiceCategory]
         public List<ServiceCategory> GetServiceCategory(byte bServiceCategoryId)
         {
             return objMasterDAL.GetServiceCategory(bServiceCategoryId);
         }
         public string AddUpdateServiceCategory(ServiceCategory ObjServiceCategory)
         {
            return  objMasterDAL.AddUpdateServiceCategory(ObjServiceCategory); 
         }
         public DataSet GetServiceCategoryById(byte bServiceCategoryId)
         {
             return objMasterDAL.GetServiceCategoryById(bServiceCategoryId); 
         }
        #endregion
         #region Activity
         public List<Activity> GetActivity(int iActivityId)
         {
             return objMasterDAL.GetActivity(iActivityId);
         }
         public string AddUpdateActivity(Activity ObjActivity)
         {
             return objMasterDAL.AddUpdateActivity(ObjActivity);
         }
         public DataSet GetActivitybyCategory(int iServiceCategoryId)
         {
             return objMasterDAL.GetActivitybyCategory(iServiceCategoryId);
         }
         #endregion

         
        #region [Company Group]
         public DataSet GetCompanyGroup(int ICompanyGroupId)
         {
           return   objMasterDAL.GetCompanyGroup(ICompanyGroupId);
         }
         public Int16 AddUpdateCompanyGroup(CompanyGroup ObjCompanyGroup)
         {
             return objMasterDAL.AddUpdateCompanyGroup(ObjCompanyGroup);
         }
        #endregion
         #region [Company Master]
         public DataSet GetCompanyMaster(int ICompanyMasterId)
         {
             return objMasterDAL.GetCompanyMaster(ICompanyMasterId);
         }
         public Int16 AddUpdateCompanyMaster(CompanyMaster ObjCompanyMaster)
         {
             return objMasterDAL.AddUpdateCompanyMaster(ObjCompanyMaster);
         }

         #endregion

         #region [User Master]

         public string InsertUpdateUserDetails(UserMaster objUser)
         {
             return objMasterDAL.InsertUpdateUserDetails(objUser);
         }

         public DataSet GetUserDetails(int UserId)
         {
             return objMasterDAL.GetUserDetails(UserId);
         }

         public DataSet GetUserDetailsByUserName(string Name, string Password)
         {
             return objMasterDAL.GetUserDetailsByUserName(Name, Password);
         }

         public Int16 IsUserNameExist(int iUserId, string strUserName)
         {
             return objMasterDAL.IsUserNameExist(iUserId, strUserName);
         }

         #endregion 

         #region [RateCard]
         public DataSet GetCustomer(int iCompanyGroupId)
         {
             return objMasterDAL.GetCustomer(iCompanyGroupId);
         }
         public DataSet GetRateCard(int iCustomerId, int IActivityId)
         {
             return objMasterDAL.GetRateCard(iCustomerId,IActivityId);
         }
         public string InsertUpdateRateCard(RateCard objRate)
         {
             return objMasterDAL.InsertUpdateRateCard(objRate);
         }
         #endregion
         #region [Customer]
         public int AddUpdateCustomer(Customer ObjCompanyGroup)
         {
             return objMasterDAL.AddUpdateCustomer(ObjCompanyGroup);
         }
         public string AddUpdatePickupAddress(string strxmlPickupAddress, int iCustomerId)
         {
             return objMasterDAL.AddUpdatePickupAddress(strxmlPickupAddress, iCustomerId);
         }

         public DataSet GetCustomerByWarehouseId(int iCustomerId)
         {
             return objMasterDAL.GetCustomerByWarehouseId(iCustomerId);
         }
         public DataSet GetCustomerByCustomerId(int iCustomerId)
         {
             return objMasterDAL.GetCustomerByCustomerId(iCustomerId);
         }
         public DataSet GetCompanyNamebyID(int iWHID)
         {
             return objMasterDAL.GetCOMPANYNAMEBYWHID(iWHID);
         }
         public DataSet GetPickUpAddress(int iCustomerId)
         {
             return objMasterDAL.GetPickUpAddress(iCustomerId);
         }
         public DataSet GetPickUpAddressOnWO(int WorkOrderNo)
         {
             return objMasterDAL.GetPickUpAddressOnWO(WorkOrderNo);
         }

         public DataSet GetAuthorisedPerson(int iPickupAddressId)
         {
             return objMasterDAL.GetAuthorisedPerson(iPickupAddressId);
         }
        #endregion
         #region [CityMaster]
         public string AddUpdateCityMaster(City objCityMaster)
         {
             return objMasterDAL.AddUpdateCityMaster(objCityMaster);
         }
         #endregion
         #region [WareHouse]
         public DataSet GetWareHouse(int IWareHouseId)
         {
             return objMasterDAL.GetWareHouse(IWareHouseId);
         }
         public int AddUpdateWareHouseMaster(WareHouse objWareHouse)
         {
             return objMasterDAL.AddUpdateWareHouseMaster(objWareHouse);
         }
         public DataSet GetRackMasterByWareHouseId(Int16 iWareHouseId)
         {
             return objMasterDAL.GetRackMasterByWareHouseId(iWareHouseId);
         }
        
         #endregion

         #region [Rack Master]
         public DataSet GetRackMaster(Int16 RackId)
         {
             return objMasterDAL.GetRackMaster(RackId);
         }
         public int AddUpdateRackMaster(RackMaster ObjCompanyGroup)
         {
             return objMasterDAL.AddUpdateRackMaster(ObjCompanyGroup);
         }
         public DataSet GetMaxWarehouseRowNumberAndBoxStartNo(Int16 iWareHouseId)
         {
             return objMasterDAL.GetMaxWarehouseRowNumberAndBoxStartNo(iWareHouseId);
         }
         #endregion

         #region [Contract Master]

         public string AddUpdateContractMaster(ContractMaster ObjContractMaster)
         {
             return objMasterDAL.AddUpdateContractMaster(ObjContractMaster);
         }

         public string InsertUpdateDocument(Document objDocument)
         {
             return objMasterDAL.InsertUpdateDocument(objDocument);
         }

         public DataSet GetContract(int ContractId)
         {
             return objMasterDAL.GetContract(ContractId);
         }

         public DataSet GetDocument(int ContractId)
         {
             return objMasterDAL.GetDocument(ContractId);
         }
         public int DeleteDocument(int DocumentId)
         {
             return objMasterDAL.DeleteDocument(DocumentId);
         }
         public DataSet GetContractOnCustomer(int iCustomerId)
         {
             return objMasterDAL.GetContractOnCustomer(iCustomerId);
         }
         public DataSet GetContractNumber()
         {
             return objMasterDAL.GetContractNumber();
         }
         #endregion
         #region [Box Location]
         public DataSet GetBoxLocation(int iWareHouseId, string BoxLocationCode, int iCustomerId, int iCompanyGroupId)
         {
             return objMasterDAL.GetBoxLocation(iWareHouseId,BoxLocationCode,iCustomerId,iCompanyGroupId);
         }
         public string UpdateMaplocation(string strx_MapLocationList)
         {
             return objMasterDAL.UpdateMaplocation( strx_MapLocationList);
         }
        #endregion

        #region [Location and Row Master 25/02/2015]
        public DataSet GetRowMaster(Int16 iWareHouseId, Int16 iRowId)
        {
            return objMasterDAL.GetRowMaster(iWareHouseId, iRowId);
        }
        public string Genratelocation(Int16 iRowId)
        {
            return objMasterDAL.Genratelocation(iRowId);
        }

        public DataSet GetLocationDetails(Int16 iWareHouseId, Int16 iRowId, string strLocationCode)
        {
             return objMasterDAL.GetLocationDetails(iWareHouseId,iRowId,strLocationCode);
        }
      
        public string AddUpdateRowMaster(RowMaster ObjRowMaster)
        {
            return objMasterDAL.AddUpdateRowMaster(ObjRowMaster); 
        }

        public DataSet ValidateAndMapLocations(Int16 isValidate, string strxmlLocation)
        {
         return    objMasterDAL.ValidateAndMapLocations(isValidate, strxmlLocation);
        }
       #endregion


        #region [Customer Master]

        public string InsertUpdateCustomerUserDetails(int UserId, string FullName, string UserName,
            string EmailId, string Password, int CompGroupId, int IsActive, string CustomerIdValues, int n_Islocked, string d_AccountExpiryDate)
        {
            return objMasterDAL.InsertUpdateCustomerUserDetails(UserId, FullName, UserName, EmailId,
                Password, CompGroupId, IsActive, CustomerIdValues, n_Islocked, d_AccountExpiryDate);
        }

        public DataSet GetCustomerUserDetails(int UserId)
        {
            return objMasterDAL.GetCustomerUserDetails(UserId);
        }

        public DataSet GetCustomerUserDetailsByUserName(string Name, string Password)
        {
            return objMasterDAL.GetCustomerUserDetailsByUserName(Name, Password);
        }

        public Int16 IsCustomerUserNameExist(int iUserId, string strUserName)
        {
            return objMasterDAL.IsCustomerUserNameExist(iUserId, strUserName);
        }

        public string GetContractEndDate(int pn_CustomerId)
        {
            return objMasterDAL.GetContractEndDate(pn_CustomerId);
        }

        #endregion 

        #region "Service Request in Main"

        public DataSet GetServiceRequestByCustomer(int iCustomerId)
        {
            return objMasterDAL.GetServiceRequestByCustomer(iCustomerId);
        }
        public DataSet GetServiceRequestWorkOrder(int ServiceRequestNo)
        {
            return objMasterDAL.GetServiceRequestWorkOrder(ServiceRequestNo);
        }
        #endregion
        //public DataSet DemoGetServiceRequestWorkOrder(int DemoServiceRequestNo)
        //{
        //    return objMasterDAL.DemoGetServiceRequestWorkOrder(DemoServiceRequestNo);
        //}
       
        public DataSet GetServiceRequestDetailsByWorkorder(int iWorkOrderNo)
        {
            return objMasterDAL.GetServiceReques(iWorkOrderNo);
        }


        #region [Account Master]
        public DataSet GetInvoice(int ICustomerId)
        {
            return objMasterDAL.GetInvoice(ICustomerId);
        }
        public DataSet GetPaymentType()
        {
            return objMasterDAL.GetPaymentType();
        }
        public DataSet GetPaymentStatus()
        {
            return objMasterDAL.GetPaymentStatus();
        }

        public int  InsertUpdatePayment(int? n_AccountId, int? n_InvoiceNo, int? n_PaymentType,
         string s_TransactionNumber, string d_TransactionDate, string s_ClientBank,
         string s_ClientBranch, decimal? n_ClientAccountNo, int? n_ChequeNumber, string d_ChequeDate,
         decimal? n_TransactionAmount,  decimal? n_TDS,  decimal? n_AmtReceived, int? n_Status, string s_ReasonChequeBounced, string s_Remarks,
            int? n_ModifiedBy)
        {
            return objMasterDAL.InsertUpdatePayment(n_AccountId, n_InvoiceNo,
                n_PaymentType, s_TransactionNumber, d_TransactionDate, s_ClientBank, s_ClientBranch, n_ClientAccountNo,
                n_ChequeNumber, d_ChequeDate, n_TransactionAmount,n_TDS,n_AmtReceived,n_Status, s_ReasonChequeBounced, s_Remarks, n_ModifiedBy);
        }
        public DataSet GetPaymentDetails()
        {
            return objMasterDAL.GetPaymentDetails();
        }


        public decimal GetInvoiceAmount(Int64 pn_InvoiceNo)
        {
            return objMasterDAL.GetInvoiceAmount(pn_InvoiceNo);
        }
        #endregion

        public DataSet GetCustomerWorkorder(int iwarehouseid)
        {
            return objMasterDAL.GetCustomerWorkorder(iwarehouseid);
        }

        public DataSet Select_MakerSearch_ForEdit(int Fid)
        {
            return objMasterDAL.Select_MakerSearch_ForEdit(Fid);
        }

        public Int16 IsCityMasterExist(int iCityId, string strCityName, int is_StateId)
        {
            return objMasterDAL.IsCityMasterExist(iCityId, strCityName,is_StateId);
        }

        public Int16 IsRowMasterNameExist(int iRowId, string strRowName, int iWareHouseId)
        {
            return objMasterDAL.IsRowMasterNameExist(iRowId, strRowName, iWareHouseId);
        }

     }

}
