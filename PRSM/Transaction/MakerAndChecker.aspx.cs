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
using UserRoleWiseAcess;
using System.Web.SessionState;
using System.Collections;
using System.Drawing;


public partial class Transaction_MakerAndChecker : PageBase
{
    public static PRSMBAL.MasterBAL objPRSMBAL = new MasterBAL();
    public static PRSMBAL.TransactionBAL objPRSMTransBAL = new TransactionBAL();
    public static PRSMBAL.TransactionBAL objTRANSStBAL = new TransactionBAL();
    private System.Globalization.CultureInfo enGB = new System.Globalization.CultureInfo("en-GB");
    PageBase objPageBase = new PageBase();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (UserId == 0)
        {
            Response.Redirect("~/User/Login.aspx", false);
        }
        if (!IsPostBack)
        {
           // //NewInwardOutward();
            BindNewMaker();
            SetRolewiseAcessfuncationality();
        }
    }

    protected void grdFilesDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        DataSet ds1 = objPRSMBAL.GetApplicationCodeDetails("DEPARTMENT", string.Empty);

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList ddlDepartment = (DropDownList)e.Row.FindControl("ddlDepart");
            ddlDepartment.DataSource = ds1.Tables[0];
            ddlDepartment.DataValueField = "AppCodeId";
            ddlDepartment.DataTextField = "AppCodeName";
            ddlDepartment.DataBind();
            ddlDepartment.SelectedValue = "108";
            TextBox txtEdate = (TextBox)e.Row.FindControl("txtEdate");
            if (txtEdate != null)
            {
                AjaxControlToolkit.FilteredTextBoxExtender ftextender = new AjaxControlToolkit.FilteredTextBoxExtender();
                ftextender.FilterType = AjaxControlToolkit.FilterTypes.Numbers;
                ftextender.TargetControlID = txtEdate.ClientID;

            }

        }
    }

    protected void grdFilesDetailsModify_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        DataSet ds1 = objPRSMBAL.GetApplicationCodeDetails("DEPARTMENT", string.Empty);

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList ddlDepartment = (DropDownList)e.Row.FindControl("ddlDepart");
            string DeptID = grdFilesDetailsModify.DataKeys[e.Row.RowIndex].Values[1].ToString();
            ddlDepartment.DataSource = ds1.Tables[0];
            ddlDepartment.DataValueField = "AppCodeId";
            ddlDepartment.DataTextField = "AppCodeName";
            ddlDepartment.DataBind();
            ddlDepartment.SelectedValue = DeptID;
            
            Label lblStatus = (Label)e.Row.FindControl("lblStatus");
            TextBox txtEdate = (TextBox)e.Row.FindControl("txtEdate");
            TextBox txtlabel3 = (TextBox)e.Row.FindControl("txtlabel3");
            TextBox txtlabel2 = (TextBox)e.Row.FindControl("txtlabel2");
            TextBox txtlabel1 = (TextBox)e.Row.FindControl("txtlabel1");
            TextBox txtFdate = (TextBox)e.Row.FindControl("txtFdate");
            TextBox txtyear = (TextBox)e.Row.FindControl("txtyear");
            TextBox txtFilename = (TextBox)e.Row.FindControl("txtFilename");
            TextBox txtFileBarCode = (TextBox)e.Row.FindControl("txtFileBarCode");
            TextBox txtBoxBarCode = (TextBox)e.Row.FindControl("txtBoxBarCode");
            Label lblSrNo = (Label)e.Row.FindControl("lblSrNo");
            Label lblRemarks = (Label)e.Row.FindControl("lblRemarks");
            CheckBox cbSelect = (CheckBox)e.Row.FindControl("cbSelect");
            TextBox txtFileDescription = (TextBox)e.Row.FindControl("txtFileDescription");
            TextBox txtDestructionDueDate = (TextBox)e.Row.FindControl("txtDestructionDueDate");


            if (txtEdate != null)
            {
                AjaxControlToolkit.FilteredTextBoxExtender ftextender = new AjaxControlToolkit.FilteredTextBoxExtender();
                ftextender.FilterType = AjaxControlToolkit.FilterTypes.Numbers;
                ftextender.TargetControlID = txtEdate.ClientID;
            }

            if (lblStatus.Text == "Approved")
            {
                ddlDepartment.Enabled = false;
                txtFdate.Enabled = false;
                txtEdate.Enabled = false;
                txtlabel3.Enabled = false;
                txtlabel2.Enabled = false;
                txtlabel1.Enabled = false;
                txtyear.Enabled = false;
                txtFilename.Enabled = false;
                txtFileBarCode.Enabled = false;
                txtBoxBarCode.Enabled = false;
                txtFileDescription.Enabled = false;
                txtDestructionDueDate.Enabled = false;
                e.Row.Cells[0].BackColor = Color.YellowGreen;
                //cbSelect.Attributes.Add("style", "display:none");
                cbSelect.Visible = false;
            }
            if (lblStatus.Text == "Reject")
            {
                e.Row.Cells[0].BackColor = Color.Tomato;
                //e.Row.Cells[11].BackColor = Color.Maroon;
                //e.Row.Cells[12].BackColor = Color.Maroon;
                //ddlDepartment.ForeColor = Color.Red;
            }


            if (txtEdate != null)
            {
                AjaxControlToolkit.FilteredTextBoxExtender ftextender = new AjaxControlToolkit.FilteredTextBoxExtender();
                ftextender.FilterType = AjaxControlToolkit.FilterTypes.Numbers;
                ftextender.TargetControlID = txtEdate.ClientID;

            }

        }
    }



    protected void grdFilesDetailsChecker_RowDataBound(object sender, GridViewRowEventArgs e)
    {
       
    }

    
    protected void grdboxdetailsModify_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string lblStatus = e.Row.Cells[1].Text.ToString();
            TextBox txtBoxBarCode = (TextBox)e.Row.FindControl("txtBoxBarCode");
            TextBox txtBoxLocCode = (TextBox)e.Row.FindControl("txtBoxLocCode");

            if (lblStatus == "Approved")
            {
                txtBoxBarCode.Enabled = false;
                txtBoxLocCode.Enabled = false;
            }
        }

    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Status"> Open,Closed</param>
    /// <returns></returns>
    protected Int16 GetWorkStatus(string Status)
    {
        DataSet dsWorkStatus = objPRSMBAL.GetApplicationCodeDetails("WORKORDER_STATUS", "");
        Int16 istatus = 0;
        for (int i = 0; i < dsWorkStatus.Tables[0].Rows.Count; i++)
        {
            if (Convert.ToString(dsWorkStatus.Tables[0].Rows[i]["AppCodeName"]).ToUpper() == Status.ToUpper())
            {
                istatus = Convert.ToInt16(dsWorkStatus.Tables[0].Rows[i]["AppCodeId"]);

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
        DataSet dsWorkActivityStatus = objPRSMBAL.GetApplicationCodeDetails("ACTIVITY_STATUS", "");
        Int16 istatus = 0;
        for (int i = 0; i < dsWorkActivityStatus.Tables[0].Rows.Count; i++)
        {
            if (Convert.ToString(dsWorkActivityStatus.Tables[0].Rows[i]["AppCodeName"]).ToUpper() == Status.ToUpper())
            {
                istatus = Convert.ToInt16(dsWorkActivityStatus.Tables[0].Rows[i]["AppCodeId"]);
                break;
            }
        }
        return istatus;
    }
    protected void NewInwardOutward()
    {
        //  BindCompanyGroup(0);

        ddlCompanyGroup.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlWorkOrderActivity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        lblTotalCount.Visible = false;
        lnkbtnviewWoActivityDetails.Visible = false;
        BindDdlWareHouse(ddlWareHouse);
        rbtactivityType.Items[0].Selected = true;
        lblActivityName.Text = "New Standard Box Cost (1.50 Cubic Ft.)";
        binddefaultBoxDetailsGrid(grdboxdetails);
        ViewState["FileDetailsTable"] = null;
        bindfiledetails(grdFilesDetails);

    }

    protected void ModifyInwardOutward()
    {
        ddlCompanyGroupModify.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlCustomerModify.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlWorkOrderModify.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        lblTotalCount.Visible = false;
        lnkbtnviewWoActivityDetailsModify.Visible = false;
        BindDdlWareHouse(ddlWareHouseModify);
        rbtactivityTypeModify.Items[0].Selected = true;
        lblActivityName.Text = "New Standard Box Cost (1.50 Cubic Ft.)";
        binddefaultBoxDetailsGrid(grdboxdetailsModify);
        ViewState["FileDetailsTable"] = null;
        bindfiledetails(grdFilesDetailsModify);
    }

    protected void binddefaultFileDetailsGrid(GridView grvctrl)
    {
        //grdFilesDetails
        for (int i = 1; i <= 25; i++)
        {
            AddFilesDetails(-1, 0, "", "", "", 0, "", Convert.ToDateTime(null).ToString("dd-MM-yyyy", CultureInfo),
                Convert.ToDateTime(null).ToString("dd-MM-yyyy", CultureInfo), "", "", "", "","","",0,"",Convert.ToDateTime(null).ToString("dd-MM-yyyy"));
        }
        bindfiledetails(grvctrl);
        if (grvctrl.Rows.Count > 0)
        {
            grvctrl.UseAccessibleHeader = true;
            //This will add the <thead> and <tbody> elements
            grvctrl.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
    }




    protected void BindCompanyGroup(int iCompanyId, DropDownList ddlctrl)
    {
        ddlctrl.Items.Clear();
        ddlctrl.DataSource = objPRSMBAL.GetCompanyGroup(iCompanyId);
        ddlctrl.DataValueField = "CompanyGroupId";
        ddlctrl.DataTextField = "CGName";
        ddlctrl.DataBind();
        ddlctrl.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }
    protected void BindCustomer(int iCompanyId, DropDownList ddlctrl)
    {
        ScriptManager.RegisterStartupScript(this, typeof(Page),
"alert", "BindBoxBarcodeEvents();", true);
        ddlctrl.Items.Clear();
        DataSet dsCustomer = objPRSMBAL.GetCustomer(iCompanyId);
        ddlctrl.DataSource = dsCustomer.Tables[0];
        ddlctrl.DataValueField = "CustomerId";
        ddlctrl.DataTextField = "CustomerName";
        ddlctrl.DataBind();
        ddlctrl.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }
    private void BindDdlWareHouse(DropDownList ddlctrl)
    {
        ddlctrl.Items.Clear();
        ddlctrl.DataSource = objPRSMBAL.GetWareHouse(0);
        ddlctrl.DataValueField = "WareHouseId";
        ddlctrl.DataTextField = "WarehouseName";
        ddlctrl.DataBind();
        ddlctrl.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }
    protected void btnAddFileDetails(object sender, EventArgs e)
    {
        Button thisButton = (Button)sender;
        GridViewRow currentRow = (GridViewRow)thisButton.Parent.Parent;
        TextBox txtBoxBarCode = (TextBox)currentRow.FindControl("txtBoxBarCode");
        TextBox txtFileBarCode = (TextBox)currentRow.FindControl("txtFileBarCode");
        TextBox txtFilename = (TextBox)currentRow.FindControl("txtFilename");
        DropDownList ddldepart = (DropDownList)currentRow.FindControl("txtdepart");
        TextBox txtyear = (TextBox)currentRow.FindControl("txtyear");
        TextBox txtFdate = (TextBox)currentRow.FindControl("txtFdate");
        TextBox txtEdate = (TextBox)currentRow.FindControl("txtEdate");
        TextBox txtlabel1 = (TextBox)currentRow.FindControl("txtlabel1");
        TextBox txtlabel2 = (TextBox)currentRow.FindControl("txtlabel2");
        TextBox txtlabel3 = (TextBox)currentRow.FindControl("txtlabel3");
        TextBox txtFileDescription = (TextBox)currentRow.FindControl("txtFileDescription");
        TextBox txtDestructionDueDate = (TextBox)currentRow.FindControl("txtDestructionDueDate");
        //TextBox txtRemarks = (TextBox)currentRow.FindControl("txtRemarks");
        int rowindex = 0;
        string strBoxBarCode = "", strFileBarCode = "", strFileName = "", strDepart = ""
            , stryear = "", strFdate = "", strEdate = "", strLabel1 = "", strLabel2 = "", strLabel3 = ""
            , strRemarks = "", strDepartment = "", strFileDescription = "", strDestructionDueDate="";
        strBoxBarCode = txtBoxBarCode.Text;
        strFileBarCode = txtFileBarCode.Text;
        strFileName = txtFilename.Text;
        strDepart = ddldepart.SelectedValue;
        stryear = txtyear.Text;
        strFdate = txtFdate.Text;
        strEdate = txtEdate.Text;
        strLabel1 = txtlabel1.Text;
        strLabel2 = txtlabel2.Text;
        strLabel3 = txtlabel3.Text;
        rowindex = currentRow.RowIndex;
        strDepartment = ddldepart.SelectedItem.Text;
        strFileDescription = txtFileDescription.Text;
        strDestructionDueDate = txtDestructionDueDate.Text;
        AddFilesDetails(-1, 0, strBoxBarCode, strFileBarCode, strFileName, Convert.ToInt32(strDepart),
            stryear, strFdate, strEdate, strLabel1, strLabel2, strLabel3, "", "", strDepartment, 0, strFileDescription, strDestructionDueDate);
        txtBoxBarCode.Focus();
        //if (rbtNewModifyFreshPickup.SelectedValue == "1")
        //{
        bindfiledetails(grdFilesDetails);
        //}
        //else
        //{
        //    bindfiledetails(grdFilesDetailsModify);
        //}
    }

    protected void ddlCompanyGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        //ScriptManager.RegisterStartupScript(this, typeof(Page),
        //    "alert", "BindBoxBarcodeEvents();", true);
  
        if (ddlCompanyGroup.SelectedIndex > 0)
        {
           BindCustomer(Convert.ToByte(ddlCompanyGroup.SelectedItem.Value), ddlCustomer);
            //DataSet dsCustomer = objPRSMBAL.GetCustomer(Convert.ToByte(ddlCompanyGroup.SelectedItem.Value));
            //ddlCustomer.DataSource = dsCustomer.Tables[0];
            //ddlCustomer.DataValueField = "CustomerId";
            //ddlCustomer.DataTextField = "CustomerName";
            //ddlCustomer.DataBind();
            //ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlWorkOrder.Items.Clear();
            ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            clearWoActiviyDropDown();
        }
        else
        {
            ddlCustomer.Items.Clear();
            ddlCustomer.DataSource = null;
            ddlCustomer.DataBind();
            ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlWorkOrder.Items.Clear();
            ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
           clearWoActiviyDropDown();
        }
    }

    protected void ddlCompanyGroupModify_SelectedIndexChanged(object sender, EventArgs e)
    {

        if (ddlCompanyGroupModify.SelectedIndex > 0)
        {
            BindCustomer(Convert.ToByte(ddlCompanyGroupModify.SelectedItem.Value), ddlCustomerModify);
            ddlWorkOrderModify.Items.Clear();
            ddlWorkOrderModify.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            clearWoActiviyDropDownModify();
        }
        else
        {
            ddlCustomerModify.Items.Clear();
            ddlCustomerModify.DataSource = null;
            ddlCustomerModify.DataBind();
            ddlCustomerModify.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlWorkOrderModify.Items.Clear();
            ddlWorkOrderModify.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            clearWoActiviyDropDownModify();
        }
    }

    protected void clearWoActiviyDropDown()
    {
        ddlWorkOrderActivity.Items.Clear();
        ddlWorkOrderActivity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        lblTotalCount.Visible = false;
        lnkbtnviewWoActivityDetails.Visible = false;

    }

    protected void clearWoActiviyDropDownModify()
    {
        ddlWorkOrderModify.Items.Clear();
        ddlWorkOrderModify.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        lblTotalCount.Visible = false;
        lnkbtnviewWoActivityDetailsModify.Visible = false;

    }


    #region [BOX]
    protected DataTable BoxDetailsTable()
    {

        DataTable dtBoxDetails = new DataTable();
        if (ViewState["dtBoxDetailsTable"] == null)
        {
            dtBoxDetails.TableName = "Root";
            dtBoxDetails.Columns.Add("SrNo", typeof(int));
            dtBoxDetails.Columns["SrNo"].AutoIncrement = true;
            dtBoxDetails.Columns["SrNo"].AutoIncrementSeed = 0;
            dtBoxDetails.Columns.Add("BoxId", typeof(Int32));
            dtBoxDetails.Columns.Add("BoxBarCode", typeof(String));
            dtBoxDetails.Columns.Add("BoxLocCode", typeof(String));
            dtBoxDetails.Columns.Add("IsSelected", typeof(int));
            dtBoxDetails.AcceptChanges();
        }
        else
        {
            dtBoxDetails = (DataTable)ViewState["dtBoxDetailsTable"];
        }
        return dtBoxDetails;
    }
    protected void AddBoxDetails(int iSrNo, int iBoxId, string sBoxBarCode,
        string sBoxLocCode, int IsSelected)//, string sBoxRemarks,  string sBoxStatus)
    {
        DataTable dtBoxDetails;
        DataRow drBoxDetails;
        dtBoxDetails = BoxDetailsTable();
        try
        {
            drBoxDetails = dtBoxDetails.NewRow();
            if (iSrNo == -1)
            {
                drBoxDetails["BoxId"] = iBoxId;
                drBoxDetails["BoxBarCode"] = sBoxBarCode;
                drBoxDetails["BoxLocCode"] = sBoxLocCode;
                drBoxDetails["IsSelected"] = IsSelected;
                dtBoxDetails.Rows.Add(drBoxDetails);
                dtBoxDetails.AcceptChanges();
            }
            else
            {
                dtBoxDetails.Rows[iSrNo]["BoxId"] = iBoxId;
                dtBoxDetails.Rows[iSrNo]["BoxBarCode"] = sBoxBarCode;
                dtBoxDetails.Rows[iSrNo]["BoxLocCode"] = sBoxLocCode;
                drBoxDetails["IsSelected"] = IsSelected;
                dtBoxDetails.AcceptChanges();
            }
            ViewState["dtBoxDetailsTable"] = dtBoxDetails;
        }
        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }

    }

    protected void UpdateBoxDetails( int iBoxId,
        string sBoxBarCode, string sBoxLocCode, int IsSelected)//, string sBoxRemarks, string sBoxStatus,
    {
        DataTable dtBoxDetails;
        dtBoxDetails = BoxDetailsTable();

        if (!dtBoxDetails.Columns.Contains("IsSelected"))
            dtBoxDetails.Columns.Add("IsSelected");

        DataRow drBoxDetails = dtBoxDetails.AsEnumerable().Where(r => ((int)r["BoxId"]).Equals(iBoxId)).First(); // getting the row to edit , change it as you need
        if (Convert.ToString(ViewState["Action"]) == "U")
        {
            drBoxDetails["BoxBarCode"] = sBoxBarCode;
            drBoxDetails["BoxLocCode"] = sBoxLocCode;
            drBoxDetails["IsSelected"] = IsSelected;
        }
        //drBoxDetails["BoxRemarks"] = sBoxRemarks;
        //drBoxDetails["BoxStatus"] = sBoxStatus;

        dtBoxDetails.AcceptChanges();
    }

    protected void UpdateFileDetails( Int32 FileId, string sFileRemarks,  string sFileStatus,
      string BoxBarCode,     string FileBarCode, string sFileName, int DepartmentId, string sYear, String FromDate,
        String EndDate, string Label1, string Label2, string Label3, string sDepartmentName, int IsSelected,string FileDescription2,string DestructionDueDate)
    {
        DataTable dtFileDetails;
        dtFileDetails = FileDetailsTable();

        if (!dtFileDetails.Columns.Contains("IsSelected"))
        {
            dtFileDetails.Columns.Add("IsSelected");
        }

        DataRow drFileDetails = dtFileDetails.AsEnumerable().Where(r => ((int)r["FileId"]).Equals(FileId)).First(); // getting the row to edit , change it as you need

        if (Convert.ToString(ViewState["Action"]) == "U")
        {

            drFileDetails["BoxBarCode"] = BoxBarCode;
            drFileDetails["FileBarCode"] = FileBarCode;
            drFileDetails["sFileName"] = sFileName.Replace("'", "''");
            drFileDetails["Department"] = sDepartmentName;
            drFileDetails["sYear"] = sYear;
            drFileDetails["FromDate"] = FromDate.ToString().Replace("01-01-0001", "");
            drFileDetails["EndDate"] = EndDate.ToString().Replace("01-01-0001", "");
            drFileDetails["Label1"] = Label1.Replace("'", "''");
            drFileDetails["Label2"] = Label2.Replace("'", "''");
            drFileDetails["Label3"] = Label3.Replace("'", "''");
            drFileDetails["DepartmentId"] = DepartmentId;
            drFileDetails["IsSelected"] = IsSelected;
            drFileDetails["FileDescription1"] = FileDescription2.Replace("'", "''");
            drFileDetails["DestructionDueDate"] = DestructionDueDate.ToString().Replace("01-01-0001", "");
        }
        drFileDetails["FileRemarks"] = sFileStatus == "Approved" ? string.Empty : sFileRemarks.Replace("'", "''");
         drFileDetails["FileStatus"] = (sFileStatus == "Approved"?sFileStatus:
            (string.IsNullOrWhiteSpace(sFileRemarks) == true ? drFileDetails["FileStatus"] : sFileStatus));
        dtFileDetails.AcceptChanges();
    }

    protected void binddefaultBoxDetailsGrid(GridView grvctrl)
    {
        for (int i = 0; i < 25; i++)
        {
            AddBoxDetails(-1, 0, "", "",0);
        }
        bindBoxdetails(grvctrl);
        if (grvctrl.Rows.Count > 0)
        {
            grvctrl.UseAccessibleHeader = true;
            grvctrl.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
    }

    protected void bindBoxdetails(GridView grvctrl)
    {
        grvctrl.DataSource = null;
        grvctrl.DataBind();
        grvctrl.DataSource = BoxDetailsTable();
        grvctrl.DataBind();
        //grvctrl.EmptyDataText = "No Records Found";
    }

    #endregion
    #region -------[Files]-------------
    protected DataTable FileDetailsTable()
    {
        DataTable dtFileDetails = new DataTable();
        if (ViewState["FileDetailsTable"] == null)
        {
            dtFileDetails.TableName = "Root";
            dtFileDetails.Columns.Add("SrNo", typeof(int));
            dtFileDetails.Columns["SrNo"].AutoIncrement = true;
            dtFileDetails.Columns["SrNo"].AutoIncrementSeed = 0;
            dtFileDetails.Columns.Add("FileId", typeof(Int32));
            dtFileDetails.Columns.Add("BoxBarCode", typeof(String));
            dtFileDetails.Columns.Add("FileBarCode", typeof(String));
            dtFileDetails.Columns.Add("sFileName", typeof(String));
            dtFileDetails.Columns.Add("Department", typeof(String));
            dtFileDetails.Columns.Add("sYear", typeof(String));
            dtFileDetails.Columns.Add("FromDate", typeof(String));
            dtFileDetails.Columns.Add("EndDate", typeof(String));
            dtFileDetails.Columns.Add("Label1", typeof(String));
            dtFileDetails.Columns.Add("Label2", typeof(String));
            dtFileDetails.Columns.Add("Label3", typeof(String));
            dtFileDetails.Columns.Add("FileRemarks", typeof(String));
            dtFileDetails.Columns.Add("FileStatus", typeof(String));
            dtFileDetails.Columns.Add("DepartmentId", typeof(int));
            dtFileDetails.Columns.Add("IsSelected", typeof(int));
            dtFileDetails.Columns.Add("FileDescription1", typeof(string));
            dtFileDetails.Columns.Add("DestructionDueDate", typeof(string));
            dtFileDetails.AcceptChanges();
        }
        else
        {
            dtFileDetails = (DataTable)ViewState["FileDetailsTable"];
        }
        return dtFileDetails;
    }

    protected void AddFilesDetails(int iSrNo, Int32 FileId, string BoxBarCode, 
        string FileBarCode, string sFileName, int DepartmentId, string sYear, String FromDate, 
        String EndDate, string Label1, string Label2, string Label3,  string sFileRemarks,
        string sFileStatus, string sDepartmentName, int IsSelected, string FileDescription, string DestructionDueDate)
    {
        DataTable dtFilesDetails;
        DataRow drFilesDetails;
        dtFilesDetails = FileDetailsTable();
        try
        {
            drFilesDetails = dtFilesDetails.NewRow();
            if (iSrNo == -1)
            {
                drFilesDetails["FileId"] = FileId;
                drFilesDetails["BoxBarCode"] = BoxBarCode;
                drFilesDetails["FileBarCode"] = FileBarCode;
                drFilesDetails["sFileName"] = sFileName.Replace("'", "''");
                drFilesDetails["Department"] = sDepartmentName;
                drFilesDetails["sYear"] = sYear;
                drFilesDetails["FromDate"] = FromDate.ToString().Replace("01-01-0001", "");
                drFilesDetails["EndDate"] = EndDate.ToString().Replace("01-01-0001", "");
                drFilesDetails["Label1"] = Label1.Replace("'", "''");
                drFilesDetails["Label2"] = Label2.Replace("'", "''");
                drFilesDetails["Label3"] = Label3.Replace("'", "''");
                drFilesDetails["FileRemarks"] = sFileRemarks.Replace("'", "''");
                drFilesDetails["FileStatus"] = sFileStatus;
                drFilesDetails["DepartmentId"] = DepartmentId;
                drFilesDetails["IsSelected"] = IsSelected;
                drFilesDetails["FileDescription1"] = FileDescription.Replace("'", "''");
                drFilesDetails["DestructionDueDate"] = DestructionDueDate.ToString().Replace("01-01-0001", "");
                dtFilesDetails.Rows.Add(drFilesDetails);
                dtFilesDetails.AcceptChanges();
            }
            else
            {
                dtFilesDetails.Rows[iSrNo]["FileId"] = FileId;
                dtFilesDetails.Rows[iSrNo]["BoxBarCode"] = BoxBarCode;
                dtFilesDetails.Rows[iSrNo]["FileBarCode"] = FileBarCode;
                dtFilesDetails.Rows[iSrNo]["sFileName"] = sFileName.Replace("'","''");
                drFilesDetails["Department"] = sDepartmentName;
                dtFilesDetails.Rows[iSrNo]["sYear"] = sYear;
                dtFilesDetails.Rows[iSrNo]["FromDate"] = FromDate.ToString().Replace("01-01-0001", "");
                dtFilesDetails.Rows[iSrNo]["EndDate"] = EndDate.ToString().Replace("01-01-0001", "");
                dtFilesDetails.Rows[iSrNo]["Label1"] = Label1.Replace("'", "''");
                dtFilesDetails.Rows[iSrNo]["Label2"] = Label2.Replace("'", "''");
                dtFilesDetails.Rows[iSrNo]["Label3"] = Label3.Replace("'", "''");
                dtFilesDetails.Rows[iSrNo]["FileId"] = FileId;
                dtFilesDetails.Rows[iSrNo]["FileRemarks"] = sFileRemarks.Replace("'", "''");
                dtFilesDetails.Rows[iSrNo]["FileStatus"] = sFileStatus;
                dtFilesDetails.Rows[iSrNo]["DepartmentId"] = DepartmentId;
                dtFilesDetails.Rows[iSrNo]["IsSelected"] = IsSelected;
                dtFilesDetails.Rows[iSrNo]["FileDescription1"] = FileDescription.Replace("'", "''");
                dtFilesDetails.Rows[iSrNo]["DestructionDueDate"] = DestructionDueDate.ToString().Replace("01-01-0001", "");
                dtFilesDetails.AcceptChanges();
            }
            ViewState["FileDetailsTable"] = dtFilesDetails;
        }
        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }
    }

    protected void bindfiledetails(GridView grvctrl)
    {
        //grdFilesDetails
        grvctrl.DataSource = null;
        grvctrl.DataBind();
        grvctrl.DataSource = FileDetailsTable();
        grvctrl.DataBind();
    }



    #endregion
    protected void grdFilesDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "cmddelete")
        {
            int iRowToDelete = Convert.ToInt32(e.CommandArgument.ToString());
            DataTable dtFilesDetails = (DataTable)ViewState["FileDetailsTable"];
            if (dtFilesDetails != null)
            {
                if (dtFilesDetails.Rows.Count >= iRowToDelete)
                {
                    dtFilesDetails.Rows[iRowToDelete].Delete();
                    dtFilesDetails.AcceptChanges();
                }
            }
            ViewState["FileDetailsTable"] = dtFilesDetails;
            bindfiledetails(grdFilesDetails);
            if (grdFilesDetails.Rows.Count == 0)
            {
                binddefaultFileDetailsGrid(grdFilesDetails);
            }
        }
    }

    protected void ddlCustomer_SelectedIndexChanged(object sender, EventArgs e)
    {
        int iCompgroupId, icustomerid, iwarehouseid, istatus;
        icustomerid = 0;
        iwarehouseid = 0;
        istatus = 0;
        if (ddlCustomer.SelectedIndex > 0)
        {
            iCompgroupId = Convert.ToInt32(ddlCompanyGroup.SelectedItem.Value);
            icustomerid = Convert.ToInt32(ddlCustomer.SelectedItem.Value);
            clearWoActiviyDropDown();
            if (ddlWareHouse.SelectedIndex > 0)
            {
                iwarehouseid = Convert.ToInt32(ddlWareHouse.SelectedItem.Value);
            }
            istatus = GetWorkStatus("Open");
            bindWorkOrder(iCompgroupId, icustomerid, iwarehouseid, istatus, ddlWorkOrder);
        }
        else
        {
            ddlWorkOrder.Items.Clear();
            ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            clearWoActiviyDropDown();
        }

    }
    protected void ddlCustomerModify_SelectedIndexChanged(object sender, EventArgs e)
    {
        int iCompgroupId, icustomerid, iwarehouseid, istatus;
        icustomerid = 0;
        iwarehouseid = 0;
        istatus = 0;
        if (ddlCustomerModify.SelectedIndex > 0)
        {
            iCompgroupId = Convert.ToInt32(ddlCompanyGroupModify.SelectedItem.Value);
            icustomerid = Convert.ToInt32(ddlCustomerModify.SelectedItem.Value);
            clearWoActiviyDropDownModify();
            if (ddlWareHouseModify.SelectedIndex > 0)
            {
                iwarehouseid = Convert.ToInt32(ddlWareHouseModify.SelectedItem.Value);
            }
            istatus = GetWorkStatus("Open");
            bindWorkOrder(iCompgroupId, icustomerid, iwarehouseid, istatus, ddlWorkOrderModify);
        }
        else
        {
            ddlWorkOrderModify.Items.Clear();
            ddlWorkOrderModify.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            clearWoActiviyDropDownModify();
        }

    }


    protected void bindWorkOrder(int icompgroupId, int icustomerid, int iwarehouseid, int istatus, DropDownList ddlctrl)
    {
        DataSet dsWorkOrder = objPRSMTransBAL.GetWorkOrder(0, icompgroupId, icustomerid, iwarehouseid, istatus, null, null);
        ddlctrl.Items.Clear();
        ddlctrl.DataSource = null;
        ddlctrl.DataBind();
        if (dsWorkOrder != null)
        {
            if (dsWorkOrder.Tables.Count > 0)
            {
                ddlctrl.DataSource = dsWorkOrder.Tables[0];
                ddlctrl.DataValueField = "WorkorderNo";
                ddlctrl.DataTextField = "WorkorderNo";
                ddlctrl.DataBind();
            }
        }
        ddlctrl.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });

    }
    protected void bindWorkOrderActivites(int iWorkorderNo, int istatus, RadioButtonList rblctrl, DropDownList ddlctrl)
    {
        ddlctrl.DataSource = null;
        ddlctrl.DataBind();
        DataSet dsWorkOrderActivity = objPRSMTransBAL.GetWoActivity(0, iWorkorderNo, istatus, "Fresh Pick-up", 0);
        string ActivityName = "";
        if (rblctrl.SelectedItem.Value == "1")
        {
            ActivityName = "New Standard Box Cost (1.50 Cubic Ft.)";
        }
        else
        {
            ActivityName = "Bar-coding & Data Entry (File & Box)";
        }
        ddlctrl.Items.Clear();
        for (int i = 0; i < dsWorkOrderActivity.Tables[0].Rows.Count; i++)
        {
            if (ActivityName == Convert.ToString(dsWorkOrderActivity.Tables[0].Rows[i]["ActivityName"]))
            {
                ddlctrl.Items.Add(new ListItem(Convert.ToString(dsWorkOrderActivity.Tables[0].Rows[i]["PickUpAddress"]), Convert.ToString(dsWorkOrderActivity.Tables[0].Rows[i]["WOActivityId"])));
            }

        }
        ddlctrl.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }

    protected void ddlWorkOrder_SelectedIndexChanged(object sender, EventArgs e)
    {
        int istatus = GetWorkActivityStatus("Open");
        if (ddlWorkOrder.SelectedIndex > 0)
        {

            bindWorkOrderActivites(Convert.ToInt32(ddlWorkOrder.SelectedItem.Value), istatus, rbtactivityType, ddlWorkOrderActivity);
            if (rbtactivityType.SelectedItem.Value == "1")
            {
                if (ddlWorkOrder.SelectedIndex > 0)
                {
                    ddlWorkOrderActivity.SelectedIndex = ddlWorkOrderActivity.Items.IndexOf(ddlWorkOrderActivity.Items.FindByText("New Standard Box Cost (1.50 Cubic Ft.)"));
                }
            }
            else
            {
                if (ddlWorkOrder.SelectedIndex > 0)
                {
                    ddlWorkOrderActivity.SelectedIndex = ddlWorkOrderActivity.Items.IndexOf(ddlWorkOrderActivity.Items.FindByText("Bar-coding & Data Entry (File & Box)"));
                    BindActivityViewDetails();
                }
            }
        }
        else
        {
            clearWoActiviyDropDown();
        }

    }

    protected void ddlWorkOrderModify_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlWorkOrderModify.SelectedIndex > 0)
        {
            BindAllDropDownByWorkOrderNo(ddlWorkOrderModify, ddlCustomerModify, ddlCompanyGroupModify, ddlWareHouseModify);
            GetBoxFileDataByWorkOrderNo(ddlWorkOrderModify,"Pending");
            if (rbtactivityTypeModify.SelectedValue == "1")
            {
                if (ViewState["dtBoxDetailsTable"] != null)
                {
                    if (((DataTable)ViewState["dtBoxDetailsTable"]).Rows.Count > 0)
                    {
                        grdboxdetailsModify.DataSource = ViewState["dtBoxDetailsTable"];
                        grdboxdetailsModify.DataBind();
                        grdboxdetailsModify.Visible = true;
                        grdFilesDetailsModify.Visible = false;
                    }
                }
            }
            else
            {
                if (ViewState["FileDetailsTable"] != null)
                {
                    if (((DataTable)ViewState["FileDetailsTable"]).Rows.Count > 0)
                    {
                        grdFilesDetailsModify.DataSource = ViewState["FileDetailsTable"];
                        grdFilesDetailsModify.DataBind();
                        grdboxdetailsModify.Visible = false;
                        grdFilesDetailsModify.Visible = true;
                    }
                }
            
            }
        }
        else
        {
            clearAllModify();
            BindModifyMaker();
            if (rbtactivityTypeModify.SelectedValue == "1")
            {
                lblActivityNameModify.Text = "New Standard Box Cost (1.50 Cubic Ft.)";
                ViewState["FileDetailsTable"] = null;
                grdFilesDetailsModify.Visible = false;
                grdboxdetailsModify.Visible = false;
                lnkbtnviewWoActivityDetailsModify.Visible = false;
                gridviewWoActivityDetails.DataSource = null;
                gridviewWoActivityDetails.DataBind();
                lblTotalCountModify.Text = "";
                lblTotalCountModify.Visible = false;
            }
            else
            {
                lblActivityNameModify.Text = "Bar-coding & Data Entry (File & Box)";
                grdboxdetailsModify.Visible = false;
                grdFilesDetailsModify.Visible = false;
                ViewState["dtBoxDetailsTable"] = null;
                lnkbtnviewWoActivityDetailsModify.Visible = false;
                gridviewWoActivityDetails.DataSource = null;
                gridviewWoActivityDetails.DataBind();
                lblTotalCountModify.Text = "";
                lblTotalCountModify.Visible = false;
            }
        }
    }

    protected void ddlWorkOrderChecker_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlWorkOrderChecker.SelectedIndex > 0)
        {
            BindAllDropDownByWorkOrderNo(ddlWorkOrderChecker, ddlCustomerChecker, ddlCompanyGroupChecker, ddlWareHouseChecker);
            GetBoxFileDataByWorkOrderNo(ddlWorkOrderChecker, "Pending");
           
                if (ViewState["FileDetailsTable"] != null)
                {
                    if (((DataTable)ViewState["FileDetailsTable"]).Rows.Count > 0)
                    {
                        grdFilesDetailsChecker.DataSource = ViewState["FileDetailsTable"];
                        grdFilesDetailsChecker.DataBind();
                        grdFilesDetailsChecker.Visible = true;
                    }
                }
                else
                {
                    bindfiledetails(grdFilesDetailsChecker);
                    grdFilesDetailsChecker.Visible = true;
                }
           
        }
        else
        {
            clearAllChecker();
            BindChecker();

            lblActivityNameChecker.Text = "Bar-coding & Data Entry (File & Box)";
            grdFilesDetailsChecker.Visible = false;
            ViewState["dtBoxDetailsTable"] = null;
            
        }
    }

    /// <summary>
    /// </summary>
    /// <param name="Status">In,Out,Permanent Out,Destroy</param>
    /// <returns></returns>
    protected static Int16 GetBoxFileStatus(string Status)
    {
        DataSet dsBoxFileStatus = objPRSMBAL.GetApplicationCodeDetails("BOXFILE_STATUS", "");
        Byte istatus = 0;
        for (int i = 0; i < dsBoxFileStatus.Tables[0].Rows.Count; i++)
        {
            if (Convert.ToString(dsBoxFileStatus.Tables[0].Rows[i]["AppCodeName"]).ToUpper() == Status.ToUpper())
            {
                istatus = Convert.ToByte(dsBoxFileStatus.Tables[0].Rows[i]["AppCodeId"]);
                break;
            }
        }
        return istatus;
    }
    protected void clearAllSave()
    {
        BindDdlWareHouse(ddlWareHouse);
        ViewState["FileDetailsTable"] = null;
        ViewState["dtBoxDetailsTable"] = null;
        ddlCustomer.Items.Clear();
        ddlWorkOrderActivity.Items.Clear();
        lnkbtnviewWoActivityDetails.Visible = false;
        ddlCompanyGroup.Items.Clear();
        ddlWorkOrder.Items.Clear();
        //ddlWareHouse.SelectedIndex = 0;
        if (ddlCompanyGroup.Items.Count > 0)
        {
            ddlCompanyGroup.SelectedIndex = 0;
        }
        //ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        //ddlWorkOrderActivity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        //ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }

    protected void clearAllModify()
    {
        ViewState["FileDetailsTable"] = null;
        ViewState["dtBoxDetailsTable"] = null;
        ddlCustomerModify.Items.Clear();
        lnkbtnviewWoActivityDetailsModify.Visible = false;
        ddlWorkOrderModify.Items.Clear();
        ddlWareHouseModify.Items.Clear();
        ddlCompanyGroupModify.Items.Clear();
       
    }
    protected void clearAllChecker()
    {
        ViewState["FileDetailsTable"] = null;
        ViewState["dtBoxDetailsTable"] = null;
        ddlCustomerChecker.Items.Clear();
        ddlWorkOrderChecker.Items.Clear();
        ddlWareHouseChecker.Items.Clear();
        ddlCompanyGroupChecker.Items.Clear();
        rbtApprovedRejectChecker.ClearSelection();
    }

    protected void UpdateBoxDataTable(GridView grvctrl)
    {
        try
        {
            int  IsSelected = 0;
            for (int i = 0; i < grvctrl.Rows.Count; i++)
            {
                string strBoxBarCode = "", strBoxLocCode = "", strBoxRemarks = "", strBoxStatus = "";
                if (Convert.ToString(ViewState["Action"]) == "N" || Convert.ToString(ViewState["Action"]) == "U")
                {
                    TextBox txtBoxBarCode = (TextBox)grvctrl.Rows[i].FindControl("txtBoxBarCode");
                    TextBox txtBoxLocCode = (TextBox)grvctrl.Rows[i].FindControl("txtBoxLocCode");
                    strBoxBarCode = txtBoxBarCode.Text;
                    strBoxLocCode = txtBoxLocCode.Text;


                    if (Convert.ToString(ViewState["Action"]) == "U")
                    {
                        CheckBox cbSelect = (CheckBox)grvctrl.Rows[i].FindControl("cbSelect");
                        if (cbSelect.Checked == true)
                            IsSelected = 1;
                        else
                            IsSelected = 0;
                    }
                }
                else
                {
                    strBoxBarCode = grvctrl.Rows[i].Cells[5].Text.ToString().Replace("&nbsp;", ""); 
                    strBoxLocCode = grvctrl.Rows[i].Cells[6].Text.ToString().Replace("&nbsp;", "");
                  
                }
             
                int boxid = 0;
                if (strBoxBarCode.Trim() != "")
                {
                    if (Convert.ToString(ViewState["Action"]) != "N")
                    {
                        boxid = Convert.ToInt16(grvctrl.DataKeys[i].Value.ToString());

                        //if (Convert.ToString(ViewState["Action"]) == "C")
                        //{
                        //    RadioButton rbtApproval = (RadioButton)grvctrl.Rows[i].FindControl("rbtApproval");
                        //    RadioButton rbtReject = (RadioButton)grvctrl.Rows[i].FindControl("rbtReject");
                        //    if (rbtApproval.Checked == true && rbtReject.Checked == false)
                        //    {
                        //        strBoxStatus = "Approved";
                        //    }
                        //    if (rbtApproval.Checked == false && rbtReject.Checked == true)
                        //    {
                        //        strBoxStatus = "Reject";
                        //    }
                        //    if (rbtApproval.Checked == false && rbtReject.Checked == false)
                        //    {
                        //        strBoxStatus = "Pending";
                        //    }
                        //}
                        //else if (Convert.ToString(ViewState["Action"]) == "U")
                        //{
                        //    strBoxStatus = grvctrl.Rows[i].Cells[1].Text.ToString().Replace("&nbsp;", "");
                        //    strBoxRemarks = grvctrl.Rows[i].Cells[2].Text.ToString().Replace("&nbsp;", ""); 
                        //}
                    }
                    else
                    {
                        boxid = 1;
                    }
                }
                if (boxid != 0)
                {
                    if (Convert.ToString(ViewState["Action"]) == "N")
                    {
                        AddBoxDetails(-1, boxid, strBoxBarCode, strBoxLocCode, IsSelected);//, strBoxRemarks, strBoxStatus
                    }
                    else
                    {
                        UpdateBoxDetails(boxid, strBoxBarCode, strBoxLocCode, IsSelected);//, strBoxRemarks, strBoxStatus,
                    }

                }
            }
        }
        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }
    }
    protected void UpdateFileDataTable(GridView grvctrl)
    {
        try
        {
            for (int i = 0; i < grvctrl.Rows.Count; i++)
            {
                Int32 fileid = 0 ;
                string strBoxBarCode = "", strFileBarCode = "", strFileName = "", stryear = "", strFdate = "",
                    strEdate = "", strLabel1 = "", strLabel2 = "",
                    strLabel3 = "", strFileRemarks = "", strFileStatus = "", strDepartment = "", strFileDescription = "", strDestructionDueDate="";
                int iDepart = 0,IsSelected = 0;
                if (Convert.ToString(ViewState["Action"]) == "N" || Convert.ToString(ViewState["Action"]) == "U")
                {
                    TextBox txtBoxBarCode = (TextBox)grvctrl.Rows[i].FindControl("txtBoxBarCode");
                    TextBox txtFileBarCode = (TextBox)grvctrl.Rows[i].FindControl("txtFileBarCode");
                    TextBox txtFilename = (TextBox)grvctrl.Rows[i].FindControl("txtFilename");
                    DropDownList ddldepart = (DropDownList)grvctrl.Rows[i].FindControl("ddlDepart");
                    TextBox txtyear = (TextBox)grvctrl.Rows[i].FindControl("txtyear");
                    TextBox txtFdate = (TextBox)grvctrl.Rows[i].FindControl("txtFdate");
                    TextBox txtEdate = (TextBox)grvctrl.Rows[i].FindControl("txtEdate");
                    TextBox txtlabel1 = (TextBox)grvctrl.Rows[i].FindControl("txtlabel1");
                    TextBox txtlabel2 = (TextBox)grvctrl.Rows[i].FindControl("txtlabel2");
                    TextBox txtlabel3 = (TextBox)grvctrl.Rows[i].FindControl("txtlabel3");
                    TextBox txtFileDescription = (TextBox)grvctrl.Rows[i].FindControl("txtFileDescription");
                    TextBox txtDestructionDueDate = (TextBox)grvctrl.Rows[i].FindControl("txtDestructionDueDate");

                    strBoxBarCode = txtBoxBarCode.Text;
                    strFileBarCode = txtFileBarCode.Text;
                    strFileName = txtFilename.Text;
                    iDepart = Convert.ToInt32(ddldepart.SelectedValue);
                    stryear = txtyear.Text;
                    strFdate = txtFdate.Text;
                    strEdate = txtEdate.Text;
                    strLabel1 = txtlabel1.Text;
                    strLabel2 = txtlabel2.Text;
                    strLabel3 = txtlabel3.Text;
                    strFileDescription = txtFileDescription.Text;
                    strDestructionDueDate = txtDestructionDueDate.Text;
                    strDepartment = ddldepart.SelectedItem.Text;
                   
                    if (Convert.ToString(ViewState["Action"]) == "U")
                    {
                        Label lblRemarks = (Label)grvctrl.Rows[i].FindControl("lblRemarks");
                        Label lblStatus = (Label)grvctrl.Rows[i].FindControl("lblStatus");
                        strFileRemarks = lblRemarks.Text;
                        strFileStatus = lblStatus.Text;
                        fileid = Convert.ToInt32(grvctrl.DataKeys[i].Values[0].ToString());
                        CheckBox cbSelect = (CheckBox)grvctrl.Rows[i].FindControl("cbSelect");
                        if (cbSelect.Checked == true)
                            IsSelected = 1;
                        else
                            IsSelected = 0;
                    }
                    else
                    {
                        strFileRemarks = string.Empty;
                        strFileStatus = string.Empty;
                    }

                }
                if (Convert.ToString(ViewState["Action"]) == "C")
                {
                    Label lblyear = (Label)grvctrl.Rows[i].FindControl("lblyear");
                    Label lblFdate = (Label)grvctrl.Rows[i].FindControl("lblFdate");
                    Label lblEdate = (Label)grvctrl.Rows[i].FindControl("lblEdate");
                    TextBox txtRemarks = (TextBox)grvctrl.Rows[i].FindControl("txtRemarks");
                    strBoxBarCode = grvctrl.Rows[i].Cells[1].Text.ToString().Replace("&nbsp;", "");
                    strFileBarCode = grvctrl.Rows[i].Cells[2].Text.ToString().Replace("&nbsp;", "");
                    strFileName = grvctrl.Rows[i].Cells[3].Text.ToString().Replace("&nbsp;", "");
                    strDepartment = Convert.ToString(grvctrl.Rows[i].Cells[4].Text.ToString().Replace("&nbsp;", ""));
                    stryear = lblyear.Text.ToString().Replace("&nbsp;", "");
                    strFdate = lblFdate.Text.ToString().Replace("&nbsp;", "");
                    strEdate = lblEdate.Text.ToString().Replace("&nbsp;", "");
                    strLabel1 = grvctrl.Rows[i].Cells[8].Text.ToString().Replace("&nbsp;", ""); ;
                    strLabel2 = grvctrl.Rows[i].Cells[9].Text.ToString().Replace("&nbsp;", "");
                    strLabel3 = grvctrl.Rows[i].Cells[10].Text.ToString().Replace("&nbsp;", "");
                    strFileDescription = grvctrl.Rows[i].Cells[11].Text.ToString().Replace("&nbsp;", "");
                    strDestructionDueDate = grvctrl.Rows[i].Cells[12].Text.ToString().Replace("&nbsp;", "");

                    strFdate = lblFdate.Text.ToString().Replace("&nbsp;", "");
                    strFileRemarks = txtRemarks.Text;

                    iDepart = Convert.ToInt16(grvctrl.DataKeys[i].Values[1].ToString());
                    //RadioButton rbtApproval = (RadioButton)grvctrl.Rows[i].FindControl("rbtApproval");
                    //RadioButton rbtReject = (RadioButton)grvctrl.Rows[i].FindControl("rbtReject");
                    if (rbtApprovedRejectChecker.SelectedValue == "1")
                    {
                        strFileStatus = "Approved";
                    }
                    if (rbtApprovedRejectChecker.SelectedValue == "2")
                    {
                        strFileStatus = "Reject";
                    }
                    if (string.IsNullOrEmpty(rbtApprovedRejectChecker.SelectedValue))
                    {
                        strFileStatus = "Pending";
                    }
                    fileid = Convert.ToInt32(grvctrl.DataKeys[i].Values[0].ToString());
                }
                // int rowindex = 0;
             
              
                if (strFileBarCode.Trim() != "" && strBoxBarCode != "")
               {
                   if (Convert.ToString(ViewState["Action"]) != "N")
                   {
                      fileid = Convert.ToInt32(grvctrl.DataKeys[i].Values[0].ToString());
                   }
                   else
                   {
                       fileid = 1;
                   }
                }
                if (fileid != 0)
                {
                    if (Convert.ToString(ViewState["Action"]) == "N")
                    {
                        AddFilesDetails(i, fileid, strBoxBarCode, strFileBarCode, strFileName, iDepart, 
                            stryear, strFdate, strEdate, strLabel1, strLabel2, strLabel3, strFileRemarks,
                            strFileStatus, strDepartment, IsSelected,strFileDescription,strDestructionDueDate);
                    }
                    else
                    {

                            UpdateFileDetails(fileid, strFileRemarks, strFileStatus, strBoxBarCode, strFileBarCode, strFileName, iDepart,
                                       stryear, strFdate, strEdate, strLabel1, strLabel2, strLabel3, strDepartment, IsSelected, strFileDescription, strDestructionDueDate
                                       );
                        
                    }
                }
              
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
            Page.Validate("SaveGroup");
            if (Page.IsValid)
            {
                int iCustId = Convert.ToInt32(ddlCustomer.SelectedValue);
                Int16 iWareHousId = Convert.ToInt16(ddlWareHouse.SelectedValue);
                string msg = "Record saved successfully.";
                bool isError = true;
                string srdbtnChkId = rbtactivityType.SelectedValue.ToString();
                if (srdbtnChkId == "1")
                {
                    string xmlBoxData;
                    DataSet dsBoxDuplicate = new DataSet();
                    DataSet dsxmlBoxDetail = new DataSet();
                    DataTable dtBoxDetails = new DataTable();
                    dtBoxDetails = BoxDetailsTable().Clone();
                    dtBoxDetails.TableName = "Root";
                    UpdateBoxDataTable(grdboxdetails);
                    DataRow[] foundrows = BoxDetailsTable().Select("boxid =1");
                    if (foundrows.Length > 0)
                    {
                        dtBoxDetails = foundrows.CopyToDataTable<DataRow>();
                    }
                    dtBoxDetails.AcceptChanges();
                    if (dtBoxDetails.Rows.Count < 1)
                    {
                        lblMsg.Text = "Please enter atleast one box details.";
                        ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "ShowdivDuplicate();", true);
                        return;
                    }
                    dsxmlBoxDetail.Tables.Add(dtBoxDetails);
                    dsxmlBoxDetail.Tables[0].TableName = "Root";
                    dsxmlBoxDetail.AcceptChanges();
                    xmlBoxData = dsxmlBoxDetail.GetXml();
                    dsBoxDuplicate = objPRSMTransBAL.InsertUpdateMakerBoxDetails(iCustId, iWareHousId, xmlBoxData, Convert.ToInt32(ddlWorkOrderActivity.SelectedValue), Convert.ToInt16(UserId), 0);
                    if (dsBoxDuplicate.Tables.Count != 0)
                    {
                        if (dsBoxDuplicate.Tables[0].Rows.Count > 0)
                        {
                            msg = string.Empty;
                            msg += "<br/> <br/>  Please check below record(s) are already added.";
                        }

                        for (int i = 0; i < dsBoxDuplicate.Tables[0].Columns.Count; i++)
                        {
                            if (dsBoxDuplicate.Tables[0].Columns[i].ColumnName == "BoxBarCode")
                            {
                                grdduplicateEntry.DataSource = dsBoxDuplicate.Tables[0];
                                grdduplicateEntry.DataBind();
                                isError = false;
                                lblMsg.Text = msg;
                                clearAllSave();
                                ViewState["dtBoxDetailsTable"] = null;
                                ClearGrdBoxDetails(grdboxdetails);
                                ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "ShowdivDuplicate();", true);
                                return;
                            }
                        }
                        if (isError)
                        {
                            lblMsg.Text = "Error in record adding";
                            ErrorHandler.WriteLog(dsBoxDuplicate);
                        }
                    }
                    ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('Record saved successfully.')", true);
                }
                if (srdbtnChkId == "2")
                {
                    string xmlBoxFileData;
                    Int16 iStatus = GetBoxFileStatus("In");
                    DataSet dsxml = new DataSet();
                    DataTable dtBoxFileDetails = new DataTable();
                    dtBoxFileDetails = FileDetailsTable().Clone();
                    dtBoxFileDetails.TableName = "Root";
                    DataSet dsResult = new DataSet();
                    UpdateFileDataTable(grdFilesDetails);
                    string strFilter = "FileId =1";
                    DataRow[] foundrows = FileDetailsTable().Select(strFilter);
                    if (foundrows.Length > 0)
                    {
                        dtBoxFileDetails = foundrows.CopyToDataTable<DataRow>();
                    }
                    dtBoxFileDetails.AcceptChanges();
                    if (dtBoxFileDetails.Rows.Count < 1)
                    {
                        lblMsg.Text = "Please enter at least one file details.";
                        ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "ShowdivDuplicate();", true);
                        return;
                    }
                    dsxml.Tables.Add(dtBoxFileDetails);
                    dsxml.Tables[0].TableName = "Root";
                    dsxml.AcceptChanges();
                    xmlBoxFileData = dsxml.GetXml();
                    dsResult = objPRSMTransBAL.InsertUpdateMakerFileDetails(iCustId, iWareHousId, xmlBoxFileData, Convert.ToInt32(ddlWorkOrderActivity.SelectedItem.Value), 0, Convert.ToInt16(UserId));
                    //msg += ",";
                    if (dsResult.Tables.Count != 0)
                    {
                        if (dsResult.Tables[0].Rows.Count > 0)
                        {
                            msg = string.Empty;
                            msg += "<br/> <br/>  Please check below record(s) are already added.";
                        }
                        for (int i = 0; i < dsResult.Tables[0].Columns.Count; i++)
                        {
                            if (dsResult.Tables[0].Columns[i].ColumnName == "FileCode")
                            {
                                grdduplicateEntry.DataSource = dsResult.Tables[0];
                                grdduplicateEntry.DataBind();
                                isError = false;
                                lblMsg.Text = msg;
                                clearAllSave();
                                lblTotalCount.Text = "";
                                binddefaultFileDetailsGrid(grdFilesDetails);
                                ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "ShowdivDuplicate();", true);
                                return;
                            }
                        }
                        if (isError)
                        {
                            lblMsg.Text = "Error in record adding";
                            ErrorHandler.WriteLog(dsResult);
                        }
                    }
                    clearAllSave();

                    binddefaultFileDetailsGrid(grdFilesDetails);
                }
            }
        }
        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }
    }


    protected void btnModify_Click(object sender, EventArgs e)
    {
        try
        {
            Page.Validate("ModifyGroup");
            if (Page.IsValid)
            {
                int iCustId = Convert.ToInt32(ddlCustomerModify.SelectedValue);
                Int16 iWareHousId = Convert.ToInt16(ddlWareHouseModify.SelectedValue);
                string msg = "Record saved successfully.";
                bool isError = true;
                string srdbtnChkId = rbtactivityTypeModify.SelectedValue.ToString();

                Boolean IsChecked = false;
             
                if (srdbtnChkId == "1")
                {
                    string xmlBoxData;
                    DataSet dsBoxDuplicate = new DataSet();
                    DataSet dsxmlBoxDetail = new DataSet();
                    DataTable dtBoxDetails = new DataTable();
                    dtBoxDetails = BoxDetailsTable().Clone();
                    dtBoxDetails.TableName = "Root";

                    for (int count = 0; count < grdboxdetailsModify.Rows.Count; count++)
                    {
                        if (((CheckBox)grdboxdetailsModify.Rows[count].FindControl("cbSelect")).Checked)
                        {
                            IsChecked = true;
                            break;
                        }
                    }

                    if (IsChecked == false)
                    {
                        lblMsg.Text = "Please select atleast one checkbox";
                        ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "ShowdivDuplicate();", true);
                        return;
                    }


                    UpdateBoxDataTable(grdboxdetailsModify);

                    //dtBoxDetails.AcceptChanges();

                    DataRow[] foundrows = BoxDetailsTable().Select("IsSelected = 1");
                    if (foundrows.Length > 0)
                    {
                        dtBoxDetails = foundrows.CopyToDataTable<DataRow>();
                    }

                    dsxmlBoxDetail.Tables.Add(dtBoxDetails);
                    dsxmlBoxDetail.Tables[0].TableName = "Root";
                    dsxmlBoxDetail.AcceptChanges();
                    xmlBoxData = dsxmlBoxDetail.GetXml();
                    dsBoxDuplicate = objPRSMTransBAL.UpdateBoxDetails(iCustId, iWareHousId, xmlBoxData, Convert.ToInt32(ddlWorkOrderModify.SelectedValue), Convert.ToInt16(UserId), 0);
                    if (dsBoxDuplicate.Tables.Count != 0)
                    {
                        if (dsBoxDuplicate.Tables[0].Rows.Count > 0)
                        {
                           msg= string.Empty;
                            msg += "<br/> <br/>  Please check below record(s) are already added.";


                            for (int i = 0; i < dsBoxDuplicate.Tables[0].Columns.Count; i++)
                            {
                                if (dsBoxDuplicate.Tables[0].Columns[i].ColumnName == "BoxBarCode")
                                {
                                    grdduplicateEntry.DataSource = dsBoxDuplicate.Tables[0];
                                    grdduplicateEntry.DataBind();
                                    isError = false;
                                    lblMsg.Text = msg;
                                    //clearAllModify();
                                    //ViewState["dtBoxDetailsTable"] = null;
                                    //ClearGrdBoxDetails(grdboxdetailsModify);
                                    ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "ShowdivDuplicate();", true);
                                    return;
                                }
                            }
                            if (isError)
                            {
                                lblMsg.Text = "Error in record updating";
                                ErrorHandler.WriteLog(dsBoxDuplicate);
                            }
                        }

                    }
                    ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('Record update successfully.')", true);
                }
                if (srdbtnChkId == "2")
                {
                    string xmlBoxFileData;
                    Int16 iStatus = GetBoxFileStatus("In");
                    DataSet dsxml = new DataSet();
                    DataTable dtBoxFileDetails = new DataTable();
                    dtBoxFileDetails = FileDetailsTable().Clone();
                    dtBoxFileDetails.TableName = "Root";
                    DataSet dsResult = new DataSet();

                    for (int count = 0; count < grdFilesDetailsModify.Rows.Count; count++)
                    {
                        if (((CheckBox)grdFilesDetailsModify.Rows[count].FindControl("cbSelect")).Checked)
                        {
                            IsChecked = true;
                            break;
                        }
                    }

                    if (IsChecked == false)
                    {
                        lblMsg.Text = "Please select atleast one checkbox";
                        ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "ShowdivDuplicate();", true);
                        return;
                    }
                    UpdateFileDataTable(grdFilesDetailsModify);
                    string strFilter = "FileId =1";
                    DataRow[] foundrows = FileDetailsTable().Select("FileStatus = 'Reject' AND BoxBarCode = ''");
                    if (foundrows.Length > 0)
                    {
                        lblMsg.Text = "Please enter Box Barcode.";
                        ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "ShowdivDuplicate();", true);
                        return;
                    }
                    foundrows = FileDetailsTable().Select("FileStatus = 'Reject' AND FileBarCode = ''");
                    if (foundrows.Length > 0)
                    {
                        lblMsg.Text = "Please enter File Barcode.";
                        ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "ShowdivDuplicate();", true);
                        return;
                    }
                    foundrows = FileDetailsTable().Select("FileStatus = 'Reject' AND IsSelected = 1");
                    if (foundrows.Length > 0)
                    {
                        dtBoxFileDetails = foundrows.CopyToDataTable<DataRow>();
                    }
                    else
                    {
                        lblMsg.Text = "There is no any File details for updation.";
                        ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "ShowdivDuplicate();", true);
                        return;
                    }
                    dtBoxFileDetails.AcceptChanges();
                    if (dtBoxFileDetails.Rows.Count < 1)
                    {
                        lblMsg.Text = "Please enter at least one file details.";
                        ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "ShowdivDuplicate();", true);
                        return;
                    }
                    dsxml.Tables.Add(dtBoxFileDetails);
                    dsxml.Tables[0].TableName = "Root";
                    dsxml.AcceptChanges();
                    xmlBoxFileData = dsxml.GetXml();
                    dsResult = objPRSMTransBAL.UpdateFileDetails(iCustId, iWareHousId, xmlBoxFileData, Convert.ToInt32(ddlWorkOrderModify.SelectedItem.Value), Convert.ToInt16(UserId), 0);
                    //msg += ",";
                    if (dsResult.Tables.Count != 0)
                    {
                        if (dsResult.Tables[0].Rows.Count > 0)
                        {
                            msg = string.Empty;
                            msg += "<br/> <br/>  Please check below record(s) are already added.";

                            for (int i = 0; i < dsResult.Tables[0].Columns.Count; i++)
                            {
                                if (dsResult.Tables[0].Columns[i].ColumnName == "FileCode")
                                {
                                    grdduplicateEntry.DataSource = dsResult.Tables[0];
                                    grdduplicateEntry.DataBind();
                                    isError = false;
                                    lblMsg.Text = msg;
                                    //clearAllModify();
                                    //lblTotalCount.Text = "";
                                    //binddefaultFileDetailsGrid(grdFilesDetailsModify);
                                    ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "ShowdivDuplicate();", true);
                                    return;
                                }
                            }
                            if (isError)
                            {
                                lblMsg.Text = "Error in record Updating";
                                ErrorHandler.WriteLog(dsResult);
                            }
                        }

                    }
                  
                    ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('Record update successfully.')", true);

                }
                lnkbtnModifyMaker_Click(null, null);
            }
        }
        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }


    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        clearAllSave();
        lnkbtnviewWoActivityDetails.Visible = false;
        lblTotalCount.Text = "";
        lblMsg.Text = "";
        if (rbtactivityType.SelectedItem.Value == "1")
        {
            grdFilesDetails.Visible = false;
            grdboxdetails.Visible = true;
            ClearGrdBoxDetails(grdboxdetails);
        }
        else
        {

            grdFilesDetails.Visible = true;
            grdboxdetails.Visible = false;
            binddefaultFileDetailsGrid(grdFilesDetails);
        }
        ddlCompanyGroup.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlWorkOrderActivity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }

    protected void btnCancelModify_Click(object sender, EventArgs e)
    {
        clearAllModify();
        GetNonApprovedWorkOrderNo("Reject", ddlWorkOrderModify);
        lnkbtnviewWoActivityDetailsModify.Visible = false;
        lblTotalCountModify.Text = "";
        lblMsg.Text = "";
        if (rbtactivityTypeModify.SelectedItem.Value == "1")
        {
            grdFilesDetailsModify.Visible = false;
            grdboxdetailsModify.Visible = false;
            //ClearGrdBoxDetails(grdboxdetailsModify);
        }
        else
        {

            grdFilesDetailsModify.Visible = false;
            grdboxdetailsModify.Visible = false;
            //binddefaultFileDetailsGrid(grdFilesDetailsModify);
        }

    }

    #region [Rolewise access page funcationality]
    public void SetRolewiseAcessfuncationality()
    {
        UserRolewiseAcess objUserRoleWiseAcessDAL = new UserRolewiseAcess();
        DataTable dtPageId = objUserRoleWiseAcessDAL.GetApplicationCodeDetails("Page_Name", "Maker & Checker").Tables[0];
        int PageId = 0;
        if (dtPageId.Rows.Count > 0)
        {
            PageId = Convert.ToInt32(dtPageId.Rows[0][0]);
        }
        DataTable dtPagefuncationality = objUserRoleWiseAcessDAL.GetPageFunctionalityByRoleAndPageId(PageId, RoleId).Tables[0];
        btnSave.Visible = false;
        btnCancel.Visible = false;
        btnApprove.Visible = false;
        btnCancelApprove.Visible = false;
        btnModify.Visible = false;
        btnCancelModify.Visible = false;
        //lnkbtnChecker.Enabled = false;
        //lnkbtnMaker.Enabled = false;
        //lnkbtnModifyMaker.Enabled = false;
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
                            btnApprove.Visible = true;
                            break;
                        case "Update":
                            btnModify.Visible = true;
                            btnCancelModify.Visible = true;
                            break;
                        case "Clear":
                            btnCancel.Visible = true;
                            btnCancelApprove.Visible = true;
                            break;
                        case "Maker Tab":
                            lnkbtnMaker.Enabled = true;
                            lnkbtnModifyMaker.Enabled = true;
                            break;
                        case "Checker Tab":
                            lnkbtnChecker.Enabled = true;
                            break;
                        default:
                            break;
                    }
                }
            }
        }

    }
    #endregion

    private void BindActivityViewDetails()
    {
        lblTotalCount.Visible = false;
        lnkbtnviewWoActivityDetails.Visible = false;
        if (rbtactivityType.SelectedValue.ToString() != "1")
        {
            if (ddlWorkOrderActivity.SelectedIndex > 0)
            {
                int WoderActivity = Convert.ToInt32(ddlWorkOrderActivity.SelectedItem.Value);

                DataSet dsGeFileDetais = objPRSMTransBAL.GetFileDetailsbyWoActivityId(Convert.ToInt32(ddlWorkOrderActivity.SelectedItem.Value));
                if (dsGeFileDetais != null)
                {

                    if (dsGeFileDetais.Tables.Count > 0)
                    {
                        if (dsGeFileDetais.Tables[0].Rows.Count > 0)
                        {

                            int BoxCount = 0, FileCount = 0, TotalBoxAdded = 0, TotalFileAdded = 0;
                            BoxCount = Convert.ToInt32(dsGeFileDetais.Tables[0].Rows[0]["BoxCount"]);
                            FileCount = Convert.ToInt32(dsGeFileDetais.Tables[0].Rows[0]["FileCount"]);
                            TotalBoxAdded = Convert.ToInt32(dsGeFileDetais.Tables[0].Rows[0]["TotalBoxAdded"]);
                            TotalFileAdded = Convert.ToInt32(dsGeFileDetais.Tables[0].Rows[0]["TotalFileAdded"]);
                            string Result = "Total Boxes :" + TotalBoxAdded.ToString() + "/" + BoxCount;
                            Result += "&nbsp;|&nbsp;  Total Files :" + TotalFileAdded.ToString() + "/" + FileCount;
                            if (TotalBoxAdded > 0)
                            {
                                lnkbtnviewWoActivityDetails.Visible = true;
                                gridviewWoActivityDetails.DataSource = null;
                                gridviewWoActivityDetails.DataBind();
                                gridviewWoActivityDetails.DataSource = dsGeFileDetais.Tables[1];
                                gridviewWoActivityDetails.DataBind();
                            }
                            lblTotalCount.Text = Result;
                            lblTotalCount.Visible = true;

                        }
                    }
                }
            }
        }
    }

    private void BindActivityViewDetailsModify()
    {
        lblTotalCount.Visible = false;
        lnkbtnviewWoActivityDetailsModify.Visible = false;
        if (rbtactivityTypeModify.SelectedValue.ToString() != "1")
        {
            if (ddlWorkOrderModify.SelectedIndex > 0)
            {
                int WoderActivity = Convert.ToInt32(ddlWorkOrderActivity.SelectedItem.Value);

                DataSet dsGeFileDetais = objPRSMTransBAL.GetFileDetailsbyWoActivityId(Convert.ToInt32(ddlWorkOrderModify.SelectedItem.Value));
                if (dsGeFileDetais != null)
                {

                    if (dsGeFileDetais.Tables.Count > 0)
                    {
                        if (dsGeFileDetais.Tables[0].Rows.Count > 0)
                        {

                            int BoxCount = 0, FileCount = 0, TotalBoxAdded = 0, TotalFileAdded = 0;
                            BoxCount = Convert.ToInt32(dsGeFileDetais.Tables[0].Rows[0]["BoxCount"]);
                            FileCount = Convert.ToInt32(dsGeFileDetais.Tables[0].Rows[0]["FileCount"]);
                            TotalBoxAdded = Convert.ToInt32(dsGeFileDetais.Tables[0].Rows[0]["TotalBoxAdded"]);
                            TotalFileAdded = Convert.ToInt32(dsGeFileDetais.Tables[0].Rows[0]["TotalFileAdded"]);
                            string Result = "Total Boxes :" + TotalBoxAdded.ToString() + "/" + BoxCount;
                            Result += "&nbsp;|&nbsp;  Total Files :" + TotalFileAdded.ToString() + "/" + FileCount;
                            if (TotalBoxAdded > 0)
                            {
                                lnkbtnviewWoActivityDetailsModify.Visible = true;
                                gridviewWoActivityDetails.DataSource = null;
                                gridviewWoActivityDetails.DataBind();
                                gridviewWoActivityDetails.DataSource = dsGeFileDetais.Tables[1];
                                gridviewWoActivityDetails.DataBind();
                            }
                            lblTotalCount.Text = Result;
                            lblTotalCount.Visible = true;

                        }
                    }
                }
            }
        }
    }


    protected void ddlWorkOrderActivity_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindActivityViewDetails();
    }

    protected void lnkbtnviewWoActivityDetails_Click(object sender, EventArgs e)
    {

    }
    protected void lnkbtnviewWoActivityDetailsModify_Click(object sender, EventArgs e)
    {

    }
    protected void ddlWareHouse_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlWareHouse.SelectedIndex > 0)
        {
            BindCompanyGroup(0, ddlCompanyGroup);
            ddlCustomer.Items.Clear();
            ddlCustomer.DataSource = null;
            ddlCustomer.DataBind();
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
            ddlCompanyGroup.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlWorkOrder.Items.Clear();
            ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            clearWoActiviyDropDown();

        }
    }

    protected void ddlWareHouseModify_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlWareHouseModify.SelectedIndex > 0)
        {
            BindCompanyGroup(0, ddlCompanyGroupModify);
            ddlCustomerModify.Items.Clear();
            ddlCustomerModify.DataSource = null;
            ddlCustomerModify.DataBind();
            ddlCustomerModify.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlWorkOrderModify.Items.Clear();
            ddlWorkOrderModify.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            clearWoActiviyDropDownModify();
        }
        else
        {
            ddlCompanyGroupModify.Items.Clear();
            ddlCustomerModify.Items.Clear();
            ddlCustomerModify.DataSource = null;
            ddlCustomerModify.DataBind();
            ddlCompanyGroupModify.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlCustomerModify.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlWorkOrderModify.Items.Clear();
            ddlWorkOrderModify.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            clearWoActiviyDropDownModify();

        }
    }

    protected void ClearGrdBoxDetails(GridView grvctrl)
    {
        for (int i = 0; i < 25; i++)
        {
            AddBoxDetails(-1, 0, "", "",0);
        }
        bindBoxdetails(grvctrl);
        if (grvctrl.Rows.Count > 0)
        {
            //This replaces <td> with <th> and adds the scope attribute
            grvctrl.UseAccessibleHeader = true;
            //This will add the <thead> and <tbody> elements
            grvctrl.HeaderRow.TableSection = TableRowSection.TableHeader;

            //This adds the <tfoot> element. 
            //Remove if you don't have a footer row
            //gvTheGrid.FooterRow.TableSection = TableRowSection.TableFooter;
        }
    }

    protected void rbtactivityType_SelectedIndexChanged(object sender, EventArgs e)
    {
        clearAllSave();

        if (rbtactivityType.SelectedItem.Value == "1")
        {
            lblActivityName.Text = "New Standard Box Cost (1.50 Cubic Ft.)";
            binddefaultBoxDetailsGrid(grdboxdetails);
            ViewState["FileDetailsTable"] = null;
            //bindfiledetails();
            grdFilesDetails.Visible = false;
            grdboxdetails.Visible = true;

            lnkbtnviewWoActivityDetails.Visible = false;
            gridviewWoActivityDetails.DataSource = null;
            gridviewWoActivityDetails.DataBind();
            lblTotalCount.Text = "";
            lblTotalCount.Visible = false;
            ddlCompanyGroup.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlWorkOrderActivity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
        else
        {
            lblActivityName.Text = "Bar-coding & Data Entry (File & Box)";
            binddefaultFileDetailsGrid(grdFilesDetails);
            grdboxdetails.Visible = false;
            grdFilesDetails.Visible = true;
            ViewState["dtBoxDetailsTable"] = null;
            bindBoxdetails(grdboxdetails);
            lnkbtnviewWoActivityDetails.Visible = false;
            gridviewWoActivityDetails.DataSource = null;
            gridviewWoActivityDetails.DataBind();
            lblTotalCount.Text = "";
            lblTotalCount.Visible = false;
            ddlCompanyGroup.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlWorkOrderActivity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
    }

    protected void rbtactivityTypeModify_SelectedIndexChanged(object sender, EventArgs e)
    {
        //clearAllModify();
        GetBoxFileDataByWorkOrderNo(ddlWorkOrderModify, "Pending");
        if (rbtactivityTypeModify.SelectedValue == "1")
        {
            if (ViewState["dtBoxDetailsTable"] != null)
            {
                if (((DataTable)ViewState["dtBoxDetailsTable"]).Rows.Count > 0)
                {
                    grdboxdetailsModify.DataSource = ViewState["dtBoxDetailsTable"];
                    grdboxdetailsModify.DataBind();
                    grdboxdetailsModify.Visible = true;
                    grdFilesDetailsModify.Visible = false;
                }
            }
            else
            {
                bindBoxdetails(grdboxdetailsModify);
                grdboxdetailsModify.Visible = true;
                grdFilesDetailsModify.Visible = false;
            }
        }
        else
        {
            if (ViewState["FileDetailsTable"] != null)
            {
                if (((DataTable)ViewState["FileDetailsTable"]).Rows.Count > 0)
                {
                    grdFilesDetailsModify.DataSource = ViewState["FileDetailsTable"];
                    grdFilesDetailsModify.DataBind();
                    grdboxdetailsModify.Visible = false;
                    grdFilesDetailsModify.Visible = true;
                }
            }
            else
            {
                bindfiledetails(grdFilesDetailsModify);
                grdboxdetailsModify.Visible = false;
                grdFilesDetailsModify.Visible = true;
            }

        }
    }

    


    public string Getyear(object Year)
    {
        if (!string.IsNullOrEmpty(Convert.ToString(Year)))
        {
            return Convert.ToString(Year);
        }
        return " ";
    }
    public string GetFromatedDate(object FromatDate)
    {
        if (!string.IsNullOrEmpty(Convert.ToString(FromatDate)))
        {
            DateTime? FormatdedDate = Convert.ToDateTime(FromatDate, enGB);
            return Convert.ToDateTime(FromatDate, enGB).ToShortDateString();
        }
        return " ";
    }

    //protected void Timer1_Tick(object sender, EventArgs e)
    //{
    //    lbltimerUpdate.Text = "Last Update" + DateTime.Now.ToLongTimeString();
    //}
    protected void lnkbtnMaker_Click(object sender, EventArgs e)
    {
        ViewState["Action"] = "N";
        clearAllSave();
        BindNewMaker();
        if (rbtactivityType.SelectedItem.Value == "1")
        {
            lblActivityName.Text = "New Standard Box Cost (1.50 Cubic Ft.)";
            binddefaultBoxDetailsGrid(grdboxdetails);
            ViewState["FileDetailsTable"] = null;
            //bindfiledetails();
            grdFilesDetails.Visible = false;
            grdboxdetails.Visible = true;
            lnkbtnviewWoActivityDetails.Visible = false;
            gridviewWoActivityDetails.DataSource = null;
            gridviewWoActivityDetails.DataBind();
            lblTotalCount.Text = "";
            lblTotalCount.Visible = false;
        }
        else
        {
            lblActivityName.Text = "Bar-coding & Data Entry (File & Box)";
            binddefaultFileDetailsGrid(grdFilesDetails);
            grdboxdetails.Visible = false;
            grdFilesDetails.Visible = true;
            ViewState["dtBoxDetailsTable"] = null;
            bindBoxdetails(grdboxdetails);
            lnkbtnviewWoActivityDetails.Visible = false;
            gridviewWoActivityDetails.DataSource = null;
            gridviewWoActivityDetails.DataBind();
            lblTotalCount.Text = "";
            lblTotalCount.Visible = false;
        }
    }
    protected void lnkbtnModifyMaker_Click(object sender, EventArgs e)
    {
        clearAllModify();
        ViewState["Action"] = "U";
        BindModifyMaker();
        if (rbtactivityTypeModify.SelectedValue == "1")
        {
            lblActivityNameModify.Text = "New Standard Box Cost (1.50 Cubic Ft.)";
            ViewState["FileDetailsTable"] = null;
            grdFilesDetailsModify.Visible = false;
            grdboxdetailsModify.Visible = false;
            lnkbtnviewWoActivityDetailsModify.Visible = false;
            gridviewWoActivityDetails.DataSource = null;
            gridviewWoActivityDetails.DataBind();
            lblTotalCountModify.Text = "";
            lblTotalCountModify.Visible = false;
        }
        else
        {
            lblActivityNameModify.Text = "Bar-coding & Data Entry (File & Box)";
            grdboxdetailsModify.Visible = false;
            grdFilesDetailsModify.Visible = false;
            ViewState["dtBoxDetailsTable"] = null;
            lnkbtnviewWoActivityDetailsModify.Visible = false;
            gridviewWoActivityDetails.DataSource = null;
            gridviewWoActivityDetails.DataBind();
            lblTotalCountModify.Text = "";
            lblTotalCountModify.Visible = false;
        }
    }
    protected void lnkbtnChecker_Click(object sender, EventArgs e)
    {
        ViewState["Action"] = "C";
        clearAllChecker();
       BindChecker();

        lblActivityNameChecker.Text = "Bar-coding & Data Entry (File & Box)";
        grdFilesDetailsChecker.Visible = false;
        ViewState["dtBoxDetailsTable"] = null;
        
    }

    protected void btnApprove_Click(object sender, EventArgs e)
    {

        try
        {
            Page.Validate("CheckerGroup");
            if (Page.IsValid)
            {
                int iCustId = Convert.ToInt32(ddlCustomerChecker.SelectedValue);
                Int16 iWareHousId = Convert.ToInt16(ddlWareHouseChecker.SelectedValue);
                string msg = "Record saved successfully.";
                bool isError = true;
             
                    string xmlBoxFileData;
                    Int16 iStatus = GetBoxFileStatus("In");
                    DataSet dsxml = new DataSet();
                    DataTable dtBoxFileDetails = new DataTable();
                    dtBoxFileDetails = FileDetailsTable().Clone();
                    dtBoxFileDetails.TableName = "Root";
                    DataSet dsResult = new DataSet();
                    UpdateFileDataTable(grdFilesDetailsChecker);
                    
                  

                    if (string.IsNullOrWhiteSpace(rbtApprovedRejectChecker.SelectedValue))
                    {
                        lblMsg.Text = "Please Select either approved or reject for records.";
                        ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "ShowdivDuplicate();", true);
                        return;
                    }


                    string strFilter = "FileStatus = 'Reject' AND FileRemarks <>''";
                    DataRow[] foundRemarkrows = FileDetailsTable().Select(strFilter);
                    if (foundRemarkrows.Length == 0 && rbtApprovedRejectChecker.SelectedValue !="1")
                    {
                        lblMsg.Text = "Please enter at least one rejection remark.";
                        ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "ShowdivDuplicate();", true);
                        return;
                    }
                   
                   
                    dtBoxFileDetails = FileDetailsTable();
                    dtBoxFileDetails.AcceptChanges();
                    dsxml.Tables.Add(dtBoxFileDetails);
                    dsxml.Tables[0].TableName = "Root";
                    dsxml.AcceptChanges();
                    xmlBoxFileData = dsxml.GetXml();
                    objPRSMTransBAL.ApproveFileDetails(iCustId, iWareHousId, xmlBoxFileData, Convert.ToInt32(ddlWorkOrderChecker.SelectedItem.Value), Convert.ToInt16(UserId), 0);

                    string StrStatus = string.Empty;
                    StrStatus = rbtApprovedRejectChecker.SelectedItem.Text;
                    ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('Record " + StrStatus + " successfully.')", true);


            lnkbtnChecker_Click(null, null);



            }
        }
        catch
        { 
        
        }
    }
    protected void btnCancelApprove_Click(object sender, EventArgs e)
    {
        clearAllChecker();
        lblMsg.Text = "";
        grdFilesDetailsChecker.Visible = false;
        GetNonApprovedWorkOrderNo("Pending", ddlWorkOrderChecker);
    }

    protected void BindNewMaker()
    {
        divNewMaker.Style["display"] = "block";
        divModifyMaker.Style["display"] = "none";
        divChecker.Style["display"] = "none";
        ViewState["Action"] = "N";
        NewInwardOutward();
        lnkbtnChecker.Style["color"] = "#4f4f4f !important;";
        lnkbtnModifyMaker.Style["color"] = "#4f4f4f !important;";
        lnkbtnMaker.Style["color"] = "blue !important;";
        rbtactivityType.SelectedValue = "1";
    }

    protected void BindModifyMaker()
    {
        divNewMaker.Style["display"] = "none";
        divModifyMaker.Style["display"] = "block";
        divChecker.Style["display"] = "none";
       GetNonApprovedWorkOrderNo("Reject",ddlWorkOrderModify);
        lnkbtnChecker.Style["color"] = "#4f4f4f !important;";
        lnkbtnMaker.Style["color"] = "#4f4f4f !important;";
        lnkbtnModifyMaker.Style["color"] = "blue !important;";
        rbtactivityTypeModify.SelectedValue = "2";
    }
    protected void BindChecker()
    {
        divNewMaker.Style["display"] = "none";
        divModifyMaker.Style["display"] = "none";
        divChecker.Style["display"] = "block";
        GetNonApprovedWorkOrderNo("Pending", ddlWorkOrderChecker);
        lnkbtnModifyMaker.Style["color"] = "#4f4f4f !important;";
        lnkbtnMaker.Style["color"] = "#4f4f4f !important;";
        lnkbtnChecker.Style["color"] = "blue !important;";
        //rbtactivityTypeChecker.SelectedValue = "1";
    }

    #region [Update Maker]

     #region [Bind All DropDown]

    protected void BindAllDropDownByWorkOrderNo(DropDownList ddlWorkOder,DropDownList ddlCustomer,DropDownList ddlCompany,DropDownList ddlWareHouse)
    {
        DataTable Dt = objPRSMTransBAL.GetCustmerCompanyWareHouseDataByWorkOrderNo(Convert.ToInt64(ddlWorkOder.SelectedValue));
        ddlCustomer.Items.Clear();
        ddlCustomer.DataSource = Dt;
        ddlCustomer.DataValueField = "n_CustomerId";
        ddlCustomer.DataTextField = "s_CustomerName";
        ddlCustomer.DataBind();

        ddlCompany.Items.Clear();
        ddlCompany.DataSource = Dt;
        ddlCompany.DataValueField = "n_CompanyGroupId";
        ddlCompany.DataTextField = "s_CGName";
        ddlCompany.DataBind();


        ddlWareHouse.Items.Clear();
        ddlWareHouse.DataSource = Dt;
        ddlWareHouse.DataValueField = "n_WareHouseId";
        ddlWareHouse.DataTextField = "s_WarehouseName";
        ddlWareHouse.DataBind();
        
    }
     #endregion


    protected void GetNonApprovedWorkOrderNo(string strStatus, DropDownList ddlWorkOrder)
    {
        DataTable Dt = null;
        string strFilter = "s_AppCodeName='" + strStatus + "'";
        DataRow[] foundrows = objPRSMTransBAL.GetNoneApprovedWorkOrderNo().Select(strFilter);
        if (foundrows.Length > 0)
        {
            Dt = foundrows.CopyToDataTable<DataRow>();
        }


        ddlWorkOrder.Items.Clear();
        ddlWorkOrder.DataSource = Dt;
        ddlWorkOrder.DataValueField = "n_WorkOrderNo";
        ddlWorkOrder.DataTextField = "n_WorkOrderNo";
        ddlWorkOrder.DataBind();
        ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }

    protected void GetBoxFileDataByWorkOrderNo(DropDownList ddlWorkOder, string strStatus)
    {
        DataSet Ds = objPRSMTransBAL.GetBoxFileDataByWorkOrderNo(Convert.ToInt64(ddlWorkOder.SelectedValue));

        DataTable Dt = null;
       
        DataRow[] foundrows = null;

        string strFilter = string.Empty;

        if (Convert.ToString(ViewState["Action"]) == "C")
        {
            //strFilter = "BoxStatus='" + strStatus + "'";

            //foundrows = Ds.Tables[0].Select(strFilter);
            foundrows = Ds.Tables[0].Select();
            if (foundrows.Length > 0)
            {
                Dt = foundrows.CopyToDataTable<DataRow>();
                ViewState["dtBoxDetailsTable"] = Dt;
            }
            else
            {
                ViewState["dtBoxDetailsTable"] = null;
            }
         
            strFilter = "FileStatus='" + strStatus + "'";
            foundrows = Ds.Tables[1].Select(strFilter);
            if (foundrows.Length > 0)
            {
                Dt = foundrows.CopyToDataTable<DataRow>();
                ViewState["FileDetailsTable"] = Dt;
            }
            else
            {
                ViewState["FileDetailsTable"] = null;
            }
          
        }
        if (Convert.ToString(ViewState["Action"]) == "U")
        {
            //strFilter = "BoxStatus <> '" + strStatus + "'";
            //foundrows = Ds.Tables[0].Select(strFilter);
            foundrows = Ds.Tables[0].Select();
            IEnumerable<DataRow> OrderByData = null;
            if (foundrows.Length > 0)
            {
                Dt = foundrows.CopyToDataTable<DataRow>();

                //OrderByData = from dtls in Dt.AsEnumerable()
                //                                   orderby dtls.Field<int>("BoxId")
                //                                   orderby dtls.Field<string>("BoxStatus") descending
                //                                   select dtls;

               // ViewState["dtBoxDetailsTable"] = OrderByData.CopyToDataTable<DataRow>();
                ViewState["dtBoxDetailsTable"] = Dt;
            }

            else
            {
                ViewState["dtBoxDetailsTable"] = null;
            }
            strFilter = "FileStatus <> '" + strStatus + "'";
            foundrows = Ds.Tables[1].Select(strFilter);

            if (foundrows.Length > 0)
            {
                Dt = foundrows.CopyToDataTable<DataRow>();


                OrderByData = from dtls in Dt.AsEnumerable()
                              orderby dtls.Field<int>("FileId")
                              orderby dtls.Field<string>("FileStatus") descending
                              select dtls;

                ViewState["FileDetailsTable"] = OrderByData.CopyToDataTable<DataRow>();
            }
            else
            {
                ViewState["FileDetailsTable"] = null;
            }
        }
    }

    #endregion


    //protected string GetFunctionForBoxBarCode(object IndexNo,string Grd)
    //{


    //    //foreach (GridViewRow row in Grd.Rows)
    //    //{

    //    //TextBox txtotherServicesBoxBarCode = (TextBox)row.FindControl("txtotherServicesBoxBarCode");
    //    ////TextBox txtOtherServicesFileBarcode = (TextBox)row.FindControl("txtOtherServicesFileBarcode");
    //    ////if (txtotherServicesBoxBarCode.Text == "")
    //    ////{
    //    ////    txtOtherServicesFileBarcode.Text = "";
    //    ////}
    //    //}

    //    string strIndexNo = "#ContentPlaceHolder1_" + Grd + "_selectedValue_" + Convert.ToString(IndexNo);
    //    string functionName = "autocompDrop(this.id,'" + strIndexNo + "');";
    //    return functionName;
    //}
    //protected string GetFunctionForFileBarCode(object IndexNo, string Grd)
    //{
    //    string strIndexNo = "#ContentPlaceHolder1_" + Grd + "_selectedValue_" + Convert.ToString(IndexNo);
    //    string functionName = "autocompDropFile(this.id,'" + strIndexNo + "');";
    //    return functionName;
    //}




    #region Autocomplete extender for Box BarCode And Filre Barcode
    [System.Web.Services.WebMethod]
    [System.Web.Script.Services.ScriptMethod()]
    public static List<Autocomplete> GetBoxBarCode(string prefix, string CustomerId, int BoxFileStatus)
    {
        short iInOutStatus = 0;
       
        
        DataSet ds = objTRANSStBAL.GetBoxbarCode(Convert.ToInt32(CustomerId), iInOutStatus);
        List<Autocomplete> result = new List<Autocomplete>();
        if (ds.Tables.Count > 0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    result.Add(new Autocomplete
                    {
                        label = Convert.ToString(ds.Tables[0].Rows[i]["BoxBarCode"]),
                        value = Convert.ToInt32(ds.Tables[0].Rows[i]["BoxId"])
                    });
                }
            }
        }
        var res = result.ToList().Where(r => r.label.ToLower().IndexOf(prefix.ToLower()) != -1);
        return res.ToList();
    }
    //[System.Web.Services.WebMethod]
    //[System.Web.Script.Services.ScriptMethod()]
    //public static List<Autocomplete> GetFileBaCode(string prefix, string CustomerId, string BoxId, int FileStatus)
    //{
    //    short iInOutStatus = 0;
    //    switch (Convert.ToInt16(FileStatus))
    //    {
    //        case 1:
    //            iInOutStatus = Convert.ToInt16(GetBoxFileStatus("In"));
    //            break;
    //        case 2:
    //            iInOutStatus = Convert.ToInt16(GetBoxFileStatus("Out"));
    //            break;
    //        default:
    //            break;
    //    }

    //    int iBoxId = 0;
    //    if (!string.IsNullOrEmpty(BoxId))
    //    {
    //        iBoxId = Convert.ToInt32(BoxId);
    //    }
    //    DataSet ds = objTRANSStBAL.GetFileBarCode(Convert.ToInt32(CustomerId), iBoxId, iInOutStatus);
    //    List<Autocomplete> result = new List<Autocomplete>();
    //    if (ds.Tables.Count > 0)
    //    {
    //        if (ds.Tables[0].Rows.Count > 0)
    //        {
    //            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
    //            {
    //                result.Add(new Autocomplete
    //                {
    //                    label = Convert.ToString(ds.Tables[0].Rows[i]["FileBarCode"]),
    //                    value = Convert.ToInt32(ds.Tables[0].Rows[i]["FileId"])
    //                });
    //            }
    //        }
    //    }
    //    var res = result.ToList().Where(r => r.label.ToLower().IndexOf(prefix.ToLower()) != -1);
    //    return res.ToList();
    //}

    #endregion Autocomplete extender for Box BarCode And Filre Barcode



    protected string GetFunctionForBoxBarCode(object IndexNo)
    {



        string strIndexNo = "#ContentPlaceHolder1_grdboxdetails_selectedValue_" + Convert.ToString(IndexNo);
        string functionName = "autocompDrop(this.id,'" + strIndexNo + "');";
        return functionName;
    }


    //protected string GetFunctionForFileBarCode(object IndexNo)
    //{
    //    string strIndexNo = "#ContentPlaceHolder1_grdOtherServicesFiles_selectedValueOtherServices_" + Convert.ToString(IndexNo);
    //    string functionName = "autocompDropFile(this.id,'" + strIndexNo + "');";
    //    return functionName;
    //}




   
}