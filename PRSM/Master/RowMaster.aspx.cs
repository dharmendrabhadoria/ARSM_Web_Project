using System;
using System.Data;
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


public partial class Master_Rack : PageBase
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
            ViewState["RackId"] = 0;
            BindRowMaster();
            BindDdlWareHouse();
            ddlWareHouse.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            SetRolewiseAcessfuncationality();
            txtrowName.Focus();
        }
    }


    protected void BindRowMaster()
    {
        gvRowMaster.DataSource = objPRSMBAL.GetRowMaster(0,0);
        gvRowMaster.DataBind();
    }

    private void BindDdlWareHouse()
    {
        ddlWareHouse.DataSource = objPRSMBAL.GetWareHouse(0);
        ddlWareHouse.DataValueField = "WareHouseId";
        ddlWareHouse.DataTextField = "WarehouseName";
        ddlWareHouse.DataBind();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            try
            {
                int cRowId = Convert.ToInt32(ViewState["RowId"]);
                string cRowName = txtrowName.Text.ToString().Trim();

                Int16 iRowId = 0;
                if (ViewState["RowId"] != null)
                {
                    iRowId = Convert.ToInt16(ViewState["RowId"].ToString());
                }
                Int16 iNoOfShelf = Convert.ToInt16(txtnoshelf.Text.Trim());
                Int16 iNoOfLocationPerSelf = Convert.ToInt16(txtNofLocationPerSelf.Text.Trim());

                Int16 ChekUserExist = objPRSMBAL.IsRowMasterNameExist(cRowId, cRowName,Convert.ToInt32(ddlWareHouse.SelectedValue));
                if (ChekUserExist == 2)
                {
                    string Msg = "Duplicate Row Id found in this WareHouse. ";
                    lblMessage.Text = Msg;
                    return;
                }
                string sReturnValue = objPRSMBAL.AddUpdateRowMaster(new RowMaster
                {
                    RowId = iRowId,
                    RowName = txtrowName.Text.Trim(),
                    WareHouseId = Convert.ToInt16(ddlWareHouse.SelectedItem.Value.ToString().Trim()),
                    NoofShelf = iNoOfShelf,
                    NoOfLocationPerSelf = iNoOfLocationPerSelf,
                    Remark = txtRemark.Text,
                    UserId = Convert.ToInt16(UserId),
                });

               if (sReturnValue == "Record saved successfully.")
                {
                    lblMessage.Text = sReturnValue;
                   clear();
                }
                BindRowMaster();
               
            }
            catch (Exception ex)
            {
                lblMessage.Visible = true;
                lblMessage.Text = ex.ToString();
                ErrorHandler.WriteLog(ex);
            }
        }
        
    }
    
    public void clear()
    {
        ViewState["RackId"] = 0;
        txtrowName.Text = string.Empty;
        ddlWareHouse.SelectedIndex = 0;
        txtRemark.Text = string.Empty;
        txtNofLocationPerSelf.Text = string.Empty;
        txtnoshelf.Text = string.Empty;
    }
    protected void gvRowMaster_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        if (e.CommandName == "EdtRowMastger")
        {
            ViewState["RowId"] = Convert.ToInt32(e.CommandArgument.ToString());
            GridViewRow gvRowMaster = (GridViewRow)((LinkButton)e.CommandSource).NamingContainer;
            Label lblRowName = (Label)gvRowMaster.FindControl("lblRowName");
            Label lblNoofLocationPerSelf = (Label)gvRowMaster.FindControl("lblNoofLocationPerSelf");
            Label lblWareHouseId = (Label)gvRowMaster.FindControl("lblWareHouseId");
            Label lblNoofShelf = (Label)gvRowMaster.FindControl("lblNoofShelf");
            Label lblRemork = (Label)gvRowMaster.FindControl("lblRemork");
            Label lb1WareHouseName = (Label)gvRowMaster.FindControl("lb1WareHouseName");

            ddlWareHouse.SelectedIndex = ddlWareHouse.Items.IndexOf(ddlWareHouse.Items.FindByValue(lblWareHouseId.Text.ToString()));
            txtrowName.Text = lblRowName.Text;
            txtnoshelf.Text = lblNoofShelf.Text;
            txtNofLocationPerSelf.Text = lblNoofLocationPerSelf.Text;
            txtRemark.Text = lblRemork.Text;
            lb1WareHouseName.Text = ddlWareHouse.SelectedValue.ToString();
            lblMessage.Visible = false;
        }
    }


    protected void gvRowMaster_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvRowMaster.PageIndex = e.NewPageIndex;
        BindRowMaster();
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        clear();
        lblMessage.Text = string.Empty;
    }
    #region [Rolewise access page funcationality]
    public void SetRolewiseAcessfuncationality()
    {
        UserRolewiseAcess objUserRoleWiseAcessDAL = new UserRolewiseAcess();
        DataTable dtPageId = objUserRoleWiseAcessDAL.GetApplicationCodeDetails("Page_Name", "Rack").Tables[0];
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
        if (gvRowMaster.Rows.Count > 0 && IsEditGrid == false)
        {
            for (int i = 0; i < gvRowMaster.Rows.Count; i++)
            {
                LinkButton lnkbtnEdit = (LinkButton)gvRowMaster.Rows[i].FindControl("lnkbtnEdit");
                if (lnkbtnEdit != null)
                {
                    lnkbtnEdit.Visible = false;
                }
            }
        }
    }
    #endregion


   
}