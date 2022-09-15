<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true"
    CodeFile="OtherServices.aspx.cs" Inherits="Transaction_OtherServices" %>

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

   function CheckDecimal(Value) {
         var mainstring = Value;
         mainstring = mainstring.toString().substring(0, 1);
        if (mainstring == '.') {
            $('#ContentPlaceHolder1_txtAmount').val('0'+Value);
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
                CausesValidation="false" OnClientClick="return false;"> Other Services </asp:LinkButton>
        </div>
        <div class="frmbox">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                 <td style="width: 14%" align="left">
                </td>
                <td style="width: 14%" align="left">
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
                        <asp:DropDownList ID="ddlWareHouse" runat="server" Width="200" AutoPostBack="true" TabIndex="1"
                            onselectedindexchanged="ddlWareHouse_SelectedIndexChanged">
                        </asp:DropDownList><br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" SetFocusOnError="true" runat="server" ControlToValidate="ddlWareHouse"
                            ErrorMessage="Please Select WareHouse." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td width="15%">
                        Company Group
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlCompanyGroup" TabIndex="2" runat="server" AutoPostBack="true" Width="210"
                            OnSelectedIndexChanged="ddlCompanyGroup_SelectedIndexChanged">
                        </asp:DropDownList>
                         <span id="SpnddlCompanyGroup" style="color: Red;"></span>
                        <br />
                         <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlCompanyGroup"
                            ErrorMessage="Please Select Company Group." SetFocusOnError="true" InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                      
                    </td>
                    <td>
                        Customer
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlCustomer" TabIndex="3" runat="server" AutoPostBack="true" 
                            Width="210" onselectedindexchanged="ddlCustomer_SelectedIndexChanged">
                        </asp:DropDownList><br />
                         <span id="SpnddlCustomer" style="color: Red;"></span>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" SetFocusOnError="true" runat="server" ControlToValidate="ddlCustomer"
                            ErrorMessage="Please Select Customer." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                      
              
                    </td>
                </tr>
                <tr>
                    <td width="12%">
                        Work Order
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlWorkOrder" TabIndex="4" runat="server" AutoPostBack="true" 
                            Width="210" onselectedindexchanged="ddlWorkOrder_SelectedIndexChanged">
                        </asp:DropDownList><br />
                         <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlWorkOrder"
                            ErrorMessage="Please Select Work Order." SetFocusOnError="true" InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                       
           
                    </td>
                    <td>
                        Work Order Activity
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlWorkOrderActivity" TabIndex="5" runat="server" AutoPostBack="true" 
                            Width="210" onselectedindexchanged="ddlWorkOrderActivity_SelectedIndexChanged">
                        </asp:DropDownList><br />
                         <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="ddlWorkOrderActivity"
                            ErrorMessage="Please Select Activity." SetFocusOnError="true" InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
            
                    </td>
                </tr>
                <tr>
                    <td width="12%">
                        No of Services
                    </td>
                    <td>
                        <asp:TextBox ID="txtnoofservices" runat="server" Style="width: 100px;" TabIndex="6" MaxLength="5"></asp:TextBox><br />
                         <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" runat="server" TargetControlID="txtnoofservices"  FilterType="Numbers" />                                                       
                        <asp:RequiredFieldValidator ID="reqvaltxtnoofservices" ForeColor='Red' ControlToValidate="txtnoofservices" ErrorMessage="Please Enter No. of Services." SetFocusOnError="true" ValidationGroup="SaveGroup" runat="server"></asp:RequiredFieldValidator> <br />
                         <asp:CustomValidator runat="server" ID="custvaladmin" ControlToValidate="txtnoofservices"
                        ClientValidationFunction="ValidateNoOfBoxes" Display="Dynamic" ForeColor='Red' ErrorMessage="No. Of Services Must Be Less Than Or Equal To 30000."
                        ValidationGroup="SaveGroup"></asp:CustomValidator>
                    </td>
                    <td>
                        Amount(Per Unit)
                    </td>
                    <td>
                        <asp:TextBox ID="txtAmount" runat="server" MaxLength="10" onkeypress="return CheckDecimal(this.value);" TabIndex="6" Style="width: 100px;"></asp:TextBox><br /> 
                         <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" TargetControlID="txtAmount" ValidChars="."  FilterType="Numbers,Custom" />  
                         <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ForeColor='Red' ControlToValidate="txtAmount" ErrorMessage="Please Enter Amount." SetFocusOnError="true" ValidationGroup="SaveGroup" runat="server"></asp:RequiredFieldValidator> <br />
                          <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtAmount"
                                    Display="Dynamic" ForeColor='Red' ErrorMessage="Amount should be decimal valid (8,2)" ValidationExpression="^-?[0-9]{1,9}(\.[0-9]{1,2})?$|^-?(100)(\.[0]{1,2})?$"
                                    ValidationGroup="SaveGroup"></asp:RegularExpressionValidator>         
                    </td>
                </tr>  
                <tr>
                <td width="12%">
                Remark
                </td>
                <td colspan="3">
                 <asp:TextBox ID="txtRemark" runat="server" TabIndex="7" TextMode="MultiLine" Width="190px" Height="40"></asp:TextBox>                  
                </td>
                </tr>             
                <tr>
                    <td colspan="4" class="bordnone">
                        <asp:Button ID="btnSave" runat="server" TabIndex="8" Text="Save" ValidationGroup="SaveGroup" 
                            onclick="btnSave_Click" />
                        <asp:Button ID="btnCancel" TabIndex="9" runat="server" Text="Clear" 
                            onclick="btnCancel_Click" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
