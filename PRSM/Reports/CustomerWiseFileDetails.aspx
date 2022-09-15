<%@ Page Title="Customer Wise File Details" Language="C#" MasterPageFile="~/MasterPages/PRSM.master"
    AutoEventWireup="true" CodeFile="CustomerWiseFileDetails.aspx.cs" Inherits="Reports_ClientWiseInvetory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript">
        function ValidateCheckBoxList(sender, args) {
            var checkBoxList = document.getElementById("<%=chklstWorkOrderNo.ClientID %>");
            var checkboxes = $('input[Id*="chklstWorkOrderNo"]:checkbox');
            var isValid = false;
            if (checkboxes != null && checkboxes.length > 0) {
                for (var i = 0; i < checkboxes.length; i++) {
                    if (checkboxes[i].checked) {
                        isValid = true;
                        break;
                    }
                }
                args.IsValid = isValid;
            }
        }



        function SelectAllCheckboxesA() {

            var Res = true
            Res = $('#ContentPlaceHolder1_chkboxSelectAll').prop('checked');
            if (Res == true) {
                $('input[Id*="chklstWorkOrderNo"]:checkbox').each(function () { this.checked = true; });
            }
            //        else {

            //            $('input[Id*="chklstWorkOrderNo"]:checkbox').each(function () { this.checked = false; });
            //        }

            $("[id*=chkboxSelectAll]").bind("click", function () {
                if ($(this).is(":checked")) {
                    $("[id*=chklstWorkOrderNo] input").attr("checked", "checked");
                } else {
                    $("[id*=chklstWorkOrderNo] input").removeAttr("checked");
                }
            });

            $("[id*=chklstWorkOrderNo] input").bind("click", function () {
                if ($("[id*=chklstWorkOrderNo] input:checked").length == $("[id*=chklstWorkOrderNo] input").length) {
                    $("[id*=chkboxSelectAll]").attr("checked", "checked");
                } else {
                    $("[id*=chkboxSelectAll]").removeAttr("checked");
                }
            });
        }
      
 
    </script>
    <script language="javascript" type="text/javascript">
   
    </script>
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
    <script src="../Scripts/FilePickupReport.js" type="text/javascript"></script>
    <ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </ajax:ToolkitScriptManager>
    <asp:UpdatePanel ID="updActivity" runat="server">
        <ContentTemplate>
            <script type="text/javascript">
                Sys.Application.add_load(BindDates);
                Sys.Application.add_load(SelectAllCheckboxesA);
            </script>
            <div class="middle">
                <div class="frmbxhead" style="width: 170px; left: 100px;">
                    Customer Wise File Details
                </div>
                <div class="frmbox">
                    <table width="100%" border="0">
                        <tr>
                            <td width="100px">
                                Customer
                            </td>
                            <td width="200px">
                                <asp:DropDownList ID="ddlCustomer" runat="server" Width="300px" OnSelectedIndexChanged="ddlCustomer_SelectedIndexChanged"
                                    AutoPostBack="true">
                                </asp:DropDownList>
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlCustomer"
                                    ErrorMessage="Please Select Customer." InitialValue="0" ForeColor="Red" ValidationGroup="viewGroup"></asp:RequiredFieldValidator>
                            </td>
                            <td width="50px">
                                Year
                            </td>
                            <td width="100px">
                                <asp:DropDownList ID="ddlYear" runat="server" Width="100" OnSelectedIndexChanged="ddlYear_SelectedIndexChanged"
                                    AutoPostBack="true">
                                </asp:DropDownList>
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlYear"
                                    ErrorMessage="Please Select Year." InitialValue="0" ForeColor="Red" ValidationGroup="viewGroup"></asp:RequiredFieldValidator>
                            </td>
                            <td width="50px">
                                Month
                            </td>
                            <td width="100px">
                                <asp:DropDownList ID="ddlMonth" runat="server" Width="100" OnSelectedIndexChanged="ddlMonth_SelectedIndexChanged"
                                    AutoPostBack="true">
                                </asp:DropDownList>
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlMonth"
                                    ErrorMessage="Please Select Month." InitialValue="0" ForeColor="Red" ValidationGroup="viewGroup"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <asp:Panel runat="server" ID="pnlWoNo" BorderWidth="0px" Visible="false">
                            <tr>
                                <br />
                                <td valign="top" width="100px">
                                    <asp:Label ID="lb1WONo" Text="Work Order No." runat="server" Visible="false"></asp:Label>
                                </td>
                                <td colspan="5">
                                    <div style="overflow: auto; padding-left: 0px; color: #4f4f4f; font-size: 12px; width: 25%;
                                        height: 150px; line-height: 20px;">
                                        <asp:CheckBox ID="chkboxSelectAll" Text="Select All" runat="server" Visible="false"
                                            onclick="javascript:SelectAllCheckboxesA();" />
                                        <br />
                                        <asp:CheckBoxList runat="server" ID="chklstWorkOrderNo" RepeatDirection="Vertical">
                                        </asp:CheckBoxList>
                                    </div>
                                    <br />
                                    <asp:CustomValidator ID="CustValWorkOrderNo" ErrorMessage="Please Select atleast one Work Order."
                                        ForeColor="Red" ClientValidationFunction="ValidateCheckBoxList" runat="server"
                                        ValidationGroup="viewGroup" Visible="false" />
                                </td>
                            </tr>
                        </asp:Panel>
                        <tr>
                            <td colspan="6">
                                <asp:Label ID="lb1Message" runat="server" Text="" ForeColor="Red" Font-Size="Small"
                                    Visible="false"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnView" runat="server" Text="View" OnClick="btnView_Click" ValidationGroup="viewGroup" />
                                <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" />
                            </td>
                            <td>
                                <asp:Panel runat="server" ID="pnlReportType" Visible="false">
                                    <td colspan="5" align="left">
                                        <table border="0">
                                            <tr>
                                                <td>
                                                    Type :
                                                </td>
                                                <td>
                                                    <asp:RadioButtonList ID="rdbtnlstCustomerWise" runat="server" AutoPostBack="true"
                                                        RepeatDirection="Horizontal">
                                                        <asp:ListItem Text="PDF" Value="0" Selected="True"></asp:ListItem>
                                                        <asp:ListItem Text="Excel" Value="1"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnExportToExcel" runat="server" Text="Export & Print" OnClick="btnExportToExcel_Click"
                                                        Visible="false" />
                                                </td>
                                            </tr>
                                        </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td align="center" colspan="2">
                                <asp:Label ID="lb1gvMessage" runat="server" Style="width: 300px; color: Red; text-align: center;
                                    font-size: x-small; padding-left: 50px; font: message-box;" Text=" " Visible="false"></asp:Label>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6">
                                <div>
                                    <asp:GridView runat="server" ID="gvClientWiseFileDetails" AutoGenerateColumns="false"
                                        CssClass="grid_data" Width="100%" ShowHeader="true" ShowFooter="true" AllowPaging="true"
                                        PageSize="10" OnPageIndexChanging="gvClientWiseFileDetails_PageIndexChanging">
                                        <Columns>
                                            <asp:BoundField HeaderText="Box BarCode" ItemStyle-Width="10%" DataField="Box BarCode" />
                                            <asp:BoundField HeaderText="File BarCode" ItemStyle-Width="10%" DataField="File BarCode" />
                                           <%-- <asp:BoundField HeaderText="Location Code" ItemStyle-Width="10%" DataField="LocationCode" />--%>
                                            <asp:BoundField HeaderText="File Description1" ItemStyle-Width="10%" DataField="File Description1" />
                                            <asp:BoundField HeaderText="File Description2" ItemStyle-Width="10%" DataField="File Description2" />
                                            <asp:BoundField HeaderText="Department" ItemStyle-Width="8%" DataField="Department" />
                                            <asp:BoundField HeaderText="Year" ItemStyle-Width="5%" DataField="Year" />
                                            <asp:BoundField HeaderText="From Date" ItemStyle-Width="10%" DataField="From Date" />
                                            <asp:BoundField HeaderText="To Date" ItemStyle-Width="5%" DataField="To Date" />
                                            <asp:BoundField HeaderText="File Type" ItemStyle-Width="5%" DataField="File Type" />
                                            <asp:BoundField HeaderText="From No" ItemStyle-Width="5%" DataField="From No" />
                                            <asp:BoundField HeaderText="To No" ItemStyle-Width="5%" DataField="To No" />
                                            <asp:BoundField HeaderText="Destruction Due Date" ItemStyle-Width="5%" DataField="DestructionDueDate" />
                                            <asp:BoundField HeaderText="Status" ItemStyle-Width="10%" DataField="Status" />
                                            <asp:BoundField HeaderText="PickUp Address" ItemStyle-Width="20%" DataField="PickUp Address" />
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnExportToExcel" />
            <asp:PostBackTrigger ControlID="chkboxSelectAll" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
