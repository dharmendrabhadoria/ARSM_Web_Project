using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using UserRoleWiseAcess;
using System.Globalization;
using UserRoleWiseAcess;
using Utility;
using System.Data;
using PRSMBAL;
using Entity;
using System.Configuration;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Net;
using System.Drawing;


public partial class User_CustomerCreation : PageBase
{
    private System.Globalization.CultureInfo enGB = new System.Globalization.CultureInfo("en-GB");
    EncryptDecrypt objEncryptDecrypt = new EncryptDecrypt();
    MasterBAL objPRSMBAL = new MasterBAL();
    protected void Page_Load(object sender, EventArgs e)
    {
       
        if (!IsPostBack)
        {
            ViewState["UserId"] = 0;
            BindCompanyGroup(0);
            //lstCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            chkActive.Checked = true;
            BindCustomerdetails();
            Isdisplaymsg(false);
            SetRolewiseAcessfuncationality();
           

        }

    }

    protected void BindCompanyGroup(int iCompanyId)
    {
        ddlCompanyGroup.Items.Clear();
        ddlCompanyGroup.DataSource = objPRSMBAL.GetCompanyGroup(iCompanyId);
        ddlCompanyGroup.DataValueField = "CompanyGroupId";
        ddlCompanyGroup.DataTextField = "CGName";
        ddlCompanyGroup.DataBind();
        ddlCompanyGroup.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }

