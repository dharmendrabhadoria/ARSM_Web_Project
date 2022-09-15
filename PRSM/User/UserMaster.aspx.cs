using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Entity;
using System.Globalization;
using UserRoleWiseAcess;
using Utility;
using System.Data;
using PRSMBAL;

public partial class Users_UserMaster : PageBase
{
    UserMaster objeUserMaster = new UserMaster();
    private System.Globalization.CultureInfo enGB = new System.Globalization.CultureInfo("en-GB");
    EncryptDecrypt objEncryptDecrypt = new EncryptDecrypt();
    MasterBAL objPRSMBAL = new MasterBAL();
    protected void Page_Load(object sender, EventArgs e)
        {
            if (UserId == 0)
            {
                 Response.Redirect("~/User/Login.aspx", false);
            }           
            if (!IsPostBack)
            {                  
            ViewState["UserId"] = 0;
            Fill_DropDownList();
            chkisActive.Checked = true;
            BindUserdetails();
            //txtPwd.TextMode = TextBoxMode.Password;
            //txtRenPassword.TextMode = TextBoxMode.Password;
            Isdisplaymsg(false);
            SetRolewiseAcessfuncationality();  
            }
    }
    public void Fill_DropDownList()
    {
            ddlRole.Items.Clear();
            ddlRole.DataSource = null;
            ddlRole.DataBind();
            DataSet ds = objPRSMBAL.GetApplicationCodeDetails("ROLE", string.Empty);
            ddlRole.DataSource = ds.Tables[0];
            ddlRole.DataValueField = "AppCodeId";
            ddlRole.DataTextField = "AppCodeName";
            ddlRole.DataBind();
            ddlRole.Items.Insert(0, new ListItem { Text = "--Select", Value = "0" });
            ddlDepartment.Items.Clear();
            ddlDepartment.DataSource = null;
            ddlDepartment.DataBind();
            DataSet ds1 = objPRSMBAL.GetApplicationCodeDetails("DEPARTMENT", string.Empty);
            ddlDepartment.DataSource = ds1.Tables[0];
            ddlDepartment.DataValueField = "AppCodeId";
            ddlDepartment.DataTextField = "AppCodeName";
            ddlDepartment.DataBind();
            ddlDepartment.Items.Insert(0, new ListItem { Text = "--Select", Value = "0" });

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
           if (Page.IsValid)
            {
                string sReturnValue = "";
                try
                {                   
                    if (txtdob.Text.Trim() == "")
                    {
                         return;
                    }
                    else
                    {
                        DateTime dob = Convert.ToDateTime(txtdob.Text.ToString(), enGB);
                        if (dob > DateTime.Now.Date)
                        {
                            lblDate.Attributes.Add("style", "display:block");
                            lblDate.Text = "Birth Date less than current date.";
                            return;
                        }
                    }
                    objeUserMaster.UserId     = Convert.ToInt32(ViewState["UserId"]);
                    objeUserMaster.FirstName  = txtFname.Text.Trim();
                    objeUserMaster.LastName   = txtLname.Text.Trim();
                    objeUserMaster.MiddleName = txtMname.Text.Trim();
                    objeUserMaster.BirthDate  = Convert.ToDateTime(txtdob.Text.ToString(), enGB);
                    objeUserMaster.UserName   = txtUserName.Text.Trim();
                    objeUserMaster.EmailId    = txtEmailId.Text.Trim();
                    string encryptedPwd       = EncryptDecrypt.EncryptString(txtPwd.Text.Trim());
                    objeUserMaster.Password   = encryptedPwd;
                    objeUserMaster.UserRole   = Convert.ToInt16(ddlRole.SelectedValue);
                    objeUserMaster.Department = Convert.ToInt16(ddlDepartment.SelectedValue);
                    Int16 IsActive            = 0;
                    if (chkisActive.Checked == true)
                    {
                        IsActive = 1;
                    }
                    objeUserMaster.IsActive = IsActive;
                    lblMessage.Text = string.Empty;
                    Int16 ChekUserExist = objPRSMBAL.IsUserNameExist(objeUserMaster.UserId, objeUserMaster.UserName);
                    Isdisplaymsg(true);
                    if (ChekUserExist == 2)
                    {
                        string Msg = "User Name already used by another user. ";
                        lblMessage.Text = Msg;
                        return;
                    }
                    sReturnValue = objPRSMBAL.InsertUpdateUserDetails(objeUserMaster);
                    if (sReturnValue == "Record saved successfully.")
                    {
                        lblMessage.Text = sReturnValue;
                        clear();
                    }
                    BindUserdetails();
                }
                catch (Exception ex)
                {
                    Isdisplaymsg(true);
                    lblMessage.Text = ex.ToString();
                    ErrorHandler.WriteLog(ex);
                }
            }
        }

