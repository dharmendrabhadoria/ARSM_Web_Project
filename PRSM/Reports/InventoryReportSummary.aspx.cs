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
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;

public partial class InventoryReportSummary : PageBase
{
    private System.Globalization.CultureInfo enGB = new System.Globalization.CultureInfo("en-GB");
    public static PRSMBAL.MasterBAL objPRSMBAL = new MasterBAL();
    public static PRSMBAL.TransactionBAL objTRANSBAL = new TransactionBAL();
    PageBase objPageBase = new PageBase();
    public static PRSMBAL.MasterBAL objstPRSMBAL = new MasterBAL();
    public static PRSMBAL.TransactionBAL objTRANSStBAL = new TransactionBAL();
    public PRSMBAL.ReportBAL objPRSMReportBAL = new ReportBAL();
    ReportBAL objPRSMReportInvBAL = new ReportBAL();
    InventryReportAsOnDate objPRSMInv = new InventryReportAsOnDate();
    DataSet ds;
    private GetPDFTables ObjPdfTAbles = new GetPDFTables();
    private Product product = new Product();
    public static int IsExist { get; set; }

    int CustomerId = 0;
    int Year = 0;
    string CommandName = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetInventoryData();
            int CompanyId = 0;
            BindCompanyGroup(CompanyId);
            lnkbtnInventorySummary.Style["color"] = "blue !important;";
            lnkbtnInventoryDeatils.Style["color"] = "#4f4f4f !important;";
                       
        }
    }
    #region [GetData for Summary and Details]
    private void GetInventoryData()
    {
        SetRolewiseAcessfuncationality();
        objPRSMInv.Report_type = 1;
        objPRSMInv.WareHouseId = 1;
        objPRSMInv.Year = 0;
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

        objPRSMInv.FromDate = dFromDate;
        objPRSMInv.ToDate = dToDate;
        lb1Message.Visible = false;
        lblyear.Visible = false;
        ddlyears.Visible = false;
        lb1Message.Text = "";
        if (ddlCustomer.SelectedIndex != -1)
        {
            objPRSMInv.CustomerID = Convert.ToInt32(ddlCustomer.SelectedValue);
        }
        ds = objPRSMReportInvBAL.GetInventoryDataAsOnDate(objPRSMInv);
        if (ds.Tables[0].Rows.Count > 0)
        {
            pnlExportype.Visible = true;
            Session["InventoryData"] = ds.Tables[0];
            HttpContext.Current.Cache["InventoryData"] = ds.Tables[0];
            HttpContext.Current.Cache["InventoryDataSum"] = ds.Tables[1];
            btnExportToExcel.Visible = true;
            gvInventoryReport.DataSource = ds;
            gvInventoryReport.DataBind();
            AsOnDateGrid.Style["display"] = "";
        }
        else
        {
            pnlExportype.Visible = false;
            btnExportToExcel.Visible = false;
            gvInventoryReport.DataSource = null;
            gvInventoryReport.DataBind();            
            lb1Message.Visible = true;
            lb1Message.Text = "No Data Found";
            Session["InventoryData"] = null;
        }

        AsOnDateGrid.Visible = true;
        gvInventoryReport.Visible = true;
        lblyear.Visible = false;
        ddlyears.Visible = false;
    }

    private void GetInventoryYearWise()
    {
        SetRolewiseAcessfuncationality();
        objPRSMInv.Report_type = 3;
        objPRSMInv.WareHouseId = 1;
        objPRSMInv.Year = Convert.ToInt16(ddlyears.SelectedItem.Value);
        if (ddlCustomer.SelectedValue == "")
        {
            objPRSMInv.CustomerID = 0;
        }
        else
        {
            objPRSMInv.CustomerID = Convert.ToInt32(ddlCustomer.SelectedValue);
        }
        lblyear.Visible = false;
        ddlyears.Visible = true;
        DataSet ds = objPRSMReportInvBAL.GetInventoryDataAsOnDate(objPRSMInv);
        if (ds.Tables[0].Rows.Count > 0)
        {
            pnlExportype.Visible = true;
            btnExportToExcel.Visible = true;
            Session["InventoryReportYearWise"] = ds.Tables[0];
            HttpContext.Current.Cache["InventoryReportYearWise"] = ds.Tables[0];
           // HttpContext.Current.Cache["InventoryReportYearWiseSum"] = ds.Tables[1];
            divgvIventoryYear.Style["display"] = "";
            lb1Message.Text = "";
            gvSummaryYear.Visible = true;
            gvSummaryYear.DataSource = ds;
            gvSummaryYear.DataBind();
            gvInventoryReport.DataSource = null;
            gvInventoryReport.DataBind();
            gvSummaryDept.DataSource = null;
            gvSummaryDept.DataBind();

            Session["InventoryData"] = null;
            Session["InventoryDataDeptWise"] = null;
        }
        else
        {
            pnlExportype.Visible = false;
            btnExportToExcel.Visible = false;
            gvSummaryYear.DataSource = null;
            gvSummaryYear.DataBind();
            lb1Message.Visible = true;
            lb1Message.Text = "No Data Found";

            Session["InventoryReportYearWise"] = null;
        }
    }
    protected void btnViewClear_Click(object sender, EventArgs e)
    {
        ddlCompanyGroup.SelectedIndex = 0;
        ddlCustomer.SelectedIndex = 0;
        ddlyears.SelectedIndex = 0;
        txtfromDate.Text = string.Empty;
        txttodate.Text = string.Empty;
        pnlExportype.Visible = false;
        gvInventoryDetail.DataSource = null;
        gvInventoryDetail.DataBind();
        gvInventoryReport.DataSource = null;
        gvInventoryReport.DataBind();
        gvSummaryYear.DataSource = null;
        gvSummaryYear.DataBind();

        Session["InventoryData"] = null;
        Session["InventoryReportYearWise"] = null;

    }

    private void GetInventoryDepartMentwise()
    {
        SetRolewiseAcessfuncationality();
        btnview.Visible = true;
        objPRSMInv.Report_type = 2;
        objPRSMInv.WareHouseId = 1;
        objPRSMInv.Year = 0;// Convert.ToInt16(ddlyears.SelectedItem.Value);   
        objPRSMInv.CustomerID = Convert.ToInt32(ddlCustomer.SelectedValue);
        DateTime? dFromDate;
        DateTime? dToDate;
        lb1Message.Text = "";
        if (txtfromDate.Text == "")
            dFromDate = null;
        else
            dFromDate = Convert.ToDateTime(txtfromDate.Text.ToString(), enGB);
        if (txttodate.Text == "")
            dToDate = null;
        else
            dToDate = Convert.ToDateTime(txttodate.Text.ToString(), enGB);

        objPRSMInv.FromDate = dFromDate;
        objPRSMInv.ToDate = dToDate;

        ds = objPRSMReportInvBAL.GetInventoryDataAsOnDate(objPRSMInv);
       
        if (ds.Tables[0].Rows.Count > 0)
        {
            Session["InventoryDataDeptWise"] = ds.Tables[0];
            btnExportToExcel.Visible = true;
            divgvInventoryDept.Style["display"] = "";
            gvSummaryDept.Visible = true;
            gvSummaryDept.DataSource = ds;
            gvSummaryDept.DataBind();
            gvInventoryReport.DataSource = null;
            gvInventoryReport.DataBind();
            gvSummaryYear.DataSource = null;
            gvSummaryYear.DataBind();

            Session["InventoryData"] = null;
            Session["InventoryReportYearWise"] = null;
        }
        else
        {
            btnExportToExcel.Visible = false;
            gvSummaryDept.DataSource = null;
            gvSummaryDept.DataBind();
            lb1Message.Visible = true;
            lb1Message.Text = "No Data Found";
            Session["InventoryDataDeptWise"] = null;
        }


    }
    private void GetInventoryDetailData()
    {
        objPRSMInv.Report_type = 4;
        objPRSMInv.WareHouseId = 1;
        objPRSMInv.Year = Convert.ToInt16(ddlyears.SelectedItem.Value);
        lb1Message.Text = "";
        if (ddlCustomer.SelectedValue == "")
        {
            objPRSMInv.CustomerID = 0;
        }
        else
        {
            objPRSMInv.CustomerID = Convert.ToInt32(ddlCustomer.SelectedValue);
        }
        //if (ddlCustomer.SelectedValue == "0")
        //{
        //    lb1Message.Visible = true;
        //    lb1Message.Text = "Please Select Customer";
        //}
        
        ds = objPRSMReportInvBAL.GetInventoryDataAsOnDate(objPRSMInv);
        if (ds.Tables[0].Rows.Count > 0)
        {
            pnlExportype.Visible = true;
            Session["InventoryDetails"] = ds.Tables[0];
            HttpContext.Current.Cache["InventoryDetailsSum"] = ds.Tables[1];
            HttpContext.Current.Cache["InventoryDetails"] = ds.Tables[0];
            btnExportToExcel.Visible = true;
            gvInventoryDetail.Visible = true;
            gvInventoryDetail.DataSource = ds;
            gvInventoryDetail.DataBind();
            divInventorySummaryDetails.Style["display"] = "";
            //lblmessage.Visible = false;
        }
        else
        {
            pnlExportype.Visible = false;
            btnExportToExcel.Visible = false;
            gvInventoryDetail.DataSource = null;
            gvInventoryDetail.DataBind();
            lb1Message.Visible = true;
            lb1Message.Text = "No Data Found";
        }

    }
    #endregion
    protected void ClearAllGrid()
    {
        btnExportToExcel.Visible = false;
        gvInventoryReport.DataSource = null;
        gvInventoryReport.DataBind();
        gvSummaryDept.DataSource = null;
        gvSummaryDept.DataBind();
        gvSummaryYear.DataSource = null;
        gvSummaryYear.DataBind();
        AsOnDateGrid.Style["display"] = "none";
        divgvInventoryDept.Style["display"] = "none";
        divgvIventoryYear.Style["display"] = "none";

        Session["InventoryData"] = null;
        Session["InventoryDataDeptWise"] = null;
        Session["InventoryReportYearWise"] = null;

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
        ddlCustomer.DataSource = objPRSMBAL.GetCustomer(iCompanyId);
        ddlCustomer.DataValueField = "CustomerId";
        ddlCustomer.DataTextField = "CustomerName";
        ddlCustomer.DataBind();
        ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });

    }
    protected void ddlCompanyGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlCompanyGroup.SelectedIndex > 0)
        {
            BindCustomer(Convert.ToByte(ddlCompanyGroup.SelectedItem.Value));
        }
        else
        {
            ddlyears.SelectedIndex = 0;
            ddlCustomer.Items.Clear();
            ddlCustomer.DataSource = null;
            ddlCustomer.DataBind();
            gvInventoryReport.DataSource = null;
            gvInventoryReport.DataBind();
            ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            Session["InventoryData"] = null;
        }
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
            string htmlReportFileter = "<table width='100%'> <tr> <td> Company Group :</td><td colspan='3'>" + " </td> </tr>";
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
                        if (cell.Controls.Count >= 1)
                        {
                            if (cell.Controls[1] != null && cell.Controls[1] is System.Web.UI.WebControls.LinkButton)
                            {
                                string cellControlText = ((System.Web.UI.WebControls.LinkButton)cell.Controls[1]).Text;
                                cell.Controls.Remove(cell.Controls[1]);
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
            //style to format numbers to string
            string style = @"<style> .textmode { } </style>";
            Response.Write(style);
            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();

        }
    }
    public class Years
    {
        public int YearId { get; set; }
        public string YearName { get; set; }
    }

    protected void btnExportToExcel_Click(object sender, EventArgs e)
    {
            DataTable dtsummaryClientwise = new DataTable();
            if (rdlstbtnReport.SelectedValue == "1")
            {
                Session["InventoryReportYearWise"] = null;
                IsExist = 1;
                if (Session["InventoryData"] != null)
                {
                    if (rdbtnlstReportType.SelectedItem.Text == "PDF")
                    {
                        GeneratePDF();
                    }
                    if (rdbtnlstReportType.SelectedItem.Text == "Excel")
                    {
                        dtsummaryClientwise = (DataTable)Session["InventoryData"];
                        ExportExcel(gvInventoryReport, dtsummaryClientwise, "InventorySummary");
                    }
           }

        }

           if (rdlstbtnReport.SelectedValue == "3")
            {
                Session["InventoryData"] = null;

                if (Session["InventoryReportYearWise"] != null)
                {
                    IsExist = 3;
                    if (rdbtnlstReportType.SelectedItem.Text == "PDF")
                    {
                        GeneratePDF();
                    }
                    if (rdbtnlstReportType.SelectedItem.Text == "Excel")
                    {
                        dtsummaryClientwise = (DataTable)Session["InventoryReportYearWise"];
                        ExportExcel(gvSummaryYear, dtsummaryClientwise, "InventorySummary");
                    }
            }

        }

        if (Session["InventoryDetails"] != null)
        {
            Session["InventoryData"] = null;
            Session["InventoryReportYearWise"] = null;
            IsExist = 4;
            if (rdbtnlstReportType.SelectedItem.Text == "PDF")
            {
                GeneratePDF();
            }
            if (rdbtnlstReportType.SelectedItem.Text == "Excel")
            {
                dtsummaryClientwise = (DataTable)Session["InventoryDetails"];
                ExportExcel(gvInventoryDetail, dtsummaryClientwise, "InventoryDetails");
            }
        }
    }
  
    protected void btnDetailsExcelExport_Click(object sender, EventArgs e)
    {
        DataTable dtsummaryClientwise = new DataTable();
        if (Session["InventoryDetails"] != null)
        {
            dtsummaryClientwise = (DataTable)Session["InventoryDetails"];
            ExportExcel(gvInventoryDetail, dtsummaryClientwise, "Inventory Details");
        }

    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }
    protected void lnkbtnInventorySummary_Click(object sender, EventArgs e)
    {
        pnlExportype.Visible = false;
        btnExportToExcel.Visible = false;
        lnkbtnInventorySummary.Style["color"] = "blue !important;";
        lnkbtnInventoryDeatils.Style["color"] = "#4f4f4f !important;";
        rdlstbtnReport.Visible = true;
        ShowInventorySummary();
    }

    private void ShowInventorySummary()
    {
        lb1Message.Text = "";

        divInventorySummary.Style["display"] = "";
        divInventorySummaryDetails.Style["display"] = "none";
        ddlCustomer.Items.Clear();
        ddlCustomer.DataSource = null;
        ddlCustomer.DataBind();

        rdlstbtnReport.Style["display"] = "";
        btnViewDetails.Visible = false;
        btnview.Visible = true;
        txtfromDate.Visible = true;
        lblfrmdt.Visible = true;
        txttodate.Visible = true;
        lbltodate.Visible = true;
        lblyear.Visible = false;
        ddlyears.Visible = false;
        int CompanyId = 0;
        BindCompanyGroup(CompanyId);

    }
    private void ClearFileds()
    {
        ddlCustomer.Items.Clear();
        ddlCustomer.DataSource = null;
        ddlCustomer.DataBind();
        ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlCompanyGroup.SelectedIndex = -1;
        lb1Message.Visible = false;
    }

    protected void lnkbtnInventoryDeatils_Click(object sender, EventArgs e)
    {
        pnlExportype.Visible = false;
        btnExportToExcel.Visible = false;
        Session["InventoryData"] = null;
        lnkbtnInventorySummary.Style["color"] = "#4f4f4f !important;";
        lnkbtnInventoryDeatils.Style["color"] = "blue !important;";
        ClearAllGrid();
        ClearCustomerDDL();
    }

    private void ShowInventoryDetails()
    {
        int CompanyId = 0;
        lb1Message.Text = "";
        BindCompanyGroup(CompanyId);
        lblyear.Visible = false;
        ddlyears.Visible = false;

        // btnViewDetails.Visible = true;

        rdlstbtnReport.Style["display"] = "none";
        txtfromDate.Visible = false;
        lblfrmdt.Visible = false;
        txttodate.Visible = false;
        lbltodate.Visible = false;
        btnViewDetails.Visible = true;
        btnview.Visible = false;
        lblyear.Visible = true;
        ddlyears.Visible = true;
        BindCustomer(CompanyId);
        //divInventorySummary.Style["display"] = "none";
        //divInventorySummaryDetails.Style["display"] = "";
        ClearSummaryGrid();

    }

    protected void ClearSummaryGrid()
    {
        gvInventoryReport.DataSource = null;
        gvInventoryReport.DataBind();
        Session["InventoryData"] = null;

    }
    #region [Rolewise access page funcationality]

    public void SetRolewiseAcessfuncationality()
    {
        UserRolewiseAcess objUserRoleWiseAcessDAL = new UserRolewiseAcess();
        DataTable dtPageId = objUserRoleWiseAcessDAL.GetApplicationCodeDetails("Page_Name", "Inventory").Tables[0];
        int PageId = 0;
        if (dtPageId.Rows.Count > 0)
        {
            PageId = Convert.ToInt32(dtPageId.Rows[0][0]);
        }
        DataTable dtPagefuncationality = objUserRoleWiseAcessDAL.GetPageFunctionalityByRoleAndPageId(PageId, RoleId).Tables[0];
        // btnview.Visible = false;
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
                        case "Export To Excel":
//                            btnExportToExcel.Visible = true;
                            break;
                        default:
                            break;
                    }
                }
            }
        }
    }
    #endregion

    protected void btnview_Click1(object sender, EventArgs e)
    {
        if (rdlstbtnReport.SelectedValue == "1")
        {
            try
            {
                GetInventoryData();
            }
            catch (Exception ex)
            {
                ErrorHandler.WriteLog(ex);
            }
        }
        ////if (rdlstbtnReport.SelectedValue == "2")
        ////{
        ////    try
        ////    {
        ////        GetInventoryDepartMentwise();
        ////    }
        ////    catch (Exception ex)
        ////    {
        ////        ErrorHandler.WriteLog(ex);
        ////    }
        ////}

        if (rdlstbtnReport.SelectedValue == "3")
        {
            try
            {
                GetInventoryYearWise();
            }
            catch (Exception ex)
            {
                ErrorHandler.WriteLog(ex);
            }
        }

    }
    protected void btnViewDetails_Click(object sender, EventArgs e)
    {
        try
        {
            GetInventoryDetailData();
        }
        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }

    }
    protected void ClearCustomerDDL()
    {
        ddlCustomer.Items.Clear();
        ddlCustomer.DataSource = null;
        ddlCustomer.DataBind();
        ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        txtfromDate.Visible = false;
        txttodate.Visible = false;
        lblfrmdt.Visible = false;
        lbltodate.Visible = false;
        rdlstbtnReport.Visible = false;
        ddlyears.Visible = true;
        lblyear.Visible = true;
        btnview.Visible = false;
        btnViewDetails.Visible = true;
        ddlCompanyGroup.SelectedIndex = -1;
        ddlyears.SelectedIndex = -1;
        rdlstbtnReport.SelectedValue = "1";
    }

    int TotalInBoxes = 0;
    int TotalOutBoxes = 0;
    int TotalInFiles = 0;
    int TotalOutFiles = 0;
    int TotalBoxes = 0;
    int TotalFiles = 0;

    protected void gvInventoryReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TotalInBoxes += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "InBox"));
            TotalOutBoxes += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "OutBox"));
            TotalInFiles += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "InFile"));
            TotalOutFiles += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "OutFile"));

            TotalBoxes += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "TotalBoxes"));
            TotalFiles += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "TotalFiles"));
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblGrandTotalInBoxes = (Label)e.Row.FindControl("lblGrandTotalInBoxes");
            lblGrandTotalInBoxes.Text = TotalInBoxes.ToString();
            Label lblGrandTotalOutBoxes = (Label)e.Row.FindControl("lblGrandTotalOutBoxes");
            lblGrandTotalOutBoxes.Text = TotalOutBoxes.ToString();
            Label lblGrandTotalInFiles = (Label)e.Row.FindControl("lblGrandTotalInFiles");
            lblGrandTotalInFiles.Text = TotalInFiles.ToString();
            Label lblGrandTotalOutFiles = (Label)e.Row.FindControl("lblGrandTotalOutFiles");
            lblGrandTotalOutFiles.Text = TotalOutFiles.ToString();

            Label lblGrandTotalBoxes = (Label)e.Row.FindControl("lblGrandTotalBoxes");
            lblGrandTotalBoxes.Text = TotalBoxes.ToString();
            Label lblGrandTotalFiles = (Label)e.Row.FindControl("lblGrandTotalFiles");
            lblGrandTotalFiles.Text = TotalFiles.ToString();
        }
    }
    protected void gvSummaryYear_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TotalInBoxes += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "InBox"));
            TotalOutBoxes += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "OutBox"));
            TotalInFiles += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "InFile"));
            TotalOutFiles += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "OutFile"));

            TotalBoxes += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "TotalBoxes"));
            TotalFiles += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "TotalFiles"));
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblGrandTotalInBoxes = (Label)e.Row.FindControl("lblGrandTotalInBoxes");
            lblGrandTotalInBoxes.Text = TotalInBoxes.ToString();
            Label lblGrandTotalOutBoxes = (Label)e.Row.FindControl("lblGrandTotalOutBoxes");
            lblGrandTotalOutBoxes.Text = TotalOutBoxes.ToString();
            Label lblGrandTotalInFiles = (Label)e.Row.FindControl("lblGrandTotalInFiles");
            lblGrandTotalInFiles.Text = TotalInFiles.ToString();
            Label lblGrandTotalOutFiles = (Label)e.Row.FindControl("lblGrandTotalOutFiles");
            lblGrandTotalOutFiles.Text = TotalOutFiles.ToString();

            Label lblGrandTotalBoxes = (Label)e.Row.FindControl("lblGrandTotalBoxes");
            lblGrandTotalBoxes.Text = TotalBoxes.ToString();
            Label lblGrandTotalFiles = (Label)e.Row.FindControl("lblGrandTotalFiles");
            lblGrandTotalFiles.Text = TotalFiles.ToString();
        }
    }
    protected void rdlstbtnReport_SelectedIndexChanged(object sender, EventArgs e)
    {
        ClearAllGrid();
        ClearFileds();
        ////if (rdlstbtnReport.SelectedValue == "2")
        ////{
        ////    btnview.Visible = true;
        ////    gvInventoryReport.DataSource = null;
        ////    gvInventoryReport.DataBind();
        ////    ddlyears.Visible = false;
        ////    lblyear.Visible = false;
        ////}
        if (rdlstbtnReport.SelectedValue == "3")
        {
          
            txtfromDate.Text = string.Empty;
            txttodate.Text = string.Empty;
            txtfromDate.Visible = false;
            txttodate.Visible = false;
            lblfrmdt.Visible = false;
            lbltodate.Visible = false;
            ddlyears.Visible = true;
            lblyear.Visible = true;
        }
        if (rdlstbtnReport.SelectedValue == "1")
        {
            ddlyears.SelectedIndex = 0;
            txtfromDate.Visible = true;
            txttodate.Visible = true;
            lblfrmdt.Visible = true;
            lbltodate.Visible = true;
            ddlyears.Visible = false;
            lblyear.Visible = false;
        }
    }
   
    protected void gvSummaryDept_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TotalInBoxes += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "InBox"));
            TotalOutBoxes += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "OutBox"));
            TotalInFiles += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "InFile"));
            TotalOutFiles += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "OutFile"));

            TotalBoxes += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "TotalBoxes"));
            TotalFiles += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "TotalFiles"));
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblGrandTotalInBoxes = (Label)e.Row.FindControl("lblGrandTotalInBoxes");
            lblGrandTotalInBoxes.Text = TotalInBoxes.ToString();
            Label lblGrandTotalOutBoxes = (Label)e.Row.FindControl("lblGrandTotalOutBoxes");
            lblGrandTotalOutBoxes.Text = TotalOutBoxes.ToString();
            Label lblGrandTotalInFiles = (Label)e.Row.FindControl("lblGrandTotalInFiles");
            lblGrandTotalInFiles.Text = TotalInFiles.ToString();
            Label lblGrandTotalOutFiles = (Label)e.Row.FindControl("lblGrandTotalOutFiles");
            lblGrandTotalOutFiles.Text = TotalOutFiles.ToString();

            Label lblGrandTotalBoxes = (Label)e.Row.FindControl("lblGrandTotalBoxes");
            lblGrandTotalBoxes.Text = TotalBoxes.ToString();
            Label lblGrandTotalFiles = (Label)e.Row.FindControl("lblGrandTotalFiles");
            lblGrandTotalFiles.Text = TotalFiles.ToString();
        }
    }

    protected void GeneratePDF()
    {
        DateTime? dFromDate;
        DateTime? dToDate;
        int CustomerId=0;
        if (ddlCustomer.SelectedIndex > 0)
        {
            CustomerId = Convert.ToInt32(ddlCustomer.SelectedValue);
        }
        if (txtfromDate.Text == "")
            dFromDate = Convert.ToDateTime("01-01-1900");
        else
            dFromDate = Convert.ToDateTime(txtfromDate.Text.ToString(), enGB);
        if (txttodate.Text == "")
            dToDate = DateTime.Now;
        else
            dToDate = Convert.ToDateTime(txttodate.Text.ToString(), enGB);
        Director director = new Director();
        ConcreteBuilder b1 = new ConcreteBuilder();
        b1.CustomerId = CustomerId;
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
            string FileName = IsExist == 1 ? "InventorySummary" : "InventoryDetails";
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
        const string FullFilePath = "~/Reports/Inventory.htm";
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
        public Int16 Year { get; set; }

        DataTable GetInvetory(int ICustId)
        {

            DataTable dtInventory = new DataTable();
            if (IsExist == 1)
            {
                if (HttpContext.Current.Cache["InventoryData"] != null)
                {
                    dtInventory = (DataTable)HttpContext.Current.Cache["InventoryData"];
                }
            }
            if (IsExist == 3)
            {
                if (HttpContext.Current.Cache["InventoryReportYearWise"] != null)
                {
                    dtInventory = (DataTable)HttpContext.Current.Cache["InventoryReportYearWise"];
                }
            }

            if (IsExist == 4)
            {
                if (HttpContext.Current.Cache["InventoryDetails"] != null)
                {
                    dtInventory =(DataTable) HttpContext.Current.Cache["InventoryDetails"];
                }
            }
            return dtInventory;
        }

        DataTable GetInOutBoxesFilesCount(int ICustId)
        {
            DataTable dtInventory = new DataTable();
            if (IsExist == 1)
            {
                if (HttpContext.Current.Cache["InventoryDataSum"] != null)
                {
                    dtInventory = (DataTable)HttpContext.Current.Cache["InventoryDataSum"];
                }
            }
            return dtInventory;
        }

        DataTable GetInOutBoxesFilesYearsCount(int ICustId)
        {
            DataTable dtInventory = new DataTable();
            if (IsExist == 3)
            {
                if (HttpContext.Current.Cache["InventoryReportYearWiseSum"] != null)
                {
                    dtInventory = (DataTable)HttpContext.Current.Cache["InventoryReportYearWiseSum"];
                }
            }
            return dtInventory;
        }

        DataTable GetInOutBoxesFilesDetailsCount(int ICustId)
        {
            DataTable dtInventory = new DataTable();
            if (IsExist == 4)
            {
                if (HttpContext.Current.Cache["InventoryDetailsSum"] != null)
                {
                    dtInventory = (DataTable)HttpContext.Current.Cache["InventoryDetailsSum"];
                }
            }
            return dtInventory;
        }

        public void BuildOtherServices()
        {
            product.Initlize();
            iTextSharp.text.pdf.PdfPTable TableInventory = null;

            if (IsExist == 1)
            {
                TableInventory = ObjPdfTAbles.GetInventoryReportSummary(GetInvetory(CustomerId), GetInOutBoxesFilesCount(CustomerId));
            }
            if (IsExist == 3)
            {

                TableInventory = ObjPdfTAbles.GetInventoryYearWiseReport(GetInvetory(CustomerId), GetInOutBoxesFilesYearsCount(CustomerId));
            }
            if (IsExist == 4)
            {
                TableInventory = ObjPdfTAbles.GetInventoryDetailsReport(GetInvetory(CustomerId));
            }

            product.Add(TableInventory, GetWoHeader(), 0);
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
    //protected void gvInventoryReport_RowCommand(object sender, GridViewCommandEventArgs e)
    //{

    //}
    //public int[] CustomerId
    //{
    //    get
    //    {
    //        int[] CustomerId = { 0 };
    //        if (Session["CustomerId"] != null)
    //        {
    //            CustomerId = (int[])Session["CustomerId"];
    //        }
    //        return CustomerId;
    //    }
    //    set
    //    {
    //        Session["CustomerId"] = value;
    //    }
    //}

    public void GetInOutBoxeFileDetails(string CommandName)
    {
        DataSet dsGetInOutBoxeFileDetails = null;
        Session["dsGetFileDetails"] = null;
        try
        {

            if (CommandName == "lnkviewInBoxesDetails")
            {
                try
                {
                    dsGetInOutBoxeFileDetails = objPRSMReportInvBAL.GetInvYearWiseBoxFileDetails("BoxIn", Convert.ToInt32(ViewState["CustomerId"]), Convert.ToInt32(ViewState["Year"]));
                    if (dsGetInOutBoxeFileDetails.Tables.Count > 0)
                    {

                        if (dsGetInOutBoxeFileDetails.Tables[0].Rows.Count > 0)
                        {
                            gvInBoxDetails.DataSource = dsGetInOutBoxeFileDetails.Tables[0];
                            gvInBoxDetails.DataBind();
                        }

                        else
                        {
                            gvInBoxDetails.DataSource = null;
                            gvInBoxDetails.DataBind();
                        }

                        ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "divShowInBoxdetails();", true);
                    }
                }
                catch (Exception ex)
                {
                    ErrorHandler.WriteLog(ex);
                }
            }
             if (CommandName == "lnkviewInFilesDetails")
             {
                 try
                {
                    dsGetInOutBoxeFileDetails = objPRSMReportInvBAL.GetInvYearWiseBoxFileDetails("FileIn", Convert.ToInt32(ViewState["CustomerId"]), Convert.ToInt32(ViewState["Year"]));
                    if (dsGetInOutBoxeFileDetails.Tables.Count > 0)
                    {
                        if (dsGetInOutBoxeFileDetails.Tables[0].Rows.Count > 0)
                        {
                            gvInFilesDetails.DataSource = dsGetInOutBoxeFileDetails.Tables[0];
                            gvInFilesDetails.DataBind();
                        }
                        else
                        {
                            gvInFilesDetails.DataSource = null;
                            gvInFilesDetails.DataBind();
                        }

                        ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "divShowInFilesdetails();", true);
                    }
             }

                 catch (Exception ex)
                {
                    ErrorHandler.WriteLog(ex);
                }
            }
             if (CommandName == "lnkviewOutFilesDetails")
            {
                
                try
                {
                    dsGetInOutBoxeFileDetails = objPRSMReportInvBAL.GetInvYearWiseBoxFileDetails("FileOut", Convert.ToInt32(ViewState["CustomerId"]), Convert.ToInt32(ViewState["Year"]));
                    if (dsGetInOutBoxeFileDetails.Tables[0].Rows.Count > 0)
                    {
                        if (dsGetInOutBoxeFileDetails.Tables[0].Rows.Count > 0)
                        {
                            gvOutFilesDetails.DataSource = dsGetInOutBoxeFileDetails.Tables[0];
                            gvOutFilesDetails.DataBind();
                        }
                    }
                    else
                    {
                        gvOutFilesDetails.DataSource = null;
                        gvOutFilesDetails.DataBind();
                    }

                    ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "divShowOutFilesdetails();", true);
                }
                catch (Exception ex)
                {
                    ErrorHandler.WriteLog(ex);
                }
            }
             if (CommandName == "lnkviewOutBoxesDetails")
            {
                
                try
                {
                    dsGetInOutBoxeFileDetails = objPRSMReportInvBAL.GetInvYearWiseBoxFileDetails("BoxOut", Convert.ToInt32(ViewState["CustomerId"]), Convert.ToInt32(ViewState["Year"]));
                    if (dsGetInOutBoxeFileDetails.Tables.Count > 0)
                    {
                        if (dsGetInOutBoxeFileDetails.Tables[0].Rows.Count > 0)
                        {
                            gvOutBoxDetails.DataSource = dsGetInOutBoxeFileDetails.Tables[0];
                            gvOutBoxDetails.DataBind();
                        }
                        else
                        {
                            gvOutBoxDetails.DataSource = null;
                            gvOutBoxDetails.DataBind();
                        }

                        ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "divShowOutBoxdetails();", true);
                        //ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "divShowOutBoxdetails();", true);
                    }

                }
                catch (Exception ex)
                {
                    ErrorHandler.WriteLog(ex);
                }

            }
            Session["dsGetInOutBoxeFileDetails"] = dsGetInOutBoxeFileDetails;
        } 
       
        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }
    }


    protected void gvInventoryDetail_RowCommand(object sender, GridViewCommandEventArgs e)
     {
        //string strIOType = "";
        //DataSet dsGetFileDetails = null;
        //int CustomerId = 0;
        if (ddlCustomer.SelectedIndex != -1)
        {
            CustomerId = Convert.ToInt32(ddlCustomer.SelectedValue);
            ViewState["CustomerId"] = CustomerId;
        }
        Year = Convert.ToInt32(e.CommandArgument);
        ViewState["Year"] = Year;
        CommandName = Convert.ToString(e.CommandName);
        ViewState["CommandName"] = CommandName;

        GetInOutBoxeFileDetails(CommandName);


        //if (e.CommandName == "lnkviewInBoxesDetails")
        //{
    
        //    //strIOType = Convert.ToString(e.CommandArgument.ToString()); //Convert.ToInt32(CustomerId[0]),

        //    int Year = Convert.ToInt32(e.CommandArgument.ToString());
        //    dsGetFileDetails = objPRSMReportInvBAL.GetInvYearWiseBoxFileDetails("BoxIn",CustomerId, Year);

        //    //dsGetFileDetails = objPRSMReportInvBAL.GetInOutBFDetailsInventory(Convert.ToInt32(CustomerId[0]));
        //    try
        //    {
        //        if (dsGetFileDetails.Tables.Count > 0)
        //        {

        //            if (dsGetFileDetails.Tables[0].Rows.Count > 0)
        //            {
        //                gvInBoxDetails.DataSource = dsGetFileDetails.Tables[0];
        //                gvInBoxDetails.DataBind();
        //            }

        //            else
        //            {
        //                gvInBoxDetails.DataSource = null;
        //                gvInBoxDetails.DataBind();
        //            }

        //            ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "divShowInBoxdetails();", true);
        //        }

        //    }
        //    catch (Exception ex)
        //    {
        //        ErrorHandler.WriteLog(ex);
        //    }
        //}
        //if (e.CommandName == "lnkviewInFilesDetails")
        //{
        //    int Year = Convert.ToInt32(e.CommandArgument.ToString());
        //    dsGetFileDetails = objPRSMReportInvBAL.GetInvYearWiseBoxFileDetails("FileIn",CustomerId, Year);
        //    try
        //    {
        //        if (dsGetFileDetails.Tables.Count > 0)
        //        {
        //            if (dsGetFileDetails.Tables[0].Rows.Count > 0)
        //            {
        //                gvInFilesDetails.DataSource = dsGetFileDetails.Tables[0];
        //                gvInFilesDetails.DataBind();
        //            }
        //            else
        //            {
        //                gvInFilesDetails.DataSource = null;
        //                gvInFilesDetails.DataBind();
        //            }

        //            ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "divShowInFilesdetails();", true);
        //        }

        //    }
        //    catch (Exception ex)
        //    {
        //        ErrorHandler.WriteLog(ex);
        //    }
        //}

        //if (e.CommandName == "lnkviewOutFilesDetails")
        //{
        //    DataTable dt = new DataTable();
        //    //   strIOType = Convert.ToString(e.CommandArgument.ToString());

        //    //dsGetFileDetails = objPRSMReportInvBAL.GetInOutBFDetailsInventory(Convert.ToInt32(CustomerId[0]));
        //    int Year = Convert.ToInt32(e.CommandArgument.ToString());
        //    dsGetFileDetails = objPRSMReportInvBAL.GetInvYearWiseBoxFileDetails("FileOut",CustomerId, Year);

        //    try
        //    {
        //        if (dsGetFileDetails.Tables[0].Rows.Count > 0)
        //        {
        //            if (dsGetFileDetails.Tables[0].Rows.Count > 0)
        //            {
        //                gvOutFilesDetails.DataSource = dsGetFileDetails.Tables[0];
        //                gvOutFilesDetails.DataBind();
        //            }
        //        }
        //        else
        //        {
        //            gvOutFilesDetails.DataSource = null;
        //            gvOutFilesDetails.DataBind();
        //        }

        //        ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "divShowOutFilesdetails();", true);
        //    }
        //    catch (Exception ex)
        //    {
        //        ErrorHandler.WriteLog(ex);
        //    }
        //}
        //if (e.CommandName == "lnkviewOutBoxesDetails")
        //{
        //    DataTable dt = new DataTable();
        //    //            strIOType = Convert.ToString(e.CommandArgument.ToString());
        //    //            dsGetFileDetails = objPRSMReportInvBAL.GetInOutBFDetailsInventory(Convert.ToInt32(CustomerId[0]));
        //     int Year = Convert.ToInt32(e.CommandArgument.ToString());
        //    dsGetFileDetails = objPRSMReportInvBAL.GetInvYearWiseBoxFileDetails("BoxOut",CustomerId, Year);
        //    try
        //    {
        //        if (dsGetFileDetails.Tables.Count > 0)
        //        {
        //            if (dsGetFileDetails.Tables[0].Rows.Count > 0)
        //            {
        //                gvOutBoxDetails.DataSource = dsGetFileDetails.Tables[0];
        //                gvOutBoxDetails.DataBind();
        //            }
        //            else
        //            {
        //                gvOutBoxDetails.DataSource = null;
        //                gvOutBoxDetails.DataBind();
        //            }

        //            ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "divShowOutBoxdetails();", true);
        //            //ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "divShowOutBoxdetails();", true);
        //        }

        //    }
        //    catch (Exception ex)
        //    {
        //        ErrorHandler.WriteLog(ex);
        //    }
        //}
    }

    protected void gvInBoxDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvInBoxDetails.PageIndex = e.NewPageIndex;
        //ViewState["NewPageIndex"] = e.NewPageIndex;
        GetInOutBoxeFileDetails(Convert.ToString(ViewState["CommandName"]));
    }

    protected void gvOutBoxDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvOutBoxDetails.PageIndex = e.NewPageIndex;
        GetInOutBoxeFileDetails(Convert.ToString(ViewState["CommandName"]));
    }
    protected void gvInFilesDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvInFilesDetails.PageIndex = e.NewPageIndex;        
        GetInOutBoxeFileDetails(Convert.ToString(ViewState["CommandName"]));
    }
    protected void gvOutFilesDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvOutFilesDetails.PageIndex = e.NewPageIndex;        
        GetInOutBoxeFileDetails(Convert.ToString(ViewState["CommandName"]));
    }

    protected void btnInFilesdetails_Click(object sender, EventArgs e)
    {
        Session["dsGetFileDetails"] = null;
        gvInFilesDetails.DataSource = null;
        gvInFilesDetails.DataBind();
        gvInFilesDetails.PageIndex = 0;
    }
    protected void btnInBoxdetails_Click(object sender, EventArgs e)
    {
        Session["dsGetFileDetails"] = null;
        gvInBoxDetails.DataSource = null;
        gvInBoxDetails.DataBind();
        gvInBoxDetails.PageIndex = 0;
    }
    protected void btnOutFilesdetails_Click(object sender, EventArgs e)
    {
        Session["dsGetFileDetails"] = null;
        gvOutFilesDetails.DataSource = null;
        gvOutFilesDetails.DataBind();
        gvOutFilesDetails.PageIndex = 0;
    }
    protected void btnOutBoxdetails_Click(object sender, EventArgs e)
    {
        Session["dsGetFileDetails"] = null;
        gvOutBoxDetails.DataSource = null;
        gvOutBoxDetails.DataBind();
        gvOutBoxDetails.PageIndex = 0;
    }


}


