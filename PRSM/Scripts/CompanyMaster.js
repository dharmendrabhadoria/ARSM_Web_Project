//Company Master Validation
function EnableValidationonPage(IsEnable) {
    $(document).ready(function () {
        for (i = 0; i < Page_Validators.length; i++) {

            ValidatorEnable(Page_Validators[i], IsEnable);
        }
    });
}
function EnableCustomerCM(IsEnable) {
    $(document).ready(function () {
        for (i = 0; i < Page_Validators.length; i++) {

            ValidatorEnable(Page_Validators[i], IsEnable);
        }
    });
}
function Validatefields() {
    EnableCustomerCM(true);
    EnablePickGroupValidationonPage(false);
    EnableCustomerVaildation(false);
    return true;
}
function clearfields1() {
    EnableValidationonPage(false);
    if ($("#ContentPlaceHolder1_lblMessage") != null) {
        $("#ContentPlaceHolder1_lblMessage").css('display', 'none')
    }
    if ($("#ContentPlaceHolder1_lblCompanyGroupMsg") != null) {
        $("#ContentPlaceHolder1_lblCompanyGroupMsg").css('display', 'none')
    }
    $('#ContentPlaceHolder1_txtGroupName').val('')
    $('#ContentPlaceHolder1_ddlindustry').val(0)
    $('#ContentPlaceHolder1_txtPANNo').val('')
    $('#ContentPlaceHolder1_txtTAN').val('')
    $('#ContentPlaceHolder1_txtregisteraddress').val('')
    $('#ContentPlaceHolder1_txtContactPerson').val('')
    $('#ContentPlaceHolder1_txtPhoneNumber').val('')
    //    document.getElementById("SpnInvalidPhoneNo").innerHTML = '';
    $('#ContentPlaceHolder1_txtEmail').val('')
    $('#ContentPlaceHolder1_txtContactPerson1').val('')
    $('#ContentPlaceHolder1_txtPhoneNumber1').val('')
    //    document.getElementById("SpnInvalidPhoneNo1").innerHTML = '';
    $('#ContentPlaceHolder1_txtEmail1').val('')
    return true;
}
function ValidatePhoneNumber(source, args) {
    var number = $("#ContentPlaceHolder1_txtPhoneNumber").val();
    var Zerovalid = number / 1;
    if (Zerovalid == '0') {
        args.IsValid = false;
    }
    else {
        args.IsValid = true;
    }
}
function ValidateFaxNumber(source, args) {
    var number = $("#ContentPlaceHolder1_txtFax").val();
    var Zerovalid = number / 1;
    if (Zerovalid == '0') {
        args.IsValid = false;
    }
    else {
        args.IsValid = true;
    }
}
function ValidatePhoneNumber1(source, args) {
    var number = $("#ContentPlaceHolder1_txtPhoneNumber1").val();
    var Zerovalid = number / 1;
    if (Zerovalid == '0') {
        args.IsValid = false;
    }
    else {
        args.IsValid = true;
    }
}
function ValidateCorpFaxNumber(source, args) {
    var number = $("#ContentPlaceHolder1_txtcorporatefax").val();
    var Zerovalid = number / 1;
    if (Zerovalid == '0') {
        args.IsValid = false;
    }
    else {
        args.IsValid = true;
    }
}


