<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true" EnableEventValidation="true"  
    CodeFile="Activity.aspx.cs" Inherits="Master_ServiceActivity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../Scripts/Activity.js" type="text/javascript"></script>
    <ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </ajax:ToolkitScriptManager>
    <asp:UpdatePanel ID="updActivity" runat="server">
        <ContentTemplate>
    

    <div class="middle">
      <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Activity</li>
            </ol>
        <div class="row">
        <div class="col-md-12 col-lg-12">
             <div class="b-b b-grey m-b-20">
                  <h3 class="m-b-10">Activity</h3>
                </div>

            </div>
        </div>


      
         
                  <asp:Label ID="lblMessage" runat="server"  Font-Bold="true" Font-Size="Medium" ForeColor="Brown"></asp:Label>
        <div class="card card-default"> 
            <div class="card-body">
        <div class="row">
        <div class="col-md-6">
          <div class="form-group form-group-default form-group-default-select2 required">
                         
                    <label class="">Service Category</label>
                                     <%-- <select class="full-width" ID="ddlServiceCategory" runat="server" data-placeholder="Select Country" data-init-plugin="select2">
                                          <option value="0">--Select--</option>
                                          </select>--%>
                        <asp:DropDownList ID="ddlServiceCategory" runat="server" CssClass="full-width" data-init-plugin="select2">
                            <asp:ListItem ></asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="reqserviceCategory" Style="display:none;" runat="server" ErrorMessage="Please Select Service Category." InitialValue="0" ControlToValidate="ddlServiceCategory" ForeColor="Red" ValidationGroup="SaveGroup" ></asp:RequiredFieldValidator>
                  </div>
                      </div>  
        <div class="col-md-6">
                  <div class="form-group form-group-default required">
                       <label>Activity Name</label>
                        <asp:TextBox ID="txtActivityName" runat="server" MaxLength="50" CssClass="form-control" required></asp:TextBox>

                      </div>
            </div></div>
            


        <div class="row">
    <div class="col-md-6">
                            <asp:RequiredFieldValidator ID="ReqfldName" runat="server" 
                        ControlToValidate="txtActivityName" ErrorMessage="Please Enter Name." 
                        ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                           <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Custom"
                            ValidChars="-'_.& " TargetControlID="txtActivityName">
                        </ajax:FilteredTextBoxExtender>
                    <div class="form-group form-group-default required">
                        <label>Remark</label>
                        <asp:TextBox ID="txtRemark" runat="server" CssClass="form-control" TextMode="MultiLine"
                            onkeypress="return textboxMultilineMaxNumber(this.id,200)" onkeyup="return textboxMultilineMaxNumber(this.id,200)"></asp:TextBox>
                        </div>
              </div>
           
    <div class="col-md-6">
        <div  class="form-check">
                       <p class="m-t-10">Unit</p>
                   
                   
                <asp:RadioButtonList ID="rbtnUnit"  runat="server" 
                            RepeatDirection="Horizontal" Width="500px">                    
                    <asp:ListItem Value="1" selected="True" Text="Per Box Per Month"></asp:ListItem>  
                    <asp:ListItem Value="2" Text="Per File"></asp:ListItem>  
                    <asp:ListItem Value="3" Text="Per Box"></asp:ListItem>  
                    <asp:ListItem Value="4" Text="Per Unit"></asp:ListItem>  
                </asp:RadioButtonList>  
            </div>
                </div>

    </div>
               


                        <asp:Button ID="btnSave" runat="server" Text="Save"  CssClass="btn btn-primary btn-cons btn-animated from-left"
                            OnClientClick="return  Validatefields();" onclick="btnSave_Click"  />
                        <asp:Button ID="btnCancel" runat="server" Text="Clear"  CssClass="btn btn-primary btn-cons btn-animated from-left"
                            OnClientClick="clearfields();return false;"  />

                 


               

                   
                 </div>  </div> 


                    <div style="float:right" runat="server" id="divShowFilter"   > Filter by Service Category : <asp:DropDownList runat="server"    
                    ID="ddlfiltersearchbyCategory" AutoPostBack="True"   
                            onselectedindexchanged="ddlfiltersearchbyCategory_SelectedIndexChanged" CausesValidation="false" ValidationGroup="none" onchange="Page_BlockSubmit = false;"   >
            
            </asp:DropDownList> </div> <br /> <br />


                      <asp:GridView ID="gdvActivity" runat="server" AutoGenerateColumns="False" 
                        width="100%" CssClass="table table-hover" GridLines="None" 
                            onrowdatabound="gdvActivity_RowDataBound" AllowPaging="True" 
                            onpageindexchanging="gdvActivity_PageIndexChanging"  PageSize="20"   >
                        <Columns>
                        <asp:TemplateField HeaderText="Sr No."   ItemStyle-Width= "7%" >
                                <ItemTemplate>
                                    <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'  ></asp:Label>
                                </ItemTemplate>

<ItemStyle Width="7%"></ItemStyle>
                            </asp:TemplateField>
                                <asp:TemplateField HeaderText="Service Category " ItemStyle-Width= "20%" >
                                <ItemTemplate>
                                    <asp:Label ID="lblSCName" runat="server" Text='<%# Eval("SCName") %>'></asp:Label>
                                </ItemTemplate>

<ItemStyle Width="20%"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Activity Name" ItemStyle-Width= "20%" >
                                <ItemTemplate>
                                    <asp:Label ID="lblName" runat="server" Text='<%# Eval("ActivityName") %>'></asp:Label>
                                </ItemTemplate>

<ItemStyle Width="20%"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Remark">
                            <ItemTemplate>
                            <div style="width:450px;overflow:auto;" >
                                    <asp:Label ID="lblRemark" runat="server" Text='<%# Eval("Remark") %>'></asp:Label>
                                    </div>
                                </ItemTemplate>
                            
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="">
                            <ItemStyle Width="5%"></ItemStyle>
                            <ItemTemplate>
                                    <asp:LinkButton ID="lnkbtnEdit" runat="server" Text="Edit" CommandArgument='<%# Eval("IsEdit") %>'     ></asp:LinkButton>
                                    <asp:HiddenField ID="hdnEditid" runat="server" Value = '<%# Eval("IsEdit") %>'   />
                                    <asp:HiddenField ID="hdnActivityid" runat="server" Value = '<%# Eval("ActivityId") %>'   />
                                    <asp:HiddenField ID="hdnCategoryid" runat="server" Value = '<%# Eval("ServiceCategoryId") %>'    />
                                    <asp:HiddenField ID="hdnUnit" runat="server" Value = '<%# Eval("Unit") %>'    />
                                </ItemTemplate>
                            
                            </asp:TemplateField>
                        </Columns>
                        <AlternatingRowStyle CssClass="AlternativeRowStyle"   />
                        <EmptyDataTemplate>
                        <label style="color: Red;text-align: center;padding-left: 350px;font-weight: bold; "  > No Record Found</label>
                        </EmptyDataTemplate>
                    </asp:GridView>
                   
           
            <asp:HiddenField ID="hdneditid" runat="server"      /> 
            <asp:HiddenField ID="hdnActivityId" runat="server"      />


    
    </div>
            </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
