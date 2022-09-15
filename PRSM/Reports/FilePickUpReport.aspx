<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true"
    CodeFile="~/Reports/FilePickUpReport.aspx.cs" Inherits="Reports_FilePickUpReport"
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
            position: absolute;
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
    <script src="../Scripts/FilePickupReport.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        function ValidateFile() {
            var selectedValues = 0;
            var ErrorMsg = " Following fields are mandatory! \n\t ";
            var ValResult = true;

            var CompanyGroup = $('#ContentPlaceHolder1_ddlCgpickDetails').val();
            var CustomerId = $('#ContentPlaceHolder1_ddlCstpickDetails').val();

            if (CompanyGroup == '0') {
                ErrorMsg += "Please select company group\n ";
                ValResult = false;
            }


            if (CustomerId == '0') {
                ErrorMsg += "Please select customer";
                ValResult = false;
            }

            if (ValResult == false) {
                alert(ErrorMsg);
                return false;
            }
            else {
                return validateDateFileDetails();
            }
            return true;
        }

        function validateDateFileDetails() {
            var ErrorMsg = "\t Following fields are mandatory! \n \t\t"
            var ValResult = true;
            var FromDate = $("#ContentPlaceHolder1_txtFromDatepickDetials");
            var Enddate = $("#ContentPlaceHolder1_txtToDatepickDetials");
            if (Enddate.val() != '' && FromDate.val() != '') {
                var str1 = FromDate.val();
                var str2 = Enddate.val();
                var dt1 = parseInt(str1.substring(0, 2), 10);
                var mon1 = parseInt(str1.substring(3, 5), 10);
                var yr1 = parseInt(str1.substring(6, 10), 10);
                var dt2 = parseInt(str2.substring(0, 2), 10);
                var mon2 = parseInt(str2.substring(3, 5), 10);
                var yr2 = parseInt(str2.substring(6, 10), 10);
                var date1 = new Date(yr1, mon1, dt1);
                var date2 = new Date(yr2, mon2, dt2);
                if (date1 > date2) {
                    ErrorMsg += 'End Date should be greater than From Date.'
                    ValResult = false;
                }
            }
            if (ValResult == false) {
                alert(ErrorMsg);
                return false;
            }
            else
                return true;
        }

        function divShowFilesdetails() {
            $('#divShowFilesdetails').show();
            //            $("#blocker").attr('style', 'display:block');
            $("#divShowFilesdetails").attr('style', 'display:block');
        }

        function divHideFilesdetails() {
            debugger;
            $('#divShowFilesdetails').hide();
            $("#divShowFilesdetails").attr('style', 'display:none');
            //            $("#blocker").hide();
            //            $("#blocker").attr('style', 'display:none');

            //            $(function () {
            //                $('#button').click(function () {
            //                    window.close();
            //                });
            //            });
            //            document.form1.submit();
            //$("#divShowFilesdetails").dialog("close");

        }

        function divShowBoxesDetials() {
            $('#divShowBoxesDetails').show();
            //            $("#blocker").attr('style', 'display:block');
            $("#divShowBoxesDetails").attr('style', 'display:block');
        }
        function divHideBoxesDetails() {
            debugger;
            $('#divShowBoxesDetails').hide();
            $("#divShowBoxesDetails").attr('style', 'display:none');

            $("HyperLink2.deletable").click(function (e) {

                alert($(this).attr('id')); // this is ID of the deleted row use this to make service or ajax call

                var row = $(this).parent("td").parent('tr');  // this is row that should be deleted
                row.remove(); // this will remove row from DOM, but not from Db

            });

            //            $("#gvBoxesDetails tr:not(:first-child)").html("");
            //            $("#divShowBoxesDetails").html("");

            //            $("#blocker").attr('style', 'display:none');
            //            document.form1.submit();
            //            $(function () {
            //                $('#button').click(function () {
            //                    window.close();
            //                });
            //            });
            //            $("#divShowBoxesDetails").dialog("close");
        }


       


           
    </script>
    <%--    <script src="../Scripts/RestoreRetreivalReport.js" type="text/javascript"></script>--%>
    <ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </ajax:ToolkitScriptManager>
    <asp:UpdatePanel ID="updActivity" runat="server">
        <ContentTemplate>
            <script type="text/javascript">
                Sys.Application.add_load(BindDates);
            </script>
            <div class="middle">
                <div class="frmbxhead" style="z-index: 0 !important; width: 200px;">
                    <asp:LinkButton ID="lnkbtnFilePickUpSummary" runat="server" Font-Underline="false"
                        Style="color: #4f4f4f !important;" CausesValidation="false" OnClick="lnkbtnFilePickUp_Click">File Pick-Up Summary </asp:LinkButton>
                </div>
                <div class="frmbxhead" style="margin-left: 295px; width: 160px; z-index: 1; !important;">
                    <asp:LinkButton ID="lnkbtnFilePickUpdetails" runat="server" Font-Underline="false"
                        Style="color: #4f4f4f !important;" CausesValidation="false" OnClick="lnkbtnFilePickUpdetails_Click">File Pick-Up Details</asp:LinkButton>
                </div>
                <div class="frmbox">
                    <center>
                        <div id="divFilePickUp" runat="server" style="display: block;">
                            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td>
                                    </td>
                                    <td colspan="3">
                                        <%--  <asp:RadioButtonList ID="rdlstbtnReport" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rdlstbtnReport_SelectedIndexChanged"
                                            RepeatColumns="2" RepeatDirection="Horizontal" Width="239px">
                                            <asp:ListItem Selected="True" Text="Customer-Wise" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Department-Wise" Value="2"> </asp:ListItem>
                                        </asp:RadioButtonList>--%>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 10%">
                                        Company Group
                                    </td>
                                    <td style="width: 15%">
                                        <asp:DropDownList ID="ddlCompanyGroup" runat="server" Width="250" OnSelectedIndexChanged="ddlCompanyGroup_SelectedIndexChanged"
                                            AutoPostBack="true">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="width: 10%">
                                        Customer
                                    </td>
                                    <td style="width: 15%">
                                        <asp:DropDownList ID="ddlCustomer" runat="server" Width="250" AutoPostBack="true"
                                            OnSelectedIndexChanged="ddlCustomer_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 10%">
                                        From Date
                                    </td>
                                    <td style="width: 10%">
                                        <asp:TextBox ID="txtfromDate" runat="server" Width="150" CssClass="datepicker1" onkeypress="return false;">
                                        </asp:TextBox>
                                    </td>
                                    <td style="width: 10%">
                                        To Date
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txttodate" runat="server" Width="150" CssClass="datepicker1" onkeypress="return false;">
                                        </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td align="left">
                                        <asp:Button ID="btnview" runat="server" OnClick="btnview_Click" OnClientClick="javascript:return Validate();"
                                            Text="View" />
                                        <asp:Button ID="btnCancel" runat="server" CausesValidation="false" Text="Clear" OnClick="btnCancel_Click" />
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
                                                            Text="Export & Print" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </asp:Panel>
                                </tr>
                            </table>
                            <table width="100%" border="0">
                                <tr>
                                    <td style="width: 15%">
                                        &nbsp;
                                    </td>
                                    <td>
                                        <br />
                                        <br />
                                        <div id="gvClientwiseHeader" runat="server">
                                            <table cellspacing="0" cellpadding="0" rules="all" border="1" id="tblHeader" style="border-collapse: collapse;
                                                width: 800px;" class="grid_data">
                                                <tr>
                                                    <th style="width: 600px; text-align: center">
                                                        Customer Name
                                                    </th>
                                                    <th style="width: 100px; text-align: center">
                                                        No. Of Boxes
                                                    </th>
                                                    <th style="width: 100px; text-align: center">
                                                        No. Of Files
                                                    </th>
                                                </tr>
                                            </table>
                                        </div>
                                        <div id="divgvClientwise" runat="server" style="overflow: auto; padding-left: 0px;
                                            color: #4f4f4f; font-size: 12px; width: 90%; height: 200px; line-height: 20px;
                                            display: block;">
                                            <asp:GridView ID="gvClientwise" runat="server" AutoGenerateColumns="false" CssClass="grid_data"
                                                OnRowDataBound="gvClientwise_RowDataBound" ShowFooter="true" ShowHeader="false"
                                                Width="100%">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Customer Name">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblName" runat="server" Text='<%# Eval("s_CustomerName") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblTotal" runat="server" Font-Bold="true" Font-Size="14px" Text="Total"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="571" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="No. Of Boxes">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblNoOfBoxes" runat="server" Text='<%# Eval("n_NoOfBoxes") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblGrandTotalBoxes" runat="server" Font-Bold="true"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="96" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="No. Of Files">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblNoOfFiles" runat="server" Text='<%# Eval("n_NoOfFiles") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblGrandTotalFiles" runat="server" Font-Bold="true"></asp:Label>
                                                        </FooterTemplate>
                                                        <HeaderStyle Width="100" />
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
                                                            <asp:Label ID="lblName" runat="server" Text='<%# Eval("s_DeptName") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblTotal" runat="server" Font-Bold="true" Font-Size="14px" Text="Total"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="60%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="No. Of Files">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblNoOfFiles" runat="server" Text='<%# Eval("n_NoOfFiles") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblGrandTotalFiles" runat="server" Font-Bold="true"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="40%" />
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div id="divFilePickUpdetails" runat="server" style="display: none;">
                            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td>
                                    </td>
                                    <td colspan="3" align="left">
                                        <asp:RadioButtonList ID="rdbtnFilePickDetails" runat="server" AutoPostBack="True"
                                            RepeatColumns="2" RepeatDirection="Horizontal" Width="300px" OnSelectedIndexChanged="rdbtnFilePickDetails_SelectedIndexChanged">
                                            <asp:ListItem Selected="True" Text="Work Order Number Wise" Value="1"> </asp:ListItem>
                                            <asp:ListItem Text="Work Order Date Wise" Value="2"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 7%">
                                        Company Group
                                    </td>
                                    <td style="width: 10%">
                                        <asp:DropDownList ID="ddlCgpickDetails" runat="server" Width="250" AutoPostBack="true"
                                            OnSelectedIndexChanged="ddlCgpickDetails_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="width: 7%">
                                        Customer
                                    </td>
                                    <td style="width: 10%">
                                        <asp:DropDownList ID="ddlCstpickDetails" runat="server" Width="250" AutoPostBack="true">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 7%">
                                        From Date
                                    </td>
                                    <td style="width: 10%">
                                        <asp:TextBox ID="txtFromDatepickDetials" runat="server" Width="150" CssClass="datepicker1"
                                            onkeypress="return false;"></asp:TextBox>
                                    </td>
                                    <td style="width: 10%">
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
                                    </td>
                                    <td align="left">
                                        <asp:Button ID="btnViewPickDetails" runat="server" Text="View" OnClick="btnViewPickDetails_Click"
                                            OnClientClick="javascript:return ValidateFile();" />
                                        <asp:Button ID="btncancelfiledetails" runat="server" CausesValidation="false" Text="Clear"
                                            OnClick="btncancelfiledetails_Click" />
                                    </td>
                                    <asp:Panel ID="pnlReportType" runat="server" Visible="false">
                                        <td style="width: 5%">
                                            Type:
                                        </td>
                                        <td>
                                            <table border="0">
                                                <tr>
                                                    <td>
                                                        <asp:RadioButtonList ID="rdbtnlstOSDetails" runat="server" AutoPostBack="true" RepeatDirection="Horizontal">
                                                            <asp:ListItem Text="PDF" Value="0" Selected="True"></asp:ListItem>
                                                            <asp:ListItem Text="Excel" Value="1"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnExportDetails" runat="server" Text="Export & Print" OnClick="btnExportDetails_Click" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </asp:Panel>
                                </tr>
                            </table>
                            <table width="100%">
                                <tr>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div id="DivGrdFileDetailsWorkOrderNoWise" runat="server" style="overflow: auto;
                                            padding-left: 0px; color: #4f4f4f; font-size: 12px; width: 100%; height: 200px;
                                            line-height: 20px; display: block;">
                                            <asp:GridView ID="GrdFileDetailsWorkOrderNoWise" runat="server" AutoGenerateColumns="false"
                                                CssClass="grid_data" OnRowDataBound="GrdFileDetailsWorkOrderNoWise_RowDataBound"
                                                OnRowCommand="GrdFileDetailsWorkOrderNoWise_RowCommand" ShowFooter="true" ShowHeader="true"
                                                Width="100%">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Work Order No.">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblWorkOrderNo" runat="server" Text='<%# Eval("WorkOrderNo") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="20%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Work Order Date">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblWorkOrderDate" runat="server" Text='<%# Eval("WorkOrderDate","{0:dd/MM/yyyy}") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="20%" />
                                                    </asp:TemplateField>
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
                                                            <asp:Label ID="lblNoOfBoxes" runat="server" Text='<%# Eval("NoOfBoxes") %>' Visible="false"></asp:Label>
                                                            <asp:LinkButton ID="lnkbtnviewBoxes" runat="server" Text='<%# Eval("NoOfBoxes") %>'
                                                                CommandArgument='<%#Eval("WorkOrderNo")%>' CommandName="lnkviewBoxesDetails"
                                                                Font-Underline="true" Style="cursor: pointer" ToolTip="Show Boxes Details" />
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblGrandTotalBoxesDetails" runat="server" Font-Bold="true"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="20%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="No. Of Files">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblNoOfFiles" runat="server" Text='<%# Eval("NoOfFiles") %>' Visible="false"></asp:Label>
                                                            <asp:LinkButton ID="lnkbtnviewFilesDetails" runat="server" Text='<%# Eval("NoOfFiles") %>'
                                                                CommandArgument='<%#Eval("WorkOrderNo")%>' CommandName="lnkviewFileDetails" Font-Underline="true"
                                                                Style="cursor: pointer" ToolTip="Show Files Details" />
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblGrandTotalFilesDetails" runat="server" Font-Bold="true"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="20%" />
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                        <div id="DivGrdFileDetailsWorkOrderDateWise" runat="server" style="overflow: auto;
                                            padding-left: 0px; color: #4f4f4f; font-size: 12px; width: 100%; height: 200px;
                                            line-height: 20px; display: none;">
                                            <asp:GridView ID="GrdFileDetailsWorkOrderDateWise" runat="server" AutoGenerateColumns="false"
                                                OnRowDataBound="GrdFileDetailsWorkOrderDateWise_RowDataBound" CssClass="grid_data"
                                                OnRowCommand="GrdFileDetailsWorkOrderDateWise_RowCommand" ShowFooter="true" ShowHeader="true"
                                                Width="100%">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Work Order Date">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblWorkOrderDate" runat="server" Text='<%# Eval("WorkOrderDate","{0:dd-MM-yyyy}") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="20%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Work Order No.">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblWorkOrderNo" runat="server" Text='<%# Eval("WorkOrderNo") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="20%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Customer Name">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblName" runat="server" Text='<%# Eval("CustomerName") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblTotal" runat="server" Font-Bold="true" Font-Size="14px" Text="Total"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="20%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="No Of Boxes">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblNoOfBoxes" runat="server" Text='<%# Eval("NoOfBoxes") %>' Visible="false"></asp:Label>
                                                            <asp:LinkButton ID="lnkbtnviewBoxes" runat="server" Text='<%# Eval("NoOfBoxes") %>'
                                                                CommandArgument='<%#Eval("WorkOrderNo")%>' CommandName="lnkviewBoxesDetails"
                                                                Font-Underline="true" Style="cursor: pointer" ToolTip="Show Boxes Details" />
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblGrandTotalBoxesDateWise" runat="server" Font-Bold="true"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="20%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="No Of Files">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblNoOfFiles" runat="server" Text='<%# Eval("NoOfFiles") %>' Visible="false"></asp:Label>
                                                            <asp:LinkButton ID="lnkbtnviewFilesDetails" runat="server" Text='<%# Eval("NoOfFiles") %>'
                                                                CommandArgument='<%#Eval("WorkOrderNo")%>' CommandName="lnkviewFileDetails" Font-Underline="true"
                                                                Style="cursor: pointer" ToolTip="Show Files Details" />
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblGrandTotalFilesDateWise" runat="server" Font-Bold="true"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="20%" />
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div id="divShowFilesdetails" class="divActivityRate" style="width: 910px !important;">
                            <div style="float: right">
                                <asp:Button Text="Close" ForeColor="Blue" runat="server" Style="cursor: pointer"
                                    ID="btnFilePopupClose" OnClientClick=" divHideFilesdetails();" OnClick="btnFilePopupClose_Click">
                                </asp:Button>
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
                                                BackColor="White" UseAccessibleHeader="true" CssClass="grid_data" HeaderStyle-CssClass="header"
                                                AllowPaging="True" PageSize="10" OnPageIndexChanging="gvFilesDetails_PageIndexChanging">
                                                <EmptyDataTemplate>
                                                    <label style="width: 300px; color: Red; text-align: center; font-size: medium; padding-left: 400px;
                                                        font: message-box;">
                                                        No Record Available
                                                    </label>
                                                </EmptyDataTemplate>
                                                <Columns>
                                                    <asp:BoundField HeaderText="Box BarCode" ItemStyle-Width="10%" DataField="Box BarCode" />
                                                    <asp:BoundField HeaderText="File BarCode" ItemStyle-Width="10%" DataField="File BarCode" />
                                                    <asp:BoundField HeaderText="LocationCode" ItemStyle-Width="10%" DataField="LocationCode" />
                                                    <asp:BoundField HeaderText="File Description1" ItemStyle-Width="13%" DataField="File Description1" />
                                                    <asp:BoundField HeaderText="File Description2" ItemStyle-Width="13%" DataField="File Description2" />
                                                    <asp:BoundField HeaderText="Department" ItemStyle-Width="7%" DataField="Department" />
                                                    <asp:BoundField HeaderText="Year" ItemStyle-Width="7%" DataField="Year" />
                                                    <asp:BoundField HeaderText="From Date" ItemStyle-Width="8%" DataField="From Date" />
                                                    <asp:BoundField HeaderText="To Date" ItemStyle-Width="8%" DataField="To Date" />
                                                    <asp:BoundField HeaderText="File Type" ItemStyle-Width="8%" DataField="File Type" />
                                                    <asp:BoundField HeaderText="From No" ItemStyle-Width="8%" DataField="From No" />
                                                    <asp:BoundField HeaderText="To No" ItemStyle-Width="8%" DataField="To No" />
                                                    <asp:BoundField HeaderText="DestructionDueDate" ItemStyle-Width="8%" DataField="DestructionDueDate" />
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div id="divShowBoxesDetails" class="divActivityRate" style="width: 910px !important;">
                            <div style="float: right">
                                <asp:Button Text="Close" ForeColor="Blue" runat="server" Style="cursor: pointer"
                                    ID="btnBoxPopupClose" OnClientClick=" divHideBoxesDetails();" OnClick="btnBoxPopupClose_Click">
                                </asp:Button>
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
                                                BackColor="White" UseAccessibleHeader="true" CssClass="grid_data" HeaderStyle-CssClass="header"
                                                AllowPaging="True" OnPageIndexChanging="gvBoxesDetails_PageIndexChanging" PageSize="10">
                                                <EmptyDataTemplate>
                                                    <label style="width: 300px; color: Red; text-align: center; font-size: medium; padding-left: 400px;
                                                        font: message-box;">
                                                        No Record Available
                                                    </label>
                                                </EmptyDataTemplate>
                                                <Columns>
                                                    <asp:BoundField HeaderText="Box BarCode" ItemStyle-Width="10%" DataField="Box BarCode">
                                                        <ItemStyle Width="10%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField HeaderText="LocationCode" ItemStyle-Width="10%" DataField="LocationCode">
                                                        <ItemStyle Width="10%" />
                                                    </asp:BoundField>
                                                </Columns>
                                                <HeaderStyle CssClass="header" />
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
            <asp:PostBackTrigger ControlID="btnExportToExcel" />
            <asp:PostBackTrigger ControlID="btnExportDetails" />
            <asp:PostBackTrigger ControlID="GrdFileDetailsWorkOrderNoWise" />
            <asp:PostBackTrigger ControlID="btnExportToExcel" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
