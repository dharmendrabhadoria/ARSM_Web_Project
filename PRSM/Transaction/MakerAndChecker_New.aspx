<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true" CodeFile="MakerAndChecker_New.aspx.cs" 
Inherits="Transaction_MakerAndChecker_New" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../Scripts/FilePickupReport.js" type="text/javascript"></script>
       <%-- <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
        <script src="../Scripts/1.10.4-jquery-ui.js" type="text/javascript"></script>
        <script src="../Scripts/jquery-ui.js" type="text/javascript"></script>
        <script type="text/javascript" src="../scripts/jquery-1.4.2.min.js"></script>
               <script type="text/javascript" src="../scripts/jquery-list-attributes.js"></script>
        <script src="../Scripts/jquery.maskedinput-1.3.1.min_.js" type="text/javascript"></script>
        <script src="../Scripts/MakerChecker.js" type="text/javascript"></script>

        <script src="../Scripts/MakerChecker.js" type="text/javascript"></script>


        <script type="text/javascript" src="../scripts/jquery.scrollableFixedHeaderTable.js"></script>
        <link href="../Scripts/jquery-ui.css" rel="stylesheet" type="text/css" />
        <link href="../Styles/style.css" rel="stylesheet" type="text/css" />
        <link href="../Styles/scrollableFixedHeaderTable.css" rel="stylesheet" type="text/css" />
        <link href="../Scripts/1.10.4-themes-smoothness-jquery-ui.css" rel="stylesheet" type="text/css" />--%>

        <%-- <script src="../Scripts/jquery.ui.datetimepicker.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.ui.datetimepicker.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquerydatepicker.js" type="text/javascript"></script>
    <link href="../Styles/jquery-ui-1.7.3.custom.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-1.4.2.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.ui.core.js" type="text/javascript"></script>
    <link href="../Styles/CDMS.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/GridView.css" rel="stylesheet" type="text/css" />--%>

    

<%--<script src="../Scripts/FilePickupReport.js" type="text/javascript"></script>--%>
    <script language="javascript" type="text/javascript">

//        $(document).load(function () {
//            debugger;
//            alert('hi');
//            BindDates();
        //        });

        function ValidateFile() {
            var selectedValues = 0;
            var ErrorMsg = " Following fields are mandatory! \n\t ";
            var ValResult = true;

            var WareHouse = $('#ContentPlaceHolder1_ddlWareHouse').val();
            var WorkOrder = $('#ContentPlaceHolder1_ddlCustWorkOrder').val();
            
            if (WareHouse == '0') {
                ErrorMsg += "Please select WareHouse \n\t";
                ValResult = false;
            }
            if (WorkOrder == '0') {
                ErrorMsg += "Please select Customer Workorder\n ";
                ValResult = false;
            }

            if (ValResult == false) {
                alert(ErrorMsg);
                return false;
            }

                return validateDateFileDetails();

            return true;
        }
        function validateDateFileDetails() {
            var ErrorMsg = "\t Following fields are mandatory! \n \t\t"
            var ValResult = true;
            var FromDate = $("ContentPlaceHolder1_#txtFDate");
            var Enddate = $("ContentPlaceHolder1_#txtEDate");
            if (Enddate.val() != '' && FromDate.val() != '') {
                var str1 = FromDate.val();
                var str2 = Enddate.val();
                var dt1 = parseInt(str1.substring(0, 2), 10);
                var mon1 = parseInt(str1.substring(3, 5), 10);
                var yr1 = parseInt(str1.substring(6, 10), 10);
                var dt2 = parseInt(str2.substring(0, 2), 10);
                var mon2 = parseInt(str2.substring(3, 5), 10);
                var yr2 = parseInt(str2.substring(6, 10), 10);
                var date1 = new Date(yr1, mon1, dt1);
                var date2 = new Date(yr2, mon2, dt2);
                if (date1 > date2) {
                    ErrorMsg += 'End Date should be greater than From Date.'
                    ValResult = false;
                }
            }
            if (ValResult == false) {
                alert(ErrorMsg);
                return false;
            }
            else
                return true;
        }


        </Script>
        

   <style type="text/css">
        .div
        {
            font-family: Arial, Helvetica, sans-serif;
            border: 1px solid #CCCCCC;
            width: 802px;
        }
        
        .ui-autocomplete
        {
            background-color: white !important;
            width: 200px;
        } 
              
        .nopadding {padding:0px !important;}
        
        .RubberBandBox
         {
        overflow:hidden;
        padding:0;     
        filter:alpha(opacity=50); 
        background-color:#666666;
        border:0px solid #596380;
        z-index:100;
        left:0px;
        top:-189px;
        height:39%   ;
        width:100%;
        position:fixed;
        display:block;     
        }
    
        .RubberBandBox img
        {
        left:50%;
        top:50%;
        position:absolute;
        height:30px;
        width:114px;
        /*z-index:5   */
        }
        
        .modalBackground
        {
            background-color: #cccccc;
            filter: alpha(opacity=50);
            opacity: 0.7;
        }

        .modalPopup
        {
            background-color: #ffffff;
            border-width: 3px;
            border-style: solid;
            border-color: Gray;
            padding: 3px;
            width: 320px;
        }        
       
        .ui-autocomplete
        {
            background-color: white !important;
            width: 200px;
            max-height:150px !important;
            overflow:auto ;
        }        
        
        </style>

        <script language="javascript" type="text/javascript">
