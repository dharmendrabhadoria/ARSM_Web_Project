<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="User_Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <!--[if lte IE 8]>
<script src="style/script/html5.js"></script>
<![endif]-->
    <!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <link href="../styles/style.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Login.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="container">
        <ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
        </ajax:ToolkitScriptManager>
        <section>
    	<div class="login-sect">
        	<div class="logo" style="margin:25px 0;">
            	<%--<a href="#"><img src="../images/prsm-logo.jpg" width="275" height="94"></a>--%>
                <a href="#"><img src="../images/apaar-logo.png" width="275" height="94"></a>
            </div>
            <div class="content">
            <h1>User Login</h1>
                 <div  style="text-align:left; padding-left:30px; padding-top:20px;">
                    <asp:Label runat="server" ID="lblMsg" Font-Size="Medium"  ForeColor="Red"></asp:Label> 
              	</div>
                <ul>
                    <li>
                        <label for="form-login-username">User Name </label>&nbsp;
                        <asp:TextBox ID="txtUserID" runat="server" MaxLength="15" Width="220"  TabIndex="1" ></asp:TextBox>
                        <ajax:FilteredTextBoxExtender ID="FilexttxtUserName" runat="server" TargetControlID="txtUserID"
                        FilterType=" Numbers,UppercaseLetters,LowercaseLetters,Custom" ValidChars="&,', " />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtUserID"
                        ErrorMessage="User name should not be blank." ValidationGroup="SaveGroup" ForeColor="Red" Display="Dynamic" Font-Size ="14px"
                        SetFocusOnError="true"></asp:RequiredFieldValidator>      
                    </li>
    
                    <li>
                        <label for="form-login-password" id="yui_3_2_0pr1_1_1403083442891227">Password</label> &nbsp;
                        <asp:TextBox ID="txtLoginPassword" runat="server" TabIndex="2" 
                            AutoCompleteType="None"  Width="220px" TextMode="Password" MaxLength="15"   ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldPwd" runat="server"  ForeColor="Red" ControlToValidate="txtLoginPassword"
                         SetFocusOnError="true" ErrorMessage="Password should not be blank." ValidationGroup="SaveGroup" Font-Size ="14px"  Display="Dynamic"></asp:RequiredFieldValidator>             
                    </li>
                </ul>
                <div class="buttonAndSpinnerContainer">
                <asp:Button ID="btnLogin" runat="server" Text="Login" 
                 class="btn btn-primary signup-submit" tabindex="4" onclick="btnLogin_Click"  ValidationGroup="SaveGroup"  OnClientClick="return  Validatefields();" ></asp:Button>
               	</div>
   
            </div>
        </div>
    </section>
    </div>
    </form>
</body>
</html>
