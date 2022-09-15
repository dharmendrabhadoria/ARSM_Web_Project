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
using System.Xml;
using System.Configuration;
using System.IO;

public partial class Transaction_AddNewFile : PageBase //System.Web.UI.Page
{
    public static PRSMBAL.MasterBAL objPRSMBAL = new MasterBAL();
    public static PRSMBAL.TransactionBAL objPRSMTransBAL = new TransactionBAL();
    public static PRSMBAL.TransactionBAL objTRANSStBAL = new TransactionBAL();
    private System.Globalization.CultureInfo enGB = new System.Globalization.CultureInfo("en-GB");

    MakerSearch objMakerSearch = new MakerSearch();
    PageBase objPageBase = new PageBase();

    DataTable dtSaveNextFileIDs = new DataTable();
    DataSet dsSaveNextFile;
    int n_pg_customerid;
    int n_pg_groupid;
    string s_pg_ImageExtention;
    int n_pg_FileId;
    int n_pg_BoxId;

    protected void Page_Load(object sender, EventArgs e)
    {
        //txtBoxBarCode.Attributes.Add("onkeypress", "autocompleteBC(this);");
         ExpirePageCache();
        if (UserId == 0)
        {
            Response.Redirect("~/User/Login.aspx", false);
        }
        if (!IsPostBack)
        {
            BindDepartment();
            
            if ((Request.QueryString["Mode"].ToString()) == "EditFile")
             {   
                btnAddFile.ToolTip = "Update File";
                btnAddFile.Text = "Update";
                btnSaveNext.Text = "Update & Next";
                btnSaveNext.ToolTip = "Update & Next";
                hdnFileID.Value = Request.QueryString["Fid"].Trim();
                GetFileDetailsForSaveNext(Convert.ToInt32(hdnFileID.Value));
                //btnAddFile.Visible = true;
                //btnSaveNext.Visible = true;
            }
            else if ((Request.QueryString["Mode"].ToString()) == "AddFile")
            {
                btnAddFile.ToolTip = "Save File";
                btnAddFile.Text = "Save File";
                btnSaveNext.Visible = false;
                btnNext.Visible = false;
                btnAddFile.Visible = true;
            }

        }
    }
    private void ExpirePageCache()
    {
        try
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.Now - new TimeSpan(1, 0, 0));
            Response.Cache.SetLastModified(DateTime.Now);
            Response.Cache.SetAllowResponseInBrowserHistory(false);
        }
        catch (Exception ex)
        {
           
        }
    }
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

    public void GetRecordForEdit(int Fid)
    {

        try
        { 
            ddlDepart.Items.Insert(0, new ListItem("--Select--", "0"));

            DataSet dsMakerSearch = objPRSMBAL.Select_MakerSearch_ForEdit(Fid);
            
            if (dsMakerSearch != null)
            {
                if (dsMakerSearch.Tables[0].Rows.Count > 0)
                {
                    txtBoxBarCode.Text = dsMakerSearch.Tables[0].Rows[0]["Box Barcode"].ToString();
                    txtFileBarCode.Text = dsMakerSearch.Tables[0].Rows[0]["File BarCode"].ToString();
                    txtFileDesc1.Text = dsMakerSearch.Tables[0].Rows[0]["File Description1"].ToString();
                    txtFileDesc2.Text = dsMakerSearch.Tables[0].Rows[0]["File Description2"].ToString();
                    ddlDepart.ClearSelection();
                    ddlDepart.Items.FindByValue(dsMakerSearch.Tables[0].Rows[0]["DepartmentId"].ToString()).Selected = true;
                    txtyear.Text = dsMakerSearch.Tables[0].Rows[0]["Year"].ToString();
                    //txtFdate.Text = dsMakerSearch.Tables[0].Rows[0]["FromDate"].ToString();
                    //txtEdate.Text = dsMakerSearch.Tables[0].Rows[0]["ToDate"].ToString();
                    if (dsMakerSearch.Tables[0].Rows[0]["FromDate"].ToString().Trim() != "")
                    {
                        DateTime dtFromDate;
                        dtFromDate = DateTime.Parse(dsMakerSearch.Tables[0].Rows[0]["FromDate"].ToString());
                        txtFdate.Text = dtFromDate.ToString("dd-MMM-yyyy");
                        //txtFdate.Text = dsMakerSearch.Tables[0].Rows[0]["FromDate"].ToString().Trim().Substring(0, 11);
                    }
                    if (dsMakerSearch.Tables[0].Rows[0]["ToDate"].ToString().Trim() != "")
                    {
                        DateTime dtToDate;
                        dtToDate = DateTime.Parse(dsMakerSearch.Tables[0].Rows[0]["ToDate"].ToString());
                        txtEdate.Text = dtToDate.ToString("dd-MMM-yyyy");
                    }
                    txtFileType.Text = dsMakerSearch.Tables[0].Rows[0]["File Type"].ToString();
                    txtFormNum.Text = dsMakerSearch.Tables[0].Rows[0]["From No"].ToString();
                    txtToNum.Text = dsMakerSearch.Tables[0].Rows[0]["To No"].ToString();
                    //txtDestructionDueDate.Text = dsMakerSearch.Tables[0].Rows[0]["Destruction Due Date"].ToString();
                    if (dsMakerSearch.Tables[0].Rows[0]["Destruction Due Date"].ToString().Trim() != "")
                    {
                        DateTime dtDestDueDate;
                        dtDestDueDate = DateTime.Parse(dsMakerSearch.Tables[0].Rows[0]["Destruction Due Date"].ToString());
                        txtDestructionDueDate.Text = dtDestDueDate.ToString("dd-MMM-yyyy");
                    }

                    if (Session["rblSelectedVal"].ToString() == "1") //Maker Search
                    {
                        if (dsSaveNextFile.Tables[0].Rows[0]["ApproveStatus"].ToString().Trim() == "Pending" || dsSaveNextFile.Tables[0].Rows[0]["ApproveStatus"].ToString().Trim() == "Reject")
                        {
                            btnAddFile.Visible = true;
                            //btnSaveNext.Visible = true;
                        }
                        if (dsSaveNextFile.Tables[0].Rows[0]["ApproveStatus"].ToString().Trim() == "Approved")
                        {
                            btnAddFile.Visible = false;
                            btnSaveNext.Visible = false;
                        }
                    }
                    else if (Session["rblSelectedVal"].ToString() == "2" && dsSaveNextFile.Tables[0].Rows[0]["ApproveStatus"].ToString().Trim() == "Reject") //Maker Update
                    {
                        btnAddFile.Visible = true;
                        btnSaveNext.Visible = true;
                    }
                    if (Session["rblSelectedVal"].ToString() == "3") //Maker Checker
                    {
                        btnAddFile.Visible = false;
                        btnSaveNext.Visible = false;
                    }
                    //dsMakerSearch.Tables[0].Rows[0]["FileId"].ToString();
                    //dsMakerSearch.Tables[0].Rows[0]["ModifiedBy"].ToString();

                    
                }
               
            }
            btnAddFile.Text = "Update";
            btnSaveNext.Text = "Update & Next";
            ViewState["Status1"] = "Update";
            ViewState["Status2"] = "Update & Next";
            hdnMode.Value = "Update";
            txtFileBarCode.ReadOnly = true;
            txtBoxBarCode.ReadOnly = true;
        }
        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }
    }

    protected void btnAddFile_Click(object sender, EventArgs e)
    {
        if ((Request.QueryString["Mode"].ToString()) == "EditFile")
        {
            btnSaveNext.Visible = false;
            btnNext.Visible = false;
            btnAddFile.Visible = false;
        }
        else if ((Request.QueryString["Mode"].ToString()) == "AddFile")
        {
            btnSaveNext.Visible = false;
            btnNext.Visible = false;
            btnAddFile.Visible = true;
        }
        //btnSaveNext.Visible = false;
        //btnNext.Visible = false;
        //btnAddFile.Visible = false;
        lblMesg.Text = string.Empty;
        if (Page.IsValid)
        {
            bool Status = AddEditFile();
            if (Request.QueryString["Mode"].ToString() == "EditFile" && Status == true)
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Record Updated Successfully.')", true);
            }
            else if (Request.QueryString["Mode"].ToString() == "AddFile" && Status == true)
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('File Details : " + objMakerSearch.FileBarcode + " is Inserted Successfully.')", true);
            }
            else if (Request.QueryString["Mode"].ToString() == "AddFile" && Status == false)
            {
                //if (txtBoxBarCode.Text == "" || txtFileBarCode.Text == "")
                //{
                //    ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Please enter details ')", true);
                //}
                //else
                //{
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('File Barcode : " + objMakerSearch.FileBarcode + " is already exist..')", true);
                //}
            }

            txtBoxBarCode.Text = "";
            txtFileBarCode.Text = "";
            txtFileDesc1.Text = "";
            txtFileDesc2.Text = "";
            ddlDepart.ClearSelection();
            txtyear.Text = "";
            txtFdate.Text = "";
            txtEdate.Text = "";
            txtFileType.Text = "";
            txtFormNum.Text = "";
            txtToNum.Text = "";
            txtDestructionDueDate.Text = "";
            imgFile.ImageUrl = "";
        }
    }

    protected bool AddEditFile()
    {
        
            #region start
                int isExist = 0;
                bool isNew;
                bool Status = false;
                //int FileId = 0;
                int ActivityId = 0;
                DataSet dsWoActivityId = null;
        try
        {
                if (Page.IsValid)
                {
                Int16 iWareHousId = Convert.ToInt16(Session["WarehouseID"]); //iwarehouseid = Convert.ToInt32(ddlWareHouse.SelectedItem.Value);
                int iCustId = Convert.ToInt32(Session["CustomerId"]); //ddlCustWorkOrder.SelectedItem.Value 
                int WorkOrderNo = Convert.ToInt32(Session["WorkOrderNo"]); ////ddlCustWorkOrder.SelectedItem.Value 
                if ((Request.QueryString["Mode"].ToString()) == "AddFile")
                    isNew = false;
                else
                    isNew = true;
                if ((Request.QueryString["Mode"].ToString()) == "EditFile" || (Request.QueryString["Mode"].ToString()) == "AddFile")
                    ActivityId = 2;
                else
                    ActivityId = 1;

                dsWoActivityId = objPRSMTransBAL.GetWoActivityId(WorkOrderNo, ActivityId);
                int WoActivityId = Convert.ToInt32(dsWoActivityId.Tables[0].Rows[0]["WoActivityId"]);
                int BranchId = Convert.ToInt32(dsWoActivityId.Tables[0].Rows[0]["BranchId"]);

                //objMakerSearch.FileId = Convert.ToInt32(Request.QueryString["Fid"]);

                if (!string.IsNullOrEmpty(hdnFileID.Value.Trim()))
                objMakerSearch.FileId = Convert.ToInt32(hdnFileID.Value);
                else
                objMakerSearch.FileId =  0;

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
               // objMakerSearch.FileType = txtFileType.Text;
                objMakerSearch.FromNum = txtFormNum.Text;
                objMakerSearch.ToNum = txtToNum.Text;
                if (!string.IsNullOrEmpty(txtDestructionDueDate.Text.Trim()))
                    objMakerSearch.DestructionDueDate = txtDestructionDueDate.Text.ToString();
                else
                    objMakerSearch.DestructionDueDate = DBNull.Value.ToString();
                objMakerSearch.BranchID = BranchId;
                objMakerSearch.WoActivityId = WoActivityId;

                Status = objPRSMTransBAL.InsertUpdFileDetails(objMakerSearch, out isExist,isNew);

                //if (isExist == 1 && (Request.QueryString["Mode"].ToString()) == "EditFile" && Status == true)
                //{
                //    ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Record Updated Successfully.')", true);
                //    //ModalPopup.Show();
                //}
                //else if (isExist == 1 && (Request.QueryString["Mode"].ToString()) == "AddFile" && Status == true)
                //{
                //    ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('File Details : " + objMakerSearch.FileBarcode + " is Inserted Successfully.')", true);
                //}
                //else if (isExist == -1 && (Request.QueryString["Mode"].ToString()) == "AddFile" && Status == false)
                //{
                //    ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('File Barcode : " + objMakerSearch.FileBarcode + " is already exist..')", true);
                //}

               
            }
            
            #endregion
               

           
        }
        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }

        return Status;
       
    }

    protected Byte GetBoxFileStatus(string Status)
    {
        DataSet dsBoxFileStatus = objPRSMBAL.GetApplicationCodeDetails("BOXFILE_STATUS", "");
        Byte istatus = 0;
        istatus = Convert.ToByte(dsBoxFileStatus.Tables[0].Rows[0]["AppCodeId"]);
        return istatus;
    }


    public void GetFileDetailsForSaveNext(int FileID)
    {
        try
        {
            if (Session["SearchFileIDs"] != null)
            {
                dtSaveNextFileIDs = (DataTable)(Session["SearchFileIDs"]);
                DataRow drLastRow = dtSaveNextFileIDs.Rows[dtSaveNextFileIDs.Rows.Count - 1];
                int iLast_FileID = Convert.ToInt32(drLastRow[0].ToString().Trim());
                if (FileID == iLast_FileID)
                {
                    btnAddFile.Visible = true;
                    btnSaveNext.Visible = false;
                    btnNext.Visible = false;
                }
            }

            dsSaveNextFile = objPRSMBAL.Select_MakerSearch_ForEdit(FileID);
            DataTable dt = new DataTable();
            dt = dsSaveNextFile.Tables[0];
            for (int i = 0; i <= dsSaveNextFile.Tables[0].Rows.Count - 1; i++)
            {
                if (dt.Rows[0]["File BarCode"].ToString() != "")
                { 
                    ViewState["CheckFile"] = dt;
                }
            }
            
                if (dsSaveNextFile != null && dsSaveNextFile.Tables[0].Rows.Count > 0)
                {
                    hdnFileID.Value = dsSaveNextFile.Tables[0].Rows[0]["FileId"].ToString();
                    txtBoxBarCode.Text = dsSaveNextFile.Tables[0].Rows[0]["Box Barcode"].ToString();
                    txtFileBarCode.Text = dsSaveNextFile.Tables[0].Rows[0]["File BarCode"].ToString();
                    txtFileDesc1.Text = dsSaveNextFile.Tables[0].Rows[0]["File Description1"].ToString();
                    txtFileDesc2.Text = dsSaveNextFile.Tables[0].Rows[0]["File Description2"].ToString();
                    n_pg_customerid = Convert.ToInt32(dsSaveNextFile.Tables[0].Rows[0]["Customer Id"].ToString());
                    n_pg_groupid = Convert.ToInt32(dsSaveNextFile.Tables[0].Rows[0]["Group Id"].ToString());
                    s_pg_ImageExtention = dsSaveNextFile.Tables[0].Rows[0]["Image Extention"].ToString();
                    n_pg_FileId = Convert.ToInt32(dsSaveNextFile.Tables[0].Rows[0]["FileId"].ToString());
                    n_pg_BoxId = Convert.ToInt32(dsSaveNextFile.Tables[0].Rows[0]["Box Id"].ToString());
                    

                    ddlDepart.ClearSelection();
                    ddlDepart.Items.FindByValue(dsSaveNextFile.Tables[0].Rows[0]["DepartmentId"].ToString()).Selected = true;
                    txtyear.Text = dsSaveNextFile.Tables[0].Rows[0]["Year"].ToString();

                    //txtFdate.Text = dsSaveNextFile.Tables[0].Rows[0]["FromDate"].ToString();
                    //txtEdate.Text = dsSaveNextFile.Tables[0].Rows[0]["ToDate"].ToString();

                    if (dsSaveNextFile.Tables[0].Rows[0]["FromDate"].ToString().Trim() != "")
                    {
                        DateTime dtFromDate;
                        dtFromDate = DateTime.Parse(dsSaveNextFile.Tables[0].Rows[0]["FromDate"].ToString());
                        txtFdate.Text = dtFromDate.ToString("dd-MMM-yyyy");
                        //txtFdate.Text = dsSaveNextFile.Tables[0].Rows[0]["FromDate"].ToString().Trim().Substring(0, 11);
                    }
                    if (dsSaveNextFile.Tables[0].Rows[0]["ToDate"].ToString().Trim() != "")
                    {
                        DateTime dtToDate;
                        dtToDate = DateTime.Parse(dsSaveNextFile.Tables[0].Rows[0]["ToDate"].ToString());
                        txtEdate.Text = dtToDate.ToString("dd-MMM-yyyy");                        
                    }
                   
                    txtFileType.Text = dsSaveNextFile.Tables[0].Rows[0]["File Type"].ToString();
                    txtFormNum.Text = dsSaveNextFile.Tables[0].Rows[0]["From No"].ToString();
                    txtToNum.Text = dsSaveNextFile.Tables[0].Rows[0]["To No"].ToString();
                    //txtDestructionDueDate.Text = dsSaveNextFile.Tables[0].Rows[0]["Destruction Due Date"].ToString();
                    if (dsSaveNextFile.Tables[0].Rows[0]["Destruction Due Date"].ToString().Trim() != "")
                    {
                        DateTime dtDestDueDate;
                        dtDestDueDate = DateTime.Parse(dsSaveNextFile.Tables[0].Rows[0]["Destruction Due Date"].ToString());
                        txtDestructionDueDate.Text = dtDestDueDate.ToString("dd-MMM-yyyy");
                    }

                    //============Display Image==============
                    int n_CompanyGroup = n_pg_groupid;
                    int n_CustomerNo = n_pg_customerid;
                    string s_BoxBarCode = txtBoxBarCode.Text;
                    string s_FileBarCode = txtFileBarCode.Text;
                    string s_FileImgExtension = s_pg_ImageExtention;
                    //string s_FromFileName = n_pg_FileId.ToString().Trim() + (s_FileImgExtension.Contains(".") ? "" : ".") + s_FileImgExtension;
                    string s_FromFileName = n_pg_FileId.ToString().Trim();
                    string s_ToFileName = "Image" + (s_FileImgExtension.Contains(".") ? "" : ".") + s_FileImgExtension;
                    string strDrive = System.Configuration.ConfigurationManager.AppSettings["ImageDrive"].ToString();
                    string strFolder = System.Configuration.ConfigurationManager.AppSettings["ImageFolder"].ToString();
                    string strBasePath = strDrive + "\\" + strFolder + "\\" + n_CompanyGroup.ToString().Trim() + "\\" + n_CustomerNo.ToString().Trim() + "\\" + n_pg_BoxId.ToString().Trim() + "\\" + s_FromFileName;
                    ErrorHandler.WriteIPNLog(strBasePath);
                    if (File.Exists(strBasePath))
                    {
                        File.Copy(strBasePath, Server.MapPath("~\\ImageDisplay\\" + s_ToFileName), true);
                        imgFile.ImageUrl = "~\\ImageDisplay\\" + s_ToFileName + "?" + DateTime.Now.ToLongTimeString();
                        imgFile.Height = 300;
                        imgFile.Width = 300;
                        imgFile.Visible = true;
                    }
                    else
                        imgFile.Visible = false;
                    //==========================================

                    if (Session["rblSelectedVal"].ToString() == "1") //Maker Search
                    {
                        if (dsSaveNextFile.Tables[0].Rows[0]["ApproveStatus"].ToString().Trim() == "Pending" || dsSaveNextFile.Tables[0].Rows[0]["ApproveStatus"].ToString().Trim() == "Reject")
                        {
                            btnAddFile.Visible = true;
                            //btnSaveNext.Visible = true;
                        }
                        if (dsSaveNextFile.Tables[0].Rows[0]["ApproveStatus"].ToString().Trim() == "Approved")
                        {
                            btnAddFile.Visible = false;
                            btnSaveNext.Visible = false;
                        }
                    }
                    else if (Session["rblSelectedVal"].ToString() == "2" && dsSaveNextFile.Tables[0].Rows[0]["ApproveStatus"].ToString().Trim() == "Reject") //Maker Update
                    {
                        btnAddFile.Visible = true;
                        //btnSaveNext.Visible = true;
                    }
                    if (Session["rblSelectedVal"].ToString() == "3") //Maker Checker
                    {
                        btnAddFile.Visible = false;
                        btnSaveNext.Visible = false;
                    }

                    //dsSaveNextFile.Tables[0].Rows[0]["FileId"].ToString();
                    //dsSaveNextFile.Tables[0].Rows[0]["ModifiedBy"].ToString();
                }

            
            btnAddFile.Text = "Update";
            btnSaveNext.Text = "Update & Next";
            ViewState["Status1"] = "Update";
            ViewState["Status2"] = "Update & Next";
            hdnMode.Value = "Update";
            txtFileBarCode.ReadOnly = true;
            txtBoxBarCode.ReadOnly = true;
            

        }
        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }
    }

    protected void btnSaveNext_Click(object sender, EventArgs e)
    {
        if (Session["SearchFileIDs"] != null)
        {
            int iFile_Index = 0;
            int iUpdatedBy = UserId;
            dtSaveNextFileIDs = (DataTable)(Session["SearchFileIDs"]);
            try
            {
                if (Page.IsValid)
                {
                    bool Status = AddEditFile();
                    if (Request.QueryString["Mode"].ToString() == "EditFile" && Status == true)
                    {
                        lblMesg.ForeColor = Color.Green;
                        lblMesg.Text = "File Barcode of: " + objMakerSearch.FileBarcode + " details are Updated Successfully";
                        imgFile.ImageUrl = "";
                    }
                    int iMaxFileIndex = dtSaveNextFileIDs.Rows.Count - 1;

                    for (iFile_Index = 0; iFile_Index < dtSaveNextFileIDs.Rows.Count; iFile_Index++)
                    {
                        if (dtSaveNextFileIDs.Rows[iFile_Index][0].ToString().Trim() == hdnFileID.Value)
                        {
                            if (iFile_Index < iMaxFileIndex)
                            {
                                GetFileDetailsForSaveNext(Convert.ToInt32(dtSaveNextFileIDs.Rows[iFile_Index + 1][0]));
                                DataTable dt = new DataTable();
                                dt = (DataTable)ViewState["CheckFile"];
                                if (iFile_Index + 1 != iMaxFileIndex)
                                {
                                    btnAddFile.Visible = true;
                                    btnSaveNext.Visible = true;
                                    btnNext.Visible = true;
                                }
                                else
                                {
                                    btnAddFile.Visible = true;
                                    btnSaveNext.Visible = false;
                                    btnNext.Visible = false;
                                }
                                break;
                            }
                            else
                            {
                            }

                        }

                    }
 
                }


            }
            catch (Exception ex)
            {
                ErrorHandler.WriteLog(ex);
            }

        }

    }
    protected void btnNext_Click(object sender, EventArgs e)
    {

        if (Session["SearchFileIDs"] != null)
        {
            int iFile_Index = 0;
            int iUpdatedBy = UserId;
            dtSaveNextFileIDs = (DataTable)(Session["SearchFileIDs"]);
            lblMesg.Text = string.Empty;
            try
            {
                if (Page.IsValid)
                {
                    //bool Status = AddEditFile();
                    //if (Request.QueryString["Mode"].ToString() == "EditFile" && Status == true)
                    //{
                    //    //ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Record Updated Successfully.')", true);
                    //    lblMesg.ForeColor = Color.Green;
                    //    lblMesg.Text = "File Barcode of: " + objMakerSearch.FileBarcode + " details are Updated Successfully";
                    //}
                    int iMaxFileIndex = dtSaveNextFileIDs.Rows.Count - 1;

                    for (iFile_Index = 0; iFile_Index < dtSaveNextFileIDs.Rows.Count; iFile_Index++)
                    {
                        if (dtSaveNextFileIDs.Rows[iFile_Index][0].ToString().Trim() == hdnFileID.Value)
                        {
                            if (iFile_Index < iMaxFileIndex)
                            {
                                GetFileDetailsForSaveNext(Convert.ToInt32(dtSaveNextFileIDs.Rows[iFile_Index + 1][0]));
                                DataTable dt = new DataTable();
                                dt = (DataTable)ViewState["CheckFile"];
                                if (iFile_Index + 1 != iMaxFileIndex)
                                {
                                    //btnAddFile.Visible = true;
                                    //btnSaveNext.Visible = true;
                                    btnNext.Visible = true;
                                }
                                else
                                {
                                    //btnAddFile.Visible = true;
                                    btnSaveNext.Visible = false;
                                    btnNext.Visible = false;
                                }
                                break;
                            }
                            else
                            {
                            }

                        }

                    }

                }


            }
            catch (Exception ex)
            {
                ErrorHandler.WriteLog(ex);
            }

        }

    }


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

    #endregion Autocomplete extender for Box BarCode And Filre Barcode

}