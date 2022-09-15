<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true" EnableEventValidation="true"  
    CodeFile="Activity.aspx.cs" Inherits="Master_ServiceActivity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../Scripts/Activity.js" type="text/javascript"></script>
    <ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </ajax:ToolkitScriptManager>
    <asp:UpdatePanel ID="updActivity" runat="server">
        <ContentTemplate>
    <div class="clear">
    </div>

    <div class="middle">
    
        <div class="frmbxhead" style="width: 150px;">
            Activity
        </div>
        
        


        <div class="frmbox">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">

           <tr>
                <td width="15%">
               </td>
                <td align="center" colspan="3" >
                  <asp:Label ID="lblMessage" runat="server"  Font-Bold="true" Font-Size="Medium" ForeColor="Brown"></asp:Label>
               </td>
             </tr>
                <tr>
                    <td width="15%">
                        Service Category
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlServiceCategory" runat="server" Width="200">
                            <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                        </asp:DropDownList><br />
                        <asp:RequiredFieldValidator ID="reqserviceCategory" runat="server" ErrorMessage="Please Select Service Category." InitialValue="0" ControlToValidate="ddlServiceCategory" ForeColor="Red" ValidationGroup="SaveGroup" ></asp:RequiredFieldValidator>
                    </td>
                      <td width="12%">
                        Activity Name
                    </td>
                    <td>
                        <asp:TextBox ID="txtActivityName" runat="server" Style="width: 200px;" 
                            MaxLength="50"></asp:TextBox><br />
                            <asp:RequiredFieldValidator ID="ReqfldName" runat="server" 
                        ControlToValidate="txtActivityName" ErrorMessage="Please Enter Name." 
                        ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                           <ajax:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Custom"
                            ValidChars="-'_.& " TargetControlID="txtActivityName">
                        </ajax:FilteredTextBoxExtender>
                    </td>
                </tr>
                <tr>
                    <td width="12%">
                        Remark
                    </td>
                    <td colspan="3" >
                        <asp:TextBox ID="txtRemark" runat="server" Style="width: 250px;resize:none;" TextMode="MultiLine"
                            onkeypress="return textboxMultilineMaxNumber(this.id,200)" onkeyup="return textboxMultilineMaxNumber(this.id,200)"></asp:TextBox>
                    </td>
                </tr>
                <tr>                
                 <td width="12%">
                        Unit
                    </td>
                    <td colspan="3">
                <asp:RadioButtonList ID="rbtnUnit" Style="width: 500px;"   runat="server" 
                            RepeatDirection="Horizontal" Width="500px">                    
                    <asp:ListItem Value="1" selected="True" Text="Per Box Per Month"></asp:ListItem>  
                    <asp:ListItem Value="2" Text="Per File"></asp:ListItem>  
                    <asp:ListItem Value="3" Text="Per Box"></asp:ListItem>  
                    <asp:ListItem Value="4" Text="Per Unit"></asp:ListItem>  
                </asp:RadioButtonList>  
                </td>
                </tr>

                <tr>
                    <td colspan="4" class="bordnone">
                        <asp:Button ID="btnSave" runat="server" Text="Save"  
                            OnClientClick="return  Validatefields();" onclick="btnSave_Click"  />
                        <asp:Button ID="btnCancel" runat="server" Text="Clear" 
                            OnClientClick="clearfields();return false;"  />
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="4">
                    <div style="float:right" runat="server" id="divShowFilter"   > Filter by Service Category : <asp:DropDownList runat="server"    
                    ID="ddlfiltersearchbyCategory" AutoPostBack="True"   
                            onselectedindexchanged="ddlfiltersearchbyCategory_SelectedIndexChanged" CausesValidation="false" ValidationGroup="none" onchange="Page_BlockSubmit = false;"   >
            
            </asp:DropDownList> </div> <br /> <br />
                      <asp:GridView ID="gdvActivity" runat="server" AutoGenerateColumns="False" 
                        width="100%" CssClass="grid_data" GridLines="None" 
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
                    </td>
                </tr>
            </table>
            <asp:HiddenField ID="hdneditid" runat="server"      /> 
            <asp:HiddenField ID="hdnActivityId" runat="server"      />

        </div>
    
    </div>
            </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
