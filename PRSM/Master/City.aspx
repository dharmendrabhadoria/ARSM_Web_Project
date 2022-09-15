<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true"
    CodeFile="City.aspx.cs" Inherits="Master_City" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <script src="../Scripts/City.js" type="text/javascript"></script>
    <div class="clear">
    </div>
    <div class="middle">
        <div class="frmbxhead" style="width: 150px;">
            City
        </div>
        <div class="frmbox">
            <%--<asp:UpdatePanel ID="updRateCard" runat="server">
                <ContentTemplate>--%>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="15%">
                        State
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlState" runat="server" AutoPostBack="true" Width="210" OnSelectedIndexChanged="ddlState_SelectedIndexChanged">
                        </asp:DropDownList>
                        <span id="SpnddlState" style="color: Red;"></span>
                    </td>
                </tr>
                <tr>
                    <td width="12%">
                        City
                    </td>
                    <td>
                        <asp:TextBox ID="txtCity" runat="server" MaxLength="40" Width="200px"></asp:TextBox>
                        <span id="spntxtCity" style="color: Red;"></span>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="bordnone">
                        <asp:Button ID="btnSave" runat="server" Text="Save " OnClientClick="javascript:return validate();"
                            OnClick="btnSave_Click" />
                        <asp:Button ID="btnCancel" runat="server" Text="Clear" 
                         OnClick="btnCancel_Click" />
                        <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="2">
                        <asp:DataList runat="server" ID="dlistcity" RepeatColumns="3" RepeatDirection="Horizontal"
                            Width="100%" BorderWidth="0" RepeatLayout="Table" OnItemCommand="dlistcity_ItemCommand">
                            <ItemTemplate>
                                <td style="border-right: #e5e5e5 1px solid; width: 200px" align="left">
                                    <asp:Label ID="lblCityName" runat="server" Text='<%# Bind("CityName") %>'></asp:Label>
                                    <asp:Label ID="lblStateName" runat="server" Text='<%# Bind("StateName") %>' Visible="false"></asp:Label>
                                    <div style="float: right">
                                        <asp:LinkButton ID="lnkbtnEdit" runat="server" Text="Edit" CommandName="Select"></asp:LinkButton>
                                        <asp:HiddenField ID="hdnCityId" runat="server" Value='<%# Eval("CityId") %>' />
                                        <asp:HiddenField ID="hdnStateId" runat="server" Value='<%# Eval("StateId") %>' />
                                    </div>
                                </td>
                               
                            </ItemTemplate>
                            
                        </asp:DataList>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="width: 100%; text-align: center;">
                        <asp:DataList ID="dlPaging" runat="server" RepeatDirection="Horizontal" HorizontalAlign="Center"
                            CssClass="grid_data" OnItemDataBound="dlPaging_ItemDataBound" OnItemCommand="dlPaging_ItemCommand1">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkbtnPaging" runat="server" CommandArgument='<%# Eval("PageIndex") %>'
                                    CommandName="lnkbtnPaging" Text='<%# Eval("PageText") %>'></asp:LinkButton>
                            </ItemTemplate>
                        </asp:DataList>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <asp:HiddenField ID="hfPagesize" runat="server" Value="200" />
</asp:Content>
