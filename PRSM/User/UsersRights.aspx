<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PRSM.master" AutoEventWireup="true"
    CodeFile="UsersRights.aspx.cs" Inherits="Users_UsersRights" MaintainScrollPositionOnPostback="true"   %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript" language="javascript"   >
    function SelectAllCheckboxesA(chk) {
       // alert(chk);
        $('#<%=grdPageaccess.ClientID %>').find('input[Id*="chkRowise"]:checkbox').each(function() {
            if (this != chk) {
                this.checked = chk.checked;
            }
        });
        $('#<%=grdPageaccess.ClientID %>').find('input[Id*="chkIsEnable"]:checkbox').each(function() {
            if (this != chk) {
                this.checked = chk.checked;
            }
        });
    }

    function SelectAllRowise(chk)
     {
        var obj = chk;
        var objId = "#"+obj.getAttribute('id')
        var objId = objId.replace('chkRowise', 'dtlistfunctionality');
       // alert(objId);
        $(objId).find('input[Id*="chkIsEnable"]:checkbox').each(function() {
            if (this != chk) {
                this.checked = chk.checked;
            }
        });
        GridviewCheck();
    }
    // Disable row check if at leaset one uncheck for that row
    function disablechk(id, strrowiseid)
     {
       // alert(strrowiseid);
        var dlistid = '';
        dlistid = id
        var Dlist = document.getElementById(dlistid);
        // alert(Dlist);
        var chkRowwise = document.getElementById(strrowiseid);
        if (Dlist != null)
         {
            var Inputs;
            Inputs = Dlist.getElementsByTagName("input");
            var Ischecked = true;
         //   alert(Inputs.length);
            for (var n = 0; n < Inputs.length; ++n)
             {
                if (Inputs[n].type == 'checkbox') 
                {
                    if (!Inputs[n].checked) 
                    {
                        Ischecked = false;
                    }
                }
            }
            if (chkRowwise != null)
             {
                 chkRowwise.checked = Ischecked;
             }
             GridviewCheck();
             
        }
    }
    //Grid view disable all if at leaset one uncheck
    function GridviewCheck()
     {
         var Ischecked = true;
         $('#<%=grdPageaccess.ClientID %> :input').each(function() {

         if ($(this).attr('type') == "checkbox") 
             {
                 var chkid = $(this).attr('id');
                 if ('ctl00_ContentPlaceHolder1_grdPageaccess_ctl01_chkAll' != chkid)
                  {
                     var chkRowiseid = document.getElementById(chkid)
                     //alert(chkRowiseid);
                     //alert(chkRowiseid.checked);
                     if (!chkRowiseid.checked) 
                     {
                         Ischecked = false;
                     }
                 }
             }

         });
         var SelectAllCheck = document.getElementById('ctl00_ContentPlaceHolder1_grdPageaccess_ctl01_chkAll');
          //alert(Ischecked);
         if (SelectAllCheck != null) 
         {
             SelectAllCheck.checked = Ischecked;
         }
     }
     function IsRoleSelected() {
         mydropdown = $('#ddlRole');
         if (mydropdown.length == 0 || $(mydropdown).val() == "") {
             alert("Please Select Any Role ");
             return false;
             return;
         }
         else {
             return true;
         }

     }
     function IsAnyChecked() {
       
         var Ischecked = false;       
         $('#<%=grdPageaccess.ClientID %> :input').each(function () {
             if ($(this).attr('type') == "checkbox") {
                 var chkid = $(this).attr('id');
                 if ('ctl00_ContentPlaceHolder1_grdPageaccess_ctl01_chkAll' != chkid) {
                     var chkRowiseid = document.getElementById(chkid);
                     if (chkRowiseid.checked) {
                         Ischecked = true;
                         return true;
                     }
                 }
             }

         });
         var ErrorMsg = "\t Following fields are mandatory! \n "
         var ValResult = true;

         var ddlval = $('#ContentPlaceHolder1_ddlRole').val();
         if (ddlval == "0" || ddlval == "--Select--") {
             ErrorMsg += " \t\t Role \n \t\t";
             ValResult = false;         
         }
         if (!Ischecked) {
             ErrorMsg += "Activity \n \t\t";
             ValResult = false;            
         }
         if (ValResult == false) {
             alert(ErrorMsg);
             return false;
         } 
     }
