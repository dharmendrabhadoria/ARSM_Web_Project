<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true"
    CodeFile="RowMaster.aspx.cs" Inherits="Master_Rack" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </ajax:ToolkitScriptManager>
    <script src="../Scripts/RowMaster.js" type="text/javascript"></script>
    <script type="text/javascript">
        function isnoshelf(evt) {
            var iKeyCode = (evt.which) ? evt.which : evt.keyCode

            if ((iKeyCode >= 48 && iKeyCode <= 57) || (iKeyCode == 8)) {
                if (document.getElementById("txtnoshelf").value.length <= 13)
                    return true;
            }


            //        alert("phone number should be numeric");
            return false;
        }
    </script>
    <div class="clear">
    </div>
    <div class="middle">
        <div class="frmbxhead">
            Row Master
        </div>
        <div class="frmbox">
            <asp:UpdatePanel ID="updRow" runat="server">
                <ContentTemplate>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr style="width: 14%">
                            <td align="14%">
                                &nbsp;
                            </td>
                            <td colspan="5" align="center">
                                <asp:Label ID="lblMessage" runat="server" Font-Bold="true" Font-Size="Medium" ForeColor="Brown"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 14%">
                                Row Name
                            </td>
                            <td>
                                <asp:TextBox ID="txtrowName" runat="server" Style="width: 200px;" MaxLength="2"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="ReqfGroupName" runat="server" ControlToValidate="txtrowName"
                                    ErrorMessage="Please Enter Row Name." ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Custom"
                                    ValidChars=" " TargetControlID="txtrowName">
                                </ajax:FilteredTextBoxExtender>
                            </td>
                            <td style="width: 14%">
                                WareHouse
                            </td>
                            <td colspan="3">
                                <asp:DropDownList ID="ddlWareHouse" runat="server" Width="200">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="ddlWareHouse"
                                    ErrorMessage="Please Select WareHouse." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 14%">
                                No. of Shelfs
                            </td>
                            <td>
                                <asp:TextBox ID="txtnoshelf" runat="server" Width="73px" MaxLength="2" onkeypress="return isnoshelf(event);"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtnoshelf"
                                    ErrorMessage="Please Enter No. Of Shelf." ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                                <br />
                                <asp:CustomValidator runat="server" ID="custvalnoshelf" ControlToValidate="txtnoshelf"
                                    ClientValidationFunction="ValidateNoOfShelf" Display="Dynamic" ForeColor="Red"
                                    ErrorMessage="No. of shelf must be less than or equal to 7" ValidationGroup="SaveGroup"></asp:CustomValidator>
                            </td>
                            <td style="width: 20%">
                                No. &nbsp; Of Location Per Self
                            </td>
                            <td colspan="3">
                                <asp:TextBox ID="txtNofLocationPerSelf" runat="server" MaxLength="3" onkeypress="return ValdEvenZeroAtBegining(event);"
                                    onchange="return GetBoxEndNo(this);" Width="73px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtNofLocationPerSelf"
                                    ErrorMessage="Please Enter No. Of  Location Per Self." ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender5" runat="server" FilterType="Numbers,Custom"
                                    ValidChars="." TargetControlID="txtNofLocationPerSelf">
                                </ajax:FilteredTextBoxExtender>
                                <br />
                                <asp:CustomValidator runat="server" ID="CustomValidator1" ControlToValidate="txtNofLocationPerSelf"
                                    ClientValidationFunction="ValidateNoOfLocationPerself" Display="Dynamic" ForeColor="Red"
                                    ErrorMessage="No. of  location per self must be less than to 999" ValidationGroup="SaveGroup"></asp:CustomValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 14%">
                                Remark
                            </td>
                            <td colspan="5">
                                <asp:TextBox ID="txtRemark" runat="server" onkeypress=" return textboxMultilineMaxNumber(this.id,100)"
                                    onkeyup=" return textboxMultilineMaxNumber(this.id,100)" Style="width: 200px;"
                                    TextMode="MultiLine"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6">
                                <asp:Button ID="btnSave" runat="server" Text="Save" ValidationGroup="SaveGroup" OnClientClick="return  Validatefields();"
                                    OnClick="btnSave_Click" />
                                <asp:Button ID="btnCancel" runat="server" Text="Clear" OnClientClick="return clearfields();"
                                    OnClick="btnCancel_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6">
                            </td>
                        </tr>
                        <tr>
                            <td align="left" colspan="6">
                                <asp:GridView ID="gvRowMaster" runat="server" AutoGenerateColumns="False" Width="100%"
                                    CssClass="grid_data" GridLines="None" AllowPaging="true" PageSize="20" OnPageIndexChanging="gvRowMaster_PageIndexChanging"
                                    OnRowCommand="gvRowMaster_RowCommand">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Sr No." ItemStyle-Width="5%">
                                            <ItemTemplate>
                                                <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex+1  %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Row Name" ItemStyle-Width="5%">
                                            <ItemTemplate>
                                                <asp:Label ID="lblRowName" runat="server" Text='<%# Eval("RowName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="WareHouse" ItemStyle-Width="10%">
                                            <ItemTemplate>
                                                <asp:Label ID="lblWareHouseId" runat="server" Text='<%# Eval("WareHouseId") %>' Visible="false"></asp:Label>
                                                <asp:Label ID="lb1WareHouseName" runat="server" Text='<%# Eval("WarehouseName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="No. Of Shelf" ItemStyle-Width="10%">
                                            <ItemTemplate>
                                                <asp:Label ID="lblNoofShelf" runat="server" Text='<%# Eval("NoofShelf") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="No. Of Location Per Self" ItemStyle-Width="10%">
                                            <ItemTemplate>
                                                <asp:Label ID="lblNoofLocationPerSelf" runat="server" Text='<%# Eval("NoOfLocationPerSelf") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Remark" ItemStyle-Width="15%">
                                            <ItemTemplate>
                                                <div style="overflow: auto; max-height: 35px; max-width: 160px;">
                                                    <asp:Label ID="lblRemork" runat="server" Text='<%# Eval("Remark") %>'></asp:Label>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="">
                                            <ItemStyle Width="5%"></ItemStyle>
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hdnRowId" runat="server" Value='<%# Eval("RowId") %>' />
                                                <asp:LinkButton ID="lnkbtnEdit" runat="server" Text="Edit" CommandArgument='<%# Eval("RowId")%>'
                                                    Font-Underline="false" CommandName="EdtRowMastger"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <AlternatingRowStyle CssClass="AlternativeRowStyle" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div class="clear">
        </div>
        <br />
    </div>
    <asp:HiddenField ID="hdnRowId" runat="server" />
</asp:Content>
