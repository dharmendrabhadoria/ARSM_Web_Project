<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true"
    CodeFile="ServiceCategory.aspx.cs" Inherits="Master_ServiceCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../Scripts/ServiceCategory.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">
    </script>
    <ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </ajax:ToolkitScriptManager>
    <style type="text/css">
        .ui-autocomplete
        {
            width: 310px !important;
        }
        .disblebtn
        {
            background-color: #797979;
        }
    </style>
   
    <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Service Category</li>
            </ol>
    <div class="row">
        <div class="col-md-12 col-lg-12">
             <div class="b-b b-grey m-b-20">
                  <h3 class="m-b-10">Service Category</h3>
                </div>

            </div>
        </div>

     <div class="row">
              <div class="col-md-12">

  <div class="card card-default">
                  <div class="card-body">

                           <asp:Label ID="lblMessage" runat="server" Font-Bold="true" Visible="true" Font-Size="Medium"
                            ForeColor="Brown"></asp:Label>
					 <div class="row">
                    
					 <div class="col-md-6">
                           <div class="form-group form-group-default">
                           <label class="">Name</label>
                                <asp:TextBox ID="txtSCName" runat="server" MaxLength="50" CssClass="form-control"></asp:TextBox>
                        

                               </div>
                         <asp:RequiredFieldValidator ID="ReqfldName" runat="server" ControlToValidate="txtSCName"
                            ErrorMessage="Please Enter Name." ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                        <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Custom"
                            ValidChars="-'_.& " TargetControlID="txtSCName">
                        </ajax:FilteredTextBoxExtender>
                         </div>
                          <div class="col-md-6">
                               <div class="form-group form-group-default">
                                    <label class="">Remark</label>
                                   <asp:TextBox ID="txtRemark" runat="server"  CssClass="form-control"
                            onkeypress=" return textboxMultilineMaxNumber(this.id,200)" onkeyup=" return textboxMultilineMaxNumber(this.id,200) "></asp:TextBox>

                                   </div>
                              </div>
                    </div>
                      <div class="row">
                          <div class="col-md-12">
                               <asp:Button ID="btnSave" runat="server" type="button" class="btn btn-primary"  Text="Save" ValidationGroup="SaveGroup" OnClientClick="return  Validatefields();"
                            OnClick="btnSave_Click" />
                        <asp:Button ID="btnCancel" runat="server" Text="Clear" type="button" class="btn btn-primary"  OnClientClick="clearfields();return false;" />
                          </div>

                      </div>


                      <div class="row">
                          <div class="col-md-12 m-t-20">
                              <asp:GridView ID="gdvSearchCategory" runat="server" AutoGenerateColumns="False"  CssClass="table table-hover table-condense"
                             GridLines="None" OnRowDataBound="gdvSearchCategory_RowDataBound"
                            AllowPaging="True" OnPageIndexChanging="gdvSearchCategory_PageIndexChanging"
                            PageSize="20">
                            <Columns>
                                <asp:TemplateField HeaderText="Sr No.">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Name" >
                                    <ItemTemplate>
                                        <asp:Label ID="lblName" runat="server" Text='<%#Eval("SCName") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Remark">
                                    <ItemTemplate>
                                        <div style="width: 450px; overflow: auto;">
                                            <asp:Label ID="lblRemark" runat="server" Text='<%# Eval("Remark") %>'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="">
                                    <ItemStyle></ItemStyle>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkbtnEdit" runat="server" Text="Edit" OnClientClick="javascript:Hide();"
                                            CommandArgument='<%# Eval("IsEdit") %>'></asp:LinkButton>
                                        <asp:HiddenField ID="hdnEditid" runat="server" Value='<%# Eval("IsEdit") %>' />
                                        <asp:HiddenField ID="hdnCategoryid" runat="server" Value='<%# Eval("ServiceCategoryId") %>' />
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
   
     
      
         
                        
                   
        
       
        <asp:HiddenField ID="hdneditid" runat="server" />
        <asp:HiddenField ID="hdnCategoryid" runat="server" />
        <div id="loading-div-background" style="display: none;">
            <div id="loading-div" class="ui-corner-all" style="background-color: White !important;
                height: 200px;">
                <img style="height: 70px; margin: 30px;" src="../images/loading.gif" alt="Loading.." />
                <h2 style="color: Gray; font-weight: normal;">
                    Please wait....</h2>
            </div>
        </div>
   
</asp:Content>
