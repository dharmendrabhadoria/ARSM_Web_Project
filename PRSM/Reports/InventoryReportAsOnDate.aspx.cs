using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using PRSMBAL;
using Entity;
using System.IO;
using UserRoleWiseAcess;
using Utility;
using System.Web.SessionState;
using System.Globalization;
using System.IO;
using System.Drawing;
using System.Configuration;

public partial class Reports_InventoryReportAsOnDate : PageBase
{
    ReportBAL objPRSMReportInvBAL = new ReportBAL();
    InventryReportAsOnDate objPRSMInv = new InventryReportAsOnDate();
    PageBase objPageBase = new PageBase();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetInventoryData();
            SetRolewiseAcessfuncationality();
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
            string htmlReportFileter = "<table width='100%'> <tr> <td> Company Group :</td><td colspan='3'>" + lbltodaydate.Text + " </td> </tr>";      
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
            //style to format numbers to string
            string style = @"<style> .textmode { } </style>";
            Response.Write(style);
            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();

        }
    }

    private void GetInventoryData()
    {
        lbltodaydate.Text = DateTime.Now.Date.ToString("dd-MMM-yyyy");
        objPRSMInv.Report_type = 1;
        objPRSMInv.WareHouseId = 1;
        objPRSMInv.Year = 0;
        //btnExportToExcel.Visible = true;
        DataSet ds = objPRSMReportInvBAL.GetInventoryDataAsOnDate(objPRSMInv);
        DataSet dswarehouser = objPRSMReportInvBAL.GetWareHouseName();
        ViewState["InventoryData"] = ds.Tables[0];
        lblwarehouse.Text = Convert.ToString(dswarehouser.Tables[0].Rows[0].ItemArray[1]);
        gvInventoryReport.DataSource = ds;
        gvInventoryReport.DataBind();
    }    
   
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }     
    protected void btnExportToExcel_Click1(object sender, EventArgs e)
    {
        DataTable dtsummaryClientwise = new DataTable();
        if (ViewState["InventoryData"] != null)
        {
            dtsummaryClientwise = (DataTable)ViewState["InventoryData"];
            ExportExcel(gvInventoryReport, dtsummaryClientwise, "Inventory Report As on Date");
        }
    }
    public void SetRolewiseAcessfuncationality()
    {
        UserRolewiseAcess objUserRoleWiseAcessDAL = new UserRolewiseAcess();
        DataTable dtPageId = objUserRoleWiseAcessDAL.GetApplicationCodeDetails("Page_Name", "Inventory Report As OnDate").Tables[0];
        int PageId = 0;
        if (dtPageId.Rows.Count > 0)
        {
            PageId = Convert.ToInt32(dtPageId.Rows[0][0]);
        }
        DataTable dtPagefuncationality = objUserRoleWiseAcessDAL.GetPageFunctionalityByRoleAndPageId(PageId,RoleId).Tables[0];       
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
                            btnExportToExcel.Visible = true;
                            break;                   
                    }
                }
            }
        }
    }

  
}