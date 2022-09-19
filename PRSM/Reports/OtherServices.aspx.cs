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
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
public partial class Reports_FilePickUpReport :PageBase
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
            FilePickUpSummary();
            
        }
    }

    protected void FilePickUpSummary()
    {
        
        lnkbtnFilePickUpdetails.Style["color"] = "#4f4f4f !important;";
        lnkbtnFilePickUpSummary.Style["color"] = "blue !important;";
        gvClientwiseHeader.Style.Clear();
        gvClientwiseHeader.Style.Add("Style", "overflow: auto; padding-left: 0px; color: #4f4f4f; font-size: 12px; width: 98.6%;  line-height: 20px;display: none;");
        ViewState["btnExpoert"] = false; 
        BindCompanyGroup(0);
        ddlCustomer.Items.Clear();
        ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlCstpickDetails.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlCustomer.SelectedIndex = 0;
        ddlCompanyGroup.SelectedIndex = 0;
        divFilePickUpdetails.Style["display"] = "none";
        divFilePickUp.Style["display"] = "block";
        clearViewStateandGrids(); 
        btnExportToExcel.Visible = false;
        SetRolewiseAcessfuncationality();
        //if (rdlstbtnReport.Items.Count > 0)
        //{
        //    rdlstbtnReport.Items[0].Selected = true; 
        //}
        //if (rdlstbtnReport.SelectedItem.Text == "Department-Wise")
        //{
            ddlCompanyGroup.Enabled = true;
            ddlCustomer.Enabled = true;
          
        //}
        //else
        //{
            ddlCompanyGroup.Enabled = false;
            ddlCustomer.Enabled = false; 
            BindClientWise();
           // BindActivity();
        ////}
       
    }

    protected void GrdFileDetailsWorkOrderNoWise_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "lnkviewFileRetrieval")
        {
            int iworkorderno = Convert.ToInt32(e.CommandArgument.ToString());
            DataSet dsGetFileDetails = objTRANSBAL.GetFileRetrievalOtherServicesDetailsByWoNo(iworkorderno);
            try
            {
                if (dsGetFileDetails.Tables.Count > 0)
                {
                    if (dsGetFileDetails.Tables[0].Rows.Count > 0)
                    {

                        if (dsGetFileDetails.Tables[0].Rows.Count > 0)
                        {
                            gvFilesDetails.DataSource = dsGetFileDetails.Tables[0];
                            gvFilesDetails.DataBind();
                        }
                    }
                    else
                    {
                        gvFilesDetails.DataSource = null;
                        gvFilesDetails.DataBind();
                    }

                    ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "divShowFilesdetails();", true);
                }
              
            }
            catch (Exception ex)
            {
                ErrorHandler.WriteLog(ex);
            }
        }
    }
    protected void GrdFileDetailsWorkOrderDateWise_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "lnkviewFileRetrieval")
        {
            int iworkorderno = Convert.ToInt32(e.CommandArgument.ToString());
            DataSet dsGetFileDetails = objTRANSBAL.GetFileRetrievalOtherServicesDetailsByWoNo(iworkorderno);
            try
            {
                if (dsGetFileDetails.Tables.Count > 0)
                {
                    if (dsGetFileDetails.Tables[0].Rows.Count > 0)
                    {

                        if (dsGetFileDetails.Tables[0].Rows.Count > 0)
                        {
                            gvFilesDetails.DataSource = dsGetFileDetails.Tables[0];
                            gvFilesDetails.DataBind();
                        }
                    }
                    else
                    {
                        gvFilesDetails.DataSource = null;
                        gvFilesDetails.DataBind();
                    }

                    ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "divShowFilesdetails();", true);
                }
             
            }
            catch (Exception ex)
            {
                ErrorHandler.WriteLog(ex);
            }
        }
    }
    protected void FilePickUpDetails()
    {
        ViewState["btnExpoertDetails"] = false;
        lnkbtnFilePickUpdetails.Style["color"] = "blue !important;";
        lnkbtnFilePickUpSummary.Style["color"] = "#4f4f4f !important;";
        ddlCstpickDetails.SelectedIndex = 0;
        ddlCgpickDetails.SelectedIndex = 0;
        divFilePickUpdetails.Style["display"] = "block";
        divFilePickUp.Style["display"] = "none";
        clearViewStateandGrids();
        SetRolewiseAcessfuncationality();
        btnExportDetails.Visible = true;
      
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
        gvClientwise.DataSource = null;
        gvClientwise.DataBind();
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

    ////protected void BindActivity()
    ////{
    ////    List<Activity> lst = objPRSMBAL.GetActivity(0);
    ////    if (lst != null)
    ////    {
    ////        if (lst.Count > 0)
    ////        {
    ////               var query =
    ////                            from order in lst.AsEnumerable()
    ////                            where order.SCName == "Other services"
    ////                            select order;
    ////                ddlActivity.DataSource = query.ToList();
    ////                ddlActivity.DataTextField = "ActivityName";
    ////                ddlActivity.DataValueField = "ActivityId";
    ////                ddlActivity.DataBind();
    ////                ddlActivity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    ////        }
    ////    }
    ////}
    protected void ddlCustomer_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlCustomer.SelectedIndex > 0)
        {
            int iCustomerId = Convert.ToInt32(ddlCstpickDetails.SelectedValue);
        }
    }
    public class Years
    {
        public int YearId { get; set; }
        public string YearName { get; set; }
    }
    protected void BindClientWise()
    {
        gvClientwiseHeader.Style.Clear();
        gvClientwiseHeader.Style.Add("Style", "overflow: auto; padding-left: 0px; color: #4f4f4f; font-size: 12px; width: 98.6%;  line-height: 20px;display: none;");
        divgvClientwise.Style["display"] = "none";
        ViewState["Summaryclientwise"] = null;
        ViewState["SummaryDepartmentWise"] = null;
        gvClientwise.DataSource = null;
        gvClientwise.DataBind();
        int? iCustomerId;
        iCustomerId = null;
        int iActivityId=0;
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

        if (ddlCustomer.SelectedIndex > 0)
        {
            iCustomerId = Convert.ToInt32(ddlCustomer.SelectedItem.Value);    
        }
        //if (ddlActivity.SelectedIndex > 0)
        //{
        //    iActivityId = Convert.ToInt32(ddlActivity.SelectedValue);
        //}
        Entity.OtherServicesReport ObjOSReport =
            new Entity.OtherServicesReport
            {
                 ActivityId = iActivityId,
                CustomerId = 0,
                FromDate = dFromDate,
                ToDate = dToDate,
                IsSummary = 0
            };
        DataSet ds = objPRSMReportBAL.GetOtherServicesReport(ObjOSReport);
        if (ds != null)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                pnlExportype.Visible = true;
                if (ViewState["btnExpoert"] != null)
                {
               bool Isvisible = (bool)ViewState["btnExpoert"];
               btnExportToExcel.Visible = Isvisible;
                }
                
                ViewState["Summaryclientwise"] = ds.Tables[0];
                HttpContext.Current.Cache["Summaryclientwise"] = ds.Tables[0];
                HttpContext.Current.Cache["SummaryclientwiseSum"] = ds.Tables[1];
                divgvClientwise.Style["display"] = "block";
                gvClientwiseHeader.Style.Clear();
                gvClientwiseHeader.Style.Add("Style", "overflow: auto; padding-left: 0px; color: #4f4f4f; font-size: 12px; width: 98.6%;  line-height: 20px;display: block;");
                gvClientwise.Visible = true;
                gvClientwise.DataSource = ds.Tables[0];
                gvClientwise.DataBind();
            }
            else
            {
                pnlExportype.Visible = false;
                btnExportToExcel.Visible = false;
                divgvClientwise.Style["display"] = "none";
                gvClientwiseHeader.Style.Clear();
                gvClientwiseHeader.Style.Add("Style", "overflow: auto; padding-left: 0px; color: #4f4f4f; font-size: 12px; width: 98.6%;  line-height: 20px;display: none;");
                gvClientwise.DataSource = null;
                gvClientwise.DataBind();
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('No Record Found.')", true);
            }

        }
    }
    
    protected void btnview_Click(object sender, EventArgs e)
    {
        BindClientWise();
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
            string htmlReportFileter = "<table width='100%'> <tr> <td> Company Group :</td><td colspan='3'>" +ddlCompanyGroup.SelectedItem.Text+ " </td> </tr>";
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
            gvReport.RenderControl(hw);
            gvReport.ShowHeader = false;
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
            ////if (rdlstbtnReport.SelectedValue == "1")
            ////{
                DataTable dtOtherServices = new DataTable();
                if (ViewState["Summaryclientwise"] != null)
                {
                    IsExist = 1;
                    if (rdbtnlstReportType.SelectedItem.Text == "PDF")
                    {
                        GeneratePDF();
                    }
                    if (rdbtnlstReportType.SelectedItem.Text == "Excel")
                    {
                        dtOtherServices = (DataTable)ViewState["Summaryclientwise"];
                        ExportExcel(gvClientwise, dtOtherServices, "Other Services");
                    }
                }
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
    int TotalFaxlocal = 0;
    int TotalPhotocopy = 0;
    int TotalScanningEmail = 0;
    int TotalFaxSTD = 0;
    int TotallblDocsearchInse = 0;
    int TotalAuditRoomCharges = 0;
    int TotalFileAccess = 0;
    protected void gvClientwise_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblFaxlocal = (Label)e.Row.FindControl("lblFaxlocal");
            Label lblPhotocopy = (Label)e.Row.FindControl("lblPhotocopy");
            Label lblScanningEmail = (Label)e.Row.FindControl("lblScanningEmail");
            Label lblFaxSTD = (Label)e.Row.FindControl("lblFaxSTD");
            Label lblDocumentsearchingInsertion = (Label)e.Row.FindControl("lblDocumentsearchingInsertion");
            Label lblAuditRoomCharges = (Label)e.Row.FindControl("lblAuditRoomCharges");
            Label lblFileAccess = (Label)e.Row.FindControl("lblFileAccess");
            if (lblPhotocopy.Text == "")
            {
                lblPhotocopy.Text = "0";
            }
            else
            {
                TotalPhotocopy += Convert.ToInt32(lblPhotocopy.Text);
            }
            if (lblFaxlocal.Text == "")
            {
                lblFaxlocal.Text = "0";
            }
            else
            {
                 TotalFaxlocal += Convert.ToInt32(lblFaxlocal.Text);
            }

            if( lblScanningEmail.Text == "")
            {
                lblScanningEmail.Text = "0";
            }
            else
            {
                TotalScanningEmail += Convert.ToInt32(lblScanningEmail.Text);
            }
            if (lblFaxSTD.Text == "")
            {
                lblFaxSTD.Text = "0";
            }
            else
            {
                TotalFaxSTD += Convert.ToInt32(lblFaxSTD.Text);
            }
            if (lblDocumentsearchingInsertion.Text == "")
            {
                lblDocumentsearchingInsertion.Text = "0";
            }
            else
            {
                TotallblDocsearchInse +=Convert.ToInt32(lblDocumentsearchingInsertion.Text);
            }
            if (lblAuditRoomCharges.Text == "")
            {
                lblAuditRoomCharges.Text = "0";
            }
            else
            {
                TotalAuditRoomCharges += Convert.ToInt32(lblAuditRoomCharges.Text);
            }
            if (lblFileAccess.Text == "")
            {
                lblFileAccess.Text = "";

            }
            else
            {
                TotalFileAccess += Convert.ToInt32(lblFileAccess.Text);
            }

        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblFaxlocalF = (Label)e.Row.FindControl("lblFaxlocalF");
            lblFaxlocalF.Text = TotalFaxlocal.ToString();
            Label lblPhotocopyF = (Label)e.Row.FindControl("lblPhotocopyF");
            lblPhotocopyF.Text = TotalPhotocopy.ToString();
            Label lblScanningEmail = (Label)e.Row.FindControl("lblScanningEmail");
            lblScanningEmail.Text = TotalScanningEmail.ToString();
            Label lblFaxSTDF = (Label)e.Row.FindControl("lblFaxSTDF");
            lblFaxSTDF.Text = TotalFaxSTD.ToString();
            Label lblDocumentSearchingInsertionF = (Label)e.Row.FindControl("lblDocumentSearchingInsertionF");
            lblDocumentSearchingInsertionF.Text = TotallblDocsearchInse.ToString();
            Label lblAuditRoomCharges = (Label)e.Row.FindControl("lblAuditRoomCharges");
            lblAuditRoomCharges.Text = TotalAuditRoomCharges.ToString();
            Label lblFileAccess = (Label)e.Row.FindControl("lblFileAccess");
            lblFileAccess.Text = TotalFileAccess.ToString();
        }

    }

    protected void gvWorkorderwise_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblFaxlocal = (Label)e.Row.FindControl("lblFaxlocal");
            Label lblPhotocopy = (Label)e.Row.FindControl("lblPhotocopy");
            Label lblScanningEmail = (Label)e.Row.FindControl("lblScanningEmail");
            Label lblFaxSTD = (Label)e.Row.FindControl("lblFaxSTD");
            Label lblDocumentsearchingInsertion = (Label)e.Row.FindControl("lblDocumentsearchingInsertion");
            Label lblAuditRoomCharges = (Label)e.Row.FindControl("lblAuditRoomCharges");
            Label lblFileAccess = (Label)e.Row.FindControl("lblFileAccess");
            if (lblPhotocopy.Text == "")
            {
                lblPhotocopy.Text = "0";
            }
            else
            {
                TotalPhotocopy += Convert.ToInt32(lblPhotocopy.Text);
            }
            if (lblFaxlocal.Text == "")
            {
                lblFaxlocal.Text = "0";
            }
            else
            {
                TotalFaxlocal += Convert.ToInt32(lblFaxlocal.Text);
                ViewState["TotalFaxlocal"] = TotalFaxlocal;
            }

            if (lblScanningEmail.Text == "")
            {
                lblScanningEmail.Text = "0";
            }
            else
            {
                TotalScanningEmail += Convert.ToInt32(lblScanningEmail.Text);
            }
            if (lblFaxSTD.Text == "")
            {
                lblFaxSTD.Text = "0";
            }
            else
            {
                TotalFaxSTD += Convert.ToInt32(lblFaxSTD.Text);
            }
            if (lblDocumentsearchingInsertion.Text == "")
            {
                lblDocumentsearchingInsertion.Text = "0";
            }
            else
            {
                TotallblDocsearchInse += Convert.ToInt32(lblDocumentsearchingInsertion.Text);
            }
            if (lblAuditRoomCharges.Text == "")
            {
                lblAuditRoomCharges.Text = "0";
            }
            else
            {
                TotalAuditRoomCharges += Convert.ToInt32(lblAuditRoomCharges.Text);
            }
            if (lblFileAccess.Text == "")
            {
                lblFileAccess.Text = "";

            }
            else
            {
                TotalFileAccess += Convert.ToInt32(lblFileAccess.Text);
            }

        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblFaxlocalF = (Label)e.Row.FindControl("lblFaxlocalF");
            lblFaxlocalF.Text = TotalFaxlocal.ToString();
            Label lblPhotocopyF = (Label)e.Row.FindControl("lblPhotocopyF");
            lblPhotocopyF.Text = TotalPhotocopy.ToString();
            Label lblScanningEmail = (Label)e.Row.FindControl("lblScanningEmail");
            lblScanningEmail.Text = TotalScanningEmail.ToString();
            Label lblFaxSTDF = (Label)e.Row.FindControl("lblFaxSTDF");
            lblFaxSTDF.Text = TotalFaxSTD.ToString();
            Label lblDocumentSearchingInsertionF = (Label)e.Row.FindControl("lblDocumentSearchingInsertionF");
            lblDocumentSearchingInsertionF.Text = TotallblDocsearchInse.ToString();
            Label lblAuditRoomCharges = (Label)e.Row.FindControl("lblAuditRoomCharges");
            lblAuditRoomCharges.Text = TotalAuditRoomCharges.ToString();
            Label lblFileAccess = (Label)e.Row.FindControl("lblFileAccess");
            lblFileAccess.Text = TotalFileAccess.ToString();
        }

    }
  
    protected void GrdFileDetailsWorkOrderNoWise_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblFaxlocal = (Label)e.Row.FindControl("lblFaxlocal");
            Label lblPhotocopy = (Label)e.Row.FindControl("lblPhotocopy");
            Label lblScanningEmail = (Label)e.Row.FindControl("lblScanningEmail");
            Label lblFaxSTD = (Label)e.Row.FindControl("lblFaxSTD");
            Label lblDocumentsearchingInsertion = (Label)e.Row.FindControl("lblDocumentsearchingInsertion");
            Label lblAuditRoomCharges = (Label)e.Row.FindControl("lblAuditRoomCharges");
            Label lblFileRetrieval = (Label)e.Row.FindControl("lblFileRetrieval");
            LinkButton lbtnFileRetrieval = (LinkButton)e.Row.FindControl("lbtnFileRetrieval");

            if (lbtnFileRetrieval.Text.ToString() == "0")
            {
                lbtnFileRetrieval.Visible = false;
                lblFileRetrieval.Visible = true;
            }
            else
            {
                lblFileRetrieval.Visible = false;
                lbtnFileRetrieval.Visible = true;
            }
            
            if (lblPhotocopy.Text == "")
            {
                lblPhotocopy.Text = "0";
            }
            else
            {
                TotalPhotocopy += Convert.ToInt32(lblPhotocopy.Text);
            }
            if (lblFaxlocal.Text == "")
            {
                lblFaxlocal.Text = "0";
            }
            else
            {
                TotalFaxlocal += Convert.ToInt32(lblFaxlocal.Text);
            }

            if (lblScanningEmail.Text == "")
            {
                lblScanningEmail.Text = "0";
            }
            else
            {
                TotalScanningEmail += Convert.ToInt32(lblScanningEmail.Text);
            }
            if (lblFaxSTD.Text == "")
            {
                lblFaxSTD.Text = "0";
            }
            else
            {
                TotalFaxSTD += Convert.ToInt32(lblFaxSTD.Text);
            }
            if (lblDocumentsearchingInsertion.Text == "")
            {
                lblDocumentsearchingInsertion.Text = "0";
            }
            else
            {
                TotallblDocsearchInse += Convert.ToInt32(lblDocumentsearchingInsertion.Text);
            }
            if (lblAuditRoomCharges.Text == "")
            {
                lblAuditRoomCharges.Text = "0";
            }
            else
            {
                TotalAuditRoomCharges += Convert.ToInt32(lblAuditRoomCharges.Text);
            }
            if (lblFileRetrieval.Text == "")
            {
                lblFileRetrieval.Text = "";

            }
            else
            {
                TotalFileAccess += Convert.ToInt32(lblFileRetrieval.Text);
            }
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblFaxlocalF = (Label)e.Row.FindControl("lblFaxlocalF");
            lblFaxlocalF.Text = TotalFaxlocal.ToString();
            Label lblPhotocopyF = (Label)e.Row.FindControl("lblPhotocopyF");
            lblPhotocopyF.Text = TotalPhotocopy.ToString();
            Label lblScanningEmail = (Label)e.Row.FindControl("lblScanningEmail");
            lblScanningEmail.Text = TotalScanningEmail.ToString();
            Label lblFaxSTDF = (Label)e.Row.FindControl("lblFaxSTDF");
            lblFaxSTDF.Text = TotalFaxSTD.ToString();
            Label lblDocumentSearchingInsertionF = (Label)e.Row.FindControl("lblDocumentSearchingInsertionF");
            lblDocumentSearchingInsertionF.Text = TotallblDocsearchInse.ToString();
            Label lblAuditRoomCharges = (Label)e.Row.FindControl("lblAuditRoomCharges");
            lblAuditRoomCharges.Text = TotalAuditRoomCharges.ToString();
            Label lblFileAccess = (Label)e.Row.FindControl("lblFileAccess");
            lblFileAccess.Text = TotalFileAccess.ToString();
        }

        
    }

    
    protected void GrdFileDetailsWorkOrderDateWise_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblFaxlocal = (Label)e.Row.FindControl("lblFaxlocal");
            Label lblPhotocopy = (Label)e.Row.FindControl("lblPhotocopy");
            Label lblScanningEmail = (Label)e.Row.FindControl("lblScanningEmail");
            Label lblFaxSTD = (Label)e.Row.FindControl("lblFaxSTD");
            Label lblDocumentsearchingInsertion = (Label)e.Row.FindControl("lblDocumentsearchingInsertion");
            Label lblAuditRoomCharges = (Label)e.Row.FindControl("lblAuditRoomCharges");
            Label lblFileRetrieval = (Label)e.Row.FindControl("lblFileRetrieval");
            LinkButton lbtnFileRetrieval = (LinkButton)e.Row.FindControl("lbtnFileRetrieval");
            if (lbtnFileRetrieval.Text.ToString() == "0")
            {
                lbtnFileRetrieval.Visible = false;
                lblFileRetrieval.Visible = true;
            }
            else
            {
                lblFileRetrieval.Visible = false;
                lbtnFileRetrieval.Visible = true;
            }

            if (lblPhotocopy.Text == "")
            {
                lblPhotocopy.Text = "0";
            }
            else
            {
                TotalPhotocopy += Convert.ToInt32(lblPhotocopy.Text);
                
            }
            if (lblFaxlocal.Text == "")
            {
                lblFaxlocal.Text = "0";
            }
            else
            {
                TotalFaxlocal += Convert.ToInt32(lblFaxlocal.Text);
            }

            if (lblScanningEmail.Text == "")
            {
                lblScanningEmail.Text = "0";
            }
            else
            {
                TotalScanningEmail += Convert.ToInt32(lblScanningEmail.Text);
            }
            if (lblFaxSTD.Text == "")
            {
                lblFaxSTD.Text = "0";
            }
            else
            {
                TotalFaxSTD += Convert.ToInt32(lblFaxSTD.Text);
            }
            if (lblDocumentsearchingInsertion.Text == "")
            {
                lblDocumentsearchingInsertion.Text = "0";
            }
            else
            {
                TotallblDocsearchInse += Convert.ToInt32(lblDocumentsearchingInsertion.Text);
            }
            if (lblAuditRoomCharges.Text == "")
            {
                lblAuditRoomCharges.Text = "0";
            }
            else
            {
                TotalAuditRoomCharges += Convert.ToInt32(lblAuditRoomCharges.Text);
            }
            if (lblFileRetrieval.Text == "")
            {
                lblFileRetrieval.Text = "";

            }
            else
            {
                TotalFileAccess += Convert.ToInt32(lblFileRetrieval.Text);
            }

        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblFaxlocalF = (Label)e.Row.FindControl("lblFaxlocalF");
            lblFaxlocalF.Text = TotalFaxlocal.ToString();
            Label lblPhotocopyF = (Label)e.Row.FindControl("lblPhotocopyF");
            lblPhotocopyF.Text = TotalPhotocopy.ToString();
            Label lblScanningEmail = (Label)e.Row.FindControl("lblScanningEmail");
            lblScanningEmail.Text = TotalScanningEmail.ToString();
            Label lblFaxSTDF = (Label)e.Row.FindControl("lblFaxSTDF");
            lblFaxSTDF.Text = TotalFaxSTD.ToString();
            Label lblDocumentSearchingInsertionF = (Label)e.Row.FindControl("lblDocumentSearchingInsertionF");
            lblDocumentSearchingInsertionF.Text = TotallblDocsearchInse.ToString();
            Label lblAuditRoomCharges = (Label)e.Row.FindControl("lblAuditRoomCharges");
            lblAuditRoomCharges.Text = TotalAuditRoomCharges.ToString();
            Label lblFileAccess = (Label)e.Row.FindControl("lblFileAccess");
            lblFileAccess.Text = TotalFileAccess.ToString();
        }

    }


    protected void lnkbtnclose_Click(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "HidedivContract();", true);
    }

    protected void rdlstbtnReport_SelectedIndexChanged(object sender, EventArgs e)
    {
        ClearFileSummary();
         gvClientwiseHeader.Style.Clear();
         gvClientwiseHeader.Style.Add("Style", "overflow: auto; padding-left: 0px; color: #4f4f4f; font-size: 12px; width: 98.6%;  line-height: 20px;display: none;");
          gvClientwise.DataSource = null;
           gvClientwise.DataBind();
            gvClientwise.DataSource = null;
            gvClientwise.DataBind();
            divgvClientwise.Style["display"] = "block";
            ddlCompanyGroup.Enabled = false;
            ddlCustomer.Enabled = false;
    }

    protected void lnkbtnFilePickUp_Click(object sender, EventArgs e)
    {

        ClearDate();
        FilePickUpSummary();
    }
    protected void lnkbtnFilePickUpdetails_Click(object sender, EventArgs e)
    {
        pnlReportType.Visible = false;
        pnlExportype.Visible = false;
        FilePickUpDetails();
    }
    protected void ddlCgpickDetails_SelectedIndexChanged(object sender, EventArgs e)
    {
        GrdFileDetailsWorkOrderNoWise.DataSource = null;
        GrdFileDetailsWorkOrderNoWise.DataBind();
        GrdFileDetailsWorkOrderDateWise.DataSource = null;
        GrdFileDetailsWorkOrderDateWise.DataBind();
        btnExportDetails.Visible = false; 
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
        pnlExportype.Visible = false;
        pnlReportType.Visible = false;
        txtfromDate.Text = "";
        txttodate.Text = "";
        txtToDatepickDetials.Text = "";
       // rdbtnlstOSDetails.SelectedIndex = 0;
        //rdbtnFilePickDetails.SelectedIndex = 0;
        txtFromDatepickDetials.Text = "";
        txtToDatepickDetials.Text = string.Empty;
        ddlCgpickDetails.SelectedIndex = 0;
        ddlCompanyGroup.SelectedIndex = 0;
        ddlCustomer.SelectedIndex = 0;
        //ddlCstpickDetails.SelectedIndex = 0;
    }
    protected void clearViewStateandGrids()
    {
      gvClientwise.DataSource = null;
      gvClientwise.DataBind();
        GrdFileDetailsWorkOrderNoWise.DataSource = null;
        GrdFileDetailsWorkOrderNoWise.DataBind();
        GrdFileDetailsWorkOrderDateWise.DataSource = null;
        GrdFileDetailsWorkOrderDateWise.DataBind();
        ViewState["Summaryclientwise"] = null;
        ViewState["SummaryDepartmentWise"] = null;
        ViewState["FilePickUpdetailsWorkOrderNumberWise"] = null;
        ViewState["FilePickUpdetailsWorkOrdeDateWise"] = null;
    }
    protected void rdbtnFilePickDetails_SelectedIndexChanged(object sender, EventArgs e)
    {
        ClearDate();
        //ClearGrid();
        btnExportDetails.Visible = false; 
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
            GrdFileDetailsWorkOrderDateWise .DataSource = null;
            GrdFileDetailsWorkOrderDateWise .DataBind();
            ddlCstpickDetails.SelectedIndex = 0;
            ddlCgpickDetails.SelectedIndex = 0;
            DivGrdFileDetailsWorkOrderNoWise.Style["display"] = "none";
            DivGrdFileDetailsWorkOrderDateWise.Style["display"] = "block";
        }
    }

    protected void BindWorkOrderNumberWise()
    {
        GrdFileDetailsWorkOrderNoWise.DataSource = null;
        GrdFileDetailsWorkOrderNoWise.DataBind();
        GrdFileDetailsWorkOrderDateWise.DataSource = null;
        GrdFileDetailsWorkOrderDateWise.DataBind();
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

        Entity.OtherServicesReport ObjFilePickUpReport =
            new Entity.OtherServicesReport
            {
                ActivityId = 0,
                CustomerId = iCustomerId,
                FromDate = dFromDate,
                ToDate = dToDate,
                IsSummary=1

            };
        DataSet ds = objPRSMReportBAL.GetOtherServicesReport(ObjFilePickUpReport);
        if (ds != null)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                pnlReportType.Visible = true;
                btnExportDetails.Visible = true;
                ViewState["FilePickUpdetailsWorkOrderNumberWise"] = ds.Tables[0];
                HttpContext.Current.Cache["FilePickUpdetailsWorkOrderNumberWise"] = ds.Tables[0];
                HttpContext.Current.Cache["FilePickUpdetailsWorkOrderNumberWiseSum"] = ds.Tables[1];
                GrdFileDetailsWorkOrderNoWise.DataSource = ds.Tables[0];
                GrdFileDetailsWorkOrderNoWise.DataBind();
            }
            else
            {
                pnlReportType.Visible = false;
                btnExportDetails.Visible = false ;
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('No Record Found.')", true);
            }

        }
    }
    protected void BindWorkOrderDateWise()
    {
        DateTime? dFromDate;
        DateTime? dToDate;
        GrdFileDetailsWorkOrderNoWise.DataSource = null;
        GrdFileDetailsWorkOrderNoWise.DataBind();
        GrdFileDetailsWorkOrderDateWise.DataSource = null;
        GrdFileDetailsWorkOrderDateWise.DataBind();
        if (txtFromDatepickDetials.Text == "")
            dFromDate = null;
        else
            dFromDate = Convert.ToDateTime(txtFromDatepickDetials.Text.ToString(), enGB);
        if (txtToDatepickDetials.Text == "")
            dToDate = null;
        else
            dToDate = Convert.ToDateTime(txtToDatepickDetials.Text.ToString(), enGB);
        Entity.OtherServicesReport ObjFilePickUpReport =
            new Entity.OtherServicesReport
            {
                ActivityId = 0,
                CustomerId =  Convert.ToInt32(ddlCstpickDetails.SelectedValue),
                FromDate = dFromDate,
                ToDate = dToDate,
                IsSummary=1

            };
        DataSet ds = objPRSMReportBAL.GetOtherServicesReport(ObjFilePickUpReport);
        if (ds != null)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                pnlReportType.Visible = true;
                btnExportDetails.Visible = true;
                ViewState["FilePickUpdetailsWorkOrdeDateWise"] = ds.Tables[0];
                HttpContext.Current.Cache["FilePickUpdetailsWorkOrdeDateWise"] = ds.Tables[0];
                HttpContext.Current.Cache["FilePickUpdetailsWorkOrdeDateWiseSum"] = ds.Tables[1];
                GrdFileDetailsWorkOrderDateWise.DataSource = ds.Tables[0];
                GrdFileDetailsWorkOrderDateWise.DataBind();
            }
            else
            {
                pnlReportType.Visible = false;
                btnExportDetails.Visible = false;
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('No Record Found.')", true);
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
                if (ViewState["FilePickUpdetailsWorkOrderNumberWise"] != null)
                {
                    IsExist = 2;
                    if (rdbtnlstOSDetails.SelectedItem.Text == "PDF")
                    {
                        GeneratePDF();
                    }
                    if (rdbtnlstOSDetails.SelectedItem.Text == "Excel")
                    {
                        WorkOrderNoWise = (DataTable)ViewState["FilePickUpdetailsWorkOrderNumberWise"];
                        ExportExcel(GrdFileDetailsWorkOrderNoWise, WorkOrderNoWise, "Work Order No. Wise");
                    }
                  
                }

            }

            else
            {
                DataTable WorkOrderdateWise = new DataTable();
                if (ViewState["FilePickUpdetailsWorkOrdeDateWise"] != null)
                {
                    IsExist = 3;
                    if (rdbtnlstOSDetails.SelectedItem.Text == "PDF")
                    {
                        GeneratePDF();
                    }
                    if (rdbtnlstOSDetails.SelectedItem.Text == "Excel")
                    {
                        WorkOrderdateWise = (DataTable)ViewState["FilePickUpdetailsWorkOrdeDateWise"];
                        ExportExcel(GrdFileDetailsWorkOrderDateWise, WorkOrderdateWise, "Work Order Date Wise");
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
        //DataTable dtPageId = objUserRoleWiseAcessDAL.GetApplicationCodeDetails("Page_Name", "Other Services Report").Tables[0];
        DataTable dtPageId = objUserRoleWiseAcessDAL.GetApplicationCodeDetails("Page_Name", "Other Services").Tables[0];
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
                    PageFuncationality = Convert.ToString(dtPagefuncationality.Rows[i]["Functionality"]).Trim();
                    switch (PageFuncationality)
                    {
                        case "View":
                            btnview.Visible = true;
                            btnViewPickDetails.Visible = true;
                            break;
                        case "View Details":
                            btnViewPickDetails.Visible = true;
                            break;
                        case "Export To Excel":
                            ViewState["btnExpoert"] = true;
                            break;
                        case "Export To Excel Details":
                            ViewState["btnExpoertDetails"] = true;
                            break;
                        default:
                            break;
                    }
                }
            }
        }
    }
    #endregion
    protected void ClearFileSummary()
    {
        if (ddlCompanyGroup.Items.Count > 0)
        {
            ddlCompanyGroup.SelectedIndex = 0;
        }
        ddlCustomer.Items.Clear();
        ddlCustomer.DataSource = null;
        ddlCustomer.DataBind();
        ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        txtfromDate.Text = "";
        txttodate.Text = "";
        ViewState["Summaryclientwise"] = null;
        ViewState["SummaryDepartmentWise"] = null;
        gvClientwiseHeader.Style.Clear();
        gvClientwiseHeader.Style["style"] = "overflow: auto; padding-left: 0px; color: #4f4f4f; font-size: 12px; width: 98.6%;  line-height: 20px;display: none;";
        gvClientwise.DataSource = null;
        gvClientwise.DataBind();
        btnExportToExcel.Visible = false; 
    }
    protected void ClearFileDetails()
    {
        pnlReportType.Visible = false;
        if (ddlCgpickDetails.Items.Count > 0)
        {
            ddlCgpickDetails.SelectedIndex = 0;
        }
         ddlCstpickDetails.Items.Clear();
        ddlCstpickDetails.DataSource = null;
        ddlCstpickDetails.DataBind();
        ddlCstpickDetails.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        txtFromDatepickDetials.Text ="";
        txtToDatepickDetials.Text ="";
        ViewState["FilePickUpdetailsWorkOrderNumberWise"] = null;
        ViewState["FilePickUpdetailsWorkOrdeDateWise"] = null;
        GrdFileDetailsWorkOrderNoWise.DataSource = null;
         GrdFileDetailsWorkOrderNoWise.DataBind();
         GrdFileDetailsWorkOrderDateWise.DataSource = null;
         GrdFileDetailsWorkOrderDateWise.DataBind();
         btnExportDetails.Visible = false;  
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        pnlExportype.Visible = false;
        gvClientwiseHeader.Style["style"] = "overflow: auto; padding-left: 0px; color: #4f4f4f; font-size: 12px; width: 98.6%;  line-height: 20px;display: none;";
        ClearFileSummary();
    }
    protected void btncancelfiledetails_Click(object sender, EventArgs e)
    {
        ClearFileDetails();
    }
   

    protected void GeneratePDF()
    {
        DateTime? dFromDate;
        DateTime? dToDate;
        if (IsExist == 2 || IsExist == 3)
        {
            if (txtFromDatepickDetials.Text == "")
                dFromDate = Convert.ToDateTime("01-01-1900");
            else
                dFromDate = Convert.ToDateTime(txtFromDatepickDetials.Text.ToString(), enGB);
            if (txtToDatepickDetials.Text == "")
                dToDate = DateTime.Now;
            else
                dToDate = Convert.ToDateTime(txtToDatepickDetials.Text.ToString(), enGB);
        }
        else
        {
            if (txtfromDate.Text == "")
                dFromDate = Convert.ToDateTime("01-01-1900");
            else
                dFromDate = Convert.ToDateTime(txtfromDate.Text.ToString(), enGB);
            if (txttodate.Text == "")
                dToDate = DateTime.Now;
            else
                dToDate = Convert.ToDateTime(txttodate.Text.ToString(), enGB);
        }

        Director director = new Director();
        //IBuilder b1 = new ConcreteBuilder();
        ConcreteBuilder b1 = new ConcreteBuilder();
        b1.CompanyGroupId = Convert.ToInt32(ddlCompanyGroup.SelectedValue);
        b1.CustomerId = Convert.ToInt32(ddlCstpickDetails.SelectedValue);
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

            ErrorHandler.WriteLog(ex); ;
        }
    }

    class Director
    {
        // Builder uses a complex series of steps 
        public void Construct(IBuilder builder)
        {
            builder.BuildOtherServices();
        }
    }

    public interface IBuilder
    {
        void BuildOtherServices();
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
            string FileName = IsExist == 1 ? "OtherServicesSummary" : "OtherServicesDetails";
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
        const string FullFilePath = "~/Reports/OtherServices.htm";
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

        DataTable GetOtherServices(Int16 WOActivityId, int ICustId,Byte IsSummary)
        {
           
            DataTable dtOtherServices = new DataTable();
            if (IsExist == 1)
            {
                if (HttpContext.Current.Cache["Summaryclientwise"] != null)
                {
                    dtOtherServices = (DataTable)HttpContext.Current.Cache["Summaryclientwise"];
                }
            }
            if (IsExist == 2)
            {
                if (HttpContext.Current.Cache["FilePickUpdetailsWorkOrderNumberWise"] != null)
                {
                    dtOtherServices = (DataTable)HttpContext.Current.Cache["FilePickUpdetailsWorkOrderNumberWise"];
                }
            }

            if (IsExist == 3)
            {
                if (HttpContext.Current.Cache["FilePickUpdetailsWorkOrdeDateWise"] != null)
                {
                    dtOtherServices = (DataTable)HttpContext.Current.Cache["FilePickUpdetailsWorkOrdeDateWise"];
                }
            }

            return dtOtherServices;
        }

        DataTable GetNoServiceCount(Int16 WOActivityId, int ICustId, Byte IsSummary)
        {
            DataTable dtOtherService = new DataTable();
            if (IsExist == 1)
            {
                if (HttpContext.Current.Cache["SummaryclientwiseSum"] != null)
                {
                    dtOtherService =(DataTable) HttpContext.Current.Cache["SummaryclientwiseSum"];
                }
            }
            return dtOtherService;
        }

        DataTable GetNoOfServiceCountDetails(Int16 WOActivityId, int ICustId, Byte IsSummary)
        {
            DataTable dtOtherService = new DataTable();
            if (IsExist == 2)
            {
                if (HttpContext.Current.Cache["FilePickUpdetailsWorkOrderNumberWiseSum"] != null)
                {
                    dtOtherService = (DataTable)HttpContext.Current.Cache["FilePickUpdetailsWorkOrderNumberWiseSum"];
                }
            }

            if (IsExist == 3)
            {
                if (HttpContext.Current.Cache["FilePickUpdetailsWorkOrdeDateWiseSum"] != null)
                {
                    dtOtherService = (DataTable)HttpContext.Current.Cache["FilePickUpdetailsWorkOrdeDateWiseSum"];
                }
            }

            return dtOtherService;
        }

        public void BuildOtherServices()
        {
            product.Initlize();
            iTextSharp.text.pdf.PdfPTable TableServiceCompt = null;
            Int16 WOActivityId = 0;
            Byte IsSummary = 0;
           
            if (IsExist == 1)
            {
                IsSummary=0;
                TableServiceCompt = ObjPdfTAbles.GetOtherServicesReportSummary(GetOtherServices(WOActivityId, CustomerId, IsSummary), GetNoServiceCount(WOActivityId, CustomerId, IsSummary));
            }
            if (IsExist == 2)
            {
                IsSummary = 1;
                TableServiceCompt = ObjPdfTAbles.GetOtherServicesReportWONo(GetOtherServices(WOActivityId, CustomerId, IsSummary), GetNoOfServiceCountDetails(WOActivityId, CustomerId, IsSummary));
            }
            if (IsExist == 3)
            {
                IsSummary = 1;
                TableServiceCompt = ObjPdfTAbles.GetOtherServicesReportWoDateWise(GetOtherServices(WOActivityId, CustomerId, IsSummary), GetNoOfServiceCountDetails(WOActivityId, CustomerId, IsSummary));
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
}


