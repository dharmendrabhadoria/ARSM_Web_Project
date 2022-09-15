using System;
using System.Text;
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
using System.Globalization;
using System.IO;
using System.Drawing;



/*
 * Thing stored in ViewState
ViewState["dsInvoivce"]  output of GetInvoice
ViewState["HigherEducation"] string
ViewState["EDUCATIONCESS"] string
ViewState["CustomerListTable"] - table with name root , and columns SrNo and n_CustomerId */

public partial class Transaction_MonthlyInvoice_New : PageBase
{
    #region Constsnts and Page level variables
    const string _LOGOIMAGE = "@imagepath@";
    const string _LOGOIMAGE1 = "@imagepath1@";
    const string _INVOICEACTIVITYLIST = "@InvoiceActivityList@";
    const string _INVOICENO = "@InvoiceNo@";
    const string _INVOICEDATE = "@InvoiceDate@";
    const string _CLIENT = "@Client@";
    const string _CLIENTPIN = "@ClientPin@";
    const string _CLIENTCITY = "@ClientCity@";
    const string _CLIENTSTATE = "@ClientState@";
    const string _CLIENTADDRESS1 = "@ClientAddress1@";
    const string _CLIENTADDRESS2 = "@ClientAddress2@";
    const string _INVOICEAMOUNT = "@INVOICEAMOUNT@";
    const string _VATAMOUNT = "@VATAMOUNT@";
    const string _EDUCATIONCESS = "@EDUCATIONCESS@";
    const string _GRANDTOTAL = "@GRANDTOTAL@";
    const string _VATPERCT = "@iHigherEducation@";
    const string _EDUCATIONCESSPERCT = "@EDUCATIONCESSPERCT@";
    const string _RECORDMANAGEMENTCHARGES = "@RECORDMANAGEMENTCHARGES@";
    const string _INVOICEFROM = "@InvoiceFrom@";
    const string _INVOICETO = "@InvoiceTo@";
    const string _SERVICETAXPERCT = "@SERVICETAXPERCT@";
    const string _SERVICETAXS = "@SERVICETAX@";
    const string _GRANDTOTALWORDS = "@GRANDTOTALWORDS@";
    const string _RECORDMANAGEMENTCHARGESDETAILS = "@RecordManagementChargesDetails@";
    const string _INVOICESUMMARY = "@INVOICESUMMARY@";
    private System.Globalization.CultureInfo enGB = new System.Globalization.CultureInfo("en-GB");
    PRSMBAL.MasterBAL objPRSMBAL = new MasterBAL();
    PRSMBAL.TransactionBAL objTRANSBAL = new TransactionBAL();
    #endregion
    int n_RowNumber = 0;
    int n_Invoice = 0;
    //Added by Sandip Hirave
    iTextSharp.text.Font calibri = iTextSharp.text.FontFactory.GetFont("calibri", 9, iTextSharp.text.Font.NORMAL, iTextSharp.text.BaseColor.BLACK);
    iTextSharp.text.Font calibri7 = iTextSharp.text.FontFactory.GetFont("calibri", 7, iTextSharp.text.Font.NORMAL, iTextSharp.text.BaseColor.BLACK);
    iTextSharp.text.Font calibribold = iTextSharp.text.FontFactory.GetFont("calibri", 9, iTextSharp.text.Font.BOLD, iTextSharp.text.BaseColor.BLACK);
    iTextSharp.text.Image imglogo;
    iTextSharp.text.Image imglogo1;
    iTextSharp.text.Image imgruppe;
    string FullFilePath;
    string LogoImagePath;
    string LogoImagePath1;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GenreateInvoice();
        }
        lblSearchResult.Text = "";
    }
    protected void GenreateInvoice()
    {
        ViewState["dsInvoivce"] = null;
        divGenrateInvoice.Style["display"] = "block";
        divViewInvoice.Style["display"] = "none";
        BindDdlWareHouse();
        BindDdlWareHouse_ForGetInvoice();
        txtInvoiceDate.Text = DateTime.Now.ToString("dd/MM/yyyy", enGB);
        txtInvoiceDate.Enabled = false;
        bindmonths();
        bindyears();
        BindCustomer();
        if (ddlYear.Items.Count > 0)
        {
            ddlYear.Items.FindByValue(DateTime.Now.Year.ToString()).Selected = true;
        }
        if (ddlMonth.Items.Count > 0)
        {
            ddlMonth.Items.FindByValue((DateTime.Now.Month - 1).ToString()).Selected = true;
        }
        bindTaxDetails();
        grdInvoice.DataSource = null;
        grdInvoice.DataBind();
        Clearcheckeitem();
        lnkbtnInovice.Style["color"] = "blue !important;";
        lnkbtnviewInvoice.Style["color"] = "#4f4f4f !important;";
    }
    protected void ViewInvoice()
    {
        divGenrateInvoice.Style["display"] = "none";
        divViewInvoice.Style["display"] = "block";
        //BindCompanyGroup(0);
        ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        bindmonthsView();
        bindyearsview();
        bindTomonthsView();
        bindToyearsview();
    }
    private void BindDdlWareHouse()
    {
        ddlWareHouse.DataSource = objPRSMBAL.GetWareHouse(0);
        ddlWareHouse.DataValueField = "WareHouseId";
        ddlWareHouse.DataTextField = "WarehouseName";
        ddlWareHouse.DataBind();
        ddlWareHouse.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }
    private void BindDdlWareHouse_ForGetInvoice()
    {
        ddlWareHouse_ForGetInvoice.DataSource = objPRSMBAL.GetWareHouse(0);
        ddlWareHouse_ForGetInvoice.DataValueField = "WareHouseId";
        ddlWareHouse_ForGetInvoice.DataTextField = "WarehouseName";
        ddlWareHouse_ForGetInvoice.DataBind();
        ddlWareHouse_ForGetInvoice.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlCompanyGroup.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }
    protected void bindmonths()
    {
        DateTimeFormatInfo info = DateTimeFormatInfo.GetInstance(null);
        List<Months> lstMonth = new List<Months>();
        for (int i = 1; i < 13; i++)
        {
            lstMonth.Add(new Months() { MonthId = i, MonthName = info.GetMonthName(i) });
        }
        ddlMonth.DataSource = null;
        ddlMonth.DataBind();
        ddlMonth.DataSource = lstMonth.ToList();
        ddlMonth.DataValueField = "MonthId";
        ddlMonth.DataTextField = "MonthName";
        ddlMonth.DataBind();
        ddlMonth.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }
    protected void bindTaxDetails()
    {
        DataSet ds = new DataSet();
        ds = objTRANSBAL.GetTaxMasterDetails(0);
        if (ds != null)
        {
            if (ds.Tables.Count > 0)
            {
                try
                {

                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        switch (Convert.ToString(ds.Tables[0].Rows[i]["TaxName"].ToString()))
                        {
                            case "Service Tax @14%":
                                txtServicetax.Text = Convert.ToString(ds.Tables[0].Rows[i]["TaxValue"].ToString());
                                ViewState["Service Tax @14%"] = Convert.ToString(ds.Tables[0].Rows[i]["TaxValue"].ToString());
                                break;
                            case "Swachh Bharat Cess @0.5%":
                                txtSwachhBharatCess.Text = Convert.ToString(ds.Tables[0].Rows[i]["TaxValue"].ToString());
                                ViewState["Swachh Bharat Cess @0.5%"] = Convert.ToString(ds.Tables[0].Rows[i]["TaxValue"].ToString());
                                break;
                            case "Krishi Kalyan Cess @0.5%":
                                txtKrishiKalyanCess.Text = Convert.ToString(ds.Tables[0].Rows[i]["TaxValue"].ToString());
                                ViewState["Krishi Kalyan Cess @0.5%"] = Convert.ToString(ds.Tables[0].Rows[i]["TaxValue"].ToString());
                                break;
                            //case "OTHER TAX":
                            //    txtotherCharges.Text = Convert.ToString(ds.Tables[0].Rows[i]["TaxValue"].ToString());
                            //    break;
                            default:
                                break;
                        }
                    }
                }
                catch (Exception ex)
                {
                    ErrorHandler.WriteLog(ex);
                }
            }
        }

    }

    protected DataTable CustomerListTable()
    {
        DataTable dtcustomerlist = new DataTable();
        if (ViewState["CustomerListTable"] == null)
        {
            dtcustomerlist.TableName = "Root";
            dtcustomerlist.Columns.Add("SrNo", typeof(int));
            dtcustomerlist.Columns["SrNo"].AutoIncrement = true;
            dtcustomerlist.Columns["SrNo"].AutoIncrementSeed = 0;
            dtcustomerlist.Columns.Add("n_CustomerId", typeof(Int32));
            dtcustomerlist.AcceptChanges();
        }
        else
        {
            dtcustomerlist = (DataTable)ViewState["CustomerListTable"];
        }
        return dtcustomerlist;
    }
    protected void AddCustoemr(int iSrNo, int CustomerId)
    {
        DataTable dtFilesDetails;
        DataRow drFilesDetails;
        dtFilesDetails = CustomerListTable();
        try
        {
            drFilesDetails = dtFilesDetails.NewRow();
            if (iSrNo == -1)
            {
                drFilesDetails["n_CustomerId"] = CustomerId;
                dtFilesDetails.Rows.Add(drFilesDetails);
                dtFilesDetails.AcceptChanges();
            }
            else
            {
                dtFilesDetails.Rows[iSrNo]["n_CustomerId"] = CustomerId;
                dtFilesDetails.AcceptChanges();
            }
            ViewState["CustomerListTable"] = dtFilesDetails;
        }
        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }
    }
    protected void bindyears()
    {
        var currentYear = DateTime.Today.Year;
        List<Years> lstYears = new List<Years>();
        for (int i = DateTime.Now.Year - 1; i <= DateTime.Now.Year; i++)
        {
            lstYears.Add(new Years() { YearId = i, YearName = Convert.ToString(i) });
        }
        ddlYear.DataSource = null;
        ddlYear.DataBind();
        ddlYear.DataSource = lstYears.ToList().OrderByDescending(m => m.YearId);
        ddlYear.DataValueField = "YearId";
        ddlYear.DataTextField = "YearName";
        ddlYear.DataBind();
        ddlYear.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }

    protected void bindyearsview()
    {
        List<Years> lstYears = new List<Years>();
        for (int i = DateTime.Now.Year - 3; i <= DateTime.Now.Year; i++)
        {
            lstYears.Add(new Years() { YearId = i, YearName = Convert.ToString(i) });
        }
        ddlYearView.DataSource = null;
        ddlYearView.DataBind();
        ddlYearView.DataSource = lstYears.ToList().OrderByDescending(m => m.YearId);
        ddlYearView.DataValueField = "YearId";
        ddlYearView.DataTextField = "YearName";
        ddlYearView.DataBind();
        // ddlYearView.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }
    protected void bindToyearsview()
    {
        List<Years> lstYears = new List<Years>();
        for (int i = DateTime.Now.Year - 3; i <= DateTime.Now.Year; i++)
        {
            lstYears.Add(new Years() { YearId = i, YearName = Convert.ToString(i) });
        }
        ddlToYearView.DataSource = null;
        ddlToYearView.DataBind();
        ddlToYearView.DataSource = lstYears.ToList().OrderByDescending(m => m.YearId);
        ddlToYearView.DataValueField = "YearId";
        ddlToYearView.DataTextField = "YearName";
        ddlToYearView.DataBind();
        //ddlToYearView.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }
    protected void bindmonthsView()
    {
        DateTimeFormatInfo info = DateTimeFormatInfo.GetInstance(null);
        List<Months> lstMonth = new List<Months>();
        for (int i = 1; i < 13; i++)
        {
            lstMonth.Add(new Months() { MonthId = i, MonthName = info.GetMonthName(i) });
        }
        ddlMonthView.DataSource = null;
        ddlMonthView.DataBind();
        ddlMonthView.DataSource = lstMonth.ToList().OrderBy(m => m.MonthId);
        ddlMonthView.DataValueField = "MonthId";
        ddlMonthView.DataTextField = "MonthName";
        ddlMonthView.DataBind();
        ddlMonthView.Items.FindByValue(System.DateTime.Now.Month.ToString()).Selected = true;
        //ddlMonthView.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }
    protected void bindTomonthsView()
    {
        DateTimeFormatInfo info = DateTimeFormatInfo.GetInstance(null);
        List<Months> lstMonth = new List<Months>();
        for (int i = 1; i < 13; i++)
        {
            lstMonth.Add(new Months() { MonthId = i, MonthName = info.GetMonthName(i) });
        }
        ddlToMonthView.DataSource = null;
        ddlToMonthView.DataBind();
        ddlToMonthView.DataSource = lstMonth.ToList().OrderBy(m => m.MonthId);
        ddlToMonthView.DataValueField = "MonthId";
        ddlToMonthView.DataTextField = "MonthName";
        ddlToMonthView.DataBind();
        ddlToMonthView.Items.FindByValue(System.DateTime.Now.Month.ToString()).Selected = true;
        // ddlToMonthView.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }
    public void BindCustomer()
    {
        DataSet dsCustomer = new DataSet();
        grdCustomer.DataSource = null;
        grdCustomer.DataBind();
        dsCustomer = objPRSMBAL.GetCustomerByWarehouseId(Convert.ToInt32(ddlWareHouse.SelectedValue));
        if (dsCustomer.Tables[0].Rows.Count > 0)
        {
            grdCustomer.DataSource = dsCustomer.Tables[0];
            grdCustomer.DataBind();
        }
    }
    public void BindCompanyNameByWHID()
    {
        DataSet dsCustomer = new DataSet();
        ddlCompanyGroup.DataSource = null;
        ddlCompanyGroup.DataBind();
        dsCustomer = objPRSMBAL.GetCompanyNamebyID(Convert.ToInt32(ddlWareHouse_ForGetInvoice.SelectedValue));

        ddlCompanyGroup.DataSource = dsCustomer;
        ddlCompanyGroup.DataValueField = "n_CompanyGroupId";
        ddlCompanyGroup.DataTextField = "CompanyGroupName";
        ddlCompanyGroup.DataBind();
        ddlCompanyGroup.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }

    public class Months
    {
        public int MonthId { get; set; }
        public string MonthName { get; set; }
    }
    public class Years
    {
        public int YearId { get; set; }
        public string YearName { get; set; }
    }

    protected void btnGenrateInvoice_Click(object sender, EventArgs e)
    {
        if (Page.IsPostBack)
        {
            try
            {
                for (int i = 0; i < grdCustomer.Rows.Count; i++)
                {
                    CheckBox chkstatus = (CheckBox)grdCustomer.Rows[i].FindControl("chkstatus");
                    if (chkstatus != null)
                    {
                        if (chkstatus.Checked)
                        {
                            HiddenField hdncustomerId = (HiddenField)grdCustomer.Rows[i].FindControl("hdncustomerId");
                            if (hdncustomerId != null)
                            {
                                AddCustoemr(-1, Convert.ToInt32(hdncustomerId.Value));
                            }
                        }
                    }
                }
                string strxmlCustomerData;
                int iMonthYear = 0;
                Int16 iWareHouseId = 0;
                iWareHouseId = Convert.ToInt16(ddlWareHouse.SelectedItem.Value);
                DataSet dsxml = new DataSet();
                dsxml.Tables.Add(CustomerListTable());
                dsxml.Tables[0].TableName = "Root";
                dsxml.AcceptChanges();
                strxmlCustomerData = dsxml.GetXml();
                string strMonth = ddlMonth.SelectedItem.Value.ToString();
                string strYear = ddlYear.SelectedItem.Value.ToString();
                if (strMonth.Length <= 1)
                {
                    strMonth = "0" + strMonth;
                }
                iMonthYear = Convert.ToInt32(strYear + strMonth);
                DataSet dsResult = new DataSet();
                dsResult = objTRANSBAL.USP_GenerateInvoice_GST(Convert.ToInt32(strMonth), Convert.ToInt32(strYear), iWareHouseId, strxmlCustomerData, Convert.ToInt16(UserId));
                lblMessage.Text = "Invoice generated successfully";
                lblMsg.Text = "Invoice generated successfully";
                grdresult.DataSource = null;
                grdresult.DataBind();
                if (dsResult != null)
                {
                    if (dsResult.Tables.Count > 0)
                    {
                        grdresult.DataSource = dsResult.Tables[0];
                        grdresult.DataBind();
                    }
                }
                clear();
                //lblMessage.Text = "";
                BindCustomer();
                ViewState["CustomerListTable"] = null;
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "divShowResult();", true);
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Invoice/s could not be generated";
                lblMsg.Text = "Invoice/s could not be generated";
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "divShowResult();", true);
                ErrorHandler.WriteLog(ex);
            }
        }
    }
    protected void clear()
    {
        ddlYear.ClearSelection();
        ddlMonth.ClearSelection();
        ddlWareHouse.ClearSelection();
        if (ddlWareHouse.Items.Count > 0)
        {
            ddlWareHouse.SelectedIndex = 0;
        }
        if (ddlYear.Items.Count > 0)
        {
            ddlYear.Items.FindByValue(DateTime.Now.Year.ToString()).Selected = true;
        }
        if (ddlMonth.Items.Count > 0)
        {
            ddlMonth.Items.FindByValue((DateTime.Now.Month - 1).ToString()).Selected = true;
        }
        Clearcheckeitem();
    }
    protected void Clearcheckeitem()
    {
        CheckBox chkBoxstatusAll = null;
        if (chkBoxstatusAll != null)
        {
            chkBoxstatusAll = (CheckBox)grdCustomer.HeaderRow.FindControl("chkBoxstatusAll");
            chkBoxstatusAll.Checked = false;
            return;
        }
        for (int i = 0; i < grdCustomer.Rows.Count; i++)
        {

            CheckBox chkstatus = (CheckBox)grdCustomer.Rows[i].FindControl("chkstatus");

            if (chkstatus != null)
            {
                chkstatus.Checked = false;
            }
        }
    }
    //protected void BindCompanyGroup(int iCompanyId)
    //{
    //    ddlCompanyGroup.DataSource = null;
    //    ddlCompanyGroup.DataBind();
    //    //ddlCompanyGroup.DataSource = objPRSMBAL.GetCompanyGroup(iCompanyId);
    //    ddlCompanyGroup.DataSource = objPRSMBAL.GetCompanyGroup(Convert.ToInt32(ddlWareHouse_ForGetInvoice.SelectedValue));
    //    ddlCompanyGroup.DataValueField = "CompanyGroupId";
    //    ddlCompanyGroup.DataTextField = "CGName";
    //    ddlCompanyGroup.DataBind();
    //    ddlCompanyGroup.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    //}
    protected void lnkbtnviewInvoice_Click(object sender, EventArgs e)
    {
        ViewInvoice();
        lnkbtnviewInvoice.Style["color"] = "blue !important;";
        lnkbtnInovice.Style["color"] = "#4f4f4f !important;";
    }
    protected void lnkbtnInovice_Click(object sender, EventArgs e)
    {
        GenreateInvoice();
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
    protected string GetInvoiceNo(object invoiceNo)
    {
        string InvoiceNo = Convert.ToString(invoiceNo);
        switch (Convert.ToString(InvoiceNo).Length)
        {
            case 1:
                InvoiceNo = "00000" + Convert.ToInt32(invoiceNo);
                break;
            case 2:
                InvoiceNo = "0000" + Convert.ToInt32(invoiceNo);
                break;
            case 3:
                InvoiceNo = "000" + Convert.ToInt32(invoiceNo);
                break;
            case 4:
                InvoiceNo = "00" + Convert.ToInt32(invoiceNo);
                break;
            case 5:
                InvoiceNo = "0" + Convert.ToInt32(invoiceNo);
                break;
            default:
                break;
        }
        return InvoiceNo;
    }
    protected string GetInvoiceNum(object invoiceNo)
    {
        string InvoiceNo = Convert.ToString(invoiceNo);
        switch (Convert.ToString(InvoiceNo).Length)
        {
            case 1:
                InvoiceNo = "00000" + Convert.ToInt32(invoiceNo);
                break;
            case 2:
                InvoiceNo = "0000" + Convert.ToInt32(invoiceNo);
                break;
            case 3:
                InvoiceNo = "000" + Convert.ToInt32(invoiceNo);
                break;
            case 4:
                InvoiceNo = "00" + Convert.ToInt32(invoiceNo);
                break;
            case 5:
                InvoiceNo = "0" + Convert.ToInt32(invoiceNo);
                break;
            default:
                break;
        }
        return InvoiceNo;
    }
    protected void ddlCompanyGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlCompanyGroup.SelectedIndex > 0)
        {
            BindCustomer(Convert.ToByte(ddlCompanyGroup.SelectedItem.Value));
        }
        else
        {
            ddlCustomer.Items.Clear();
            ddlCustomer.DataSource = null;
            ddlCustomer.DataBind();
            ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
    }

    protected void GenrateInvoicePDF_HTML(string Strhtml)
    {

        Response.Clear();

        string  CustomerName = ddlYearView.SelectedItem.Text + "-" + ddlMonthView.SelectedItem.Text + "-" + ddlCustomer.SelectedItem.Text;
        CustomerName = CustomerName.Replace(" ", "-");

        Response.ContentType = "application/pdf";
        Response.AddHeader("content-disposition", string.Format("attachment;filename={0}.pdf", CustomerName));
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.BinaryWrite(GetPDF(Strhtml));
        Response.End();
    }
    public byte[] GetPDF(string pHTML)
    {
        byte[] bPDF = null;

        //MemoryStream ms = new MemoryStream();
        TextReader txtReader = new StringReader(pHTML);

        // 1: create object of a itextsharp document class
        ///Document doc = new Document(PageSize.A4, 25, 25, 25, 25);
        var document = new iTextSharp.text.Document(iTextSharp.text.PageSize.A4, 30, 30, 10, 10);

        // 2: we create a itextsharp pdfwriter that listens to the document and directs a XML-stream to a file
        ///PdfWriter oPdfWriter = PdfWriter.GetInstance(doc, ms);
        var output = new MemoryStream();
        iTextSharp.text.pdf.PdfWriter writer = iTextSharp.text.pdf.PdfWriter.GetInstance(document, output);
        // 3: we create a worker parse the document
        iTextSharp.text.html.simpleparser.HTMLWorker htmlWorker = new iTextSharp.text.html.simpleparser.HTMLWorker(document);

        // 4: we open document and start the worker on the document
        document.Open();
        htmlWorker.StartDocument();


        // 5: parse the html into the document
        htmlWorker.Parse(txtReader);

        // 6: close the document and the worker
        htmlWorker.EndDocument();
        htmlWorker.Close();
        document.Close();

        bPDF = output.ToArray();

        return bPDF;
    }
    protected void GenrateInvoicePDF(DataSet dsInvoice)
    {
        //Added By Sandip Hirave
        //Fonts
        Int32 CustomerId = Convert.ToInt32(dsInvoice.Tables[0].Rows[0]["CustomerId"].ToString());

        DataSet dsProvider = new DataSet();
        dsProvider = objTRANSBAL.GetProviderDetails(CustomerId);
        int ProviderID = Convert.ToInt32(dsProvider.Tables[0].Rows[0]["n_ProviderId"].ToString());
        //Added By Sandip Hirave
        if (ProviderID == 1)
        {
            //Images
            //imglogo = iTextSharp.text.Image.GetInstance(HttpContext.Current.Server.MapPath("~/images/prsm-logo.png"));
            //imglogo1 = iTextSharp.text.Image.GetInstance(HttpContext.Current.Server.MapPath("~/images/panoramic-group-logo1.png"));

            imglogo = iTextSharp.text.Image.GetInstance(HttpContext.Current.Server.MapPath("~/images/apaar-logo.png"));
            imglogo1 = iTextSharp.text.Image.GetInstance(HttpContext.Current.Server.MapPath("~/images/apaar-logo.png"));
            imgruppe = iTextSharp.text.Image.GetInstance(HttpContext.Current.Server.MapPath("~/images/imgruppe.png"));
            imgruppe.ScaleAbsolute(6.0f, 6.0f);
            //Image Paths
            FullFilePath = Server.MapPath("~/Reports/invoice.html");
            //LogoImagePath = Server.MapPath("~/images/prsm-logo.png");
            //LogoImagePath1 = Server.MapPath("~/images/panoramic-group-logo1.png");
            LogoImagePath = Server.MapPath("~/images/apaar-logo.png");
            LogoImagePath1 = Server.MapPath("~/images/apaar-logo.png");
            LogoImagePath = "'" + LogoImagePath + "'";
        }
        //Added By Sandip Hirave
        if (ProviderID == 2)
        {
            //Images
            //imglogo = iTextSharp.text.Image.GetInstance(HttpContext.Current.Server.MapPath("~/images/prsm-logo1.png"));
            //imglogo1 = iTextSharp.text.Image.GetInstance(HttpContext.Current.Server.MapPath("~/images/panoramic-group-logo2.png"));

            imglogo = iTextSharp.text.Image.GetInstance(HttpContext.Current.Server.MapPath("~/images/apaar-logo.png"));
            imglogo1 = iTextSharp.text.Image.GetInstance(HttpContext.Current.Server.MapPath("~/images/apaar-logo.png"));
            imgruppe = iTextSharp.text.Image.GetInstance(HttpContext.Current.Server.MapPath("~/images/imgruppe.png"));
            imgruppe.ScaleAbsolute(6.0f, 6.0f);
            //Image Paths
            FullFilePath = Server.MapPath("~/Reports/invoice1.html");
            //LogoImagePath = Server.MapPath("~/images/prsm-logo1.png");
            //LogoImagePath1 = Server.MapPath("~/images/panoramic-group-logo2.png");
            LogoImagePath = Server.MapPath("~/images/apaar-logo.png");
            LogoImagePath1 = Server.MapPath("~/images/apaar-logo.png");
            LogoImagePath = "'" + LogoImagePath + "'";
        }

        string CustomerName = "";
        iTextSharp.text.pdf.PdfPTable TableInvoiceSummary = new iTextSharp.text.pdf.PdfPTable(3);
        float[] widthsTableInvoiceSummary = new float[] { 550f, 520f, 130f };
        TableInvoiceSummary.WidthPercentage = 100;
        TableInvoiceSummary.SetWidths(widthsTableInvoiceSummary);

        iTextSharp.text.pdf.PdfPTable Headertable = new iTextSharp.text.pdf.PdfPTable(3);
        iTextSharp.text.pdf.PdfPCell Headercell = new iTextSharp.text.pdf.PdfPCell(imglogo1);

        // Commented By: Vishal Temkar
        // Date : 25-Jan-2016
        //Int16 iMonth = Convert.ToInt16(ddlMonthView.SelectedItem.Value.ToString());
        //Int16 iYear = Convert.ToInt16(ddlYearView.SelectedItem.Value.ToString());

        Int16 iMonth = Convert.ToInt16(dsInvoice.Tables[0].Rows[0]["MonthYear"].ToString().Substring(4, 2));// ddlMonthView.SelectedItem.Value.ToString());
        Int16 iYear = Convert.ToInt16(dsInvoice.Tables[0].Rows[0]["MonthYear"].ToString().Substring(0, 4));

        DateTime Fromdate = new DateTime(iYear, iMonth, 1);
        DateTime Todate = new DateTime(iYear, iMonth, DateTime.DaysInMonth(iYear, iMonth));
        if (Todate > DateTime.Now)
            Todate = DateTime.Now;

        //if (dt.Rows.Count > 0)

        var document = new iTextSharp.text.Document(iTextSharp.text.PageSize.A4, 30, 30, 10, 10);
        var output = new MemoryStream();
        iTextSharp.text.pdf.PdfWriter writer = iTextSharp.text.pdf.PdfWriter.GetInstance(document, output);
        writer.PageEvent = new Footer(dsProvider);
        document.Open();
        Headertable.AddCell(Headercell);
        Headertable.SpacingBefore = 5f;
        Headercell = new iTextSharp.text.pdf.PdfPCell(imglogo1);
        Headercell.HorizontalAlignment = iTextSharp.text.Element.ALIGN_RIGHT;
        Headertable.AddCell(Headercell);
        float[] widths = new float[] { 250f, 350f, 100f };
        Headertable.SetWidths(widths);
        document.Add(Headertable);
        string contents = File.ReadAllText(FullFilePath);
        contents = contents.Replace(_LOGOIMAGE, LogoImagePath);
        contents = contents.Replace(_LOGOIMAGE1, LogoImagePath1);

        iTextSharp.text.pdf.PdfPCell cellTest = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(""));
        cellTest.BorderWidth = 0.0f;
        cellTest.Colspan = 3;
        cellTest.FixedHeight = 3.2f;

        if (dsInvoice != null)
        {
            if (dsInvoice.Tables.Count > 0)
            {
                //Replaceing Invoice No, date, customer name with address using Invoice.html. //Reports/Invoice.html 
                if (dsInvoice.Tables[0].Rows.Count > 0)
                {
                    int j = 0;
                    //for (int j = 0; j < dsInvoice.Tables[0].Rows.Count; j++)
                    {
                        /*Old Invoice Serice */
                        string InvoiceNo = Convert.ToString(dsInvoice.Tables[0].Rows[j]["InvoiceNo"]);
                        //switch (Convert.ToString(dsInvoice.Tables[0].Rows[j]["InvoiceNo"]).Length  )
                        //{
                        //    case 1:
                        //        InvoiceNo = "00000" + Convert.ToInt32(dsInvoice.Tables[0].Rows[j]["InvoiceNo"]);
                        //        break ;
                        //    case 2:
                        //        InvoiceNo = "0000"+Convert.ToInt32(dsInvoice.Tables[0].Rows[j]["InvoiceNo"]) ;
                        //        break ;
                        //    case 3:
                        //        InvoiceNo = "000"+Convert.ToInt32(dsInvoice.Tables[0].Rows[j]["InvoiceNo"]) ;
                        //        break ;
                        //    case 4:
                        //        InvoiceNo = "00"+Convert.ToInt32(dsInvoice.Tables[0].Rows[j]["InvoiceNo"]) ;
                        //        break ;
                        //    case 5:
                        //        InvoiceNo = "0" + Convert.ToInt32(dsInvoice.Tables[0].Rows[j]["InvoiceNo"]);
                        //        break;
                        //    default:
                        //        break;
                        //}
                        //contents = contents.Replace(_INVOICENO, Convert.ToString(dsInvoice.Tables[0].Rows[j]["InvoiceNo"]));
                        contents = contents.Replace(_INVOICENO, InvoiceNo);
                        contents = contents.Replace(_INVOICEFROM, Convert.ToDateTime(Fromdate).ToString("dd-MM-yyyy"));
                        contents = contents.Replace(_INVOICETO, Convert.ToDateTime(Todate).ToString("dd-MM-yyyy"));
                        contents = contents.Replace(_INVOICEDATE, Convert.ToDateTime(dsInvoice.Tables[0].Rows[j]["InvoiceDate"]).ToString("dd-MM-yyyy"));
                        contents = contents.Replace(_CLIENT, Convert.ToString(dsInvoice.Tables[0].Rows[j]["CustomerName"]));
                        contents = contents.Replace(_CLIENTADDRESS1, Convert.ToString(dsInvoice.Tables[0].Rows[j]["BillingAddress1"]));
                        contents = contents.Replace(_CLIENTADDRESS2, Convert.ToString(dsInvoice.Tables[0].Rows[j]["BillingAddress2"]));
                        contents = contents.Replace(_CLIENTPIN, Convert.ToString(dsInvoice.Tables[0].Rows[j]["PinCode"]));
                        contents = contents.Replace(_CLIENTCITY, Convert.ToString(dsInvoice.Tables[0].Rows[j]["CityName"]));
                        contents = contents.Replace(_CLIENTSTATE, Convert.ToString(dsInvoice.Tables[0].Rows[j]["StateName"]));

                        // creating PDF Blank cell for adding blank cell in PDF table
                        iTextSharp.text.pdf.PdfPCell cellFBlank = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(""));
                        cellFBlank.HorizontalAlignment = iTextSharp.text.Element.ALIGN_RIGHT;
                        cellFBlank.BorderWidth = 0f;
                        cellFBlank.VerticalAlignment = iTextSharp.text.Element.ALIGN_MIDDLE;
                        TableInvoiceSummary.AddCell(cellFBlank);
                        TableInvoiceSummary.AddCell(cellFBlank);
                        TableInvoiceSummary.AddCell(cellFBlank);
                        TableInvoiceSummary.AddCell(cellFBlank);
                        TableInvoiceSummary.AddCell(cellFBlank);
                        TableInvoiceSummary.AddCell(cellFBlank);
                        TableInvoiceSummary.AddCell(cellFBlank);
                        TableInvoiceSummary.AddCell(cellFBlank);
                        TableInvoiceSummary.AddCell(cellFBlank);
                        if (Convert.ToInt16(dsInvoice.Tables[0].Rows[0]["BillingMode"]) == 2)
                        {

                            iTextSharp.text.pdf.PdfPCell cellServiceName11 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(Convert.ToString("Record Management Charges"), calibri));
                            cellServiceName11.HorizontalAlignment = iTextSharp.text.Element.ALIGN_LEFT;
                            cellServiceName11.BorderWidth = 0f;
                            cellServiceName11.VerticalAlignment = iTextSharp.text.Element.ALIGN_MIDDLE;
                            cellServiceName11.Padding = 3;
                            TableInvoiceSummary.AddCell(cellServiceName11);
                            TableInvoiceSummary.AddCell(cellFBlank);
                            iTextSharp.text.pdf.PdfPCell cellAmount11 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(Convert.ToString(dsInvoice.Tables[0].Rows[j]["StorageCharges"]), calibri));
                            cellAmount11.HorizontalAlignment = iTextSharp.text.Element.ALIGN_RIGHT;
                            cellAmount11.BorderWidth = 0f;
                            cellAmount11.VerticalAlignment = iTextSharp.text.Element.ALIGN_MIDDLE;
                            cellAmount11.Padding = 3;
                            TableInvoiceSummary.AddCell(cellAmount11);
                            cellTest.FixedHeight = 10.2f;
                            TableInvoiceSummary.AddCell(cellTest);



                        }
                        else
                        {
                            //Adding record Management Charges service in TableInvoiceSummary table
                            double NoOfBoxes = Convert.ToDouble(dsInvoice.Tables[0].Rows[0]["ExistingBox"]) + Convert.ToDouble(dsInvoice.Tables[0].Rows[0]["NBoxCountBefore15"]);
                            iTextSharp.text.pdf.PdfPCell cellServiceName = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Record Management Charges \n (No of Boxes : " + Convert.ToString(NoOfBoxes + ")"), calibri));
                            //iTextSharp.text.pdf.PdfPCell cellServiceName = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Record Management Charges \n (" +  + ")"), calibri));
                            cellServiceName.HorizontalAlignment = iTextSharp.text.Element.ALIGN_LEFT;
                            cellServiceName.BorderWidth = 0f;
                            cellServiceName.Padding = 3;
                            cellServiceName.VerticalAlignment = iTextSharp.text.Element.ALIGN_MIDDLE;
                            TableInvoiceSummary.AddCell(cellServiceName);
                            TableInvoiceSummary.AddCell(cellFBlank);
                            iTextSharp.text.pdf.PdfPCell cellAmount = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(Convert.ToString(dsInvoice.Tables[0].Rows[j]["StorageCharges"]), calibri));
                            cellAmount.HorizontalAlignment = iTextSharp.text.Element.ALIGN_RIGHT;
                            cellAmount.BorderWidth = 0f;
                            cellAmount.VerticalAlignment = iTextSharp.text.Element.ALIGN_MIDDLE;
                            cellAmount.Padding = 3;
                            TableInvoiceSummary.AddCell(cellAmount);
                            cellTest.FixedHeight = 10.2f;
                            TableInvoiceSummary.AddCell(cellTest);

                        }

                        //Adding  services in TableInvoiceSummary
                        if (dsInvoice.Tables.Count > 1)
                        {
                            for (int i = 0; i < dsInvoice.Tables[1].Rows.Count; i++)
                            {
                                iTextSharp.text.pdf.PdfPCell cellServiceName1 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(Convert.ToString(dsInvoice.Tables[1].Rows[i]["s_SCName"]), calibri));
                                cellServiceName1.HorizontalAlignment = iTextSharp.text.Element.ALIGN_LEFT;
                                cellServiceName1.BorderWidth = 0f;
                                cellServiceName1.VerticalAlignment = iTextSharp.text.Element.ALIGN_MIDDLE;
                                cellServiceName1.Padding = 3;
                                TableInvoiceSummary.AddCell(cellServiceName1);
                                TableInvoiceSummary.AddCell(cellFBlank);
                                iTextSharp.text.pdf.PdfPCell cellAmount1 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(Convert.ToString(dsInvoice.Tables[1].Rows[i]["Amount"]), calibri));
                                cellAmount1.HorizontalAlignment = iTextSharp.text.Element.ALIGN_RIGHT;
                                cellAmount1.BorderWidth = 0f;
                                cellAmount1.VerticalAlignment = iTextSharp.text.Element.ALIGN_MIDDLE;
                                cellAmount1.Padding = 3;
                                TableInvoiceSummary.AddCell(cellAmount1);
                                cellTest.FixedHeight = 10.2f;
                                TableInvoiceSummary.AddCell(cellTest);
                            }
                        }
                        else
                        {
                            contents = contents.Replace(_INVOICESUMMARY, "");
                        }
                        //Adding Education, HigherEducation,Service Tax, Net Amount and Invoice Amount
                        //iHigherEducation Replace with Krishi_Kalyan_Cess
                        //EDUCESSPERCT	Replace with Swachh_Bharat_Cess
                        //SERVICETAXPERCT Replace with Service_Tax

                        cellTest.FixedHeight = 3.2f;
                        string Service_Tax = "0";
                        string Swachh_Bharat_Cess = "0";
                        string Krishi_Kalyan_Cess = "0";
                        if (ViewState["Service Tax @14%"] != null)
                        {
                            Service_Tax = Convert.ToString(ViewState["Service Tax @14%"]);
                        }
                        if (ViewState["Swachh Bharat Cess @0.5%"] != null)
                        {
                            Swachh_Bharat_Cess = Convert.ToString(ViewState["Swachh Bharat Cess @0.5%"]);
                        }
                        if (ViewState["Krishi Kalyan Cess @0.5%"] != null)
                        {
                            Krishi_Kalyan_Cess = Convert.ToString(ViewState["Krishi Kalyan Cess @0.5%"]);
                        }
                        for (int i = 1; i <= 6; i++)
                        {
                            switch (i)
                            {
                                case 1:
                                    int TotalServiceCategory = 7 - dsInvoice.Tables[1].Rows.Count + 1;
                                    for (int ij = 0; ij < TotalServiceCategory; ij++)
                                    {
                                        cellFBlank.FixedHeight = 10.2f;
                                        TableInvoiceSummary.AddCell(cellFBlank);
                                        TableInvoiceSummary.AddCell(cellFBlank);
                                        TableInvoiceSummary.AddCell(cellFBlank);
                                        TableInvoiceSummary.AddCell(cellFBlank);
                                        TableInvoiceSummary.AddCell(cellFBlank);
                                        TableInvoiceSummary.AddCell(cellFBlank);
                                    }

                                    iTextSharp.text.pdf.PdfPCell cellServiceName1 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Net Amount", calibri));
                                    cellServiceName1.HorizontalAlignment = iTextSharp.text.Element.ALIGN_RIGHT;
                                    cellServiceName1.BorderWidth = 0f;
                                    cellServiceName1.VerticalAlignment = iTextSharp.text.Element.ALIGN_MIDDLE;
                                    cellServiceName1.Padding = 3;
                                    TableInvoiceSummary.AddCell(cellFBlank);
                                    TableInvoiceSummary.AddCell(cellServiceName1);
                                    iTextSharp.text.Phrase PH = new iTextSharp.text.Phrase("", calibri);
                                    PH.Add(new iTextSharp.text.Chunk(imgruppe, 0, 0));
                                    PH.Add(" " + Convert.ToString(dsInvoice.Tables[0].Rows[j]["InvoiceAmount"]));
                                    iTextSharp.text.pdf.PdfPCell cellAmount1 = new iTextSharp.text.pdf.PdfPCell(PH);
                                    cellAmount1.HorizontalAlignment = iTextSharp.text.Element.ALIGN_RIGHT;
                                    cellAmount1.BorderWidth = 0f;
                                    cellAmount1.BorderWidth = 0f;
                                    cellAmount1.BorderWidthTop = 0.5f;
                                    cellAmount1.VerticalAlignment = iTextSharp.text.Element.ALIGN_MIDDLE;
                                    TableInvoiceSummary.AddCell(cellAmount1);
                                    TableInvoiceSummary.AddCell(cellFBlank);
                                    TableInvoiceSummary.AddCell(cellFBlank);
                                    TableInvoiceSummary.AddCell(cellFBlank);
                                    TableInvoiceSummary.AddCell(cellTest);
                                    TableInvoiceSummary.AddCell(cellTest);
                                    break;
                                case 2:
                                    TableInvoiceSummary.AddCell(cellTest);
                                    TableInvoiceSummary.AddCell(cellTest);
                                    iTextSharp.text.pdf.PdfPCell cellServiceName4 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Service Tax @" + Service_Tax + "% ", calibri));
                                    cellServiceName4.HorizontalAlignment = iTextSharp.text.Element.ALIGN_LEFT;
                                    cellServiceName4.BorderWidth = 0f;
                                    cellServiceName4.VerticalAlignment = iTextSharp.text.Element.ALIGN_MIDDLE;
                                    cellServiceName4.Padding = 3;
                                    TableInvoiceSummary.AddCell(cellServiceName4);
                                    TableInvoiceSummary.AddCell(cellFBlank);
                                    iTextSharp.text.pdf.PdfPCell cellAmount4 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(Convert.ToString(dsInvoice.Tables[0].Rows[j]["ServiceTax"]), calibri));
                                    cellAmount4.HorizontalAlignment = iTextSharp.text.Element.ALIGN_RIGHT;
                                    cellAmount4.BorderWidth = 0f;
                                    cellAmount4.VerticalAlignment = iTextSharp.text.Element.ALIGN_MIDDLE;
                                    TableInvoiceSummary.AddCell(cellAmount4);
                                    TableInvoiceSummary.AddCell(cellTest);
                                    break;
                                case 3:
                                    iTextSharp.text.pdf.PdfPCell cellServiceName2 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Swachh Bharat Cess @" + Swachh_Bharat_Cess + "% ", calibri));
                                    cellServiceName2.HorizontalAlignment = iTextSharp.text.Element.ALIGN_LEFT;
                                    cellServiceName2.BorderWidth = 0f;
                                    cellServiceName2.VerticalAlignment = iTextSharp.text.Element.ALIGN_MIDDLE;
                                    cellServiceName2.Padding = 3;
                                    TableInvoiceSummary.AddCell(cellServiceName2);
                                    TableInvoiceSummary.AddCell(cellFBlank);
                                    iTextSharp.text.pdf.PdfPCell cellAmount2 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(Convert.ToString(dsInvoice.Tables[0].Rows[j]["EduTax"]), calibri));
                                    cellAmount2.HorizontalAlignment = iTextSharp.text.Element.ALIGN_RIGHT;
                                    cellAmount2.BorderWidth = 0f;
                                    cellAmount2.VerticalAlignment = iTextSharp.text.Element.ALIGN_MIDDLE;
                                    TableInvoiceSummary.AddCell(cellAmount2);
                                    TableInvoiceSummary.AddCell(cellTest);
                                    break;
                                case 4:
                                    iTextSharp.text.pdf.PdfPCell cellServiceName3 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Krishi Kalyan Cess @" + Krishi_Kalyan_Cess + "% ", calibri));
                                    cellServiceName3.HorizontalAlignment = iTextSharp.text.Element.ALIGN_LEFT;
                                    cellServiceName3.BorderWidth = 0f;
                                    cellServiceName3.VerticalAlignment = iTextSharp.text.Element.ALIGN_MIDDLE;
                                    cellServiceName3.Padding = 3;
                                    TableInvoiceSummary.AddCell(cellServiceName3);
                                    TableInvoiceSummary.AddCell(cellFBlank);
                                    string strHigherEducation = Convert.ToString(dsInvoice.Tables[0].Rows[j]["HigherEducation"]).Trim();
                                    if (string.IsNullOrEmpty(strHigherEducation))
                                    {
                                        strHigherEducation = "0.00";
                                    }
                                    iTextSharp.text.pdf.PdfPCell cellAmount3 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(strHigherEducation, calibri));
                                    cellAmount3.HorizontalAlignment = iTextSharp.text.Element.ALIGN_RIGHT;
                                    cellAmount3.BorderWidth = 0f;
                                    cellAmount3.VerticalAlignment = iTextSharp.text.Element.ALIGN_MIDDLE;
                                    TableInvoiceSummary.AddCell(cellAmount3);
                                    TableInvoiceSummary.AddCell(cellTest);
                                    break;
                                case 5:
                                    iTextSharp.text.pdf.PdfPCell cellServiceName5 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Invoice Amount", calibri));
                                    cellServiceName5.HorizontalAlignment = iTextSharp.text.Element.ALIGN_RIGHT;
                                    cellServiceName5.BorderWidth = 0f;
                                    cellServiceName5.VerticalAlignment = iTextSharp.text.Element.ALIGN_MIDDLE;
                                    cellServiceName5.Padding = 3;
                                    TableInvoiceSummary.AddCell(cellFBlank);
                                    TableInvoiceSummary.AddCell(cellServiceName5);
                                    iTextSharp.text.Phrase PH1 = new iTextSharp.text.Phrase("", calibri);
                                    PH1.Add(new iTextSharp.text.Chunk(imgruppe, 0, 0));
                                    PH1.Add(" " + Convert.ToString(dsInvoice.Tables[0].Rows[j]["TotalAmount"]));
                                    iTextSharp.text.pdf.PdfPCell cellAmount5 = new iTextSharp.text.pdf.PdfPCell(PH1);
                                    cellAmount5.HorizontalAlignment = iTextSharp.text.Element.ALIGN_RIGHT;
                                    cellAmount5.BorderWidth = 0f;
                                    cellAmount5.BorderWidthTop = 0.5f;
                                    cellAmount5.VerticalAlignment = iTextSharp.text.Element.ALIGN_MIDDLE;
                                    TableInvoiceSummary.AddCell(cellAmount5);
                                    break;
                                case 6:
                                    string TotalAmtinWords = MoneyConvDS.MoneyConvFn(Convert.ToString(dsInvoice.Tables[0].Rows[j]["TotalAmount"]));
                                    cellFBlank.Colspan = 3;
                                    TableInvoiceSummary.AddCell(cellFBlank);
                                    iTextSharp.text.pdf.PdfPCell cellServiceName6 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(TotalAmtinWords, calibri));
                                    cellServiceName6.HorizontalAlignment = iTextSharp.text.Element.ALIGN_RIGHT;

                                    cellServiceName6.BorderWidth = 0f;
                                    cellServiceName6.VerticalAlignment = iTextSharp.text.Element.ALIGN_MIDDLE;
                                    cellServiceName6.Colspan = 3;
                                    cellServiceName6.Padding = 3;
                                    TableInvoiceSummary.AddCell(cellServiceName6);
                                    TableInvoiceSummary.AddCell(cellFBlank);
                                    break;
                                default:
                                    break;
                            }
                        }
                    }
                }
            }
        }
        int iCounter = 0;
        var parsedHtmlElements = iTextSharp.text.html.simpleparser.HTMLWorker.ParseToList(new StringReader(contents), null);
        iTextSharp.text.pdf.PdfPTable tableBorder = new iTextSharp.text.pdf.PdfPTable(1);
        float[] widthstableBorder = new float[] { 700F };
        tableBorder.SetWidths(widthstableBorder);
        tableBorder.WidthPercentage = 100;
        iTextSharp.text.pdf.PdfPCell cell = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(""));
        cell = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("   "));
        cell.BorderColorBottom = iTextSharp.text.BaseColor.GRAY;
        cell.BorderWidthLeft = 0f;
        cell.BorderWidthRight = 0f;
        cell.BorderWidthTop = 0f;
        cell.BorderWidthBottom = 0.4f;
        cell.MinimumHeight = 0.2f;
        cell.FixedHeight = 0.2f;
        tableBorder.AddCell(cell);


        foreach (var htmlElement in parsedHtmlElements)
        {
            document.Add(htmlElement as iTextSharp.text.IElement);
            if (iCounter == 0)
            {
                document.Add(tableBorder);
            }
            if (iCounter == 3)
            {
                document.Add(tableBorder);
                document.Add(TableInvoiceSummary);
                document.Add(tableBorder);
            }
            iCounter = iCounter + 1;
        }
        document.NewPage();
        string sActivitylist = "";
        string strInvoiceAmount = " ";
        double nSubTotalAmount = 0.00;
        double nNetTotalAmount = 0.00;
        string strRecordManagementAmount = " ";
        if (dsInvoice.Tables.Count > 1)
        {
            strInvoiceAmount += Convert.ToString(dsInvoice.Tables[0].Rows[0]["InvoiceAmount"]);
            strRecordManagementAmount = Convert.ToString(dsInvoice.Tables[0].Rows[0]["StorageCharges"]);
            // nSubTotalAmount =Convert.ToDouble(dsInvoice.Tables[0].Rows[0]["TotalAmount"]) - Convert.ToDouble(dsInvoice.Tables[0].Rows[0]["StorageCharges"]);
            nNetTotalAmount = Convert.ToDouble(dsInvoice.Tables[0].Rows[0]["TotalAmount"]) + Convert.ToDouble(dsInvoice.Tables[0].Rows[0]["StorageCharges"]);

            sActivitylist = genrateActivityHTMl(dsInvoice.Tables[0], dsInvoice.Tables[2], strInvoiceAmount, ProviderID);
        }

        //Invoice Total PDF Changes
        iTextSharp.text.pdf.PdfPTable tableTotalPDF = new iTextSharp.text.pdf.PdfPTable(2);
        float[] widthstableTotalPDF = new float[] { 910F, 90F };
        tableTotalPDF.WidthPercentage = 100;
        tableTotalPDF.SetWidths(widthstableTotalPDF);

        iTextSharp.text.pdf.PdfPCell cellBlankC = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri7));
        cellBlankC.BorderWidth = 0f;
        cellBlankC.BorderWidthLeft = 0f;
        cellBlankC.BorderWidthRight = 0f;
        cellBlankC.BorderWidthTop = 0f;
        cell.BorderWidthBottom = 0;

        //Sub Total
        iTextSharp.text.pdf.PdfPCell cellTitle = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Net Amount:", calibri7));
        cellTitle.HorizontalAlignment = iTextSharp.text.Element.ALIGN_RIGHT;
        cellTitle.BorderWidth = 0f;
        cellTitle.Padding = 0f;
        iTextSharp.text.Phrase PHTotal = new iTextSharp.text.Phrase(" ", calibri7);
        PHTotal.Add(new iTextSharp.text.Chunk(imgruppe, 0, 0));
        PHTotal.Add(" " + string.Format("{0:0.00}", strInvoiceAmount));
        iTextSharp.text.pdf.PdfPCell cellT = new iTextSharp.text.pdf.PdfPCell(PHTotal);
        //cellT.BorderWidth = 0f;
        //cellT.BorderWidthLeft = 0f;
        //cellT.BorderWidthRight = 0f;
        //cellT.BorderWidthTop = 0f;
        //cellT.BorderWidthBottom = 0;
        cellT.BorderWidth = 0f;
        cellT.Padding = 0f;
        cellT.BorderWidthTop = 0.4f;
        cellT.PaddingTop = 3f;
        cellTitle.PaddingTop = 3f;
        cellT.HorizontalAlignment = iTextSharp.text.Element.ALIGN_RIGHT;


        tableTotalPDF.AddCell(cellBlankC);
        tableTotalPDF.AddCell(cellBlankC);
        tableTotalPDF.AddCell(cellTitle);
        tableTotalPDF.AddCell(cellT);
        tableTotalPDF.AddCell(cellBlankC);
        tableTotalPDF.AddCell(cellBlankC);
        tableTotalPDF.AddCell(cell);
        tableTotalPDF.AddCell(cell);

        ////Record Management
        //iTextSharp.text.pdf.PdfPCell cellRecordManagentTitle = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Record Management Charges:", calibri7));
        //cellRecordManagentTitle.BorderWidth = 0f;
        //cellRecordManagentTitle.Padding = 0f;
        //cellRecordManagentTitle.HorizontalAlignment = iTextSharp.text.Element.ALIGN_RIGHT;
        //iTextSharp.text.Phrase RecordManagentTotal = new iTextSharp.text.Phrase(" ", calibri7);
        //RecordManagentTotal.Add(new iTextSharp.text.Chunk(imgruppe, 0, 0));
        //RecordManagentTotal.Add(" " + strRecordManagementAmount);
        //iTextSharp.text.pdf.PdfPCell cellRecordManagent = new iTextSharp.text.pdf.PdfPCell(RecordManagentTotal);
        //cellRecordManagent.Padding = 0f;
        //cellRecordManagent.BorderWidth = 0f;
        //cellRecordManagent.HorizontalAlignment = iTextSharp.text.Element.ALIGN_RIGHT;
        //tableTotalPDF.AddCell(cellRecordManagentTitle);
        //tableTotalPDF.AddCell(cellRecordManagent);

        ////Net Amount
        //iTextSharp.text.pdf.PdfPCell cellNetAmountTitle = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Net Amount:", calibri7));
        //cellNetAmountTitle.BorderWidth = 0f;
        //cellNetAmountTitle.Padding = 0f;
        //cellNetAmountTitle.HorizontalAlignment = iTextSharp.text.Element.ALIGN_RIGHT;
        //iTextSharp.text.Phrase NetAmountPh = new iTextSharp.text.Phrase(" ", calibri7);
        //NetAmountPh.Add(new iTextSharp.text.Chunk(imgruppe, 0, 0));
        //NetAmountPh.Add(" " + strInvoiceAmount);
        //iTextSharp.text.pdf.PdfPCell cellNetAmount = new iTextSharp.text.pdf.PdfPCell(NetAmountPh);
        //cellNetAmount.BorderWidth = 0f;
        //cellNetAmount.Padding = 0f;
        //cellNetAmount.HorizontalAlignment = iTextSharp.text.Element.ALIGN_RIGHT;
        //tableTotalPDF.AddCell(cellBlankC);
        //tableTotalPDF.AddCell(cellBlankC);
        //cellNetAmount.BorderWidthTop = 0.4f;
        //cellNetAmount.PaddingTop = 3f;
        //cellNetAmountTitle.PaddingTop = 3f;
        //tableTotalPDF.AddCell(cellNetAmountTitle);
        //tableTotalPDF.AddCell(cellNetAmount);

        var parsedHtmlElementsActivitylist = iTextSharp.text.html.simpleparser.HTMLWorker.ParseToList(new StringReader(sActivitylist), null);
        iCounter = 0;
        foreach (var htmlElement in parsedHtmlElementsActivitylist)
        {
            document.Add(htmlElement as iTextSharp.text.IElement);
            if (iCounter == 0)
            {
                document.Add(tableBorder);
            }
            iCounter = iCounter + 1;
        }
        document.Add(tableTotalPDF);
        //document.Close();


        //document.NewPage();
        //string sActivitylist1 = "";
        //string strInvoiceAmount1 = " ";
        //double nSubTotalAmount1 = 0.00;
        //double nNetTotalAmount1 = 0.00;
        //string strRecordManagementAmount1 = " ";
        //if ()
        //{

        //}



        foreach (GridViewRow gvrow in grdInvoice.Rows)
        {

            CheckBox chk = (CheckBox)gvrow.FindControl("chkBoxstatusDaywise");
            //Int64 nID = Convert.ToInt64(grdInvoice.DataKeys[((GridViewRow)chk.NamingContainer).RowIndex].Value);


            if (chk != null & chk.Checked)
            {
                if (gvrow.RowIndex == n_RowNumber)
                {
                    document.NewPage();
                    string sActivitylist1 = "";
                    string strInvoiceAmount1 = " ";
                    if (dsInvoice.Tables.Count > 1)
                    {
                        strInvoiceAmount1 = Convert.ToString(dsInvoice.Tables[3].Compute("Sum(DayCharges)", ""));
                        //strRecordManagementAmount1 = Convert.ToString(dsInvoice.Tables[0].Rows[n_RowNumber]["StorageCharges"]);
                        // nSubTotalAmount1 =Convert.ToDouble(dsInvoice.Tables[0].Rows[0]["TotalAmount"]) - Convert.ToDouble(dsInvoice.Tables[0].Rows[0]["StorageCharges"]);
                        //nNetTotalAmount1 = Convert.ToDouble(dsInvoice.Tables[0].Rows[n_RowNumber]["TotalAmount"]) + Convert.ToDouble(dsInvoice.Tables[0].Rows[n_RowNumber]["StorageCharges"]);

                        sActivitylist1 = genrateActivityHTMl1(dsInvoice.Tables[0], dsInvoice.Tables[3], strInvoiceAmount1);

                        //if (rowIndex % 2 != 0)
                        //{
                        //    cell.BackgroundColor = new BaseColor(System.Drawing.ColorTranslator.FromHtml("#9ab2ca"));
                        //}
                        //else
                        //{
                        //    cell.BackgroundColor = new BaseColor(System.Drawing.ColorTranslator.FromHtml("#f1f5f6"));
                        //}
                    }



                    //Invoice Total PDF Changes
                    iTextSharp.text.pdf.PdfPTable tableTotalPDF1 = new iTextSharp.text.pdf.PdfPTable(2);
                    float[] widthstableTotalPDF1 = new float[] { 910F, 90F };
                    tableTotalPDF1.WidthPercentage = 100;
                    tableTotalPDF1.SetWidths(widthstableTotalPDF1);

                    iTextSharp.text.pdf.PdfPCell cellBlankC1 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri7));
                    cellBlankC1.BorderWidth = 0f;
                    cellBlankC1.BorderWidthLeft = 0f;
                    cellBlankC1.BorderWidthRight = 0f;
                    cellBlankC1.BorderWidthTop = 0f;
                    cell.BorderWidthBottom = 0;

                    //Sub Total
                    iTextSharp.text.pdf.PdfPCell cellTitle1 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Total Amount:", calibri7));
                    cellTitle1.HorizontalAlignment = iTextSharp.text.Element.ALIGN_RIGHT;
                    cellTitle1.BorderWidth = 0f;
                    cellTitle1.Padding = 0f;
                    iTextSharp.text.Phrase PHTotal1 = new iTextSharp.text.Phrase(" ", calibri7);
                    PHTotal1.Add(new iTextSharp.text.Chunk(imgruppe, 0, 0));
                    PHTotal1.Add(" " + string.Format("{0:0.00}", Convert.ToDecimal(strInvoiceAmount1)));
                    iTextSharp.text.pdf.PdfPCell cellT1 = new iTextSharp.text.pdf.PdfPCell(PHTotal1);
                    cellT1.BorderWidth = 0f;
                    cellT1.BorderWidthLeft = 0f;
                    cellT1.BorderWidthRight = 0f;
                    cellT1.BorderWidthTop = 0f;
                    cellT1.BorderWidthBottom = 0;
                    cellT1.BorderWidth = 0f;
                    cellT1.Padding = 0f;
                    cellT1.BorderWidthTop = 0.4f;
                    cellT1.PaddingTop = 3f;
                    cellTitle1.PaddingTop = 3f;
                    cellT1.HorizontalAlignment = iTextSharp.text.Element.ALIGN_RIGHT;


                    tableTotalPDF1.AddCell(cellBlankC1);
                    tableTotalPDF1.AddCell(cellBlankC1);
                    tableTotalPDF1.AddCell(cellTitle1);
                    tableTotalPDF1.AddCell(cellT1);
                    tableTotalPDF1.AddCell(cellBlankC1);
                    tableTotalPDF1.AddCell(cellBlankC1);
                    tableTotalPDF1.AddCell(cell);
                    tableTotalPDF1.AddCell(cell);

                    var parsedHtmlElementsActivitylist1 = iTextSharp.text.html.simpleparser.HTMLWorker.ParseToList(new StringReader(sActivitylist1), null);
                    iCounter = 0;
                    foreach (var htmlElement1 in parsedHtmlElementsActivitylist1)
                    {
                        document.Add(htmlElement1 as iTextSharp.text.IElement);
                        if (iCounter == 0)
                        {
                            document.Add(tableBorder);
                        }
                        iCounter = iCounter + 1;
                    }


                    document.Add(tableTotalPDF1);
                }
            }
        }


        document.Close();
        //CustomerName = ddlYearView.SelectedItem.Text + "-" + ddlMonthView.SelectedItem.Text + ddlCustomer.SelectedItem.Text;
        //CustomerName = Convert.ToDateTime(Fromdate).ToString("dd-MMM-yyyy") + "To" + Convert.ToDateTime(Todate).ToString("dd-MMM-yyyy");
        ////CustomerName = CustomerName.Replace(" ", "-");
        //Response.ContentType = "application/pdf";
        //Response.AddHeader("Content-Disposition", string.Format("attachment;filename={0}.pdf", CustomerName));
        CustomerName = ddlYearView.SelectedItem.Text + "-" + ddlMonthView.SelectedItem.Text + "-" + ddlCustomer.SelectedItem.Text;
        CustomerName = CustomerName.Replace(" ", "-");
        Response.ContentType = "application/pdf";
        Response.AddHeader("Content-Disposition", string.Format("attachment;filename={0}.pdf", CustomerName));
        Response.BinaryWrite(output.ToArray());

    }

    protected string genrateActivityHTMl(DataTable dtRMC, DataTable dt, string strInvoiceAmount, int ProviderID)
    { // Adding all activities releated to the invoice ie. Activity details page

        //string Filed = "Header";
        //DataSet dsSubFooter = objTRANSBAL.GetHeaderFooterDetails(ProviderID, Filed);
        string LogoImagePath;
        string LogoImagePath1;
        string rupeeImagepath;
        StringBuilder sb = new StringBuilder();
        string strdActivityDate = string.Empty;
        string strActivity = string.Empty;
        string strRate = string.Empty;
        string strunit = string.Empty;
        string strQuantiy = string.Empty;
        string strAmount = string.Empty;
        string strWorkorderNo = string.Empty;
        string strHead = string.Empty;
        //Added By Sandip Hirave
        if (ProviderID == 1)
        {
            //LogoImagePath = Server.MapPath("~/images/prsm-logo.png");
            //LogoImagePath1 = Server.MapPath("~/images/panoramic-group-logo1.png");
            LogoImagePath = Server.MapPath("~/images/apaar-logo.png");
            LogoImagePath1 = Server.MapPath("~/images/apaar-logo.png");
            rupeeImagepath = Server.MapPath("~/images/imgruppe.png");

            sb.Append(" <p> <table border='0' cellpadding='5' cellspacing='0' style='margin: 0 auto;font-family: Calibri;font-size:10px; width:100%'>");
            sb.Append("<tr> <td style='width: 450;' align='left' colspan='4'   > <img src='" + LogoImagePath + "'   /> <br />");
            sb.Append("<p  style='align:center;font-size: 6pt;'  > <b style='font-size: 6pt;' >Registered Office:</b>  ");
            sb.Append("111-113,Kalyandas Udyog Bhavan, Near Century Bazar, Prabhadevi, Mumbai - 400025. </label><br/>");
            sb.Append("<b style='font-size: 6pt;' >Storage Premises:</b> Gala Nos:J/10/,J/11 &J/13,Globe Complex,");
            sb.Append("Dapode Bypass Road,Ovali,Bhiwandi-421302. Tel no. 02522-661807 </p>");
            sb.Append("   </td><td style='width: 75;' align='right' > <img src='" + LogoImagePath1 + "'   />  </td>");
            sb.Append("</tr>  </table></p>");
            sb.Append(" <table border='0' cellpadding='5' cellspacing='0' style='margin: 0 auto;font-family: Calibri;font-size:10px; width:100%'> <tr> <td align='right' width:100%  ><p  style='font-size: 8pt;text-decoration:underline'  > INVOICE DETAILS  </p>  <td> </tr> </table> <br/>");
            sb.Append("<table width='100%' style='font-size: 7pt' border='0'  cellspacing='0' cellpadding='0' >");
            //if (dt.Rows.Count > 0)
            //{
            strHead = "<tr>  <td width='5%' valign='top'> No.";
            strHead += " </td>   <td width='10%' valign='top'>";
            strHead += "    Date</td>    <td width='10%' valign='top'>  Work Order";
            strHead += "      </td>                        <td width='45%' valign='top'> Activity     </td>";
            strHead += "<td width='10%' valign='top'>Rate (INR)               </td>";
            strHead += "<td width='10%' valign='top' align='center'> Qty";
            strHead += "</td><td valign='top' width='10%' align='right' > Amount (INR) </td></tr>";
            strHead += "<tr> <td valign='top' width='100%' colspan='7' >   _________________________________________________________________________________________________________________________________________</td></tr>";
            sb.Append(strHead);
        }
        //Added By Sandip Hirave
        if (ProviderID == 2)
        {
            //LogoImagePath = Server.MapPath("~/images/prsm-logo1.png");
            //LogoImagePath1 = Server.MapPath("~/images/panoramic-group-logo2.png");
            LogoImagePath = Server.MapPath("~/images/apaar-logo.png");
            LogoImagePath1 = Server.MapPath("~/images/apaar-logo.png");
            rupeeImagepath = Server.MapPath("~/images/imgruppe.png");

            sb.Append(" <p> <table border='0' cellpadding='5' cellspacing='0' style='margin: 0 auto;font-family: Calibri;font-size:10px; width:100%'>");
            sb.Append("<tr> <td style='width: 450;' align='left' colspan='4'   > <img src='" + LogoImagePath + "'   /> <br />");
            sb.Append("<p  style='align:center;font-size: 6pt;'  > <b style='font-size: 6pt;' >Registered Office:</b>  ");
            sb.Append("111-113,Kalyandas Udyog Bhavan, Near Century Bazar, Prabhadevi, Mumbai - 400025. </label><br/>");
            sb.Append("<b style='font-size: 6pt;' >Storage Premises:</b> Gala Nos:J/10/,J/11 &J/13,Globe Complex,");
            sb.Append("Dapode Bypass Road,Ovali,Bhiwandi-421302. Tel no. 02522-661807 </p>");
            sb.Append("   </td><td style='width: 75;' align='right' > <img src='" + LogoImagePath1 + "'   />  </td>");
            sb.Append("</tr>  </table></p>");
            sb.Append(" <table border='0' cellpadding='5' cellspacing='0' style='margin: 0 auto;font-family: Calibri;font-size:10px; width:100%'> <tr> <td align='right' width:100%  ><p  style='font-size: 8pt;text-decoration:underline'  > INVOICE DETAILS  </p>  <td> </tr> </table> <br/>");
            sb.Append("<table width='100%' style='font-size: 7pt' border='0'  cellspacing='0' cellpadding='0' >");
            //if (dt.Rows.Count > 0)
            //{
            strHead = "<tr>  <td width='5%' valign='top'> No.";
            strHead += " </td>   <td width='10%' valign='top'>";
            strHead += "    Date</td>    <td width='10%' valign='top'>  Work Order";
            strHead += "      </td>                        <td width='45%' valign='top'> Activity     </td>";
            strHead += "<td width='10%' valign='top'>Rate (INR)               </td>";
            strHead += "<td width='10%' valign='top' align='center'> Qty";
            strHead += "</td><td valign='top' width='10%' align='right' > Amount (INR) </td></tr>";
            strHead += "<tr> <td valign='top' width='100%' colspan='7' >   _________________________________________________________________________________________________________________________________________</td></tr>";
            sb.Append(strHead);
        }


        //}
        // string strActivity1 = Convert.ToString(dtRMC.Rows[0]["ActivityName"]);
        //string strdActivityDate1 = Convert.ToDateTime(dt.Rows[0]["ActivityDate"]).ToString("dd-MM-yyyy");
        //Record Management charges for new box and new box 1-15 and new box 16-30 they want new box only ---- Modified By Sunil Pandey

        double nRate = 0.0;
        double nQty = 0.0;
        double nAmount = 0.0;
        nRate = Convert.ToDouble(dtRMC.Rows[0]["RecordMangementCharges"]);

        for (int j = 0; j < 2; j++)
        {

            if (j == 0)
            {
                //nRate += Convert.ToDouble(dtRMC.Rows[0]["RMCNewRate"]);

                nQty += Convert.ToDouble(dtRMC.Rows[0]["ExistingBox"]);
                nAmount += Convert.ToDouble(dtRMC.Rows[0]["TotalExistBoxAmount"]);
            }
            if (j == 1)
            {
                // nRate += Convert.ToDouble(dtRMC.Rows[0]["RMCNewRate"]);
                nQty += Convert.ToDouble(dtRMC.Rows[0]["NBoxCountBefore15"]);
                nAmount += Convert.ToDouble(dtRMC.Rows[0]["TotalNewBoxAmount"]);
            }

            //if (j==0)
            // {
            //string strQuantiy1 = Convert.ToString(dtRMC.Rows[0]["ExistingBox"]);
            //string strRate1 = Convert.ToString(dtRMC.Rows[0]["RecordMangementCharges"]);
            //string strAmount1 = Convert.ToString(dtRMC.Rows[0]["TotalExistBoxAmount"]);

            //string strHtml1 = "<tr><td width='5%' valign='top'>" +1+ "</td>";
            //strHtml1 += "<td width='10%' align='center' valign='top'>- </td>";
            //strHtml1 += "<td width='10%' align='center' valign='top'> - </td>";
            //strHtml1 += "<td width='45%' valign='top' >Record Management Charges</td>";
            ////strHtml1 += "<td width='10%' valign='top'> " + strWorkorderNo + " </td>";
            ////strHtml1 += "<td width='45%' valign='top'> " + strActivity + " </td>";
            //strHtml1 += "<td width='10%' valign='top'>" + strRate1 + "</td>";
            //strHtml1 += "<td width='10%' valign='top' align='center'>" + strQuantiy1 + " </td>";
            //strHtml1 += "<td valign='top' width='10%' align='right' >" + strAmount1 + " </td>";
            //strHtml1 += "</tr>";
            //sb.Append(strHtml1);
            //}
            //if (j== 1)
            // {
            //     string strQuantiy2 = Convert.ToString(dtRMC.Rows[0]["NBoxCountBefore15"]);
            //     string strRate2 = Convert.ToString(dtRMC.Rows[0]["RMCNewRate"]);
            //     string strAmount2 = Convert.ToString(dtRMC.Rows[0]["TotalNewBoxAmount"]);

            //     string strHtml2 = "<tr><td width='5%' valign='top'>" + 2+"</td>";
            //     strHtml2 += "<td width='10%' align='center' valign='top'>- </td>";
            //     strHtml2 += "<td width='10%' align='center' valign='top'> - </td>";
            //     strHtml2 += "<td width='45%' valign='top' >Record Management Charges(New Boxes 1-15)</td>";
            //     strHtml2 += "<td width='10%' valign='top'>" + strRate2 + "</td>";
            //     strHtml2 += "<td width='10%' valign='top' align='center'>" + strQuantiy2 + " </td>";
            //     strHtml2 += "<td valign='top' width='10%' align='right' >" + strAmount2 + " </td>";
            //     strHtml2 += "</tr>";
            //     sb.Append(strHtml2);
            // }
            //if (j == 2)
            //{
            //    string strQuantiy2 = Convert.ToString(dtRMC.Rows[0]["NBoxAF15"]);
            //    string strRate2 = "0.0";
            //    //Convert.ToString(dtRMC.Rows[0]["RecordMangementCharges"]);
            //    //  string strAmount2 = Convert.ToString(dtRMC.Rows[0]["TotalNewBoxAmount"]);

            //    string strHtml2 = "<tr><td width='5%' valign='top'>" + 3 + "</td>";
            //    strHtml2 += "<td width='10%' align='center' valign='top'>-</td>";
            //    strHtml2 += "<td width='10%' align='center' valign='top'>-</td>";
            //    strHtml2 += "<td width='45%' valign='top'>Record Management Charges(New Boxes 16-30)</td>";
            //    //strHtml1 += "<td width='10%' valign='top'> " + strWorkorderNo + " </td>";
            //    //strHtml1 += "<td width='45%' valign='top'> " + strActivity + " </td>";
            //    strHtml2 += "<td width='10%' valign='top'>" + strRate2 + "</td>";
            //    strHtml2 += "<td width='10%' valign='top' align='center'>" + strQuantiy2 + " </td>";
            //    strHtml2 += "<td valign='top' width='10%' align='right' >0.00</td>";
            //    strHtml2 += "</tr>";
            //    sb.Append(strHtml2);
            //}
        }

        if (Convert.ToInt16(dtRMC.Rows[0]["BillingMode"]) == 2)
        {
            nRate = 0;
        }
        //else nRate = Convert.ToDouble(dtRMC.Rows[0]["RecordMangementTotalBoxes"]);

        //nQty = Convert.ToDouble(dtRMC.Rows[0]["RecordMangementTotalBoxes"]);
        //nAmount = Convert.ToDouble(dtRMC.Rows[0]["StorageCharges"]);
        string strHtml1 = "<tr><td width='5%' valign='top'>" + 1 + "</td>";
        strHtml1 += "<td width='10%' align='center' valign='top'>- </td>";
        strHtml1 += "<td width='10%' align='center' valign='top'> - </td>";
        strHtml1 += "<td width='45%' valign='top' >Record Management Charges</td>";
        //strHtml1 += "<td width='10%' valign='top'> " + strWorkorderNo + " </td>";
        //strHtml1 += "<td width='45%' valign='top'> " + strActivity + " </td>";
        if (Convert.ToInt16(dtRMC.Rows[0]["BillingMode"]) == 2)
        {
            strHtml1 += "<td width='10%' valign='top'>" + "</td>";
            strHtml1 += "<td width='10%' valign='top' align='center'>" + " </td>";
        }
        else
        {
            strHtml1 += "<td width='10%' valign='top'>" + nRate.ToString("0.00") + "</td>";
            strHtml1 += "<td width='10%' valign='top' align='center'>" + nQty + " </td>";
        }


        strHtml1 += "<td valign='top' width='10%' align='right' >" + nAmount.ToString("0.00") + " </td>";
        strHtml1 += "</tr>";
        sb.Append(strHtml1);

        int itoalActivity = Convert.ToInt32(dt.Rows.Count - 1);
        for (int i = 0; i < dt.Rows.Count; i++)
        {

            int iSrNo = i + 2;
            strActivity = Convert.ToString(dt.Rows[i]["ActivityName"]);
            strdActivityDate = Convert.ToDateTime(dt.Rows[i]["ActivityDate"]).ToString("dd-MM-yyyy");
            strQuantiy = Convert.ToString(dt.Rows[i]["ActivityCount"]);
            strRate = Convert.ToString(dt.Rows[i]["Amount"]) + "  " + Convert.ToString(dt.Rows[i]["Unit"]);
            strAmount = Convert.ToString(dt.Rows[i]["TotalAmount"]);
            strWorkorderNo = Convert.ToString(dt.Rows[i]["WorkorderNo"]);
            string strHtml = "<tr>       <td width='5%' valign='top'>" + iSrNo + "</td>";
            strHtml += "<td width='10%' valign='top'> " + strdActivityDate + " </td>";
            strHtml += "<td width='10%' valign='top'> " + strWorkorderNo + " </td>";
            strHtml += "<td width='45%' valign='top'> " + strActivity + " </td>";
            strHtml += "<td width='10%' valign='top'>" + strRate + "<br/>" + strunit + " </td>";
            strHtml += "<td width='10%' valign='top' align='center'>" + strQuantiy + " </td>";
            strHtml += "<td valign='top' width='10%' align='right' >" + strAmount + " </td>";
            strHtml += "</tr>";
            sb.Append(strHtml);

        }
        sb.Append("</table>");
        return sb.ToString();
    }
    protected string genrateActivityHTMl1(DataTable dtRMC, DataTable dt, string strInvoiceAmount1)
    { // Adding all activities releated to the invoice ie. Activity details page
      //string LogoImagePath = Server.MapPath("~/images/prsm-logo.png");
      //string LogoImagePath1 = Server.MapPath("~/images/panoramic-group-logo1.png");

        string LogoImagePath = Server.MapPath("~/images/apaar-logo.png");
        string LogoImagePath1 = Server.MapPath("~/images/apaar-logo.png");
        string rupeeImagepath = Server.MapPath("~/images/imgruppe.png");
        StringBuilder sb = new StringBuilder();
        string strdActivityDate = string.Empty;
        string NoofBox = string.Empty;
        decimal strAmount;
        //string strActivity = string.Empty;
        //string strRate = string.Empty;
        //string strunit = string.Empty;
        //string strQuantiy = string.Empty;
        //string strAmount = string.Empty;
        //string strWorkorderNo = string.Empty;
        string strHead = string.Empty;


        sb.Append(" <p> <table border='0' cellpadding='5' cellspacing='0' style='margin: 0 auto;font-family: Calibri;font-size:10px; width:100%'>");
        sb.Append("<tr> <td style='width: 450;' align='left' colspan='4'   > <img src='" + LogoImagePath + "'   /> <br />");
        sb.Append("<p  style='align:center;font-size: 6pt;'  > <b style='font-size: 6pt;' >Registered Office:</b>  ");
        sb.Append("111-113,Kalyandas Udyog Bhavan, Near Century Bazar, Prabhadevi, Mumbai - 400025. </label><br/>");
        sb.Append("<b style='font-size: 6pt;' >Storage Premises:</b> Gala Nos:J/10/,J/11 &J/13,Globe Complex,");
        sb.Append("Dapode Bypass Road,Ovali,Bhiwandi-421302. Tel no. 02522-661807 </p>");
        sb.Append("   </td><td style='width: 75;' align='right' > <img src='" + LogoImagePath1 + "'   />  </td>");
        sb.Append("</tr>  </table></p>");
        sb.Append(" <table border='0' cellpadding='5' cellspacing='0' style='margin: 0 auto;font-family: Calibri;font-size:10px; width:100%'> <tr> <td align='right' width:100%  ><p  style='font-size: 8pt;text-decoration:underline'  > Record Management Charge Details  </p>  <td> </tr> </table> <br/>");
        sb.Append("<table width='100%' style='font-size: 7pt' border='0'  cellspacing='0' cellpadding='0' >");
        //if (dt.Rows.Count > 0)
        //{
        strHead = "<tr>  <td width='5%' valign='top'> No.";
        strHead += " </td>   <td width='10%' valign='top' align='right' style='background-color: #18B5F0'>";
        strHead += "    Date</td>    <td width='10%' valign='top' align='right'>  No Of Boxes";
        strHead += "      </td>                        <td width='45%' valign='top' align='right'> Amount     </td>";
        strHead += "<tr> <td valign='top' width='10%' colspan='7' >   _________________________________________________________________________________________________________________________________________</td></tr>";
        sb.Append(strHead);
        //sb.Append("<html><body><table class='reportWrapperTable' cellspacing='0'cellpadding='4' rules='rows' style='color:#1f2240;background-color:#ffffff'><thead style='100%;color:#ffffff;background-color:#1f2240;font-weight:bold'><tr>" + strHead);

        //}


        //string strHtml1 = "<tr><td width='5%' valign='top'>" + 1 + "</td>";
        ////strHtml1 += "<td width='10%' align='center' valign='top'>- </td>";
        ////strHtml1 += "<td width='10%' align='center' valign='top'> - </td>";

        //strHtml1 += "</tr>";
        //sb.Append(strHtml1);

        //int itoalActivity = Convert.ToInt32(dt.Rows.Count - 1);
        for (int i = 0; i < dt.Rows.Count; i++)
        {

            int iSrNo = i + 1;

            strdActivityDate = Convert.ToDateTime(dt.Rows[i]["DayDate"]).ToString("dd-MM-yyyy");
            NoofBox = Convert.ToString(dt.Rows[i]["DayTotalNoOfBoxes"]);
            strAmount = Convert.ToDecimal(dt.Rows[i]["DayCharges"]);
            string strHtml = "<tr>       <td width='5%' valign='top'>" + iSrNo + "</td>";
            strHtml += "<td width='10%' valign='top' align='right'> " + strdActivityDate + " </td>";
            strHtml += "<td width='10%' valign='top' align='right'> " + NoofBox + " </td>";
            strHtml += "<td valign='top' width='10%' align='right'  >" + strAmount.ToString("0.00") + " </td>";
            strHtml += "</tr>";
            sb.Append(strHtml);
        }
        sb.Append("</table>");
        return sb.ToString();
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        clear();
        lblMessage.Text = "";
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            //grdInvoice.DataSource = null;
            //grdInvoice.DataBind();
            grdInvoice.PageIndex = 0;
            BindCustomerdetails();
        }
    }
    public void BindCustomerdetails()
    {
        int intFrom_Month = 0;
        int intFrom_Year = 0;
        int intTo_Month = 0;
        int intTo_Year = 0;
        int intCust_ID = 0;
        int intGroup_ID = 0;
        //int intWH_ID = 0;

        if (ddlMonthView.SelectedItem.Value != "--Select--")
        { intFrom_Month = Convert.ToInt16(ddlMonthView.SelectedItem.Value); }

        if (ddlYearView.SelectedItem.Value != "--Select--")
        { intFrom_Year = Convert.ToInt16(ddlYearView.SelectedItem.Value); }

        if (ddlToMonthView.SelectedItem.Value != "--Select--")
        { intTo_Month = Convert.ToInt16(ddlToMonthView.SelectedItem.Value); }

        if (ddlToYearView.SelectedItem.Value != "--Select--")
        { intTo_Year = Convert.ToInt16(ddlToYearView.SelectedItem.Value); }

        if (ddlCustomer.SelectedItem.Value != "--Select--")
        { intCust_ID = Convert.ToInt32(ddlCustomer.SelectedItem.Value); }

        if (ddlCompanyGroup.SelectedItem.Value != "--Select--")
        { intGroup_ID = Convert.ToInt32(ddlCompanyGroup.SelectedItem.Value); }

        //if (ddlCompanyGroup.SelectedItem.Value != "--Select--")
        //{ intWH_ID = Convert.ToInt32(ddlWareHouse_ForGetInvoice.SelectedItem.Value); }

        DataSet dsInvoivceList = new DataSet();
        dsInvoivceList = objTRANSBAL.GetInvoiceList_New(intFrom_Month, intFrom_Year, intTo_Month, intTo_Year, intCust_ID, intGroup_ID);

        ViewState["dsInvoivce"] = dsInvoivceList;
        grdInvoice.DataSource = null;
        grdInvoice.DataBind();
        if (dsInvoivceList != null)
        {
            if (dsInvoivceList.Tables.Count > 0)
            {
                if (dsInvoivceList.Tables[0].Rows.Count > 0)
                {
                    grdInvoice.DataSource = dsInvoivceList.Tables[0];
                    grdInvoice.DataBind();

                    DataTable dt = new DataTable();
                    dt = dsInvoivceList.Tables[0];

                    Display_Message_forRowFound("Total number of invoices found are: " + dsInvoivceList.Tables[0].Rows.Count.ToString() + " " + "&  " + "Total Invoice Amount is: " + dt.Compute("Sum(TotalAmount)", "").ToString(), true);


                    //DataTable dt = new DataTable();
                    //dt = dsInvoivceList.Tables[0];

                    //Display_Message_forTotalAmount("Total Invoice Amount is: " + dt.Compute("Sum(TotalAmount)", "").ToString(), true);

                }
                else
                {
                    //ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('Invoice not found')", true);
                    Display_Message_forRowFound("No rows found", false);

                }
            }

        }
    }
    public void Display_Message_forRowFound(string Errormsg, bool Success)
    {
        lblSearchResult.Text = Errormsg;
        if (Success == false)
        {
            lblSearchResult.ForeColor = Color.Red;
        }
        else
        {
            lblSearchResult.ForeColor = Color.Green;
        }
    }
    //public void Display_Message_forTotalAmount(string Errormsg, bool Success)
    //{
    //    lblTotalAmt.Text = Errormsg;
    //    if (Success == false)
    //    {
    //        lblTotalAmt.ForeColor = Color.Red;
    //    }
    //    else
    //    {
    //        lblTotalAmt.ForeColor = Color.Green;
    //    }
    //}
    protected void grdInvoice_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        if (e.CommandName == "ViewInvoice")
        {
            LinkButton lb = (LinkButton)e.CommandSource;
            //Button btn = (Button)e.CommandSource;
            GridViewRow grd = (GridViewRow)lb.NamingContainer;
            n_RowNumber = grd.DataItemIndex;
            //int tempId = Convert.ToInt32(grdInvoice.DataKeys[grd.RowIndex].Values["AutoId"].ToString());
            n_Invoice = Convert.ToInt32(((System.Web.UI.WebControls.LinkButton)(grd.Cells[2].Controls[1])).Text);

            int intFrom_Month = 0;
            int intFrom_Year = 0;
            int intTo_Month = 0;
            int intTo_Year = 0;
            int intCust_ID = 0;
            int intGroup_ID = 0;
            int intWH_ID = 0;

            if (ddlMonthView.SelectedItem.Value != "--Select--")
            { intFrom_Month = Convert.ToInt16(ddlMonthView.SelectedItem.Value); }

            if (ddlYearView.SelectedItem.Value != "--Select--")
            { intFrom_Year = Convert.ToInt16(ddlYearView.SelectedItem.Value); }

            if (ddlToMonthView.SelectedItem.Value != "--Select--")
            { intTo_Month = Convert.ToInt16(ddlToMonthView.SelectedItem.Value); }

            if (ddlToYearView.SelectedItem.Value != "--Select--")
            { intTo_Year = Convert.ToInt16(ddlToYearView.SelectedItem.Value); }

            if (ddlCustomer.SelectedItem.Value != "--Select--")
            { intCust_ID = Convert.ToInt32(ddlCustomer.SelectedItem.Value); }

            if (ddlCompanyGroup.SelectedItem.Value != "--Select--")
            { intGroup_ID = Convert.ToInt32(ddlCompanyGroup.SelectedItem.Value); }

            if (ddlCompanyGroup.SelectedItem.Value != "--Select--")
            { intWH_ID = Convert.ToInt32(ddlWareHouse_ForGetInvoice.SelectedItem.Value); }

            DataSet dsInvoivce = new DataSet();
            dsInvoivce = objTRANSBAL.GetInvoice_New(intFrom_Month, intFrom_Year, intTo_Month, intTo_Year, intCust_ID, intGroup_ID, intWH_ID, n_Invoice);

            if (dsInvoivce != null && dsInvoivce.Tables.Count > 0)
            {
                ViewState["dsInvoivce"] = dsInvoivce;
                //GenrateInvoicePDF((DataSet)ViewState["dsInvoivce"]);

                DataSet dsPrintInvoice = new DataSet();
                dsPrintInvoice = objTRANSBAL.USP_DemoInvoice(Convert.ToInt32(dsInvoivce.Tables[0].Rows[0]["InvoiceNo"].ToString()));

                string Strhtml = dsPrintInvoice.Tables[0].Rows[0]["s_PrintString"].ToString();

                GenrateInvoicePDF_HTML(Strhtml);
            }
            else
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('Invoice not found, please check the customer and warehouse.')", true);
        }
    }
    protected void grdInvoice_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdInvoice.PageIndex = e.NewPageIndex;
        BindCustomerdetails();
    }
    protected void ddlWareHouse_SelectedIndexChanged(object sender, EventArgs e)
    {
        grdCustomer.DataSource = null;
        grdCustomer.DataBind();
        BindCustomer();
    }
    protected void ddlWareHouse_ForGetInvoice_SelectedIndexChanged(object sender, EventArgs e)
    {
        //ddlCompanyGroup.DataSource = null;
        //ddlCompanyGroup.DataBind();
        BindCompanyNameByWHID();
        //BindCompanyGroup(0);
    }
    protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField hf = (HiddenField)e.Row.Cells[5].FindControl("hfTotAmt");
            HiddenField hfbm = (HiddenField)e.Row.Cells[3].FindControl("hfBillingMode");
            if (hf.Value.ToString() == "" || hf.Value.ToString() == "0" || hf.Value.ToString() == null || hf.Value.ToString() == "&nbsp;")
            {
                e.Row.Cells[5].BackColor = System.Drawing.Color.LightPink;
            }
            else
            {
                e.Row.Cells[5].BackColor = System.Drawing.Color.LightGreen;
            }

            if (hfbm.Value.ToString() == "1")
            {
                e.Row.Cells[3].Enabled = false;
            }
        }
    }


}