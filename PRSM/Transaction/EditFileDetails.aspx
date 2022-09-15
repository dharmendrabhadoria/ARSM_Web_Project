<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditFileDetails.aspx.cs" Inherits="Transaction_EditFileDetails" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server" id="Head1">
    <meta http-equiv="X-UA-Compatible" content="IE=8;IE=9;FF=3;OtherUA=4" />
    <base target="_self" />
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="sm1" runat="server">
    </asp:ScriptManager>
    <div align="center">
     <asp:Panel ID="Panel2" runat="server" GroupingText="Edit File Details" Font-Size="Medium" >

     <table runat="server" id="tabEditFile" cellpadding="0" cellspacing="0" align="center" width="92%">
                    <tr>
                        <td colspan="4">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" bgcolor="#008CF8" style="width: 100%" valign="Top" align="center">
                            <asp:Label ID="Label1" runat="server" Font-Bold="True" Text="Edit File Details"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4"> <br /><br />
                        </td>
                    </tr>                     
                    <tr id="trEditFile" runat="server">
                        <td colspan="4">

                        <table width="100%" style="border: 2px" border="0">
                        <tr>
                            <td style="width: 14%" align="left">
                               Box BarCode
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtBoxBarCode" runat="server" Width="150px" MaxLength="16"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="rfvTxtBoxBarCode" runat="server" 
                                                ControlToValidate="txtBoxBarCode" Display="Dynamic" 
                                                ErrorMessage="Please enter Box BarCode." ForeColor="Red" 
                                                ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>                        
                            </td>
                            <td style="width: 20%" align="left">
                                File BarCode
                            </td>

                            <td align="left">
                           <asp:TextBox ID="txtFileBarCode" runat="server" Width="150px" MaxLength="16"></asp:TextBox>
                                <br />
                               <asp:RequiredFieldValidator ID="rfvTxtFileBarCode" runat="server" 
                                                ControlToValidate="txtFileBarCode" Display="Dynamic" 
                                                ErrorMessage="Please enter File BarCode." ForeColor="Red" 
                                                 ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                            </td>
                        </tr> 
                        <tr>
                            <td style="width: 14%" align="left">
                               File Description1
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtFileDesc1" runat="server" Width="150px" MaxLength="255"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="rfvtxtFileDesc1" runat="server" ControlToValidate="txtFileDesc1"
                                    ErrorMessage="Please enter File Description1." ForeColor="Red" ValidationGroup="SaveGroup"
                                    Display="Dynamic"></asp:RequiredFieldValidator>                                
                            </td>
                            <td style="width: 20%" align="left">
                                File Description2
                            </td>
                            <td align="left">
                           <asp:TextBox ID="txtFileDesc2" runat="server" Width="150px" MaxLength="255"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="rfvtxtFileDesc2" runat="server" ControlToValidate="txtFileDesc2"
                                    ErrorMessage="Please enter File Description2." ForeColor="Red" ValidationGroup="SaveGroup"
                                    Display="Dynamic"></asp:RequiredFieldValidator>    
                            </td>
                        </tr>  
                        <tr>
                            <td style="width: 14%" align="left">
                               Department
                            </td>
                            <td align="left">
                                 <asp:DropDownList ID="ddlDepart" runat="server" Width="155px" MaxLength="100">
                                                </asp:DropDownList>
                                <br />
                                <asp:RequiredFieldValidator ID="rfvDdlDepart" runat="server" 
                                                ControlToValidate="ddlDepart" Display="Dynamic" 
                                                ErrorMessage="Please select Department." ForeColor="Red" InitialValue="0" 
                                                ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>                           
                            </td>
                            <td style="width: 20%" align="left">
                                Year
                            </td>

                            <td align="left">
                           <asp:TextBox ID="txtyear" runat="server" Width="150px" MaxLength="10"> </asp:TextBox>
                                                          <ajax:FilteredTextBoxExtender ID="fltrYearModify" runat="server" FilterType="Numbers,Custom"
                                                        ValidChars="-" TargetControlID="txtyear">
                                                    </ajax:FilteredTextBoxExtender>
                                <br />
                                <asp:RequiredFieldValidator ID="rfvtxtyear" runat="server" ControlToValidate="txtyear"
                                    ErrorMessage="Please select Year." ForeColor="Red" ValidationGroup="SaveGroup"
                                    Display="Dynamic"></asp:RequiredFieldValidator>    
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 14%" align="left">
                                From Date
                            </td>
                            <td align="left">
                                 <asp:TextBox ID="txtFdate" runat="server" Width="150px"   MaxLength="10" ></asp:TextBox> <br />
                                               <asp:RegularExpressionValidator ID="regFromDateModify" runat="server" ValidationGroup="ModifyGroup" ClientIDMode="Predictable"
                                                ErrorMessage="Invalid Date" Tooltip="Please enter date in dd/mm/yyyy format"  ForeColor="Red"   ControlToValidate="txtFdate" Display="Dynamic"  
                                                ValidationExpression="(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[012])/\d{4}"></asp:RegularExpressionValidator> 
                                            
                                            <asp:RequiredFieldValidator ID="rfvtxtFdate" runat="server" 
                                                ControlToValidate="txtFdate" Display="Dynamic" 
                                                ErrorMessage="Please select From Date." ForeColor="Red" 
                                                ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>                        
                            </td>
                            <td style="width: 20%" align="left">
                                To Date
                            </td>
                            <td align="left">
                           <asp:TextBox ID="txtEdate" runat="server" Width="150px" MaxLength="10"  ></asp:TextBox> <br />
                                        <asp:RegularExpressionValidator ID="regEndDateModify" runat="server" ValidationGroup="ModifyGroup" ClientIDMode="Predictable"
                                        ErrorMessage="Invalid Date" Tooltip="Please enter date in dd/mm/yyyy format"  ForeColor="Red"   ControlToValidate="txtEdate" Display="Dynamic"  
                                        ValidationExpression="(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[012])/\d{4}" >
                                        </asp:RegularExpressionValidator>
                                           
                                            <asp:RequiredFieldValidator ID="rfvtxtEdate" runat="server" 
                                                ControlToValidate="txtEdate" Display="Dynamic" 
                                                ErrorMessage="Please select To Date." ForeColor="Red" 
                                                 ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                            </td>

                        </tr> 
                        <tr>
                            <td style="width: 14%" align="left">
                                File Type
                            </td>
                            <td align="left">
                                 <asp:TextBox ID="txtFileType" runat="server" Width="150px" MaxLength="100"></asp:TextBox> <br />
                                               <ajax:FilteredTextBoxExtender ID="fltrLable1Modify" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                                        ValidChars=" -" TargetControlID="txtFileType"/>
                                           
                                            <asp:RequiredFieldValidator ID="rfvtxtFileType" runat="server" 
                                                ControlToValidate="txtFileType" Display="Dynamic" 
                                                ErrorMessage="Please enter File Type." ForeColor="Red" 
                                                ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>                   
                            </td>
                            <td style="width: 20%" align="left">
                                 From Number
                            </td>
                            <td align="left">
                           <asp:TextBox ID="txtFormNum" runat="server" Width="150px" MaxLength="100"></asp:TextBox>
                                              <ajax:FilteredTextBoxExtender ID="fltrLable2Modify" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                                ValidChars=" -" TargetControlID="txtFormNum"/>
                                            <br />
                                            <asp:RequiredFieldValidator ID="rfvtxtFormNum" runat="server" 
                                                ControlToValidate="txtFormNum" Display="Dynamic" 
                                                ErrorMessage="Please enter Form Number." ForeColor="Red" 
                                                ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                         <tr>
                            <td style="width: 14%" align="left">
                                To Number
                            </td>
                            <td align="left">
                                 <asp:TextBox ID="txtToNum" runat="server" Width="150px" MaxLength="100"></asp:TextBox>
                                                 <ajax:FilteredTextBoxExtender ID="fltrLable3Modify" runat="server" FilterType="UppercaseLetters,LowercaseLetters,Numbers,Custom"
                                                        ValidChars=" -" TargetControlID="txtToNum"/>
                                            <br />
                                            <asp:RequiredFieldValidator ID="rfvtxtToNum" runat="server" 
                                                ControlToValidate="txtToNum" Display="Dynamic" 
                                                ErrorMessage="Please enter To Number." ForeColor="Red" 
                                                ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>           
                            </td>
                            <td style="width: 20%" align="left">
                                  Destruction Due Date
                            </td>
                            <td align="left">
                          <asp:TextBox ID="txtDestructionDueDate" runat="server" Width="150px" ValidationGroup="SaveGroup"  ClientIDMode="Predictable"    onkeyup="return changeCells( this, this.id,event);" 
                                                 MaxLength="10"   ></asp:TextBox>   <br />
                                               <asp:RegularExpressionValidator ID="regFromDateModify1" runat="server" ValidationGroup="ModifyGroup" ClientIDMode="Predictable"
                                                ErrorMessage="Invalid Date" Tooltip="Please enter date in dd/mm/yyyy format"  ForeColor="Red"   ControlToValidate="txtDestructionDueDate" Display="Dynamic"  
                                                ValidationExpression="(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[012])/\d{4}"></asp:RegularExpressionValidator>                                            
                                            <asp:RequiredFieldValidator ID="rfvtxtDestructionDueDate" runat="server" 
                                                ControlToValidate="txtDestructionDueDate" Display="Dynamic" 
                                                ErrorMessage="Please select Destruction Due Date." ForeColor="Red" 
                                                ValidationGroup="SaveGroup"></asp:RequiredFieldValidator>
                            </td>
                        </tr>                         
                        <tr>
                        <td colspan="4"> <br />
                        </td>
                    </tr>                         
                        <tr>                            
                            <td  align="center" colspan="4" >
                              <asp:Button ID="btnEditFile" runat="server" Text="Edit File" ToolTip="Edit File Details"/>
                                        &nbsp;&nbsp;                                        
                                        <asp:Button ID="btnClose" runat="server" CssClass="btnbg" Text="Close"
                                            ToolTip="Close Window" Width="91px" OnClientClick="javascript:self.close(); return false;"
                                            CausesValidation="false" />&nbsp;
                            </td>
                            <td>                                
                            </td>
                        </tr>
                    </table>
                    </td>
                        </tr>
                        </table>

     </asp:Panel>
    
    </div>
    </form>
</body>
</html>
