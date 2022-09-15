<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true" CodeFile="InHouseMangement.aspx.cs" Inherits="Transaction_InHouseMangement" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<script type="text/javascript" language="javascript">
    function ValidateNoOfBoxes(source, args) {
        var number = document.getElementById('<%=txtnoofservices.ClientID%>').value;
        if (number > 30000) {
            args.IsValid = false;
        }
        else {
            args.IsValid = true;
        }
    }


    function CheckDecimal(Val) {
        var mainstring = document.getElementById(Val).value;
        mainstring = mainstring.toString().substring(0, 1);
        if (mainstring == '.') {
            document.getElementById(Val).value = '0' + document.getElementById(Val).value.toString();
        }
        return true;
    }

</script>
    <div class="clear">
    </div>
    <ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </ajax:ToolkitScriptManager>
    <asp:UpdatePanel ID="UpdOtherServices" runat="server">
    <ContentTemplate>
    <div class="middle">
        <div class="frmbxhead" style="width: 150px;">
            <asp:LinkButton ID="lnkbtnOtherServices" runat="server" Font-Underline="false" Style="color: #4f4f4f !important;"
                CausesValidation="false" OnClientClick="return false;"> In House Management</asp:LinkButton>
        </div>
        <div class="frmbox">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                 <td style="width: 14%" align="left">
                </td>
                <td style="width: 14%">
                  <asp:Label ID="lblMessage" runat="server"  Font-Bold="true" Font-Size="Medium" ForeColor="Brown"></asp:Label>
                </td>
                </tr>
                </table> 
            <table width="100%">
                <tr>
                    <td style="width: 14%">
                        WareHouse
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlWareHouse" runat="server" Width="200" AutoPostBack="true"
                            onselectedindexchanged="ddlWareHouse_SelectedIndexChanged">
                        </asp:DropDownList><br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlWareHouse" SetFocusOnError="true"
                            ErrorMessage="Please Select WareHouse." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td width="15%">
                        Company Group
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlCompanyGroup" runat="server" AutoPostBack="true" Width="210"
                            OnSelectedIndexChanged="ddlCompanyGroup_SelectedIndexChanged">
                        </asp:DropDownList>
                         <span id="SpnddlCompanyGroup" style="color: Red;"></span>
                        <br />
                         <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" SetFocusOnError="true" ControlToValidate="ddlCompanyGroup"
                            ErrorMessage="Please Select Company Group." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                      
                    </td>
                    <td>
                        Customer
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlCustomer" runat="server" AutoPostBack="true" 
                            Width="210" onselectedindexchanged="ddlCustomer_SelectedIndexChanged">
                        </asp:DropDownList><br />
                         <span id="SpnddlCustomer" style="color: Red;"></span>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" SetFocusOnError="true" ControlToValidate="ddlCustomer"
                            ErrorMessage="Please Select Customer." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                      
              
                    </td>
                </tr>
                <tr>
                    <td width="12%">
                        Work Order
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlWorkOrder" runat="server" AutoPostBack="true" 
                            Width="210" onselectedindexchanged="ddlWorkOrder_SelectedIndexChanged">
                        </asp:DropDownList><br />
                         <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" SetFocusOnError="true" ControlToValidate="ddlWorkOrder"
                            ErrorMessage="Please Select Work Order." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                       
           
                    </td>
                    <td>
                        Work Order Activity
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlWorkOrderActivity" runat="server" AutoPostBack="true" Width="210">
                        </asp:DropDownList><br />
                         <asp:RequiredFieldValidator ID="RequiredFieldValidator5" SetFocusOnError="true" runat="server" ControlToValidate="ddlWorkOrderActivity"
                            ErrorMessage="Please Select Activity." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
            
                    </td>
                </tr>
                <tr>
                    <td width="12%">
                        No of Services
                    </td>
                    <td>
                        <asp:TextBox ID="txtnoofservices" runat="server" Style="width: 100px;" MaxLength="5" Enabled="false"  Text="1"  ></asp:TextBox><br />
                         <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" runat="server" TargetControlID="txtnoofservices"  FilterType="Numbers" />                                                       
                        <asp:RequiredFieldValidator ID="reqvaltxtnoofservices" Visible="false" SetFocusOnError="true" ForeColor='Red' ControlToValidate="txtnoofservices" ErrorMessage="Please Enter No. of Services."  ValidationGroup="SaveGroup" runat="server"></asp:RequiredFieldValidator> <br />
                         <asp:CustomValidator runat="server" ID="custvaladmin" ControlToValidate="txtnoofservices"
                        ClientValidationFunction="ValidateNoOfBoxes" Display="Dynamic" ForeColor='Red' ErrorMessage="No. Of Services Must Be Less Than Or Equal To 30000."
                        ValidationGroup="SaveGroup"></asp:CustomValidator>
                    </td>
                    <td>
                        Amount
                    </td>
                    <td>
                        <asp:TextBox ID="txtAmount"  runat="server" MaxLength="10" onkeypress="javascript:CheckDecimal(this.id);"  Style="width: 100px;"></asp:TextBox><br /> 
                         <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" TargetControlID="txtAmount" ValidChars="."  FilterType="Numbers,Custom" />  
                         <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ForeColor='Red' ControlToValidate="txtAmount" ErrorMessage="Please Enter Amount." SetFocusOnError="true" ValidationGroup="SaveGroup" runat="server"></asp:RequiredFieldValidator> <br />
                         <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtAmount"
                                    Display="Dynamic" ForeColor='Red' ErrorMessage="Amount should be decimal valid (8,2)" ValidationExpression="^-?[0-9]{1,8}(\.[0-9]{1,2})?$|^-?(100)(\.[0]{1,2})?$"
                                    ValidationGroup="SaveGroup"></asp:RegularExpressionValidator>      
                    </td>
                </tr>  
                <tr>
                <td width="12%">
                Remark
                </td>
                <td colspan="3">
                 <asp:TextBox ID="txtRemark" runat="server" TextMode="MultiLine" Width="190px" Height="40"></asp:TextBox>                  
                </td>
                </tr>             
                <tr>
                    <td colspan="4" class="bordnone">
                        <asp:Button ID="btnSave" runat="server" Text="Save" ValidationGroup="SaveGroup" 
                            onclick="btnSave_Click" />
                        <asp:Button ID="btnCancel" runat="server" Text="Clear" 
                            onclick="btnCancel_Click" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

