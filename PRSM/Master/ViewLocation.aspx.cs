using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using UserRoleWiseAcess;
using PRSMBAL;
using Entity;
using Utility;
using System.IO;
using System.Configuration;
using System.Data.OleDb;

public partial class Master_ViewLocation : PageBase
{
    PRSMBAL.MasterBAL objPRSMBAL = new MasterBAL();
    public static PRSMBAL.MasterBAL objPRSMBAL1 = new MasterBAL();
    public static PRSMBAL.MasterBAL objStatPRSMBAL = new MasterBAL();
    public const string strSaveFilePath = @"~/PRSMDocument/ContractDocument";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GenerateLocation();
        }
    }

    protected void GenerateLocation()
    {
        divGenerateLocation.Style["display"] = "block";
        divMapLocation.Style["display"] = "none";
        divSearchLocation.Style["display"] = "none";
        lnkbtnMapLocation.Style["color"] = "#4f4f4f !important;";
        lnkbtnSearchLocation.Style["color"] = "#4f4f4f !important;";
        lnkbtnGenerateLocation.Style["color"] = "blue !important;";
        ViewState["ValidateLocation"] = null;
        BindDdlWareHouseGenrate();
        ddlRowGroupGenrate.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        SetRolewiseAcessfuncationality();
    }
    protected void MapLocation()
    {
        divGenerateLocation.Style["display"] = "none";
        divMapLocation.Style["display"] = "block";
        divSearchLocation.Style["display"] = "none";
        lnkbtnMapLocation.Style["color"] = "blue !important;";
        lnkbtnSearchLocation.Style["color"] = "#4f4f4f !important;";
        lnkbtnGenerateLocation.Style["color"] = "#4f4f4f !important;";
        lblLocationValidationMessage.Text = "";
        grdValidateLocation.DataSource = null;
        grdValidateLocation.DataBind();
        btnSaveLocation.Visible = false;  
        SetRolewiseAcessfuncationality();
    }

    protected void SearchLocation()
    {
        divGenerateLocation.Style["display"] = "none";
        divMapLocation.Style["display"] = "none";
        divSearchLocation.Style["display"] = "block";
        lnkbtnMapLocation.Style["color"] = "#4f4f4f !important;";
        lnkbtnSearchLocation.Style["color"] = "blue !important;";
        lnkbtnGenerateLocation.Style["color"] = "#4f4f4f !important;";
        BindDdlWareHouseSearch();
        grdLocationDetails.DataSource = null;
        grdLocationDetails.DataBind();
        ViewState["dsResult"] = null;
        ddlRowSearch.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        SetRolewiseAcessfuncationality();
    }
    private void BindDdlWareHouseGenrate()
    {
        ddlWareHouseGenrate.DataSource = objPRSMBAL.GetWareHouse(0);
        ddlWareHouseGenrate.DataValueField = "WareHouseId";
        ddlWareHouseGenrate.DataTextField = "WarehouseName";
        ddlWareHouseGenrate.DataBind();
        ddlWareHouseGenrate.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }


    private void BindRow(Int16 iwarehouseid, Int16 irowId)
    {
        ddlRowGroupGenrate.Items.Clear();
        ddlRowGroupGenrate.DataSource = null;
        ddlRowGroupGenrate.DataBind();
        ddlRowGroupGenrate.DataSource = objPRSMBAL.GetRowMaster(iwarehouseid, irowId);
        ddlRowGroupGenrate.DataValueField = "RowId";
        ddlRowGroupGenrate.DataTextField = "RowName";
        ddlRowGroupGenrate.DataBind();
        ddlRowGroupGenrate.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }

    protected void clearGeneratelocation()
    {
        BindDdlWareHouseGenrate();
        ddlRowGroupGenrate.Items.Clear();
        ddlRowGroupGenrate.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }

    private void BindDdlWareHouseSearch()
    {
        ddlWareHouseSearch.DataSource = objPRSMBAL.GetWareHouse(0);
        ddlWareHouseSearch.DataValueField = "WareHouseId";
        ddlWareHouseSearch.DataTextField = "WarehouseName";
        ddlWareHouseSearch.DataBind();
        ddlWareHouseSearch.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }

    private void BindRowSearch(Int16 iwarehouseid, Int16 irowId)
    {
        ddlRowSearch.Items.Clear();
        ddlRowSearch.DataSource = null;
        ddlRowSearch.DataBind();
        ddlRowSearch.DataSource = objPRSMBAL.GetRowMaster(iwarehouseid, irowId);
        ddlRowSearch.DataValueField = "RowId";
        ddlRowSearch.DataTextField = "RowName";
        ddlRowSearch.DataBind();
        ddlRowSearch.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }
    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        btnGenerate.Enabled = false;
        string strmessage = objPRSMBAL.Genratelocation(Convert.ToInt16(ddlRowGroupGenrate.SelectedItem.Value));
        btnGenerate.Enabled = true;
        lblMessage.Text = strmessage;
        if (strmessage == "Record saved successfully.")
        {
            clearGeneratelocation();
        }

    }
    protected void ddlWareHouseGenrate_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlWareHouseGenrate.SelectedIndex > 0)
        {
            BindRow(Convert.ToInt16(ddlWareHouseGenrate.SelectedItem.Value), 0);
        }
        else
        {
            ddlRowGroupGenrate.Items.Clear();
            ddlRowGroupGenrate.DataSource = null;
            ddlRowGroupGenrate.DataValueField = "RowId";
            ddlRowGroupGenrate.DataTextField = "RowName";
            ddlRowGroupGenrate.DataBind();
            ddlRowGroupGenrate.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
    }
    protected void lnkbtnGenerateLocation_Click(object sender, EventArgs e)
    {
        GenerateLocation();
    }
    protected void lnkbtnMapLocation_Click(object sender, EventArgs e)
    {
        ddlRowSearch.SelectedIndex = 0;
        MapLocation();
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        clearGeneratelocation();
        lblMessage.Text = "";
    }

    #region [Rolewise access page funcationality]
    public void SetRolewiseAcessfuncationality()
    {
        UserRolewiseAcess objUserRoleWiseAcessDAL = new UserRolewiseAcess();
        DataTable dtPageId = objUserRoleWiseAcessDAL.GetApplicationCodeDetails("Page_Name", "Box Location").Tables[0];
        int PageId = 0;
        if (dtPageId.Rows.Count > 0)
        {
            PageId = Convert.ToInt32(dtPageId.Rows[0][0]);
        }
        DataTable dtPagefuncationality = objUserRoleWiseAcessDAL.GetPageFunctionalityByRoleAndPageId(PageId, RoleId).Tables[0];
        btnGenerate.Visible = false;
        btnCancel.Visible = false;
        btnSearch.Visible = false;
        btnUpload.Visible = false;
        btnSaveLocation.Visible = false;
        ViewState["Save"] = false;
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
                        case "Generate":
                            btnGenerate.Visible = true;
                            break;
                        case "Clear":
                            btnCancel.Visible = true;
                            break;
                        case "Upload":
                            btnUpload.Visible = true;
                            break;
                        case "Search":
                            btnSearch.Visible = true;
                            break;
                        case "Save":
                            ViewState["Save"] = true; 
                            break;
                        default:
                            break;
                    }
                }
            }
        }

        //  disablegrid(Convert.ToBoolean(ViewState["IsEditGrid"]));
    }

    //protected void disablegrid(bool IsEditGrid)
    //{
    //    if (gdvActivity.Rows.Count > 0 && IsEditGrid == false)
    //    {
    //        for (int i = 0; i < gdvActivity.Rows.Count; i++)
    //        {
    //            LinkButton lnkbtnEdit = (LinkButton)gdvActivity.Rows[i].FindControl("lnkbtnEdit");
    //            if (lnkbtnEdit != null)
    //            {
    //                lnkbtnEdit.Visible = false;
    //            }
    //        }
    //    }
    //}
    #endregion
    protected void lnkbtnSearchLocation_Click(object sender, EventArgs e)
    {
        ddlRowSearch.SelectedIndex = 0;
        SearchLocation();
    }
    protected void ddlWareHouseSearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlWareHouseSearch.SelectedIndex > 0)
        {
            BindRowSearch(Convert.ToInt16(ddlWareHouseSearch.SelectedItem.Value), 0);
        }
        else
        {
            ddlRowSearch.Items.Clear();
            ddlRowSearch.DataSource = null;
            ddlRowSearch.DataValueField = "RowId";
            ddlRowSearch.DataTextField = "RowName";
            ddlRowSearch.DataBind();
            ddlRowSearch.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        ViewState["dsResult"] = null;
        Int16 iWarehouseId = 0;
        Int16 iRowId = 0;
        string strLocationCode = "%%";
        if (ddlWareHouseSearch.SelectedIndex > 0)
        {
            iWarehouseId = Convert.ToInt16(ddlWareHouseSearch.SelectedItem.Value);
        }
        if (ddlRowSearch.SelectedIndex > 0)
        {
            iRowId = Convert.ToInt16(ddlRowSearch.SelectedItem.Value);
        }
        if (!string.IsNullOrEmpty(txtSearchLocation.Text.Trim()))
        {
            strLocationCode = txtSearchLocation.Text.Trim();
        }
        DataSet dsResult = new DataSet();
        dsResult = objPRSMBAL.GetLocationDetails(iWarehouseId, iRowId, strLocationCode);
        grdLocationDetails.DataSource = null;
        grdLocationDetails.DataBind();
        if (dsResult.Tables.Count > 0)
        {
            grdLocationDetails.DataSource = dsResult.Tables[0];
            ViewState["dsResult"] = dsResult;
            grdLocationDetails.DataBind();
        }
    }
    protected void grdLocationDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdLocationDetails.PageIndex = e.NewPageIndex;
        if (ViewState["dsResult"] != null)
        {
            DataSet dsResult = (DataSet)ViewState["dsResult"];
            if (dsResult.Tables.Count > 0)
            {
                grdLocationDetails.DataSource = dsResult.Tables[0];
                grdLocationDetails.DataBind();
            }
        }
    }
    [System.Web.Services.WebMethod]
    [System.Web.Script.Services.ScriptMethod()]
    public static List<Autocomplete> GetLocation(string prefix, string WareHouseId, string BoxId, int FileStatus)
    {
        short iInOutStatus = 0;

        int iBoxId = 0;
        if (!string.IsNullOrEmpty(BoxId))
        {
            iBoxId = Convert.ToInt32(BoxId);
        }
        DataSet ds = objPRSMBAL1.GetLocationDetails(Convert.ToInt16(WareHouseId), Convert.ToInt16(iBoxId), "%%");
        List<Autocomplete> result = new List<Autocomplete>();
        if (ds.Tables.Count > 0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    result.Add(new Autocomplete
                    {
                        label = Convert.ToString(ds.Tables[0].Rows[i]["LocationCode"]),
                        value = Convert.ToInt32(ds.Tables[0].Rows[i]["LocationId"])
                    });
                }
            }
        }
        var res = result.ToList().Where(r => r.label.ToLower().IndexOf(prefix.ToLower()) != -1);
        return result.ToList();
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        txtSearchLocation.Text = "";
        if (ddlRowSearch.Items.Count > 0)
        {
            ddlRowSearch.SelectedIndex = 0;
        }
        if (ddlWareHouseSearch.Items.Count > 0)
        {
            ddlWareHouseSearch.SelectedIndex = 0;
        }
    }


    private string  Import_ExcelandGenrrateXml(string FilePath, string Extension, string isHDR)
    {
        string conStr = string.Empty;
        string strxmlGenrate =string.Empty ;
        try
        {

       
        switch (Extension)
        {
            case ".xls": //Excel 97-03
                conStr = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source={0};Extended Properties='Excel 8.0;HDR={1}'";
                break;
            case ".xlsx": //Excel 07
                conStr = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0}; Extended Properties='Excel 8.0;HDR={1}'";
                break;
        }
        conStr = String.Format(conStr, FilePath, isHDR);
        OleDbConnection connExcel = new OleDbConnection(conStr);
        OleDbCommand cmdExcel = new OleDbCommand();
        OleDbDataAdapter oda = new OleDbDataAdapter();
        DataTable dtResultExcel = new DataTable();
        cmdExcel.Connection = connExcel;
        //Get the name of First Sheet
        connExcel.Open();
        DataTable dtExcelSchema;
        dtExcelSchema = connExcel.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
        string SheetName = dtExcelSchema.Rows[0]["TABLE_NAME"].ToString();
        connExcel.Close();
        //Read Data from First Sheet
        connExcel.Open();
        cmdExcel.CommandText = "SELECT * From [" + SheetName + "]";
        oda.SelectCommand = cmdExcel;
        oda.Fill(dtResultExcel);
        connExcel.Close();
        DataSet dsResult =new DataSet();
        dtResultExcel.TableName = "Root";
        dsResult.Tables.Add(dtResultExcel);
        strxmlGenrate = dsResult.GetXml();
        }
        catch (Exception ex )
        {
            ErrorHandler.WriteLog(ex);  
        }
        return strxmlGenrate;
    }

    protected void btnUpload_Click(object sender, EventArgs e)
    {
        if (fiuploadExcel.HasFile)
        {
            string FileName = Path.GetFileName(fiuploadExcel.PostedFile.FileName);
            string Extension = Path.GetExtension(fiuploadExcel.PostedFile.FileName);
            string FilePath = Server.MapPath(strSaveFilePath+"/"+"Location"+Guid.NewGuid().ToString()+ FileName);
            fiuploadExcel.SaveAs(FilePath);
            string strXmlLocations = Import_ExcelandGenrrateXml(FilePath, Extension, "Yes");
            grdValidateLocation.DataSource = null;
            grdValidateLocation.DataBind();
            lblLocationValidationMessage.Text = "";
            btnSaveLocation.Visible = false;
            if (!string.IsNullOrEmpty(strXmlLocations))
            {
                 //0 For Validate 1 For Insert
                DataSet dsResult = objPRSMBAL.ValidateAndMapLocations(0, strXmlLocations);
                if (dsResult != null)
                {
                    if (dsResult.Tables.Count > 0)
                    {
                        if (dsResult.Tables[0].Rows.Count > 0)
                        {
                            grdValidateLocation.DataSource = dsResult.Tables[0];
                            ViewState["ValidateLocation"] = dsResult.Tables[0];
                            grdValidateLocation.DataBind();
                        }
                        else
                        {
                            lblMessage.ForeColor = System.Drawing.Color.Brown;
                            lblLocationValidationMessage.Text = "Excel should have two columns as Location & BoxBarCode.";
                            btnSaveLocation.Visible = false;
                        }
                    }
                    if ((dsResult.Tables.Count > 1))
                    {
                        //lblMessage.ForeColor = System.Drawing.Color.Brown;    
                        //lblLocationValidationMessage.Text = Convert.ToString(dsResult.Tables[1].Rows[0]["Message"]);
                        bool IsVisible = false;
                        IsVisible = (bool)ViewState["Save"];
                        if (IsVisible)
                        {
                           // btnSaveLocation.Visible = true;
                        }
                    }
                    else
                    {
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                        lblLocationValidationMessage.Text = "Some entry are invalid";
                        btnSaveLocation.Visible = false;
                    }
                }
            }
        }
    }
    protected string GetImageForValid(object BoxOrLocStatus)
    {
        if (!string.IsNullOrEmpty(Convert.ToString(BoxOrLocStatus)))
        {
            return "../images/Invalid.png";
        }
        else {
            return "../images/Valid.png";
        }
   }
    protected void btnSaveLocation_Click(object sender, EventArgs e)
    {
        if (ViewState["ValidateLocation"] != null)
        {
            DataTable dtResult = (DataTable)ViewState["ValidateLocation"];
            dtResult.TableName = "Root";
            DataSet dsResult = new DataSet();
            dsResult.Tables.Add(dtResult);
            string strXmlLocations = dsResult.GetXml();
            //0 For Validate 1 For Insert
            DataSet dsResultOutput = objPRSMBAL.ValidateAndMapLocations(1, strXmlLocations);
            lblLocationValidationMessage.Text = "";
            grdValidateLocation.DataSource = null;
            grdValidateLocation.DataBind();
            btnSaveLocation.Visible = false;  
            if (dsResultOutput.Tables.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('Record Saved Successfully.')", true);
            }
        }
    }
}