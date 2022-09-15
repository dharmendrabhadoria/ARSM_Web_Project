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
            BindRackMaster();
            BindDdlWareHouse();
            ddlWareHouse.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            SetRolewiseAcessfuncationality();
            ddlWareHouse.Focus();
        }
    }


    protected void BindRackMaster()
    {
        gvRackMst.DataSource = objPRSMBAL.GetRackMaster(0);
        gvRackMst.DataBind();
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
                Int16 iRackId = Convert.ToInt16(ViewState["RackId"]);
                Int16 iNoOfShelf = Convert.ToInt16(txtnoshelf.Text.Trim());
                Int16 iNoOfBoxePerShelf = Convert.ToInt16(txttotalboxpershelf.Text.Trim());

                int IsRackExist = objPRSMBAL.AddUpdateRackMaster(new RackMaster
                {
                    RackId = iRackId,
                    RowName = txtrowName.Text.Trim(),
                    WareHouseId = Convert.ToInt16(ddlWareHouse.SelectedItem.Value.ToString().Trim()),
                    NoOfShelf = iNoOfShelf,
                    NoOfBoxePerShelf = iNoOfBoxePerShelf,
                    BoxStartNo = Convert.ToInt32(txtboxStartNo.Text),                  
                    Remark = txtRemark.Text,
                    Width = Convert.ToDecimal(txtwidth.Text.Trim()),
                    Height = Convert.ToDecimal(txtHeight.Text.Trim()),
                    Depth = Convert.ToDecimal(txtDepth.Text.Trim()),
                    UserId = UserId,
                    NoofRacks = Convert.ToInt32(txtNoofRacks.Text),
                    RowId = Convert.ToInt16(txtRowId.Text),
                    BoxEndNo = Convert.ToInt32(txtBoxEndNo.Text)
                });

                if (IsRackExist == -1)
                {
                    lblMessage.Visible = true;
                    lblMessage.Text = "Row Name Already Exists.";
                    txtrowName.Focus();
                }
                else
                {
                  
                    lblMessage.Visible = true;
                    lblMessage.Text = "Record saved successfully.";
                    clear();
                    BindRackMaster();
                }
            }
            catch (Exception ex)
            {
                lblMessage.Visible = true;
                lblMessage.Text = ex.ToString();
                ErrorHandler.WriteLog(ex);
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "GetBoxEndNo(null);", true);
        }
    }
    
    public void clear()
    {
        ViewState["RackId"] = 0;
        txtrowName.Text = string.Empty;
        txtBoxEndNo.Text = string.Empty;
        ddlWareHouse.SelectedIndex = 0;
        txtboxStartNo.Text = string.Empty;
        txtHeight.Text = string.Empty;
        txtRemark.Text = string.Empty;
        txttotalboxpershelf.Text = string.Empty;
        txtwidth.Text = string.Empty;
        txtDepth.Text = string.Empty;
        txtnoshelf.Text = string.Empty;
        txtNoofRacks.Text = string.Empty;
        txtTotalboxes.Text = string.Empty;
        txtBoxEndNo.Text = string.Empty;
        txtRowId.Text = string.Empty;    
       
       
    }
    protected void gvRackMst_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        
        if (e.CommandName == "EdtRack")
        {
            ViewState["RackId"] = Convert.ToInt32(e.CommandArgument.ToString());
            DataSet ds = objPRSMBAL.GetRackMaster(Convert.ToInt16(e.CommandArgument.ToString()));
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    txtrowName.Text = Convert.ToString(ds.Tables[0].Rows[0]["RowName"]);
                    ddlWareHouse.SelectedIndex = ddlWareHouse.Items.IndexOf(ddlWareHouse.Items.FindByText(ds.Tables[0].Rows[0]["WareHouseName"].ToString()));
                    txtnoshelf.Text = ds.Tables[0].Rows[0]["NoofShelf"].ToString();
                    txttotalboxpershelf.Text = ds.Tables[0].Rows[0]["NoofBoxesPerShelf"].ToString();
                    txtboxStartNo.Text = ds.Tables[0].Rows[0]["BoxStartNo"].ToString();
                    Int16 iNoOfShelf = Convert.ToInt16(ds.Tables[0].Rows[0]["NoofShelf"].ToString());
                    Int16 iNoOfBoxOnShelf = Convert.ToInt16(ds.Tables[0].Rows[0]["NoofBoxesPerShelf"].ToString());
                    int iStartNo = Convert.ToInt32(ds.Tables[0].Rows[0]["BoxStartNo"].ToString())-1;
                    int iStartEndNo = iNoOfShelf * iNoOfBoxOnShelf + iStartNo;
                    txtBoxEndNo.Text = iStartEndNo.ToString();
                    txtTotalboxes.Text = iStartEndNo.ToString();
                    txtRemark.Text = ds.Tables[0].Rows[0]["Remark"].ToString();
                    txtHeight.Text = ds.Tables[0].Rows[0]["Height"].ToString();
                    txtwidth.Text = ds.Tables[0].Rows[0]["Width"].ToString();
                    txtDepth.Text = ds.Tables[0].Rows[0]["Depth"].ToString();
                    UserId = Convert.ToInt32(ds.Tables[0].Rows[0]["UserId"].ToString());
                    txtNoofRacks.Text = ds.Tables[0].Rows[0]["NoofRacks"].ToString();
                }
            }
            lblMessage.Visible = false;
        }
    }

  
    protected void gvRackMst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvRackMst.PageIndex = e.NewPageIndex;
        BindRackMaster();
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
        if (gvRackMst.Rows.Count > 0 && IsEditGrid == false)
        {
            for (int i = 0; i < gvRackMst.Rows.Count; i++)
            {
                LinkButton lnkbtnEdit = (LinkButton)gvRackMst.Rows[i].FindControl("lnkbtnEdit");
                if (lnkbtnEdit != null)
                {
                    lnkbtnEdit.Visible = false;
                }
            }
        }
    }
    #endregion


    protected void ddlWareHouse_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlWareHouse.SelectedIndex == 0)
        {
            txtRowId.Text = string.Empty;
            txtboxStartNo.Text = string.Empty;
            clear();
        }
        else
        {
            DataSet dsGetMaxWarehouseRowNumber= objPRSMBAL.GetMaxWarehouseRowNumberAndBoxStartNo(Convert.ToInt16(ddlWareHouse.SelectedItem.Value));
            txtboxStartNo.Text = string.Empty;
            txtRowId.Text      = string.Empty;
            if (dsGetMaxWarehouseRowNumber != null)
            {
                if (dsGetMaxWarehouseRowNumber.Tables.Count > 0)
                {
                    txtRowId.Text       = Convert.ToString(dsGetMaxWarehouseRowNumber.Tables[0].Rows[0]["RowId"]);
                    txtboxStartNo.Text  = Convert.ToString(dsGetMaxWarehouseRowNumber.Tables[0].Rows[0]["BoxStartNo"]);
                }
            }
        }
    }
}