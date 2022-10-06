<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true"
    CodeFile="CompanyMaster.aspx.cs" Inherits="Master_CompanyMaster" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../Scripts/CompanyMaster.js" type="text/javascript"></script>
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <asp:UpdatePanel ID="updCustomer" runat="server">
        <ContentTemplate>
                 </ContentTemplate>
    </asp:UpdatePanel>
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Company Master</li>
            </ol>
    <div class="row">
        <div class="col-md-12 col-lg-12">
             <div class="b-b b-grey m-b-20">
                  <h3 class="m-b-10">Company Master</h3>
                </div>
            </div>
        </div>


            <div class="row">
              <div class="col-md-12">
                <div class="card card-default">
                  <div class="card-body">
                      <div class="row">
                           <div class="col-md-6">
                                <div class="form-group form-group-default">
                           <label class="">Name</label>
                                    <asp:TextBox ID="txtGroupName" runat="server" TabIndex="1"  CssClass="form-control" MaxLength="50"></asp:TextBox>

                                    </div>
                                <asp:RequiredFieldValidator ID="ReqfGroupName" runat="server" ControlToValidate="txtGroupName"
                                    ErrorMessage="Please Enter Name." ForeColor="Red" ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                    ValidChars="-'_& " TargetControlID="txtGroupName">
                                </ajax:FilteredTextBoxExtender>
                               </div>

                          <div class="col-md-6">
                              <div class="form-group form-group-default form-group-default-select2">
                           <label class="">Industry</label>
                                   <asp:DropDownList ID="ddlindustry" runat="server" TabIndex="2"  CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2"> </asp:DropDownList>
                                    </div>
                              <asp:RequiredFieldValidator ID="reqserviceCategory" runat="server" ErrorMessage="Please Select Industry."
                                    InitialValue="0" ControlToValidate="ddlindustry" ForeColor="Red" ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                               </div>
                          </div>
                       <div class="row">
        <div class="col-md-12 col-lg-12">
             <div class="b-b b-grey m-b-20">
                  <h5 class="m-b-10">Register</h5>
                </div>
            </div>
        </div>
                      <div class="row">
                             <%--<fieldset>--%>
                          <div class="col-md-3">
                               <div class="form-group form-group-default">
                           <label class="">Address</label>
                                     <asp:TextBox ID="txtregisteraddress" TabIndex="3"  runat="server" MaxLength="200" onkeypress="return textboxMultilineMaxNumber(this.id,200)"
                                                    onkeyup="return textboxMultilineMaxNumber(this.id,200)" rows="5" Height="115"  TextMode="MultiLine"  CssClass="form-control"></asp:TextBox>
                           
                                                    
                                    </div>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtpincode"
                                                    EnableClientScript="true" ErrorMessage="Please Enter Address." ForeColor="Red"
                                                    ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>

                              </div>
                          <div class="col-md-9">
                              <div class="row">  
                                  <div class="col-md-4">
                                      <div class="form-group form-group-default form-group-default-select2">
                           <label class="">State</label>
                                      <asp:DropDownList ID="ddlState" TabIndex="4"  runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlState_SelectedIndexChanged" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2"
                                                   >
                                                </asp:DropDownList>
                                          </div>
                                      <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlState"
                                                    ErrorMessage="Please Select State." ForeColor="Red" InitialValue="0" ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                              </div>
                                  <div class="col-md-4">
                                      <div class="form-group form-group-default form-group-default-select2">
                           <label class="">City</label>
                                           <asp:DropDownList ID="ddlCity" TabIndex="5"  runat="server" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2">
                                                </asp:DropDownList>
                                               
                                               
                              </div>
 <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlCity"
                                                    ErrorMessage="Please Select City." ForeColor="Red" InitialValue="0" ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                              </div>
                                  <div class="col-md-4">
                                      <div class="form-group form-group-default">
                           <label class="">Pin</label>
                                           <asp:TextBox ID="txtpincode" runat="server" TabIndex="6"  MaxLength="8" CssClass="form-control"></asp:TextBox>
                                               
                                              
                                          </div>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtpincode"
                                                    EnableClientScript="true" ErrorMessage="Please Enter Pin Code." ForeColor="Red"
                                                    ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender11" runat="server" FilterType="Numbers"
                                                    TargetControlID="txtpincode" />
                              </div>

                              </div>
                              <div class="row">  
                                   <div class="col-md-4">
                                       <div class="form-group form-group-default">
                           <label class="">Email</label>
                                           <asp:TextBox ID="txtEmail" runat="server" TabIndex="7" class="form-control" MaxLength="50"></asp:TextBox>
                                           </div>
                                       <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="txtEmail" 
                                                    EnableClientScript="true" ErrorMessage="Please Enter Email." ForeColor="Red"
                                                    ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidatortxtEmail" runat="server"
                                                    ControlToValidate="txtEmail" ErrorMessage="Invalid Email." ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                    ValidationGroup="SaveGroup1"></asp:RegularExpressionValidator>
                              </div>
                                  <div class="col-md-4">
                                       <div class="form-group form-group-default">
                           <label class="">Phone</label>
                                <asp:TextBox ID="txtPhoneNumber" TabIndex="8"  runat="server" MaxLength="15" class="form-control" ></asp:TextBox>
                                                
                                    </div> <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="txtPhoneNumber"
                                                    EnableClientScript="true" ErrorMessage="Please Enter Phone." ForeColor="Red"
                                                    ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>                              
                                                
                                                <ajax:FilteredTextBoxExtender ID="extendertelephone" runat="server" FilterType="Numbers"
                                                    TargetControlID="txtPhoneNumber">
                                                </ajax:FilteredTextBoxExtender>
                                                  <asp:CustomValidator runat="server" ID="CustomvalidatortxtTelePhone" ForeColor="Red"
                                                    ControlToValidate="txtPhoneNumber" ClientValidationFunction="ValidatePhoneNumber"
                                                    Display="Dynamic" ErrorMessage="Please Enter Valid Phone Number." ValidationGroup="SaveGroup1"></asp:CustomValidator>
                                                     <asp:RegularExpressionValidator ID="RegularExpressionValidator5" ForeColor="Red" SetFocusOnError="true" runat="server" 
                                                    ErrorMessage="Phone number should be greater than or equal to 6 digits." ValidationExpression="^((\\+91-?)|0)?[0-9]{6,15}$" 
                                                     ValidationGroup="SaveGroup1" ControlToValidate="txtPhoneNumber" Display="Dynamic"></asp:RegularExpressionValidator>
                                      </div>
                                  <div class="col-md-4">
                                      <div class="form-group form-group-default">
                           <label class="">Fax</label>
                                    <asp:TextBox ID="txtFax" runat="server" TabIndex="9"   MaxLength="15" class="form-control"></asp:TextBox>
                                                       
                              </div>
                                       <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ControlToValidate="txtFax"
                                                    EnableClientScript="true" ErrorMessage="Please Enter Fax." ForeColor="Red"
                                                    ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                                                    <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" runat="server" FilterType="Numbers"
                                                    TargetControlID="txtFax">
                                                </ajax:FilteredTextBoxExtender>
                                                     <asp:CustomValidator runat="server" ID="Customvalidator3" ForeColor="Red"
                                                    ControlToValidate="txtFax" ClientValidationFunction="ValidateFaxNumber"
                                                    Display="Dynamic" ErrorMessage="Please Enter Valid Fax Number." ValidationGroup="SaveGroup1"></asp:CustomValidator>

                              </div>
                       
                              </div>

                          </div>
                                  <%--  </fieldset>--%>
                      </div>
                      <div class="row">
        <div class="col-md-12 col-lg-12">
             <div class="b-b b-grey m-b-20">
                  <h5 class="m-b-10">Corporate</h5>
                </div>
            </div>
        </div>

