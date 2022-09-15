using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PRSMBAL;
using Entity;
using Utility;
using UserRoleWiseAcess;
using System.Data;

public partial class Master_Rate : PageBase
{
    MasterBAL objPRSMBAL = new MasterBAL();
    string sDBFromDate ="";
    string sDBEndDate = "";
    private System.Globalization.CultureInfo enGB = new System.Globalization.CultureInfo("en-GB");
    protected void Page_Load(object sender, EventArgs e)
    {
        if (UserId == 0)
        {
            Response.Redirect("~/User/Login.aspx", false);
        }
        if (!IsPostBack)
        {
            BindCompnayGroup();
            ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            lblMessage.Text = "";
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
    private void BindCustomer()
    {
        lblFromDate.Text = "";
        lblEndDate.Text = "";
        tdFdate.Visible = false;
        tdEnddate.Visible = false;
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
        grdRateCard.DataSource = null;
        grdRateCard.DataBind();
    }
    private void BindRateGrid()
    {
        if (ddlCustomer.SelectedIndex > 0)
        {
            grdRateCard.DataSource = objPRSMBAL.GetRateCard(Convert.ToInt32(ddlCustomer.SelectedValue),0);
            grdRateCard.DataBind();
        }
        else
        {
            grdRateCard.DataSource =null;
            grdRateCard.DataBind();
        }
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
    protected void ddlCustomer_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblMessage.Text = "";
        lblFromDate.Text = "";
        lblEndDate.Text = "";
        ContractMaster ObjCM = new ContractMaster();
        Document ObjDM = new Document();
        DataSet dsContractOnCustomer = objPRSMBAL.GetContractOnCustomer(Convert.ToInt32(ddlCustomer.SelectedValue));
        DataTable dtContractOnCustomer = dsContractOnCustomer.Tables[0];
        if (dtContractOnCustomer.Rows.Count <1)
        {
            grdRateCard.DataSource = null;
            grdRateCard.DataBind();
            tdFdate.Visible = false;
            tdEnddate.Visible = false;
            lblFromDate.Visible = false;
            lblEndDate.Visible = false;
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('Please upload contract first to add/update the activity rate.')", true);
            return;
        }

        if (ddlCustomer.SelectedIndex > 0)
        {
                 BindRateGrid();
                if (dtContractOnCustomer.Rows.Count > 0)
                {
                    tdFdate.Visible = true;
                    tdEnddate.Visible = true;
                    lblFromDate.Visible = true;
                    lblEndDate.Visible = true;
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
    protected void btnSave_Click(object sender, EventArgs e)
    {
      if(Page.IsValid)
      {
        string sReturnValue = "Record Saved Successfully.";
        bool Is_Data_Saved = false;
        try
        {
     
            DateTime dFromDate = Convert.ToDateTime(lblFromDate.Text.ToString(), enGB);
            DateTime dEndDate = Convert.ToDateTime(lblEndDate.Text.ToString(), enGB);
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
                            RateCardId = hdnRateCardId.Value == "" ? 0 :Convert.ToInt32(hdnRateCardId.Value),
                            CustomerId = Convert.ToInt32(ddlCustomer.SelectedValue),
                            ActivityId = Convert.ToInt32(hdnActivityId.Value),
                            Rate =       txtRate.Text==""?0:Convert.ToDecimal(txtRate.Text),
                            UserId = UserId,
                            FromDate = dFromDate,
                            Todate = dEndDate,
                        });
                        Is_Data_Saved = true;
                    }               
                }
                if (Is_Data_Saved)
                 BindRateGrid();
                lblMessage.Text = sReturnValue;
               
            }

        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }
    }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Reset();
    }
    private void Reset()
    {
        ddlCompanyGroup.SelectedIndex = 0;
        ddlCustomer.Items.Clear();
        ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        grdRateCard.DataSource =null;
        grdRateCard.DataBind();
        lblMessage.Text = "";
        lblFromDate.Text = "";
        lblEndDate.Text = "";
        lblFromDate.Visible = false;
        lblEndDate.Visible = false;
        tdFdate.Visible = false;
        tdEnddate.Visible = false;
    }
    #region [Rolewise access page funcationality]
    public void SetRolewiseAcessfuncationality()
    {
        UserRolewiseAcess objUserRoleWiseAcessDAL = new UserRolewiseAcess();
        DataTable dtPageId = objUserRoleWiseAcessDAL.GetApplicationCodeDetails("Page_Name", "Rate Card").Tables[0];
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
                        case "Clear":
                            btnCancel.Visible = true;                          
                            break;                       
                      
                        default:
                            break;
                    }
                }
            }
        }

       
    }

   
    #endregion

 
}