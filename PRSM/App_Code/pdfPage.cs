using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.IO;
using System.Xml;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;
using System.Collections;
using System.Net;
using PRSMBAL;
using iTextSharp.text;


public partial class Footer : PdfPageEventHelper
{
    // This is the contentbyte object of the writer
    PdfContentByte cb;
    // we will put the final number of pages in a template
    PdfTemplate template;
    // this is the BaseFont we are going to use for the header / footer
    BaseFont bf = null;
    #region Properties
   

    private string _HeaderLeft;
    public string HeaderLeft
    {
        get { return _HeaderLeft; }
        set { _HeaderLeft = value; }
    }
    private string _HeaderRight;
    public string HeaderRight
    {
        get { return _HeaderRight; }
        set { _HeaderRight = value; }
    }
    private Font _HeaderFont;
    public Font HeaderFont
    {
        get { return _HeaderFont; }
        set { _HeaderFont = value; }
    }
    private Font _FooterFont;
    public Font FooterFont
    {
        get { return _FooterFont; }
        set { _FooterFont = value; }
    }
    #endregion
    iTextSharp.text.Font calibri = iTextSharp.text.FontFactory.GetFont("calibri", 8, iTextSharp.text.Font.NORMAL);
    iTextSharp.text.Font calibriMid = iTextSharp.text.FontFactory.GetFont("calibri", 9, iTextSharp.text.Font.NORMAL);

    private string Provider;
    private string Filed;
    private int ProviderID;
    PRSMBAL.TransactionBAL objTRANSBAL = new TransactionBAL();
    public Footer(DataSet dsProvider)
    {
        // TODO: Complete member initialization
        ProviderID = Convert.ToInt32(dsProvider.Tables[0].Rows[0]["n_ProviderId"].ToString());
        Provider = dsProvider.Tables[0].Rows[0]["s_ProviderName"].ToString();
    }
    public override void OnOpenDocument(PdfWriter writer, Document document)
    {
        try
        {
         //   PrintTime = DateTime.Now;
            bf = BaseFont.CreateFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
            cb = writer.DirectContent;
            template = cb.CreateTemplate(50, 50);
        }
        catch (DocumentException de)
        {
        }
        catch (System.IO.IOException ioe)
        {
        }
    }
    public override void OnStartPage(PdfWriter writer, Document document)
    {
        base.OnStartPage(writer, document);
        Rectangle pageSize = document.PageSize;
      
        if (HeaderLeft + HeaderRight != string.Empty)
        {
            PdfPTable HeaderTable = new PdfPTable(2);
            HeaderTable.DefaultCell.VerticalAlignment = Element.ALIGN_MIDDLE;
            HeaderTable.TotalWidth = pageSize.Width - 80;
            HeaderTable.SetWidthPercentage(new float[] { 45, 45 }, pageSize);
            
            PdfPCell HeaderLeftCell = new PdfPCell(new Phrase(8, HeaderRight, HeaderFont));
            HeaderLeftCell.Padding = 5;
            HeaderLeftCell.PaddingBottom = 8;
            HeaderLeftCell.BorderWidthRight = 0;
            HeaderTable.AddCell(HeaderLeftCell);
            
            PdfPCell HeaderRightCell = new PdfPCell(new Phrase(8, HeaderLeft, HeaderFont));
            HeaderRightCell.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
            HeaderRightCell.Padding = 5;
            HeaderRightCell.PaddingBottom = 8;
            HeaderRightCell.BorderWidthLeft = 0;
            HeaderTable.AddCell(HeaderRightCell);
            cb.SetRGBColorFill(0, 0, 0);
            HeaderTable.WriteSelectedRows(0,150, pageSize.GetLeft(40), pageSize.GetTop(50), cb);
        }
    }
public override void OnEndPage(PdfWriter writer, Document doc)
{
  
   
    int pageN = writer.PageNumber;
    if (pageN == 1)
    {
        PdfPTable TblMain = new PdfPTable(1);
        TblMain.TotalWidth = 500;
       
         Paragraph footerPAN = new Paragraph(" ",
                                           calibriMid);

        PdfPCell TblMaincell1 = new PdfPCell(footerPAN);
        TblMaincell1.Border = 0;
        TblMaincell1.PaddingLeft = 10;
        TblMaincell1.HorizontalAlignment = 2;
        TblMain.AddCell(TblMaincell1);

        PdfPCell blankCell = new PdfPCell(new Paragraph(" "));
        blankCell.Border = 0;
        TblMain.AddCell(blankCell);
        TblMain.AddCell(blankCell);
        
        PdfPCell TblMaincelAuth = new PdfPCell(new Paragraph(" ",
                                          calibriMid));
        TblMaincelAuth.Border = 0;
        TblMaincelAuth.HorizontalAlignment = 2;
        TblMain.AddCell(TblMaincelAuth);


         //-------Edited By Sandip Hirave---------
        Filed="SubFooter";
        DataSet dsSubFooter = objTRANSBAL.GetHeaderFooterDetails(ProviderID, Filed);
        StringBuilder sbfooter = new StringBuilder();
        for (int i = 0; i < dsSubFooter.Tables[0].Rows.Count; i++)
        {
            sbfooter.Append(dsSubFooter.Tables[0].Rows[i]["Value"] +"\n");
        }

       //----------Commented By Sandip Hirave-----------

        //StringBuilder sbfooter = new StringBuilder();
        //sbfooter.Append("Note:\n");

        //sbfooter.Append("1.	Payment may kindly be made by A/C payee Cheque/DD  in favour of "+Provider + " or through NEFT/RTGS in A/C No:60272647303; Bank:Bank Of Maharashtra; Branch:PRABHADEVI BRANCH; IFSC Code:MAHB0000318 \n");
        //sbfooter.Append("2.	Payment should be made within 7 days and for billing queries please reply within 7 days on response.prsm@panoramicworld.biz \n");
        //sbfooter.Append("3. Subject to Mumbai Jurisdiction\n");
        //“Panoramic Record Storage and Management Limited” or through NEFT/RTGS in A/C No:60109821609; Bank:Bank of Maharashtra; Branch:L J Road Mahim Mumbai; IFSC Code:MAHB0000108 \n");
        
        Paragraph footer = new Paragraph(sbfooter.ToString(),
                                         calibriMid);
        footer.Alignment = Element.ALIGN_LEFT;
    
        iTextSharp.text.pdf.PdfPTable footerTbl = new iTextSharp.text.pdf.PdfPTable(1);
    
        footerTbl.TotalWidth = 530;
        footerTbl.WidthPercentage = 100;

        iTextSharp.text.pdf.PdfPTable tableBorder = new iTextSharp.text.pdf.PdfPTable(1);
        float[] widthstableBorder = new float[] { 400F };
        tableBorder.SetWidths(widthstableBorder);
        tableBorder.WidthPercentage = 100;

        //-------Edited By Sandip Hirave---------
        Filed = "Footer";
        DataSet dsFooter = objTRANSBAL.GetHeaderFooterDetails(ProviderID, Filed);
        //PdfPCell cellPAN1;
        for (int i = 0; i < dsFooter.Tables[0].Rows.Count; i++)
        {
            //string Footer = dsFooter.Tables[0].Rows[i]["Value"].ToString();
            PdfPCell cellPAN1 = new PdfPCell(new Paragraph(dsFooter.Tables[0].Rows[i]["Value"].ToString(), calibriMid));
            cellPAN1.Border = 0;
            cellPAN1.PaddingBottom = 30;
            footerTbl.AddCell(cellPAN1);
        }
        //PdfPCell cellPAN1 = new PdfPCell(new Paragraph("PAN No. : AAHCA4902F                                                                          PANORAMIC RECORD STORAGE & MANAGEMENT LTD. \n \nService Tax Regn. No.- AAHCA4902FSD001\n \nService Tax category - Business Support Service.",
        
        //----------Commented By Sandip Hirave-----------
        //PdfPCell cellPAN1 = new PdfPCell(new Paragraph("PAN No. : AAHCA4902F                                                                           " + Provider + ". \nService Tax Regn. No. : AAHCA4902FSD001 \nService Tax Category : Business Support Service.",
        //                                 calibriMid));

        //cellPAN1.Border = 0;
        //cellPAN1.PaddingBottom = 30;
        //footerTbl.AddCell(cellPAN1);
        PdfPCell cellPANAuth = new PdfPCell(new Paragraph("            AUTHORISED SIGNATORY ",  calibriMid));
        cellPANAuth.VerticalAlignment = Element.ALIGN_TOP; 
        cellPANAuth.Border = 0;
        cellPANAuth.PaddingLeft=300;
        cellPANAuth.PaddingBottom=0;
        footerTbl.AddCell(cellPANAuth);

        iTextSharp.text.pdf.PdfPCell cellbo = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(""));
        cellbo = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("   "));
        cellbo.BorderColorBottom = iTextSharp.text.BaseColor.GRAY;
        cellbo.Border = 0;
        cellbo.BorderWidthLeft = 0f;
        cellbo.BorderWidthRight = 0f;
        cellbo.BorderWidthTop = 0f;
        cellbo.BorderWidthBottom = 0.4f;
        footerTbl.AddCell(cellbo);
        PdfPCell cell = new PdfPCell(footer);
        cell.Border = 0;
        cell.BorderColorTop = BaseColor.GRAY;
        footerTbl.AddCell(cell);
        footerTbl.HorizontalAlignment = Element.ALIGN_CENTER;
        TblMain.WriteSelectedRows(0, -1, 32, 320, writer.DirectContent);
        footerTbl.WriteSelectedRows(0, -1, 32, 200, writer.DirectContent);
              
    }
    String text = "Page " + pageN + " of ";
    float len = bf.GetWidthPoint(text, 8);
    Rectangle pageSize = doc.PageSize;
    cb.SetRGBColorFill(100, 100, 100);
    cb.BeginText();
    cb.SetFontAndSize(bf, 8);
    cb.SetTextMatrix(pageSize.GetLeft(240), pageSize.GetBottom(25));
    cb.ShowText(text);
    cb.EndText();
    cb.AddTemplate(template, pageSize.GetLeft(240) + len, pageSize.GetBottom(25));
    cb.BeginText();
    cb.SetFontAndSize(bf, 8);
    cb.EndText();
}
  public override void OnCloseDocument(PdfWriter writer, Document document)
{
    base.OnCloseDocument(writer, document);
    template.BeginText();
    template.SetFontAndSize(bf, 8);
    template.SetTextMatrix(0, 0);
    template.ShowText("" + (writer.PageNumber - 1));
    template.EndText();
}
     }
      public partial class WorkOrderFooter : PdfPageEventHelper
      {
    // This is the contentbyte object of the writer
    PdfContentByte cb;
    // we will put the final number of pages in a template
    PdfTemplate template;
    // this is the BaseFont we are going to use for the header / footer
    BaseFont bf = null;
    #region Properties


    private string _HeaderLeft;
    public string HeaderLeft
    {
        get { return _HeaderLeft; }
        set { _HeaderLeft = value; }
    }
    private string _HeaderRight;
    public string HeaderRight
    {
        get { return _HeaderRight; }
        set { _HeaderRight = value; }
    }
    private Font _HeaderFont;
    public Font HeaderFont
    {
        get { return _HeaderFont; }
        set { _HeaderFont = value; }
    }
    private Font _FooterFont;
    public Font FooterFont
    {
        get { return _FooterFont; }
        set { _FooterFont = value; }
    }
    #endregion
    iTextSharp.text.Font calibri = iTextSharp.text.FontFactory.GetFont("calibri", 8, iTextSharp.text.Font.NORMAL, iTextSharp.text.BaseColor.BLACK);
    iTextSharp.text.Font calibriMid = iTextSharp.text.FontFactory.GetFont("calibri", 10, iTextSharp.text.Font.NORMAL, iTextSharp.text.BaseColor.BLACK);

    public override void OnOpenDocument(PdfWriter writer, Document document)
    {
        try
        {
            //   PrintTime = DateTime.Now;
            bf = BaseFont.CreateFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
            cb = writer.DirectContent;
            template = cb.CreateTemplate(50, 50);
        }
        catch (DocumentException de)
        {
        }
        catch (System.IO.IOException ioe)
        {
        }
    }
    public override void OnStartPage(PdfWriter writer, Document document)
    {
        base.OnStartPage(writer, document);
        Rectangle pageSize = document.PageSize;

        if (HeaderLeft + HeaderRight != string.Empty)
        {
            PdfPTable HeaderTable = new PdfPTable(2);
            HeaderTable.DefaultCell.VerticalAlignment = Element.ALIGN_MIDDLE;
            HeaderTable.TotalWidth = pageSize.Width - 80;
            HeaderTable.SetWidthPercentage(new float[] { 45, 45 }, pageSize);
            
            PdfPCell HeaderLeftCell = new PdfPCell(new Phrase(8, HeaderRight, HeaderFont));
            HeaderLeftCell.Padding = 5;
            HeaderLeftCell.PaddingBottom = 8;
            HeaderLeftCell.BorderWidthRight = 0;
            HeaderTable.AddCell(HeaderLeftCell);

            PdfPCell HeaderRightCell = new PdfPCell(new Phrase(8, HeaderLeft, HeaderFont));
            HeaderRightCell.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
            HeaderRightCell.Padding = 5;
            HeaderRightCell.PaddingBottom = 8;
            HeaderRightCell.BorderWidthLeft = 0;
            HeaderTable.AddCell(HeaderRightCell);

            cb.SetRGBColorFill(0, 0, 0);
            HeaderTable.WriteSelectedRows(0, 150, pageSize.GetLeft(40), pageSize.GetTop(60), cb);
        }
    }
    public override void OnEndPage(PdfWriter writer, Document doc)
    {
        int pageN = writer.PageNumber;
        String text = "Page "+pageN+" of ";
        float len = bf.GetWidthPoint(text, 6);
        Rectangle pageSize = doc.PageSize;
        cb.SetRGBColorFill(100, 100, 100);
        cb.BeginText();
        cb.SetFontAndSize(bf, 6);
        cb.SetTextMatrix(pageSize.GetLeft(247), pageSize.GetBottom(8));
        cb.ShowText(text);
        cb.EndText();
        cb.AddTemplate(template, pageSize.GetLeft(247) + len, pageSize.GetBottom(8));
        cb.BeginText();
        cb.SetFontAndSize(bf, 6);
        cb.EndText();

    }
    public override void OnCloseDocument(PdfWriter writer, Document document)
    {
        base.OnCloseDocument(writer, document);
        template.BeginText();
        template.SetFontAndSize(bf, 6);
        template.SetTextMatrix(0, 0);
        template.ShowText("" + (writer.PageNumber - 1));
        template.EndText();

    }

}


#region [PDF Tables]

