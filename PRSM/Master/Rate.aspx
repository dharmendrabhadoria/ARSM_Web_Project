<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true"
    CodeFile="Rate.aspx.cs" Inherits="Master_Rate" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../Scripts/RateCard.js" type="text/javascript"></script>
    <script src="../Scripts/1.10.4-jquery-ui.js" type="text/javascript"></script>
    <link href="../Scripts/1.10.4-themes-smoothness-jquery-ui.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-ui.js" type="text/javascript"></script>
    <ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </ajax:ToolkitScriptManager>
    <script type="text/javascript">
        Sys.Application.add_load(bindevents);
    </script>

    <script type="text/javascript">
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
    <div class="middle">
        <div class="frmbxhead" style="width: 150px;">
            Rate Card
        </div>
        <div class="frmbox">
            <asp:UpdatePanel ID="updRateCard" runat="server">
                <ContentTemplate>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="15%">
                            </td>
                            <td align="left" colspan="3" >
                                <asp:Label ID="lblMessage" runat="server" Font-Bold="true" Font-Size="Small" ForeColor="Brown"></asp:Label>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td width="15%">
                                Company Group
                            </td>
                            <td colspan="3" >
                                <asp:DropDownList ID="ddlCompanyGroup" runat="server" AutoPostBack="true" Width="210" TabIndex="1"
                                    OnSelectedIndexChanged="ddlCompanyGroup_SelectedIndexChanged">
                                </asp:DropDownList><br />
                                <span id="SpnddlCompanyGroup" style="color: Red;"></span>
                            </td>
                        </tr>
                        <tr>
                            <td width="15%">
                                Customer
                            </td>
                            <td colspan="3" >
                                <asp:DropDownList ID="ddlCustomer" runat="server" AutoPostBack="true" Width="210" TabIndex="2"
                                    OnSelectedIndexChanged="ddlCustomer_SelectedIndexChanged">
                                </asp:DropDownList><br />
                                <span id="SpnddlCustomer" style="color: Red;"></span>
                            </td>
                        </tr>
                        <tr>
                        <td id="tdFdate" runat="server" width="15%" visible="false">
                                From Date</td>
                            <td>
                           <asp:Label ID="lblFromDate" runat="server" Font-Bold="true" ></asp:Label>

                            </td>
                            <td id="tdEnddate" runat="server" visible="false">
                                End Date</td>
                            <td>
                               <asp:Label ID="lblEndDate" runat="server" Font-Bold="true" ></asp:Label>
                        
                            </td>
                        </tr>
                        <tr>
                            <td align="left" colspan="4">
                                <div style="width: 100%; height: 295px; overflow: auto;">
                                    <asp:GridView ID="grdRateCard" runat="server" AutoGenerateColumns="False" class="grid_data"
                                        Width="100%" GridLines="None">
                                        <Columns>
                                            <asp:BoundField DataField="Sr No." HeaderText="Sr No." ReadOnly="True">
                                                <ItemStyle Width="7%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Category" HeaderText="Category" ReadOnly="True">
                                                <ItemStyle Width="15%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Activity" HeaderText="Activity" ReadOnly="True">
                                                <ItemStyle Width="35%" />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Rate">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRate" runat="server" Text='<%# Bind("Rate") %>' Visible="false"></asp:Label>
                                                    <asp:TextBox ID="txtRate" TabIndex="2" runat="server" Width="90" Text='<%# Bind("Rate") %>' Style="text-align: right;"
                                                        onclick="if(this.value=='0.00'){this.value='';}" onblur="if(this.value==''){this.value='0.00';}"
                                                        onfocus="if(this.value=='0.00'){this.value='';this.focus();}" onkeypress="return CheckDecimal(this.id);"  ValidationGroup="ValRateCard1"></asp:TextBox> 
                                                    <asp:RequiredFieldValidator ID="RegFieldFname" runat="server" ForeColor="Red" ControlToValidate="txtRate" ValidationGroup="ValRateCard1"
                                                        SetFocusOnError="true" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="regexpArtPriceINR" runat="server" ControlToValidate="txtRate" ValidationGroup="ValRateCard1"
                                                        ErrorMessage="Rate should be decimal valid  (8,2) " ValidationExpression="^-?[0-9]{1,8}(\.[0-9]{1,2})?$|^-?(100)(\.[0]{1,2})?$"
                                                        ForeColor="Red"></asp:RegularExpressionValidator>
                                                    <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" FilterType="Numbers, Custom"
                                                        ValidChars="." TargetControlID="txtRate">
                                                    </ajax:FilteredTextBoxExtender>
                                                    <asp:HiddenField ID="hdnRateCardId" runat="server" Value='<%# Eval("RateCardId") %>' />
                                                    <asp:HiddenField ID="hdnActivityId" runat="server" Value='<%# Eval("ActivityId") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <AlternatingRowStyle CssClass="AlternativeRowStyle" />
                                    </asp:GridView>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="bordnone">
                                <asp:Button ID="btnSave" runat="server" TabIndex="3" Text="Save" ValidationGroup="ValRateCard1" OnClientClick="javascript:return validRateCardOnly();"
                                    OnClick="btnSave_Click" />
                                <asp:Button ID="btnCancel" runat="server" Text="Clear" TabIndex="4" OnClick="btnCancel_Click" OnClientClick="return ClearRateC();"   />
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