</script>
<style type="text/css"  >
.comgrid1
{
	width:100%;
}
.comgrid1 tr:nth-child(odd) th
{
	background-image:url(../images/nav-bg-rx.jpg);background-repeat:repeat-x;
  	padding:7px 5px !important;
	border: 0px dashed #DBDBDB;
	font-size:13px;	
	color:#595959;
}
.comgrid1 tr:hover:nth-child(even) td
{
	background-color:#fbf8d9;
	
	color:#2f6490;
	
}
.comgrid1 tr:hover:nth-child(odd) td
{
	background-color:#fbf8d9;

	color:#2f6490;
	
}
.comgrid1 tr:hover:nth-child(even) td
{
	background-color:#fbf8d9;
	
	color:#2f6490;
	
}
.tabltdfix td{width:180px !important;}
</style>

    <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Assign User Page Access Rights</li>
            </ol>
    <div class="row">
        <div class="col-md-12 col-lg-12">
             <div class="b-b b-grey m-b-20">
                  <h3 class="m-b-10">Assign User Page Access Rights</h3>
                </div>

            </div>
        </div>

      <div class="row">
              <div class="col-md-12">
                <div class="card card-default">
                  <div class="card-body">
                      <div class="row">
                           <div class="col-md-12">
                                  <div class="form-group form-group-default form-group-default-select2">
                           <label class="">Role</label>
                                       <asp:DropDownList ID="ddlRole" runat="server" AutoPostBack="True"   CssClass="form-group form-group-default form-group-default-select2 required" data-init-plugin="select2"
                        onselectedindexchanged="ddlRole_SelectedIndexChanged"  >
                    </asp:DropDownList>

                                      </div>
                                <asp:RequiredFieldValidator ID="reqddlddlRole" runat="server"  SetFocusOnError="true" ControlToValidate="ddlRole" ErrorMessage="Please Select Role."  Display="Dynamic" ValidationGroup="Save" InitialValue="0"    ></asp:RequiredFieldValidator>  
                               </div>

                          

                        </div>
                      </div>
                    </div>
                  </div>
          </div>


    
   
       
        <asp:GridView ID="grdPageaccess" runat="server" AutoGenerateColumns="false" 
            Width="100%" onrowdatabound="grdPageaccess_RowDataBound" CssClass="table table-hover table-condense"   GridLines="None" BorderWidth="0"     >
            <Columns>
            <asp:TemplateField HeaderText="Page Name" ItemStyle-Width="170"  >
           <ItemTemplate>
               <asp:Label ID="lblPageName" runat="server" Text='<%# Eval("AppCodeName") %>'></asp:Label>
               <asp:HiddenField runat="server" ID="hdnPageId" Value='<%# Eval("AppCodeId") %>'   />
           </ItemTemplate>
          
<ItemStyle Width="170px"></ItemStyle>
          
            </asp:TemplateField>
            <asp:TemplateField  ItemStyle-Width="170"   >
           <ItemTemplate >
                 <asp:CheckBox runat="server" ID="chkRowise" onclick="javascript:SelectAllRowise(this);" ToolTip="Check" /> 
           </ItemTemplate>

<ItemStyle Width="170px"></ItemStyle>
<HeaderTemplate  >
           <asp:CheckBox runat="server" ID="chkAll" Text=" All" onclick="javascript:SelectAllCheckboxesA(this);" ToolTip="Check"  /> 
           </HeaderTemplate>
           <HeaderStyle HorizontalAlign="Left"   />
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Apply rights"  >
           <ItemTemplate >
               <asp:DataList runat="server" ID="dtlistfunctionality" RepeatColumns="4" 
                   RepeatDirection="Horizontal"  BorderWidth="0" 
                   style="empty-cells:hide;border-width:0px;   " 
                   onitemdatabound="dtlistfunctionality_ItemDataBound" 
                   onitemcreated="dtlistfunctionality_ItemCreated" CssClass="tabltdfix">
             <ItemTemplate>
            <asp:HiddenField runat="server" ID="hdnPageFunctionId" Value='<%# Eval("PageFunctionId") %>'   />
            <asp:CheckBox runat="server" ID="chkIsEnable" Checked='<%# Eval("IsEnableForRole") %>' ToolTip="Check"  /> 
            <asp:Label ID="lblFuncationality" runat="server" Text='<%# Eval("Functionality") %>'></asp:Label> &nbsp;  &nbsp; 
           
             </ItemTemplate>
             <ItemStyle Width="200"  HorizontalAlign="Left"   />
             </asp:DataList>
           </ItemTemplate>
            
            </asp:TemplateField>
            </Columns>
              <HeaderStyle  HorizontalAlign="Left" BorderWidth="0"    />
        </asp:GridView>
   
        <asp:Button ID="btnSave" runat="server" Text="Save"  OnClientClick="return IsAnyChecked();"
            onclick="btnSave_Click" ValidationGroup="Save"  />
   
   
</asp:Content>
