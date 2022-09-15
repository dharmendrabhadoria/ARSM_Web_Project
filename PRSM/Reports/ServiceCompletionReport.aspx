<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPages/PRSM.master" CodeFile="ServiceCompletionReport.aspx.cs" Inherits="Reports_ServiceCompletionReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
        .nopadding {padding:0px !important;}
    </style>

    <script src="../Scripts/FilePickupReport.js" type="text/javascript"></script>
    <script src="../Scripts/WorkOrder.js" type="text/javascript"></script>
    <ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </ajax:ToolkitScriptManager>
    <asp:UpdatePanel runat="server" ID="UpdpananelSerachOrder">
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
          <script src="../Scripts/FilePickupReport.js" type="text/javascript"></script>
          <script type="text/javascript">
              Sys.Application.add_load(BindDates);
            </script>
            <div class="clear">
            </div>
            <div class="middle">

                <div class="frmbxhead" style="margin-left:10px!important;margin-bottom: -1px !important;
                    z-index: 0 !important;">
                    <asp:LinkButton ID="lnkbtnsummary" runat="server" Font-Underline="false"
                        Style="color: #4f4f4f !important;" CausesValidation="false" OnClick="lnkbtnsummary_Click">Service Completion Summary </asp:LinkButton>
                </div>
                <div class="frmbxhead" style="margin-left:250px !important; margin-bottom: -1px !important;
                    z-index: 0 !important;">
                    <asp:LinkButton ID="lnkbtnservicedetails" runat="server" Font-Underline="false" Style="color: #4f4f4f !important;"
                        CausesValidation="false" OnClick="lnkbtnservicedetails_Click" OnClientClick="changesearch('ContentPlaceHolder1_ddlSearchRequestby')">Service Completion Details</asp:LinkButton>
                </div>
                <div class="frmbox">
                <center>
                   <table width="100%" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td align="center">
                                <asp:Label ID="lblMessage" runat="server" Font-Bold="true" Font-Size="Medium" ForeColor="Brown"></asp:Label>
                            </td>
                        </tr>
                    </table>

  
                    <div id="divServiceCompletion" runat="server" style="width:90%;">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                             <tr>
                                  
                                    <td colspan="5" align="left">
                                        <asp:RadioButtonList ID="rdbtnFilePickDetails" runat="server" 
                                            AutoPostBack="True" Visible="false"
                                            RepeatColumns="2" RepeatDirection="Horizontal" Width="400px" 
                                            onselectedindexchanged="rdbtnFilePickDetails_SelectedIndexChanged" >
                                            <asp:ListItem Selected="True" Text="Work Order Number Wise" Value="1"> </asp:ListItem>
                                            <asp:ListItem Text="Work Order Date Wise" Value="2"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                    
                                </tr>
                            <tr>
                             <td width="5%">
                                  WareHouse
                                </td>
                                <td width="10%">
                                    <asp:DropDownList ID="ddlWareHouse" runat="server" Width="150">
                                    </asp:DropDownList>
                             </td>
                                <td width="15%">
                               Company Group
                                </td>
                                <td colspan="2">
                                     <asp:DropDownList ID="ddlCompanyGroup" runat="server" AutoPostBack="true" Width="210"
                                        OnSelectedIndexChanged="ddlCompanyGroup_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>

                                <td width="5%" align="left">
                                   Customer   
                                </td>
                                <td>
                                   <asp:DropDownList ID="ddlCustomer" runat="server" AutoPostBack="true" Width="210"   
                                   OnSelectedIndexChanged="ddlCustomer_SelectedIndexChanged">
                                    <asp:ListItem Value="0" Text="--Select--"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td width="10%">
                                 Work Order number
                                </td>
                                <td colspan="2">
                               <asp:DropDownList ID="ddlWorkOrder" runat="server" Width="210">
                                </asp:DropDownList> 
                                </td>
                            </tr>
                            <tr>
                                    <td style="width: 5%" >
                                        From Date
                                    </td>
                                    <td >
                                        <asp:TextBox ID="txtfromDate" runat="server" Width="150" CssClass="datepicker1" onkeypress="return false;">
                                        </asp:TextBox>
                                    </td>
                                    <td width="10%">
                                        To Date
                                    </td>
                                    <td  colspan="2" >
                                        <asp:TextBox ID="txttodate" runat="server" Width="150" CssClass="datepicker1" onkeypress="return false;">
                                        </asp:TextBox>
                                    </td>
                                </tr>
                            <tr>
                            <td></td>
                                <td align="left"> 
                                    <asp:Button ID="btnview" runat="server" Text="View" Style="margin-top: 0px;" OnClientClick="javascript:return validateDate();" 
                                        OnClick="btnview_Click"  />
                                    &nbsp;&nbsp; &nbsp;
                                    <asp:Button ID="btnViewClear" runat="server" Text="Clear" 
                                        OnClick="btnViewClear_Click" />
                                </td>
                                <asp:Panel ID="pnlExportype" runat="server" Visible="false">
                             <td style="width: 10%">Type : </td>
                                           <td>
                                           <table border="0">
                                           <tr>
                                           <td>  <asp:RadioButtonList ID="rdbtnlstReportType" runat="server" AutoPostBack="true" RepeatDirection="Horizontal">
                                        <asp:ListItem Text="PDF" Value="0" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="Excel" Value="1"></asp:ListItem>
                                        </asp:RadioButtonList></td>
                                        <td>
                                        <asp:Button ID="btnExportToExcel" runat="server"  OnClick="btnExportToExcel_Click"
                                                        Text="Export & Print" Visible="false" />   
                                        </td>
                                           </tr>
                                           </table>
                                           
                                    </td>
                                    </asp:Panel>
                            </tr>
                            <tr>
             <td colspan="5" width="100%">
                                <div id="divServiceComplSummary" runat="server" style="overflow: auto; padding-left: 0px;
                                                color: #4f4f4f; font-size: 12px; width:100%; height:200px;   line-height: 20px;
                                                display:block; " >
                                   <asp:GridView ID="GridServiceSummarry" runat="server" 
                                        AutoGenerateColumns="False" ShowHeader="true"
                                        Width="100%" CssClass="grid_data" ShowFooter="true" 
                                        onrowdatabound="GridServiceSummarry_RowDataBound" >
              
                                        <EmptyDataRowStyle HorizontalAlign="Center" />
                                        <Columns>
                                       <asp:TemplateField HeaderText="Sr No." ItemStyle-Width="5%">
                                         <ItemTemplate>
                                            <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'></asp:Label>
                                             </ItemTemplate>
                                          <ItemStyle Width="7%"></ItemStyle>
                                         </asp:TemplateField>
                                          <asp:TemplateField HeaderText="Customer">
                                            <ItemTemplate>
                                             <asp:Label ID="lblCustomer" runat="server" Text='<%#Eval("CustomerName") %>'></asp:Label>
                                            </ItemTemplate>
                                              <FooterTemplate>
                                                <asp:Label ID="lblTotal" runat="server" Font-Bold="true" Font-Size="14px" Text="Total"></asp:Label>
                                              </FooterTemplate>
                                            </asp:TemplateField>
                                           <asp:TemplateField HeaderText="Total Work Order No.">
                                            <ItemTemplate>
                                             <asp:Label ID="lblWorkOrderNo" runat="server" Text='<%#Eval("TotalWoNo") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>   
                                                <asp:Label ID="lblTotalWoNo" runat="server" Font-Bold="true"></asp:Label>
                                            </FooterTemplate>
                                            </asp:TemplateField>
                                          <asp:TemplateField HeaderText="Total Service">
                                            <ItemTemplate>
                                             <asp:Label ID="lblRequestedService" runat="server" Text='<%#Eval("TotalService") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>   
                                                <asp:Label ID="lblTotalRequestedService" runat="server" Font-Bold="true"></asp:Label>
                                            </FooterTemplate>
                                            </asp:TemplateField>
                                           <asp:TemplateField HeaderText="Completed Service">
                                            <ItemTemplate>
                                             <asp:Label ID="lblComletedService" runat="server" Text='<%#Eval("ComletedService") %>'></asp:Label>
                                            </ItemTemplate>
                                             <FooterTemplate>   
                                                <asp:Label ID="lblTotalCompletedService" runat="server" Font-Bold="true"></asp:Label>
                                            </FooterTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <AlternatingRowStyle CssClass="AlternativeRowStyle" />
                                    </asp:GridView>
                                    </div>
                                <div id="divServiceComplDetails" runat="server" style="overflow: auto; padding-left: 0px;
                                                color: #4f4f4f; font-size: 12px; width: 90%; height:200px;   line-height: 20px;
                                                display:none;" >
                                   <asp:GridView ID="gdvSearchWorkOrder" runat="server" 
                                        AutoGenerateColumns ="true"  HeaderStyle-HorizontalAlign="Center"  ShowFooter="false"
                                        Width="100%" CssClass="grid_data" 
                                         >
                        <%--                <EmptyDataTemplate>
                                            <span style="text-align: center;">
                                                <asp:Label ID="lblmsg" Text="No Record Found" Font-Size="14px" Font-Bold="true" Style="text-align: center"
                                                    ForeColor="Red" runat="server"></asp:Label>
                                            </span>
                                        </EmptyDataTemplate>--%>
                                    </asp:GridView>
                                    </div>


                                    </div>
                                </center>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>

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
            <asp:PostBackTrigger ControlID="btnExportToExcel" />
            
            </Triggers>
    </asp:UpdatePanel>
    </asp:Content>

