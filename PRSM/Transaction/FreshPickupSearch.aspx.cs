using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PRSMBAL;
using System.Data;
using System.Data.SqlClient;
using Entity;
using UserRoleWiseAcess;
using Utility;
using System.IO;
using System.Data.OleDb;
using System.Configuration;
using System.Drawing;

public partial class Transaction_FreshPickupSearch : PageBase
{
    PRSMBAL.MasterBAL objPRSMBAL = new MasterBAL();
    PRSMBAL.TransactionBAL objPRSMTransBAL = new TransactionBAL();
    FreshEntrySearch objFreshSearch = new FreshEntrySearch();
    PageBase ObjPageBase = new PageBase();
    public PRSMBAL.ReportBAL objPRSMReportBAL = new ReportBAL();
    private GetPDFTables ObjPdfTAbles = new GetPDFTables();
    private Product product = new Product();
    public static int IsExist { get; set; }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindDdlWareHouse();
            BindDepartment();
            trIMPORT.Attributes["style"] = "display:none";
        }
    }
    private void BindDepartment()
    {
        DataSet ds1 = objPRSMBAL.GetApplicationCodeDetails("DEPARTMENT", string.Empty);
        ddlDept.DataSource = ds1;
        ddlDept.DataValueField = "AppCodeId";
        ddlDept.DataTextField = "AppCodeName";
        ddlDept.DataBind();
        ddlDept.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }
    private void BindDdlWareHouse()
    {
        ddlCompanyGroup.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlWareHouse.DataSource = objPRSMBAL.GetWareHouse(0);
        ddlWareHouse.DataValueField = "WareHouseId";
        ddlWareHouse.DataTextField = "WarehouseName";
        ddlWareHouse.DataBind();
        ddlWareHouse.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }
    public void Clear()
    {
        ddlWareHouse.SelectedIndex = 0;
        ddlCustomer.Items.Clear();
        ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlCompanyGroup.Items.Clear();
        ddlCompanyGroup.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlDept.SelectedIndex = 0;
        txtFile.Text = "";
        txtFileBarcode.Text = "";
        txtlbl1.Text = "";
        txtlbl2.Text = "";
        txtlbl3.Text = "";
        gvFileData.DataSource = null;
        gvFileData.DataBind();
        gvBoxDetails.DataSource = null;
        gvBoxDetails.DataBind();
        lblEmptyMessage.Text = "";
        btnExportToExcel.Visible = false;
        rdbtnlstReportType.Visible = false;
        lblType.Visible = false;
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        DataSet ds = new DataSet();
        if (rbtactivityType.SelectedValue == "2")
        {
            objFreshSearch.Type = Convert.ToInt32(rbtactivityType.SelectedValue);
            objFreshSearch.CompanyGroupId = Convert.ToInt32(ddlCompanyGroup.SelectedValue);
            objFreshSearch.CustomerId = Convert.ToInt32(ddlCustomer.SelectedValue);
            objFreshSearch.Department = Convert.ToInt32(ddlDept.SelectedValue);
            objFreshSearch.FileBarcode = txtFileBarcode.Text;
            objFreshSearch.WareHouseId = Convert.ToInt32(ddlWareHouse.SelectedValue);
            objFreshSearch.FileName = txtFile.Text.Trim();
            objFreshSearch.label1 = txtlbl3.Text.Trim();
            objFreshSearch.label2 = txtlbl1.Text.Trim();
            objFreshSearch.label3 = txtlbl2.Text.Trim();
            objFreshSearch.FileDesc2 = txtFileDesc2.Text.Trim();
            ds = objPRSMTransBAL.getFreshPickupData(objFreshSearch);
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                dvFile.Visible = true;
                lblEmptyMessage.Visible = false;
                HttpContext.Current.Cache["FreshPickupFile"] = ds.Tables[0];
                ViewState["FreshPickupFile"] = ds.Tables[0];
                btnExportToExcel.Visible = true;
                rdbtnlstReportType.Visible = true;
                lblType.Visible = true;
                gvFileData.DataSource = ds;
                gvFileData.DataBind();
            }
            else
            {
                lblEmptyMessage.Visible = true;
                btnExportToExcel.Visible = false;
                gvFileData.DataSource = null;
                gvFileData.DataBind();
                lblEmptyMessage.Text = "No Data Found";
            }
        }
        else
        {
            objFreshSearch.Type = Convert.ToInt32(rbtactivityType.SelectedValue);
            objFreshSearch.CompanyGroupId = Convert.ToInt32(ddlCompanyGroup.SelectedValue);
            objFreshSearch.CustomerId = Convert.ToInt32(ddlCustomer.SelectedValue);
            objFreshSearch.Department = Convert.ToInt32(ddlDept.SelectedValue);
            objFreshSearch.FileBarcode = txtFileBarcode.Text;
            objFreshSearch.WareHouseId = Convert.ToInt32(ddlWareHouse.SelectedValue);
            objFreshSearch.FileName = txtFile.Text;
            objFreshSearch.label1 = txtlbl1.Text;
            objFreshSearch.label2 = txtlbl2.Text;
            if (ViewState["ListOfBoxBarCode"] != null)
            {
                objFreshSearch.label3 = (string)ViewState["ListOfBoxBarCode"];
                ViewState["ListOfBoxBarCode"] = null;
            }
            else
            {
                objFreshSearch.label3 = txtlbl3.Text;
            }
            ds = objPRSMTransBAL.getFreshPickupData(objFreshSearch);
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                gvBoxDetails.Visible = true;
                lb1MsgBoxDetails.Visible = false;
                ViewState["FreshPickupBox"] = ds.Tables[0];
                HttpContext.Current.Cache["FreshPickupBox"] = ds.Tables[0];
                btnExportToExcel.Visible = true;
                rdbtnlstReportType.Visible = true;
                lblType.Visible = true;
                gvBoxDetails.DataSource = ds;
                gvBoxDetails.DataBind();
            }
            else
            {
                lb1MsgBoxDetails.Visible = true;
                btnExportToExcel.Visible = false;
                gvBoxDetails.DataSource = null;
                gvBoxDetails.DataBind();
                lb1MsgBoxDetails.Text = "No Data Found";
            }
        }
    }
    protected void rbtactivityType_SelectedIndexChanged(object sender, EventArgs e)
    {
        btnExportToExcel.Visible = false;
        if (rbtactivityType.SelectedValue == "1")
        {
            lb1BoxFile.Text = "Box BarCode";
            divBoxDetails.Visible = true;
            divFileDetails.Visible = false;
            btnSearch.Attributes["style"] = "display:block";
            dvFile.Attributes["style"] = "display:none";
            gvBoxDetails.Attributes["style"] = "display:block";
            trIMPORT.Attributes["style"] = "display:block";
            gvFileData.DataSource = null;
            gvFileData.DataBind();
            gvFileData.Visible = false;
            gvBoxDetails.Visible = true;
        }
        else
        {
            lb1BoxFile.Text = "File BarCode";
            divFileDetails.Visible = true;
            divBoxDetails.Visible = false;
            dvFile.Attributes["Style"] = "display:block";
            trIMPORT.Attributes["style"] = "display:none";
            gvBoxDetails.DataSource = null;
            gvBoxDetails.DataBind();
            gvBoxDetails.Visible = false;
            gvFileData.Visible = true;
        }
        Clear();
    }
    protected void ddlWareHouse_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlWareHouse.SelectedIndex > 0)
        {
            BindCompanyGroup(0);
            ddlCustomer.Items.Clear();
            ddlCustomer.DataSource = null;
            ddlCustomer.DataBind();
            ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
        else
        {
            ddlCompanyGroup.Items.Clear();
            ddlCustomer.Items.Clear();
            ddlCustomer.DataSource = null;
            ddlCustomer.DataBind();
            ddlCompanyGroup.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
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
    protected void BindCustomer(int iCompanyId)
    {
        ddlCustomer.DataSource = null;
        ddlCustomer.DataBind();
        DataSet dsCustomer = objPRSMBAL.GetCustomer(iCompanyId);
        ddlCustomer.DataSource = dsCustomer.Tables[0];
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
            ddlCustomer.Items.Clear();
            ddlCustomer.DataSource = null;
            ddlCustomer.DataBind();
            ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
    }
    protected void btnExportToExcel_Click(object sender, EventArgs e)
    {
        try
        {
            if (rbtactivityType.SelectedValue == "2")
            {
                IsExist = 1;
                DataTable dtsummaryClientwise = new DataTable();
                if (ViewState["FreshPickupFile"] != null)
                {
                    if (rdbtnlstReportType.SelectedItem.Text == "PDF")
                    {
                        GeneratePDF();
                    }
                    if (rdbtnlstReportType.SelectedItem.Text == "Excel")
                    {
                        dtsummaryClientwise = (DataTable)ViewState["FreshPickupFile"];
                        ExportExcel(gvFileData, dtsummaryClientwise, "FreshPickupFileBoxSearch");
                    }

                }
            }
            else
            {
                IsExist = 2;
                DataTable dtsummaryDepertmentClientwise = new DataTable();
                if (ViewState["FreshPickupBox"] != null)
                {
                    if (rdbtnlstReportType.SelectedItem.Text == "PDF")
                    {
                        GeneratePDF();
                    }
                    if (rdbtnlstReportType.SelectedItem.Text == "Excel")
                    {
                        dtsummaryDepertmentClientwise = (DataTable)ViewState["FreshPickupBox"];
                        ExportExcel(gvBoxDetails, dtsummaryDepertmentClientwise, "FreshPickupFileBoxSearch");
                    }

                }

            }
        }
        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }
    }
    protected void ddlCustomer_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        Clear();
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
        string CompanyGroup = "";
        using (StringWriter sw = new StringWriter())
        {
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            string htmlReportFileter = "<table width='100%'> <tr> <td> Company Group :</td><td colspan='3'>" + CompanyGroup + " </td> </tr>";
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
    public void SetRolewiseAcessfuncationality()
    {
        UserRolewiseAcess objUserRoleWiseAcessDAL = new UserRolewiseAcess();
        DataTable dtPageId = objUserRoleWiseAcessDAL.GetApplicationCodeDetails("Page_Name", "Search Boxes/Files").Tables[0];
        int PageId = 0;
        if (dtPageId.Rows.Count > 0)
        {
            PageId = Convert.ToInt32(dtPageId.Rows[0][0]);
        }
        DataTable dtPagefuncationality = objUserRoleWiseAcessDAL.GetPageFunctionalityByRoleAndPageId(PageId, RoleId).Tables[0];
        btnSearch.Visible = false;


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
                        case "Search":
                            btnSearch.Visible = true;
                            break;
                        default:
                            break;
                    }
                }
            }
        }

    }

    DataSet ds;
    DataTable Dt;
    //protected void btnIpload_Click(object sender, EventArgs e)
    //{
    //    ImporttoDatatable();
    //    CheckData();
    //    //InsertData();
    //    //BindGrid();
    //}
    //private void ImporttoDatatable()
    //{
    //    try
    //    {
    //        if (fuBoxBarCode.HasFile)
    //        {
    //            DataSet ds;
    //            DataTable Dt;
    //            string currentdateandtime = DateTime.Now.Day.ToString() + "_" + DateTime.Now.Month.ToString() + "_" + DateTime.Now.Year.ToString() + "_" + DateTime.Now.Hour.ToString() + "_" + DateTime.Now.Minute.ToString() + "_" + DateTime.Now.Second.ToString();
    //            string FileName = fuBoxBarCode.FileName;
    //            string path = string.Concat(Server.MapPath("~/PRSMDocument/" + currentdateandtime));//fuBoxBarCode.FileName));
    //            fuBoxBarCode.PostedFile.SaveAs(path);
    //            OleDbConnection OleDbcon = new OleDbConnection("Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + path + ";Extended Properties=Excel 12.0;");
    //            OleDbCommand cmd = new OleDbCommand("SELECT * FROM [Sheet1$]", OleDbcon);

    //            OleDbDataAdapter objAdapter1 = new OleDbDataAdapter(cmd);
    //            ds = new DataSet();
    //            objAdapter1.Fill(ds);
    //            Dt = ds.Tables[0];
    //            ViewState["UploadedBoxes"] = ds.Tables[0];
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //    }
    //}

    //private void CheckData()
    //{
    //    try
    //    {
    //        if (ViewState["UploadedBoxes"] != null)
    //        {
    //            Dt = (DataTable)ViewState["UploadedBoxes"];
    //            ViewState["UploadedBoxes"] = null;
    //            //for (int i = 0; i < Dt.Rows.Count; i++)
    //            //{
    //            //    if (Dt.Rows[i][0].ToString() == "")
    //            //    {
    //            //        int RowNo = i + 2;
    //            //        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "InvalidArgs", "alert('Please enter BoxBarCode in row " + RowNo + "');", true);
    //            //        return;
    //            //    }
    //            //}
    //            MemoryStream str = new MemoryStream();
    //            Dt.WriteXml(str, true);
    //            str.Seek(0, SeekOrigin.Begin);
    //            StreamReader sr = new StreamReader(str);
    //            string xmlstr;
    //            xmlstr = sr.ReadToEnd();
    //            ViewState["ListOfBoxBarCode"] = xmlstr;
    //            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "FileImport", "alert('" + fuBoxBarCode.FileName + " File imported, kindly click the Search button');", true);
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //    }
    //}


    class Director
    {
        public void Construct(IBuilder builder)
        {
            builder.BuildFilePickup();
        }
    }

    public interface IBuilder
    {
        void BuildFilePickup();
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
        public Int16 SerchType { get; set; }
        public int DepartmentId { get; set; }
        public string FileBarCode { get; set; }
        public string FileName { get; set; }
        public string Label1 { get; set; }
        public string Label2 { get; set; }
        public string Label3 { get; set; }
        public string FileDescription2 { get; set; }
        public string DestructionDueDate { get; set; }

        public void Initlize()
        {
            _document = new iTextSharp.text.Document(iTextSharp.text.PageSize.A4, 30, 30, 10, 10);
            //_document = new iTextSharp.text.Document(new iTextSharp.text.RectangleReadOnly(842, 595), 88f, 88f, 10f, 10f);
            _document.SetPageSize(iTextSharp.text.PageSize.A4.Rotate());
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
            string FileName = IsExist == 1 ? "FreshPickupFileBoxSearch" : "FreshPickupFileBoxSearch";
            _document.Close();
            HttpContext.Current.Response.ContentType = "application/pdf";
            HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment;filename=" + FileName + ".pdf", 0000));
            HttpContext.Current.Response.BinaryWrite(_output.ToArray());
        }
    }

    protected void GeneratePDF()
    {
        Director director = new Director();
        ConcreteBuilder b1 = new ConcreteBuilder();
        if (IsExist == 2 || IsExist == 1)
        {
            b1.CompanyGroupId = 0;
            b1.SerchType = Convert.ToInt16(rbtactivityType.SelectedValue);
            b1.CustomerId = Convert.ToInt32(ddlCustomer.SelectedValue);
            b1.DepartmentId = Convert.ToInt32(objFreshSearch.Department);
            b1.FileBarCode = txtFileBarcode.Text.Trim();
            b1.WareHouseId = Convert.ToInt16(ddlWareHouse.SelectedValue);
            b1.FileDescription1 = txtFile.Text.Trim();
            b1.FromNo = txtlbl1.Text.Trim();
            b1.ToNo = txtlbl2.Text.Trim();
            b1.FileType = txtlbl3.Text.Trim();
            b1.FileDescription2 = txtFileDesc2.Text.Trim();
            //b1.DestructionDueDate = "";
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


    public class ConcreteBuilder : System.Web.UI.Page, IBuilder
    {
        /*======================Constants================================= */
        const string _LOGOIMAGE = "@imagepath@";
        const string _LOGOIMAGE1 = "@imagepath1@";
        const string _ServiceCateg = "@ServiceCateg@";
        const string _RequestedActivity = "@TableRequestedActivity@";
        const string _WoStatus = "@WoStatus@";
        const string FullFilePath = "~/Reports/FreshFilePickupSearch.htm";
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
        PRSMBAL.TransactionBAL objPRSMTransBAL = new TransactionBAL();
        public byte IsNew { get; set; }
        public Int16 WareHouseId { get; set; }
        public int CompanyGroupId { get; set; }
        public int CustomerId { get; set; }
        public Int16 SerchType { get; set; }
        public int DepartmentId { get; set; }
        public string FileBarCode { get; set; }
        //public string FileName { get; set; }
        public string FileDescription1 { get; set; }
        //public string Label1 { get; set; }
        //public string Label2 { get; set; }
        //public string Label3 { get; set; }
        public string FromNo { get; set; }
        public string ToNo { get; set; }
        public string FileType { get; set; }
        public string FileDescription2 { get; set; }
        public string DestructionDueDate { get; set; }

        DataTable GetFreshFilePickupSearch(int ICustId)
        {

            DataTable dtFilePickup = new DataTable();
            if (IsExist == 1)
            {
                if (HttpContext.Current.Cache["FreshPickupFile"] != null)
                {
                    dtFilePickup = (DataTable)HttpContext.Current.Cache["FreshPickupFile"];
                }
            }
            if (IsExist == 2)
            {
                if (HttpContext.Current.Cache["FreshPickupBox"] != null)
                {
                    dtFilePickup = (DataTable)HttpContext.Current.Cache["FreshPickupBox"];
                }
            }

            return dtFilePickup;
        }

        public void BuildFilePickup()
        {
            product.Initlize();
            iTextSharp.text.pdf.PdfPTable TableFilePickup = null;
            if (IsExist == 1)
            {
                TableFilePickup = ObjPdfTAbles.GetFreshFilePickupFileSearch(GetFreshFilePickupSearch(CustomerId));
            }
            if (IsExist == 2)
            {
                TableFilePickup = ObjPdfTAbles.GetFreshFilePickupBoxSearch(GetFreshFilePickupSearch(CustomerId));
            }
            product.Add(TableFilePickup, GetWoHeader(), 0);
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
    protected void btnFileFreshPickUpSearch_Click(object sender, EventArgs e)
    {
        DataTable dtExceldatafile = new DataTable();
        string consString = ConfigurationManager.ConnectionStrings["PRSMDataBaseConnection"].ConnectionString;
        try
        {
            //Upload and save the file
            string excelPath = Server.MapPath("~/Files/") + Path.GetFileName(FileUpld1.PostedFile.FileName);
            FileUpld1.SaveAs(excelPath);
            string conString = string.Empty;
            string extension = Path.GetExtension(FileUpld1.PostedFile.FileName);
            switch (extension)
            {
                case ".xls": //Excel 97-03
                    conString = ConfigurationManager.ConnectionStrings["Excel03ConString"].ConnectionString;
                    break;
                case ".xlsx": //Excel 07 or higher
                    conString = ConfigurationManager.ConnectionStrings["Excel07+ConString"].ConnectionString;
                    break;
            }
            //ClientScript.RegisterStartupScript(GetType(), "popup", "PopupFiles()", true);
            conString = string.Format(conString, excelPath);
            using (OleDbConnection excel_con = new OleDbConnection(conString))
            {
                excel_con.Open();
                string sheet1 = excel_con.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null).Rows[0]["TABLE_NAME"].ToString();

                //dtExcelData.Columns.AddRange(new DataColumn[1] { new DataColumn("FILE_BARCODE", typeof(string)) });

                using (OleDbDataAdapter oda = new OleDbDataAdapter("SELECT * FROM [" + sheet1 + "]", excel_con))
                {
                    oda.Fill(dtExceldatafile);
                }
                excel_con.Close();

            }
            using (SqlConnection con = new SqlConnection(consString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "truncate table tbl_FreshFilePickupSearch";
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            using (SqlConnection con2 = new SqlConnection(consString))
            {
                using (SqlBulkCopy sqlBulkCopy = new SqlBulkCopy(con2))
                {

                    sqlBulkCopy.DestinationTableName = "dbo.tbl_FreshFilePickupSearch";
                    //sqlBulkCopy.ColumnMappings.Add("BOX_BARCODE", "BOX_BARCODE");
                    sqlBulkCopy.ColumnMappings.Add("FILE_BARCODE", "FILE_BARCODE");
                    con2.Open();
                    sqlBulkCopy.WriteToServer(dtExceldatafile);
                    //lblmsg.Text = "Data Inserted successfully";
                    con2.Close();
                }
            }
            DataTable dtFileBarcode = new DataTable();
            using (SqlConnection con = new SqlConnection(consString))
            {
                using (SqlCommand cmd = new SqlCommand("usp_xlRetr_ValidateFreshFilePickupSearch", con))
                {
                    con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlParameter prm = new SqlParameter();

                    prm.ParameterName = "@custid";
                    prm.SqlDbType = SqlDbType.Int;
                    prm.Value = ddlCustomer.SelectedValue;
                    cmd.Parameters.Add(prm);
                    DataTable dt = new DataTable();
                    SqlDataReader sqdr = cmd.ExecuteReader();
                    dt.Load(sqdr);
                    //sqdr.NextResult(); 
                    if (!sqdr.IsClosed)
                        dtFileBarcode.Load(sqdr);
                    // dt.Load(cmd.ExecuteReader());
                    con.Close();

                    if (dt.Rows.Count > 0)
                    {
                        //strErrorMsg = "Please correct the following errors in the Excel sheet and then try again.";
                        gvFreshFileError.DataSource = dt;
                        gvFreshFileError.DataBind();
                        return;
                    }
                }
            }
            //Bind to gridview         
            {

                
            }
        }

        catch (Exception ex)
        {
            lblErrMsgFrshPickUp.Text = ex.Message;
            lblErrMsgFrshPickUp.ForeColor = Color.Red;
        }
    }
}
    
           

       