/// <summary>
/// Creating PDF tables for work order genration
/// </summary>
  public class GetPDFTables
{
    //Fonts
    iTextSharp.text.Font calibri = iTextSharp.text.FontFactory.GetFont("calibri", 8, iTextSharp.text.Font.NORMAL);
    iTextSharp.text.Font calibrismall = iTextSharp.text.FontFactory.GetFont("calibri", 7, iTextSharp.text.Font.NORMAL);
    iTextSharp.text.Font calibriLarge = iTextSharp.text.FontFactory.GetFont("calibri", 10, iTextSharp.text.Font.NORMAL);
    iTextSharp.text.Font calibriUndeline = iTextSharp.text.FontFactory.GetFont("calibri", 9, iTextSharp.text.Font.UNDERLINE, iTextSharp.text.BaseColor.BLACK);
    iTextSharp.text.Font calibribold = iTextSharp.text.FontFactory.GetFont("calibri", 9, iTextSharp.text.Font.BOLD, iTextSharp.text.BaseColor.BLACK);
    //Adding element in cell
    protected iTextSharp.text.Phrase PdfCellElement(string Elements)
    {
        return new iTextSharp.text.Phrase(Elements, calibri);
    }
    /// <summary>
    /// Default set border and bottom border or and left align
    /// </summary>
    /// <param name="PdfCellNames"></param>
    /// <param name="borderBottom"></param>
    /// <param name="borderwidth"></param>
    /// <param name="HorizontalAlignment"></param>
    public void SetDefaulfBorder(iTextSharp.text.pdf.PdfPCell[] PdfCellNames, float borderBottom, float borderwidth, int HorizontalAlignment)
    {
        for (int i = 0; i < PdfCellNames.Length; i++)
        {
            PdfCellNames[i].BorderWidth = borderwidth;
            PdfCellNames[i].BorderWidthBottom = borderBottom;
            PdfCellNames[i].HorizontalAlignment = HorizontalAlignment;
        }
    }
    public iTextSharp.text.pdf.PdfPTable PdfWOrkOrderUpdatetables()
    {
        iTextSharp.text.pdf.PdfPTable TableUpdateWorkOrder = new iTextSharp.text.pdf.PdfPTable(4);
        float[] TableUpdateWorkOrderupwidth = new float[] { 240f, 193f, 220f, 346f };
        TableUpdateWorkOrder.WidthPercentage = 100;
        TableUpdateWorkOrder.SetWidths(TableUpdateWorkOrderupwidth);

        iTextSharp.text.pdf.PdfPCell cellNameHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Name of the Person updating", calibri));
        iTextSharp.text.pdf.PdfPCell cellDateHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Date of update", calibri));
        iTextSharp.text.pdf.PdfPCell cellSignHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Signature", calibri));
        iTextSharp.text.pdf.PdfPCell cellConfirmedNoHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Confirmed by ", calibri));
        iTextSharp.text.pdf.PdfPCell[] pdfFPWOUpdatedHeaderCells = new iTextSharp.text.pdf.PdfPCell[] { cellConfirmedNoHeader, cellNameHeader, cellDateHeader, cellSignHeader };
        SetDefaulfBorder(pdfFPWOUpdatedHeaderCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        TableUpdateWorkOrder.AddCell(cellNameHeader);
        TableUpdateWorkOrder.AddCell(cellDateHeader);
        TableUpdateWorkOrder.AddCell(cellSignHeader);
        TableUpdateWorkOrder.AddCell(cellConfirmedNoHeader);
        return TableUpdateWorkOrder;

    }


    public iTextSharp.text.pdf.PdfPTable PdfTableAcknolwedgement()
    {
        iTextSharp.text.pdf.PdfPTable TableAck = new iTextSharp.text.pdf.PdfPTable(1);
        float[] TableUpdateWorkOrderupwidth = new float[] { 200f };
        TableAck.WidthPercentage = 100;
        TableAck.SetWidths(TableUpdateWorkOrderupwidth);
        iTextSharp.text.pdf.PdfPCell cellName = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Name", calibri));
        cellName.BorderWidth = 0;
        cellName.HorizontalAlignment = Element.ALIGN_LEFT;
        cellName.MinimumHeight = 15f;
        iTextSharp.text.pdf.PdfPCell cellDate = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Date", calibri));
        cellDate.BorderWidth = 0;
        cellDate.MinimumHeight = 15f;
        cellDate.HorizontalAlignment = Element.ALIGN_LEFT;
        iTextSharp.text.pdf.PdfPCell CelllStamp = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Stamp", calibri));
        CelllStamp.BorderWidth = 0;
        CelllStamp.MinimumHeight = 15f;
        CelllStamp.HorizontalAlignment = Element.ALIGN_LEFT;
        TableAck.AddCell(cellName);
        TableAck.AddCell(cellDate);
        TableAck.AddCell(CelllStamp);
        return TableAck;
    }
    public iTextSharp.text.pdf.PdfPTable PdfWOrkOrderClosuretables()
    {
        iTextSharp.text.pdf.PdfPTable TableUpdateWorkOrderclosure = new iTextSharp.text.pdf.PdfPTable(4);
        float[] TableUpdateWorkOrderclosurewidth = new float[] { 240f, 193f, 220f, 346f };
        TableUpdateWorkOrderclosure.WidthPercentage = 100;
        TableUpdateWorkOrderclosure.SetWidths(TableUpdateWorkOrderclosurewidth);
        //Activity 
        iTextSharp.text.pdf.PdfPCell cellNameActivityCloHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Name of the Person closure", calibri));
        iTextSharp.text.pdf.PdfPCell cellDateActivityCloHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Date of closure", calibri));
        iTextSharp.text.pdf.PdfPCell cellSignActivityCloHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Signature", calibri));
        iTextSharp.text.pdf.PdfPCell cellActivityCloConfirmedNoHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Confirmed by ", calibri));
        iTextSharp.text.pdf.PdfPCell[] pdfFPWOActivityCloUpdatedHeaderCells = new iTextSharp.text.pdf.PdfPCell[] { cellNameActivityCloHeader, cellDateActivityCloHeader, cellSignActivityCloHeader, cellActivityCloConfirmedNoHeader };
        SetDefaulfBorder(pdfFPWOActivityCloUpdatedHeaderCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        SetDefaulfBorder(pdfFPWOActivityCloUpdatedHeaderCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);

        TableUpdateWorkOrderclosure.AddCell(cellNameActivityCloHeader);
        TableUpdateWorkOrderclosure.AddCell(cellDateActivityCloHeader);
        TableUpdateWorkOrderclosure.AddCell(cellSignActivityCloHeader);
        TableUpdateWorkOrderclosure.AddCell(cellActivityCloConfirmedNoHeader);
        return TableUpdateWorkOrderclosure;
    }
    /// <summary>
    /// Work Order details to add in PDf header
    /// </summary>
    /// <param name="WorkOrderdetails"></param>
    /// <returns></returns>
    public iTextSharp.text.pdf.PdfPTable GetWorkOrderDetails(DataTable dtWorkOrderdetails)
    {
        iTextSharp.text.pdf.PdfPTable TableWorkOrderDetails = new iTextSharp.text.pdf.PdfPTable(5);
        
        float[] widthTableWorkOrderDetails = new float[] { 240f, 193f, 220f, 140f, 206f };
        TableWorkOrderDetails.WidthPercentage = 100;
        TableWorkOrderDetails.SetWidths(widthTableWorkOrderDetails);
        if (dtWorkOrderdetails.Rows.Count > 0)
        {
            string WOStatus = string.Empty;
            string Date = string.Empty;
            if (!string.IsNullOrEmpty(Convert.ToString(dtWorkOrderdetails.Rows[0]["WorkOrderDate"])))
            {
                Date = dtWorkOrderdetails.Rows[0]["WorkOrderDate"].ToString();
            }
            if (WOStatus != "Open")
            {
                if (!string.IsNullOrEmpty(Convert.ToString(dtWorkOrderdetails.Rows[0]["ModificationDate"])))
                {
                    WOStatus += " ";
                    WOStatus += Convert.ToString(dtWorkOrderdetails.Rows[0]["ModificationDate"].ToString());
                }
            }

            iTextSharp.text.pdf.PdfPCell cellblank = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPCell cellWoTitle = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Work Order", calibriLarge));
            iTextSharp.text.pdf.PdfPCell cellWoCilentNameHeaders = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Client Name", calibri));
            iTextSharp.text.pdf.PdfPCell cellWoCilentName = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(Convert.ToString(dtWorkOrderdetails.Rows[0]["CustomerName"]), calibrismall));
            iTextSharp.text.pdf.PdfPCell cellWoOrderNoHeaders = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Work Order No.", calibri));
            iTextSharp.text.pdf.PdfPCell cellWoOrderNo = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(Convert.ToString(dtWorkOrderdetails.Rows[0]["WorkOrderNo"]), calibri));
            iTextSharp.text.pdf.PdfPCell cellWoOrderDateHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Date", calibri));
            iTextSharp.text.pdf.PdfPCell cellWoOrderDate = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(Convert.ToString(Date), calibri));
            iTextSharp.text.pdf.PdfPCell cellWoOrdeStausHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Status", calibri));
            iTextSharp.text.pdf.PdfPCell cellWoOrdeStaus = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(Convert.ToString(dtWorkOrderdetails.Rows[0]["WoStatus"]), calibri));
            iTextSharp.text.pdf.PdfPCell[] pdfCells = new iTextSharp.text.pdf.PdfPCell[] { cellblank, cellWoCilentNameHeaders, cellWoCilentName, cellWoOrderNoHeaders, cellWoOrderNo, cellWoOrderDateHeader, cellWoOrderDate, cellWoOrdeStausHeader, cellWoOrdeStaus };
            SetDefaulfBorder(pdfCells, 0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            cellWoTitle.BorderWidth = 0f;
            cellWoTitle.HorizontalAlignment = iTextSharp.text.Element.ALIGN_CENTER;
            cellWoTitle.VerticalAlignment = iTextSharp.text.Element.ALIGN_CENTER;
            cellWoTitle.Colspan = 5;
            TableWorkOrderDetails.AddCell(cellWoTitle);
            cellblank.Colspan = 5;
            TableWorkOrderDetails.AddCell(cellblank);
          //  cellWoCilentNameHeaders.Colspan = 5;
         //   TableWorkOrderDetails.AddCell(cellWoCilentNameHeaders);
            cellblank.Colspan = 0;
            cellWoCilentNameHeaders.Colspan = 0;
            TableWorkOrderDetails.AddCell(cellWoCilentNameHeaders);
            TableWorkOrderDetails.AddCell(cellblank);
            TableWorkOrderDetails.AddCell(cellblank);
            TableWorkOrderDetails.AddCell(cellWoOrderNoHeaders);
            TableWorkOrderDetails.AddCell(cellWoOrderNo);
            cellWoCilentName.Colspan = 3;
            TableWorkOrderDetails.AddCell(cellWoCilentName);
            cellWoCilentName.Colspan = 0;
            TableWorkOrderDetails.AddCell(cellWoOrderDateHeader);
            TableWorkOrderDetails.AddCell(cellWoOrderDate);
            TableWorkOrderDetails.AddCell(cellblank);
            TableWorkOrderDetails.AddCell(cellWoOrdeStausHeader);
            TableWorkOrderDetails.AddCell(cellWoOrdeStaus);
            cellblank.Colspan = 0;
        }
        return TableWorkOrderDetails;
    }
    /// <summary>
    /// add PDF tables File pickup services
    /// </summary>
    /// <param name="dtFilePickup"></param>
    /// <param name="CurrentService"></param>
    /// <param name="TotalServices"></param>
    /// <returns></returns>
    public iTextSharp.text.pdf.PdfPTable GetFilePickup(DataTable dtFilePickup, int CurrentService, int TotalServices)
    {
        iTextSharp.text.pdf.PdfPTable TableFilePickup = new iTextSharp.text.pdf.PdfPTable(6);
        float[] TableFilePickupwidth = new float[] { 240f, 193f, 220f, 70f, 70f,206f };
        TableFilePickup.WidthPercentage = 100;
        TableFilePickup.SetWidths(TableFilePickupwidth);
        iTextSharp.text.pdf.PdfPCell cellFilePickupHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("File Pickup  " + CurrentService + "/" + TotalServices, calibriUndeline));
        cellFilePickupHeader.Colspan = 6;
        cellFilePickupHeader.BorderWidth = 0.0f;
        iTextSharp.text.pdf.PdfPCell cellAddressHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Address", calibri));
        iTextSharp.text.pdf.PdfPCell cellDepartmentHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Department", calibri));
        iTextSharp.text.pdf.PdfPCell cellContactNoHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Contact Person \n (Mobile)", calibri));
        iTextSharp.text.pdf.PdfPCell cellNoOfBoxesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("No. of \n Boxes", calibri));
        iTextSharp.text.pdf.PdfPCell cellNoOfFilesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("No. of \n Files", calibri));
        iTextSharp.text.pdf.PdfPCell cellAcknowledgementHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Acknowledgement", calibri));
      //  iTextSharp.text.pdf.PdfPCell cellborder = new iTextSharp.text.pdf.PdfPCell();
      //  cellborder.Colspan = 6;
        iTextSharp.text.pdf.PdfPCell cellbordersmall = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmall.Colspan = 6;
        cellbordersmall.BorderColor = iTextSharp.text.BaseColor.BLACK;   
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmall };
        SetDefaulfBorder(pdfRowCellsborder, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        cellNoOfBoxesHeader.Border = 1;
        iTextSharp.text.pdf.PdfPCell cellbordersmallmicro = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallmicro.Colspan = 6;
        cellbordersmallmicro.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborder = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallmicro };
        SetDefaulfBorder(pdfRowsCellsborder, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);

        iTextSharp.text.pdf.PdfPCell cellbordersmallGrey = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallGrey.Colspan = 6;
        cellbordersmallGrey.BorderColor = iTextSharp.text.BaseColor.LIGHT_GRAY;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborderGrey = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallGrey };
        SetDefaulfBorder(pdfRowsCellsborderGrey, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);


        iTextSharp.text.pdf.PdfPCell[] pdfCells = new iTextSharp.text.pdf.PdfPCell[] { cellNoOfBoxesHeader, cellNoOfFilesHeader, cellDepartmentHeader, cellContactNoHeader, cellAddressHeader, cellAcknowledgementHeader };
        SetDefaulfBorder(pdfCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell cellblank = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri)));
        cellblank.Colspan = 6;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsblank = new iTextSharp.text.pdf.PdfPCell[] { cellblank };
        SetDefaulfBorder(pdfRowCellsblank, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        //Adding Headers to file pickup
        TableFilePickup.AddCell(cellblank);
        TableFilePickup.AddCell(cellblank);
        TableFilePickup.AddCell(cellFilePickupHeader);
        TableFilePickup.AddCell(cellblank);
        TableFilePickup.AddCell(cellAddressHeader);
        TableFilePickup.AddCell(cellDepartmentHeader);
        TableFilePickup.AddCell(cellContactNoHeader);
        TableFilePickup.AddCell(cellNoOfBoxesHeader);
        TableFilePickup.AddCell(cellNoOfFilesHeader);
        TableFilePickup.AddCell(cellAcknowledgementHeader);
        TableFilePickup.AddCell(cellbordersmallGrey);
        TableFilePickup.AddCell(cellblank);
        for (int j = 0; j < dtFilePickup.Rows.Count; j++)
        {
            iTextSharp.text.pdf.PdfPCell cellCommon = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPCell cellAddressvalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFilePickup.Rows[j]["PickUpAddress"])));
            iTextSharp.text.pdf.PdfPCell cellDepartmentvalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFilePickup.Rows[j]["Department"])));
            iTextSharp.text.pdf.PdfPCell cellContactNamevalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFilePickup.Rows[j]["AuthorisedPerson"]) + "\n (" + Convert.ToString(dtFilePickup.Rows[j]["AuthPMobileNo"]) + ")"));
            iTextSharp.text.pdf.PdfPCell cellBoxCountvalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFilePickup.Rows[j]["BoxCount"])));
            iTextSharp.text.pdf.PdfPCell cellFileCountvalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFilePickup.Rows[j]["FileCount"])));
            iTextSharp.text.pdf.PdfPCell cellMobileNovalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFilePickup.Rows[j]["AuthPMobileNo"])));
            //iTextSharp.text.pdf.PdfPCell cellAcknowledgementvalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString("Name                  \n \n \n Date  \n \n Stamp  ")));
            iTextSharp.text.pdf.PdfPCell cellAcknowledgementvalue = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPTable tableACk = new iTextSharp.text.pdf.PdfPTable(1);
            tableACk = PdfTableAcknolwedgement();
            cellAcknowledgementvalue.AddElement(tableACk);
            iTextSharp.text.pdf.PdfPCell cellModifiedByvalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(""));
            iTextSharp.text.pdf.PdfPCell cellModifiedDatevalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(""));
            iTextSharp.text.pdf.PdfPCell cellModifiedbyheader = new iTextSharp.text.pdf.PdfPCell(PdfCellElement("Name  "));
            iTextSharp.text.pdf.PdfPCell cellWoModifiedDateheader = new iTextSharp.text.pdf.PdfPCell(PdfCellElement("Date "));
            iTextSharp.text.pdf.PdfPCell[] pdfRowCells = new iTextSharp.text.pdf.PdfPCell[] { cellblank, cellCommon, cellAddressvalue, cellDepartmentvalue, cellContactNamevalue, cellBoxCountvalue, cellFileCountvalue, cellMobileNovalue, cellModifiedByvalue, cellModifiedDatevalue, cellModifiedbyheader, cellWoModifiedDateheader, cellAcknowledgementvalue };
            SetDefaulfBorder(pdfRowCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            TableFilePickup.AddCell(cellAddressvalue);
            TableFilePickup.AddCell(cellDepartmentvalue);
            TableFilePickup.AddCell(cellContactNamevalue);
            TableFilePickup.AddCell(cellBoxCountvalue);
            TableFilePickup.AddCell(cellFileCountvalue);
            TableFilePickup.AddCell(cellAcknowledgementvalue);
            cellblank.Colspan = 6;
            TableFilePickup.AddCell(cellblank);
            TableFilePickup.AddCell(cellblank);
            cellbordersmallGrey.Colspan = 6;
            cellbordersmallGrey.Colspan = 6;
              
                if (j == dtFilePickup.Rows.Count - 1)
                {
                    TableFilePickup.AddCell(cellbordersmall);
                }
                else
                {
                    TableFilePickup.AddCell(cellbordersmallGrey);
                }
            if (j == dtFilePickup.Rows.Count - 1)
            {
                //Update Work Order details

                iTextSharp.text.pdf.PdfPCell cellUpdateWorkOrderHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Work Order Update ", calibriLarge));
                cellUpdateWorkOrderHeader.Colspan = 6;
               
                iTextSharp.text.pdf.PdfPCell cellUpdateActivityClosurerHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Work Order Closure", calibriLarge));
                cellUpdateActivityClosurerHeader.Colspan = 6;
               
                iTextSharp.text.pdf.PdfPCell cellActivityClosure = new iTextSharp.text.pdf.PdfPCell();
                cellActivityClosure.Colspan = 6;
                iTextSharp.text.pdf.PdfPCell cellUpdateWorkOrder = new iTextSharp.text.pdf.PdfPCell();
                cellUpdateWorkOrder.Colspan = 6;
                iTextSharp.text.pdf.PdfPCell[] pdfFPWOUpdatedCells = new iTextSharp.text.pdf.PdfPCell[] { cellUpdateWorkOrderHeader,     cellUpdateActivityClosurerHeader };
                SetDefaulfBorder(pdfFPWOUpdatedCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
               // TableFilePickup.AddCell(cellbordersmall);
                cellblank.Colspan = 6;
                TableFilePickup.AddCell(cellblank);
                cellUpdateWorkOrderHeader.HorizontalAlignment = Element.ALIGN_CENTER;
                TableFilePickup.AddCell(cellUpdateWorkOrderHeader);
               // TableFilePickup.AddCell(cellblank);
                
                cellbordersmall.Colspan = 4;
              //  TableUpdateWorkOrder.AddCell(cellbordersmall);
                iTextSharp.text.pdf.PdfPTable UpdateWorkOrderTable = PdfWOrkOrderUpdatetables();
                iTextSharp.text.pdf.PdfPTable UpdateWorkOrderClosureTable = PdfWOrkOrderClosuretables();

                cellbordersmall.Colspan = 6;
                for (int i = 0; i < dtFilePickup.Rows.Count; i++)
                {
                    cellblank.Colspan = 4;
                    UpdateWorkOrderTable.AddCell(cellblank);
                    UpdateWorkOrderClosureTable.AddCell(cellblank);
                    iTextSharp.text.pdf.PdfPCell cellNamevalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(Convert.ToString(i + 1)+") "+"_________________", calibrismall));
                    iTextSharp.text.pdf.PdfPCell cellDatevalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("_______________", calibrismall));
                    iTextSharp.text.pdf.PdfPCell cellSignvalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("_______________", calibrismall));
                    iTextSharp.text.pdf.PdfPCell cellConfirmedNovalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("_______________", calibrismall));
                    iTextSharp.text.pdf.PdfPCell[] pdfFPWOUpdatedCellsvalue = new iTextSharp.text.pdf.PdfPCell[] { cellConfirmedNovalue, cellNamevalue, cellDatevalue, cellSignvalue, cellUpdateWorkOrder, cellActivityClosure };
                    SetDefaulfBorder(pdfFPWOUpdatedCellsvalue, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
                    UpdateWorkOrderTable.AddCell(cellNamevalue);
                    UpdateWorkOrderTable.AddCell(cellDatevalue);
                    UpdateWorkOrderTable.AddCell(cellSignvalue);
                    UpdateWorkOrderTable.AddCell(cellConfirmedNovalue);

                    UpdateWorkOrderClosureTable.AddCell(cellNamevalue);
                    UpdateWorkOrderClosureTable.AddCell(cellDatevalue);
                    UpdateWorkOrderClosureTable.AddCell(cellSignvalue);
                    UpdateWorkOrderClosureTable.AddCell(cellConfirmedNovalue);
                }
                cellblank.Colspan = 6;
                cellUpdateWorkOrder.AddElement(UpdateWorkOrderTable);
               // TableFilePickup.AddCell(cellblank);
                cellActivityClosure.AddElement(UpdateWorkOrderClosureTable);
                //TableFilePickup.AddCell(cellbordersmall);
                TableFilePickup.AddCell(cellUpdateWorkOrder);
                TableFilePickup.AddCell(cellblank);
              
                TableFilePickup.AddCell(cellbordersmallmicro);
                TableFilePickup.AddCell(cellblank);
                cellUpdateActivityClosurerHeader.HorizontalAlignment = Element.ALIGN_CENTER;
                TableFilePickup.AddCell(cellUpdateActivityClosurerHeader);
                TableFilePickup.AddCell(cellActivityClosure);

            }

        }
        return TableFilePickup;
    }
    //public iTextSharp.text.pdf.PdfPTable GetFileRetrival(DataTable dtreterival, int CurrentService, int TotalServices,int TotalRetrivalActivity)
    public iTextSharp.text.pdf.PdfPTable GetFileRetrival(DataTable dtreterival, int CurrentService, int TotalServices)
    {
        iTextSharp.text.pdf.PdfPTable TableRetrival = new iTextSharp.text.pdf.PdfPTable(5);

        float[] TableFilePickupwidth = new float[] {270, 204f, 130f, 130f, 184f };
        TableRetrival.WidthPercentage = 100;
        TableRetrival.SetWidths(TableFilePickupwidth);
        iTextSharp.text.pdf.PdfPCell cellRetrivalHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Retrieval  " + CurrentService + "/" + TotalServices, calibriUndeline));
        cellRetrivalHeader.Colspan = 5;
        iTextSharp.text.pdf.PdfPCell cellPickupHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Pickup/Delivery \n Address", calibri));
        iTextSharp.text.pdf.PdfPCell cellActivityHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Activity", calibri));
        iTextSharp.text.pdf.PdfPCell cellFileBarCodeHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("File Bar Code", calibri));
        cellFileBarCodeHeader.Border = 2;
        iTextSharp.text.pdf.PdfPCell cellBoxBarCodeHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Box Bar Code", calibri));
        cellBoxBarCodeHeader.Border = 2;
        iTextSharp.text.pdf.PdfPCell cellStatusHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Acknowledgement", calibri));
        iTextSharp.text.pdf.PdfPCell cellborder = new iTextSharp.text.pdf.PdfPCell();
        cellborder.Colspan = 5;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder = new iTextSharp.text.pdf.PdfPCell[] { cellborder };
        SetDefaulfBorder(pdfRowCellsborder, 0.1f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell[] pdfCellsheader = new iTextSharp.text.pdf.PdfPCell[] { cellRetrivalHeader };
        SetDefaulfBorder(pdfCellsheader, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell[] pdfCells = new iTextSharp.text.pdf.PdfPCell[] { cellPickupHeader,cellActivityHeader, cellFileBarCodeHeader, cellBoxBarCodeHeader, cellStatusHeader };
        SetDefaulfBorder(pdfCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell cellblank = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri)));
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsblank = new iTextSharp.text.pdf.PdfPCell[] { cellblank };
        SetDefaulfBorder(pdfRowCellsblank, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        cellblank.Colspan = 5;
        
        TableRetrival.AddCell(cellblank);
        TableRetrival.AddCell(cellRetrivalHeader);
        TableRetrival.AddCell(cellblank);
        cellPickupHeader.BorderWidth = 0f;
        TableRetrival.AddCell(cellPickupHeader);
        TableRetrival.AddCell(cellActivityHeader);
        cellBoxBarCodeHeader.BorderWidth = 1f;
        TableRetrival.AddCell(cellBoxBarCodeHeader);
        TableRetrival.AddCell(cellFileBarCodeHeader);
        TableRetrival.AddCell(cellStatusHeader);
        TableRetrival.AddCell(cellborder);

        iTextSharp.text.pdf.PdfPCell cellbordersmallGrey = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallGrey.Colspan = 6;
        cellbordersmallGrey.BorderColor = iTextSharp.text.BaseColor.LIGHT_GRAY;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborderGrey = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallGrey };
        SetDefaulfBorder(pdfRowsCellsborderGrey, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);

        int  iPickupAddress = 0;
        string sPickupAddress = "";
        string sAcknlowedgement = "";
        int isborder = 0;
        int TotalPickUpAddress = 0;
        for (int i = 0; i < dtreterival.Rows.Count; i++)
        {
              
           
            if (iPickupAddress != Convert.ToInt32(dtreterival.Rows[i]["PickUpAddressId"]))
            {
                TotalPickUpAddress = TotalPickUpAddress + 1;
                PRSMBAL.MasterBAL ObjMasterBal = new MasterBAL();
                DataSet dsAuth =new DataSet();
                string strAuthorisePerson = string.Empty;
                string strAuthorisePersonContactNo = string.Empty;
                dsAuth = ObjMasterBal.GetAuthorisedPerson(Convert.ToInt32(dtreterival.Rows[i]["PickUpAddressId"]));
                    if(dsAuth !=null)
                    {
                    if(dsAuth.Tables.Count >0)
                    {
                    if(dsAuth.Tables[0].Rows.Count >0)
                    {
                        strAuthorisePerson = Convert.ToString(dsAuth.Tables[0].Rows[0]["AuthorisedPerson"]);
                        strAuthorisePersonContactNo = Convert.ToString(dsAuth.Tables[0].Rows[0]["PhoneNumber"]);
                    }
                    }
                    }
                iPickupAddress = Convert.ToInt32(dtreterival.Rows[i]["PickUpAddressId"]);
                sPickupAddress = (Convert.ToString(dtreterival.Rows[i]["PickUpAddress"]) + "\n \nContact Person :" + strAuthorisePerson + "  \n (Phone:" + strAuthorisePersonContactNo + ") ");
                sAcknlowedgement = Convert.ToString("Name                  \n \n \n Date \n \n Stamp   ");
                isborder = isborder + 1;
               
            }
            else
            {
                sPickupAddress = "";
                sAcknlowedgement="";
                isborder = 0;
            }
            string fileBarcode="";
            string BoxBarcode="";
            if(!string.IsNullOrEmpty(Convert.ToString(dtreterival.Rows[i]["FileBarCode"])))
            {
                fileBarcode = Convert.ToString(dtreterival.Rows[i]["FileBarCode"]);
            }
            if (!string.IsNullOrEmpty(Convert.ToString(dtreterival.Rows[i]["BoxBarCode"])))
            {
                BoxBarcode = Convert.ToString(dtreterival.Rows[i]["BoxBarCode"]);
            }
            iTextSharp.text.pdf.PdfPCell cellPickUpvalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(sPickupAddress, calibri));
            iTextSharp.text.pdf.PdfPCell cellActivityvalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(Convert.ToString(dtreterival.Rows[i]["ActivityName"]), calibri));
            iTextSharp.text.pdf.PdfPCell cellFileBarCodevalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(fileBarcode,calibri));
            iTextSharp.text.pdf.PdfPCell cellBoxBarCodevalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(BoxBarcode, calibri));
            iTextSharp.text.pdf.PdfPCell cellStatusvalue = new iTextSharp.text.pdf.PdfPCell();
            if (sAcknlowedgement.Trim() != "")
            {
                
               
                iTextSharp.text.pdf.PdfPTable tableACk = new iTextSharp.text.pdf.PdfPTable(1);
                tableACk = PdfTableAcknolwedgement();
                cellStatusvalue.AddElement(tableACk);
                //cellStatusvalue.AddElement(
            }
            else
            {
            //    iTextSharp.text.pdf.PdfPCell cellStatusvalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(sAcknlowedgement, calibri));
            cellStatusvalue.AddElement((new iTextSharp.text.Phrase(sAcknlowedgement, calibri)));
            }
            
            iTextSharp.text.pdf.PdfPCell[] pdfRowCellvalues = new iTextSharp.text.pdf.PdfPCell[] {cellPickUpvalue, cellActivityvalue, cellFileBarCodevalue, cellBoxBarCodevalue, cellStatusvalue };
            SetDefaulfBorder(pdfRowCellvalues, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            if (sPickupAddress != "" && i > 0)
            {
                cellblank.Colspan = 5;
                TableRetrival.AddCell(cellbordersmallGrey);
            }
            TableRetrival.AddCell(cellPickUpvalue);
            TableRetrival.AddCell(cellActivityvalue);
            TableRetrival.AddCell(cellBoxBarCodevalue);
            TableRetrival.AddCell(cellFileBarCodevalue);
            TableRetrival.AddCell(cellStatusvalue);
            cellblank.Colspan = 5;
            TableRetrival.AddCell(cellblank);
       
          
        }

        iTextSharp.text.pdf.PdfPCell cellUpdateWorkOrderHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Work Order Update ", calibriLarge));
        cellUpdateWorkOrderHeader.Colspan = 5;
        iTextSharp.text.pdf.PdfPCell cellUpdateActivityClosurerHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Work Order Closure", calibriLarge));
        cellUpdateActivityClosurerHeader.Colspan = 5;

        iTextSharp.text.pdf.PdfPCell cellActivityClosure = new iTextSharp.text.pdf.PdfPCell();
        cellActivityClosure.Colspan = 5;
        iTextSharp.text.pdf.PdfPCell cellUpdateWorkOrder = new iTextSharp.text.pdf.PdfPCell();
        cellUpdateWorkOrder.Colspan = 5;
        iTextSharp.text.pdf.PdfPCell[] pdfFPWOUpdatedCells = new iTextSharp.text.pdf.PdfPCell[] { cellUpdateWorkOrderHeader, cellUpdateActivityClosurerHeader };
        SetDefaulfBorder(pdfFPWOUpdatedCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell cellbordersmallmicro = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallmicro.Colspan = 5;
        cellbordersmallmicro.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborder = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallmicro };
        SetDefaulfBorder(pdfRowsCellsborder, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        // TableFilePickup.AddCell(cellbordersmall);
        cellblank.Colspan = 5;
        TableRetrival.AddCell(cellborder);
        TableRetrival.AddCell(cellblank);
        cellUpdateWorkOrderHeader.HorizontalAlignment = Element.ALIGN_CENTER; 
        TableRetrival.AddCell(cellUpdateWorkOrderHeader);
        // TableFilePickup.AddCell(cellblank);
        iTextSharp.text.pdf.PdfPTable UpdateWorkOrderTable = PdfWOrkOrderUpdatetables();
        iTextSharp.text.pdf.PdfPTable UpdateWorkOrderClosureTable = PdfWOrkOrderClosuretables();
       


        for (int i = 0; i < TotalPickUpAddress; i++)
        {
            cellblank.Colspan = 4;
            UpdateWorkOrderTable.AddCell(cellblank);
            UpdateWorkOrderClosureTable.AddCell(cellblank);
            iTextSharp.text.pdf.PdfPCell cellNamevalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(Convert.ToString(i + 1) + ") " + "_________________", calibrismall));
            iTextSharp.text.pdf.PdfPCell cellDatevalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("_______________", calibrismall));
            iTextSharp.text.pdf.PdfPCell cellSignvalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("_______________", calibrismall));
            iTextSharp.text.pdf.PdfPCell cellConfirmedNovalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("_______________", calibrismall));
            iTextSharp.text.pdf.PdfPCell[] pdfFPWOUpdatedCellsvalue = new iTextSharp.text.pdf.PdfPCell[] { cellConfirmedNovalue, cellNamevalue, cellDatevalue, cellSignvalue, cellUpdateWorkOrder, cellActivityClosure };
            SetDefaulfBorder(pdfFPWOUpdatedCellsvalue, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            UpdateWorkOrderTable.AddCell(cellNamevalue);
            UpdateWorkOrderTable.AddCell(cellDatevalue);
            UpdateWorkOrderTable.AddCell(cellSignvalue);
            UpdateWorkOrderTable.AddCell(cellConfirmedNovalue);
            UpdateWorkOrderClosureTable.AddCell(cellNamevalue);
            UpdateWorkOrderClosureTable.AddCell(cellDatevalue);
            UpdateWorkOrderClosureTable.AddCell(cellSignvalue);
            UpdateWorkOrderClosureTable.AddCell(cellConfirmedNovalue);
           
        }

        cellblank.Colspan = 5;
        cellUpdateWorkOrder.AddElement(UpdateWorkOrderTable);
        // TableFilePickup.AddCell(cellblank);
     
        cellActivityClosure.AddElement(UpdateWorkOrderClosureTable);
        //TableFilePickup.AddCell(cellbordersmall);
        TableRetrival.AddCell(cellUpdateWorkOrder);
        TableRetrival.AddCell(cellblank);
        TableRetrival.AddCell(cellborder);
        TableRetrival.AddCell(cellblank);
        cellUpdateActivityClosurerHeader.HorizontalAlignment = Element.ALIGN_CENTER; 
        TableRetrival.AddCell(cellUpdateActivityClosurerHeader);
        TableRetrival.AddCell(cellActivityClosure);
        return TableRetrival;
    }
    public iTextSharp.text.pdf.PdfPTable GetOtherServices(DataTable dtOtherServices, int CurrentService, int TotalServices)
    {
        iTextSharp.text.pdf.PdfPTable TableOtherServices = new iTextSharp.text.pdf.PdfPTable(3);
        float[] TableOtherServiceswidth = new float[] { 350f, 250f, 250f };
        TableOtherServices.WidthPercentage = 100;
        TableOtherServices.SetWidths(TableOtherServiceswidth);
        iTextSharp.text.pdf.PdfPCell cellOSHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Other Services  " + CurrentService + "/" + TotalServices, calibriUndeline));
        cellOSHeader.Colspan = 3;
        iTextSharp.text.pdf.PdfPCell cellActivityHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Activity", calibri));
        iTextSharp.text.pdf.PdfPCell cellNoOfServicesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Number/Quantity", calibri));
        //iTextSharp.text.pdf.PdfPCell cellStatusHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Status", calibri));
        iTextSharp.text.pdf.PdfPCell cellStatusHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri));
        iTextSharp.text.pdf.PdfPCell cellborder = new iTextSharp.text.pdf.PdfPCell();
        cellborder.Colspan = 3;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder = new iTextSharp.text.pdf.PdfPCell[] { cellborder };
        SetDefaulfBorder(pdfRowCellsborder, 0.1f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell[] pdfCells = new iTextSharp.text.pdf.PdfPCell[] { cellOSHeader, cellActivityHeader, cellNoOfServicesHeader, cellStatusHeader, cellStatusHeader };
        SetDefaulfBorder(pdfCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell cellblank = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri)));
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsblank = new iTextSharp.text.pdf.PdfPCell[] { cellblank };
        SetDefaulfBorder(pdfRowCellsblank, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        cellblank.Colspan = 3;
        TableOtherServices.AddCell(cellblank);
        TableOtherServices.AddCell(cellOSHeader);
        TableOtherServices.AddCell(cellActivityHeader);
        TableOtherServices.AddCell(cellNoOfServicesHeader);
        TableOtherServices.AddCell(cellStatusHeader);
        TableOtherServices.AddCell(cellborder);

        PRSMBAL.TransactionBAL objTRANSBAL = new TransactionBAL();
        if (HttpContext.Current.Session["WorkOrderNo"] != null && HttpContext.Current.Session["ServiceRequestId"]!=null)
        {
            int WONo = Convert.ToInt32(HttpContext.Current.Session["WorkOrderNo"].ToString());
            int iServiceRequest =Convert.ToInt32( HttpContext.Current.Session["ServiceRequestId"].ToString());
            DataSet ds = new DataSet();
            ds = objTRANSBAL.GetRetrivalBoxFileDetails(WONo, 0, 0, iServiceRequest);

            for (int j = 0; j < dtOtherServices.Rows.Count; j++)
            {
                iTextSharp.text.pdf.PdfPCell cellActivityvalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(Convert.ToString(dtOtherServices.Rows[j]["ActivityName"]), calibri));
                iTextSharp.text.pdf.PdfPCell cellFileCountvalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(Convert.ToString(dtOtherServices.Rows[j]["FileCount"]), calibri));
                //iTextSharp.text.pdf.PdfPCell cellStatusvalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(Convert.ToString(dtOtherServices.Rows[j]["WoActivityStatus"]), calibri));
                iTextSharp.text.pdf.PdfPCell cellStatusvalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(Convert.ToString(""), calibri));
                iTextSharp.text.pdf.PdfPCell[] pdfRowCellvalues = new iTextSharp.text.pdf.PdfPCell[] { cellActivityvalue, cellFileCountvalue, cellStatusvalue };
                SetDefaulfBorder(pdfRowCellvalues, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
                TableOtherServices.AddCell(cellblank);
                TableOtherServices.AddCell(cellActivityvalue);
                TableOtherServices.AddCell(cellFileCountvalue);
                TableOtherServices.AddCell(cellStatusvalue);
               // TableOtherServices.AddCell(cellblank);

                if (j == dtOtherServices.Rows.Count - 1)
                {

                    iTextSharp.text.pdf.PdfPTable TableSubOtherServices = new iTextSharp.text.pdf.PdfPTable(4);
                    float[] TableOSwidth = new float[] { 300f, 250f, 150f, 50f };
                    TableSubOtherServices.WidthPercentage = 100;
                    TableSubOtherServices.SetWidths(TableOSwidth);

                    iTextSharp.text.pdf.PdfPCell cellOSActivityHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Activity", calibri));
                    cellOSActivityHeader.BorderWidth = 0.0f;
                    iTextSharp.text.pdf.PdfPCell cellFileBarCodeHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("File Bar Code", calibri));
                    cellFileBarCodeHeader.BorderWidth = 0.0f;
                    iTextSharp.text.pdf.PdfPCell cellBoxBarCodeHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Box Bar Code", calibri));
                    cellBoxBarCodeHeader.BorderWidth = 0.0f;
                    //iTextSharp.text.pdf.PdfPCell cellOStatusHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Status", calibri));
                    iTextSharp.text.pdf.PdfPCell cellOStatusHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri));
                    cellOStatusHeader.BorderWidth = 0.0f;
                    iTextSharp.text.pdf.PdfPCell cellOSborder = new iTextSharp.text.pdf.PdfPCell();
                    cellOSborder.BorderWidth = 0.0f;
                    cellOSborder.Colspan = 4;
                    iTextSharp.text.pdf.PdfPCell cellSubOtherServices = new iTextSharp.text.pdf.PdfPCell();
                    cellSubOtherServices.Colspan = 4;
                    cellSubOtherServices.BorderWidth = 0.0f;
                    iTextSharp.text.pdf.PdfPCell[] pdfRowCellOSborder = new iTextSharp.text.pdf.PdfPCell[] { cellOSborder };
                    SetDefaulfBorder(pdfRowCellOSborder, 0.1f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
                    iTextSharp.text.pdf.PdfPCell[] pdfCell = new iTextSharp.text.pdf.PdfPCell[] { cellOSActivityHeader, cellFileBarCodeHeader, cellBoxBarCodeHeader, cellOStatusHeader };
                    SetDefaulfBorder(pdfCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
                    cellblank.Colspan = 4;
                    

                    //SetDefaulfBorder(pdfRowCellsborder, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                        {
                            if (i == 0)
                            {

                                TableOtherServices.AddCell(cellblank);
                                TableSubOtherServices.AddCell(cellOSActivityHeader);
                                TableSubOtherServices.AddCell(cellFileBarCodeHeader);
                                TableSubOtherServices.AddCell(cellBoxBarCodeHeader);
                                TableSubOtherServices.AddCell(cellOStatusHeader);
                                TableSubOtherServices.AddCell(cellOSborder);
                            }
                            TableSubOtherServices.AddCell(cellblank);
                            iTextSharp.text.pdf.PdfPCell cellSubActivityvalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(Convert.ToString(ds.Tables[0].Rows[i]["ActivityName"]), calibri));
                            cellSubActivityvalue.BorderWidth = 0.0f;
                            iTextSharp.text.pdf.PdfPCell cellFileBarCodevalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(Convert.ToString(ds.Tables[0].Rows[i]["FileBarCode"]), calibri));
                            cellFileBarCodevalue.BorderWidth = 0.0f;
                            iTextSharp.text.pdf.PdfPCell cellBoxBarCodevalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(Convert.ToString(ds.Tables[0].Rows[i]["BoxBarCode"]), calibri));
                            cellBoxBarCodevalue.BorderWidth = 0.0f;
                            //iTextSharp.text.pdf.PdfPCell cellSubStatusvalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(Convert.ToString(ds.Tables[0].Rows[i]["WoActivityStatus"]), calibri));
                            iTextSharp.text.pdf.PdfPCell cellSubStatusvalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(Convert.ToString(""), calibri));
                            cellSubStatusvalue.BorderWidth = 0.0f;
                            iTextSharp.text.pdf.PdfPCell[] pdfRowCellSubvalues = new iTextSharp.text.pdf.PdfPCell[] { cellActivityvalue, cellFileBarCodevalue, cellBoxBarCodevalue, cellSubStatusvalue };
                            // SetDefaulfBorder(pdfRowCellvalues, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
                            TableSubOtherServices.AddCell(cellSubActivityvalue);
                            TableSubOtherServices.AddCell(cellFileBarCodevalue);
                            TableSubOtherServices.AddCell(cellBoxBarCodevalue);
                            TableSubOtherServices.AddCell(cellSubStatusvalue);
                        }
                    }

                    iTextSharp.text.pdf.PdfPCell cellUpdateWorkOrderHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Work Order Update ", calibriLarge));
                    cellUpdateWorkOrderHeader.Colspan = 4;
                    iTextSharp.text.pdf.PdfPCell cellUpdateActivityClosurerHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Work Order Closure", calibriLarge));
                    cellUpdateActivityClosurerHeader.Colspan = 4;

                    iTextSharp.text.pdf.PdfPCell cellActivityClosure = new iTextSharp.text.pdf.PdfPCell();
                    cellActivityClosure.Colspan = 4;
                    iTextSharp.text.pdf.PdfPCell cellUpdateWorkOrder = new iTextSharp.text.pdf.PdfPCell();
                    cellUpdateWorkOrder.Colspan = 4;
                    iTextSharp.text.pdf.PdfPCell[] pdfFPWOUpdatedCells = new iTextSharp.text.pdf.PdfPCell[] { cellUpdateWorkOrderHeader, cellUpdateActivityClosurerHeader };
                    SetDefaulfBorder(pdfFPWOUpdatedCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
                    iTextSharp.text.pdf.PdfPCell cellbordersmallmicro = new iTextSharp.text.pdf.PdfPCell();
                    cellbordersmallmicro.Colspan = 4;
                    cellbordersmallmicro.BorderColor = iTextSharp.text.BaseColor.BLACK;
                    iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborder = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallmicro };
                    SetDefaulfBorder(pdfRowsCellsborder, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
                    // TableFilePickup.AddCell(cellbordersmall);
                  
                    // TableFilePickup.AddCell(cellblank);
                    iTextSharp.text.pdf.PdfPTable UpdateWorkOrderTable = PdfWOrkOrderUpdatetables();
                    iTextSharp.text.pdf.PdfPTable UpdateWorkOrderClosureTable = PdfWOrkOrderClosuretables();

                    for (int i = 0; i < 1; i++)
                    {
                        cellblank.Colspan = 4;
                        UpdateWorkOrderTable.AddCell(cellblank);
                        UpdateWorkOrderClosureTable.AddCell(cellblank);
                        iTextSharp.text.pdf.PdfPCell cellNamevalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(Convert.ToString(i + 1) + ") " + "_________________", calibrismall));
                        iTextSharp.text.pdf.PdfPCell cellDatevalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("_______________", calibrismall));
                        iTextSharp.text.pdf.PdfPCell cellSignvalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("_______________", calibrismall));
                        iTextSharp.text.pdf.PdfPCell cellConfirmedNovalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("_______________", calibrismall));
                        iTextSharp.text.pdf.PdfPCell[] pdfFPWOUpdatedCellsvalue = new iTextSharp.text.pdf.PdfPCell[] { cellConfirmedNovalue, cellNamevalue, cellDatevalue, cellSignvalue, cellUpdateWorkOrder, cellActivityClosure };
                        SetDefaulfBorder(pdfFPWOUpdatedCellsvalue, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
                        UpdateWorkOrderTable.AddCell(cellNamevalue);
                        UpdateWorkOrderTable.AddCell(cellDatevalue);
                        UpdateWorkOrderTable.AddCell(cellSignvalue);
                        UpdateWorkOrderTable.AddCell(cellConfirmedNovalue);

                        UpdateWorkOrderClosureTable.AddCell(cellNamevalue);
                        UpdateWorkOrderClosureTable.AddCell(cellDatevalue);
                        UpdateWorkOrderClosureTable.AddCell(cellSignvalue);
                        UpdateWorkOrderClosureTable.AddCell(cellConfirmedNovalue);
                        
                    }

                    UpdateWorkOrderClosureTable.AddCell(cellblank);
                    cellSubOtherServices.AddElement(TableSubOtherServices);
                    TableOtherServices.AddCell(cellSubOtherServices);
                    cellblank.Colspan = 4;
                    cellborder.Colspan = 4;
                    TableSubOtherServices.AddCell(cellborder);
                    TableOtherServices.AddCell(cellblank);
                    cellUpdateWorkOrderHeader.HorizontalAlignment = Element.ALIGN_CENTER;
                    TableOtherServices.AddCell(cellUpdateWorkOrderHeader);
                   // TableOtherServices.AddCell(cellblank);
                    cellblank.Colspan = 4;
                    cellUpdateWorkOrder.AddElement(UpdateWorkOrderTable);
                    // TableFilePickup.AddCell(cellblank);
                    cellActivityClosure.AddElement(UpdateWorkOrderClosureTable);
                    //TableFilePickup.AddCell(cellbordersmall);
                    TableOtherServices.AddCell(cellUpdateWorkOrder);
                    TableOtherServices.AddCell(cellblank);

                    TableOtherServices.AddCell(cellborder);
                    TableOtherServices.AddCell(cellblank);
                    cellUpdateActivityClosurerHeader.HorizontalAlignment = Element.ALIGN_CENTER; 
                    TableOtherServices.AddCell(cellUpdateActivityClosurerHeader);
                    TableOtherServices.AddCell(cellActivityClosure);
                }
            }
        }
        return TableOtherServices;


    }
    public iTextSharp.text.pdf.PdfPTable GetDestruction(DataTable dtDestruction, int CurrentService, int TotalServices)
    {

        iTextSharp.text.pdf.PdfPTable TableDestruction = new iTextSharp.text.pdf.PdfPTable(4);
        float[] TableDestructionwidth = new float[] { 100f, 450f, 150f, 50f };
        TableDestruction.WidthPercentage = 100;
        iTextSharp.text.pdf.PdfPCell cellDestructionHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Destruction  " + CurrentService + "/" + TotalServices, calibriUndeline));
        cellDestructionHeader.Colspan = 4;
        iTextSharp.text.pdf.PdfPCell CellActivityHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Activity", calibri));
        iTextSharp.text.pdf.PdfPCell CellNoBoxesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("File Bar Code", calibri));
        iTextSharp.text.pdf.PdfPCell CellNoFileHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Box Bar Code", calibri));
        iTextSharp.text.pdf.PdfPCell CellStatusHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Status", calibri));
        iTextSharp.text.pdf.PdfPCell cellborder = new iTextSharp.text.pdf.PdfPCell();
        cellborder.Colspan = 4;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder = new iTextSharp.text.pdf.PdfPCell[] { cellborder };
        SetDefaulfBorder(pdfRowCellsborder, 0.1f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell[] pdfCells = new iTextSharp.text.pdf.PdfPCell[] { cellDestructionHeader, CellActivityHeader, CellNoBoxesHeader, CellNoFileHeader, CellStatusHeader };
        SetDefaulfBorder(pdfCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell cellblank = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri)));
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsblank = new iTextSharp.text.pdf.PdfPCell[] { cellblank };
        SetDefaulfBorder(pdfRowCellsblank, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        cellblank.Colspan = 4;
        TableDestruction.AddCell(cellblank);
        TableDestruction.AddCell(cellDestructionHeader);
        TableDestruction.AddCell(CellActivityHeader);
        TableDestruction.AddCell(CellNoBoxesHeader);
        TableDestruction.AddCell(CellNoFileHeader);
        TableDestruction.AddCell(CellStatusHeader);
        TableDestruction.AddCell(cellborder);
        for (int i = 0; i < dtDestruction.Rows.Count; i++)
        {
            iTextSharp.text.pdf.PdfPCell cellActivityvalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(Convert.ToString(dtDestruction.Rows[i]["ActivityName"]), calibri));
            iTextSharp.text.pdf.PdfPCell cellBoxBarCodevalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(Convert.ToString(dtDestruction.Rows[i]["BoxBarCode"]), calibri));
            iTextSharp.text.pdf.PdfPCell cellFileBarCodevalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(Convert.ToString(dtDestruction.Rows[i]["FileBarCode"]), calibri));
            iTextSharp.text.pdf.PdfPCell cellStatusvalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(Convert.ToString(dtDestruction.Rows[i]["WoActivityStatus"]), calibri));
            iTextSharp.text.pdf.PdfPCell[] pdfRowCellvalues = new iTextSharp.text.pdf.PdfPCell[] { cellActivityvalue, cellBoxBarCodevalue, cellFileBarCodevalue, cellStatusvalue };
            SetDefaulfBorder(pdfRowCellvalues, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            TableDestruction.AddCell(cellActivityvalue);
            TableDestruction.AddCell(cellBoxBarCodevalue);
            TableDestruction.AddCell(cellFileBarCodevalue);
            TableDestruction.AddCell(cellStatusvalue);
            cellblank.Colspan = 4;
            TableDestruction.AddCell(cellblank);
        }
        return TableDestruction;
    }
    public iTextSharp.text.pdf.PdfPTable GetParmanentReturn(DataTable dtParmanentReturn, int CurrentService, int TotalServices)
    {
        iTextSharp.text.pdf.PdfPTable TableParmanentReturn = new iTextSharp.text.pdf.PdfPTable(4);
        float[] TableParmanentReturnwidth = new float[] { 100f, 450f, 150f, 50f };
        TableParmanentReturn.WidthPercentage = 100;
        iTextSharp.text.pdf.PdfPCell cellParmanentReturnHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Parmanent Return  " + CurrentService + "/" + TotalServices, calibriUndeline));
        cellParmanentReturnHeader.Colspan = 4;
        iTextSharp.text.pdf.PdfPCell CellsActivityHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Activity", calibri));
        iTextSharp.text.pdf.PdfPCell CellFileBarCodeHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("File Bar Code", calibri));
        iTextSharp.text.pdf.PdfPCell CellBoxBarCodeHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Box Bar Code", calibri));
        iTextSharp.text.pdf.PdfPCell CellStatusHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Status", calibri));
        iTextSharp.text.pdf.PdfPCell cellborder = new iTextSharp.text.pdf.PdfPCell();
        cellborder.Colspan = 4;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder = new iTextSharp.text.pdf.PdfPCell[] { cellborder };
        SetDefaulfBorder(pdfRowCellsborder, 0.1f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell[] pdfCells = new iTextSharp.text.pdf.PdfPCell[] { cellParmanentReturnHeader, CellsActivityHeader, CellFileBarCodeHeader, CellBoxBarCodeHeader, CellStatusHeader };
        SetDefaulfBorder(pdfCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell cellblank = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri)));
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsblank = new iTextSharp.text.pdf.PdfPCell[] { cellblank };
        SetDefaulfBorder(pdfRowCellsblank, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        cellblank.Colspan = 4;
        TableParmanentReturn.AddCell(cellblank);
        TableParmanentReturn.AddCell(cellParmanentReturnHeader);
        TableParmanentReturn.AddCell(cellblank);
        TableParmanentReturn.AddCell(CellsActivityHeader);
        TableParmanentReturn.AddCell(CellFileBarCodeHeader);
        TableParmanentReturn.AddCell(CellBoxBarCodeHeader);
        TableParmanentReturn.AddCell(CellStatusHeader);
        TableParmanentReturn.AddCell(cellborder);
        for (int i = 0; i < dtParmanentReturn.Rows.Count; i++)
        {
            iTextSharp.text.pdf.PdfPCell cellActivityvalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(Convert.ToString(dtParmanentReturn.Rows[i]["ActivityName"]), calibri));
            iTextSharp.text.pdf.PdfPCell cellBoxBarCodevalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(Convert.ToString(dtParmanentReturn.Rows[i]["BoxBarCode"]), calibri));
            iTextSharp.text.pdf.PdfPCell cellFileBarCodevalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(Convert.ToString(dtParmanentReturn.Rows[i]["FileBarCode"]), calibri));
            iTextSharp.text.pdf.PdfPCell cellStatusvalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(Convert.ToString(dtParmanentReturn.Rows[i]["WoActivityStatus"]), calibri));
            iTextSharp.text.pdf.PdfPCell[] pdfRowCellvalues = new iTextSharp.text.pdf.PdfPCell[] { cellActivityvalue, cellBoxBarCodevalue, cellFileBarCodevalue, cellStatusvalue };
            SetDefaulfBorder(pdfRowCellvalues, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            TableParmanentReturn.AddCell(cellActivityvalue);
            TableParmanentReturn.AddCell(cellBoxBarCodevalue);
            TableParmanentReturn.AddCell(cellFileBarCodevalue);
            TableParmanentReturn.AddCell(cellStatusvalue);
            cellblank.Colspan = 4;
            TableParmanentReturn.AddCell(cellblank);
        }

        iTextSharp.text.pdf.PdfPCell cellUpdateWorkOrderHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Work Order Update ", calibriLarge));
        cellUpdateWorkOrderHeader.Colspan = 5;
        iTextSharp.text.pdf.PdfPCell cellUpdateActivityClosurerHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Work Order Closure", calibriLarge));
        cellUpdateActivityClosurerHeader.Colspan = 5;

        iTextSharp.text.pdf.PdfPCell cellActivityClosure = new iTextSharp.text.pdf.PdfPCell();
        cellActivityClosure.Colspan = 5;
        iTextSharp.text.pdf.PdfPCell cellUpdateWorkOrder = new iTextSharp.text.pdf.PdfPCell();
        cellUpdateWorkOrder.Colspan = 5;
        iTextSharp.text.pdf.PdfPCell[] pdfFPWOUpdatedCells = new iTextSharp.text.pdf.PdfPCell[] { cellUpdateWorkOrderHeader, cellUpdateActivityClosurerHeader };
        SetDefaulfBorder(pdfFPWOUpdatedCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell cellbordersmallmicro = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallmicro.Colspan = 5;
        cellbordersmallmicro.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborder = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallmicro };
        SetDefaulfBorder(pdfRowsCellsborder, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        // TableFilePickup.AddCell(cellbordersmall);
        cellblank.Colspan = 5;
        TableParmanentReturn.AddCell(cellborder);
        TableParmanentReturn.AddCell(cellblank);
        cellUpdateWorkOrderHeader.HorizontalAlignment = Element.ALIGN_CENTER;
        TableParmanentReturn.AddCell(cellUpdateWorkOrderHeader);
        // TableFilePickup.AddCell(cellblank);

       //// cellbordersmall.Colspan = 4;
        //  TableUpdateWorkOrder.AddCell(cellbordersmall);
        iTextSharp.text.pdf.PdfPTable UpdateWorkOrderTable = PdfWOrkOrderUpdatetables();
        iTextSharp.text.pdf.PdfPTable UpdateWorkOrderClosureTable = PdfWOrkOrderClosuretables();

       //// cellbordersmall.Colspan = 6;
        //for (int i = 0; i < dtParmanentReturn.Rows.Count; i++)
        for (int i = 0; i < TotalServices; i++)
        {
            cellblank.Colspan = 4;
            UpdateWorkOrderTable.AddCell(cellblank);
            UpdateWorkOrderClosureTable.AddCell(cellblank);
            iTextSharp.text.pdf.PdfPCell cellNamevalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(Convert.ToString(i + 1) + ") " + "_________________", calibrismall));
            iTextSharp.text.pdf.PdfPCell cellDatevalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("_______________", calibrismall));
            iTextSharp.text.pdf.PdfPCell cellSignvalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("_______________", calibrismall));
            iTextSharp.text.pdf.PdfPCell cellConfirmedNovalue = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("_______________", calibrismall));
            iTextSharp.text.pdf.PdfPCell[] pdfFPWOUpdatedCellsvalue = new iTextSharp.text.pdf.PdfPCell[] { cellConfirmedNovalue, cellNamevalue, cellDatevalue, cellSignvalue, cellUpdateWorkOrder, cellActivityClosure };
            SetDefaulfBorder(pdfFPWOUpdatedCellsvalue, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            UpdateWorkOrderTable.AddCell(cellNamevalue);
            UpdateWorkOrderTable.AddCell(cellDatevalue);
            UpdateWorkOrderTable.AddCell(cellSignvalue);
            UpdateWorkOrderTable.AddCell(cellConfirmedNovalue);

            UpdateWorkOrderClosureTable.AddCell(cellNamevalue);
            UpdateWorkOrderClosureTable.AddCell(cellDatevalue);
            UpdateWorkOrderClosureTable.AddCell(cellSignvalue);
            UpdateWorkOrderClosureTable.AddCell(cellConfirmedNovalue);
        }
        cellblank.Colspan = 6;
        cellUpdateWorkOrder.AddElement(UpdateWorkOrderTable);
        // TableFilePickup.AddCell(cellblank);
        cellActivityClosure.AddElement(UpdateWorkOrderClosureTable);
        //TableFilePickup.AddCell(cellbordersmall);
        TableParmanentReturn.AddCell(cellUpdateWorkOrder);
        TableParmanentReturn.AddCell(cellblank);

        TableParmanentReturn.AddCell(cellbordersmallmicro);
        TableParmanentReturn.AddCell(cellblank);
        cellUpdateActivityClosurerHeader.HorizontalAlignment = Element.ALIGN_CENTER;
        TableParmanentReturn.AddCell(cellUpdateActivityClosurerHeader);
        TableParmanentReturn.AddCell(cellActivityClosure);

        return TableParmanentReturn;

    }

    public iTextSharp.text.pdf.PdfPTable GetServiceCompletionReportSummary(DataTable dtServiceComp, DataTable dtServicecount)
    {
            iTextSharp.text.pdf.PdfPTable TableServiceSummary = new iTextSharp.text.pdf.PdfPTable(4);
            float[] TableServiceCompwidth1 = new float[] { 240f, 100f, 100f,120f};
            TableServiceSummary.WidthPercentage = 100;
            TableServiceSummary.SetWidths(TableServiceCompwidth1);
            iTextSharp.text.pdf.PdfPCell cellServiceCompHeader1 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" "));
            cellServiceCompHeader1.VerticalAlignment = iTextSharp.text.Element.ALIGN_CENTER;
            cellServiceCompHeader1.Colspan = 4;
            cellServiceCompHeader1.BorderWidth = 0.0f;
            iTextSharp.text.pdf.PdfPCell cellCustomerHeader1 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Customer", calibri));
            iTextSharp.text.pdf.PdfPCell cellTotalWoNoeHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Total Work Order No", calibri));
            iTextSharp.text.pdf.PdfPCell cellTotalServiceHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Total Service", calibri));
            iTextSharp.text.pdf.PdfPCell cellCompletedServiceHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Completed Service", calibri));
            iTextSharp.text.pdf.PdfPCell cellbordersmall1 = new iTextSharp.text.pdf.PdfPCell();
            cellbordersmall1.Colspan = 4;
            cellbordersmall1.BorderColor = iTextSharp.text.BaseColor.BLACK;
            iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder1 = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmall1 };
            SetDefaulfBorder(pdfRowCellsborder1, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            cellServiceCompHeader1.Border = 1;
            iTextSharp.text.pdf.PdfPCell cellbordersmallmicro1 = new iTextSharp.text.pdf.PdfPCell();
            cellbordersmallmicro1.Colspan = 4;
            cellbordersmallmicro1.BorderColor = iTextSharp.text.BaseColor.BLACK;
            iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborder1 = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallmicro1 };
            SetDefaulfBorder(pdfRowsCellsborder1, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);

            iTextSharp.text.pdf.PdfPCell cellbordersmallGrey1 = new iTextSharp.text.pdf.PdfPCell();
            cellbordersmallGrey1.Colspan = 4;
            cellbordersmallGrey1.BorderColor = iTextSharp.text.BaseColor.LIGHT_GRAY;
            iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborderGrey1 = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallGrey1 };
            SetDefaulfBorder(pdfRowsCellsborderGrey1, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            iTextSharp.text.pdf.PdfPCell[] pdfCells1 = new iTextSharp.text.pdf.PdfPCell[] { cellServiceCompHeader1, cellCustomerHeader1, cellTotalWoNoeHeader, cellTotalServiceHeader, cellCompletedServiceHeader };
            SetDefaulfBorder(pdfCells1, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            iTextSharp.text.pdf.PdfPCell cellblank1 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri)));
            cellblank1.Colspan = 4;
            iTextSharp.text.pdf.PdfPCell[] pdfRowCellsblank1 = new iTextSharp.text.pdf.PdfPCell[] { cellblank1 };
            SetDefaulfBorder(pdfRowCellsblank1, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            //Adding Headers to Service completion 
            TableServiceSummary.AddCell(cellblank1);
            TableServiceSummary.AddCell(cellServiceCompHeader1);
            TableServiceSummary.AddCell(cellCustomerHeader1);
            TableServiceSummary.AddCell(cellTotalWoNoeHeader);
            TableServiceSummary.AddCell(cellTotalServiceHeader);
            TableServiceSummary.AddCell(cellCompletedServiceHeader);
            cellblank1.BorderWidth = 0.0f;
          /// setting the boreder after header
            iTextSharp.text.pdf.PdfPCell RowBoarder1 = new iTextSharp.text.pdf.PdfPCell();
            RowBoarder1.BorderColor = iTextSharp.text.BaseColor.BLACK;
            iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder11 = new iTextSharp.text.pdf.PdfPCell[] { RowBoarder1 };
            RowBoarder1.Colspan = 4;
            RowBoarder1.BorderWidth = 1;
            SetDefaulfBorder(pdfRowCellsborder11, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            TableServiceSummary.AddCell(RowBoarder1);
            TableServiceSummary.AddCell(cellblank1);
            for (int j = 0; j < dtServiceComp.Rows.Count; j++)
            {
                iTextSharp.text.pdf.PdfPCell cellCommon1 = new iTextSharp.text.pdf.PdfPCell();
                iTextSharp.text.pdf.PdfPCell cellCustomervalue1 = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtServiceComp.Rows[j]["CustomerName"])));
                iTextSharp.text.pdf.PdfPCell cellTotalWoNovalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtServiceComp.Rows[j]["TotalWoNo"])));
                iTextSharp.text.pdf.PdfPCell cellTotalServicevalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtServiceComp.Rows[j]["TotalService"])));
                iTextSharp.text.pdf.PdfPCell cellComletedServicevalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtServiceComp.Rows[j]["ComletedService"])));
                //iTextSharp.text.pdf.PdfPCell cellCompletionDateHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtServiceComp.Rows[j]["CompletionDate"])));
                iTextSharp.text.pdf.PdfPCell cellAcknowledgementvalue = new iTextSharp.text.pdf.PdfPCell();
                iTextSharp.text.pdf.PdfPTable tableACk = new iTextSharp.text.pdf.PdfPTable(1);
                iTextSharp.text.pdf.PdfPCell[] pdfRowCells = new iTextSharp.text.pdf.PdfPCell[] { cellblank1, cellCommon1, cellCustomervalue1, cellTotalWoNovalue, cellTotalServicevalue, cellComletedServicevalue };
                SetDefaulfBorder(pdfRowCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
                TableServiceSummary.AddCell(cellCustomervalue1);
                TableServiceSummary.AddCell(cellTotalWoNovalue);
                TableServiceSummary.AddCell(cellTotalServicevalue);
                TableServiceSummary.AddCell(cellComletedServicevalue);
                cellblank1.Colspan = 4;
                TableServiceSummary.AddCell(cellblank1);
                cellbordersmallGrey1.Colspan = 4;
                cellbordersmallGrey1.Colspan = 4;
          
            }
            iTextSharp.text.pdf.PdfPCell cellCommon = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPCell cellTotal= new iTextSharp.text.pdf.PdfPCell(PdfCellElement("Total"));
            iTextSharp.text.pdf.PdfPCell cellTotalWoNo = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtServicecount.Rows[0]["TotalWOCount"])));
            iTextSharp.text.pdf.PdfPCell cellTotalService = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtServicecount.Rows[0]["TotalServiceCount"])));
            iTextSharp.text.pdf.PdfPCell cellTotalComletedService = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtServicecount.Rows[0]["TotalCompletionServiceCount"])));
            //iTextSharp.text.pdf.PdfPCell cellCompletionDateHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtServiceComp.Rows[j]["CompletionDate"])));
            iTextSharp.text.pdf.PdfPCell cellAcknowledgement = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPTable tableACk1 = new iTextSharp.text.pdf.PdfPTable(1);
            iTextSharp.text.pdf.PdfPCell[] pdfRowCells1 = new iTextSharp.text.pdf.PdfPCell[] { cellblank1, cellCommon, cellTotal, cellTotalWoNo, cellTotalService, cellTotalComletedService };
            SetDefaulfBorder(pdfRowCells1, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            TableServiceSummary.AddCell(cellTotal);
            TableServiceSummary.AddCell(cellTotalWoNo);
            TableServiceSummary.AddCell(cellTotalService);
            TableServiceSummary.AddCell(cellTotalComletedService);
            cellblank1.Colspan = 4;
            TableServiceSummary.AddCell(cellblank1);
            cellbordersmallGrey1.Colspan = 4;
            cellbordersmallGrey1.Colspan = 4;

            return TableServiceSummary;
        
    }

    public iTextSharp.text.pdf.PdfPTable GetServiceCompletionReport(DataTable dtServiceComp)
    {

            iTextSharp.text.pdf.PdfPTable TableServiceComp = new iTextSharp.text.pdf.PdfPTable(5);
            float[] TableServiceCompwidth = new float[] { 240f, 193f, 150f, 120f, 215f };
            TableServiceComp.WidthPercentage = 100;
            TableServiceComp.SetWidths(TableServiceCompwidth);
            iTextSharp.text.pdf.PdfPCell cellServiceCompHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" "));
            cellServiceCompHeader.VerticalAlignment = iTextSharp.text.Element.ALIGN_CENTER;
            cellServiceCompHeader.Colspan = 5;
            cellServiceCompHeader.BorderWidth = 0.0f;
            iTextSharp.text.pdf.PdfPCell cellCustomerHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Customer", calibri));
            iTextSharp.text.pdf.PdfPCell cellRequestedServiceHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Requested Service", calibri));
            iTextSharp.text.pdf.PdfPCell cellWorkOrderNumberHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Work Order Number", calibri));
            iTextSharp.text.pdf.PdfPCell cellWorkOrderDateHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Work Order Date", calibri));
            iTextSharp.text.pdf.PdfPCell cellCompletionDateHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Completion  Date", calibri));
            iTextSharp.text.pdf.PdfPCell cellbordersmall = new iTextSharp.text.pdf.PdfPCell();
            cellbordersmall.Colspan = 5;
            cellbordersmall.BorderColor = iTextSharp.text.BaseColor.BLACK;
            iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmall };
            SetDefaulfBorder(pdfRowCellsborder, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            cellServiceCompHeader.Border = 1;
            iTextSharp.text.pdf.PdfPCell cellbordersmallmicro = new iTextSharp.text.pdf.PdfPCell();
            cellbordersmallmicro.Colspan = 5;
            cellbordersmallmicro.BorderColor = iTextSharp.text.BaseColor.BLACK;
            iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborder = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallmicro };
            SetDefaulfBorder(pdfRowsCellsborder, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);

            iTextSharp.text.pdf.PdfPCell cellbordersmallGrey = new iTextSharp.text.pdf.PdfPCell();
            cellbordersmallGrey.Colspan = 5;
            cellbordersmallGrey.BorderColor = iTextSharp.text.BaseColor.LIGHT_GRAY;
            iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborderGrey = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallGrey };
            SetDefaulfBorder(pdfRowsCellsborderGrey, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            iTextSharp.text.pdf.PdfPCell[] pdfCells = new iTextSharp.text.pdf.PdfPCell[] { cellServiceCompHeader, cellCustomerHeader, cellRequestedServiceHeader, cellWorkOrderNumberHeader, cellWorkOrderDateHeader, cellCompletionDateHeader };
            SetDefaulfBorder(pdfCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            iTextSharp.text.pdf.PdfPCell cellblank = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri)));
            cellblank.Colspan = 5;
            iTextSharp.text.pdf.PdfPCell[] pdfRowCellsblank = new iTextSharp.text.pdf.PdfPCell[] { cellblank };
            SetDefaulfBorder(pdfRowCellsblank, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            //Adding Headers to Service completion 
            TableServiceComp.AddCell(cellblank);
            TableServiceComp.AddCell(cellblank);
            TableServiceComp.AddCell(cellServiceCompHeader);
            TableServiceComp.AddCell(cellWorkOrderNumberHeader);
            TableServiceComp.AddCell(cellWorkOrderDateHeader);
            TableServiceComp.AddCell(cellCustomerHeader);
            TableServiceComp.AddCell(cellRequestedServiceHeader);
            TableServiceComp.AddCell(cellCompletionDateHeader);
            cellblank.BorderWidth = 0.0f;
            /// setting the boreder after header
            iTextSharp.text.pdf.PdfPCell RowBoarder = new iTextSharp.text.pdf.PdfPCell();
            RowBoarder.BorderColor = iTextSharp.text.BaseColor.BLACK;
            iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder111 = new iTextSharp.text.pdf.PdfPCell[] { RowBoarder };
            RowBoarder.Colspan = 5;
            RowBoarder.BorderWidth = 1;
            SetDefaulfBorder(pdfRowCellsborder111, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            TableServiceComp.AddCell(RowBoarder);
            TableServiceComp.AddCell(cellblank);
            for (int j = 0; j < dtServiceComp.Rows.Count; j++)
            {
                iTextSharp.text.pdf.PdfPCell cellCommon = new iTextSharp.text.pdf.PdfPCell();
                iTextSharp.text.pdf.PdfPCell cellCustomervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtServiceComp.Rows[j]["CustomerName"])));
                iTextSharp.text.pdf.PdfPCell cellRequestedServiceHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtServiceComp.Rows[j]["RequestedService"])));
                iTextSharp.text.pdf.PdfPCell cellWorkOrderNumberHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtServiceComp.Rows[j]["WorkorderNo"])));
                iTextSharp.text.pdf.PdfPCell cellWorkOrderDateHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtServiceComp.Rows[j]["WorkOrderDate"])));
                iTextSharp.text.pdf.PdfPCell cellCompletionDateHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtServiceComp.Rows[j]["CompletionDate"])));
                iTextSharp.text.pdf.PdfPCell cellAcknowledgementvalue = new iTextSharp.text.pdf.PdfPCell();
                iTextSharp.text.pdf.PdfPTable tableACk = new iTextSharp.text.pdf.PdfPTable(1);
                iTextSharp.text.pdf.PdfPCell[] pdfRowCells = new iTextSharp.text.pdf.PdfPCell[] { cellblank, cellCommon, cellCustomervalue, cellRequestedServiceHeadervalue, cellWorkOrderNumberHeadervalue, cellWorkOrderDateHeadervalue, cellCompletionDateHeadervalue, cellCompletionDateHeadervalue };
                SetDefaulfBorder(pdfRowCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
                TableServiceComp.AddCell(cellWorkOrderNumberHeadervalue);
                TableServiceComp.AddCell(cellWorkOrderDateHeadervalue);
                TableServiceComp.AddCell(cellCustomervalue);
                TableServiceComp.AddCell(cellRequestedServiceHeadervalue);
                TableServiceComp.AddCell(cellCompletionDateHeadervalue);
                cellblank.Colspan = 5;
                TableServiceComp.AddCell(cellblank);
                cellbordersmallGrey.Colspan = 5;
                cellbordersmallGrey.Colspan = 5;
                TableServiceComp.AddCell(cellblank);

            }
            return TableServiceComp;
    }

    public iTextSharp.text.pdf.PdfPTable GetServiceCompletionReportDateWise(DataTable dtServiceComp)
    {

        iTextSharp.text.pdf.PdfPTable TableServiceComp = new iTextSharp.text.pdf.PdfPTable(5);
        float[] TableServiceCompwidth = new float[] { 240f, 193f, 150f, 120f, 215f };
        TableServiceComp.WidthPercentage = 100;
        TableServiceComp.SetWidths(TableServiceCompwidth);
        iTextSharp.text.pdf.PdfPCell cellServiceCompHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" "));
        cellServiceCompHeader.VerticalAlignment = iTextSharp.text.Element.ALIGN_CENTER;
        cellServiceCompHeader.Colspan = 5;
        cellServiceCompHeader.BorderWidth = 0.0f;
        iTextSharp.text.pdf.PdfPCell cellCustomerHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Customer", calibri));
        iTextSharp.text.pdf.PdfPCell cellRequestedServiceHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Requested Service", calibri));
        iTextSharp.text.pdf.PdfPCell cellWorkOrderNumberHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Work Order Number", calibri));
        iTextSharp.text.pdf.PdfPCell cellWorkOrderDateHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Work Order Date", calibri));
        iTextSharp.text.pdf.PdfPCell cellCompletionDateHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Completion  Date", calibri));
        iTextSharp.text.pdf.PdfPCell cellbordersmall = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmall.Colspan = 5;
        cellbordersmall.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmall };
        SetDefaulfBorder(pdfRowCellsborder, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        cellServiceCompHeader.Border = 1;
        iTextSharp.text.pdf.PdfPCell cellbordersmallmicro = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallmicro.Colspan = 5;
        cellbordersmallmicro.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborder = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallmicro };
        SetDefaulfBorder(pdfRowsCellsborder, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);

        iTextSharp.text.pdf.PdfPCell cellbordersmallGrey = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallGrey.Colspan = 5;
        cellbordersmallGrey.BorderColor = iTextSharp.text.BaseColor.LIGHT_GRAY;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborderGrey = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallGrey };
        SetDefaulfBorder(pdfRowsCellsborderGrey, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell[] pdfCells = new iTextSharp.text.pdf.PdfPCell[] { cellServiceCompHeader, cellCustomerHeader, cellRequestedServiceHeader, cellWorkOrderNumberHeader, cellWorkOrderDateHeader, cellCompletionDateHeader };
        SetDefaulfBorder(pdfCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell cellblank = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri)));
        cellblank.Colspan = 5;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsblank = new iTextSharp.text.pdf.PdfPCell[] { cellblank };
        SetDefaulfBorder(pdfRowCellsblank, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        //Adding Headers to Service completion 
        TableServiceComp.AddCell(cellblank);
        TableServiceComp.AddCell(cellblank);
        TableServiceComp.AddCell(cellServiceCompHeader);
        TableServiceComp.AddCell(cellWorkOrderDateHeader);
        TableServiceComp.AddCell(cellWorkOrderNumberHeader);
        TableServiceComp.AddCell(cellCustomerHeader);
        TableServiceComp.AddCell(cellRequestedServiceHeader);
        TableServiceComp.AddCell(cellCompletionDateHeader);
        cellblank.BorderWidth = 0.0f;
        /// setting the boreder after header
        iTextSharp.text.pdf.PdfPCell RowBoarder = new iTextSharp.text.pdf.PdfPCell();
        RowBoarder.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder111 = new iTextSharp.text.pdf.PdfPCell[] { RowBoarder };
        RowBoarder.Colspan = 5;
        RowBoarder.BorderWidth = 1;
        SetDefaulfBorder(pdfRowCellsborder111, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        TableServiceComp.AddCell(RowBoarder);
        TableServiceComp.AddCell(cellblank);
        for (int j = 0; j < dtServiceComp.Rows.Count; j++)
        {
            iTextSharp.text.pdf.PdfPCell cellCommon = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPCell cellCustomervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtServiceComp.Rows[j]["CustomerName"])));
            iTextSharp.text.pdf.PdfPCell cellRequestedServiceHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtServiceComp.Rows[j]["RequestedService"])));
            iTextSharp.text.pdf.PdfPCell cellWorkOrderNumberHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtServiceComp.Rows[j]["WorkorderNo"])));
            iTextSharp.text.pdf.PdfPCell cellWorkOrderDateHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtServiceComp.Rows[j]["WorkOrderDate"])));
            iTextSharp.text.pdf.PdfPCell cellCompletionDateHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtServiceComp.Rows[j]["CompletionDate"])));
            iTextSharp.text.pdf.PdfPCell cellAcknowledgementvalue = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPTable tableACk = new iTextSharp.text.pdf.PdfPTable(1);
            iTextSharp.text.pdf.PdfPCell[] pdfRowCells = new iTextSharp.text.pdf.PdfPCell[] { cellblank, cellCommon, cellCustomervalue, cellRequestedServiceHeadervalue, cellWorkOrderNumberHeadervalue, cellWorkOrderDateHeadervalue, cellCompletionDateHeadervalue, cellCompletionDateHeadervalue };
            SetDefaulfBorder(pdfRowCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            TableServiceComp.AddCell(cellWorkOrderDateHeadervalue);
            TableServiceComp.AddCell(cellWorkOrderNumberHeadervalue);
            TableServiceComp.AddCell(cellCustomervalue);
            TableServiceComp.AddCell(cellRequestedServiceHeadervalue);
            TableServiceComp.AddCell(cellCompletionDateHeadervalue);
            cellblank.Colspan = 5;
            TableServiceComp.AddCell(cellblank);
            cellbordersmallGrey.Colspan = 5;
            cellbordersmallGrey.Colspan = 5;
            TableServiceComp.AddCell(cellblank);

        }
        return TableServiceComp;
    }

    public iTextSharp.text.pdf.PdfPTable GetOtherServicesReportSummary(DataTable dtOtherServices,DataTable dtNoServicesCount)
    {
        iTextSharp.text.pdf.PdfPTable TableOtherService = new iTextSharp.text.pdf.PdfPTable(8);
        float[] TableServiceCompwidth = new float[] { 340f, 100f, 100f, 100f, 100f,100f,100f,100f };
        TableOtherService.WidthPercentage = 100;
        TableOtherService.SetWidths(TableServiceCompwidth);
        iTextSharp.text.pdf.PdfPCell cellOSHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" "));
        cellOSHeader.VerticalAlignment = iTextSharp.text.Element.ALIGN_CENTER;
        cellOSHeader.Colspan = 8;
        cellOSHeader.BorderWidth = 0.0f;
        iTextSharp.text.pdf.PdfPCell cellCustomerHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Customer", calibri));
        iTextSharp.text.pdf.PdfPCell cellFaxlocalHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Fax–local", calibri));
        iTextSharp.text.pdf.PdfPCell cellPhotocopyHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Photocopy", calibri));
        iTextSharp.text.pdf.PdfPCell cellScanningEmailHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Scanning And Email", calibri));
        iTextSharp.text.pdf.PdfPCell cellFaxSTDHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Fax – STD", calibri));
        iTextSharp.text.pdf.PdfPCell cellDocSearchingInsertHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Document Searching And Insertion", calibri));
        iTextSharp.text.pdf.PdfPCell cellAuditChargesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Audit Room Charges", calibri));
        iTextSharp.text.pdf.PdfPCell cellFileRetrievalHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("File Retrieval", calibri));
        iTextSharp.text.pdf.PdfPCell cellbordersmall = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmall.Colspan = 8;
        cellbordersmall.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmall };
        SetDefaulfBorder(pdfRowCellsborder, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        cellOSHeader.Border = 1;
        iTextSharp.text.pdf.PdfPCell cellbordersmallmicro = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallmicro.Colspan = 8;
        cellbordersmallmicro.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborder = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallmicro };
        SetDefaulfBorder(pdfRowsCellsborder, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);

        iTextSharp.text.pdf.PdfPCell cellbordersmallGrey = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallGrey.Colspan = 8;
        cellbordersmallGrey.BorderColor = iTextSharp.text.BaseColor.LIGHT_GRAY;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborderGrey = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallGrey };
        SetDefaulfBorder(pdfRowsCellsborderGrey, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell[] pdfCells = new iTextSharp.text.pdf.PdfPCell[] { cellOSHeader, cellCustomerHeader, cellFaxlocalHeader, cellPhotocopyHeader, cellScanningEmailHeader, cellFaxSTDHeader, cellDocSearchingInsertHeader, cellAuditChargesHeader, cellFileRetrievalHeader };
        SetDefaulfBorder(pdfCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell cellblank = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri)));
        cellblank.Colspan = 8;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsblank = new iTextSharp.text.pdf.PdfPCell[] { cellblank };
        SetDefaulfBorder(pdfRowCellsblank, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        //Adding Headers to Service completion 
        TableOtherService.AddCell(cellblank);
        TableOtherService.AddCell(cellblank);
        TableOtherService.AddCell(cellOSHeader);
        TableOtherService.AddCell(cellCustomerHeader);
        TableOtherService.AddCell(cellFaxlocalHeader);
        TableOtherService.AddCell(cellPhotocopyHeader);
        TableOtherService.AddCell(cellScanningEmailHeader);
        TableOtherService.AddCell(cellFaxSTDHeader);
        TableOtherService.AddCell(cellDocSearchingInsertHeader);
        TableOtherService.AddCell(cellAuditChargesHeader);
        TableOtherService.AddCell(cellFileRetrievalHeader);
        cellblank.BorderWidth = 0.0f;
        /// setting the boreder after header
        iTextSharp.text.pdf.PdfPCell RowBoarder = new iTextSharp.text.pdf.PdfPCell();
        RowBoarder.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder111 = new iTextSharp.text.pdf.PdfPCell[] { RowBoarder };
        RowBoarder.Colspan = 8;
        RowBoarder.BorderWidth = 1;
        SetDefaulfBorder(pdfRowCellsborder111, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        TableOtherService.AddCell(RowBoarder);
        TableOtherService.AddCell(cellblank);
        for (int j = 0; j < dtOtherServices.Rows.Count; j++)
        {
            iTextSharp.text.pdf.PdfPCell cellCommon = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPCell cellCustomervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtOtherServices.Rows[j]["Customer Name"])));
            string FaxLocal = Convert.ToString(dtOtherServices.Rows[j]["Fax – local"]) == "" ? "0" : Convert.ToString(dtOtherServices.Rows[j]["Fax – local"]);
            string Photocopy = Convert.ToString(dtOtherServices.Rows[j]["Photocopy"]) == "" ? "0" : Convert.ToString(dtOtherServices.Rows[j]["Photocopy"]);
            string ScanningEmail = Convert.ToString(dtOtherServices.Rows[j]["Scanning & Email"]) == "" ? "0" : Convert.ToString(dtOtherServices.Rows[j]["Scanning & Email"]);
            string FaxSTD = Convert.ToString(dtOtherServices.Rows[j]["Fax – STD"]) == "" ? "0" : Convert.ToString(dtOtherServices.Rows[j]["Fax – STD"]);
            string DocearchInsertion = Convert.ToString(dtOtherServices.Rows[j]["Document Searching & Insertion"]) == "" ? "0" : Convert.ToString(dtOtherServices.Rows[j]["Document Searching & Insertion"]);
            string AuditRoomCharges = Convert.ToString(dtOtherServices.Rows[j]["Audit Room Charges"]) == "" ? "0" : Convert.ToString(dtOtherServices.Rows[j]["Audit Room Charges"]);
            string FileRetrieval = Convert.ToString(dtOtherServices.Rows[j]["File Retrieval"]) == "" ? "0" : Convert.ToString(dtOtherServices.Rows[j]["File Retrieval"]);
            iTextSharp.text.pdf.PdfPCell cellFaxlocalHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(FaxLocal));
            iTextSharp.text.pdf.PdfPCell cellPhotocopyHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Photocopy));
            iTextSharp.text.pdf.PdfPCell cellScanningEmailHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(ScanningEmail));
            iTextSharp.text.pdf.PdfPCell cellFaxSTDHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(FaxSTD));
            iTextSharp.text.pdf.PdfPCell cellDocSearchInsertHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(DocearchInsertion));
            iTextSharp.text.pdf.PdfPCell cellAuditRoomChargesHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(AuditRoomCharges));
            iTextSharp.text.pdf.PdfPCell cellFileRetHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(FileRetrieval));
            iTextSharp.text.pdf.PdfPCell cellAcknowledgementvalue = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPTable tableACk = new iTextSharp.text.pdf.PdfPTable(1);
            iTextSharp.text.pdf.PdfPCell[] pdfRowCells = new iTextSharp.text.pdf.PdfPCell[] { cellblank, cellCommon, cellCustomervalue, cellFaxlocalHeadervalue, cellPhotocopyHeadervalue, cellScanningEmailHeadervalue, cellFaxSTDHeadervalue, cellDocSearchInsertHeadervalue, cellAuditRoomChargesHeadervalue, cellFileRetHeadervalue };
            SetDefaulfBorder(pdfRowCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            TableOtherService.AddCell(cellCustomervalue);
            TableOtherService.AddCell(cellFaxlocalHeadervalue);
            TableOtherService.AddCell(cellPhotocopyHeadervalue);
            TableOtherService.AddCell(cellScanningEmailHeadervalue);
            TableOtherService.AddCell(cellFaxSTDHeadervalue);
            TableOtherService.AddCell(cellDocSearchInsertHeadervalue);
            TableOtherService.AddCell(cellAuditRoomChargesHeadervalue);
            TableOtherService.AddCell(cellFileRetHeadervalue);
            cellblank.Colspan = 8;
            TableOtherService.AddCell(cellblank);
            cellbordersmallGrey.Colspan = 8;
            cellbordersmallGrey.Colspan = 8;
            TableOtherService.AddCell(cellblank);
        }
        iTextSharp.text.pdf.PdfPCell cellCommon1 = new iTextSharp.text.pdf.PdfPCell();
        iTextSharp.text.pdf.PdfPCell cellTotal = new iTextSharp.text.pdf.PdfPCell(PdfCellElement("Total"));
        iTextSharp.text.pdf.PdfPCell cellTotalFaxlocal = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtNoServicesCount.Rows[0]["Fax – local"])));
        iTextSharp.text.pdf.PdfPCell cellTotalPhotocopy = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtNoServicesCount.Rows[0]["Photocopy"])));
        iTextSharp.text.pdf.PdfPCell cellTotalScanningEmail = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtNoServicesCount.Rows[0]["Scanning & Email"])));
        iTextSharp.text.pdf.PdfPCell cellTotalFaxSTD = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtNoServicesCount.Rows[0]["Fax – STD"])));
        iTextSharp.text.pdf.PdfPCell cellTotalDocSearchInsertion = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtNoServicesCount.Rows[0]["Document Searching & Insertion"])));
        iTextSharp.text.pdf.PdfPCell cellTotalAuditRoomCharges = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtNoServicesCount.Rows[0]["Audit Room Charges"])));
        iTextSharp.text.pdf.PdfPCell cellTotalFileRetrieval = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtNoServicesCount.Rows[0]["File Retrieval"])));
        iTextSharp.text.pdf.PdfPCell cellAcknowledgement = new iTextSharp.text.pdf.PdfPCell();
        iTextSharp.text.pdf.PdfPTable tableACk1 = new iTextSharp.text.pdf.PdfPTable(1);
        iTextSharp.text.pdf.PdfPCell[] pdfRowCells1 = new iTextSharp.text.pdf.PdfPCell[] { cellblank, cellCommon1, cellTotal, cellTotalFaxlocal, cellTotalPhotocopy, cellTotalScanningEmail, cellTotalFaxSTD, cellTotalDocSearchInsertion, cellTotalAuditRoomCharges, cellTotalFileRetrieval };
        SetDefaulfBorder(pdfRowCells1, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);

        TableOtherService.AddCell(cellblank);
        TableOtherService.AddCell(cellTotal);
        TableOtherService.AddCell(cellTotalFaxlocal);
        TableOtherService.AddCell(cellTotalPhotocopy);
        TableOtherService.AddCell(cellTotalScanningEmail);
        TableOtherService.AddCell(cellTotalFaxSTD);
        TableOtherService.AddCell(cellTotalDocSearchInsertion);
        TableOtherService.AddCell(cellTotalAuditRoomCharges);
        TableOtherService.AddCell(cellTotalFileRetrieval);
        cellblank.Colspan = 8;
        TableOtherService.AddCell(cellblank);
        cellbordersmallGrey.Colspan = 8;
        cellbordersmallGrey.Colspan = 8;
        TableOtherService.AddCell(cellblank);
        return TableOtherService;
    }

    public iTextSharp.text.pdf.PdfPTable GetOtherServicesReportWONo(DataTable dtOtherServices, DataTable dtNoServicesCount)
    {

        iTextSharp.text.pdf.PdfPTable TableOtherService = new iTextSharp.text.pdf.PdfPTable(10);
        float[] TableServiceCompwidth = new float[] { 150f, 150f, 240f, 100f, 100f, 100f, 100f, 100f,100f,100f };
        TableOtherService.WidthPercentage = 100;
        TableOtherService.SetWidths(TableServiceCompwidth);
        iTextSharp.text.pdf.PdfPCell cellOSHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" "));
        cellOSHeader.VerticalAlignment = iTextSharp.text.Element.ALIGN_CENTER;
        cellOSHeader.Colspan = 10;
        cellOSHeader.BorderWidth = 0.0f;
        iTextSharp.text.pdf.PdfPCell cellWorkOrderNoHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Work Order No.", calibri));
        iTextSharp.text.pdf.PdfPCell cellWorkOrderDateHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Work Order Date", calibri));
        iTextSharp.text.pdf.PdfPCell cellCustomerHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Customer", calibri));
        iTextSharp.text.pdf.PdfPCell cellFaxlocalHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Fax–local", calibri));
        iTextSharp.text.pdf.PdfPCell cellPhotocopyHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Photocopy", calibri));
        iTextSharp.text.pdf.PdfPCell cellScanningEmailHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Scanning And Email", calibri));
        iTextSharp.text.pdf.PdfPCell cellFaxSTDHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Fax – STD", calibri));
        iTextSharp.text.pdf.PdfPCell cellDocSearchingInsertHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Document Searching And Insertion", calibri));
        iTextSharp.text.pdf.PdfPCell cellAuditChargesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Audit Room Charges", calibri));
        iTextSharp.text.pdf.PdfPCell cellFileRetrievalHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("File Retrieval", calibri));
        iTextSharp.text.pdf.PdfPCell cellbordersmall = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmall.Colspan = 10;
        cellbordersmall.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmall };
        SetDefaulfBorder(pdfRowCellsborder, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        cellOSHeader.Border = 1;
        iTextSharp.text.pdf.PdfPCell cellbordersmallmicro = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallmicro.Colspan = 10;
        cellbordersmallmicro.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborder = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallmicro };
        SetDefaulfBorder(pdfRowsCellsborder, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);

        iTextSharp.text.pdf.PdfPCell cellbordersmallGrey = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallGrey.Colspan = 10;
        cellbordersmallGrey.BorderColor = iTextSharp.text.BaseColor.LIGHT_GRAY;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborderGrey = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallGrey };
        SetDefaulfBorder(pdfRowsCellsborderGrey, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell[] pdfCells = new iTextSharp.text.pdf.PdfPCell[] { cellOSHeader,cellWorkOrderNoHeader,cellWorkOrderDateHeader, cellCustomerHeader, cellFaxlocalHeader, cellPhotocopyHeader, cellScanningEmailHeader, cellFaxSTDHeader, cellDocSearchingInsertHeader, cellAuditChargesHeader, cellFileRetrievalHeader };
        SetDefaulfBorder(pdfCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell cellblank = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri)));
        cellblank.Colspan = 10;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsblank = new iTextSharp.text.pdf.PdfPCell[] { cellblank };
        SetDefaulfBorder(pdfRowCellsblank, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        //Adding Headers to Service completion 
        TableOtherService.AddCell(cellblank);
        TableOtherService.AddCell(cellblank);
        TableOtherService.AddCell(cellOSHeader);
        TableOtherService.AddCell(cellWorkOrderNoHeader);
        TableOtherService.AddCell(cellWorkOrderDateHeader);
        TableOtherService.AddCell(cellCustomerHeader);
        TableOtherService.AddCell(cellFaxlocalHeader);
        TableOtherService.AddCell(cellPhotocopyHeader);
        TableOtherService.AddCell(cellScanningEmailHeader);
        TableOtherService.AddCell(cellFaxSTDHeader);
        TableOtherService.AddCell(cellDocSearchingInsertHeader);
        TableOtherService.AddCell(cellAuditChargesHeader);
        TableOtherService.AddCell(cellFileRetrievalHeader);
        cellblank.BorderWidth = 0.0f;
        /// setting the boreder after header
        iTextSharp.text.pdf.PdfPCell RowBoarder = new iTextSharp.text.pdf.PdfPCell();
        RowBoarder.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder111 = new iTextSharp.text.pdf.PdfPCell[] { RowBoarder };
        RowBoarder.Colspan = 10;
        RowBoarder.BorderWidth = 1;
        SetDefaulfBorder(pdfRowCellsborder111, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        TableOtherService.AddCell(RowBoarder);
        TableOtherService.AddCell(cellblank);
        for (int j = 0; j < dtOtherServices.Rows.Count; j++)
        {
            iTextSharp.text.pdf.PdfPCell cellCommon = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPCell cellWorkOrderNoHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtOtherServices.Rows[j]["WorkorderNo"])));
            iTextSharp.text.pdf.PdfPCell cellWorkOrderDateHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtOtherServices.Rows[j]["WorkOrderDate"])));
            iTextSharp.text.pdf.PdfPCell cellCustomervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtOtherServices.Rows[j]["Customer Name"])));
            string FaxLocal = Convert.ToString(dtOtherServices.Rows[j]["Fax – local"]) == "" ? "0" : Convert.ToString(dtOtherServices.Rows[j]["Fax – local"]);
            string Photocopy = Convert.ToString(dtOtherServices.Rows[j]["Photocopy"]) == "" ? "0" : Convert.ToString(dtOtherServices.Rows[j]["Photocopy"]);
            string ScanningEmail = Convert.ToString(dtOtherServices.Rows[j]["Scanning & Email"]) == "" ? "0" : Convert.ToString(dtOtherServices.Rows[j]["Scanning & Email"]);
            string FaxSTD = Convert.ToString(dtOtherServices.Rows[j]["Fax – STD"]) == "" ? "0" : Convert.ToString(dtOtherServices.Rows[j]["Fax – STD"]);
            string DocearchInsertion = Convert.ToString(dtOtherServices.Rows[j]["Document Searching & Insertion"]) == "" ? "0" : Convert.ToString(dtOtherServices.Rows[j]["Document Searching & Insertion"]);
            string AuditRoomCharges = Convert.ToString(dtOtherServices.Rows[j]["Audit Room Charges"]) == "" ? "0" : Convert.ToString(dtOtherServices.Rows[j]["Audit Room Charges"]);
            string FileRetrieval = Convert.ToString(dtOtherServices.Rows[j]["File Retrieval"]) == "" ? "0" : Convert.ToString(dtOtherServices.Rows[j]["File Retrieval"]);
            iTextSharp.text.pdf.PdfPCell cellFaxlocalHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(FaxLocal));
            iTextSharp.text.pdf.PdfPCell cellPhotocopyHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Photocopy));
            iTextSharp.text.pdf.PdfPCell cellScanningEmailHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(ScanningEmail));
            iTextSharp.text.pdf.PdfPCell cellFaxSTDHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(FaxSTD));
            iTextSharp.text.pdf.PdfPCell cellDocSearchInsertHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(DocearchInsertion));
            iTextSharp.text.pdf.PdfPCell cellAuditRoomChargesHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(AuditRoomCharges));
            iTextSharp.text.pdf.PdfPCell cellFileRetHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(FileRetrieval));
            iTextSharp.text.pdf.PdfPCell cellAcknowledgementvalue = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPTable tableACk = new iTextSharp.text.pdf.PdfPTable(1);
            iTextSharp.text.pdf.PdfPCell[] pdfRowCells = new iTextSharp.text.pdf.PdfPCell[] { cellblank, cellCommon,cellWorkOrderNoHeadervalue,cellWorkOrderDateHeadervalue, cellCustomervalue, cellFaxlocalHeadervalue, cellPhotocopyHeadervalue, cellScanningEmailHeadervalue, cellFaxSTDHeadervalue, cellDocSearchInsertHeadervalue, cellAuditRoomChargesHeadervalue, cellFileRetHeadervalue };
            SetDefaulfBorder(pdfRowCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            TableOtherService.AddCell(cellWorkOrderNoHeadervalue);
            TableOtherService.AddCell(cellWorkOrderDateHeadervalue);
            TableOtherService.AddCell(cellCustomervalue);
            TableOtherService.AddCell(cellFaxlocalHeadervalue);
            TableOtherService.AddCell(cellPhotocopyHeadervalue);
            TableOtherService.AddCell(cellScanningEmailHeadervalue);
            TableOtherService.AddCell(cellFaxSTDHeadervalue);
            TableOtherService.AddCell(cellDocSearchInsertHeadervalue);
            TableOtherService.AddCell(cellAuditRoomChargesHeadervalue);
            TableOtherService.AddCell(cellFileRetHeadervalue);
            cellblank.Colspan = 10;
            TableOtherService.AddCell(cellblank);
            cellbordersmallGrey.Colspan = 10;
            cellbordersmallGrey.Colspan = 10;
            TableOtherService.AddCell(cellblank);

        }

        iTextSharp.text.pdf.PdfPCell cellCommon1 = new iTextSharp.text.pdf.PdfPCell();
        iTextSharp.text.pdf.PdfPCell cellTotal = new iTextSharp.text.pdf.PdfPCell(PdfCellElement("Total"));
        iTextSharp.text.pdf.PdfPCell cellTotalFaxlocal = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtNoServicesCount.Rows[0]["Fax – local"])));
        iTextSharp.text.pdf.PdfPCell cellTotalPhotocopy = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtNoServicesCount.Rows[0]["Photocopy"])));
        iTextSharp.text.pdf.PdfPCell cellTotalScanningEmail = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtNoServicesCount.Rows[0]["Scanning & Email"])));
        iTextSharp.text.pdf.PdfPCell cellTotalFaxSTD = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtNoServicesCount.Rows[0]["Fax – STD"])));
        iTextSharp.text.pdf.PdfPCell cellTotalDocSearchInsertion = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtNoServicesCount.Rows[0]["Document Searching & Insertion"])));
        iTextSharp.text.pdf.PdfPCell cellTotalAuditRoomCharges = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtNoServicesCount.Rows[0]["Audit Room Charges"])));
        iTextSharp.text.pdf.PdfPCell cellTotalFileRetrieval = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtNoServicesCount.Rows[0]["File Retrieval"])));
        iTextSharp.text.pdf.PdfPCell cellAcknowledgement = new iTextSharp.text.pdf.PdfPCell();
        iTextSharp.text.pdf.PdfPTable tableACk1 = new iTextSharp.text.pdf.PdfPTable(1);
        iTextSharp.text.pdf.PdfPCell[] pdfRowCells1 = new iTextSharp.text.pdf.PdfPCell[] { cellblank, cellCommon1, cellTotal, cellTotalFaxlocal, cellTotalPhotocopy, cellTotalScanningEmail, cellTotalFaxSTD, cellTotalDocSearchInsertion, cellTotalAuditRoomCharges, cellTotalFileRetrieval };
        SetDefaulfBorder(pdfRowCells1, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);

        iTextSharp.text.pdf.PdfPCell cellBlankHeaderlHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri));
        cellBlankHeaderlHeader.BorderWidth = 0.0f;
        iTextSharp.text.pdf.PdfPCell cellBlankHeaderlHeader1 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri));
        cellBlankHeaderlHeader1.BorderWidth = 0.0f;
        TableOtherService.AddCell(cellblank);
        TableOtherService.AddCell(cellBlankHeaderlHeader);
        TableOtherService.AddCell(cellBlankHeaderlHeader1);
        TableOtherService.AddCell(cellTotal);
        TableOtherService.AddCell(cellTotalFaxlocal);
        TableOtherService.AddCell(cellTotalPhotocopy);
        TableOtherService.AddCell(cellTotalScanningEmail);
        TableOtherService.AddCell(cellTotalFaxSTD);
        TableOtherService.AddCell(cellTotalDocSearchInsertion);
        TableOtherService.AddCell(cellTotalAuditRoomCharges);
        TableOtherService.AddCell(cellTotalFileRetrieval);
        cellblank.Colspan = 10;
        TableOtherService.AddCell(cellblank);
        cellbordersmallGrey.Colspan = 10;
        cellbordersmallGrey.Colspan = 10;
        TableOtherService.AddCell(cellblank);

        return TableOtherService;
    }

    public iTextSharp.text.pdf.PdfPTable GetOtherServicesReportWoDateWise(DataTable dtOtherServices,DataTable dtNoServicesCount)
    {

        iTextSharp.text.pdf.PdfPTable TableOtherService = new iTextSharp.text.pdf.PdfPTable(10);
        float[] TableServiceCompwidth = new float[] { 150f, 150f, 240f, 100f, 100f, 100f, 100f, 100f, 100f, 100f };
        TableOtherService.WidthPercentage = 100;
        TableOtherService.SetWidths(TableServiceCompwidth);
        iTextSharp.text.pdf.PdfPCell cellOSHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" "));
        cellOSHeader.VerticalAlignment = iTextSharp.text.Element.ALIGN_CENTER;
        cellOSHeader.Colspan = 10;
        cellOSHeader.BorderWidth = 0.0f;
        iTextSharp.text.pdf.PdfPCell cellWorkOrderDateHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Work Order Date", calibri));
        iTextSharp.text.pdf.PdfPCell cellWorkOrderNoHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Work Order No.", calibri));
        iTextSharp.text.pdf.PdfPCell cellCustomerHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Customer", calibri));
        iTextSharp.text.pdf.PdfPCell cellFaxlocalHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Fax–local", calibri));
        iTextSharp.text.pdf.PdfPCell cellPhotocopyHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Photocopy", calibri));
        iTextSharp.text.pdf.PdfPCell cellScanningEmailHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Scanning And Email", calibri));
        iTextSharp.text.pdf.PdfPCell cellFaxSTDHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Fax – STD", calibri));
        iTextSharp.text.pdf.PdfPCell cellDocSearchingInsertHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Document Searching And Insertion", calibri));
        iTextSharp.text.pdf.PdfPCell cellAuditChargesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Audit Room Charges", calibri));
        iTextSharp.text.pdf.PdfPCell cellFileRetrievalHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("File Retrieval", calibri));
        iTextSharp.text.pdf.PdfPCell cellbordersmall = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmall.Colspan = 10;
        cellbordersmall.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmall };
        SetDefaulfBorder(pdfRowCellsborder, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        cellOSHeader.Border = 1;
        iTextSharp.text.pdf.PdfPCell cellbordersmallmicro = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallmicro.Colspan = 10;
        cellbordersmallmicro.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborder = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallmicro };
        SetDefaulfBorder(pdfRowsCellsborder, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);

        iTextSharp.text.pdf.PdfPCell cellbordersmallGrey = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallGrey.Colspan = 10;
        cellbordersmallGrey.BorderColor = iTextSharp.text.BaseColor.LIGHT_GRAY;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborderGrey = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallGrey };
        SetDefaulfBorder(pdfRowsCellsborderGrey, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell[] pdfCells = new iTextSharp.text.pdf.PdfPCell[] { cellOSHeader,cellWorkOrderDateHeader, cellWorkOrderNoHeader , cellCustomerHeader, cellFaxlocalHeader, cellPhotocopyHeader, cellScanningEmailHeader, cellFaxSTDHeader, cellDocSearchingInsertHeader, cellAuditChargesHeader, cellFileRetrievalHeader };
        SetDefaulfBorder(pdfCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell cellblank = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri)));
        cellblank.Colspan = 10;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsblank = new iTextSharp.text.pdf.PdfPCell[] { cellblank };
        SetDefaulfBorder(pdfRowCellsblank, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        //Adding Headers to Service completion 
        TableOtherService.AddCell(cellblank);
        TableOtherService.AddCell(cellblank);
        TableOtherService.AddCell(cellOSHeader);
        TableOtherService.AddCell(cellWorkOrderDateHeader);
        TableOtherService.AddCell(cellWorkOrderNoHeader);
        TableOtherService.AddCell(cellCustomerHeader);
        TableOtherService.AddCell(cellFaxlocalHeader);
        TableOtherService.AddCell(cellPhotocopyHeader);
        TableOtherService.AddCell(cellScanningEmailHeader);
        TableOtherService.AddCell(cellFaxSTDHeader);
        TableOtherService.AddCell(cellDocSearchingInsertHeader);
        TableOtherService.AddCell(cellAuditChargesHeader);
        TableOtherService.AddCell(cellFileRetrievalHeader);
        cellblank.BorderWidth = 0.0f;
        /// setting the boreder after header
        iTextSharp.text.pdf.PdfPCell RowBoarder = new iTextSharp.text.pdf.PdfPCell();
        RowBoarder.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder111 = new iTextSharp.text.pdf.PdfPCell[] { RowBoarder };
        RowBoarder.Colspan = 10;
        RowBoarder.BorderWidth = 1;
        SetDefaulfBorder(pdfRowCellsborder111, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        TableOtherService.AddCell(RowBoarder);
        TableOtherService.AddCell(cellblank);
        for (int j = 0; j < dtOtherServices.Rows.Count; j++)
        {
            iTextSharp.text.pdf.PdfPCell cellCommon = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPCell cellWorkOrderNoHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtOtherServices.Rows[j]["WorkOrderNo"])));
            iTextSharp.text.pdf.PdfPCell cellWorkOrderDateHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtOtherServices.Rows[j]["WorkOrderDate"])));
            iTextSharp.text.pdf.PdfPCell cellCustomervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtOtherServices.Rows[j]["Customer Name"])));
            string FaxLocal = Convert.ToString(dtOtherServices.Rows[j]["Fax – local"]) == "" ? "0" : Convert.ToString(dtOtherServices.Rows[j]["Fax – local"]);
            string Photocopy = Convert.ToString(dtOtherServices.Rows[j]["Photocopy"]) == "" ? "0" : Convert.ToString(dtOtherServices.Rows[j]["Photocopy"]);
            string ScanningEmail = Convert.ToString(dtOtherServices.Rows[j]["Scanning & Email"]) == "" ? "0" : Convert.ToString(dtOtherServices.Rows[j]["Scanning & Email"]);
            string FaxSTD = Convert.ToString(dtOtherServices.Rows[j]["Fax – STD"]) == "" ? "0" : Convert.ToString(dtOtherServices.Rows[j]["Fax – STD"]);
            string DocearchInsertion = Convert.ToString(dtOtherServices.Rows[j]["Document Searching & Insertion"]) == "" ? "0" : Convert.ToString(dtOtherServices.Rows[j]["Document Searching & Insertion"]);
            string AuditRoomCharges = Convert.ToString(dtOtherServices.Rows[j]["Audit Room Charges"]) == "" ? "0" : Convert.ToString(dtOtherServices.Rows[j]["Audit Room Charges"]);
            string FileRetrieval = Convert.ToString(dtOtherServices.Rows[j]["File Retrieval"]) == "" ? "0" : Convert.ToString(dtOtherServices.Rows[j]["File Retrieval"]);
            iTextSharp.text.pdf.PdfPCell cellFaxlocalHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(FaxLocal));
            iTextSharp.text.pdf.PdfPCell cellPhotocopyHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Photocopy));
            iTextSharp.text.pdf.PdfPCell cellScanningEmailHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(ScanningEmail));
            iTextSharp.text.pdf.PdfPCell cellFaxSTDHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(FaxSTD));
            iTextSharp.text.pdf.PdfPCell cellDocSearchInsertHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(DocearchInsertion));
            iTextSharp.text.pdf.PdfPCell cellAuditRoomChargesHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(AuditRoomCharges));
            iTextSharp.text.pdf.PdfPCell cellFileRetHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(FileRetrieval));
            iTextSharp.text.pdf.PdfPCell cellAcknowledgementvalue = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPTable tableACk = new iTextSharp.text.pdf.PdfPTable(1);
            iTextSharp.text.pdf.PdfPCell[] pdfRowCells = new iTextSharp.text.pdf.PdfPCell[] { cellblank, cellCommon, cellWorkOrderDateHeadervalue,cellWorkOrderNoHeadervalue , cellCustomervalue, cellFaxlocalHeadervalue, cellPhotocopyHeadervalue, cellScanningEmailHeadervalue, cellFaxSTDHeadervalue, cellDocSearchInsertHeadervalue, cellAuditRoomChargesHeadervalue, cellFileRetHeadervalue };
            SetDefaulfBorder(pdfRowCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            TableOtherService.AddCell(cellWorkOrderDateHeadervalue);
            TableOtherService.AddCell(cellWorkOrderNoHeadervalue);
            TableOtherService.AddCell(cellCustomervalue);
            TableOtherService.AddCell(cellFaxlocalHeadervalue);
            TableOtherService.AddCell(cellPhotocopyHeadervalue);
            TableOtherService.AddCell(cellScanningEmailHeadervalue);
            TableOtherService.AddCell(cellFaxSTDHeadervalue);
            TableOtherService.AddCell(cellDocSearchInsertHeadervalue);
            TableOtherService.AddCell(cellAuditRoomChargesHeadervalue);
            TableOtherService.AddCell(cellFileRetHeadervalue);
            cellblank.Colspan = 10;
            TableOtherService.AddCell(cellblank);
            cellbordersmallGrey.Colspan = 10;
            cellbordersmallGrey.Colspan = 10;
            TableOtherService.AddCell(cellblank);

        }

        iTextSharp.text.pdf.PdfPCell cellCommon1 = new iTextSharp.text.pdf.PdfPCell();
        iTextSharp.text.pdf.PdfPCell cellTotal = new iTextSharp.text.pdf.PdfPCell(PdfCellElement("Total"));
        iTextSharp.text.pdf.PdfPCell cellTotalFaxlocal = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtNoServicesCount.Rows[0]["Fax – local"])));
        iTextSharp.text.pdf.PdfPCell cellTotalPhotocopy = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtNoServicesCount.Rows[0]["Photocopy"])));
        iTextSharp.text.pdf.PdfPCell cellTotalScanningEmail = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtNoServicesCount.Rows[0]["Scanning & Email"])));
        iTextSharp.text.pdf.PdfPCell cellTotalFaxSTD = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtNoServicesCount.Rows[0]["Fax – STD"])));
        iTextSharp.text.pdf.PdfPCell cellTotalDocSearchInsertion = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtNoServicesCount.Rows[0]["Document Searching & Insertion"])));
        iTextSharp.text.pdf.PdfPCell cellTotalAuditRoomCharges = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtNoServicesCount.Rows[0]["Audit Room Charges"])));
        iTextSharp.text.pdf.PdfPCell cellTotalFileRetrieval = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtNoServicesCount.Rows[0]["File Retrieval"])));
        iTextSharp.text.pdf.PdfPCell cellAcknowledgement = new iTextSharp.text.pdf.PdfPCell();
        iTextSharp.text.pdf.PdfPTable tableACk1 = new iTextSharp.text.pdf.PdfPTable(1);
        iTextSharp.text.pdf.PdfPCell[] pdfRowCells1 = new iTextSharp.text.pdf.PdfPCell[] { cellblank, cellCommon1, cellTotal, cellTotalFaxlocal, cellTotalPhotocopy, cellTotalScanningEmail, cellTotalFaxSTD, cellTotalDocSearchInsertion, cellTotalAuditRoomCharges, cellTotalFileRetrieval };
        SetDefaulfBorder(pdfRowCells1, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);

        iTextSharp.text.pdf.PdfPCell cellBlankHeaderlHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri));
        cellBlankHeaderlHeader.BorderWidth = 0.0f;
        iTextSharp.text.pdf.PdfPCell cellBlankHeaderlHeader1 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri));
        cellBlankHeaderlHeader1.BorderWidth = 0.0f;
        TableOtherService.AddCell(cellblank);
        TableOtherService.AddCell(cellBlankHeaderlHeader);
        TableOtherService.AddCell(cellBlankHeaderlHeader1);
        TableOtherService.AddCell(cellTotal);
        TableOtherService.AddCell(cellTotalFaxlocal);
        TableOtherService.AddCell(cellTotalPhotocopy);
        TableOtherService.AddCell(cellTotalScanningEmail);
        TableOtherService.AddCell(cellTotalFaxSTD);
        TableOtherService.AddCell(cellTotalDocSearchInsertion);
        TableOtherService.AddCell(cellTotalAuditRoomCharges);
        TableOtherService.AddCell(cellTotalFileRetrieval);
        cellblank.Colspan = 10;
        TableOtherService.AddCell(cellblank);
        cellbordersmallGrey.Colspan = 10;
        cellbordersmallGrey.Colspan = 10;
        TableOtherService.AddCell(cellblank);


        return TableOtherService;
    }

    public iTextSharp.text.pdf.PdfPTable GetFileRestoreRetrievalReportSummary(DataTable dtFileRestoreRetrieval,DataTable dtFileRestoreRetSum)
    {
        iTextSharp.text.pdf.PdfPTable TableFileRestoreRetrievalSummary = new iTextSharp.text.pdf.PdfPTable(5);
        float[] TableFileRestoreRetrievalCompwidth1 = new float[] { 240f, 100f, 100f, 120f, 120 };
        TableFileRestoreRetrievalSummary.WidthPercentage = 100;
        TableFileRestoreRetrievalSummary.SetWidths(TableFileRestoreRetrievalCompwidth1);
        iTextSharp.text.pdf.PdfPCell cellFileRestoreRetrievalCompHeader1 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" "));
        cellFileRestoreRetrievalCompHeader1.VerticalAlignment = iTextSharp.text.Element.ALIGN_CENTER;
        cellFileRestoreRetrievalCompHeader1.Colspan = 5;
        cellFileRestoreRetrievalCompHeader1.BorderWidth = 0.0f;
        iTextSharp.text.pdf.PdfPCell cellCustomerHeader1 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Customer Name", calibri));
        iTextSharp.text.pdf.PdfPCell cellBlankHeaderlHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri));
        cellBlankHeaderlHeader.BorderWidth = 0.0f;
        iTextSharp.text.pdf.PdfPCell cellRetrievalHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Retrieval", calibri));
        cellRetrievalHeader.VerticalAlignment = iTextSharp.text.Element.ALIGN_CENTER;
        cellRetrievalHeader.Colspan = 2;
        iTextSharp.text.pdf.PdfPCell cellRestoreHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Restore", calibri));
        cellRestoreHeader.VerticalAlignment = iTextSharp.text.Element.ALIGN_CENTER;
        cellRestoreHeader.Colspan = 2;
        iTextSharp.text.pdf.PdfPCell cellRetNoOfBoxesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("No. Of Boxes", calibri));
        iTextSharp.text.pdf.PdfPCell cellRetNoOfFilesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("No. Of Files", calibri));
        iTextSharp.text.pdf.PdfPCell cellRestoreNoOfBoxesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("No. Of Boxes", calibri));
        iTextSharp.text.pdf.PdfPCell cellRestoreNoOfFielsHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("No. Of Files", calibri));
        iTextSharp.text.pdf.PdfPCell cellbordersmall1 = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmall1.Colspan = 5;
        cellbordersmall1.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder1 = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmall1 };
        SetDefaulfBorder(pdfRowCellsborder1, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        cellFileRestoreRetrievalCompHeader1.Border = 1;
        iTextSharp.text.pdf.PdfPCell cellbordersmallmicro1 = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallmicro1.Colspan = 5;
        cellbordersmallmicro1.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborder1 = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallmicro1 };
        SetDefaulfBorder(pdfRowsCellsborder1, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);

        iTextSharp.text.pdf.PdfPCell cellbordersmallGrey1 = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallGrey1.Colspan = 5;
        cellbordersmallGrey1.BorderColor = iTextSharp.text.BaseColor.LIGHT_GRAY;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborderGrey1 = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallGrey1 };
        SetDefaulfBorder(pdfRowsCellsborderGrey1, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell[] pdfCells1 = new iTextSharp.text.pdf.PdfPCell[] { cellFileRestoreRetrievalCompHeader1, cellCustomerHeader1, cellRetrievalHeader, cellRestoreHeader, cellRetNoOfBoxesHeader, cellRetNoOfFilesHeader, cellRestoreNoOfBoxesHeader, cellRestoreNoOfFielsHeader };
        SetDefaulfBorder(pdfCells1, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell cellblank1 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri)));
        cellblank1.Colspan = 5;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsblank1 = new iTextSharp.text.pdf.PdfPCell[] { cellblank1 };
        SetDefaulfBorder(pdfRowCellsblank1, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        //Adding Headers to Service completion 
        TableFileRestoreRetrievalSummary.AddCell(cellblank1);

        TableFileRestoreRetrievalSummary.AddCell(cellFileRestoreRetrievalCompHeader1);

        TableFileRestoreRetrievalSummary.AddCell(cellBlankHeaderlHeader);
        TableFileRestoreRetrievalSummary.AddCell(cellRetrievalHeader);
        TableFileRestoreRetrievalSummary.AddCell(cellRestoreHeader);
        TableFileRestoreRetrievalSummary.AddCell(cellCustomerHeader1);
        TableFileRestoreRetrievalSummary.AddCell(cellRetNoOfBoxesHeader);
        TableFileRestoreRetrievalSummary.AddCell(cellRetNoOfFilesHeader);
        TableFileRestoreRetrievalSummary.AddCell(cellRestoreNoOfBoxesHeader);
        TableFileRestoreRetrievalSummary.AddCell(cellRestoreNoOfBoxesHeader);
        cellblank1.BorderWidth = 0.0f;
        /// setting the boreder after header
        iTextSharp.text.pdf.PdfPCell RowBoarder1 = new iTextSharp.text.pdf.PdfPCell();
        RowBoarder1.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder11 = new iTextSharp.text.pdf.PdfPCell[] { RowBoarder1 };
        RowBoarder1.Colspan = 5;
        RowBoarder1.BorderWidth = 1;
        SetDefaulfBorder(pdfRowCellsborder11, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        TableFileRestoreRetrievalSummary.AddCell(RowBoarder1);
        TableFileRestoreRetrievalSummary.AddCell(cellblank1);
        for (int j = 0; j < dtFileRestoreRetrieval.Rows.Count; j++)
        {
            iTextSharp.text.pdf.PdfPCell cellCommon1 = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPCell cellCustomerHeaderValue1 = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetrieval.Rows[j]["CustomerName"])));
            iTextSharp.text.pdf.PdfPCell cellNoOfBoxesRetHeaderValue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetrieval.Rows[j]["NoOfBoxesRet"])));
            iTextSharp.text.pdf.PdfPCell cellNoOfFilesRetHeaderValue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetrieval.Rows[j]["NoOfFilesRet"])));
            iTextSharp.text.pdf.PdfPCell cellNoOfBoxesResHeaderValue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetrieval.Rows[j]["NoOfBoxesRes"])));
            iTextSharp.text.pdf.PdfPCell cellNoOfFilesResHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetrieval.Rows[j]["NoOfFilesRes"])));
            iTextSharp.text.pdf.PdfPCell cellAcknowledgementvalue = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPTable tableACk = new iTextSharp.text.pdf.PdfPTable(1);
            iTextSharp.text.pdf.PdfPCell[] pdfRowCells = new iTextSharp.text.pdf.PdfPCell[] { cellblank1, cellCommon1, cellCustomerHeaderValue1, cellNoOfBoxesRetHeaderValue, cellNoOfFilesRetHeaderValue, cellNoOfBoxesResHeaderValue, cellNoOfFilesResHeadervalue };
            SetDefaulfBorder(pdfRowCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            TableFileRestoreRetrievalSummary.AddCell(cellCustomerHeaderValue1);
            TableFileRestoreRetrievalSummary.AddCell(cellNoOfBoxesRetHeaderValue);
            TableFileRestoreRetrievalSummary.AddCell(cellNoOfFilesRetHeaderValue);
            TableFileRestoreRetrievalSummary.AddCell(cellNoOfBoxesResHeaderValue);
            TableFileRestoreRetrievalSummary.AddCell(cellNoOfFilesResHeadervalue);
            cellblank1.Colspan = 5;
            TableFileRestoreRetrievalSummary.AddCell(cellblank1);
            cellbordersmallGrey1.Colspan = 5;
            cellbordersmallGrey1.Colspan = 5;

        }

        iTextSharp.text.pdf.PdfPCell cellCommon = new iTextSharp.text.pdf.PdfPCell();
        iTextSharp.text.pdf.PdfPCell cellTotal = new iTextSharp.text.pdf.PdfPCell(PdfCellElement("Total"));
        iTextSharp.text.pdf.PdfPCell cellTotaNoOfBoxesRet = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetSum.Rows[0]["NoOfBoxesRet"])));
        iTextSharp.text.pdf.PdfPCell cellTotalNoOfBoxesRet = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetSum.Rows[0]["NoOfFilesRet"])));
        iTextSharp.text.pdf.PdfPCell cellTotalNoOfBoxesRes = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetSum.Rows[0]["NoOfBoxesRes"])));
        iTextSharp.text.pdf.PdfPCell cellNoOfFilesRes = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetSum.Rows[0]["NoOfFilesRes"])));
        iTextSharp.text.pdf.PdfPCell cellAcknowledgement = new iTextSharp.text.pdf.PdfPCell();
        iTextSharp.text.pdf.PdfPTable tableACk1 = new iTextSharp.text.pdf.PdfPTable(1);
        iTextSharp.text.pdf.PdfPCell[] pdfRowCells1 = new iTextSharp.text.pdf.PdfPCell[] { cellblank1, cellCommon, cellTotal, cellTotaNoOfBoxesRet, cellTotalNoOfBoxesRet, cellTotalNoOfBoxesRes, cellNoOfFilesRes };
        SetDefaulfBorder(pdfRowCells1, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        TableFileRestoreRetrievalSummary.AddCell(cellTotal);
        TableFileRestoreRetrievalSummary.AddCell(cellTotaNoOfBoxesRet);
        TableFileRestoreRetrievalSummary.AddCell(cellTotalNoOfBoxesRet);
        TableFileRestoreRetrievalSummary.AddCell(cellTotalNoOfBoxesRes);
        TableFileRestoreRetrievalSummary.AddCell(cellNoOfFilesRes);
        cellblank1.Colspan = 5;
        TableFileRestoreRetrievalSummary.AddCell(cellblank1);
        cellbordersmallGrey1.Colspan = 5;
        cellbordersmallGrey1.Colspan = 5;

        return TableFileRestoreRetrievalSummary;

    }

    public iTextSharp.text.pdf.PdfPTable GetFileRestRetDeptWiseReportSummary(DataTable dtFileRestoreRetrievalDept, DataTable dtFileRestoreRetrievalCount)
    {
        iTextSharp.text.pdf.PdfPTable TableFileRestoreRetrievalDeptSummary = new iTextSharp.text.pdf.PdfPTable(3);
        float[] TableFileRestRetDeptCompwidth1 = new float[] { 200f, 100f, 100f};
        TableFileRestoreRetrievalDeptSummary.WidthPercentage = 100;
        TableFileRestoreRetrievalDeptSummary.SetWidths(TableFileRestRetDeptCompwidth1);
        iTextSharp.text.pdf.PdfPCell cellFileRestRetDeptCompHeader1 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" "));
        cellFileRestRetDeptCompHeader1.VerticalAlignment = iTextSharp.text.Element.ALIGN_CENTER;
        cellFileRestRetDeptCompHeader1.Colspan = 3;
        cellFileRestRetDeptCompHeader1.BorderWidth = 0.0f;
        iTextSharp.text.pdf.PdfPCell cellDepartmentHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Department", calibri));
        iTextSharp.text.pdf.PdfPCell cellNoOfBoxesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("No. Of Files Retrieval", calibri));
        iTextSharp.text.pdf.PdfPCell cellNoOfFilesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("No. Of Files Restore", calibri));
        iTextSharp.text.pdf.PdfPCell cellbordersmall1 = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmall1.Colspan = 3;
        cellbordersmall1.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder1 = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmall1 };
        SetDefaulfBorder(pdfRowCellsborder1, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        cellFileRestRetDeptCompHeader1.Border = 1;
        iTextSharp.text.pdf.PdfPCell cellbordersmallmicro1 = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallmicro1.Colspan = 3;
        cellbordersmallmicro1.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborder1 = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallmicro1 };
        SetDefaulfBorder(pdfRowsCellsborder1, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);

        iTextSharp.text.pdf.PdfPCell cellbordersmallGrey1 = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallGrey1.Colspan = 3;
        cellbordersmallGrey1.BorderColor = iTextSharp.text.BaseColor.LIGHT_GRAY;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborderGrey1 = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallGrey1 };
        SetDefaulfBorder(pdfRowsCellsborderGrey1, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell[] pdfCells1 = new iTextSharp.text.pdf.PdfPCell[] { cellFileRestRetDeptCompHeader1, cellDepartmentHeader, cellNoOfBoxesHeader, cellNoOfFilesHeader};
        SetDefaulfBorder(pdfCells1, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell cellblank1 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri)));
        cellblank1.Colspan = 3;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsblank1 = new iTextSharp.text.pdf.PdfPCell[] { cellblank1 };
        SetDefaulfBorder(pdfRowCellsblank1, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        //Adding Headers to Service completion 
        TableFileRestoreRetrievalDeptSummary.AddCell(cellblank1);

        TableFileRestoreRetrievalDeptSummary.AddCell(cellFileRestRetDeptCompHeader1);
        TableFileRestoreRetrievalDeptSummary.AddCell(cellDepartmentHeader);
        TableFileRestoreRetrievalDeptSummary.AddCell(cellNoOfBoxesHeader);
        TableFileRestoreRetrievalDeptSummary.AddCell(cellNoOfFilesHeader);
        cellblank1.BorderWidth = 0.0f;
        /// setting the boreder after header
        iTextSharp.text.pdf.PdfPCell RowBoarder1 = new iTextSharp.text.pdf.PdfPCell();
        RowBoarder1.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder11 = new iTextSharp.text.pdf.PdfPCell[] { RowBoarder1 };
        RowBoarder1.Colspan = 5;
        RowBoarder1.BorderWidth = 1;
        SetDefaulfBorder(pdfRowCellsborder11, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        TableFileRestoreRetrievalDeptSummary.AddCell(RowBoarder1);
        TableFileRestoreRetrievalDeptSummary.AddCell(cellblank1);
        for (int j = 0; j < dtFileRestoreRetrievalDept.Rows.Count; j++)
        {
            iTextSharp.text.pdf.PdfPCell cellCommon1 = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPCell cellDepartmentHeaderValue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetrievalDept.Rows[j]["Department"])));
            iTextSharp.text.pdf.PdfPCell cellNoOfBoxesHeaderValue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetrievalDept.Rows[j]["NoOfFilesRet"])));
            iTextSharp.text.pdf.PdfPCell cellNoOfFilesHeaderValue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetrievalDept.Rows[j]["NoOfFilesRes"])));
            iTextSharp.text.pdf.PdfPCell cellAcknowledgementvalue = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPTable tableACk = new iTextSharp.text.pdf.PdfPTable(1);
            iTextSharp.text.pdf.PdfPCell[] pdfRowCells = new iTextSharp.text.pdf.PdfPCell[] { cellblank1, cellCommon1, cellDepartmentHeaderValue, cellNoOfBoxesHeaderValue, cellNoOfFilesHeaderValue};
            SetDefaulfBorder(pdfRowCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            TableFileRestoreRetrievalDeptSummary.AddCell(cellDepartmentHeaderValue);
            TableFileRestoreRetrievalDeptSummary.AddCell(cellNoOfBoxesHeaderValue);
            TableFileRestoreRetrievalDeptSummary.AddCell(cellNoOfFilesHeaderValue);
            cellblank1.Colspan = 3;
            TableFileRestoreRetrievalDeptSummary.AddCell(cellblank1);
            cellbordersmallGrey1.Colspan = 3;
            cellbordersmallGrey1.Colspan = 3;

        }

        iTextSharp.text.pdf.PdfPCell cellCommon = new iTextSharp.text.pdf.PdfPCell();
        iTextSharp.text.pdf.PdfPCell cellTotal = new iTextSharp.text.pdf.PdfPCell(PdfCellElement("Total"));
        iTextSharp.text.pdf.PdfPCell cellTotaNoOfBoxes = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetrievalCount.Rows[0]["NoOfFilesRet"])));
        iTextSharp.text.pdf.PdfPCell cellTotalNoOfFiles = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetrievalCount.Rows[0]["NoOfFilesRes"])));
        iTextSharp.text.pdf.PdfPCell cellAcknowledgement = new iTextSharp.text.pdf.PdfPCell();
        iTextSharp.text.pdf.PdfPTable tableACk1 = new iTextSharp.text.pdf.PdfPTable(1);
        iTextSharp.text.pdf.PdfPCell[] pdfRowCells1 = new iTextSharp.text.pdf.PdfPCell[] { cellblank1, cellCommon, cellTotal, cellTotaNoOfBoxes, cellTotalNoOfFiles };
        SetDefaulfBorder(pdfRowCells1, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        TableFileRestoreRetrievalDeptSummary.AddCell(cellTotal);
        TableFileRestoreRetrievalDeptSummary.AddCell(cellTotaNoOfBoxes);
        TableFileRestoreRetrievalDeptSummary.AddCell(cellTotalNoOfFiles);
        cellblank1.Colspan = 3;
        TableFileRestoreRetrievalDeptSummary.AddCell(cellblank1);
        cellbordersmallGrey1.Colspan = 3;
        cellbordersmallGrey1.Colspan = 3;

        return TableFileRestoreRetrievalDeptSummary;

    }

    public iTextSharp.text.pdf.PdfPTable GetFileRestRetWONoWiseReportSummary(DataTable dtFileRestoreRetrieval, DataTable dtFileRestoreRetSum)
    {
        iTextSharp.text.pdf.PdfPTable TableFileRestRetDateWiseReportSummary = new iTextSharp.text.pdf.PdfPTable(7);
        float[] TableFileRestoreRetrievalCompwidth1 = new float[] { 240f, 150f, 150f, 120f, 120f, 100f, 100f };
        TableFileRestRetDateWiseReportSummary.WidthPercentage = 100;
        TableFileRestRetDateWiseReportSummary.SetWidths(TableFileRestoreRetrievalCompwidth1);
        iTextSharp.text.pdf.PdfPCell cellFileRestoreRetrievalCompHeader1 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" "));
        cellFileRestoreRetrievalCompHeader1.VerticalAlignment = iTextSharp.text.Element.ALIGN_CENTER;
        cellFileRestoreRetrievalCompHeader1.Colspan = 7;
        cellFileRestoreRetrievalCompHeader1.BorderWidth = 0.0f;
        iTextSharp.text.pdf.PdfPCell cellCustomerHeader1 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Customer Name", calibri));
        iTextSharp.text.pdf.PdfPCell cellBlankHeaderlHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri));
        cellBlankHeaderlHeader.BorderWidth = 0.0f;
        iTextSharp.text.pdf.PdfPCell cellBlankHeader2Header = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri));
        cellBlankHeader2Header.BorderWidth = 0.0f;
        iTextSharp.text.pdf.PdfPCell cellBlankHeader3Header = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri));
        cellBlankHeader3Header.BorderWidth = 0.0f;
        iTextSharp.text.pdf.PdfPCell cellRetrievalHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Retrieval", calibri));
        cellRetrievalHeader.VerticalAlignment = iTextSharp.text.Element.ALIGN_CENTER;
        cellRetrievalHeader.Colspan = 2;
        iTextSharp.text.pdf.PdfPCell cellRestoreHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Restore", calibri));
        cellRestoreHeader.VerticalAlignment = iTextSharp.text.Element.ALIGN_CENTER;
        cellRestoreHeader.Colspan = 2;
        iTextSharp.text.pdf.PdfPCell cellWorkOrderNoHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Work Order No.", calibri));
        iTextSharp.text.pdf.PdfPCell cellWorkOrderDateHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Work Order Date", calibri));
        iTextSharp.text.pdf.PdfPCell cellRetNoOfBoxesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("No. Of Boxes", calibri));
        iTextSharp.text.pdf.PdfPCell cellRetNoOfFilesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("No. Of Files", calibri));
        iTextSharp.text.pdf.PdfPCell cellRestoreNoOfBoxesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("No. Of Boxes", calibri));
        iTextSharp.text.pdf.PdfPCell cellRestoreNoOfFielsHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("No. Of Files", calibri));
        iTextSharp.text.pdf.PdfPCell cellbordersmall1 = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmall1.Colspan = 7;
        cellbordersmall1.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder1 = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmall1 };
        SetDefaulfBorder(pdfRowCellsborder1, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        cellFileRestoreRetrievalCompHeader1.Border = 1;
        iTextSharp.text.pdf.PdfPCell cellbordersmallmicro1 = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallmicro1.Colspan = 7;
        cellbordersmallmicro1.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborder1 = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallmicro1 };
        SetDefaulfBorder(pdfRowsCellsborder1, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);

        iTextSharp.text.pdf.PdfPCell cellbordersmallGrey1 = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallGrey1.Colspan = 7;
        cellbordersmallGrey1.BorderColor = iTextSharp.text.BaseColor.LIGHT_GRAY;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborderGrey1 = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallGrey1 };
        SetDefaulfBorder(pdfRowsCellsborderGrey1, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell[] pdfCells1 = new iTextSharp.text.pdf.PdfPCell[] { cellFileRestoreRetrievalCompHeader1, cellWorkOrderNoHeader, cellWorkOrderDateHeader, cellCustomerHeader1, cellRetrievalHeader, cellRestoreHeader, cellRetNoOfBoxesHeader, cellRetNoOfFilesHeader, cellRestoreNoOfBoxesHeader, cellRestoreNoOfFielsHeader };
        SetDefaulfBorder(pdfCells1, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell cellblank1 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri)));
        cellblank1.Colspan = 7;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsblank1 = new iTextSharp.text.pdf.PdfPCell[] { cellblank1 };
        SetDefaulfBorder(pdfRowCellsblank1, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        //Adding Headers to Service completion 
        TableFileRestRetDateWiseReportSummary.AddCell(cellblank1);

        TableFileRestRetDateWiseReportSummary.AddCell(cellFileRestoreRetrievalCompHeader1);

        TableFileRestRetDateWiseReportSummary.AddCell(cellBlankHeaderlHeader);
        TableFileRestRetDateWiseReportSummary.AddCell(cellBlankHeader2Header);
        TableFileRestRetDateWiseReportSummary.AddCell(cellBlankHeader3Header);
        TableFileRestRetDateWiseReportSummary.AddCell(cellRetrievalHeader);
        TableFileRestRetDateWiseReportSummary.AddCell(cellRestoreHeader);
        TableFileRestRetDateWiseReportSummary.AddCell(cellWorkOrderNoHeader);
        TableFileRestRetDateWiseReportSummary.AddCell(cellWorkOrderDateHeader);
        TableFileRestRetDateWiseReportSummary.AddCell(cellCustomerHeader1);
        TableFileRestRetDateWiseReportSummary.AddCell(cellRetNoOfBoxesHeader);
        TableFileRestRetDateWiseReportSummary.AddCell(cellRetNoOfFilesHeader);
        TableFileRestRetDateWiseReportSummary.AddCell(cellRestoreNoOfBoxesHeader);
        TableFileRestRetDateWiseReportSummary.AddCell(cellRestoreNoOfFielsHeader);
        cellblank1.BorderWidth = 0.0f;
        /// setting the boreder after header
        iTextSharp.text.pdf.PdfPCell RowBoarder1 = new iTextSharp.text.pdf.PdfPCell();
        RowBoarder1.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder11 = new iTextSharp.text.pdf.PdfPCell[] { RowBoarder1 };
        RowBoarder1.Colspan = 7;
        RowBoarder1.BorderWidth = 1;
        SetDefaulfBorder(pdfRowCellsborder11, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        TableFileRestRetDateWiseReportSummary.AddCell(RowBoarder1);
        TableFileRestRetDateWiseReportSummary.AddCell(cellblank1);
        for (int j = 0; j < dtFileRestoreRetrieval.Rows.Count; j++)
        {
            iTextSharp.text.pdf.PdfPCell cellCommon1 = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPCell cellWorkOrderDateHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetrieval.Rows[j]["WorkOrderDate"])));
            iTextSharp.text.pdf.PdfPCell cellWorkOrderNoHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetrieval.Rows[j]["WorkOrderNo"])));
            iTextSharp.text.pdf.PdfPCell cellCustomerHeaderValue1 = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetrieval.Rows[j]["CustomerName"])));
            iTextSharp.text.pdf.PdfPCell cellNoOfBoxesRetHeaderValue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetrieval.Rows[j]["NoOfBoxesRet"])));
            iTextSharp.text.pdf.PdfPCell cellNoOfFilesRetHeaderValue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetrieval.Rows[j]["NoOfFilesRet"])));
            iTextSharp.text.pdf.PdfPCell cellNoOfBoxesResHeaderValue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetrieval.Rows[j]["NoOfBoxesRes"])));
            iTextSharp.text.pdf.PdfPCell cellNoOfFilesResHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetrieval.Rows[j]["NoOfFilesRes"])));
            iTextSharp.text.pdf.PdfPCell cellAcknowledgementvalue = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPTable tableACk = new iTextSharp.text.pdf.PdfPTable(1);
            iTextSharp.text.pdf.PdfPCell[] pdfRowCells = new iTextSharp.text.pdf.PdfPCell[] { cellblank1, cellCommon1, cellWorkOrderNoHeadervalue, cellWorkOrderDateHeadervalue, cellCustomerHeaderValue1, cellNoOfBoxesRetHeaderValue, cellNoOfFilesRetHeaderValue, cellNoOfBoxesResHeaderValue, cellNoOfFilesResHeadervalue };
            SetDefaulfBorder(pdfRowCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            TableFileRestRetDateWiseReportSummary.AddCell(cellWorkOrderNoHeadervalue);
            TableFileRestRetDateWiseReportSummary.AddCell(cellWorkOrderDateHeadervalue);
            TableFileRestRetDateWiseReportSummary.AddCell(cellCustomerHeaderValue1);
            TableFileRestRetDateWiseReportSummary.AddCell(cellNoOfBoxesRetHeaderValue);
            TableFileRestRetDateWiseReportSummary.AddCell(cellNoOfFilesRetHeaderValue);
            TableFileRestRetDateWiseReportSummary.AddCell(cellNoOfBoxesResHeaderValue);
            TableFileRestRetDateWiseReportSummary.AddCell(cellNoOfFilesResHeadervalue);
            cellblank1.Colspan = 7;
            TableFileRestRetDateWiseReportSummary.AddCell(cellblank1);
            cellbordersmallGrey1.Colspan = 7;
            cellbordersmallGrey1.Colspan = 7;

        }

        iTextSharp.text.pdf.PdfPCell cellCommon = new iTextSharp.text.pdf.PdfPCell();
        iTextSharp.text.pdf.PdfPCell cellTotal = new iTextSharp.text.pdf.PdfPCell(PdfCellElement("Total"));
        iTextSharp.text.pdf.PdfPCell cellTotaNoOfBoxesRet = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetSum.Rows[0]["NoOfBoxesRet"])));
        iTextSharp.text.pdf.PdfPCell cellTotalNoOfBoxesRet = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetSum.Rows[0]["NoOfFilesRet"])));
        iTextSharp.text.pdf.PdfPCell cellTotalNoOfBoxesRes = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetSum.Rows[0]["NoOfBoxesRes"])));
        iTextSharp.text.pdf.PdfPCell cellNoOfFilesRes = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetSum.Rows[0]["NoOfFilesRes"])));
        iTextSharp.text.pdf.PdfPCell cellAcknowledgement = new iTextSharp.text.pdf.PdfPCell();
        iTextSharp.text.pdf.PdfPTable tableACk1 = new iTextSharp.text.pdf.PdfPTable(1);
        iTextSharp.text.pdf.PdfPCell[] pdfRowCells1 = new iTextSharp.text.pdf.PdfPCell[] { cellblank1, cellCommon, cellTotal, cellTotaNoOfBoxesRet, cellTotalNoOfBoxesRet, cellTotalNoOfBoxesRes, cellNoOfFilesRes };
        SetDefaulfBorder(pdfRowCells1, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell cellBlankHeaderTotalHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri));
        cellBlankHeaderTotalHeader.BorderWidth = 0.0f;
        iTextSharp.text.pdf.PdfPCell cellBlankHeaderTotal1Header = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri));
        cellBlankHeaderTotal1Header.BorderWidth = 0.0f;
        TableFileRestRetDateWiseReportSummary.AddCell(cellBlankHeaderTotalHeader);
        TableFileRestRetDateWiseReportSummary.AddCell(cellBlankHeaderTotal1Header);
        TableFileRestRetDateWiseReportSummary.AddCell(cellTotal);
        TableFileRestRetDateWiseReportSummary.AddCell(cellTotaNoOfBoxesRet);
        TableFileRestRetDateWiseReportSummary.AddCell(cellTotalNoOfBoxesRet);
        TableFileRestRetDateWiseReportSummary.AddCell(cellTotalNoOfBoxesRes);
        TableFileRestRetDateWiseReportSummary.AddCell(cellNoOfFilesRes);
        cellblank1.Colspan = 7;
        TableFileRestRetDateWiseReportSummary.AddCell(cellblank1);
        cellbordersmallGrey1.Colspan = 7;
        cellbordersmallGrey1.Colspan = 7;
        return TableFileRestRetDateWiseReportSummary;
    }
    public iTextSharp.text.pdf.PdfPTable GetFileRestRetWODateWiseReportSummary(DataTable dtFileRestoreRetrieval, DataTable dtFileRestoreRetSum)
    {
        iTextSharp.text.pdf.PdfPTable TableFileRestRetDateWiseReportSummary = new iTextSharp.text.pdf.PdfPTable(7);
        float[] TableFileRestoreRetrievalCompwidth1 = new float[] { 240f, 150f, 150f, 120f, 120f, 100f, 100f };
        TableFileRestRetDateWiseReportSummary.WidthPercentage = 100;
        TableFileRestRetDateWiseReportSummary.SetWidths(TableFileRestoreRetrievalCompwidth1);
        iTextSharp.text.pdf.PdfPCell cellFileRestoreRetrievalCompHeader1 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" "));
        cellFileRestoreRetrievalCompHeader1.VerticalAlignment = iTextSharp.text.Element.ALIGN_CENTER;
        cellFileRestoreRetrievalCompHeader1.Colspan = 7;
        cellFileRestoreRetrievalCompHeader1.BorderWidth = 0.0f;
        iTextSharp.text.pdf.PdfPCell cellCustomerHeader1 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Customer Name", calibri));
        iTextSharp.text.pdf.PdfPCell cellBlankHeaderlHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri));
        cellBlankHeaderlHeader.BorderWidth = 0.0f;
        iTextSharp.text.pdf.PdfPCell cellBlankHeader2Header = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri));
        cellBlankHeader2Header.BorderWidth = 0.0f;
        iTextSharp.text.pdf.PdfPCell cellBlankHeader3Header = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri));
        cellBlankHeader3Header.BorderWidth = 0.0f;
        iTextSharp.text.pdf.PdfPCell cellRetrievalHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Retrieval", calibri));
        cellRetrievalHeader.VerticalAlignment = iTextSharp.text.Element.ALIGN_CENTER;
        cellRetrievalHeader.Colspan = 2;
        iTextSharp.text.pdf.PdfPCell cellRestoreHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Restore", calibri));
        cellRestoreHeader.VerticalAlignment = iTextSharp.text.Element.ALIGN_CENTER;
        cellRestoreHeader.Colspan = 2;
        iTextSharp.text.pdf.PdfPCell cellWorkOrderNoHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Work Order No.", calibri));
        iTextSharp.text.pdf.PdfPCell cellWorkOrderDateHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Work Order Date", calibri));
        iTextSharp.text.pdf.PdfPCell cellRetNoOfBoxesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("No. Of Boxes", calibri));
        iTextSharp.text.pdf.PdfPCell cellRetNoOfFilesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("No. Of Files", calibri));
        iTextSharp.text.pdf.PdfPCell cellRestoreNoOfBoxesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("No. Of Boxes", calibri));
        iTextSharp.text.pdf.PdfPCell cellRestoreNoOfFielsHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("No. Of Files", calibri));
        iTextSharp.text.pdf.PdfPCell cellbordersmall1 = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmall1.Colspan = 7;
        cellbordersmall1.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder1 = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmall1 };
        SetDefaulfBorder(pdfRowCellsborder1, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        cellFileRestoreRetrievalCompHeader1.Border = 1;
        iTextSharp.text.pdf.PdfPCell cellbordersmallmicro1 = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallmicro1.Colspan = 7;
        cellbordersmallmicro1.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborder1 = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallmicro1 };
        SetDefaulfBorder(pdfRowsCellsborder1, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);

        iTextSharp.text.pdf.PdfPCell cellbordersmallGrey1 = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallGrey1.Colspan = 7;
        cellbordersmallGrey1.BorderColor = iTextSharp.text.BaseColor.LIGHT_GRAY;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborderGrey1 = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallGrey1 };
        SetDefaulfBorder(pdfRowsCellsborderGrey1, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell[] pdfCells1 = new iTextSharp.text.pdf.PdfPCell[] { cellFileRestoreRetrievalCompHeader1, cellWorkOrderDateHeader, cellWorkOrderNoHeader, cellCustomerHeader1, cellRetrievalHeader, cellRestoreHeader, cellRetNoOfBoxesHeader, cellRetNoOfFilesHeader, cellRestoreNoOfBoxesHeader, cellRestoreNoOfFielsHeader };
        SetDefaulfBorder(pdfCells1, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell cellblank1 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri)));
        cellblank1.Colspan = 7;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsblank1 = new iTextSharp.text.pdf.PdfPCell[] { cellblank1 };
        SetDefaulfBorder(pdfRowCellsblank1, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        //Adding Headers to Service completion 
        TableFileRestRetDateWiseReportSummary.AddCell(cellblank1);

        TableFileRestRetDateWiseReportSummary.AddCell(cellFileRestoreRetrievalCompHeader1);

        TableFileRestRetDateWiseReportSummary.AddCell(cellBlankHeaderlHeader);
        TableFileRestRetDateWiseReportSummary.AddCell(cellBlankHeader2Header);
        TableFileRestRetDateWiseReportSummary.AddCell(cellBlankHeader3Header);
        TableFileRestRetDateWiseReportSummary.AddCell(cellRetrievalHeader);
        TableFileRestRetDateWiseReportSummary.AddCell(cellRestoreHeader);
        TableFileRestRetDateWiseReportSummary.AddCell(cellWorkOrderDateHeader);
        TableFileRestRetDateWiseReportSummary.AddCell(cellWorkOrderNoHeader);
        TableFileRestRetDateWiseReportSummary.AddCell(cellCustomerHeader1);
        TableFileRestRetDateWiseReportSummary.AddCell(cellRetNoOfBoxesHeader);
        TableFileRestRetDateWiseReportSummary.AddCell(cellRetNoOfFilesHeader);
        TableFileRestRetDateWiseReportSummary.AddCell(cellRestoreNoOfBoxesHeader);
        TableFileRestRetDateWiseReportSummary.AddCell(cellRestoreNoOfFielsHeader);
        cellblank1.BorderWidth = 0.0f;
        /// setting the boreder after header
        iTextSharp.text.pdf.PdfPCell RowBoarder1 = new iTextSharp.text.pdf.PdfPCell();
        RowBoarder1.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder11 = new iTextSharp.text.pdf.PdfPCell[] { RowBoarder1 };
        RowBoarder1.Colspan = 7;
        RowBoarder1.BorderWidth = 1;
        SetDefaulfBorder(pdfRowCellsborder11, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        TableFileRestRetDateWiseReportSummary.AddCell(RowBoarder1);
        TableFileRestRetDateWiseReportSummary.AddCell(cellblank1);
        for (int j = 0; j < dtFileRestoreRetrieval.Rows.Count; j++)
        {
            iTextSharp.text.pdf.PdfPCell cellCommon1 = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPCell cellWorkOrderDateHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetrieval.Rows[j]["WorkOrderDate"])));
            iTextSharp.text.pdf.PdfPCell cellWorkOrderNoHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetrieval.Rows[j]["WorkOrderNo"])));
            iTextSharp.text.pdf.PdfPCell cellCustomerHeaderValue1 = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetrieval.Rows[j]["CustomerName"])));
            iTextSharp.text.pdf.PdfPCell cellNoOfBoxesRetHeaderValue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetrieval.Rows[j]["NoOfBoxesRet"])));
            iTextSharp.text.pdf.PdfPCell cellNoOfFilesRetHeaderValue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetrieval.Rows[j]["NoOfFilesRet"])));
            iTextSharp.text.pdf.PdfPCell cellNoOfBoxesResHeaderValue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetrieval.Rows[j]["NoOfBoxesRes"])));
            iTextSharp.text.pdf.PdfPCell cellNoOfFilesResHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetrieval.Rows[j]["NoOfFilesRes"])));
            iTextSharp.text.pdf.PdfPCell cellAcknowledgementvalue = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPTable tableACk = new iTextSharp.text.pdf.PdfPTable(1);
            iTextSharp.text.pdf.PdfPCell[] pdfRowCells = new iTextSharp.text.pdf.PdfPCell[] { cellblank1, cellCommon1, cellWorkOrderDateHeadervalue, cellWorkOrderNoHeadervalue, cellCustomerHeaderValue1, cellNoOfBoxesRetHeaderValue, cellNoOfFilesRetHeaderValue, cellNoOfBoxesResHeaderValue, cellNoOfFilesResHeadervalue };
            SetDefaulfBorder(pdfRowCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            TableFileRestRetDateWiseReportSummary.AddCell(cellWorkOrderDateHeadervalue);
            TableFileRestRetDateWiseReportSummary.AddCell(cellWorkOrderNoHeadervalue);
            TableFileRestRetDateWiseReportSummary.AddCell(cellCustomerHeaderValue1);
            TableFileRestRetDateWiseReportSummary.AddCell(cellNoOfBoxesRetHeaderValue);
            TableFileRestRetDateWiseReportSummary.AddCell(cellNoOfFilesRetHeaderValue);
            TableFileRestRetDateWiseReportSummary.AddCell(cellNoOfBoxesResHeaderValue);
            TableFileRestRetDateWiseReportSummary.AddCell(cellNoOfFilesResHeadervalue);
            cellblank1.Colspan = 7;
            TableFileRestRetDateWiseReportSummary.AddCell(cellblank1);
            cellbordersmallGrey1.Colspan = 7;
            cellbordersmallGrey1.Colspan = 7;

        }

        iTextSharp.text.pdf.PdfPCell cellCommon = new iTextSharp.text.pdf.PdfPCell();
        iTextSharp.text.pdf.PdfPCell cellTotal = new iTextSharp.text.pdf.PdfPCell(PdfCellElement("Total"));
        iTextSharp.text.pdf.PdfPCell cellTotaNoOfBoxesRet = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetSum.Rows[0]["NoOfBoxesRet"])));
        iTextSharp.text.pdf.PdfPCell cellTotalNoOfBoxesRet = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetSum.Rows[0]["NoOfFilesRet"])));
        iTextSharp.text.pdf.PdfPCell cellTotalNoOfBoxesRes = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetSum.Rows[0]["NoOfBoxesRes"])));
        iTextSharp.text.pdf.PdfPCell cellNoOfFilesRes = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFileRestoreRetSum.Rows[0]["NoOfFilesRes"])));
        iTextSharp.text.pdf.PdfPCell cellAcknowledgement = new iTextSharp.text.pdf.PdfPCell();
        iTextSharp.text.pdf.PdfPTable tableACk1 = new iTextSharp.text.pdf.PdfPTable(1);
        iTextSharp.text.pdf.PdfPCell[] pdfRowCells1 = new iTextSharp.text.pdf.PdfPCell[] { cellblank1, cellCommon, cellTotal, cellTotaNoOfBoxesRet, cellTotalNoOfBoxesRet, cellTotalNoOfBoxesRes, cellNoOfFilesRes };
        SetDefaulfBorder(pdfRowCells1, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell cellBlankHeaderTotalHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri));
        cellBlankHeaderTotalHeader.BorderWidth = 0.0f;
        iTextSharp.text.pdf.PdfPCell cellBlankHeaderTotal1Header = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri));
        cellBlankHeaderTotal1Header.BorderWidth = 0.0f;
        TableFileRestRetDateWiseReportSummary.AddCell(cellBlankHeaderTotalHeader);
        TableFileRestRetDateWiseReportSummary.AddCell(cellBlankHeaderTotal1Header);
        TableFileRestRetDateWiseReportSummary.AddCell(cellTotal);
        TableFileRestRetDateWiseReportSummary.AddCell(cellTotaNoOfBoxesRet);
        TableFileRestRetDateWiseReportSummary.AddCell(cellTotalNoOfBoxesRet);
        TableFileRestRetDateWiseReportSummary.AddCell(cellTotalNoOfBoxesRes);
        TableFileRestRetDateWiseReportSummary.AddCell(cellNoOfFilesRes);
        cellblank1.Colspan = 7;
        TableFileRestRetDateWiseReportSummary.AddCell(cellblank1);
        cellbordersmallGrey1.Colspan = 7;
        cellbordersmallGrey1.Colspan = 7;
        return TableFileRestRetDateWiseReportSummary;
    }

    public iTextSharp.text.pdf.PdfPTable GetCustomerWiseReportSummary(DataTable dtCustomer)
    {
        iTextSharp.text.pdf.PdfPTable TableCustomerWiseReportSummary = new iTextSharp.text.pdf.PdfPTable(12);
        float[] TableCustomerWisewidth = new float[] { 150f, 170f, 150f, 200f, 150f, 100f, 150f,100f,100f,100f,100f,100f };
        TableCustomerWiseReportSummary.WidthPercentage = 100;
        TableCustomerWiseReportSummary.SetWidths(TableCustomerWisewidth);
        iTextSharp.text.pdf.PdfPCell cellCustomerWiseHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" "));
        cellCustomerWiseHeader.VerticalAlignment = iTextSharp.text.Element.ALIGN_CENTER;
        cellCustomerWiseHeader.Colspan = 12;
        cellCustomerWiseHeader.BorderWidth = 0.0f;
        iTextSharp.text.pdf.PdfPCell cellBoxBarCodeHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Box BarCode", calibri));
        iTextSharp.text.pdf.PdfPCell cellFileBarCodeHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("File BarCode", calibri));
        iTextSharp.text.pdf.PdfPCell cellFileNameHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("File Description1", calibri));
        iTextSharp.text.pdf.PdfPCell cellFileDesc2 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("File Description2", calibri));
        iTextSharp.text.pdf.PdfPCell cellPickUpAddressHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("PickUp Address", calibri));
        iTextSharp.text.pdf.PdfPCell cellDepartmentHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Department", calibri));
        iTextSharp.text.pdf.PdfPCell cellYearHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Year", calibri));
        iTextSharp.text.pdf.PdfPCell cellFromDateHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("From Date", calibri));
        iTextSharp.text.pdf.PdfPCell cellToDateHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("To Date", calibri));
        //iTextSharp.text.pdf.PdfPCell cellLabel1Header = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("FromNo", calibri));
        //iTextSharp.text.pdf.PdfPCell cellLabel2Header = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("ToNo", calibri));
        iTextSharp.text.pdf.PdfPCell cellLabel3Header = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("FileType", calibri));
        iTextSharp.text.pdf.PdfPCell cellFileDestructionDueDate = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Destruction Due Date", calibri));
        iTextSharp.text.pdf.PdfPCell cellStatusHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Status", calibri));
        iTextSharp.text.pdf.PdfPCell cellbordersmall1 = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmall1.Colspan = 12;
        cellbordersmall1.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder1 = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmall1 };
        SetDefaulfBorder(pdfRowCellsborder1, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        cellCustomerWiseHeader.Border = 1;
        iTextSharp.text.pdf.PdfPCell cellbordersmallmicro1 = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallmicro1.Colspan = 12;
        cellbordersmallmicro1.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborder1 = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallmicro1 };
        SetDefaulfBorder(pdfRowsCellsborder1, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);

        iTextSharp.text.pdf.PdfPCell cellbordersmallGrey1 = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallGrey1.Colspan = 12;
        cellbordersmallGrey1.BorderColor = iTextSharp.text.BaseColor.LIGHT_GRAY;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborderGrey1 = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallGrey1 };
        SetDefaulfBorder(pdfRowsCellsborderGrey1, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell[] pdfCells1 = new iTextSharp.text.pdf.PdfPCell[] { cellCustomerWiseHeader, cellBoxBarCodeHeader, cellFileBarCodeHeader, cellFileNameHeader, cellFileDesc2, cellPickUpAddressHeader, cellDepartmentHeader, cellYearHeader, cellFromDateHeader, cellToDateHeader, cellLabel3Header, cellFileDestructionDueDate, cellStatusHeader };
        SetDefaulfBorder(pdfCells1, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell cellblank1 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri)));
        cellblank1.Colspan = 12;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsblank1 = new iTextSharp.text.pdf.PdfPCell[] { cellblank1 };
        SetDefaulfBorder(pdfRowCellsblank1, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        //Adding Headers to Service completion 
        TableCustomerWiseReportSummary.AddCell(cellblank1);

        TableCustomerWiseReportSummary.AddCell(cellCustomerWiseHeader);
        TableCustomerWiseReportSummary.AddCell(cellBoxBarCodeHeader);
        TableCustomerWiseReportSummary.AddCell(cellFileBarCodeHeader);
        TableCustomerWiseReportSummary.AddCell(cellFileNameHeader);
        TableCustomerWiseReportSummary.AddCell(cellFileDesc2);
        TableCustomerWiseReportSummary.AddCell(cellDepartmentHeader);
        TableCustomerWiseReportSummary.AddCell(cellPickUpAddressHeader);
        TableCustomerWiseReportSummary.AddCell(cellYearHeader);
        TableCustomerWiseReportSummary.AddCell(cellFromDateHeader);
        TableCustomerWiseReportSummary.AddCell(cellToDateHeader);
        //TableCustomerWiseReportSummary.AddCell(cellLabel1Header);
        //TableCustomerWiseReportSummary.AddCell(cellLabel2Header);
        TableCustomerWiseReportSummary.AddCell(cellLabel3Header);
        TableCustomerWiseReportSummary.AddCell(cellFileDestructionDueDate);
        TableCustomerWiseReportSummary.AddCell(cellStatusHeader);
        cellblank1.BorderWidth = 0.0f;
        /// setting the boreder after header
        iTextSharp.text.pdf.PdfPCell RowBoarder1 = new iTextSharp.text.pdf.PdfPCell();
        RowBoarder1.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder11 = new iTextSharp.text.pdf.PdfPCell[] { RowBoarder1 };
        RowBoarder1.Colspan = 12;
        RowBoarder1.BorderWidth = 1;
        SetDefaulfBorder(pdfRowCellsborder11, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        TableCustomerWiseReportSummary.AddCell(RowBoarder1);
        TableCustomerWiseReportSummary.AddCell(cellblank1);
        for (int j = 0; j < dtCustomer.Rows.Count; j++)
        {
            iTextSharp.text.pdf.PdfPCell cellCommon1 = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPCell cellBoxBarCodeHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtCustomer.Rows[j]["Box BarCode"])));
            iTextSharp.text.pdf.PdfPCell cellFileBarCodeHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtCustomer.Rows[j]["File BarCode"])));
            iTextSharp.text.pdf.PdfPCell cellFileNameHeaderValue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtCustomer.Rows[j]["File Description1"])));
            iTextSharp.text.pdf.PdfPCell cellFileDescr2 = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtCustomer.Rows[j]["File Description2"])));
            iTextSharp.text.pdf.PdfPCell cellDeptHeaderValue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtCustomer.Rows[j]["Department"])));
            iTextSharp.text.pdf.PdfPCell cellPickUpHeaderValue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtCustomer.Rows[j]["PickUp Address"])));
            iTextSharp.text.pdf.PdfPCell cellYearHeaderValue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtCustomer.Rows[j]["Year"])));
            iTextSharp.text.pdf.PdfPCell cellFromDateHeaderValue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtCustomer.Rows[j]["From Date"])));
            iTextSharp.text.pdf.PdfPCell cellToDateHeaderValue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtCustomer.Rows[j]["To Date"])));
            //iTextSharp.text.pdf.PdfPCell cellLabel1Headervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtCustomer.Rows[j]["Label1"])));
            //iTextSharp.text.pdf.PdfPCell cellLabel2Headervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtCustomer.Rows[j]["Label2"])));
            iTextSharp.text.pdf.PdfPCell cellLabel3Headervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtCustomer.Rows[j]["File Type"])));
            iTextSharp.text.pdf.PdfPCell cellFileDestructionDueDt = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtCustomer.Rows[j]["DestructionDueDate"])));
            iTextSharp.text.pdf.PdfPCell cellStatusHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtCustomer.Rows[j]["Status"])));
            iTextSharp.text.pdf.PdfPCell cellAcknowledgementvalue = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPTable tableACk = new iTextSharp.text.pdf.PdfPTable(1);
            iTextSharp.text.pdf.PdfPCell[] pdfRowCells = new iTextSharp.text.pdf.PdfPCell[] { cellblank1, cellCommon1, cellBoxBarCodeHeadervalue, cellFileBarCodeHeadervalue, cellFileNameHeaderValue,cellFileDescr2, cellDeptHeaderValue, cellPickUpHeaderValue, cellYearHeaderValue, cellFromDateHeaderValue, cellToDateHeaderValue, cellLabel3Headervalue, cellFileDestructionDueDt, cellStatusHeadervalue };
            SetDefaulfBorder(pdfRowCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            TableCustomerWiseReportSummary.AddCell(cellBoxBarCodeHeadervalue);
            TableCustomerWiseReportSummary.AddCell(cellFileBarCodeHeadervalue);
            TableCustomerWiseReportSummary.AddCell(cellFileNameHeaderValue);
            TableCustomerWiseReportSummary.AddCell(cellFileDescr2);
            TableCustomerWiseReportSummary.AddCell(cellDeptHeaderValue);
            TableCustomerWiseReportSummary.AddCell(cellPickUpHeaderValue);
            TableCustomerWiseReportSummary.AddCell(cellYearHeaderValue);
            TableCustomerWiseReportSummary.AddCell(cellFromDateHeaderValue);
            TableCustomerWiseReportSummary.AddCell(cellToDateHeaderValue);
            //TableCustomerWiseReportSummary.AddCell(cellLabel1Headervalue);
            //TableCustomerWiseReportSummary.AddCell(cellLabel2Headervalue);
            TableCustomerWiseReportSummary.AddCell(cellLabel3Headervalue);
            TableCustomerWiseReportSummary.AddCell(cellFileDestructionDueDt);
            TableCustomerWiseReportSummary.AddCell(cellStatusHeadervalue);
            cellblank1.Colspan = 12;
            TableCustomerWiseReportSummary.AddCell(cellblank1);
            cellbordersmallGrey1.Colspan = 12;
            cellbordersmallGrey1.Colspan = 12;

        }
        return TableCustomerWiseReportSummary;
    }

    public iTextSharp.text.pdf.PdfPTable GetFilePickupReportSummary(DataTable dtFP, DataTable dtFPcount)
    {
        iTextSharp.text.pdf.PdfPTable TableFPSummary = new iTextSharp.text.pdf.PdfPTable(3);
        float[] TableFPCompwidth1 = new float[] { 240f, 100f, 100f};
        TableFPSummary.WidthPercentage = 100;
        TableFPSummary.SetWidths(TableFPCompwidth1);
        iTextSharp.text.pdf.PdfPCell cellFPCompHeader1 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" "));
        cellFPCompHeader1.VerticalAlignment = iTextSharp.text.Element.ALIGN_CENTER;
        cellFPCompHeader1.Colspan = 3;
        cellFPCompHeader1.BorderWidth = 0.0f;
        iTextSharp.text.pdf.PdfPCell cellCustomerHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Customer Name", calibri));
        iTextSharp.text.pdf.PdfPCell cellNoOfBoxesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("No. Of Boxes", calibri));
        iTextSharp.text.pdf.PdfPCell cellNoOfFilesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("No. Of Files", calibri));
        iTextSharp.text.pdf.PdfPCell cellbordersmall1 = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmall1.Colspan = 3;
        cellbordersmall1.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder1 = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmall1 };
        SetDefaulfBorder(pdfRowCellsborder1, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        cellFPCompHeader1.Border = 1;
        iTextSharp.text.pdf.PdfPCell cellbordersmallmicro1 = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallmicro1.Colspan = 3;
        cellbordersmallmicro1.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborder1 = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallmicro1 };
        SetDefaulfBorder(pdfRowsCellsborder1, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);

        iTextSharp.text.pdf.PdfPCell cellbordersmallGrey1 = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallGrey1.Colspan = 3;
        cellbordersmallGrey1.BorderColor = iTextSharp.text.BaseColor.LIGHT_GRAY;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborderGrey1 = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallGrey1 };
        SetDefaulfBorder(pdfRowsCellsborderGrey1, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell[] pdfCells1 = new iTextSharp.text.pdf.PdfPCell[] { cellFPCompHeader1, cellCustomerHeader, cellNoOfBoxesHeader, cellNoOfFilesHeader };
        SetDefaulfBorder(pdfCells1, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell cellblank1 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri)));
        cellblank1.Colspan = 3;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsblank1 = new iTextSharp.text.pdf.PdfPCell[] { cellblank1 };
        SetDefaulfBorder(pdfRowCellsblank1, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        //Adding Headers to File Pickup completion 
        TableFPSummary.AddCell(cellblank1);
        TableFPSummary.AddCell(cellFPCompHeader1);
        TableFPSummary.AddCell(cellCustomerHeader);
        TableFPSummary.AddCell(cellNoOfBoxesHeader);
        TableFPSummary.AddCell(cellNoOfFilesHeader);
        cellblank1.BorderWidth = 0.0f;
        /// setting the boreder after header
        iTextSharp.text.pdf.PdfPCell RowBoarder1 = new iTextSharp.text.pdf.PdfPCell();
        RowBoarder1.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder11 = new iTextSharp.text.pdf.PdfPCell[] { RowBoarder1 };
        RowBoarder1.Colspan = 3;
        RowBoarder1.BorderWidth = 1;
        SetDefaulfBorder(pdfRowCellsborder11, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        TableFPSummary.AddCell(RowBoarder1);
        TableFPSummary.AddCell(cellblank1);
        for (int j = 0; j < dtFP.Rows.Count; j++)
        {
            iTextSharp.text.pdf.PdfPCell cellCommon1 = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPCell cellCustomerHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFP.Rows[j]["s_CustomerName"])));
            iTextSharp.text.pdf.PdfPCell cellNoOfBoxesHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFP.Rows[j]["n_NoOfBoxes"])));
            iTextSharp.text.pdf.PdfPCell cellNoOfFilesHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFP.Rows[j]["n_NoOfFiles"])));
            iTextSharp.text.pdf.PdfPCell cellAcknowledgementvalue = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPTable tableACk = new iTextSharp.text.pdf.PdfPTable(1);
            iTextSharp.text.pdf.PdfPCell[] pdfRowCells = new iTextSharp.text.pdf.PdfPCell[] { cellblank1, cellCommon1, cellCustomerHeadervalue, cellNoOfBoxesHeadervalue, cellNoOfFilesHeadervalue };
            SetDefaulfBorder(pdfRowCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            TableFPSummary.AddCell(cellCustomerHeadervalue);
            TableFPSummary.AddCell(cellNoOfBoxesHeadervalue);
            TableFPSummary.AddCell(cellNoOfFilesHeadervalue);
            cellblank1.Colspan = 3;
            TableFPSummary.AddCell(cellblank1);
            cellbordersmallGrey1.Colspan = 3;
            cellbordersmallGrey1.Colspan = 3;

        }

        iTextSharp.text.pdf.PdfPCell cellCommon = new iTextSharp.text.pdf.PdfPCell();
        iTextSharp.text.pdf.PdfPCell cellTotal = new iTextSharp.text.pdf.PdfPCell(PdfCellElement("Total"));
        iTextSharp.text.pdf.PdfPCell cellTotalNoOfBoxes = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFPcount.Rows[0]["NoOfBoxes"])));
        iTextSharp.text.pdf.PdfPCell cellTotalNoOfFiles = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFPcount.Rows[0]["NoOfFiles"])));
        iTextSharp.text.pdf.PdfPCell cellAcknowledgement = new iTextSharp.text.pdf.PdfPCell();
        iTextSharp.text.pdf.PdfPTable tableACk1 = new iTextSharp.text.pdf.PdfPTable(1);
        iTextSharp.text.pdf.PdfPCell[] pdfRowCells1 = new iTextSharp.text.pdf.PdfPCell[] { cellblank1, cellCommon, cellTotal, cellTotalNoOfBoxes, cellTotalNoOfFiles };
        SetDefaulfBorder(pdfRowCells1, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        TableFPSummary.AddCell(cellTotal);
        TableFPSummary.AddCell(cellTotalNoOfBoxes);
        TableFPSummary.AddCell(cellTotalNoOfFiles);
        cellblank1.Colspan = 3;   
        TableFPSummary.AddCell(cellblank1);
        cellbordersmallGrey1.Colspan = 3;
        cellbordersmallGrey1.Colspan = 3;

        return TableFPSummary;

    }
    public iTextSharp.text.pdf.PdfPTable GetFilePickupDepartmentWiseReportSummary(DataTable dtFP, DataTable dtFPcount)
    {
        iTextSharp.text.pdf.PdfPTable TableFPDepartmentWiseSummary = new iTextSharp.text.pdf.PdfPTable(2);
        float[] TableFPDepartmentwidth = new float[] { 240f, 100f};
        TableFPDepartmentWiseSummary.WidthPercentage = 100;
        TableFPDepartmentWiseSummary.SetWidths(TableFPDepartmentwidth);
        iTextSharp.text.pdf.PdfPCell cellFPCompHeader1 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" "));
        cellFPCompHeader1.VerticalAlignment = iTextSharp.text.Element.ALIGN_CENTER;
        cellFPCompHeader1.Colspan = 2;
        cellFPCompHeader1.BorderWidth = 0.0f;
        iTextSharp.text.pdf.PdfPCell cellDepartmentHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Department Name", calibri));
        iTextSharp.text.pdf.PdfPCell cellNoOfFilesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("No. Of Files", calibri));
        iTextSharp.text.pdf.PdfPCell cellbordersmall1 = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmall1.Colspan = 2;
        cellbordersmall1.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder1 = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmall1 };
        SetDefaulfBorder(pdfRowCellsborder1, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        cellFPCompHeader1.Border = 1;
        iTextSharp.text.pdf.PdfPCell cellbordersmallmicro1 = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallmicro1.Colspan = 2;
        cellbordersmallmicro1.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborder1 = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallmicro1 };
        SetDefaulfBorder(pdfRowsCellsborder1, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);

        iTextSharp.text.pdf.PdfPCell cellbordersmallGrey1 = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallGrey1.Colspan = 2;
        cellbordersmallGrey1.BorderColor = iTextSharp.text.BaseColor.LIGHT_GRAY;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborderGrey1 = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallGrey1 };
        SetDefaulfBorder(pdfRowsCellsborderGrey1, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell[] pdfCells1 = new iTextSharp.text.pdf.PdfPCell[] { cellFPCompHeader1, cellDepartmentHeader,  cellNoOfFilesHeader };
        SetDefaulfBorder(pdfCells1, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell cellblank1 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri)));
        cellblank1.Colspan = 2;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsblank1 = new iTextSharp.text.pdf.PdfPCell[] { cellblank1 };
        SetDefaulfBorder(pdfRowCellsblank1, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        //Adding Headers to File Pickup completion 
        TableFPDepartmentWiseSummary.AddCell(cellblank1);
        TableFPDepartmentWiseSummary.AddCell(cellFPCompHeader1);
        TableFPDepartmentWiseSummary.AddCell(cellDepartmentHeader);
        TableFPDepartmentWiseSummary.AddCell(cellNoOfFilesHeader);
        cellblank1.BorderWidth = 0.0f;
        /// setting the boreder after header
        iTextSharp.text.pdf.PdfPCell RowBoarder1 = new iTextSharp.text.pdf.PdfPCell();
        RowBoarder1.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder11 = new iTextSharp.text.pdf.PdfPCell[] { RowBoarder1 };
        RowBoarder1.Colspan = 2;
        RowBoarder1.BorderWidth = 1;
        SetDefaulfBorder(pdfRowCellsborder11, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        TableFPDepartmentWiseSummary.AddCell(RowBoarder1);
        TableFPDepartmentWiseSummary.AddCell(cellblank1);
        for (int j = 0; j < dtFP.Rows.Count; j++)
        {
            iTextSharp.text.pdf.PdfPCell cellCommon1 = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPCell cellCustomerHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFP.Rows[j]["s_DeptName"])));
            iTextSharp.text.pdf.PdfPCell cellNoOfBoxesHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFP.Rows[j]["n_NoOfBoxes"])));
            iTextSharp.text.pdf.PdfPCell cellNoOfFilesHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFP.Rows[j]["n_NoOfFiles"])));
            iTextSharp.text.pdf.PdfPCell cellAcknowledgementvalue = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPTable tableACk = new iTextSharp.text.pdf.PdfPTable(1);
            iTextSharp.text.pdf.PdfPCell[] pdfRowCells = new iTextSharp.text.pdf.PdfPCell[] { cellblank1, cellCommon1, cellCustomerHeadervalue, cellNoOfBoxesHeadervalue, cellNoOfFilesHeadervalue };
            SetDefaulfBorder(pdfRowCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            TableFPDepartmentWiseSummary.AddCell(cellCustomerHeadervalue);
            TableFPDepartmentWiseSummary.AddCell(cellNoOfFilesHeadervalue);
            cellblank1.Colspan = 2;
            TableFPDepartmentWiseSummary.AddCell(cellblank1);
            cellbordersmallGrey1.Colspan = 2;
            cellbordersmallGrey1.Colspan = 2;

        }

        iTextSharp.text.pdf.PdfPCell cellCommon = new iTextSharp.text.pdf.PdfPCell();
        iTextSharp.text.pdf.PdfPCell cellTotal = new iTextSharp.text.pdf.PdfPCell(PdfCellElement("Total"));
        iTextSharp.text.pdf.PdfPCell cellTotalNoOfFiles = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFPcount.Rows[0]["NoOfFiles"])));
        iTextSharp.text.pdf.PdfPCell cellAcknowledgement = new iTextSharp.text.pdf.PdfPCell();
        iTextSharp.text.pdf.PdfPTable tableACk1 = new iTextSharp.text.pdf.PdfPTable(1);
        iTextSharp.text.pdf.PdfPCell[] pdfRowCells1 = new iTextSharp.text.pdf.PdfPCell[] { cellblank1, cellCommon, cellTotal, cellTotalNoOfFiles };
        SetDefaulfBorder(pdfRowCells1, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        TableFPDepartmentWiseSummary.AddCell(cellTotal);
        TableFPDepartmentWiseSummary.AddCell(cellTotalNoOfFiles);
        cellblank1.Colspan = 2;
        TableFPDepartmentWiseSummary.AddCell(cellblank1);
        cellbordersmallGrey1.Colspan = 2;
        cellbordersmallGrey1.Colspan = 2;
        return TableFPDepartmentWiseSummary;

    }

    public iTextSharp.text.pdf.PdfPTable GetFilePickupReportWONo(DataTable dtFP, DataTable dtFPCount)
    {

        iTextSharp.text.pdf.PdfPTable TableFilePickupWODateWise = new iTextSharp.text.pdf.PdfPTable(5);
        float[] TableFPwidth = new float[] { 200f, 200f, 240f, 150f, 150f };
        TableFilePickupWODateWise.WidthPercentage = 100;
        TableFilePickupWODateWise.SetWidths(TableFPwidth);
        iTextSharp.text.pdf.PdfPCell cellFPHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" "));
        cellFPHeader.VerticalAlignment = iTextSharp.text.Element.ALIGN_CENTER;
        cellFPHeader.Colspan = 5;
        cellFPHeader.BorderWidth = 0.0f;
        iTextSharp.text.pdf.PdfPCell cellWorkOrderNoHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Work Order No.", calibri));
        iTextSharp.text.pdf.PdfPCell cellWorkOrderDateHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Work Order Date", calibri));
        iTextSharp.text.pdf.PdfPCell cellCustomerHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Customer Name", calibri));
        iTextSharp.text.pdf.PdfPCell cellNoOfBoxesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("No. Of Boxes", calibri));
        iTextSharp.text.pdf.PdfPCell cellNoOfFilesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("No. Of Files", calibri));
        iTextSharp.text.pdf.PdfPCell cellbordersmall = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmall.Colspan = 5;
        cellbordersmall.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmall };
        SetDefaulfBorder(pdfRowCellsborder, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        cellFPHeader.Border = 1;
        iTextSharp.text.pdf.PdfPCell cellbordersmallmicro = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallmicro.Colspan = 5;
        cellbordersmallmicro.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborder = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallmicro };
        SetDefaulfBorder(pdfRowsCellsborder, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);

        iTextSharp.text.pdf.PdfPCell cellbordersmallGrey = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallGrey.Colspan = 5;
        cellbordersmallGrey.BorderColor = iTextSharp.text.BaseColor.LIGHT_GRAY;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborderGrey = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallGrey };
        SetDefaulfBorder(pdfRowsCellsborderGrey, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell[] pdfCells = new iTextSharp.text.pdf.PdfPCell[] { cellFPHeader, cellWorkOrderNoHeader, cellWorkOrderDateHeader, cellCustomerHeader, cellNoOfBoxesHeader, cellNoOfFilesHeader };
        SetDefaulfBorder(pdfCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell cellblank = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri)));
        cellblank.Colspan = 5;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsblank = new iTextSharp.text.pdf.PdfPCell[] { cellblank };
        SetDefaulfBorder(pdfRowCellsblank, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        //Adding Headers to Service completion 
        TableFilePickupWODateWise.AddCell(cellblank);
        TableFilePickupWODateWise.AddCell(cellblank);
        TableFilePickupWODateWise.AddCell(cellFPHeader);
        TableFilePickupWODateWise.AddCell(cellWorkOrderNoHeader);
        TableFilePickupWODateWise.AddCell(cellWorkOrderDateHeader);
        TableFilePickupWODateWise.AddCell(cellCustomerHeader);
        TableFilePickupWODateWise.AddCell(cellNoOfBoxesHeader);
        TableFilePickupWODateWise.AddCell(cellNoOfFilesHeader);
        cellblank.BorderWidth = 0.0f;
        /// setting the boreder after header
        iTextSharp.text.pdf.PdfPCell RowBoarder = new iTextSharp.text.pdf.PdfPCell();
        RowBoarder.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder111 = new iTextSharp.text.pdf.PdfPCell[] { RowBoarder };
        RowBoarder.Colspan = 5;
        RowBoarder.BorderWidth = 1;
        SetDefaulfBorder(pdfRowCellsborder111, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        TableFilePickupWODateWise.AddCell(RowBoarder);
        TableFilePickupWODateWise.AddCell(cellblank);
        for (int j = 0; j < dtFP.Rows.Count; j++)
        {
            iTextSharp.text.pdf.PdfPCell cellCommon = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPCell cellWorkOrderNoHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFP.Rows[j]["WorkorderNo"])));
            iTextSharp.text.pdf.PdfPCell cellWorkOrderDateHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFP.Rows[j]["WorkOrderDate"])));
            iTextSharp.text.pdf.PdfPCell cellCustomervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFP.Rows[j]["CustomerName"])));
            string NoOfBoxes = Convert.ToString(dtFP.Rows[j]["NoOfBoxes"]) == "" ? "0" : Convert.ToString(dtFP.Rows[j]["NoOfBoxes"]);
            string NoOfFiles = Convert.ToString(dtFP.Rows[j]["NoOfFiles"]) == "" ? "0" : Convert.ToString(dtFP.Rows[j]["NoOfFiles"]);
            iTextSharp.text.pdf.PdfPCell cellNoOfBoxesHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(NoOfBoxes));
            iTextSharp.text.pdf.PdfPCell cellNoOfFilesHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(NoOfFiles));
            iTextSharp.text.pdf.PdfPCell cellAcknowledgementvalue = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPTable tableACk = new iTextSharp.text.pdf.PdfPTable(1);
            iTextSharp.text.pdf.PdfPCell[] pdfRowCells = new iTextSharp.text.pdf.PdfPCell[] { cellblank, cellCommon, cellWorkOrderNoHeadervalue, cellWorkOrderDateHeadervalue, cellCustomervalue, cellNoOfBoxesHeadervalue, cellNoOfFilesHeadervalue };
            SetDefaulfBorder(pdfRowCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            TableFilePickupWODateWise.AddCell(cellWorkOrderNoHeadervalue);
            TableFilePickupWODateWise.AddCell(cellWorkOrderDateHeadervalue);
            TableFilePickupWODateWise.AddCell(cellCustomervalue);
            TableFilePickupWODateWise.AddCell(cellNoOfBoxesHeadervalue);
            TableFilePickupWODateWise.AddCell(cellNoOfFilesHeadervalue);
            cellblank.Colspan = 5;
            TableFilePickupWODateWise.AddCell(cellblank);
            cellbordersmallGrey.Colspan = 5;
            cellbordersmallGrey.Colspan = 5;
            TableFilePickupWODateWise.AddCell(cellblank);
        }

        iTextSharp.text.pdf.PdfPCell cellCommon1 = new iTextSharp.text.pdf.PdfPCell();
        iTextSharp.text.pdf.PdfPCell cellTotal = new iTextSharp.text.pdf.PdfPCell(PdfCellElement("Total"));
        iTextSharp.text.pdf.PdfPCell cellTotalNoOfBoxes = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFPCount.Rows[0]["NoOfBoxes"])));
        iTextSharp.text.pdf.PdfPCell cellTotalNoOfFiles = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFPCount.Rows[0]["NoOfFiles"])));
        iTextSharp.text.pdf.PdfPCell cellAcknowledgement = new iTextSharp.text.pdf.PdfPCell();
        iTextSharp.text.pdf.PdfPTable tableACk1 = new iTextSharp.text.pdf.PdfPTable(1);
        iTextSharp.text.pdf.PdfPCell[] pdfRowCells1 = new iTextSharp.text.pdf.PdfPCell[] { cellblank, cellCommon1, cellTotal, cellTotalNoOfBoxes, cellTotalNoOfFiles };
        SetDefaulfBorder(pdfRowCells1, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell cellBlankHeaderlHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri));
        cellBlankHeaderlHeader.BorderWidth = 0.0f;
        iTextSharp.text.pdf.PdfPCell cellBlankHeaderlHeader1 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri));
        cellBlankHeaderlHeader1.BorderWidth = 0.0f;
        TableFilePickupWODateWise.AddCell(cellblank);
        TableFilePickupWODateWise.AddCell(cellBlankHeaderlHeader);
        TableFilePickupWODateWise.AddCell(cellBlankHeaderlHeader1);
        TableFilePickupWODateWise.AddCell(cellTotal);
        TableFilePickupWODateWise.AddCell(cellTotalNoOfBoxes);
        TableFilePickupWODateWise.AddCell(cellTotalNoOfFiles);
        cellblank.Colspan = 5;
        TableFilePickupWODateWise.AddCell(cellblank);
        cellbordersmallGrey.Colspan = 5;
        cellbordersmallGrey.Colspan = 5;
        TableFilePickupWODateWise.AddCell(cellblank);
        return TableFilePickupWODateWise;
    }
    public iTextSharp.text.pdf.PdfPTable GetFilePickupReportWODate(DataTable dtFP, DataTable dtFPCount)
    {

        iTextSharp.text.pdf.PdfPTable TableFilePickupWODateWise = new iTextSharp.text.pdf.PdfPTable(5);
        float[] TableFPwidth = new float[] { 200f, 200f, 240f, 150f, 150f };
        TableFilePickupWODateWise.WidthPercentage = 100;
        TableFilePickupWODateWise.SetWidths(TableFPwidth);
        iTextSharp.text.pdf.PdfPCell cellFPHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" "));
        cellFPHeader.VerticalAlignment = iTextSharp.text.Element.ALIGN_CENTER;
        cellFPHeader.Colspan = 5;
        cellFPHeader.BorderWidth = 0.0f;
        iTextSharp.text.pdf.PdfPCell cellWorkOrderNoHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Work Order No.", calibri));
        iTextSharp.text.pdf.PdfPCell cellWorkOrderDateHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Work Order Date", calibri));
        iTextSharp.text.pdf.PdfPCell cellCustomerHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Customer Name", calibri));
        iTextSharp.text.pdf.PdfPCell cellNoOfBoxesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("No. Of Boxes", calibri));
        iTextSharp.text.pdf.PdfPCell cellNoOfFilesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("No. Of Files", calibri));
        iTextSharp.text.pdf.PdfPCell cellbordersmall = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmall.Colspan = 5;
        cellbordersmall.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmall };
        SetDefaulfBorder(pdfRowCellsborder, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        cellFPHeader.Border = 1;
        iTextSharp.text.pdf.PdfPCell cellbordersmallmicro = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallmicro.Colspan = 5;
        cellbordersmallmicro.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborder = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallmicro };
        SetDefaulfBorder(pdfRowsCellsborder, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);

        iTextSharp.text.pdf.PdfPCell cellbordersmallGrey = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallGrey.Colspan = 5;
        cellbordersmallGrey.BorderColor = iTextSharp.text.BaseColor.LIGHT_GRAY;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborderGrey = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallGrey };
        SetDefaulfBorder(pdfRowsCellsborderGrey, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell[] pdfCells = new iTextSharp.text.pdf.PdfPCell[] { cellFPHeader, cellWorkOrderDateHeader, cellWorkOrderNoHeader, cellCustomerHeader, cellNoOfBoxesHeader, cellNoOfFilesHeader };
        SetDefaulfBorder(pdfCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell cellblank = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri)));
        cellblank.Colspan = 5;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsblank = new iTextSharp.text.pdf.PdfPCell[] { cellblank };
        SetDefaulfBorder(pdfRowCellsblank, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        //Adding Headers to Service completion 
        TableFilePickupWODateWise.AddCell(cellblank);
        TableFilePickupWODateWise.AddCell(cellblank);
        TableFilePickupWODateWise.AddCell(cellFPHeader);
        TableFilePickupWODateWise.AddCell(cellWorkOrderDateHeader);
        TableFilePickupWODateWise.AddCell(cellWorkOrderNoHeader);
        TableFilePickupWODateWise.AddCell(cellCustomerHeader);
        TableFilePickupWODateWise.AddCell(cellNoOfBoxesHeader);
        TableFilePickupWODateWise.AddCell(cellNoOfFilesHeader);
        cellblank.BorderWidth = 0.0f;
        /// setting the boreder after header
        iTextSharp.text.pdf.PdfPCell RowBoarder = new iTextSharp.text.pdf.PdfPCell();
        RowBoarder.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder111 = new iTextSharp.text.pdf.PdfPCell[] { RowBoarder };
        RowBoarder.Colspan = 5;
        RowBoarder.BorderWidth = 1;
        SetDefaulfBorder(pdfRowCellsborder111, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        TableFilePickupWODateWise.AddCell(RowBoarder);
        TableFilePickupWODateWise.AddCell(cellblank);
        for (int j = 0; j < dtFP.Rows.Count; j++)
        {
            iTextSharp.text.pdf.PdfPCell cellCommon = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPCell cellWorkOrderNoHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFP.Rows[j]["WorkorderNo"])));
            iTextSharp.text.pdf.PdfPCell cellWorkOrderDateHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFP.Rows[j]["WorkOrderDate"])));
            iTextSharp.text.pdf.PdfPCell cellCustomervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFP.Rows[j]["CustomerName"])));
            string NoOfBoxes = Convert.ToString(dtFP.Rows[j]["NoOfBoxes"]) == "" ? "0" : Convert.ToString(dtFP.Rows[j]["NoOfBoxes"]);
            string NoOfFiles = Convert.ToString(dtFP.Rows[j]["NoOfFiles"]) == "" ? "0" : Convert.ToString(dtFP.Rows[j]["NoOfFiles"]);
            iTextSharp.text.pdf.PdfPCell cellNoOfBoxesHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(NoOfBoxes));
            iTextSharp.text.pdf.PdfPCell cellNoOfFilesHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(NoOfFiles));
            iTextSharp.text.pdf.PdfPCell cellAcknowledgementvalue = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPTable tableACk = new iTextSharp.text.pdf.PdfPTable(1);
            iTextSharp.text.pdf.PdfPCell[] pdfRowCells = new iTextSharp.text.pdf.PdfPCell[] { cellblank, cellCommon, cellWorkOrderDateHeadervalue, cellWorkOrderNoHeadervalue, cellCustomervalue, cellNoOfBoxesHeadervalue, cellNoOfFilesHeadervalue };
            SetDefaulfBorder(pdfRowCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            TableFilePickupWODateWise.AddCell(cellWorkOrderDateHeadervalue);
            TableFilePickupWODateWise.AddCell(cellWorkOrderNoHeadervalue);
            TableFilePickupWODateWise.AddCell(cellCustomervalue);
            TableFilePickupWODateWise.AddCell(cellNoOfBoxesHeadervalue);
            TableFilePickupWODateWise.AddCell(cellNoOfFilesHeadervalue);
            cellblank.Colspan = 5;
            TableFilePickupWODateWise.AddCell(cellblank);
            cellbordersmallGrey.Colspan = 5;
            cellbordersmallGrey.Colspan = 5;
            TableFilePickupWODateWise.AddCell(cellblank);
        }

        iTextSharp.text.pdf.PdfPCell cellCommon1 = new iTextSharp.text.pdf.PdfPCell();
        iTextSharp.text.pdf.PdfPCell cellTotal = new iTextSharp.text.pdf.PdfPCell(PdfCellElement("Total"));
        iTextSharp.text.pdf.PdfPCell cellTotalNoOfBoxes = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFPCount.Rows[0]["NoOfBoxes"])));
        iTextSharp.text.pdf.PdfPCell cellTotalNoOfFiles = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFPCount.Rows[0]["NoOfFiles"])));
        iTextSharp.text.pdf.PdfPCell cellAcknowledgement = new iTextSharp.text.pdf.PdfPCell();
        iTextSharp.text.pdf.PdfPTable tableACk1 = new iTextSharp.text.pdf.PdfPTable(1);
        iTextSharp.text.pdf.PdfPCell[] pdfRowCells1 = new iTextSharp.text.pdf.PdfPCell[] { cellblank, cellCommon1, cellTotal, cellTotalNoOfBoxes, cellTotalNoOfFiles };
        SetDefaulfBorder(pdfRowCells1, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell cellBlankHeaderlHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri));
        cellBlankHeaderlHeader.BorderWidth = 0.0f;
        iTextSharp.text.pdf.PdfPCell cellBlankHeaderlHeader1 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri));
        cellBlankHeaderlHeader1.BorderWidth = 0.0f;
        TableFilePickupWODateWise.AddCell(cellblank);
        TableFilePickupWODateWise.AddCell(cellBlankHeaderlHeader);
        TableFilePickupWODateWise.AddCell(cellBlankHeaderlHeader1);
        TableFilePickupWODateWise.AddCell(cellTotal);
        TableFilePickupWODateWise.AddCell(cellTotalNoOfBoxes);
        TableFilePickupWODateWise.AddCell(cellTotalNoOfFiles);
        cellblank.Colspan = 5;
        TableFilePickupWODateWise.AddCell(cellblank);
        cellbordersmallGrey.Colspan = 5;
        cellbordersmallGrey.Colspan = 5;
        TableFilePickupWODateWise.AddCell(cellblank);
        return TableFilePickupWODateWise;
    }

    public iTextSharp.text.pdf.PdfPTable GetInventoryReportSummary(DataTable dtInventory, DataTable dtNoInventoryCount)
    {
        iTextSharp.text.pdf.PdfPTable TableInventory = new iTextSharp.text.pdf.PdfPTable(7);
        float[] TableInventoryWidth = new float[] { 340f, 100f, 100f, 100f, 100f, 100f, 100f };
        TableInventory.WidthPercentage = 100;
        TableInventory.SetWidths(TableInventoryWidth);
        iTextSharp.text.pdf.PdfPCell cellInventoryHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" "));
        cellInventoryHeader.VerticalAlignment = iTextSharp.text.Element.ALIGN_CENTER;
        cellInventoryHeader.Colspan = 7;
        cellInventoryHeader.BorderWidth = 0.0f;
        iTextSharp.text.pdf.PdfPCell cellCustomerHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Customer", calibri));
        iTextSharp.text.pdf.PdfPCell cellNoOfInBoxesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("No. Of In Boxes", calibri));
        iTextSharp.text.pdf.PdfPCell cellNoOfOutBoxesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("No. Of Out Boxes", calibri));
        iTextSharp.text.pdf.PdfPCell cellTotalBoxesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Total Boxes", calibri));
        iTextSharp.text.pdf.PdfPCell cellNoOfInFilesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("No. Of In Files", calibri));
        iTextSharp.text.pdf.PdfPCell cellNoOfOutFilesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("No. Of Out Files", calibri));
        iTextSharp.text.pdf.PdfPCell cellTotalFilesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Total Files", calibri));
        iTextSharp.text.pdf.PdfPCell cellbordersmall = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmall.Colspan = 7;
        cellbordersmall.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmall };
        SetDefaulfBorder(pdfRowCellsborder, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        cellInventoryHeader.Border = 1;
        iTextSharp.text.pdf.PdfPCell cellbordersmallmicro = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallmicro.Colspan = 7;
        cellbordersmallmicro.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborder = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallmicro };
        SetDefaulfBorder(pdfRowsCellsborder, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);

        iTextSharp.text.pdf.PdfPCell cellbordersmallGrey = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallGrey.Colspan = 7;
        cellbordersmallGrey.BorderColor = iTextSharp.text.BaseColor.LIGHT_GRAY;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborderGrey = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallGrey };
        SetDefaulfBorder(pdfRowsCellsborderGrey, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell[] pdfCells = new iTextSharp.text.pdf.PdfPCell[] { cellInventoryHeader, cellCustomerHeader, cellNoOfInBoxesHeader, cellNoOfOutBoxesHeader, cellTotalBoxesHeader, cellNoOfInFilesHeader, cellNoOfOutFilesHeader, cellTotalFilesHeader };
        SetDefaulfBorder(pdfCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell cellblank = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri)));
        cellblank.Colspan = 7;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsblank = new iTextSharp.text.pdf.PdfPCell[] { cellblank };
        SetDefaulfBorder(pdfRowCellsblank, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        //Adding Headers to Service completion 
        TableInventory.AddCell(cellblank);
        TableInventory.AddCell(cellblank);
        TableInventory.AddCell(cellInventoryHeader);
        TableInventory.AddCell(cellCustomerHeader);
        TableInventory.AddCell(cellNoOfInBoxesHeader);
        TableInventory.AddCell(cellNoOfOutBoxesHeader);
        TableInventory.AddCell(cellTotalBoxesHeader);
        TableInventory.AddCell(cellNoOfInFilesHeader);
        TableInventory.AddCell(cellNoOfOutFilesHeader);
        TableInventory.AddCell(cellTotalFilesHeader);
        cellblank.BorderWidth = 0.0f;
        /// setting the boreder after header
        iTextSharp.text.pdf.PdfPCell RowBoarder = new iTextSharp.text.pdf.PdfPCell();
        RowBoarder.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder111 = new iTextSharp.text.pdf.PdfPCell[] { RowBoarder };
        RowBoarder.Colspan = 7;
        RowBoarder.BorderWidth = 1;
        SetDefaulfBorder(pdfRowCellsborder111, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        TableInventory.AddCell(RowBoarder);
        TableInventory.AddCell(cellblank);
        for (int j = 0; j < dtInventory.Rows.Count; j++)
        {
            iTextSharp.text.pdf.PdfPCell cellCommon = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPCell cellCustomervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtInventory.Rows[j]["CustomerName"])));
            string InBox = Convert.ToString(dtInventory.Rows[j]["InBox"]) == "" ? "0" : Convert.ToString(dtInventory.Rows[j]["InBox"]);
            string OutBox = Convert.ToString(dtInventory.Rows[j]["OutBox"]) == "" ? "0" : Convert.ToString(dtInventory.Rows[j]["OutBox"]);
            string TotalBoxes = Convert.ToString(dtInventory.Rows[j]["TotalBoxes"]) == "" ? "0" : Convert.ToString(dtInventory.Rows[j]["TotalBoxes"]);
            string InFile = Convert.ToString(dtInventory.Rows[j]["InFile"]) == "" ? "0" : Convert.ToString(dtInventory.Rows[j]["InFile"]);
            string OutFile = Convert.ToString(dtInventory.Rows[j]["OutFile"]) == "" ? "0" : Convert.ToString(dtInventory.Rows[j]["OutFile"]);
            string TotalFiles = Convert.ToString(dtInventory.Rows[j]["TotalFiles"]) == "" ? "0" : Convert.ToString(dtInventory.Rows[j]["TotalFiles"]);
            iTextSharp.text.pdf.PdfPCell cellInBoxHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(InBox));
            iTextSharp.text.pdf.PdfPCell cellOutBoxHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(OutBox));
            iTextSharp.text.pdf.PdfPCell cellTotalBoxesHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(TotalBoxes));
            iTextSharp.text.pdf.PdfPCell cellInFileHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(InFile));
            iTextSharp.text.pdf.PdfPCell cellOutFileHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(OutFile));
            iTextSharp.text.pdf.PdfPCell cellTotalFilesHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(TotalFiles));
            iTextSharp.text.pdf.PdfPCell cellAcknowledgementvalue = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPTable tableACk = new iTextSharp.text.pdf.PdfPTable(1);
            iTextSharp.text.pdf.PdfPCell[] pdfRowCells = new iTextSharp.text.pdf.PdfPCell[] { cellblank, cellCommon, cellCustomervalue, cellInBoxHeadervalue, cellOutBoxHeadervalue, cellTotalBoxesHeadervalue, cellInFileHeadervalue, cellOutFileHeadervalue, cellTotalFilesHeadervalue};
            SetDefaulfBorder(pdfRowCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            TableInventory.AddCell(cellCustomervalue);
            TableInventory.AddCell(cellInBoxHeadervalue);
            TableInventory.AddCell(cellOutBoxHeadervalue);
            TableInventory.AddCell(cellTotalBoxesHeadervalue);
            TableInventory.AddCell(cellInFileHeadervalue);
            TableInventory.AddCell(cellOutFileHeadervalue);
            TableInventory.AddCell(cellTotalFilesHeadervalue);
            cellblank.Colspan = 7;
            TableInventory.AddCell(cellblank);
            cellbordersmallGrey.Colspan = 7;
            cellbordersmallGrey.Colspan = 7;
            TableInventory.AddCell(cellblank);
        }
        iTextSharp.text.pdf.PdfPCell cellCommon1 = new iTextSharp.text.pdf.PdfPCell();
        iTextSharp.text.pdf.PdfPCell cellTotal = new iTextSharp.text.pdf.PdfPCell(PdfCellElement("Total"));
        iTextSharp.text.pdf.PdfPCell cellTotalInBox = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtNoInventoryCount.Rows[0]["InBox"])));
        iTextSharp.text.pdf.PdfPCell cellTotalOutBox = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtNoInventoryCount.Rows[0]["OutBox"])));
        iTextSharp.text.pdf.PdfPCell cellTotalTotalBoxes = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtNoInventoryCount.Rows[0]["TotalBoxes"])));
        iTextSharp.text.pdf.PdfPCell cellTotalInFile = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtNoInventoryCount.Rows[0]["InFile"])));
        iTextSharp.text.pdf.PdfPCell cellTotalOutFile = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtNoInventoryCount.Rows[0]["OutFile"])));
        iTextSharp.text.pdf.PdfPCell cellTotalTotalFiles = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtNoInventoryCount.Rows[0]["TotalFiles"])));
        iTextSharp.text.pdf.PdfPCell cellAcknowledgement = new iTextSharp.text.pdf.PdfPCell();
        iTextSharp.text.pdf.PdfPTable tableACk1 = new iTextSharp.text.pdf.PdfPTable(1);
        iTextSharp.text.pdf.PdfPCell[] pdfRowCells1 = new iTextSharp.text.pdf.PdfPCell[] { cellblank, cellCommon1, cellTotal, cellTotalInBox, cellTotalOutBox, cellTotalTotalBoxes, cellTotalInFile, cellTotalOutFile, cellTotalTotalFiles};
        SetDefaulfBorder(pdfRowCells1, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);

        TableInventory.AddCell(cellblank);
        TableInventory.AddCell(cellTotal);
        TableInventory.AddCell(cellTotalInBox);
        TableInventory.AddCell(cellTotalOutBox);
        TableInventory.AddCell(cellTotalTotalBoxes);
        TableInventory.AddCell(cellTotalInFile);
        TableInventory.AddCell(cellTotalOutFile);
        TableInventory.AddCell(cellTotalTotalFiles);
        
        cellblank.Colspan = 7;
        TableInventory.AddCell(cellblank);
        cellbordersmallGrey.Colspan = 7;
        cellbordersmallGrey.Colspan = 7;
        TableInventory.AddCell(cellblank);
        return TableInventory;
    }

    public iTextSharp.text.pdf.PdfPTable GetInventoryYearWiseReport(DataTable dtInventory, DataTable dtNoInventoryCount)
    {
        iTextSharp.text.pdf.PdfPTable TableInventory = new iTextSharp.text.pdf.PdfPTable(7);
        float[] TableInventoryWidth = new float[] { 100f, 150f, 150f, 100f, 100f, 150f, 100f };
        TableInventory.WidthPercentage = 100;
        TableInventory.SetWidths(TableInventoryWidth);
        iTextSharp.text.pdf.PdfPCell cellInventoryHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" "));
        cellInventoryHeader.VerticalAlignment = iTextSharp.text.Element.ALIGN_CENTER;
        cellInventoryHeader.Colspan = 7;
        cellInventoryHeader.BorderWidth = 0.0f;
        iTextSharp.text.pdf.PdfPCell cellNoOfInBoxesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("No. Of In Boxes", calibri));
        iTextSharp.text.pdf.PdfPCell cellNoOfOutBoxesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("No. Of Out Boxes", calibri));
        iTextSharp.text.pdf.PdfPCell cellTotalBoxesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Total Boxes", calibri));
        iTextSharp.text.pdf.PdfPCell cellNoOfInFilesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("No. Of In Files", calibri));
        iTextSharp.text.pdf.PdfPCell cellNoOfOutFilesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("No. Of Out Files", calibri));
        iTextSharp.text.pdf.PdfPCell cellTotalFilesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Total Files", calibri));
        iTextSharp.text.pdf.PdfPCell cellYearHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Year", calibri));
        iTextSharp.text.pdf.PdfPCell cellbordersmall = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmall.Colspan = 7;
        cellbordersmall.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmall };
        SetDefaulfBorder(pdfRowCellsborder, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        cellInventoryHeader.Border = 1;
        iTextSharp.text.pdf.PdfPCell cellbordersmallmicro = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallmicro.Colspan = 7;
        cellbordersmallmicro.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborder = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallmicro };
        SetDefaulfBorder(pdfRowsCellsborder, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);

        iTextSharp.text.pdf.PdfPCell cellbordersmallGrey = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallGrey.Colspan = 7;
        cellbordersmallGrey.BorderColor = iTextSharp.text.BaseColor.LIGHT_GRAY;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborderGrey = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallGrey };
        SetDefaulfBorder(pdfRowsCellsborderGrey, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell[] pdfCells = new iTextSharp.text.pdf.PdfPCell[] { cellInventoryHeader, cellNoOfInBoxesHeader, cellNoOfOutBoxesHeader, cellTotalBoxesHeader, cellNoOfInFilesHeader, cellNoOfOutFilesHeader, cellTotalFilesHeader, cellYearHeader };
        SetDefaulfBorder(pdfCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell cellblank = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri)));
        cellblank.Colspan = 7;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsblank = new iTextSharp.text.pdf.PdfPCell[] { cellblank };
        SetDefaulfBorder(pdfRowCellsblank, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        //Adding Headers to Service completion 
        TableInventory.AddCell(cellblank);
        TableInventory.AddCell(cellblank);
        TableInventory.AddCell(cellInventoryHeader);
        TableInventory.AddCell(cellYearHeader);
        TableInventory.AddCell(cellNoOfInBoxesHeader);
        TableInventory.AddCell(cellNoOfOutBoxesHeader);
        TableInventory.AddCell(cellTotalBoxesHeader);
        TableInventory.AddCell(cellNoOfInFilesHeader);
        TableInventory.AddCell(cellNoOfOutFilesHeader);
        TableInventory.AddCell(cellTotalFilesHeader);
        cellblank.BorderWidth = 0.0f;
        /// setting the boreder after header
        iTextSharp.text.pdf.PdfPCell RowBoarder = new iTextSharp.text.pdf.PdfPCell();
        RowBoarder.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder111 = new iTextSharp.text.pdf.PdfPCell[] { RowBoarder };
        RowBoarder.Colspan = 7;
        RowBoarder.BorderWidth = 1;
        SetDefaulfBorder(pdfRowCellsborder111, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        TableInventory.AddCell(RowBoarder);
        TableInventory.AddCell(cellblank);
        for (int j = 0; j < dtInventory.Rows.Count; j++)
        {
            iTextSharp.text.pdf.PdfPCell cellCommon = new iTextSharp.text.pdf.PdfPCell();
            //iTextSharp.text.pdf.PdfPCell cellCustomervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtInventory.Rows[j]["CustomerName"])));
            string InBox = Convert.ToString(dtInventory.Rows[j]["InBox"]) == "" ? "0" : Convert.ToString(dtInventory.Rows[j]["InBox"]);
            string OutBox = Convert.ToString(dtInventory.Rows[j]["OutBox"]) == "" ? "0" : Convert.ToString(dtInventory.Rows[j]["OutBox"]);
            string TotalBoxes = Convert.ToString(dtInventory.Rows[j]["TotalBoxes"]) == "" ? "0" : Convert.ToString(dtInventory.Rows[j]["TotalBoxes"]);
            string InFile = Convert.ToString(dtInventory.Rows[j]["InFile"]) == "" ? "0" : Convert.ToString(dtInventory.Rows[j]["InFile"]);
            string OutFile = Convert.ToString(dtInventory.Rows[j]["OutFile"]) == "" ? "0" : Convert.ToString(dtInventory.Rows[j]["OutFile"]);
            string TotalFiles = Convert.ToString(dtInventory.Rows[j]["TotalFiles"]) == "" ? "0" : Convert.ToString(dtInventory.Rows[j]["TotalFiles"]);
            iTextSharp.text.pdf.PdfPCell cellInBoxHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(InBox));
            iTextSharp.text.pdf.PdfPCell cellOutBoxHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(OutBox));
            iTextSharp.text.pdf.PdfPCell cellTotalBoxesHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(TotalBoxes));
            iTextSharp.text.pdf.PdfPCell cellInFileHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(InFile));
            iTextSharp.text.pdf.PdfPCell cellOutFileHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(OutFile));
            iTextSharp.text.pdf.PdfPCell cellTotalFilesHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(TotalFiles));
            iTextSharp.text.pdf.PdfPCell cellYearHeaderValue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtInventory.Rows[j]["Years"])));
            iTextSharp.text.pdf.PdfPCell cellAcknowledgementvalue = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPTable tableACk = new iTextSharp.text.pdf.PdfPTable(1);
            iTextSharp.text.pdf.PdfPCell[] pdfRowCells = new iTextSharp.text.pdf.PdfPCell[] { cellblank, cellCommon, cellInBoxHeadervalue, cellOutBoxHeadervalue, cellTotalBoxesHeadervalue, cellInFileHeadervalue, cellOutFileHeadervalue, cellTotalFilesHeadervalue, cellYearHeaderValue };
            SetDefaulfBorder(pdfRowCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            TableInventory.AddCell(cellYearHeaderValue);
            TableInventory.AddCell(cellInBoxHeadervalue);
            TableInventory.AddCell(cellOutBoxHeadervalue);
            TableInventory.AddCell(cellTotalBoxesHeadervalue);
            TableInventory.AddCell(cellInFileHeadervalue);
            TableInventory.AddCell(cellOutFileHeadervalue);
            TableInventory.AddCell(cellTotalFilesHeadervalue);
            cellblank.Colspan = 7;
            TableInventory.AddCell(cellblank);
            cellbordersmallGrey.Colspan = 7;
            cellbordersmallGrey.Colspan = 7;
            TableInventory.AddCell(cellblank);
        }
        iTextSharp.text.pdf.PdfPCell cellCommon1 = new iTextSharp.text.pdf.PdfPCell();
        iTextSharp.text.pdf.PdfPCell cellTotal = new iTextSharp.text.pdf.PdfPCell(PdfCellElement("Total"));
        iTextSharp.text.pdf.PdfPCell cellTotalInBox = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtNoInventoryCount.Rows[0]["InBox"])));
        iTextSharp.text.pdf.PdfPCell cellTotalOutBox = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtNoInventoryCount.Rows[0]["OutBox"])));
        iTextSharp.text.pdf.PdfPCell cellTotalTotalBoxes = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtNoInventoryCount.Rows[0]["TotalBoxes"])));
        iTextSharp.text.pdf.PdfPCell cellTotalInFile = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtNoInventoryCount.Rows[0]["InFile"])));
        iTextSharp.text.pdf.PdfPCell cellTotalOutFile = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtNoInventoryCount.Rows[0]["OutFile"])));
        iTextSharp.text.pdf.PdfPCell cellTotalTotalFiles = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtNoInventoryCount.Rows[0]["TotalFiles"])));
        iTextSharp.text.pdf.PdfPCell cellAcknowledgement = new iTextSharp.text.pdf.PdfPCell();
        iTextSharp.text.pdf.PdfPTable tableACk1 = new iTextSharp.text.pdf.PdfPTable(1);
        iTextSharp.text.pdf.PdfPCell[] pdfRowCells1 = new iTextSharp.text.pdf.PdfPCell[] { cellblank, cellCommon1, cellTotal, cellTotalInBox, cellTotalOutBox, cellTotalTotalBoxes, cellTotalInFile, cellTotalOutFile, cellTotalTotalFiles };
        SetDefaulfBorder(pdfRowCells1, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);

        TableInventory.AddCell(cellblank);
        TableInventory.AddCell(cellTotal);
        TableInventory.AddCell(cellTotalInBox);
        TableInventory.AddCell(cellTotalOutBox);
        TableInventory.AddCell(cellTotalTotalBoxes);
        TableInventory.AddCell(cellTotalInFile);
        TableInventory.AddCell(cellTotalOutFile);
        TableInventory.AddCell(cellTotalTotalFiles);

        cellblank.Colspan = 7;
        TableInventory.AddCell(cellblank);
        cellbordersmallGrey.Colspan = 7;
        cellbordersmallGrey.Colspan = 7;
        TableInventory.AddCell(cellblank);
        return TableInventory;
    }

    public iTextSharp.text.pdf.PdfPTable GetInventoryDetailsReport(DataTable dtInventoryDet)
    {
        iTextSharp.text.pdf.PdfPTable TableInventory = new iTextSharp.text.pdf.PdfPTable(7);
        float[] TableInventoryWidth = new float[] { 100f, 150f, 150f, 100f, 100f, 150f, 100f};
        TableInventory.WidthPercentage = 100;
        TableInventory.SetWidths(TableInventoryWidth);
        iTextSharp.text.pdf.PdfPCell cellInventoryHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" "));
        cellInventoryHeader.VerticalAlignment = iTextSharp.text.Element.ALIGN_CENTER;
        cellInventoryHeader.Colspan = 7;
        cellInventoryHeader.BorderWidth = 0.0f;
        iTextSharp.text.pdf.PdfPCell cellNoOfInBoxesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("No. Of In Boxes", calibri));
        iTextSharp.text.pdf.PdfPCell cellNoOfOutBoxesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("No. Of Out Boxes", calibri));
        iTextSharp.text.pdf.PdfPCell cellTotalBoxesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Total Boxes", calibri));
        iTextSharp.text.pdf.PdfPCell cellNoOfInFilesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("No. Of In Files", calibri));
        iTextSharp.text.pdf.PdfPCell cellNoOfOutFilesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("No. Of Out Files", calibri));
        iTextSharp.text.pdf.PdfPCell cellTotalFilesHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Total Files", calibri));
        iTextSharp.text.pdf.PdfPCell cellYearHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Year", calibri));
        iTextSharp.text.pdf.PdfPCell cellbordersmall = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmall.Colspan = 7;
        cellbordersmall.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmall };
        SetDefaulfBorder(pdfRowCellsborder, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        cellInventoryHeader.Border = 1;
        iTextSharp.text.pdf.PdfPCell cellbordersmallmicro = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallmicro.Colspan = 7;
        cellbordersmallmicro.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborder = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallmicro };
        SetDefaulfBorder(pdfRowsCellsborder, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);

        iTextSharp.text.pdf.PdfPCell cellbordersmallGrey = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallGrey.Colspan = 7;
        cellbordersmallGrey.BorderColor = iTextSharp.text.BaseColor.LIGHT_GRAY;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborderGrey = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallGrey };
        SetDefaulfBorder(pdfRowsCellsborderGrey, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell[] pdfCells = new iTextSharp.text.pdf.PdfPCell[] { cellInventoryHeader,cellYearHeader, cellNoOfInBoxesHeader, cellNoOfOutBoxesHeader, cellTotalBoxesHeader, cellNoOfInFilesHeader, cellNoOfOutFilesHeader, cellTotalFilesHeader  };
        SetDefaulfBorder(pdfCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell cellblank = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri)));
        cellblank.Colspan = 7;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsblank = new iTextSharp.text.pdf.PdfPCell[] { cellblank };
        SetDefaulfBorder(pdfRowCellsblank, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        //Adding Headers to Service completion 
        TableInventory.AddCell(cellblank);
        TableInventory.AddCell(cellblank);
        TableInventory.AddCell(cellInventoryHeader);
        TableInventory.AddCell(cellYearHeader);
        TableInventory.AddCell(cellNoOfInBoxesHeader);
        TableInventory.AddCell(cellNoOfOutBoxesHeader);
        TableInventory.AddCell(cellTotalBoxesHeader);
        TableInventory.AddCell(cellNoOfInFilesHeader);
        TableInventory.AddCell(cellNoOfOutFilesHeader);
        TableInventory.AddCell(cellTotalFilesHeader);
      
        cellblank.BorderWidth = 0.0f;
        /// setting the boreder after header
        iTextSharp.text.pdf.PdfPCell RowBoarder = new iTextSharp.text.pdf.PdfPCell();
        RowBoarder.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder111 = new iTextSharp.text.pdf.PdfPCell[] { RowBoarder };
        RowBoarder.Colspan = 7;
        RowBoarder.BorderWidth = 1;
        SetDefaulfBorder(pdfRowCellsborder111, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        TableInventory.AddCell(RowBoarder);
        TableInventory.AddCell(cellblank);
        for (int j = 0; j < dtInventoryDet.Rows.Count; j++)
        {
            iTextSharp.text.pdf.PdfPCell cellCommon = new iTextSharp.text.pdf.PdfPCell();
            //iTextSharp.text.pdf.PdfPCell cellDepartmentNameHeaderValue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtInventoryDet.Rows[j]["DepartmentName"])));
            string InBox = Convert.ToString(dtInventoryDet.Rows[j]["InBox"]) == "" ? "0" : Convert.ToString(dtInventoryDet.Rows[j]["InBox"]);
            string OutBox = Convert.ToString(dtInventoryDet.Rows[j]["OutBox"]) == "" ? "0" : Convert.ToString(dtInventoryDet.Rows[j]["OutBox"]);
            string TotalBoxes = Convert.ToString(dtInventoryDet.Rows[j]["TotalBoxes"]) == "" ? "0" : Convert.ToString(dtInventoryDet.Rows[j]["TotalBoxes"]);
            string InFile = Convert.ToString(dtInventoryDet.Rows[j]["InFile"]) == "" ? "0" : Convert.ToString(dtInventoryDet.Rows[j]["InFile"]);
            string OutFile = Convert.ToString(dtInventoryDet.Rows[j]["OutFile"]) == "" ? "0" : Convert.ToString(dtInventoryDet.Rows[j]["OutFile"]);
            string TotalFiles = Convert.ToString(dtInventoryDet.Rows[j]["TotalFiles"]) == "" ? "0" : Convert.ToString(dtInventoryDet.Rows[j]["TotalFiles"]);
            iTextSharp.text.pdf.PdfPCell cellInBoxHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(InBox));
            iTextSharp.text.pdf.PdfPCell cellOutBoxHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(OutBox));
            iTextSharp.text.pdf.PdfPCell cellTotalBoxesHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(TotalBoxes));
            iTextSharp.text.pdf.PdfPCell cellInFileHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(InFile));
            iTextSharp.text.pdf.PdfPCell cellOutFileHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(OutFile));
            iTextSharp.text.pdf.PdfPCell cellTotalFilesHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(TotalFiles));
            iTextSharp.text.pdf.PdfPCell cellYearHeaderValue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtInventoryDet.Rows[j]["Years"])));
            iTextSharp.text.pdf.PdfPCell cellAcknowledgementvalue = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPTable tableACk = new iTextSharp.text.pdf.PdfPTable(1);
            iTextSharp.text.pdf.PdfPCell[] pdfRowCells = new iTextSharp.text.pdf.PdfPCell[] { cellblank, cellCommon,cellYearHeaderValue , cellInBoxHeadervalue, cellOutBoxHeadervalue, cellTotalBoxesHeadervalue, cellInFileHeadervalue, cellOutFileHeadervalue, cellTotalFilesHeadervalue };
            SetDefaulfBorder(pdfRowCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            TableInventory.AddCell(cellYearHeaderValue);
            TableInventory.AddCell(cellInBoxHeadervalue);
            TableInventory.AddCell(cellOutBoxHeadervalue);
            TableInventory.AddCell(cellTotalBoxesHeadervalue);
            TableInventory.AddCell(cellInFileHeadervalue);
            TableInventory.AddCell(cellOutFileHeadervalue);
            TableInventory.AddCell(cellTotalFilesHeadervalue);
            cellblank.Colspan = 7;
            TableInventory.AddCell(cellblank);
            cellbordersmallGrey.Colspan = 7;
            cellbordersmallGrey.Colspan = 7;
            TableInventory.AddCell(cellblank);
        }

        cellblank.Colspan =7;
        TableInventory.AddCell(cellblank);
        cellbordersmallGrey.Colspan = 7;
        cellbordersmallGrey.Colspan = 7;
        TableInventory.AddCell(cellblank);
        return TableInventory;
    }

    public iTextSharp.text.pdf.PdfPTable GetFreshFilePickupFileSearch(DataTable dtFreshFP)
    {
        iTextSharp.text.pdf.PdfPTable TableFreshFilePickupFileBoxSearch = new iTextSharp.text.pdf.PdfPTable(12);
        float[] TableFreshFilePickupFileBoxSearchwidth = new float[] { 250f, 250f, 300f, 250f, 200f, 250f, 250f, 250f, 150f, 150f, 150f, 150f };
        TableFreshFilePickupFileBoxSearch.WidthPercentage = 100;
        TableFreshFilePickupFileBoxSearch.SetWidths(TableFreshFilePickupFileBoxSearchwidth);
        iTextSharp.text.pdf.PdfPCell cellCustomerWiseHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" "));
        cellCustomerWiseHeader.VerticalAlignment = iTextSharp.text.Element.ALIGN_CENTER;
        cellCustomerWiseHeader.Colspan = 12;
        cellCustomerWiseHeader.BorderWidth = 0.0f;
        iTextSharp.text.pdf.PdfPCell cellWareHouseHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("WareHouse", calibri));
        iTextSharp.text.pdf.PdfPCell cellCompanyGroupHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Company Group", calibri));
        iTextSharp.text.pdf.PdfPCell cellCustomerHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Customer", calibri));
        iTextSharp.text.pdf.PdfPCell cellDepartmentHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Department", calibri));
        iTextSharp.text.pdf.PdfPCell cellStatusHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Status", calibri));
        iTextSharp.text.pdf.PdfPCell cellBoxBarcodeHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Box Barcode", calibri));
        iTextSharp.text.pdf.PdfPCell cellLocationHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Location Code", calibri));
        iTextSharp.text.pdf.PdfPCell cellFileNameHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("File Description1", calibri));
        iTextSharp.text.pdf.PdfPCell cellFileBarCodeHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("File BarCode", calibri));
        iTextSharp.text.pdf.PdfPCell cellLabel1Header = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("From No", calibri));
        iTextSharp.text.pdf.PdfPCell cellLabel2Header = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("To No", calibri));
        iTextSharp.text.pdf.PdfPCell cellLabel3Header = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("File Type", calibri));
        iTextSharp.text.pdf.PdfPCell cellFileNameDesc2 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("File Description2", calibri));
        iTextSharp.text.pdf.PdfPCell cellFileNameDestructionDueDate = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Destruction Due Date", calibri));

        iTextSharp.text.pdf.PdfPCell cellbordersmall1 = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmall1.Colspan = 12;
        cellbordersmall1.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder1 = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmall1 };
        SetDefaulfBorder(pdfRowCellsborder1, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        cellCustomerWiseHeader.Border = 1;
        iTextSharp.text.pdf.PdfPCell cellbordersmallmicro1 = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallmicro1.Colspan = 12;
        cellbordersmallmicro1.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborder1 = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallmicro1 };
        SetDefaulfBorder(pdfRowsCellsborder1, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);

        iTextSharp.text.pdf.PdfPCell cellbordersmallGrey1 = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallGrey1.Colspan = 12;
        cellbordersmallGrey1.BorderColor = iTextSharp.text.BaseColor.LIGHT_GRAY;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborderGrey1 = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallGrey1 };
        SetDefaulfBorder(pdfRowsCellsborderGrey1, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell[] pdfCells1 = new iTextSharp.text.pdf.PdfPCell[] { cellCustomerWiseHeader, cellWareHouseHeader, cellCompanyGroupHeader, cellCustomerHeader, cellDepartmentHeader, cellStatusHeader, cellBoxBarcodeHeader, cellLocationHeader, cellFileNameHeader, cellFileNameDesc2, cellFileBarCodeHeader, cellLabel1Header, cellLabel2Header, cellFileNameDestructionDueDate, cellLabel3Header }; //cellLabel1Header, cellLabel2Header,
        SetDefaulfBorder(pdfCells1, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell cellblank1 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri)));
        cellblank1.Colspan = 12;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsblank1 = new iTextSharp.text.pdf.PdfPCell[] { cellblank1 };
        SetDefaulfBorder(pdfRowCellsblank1, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        //Adding Headers to Service completion 
        TableFreshFilePickupFileBoxSearch.AddCell(cellblank1);

        TableFreshFilePickupFileBoxSearch.AddCell(cellCustomerWiseHeader);
        TableFreshFilePickupFileBoxSearch.AddCell(cellWareHouseHeader);
        TableFreshFilePickupFileBoxSearch.AddCell(cellCompanyGroupHeader);
        TableFreshFilePickupFileBoxSearch.AddCell(cellCustomerHeader);
        TableFreshFilePickupFileBoxSearch.AddCell(cellBoxBarcodeHeader);
        TableFreshFilePickupFileBoxSearch.AddCell(cellLocationHeader);
        TableFreshFilePickupFileBoxSearch.AddCell(cellFileBarCodeHeader);
        TableFreshFilePickupFileBoxSearch.AddCell(cellFileNameHeader);
        TableFreshFilePickupFileBoxSearch.AddCell(cellFileNameDesc2);
        TableFreshFilePickupFileBoxSearch.AddCell(cellDepartmentHeader);
        TableFreshFilePickupFileBoxSearch.AddCell(cellLabel1Header);
        TableFreshFilePickupFileBoxSearch.AddCell(cellLabel2Header);
        TableFreshFilePickupFileBoxSearch.AddCell(cellLabel3Header);
        TableFreshFilePickupFileBoxSearch.AddCell(cellFileNameDestructionDueDate);
        TableFreshFilePickupFileBoxSearch.AddCell(cellStatusHeader);
        cellblank1.BorderWidth = 0.0f;
        /// setting the boreder after header
        iTextSharp.text.pdf.PdfPCell RowBoarder1 = new iTextSharp.text.pdf.PdfPCell();
        RowBoarder1.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder11 = new iTextSharp.text.pdf.PdfPCell[] { RowBoarder1 };
        RowBoarder1.Colspan = 12;
        RowBoarder1.BorderWidth = 1;
        SetDefaulfBorder(pdfRowCellsborder11, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        TableFreshFilePickupFileBoxSearch.AddCell(RowBoarder1);
        TableFreshFilePickupFileBoxSearch.AddCell(cellblank1);
        for (int j = 0; j < dtFreshFP.Rows.Count; j++)
        {
            iTextSharp.text.pdf.PdfPCell cellCommon1 = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPCell cellWareHouseHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFreshFP.Rows[j]["WareHouse"])));
            iTextSharp.text.pdf.PdfPCell cellCompanyGroupHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFreshFP.Rows[j]["Company Group"])));
            iTextSharp.text.pdf.PdfPCell cellCustomerHeaderValue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFreshFP.Rows[j]["Customer"])));
            iTextSharp.text.pdf.PdfPCell cellDeptHeaderValue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFreshFP.Rows[j]["Department"])));
            iTextSharp.text.pdf.PdfPCell cellStatusHeaderValue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFreshFP.Rows[j]["Status"])));
            iTextSharp.text.pdf.PdfPCell cellBoxBarcodeHeaderValue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFreshFP.Rows[j]["Box Barcode"])));
            iTextSharp.text.pdf.PdfPCell cellLocationHeaderValue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFreshFP.Rows[j]["Location"])));
            iTextSharp.text.pdf.PdfPCell cellFileNameHeaderValue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFreshFP.Rows[j]["File Description1"])));
            iTextSharp.text.pdf.PdfPCell cellFileNameDescr2 = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFreshFP.Rows[j]["File Description2"])));
            iTextSharp.text.pdf.PdfPCell cellLabel1Headervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFreshFP.Rows[j]["From No"])));
            iTextSharp.text.pdf.PdfPCell cellLabel2Headervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFreshFP.Rows[j]["To No"])));
            iTextSharp.text.pdf.PdfPCell cellLabel3Headervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFreshFP.Rows[j]["File Type"])));
            iTextSharp.text.pdf.PdfPCell cellFileDestructionDueDt = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFreshFP.Rows[j]["Destruction Due Date"])));
            iTextSharp.text.pdf.PdfPCell cellFileBarCodeHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFreshFP.Rows[j]["File BarCode"])));

            iTextSharp.text.pdf.PdfPCell cellAcknowledgementvalue = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPTable tableACk = new iTextSharp.text.pdf.PdfPTable(1);
            iTextSharp.text.pdf.PdfPCell[] pdfRowCells = new iTextSharp.text.pdf.PdfPCell[] { cellblank1, cellCommon1, cellWareHouseHeadervalue, cellCompanyGroupHeadervalue, cellCustomerHeaderValue, cellDeptHeaderValue, cellStatusHeaderValue, cellBoxBarcodeHeaderValue, cellLocationHeaderValue, cellFileNameHeaderValue, cellFileNameDescr2, cellFileBarCodeHeadervalue, cellLabel1Headervalue, cellLabel2Headervalue, cellFileDestructionDueDt, cellLabel3Headervalue }; //cellLabel1Headervalue, cellLabel2Headervalue, 
            SetDefaulfBorder(pdfRowCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            TableFreshFilePickupFileBoxSearch.AddCell(cellWareHouseHeadervalue);
            TableFreshFilePickupFileBoxSearch.AddCell(cellCompanyGroupHeadervalue);
            TableFreshFilePickupFileBoxSearch.AddCell(cellCustomerHeaderValue);
            TableFreshFilePickupFileBoxSearch.AddCell(cellBoxBarcodeHeaderValue);
            TableFreshFilePickupFileBoxSearch.AddCell(cellLocationHeaderValue);
            TableFreshFilePickupFileBoxSearch.AddCell(cellFileBarCodeHeadervalue);
            TableFreshFilePickupFileBoxSearch.AddCell(cellFileNameHeaderValue);
            TableFreshFilePickupFileBoxSearch.AddCell(cellFileNameDescr2);
            TableFreshFilePickupFileBoxSearch.AddCell(cellDeptHeaderValue);
            TableFreshFilePickupFileBoxSearch.AddCell(cellLabel1Headervalue);
            TableFreshFilePickupFileBoxSearch.AddCell(cellLabel2Headervalue);
            TableFreshFilePickupFileBoxSearch.AddCell(cellLabel3Headervalue);
            TableFreshFilePickupFileBoxSearch.AddCell(cellFileDestructionDueDt);
            TableFreshFilePickupFileBoxSearch.AddCell(cellStatusHeaderValue);
            cellblank1.Colspan = 12;
            TableFreshFilePickupFileBoxSearch.AddCell(cellblank1);
            cellbordersmallGrey1.Colspan = 12;
            cellbordersmallGrey1.Colspan = 12;

        }
        return TableFreshFilePickupFileBoxSearch;
    }

    public iTextSharp.text.pdf.PdfPTable GetFreshFilePickupBoxSearch(DataTable dtFreshFP)
    {
        iTextSharp.text.pdf.PdfPTable TableFreshFilePickupFileBoxSearch = new iTextSharp.text.pdf.PdfPTable(5);
        float[] TableFreshFilePickupFileBoxSearchwidth = new float[] { 150f, 170f, 150f, 200f, 150f };
        TableFreshFilePickupFileBoxSearch.WidthPercentage = 100;
        TableFreshFilePickupFileBoxSearch.SetWidths(TableFreshFilePickupFileBoxSearchwidth);
        iTextSharp.text.pdf.PdfPCell cellCustomerWiseHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" "));
        cellCustomerWiseHeader.VerticalAlignment = iTextSharp.text.Element.ALIGN_CENTER;
        cellCustomerWiseHeader.Colspan = 5;
        cellCustomerWiseHeader.BorderWidth = 0.0f;
        iTextSharp.text.pdf.PdfPCell cellWareHouseHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Ware House", calibri));
        iTextSharp.text.pdf.PdfPCell cellCompanyGroupHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Company Group", calibri));
        iTextSharp.text.pdf.PdfPCell cellCustomerHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Customer", calibri));
        iTextSharp.text.pdf.PdfPCell cellBoxBarcodeHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Box Barcode", calibri));
        iTextSharp.text.pdf.PdfPCell cellLocationHeader = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase("Location Code", calibri));
        iTextSharp.text.pdf.PdfPCell cellbordersmall1 = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmall1.Colspan = 5;
        cellbordersmall1.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder1 = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmall1 };
        SetDefaulfBorder(pdfRowCellsborder1, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        cellCustomerWiseHeader.Border = 1;
        iTextSharp.text.pdf.PdfPCell cellbordersmallmicro1 = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallmicro1.Colspan = 5;
        cellbordersmallmicro1.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborder1 = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallmicro1 };
        SetDefaulfBorder(pdfRowsCellsborder1, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);

        iTextSharp.text.pdf.PdfPCell cellbordersmallGrey1 = new iTextSharp.text.pdf.PdfPCell();
        cellbordersmallGrey1.Colspan = 5;
        cellbordersmallGrey1.BorderColor = iTextSharp.text.BaseColor.LIGHT_GRAY;
        iTextSharp.text.pdf.PdfPCell[] pdfRowsCellsborderGrey1 = new iTextSharp.text.pdf.PdfPCell[] { cellbordersmallGrey1 };
        SetDefaulfBorder(pdfRowsCellsborderGrey1, 0.001f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell[] pdfCells1 = new iTextSharp.text.pdf.PdfPCell[] { cellCustomerWiseHeader, cellWareHouseHeader, cellCustomerHeader, cellCompanyGroupHeader, cellBoxBarcodeHeader, cellLocationHeader };
        SetDefaulfBorder(pdfCells1, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        iTextSharp.text.pdf.PdfPCell cellblank1 = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" ", calibri)));
        cellblank1.Colspan = 5;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsblank1 = new iTextSharp.text.pdf.PdfPCell[] { cellblank1 };
        SetDefaulfBorder(pdfRowCellsblank1, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        //Adding Headers to Service completion 
        TableFreshFilePickupFileBoxSearch.AddCell(cellblank1);
        TableFreshFilePickupFileBoxSearch.AddCell(cellWareHouseHeader);
        TableFreshFilePickupFileBoxSearch.AddCell(cellCustomerHeader);
        TableFreshFilePickupFileBoxSearch.AddCell(cellCompanyGroupHeader);
        TableFreshFilePickupFileBoxSearch.AddCell(cellBoxBarcodeHeader);
        TableFreshFilePickupFileBoxSearch.AddCell(cellLocationHeader);
        cellblank1.BorderWidth = 0.0f;
        /// setting the boreder after header
        iTextSharp.text.pdf.PdfPCell RowBoarder1 = new iTextSharp.text.pdf.PdfPCell();
        RowBoarder1.BorderColor = iTextSharp.text.BaseColor.BLACK;
        iTextSharp.text.pdf.PdfPCell[] pdfRowCellsborder11 = new iTextSharp.text.pdf.PdfPCell[] { RowBoarder1 };
        RowBoarder1.Colspan = 5;
        RowBoarder1.BorderWidth = 1;
        SetDefaulfBorder(pdfRowCellsborder11, 0.01f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
        TableFreshFilePickupFileBoxSearch.AddCell(RowBoarder1);
        TableFreshFilePickupFileBoxSearch.AddCell(cellblank1);
        for (int j = 0; j < dtFreshFP.Rows.Count; j++)
        {
            iTextSharp.text.pdf.PdfPCell cellCommon1 = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPCell cellWareHouseHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFreshFP.Rows[j]["Ware House"])));
            iTextSharp.text.pdf.PdfPCell cellCompanyGroupHeadervalue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFreshFP.Rows[j]["Company Group"])));
            iTextSharp.text.pdf.PdfPCell cellCustomerHeaderValue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFreshFP.Rows[j]["Customer"])));
            iTextSharp.text.pdf.PdfPCell cellBoxBarcodeHeaderValue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFreshFP.Rows[j]["Box Barcode"])));
            iTextSharp.text.pdf.PdfPCell cellLocationHeaderValue = new iTextSharp.text.pdf.PdfPCell(PdfCellElement(Convert.ToString(dtFreshFP.Rows[j]["Location Code"])));
            iTextSharp.text.pdf.PdfPCell cellAcknowledgementvalue = new iTextSharp.text.pdf.PdfPCell();
            iTextSharp.text.pdf.PdfPTable tableACk = new iTextSharp.text.pdf.PdfPTable(1);
            iTextSharp.text.pdf.PdfPCell[] pdfRowCells = new iTextSharp.text.pdf.PdfPCell[] { cellblank1, cellCommon1, cellWareHouseHeadervalue, cellCustomerHeaderValue, cellCompanyGroupHeadervalue, cellBoxBarcodeHeaderValue, cellLocationHeaderValue };
            SetDefaulfBorder(pdfRowCells, 0.0f, 0f, iTextSharp.text.Element.ALIGN_LEFT);
            TableFreshFilePickupFileBoxSearch.AddCell(cellWareHouseHeadervalue);
            TableFreshFilePickupFileBoxSearch.AddCell(cellCustomerHeaderValue);
            TableFreshFilePickupFileBoxSearch.AddCell(cellCompanyGroupHeadervalue);
            TableFreshFilePickupFileBoxSearch.AddCell(cellBoxBarcodeHeaderValue);
            TableFreshFilePickupFileBoxSearch.AddCell(cellLocationHeaderValue);
            cellblank1.Colspan = 5;
            TableFreshFilePickupFileBoxSearch.AddCell(cellblank1);
            cellbordersmallGrey1.Colspan = 5;
            cellbordersmallGrey1.Colspan = 5;

        }
        return TableFreshFilePickupFileBoxSearch;
    }


}
#endregion