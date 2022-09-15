using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PRSMBAL;
using Utility;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;
using Entity;
using UserRoleWiseAcess;
using System.Web.SessionState;


public partial class Transaction_OtherServices : PageBase
{
    PRSMBAL.MasterBAL objPRSMBAL = new MasterBAL();
    PageBase objPageBase = new PageBase();
    PRSMBAL.TransactionBAL objTRANSBAL = new TransactionBAL();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ddlWareHouse.Focus();
            OtherServices();
            SetRolewiseAcessfuncationality();
            
        }
    }
    protected void ddlCompanyGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlCompanyGroup.SelectedIndex > 0)
        {
            BindCustomer(Convert.ToByte(ddlCompanyGroup.SelectedItem.Value));
            ddlWorkOrder.Items.Clear();
            ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlWorkOrderActivity.Items.Clear();
            ddlWorkOrderActivity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
        else
        {
            ddlCustomer.Items.Clear();
            ddlCustomer.DataSource = null;
            ddlCustomer.DataBind();
            ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlWorkOrder.Items.Clear();
            ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlWorkOrderActivity.Items.Clear();
            ddlWorkOrderActivity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
    }
    protected void OtherServices()
    {
        BindDdlWareHouse(); 
        ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlWorkOrderActivity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });       
        ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlCompanyGroup.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });        
            
    }
    protected void BindCompanyGroup(int iCompanyId)
    {
        ddlCompanyGroup.DataSource = null;
        ddlCompanyGroup.DataBind();
        ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlWorkOrderActivity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlCompanyGroup.DataSource = objPRSMBAL.GetCompanyGroup(iCompanyId);
        ddlCompanyGroup.DataValueField = "CompanyGroupId";
        ddlCompanyGroup.DataTextField = "CGName";
        ddlCompanyGroup.DataBind();
        ddlCompanyGroup.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }
    protected void BindCustomer(int iCompanyId)
    {
        ddlCustomer.DataSource = null;
        ddlCustomer.DataBind();
        ddlCustomer.DataSource = objPRSMBAL.GetCustomer(iCompanyId);
        ddlCustomer.DataValueField = "CustomerId";
        ddlCustomer.DataTextField = "CustomerName";
        ddlCustomer.DataBind();
        ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }
    private void BindDdlWareHouse()
    {
        DataSet dsGetWareHouse = objPRSMBAL.GetWareHouse(0);
        if (dsGetWareHouse != null)
        {
            if (dsGetWareHouse.Tables.Count > 0)
            {
                ddlWareHouse.DataSource = dsGetWareHouse.Tables[0];
                ddlWareHouse.DataValueField = "WareHouseId";
                ddlWareHouse.DataTextField = "WarehouseName";
                ddlWareHouse.DataBind();
                ddlWareHouse.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            }
        }
        else
        {
            ddlCompanyGroup.Items.Clear();          
            ddlCustomer.Items.Clear();
            ddlCustomer.DataSource = null;
            ddlCustomer.DataBind();
            ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlWorkOrder.Items.Clear();
            ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlWorkOrderActivity.Items.Clear();
            ddlWorkOrderActivity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });            
        }
       
      
    }
    protected void BindWorkOrder(int iworkorder, int icustomerid, int iwarehouseid, int istatus, DateTime? dFromDate, DateTime? dToDate)
    {

        DataSet dsGetWorkOrderData = objTRANSBAL.GetWorkOrder(0,Convert.ToInt32(ddlCompanyGroup.SelectedItem.Value), Convert.ToInt32(ddlCustomer.SelectedValue), Convert.ToInt32(ddlWareHouse.SelectedValue), istatus, null, null);
        ddlWorkOrder.Items.Clear();
        ddlWorkOrder.DataSource = null;
        ddlWorkOrder.DataBind();        
        if (dsGetWorkOrderData != null)        
        {
            if (dsGetWorkOrderData.Tables.Count > 0)
            {               
                ddlWorkOrder.DataSource = dsGetWorkOrderData.Tables[0];
                ddlWorkOrder.DataValueField = "WorkorderNo";
                ddlWorkOrder.DataTextField = "WorkorderNo";
                ddlWorkOrder.DataBind();
            }
        }
        ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }
    protected void ddlCustomer_SelectedIndexChanged(object sender, EventArgs e)
    {
        int icustomerid, iwarehouseid, istatus;
        icustomerid = 0;
        iwarehouseid = 0;
        istatus = 0;
        if (ddlCustomer.SelectedIndex > 0)
        {
           int iCompgroupId = Convert.ToInt32(ddlCompanyGroup.SelectedItem.Value);
            icustomerid = Convert.ToInt32(ddlCustomer.SelectedItem.Value);
            ddlWorkOrderActivity.Items.Clear();
            ddlWorkOrderActivity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            if (ddlWareHouse.SelectedIndex > 0)
            {
                iwarehouseid = Convert.ToInt32(ddlWareHouse.SelectedItem.Value);
            }
            istatus = GetWorkStatus("Open");
            bindWorkOrder(iCompgroupId,icustomerid, iwarehouseid, istatus);
        }
        else
        {
            ddlWorkOrderActivity.Items.Clear();
            ddlWorkOrderActivity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlWorkOrder.Items.Clear();
            ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
    }
    protected void bindWorkOrder(int icompgroupId, int icustomerid, int iwarehouseid, int istatus)
    {
        DataSet dsWorkOrder = objTRANSBAL.GetWorkOrder(0,icompgroupId, icustomerid, iwarehouseid, istatus, null, null);
        ddlWorkOrder.Items.Clear();
        ddlWorkOrder.DataSource = null;
        ddlWorkOrder.DataBind();
        if (dsWorkOrder != null)
        {
            if (dsWorkOrder.Tables.Count > 0)
            {
                ddlWorkOrder.DataSource = dsWorkOrder.Tables[0];
                ddlWorkOrder.DataValueField = "WorkorderNo";
                ddlWorkOrder.DataTextField = "WorkorderNo";
                ddlWorkOrder.DataBind();
            }
        }
        ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });

    }
    protected Int16 GetWorkStatus(string Status)
    {
        DataSet dsCodeDetails = objPRSMBAL.GetApplicationCodeDetails("WORKORDER_STATUS", "");
        Int16 istatus = 0;
        for (int i = 0; i < dsCodeDetails.Tables[0].Rows.Count; i++)
        {
            if (Convert.ToString(dsCodeDetails.Tables[0].Rows[i]["AppCodeName"]).ToUpper() == Status.ToUpper())
            {
                istatus = Convert.ToInt16(dsCodeDetails.Tables[0].Rows[i]["AppCodeId"]);
                break;
            }
        }
        return istatus;
    }
  
   
    protected void ddlWorkOrder_SelectedIndexChanged(object sender, EventArgs e)
    {
        ViewState["dsWorkOrderActivity"] = null;
        int istatus = GetWorkActivityStatus("Open");
        DataSet dsWorkOrderActivity = objTRANSBAL.GetWoActivity(0, Convert.ToInt32(ddlWorkOrder.SelectedValue), istatus, "Other Services",0);
        if (ddlCustomer.SelectedIndex > 0)
        {
            ddlWorkOrderActivity.DataSource = dsWorkOrderActivity.Tables[0];
            ViewState["dsWorkOrderActivity"] = dsWorkOrderActivity.Tables[0];
            ddlWorkOrderActivity.DataValueField = "WOActivityId";
            ddlWorkOrderActivity.DataTextField = "ActivityName";
            ddlWorkOrderActivity.DataBind();
            ddlWorkOrderActivity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
        else
        {
            ddlWorkOrderActivity.Items.Clear();
            ddlWorkOrderActivity.DataSource = null;
            ddlWorkOrderActivity.DataBind();
            ddlWorkOrderActivity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
      }

    protected Int16 GetWorkActivityStatus(string Status)
    {
        DataSet dsActivityStatus = objPRSMBAL.GetApplicationCodeDetails("ACTIVITY_STATUS", "");
        Int16 istatus = 0;
        for (int i = 0; i < dsActivityStatus.Tables[0].Rows.Count; i++)
        {
            if (Convert.ToString(dsActivityStatus.Tables[0].Rows[i]["AppCodeName"]).ToUpper() == Status.ToUpper())
            {
                istatus = Convert.ToInt16(dsActivityStatus.Tables[0].Rows[i]["AppCodeId"]);
                break;
            }
        }
        return istatus;
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            try
            {
                string sres = string.Empty;
                sres = objTRANSBAL.InsertOtherTransactions(0, Convert.ToInt32(ddlWorkOrderActivity.SelectedValue), Convert.ToInt32(txtnoofservices.Text), txtRemark.Text, Convert.ToInt32(objPageBase.UserId),Convert.ToDecimal(txtAmount.Text));
                lblMessage.Visible = true;
                lblMessage.Text = sres;
                Clear();
            }
            catch (Exception ex)
            {
                ErrorHandler.WriteLog(ex);    
                
            }           

        }
    }
    protected void Clear()
    {
        ddlWareHouse.SelectedIndex = 0;
        ddlCompanyGroup.SelectedIndex = 0;
        ddlWorkOrder.SelectedIndex = 0;
        ddlWorkOrderActivity.SelectedIndex = 0;
        txtnoofservices.Text = string.Empty;
        txtRemark.Text = string.Empty;
        txtAmount.Text = string.Empty;
        ddlCustomer.Items.Clear();
        ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlWorkOrderActivity.Items.Clear();
        ddlWorkOrderActivity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlWorkOrder.Items.Clear();
        ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });

    }
    protected void ddlWareHouse_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlWareHouse.SelectedIndex > 0)
        {
            BindCompanyGroup(0);          
            ddlCustomer.Items.Clear();
            ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlWorkOrder.Items.Clear();
            ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });            
            clearWoActiviyDropDown();
        }
        else
        {
            ddlCompanyGroup.Items.Clear();           
            ddlCustomer.Items.Clear();
            ddlCustomer.DataSource = null;
            ddlCustomer.DataBind();
            ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlCompanyGroup.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlWorkOrder.Items.Clear();
            ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            clearWoActiviyDropDown();            
        }       
    }
    protected void clearWoActiviyDropDown()
    {
        ddlWorkOrderActivity.Items.Clear();
        ddlWorkOrderActivity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        txtnoofservices.Text = string.Empty;
        txtRemark.Text = string.Empty;
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Clear();
        lblMessage.Text = "";
    }
    #region [Rolewise access page funcationality]
    public void SetRolewiseAcessfuncationality()
    {
        UserRolewiseAcess objUserRoleWiseAcessDAL = new UserRolewiseAcess();
        DataTable dtPageId = objUserRoleWiseAcessDAL.GetApplicationCodeDetails("Page_Name", "Other Services").Tables[0];
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
    protected void ddlWorkOrderActivity_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtAmount.Text = ""; 
        if (ddlWorkOrderActivity.SelectedIndex > 0)
        {
            int iFileCount = 0;
            int iactivityId = 0;
            if (ViewState["dsWorkOrderActivity"] != null)
            {
                DataTable dtactivityid = (DataTable)ViewState["dsWorkOrderActivity"];
                if (dtactivityid != null)
                {
                    if (dtactivityid.Rows.Count > 0)
                    {
                        string strexp = "WoActivityId=" + Convert.ToString(ddlWorkOrderActivity.SelectedValue);
                        DataRow[] dr = dtactivityid.Select(strexp);
                        if (dr.Length > 0)
                        {
                        iFileCount = Convert.ToInt32(dr[0]["FileCount"].ToString());
                        iactivityId =Convert.ToInt32( dr[0]["Activityid"].ToString());
                        txtnoofservices.Text = iFileCount.ToString();
                        }
                    }
                }

            }

            DataSet dsRate = objPRSMBAL.GetRateCard(Convert.ToInt32(ddlCustomer.SelectedValue), Convert.ToInt32(iactivityId));
            if (dsRate.Tables[0].Rows.Count > 0)
            {
                txtAmount.Text = dsRate.Tables[0].Rows[0]["Rate"].ToString();
            }

        }
    }
}