//            function Upload() {
            //                newwindow = window.showModalDialog("AddNewBox.aspx", window, dialogHeight: 650px; dialogWidth: 800px;Center:yes");
//                return true;
            //            }

            function OpenBoxReference() {
                var selectedValues = 0;
                var ErrorMsg = " Following fields are mandatory! \n\t ";
                var ValResult = true;

                var WareHouse = $('#ContentPlaceHolder1_ddlWareHouse').val();
                var WorkOrder = $('#ContentPlaceHolder1_ddlCustWorkOrder').val();
                var PickupAddress = $('#ContentPlaceHolder1_ddlWorkOrderActivity').val();

                if (WareHouse == '0') {
                    ErrorMsg += "Please select WareHouse\n\t ";
                    ValResult = false;
                }
                if (WorkOrder == '0') {
                    ErrorMsg += "Please select Customer Workorder\n\t ";
                    ValResult = false;
                }
                if (PickupAddress == '0') {
                    ErrorMsg += "Please select Pick Up Address\n ";
                    ValResult = false;
                }
                if (ValResult == false) {
                    alert(ErrorMsg);
                    return false;
                }
                window.showModalDialog("AddNewBox.aspx?Mode=AddBox", window, "dialogHeight: 500px; dialogWidth: 1000px;Center:yes");
                
                return true;
            }

            function OpenFileReference() {
                var selectedValues = 0;
                var ErrorMsg = " Following fields are mandatory! \n\t ";
                var ValResult = true;

                var WareHouse = $('#ContentPlaceHolder1_ddlWareHouse').val();
                var WorkOrder = $('#ContentPlaceHolder1_ddlCustWorkOrder').val();

                if (WareHouse == '0') {
                    ErrorMsg += "Please select WareHouse \n\t";
                    ValResult = false;
                }
                if (WorkOrder == '0') {
                    ErrorMsg += "Please select Customer Workorder\n ";
                    ValResult = false;
                }
                if (ValResult == false) {
                    alert(ErrorMsg);
                    return false;
                }
                window.showModalDialog("AddNewFile.aspx?Mode=AddFile", window, "dialogHeight: 650px; dialogWidth: 1100px;Center:yes");
                return true;
            }

            function EditFileDetails(ID) {
                var Fid = ID.trim();
                window.showModalDialog("AddNewFile.aspx?Mode=EditFile&Fid=" + Fid, window, "dialogHeight: 650px; dialogWidth: 1100px;Center:yes");
                return true;
            }

//            function EditBoxDetails(ID) {
//                var Fbc = ID.toString().trim();
//                window.showModalDialog("AddNewBox.aspx?Mode=EditBox&Bbc=" + Bbc, window, "dialogHeight: 300px; dialogWidth: 700px;Center:yes");

