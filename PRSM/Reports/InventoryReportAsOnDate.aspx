<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPages/PRSM.master"
    CodeFile="InventoryReportAsOnDate.aspx.cs" Inherits="Reports_InventoryReportAsOnDate"
    EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../Scripts/FilePickupReport.js" type="text/javascript"></script>
    <ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </ajax:ToolkitScriptManager>
    <asp:UpdatePanel ID="upInventoryReport" runat="server">
        <ContentTemplate>
            <div class="middle">
                <div class="frmbox">
                    <center>
                        <table width="80%" cellpadding="0" cellspacing="0">
                            <tr>
                                <td align="left">
                                    <b>As On Date :</b>
                                    <asp:Label ID="lbltodaydate" runat="server" Text=""></asp:Label>
                                </td>
                                <td align="left">
                                    <b>Ware House :</b>
                                    <asp:Label ID="lblwarehouse" runat="server" Text=""></asp:Label>
                                </td>
                                <td align="left">
                                <asp:Button ID="btnExportToExcel" runat="server" Visible="false" Text="Export To Excel File" 
                                        onclick="btnExportToExcel_Click1" />
                                    <%--<asp:Button ID="btnExportToExcel" runat="server" Enabled="false" Text="Export To Excel File"
                                        OnClick="btnExportToExcel_Click" />--%>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <div id="divgvClientwise" runat="server" style="overflow: auto; padding-left: 0px;
                                        color: #4f4f4f; font-size: 12px; width: 100%; height: 200px; line-height: 20px;
                                        display: block;">
                                        <asp:GridView ID="gvInventoryReport" runat="server" AutoGenerateColumns="false" CssClass="grid_data"
                                            ShowFooter="true" ShowHeader="true" Width="100%">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Customer Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblName" runat="server" Text='<%# Eval("CustomerName") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <%-- <asp:Label ID="lblTotal" runat="server" Font-Bold="true" Font-Size="14px" Text="Total"></asp:Label>--%>
                                                    </FooterTemplate>
                                                    <ItemStyle Width="30%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="No. Of IN Boxes">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblNoOfInBoxes" runat="server" Text='<%# Eval("NoOfINBoxes") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <asp:Label ID="lblGrandTotalInBoxes" runat="server" Font-Bold="true"></asp:Label>
                                                    </FooterTemplate>
                                                    <ItemStyle Width="15%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="No. Of IN Files">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblNoOfInFiles" runat="server" Text='<%# Eval("NoOfINFiles") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <asp:Label ID="lblGrandTotalInFiles" runat="server" Font-Bold="true"></asp:Label>
                                                    </FooterTemplate>
                                                    <ItemStyle Width="15%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="No. Of OUT Boxes">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblNoOfOutBoxes" runat="server" Text='<%# Eval("NoOfOUTBoxes") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <asp:Label ID="lblGrandTotalOutBoxes" runat="server" Font-Bold="true"></asp:Label>
                                                    </FooterTemplate>
                                                    <ItemStyle Width="15%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="No. Of OUT Files">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblNoOfOutFiles" runat="server" Text='<%# Eval("NoOfOUTFiles") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <asp:Label ID="lblGrandTotalOutFiles" runat="server" Font-Bold="true"></asp:Label>
                                                    </FooterTemplate>
                                                    <ItemStyle Width="15%" />
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </center>
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnExportToExcel" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
