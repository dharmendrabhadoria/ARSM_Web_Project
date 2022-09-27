<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true"
    CodeFile="City.aspx.cs" Inherits="Master_City" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <script src="../Scripts/City.js" type="text/javascript"></script>
    

     <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">City</li>
            </ol>
    <div class="row">
        <div class="col-md-12 col-lg-12">
             <div class="b-b b-grey m-b-20">
                  <h3 class="m-b-10">City Master</h3>
                </div>

            </div>
        </div>
       <div class="row">
              <div class="col-md-12">
                <!-- START card -->
                <div class="card card-default">
                  <div class="card-body">
					 <div class="row">
					 <div class="col-md-6">
                         <div class="form-group form-group-default form-group-default-select2 required">
                           <label class="">City State</label>

                              <asp:DropDownList ID="ddlState"  CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlState_SelectedIndexChanged">
                        </asp:DropDownList>
                        <span id="SpnddlState" style="color: Red;"></span>
                    </div>
                         </div>
                         <div class="col-md-6">
                            <div class="form-group form-group-default">
                           <label class="">City</label>
                            <asp:TextBox ID="txtCity" runat="server" MaxLength="40" CssClass="form-control"></asp:TextBox>
                        <span id="spntxtCity" style="color: Red;"></span>
     </div>

                    </div>
                   
                    </div>
                      <div class="row">
                          <div class="col-md-12">
                               <asp:Button ID="btnSave"  type="button" class="btn btn-primary" runat="server" Text="Save " OnClientClick="javascript:return validate();"
                            OnClick="btnSave_Click" />
                        <asp:Button ID="btnCancel" runat="server"  type="button" class="btn btn-primary"  Text="Clear" 
                         OnClick="btnCancel_Click" />
                        <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>

                          </div>

                      </div>
                       

                    </div>
                </div>
                  </div>
           </div>
            
        
       
            <%--<asp:UpdatePanel ID="updRateCard" runat="server">
                <ContentTemplate>--%>
        <div class="row">
        <div class="col-md-12 col-lg-12">
             <div class="b-b b-grey m-b-20">
                  <h3 class="m-b-10">State City List</h3>
                </div>

            </div>
        </div>
                        
                   
                   
                        <asp:DataList runat="server" ID="dlistcity" RepeatColumns="3" RepeatDirection="Horizontal"
                            BorderWidth="0" RepeatLayout="Table" OnItemCommand="dlistcity_ItemCommand" CssClass="table table-hover">
                            <ItemTemplate>
                                <td>
                                    <asp:Label ID="lblCityName" runat="server" Text='<%# Bind("CityName") %>'></asp:Label>
                                    <asp:Label ID="lblStateName" runat="server" Text='<%# Bind("StateName") %>' Visible="false"></asp:Label>
                                    <div style="float: right; ">
                                        <asp:LinkButton ID="lnkbtnEdit" runat="server" Text="Edit" CommandName="Select"></asp:LinkButton>
                                        <asp:HiddenField ID="hdnCityId" runat="server" Value='<%# Eval("CityId") %>' />
                                        <asp:HiddenField ID="hdnStateId" runat="server" Value='<%# Eval("StateId") %>' />
                                    </div>
                                </td>
                               
                            </ItemTemplate>
                            
                        </asp:DataList>
                  
                        <asp:DataList ID="dlPaging" runat="server" RepeatDirection="Horizontal" HorizontalAlign="Center"
                            CssClass="grid_data" OnItemDataBound="dlPaging_ItemDataBound" OnItemCommand="dlPaging_ItemCommand1">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkbtnPaging" runat="server" CommandArgument='<%# Eval("PageIndex") %>'
                                    CommandName="lnkbtnPaging" Text='<%# Eval("PageText") %>'></asp:LinkButton>
                            </ItemTemplate>
                        </asp:DataList>
                    
       
    <asp:HiddenField ID="hfPagesize" runat="server" Value="200" />
</asp:Content>
