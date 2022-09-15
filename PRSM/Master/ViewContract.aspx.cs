using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UserRoleWiseAcess;
using Entity;
using PRSMBAL;
using Utility;
using System.IO;
using System.Net;


public partial class Master_ViewContract :PageBase
{
    PRSMBAL.MasterBAL objPRSMBAL = new MasterBAL();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (UserId == 0)
        {
            Response.Redirect("~/User/Login.aspx", false);
        }
        if (!IsPostBack)
        {
            BindCompnayGroup();
            BindCustomer();
            ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            SetRolewiseAcessfuncationality();
        }
    }

    private void BindCompnayGroup()
    {
        ddlCompanyGroup.DataSource = objPRSMBAL.GetCompanyGroup(0);
        ddlCompanyGroup.DataTextField = "CGName";
        ddlCompanyGroup.DataValueField = "CompanyGroupId";
        ddlCompanyGroup.DataBind();
        ddlCompanyGroup.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }

    protected void ddlCompanyGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlCompanyGroup.SelectedIndex == 0)
        {
            Reset();
        }
        else
        {
            BindCustomer();
        }
    }
    private void BindCustomer()
    {
        if (ddlCompanyGroup.SelectedIndex > 0)
        {
            ddlCustomer.DataSource = objPRSMBAL.GetCustomer(Convert.ToInt32(ddlCompanyGroup.SelectedValue));
            ddlCustomer.DataTextField = "CustomerName";
            ddlCustomer.DataValueField = "CustomerId";
            ddlCustomer.DataBind();
            ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
        else
        {
            ddlCustomer.DataSource = null;
            ddlCustomer.DataBind();
            ddlCustomer.Items.Insert(0, new ListItem { Text = "--Please--", Value = "0" });
        }
    
    }

    protected void imgEdit_Click(object sender, ImageClickEventArgs e)
    {
        ImageButton imgEdit = (ImageButton)sender;
        // The file path to download.
        if (!string.IsNullOrEmpty(imgEdit.CommandArgument.ToString().Trim()))
        {

            string FullFilePath = Server.MapPath(@"~/PRSMDocument/ContractDocument" + "\\" + imgEdit.CommandArgument.ToString().Replace("\\", "").Trim());
            try
            {
                WebClient req = new WebClient();
                HttpResponse response = HttpContext.Current.Response;
                response.Clear();
                response.ClearContent();
                response.ClearHeaders();
                response.Buffer = true;
                response.AddHeader("Content-Disposition", "attachment;filename=\"" + FullFilePath + "\"");
                byte[] data = req.DownloadData(FullFilePath);
                response.BinaryWrite(data);
                response.End();
            }
            catch (Exception ex)
            {

             //   throw ex;

            }
        }
        else
        {
            Page page = HttpContext.Current.CurrentHandler as Page;
            page.ClientScript.RegisterStartupScript(typeof(Page), "Script", "<script language='javascript'>alert('Contract not uploaded.');</script>");
        }
    }

    private void BindContractOnCustId(int iCustomerId)
    {
        if (ddlCustomer.SelectedIndex > 0)
        {
            gvViewContract.DataSource = objPRSMBAL.GetContractOnCustomer(iCustomerId);
            gvViewContract.DataBind();
        }
        else
        {
            gvViewContract.DataSource = null;
            gvViewContract.DataBind();
        }
    }

    protected void ddlCustomer_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlCustomer.SelectedIndex > 0)
        {
            int iCustomerId = Convert.ToInt32(ddlCustomer.SelectedValue);
            BindContractOnCustId(iCustomerId);
        }
        else
        {
            gvViewContract.DataSource = null;
            gvViewContract.DataBind();
        }

    }

    private void Reset()
    {
        ddlCompanyGroup.SelectedIndex = 0;
        ddlCustomer.Items.Clear();
        ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        gvViewContract.DataSource = null;
        gvViewContract.DataBind();
    }
    #region [Rolewise access page funcationality]
    public void SetRolewiseAcessfuncationality()
    {
        UserRolewiseAcess objUserRoleWiseAcessDAL = new UserRolewiseAcess();
        DataTable dtPageId = objUserRoleWiseAcessDAL.GetApplicationCodeDetails("Page_Name", "View Contract").Tables[0];
        int PageId = 0;
        if (dtPageId.Rows.Count > 0)
        {
            PageId = Convert.ToInt32(dtPageId.Rows[0][0]);
        }
        DataTable dtPagefuncationality = objUserRoleWiseAcessDAL.GetPageFunctionalityByRoleAndPageId(PageId, RoleId).Tables[0];        

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
                       
                        case "View":
                            ViewState["IsEditGrid"] = true;
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
        if (gvViewContract.Rows.Count > 0 && IsEditGrid == false)
        {
            for (int i = 0; i < gvViewContract.Rows.Count; i++)
            {
                ImageButton imgEdit = (ImageButton)gvViewContract.Rows[i].FindControl("imgEdit");
                if (imgEdit != null)
                {
                    imgEdit.Visible = false;
                }
            }
        }
    }
    #endregion
    protected void gvViewContract_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvViewContract.PageIndex = e.NewPageIndex;
    }
}