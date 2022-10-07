<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true"
    CodeFile="MonthlyInvoice_New.aspx.cs" Inherits="Transaction_MonthlyInvoice_New" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </ajax:ToolkitScriptManager>
    <script src="../Scripts/Invoice.js" type="text/javascript"></script>
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
            left: 400px;
            top: 200px;
        }
        .ExcelTable2007
        {
            border: 1px solid #B0CBEF;
            border-width: 1px 0px 0px 1px;
            font-size: 11pt;
            font-family: Calibri;
            font-weight: 100;
            border-spacing: 0px;
            border-collapse: collapse;
        }
    </style>
    <asp:UpdatePanel runat="server" ID="updInvoice">
        <ContentTemplate>
            </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnGenrateInvoice" />
            <asp:PostBackTrigger ControlID="grdInvoice" />
        </Triggers>
         </asp:UpdatePanel>
             <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Generate New Invoice</li>
            </ol>

            <div class="card card-transparent">

     <ul class="nav nav-tabs nav-tabs-linetriangle" data-init-reponsive-tabs="dropdownfx">
   <li class="nav-item">
        <asp:LinkButton ID="lnkbtnInovice" runat="server" Font-Underline="false" Style="color: #4f4f4f !important;"
                    CausesValidation="false" OnClick="lnkbtnInovice_Click"> Invoice</asp:LinkButton>

        </li>
      <li class="nav-item">
           <asp:LinkButton ID="lnkbtnviewInvoice" runat="server" Font-Underline="false" Style="color: #4f4f4f !important;"
                    CausesValidation="false" OnClick="lnkbtnviewInvoice_Click"> View Invoice</asp:LinkButton>

          </li>
         </ul>
                <div class="tab-content">
