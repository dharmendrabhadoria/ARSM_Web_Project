//Activity page validations
/* Enbale/disable page validation function */
function EnableValidationonPage(IsEnable) {
    $(document).ready(function () {
    for (i = 0; i < Page_Validators.length; i++) {

        ValidatorEnable(Page_Validators[i], IsEnable);
    }
});
}
function clearfields() {
       EnableValidationonPage(false);
        $("#ContentPlaceHolder1_ddlServiceCategory").val("0")
       $('#ContentPlaceHolder1_txtActivityName').val('');
       $('#ContentPlaceHolder1_txtRemark').val('');
       $('#ContentPlaceHolder1_hdneditid').val("1")
       $('#ContentPlaceHolder1_hdnActivityId').val("0");
       if ($("#ContentPlaceHolder1_lblMessage") != null) {
           $("#ContentPlaceHolder1_lblMessage").css('display', 'none')
       }
}
/* validation on btnclick */
function Validatefields() {
    EnableValidationonPage(true);
    if (typeof (Page_ClientValidate) == 'function') {
        Page_ClientValidate('SaveGroup');
    }

    if (Page_IsValid) {
        return true;
    }
    return false;
}
/* Edit activity*/
function EditActivity(Editid) {
    EnableValidationonPage(false);
    var Editbtn = $("#"+Editid)
    var row_index = parseInt(Editbtn.closest('td').parent()[0].sectionRowIndex) - 1;
    var lblName = $("#ContentPlaceHolder1_gdvActivity_lblName_"+row_index);
    var lblRemark = $("#ContentPlaceHolder1_gdvActivity_lblRemark_"+row_index);
    $('#ContentPlaceHolder1_txtActivityName').val(lblName.html());
    $('#ContentPlaceHolder1_txtRemark').val(lblRemark.html());
    var hdneditid     = $("#ContentPlaceHolder1_gdvActivity_hdnEditid_" + row_index);
    var hdnActivityid = $("#ContentPlaceHolder1_gdvActivity_hdnActivityid_" + row_index);
    var hdncategoryId = $("#ContentPlaceHolder1_gdvActivity_hdnCategoryid_" + row_index);
    var hdnUnit = $("#ContentPlaceHolder1_gdvActivity_hdnUnit_" + row_index);
    //alert(hdnUnit.val());
    $('#ContentPlaceHolder1_hdneditid').val(hdneditid.val())
    $('#ContentPlaceHolder1_ddlServiceCategory').val(hdncategoryId.val());
    $('#ContentPlaceHolder1_hdnActivityId').val(hdnActivityid.val());

    if (hdnUnit.val() == 2) {
        $('#ContentPlaceHolder1_rbtnUnit_1').attr('checked', true);
    }
    else if (hdnUnit.val() == 3) {
        $('#ContentPlaceHolder1_rbtnUnit_2').attr('checked', true);
    }
    else if (hdnUnit.val() == 4) {
        $('#ContentPlaceHolder1_rbtnUnit_3').attr('checked', true);
    }
    else {
        $('#ContentPlaceHolder1_rbtnUnit_0').attr('checked', true);
    }


        if ($("#ContentPlaceHolder1_lblMessage") != null) {
            $("#ContentPlaceHolder1_lblMessage").css('display', 'none')
        }
    return false;
}
