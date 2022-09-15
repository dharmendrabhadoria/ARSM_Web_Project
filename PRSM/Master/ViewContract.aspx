<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/MasterPages/PRSM.master" CodeFile="ViewContract.aspx.cs" Inherits="Master_ViewContract" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </ajax:ToolkitScriptManager>
<div class="clear"></div>
    <div class="middle">
        <div class="frmbxhead" style="width:150px;"  > View Contract </div>
        <div class="frmbox">  
                    <div id="divSearchContract" runat="server">
                 <asp:UpdatePanel ID="UpdateViewContract" runat="server">
                   <ContentTemplate>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                  <tr>
                            <td>
                            </td>
                            <td align="left" colspan="3" >
                                <asp:Label ID="Label1" runat="server" Font-Bold="true" Font-Size="Medium" ForeColor="Brown"></asp:Label>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td width="15%">
                                Company Group
                            </td>
                            <td colspan="3" >
                                <asp:DropDownList ID="ddlCompanyGroup" runat="server" AutoPostBack="true" Width="210"
                                    OnSelectedIndexChanged="ddlCompanyGroup_SelectedIndexChanged">
                                </asp:DropDownList>
                                <span id="SpnddlCompanyGroup" style="color: Red;"></span>
                            </td>
                        </tr>
                        <tr>
                            <td width="12%">
                                Customer
                            </td>
                            <td colspan="3" >
                             <asp:DropDownList ID="ddlCustomer" runat="server" AutoPostBack="true" Width="210"
                                    OnSelectedIndexChanged="ddlCustomer_SelectedIndexChanged" />
                                <span id="SpnddlCustomer" style="color: Red;"></span>
                            </td>
                        </tr>
                        </table>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td colspan="6">
                                    <asp:GridView ID="gvViewContract" runat="server" AutoGenerateColumns="False" class="grid_data"
                                        Width="100%" GridLines="None" AllowPaging="True"  PageSize="20" 
                                        onpageindexchanging="gvViewContract_PageIndexChanging" >
                                        <Columns>
                                            <asp:TemplateField HeaderText="Sr No." ItemStyle-Width="7%">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="7%"></ItemStyle>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="ContractNo" HeaderText="Contract No" ReadOnly="True">
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Remark" HeaderText="Remark" ReadOnly="True">
                                            </asp:BoundField>
                                            <asp:BoundField DataField="DocumentName" HeaderText="Document Name" ReadOnly="True"></asp:BoundField>
                                          
                                                <asp:TemplateField>
                                                <ItemTemplate>
                                                <asp:ImageButton ID="imgEdit" runat="server" ImageUrl="~/images/view-bt.png"  CommandName="ViewPath"
                                                CommandArgument='<%# Eval("Filepath") %>' onclick="imgEdit_Click" />
                                                </ItemTemplate>
                                                </asp:TemplateField>
                                        </Columns>
                                        <EmptyDataTemplate>
                                            <asp:Label ID="lblErrorMessage" runat="server" Font-Bold="true" Font-Size="Medium"
                                                ForeColor="Brown" Text="No Record Found." Style="padding-left: 250px;"></asp:Label>
                                        </EmptyDataTemplate>
                                        <AlternatingRowStyle CssClass="AlternativeRowStyle" />
                                        <EmptyDataRowStyle VerticalAlign="Middle" />
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                        </ContentTemplate>
                        <Triggers>
                        <asp:PostBackTrigger ControlID="gvViewContract"  />
                     </Triggers>
                        </asp:UpdatePanel>
                    </div>

        </div>
        <div class="clear"></div><br />
     
    </div>
</asp:Content>