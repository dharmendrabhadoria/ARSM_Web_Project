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


public partial class Transaction_FreshPickup : PageBase 
{
    PRSMBAL.MasterBAL objPRSMBAL = new MasterBAL();
    PRSMBAL.TransactionBAL objPRSMTransBAL = new TransactionBAL();
    private System.Globalization.CultureInfo enGB = new System.Globalization.CultureInfo("en-GB");
    protected void Page_Load(object sender, EventArgs e)
    {
        if (UserId == 0)

        {
            Response.Redirect("~/User/Login.aspx", false);
        }
        if (!IsPostBack)
        {
            NewInwardOutward();
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
        BindDdlWareHouse();
        rbtactivityType.Items[0].Selected = true;
        lblActivityName.Text = "New Standard Box Cost (1.50 Cubic Ft.)";
        binddefaultBoxDetailsGrid();
        ViewState["FileDetailsTable"] = null;
        bindfiledetails();
    }

    protected void binddefaultFileDetailsGrid()
    {

        for (int i = 1; i <= 25; i++)
        {
            AddFilesDetails(-1, 0, "", "", "", 0, "", Convert.ToDateTime(null).ToString("dd-MM-yyyy", CultureInfo), Convert.ToDateTime(null).ToString("dd-MM-yyyy", CultureInfo), "", "", "");
        }
        bindfiledetails();
        if (grdFilesDetails.Rows.Count >0)
        {
            grdFilesDetails.UseAccessibleHeader = true;
            //This will add the <thead> and <tbody> elements
            grdFilesDetails.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
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
        DataSet dsCustomer = objPRSMBAL.GetCustomer(iCompanyId);
        ddlCustomer.DataSource = dsCustomer.Tables[0]; 
        ddlCustomer.DataValueField = "CustomerId";
        ddlCustomer.DataTextField = "CustomerName";
        ddlCustomer.DataBind();
        ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }
    private void BindDdlWareHouse()
    {
        ddlWareHouse.DataSource = objPRSMBAL.GetWareHouse(0);
        ddlWareHouse.DataValueField = "WareHouseId";
        ddlWareHouse.DataTextField = "WarehouseName";
        ddlWareHouse.DataBind();
        ddlWareHouse.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
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
        int rowindex = 0;
        string strBoxBarCode = "", strFileBarCode = "", strFileName = "", strDepart = "", stryear = "", strFdate = "", strEdate = "", strLabel1 = "", strLabel2 = "", strLabel3 = "";
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
        AddFilesDetails(-1,0, strBoxBarCode, strFileBarCode, strFileName, Convert.ToInt32(strDepart), stryear,strFdate,strEdate, strLabel1, strLabel2, strLabel3);
        txtBoxBarCode.Focus();
        bindfiledetails();
    }

    protected void ddlCompanyGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlCompanyGroup.SelectedIndex > 0)
        {
            BindCustomer(Convert.ToByte(ddlCompanyGroup.SelectedItem.Value));
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

    protected void clearWoActiviyDropDown()
    {
        ddlWorkOrderActivity.Items.Clear();
        ddlWorkOrderActivity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        lblTotalCount.Visible = false;
        lnkbtnviewWoActivityDetails.Visible = false; 
    
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
            dtBoxDetails.AcceptChanges();
        }
        else
        {
            dtBoxDetails = (DataTable)ViewState["dtBoxDetailsTable"];
        }
        return dtBoxDetails;
    }
    protected void AddBoxDetails(int iSrNo, int iBoxId, string sBoxBarCode,string sBoxLocCode)
    {
        DataTable dtBoxDetails;
        DataRow drBoxDetails;
        dtBoxDetails = BoxDetailsTable();
        try
        {
            drBoxDetails = dtBoxDetails.NewRow();
            if (iSrNo == -1)
            {
                drBoxDetails["BoxId"]          = iBoxId;
                drBoxDetails["BoxBarCode"]     = sBoxBarCode;
                drBoxDetails["BoxLocCode"]     = sBoxLocCode;
                dtBoxDetails.Rows.Add(drBoxDetails);
                dtBoxDetails.AcceptChanges();
            }
            else
            {
                dtBoxDetails.Rows[iSrNo]["BoxId"]         = iBoxId;
                dtBoxDetails.Rows[iSrNo]["BoxBarCode"]    = sBoxBarCode;
                dtBoxDetails.Rows[iSrNo]["BoxLocCode"]    = sBoxLocCode;
                dtBoxDetails.AcceptChanges();
            }
            ViewState["dtBoxDetailsTable"] = dtBoxDetails;
        }
        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }
    
    }

