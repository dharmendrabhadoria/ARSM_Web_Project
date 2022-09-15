<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true"
    CodeFile="Rack.aspx.cs" Inherits="Master_Rack" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </ajax:ToolkitScriptManager>
    <script src="../Scripts/RackMaster.js" type="text/javascript"></script>
    <div class="clear">
    </div>
    <div class="middle">
        <div class="frmbxhead">
            Rack
        </div>
        <div class="frmbox">
            <asp:UpdatePanel ID="updRateCard" runat="server">
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
                                WareHouse
                            </td>
                            <td colspan="5">
                                <asp:DropDownList ID="ddlWareHouse" runat="server" Width="200"  AutoPostBack="true" 
                                    onselectedindexchanged="ddlWareHouse_SelectedIndexChanged">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlWareHouse"
                                    ErrorMessage="Please Select WareHouse." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 14%">
                                Row Id
                            </td>
                            <td colspan="5">
                                    <asp:TextBox ID="txtRowId" runat="server" Style="width: 200px;" MaxLength="2" Enabled="false"  ></asp:TextBox>
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="txtRowId"
                                    ErrorMessage="Please Enter Row Id." ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                                
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 14%">
                                Row Name
                            </td>
                            <td>
                                <asp:TextBox ID="txtrowName" runat="server" Style="width: 200px;" MaxLength="50"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="ReqfGroupName" runat="server" ControlToValidate="txtrowName"
                                    ErrorMessage="Please Enter Row Name." ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                                 <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Custom" 
                                 ValidChars=" "  TargetControlID="txtrowName"></ajax:FilteredTextBoxExtender>
                            </td>
                              <td >
                                No. of Racks 
                            </td>
                            <td colspan="3"  >
                                <asp:TextBox ID="txtNoofRacks" runat="server" Style="width: 73px;" onkeypress="return ValdEvenZeroAtBegining(event)" MaxLength="2" onchange="return GetBoxEndNo(this);" ></asp:TextBox>
                                <br />
                                  <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender6" runat="server" FilterType="Numbers"
                                     TargetControlID="txtNoofRacks"></ajax:FilteredTextBoxExtender>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtNoofRacks"
                                    ErrorMessage="Please Enter No. of Racks." ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                  
                        <tr>
                            <td style="width: 14%">
                                No. of Shelfs per Rack   
                            </td>
                            <td>
                                <asp:TextBox ID="txtnoshelf" runat="server" Width="73px" MaxLength="2" onchange="return GetBoxEndNo(this);"
                                    onkeypress="return ValdEvenZeroAtBegining(event);"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtnoshelf"
                                    ErrorMessage="Please Enter No. Of Shelf." ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                            </td>
                            <td style="width: 14%">
                                No. of&nbsp; Boxes per shelf
                            </td>
                            <td colspan="3">
                                <asp:TextBox ID="txttotalboxpershelf" runat="server" MaxLength="3" onkeypress="return ValdEvenZeroAtBegining(event);"
                                    onchange="return GetBoxEndNo(this);" Width="73px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txttotalboxpershelf"
                                    ErrorMessage="Please Enter No. Of Box Per Shelf." ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender5" runat="server" FilterType="Numbers,Custom"
                                    ValidChars="." TargetControlID="txttotalboxpershelf">
                                </ajax:FilteredTextBoxExtender>
                            </td>
                        </tr>
                         <tr>
                            <td style="width: 14%">
                                Box Start&nbsp; No.
                            </td>
                            <td>
                                <asp:TextBox ID="txtboxStartNo"   Enabled="false"   runat="server" Width="73px" onchange="return GetBoxEndNo();"
                                    MaxLength="6" onkeypress="return ValdEvenZeroAtBegining(event);"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtboxStartNo"
                                    ErrorMessage="Please Enter Box Start No." ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                            </td>
                            <td style="width: 14%">
                                Box End No.
                            </td>
                            <td >
                                <asp:TextBox ID="txtBoxEndNo" Enabled="false"  MaxLength="8" runat="server" Width="73px" CausesValidation="false"></asp:TextBox>
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtBoxEndNo"
                                    ErrorMessage="Please Enter Box End No." ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                            </td>
                            <td style="width: 14%">
                                Total boxes in Row
                            </td>
                            <td >
                                <asp:TextBox ID="txtTotalboxes" ReadOnly="true" MaxLength="8" runat="server" Width="73px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 14%">
                                Remark
                            </td>
                            <td colspan="5">
                                <asp:TextBox ID="txtRemark" runat="server" onkeypress=" return textboxMultilineMaxNumber(this.id,200)"
                                    onkeyup=" return textboxMultilineMaxNumber(this.id,200)" Style="width: 200px;"
                                    TextMode="MultiLine"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 14%">
                                Height
                            </td>
                            <td>
                                <asp:TextBox ID="txtHeight" runat="server" onkeyup="onlyonedot(this.id,event,false)" MaxLength="5" Width="73px"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" Display="Dynamic"
                                    ControlToValidate="txtHeight" ErrorMessage="Please Enter Height." ForeColor="Red"
                                    ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="regexpArtPriceINR" runat="server" ControlToValidate="txtHeight"
                                    Display="Dynamic"  ValidationGroup="SaveGroup" ErrorMessage="Height should be decimal valid  (3,2)" ValidationExpression="^-?[0-9]{1,3}(\.[0-9]{1,2})?$|^-?(100)(\.[0]{1,2})?$"
                                    ForeColor="Red"></asp:RegularExpressionValidator>
                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" FilterType="Numbers,Custom"
                                    ValidChars="." TargetControlID="txtHeight">
                                </ajax:FilteredTextBoxExtender>
                            </td>
                            <td style="width: 14%">
                                Width
                            </td>
                            <td>
                                <asp:TextBox ID="txtwidth" runat="server" onkeyup="onlyonedot(this.id,event,false)" MaxLength="5" Width="73px"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" Display="Dynamic"
                                    ControlToValidate="txtwidth" ErrorMessage="Please Enter Width." ForeColor="Red"
                                    ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtwidth"
                                    Display="Dynamic"  ValidationGroup="SaveGroup" ErrorMessage="Width should be decimal valid  (3,2) " ValidationExpression="^-?[0-9]{1,3}(\.[0-9]{1,2})?$|^-?(100)(\.[0]{1,2})?$"
                                    ForeColor="Red"></asp:RegularExpressionValidator>
                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" FilterType="Numbers, Custom"
                                    ValidChars="." TargetControlID="txtwidth">
                                </ajax:FilteredTextBoxExtender>
                            </td>
                            <td style="width: 14%">
                                Depth
                            </td>
                            <td >
                                <asp:TextBox ID="txtDepth" runat="server" onkeyup="onlyonedot(this.id,event,false)" MaxLength="5" Width="73px"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" Display="Dynamic"
                                    ControlToValidate="txtDepth" ErrorMessage="Please Enter Depth." ForeColor="Red"
                                    ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtDepth"
                                    Display="Dynamic"  ValidationGroup="SaveGroup" ErrorMessage="Depth should be decimal valid  (5,2) " ValidationExpression="^-?[0-9]{1,3}(\.[0-9]{1,2})?$|^-?(100)(\.[0]{1,2})?$"
                                    ForeColor="Red"></asp:RegularExpressionValidator>
                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" runat="server" FilterType="Numbers, Custom"
                                    ValidChars="." TargetControlID="txtDepth">
                                </ajax:FilteredTextBoxExtender>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6">
                                <asp:Button ID="btnSave" runat="server" Text="Save" ValidationGroup="SaveGroup" OnClientClick="return  Validatefields();"
                                    OnClick="btnSave_Click" />
                                <asp:Button ID="btnCancel" runat="server" Text="Clear" OnClientClick="return clearfields();"  OnClick="btnCancel_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6">
                            </td>
                        </tr>
                        <tr>
                            <td align="left" colspan="6">
                                <asp:GridView ID="gvRackMst" runat="server" AutoGenerateColumns="False" Width="100%"
                                    CssClass="grid_data" GridLines="None" AllowPaging="true" PageSize="20" OnPageIndexChanging="gvRackMst_PageIndexChanging"
                                    OnRowCommand="gvRackMst_RowCommand">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Sr No." ItemStyle-Width="5%">
                                            <ItemTemplate>
                                                <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex+1  %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                           <asp:TemplateField HeaderText="WareHouse " ItemStyle-Width="15%">
                                            <ItemTemplate>
                                                <asp:Label ID="lblWareHouseName" runat="server" Text='<%# Eval("WareHouseName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Row Id" ItemStyle-Width="4%">
                                            <ItemTemplate>
                                                <asp:Label ID="lblRowId" runat="server" Text='<%# Eval("RowId") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Row Name" ItemStyle-Width="15%">
                                            <ItemTemplate>
                                                <asp:Label ID="lblName" runat="server" Text='<%# Eval("RowName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="No of<br/> Racks" ItemStyle-Width="5%">
                                            <ItemTemplate>
                                                <asp:Label ID="lblNoofRacks" runat="server" Text='<%# Eval("NoofRacks") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="No. of Shelfs per Rack" ItemStyle-Width="5%">
                                            <ItemTemplate>
                                                <asp:Label ID="lblNoofShelf" runat="server" Text='<%# Eval("NoofShelf") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="No of Boxes<br/> Per Shelf" ItemStyle-Width="5%">
                                            <ItemTemplate>
                                                <asp:Label ID="lblNoofBoxesPerShelf" runat="server" Text='<%# Eval("NoofBoxesPerShelf") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Box StartNo." ItemStyle-Width="5%">
                                            <ItemTemplate>
                                                <asp:Label ID="lblBoxStartNo" runat="server" Text='<%# Eval("BoxStartNo") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Box EndNo." ItemStyle-Width="5%">
                                            <ItemTemplate>
                                                <asp:Label ID="lblBoxEndNo" runat="server" Text='<%# Eval("BoxEndNo") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                     
                                    <%--    <asp:TemplateField HeaderText="">
                                            <ItemStyle Width="5%"></ItemStyle>
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hdnRackId" runat="server" Value='<%# Eval("RackId") %>' />
                                                <asp:LinkButton ID="lnkbtnEdit" runat="server" Text="Edit" CommandArgument='<%# Eval("RackId")%>' Font-Underline="false"  
                                                    CommandName="EdtRack"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>--%>
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
</asp:Content>
