using System;
using System.Data ;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Entity;
using System.Web.Script.Serialization;
using PRSMBAL;
using Utility;
using System.Web.Services;
using System.Web.SessionState;
using System.IO;
using UserRoleWiseAcess;
using System.Net;


public partial class Master_Customer : PageBase 
{
    PRSMBAL.MasterBAL objPRSMBAL = new MasterBAL();
    public static PRSMBAL.MasterBAL objstPRSMBAL = new MasterBAL();
    public const string strSaveFilePath = @"~/PRSMDocument/ContractDocument";
    private System.Globalization.CultureInfo enGB = new System.Globalization.CultureInfo("en-GB");
    protected void Page_Load(object sender, EventArgs e)
    {
            if (UserId == 0)
            {
                Response.Redirect("~/User/Login.aspx", false);
            }
            if (!IsPostBack)
            {   
                ViewState["iSrNo"] = -1;
                ViewState["iPickupAddressId"] = 0;
                ViewState["iCustomerId"] = 0;
                ViewState["iAuthorisedPersonId"] = 0;
                ViewState["iAuthorisedPersonId1"] = 0;
                BindApplicationMaster(ddlDepartment, "DEPARTMENT", string.Empty);
                BindApplicationMaster(ddlindustry, "INDUSTRY", string.Empty);
                BindState();
                BindCorpState();
                BindBillingState();
                BindPickUpState();
                ddlCity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
                ddlbillingCity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
               
                ddlpickupcity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
                ddlcorporatecity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
                BindCustomerPickupAddress();
                hdnPickupAddressId.Value  = "0";
                EnableDisableTabs(1);
                BindRateGrid();
                SetRolewiseAcessfuncationality();                           
            }
    }

