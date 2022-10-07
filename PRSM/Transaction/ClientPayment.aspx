<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true"
    CodeFile="ClientPayment.aspx.cs" Inherits="Transaction_ClientPayment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .RubberBandBox
        {
            overflow: hidden;
            padding: 0; /*opacity: .5;*/ /*filter: alpha(opacity=50);*/
            background-color: #666666;
            border: 0px solid #596380;
            z-index: 1000;
            left: 0px;
            top: 0px;
            height: 100%;
            width: 100%;
            position: fixed;
            display: block;
        }
        
        .RubberBandBox img
        {
            left: 50%;
            top: 50%;
            position: absolute;
            height: 30px;
            width: 114px;
            z-index: 5;
        }
    </style>
    <ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </ajax:ToolkitScriptManager>
    <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="0" AssociatedUpdatePanelID="updActivity">
        <ProgressTemplate>
            <div id="divUpdateProgress" class="RubberBandBox">
                <img id="imgLoadingImage" src="../images/loading-animation.gif" alt="Loading....." />
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <asp:UpdatePanel ID="updActivity" runat="server">
        <ContentTemplate>
            <script type="text/javascript">
                function BindDates() {
                    $(function () {
                        $('#ContentPlaceHolder1_txtTransactionDate').attr('readonly', 'readonly');
                        $('#ContentPlaceHolder1_txtChequeDate').attr('readonly', 'readonly');
                        $(".datepicker1").datepicker({
                            changeMonth: true,
                            changeYear: true,
                            dateFormat: 'dd-mm-yy',
                            yearRange: "-110:+15",
                            beforeShow: function () {
                                setTimeout(function () {
                                    $('.ui-datepicker1').css('z-index', 100);
                                }, 0);
                            }
                        });
                    })
                }
                Sys.Application.add_load(BindDates);
            </script>
            <script type="text/javascript">
                //                function FunCalculate() {

                //                    var txt1 = document.getElementById('<%= txtAmount.ClientID%>').value;
                //                    var txt2 = document.getElementById('<%= txt_TDS.ClientID%>').value;
                //                    if (txt1 != '' && txt2 != "")
                //                        document.getElementById('<%= txt_netamt.ClientID%>').value = eval((parseFloat(txt1) - parseFloat(txt2)));
                //                }

                function Substrn() {
                    var text1 = document.getElementById('<%= txtAmount.ClientID %>');
                    var text2 = document.getElementById('<%= txt_TDS.ClientID %>');
                    if (text1.value.length == 0 || text2.value.length == 0) {
                        alert('txtAmount and txt_TDS should not be empty');
                        return;
                    }

                    var x = parseInt(text1.value);
                    var y = parseInt(text2.value);
                    document.getElementById('<%= txt_netamt.ClientID %>').value = x - y;
                }

            </script>
            <script type="text/javascript">

                //                function Calculate() {

                //                    var txt1 = document.getElementById('<%= txt_AmtRec.ClientID%>').value;
                //                    var txt2 = document.getElementById('<%= txt_netamt.ClientID%>').value;
                //                    if (txt1 != '' && txt2 != "")
                //                        document.getElementById('<%= txt_diff.ClientID%>').value = eval((parseFloat(txt1) - parseFloat(txt2)));
                //                }
                function CalDiff() {
                    var text1 = document.getElementById('<%= txt_AmtRec.ClientID %>');
                    var text2 = document.getElementById('<%= txt_netamt.ClientID %>');
                    if (text1.value.length == 0 || text2.value.length == 0) {
                        //                        alert('txt_AmtRec and txt_netamt should not be empty');
                        return;
                    }

                    var x = parseInt(text1.value);
                    var y = parseInt(text2.value);
                    document.getElementById('<%= txt_diff.ClientID %>').value = x - y;
                }
            </script>
            <script type="text/javascript">
                function valNetAmt() {
                    //                    if ((document.getElementById("txt_netamt").value) < 0 || isNaN("txt_netamt"))
                    var iv = parseInt(document.getElementById('ContentPlaceHolder1_txtAmount').value);
                    var td = parseInt(document.getElementById('ContentPlaceHolder1_txt_TDS').value);
                    if (td > iv) {
                        alert("Please insert only positive numbers");
                        return false;
                    }

                }
            </script>
         <%--   <script type="text/javascript">
                function HideDiff() {
                    var x = document.getElementById("ContentPlaceHolder1_lbldiff");
                    if (x) {
                        var y = document.getElementById("ContentPlaceHolder1_txt_diff");
                        if (x.value == 0) target.style.display = 'none';
                        else {
                            y.style.display = 'none';
                        }
                    }
                }
            </script>--%>

               <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Customer Payment Details</li>
            </ol>
            <div class="row">
        <div class="col-md-12 col-lg-12">
             <div class="b-b b-grey m-b-20">
                  <h3 class="m-b-10">Customer Payment Details</h3>
                </div>
            </div>
                </div>


             <div class="row">
              <div class="col-md-12">
                <div class="card card-default">
                  <div class="card-body">
                      <div class="row">
                          <div class="col-md-4">
                              <div class="form-group form-group-default form-group-default-select2">
                           <label class=""> Company Group</label>
                                    <asp:DropDownList ID="ddlCompanyGroup" runat="server" AutoPostBack="true" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2"
                                    OnSelectedIndexChanged="ddlCompanyGroup_SelectedIndexChanged">
                                </asp:DropDownList>
                                  </div>
                             
                                <span id="Span3" style="color: Red;"></span>
                              
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlCompanyGroup"
                                    ErrorMessage="Please select company Group." InitialValue="0" ForeColor="Red"
                                    ValidationGroup="SaveGroup" Display="Dynamic"></asp:RequiredFieldValidator>
                          </div>
                          <div class="col-md-4">
                              <div class="form-group form-group-default form-group-default-select2">
                           <label class="">Customer</label>
                                  <asp:DropDownList ID="ddlCustomer" runat="server" AutoPostBack="true" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2"
                                    OnSelectedIndexChanged="ddlCustomer_SelectedIndexChanged">
                                </asp:DropDownList>
                                  </div>
                               
                                <span id="Span2" style="color: Red;"></span>
                               
                                <span id="SpnddlCustomer" style="color: Red;"></span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="ddlCustomer"
                                    Display="Dynamic" ErrorMessage="Please select customer." InitialValue="0" ForeColor="Red"
                                    ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>

                          </div>
                          <div class="col-md-4">
                              <div class="form-group form-group-default form-group-default-select2">
                           <label class="">Invoice</label>
                                   <asp:DropDownList ID="ddlInvoice" runat="server" AutoPostBack="true" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2"
                                    OnSelectedIndexChanged="ddlInvoice_SelectedIndexChanged">
                                </asp:DropDownList>
                                
                                  </div>
                              <span id="Span1" style="color: Red;"></span>
                               
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlInvoice"
                                    Display="Dynamic" ErrorMessage="Please select Invoice." InitialValue="" ForeColor="Red"
                                    ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                          </div>
                          </div>

                      <div class="row">
                          <div class="col-md-4">
                              <div class="form-group">
                           <label class="">Payment type</label>
                                  <asp:RadioButtonList runat="server" ID="rbtPaymentType" RepeatDirection="Horizontal"
                                    RepeatColumns="3" AutoPostBack="true" OnSelectedIndexChanged="rbtPaymentType_SelectedIndexChanged">
                                </asp:RadioButtonList>
                                   </div>
                                <span id="SpnddlCompanyGroup" style="color: Red;"></span>
                             
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="rbtPaymentType"
                                    Display="Dynamic" ErrorMessage="Please select Payment Type." InitialValue=""
                                    ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                          </div>
                          <div class="col-md-4">
                              <div class="form-group form-group-default">
                           <label class="">Transaction Number</label>
                                  <asp:TextBox ID="txtTransactionNo" runat="server" CssClass="form-control"></asp:TextBox>
                                  </div>
                          </div>
                          <div class="col-md-4">
                                 <div class="form-group form-group-default">
                           <label class="">Transaction Date</label>
                                     <asp:TextBox ID="txtTransactionDate" runat="server" CssClass="datepicker1 form-control" onkeypress="return false;" ></asp:TextBox>
                                     </div>
                          </div>
                      </div>

                      <div class="row">
                          <div class="col-md-4">
                              <div class="form-group form-group-default">
                           <label class="">Client Bank</label>
                                   <asp:TextBox ID="txtBank" runat="server" CssClass="form-control"></asp:TextBox>
                              </div>
                          </div>
                          <div class="col-md-4">
                               <div class="form-group form-group-default">
                           <label class="">Client Branch</label>
                                   <asp:TextBox ID="txtBarnch" runat="server" CssClass="form-control"></asp:TextBox>
                              </div>
                          </div>
                          <div class="col-md-4">
                               <div class="form-group form-group-default">
                           <label class="">Client A/c Number</label>
                                    <asp:TextBox ID="txtAccountNo" runat="server" CssClass="form-control"></asp:TextBox>
                               
                              </div>
                               <asp:RegularExpressionValidator Display="Dynamic" ControlToValidate="txtAccountNo"
                                    ID="RegularExpressionValidator1" ValidationExpression="^[\d]{0,20}$" runat="server"
                                    ErrorMessage="Only Numerics allowed. Maximum 20 characters allowed."></asp:RegularExpressionValidator>
                          </div>
                      </div>

                      <div class="row">
                          <div class="col-md-4">
                               <div class="form-group form-group-default">
                           <label class="">Cheque Number</label>
                                   <asp:TextBox ID="txtChequeNo" runat="server" CssClass="form-control"></asp:TextBox>
                                   </div>
                          </div>
                          <div class="col-md-4">
                               <div class="form-group form-group-default">
                           <label class="">Cheque Date</label>
                                   <asp:TextBox ID="txtChequeDate" runat="server" CssClass="datepicker1 form-control" onkeypress="return false;"></asp:TextBox>
                                   </div>
                          </div>
                          <div class="col-md-4">
                               <div class="form-group form-group-default">
                           <label class="">Invoice Amount</label>
                                   <asp:TextBox ID="txtAmount" runat="server" Enabled="false" CssClass="form-control" onblur="Substrn()"></asp:TextBox>
                                
                                   </div>
                              <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtAmount"
                                    Display="Dynamic" ErrorMessage="Please Enter Transaction Amount." InitialValue=""
                                    ForeColor="Red" ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                          </div>
                      </div>



                       <%--  <asp:TextBox ID="txtAmount" runat="server" Enabled="false" onkeyup="FunCalculate()"></asp:TextBox>--%>

                      <div class="row">
                          <div class="col-md-3">
                              <div class="form-group form-group-default">
                           <label class="">TDS</label>
                                  <asp:TextBox ID="txt_TDS" runat="server" MaxLength="200" onblur="Substrn()" CssClass="form-control"></asp:TextBox>
                                    
                                  </div>
                              <asp:RegularExpressionValidator ID="RegularExpValTDS" runat="server" ControlToValidate="txt_TDS"
                                        Display="Dynamic" ErrorMessage="Only Numerics allowed" ValidationExpression="^[\d]{0,20}$"></asp:RegularExpressionValidator>
                          </div>
                          <div class="col-md-3">
                               <div class="form-group form-group-default">
                           <label class="">Net Amount</label>
                                   <asp:TextBox ID="txt_netamt" runat="server" onblur="CalDiff()" CssClass="form-control"></asp:TextBox>
                                  </div>
                          </div>
                          <div class="col-md-3">
                               <div class="form-group form-group-default">
                           <label class="">Amount Received</label>
                                    <asp:TextBox ID="txt_AmtRec" runat="server" onblur="CalDiff()" CssClass="form-control"></asp:TextBox>
                                  </div>
                          </div>
                          <div class="col-md-3">
                               <div class="form-group form-group-default">
                          
                                   <asp:Label ID="lbldiff" runat="server" Text="Difference" ></asp:Label>
                                   <asp:TextBox ID="txt_diff" runat="server"  CssClass="form-control"></asp:TextBox>
                                  </div>
                          </div>
                      </div>

                      <div class="row">
                          <div class="col-md-4">
                               <div class="form-group form-group-default form-group-default-select2">
                           <label class="">Status</label>
                                   <asp:DropDownList ID="ddlStatus" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged" CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2"
                                        >
                                    </asp:DropDownList>
                                   </div>
                          </div>
                          <div class="col-md-4">
                              <div class="form-group form-group-default">
                           <label class="">Reason if Cheque Bounced</label>
                                   <asp:TextBox ID="txtBouncedreason" runat="server" MaxLength="200" TextMode="MultiLine"  CssClass="form-control"></asp:TextBox>
                                   </div>
                          </div>
                          <div class="col-md-4">
                              <div class="form-group form-group-default">
                           <label class="">Remarks</label>
                                  <asp:TextBox ID="txtRemarks" runat="server" MaxLength="500" TextMode="MultiLine"  CssClass="form-control"></asp:TextBox>
                                   </div>
                          </div>
                      </div>

                      <div class="row">
                          <div class="col-md-12">

                              <asp:Button ID="btnSave" runat="server" CausesValidation="true" OnClick="btnSave_Click" type="button" CssClass="btn btn-primary"
                                        Text="Save" ValidationGroup="SaveGroup" OnClientClick=" return valNetAmt();" />
                                    <asp:Button ID="btnReset" runat="server" OnClick="btnReset_Click" Text="Clear" type="button" CssClass="btn btn-primary" />
                          </div>
                      </div>


                      </div>
                    </div>
                  </div>
                 </div>
           

             <%-- <asp:TextBox ID="txt_TDS" runat="server" MaxLength="200" onkeyup="FunCalculate()"></asp:TextBox>--%>
             <%--  <asp:TextBox ID="txt_netamt" runat="server" onkeyup="Calculate()"></asp:TextBox>--%>
             <%--        <asp:TextBox ID="txt_AmtRec" runat="server" onkeyup="Calculate()"></asp:TextBox>--%>

            <div class="middle">
               
                    
               
                <div class="frmbox">
                    <table width="100%" style="border: 2px" border="0">
                       
                        
                        
                        
                        <caption>
                            =
                            
                            
                            <tr>
                                <td align="center" colspan="6">
                                    
                                </td>
                            </tr>
                        </caption>
                    </table>
                    
                                <asp:GridView ID="gvAccountMaster" runat="server" AutoGenerateColumns="False" AllowPaging="true"
                                    PageSize="20" border="0" CssClass="table table-hover table-condense" GridLines="None" OnRowCommand="gvAccountMaster_RowCommand"
                                    OnPageIndexChanging="gvAccountMaster_PageIndexChanging">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Sr No." ItemStyle-Width="7%">
                                            <ItemTemplate>
                                                <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1  %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="n_InvoiceNo" HeaderText="Invoice No">
                                            <ItemStyle Width="10%"></ItemStyle>
                                            <HeaderStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="s_CustomerName" HeaderText="Customer Name">
                                            <ItemStyle Width="10%"></ItemStyle>
                                            <HeaderStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="PaymentType" HeaderText="Payment Type">
                                            <ItemStyle Width="10%"></ItemStyle>
                                            <HeaderStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="s_TransactionNumber" HeaderText="Transaction Number">
                                            <ItemStyle Width="10%"></ItemStyle>
                                            <HeaderStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="d_TransactionDate" HeaderText="Transaction Date">
                                            <ItemStyle Width="10%"></ItemStyle>
                                            <HeaderStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="s_ClientBank" HeaderText="Client Bank">
                                            <ItemStyle Width="10%"></ItemStyle>
                                            <HeaderStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="s_ClientBranch" HeaderText="Client Branch">
                                            <ItemStyle Width="10%"></ItemStyle>
                                            <HeaderStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="n_ClientAccountNo" HeaderText="Client A/c Number">
                                            <ItemStyle Width="10%"></ItemStyle>
                                            <HeaderStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="n_ChequeNumber" HeaderText="Cheque Number">
                                            <ItemStyle Width="10%"></ItemStyle>
                                            <HeaderStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="d_ChequeDate" HeaderText="Cheque Date">
                                            <ItemStyle Width="10%"></ItemStyle>
                                            <HeaderStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="n_TransactionAmount" HeaderText="Transaction Amount">
                                            <ItemStyle Width="10%"></ItemStyle>
                                            <HeaderStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="n_TDS" HeaderText="TDS Amount">
                                            <ItemStyle Width="10%"></ItemStyle>
                                            <HeaderStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="n_AmtReceived" HeaderText="Amount Received">
                                            <ItemStyle Width="10%"></ItemStyle>
                                            <HeaderStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="PaymentStatus" HeaderText="Status">
                                            <ItemStyle Width="10%"></ItemStyle>
                                            <HeaderStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="s_ReasonChequeBounced" HeaderText="Reason list if Cheque Bounced">
                                            <ItemStyle Width="10%"></ItemStyle>
                                            <HeaderStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="s_Remarks" HeaderText="Remarks">
                                            <ItemStyle Width="10%"></ItemStyle>
                                            <HeaderStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkbtnEdit" runat="server" Text="Edit" CommandArgument='<%# Eval("n_AccountId") + ";" +Eval("n_CustomerId")+ ";" +Eval("PaymentTypeID")+ ";" +Eval("PaymentStatusId")+";"+Eval("n_CompanyGroupId") %>'
                                                    CommandName="EdtUser"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle HorizontalAlign="Left" BorderWidth="0" />
                                    <AlternatingRowStyle CssClass="AlternativeRowStyle" />
                                </asp:GridView>
                           
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
