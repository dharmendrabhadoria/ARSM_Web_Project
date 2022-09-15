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
using System.Web.Caching;
using System.Globalization;

public partial class Transaction_MakerAndChecker_New : PageBase //System.Web.UI.Page
{
    public static PRSMBAL.MasterBAL objPRSMBAL = new MasterBAL();
    public static PRSMBAL.TransactionBAL objPRSMTransBAL = new TransactionBAL();
    public static PRSMBAL.TransactionBAL objTRANSStBAL = new TransactionBAL();
    private System.Globalization.CultureInfo enGB = new System.Globalization.CultureInfo("en-GB");
    PageBase objPageBase = new PageBase();    
    IFormatProvider format = new System.Globalization.CultureInfo("en-GB", true);
    MakerSearch objMakerSearch = new MakerSearch();
    DataSet dsMakerCheckerSearch = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        System.Globalization.DateTimeFormatInfo mfi = new System.Globalization.DateTimeFormatInfo();
        DateTime dt1 = DateTime.Now;
        string strDate = dt1.ToString("dd-MMM-yyyy");
        DateTime FirstDayInMonth = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
        ScriptManager.RegisterStartupScript(this, GetType(), "Temp", "ValidateDates();", true);
        CultureInfo enGB = new CultureInfo("en-GB");

