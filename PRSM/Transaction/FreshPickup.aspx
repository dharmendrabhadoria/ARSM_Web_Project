<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true"
    CodeFile="FreshPickup.aspx.cs" Inherits="Transaction_FreshPickup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="../Styles/style.css" rel="stylesheet" type="text/css" />
     <link href="../Styles/scrollableFixedHeaderTable.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../scripts/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="../scripts/jquery.cookie.pack.js"></script>
    <script type="text/javascript" src="../scripts/jquery.dimensions.min.js"></script>
   <script type="text/javascript" src="../scripts/jquery.scrollableFixedHeaderTable.js"></script>
    <script type="text/javascript" src="../scripts/jquery-list-attributes.js"></script>
    <script src="../Scripts/Freshpickup.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.maskedinput-1.3.1.min_.js" type="text/javascript"></script>

    

    <style>
        .div
        {
            font-family: Arial, Helvetica, sans-serif;
            border: 1px solid #CCCCCC;
            width: 802px;
        }
        
        .myTable
        {
            background-color: BLACK;
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
    
    

    <ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </ajax:ToolkitScriptManager>
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


    <script src="../Scripts/Freshpickup.js" type="text/javascript" language="javascript" />
    <script type="text/javascript">
        Sys.Application.add_load(validbox());
    </script>
   
    <asp:UpdatePanel ID="updpnlfreshpickup" runat="server" >
        <ContentTemplate>
            <div class="clear">
            </div>
            <div class="middle">
                <div class="frmbxhead" style="width: 150px; z-index: 10!important;">
                    <asp:LinkButton ID="lnkbtnFreshPickup" runat="server" Font-Underline="false" Style="color: #4f4f4f !important;"
                        CausesValidation="false" OnClientClick="return false;"> Fresh Pick-Up </asp:LinkButton>
                </div>
                <div class="frmbox">
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
                    <tr >
                    <td colspan="4" align="right" >
                    <asp:Timer ID="Timer1" runat="server" Interval="120000" ontick="Timer1_Tick"/> <asp:Label runat="server" ID="lbltimerUpdate"  ></asp:Label>
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
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="ddlCompanyGroup"
                                    ErrorMessage="Please select company Group." InitialValue="0" ForeColor="Red"
                                    ValidationGroup="SaveGroupboxAdd" Display="Dynamic"></asp:RequiredFieldValidator>
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
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="ddlCustomer"
                                    Display="Dynamic" ErrorMessage="Please select customer." InitialValue="0" ForeColor="Red"
                                    ValidationGroup="SaveGroupboxAdd"></asp:RequiredFieldValidator>
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
                                    ErrorMessage="Please select work order." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroupboxAdd"
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
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="ddlWorkOrder"
                                    Display="Dynamic" ErrorMessage="Please select work order activity." InitialValue="0"
                                    ForeColor="Red" ValidationGroup="SaveGroupboxAdd"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                
                           <div id='table-container'>
                             <asp:GridView runat="server" ID="grdboxdetails"  AutoGenerateColumns="false" Width="100%" BackColor="White" UseAccessibleHeader="true"   CssClass="ExcelTable2007-1 myTable scrollableFixedHeaderTable" 
                                      HeaderStyle-CssClass="header"   >
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
                                                    <asp:TextBox ID="txtBoxBarCode" runat="server" Style="width:100%;" MaxLength="16"
                                                        Text='<%# Eval("BoxBarCode") %>' onkeyup="return changeCells( this, this.id,event)"  onchange="return findDuplicateBox(this.id);"  ></asp:TextBox>
                                                    <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender212" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                                        ValidChars="-" TargetControlID="txtBoxBarCode">
                                                    </ajax:FilteredTextBoxExtender>
                                                </ItemTemplate>
                                                <ItemStyle Width="25%"></ItemStyle>
                                            </asp:TemplateField>

                                           <asp:TemplateField HeaderText="Box LocationCode"  >
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtBoxLocCode" runat="server" Style="width:100%;" MaxLength="15" 
                                                        Text='<%# Eval("BoxLocCode") %>' onkeyup="return changeCells( this, this.id,event)" ></asp:TextBox>
                                                    <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender102" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                                        ValidChars=" -" TargetControlID="txtBoxLocCode">
                                                    </ajax:FilteredTextBoxExtender>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            </Columns>
                                            </asp:GridView>   
                                            <%--</div>
                                            <div class="div">--%>
                                    <asp:GridView runat="server" ID="grdFilesDetails" CellSpacing="1" CellPadding="1"  AutoGenerateColumns="false"  CssClass="ExcelTable2007-1 myTable scrollableFixedHeaderTable" width="1600px"
                                     OnRowCommand="grdFilesDetails_RowCommand"   onrowdatabound="grdFilesDetails_RowDataBound" HeaderStyle-CssClass="header"    >
                                        <Columns>
                                            <asp:TemplateField ItemStyle-Width="2%" ItemStyle-Height="7px" HeaderStyle-Width="2%" HeaderText = "Sr No." ItemStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'
                                                        Width="10px"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="3%"></ItemStyle>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Box BarCode" ItemStyle-Height="7px" ItemStyle-Width="7%"  >
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtBoxBarCode" runat="server" Style="width:100%;" MaxLength="16" 
                                                        Text='<%# Eval("BoxBarCode") %>' onkeyup="return changeCells( this, this.id,event)" ></asp:TextBox>
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
                                                        Text='<%# Eval("FileBarCode") %>' onchange="return findduplicatefileName(this.id);" onkeyup="return changeCells( this, this.id,event)" ></asp:TextBox>
                                                    <ajax:FilteredTextBoxExtender ID="fltrFbarCode" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                                        ValidChars="-" TargetControlID="txtFileBarCode">
                                                    </ajax:FilteredTextBoxExtender>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left"   ></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="File Name" ItemStyle-Width="10%"  >
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtFilename" runat="server" Style="width:100%;" MaxLength="255"
                                                        Text='<%# Eval("sFileName") %>' onkeyup="return changeCells( this, this.id,event)" ></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>
                                          <asp:TemplateField HeaderText="Department" ItemStyle-Width="10%"  >
                                                <ItemTemplate>
                                                <asp:DropDownList ID="ddlDepart" runat="server" Style="width: 135px;"
                                                 MaxLength="100" onkeyup="return changeCells( this, this.id,event)" >
                                                </asp:DropDownList>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>
                                         <asp:TemplateField HeaderText="Year<br/>eg. (2013,2013-14)" ItemStyle-Width="10%"  >
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtyear" runat="server" Style="width:100%;" MaxLength="10" 
                                                        Text='<%# Eval("sYear") %>'  ></asp:TextBox>
                                                          <ajax:FilteredTextBoxExtender ID="fltrYear" runat="server" FilterType="Numbers,Custom"
                                                        ValidChars="-" TargetControlID="txtyear">
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
                                              onkeyup="return changeCells( this, this.id,event)" MaxLength="10" Text='<%# Eval("EndDate")%>' ></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="regEndDate" runat="server" ValidationGroup="SaveGroup" ClientIDMode="Predictable"
                                        ErrorMessage="Invalid Date" Tooltip="Please enter date in dd/mm/yyyy format"  ForeColor="Red"   ControlToValidate="txtEdate" Display="Dynamic"  
                                        ValidationExpression="(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[012])/\d{4}" ></asp:RegularExpressionValidator> 
                                                </ItemTemplate>
                                                <ItemStyle Width="10%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>
                                             <asp:TemplateField HeaderText="Label1" ItemStyle-Width="10%" >
                                                <ItemTemplate>
                                               <asp:TextBox ID="txtlabel1" runat="server" Style="width:100%;" MaxLength="100"  onkeyup="return changeCells( this, this.id,event)"
                                                Text='<%# Eval("Label1") %>' ></asp:TextBox>
                                               <ajax:FilteredTextBoxExtender ID="fltrLable1" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                                        ValidChars=" -" TargetControlID="txtlabel1"/>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Label2" ItemStyle-Width="10%"   >
                                                <ItemTemplate>
                                               <asp:TextBox ID="txtlabel2" runat="server" Style="width:100%;" MaxLength="100"
                                             onkeyup="return changeCells( this, this.id,event)"       Text='<%# Eval("Label2") %>'></asp:TextBox>
                                               <ajax:FilteredTextBoxExtender ID="fltrLable2" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                                ValidChars=" -" TargetControlID="txtlabel2"/>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"   />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Label3" ItemStyle-Width="10%"  >
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtlabel3" runat="server" Style="width:100%;" MaxLength="100"
                                                     onkeyup="return changeCells( this, this.id,event)"    Text='<%# Eval("Label3") %>' ></asp:TextBox>
                                                  <ajax:FilteredTextBoxExtender ID="fltrLable3" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                                        ValidChars=" -" TargetControlID="txtlabel3"/>
 
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
            </div>
            <div id="divDuplicateRecord" class="divActivityRate" style="display: none;">
                <div style="float: right">
                    <asp:HyperLink Text="Close" ForeColor="Blue" runat="server" Style="cursor: pointer"
                        ID="HyperLink1" onclick=" HidedivDuplicate();"></asp:HyperLink>
                </div>
                <asp:Label runat="server" ID="lblMsg" Font-Bold="true" Font-Size="12px" Style="padding-left: 150px;"></asp:Label>
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

                                        <script type="text/javascript">
                                            jQuery(function ($) {
                                                $("[id^='ContentPlaceHolder1_grdFilesDetails_txtFdate_']").mask('99/99/9999');
                                                $("[id^='ContentPlaceHolder1_grdFilesDetails_txtEdate_']").mask('99/99/9999');
                                                $("[id^='ContentPlaceHolder1_grdFilesDetails_txtyear_']").mask("9999? -99");

                                            });

                                            Sys.Application.add_load(function () { $('#ContentPlaceHolder1_grdboxdetails').scrollableFixedHeaderTable(600, 200); });
                                            Sys.Application.add_load(function () { $('#ContentPlaceHolder1_grdFilesDetails').scrollableFixedHeaderTable(1100, 200); });
                                          

                                            
  
  </script>
</script>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="ddlCompanyGroup" EventName="SelectedIndexChanged" />
            <asp:PostBackTrigger ControlID="rbtactivityType" />
            
        </Triggers>

    </asp:UpdatePanel>
      <script type="text/javascript">

         Sys.Application.add_load(function () { $("[id^='ContentPlaceHolder1_grdFilesDetails_txtFdate_']").mask('99/99/9999'); });
         Sys.Application.add_load(function () { $("[id^='ContentPlaceHolder1_grdFilesDetails_txtEdate_']").mask('99/99/9999') });
         Sys.Application.add_load(function () { $("[id^='ContentPlaceHolder1_grdFilesDetails_txtyear_']").mask("9999? -99"); });
 </script>

</asp:Content>