<div  runat="server" id="divGenrateInvoice">
            <div class="row" >
                <asp:Label ID="lblMessage" runat="server" Font-Bold="true" Font-Size="Medium" ForeColor="Brown"></asp:Label>
                <div class="col-md-3">
                     <div class="form-group form-group-default form-group-default-select2 required">
                           <label class="">Warehouse</label>
                    <asp:DropDownList ID="ddlWareHouse" runat="server" AutoPostBack="True" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2"
                                        OnSelectedIndexChanged="ddlWareHouse_SelectedIndexChanged">
                                    </asp:DropDownList>
                         </div>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlWareHouse"
                                        ErrorMessage="Please Select WareHouse." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-3"> <div class="form-group form-group-default">
                           <label class="">Warehouse</label>
                    <asp:TextBox ID="txtInvoiceDate" runat="server" CssClass="form-control" MaxLength="20"></asp:TextBox>
                    </div>
                </div>
                <div class="col-md-3">
                     <div class="form-group form-group-default form-group-default-select2 required">
                           <label class="">Warehouse</label>
                    <asp:DropDownList ID="ddlYear" runat="server" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2">
                                    </asp:DropDownList>
                         </div>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlYear"
                                        ErrorMessage="Please Select Year." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-3">
                     <div class="form-group form-group-default form-group-default-select2 required">
                           <label class="">Warehouse</label>
                    <asp:DropDownList ID="ddlMonth" runat="server" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2">
                                    </asp:DropDownList>
                         </div>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlMonth"
                                        ErrorMessage="Please Select Month." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                </div>
            </div>

    <div class="row">
        <label>Customer List</label>
        <div style=" height: 200px; overflow: auto; background-color: #FFF; border: 1px solid #596380;
                                        padding: 0 10px 0 0;" class="col-md-12">
                                        <asp:GridView ID="grdCustomer" runat="server" AutoGenerateColumns="False" CssClass="table table-hover table-condense"
                                            GridLines="None" AllowPaging="false">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Sr No." ItemStyle-Width="7%">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle Width="7%"></ItemStyle>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="CompanyGroupName" HeaderText="Company Group" ReadOnly="True">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="CustomerName" HeaderText="Customer Name" ReadOnly="True">
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="Billing Address">
                                                    <ItemTemplate>
                                                        <div style="overflow: auto; max-height: 35px;">
                                                            <asp:Label ID="lblAddress" runat="server" Text='<%# Bind("BillingAddress") %>'></asp:Label>
                                                        </div>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="" >
                                                    <ItemTemplate>
                                                        <asp:CheckBox runat="server" ID="chkstatus" />
                                                        <asp:HiddenField runat="server" ID="hdncustomerId" Value='<%# Bind("CustomerId") %>' />
                                                    </ItemTemplate>
                                                    <ItemStyle Width="20%"></ItemStyle>
                                                    <HeaderTemplate>
                                                        <asp:CheckBox runat="server" ID="chkBoxstatusAll" Text="  All" />
                                                    </HeaderTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <EmptyDataTemplate>
                                                <asp:Label ID="lblErrorMessage" runat="server" Font-Bold="true" Font-Size="Medium"
                                                    ForeColor="Brown" Text="No Record Found." Style="padding-left: 250px;"></asp:Label>
                                            </EmptyDataTemplate>
                                            <AlternatingRowStyle CssClass="AlternativeRowStyle" />
                                            <EmptyDataRowStyle VerticalAlign="Middle" />
                                        </asp:GridView>
                                    </div>
    </div>


    <div class="row m-t-20" >
        <div class="col-md-4">
             <div class="form-group form-group-default">
                           <label class="">Service Tax (%)</label>
                 <asp:TextBox ID="txtServicetax" runat="server"  MaxLength="5" CssClass="form-control"
                                        Enabled="false" onkeyup="onlyonedot(this.id,event,true)"></asp:TextBox>
                                  
                                   
                 </div>
             <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" TargetControlID="txtServicetax"
                                        Enabled="false" ValidChars="." FilterType="Numbers,Custom" />
        </div>
        <div class="col-md-4">
             <div class="form-group form-group-default">
                           <label class="">Swachh Bharat Cess (%)</label>
                  <asp:TextBox ID="txtSwachhBharatCess" runat="server" CssClass="form-control" MaxLength="5"
                                        onkeyup="onlyonedot(this.id,event,true)" Enabled="false"></asp:TextBox>
                                   
                 </div>
             <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" TargetControlID="txtSwachhBharatCess"
                                        ValidChars="." FilterType="Numbers,Custom" />
        </div>
        <div class="col-md-4">
             <div class="form-group form-group-default">
                           <label class="">Krishi Kalyan Cess (%)</label>
                 <asp:TextBox ID="txtKrishiKalyanCess" runat="server" CssClass="form-control" MaxLength="9"
                                        Enabled="false" onkeyup="onlyonedot(this.id,event,false)"></asp:TextBox>
                                   
                                    
                 </div>
            <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" runat="server" TargetControlID="txtKrishiKalyanCess"
                                        ValidChars="." FilterType="Numbers,Custom" />
        </div>
         <asp:TextBox ID="txtEducationCess" runat="server" Style="width: 100px;" MaxLength="9"
                                        Enabled="false" onkeyup="onlyonedot(this.id,event,false)" Visible="False"></asp:TextBox>
    </div>

    <div class="row">
        <div class="col-md-12">
            <asp:Button ID="btnGenrateInvoice" runat="server" Text="Generate" ValidationGroup="SaveGroup" type="button" CssClass="btn btn-primary"
                                        OnClick="btnGenrateInvoice_Click" OnClientClick="return validateInvoice();" />
                                    <asp:Button ID="btnCancel" runat="server" TabIndex="10" Text="Clear" OnClick="btnCancel_Click" type="button" CssClass="btn btn-primary" />
        </div>

    </div>

               </div>

            

                    <div runat="server" id="divViewInvoice">

                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group form-group-default form-group-default-select2 required">
                           <label class="">WareHouse</label>
                                    <asp:DropDownList ID="ddlWareHouse_ForGetInvoice" runat="server" AutoPostBack="True" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2"
                                        OnSelectedIndexChanged="ddlWareHouse_ForGetInvoice_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group form-group-default form-group-default-select2 required">
                           <label class="">Company Group</label>
                                    <asp:DropDownList ID="ddlCompanyGroup" runat="server" OnSelectedIndexChanged="ddlCompanyGroup_SelectedIndexChanged" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2"
                                        AutoPostBack="true">
                                    </asp:DropDownList>
                                    </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group form-group-default form-group-default-select2 required">
                           <label class="">Customer</label>
                                    <asp:DropDownList ID="ddlCustomer" runat="server" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2">
                                    </asp:DropDownList>
                                    </div>
                            </div>
                        </div>
                         <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlWareHouse"
                                        ErrorMessage="Please Select WareHouse." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>--%>
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="ddlCompanyGroup"
                                        ErrorMessage="Please Select Company Group." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroupview"></asp:RequiredFieldValidator>--%>
                         <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="ddlCustomer"
                                        ErrorMessage="Please Select Customer." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroupview"></asp:RequiredFieldValidator>--%>
                        
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group form-group-default form-group-default-select2 required">
                           <label class="">From Year</label>
                                    <asp:DropDownList ID="ddlYearView" runat="server" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2">
                                    </asp:DropDownList>
                                    </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group form-group-default form-group-default-select2 required">
                           <label class="">From Month</label>
                                    <asp:DropDownList ID="ddlMonthView" runat="server" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2">
                                    </asp:DropDownList>
                                    </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group form-group-default form-group-default-select2 required">
                           <label class="">To Year</label>
                                     <asp:DropDownList ID="ddlToYearView" runat="server" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2">
                                    </asp:DropDownList>
                                    </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group form-group-default form-group-default-select2 required">
                           <label class="">To Month</label>
                                    <asp:DropDownList ID="ddlToMonthView" runat="server" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2">
                                    </asp:DropDownList>
                                    </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                 <asp:Button ID="btnSearch" runat="server" Text="Search" Style="margin-top: 0px;"
                                        ValidationGroup="SaveGroupview" OnClick="btnSearch_Click" type="button" CssClass="btn btn-primary"/>
                            </div>
                        </div>

                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlYearView"
                            ErrorMessage="Please Select Year." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroupview"></asp:RequiredFieldValidator>--%>
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="ddlMonthView"
                            ErrorMessage="Please Select Month." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroupview"></asp:RequiredFieldValidator>--%>
                        <table width="100%">
                            
                           
                            <tr>
                                <td colspan="7" align="left">
                                    <asp:Label ID="lblSearchResult" runat="server" Text=""></asp:Label>
                                </td>
                                <%--<td colspan="5" align="right">
                                    <asp:Label ID="lblTotalAmt" runat="server" Text=""></asp:Label>
                                </td>--%>
                            </tr>
                            <tr>
                                <td colspan="6">
                                    <asp:GridView ID="grdInvoice" runat="server" AutoGenerateColumns="False" CssClass="table table-hover table-condense"
                                         GridLines="None" AllowPaging="True" OnRowCommand="grdInvoice_RowCommand"
                                        OnPageIndexChanging="grdInvoice_PageIndexChanging" OnRowDataBound="OnRowDataBound">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Sr No." ItemStyle-Width="7%">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="7%"></ItemStyle>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="CustomerName" HeaderText="Customer Name" ReadOnly="True"
                                                ControlStyle-Width="10%">
                                                <ControlStyle Width="10%" />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="InvoiceNo" ItemStyle-Width="10%">
                                                <ItemTemplate>
                                                    <%--<asp:Label ID="Label1" runat="server" Text='<% #GetInvoiceNum(Eval("InvoiceNo"))%> ' />--%>
                                                    <asp:LinkButton runat="server" ID="lnkbtnview" CommandArgument='<%# Bind("InvoiceNo") %>'
                                                        Text='<% #GetInvoiceNum(Eval("InvoiceNo"))%> ' ForeColor="Blue" Font-Underline="false"
                                                        CommandName="ViewInvoice" />
                                                    <asp:HiddenField runat="server" ID="hdncustomerId" Value='<%# Bind("CustomerId") %>' />
                                                </ItemTemplate>
                                                <ItemStyle Width="20%"></ItemStyle>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Daywise" ItemStyle-Width="20%">
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkBoxstatusDaywise" AutoPostBack="false" />
                                                    <asp:HiddenField ID="hfBillingMode" runat="server" Value='<%# Bind("BillingMode") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="InvoiceDate" HeaderText="Invoice Date " ReadOnly="True"
                                                ControlStyle-Width="10%" DataFormatString="{0:dd-MM-yyyy}">
                                                <ControlStyle Width="10%" />
                                            </asp:BoundField>
                                            <%-- <asp:BoundField DataField="TotalAmount" HeaderText="Total Amount " ReadOnly="True"
                                                ControlStyle-Width="10%">
                                                <ControlStyle Width="10%" />
                                            </asp:BoundField>--%>
                                            <asp:TemplateField HeaderText="Total Amount" ItemStyle-Width="7%">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTotAmt" runat="server" Text='<%# Bind("TotalAmount") %>'></asp:Label>
                                                    <asp:HiddenField ID="hfTotAmt" runat="server" Value='<%# Bind("AccountId") %>' />
                                                </ItemTemplate>
                                                <ItemStyle Width="7%"></ItemStyle>
                                            </asp:TemplateField>
                                            <%-- <asp:TemplateField HeaderText="" ItemStyle-Width="5%">
                                                <ItemTemplate>
                                                    <asp:LinkButton runat="server" ID="lnkbtnview" CommandArgument='<%# Bind("CustomerId") %>'
                                                        Text="View" ForeColor="Blue" Font-Underline="false" CommandName="ViewInvoice" />
                                                    <asp:HiddenField runat="server" ID="hdncustomerId" Value='<%# Bind("CustomerId") %>' />
                                                </ItemTemplate>
                                                <ItemStyle Width="20%"></ItemStyle>
                                            </asp:TemplateField>--%>
                                        </Columns>
                                        <AlternatingRowStyle CssClass="AlternativeRowStyle" />
                                        <EmptyDataRowStyle VerticalAlign="Middle" />
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </div>
                
            <div id="divShowResult" class="divActivityRate" style="display: none;">
                <div style="float: right">
                    <asp:HyperLink Text="Close" ForeColor="Blue" runat="server" Style="cursor: pointer"
                        ID="HyperLink1" onclick=" HidedivShowResult();"></asp:HyperLink>
                </div>
                <asp:Label runat="server" ID="lblMsg" Font-Bold="true" Font-Size="14px" Style="padding-left: 88px;"
                    Text="Invoice generated successfully."></asp:Label>
                <div style="overflow: auto; height: 100px; padding-left: 25px;">
                    <asp:GridView ID="grdresult" runat="server" Width="100%">
                    </asp:GridView>
                </div>
            </div>

                    </div>
                </div>
             
            <div id="blocker" style="display: none">
                <div>
                    Loading...</div>
           
       
   
</asp:Content>