    public void BindCustomer(int iCompanyId)
    {
        if (iCompanyId == 0)
        { 
           lstCustomer.Items.Clear();
     
        }
        else
        {
            DataSet dsCustomer = objPRSMBAL.GetCustomer(iCompanyId);
            lstCustomer.DataSource = dsCustomer.Tables[0];
            lstCustomer.DataValueField = "CustomerId";
            lstCustomer.DataTextField = "CustomerName";
            lstCustomer.DataBind();
            lstCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });

        }
    }

   

    protected void btnSave_Click(object sender, EventArgs e)
    {
        DateTime dt1 = DateTime.ParseExact(txtAciveDate.Text, "dd-MM-yyyy", null);
        if (Page.IsValid)
        {
            string sReturnValue = "";
            try
            {
                
                if (txtAciveDate.Text != null && lblcontractDate.Text != null && txtAciveDate.Text.Length != 0 && lblcontractDate.Text.Length != 0)
                {
                     dt1 = DateTime.ParseExact(txtAciveDate.Text, "dd-MM-yyyy", null);
                     DateTime dt2 = DateTime.ParseExact(lblcontractDate.Text, "dd-MM-yyyy", null);

                    if (DateTime.Compare(dt1, dt2) > 0)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "", "alert('Account Expiry Date should be less than or equal to Contract Date.');", true);
                        return;
                    }
                }
               
               
                int UserId = Convert.ToInt32(ViewState["UserId"]);
                string FullName = txtCustFullName.Text.ToString().Trim();

                string UserName = txtCustUserName.Text.Trim();
                string EmailId = txtCustEmail.Text.Trim();

                string encryptedPwd = EncryptDecrypt.EncryptString(txtPwd.Text.Trim());
                
                string Password = encryptedPwd;

                int CompGroupId = Convert.ToInt16(ddlCompanyGroup.SelectedValue);
                string CustomerIdValues = string.Empty;
                foreach (ListItem item in lstCustomer.Items)
                {
                    if (item.Selected)
                    {
                        CustomerIdValues = CustomerIdValues + item.Value + ",";
                    }
                }

           

                Int16 IsActive = 0 , IsLocked = 0;

                if (chkActive.Checked == true)
                {
                    IsActive = 1;
                }
                if (chkLocked.Checked == true)
                {
                    IsLocked = 1;
                }
               
                lblMessage.Text = string.Empty;

                Int16 ChekUserExist = objPRSMBAL.IsCustomerUserNameExist(UserId, UserName);

                Isdisplaymsg(true);
                if (ChekUserExist == 2)
                {
                    string Msg = "User Id already used by another user. ";
                    lblMessage.Text = Msg;
                    return;
                }
                sReturnValue = objPRSMBAL.InsertUpdateCustomerUserDetails
                    (UserId, FullName, UserName, EmailId, Password, CompGroupId, IsActive, CustomerIdValues, IsLocked, dt1.ToString("dd/MM/yyyy"));
                if (sReturnValue == "Record saved successfully.")
                {
                    SendEmail();
                    lblMessage.Text = sReturnValue;
                    clear();
                }
                if (sReturnValue == "Record updated successfully.")
                {
                    SendEmail();
                    lblMessage.Text = sReturnValue;
                    clear();
                }
                BindCustomerdetails();
            }
            catch (Exception ex)
            {
                Isdisplaymsg(true);
                lblMessage.Text = ex.ToString();
                ErrorHandler.WriteLog(ex);
            }
        }
    }

    protected void gvUserMaster_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvUserMaster.PageIndex = e.NewPageIndex;
        BindCustomerdetails();
    }

    protected void gvUserMaster_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EdtUser")
        {
           
            Isdisplaymsg(false);
            txtCustUserName.Enabled = false;
            //txtEmailId.Enabled = false;
            int UserId = 0;
            UserId = Convert.ToInt32(e.CommandArgument.ToString());
            ViewState["UserId"] = UserId;
            DataSet ds = objPRSMBAL.GetCustomerUserDetails(UserId);
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    txtCustFullName.Text = Convert.ToString(ds.Tables[0].Rows[0]["CustomerName"]);
                    txtCustUserName.Text = Convert.ToString(ds.Tables[0].Rows[0]["CustomerUserName"]);
                    txtCustEmail.Text = Convert.ToString(ds.Tables[0].Rows[0]["EmailId"]);
                    txtPwd.TextMode = TextBoxMode.Password;
                
                    txtPwd.Text = EncryptDecrypt.DecryptString(Convert.ToString(ds.Tables[0].Rows[0]["Password"]));
                    //txtPwd.Text = string.Empty;
                    string CompanyGroupId = Convert.ToString(ds.Tables[0].Rows[0]["CompanyGroupId"]).Trim();
                    string CustomerId = Convert.ToString(ds.Tables[0].Rows[0]["CustomerId"]).Trim();
                    chkActive.Checked = false;
                    if (Convert.ToInt16(ds.Tables[0].Rows[0]["IsActive"]) == 1)
                    {
                        chkActive.Checked = true;
                    }
                    for (int i = 0; i < ddlCompanyGroup.Items.Count; i++)
                    {
                        if (Convert.ToString(ddlCompanyGroup.Items[i].Value) == CompanyGroupId)
                        {
                            ddlCompanyGroup.SelectedValue = CompanyGroupId;
                            break;
                        }
                    }
                    BindCustomer(Convert.ToInt16(CompanyGroupId));
                    string[] CustomerID = CustomerId.Split(',');
                    for (int i = 0; i < CustomerID.Length; i++)
                    {
                        if (lstCustomer.Items.FindByValue(CustomerID[i]) != null)
                        {
                            lstCustomer.Items.FindByValue(CustomerID[i]).Selected = true;
                        }
                       
                    }


                    chkLocked.Checked = false;
                    if (Convert.ToInt16(ds.Tables[0].Rows[0]["islocked"]) == 1)
                    {
                        chkLocked.Checked = true;
                    }

                    txtAciveDate.Text = Convert.ToString(ds.Tables[0].Rows[0]["AccountExpiryDate"]).Trim();

                    lblcontractDate.Text = objPRSMBAL.GetContractEndDate(Convert.ToInt32(lstCustomer.SelectedValue));
                    //trPwd.Visible = false ;
                }
            }
        }
    }

    public void BindCustomerdetails()
    {
        gvUserMaster.DataSource = null;
        gvUserMaster.DataBind();
        DataSet ds = objPRSMBAL.GetCustomerUserDetails(0);
        if (ds.Tables.Count > 0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                gvUserMaster.DataSource = ds;
                gvUserMaster.DataBind();
            }
        }
    }
    public void Isdisplaymsg(bool Isdisplay)
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

    public void clear()
    {
        txtCustFullName.Text = string.Empty;
        txtPwd.Text = string.Empty;
        txtCustUserName.Text = "";
        txtCustUserName.Enabled = true;
     
        if (ddlCompanyGroup.SelectedIndex > 0)
        {
            ddlCompanyGroup.SelectedIndex = 0;
        }
        //lstCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        if (lstCustomer.SelectedIndex > 0)
        {
            lstCustomer.SelectedIndex = 0;
        }
        ViewState["UserId"] = 0;
        //TRpwdNew.Visible = true;
        txtCustEmail.Text = "";
        txtCustEmail.Enabled = true;
        txtAciveDate.Text = string.Empty;
        lblcontractDate.Text = "";
       // trPwd.Visible = true;
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

   
    
    #region [Rolewise access page funcationality]
    public void SetRolewiseAcessfuncationality()
    {
        UserRolewiseAcess objUserRoleWiseAcessDAL = new UserRolewiseAcess();
        DataTable dtPageId = objUserRoleWiseAcessDAL.GetApplicationCodeDetails("Page_Name", "Customer User Master").Tables[0];
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
    protected void ddlCompanyGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
            BindCustomer(Convert.ToInt16(ddlCompanyGroup.SelectedValue));
    }
    protected void lstCustomer_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtAciveDate.Text = System.DateTime.Now.AddDays(180).ToString("dd-MM-yyyy").ToString();
        if(!string.IsNullOrEmpty(lstCustomer.SelectedValue))
        lblcontractDate.Text = objPRSMBAL.GetContractEndDate(Convert.ToInt32(lstCustomer.SelectedValue));
    }




    protected void SendEmail()
    {
        string username = string.Empty;
        string password = string.Empty;
        string constr = ConfigurationManager.ConnectionStrings["PRSMDataBaseConnection"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT s_CustomerUserName, s_Password FROM tbl_CustomerUserMaster WHERE s_EmailId = @Email"))
            {
                cmd.Parameters.AddWithValue("@Email", txtCustEmail.Text.Trim());
                cmd.Connection = con;
                con.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    if (sdr.Read())
                    {
                        username = sdr["s_CustomerUserName"].ToString();
                        password = EncryptDecrypt.DecryptString(sdr["s_Password"].ToString());
                    }
                }
                con.Close();
            }
        }
        if (!string.IsNullOrEmpty(password) && !string.IsNullOrEmpty(txtCustEmail.Text))
        {
            MailMessage mm = new MailMessage("pul@panoramicworld.biz", txtCustEmail.Text.Trim());
            mm.Subject = "Password Generated";
            mm.Body = string.Format("Dear {0},<br /><br />Your password is {1}.<br /><br />Regards.<br/>PRSM Team", username, password);
            mm.IsBodyHtml = true;
            SmtpClient smtp = new SmtpClient();
            smtp.Host = "smtp3.netcore.co.in";
            //smtp.EnableSsl = true;
            NetworkCredential NetworkCred = new NetworkCredential();
            NetworkCred.UserName = "pul@panoramicworld.biz";
            NetworkCred.Password = "$0Lut!0n";
            smtp.UseDefaultCredentials = false;
            smtp.Credentials = NetworkCred;
            smtp.Port = 25;
            smtp.Send(mm);
            lblMessage.ForeColor = Color.Green;
            lblMessage.Text = "Password has been sent to your email address.";
        }
        else
        {
            lblMessage.ForeColor = Color.Red;
            lblMessage.Text = "This email address does not match our records.";
        }


    }

}