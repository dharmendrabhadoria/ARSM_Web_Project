<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true"
    CodeFile="FileRestoreRetrievalReport.aspx.cs" Inherits="Reports_FileRestoreRetrievalReport"
    EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .ui-autocomplete
        {
            background-color: white !important;
            width: 200px;
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
        .divCompanyGroup
        {
            background-color: #fff;
            z-index: 9999;
            position: absolute;
            background: #fff;
            padding: 15px;
            top: 90px;
            border: #e4e4e4 2px solid;
            box-shadow: 0 0 20px #000;
            width: 1120px;
            left: 16%;
            margin-left: -120px;
            display: none;
        }
        
        .divActivityRate
        {
            background-color: #fff;
            z-index: 9999;
            position: fixed;
            background: #fff;
            padding: 20px;
            top: 10px;
            border: #e4e4e4 2px solid;
            box-shadow: 0 0 20px #000;
            width: 900px;
            left: 16%;
            margin-left: -80px;
            display: none;
        }
        
        .divActivityContract
        {
            background-color: #ffffff;
            z-index: 9999;
            position: fixed;
            background: #ffffff;
            padding: 20px;
            top: 12px;
            border: #e4e4e4 2px solid;
            box-shadow: 0 0 20px #000;
            width: 900px;
            left: 16%;
            margin-left: -80px;
            display: none;
        }
        .frmbox td
        {
            padding: 5px;
        }
    </style>
    <script language="javascript" type="text/javascript">
        function divShowFilesdetails() {
            $('#divShowFilesdetails').show();
            $("#blocker").attr('style', 'display:block');
            $("#divShowFilesdetails").attr('style', 'display:block');
        }

        function divHideFilesdetails() {

            $('#divShowFilesdetails').hide();
            $("#divShowFilesdetails").attr('style', 'display:none');
            $("#blocker").attr('style', 'display:none');
        }

        function divShowBoxesDetials() {
            $('#divShowBoxesDetails').show();
            $("#blocker").attr('style', 'display:block');
            $("#divShowBoxesDetails").attr('style', 'display:block');
        }
        function divHideBoxesDetails() {
            $('#divShowBoxesDetails').hide();
            $("#divShowBoxesDetails").attr('style', 'display:none');
            $("#blocker").attr('style', 'display:none');
        }
        function divShowResFilesdetails() {
            $('#divShowResFilesdetails').show();
            $("#blocker").attr('style', 'display:block');
            $("#divShowResFilesdetails").attr('style', 'display:block');
        }
        function divHideResFilesdetails() {
            $('#divShowResFilesdetails').hide();
            $("#divShowResFilesdetails").attr('style', 'display:none');
            $("#blocker").attr('style', 'display:none');
        }
    </script>
    <script src="../Scripts/RestoreRetreivalReport.js" type="text/javascript"></script>
    <ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </ajax:ToolkitScriptManager>
    <asp:UpdatePanel ID="updActivity" runat="server">
        <ContentTemplate>
            <script type="text/javascript">
                Sys.Application.add_load(BindDates);
            </script>
            <div class="middle">
                <div class="frmbxhead" style="z-index: 0 !important;">
                    <asp:LinkButton ID="lnkbtnFilePickUp" runat="server" Font-Underline="false" Style="color: #4f4f4f !important;"
                        CausesValidation="false" OnClick="lnkbtnFilePickUp_Click">Retrieval & Restore Summary</asp:LinkButton>
                </div>
                <div class="frmbxhead" style="margin-left: 250px !important; margin-bottom: 0px !important;
                    z-index: 0 !important;">
                    <asp:LinkButton ID="lnkbtnFilePickUpdetails" runat="server" Font-Underline="false"
                        Style="color: #4f4f4f !important;" CausesValidation="false" OnClick="lnkbtnFilePickUpdetails_Click">Retrieval & Restore Details</asp:LinkButton>
                </div>
                <div class="frmbox">
                    <center>
                        <div id="divFilePickUp" runat="server" style="display: block;">
                            <table width="80%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td colspan="3">
                                        <%-- <asp:RadioButtonList ID="rdlstbtnReport" runat="server" AutoPostBack="True" 
                                        Height="16px" onselectedindexchanged="rdlstbtnReport_SelectedIndexChanged" 
                                        RepeatColumns="2" RepeatDirection="Horizontal" Width="396px">
                                        <asp:ListItem Selected="True" Text="Customer-Wise" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Department-Wise" Value="2"> </asp:ListItem>
                                    </asp:RadioButtonList>--%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Company Group
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlCompanyGroup" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlCompanyGroup_SelectedIndexChanged"
                                            Width="250">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        Customer
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlCustomer" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlCustomer_SelectedIndexChanged"
                                            Width="250">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        From Date
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtfromDate" runat="server" Width="150" CssClass="datepicker1" onkeypress="return false;">
                                        </asp:TextBox>
                                    </td>
                                    <td>
                                        To Date
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txttodate" runat="server" Width="150" CssClass="datepicker1" onkeypress="return false;">
                                        </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td>
                                        <asp:Button ID="btnview" runat="server" OnClick="btnview_Click" OnClientClick="javascript:return Validate();"
                                            Text="View" />
                                        &nbsp;&nbsp; &nbsp;
                                        <asp:Button ID="btnViewClear" runat="server" Text="Clear" OnClick="btnViewClear_Click" />
                                    </td>
                                    <asp:Panel ID="pnlExportype" runat="server" Visible="false">
                                        <td style="width: 5%">
                                            Type:
                                        </td>
                                        <td>
                                            <table border="0">
                                                <tr>
                                                    <td>
                                                        <asp:RadioButtonList ID="rdbtnlstReportType" runat="server" AutoPostBack="true" RepeatDirection="Horizontal">
                                                            <asp:ListItem Text="PDF" Value="0" Selected="True"></asp:ListItem>
                                                            <asp:ListItem Text="Excel" Value="1"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnExportToExcel" runat="server" OnClick="btnExportToExcel_Click"
                                                            Text="Export & Print" Visible="false" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </asp:Panel>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <div id="divgvClientwise" runat="server" style="overflow: auto; padding-left: 0px;
                                            color: #4f4f4f; font-size: 12px; width: 100%; height: 200px; line-height: 20px;
                                            display: block;">
                                            <asp:GridView ID="gvClientwise" runat="server" AutoGenerateColumns="false" CssClass="grid_data"
                                                OnRowDataBound="gvClientwise_RowDataBound" OnRowCreated="gvClientwise_RowCreated"
                                                ShowFooter="true" ShowHeader="true" Width="100%">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Customer Name">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblName" runat="server" Text='<%# Eval("CustomerName") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblTotal" runat="server" Font-Bold="true" Font-Size="14px" Text="Total"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="20%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="No. Of Boxes">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblNoOfBoxesRet" runat="server" Text='<%# Eval("NoOfBoxesRet") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblGrandTotalBoxesRet" runat="server" Font-Bold="true"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="15%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="No. Of Files">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblNoOfFilesRet" runat="server" Text='<%# Eval("NoOfFilesRet") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblGrandTotalFilesRet" runat="server" Font-Bold="true"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="15%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="No. Of Boxes">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblNoOfBoxesRes" runat="server" Text='<%# Eval("NoOfBoxesRes") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblGrandTotalBoxesRes" runat="server" Font-Bold="true"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="15%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="No. Of Files">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblNoOfFilesRes" runat="server" Text='<%# Eval("NoOfFilesRes") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblGrandTotalFilesRes" runat="server" Font-Bold="true"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="15%" />
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                        <div id="divDepartmentwise" runat="server" style="overflow: auto; padding-left: 0px;
                                            color: #4f4f4f; font-size: 12px; width: 70%; height: 200px; line-height: 20px;
                                            display: none;">
                                            <asp:GridView ID="GrdDepartmentwise" runat="server" AutoGenerateColumns="false" CssClass="grid_data"
                                                OnRowDataBound="GrdDepartmentwise_RowDataBound" ShowFooter="true" ShowHeader="true"
                                                Width="100%">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Department">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblName" runat="server" Text='<%# Eval("Department") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblTotal" runat="server" Font-Bold="true" Font-Size="14px" Text="Total"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="30%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="No. Of Files Retrieval">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblNoOfFilesRet" runat="server" Text='<%# Eval("NoOfFilesRet") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblGrandTotalFilesRet" runat="server" Font-Bold="true"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="20%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="No. Of Files Restore">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblNoOfFilesRes" runat="server" Text='<%# Eval("NoOfFilesRes") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblGrandTotalFilesRes" runat="server" Font-Bold="true"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="20%" />
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </td>
                                </tr>
                                </tr>
                            </table>
                        </div>
                        <div id="divFilePickUpdetails" runat="server" style="display: none;">
                            <table width="80%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td colspan="3">
                                        <asp:RadioButtonList ID="rdbtnFilePickDetails" runat="server" AutoPostBack="True"
                                            RepeatColumns="2" RepeatDirection="Horizontal" Width="300px" OnSelectedIndexChanged="rdbtnFilePickDetails_SelectedIndexChanged">
                                            <asp:ListItem Selected="True" Text="Work Order Number Wise" Value="1"> </asp:ListItem>
                                            <asp:ListItem Text="Work Order Date Wise" Value="2"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Company Group
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlCgpickDetails" runat="server" Width="250" AutoPostBack="true"
                                            OnSelectedIndexChanged="ddlCgpickDetails_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        Customer
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlCstpickDetails" runat="server" Width="250" AutoPostBack="true">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        From Date
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtFromDatepickDetials" runat="server" Width="150" CssClass="datepicker1"
                                            onkeypress="return false;"></asp:TextBox>
                                    </td>
                                    <td>
                                        To Date
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtToDatepickDetials" runat="server" Width="150" CssClass="datepicker1"
                                            onkeypress="return false;">
                                        </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td align="left">
                                        <asp:Button ID="btnViewPickDetails" runat="server" OnClientClick="javascript:return ValidateFile();"
                                            Text="View Details" OnClick="btnViewPickDetails_Click" />
                                        <asp:Button ID="btnClearDetails" runat="server" Text="Clear" OnClick="btnClearDetails_Click" />
                                    </td>
                                    <asp:Panel ID="PnlReportType" runat="server" Visible="false">
                                        <td style="width: 5%">
                                            Type:
                                        </td>
                                        <td>
                                            <table border="0">
                                                <tr>
                                                    <td>
                                                        <asp:RadioButtonList ID="rdbtnlstFielRetSDetails" runat="server" AutoPostBack="true"
                                                            RepeatDirection="Horizontal">
                                                            <asp:ListItem Text="PDF" Value="0" Selected="True"></asp:ListItem>
                                                            <asp:ListItem Text="Excel" Value="1"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnExportDetails" runat="server" Text="Export & Print" OnClick="btnExportDetails_Click"
                                                            Visible="false" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </asp:Panel>
                                    <tr>
                                        <td colspan="4">
                                            <div id="DivGrdFileDetailsWorkOrderNoWise" runat="server" style="overflow: auto;
                                                padding-left: 0px; color: #4f4f4f; font-size: 12px; width: 100%; height: 200px;
                                                line-height: 20px; display: block;">
                                                <asp:GridView ID="GrdFileDetailsWorkOrderNoWise" runat="server" AutoGenerateColumns="false"
                                                    OnRowCommand="GrdFileDetailsWorkOrderNoWise_RowCommand" CssClass="grid_data"
                                                    OnRowDataBound="GrdFileDetailsWorkOrderNoWise_RowDataBound" OnRowCreated="GrdFileDetailsWorkOrderNoWise_RowCreated"
                                                    ShowFooter="true" ShowHeader="true" Width="100%">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Work Order No.">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblWorkOrderNo" runat="server" Text='<%# Eval("WorkOrderNo") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Work Order Date">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblWorkOrderDate" runat="server" Text='<%# Eval("WorkOrderDate","{0:dd/MM/yyyy}") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Customer Name">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblName" runat="server" Text='<%# Eval("CustomerName") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <FooterTemplate>
                                                                <asp:Label ID="lblTotal" runat="server" Font-Bold="true" Font-Size="14px" Text="Total"></asp:Label>
                                                            </FooterTemplate>
                                                            <ItemStyle Width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="No. Of Boxes">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblNoOfBoxesRet" runat="server" Text='<%# Eval("NoOfBoxesRet") %>'
                                                                    Visible="false"></asp:Label>
                                                                <asp:LinkButton ID="lbtnBoxesRet" runat="server" Text='<%# Eval("NoOfBoxesRet") %>'
                                                                    CommandArgument='<%#Eval("WorkOrderNo") %>' CommandName="lnkBoxRetDetails" Font-Underline="true"
                                                                    Style="cursor: pointer" />
                                                            </ItemTemplate>
                                                            <FooterTemplate>
                                                                <asp:Label ID="lblGrandTotalBoxesDetailsRet" runat="server" Font-Bold="true"></asp:Label>
                                                            </FooterTemplate>
                                                            <ItemStyle Width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="No. Of Files">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblNoOfFilesRet" runat="server" Text='<%# Eval("NoOfFilesRet") %>'
                                                                    Visible="false"></asp:Label>
                                                                <asp:LinkButton ID="lbtnFilesRet" runat="server" Text='<%# Eval("NoOfFilesRet") %>'
                                                                    CommandArgument='<%#Eval("WorkOrderNo") %>' CommandName="lnkFileRetDetails" Font-Underline="true"
                                                                    Style="cursor: pointer" />
                                                            </ItemTemplate>
                                                            <FooterTemplate>
                                                                <asp:Label ID="lblGrandTotalFilesDetailsRet" runat="server" Font-Bold="true"></asp:Label>
                                                            </FooterTemplate>
                                                            <ItemStyle Width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="No. Of Boxes">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblNoOfBoxesRes" runat="server" Text='<%# Eval("NoOfBoxesRes") %>'
                                                                    Visible="false"></asp:Label>
                                                                <asp:LinkButton ID="lbtnBoxesRes" runat="server" Text='<%# Eval("NoOfBoxesRes") %>'
                                                                    CommandArgument='<%#Eval("WorkOrderNo") %>' CommandName="lnkBoxesResDetails"
                                                                    Font-Underline="true" Style="cursor: pointer" />
                                                            </ItemTemplate>
                                                            <FooterTemplate>
                                                                <asp:Label ID="lblGrandTotalBoxesDetailsRes" runat="server" Font-Bold="true"></asp:Label>
                                                            </FooterTemplate>
                                                            <ItemStyle Width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="No. Of Files">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblNoOfFilesRes" runat="server" Text='<%# Eval("NoOfFilesRes") %>'
                                                                    Visible="false"></asp:Label>
                                                                <asp:LinkButton ID="lbtnFilesRes" runat="server" Text='<%# Eval("NoOfFilesRes") %>'
                                                                    CommandArgument='<%#Eval("WorkOrderNo") %>' CommandName="lnkFilesResDetails"
                                                                    Font-Underline="true" Style="cursor: pointer" />
                                                            </ItemTemplate>
                                                            <FooterTemplate>
                                                                <asp:Label ID="lblGrandTotalFilesDetailsRes" runat="server" Font-Bold="true"></asp:Label>
                                                            </FooterTemplate>
                                                            <ItemStyle Width="10%" />
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                            <div id="DivGrdFileDetailsWorkOrderDateWise" runat="server" style="overflow: auto;
                                                padding-left: 0px; color: #4f4f4f; font-size: 12px; width: 100%; height: 200px;
                                                line-height: 20px; display: none;">
                                                <asp:GridView ID="GrdFileDetailsWorkOrderDateWise" runat="server" AutoGenerateColumns="false"
                                                    OnRowCommand="GrdFileDetailsWorkOrderDateWise_RowCommand" OnRowDataBound="GrdFileDetailsWorkOrderDateWise_RowDataBound"
                                                    CssClass="grid_data" OnRowCreated="GrdFileDetailsWorkOrderDateWise_RowCreated"
                                                    ShowFooter="true" ShowHeader="true" Width="100%">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Work Order Date">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblWorkOrderDate" runat="server" Text='<%# Eval("WorkOrderDate","{0:dd-MM-yyyy}") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Work Order No.">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblWorkOrderNo" runat="server" Text='<%# Eval("WorkOrderNo") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Customer Name">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblName" runat="server" Text='<%# Eval("CustomerName") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <FooterTemplate>
                                                                <asp:Label ID="lblTotal" runat="server" Font-Bold="true" Font-Size="14px" Text="Total"></asp:Label>
                                                            </FooterTemplate>
                                                            <ItemStyle Width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="No Of Boxes">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblNoOfBoxesRet" runat="server" Text='<%# Eval("NoOfBoxesRet") %>'
                                                                    Visible="false"></asp:Label>
                                                                <asp:LinkButton ID="lbtnBoxesRet" runat="server" Text='<%# Eval("NoOfBoxesRet") %>'
                                                                    CommandArgument='<%#Eval("WorkOrderNo") %>' CommandName="lnkBoxRetDetails" Font-Underline="true"
                                                                    Style="cursor: pointer" />
                                                            </ItemTemplate>
                                                            <FooterTemplate>
                                                                <asp:Label ID="lblGrandTotalBoxesDateWiseRet" runat="server" Font-Bold="true"></asp:Label>
                                                            </FooterTemplate>
                                                            <ItemStyle Width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="No Of Files">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblNoOfFilesRet" runat="server" Text='<%# Eval("NoOfFilesRet") %>'
                                                                    Visible="false"></asp:Label>
                                                                <asp:LinkButton ID="lbtnFilesRet" runat="server" Text='<%# Eval("NoOfFilesRet") %>'
                                                                    CommandArgument='<%#Eval("WorkOrderNo") %>' CommandName="lnkFileRetDetails" Font-Underline="true"
                                                                    Style="cursor: pointer" />
                                                            </ItemTemplate>
                                                            <FooterTemplate>
                                                                <asp:Label ID="lblGrandTotalFilesDateWiseRet" runat="server" Font-Bold="true"></asp:Label>
                                                            </FooterTemplate>
                                                            <ItemStyle Width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="No Of Boxes">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblNoOfBoxesRes" runat="server" Text='<%# Eval("NoOfBoxesRes") %>'
                                                                    Visible="false"></asp:Label>
                                                                <asp:LinkButton ID="lbtnBoxesRes" runat="server" Text='<%# Eval("NoOfBoxesRes") %>'
                                                                    CommandArgument='<%#Eval("WorkOrderNo") %>' CommandName="lnkBoxesResDetails"
                                                                    Font-Underline="true" Style="cursor: pointer" />
                                                            </ItemTemplate>
                                                            <FooterTemplate>
                                                                <asp:Label ID="lblGrandTotalBoxesDateWiseRes" runat="server" Font-Bold="true"></asp:Label>
                                                            </FooterTemplate>
                                                            <ItemStyle Width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="No Of Files">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblNoOfFilesRes" runat="server" Text='<%# Eval("NoOfFilesRes") %>'
                                                                    Visible="false"></asp:Label>
                                                                <asp:LinkButton ID="lbtnFilesRes" runat="server" Text='<%# Eval("NoOfFilesRes") %>'
                                                                    CommandArgument='<%#Eval("WorkOrderNo") %>' CommandName="lnkFilesResDetails"
                                                                    Font-Underline="true" Style="cursor: pointer" />
                                                            </ItemTemplate>
                                                            <FooterTemplate>
                                                                <asp:Label ID="lblGrandTotalFilesDateWiseRes" runat="server" Font-Bold="true"></asp:Label>
                                                            </FooterTemplate>
                                                            <ItemStyle Width="10%" />
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                        </td>
                                    </tr>
                                </tr>
                            </table>
                        </div>
                        <div id="divShowFilesdetails" class="divActivityRate" style="width: 910px !important;">
                            <div style="float: right">
                                <asp:HyperLink Text="close" ForeColor="Blue" runat="server" Style="cursor: pointer"
                                    ID="HyperLink1" onclick=" divHideFilesdetails();"></asp:HyperLink>
                            </div>
                            <br />
                            <div id="PrintdivShowWodetails" style="overflow: auto; padding-left: 15px; color: #4f4f4f;
                                font-size: 12px; width: 900px; height: 450px; line-height: 20px;">
                                <table style="text-align: left; width: 100%; height: auto;" border="0">
                                    <tr>
                                        <td colspan="6" style="text-align: center;">
                                            Files Details
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6">
                                            <asp:GridView runat="server" ID="gvFilesDetails" AutoGenerateColumns="false" Width="120%"
                                                BackColor="White" UseAccessibleHeader="true" CssClass="grid_data" HeaderStyle-CssClass="header">
                                                <EmptyDataTemplate>
                                                    <label style="width: 300px; color: Red; text-align: center; font-size: medium; padding-left: 400px;
                                                        font: message-box;">
                                                        No Record Available
                                                    </label>
                                                </EmptyDataTemplate>
                                                <Columns>
                                                    <asp:BoundField HeaderText="File BarCode" ItemStyle-Width="10%" DataField="FileBarCode" />
                                                    <asp:BoundField HeaderText="File Description1" ItemStyle-Width="10%" DataField="File Description1" />
                                                    <asp:BoundField HeaderText="File Description2" ItemStyle-Width="10%" DataField="File Description2" />
                                                    <asp:BoundField HeaderText="File Type" ItemStyle-Width="5%" DataField="File Type" />
                                                    <asp:BoundField HeaderText="From No" ItemStyle-Width="5%" DataField="From No" />
                                                    <asp:BoundField HeaderText="To No" ItemStyle-Width="5%" DataField="To No" />
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div id="divShowBoxesDetails" class="divActivityRate" style="width: 910px !important;">
                            <div style="float: right">
                                <asp:HyperLink Text="close" ForeColor="Blue" runat="server" Style="cursor: pointer"
                                    ID="HyperLink2" onclick=" divHideBoxesDetails();"></asp:HyperLink>
                            </div>
                            <br />
                            <div id="PrintdivShowBoxesDetails" style="overflow: auto; padding-left: 15px; color: #4f4f4f;
                                font-size: 12px; width: 900px; height: 450px; line-height: 20px;">
                                <table style="text-align: left; width: 100%; height: auto;" border="0">
                                    <tr>
                                        <td colspan="6" style="text-align: center;">
                                            Boxes Details
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6">
                                            <asp:GridView runat="server" ID="gvBoxesDetails" AutoGenerateColumns="false" Width="100%"
                                                BackColor="White" UseAccessibleHeader="true" CssClass="grid_data" HeaderStyle-CssClass="header">
                                                <EmptyDataTemplate>
                                                    <label style="width: 300px; color: Red; text-align: center; font-size: medium; padding-left: 400px;
                                                        font: message-box;">
                                                        No Record Available
                                                    </label>
                                                </EmptyDataTemplate>
                                                <Columns>
                                                    <asp:BoundField HeaderText="Box BarCode" ItemStyle-Width="10%" DataField="BoxBarCode" />
                                                   <%-- <asp:BoundField HeaderText="LocationCode" ItemStyle-Width="10%" DataField="LocationCode" />--%>
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div id="divShowResFilesdetails" class="divActivityRate" style="width: 1000px !important;">
                            <div style="float: right">
                                <asp:Button Text="Close" ForeColor="Blue" runat="server" Style="cursor: pointer"
                                    ID="btnFilePopupClose" OnClientClick="divHideResFilesdetails();" OnClick="btnFilePopupClose_Click" ></asp:Button>
                            </div>
                            <br />
                            <div id="Div1" style="overflow: auto; padding-left: 15px; color: #4f4f4f; font-size: 12px;
                                width: 900px; height: 450px; line-height: 20px;">
                                <table style="text-align: left; width: 100%; height: auto;" border="0">
                                    <tr>
                                        <td colspan="6" style="text-align: center;">
                                            Details
                                        </td>
                                    </tr>
                                    <tr>

                                        <td colspan="6">
                                            <asp:GridView runat="server" ID="gvResRetDetails" AutoGenerateColumns="true" Width="120%"
                                                BackColor="White" UseAccessibleHeader="true" CssClass="grid_data" HeaderStyle-CssClass="header"
                                                 AllowPaging="True" PageSize="10"  OnPageIndexChanging="gvResRetDetails_PageIndexChanging" >
                                          
                                                <EmptyDataTemplate>
                                                    <label style="width: 500px; color: Red; text-align: center; font-size: medium; padding-left: 400px;
                                                        font: message-box;">
                                                        No Record Available
                                                    </label>
                                                </EmptyDataTemplate>
                                                <%-- <Columns>
                                                <asp:BoundField HeaderText="Department" ItemStyle-Width="10%" DataField="Department" />
                                                <asp:BoundField HeaderText="File BarCode" ItemStyle-Width="10%" DataField="FileBarcode" />
                                                <asp:BoundField HeaderText="Box BarCode" ItemStyle-Width="10%" DataField="Box Barcode" />
                                                <asp:BoundField HeaderText="File Description1" ItemStyle-Width="10%" DataField="Description 1" />
                                                <asp:BoundField HeaderText="File Description2" ItemStyle-Width="10%" DataField="Description 2" />
                                                <asp:BoundField HeaderText="Year" ItemStyle-Width="10%" DataField="Year" />
                                                <asp:BoundField HeaderText="From No" ItemStyle-Width="10%" DataField="From No" />
                                                <asp:BoundField HeaderText="To No" ItemStyle-Width="10%" DataField="To No" />
                                                <asp:BoundField HeaderText="From Date" ItemStyle-Width="10%" DataField="From Date" />
                                                <asp:BoundField HeaderText="To Date" ItemStyle-Width="10%" DataField="To Date" />
                                                <asp:BoundField HeaderText="Destruction Due Date" ItemStyle-Width="10%" DataField="Destruction Due Date" />                                                
                                            </Columns>--%>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </center>
                </div>
            </div>
            </div>
            <div id="blocker" style="display: none">
                <div>
                    Loading...</div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnExportDetails" />
            <asp:PostBackTrigger ControlID="btnExportToExcel" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
