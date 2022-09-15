<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true"
    CodeFile="ServiceCategory.aspx.cs" Inherits="Master_ServiceCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../Scripts/ServiceCategory.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">
    </script>
    <ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </ajax:ToolkitScriptManager>
    <style type="text/css">
        .ui-autocomplete
        {
            width: 310px !important;
        }
        .disblebtn
        {
            background-color: #797979;
        }
    </style>
    <div class="clear">
    </div>
    <div class="middle">
        <div class="frmbxhead" style="width: 150px;">
            Service Category
        </div>
        <div class="frmbox">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblMessage" runat="server" Font-Bold="true" Visible="true" Font-Size="Medium"
                            ForeColor="Brown"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="12%">
                        Name
                    </td>
                    <td>
                        <asp:TextBox ID="txtSCName" runat="server" Style="width: 200px;" MaxLength="50"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="ReqfldName" runat="server" ControlToValidate="txtSCName"
                            ErrorMessage="Please Enter Name." ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                        <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Custom"
                            ValidChars="-'_.& " TargetControlID="txtSCName">
                        </ajax:FilteredTextBoxExtender>
                    </td>
                </tr>
                <tr>
                    <td width="12%">
                        Remark
                    </td>
                    <td>
                        <asp:TextBox ID="txtRemark" runat="server" Style="width:200px;resize:none;" TextMode="MultiLine"
                            onkeypress=" return textboxMultilineMaxNumber(this.id,200)" onkeyup=" return textboxMultilineMaxNumber(this.id,200) "></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="bordnone">
                        <asp:Button ID="btnSave" runat="server" Text="Save" ValidationGroup="SaveGroup" OnClientClick="return  Validatefields();"
                            OnClick="btnSave_Click" />
                        <asp:Button ID="btnCancel" runat="server" Text="Clear" OnClientClick="clearfields();return false;" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="2">
                        <asp:GridView ID="gdvSearchCategory" runat="server" AutoGenerateColumns="False" Width="100%"
                            CssClass="grid_data" GridLines="None" OnRowDataBound="gdvSearchCategory_RowDataBound"
                            AllowPaging="True" OnPageIndexChanging="gdvSearchCategory_PageIndexChanging"
                            PageSize="20">
                            <Columns>
                                <asp:TemplateField HeaderText="Sr No." ItemStyle-Width="7%">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="7%"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Name" ItemStyle-Width="35%">
                                    <ItemTemplate>
                                        <asp:Label ID="lblName" runat="server" Text='<%#Eval("SCName") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="20%"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Remark">
                                    <ItemTemplate>
                                        <div style="width: 450px; overflow: auto;">
                                            <asp:Label ID="lblRemark" runat="server" Text='<%# Eval("Remark") %>'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="">
                                    <ItemStyle Width="5%"></ItemStyle>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkbtnEdit" runat="server" Text="Edit" OnClientClick="javascript:Hide();"
                                            CommandArgument='<%# Eval("IsEdit") %>'></asp:LinkButton>
                                        <asp:HiddenField ID="hdnEditid" runat="server" Value='<%# Eval("IsEdit") %>' />
                                        <asp:HiddenField ID="hdnCategoryid" runat="server" Value='<%# Eval("ServiceCategoryId") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <AlternatingRowStyle CssClass="AlternativeRowStyle" />
                        </asp:GridView>
                    </td>
                </tr>
            </table>
        </div>
        <div class="clear">
        </div>
        <br />
        <asp:HiddenField ID="hdneditid" runat="server" />
        <asp:HiddenField ID="hdnCategoryid" runat="server" />
        <div id="loading-div-background" style="display: none;">
            <div id="loading-div" class="ui-corner-all" style="background-color: White !important;
                height: 200px;">
                <img style="height: 70px; margin: 30px;" src="../images/loading.gif" alt="Loading.." />
                <h2 style="color: Gray; font-weight: normal;">
                    Please wait....</h2>
            </div>
        </div>
    </div>
</asp:Content>
