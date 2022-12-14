using System;
using System.Data ;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Entity;
using System.Web.Services;
using System.Web.Script.Serialization;
using UserRoleWiseAcess;
using PRSMBAL;
using Utility;
 
public partial class Master_CompanyGroup : PageBase
{
     PRSMBAL.MasterBAL objPRSMBAL = new MasterBAL();
    public static PRSMBAL.MasterBAL objstPRSMBAL = new MasterBAL();
   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (UserId == 0)
        {
            Response.Redirect("~/User/Login.aspx", false);
        }
        if (!IsPostBack)
        {           
            BindIndustry();
            BindState();
            BindCorpState();
            BindCompnayGroup();
            ViewState["CompanyGroupId"] = 0;
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

    protected void BindCompnayGroup()
    {
  
        gdvCompanyGroup.DataSource = objPRSMBAL.GetCompanyGroup(0);
        gdvCompanyGroup.DataBind();

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
                        StateId  = Convert.ToInt32(ds.Tables[0].Rows[i]["StateId"]),
                        CityId   = Convert.ToInt32(ds.Tables[0].Rows[i]["CityId"])
                    });
                }
            }
        }
        return lstCity.Where(C => C.StateId == iState).ToList();

    }
    public void clear()
    { 
       ViewState["CompanyGroupId"] = 0;
       txtGroupName.Text = string.Empty ; 
       txtPANNo.Text = string.Empty ;
       txtTAN.Text = string.Empty ; 
       txtContactPerson.Text = string.Empty ;
       txtPhoneNumber.Text = string.Empty ;
       txtEmail.Text = string.Empty ;
       txtContactPerson1.Text = string.Empty;
       txtPhoneNumber1.Text = string.Empty;
       txtEmail1.Text = string.Empty;
       txtpincode.Text = string.Empty;
       txtcorporatepincode.Text = string.Empty;
       txtMobileNumber.Text = string.Empty;
       txtmobilenumber1.Text = string.Empty;
       txtRegAddress1.Text = string.Empty;
       txtRegAddress2.Text = string.Empty;
       txtCorpAddress1.Text = string.Empty;
       txtCorpAddress2.Text = string.Empty;

        if(ddlindustry.Items.Count >0)
        {
            ddlindustry.SelectedIndex = 0;
        }
            BindState();
            ddlCity.Items.Clear(); 
            ddlCity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            BindCorpState();
            ddlcorporatecity.Items.Clear();
            ddlcorporatecity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }
    protected void Validatedata(object source, ServerValidateEventArgs args)
    {
        if (txtContactPerson1.Text == "" && txtPhoneNumber1.Text == "" && txtmobilenumber1.Text == "" && txtEmail1.Text == "")
        {
            args.IsValid = true;
            
        }
        else if (txtContactPerson1.Text != "" && txtPhoneNumber1.Text != "" && txtPhoneNumber1.Text != "" && txtEmail1.Text != "")
        {
            args.IsValid = true;
        }
        else
        {
            string ErrorMsg = "Please ENTER Following Details";
            if (string.IsNullOrEmpty(txtContactPerson1.Text))
            {
                ErrorMsg += "Contact Person";
            }
            if (string.IsNullOrEmpty(txtPhoneNumber1.Text))
            {
                ErrorMsg += "Phone Number";
            }
            if (string.IsNullOrEmpty(txtmobilenumber1.Text))
            {
                ErrorMsg += "Mobile Number";
            }
            if (string.IsNullOrEmpty(txtEmail1.Text))
            {
                ErrorMsg += "Email";
            }
            args.IsValid = false;
            return;
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
    
            Validate();//validate all fields at server side        
            if (Page.IsValid)
            {
               try
                { 
                    
                    int iCompanyGroupId = Convert.ToInt32(ViewState["CompanyGroupId"]);
                    int IsCgNameExist = objPRSMBAL.AddUpdateCompanyGroup(new CompanyGroup
                    {
                        CompanyGroupId = iCompanyGroupId,
                        CGName = txtGroupName.Text.Trim(),
                        IndustryId = Convert.ToInt32(ddlindustry.SelectedItem.Value),
                        PANNumber = txtPANNo.Text.Trim(),
                        TANNumber = txtTAN.Text,
                        RegisterAddress ="",
                        StateId = Convert.ToInt32(ddlState.SelectedItem.Value),
                        CityId = Convert.ToInt32(ddlCity.SelectedItem.Value),
                        PinCode=txtpincode.Text.Trim(),
                        CorporateAddress="",
                        CorporateStateId=Convert.ToInt32(ddlcorporatestate.SelectedItem.Value),
                        CorporateCityId=Convert.ToInt32(ddlcorporatecity.SelectedItem.Value),
                        CorporatePinCode=txtcorporatepincode.Text,
                        ContactPerson = txtContactPerson.Text,
                        PhoneNumber = txtPhoneNumber.Text.Trim(),
                        MobileNumber=txtMobileNumber.Text.Trim(),
                        Email = txtEmail.Text.Trim(),
                        ContactPerson1=txtContactPerson1.Text,
                        PhoneNumber1=txtPhoneNumber1.Text.Trim(),
                        MobileNumber1=txtmobilenumber1.Text.Trim(),
                        Email1=txtEmail1.Text.Trim(),
                        UserId = UserId,
                        RegAddress1=txtRegAddress1.Text.Trim(),
                        RegAddress2=txtRegAddress2.Text.Trim(),   
                        CorpAddress1=txtCorpAddress1.Text.Trim(),
                        CorpAddress2=txtCorpAddress2.Text.Trim()
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
                        clear();
                        BindCompnayGroup();
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
    protected void gdvCompanyGroup_RowCommand(object sender, GridViewCommandEventArgs e)
    {
            if (e.CommandName == "EdtCompanyGroup")
            {
                ViewState["CompanyGroupId"] = Convert.ToInt32(e.CommandArgument.ToString());
                DataSet ds = objPRSMBAL.GetCompanyGroup(Convert.ToInt32(e.CommandArgument.ToString()));
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        txtGroupName.Text = Convert.ToString(ds.Tables[0].Rows[0]["CGName"]);
                        txtPANNo.Text = Convert.ToString(ds.Tables[0].Rows[0]["PANNumber"]);
                        txtTAN.Text = Convert.ToString(ds.Tables[0].Rows[0]["TANNumber"]);
                        txtpincode.Text = Convert.ToString(ds.Tables[0].Rows[0]["PinCode"]);
                        txtcorporatepincode.Text = Convert.ToString(ds.Tables[0].Rows[0]["CorpPinCode"]);
                        txtContactPerson.Text = Convert.ToString(ds.Tables[0].Rows[0]["ContactPerson"]);
                        txtPhoneNumber.Text = Convert.ToString(ds.Tables[0].Rows[0]["PhoneNumber"]);
                        txtMobileNumber.Text = Convert.ToString(ds.Tables[0].Rows[0]["MobileNumber"]);
                        txtEmail.Text = Convert.ToString(ds.Tables[0].Rows[0]["Email"]);
                        txtContactPerson1.Text = Convert.ToString(ds.Tables[0].Rows[0]["ContactPerson1"]);
                        txtPhoneNumber1.Text = Convert.ToString(ds.Tables[0].Rows[0]["PhoneNumber1"]);
                        txtmobilenumber1.Text = Convert.ToString(ds.Tables[0].Rows[0]["MobileNumber1"]);
                        txtEmail1.Text = Convert.ToString(ds.Tables[0].Rows[0]["Email1"]);
                        txtRegAddress1.Text = Convert.ToString(ds.Tables[0].Rows[0]["RegAddress1"]);
                        txtRegAddress2.Text = Convert.ToString(ds.Tables[0].Rows[0]["RegAddress2"]);
                        txtCorpAddress1.Text = Convert.ToString(ds.Tables[0].Rows[0]["CorpAddress1"]);
                        txtCorpAddress2.Text = Convert.ToString(ds.Tables[0].Rows[0]["CorpAddress2"]);

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
                    }
                }
                lblMessage.Visible = false;
            }

    }
    protected void BindCityByState(int  StateId)
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
        ddlCity.Focus();

    }
    protected void gdvCompanyGroup_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gdvCompanyGroup.PageIndex = e.NewPageIndex;
        BindCompnayGroup();
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        lblMessage.Text = "";
        clear();
    }
    #region [Rolewise access page funcationality]
    public void SetRolewiseAcessfuncationality()
    {
        UserRolewiseAcess objUserRoleWiseAcessDAL = new UserRolewiseAcess();
        DataTable dtPageId = objUserRoleWiseAcessDAL.GetApplicationCodeDetails("Page_Name", "Company Group").Tables[0];
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
        if (gdvCompanyGroup.Rows.Count > 0 && IsEditGrid == false)
        {
            for (int i = 0; i < gdvCompanyGroup.Rows.Count; i++)
            {
                LinkButton lnkbtnEdit = (LinkButton)gdvCompanyGroup.Rows[i].FindControl("lnkbtnEdit");
                if (lnkbtnEdit != null)
                {
                    lnkbtnEdit.Visible = false;
                }
            }
        }
    }
    #endregion

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

    protected void cusCG_ServerValidate(object sender, ServerValidateEventArgs e)
    {
        long zeroValidate = Convert.ToInt64(e.Value.ToString().Replace(" ", "").Trim());
        if (zeroValidate == 0)
            e.IsValid = false;
        else
            e.IsValid = true;
    }
}