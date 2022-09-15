//Servcie Category page validations

/* Enbale/disable page validation function */
function EnableValidationonPage(IsEnable) {
    for (i = 0; i < Page_Validators.length; i++) {

        ValidatorEnable(Page_Validators[i], IsEnable);
    }

}

/* validation on btnclick */
function Validatefields() {
    var msglbl = $("#lblMsg");
    if (msglbl != null) {
        $('#lblMsg').css('display', 'none')
    }
    EnableValidationonPage(true);
    if (typeof (Page_ClientValidate) == 'function') {
        Page_ClientValidate('SaveGroup');
    }

    if (Page_IsValid) {
        return true;
    }
   
}