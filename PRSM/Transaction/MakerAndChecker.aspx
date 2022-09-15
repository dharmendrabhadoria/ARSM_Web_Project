<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true"
    CodeFile="MakerAndChecker.aspx.cs" Inherits="Transaction_MakerAndChecker" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
<script src="../Scripts/1.10.4-jquery-ui.js" type="text/javascript"></script>
   <script src="../Scripts/jquery-ui.js" type="text/javascript"></script>
     <script type="text/javascript" src="../scripts/jquery-1.4.2.min.js"></script>
 <%-- 
     <script type="text/javascript" src="../scripts/jquery.dimensions.min.js"></script>
    <script type="text/javascript" src="../scripts/jquery.cookie.pack.js"></script>--%>
    <script type="text/javascript" src="../scripts/jquery-list-attributes.js"></script>
    <script src="../Scripts/jquery.maskedinput-1.3.1.min_.js" type="text/javascript"></script>
    <script src="../Scripts/MakerChecker.js" type="text/javascript"></script>

     <script type="text/javascript" src="../scripts/jquery.scrollableFixedHeaderTable.js"></script>
    <link href="../Scripts/jquery-ui.css" rel="stylesheet" type="text/css" />
     <link href="../Styles/style.css" rel="stylesheet" type="text/css" />
     <link href="../Styles/scrollableFixedHeaderTable.css" rel="stylesheet" type="text/css" />
    <link href="../Scripts/1.10.4-themes-smoothness-jquery-ui.css" rel="stylesheet" type="text/css" />

   <style>
        .div
        {
            font-family: Arial, Helvetica, sans-serif;
            border: 1px solid #CCCCCC;
            width: 802px;
        }
        
        .myTable
        {
           /* background-color: BLACK;*/
            font-size: 12px;
        }
        
        .myTable td
        {
            background-color: WHITE;
        }
        
        .myTable .header td
        {
            font-weight: bold;
            background-color: #CCCCCC;
        }
    </style>

     <style type="text/css">
        .ui-autocomplete
        {
            background-color: white !important;
            width: 200px;
        }
       
        .nopadding {padding:0px !important;}
    </style>

      <style type="text/css">
        .AlternativeRowStyle
        {
            background-color: White;
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
        
        .divActivityRate
        {
            background-color: #fff;
            z-index: 20000;
            position: fixed;
            background: #fff;
            padding: 20px;
            border: #e4e4e4 2px solid;
            box-shadow: 0 0 20px #000;
            display: none;
            width: 500px;
            left: 20%;
            top: 200px;
        }
        .ExcelTable2007
        {
            border: 1px solid #B0CBEF;
            border-width: 1px 0px 0px 1px;
            font-size: 11px;
            font-family: Calibri;
            font-weight: 100;
            border-spacing: 0px;
            border-collapse: collapse;
        }
        
        .FixedHeader
        {
            position: absolute;
            font-weight: bold;
        }
    </style>

      <style type="text/css">
    .RubberBandBox {
      
      overflow:hidden;
      padding:0;
      opacity:.5;
      filter:alpha(opacity=50); 
      background-color:#666666;
      border:0px solid #596380;
      z-index:100;
      left:0px;
      top:0px;
      height:100%   ;
      width:100%;
      position:fixed;
      display:block;
     
    }
    
    .RubberBandBox img{
       left:50%;
       top:50%;
       position:absolute;
       height:30px;
       width:114px;
       /*z-index:5   */
    }
  
    </style>

    <ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </ajax:ToolkitScriptManager>
  
    <script src="../Scripts/MakerChecker.js" type="text/javascript"></script>

        <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="0" AssociatedUpdatePanelID="updpnlfreshpickup">
                <ProgressTemplate>
                    <div id="divUpdateProgress" class="RubberBandBox">
                        <img id="imgLoadingImage" src="../images/loading-animation.gif" alt="Loading....."
                            />
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>

    <asp:UpdatePanel ID="updpnlfreshpickup" runat="server" >
        <ContentTemplate>
         <style type="text/css">
        .ui-autocomplete
        {
            background-color: white !important;
            width: 200px;
            max-height:150px !important;
            overflow:auto ;
        }
        </style>

        
   

   
            <div class="clear">
            </div>
            <div class="middle">
                <div class="frmbxhead" style="width: 125px; z-index: 10!important;">
                    <asp:LinkButton ID="lnkbtnMaker" runat="server" Font-Underline="false" Style="color: #4f4f4f !important;"
                        CausesValidation="false" 
                        onclick="lnkbtnMaker_Click">Maker New Entry</asp:LinkButton>
                </div>
                  <div class="frmbxhead" style="margin-left: 220px !important; margin-bottom: -1px !important;
                    z-index: 0 !important;">
                    <asp:LinkButton ID="lnkbtnModifyMaker" runat="server" 
                        Font-Underline="false" Style="color: #4f4f4f !important;"
                        CausesValidation="false" onclick="lnkbtnModifyMaker_Click" >Maker Update Entry</asp:LinkButton>
                </div>

                   <div class="frmbxhead" style="margin-left: 410px !important; margin-bottom: -1px !important;
                    z-index: 0 !important;">
                    <asp:LinkButton ID="lnkbtnChecker" runat="server" 
                        Font-Underline="false" Style="color: #4f4f4f !important;"
                        CausesValidation="false" onclick="lnkbtnChecker_Click" >Checker</asp:LinkButton>
                </div>
                  
                <div class="frmbox">
                <table width="100%" style="border: 2px" border="0">
                    <%--       <tr >
                    <td colspan="4" align="right" >
                    <asp:Timer ID="Timer1" runat="server" Interval="120000" ontick="Timer1_Tick"/> <asp:Label runat="server" ID="lbltimerUpdate"  ></asp:Label>
                    </td>
                    </tr>--%>
                </table>
                  <div id="divNewMaker" runat="server" >
                    <table width="100%" style="border: 2px" border="0">
                    <tr>
                    <td> </td>
                    <td colspan="4"    >
                    <asp:RadioButtonList runat="server" ID="rbtactivityType" RepeatDirection="Horizontal"  
                            RepeatColumns="2"  Width="360px" 
                            AutoPostBack="true" 
                            onselectedindexchanged="rbtactivityType_SelectedIndexChanged"    >
                     <asp:ListItem Text="New Box preparation" Value="1"  ></asp:ListItem>
                    <asp:ListItem Text="File Pickup"  Value="2"  ></asp:ListItem>
                     </asp:RadioButtonList>
                     </td>
                    </tr>
             
                        <tr>
                            <td style="width: 14%">
                                WareHouse
                            </td>
                            
                            <td colspan="4" >
                                <asp:DropDownList ID="ddlWareHouse" runat="server" Width="200" 
                                    onselectedindexchanged="ddlWareHouse_SelectedIndexChanged" AutoPostBack="true"  >
                                </asp:DropDownList>
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="ddlWareHouse"
                                    ErrorMessage="Please select WareHouse." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup"
                                    Display="Dynamic"></asp:RequiredFieldValidator>
                                
                            </td>
                        </tr>
                        <tr>
                            <td width="15%">
                                Company Group
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlCompanyGroup" runat="server" AutoPostBack="true" Width="210"
                                    OnSelectedIndexChanged="ddlCompanyGroup_SelectedIndexChanged">
                                </asp:DropDownList>
                                <span id="SpnddlCompanyGroup" style="color: Red;"></span>
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlCompanyGroup"
                                    ErrorMessage="Please select company Group." InitialValue="0" ForeColor="Red"
                                    ValidationGroup="SaveGroup" Display="Dynamic"></asp:RequiredFieldValidator>
                           
                            </td>
                            <td>
                                Customer
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlCustomer" runat="server" AutoPostBack="true" Width="210"
                                    OnSelectedIndexChanged="ddlCustomer_SelectedIndexChanged">
                                </asp:DropDownList>
                                <br />
                                <span id="SpnddlCustomer" style="color: Red;"></span>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="ddlCustomer"
                                    Display="Dynamic" ErrorMessage="Please select customer." InitialValue="0" ForeColor="Red"
                                    ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                          
                            </td>
                        </tr>
                        <tr>
                            <td width="12%">
                                Work Order
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlWorkOrder" runat="server" AutoPostBack="true" Width="210"
                                    OnSelectedIndexChanged="ddlWorkOrder_SelectedIndexChanged">
                                </asp:DropDownList>
                                <br />
                                <asp:Label runat="server" ID="lblActivityName" ></asp:Label>
                              <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlWorkOrder"
                                    ErrorMessage="Please select work order." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup"
                                    Display="Dynamic"></asp:RequiredFieldValidator>
                            </td>
                            <td>
                               Pick Up Address
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlWorkOrderActivity" runat="server" Width="210" AutoPostBack="True"
                                    OnSelectedIndexChanged="ddlWorkOrderActivity_SelectedIndexChanged">
                                </asp:DropDownList>
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="ddlWorkOrderActivity"
                                    Display="Dynamic" ErrorMessage="Please select work order activity." InitialValue="0"
                                    ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                             <%--onchange='<% #GetFunctionForBoxBarCode(Container.DataItemIndex)%> '  onblur='<% #GetFunctionForBoxBarCode(Container.DataItemIndex)%> '--%>
                                            <%--      onchange="return findDuplicateBox(this.id,'grdboxdetails');"--%>
                                             <%--  onmousemove='<% #GetFunctionForBoxBarCode(Container.DataItemIndex,"grdboxdetails")%> '  
                                            onblur='<% #GetFunctionForBoxBarCode(Container.DataItemIndex,"grdboxdetails")%> '  --%>
                           <div id='table-container'>
                         
                             <asp:GridView runat="server" ID="grdboxdetails"  AutoGenerateColumns="false" 
                             Width="100%" BackColor="White" 
                              CssClass="ExcelTable2007-1 myTable scrollableFixedHeaderTable"  >
                            
                                        <Columns>
                                            <asp:TemplateField ItemStyle-Width="4%" HeaderStyle-Width="4%" ItemStyle-HorizontalAlign="Center" HeaderText = "Sr No." >
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'
                                                        Width="15px"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="4%"></ItemStyle>
                                            </asp:TemplateField>
                                               <asp:TemplateField HeaderText="Box BarCode" ItemStyle-Width="25%" HeaderStyle-Width="25%" >
                                                <ItemTemplate>
                                                 <asp:HiddenField ID="selectedValue" runat="server" />
                                                    <asp:TextBox ID="txtBoxBarCode" runat="server" Style="width:100%;" MaxLength="16"
                                                        Text='<%# Eval("BoxBarCode") %>' 
                                                        onkeyup="return changeCells( this, this.id,event);" 
                                                         onchange="return findDuplicateBox(this.id,'grdboxdetails');"
                                                 ></asp:TextBox>  
                                           
                                                    <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtenderBarCode" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                                        ValidChars="-" TargetControlID="txtBoxBarCode">
                                                    </ajax:FilteredTextBoxExtender>
                                                </ItemTemplate>
                                                <ItemStyle Width="25%"></ItemStyle>
                                            </asp:TemplateField>

                                           <asp:TemplateField HeaderText="Box LocationCode"  >
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtBoxLocCode" runat="server" Style="width:100%;" MaxLength="15" 
                                                        Text='<%# Eval("BoxLocCode") %>' onkeyup="return changeCells( this, this.id,event);" ></asp:TextBox>
                                                  <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtenderLocCode" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                                        ValidChars=" -" TargetControlID="txtBoxLocCode">
                                                    </ajax:FilteredTextBoxExtender>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            </Columns>
                                            </asp:GridView>   
                                        
                                            <%--<div class="div">--%>
                                            <%--  <div style="overflow:auto;width:1000px;height:200px;vertical-align:top">--%>
                                    <asp:GridView runat="server" ID="grdFilesDetails" CellSpacing="1" CellPadding="1"  
                                    AutoGenerateColumns="false"  CssClass="ExcelTable2007-1 myTable scrollableFixedHeaderTable" width="1600px"
                                     OnRowCommand="grdFilesDetails_RowCommand"   onrowdatabound="grdFilesDetails_RowDataBound" 
                                     HeaderStyle-CssClass="header">
                                        <Columns>
                                            <asp:TemplateField ItemStyle-Width="3%" ItemStyle-Height="7px" HeaderStyle-Width="2%" HeaderText = "Sr No." ItemStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'
                                                        Width="10px"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="3%"></ItemStyle>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Box BarCode" ItemStyle-Height="7px" ItemStyle-Width="7%"  >
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtBoxBarCode" runat="server" Style="width:100%;" MaxLength="16" 
                                                        Text='<%# Eval("BoxBarCode") %>' onkeyup="return changeCells(this, this.id,event);" ></asp:TextBox>
                                                    <ajax:FilteredTextBoxExtender ID="fltrBxbarCode" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                                        ValidChars="-" TargetControlID="txtBoxBarCode">
                                                    </ajax:FilteredTextBoxExtender>
                                                </ItemTemplate>
                                                <ItemStyle Width="7%" HorizontalAlign="Left"   ></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>
                                       
                                            <asp:TemplateField HeaderText="File BarCode" ItemStyle-Width="10%"  >
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtFileBarCode" runat="server" Style="width:100%;" MaxLength="16"
                                                        Text='<%# Eval("FileBarCode") %>' onchange="return findduplicatefileName(this.id,'grdFilesDetails');" onkeyup="return changeCells( this, this.id,event);" ></asp:TextBox>
                                                    <ajax:FilteredTextBoxExtender ID="fltrFbarCode" runat="server"
                                                     FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom" 
                                                        ValidChars="-" TargetControlID="txtFileBarCode">
                                                    </ajax:FilteredTextBoxExtender>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left"   ></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="File Description 1" ItemStyle-Width="10%"  >
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtFilename" runat="server" Style="width:100%;" MaxLength="255"
                                                        Text='<%# Eval("sFileName") %>' onkeyup="return changeCells( this, this.id,event);" ></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>
                                               <asp:TemplateField HeaderText="File Description 2" ItemStyle-Width="10%"  >
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtFileDescription" runat="server" Style="width:100%;" MaxLength="255"
                                                        Text='<%# Eval("sFileName") %>' onkeyup="return changeCells( this, this.id,event);" ></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>
                                          <asp:TemplateField HeaderText="Department" ItemStyle-Width="10%"  >
                                                <ItemTemplate>
                                                <asp:DropDownList ID="ddlDepart" runat="server" Style="width: 135px;"
                                                 MaxLength="100" onkeyup="return changeCells( this, this.id,event);" >
                                                </asp:DropDownList>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>
                                         <asp:TemplateField HeaderText="Year<br/>eg. (2013,2013-14)" ItemStyle-Width="10%"  >
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtyear" runat="server" Style="width:100%;" MaxLength="10" 
                                                        Text='<%# Eval("sYear") %>'  ></asp:TextBox>
                                                          <ajax:FilteredTextBoxExtender ID="fltrYear" runat="server" 
                                                          FilterType="Numbers,Custom" ValidChars="-" TargetControlID="txtyear">
                                                    </ajax:FilteredTextBoxExtender>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="From Date<br/>(DD-MM-YYYY)" ItemStyle-Width="10%"   >
                                                <ItemTemplate>
                                              <asp:TextBox ID="txtFdate" runat="server" Style="width:50%;" ValidationGroup="SaveGroup"  ClientIDMode="Predictable"  
                                                 MaxLength="10" Text='<%# Eval("FromDate")%>'   ></asp:TextBox>
                                               <asp:RegularExpressionValidator ID="regFromDate" runat="server" ValidationGroup="SaveGroup" ClientIDMode="Predictable"
                                                ErrorMessage="Invalid Date" Tooltip="Please enter date in dd/mm/yyyy format"  ForeColor="Red"   ControlToValidate="txtFdate" Display="Dynamic"  
                                                ValidationExpression="(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[012])/\d{4}"></asp:RegularExpressionValidator> 
                                                </ItemTemplate>
                                                <ItemStyle Width="10%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>
                                        <asp:TemplateField HeaderText="To Date<br/>(DD-MM-YYYY)" ItemStyle-Width="10%" >
                                                <ItemTemplate>
                                           <asp:TextBox ID="txtEdate" runat="server" Style="width:50%;" 
                                              onkeyup="return changeCells( this, this.id,event);" MaxLength="10" Text='<%# Eval("EndDate")%>' ></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="regEndDate" runat="server" ValidationGroup="SaveGroup" ClientIDMode="Predictable"
                                        ErrorMessage="Invalid Date" Tooltip="Please enter date in dd/mm/yyyy format"  ForeColor="Red"   ControlToValidate="txtEdate" Display="Dynamic"  
                                        ValidationExpression="(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[012])/\d{4}" >
                                        </asp:RegularExpressionValidator>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>
                                             <asp:TemplateField HeaderText="File Type" ItemStyle-Width="10%" >
                                                <ItemTemplate>
                                               <asp:TextBox ID="txtlabel1" runat="server" Style="width:100%;" MaxLength="100"  onkeyup="return changeCells( this, this.id,event);"
                                                Text='<%# Eval("Label1") %>' ></asp:TextBox>
                                              <ajax:FilteredTextBoxExtender ID="fltrLable1" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                                        ValidChars=" -" TargetControlID="txtlabel1"/>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="From No." ItemStyle-Width="10%"   >
                                                <ItemTemplate>
                                               <asp:TextBox ID="txtlabel2" runat="server" Style="width:100%;" MaxLength="100"
                                             onkeyup="return changeCells( this, this.id,event);"       Text='<%# Eval("Label2") %>'></asp:TextBox>
                                              <ajax:FilteredTextBoxExtender ID="fltrLable2" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                                ValidChars=" -" TargetControlID="txtlabel2"/>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="To No." ItemStyle-Width="10%"  >
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtlabel3" runat="server" Style="width:100%;" MaxLength="100"
                                                     onkeyup="return changeCells( this, this.id,event);"    Text='<%# Eval("Label3") %>' ></asp:TextBox>
                                                <ajax:FilteredTextBoxExtender ID="fltrLable3" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                                        ValidChars=" -" TargetControlID="txtlabel3"/>
 
                                                </ItemTemplate>
                                                <ItemStyle Width="10%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>
                                               <asp:TemplateField HeaderText="Destruction Due Date<br/>(DD-MM-YYYY)" ItemStyle-Width="10%"   >
                                                <ItemTemplate>
                                              <asp:TextBox ID="txtDestructionDueDate" runat="server" Style="width:50%;" ValidationGroup="SaveGroup"  ClientIDMode="Predictable"  
                                                 MaxLength="10" Text='<%# Eval("DestructionDueDate")%>'   ></asp:TextBox>
                                               <asp:RegularExpressionValidator ID="regFromDate1" runat="server" ValidationGroup="SaveGroup" ClientIDMode="Predictable"
                                                ErrorMessage="Invalid Date" Tooltip="Please enter date in dd/mm/yyyy format"  ForeColor="Red"   ControlToValidate="txtDestructionDueDate" Display="Dynamic"  
                                                ValidationExpression="(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[012])/\d{4}"></asp:RegularExpressionValidator> 
                                                </ItemTemplate>
                                                <ItemStyle Width="10%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>
                                        </Columns>
                                        <AlternatingRowStyle CssClass="AlternativeRowStyle" />
                                    </asp:GridView>
                                   <%-- </div>--%>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="bordnone">
                                <asp:Button ID="btnSave" runat="server" Text="Save"  ValidationGroup="SaveGroup" OnClientClick="return validateFreshPickupall();"
                                    OnClick="btnSave_Click" CausesValidation="true"   />
                                <asp:Button ID="btnCancel" runat="server" Text="Clear"  OnClick="btnCancel_Click" />
                            </td>
                            <td colspan="2" class="bordnone">
                                <div style="float: right">
                                    <asp:Label ID="lblTotalCount" runat="server" Text="Label" ForeColor="Blue"></asp:Label>
                                    &nbsp; &nbsp;
                                    <asp:LinkButton ID="lnkbtnviewWoActivityDetails" runat="server" Text="View Details"
                                        OnClick="lnkbtnviewWoActivityDetails_Click" OnClientClick="return divShowWoActivityDetails();" Visible="false"></asp:LinkButton>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                   <div id="divModifyMaker" runat="server">
                    <table width="100%" style="border: 2px" border="0">
                       <tr>
                            <td width="12%">
                                Work Order
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlWorkOrderModify" runat="server" AutoPostBack="true" Width="210"
                                    OnSelectedIndexChanged="ddlWorkOrderModify_SelectedIndexChanged">
                                </asp:DropDownList>
                                <br />
                                <asp:Label runat="server" ID="lblActivityNameModify" ></asp:Label>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ControlToValidate="ddlWorkOrderModify"
                                    ErrorMessage="Please select work order." InitialValue="0" ForeColor="Red" ValidationGroup="ModifyGroup"
                                    Display="Dynamic"></asp:RequiredFieldValidator>
                            </td>
                            <td>
                               Customer
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlCustomerModify" runat="server"  Width="210"
                                  Enabled="false">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td width="15%">
                                Company Group
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlCompanyGroupModify" runat="server" Width="210"
                                  Enabled="false">
                                </asp:DropDownList>
                            </td>
                          <td style="width: 14%">
                                WareHouse
                            </td>
                            
                            <td colspan="4" >
                                <asp:DropDownList ID="ddlWareHouseModify" runat="server" Width="200" 
                                  Enabled="false">
                                </asp:DropDownList>
                                <br />
                            </td>
                        </tr>
                   
                           <tr>
                    <td> </td>
                    <td colspan="4"    >
                    <asp:RadioButtonList runat="server" ID="rbtactivityTypeModify" RepeatDirection="Horizontal"  
                            RepeatColumns="2"  Width="200px" 
                            AutoPostBack="true" 
                            onselectedindexchanged="rbtactivityTypeModify_SelectedIndexChanged"    >
                     <asp:ListItem Text="Update Box" Value="1"  ></asp:ListItem>
                    <asp:ListItem Text="Update File"  Value="2"  ></asp:ListItem>
                     </asp:RadioButtonList>
                     
                     </td>
                    </tr>
                        <tr>
                            <td colspan="4">
                        <div id='table-container1'>
                             <asp:GridView runat="server" ID="grdboxdetailsModify"  AutoGenerateColumns="false" 
                             Width="100%" BackColor="White" UseAccessibleHeader="true" DataKeyNames="BoxId"  
                             CssClass="ExcelTable2007-1 myTable scrollableFixedHeaderTable"  EmptyDataText="No Records Found" 
                              onrowdatabound="grdboxdetailsModify_RowDataBound" 
                                      HeaderStyle-CssClass="header"   >
                                        <Columns>
                                         <asp:TemplateField ItemStyle-Width="4%" HeaderStyle-Width="4%" ItemStyle-HorizontalAlign="Center" HeaderText = "Sr No." >
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'
                                                        Width="15px"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="4%"></ItemStyle>
                                            </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Select All" HeaderStyle-Width="5%">
                                                <HeaderTemplate>
                                                    <asp:CheckBox ID="chkSelectAll" runat="server" onclick="javascript:SelectAllCheckboxes(this,'grdboxdetailsModify');"/>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="cbSelect" runat="server" onClick="CheckSelectAll('grdboxdetailsModify');"></asp:CheckBox>
                                                </ItemTemplate>
                                                  <ItemStyle HorizontalAlign="Center" Width="5%"  ></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Center"   />
                                            </asp:TemplateField>
                                              <asp:TemplateField HeaderText="Box BarCode" ItemStyle-Width="25%" HeaderStyle-Width="25%" >
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtBoxBarCode" runat="server" Style="width:100%;" MaxLength="16"
                                                        Text='<%# Eval("BoxBarCode") %>' onkeyup="return changeCells( this, this.id,event);"  onchange="return findDuplicateBox(this.id,'grdboxdetailsModify');"  ></asp:TextBox>
                                                    <ajax:FilteredTextBoxExtender ID="FltBoxCodeExtenderModify" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                                        ValidChars="-" TargetControlID="txtBoxBarCode">
                                                    </ajax:FilteredTextBoxExtender>
                                                </ItemTemplate>
                                                <ItemStyle Width="25%"></ItemStyle>
                                                  </asp:TemplateField>
                                           <asp:TemplateField HeaderText="Box LocationCode"  >
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtBoxLocCode" runat="server" Style="width:100%;" MaxLength="15" 
                                                        Text='<%# Eval("BoxLocCode") %>' onkeyup="return changeCells( this, this.id,event);" ></asp:TextBox>
                                                   <ajax:FilteredTextBoxExtender ID="FltBoxLocExtenderModify" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                                        ValidChars=" -" TargetControlID="txtBoxLocCode">
                                                    </ajax:FilteredTextBoxExtender>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            </Columns>
                                            </asp:GridView>   
                                            <%--</div>
                                            <div class="div">--%>
                                    <asp:GridView runat="server" ID="grdFilesDetailsModify" CellSpacing="1" CellPadding="1"  
                                    AutoGenerateColumns="false"  CssClass="ExcelTable2007-1 myTable scrollableFixedHeaderTable" 
                                    width="1600px" DataKeyNames="FileId,DepartmentId"   EmptyDataText="No Records Found" 
                                     onrowdatabound="grdFilesDetailsModify_RowDataBound" HeaderStyle-CssClass="header"    >
                                        <Columns>
                                        
                                             <asp:TemplateField ItemStyle-Width="2%" ItemStyle-Height="7px" HeaderStyle-Width="2%" HeaderText = "Sr No." ItemStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'
                                                        Width="10px"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="2%"></ItemStyle>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Select All" HeaderStyle-Width="3%">
                                                <HeaderTemplate>
                                                    <asp:CheckBox ID="chkSelectAll" runat="server" onclick="javascript:SelectAllCheckboxes(this,'grdFilesDetailsModify');"/>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="cbSelect" runat="server" onClick="CheckSelectAll('grdFilesDetailsModify');"></asp:CheckBox><%--onClick="checkUncheckHeaderCheckBox(this,'grdFilesDetailsModify');"--%>
                                                </ItemTemplate>
                                                  <ItemStyle HorizontalAlign="Center" Width="2%"  ></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Center"   />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Box BarCode" ItemStyle-Height="7px" ItemStyle-Width="6%"  >
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtBoxBarCode" runat="server" Style="width:100%;" MaxLength="16" 
                                                        Text='<%# Eval("BoxBarCode") %>' onkeyup="return changeCells( this, this.id,event);" ></asp:TextBox>
                                                 <ajax:FilteredTextBoxExtender ID="fltrBxbarCodeModify" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                                        ValidChars="-" TargetControlID="txtBoxBarCode">
                                                    </ajax:FilteredTextBoxExtender>
                                                </ItemTemplate>
                                                <ItemStyle Width="7%" HorizontalAlign="Left"   ></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>
                                       
                                            <asp:TemplateField HeaderText="File BarCode" ItemStyle-Width="8%"  >
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtFileBarCode" runat="server" Style="width:100%;" MaxLength="16"
                                                        Text='<%# Eval("FileBarCode") %>' onchange="return findduplicatefileName(this.id,'grdFilesDetailsModify');" onkeyup="return changeCells( this, this.id,event);" ></asp:TextBox>
                                                  <ajax:FilteredTextBoxExtender ID="fltrFbarCodeModify" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                                        ValidChars="-" TargetControlID="txtFileBarCode">
                                                    </ajax:FilteredTextBoxExtender>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left"   ></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="File Description 1" ItemStyle-Width="8%"  >
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtFilename" runat="server" Style="width:100%;" MaxLength="255"
                                                        Text='<%# Eval("sFileName") %>' onkeyup="return changeCells( this, this.id,event);" ></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="File Description 2" ItemStyle-Width="10%"  >
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtFileDescription" runat="server" Style="width:100%;" MaxLength="255"
                                                        Text='<%# Eval("FileDescription1") %>' onkeyup="return changeCells( this, this.id,event);" ></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>
                                          <asp:TemplateField HeaderText="Department" ItemStyle-Width="10%"  >
                                                <ItemTemplate>
                                                <asp:DropDownList ID="ddlDepart" runat="server" Style="width: 135px;"
                                                 MaxLength="100" onkeyup="return changeCells( this, this.id,event);" >
                                                </asp:DropDownList>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>
                                             <asp:TemplateField HeaderText="Year<br/>eg. (2013,2013-14)" ItemStyle-Width="12%"  >
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtyear" runat="server" Style="width:100%;" MaxLength="10" 
                                                        Text='<%# Eval("sYear") %>'  ></asp:TextBox>
                                                          <ajax:FilteredTextBoxExtender ID="fltrYearModify" runat="server" FilterType="Numbers,Custom"
                                                        ValidChars="-" TargetControlID="txtyear">
                                                    </ajax:FilteredTextBoxExtender>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="From Date<br/>(DD-MM-YYYY)" ItemStyle-Width="12%"   >
                                                <ItemTemplate>
                                              <asp:TextBox ID="txtFdate" runat="server" Style="width:100%;" ValidationGroup="SaveGroup"  ClientIDMode="Predictable"  
                                                 MaxLength="10" Text='<%# Eval("FromDate")%>'   ></asp:TextBox>
                                               <asp:RegularExpressionValidator ID="regFromDateModify" runat="server" ValidationGroup="ModifyGroup" ClientIDMode="Predictable"
                                                ErrorMessage="Invalid Date" Tooltip="Please enter date in dd/mm/yyyy format"  ForeColor="Red"   ControlToValidate="txtFdate" Display="Dynamic"  
                                                ValidationExpression="(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[012])/\d{4}"></asp:RegularExpressionValidator> 
                                                </ItemTemplate>
                                                <ItemStyle Width="10%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>
                                        <asp:TemplateField HeaderText="To Date<br/>(DD-MM-YYYY)" ItemStyle-Width="12%" >
                                                <ItemTemplate>
                                           <asp:TextBox ID="txtEdate" runat="server" Style="width:100%;" 
                                              onkeyup="return changeCells( this, this.id,event);" MaxLength="10" Text='<%# Eval("EndDate")%>' ></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="regEndDateModify" runat="server" ValidationGroup="ModifyGroup" ClientIDMode="Predictable"
                                        ErrorMessage="Invalid Date" Tooltip="Please enter date in dd/mm/yyyy format"  ForeColor="Red"   ControlToValidate="txtEdate" Display="Dynamic"  
                                        ValidationExpression="(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[012])/\d{4}" >
                                        </asp:RegularExpressionValidator>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>
                                             <asp:TemplateField HeaderText="File Type" ItemStyle-Width="10%" >
                                                <ItemTemplate>
                                               <asp:TextBox ID="txtlabel1" runat="server" Style="width:100%;" MaxLength="100"  onkeyup="return changeCells( this, this.id,event);"
                                                Text='<%# Eval("Label1") %>' ></asp:TextBox>
                                               <ajax:FilteredTextBoxExtender ID="fltrLable1Modify" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                                        ValidChars=" -" TargetControlID="txtlabel1"/>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="From No." ItemStyle-Width="8%"   >
                                                <ItemTemplate>
                                               <asp:TextBox ID="txtlabel2" runat="server" Style="width:100%;" MaxLength="100"
                                             onkeyup="return changeCells( this, this.id,event);"       Text='<%# Eval("Label2") %>'></asp:TextBox>
                                              <ajax:FilteredTextBoxExtender ID="fltrLable2Modify" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                                ValidChars=" -" TargetControlID="txtlabel2"/>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="To No." ItemStyle-Width="10%"  >
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtlabel3" runat="server" Style="width:100%;" MaxLength="100"
                                                     onkeyup="return changeCells( this, this.id,event);"    Text='<%# Eval("Label3") %>' ></asp:TextBox>
                                                 <ajax:FilteredTextBoxExtender ID="fltrLable3Modify" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                                        ValidChars=" -" TargetControlID="txtlabel3"/>
 
                                                </ItemTemplate>
                                                <ItemStyle Width="10%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Destruction Due Date<br/>(DD-MM-YYYY)" ItemStyle-Width="12%"   >
                                                <ItemTemplate>
                                              <asp:TextBox ID="txtDestructionDueDate" runat="server" Style="width:90%;" ValidationGroup="SaveGroup"  ClientIDMode="Predictable"    onkeyup="return changeCells( this, this.id,event);" 
                                                 MaxLength="10" Text='<%# Eval("DestructionDueDate")%>'   ></asp:TextBox>
                                               <asp:RegularExpressionValidator ID="regFromDateModify1" runat="server" ValidationGroup="ModifyGroup" ClientIDMode="Predictable"
                                                ErrorMessage="Invalid Date" Tooltip="Please enter date in dd/mm/yyyy format"  ForeColor="Red"   ControlToValidate="txtDestructionDueDate" Display="Dynamic"  
                                                ValidationExpression="(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[012])/\d{4}"></asp:RegularExpressionValidator> 
                                                </ItemTemplate>
                                                <ItemStyle Width="10%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>
                                               <asp:TemplateField HeaderText="Status" ItemStyle-Width="10%"  >
                                                <ItemTemplate>
                                                    <asp:Label ID="lblStatus" runat="server" Style="width:100%;" 
                                                       Text='<%# Eval("FileStatus") %>' ></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>
                                          
                                            
                                                <asp:TemplateField HeaderText="Remarks" ItemStyle-Width="10%"  >
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRemarks" runat="server" Style="width:100%;" 
                                                       Text='<%# Eval("FileRemarks") %>' ></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>
                                        </Columns>
                                        <AlternatingRowStyle CssClass="AlternativeRowStyle" />
                                    </asp:GridView>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="bordnone">
                        <%--    OnClientClick="return validateFreshPickupall();"--%>
                                <asp:Button ID="btnModify" runat="server" Text="Update"  ValidationGroup="ModifyGroup" OnClientClick="return validateModifyMaker();"
                                    OnClick="btnModify_Click" CausesValidation="true"   />
                                <asp:Button ID="btnCancelModify" runat="server" Text="Clear"  OnClick="btnCancelModify_Click" />
                            </td>
                            <td colspan="2" class="bordnone">
                                <div style="float: right">
                                    <asp:Label ID="lblTotalCountModify" runat="server" Text="Label" ForeColor="Blue"></asp:Label>
                                    &nbsp; &nbsp;
                                    <asp:LinkButton ID="lnkbtnviewWoActivityDetailsModify" runat="server" Text="View Details"
                                        OnClick="lnkbtnviewWoActivityDetailsModify_Click" OnClientClick="return divShowWoActivityDetails();" Visible="false"></asp:LinkButton>
                                </div>
                            </td>
                        </tr>
                    </table>
                          </div>

  <div id="divChecker" runat="server">
          <table width="100%" style="border: 2px" border="0">
                       <tr>
                            <td width="12%">
                                Work Order
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlWorkOrderChecker" runat="server" AutoPostBack="true" Width="210"
                                    OnSelectedIndexChanged="ddlWorkOrderChecker_SelectedIndexChanged">
                                </asp:DropDownList>
                                <br />
                                <asp:Label runat="server" ID="lblActivityNameChecker" ></asp:Label>
                               <asp:RequiredFieldValidator ID="RfvWorkOrderChecker" runat="server" ControlToValidate="ddlWorkOrderChecker"
                                    ErrorMessage="Please select work order." InitialValue="0" ForeColor="Red" ValidationGroup="CheckerGroup"
                                    Display="Dynamic"></asp:RequiredFieldValidator>
                            </td>
                            <td>
                               Customer
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlCustomerChecker" runat="server"  Width="210"
                                  Enabled="false">
                                </asp:DropDownList>
                                <br />
                                <span id="Span3" style="color: Red;"></span>
                            </td>
                        </tr>
                        <tr>
                            <td width="15%">
                                Company Group
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlCompanyGroupChecker" runat="server" Width="210"
                                  Enabled="false">
                                </asp:DropDownList>
                                <span id="Span4" style="color: Red;"></span>
                                <br />
                            </td>
                          <td style="width: 14%">
                                WareHouse
                            </td>
                            
                            <td colspan="4" >
                                <asp:DropDownList ID="ddlWareHouseChecker" runat="server" Width="200" 
                                  Enabled="false">
                                </asp:DropDownList>
                                <br />
                            </td>
                        </tr>
                   
                           <tr>
                    <td> </td>
                    <td colspan="4"    >
                    <asp:RadioButtonList runat="server" ID="rbtApprovedRejectChecker" RepeatDirection="Horizontal"  
                            RepeatColumns="2"  Width="200px" 
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
                    </tr>
                        <tr>
                            <td colspan="4">
                        <div id='table-container2'>
                                    <asp:GridView runat="server" ID="grdFilesDetailsChecker" CellSpacing="1" CellPadding="1"  
                                    AutoGenerateColumns="false"  CssClass="ExcelTable2007-1 myTable scrollableFixedHeaderTable" 
                                    width="1600px" DataKeyNames="FileId,DepartmentId"   EmptyDataText="No Records Found" 
                                      HeaderStyle-CssClass="header"    >
                                        <Columns>

                                          <asp:TemplateField ItemStyle-Width="2%"  HeaderStyle-Width="2%" HeaderText = "Sr No." ItemStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'
                                                        Width="5px"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="3%"></ItemStyle>
                                            </asp:TemplateField>
                                          <asp:BoundField DataField="BoxBarCode" HeaderText="Box BarCode"> 
                                             <ItemStyle Width="10%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                                </asp:BoundField>

                                           <asp:BoundField DataField="FileBarCode" HeaderText="File BarCode">
                                              <ItemStyle Width="10%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                                </asp:BoundField>
                                            <asp:BoundField DataField="sFileName" HeaderText="File Description 1" >
                                             <ItemStyle Width="10%"></ItemStyle>
                                               <HeaderStyle HorizontalAlign="Left"   />
                                                </asp:BoundField>
                                                  <asp:BoundField DataField="FileDescription1" HeaderText="File Description 2" >
                                             <ItemStyle Width="10%"></ItemStyle>
                                               <HeaderStyle HorizontalAlign="Left"   />
                                                </asp:BoundField>
                                            <asp:BoundField DataField="Department" HeaderText="Department" > 
                                             <ItemStyle Width="10%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                                </asp:BoundField>
                                               <asp:TemplateField HeaderText="Year<br/>eg. (2013,2013-14)" 
                                               ItemStyle-Width="10%"  >
                                                <ItemTemplate>
                                                    <asp:Label ID="lblyear" runat="server" Style="width:100%;" 
                                                        Text='<%# Eval("sYear") %>'  ></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="From Date<br/>(DD-MM-YYYY)" 
                                            ItemStyle-Width="10%"   >
                                                <ItemTemplate>
                                              <asp:Label ID="lblFdate" runat="server" Style="width:50%;"   
                                                 Text='<%# Eval("FromDate")%>'   ></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>
                                        <asp:TemplateField HeaderText="To Date<br/>(DD-MM-YYYY)">
                                                <ItemTemplate>
                                           <asp:Label ID="lblEdate" runat="server" Style="width:50%;" 
                                              Text='<%# Eval("EndDate")%>' ></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>

                                             
                                             <asp:BoundField DataField="Label1" HeaderText="File Type">
                                            <ItemStyle Width="8%"></ItemStyle>
                                            <HeaderStyle HorizontalAlign="Left"   />
                                                </asp:BoundField>

                                        <asp:BoundField DataField="Label2" HeaderText="From No." >
                                            <ItemStyle Width="8%"></ItemStyle>
                                            <HeaderStyle HorizontalAlign="Left"   />
                                                </asp:BoundField>
                              
                                        <asp:BoundField DataField="Label3" HeaderText="To No.">
                                              <ItemStyle Width="8%"></ItemStyle>
                                               <HeaderStyle HorizontalAlign="Left"   />
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="Destruction Due Date<br/>(DD-MM-YYYY)" 
                                            ItemStyle-Width="10%"   >
                                                <ItemTemplate>
                                              <asp:Label ID="lblFdateDestructionDate" runat="server" Style="width:50%;"   
                                                 Text='<%# Eval("DestructionDueDate")%>'   ></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>
                                              <asp:BoundField DataField="FileStatus" HeaderText="Status" >
                                              <ItemStyle Width="10%"></ItemStyle>
                                                 <HeaderStyle HorizontalAlign="Left"   />
                                                </asp:BoundField>
                                                
                                              <asp:TemplateField HeaderText="Remarks" ItemStyle-Width="25%"  >
                                                <ItemTemplate> 
                                                    <asp:TextBox ID="txtRemarks" runat="server" 
                                                     MaxLength="200" style="width:100%"
                                                       Text='<%# Eval("FileRemarks") %>' ></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="25%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"/>
                                            </asp:TemplateField>
                                        </Columns>
                                        <AlternatingRowStyle CssClass="AlternativeRowStyle" />
                                    </asp:GridView>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="bordnone">
                                <asp:Button ID="btnApprove" runat="server" Text="Save"  ValidationGroup="CheckerGroup"
                                    OnClick="btnApprove_Click" CausesValidation="true"   OnClientClick="return validateChecker();"/>  <%--OnClientClick="return validateFreshPickupall();"--%>
                                <asp:Button ID="btnCancelApprove" runat="server" Text="Clear"  OnClick="btnCancelApprove_Click" />
                            </td>
                       
                        </tr>
                    </table>
                          </div>


                </div>
             </div>
              


            <div id="divDuplicateRecord" class="divActivityRate" style="display: none;">
                <div style="float: right">
                    <asp:HyperLink Text="Close" ForeColor="Blue" runat="server" Style="cursor: pointer"
                        ID="HyperLink1" onclick=" HidedivDuplicate();"></asp:HyperLink>
                </div>
                 <asp:Label runat="server" ID="lblMsg" Font-Bold="true" Font-Size="12px" Style="padding-left: 75px;"></asp:Label>
                <div style="overflow: auto; height: 100px; padding-left: 25px;">
                    <asp:GridView ID="grdduplicateEntry" runat="server" AutoGenerateColumns="true" Width="500px"
                        CssClass="grid_data">
                        <Columns>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
            <div id="divWoActivityDetails" class="divActivityRate" style="display: none; width:100%!important; padding-left:1px;">
                <div style="float: right;margin-top: -15px!important;">
                    <asp:HyperLink Text="Close" ForeColor="Blue" runat="server" Style="cursor: pointer;"
                        ID="HyperLink2" onclick=" HidedivWoActivityDetails();"></asp:HyperLink>
                </div>
                <asp:Label runat="server" ID="Label1" Font-Bold="true" Font-Size="12px"></asp:Label>
                <center>
                   <div style="overflow: auto; height:250px; width:100%;margin-top:10px;">
                    <asp:GridView ID="gridviewWoActivityDetails" runat="server" CellPadding="0" CellSpacing="0" Width="100%"  CssClass="grid_data" AutoGenerateColumns="false"  >
                    <Columns>
                      <asp:TemplateField HeaderText="Sr No."   ItemStyle-Width= "7%" >
                                <ItemTemplate>
                                    <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'  ></asp:Label>
                                </ItemTemplate>

<ItemStyle Width="7%"></ItemStyle>
                            </asp:TemplateField>
                    <asp:BoundField DataField="Box BarCode"  HeaderText="Box BarCode"   />
                    <asp:BoundField DataField="File BarCode" HeaderText="File BarCode"  />
                    <asp:TemplateField HeaderText="Year"  >
                    <ItemTemplate>
                    <asp:Label runat="server" ID="lblyear" Text='<%# Getyear(Eval("Year") ) %>'   ></asp:Label>
                     </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="From Date"  >
                    <ItemTemplate>
                    <asp:Label runat="server" ID="lblFromDate" Text='<%# GetFromatedDate(Eval("From Date") ) %>'   ></asp:Label>
                     </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="To Date"  >
                    <ItemTemplate>
                    <asp:Label runat="server" ID="lblToDate" Text='<%# GetFromatedDate(Eval("To Date") ) %>'   ></asp:Label>
                     </ItemTemplate>
                    </asp:TemplateField>
                    </Columns>
                    </asp:GridView>
                </div>
                </center>
          
            </div>
         
                   



            <div id="blocker" style="display: none">
                <div>
                    Loading...</div>
            </div>
           <%-- <script type="text/javascript">
                Sys.Application.add_load(BindBoxBarcodeEvents);
                            </script>--%>

                                 <script type="text/javascript">
                                     jQuery(function ($) {
                                         $("[id^='ContentPlaceHolder1_grdFilesDetails_txtFdate_']").mask('99/99/9999');
                                         $("[id^='ContentPlaceHolder1_grdFilesDetails_txtEdate_']").mask('99/99/9999');
                                         $("[id^='ContentPlaceHolder1_grdFilesDetails_txtyear_']").mask("9999? -99");
                                         $("[id^='ContentPlaceHolder1_grdFilesDetails_txtDestructionDueDate_']").mask('99/99/9999');

                                         $("[id^='ContentPlaceHolder1_grdFilesDetailsModify_txtFdate_']").mask('99/99/9999');
                                         $("[id^='ContentPlaceHolder1_grdFilesDetailsModify_txtEdate_']").mask('99/99/9999');
                                         $("[id^='ContentPlaceHolder1_grdFilesDetailsModify_txtyear_']").mask("9999? -99");

                                     });
                                         Sys.Application.add_load(function () { $('#ContentPlaceHolder1_grdboxdetails').scrollableFixedHeaderTable(600, 200); });
                                           Sys.Application.add_load(function () { $('#ContentPlaceHolder1_grdFilesDetails').scrollableFixedHeaderTable(1100, 200); });
                                            Sys.Application.add_load(function () { $('#ContentPlaceHolder1_grdboxdetailsModify').scrollableFixedHeaderTable(600, 200); });
                                            Sys.Application.add_load(function () { $('#ContentPlaceHolder1_grdFilesDetailsModify').scrollableFixedHeaderTable(1100, 200); });
                                            Sys.Application.add_load(function () { $('#ContentPlaceHolder1_grdboxdetailsChecker').scrollableFixedHeaderTable(600, 200); });
                                            Sys.Application.add_load(function () { $('#ContentPlaceHolder1_grdFilesDetailsChecker').scrollableFixedHeaderTable(1100, 200); });



                                            
  
  </script>

   <script type="text/javascript">

       Sys.Application.add_load(function () { $("[id^='ContentPlaceHolder1_grdFilesDetails_txtFdate_']").mask('99/99/9999'); });
       Sys.Application.add_load(function () { $("[id^='ContentPlaceHolder1_grdFilesDetails_txtEdate_']").mask('99/99/9999'); });
       Sys.Application.add_load(function () { $("[id^='ContentPlaceHolder1_grdFilesDetails_txtyear_']").mask("9999? -99"); });
       Sys.Application.add_load(function () { $("[id^='ContentPlaceHolder1_grdFilesDetails_txtDestructionDueDate_']").mask('99/99/9999'); });

       Sys.Application.add_load(function () { $("[id^='ContentPlaceHolder1_grdFilesDetailsModify_txtFdate_']").mask('99/99/9999'); });
       Sys.Application.add_load(function () { $("[id^='ContentPlaceHolder1_grdFilesDetailsModify_txtEdate_']").mask('99/99/9999'); });
       Sys.Application.add_load(function () { $("[id^='ContentPlaceHolder1_grdFilesDetailsModify_txtyear_']").mask("9999? -99"); });
       Sys.Application.add_load(function () { $("[id^='ContentPlaceHolder1_grdFilesDetailsModify_txtDestructionDueDate_']").mask('99/99/9999'); });

 </script>

     

        </ContentTemplate>
      
    </asp:UpdatePanel>
    

</asp:Content>