//                return true;
//            }
                 </script>

    <%--<ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </ajax:ToolkitScriptManager>--%>

        <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="0" AssociatedUpdatePanelID="updpnlfreshpickup">
                <ProgressTemplate>
                    <div id="divUpdateProgress" class="RubberBandBox">
                        <img id="imgLoadingImage" src="../images/loading-animation.gif" alt="Loading....."/>
                        <span id="loding" style="font-style: normal; color: Red">Please Wait...</span>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>

    <asp:UpdatePanel ID="updpnlfreshpickup" runat="server" >
        <ContentTemplate>
          <script type="text/javascript">
              Sys.Application.add_load(BindDates);
            </script>
            <div class="middle">
                  <asp:ScriptManager ID="ScriptManager1" runat="server"  EnableScriptGlobalization="true"
                EnableScriptLocalization="true">
                </asp:ScriptManager>
               <%-- <div class="frmbox">                --%>
                 <asp:Panel ID="Panel2" runat="server" GroupingText="Work Order Selection" style="font-family: arial;font-size: 11px;" >
                  
                    <table width="100%" style="border: 2px" border="0">
                        <tr>
                            <td style="width: 6%" align="right">
                                WareHouse <span style="color: #FF0000">*</span>
                            </td>
                            <td style="width: 13%" align="left">
                                <asp:DropDownList ID="ddlWareHouse" runat="server" Width="145" 
                                     AutoPostBack="true" 
                                    onselectedindexchanged="ddlWareHouse_SelectedIndexChanged"  >
                                </asp:DropDownList>
                                <br />
                                <asp:RequiredFieldValidator ID="rfvDdlWareHouse" runat="server" ControlToValidate="ddlWareHouse"
                                    ErrorMessage="Please select WareHouse." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup"
                                    Display="Dynamic"></asp:RequiredFieldValidator>                                
                            </td>
                            <td style="width: 12%" align="right">
                                Customer Workorder No.<span style="color: #FF0000">*</span>
                            </td>

                            <td style="width: 22%" align="left">
                            <asp:DropDownList ID="ddlCustWorkOrder" runat="server" AutoPostBack="true" 
                                    Width="340" onselectedindexchanged="ddlCustWorkOrder_SelectedIndexChanged">
                                 </asp:DropDownList>
                                <br />
                                <asp:Label runat="server" ID="lblActivityName" ></asp:Label>
                              <asp:RequiredFieldValidator ID="rfvDdlCustWorkOrder" runat="server" ControlToValidate="ddlCustWorkOrder"
                                    ErrorMessage="Please select Customer Work order." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup"
                                    Display="Dynamic"></asp:RequiredFieldValidator>
                            </td>
                            <td style="width: 8%" align="right">
                               Pick Up Address
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlWorkOrderActivity" runat="server" Width="330" >
                                </asp:DropDownList>
                                <br />
                                <asp:RequiredFieldValidator ID="rfvDdlWorkOrderActivity" runat="server" ControlToValidate="ddlWorkOrderActivity"
                                    Display="Dynamic" ErrorMessage="Please select work order activity." InitialValue="0"
                                    ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                            </td>
                        </tr>                      
                       <%-- <tr>  
                        <td style="width: 5%" align="left">
                               
                            </td>
                            <td style="width: 13%" align="left">
                                
                                                       
                            </td>                          
                            <td>
                               Pick Up Address
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlWorkOrderActivity" runat="server" Width="350" >
                                </asp:DropDownList>
                                <br />
                                <asp:RequiredFieldValidator ID="rfvDdlWorkOrderActivity" runat="server" ControlToValidate="ddlWorkOrderActivity"
                                    Display="Dynamic" ErrorMessage="Please select work order activity." InitialValue="0"
                                    ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                            </td>
                        </tr>  --%>                    
                       
                    </table>
              </asp:Panel>

               <%--  </div>--%>
              <asp:Panel ID="Panel1" runat="server" GroupingText="Search" style="font-family: arial;font-size: 11px;">

                    <table width="100%" style="border: 2px" border="0">
                                 
                        <tr>
                            <td style="width: 70%">
                                <asp:RadioButtonList ID="rblMakerChecker" runat="server" Width="300px"
                                    RepeatDirection="Horizontal" Font-Bold="True" Font-Size="Larger" 
                                    onselectedindexchanged="rblMakerChecker_SelectedIndexChanged" 
                                    AutoPostBack="True">
                                                            <asp:ListItem Value="1" Selected="True"> Maker </asp:ListItem>
                                                            <asp:ListItem Value="2"> Maker Update </asp:ListItem>
                                                            <asp:ListItem Value="3"> Checker </asp:ListItem>
                                                        </asp:RadioButtonList>
                            </td>
                            
                            <td align="right">
                                <asp:Button ID="btnAddBox" runat="server" Text="Add Box" 
                                    CausesValidation="False" 
                                    OnClientClick="javascript:return OpenBoxReference();" 
                                     /> &nbsp; &nbsp; &nbsp;
                                 <asp:Button ID="btnAddFile" runat="server" Text="Add File" CausesValidation="False" OnClientClick="javascript:return OpenFileReference();"/> 
                                  <input id="hdnMode" runat="server" type="hidden" value="" />
                            </td>
                        </tr>  
                       <%-- <tr> <td >  <br /></td> </tr>          --%>          
                        <tr>                            
                            <td align="left" valign="top" colspan="3">
                                <table style="border: 2px" width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td style="width: 8%" >
                                            Box BarCode
                                        </td>
                                        <td style="width: 19%">
                                            <asp:TextBox ID="txtBoxBarCode" runat="server" Width="150px" MaxLength="16"></asp:TextBox>                                                                                     
                                        </td>
                                        <td style="width: 8%">
                                            File BarCode
                                        </td>
                                        <td style="width: 19%">
                                             <asp:TextBox ID="txtFileBarCode" runat="server" Width="150px" MaxLength="16"></asp:TextBox>                                                                            
                                        </td>

                                        <td style="width: 7%">
                                            Department
                                        </td>
                                        <td style="width: 19%">
                                            <asp:DropDownList ID="ddlDepart" runat="server" Width="155px" MaxLength="100">
                                                </asp:DropDownList> 
                                        </td>
                                   
                                        <td style="width: 8%">
                                            File Description1
                                        </td>
                                        <td style="width: 20%">
                                            <asp:TextBox ID="txtFileDesc1" runat="server" Width="150px" MaxLength="255"></asp:TextBox>                                                                      
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 8%">
                                            File Description2
                                        </td>
                                        <td style="width: 19%">
                                            <asp:TextBox ID="txtFileDesc2" runat="server" Width="150px" MaxLength="255"></asp:TextBox> 
                                        </td>

                                        <td style="width: 8%">
                                            File Type
                                        </td>
                                        <td style="width: 19%">
                                          <asp:TextBox ID="txtFileType" runat="server" Width="150px" MaxLength="100"> </asp:TextBox> <br />
                                               <ajax:FilteredTextBoxExtender ID="fltrLable1Modify" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                                        ValidChars=" -" TargetControlID="txtFileType"/> 
                                        </td>
                                   
                                        <td style="width: 7%">
                                            Year
                                        </td>
                                        <td style="width: 19%">
                                            <asp:TextBox ID="txtyear" runat="server" Width="150px" MaxLength="10"></asp:TextBox>
                                                          <ajax:FilteredTextBoxExtender ID="fltrYearModify" runat="server" FilterType="Numbers,Custom"
                                                        ValidChars="-" TargetControlID="txtyear">
                                                    </ajax:FilteredTextBoxExtender> 
                                        </td>
                                        <td style="width: 8%">
                                            From Date
                                        </td>
                                        <td style="width: 20%">
                                                <asp:TextBox ID="txtFdate" runat="server" Width="150" CssClass="datepicker1" onkeypress="return false;">
                                        </asp:TextBox>                                           
                                        </td>
                                         </tr>
                                     <tr>
                                        <td style="width: 8%">
                                            To Date
                                        </td>
                                        <td style="width: 19%">                                            
                                              <asp:TextBox ID="txtEdate" runat="server" Width="150" CssClass="datepicker1" onkeypress="return false;"> </asp:TextBox>                                            
                                        </td>
                                   
                                        <td style="width: 8%">
                                            From Number
                                        </td>
                                        <td style="width: 19%">
                                            <asp:TextBox ID="txtFromNum" runat="server" Width="150px" MaxLength="100"></asp:TextBox> <br />
                                              <ajax:FilteredTextBoxExtender ID="fltrLable2Modify" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                                ValidChars=" -" TargetControlID="txtFromNum"/> 
                                        </td>
                                        <td style="width: 7%">
                                            To Number
                                        </td>
                                        <td style="width: 19%">
                                            <asp:TextBox ID="txtToNum" runat="server" Width="150px" MaxLength="100"></asp:TextBox> <br />
                                                 <ajax:FilteredTextBoxExtender ID="fltrLable3Modify" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                                        ValidChars=" -" TargetControlID="txtToNum"/>
                                        </td>

                                        <td style="width: 8%">
                                            Destruction Due Date
                                        </td>
                                        <td style="width: 20%">
                                            <asp:TextBox ID="txtDestructionDueDate" runat="server" Width="150px" ValidationGroup="SaveGroup" CssClass="datepicker1"  
                                                 MaxLength="10"></asp:TextBox> 
                                        </td>
                                    </tr>

                                    <tr> <td colspan="6">  <br /></td> </tr>
                                    <tr>
                                    <td align="left" colspan="3">
                                        <asp:Label ID="lblSearchCount" runat="server" Text=""></asp:Label>
                                    </td>
                                    <td align="left" colspan="3">
                                    <asp:Button ID="btnSearch" runat="server" Text="Search" CausesValidation="False" ToolTip="Search Box File details"
                                    OnClientClick="javascript:return ValidateFile();" onclick="btnSearch_Click"/> 
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CausesValidation="False" 
                                            ToolTip="Clear Search" onclick="btnCancel_Click" /> 
                                    </td>
                                    </tr>

                                </table>
                            </td>
                        </tr>

                    </table>
              </asp:Panel>  
              
              <asp:Panel ID="GvPanal" runat="server" GroupingText="Search Result" Visible="false" CssClass="overflowdiv">
                                <table width="100%" >
                                   <%-- <tr>
                                        <td style="text-align: left" class="BoldFont">
                                            Search Result Count :
                                            <asp:Label ID="lblCount" runat="server" Text="" Style="text-align: left"></asp:Label>
                                        </td>
                                    </tr>--%>
                                     <tr id="trMakerCheckerUpdate" runat="server" style="font-family: arial;font-size: 11px;">
                                    <td style="width:35%;" align="right" id="tdSelectMode" runat="server"> 
                                   <b>
                                       <asp:Label ID="lblmode" runat="server" Text="Please select The Mode :"></asp:Label>  <span style="color: #FF0000"></span> </b> &nbsp; &nbsp; &nbsp; &nbsp;</td>
                                    <td  style="width:17%;" align="left" id="tdRblSelectMode" runat="server">
                                    <asp:RadioButtonList runat="server" ID="rbtApprovedRejectChecker" RepeatDirection="Horizontal"  
                            RepeatColumns="2"  Width="150px" 
                            AutoPostBack="true" >
                    <asp:ListItem Text="Approved" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Reject"  Value="2"></asp:ListItem>
                     </asp:RadioButtonList>
                     <asp:RequiredFieldValidator ID="rfvAppRej" runat="server" 
                     ControlToValidate="rbtApprovedRejectChecker"
                     ErrorMessage="Please select Approved / Reject." InitialValue="" 
                     ForeColor="Red" ValidationGroup="CheckerGroup"
                     Display="Dynamic"></asp:RequiredFieldValidator> 
                     </td>
                             <td style="width:40%;" align="left" id="tdApproveReject" runat="server">      
                                    <asp:Button ID="btnApprove" runat="server" Text="Save"  ValidationGroup="CheckerGroup"
                                    CausesValidation="true" OnClientClick="return validateChecker();" 
                                        onclick="btnApprove_Click"/> &nbsp; &nbsp; &nbsp;
                                <asp:Button ID="btnCancelApprove" runat="server" Text="Clear" 
                                        onclick="btnCancelApprove_Click"  /> <br />
                                <asp:Label runat="server" ID="lblMsg" Font-Bold="true" Font-Size="12px" ></asp:Label>
                                    </td>

                                  <%--  <td style="width:20%;" align="left" id="tdUpdateMaker" runat="server">     
                                    <asp:Button ID="btnModify" runat="server" Text="Update"  ValidationGroup="ModifyGroup"
                                    CausesValidation="true"   />
                                <asp:Button ID="btnCancelModify" runat="server" Text="Clear" />
                                    </td>--%>

                                    </tr>

                                    <tr>
                                        <td colspan="3">
                                            <asp:GridView ID="GrdMakerSearch" runat="server" AllowPaging="True" 
                                                AutoGenerateColumns="False" Width="100%"
                                               BorderStyle="Solid" EmptyDataText="No Record Found" onrowcommand="GrdMakerSearch_RowCommand" 
                                                onrowediting="GrdMakerSearch_RowEditing" BackColor="White" 
                                                UseAccessibleHeader="true" CssClass="grid_data" 
                                                HeaderStyle-CssClass="header" 
                                                onpageindexchanging="GrdMakerSearch_PageIndexChanging" 
                                                onrowdatabound="GrdMakerSearch_RowDataBound" OnSorting="GrdMakerSearch_Sorting" AllowSorting="true">
                                                <Columns>
                                               
                                               <asp:TemplateField ItemStyle-Width="2%"  HeaderStyle-Width="2%" HeaderText = "Sr No." ItemStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'
                                                        Width="5px"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="3%"></ItemStyle>
                                            </asp:TemplateField>
                                                    <asp:BoundField DataField="Box Barcode" HeaderText="Box BarCode" SortExpression="Box Barcode">
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                     <asp:TemplateField HeaderText="File BarCode" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="15%"
                                                            SortExpression="File BarCode">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lnkFileID" runat="server" CommandArgument='<%#Eval("FileId")%>'
                                                                    CommandName="EditRecord" Text='<%#Eval("File BarCode") %>'></asp:LinkButton> 
                                                                    <asp:Label ID="lblFbc" runat="server" Text='<%#Eval("File BarCode") %>' Visible="false"></asp:Label>                                                               
                                                                     <asp:Label ID="lblFID" runat="server" Text='<%#Eval("FileId") %>' Visible="false"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Left" Width="10%" />
                                                        </asp:TemplateField>                                                   
                                                    <asp:BoundField DataField="sFileName" HeaderText="File Description1">
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="FileDescription1" HeaderText="File Description2">
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Department" HeaderText="Department" >
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Year" HeaderText="Year">
                                                      <ItemStyle HorizontalAlign="Left"  Width="8%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="FromDate" HeaderText="From Date" >
                                                        <ItemStyle HorizontalAlign="Left"  Width="9%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="ToDate" HeaderText="To Date"></asp:BoundField>
                                                     <asp:BoundField DataField="File Type" HeaderText="File Type"  >
                                                         <ItemStyle HorizontalAlign="Left"  Width="9%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="From No" HeaderText="From No" >
                                                        <ItemStyle HorizontalAlign="Left" Width="9%"/>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="To No" HeaderText="To No" >
                                                        <ItemStyle HorizontalAlign="Left" Width="9%"/>
                                                    </asp:BoundField>                                                    
                                                    <asp:BoundField DataField="Destruction Due Date" HeaderText="Destruction Due Date" >
                                                        <ItemStyle HorizontalAlign="Left" Width="9%"/>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="FileStatus" HeaderText="FileStatus">
                                                         <ItemStyle HorizontalAlign="Left" Width="9%"/>
                                                     </asp:BoundField>                                                    
                                                     <asp:TemplateField HeaderText="Remarks" ItemStyle-Width="25%"  >
                                                <ItemTemplate> 
                                                    <asp:TextBox ID="txtRemarks" runat="server" 
                                                     MaxLength="200" style="width:100%" Text='<%# Eval("FileRemarks") %>' 
                                                       ></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="25%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"/>
                                            </asp:TemplateField>
                                                  
                                                  <asp:TemplateField HeaderText="FileId" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="15%"
                                                            SortExpression="File BarCode" Visible="false">
                                                            <ItemTemplate> 
                                                                    <asp:Label ID="lblFileId" runat="server" Text='<%#Eval("FileId") %>'
                                                                    CommandArgument='<%#Eval("FileId")%>' ></asp:Label>                                                               
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Left" Width="10%" />
                                                        </asp:TemplateField>

                                                  <%--<asp:BoundField DataField="FileId" HeaderText="FileId" Visible="False">
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:BoundField>--%>
                                                <asp:BoundField DataField="WareHouse" HeaderText="WareHouse" Visible="False">
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                     <asp:BoundField DataField="Company Group" HeaderText="Company Group" Visible="False">
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Customer" HeaderText="Customer" Visible="False">
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:BoundField>

                                                    <asp:BoundField DataField="WorkorderNo" HeaderText="Workorder No" Visible="False">
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                     <asp:BoundField DataField="Box Location" HeaderText="Box Location"  Visible="False">
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="WO Status" HeaderText="WO Status"  Visible="False">
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Status" HeaderText="Status"  Visible="False">
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:BoundField>

                                                     <asp:TemplateField HeaderText="DepartmentId" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="15%"
                                                            SortExpression="Department" Visible="false">
                                                            <ItemTemplate>
                                                            
                                                              <%--  <asp:LinkButton ID="lnkDeptID" runat="server" CommandArgument='<%#Eval("DepartmentId")%>'
                                                                    Text='<%#Eval("DepartmentId") %>' Visible="false"></asp:LinkButton> --%>
                                                                    <asp:Label ID="lblDeptID" runat="server" Text='<%#Eval("DepartmentId") %>'
                                                                    CommandArgument='<%#Eval("DepartmentId")%>' ></asp:Label>                                                               
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Left" Width="10%" />
                                                        </asp:TemplateField>

                                                     <%--<asp:TemplateField HeaderText="DepartmentID" ItemStyle-Width="10%" Visible="false" >
                                                <ItemTemplate>
                                                <asp:DropDownList ID="ddlDepart" runat="server" Style="width: 135px;"
                                                 MaxLength="100" onkeyup="return changeCells( this, this.id,event);" >
                                                </asp:DropDownList>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>--%>

                                            <asp:BoundField DataField="CustomerId" HeaderText="CustomerId" Visible="False">
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:BoundField>

                                                </Columns>
                                                <PagerStyle CssClass="pgr" HorizontalAlign="Left" />
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                 <%--   <caption>
                                        <br />
                                    </caption>
                                    </tr>--%>
                                   
                                </table>
                            </asp:Panel>
                                      
              </div>

             <%-- <asp:Panel ID="panAddBox" Style="display: none; overflow:scroll;" runat="server" CssClass="modalPopup" Width="750px" Height="97%" ScrollBars="Vertical" >
                <div id="dvAddBox" style="font-weight: bold; font-size: 15px; color: #034680; text-align: center; padding: 5px 0 0 0;">
                    <asp:Label ID="Label2" runat="server" SkinID="lblheader" Text="Add New Box"></asp:Label>
                </div>                
                <div id="divUserMstrPopUp" style="width:100%;" runat="server" >
                
                <table border="0" width="100%" cellpadding="0" cellspacing="0">
                    <tr>  
                        <td colspan="3" style="display: block">

                        <asp:DropDownList ID="DropDownList1" runat="server" Width="210" >
                    </asp:DropDownList>
                        </td>
                        <td>
                            <asp:Button ID="btnClose" runat="server" Text="Close" />
                                    
                            </td>      
                    </tr>
                                  
                                
                </table>
                      
                </div>
               
            </asp:Panel>

            <ajax:ModalPopupExtender BackgroundCssClass="modalBackground" CancelControlID="btnClose"
                runat="server" PopupControlID="panAddBox" Drag="true" ID="ModalPopup" 
                PopupDragHandleControlID="dvAddBox" BehaviorID="ModalPopup" TargetControlID="btnAddBox"  />
            <asp:HiddenField ID="hdnTarget" runat="server" />--%>

        </ContentTemplate>
      
    </asp:UpdatePanel>    

</asp:Content>

