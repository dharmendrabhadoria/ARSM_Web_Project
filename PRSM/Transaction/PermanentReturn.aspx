<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true"
    CodeFile="PermanentReturn.aspx.cs" Inherits="Transaction_PermanentReturn" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="../Styles/scrollableFixedHeaderTable.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../scripts/jquery.cookie.pack.js"></script>
    <script src="../Scripts/1.10.4-jquery-ui.js" type="text/javascript"></script>
    <script type="text/javascript" src="../scripts/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="../scripts/jquery.dimensions.min.js"></script>
    <script type="text/javascript" src="../scripts/jquery.scrollableFixedHeaderTable.js"></script>
    <script type="text/javascript" src="../scripts/jquery-list-attributes.js"></script>
  <script src="../Scripts/PermanentReturn.js" type="text/javascript"></script>
    <ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </ajax:ToolkitScriptManager>
    <script type="text/javascript">
        Sys.Application.add_load(BindGrdChkUchkEvents);
    </script>
 
    <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Permanent Return</li>
            </ol>
            <div class="row">
        <div class="col-md-12 col-lg-12">
             <div class="b-b b-grey m-b-20">
                  <h3 class="m-b-10"><asp:LinkButton ID="lnkbtnInward" runat="server" Font-Underline="false" Style="color: #4f4f4f !important;"
                CausesValidation="false"> Permanent Return</asp:LinkButton></h3>
                </div>
            </div>
                </div>
       <asp:UpdatePanel ID="updpnlInward" runat="server">
            <ContentTemplate>


 </ContentTemplate>
        </asp:UpdatePanel>
    <div class="row">
              <div class="col-md-12">
                <div class="card card-default">
                  <div class="card-body">
                      <div id="divInward" runat="server">
                      <div class="row">
                          <div class="col-md-4">
                              <div class="form-group form-group-default form-group-default-select2">
                           <label class="">WareHouse</label>
                                  <asp:DropDownList ID="ddlWareHouse" runat="server" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2">
                            </asp:DropDownList>
                           
                                  </div>
                               <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlWareHouse"
                                ErrorMessage="Please Select WareHose." InitialValue="0" ForeColor="Red" ValidationGroup="SaveInWarddGroup" Display="Dynamic" ></asp:RequiredFieldValidator>
                          </div>
                          <div class="col-md-4">
                              <div class="form-group form-group-default form-group-default-select2">
                           <label class="">Company Group</label>
                                  <asp:DropDownList ID="ddlCompanyGroup" runat="server" AutoPostBack="true" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2"
                                OnSelectedIndexChanged="ddlCompanyGroup_SelectedIndexChanged">
                            </asp:DropDownList>
                           
                                  </div>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlCompanyGroup" Display="Dynamic"  
                                ErrorMessage="Please Select Company Group ." InitialValue="0" ForeColor="Red"
                                ValidationGroup="SaveInWarddGroup"   ></asp:RequiredFieldValidator>
                            <span id="SpnddlCompanyGroup" style="color: Red;"></span>
                          </div>
                          <div class="col-md-4">
                              <div class="form-group form-group-default form-group-default-select2">
                           <label class="">Customer</label>
                                  <asp:DropDownList ID="ddlCustomer" runat="server" AutoPostBack="true" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2"
                                OnSelectedIndexChanged="ddlCustomer_SelectedIndexChanged">
                            </asp:DropDownList><br />
                           
                                  </div>
                               <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlCustomer"
                                ErrorMessage="Please Select Customer ." InitialValue="0" ForeColor="Red" ValidationGroup="SaveInWarddGroup" Display="Dynamic"  ></asp:RequiredFieldValidator>
                            <span id="SpnddlCustomer" style="color: Red;"></span>
                          </div>


                          </div>
                          </div>
                      <div class="row">
                          <div class="col-md-6">
                                 <div class="form-group form-group-default form-group-default-select2">
                           <label class="">Work Order</label>
                                      <asp:DropDownList ID="ddlWorkOrder" runat="server" AutoPostBack="true" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2"
                                OnSelectedIndexChanged="ddlWorkOrder_SelectedIndexChanged">
                            </asp:DropDownList>
                            
                                     </div>
                              <span id="Span1" style="color: Red;"></span>
                          </div>
                          <div class="col-md-6">
                                 <div class="form-group form-group-default form-group-default-select2">
                           <label class="">Work Order Activity</label>
                                     <asp:DropDownList ID="ddlWorkOrderActivity" runat="server" AutoPostBack="true" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2">
                            </asp:DropDownList>
                            
                                     </div>
                              <span id="Span2" style="color: Red;"></span>
                          </div>
                      </div>
                      <div class="row">
                          <div class="col-md-12">
                              <asp:Button ID="btnSearch" runat="server" Text="Search" ValidationGroup="SaveInWarddGroup" type="button" CssClass="btn btn-primary"
                                OnClick="btnSearch_Click" OnClientClick="return ReqInwardFieldsAll();" />

                          </div>
                      </div>




                      </div>
                    </div>
                  </div>
        </div>




    <div class="middle">
        
            
        
     
                <div class="frmbox">
                    
                        
                                    <div runat="server" id="divInwardBoxes" style="display: none;">
                                        <fieldset class="fieldSetBorder">
                                            <legend>Box Details</legend>
                                            
                                                 <asp:Panel ID="pnlgvBx" runat="server" ScrollBars="Both" BorderStyle="Solid" BorderWidth="1px"
                                                            Height="300px">
                                                         <asp:GridView runat="server"  ID="grdBoxDetails" CellSpacing="1" CellPadding="1" AutoGenerateColumns="false"
                                                               CssClass="table table-hover table-condense" Width="100%" HeaderStyle-CssClass="header">
                                                                <Columns>
                                                                    <asp:TemplateField ItemStyle-Width="2%" ItemStyle-Height="7px" HeaderStyle-Width="13%"
                                                                        HeaderText="Sr No.">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'
                                                                                Width="10px"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="13%"></ItemStyle>
                                                                        <HeaderStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Box BarCode" ItemStyle-Height="7px" ItemStyle-Width="27%">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblBoxCode" runat="server" Text='<%# Eval("BoxCode") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="27%"></ItemStyle>
                                                                        <HeaderStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Box Location Code" ItemStyle-Width="30%">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblBx2" runat="server" Text='<%# Eval("LocationCode") %>'></asp:Label>
                                                                            <asp:HiddenField ID="hdnBoxId" runat="server" Value='<%# Eval("BoxId") %>' />
                                                                            <asp:HiddenField ID="hdnBxStatus" runat="server" Value='<%# Eval("BoxStatus") %>' />
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="30%"></ItemStyle>
                                                                        <HeaderStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="" ItemStyle-Width="30%">
                                                                        <ItemTemplate>
                                                                            <asp:CheckBox runat="server" ID="chkstatus" Checked="true" Enabled="false" />
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="30%"></ItemStyle>
                                                                        <HeaderTemplate>
                                                                            <asp:CheckBox runat="server" ID="chkBoxstatusAll" Text="  All" Checked="true" Enabled="false" />
                                                                        </HeaderTemplate>
                                                                        <HeaderStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <AlternatingRowStyle CssClass="AlternativeRowStyle" />
                                                            </asp:GridView>
                
                                                        </asp:Panel>
                                                   
                                        </fieldset>
                                    </div>
                                    <div runat="server" id="divInwardFiles" style="display: none;">
                                        <fieldset class="fieldSetBorder">
                                            <legend>File Details </legend>
                                           
                                                        <asp:Panel ID="PanelgvFile" runat="server" ScrollBars="Both" BorderStyle="Solid"
                                                            Height="300px">
                                            <asp:GridView runat="server" ID="grdFilesDetails" CellSpacing="1" CellPadding="1"
                                                                AutoGenerateColumns="false" CssClass="table table-hover table-condense"
                                                                Width="100%" HeaderStyle-CssClass="header">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Sr No." ItemStyle-Width="6%">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="6%"></ItemStyle>
                                                                        <HeaderStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Box BarCode" ItemStyle-Width="12%">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblBxBarCode" runat="server" Text='<%# Eval("BoxBarCode") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="12%"></ItemStyle>
                                                                        <HeaderStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="File BarCode" ItemStyle-Width="12%">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblFileBarCode" runat="server" Text='<%# Eval("FileBarCode") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="12%"></ItemStyle>
                                                                        <HeaderStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText=" Location Code" ItemStyle-Width="10%">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblLocationCode" runat="server" Text='<%# Eval("LocationCode") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="10%"></ItemStyle>
                                                                        <HeaderStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="File Name" ItemStyle-Width="10%">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblFileName" runat="server" Text='<%# Eval("FileName") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="10%"></ItemStyle>
                                                                        <HeaderStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Department" ItemStyle-Width="10%">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblDepartment" runat="server" Text='<%# Eval("Department") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="10%"></ItemStyle>
                                                                        <HeaderStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Year" ItemStyle-Width="10%">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblyear" runat="server" Text='<%# Eval("Year") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="10%"></ItemStyle>
                                                                        <HeaderStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="From Date" ItemStyle-Width="10%">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblFromDate" runat="server" Text='<%# Eval("FromDate", "{0:dd-MM-yyyy}")%>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="10%"></ItemStyle>
                                                                        <HeaderStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="To Date" ItemStyle-Width="10%">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblToDate" runat="server" Text='<%# Eval("Todate", "{0:dd-MM-yyyy}")%>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="10%"></ItemStyle>
                                                                        <HeaderStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField ItemStyle-Width="10%">
                                                                        <ItemTemplate>
                                                                            <asp:CheckBox runat="server" ID="chkstatus" Checked="true" Enabled="false" CssClass="css-checkbox" name="chkstatus" />
                                                                            <asp:HiddenField ID="hdnFileId" runat="server" Value='<%# Eval("FileId") %>' />
                                                                            <asp:HiddenField ID="hdnFlStatus" runat="server" Value='<%# Eval("FileStatus") %>' />
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="10%"></ItemStyle>
                                                                        <HeaderTemplate>
                                                                            <asp:CheckBox runat="server" ID="chkstatusAll" Text="  All" Checked="true" Enabled="false" />
                                                                        </HeaderTemplate>
                                                                        <HeaderStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <AlternatingRowStyle CssClass="AlternativeRowStyle" />
                                                            </asp:GridView>
                                                        </asp:Panel>
                                                    
                                        </fieldset>
                                    </div>
                                
                                   
                                    <%--<asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" OnClientClick="return ValidateInwardfields();"   />
                                  --%>
                                    <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" OnClientClick="return ValidateInwardfields();" type="button" CssClass="btn btn-primary"  />
                                  
                                    <asp:Button ID="btnCancel" runat="server" Text="Clear" OnClientClick="return clearInwardfields();" type="button" CssClass="btn btn-primary"
                                        OnClick="btnCancel_Click" />
                               
                   
                </div>
           
        <script type="text/javascript">
            Sys.Application.add_load(function () { $('#ContentPlaceHolder1_grdBoxDetails').scrollableFixedHeaderTable(1000, 200); });
        </script>
     <script type="text/javascript">
                    Sys.Application.add_load(function () { $('#ContentPlaceHolder1_grdFilesDetails').scrollableFixedHeaderTable(1000, 200); });
          </script>
        <script type="text/javascript">
            Sys.Application.add_load(BindGrdChkUchkEvents);
        </script>
    </div>
</asp:Content>
