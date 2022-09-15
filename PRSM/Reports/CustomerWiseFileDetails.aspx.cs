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
using System.Configuration;

public partial class Reports_ClientWiseInvetory : PageBase
{
    private System.Globalization.CultureInfo enGB = new System.Globalization.CultureInfo("en-GB");
    public static PRSMBAL.MasterBAL objPRSMBAL = new MasterBAL();
    public static PRSMBAL.TransactionBAL objTRANSBAL = new TransactionBAL();
    PageBase objPageBase = new PageBase();
    public static PRSMBAL.MasterBAL objstPRSMBAL = new MasterBAL();
    public static PRSMBAL.TransactionBAL objTRANSStBAL = new TransactionBAL();
    public PRSMBAL.ReportBAL objPRSMReportBAL = new ReportBAL();
    private GetPDFTables ObjPdfTAbles = new GetPDFTables();
    private Product product = new Product();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindmonthsView();
            Bindyearsview();
            BindCustomer();
            SetRolewiseAcessfuncationality();
        }
    }
    public void SetRolewiseAcessfuncationality()
    {
        UserRolewiseAcess objUserRoleWiseAcessDAL = new UserRolewiseAcess();
        DataTable dtPageId = objUserRoleWiseAcessDAL.GetApplicationCodeDetails("Page_Name", "Customer Wise File Details").Tables[0];
        int PageId = 0;
        if (dtPageId.Rows.Count > 0)
        {
            PageId = Convert.ToInt32(dtPageId.Rows[0][0]);
        }
        DataTable dtPagefuncationality = objUserRoleWiseAcessDAL.GetPageFunctionalityByRoleAndPageId(PageId, RoleId).Tables[0];
        btnView.Visible = false;
        btnExportToExcel.Visible = false;

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
                        case "View":
                            btnView.Visible = true;
                            break;
                        case "Export To Excel":
                            btnExportToExcel.Visible = false;
                            break;
                        default:
                            break;
                    }
                }
            }
        }

      
    }
    protected void BidGridView()
    {
        int iCustomerId = 0;
        Int16 iMonth = 0;
        int iYear = 0;
        ViewState["CustomerWiseFileDetails"] = null;
        DataTable dt = WorkOrderNoTable();
        DataSet dsNewSet = new DataSet();
        dsNewSet.Tables.Add(dt);
        String SelectedWONos = string.Empty;

        if (dsNewSet != null)
        {
            if (dsNewSet.Tables[0].Rows.Count > 0)
            {
                SelectedWONos = dsNewSet.GetXml();
            }
        }
        else
        {
            SelectedWONos = "";
        }

        if (ddlCustomer.SelectedIndex > 0)
        {
            iCustomerId = Convert.ToInt32(ddlCustomer.SelectedValue);
        }
        if (ddlMonth.SelectedIndex > 0)
        {
            iMonth = Convert.ToInt16(ddlMonth.SelectedValue);
        }
        if (ddlYear.SelectedIndex > 0)
        {
            iYear = Convert.ToInt32(ddlYear.SelectedValue);
        }

        Entity.ClientWiseFileDetailsReport ObjClientWiseFileDet =
            new Entity.ClientWiseFileDetailsReport()
            {
                CustomerId = iCustomerId,
                Month = iMonth,
                year = iYear,
                WorkOrderNo = SelectedWONos
            };

        DataSet ds = objPRSMReportBAL.GetClientWiseFileDetails(ObjClientWiseFileDet);
        if (ds != null)
        {

            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    btnExportToExcel.Visible = true;
                    ViewState["CustomerWiseFileDetails"] = ds.Tables[0];
                    gvClientWiseFileDetails.DataSource = ds.Tables[0];
                    gvClientWiseFileDetails.DataBind();
                }
                else
                {
                    btnExportToExcel.Visible = false;
                    lb1gvMessage.Visible = true;
                    lb1gvMessage.Text = "No Record Available";
                    gvClientWiseFileDetails.DataSource = null;
                    gvClientWiseFileDetails.DataBind();
                }
            }
        }

    }
    protected void btnView_Click(object sender, EventArgs e)
    {
        if (chklstWorkOrderNo.Items.Count > 0 )
        {
            gvClientWiseFileDetails.Visible = true;
            pnlReportType.Visible = true;
            BidGridView();
        }
        else
        {
            lb1Message.Visible = true;
            lb1gvMessage.Visible = true;
            lb1gvMessage.Text = "No Work Order Number Found";
            CustValWorkOrderNo.Visible = false;
            gvClientWiseFileDetails.Visible = false;
        }
    }
    protected void BindCustomer()
    {
        ddlCustomer.DataSource = null;
        ddlCustomer.DataBind();
        ddlCustomer.DataSource = objPRSMBAL.GetCustomer(0);
        ddlCustomer.DataValueField = "CustomerId";
        ddlCustomer.DataTextField = "CustomerName";
        ddlCustomer.DataBind();
        ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });

    }
    protected void Bindyearsview()
    {
        List<Years> lstYears = new List<Years>();
        for (int i = DateTime.Now.Year - 3; i <= DateTime.Now.Year; i++)
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
    protected void BindmonthsView()
    {
        DateTimeFormatInfo info = DateTimeFormatInfo.GetInstance(null);
        List<Months> lstMonth = new List<Months>();
        for (int i = 1; i < 13; i++)
        {
            lstMonth.Add(new Months() { MonthId = i, MonthName = info.GetMonthName(i) });
        }
        ddlMonth.DataSource = null;
        ddlMonth.DataBind();
        ddlMonth.DataSource = lstMonth.ToList().OrderBy(m => m.MonthId);
        ddlMonth.DataValueField = "MonthId";
        ddlMonth.DataTextField = "MonthName";
        ddlMonth.DataBind();
        ddlMonth.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }

    protected void gvClientWiseFileDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvClientWiseFileDetails.PageIndex = e.NewPageIndex;
        BidGridView();
    }

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

    protected void ddlCustomer_SelectedIndexChanged(object sender, EventArgs e)
    {
        pnlWoNo.Visible = false;
        DateTime? FromDate;
        DateTime? EndDate;
        int iMonth = 0;
        int iYear = 0;
        chkboxSelectAll.Checked = false;
        lb1gvMessage.Visible = false;
        chklstWorkOrderNo.Items.Clear();
        ddlMonth.SelectedIndex = 0;
        ddlYear.SelectedIndex = 0;
        if (ddlCustomer.SelectedIndex == 0)
        {
          
            chklstWorkOrderNo.Items.Clear();
            chklstWorkOrderNo.DataSource = null;
            chklstWorkOrderNo.DataBind();
            chkboxSelectAll.Visible = false;
            gvClientWiseFileDetails.Visible = false;
            btnExportToExcel.Visible = false;
            lb1WONo.Visible = false;
            CustValWorkOrderNo.Visible = false;
            
        }

        if (ddlMonth.SelectedIndex == 0)
        {
            int CurrMonth = Convert.ToInt32(System.DateTime.Now.Month);
            iMonth = CurrMonth;
            FromDate = null;

        }
        else
        {
            iMonth = Convert.ToInt32(ddlMonth.SelectedValue.ToString());
        }

        if (ddlYear.SelectedIndex == 0)
        {
            int CurrYear = Convert.ToInt32(System.DateTime.Now.Year);
            iYear = CurrYear;
            EndDate = null;
        }
        else
        {
            iYear = Convert.ToInt32(ddlYear.SelectedValue.ToString());
        }

        if (ddlCustomer.SelectedIndex > 0 && ddlYear.SelectedIndex > 0 && ddlMonth.SelectedIndex > 0)
        {

            iMonth = Convert.ToInt32(iMonth);
            DateTime StartDay = new DateTime(iYear, iMonth, 1);
            int iMonthStartDay = StartDay.Day;
            if (Convert.ToInt32(ddlMonth.SelectedValue) <= 9)
            {
                string strFromDate = "0" + iMonthStartDay.ToString() + "-" + "0" + iMonth + "-" + iYear;
                FromDate = Convert.ToDateTime(strFromDate.Trim(), enGB);
                DateTime EndDay = StartDay.AddMonths(1).AddDays(-1);
                int iMonthEndDay = EndDay.Day;
                string strEndDate = iMonthEndDay.ToString() + "-" + "0" + iMonth + "-" + iYear;
                EndDate = Convert.ToDateTime(strEndDate.Trim(), enGB);
            }
            else
            {

                string strFromDate = "0" + iMonthStartDay.ToString() + "-" + iMonth + "-" + iYear;
                FromDate = Convert.ToDateTime(strFromDate.Trim(), enGB);
                DateTime EndDay = StartDay.AddMonths(1).AddDays(-1);
                int iMonthEndDay = EndDay.Day;
                string strEndDate = iMonthEndDay.ToString() + "-" + iMonth + "-" + iYear;
                EndDate = Convert.ToDateTime(strEndDate.Trim(), enGB);

            }
            Int16 iStatus = GetWorkStatus("Closed");
            DataSet dsGetWorkOrder = objTRANSBAL.GetWorkOrder(0, 0, Convert.ToInt32(ddlCustomer.SelectedValue), 0, iStatus, FromDate, EndDate);
            if (dsGetWorkOrder.Tables.Count > 0)
            {
                if (dsGetWorkOrder.Tables[0].Rows.Count > 0)
                {
                    pnlWoNo.Visible = true;
                    lb1Message.Visible = false;
                    CustValWorkOrderNo.Visible = true;
                    chkboxSelectAll.Visible = true;
                    chklstWorkOrderNo.DataSource = dsGetWorkOrder.Tables[0];
                    chklstWorkOrderNo.DataValueField = "WorkorderNo";
                    chklstWorkOrderNo.DataTextField = "WorkorderNo";
                    chklstWorkOrderNo.DataBind();
                }
                else
                {
                    pnlWoNo.Visible = false;
                    chkboxSelectAll.Checked = false;
                    chkboxSelectAll.Visible = false;
                    CustValWorkOrderNo.Visible = false;
                    chklstWorkOrderNo.Items.Clear();
                    chklstWorkOrderNo.DataSource = null;
                    chklstWorkOrderNo.DataBind();
                    gvClientWiseFileDetails.Visible = false;
                    btnExportToExcel.Visible = false;
                    lb1WONo.Visible = false;

                }
            }
        }
        else
        {
            chkboxSelectAll.Visible = false;
        }

        
    }

    protected void ddlMonth_SelectedIndexChanged(object sender, EventArgs e)
    {
        DateTime? FromDate;
        DateTime? EndDate;
        int iMonth = 0;
        int iYear = 0;
        chkboxSelectAll.Checked = false;
        lb1gvMessage.Visible = false;
        if (ddlMonth.SelectedIndex == 0)
        {
            chklstWorkOrderNo.Items.Clear();
            chklstWorkOrderNo.DataSource = null;
            chklstWorkOrderNo.DataBind();
            chkboxSelectAll.Visible = false;
            btnExportToExcel.Visible = false;
            lb1WONo.Visible = false;
            gvClientWiseFileDetails.Visible = false;
            CustValWorkOrderNo.Visible = false;
        }

        if (ddlYear.SelectedIndex> 0)
        {
            iYear = Convert.ToInt32(ddlYear.SelectedValue.ToString());
        }
      

        if (ddlMonth.SelectedIndex > 0 && ddlYear.SelectedIndex>0 && ddlCustomer.SelectedIndex>0)
        {
            iMonth = Convert.ToInt32(ddlMonth.SelectedValue.ToString());
            DateTime StartDay = new DateTime(iYear, iMonth, 1);
            int iMonthStartDay = StartDay.Day;
            if (Convert.ToInt32(ddlMonth.SelectedValue) <= 9)
            {
                string strFromDate = "0" + iMonthStartDay.ToString() + "-" + "0" + iMonth + "-" + iYear;
                FromDate = Convert.ToDateTime(strFromDate.Trim(), enGB);
                DateTime EndDay = StartDay.AddMonths(1).AddDays(-1);
                int iMonthEndDay = EndDay.Day;
                string strEndDate = iMonthEndDay.ToString() + "-" + "0" + iMonth + "-" + iYear;
                EndDate = Convert.ToDateTime(strEndDate.Trim(), enGB);
            }
            else
            {

                string strFromDate = "0" + iMonthStartDay.ToString() + "-" + iMonth + "-" + iYear;
                FromDate = Convert.ToDateTime(strFromDate.Trim(), enGB);
                DateTime EndDay = StartDay.AddMonths(1).AddDays(-1);
                int iMonthEndDay = EndDay.Day;
                string strEndDate = iMonthEndDay.ToString() + "-" + iMonth + "-" + iYear;
                EndDate = Convert.ToDateTime(strEndDate.Trim(), enGB);

            }
            Int16 iStatus = GetWorkStatus("Closed");
            DataSet dsGetWorkOrder = objTRANSBAL.GetWorkOrder(0, 0, Convert.ToInt32(ddlCustomer.SelectedValue), 0, iStatus, FromDate, EndDate);
            if (dsGetWorkOrder.Tables.Count > 0)
            {
                if (dsGetWorkOrder.Tables[0].Rows.Count > 0)
                {
                    pnlWoNo.Visible = true;
                    chkboxSelectAll.Visible = true;
                    lb1Message.Visible = false;
                    CustValWorkOrderNo.Visible = true;
                    lb1WONo.Visible = true;
                    chklstWorkOrderNo.DataSource = dsGetWorkOrder.Tables[0];
                    chklstWorkOrderNo.DataValueField = "WorkorderNo";
                    chklstWorkOrderNo.DataTextField = "WorkorderNo";
                    chklstWorkOrderNo.DataBind();
                }
                else
                {
                    pnlWoNo.Visible = false;
                    chkboxSelectAll.Checked = false;
                    chkboxSelectAll.Visible = false;
                    CustValWorkOrderNo.Visible = false;
                    chklstWorkOrderNo.Items.Clear();
                    chklstWorkOrderNo.DataSource = null;
                    chklstWorkOrderNo.DataBind();
                    gvClientWiseFileDetails.Visible = false;
                    btnExportToExcel.Visible = false;
                    lb1WONo.Visible = false;
                   
                }
            }

        }
      
    }
    
    protected void ddlYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        DateTime? FromDate;
        DateTime? EndDate;
        int iMonth = 0;
        int iYear = 0;
        chkboxSelectAll.Checked = false;
        lb1gvMessage.Visible = false;
        ddlMonth.SelectedIndex = 0;

        if (ddlYear.SelectedIndex == 0)
        {
            chklstWorkOrderNo.Items.Clear();
            chklstWorkOrderNo.DataSource = null;
            chklstWorkOrderNo.DataBind();
            chkboxSelectAll.Visible = false;
            gvClientWiseFileDetails.Visible = false;
            btnExportToExcel.Visible = false;
            lb1WONo.Visible = false;
            CustValWorkOrderNo.Visible = false;
        }

        if (ddlMonth.SelectedIndex >0 )
        {
            iMonth = Convert.ToInt32(ddlMonth.SelectedValue.ToString());
           
        }

        if (ddlYear.SelectedIndex > 0 && ddlMonth.SelectedIndex>0 && ddlCustomer.SelectedIndex>0)
        {
            iYear = Convert.ToInt32(ddlYear.SelectedValue.ToString());
            DateTime StartDay = new DateTime(iYear, iMonth, 1);
            int iMonthStartDay = StartDay.Day;
            if (Convert.ToInt32(ddlMonth.SelectedValue) <= 9)
            {
                string strFromDate = "0" + iMonthStartDay.ToString() + "-" + "0" + iMonth + "-" + iYear;
                FromDate = Convert.ToDateTime(strFromDate.Trim(), enGB);
                DateTime EndDay = StartDay.AddMonths(1).AddDays(-1);
                int iMonthEndDay = EndDay.Day;
                string strEndDate = iMonthEndDay.ToString() + "-" + "0" + iMonth + "-" + iYear;
                EndDate = Convert.ToDateTime(strEndDate.Trim(), enGB);
            }
            else
            {

                string strFromDate = "0" + iMonthStartDay.ToString() + "-" + iMonth + "-" + iYear;
                FromDate = Convert.ToDateTime(strFromDate.Trim(), enGB);
                DateTime EndDay = StartDay.AddMonths(1).AddDays(-1);
                int iMonthEndDay = EndDay.Day;
                string strEndDate = iMonthEndDay.ToString() + "-" + iMonth + "-" + iYear;
                EndDate = Convert.ToDateTime(strEndDate.Trim(), enGB);

            }
            Int16 iStatus = GetWorkStatus("Closed");
            DataSet dsGetWorkOrder = objTRANSBAL.GetWorkOrder(0, 0, Convert.ToInt32(ddlCustomer.SelectedValue), 0, iStatus, FromDate, EndDate);
            if (dsGetWorkOrder.Tables.Count > 0)
            {
                if (dsGetWorkOrder.Tables[0].Rows.Count > 0)
                {
                    pnlWoNo.Visible = true;
                    chkboxSelectAll.Visible = true;
                    lb1Message.Visible = false;
                    CustValWorkOrderNo.Visible = true;
                    lb1WONo.Visible = true;
                    chklstWorkOrderNo.DataSource = dsGetWorkOrder.Tables[0];
                    chklstWorkOrderNo.DataValueField = "WorkorderNo";
                    chklstWorkOrderNo.DataTextField = "WorkorderNo";
                    chklstWorkOrderNo.DataBind();
                }
                else
                {
                    pnlWoNo.Visible = false;
                    CustValWorkOrderNo.Visible = false;
                    chkboxSelectAll.Checked = false;
                    chkboxSelectAll.Visible = false;
                    lb1WONo.Visible = false;
                    chklstWorkOrderNo.Items.Clear();
                    chklstWorkOrderNo.DataSource = null;
                    chklstWorkOrderNo.DataBind();
                    gvClientWiseFileDetails.Visible = false;
                    btnExportToExcel.Visible = false;
                    lb1WONo.Visible = false;

                }
            }
        }
    }

    protected void btnExportToExcel_Click(object sender, EventArgs e)
    {
        try
        {
            if (ViewState["CustomerWiseFileDetails"] != null)
            {
                HttpContext.Current.Session["CustomerWiseFileDetails"] = ViewState["CustomerWiseFileDetails"];
                if (rdbtnlstCustomerWise.SelectedItem.Text == "PDF")
                {
                    GeneratePDF();
                }
                if (rdbtnlstCustomerWise.SelectedItem.Text == "Excel")
                {
                    DataTable dtFileDet = (DataTable)ViewState["CustomerWiseFileDetails"];
                    if (dtFileDet.Rows.Count > 0)
                    {
                        ExporttoExcel(dtFileDet);
                    }
                }
              
            }
        }
        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }

    }

    private void ExporttoExcel(DataTable dtCustFileDet)
    {
        try
        {
            System.IO.StringWriter objStringWriter = new System.IO.StringWriter();
            System.Web.UI.WebControls.DataGrid tempDataGrid = new System.Web.UI.WebControls.DataGrid();
            System.Web.UI.HtmlTextWriter objHtmlTextWriter = new System.Web.UI.HtmlTextWriter(objStringWriter);
            HttpContext.Current.Response.ClearContent();
            HttpContext.Current.Response.ClearHeaders();
            HttpContext.Current.Response.ContentType = "application/vnd.ms-excel";
            HttpContext.Current.Response.Charset = "";
            HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment;filename=CustomerWiseFileDetails.xls");
            if (dtCustFileDet.Rows.Count > 0)
            {
                tempDataGrid.DataSource = dtCustFileDet;
            }
            else
            {
                tempDataGrid.DataSource = null;
            }

            tempDataGrid.DataBind();
            tempDataGrid.HeaderStyle.Font.Bold = true;
            tempDataGrid.RenderControl(objHtmlTextWriter);
            HttpContext.Current.Response.Write(objStringWriter.ToString());
            HttpContext.Current.Response.End();
        }

        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }
    }
  
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }
    protected DataTable WorkOrderNoTable()
    { 
     
           DataTable dtWONoTable = new DataTable();
            DataRow dr;
            dtWONoTable.TableName = "Root";
            dtWONoTable.Columns.Add("WorkOrderNo", typeof(int));
         
            for(int i=0;i<chklstWorkOrderNo.Items.Count;i++)
            {
               if (chklstWorkOrderNo.Items[i].Selected)
               {
                  dr = dtWONoTable.NewRow();
                  dr["WorkOrderNo"] =chklstWorkOrderNo.Items[i].Value ;
                  dtWONoTable.Rows.Add(dr);
                  dtWONoTable.AcceptChanges();
               }
            }

            return dtWONoTable;
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        pnlWoNo.Visible = false;
        pnlReportType.Visible = false;
        ddlCustomer.SelectedIndex = 0;
        ddlMonth.SelectedIndex = 0;
        ddlYear.SelectedIndex = 0;
        chkboxSelectAll.Checked = false;
        chklstWorkOrderNo.Items.Clear();
        if (gvClientWiseFileDetails.Rows.Count > 0)
        {
            gvClientWiseFileDetails.DataSource = null;
            gvClientWiseFileDetails.DataBind();
        }
        else
        {
            gvClientWiseFileDetails.DataSource = null;
        }
        lb1gvMessage.Visible = false;
        chkboxSelectAll.Visible = false;
        btnExportToExcel.Visible = false;
        lb1WONo.Visible = false;
        lb1Message.Visible = false;

    }

    protected void GeneratePDF()
    {
        if (ddlYear.SelectedIndex > 0 && ddlMonth.SelectedIndex > 0 && ddlCustomer.SelectedIndex > 0)
        {
         
            Director director = new Director();
            ConcreteBuilder b1 = new ConcreteBuilder();
            b1.CustomerId = Convert.ToInt32(ddlCustomer.SelectedValue);
            try
            {
                director.Construct(b1);
                Product p1 = b1.GetResult();
                p1.Show();
            }
            catch (Exception ex)
            {
                ErrorHandler.WriteLog(ex); ;
            }
        }
    }

    class Director
    {
        // Builder uses a complex series of steps 
        public void Construct(IBuilder builder)
        {
            builder.BuildCustomerWise();
        }
    }

    public interface IBuilder
    {
        void BuildCustomerWise();
        Product GetResult();
    }
    public class Product : System.Web.UI.Page
    {
        iTextSharp.text.Document _document;
        MemoryStream _output;
        iTextSharp.text.pdf.PdfWriter _writer;
        public Int16 WareHouseId { get; set; }
        public int CompanyGroupId { get; set; }
        public int CustomerId { get; set; }
        public int IWoNo { get; set; }
        public DateTime Fromdate { get; set; }
        public DateTime ToDate { get; set; }

        public void Initlize()
        {
            _document = new iTextSharp.text.Document(iTextSharp.text.PageSize.A4, 30, 30, 10, 10);
            _output = new MemoryStream();
            _writer = iTextSharp.text.pdf.PdfWriter.GetInstance(_document, _output);
            _writer.PageEvent = new WorkOrderFooter();
            _document.Open();
            _document.NewPage();
        }
        public void Add(iTextSharp.text.IElement htmlElementpage, List<iTextSharp.text.IElement> htmlelementHeader, byte Isnew)
        {
            if (Isnew == 1)
            {
                _document.NewPage();
            }

            for (int i = 0; i < htmlelementHeader.Count; i++)
            {
                _document.Add(htmlelementHeader[i]);
                if (i == 0 || i == 2)
                {
                    iTextSharp.text.pdf.PdfPTable tableBorder = new iTextSharp.text.pdf.PdfPTable(5);
                    float[] widthstableBorder = new float[] { 300f, 133f, 301f, 133f, 133f };
                    tableBorder.SetWidths(widthstableBorder);
                    tableBorder.WidthPercentage = 100;
                    iTextSharp.text.pdf.PdfPCell cell = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" "));
                    cell.Colspan = 5;
                    cell.BorderWidthLeft = 0f;
                    cell.BorderWidthRight = 0f;
                    cell.BorderWidthTop = 0f;
                    cell.BorderWidth = 0f;
                    cell.BorderWidthBottom = 0.1f;
                    tableBorder.AddCell(cell);
                    _document.Add(tableBorder);
                }
            }
            _document.Add(htmlElementpage);
        }

        public void Show()
        {
            _document.Close();
            HttpContext.Current.Response.ContentType = "application/pdf";
            HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment;filename=CustomerWise{0}.pdf", 0000));
            HttpContext.Current.Response.BinaryWrite(_output.ToArray());
        }
    }



    public class ConcreteBuilder : System.Web.UI.Page, IBuilder
    {
        /*======================Constants================================= */
        const string _LOGOIMAGE = "@imagepath@";
        const string _LOGOIMAGE1 = "@imagepath1@";
        const string _ServiceCateg = "@ServiceCateg@";
        const string _RequestedActivity = "@TableRequestedActivity@";
        const string _WoStatus = "@WoStatus@";
        const string FullFilePath = "~/Reports/CustomerWise.htm";
        //const string LogoImagePath = "~/images/prsm-logo.png";
        //const string LogoImagePath1 = "~/images/panoramic-group-logo1.png";

        const string LogoImagePath = "~/images/apaar-logo.png";
        const string LogoImagePath1 = "~/images/apaar-logo.png";


        public PRSMBAL.TransactionBAL objTRANSBAL = new TransactionBAL();
        public static PRSMBAL.ReportBAL objPRSMReportBAL = new ReportBAL();
        //======================================================================

        private Product product = new Product();
        public PRSMBAL.MasterBAL objPRSMBAL = new MasterBAL();
        private GetPDFTables ObjPdfTAbles = new GetPDFTables();
        public byte IsNew { get; set; }
        public Int16 WareHouseId { get; set; }
        public int CompanyGroupId { get; set; }
        public int CustomerId { get; set; }
        public int IWoNo { get; set; }
        public DateTime Fromdate { get; set; }
        public DateTime ToDate { get; set; }

        DataTable GetCustomerWise( int ICustId)
        {
            DataTable dtCustWise = new DataTable();
            if (HttpContext.Current.Session["CustomerWiseFileDetails"] != null)
            {
                dtCustWise  =(DataTable) HttpContext.Current.Session["CustomerWiseFileDetails"];
               // dtCustWise = ds.Tables[0];
            }
            
            return dtCustWise;
        }

        public void BuildCustomerWise()
        {
             product.Initlize();
             iTextSharp.text.pdf.PdfPTable TableCustomerWise = null;
             TableCustomerWise = ObjPdfTAbles.GetCustomerWiseReportSummary(GetCustomerWise(CustomerId));
             product.Add(TableCustomerWise, GetWoHeader(), 0);
             IsNew = 1;
        }

        public Product GetResult()
        {
            return product;
        }

        public List<iTextSharp.text.IElement> GetWoHeader()
        {
            string strTableList = string.Empty;

            string contents = File.ReadAllText(Server.MapPath(FullFilePath));
            contents = contents.Replace(_LOGOIMAGE, Server.MapPath(LogoImagePath));
            contents = contents.Replace(_LOGOIMAGE1, Server.MapPath(LogoImagePath1));
            List<iTextSharp.text.IElement> _lst = new List<iTextSharp.text.IElement>();
            var parsedHtmlElements = iTextSharp.text.html.simpleparser.HTMLWorker.ParseToList(new StringReader(contents), null);
            foreach (var htmlElement in parsedHtmlElements)
            {
                _lst.Add(htmlElement as iTextSharp.text.IElement);
            }
            return _lst;
        }
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

}