<div class="row">

    <asp:Label ID="lblMessage" runat="server" Font-Bold="true" Font-Size="Medium" ForeColor="Brown"></asp:Label>
    <div class="col-md-3">
          <div class="form-group form-group-default">
                           <label class="">Address</label>
       <asp:TextBox ID="txtcorporateaddress" TabIndex="10"  runat="server" Rows="4" Height="100"  CssClass="form-control" MaxLength="200" onkeypress="return textboxMultilineMaxNumber(this.id,200)" onkeyup="return textboxMultilineMaxNumber(this.id,200)"
                                                    TextMode="MultiLine" ></asp:TextBox>
                                                    
    </div>
        <asp:RequiredFieldValidator ID="ReqFieldcorporateaddress" ControlToValidate="txtcorporateaddress" ForeColor="Red" runat="server" ValidationGroup="SaveGroup1" ErrorMessage="Please Enter Address."></asp:RequiredFieldValidator>
          </div>
    <div class="col-md-9">
        <div class="row">
            <div class="col-md-4">
                 <div class="form-group form-group-default form-group-default-select2">
                           <label class="">State</label>
                      <asp:DropDownList ID="ddlcorporatestate" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2" TabIndex="11"  runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlcorporatestate_SelectedIndexChanged"
                                                   >
                                                </asp:DropDownList>
                                               
                     </div>
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="ddlcorporatestate"
                                                    ErrorMessage="Please Select State." ForeColor="Red" InitialValue="0" ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                </div>
            <div class="col-md-4">
                 <div class="form-group form-group-default form-group-default-select2">
                           <label class="">City</label>
                     <asp:DropDownList ID="ddlcorporatecity" TabIndex="12"  runat="server" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2">
                                                </asp:DropDownList>
                     </div>
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="ddlcorporatecity"
                                                    ErrorMessage="Please Select City." ForeColor="Red" InitialValue="0" ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                </div>
            <div class="col-md-4">
                 <div class="form-group form-group-default form-group-default-select2">
                           <label class="">Pin</label>
                       <asp:TextBox ID="txtcorporatepincode" TabIndex="13" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2"  runat="server" MaxLength="8"></asp:TextBox>
                                               
                     </div>
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="txtcorporatepincode"
                                                    EnableClientScript="true" ErrorMessage="Please Enter Pin Code." ForeColor="Red"
                                                    ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender10" runat="server" FilterType="Numbers"
                                                    TargetControlID="txtcorporatepincode" />
                </div>
        </div>
         <div class="row">
            <div class="col-md-4">
                <div class="form-group form-group-default">
                           <label class="">Email</label>
                     <asp:TextBox ID="txtcorporateemail" TabIndex="14"  runat="server" MaxLength="50" class="form-control" ></asp:TextBox>
                                                  
                    </div>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtcorporateemail"
                                                    EnableClientScript="true" ErrorMessage="Please Enter Email." ForeColor="Red"
                                                    ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtcorporateemail"
                                                        ErrorMessage="Invalid Email." ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                        ValidationGroup="SaveGroup1"></asp:RegularExpressionValidator>
                </div>
            <div class="col-md-4">
                <div class="form-group form-group-default">
                           <label class="">Phone</label>
                    <asp:TextBox ID="txtPhoneNumber1" runat="server" TabIndex="15"  MaxLength="15" class="form-control"  ></asp:TextBox>
                    
                    </div>
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtPhoneNumber1"
                                                    EnableClientScript="true" ErrorMessage="Please Enter Phone." ForeColor="Red"
                                                    ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                                                    <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender8" runat="server" FilterType="Numbers"
                                                        TargetControlID="txtPhoneNumber1">
                                                    </ajax:FilteredTextBoxExtender><br />
                                                     <asp:CustomValidator runat="server" ID="Customvalidator1" ForeColor="Red"
                                                    ControlToValidate="txtPhoneNumber1" ClientValidationFunction="ValidatePhoneNumber1"
                                                    Display="Dynamic" ErrorMessage="Please Enter Valid Phone Number." ValidationGroup="SaveGroup1"></asp:CustomValidator>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ForeColor="Red" SetFocusOnError="true" runat="server" 
                                                    ErrorMessage="Phone number should be greater than or equal to 6 digits." ValidationExpression="^((\\+91-?)|0)?[0-9]{6,15}$" 
                                                     ValidationGroup="SaveGroup1" ControlToValidate="txtPhoneNumber1" Display="Dynamic"></asp:RegularExpressionValidator>
                </div>
            <div class="col-md-4">
                <div class="form-group form-group-default">
                           <label class="">Fax</label>
                    <asp:TextBox ID="txtcorporatefax" runat="server" MaxLength="15" TabIndex="16" class="form-control"  ></asp:TextBox>
                                                   
                    </div>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtcorporatefax"
                                                    EnableClientScript="true" ErrorMessage="Please Enter Fax." ForeColor="Red"
                                                    ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                                                     <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender12" runat="server" FilterType="Numbers"
                                                        TargetControlID="txtcorporatefax"></ajax:FilteredTextBoxExtender><br />
                                                         <asp:CustomValidator runat="server" ID="Customvalidator2" ForeColor="Red"
                                                    ControlToValidate="txtcorporatefax" ClientValidationFunction="ValidateCorpFaxNumber"
                                                    Display="Dynamic" ErrorMessage="Please Enter Valid Fax Number." ValidationGroup="SaveGroup1"></asp:CustomValidator>
                </div>
        </div>

        



    </div>

