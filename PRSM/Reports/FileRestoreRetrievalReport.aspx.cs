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
public partial class Reports_FileRestoreRetrievalReport : PageBase
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

    int iworkorderno = 0;
    string CommandName = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
       
        if (!IsPostBack)
        {
           
            FilePickUpSummary();
        }
    }

    protected void FilePickUpSummary()
    {

        lnkbtnFilePickUpdetails.Style["color"] = "#4f4f4f !important;";
        lnkbtnFilePickUp.Style["color"] = "blue !important;";
       ViewState["btnExpoert"] = false;
        BindCompanyGroup(0);
        ddlCustomer.Items.Clear();
        ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlCstpickDetails.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlCustomer.SelectedIndex = 0;
        ddlCompanyGroup.SelectedIndex = 0;
        divFilePickUpdetails.Style["display"] = "none";
        divFilePickUp.Style["display"] = "block";
       
        btnExportToExcel.Visible = false;
        SetRolewiseAcessfuncationality();
       
            ddlCompanyGroup.Enabled = false;
            ddlCustomer.Enabled = false;
            BindClientWise();
       

    }
    protected void btnViewClear_Click(object sender, EventArgs e)
    {
        pnlExportype.Visible = false;
        ddlCompanyGroup.SelectedIndex = 0;
        ddlCustomer.SelectedIndex = 0;
        txtfromDate.Text = string.Empty;
        txttodate.Text = string.Empty;
        gvClientwise.DataSource = null;
        gvClientwise.DataBind();
    }
    protected void btnClearDetails_Click(object sender, EventArgs e)
    {
        PnlReportType.Visible = false;
        ddlCgpickDetails.SelectedIndex = 0;
        ddlCstpickDetails.SelectedIndex = 0;
        txtFromDatepickDetials.Text = string.Empty;
        txtToDatepickDetials.Text = string.Empty;
        GrdFileDetailsWorkOrderDateWise.DataSource = null;
        GrdFileDetailsWorkOrderDateWise.DataBind();
        GrdFileDetailsWorkOrderNoWise.DataSource = null;
        GrdFileDetailsWorkOrderNoWise.DataBind();
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

        ddlCgpickDetails.DataSource = null;
        ddlCgpickDetails.DataBind();
        ddlCgpickDetails.DataSource = objPRSMBAL.GetCompanyGroup(iCompanyId);
        ddlCgpickDetails.DataValueField = "CompanyGroupId";
        ddlCgpickDetails.DataTextField = "CGName";
        ddlCgpickDetails.DataBind();
        ddlCgpickDetails.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });

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

    protected void BindCustomerPickDetails(int iCompanyId)
    {

        ddlCstpickDetails.DataSource = null;
        ddlCstpickDetails.DataBind();
        ddlCstpickDetails.DataSource = objPRSMBAL.GetCustomer(iCompanyId);
        ddlCstpickDetails.DataValueField = "CustomerId";
        ddlCstpickDetails.DataTextField = "CustomerName";
        ddlCstpickDetails.DataBind();
        ddlCstpickDetails.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });

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

    protected void ddlCustomer_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlCustomer.SelectedIndex > 0)
        {
            int iCustomerId = Convert.ToInt32(ddlCustomer.SelectedValue);
          //  BindPickUpAddress(iCustomerId);
        }
        else
        {
            divDepartmentwise.Visible = false;
            GrdDepartmentwise.DataSource = null;
            GrdDepartmentwise.DataBind();
        }
    }
  
    public class Years
    {
        public int YearId { get; set; }
        public string YearName { get; set; }
    }

 
    protected void BindClientWise()
    {
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
       Entity.FilePickUpReport ObjFilePickUpReport =
      new Entity.FilePickUpReport
            {
                 CompanyGroupId = Convert.ToInt32(ddlCompanyGroup.SelectedValue),
                 CustomerId = Convert.ToInt32(ddlCustomer.SelectedValue),
                 DepartmentId = Convert.ToInt32(0),
                 FromDate = dFromDate,
                 ToDate = dToDate
            };

       int ActivityTypeId = Convert.ToInt32(ViewState["ServiceReportType"]);

        DataSet ds = objPRSMReportBAL.GetFileRetrievalRestoreSummary(ObjFilePickUpReport);
        if (ds != null)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                pnlExportype.Visible = true;
                ViewState["Summaryclientwise"] = ds.Tables[0];
                HttpContext.Current.Cache["Summaryclientwise"] = ds.Tables[0];
                HttpContext.Current.Cache["SummaryclientwiseSum"] = ds.Tables[2];
                gvClientwise.DataSource = ds.Tables[0];
                gvClientwise.DataBind();
            }
            else
            {
                pnlExportype.Visible = false;
                gvClientwise.DataSource = null;
                gvClientwise.DataBind();
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('No Record Found.')", true);
            }

        }
    }
    protected void DepartmentWise()
    {
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

       Entity.FilePickUpReport ObjFilePickUpReport =
      new Entity.FilePickUpReport
       {
           CompanyGroupId = Convert.ToInt32(ddlCompanyGroup.SelectedValue),
           CustomerId = Convert.ToInt32(ddlCustomer.SelectedValue),
           DepartmentId = Convert.ToInt32(0),
           FromDate = dFromDate,
           ToDate = dToDate
          
       };

       int ActivityTypeId = Convert.ToInt32(ViewState["ServiceReportType"]);

        DataSet ds = objPRSMReportBAL.GetFileRetrievalRestoreSummary(ObjFilePickUpReport);
        if (ds.Tables[1].Rows.Count > 0)
        {
            pnlExportype.Visible = true;
            ViewState["SummaryDepartmentWise"] = ds.Tables[1];
            GrdDepartmentwise.DataSource = ds.Tables[1];
            GrdDepartmentwise.DataBind();
        }
        else
            pnlExportype.Visible = true;
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('No Record Found.')", true);
    }
    protected void btnview_Click(object sender, EventArgs e)
    {
        btnExportToExcel.Visible = true;
        ClearGrid();
        btnExportToExcel.Enabled = true;
        //if (rdlstbtnReport.SelectedItem.Text == "Department-Wise")
        //{
        //    DepartmentWise();
        //}
        //else
        //{
            BindClientWise();
        //}
    }
    protected void ExportExcel(GridView gvReport, DataTable dtReportData, string ReportName)
    {
        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename=" + ReportName + ".xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-excel";
        using (StringWriter sw = new StringWriter())
        {
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            string htmlReportFileter = "<table width='100%'> <tr> <td> Company Group :</td><td colspan='3'>" +ddlCompanyGroup.SelectedItem.Text+ " </td> </tr>";
        //    htmlReportFileter += "<tr> <td> Customer :</td><td colspan='3'>" + ddlCustomer.SelectedItem.Text + " </td> </tr>";
           // htmlReportFileter += "<tr> <td> Pick Up Address :</td><td colspan='3'>" + lblPickupAddress.Text + " </td> </tr>";
          //  htmlReportFileter += "<tr> <td> Department :</td><td colspan='3'>" + lblDepartment.Text + " </td> </tr>";
            //htmlReportFileter += "<tr> <td> From Date :</td><td>" + txtfromDate.Text+ " </td><td> To Date :</td><td>" + txttodate.Text + " </td> </tr> <br />";
        //    htmlReportFileter += "<tr> <td> Report Type :</td><td colspan='3'>  " + rbtreportwise.SelectedItem.ToString() + "  </td> </tr><br />";
            htmlReportFileter += "</br>";
            htmlReportFileter += "</table>";
            //To Export all pages
            gvReport.AllowPaging = false;
            gvReport.DataSource = dtReportData;
            gvReport.DataBind();

            // gdvSearchWorkOrder.HeaderRow.BackColor = Color.White;
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
                        if (cell.Controls.Count >= 4)
                        {
                            if (cell.Controls[3] != null && cell.Controls[3] is System.Web.UI.WebControls.LinkButton)
                            {
                                string cellControlText = ((System.Web.UI.WebControls.LinkButton)cell.Controls[3]).Text;
                                cell.Controls.Remove(cell.Controls[3]);
                                System.Web.UI.WebControls.Literal lit = new System.Web.UI.WebControls.Literal();
                                lit.Text = cellControlText;
                                cell.Controls.Add(lit);
                            }
                        }
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

            //    ltrClintWiseFilter.Text = htmlReportFileter;
          //ltrClintWiseFilter.RenderControl(hw);
            gvReport.RenderControl(hw);
            //style to format numbers to string
            string style = @"<style> .textmode { } </style>";
            Response.Write(style);
            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();

        }
    }
    protected void btnExportToExcel_Click(object sender, EventArgs e)
    {
        try
        {
            //if (rdlstbtnReport.SelectedValue == "1")
            //{
                IsExist = 1;
                DataTable dtsummaryClientwise = new DataTable();
                if (ViewState["Summaryclientwise"] != null)
                {
                    IsExist = 1;
                    if (rdbtnlstReportType.SelectedItem.Text == "PDF")
                    {
                        GeneratePDF();
                    }
                    if (rdbtnlstReportType.SelectedItem.Text == "Excel")
                    {
                        dtsummaryClientwise = (DataTable)ViewState["Summaryclientwise"];
                        ExportExcel(gvClientwise, dtsummaryClientwise, "FileRetrievalRestoreSummary");
                    }
                }
             
            //}
            //else
            //{
            //    IsExist = 2;
            //    DataTable dtsummaryDepertmentClientwise = new DataTable();
            //    if (ViewState["SummaryDepartmentWise"] != null)
            //    {
            //        if (rdbtnlstReportType.SelectedItem.Text == "PDF")
            //        {
            //            GeneratePDF();
            //        }
            //        if (rdbtnlstReportType.SelectedItem.Text == "Excel")
            //        {
            //            dtsummaryDepertmentClientwise = (DataTable)ViewState["SummaryDepartmentWise"];
            //            ExportExcel(GrdDepartmentwise, dtsummaryDepertmentClientwise, "Department Wise File Pickup");
            //        }
            //    }
            //}
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
    int TotalBoxesRet = 0;
    int TotalFilesRet = 0;
    int TotalBoxesRes = 0;
    int TotalFilesRes = 0;
    protected void gvClientwise_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TotalBoxesRet += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "NoOfBoxesRet"));
            TotalFilesRet += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "NoOfFilesRet"));
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblGrandTotalBoxesRet = (Label)e.Row.FindControl("lblGrandTotalBoxesRet");
            lblGrandTotalBoxesRet.Text = TotalBoxesRet.ToString();
            Label lblGrandTotalFilesRet = (Label)e.Row.FindControl("lblGrandTotalFilesRet");
            lblGrandTotalFilesRet.Text = TotalFilesRet.ToString();
        }


        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TotalBoxesRes += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "NoOfBoxesRes"));
            TotalFilesRes += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "NoOfFilesRes"));
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblGrandTotalBoxesRes = (Label)e.Row.FindControl("lblGrandTotalBoxesRes");
            lblGrandTotalBoxesRes.Text = TotalBoxesRes.ToString();
            Label lblGrandTotalFilesRes = (Label)e.Row.FindControl("lblGrandTotalFilesRes");
            lblGrandTotalFilesRes.Text = TotalFilesRes.ToString();
        }

    }




    protected void gvClientwise_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            GridView HeaderGrid = (GridView)sender;
            GridViewRow HeaderRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);
            TableHeaderCell Cell_Header = new TableHeaderCell();
            Cell_Header.Text = "";
            Cell_Header.HorizontalAlign = HorizontalAlign.Center;
            Cell_Header.ColumnSpan = 1;
            Cell_Header.RowSpan = 1;
            //HeaderRow.Attributes.Add("CssClass",".grid_data");
            HeaderRow.Cells.Add(Cell_Header);

            Cell_Header = new TableHeaderCell();
            Cell_Header.Text = "Retrieval";
            Cell_Header.HorizontalAlign = HorizontalAlign.Center;
            Cell_Header.ColumnSpan = 2;
            Cell_Header.Style.Add("text-align", "center");
            HeaderRow.Cells.Add(Cell_Header);

            Cell_Header = new TableHeaderCell();
            Cell_Header.Text = "Restore";
            Cell_Header.HorizontalAlign = HorizontalAlign.Center;
            Cell_Header.ColumnSpan = 2;
            Cell_Header.Style.Add("text-align", "center");
            HeaderRow.Cells.Add(Cell_Header);

            gvClientwise.Controls[0].Controls.AddAt(0, HeaderRow);

        }
    }

    protected void GrdFileDetailsWorkOrderNoWise_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            GridView HeaderGrid = (GridView)sender;
            GridViewRow HeaderRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);
            TableHeaderCell Cell_Header = new TableHeaderCell();
            Cell_Header.Text = "";
            Cell_Header.HorizontalAlign = HorizontalAlign.Center;
            Cell_Header.ColumnSpan = 3;
            //Cell_Header.RowSpan = 1;
            HeaderRow.Cells.Add(Cell_Header);

            Cell_Header = new TableHeaderCell();
            Cell_Header.Text = "Retrieval";
            Cell_Header.HorizontalAlign = HorizontalAlign.Center;
            Cell_Header.ColumnSpan = 2;
            Cell_Header.Style.Add("text-align", "center");
            HeaderRow.Cells.Add(Cell_Header);

            Cell_Header = new TableHeaderCell();
            Cell_Header.Text = "Restore";
            Cell_Header.HorizontalAlign = HorizontalAlign.Center;
            Cell_Header.ColumnSpan = 2;
            Cell_Header.Style.Add("text-align", "center");
            HeaderRow.Cells.Add(Cell_Header);

            GrdFileDetailsWorkOrderNoWise.Controls[0].Controls.AddAt(0, HeaderRow);

        }
    }

    protected void GrdFileDetailsWorkOrderDateWise_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            GridView HeaderGrid = (GridView)sender;
            GridViewRow HeaderRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);
            TableHeaderCell Cell_Header = new TableHeaderCell();
            Cell_Header.Text = "";
            Cell_Header.HorizontalAlign = HorizontalAlign.Center;
            Cell_Header.ColumnSpan = 3;
            //Cell_Header.RowSpan = 1;
            HeaderRow.Cells.Add(Cell_Header);

            Cell_Header = new TableHeaderCell();
            Cell_Header.Text = "Retrieval";
            Cell_Header.HorizontalAlign = HorizontalAlign.Center;
            Cell_Header.ColumnSpan = 2;
            Cell_Header.Style.Add("text-align", "center");
            HeaderRow.Cells.Add(Cell_Header);

            Cell_Header = new TableHeaderCell();
            Cell_Header.Text = "Restore";
            Cell_Header.HorizontalAlign = HorizontalAlign.Center;
            Cell_Header.ColumnSpan = 2;
            Cell_Header.Style.Add("text-align", "center");
            HeaderRow.Cells.Add(Cell_Header);

            GrdFileDetailsWorkOrderDateWise.Controls[0].Controls.AddAt(0, HeaderRow);

        }
    }

    int TotalDeptfilesRet = 0;
    int TotalDeptfilesRes = 0;

    protected void GrdDepartmentwise_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TotalDeptfilesRet += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "NoOfFilesRet"));
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblGrandTotalFilesRet = (Label)e.Row.FindControl("lblGrandTotalFilesRet");
            lblGrandTotalFilesRet.Text = TotalDeptfilesRet.ToString();
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TotalDeptfilesRes += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "NoOfFilesRes"));
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblGrandTotalFilesRes = (Label)e.Row.FindControl("lblGrandTotalFilesRes");
            lblGrandTotalFilesRes.Text = TotalDeptfilesRes.ToString();
        }
    }
    int TotalWORet = 0;
    int TotalWORes = 0;
    protected void gvWorkorderwise_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TotalWORet += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "TotalPickUpFiles"));
            TotalFilesRet += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "NoOfFilesRet"));
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblGrandTotalRet = (Label)e.Row.FindControl("lblGrandTotalRet");
            lblGrandTotalRet.Text = TotalWORet.ToString();
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TotalWORes += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "TotalPickUpFiles"));
            TotalFilesRes += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "NoOfFilesRes"));
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblGrandTotalRes = (Label)e.Row.FindControl("lblGrandTotalRes");
            lblGrandTotalRes.Text = TotalWORes.ToString();
        }
    }


    Int32 totalWorkNoWiseBoxRet = 0;
    Int32 totalWorkdateWiseFileRet = 0;

    Int32 totalWorkNoWiseBoxRes = 0;
    Int32 totalWorkdateWiseFileRes = 0;
    protected void GrdFileDetailsWorkOrderNoWise_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            LinkButton lbtnBoxesRet = (LinkButton)e.Row.FindControl("lbtnBoxesRet");
            LinkButton lbtnFilesRet = (LinkButton)e.Row.FindControl("lbtnFilesRet");
            LinkButton lbtnBoxesRes =(LinkButton)e.Row.FindControl("lbtnBoxesRes");
            LinkButton lbtnFilesRes = (LinkButton)e.Row.FindControl("lbtnFilesRes");
            Label lblNoOfBoxesRet = (Label)e.Row.FindControl("lblNoOfBoxesRet");
            Label lblNoOfFilesRet = (Label)e.Row.FindControl("lblNoOfFilesRet");
            Label lblNoOfBoxesRes = (Label)e.Row.FindControl("lblNoOfBoxesRes");
            Label lblNoOfFilesRes = (Label)e.Row.FindControl("lblNoOfFilesRes");

            if (lbtnBoxesRet.Text.ToString() == "0")
            {
                lbtnBoxesRet.Enabled = false;
                lblNoOfBoxesRet.Enabled = true;
            }
            else
            {
                lblNoOfBoxesRet.Enabled = false;
                lbtnBoxesRet.Enabled = true;
            }

            if (lbtnFilesRet.Text.ToString() == "0")
            {
                lblNoOfFilesRet.Enabled = true;
                lbtnFilesRet.Enabled = false;
            }
            else
            {
                lblNoOfFilesRet.Enabled = false;
                lbtnFilesRet.Enabled = true;
            }
            if (lbtnBoxesRes.Text == "0")
            {
                lbtnBoxesRes.Enabled = false;
                lblNoOfBoxesRes.Enabled = true;
            }
            else
            {
                lbtnBoxesRes.Enabled = true;
                lblNoOfBoxesRes.Enabled = false;
            }
            if (lbtnFilesRes.Text == "0")
            {
                lbtnFilesRes.Enabled = false;
                lblNoOfFilesRes.Enabled = true;
            }
            else
            {
                lbtnFilesRes.Enabled = true;
                lblNoOfFilesRes.Enabled = false;
            }

            totalWorkNoWiseBoxRet += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "NoOfBoxesRet"));
            totalWorkdateWiseFileRet += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "NoOfFilesRet"));
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblGrandTotalBoxesRet = (Label)e.Row.FindControl("lblGrandTotalBoxesDetailsRet");
            lblGrandTotalBoxesRet.Text = totalWorkNoWiseBoxRet.ToString();
            Label lblGrandTotalFilesRet = (Label)e.Row.FindControl("lblGrandTotalFilesDetailsRet");
            lblGrandTotalFilesRet.Text = totalWorkdateWiseFileRet.ToString();
        }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            totalWorkNoWiseBoxRes += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "NoOfBoxesRes"));
            totalWorkdateWiseFileRes += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "NoOfFilesRes"));
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblGrandTotalBoxesRes = (Label)e.Row.FindControl("lblGrandTotalBoxesDetailsRes");
            lblGrandTotalBoxesRes.Text = totalWorkNoWiseBoxRes.ToString();
            Label lblGrandTotalFilesRes = (Label)e.Row.FindControl("lblGrandTotalFilesDetailsRes");
            lblGrandTotalFilesRes.Text = totalWorkdateWiseFileRes.ToString();
        }
    }

    Int32 totalWorkNoWiseBox1Ret = 0;
    Int32 totalWorkdateWiseFile1Ret = 0;
    Int32 totalWorkNoWiseBox1Res = 0;
    Int32 totalWorkdateWiseFile1Res = 0;
    protected void GrdFileDetailsWorkOrderDateWise_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            LinkButton lbtnBoxesRet = (LinkButton)e.Row.FindControl("lbtnBoxesRet");
            LinkButton lbtnFilesRet = (LinkButton)e.Row.FindControl("lbtnFilesRet");
            LinkButton lbtnBoxesRes = (LinkButton)e.Row.FindControl("lbtnBoxesRes");
            LinkButton lbtnFilesRes = (LinkButton)e.Row.FindControl("lbtnFilesRes");
            Label lblNoOfBoxesRet = (Label)e.Row.FindControl("lblNoOfBoxesRet");
            Label lblNoOfFilesRet = (Label)e.Row.FindControl("lblNoOfFilesRet");
            Label lblNoOfBoxesRes = (Label)e.Row.FindControl("lblNoOfBoxesRes");
            Label lblNoOfFilesRes = (Label)e.Row.FindControl("lblNoOfFilesRes");

            if (lbtnBoxesRet.Text.ToString() == "0")
            {
                lbtnBoxesRet.Enabled = false;
                lblNoOfBoxesRet.Enabled = true;
            }
            else
            {
                lblNoOfBoxesRet.Enabled = false;
                lbtnBoxesRet.Enabled = true;
            }

            if (lbtnFilesRet.Text.ToString() == "0")
            {
                lblNoOfFilesRet.Enabled = true;
                lbtnFilesRet.Enabled = false;
            }
            else
            {
                lblNoOfFilesRet.Enabled = false;
                lbtnFilesRet.Enabled = true;
            }
            if (lbtnBoxesRes.Text == "0")
            {
                lbtnBoxesRes.Enabled = false;
                lblNoOfBoxesRes.Enabled = true;
            }
            else
            {
                lbtnBoxesRes.Enabled = true;
                lblNoOfBoxesRes.Enabled = false;
            }
            if (lbtnFilesRes.Text == "0")
            {
                lbtnFilesRes.Enabled = false;
                lblNoOfFilesRes.Enabled = true;
            }
            else
            {
                lbtnFilesRes.Enabled = true;
                lblNoOfFilesRes.Enabled = false;
            }
            totalWorkNoWiseBox1Ret += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "NoOfBoxesRet"));
            totalWorkdateWiseFile1Ret += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "NoOfFilesRet"));
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblGrandTotalBoxesRet = (Label)e.Row.FindControl("lblGrandTotalBoxesDateWiseRet");
            lblGrandTotalBoxesRet.Text = totalWorkNoWiseBox1Ret.ToString();
            Label lblGrandTotalFilesRet = (Label)e.Row.FindControl("lblGrandTotalFilesDateWiseRet");
            lblGrandTotalFilesRet.Text = totalWorkdateWiseFile1Ret.ToString();
        }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            totalWorkNoWiseBox1Res += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "NoOfBoxesRes"));
            totalWorkdateWiseFile1Res += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "NoOfFilesRes"));
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblGrandTotalBoxesRes = (Label)e.Row.FindControl("lblGrandTotalBoxesDateWiseRes");
            lblGrandTotalBoxesRes.Text = totalWorkNoWiseBox1Res.ToString();
            Label lblGrandTotalFilesRes = (Label)e.Row.FindControl("lblGrandTotalFilesDateWiseRes");
            lblGrandTotalFilesRes.Text = totalWorkdateWiseFile1Res.ToString();
        }
    }


    protected void lnkbtnclose_Click(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "HidedivContract();", true);
    }

    protected void rdlstbtnReport_SelectedIndexChanged(object sender, EventArgs e)
    {
        ClearDate();
        ClearGrid();
        ddlCustomer.SelectedIndex = 0;
        ddlCompanyGroup.SelectedIndex = 0;
    
        divFilePickUpdetails.Style["display"] = "none";
        divFilePickUp.Style["display"] = "block";
        //if (rdlstbtnReport.SelectedItem.Text == "Department-Wise")
        //{
            GrdDepartmentwise.DataSource = null;
            GrdDepartmentwise.DataBind();
            divDepartmentwise.Style["display"] = "block";
            divgvClientwise.Style["display"] = "none";
            ddlCompanyGroup.Enabled = true ;
            ddlCustomer.Enabled = true;
        //}
        //else
        //{
            ddlCompanyGroup.Enabled = false;
            ddlCustomer.Enabled = false;
            gvClientwise.DataSource = null;
            gvClientwise.DataBind();
            divDepartmentwise.Style["display"] = "none";
            divgvClientwise.Style["display"] = "block";
         
        //}
    }


    //private void ExporttoExcel(DataTable table)
    //{
    //    string htmlReportFileter = "<table width='100%'> <tr> <td> Company Group :</td><td colspan='3'>" + lblCompanyGroup.Text + " </td> </tr>";
    //    htmlReportFileter += "<tr> <td> Customer :</td><td colspan='3'>" + lblCustomer.Text + " </td> </tr>";
    //    htmlReportFileter += "<tr> <td> Pick Up Address :</td><td colspan='3'>" + lblPickupAddress.Text + " </td> </tr>";
    //    htmlReportFileter += "<tr> <td> Department :</td><td colspan='3'>" + lblDepartment.Text + " </td> </tr>";
    //    htmlReportFileter += "<tr> <td> From Date :</td><td>" + lblFromDate.Text + " </td><td> To Date :</td><td>" + lblToDate.Text + " </td> </tr> <br />";
    //    htmlReportFileter += "<tr> <td> Report Type :</td><td colspan='3'> File Pickup Details </td> </tr><br />";
    //    htmlReportFileter += "</br>";
    //    htmlReportFileter += "</table>";
    //    ltrFPDetails.Text = htmlReportFileter;

    //    HttpContext.Current.Response.Write("<Td>");
    //    {
    //        HttpContext.Current.Response.Clear();
    //        HttpContext.Current.Response.ClearContent();
    //        HttpContext.Current.Response.ClearHeaders();
    //        HttpContext.Current.Response.Buffer = true;
    //        HttpContext.Current.Response.ContentType = "application/ms-excel";
    //        HttpContext.Current.Response.Write(@"<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.0 Transitional//EN"">");
    //        HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment;filename=FilePickupDetails.xls");
    //        HttpContext.Current.Response.Charset = "utf-8";
    //        HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.GetEncoding("windows-1250");
    //        //sets font
    //        HttpContext.Current.Response.Write("<font style='font-size:12.0pt; font-family:Calibri;'>");
    //        HttpContext.Current.Response.Write(ltrFPDetails.Text);
    //        HttpContext.Current.Response.Write("<BR><BR><BR>");
    //        HttpContext.Current.Response.Write("<Table border='1' bgColor='#ffffff' borderColor='#000000' cellSpacing='0' cellPadding='0' style='font-size:10.0pt; font-family:Calibri; background:white;'> <TR>");
    //        int columnscount = gvfilepickupdetails.Columns.Count;

    //        for (int j = 0; j < columnscount; j++)
    //        {
    //            //Makes headers bold
    //            HttpContext.Current.Response.Write("<Td>");
    //            HttpContext.Current.Response.Write("<B>");
    //            HttpContext.Current.Response.Write(gvfilepickupdetails.Columns[j].HeaderText.ToString());
    //            HttpContext.Current.Response.Write("</B>");
    //            HttpContext.Current.Response.Write("</Td>");
    //        }

    //        HttpContext.Current.Response.Write("</TR>");
    //        foreach (DataRow row in table.Rows)
    //        {
    //            HttpContext.Current.Response.Write("<TR>");
    //            for (int i = 0; i < table.Columns.Count; i++)
    //            {
    //                HttpContext.Current.Response.Write("<Td Width='250px'>");
    //                HttpContext.Current.Response.Write(row[i].ToString());
    //                HttpContext.Current.Response.Write("</Td>");
    //            }
    //            HttpContext.Current.Response.Write("</TR>");
    //        }

    //        HttpContext.Current.Response.Write("</Table>");
    //        HttpContext.Current.Response.Write("</font>");
    //        HttpContext.Current.Response.Flush();
    //        HttpContext.Current.Response.End();
    //    }
    //}

    protected void ClearGrid()
    {
        ViewState["Summaryclientwise"]=null;
        ViewState["SummaryDepartmentWise"] = null;
        ViewState["FilePickUpdetailsWorkOrderWise"] = null;
        ViewState["FilePickUpdetailsWorkOrdeDateWise"] = null;
        GrdDepartmentwise.DataSource = null;
        GrdDepartmentwise.DataBind();
        gvClientwise.DataSource = null;
        gvClientwise.DataBind();
        GrdFileDetailsWorkOrderDateWise.DataSource = null;
        GrdFileDetailsWorkOrderDateWise.DataBind();
        GrdFileDetailsWorkOrderNoWise.DataSource = null;
        GrdFileDetailsWorkOrderNoWise.DataBind();
    }

    protected void lnkbtnFilePickUp_Click(object sender, EventArgs e)
    {
        pnlExportype.Visible = false;
        PnlReportType.Visible = false;
        lnkbtnFilePickUpdetails.Style["color"] = "#4f4f4f !important;";
        lnkbtnFilePickUp.Style["color"] = "blue !important;";
        ddlCompanyGroup.SelectedIndex = 0;
        divFilePickUpdetails.Style["display"] = "none";
        divFilePickUp.Style["display"] = "block";
        ClearGrid();
        txtfromDate.Text = string.Empty;
        txttodate.Text = string.Empty;
        ddlCustomer.Items.Clear ();
        ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlCustomer.SelectedIndex = 0;
    }

    protected void lnkbtnFilePickUpdetails_Click(object sender, EventArgs e)
    {
        pnlExportype.Visible = false;
        PnlReportType.Visible = false;
        lnkbtnFilePickUpdetails.Style["color"] = "blue !important;";
        lnkbtnFilePickUp.Style["color"] = "#4f4f4f !important;";
        divFilePickUpdetails.Style["display"] = "block";
        divFilePickUp.Style["display"] = "none";
        ClearGrid();
        txtFromDatepickDetials.Text = string.Empty;
        txtToDatepickDetials.Text = string.Empty;
        ddlCstpickDetails.Items.Clear ();
        ddlCstpickDetails.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlCgpickDetails.SelectedIndex = 0;
    }
    protected void ddlCgpickDetails_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlCgpickDetails.SelectedIndex > 0)
        {
            BindCustomerPickDetails(Convert.ToByte(ddlCgpickDetails.SelectedValue));
        }
        else
        {
            ddlCstpickDetails.Items.Clear();
            ddlCstpickDetails.DataSource = null;
            ddlCstpickDetails.DataBind();
            ddlCstpickDetails.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
    }
    protected void btnViewPickDetails_Click(object sender, EventArgs e)
    {
        btnExportDetails.Visible = true;
        divFilePickUp.Style["display"] = "none";
        divFilePickUpdetails.Style["display"] = "block";
        if (rdbtnFilePickDetails.SelectedItem.Text == "Work Order Number Wise")
        {

            DivGrdFileDetailsWorkOrderNoWise.Style["display"] = "block";
            DivGrdFileDetailsWorkOrderDateWise.Style["display"] = "none";
            BindWorkOrderNumberWise();
        }
        else
        {
            DivGrdFileDetailsWorkOrderNoWise.Style["display"] = "none";
            DivGrdFileDetailsWorkOrderDateWise.Style["display"] = "block";
            BindWorkOrderDateWise();
        }
    }

    protected void ClearDate()
    {
        txtfromDate.Text = "";
        txttodate.Text = "";
        txtFromDatepickDetials.Text = "";
        txtToDatepickDetials.Text = "";
    }
    protected void rdbtnFilePickDetails_SelectedIndexChanged(object sender, EventArgs e)
    {
        ClearDate();
        ClearGrid();
        divFilePickUp.Style["display"] = "none";
        divFilePickUpdetails.Style["display"] = "block";
        ddlCgpickDetails.SelectedIndex = 0;
        ddlCstpickDetails.SelectedIndex = 0;
        if (rdbtnFilePickDetails.SelectedItem.Text == "Work Order Number Wise")
        {
            GrdFileDetailsWorkOrderNoWise.DataSource = null;
            GrdFileDetailsWorkOrderNoWise.DataBind();
            DivGrdFileDetailsWorkOrderNoWise.Style["display"] = "block";
            DivGrdFileDetailsWorkOrderDateWise.Style["display"] = "none";
        }
        else
        {
            GrdFileDetailsWorkOrderDateWise.DataSource = null;
            GrdFileDetailsWorkOrderNoWise.DataBind();
            ddlCstpickDetails.SelectedIndex = 0;
            ddlCgpickDetails.SelectedIndex = 0;
            DivGrdFileDetailsWorkOrderNoWise.Style["display"] = "none";
            DivGrdFileDetailsWorkOrderDateWise.Style["display"] = "block";
        }
    }

    protected void GrdFileDetailsWorkOrderNoWise_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        iworkorderno = Convert.ToInt32(e.CommandArgument.ToString());
        ViewState["vsWorkorderno"] = iworkorderno;
        //CommandName = Convert.ToString(e.CommandName);
        //ViewState["CommandName"] = CommandName;
        switch (e.CommandName)
        {
            case "lnkFileRetDetails": DisplayDetailsPopup("RetFile", e.CommandArgument.ToString()); ViewState["CommandName"] = "RetFile"; break;
            case "lnkBoxRetDetails": DisplayDetailsPopup("RetBox", e.CommandArgument.ToString()); ViewState["CommandName"] = "RetBox"; break;
            case "lnkBoxesResDetails": DisplayDetailsPopup("ResBox", e.CommandArgument.ToString()); ViewState["CommandName"] = "ResBox";  break;
            case "lnkFilesResDetails": DisplayDetailsPopup("ResFile", e.CommandArgument.ToString()); ViewState["CommandName"] = "ResFile"; break; 
        }
    }

    protected void GrdFileDetailsWorkOrderDateWise_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        iworkorderno = Convert.ToInt32(e.CommandArgument.ToString());
        ViewState["vsWorkorderno"] = iworkorderno;        
        switch (e.CommandName)
        {
            case "lnkFileRetDetails": DisplayDetailsPopup("RetFile", e.CommandArgument.ToString()); ViewState["CommandName"] = "RetFile"; break;
            case "lnkBoxRetDetails": DisplayDetailsPopup("RetBox", e.CommandArgument.ToString()); ViewState["CommandName"] = "RetBox"; break;
            case "lnkBoxesResDetails": DisplayDetailsPopup("ResBox", e.CommandArgument.ToString()); ViewState["CommandName"] = "ResBox"; break;
            case "lnkFilesResDetails": DisplayDetailsPopup("ResFile", e.CommandArgument.ToString()); ViewState["CommandName"] = "ResFile"; break;
        }
    }

    protected void BindWorkOrderNumberWise()
    {
        
        DateTime? dFromDate;
        DateTime? dToDate;
        if (txtFromDatepickDetials.Text == "")
            dFromDate = null;
        else
            dFromDate = Convert.ToDateTime(txtFromDatepickDetials.Text.ToString(), enGB);
        if (txtToDatepickDetials.Text == "")
            dToDate = null;
        else
            dToDate = Convert.ToDateTime(txtToDatepickDetials.Text.ToString(), enGB);
        int iCustomerId = 0;
        if (ddlCstpickDetails.SelectedValue == "")
        {
            iCustomerId = 0;
        }
        else
            iCustomerId = Convert.ToInt32(ddlCstpickDetails.SelectedValue);

        Entity.FilePickUpReport ObjFilePickUpReport =
            new Entity.FilePickUpReport
            {
                CompanyGroupId = Convert.ToInt32(ddlCgpickDetails.SelectedValue),
                CustomerId = iCustomerId,
                DepartmentId = Convert.ToInt32(0),
                FromDate = dFromDate,
                ToDate = dToDate

            };
        int n_ActivityTypeId = Convert.ToInt16(ViewState["ServiceReportType"]);
        DataSet ds = objPRSMReportBAL.GetFileRetrievalRestoreDetails(ObjFilePickUpReport);
        if (ds != null)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                PnlReportType.Visible = true;
                btnExportDetails.Visible = true;
                HttpContext.Current.Cache["FileRestorerRetrievalWONo"] = ds.Tables[0];
                HttpContext.Current.Cache["FileRestorerRetrievalWONoSum"] = ds.Tables[1];
                ViewState["FilePickUpdetailsWorkOrderWise"] = ds.Tables[0];
                GrdFileDetailsWorkOrderNoWise.DataSource = ds.Tables[0];
                GrdFileDetailsWorkOrderNoWise.DataBind();
            }
            else
            {
                PnlReportType.Visible = false;
                GrdFileDetailsWorkOrderNoWise.DataSource = null;
                GrdFileDetailsWorkOrderNoWise.DataBind();
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('No Record Found.')", true);
                ViewState["FilePickUpdetailsWorkOrderWise"] = null;
            }

        }
    }
    protected void BindWorkOrderDateWise()
    {
        DateTime? dFromDate;
        DateTime? dToDate;
        if (txtFromDatepickDetials.Text == "")
            dFromDate = null;
        else
            dFromDate = Convert.ToDateTime(txtFromDatepickDetials.Text.ToString(), enGB);
        if (txtToDatepickDetials.Text == "")
            dToDate = null;
        else
            dToDate = Convert.ToDateTime(txtToDatepickDetials.Text.ToString(), enGB);
        Entity.FilePickUpReport ObjFilePickUpReport =
            new Entity.FilePickUpReport
            {
                CompanyGroupId = Convert.ToInt32(ddlCgpickDetails.SelectedValue),
                CustomerId = Convert.ToInt32(ddlCstpickDetails.SelectedValue),
                DepartmentId = Convert.ToInt32(0),
                FromDate = dFromDate,
                ToDate = dToDate

            };

        int n_ActivityTypeId = Convert.ToInt16(ViewState["ServiceReportType"]);
        DataSet ds = objPRSMReportBAL.GetFileRetrievalRestoreDetails(ObjFilePickUpReport);
        if (ds != null)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                PnlReportType.Visible = true;
                btnExportDetails.Visible = true;
                HttpContext.Current.Cache["FileRestorerRetrievalWODate"] = ds.Tables[0];
                HttpContext.Current.Cache["FileRestorerRetrievalWODateSum"] = ds.Tables[1];
                ViewState["FilePickUpdetailsWorkOrdeDateWise"] = ds.Tables[0];
                GrdFileDetailsWorkOrderDateWise.DataSource = ds.Tables[0];
                GrdFileDetailsWorkOrderDateWise.DataBind();
            }
            else
            {
                PnlReportType.Visible = false;
                GrdFileDetailsWorkOrderDateWise.DataSource = null;
                GrdFileDetailsWorkOrderDateWise.DataBind();
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('No Record Found.')", true);
                ViewState["FilePickUpdetailsWorkOrdeDateWise"] = null;
            }

        }
    }

    protected void btnExportDetails_Click(object sender, EventArgs e)
    {
      
        try
        {
            if (rdbtnFilePickDetails.SelectedValue == "1")
            {
                DataTable WorkOrderNoWise = new DataTable();
                IsExist = 2;
                if (ViewState["FilePickUpdetailsWorkOrderWise"] != null)
                {
                    if (rdbtnlstFielRetSDetails.SelectedItem.Text == "PDF")
                    {
                        GeneratePDF();
                    }
                    if (rdbtnlstFielRetSDetails.SelectedItem.Text == "Excel")
                    {
                        WorkOrderNoWise = (DataTable)ViewState["FilePickUpdetailsWorkOrderWise"];
                        ExportExcel(GrdFileDetailsWorkOrderNoWise, WorkOrderNoWise, "FileRetrivalRestoreDetasails");
                    }
                   
                }

            }

            else
            {
                DataTable WorkOrderdateWise= new DataTable();
             
                if (ViewState["FilePickUpdetailsWorkOrdeDateWise"] != null)
                {
                    IsExist = 3;
                    if (rdbtnlstFielRetSDetails.SelectedItem.Text == "PDF")
                    {
                        GeneratePDF();
                    }
                    if (rdbtnlstFielRetSDetails.SelectedItem.Text == "Excel")
                    {
                        WorkOrderdateWise = (DataTable)ViewState["FilePickUpdetailsWorkOrdeDateWise"];
                        ExportExcel(GrdFileDetailsWorkOrderDateWise, WorkOrderdateWise, "FileRetrivalRestoreDetasails");
                    }

                }
            }
        }
        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }
    }
    #region [Rolewise access page funcationality]

    public void SetRolewiseAcessfuncationality()
    {
        UserRolewiseAcess objUserRoleWiseAcessDAL = new UserRolewiseAcess();


        DataTable dtPageId = objUserRoleWiseAcessDAL.GetApplicationCodeDetails("Page_Name", "Retrieval & Restore").Tables[0];
        int PageId = 0;
        if (dtPageId.Rows.Count > 0)
        {
            PageId = Convert.ToInt32(dtPageId.Rows[0][0]);
        }
        DataTable dtPagefuncationality = objUserRoleWiseAcessDAL.GetPageFunctionalityByRoleAndPageId(PageId, RoleId).Tables[0];
        btnview.Visible = false;
        btnViewPickDetails.Visible = false;
        btnExportToExcel.Visible = false;
        btnExportDetails.Visible = false;

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
                            btnview.Visible = true;
                            break;
                        case "View Details":
                            btnViewPickDetails.Visible = true;
                            break;
                        case "Export To Excel":
                            btnExportToExcel.Visible = true;
                            break;
                        case "Export To Excel Details":
                            btnExportDetails.Visible = true;
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
        Director director = new Director();
        ConcreteBuilder b1 = new ConcreteBuilder();
        if (IsExist == 2 || IsExist == 1)
        {
            if (txtfromDate.Text == "")
                dFromDate = Convert.ToDateTime("01-01-1900");
            else
                dFromDate = Convert.ToDateTime(txtfromDate.Text.ToString(), enGB);
            if (txttodate.Text == "")
                dToDate = DateTime.Now;
            else
                dToDate = Convert.ToDateTime(txttodate.Text.ToString(), enGB);

            b1.CompanyGroupId = Convert.ToInt32(ddlCompanyGroup.SelectedValue);
            b1.CustomerId = Convert.ToInt32(ddlCustomer.SelectedValue);
            b1.Fromdate = (DateTime)dFromDate;
            b1.ToDate = (DateTime)dToDate;
        }
        else
        {
            if (txtFromDatepickDetials.Text == "")
                dFromDate = Convert.ToDateTime("01-01-1900");
            else
                dFromDate = Convert.ToDateTime(txtFromDatepickDetials.Text.ToString(), enGB);
            if (txtToDatepickDetials.Text == "")
                dToDate = DateTime.Now;
            else
                dToDate = Convert.ToDateTime(txtToDatepickDetials.Text.ToString(), enGB);

            b1.CompanyGroupId = Convert.ToInt32(ddlCompanyGroup.SelectedValue);
            b1.CustomerId = Convert.ToInt32(ddlCstpickDetails.SelectedValue);
            b1.Fromdate = (DateTime)dFromDate;
            b1.ToDate = (DateTime)dToDate;
        }


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

    class Director
    {
        // Builder uses a complex series of steps 
        public void Construct(IBuilder builder)
        {
            builder.BuildFileRestoreRetrieval();
        }
    }

    public interface IBuilder
    {
        void BuildFileRestoreRetrieval();
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
            string FileName = IsExist == 1 ? "FileRetrievalRestoreSummary" : "FileRetrievalRestoreDetails";
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
        const string FullFilePath = "~/Reports/FileRestoreRetrievalReport.htm";
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

        DataTable GetFileRestorRetrieval(int ICustId)
        {

            DataTable dtFileRestorRetrieval = new DataTable();
            if (IsExist == 1)
            {
                if (HttpContext.Current.Cache["Summaryclientwise"] != null)
                {
                    dtFileRestorRetrieval = (DataTable)HttpContext.Current.Cache["Summaryclientwise"];
                }
            }
            if (IsExist == 2)
            {
                if (HttpContext.Current.Cache["FileRestorerRetrievalWONo"] != null)
                {
                    dtFileRestorRetrieval = (DataTable)HttpContext.Current.Cache["FileRestorerRetrievalWONo"];
                }
            }

            if (IsExist == 3)
            {
                if (HttpContext.Current.Cache["FileRestorerRetrievalWODate"] != null)
                {
                    dtFileRestorRetrieval = (DataTable)HttpContext.Current.Cache["FileRestorerRetrievalWODate"];
                }
            }
            return dtFileRestorRetrieval;
        }

        DataTable GetNoBoxesFilesCount(int ICustId)
        {
            DataTable dtFileResRet = new DataTable();
            if (IsExist == 1)
            {
                if (HttpContext.Current.Cache["SummaryclientwiseSum"] != null)
                {
                    dtFileResRet = (DataTable)HttpContext.Current.Cache["SummaryclientwiseSum"];
                }
            }

            return dtFileResRet;
        }

        DataTable GetNoBoxesFilesWoNoDateWiseCount(int ICustId)
        {
            DataTable dtFileResRet = new DataTable();
            if (IsExist == 3)
            {
                if (HttpContext.Current.Cache["FileRestorerRetrievalWODateSum"] != null)
                {
                    dtFileResRet = (DataTable)HttpContext.Current.Cache["FileRestorerRetrievalWODateSum"];
                }
            }
            if (IsExist == 2)
            {
                if (HttpContext.Current.Cache["FileRestorerRetrievalWONoSum"] != null)
                {
                    dtFileResRet = (DataTable)HttpContext.Current.Cache["FileRestorerRetrievalWONoSum"];
                }
            }
            return dtFileResRet;
        }

        public void BuildFileRestoreRetrieval()
        {
            product.Initlize();
            iTextSharp.text.pdf.PdfPTable TableFileRestoreRetrieval = null;
            if (IsExist == 1)
            {
                TableFileRestoreRetrieval = ObjPdfTAbles.GetFileRestoreRetrievalReportSummary(GetFileRestorRetrieval(CustomerId), GetNoBoxesFilesCount(CustomerId));
            }
            if (IsExist == 2)
            {
                TableFileRestoreRetrieval = ObjPdfTAbles.GetFileRestRetWONoWiseReportSummary(GetFileRestorRetrieval(CustomerId), GetNoBoxesFilesWoNoDateWiseCount(CustomerId));
            }
            if (IsExist == 3)
            {
                TableFileRestoreRetrieval = ObjPdfTAbles.GetFileRestRetWODateWiseReportSummary(GetFileRestorRetrieval(CustomerId), GetNoBoxesFilesWoNoDateWiseCount(CustomerId));
            }
            product.Add(TableFileRestoreRetrieval, GetWoHeader(), 0);
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
    #endregion
    /////////////////////////////////ADDITIONAL CODE HERE//////////////////////////////////////////

    void DisplayDetailsPopup(string strIOType, string strWrokOrderNo)
    {
        int intWorkOrderNo = Convert.ToInt32(strWrokOrderNo);
        //int CustomerId = Convert.ToInt32(ddlCustomer.SelectedValue);
        DataSet dsGetFileDetails = null;
        Session["dsGetFileDetails"] = null;
        int CustomerId = 0;
        if (ddlCstpickDetails.SelectedIndex != -1)
        {
            CustomerId = Convert.ToInt32(ddlCstpickDetails.SelectedValue);
        }
        //dsGetFileDetails = objPRSMReportBAL.GetResRetDetails(Convert.ToInt32(CustomerId[0]), strIOType, intWorkOrderNo);
        dsGetFileDetails = objPRSMReportBAL.GetResRetDetails(CustomerId, strIOType, intWorkOrderNo);
        Session["dsGetFileDetails"] = dsGetFileDetails;
        try
        {
            if (dsGetFileDetails.Tables.Count > 0)
            {
                if (dsGetFileDetails.Tables[0].Rows.Count > 0)
                {

                    if (dsGetFileDetails.Tables[0].Rows.Count > 0)
                    {
                        if (strIOType == "ResFile")
                        { //Remove Last Two Columns Status and NoOfDays
                            DataTable dt = dsGetFileDetails.Tables[0];
                            int ColCount = dt.Columns.Count;
                            dt.Columns.RemoveAt(ColCount - 1); //Last Column
                            dt.Columns.RemoveAt(ColCount - 2); //Last But One Column
                            gvResRetDetails.DataSource = dt;
                            gvResRetDetails.DataBind();
                        }
                        else
                        {
                            //Remove Department column
                            DataTable dt = dsGetFileDetails.Tables[0];
                            //dt.Columns.RemoveAt(0); //First Column
                            gvResRetDetails.DataSource = dsGetFileDetails.Tables[0];
                            gvResRetDetails.DataBind();
                        }
                    }
                }
                else
                {
                    gvResRetDetails.DataSource = null;
                    gvResRetDetails.DataBind();
                }

                ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "divShowResFilesdetails();", true);
            }

        }
        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }
    } //DisplayDetailsPopup

    protected void gvResRetDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvResRetDetails.PageIndex = e.NewPageIndex;
        //ViewState["NewPageIndex"] = e.NewPageIndex;
        //DisplayDetailsPopup(string strIOType, string strWrokOrderNo);
        DisplayDetailsPopup(ViewState["CommandName"].ToString(), Convert.ToString(ViewState["vsWorkorderno"]));
        //BindgvBoxesDetails(Convert.ToInt32(ViewState["vsWorkorderno"]), ViewState["CommandName"].ToString());
    }

    protected void btnFilePopupClose_Click(object sender, EventArgs e)
    {
        Session["dsGetFileDetails"] = null;
        gvResRetDetails.DataSource = null;
        gvResRetDetails.DataBind();
        gvResRetDetails.PageIndex = 0;
    }

}


