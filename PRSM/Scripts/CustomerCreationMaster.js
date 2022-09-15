
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

    $("#ContentPlaceHolder1_txtCustFullName").val('')
    $("#ContentPlaceHolder1_txtCustUserName").val('')
    $("#ContentPlaceHolder1_txtCustUserName").removeAttr("disabled");
    $("#ContentPlaceHolder1_txtCustEmail").val('')
    $("#ContentPlaceHolder1_txtPwd").val('')
    $("#ContentPlaceHolder1_ddlCompanyGroup").val('0')
    $("#ContentPlaceHolder1_lstCustomer").val('0')
    if ($("#ContentPlaceHolder1_lblMessage") != null) {
        $("#ContentPlaceHolder1_lblMessage").css('display', 'none')
    }
  
    EnableValidationonPage(false);
    return false;
}
