<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true"
    CodeFile="Customer.aspx.cs" Inherits="Master_Customer" EnableEventValidation="false"
    MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../Scripts/UserMaster.js" type="text/javascript"></script>
    <link href="../Scripts/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/1.10.4-jquery-ui.js" type="text/javascript"></script>
    <link href="../Scripts/1.10.4-themes-smoothness-jquery-ui.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Contract.js" type="text/javascript"></script>
    <script src="../Scripts/Customer.js" type="text/javascript"></script>
    <script src="../Scripts/CompanyGroup.js" type="text/javascript"></script>
    <style type="text/css">
    <style type="text/css">
        .ui-autocomplete
        {
            background-color: white !important;
            width: 200px;
        }
        
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
        .divCompanyGroup
        {
            background-color: #fff;
            z-index: 9999;
            position: absolute;
            background: #fff;
            padding: 15px;
            top: 90px;
            border: #e4e4e4 2px solid;
            box-shadow: 0 0 20px #000;
            width: 1120px;
            left: 16%;
            margin-left: -120px;
            display: none;
        }
        
        .divActivityRate
        {
            background-color: #fff;
            z-index: 9999;
            position: fixed;
            background: #fff;
            padding: 20px;
            top:10px;
            border: #e4e4e4 2px solid;
            box-shadow: 0 0 20px #000;
            width: 900px;
            left: 16%;
            margin-left: -80px;
            display: none;
        }
        
       .divActivityContract
        {
            background-color:#ffffff;
            z-index: 9999;
            position: fixed;
            background:#ffffff;
            padding: 20px;
            top:12px;
            border: #e4e4e4 2px solid;
            box-shadow: 0 0 20px #000;
            width: 900px;
            left: 16%;
            margin-left: -80px;
            display: none;
        }
        .frmbox td{padding:5px}
    </style>
    <ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </ajax:ToolkitScriptManager>
    <script type="text/javascript">
        Sys.Application.add_load(BindGroupEvents);
        Sys.Application.add_load(bindevents);
    </script>
    <%--    <script type="text/javascript">
        Sys.Application.add_load(bindevents);
    </script>--%>
    <asp:UpdatePanel ID="updCustomer" runat="server">
        <ContentTemplate>
            <div class="clear">
            </div>
            <div class="middle">
                <div class="frmbxhead" style="z-index: 0 !important;">
                    <asp:LinkButton ID="lnkbtnNewcustomer" runat="server" Font-Underline="false" Style="color: #4f4f4f !important;"
                        OnClick="lnkbtnNewcustomer_Click" CausesValidation="false">New Customer</asp:LinkButton>
                </div>
                <div class="frmbxhead" style="margin-left: 188px !important; margin-bottom: -1px !important;
                    z-index: 0 !important;">
                    <asp:LinkButton ID="lnkbtnSearchCustomer" runat="server" Font-Underline="false" Style="color: #4f4f4f !important;"
                        OnClick="lnkbtnSearchCustomer_Click" CausesValidation="false">Modify Customer</asp:LinkButton>
                </div>
                <div class="frmbox">
                    <div id="divNewCustomer" runat="server">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td colspan="8" align="center">
                                    <asp:Label ID="lblMessage" runat="server" Font-Bold="true" Font-Size="Medium" ForeColor="Brown"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Name
                                </td>
                                <td>
                                    <asp:TextBox ID="txtCustomerName" MaxLength="100" runat="server" Style="width: 180px;"></asp:TextBox>
                                    <br />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="txtCustomerName"
                                        ErrorMessage="Please Enter Name." ForeColor="Red" ValidationGroup="SaveGroupC"></asp:RequiredFieldValidator>
                                </td>
                                <td>
                                    Group Name
                                </td>
                                <td colspan="5">
                                    <div class="ui-widget" style="width: 100%; padding-top: 14px">
                                        <asp:HiddenField ID="selectedValue" runat="server" />
                                        <asp:TextBox ID="txtNameofthegroup" runat="server" Width="180" onblur="autocompDrop(this.id);"> </asp:TextBox>
                                        <br />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ControlToValidate="txtNameofthegroup"
                                            ErrorMessage="Please Enter Group Name." ForeColor="Red" ValidationGroup="SaveGroupC"></asp:RequiredFieldValidator>
                                    </div>
                                    <asp:HyperLink Text="(Add New Group)" ForeColor="Blue" runat="server" ID="hprAddnew"
                                        Style="cursor: pointer" onclick="ShowdivCompanyGroup();"></asp:HyperLink>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 12%">
                                    Billing Address Line 1
                                </td>
                                <td style="width: 10%">
                                    <asp:TextBox ID="txtBillingAddress1" runat="server" TextMode="MultiLine" Style="width: 180px;
                                        height: 25px;" onkeypress="return textboxMultilineMaxNumber(this.id,50)" onkeyup="return textboxMultilineMaxNumber(this.id,50)"></asp:TextBox>
                                    <br />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator25" runat="server" ErrorMessage="Please Enter Billing Address Line 1."
                                        ControlToValidate="txtBillingAddress1" ForeColor="Red" ValidationGroup="SaveGroupC"></asp:RequiredFieldValidator>
                                </td>
                                <td style="width: 12%">
                                    Billing Address Line 2
                                </td>
                                <td style="width: 30%" colspan="5">
                                    <asp:TextBox ID="txtBillingAddress2" runat="server" TextMode="MultiLine" Style="width: 180px;
                                        height: 25px;" onkeypress="return textboxMultilineMaxNumber(this.id,50)" onkeyup="return textboxMultilineMaxNumber(this.id,50)"></asp:TextBox>
                                    <br />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator26" runat="server" ErrorMessage="Please Enter Billing Address Line 2."
                                        ControlToValidate="txtBillingAddress2" ForeColor="Red" ValidationGroup="SaveGroupC"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 6%">
                                    State
                                </td>
                                <td style="width: 24%">
                                    <asp:DropDownList ID="ddlbillingState" runat="server" Width="190" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlbillingState_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    <br />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" ErrorMessage="Please Select State."
                                        InitialValue="0" ControlToValidate="ddlbillingState" ForeColor="Red" ValidationGroup="SaveGroupC"></asp:RequiredFieldValidator>
                                </td>
                                <td style="width: 9%">
                                    City
                                </td>
                                <td style="width: 5%" colspan="5">
                                    <asp:DropDownList ID="ddlbillingCity" runat="server" Width="150">
                                    </asp:DropDownList>
                                    <br />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ErrorMessage="Please Select City."
                                        InitialValue="0" ControlToValidate="ddlbillingCity" ForeColor="Red" ValidationGroup="SaveGroupC"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 12%">
                                    Pin
                                </td>
                                <td colspan="1">
                                    <asp:TextBox ID="txtCustomerPinCode" runat="server" MaxLength="6"></asp:TextBox>
                                    <br />
                                    <asp:RequiredFieldValidator ID="rfv" runat="server" ErrorMessage="Please Enter Pincode."
                                        ControlToValidate="txtCustomerPinCode" ForeColor="Red" ValidationGroup="SaveGroupC"></asp:RequiredFieldValidator>
                                    <br />
                                    <asp:CustomValidator runat="server" ID="Customvalidator40" ForeColor="Red" ControlToValidate="txtCustomerPinCode"
                                        Display="Static" EnableClientScript="true" ClientValidationFunction="ValidateCustomerPinCode"
                                        ErrorMessage="Please enter valid pin code" OnServerValidate="cusCustom_ServerValidate"
                                        ValidationGroup="SaveGroupC"></asp:CustomValidator>
                                    <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender18" runat="server" FilterType="Numbers"
                                        TargetControlID="txtCustomerPinCode">
                                    </ajax:FilteredTextBoxExtender>
                                    <br />
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator12" ForeColor="Red"
                                        SetFocusOnError="true" runat="server" ErrorMessage="Pin code should be of 6 digits."
                                        ValidationExpression="^((\\+91-?)|0)?[0-9]{6}$" ValidationGroup="SaveGroupC"
                                        ControlToValidate="txtCustomerPinCode" Display="Dynamic"></asp:RegularExpressionValidator>
                                </td>
                                <td style="width: 9%">
                                    Billing Mode
                                </td>
                                <td style="width: 5%" colspan="5">
                                    <asp:DropDownList ID="ddlBillingMode" runat="server" Width="150" 
                                        AutoPostBack="True">
                                        <asp:ListItem Value="2">DayWise</asp:ListItem>
                                        <asp:ListItem Value="1">SlotWise</asp:ListItem>
                                    </asp:DropDownList>
                                    <br />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator29" runat="server" ErrorMessage="Please Select Billing Mode."
                                        InitialValue="0" ControlToValidate="ddlBillingMode" ForeColor="Red" ValidationGroup="SaveGroupC"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="8" width="100%" style="padding-left: 1px !important">
                                    <table class="frmbox" style="padding: 0px!important; width: 100%;" border="0">
                                        <tr>
                                            <td align="left" colspan="8">
                                                <b>Pick-Up Address </b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 4%">
                                                State
                                            </td>
                                            <td style="width: 24%">
                                                <asp:DropDownList ID="ddlpickupstate" runat="server" Width="190" AutoPostBack="true"
                                                    OnSelectedIndexChanged="ddlpickupstate_SelectedIndexChanged">
                                                </asp:DropDownList>
                                                <br />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Please Select State."
                                                    InitialValue="0" ControlToValidate="ddlpickupstate" ForeColor="Red" ValidationGroup="SavePickGroup"></asp:RequiredFieldValidator>
                                            </td>
                                            <td style="width: 7%">
                                                City
                                            </td>
                                            <td style="width: 12%">
                                                <asp:DropDownList ID="ddlpickupcity" runat="server" Width="190">
                                                </asp:DropDownList>
                                                <br />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Please Select City."
                                                    InitialValue="0" ControlToValidate="ddlpickupcity" ForeColor="Red" ValidationGroup="SavePickGroup"></asp:RequiredFieldValidator>
                                            </td>
                                            <td style="width: 15%">
                                                Address Line 1
                                            </td>
                                            <td style="width: 30%">
                                                <asp:TextBox ID="txtPickupAddress1" runat="server" TextMode="MultiLine" Style="width: 180px;
                                                    height: 25px;" onkeypress="return textboxMultilineMaxNumber(this.id,50)" onkeyup="return textboxMultilineMaxNumber(this.id,50)"></asp:TextBox>
                                                <br />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator27" runat="server" ErrorMessage="Please Enter Pick-Up Address Line 1."
                                                    ControlToValidate="txtPickupAddress1" ForeColor="Red" ValidationGroup="SavePickGroup"></asp:RequiredFieldValidator>
                                            </td>
                                            <td style="width: 12%">
                                                Address Line 2
                                            </td>
                                            <td style="width: 30%">
                                                <asp:TextBox ID="txtPickupAddress2" runat="server" TextMode="MultiLine" Style="width: 180px;
                                                    height: 25px;" onkeypress="return textboxMultilineMaxNumber(this.id,50)" onkeyup="return textboxMultilineMaxNumber(this.id,50)"></asp:TextBox>
                                                <br />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator28" runat="server" ErrorMessage="Please Enter Pick-Up Address Line 2."
                                                    ControlToValidate="txtPickupAddress2" ForeColor="Red" ValidationGroup="SavePickGroup"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Department
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlDepartment" runat="server" Width="180">
                                                </asp:DropDownList>
                                                <br />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="Please Select Department."
                                                    InitialValue="0" ControlToValidate="ddlDepartment" ForeColor="Red" ValidationGroup="SavePickGroup"></asp:RequiredFieldValidator>
                                            </td>
                                            <td style="width: 6%">
                                                Pin
                                            </td>
                                            <td style="width: 15%" colspan="5">
                                                <asp:TextBox ID="txtPickUpPincode" runat="server" MaxLength="6"></asp:TextBox>
                                                <br />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please Enter Pincode."
                                                    ControlToValidate="txtPickUpPincode" ForeColor="Red" ValidationGroup="SavePickGroup"></asp:RequiredFieldValidator>
                                                <br />
                                                <asp:CustomValidator runat="server" ID="Customvalidator140" ForeColor="Red" ControlToValidate="txtPickUpPincode"
                                                    Display="Static" EnableClientScript="true" ClientValidationFunction="ValidatePickUpPinCode"
                                                    ErrorMessage="Please enter valid pin code" OnServerValidate="cusCustom_ServerValidate"
                                                    ValidationGroup="SavePickGroup"></asp:CustomValidator>
                                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender17" runat="server" FilterType="Numbers"
                                                    TargetControlID="txtPickUpPincode">
                                                </ajax:FilteredTextBoxExtender>
                                                <br />
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator13" ForeColor="Red"
                                                    SetFocusOnError="true" runat="server" ErrorMessage="Pin code should be of 6 digits."
                                                    ValidationExpression="^((\\+91-?)|0)?[0-9]{6}$" ValidationGroup="SavePickGroup"
                                                    ControlToValidate="txtPickUpPincode" Display="Dynamic"></asp:RegularExpressionValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" colspan="8">
                                                <b>Authorised Persons </b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Name
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtAuthoName" runat="server" Style="width: 180px;" MaxLength="50"></asp:TextBox>
                                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender7" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Custom"
                                                    ValidChars="-'_& " TargetControlID="txtAuthoName">
                                                </ajax:FilteredTextBoxExtender>
                                                <br />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtAuthoName"
                                                    ErrorMessage="Please Enter Name." ForeColor="Red" ValidationGroup="SavePickGroup"></asp:RequiredFieldValidator>
                                            </td>
                                            <td>
                                                Phone
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtAuthoPhone" runat="server" Style="width: 180px; margin-top: 14px"
                                                    MaxLength="15"></asp:TextBox><br />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtAuthoPhone"
                                                    ErrorMessage="Please Enter Phone Number." ForeColor="Red" ValidationGroup="SavePickGroup"></asp:RequiredFieldValidator>
                                                <br />
                                                <asp:CustomValidator runat="server" ID="CustomvalidatortxtAuthoPhone" ForeColor="Red"
                                                    ControlToValidate="txtAuthoPhone" ClientValidationFunction="ValidatePhonePick1"
                                                    Display="Dynamic" ErrorMessage="Please enter valid phone number" OnServerValidate="cusCustom_ServerValidate"
                                                    ValidationGroup="SavePickGroup"></asp:CustomValidator>
                                                <br />
                                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender11" runat="server" FilterType="Numbers,Custom"
                                                    ValidChars=" " TargetControlID="txtAuthoPhone">
                                                </ajax:FilteredTextBoxExtender>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator8" ForeColor="Red"
                                                    SetFocusOnError="true" runat="server" ErrorMessage="Phone number should be greater than or equal to 6 digits."
                                                    ValidationExpression="^((\\+91-?)|0)?[0-9]{6,15}$" ValidationGroup="SavePickGroup"
                                                    ControlToValidate="txtAuthoPhone" Display="Dynamic"></asp:RegularExpressionValidator>
                                            </td>
                                            <td>
                                                Mobile
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtMobileNo" runat="server" Style="width: 180px;" MaxLength="10"></asp:TextBox><br />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator21" runat="server" ControlToValidate="txtMobileNo"
                                                    ErrorMessage="Please Enter Mobile Number." ForeColor="Red" ValidationGroup="SavePickGroup"></asp:RequiredFieldValidator>
                                                <br />
                                                <asp:CustomValidator runat="server" ID="Customvalidator3" ForeColor="Red" ControlToValidate="txtMobileNo"
                                                    ClientValidationFunction="ValidateMobilePick1" Display="Dynamic" ErrorMessage="Please enter valid Mobile No."
                                                    OnServerValidate="cusCustom_ServerValidate" ValidationGroup="SavePickGroup"></asp:CustomValidator>
                                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender15" runat="server" FilterType="Numbers"
                                                    TargetControlID="txtMobileNo">
                                                </ajax:FilteredTextBoxExtender>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator10" ForeColor="Red"
                                                    SetFocusOnError="true" runat="server" ErrorMessage="Mobile number should be 10 digits only."
                                                    ValidationExpression="^((\\+91-?)|0)?[0-9]{10}$" ValidationGroup="SavePickGroup"
                                                    ControlToValidate="txtMobileNo" Display="Dynamic"></asp:RegularExpressionValidator>
                                            </td>
                                            <td>
                                                Email
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtAuthoEmail" runat="server" Style="width: 180px; margin-top: 14px"
                                                    MaxLength="50"></asp:TextBox><br />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="txtAuthoEmail"
                                                    ErrorMessage="Please Enter Email." ForeColor="Red" ValidationGroup="SavePickGroup"></asp:RequiredFieldValidator>
                                                <br />
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                    ErrorMessage="Invalid Email." ValidationGroup="SavePickGroup" ControlToValidate="txtAuthoEmail"
                                                    ForeColor="Red"></asp:RegularExpressionValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Name
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtAuthoName1" runat="server" Style="width: 180px;" MaxLength="50"
                                                    onchange="ClearAll(this.id);"></asp:TextBox><br />
                                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender8" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Custom"
                                                    ValidChars="-'_& " TargetControlID="txtAuthoName1">
                                                </ajax:FilteredTextBoxExtender>
                                                <asp:CustomValidator ID="CustomValidatortxtauthoname" runat="server" ControlToValidate="txtAuthoName1"
                                                    ClientValidationFunction="Validatecdata" ValidationGroup="SavePickGroup"></asp:CustomValidator>
                                                <span id="spnContactPerson1"></span>
                                            </td>
                                            <td>
                                                Phone
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtAuthoPhone1" runat="server" Style="width: 180px;" MaxLength="15"
                                                    onchange="ClearAll(this.id);"></asp:TextBox><br />
                                                <asp:CustomValidator runat="server" ID="Customvalidator1" ForeColor="Red" ControlToValidate="txtAuthoPhone1"
                                                    ClientValidationFunction="ValidatePhonePick2" Display="Dynamic" ErrorMessage="Please enter valid phone number"
                                                    OnServerValidate="cusCustom_ServerValidate" ValidationGroup="SavePickGroup"></asp:CustomValidator>
                                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender12" runat="server" FilterType="Numbers,Custom"
                                                    ValidChars=" " TargetControlID="txtAuthoPhone1">
                                                </ajax:FilteredTextBoxExtender>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator9" ForeColor="Red"
                                                    SetFocusOnError="true" runat="server" ErrorMessage="Phone number should be greater than or equal to 6 digits."
                                                    ValidationExpression="^((\\+91-?)|0)?[0-9]{6,15}$" ValidationGroup="SavePickGroup"
                                                    ControlToValidate="txtAuthoPhone1" Display="Dynamic"></asp:RegularExpressionValidator>
                                                <asp:CustomValidator ID="CustomValidator11" runat="server" ControlToValidate="txtAuthoPhone1"
                                                    ClientValidationFunction="Validatecdata" ValidationGroup="SavePickGroup"></asp:CustomValidator>
                                                <span id="spnPhone1"></span>
                                            </td>
                                            <td>
                                                Mobile
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtMobileNo1" runat="server" Style="width: 180px; margin-top: 14px"
                                                    onchange="ClearAll(this.id);" MaxLength="10"></asp:TextBox><br />
                                                <br />
                                                <asp:CustomValidator runat="server" ID="Customvalidator4" ForeColor="Red" ControlToValidate="txtMobileNo1"
                                                    ClientValidationFunction="ValidateMobilePick2" Display="Dynamic" ErrorMessage="Please enter valid Mobile No."
                                                    OnServerValidate="cusCustom_ServerValidate" ValidationGroup="SavePickGroup"></asp:CustomValidator>
                                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender16" runat="server" FilterType="Numbers"
                                                    TargetControlID="txtMobileNo1">
                                                </ajax:FilteredTextBoxExtender>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator11" ForeColor="Red"
                                                    SetFocusOnError="true" runat="server" ErrorMessage="Mobile number should be 10 digits only."
                                                    ValidationExpression="^((\\+91-?)|0)?[0-9]{10}$" ValidationGroup="SavePickGroup"
                                                    ControlToValidate="txtMobileNo1" Display="Dynamic"></asp:RegularExpressionValidator>
                                                <asp:CustomValidator ID="CustomValidator12" runat="server" ControlToValidate="txtMobileNo1"
                                                    ClientValidationFunction="Validatecdata" ValidationGroup="SavePickGroup"></asp:CustomValidator>
                                                <span id="SpanMobile1"></span>
                                            </td>
                                            <td>
                                                Email
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtAuthoEmail1" runat="server" Style="width: 180px; margin-top: 14px"
                                                    onchange="ClearAll(this.id);" MaxLength="50"></asp:TextBox>
                                                <br />
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                    ErrorMessage="Invalid Email." ValidationGroup="SavePickGroup" ControlToValidate="txtAuthoEmail1"
                                                    ForeColor="Red"></asp:RegularExpressionValidator><br />
                                                <asp:CustomValidator ID="CustomValidator13" runat="server" ControlToValidate="txtAuthoEmail1"
                                                    ClientValidationFunction="Validatecdata" ValidationGroup="SavePickGroup"></asp:CustomValidator>
                                                <span id="SpanEmail1"></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" colspan="8">
                                                <span style="float: right">
                                                    <asp:Button ID="btnAddpickupaddress" runat="server" Text="Add +" ValidationGroup="SavePickGroup"
                                                        OnClick="btnAddpickupaddress_Click" /></span>
                                                <asp:GridView ID="gdvCustomerpickup" runat="server" AutoGenerateColumns="False" Width="100%"
                                                    CssClass="grid_data" GridLines="None" OnRowCommand="gdvCustomerpickup_RowCommand"
                                                    Style="border-right: 1px !important;">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Sr No." ItemStyle-Width="7%">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex+1  %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="7%"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Authorised Person">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblAuthorisedPerson" runat="server" Text='<%# Eval("AuthorisedPerson") %>'></asp:Label>
                                                                <br />
                                                                <asp:Label ID="lblAuthorisedPerson1" runat="server" Text='<%# Eval("AuthorisedPerson1") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Department">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblDepartment" runat="server" Text='<%# Eval("Department") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Phone No.">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblPhoneNo" runat="server" Text='<%# Eval("PhoneNumber") %>'></asp:Label>
                                                                <br />
                                                                <asp:Label ID="lblPhoneNo1" runat="server" Text='<%# Eval("PhoneNumber1") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Email">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>'></asp:Label>
                                                                <br />
                                                                <asp:Label ID="lblEmail1" runat="server" Text='<%# Eval("Email1") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Mobile No.">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblmobile" runat="server" Text='<%# Eval("MobileNo") %>'></asp:Label>
                                                                <br />
                                                                <asp:Label ID="lblmobile1" runat="server" Text='<%# Eval("MobileNo1") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Pick-Up Address" ItemStyle-Width="20%">
                                                            <ItemTemplate>
                                                                <div style="overflow: auto; max-height: 35px; max-width: 160px;">
                                                                    <asp:Label ID="lblAddress1" runat="server" Text='<%# Eval("Address1") %>'></asp:Label><br />
                                                                    <asp:Label ID="lb1PickupAddress2" runat="server" Text='<%# Eval("Address2") %>'></asp:Label>
                                                                </div>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="20%"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField>
                                                            <ItemStyle Width="5%"></ItemStyle>
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lnkbtnEdit" runat="server" Text="Edit" CommandName="editPickUpp"
                                                                    OnClientClick="return editpickup(this.id)">
                                                                </asp:LinkButton>
                                                                <asp:HiddenField runat="server" ID="hdnPickupAddressId" Value='<%# Eval("PickupAddressId") %>' />
                                                                <asp:HiddenField runat="server" ID="hdnStateId" Value='<%# Eval("StateId") %>' />
                                                                <asp:HiddenField runat="server" ID="hdnCityId" Value='<%# Eval("CityId") %>' />
                                                                <asp:HiddenField runat="server" ID="hdnPinCode" Value='<%# Eval("PinCode") %>' />
                                                                <asp:HiddenField runat="server" ID="hdnDepartment" Value='<%# Eval("DepartmentId") %>' />
                                                                <asp:HiddenField runat="server" ID="hdnAuthorisedPersonId" Value='<%# Eval("AuthorisedPersonId") %>' />
                                                                <asp:HiddenField runat="server" ID="hdnAuthorisedPersonId1" Value='<%# Eval("AuthorisedPersonId1") %>' />
                                                                <asp:HiddenField runat="server" ID="hdnSrNo" Value='<%# Container.DataItemIndex %>' />
                                                                <asp:HiddenField runat="server" ID="hdnPickupAddress1" Value='<%# Eval("Address1") %>' />
                                                                <asp:HiddenField runat="server" ID="hdnPickupAddress2" Value='<%# Eval("Address2") %>' />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <AlternatingRowStyle CssClass="AlternativeRowStyle" />
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="8" class="bordnone">
                                    <label style="width: 200px; margin-right: 60px;">
                                        &nbsp; &nbsp; &nbsp; &nbsp;
                                    </label>
                                    <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSaveCustomer_Click"
                                        ValidationGroup="SaveGroupC" OnClientClick="return SaveCustomerValid();" />
                                    <asp:Button ID="btnCancelCustomer" runat="server" Text="Clear" OnClick="btnCancelCustomer_Click" />
                                    <asp:HiddenField ID="hdnCustomerAutocompltelist" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td class="bordnone" colspan="6">
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="divSearchCustomer" runat="server">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align="left" width="15%">
                                    Group Name
                                </td>
                                <td width="21%" align="left" colspan="2">
                                    <asp:DropDownList ID="ddlGroupName" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlGroupName_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                                <td width="21%" align="left">
                                    <asp:TextBox ID="txtSeach" onblur="autocompDropOnGrpSel(this.id);" Visible="false"
                                        runat="server">
                                    </asp:TextBox>
                                </td>
                                <td colspan="2" align="left">
                                    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                                </td>
                            </tr>
                        </table>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td colspan="6">
                                    <asp:GridView ID="grdCustomer" runat="server" AutoGenerateColumns="False" class="grid_data"
                                        Width="100%" GridLines="None" AllowPaging="True" OnPageIndexChanging="grdCustomer_PageIndexChanging"
                                        OnRowCommand="grdCustomer_RowCommand" PageSize="20">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Sr No." ItemStyle-Width="5%">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="5%"></ItemStyle>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="CustomerName" HeaderText="Customer Name" ReadOnly="True">
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Company Group">
                                                <ItemTemplate>
                                                    <div style="overflow: auto; max-height: 35px; max-width: 170px;">
                                                        <asp:Label ID="lblCompanyGroupName" runat="server" Text='<%# Bind("CompanyGroupName") %>'></asp:Label>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Billing Address1">
                                                <ItemTemplate>
                                                    <div style="overflow: auto; max-height: 35px; max-width: 110px;">
                                                        <asp:Label ID="lblBillingAddress1" runat="server" Text='<%# Bind("BillingAddress1") %>'></asp:Label>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText=" Billing Address2">
                                                <ItemTemplate>
                                                    <div style="overflow: auto; max-height: 35px; max-width: 110px;">
                                                        <asp:Label ID="lblBillingAddress2" runat="server" Text='<%# Bind("BillingAddress2") %>'></asp:Label>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="CityName" HeaderText="City" ReadOnly="True"></asp:BoundField>
                                            <asp:BoundField DataField="StateName" HeaderText="State" ReadOnly="True"></asp:BoundField>
                                            <asp:TemplateField HeaderText="">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkbtnEdit" runat="server" Text="Edit " CommandArgument='<%# Eval("CustomerId") %>'
                                                        CommandName="lnkEdit" Font-Underline="false" Style="cursor: pointer" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkbtnAddNewContract" runat="server" Text="Contract" CommandArgument='<%#Eval("CustomerId")+","+Eval("CompanyGroupName")+","+Eval("CustomerName") %>'
                                                        CommandName="lnkAddContract" Font-Underline="false" Style="cursor: pointer" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkbtnAddRateCard" runat="server" Text=" Rate Card" CommandArgument='<%#Eval("CustomerId")+","+Eval("CompanyGroupName")+","+Eval("CustomerName") %>'
                                                        CommandName="lnkAddRate" Font-Underline="false" Style="cursor: pointer" />
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
                    </div>
                    <asp:HiddenField ID="hdnSearcheCustId" runat="server" />
                    <asp:HiddenField ID="hdnCustIdONContract" runat="server" />
                </div>
            </div>
            <div id="divCustomerGroup" class="divCompanyGroup">
                <div style="float: right">
                    <asp:HyperLink Text="Close" ForeColor="Blue" runat="server" Style="cursor: pointer"
                        ID="hlnkhidecompanygroup" onclick="HidedivCompanyGroup();"></asp:HyperLink>
                </div>
                <div style="padding-left: 350px; float: left; text-align: center; color: #4f4f4f;
                    font-family: Arial; font-size: 13px; font-weight: bold; width: auto;">
                    Company Group
                </div>
                <div class="frmbox">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td colspan="8" align="center">
                                <asp:Label ID="lblCompanyGroupMsg" runat="server" Font-Bold="true" Font-Size="Medium"
                                    ForeColor="Brown"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td width="6%">
                                Name
                            </td>
                            <td width="8%">
                                <asp:TextBox ID="txtGroupName" runat="server" Style="width: 200px;" MaxLength="100"></asp:TextBox><br />
                                <asp:RequiredFieldValidator ID="ReqfGroupName" runat="server" ControlToValidate="txtGroupName"
                                    ErrorMessage="Please Enter Name." ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                    ValidChars="-'_& /.\ @" TargetControlID="txtGroupName">
                                </ajax:FilteredTextBoxExtender>
                            </td>
                            <td width="5%">
                                Industry
                            </td>
                            <td colspan="5" width="10%">
                                <asp:DropDownList ID="ddlindustry" runat="server" Width="200">
                                </asp:DropDownList>
                                <br />
                                <asp:RequiredFieldValidator ID="reqserviceCategory" runat="server" ErrorMessage="Please Select Industry."
                                    InitialValue="0" ControlToValidate="ddlindustry" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                PAN
                            </td>
                            <td>
                                <asp:TextBox ID="txtPANNo" runat="server" Style="width: 100px;" onchange="javascript:upperletter(this.value);"
                                    MaxLength="10"></asp:TextBox>
                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                    TargetControlID="txtPANNo">
                                </ajax:FilteredTextBoxExtender>
                            </td>
                            <td>
                                TAN
                            </td>
                            <td>
                                <asp:TextBox ID="txtTAN" runat="server" Style="width: 100px;" MaxLength="25" onchange="javascript:upperletterTan(this.value);"></asp:TextBox>
                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender22" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                    TargetControlID="txtTAN">
                                </ajax:FilteredTextBoxExtender>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td width="6%">
                                Register Address Line 1
                            </td>
                            <td>
                                <asp:TextBox ID="txtRegAddress1" runat="server" TextMode="MultiLine" Style="width: 190px;
                                    height: 25px;" MaxLength="50" onkeypress="return textboxMultilineMaxNumber(this.id,50)"
                                    onkeyup="return textboxMultilineMaxNumber(this.id,50)"></asp:TextBox><br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="txtRegAddress1"
                                    ErrorMessage="Please Enter Register Address Line 1." EnableClientScript="true"
                                    ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                            </td>
                            <td>
                                Register Address Line 2
                            </td>
                            <td colspan="5" width="15%">
                                <asp:TextBox ID="txtRegAddress2" runat="server" TextMode="MultiLine" Style="width: 190px;
                                    height: 25px;" MaxLength="50" onkeypress="return textboxMultilineMaxNumber(this.id,50)"
                                    onkeyup="return textboxMultilineMaxNumber(this.id,50)"></asp:TextBox><br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtRegAddress2"
                                    ErrorMessage="Please Enter Register Address Line 2." EnableClientScript="true"
                                    ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                State
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlState" runat="server" Width="200" AutoPostBack="true" OnSelectedIndexChanged="ddlState_SelectedIndexChanged">
                                </asp:DropDownList>
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Please Select State."
                                    InitialValue="0" ControlToValidate="ddlState" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                            </td>
                            <td>
                                City
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlCity" runat="server" Width="200">
                                </asp:DropDownList>
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator24" runat="server" ErrorMessage="Please Select City."
                                    InitialValue="0" ControlToValidate="ddlCity" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                            </td>
                            <td>
                                Pin
                            </td>
                            <td colspan="3">
                                <asp:TextBox ID="txtpincode" runat="server" MaxLength="6"></asp:TextBox><br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator113" runat="server" ControlToValidate="txtpincode"
                                    ErrorMessage="Please Enter Pin Code." EnableClientScript="true" ForeColor="Red"
                                    ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                                <br />
                                <asp:CustomValidator runat="server" ID="Customvalidator114" ForeColor="Red" ControlToValidate="txtpincode"
                                    Display="Static" EnableClientScript="true" ClientValidationFunction="ValidateRegPinCodeOnPopup"
                                    ErrorMessage="Please enter valid pin code" OnServerValidate="cusCustom_ServerValidate"
                                    ValidationGroup="SaveGroup"></asp:CustomValidator>
                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" runat="server" TargetControlID="txtpincode"
                                    FilterType="Numbers" />
                                <br />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator14" ForeColor="Red"
                                    SetFocusOnError="true" runat="server" ErrorMessage="Pin code should be of 6 digits."
                                    ValidationExpression="^((\\+91-?)|0)?[0-9]{6}$" ValidationGroup="SaveGroup" ControlToValidate="txtpincode"
                                    Display="Dynamic"></asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Corporate Address Line 1
                            </td>
                            <td>
                                <asp:TextBox ID="txtCorpAddress1" runat="server" TextMode="MultiLine" Style="width: 190px;
                                    height: 25px;" MaxLength="50" onkeypress="return textboxMultilineMaxNumber(this.id,50)"
                                    onkeyup="return textboxMultilineMaxNumber(this.id,50)"></asp:TextBox><br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" ControlToValidate="txtCorpAddress1"
                                    ErrorMessage="Please Enter Corporate Address Line 1." EnableClientScript="true"
                                    ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                            </td>
                            <td>
                                Corporate Address Line 2
                            </td>
                            <td colspan="5">
                                <asp:TextBox ID="txtCorpAddress2" runat="server" TextMode="MultiLine" Style="width: 190px;
                                    height: 25px;" MaxLength="50" onkeypress="return textboxMultilineMaxNumber(this.id,50)"
                                    onkeyup="return textboxMultilineMaxNumber(this.id,50)"></asp:TextBox><br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" ControlToValidate="txtCorpAddress2"
                                    ErrorMessage="Please Enter Corporate Address Line 2." EnableClientScript="true"
                                    ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                State
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlcorporatestate" runat="server" Width="200" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlcorporatestate_SelectedIndexChanged">
                                </asp:DropDownList>
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator18" runat="server" ErrorMessage="Please Select State."
                                    InitialValue="0" ControlToValidate="ddlcorporatestate" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                            </td>
                            <td>
                                City
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlcorporatecity" runat="server" Width="200">
                                </asp:DropDownList>
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator20" runat="server" ErrorMessage="Please Select City."
                                    InitialValue="0" ControlToValidate="ddlcorporatecity" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>&nbsp;&nbsp;
                            </td>
                            <td>
                                Pin
                            </td>
                            <td colspan="3">
                                <asp:TextBox ID="txtcorporatepincode" runat="server" MaxLength="6"></asp:TextBox><br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator23" runat="server" ControlToValidate="txtcorporatepincode"
                                    ErrorMessage="Please Enter Pin Code." EnableClientScript="true" ForeColor="Red"
                                    ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                                <br />
                                <asp:CustomValidator runat="server" ID="Customvalidator142" ForeColor="Red" ControlToValidate="txtcorporatepincode"
                                    Display="Static" EnableClientScript="true" ClientValidationFunction="ValidateCorpPinCodeOnPopup"
                                    ErrorMessage="Please enter valid pin code" OnServerValidate="cusCustom_ServerValidate"
                                    ValidationGroup="SaveGroup"></asp:CustomValidator>
                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender10" runat="server" TargetControlID="txtcorporatepincode"
                                    FilterType="Numbers" />
                                <br />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator15" ForeColor="Red"
                                    SetFocusOnError="true" runat="server" ErrorMessage="Pin code should be of 6 digits."
                                    ValidationExpression="^((\\+91-?)|0)?[0-9]{6}$" ValidationGroup="SaveGroup" ControlToValidate="txtcorporatepincode"
                                    Display="Dynamic"></asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="8" width="100%">
                                <fieldset style="border: #e4e4e4 2px solid; -webkit-border-top-left-radius: 10px;
                                    -webkit-border-top-right-radius: 10px; -moz-border-radius-topleft: 10px; -moz-border-radius-topright: 10px;">
                                    <legend><b>Contact Person</b></legend>
                                    <table width="100%">
                                        <tr>
                                            <td>
                                                Name
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtContactPerson" runat="server" Style="width: 190px" MaxLength="50"></asp:TextBox>
                                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender5" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Custom"
                                                    ValidChars="-'_& " TargetControlID="txtContactPerson">
                                                </ajax:FilteredTextBoxExtender>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtContactPerson"
                                                    ErrorMessage="Please Enter Contact Person Name." EnableClientScript="true" ForeColor="Red"
                                                    ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                                            </td>
                                            <td>
                                                Phone
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtPhoneNumber" runat="server" ValidationGroup="SaveGroup" Style="width: 190px;
                                                    margin-top: 14px" MaxLength="15"></asp:TextBox><br />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator19" runat="server" ControlToValidate="txtPhoneNumber"
                                                    ErrorMessage="Please Enter Phone Number." EnableClientScript="true" ForeColor="Red"
                                                    ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender13" runat="server" FilterType="Numbers"
                                                    TargetControlID="txtPhoneNumber">
                                                </ajax:FilteredTextBoxExtender>
                                                <br />
                                                <asp:CustomValidator runat="server" ID="Customvalidator2" ForeColor="Red" ControlToValidate="txtPhoneNumber"
                                                    Display="Static" EnableClientScript="true" ClientValidationFunction="ValidatePhoneNumberOnCG"
                                                    ErrorMessage="Please enter valid phone number" OnServerValidate="cusCustom_ServerValidate"
                                                    ValidationGroup="SaveCompanyGroup"></asp:CustomValidator>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator5" ForeColor="Red"
                                                    SetFocusOnError="true" runat="server" ErrorMessage="Phone number should be greater than or equal to 6 digits."
                                                    ValidationExpression="^((\\+91-?)|0)?[0-9]{6,15}$" ValidationGroup="SaveGroup"
                                                    ControlToValidate="txtPhoneNumber" Display="Dynamic"></asp:RegularExpressionValidator>
                                            </td>
                                            <td>
                                                Mobile
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtMobileNumber" ValidationGroup="SaveGroup" runat="server" Style="width: 190px;"
                                                    MaxLength="10"></asp:TextBox><br />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator22" runat="server" ErrorMessage="Please Enter Mobile Number."
                                                    ControlToValidate="txtMobileNumber" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                                                <br />
                                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender20" runat="server" TargetControlID="txtMobileNumber"
                                                    FilterType="Numbers" />
                                                <asp:CustomValidator runat="server" ID="Customvalidator5" ForeColor="Red" ControlToValidate="txtMobileNumber"
                                                    ClientValidationFunction="ValidatePhoneNumber" Display="Dynamic" ErrorMessage="Please Enter Valid Mobile Number."
                                                    ValidationGroup="SaveGroup"></asp:CustomValidator>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator6" ForeColor="Red"
                                                    SetFocusOnError="true" runat="server" ErrorMessage="Mobile number should be of 10 digits."
                                                    ValidationExpression="^((\\+91-?)|0)?[0-9]{10}$" ValidationGroup="SaveGroup"
                                                    ControlToValidate="txtMobileNumber" Display="Dynamic"></asp:RegularExpressionValidator>
                                            </td>
                                            <td>
                                                Email
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtEmail" runat="server" Style="width: 190px; margin-top: 14px"
                                                    MaxLength="50"></asp:TextBox>
                                                <br />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorph" runat="server" ControlToValidate="txtEmail"
                                                    ErrorMessage="Please Enter Email." EnableClientScript="true" ForeColor="Red"
                                                    ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                                                <br />
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidatortxtEmail" runat="server"
                                                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="Invalid Email."
                                                    ValidationGroup="SaveGroup" ControlToValidate="txtEmail" ForeColor="Red"></asp:RegularExpressionValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Name
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtContactPerson1" runat="server" Style="width: 190px" MaxLength="50"></asp:TextBox>
                                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Custom"
                                                    ValidChars="-'_& " TargetControlID="txtContactPerson1">
                                                </ajax:FilteredTextBoxExtender>
                                                <asp:CustomValidator ID="customvalidatorcp1" runat="server" ValidationGroup="SaveGroup"
                                                    ControlToValidate="txtContactPerson1" ClientValidationFunction="Validatedatac"></asp:CustomValidator>
                                                <span id="spnContactPerson11"></span>
                                            </td>
                                            <td>
                                                Phone
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtPhoneNumber1" runat="server" Style="width: 190px;" MaxLength="15"></asp:TextBox>
                                                <br />
                                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender14" runat="server" FilterType="Numbers,Custom"
                                                    ValidChars=" " TargetControlID="txtPhoneNumber1">
                                                </ajax:FilteredTextBoxExtender>
                                                <asp:CustomValidator runat="server" ID="Customvalidator7" ForeColor="Red" ControlToValidate="txtPhoneNumber1"
                                                    Display="Static" EnableClientScript="true" ClientValidationFunction="ValidatePhoneNumberOnPopup"
                                                    ErrorMessage="Please enter valid phone number" OnServerValidate="cusCustom_ServerValidate"
                                                    ValidationGroup="SaveGroup"></asp:CustomValidator>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" ForeColor="Red"
                                                    SetFocusOnError="true" runat="server" ErrorMessage="Phone number should be greater than or equal to 6 digits."
                                                    ValidationExpression="^((\\+91-?)|0)?[0-9]{6,15}$" ValidationGroup="SaveGroup"
                                                    ControlToValidate="txtPhoneNumber1" Display="Dynamic"></asp:RegularExpressionValidator>
                                                <asp:CustomValidator ID="customvalidator8" runat="server" ValidationGroup="SaveGroup"
                                                    ControlToValidate="txtPhoneNumber1" ClientValidationFunction="Validatedatac"></asp:CustomValidator>
                                                <span id="spnPhone11"></span>
                                            </td>
                                            <td>
                                                Mobile
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtmobilenumber1" runat="server" Style="width: 190px;" MaxLength="10"></asp:TextBox><br />
                                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender21" runat="server" TargetControlID="txtmobilenumber1"
                                                    FilterType="Numbers,Custom" ValidChars=" " />
                                                <asp:CustomValidator runat="server" ID="Customvalidator6" ForeColor="Red" ControlToValidate="txtmobilenumber1"
                                                    ClientValidationFunction="ValidatePhoneNumber1" Display="Dynamic" ErrorMessage="Please Enter Valid Mobile Number."
                                                    ValidationGroup="SaveGroup"></asp:CustomValidator>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator7" ForeColor="Red"
                                                    SetFocusOnError="true" runat="server" ErrorMessage="Phone number should be of 10 digits."
                                                    ValidationExpression="^((\\+91-?)|0)?[0-9]{10}$" ValidationGroup="SaveGroup"
                                                    ControlToValidate="txtmobilenumber1" Display="Dynamic"></asp:RegularExpressionValidator>
                                                <asp:CustomValidator ID="customvalidator9" runat="server" ValidationGroup="SaveGroup"
                                                    ControlToValidate="txtmobilenumber1" ClientValidationFunction="Validatedatac"></asp:CustomValidator>
                                                <span id="SpanMobile11"></span>
                                            </td>
                                            <td>
                                                Email
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtEmail1" runat="server" Style="width: 190px; margin-top: 14px"
                                                    MaxLength="50"></asp:TextBox>
                                                <br />
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                    ErrorMessage="Invalid Email." ValidationGroup="SaveGroup" ControlToValidate="txtEmail1"
                                                    ForeColor="Red"></asp:RegularExpressionValidator><br />
                                                <asp:CustomValidator ID="customvalidator10" runat="server" ValidationGroup="SaveGroup"
                                                    ControlToValidate="txtEmail1" ClientValidationFunction="Validatedatac"></asp:CustomValidator>
                                                <span id="SpanEmail11"></span>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="8" class="bordnone">
                                <asp:Button ID="btnSaveComanygroup" runat="server" Text="Save" ValidationGroup="SaveGroup"
                                    OnClick="btnSaveComanygroup_Click" />
                                <asp:Button ID="btnClearComanygroup" runat="server" Text="Clear" OnClick="btnClearComanygroup_Click"
                                    OnClientClick="return clearfields();" />
                            </td>
                        </tr>
                    </table>
                    <asp:HiddenField ID="hdnPickupAddressId" runat="server" />
                </div>
            </div>
            <div id="divActivityRate" class="divActivityRate">
                <div style="float: right">
                    <asp:HyperLink Text="Hide" ForeColor="Blue" runat="server" Style="cursor: pointer"
                        ID="hlnkcloseActivityRate" onclick=" HidedivActivityRate();"></asp:HyperLink>
                </div>
                <div style="padding-left: 350px; float: left; text-align: center; color: #4f4f4f;
                    font-family: Arial; font-size: 13px; font-weight: bold; width: auto;">
                    Activity Rate
                </div>
                <div class="frmbox">
                    <asp:UpdatePanel ID="updRateCard" runat="server">
                        <ContentTemplate>
                            <script type="text/javascript">
                                Sys.Application.add_load(BindGroupEvents);
                                Sys.Application.add_load(bindevents);
                            </script>
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td align="center" colspan="4">
                                        <asp:Label ID="lblActvRateMsg" runat="server" Font-Bold="true" Font-Size="Small"
                                            ForeColor="Brown"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" colspan="4" style="font-family: Arial; font-weight: bold; font-size: 13px;">
                                        Company Group :&nbsp;<asp:Label ID="lblRateCGname" runat="server" Font-Bold="true"
                                            ForeColor="Brown"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" colspan="4" style="font-family: Arial; font-weight: bold; font-size: 13px;">
                                        Customer Name :&nbsp;<asp:Label ID="lblRateCustName" runat="server" Font-Bold="true"
                                            ForeColor="Brown"></asp:Label>
                                    </td>
                                    <tr>
                                        <td id="tdFdate" runat="server" width="12%">
                                            From Date
                                        </td>
                                        <td>
                                            <asp:Label ID="lblFromDate" runat="server" Font-Bold="true"></asp:Label>
                                            <%--             <asp:TextBox ID="txtFromDateRate" CssClass="datepicker" runat="server" size="27"
                                                MaxLength="60" onkeypress="retrun false;" Width="190px" TabIndex="3"></asp:TextBox>--%>
                                        </td>
                                        <td id="tdEnddate" runat="server" width="12%">
                                            End Date
                                        </td>
                                        <td>
                                            <asp:Label ID="lblEndDate" runat="server" Font-Bold="true"></asp:Label>
                                            <%--                        <asp:TextBox ID="txtEndDateRate" runat="server" size="27" MaxLength="60" CssClass="datepicker"
                                                onkeypress="retrun false;" Width="190px" TabIndex="4"></asp:TextBox>--%>
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
                                                                <asp:TextBox ID="txtRate" runat="server" MaxLength="9" Width="90" Text='<%# Bind("Rate") %>'
                                                                    Style="text-align: right;" onclick="if(this.value=='0.00'){this.value='';}" onchange="if(this.value==''){this.value='0.00';}"
                                                                    onblur="if(this.value==''){this.value='0.00';}" onfocus="if(this.value=='0.00'){this.value='';this.focus();}"
                                                                    ValidationGroup="ValRateGroup2"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="RegFieldFname" runat="server" ForeColor="Red" ControlToValidate="txtRate"
                                                                    SetFocusOnError="true" ErrorMessage="*" ValidationGroup="ValRateGroup2"></asp:RequiredFieldValidator>
                                                                <br />
                                                                <asp:RegularExpressionValidator ID="rfvdtr" runat="server" ControlToValidate="txtRate"
                                                                    ValidationGroup="ValRateGroup2" ErrorMessage="Rate should be decimal valid  (8,2) "
                                                                    ValidationExpression="^-?[0-9]{1,8}(\.[0-9]{1,2})?$|^-?(100)(\.[0]{1,2})?$" ForeColor="Red"></asp:RegularExpressionValidator>
                                                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" FilterType="Numbers,Custom"
                                                                    ValidChars="." TargetControlID="txtRate">
                                                                </ajax:FilteredTextBoxExtender>
                                                                <asp:HiddenField ID="hdnRateCardId" runat="server" Value='<%# Eval("RateCardId") %>' />
                                                                <asp:HiddenField ID="hdnActivityId" runat="server" Value='<%# Eval("ActivityId") %>' />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <AlternatingRowStyle CssClass="AlternativeRowStyle" />
                                                </asp:GridView>
                                                <asp:HiddenField ID="hdnCustIdOnRate" runat="server" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" class="bordnone" valign="bottom">
                                            <asp:Button ID="btnSaveActivityRate" runat="server" ValidationGroup="ValRateGroup2"
                                                OnClientClick="javascript:return ValidCustomerSaveRateAcivity();" TabIndex="9"
                                                Text="Save" OnClick="btnSaveActivityRate_Click" />
                                            <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" CausesValidation="false" />
                                        </td>
                                    </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:HiddenField ID="hdnCustId" runat="server" />
                </div>
            </div>
            <div id="divSaveMsg" class="divActivityRate" style="display: none">
                <div style="padding-left: 350px; float: left; text-align: center; color: #4f4f4f;
                    font-family: Arial; font-size: 13px; font-weight: bold; width: auto;">
                    Record Updated Sucessfully.
                </div>
            </div>
            <div id="blocker" style="display: none">
                <div>
                    Loading...</div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <div id="divContract" class="divActivityContract">
        <div style="float: right">
            <asp:HyperLink Text="Hide" ForeColor="Blue" runat="server" Style="cursor: pointer"
                ID="HyperLink1" onclick=" HidedivContract();"></asp:HyperLink>
        </div>
        <div style="padding-left: 350px; float: left; text-align: center; color: #4f4f4f;
            font-family: Arial; font-size: 13px; font-weight: bold; width: auto;">
            Contract
        </div>
        <div class="frmbox">
            <asp:UpdatePanel ID="UpdateContract" runat="server">
                <ContentTemplate>
                    <script type="text/javascript">
                        Sys.Application.add_load(BindContractDate);
                    </script>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="15%" align="left">
                            </td>
                            <td width="21%" colspan="3" align="center">
                                <asp:Label ID="lblContrDocMsg" runat="server" Font-Bold="true" Font-Size="Small"
                                    ForeColor="Brown"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" colspan="4" style="font-family: Arial; font-weight: bold; font-size: 13px;">
                                Company Group :&nbsp;<asp:Label ID="lblCompGrpName" runat="server" Font-Bold="true"
                                    ForeColor="Brown"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" colspan="4" style="font-family: Arial; font-weight: bold; font-size: 13px;">
                                Customer Name :&nbsp;<asp:Label ID="lblCustomername" runat="server" Font-Bold="true"
                                    ForeColor="Brown"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td width="15%">
                                Contract No.
                            </td>
                            <td width="21%">
                                <asp:TextBox ID="txtContractNo" runat="server" Style="width: 200px;" MaxLength="15"
                                    Enabled="false" TabIndex="1"></asp:TextBox>
                            </td>
                            <td width="15%">
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>
                                From Date
                            </td>
                            <td>
                                <asp:TextBox ID="txtFromDateContract" CssClass="datepicker1" runat="server" size="27"
                                    MaxLength="60" onkeypress="return false;" Width="190px" TabIndex="3"></asp:TextBox>
                            </td>
                            <td>
                                End Date
                            </td>
                            <td>
                                <asp:TextBox ID="txtEndDateContract" runat="server" size="27" MaxLength="60" CssClass="datepicker1"
                                    onkeypress="return false;" Width="190px" TabIndex="4"></asp:TextBox><br />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Remark
                            </td>
                            <td>
                                <asp:TextBox ID="txtRemark" runat="server" TextMode="MultiLine" Style="width: 190px;
                                    height: 45px;" MaxLength="250" TabIndex="5" onkeypress="return textboxMultilineMaxNumber(this.id,250)"
                                    onkeyup="return textboxMultilineMaxNumber(this.id,250)"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Document Name
                            </td>
                            <td>
                                <asp:TextBox ID="txtDocumentName" runat="server" MaxLength="50" Style="width: 190px"
                                    TabIndex="7"></asp:TextBox>
                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender9" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Custom"
                                    ValidChars="-'_& " TargetControlID="txtDocumentName">
                                </ajax:FilteredTextBoxExtender>
                            </td>
                            <td width="15%">
                                Select Document
                            </td>
                            <td>
                                <asp:FileUpload ID="fileContractDocPath" runat="server" Height="20" TabIndex="8"
                                    onchange=" return validateFileUpload();" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="bordnone" valign="bottom">
                                <asp:Button ID="btnSaveContract" runat="server" OnClientClick="return validateContractSave()"
                                    TabIndex="9" Text="Save" OnClick="btnSaveContract_Click" />
                                <asp:Button ID="btnCancelcontract" runat="server" TabIndex="10" CausesValidation="false"
                                    OnClientClick="return clearContractfields()" Text="Clear" />
                            </td>
                            <td width="15%">
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td align="left" colspan="4">
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnSaveContract" />
                </Triggers>
                <Triggers>
                    <asp:PostBackTrigger ControlID="grdRateCard" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