    protected void binddefaultBoxDetailsGrid()
    {
        for (int i = 0; i < 25; i++)
        {
            AddBoxDetails(-1,0,"","");
        }
            bindBoxdetails();
        if (grdboxdetails.Rows.Count > 0)
        {
            grdboxdetails.UseAccessibleHeader = true;
            grdboxdetails.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
    }

    protected void bindBoxdetails()
    {
        grdboxdetails.DataSource = null;
        grdboxdetails.DataBind();
        grdboxdetails.DataSource = BoxDetailsTable();
        grdboxdetails.DataBind();
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
            dtFileDetails.Columns.Add("DepartmentId", typeof(int));
            dtFileDetails.Columns.Add("sYear", typeof(String));
            dtFileDetails.Columns.Add("FromDate", typeof(String));
            dtFileDetails.Columns.Add("EndDate", typeof(String));
            dtFileDetails.Columns.Add("Label1", typeof(String));
            dtFileDetails.Columns.Add("Label2", typeof(String));
            dtFileDetails.Columns.Add("Label3", typeof(String));
            dtFileDetails.AcceptChanges();
        }
        else
        {
            dtFileDetails = (DataTable)ViewState["FileDetailsTable"];
        }
        return dtFileDetails;
    }

    protected void AddFilesDetails(int iSrNo, int FileId, string BoxBarCode, string FileBarCode, string sFileName, int DepartmentId, string sYear, String FromDate, String EndDate, string Label1, string Label2, string Label3)
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
                drFilesDetails["sFileName"] = sFileName;
                drFilesDetails["DepartmentId"] = DepartmentId;
                drFilesDetails["sYear"]    = sYear;
                drFilesDetails["FromDate"] = FromDate.ToString().Replace("01-01-0001","");
                drFilesDetails["EndDate"] = EndDate.ToString().Replace("01-01-0001",""); 
                drFilesDetails["Label1"]   = Label1;
                drFilesDetails["Label2"]   = Label2;
                drFilesDetails["Label3"]   = Label3;
                dtFilesDetails.Rows.Add(drFilesDetails);
                dtFilesDetails.AcceptChanges();
            }
            else
            {
                dtFilesDetails.Rows[iSrNo]["FileId"] = FileId;
                dtFilesDetails.Rows[iSrNo]["BoxBarCode"] = BoxBarCode;
                dtFilesDetails.Rows[iSrNo]["FileBarCode"] = FileBarCode;
                dtFilesDetails.Rows[iSrNo]["sFileName"] = sFileName;
                dtFilesDetails.Rows[iSrNo]["DepartmentId"] = DepartmentId;
                dtFilesDetails.Rows[iSrNo]["sYear"] = sYear;
                dtFilesDetails.Rows[iSrNo]["FromDate"] = FromDate.ToString().Replace("01-01-0001","");
                dtFilesDetails.Rows[iSrNo]["EndDate"] = EndDate.ToString().Replace("01-01-0001","");
                dtFilesDetails.Rows[iSrNo]["Label1"] = Label1;
                dtFilesDetails.Rows[iSrNo]["Label2"] = Label2;
                dtFilesDetails.Rows[iSrNo]["Label3"] = Label3;
                dtFilesDetails.Rows[iSrNo]["FileId"] = FileId;
                dtFilesDetails.AcceptChanges();
            }
            ViewState["FileDetailsTable"] = dtFilesDetails;
        }
        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }
    }

  protected void bindfiledetails()
    {
        grdFilesDetails.DataSource = null;
        grdFilesDetails.DataBind();
        grdFilesDetails.DataSource = FileDetailsTable();
        grdFilesDetails.DataBind();
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
            bindfiledetails();
            if (grdFilesDetails.Rows.Count == 0)
            {
                binddefaultFileDetailsGrid();
            }
        }
    }
    protected void ddlCustomer_SelectedIndexChanged(object sender, EventArgs e)
    {
        int iCompgroupId,icustomerid, iwarehouseid, istatus;
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
            bindWorkOrder(iCompgroupId,icustomerid, iwarehouseid, istatus);
        }
        else
        {
            ddlWorkOrder.Items.Clear(); 
            ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            clearWoActiviyDropDown();
        }

    }
    protected void bindWorkOrder(int icompgroupId, int icustomerid, int iwarehouseid, int istatus)
    {
        DataSet dsWorkOrder = objPRSMTransBAL.GetWorkOrder(0,icompgroupId, icustomerid, iwarehouseid, istatus, null, null);
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
    protected void bindWorkOrderActivites(int iWorkorderNo, int istatus)
    {
        ddlWorkOrderActivity.DataSource = null;
        ddlWorkOrderActivity.DataBind();
        DataSet dsWorkOrderActivity = objPRSMTransBAL.GetWoActivity(0, iWorkorderNo, istatus, "Fresh Pick-up",0);
       // ddlWorkOrderActivity.DataSource = dsWorkOrderActivity.Tables[0];
        //ddlWorkOrderActivity.DataValueField = "WOActivityId";
        //ddlWorkOrderActivity.DataTextField = "ActivityName" ;
        //ddlWorkOrderActivity.DataTextField = "PickUpAddress"; 
        //ddlWorkOrderActivity.DataBind();
        string ActivityName = "";
        if (rbtactivityType.SelectedItem.Value == "1")
        {
            ActivityName = "New Standard Box Cost (1.50 Cubic Ft.)";
        }
        else
        {
            ActivityName = "Bar-coding & Data Entry (File & Box)";
        }
        ddlWorkOrderActivity.Items.Clear();
        for (int i = 0; i < dsWorkOrderActivity.Tables[0].Rows.Count  ; i++)
        {
            if (ActivityName == Convert.ToString(dsWorkOrderActivity.Tables[0].Rows[i]["ActivityName"]))
            {
                ddlWorkOrderActivity.Items.Add(new ListItem( Convert.ToString(dsWorkOrderActivity.Tables[0].Rows[i]["PickUpAddress"]), Convert.ToString(dsWorkOrderActivity.Tables[0].Rows[i]["WOActivityId"])));  
            }
            
        }
        ddlWorkOrderActivity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }
    protected void ddlWorkOrder_SelectedIndexChanged(object sender, EventArgs e)
    {
     
        int istatus = GetWorkActivityStatus("Open");
       if (ddlWorkOrder.SelectedIndex > 0)
        {

            bindWorkOrderActivites(Convert.ToInt32(ddlWorkOrder.SelectedItem.Value), istatus);
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

    /// <summary>
    /// </summary>
    /// <param name="Status">In,Out,Permanent Out,Destroy</param>
    /// <returns></returns>
    protected Byte GetBoxFileStatus(string Status)
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
    protected void clearAll()
    {
      
    ViewState["FileDetailsTable"] = null;
    ddlCustomer.Items.Clear();  
    ddlWorkOrderActivity.Items.Clear();
    lnkbtnviewWoActivityDetails.Visible = false;
    ddlWorkOrder.Items.Clear();
     ddlWareHouse.SelectedIndex = 0;
    if (ddlCompanyGroup.Items.Count > 0)
    {
        ddlCompanyGroup.SelectedIndex = 0;
    }
    ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    ddlWorkOrderActivity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" }); 
    }

    protected void UpdateBoxDataTable()
    {
        try
        {
            for (int i = 0; i < grdboxdetails.Rows.Count; i++)
            {
                TextBox txtBoxBarCode = (TextBox)grdboxdetails.Rows[i].FindControl("txtBoxBarCode");
                TextBox txtBoxLocCode = (TextBox)grdboxdetails.Rows[i].FindControl("txtBoxLocCode");
                //int rowindex = 0;
                string strBoxBarCode = "", strBoxLocCode = "";
                strBoxBarCode        = txtBoxBarCode.Text;
                strBoxLocCode        = txtBoxLocCode.Text;
                int boxid = 0;
                if (strBoxBarCode.Trim() != "")
                {
                    boxid = 1;
                }
                if (boxid != 0)
                {
                    AddBoxDetails(-1, boxid, strBoxBarCode,strBoxLocCode);
                }
            }
        }
        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }
    }
    protected void UpdateFileDataTable()
    {
        try
        {
        for (int i = 0; i < grdFilesDetails.Rows.Count  ; i++)
        {
        TextBox txtBoxBarCode = (TextBox)grdFilesDetails.Rows[i].FindControl("txtBoxBarCode");
        TextBox txtFileBarCode = (TextBox)grdFilesDetails.Rows[i].FindControl("txtFileBarCode");
        TextBox txtFilename = (TextBox)grdFilesDetails.Rows[i].FindControl("txtFilename");
        DropDownList ddldepart = (DropDownList)grdFilesDetails.Rows[i].FindControl("ddlDepart");
        TextBox txtyear = (TextBox)grdFilesDetails.Rows[i].FindControl("txtyear");
        TextBox txtFdate = (TextBox)grdFilesDetails.Rows[i].FindControl("txtFdate");
        TextBox txtEdate = (TextBox)grdFilesDetails.Rows[i].FindControl("txtEdate");
        TextBox txtlabel1 = (TextBox)grdFilesDetails.Rows[i].FindControl("txtlabel1");
        TextBox txtlabel2 = (TextBox)grdFilesDetails.Rows[i].FindControl("txtlabel2");
        TextBox txtlabel3 = (TextBox)grdFilesDetails.Rows[i].FindControl("txtlabel3");
       // int rowindex = 0;
        string strBoxBarCode = "", strFileBarCode = "", strFileName = "", stryear = "", strFdate = "", strEdate = "", strLabel1 = "", strLabel2 = "", strLabel3="";
            strBoxBarCode = txtBoxBarCode.Text;
            strFileBarCode = txtFileBarCode.Text;
            strFileName = txtFilename.Text;
       int  iDepart =Convert.ToInt32(ddldepart.SelectedValue);
            stryear =   txtyear.Text;
            strFdate =  txtFdate.Text;
            strEdate =  txtEdate.Text;
            strLabel1 = txtlabel1.Text;
            strLabel2 = txtlabel2.Text;
            strLabel3 = txtlabel3.Text;
        int fileid = 0;
        if (strFileBarCode.Trim()!= "" && strBoxBarCode!= "")
        {
            fileid = 1;
        }
        if (fileid != 0)
        {
            AddFilesDetails(i, fileid, strBoxBarCode, strFileBarCode, strFileName,iDepart,stryear, strFdate, strEdate, strLabel1, strLabel2, strLabel3);
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
            Page.Validate(); 
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
                    UpdateBoxDataTable();
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
                    dsBoxDuplicate = objPRSMTransBAL.InsertUpdateBoxDetails(iCustId,iWareHousId,xmlBoxData, Convert.ToInt32(ddlWorkOrderActivity.SelectedValue), Convert.ToInt16(UserId), 0); 
                    if (dsBoxDuplicate.Tables.Count != 0)
                   {
                       if (dsBoxDuplicate.Tables[0].Rows.Count > 0)
                       {
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
                               clearAll();
                               ViewState["dtBoxDetailsTable"] = null;
                               ClearGrdBoxDetails();
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
                    Byte iStatus = GetBoxFileStatus("In");
                    DataSet dsxml = new DataSet();
                    DataTable dtBoxFileDetails = new DataTable();
                    dtBoxFileDetails = FileDetailsTable().Clone();
                    dtBoxFileDetails.TableName = "Root";
                    DataSet dsResult = new DataSet();
                    UpdateFileDataTable();
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
                    dsResult = objPRSMTransBAL.InsertUpdateFileDetails(iCustId, iWareHousId, xmlBoxFileData, Convert.ToInt32(ddlWorkOrderActivity.SelectedItem.Value), 0, Convert.ToInt16(UserId));
                    //msg += ",";
                    if (dsResult.Tables.Count != 0)
                    {
                        if (dsResult.Tables[0].Rows.Count > 0)
                        {
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
                                clearAll();
                                lblTotalCount.Text = "";
                                binddefaultFileDetailsGrid();
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
                    clearAll();
                   
                    binddefaultFileDetailsGrid();
                }
            }
        }
        catch (Exception ex )
        {
            ErrorHandler.WriteLog(ex);  
         }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        clearAll();
        lnkbtnviewWoActivityDetails.Visible = false;
        lblTotalCount.Text = "";
        lblMsg.Text = "";
        if (rbtactivityType.SelectedItem.Value == "1")
        {
            grdFilesDetails.Visible = false;
            grdboxdetails.Visible = true;
            ClearGrdBoxDetails();
        }
        else
        {
           
            grdFilesDetails.Visible = true;
            grdboxdetails.Visible = false;
            binddefaultFileDetailsGrid();
        }
        
    }
    #region [Rolewise access page funcationality]
    public void SetRolewiseAcessfuncationality()
    {
        UserRolewiseAcess objUserRoleWiseAcessDAL = new UserRolewiseAcess();
        DataTable dtPageId = objUserRoleWiseAcessDAL.GetApplicationCodeDetails("Page_Name", "Fresh Pick-up").Tables[0];
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

                            int BoxCount=0, FileCount=0, TotalBoxAdded=0, TotalFileAdded=0;
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
    protected void ddlWorkOrderActivity_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindActivityViewDetails();
    }
    protected void lnkbtnviewWoActivityDetails_Click(object sender, EventArgs e)
    {

    }
    protected void ddlWareHouse_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlWareHouse.SelectedIndex > 0)
        {
            BindCompanyGroup(0);
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

    protected void ClearGrdBoxDetails()
    {
        for (int i = 0; i < 25; i++)
        {
            AddBoxDetails(-1,0,"","");
        }
        bindBoxdetails(); 
        if (grdboxdetails.Rows.Count > 0)
        {
            //This replaces <td> with <th> and adds the scope attribute
            grdboxdetails.UseAccessibleHeader = true;
            //This will add the <thead> and <tbody> elements
            grdboxdetails.HeaderRow.TableSection = TableRowSection.TableHeader;

            //This adds the <tfoot> element. 
            //Remove if you don't have a footer row
            //gvTheGrid.FooterRow.TableSection = TableRowSection.TableFooter;
        }
    }

    protected void rbtactivityType_SelectedIndexChanged(object sender, EventArgs e)
    {
        clearAll();
        
        if (rbtactivityType.SelectedItem.Value == "1")
        {
            lblActivityName.Text = "New Standard Box Cost (1.50 Cubic Ft.)";
            binddefaultBoxDetailsGrid();
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
   
            binddefaultFileDetailsGrid();
            grdboxdetails.Visible = false;
            grdFilesDetails.Visible = true;
            ViewState["dtBoxDetailsTable"] = null;
            bindBoxdetails();
            lnkbtnviewWoActivityDetails.Visible = false;
            gridviewWoActivityDetails.DataSource = null;
            gridviewWoActivityDetails.DataBind();
            lblTotalCount.Text = "";
            lblTotalCount.Visible = false;
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
        if( !string.IsNullOrEmpty(Convert.ToString(FromatDate)))
        {
        DateTime? FormatdedDate = Convert.ToDateTime(FromatDate, enGB);
        return Convert.ToDateTime(FromatDate, enGB).ToShortDateString();
        }
        return  " "; 
    }

    protected void Timer1_Tick(object sender, EventArgs e)
    {
        lbltimerUpdate.Text = "Last Update" + DateTime.Now.ToLongTimeString();  
    }
}