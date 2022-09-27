<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true"
    CodeFile="Rate.aspx.cs" Inherits="Master_Rate" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../Scripts/RateCard.js" type="text/javascript"></script>
    <script src="../Scripts/1.10.4-jquery-ui.js" type="text/javascript"></script>
    <link href="../Scripts/1.10.4-themes-smoothness-jquery-ui.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-ui.js" type="text/javascript"></script>
    <ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </ajax:ToolkitScriptManager>
    <script type="text/javascript">
        Sys.Application.add_load(bindevents);
    </script>

    <script type="text/javascript">
        function CheckDecimal(Val) {
        var mainstring = document.getElementById(Val).value;
        mainstring = mainstring.toString().substring(0, 1);
        if (mainstring == '.') {
            document.getElementById(Val).value = '0' + document.getElementById(Val).value.toString();
        }
        return true;
        }
    </script>
     
       <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Rate Card</li>
            </ol>
    <div class="row">
        <div class="col-md-12 col-lg-12">
             <div class="b-b b-grey m-b-20">
                  <h3 class="m-b-10">Rate Card</h3>
                </div>

            </div>
        </div>

     <div class="row">
              <div class="col-md-12">
                <!-- START card -->
                   <asp:UpdatePanel ID="updRateCard" runat="server">
                <ContentTemplate>
                     <asp:Label ID="lblMessage" runat="server" ></asp:Label>
                  
                            </ContentTemplate>
            </asp:UpdatePanel>
                <div class="card card-default">
                  <div class="card-body">
					 <div class="row">
					 <div class="col-md-6">
                      
                         
                         <div class="form-group form-group-default form-group-default-select2 required">
                           <label class="">Rate Card</label>
                              <asp:DropDownList ID="ddlCompanyGroup" runat="server" AutoPostBack="true" TabIndex="1"  CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2"
                                    OnSelectedIndexChanged="ddlCompanyGroup_SelectedIndexChanged">
                                </asp:DropDownList><br />
                                <span id="SpnddlCompanyGroup" style="color: Red;"></span>
                          
                    </div>
                    </div>
                          <div class="col-md-6">
                               <div class="form-group form-group-default form-group-default-select2 required">
                           <label class="">Customer</label>
                                    <asp:DropDownList ID="ddlCustomer" runat="server" AutoPostBack="true" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2" TabIndex="2"
                                    OnSelectedIndexChanged="ddlCustomer_SelectedIndexChanged">
                                </asp:DropDownList><br />
                                <span id="SpnddlCustomer" style="color: Red;"></span>
                                   </div>
                    </div>
                    </div>

                      <div class="row">
                            <div class="col-md-1">  <div id="tdFdate" runat="server" visible="false">
                                From Date:</div>
                                </div>
                          <div class="col-md-5">  <asp:Label ID="lblFromDate" runat="server" Font-Bold="true" ></asp:Label>
                                </div>
                          <div class="col-md-1"> <div id="tdEnddate" runat="server" visible="false">
                                End Date:</div>
                                </div>
                          <div class="col-md-5">  <asp:Label ID="lblEndDate" runat="server" Font-Bold="true" ></asp:Label>
                                </div>
                          </div>

                      <div class="row">

                            <div class="col-md-12" style="height:300px; overflow:scroll;">
                                    <asp:GridView ID="grdRateCard" runat="server" AutoGenerateColumns="False" CssClass="table table-hover table-condense" GridLines="None">
                                        <Columns>
                                            <asp:BoundField DataField="Sr No." HeaderText="Sr No." ReadOnly="True">
                                                <ItemStyle Width="7%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Category" HeaderText="Category" ReadOnly="True">
                                                <ItemStyle Width="15%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Activity" HeaderText="Activity" ReadOnly="True">
                                                <ItemStyle Width="35%" />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Rate">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRate" runat="server" Text='<%# Bind("Rate") %>' Visible="false"></asp:Label>
                                                    <asp:TextBox ID="txtRate" TabIndex="2" runat="server" Width="90" Text='<%# Bind("Rate") %>' Style="text-align: right;"
                                                        onclick="if(this.value=='0.00'){this.value='';}" onblur="if(this.value==''){this.value='0.00';}"
                                                        onfocus="if(this.value=='0.00'){this.value='';this.focus();}" onkeypress="return CheckDecimal(this.id);"  ValidationGroup="ValRateCard1"></asp:TextBox> 
                                                    <asp:RequiredFieldValidator ID="RegFieldFname" runat="server" ForeColor="Red" ControlToValidate="txtRate" ValidationGroup="ValRateCard1"
                                                        SetFocusOnError="true" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="regexpArtPriceINR" runat="server" ControlToValidate="txtRate" ValidationGroup="ValRateCard1"
                                                        ErrorMessage="Rate should be decimal valid  (8,2) " ValidationExpression="^-?[0-9]{1,8}(\.[0-9]{1,2})?$|^-?(100)(\.[0]{1,2})?$"
                                                        ForeColor="Red"></asp:RegularExpressionValidator>
                                                    <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" FilterType="Numbers, Custom"
                                                        ValidChars="." TargetControlID="txtRate">
                                                    </ajax:FilteredTextBoxExtender>
                                                    <asp:HiddenField ID="hdnRateCardId" runat="server" Value='<%# Eval("RateCardId") %>' />
                                                    <asp:HiddenField ID="hdnActivityId" runat="server" Value='<%# Eval("ActivityId") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <AlternatingRowStyle CssClass="AlternativeRowStyle" />
                                    </asp:GridView>
                               </div>

                           </div>

                      <div class="row">
                          <div class="col-md-12 m-t-15">
                                <asp:Button ID="btnSave" type="button" class="btn btn-primary" runat="server" TabIndex="3" Text="Save" ValidationGroup="ValRateCard1" OnClientClick="javascript:return validRateCardOnly();"
                                    OnClick="btnSave_Click" />
                                <asp:Button ID="btnCancel" runat="server" type="button" class="btn btn-primary" Text="Clear" TabIndex="4" OnClick="btnCancel_Click" OnClientClick="return ClearRateC();"   />
                              </div>


                      </div>



                      </div>
                    </div>
                  </div>
         </div>
   
    
       
 
          
                 
                      
                          
                         

                           
                           
                           
                             
                        
                            
                            
                           
              
     
   
</asp:Content>
