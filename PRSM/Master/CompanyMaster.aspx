<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true"
    CodeFile="CompanyMaster.aspx.cs" Inherits="Master_CompanyMaster" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<style type="text/css">
    .frmbox td {
padding: 5px 8px;
}
</style>
    <script src="../Scripts/CompanyMaster.js" type="text/javascript"></script>
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <asp:UpdatePanel ID="updCustomer" runat="server">
        <ContentTemplate>
            <div class="clear">
            </div>
            <div class="middle">
                <div class="frmbxhead" style="width: 150px;">
                    Company Master</div>
                <div class="frmbox">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="15%" align="center">
                            </td>
                            <td width="21%" colspan="7" align="center">
                                <asp:Label ID="lblMessage" runat="server" Font-Bold="true" Font-Size="Medium" ForeColor="Brown"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td width="15%">
                                Name
                            </td>
                            <td width="21%">
                                <asp:TextBox ID="txtGroupName" runat="server" TabIndex="1" Style="width: 200px;" MaxLength="50"></asp:TextBox><br />
                                <asp:RequiredFieldValidator ID="ReqfGroupName" runat="server" ControlToValidate="txtGroupName"
                                    ErrorMessage="Please Enter Name." ForeColor="Red" ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                    ValidChars="-'_& " TargetControlID="txtGroupName">
                                </ajax:FilteredTextBoxExtender>
                            </td>
                            <td width="15%">
                                Industry
                            </td>
                            <td colspan="5">
                                <asp:DropDownList ID="ddlindustry" runat="server" TabIndex="2"  Width="200">
                                </asp:DropDownList>
                                <br />
                                <asp:RequiredFieldValidator ID="reqserviceCategory" runat="server" ErrorMessage="Please Select Industry."
                                    InitialValue="0" ControlToValidate="ddlindustry" ForeColor="Red" ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="8" width="100%">
                                <fieldset style="border: #e4e4e4 2px solid; -webkit-border-top-left-radius: 10px;
                                    -webkit-border-top-right-radius: 10px; -moz-border-radius-topleft: 10px; -moz-border-radius-topright: 10px;">
                                    <legend><b>Register</b></legend>
                                    <table width="100%">
                                        <tr>
                                            <td>
                                                Address
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtregisteraddress" TabIndex="3"  runat="server" MaxLength="200" onkeypress="return textboxMultilineMaxNumber(this.id,200)"
                                                    onkeyup="return textboxMultilineMaxNumber(this.id,200)" Style="width: 190px;
                                                    height: 45px;" TextMode="MultiLine"></asp:TextBox><br />
                                                      <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtpincode"
                                                    EnableClientScript="true" ErrorMessage="Please Enter Address." ForeColor="Red"
                                                    ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                                            </td>
                                            <td>
                                                State
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlState" TabIndex="4"  runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlState_SelectedIndexChanged"
                                                    Width="200">
                                                </asp:DropDownList><br />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlState"
                                                    ErrorMessage="Please Select State." ForeColor="Red" InitialValue="0" ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                                            </td>
                                            <td>
                                                City
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlCity" TabIndex="5"  runat="server" Width="200">
                                                </asp:DropDownList>
                                                <br />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlCity"
                                                    ErrorMessage="Please Select City." ForeColor="Red" InitialValue="0" ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                                            </td>
                                            <td>
                                                Pin
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtpincode" runat="server" TabIndex="6"  MaxLength="8"></asp:TextBox>
                                                <br />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtpincode"
                                                    EnableClientScript="true" ErrorMessage="Please Enter Pin Code." ForeColor="Red"
                                                    ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender11" runat="server" FilterType="Numbers"
                                                    TargetControlID="txtpincode" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Email
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtEmail" runat="server" TabIndex="7"  MaxLength="50" Style="width: 100px;"></asp:TextBox>
                                                <br />
                                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="txtEmail"
                                                    EnableClientScript="true" ErrorMessage="Please Enter Email." ForeColor="Red"
                                                    ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator><br />
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidatortxtEmail" runat="server"
                                                    ControlToValidate="txtEmail" ErrorMessage="Invalid Email." ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                    ValidationGroup="SaveGroup1"></asp:RegularExpressionValidator>
                                            </td>
                                            <td>
                                                Phone
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtPhoneNumber" TabIndex="8"  runat="server" MaxLength="15" Style="width: 100px;"></asp:TextBox><br />
                                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="txtPhoneNumber"
                                                    EnableClientScript="true" ErrorMessage="Please Enter Phone." ForeColor="Red"
                                                    ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>                              
                                                
                                                <ajax:FilteredTextBoxExtender ID="extendertelephone" runat="server" FilterType="Numbers"
                                                    TargetControlID="txtPhoneNumber">
                                                </ajax:FilteredTextBoxExtender><br />
                                                  <asp:CustomValidator runat="server" ID="CustomvalidatortxtTelePhone" ForeColor="Red"
                                                    ControlToValidate="txtPhoneNumber" ClientValidationFunction="ValidatePhoneNumber"
                                                    Display="Dynamic" ErrorMessage="Please Enter Valid Phone Number." ValidationGroup="SaveGroup1"></asp:CustomValidator>
                                                     <asp:RegularExpressionValidator ID="RegularExpressionValidator5" ForeColor="Red" SetFocusOnError="true" runat="server" 
                                                    ErrorMessage="Phone number should be greater than or equal to 6 digits." ValidationExpression="^((\\+91-?)|0)?[0-9]{6,15}$" 
                                                     ValidationGroup="SaveGroup1" ControlToValidate="txtPhoneNumber" Display="Dynamic"></asp:RegularExpressionValidator>

                                            </td>                                            
                                            <td>
                                                Fax
                                            </td>
                                            <td colspan="3">
                                                <asp:TextBox ID="txtFax" runat="server" TabIndex="9"   MaxLength="15" Style="width: 100px;"></asp:TextBox><br />
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ControlToValidate="txtFax"
                                                    EnableClientScript="true" ErrorMessage="Please Enter Fax." ForeColor="Red"
                                                    ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                                                    <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" runat="server" FilterType="Numbers"
                                                    TargetControlID="txtFax">
                                                </ajax:FilteredTextBoxExtender><br />
                                                     <asp:CustomValidator runat="server" ID="Customvalidator3" ForeColor="Red"
                                                    ControlToValidate="txtFax" ClientValidationFunction="ValidateFaxNumber"
                                                    Display="Dynamic" ErrorMessage="Please Enter Valid Fax Number." ValidationGroup="SaveGroup1"></asp:CustomValidator>
                                            </td>
                                    </table>
                                </fieldset>
                        </tr>
                        <tr>
                            <td colspan="8" width="100%">
                                <fieldset style="border: #e4e4e4 2px solid; -webkit-border-top-left-radius: 10px;
                                    -webkit-border-top-right-radius: 10px; -moz-border-radius-topleft: 10px; -moz-border-radius-topright: 10px;">
                                    <legend><b>Corporate</b></legend>
                                    <table width="100%">
                                        <tr>
                                            <td>
                                                Address
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtcorporateaddress" TabIndex="10"  runat="server" MaxLength="200" Style="width: 190px;
                                                    height: 45px;" onkeypress="return textboxMultilineMaxNumber(this.id,200)" onkeyup="return textboxMultilineMaxNumber(this.id,200)"
                                                    TextMode="MultiLine"></asp:TextBox><br />
                                                    <asp:RequiredFieldValidator ID="ReqFieldcorporateaddress" ControlToValidate="txtcorporateaddress" ForeColor="Red" runat="server" ValidationGroup="SaveGroup1" ErrorMessage="Please Enter Address."></asp:RequiredFieldValidator>

                                            </td>
                                            <td>
                                                State
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlcorporatestate" TabIndex="11"  runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlcorporatestate_SelectedIndexChanged"
                                                    Width="200">
                                                </asp:DropDownList><br />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="ddlcorporatestate"
                                                    ErrorMessage="Please Select State." ForeColor="Red" InitialValue="0" ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                                            </td>
                                            <td>
                                                City
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlcorporatecity" TabIndex="12"  runat="server" Width="200">
                                                </asp:DropDownList>
                                                <br />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="ddlcorporatecity"
                                                    ErrorMessage="Please Select City." ForeColor="Red" InitialValue="0" ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                                                &nbsp;&nbsp;
                                            </td>
                                            <td>
                                                Pin
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtcorporatepincode" TabIndex="13"  runat="server" MaxLength="8"></asp:TextBox><br />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="txtcorporatepincode"
                                                    EnableClientScript="true" ErrorMessage="Please Enter Pin Code." ForeColor="Red"
                                                    ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender10" runat="server" FilterType="Numbers"
                                                    TargetControlID="txtcorporatepincode" />
                                            </td>
                                            <tr>
                                                <td>
                                                    Email
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtcorporateemail" TabIndex="14"  runat="server" MaxLength="50" Style="width: 100px;"></asp:TextBox>
                                                    <br />
                                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtcorporateemail"
                                                    EnableClientScript="true" ErrorMessage="Please Enter Email." ForeColor="Red"
                                                    ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator><br />
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtcorporateemail"
                                                        ErrorMessage="Invalid Email." ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                        ValidationGroup="SaveGroup1"></asp:RegularExpressionValidator>
                                                </td>
                                                <td>
                                                    Phone
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtPhoneNumber1" runat="server" TabIndex="15"  MaxLength="15" Style="width: 100px;"></asp:TextBox><br />
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
                                                </td>                                               
                                                <td>
                                                    Fax
                                                </td>
                                                <td colspan="3">
                                                    <asp:TextBox ID="txtcorporatefax" runat="server" MaxLength="15" TabIndex="16"  Style="width: 100px;"></asp:TextBox><br />
                                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtcorporatefax"
                                                    EnableClientScript="true" ErrorMessage="Please Enter Fax." ForeColor="Red"
                                                    ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                                                     <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender12" runat="server" FilterType="Numbers"
                                                        TargetControlID="txtcorporatefax"></ajax:FilteredTextBoxExtender><br />
                                                         <asp:CustomValidator runat="server" ID="Customvalidator2" ForeColor="Red"
                                                    ControlToValidate="txtcorporatefax" ClientValidationFunction="ValidateCorpFaxNumber"
                                                    Display="Dynamic" ErrorMessage="Please Enter Valid Fax Number." ValidationGroup="SaveGroup1"></asp:CustomValidator>
                                                </td>
                                            </tr>
                                    </table>
                                </fieldset>
                        </tr>
                        <tr>
                            <td>
                                PAN
                            </td>
                            <td>
                                <asp:TextBox ID="txtPANNo" runat="server" MaxLength="10" TabIndex="17"  onchange="javascript:upperletter(this.value);"
                                    Style="width: 100px;"></asp:TextBox><br />
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ControlToValidate="txtPANNo"
                                                    EnableClientScript="true" ErrorMessage="Please Enter PAN No." ForeColor="Red"
                                                    ValidationGroup="SaveGroup1"></asp:RequiredFieldValidator>
                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                    TargetControlID="txtPANNo">
                                </ajax:FilteredTextBoxExtender>
                            </td>
                            <td>
                                TAN
                            </td>
                            <td>
                                <asp:TextBox ID="txtTAN" runat="server" MaxLength="25" TabIndex="18"  onchange="javascript:upperletterTan(this.value);"
                                    Style="width: 100px;"></asp:TextBox>                                           
                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                    TargetControlID="txtTAN">
                                </ajax:FilteredTextBoxExtender>
                            </td>
                            <td>
                                CIN
                            </td>
                            <td>
                                <asp:TextBox ID="txtCIN" runat="server" TabIndex="19"  MaxLength="17" Style="width: 100px;"></asp:TextBox>                                
                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender5" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers"
                                    TargetControlID="txtCIN">
                                </ajax:FilteredTextBoxExtender>
                            </td>
                            <td>
                                VAT
                            </td>
                            <td>
                                <asp:TextBox ID="txtVAT" TabIndex="20"  runat="server" MaxLength="25" Style="width: 100px;"></asp:TextBox>                                
                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender6" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers"
                                    TargetControlID="txtVAT">
                                </ajax:FilteredTextBoxExtender>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Sales Tax
                            </td>
                            <td colspan="7">
                                <asp:TextBox ID="txtSalesTaxNo" TabIndex="21"  runat="server" MaxLength="25" Style="width: 100px;"></asp:TextBox>                          
                                <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender7" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers"
                                    TargetControlID="txtSalesTaxNo">
                                </ajax:FilteredTextBoxExtender>
                            </td>
                        </tr>
                        <tr>
                            <td class="bordnone" colspan="8">
                                <asp:Button ID="btnSave" runat="server" TabIndex="22"  OnClick="btnSave_Click" 
                                    Text="Save" ValidationGroup="SaveGroup1" />
                                <asp:Button ID="btnCancel" runat="server" TabIndex="23"  OnClick="btnCancel_Click" OnClientClick="return clearfields1();"
                                    Text="Clear" />
                            </td>
                        </tr>
                        <tr>
                            <td align="left" colspan="8">
                                <asp:GridView ID="gdvCompanyMaster" runat="server" OnRowCommand="gdvCompanyMaster_RowCommand" AllowPaging="true" AutoGenerateColumns="False"
                                    CssClass="grid_data" GridLines="None" PageSize="20" Width="100%">
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
                            </td>
                        </tr>
                        </tr>
                    </table>
                </div>
                <div id="loading-div-background" style="display: none;">
                    <div id="loading-div" class="ui-corner-all" style="background-color: White !important;
                        height: 200px;">
                        <img style="height: 70px; margin: 30px;" src="../images/loading.gif" alt="Loading.." />
                        <h2 style="color: Gray; font-weight: normal;">
                            Please wait....</h2>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
