<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddNewFile.aspx.cs" Inherits="Transaction_AddNewFile"
    CodeBehind="~/Transaction/AddNewFile.aspx.cs" EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server" id="Head1">
    <meta http-equiv="X-UA-Compatible" content="IE=8;IE=9;FF=3;OtherUA=4" />
    <base target="_self" />
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <link href="../Scripts/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/1.10.4-jquery-ui.js" type="text/javascript"></script>
    <script src="../Scripts/FilePickupReport.js" type="text/javascript"></script>
    <%-- <link href="../Scripts/1.10.4-themes-smoothness-jquery-ui.css" rel="stylesheet" type="text/css" />--%>
    <%--<script src="../Scripts/jquery.maskedinput-1.3.1.min_.js" type="text/javascript"></script>--%>
    <%-- <link href="../Scripts/jquery-ui.css" rel="stylesheet" type="text/css" />--%>
    <link href="../Styles/style.css" rel="stylesheet" type="text/css" />
    <%--  <link href="../Styles/scrollableFixedHeaderTable.css" rel="stylesheet" type="text/css" />--%>
    <%--
       <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.1/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.1/jquery-ui.min.js"></script>
      
       <script language="javascript"  type="text/javascript">
           function autocompleteBC(control) {
          $("#txtBoxBarCode").autocomplete({
                source: function(request, response) {
                    $.ajax({
                        url: "AddNewFile.aspx/GetBoxBarCode",
                        data: "{'prefixText':'" + $('#txtBoxBarCode').val + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataFilter: function(data) { return data; },
                        success: function(data) {
                            response(data.d);
                        },
                        Error: function(results) {
                            alert("Error");
                        },
                        close: function(event, ui) {
                            $("txtBoxBarCode").data().term = null; // Clear the cached search term, make every search new
                        }
                    });
                }
            });

        }
       
       </script>--%>
    <script type="text/javascript">

        function DateCheck() {

            var Fdate = document.getElementById('txtFdate').value;
            var Edate = document.getElementById('txtEdate').value;

            //               var sDate = new Date(empname1);
            //               var eDate = new Date(empname2);

            if (Fdate.trim() > Edate.trim()) {

                alert("Please ensure that the End Date is greater than or equal to the Start Date.");
                return false;
            }


            //               var StartDate = document.getElementById("txtFdate").value;
            //               var EndDate = document.getElementById("txtEdate").value;
            //               var eDate = new Date(EndDate);
            //               var sDate = new Date(StartDate);
            //               if (StartDate.trim() != '' && StartDate.trim() != '' && sDate.trim() > eDate.trim()) {
            //                   alert("Please ensure that the End Date is greater than or equal to the Start Date.");
            //                   return false;
            //               }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <script type="text/javascript">
        Sys.Application.add_load(BindDates);
    </script>
    <asp:ScriptManager ID="sm1" runat="server">
    </asp:ScriptManager>
    <div align="center">
        <asp:Panel ID="Panel2" runat="server"  Font-Size="Medium">
            <table runat="server" id="tabAddEditFile" cellpadding="0" cellspacing="0" align="center"
                width="92%">
                <tr>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#80FFFF" style="width: 100%" valign="Top" align="center">
                        <asp:Label ID="Label1" runat="server" Font-Bold="True" Text="Add/Edit File Details"
                            ForeColor="#FF9900"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <br />
                        <br />
                    </td>
                </tr>
                <tr id="trNewFile" runat="server">
                    <td>
                        <table width="100%" style="border: 2px" border="0">
                            <tr>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="width: 50%">
                                    <asp:Image ID="imgFile" runat="server"  />
                                    <%--<asp:Image ID="Image1" runat="server" ImageUrl="~/images/Test/box2.jpg" />
                                    <asp:Image ID="Image2" runat="server" ImageUrl="e:/image/Penguins.jpeg" />--%>
                                </td>
                                <td colspan="2" style="width: 50%">
                                    <table>
                                        <tr>
                                            <td style="width: 14%" align="left">
                                                Box BarCode <span style="color: #FF0000">*</span>
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtBoxBarCode" runat="server" Width="150px" MaxLength="16"></asp:TextBox>
                                                <br />
                                                <asp:RequiredFieldValidator ID="rfvTxtBoxBarCode" runat="server" ControlToValidate="txtBoxBarCode"
                                                    Display="Dynamic" ErrorMessage="Please enter Box BarCode." ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                                                <asp:AutoCompleteExtender ID="aceBoxBarCode" runat="server" TargetControlID="txtBoxBarCode"
                                                    MinimumPrefixLength="1" EnableCaching="true" CompletionSetCount="1" CompletionInterval="1000"
                                                    ServiceMethod="GetBoxBarCode"></asp:AutoCompleteExtender>
                                            </td>
                                            <td style="width: 20%" align="left">
                                                File BarCode <span style="color: #FF0000">*</span>
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtFileBarCode" runat="server" Width="150px" MaxLength="16"></asp:TextBox>
                                                <br />
                                                <asp:RequiredFieldValidator ID="rfvTxtFileBarCode" runat="server" ControlToValidate="txtFileBarCode"
                                                    Display="Dynamic" ErrorMessage="Please enter File BarCode." ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 14%" align="left">
                                                File Description1
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtFileDesc1" runat="server" Width="150px" MaxLength="255"></asp:TextBox>
                                                <br />
                                            </td>
                                            <td style="width: 20%" align="left">
                                                File Description2
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtFileDesc2" runat="server" Width="150px" MaxLength="255"></asp:TextBox>
                                                <br />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 14%" align="left">
                                                Department<span style="color: #FF0000">*</span>
                                            </td>
                                            <td align="left">
                                                <asp:DropDownList ID="ddlDepart" runat="server" Width="155px" MaxLength="100">
                                                </asp:DropDownList>
                                                <br />
                                                <asp:RequiredFieldValidator ID="RFVddlDepart" runat="server" ControlToValidate="ddlDepart"
                                                    Display="Dynamic" ErrorMessage="Please Select Department." ForeColor="Red" ValidationGroup="SaveGroup"
                                                    InitialValue="0" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            </td>
                                            <td style="width: 20%" align="left">
                                                Year
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtyear" runat="server" Width="150px" MaxLength="10"> </asp:TextBox>
                                                <br />
                                                <ajax:FilteredTextBoxExtender ID="fltrYearModify" runat="server" FilterType="Numbers,Custom"
                                                    ValidChars="-" TargetControlID="txtyear">
                                                </ajax:FilteredTextBoxExtender>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 14%" align="left">
                                                From Date
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtFdate" runat="server" Width="150px" MaxLength="10" CssClass="datepicker1"
                                                    onkeypress="return false;"></asp:TextBox>
                                                <br />
                                            </td>
                                            <td style="width: 20%" align="left">
                                                To Date
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtEdate" runat="server" Width="150px" MaxLength="10" CssClass="datepicker1"></asp:TextBox>
                                                <br />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 14%" align="left">
                                                File Type
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtFileType" runat="server" Width="150px" MaxLength="100"></asp:TextBox>
                                                <br />
                                                <ajax:FilteredTextBoxExtender ID="fltrLable1Modify" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                                    ValidChars=" -" TargetControlID="txtFileType" />
                                            </td>
                                            <td style="width: 20%" align="left">
                                                From Number
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtFormNum" runat="server" Width="150px" MaxLength="100"></asp:TextBox>
                                                <ajax:FilteredTextBoxExtender ID="fltrLable2Modify" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                                    ValidChars=" -" TargetControlID="txtFormNum" />
                                                <br />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 14%" align="left">
                                                To Number
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtToNum" runat="server" Width="150px" MaxLength="100"></asp:TextBox>
                                                <ajax:FilteredTextBoxExtender ID="fltrLable3Modify" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                                    ValidChars=" -" TargetControlID="txtToNum" />
                                                <br />
                                            </td>
                                            <td style="width: 20%" align="left">
                                                Destruction Due Date
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtDestructionDueDate" runat="server" Width="150px" ValidationGroup="SaveGroup"
                                                    MaxLength="10" CssClass="datepicker1" onkeypress="return false;"></asp:TextBox>
                                                <br />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4">
                                                <br />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" colspan="4">
                                                <asp:Button ID="btnAddFile" runat="server" Text="Save File" ToolTip="Save File" OnClick="btnAddFile_Click"
                                                    ValidationGroup="SaveGroup" OnClientClick="return  DateCheck();" />
                                                &nbsp;&nbsp;
                                                <asp:Button ID="btnSaveNext" runat="server" Text="Save & Next" ToolTip="Save & Next"
                                                    Width="100px" ValidationGroup="SaveGroup" OnClick="btnSaveNext_Click" />
                                                &nbsp;&nbsp;
                                                <asp:Button ID="btnNext" runat="server" Text="Next" ToolTip="Read Next Record" Width="70px"
                                                    ValidationGroup="SaveGroup" OnClick="btnNext_Click" />
                                                &nbsp;&nbsp;
                                                <asp:Button ID="btnClose" runat="server" CssClass="btnbg" Text="Close" ToolTip="Close Window"
                                                    Width="70px" OnClientClick="javascript:self.close(); return false;" CausesValidation="false" />&nbsp;
                                                <input id="hdnMode" runat="server" type="hidden" value="" />
                                            </td>
                                            <%--<td>                                
                            </td>--%>
                                        </tr>
                                        <tr>
                                            <td colspan="4">
                                                <asp:Label ID="lblMesg" runat="server" Text=""></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4">
                                                <asp:HiddenField ID="hdnFileID" runat="server" />
                                                <%--<asp:HiddenField ID="hfCustomerId" runat="server" />
                                                <asp:HiddenField ID="hfCompanyId" runat="server" />
                                                <asp:HiddenField ID="hfImageExtention" runat="server" />--%>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </div>
    </form>
</body>
</html>
