$(function () {
    $('#ContentPlaceHolder1_txtdob').attr('readonly', 'readonly');
    $(".datepicker").datepicker({
        maxDate: '0',
        changeMonth: true,
        changeYear: true,
        dateFormat: 'dd-mm-yy',
        yearRange: "-110:+0",
        beforeShow: function () {
            setTimeout(function () {
                $('.ui-datepicker').css('z-index', 9999);
            }, 0);
        }
    });
});
/* Enbale/disable page validation function */
function EnableValidationonPage(IsEnable) {
    for (i = 0; i < Page_Validators.length; i++) {

        ValidatorEnable(Page_Validators[i], IsEnable);
    }

}

function ClientValidatePwd(source, clientside_arguments) {

    //Test whether the length of the value is more than 6 characters
    if (clientside_arguments.Value.length >= 6) {
        clientside_arguments.IsValid = true;
    }
    else { clientside_arguments.IsValid = false };
}



/* validation on btnclick */
function Validatefields() {
    EnableValidationonPage(true);
    if ($("#ContentPlaceHolder1_lblMessage") != null) {
        $("#ContentPlaceHolder1_lblMessage").css('display', 'none')
    }
    if (typeof (Page_ClientValidate) == 'function') {
        Page_ClientValidate('SaveGroup');
    }

    if (Page_IsValid) {
        return true;
    }
    else
    return false;
}

/*---- Clear field function */
function clearfields() {

    $("#ContentPlaceHolder1_txtFname").val('')
    $("#ContentPlaceHolder1_txtMname").val('')
    $("#ContentPlaceHolder1_txtLname").val('')
    $("#ContentPlaceHolder1_txtUserName").val('')
    $("#ContentPlaceHolder1_txtUserName").removeAttr("disabled"); 
    $("#ContentPlaceHolder1_txtdob").val('')
    $("#ContentPlaceHolder1_txtEmailId").val('')
    $("#ContentPlaceHolder1_txtPwd").val('')
    $("#ContentPlaceHolder1_txtRenPassword").val('')
    $("#ContentPlaceHolder1_ddlDepartment").val('0')
    $("#ContentPlaceHolder1_ddlRole").val('0')
    if ($("#ContentPlaceHolder1_lblMessage") != null) {
        $("#ContentPlaceHolder1_lblMessage").css('display', 'none')
    }
    if ($("#ContentPlaceHolder1_lblDate") != null) {
        $("#ContentPlaceHolder1_lblDate").css('display', 'none')
    }
    EnableValidationonPage(false);
    return false;
}
