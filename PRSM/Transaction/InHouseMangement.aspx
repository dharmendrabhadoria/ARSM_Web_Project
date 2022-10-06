<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true" CodeFile="InHouseMangement.aspx.cs" Inherits="Transaction_InHouseMangement" %>


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


    function CheckDecimal(Val) {
        var mainstring = document.getElementById(Val).value;
        mainstring = mainstring.toString().substring(0, 1);
        if (mainstring == '.') {
            document.getElementById(Val).value = '0' + document.getElementById(Val).value.toString();
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
              <li class="breadcrumb-item active">In House Management</li>
            </ol>
    <div class="row">
        <div class="col-md-12 col-lg-12">
             <div class="b-b b-grey m-b-20">
                  <h3 class="m-b-10">In House Management</h3>
                </div>

            </div>
        </div>

       
            <asp:LinkButton ID="lnkbtnOtherServices" runat="server" Font-Underline="false" Style="color: #4f4f4f !important;"
                CausesValidation="false" OnClientClick="return false;"> In House Management</asp:LinkButton>
      

        <asp:Label ID="lblMessage" runat="server"  Font-Bold="true" Font-Size="Medium" ForeColor="Brown"></asp:Label>

           <div class="row">
              <div class="col-md-12">
                <div class="card card-default">
                  <div class="card-body">
                      <div class="row">
                           <div class="col-md-4">
                                  <div class="form-group form-group-default form-group-default-select2">
                           <label class="">WareHouse</label>
                                       <asp:DropDownList ID="ddlWareHouse" runat="server" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2" AutoPostBack="true"
                            onselectedindexchanged="ddlWareHouse_SelectedIndexChanged">
                        </asp:DropDownList>

                                      </div>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlWareHouse" SetFocusOnError="true"
                            ErrorMessage="Please Select WareHouse." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                               </div>

                          <div class="col-md-4">
                                  <div class="form-group form-group-default form-group-default-select2">
                           <label class="">Company Group</label>
                                       <asp:DropDownList ID="ddlCompanyGroup" runat="server" AutoPostBack="true"  CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2"
                            OnSelectedIndexChanged="ddlCompanyGroup_SelectedIndexChanged">
                        </asp:DropDownList>
                                      </div>
                              <span id="SpnddlCompanyGroup" style="color: Red;"></span>
                       
                         <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" SetFocusOnError="true" ControlToValidate="ddlCompanyGroup"
                            ErrorMessage="Please Select Company Group." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                              </div>

                          <div class="col-md-4">
                                  <div class="form-group form-group-default form-group-default-select2">
                           <label class="">Customer</label>
                                       <asp:DropDownList ID="ddlCustomer" runat="server" AutoPostBack="true"  CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2"
                            onselectedindexchanged="ddlCustomer_SelectedIndexChanged">
                        </asp:DropDownList>
                              
                                  </div>
                               <span id="SpnddlCustomer" style="color: Red;"></span>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" SetFocusOnError="true" ControlToValidate="ddlCustomer"
                            ErrorMessage="Please Select Customer." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                              </div>
                          </div>

                      <div class="row">
                          <div class="col-md-6">
                              <div class="form-group form-group-default form-group-default-select2">
                           <label class="">Work Order</label>
                                  <asp:DropDownList ID="ddlWorkOrder" runat="server" AutoPostBack="true" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2" onselectedindexchanged="ddlWorkOrder_SelectedIndexChanged">
                        </asp:DropDownList>
                                  </div>
                               <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" SetFocusOnError="true" ControlToValidate="ddlWorkOrder"
                            ErrorMessage="Please Select Work Order." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                              </div>

                        

                         <div class="col-md-6">
                              <div class="form-group form-group-default form-group-default-select2">
                           <label class="">Work Order Activity</label>
                                  <asp:DropDownList ID="ddlWorkOrderActivity" runat="server" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2" AutoPostBack="true" >
                        </asp:DropDownList>
                                  </div>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator5" SetFocusOnError="true" runat="server" ControlToValidate="ddlWorkOrderActivity"
                            ErrorMessage="Please Select Activity." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                              </div>
                      </div>

                      <div class="row">
                          <div class="col-md-4">
                               <div class="form-group form-group-default">
                           <label class="">No of Services</label>
                                   <asp:TextBox ID="txtnoofservices" runat="server" CssClass="form-control" MaxLength="5" Enabled="false"  Text="1"  ></asp:TextBox>
                                   </div>
                               <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" runat="server" TargetControlID="txtnoofservices"  FilterType="Numbers" />                                                       
                        <asp:RequiredFieldValidator ID="reqvaltxtnoofservices" Visible="false" SetFocusOnError="true" ForeColor='Red' ControlToValidate="txtnoofservices" ErrorMessage="Please Enter No. of Services."  ValidationGroup="SaveGroup" runat="server"></asp:RequiredFieldValidator> <br />
                         <asp:CustomValidator runat="server" ID="custvaladmin" ControlToValidate="txtnoofservices"
                        ClientValidationFunction="ValidateNoOfBoxes" Display="Dynamic" ForeColor='Red' ErrorMessage="No. Of Services Must Be Less Than Or Equal To 30000."
                        ValidationGroup="SaveGroup"></asp:CustomValidator>
                          </div>
                          <div class="col-md-4">
                               <div class="form-group form-group-default">
                           <label class="">Amount</label>
                                   <asp:TextBox ID="txtAmount"  runat="server" MaxLength="10" onkeypress="javascript:CheckDecimal(this.id);"  CssClass="form-control"></asp:TextBox>

                                   </div>
                              <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" TargetControlID="txtAmount" ValidChars="."  FilterType="Numbers,Custom" />  
                         <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ForeColor='Red' ControlToValidate="txtAmount" ErrorMessage="Please Enter Amount." SetFocusOnError="true" ValidationGroup="SaveGroup" runat="server"></asp:RequiredFieldValidator> <br />
                         <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtAmount"
                                    Display="Dynamic" ForeColor='Red' ErrorMessage="Amount should be decimal valid (8,2)" ValidationExpression="^-?[0-9]{1,8}(\.[0-9]{1,2})?$|^-?(100)(\.[0]{1,2})?$"
                                    ValidationGroup="SaveGroup"></asp:RegularExpressionValidator>      
                          </div>
                           <div class="col-md-4">
                               <div class="form-group form-group-default">
                           <label class="">Remark</label>
                                    <asp:TextBox ID="txtRemark" runat="server" TextMode="MultiLine"   CssClass="form-control"></asp:TextBox>           
                                   </div>
                               </div>
                      </div>

                      <div class="row">
                          <div class="col-md-12">
                               <asp:Button ID="btnSave" runat="server" Text="Save" ValidationGroup="SaveGroup"  type="button" class="btn btn-primary"
                            onclick="btnSave_Click" />
                        <asp:Button ID="btnCancel" runat="server" Text="Clear"  type="button" class="btn btn-primary"
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

