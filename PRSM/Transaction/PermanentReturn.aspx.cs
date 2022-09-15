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
using Entity;
using System.Web.SessionState;
using System.IO;
using UserRoleWiseAcess;
using System.Text;


public partial class Transaction_PermanentReturn : PageBase
{
    TransactionBAL objTransactionBAL = new TransactionBAL();
    MasterBAL objPRSMBAL = new MasterBAL();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (UserId == 0)
        {
            Response.Redirect("~/User/Login.aspx", false);
        }
        if (!IsPostBack)
        {
            NewInwardOutward();
            ddlWorkOrderActivity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            SetRolewiseAcessfuncationality();
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Status"> Open,Closed</param>
    /// <returns></returns>
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
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Status"> Open,Closed</param>
    /// <returns></returns>
    protected Int16 GetWorkActivityStatus(string Status)
    {
        DataSet ds = objPRSMBAL.GetApplicationCodeDetails("ACTIVITY_STATUS", "");
        Int16 istatus = 0;
        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
        {
            if (Convert.ToString(ds.Tables[0].Rows[i]["AppCodeName"]).ToUpper() == Status.ToUpper())
            {
                istatus = Convert.ToInt16(ds.Tables[0].Rows[i]["AppCodeId"]);
                break;
            }
        }
        return istatus;
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Status">In,Out,Permanent Out,Destroy</param>
    /// <returns></returns>
    protected Int16 GetBoxFileStatus(string Status)
    {
        DataSet ds = objPRSMBAL.GetApplicationCodeDetails("BOXFILE_STATUS", "");
        Int16 istatus = 0;
        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
        {
            if (Convert.ToString(ds.Tables[0].Rows[i]["AppCodeName"]).ToUpper() == Status.ToUpper())
            {
                istatus = Convert.ToInt16(ds.Tables[0].Rows[i]["AppCodeId"]);
                break;
            }
        }
        return istatus;
    }
    protected void NewInwardOutward()
    {
        divInward.Style["display"] = "block";
        BindCompanyGroup(0);
        ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        BindDdlWareHouse();

    }
    protected void BindCompanyGroup(int iCompanyId)
    {

        ddlCompanyGroup.DataSource = null;
        ddlCompanyGroup.DataBind();
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
    protected void BindDdlWareHouse()
    {
        ddlWareHouse.DataSource = objPRSMBAL.GetWareHouse(0);
        ddlWareHouse.DataValueField = "WareHouseId";
        ddlWareHouse.DataTextField = "WarehouseName";
        ddlWareHouse.DataBind();
        ddlWareHouse.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }

    protected void ddlCompanyGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlCompanyGroup.SelectedIndex > 0)
        {
            BindCustomer(Convert.ToByte(ddlCompanyGroup.SelectedItem.Value));
            ddlWorkOrder.Items.Clear();
            ddlWorkOrderActivity.Items.Clear();
            ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlWorkOrderActivity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
        else
        {
            ddlCustomer.Items.Clear();
            ddlCustomer.DataSource = null;
            ddlCustomer.DataBind();
            ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlWorkOrder.Items.Clear();
            ddlWorkOrderActivity.Items.Clear();
            ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlWorkOrderActivity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
    }

    #region -------GEt Box Details
    protected void BindBoxdetails(int iWorkOrderNumber, int iWoActivityId, Int16 Isboxfile)
    {
        grdBoxDetails.DataSource = null;
        grdBoxDetails.DataBind();
        DataSet dsboxdetails = objTransactionBAL.GetRetrivalBoxFileDetails(iWorkOrderNumber, iWoActivityId, Isboxfile,0);
        if (dsboxdetails.Tables[0].Rows.Count > 0)
        {
            grdBoxDetails.DataSource = dsboxdetails.Tables[0];
            grdBoxDetails.DataBind();
        }
        else
        {
            divInwardBoxes.Style.Add("display", "none");
            divInwardFiles.Style.Add("display", "none");
            ViewState["FileDetails"] = null;
            ViewState["BoxDetails"] = null;
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('No Box Found')", true);
        }
    }
    #endregion

    #region -----Get--[Files]-------------

    protected void Bindfiledetails(int iWorkOrderNumber, int iWoActivityId, Int16 Isboxfile)
    {
        grdFilesDetails.DataSource = null;
        grdFilesDetails.DataBind();
        DataSet dsFileDetails = objTransactionBAL.GetRetrivalBoxFileDetails(iWorkOrderNumber, iWoActivityId, Isboxfile,0);
        if (dsFileDetails.Tables[0].Rows.Count > 0)
        {
            grdFilesDetails.DataSource = dsFileDetails.Tables[0];
            grdFilesDetails.DataBind();
        }
        else
        {
            divInwardBoxes.Style.Add("display", "none");
            divInwardFiles.Style.Add("display", "none");
            ViewState["FileDetails"] = null;
            ViewState["BoxDetails"] = null;
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('No File Found')", true);
        }
    }

    #endregion
    protected void ddlCustomer_SelectedIndexChanged(object sender, EventArgs e)
    {
        Int16 iStatus = GetWorkStatus("Open");
        ddlWorkOrder.DataSource = null;

        if (ddlCustomer.SelectedIndex > 0)
        {
            int iCompgroupId = Convert.ToInt32(ddlCompanyGroup.SelectedItem.Value);
            ddlWorkOrder.Items.Clear();
            ddlWorkOrder.DataSource = null;
            ddlWorkOrder.DataBind();
            DataSet dsTransactionBAL = objTransactionBAL.GetWorkOrder(0,iCompgroupId, Convert.ToInt32(ddlCustomer.SelectedValue),
            Convert.ToInt16(ddlWareHouse.SelectedValue), iStatus, null, null);
            ddlWorkOrder.DataSource = dsTransactionBAL.Tables[0];
            ddlWorkOrder.DataValueField = "WorkorderNo";
            ddlWorkOrder.DataTextField = "WorkorderNo";
            ddlWorkOrder.DataBind();
            ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
        else
        {
            ddlWorkOrder.Items.Clear();
            ddlWorkOrder.DataSource = null;
            ddlWorkOrder.DataBind();
            ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlWorkOrderActivity.Items.Clear();
            ddlWorkOrderActivity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
    }
    protected void ddlWorkOrder_SelectedIndexChanged(object sender, EventArgs e)
    {

        Int16 Status = GetWorkActivityStatus("Open");
        DataSet ds = objTransactionBAL.GetWoActivity(0, Convert.ToInt32(ddlWorkOrder.SelectedValue), Status, "Permanent Return",0);
        if (ddlCustomer.SelectedIndex > 0)
        {
            ddlWorkOrderActivity.DataSource = ds.Tables[0];
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

    protected DataTable TblFileDetails()
    {
        DataTable dtFileDetails = new DataTable();
        if (ViewState["FileDetails"] == null)
        {
            dtFileDetails.TableName = "Root";
            dtFileDetails.Columns.Add("SrNo", typeof(int));
            dtFileDetails.Columns["SrNo"].AutoIncrement = true;
            dtFileDetails.Columns["SrNo"].AutoIncrementSeed = 0;
            dtFileDetails.Columns.Add("FileId", typeof(int));
            dtFileDetails.Columns.Add("fileStatus", typeof(byte));
            dtFileDetails.AcceptChanges();
        }
        else
        {
            dtFileDetails = (DataTable)ViewState["FileDetails"];
        }
        return dtFileDetails;

    }

    protected void AddUpdateFileDetails(int iFileId, Int16 iStatus)
    {
        DataTable dtFileDetails;
        DataRow drFileDetails;
        dtFileDetails = TblFileDetails();
        try
        {
            drFileDetails = dtFileDetails.NewRow();
            drFileDetails["FileId"] = iFileId;
            drFileDetails["fileStatus"] = iStatus;
            dtFileDetails.Rows.Add(drFileDetails);
            ViewState["FileDetails"] = dtFileDetails;
        }
        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }
    }
    protected DataTable TblBoxDetails()
    {
        DataTable dtBoxDetails = new DataTable();
        if (ViewState["BoxDetails"] == null)
        {
            dtBoxDetails.TableName = "Root";
            dtBoxDetails.Columns.Add("SrNo", typeof(int));
            dtBoxDetails.Columns["SrNo"].AutoIncrement = true;
            dtBoxDetails.Columns["SrNo"].AutoIncrementSeed = 0;
            dtBoxDetails.Columns.Add("BoxId", typeof(int));
            dtBoxDetails.Columns.Add("boxStatus", typeof(byte));
            dtBoxDetails.AcceptChanges();
        }
        else
        {
            dtBoxDetails = (DataTable)ViewState["BoxDetails"];
        }
        return dtBoxDetails;

    }

    protected void AddUpdateBoxDetails(int iBoxId, Int16 iStatus)
    {
        DataTable dtBoxDetails;
        DataRow drdtBoxDetails;
        dtBoxDetails = TblBoxDetails();
        try
        {
            drdtBoxDetails = dtBoxDetails.NewRow();
            drdtBoxDetails["BoxId"] = iBoxId;
            drdtBoxDetails["boxStatus"] = iStatus;
            dtBoxDetails.Rows.Add(drdtBoxDetails);
            ViewState["BoxDetails"] = dtBoxDetails;
        }
        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            // Isboxfile  1 = box ,2 = file , 0 = all
            int iWorkOrderNo = Convert.ToInt32(ddlWorkOrder.SelectedValue);
            int iWorkOrderActivityId = Convert.ToInt32(ddlWorkOrderActivity.SelectedValue);

            if (iWorkOrderActivityId != 0)
            {
                divInwardBoxes.Style.Add("display", "none");
                divInwardFiles.Style.Add("display", "block");
                Bindfiledetails(iWorkOrderNo, iWorkOrderActivityId, 2);
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "divHideblocker();", true);
            }
  
        }
        catch (Exception ex)
        {

            ErrorHandler.WriteLog(ex);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            Page.Validate();
            if (Page.IsValid)
            {
                Byte istatus = 0;
                int iCustId = Convert.ToInt32(ddlCustomer.SelectedValue);
                istatus = Convert.ToByte(GetBoxFileStatus("Permanent Out"));
                Int16 iWareHousId = Convert.ToInt16(ddlWareHouse.SelectedValue);
                int iWoAcitvityId = Convert.ToInt32(ddlWorkOrderActivity.SelectedValue);
                int IsChkbox = 0;
    
                    if (grdFilesDetails.Rows.Count > 0)
                    {
                        foreach (GridViewRow Gvr in grdFilesDetails.Rows)
                        {
                            CheckBox chkstatus = (CheckBox)Gvr.FindControl("chkstatus");
                            HiddenField hdFileId = (HiddenField)Gvr.FindControl("hdnFileId");
                            HiddenField hdnFlStatus = (HiddenField)Gvr.FindControl("hdnFlStatus");
                            if (chkstatus.Checked == true)
                            {
                                IsChkbox = 1;
                                AddUpdateFileDetails(Convert.ToInt32(hdFileId.Value), istatus);
                            }
                            else
                            {
                                AddUpdateFileDetails(Convert.ToInt32(hdFileId.Value), Convert.ToByte(hdnFlStatus.Value));
                            }
                        }
                      }
                    if (IsChkbox == 0)
                        {
                        ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('Please select boxes')", true);
                        return;
                        }

                        DataTable dtFile = TblFileDetails();
                        DataSet dsFile = new DataSet();
                        dsFile.Tables.Add(dtFile);
                        string xmlstringFile = dsFile.GetXml();
                        objTransactionBAL.InsertUpdateFileDetails(iCustId, iWareHousId, xmlstringFile, iWoAcitvityId, 1, Convert.ToInt16(UserId));
                        grdFilesDetails.DataSource = null;
                        grdFilesDetails.DataBind();
                        ViewState["FileDetails"] = null;
                        ClearAll();
                        ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('Record Saved Successfully')", true);
                       divInwardFiles.Style.Add("display", "none");
            }

        }
        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        ClearAll();
    }

    protected void ClearAll()
    {
        grdFilesDetails.DataSource = null;
        grdFilesDetails.DataBind();
        ViewState["FileDetails"] = null;

        if (ddlWareHouse.Items.Count > 0)
        {
            ddlWareHouse.SelectedIndex = 0;
        }
        if (ddlCompanyGroup.Items.Count > 0)
        {
            ddlCompanyGroup.SelectedIndex = 0;
        }
        divInwardFiles.Style.Add("display", "none");
        ViewState["FileDetails"] = null;
        grdBoxDetails.DataSource = null;
        grdBoxDetails.DataBind();
        grdFilesDetails.DataSource = null;
        grdFilesDetails.DataBind();
        ddlCustomer.Items.Clear();
        ddlWorkOrder.Items.Clear();
        ddlWorkOrderActivity.Items.Clear();
        ddlWorkOrderActivity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        divInwardFiles.Style.Add("display", "none");
    }
    protected void rbtInwardFileBox_SelectedIndexChanged(object sender, EventArgs e)
    {
        divInwardFiles.Style.Add("display", "none");
        ViewState["FileDetails"] = null;
        grdBoxDetails.DataSource = null;
        grdBoxDetails.DataBind();
        grdFilesDetails.DataSource = null;
        grdFilesDetails.DataBind();
    }
    #region [Rolewise access page funcationality]
    public void SetRolewiseAcessfuncationality()
    {
        UserRolewiseAcess objUserRoleWiseAcessDAL = new UserRolewiseAcess();
        DataTable dtPageId = objUserRoleWiseAcessDAL.GetApplicationCodeDetails("Page_Name", "Permanent Return").Tables[0];
        int PageId = 0;
        if (dtPageId.Rows.Count > 0)
        {
            PageId = Convert.ToInt32(dtPageId.Rows[0][0]);
        }
        DataTable dtPagefuncationality = objUserRoleWiseAcessDAL.GetPageFunctionalityByRoleAndPageId(PageId, RoleId).Tables[0];
        btnSave.Visible = false;
        btnCancel.Visible = false;
        btnSearch.Visible = false;

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
                        case "Search":
                            btnSearch.Visible = true;
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