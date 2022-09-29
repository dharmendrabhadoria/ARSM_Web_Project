<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true"
    CodeFile="UserMaster.aspx.cs" Inherits="Users_UserMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--  <link href="../style/datestyle.css" rel="stylesheet" type="text/css" />--%>
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../Scripts/UserMaster.js" type="text/javascript"></script>
    <link href="../Scripts/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/1.10.4-jquery-ui.js" type="text/javascript"></script>
    <link href="../Scripts/1.10.4-themes-smoothness-jquery-ui.css" rel="stylesheet" type="text/css" />
    <div class="clear">
    </div>
    <ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </ajax:ToolkitScriptManager>
   

    <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">User Master</li>
            </ol>
    <div class="row">
        <div class="col-md-12 col-lg-12">
             <div class="b-b b-grey m-b-20">
                  <h3 class="m-b-10">User Master</h3>
                </div>

            </div>
        </div>
     <div class="row">
              <div class="col-md-12">
                <div class="card card-default">
                  <div class="card-body">
                       <asp:Label ID="lblMessage" runat="server" Font-Bold="true" Font-Size="Medium" ForeColor="Brown"></asp:Label>
                       <div class="row">
					 <div class="col-md-4">
      <div class="form-group form-group-default">
                           <label class="">First Name</label>
          <asp:TextBox ID="txtFname" runat="server" size="27" MaxLength="20" CssClass="form-control"></asp:TextBox>
                      

          </div> <asp:RequiredFieldValidator ID="RegFieldFname" runat="server" ForeColor="Red" ControlToValidate="txtFname"
                            SetFocusOnError="true" ErrorMessage="First name should not be blank." ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ForeColor="Red"
                            ControlToValidate="txtFname" ErrorMessage="First name should be alphabetic only."
                            ValidationGroup="SaveGroup" Display="Dynamic" runat="server" ValidationExpression="^[a-zA-Z' ]+$" />
                         </div>
                              
                       <div class="col-md-4">
        <div class="form-group form-group-default">
                           <label class="">Middle Name</label>
            <asp:TextBox ID="txtMname" runat="server" size="27" MaxLength="20"  CssClass="form-control"></asp:TextBox>
                        
                      
                         </div>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator5" ForeColor="Red"
                            ControlToValidate="txtMname" ValidationExpression="^[a-zA-Z' ]+$" ErrorMessage="Middle Name should be alphabetic only."
                            runat="server" ValidationGroup="SaveGroup" />
                           </div>
                            <div class="col-md-4">
                               <div class="form-group form-group-default">
                           <label class="">Last Name</label>
                                   <asp:TextBox ID="txtLname" runat="server" size="27" MaxLength="20"  CssClass="form-control"></asp:TextBox>

                                   </div>
                             
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red"
                            ControlToValidate="txtLname" SetFocusOnError="true" ErrorMessage="Last name should not be blank."
                            ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" ForeColor="Red"
                            ControlToValidate="txtLname" ValidationExpression="^[a-zA-Z' ]+$" ErrorMessage="Alphabetic only."
                            runat="server" ValidationGroup="SaveGroup" />
                               </div>
                </div>

                    
                      <div class="row">
                           <div class="col-md-4">
                               <div class="form-group form-group-default">
                           <label class="">User Name</label>
                                    <asp:TextBox ID="txtUserName" runat="server" MaxLength="15"  CssClass="form-control"></asp:TextBox>
                                   </div>
                                <ajax:FilteredTextBoxExtender ID="FilexttxtUserName" runat="server" TargetControlID="txtUserName"
                            FilterType=" Numbers,UppercaseLetters,LowercaseLetters,Custom" ValidChars="&,', " />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtUserName"
                            ErrorMessage="User name should not be blank." ValidationGroup="SaveGroup" ForeColor="Red" Display="Dynamic"
                            SetFocusOnError="true"></asp:RequiredFieldValidator>
                               </div>
                          <div class="col-md-4">
                               <div class="form-group form-group-default">
                           <label class="">Date Of Birth</label>
                                    <asp:TextBox ID="txtdob" runat="server" size="27" MaxLength="60" Width="220" CssClass="datepicker form-control" 
                         onkeypress="return false;"></asp:TextBox>

                                   </div>
                              
                        <asp:Label runat="server" ID="lblDate" Style="display: none;" ForeColor="Red" ></asp:Label>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red"
                            ControlToValidate="txtdob" SetFocusOnError="true" ErrorMessage="Please enter  date of birth."
                            ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                              </div>
                           <div class="col-md-4">
                                <div class="form-group form-group-default">
                           <label class="">Email</label>
                                     <asp:TextBox ID="txtEmailId" runat="server" MaxLength="50"  CssClass="form-control"></asp:TextBox>
                                   </div>
                               <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" SetFocusOnError="true"
                            ForeColor="Red" ControlToValidate="txtEmailId" ErrorMessage="Email ID should not be blank."
                            Display="Dynamic" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" SetFocusOnError="true"
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="Invalid Email ID."
                            ValidationGroup="SaveGroup" ForeColor="Red" ControlToValidate="txtEmailId" Display="Dynamic"></asp:RegularExpressionValidator>
                               </div>


                          </div>


                      <div class="row" runat="server" id="TRpwdNew">
                          <div class="col-md-6">
                              <div class="form-group form-group-default">
                           <label class="">Password</label>
                                  <asp:TextBox ID="txtPwd" runat="server" MaxLength="15" TextMode="Password"   CssClass="form-control"></asp:TextBox>
                                   </div>
                               <asp:RequiredFieldValidator ID="RequiredFieldPwd" runat="server" ForeColor="Red"
                            ControlToValidate="txtPwd" SetFocusOnError="true" ErrorMessage="Password should not be blank."
                            ValidationGroup="SaveGroup" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="CustomValidatorPwd" ClientValidationFunction="ClientValidatePwd"
                            ForeColor="Red" ControlToValidate="txtPwd" runat="server" ErrorMessage="The password must be more than 6 characters."
                            Display="Dynamic" ValidationGroup="SaveGroup"></asp:CustomValidator>
                          </div>
                          <div class="col-md-6">
                               <div class="form-group form-group-default">
                           <label class="">Re-enter Password</label>
                            <asp:TextBox ID="txtRenPassword" runat="server" MaxLength="15" TextMode="Password"  CssClass="form-control"></asp:TextBox>
                      
                                   </div>
                               <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ForeColor="Red"
                            ControlToValidate="txtRenPassword" SetFocusOnError="true" ErrorMessage="Re-enter password should not be blank."
                            ValidationGroup="SaveGroup" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="cmPasswordRpt" runat="server" ValidationGroup="SaveGroup"
                            Display="Dynamic" SetFocusOnError="true" ControlToCompare="txtPwd" ForeColor="Red"
                            ControlToValidate="txtRenPassword" ValidateEmptyText="true" ErrorMessage="Your passwords do not match." />
                          </div>

                      </div>


                      <div class="row">
                          <div class="col-md-4">
                              <div class="form-group form-group-default form-group-default-select2">
                           <label class="">Department</label>
                                     <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2">    </asp:DropDownList>
                                  </div>
                              <asp:RequiredFieldValidator ID="reqddlvendorName" runat="server" SetFocusOnError="true"
                            ForeColor="Red" ControlToValidate="ddlDepartment" ErrorMessage="Please Select Department."
                            ValidationGroup="SaveGroup" Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>
                          </div>
                          <div class="col-md-4">
                               <div class="form-group form-group-default form-group-default-select2">
                           <label class="">Role</label>
                                    <asp:DropDownList ID="ddlRole" runat="server"  CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2">
                        </asp:DropDownList>
                       
                        
                                   </div>
                              <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" SetFocusOnError="true"
                            ForeColor="Red" ControlToValidate="ddlRole" ErrorMessage="Please Select Role."
                            ValidationGroup="SaveGroup" Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>
                          </div>
                          <div class="col-md-4">
                              <asp:CheckBox ID="chkisActive" runat="server" Text="Active" />
                          </div>
                      </div>

                      <div class="row">
                          <div class="col-md-12">
                               <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" ValidationGroup="SaveGroup" type="button" class="btn btn-primary"
                            OnClientClick="return  Validatefields();" />
                        <asp:Button ID="btnReset" runat="server" Text="Clear" OnClick="btnReset_Click" OnClientClick="clearfields();" type="button" class="btn btn-primary"/>

                          </div>

                      </div>



                      </div>

                      </div>
            </div>
        </div>
   

        <div class="frmbox">
      
                        <asp:GridView ID="gvUserMaster" runat="server" AutoGenerateColumns="False" AllowPaging="true"
                            PageSize="20" Width="100%" border="0" CssClass="table table-hover table-condense" GridLines="None" OnRowCommand="gvUserMaster_RowCommand"
                            OnPageIndexChanging="gvUserMaster_PageIndexChanging">
                            <Columns>
                                <asp:TemplateField HeaderText="Sr No." ItemStyle-Width="7%">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="User Name ">
                                    <ItemTemplate>
                                        <%# Eval("FirstName")%>
                                        &nbsp;
                                        <%# Eval("LastName")%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="EmailId">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="hdnUserId" runat="server" Value='<%# Eval("UserId") %>' />
                                        <asp:Label ID="lblemailId" runat="server" Text='<%# Eval("EmailId") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Role">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRoleName" runat="server" Text='<%# Eval("RoleName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Department">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDepartmentName" runat="server" Text='<%# Eval("DepartmentName") %>'></asp:Label>
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
                        <asp:HiddenField ID="hdndob" runat="server" />
                   
        </div>
   
</asp:Content>