    public void clear()
    {
        txtFname.Text = string.Empty;
        txtLname.Text = string.Empty;
        txtMname.Text = string.Empty;
        txtdob.Text = string.Empty;
        txtPwd.Text = string.Empty;
        txtUserName.Text = "";
        txtUserName.Enabled = true;
        txtRenPassword.Text = string.Empty;
        if (ddlDepartment.SelectedIndex > 0)
        {
            ddlDepartment.SelectedIndex = 0; 
        }
        if (ddlRole.SelectedIndex > 0)
        {
            ddlRole.SelectedIndex = 0;
        }
        ViewState["UserId"] = 0;
        TRpwdNew.Visible = true;
        txtEmailId.Text = "";
        txtEmailId.Enabled = true;
        lblDate.Text = "";
    }
    public void BindUserdetails()
    {
        gvUserMaster.DataSource = null;
        gvUserMaster.DataBind();
        DataSet ds = objPRSMBAL.GetUserDetails(0);
      if (ds.Tables.Count > 0)
      {
          if (ds.Tables[0].Rows.Count > 0)
          {
              gvUserMaster.DataSource = ds;
              gvUserMaster.DataBind();
          }
      }
    }
    public bool IsChecked(object IsCheck)
    {
      return Convert.ToInt16(IsCheck) == 1 ? true : false;  
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        Isdisplaymsg(false);
        lblMessage.Text = string.Empty;
        clear();
    }

    public void  Isdisplaymsg(bool Isdisplay)
    {
        if (Isdisplay)
        {
            lblMessage.Attributes.Add("style", "display:block");
        }
        else
        {
            lblMessage.Attributes.Add("style", "display:none");
        }
        
    }
    protected void gvUserMaster_RowCommand(object sender, GridViewCommandEventArgs e)
    {
       if (e.CommandName == "EdtUser")
        {
            lblDate.Attributes.Add("style", "display:none");
            Isdisplaymsg(false);
            txtUserName.Enabled = false;
            //txtEmailId.Enabled = false;
            int UserId = 0;
            UserId = Convert.ToInt32(e.CommandArgument.ToString());
            ViewState["UserId"] = UserId;
            DataSet ds = objPRSMBAL.GetUserDetails(UserId);
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    txtFname.Text = Convert.ToString(ds.Tables[0].Rows[0]["FirstName"]);
                    txtLname.Text = Convert.ToString(ds.Tables[0].Rows[0]["LastName"]);
                    txtMname.Text = Convert.ToString(ds.Tables[0].Rows[0]["MiddleName"]);
                  
                    if (!string.IsNullOrEmpty(Convert.ToString(ds.Tables[0].Rows[0]["BirthDate"])))
                    {
                        txtdob.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["BirthDate"]).ToString("dd-MM-yyyy",enGB);
                    }

                    txtUserName.Text = Convert.ToString(ds.Tables[0].Rows[0]["UserName"]);
                    txtEmailId.Text = Convert.ToString(ds.Tables[0].Rows[0]["EmailId"]);
                    txtPwd.TextMode = TextBoxMode.SingleLine;
                    txtRenPassword.TextMode = TextBoxMode.SingleLine;
                    txtPwd.Text = EncryptDecrypt.DecryptString(Convert.ToString(ds.Tables[0].Rows[0]["Password"]));
                    txtRenPassword.Text = EncryptDecrypt.DecryptString(Convert.ToString(ds.Tables[0].Rows[0]["Password"]));
                    TRpwdNew.Visible = false;
                    string deptid=Convert.ToString(ds.Tables[0].Rows[0]["Department"]).Trim();
                    string roleId = Convert.ToString(ds.Tables[0].Rows[0]["UserRole"]).Trim();
                    chkisActive.Checked = false;
                    if (Convert.ToInt16(ds.Tables[0].Rows[0]["IsActive"]) == 1)
                    {
                        chkisActive.Checked = true;
                    }
                    for (int i = 0; i < ddlDepartment.Items.Count  ; i++)
                    {
                        if (Convert.ToString(ddlDepartment.Items[i].Value) == deptid)
                        {
                            ddlDepartment.SelectedValue = deptid;
                            break;
                        }
                    }
                    for (int i = 0; i < ddlRole.Items.Count; i++)
                    {
                        if (Convert.ToString(ddlRole.Items[i].Value) == roleId)
                        {
                            ddlRole.SelectedValue = roleId;
                            break;
                        }
                    }
                }
             }
        }
    }


    protected void gvUserMaster_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvUserMaster.PageIndex = e.NewPageIndex;
        BindUserdetails();
    }
    #region [Rolewise access page funcationality]
    public void SetRolewiseAcessfuncationality()
    {
        UserRolewiseAcess objUserRoleWiseAcessDAL = new UserRolewiseAcess();
        DataTable dtPageId = objUserRoleWiseAcessDAL.GetApplicationCodeDetails("Page_Name", "User Master").Tables[0];
        int PageId = 0;
        if (dtPageId.Rows.Count > 0)
        {
            PageId = Convert.ToInt32(dtPageId.Rows[0][0]);
        }
        DataTable dtPagefuncationality = objUserRoleWiseAcessDAL.GetPageFunctionalityByRoleAndPageId(PageId, RoleId).Tables[0];
        btnSave.Visible = false;
        btnReset.Visible = false;

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
                            btnReset.Visible = true;
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
        if (gvUserMaster.Rows.Count > 0 && IsEditGrid == false)
        {
            for (int i = 0; i < gvUserMaster.Rows.Count; i++)
            {
                LinkButton lnkbtnEdit = (LinkButton)gvUserMaster.Rows[i].FindControl("lnkbtnEdit");
                if (lnkbtnEdit != null)
                {
                    lnkbtnEdit.Visible = false;
                }
            }
        }
    }
    #endregion
}
