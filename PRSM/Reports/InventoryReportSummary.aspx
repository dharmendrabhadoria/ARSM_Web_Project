<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true"
    CodeFile="InventoryReportSummary.aspx.cs" Inherits="InventoryReportSummary" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../Scripts/FilePickupReport.js" type="text/javascript"></script>
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
            top: 10px;
            border: #e4e4e4 2px solid;
            box-shadow: 0 0 20px #000;
            width: 900px;
            left: 16%;
            margin-left: -80px;
            display: none;
        }
        
        .divActivityContract
        {
            background-color: #ffffff;
            z-index: 9999;
            position: fixed;
            background: #ffffff;
            padding: 20px;
            top: 12px;
            border: #e4e4e4 2px solid;
            box-shadow: 0 0 20px #000;
            width: 900px;
            left: 16%;
            margin-left: -80px;
            display: none;
        }
        .frmbox td
        {
            padding: 5px;
        }
    </style>
    <script language="javascript" type="text/javascript">

        function divShowInFilesdetails() {
            $('#divShowInFilesdetails').show();
            $("#blocker").attr('style', 'display:block');
            $("#divShowInFilesdetails").attr('style', 'display:block');
        }
        function divShowInBoxdetails() {
            $('#divShowInBoxdetails').show();
            $("#blocker").attr('style', 'display:block');
            $("#divShowInBoxdetails").attr('style', 'display:block');
        }
        function divShowOutFilesdetails() {
            $('#divShowOutFilesdetails').show();
            $("#blocker").attr('style', 'display:block');
            $("#divShowOutFilesdetails").attr('style', 'display:block');
        }
        function divShowOutBoxdetails() {
            $('#divShowOutBoxdetails').show();
            $("#blocker").attr('style', 'display:block');
            $("#divShowOutBoxdetails").attr('style', 'display:block');
        }
        function divHideInFilesdetails() {
            $('#divShowInFilesdetails').hide();
            $("#divShowInFilesdetails").attr('style', 'display:none');
            $("#blocker").attr('style', 'display:none');
        }
        function divHideInBoxdetails() {
            $('#divShowInBoxdetails').hide();
            $("#divShowInBoxdetails").attr('style', 'display:none');
            $("#blocker").attr('style', 'display:none');
        }
        function divHideOutFilesdetails() {
            $('#divShowOutFilesdetails').hide();
            $("#divShowOutFilesdetails").attr('style', 'display:none');
            $("#blocker").attr('style', 'display:none');
        }
        function divHideOutBoxdetails() {
            $('#divShowOutBoxdetails').hide();
            $("#divShowOutBoxdetails").attr('style', 'display:none');
            $("#blocker").attr('style', 'display:none');
        }
    </script>
    <ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </ajax:ToolkitScriptManager>
    <asp:UpdatePanel ID="updActivity" runat="server">
        <ContentTemplate>
            <script type="text/javascript">
                Sys.Application.add_load(BindDates);
            </script>
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Inventory</li>
            </ol>

            <div class="card card-transparent">

     <ul class="nav nav-tabs nav-tabs-linetriangle" data-init-reponsive-tabs="dropdownfx">
   <li class="nav-item">
        <asp:LinkButton ID="lnkbtnInventorySummary" runat="server" Font-Underline="false"
                        Style="color: #4f4f4f !important;" CausesValidation="false" OnClick="lnkbtnInventorySummary_Click">Inventory Summary</asp:LinkButton>

        </li>
      <li class="nav-item">

           <asp:LinkButton ID="lnkbtnInventoryDeatils" runat="server" Font-Underline="false"
                        Style="color: #4f4f4f !important;" CausesValidation="false" OnClick="lnkbtnInventoryDeatils_Click">Inventory Details</asp:LinkButton>

           </li>
         </ul>


                <div class="tab-content">
                     <div id="divInventorySummary" runat="server" style="display: block;">
                    <div class="row">
                        <div class="col-md-12">
                            <asp:RadioButtonList ID="rdlstbtnReport" runat="server" AutoPostBack="True" Height="16px"
                                            RepeatDirection="Horizontal" Width="300px" OnSelectedIndexChanged="rdlstbtnReport_SelectedIndexChanged">
                                            <asp:ListItem Selected="True" Text=" Customer-Wise" Value="1"></asp:ListItem>
                                            <%--<asp:ListItem Text="Department-Wise" Value="2"> </asp:ListItem>--%>
                                            <asp:ListItem Text=" Yearwise" Value="3"> </asp:ListItem>
                                        </asp:RadioButtonList>
                        </div>

                    </div>

                         <div class="row">
                             <div class="col-md-4">
                                 <div class="form-group form-group-default form-group-default-select2 required">
                           <label class="">Company Group</label>
                                     <asp:DropDownList ID="ddlCompanyGroup" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlCompanyGroup_SelectedIndexChanged" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2"
                                            >
                                        </asp:DropDownList>
                                     </div>
                             </div>
                             <div class="col-md-4">
                                 <div class="form-group form-group-default form-group-default-select2 required">
                           <label class="">Customer</label>
                                     <asp:DropDownList ID="ddlCustomer" runat="server" AutoPostBack="true" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2">
                                        </asp:DropDownList>
                                     </div>
                             </div>
                             <div class="col-md-4">
                                 <asp:Label runat="server" Text="Year" ID="lblyear">Year</asp:Label>
                                        <asp:DropDownList ID="ddlyears" runat="server" AutoPostBack="true" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2">
                                            <asp:ListItem Selected="True" Text="All" Value="0"> </asp:ListItem>
                                            <asp:ListItem Text="2013" Value="2013"> </asp:ListItem>
                                            <asp:ListItem Text="2014" Value="2014"> </asp:ListItem>
                                            <asp:ListItem Text="2015" Value="2015"> </asp:ListItem>
                                        </asp:DropDownList>
                             </div>

                         </div>
                         <div class="row">
                             <div class="col-md-6">
                                 <div class="form-group form-group-default">
                           <asp:Label ID="lblfrmdt" runat="server" Text="From Date"></asp:Label>
                                     <asp:TextBox ID="txtfromDate" runat="server" CssClass="datepicker1 form-control" onkeypress="return false;"> </asp:TextBox>
                                     </div>
                             </div>
                             <div class="col-md-6">
                                  <div class="form-group form-group-default">
                           <asp:Label ID="lbltodate" runat="server" Text="To Date"></asp:Label>
                                      <asp:TextBox ID="txttodate" runat="server" CssClass="datepicker1 form-control" onkeypress="return false;"> </asp:TextBox>
                                     </div>
                             </div>

                         </div>



                   
                            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                               
                                <tr>
                                    <td style="width: 10%">
                                        
                                    </td>
                                    <td style="width: 10%">
                                        
                                    </td>
                                    <td style="width: 10%">
                                        
                                    </td>
                                    <td style="width: 10%">
                                        
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                        <asp:Button ID="btnview" runat="server" Text="View" OnClick="btnview_Click1" OnClientClick="javascript:return Validate();" />
                                        <asp:Button ID="btnViewDetails" runat="server" Text="View" Visible="false" OnClick="btnViewDetails_Click" />
                                        <asp:Button ID="btnViewClear" runat="server" Text="Clear" OnClick="btnViewClear_Click" />
                                    </td>
                                    <asp:Panel ID="pnlExportype" runat="server" Visible="false">
                                        <td style="width: 5%">
                                            Type
                                        </td>
                                        <td>
                                            <table border="0">
                                                <tr>
                                                    <td>
                                                        <asp:RadioButtonList ID="rdbtnlstReportType" runat="server" AutoPostBack="true" RepeatDirection="Horizontal">
                                                            <asp:ListItem Text="PDF" Value="0" Selected="True"></asp:ListItem>
                                                            <asp:ListItem Text="Excel" Value="1"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnExportToExcel" runat="server" OnClick="btnExportToExcel_Click"
                                                            Text="Export & Print" Visible="false" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                        </td>
                                    </asp:Panel>
                                </tr>
                                <tr>
                                    <td colspan="5">
                                        <asp:Label ID="lb1Message" runat="server" Text="" ForeColor="Red" Font-Size="Small"
                                            Visible="false"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <table width="100%" border="0">
                                <tr>
                                    <td style="width: 0%">
                                        &nbsp;
                                    </td>
                                    <td>
                                        <%--  <div style="float: right">
                                        </div>--%>
                                        <div id="AsOnDateGrid" runat="server" style="display: none; overflow: auto; padding-left: 0px;
                                            color: #4f4f4f; font-size: 12px; width: 100%; height: 200px; line-height: 20px;">
                                            <asp:GridView ID="gvInventoryReport" runat="server" AutoGenerateColumns="false" CssClass="grid_data"
                                                ShowFooter="true" ShowHeader="true" Width="100%" OnRowDataBound="gvInventoryReport_RowDataBound">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Customer Name">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblName" runat="server" Text='<%# Eval("CustomerName") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblTotal" runat="server" Font-Bold="true" Font-Size="14px" Text="Total"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="30%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="No. Of In Boxes">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblNoOfInBoxes" runat="server" Text='<%# Eval("InBox") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblGrandTotalInBoxes" runat="server" Font-Bold="true"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="10%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="No. Of Out Boxes">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblNoOfOutBoxes" runat="server" Text='<%# Eval("OutBox") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblGrandTotalOutBoxes" runat="server" Font-Bold="true"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="10%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Total Boxes">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblTotalBoxes" runat="server" Text='<%# Eval("TotalBoxes") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblGrandTotalBoxes" runat="server" Font-Bold="true"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="10%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="No. Of In Files">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblNoOfInFiles" runat="server" Text='<%# Eval("InFile") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblGrandTotalInFiles" runat="server" Font-Bold="true"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="10%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="No. Of Out Files">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblNoOfOutFiles" runat="server" Text='<%# Eval("OutFile") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblGrandTotalOutFiles" runat="server" Font-Bold="true"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="10%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Total Files">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblTotalFiles" runat="server" Text='<%# Eval("TotalFiles") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblGrandTotalFiles" runat="server" Font-Bold="true"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="10%" />
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                        <div id="divgvInventoryDept" runat="server" style="display: none; overflow: auto;
                                            padding-left: 0px; color: #4f4f4f; font-size: 12px; width: 82%; height: 200px;
                                            line-height: 20px; display: none;">
                                            <asp:GridView ID="gvSummaryDept" runat="server" AutoGenerateColumns="false" CssClass="grid_data"
                                                ShowFooter="true" Width="100%" OnRowDataBound="gvSummaryDept_RowDataBound">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Department Name">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblDept" runat="server" Text='<%# Eval("DepartmentName") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblTotal" runat="server" Font-Bold="true" Font-Size="14px" Text="Total"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="10%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="In Boxes">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblNoOfINBoxes" runat="server" Text='<%# Eval("InBox") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblGrandTotalInBoxes" runat="server" Font-Bold="true"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="15%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Out Boxes">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblNoOfOUTBoxes" runat="server" Text='<%# Eval("OutBox") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblGrandTotalOutBoxes" runat="server" Font-Bold="true"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="15%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Total Boxes">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblTotalBoxes" runat="server" Text='<%# Eval("TotalBoxes") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblGrandTotalBoxes" runat="server" Font-Bold="true"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="15%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="No. Of In Files">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblNoOfInFiles" runat="server" Text='<%# Eval("InFile") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblGrandTotalInFiles" runat="server" Font-Bold="true"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="10%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="No. Of Out Files">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblNoOfOutFiles" runat="server" Text='<%# Eval("OutFile") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblGrandTotalOutFiles" runat="server" Font-Bold="true"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="10%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="TotalFiles">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblTotalFiles" runat="server" Text='<%# Eval("TotalFiles") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblGrandTotalFiles" runat="server" Font-Bold="true"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="10%" />
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                        <div id="divgvIventoryYear" runat="server" style="display: none; overflow: auto;
                                            padding-left: 0px; color: #4f4f4f; font-size: 12px; width: 70%; height: 200px;
                                            line-height: 20px; display: none; vertical-align: top;">
                                            <asp:GridView ID="gvSummaryYear" runat="server" AutoGenerateColumns="false" CssClass="grid_data"
                                                ShowFooter="true" ShowHeader="true" Width="100%" OnRowDataBound="gvSummaryYear_RowDataBound">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Years">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblYears" runat="server" Text='<%# Eval("Years") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="15%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="In Boxes">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblNoOfINBoxes" runat="server" Text='<%# Eval("InBox") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblGrandTotalInBoxes" runat="server" Font-Bold="true"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="15%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Out Boxes">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblNoOfOUTBoxes" runat="server" Text='<%# Eval("OutBox") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblGrandTotalOutBoxes" runat="server" Font-Bold="true"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="15%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Total Boxes">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblTotalNoOfBoxes" runat="server" Text='<%# Eval("TotalBoxes")  %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblGrandTotalBoxes" runat="server" Font-Bold="true"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="15%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="No. Of In Files">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblNoOfInFiles" runat="server" Text='<%# Eval("InFile") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblGrandTotalInFiles" runat="server" Font-Bold="true"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="10%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="No. Of Out Files">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblNoOfOutFiles" runat="server" Text='<%# Eval("OutFile") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblGrandTotalOutFiles" runat="server" Font-Bold="true"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="10%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="TotalFiles">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblTotalFiles" runat="server" Text='<%# Eval("TotalFiles") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblGrandTotalFiles" runat="server" Font-Bold="true"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="10%" />
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                        <!-- as on date -->
                                        <div id="divInventorySummaryDetails" runat="server" style="display: none;">
                                            <asp:GridView ID="gvInventoryDetail" runat="server" AutoGenerateColumns="false" CssClass="grid_data"
                                                ShowFooter="false" ShowHeader="true" Width="100%" OnRowCommand="gvInventoryDetail_RowCommand">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Years">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblYears" runat="server" Text='<%# Eval("Years") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="10%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="In Boxes">
                                                        <ItemTemplate>
                                                            <%--  <asp:Label ID="lblNoOfINBoxes" runat="server" Text='<%# Eval("InBox") %>'></asp:Label>--%>
                                                            <asp:LinkButton ID="lnkbtnviewBoxes" runat="server" Text='<%# Eval("InBox") %>' CommandArgument='<%# Eval("Years") %>'
                                                                CommandName="lnkviewInBoxesDetails" Font-Underline="true" Style="cursor: pointer"
                                                                ToolTip="Show Boxes Details" />
                                                        </ItemTemplate>
                                                        <ItemStyle Width="10%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Out Boxes">
                                                        <ItemTemplate>
                                                            <%--<asp:Label ID="lblNoOfOUTBoxes" runat="server" Text='<%# Eval("OutBox") %>'></asp:Label>--%>
                                                            <asp:LinkButton ID="lnkbtnviewBoxes1" runat="server" Text='<%# Eval("OutBox") %>'
                                                                CommandArgument='<%# Eval("Years") %>' CommandName="lnkviewOutBoxesDetails" Font-Underline="true"
                                                                Style="cursor: pointer" ToolTip="Show Boxes Details" />
                                                        </ItemTemplate>
                                                        <ItemStyle Width="10%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Total Boxes">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblTotalNoOfBoxes" runat="server" Text='<%# Eval("TotalBoxes")  %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="10%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="No. Of In Files">
                                                        <ItemTemplate>
                                                            <%--   <asp:Label ID="lblNoOfInFiles" runat="server" Text='<%# Eval("InFile") %>'></asp:Label>--%>
                                                            <asp:LinkButton ID="lnkbtnviewBoxes2" runat="server" Text='<%# Eval("InFile") %>'
                                                                CommandArgument='<%# Eval("Years") %>' CommandName="lnkviewInFilesDetails" Font-Underline="true"
                                                                Style="cursor: pointer" ToolTip="Show File Details" />
                                                            </div>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblGrandTotalInFiles" runat="server" Font-Bold="true"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="10%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="No. Of Out Files">
                                                        <ItemTemplate>
                                                            <%-- <asp:Label ID="lblNoOfOutFiles" runat="server" Text='<%# Eval("OutFile") %>'></asp:Label>--%>
                                                            <asp:LinkButton ID="lnkbtnviewBoxes3" runat="server" Text='<%# Eval("OutFile") %>'
                                                                CommandArgument='<%# Eval("Years") %>' CommandName="lnkviewOutFilesDetails" Font-Underline="true"
                                                                Style="cursor: pointer" ToolTip="Show File Details" />
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblGrandTotalOutFiles" runat="server" Font-Bold="true"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="10%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="TotalFiles">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblTotalFiles" runat="server" Text='<%# Eval("TotalFiles") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblGrandTotalFiles" runat="server" Font-Bold="true"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="10%" />
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>







                    



                    <div id="divShowInFilesdetails" class="divActivityRate" style="width: 910px !important;">
                            <div style="float: right">
                                <asp:Button Text="Close" ForeColor="Blue" runat="server" Style="cursor: pointer"
                                    ID="btnInFilesdetails" OnClientClick=" divHideInFilesdetails();" OnClick="btnInFilesdetails_Click">
                                </asp:Button>
                            </div>
                            <br />
                            <div id="PrintdivShowWodetails" style="overflow: auto; padding-left: 15px; color: #4f4f4f;
                                font-size: 12px; width: 900px; height: 450px; line-height: 20px;">
                                <table style="text-align: left; width: 100%; height: auto;" border="0">
                                    <tr>
                                        <td colspan="6" style="text-align: center;">
                                            In Files Details
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6">
                                            <asp:GridView runat="server" ID="gvInFilesDetails" AutoGenerateColumns="false" Width="120%"
                                                BackColor="White" UseAccessibleHeader="true" CssClass="grid_data" HeaderStyle-CssClass="header"
                                                AllowPaging="True" OnPageIndexChanging="gvInFilesDetails_PageIndexChanging">
                                                <EmptyDataTemplate>
                                                    <label style="width: 300px; color: Red; text-align: center; font-size: medium; padding-left: 400px;
                                                        font: message-box;">
                                                        No Record Available
                                                    </label>
                                                </EmptyDataTemplate>
                                                <Columns>
                                                    <asp:BoundField HeaderText="Box BarCode" ItemStyle-Width="10%" DataField="BoxBarCode" />
                                                    <asp:BoundField HeaderText="File BarCode" ItemStyle-Width="10%" DataField="FileBarcode" />
                                                    <asp:BoundField HeaderText="LocationCode" ItemStyle-Width="10%" DataField="LocationCode" />
                                                    <asp:BoundField HeaderText="File Description1" ItemStyle-Width="13%" DataField="FileDescription1" />
                                                    <asp:BoundField HeaderText="File Description2" ItemStyle-Width="13%" DataField="FileDescription2" />
                                                    <asp:BoundField HeaderText="Department" ItemStyle-Width="7%" DataField="DepartmentName" />
                                                    <asp:BoundField HeaderText="Year" ItemStyle-Width="7%" DataField="Year" />
                                                    <asp:BoundField HeaderText="From Date" ItemStyle-Width="8%" DataField="FromDate" />
                                                    <asp:BoundField HeaderText="To Date" ItemStyle-Width="8%" DataField="ToDate" />
                                                    <asp:BoundField HeaderText="File Type" ItemStyle-Width="8%" DataField="File Type" />
                                                    <asp:BoundField HeaderText="From No" ItemStyle-Width="8%" DataField="FromNo" />
                                                    <asp:BoundField HeaderText="To No" ItemStyle-Width="8%" DataField="ToNo" />
                                                    <asp:BoundField HeaderText="Destruction Due Date" ItemStyle-Width="8%" DataField="DestructionDueDate" />
                                                    <asp:BoundField HeaderText="Activity" ItemStyle-Width="8%" DataField="Activity" />
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>

                    <div id="divShowInBoxdetails" class="divActivityRate" style="width: 910px !important;">
                            <div style="float: right">
                                <asp:Button Text="Close" ForeColor="Blue" runat="server" Style="cursor: pointer"
                                    ID="btnInBoxdetails" OnClientClick=" divHideInBoxdetails();" OnClick="btnInBoxdetails_Click">
                                </asp:Button>
                            </div>
                            <br />
                            <div id="Div2" style="overflow: auto; padding-left: 15px; color: #4f4f4f; font-size: 12px;
                                width: 900px; height: 450px; line-height: 20px;">
                                <table style="text-align: left; width: 100%; height: auto;" border="0">
                                    <tr>
                                        <td colspan="6" style="text-align: center;">
                                            In Box Details
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6">
                                            <asp:GridView runat="server" ID="gvInBoxDetails" AutoGenerateColumns="false" Width="100%"
                                                BackColor="White" UseAccessibleHeader="true" CssClass="grid_data" HeaderStyle-CssClass="header"
                                                AllowPaging="True" OnPageIndexChanging="gvInBoxDetails_PageIndexChanging">
                                                <EmptyDataTemplate>
                                                    <label style="width: 300px; color: Red; text-align: center; font-size: medium; padding-left: 400px;
                                                        font: message-box;">
                                                        No Record Available
                                                    </label>
                                                </EmptyDataTemplate>
                                                <Columns>
                                                    <%--    <asp:BoundField HeaderText="Department" ItemStyle-Width="10%" DataField="Department" />--%>
                                                    <asp:BoundField HeaderText="Box Barcode" ItemStyle-Width="10%" DataField="BoxBarcode" />
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>

                    <div id="divShowOutFilesdetails" class="divActivityRate" style="width: 910px !important;">
                            <div style="float: right">
                                <asp:Button Text="Close" ForeColor="Blue" runat="server" Style="cursor: pointer"
                                    ID="btnOutFilesdetails" OnClientClick=" divHideOutFilesdetails();" OnClick="btnOutFilesdetails_Click">
                                </asp:Button>
                            </div>
                            <br />
                            <div id="Div3" style="overflow: auto; padding-left: 15px; color: #4f4f4f; font-size: 12px;
                                width: 900px; height: 450px; line-height: 20px;">
                                <table style="text-align: left; width: 100%; height: auto;" border="0">
                                    <tr>
                                        <td colspan="6" style="text-align: center;">
                                            Out Files Details
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6">
                                            <asp:GridView runat="server" ID="gvOutFilesDetails" AutoGenerateColumns="false" Width="120%"
                                                BackColor="White" UseAccessibleHeader="true" CssClass="grid_data" HeaderStyle-CssClass="header"
                                                AllowPaging="True" OnPageIndexChanging="gvOutFilesDetails_PageIndexChanging">
                                                <EmptyDataTemplate>
                                                    <label style="width: 300px; color: Red; text-align: center; font-size: medium; padding-left: 400px;
                                                        font: message-box;">
                                                        No Record Available
                                                    </label>
                                                </EmptyDataTemplate>
                                                <Columns>
                                                    <asp:BoundField HeaderText="Box BarCode" ItemStyle-Width="10%" DataField="BoxBarcode" />
                                                    <asp:BoundField HeaderText="File BarCode" ItemStyle-Width="10%" DataField="FileBarcode" />
                                                    <asp:BoundField HeaderText="LocationCode" ItemStyle-Width="10%" DataField="LocationCode" />
                                                    <asp:BoundField HeaderText="File Description1" ItemStyle-Width="13%" DataField="FileDescription1" />
                                                    <asp:BoundField HeaderText="File Description2" ItemStyle-Width="13%" DataField="FileDescription2" />
                                                    <asp:BoundField HeaderText="Department" ItemStyle-Width="7%" DataField="DepartmentName" />
                                                    <asp:BoundField HeaderText="Year" ItemStyle-Width="7%" DataField="Year" />
                                                    <asp:BoundField HeaderText="From Date" ItemStyle-Width="8%" DataField="FromDate" />
                                                    <asp:BoundField HeaderText="To Date" ItemStyle-Width="8%" DataField="ToDate" />
                                                    <asp:BoundField HeaderText="File Type" ItemStyle-Width="8%" DataField="File Type" />
                                                    <asp:BoundField HeaderText="From No" ItemStyle-Width="8%" DataField="FromNo" />
                                                    <asp:BoundField HeaderText="To No" ItemStyle-Width="8%" DataField="ToNo" />
                                                    <asp:BoundField HeaderText="Destruction Due Date" ItemStyle-Width="8%" DataField="DestructionDueDate" />
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>

                    <div id="divShowOutBoxdetails" class="divActivityRate" style="width: 910px !important;">
                            <div style="float: right">
                                <asp:Button Text="Close" ForeColor="Blue" runat="server" Style="cursor: pointer"
                                    ID="btnOutBoxdetails" OnClientClick=" divHideOutBoxdetails();" OnClick="btnOutBoxdetails_Click">
                                </asp:Button>
                            </div>
                            <br />
                            <div id="Div4" style="overflow: auto; padding-left: 15px; color: #4f4f4f; font-size: 12px;
                                width: 900px; height: 450px; line-height: 20px;">
                                <table style="text-align: left; width: 100%; height: auto;" border="0">
                                    <tr>
                                        <td colspan="6" style="text-align: center;">
                                            Out Box Details
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6">
                                            <asp:GridView runat="server" ID="gvOutBoxDetails" AutoGenerateColumns="false" Width="100%"
                                                BackColor="White" UseAccessibleHeader="true" CssClass="grid_data" HeaderStyle-CssClass="header"
                                                AllowPaging="True" OnPageIndexChanging="gvOutBoxDetails_PageIndexChanging">
                                                <EmptyDataTemplate>
                                                    <label style="width: 300px; color: Red; text-align: center; font-size: medium; padding-left: 400px;
                                                        font: message-box;">
                                                        No Record Available
                                                    </label>
                                                </EmptyDataTemplate>
                                                <Columns>
                                                    <%-- <asp:BoundField HeaderText="Department" ItemStyle-Width="10%" DataField="Department" />--%>
                                                    <asp:BoundField HeaderText="Box Barcode" ItemStyle-Width="10%" DataField="BoxBarcode" />
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>

           
            </div>
            <div id="blocker" style="display: none">
                <div>
                    Loading...</div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnExportToExcel" />
            <%--            <asp:PostBackTrigger ControlID="btnDetailsExcelExport" />--%>
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
