<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true"
    CodeFile="ViewLocation.aspx.cs" Inherits="Master_ViewLocation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <script src="../Scripts/BoxLocation.js" type="text/javascript"></script>
    <style type="text/css"  >
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
        
        .ui-autocomplete
        {
            background-color: white !important;
            width: 200px;
            max-height:150px !important;
            overflow:auto ;
        }
    </style>
    <script type="text/javascript">
        Sys.Application.add_load(BindBoxBarcodeEvents);
            </script>
    <div class="clear">
    </div>
    <div class="middle">
    <div class="frmbxhead" style="width: 150px; z-index:1 ">
     <asp:LinkButton ID="lnkbtnGenerateLocation" runat="server" Font-Underline="false" Style="color: #4f4f4f !important;"
                        CausesValidation="false" 
            onclick="lnkbtnGenerateLocation_Click" >  Generate Location</asp:LinkButton>
           
        </div>
        <div class="frmbxhead" style="margin-left:250px;width: 160px; z-index:1 ">
        <asp:LinkButton ID="lnkbtnMapLocation" runat="server" Font-Underline="false" Style="color: #4f4f4f !important;"
                        CausesValidation="false" onclick="lnkbtnMapLocation_Click" >  Map Location</asp:LinkButton>
            
        </div>
         <div class="frmbxhead" style=" margin-left:480px; width: 150px; z-index:1 ">
         <asp:LinkButton ID="lnkbtnSearchLocation" runat="server" Font-Underline="false" Style=" color: #4f4f4f !important;"
                        CausesValidation="false" onclick="lnkbtnSearchLocation_Click" >  Search Location</asp:LinkButton>
            
        </div>
        <div class="frmbox">
        <div id="divGenerateLocation" runat="server"  >
         <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                <table width="100%" >
                <tr>
                <td align="center" colspan="2" >
                                <asp:Label ID="lblMessage" runat="server" Font-Bold="true" Font-Size="Medium" ForeColor="Brown"></asp:Label>
                            </td>
                </tr>
                      <tr>
                            <td style="width: 14%">
                                WareHouse
                            </td>
                            <td >
                                <asp:DropDownList ID="ddlWareHouseGenrate" runat="server" Width="200" 
                                    AutoPostBack="True" 
                                    onselectedindexchanged="ddlWareHouseGenrate_SelectedIndexChanged"  >
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlWareHouseGenrate"
                                    ErrorMessage="Please Select WareHouse." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroupGenrate"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                              <tr>
                                <td>
                                    Row
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlRowGroupGenrate" runat="server" Width="200"   >
                                    </asp:DropDownList>

                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlRowGroupGenrate"
                                    ErrorMessage="Please Select Row." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroupGenrate"></asp:RequiredFieldValidator>
                                </td>
                                </tr>
                                <tr>
                                <td></td>
                                <td>
                                  <asp:Button ID="btnGenerate" runat="server" Text="Generate" ValidationGroup="SaveGroupGenrate"
                                    Style=" margin-top : 0px;" onclick="btnGenerate_Click"   />
                                    <asp:Button ID="btnCancel" runat="server" CausesValidation="false" 
                                        Text="Clear" OnClick="btnCancel_Click" />
                                </td>
                                </tr>
                </table>
                </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        <div id="divMapLocation" runat="server"  >
       <table width="100%" border ="0" >
       <tr>
       <td>Uplodad Excel File</td>
       <td>
           <asp:FileUpload ID="fiuploadExcel" runat="server"  onchange=" return validateFileUpload();"  />
            <asp:Button ID="btnUpload" runat="server"   Text="Upload" 
             OnClientClick=" return validateFileUpload();"    onclick="btnUpload_Click"  />
       </td>
       
       </tr>
       <tr>
       <td></td>
       <td>
        <div style="float:left; padding-left:150px;  "   >
       <asp:Label runat="server" ID="lblLocationValidationMessage" Font-Bold="true" Font-Size="Medium" ForeColor="Brown"    ></asp:Label>
       </div>
       <br />
       <div style="max-height:200px; overflow:auto; width:90% "  >
      
           <asp:GridView runat="server" ID="grdValidateLocation" AutoGenerateColumns="false" 
                                          Width="95%" CssClass="grid_data" 
                                        onpageindexchanging="grdLocationDetails_PageIndexChanging"      >
                                <Columns>
                                <asp:TemplateField HeaderText="Sr No.">
                                                                <ItemTemplate>
                                                                 <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'></asp:Label>
                                                                </ItemTemplate>
                                                                  <ItemStyle Width="10%" ></ItemStyle>
                                                            </asp:TemplateField>
                                <asp:TemplateField HeaderText="Location Code" >
                                 <ItemTemplate>
                                <asp:Label ID="lblLocationCode" runat="server" Text='<%# Eval("Location") %>' ></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="10%" ></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Box BarCode" >
                                 <ItemTemplate>
                                <asp:Label ID="lblBoxBarCodes" runat="server" Text='<%# Eval("BoxBarCode") %>' ></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="10%" ></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status" >
                                 <ItemTemplate>
                                 <asp:Image runat="server" ID="imgValid" ImageUrl= '<% #GetImageForValid(Eval("BoxOrLocStatus"))%> '  style="height:16px;width:14px;"   />
                                <asp:Label ID="lblBoxOrLocStatus" runat="server" Text='<%# Eval("BoxOrLocStatus") %>' ></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="10%" ></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Remraks" >
                                 <ItemTemplate>
                                <asp:Label ID="lblRemraks" runat="server" Text='<%# Eval("Remraks") %>' ></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="60%" ></ItemStyle>
                                </asp:TemplateField>
                         
                               
                                
                                </Columns>
                                </asp:GridView>
       </div>
       <div style="float:left;"   >
        <asp:Button ID="btnSaveLocation" runat="server"   Text="Save" 
               onclick="btnSaveLocation_Click"    />

       </div>
       </td>
       </tr>
       </table>
            </div>

             <div id="divSearchLocation" runat="server"  >
             <table width="100%" >
        <tr>
                            <td style="width: 7%">
                                WareHouse
                            </td>
                            <td style="width: 15%" >
                                <asp:DropDownList ID="ddlWareHouseSearch" runat="server" Width="200" 
                                    AutoPostBack="True" 
                                    onselectedindexchanged="ddlWareHouseSearch_SelectedIndexChanged"                 >
                                </asp:DropDownList>
                            </td>
                                <td style="width: 5%">
                                    Row
                                </td>
                                <td style="width: 15%" >
                                    <asp:DropDownList ID="ddlRowSearch" runat="server" Width="200" >
                                    </asp:DropDownList>
                                </td>
                                <td style="width: 5%" >Location </td>
                                <td>
                                <div class="ui-widget" style="width: 15%;">
                                        <asp:HiddenField ID="selectedValue" runat="server" />
                                        <asp:TextBox ID="txtSearchLocation" runat="server" Width="100"  onblur="autocompDropFile(this.id,'#ContentPlaceHolder1_selectedValue');" > </asp:TextBox>
                                        
                                        </div>
                                </td>
                                <td>
                                
                                </td>
                                </tr>
                                <tr>
                                <td colspan="5" >
                                <asp:Button ID="btnSearch" runat="server" CausesValidation="false"   Text="Search" 
                                        onclick="btnSearch_Click"  />
                                        <asp:Button ID="btnClear" runat="server" CausesValidation="false"   
                                        Text="Clear" onclick="btnClear_Click"  />
                                </td>
                                </tr>
                                <tr>
                                <td style="width:100%" colspan="7"  align="center"   >
                                <asp:GridView runat="server" ID="grdLocationDetails" AutoGenerateColumns="false" 
                                        AllowPaging="true"  Width="100%" CssClass="grid_data" 
                                        onpageindexchanging="grdLocationDetails_PageIndexChanging"      >
                                <Columns>
                                <asp:TemplateField HeaderText="Sr No.">
                                                                <ItemTemplate>
                                                                 <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'></asp:Label>
                                                                </ItemTemplate>
                                                                  <ItemStyle Width="10%" ></ItemStyle>
                                                            </asp:TemplateField>
                                <asp:TemplateField HeaderText="Location Code" >
                                 <ItemTemplate>
                                <asp:Label ID="lblLocationCode" runat="server" Text='<%# Eval("LocationCode") %>' ></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="10%" ></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Box Details" >
                                 <ItemTemplate>
                                <asp:Label ID="lblBoxBarCodes" runat="server" Text='<%# Eval("BoxBarCodes") %>' ></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="60%" ></ItemStyle>
                                
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Total" >
                                 <ItemTemplate>
                                <asp:Label ID="lblBoxCount" runat="server" Text='<%# Eval("BoxCount") %>' ></asp:Label>/
                                <asp:Label ID="lblMaxBoxCount" runat="server" Text='<%# Eval("MaxBoxCount") %>' ></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="10%" ></ItemStyle>
                                </asp:TemplateField>
                               
                                
                                </Columns>
                                </asp:GridView>
                                </td>
                                </tr>
                                </table>
            </div>
            
        </div>
    </div>
</asp:Content>

