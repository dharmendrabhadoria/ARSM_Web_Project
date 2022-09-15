<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true"
    CodeFile="UploadPickupData.aspx.cs" Inherits="Transaction_UploadExcelData" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="sm" runat="server">
    </asp:ScriptManager>
    <script type="text/javascript">
        function validateFileUpload() {

            var WorkorderNumber = document.getElementById('ContentPlaceHolder1_ddlWorkorderNumber').value;
            if (WorkorderNumber == "0") {
                alert("Please select Workorder Number.");
                document.getElementById("ContentPlaceHolder1_ddlWorkorderNumber").focus();
                return false;
            }

            var uplSheet = document.getElementById('ContentPlaceHolder1_FileUpload_Pickup');
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
    </script>
    <%--        <asp:UpdatePanel ID="updUploadPickup" runat="server">
            <ContentTemplate><div class="middle">--%>
    <div class="frmbxhead" style="width: 150px; z-index: 100px;">
        <a id="lnkUploadPickupdata" style="text-decoration: none; color: #4f4f4f !important;">
            Upload Pickup Data</a>
    </div>
    <div id="divUploadPickUpData">
        <div class="frmbox">
            <div id="ContentPlaceHolder1_divInward" style="display: block;">
                <table width="100%">
                    <tr>
                        <td style="width: 14%">
                            Fresh Pickup Work Order
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlWorkorderNumber" runat="server" Width="200px" OnSelectedIndexChanged="ddlWorkorderNumber_SelectedIndexChanged">
                            </asp:DropDownList>
                            <%-- <asp:Label ID="lblWorkOrder" runat="server"> </asp:Label>--%>
                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlWorkorderNumber"
                                ErrorMessage="Please select Workorder Number." InitialValue="0" ForeColor="Red"
                                ValidationGroup="SavePickupData" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>--%>
                        </td>
                        <td>
                            <%--<asp:Button ID="btnCreateExcel" runat="server" Text="Download Standred Format Excel File"
                                OnClick="btnCreateExcel_Click" />--%>
                            <asp:HyperLink ID="hyExcelsheet" runat="server" NavigateUrl="~/ExcelSheetFormats/Pickup_Format.xlsx">Download Standard Format Excel File</asp:HyperLink>
                        </td>
                    </tr>
                    <tr>
                        <td width="15%">
                            Excel File
                        </td>
                        <td>
                            <asp:FileUpload ID="FileUpload_Pickup" runat="server" 
                                onchange=" return validateFileUpload();" TabIndex="1" />
                            <asp:Label ID="lblValidationMessage" runat="server" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" class="bordnone">
                            <asp:Button ID="btnUpload" Text="Upload" OnClick="Upload" runat="server" 
                                OnClientClick=" return validateFileUpload();" 
                                TabIndex="2" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <asp:Label ID="lblAddDepartmentMessage" runat="server" ForeColor="Red"></asp:Label><br />
                            <asp:Button ID="btnAddDepartments" runat="server" OnClick="btnAddDepartments_Click"
                                Text="Add Departments" Visible="False" TabIndex="3" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <asp:GridView Width="400px" ID="grdError" runat="server" AutoGenerateColumns="true"
                                CssClass="ExcelTable2007-1">
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <%-- </div>--%>
    <%--</ContentTemplate>
        </asp:UpdatePanel>--%>
</asp:Content>
