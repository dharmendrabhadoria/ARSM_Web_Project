<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true"
    CodeFile="CompanyGroup.aspx.cs" Inherits="Master_CompanyGroup" EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../Scripts/CompanyGroup.js" type="text/javascript"></script>
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <asp:UpdatePanel ID="updCustomer" runat="server">
        <ContentTemplate>
      

             <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Company Group</li>
            </ol>
            <div class="row">
        <div class="col-md-12 col-lg-12">
             <div class="b-b b-grey m-b-20">
                  <h3 class="m-b-10">Company Group</h3>
                </div>
            </div>
                </div>
                <div class="row">
              <div class="col-md-12">
                <div class="card card-default">
                  <div class="card-body">

                      <div class="row">

                           <asp:Label ID="lblMessage" runat="server" Font-Bold="true" Font-Size="Medium" ForeColor="Brown"></asp:Label>
                          <div class="col-md-3">
                               <div class="form-group form-group-default">
                           <label class="">Name</label>
                              <asp:TextBox ID="txtGroupName" runat="server" MaxLength="100" CssClass="form-control"></asp:TextBox>
                                   </div>
                                <asp:RequiredFieldValidator ID="ReqfGroupName" runat="server" ControlToValidate="txtGroupName"
                                    ErrorMessage="Please Enter Name." ForeColor="Red" ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator> 
                                      <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                    ValidChars="-'_& /\. @" TargetControlID="txtGroupName">
                                </ajax:FilteredTextBoxExtender>                  
                          </div>
                          <div class="col-md-3">
                              <div class="form-group form-group-default form-group-default-select2">
                           <label class="">Industry</label>

                      <asp:DropDownList ID="ddlindustry" runat="server"  CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2">
                                </asp:DropDownList>
                                </div>
                                <asp:RequiredFieldValidator ID="reqserviceCategory" runat="server" ErrorMessage="Please Select Industry."
                                    InitialValue="0" ControlToValidate="ddlindustry" ForeColor="Red" ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                          </div>
                          <div class="col-md-3">
                              <div class="form-group form-group-default">
                           <label class="">PAN</label>
                                  <asp:TextBox ID="txtPANNo" runat="server" onchange="javascript:upperletter(this.value);" CssClass="form-control"
                                    MaxLength="10"></asp:TextBox>
                                  </div>
                              
                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                    TargetControlID="txtPANNo">
                                </ajax:FilteredTextBoxExtender>
                          </div>
                          <div class="col-md-3">
                              <div class="form-group form-group-default">
                           <label class="">TAN</label>
                                  <asp:TextBox ID="txtTAN" runat="server"  MaxLength="25" onchange="javascript:upperletterTan(this.value);" CssClass="form-control"></asp:TextBox>
                                  </div>
                        
                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                    TargetControlID="txtTAN">
                                </ajax:FilteredTextBoxExtender>
                          </div>
                      </div>

                      <div class="row">
                          <div class="col-md-6">
                               <div class="form-group form-group-default">
                           <label class="">Register Address Line 1</label>
                                    <asp:TextBox ID="txtRegAddress1" runat="server" TextMode="MultiLine" CssClass="form-control" MaxLength="50" onkeypress="return textboxMultilineMaxNumber(this.id,50)"
                                    onkeyup="return textboxMultilineMaxNumber(this.id,50)"></asp:TextBox>
                                      
                                   </div>
                              <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="txtRegAddress1"
                                    ErrorMessage="Please Enter Register Address Line 1." EnableClientScript="true" ForeColor="Red"
                                    ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                          </div>
                          <div class="col-md-6">
                               <div class="form-group form-group-default">
                           <label class="">Register Address Line 2</label>
                                     <asp:TextBox ID="txtRegAddress2" runat="server" TextMode="MultiLine" CssClass="form-control" MaxLength="50" onkeypress="return textboxMultilineMaxNumber(this.id,50)"
                                    onkeyup="return textboxMultilineMaxNumber(this.id,50)"></asp:TextBox>
                                    
                                   </div>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ControlToValidate="txtRegAddress2"
                                    ErrorMessage="Please Enter Register Address Line 2." EnableClientScript="true" ForeColor="Red"
                                    ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                          </div>
                      </div>

                      <div class="row">
                          <div class="col-md-4">
                                 <div class="form-group form-group-default form-group-default-select2">
                           <label class="">State</label>
                                      <asp:DropDownList ID="ddlState" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlState_SelectedIndexChanged" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2">
                                </asp:DropDownList>
                                
                                     </div>
                              <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Please Select State."
                                    InitialValue="0" ControlToValidate="ddlState" ForeColor="Red" ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                          </div>
                          <div class="col-md-4">
                                 <div class="form-group form-group-default form-group-default-select2">
                           <label class="">Industry</label>
                                       <asp:DropDownList ID="ddlCity" runat="server" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2">
                                </asp:DropDownList>
                                     </div>
                               <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Select City."
                                    InitialValue="0" ControlToValidate="ddlCity" ForeColor="Red" ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                          </div>
                          <div class="col-md-4">
                                 <div class="form-group form-group-default">
                           <label class="">Pin Code</label>
                                     <asp:TextBox ID="txtpincode" runat="server" MaxLength="6" CssClass="form-control"></asp:TextBox>
                               
                                     </div>
                               <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtpincode"
                                    ErrorMessage="Please Enter Pin Code." EnableClientScript="true" ForeColor="Red"
                                    ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                                     
                                                <asp:CustomValidator runat="server" ID="Customvalidator142" ForeColor="Red" ControlToValidate="txtpincode"
                                                    Display="Static" EnableClientScript="true" ClientValidationFunction="ValidateRegPinCode"
                                                    ErrorMessage="Please enter valid pin code" OnServerValidate="cusCG_ServerValidate"
                                                    ValidationGroup="SaveGroup1"></asp:CustomValidator>
                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender11" runat="server" TargetControlID="txtpincode"
                                    FilterType="Numbers" />
                                    
                                      <asp:RegularExpressionValidator ID="RegularExpressionValidator7" ForeColor="Red" SetFocusOnError="true" runat="server" 
                                                    ErrorMessage="Pin code should be of 6 digits." ValidationExpression="^((\\+91-?)|0)?[0-9]{6}$" 
                                                     ValidationGroup="SaveGroup1" ControlToValidate="txtpincode" Display="Dynamic"></asp:RegularExpressionValidator>
                          </div>
                      </div>


                      <div class="row">
                          <div class="col-md-6">
                               <div class="form-group form-group-default">
                           <label class="">Corporate Address Line 1</label>
                                   <asp:TextBox ID="txtCorpAddress1" runat="server" CssClass="form-control"  MaxLength="50" onkeypress="return textboxMultilineMaxNumber(this.id,50)"
                                    onkeyup="return textboxMultilineMaxNumber(this.id,50)"></asp:TextBox>
                                    

                                   </div>
                               <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="txtCorpAddress1"
                                    ErrorMessage="Please Enter Corporate Address Line 1." EnableClientScript="true" ForeColor="Red"
                                    ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                              </div>
                          <div class="col-md-6">
                               <div class="form-group form-group-default">
                           <label class="">Corporate Address Line 2</label>
                                    <asp:TextBox ID="txtCorpAddress2" runat="server" CssClass="form-control" MaxLength="50" onkeypress="return textboxMultilineMaxNumber(this.id,50)"
                                    onkeyup="return textboxMultilineMaxNumber(this.id,50)"></asp:TextBox>
                                    

                                   </div>
                               <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ControlToValidate="txtCorpAddress2"
                                    ErrorMessage="Please Enter Corporate Address Line 2." EnableClientScript="true" ForeColor="Red"
                                    ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                              </div>

                      </div>

                      <div class="row">
                            <div class="col-md-4">
                               <div class="form-group form-group-default">
                           <label class="">State</label>
                                    <asp:DropDownList ID="ddlcorporatestate" runat="server" AutoPostBack="true" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2"
                                    OnSelectedIndexChanged="ddlcorporatestate_SelectedIndexChanged">
                                </asp:DropDownList>
                                
                                   </div>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="Please Select State." 
                                    InitialValue="0" ControlToValidate="ddlcorporatestate" ForeColor="Red" ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                      </div>

                          <div class="col-md-4">
                               <div class="form-group form-group-default">
                           <label class="">City</label>
                                    <asp:DropDownList ID="ddlcorporatecity" runat="server" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2">
                                </asp:DropDownList>
                             
                                   </div>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Please Select City."
                                    InitialValue="0" ControlToValidate="ddlcorporatecity" ForeColor="Red" ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                      </div>

                          <div class="col-md-4">
                               <div class="form-group form-group-default">
                           <label class="">Pin</label>
                                    <asp:TextBox ID="txtcorporatepincode" runat="server" MaxLength="6" CssClass="form-control"></asp:TextBox>
                                
                                   </div>
                              <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="txtcorporatepincode"
                                    ErrorMessage="Please Enter Pin Code." EnableClientScript="true" ForeColor="Red"
                                    ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                                   
                                                <asp:CustomValidator runat="server" ID="Customvalidator4" ForeColor="Red" ControlToValidate="txtcorporatepincode"
                                                    Display="Static" EnableClientScript="true" ClientValidationFunction="ValidateCorpPinCode"
                                                    ErrorMessage="Please enter valid pin code" OnServerValidate="cusCG_ServerValidate"
                                                    ValidationGroup="SaveGroup1"></asp:CustomValidator>
                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender10" runat="server" TargetControlID="txtcorporatepincode"
                                    FilterType="Numbers" />
                                   
                                      <asp:RegularExpressionValidator ID="RegularExpressionValidator6" ForeColor="Red" SetFocusOnError="true" runat="server" 
                                                    ErrorMessage="Pin code should be of 6 digits." ValidationExpression="^((\\+91-?)|0)?[0-9]{6}$" 
                                                     ValidationGroup="SaveGroup1" ControlToValidate="txtcorporatepincode" Display="Dynamic"></asp:RegularExpressionValidator>
                      </div>


                    </div>

                      <div class="row">
        <div class="col-md-12 col-lg-12">
             <div class="b-b b-grey m-b-20">
                  <h5 class="m-b-10">Contact Person</h5>
                </div>
            </div>
        </div>

                      <div class="row">
                          <div class="col-md-3">
                              <div class="form-group form-group-default">
                           <label class="">Name</label>
                                  <asp:TextBox ID="txtContactPerson" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                                              
                                  </div>
                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Custom"
                                                    ValidChars="-'_& " TargetControlID="txtContactPerson">
                                                </ajax:FilteredTextBoxExtender>
                                           
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtContactPerson"
                                                    ErrorMessage="Please Enter Contact Person Name." EnableClientScript="true" ForeColor="Red"
                                                    ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                          </div>
                          <div class="col-md-3">
                               <div class="form-group form-group-default">
                           <label class="">Phone</label>
                                   <asp:TextBox ID="txtPhoneNumber" ValidationGroup="SaveGroup1" CssClass="form-control" runat="server" 
                                                    MaxLength="15"></asp:TextBox>
                                                
                                  </div>
                              <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Please Enter Phone Number."
                                                    ControlToValidate="txtPhoneNumber" ForeColor="Red" ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                                               
                                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender6" runat="server" TargetControlID="txtPhoneNumber"
                                                    FilterType="Numbers" />
                                                <asp:CustomValidator runat="server" ID="CustomvalidatortxtTelePhone" ForeColor="Red"
                                                    ControlToValidate="txtPhoneNumber" ClientValidationFunction="ValidatePhoneNumber"
                                                    Display="Dynamic" ErrorMessage="Please Enter Valid Phone Number." ValidationGroup="SaveGroup1"></asp:CustomValidator>
                                                     <asp:RegularExpressionValidator ID="RegularExpressionValidator4" ForeColor="Red" SetFocusOnError="true" runat="server" 
                                                    ErrorMessage="Phone number should be greater than or equal to 6 digits." ValidationExpression="^((\\+91-?)|0)?[0-9]{6,15}$" 
                                                     ValidationGroup="SaveGroup1" ControlToValidate="txtPhoneNumber" Display="Dynamic"></asp:RegularExpressionValidator>
                          </div>
                          <div class="col-md-3">
                               <div class="form-group form-group-default">
                           <label class="">Mobile</label>
                                    <asp:TextBox ID="txtMobileNumber" ValidationGroup="SaveGroup1" runat="server" CssClass="form-control"
                                                    MaxLength="10"></asp:TextBox>
                                               
                                  </div>
                               <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="Please Enter Mobile Number."
                                                    ControlToValidate="txtMobileNumber" ForeColor="Red" ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                                                
                                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender8" runat="server" TargetControlID="txtMobileNumber"
                                                    FilterType="Numbers" />
                                                <asp:CustomValidator runat="server" ID="Customvalidator2" ForeColor="Red" ControlToValidate="txtMobileNumber"
                                                    ClientValidationFunction="ValidateMobileNumber" Display="Dynamic" ErrorMessage="Please Enter Valid Mobile Number."
                                                    ValidationGroup="SaveGroup1"></asp:CustomValidator>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ForeColor="Red" SetFocusOnError="true" runat="server" 
                                                    ErrorMessage="Mobile number should be 10 digits only." ValidationExpression="^((\\+91-?)|0)?[0-9]{10}$" 
                                                     ValidationGroup="SaveGroup1" ControlToValidate="txtMobileNumber" Display="Dynamic"></asp:RegularExpressionValidator> 
                          </div>
                          <div class="col-md-3">
                               <div class="form-group form-group-default">
                           <label class="">Email</label>
                                   <asp:TextBox ID="txtEmail" runat="server" MaxLength="50" CssClass="form-control"></asp:TextBox>
                                                
                                  </div>
                              <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtEmail"
                                                    ErrorMessage="Please Enter Email." EnableClientScript="true" ForeColor="Red"
                                                    ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidatortxtEmail" runat="server"
                                                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="Invalid Email."
                                                    ValidationGroup="SaveGroup1" ControlToValidate="txtEmail" ForeColor="Red"></asp:RegularExpressionValidator>
                          </div>
                      </div>

                      <div class="row">
                          <div class="col-md-3">
                              <div class="form-group form-group-default">
                           <label class="">Name</label>
                                  <asp:TextBox ID="txtContactPerson1"  runat="server" MaxLength="50"  CssClass="form-control"></asp:TextBox>
                                              
                                  </div>
                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender5" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Custom"
                                                    ValidChars="-'_& " TargetControlID="txtContactPerson1">
                                                </ajax:FilteredTextBoxExtender>   
                                                <asp:CustomValidator ID="CustomValidator9" runat="server" OnServerValidate="Validatedata" ClientValidationFunction="Validatedata" ValidationGroup="SaveGroup1" ControlToValidate="txtContactPerson1" ></asp:CustomValidator>
                                                 <span id="spnContactPerson1" ></span>            
                          </div>
                          <div class="col-md-3">
                               <div class="form-group form-group-default">
                           <label class="">Phone</label>
                                   <asp:TextBox ID="txtPhoneNumber1"   ValidationGroup="SaveGroup1" runat="server" MaxLength="15"  CssClass="form-control"></asp:TextBox>
                                                
                                  </div>
                              <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender7" runat="server" TargetControlID="txtPhoneNumber1"
                                                    FilterType="Numbers" />
                                                <asp:CustomValidator runat="server" ID="Customvalidator1" ForeColor="Red" ControlToValidate="txtPhoneNumber1"
                                                    ClientValidationFunction="ValidatePhoneNumber1" Display="Dynamic" ErrorMessage="Please Enter Valid Phone Number."
                                                    ValidationGroup="SaveGroup1"></asp:CustomValidator>
                                                     <asp:RegularExpressionValidator ID="RegularExpressionValidator5" ForeColor="Red" SetFocusOnError="true" runat="server" 
                                                    ErrorMessage="Phone number should be greater than or equal to 6 digits." ValidationExpression="^((\\+91-?)|0)?[0-9]{6,15}$" 
                                                     ValidationGroup="SaveGroup1" ControlToValidate="txtPhoneNumber1" Display="Dynamic"></asp:RegularExpressionValidator>
                                                     <asp:CustomValidator ID="customvalidator8" runat="server"
                                                      OnServerValidate="Validatedata" ForeColor="Red" ClientValidationFunction="Validatedata" ValidationGroup="SaveGroup1"
                                                       ControlToValidate="txtPhoneNumber1"></asp:CustomValidator>
                                                     <span id="spnPhone1"  ></span>
                          </div>
                          <div class="col-md-3">
                               <div class="form-group form-group-default">
                           <label class="">Mobile</label>
                                   <asp:TextBox ID="txtmobilenumber1"      ValidationGroup="SaveGroup1" runat="server"  CssClass="form-control"
                                                    MaxLength="10"></asp:TextBox>
                                               
                                  </div>
                               <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender9" runat="server" TargetControlID="txtmobilenumber1"
                                                    FilterType="Numbers" />
                                                <asp:CustomValidator runat="server" ID="Customvalidator3" ForeColor="Red" ControlToValidate="txtmobilenumber1"
                                                    ClientValidationFunction="ValidateMobileNumber1" Display="Dynamic" ErrorMessage="Please Enter Valid Mobile Number."
                                                    ValidationGroup="SaveGroup1"></asp:CustomValidator> 
                                                     <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ForeColor="Red" SetFocusOnError="true" runat="server" 
                                                    ErrorMessage="Mobile number should be 10 digits only." ValidationExpression="^((\\+91-?)|0)?[0-9]{10}$" 
                                                     ValidationGroup="SaveGroup1" ControlToValidate="txtmobilenumber1" Display="Dynamic"></asp:RegularExpressionValidator> 
                                                     <asp:CustomValidator ID="CustomValidator7" runat="server" OnServerValidate="Validatedata" ClientValidationFunction="Validatedata" ValidationGroup="SaveGroup1" ForeColor="Red" ControlToValidate="txtmobilenumber1"></asp:CustomValidator>                                                
                                                       <span id="SpanMobile1" ></span>     
                          </div>
                          <div class="col-md-3">
                               <div class="form-group form-group-default">
                           <label class="">Email</label>
                                   <asp:TextBox ID="txtEmail1"  runat="server"  MaxLength="50"  CssClass="form-control"></asp:TextBox>
                                               
                                  </div>
                               <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                    ErrorMessage="Invalid Email." ValidationGroup="SaveGroup1" ControlToValidate="txtEmail1"
                                                    ForeColor="Red"></asp:RegularExpressionValidator><br />
                                                     <asp:CustomValidator id="CustomValidator6" runat="server"  ForeColor="Red" OnServerValidate="Validatedata" ClientValidationFunction="Validatedata"   ValidationGroup="SaveGroup1"  ControlToValidate="txtEmail1"></asp:CustomValidator>                                            
                                                         <span id="SpanEmail1" ></span>  
                          </div>
                      </div>

                      <div class="row">
                          <div class="col-md-12">
                              <asp:Button ID="btnSave" runat="server" Text="Save" ValidationGroup="SaveGroup1" type="button" class="btn btn-primary"
                                OnClick="btnSave_Click" />
                            <asp:Button ID="btnCancel" runat="server" Text="Clear" OnClientClick="return clearfields1();" type="button" class="btn btn-primary"
                                OnClick="btnCancel_Click" />
                          </div>
                      </div>

                  </div>
                    </div>
                    </div>


     
          
              
             
                    
                            <asp:GridView ID="gdvCompanyGroup" runat="server" AutoGenerateColumns="False" 
                                CssClass="table table-hover table-condense" GridLines="None" OnRowCommand="gdvCompanyGroup_RowCommand"
                                AllowPaging="true" PageSize="20" OnPageIndexChanging="gdvCompanyGroup_PageIndexChanging">
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr No." ItemStyle-Width="7%">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex+1  %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="7%"></ItemStyle>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Group Name" ItemStyle-Width="20%">
                                        <ItemTemplate>
                                            <asp:Label ID="lblName" runat="server" Text='<%# Eval("CGName") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="20%"></ItemStyle>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Industry">
                                        <ItemTemplate>
                                            <asp:Label ID="lblIndustry" runat="server" Text='<%# Eval("IndustryId") %>' Visible="false"></asp:Label>
                                            <asp:Label ID="Industry" runat="server" Text='<%# Eval("Industry") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Contact Person">
                                        <ItemTemplate>
                                            <asp:Label ID="lblContactPerson" runat="server" Text='<%# Eval("ContactPerson") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Phone No.">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPhoneNo" runat="server" Text='<%# Eval("PhoneNumber") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="">
                                        <ItemStyle Width="5%"></ItemStyle>
                                        <ItemTemplate>
                                            <asp:HiddenField ID="hdnCompanyGroupId" runat="server" Value='<%# Eval("CompanyGroupId") %>' />
                                            <asp:LinkButton ID="lnkbtnEdit" runat="server" Text="Edit" CommandArgument='<%# Eval("CompanyGroupId") %>'
                                                CommandName="EdtCompanyGroup"></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <AlternatingRowStyle CssClass="AlternativeRowStyle" />
                            </asp:GridView>
                        
              
                <div id="loading-div-background" style="display: none;">
                    <div id="loading-div" class="ui-corner-all" style="background-color: White !important;
                        height: 200px;">
                        <img style="height: 70px; margin: 30px;" src="../images/loading.gif" alt="Loading.." />
                        <h2 style="color: Gray; font-weight: normal;">
                            Please wait....</h2>
                    </div>
                </div>
           
        </ContentTemplate>    
    </asp:UpdatePanel>
</asp:Content>