    protected void BindAutoGenContractNo()
    {
        DataSet dsContractNumber = objstPRSMBAL.GetContractNumber();
        if (dsContractNumber.Tables[0].Rows.Count > 0)
        {
            txtContractNo.Text = dsContractNumber.Tables[0].Rows[0]["Column1"].ToString();
        }
    }
    #region [Autocomplete]
    [System.Web.Services.WebMethod]
    [System.Web.Script.Services.ScriptMethod()]
    public static List<Autocomplete> GetCompany(string prefix)
    {

        DataSet ds = objstPRSMBAL.GetCompanyGroup(0);
        List<Autocomplete> result = new List<Autocomplete>();
        if (ds.Tables.Count > 0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    result.Add(new Autocomplete
                    {
                        label = Convert.ToString(ds.Tables[0].Rows[i]["CGName"]),
                        value = Convert.ToInt32(ds.Tables[0].Rows[i]["CompanyGroupId"])
                    });
                }
            }
        }
        var res = result.ToList().Where(r => r.label.ToLower().IndexOf(prefix.ToLower()) != -1);
        return res.ToList();
    }
    public List<Autocomplete> GetCompanyid(string prefix)
    {
        DataSet ds = objstPRSMBAL.GetCompanyGroup(0);
        List<Autocomplete> result = new List<Autocomplete>();
        if (ds.Tables.Count > 0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    result.Add(new Autocomplete
                    {
                        label = Convert.ToString(ds.Tables[0].Rows[i]["CGName"]),
                        value = Convert.ToInt32(ds.Tables[0].Rows[i]["CompanyGroupId"])
                    });
                }
            }
        }
        var res = result.ToList().Where(r => r.label.ToLower().IndexOf(prefix.ToLower()) != -1);
        return res.ToList();
    }
    [WebMethod]
    public static List<City> GetAutoCompleteData(string StateId)
    {
        int iState = Convert.ToInt32(StateId);
        DataSet ds = objstPRSMBAL.GetCity(iState);
        List<City> lstCity = new List<City>();
        if (ds != null)
        {
            if (ds.Tables.Count > 0)
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    lstCity.Add(new City
                    {
                        CityName = Convert.ToString(ds.Tables[0].Rows[i]["CityName"]),
                        StateId = Convert.ToInt32(ds.Tables[0].Rows[i]["StateId"]),
                        CityId = Convert.ToInt32(ds.Tables[0].Rows[i]["CityId"])
                    });
                }
            }
        }
        return lstCity.Where(C => C.StateId == iState).ToList();
    }
    #endregion
    #region [ Search Customer]
   
    public void BindSearchedCustomer(int iCustomerId)
    {
        //Get Customer details
        string strRegAddress = string.Empty;
        DataSet dsCustomer = objPRSMBAL.GetCustomerByCustomerId(iCustomerId);
        DataTable dtC = dsCustomer.Tables[0];
        if (dtC.Rows.Count > 0)
          {
            ViewState["iCustomerId"]    = Convert.ToString(dtC.Rows[0]["CustomerId"]);
            selectedValue.Value         = Convert.ToString(dtC.Rows[0]["CompanyGroupId"]);  
            txtCustomerName.Text        = Convert.ToString(dtC.Rows[0]["CustomerName"]);
            txtNameofthegroup.Text      = Convert.ToString(dtC.Rows[0]["CompanyGroupName"]);
            strRegAddress = Convert.ToString(dtC.Rows[0]["BillingAddress"]);
            txtCustomerPinCode.Text     = Convert.ToString(dtC.Rows[0]["PinCode"]);
            txtBillingAddress1.Text = Convert.ToString(dtC.Rows[0]["BillingAddress1"]);
            txtBillingAddress2.Text = Convert.ToString(dtC.Rows[0]["BillingAddress2"]);

          
            ddlbillingState.ClearSelection();

            if (Convert.ToString(dtC.Rows[0]["BillingMode"]) == null || Convert.ToString(dtC.Rows[0]["BillingMode"]) == "")
            {
                ddlBillingMode.SelectedIndex = 1;
            }
            else
            {
                int intid = ddlBillingMode.Items.IndexOf(ddlBillingMode.Items.FindByValue(dtC.Rows[0]["BillingMode"].ToString()));
                if (intid > 0)
                {
                    ddlBillingMode.SelectedIndex = intid;
                }
                else
                {
                    ddlBillingMode.SelectedIndex = 0;
                }
            }

           
            //if(ddlBillingMode.Items.Count
            if (ddlbillingState.Items.Count > 0)
            {
                BindBillingState();
                ddlbillingState.SelectedIndex = ddlbillingState.Items.IndexOf(ddlbillingState.Items.FindByValue(dtC.Rows[0]["StateId"].ToString()));
            }
            if (ddlbillingCity.Items.Count > 0)
            {
                BindBillingCityByState(Convert.ToInt32(ddlbillingState.SelectedValue));
                ddlbillingCity.SelectedIndex = ddlbillingCity.Items.IndexOf(ddlbillingCity.Items.FindByValue(dtC.Rows[0]["CityId"].ToString()));
                ViewState["CutomerCityId"] = dtC.Rows[0]["CityId"].ToString();
            }
            //if (ddlBillingMode.Items.Count > 0)
            //{
            //    BindBillingState();
            //    ddlBillingMode.SelectedIndex = ddlBillingMode.Items.IndexOf(ddlBillingMode.Items.FindByValue(dtC.Rows[0]["BillingMode"].ToString()));
            //}
            //Get all pickup address of customer
            bindCustomerPickupAddressAndAuthorised(iCustomerId);
        }
        BindCustomerPickupAddress();

    }
   public void BindSerachCustomer(int iCustomerId)
    {
        ViewState["iCustomerId"] = iCustomerId;
        BindSearchedCustomer(iCustomerId);
    }
    #endregion
    #region [ PickupAddress]
    protected void ClearPickupAddress()
    {
        txtAuthoName.Text = string.Empty;
        txtAuthoPhone.Text = string.Empty;
        txtAuthoEmail.Text = string.Empty;
        txtAuthoName1.Text = string.Empty;
        txtAuthoPhone1.Text = string.Empty;
        txtAuthoEmail1.Text = string.Empty;
        txtPickUpPincode.Text = "";
        txtMobileNo.Text = "";
        txtMobileNo1.Text = "";
        hdnPickupAddressId.Value = "0";
        ViewState["iSrNo"] = -1;
        ViewState["iPickupAddressId"] = 0;
        ddlDepartment.SelectedIndex = 0;
        ddlpickupstate.SelectedIndex = 0;
        txtPickupAddress1.Text = string.Empty;
        txtPickupAddress2.Text = string.Empty;
        ddlpickupcity.Items.Clear();
        ddlpickupcity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        hdnPickupAddressId.Value = "0";
        ViewState["iAuthorisedPersonId"] = 0;
        ViewState["iAuthorisedPersonId1"] = 0;
    }
    public DataTable PickupAddressTable()
    {
        DataTable dt = new DataTable();
        if (ViewState["PickupAddressTable"] == null)
        {
            dt.TableName = "Root";
            dt.Columns.Add("SrNo", typeof(int));
            dt.Columns["SrNo"].AutoIncrement = true;
            dt.Columns["SrNo"].AutoIncrementSeed = 0;
            dt.Columns.Add("Address", typeof(String));
            dt.Columns.Add("Department", typeof(String));
            dt.Columns.Add("AuthorisedPerson", typeof(String));
            dt.Columns.Add("Email", typeof(String));
            dt.Columns.Add("PhoneNumber", typeof(String));
            dt.Columns.Add("MobileNo", typeof(String));
            dt.Columns.Add("AuthorisedPerson1", typeof(String));
            dt.Columns.Add("Email1", typeof(String));
            dt.Columns.Add("PhoneNumber1", typeof(String));
            dt.Columns.Add("MobileNo1", typeof(String));
            dt.Columns.Add("CityId", typeof(Int32));
            dt.Columns.Add("PinCode", typeof(Int32));
            dt.Columns.Add("StateId", typeof(Int32));
            dt.Columns.Add("DepartmentId", typeof(Int32));
            dt.Columns.Add("PickupAddressId", typeof(int));
            dt.Columns.Add("AuthorisedPersonId", typeof(int));
            dt.Columns.Add("AuthorisedPersonId1", typeof(int));
            dt.Columns.Add("CustomerId", typeof(int));
            dt.Columns.Add("UserId", typeof(String));
            dt.Columns.Add("IsEdit", typeof(byte));
            dt.Columns.Add("Address1", typeof(string));
            dt.Columns.Add("Address2", typeof(string));
            dt.AcceptChanges();
        }
        else
        {
            dt = (DataTable)ViewState["PickupAddressTable"];
        }
        return dt;
    }

    public void AddPickupAddress(int iSrNo, string strAddress, string strDepartment,
                                 string strAuthorisedPerson, string strEmail,
                                 string strPhoneNumber, String mobileNo,
                                 string strAuthorisedPerson1, string strEmail1,
                                 string strPhoneNumber1, String mobileNo1, int iStateId, int iCityId, int ipcUpPincode,
                                 int iDepartmentId, int iPickupAddressId,
                                 int iAuthorisedPersonId,
                                 int iAuthorisedPersonId1,
                                 int iCustomerId, int iUserId, byte bIsEdit,string Address1,string Address2)
    {
        DataTable dt;
        DataRow dr;
        dt = PickupAddressTable();
        try
        {
            dr = dt.NewRow();
            if (iSrNo == -1)
            {
                dr["Address"] = strAddress.Trim();
                dr["Department"] = strDepartment;
                dr["AuthorisedPerson"] = strAuthorisedPerson;
                dr["Email"] = strEmail;
                dr["PhoneNumber"] = strPhoneNumber;
                dr["MobileNo"] = mobileNo;
                dr["AuthorisedPerson1"] = strAuthorisedPerson1;
                dr["Email1"] = strEmail1;
                dr["PhoneNumber1"] = strPhoneNumber1;
                dr["MobileNo1"] = mobileNo1;
                dr["CityId"] = iCityId;
                dr["PinCode"] = ipcUpPincode;
                dr["StateId"] = iStateId;
                dr["DepartmentId"] = iDepartmentId;
                dr["AuthorisedPersonId"] = iAuthorisedPersonId;
                dr["AuthorisedPersonId1"] = iAuthorisedPersonId1;
                dr["PickupAddressId"] = iPickupAddressId;
                dr["CustomerId"] = iCustomerId;
                dr["UserId"] = iUserId;
                dr["IsEdit"] = bIsEdit;
                dr["Address1"] = Address1;
                dr["Address2"] = Address2;
                dt.Rows.Add(dr);
                dt.AcceptChanges();
            }
            else
            {
                dt.Rows[iSrNo]["Address"] = strAddress.Trim();
                dt.Rows[iSrNo]["Department"] = strDepartment;
                dt.Rows[iSrNo]["AuthorisedPerson"] = strAuthorisedPerson;
                dt.Rows[iSrNo]["Email"] = strEmail;
                dt.Rows[iSrNo]["PhoneNumber"] = strPhoneNumber;
                dt.Rows[iSrNo]["MobileNo"] = mobileNo;
                dt.Rows[iSrNo]["AuthorisedPerson1"] = strAuthorisedPerson1;
                dt.Rows[iSrNo]["Email1"] = strEmail1;
                dt.Rows[iSrNo]["PhoneNumber1"] = strPhoneNumber1;
                dt.Rows[iSrNo]["MobileNo1"] = mobileNo1;
                dt.Rows[iSrNo]["CityId"] = iCityId;
                dt.Rows[iSrNo]["PinCode"] = ipcUpPincode;
                dt.Rows[iSrNo]["StateId"] = iStateId;
                dt.Rows[iSrNo]["DepartmentId"] = iDepartmentId;
                dt.Rows[iSrNo]["PickupAddressId"] = iPickupAddressId;
                dt.Rows[iSrNo]["AuthorisedPersonId"] = iAuthorisedPersonId;
                dt.Rows[iSrNo]["AuthorisedPersonId1"] = iAuthorisedPersonId1;
                dt.Rows[iSrNo]["CustomerId"] = iCustomerId;
                dt.Rows[iSrNo]["UserId"] = iUserId;
                dt.Rows[iSrNo]["IsEdit"] = bIsEdit;
                dt.Rows[iSrNo]["Address1"] = Address1;
                dt.Rows[iSrNo]["Address2"] = Address2;
                dt.AcceptChanges();
            }
            ViewState["PickupAddressTable"] = dt;
        }
        catch (Exception ex)
        {
            lblMessage.Visible = true;
            lblMessage.Text = ex.ToString();
            ErrorHandler.WriteLog(ex);
        }
    }
    protected void btnAddpickupaddress_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
      
            try
            {
                int iSrNo = Convert.ToInt32(ViewState["iSrNo"]);
                int iPickupAddressId = Convert.ToInt32(ViewState["iPickupAddressId"]);
                int iCustomerId = 0;
                if (ViewState["iCustomerId"] != null)
                {
                    iCustomerId = Convert.ToInt32(ViewState["iCustomerId"]);
                }
                int iUserId = UserId;
                int iAuthorisedPersonId = Convert.ToInt32(ViewState["iAuthorisedPersonId"]);
                int iAuthorisedPersonId1 = Convert.ToInt32(ViewState["iAuthorisedPersonId1"]);
                byte bIsEdit = 0;
                if (iPickupAddressId != 0)
                {
                    bIsEdit = 1;
                }
                AddPickupAddress(iSrNo, "", ddlDepartment.SelectedItem.Text,
                                 txtAuthoName.Text.Trim(), txtAuthoEmail.Text.Trim(), txtAuthoPhone.Text.Trim(), txtMobileNo.Text.Trim(),
                                 txtAuthoName1.Text.Trim(), txtAuthoEmail1.Text.Trim(), txtAuthoPhone1.Text.Trim(),txtMobileNo1.Text.Trim(),
                                 Convert.ToInt32(ddlpickupstate.SelectedValue), Convert.ToInt32(ddlpickupcity.SelectedValue),Convert.ToInt32(txtPickUpPincode.Text),
                                 Convert.ToInt32(ddlDepartment.SelectedValue),
                                 iPickupAddressId,iAuthorisedPersonId,iAuthorisedPersonId1,iCustomerId,iUserId,bIsEdit,txtPickupAddress1.Text.Trim(),txtPickupAddress2.Text.Trim());
                if (iCustomerId != 0)
                {
                    DataSet ds = new DataSet();
                    DataTable dt = PickupAddressTable();
                    ds.Tables.Add(dt);
                    string XmlCustomerPickupAddress = ds.GetXml();
                    objPRSMBAL.AddUpdatePickupAddress(XmlCustomerPickupAddress,iCustomerId);
                    ClearPickupAddress();
                    ViewState["PickupAddressTable"] = null;
                    bindCustomerPickupAddressAndAuthorised(iCustomerId);
                    if (ddlbillingCity.Items.Count > 0)
                    {
                        BindBillingCityByState(Convert.ToInt32(ddlbillingState.SelectedValue));
                        ddlbillingCity.SelectedIndex = ddlbillingCity.Items.IndexOf(ddlbillingCity.Items.FindByValue(ViewState["CutomerCityId"].ToString()));
                    }
                }

                BindCustomerPickupAddress();
                ClearPickupAddress();
                ddlpickupcity.Items.Clear();
                ddlpickupcity.DataSource = null;
                ddlpickupcity.DataBind();
            }
            catch (Exception ex)
            {
                lblMessage.Visible = true;
                lblMessage.Text = ex.ToString();
                ErrorHandler.WriteLog(ex);
            }
        }
    }
    protected void gdvCustomerpickup_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        if (e.CommandName == "editPickUpp")
        {
            GridViewRow gdvCustomerpickupRow = (GridViewRow)((LinkButton)e.CommandSource).NamingContainer;
            if (gdvCustomerpickupRow != null)
            {
                HiddenField hdnPickupAddressId = (HiddenField)gdvCustomerpickupRow.FindControl("hdnPickupAddressId");
                HiddenField hdnStateId = (HiddenField)gdvCustomerpickupRow.FindControl("hdnStateId");
                HiddenField hdnCityId = (HiddenField)gdvCustomerpickupRow.FindControl("hdnCityId");
                HiddenField hdnPinCode = (HiddenField)gdvCustomerpickupRow.FindControl("hdnPinCode");
                HiddenField hdnDepartment = (HiddenField)gdvCustomerpickupRow.FindControl("hdnDepartment");
                Label lblmobile = (Label)gdvCustomerpickupRow.FindControl("lblmobile");
                Label lblmobile1 = (Label)gdvCustomerpickupRow.FindControl("lblmobile1");
                HiddenField hdnSrNo = (HiddenField)gdvCustomerpickupRow.FindControl("hdnSrNo");
                HiddenField hdnAuthorisedPersonId = (HiddenField)gdvCustomerpickupRow.FindControl("hdnAuthorisedPersonId");
                HiddenField hdnAuthorisedPersonId1 = (HiddenField)gdvCustomerpickupRow.FindControl("hdnAuthorisedPersonId1");
                HiddenField hdnPickupAddress1 = (HiddenField)gdvCustomerpickupRow.FindControl("hdnPickupAddress1");
                HiddenField hdnPickupAddress2 = (HiddenField)gdvCustomerpickupRow.FindControl("hdnPickupAddress2");
                txtPickupAddress1.Text = Convert.ToString(hdnPickupAddress1.Value);
                txtPickupAddress2.Text = Convert.ToString(hdnPickupAddress2.Value);

                if (hdnPickupAddressId != null)
                {
                    ViewState["iPickupAddressId"] = Convert.ToInt32(hdnPickupAddressId.Value);
                }
                if (hdnSrNo != null)
                {
                    ViewState["iSrNo"] = Convert.ToInt32(hdnSrNo.Value);
                }
                if (hdnAuthorisedPersonId != null)
                {
                    ViewState["iAuthorisedPersonId"] = Convert.ToInt32(hdnAuthorisedPersonId.Value);
                } if (hdnAuthorisedPersonId1 != null)
                {
                    ViewState["iAuthorisedPersonId1"] = Convert.ToInt32(hdnAuthorisedPersonId1.Value);
                }
                if (hdnDepartment != null)
                {

                    if (ddlDepartment.Items.Count > 0)
                    {
                        ddlDepartment.SelectedIndex = ddlDepartment.Items.IndexOf(ddlDepartment.Items.FindByValue(Convert.ToString(hdnDepartment.Value)));
                    }
                }



                if (hdnStateId != null)
                {
                       BindPickUpState();
                       ddlpickupstate.SelectedIndex = ddlpickupstate.Items.IndexOf(ddlpickupstate.Items.FindByValue(Convert.ToString(hdnStateId.Value)));
                }

                if (hdnCityId != null)
                {

                           BindPickUpCityByState(Convert.ToInt32(ddlpickupstate.SelectedValue));
                           ddlpickupcity.SelectedIndex = ddlpickupcity.Items.IndexOf(ddlpickupcity.Items.FindByValue(Convert.ToString(hdnCityId.Value)));
                }
                if (hdnPinCode!=null)
                        txtPickUpPincode.Text = hdnPinCode.Value.ToString();
                if(lblmobile!=null)
                    txtMobileNo.Text = lblmobile.Text;
                if (lblmobile1 != null)
                        txtMobileNo1.Text = lblmobile1.Text;
            }
        }
    }
    public void bindCustomerPickupAddressAndAuthorised(int iCustomerId)
    {

        DataSet dsPickUpAddress = objPRSMBAL.GetPickUpAddress(iCustomerId);
        if (dsPickUpAddress != null)
        {
            if (dsPickUpAddress.Tables.Count > 0)
            {
                DataTable dtPickUpAddress = dsPickUpAddress.Tables[0];
                string strAuthorisedPerson = string.Empty;
                string strEmail = string.Empty;
                string strPhoneNumber = string.Empty;
                string strMobileNo= string.Empty;
                string strMobileNo1 = string.Empty;
                string strAuthorisedPerson1 = string.Empty;
                string strEmail1 = string.Empty;
                string strPhoneNumber1 = string.Empty;
                int iAuthorisedPersonId = 0;
                int iAuthorisedPersonId1 = 0;
             
                for (int i = 0; i < dtPickUpAddress.Rows.Count; i++)
                {
                    int iPickupAddressId = 0;
                    iPickupAddressId = Convert.ToInt32(dtPickUpAddress.Rows[i]["PickupAddressId"]);
                    //Get Authorised persons of the pick up address
                    DataSet dsGetAuthorisedPerson = objPRSMBAL.GetAuthorisedPerson(iPickupAddressId);
                    if (dsGetAuthorisedPerson != null)
                    {
                        int count = -1;
                        if (dsGetAuthorisedPerson.Tables.Count > 0)
                        {
                            if (dsGetAuthorisedPerson.Tables[0].Rows.Count > 0)
                            {
                                iAuthorisedPersonId = Convert.ToInt32(dsGetAuthorisedPerson.Tables[0].Rows[0]["AuthorisedPersonId"]);
                                strAuthorisedPerson = Convert.ToString(dsGetAuthorisedPerson.Tables[0].Rows[0]["AuthorisedPerson"]);
                                strEmail = Convert.ToString(dsGetAuthorisedPerson.Tables[0].Rows[0]["Email"]);
                                strMobileNo = Convert.ToString(dsGetAuthorisedPerson.Tables[0].Rows[0]["MobileNo"]);
                                strPhoneNumber = Convert.ToString(dsGetAuthorisedPerson.Tables[0].Rows[0]["PhoneNumber"]);
                                count = 0;
        
                            }

                            if (dsGetAuthorisedPerson.Tables[0].Rows.Count > 1)
                            {

                                strAuthorisedPerson1 = Convert.ToString(dsGetAuthorisedPerson.Tables[0].Rows[1]["AuthorisedPerson"]);
                                strEmail1 = Convert.ToString(dsGetAuthorisedPerson.Tables[0].Rows[1]["Email"]);
                                strPhoneNumber1 = Convert.ToString(dsGetAuthorisedPerson.Tables[0].Rows[1]["PhoneNumber"]);
                                strMobileNo1 = Convert.ToString(dsGetAuthorisedPerson.Tables[0].Rows[1]["MobileNo"]) == "" ? "" : Convert.ToString(dsGetAuthorisedPerson.Tables[0].Rows[1]["MobileNo"]);
                                iAuthorisedPersonId1 = Convert.ToInt32(dsGetAuthorisedPerson.Tables[0].Rows[1]["AuthorisedPersonId"]);
                                count = 1;
                            }

                            if (count == 0)
                            {
                                AddPickupAddress(-1, Convert.ToString(dtPickUpAddress.Rows[i]["Address"]), Convert.ToString(dtPickUpAddress.Rows[i]["Department"]),
                                                                                           strAuthorisedPerson, strEmail, strPhoneNumber, strMobileNo,
                                                                                           "", "", "", "",
                                                                                           Convert.ToInt32(dtPickUpAddress.Rows[i]["StateId"]), Convert.ToInt32(dtPickUpAddress.Rows[i]["CityId"]), Convert.ToInt32(dtPickUpAddress.Rows[i]["PinCode"]),
                                                                                           Convert.ToInt32(dtPickUpAddress.Rows[i]["DepartmentId"]),
                                                                                           iPickupAddressId, iAuthorisedPersonId, 0, iCustomerId, UserId, 1,Convert.ToString(dtPickUpAddress.Rows[i]["Address1"]),Convert.ToString(dtPickUpAddress.Rows[i]["Address2"]));
                            }
                       
                            if (count == 1)
                            {
                                AddPickupAddress(-1, Convert.ToString(dtPickUpAddress.Rows[i]["Address"]), Convert.ToString(dtPickUpAddress.Rows[i]["Department"]),
                                                            strAuthorisedPerson, strEmail, strPhoneNumber, strMobileNo,
                                                            strAuthorisedPerson1, strEmail1, strPhoneNumber1, strMobileNo1,
                                                            Convert.ToInt32(dtPickUpAddress.Rows[i]["StateId"]), Convert.ToInt32(dtPickUpAddress.Rows[i]["CityId"]), Convert.ToInt32(dtPickUpAddress.Rows[i]["PinCode"]),
                                                            Convert.ToInt32(dtPickUpAddress.Rows[i]["DepartmentId"]),
                                                            iPickupAddressId, iAuthorisedPersonId, iAuthorisedPersonId1, iCustomerId, UserId, 1, Convert.ToString(dtPickUpAddress.Rows[i]["Address1"]), Convert.ToString(dtPickUpAddress.Rows[i]["Address2"]));
                            }
                 
                        }
                    }
                    //Add record to the viestate pickup address table

                }
            }
        }

    }
    protected void BindCustomerPickupAddress()
    {
        gdvCustomerpickup.DataSource = PickupAddressTable();
        gdvCustomerpickup.DataBind();
    }

    #endregion
    #region [Company Group]
    protected void btnSaveComanygroup_Click(object sender, EventArgs e)
    {       
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "ShowInfo", "ShowdivCompanyGroup();", true);        
        if (Page.IsValid)
        {
            try
            {
                int iCompanyGroupId = Convert.ToInt32(ViewState["CompanyGroupId"]);         

                List<Autocomplete> Companyid1 = GetCompanyid(txtGroupName.Text.Trim());
                int IsCgNameExist = objPRSMBAL.AddUpdateCompanyGroup(new CompanyGroup
                {
                    CompanyGroupId = iCompanyGroupId,
                    CGName = txtGroupName.Text.Trim(),
                    IndustryId = Convert.ToInt32(ddlindustry.SelectedItem.Value),
                    PANNumber = txtPANNo.Text.Trim(),
                    TANNumber = txtTAN.Text,
                    RegisterAddress = "",
                    StateId = Convert.ToInt32(ddlState.SelectedItem.Value),
                    CityId = Convert.ToInt32(ddlCity.SelectedItem.Value),
                    PinCode = txtpincode.Text.Trim(),
                    CorporateAddress = "",
                    CorporateStateId = Convert.ToInt32(ddlcorporatestate.SelectedItem.Value),
                    CorporateCityId = Convert.ToInt32(ddlcorporatecity.SelectedItem.Value),
                    CorporatePinCode = txtcorporatepincode.Text,
                    ContactPerson = txtContactPerson.Text,
                    PhoneNumber = txtPhoneNumber.Text.Trim(),
                    MobileNumber = txtMobileNumber.Text.Trim(),
                    Email = txtEmail.Text.Trim(),
                    ContactPerson1 = txtContactPerson1.Text,
                    PhoneNumber1 = txtPhoneNumber1.Text.Trim(),
                    MobileNumber1 = txtmobilenumber1.Text.Trim(),
                    Email1 = txtEmail1.Text.Trim(),
                    UserId = UserId,
                    RegAddress1 = txtRegAddress1.Text.Trim(),
                    RegAddress2 = txtRegAddress2.Text.Trim(),
                    CorpAddress1 = txtCorpAddress1.Text.Trim(),
                    CorpAddress2 = txtCorpAddress2.Text.Trim()
                   
                });

                if (IsCgNameExist == 1)// 0 Save  1 record exist
                {
                    lblCompanyGroupMsg.Visible = true;
                    lblCompanyGroupMsg.Text = "Company Group  Already Exists.";
                    //reqddlcity.IsValid = true;
                    BindCityByState(Convert.ToInt32(ddlState.SelectedValue));
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "ShowInfo", "ShowdivCompanyGroup();", true);
                    return;
                }
                else
                {
                    lblCompanyGroupMsg.Visible = true;
                    lblCompanyGroupMsg.Text = "Record Saved Successfully.";                   
                    txtNameofthegroup.Text = txtGroupName.Text.Trim();                   
                    List<Autocomplete> Companyid = GetCompanyid(txtGroupName.Text.Trim());

                    if (Companyid.Count > 0)
                    {
                        iCompanyGroupId = Convert.ToInt32(Companyid[0].value);
                        selectedValue.Value = Convert.ToString(iCompanyGroupId);                       
                    }                  
                    clear();                    
                }
            }
            catch (Exception ex)
            {
                ErrorHandler.WriteLog(ex);
            }
        }
    }

    public void clear()
    {      
        ViewState["CompanyGroupId"] = 0;
        Session["dsCustomer"] = null;
        txtGroupName.Text = string.Empty;
        txtPANNo.Text = string.Empty;
        txtTAN.Text = string.Empty;
        txtContactPerson.Text = string.Empty;
        txtPhoneNumber.Text = string.Empty;
        txtEmail.Text = string.Empty;
        txtContactPerson1.Text = string.Empty;
        txtPhoneNumber1.Text = string.Empty;
        txtRegAddress1.Text = "";
        txtRegAddress2.Text = string.Empty;
        txtEmail1.Text = string.Empty;
        txtpincode.Text = string.Empty;
        txtCorpAddress1.Text = string.Empty;
        txtCorpAddress2.Text = string.Empty;
        txtMobileNumber.Text = string.Empty;
        txtmobilenumber1.Text = string.Empty;
        if (ddlindustry.Items.Count > 0)
        {
            ddlindustry.SelectedIndex = 0;
        }
        if (ddlState.Items.Count > 0)
        {
            ddlState.SelectedIndex = 0;
        }
        if (ddlcorporatestate.Items.Count > 0)
        {
            ddlcorporatestate.SelectedIndex = 0;
        }
            ddlCity.Items.Clear();
            ddlCity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlcorporatecity.Items.Clear();
            ddlcorporatecity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        clear();
    }

    protected void btnClearComanygroup_Click(object sender, EventArgs e)
    {
        lblCompanyGroupMsg.Text = "";
        clear();
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "ShowInfo", "ShowdivCompanyGroup();", true);
    }
    
    #endregion
    #region [ Rate Activity]
    private void BindRateGrid()
    {
        int iCustomerId = Convert.ToInt32(ViewState["iCustomerId"]);
        grdRateCard.DataSource = objPRSMBAL.GetRateCard(Convert.ToInt32(iCustomerId),0);
        grdRateCard.DataBind();

    }
    #endregion
    #region [Customer]
    protected void BindApplicationMaster(DropDownList ddlApplicationCode, string strAppCode,string strAppCodeName)
    {

        ddlApplicationCode.DataSource = null;
        ddlApplicationCode.DataBind();
        ddlApplicationCode.DataSource = objPRSMBAL.GetApplicationCodeDetails(strAppCode, string.Empty);
        ddlApplicationCode.DataTextField = "AppCodeName";
        ddlApplicationCode.DataValueField = "AppCodeId";
        ddlApplicationCode.DataBind();
        ddlApplicationCode.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }

    protected void BindState()
    {
        ddlState.DataSource = null;
        ddlState.DataBind();
        ddlState.DataSource = objPRSMBAL.GetState(0);
        ddlState.DataTextField = "StateName";
        ddlState.DataValueField = "StateId";
        ddlState.DataBind();
        ddlState.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }

    protected void BindCorpState()
    {
        ddlcorporatestate.DataSource = null;
        ddlcorporatestate.DataBind();
        ddlcorporatestate.DataSource = objPRSMBAL.GetState(0);
        ddlcorporatestate.DataTextField = "StateName";
        ddlcorporatestate.DataValueField = "StateId";
        ddlcorporatestate.DataBind();
        ddlcorporatestate.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }

    protected void BindCityByState(int StateId)
    {

        DataSet ds = objPRSMBAL.GetCity(StateId);
        if (ds.Tables[0].Rows.Count > 0)
        {
            ddlCity.DataSource = null;
            ddlCity.DataSource = ds.Tables[0];
            ddlCity.DataTextField = "CityName";
            ddlCity.DataValueField = "CityId";
            ddlCity.DataBind();
            ddlCity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
        else
        {
            ddlCity.Items.Clear();
            ddlCity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
    }
    protected void BindCorpCityByState(int StateId)
    {

        DataSet ds = objPRSMBAL.GetCity(StateId);
        if (ds.Tables[0].Rows.Count > 0)
        {
            ddlcorporatecity.DataSource = null;
            ddlcorporatecity.DataSource = ds.Tables[0];
            ddlcorporatecity.DataTextField = "CityName";
            ddlcorporatecity.DataValueField = "CityId";
            ddlcorporatecity.DataBind();
            ddlcorporatecity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
        else
        {
            ddlcorporatecity.Items.Clear();
            ddlcorporatecity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
    }

    protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlState.SelectedIndex > 0)
        {
            int StateId = Convert.ToInt32(ddlState.SelectedValue);
            BindCityByState(StateId);
        }
        else
        {
            ddlCity.Items.Clear();
            ddlCity.DataSource = null;
            ddlCity.DataBind();
            ddlCity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
       ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "ShowInfo", "ShowdivCompanyGroup();", true);
    }
    protected void ddlcorporatestate_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlcorporatestate.SelectedIndex > 0)
        {
            int StateId = Convert.ToInt32(ddlcorporatestate.SelectedValue);
            BindCorpCityByState(StateId);
        }
        else
        {
            ddlcorporatecity.Items.Clear();
            ddlcorporatecity.DataSource = null;
            ddlcorporatecity.DataBind();
            ddlcorporatecity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
        ddlbillingCity.Focus();
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "ShowInfo", "ShowdivCompanyGroup();", true);
    }



    protected void BindBillingState()
    {
        // bind billing state
        ddlbillingState.DataSource = null;
        ddlbillingState.DataBind();
        ddlbillingState.DataSource = objPRSMBAL.GetState(0);
        ddlbillingState.DataTextField = "StateName";
        ddlbillingState.DataValueField = "StateId";
        ddlbillingState.DataBind();
        ddlbillingState.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }

   
    protected void BindPickUpState()
    {
        // bind pick up state
        ddlpickupstate.DataSource = null;
        ddlpickupstate.DataBind();
        ddlpickupstate.DataSource = objPRSMBAL.GetState(0);
        ddlpickupstate.DataTextField = "StateName";
        ddlpickupstate.DataValueField = "StateId";
        ddlpickupstate.DataBind();
        ddlpickupstate.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });

    }

    protected void BindBillingCityByState(int StateId)
    {

        DataSet ds = objPRSMBAL.GetCity(StateId);
        if (ds.Tables[0].Rows.Count > 0)
        {
            ddlbillingCity.DataSource = null;
            ddlbillingCity.DataSource = ds.Tables[0];
            ddlbillingCity.DataTextField = "CityName";
            ddlbillingCity.DataValueField = "CityId";
            ddlbillingCity.DataBind();
            ddlbillingCity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
        else
        {
            ddlbillingCity.Items.Clear();
            ddlbillingCity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
    }
    protected void ddlbillingState_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlbillingState.SelectedIndex > 0)
        {
            int StateId = Convert.ToInt32(ddlbillingState.SelectedValue);
            BindBillingCityByState(StateId);
        }
        else
        {
            ddlbillingCity.Items.Clear();
            ddlbillingCity.DataSource = null;
            ddlbillingCity.DataBind();
            ddlbillingCity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
        ddlbillingCity.Focus();
    }
    protected void BindPickUpCityByState(int StateId)
    {

        DataSet ds = objPRSMBAL.GetCity(StateId);
        if (ds.Tables[0].Rows.Count > 0)
        {
            ddlpickupcity.DataSource = null;
            ddlpickupcity.DataSource = ds.Tables[0];
            ddlpickupcity.DataTextField = "CityName";
            ddlpickupcity.DataValueField = "CityId";
            ddlpickupcity.DataBind();
            ddlpickupcity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
        else
        {
            ddlpickupcity.Items.Clear();
            ddlpickupcity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
    }

    protected void ddlpickupstate_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlpickupstate.SelectedIndex> 0)
        {
            int StateId = Convert.ToInt32(ddlpickupstate.SelectedValue);
            
            BindPickUpCityByState(StateId);
        }
        else
        {
            Page.Validate("SavePickGroup"); 
            ddlpickupcity.Items.Clear();
            ddlpickupcity.DataSource = null;
            ddlpickupcity.DataBind();
            ddlpickupcity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            
        }
        ddlpickupcity.Focus();
    }
    public void clearCustomer()
    {

        if (ddlbillingState.Items.Count > 0)
        {
            ddlbillingState.SelectedIndex = 0;
        }
        if (ddlDepartment.Items.Count > 0)
        {
            ddlDepartment.SelectedIndex = 0;
        }
        if (ddlbillingCity.Items.Count > 0)
        {
            ddlbillingCity.Items.Clear();
            ddlbillingCity.DataSource = null;
            ddlbillingCity.DataBind();
            ddlbillingCity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
        selectedValue.Value = "";
        txtGroupName.Text = string.Empty;
        txtCustomerName.Text = string.Empty;
        txtCustomerPinCode.Text = "";
        ViewState["PickupAddressTable"] = null;
         
        BindCustomerPickupAddress();
        ClearPickupAddress();
        clear();
    }
    protected void btnCancelCustomer_Click(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "ShowInfo", " EnableCustomerVaildation(false);", true);
        clearAllformfields();
        BindRateGrid();
    }
    public void clearAllformfields()
    {
        clearCustomer();
        if (ddlpickupstate.Items.Count > 0)
        {
            ddlpickupstate.SelectedIndex = 0;
        }
 
            ddlpickupcity.Items.Clear();
            ddlpickupcity.DataSource = null;
            ddlpickupcity.DataBind();
            ddlpickupcity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });


        if (ddlbillingState.Items.Count > 0)
        {
            ddlbillingState.SelectedIndex = 0;
        }

        if (ddlDepartment.Items.Count > 0)
        {
            ddlDepartment.SelectedIndex = 0;
        }
        if (ddlpickupstate.Items.Count > 0)
        {
            ddlpickupstate.SelectedIndex = 0;
        }

            ddlbillingCity.Items.Clear();
            ddlbillingCity.DataSource = null;
            ddlbillingCity.DataBind();
            ddlbillingCity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });

        lblMessage.Text = "";
        lblMessage.Visible = false;
        txtNameofthegroup.Text = string.Empty;
        txtBillingAddress1.Text = string.Empty;
        txtBillingAddress2.Text = string.Empty;
        ViewState["iCustomerId"] = 0;
        hdnCustId.Value = "0";
    }
    protected void btnSaveCustomer_Click(object sender, EventArgs e)
    {
      if (Page.IsValid)
        {

            try
            {
                DataTable dtValidation = PickupAddressTable();
                if (dtValidation.Rows.Count < 1)
                {
                    ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('Please enter atleast one pickup address.')", true);
                    return;
                }

                int iCompanyGroupId = 1;
                if (!string.IsNullOrEmpty(Convert.ToString(selectedValue.Value.Trim())))
                {
                    iCompanyGroupId = Convert.ToInt32(selectedValue.Value);
                }
                int iCustomerMaxId = objPRSMBAL.AddUpdateCustomer(new Customer
                {
                    CustomerId = Convert.ToInt32(ViewState["iCustomerId"]),
                    CustomerName = txtCustomerName.Text,
                    CompanyGroupId = Convert.ToInt16(selectedValue.Value),
                    BillingAddress = "",
                    StateId = Convert.ToInt32(ddlbillingState.SelectedValue),
                    CityId = Convert.ToInt32(ddlbillingCity.SelectedValue),
                    UserId = UserId,
                    CustPinCode =txtCustomerPinCode.Text,
                    BillingAddress1= txtBillingAddress1.Text,
                    BillingAddress2 = txtBillingAddress2.Text,
                    BillingMode=ddlBillingMode.SelectedValue
                 

                });
                if (iCustomerMaxId > 0)
                {
                    lblMessage.Visible = true;
                    lblMessage.Text = "Record saved successfully.";

                    DataSet ds = new DataSet();
                    DataTable dt = PickupAddressTable();
                    ds.Tables.Add(dt);
                    string XmlCustomerPickupAddress = ds.GetXml();
                    objPRSMBAL.AddUpdatePickupAddress(XmlCustomerPickupAddress, iCustomerMaxId);
                    if (GetQuerstringValue("CustomerId") != string.Empty)
                    {
                        ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "divShowhideSaveMsg();", true);
                    }
                }
                if (iCustomerMaxId == -1)
                {
                    lblMessage.Visible = true;
                    lblMessage.Text = "Customer Name already exist.";
                    txtCustomerName.Focus();
                }
                else
                {
                    clearCustomer();
                    txtNameofthegroup.Text = string.Empty;
                    txtBillingAddress1.Text = string.Empty;
                    txtBillingAddress2.Text = string.Empty;
                    ClearPickupAddress();
                    ViewState["iCustomerId"] = 0;
                    hdnCustId.Value = "0";
                    hdnCustId.Value = "0";
                    BindRateGrid();
                }
            }
            catch (Exception ex)
            {
                lblMessage.Visible = true;
                lblMessage.Text = ex.ToString();
                ErrorHandler.WriteLog(ex);
            }
        }
    }
    #endregion
    protected void lnkbtnNewcustomer_Click(object sender, EventArgs e)
    {
        EnableDisableTabs(1);
        clearAllformfields();
    }
    protected void cusCustom_ServerValidate(object sender, ServerValidateEventArgs e)
    {
       long zeroValidate =Convert.ToInt64(e.Value.ToString().Replace(" ","").Trim());
       if (zeroValidate ==0)
         e.IsValid = false;
        else
         e.IsValid = true;
    }
    protected void lnkbtnSearchCustomer_Click(object sender, EventArgs e)
    {
        EnableDisableTabs(2);
        BindGroupName();
        hdnSearcheCustId.Value = "0";
        BindCustomer(0, 0);
        txtSeach.Text = "";
        if (ddlGroupName.Items.Count > 0)
        {
            ddlGroupName.SelectedIndex = 0; 
        }
        SetRolewiseAcessfuncationality();
    }
    protected void lnkbtnviewContract_Click(object sender, EventArgs e)
    {
        EnableDisableTabs(4);
    }
    /// <summary>
    /// Enbale disable divs according to selected tab 
    /// </summary>
    /// <param name="itabid">  New Customer =1  ,Search Customer = 2, View Contract = 3</param>
    protected void EnableDisableTabs(byte  itabid )
    {
        switch (itabid )
        {

            case 2:
                divNewCustomer.Style["display"]    = "none";
                divSearchCustomer.Style["display"] = "block";
                lnkbtnNewcustomer.Style["color"] = "#4f4f4f !important;";
                lnkbtnSearchCustomer.Style["color"] = "blue !important;";
                break;
            case 3:
                divNewCustomer.Style["display"]     = "none";
                divSearchCustomer.Style["display"]  = "none";
                lnkbtnNewcustomer.Style["color"]    = "#4f4f4f !important;";
                lnkbtnSearchCustomer.Style["color"] = "#4f4f4f !important;";
                break;

                
            case 4:
                divNewCustomer.Style["display"] = "none";
                divSearchCustomer.Style["display"] = "none";
                lnkbtnNewcustomer.Style["color"] = "#4f4f4f !important;";
                lnkbtnSearchCustomer.Style["color"] = "#4f4f4f !important;";
                break;

            default:
                divNewCustomer.Style["display"]     = "block";
                divSearchCustomer.Style["display"]  = "none";
                lnkbtnNewcustomer.Style["color"]    = "blue !important;";
                lnkbtnSearchCustomer.Style["color"] = "#4f4f4f !important;";
                break;
        }
        
    }

    #region [ Search Customer]
    DataSet ds;
    public void BindCustomer(int iCompanyGroupId, int iCustomerId)
    {
        grdCustomer.DataSource = null;
        grdCustomer.DataBind();
        if (iCustomerId == 0)
        {
            ds = objPRSMBAL.GetCustomer(iCompanyGroupId);
            Session["GrdCcustomer"] = ds;
        }
        else
        {
            ds = objPRSMBAL.GetCustomerByCustomerId(iCustomerId);
        }
        string hdnVal = hdnSearcheCustId.Value.ToString();
        grdCustomer.PageIndex = 0;
        if (ds.Tables[0].Rows.Count > 0)
        {
            grdCustomer.DataSource = ds.Tables[0];
            grdCustomer.DataBind();
        }
    }
    protected void BindGroupName()
    {
        ddlGroupName.DataSource = objstPRSMBAL.GetCompanyGroup(0);
        ddlGroupName.DataTextField = "CGName";
        ddlGroupName.DataValueField = "CompanyGroupId";
        ddlGroupName.DataBind();
        ddlGroupName.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }


    [System.Web.Services.WebMethod]
    [System.Web.Script.Services.ScriptMethod()]
    public static List<Autocomplete> GetCustomerOnSameGrpName(string prefix)
    {
        List<Autocomplete> result = new List<Autocomplete>();

        try
        {
            DataSet ds = (DataSet)HttpContext.Current.Session["GrdCcustomer"];

            if (ds != null)
            {
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                        {
                            result.Add(new Autocomplete
                            {
                                label = Convert.ToString(ds.Tables[0].Rows[i]["CustomerName"]),
                                value = Convert.ToInt32(ds.Tables[0].Rows[i]["CustomerId"])
                            });
                        }
                    }
                }
            }

        }
        catch (Exception ex)
        {
            Utility.ErrorHandler.WriteLog(ex);
        }
        var res = result.ToList().Where(r => r.label.ToLower().IndexOf(prefix.ToLower()) != -1);
        return res.ToList();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            int iCompanyGroupId = 0;
            int iCustomerId = 0;
            if (string.IsNullOrEmpty(txtSeach.Text.Trim()))
            {
                hdnSearcheCustId.Value = "0";
            }
            if (ddlGroupName.SelectedValue != null)
            {
                iCompanyGroupId = Convert.ToInt32(ddlGroupName.SelectedItem.Value);
            }
            iCustomerId = Convert.ToInt32(hdnSearcheCustId.Value);
            BindCustomer(iCompanyGroupId, iCustomerId);
        }
        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }
    }
    protected void ddlGroupName_SelectedIndexChanged(object sender, EventArgs e)
    {

        txtSeach.Text = string.Empty;
        hdnSearcheCustId.Value = "0";
        if (ddlGroupName.SelectedValue.ToString() == "0")
        {
            BindCustomer(0, 0);
            txtSeach.Visible = false;
        }
        else
        {
            BindCustomer(Convert.ToInt32(ddlGroupName.SelectedValue), 0);
            txtSeach.Visible = true;
        }
    }
    #endregion
    protected void grdCustomer_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdCustomer.PageIndex = e.NewPageIndex;
        if (Session["GrdCcustomer"] != null)
        {
            DataSet ds = (DataSet)Session["GrdCcustomer"];
            grdCustomer.DataSource = ds;
            grdCustomer.DataBind(); 
        }
        else
        {
            BindCustomer(0, 0);
        }
    }
    protected void grdCustomer_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int iCustomerId = 0;
        if (e.CommandName == "lnkEdit")
        {
            clearAllformfields();
            divNewCustomer.Style["display"] = "block";
            divSearchCustomer.Style["display"] = "none";     
            iCustomerId = Convert.ToInt32(e.CommandArgument.ToString());
            BindSerachCustomer(iCustomerId);
            BindRateGrid();
        }
        else if (e.CommandName == "lnkAddContract")
        {
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "ShowdivContract();", true);
            BindAutoGenContractNo();
            string [] CustIdWithContractId =e.CommandArgument.ToString().Split(',');
            hdnCustIdONContract.Value = CustIdWithContractId[0].ToString();
            lblCompGrpName.Text = CustIdWithContractId[1].ToString();
            lblCustomername.Text = CustIdWithContractId[2].ToString();
            lblContrDocMsg.Text = "";
    
        }
        else if (e.CommandName == "lnkAddRate")
        {
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "ShowdivActivityRate();", true);
            lblFromDate.Text = "";
            lblEndDate.Text = "";
            string[] CustIdWithActvRate = e.CommandArgument.ToString().Split(',');
            hdnCustIdOnRate.Value =  CustIdWithActvRate[0].ToString();
            ViewState["iCustomerId"] = CustIdWithActvRate[0].ToString();
            lblRateCGname.Text = CustIdWithActvRate[1].ToString();
            lblRateCustName.Text = CustIdWithActvRate[2].ToString();

            ContractMaster ObjCM = new ContractMaster();
            Document ObjDM = new Document();
            DataSet dsContractOnCustomer = objPRSMBAL.GetContractOnCustomer(Convert.ToInt32(hdnCustIdOnRate.Value));
            DataTable dtContractOnCustomer = dsContractOnCustomer.Tables[0];
            if (dtContractOnCustomer.Rows.Count < 1)
            {
                grdRateCard.DataSource = null;
                grdRateCard.DataBind();
                tdFdate.Visible = false;
                tdEnddate.Visible = false;
                lblFromDate.Visible = false;
                lblEndDate.Visible = false;
                lblActvRateMsg.Text = "Please upload contract first to add/update the activity rate.";
               // ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('Please upload contract first.')", true);
                return;
            }

            if (dtContractOnCustomer.Rows.Count>=1)
            {
                BindRateGrid();
                tdFdate.Visible = true;
                tdEnddate.Visible = true;
              //  lblFromDate--
                
                lblFromDate.Visible = true;
                lblEndDate.Visible = true;
                if (dtContractOnCustomer.Rows.Count > 0)
                {
                    lblActvRateMsg.Text = "";
                    string sContractNumber = dtContractOnCustomer.Rows[0]["ContractNo"].ToString();
                    foreach (DataRow dr in dtContractOnCustomer.Rows)
                    {
                        if (dr["FromDate"].ToString() != "" && dr["EndDate"].ToString() != "")
                        {
                            DateTime dtfromdate = Convert.ToDateTime(dr["FromDate"]);
                            DateTime dttodate = Convert.ToDateTime(dr["EndDate"]);
                            lblFromDate.Text = dtfromdate.ToString("dd-MM-yyyy", CultureInfo);
                            lblEndDate.Text = dttodate.ToString("dd-MM-yyyy", CultureInfo);
                            break;
                        }
                    }
                }
            }
        }
    }
    protected void btnSaveContract_Click(object sender, EventArgs e)
    {
        lblMessage.Visible = false;
        string sContractNumber ="";
        string sDBFromDate ="";
        string sDBEndDate = "";
    
        if (Page.IsValid)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ServerControlScript", "ShowdivContract();", true);
            string message = "";
            try
            {
                ContractMaster ObjCM = new ContractMaster();
                Document ObjDM = new Document();
                DataSet dsContractOnCustomer = objPRSMBAL.GetContractOnCustomer(Convert.ToInt32(hdnCustIdONContract.Value));
                DataTable dtContractOnCustomer = dsContractOnCustomer.Tables[0];
                if (dtContractOnCustomer.Rows.Count > 0)
                {
                    for (int i = 0; i < dtContractOnCustomer.Rows.Count; i++)
                    {
                        sContractNumber = dtContractOnCustomer.Rows[i]["ContractNo"].ToString();
                        sDBFromDate = dtContractOnCustomer.Rows[i]["FromDate"].ToString();
                        sDBEndDate = dtContractOnCustomer.Rows[i]["EndDate"].ToString();
                        if (sContractNumber.Trim() == txtContractNo.Text.Trim())
                        {
                            if (Convert.ToDateTime(txtFromDateContract.Text) >= Convert.ToDateTime(sDBFromDate) && Convert.ToDateTime(txtFromDateContract.Text) <= Convert.ToDateTime(sDBEndDate))
                            {
                                lblContrDocMsg.Visible = true;
                                message = "Contract exist between dates " + Convert.ToDateTime(sDBFromDate).ToString("dd-MM-yyyy", CultureInfo) + " and " + Convert.ToDateTime(sDBEndDate).ToString("dd-MM-yyyy", CultureInfo) + " ";
                                lblContrDocMsg.Text = message.ToString();
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "ServerControlScript", "BindContractDate();", true);
                                return;
                            }
                            if (Convert.ToDateTime(txtEndDateContract.Text) >= Convert.ToDateTime(sDBFromDate) && Convert.ToDateTime(txtEndDateContract.Text) <= Convert.ToDateTime(sDBEndDate))
                            {
                                lblContrDocMsg.Visible = true;
                                message = "Contract exist between dates " + Convert.ToDateTime(sDBFromDate).ToString("dd-MM-yyyy", CultureInfo) + " and " + Convert.ToDateTime(sDBEndDate).ToString("dd-MM-yyyy", CultureInfo) + "";
                                lblContrDocMsg.Text = message.ToString();
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "ServerControlScript", "BindContractDate();", true);
                                return;
                            }
                        }
                    }
                }
                string sReturnValue = "";
                ObjCM.ContractId = 0;
                ObjCM.ContractNo =Convert.ToInt32(txtContractNo.Text.Trim());
                if (hdnCustIdONContract.Value != "")
                {
                    ObjCM.CustomerId = Convert.ToInt32(hdnCustIdONContract.Value);
                }
                ObjCM.FromDate = Convert.ToDateTime(txtFromDateContract.Text, enGB);
                ObjCM.EndDate = Convert.ToDateTime(txtEndDateContract.Text, enGB);
                ObjCM.Remark = txtRemark.Text.Trim();
                if (fileContractDocPath.HasFile)
                {
                    string filename = Path.GetFileName(fileContractDocPath.FileName);
                    string slblCustomername=" Client-";
                    slblCustomername+= lblCustomername.Text.Trim();
                    slblCustomername = slblCustomername.Replace(" ", "-");
                    string sCreatedFileName = slblCustomername.Replace("/","") + DateTime.Now.ToString("dd-MMM-yyyy", enGB) + "_" + filename;
                    ObjCM.DocumentName = txtDocumentName.Text.ToString();
                    ObjCM.Filepath = sCreatedFileName;
                    fileContractDocPath.SaveAs(Server.MapPath(strSaveFilePath + "\\" + sCreatedFileName.Replace("\\","").ToString()));
  
                }
                else
                {
                    ObjCM.DocumentName = "";
                    ObjCM.Filepath = "";
                }
                ObjCM.UserId = Convert.ToInt16(UserId);
                sReturnValue = objPRSMBAL.AddUpdateContractMaster(ObjCM);
                if (sReturnValue == "Record saved successfully.")
                {
                    lblContrDocMsg.Visible = true;
                    lblContrDocMsg.Text = "Record saved successfully.";
                    BindAutoGenContractNo();
                    Clear();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ServerControlScript", "ShowdivContract();", true);
                }
            }
            catch (Exception ex)
            {
                lblContrDocMsg.Visible = true;
                lblContrDocMsg.Text = ex.ToString();
                ErrorHandler.WriteLog(ex);
            }
        }
    }
    private void Clear()
    {
       // txtContractNo.Text = "";
        txtFromDateContract.Text = "";
        txtEndDateContract.Text = "";
        txtDocumentName.Text = "";
        txtRemark.Text = "";
        txtBillingAddress1.Text = "";
        txtBillingAddress2.Text = "";
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        //lblFromDate.Text = "";
        //lblEndDate.Text = "";
        lblActvRateMsg.Text = "";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "ServerControlScript", "ShowdivActivityRate();", true);
    }

    protected void btnSaveActivityRate_Click(object sender, EventArgs e)
    {
        string sReturnValue="";
        lblMessage.Visible = false;
       // Page.Validate();
        if (Page.IsValid)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ServerControlScript", "ShowdivActivityRate();", true);
            DateTime dFromDate = Convert.ToDateTime(lblFromDate.Text.ToString(), enGB);
            DateTime dEndDate = Convert.ToDateTime(lblEndDate.Text.ToString(), enGB);
            try
            {
                if (grdRateCard.Rows.Count > 0)
                {
                    foreach (GridViewRow Gvr in grdRateCard.Rows)
                    {
                        Label lblRate = (Label)Gvr.FindControl("lblRate");
                        TextBox txtRate = (TextBox)Gvr.FindControl("txtRate");
                        HiddenField hdnRateCardId = (HiddenField)Gvr.FindControl("hdnRateCardId");
                        HiddenField hdnActivityId = (HiddenField)Gvr.FindControl("hdnActivityId");
                         sReturnValue = objPRSMBAL.InsertUpdateRateCard(new RateCard
                            {
                                RateCardId = hdnRateCardId.Value.ToString() == "" ? 0 : Convert.ToInt32(hdnRateCardId.Value.ToString()),
                                CustomerId = Convert.ToInt32(hdnCustIdOnRate.Value),
                                ActivityId = Convert.ToInt32(hdnActivityId.Value),
                                Rate = txtRate.Text == "" ? 0 : Convert.ToDecimal(txtRate.Text),
                                UserId = UserId,
                                FromDate = dFromDate,
                                Todate = dEndDate,
                            });
                      }
                   }

                BindRateGrid();
                lblActvRateMsg.Visible = true;
                lblActvRateMsg.Text = "Record saved successfully.";
                lblCompGrpName.Text = "";
                lblCustomername.Text = "";
            }
            catch (Exception ex)
            {
                ErrorHandler.WriteLog(ex);
            }
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "ServerControlScript", "ShowdivActivityRate();", true);
    }
    #region [Rolewise access page funcationality]
    public void SetRolewiseAcessfuncationality()
    {
        UserRolewiseAcess objUserRoleWiseAcessDAL = new UserRolewiseAcess();
        DataTable dtPageId = objUserRoleWiseAcessDAL.GetApplicationCodeDetails("Page_Name","Customer").Tables[0];
        int PageId = 0;
        if (dtPageId.Rows.Count > 0)
        {
            PageId = Convert.ToInt32(dtPageId.Rows[0][0]);
        }
        DataTable dtPagefuncationality = objUserRoleWiseAcessDAL.GetPageFunctionalityByRoleAndPageId(PageId, RoleId).Tables[0];
        btnSave.Visible = false;
        btnCancelCustomer.Visible = false;
        btnAddpickupaddress.Visible = false;
        btnSearch.Visible = false;

        if (dtPagefuncationality != null)
        {
            string PageFuncationality = string.Empty;
            for (int i = 0; i < dtPagefuncationality.Rows.Count; i++)
            {
                if (Convert.ToBoolean(dtPagefuncationality.Rows[i]["IsEnableForRole"]))
                {
                    PageFuncationality = Convert.ToString(dtPagefuncationality.Rows[i]["Functionality"]);
                    switch (PageFuncationality)
                    {
                        case "Save":
                            btnSave.Visible = true;
                            break;
                        case "Edit":
                            ViewState["IsEditGrid"] = true;
                            break;
                        case "Clear":
                            btnCancelCustomer.Visible = true;
                            break;
                        case "Add":
                            btnAddpickupaddress.Visible = true;
                            break;
                        case "Search":
                            btnSearch.Visible = true;
                            break;
                        default:
                            break;
                    }
                }
            }
        }

        disablegrid(Convert.ToBoolean(ViewState["IsEditGrid"]));
    }

    protected void disablegrid(bool IsEditGrid)
    {
        if (grdCustomer.Rows.Count > 0 && IsEditGrid == false)
        {
            for (int i = 0; i < grdCustomer.Rows.Count; i++)
            {


                LinkButton lnkbtnEdit = (LinkButton)grdCustomer.Rows[i].FindControl("lnkbtnEdit");
                LinkButton lnkbtnAddNewContract = (LinkButton)grdCustomer.Rows[i].FindControl("lnkbtnAddNewContract");
                LinkButton lnkbtnAddRateCard = (LinkButton)grdCustomer.Rows[i].FindControl("lnkbtnAddRateCard");
                if (lnkbtnEdit != null)
                {
                    lnkbtnEdit.Visible = false;
                }
                if (lnkbtnAddNewContract != null)
                {
                    lnkbtnAddNewContract.Visible = false;
                }
                if (lnkbtnAddRateCard != null)
                {
                    lnkbtnAddRateCard.Visible = false;
                }
               
            }
        }
    }
    #endregion
}