        if (UserId == 0)
        {
            Response.Redirect("~/User/Login.aspx", false);
        }
        if (!IsPostBack)
        {
            NewInwardOutward();
            //BindNewMaker();
            //SetRolewiseAcessfuncationality();
            //BindWareHouse();
            btnCancelApprove.Visible = false;
        }        
    }

    protected void NewInwardOutward()
    {
        //  BindCompanyGroup(0);
       ddlWareHouse.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlCustWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlWorkOrderActivity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });     
        
        //BindDdlWareHouse(ddlWareHouse);      
        BindWareHouse();
        BindDepartment();
        lblActivityName.Text = "New Standard Box Cost (1.50 Cubic Ft.)"; 
    }

    private void BindWareHouse()
    {
        try
        {
            DataSet dsWareHouse = null;
            ddlWareHouse.Items.Clear();
            if (Cache["WareHouse"] == null)
            {
                dsWareHouse = objPRSMBAL.GetWareHouse(0);
                Cache.Insert("WareHouse", dsWareHouse, null, DateTime.Now.AddDays(1), Cache.NoSlidingExpiration);
            }
            else
            {
                dsWareHouse = (DataSet)Cache["WareHouse"];
            }
            DataView dv = (DataView)dsWareHouse.Tables[0].DefaultView;
            dv.Sort = "WarehouseName";
            if (dv.Count > 0 && dv != null)
            {
                ddlWareHouse.DataSource = dv;
                ddlWareHouse.DataTextField = "WarehouseName";
                ddlWareHouse.DataValueField = "WareHouseId";
                ddlWareHouse.DataBind();
                ddlWareHouse.Items.Insert(0, new ListItem("--Select--", "0"));
            }
        }

        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }
        
    }

    private void BindCustomerWorkorder(int ddlWhereHouseID)
    {
        try
        { 
            DataSet dsCustWorkOrder = null;
            ddlCustWorkOrder.Items.Clear();
            int result=0; 
            bool success;
            int iwarehouseid = 0;
            if (ddlWareHouse.SelectedIndex > 0)
            {
               success = int.TryParse(ddlWareHouse.SelectedItem.Value, out result);
               iwarehouseid = Convert.ToInt32(ddlWareHouse.SelectedItem.Value);
               Session["WarehouseID"] = iwarehouseid;
               dsCustWorkOrder = objPRSMBAL.GetCustomerWorkorder(iwarehouseid);                
            }

            if (dsCustWorkOrder!= null && dsCustWorkOrder.Tables[0].Rows.Count > 0)
            {
                ddlCustWorkOrder.DataSource = dsCustWorkOrder;
                ddlCustWorkOrder.DataTextField = "CustomerWorkorder";
                ddlCustWorkOrder.DataValueField = "WorkorderNo";
                ddlCustWorkOrder.DataBind();
                //Session["WoActivityId"] = iwarehouseid;
            }
            ddlCustWorkOrder.Items.Insert(0, new ListItem("--Select--", "0"));
        }

        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }

    }

    private void BindGetPickUpAddress(int WorkOrderNo)
    {
        try
        {
            DataSet dsPickUpAddress = null;
            ddlWorkOrderActivity.Items.Clear();            
            if (ddlCustWorkOrder.SelectedIndex > 0)
            {               
               dsPickUpAddress = objPRSMBAL.GetPickUpAddressOnWO(WorkOrderNo);
               Session["WorkOrderNo"] = WorkOrderNo;
            }

            if (dsPickUpAddress!= null && dsPickUpAddress.Tables[0].Rows.Count > 0)
            {
                ddlWorkOrderActivity.DataSource = dsPickUpAddress;
                ddlWorkOrderActivity.DataTextField = "PickUpAddress";
                ddlWorkOrderActivity.DataValueField = "PickupAddressId";
                ddlWorkOrderActivity.DataBind();
                int CustomerId = Convert.ToInt32(dsPickUpAddress.Tables[0].Rows[0]["CustomerId"]);
                Session["CustomerId"] = CustomerId;
                
            }
            ddlWorkOrderActivity.Items.Insert(0, new ListItem("--Select--", "0"));
        }

        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }

    }

    
    protected void ddlWareHouse_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindCustomerWorkorder(Convert.ToInt32(ddlWareHouse.SelectedValue));
    }
    protected void ddlCustWorkOrder_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindGetPickUpAddress(Convert.ToInt32(ddlCustWorkOrder.SelectedValue));
    }
    //protected void btnAddBox_Click(object sender, EventArgs e)
    //{
    //    ModalPopup.Show();

    //    Response.Redirect("AddNewBox.aspx", false);
    //    ScriptManager.RegisterStartupScript(this, typeof(Page), "window", "ShowdivDuplicate();", true);
    //    btnAddBox.Attributes.Add("OnClick", "return OpenReference();");

    //}

    private void BindDepartment()
    {
        try
        {
            DataSet dsDepartment = null;
            ddlDepart.Items.Clear();
            if (Cache["Department"] == null)
            {
                dsDepartment = objPRSMBAL.GetApplicationCodeDetails("Department", "");
                Cache.Insert("Department", dsDepartment, null, DateTime.Now.AddDays(1), Cache.NoSlidingExpiration);
            }
            else
            {
                dsDepartment = (DataSet)Cache["Department"];
            }
            DataView dv = (DataView)dsDepartment.Tables[0].DefaultView;
            dv.Sort = "AppCodeName";
            if (dv.Count > 0 && dv != null)
            {
                ddlDepart.DataSource = dv;
                ddlDepart.DataTextField = "AppCodeName";
                ddlDepart.DataValueField = "AppCodeId";
                ddlDepart.DataBind();
                ddlDepart.Items.Insert(0, new ListItem("--Select--", "0"));
            }
        }

        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        clearAllChecker();
        BindMakerCheckerSearch();       
    }

    private void BindMakerCheckerSearch()
    {
        try
        {
            DataTable dtFiles = new DataTable();
            DataColumn dcFile_ID = new DataColumn("File_ID", typeof(int));
            dtFiles.Columns.Add(dcFile_ID);
            if (Session["SearchFileIDs"] != null)
                Session.Remove("SearchFileIDs");

            //DataSet dsMakerCheckerSearch = null;
            GrdMakerSearch.DataSource = null;
            GrdMakerSearch.DataBind();

            objMakerSearch.WareHouseId = Convert.ToInt32(ddlWareHouse.SelectedValue);
            objMakerSearch.WorkOrderNo = Convert.ToInt32(ddlCustWorkOrder.SelectedValue);

            //string CustWO = ddlCustWorkOrder.SelectedValue.ToString();
            //string[] WoNun = CustWO.Split('-');
            //string WoNunLast = WoNun[1];
            //objMakerSearch.WorkOrderNo = Convert.ToInt32(WoNunLast.Trim());

            objMakerSearch.PickupAddressId = Convert.ToInt32(ddlWorkOrderActivity.SelectedValue);
            objMakerSearch.BoxBarcode = txtBoxBarCode.Text;
            objMakerSearch.FileBarcode = txtFileBarCode.Text;
            objMakerSearch.Department = Convert.ToInt32(ddlDepart.SelectedValue);
            objMakerSearch.FileDesc1 = txtFileDesc1.Text.Trim();
            objMakerSearch.FileDesc2 = txtFileDesc2.Text.Trim();
            objMakerSearch.FileType = txtFileType.Text.Trim();
            objMakerSearch.year = txtyear.Text.Trim();

            if (!string.IsNullOrEmpty(txtFdate.Text.Trim()))
                objMakerSearch.FromDate = txtFdate.Text.ToString();
            else
                objMakerSearch.FromDate = DBNull.Value.ToString();
            if (!string.IsNullOrEmpty(txtEdate.Text.Trim()))
                objMakerSearch.ToDate = txtEdate.Text.ToString();
            else
                objMakerSearch.ToDate = DBNull.Value.ToString();
            
            
                objMakerSearch.FromNum =txtFromNum.Text;            
                objMakerSearch.ToNum = txtToNum.Text;
            if (!string.IsNullOrEmpty(txtDestructionDueDate.Text.Trim()))
                objMakerSearch.DestructionDueDate = txtDestructionDueDate.Text.ToString();
            else
                objMakerSearch.DestructionDueDate = DBNull.Value.ToString();


            string sRblSlctId = rblMakerChecker.SelectedValue.ToString();
            Session["rblSelectedVal"] = sRblSlctId;
            int Fstatus=0;
            if (sRblSlctId == "1")
            {
                Fstatus = GetBoxFileStatus("Pending");
                ViewState["Action"] = "N";
                trMakerCheckerUpdate.Visible = false;
                tdSelectMode.Visible = false;
                tdRblSelectMode.Visible = false;
                tdApproveReject.Visible = false;
                //tdUpdateMaker.Visible = false;
                rbtApprovedRejectChecker.Visible = false;
                lblmode.Visible = false;
                btnApprove.Visible = false;

            }
            else if (sRblSlctId == "2")
            {
                Fstatus = GetBoxFileStatus("Reject");
                ViewState["Action"] = "U";
                trMakerCheckerUpdate.Visible = false;
                tdSelectMode.Visible = false;
                tdRblSelectMode.Visible = false;
                tdApproveReject.Visible = false;
                //tdUpdateMaker.Visible = true;
                rbtApprovedRejectChecker.Visible = false;
                lblmode.Visible = false;
                btnApprove.Visible = false;
                
            }
            else if (sRblSlctId == "3")
            {
                //Fstatus = GetBoxFileStatus("Approved");
                Fstatus = GetBoxFileStatus("Pending");
                ViewState["Action"] = "C";
                trMakerCheckerUpdate.Visible = true;
                tdSelectMode.Visible = true;
                tdRblSelectMode.Visible = true;
                tdApproveReject.Visible = true;
                //tdUpdateMaker.Visible = false;
                rbtApprovedRejectChecker.Visible = true;
                lblmode.Visible = true;
                btnApprove.Visible = true;
            }

            //ds = objPRSMTransBAL.getFreshPickupData(objMakerSearch);
            dsMakerCheckerSearch = objPRSMTransBAL.getMakerSearchData(objMakerSearch, Fstatus);

            if (dsMakerCheckerSearch != null && dsMakerCheckerSearch.Tables[0].Rows.Count > 0)
            {
                
                //HttpContext.Current.Cache["FreshPickupFile"] = ds.Tables[0];
                //ViewState["FreshPickupFile"] = ds.Tables[0];
                GvPanal.Visible = true;
                GrdMakerSearch.DataSource = dsMakerCheckerSearch.Tables[0];
                GrdMakerSearch.DataBind();
                lblSearchCount.Visible = true;
                lblSearchCount.ForeColor = Color.Green;
                lblSearchCount.Text = "No of Records Found:" + ' ' + Convert.ToString(dsMakerCheckerSearch.Tables[0].Rows.Count);
              


                //if (ViewState["CommandName"] == "EditRecord")//For Save & Next
                //{
                    for (int i = 0; i < dsMakerCheckerSearch.Tables[0].Rows.Count; i++)
                    {
                        if (Convert.ToString(dsMakerCheckerSearch.Tables[0].Rows[i]["File BarCode"]).Trim() != "")
                        {
                            DataRow drFile = dtFiles.NewRow();
                            drFile[0] = Convert.ToInt32(dsMakerCheckerSearch.Tables[0].Rows[i]["FileId"]);
                            dtFiles.Rows.Add(drFile);
                        }
                    }
                    Session["SearchFileIDs"] = dtFiles;
                //}


                    DataTable Dt = null;

                    DataRow[] foundrows = null;

                    string strFilter = string.Empty;

                    if (Convert.ToString(ViewState["Action"]) == "C")
                    {
                        foundrows = dsMakerCheckerSearch.Tables[0].Select();
                        if (foundrows.Length > 0)
                        {
                            Dt = foundrows.CopyToDataTable<DataRow>();
                            ViewState["dtBoxDetailsTable"] = Dt;
                        }
                        else
                        {
                            ViewState["dtBoxDetailsTable"] = null;
                        }

                        strFilter = "FileStatus='" + Fstatus + "'";
                        //foundrows = dsMakerCheckerSearch.Tables[0].Select(strFilter);
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
                    else
                    {
 
                    }


            }
            else
            {
                GrdMakerSearch.DataSource = null;
                GrdMakerSearch.DataBind(); 
                GvPanal.Visible = false;
                lblSearchCount.Visible = true;
                lblSearchCount.ForeColor = Color.Red;
                lblSearchCount.Text = "No Records Found";
            }        
        }

        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }

    }

    protected int GetBoxFileStatus(string Status)
    {
        DataSet dsBoxFileStatus = objPRSMBAL.GetApplicationCodeDetails("BOXFILE_STATUS", Status);
        int Fstatus = Convert.ToInt32(dsBoxFileStatus.Tables[0].Rows[0]["AppCodeId"]);
        return Fstatus;
    }

    protected void GrdMakerSearch_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EditRecord")
        { 
            ViewState["CommandName"] = "EditRecord";
            BindMakerCheckerSearch();
        }


    }
    protected void GrdMakerSearch_RowEditing(object sender, GridViewEditEventArgs e)
    {
        //ViewState["Status"] = "Update";
        //hdnMode.Value = "Update";

    }
    protected void GrdMakerSearch_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GrdMakerSearch.PageIndex = e.NewPageIndex;
        BindMakerCheckerSearch();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        ClearFields();
    }

    private void ClearFields()
    {
        ddlWareHouse.SelectedIndex = 0;
        ddlCustWorkOrder.Items.Clear();
        ddlCustWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlWorkOrderActivity.Items.Clear();
        ddlWorkOrderActivity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlDepart.SelectedIndex = 0;
        txtBoxBarCode.Text = string.Empty;
        txtFileBarCode.Text = string.Empty;
        txtFileDesc1.Text = string.Empty;
        txtFileDesc2.Text = string.Empty;
        txtFileType.Text = string.Empty;
        txtyear.Text = string.Empty;
        txtFdate.Text = string.Empty;
        txtEdate.Text = string.Empty;
        txtFromNum.Text = string.Empty;
        txtToNum.Text = string.Empty;
        txtDestructionDueDate.Text = string.Empty;
        GrdMakerSearch.DataSource = null;
        GrdMakerSearch.DataBind();
        lblSearchCount.Text = string.Empty;
        GvPanal.Visible = false;
        
    }

    protected void GrdMakerSearch_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            LinkButton l = (LinkButton)e.Row.Cells[2].FindControl("lnkFileID");
            l.Attributes.Add("onclick", "javascript:EditFileDetails(' " + l.CommandArgument + "')");

            TextBox T = (TextBox)e.Row.Cells[14].FindControl("txtRemarks");
           

            
            if (rblMakerChecker.SelectedValue.ToString() == "1")
            {
                //l.Enabled = false;
                T.Text = "";
                T.Enabled = false;
                //l.Attributes.Add("onclick", "return false");
            }
            else if (rblMakerChecker.SelectedValue.ToString() == "2")
            {
                //l.Enabled = true;
                T.Enabled = false;
                //l.Attributes.Add("onclick", "return true");
            }
            else if (rblMakerChecker.SelectedValue.ToString() == "3")
            {
                //l.Enabled = false;
                T.Text = "";
                T.Enabled = true;
                //l.Attributes.Add("onclick", "return false");
            }
        }

    }

    protected void btnApprove_Click(object sender, EventArgs e)
    {
        try
        {
            Page.Validate("CheckerGroup");
            if (Page.IsValid)
            {
                int iCustId = Convert.ToInt32(Session["CustomerId"]);
                Int16 iWareHousId = Convert.ToInt16(ddlWareHouse.SelectedValue);
                int WorkOrderNo = Convert.ToInt32(Session["WorkOrderNo"]);
                string msg = "Record saved successfully.";
                bool isError = true;
                string xmlBoxFileData;
                Int16 iStatus = GetBoxFileStatusGrid("In");
                DataSet dsxml = new DataSet();
                DataTable dtBoxFileDetails = new DataTable();
                dtBoxFileDetails = FileDetailsTable().Clone();
                dtBoxFileDetails.TableName = "Root";
                DataSet dsResult = new DataSet();
                UpdateFileDataTable(GrdMakerSearch);
                lblMsg.Text = string.Empty;

                if (string.IsNullOrWhiteSpace(rbtApprovedRejectChecker.SelectedValue))
                {
                    lblMsg.ForeColor = Color.Red;
                    lblMsg.Text = "Please Select either approved or reject for records.";
                    ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "ShowdivDuplicate();", true);
                    return;
                }
                string strFilter = "FileStatus = 'Reject' AND FileRemarks <>''";
                DataRow[] foundRemarkrows = FileDetailsTable().Select(strFilter);
                if (foundRemarkrows.Length == 0 && rbtApprovedRejectChecker.SelectedValue != "1")
                {
                    lblMsg.ForeColor = Color.Red;
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

                objPRSMTransBAL.ApproveFileDetails(iCustId, iWareHousId, xmlBoxFileData, WorkOrderNo, Convert.ToInt16(UserId), 0);

                string StrStatus = string.Empty;
                StrStatus = rbtApprovedRejectChecker.SelectedItem.Text;
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('Record(s) " + StrStatus + " successfully.')", true);

                BindMakerCheckerSearch();       
                
               
            }
        }//try
        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }
    }

    protected static Int16 GetBoxFileStatusGrid(string Status)
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
        String EndDate, string Label1, string Label2, string Label3, string sFileRemarks,
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
                dtFilesDetails.Rows[iSrNo]["sFileName"] = sFileName.Replace("'", "''");
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

    protected void UpdateFileDataTable(GridView grvctrl)
    {
        try
        {
            for (int i = 0; i < grvctrl.Rows.Count; i++)
            {
                Int32 fileid = 0;
                string strBoxBarCode = "", strFileBarCode = "", strFileName = "", stryear = "", strFdate = "",
                    strEdate = "", strLabel1 = "", strLabel2 = "",
                    strLabel3 = "", strFileRemarks = "", strFileStatus = "", strDepartment = "", strFileDescription = "", strDestructionDueDate = "";
                int iDepart = 0, IsSelected = 0;
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
                    //Label lblyear = (Label)grvctrl.Rows[i].FindControl("lblyear");
                    //Label lblFdate = (Label)grvctrl.Rows[i].FindControl("lblFdate");
                    //Label lblEdate = (Label)grvctrl.Rows[i].FindControl("lblEdate");
                    TextBox txtRemarks = (TextBox)grvctrl.Rows[i].FindControl("txtRemarks");
                    strBoxBarCode = grvctrl.Rows[i].Cells[1].Text.ToString().Replace("&nbsp;", "");
                    Label FileBarCode = (Label)grvctrl.Rows[i].FindControl("lblFbc");
                    strFileBarCode = FileBarCode.Text;
                    //strFileBarCode = grvctrl.Rows[i].Cells[2].Text.ToString().Replace("&nbsp;", "");
                    strFileName = grvctrl.Rows[i].Cells[3].Text.ToString().Replace("&nbsp;", "");
                    strFileDescription = grvctrl.Rows[i].Cells[4].Text.ToString().Replace("&nbsp;", "");
                    //strDepartment = Convert.ToString(grvctrl.Rows[i].Cells[5].Text.ToString().Replace("&nbsp;", ""));
                    //Label Department = (Label)grvctrl.Rows[i].FindControl("lblDept");
                    //strDepartment = Department.Text;
                    strDepartment = grvctrl.Rows[i].Cells[5].Text.ToString().Replace("&nbsp;", "");
                    Label DeptID = (Label)grvctrl.Rows[i].FindControl("lblDeptID");
                    iDepart = Convert.ToInt32(DeptID.Text);
                    Label FileId1 = (Label)grvctrl.Rows[i].FindControl("lblFID");
                     fileid= Convert.ToInt32(FileId1.Text);


                    stryear = Convert.ToString(grvctrl.Rows[i].Cells[6].Text.ToString().Replace("&nbsp;", ""));
                    strFdate = Convert.ToString(grvctrl.Rows[i].Cells[7].Text.ToString().Replace("&nbsp;", ""));
                    strEdate = Convert.ToString(grvctrl.Rows[i].Cells[8].Text.ToString().Replace("&nbsp;", ""));
                    strLabel1 = grvctrl.Rows[i].Cells[9].Text.ToString().Replace("&nbsp;", ""); ;
                    strLabel2 = grvctrl.Rows[i].Cells[10].Text.ToString().Replace("&nbsp;", "");
                    strLabel3 = grvctrl.Rows[i].Cells[11].Text.ToString().Replace("&nbsp;", "");
                    strDestructionDueDate = grvctrl.Rows[i].Cells[12].Text.ToString().Replace("&nbsp;", "");
                    strFileStatus = grvctrl.Rows[i].Cells[13].Text.ToString().Replace("&nbsp;", "");
                    strFileRemarks = txtRemarks.Text;
                    //DropDownList ddldepart = (DropDownList)grvctrl.Rows[i].FindControl("ddlDepart");
                    //iDepart = Convert.ToInt32(ddldepart.SelectedValue);

                    //iDepart = Convert.ToInt16(grvctrl.DataKeys[i].Values[1].ToString());
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
                     //string strfileid=grvctrl.Rows[i].Cells[15].Text.ToString().Replace("&nbsp;", "");
                    Label FileId = (Label)grvctrl.Rows[i].FindControl("lblFileId");
                    fileid = Convert.ToInt32(FileId.Text);
                }
                // int rowindex = 0;


                if (strFileBarCode.Trim() != "" && strBoxBarCode != "")
                {
                    if (Convert.ToString(ViewState["Action"]) != "N")
                    {
                        //fileid = Convert.ToInt32(grvctrl.DataKeys[i].Values[0].ToString());
                        Label FileId = (Label)grvctrl.Rows[i].FindControl("lblFileId");
                        fileid = Convert.ToInt32(FileId.Text);
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
                            strFileStatus, strDepartment, IsSelected, strFileDescription, strDestructionDueDate);
                    }
                    else if (strFileStatus=="Approved" && strFileRemarks == "")
                    {

                        UpdateFileDetails(fileid, strFileRemarks, strFileStatus, strBoxBarCode, strFileBarCode, strFileName, iDepart,
                                   stryear, strFdate, strEdate, strLabel1, strLabel2, strLabel3, strDepartment, IsSelected, strFileDescription, strDestructionDueDate
                                   );

                    }
                    else if (strFileStatus == "Reject" && strFileRemarks != "")
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

    protected void UpdateFileDetails(Int32 FileId, string sFileRemarks, string sFileStatus,
     string BoxBarCode, string FileBarCode, string sFileName, int DepartmentId, string sYear, String FromDate,
       String EndDate, string Label1, string Label2, string Label3, string sDepartmentName, int IsSelected, string FileDescription2, string DestructionDueDate)
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
        drFileDetails["FileStatus"] = (sFileStatus == "Approved" ? sFileStatus :
           (string.IsNullOrWhiteSpace(sFileRemarks) == true ? drFileDetails["FileStatus"] : sFileStatus));
        dtFileDetails.AcceptChanges();
    }
    protected void btnCancelApprove_Click(object sender, EventArgs e)
    {
        clearAllChecker();
    }

    protected void clearAllChecker()
    {
        //ViewState["FileDetailsTable"] = null;
        //ViewState["dtBoxDetailsTable"] = null;
        //ddlCustomerChecker.Items.Clear();
        //ddlWorkOrderChecker.Items.Clear();
        //ddlWareHouseChecker.Items.Clear();
        //ddlCompanyGroupChecker.Items.Clear();
        rbtApprovedRejectChecker.ClearSelection();
        lblMsg.Text = string.Empty;
    }
    protected void rblMakerChecker_SelectedIndexChanged(object sender, EventArgs e)
    {
        GrdMakerSearch.DataSource = null;       
        GrdMakerSearch.DataBind();
        GrdMakerSearch.PageIndex = 0;
        lblSearchCount.Text = "";
        rbtApprovedRejectChecker.Visible = false;
        lblmode.Visible = false;
        btnApprove.Visible = false;
    }
    protected void GrdMakerSearch_Sorting(object sender, GridViewSortEventArgs e)
    {
        BindMakerCheckerSearch();
        DataTable dt = new DataTable();
        dt = dsMakerCheckerSearch.Tables[0];
        //I’m Using  da.fill(dt);    ( for database)
        {
            string SortDir = string.Empty;
            if (dir == SortDirection.Ascending)
            {
                dir = SortDirection.Descending;
                SortDir = "Desc";
            }
            else
            {
                dir = SortDirection.Ascending;
                SortDir = "Asc";
            }
            DataView sortedView = new DataView(dt);
            sortedView.Sort = e.SortExpression + " " + SortDir;
            GrdMakerSearch.DataSource = sortedView;
            GrdMakerSearch.DataBind();
        }
    }

    public SortDirection dir
    {
        get
        {
            if (ViewState["dirState"] == null)
            {
                ViewState["dirState"] = SortDirection.Ascending;
            }
            return (SortDirection)ViewState["dirState"];
        }
        set
        {
            ViewState["dirState"] = value;
        }

    }

}