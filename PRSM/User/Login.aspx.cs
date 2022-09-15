using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Entity;
using System.Globalization;
using System.Data;
using PRSMBAL;
using System.Net.Mail;
using System.IO;
using Utility;

public partial class User_Login :PageBase
{

    MasterBAL objPRSMBAL = new MasterBAL();
    protected void Page_Load(object sender, EventArgs e)
    {
    //Test
        if (!IsPostBack)
        {
            lblMsg.Attributes.Add("style", "display:none");
            Session.Clear();
        }
    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
       //string g= EncryptDecrypt.DecryptString("P5VAyRvJIdQ=");
        if (Page.IsValid)
            {
              try
               {
                string strUsername = txtUserID.Text.Trim();
                lblMsg.Visible = false;
                string password = EncryptDecrypt.EncryptString(txtLoginPassword.Text.Trim());
                DataSet ds = objPRSMBAL.GetUserDetailsByUserName(strUsername, password);
                bool bValidLogin = false;
                bool bIsActive = false;    
                if (ds != null)
                {
                    if (ds.Tables.Count > 0)
                    {
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            UserId = Convert.ToInt32(ds.Tables[0].Rows[0]["UserId"]);
                            RoleId = Convert.ToInt32(ds.Tables[0].Rows[0]["UserRole"]);
                            UserName = Convert.ToString(ds.Tables[0].Rows[0]["FirstName"]);  

                             if(Convert.ToString(ds.Tables[0].Rows[0]["MiddleName"]).Trim().Length >1) 
                             {
                                 UserName += Convert.ToString(ds.Tables[0].Rows[0]["MiddleName"]).Substring(0, 1);
                             }
                             else
                             {
                                 UserName +=" " ;
                             }
                             UserName += Convert.ToString(ds.Tables[0].Rows[0]["LastName"]);
                             RoleName = Convert.ToString(ds.Tables[0].Rows[0]["RoleName"]);
                            if (Convert.ToInt16(ds.Tables[0].Rows[0]["IsActive"]) == 1)
                            {
                                bIsActive = true;
                            }
                            bValidLogin = true;
                        }
                    }
                }
                if (bValidLogin)
                {
                    if (bIsActive)
                    {
                        Response.Redirect("~/Master/Home.aspx", false);
                    }
                    else
                    {

                        txtUserID.Text = string.Empty;
                        txtLoginPassword.Text = string.Empty;
                        lblMsg.Visible = true;
                        lblMsg.Text = "User Is not activated.";
                    }
                }
                else
                {
                    txtUserID.Text = string.Empty;
                    txtLoginPassword.Text = string.Empty;
                    lblMsg.Visible = true;
                    lblMsg.Text = "Invalid User Name Or Password.";                    
                    lblMsg.Attributes.Add("style", "display:block");
                }
              }
             catch (Exception ex)
              {
                lblMsg.Visible = true;
                lblMsg.Text = ex.ToString();
                ErrorHandler.WriteLog(ex);
            }
         }
    }
   
}
