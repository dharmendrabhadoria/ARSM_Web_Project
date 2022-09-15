<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddNewBox.aspx.cs" Inherits="Transaction_AddNewBox" CodeBehind="~/Transaction/AddNewBox.aspx.cs"
EnableEventValidation="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server" id="Head1">
<meta http-equiv="X-UA-Compatible" content="IE=8;IE=9;FF=3;OtherUA=4" />
    <base target="_self" />

        <%--<script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
        <script src="../Scripts/1.10.4-jquery-ui.js" type="text/javascript"></script>
        <script src="../Scripts/jquery-ui.js" type="text/javascript"></script>
        <script type="text/javascript" src="../scripts/jquery-1.4.2.min.js"></script>        
        <script type="text/javascript" src="../scripts/jquery-list-attributes.js"></script>
        <script src="../Scripts/jquery.maskedinput-1.3.1.min_.js" type="text/javascript"></script>
        <script src="../Scripts/MakerChecker.js" type="text/javascript"></script>
        <script src="../Scripts/MakerChecker.js" type="text/javascript"></script>
        <script type="text/javascript" src="../scripts/jquery.scrollableFixedHeaderTable.js"></script>

        <link href="../Scripts/jquery-ui.css" rel="stylesheet" type="text/css" />
        <link href="../Styles/scrollableFixedHeaderTable.css" rel="stylesheet" type="text/css" />
        <link href="../Scripts/1.10.4-themes-smoothness-jquery-ui.css" rel="stylesheet" type="text/css" />--%>
         <link href="../Styles/style.css" rel="stylesheet" type="text/css" />

   

</head>
<body>
    <form id="form1" runat="server">
   
    <asp:ScriptManager ID="sm1" runat="server">
    </asp:ScriptManager>
    <div align="center">
     <asp:Panel ID="Panel2" runat="server" GroupingText="Add New Box" Font-Size="Medium" >
     <table runat="server" id="tabAddBox" cellpadding="0" cellspacing="0" align="center" width="92%">                    
                    <tr>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td bgcolor="#80FFFF" style="width: 100%" valign="Top" align="center">
                            <asp:Label ID="Label1" runat="server" Font-Bold="True" Text="New Box Preparation" ForeColor="#FF9900"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td> <br /><br />
                        </td>
                    </tr>                     
                    <tr id="trNewBox" runat="server">
                        <td>

                        <table width="100%" style="border: 2px" border="0">
                        <tr>
                            <td style="width: 25%" align="right">
                              Box BarCode <span style="color: #FF0000">*</span>
                            </td>
                            <td align="left" style="width: 20%">
                                <asp:TextBox ID="txtBoxBarCode" runat="server" Width="150px" MaxLength="16"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="rfvtxtBoxBarCode" runat="server" ControlToValidate="txtBoxBarCode"
                                    ErrorMessage="Please enter Box BarCode." ForeColor="Red" ValidationGroup="SaveGroup"
                                    Display="Dynamic"></asp:RequiredFieldValidator>                                
                            </td>
                            <td style="width: 20%" align="right">
                                Box Location Code
                            </td>

                            <td align="left" >
                           <asp:TextBox ID="txtBoxLocCode" runat="server" Width="150px" MaxLength="16"></asp:TextBox>                                
                            </td>
                        </tr>   
                        <tr>
                        <td colspan="4"> <br />
                        </td>
                    </tr>                         
                        <tr>                            
                            <td  align="center" colspan="4" valign="Top">
                              <asp:Button ID="btnAddBox" runat="server" Text="Save Box" ToolTip="Save Box" onclick="btnAddBox_Click" ValidationGroup="SaveGroup"/><%--OnClientClick=return CheckCarLengthCar();"--%>
                                        <%--&nbsp;&nbsp;<asp:Button ID="btnSaveNext" runat="server" CssClass="btnbg" Text="Save & Next" ToolTip="Save & Next"
                                           Width="91px"/>--%> 
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
