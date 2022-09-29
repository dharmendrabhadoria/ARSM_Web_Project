<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/MasterPages/PRSM.master" CodeFile="ViewContract.aspx.cs" Inherits="Master_ViewContract" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </ajax:ToolkitScriptManager>


        <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">View Contract</li>
            </ol>
    <div class="row">
        <div class="col-md-12 col-lg-12">
             <div class="b-b b-grey m-b-20">
                  <h3 class="m-b-10">View Contract</h3>
                </div>

            </div>
        </div>
    <div id="divSearchContract" runat="server">
        <div class="row">
              <div class="col-md-12">
                <div class="card card-default">
                  <div class="card-body">
                      <div class="row">
                            <asp:Label ID="Label1" runat="server" Font-Bold="true" Font-Size="Medium" ForeColor="Brown"></asp:Label>
                           <div class="col-md-6">
                              <div class="form-group form-group-default form-group-default-select2">
                           <label class="">Company Group</label>
                                    <asp:DropDownList ID="ddlCompanyGroup" runat="server" AutoPostBack="true" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2"
                                    OnSelectedIndexChanged="ddlCompanyGroup_SelectedIndexChanged">
                                </asp:DropDownList>
                               
                                  </div>
                                <span id="SpnddlCompanyGroup" style="color: Red;"></span>
                      </div>

                          <div class="col-md-6">
                              <div class="form-group form-group-default form-group-default-select2">
                           <label class="">Customer</label>
                                  <asp:DropDownList ID="ddlCustomer" runat="server" AutoPostBack="true" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2"
                                    OnSelectedIndexChanged="ddlCustomer_SelectedIndexChanged" />
                                <span id="SpnddlCustomer" style="color: Red;"></span>
                                  </div>
                              </div>


                        </div>
                    </div>
                  </div>
            </div>
            </div>
          </div>
    <div class="row">
    <div class="col-md-12">
       
                    
                 <asp:UpdatePanel ID="UpdateViewContract" runat="server">
                   <ContentTemplate>
                        
                       
                                    <asp:GridView ID="gvViewContract" runat="server" AutoGenerateColumns="False" CssClass="table table-hover table-condense"
                                         GridLines="None" AllowPaging="True"  PageSize="20" 
                                        onpageindexchanging="gvViewContract_PageIndexChanging" >
                                        <Columns>
                                            <asp:TemplateField HeaderText="Sr No." ItemStyle-Width="7%">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="7%"></ItemStyle>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="ContractNo" HeaderText="Contract No" ReadOnly="True">
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Remark" HeaderText="Remark" ReadOnly="True">
                                            </asp:BoundField>
                                            <asp:BoundField DataField="DocumentName" HeaderText="Document Name" ReadOnly="True"></asp:BoundField>
                                          
                                                <asp:TemplateField>
                                                <ItemTemplate>
                                                <asp:ImageButton ID="imgEdit" runat="server" ImageUrl="~/images/view-bt.png"  CommandName="ViewPath"
                                                CommandArgument='<%# Eval("Filepath") %>' onclick="imgEdit_Click" />
                                                </ItemTemplate>
                                                </asp:TemplateField>
                                        </Columns>
                                        <EmptyDataTemplate>
                                            <asp:Label ID="lblErrorMessage" runat="server" Font-Bold="true" Font-Size="Medium"
                                                ForeColor="Brown" Text="No Record Found." Style="padding-left: 250px;"></asp:Label>
                                        </EmptyDataTemplate>
                                        <AlternatingRowStyle CssClass="AlternativeRowStyle" />
                                        <EmptyDataRowStyle VerticalAlign="Middle" />
                                    </asp:GridView>
                                
                        </ContentTemplate>
                        <Triggers>
                        <asp:PostBackTrigger ControlID="gvViewContract"  />
                     </Triggers>
                        </asp:UpdatePanel>
                  
        </div>
     
    </div>
</asp:Content>