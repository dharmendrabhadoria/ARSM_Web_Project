using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UserRoleWiseAcess;
using PRSMBAL;
using Entity;
using System.Data;
using Utility;

public partial class Master_WareHouse : PageBase
{
    MasterBAL objPRSMBAL = new MasterBAL();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (UserId == 0)
            Response.Redirect("~/User/Login.aspx");

        if (!IsPostBack)
        {
            ViewState["WareHouseId"] = "0";
            ViewState["SrNo"] = -1;
            BindState();
            ddlCity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            BindGrid();
            ViewState["RackId"] = "0";
            txtboxStartNo.Text = "1";
            txtboxStartNo.Enabled = false;
            txtBoxEndNo.Enabled = false;
            txtTotalboxes.Enabled = false;
            SetRolewiseAcessfuncationality();
            txtwareHouseName.Focus(); 
        }
    }

    protected void BindState()
    {
        ddlState.DataSource = objPRSMBAL.GetState(0);
        ddlState.DataTextField = "StateName";
        ddlState.DataValueField = "StateId";
        ddlState.DataBind();
        ddlState.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }

    protected void BindCityByState(int StateId)
    {
        if (StateId > 0)
        {
            ddlCity.DataSource = null;
            ddlCity.DataSource = objPRSMBAL.GetCity(StateId);
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

    protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlState.SelectedItem.Value != null)
        {
            int StateId = Convert.ToInt32(ddlState.SelectedItem.Value);
            BindCityByState(StateId);
        }
        ddlCity.Focus();
    }

    private void BindGrid()
    {
        grdWareHouse.DataSource = objPRSMBAL.GetWareHouse(0);
        grdWareHouse.DataBind();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {       
        if (Page.IsValid)
        {
                try
                {
                    int  IsWareHouseExist = objPRSMBAL.AddUpdateWareHouseMaster(new WareHouse
                    {
                        WareHouseId = Convert.ToInt32(ViewState["WareHouseId"].ToString()),
                        WarehouseName = txtwareHouseName.Text.Trim(),
                        WarehouseCode = txtCode.Text,
                        TotalRows = Convert.ToInt32(txttotalRows.Text),
                        Address = "",
                        StateId = Convert.ToInt32(ddlState.SelectedValue),
                        CityId = Convert.ToInt32(ddlCity.SelectedValue),
                        UserId = UserId,
                        Address1=Convert.ToString(txtwareHouseAddress1.Text.Trim()),
                        Address2=Convert.ToString(txtwareHouseAddress2.Text.Trim())
                    });
                    if (IsWareHouseExist == -1)
                    {
                        lblMessage.Text = "Warehouse Name Already Exists.";
                        txtwareHouseName.Focus();
                    }
                    else
                    {
                        AddRacks(Convert.ToInt16(IsWareHouseExist));
  
                        lblMessage.Text = "Record saved successfully.";
                        Reset();
                        BindGrid();
                    }
                    lblMessage.Visible = true;
                }
                catch (Exception ex)
                {
                    lblMessage.Visible = true;
                    lblMessage.Text = ex.ToString();
                    ErrorHandler.WriteLog(ex);
                }
       
       
        }
    }

    public void AddRacks(Int16 IsWareHouseExist)
    {

        try
        {
            DataTable dtRackMaster = tblAddEditRackRecord();
            foreach (DataRow dr in dtRackMaster.Rows)
            {
                int IsRackExist = objPRSMBAL.AddUpdateRackMaster(new RackMaster
                {
                    RackId = 0,
                    RowName = dr["RowName"].ToString(),
                    WareHouseId = IsWareHouseExist,
                    NoOfShelf = Convert.ToInt16(dr["NoofShelf"].ToString()),
                    NoOfBoxePerShelf = Convert.ToInt16(dr["NoofBoxesPerShelf"].ToString()),
                    BoxStartNo = Convert.ToInt16(dr["BoxStartNo"].ToString()),
                    Remark = dr["Remark"].ToString(),
                    Width = Convert.ToDecimal(dr["Width"].ToString()),
                    Height = Convert.ToDecimal(dr["Height"].ToString()),
                    Depth = Convert.ToDecimal(dr["Depth"].ToString()),
                    UserId = UserId,
                    NoofRacks = Convert.ToInt32(dr["NoofRacks"].ToString())
                });
            }
        }
        catch (Exception ex)
        {
            lblMessageRack.Visible = true;
            lblMessageRack.Text = ex.ToString();
            ErrorHandler.WriteLog(ex);
        }

    
    }
    protected void grdWareHouse_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EdtWareHouse")
        {
            lblMessage.Visible = false;
            if (txtBoxEndNo.Text.Trim() != "")
                txtBoxEndNo.Text = "";
            ViewState["WareHouseId"] = Convert.ToInt32(e.CommandArgument.ToString());
            GridViewRow gr = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
            txtwareHouseName.Text = ((Label)gr.FindControl("lblName")).Text;
            txtCode.Text = ((Label)gr.FindControl("lblCode")).Text;
            txttotalRows.Text = ((Label)gr.FindControl("lblTotalRacks")).Text;
            Label lblAddress1 = (Label)gr.FindControl("lblAddress1");
            txtwareHouseAddress1.Text =lblAddress1.Text;
            Label lblAddress2 = (Label)gr.FindControl("lblAddress2");
            txtwareHouseAddress2.Text = lblAddress2.Text;
            ddlState.SelectedValue = ((Label)gr.FindControl("lblStateId")).Text;
            BindCityByState(Convert.ToInt32(ddlState.SelectedValue));
            ddlCity.SelectedValue = ((Label)gr.FindControl("lblCityId")).Text;
            BindRackMaster();
        }
    }

    private void Reset()
    {
        ViewState["WareHouseId"] = "0";
        ViewState["SrNo"] = -1;
        txtwareHouseName.Text = "";
        txtCode.Text = "";
        txttotalRows.Text = "";
        ddlState.SelectedIndex = 0;
        ddlCity.Items.Clear();
        ddlCity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        txtCode.Text = "";
        txtwareHouseAddress1.Text = string.Empty;
        txtwareHouseAddress2.Text = string.Empty;
        gvRackMst.DataSource = null;
        gvRackMst.DataBind();
    }

    protected void grdWareHouse_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdWareHouse.PageIndex = e.NewPageIndex;
        BindGrid();
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Reset();
        lblMessage.Visible = false;
    }
    #region temporary table for rack master
    public DataTable tblAddEditRackRecord()
    {
        DataTable dtRackMaster = new DataTable();
        if (ViewState["Rack"] == null)
        {
            dtRackMaster.Columns.Add("SrNo", typeof(int)).AutoIncrement = true;
            dtRackMaster.Columns["SrNo"].AutoIncrementSeed = 0;
            dtRackMaster.Columns.Add("RackId", typeof(int));
            dtRackMaster.Columns.Add("RowName", typeof(string));
            dtRackMaster.Columns.Add("WareHouseId", typeof(Int16));
            dtRackMaster.Columns.Add("WareHouseName", typeof(string));
            dtRackMaster.Columns.Add("NoofShelf", typeof(Int16));
            dtRackMaster.Columns.Add("NoofBoxesPerShelf", typeof(Int16));
            dtRackMaster.Columns.Add("BoxStartNo", typeof(Int16));
            dtRackMaster.Columns.Add("Remark", typeof(string));
            dtRackMaster.Columns.Add("Height", typeof(decimal));
            dtRackMaster.Columns.Add("Width", typeof(decimal));
            dtRackMaster.Columns.Add("Depth", typeof(decimal));
            dtRackMaster.Columns.Add("NoofRacks", typeof(int));

        }
        else
        {
            dtRackMaster = (DataTable)ViewState["Rack"];
        }
        return dtRackMaster;
    }

    public void AddRackMaster(int iSrNo, int iRackId, string sRowName, Int16 iWareHouseId, string sWareHouseName, Int16 iNoOfself, Int16 iNoofBoxPerself, Int16 iBoxStartNo, string sRemark, decimal dHeight, decimal dWidth, decimal dDepth, int iNoOfRacks)
    {
        DataTable dtRackMaster;
        DataRow drRackMaster;
        dtRackMaster = tblAddEditRackRecord();
        try
        {
            drRackMaster = dtRackMaster.NewRow();
            if (iSrNo == -1)
            {
                drRackMaster["RackId"] = iRackId;
                drRackMaster["RowName"] = sRowName;
                drRackMaster["WareHouseId"] = iWareHouseId;
                drRackMaster["WareHouseName"] = sWareHouseName;
                drRackMaster["NoofShelf"] = iNoOfself;
                drRackMaster["NoofBoxesPerShelf"] = iNoofBoxPerself;
                drRackMaster["BoxStartNo"] = iBoxStartNo;
                drRackMaster["Remark"] = sRemark;
                drRackMaster["Height"] = dHeight;
                drRackMaster["Width"] = dWidth;
                drRackMaster["Depth"] = dDepth;
                drRackMaster["NoofRacks"] = iNoOfRacks;
                dtRackMaster.Rows.Add(drRackMaster);
                dtRackMaster.AcceptChanges();
            }
            else
            {
                dtRackMaster.Rows[iSrNo]["RackId"] = iRackId;
                dtRackMaster.Rows[iSrNo]["RowName"] = sRowName;
                dtRackMaster.Rows[iSrNo]["WareHouseId"] = iWareHouseId;
                dtRackMaster.Rows[iSrNo]["WareHouseName"] = sWareHouseName;
                dtRackMaster.Rows[iSrNo]["NoofShelf"] = iNoOfself;
                dtRackMaster.Rows[iSrNo]["NoofBoxesPerShelf"] = iNoofBoxPerself;
                dtRackMaster.Rows[iSrNo]["BoxStartNo"] = iBoxStartNo;
                dtRackMaster.Rows[iSrNo]["Remark"] = sRemark;
                dtRackMaster.Rows[iSrNo]["Height"] = dHeight;
                dtRackMaster.Rows[iSrNo]["Width"] = dWidth;
                dtRackMaster.Rows[iSrNo]["Depth"] = dDepth;
                dtRackMaster.Rows[iSrNo]["NoofRacks"] = iNoOfRacks;
                dtRackMaster.AcceptChanges();
            }
            ViewState["Rack"] = dtRackMaster;
        }
        catch (Exception ex)
        {
            //  throw;
        }
    }
    #endregion temporary table for rack master



    #region [Rack Events and Functions]
    protected void BindRackMaster()
    {
        gvRackMst.DataSource = objPRSMBAL.GetRackMasterByWareHouseId(Convert.ToInt16(ViewState["WareHouseId"].ToString()));
        gvRackMst.DataBind();
    }

    protected void gvRackMst_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EdtRack")
        {
            DataTable dtRackMaster = tblAddEditRackRecord();
            ViewState["SrNo"] = "0";
            if (ViewState["WareHouseId"].ToString() == "0")
            {
                DataTable dtFiltered = dtRackMaster.AsEnumerable().Where(FindRow => FindRow.Field<int>("RackId") == Convert.ToInt32(e.CommandArgument.ToString())).CopyToDataTable();
                ViewState["SrNo"] = Convert.ToInt32(dtFiltered.Rows[0]["SrNo"].ToString()); 
                txtrackName.Text = Convert.ToString(dtFiltered.Rows[0]["RowName"]);
                txtnoshelf.Text = dtFiltered.Rows[0]["NoofShelf"].ToString();
                txttotalboxpershelf.Text = dtFiltered.Rows[0]["NoofBoxesPerShelf"].ToString();
                txtboxStartNo.Text = dtFiltered.Rows[0]["BoxStartNo"].ToString();
                Int16 iNoOfShelf = Convert.ToInt16(dtFiltered.Rows[0]["NoofShelf"].ToString());
                Int16 iNoOfBoxOnShelf = Convert.ToInt16(dtFiltered.Rows[0]["NoofBoxesPerShelf"].ToString());
                int iStartNo = Convert.ToInt32(dtFiltered.Rows[0]["BoxStartNo"].ToString());
                int iStartEndNo = iNoOfShelf * iNoOfBoxOnShelf + iStartNo;
                txtBoxEndNo.Text = iStartEndNo.ToString();
                txtTotalboxes.Text = iStartEndNo.ToString();
                txtRemark.Text = dtFiltered.Rows[0]["Remark"].ToString();
                txtHeight.Text = dtFiltered.Rows[0]["Height"].ToString();
                txtwidth.Text = dtFiltered.Rows[0]["Width"].ToString();
                txtDepth.Text = dtFiltered.Rows[0]["Depth"].ToString();
                txtNoofRacks.Text = dtFiltered.Rows[0]["NoofRacks"].ToString();
            }
            else
            {
                ViewState["RackId"] = Convert.ToInt32(e.CommandArgument.ToString());
                DataSet ds = objPRSMBAL.GetRackMaster(Convert.ToInt16(e.CommandArgument.ToString()));
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        txtrackName.Text = Convert.ToString(ds.Tables[0].Rows[0]["RowName"]);
                        txtnoshelf.Text = ds.Tables[0].Rows[0]["NoofShelf"].ToString();
                        txttotalboxpershelf.Text = ds.Tables[0].Rows[0]["NoofBoxesPerShelf"].ToString();
                        txtboxStartNo.Text = ds.Tables[0].Rows[0]["BoxStartNo"].ToString();
                        Int16 iNoOfShelf = Convert.ToInt16(ds.Tables[0].Rows[0]["NoofShelf"].ToString());
                        Int16 iNoOfBoxOnShelf = Convert.ToInt16(ds.Tables[0].Rows[0]["NoofBoxesPerShelf"].ToString());
                        int iStartNo = Convert.ToInt32(ds.Tables[0].Rows[0]["BoxStartNo"].ToString());
                        int iStartEndNo = iNoOfShelf * iNoOfBoxOnShelf + iStartNo;
                        txtBoxEndNo.Text = iStartEndNo.ToString();
                        txtTotalboxes.Text = iStartEndNo.ToString();
                        txtRemark.Text = ds.Tables[0].Rows[0]["Remark"].ToString();
                        txtHeight.Text = ds.Tables[0].Rows[0]["Height"].ToString();
                        txtwidth.Text = ds.Tables[0].Rows[0]["Width"].ToString();
                        txtDepth.Text = ds.Tables[0].Rows[0]["Depth"].ToString();
                        txtNoofRacks.Text = ds.Tables[0].Rows[0]["NoofRacks"].ToString();
                    }
                }
            }
            lblMessageRack.Visible = false;
        }
    }

    protected void gvRackMst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvRackMst.PageIndex = e.NewPageIndex;
        BindRackMaster();
    }

    protected void BindRackGrid()
    {
        DataTable dtRackMaster = (DataTable)ViewState["Rack"];
        if (dtRackMaster != null)
        {
            if (dtRackMaster.Rows.Count > 0)
            {
                gvRackMst.DataSource = dtRackMaster;
                gvRackMst.DataBind();
            }
        }
    }

    protected void btnSaveRack_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            lblMessage.Visible = false;
            if (ViewState["WareHouseId"].ToString() == "0")
            {
                DataSet ds = objPRSMBAL.GetRackMaster(0);
                int CheckRackName = ds.Tables[0].AsEnumerable().Where(p => p.Field<string>("RowName") == txtrackName.Text.Trim()).Count();
                if (CheckRackName < 1)
                {
                    lblMessageRack.Visible = false;
                    AddRackMaster(Convert.ToInt32(ViewState["SrNo"]), Convert.ToInt32(ViewState["RackId"]), txtrackName.Text.Trim(), 0, "Not Available", Convert.ToInt16(txtnoshelf.Text.Trim()),
                        Convert.ToInt16(txttotalboxpershelf.Text.Trim()), 1, txtRemark.Text, Convert.ToDecimal(txtHeight.Text.Trim()), Convert.ToDecimal(txtwidth.Text.Trim()), Convert.ToDecimal(txtDepth.Text.Trim()), Convert.ToInt32(txtNoofRacks.Text));
                    BindRackGrid();
                    clear();
                }
                else
                {
                    lblMessageRack.Visible = true;
                    lblMessageRack.Text = "Rack Name Already Exists.";
                    txtrackName.Focus();
                }
            }
            else
            {
                try
                {
                    Int16 iRackId = Convert.ToInt16(ViewState["RackId"]);
                    Int16 iNoOfShelf = Convert.ToInt16(txtnoshelf.Text.Trim());
                    Int16 iNoOfBoxePerShelf = Convert.ToInt16(txttotalboxpershelf.Text.Trim());

                    int IsRackExist = objPRSMBAL.AddUpdateRackMaster(new RackMaster
                    {
                        RackId = iRackId,
                        RowName = txtrackName.Text.Trim(),
                        WareHouseId = Convert.ToInt16(ViewState["WareHouseId"].ToString()),
                        NoOfShelf = iNoOfShelf,
                        NoOfBoxePerShelf = iNoOfBoxePerShelf,
                        BoxStartNo = Convert.ToInt32(txtboxStartNo.Text),
                        Remark = txtRemark.Text,
                        Width = Convert.ToDecimal(txtwidth.Text.Trim()),
                        Height = Convert.ToDecimal(txtHeight.Text.Trim()),
                        Depth = Convert.ToDecimal(txtDepth.Text.Trim()),
                        UserId = UserId,
                        NoofRacks = Convert.ToInt32(txtNoofRacks.Text)
                    });

                    if (IsRackExist == -1)
                    {
                        lblMessageRack.Visible = true;
                        lblMessageRack.Text = "Rack Name Already Exists.";
                        txtrackName.Focus();
                    }
                    else
                    {
                        lblMessageRack.Visible = true;
                        lblMessageRack.Text = "Record saved successfully.";
                        clear();
                        BindRackMaster();
                    }
                }
                catch (Exception ex)
                {
                    lblMessageRack.Visible = true;
                    lblMessageRack.Text = ex.ToString();
                    ErrorHandler.WriteLog(ex);
                }
            }
        }
        else
      lblMessageRack.Text = "";

    }

    protected void btnCancelRack_Click(object sender, EventArgs e)
    {
        lblMessageRack.Text = "";
        clear();

    }

    public void clear()
    {
        ViewState["RackId"] = "0";
        ViewState["SrNo"] = -1;
        txtrackName.Text = string.Empty;
        txtBoxEndNo.Text = string.Empty;
        txtHeight.Text = string.Empty;
        txtRemark.Text = string.Empty;
        txttotalboxpershelf.Text = string.Empty;
        txtwidth.Text = string.Empty;
        txtDepth.Text = string.Empty;
        txtnoshelf.Text = string.Empty;
        txtNoofRacks.Text = string.Empty;
    }
    #endregion

    #region [Rolewise access page funcationality]
    public void SetRolewiseAcessfuncationality()
    {
        UserRolewiseAcess objUserRoleWiseAcessDAL = new UserRolewiseAcess();
        DataTable dtPageId = objUserRoleWiseAcessDAL.GetApplicationCodeDetails("Page_Name", "WareHouse").Tables[0];
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
        if (grdWareHouse.Rows.Count > 0 && IsEditGrid == false)
        {
            for (int i = 0; i < grdWareHouse.Rows.Count; i++)
            {
                LinkButton imgEdit = (LinkButton)grdWareHouse.Rows[i].FindControl("lnkbtnEdit");
                if (imgEdit != null)
                {
                    imgEdit.Visible = false;
                }
            }
        }
    }
    #endregion

}