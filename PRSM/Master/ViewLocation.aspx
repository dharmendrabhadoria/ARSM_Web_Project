<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true"
    CodeFile="ViewLocation.aspx.cs" Inherits="Master_ViewLocation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <script src="../Scripts/BoxLocation.js" type="text/javascript"></script>
 
    <script type="text/javascript">
        Sys.Application.add_load(BindBoxBarcodeEvents);
            </script>
  

     <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Box Location</li>
            </ol>
                  

      <div class="card card-transparent">

     <ul class="nav nav-tabs nav-tabs-linetriangle" data-init-reponsive-tabs="dropdownfx">
   <li class="nav-item">
   
     <asp:LinkButton ID="lnkbtnGenerateLocation" runat="server" Font-Underline="false" 
                        CausesValidation="false" 
            onclick="lnkbtnGenerateLocation_Click" >  Generate Location</asp:LinkButton>
           </li>
      <li class="nav-item">
        
        <asp:LinkButton ID="lnkbtnMapLocation" runat="server" Font-Underline="false" CssClass="nav-item"
                        CausesValidation="false" onclick="lnkbtnMapLocation_Click" >  Map Location</asp:LinkButton>
            
       
          </li>
         <li class="nav-item">
        
         <asp:LinkButton ID="lnkbtnSearchLocation" runat="server" Font-Underline="false" CssClass="nav-item"
                        CausesValidation="false" onclick="lnkbtnSearchLocation_Click" >  Search Location</asp:LinkButton>
            
       
             </li>
         </ul>
        <div class="tab-content">
        <div id="divGenerateLocation" runat="server"  >
         <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>



                    <div class="tab-pane slide-left show active" id="fade1">
                         
                            <div class="row">
              <div class="col-lg-12 col-md-12">
                <!-- START card -->
                <div class="card card-default">
                 
                  <div class="card-body">
                    
					 <div class="row">
					 <div class="col-md-6">

                          
                                   <div class="form-group form-group-default form-group-default-select2 required">
                           <label class="">Warehouse</label>
                          <asp:DropDownList ID="ddlWareHouseGenrate" runat="server" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2"
                                    AutoPostBack="True" 
                                    onselectedindexchanged="ddlWareHouseGenrate_SelectedIndexChanged"  >
                              
                               
                                </asp:DropDownList>
                                       </div>



                      
					  </div>
					  <div class="col-md-6">
                          
					   <div class="form-group form-group-default form-group-default-select2 required">
                        <label class="">Row</label>
                     
                       
                          
                                 
                                    <asp:DropDownList ID="ddlRowGroupGenrate" runat="server"   CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2" >
                                    </asp:DropDownList>

                                     
					  </div>
                       </div>
                          <asp:Label ID="lblMessage" runat="server" Font-Bold="true" Font-Size="Medium" ForeColor="Brown"></asp:Label>
                         <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlWareHouseGenrate"
                                    ErrorMessage="Please Select WareHouse." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroupGenrate"></asp:RequiredFieldValidator>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlRowGroupGenrate"
                                    ErrorMessage="Please Select Row." InitialValue="0" ForeColor="Red" ValidationGroup="SaveGroupGenrate"></asp:RequiredFieldValidator>
                     </div>
					 
                      
                     
					  
					  <div class="m-t-15"> 
                          <asp:Button ID="btnGenerate" runat="server" Text="Generate" type="button" class="btn btn-primary btn-cons btn-animated from-left" ValidationGroup="SaveGroupGenrate"
                                    onclick="btnGenerate_Click"   />
                            <asp:Button ID="btnCancel" runat="server" CausesValidation="false" type="button" class="btn btn-primary btn-cons btn-animated from-left" ValidationGroup="SaveGroupGenrate" Text="Clear" OnClick="btnCancel_Click" />
                               

                      
                    </div>
                
                  </div>
                </div>
                <!-- END card -->
              </div>
              
            </div>
                          
                        </div>

             
                              
                           
                                
                         
                               <%-- <asp:DropDownList ID="ddlWareHouseGenrate" runat="server" Width="200" 
                                    AutoPostBack="True" 
                                    onselectedindexchanged="ddlWareHouseGenrate_SelectedIndexChanged"  >
                                </asp:DropDownList>--%>
                               
                               
                                  
                </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        <div id="divMapLocation" runat="server"  >
      <div class="tab-pane slide-left" id="fade2">
                          <div class="row">
                            <div class="col-lg-12">
                             
					 <div class="row">
					 <div class="col-md-6">
                  
                          
                           <asp:Label runat="server" ID="Label1" Font-Bold="true" Font-Size="Medium" ForeColor="Brown"    ></asp:Label>
                        <label class="">Uplodad Excel File: </label>
                         <asp:FileUpload ID="fiuploadExcel" runat="server"  onchange=" return validateFileUpload();"  />
           
                         <asp:Button ID="btnUpload" runat="server"   Text="Upload" 
             OnClientClick=" return validateFileUpload();"    onclick="btnUpload_Click"  />
                     </div>
                          <div class="col-md-6">
                         <asp:Label runat="server" ID="lblLocationValidationMessage" Font-Bold="true" Font-Size="Medium" ForeColor="Brown"    ></asp:Label>
                        

                          </div>
                           </div>
					  </div>
					 
					  </div>
                  
                    
                            </div>
                          </div>
      
      
           <asp:GridView runat="server" ID="grdValidateLocation" AutoGenerateColumns="false" 
                                          Width="95%" CssClass="table table-hover" 
                                        onpageindexchanging="grdLocationDetails_PageIndexChanging"      >
                                <Columns>
                                <asp:TemplateField HeaderText="Sr No.">
                                                                <ItemTemplate>
                                                                 <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'></asp:Label>
                                                                </ItemTemplate>
                                                                  <ItemStyle Width="10%" ></ItemStyle>
                                                            </asp:TemplateField>
                                <asp:TemplateField HeaderText="Location Code" >
                                 <ItemTemplate>
                                <asp:Label ID="lblLocationCode" runat="server" Text='<%# Eval("Location") %>' ></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="10%" ></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Box BarCode" >
                                 <ItemTemplate>
                                <asp:Label ID="lblBoxBarCodes" runat="server" Text='<%# Eval("BoxBarCode") %>' ></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="10%" ></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status" >
                                 <ItemTemplate>
                                 <asp:Image runat="server" ID="imgValid" ImageUrl= '<% #GetImageForValid(Eval("BoxOrLocStatus"))%> '  style="height:16px;width:14px;"   />
                                <asp:Label ID="lblBoxOrLocStatus" runat="server" Text='<%# Eval("BoxOrLocStatus") %>' ></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="10%" ></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Remraks" >
                                 <ItemTemplate>
                                <asp:Label ID="lblRemraks" runat="server" Text='<%# Eval("Remraks") %>' ></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="60%" ></ItemStyle>
                                </asp:TemplateField>
                         
                               
                                
                                </Columns>
                                </asp:GridView>
     

        <asp:Button ID="btnSaveLocation" runat="server"   Text="Save" 
               onclick="btnSaveLocation_Click"    />

     
           

             <div id="divSearchLocation" runat="server"  >
            
                   <div class="tab-pane slide-left" id="fade3">
                       <div class="row">
                          
                            <div class="col-md-4">



                                     <div class="form-group form-group-default form-group-default-select2 required">

                                <label>WareHouse</label>
                           
                                <asp:DropDownList ID="ddlWareHouseSearch" runat="server"
                                    AutoPostBack="True"  CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2"
                                    onselectedindexchanged="ddlWareHouseSearch_SelectedIndexChanged"                 >
                                </asp:DropDownList>
                           </div>

                              
                                
                                </div>

                          <div class="col-md-4">
    <div class="form-group form-group-default form-group-default-select2 required">

                                    <label>Row</label>
                               
                                    <asp:DropDownList ID="ddlRowSearch" runat="server"   CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2">
                                    </asp:DropDownList>
        </div>
    </div>

                           
                           <div class="col-md-4">
                               <div class="form-group form-group-default">
                                <label>Location  </label>
                                
                                        <asp:HiddenField ID="selectedValue" runat="server" />
                                        <asp:TextBox ID="txtSearchLocation" runat="server" class="form-control" onblur="autocompDropFile(this.id,'#ContentPlaceHolder1_selectedValue');" > </asp:TextBox>
                                        
                                        </div>

                          
                              </div>



                               </div>
                         

                 <div class="row">
                     <div class="col-md-6">
                           <asp:Button ID="btnSearch" runat="server" CausesValidation="false"   Text="Search" 
                                        onclick="btnSearch_Click" type="button" CssClass="btn btn-primary"  />
                                        <asp:Button ID="btnClear" runat="server" CausesValidation="false"   
                                        Text="Clear" onclick="btnClear_Click"  type="button"  CssClass="btn btn-primary" />
                     </div>
                 </div>
                        
                       <div class="row">
                           <div class="col-md-12">
                               <asp:GridView runat="server" ID="grdLocationDetails" AutoGenerateColumns="false" 
                                        AllowPaging="true" CssClass="table table-hover m-t-20" 
                                        onpageindexchanging="grdLocationDetails_PageIndexChanging"      >
                                <Columns>
                                <asp:TemplateField HeaderText="Sr No.">
                                                                <ItemTemplate>
                                                                 <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'></asp:Label>
                                                                </ItemTemplate>
                                                                  <ItemStyle ></ItemStyle>
                                                            </asp:TemplateField>
                                <asp:TemplateField HeaderText="Location Code" >
                                 <ItemTemplate>
                                <asp:Label ID="lblLocationCode" runat="server" Text='<%# Eval("LocationCode") %>' ></asp:Label>
                                </ItemTemplate>
                                <ItemStyle  ></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Box Details" >
                                 <ItemTemplate>
                                <asp:Label ID="lblBoxBarCodes" runat="server" Text='<%# Eval("BoxBarCodes") %>' ></asp:Label>
                                </ItemTemplate>
                                <ItemStyle></ItemStyle>
                                
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Total" >
                                 <ItemTemplate>
                                <asp:Label ID="lblBoxCount" runat="server" Text='<%# Eval("BoxCount") %>' ></asp:Label>/
                                <asp:Label ID="lblMaxBoxCount" runat="server" Text='<%# Eval("MaxBoxCount") %>' ></asp:Label>
                                </ItemTemplate>
                                <ItemStyle  ></ItemStyle>
                                </asp:TemplateField>
                               
                                
                                </Columns>
                                </asp:GridView>

                           </div>

                       </div>
            </div>
            
        </div>
             </div>
   </div>
        
</asp:Content>

