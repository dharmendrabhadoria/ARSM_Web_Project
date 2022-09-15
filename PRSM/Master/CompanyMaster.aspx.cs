using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using UserRoleWiseAcess;
using PRSMBAL;
using Entity;
using Utility;

public partial class Master_CompanyMaster : PageBase
{
    PRSMBAL.MasterBAL objPRSMBAL = new MasterBAL();
    public static PRSMBAL.MasterBAL objstPRSMBAL = new MasterBAL();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindIndustry();
            BindState();
            BindCorpState();
            BindCompnayMaster();
            ViewState["CompanyMasterId"] = 0;
            ddlCity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlcorporatecity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            SetRolewiseAcessfuncationality();
        }
    }
    protected void BindIndustry()
    {
        ddlindustry.DataSource = null;
        ddlindustry.DataBind();
        ddlindustry.DataSource = objPRSMBAL.GetApplicationCodeDetails("INDUSTRY", string.Empty);
        ddlindustry.DataTextField = "AppCodeName";
        ddlindustry.DataValueField = "AppCodeId";
        ddlindustry.DataBind();
        ddlindustry.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
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
        ddlcorporatecity.Focus();
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
    protected void BindCompnayMaster()
    {

        gdvCompanyMaster.DataSource = objPRSMBAL.GetCompanyMaster(0);
        gdvCompanyMaster.DataBind();

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
        ddlCity.Focus();

    }
    protected void Clear()
    {
        ViewState["CompanyMasterId"] = 0;
        ddlState.SelectedIndex = 0;
        ddlCity.SelectedIndex = 0;
        ddlcorporatestate.SelectedIndex = 0;
        ddlcorporatecity.SelectedIndex = 0;
        txtpincode.Text = string.Empty;
        txtcorporatepincode.Text = string.Empty;
        txtcorporateaddress.Text = string.Empty;
        txtPhoneNumber.Text = string.Empty;       
        txtcorporateemail.Text = string.Empty;
        txtcorporatefax.Text = string.Empty;
        txtPhoneNumber1.Text = string.Empty;      
        txtFax.Text = string.Empty;
        txtCIN.Text = string.Empty;
        txtVAT.Text = string.Empty;
        txtregisteraddress.Text = string.Empty;
        ddlindustry.SelectedIndex = 0;
        txtGroupName.Text = string.Empty;
        txtEmail.Text = string.Empty;
        txtPANNo.Text = string.Empty;
        txtTAN.Text = string.Empty;
        txtSalesTaxNo.Text = string.Empty;
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        Validate();
        if (Page.IsValid)
        {
            try
            {
                int iCompanyMasterId = Convert.ToInt32(ViewState["CompanyMasterId"]);
                int IsCgNameExist = objPRSMBAL.AddUpdateCompanyMaster(new CompanyMaster 
                {
                    CompanyMasterId = iCompanyMasterId,
                    CMName = txtGroupName.Text.Trim(),
                    IndustryId = Convert.ToInt32(ddlindustry.SelectedItem.Value),
                    PANNumber = txtPANNo.Text.Trim(),
                    TANNumber = txtTAN.Text,
                    RegisterAddress = txtregisteraddress.Text.Trim(),
                    StateId = Convert.ToInt32(ddlState.SelectedItem.Value),
                    CityId = Convert.ToInt32(ddlCity.SelectedItem.Value),
                    PinCode = txtpincode.Text.Trim(), 
                    Email=txtEmail.Text.Trim(),
                    Phone = txtPhoneNumber.Text.Trim(),
                    Fax=txtFax.Text.Trim(),
                    CorporateAddress = txtcorporateaddress.Text.Trim(),
                    CorporateStateId = Convert.ToInt32(ddlcorporatestate.SelectedItem.Value),
                    CorporateCityId = Convert.ToInt32(ddlcorporatecity.SelectedItem.Value),
                    CorporatePinCode = txtcorporatepincode.Text,
                    CorporateEmail=txtcorporateemail.Text.Trim(),
                    CorporatePhone = txtPhoneNumber1.Text.Trim(),
                    CorporateFax=txtcorporatefax.Text.Trim(),
                    CINNumber=txtCIN.Text.Trim(),
                    VATNumber=txtVAT.Text.Trim(),
                    SALESTaxNumber=txtSalesTaxNo.Text.Trim(),
                    UserId = UserId
                });
                if (IsCgNameExist == 1)// 0 Save  1 record exist
                {
                    lblMessage.Visible = true;
                    lblMessage.Text = "Company Group  Already Exists.";
                }
                else
                {
                    lblMessage.Visible = true;
                    lblMessage.Text = "Record saved successfully.";
                    Clear();
                    BindCompnayMaster();
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
    protected void gdvCompanyMaster_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EdtCompanyMaster")
        {
            ViewState["CompanyMasterId"] = Convert.ToInt32(e.CommandArgument.ToString());
            DataSet ds = objPRSMBAL.GetCompanyMaster(Convert.ToInt32(e.CommandArgument.ToString()));
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    txtGroupName.Text = Convert.ToString(ds.Tables[0].Rows[0]["CMName"]);
                    txtPANNo.Text = Convert.ToString(ds.Tables[0].Rows[0]["PANNumber"]);
                    txtTAN.Text = Convert.ToString(ds.Tables[0].Rows[0]["TANNumber"]);
                    txtregisteraddress.Text = Convert.ToString(ds.Tables[0].Rows[0]["RegisterAddress"]);
                    txtpincode.Text = Convert.ToString(ds.Tables[0].Rows[0]["PinCode"]);
                    txtcorporateaddress.Text = Convert.ToString(ds.Tables[0].Rows[0]["CorpAddress"]);
                    txtcorporatepincode.Text = Convert.ToString(ds.Tables[0].Rows[0]["CorpPinCode"]);                  
                    for (int i = 0; i < ddlindustry.Items.Count; i++)
                    {
                        string strIndustryid = Convert.ToString(ds.Tables[0].Rows[0]["IndustryId"]);
                        if (Convert.ToString(ddlindustry.Items[i].Value) == strIndustryid)
                        {
                            ddlindustry.SelectedValue = strIndustryid;
                            break;
                        }
                    }
                    int strStateId = Convert.ToInt32(ds.Tables[0].Rows[0]["StateId"]);
                    for (int i = 0; i < ddlState.Items.Count; i++)
                    {

                        if (Convert.ToInt32(ddlState.Items[i].Value) == strStateId)
                        {
                            ddlState.SelectedValue = strStateId.ToString();
                            break;
                        }
                    }
                    BindCityByState(strStateId);
                    for (int i = 0; i < ddlCity.Items.Count; i++)
                    {
                        string strCityid = Convert.ToString(ds.Tables[0].Rows[0]["CityId"]);
                        if (Convert.ToString(ddlCity.Items[i].Value) == strCityid)
                        {
                            ddlCity.SelectedValue = strCityid;
                            break;
                        }
                    }
                    txtEmail.Text = Convert.ToString(ds.Tables[0].Rows[0]["Email"]);
                    txtPhoneNumber.Text = Convert.ToString(ds.Tables[0].Rows[0]["PhoneNumber"]);
                    txtFax.Text = Convert.ToString(ds.Tables[0].Rows[0]["FaxNumber"]);
                    int strCorpStateId = Convert.ToInt32(ds.Tables[0].Rows[0]["CorpStateId"]);
                    for (int i = 0; i < ddlcorporatestate.Items.Count; i++)
                    {

                        if (Convert.ToInt32(ddlcorporatestate.Items[i].Value) == strCorpStateId)
                        {
                            ddlcorporatestate.SelectedValue = strCorpStateId.ToString();
                            break;
                        }
                    }
                    BindCorpCityByState(strCorpStateId);
                    for (int i = 0; i < ddlcorporatecity.Items.Count; i++)
                    {
                        string strCorpCityid = Convert.ToString(ds.Tables[0].Rows[0]["CorpCityId"]);
                        if (Convert.ToString(ddlcorporatecity.Items[i].Value) == strCorpCityid)
                        {
                            ddlcorporatecity.SelectedValue = strCorpCityid;
                            break;
                        }
                    }
                    txtcorporateemail.Text = Convert.ToString(ds.Tables[0].Rows[0]["CorpEmail"]);
                    txtPhoneNumber1.Text = Convert.ToString(ds.Tables[0].Rows[0]["CorpPhoneNumber"]);
                    txtcorporatefax.Text = Convert.ToString(ds.Tables[0].Rows[0]["CorpFaxNumber"]);
                    txtCIN.Text = Convert.ToString(ds.Tables[0].Rows[0]["CINNumber"]);
                    txtVAT.Text = Convert.ToString(ds.Tables[0].Rows[0]["VATNumber"]);
                    txtSalesTaxNo.Text = Convert.ToString(ds.Tables[0].Rows[0]["SalesNumber"]);
                }
            }
            lblMessage.Visible = false;
        }

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Clear(); 
    }
    #region [Rolewise access page funcationality]
    public void SetRolewiseAcessfuncationality()
    {
        UserRolewiseAcess objUserRoleWiseAcessDAL = new UserRolewiseAcess();
        DataTable dtPageId = objUserRoleWiseAcessDAL.GetApplicationCodeDetails("Page_Name", "Company Master").Tables[0];
        int PageId = 0;
        if (dtPageId.Rows.Count > 0)
        {
            PageId = Convert.ToInt32(dtPageId.Rows[0][0]);
        }
        DataTable dtPagefuncationality = objUserRoleWiseAcessDAL.GetPageFunctionalityByRoleAndPageId(PageId, RoleId).Tables[0];
        btnSave.Visible = false;
        btnCancel.Visible = false;

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
                            btnCancel.Visible = true;
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
        if (gdvCompanyMaster.Rows.Count > 0 && IsEditGrid == false)
        {
            for (int i = 0; i < gdvCompanyMaster.Rows.Count; i++)
            {
                LinkButton lnkbtnEdit = (LinkButton)gdvCompanyMaster.Rows[i].FindControl("lnkbtnEdit");
                if (lnkbtnEdit != null)
                {
                    lnkbtnEdit.Visible = false;
                }
            }
        }
    }
    #endregion
}