</div>
<div class="row">
            <div class="col-md-3">
                 <div class="form-group form-group-default">
                           <label class="">PAN</label>
                      <asp:TextBox ID="txtPANNo" runat="server" MaxLength="10" TabIndex="17"  onchange="javascript:upperletter(this.value);" class="form-control"
                                    ></asp:TextBox>
                                            
                     </div>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ControlToValidate="txtPANNo"
                                                    EnableClientScript="true" ErrorMessage="Please Enter PAN No." ForeColor="Red"
                                                    ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                    TargetControlID="txtPANNo">
                                </ajax:FilteredTextBoxExtender>
            </div>
            <div class="col-md-3">
                 <div class="form-group form-group-default">
                           <label class="">TAN</label>
                      <asp:TextBox ID="txtTAN" runat="server" MaxLength="25" TabIndex="18"  onchange="javascript:upperletterTan(this.value);" class="form-control"
                                   ></asp:TextBox>                                           
                               
                     </div>
                 <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                    TargetControlID="txtTAN">
                                </ajax:FilteredTextBoxExtender>
            </div>
            <div class="col-md-2">
                 <div class="form-group form-group-default">
                           <label class="">CIN</label>
                      <asp:TextBox ID="txtCIN" runat="server" TabIndex="19"  MaxLength="17" class="form-control"></asp:TextBox>                                
                                
                     </div>
                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender5" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers"
                                    TargetControlID="txtCIN">
                                </ajax:FilteredTextBoxExtender>
            </div>
            <div class="col-md-2">
                 <div class="form-group form-group-default">
                           <label class=""> VAT</label>
                     <asp:TextBox ID="txtVAT" TabIndex="20"  runat="server" MaxLength="25" class="form-control"></asp:TextBox>                                
                                
                     </div>
                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender6" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers"
                                    TargetControlID="txtVAT">
                                </ajax:FilteredTextBoxExtender>
            </div>
            <div class="col-md-2">
                 <div class="form-group form-group-default">
                           <label class="">Sales Tax</label>
                       <asp:TextBox ID="txtSalesTaxNo" TabIndex="21"  runat="server" class="form-control" MaxLength="25"></asp:TextBox>                          
                               
                     </div>
                 <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender7" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers"
                                    TargetControlID="txtSalesTaxNo">
                                </ajax:FilteredTextBoxExtender>
            </div>
        </div>

                      <div class="row">
                          <div class="col-md-12">
                               <asp:Button ID="btnSave" runat="server" TabIndex="22"  OnClick="btnSave_Click"  type="button" class="btn btn-primary"
                                    Text="Save" ValidationGroup="SaveGroup1" />
                              <asp:Button ID="btnCancel" runat="server" TabIndex="23"  OnClick="btnCancel_Click" OnClientClick="return clearfields1();" type="button" class="btn btn-primary"
                                    Text="Clear" />
                          </div>
                      </div>

                      <div class="row">
                          <div class="col-md-12 m-t-10">
                              <asp:GridView ID="gdvCompanyMaster" runat="server" OnRowCommand="gdvCompanyMaster_RowCommand" AllowPaging="true" AutoGenerateColumns="False"
                                    CssClass="table table-hover table-condense" GridLines="None" PageSize="20" Width="100%">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Sr No." ItemStyle-Width="7%">
                                            <ItemTemplate>
                                                <asp:Label ID="lblSrNo" runat="server" Text="<%# Container.DataItemIndex+1  %>"></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle Width="7%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Group Name" ItemStyle-Width="20%">
                                            <ItemTemplate>
                                                <asp:Label ID="lblName" runat="server" Text='<%# Eval("CMName") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle Width="20%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Industry">
                                            <ItemTemplate>
                                                <asp:Label ID="lblIndustry" runat="server" Text='<%# Eval("IndustryId") %>' Visible="false"></asp:Label>
                                                <asp:Label ID="Industry" runat="server" Text='<%# Eval("Industry") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                       
                                        <asp:TemplateField HeaderText="Phone No.">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPhoneNo" runat="server" Text='<%# Eval("PhoneNumber") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="">
                                            <ItemStyle Width="5%" />
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hdnCompanyMasterId" runat="server" Value='<%# Eval("CompanyMasterId") %>' />
                                                <asp:LinkButton ID="lnkbtnEdit" TabIndex="24"  runat="server" CommandArgument='<%# Eval("CompanyMasterId") %>'
                                                    CommandName="EdtCompanyMaster" Text="Edit"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <AlternatingRowStyle CssClass="AlternativeRowStyle" />
                                </asp:GridView>
                          </div>

                      </div>

                    </div>
                  </div>
                </div>

                </div>





            
           
              
             
                  
                                
                           
              
                <div id="loading-div-background" style="display: none;">
                    <div id="loading-div" class="ui-corner-all" style="background-color: White !important;
                        height: 200px;">
                        <img style="height: 70px; margin: 30px;" src="../images/loading.gif" alt="Loading.." />
                        <h2 style="color: Gray; font-weight: normal;">
                            Please wait....</h2>
                    </div>
                </div>
            
   
</asp:Content>
