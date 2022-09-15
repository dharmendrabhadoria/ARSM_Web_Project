<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true"
    CodeFile="FreshPickupSearch.aspx.cs" Inherits="Transaction_FreshPickupSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="../Styles/style.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/scrollableFixedHeaderTable.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../scripts/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="../scripts/jquery.cookie.pack.js"></script>
    <script type="text/javascript" src="../scripts/jquery.dimensions.min.js"></script>
    <script type="text/javascript" src="../scripts/jquery.scrollableFixedHeaderTable.js"></script>
    <script type="text/javascript" src="../scripts/jquery-list-attributes.js"></script>
    <script src="../Scripts/Freshpickup.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.maskedinput-1.3.1.min_.js" type="text/javascript"></script>
    <style>
        .div
        {
            font-family: Arial, Helvetica, sans-serif;
            border: 1px solid #CCCCCC;
            width: 802px;
        }
        
        .myTable
        {
            background-color: BLACK;
            font-size: 12px;
        }
        
        .myTable td
        {
            background-color: WHITE;
        }
        
        .myTable .header td
        {
            font-weight: bold;
            background-color: #CCCCCC;
        }
        
        .FileUpload
        {
            padding: 4px 15px;
            color: #ffffff;
            font-family: Arial;
            font-size: 13px;
            margin: 5px 5px 5px 0px;
            -webkit-border-radius: 5px;
            -moz-border-radius: 5px;
            border-radius: 5px;
            background: #fc9f24; /* Old browsers */
            background: -moz-linear-gradient(top,  #fc9f24 0%, #ce7e14 100%); /* FF3.6+ */
            background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#fc9f24), color-stop(100%,#ce7e14)); /* Chrome,Safari4+ */
            background: -webkit-linear-gradient(top,  #fc9f24 0%,#ce7e14 100%); /* Chrome10+,Safari5.1+ */
            background: -o-linear-gradient(top,  #fc9f24 0%,#ce7e14 100%); /* Opera 11.10+ */
            background: -ms-linear-gradient(top,  #fc9f24 0%,#ce7e14 100%); /* IE10+ */
            background: linear-gradient(to bottom,  #fc9f24 0%,#ce7e14 100%); /* W3C */
            filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#fc9f24', endColorstr='#ce7e14',GradientType=0 ); /* IE6-9 */
            border: #b77217 1px solid;
        }
    </style>
    <ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </ajax:ToolkitScriptManager>
    <style type="text/css">
        .AlternativeRowStyle
        {
            background-color: White;
        }
        
        #blocker
        {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            opacity: .5;
            background: url(../images/overlay-bg.png) repeat 0 0;
            z-index: 20;
        }
        #blocker div
        {
            position: absolute;
            top: 100%;
            left: 100%;
            width: 5em;
            height: 2em;
            margin: -1em 0 0 -2.5em;
            color: #fff;
            font-weight: bold;
        }
        
        .divActivityRate
        {
            background-color: #fff;
            z-index: 20000;
            position: fixed;
            background: #fff;
            padding: 20px;
            border: #e4e4e4 2px solid;
            box-shadow: 0 0 20px #000;
            display: none;
            width: 500px;
            left: 20%;
            top: 200px;
        }
        .ExcelTable2007
        {
            border: 1px solid #B0CBEF;
            border-width: 1px 0px 0px 1px;
            font-size: 11px;
            font-family: Calibri;
            font-weight: 100;
            border-spacing: 0px;
            border-collapse: collapse;
        }
        
        .FixedHeader
        {
            position: absolute;
            font-weight: bold;
        }
        .style2
        {
            width: 148px;
        }
        .style4
        {
            width: 373px;
        }
        .style5
        {
            width: 14%;
        }
    </style>
    <script src="../Scripts/Freshpickup.js" type="text/javascript" language="javascript" />
    <script type="text/javascript">
        Sys.Application.add_load(validbox());
    </script>
    <%--<script type="text/javascript">
         function validateFileUpload() {

                    var WareHouse = document.getElementById('ContentPlaceHolder1_ddlWareHouse').value;
                    if (ddlWareHouse == "0") {
                        alert("Please select WareHouse");
                        document.getElementById("ContentPlaceHolder1_ddlWareHouse").focus();
                        return false;
                    }
                    var CompanyGroup = document.getElementById('ContentPlaceHolder1_ddlCompanyGroup').value;
                    if (CompanyGroup == "0") {
                        alert("Please select CompanyGroup.");
                        document.getElementById("ContentPlaceHolder1_ddlCompanyGroup").focus();
                        return false;
                    }
                     
                    var uplSheet = document.getElementById('ContentPlaceHolder1_FileUpload2');
                    // alert(uplSheet.value.trim());
                    var extn = uplSheet.value.substring(uplSheet.value.lastIndexOf('.') + 1).toLowerCase();
                    if (uplSheet.value.trim() == "") {
                        alert('Please Select File To Upload');
                        return false;
                    }
                    var i = 1;
                    if (uplSheet.value.trim() == "") {
                        alert('Please Select File To Upload');
                        return false;
                    }
                    else {
                        if (uplSheet.value.trim() != "") {
                            // var i = 1;
                            if (extn == 'xls' || extn == 'xlsx') {
                                i = 0;
                            }
                        }
                    }
                    if (i == 1) {
                        uplSheet.value = '';
                        alert('You can upload file with (.xls Or .xlsx) extensions only.');
                        return false;
                    }


                    return true;

                }

    
    </script>--%>
    <asp:UpdatePanel ID="updpnlfreshpickup" runat="server">
        <ContentTemplate>
            <div class="clear">
            </div>
            <div class="middle">
                <div class="frmbxhead" style="width: 150px; z-index: 10!important;">
                    <asp:LinkButton ID="lnkbtnFreshPickup" runat="server" Font-Underline="false" Style="color: #4f4f4f !important;"
                        CausesValidation="false" OnClientClick="return false;"> Search Boxes/Files </asp:LinkButton>
                </div>
                <div class="frmbox">
                    <table width="100%" style="border: 2px" border="0">
                        <tr>
                            <td>
                            </td>
                            <td colspan="4">
                                <asp:RadioButtonList runat="server" ID="rbtactivityType" RepeatDirection="Horizontal"
                                    RepeatColumns="2" Width="260px" AutoPostBack="true" OnSelectedIndexChanged="rbtactivityType_SelectedIndexChanged"
                                    CausesValidation="True">
                                    <asp:ListItem Text="Box" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="File" Value="2" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                    </table>
                    <table width="100%" style="border: 2px" border="0">
                        <tr>
                            <td colspan="4" align="right">
                                <asp:Label runat="server" ID="lbltimerUpdate"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 14%">
                                WareHouse
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlWareHouse" runat="server" Width="211px" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlWareHouse_SelectedIndexChanged" Height="22px">
                                </asp:DropDownList>
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="ddlWareHouse"
                                    ErrorMessage="Please select WareHouse." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup"
                                    Display="Dynamic"></asp:RequiredFieldValidator>
                            </td>
                            <td width="15%">
                                Company Group
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlCompanyGroup" runat="server" AutoPostBack="true" Width="210"
                                    OnSelectedIndexChanged="ddlCompanyGroup_SelectedIndexChanged">
                                </asp:DropDownList>
                                <span id="SpnddlCompanyGroup" style="color: Red;"></span>
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlCompanyGroup"
                                    ErrorMessage="Please select company Group." InitialValue="0" ForeColor="Red"
                                    ValidationGroup="SaveGroup" Display="Dynamic"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Customer
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlCustomer" runat="server" AutoPostBack="true" Width="210"
                                    OnSelectedIndexChanged="ddlCustomer_SelectedIndexChanged">
                                </asp:DropDownList>
                                <br />
                                <span id="SpnddlCustomer" style="color: Red;"></span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlCustomer"
                                    ErrorMessage="Please select Customer" InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup"
                                    Display="Dynamic"></asp:RequiredFieldValidator>
                            </td>
                            <td>
                                <asp:Label ID="lb1BoxFile" runat="server" Text="File BarCode"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox runat="server" ID="txtFileBarcode" Width="194px"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                    <table width="100%" style="border: 2px" border="0" runat="server" id="trIMPORT" visible="false">
                        <tr>
                            <td>
                                Upload Box Bar Code File
                            </td>
                            <td colspan="3">
                                <%--<asp:FileUpload ID="fuBoxBarCode" runat="server" />&nbsp;
                                <asp:Button ID="btnIpload" runat="server" Text="Import" OnClick="btnIpload_Click" />
                                <asp:FileUpload ID="fuBoxBarCode" runat="server" />&nbsp;<asp:Button ID="btnIpload"
                                    runat="server" Text="Import" OnClick="btnIpload_Click" />--%>
                            </td>
                        </tr>
                    </table>
                    <div id="dvFile" runat="server">
                        <table style="border-style: none; border-color: inherit; border-width: 2px; width: 102%;"
                            border="0">
                            <tr>
                                <td class="style5">
                                    File Description1 :
                                </td>
                                <td class="style4">
                                    <asp:TextBox runat="server" ID="txtFile" Width="194px"></asp:TextBox>
                                </td>
                                <td class="style2">
                                    File Description2 :
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtFileDesc2" Width="194px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="style5">
                                    File Type :
                                </td>
                                <td class="style4">
                                    <asp:TextBox runat="server" ID="txtlbl3" Width="194px"></asp:TextBox>
                                </td>
                                <td class="style2">
                                    Department :
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ddlDept" Width="210">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td class="style5">
                                    From No :
                                </td>
                                <td class="style4">
                                    <asp:TextBox runat="server" ID="txtlbl1" Width="194px"></asp:TextBox>
                                </td>
                                <td class="style2">
                                    To No :
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtlbl2" Width="194px"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <table style="border-style: none; border-color: inherit; border-width: 2px; width: 100%;"
                        border="0">
                        <tr>
                            <td width="1%">
                                <asp:Button ID="btnSearch" runat="server" Text="View" ValidationGroup="SaveGroup"
                                    OnClick="btnSearch_Click" />
                            </td>
                            <td width="4%">
                                <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" />
                            </td>
                            <td style="width: 5%">
                                <asp:Label runat="server" ID="lblType" Text="Type:"></asp:Label>
                            </td>
                            <td>
                                <asp:RadioButtonList ID="rdbtnlstReportType" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem Text="PDF" Value="0" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Excel" Value="1"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                            <td>
                                <asp:Button ID="btnExportToExcel" runat="server" OnClick="btnExportToExcel_Click"
                                    Visible="false" Text="Export & Print" />
                            </td>
                        </tr>
                    </table>
                    <table>
                        <tr>
                            <td colspan="1">
                                <asp:Label ID="lblFileFrshPickUpSearch" runat="server" Text=" Upload File barcode excel file"></asp:Label>
                            </td>
                            <td colspan="3">
                                <asp:FileUpload ID="FileUpld1" runat="server" />
                                <asp:Button ID="btnFileFreshPickUpSearch" runat="server" Text="File Upload" OnClick="btnFileFreshPickUpSearch_Click" />
                            </td>
                            <td colspan="2">
                                <asp:HyperLink ID="HyperLink3" runat="server" 
                                    NavigateUrl="~/ExcelSheetFormats/Excel_File_freshPickupSearch.xlsx">Excel format for File</asp:HyperLink>
                                <br />
                                <br />
                                <asp:Label ID="lblErrMsgFrshPickUp" runat="server"></asp:Label>
                            </td>
                            <td>
                                <asp:GridView ID="gvFreshFileError" runat="server">
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                    <div runat="server" id="divFileDetails" width="100%">
                        <table border="0" width="100%">
                            <tr>
                                <td>
                                    <asp:Label ID="lblEmptyMessage" runat="server" Text="" ForeColor="Red" Font-Size="Small"
                                        Visible="false"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div style="overflow: auto; height: 350px;">
                                        <asp:GridView runat="server" ID="gvFileData" AutoGenerateColumns="false" Width="120%"
                                            BackColor="White" UseAccessibleHeader="true" CssClass="grid_data" HeaderStyle-CssClass="header">
                                            <Columns>
                                              <%--  <asp:BoundField HeaderText="Ware House" ItemStyle-Width="15%" DataField="WareHouse" />
                                                <asp:BoundField HeaderText="Company Group" ItemStyle-Width="20%" DataField="Company Group" />
                                                <asp:BoundField HeaderText="Customer" ItemStyle-Width="15%" DataField="Customer" />--%>
                                                <asp:BoundField HeaderText="Box Barcode" ItemStyle-Width="10%" DataField="Box Barcode" />
                                                <asp:BoundField HeaderText="File BarCode" ItemStyle-Width="10%" DataField="File BarCode" />
                                                <asp:BoundField HeaderText="Location Code" ItemStyle-Width="10%" DataField="Location" />
                                                <asp:BoundField HeaderText="File Description1" ItemStyle-Width="13%" DataField="File Description1" />
                                                <asp:BoundField HeaderText="File Description2" ItemStyle-Width="13%" DataField="File Description2" />
                                                <asp:BoundField HeaderText="Department" ItemStyle-Width="7%" DataField="Department" />
                                                <asp:BoundField HeaderText="Year" ItemStyle-Width="7%" DataField="Year" />
                                                <asp:BoundField HeaderText="From Date" ItemStyle-Width="8%" DataField="FromDate" />
                                                <asp:BoundField HeaderText="To Date" ItemStyle-Width="8%" DataField="ToDate" />
                                                <asp:BoundField HeaderText="File Type" ItemStyle-Width="8%" DataField="File Type" />
                                                <asp:BoundField HeaderText="From No" ItemStyle-Width="8%" DataField="From No" />
                                                <asp:BoundField HeaderText="To No" ItemStyle-Width="8%" DataField="To No" />
                                                <asp:BoundField HeaderText="Destruction Due Date" ItemStyle-Width="8%" DataField="Destruction Due Date" />
                                                <asp:BoundField HeaderText="Status" ItemStyle-Width="8%" DataField="Status" />
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div runat="server" id="divBoxDetails">
                        <table width="80%" align="center">
                            <tr>
                                <td>
                                    <asp:Label ID="lb1MsgBoxDetails" runat="server" Text="" ForeColor="Red" Font-Size="Small"
                                        Visible="false"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div style="overflow: auto; height: 350px" width="80%">
                                        <asp:GridView runat="server" ID="gvBoxDetails" AutoGenerateColumns="false" Width="100%"
                                            BackColor="White" UseAccessibleHeader="true" CssClass="grid_data" HeaderStyle-CssClass="header">
                                            <Columns>
                                                <asp:BoundField HeaderText="Ware House" ItemStyle-Width="10%" DataField="Ware House" />
                                                <asp:BoundField HeaderText="Company Group" ItemStyle-Width="15%" DataField="Company Group" />
                                                <asp:BoundField HeaderText="Customer" ItemStyle-Width="10%" DataField="Customer" />
                                                <asp:BoundField HeaderText="Box Barcode" ItemStyle-Width="10%" DataField="Box Barcode" />
                                                <asp:BoundField HeaderText="Location Code" ItemStyle-Width="20%" DataField="Location Code" />
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <div id="divDuplicateRecord" class="divActivityRate" style="display: none;">
                <div style="float: right">
                    <asp:HyperLink Text="Close" ForeColor="Blue" runat="server" Style="cursor: pointer"
                        ID="HyperLink1"></asp:HyperLink>
                </div>
                <asp:Label runat="server" ID="lblMsg" Font-Bold="true" Font-Size="12px" Style="padding-left: 150px;"></asp:Label>
                <div style="overflow: auto; height: 100px; padding-left: 25px;">
                    <asp:GridView ID="grdduplicateEntry" runat="server" AutoGenerateColumns="true" Width="500px"
                        CssClass="grid_data">
                        <Columns>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
            <div id="divWoActivityDetails" class="divActivityRate" style="display: none; width: 100%!important;
                padding-left: 1px;">
                <div style="float: right; margin-top: -15px!important;">
                    <asp:HyperLink Text="Close" ForeColor="Blue" runat="server" Style="cursor: pointer;"
                        ID="HyperLink2" onclick=" HidedivWoActivityDetails();"></asp:HyperLink>
                </div>
                <asp:Label runat="server" ID="Label1" Font-Bold="true" Font-Size="12px"></asp:Label>
                <center>
                    <div style="overflow: auto; height: 250px; width: 100%; margin-top: 10px;">
                        <%--      <asp:GridView ID="gridviewWoActivityDetails" runat="server" CellPadding="0" CellSpacing="0" Width="100%"  CssClass="grid_data" AutoGenerateColumns="false"  >
                    <Columns>
                      <asp:TemplateField HeaderText="Sr No."   ItemStyle-Width= "7%" >
                                <ItemTemplate>
                                    <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'  ></asp:Label>
                                </ItemTemplate>

<ItemStyle Width="7%"></ItemStyle>
                            </asp:TemplateField>
                    <asp:BoundField DataField="Box BarCode"  HeaderText="Box BarCode"   />
                    <asp:BoundField DataField="File BarCode" HeaderText="File BarCode"  />
                    <asp:TemplateField HeaderText="Year"  >
                    <ItemTemplate>
                    <asp:Label runat="server" ID="lblyear" Text='<%# Getyear(Eval("Year") ) %>'   ></asp:Label>
                     </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="From Date"  >
                    <ItemTemplate>
                    <asp:Label runat="server" ID="lblFromDate" Text='<%# GetFromatedDate(Eval("From Date") ) %>'   ></asp:Label>
                     </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="To Date"  >
                    <ItemTemplate>
                    <asp:Label runat="server" ID="lblToDate" Text='<%# GetFromatedDate(Eval("To Date") ) %>'   ></asp:Label>
                     </ItemTemplate>
                    </asp:TemplateField>
                    </Columns>
                    </asp:GridView>--%>
                    </div>
                </center>
            </div>
            <div id="blocker" style="display: none">
                <div>
                    Loading...</div>
            </div>
            <script type="text/javascript">
                jQuery(function ($) {
                    $("[id^='ContentPlaceHolder1_grdFilesDetails_txtFdate_']").mask('99/99/9999');
                    $("[id^='ContentPlaceHolder1_grdFilesDetails_txtEdate_']").mask('99/99/9999');
                    $("[id^='ContentPlaceHolder1_grdFilesDetails_txtyear_']").mask("9999? -99");

                });

                Sys.Application.add_load(function () { $('#ContentPlaceHolder1_grdboxdetails').scrollableFixedHeaderTable(600, 200); });
                Sys.Application.add_load(function () { $('#ContentPlaceHolder1_grdFilesDetails').scrollableFixedHeaderTable(1100, 200); });
                                          

                                            
  
            </script>
            </script>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="ddlCompanyGroup" EventName="SelectedIndexChanged" />
            <asp:PostBackTrigger ControlID="rbtactivityType" />
            <asp:PostBackTrigger ControlID="rbtactivityType" />
            <asp:PostBackTrigger ControlID="btnClear" />
            <asp:PostBackTrigger ControlID="btnSearch" />
            <asp:PostBackTrigger ControlID="btnExportToExcel" />
            <asp:PostBackTrigger ControlID="gvFileData" />
          <%--  <asp:PostBackTrigger ControlID="btnIpload" />--%>
            <asp:PostBackTrigger ControlID="btnFileFreshPickUpSearch" />
        </Triggers>
    </asp:UpdatePanel>
    <script type="text/javascript">

        Sys.Application.add_load(function () { $("[id^='ContentPlaceHolder1_grdFilesDetails_txtFdate_']").mask('99/99/9999'); });
        Sys.Application.add_load(function () { $("[id^='ContentPlaceHolder1_grdFilesDetails_txtEdate_']").mask('99/99/9999') });
        Sys.Application.add_load(function () { $("[id^='ContentPlaceHolder1_grdFilesDetails_txtyear_']").mask("9999? -99"); });
    </script>
</asp:Content>
