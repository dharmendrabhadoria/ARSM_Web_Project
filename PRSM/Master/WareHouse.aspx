<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true"
    CodeFile="WareHouse.aspx.cs" Inherits="Master_WareHouse" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </ajax:ToolkitScriptManager>
    <script src="../Scripts/WareHouse.js" type="text/javascript"></script>
    <script src="../Scripts/RackMaster.js" type="text/javascript"></script>
    <style type="text/css">
        .divRackCSS
        {
            background-color: #fff;
            z-index: 10000;
            position: absolute;
            background: #fff;
            padding: 15px;
            top: 150px;
            border: #e4e4e4 2px solid;
            box-shadow: 0 0 20px #000;
            width: 900px;
            left: 16%;
            margin-left: -50px;
            display: none;
        }
    </style>
    <div class="clear">
    </div>
    <div class="middle">
        <div class="frmbxhead">
            WareHouse
        </div>
        <div class="frmbox">
            <asp:UpdatePanel ID="updRateCard" runat="server">
                <ContentTemplate>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="12%">
                                &nbsp;
                            </td>
                            <td colspan="5" align="center">
                                <asp:Label ID="lblMessage" runat="server" Font-Bold="true" Font-Size="Medium" ForeColor="Brown"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td width="12%">
                                Name
                            </td>
                            <td colspan="5">
                                <asp:TextBox ID="txtwareHouseName" runat="server" Style="width: 200px;" MaxLength="50"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="ReqtxtwareHouseName" runat="server" ControlToValidate="txtwareHouseName"
                                    ErrorMessage="Please Provide Warehouse Name." ForeColor="Red" SetFocusOnError="true" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Custom"
                                ValidChars="-'_.& " TargetControlID="txtwareHouseName">
                                </ajax:FilteredTextBoxExtender>
                            </td>
                        </tr>
                        <tr>
                            <td width="12%">
                                Code
                            </td>
                            <td colspan="5">
                                <asp:TextBox ID="txtCode" runat="server" Style="width:200px;" MaxLength="10"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="ReqtxtCode" runat="server" ControlToValidate="txtCode"
                                    ErrorMessage="Please Provide Code." ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender5" runat="server" FilterType="numbers,UppercaseLetters,LowercaseLetters,Custom"
                                ValidChars="-" TargetControlID="txtCode">
                                </ajax:FilteredTextBoxExtender>
                            </td>
                        </tr>
                        <tr>
                            <td width="12%">
                                No. of&nbsp; Rows
                            </td>
                            <td colspan="5">
                                <asp:TextBox ID="txttotalRows" runat="server" onkeypress="return ValidateNumberOnly(event)"
                                    Width="73px" MaxLength="4"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="Reqtxttotalracks" runat="server" ControlToValidate="txttotalRows"
                                    ErrorMessage="Please Provide No. Of Rows." ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Address1
                            </td>
                            <td>
                                <asp:TextBox ID="txtwareHouseAddress1" runat="server" TextMode="MultiLine" onkeypress=" return textboxMultilineMaxNumber(this.id,50)"
                                    onkeyup=" return textboxMultilineMaxNumber(this.id,50) " Style="width: 190px;
                                    height: 25px;"></asp:TextBox><br />
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtwareHouseAddress1"
                                    ErrorMessage="Please Provide Address1." ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                            </td>
                             <td>
                                Address2
                            </td>
                            <td colspan="3">
                                <asp:TextBox ID="txtwareHouseAddress2" runat="server" TextMode="MultiLine" onkeypress=" return textboxMultilineMaxNumber(this.id,50)"
                                    onkeyup=" return textboxMultilineMaxNumber(this.id,50) " Style="width: 190px;
                                    height: 25px;"></asp:TextBox><br />
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="txtwareHouseAddress2"
                                    ErrorMessage="Please Provide Address2." ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                            </td>
                           
                            </tr>
                            <tr>
                            <td>
                                State
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlState" runat="server" Width="200" AutoPostBack="true" OnSelectedIndexChanged="ddlState_SelectedIndexChanged">
                                </asp:DropDownList><br />
                                <asp:RequiredFieldValidator ID="ReqddlState" runat="server" ErrorMessage="Please Select State."
                                    InitialValue="0" ControlToValidate="ddlState" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                            </td>
                            <td>
                                City
                            </td>
                            <td colspan="3">
                                <asp:DropDownList ID="ddlCity" runat="server" Width="200">
                                </asp:DropDownList><br />
                                <asp:RequiredFieldValidator ID="ReqddlCity" runat="server" ErrorMessage="Please Select City."
                                    InitialValue="0" ControlToValidate="ddlCity" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                  <%--      <tr>
                            <td width="12%">
                                Add rack
                            </td>
                            <td colspan="5">
                                <asp:HyperLink Text="Click Here" ForeColor="Blue" runat="server" ID="hlnkAddrack"
                                    Style="cursor: pointer" onclick="ShowdivRack();"></asp:HyperLink>
                            </td>
                        </tr>--%>
                        <tr>
                            <td colspan="6" class="bordnone">
                                <asp:Button ID="btnSave" runat="server" Text="Save" ValidationGroup="SaveGroup" OnClick="btnSave_Click" />
                                <asp:Button ID="btnCancel" runat="server" Text="Clear" OnClick="btnCancel_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6">
                            </td>
                        </tr>
                        <tr>
                            <td align="left" colspan="6">
                                <asp:GridView ID="grdWareHouse" runat="server" AutoGenerateColumns="False" class="grid_data"
                                    Width="100%" OnRowCommand="grdWareHouse_RowCommand" AllowPaging="true" PageSize="20"
                                    OnPageIndexChanging="grdWareHouse_PageIndexChanging">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Sr No.">
                                            <ItemTemplate>
                                                <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex+1  %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle Width="7%"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblName" runat="server" Text='<%# Bind("WarehouseName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Code">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCode" runat="server" Text='<%# Bind("WarehouseCode") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                      
                                        <asp:TemplateField HeaderText="City">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCityId" runat="server" Text='<%# Eval("CityId") %>' Visible="false"></asp:Label>
                                                <asp:Label ID="lblStateId" runat="server" Text='<%# Eval("StateId ") %>' Visible="false"></asp:Label>
                                                <asp:Label ID="lblCity" runat="server" Text='<%# Bind("CityName") %>'></asp:Label>
                                                <asp:Label ID="lblState" runat="server" Text='<%# Bind("StateName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText=" No. of&nbsp; Rows">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTotalRacks" runat="server" Text='<%# Bind("TotalRows") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                          <asp:TemplateField HeaderText="Address1">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAddress1" runat="server" Text='<%# Bind("Address1") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                          <asp:TemplateField HeaderText="Address2">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAddress2" runat="server" Text='<%# Bind("Address2") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="">
                                            <ItemStyle Width="5%"></ItemStyle>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkbtnEdit" runat="server" Text="Edit" CommandArgument='<%# Eval("WareHouseId") %>'
                                                    CommandName="EdtWareHouse"></asp:LinkButton>
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
    <div id="divRack" class="divRackCSS">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div style="float: right">
                    <asp:HyperLink Text="Close" ForeColor="Blue" runat="server" Style="cursor: pointer"
                        ID="hlnkhideRack" onclick="HidedivRack();clearfields();"></asp:HyperLink>
                </div>
                <div style="padding-left: 50px;text-align: center; color: #4f4f4f;
                    font-family: Arial; font-size: 13px; font-weight: bold; width: auto;">
                    Rack Master
                </div>
                <div class="frmbox" style="margin-top: 5px;">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr style="width: 14%">
                            <td >
                                &nbsp;
                            </td>
                            <td colspan="5">
                                <asp:Label ID="lblMessageRack" runat="server" Font-Bold="true" Font-Size="Medium"
                                    ForeColor="Brown"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 14%">
                                Row Name
                            </td>
                            <td >
                                <asp:TextBox ID="txtrackName" runat="server" Style="width: 200px;" MaxLength="50"></asp:TextBox>
                                <br />
                                 <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender8" runat="server" FilterType="UppercaseLetters,LowercaseLetters"
                            TargetControlID="txtrackName">
                            </ajax:FilteredTextBoxExtender>
                                <asp:RequiredFieldValidator ID="ReqfGroupName" runat="server" ControlToValidate="txtrackName"
                                    ErrorMessage="Please Enter Row Name." ForeColor="Red" ValidationGroup="SaveRow"></asp:RequiredFieldValidator>
                            </td>
                            <td >
                                No. of Racks 
                            </td>
                            <td colspan="3"  >
                                <asp:TextBox ID="txtNoofRacks" runat="server" Style="width: 200px;" MaxLength="8"></asp:TextBox>
                                <br />
                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender6" runat="server" FilterType="Numbers"
                                     TargetControlID="txtNoofRacks">
                                </ajax:FilteredTextBoxExtender>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtNoofRacks"
                                    ErrorMessage="Please Enter No. of Racks." ForeColor="Red" ValidationGroup="SaveRow"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 14%">
                                No. of Shelf
                            </td>
                            <td>
                                <asp:TextBox ID="txtnoshelf" runat="server" Width="73px" MaxLength="4" onchange="return GetBoxEndNoOnNoShelf(this.value);"
                                    onkeypress="return ValdEvenZeroAtBegining(event);"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtnoshelf"
                                    ErrorMessage="Please Enter No. Of Shelf." ForeColor="Red" ValidationGroup="SaveRow"></asp:RequiredFieldValidator>
                            </td>
                            <td style="width: 14%">
                                No. Of&nbsp; Boxes per shelf
                            </td>
                            <td colspan="3">
                                <asp:TextBox ID="txttotalboxpershelf" runat="server" MaxLength="4" onkeypress="return ValdEvenZeroAtBegining(event);"
                                    onchange="return GetBoxEndNoOnTotalBoxPerShelf(this.value);" Width="73px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txttotalboxpershelf"
                                    ErrorMessage="Please Enter No. Of Boxes Per Shelf." ForeColor="Red" ValidationGroup="SaveRow"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 14%">
                                Box Start&nbsp; No.
                            </td>
                            <td>
                                <asp:TextBox ID="txtboxStartNo" runat="server" Width="73px" onchange="return GetBoxEndNo(this.value);"
                                    MaxLength="6" onkeypress="return ValdEvenZeroAtBegining(event);" Text="1" Enabled="false"   ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtboxStartNo"
                                    ErrorMessage="Please Enter Box Start No." ForeColor="Red" ValidationGroup="SaveRow"></asp:RequiredFieldValidator>
                            </td>
                            <td style="width: 14%">
                                Box End No.
                            </td>
                            <td >
                                <asp:TextBox ID="txtBoxEndNo" ReadOnly="true" MaxLength="8" runat="server" Width="73px"></asp:TextBox>
                            </td>
                            <td style="width: 14%">
                                Total boxes
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
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtRemark"
                                    ErrorMessage="Please Enter Remark." ForeColor="Red" ValidationGroup="SaveRow"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 14%">
                                Height
                            </td>
                            <td>
                                <asp:TextBox ID="txtHeight" runat="server" MaxLength="5" Width="73px" onkeyup="onlyonedot(this.id,event,false)" ></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" Display="Dynamic"
                                    ControlToValidate="txtHeight" ErrorMessage="Please Enter Height." ForeColor="Red"
                                    ValidationGroup="SaveRow"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="regexpArtPriceINR" runat="server" ControlToValidate="txtHeight"
                                    Display="Dynamic" ValidationGroup="SaveRow" ErrorMessage="Height should be decimal valid  (5,2)" ValidationExpression="^-?[0-9]{1,3}(\.[0-9]{1,2})?$|^-?(100)(\.[0]{1,2})?$"
                                    ForeColor="Red"></asp:RegularExpressionValidator>
                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" FilterType="Numbers, Custom"
                                    ValidChars="." TargetControlID="txtHeight">
                                </ajax:FilteredTextBoxExtender>
                            </td>
                            <td style="width: 14%">
                                Width
                            </td>
                            <td>
                                <asp:TextBox ID="txtwidth" runat="server" MaxLength="5" Width="73px" onkeyup="onlyonedot(this.id,event,false)"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" Display="Dynamic"
                                    ControlToValidate="txtwidth" ErrorMessage="Please Enter Width." ForeColor="Red"
                                    ValidationGroup="SaveRow"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtwidth"
                                    Display="Dynamic" ValidationGroup="SaveRow" ErrorMessage="Width should be decimal valid  (5,2) " ValidationExpression="^-?[0-9]{1,3}(\.[0-9]{1,2})?$|^-?(100)(\.[0]{1,2})?$"
                                    ForeColor="Red"></asp:RegularExpressionValidator>
                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" FilterType="Numbers, Custom"
                                    ValidChars="." TargetControlID="txtwidth">
                                </ajax:FilteredTextBoxExtender>
                            </td>
                            <td style="width: 14%">
                                Depth
                            </td>
                            <td>
                                <asp:TextBox ID="txtDepth" runat="server" MaxLength="5" Width="73px" onkeyup="onlyonedot(this.id,event,false)"></asp:TextBox><br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" Display="Dynamic"
                                    ControlToValidate="txtDepth" ErrorMessage="Please Enter Depth." ForeColor="Red"
                                    ValidationGroup="SaveRow"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtDepth"
                                    Display="Dynamic" ValidationGroup="SaveRow" ErrorMessage="Depth should be decimal valid  (5,2) " ValidationExpression="^-?[0-9]{1,3}(\.[0-9]{1,2})?$|^-?(100)(\.[0]{1,2})?$"
                                    ForeColor="Red"></asp:RegularExpressionValidator>
                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" runat="server" FilterType="Numbers, Custom"
                                    ValidChars="." TargetControlID="txtDepth">
                                </ajax:FilteredTextBoxExtender>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6">
                                <asp:Button ID="btnSaveRack" runat="server" Text="Save" ValidationGroup="SaveRow" 
                                    OnClick="btnSaveRack_Click" />
                                <asp:Button ID="btnCancelRack" runat="server" Text="Clear"  OnClientClick="return clearfields();" OnClick="btnCancelRack_Click" />
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
                                        <asp:TemplateField HeaderText="Sr No." ItemStyle-Width="7%">
                                            <ItemTemplate>
                                                <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex+1  %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Rack Name" ItemStyle-Width="45%">
                                            <ItemTemplate>
                                                <asp:Label ID="lblName" runat="server" Text='<%# Eval("RowName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="WareHouse Name" ItemStyle-Width="45%">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPhoneNo" runat="server" Text='<%# Eval("WareHouseName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="">
                                            <ItemStyle Width="5%"></ItemStyle>
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hdnRackId" runat="server" Value='<%# Eval("RackId") %>' />
                                                <asp:LinkButton ID="lnkbtnEdit" runat="server" Text="Edit" CommandArgument='<%# Eval("RackId")%>'
                                                    CommandName="EdtRack"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <AlternatingRowStyle CssClass="AlternativeRowStyle" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div id="blocker" style="display: none">
        <div>
            Loading...</div>
    </div>
</asp:Content>
