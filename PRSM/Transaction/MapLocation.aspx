<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true" CodeFile="MapLocation.aspx.cs" Inherits="Transaction_MapLocation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <script src="../Scripts/BoxLocation.js" type="text/javascript"></script>

    <style type="text/css"  >
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
        
    </style>
    <div class="clear">
    </div>
    <div class="middle">
        <div class="frmbxhead" style="width: 150px; z-index:1 ">
            Map Location
        </div>
        <div class="frmbox">
            <asp:UpdatePanel ID="updpnlBoxlocaion" runat="server">
                <ContentTemplate>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                    <td colspan="2" align="left"    >
                    <asp:RadioButtonList runat="server" ID="rbtsearchType"  
                            RepeatDirection="Horizontal" 
                            onselectedindexchanged="rbtsearchType_SelectedIndexChanged" style="margin-left:250px;" AutoPostBack="true"     >
                    <asp:ListItem Text="View Location" Value="1"  ></asp:ListItem>
                    <asp:ListItem Text ="Map Location" Value="2" ></asp:ListItem>
                    </asp:RadioButtonList>
                    </td>
                    </tr>
                    <tr>
                            <td style="width: 14%">
                                WareHouse
                            </td>
                            <td >
                                <asp:DropDownList ID="ddlWareHouse" runat="server" Width="200"  >
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlWareHouse"
                                    ErrorMessage="Please Select WareHouse." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>

                                  
                            </td>
                        </tr>

                              <tr>
                                <td>
                                    Company Group
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlCompanyGroup" runat="server" Width="200" OnSelectedIndexChanged="ddlCompanyGroup_SelectedIndexChanged"
                                        AutoPostBack="true">
                                    </asp:DropDownList><br />
                                     
                                </td>
                                </tr>
                                <tr>
                                <td>
                                    Customer
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlCustomer" runat="server" Width="200" 
                                        AutoPostBack="True" onselectedindexchanged="ddlCustomer_SelectedIndexChanged" >
                                    </asp:DropDownList>
                                          <span>
                                    <asp:Button ID="btnSearch" runat="server" Text="Search" ValidationGroup="SaveGroup"
                                    Style="margin-left:50px; margin-top : 0px;" onclick="btnSearch_Click" OnClientClick ="return divShowBlocker();"  />
                                    </span>

                                </td>
                            </tr>
                        <tr>
                        <td colspan="2" >
                                           <div style='position: relative; width: 700px; height: 250px; overflow: auto; background-color: #FFF;
                            border: 1px solid #596380; padding: 0 10px 0 0;'>
                            <asp:GridView runat="server" ID="grdboxlocation" AutoGenerateColumns="false" Width="100%"
                                CssClass="grid_data" onrowdatabound="grdboxlocation_RowDataBound">
                                <Columns>
                                    <asp:TemplateField ItemStyle-Width="4%" HeaderStyle-Width="4%">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'
                                                Width="25px"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="4%"></ItemStyle>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Box Bar Code" ItemStyle-Width="15%" HeaderStyle-Width="15%">
                                        <ItemTemplate>
                                            <asp:Label ID="lblBoxBarCode" runat="server" Style="width: 106px;" MaxLength="16"
                                                Text='<%# Eval("BoxBarCode") %>'></asp:Label>
                                                <asp:HiddenField ID="hdnboxid" runat="server"
                                                value='<%# Eval("BoxId") %>'></asp:HiddenField>
                                        </ItemTemplate>
                                        <ItemStyle Width="15%"></ItemStyle>
                                    </asp:TemplateField>                          
                                  
                                    <asp:TemplateField HeaderText="Box Location Code " >
                                        <ItemTemplate>
                                            <asp:TextBox ID="lblBoxLocationCode" runat="server" Style="width: 106px;" MaxLength="16"
                                                Text='<%# Eval("BoxLocationCode") %>'></asp:TextBox>
                                        </ItemTemplate>                                        
                                    </asp:TemplateField>
                                </Columns>
                                <AlternatingRowStyle CssClass="AlternativeRowStyle" />
                            </asp:GridView>
                        </div>


                            <div id="blocker" style="display: none; ">
                <div style="text-align :center ;top:350px;left:450px; " >
                    <span style="color:White;"   >Loading... </span>
                    </div>
            </div>
                        </td>
                        </tr>
                        <tr>
                         <td colspan="2" >
<asp:Button ID="btnsubmit" runat="server" Text="Submit" ValidationGroup="SaveGroup"         
                                 Style="margin-top: 0px;" onclick="btnsubmit_Click"   />
                         </td>
                        </tr>
                        </table>
                    </div>
                
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>

