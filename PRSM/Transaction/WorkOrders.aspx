<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true"
    CodeFile="WorkOrders.aspx.cs" Inherits="Transaction_WorkOrders" %>

<asp:Content ID="Content" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .ui-autocomplete
        {
            background-color: white !important;
            width: 200px;
        }
        #popup
        {
            display: none;
            position: fixed;
            width: 250px;
            height: 150px;
            top: 50%;
            left: 50%;
            margin-left: -155px;
            margin-top: -110px;
            border: 5px solid red;
            background-color: #DEDFDE;
            padding: 30px;
            z-index: 102;
            font-family: Verdana;
            font-size: 10pt;
            border-radius: 10px;
            -webkit-border-radius: 20px;
            -moz-border-radius: 20px;
            font-weight: bold;
        }
        #content
        {
            height: auto;
            width: 250px;
            margin: 60px auto;
        }
        #popupclose
        {
            margin: 35px 0 0 80px;
            width: 50px;
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
            top: 130px;
            border: #e4e4e4 2px solid;
            box-shadow: 0 0 20px #000;
            width: 900px;
            left: 16%;
            margin-left: -80px;
            display: none;
        }
        
        .divActivityRate
        {
            background-color: #fff;
            z-index: 20000;
            position: fixed;
            background: #fff;
            padding: 20px;
            top: 25px;
            border: #e4e4e4 2px solid;
            box-shadow: 0 0 20px #000;
            width: 910px;
            left: 200px;
            display: none;
            -webkit-border-top-left-radius: 10px;
            -webkit-border-top-right-radius: 10px;
            -moz-border-radius-topleft: 10px;
            -moz-border-radius-topright: 10px;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
            border-left: #e4e4e4 2px solid;
            border-right: #e4e4e4 2px solid;
            border-top: #e4e4e4 2px solid;
        }
        .nopadding
        {
            padding: 0px !important;
        }
    </style>
    <script src="../Scripts/Request.js" type="text/javascript"></script>
    <link href="../Scripts/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/1.10.4-jquery-ui.js" type="text/javascript"></script>
    <link href="../Scripts/1.10.4-themes-smoothness-jquery-ui.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-ui.js" type="text/javascript"></script>
    <script src="../Scripts/Contract.js" type="text/javascript"></script>
    <script src="../Scripts/WorkOrder.js" type="text/javascript"></script>
    <ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </ajax:ToolkitScriptManager>
    <asp:UpdatePanel runat="server" ID="UpdpananelSerachOrder">
        <ContentTemplate>
            <script type="text/javascript">
                Sys.Application.add_load(BindRequest);
            </script>
            <script type="text/javascript">
                Sys.Application.add_load(BindCustomer);
                
            </script>
            <script type="text/javascript">
                Sys.Application.add_load(bindDatevents);
                Sys.Application.add_load(showFiledetails);
            </script>
            <script type="text/javascript">
                Sys.Application.add_load(BindContractDate);
            </script>
            <script type="text/javascript">
                Sys.Application.add_load(bindevents);
            </script>
            <script type="text/javascript">
                function validateFileUpload() {

                    var RetrievalPickUpAddress = document.getElementById('ContentPlaceHolder1_ddlRetrievalPickUpAddress').value;
                    if (RetrievalPickUpAddress == "0") {
                        alert("Please select Pickup Address.");
                        document.getElementById("ContentPlaceHolder1_ddlRetrievalPickUpAddress").focus();
                        return false;
                    }

                    var Activity = document.getElementById('ContentPlaceHolder1_ddlRetrivalActivity').value;
                    if (Activity == "0") {
                        alert("Please select Activity.");
                        document.getElementById("ContentPlaceHolder1_ddlRetrivalActivity").focus();
                        return false;
                    }

                    var uplSheet = document.getElementById('ContentPlaceHolder1_FileUpload1');
                    // alert(uplSheet.value.trim());
                    var extn = uplSheet.value.substring(uplSheet.value.lastIndexOf('.') + 1).toLowerCase();
                    if (uplSheet.value.trim() == "") {
                        alert('Please Select File To Upload');
                        return false;
                    }
                    var i = 1;
                    if (uplSheet.value.trim() == "") {
                        alert('Please Select File To Upload');
                        return false;
                    }
                    else {
                        if (uplSheet.value.trim() != "") {
                            // var i = 1;
                            if (extn == 'xls' || extn == 'xlsx') {
                                i = 0;
                            }
                        }
                    }
                    if (i == 1) {
                        uplSheet.value = '';
                        alert('You can upload file with (.xls Or .xlsx) extensions only.');
                        return false;
                    }


                    return true;

                }
            </script>
            <script type="text/javascript">
                function validateFileUpload2() {

                    var RetrievalPickUpAddress = document.getElementById('ContentPlaceHolder1_ddlRetrievalPickUpAddress').value;
                    if (RetrievalPickUpAddress == "0") {
                        alert("Please select Pickup Address.");
                        document.getElementById("ContentPlaceHolder1_ddlRetrievalPickUpAddress").focus();
                        return false;
                    }

                    var Activity = document.getElementById('ContentPlaceHolder1_ddlRetrivalActivity').value;
                    if (Activity == "0") {
                        alert("Please select Activity.");
                        document.getElementById("ContentPlaceHolder1_ddlRetrivalActivity").focus();
                        return false;
                    }

                    var uplSheet = document.getElementById('ContentPlaceHolder1_FileUpload2');
                    // alert(uplSheet.value.trim());
                    var extn = uplSheet.value.substring(uplSheet.value.lastIndexOf('.') + 1).toLowerCase();
                    if (uplSheet.value.trim() == "") {
                        alert('Please Select File To Upload');
                        return false;
                    }
                    var i = 1;
                    if (uplSheet.value.trim() == "") {
                        alert('Please Select File To Upload');
                        return false;
                    }
                    else {
                        if (uplSheet.value.trim() != "") {
                            // var i = 1;
                            if (extn == 'xls' || extn == 'xlsx') {
                                i = 0;
                            }
                        }
                    }
                    if (i == 1) {
                        uplSheet.value = '';
                        alert('You can upload file with (.xls Or .xlsx) extensions only.');
                        return false;
                    }


                    return true;

                }
            </script>
            <script type="text/javascript">
                function validateFileUploadOS() {

                    //                    var NoOfServices = document.getElementById('ContentPlaceHolder1_txtNoOfServices').value;
                    //                    if (NoOfServices == "") {
                    //                        alert("Please select No Of Services.");
                    //                        document.getElementById("ContentPlaceHolder1_txtNoOfServices").focus();
                    //                        return false;
                    //                    }
                    var uplSheet = document.getElementById('ContentPlaceHolder1_FileUpload3');
                    // alert(uplSheet.value.trim());
                    var extn = uplSheet.value.substring(uplSheet.value.lastIndexOf('.') + 1).toLowerCase();
                    if (uplSheet.value.trim() == "") {
                        alert('Please Select File To Upload');
                        return false;
                    }
                    var i = 1;
                    if (uplSheet.value.trim() == "") {
                        alert('Please Select File To Upload');
                        return false;
                    }
                    else {
                        if (uplSheet.value.trim() != "") {
                            // var i = 1;
                            if (extn == 'xls' || extn == 'xlsx') {
                                i = 0;
                            }
                        }
                    }
                    if (i == 1) {
                        uplSheet.value = '';
                        alert('You can upload file with (.xls Or .xlsx) extensions only.');
                        return false;
                    }


                    return true;

                }
            </script>
            <script type="text/javascript">
                function validateDestrFileUpload() {

                    var Activity = document.getElementById('ContentPlaceHolder1_ddlDestructionActivity').value;
                    if (Activity == "0") {
                        alert("Please select Activity.");
                        document.getElementById("ContentPlaceHolder1_ddlDestructionActivity").focus();
                        return false;
                    }

                    var uplSheet = document.getElementById('ContentPlaceHolder1_FileUpload5');
                    // alert(uplSheet.value.trim());
                    var extn = uplSheet.value.substring(uplSheet.value.lastIndexOf('.') + 1).toLowerCase();
                    if (uplSheet.value.trim() == "") {
                        alert('Please Select File To Upload');
                        return false;
                    }
                    var i = 1;
                    if (uplSheet.value.trim() == "") {
                        alert('Please Select File To Upload');
                        return false;
                    }
                    else {
                        if (uplSheet.value.trim() != "") {
                            // var i = 1;
                            if (extn == 'xls' || extn == 'xlsx') {
                                i = 0;
                            }
                        }
                    }
                    if (i == 1) {
                        uplSheet.value = '';
                        alert('You can upload file with (.xls Or .xlsx) extensions only.');
                        return false;
                    }


                    return true;

                }
            </script>
            <script type="text/javascript" language="javascript">
                function bindrbt() {
                    if ($('input[id*="rbtretrivalType"]').length > 0) {
                        $('input[id*="rbtretrivalType"]').on('change', function () {

                            if ($('input[id*="rbtretrivalType"]:checked').val() == 1) {
                                $('#ContentPlaceHolder1_txtFileBarCode').val('');
                                $("#ContentPlaceHolder1_txtFileBarCode").attr("disabled", "disabled");
                            }
                            else {
                                $("#ContentPlaceHolder1_txtFileBarCode").removeAttr("disabled");
                            }
                        });
                    }
                }
            </script>
            <script type="text/javascript">
                Sys.Application.add_load(BindContractDate);
                Sys.Application.add_load(bindrbt);
                Sys.Application.add_load(BindBoxBarcodeEvents)
            </script>
            <%--<script type="text/javascript">
                function open_win() {
                    //                $("#divFileUpload").dialog();

                    $("#divFileUpload").dialog({
                        buttons: {
                            Ok: function () {
                                $("#btnFile").click();
                            },
                            Close: function () {
                                $(this).dialog('close');
                            }
                        }
                    });
                    //                    window.showModalDialog("~\Reports\UploadBrowse.htm");
                }
            </script>--%>
            <style type="text/css">
                .ui-autocomplete
                {
                    background-color: white !important;
                    width: 200px;
                    max-height: 150px !important;
                    overflow: auto;
                }
            </style>
            <div class="clear">
            </div>
            <div class="middle">
                <div class="frmbxhead" style="width: 150px; z-index: 2;">
                    <asp:LinkButton ID="lnkbtnNewWorkOrder" runat="server" Font-Underline="false" Style="color: #4f4f4f !important;"
                        CausesValidation="false" OnClick="lnkbtnNewWorkOrder_Click"> New Work Order</asp:LinkButton>
                </div>
                <div class="frmbxhead" style="margin-left: 245px !important; margin-bottom: -1px !important;
                    z-index: 0 !important;">
                    <asp:LinkButton ID="lnkbtnSearchOrder" runat="server" Font-Underline="false" Style="color: #4f4f4f !important;"
                        CausesValidation="false" OnClick="lnkbtnSearchOrder_Click" OnClientClick="changesearch('ContentPlaceHolder1_ddlSearchRequestby')">Search&nbsp; 
                    
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                    Order</asp:LinkButton>
                </div>
                <div class="frmbxhead" style="margin-left: 400px !important; margin-bottom: -1px !important;
                    z-index: 0 !important;">
                    <asp:LinkButton ID="lnkbtnUpdateWOActivity" runat="server" Font-Underline="false"
                        Style="color: #4f4f4f !important;" CausesValidation="false" OnClick="lnkbtnUpdateWOActivity_Click">Update WO&nbsp;Activity         
                    </asp:LinkButton>
                </div>
                <div class="frmbox">
                    <table width="90%" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td align="center">
                                <asp:Label ID="lblMessage" runat="server" Font-Bold="true" Font-Size="Medium" ForeColor="Brown"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtWO" runat="server" Visible="false"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                    <div id="divNewOrder" runat="server">
                        <table width="100%">
                            <tr>
                                <td>
                                    WareHouse
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlWareHouse" runat="server" Width="150">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlWareHouse"
                                        ErrorMessage="Please Select WareHouse." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                                </td>
                                <td>
                                    Date
                                </td>
                                <td>
                                    <asp:TextBox ID="txtWorkOrderDate" runat="server" Style="width: 100px;" MaxLength="20"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Company Group
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlCompanyGroup" runat="server" Width="250" OnSelectedIndexChanged="ddlCompanyGroup_SelectedIndexChanged"
                                        AutoPostBack="true">
                                    </asp:DropDownList>
                                    <br />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlCompanyGroup"
                                        ErrorMessage="Please Select Company Group." InitialValue="0" ForeColor="Red"
                                        ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                                </td>
                                <td>
                                    Customer
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlCustomer" runat="server" Width="250" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlCustomer_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    <br />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlCustomer"
                                        ErrorMessage="Please Select Customer." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                                    <asp:HiddenField ID="hfcustusername" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Service Request
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlServiceRequest" runat="server" Width="250" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlServiceRequest_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:HiddenField ID="hfemailid" runat="server" />
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" width="100%">
                                    <fieldset style="border: #e4e4e4 0px solid; -webkit-border-top-left-radius: 10px;
                                        -webkit-border-top-right-radius: 10px; -moz-border-radius-topleft: 10px; -moz-border-radius-topright: 10px;">
                                        <legend><b></b></legend>
                                        <table width="100%">
                                            <tr>
                                                <td style="padding-left: 10px; border-bottom: #e4e4e4 2px solid;">
                                                    <label>
                                                        <span style="font-size: 16px;">Requested Service </span>
                                                    </label>
                                                    <br />
                                                    <asp:RadioButtonList ID="rdblst" runat="server" Width="700" RepeatDirection="Horizontal"
                                                        RepeatColumns="3" Style="border-bottom: 0px; padding-left: 50px;" AutoPostBack="true"
                                                        OnSelectedIndexChanged="rdblst_SelectedIndexChanged">
                                                    </asp:RadioButtonList>
                                                    <%--<asp:CheckBoxList ID="chklst" runat="server" Width="700" RepeatDirection="Horizontal"
                                                        RepeatColumns="3" Style="border-bottom: 0px; padding-left: 50px;" AutoPostBack="True"
                                                        OnSelectedIndexChanged="chklst_SelectedIndexChanged">
                                                    </asp:CheckBoxList>--%>
                                                    <br />
                                                </td>
                                            </tr>
                                        </table>
                                        <%-- ... Add file pickup and its Address  --%>
                                        <div runat="server" id="divFilepickup" style="border: #e4e4e4 1px solid; -webkit-border-top-left-radius: 5px;
                                            -webkit-border-top-right-radius: 10px; -moz-border-radius-topleft: 10px; -moz-border-radius-topright: 10px;
                                            width: 910px; margin-top: 10px;">
                                            <span style="font-size: 15px;">&nbsp; &nbsp; File Pickup </span>
                                            <br />
                                            <table width="100%" border="0">
                                                <tr>
                                                    <td style="width: 20%;">
                                                        Date Of Pick Up
                                                    </td>
                                                    <td style="width: 20%">
                                                        <asp:TextBox ID="txtdateofPickup" runat="server" Style="width: 130px;" MaxLength="10"
                                                            CssClass="datepicker" onkeypress="return false;"></asp:TextBox><br />
                                                        <asp:RequiredFieldValidator ID="rfvnDatePickUp" runat="server" ControlToValidate="txtdateofPickup"
                                                            SetFocusOnError="true" ErrorMessage="Please select date." ForeColor="Red" ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                                                    </td>
                                                    <td>
                                                        Department
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList runat="server" ID="ddlDepartment" Width="200">
                                                        </asp:DropDownList>
                                                        <br />
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ControlToValidate="ddlDepartment"
                                                            ErrorMessage="Please select department." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <%--<td style="width: 11%;" valign="top">
                                                        No. of boxes
                                                    </td>--%>
                                                    <td style="width: 20%;">
                                                        File Pickup Address
                                                    </td>
                                                    <td style="width: 20%">
                                                        <asp:DropDownList runat="server" ID="ddlFilePickUpAddress" Width="200">
                                                        </asp:DropDownList>
                                                        <br />
                                                        <asp:RequiredFieldValidator ID="rfvddlfilepickup" runat="server" ControlToValidate="ddlFilePickUpAddress"
                                                            ErrorMessage="Please select File Pick Up address." InitialValue="0" ForeColor="Red"
                                                            ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                                                    </td>
                                                    <td colspan="2" align="right">
                                                        <asp:Button ID="btnAddFPickUpAddress" runat="server" Text="Add" OnClick="btnAddFPickUpAddress_Click"
                                                            ValidationGroup="SaveGroup1" />
                                                        <br />
                                                        <asp:CustomValidator ID="cstmValidFilePickUpAddr" runat="server" OnServerValidate="Validate_FilePickUpAddress"
                                                            ErrorMessage="Please add atleast one file pickup service." InitialValue="0" ForeColor="Red"
                                                            ValidationGroup="SaveGroup"></asp:CustomValidator>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtnoofboxes" runat="server" Style="width: 130px;" MaxLength="10"
                                                            ReadOnly="true" Text="0"></asp:TextBox>
                                                        &nbsp; &nbsp;<br />
                                                        <%--<asp:RequiredFieldValidator ID="rfvnoBoxes" runat="server" ControlToValidate="txtnoofboxes"
                                                            SetFocusOnError="true" ErrorMessage="Please enter no of boxes." ForeColor="Red"
                                                            ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>--%>
                                                        <ajax:FilteredTextBoxExtender ID="filtertxtNoOfboxes" runat="server" FilterType="Numbers"
                                                            TargetControlID="txtnoofboxes">
                                                        </ajax:FilteredTextBoxExtender>
                                                    </td>
                                                    <%-- <td valign="top">
                                                        No. of Files
                                                    </td>--%>
                                                    <td valign="top">
                                                        <asp:TextBox ID="txtnooffiles" runat="server" Style="width: 130px;" MaxLength="10"
                                                            ReadOnly="true" Text="0"></asp:TextBox>
                                                        &nbsp; &nbsp;
                                                        <asp:CheckBox runat="server" ID="chkboxesconfirm" Text="To be confirmed " Style="margin: 3px 3px 3px 4px;">
                                                        </asp:CheckBox>
                                                        <br />
                                                        <%--<asp:RequiredFieldValidator ID="rfvnoFiles" runat="server" ControlToValidate="txtnooffiles"
                                                            ErrorMessage="Please enter no of files." ForeColor="Red" SetFocusOnError="true"
                                                            ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>--%>
                                                        <ajax:FilteredTextBoxExtender ID="filtertxtNoOfFiles" runat="server" FilterType="Numbers"
                                                            TargetControlID="txtnooffiles">
                                                        </ajax:FilteredTextBoxExtender>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <%-- <td style="width: 20%;">
                                                        File Pickup Address
                                                    </td>--%>
                                                    <%-- <td style="width: 20%">
                                                        <asp:DropDownList runat="server" ID="ddlFilePickUpAddress" Width="200">
                                                        </asp:DropDownList>
                                                        <br />
                                                        <asp:RequiredFieldValidator ID="rfvddlfilepickup" runat="server" ControlToValidate="ddlFilePickUpAddress"
                                                            ErrorMessage="Please select File Pick Up address." InitialValue="0" ForeColor="Red"
                                                            ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                                                    </td>
                                                    <td colspan="2" align="right">
                                                        <asp:Button ID="btnAddFPickUpAddress" runat="server" Text="Add" OnClick="btnAddFPickUpAddress_Click"
                                                            ValidationGroup="SaveGroup1" />
                                                        <br />
                                                        <asp:CustomValidator ID="cstmValidFilePickUpAddr" runat="server" OnServerValidate="Validate_FilePickUpAddress"
                                                            ErrorMessage="Please add atleast one file pickup service." InitialValue="0" ForeColor="Red"
                                                            ValidationGroup="SaveGroup"></asp:CustomValidator>
                                                    </td>--%>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" width="100%" align="right">
                                                        <asp:GridView runat="server" ID="grdFilePickUpAddress" AutoGenerateColumns="false"
                                                            CssClass="grid_data" Width="100%">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Sr No.">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="10%"></ItemStyle>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Department Name">
                                                                    <ItemTemplate>
                                                                        <asp:HiddenField ID="hdndepartmentId" runat="server" Value='<%# Eval("FDepartmentId") %>' />
                                                                        <asp:Label ID="lblDepartment" runat="server" Text="<%# ((FilePickUpAddress) Container.DataItem).FDepartmentName %>"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="20%"></ItemStyle>
                                                                </asp:TemplateField>
                                                                <%-- <asp:TemplateField HeaderText="No. Of Boxes">
                                                                    <ItemTemplate>
                                                                        <div style="overflow: auto; max-height: 35px; max-width: 170px;">
                                                                            <asp:Label ID="lblNoOfBoxes" runat="server" Text="<%# ((FilePickUpAddress) Container.DataItem).FNoOfBoxes %>"></asp:Label>
                                                                        </div>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="10%"></ItemStyle>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="No. Of Files">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblNoOfFiles" runat="server" Text="<%# ((FilePickUpAddress) Container.DataItem).FNoOfFiles %>"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="10%"></ItemStyle>
                                                                </asp:TemplateField>--%>
                                                                <asp:TemplateField HeaderText="PickUp Address">
                                                                    <ItemTemplate>
                                                                        <asp:HiddenField ID="hdnFPickUpAddressId" runat="server" Value='<%# Eval("FPickUpAddressId") %>' />
                                                                        <div style="overflow: auto; max-height: 35px; max-width: 170px;">
                                                                            <asp:Label ID="lblPickUpAddress" runat="server" Text="<%# ((FilePickUpAddress) Container.DataItem).FPickUpAddress %>"></asp:Label>
                                                                        </div>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="50%"></ItemStyle>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Date">
                                                                    <ItemTemplate>
                                                                        <div style="overflow: auto; max-height: 35px; max-width: 170px;">
                                                                            <asp:Label ID="lblFDate" runat="server" Text="<%# ((FilePickUpAddress) Container.DataItem).FPickUpDate %>"></asp:Label>
                                                                        </div>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="10%"></ItemStyle>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div runat="server" id="divRetrival" style="border: #e4e4e4 1px solid; -webkit-border-top-left-radius: 5px;
                                            -webkit-border-top-right-radius: 10px; -moz-border-radius-topleft: 10px; -moz-border-radius-topright: 10px;
                                            width: 910px; margin-top: 10px;">
                                            <span style="font-size: 15px;">&nbsp; &nbsp; Retrieval </span>
                                            <br />
                                            <table width="100%" border="0">
                                                <tr>
                                                    <td style="width: 10%;">
                                                        Pickup Address
                                                    </td>
                                                    <td style="width: 10%;">
                                                        <asp:DropDownList runat="server" ID="ddlRetrievalPickUpAddress" Width="200" AutoPostBack="True">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td colspan="4">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 10%;">
                                                        Activity
                                                    </td>
                                                    <td style="width: 10%;">
                                                        <asp:DropDownList runat="server" ID="ddlRetrivalActivity" Width="150" AutoPostBack="true"
                                                            OnSelectedIndexChanged="ddlRetrivalActivity_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td style="width: 17%;">
                                                        Box Bar Code
                                                    </td>
                                                    <td style="width: 10%">
                                                        <div class="ui-widget" style="width: 100%;">
                                                            <asp:HiddenField ID="selectedValue" runat="server" />
                                                            <asp:TextBox ID="txtBoxBarCode" runat="server" Style="width: 100px;" MaxLength="16"
                                                                onblur="autocompDrop(this.id,'#ContentPlaceHolder1_selectedValue');"></asp:TextBox>
                                                        </div>
                                                    </td>
                                                    <td id="DvFileBarCode" runat="server" style="width: 17%">
                                                        File Bar Code
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtFileBarCode" runat="server" Style="width: 100px;" MaxLength="16"
                                                            onblur="autocompDropFile(this.id,'#ContentPlaceHolder1_selectedValue');"></asp:TextBox>
                                                        &nbsp; &nbsp;
                                                        <asp:Button runat="server" ID="btnAddRetrival" Text="ADD" OnClientClick="return ValidateRetrievalBoxFile();"
                                                            OnClick="btnAddRetrival_Click" /><br />
                                                        <asp:CustomValidator ID="customvalidateRetrival" runat="server" OnServerValidate="Validate_Retrival"
                                                            ErrorMessage="Please select acitvity and box barcode!" InitialValue="0" ForeColor="Red"
                                                            ValidationGroup="SaveGroup"></asp:CustomValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="6">
                                                        <div id="divBoxUploadControls" runat="server">
                                                            <table width="100%" border="0">
                                                                <tr border="0">
                                                                    <td colspan="1">
                                                                        <asp:Label ID="LblBox" runat="server" Text=" Select Box barcode excel file"></asp:Label>
                                                                    </td>
                                                                    <td colspan="3">
                                                                        <asp:FileUpload ID="FileUpload1" runat="server" onchange=" return validateFileUpload();" />
                                                                        <asp:Button ID="btnBoxUpload" runat="server" Text="Box Upload" OnClick="btnBoxUpload_Click"
                                                                            OnClientClick="return validateFileUpload();" />
                                                                    </td>
                                                                    <td colspan="2">
                                                                        <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/ExcelSheetFormats/ExcelFormatBox.xlsx">Excel Format For box</asp:HyperLink>
                                                                        <br />
                                                                        <br />
                                                                        <br />
                                                                        <asp:Label ID="lblBoxErrorMsg" runat="server"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                        <div id="divFileUploadControls" runat="server">
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td colspan="1">
                                                                        <asp:Label ID="lblFile" runat="server" Text="Select File barcode excel file"></asp:Label>
                                                                    </td>
                                                                    <td colspan="3">
                                                                        <asp:FileUpload ID="FileUpload2" runat="server" onchange=" return validateFileUpload2();" />
                                                                        <asp:Button ID="btnFileUpload" runat="server" Text="File Upload" OnClick="btnFileUpload_Click1"
                                                                            OnClientClick="return validateFileUpload2();" />
                                                                    </td>
                                                                    <td colspan="2">
                                                                        <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/ExcelSheetFormats/ExcelFormatFile.xlsx">Excel format for File</asp:HyperLink>
                                                                        <br />
                                                                        <br />
                                                                        <asp:Label ID="lblFileErrorMsg" runat="server"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <%--                                                <tr>
                                                    <td colspan="6">

                                                    </td>
                                                </tr>--%>
                                                <tr>
                                                    <td colspan="4" width="100%" align="right">
                                                        <asp:GridView runat="server" ID="grdRetrivalActivityCount" AutoGenerateColumns="false"
                                                            CssClass="grid_data" Width="100%">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Activity Name">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblName" runat="server" Text="<%# ((ActivityListCount) Container.DataItem).ActivityName %>"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="30%"></ItemStyle>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Activity Count">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblActivityCount" runat="server" Text="<%# ((ActivityListCount) Container.DataItem).ActivityCount %>"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="30%" HorizontalAlign="Center"></ItemStyle>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="PickUp Address">
                                                                    <ItemTemplate>
                                                                        <asp:HiddenField ID="hdnRetrPickUpAddress" runat="server" Value="<%# ((ActivityListCount) Container.DataItem).RetrPickUpAddressId%>" />
                                                                        <div style="overflow: auto; max-height: 35px; max-width: 170px;">
                                                                            <asp:Label ID="lblRetPickUpAddress" runat="server" Text="<%# ((ActivityListCount) Container.DataItem).RetrPickUpAddress %>"></asp:Label>
                                                                        </div>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="40%"></ItemStyle>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>
                                                        <td colspan="2">
                                                            <asp:GridView ID="grdErrors" runat="server" CssClass="grid_data" AutoGenerateColumns="true"
                                                                Width="400px">
                                                            </asp:GridView>
                                                        </td>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="6" style="width: 100%">
                                                        <table width="100%" class="grid_data" border="0">
                                                            <tr>
                                                                <th style="width: 8%" align="left">
                                                                    Sr No.
                                                                </th>
                                                                <th align="left" style="width: 28%">
                                                                    Pick Up Address
                                                                </th>
                                                                <th align="left" style="width: 24%">
                                                                    Activity Name
                                                                </th>
                                                                <th style="width: 20%" align="left">
                                                                    Box Bar Code
                                                                </th>
                                                                <th style="width: 20%" align="left">
                                                                    File Bar Code
                                                                </th>
                                                            </tr>
                                                        </table>
                                                        <div style="overflow: auto; padding-left: 0px; color: #4f4f4f; font-size: 12px; width: 100%;
                                                            height: 180px; line-height: 20px;">
                                                            <asp:GridView runat="server" ID="grdRetrivalActivity" AutoGenerateColumns="false"
                                                                CssClass="grid_data" Width="100%" ShowHeader="false" OnRowDeleting="grdRetrivalActivity_RowDeleting">
                                                                <%--AutoGenerateDeleteButton="true"--%>
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Sr No.">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="8%"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="PickUp Address">
                                                                        <ItemTemplate>
                                                                            <asp:HiddenField ID="hdnRetrPickUpAddress" runat="server" Value="<%# ((ActivityList) Container.DataItem).RetrPickUpAddressId%>" />
                                                                            <asp:Label ID="lblPickUpAddress" runat="server" Text="<%# ((ActivityList) Container.DataItem).RetrPickUpAddress %>"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="28%"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Activity Name">
                                                                        <ItemTemplate>
                                                                            <asp:HiddenField ID="hdnActivityid" runat="server" Value="<%# ((ActivityList) Container.DataItem).ActivityId%>" />
                                                                            <asp:Label ID="lblName" runat="server" Text="<%# ((ActivityList) Container.DataItem).ActivityName %>"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="24%"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Box BarCode">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblBoxBarCode" runat="server" Text="<%# ((ActivityList) Container.DataItem).BoxBarCode %>"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="20%"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="File BarCode">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblFileBarCode" runat="server" Text="<%# ((ActivityList) Container.DataItem).FileBarCode %>"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="20%"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                    <asp:CommandField ShowDeleteButton="True" />
                                                                </Columns>
                                                            </asp:GridView>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div runat="server" id="divPermanentReturn" style="border: #e4e4e4 1px solid; -webkit-border-top-left-radius: 5px;
                                            -webkit-border-top-right-radius: 10px; -moz-border-radius-topleft: 10px; -moz-border-radius-topright: 10px;
                                            width: 910px; margin-top: 10px;">
                                            <span style="font-size: 15px;">&nbsp; &nbsp; Permanent Return</span>
                                            <br />
                                            <table width="100%" border="0">
                                                <tr>
                                                    <td style="width: 10%;">
                                                        Activity
                                                    </td>
                                                    <td style="width: 10%;">
                                                        <asp:DropDownList runat="server" ID="ddlPermanentActivity" Width="150" AutoPostBack="true"
                                                            OnSelectedIndexChanged="ddlPermanentActivity_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td style="width: 17%">
                                                        Box BarCode
                                                    </td>
                                                    <td style="width: 10%">
                                                        <div class="ui-widget" style="width: 100%;">
                                                            <asp:HiddenField ID="hdnPermaBoxBarCode" runat="server" />
                                                            <asp:TextBox ID="txtPermBoxBarCode" runat="server" Style="width: 100px;" MaxLength="16"
                                                                onblur="autocompDrop(this.id,'#ContentPlaceHolder1_hdnPermaBoxBarCode');"></asp:TextBox>
                                                        </div>
                                                    </td>
                                                    <td style="width: 17%">
                                                        File Bar Code
                                                    </td>
                                                    <td style="width: 100%;">
                                                        <asp:TextBox ID="txtPermFileBarCode" runat="server" Style="width: 100px;" MaxLength="16"
                                                            onblur="autocompDropFile(this.id,'#ContentPlaceHolder1_hdnPermaBoxBarCode');"></asp:TextBox>
                                                        &nbsp; &nbsp;
                                                        <asp:Button runat="server" ID="btnPermanent" Text="ADD" OnClientClick="return ValidatePermanentBoxFile();"
                                                            OnClick="btnPermanent_Click" /><br />
                                                        <asp:CustomValidator ID="customvalidatePermannet" runat="server" OnServerValidate="Validate_Permanent"
                                                            ErrorMessage="Please select acitvity and box barcode!" InitialValue="0" ForeColor="Red"
                                                            ValidationGroup="SaveGroup"></asp:CustomValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" width="100%" align="right">
                                                        <asp:GridView runat="server" ID="gridPermanentActivityCount" AutoGenerateColumns="false"
                                                            CssClass="grid_data" Width="100%">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Activity Name">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblName" runat="server" Text="<%# ((ActivityListCount) Container.DataItem).ActivityName %>"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="60%"></ItemStyle>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Activity Count">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblActivityCount" runat="server" Text="<%# ((ActivityListCount) Container.DataItem).ActivityCount %>"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="40%" HorizontalAlign="Center"></ItemStyle>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="6" style="width: 100%">
                                                        <table width="100%" class="grid_data" border="0">
                                                            <tr>
                                                                <th style="width: 9%" align="left">
                                                                    Sr No.
                                                                </th>
                                                                <th align="left" style="width: 40%">
                                                                    Activity Name
                                                                </th>
                                                                <th style="width: 25%" align="left">
                                                                    Box Bar Code
                                                                </th>
                                                                <th style="width: 26%" align="left">
                                                                    File Bar Code
                                                                </th>
                                                            </tr>
                                                        </table>
                                                        <div style="overflow: auto; padding-left: 0px; color: #4f4f4f; font-size: 12px; width: 100%;
                                                            height: 180px; line-height: 20px;">
                                                            <asp:GridView runat="server" ID="gridPermanentActivity" AutoGenerateColumns="false"
                                                                CssClass="grid_data" Width="100%" ShowHeader="false">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Sr No.">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="9%"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Activity Name">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblName" runat="server" Text="<%# ((ActivityList) Container.DataItem).ActivityName %>"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="40%"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Box BarCode">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblBoxBarCode" runat="server" Text="<%# ((ActivityList) Container.DataItem).BoxBarCode %>"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="25%"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="File BarCode">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblFileBarCode" runat="server" Text="<%# ((ActivityList) Container.DataItem).FileBarCode %>"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="26%"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div runat="server" id="divDestruction" style="border: #e4e4e4 1px solid; -webkit-border-top-left-radius: 5px;
                                            -webkit-border-top-right-radius: 10px; -moz-border-radius-topleft: 10px; -moz-border-radius-topright: 10px;
                                            width: 910px; margin-top: 10px;">
                                            <span style="font-size: 15px;">&nbsp; &nbsp; Destruction </span>
                                            <br />
                                            <table width="100%" border="0">
                                                <tr>
                                                    <td style="width: 10%;">
                                                        Activity
                                                    </td>
                                                    <td style="width: 10%;">
                                                        <asp:DropDownList runat="server" ID="ddlDestructionActivity" Width="150" AutoPostBack="true"
                                                            OnSelectedIndexChanged="ddlDestructionActivity_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <%-- <td style="width: 17%">--%>
                                                    <%--  <asp:Label ID="lblBoxbarcode" runat="server" Text="Box BarCode" Visible="false"></asp:Label>
                                                        <asp:Label ID="lblFileCount" runat="server" Text="No Of Files" Visible="false"></asp:Label>--%>
                                                    <%-- </td>--%>
                                                    <td style="width: 10%;">
                                                        Box Bar Code
                                                    </td>
                                                    <td style="width: 10%">
                                                        <div class="ui-widget" style="width: 100%;">
                                                            <asp:HiddenField ID="DestructionSelectedValue" runat="server" />
                                                            <asp:TextBox ID="txtDestrBoxBarCode" runat="server" Style="width: 100px;" MaxLength="16"   onblur="autocompDrop(this.id,'#ContentPlaceHolder1_selectedValue');" ></asp:TextBox>
                                                           <%--   onblur="autocompDrop(this.id,'#ContentPlaceHolder1_selectedValue');</asp:TextBox>--%>
                                                        </div>
                                                    </td>
                                                    <td id="Td2" runat="server" style="width: 17%">
                                                        File Bar Code
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtDestrFileBarCode" runat="server" Style="width: 100px;" MaxLength="16"   onblur="autocompDropFile(this.id,'#ContentPlaceHolder1_selectedValue');"></asp:TextBox>
                                                          
                                                        &nbsp; &nbsp;
                                                        <asp:Button runat="server" ID="btnDestruction" Text="ADD"  OnClick="btnDestruction_Click" />
                                                   <%--     OnClientClick="return ValidateDestructionBoxFile();"--%>
                                                           
                                                        <br />
                                                        <asp:CustomValidator ID="customvalidateDestruction" runat="server" OnServerValidate="Validate_Destruction"
                                                            ErrorMessage="Please select acitvity and box barcode!" InitialValue="0" ForeColor="Red"
                                                            ValidationGroup="SaveGroup"></asp:CustomValidator>
                                                    </td>
                                                    <tr>
                                                        <td colspan="6">
                                                            <%--      <div id="divDestrBoxUploadControls" runat="server">
                                                                <table width="100%" border="0">
                                                                    <tr border="0">
                                                                        <td colspan="1">
                                                                            <asp:Label ID="lblDestrBox" runat="server" Text=" Select Box barcode excel file"></asp:Label>
                                                                        </td>
                                                                        <td colspan="3">
                                                                            <asp:FileUpload ID="FileUpload4" runat="server" onchange=" return validateFileUpload();" />
                                                                            <asp:Button ID="btnDestrBoxUpload" runat="server" Text="Box Upload" 
                                                                                OnClientClick="return validateFileUpload();" />
                                                                        </td>
                                                                        <td colspan="2">
                                                                            <asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl="~/ExcelSheetFormats/ExcelFormatBox.xlsx">Excel Format For box</asp:HyperLink>
                                                                            <br />
                                                                            <br />
                                                                            <br />
                                                                            <asp:Label ID="lblDestrErrorBox" runat="server"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>--%>
                                                            <div id="divDestrFileUploadControls" runat="server">
                                                                <table width="100%" border="0">
                                                                    <tr>
                                                                        <td colspan="1">
                                                                            <asp:Label ID="lblDestrFile" runat="server" Text="Select File barcode excel file"></asp:Label>
                                                                        </td>
                                                                        <td colspan="3">
                                                                            <asp:FileUpload ID="FileUpload5" runat="server" /> 
                                                                            <asp:Button ID="btnDestrFileUpload" runat="server" Text="File Upload" OnClick="btnDestrFileUpload_Click"
                                                                                OnClientClick="return validateDestrFileUpload();" />
                                                                        </td>
                                                                        <td colspan="2">
                                                                            <asp:HyperLink ID="HyperLink5" runat="server" NavigateUrl="~/ExcelSheetFormats/ExcelFormatFile.xlsx">Excel format for File</asp:HyperLink>
                                                                            <br />
                                                                            <br />
                                                                            <asp:Label ID="lblDstrFileErrorMsg" runat="server"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <%--<asp:HiddenField ID="hdnDestructionBoxbarid" runat="server" />
                                                      <asp:TextBox ID="txtDestructionBoxBarCode" runat="server" Style="width: 100px;" MaxLength="16"
                                                            onblur="autocompDrop(this.id,'ContentPlaceHolder1_hdnDestructionBoxbarid');"></asp:TextBox>
                                                     <asp:TextBox ID="txtDestructionFileCount" runat="server" Style="width: 130px;" MaxLength="16"
                                                            Visible="false"></asp:TextBox>
                                                        &nbsp; &nbsp;
                                                        <ajax:FilteredTextBoxExtender ID="fltrextndrFilecount" runat="server" FilterType="Numbers"
                                                            TargetControlID="txtDestructionFileCount">
                                                      </ajax:FilteredTextBoxExtender>
                                                     <td style="width: 17%">
                                                        <asp:Label ID="lblFilebarCode" runat="server" Text="File BarCode" Visible="false"></asp:Label>
                                                    </td>
                                                    <td style="width: 100%;">
                                               <asp:TextBox ID="txtDestructionFileBarCode" runat="server" Style="width: 100px;"
                                                            MaxLength="16" onchange="autocompDropFile(this.id,'#ContentPlaceHolder1_hdnDestructionBoxbarid');"></asp:TextBox>
                                                     &nbsp; &nbsp;
                                                        <asp:Button runat="server" ID="btnDestruction" Text="ADD" OnClientClick="return ValidateDestructionBoxFile();"
                                                            OnClick="btnDestruction_Click" />
                                                        <br />
                                                        <asp:CustomValidator ID="customvalidateDestruction" runat="server" OnServerValidate="Validate_Destruction"
                                                            ErrorMessage="Please select acitvity and box barcode!" InitialValue="0" ForeColor="Red"
                                                            ValidationGroup="SaveGroup"></asp:CustomValidator>
                                                    </td>--%>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" width="100%" align="right">
                                                        <asp:GridView runat="server" ID="GridDestructionActivityCount" AutoGenerateColumns="false"
                                                            CssClass="grid_data" Width="100%">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Activity Name">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblName" runat="server" Text="<%# ((DestructionActivityListCount) Container.DataItem).ActivityName %>"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="40%"></ItemStyle>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Activity Count">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblActivityCount" runat="server" Text="<%# ((DestructionActivityListCount) Container.DataItem).ActivityCount %>"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="40%" HorizontalAlign="Center"></ItemStyle>
                                                                </asp:TemplateField>
                                                                <%--<asp:TemplateField HeaderText="File Count">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblActivityCount" runat="server" Text="<%# ((DestructionActivityListCount) Container.DataItem).FileCount %>"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="20%" HorizontalAlign="Center"></ItemStyle>
                                                                </asp:TemplateField>--%>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </td>
                                                    <td colspan="2">
                                                        <asp:GridView ID="grdDestrErr" runat="server" CssClass="grid_data" AutoGenerateColumns="true"
                                                            Width="400px">
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="6" style="width: 100%">
                                                        <table width="100%" class="grid_data" border="0">
                                                            <tr>
                                                                <th style="width: 9%" align="left">
                                                                    Sr No.
                                                                </th>
                                                                <th align="left" style="width: 40%">
                                                                    Activity Name
                                                                </th>
                                                                <th style="width: 25%" align="left">
                                                                    Box Bar Code
                                                                </th>
                                                                <th style="width: 26%" align="left">
                                                                    File Bar Code
                                                                </th>
                                                            </tr>
                                                        </table>
                                                        <div style="overflow: auto; padding-left: 0px; color: #4f4f4f; font-size: 12px; width: 100%;
                                                            height: 180px; line-height: 20px;">
                                                            <asp:GridView runat="server" ID="GridDestructionActivity" AutoGenerateColumns="false"
                                                                CssClass="grid_data" Width="100%" ShowHeader="false">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Sr No.">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="9%"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Activity Name">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblName" runat="server" Text="<%# ((DestructionActivityList)Container.DataItem).ActivityName %>"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="40%"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Box BarCode">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblBoxBarCode" runat="server" Text="<%# ((DestructionActivityList) Container.DataItem).BoxBarCode %>"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="25%"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="File BarCode">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblFileBarCode" runat="server" Text="<%# ((DestructionActivityList) Container.DataItem).FileBarCode %>"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="26%"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div runat="server" id="divOtherServices" style="border: #e4e4e4 1px solid; -webkit-border-top-left-radius: 5px;
                                            -webkit-border-top-right-radius: 10px; -moz-border-radius-topleft: 10px; -moz-border-radius-topright: 10px;
                                            width: 910px; margin-top: 10px;">
                                            <span style="font-size: 15px;">&nbsp; &nbsp; Other Sevices &nbsp &nbsp;
                                                <asp:CustomValidator ID="CstmValidOtherServiceGrd" ErrorMessage="Please enter at least one service!"
                                                    ValidationGroup="SaveGroup" runat="server" OnServerValidate="Validate_OtherServices"
                                                    ForeColor="Red"></asp:CustomValidator></span>
                                            <br />
                                            <table width="100%" border="0">
                                                <tr>
                                                    <td width="95%">
                                                        <table width="100%" class="grid_data">
                                                            <tr>
                                                                <th style="width: 9%" align="left">
                                                                    Sr No.
                                                                </th>
                                                                <th align="left">
                                                                    Activity Name
                                                                </th>
                                                                <th style="width: 25%" align="left">
                                                                    No. Of Services
                                                                </th>
                                                            </tr>
                                                        </table>
                                                        <div style="overflow: auto; padding-left: 0px; color: #4f4f4f; font-size: 12px; width: 102%;
                                                            height: 200px; line-height: 20px;">
                                                            <asp:GridView runat="server" ID="grdOtherAddServiceActivity" AutoGenerateColumns="false"
                                                                Width="100%" CssClass="grid_data" ShowHeader="false" OnDataBound="grdOtherAddServiceActivity_DataBound"
                                                                OnRowDataBound="grdOtherAddServiceActivity_RowDataBound">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Sr No." ItemStyle-Width="7%">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="9%"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Activity Name">
                                                                        <ItemTemplate>
                                                                            <asp:HiddenField ID="hdnActivityid" runat="server" Value='<%# Eval("ActivityId") %>' />
                                                                            <asp:HiddenField ID="hdhServiceCategoryId" runat="server" Value='<%# Eval("ServiceCategoryId") %>' />
                                                                            <asp:Label ID="lblName" runat="server" Text='<%# Eval("ActivityName") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="No. Of Services">
                                                                        <ItemTemplate>
                                                                            <asp:LinkButton ID="lnkOtherServices" runat="server" NavigateUrl="~/ExcelSheetFormats/ExcelFormatFile.xlsx"
                                                                                Visible="false">Excel format for File</asp:LinkButton>
                                                                            <asp:TextBox ID="txtNoOfServices" runat="server" OnTextChanged="txtNoOfServices"
                                                                                AutoPostBack="true"></asp:TextBox>
                                                                            <ajax:FilteredTextBoxExtender ID="fltrextndr" runat="server" FilterType="Numbers"
                                                                                TargetControlID="txtNoOfServices">
                                                                            </ajax:FilteredTextBoxExtender>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="25%"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <AlternatingRowStyle CssClass="AlternativeRowStyle" />
                                                            </asp:GridView>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <%--     <div id="divFileUpload">--%>
                                        <table width="100%" border="0">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Lbllfile" runat="server" Text="Select File barcode excel file"></asp:Label>
                                                </td>
                                                <td colspan="3">
                                                    <asp:FileUpload ID="FileUpload3" runat="server" />
                                                    <asp:Button ID="btnFile" runat="server" Text="FileUpload" OnClick="btnFile_Click"
                                                        OnClientClick=" return validateFileUploadOS();" />
                                                    <asp:HyperLink ID="hlOtherServices" runat="server" NavigateUrl="~/ExcelSheetFormats/ExcelFormatFile.xlsx">Excel format for File</asp:HyperLink>
                                                </td>
                                                <td colspan="2">
                                                    <br />
                                                    <br />
                                                    <asp:Label ID="lblFileOtherServices" runat="server"></asp:Label>
                                                </td>
                                                <td width="100%">
                                                    <div style="display: none;" id="divotherservicefiledetails" runat="server">
                                                        <table width="100%">
                                                            <tr>
                                                                <td colspan="5">
                                                                    <div style="overflow: auto; padding-left: 0px; color: #4f4f4f; font-size: 12px; width: 100%;
                                                                        height: auto; line-height: 20px;">
                                                                        <asp:GridView runat="server" ID="grdOtherServicesFiles" AutoGenerateColumns="false"
                                                                            Visible="true" CssClass="grid_data" Width="100%" ShowHeader="true">
                                                                            <Columns>
                                                                                <asp:TemplateField HeaderText="Sr No.">
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'></asp:Label>
                                                                                    </ItemTemplate>
                                                                                    <ItemStyle Width="9%"></ItemStyle>
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Activity Name">
                                                                                    <ItemTemplate>
                                                                                        <asp:HiddenField ID="hdnActivityid" runat="server" Value='<%# Eval("ActivityId") %>' />
                                                                                        <asp:HiddenField ID="hdhServiceCategoryId" runat="server" Value='<%# Eval("ServiceCategoryId") %>' />
                                                                                        <asp:Label ID="lblName" runat="server" Text="<%# ((OtherServicesActivityList)Container.DataItem).ActivityName %>"></asp:Label>
                                                                                    </ItemTemplate>
                                                                                    <ItemStyle Width="40%"></ItemStyle>
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Box BarCode">
                                                                                    <ItemTemplate>
                                                                                        <asp:HiddenField ID="selectedValueOtherServices" runat="server" />
                                                                                        <asp:TextBox ID="txtotherServicesBoxBarCode" runat="server" Style="width: 100px;"
                                                                                            Text='<%# Eval("BoxBarCode") %>' MaxLength="16" onmousemove='<% #GetFunctionForBoxBarCode(Container.DataItemIndex)%>'
                                                                                            onblur='<% #GetFunctionForBoxBarCode(Container.DataItemIndex)%> '></asp:TextBox>
                                                                                    </ItemTemplate>
                                                                                    <ItemStyle Width="25%"></ItemStyle>
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="File BarCode">
                                                                                    <ItemTemplate>
                                                                                        <asp:TextBox ID="txtOtherServicesFileBarcode" runat="server" Style="width: 100px;"
                                                                                            Text='<%# Eval("FileBarCode") %>' MaxLength="16" onmousemove='<% #GetFunctionForFileBarCode(Container.DataItemIndex)%>'
                                                                                            onchange='<% #GetFunctionForFileBarCode(Container.DataItemIndex)%> ' onblur='<% #GetFunctionForFileBarCode(Container.DataItemIndex)%> '></asp:TextBox>
                                                                                    </ItemTemplate>
                                                                                    <ItemStyle Width="26%"></ItemStyle>
                                                                                </asp:TemplateField>
                                                                            </Columns>
                                                                        </asp:GridView>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                    <asp:GridView ID="gvOtherFileErr" runat="server">
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                        </table>
                                        <%--  </div>--%>
                                        <table width="100%">
                                            <tr>
                                                <td colspan="2">
                                                    <asp:GridView runat="server" ID="gvFilePickUpSRtoWO" AutoGenerateColumns="false"
                                                        CssClass="grid_data" Width="100%" Visible="false">
                                                        <Columns>
                                                            <asp:BoundField DataField="Department" HeaderText="Department" />
                                                            <asp:BoundField DataField="No. of Boxes" HeaderText="No. of Boxes" />
                                                            <asp:BoundField DataField="No. of Files" HeaderText="No. of Files" />
                                                            <asp:BoundField DataField="PickUp Address" HeaderText="PickUp Address" />
                                                            <%-- <asp:BoundField DataField="Date" HeaderText="Date" DataFormatString="{0:dd-MMM-yyyy}" />--%>
                                                            <asp:TemplateField HeaderText="Date">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtDate" runat="Server" Text='<%# Bind("[Date]","{0:dd-MMM-yyyy}") %>'
                                                                        CssClass="datepicker1"></asp:TextBox>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:GridView runat="server" ID="gvRetreivalSRtoWO" AutoGenerateColumns="true" CssClass="grid_data"
                                                        Width="100%" Visible="false">
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:GridView runat="server" ID="gvOtherServicesSRtoWO" AutoGenerateColumns="true"
                                                        CssClass="grid_data" Width="100%" Visible="false">
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Remark
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtRemark" runat="server" Style="width: 740px; height: 91
                                                        320px;" TextMode="MultiLine" onkeypress=" return textboxMultilineMaxNumber(this.id,500)"
                                                        onkeyup=" return textboxMultilineMaxNumber(this.id,500)"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Status
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlServiceStatus" runat="server" Width="200">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:Button ID="btnSave" runat="server" Text="Save" ValidationGroup="SaveGroup" OnClick="btnSave_Click"
                                                        OnClientClick="javascript:retrun CompareDocumentSearchingFileCount();" />
                                                    <asp:Button ID="btnCancel" runat="server" CausesValidation="false" Text="Clear" OnClick="btnCancel_Click" />
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <%--        Search Order..............................................................--%>
                    <div id="divSearchOrder" runat="server">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="15%" align="left">
                                    Company Group
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlSearchCG" runat="server" AutoPostBack="true" Width="210"
                                        OnSelectedIndexChanged="ddlSearchCG_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    <br />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="ddlCompanyGroup"
                                        Display="Dynamic" ErrorMessage="Please Select Company Group ." InitialValue="0"
                                        ForeColor="Red" ValidationGroup="SaveInWarddGroup"></asp:RequiredFieldValidator>
                                    <span id="SpnddlCompanyGroup" style="color: Red;"></span>
                                </td>
                                <td>
                                    &nbsp
                                </td>
                                <td>
                                    &nbsp
                                </td>
                            </tr>
                            <tr>
                                <td width="15%" align="left">
                                    Customer
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlSearchCGCustomer" runat="server" Width="210">
                                        <asp:ListItem Value="0" Text="--Select--"></asp:ListItem>
                                    </asp:DropDownList>
                                    <br />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="ddlSearchCGCustomer"
                                        ErrorMessage="Please Select Customer ." InitialValue="0" ForeColor="Red" ValidationGroup="SaveInWarddGroup"
                                        Display="Dynamic"></asp:RequiredFieldValidator>
                                    <span id="SpnddlCustomer" style="color: Red;"></span>
                                </td>
                                <td>
                                    Status
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlSearchStatus" runat="server" Width="100">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td width="15%" align="left">
                                    From Date
                                </td>
                                <td>
                                    <asp:TextBox ID="txtSearchFromDate" CssClass="datepicker1" runat="server" size="27"
                                        MaxLength="60" onkeypress="return false;" Width="190px" TabIndex="3"></asp:TextBox>
                                </td>
                                <td>
                                    End Date
                                </td>
                                <td>
                                    <asp:TextBox ID="txtSearchToDate" runat="server" size="27" MaxLength="60" CssClass="datepicker1"
                                        onkeypress="return false;" Width="190px" TabIndex="4"></asp:TextBox><br />
                                </td>
                            </tr>
                            <tr>
                                <td align="left" colspan="4" width="100%">
                                    <asp:Button ID="btnSearch" runat="server" Text="Search" Style="margin-top: 0px;"
                                        OnClientClick="return valdSearchWOrder();" OnClick="btnSearch_Click" />
                                    &nbsp;&nbsp; &nbsp;
                                    <asp:Button ID="btnSearchClear" runat="server" Text="Clear" OnClientClick="return clearSearchfields();"
                                        OnClick="btnSearchClear_Click" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" width="100%">
                                    <div>
                                        <asp:GridView ID="gdvSearchWorkOrder" runat="server" AutoGenerateColumns="False"
                                            AllowPaging="true" PageSize="10" Width="100%" CssClass="grid_data" GridLines="None"
                                            OnRowCommand="gdvSearchWorkOrder_RowCommand" OnPageIndexChanging="gdvSearchWorkOrder_PageIndexChanging">
                                            <EmptyDataTemplate>
                                                <span style="text-align: center;">
                                                    <asp:Label ID="lblmsg" Text="No Record Found" Font-Size="14px" Font-Bold="true" Style="text-align: center"
                                                        ForeColor="Red" runat="server"></asp:Label>
                                                </span>
                                            </EmptyDataTemplate>
                                            <EmptyDataRowStyle HorizontalAlign="Center" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="Sr No." ItemStyle-Width="5%">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle Width="5%"></ItemStyle>
                                                </asp:TemplateField>
                                                <asp:BoundField HeaderText="Work Order No." ItemStyle-Width="10%" DataField="WorkOrderNo" />
                                                <asp:TemplateField HeaderText="Date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblWODate" runat="server" Text='<%#Eval("WorkOrderDate") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField HeaderText="Customer Name" ItemStyle-Width="35%" DataField="CustomerName" />
                                                <asp:TemplateField HeaderText="Remark">
                                                    <ItemTemplate>
                                                        <div style="overflow: auto; width: 300px; height: auto; text-align: justify; vertical-align: top">
                                                            <asp:Label ID="lblremark" runat="server" Text='<%#Eval("Remarks") %>'></asp:Label>
                                                        </div>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField HeaderText="Status" DataField="WoStatus" />
                                                <asp:TemplateField HeaderText="">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkbtnview" runat="server" Text="View Details" CommandArgument='<%#Eval("WorkOrderNo")%>'
                                                            CommandName="lnkview" Font-Underline="false" Style="cursor: pointer" />
                                                    </ItemTemplate>
                                                    <ItemStyle Width="9%"></ItemStyle>
                                                </asp:TemplateField>
                                            </Columns>
                                            <AlternatingRowStyle CssClass="AlternativeRowStyle" />
                                        </asp:GridView>
                                    </div>
                                    <div id="divShowWodetails" class="divActivityRate" style="width: 910px !important;">
                                        <div style="float: right">
                                            <asp:HyperLink Text="close" ForeColor="Blue" runat="server" Style="cursor: pointer"
                                                ID="HyperLink1" onclick=" divHideWodetails();"></asp:HyperLink>
                                        </div>
                                        <br />
                                        &nbsp;&nbsp;<asp:Button ID="btnGenerate" runat="server" OnClick="btnGenerate_Click"
                                            Text="Generate" class="rightAlign" />
                                        <div id="PrintdivShowWodetails" style="overflow: auto; padding-left: 15px; color: #4f4f4f;
                                            font-size: 12px; width: 900px; height: 450px; line-height: 20px;">
                                            <table style="text-align: left; width: 100%; height: auto;" border="0">
                                                <tr>
                                                    <td colspan="6" style="text-align: center;">
                                                        Work Order
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left" style="width: 13%;">
                                                        Customer
                                                    </td>
                                                    <td style="width: 1px;">
                                                        :
                                                    </td>
                                                    <td align="left">
                                                        <asp:Label runat="server" ID="lblSearchCustomer"></asp:Label>
                                                    </td>
                                                    <td align="left" width="90px">
                                                        Work Order No.
                                                    </td>
                                                    <td style="width: 1px;">
                                                        :
                                                    </td>
                                                    <td style="width: 220px;">
                                                        <asp:Label runat="server" ID="lbldisplayWorkororderNo"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left" valign="top">
                                                        Address
                                                    </td>
                                                    <td style="width: 1px;" valign="top">
                                                        :
                                                    </td>
                                                    <td align="left">
                                                        <asp:Label runat="server" ID="lb1CustomerAddress"></asp:Label>
                                                    </td>
                                                    <td align="left" valign="top">
                                                        Date
                                                    </td>
                                                    <td style="width: 1px;" valign="top">
                                                        :
                                                    </td>
                                                    <td align="left" valign="top">
                                                        <asp:Label runat="server" ID="lblSearchDate"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                    </td>
                                                    <td>
                                                    </td>
                                                    <td align="left">
                                                        <asp:Label runat="server" ID="lblContactPersonAndNumber"></asp:Label>
                                                        <br />
                                                    </td>
                                                    <td align="left">
                                                        Status
                                                    </td>
                                                    <td>
                                                        :
                                                    </td>
                                                    <td align="left">
                                                        <asp:Label runat="server" ID="lblSearchStatus"></asp:Label>
                                                    </td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td style="width: 1px;">
                                </td>
                                <td>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="lblClosdate" Visible="false" Text="Close Date"></asp:Label>
                                </td>
                                <td style="width: 1px;">
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="lblWoCloseDate" Visible="false"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" valign="top" style="width: 1px;">
                                </td>
                                <td valign="top">
                                </td>
                                <td align="left" style="width: auto;" valign="top">
                                    <asp:Label runat="server" ID="lblPickAddress"></asp:Label>
                                </td>
                                <td colspan="3">
                                    <table>
                                        <tr>
                                            <td>
                                                <strong>Requested Activity</strong>
                                            </td>
                                        </tr>
                                        <tr style="border-bottom: none;">
                                            <td style="border-bottom: none;">
                                                <asp:CheckBoxList ID="chkRequestedActivity" runat="server" Width="360px" Enabled="false"
                                                    RepeatDirection="Horizontal" RepeatColumns="2">
                                                </asp:CheckBoxList>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <div runat="server" id="diviewFilepickup" style="border: #e4e4e4 1px solid; -webkit-border-top-left-radius: 5px;
                            -webkit-border-top-right-radius: 10px; -moz-border-radius-topleft: 10px; -moz-border-radius-topright: 10px;
                            width: 100%; margin-top: 10px;">
                            <span style="font-size: 15px;">&nbsp; &nbsp; File Pickup </span>
                            <br />
                            <asp:GridView runat="server" ID="grdFPActivityDetails" AutoGenerateColumns="false"
                                CssClass="grid_data" Width="100%">
                                <Columns>
                                    <asp:TemplateField HeaderText="No. Of Boxes">
                                        <ItemTemplate>
                                            <asp:Label ID="lblFPBoxCount" runat="server" Text='<%# Eval("BoxCount") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="10%"></ItemStyle>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="No. Of Files">
                                        <ItemTemplate>
                                            <asp:Label ID="lb1FPFileCount" runat="server" Text='<%# Eval("FileCount") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="10%"></ItemStyle>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Department">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDepartment" runat="server" Text='<%# Eval("Department") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="15%"></ItemStyle>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="PickUp Address">
                                        <ItemTemplate>
                                            <asp:HiddenField ID="hdnWoActivityId" runat="server" Value='<%# Eval("WoActivityId") %>' />
                                            <asp:Label ID="lblAddress" runat="server" Text='<%# Eval("PickUpAddress") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="25%"></ItemStyle>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Contact Person">
                                        <ItemTemplate>
                                            <asp:Label ID="lblContactPerson" runat="server" Text='<%# Eval("AuthorisedPerson") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="20%"></ItemStyle>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Mobile No.">
                                        <ItemTemplate>
                                            <asp:Label ID="lblMobileNo" runat="server" Text='<%# Eval("AuthPMobileNo") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="10%"></ItemStyle>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                        <div runat="server" id="diviewRetrival" style="border: #e4e4e4 1px solid; -webkit-border-top-left-radius: 5px;
                            -webkit-border-top-right-radius: 10px; -moz-border-radius-topleft: 10px; -moz-border-radius-topright: 10px;
                            width: 810px; margin-top: 10px;">
                            <span style="font-size: 15px;">&nbsp; &nbsp; Retrival </span>
                            <br />
                            <table width="100%" border="0">
                                <tr>
                                    <td width="100%">
                                        <asp:GridView runat="server" ID="grddisplayActivityCount" AutoGenerateColumns="false"
                                            CssClass="grid_data" Width="90%" ShowHeader="true">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Activity Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblName" runat="server" Text='<%# Eval("ActivityName") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle Width="295px" CssClass="nopadding"></ItemStyle>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Count">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblActivityCount" runat="server" Text='<%# Eval("ActivityCount") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle Width="295px" CssClass="nopadding"></ItemStyle>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Status">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblWoActivityStatus" runat="server" Text='<%# Eval("WoActivityStatus") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle Width="295px" CssClass="nopadding"></ItemStyle>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                        <br />
                                        <div id="diviewRetrievalDetail" style="overflow: auto; width: 100%; padding: 0px;
                                            margin: 0px; height: 180px;">
                                            <asp:GridView runat="server" ID="grddisplayRetrivalActivity" AutoGenerateColumns="false"
                                                CssClass="grid_data" Width="100%" ShowHeader="true">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Sr No.">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="5%"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="PickUp Address">
                                                        <ItemTemplate>
                                                            <div style="overflow: auto; padding-left: 0px; color: #4f4f4f; width: 100%; height: 40px;">
                                                                <asp:Label ID="lblPickUpAddress" runat="server" Text='<%# Eval("PickUpAddress") %>'></asp:Label>
                                                            </div>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="35%"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Activity Name">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblName" runat="server" Text='<%# Eval("ActivityName") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="30%"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Box BarCode">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblBoxBarCode" runat="server" Text='<%# Eval("BoxBarCode") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="15%"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="File BarCode">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblFileBarCode" runat="server" Text='<%# Eval("FileBarCode") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="15%"></ItemStyle>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div runat="server" id="diviewOtherServices" style="border: #e4e4e4 1px solid; -webkit-border-top-left-radius: 5px;
                            -webkit-border-top-right-radius: 10px; -moz-border-radius-topleft: 10px; -moz-border-radius-topright: 10px;
                            width: 810px; margin-top: 10px;">
                            <span style="font-size: 15px;">&nbsp; &nbsp; Other Sevices </span>
                            <br />
                            <table width="100%" border="0">
                                <tr>
                                    <td width="95%">
                                        <div style="overflow: auto; padding-left: 0px; color: #4f4f4f; font-size: 12px; width: 100%;
                                            height: 180px; line-height: 20px;">
                                            <asp:GridView runat="server" ID="grdOtherServiceActivity" AutoGenerateColumns="false"
                                                Width="100%" CssClass="grid_data">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Sr No." ItemStyle-Width="7%">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="7%"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Activity Name">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblName" runat="server" Text='<%# Eval("ActivityName") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="No. Of Services">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblFileCount" runat="server" Text='<%# Eval("FileCount") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="25%"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Status">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblOStatus" runat="server" Text='<%# Eval("WoActivityStatus") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="25%"></ItemStyle>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <AlternatingRowStyle CssClass="AlternativeRowStyle" />
                                            </asp:GridView>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="95%">
                                        <div style="overflow: auto; padding-left: 0px; color: #4f4f4f; font-size: 12px; width: 100%;
                                            height: 180px; line-height: 20px;">
                                            <asp:GridView runat="server" ID="grdOtherServiceActivities" AutoGenerateColumns="false"
                                                Width="100%" CssClass="grid_data">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Sr No." ItemStyle-Width="7%">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="7%"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Activity Name">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblName" runat="server" Text='<%# Eval("ActivityName") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Box BarCode">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblBoxBarCode" runat="server" Text='<%# Eval("BoxBarCode") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="25%"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="File BarCode">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblFileBarCode" runat="server" Text='<%# Eval("FileBarCode") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="25%"></ItemStyle>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <AlternatingRowStyle CssClass="AlternativeRowStyle" />
                                            </asp:GridView>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div runat="server" id="diviewDestruction" style="border: #e4e4e4 1px solid; -webkit-border-top-left-radius: 5px;
                            -webkit-border-top-right-radius: 10px; -moz-border-radius-topleft: 10px; -moz-border-radius-topright: 10px;
                            width: 810px; margin-top: 10px;">
                            <span style="font-size: 15px;">&nbsp; &nbsp; Destruction </span>
                            <br />
                            <table width="100%" border="0">
                                <tr>
                                    <td width="100%">
                                        <asp:GridView runat="server" ID="gvDestructionActivityCount" AutoGenerateColumns="false"
                                            CssClass="grid_data" Width="50%" ShowHeader="true">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Activity Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblName" runat="server" Text='<%# Eval("ActivityName") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle Width="295px" CssClass="nopadding"></ItemStyle>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Count">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblActivityCount" runat="server" Text='<%# Eval("ActivityCount") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle Width="295px" CssClass="nopadding"></ItemStyle>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Status">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lb1ActivityStatus" runat="server" Text='<%# Eval("WoActivityStatus") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle Width="295px" CssClass="nopadding"></ItemStyle>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                        <br />
                                        <div id="diviewDestructionVoverfolow" style="overflow: auto; width: 100%; padding: 0px;
                                            height: 180px; margin: 0px;">
                                            <asp:GridView runat="server" ID="gvDestructionActivity" AutoGenerateColumns="false"
                                                CssClass="grid_data" Width="100%" ShowHeader="true">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Sr No." ItemStyle-Width="60px">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="60px"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Activity Name">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblName" runat="server" Text='<%# Eval("ActivityName") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="295px"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Box BarCode">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblBoxBarCode" runat="server" Text='<%# Eval("BoxBarCode") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="190px"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="File BarCode">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblFileBarCode" runat="server" Text='<%# Eval("FileBarCode") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div runat="server" id="diviewPerRetn" style="border: #e4e4e4 1px solid; -webkit-border-top-left-radius: 5px;
                            -webkit-border-top-right-radius: 10px; -moz-border-radius-topleft: 10px; -moz-border-radius-topright: 10px;
                            width: 810px; margin-top: 10px;">
                            <span style="font-size: 15px;">&nbsp; &nbsp; Parmanent Return </span>
                            <br />
                            <table width="100%" border="0">
                                <tr>
                                    <td width="100%">
                                        <asp:GridView runat="server" ID="gvParmanentReturnActivityCount" AutoGenerateColumns="false"
                                            CssClass="grid_data" Width="50%" ShowHeader="true">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Activity Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblName" runat="server" Text='<%# Eval("ActivityName") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle Width="295px" CssClass="nopadding"></ItemStyle>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Count">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblActivityCount" runat="server" Text='<%# Eval("ActivityCount") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle Width="295px" CssClass="nopadding"></ItemStyle>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Status">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lb1ActivityStatus" runat="server" Text='<%# Eval("WoActivityStatus") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle Width="295px" CssClass="nopadding"></ItemStyle>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                        <br />
                                        <div id="diviewPerRetnOverFlow" style="overflow: auto; width: 100%; padding: 0px;
                                            margin: 0px; height: 180px;">
                                            <asp:GridView runat="server" ID="gvParmanentReturnActivity" AutoGenerateColumns="false"
                                                CssClass="grid_data" Width="100%" ShowHeader="true">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Sr No." ItemStyle-Width="60px">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="60px"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Activity Name">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblName" runat="server" Text='<%# Eval("ActivityName") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="295px"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Box BarCode">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblBoxBarCode" runat="server" Text='<%# Eval("BoxBarCode") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="190px"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="File BarCode">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblFileBarCode" runat="server" Text='<%# Eval("FileBarCode") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                <div id="blocker" style="display: none">
                    <div>
                    </div>
                </div>
            </div>
            </td> </tr> </table> </div>
            <%---------  update work order activities   --%>
            <div id="divUpdateWoActivity" runat="server">
                <table width="100%">
                    <tr>
                        <td style="height: 39px">
                            WareHouse
                        </td>
                        <td colspan="3" style="height: 39px">
                            <asp:DropDownList ID="ddlWareHouseUpdate" runat="server" Width="100" AutoPostBack="true"
                                OnSelectedIndexChanged="ddlWareHouseUpdate_SelectedIndexChanged">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="ddlWareHouseUpdate"
                                ErrorMessage="Please Select Warehouse." InitialValue="0" ForeColor="Red" ValidationGroup="UpdateGroup"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Company Group
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlCompanyGroupUpdate" runat="server" Width="200" AutoPostBack="true"
                                OnSelectedIndexChanged="ddlCompanyGroupUpdate_SelectedIndexChanged">
                            </asp:DropDownList>
                            <br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="ddlCompanyGroupUpdate"
                                ErrorMessage="Please Select Company Group." InitialValue="0" ForeColor="Red"
                                ValidationGroup="UpdateGroup"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            Customer
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlCustomerUpdate" runat="server" Width="200" AutoPostBack="true"
                                OnSelectedIndexChanged="ddlCustomerUpdate_SelectedIndexChanged">
                            </asp:DropDownList>
                            <br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="ddlCustomerUpdate"
                                ErrorMessage="Please Select Customer." InitialValue="0" ForeColor="Red" ValidationGroup="UpdateGroup"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Work Order
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlWorkOrder" runat="server" Width="200" OnSelectedIndexChanged="ddlWorkOrder_SelectedIndexChanged"
                                AutoPostBack="True">
                            </asp:DropDownList>
                            <br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="ddlWorkOrder"
                                ErrorMessage="Please Select Work Order." InitialValue="0" ForeColor="Red" ValidationGroup="UpdateGroup"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            Requested Services
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlRequestedService" runat="server" Width="200" OnSelectedIndexChanged="ddlRequestedService_SelectedIndexChanged"
                                AutoPostBack="True">
                            </asp:DropDownList>
                            <br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="ddlRequestedService"
                                ErrorMessage="Please Select Service." InitialValue="0" ForeColor="Red" ValidationGroup="UpdateGroup"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:HiddenField ID="hfRSemailid" runat="server" />
                        </td>
                        <td>
                            <asp:HiddenField ID="hfRequestedService" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Activity Remark
                        </td>
                        <td>
                            <asp:TextBox ID="txtActivityRemarkUpdate" Enabled="false" runat="server" TextMode="MultiLine"></asp:TextBox>
                        </td>
                        <td>
                            Status
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlStatusUpdate" runat="server" Width="200" AutoPostBack="true"
                                OnSelectedIndexChanged="ddlStatusUpdate_SelectedIndexChanged">
                            </asp:DropDownList>
                            <br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="ddlStatusUpdate"
                                ErrorMessage="Please Select Status." InitialValue="0" ForeColor="Red" ValidationGroup="UpdateGroup"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" width="100%" align="center">
                            <div style="overflow: auto; width: 100%; padding: 0px; height: 180px; margin: 0px;">
                                <asp:GridView runat="server" ID="grdWoOrderUpdFilePickupActivities" AutoGenerateColumns="false"
                                    CssClass="grid_data" Width="100%" OnRowDataBound="grdWoOrderUpdFilePickupActivities_RowDataBound">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Sr No.">
                                            <ItemTemplate>
                                                <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle Width="5%"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Department">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDepartment" runat="server" Text='<%# Eval("Department") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle Width="10%"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="PickUp Address">
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hdnWoActivityId" runat="server" Value='<%# Eval("WoActivityId") %>' />
                                                <asp:Label ID="lblAddress" runat="server" Text='<%# Eval("PickUpAddress") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle Width="30%"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Activity">
                                            <ItemTemplate>
                                                <asp:Label ID="lblActivity" runat="server" Text='<%# Eval("ActivityName") %>'></asp:Label>
                                                <br />
                                                <asp:CheckBox runat="server" ID="chkActual" Text="Lump Sum Amount" Style="width: 50px;
                                                    text-align: center;" Enabled="true" Visible="false" OnCheckedChanged="chkActual_CheckedChanged"
                                                    AutoPostBack="true" />
                                                <asp:TextBox ID="txtUpdateLumsumAount" runat="server" Style="width: 80px; height: 10px;"
                                                    MaxLength="8" Enabled="false"></asp:TextBox>
                                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" FilterType="Numbers"
                                                    TargetControlID="txtUpdateLumsumAount">
                                                </ajax:FilteredTextBoxExtender>
                                                <br />
                                                <asp:RegularExpressionValidator ControlToValidate="txtUpdateLumsumAount" ID="regExVal"
                                                    runat="server" ErrorMessage="Amount should be grater than 0." ForeColor="Red"
                                                    ValidationExpression="^[1-9][0-9]*(\.[0-9]+)?|0+\.[0-9]*[1-9][0-9]*$" />
                                            </ItemTemplate>
                                            <ItemStyle Width="27%"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="No. Of Boxes">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtBoxCount" runat="server" Style="width: 50%;" MaxLength="8" Text='<%# Eval("BoxCount") %>'
                                                    onkeyup="return changeCells( this, this.id,event)" ReadOnly="true"></asp:TextBox>
                                                <ajax:FilteredTextBoxExtender ID="fvrBoxCount" runat="server" FilterType="Numbers"
                                                    TargetControlID="txtBoxCount">
                                                </ajax:FilteredTextBoxExtender>
                                            </ItemTemplate>
                                            <ItemStyle Width="15%"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="No. Of Files">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtFileCount" runat="server" Style="width: 50%;" MaxLength="8" Text='<%# Eval("FileCount") %>'
                                                    onkeyup="return changeCells( this, this.id,event)" ReadOnly="true"></asp:TextBox>
                                                <ajax:FilteredTextBoxExtender ID="fvrFileCount" runat="server" FilterType="Numbers"
                                                    TargetControlID="txtFileCount">
                                                </ajax:FilteredTextBoxExtender>
                                            </ItemTemplate>
                                            <ItemStyle Width="15%"></ItemStyle>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="bordnone" colspan="2">
                            <asp:Button ID="btnSubmit" ValidationGroup="UpdateGroup" runat="server" Text="Save"
                                OnClick="btnSubmit_Click" />
                            <asp:Button ID="BtnClear" runat="server" Text="Clear" OnClick="BtnClear_Click" />
                        </td>
                    </tr>
            </div>
            <asp:HiddenField ID="hdnSearcheSrequestId" runat="server" />
            <asp:HiddenField ID="hdnSearchCustId" runat="server" />
            <asp:HiddenField ID="hdnwoactivityid" runat="server" />
            <asp:HiddenField ID="hdnUserId" runat="server" />
            <asp:HiddenField ID="hdnTotalAddedActivity" runat="server" />
            <asp:HiddenField ID="hdnboxfilestatus" runat="server" />
            <asp:HiddenField ID="hdnfilestatus" runat="server" />
            <asp:HiddenField ID="hdPickup_filecount" runat="server" />
            <asp:HiddenField ID="hdPickup_boxcount" runat="server" />
            <asp:HiddenField ID="hdRetrival_filecount" runat="server" />
            <asp:HiddenField ID="hdRetrival_boxcount" runat="server" />
            <asp:HiddenField ID="hdRestore_filecount" runat="server" />
            <asp:HiddenField ID="hdRestore_boxcount" runat="server" />
            </div>
            <div class="clear">
            </div>
            <caption>
                <br />
                <div id="loading-div-background" style="display: none;">
                    <div id="loading-div" class="ui-corner-all" style="background-color: White !important;
                        height: 300px;">
                        <img style="height: 70px; margin: 30px;" src="../images/loading.gif" alt="Loading.." />
                        <h2 style="color: Gray; font-weight: normal;">
                            Please wait....</h2>
                    </div>
                </div>
            </caption>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnFile" />
            <asp:PostBackTrigger ControlID="btnBoxUpload" />
            <asp:PostBackTrigger ControlID="btnFileUpload" />
            <asp:PostBackTrigger ControlID="btnGenerate" />
            <asp:PostBackTrigger ControlID="gdvSearchWorkOrder" />
            <asp:PostBackTrigger ControlID="btnDestrFileUpload" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
