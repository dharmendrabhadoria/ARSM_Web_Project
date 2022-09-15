<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true"
    CodeFile="UserMaster.aspx.cs" Inherits="Users_UserMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--  <link href="../style/datestyle.css" rel="stylesheet" type="text/css" />--%>
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../Scripts/UserMaster.js" type="text/javascript"></script>
    <link href="../Scripts/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/1.10.4-jquery-ui.js" type="text/javascript"></script>
    <link href="../Scripts/1.10.4-themes-smoothness-jquery-ui.css" rel="stylesheet" type="text/css" />
    <div class="clear">
    </div>
    <ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </ajax:ToolkitScriptManager>
    <div class="middle">
        <div class="frmbxhead" style="width: 150px;">
            User Master
        </div>
        <div class="frmbox">
            <table width="100%">
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td colspan="2" align="center">
                        <asp:Label ID="lblMessage" runat="server" Font-Bold="true" Font-Size="Medium" ForeColor="Brown"></asp:Label>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td colspan="2">
                        &nbsp;
                    </td>
                </tr>
                <tr align="left">
                    <td>
                        First Name
                    </td>
                    <td colspan="2">
                        <asp:TextBox ID="txtFname" runat="server" size="27" MaxLength="20" Width="220"></asp:TextBox>
                        <br />
                        <asp:RequiredFieldValidator ID="RegFieldFname" runat="server" ForeColor="Red" ControlToValidate="txtFname"
                            SetFocusOnError="true" ErrorMessage="First name should not be blank." ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ForeColor="Red"
                            ControlToValidate="txtFname" ErrorMessage="First name should be alphabetic only."
                            ValidationGroup="SaveGroup" Display="Dynamic" runat="server" ValidationExpression="^[a-zA-Z' ]+$" />
                    </td>
                    <td>
                        Middle Name
                    </td>
                    <td colspan="2">
                        <asp:TextBox ID="txtMname" runat="server" size="27" MaxLength="20" Width="220"></asp:TextBox>
                        <br />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator5" ForeColor="Red"
                            ControlToValidate="txtMname" ValidationExpression="^[a-zA-Z' ]+$" ErrorMessage="Middle Name should be alphabetic only."
                            runat="server" ValidationGroup="SaveGroup" />
                    </td>
                </tr>
                <tr align="left">
                    <td>
                        Last Name
                    </td>
                    <td colspan="2">
                        <asp:TextBox ID="txtLname" runat="server" size="27" MaxLength="20" Width="220"></asp:TextBox>
                        <br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red"
                            ControlToValidate="txtLname" SetFocusOnError="true" ErrorMessage="Last name should not be blank."
                            ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" ForeColor="Red"
                            ControlToValidate="txtLname" ValidationExpression="^[a-zA-Z' ]+$" ErrorMessage="Last name should be alphabetic only."
                            runat="server" ValidationGroup="SaveGroup" />
                    </td>
                    <td>
                        Date Of Birth
                    </td>
                    <td colspan="2">
                        <asp:TextBox ID="txtdob" runat="server" size="27" MaxLength="60" Width="220" CssClass="datepicker" 
                         onkeypress="return false;"></asp:TextBox>
                        <asp:Label runat="server" ID="lblDate" Style="display: none;" ForeColor="Red" ></asp:Label><br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red"
                            ControlToValidate="txtdob" SetFocusOnError="true" ErrorMessage="Please enter  date of birth."
                            ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr align="left">
                    <td>
                        User Name
                    </td>
                    <td colspan="2">
                        <asp:TextBox ID="txtUserName" runat="server" MaxLength="15" Width="220"></asp:TextBox> <br/>
                        <ajax:FilteredTextBoxExtender ID="FilexttxtUserName" runat="server" TargetControlID="txtUserName"
                            FilterType=" Numbers,UppercaseLetters,LowercaseLetters,Custom" ValidChars="&,', " />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtUserName"
                            ErrorMessage="User name should not be blank." ValidationGroup="SaveGroup" ForeColor="Red" Display="Dynamic"
                            SetFocusOnError="true"></asp:RequiredFieldValidator>
                    </td>
                    <td>
                        Email
                    </td>
                    <td colspan="2">
                        <asp:TextBox ID="txtEmailId" runat="server" MaxLength="50" Width="220"></asp:TextBox>
                        <br/>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" SetFocusOnError="true"
                            ForeColor="Red" ControlToValidate="txtEmailId" ErrorMessage="Email ID should not be blank."
                            Display="Dynamic" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" SetFocusOnError="true"
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="Invalid Email ID."
                            ValidationGroup="SaveGroup" ForeColor="Red" ControlToValidate="txtEmailId" Display="Dynamic"></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr align="left" runat="server" id="TRpwdNew">
                    <td>
                       Password
                    </td>
                    <td colspan="2">
                        <asp:TextBox ID="txtPwd" runat="server" MaxLength="15" TextMode="Password"  Width="230"></asp:TextBox>
                        <br />
                        <asp:RequiredFieldValidator ID="RequiredFieldPwd" runat="server" ForeColor="Red"
                            ControlToValidate="txtPwd" SetFocusOnError="true" ErrorMessage="Password should not be blank."
                            ValidationGroup="SaveGroup" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="CustomValidatorPwd" ClientValidationFunction="ClientValidatePwd"
                            ForeColor="Red" ControlToValidate="txtPwd" runat="server" ErrorMessage="The password must be more than 6 characters."
                            Display="Dynamic" ValidationGroup="SaveGroup"></asp:CustomValidator>
                    </td>
                    <td>
                        Re-enter Password
                    </td>
                    <td colspan="2">
                        <asp:TextBox ID="txtRenPassword" runat="server" MaxLength="15" TextMode="Password" Width="230"></asp:TextBox>
                        <br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ForeColor="Red"
                            ControlToValidate="txtRenPassword" SetFocusOnError="true" ErrorMessage="Re-enter password should not be blank."
                            ValidationGroup="SaveGroup" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="cmPasswordRpt" runat="server" ValidationGroup="SaveGroup"
                            Display="Dynamic" SetFocusOnError="true" ControlToCompare="txtPwd" ForeColor="Red"
                            ControlToValidate="txtRenPassword" ValidateEmptyText="true" ErrorMessage="Your passwords do not match." />
                    </td>
                </tr>
                <tr align="left">
                    <td>
                        Department
                    </td>
                    <td colspan="2">
                        <asp:DropDownList ID="ddlDepartment" runat="server" Width="230">
                        </asp:DropDownList>
                        <br />
                        <asp:RequiredFieldValidator ID="reqddlvendorName" runat="server" SetFocusOnError="true"
                            ForeColor="Red" ControlToValidate="ddlDepartment" ErrorMessage="Please Select Department."
                            ValidationGroup="SaveGroup" Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>
                    </td>
                    <td>
                        Role
                    </td>
                    <td colspan="2">
                        <asp:DropDownList ID="ddlRole" runat="server" Width="230">
                        </asp:DropDownList>
                        <br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" SetFocusOnError="true"
                            ForeColor="Red" ControlToValidate="ddlRole" ErrorMessage="Please Select Role."
                            ValidationGroup="SaveGroup" Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr align="left">
                    <td>
                        <asp:CheckBox ID="chkisActive" runat="server" Text="Active" />
                    </td>
                    <td colspan="2">
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td colspan="2">
                        &nbsp;
                    </td>
                </tr>
                <tr align="left">
                    <td>
                    </td>
                    <td colspan="4">
                        <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" ValidationGroup="SaveGroup"
                            OnClientClick="return  Validatefields();" />
                        <asp:Button ID="btnReset" runat="server" Text="Clear" OnClick="btnReset_Click" OnClientClick="clearfields();" />
                    </td>
                </tr>
                <tr>
                    <td colspan="6" class="gridcover">
                        <asp:GridView ID="gvUserMaster" runat="server" AutoGenerateColumns="False" AllowPaging="true"
                            PageSize="20" Width="100%" border="0" CssClass="grid_data" GridLines="None" OnRowCommand="gvUserMaster_RowCommand"
                            OnPageIndexChanging="gvUserMaster_PageIndexChanging">
                            <Columns>
                                <asp:TemplateField HeaderText="Sr No." ItemStyle-Width="7%">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="User Name ">
                                    <ItemTemplate>
                                        <%# Eval("FirstName")%>
                                        &nbsp;
                                        <%# Eval("LastName")%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="EmailId">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="hdnUserId" runat="server" Value='<%# Eval("UserId") %>' />
                                        <asp:Label ID="lblemailId" runat="server" Text='<%# Eval("EmailId") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Role">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRoleName" runat="server" Text='<%# Eval("RoleName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Department">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDepartmentName" runat="server" Text='<%# Eval("DepartmentName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Active">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkIsActive" runat="server" Checked='<%#IsChecked(Eval("IsActive"))%> '
                                            Enabled="false"></asp:CheckBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkbtnEdit" runat="server" Text="Edit" CommandArgument='<%# Eval("UserId") %>'
                                            CommandName="EdtUser"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle HorizontalAlign="Left" BorderWidth="0" />
                            <AlternatingRowStyle CssClass="AlternativeRowStyle" />
                        </asp:GridView>
                        <asp:HiddenField ID="hdndob" runat="server" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
