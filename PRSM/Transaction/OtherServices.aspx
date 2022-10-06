<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true"
    CodeFile="OtherServices.aspx.cs" Inherits="Transaction_OtherServices" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript" language="javascript">
    function ValidateNoOfBoxes(source, args) {
        var number = document.getElementById('<%=txtnoofservices.ClientID%>').value;
        if (number > 30000) {
            args.IsValid = false;
        }
        else {
            args.IsValid = true;
        }
    }

   function CheckDecimal(Value) {
         var mainstring = Value;
         mainstring = mainstring.toString().substring(0, 1);
        if (mainstring == '.') {
            $('#ContentPlaceHolder1_txtAmount').val('0'+Value);
        }
        return true;
        }
  
</script>
    
    <ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </ajax:ToolkitScriptManager>





    <asp:UpdatePanel ID="UpdOtherServices" runat="server">
    <ContentTemplate>

          <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Other Services</li>
            </ol>
            <div class="row">
        <div class="col-md-12 col-lg-12">
             <div class="b-b b-grey m-b-20">
                  <h3 class="m-b-10">Other Services</h3>
                </div>
            </div>
                </div>
        <asp:LinkButton ID="lnkbtnOtherServices" runat="server" Font-Underline="false" Style="color: #4f4f4f !important;"
                CausesValidation="false" OnClientClick="return false;"> Other Services </asp:LinkButton>
        <div class="row">
              <div class="col-md-12">
                <div class="card card-default">
                  <div class="card-body">
                      <div class="row">
                          <div class="col-md-4">
                              <div class="form-group form-group-default form-group-default-select2">
                           <label class="">WareHouse</label>
                                  <asp:DropDownList ID="ddlWareHouse" runat="server" AutoPostBack="true" TabIndex="1" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2"
                            onselectedindexchanged="ddlWareHouse_SelectedIndexChanged">
                        </asp:DropDownList>
                       
                                  </div>
                               <asp:RequiredFieldValidator ID="RequiredFieldValidator4" SetFocusOnError="true" runat="server" ControlToValidate="ddlWareHouse"
                            ErrorMessage="Please Select WareHouse." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                          </div>
                          <div class="col-md-4">
                              <div class="form-group form-group-default form-group-default-select2">
                           <label class="">Company Group</label>
                                  <asp:DropDownList ID="ddlCompanyGroup" TabIndex="2" runat="server" AutoPostBack="true" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2" OnSelectedIndexChanged="ddlCompanyGroup_SelectedIndexChanged">
                        </asp:DropDownList>
                       
                                  </div>
                                <span id="SpnddlCompanyGroup" style="color: Red;"></span>
                     
                         <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlCompanyGroup"
                            ErrorMessage="Please Select Company Group." SetFocusOnError="true" InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                          </div>
                          <div class="col-md-4">
                              <div class="form-group form-group-default form-group-default-select2">
                           <label class="">Customer</label>
                                  <asp:DropDownList ID="ddlCustomer" TabIndex="3" runat="server" AutoPostBack="true" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2"
                            Width="210" onselectedindexchanged="ddlCustomer_SelectedIndexChanged">
                        </asp:DropDownList>
                        
                                  </div>
                               <span id="SpnddlCustomer" style="color: Red;"></span>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" SetFocusOnError="true" runat="server" ControlToValidate="ddlCustomer"
                            ErrorMessage="Please Select Customer." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                          </div>
                      </div>

                      <div class="row">
                          <div class="col-md-6">
                              <div class="form-group form-group-default form-group-default-select2">
                           <label class="">Work Order</label>
                                  <asp:DropDownList ID="ddlWorkOrder" TabIndex="4" runat="server" AutoPostBack="true" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2"
                            onselectedindexchanged="ddlWorkOrder_SelectedIndexChanged">
                        </asp:DropDownList>
                        
                                  </div>
                               <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlWorkOrder"
                            ErrorMessage="Please Select Work Order." SetFocusOnError="true" InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                          </div>
                          <div class="col-md-6">
                              <div class="form-group form-group-default form-group-default-select2">
                           <label class="">Work Order Activity</label>
                                   <asp:DropDownList ID="ddlWorkOrderActivity" TabIndex="5" runat="server" AutoPostBack="true"  CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2"
                            onselectedindexchanged="ddlWorkOrderActivity_SelectedIndexChanged">
                        </asp:DropDownList>
                        
                                  </div>
                               <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="ddlWorkOrderActivity"
                            ErrorMessage="Please Select Activity." SetFocusOnError="true" InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>

                          </div>
                      </div>

                      <div class="row">
                          <div class="col-md-4">
                              <div class="form-group form-group-default">
                           <label class="">No of Services</label>
                                  <asp:TextBox ID="txtnoofservices" runat="server"  TabIndex="6" MaxLength="5" CssClass="form-control"></asp:TextBox>
                         
                                  </div>
                              <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" runat="server" TargetControlID="txtnoofservices"  FilterType="Numbers" />                                                       
                        <asp:RequiredFieldValidator ID="reqvaltxtnoofservices" ForeColor='Red' ControlToValidate="txtnoofservices" ErrorMessage="Please Enter No. of Services." SetFocusOnError="true" ValidationGroup="SaveGroup" runat="server"></asp:RequiredFieldValidator> <br />
                         <asp:CustomValidator runat="server" ID="custvaladmin" ControlToValidate="txtnoofservices"
                        ClientValidationFunction="ValidateNoOfBoxes" Display="Dynamic" ForeColor='Red' ErrorMessage="No. Of Services Must Be Less Than Or Equal To 30000."
                        ValidationGroup="SaveGroup"></asp:CustomValidator>
                          </div>
                          <div class="col-md-4">
                              <div class="form-group form-group-default">
                           <label class="">Amount(Per Unit)</label>
                                   <asp:TextBox ID="txtAmount" runat="server" MaxLength="10" onkeypress="return CheckDecimal(this.value);" TabIndex="6" CssClass="form-control"></asp:TextBox> 
                         
                                  </div>
                              <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" TargetControlID="txtAmount" ValidChars="."  FilterType="Numbers,Custom" />  
                         <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ForeColor='Red' ControlToValidate="txtAmount" ErrorMessage="Please Enter Amount." SetFocusOnError="true" ValidationGroup="SaveGroup" runat="server"></asp:RequiredFieldValidator> <br />
                          <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtAmount"
                                    Display="Dynamic" ForeColor='Red' ErrorMessage="Amount should be decimal valid (8,2)" ValidationExpression="^-?[0-9]{1,9}(\.[0-9]{1,2})?$|^-?(100)(\.[0]{1,2})?$"
                                    ValidationGroup="SaveGroup"></asp:RegularExpressionValidator>  
                          </div>
                          <div class="col-md-4">
                              <div class="form-group form-group-default">
                           <label class="">Remark</label>
                                  <asp:TextBox ID="txtRemark" runat="server" TabIndex="7" TextMode="MultiLine" CssClass="form-control"></asp:TextBox> 
                                  </div>
                              <asp:Label ID="lblMessage" runat="server"  Font-Bold="true" Font-Size="Medium" ForeColor="Brown"></asp:Label>
                          </div>
                      </div>

                      <div class="row">
                          <div class="col-md-12">
                              <asp:Button ID="btnSave" runat="server" TabIndex="8" Text="Save" ValidationGroup="SaveGroup" type="button" class="btn btn-primary"
                            onclick="btnSave_Click" />
                        <asp:Button ID="btnCancel" TabIndex="9" runat="server" Text="Clear" type="button" class="btn btn-primary" 
                            onclick="btnCancel_Click" />
                          </div>

                      </div>



                      </div>
                    </div>
                  </div>
            </div>





    </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
