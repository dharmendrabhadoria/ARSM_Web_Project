using System;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utility;
using System.Data;
using Entity;
using UserRoleWiseAcess;
using System.Web.SessionState;
using System.Globalization;
using System.IO;
using PRSMBAL;
public partial class Reports_ServiceCompletionReport :PageBase
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
    public static int IsExist { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindDdlWareHouse();
            BindCompanyGroup(0);
            BindServiceComplSummary();
            ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
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

    private void BindDdlWareHouse()
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
        }
        else
        {
            ddlCustomer.Items.Clear();
            ddlCustomer.DataSource = null;
            ddlCustomer.DataBind();
            ddlCustomer.Items.Insert(0,new ListItem { Text = "--Select--", Value = "0" });
        }
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

    protected void bindWorkOrder(int icompgroupId, int icustomerid, int iwarehouseid, int istatus)
    {
        PRSMBAL.TransactionBAL objPRSMTransBAL = new TransactionBAL(); 
        DataSet dsWorkOrder = objPRSMTransBAL.GetWorkOrder(0, icompgroupId, icustomerid, iwarehouseid, 46, null, null);
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

    protected void ddlCustomer_SelectedIndexChanged(object sender, EventArgs e)
    {
        int iCompgroupId, icustomerid, iwarehouseid, istatus;
        icustomerid = 0;
        iwarehouseid = 0;
        istatus = 45; // open work order
   
        if (ddlCustomer.SelectedIndex > 0)
        {
            iCompgroupId = Convert.ToInt32(ddlCompanyGroup.SelectedItem.Value);
            icustomerid = Convert.ToInt32(ddlCustomer.SelectedItem.Value);
      
            if (ddlWareHouse.SelectedIndex > 0)
            {
                iwarehouseid = Convert.ToInt32(ddlWareHouse.SelectedItem.Value);
            }
            bindWorkOrder(iCompgroupId, icustomerid, iwarehouseid, istatus);
        }
        else
        {
            ddlWorkOrder.Items.Clear();
            ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
    }
    protected void BindServiceComplSummary()
    {
        //ViewState["RequestedServiceWoNoWise"] = null;
        //ViewState["RequestedServiceDateWise"]=null;
        lnkbtnservicedetails.Style["color"] = "#4f4f4f !important;";
        lnkbtnsummary.Style["color"] = "blue !important;";
        divServiceComplDetails.Style["display"] = "none";
        divServiceComplSummary.Style["display"] = "block";
        ddlWorkOrder.Enabled = false;
        DateTime? dFromDate;
        DateTime? dToDate;
        if (txtfromDate.Text == "")
            dFromDate = null;
        else
            dFromDate = Convert.ToDateTime(txtfromDate.Text.ToString(), enGB);
        if (txttodate.Text == "")
            dToDate = null;
        else
            dToDate = Convert.ToDateTime(txttodate.Text.ToString(), enGB);
        GridServiceSummarry.DataSource = null;
        GridServiceSummarry.DataBind();
        DataSet dsGetReport = objPRSMReportBAL.GetServiceCompletionSummary(Convert.ToInt16(ddlWareHouse.SelectedValue), Convert.ToInt32(ddlCompanyGroup.SelectedValue), Convert.ToInt32(ddlCustomer.SelectedValue), dFromDate, dToDate);
        if (dsGetReport.Tables[0].Rows.Count > 0)
        {
            pnlExportype.Visible = true;
            btnExportToExcel.Visible = true;
            GridServiceSummarry.DataSource = dsGetReport.Tables[0];
            GridServiceSummarry.DataBind();
            IsExist = 3;
            ViewState["RequestedSummary"] = dsGetReport.Tables[0];
        }
        else
        {
            pnlExportype.Visible = false;
            btnExportToExcel.Visible = false;
            GridServiceSummarry.DataSource = null;
            GridServiceSummarry.DataBind();
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('No Record Found.')", true);
        }
    }


    protected void BindServiceComplDetailsWorkOrderDateWise()
    {
        //ViewState["RequestedServiceWoNoWise"]=null;
        //ViewState["RequestedSummary"] = null;
        divServiceComplDetails.Style["display"] = "block";
        divServiceComplSummary.Style["display"] = "none";
        DateTime? dFromDate;
        DateTime? dToDate;
        int workordervalue = 0;
        if (txtfromDate.Text == "")
            dFromDate = null;
        else
            dFromDate = Convert.ToDateTime(txtfromDate.Text.ToString(), enGB);
        if (txttodate.Text == "")
            dToDate = null;
        else
            dToDate = Convert.ToDateTime(txttodate.Text.ToString(), enGB);

        if (ddlWorkOrder.SelectedValue.ToString() == "")
            workordervalue = 0;
        else
            workordervalue = Convert.ToInt32(ddlWorkOrder.SelectedValue);
        DataSet dsGetReport = objPRSMReportBAL.GetSrvcCompletionReport(Convert.ToInt16(ddlWareHouse.SelectedValue), Convert.ToInt32(ddlCompanyGroup.SelectedValue), Convert.ToInt32(ddlCustomer.SelectedValue), workordervalue, dFromDate, dToDate);
        if (dsGetReport != null)
        {
            gdvSearchWorkOrder.DataSource = null;
            gdvSearchWorkOrder.DataBind();
            if (dsGetReport.Tables[1].Rows.Count > 0)
            {
                pnlExportype.Visible = true;
                btnExportToExcel.Visible = true;
                HttpContext.Current.Cache["ServiceCompletionWorkOrderDateWise"] = dsGetReport.Tables[1];
                gdvSearchWorkOrder.DataSource = dsGetReport.Tables[1];
                gdvSearchWorkOrder.DataBind();
                IsExist = 2;
                ViewState["RequestedServiceDateWise"] = dsGetReport.Tables[1];
            }
          else
             {
                 pnlExportype.Visible = false;
                 btnExportToExcel.Visible = false;
                gdvSearchWorkOrder.DataSource = null;
                gdvSearchWorkOrder.DataBind();
               ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('No Record Found.')", true);
            }
        }
    }
    protected void BindServiceComplDetailsWorkOrderNoWise()
    {
        // ViewState["RequestedSummary"]=null;
        ViewState["RequestedServiceDateWise"] = null;
        lnkbtnsummary.Style["color"] = "#4f4f4f !important;";
        lnkbtnservicedetails.Style["color"] = "blue !important;";
        divServiceComplDetails.Style["display"] = "block";
        divServiceComplSummary.Style["display"] = "none";
        DateTime? dFromDate;
        DateTime? dToDate;
        int workordervalue = 0;
        if (txtfromDate.Text == "")
            dFromDate = null;
        else
            dFromDate = Convert.ToDateTime(txtfromDate.Text.ToString(), enGB);
        if (txttodate.Text == "")
            dToDate = null;
        else
            dToDate = Convert.ToDateTime(txttodate.Text.ToString(), enGB);
        gdvSearchWorkOrder.DataSource = null;
        gdvSearchWorkOrder.DataBind();
        if (ddlWorkOrder.SelectedValue.ToString() == "")
            workordervalue = 0;
        else
            workordervalue = Convert.ToInt32(ddlWorkOrder.SelectedValue);
        DataSet dsGetReport = objPRSMReportBAL.GetSrvcCompletionReport(Convert.ToInt16(ddlWareHouse.SelectedValue), Convert.ToInt32(ddlCompanyGroup.SelectedValue), Convert.ToInt32(ddlCustomer.SelectedValue), workordervalue, dFromDate, dToDate);
        if (dsGetReport != null)
        {
            if (dsGetReport.Tables[0].Rows.Count > 0)
            {
                pnlExportype.Visible = true;
                btnExportToExcel.Visible = true;
                gdvSearchWorkOrder.DataSource = dsGetReport.Tables[0];
                gdvSearchWorkOrder.DataBind();
                IsExist = 1;
                ViewState["RequestedServiceWoNoWise"] = dsGetReport.Tables[0];
                HttpContext.Current.Cache["ServiceCompletionWorkOrderNumberWise"] = dsGetReport.Tables[0];
                //HttpContext.Current.Cache["FilePickUpdetailsWorkOrderNumberWiseSum"] = ds.Tables[1];
            }
            else
            {
                pnlExportype.Visible = false;
                btnExportToExcel.Visible = false;
                gdvSearchWorkOrder.DataSource = null;
                gdvSearchWorkOrder.DataBind();
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('No Record Found.')", true);
            }
        }
    }

    protected void btnview_Click(object sender, EventArgs e)
    {
        try
        {
           
                if (divServiceComplSummary.Style["display"] == "block")
                {
                    BindServiceComplSummary();
                }
                else
                {
                    if (rdbtnFilePickDetails.SelectedItem.Text == "Work Order Number Wise")
                    {
                        BindServiceComplDetailsWorkOrderNoWise();
                    }
                    else if (rdbtnFilePickDetails.SelectedItem.Text == "Work Order Date Wise")
                    {
                        BindServiceComplDetailsWorkOrderDateWise();
                    }
                }
        }
        catch (Exception ex)
        {

            ErrorHandler.WriteLog(ex);
        }
    }

    protected void btnViewClear_Click(object sender, EventArgs e)
    {
        pnlExportype.Visible = false;
        btnExportToExcel.Visible = false;
        ddlWareHouse.SelectedIndex = 0;
        ddlCompanyGroup.SelectedIndex = 0;
        ddlCustomer.Items.Clear();
        ddlCustomer.Items.Insert(0, new ListItem("-Select-", "0"));
        ddlWorkOrder.Items.Clear();
        ddlWorkOrder.Items.Insert(0, new ListItem("-Select-","0"));
       rdbtnFilePickDetails.Visible = false;
       gdvSearchWorkOrder.DataSource = null;
       gdvSearchWorkOrder.DataBind();
       GridServiceSummarry.DataSource = null;
       GridServiceSummarry.DataBind();
       divServiceComplDetails.Style["display"] = "none";
       divServiceComplSummary.Style["display"] = "block";
       lnkbtnservicedetails.Style["color"] = "#4f4f4f !important;";
       lnkbtnsummary.Style["color"] = "blue !important;";
       txtfromDate.Text = "";
       txttodate.Text = "";
       ddlWorkOrder.Enabled = false;
       btnExportToExcel.Visible = false;
    }

    protected void lnkbtnsummary_Click(object sender, EventArgs e)
    {
        btnExportToExcel.Visible = false;
        //ViewState["RequestedServiceWoNoWise"]=null;
        //ViewState["RequestedServiceDateWise"]=null;
        lnkbtnservicedetails.Style["color"] = "#4f4f4f !important;";
        lnkbtnsummary.Style["color"] = "blue !important;";
        rdbtnFilePickDetails.Visible = false;
        lblMessage.Text = "";
        ddlWareHouse.SelectedIndex = 0;
        ddlWareHouse.SelectedIndex = 0;
        ddlCompanyGroup.SelectedIndex = 0;
        ddlCustomer.Items.Clear();
        ddlCustomer.Items.Insert(0, new ListItem("-Select-", "0"));
        ddlWorkOrder.Enabled = false;
        ddlWorkOrder.Items.Clear();
        ddlWorkOrder.Items.Insert(0, new ListItem("-Select-", "0"));
        divServiceComplDetails.Style["display"] = "none";
        divServiceComplSummary.Style["display"] = "block";
        txtfromDate.Text = "";
        txttodate.Text = "";
        gdvSearchWorkOrder.DataSource = null;
        gdvSearchWorkOrder.DataBind();
        GridServiceSummarry.DataSource = null;
        GridServiceSummarry.DataBind();
        pnlExportype.Visible = false;
        try
        {
           BindServiceComplSummary();
        }
        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }
        ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "changesearch('ContentPlaceHolder1_ddlSearchRequestby');", true);
        //  SetRolewiseAcessfuncationality();
        lblMessage.Visible = false;
    }

    protected void lnkbtnservicedetails_Click(object sender, EventArgs e)
    {
        ViewState["RequestedSummary"] = null; 
        btnExportToExcel.Visible = false;
       // ViewState["RequestedSummary"] = null;
        lnkbtnsummary.Style["color"] = "#4f4f4f !important;";
        lnkbtnservicedetails.Style["color"] = "blue !important;";
        rdbtnFilePickDetails.Visible = true;
        ddlWareHouse.SelectedIndex = 0;
        ddlCompanyGroup.SelectedIndex = 0;
        ddlCustomer.Items.Clear();
        ddlCustomer.Items.Insert(0, new ListItem("-Select-", "0"));
        ddlWorkOrder.Enabled = true;
        ddlWorkOrder.Items.Clear();
        ddlWorkOrder.Items.Insert(0, new ListItem("-Select-", "0"));
        divServiceComplSummary.Style["display"] = "none";
        divServiceComplDetails.Style["display"] = "none";
        //divGenerateBtn.Style["display"] = "none";
        txtfromDate.Text = "";
        txttodate.Text = "";
        pnlExportype.Visible = false;

        try
        {
        }
        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }
        ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "changesearch('ContentPlaceHolder1_ddlSearchRequestby');", true);
    }

    protected void btnExportToExcel_Click(object sender, EventArgs e)
    {
        try
        {
                DataTable dtsummaryClientwise = new DataTable();
                if (ViewState["RequestedSummary"] != null)
                {
                    IsExist = 3;
                    if (rdbtnlstReportType.SelectedItem.Text == "PDF")
                    {
                        GeneratePDF();
                    }
                    if (rdbtnlstReportType.SelectedItem.Text == "Excel")
                    {
                        dtsummaryClientwise = (DataTable)ViewState["RequestedSummary"];
                        ExportExcel(GridServiceSummarry, dtsummaryClientwise, "ServiceCompletionSummary");
                    }
                  
                }
            
                if (ViewState["RequestedServiceWoNoWise"] != null)
                {
                    if (rdbtnFilePickDetails.SelectedItem.Text == "Work Order Number Wise")
                    {
                               IsExist = 1; 
                               if (rdbtnlstReportType.SelectedItem.Text == "PDF")
                                {
                                    GeneratePDF();
                                }
                                if (rdbtnlstReportType.SelectedItem.Text == "Excel")
                                {
                                    dtsummaryClientwise = (DataTable)ViewState["RequestedServiceWoNoWise"];
                                    ExportExcel(gdvSearchWorkOrder, dtsummaryClientwise, "ServiceCompletionDetails");
                                }
                       
                        }
                }
                if (ViewState["RequestedServiceDateWise"] != null)
                {
                       if (rdbtnFilePickDetails.SelectedItem.Text == "Work Order Date Wise")
                        {
                            IsExist = 2; 
                            if (rdbtnlstReportType.SelectedItem.Text == "PDF")
                            {
                                GeneratePDF();
                            }
                            if (rdbtnlstReportType.SelectedItem.Text == "Excel")
                            {
                                dtsummaryClientwise = (DataTable)ViewState["RequestedServiceDateWise"];
                                ExportExcel(gdvSearchWorkOrder, dtsummaryClientwise, "ServiceCompletionDetails");
                            }
                        
                   }
                }
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

    protected void ExportExcel(GridView gvReport, DataTable dtReportData, string ReportName)
    {
        gvReport.ShowHeader = true;
        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename=" + ReportName + ".xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-excel";
        using (StringWriter sw = new StringWriter())
        {
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            string htmlReportFileter = "<table width='100%'> <tr> <td> Company Group :</td><td colspan='3'>" + ddlCompanyGroup.SelectedItem.Text + " </td> </tr>";
            htmlReportFileter += "</br>";
            htmlReportFileter += "</table>";
            gvReport.AllowPaging = false;
            gvReport.DataSource = dtReportData;
            gvReport.DataBind();
            if (gvReport.Rows.Count > 0)
            {
                foreach (TableCell cell in gvReport.HeaderRow.Cells)
                {
                    cell.BackColor = gvReport.HeaderStyle.BackColor;
                }
                foreach (GridViewRow row in gvReport.Rows)
                {
                    // row.BackColor = Color.White;
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            cell.BackColor = gvReport.AlternatingRowStyle.BackColor;
                        }
                        else
                        {
                            cell.BackColor = gvReport.RowStyle.BackColor;
                        }
                        cell.CssClass = "textmode";
                    }
                }
            }

            gvReport.RenderControl(hw);
            gvReport.ShowHeader = false;
            string style = @"<style> .textmode { } </style>";
            Response.Write(style);
            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();

        }
    }
    int TotalWoNo = 0;
    int TotalService = 0;
    int TotalServiceCompleted = 0;
    protected void GridServiceSummarry_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TotalWoNo += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "TotalWoNo"));
            TotalService += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "TotalService"));
            TotalServiceCompleted += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "ComletedService"));
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblTotal = (Label)e.Row.FindControl("lblTotalWoNo");
            Label lblTotalRequestedService = (Label)e.Row.FindControl("lblTotalRequestedService");
            lblTotal.Text = TotalWoNo.ToString();
            lblTotalRequestedService.Text = TotalService.ToString();
            Label lblTotalCompletedService = (Label)e.Row.FindControl("lblTotalCompletedService");
            lblTotalCompletedService.Text = TotalServiceCompleted.ToString();
        }
    }

    public void SetRolewiseAcessfuncationality()
    {
        UserRolewiseAcess objUserRoleWiseAcessDAL = new UserRolewiseAcess();
        DataTable dtPageId = objUserRoleWiseAcessDAL.GetApplicationCodeDetails("Page_Name", "Service Completion Report").Tables[0];
        int PageId = 0;
        if (dtPageId.Rows.Count > 0)
        {
            PageId = Convert.ToInt32(dtPageId.Rows[0][0]);
        }
        DataTable dtPagefuncationality = objUserRoleWiseAcessDAL.GetPageFunctionalityByRoleAndPageId(PageId, RoleId).Tables[0];
        btnview.Visible = false;
        btnViewClear.Visible = false;
        btnExportToExcel.Visible = false;
        if (dtPagefuncationality != null)
        {
            string PageFuncationality = string.Empty;
            for (int i = 0; i < dtPagefuncationality.Rows.Count; i++)
            {
                if (Convert.ToBoolean(dtPagefuncationality.Rows[i]["IsEnableForRole"]))
                {
                    PageFuncationality = Convert.ToString(dtPagefuncationality.Rows[i]["Functionality"]).Trim();
                    switch (PageFuncationality)
                    {
                        case "View":

                            btnview.Visible = true;
                            break;
                        case "Clear":
                            btnViewClear.Visible = true;
                            break;
                        case "Export To Excel":
                           // btnExportToExcel.Visible = true;
                            break;
                        default:
                            break;
                    }
                }
            }
        }
    }
   
    protected void GeneratePDF()
    {
        DateTime? dFromDate;
        DateTime? dToDate;
        if (txtfromDate.Text == "")
            dFromDate = Convert.ToDateTime("01-01-1900");
        else
            dFromDate = Convert.ToDateTime(txtfromDate.Text.ToString(), enGB);
        if (txttodate.Text == "")
            dToDate = DateTime.Now;
        else
            dToDate = Convert.ToDateTime(txttodate.Text.ToString(), enGB);
        Director director = new Director();
        //IBuilder b1 = new ConcreteBuilder();
        ConcreteBuilder b1 = new ConcreteBuilder();
        b1.WareHouseId = Convert.ToInt16(ddlWareHouse.SelectedValue);
        b1.CompanyGroupId = Convert.ToInt32(ddlCompanyGroup.SelectedValue);
        b1.CustomerId = Convert.ToInt32(ddlCustomer.SelectedValue);
        b1.IWoNo = Convert.ToInt32(ddlWorkOrder.SelectedValue);
        b1.Fromdate = (DateTime)dFromDate;
        b1.ToDate = (DateTime)dToDate;
        try
        {
            director.Construct(b1);
            Product p1 = b1.GetResult();
            p1.Show();
        }
        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }
    }
    class Director
    {
        public void Construct(IBuilder builder)
        {
            builder.BuildServiceComletions();
        }
    }

    public interface IBuilder
    {
        void BuildServiceComletions();
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
            string FileName = IsExist == 1 ? "ServiceComletionSummary" : "ServiceComletionDetails";
            _document.Close();
            HttpContext.Current.Response.ContentType = "application/pdf";
            HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment;filename=" + FileName + ".pdf", 0000));
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
        const string FullFilePath = "~/Reports/ServiceCompletion.htm";
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
        public    Int16 WareHouseId { get; set; }
        public int CompanyGroupId { get; set; }
        public int CustomerId { get; set; }
        public int IWoNo { get; set; }
        public DateTime Fromdate { get; set; }
        public DateTime ToDate { get; set; }

        DataTable GetServiceCompletion(Int16 iWareHosueId, int CGId, int ICustId)
        {
            DataTable dtServiceCompt = new DataTable();
            if (IsExist == 1)
            {
                if (HttpContext.Current.Cache["ServiceCompletionWorkOrderNumberWise"] != null)
                {
                    dtServiceCompt = (DataTable)HttpContext.Current.Cache["ServiceCompletionWorkOrderNumberWise"];
                }
            }
            if (IsExist == 2)
            {
                if (HttpContext.Current.Cache["ServiceCompletionWorkOrderDateWise"] != null)
                {

                    dtServiceCompt = (DataTable)HttpContext.Current.Cache["ServiceCompletionWorkOrderDateWise"]; 
                }
            }
            if (IsExist == 3)
            {
                dtServiceCompt = objPRSMReportBAL.GetServiceCompletionSummary(iWareHosueId, CGId, ICustId, Fromdate, ToDate).Tables[0];
            }
            return dtServiceCompt;
        }

        DataTable GetServiceCount(Int16 iWareHosueId, int CGId, int ICustId)
        {
            DataTable dtServiceCompt = new DataTable();
            if (IsExist == 3)
            {
                dtServiceCompt = objPRSMReportBAL.GetServiceCompletionSummary(iWareHosueId, CGId, ICustId, Fromdate, ToDate).Tables[1];
            }
            return dtServiceCompt;
        }

        public void BuildServiceComletions()
        {
            product.Initlize();
            iTextSharp.text.pdf.PdfPTable TableServiceCompt = null;
            if (IsExist == 1)
            {
                TableServiceCompt = ObjPdfTAbles.GetServiceCompletionReport(GetServiceCompletion(WareHouseId, CompanyGroupId, CustomerId));
            }
            if (IsExist == 2)
            {
                TableServiceCompt = ObjPdfTAbles.GetServiceCompletionReportDateWise(GetServiceCompletion(WareHouseId, CompanyGroupId, CustomerId));
            }
            if (IsExist == 3)
            {
                TableServiceCompt = ObjPdfTAbles.GetServiceCompletionReportSummary(GetServiceCompletion(WareHouseId, CompanyGroupId, CustomerId), GetServiceCount(WareHouseId, CompanyGroupId, CustomerId));
            }
            product.Add(TableServiceCompt, GetWoHeader(), 0);
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

    protected void rdbtnFilePickDetails_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlCompanyGroup.ClearSelection();
        ddlWareHouse.ClearSelection();
        ddlWorkOrder.ClearSelection();
        ddlCustomer.ClearSelection();
        txtfromDate.Text = "";
        txttodate.Text = "";
        gdvSearchWorkOrder.DataSource = null;
        gdvSearchWorkOrder.DataBind();
    }
}