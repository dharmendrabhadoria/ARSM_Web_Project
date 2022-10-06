<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPages/PRSM.master"
    CodeFile="CustomerCreation.aspx.cs" Inherits="User_CustomerCreation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../Scripts/CustomerCreationMaster.js" type="text/javascript"></script>
    <link href="../Scripts/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/1.10.4-jquery-ui.js" type="text/javascript"></script>
    <link href="../Scripts/1.10.4-themes-smoothness-jquery-ui.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .RubberBandBox
        {
            overflow: hidden;
            padding: 0;
            opacity: .5;
            filter: alpha(opacity=50);
            background-color: #666666;
            border: 0px solid #596380;
            z-index: 1000;
            left: 0px;
            top: 0px;
            height: 100%;
            width: 100%;
            position: fixed;
            display: block;
        }
        
        .RubberBandBox img
        {
            left: 50%;
            top: 50%;
            position: absolute;
            height: 30px;
            width: 114px; /*z-index:5   */
        }
    </style>
    <script type="text/javascript">
        function BindDates() {
            $(function () {
                $('#ContentPlaceHolder1_txtAciveDate').attr('readonly', 'readonly');
                $(".datepicker1").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    dateFormat: 'dd-mm-yy',
                    yearRange: "-110:+15",
                    beforeShow: function () {
                        setTimeout(function () {
                            $('.ui-datepicker1').css('z-index', 100);
                        }, 0);
                    }
                });
            })
        }
        Sys.Application.add_load(BindDates);
    </script>
    <ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </ajax:ToolkitScriptManager>
    <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="0" AssociatedUpdatePanelID="updActivity">
        <ProgressTemplate>
            <div id="divUpdateProgress" class="RubberBandBox">
                <img id="imgLoadingImage" src="../images/loading-animation.gif" alt="Loading....." />
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Customer User Creation</li>
            </ol>
            <div class="row">
        <div class="col-md-12 col-lg-12">
             <div class="b-b b-grey m-b-20">
                  <h3 class="m-b-10">Customer User Creation</h3>
                </div>
            </div>
                </div>
    <asp:UpdatePanel ID="updActivity" runat="server">
        <ContentTemplate>
            <asp:Label ID="lblMessage" runat="server" Font-Bold="true" Font-Size="Medium" ForeColor="Brown"></asp:Label>
            <div class="row">
              <div class="col-md-12">
                <div class="card card-default">
                  <div class="card-body">

                      <div class="row">
                           
                          <div class="col-md-6">
                              <div class="form-group form-group-default">
                           <label class="">Full Name</label>
                                  <asp:TextBox ID="txtCustFullName" runat="server" CssClass="form-control"></asp:TextBox>
                            
                                  </div>
                              <asp:RequiredFieldValidator ID="RegFieldFname" runat="server" ForeColor="Red" ControlToValidate="txtCustFullName"
                                SetFocusOnError="true" ErrorMessage="Customer name should not be blank." ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ForeColor="Red"
                                ControlToValidate="txtCustFullName" ErrorMessage="Customer name should be alphabetic only."
                                ValidationGroup="SaveGroup" Display="Dynamic" runat="server" ValidationExpression="^[a-zA-Z' ]+$" />
                          </div>
                          <div class="col-md-6">
                              <div class="form-group form-group-default">
                           <label class="">WareHouse</label>
                                  <asp:TextBox ID="txtCustEmail" runat="server" CssClass="form-control"></asp:TextBox>
                            
                                  </div>
                              <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" SetFocusOnError="true"
                                ForeColor="Red" ControlToValidate="txtCustEmail" ErrorMessage="Email ID should not be blank."
                                Display="Dynamic" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" SetFocusOnError="true"
                                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="Invalid Email ID."
                                ValidationGroup="SaveGroup" ForeColor="Red" ControlToValidate="txtCustEmail"
                                Display="Dynamic"></asp:RegularExpressionValidator>
                            <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" TargetControlID="txtCustEmail"
                                FilterType=" Numbers,UppercaseLetters,LowercaseLetters,Custom" ValidChars=".,@,_" />
                          </div>
                      </div>

                      <div class="row">
                          <div class="col-md-6">
                              <div class="form-group form-group-default form-group-default-select2">
                           <label class="">Company Group</label>
                                   <asp:DropDownList ID="ddlCompanyGroup" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlCompanyGroup_SelectedIndexChanged" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2">
                            </asp:DropDownList>
                           
                                  </div>
                               <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" SetFocusOnError="true"
                                ForeColor="Red" ControlToValidate="ddlCompanyGroup" ErrorMessage="Please Select Company Group."
                                ValidationGroup="SaveGroup" Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>
                          </div>
                          <div class="col-md-6">
                              <div class="form-group form-group-default form-group-default-select2">
                           <label class="">Select Customer</label>
                                   <asp:DropDownList ID="lstCustomer" runat="server" AutoPostBack="true" OnSelectedIndexChanged="lstCustomer_SelectedIndexChanged" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" SetFocusOnError="true"
                                ForeColor="Red" ControlToValidate="lstCustomer" ErrorMessage="Please Select Customer."
                                ValidationGroup="SaveGroup" Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>
                                  </div>
                          </div>
                      </div>

                      <div class="row">
                          <div class="col-md-4">
                                <div class="form-group form-group-default">
                           <label class="">User Id</label>
                                    <asp:TextBox ID="txtCustUserName" runat="server" CssClass="form-control"></asp:TextBox>
                            
                                    </div>
                              <ajax:FilteredTextBoxExtender ID="FilexttxtUserName" runat="server" TargetControlID="txtCustUserName"
                                FilterType=" Numbers,UppercaseLetters,LowercaseLetters,Custom" ValidChars="&,'," />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtCustUserName"
                                ErrorMessage="User Id should not be blank." ValidationGroup="SaveGroup" ForeColor="Red"
                                Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                          </div>
                          <div class="col-md-4">
                                <div class="form-group form-group-default" id="trPwd" runat="server">
                           <label class="">Full Name</label>
                                    <asp:TextBox ID="txtPwd" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                           
                                    </div>
                               <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ForeColor="Red"
                                ControlToValidate="txtPwd" SetFocusOnError="true" ErrorMessage="Password should not be blank."
                                ValidationGroup="SaveGroup" Display="Dynamic"></asp:RequiredFieldValidator>
                            <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" TargetControlID="txtPwd"
                                FilterType=" Numbers,UppercaseLetters,LowercaseLetters,Custom" ValidChars="" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" 
                                ControlToValidate="txtPwd" Display="Dynamic" 
                                ErrorMessage="Password length must be minimum 4 to maximum 12 characters" 
                                ForeColor="Red" SetFocusOnError="True" 
                                ValidationExpression="^[a-zA-Z0-9'@&#.\s]{4,12}$" 
                                ValidationGroup="SaveGroup"></asp:RegularExpressionValidator>
                          </div>
                          <div class="col-md-4">
                                <div class="form-group form-group-default">
                           <label class="">Full Name</label>
                                     <asp:TextBox ID="txtConfirmPwd" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                    </div>
                             
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red"
                                ControlToValidate="txtConfirmPwd" SetFocusOnError="true" ErrorMessage="Confirm Password should not be blank."
                                ValidationGroup="SaveGroup" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="CompareValidator1" runat="server" 
                                ErrorMessage="Password Do Not Match." ControlToCompare="txtPwd" 
                                ControlToValidate="txtConfirmPwd" Display="Dynamic" ForeColor="Red" 
                                SetFocusOnError="True" ValidationGroup="SaveGroup"></asp:CompareValidator>
                          </div>
                      </div>

                      <div class="row">
                          <div class="col-md-3">
                              IsActive:
                              <asp:CheckBox ID="chkActive" runat="server" />
                          </div>
                          <div class="col-md-3">
                              Is User Locked: <asp:CheckBox ID="chkLocked" runat="server" />
                          </div>
                          <div class="col-md-3">
                               <div class="form-group form-group-default">
                           <label class="">Account Active Date (180Days):</label>
                              
                              <asp:TextBox ID="txtAciveDate" runat="server" CssClass="datepicker1 form-control" onkeypress="return false;" ></asp:TextBox>
                         
                          </div>
                              </div>
                          <div class="col-md-3">
                              Contract Date:                            <asp:Label ID="lblcontractDate" runat="server"></asp:Label>
                          </div>
                      </div>

                    

                      
                        <div class="row">
                          <div class="col-md-12">
                              <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" ValidationGroup="SaveGroup"  type="button" class="btn btn-primary"
                                OnClientClick="return  Validatefields();" />
                            <asp:Button ID="btnReset" runat="server" Text="Clear" OnClick="btnReset_Click" OnClientClick="clearfields();"  type="button" class="btn btn-primary"/>
                          </div>

                      </div>
                    </div>
                  </div>
                </div>

              


        
                    
                  
                            <%-- <asp:ListBox ID="lstCustomer" runat="server" SelectionMode="Single" Width="400px" 
                        onselectedindexchanged="lstCustomer_SelectedIndexChanged">
                    </asp:ListBox>--%>
                    
                    
                   
                  
                            <asp:GridView ID="gvUserMaster" runat="server" AutoGenerateColumns="False" AllowPaging="true" 
                                PageSize="20" Width="100%" border="0" CssClass="table table-hover table-condense" GridLines="None" OnRowCommand="gvUserMaster_RowCommand"
                                OnPageIndexChanging="gvUserMaster_PageIndexChanging">
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr No." ItemStyle-Width="7%">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="User ID">
                                        <ItemTemplate>
                                            <%# Eval("CustomerUserName")%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="EmailId">
                                        <ItemTemplate>
                                            <asp:HiddenField ID="hdnUserId" runat="server" Value='<%# Eval("UserId") %>' />
                                            <asp:Label ID="lblemailId" runat="server" Text='<%# Eval("EmailId") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Active">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkIsActive" runat="server" Checked='<%#IsChecked(Eval("IsActive"))%> '
                                                Enabled="false"></asp:CheckBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkbtnEdit" runat="server" Text="Edit" CommandArgument='<%# Eval("UserId") %>'
                                                CommandName="EdtUser"></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle HorizontalAlign="Left" BorderWidth="0" />
                                <AlternatingRowStyle CssClass="AlternativeRowStyle" />
                            </asp:GridView>
                            <%-- <asp:HiddenField ID="hdnFN" runat="server" />
                          <asp:HiddenField ID="hdnCompanygrp" runat="server" />
                          <asp:HiddenField ID="hdnCustomerID" runat="server" />--%>
                       
           
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
