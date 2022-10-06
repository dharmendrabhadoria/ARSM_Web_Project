<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true"
    CodeFile="UploadPickupData.aspx.cs" Inherits="Transaction_UploadExcelData" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="sm" runat="server">
    </asp:ScriptManager>
    <script type="text/javascript">
        function validateFileUpload() {

            var WorkorderNumber = document.getElementById('ContentPlaceHolder1_ddlWorkorderNumber').value;
            if (WorkorderNumber == "0") {
                alert("Please select Workorder Number.");
                document.getElementById("ContentPlaceHolder1_ddlWorkorderNumber").focus();
                return false;
            }

            var uplSheet = document.getElementById('ContentPlaceHolder1_FileUpload_Pickup');
            // alert(uplSheet.value.trim());
            var extn = uplSheet.value.substring(uplSheet.value.lastIndexOf('.') + 1).toLowerCase();
            if (uplSheet.value.trim() == "") {
                alert('Please Select File To Upload');
                return false;
            }
            var i = 1;
            if (uplSheet.value.trim() == "") {
                alert('Please Select File To Upload');
                return false;
            }
            else {
                if (uplSheet.value.trim() != "") {
                    // var i = 1;
                    if (extn == 'xls' || extn == 'xlsx') {
                        i = 0;
                    }
                }
            }
            if (i == 1) {
                uplSheet.value = '';
                alert('You can upload file with (.xls Or .xlsx) extensions only.');
                return false;
            }

            
            return true;
            
        }
    </script>
    <%--        <asp:UpdatePanel ID="updUploadPickup" runat="server">
            <ContentTemplate><div class="middle">--%>





     <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Upload Pickup Data</li>
            </ol>
            <div class="row">
        <div class="col-md-12 col-lg-12">
             <div class="b-b b-grey m-b-20">
                  <h3 class="m-b-10">Upload Pickup Data</h3>
                </div>
            </div>
                </div>
    <div class="frmbxhead" style="width: 150px; z-index: 100px;">
        <a id="lnkUploadPickupdata" style="text-decoration: none; color: #4f4f4f !important;">
            Upload Pickup Data</a>
    </div>

      <div id="divUploadPickUpData">
        
            <div id="ContentPlaceHolder1_divInward" style="display: block;">
    <div class="row">
              <div class="col-md-12">
                <div class="card card-default">
                  <div class="card-body">
                      <div class="row">
                           <div class="col-md-4">
                                <div class="form-group form-group-default form-group-default-select2">
                           <label class="">Fresh Pickup Work Order</label>
                                    <asp:DropDownList ID="ddlWorkorderNumber" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2"  runat="server" OnSelectedIndexChanged="ddlWorkorderNumber_SelectedIndexChanged">
                            </asp:DropDownList>
                                    </div>
                               </div>
                           <div class="col-md-4">
                                <div class="form-group form-group-default">
                           <label class="">Excel File</label>
                               <asp:FileUpload ID="FileUpload_Pickup" runat="server" onchange=" return validateFileUpload();" TabIndex="1" />
                            <asp:Label ID="lblValidationMessage" runat="server" ForeColor="Red"></asp:Label>
                                    </div>
                               </div>
                          <div class="col-md-4">
                              <asp:HyperLink ID="hyExcelsheet" runat="server" NavigateUrl="~/ExcelSheetFormats/Pickup_Format.xlsx" class="btn btn-primary">Download Standard Format Excel File</asp:HyperLink>
                         <br /><asp:Button ID="btnUpload" Text="Upload" OnClick="Upload" runat="server" class="btn btn-primary m-t-5"
                                
                                TabIndex="2" />
                              </div>
                      </div>

                      </div>
                    </div>
                  </div>
        </div>




    
  
                
                  
                            
                            <%-- <asp:Label ID="lblWorkOrder" runat="server"> </asp:Label>--%>
                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlWorkorderNumber"
                                ErrorMessage="Please select Workorder Number." InitialValue="0" ForeColor="Red"
                                ValidationGroup="SavePickupData" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>--%>
                       
                            <%--<asp:Button ID="btnCreateExcel" runat="server" Text="Download Standred Format Excel File"
                                OnClick="btnCreateExcel_Click" />--%>
                            
                   
                   
                    
                            <%--<asp:Button ID="btnUpload" Text="Upload" OnClick="Upload" runat="server" 
                                OnClientClick=" return validateFileUpload();" 
                                TabIndex="2" />--%>
                            
                       
                   
                            <asp:Label ID="lblAddDepartmentMessage" runat="server" ForeColor="Red"></asp:Label><br />
                            <asp:Button ID="btnAddDepartments" runat="server" OnClick="btnAddDepartments_Click" class="btn btn-primary"
                                Text="Add Departments" Visible="False" TabIndex="3" />
                        
                            <asp:GridView Width="400px" ID="grdError" runat="server" AutoGenerateColumns="true"  CssClass="table table-hover table-condense" >

                            </asp:GridView>
                            <%--CssClass="ExcelTable2007-1"--%>
                       
                   
                
            </div>
        
    </div>
    <%-- </div>--%>
    <%--</ContentTemplate>
        </asp:UpdatePanel>--%>
</asp:Content>
