//Company Gropup page validations

/* Enbale/disable page validation function */
function EnableValidationonPage(IsEnable) {
    $(document).ready(function () {
        for (i = 0; i < Page_Validators.length; i++) {

            ValidatorEnable(Page_Validators[i], IsEnable);
        }
    });
}

function Hide() {
    if ($("#ContentPlaceHolder1_lblMessage") != null) {
        $("#ContentPlaceHolder1_lblMessage").css('display', 'none')
    }
}
function EnableCustomerCG(IsEnable) {
    $(document).ready(function () {
        for (i = 0; i < Page_Validators.length; i++) {

            ValidatorEnable(Page_Validators[i], IsEnable);
        }
    });
}
function clearfields() {
    EnableCustomerCG(false); 
    EnablePickGroupValidationonPage(false);
    EnableCustomerVaildation(false);
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
    $('#ContentPlaceHolder1_txtpincode').val('')
    $('#ContentPlaceHolder1_txtMobileNumber').val('')
    $('#ContentPlaceHolder1_txtmobilenumber1').val('')
    $('#ContentPlaceHolder1_txtcorporateaddress').val('')
    $('#ContentPlaceHolder1_ddlcorporatestate').val(0)
    $('#ContentPlaceHolder1_ddlpickupstate').val(0)
    $('# ContentPlaceHolder1_ddlcorporatecity').val(0)   
    document.getElementById("SpnInvalidPhoneNoCS").innerHTML = '';
    $('#ContentPlaceHolder1_txtEmail').val('')
    $('#ContentPlaceHolder1_txtContactPerson1').val('')
    $('#ContentPlaceHolder1_txtPhoneNumber1').val('')
    document.getElementById("SpnInvalidPhoneNoCF").innerHTML = '';
    $('#ContentPlaceHolder1_txtEmail1').val('')
    return true;
}
/* validation on btnclick */
function Validatefields() {
    EnableCustomerCG(true);
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

/* validation on btnclick */

function ValidateMobileNumber(source, args) {
    var number = $("#ContentPlaceHolder1_txtMobileNumber").val();
    var Zerovalid = number / 1;
    if (Zerovalid == '0') {
        args.IsValid = false;
    }
    else {
        args.IsValid = true;
    }
}
function ValidateMobileNumber1(source, args) {
    var number = $("#ContentPlaceHolder1_txtmobilenumber1").val();
    var Zerovalid = number / 1;
    if (Zerovalid == '0') {
        args.IsValid = false;
    }
    else {
        args.IsValid = true;
    }
}

function ValidatePhoneNumber(source, args) {
    var number = $("#ContentPlaceHolder1_txtPhoneNumber").val();
    var Zerovalid = number/1;
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

function PopulateCity() {
$(document).ready(function () {
  //  alert($('#ContentPlaceHolder1_ddlState').val())
    if ($('#ContentPlaceHolder1_ddlState').val() == "0") {
        $("#ContentPlaceHolder1_ddlCity").html('');
        $("#ContentPlaceHolder1_ddlCity").append("<option value='0'>--Select-- </option>");
    }
    else {
        $("#ContentPlaceHolder1_ddlState").prop("disabled", true);
        $("#ContentPlaceHolder1_ddlCity").prop("disabled", true);
        SearchCity();
        $("#ContentPlaceHolder1_ddlCity").html('');
        $("#ContentPlaceHolder1_ddlCity").append("<option value='0'>--Select-- </option>");
    }
});
}

function SearchCity() {
$(document).ready(function () {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "CompanyGroup.aspx/GetAutoCompleteData",
        data: "{'StateId':'" + $('#ContentPlaceHolder1_ddlState').val() + "'}",
        dataType: "json",
        success: function (data) {
            var arrCity = data.d;
            var strcity = JSON.stringify(arrCity);
            var newArrCity = JSON.parse(strcity);
            var options = '';
            for (var i = 0; i < newArrCity.length; i++) {
                $("#ContentPlaceHolder1_ddlCity").append("<option value=" + newArrCity[i].CityId + ">" + newArrCity[i].CityName + " </option>")
            }
            $("#ContentPlaceHolder1_ddlCity").prop("disabled", false);
            $("#ContentPlaceHolder1_ddlState").prop("disabled", false);

        },
        error: function (result) {
            alert("Error");
        }
    });
});
}

function upperletter(obj) {
    $("#ContentPlaceHolder1_txtPANNo").val(obj.toUpperCase());
}
function upperletterTan(obj) {
    $("#ContentPlaceHolder1_txtTAN").val(obj.toUpperCase());
}

function Validatedata(source, args) {
    var txtcp = $('#ContentPlaceHolder1_txtContactPerson1');
    var txtpn = $('#ContentPlaceHolder1_txtPhoneNumber1');
    var txtmn = $('#ContentPlaceHolder1_txtmobilenumber1');
    var txtemail = $('#ContentPlaceHolder1_txtEmail1');
    var spncp = $('#spnContactPerson1');
    var spnphone = $('#spnPhone1');
    var spnmobile = $('#SpanMobile1');
    var spnemail = $('#SpanEmail1');
    spncp.html('');
    spnphone.html('');
    spnmobile.html('');
    spnemail.html('');
    
   
    var ValResult = true;   
    if (txtcp.val().length > 0 && txtpn.val().length > 0 && txtmn.val().length > 0 && txtemail.val().length > 0) {           
        args.IsValid = true;
    }
    else if (txtcp.val().length == 0 && txtpn.val().length == 0 && txtmn.val().length == 0 && txtemail.val().length == 0) {
        args.IsValid = true;
    }
    else {
        if (txtcp.val().length == 0) {           
            spncp.html('Please Enter Contact Person Name.');
            $(spncp).css('color', 'red');            
            ValResult = false;
        }
       
        if (txtpn.val().length == 0) {            
            spnphone.html('Please Enter Phone Number.');
            $(spnphone).css('color', 'red');            
            ValResult = false;           
        }
         if (txtmn.val().length == 0) {            
             spnmobile.html('Please Enter Mobile Number.');
             $(spnmobile).css('color', 'red');            
             ValResult = false;             
        }
         if (txtemail.val().length == 0) {            
             spnemail.html('Please Enter Email.');
             $(spnemail).css('color', 'red');                
             ValResult = false;            
        }
        if (ValResult == false) {
            args.IsValid = false;
        }       
       
    }
}
function Validatedatac(source, args) {
    var txtcp = $('#ContentPlaceHolder1_txtContactPerson1');
    var txtpn = $('#ContentPlaceHolder1_txtPhoneNumber1');
    var txtmn = $('#ContentPlaceHolder1_txtmobilenumber1');
    var txtemail = $('#ContentPlaceHolder1_txtEmail1');
    var spncp = $('#spnContactPerson11');
    var spnphone = $('#spnPhone11');
    var spnmobile = $('#SpanMobile11');
    var spnemail = $('#SpanEmail11');
    spncp.html('');
    spnphone.html('');
    spnmobile.html('');
    spnemail.html('');
    var ValResult = true;   
    if (txtcp.val().length > 0 && txtpn.val().length > 0 && txtmn.val().length > 0 && txtemail.val().length > 0) {
        args.IsValid = true;
    }
    else if (txtcp.val().length == 0 && txtpn.val().length == 0 && txtmn.val().length == 0 && txtemail.val().length == 0) {
        args.IsValid = true;
    }
    else {
        if (txtcp.val().length == 0) {
            spncp.html('Please Enter Contact Person Name.');
            $(spncp).css('color', 'red');           
            ValResult = false;
        }
        if (txtpn.val().length == 0) {
            spnphone.html('Please Enter Phone Number.');
            $(spnphone).css('color', 'red');           
            ValResult = false;
        }
       
        if (txtmn.val().length == 0) {
            spnmobile.html('Please Enter Mobile Number.');
            $(spnmobile).css('color', 'red');          
            ValResult = false;
        }
       
        if (txtemail.val().length == 0) {
            spnemail.html('Please Enter Email.');
            $(spnemail).css('color', 'red');
           
            ValResult = false;
        }

        if (ValResult == false) {           
            args.IsValid = false;
        }

    }
}
function ValidateCorpPinCode(source, args) {
    var number = $("#ContentPlaceHolder1_txtcorporatepincode").val();
    var Zerovalid3 = number / 1;
    if (Zerovalid3 == '0') {
        args.IsValid = false;
    }
    else {
        args.IsValid = true;
    }
}
function ValidateRegPinCode(source, args) {
    var number = $("#ContentPlaceHolder1_txtpincode").val();
    var Zerovalid3 = number / 1;
    if (Zerovalid3 == '0') {
        args.IsValid = false;
    }
    else {
        args.IsValid = true;
    }
}

function ClearOtherFields() {
    var txtcp = $('#ContentPlaceHolder1_txtContactPerson1');
    var txtpn = $('#ContentPlaceHolder1_txtPhoneNumber1');
    var txtmn = $('#ContentPlaceHolder1_txtmobilenumber1');
    var txtemail = $('#ContentPlaceHolder1_txtEmail1');
    var spncp = $('#spnContactPerson1');
    var spnphone = $('#spnPhone1');   
    var spnmobile = $('#SpanMobile1');
    var spnemail = $('#SpanEmail1');
    if (txtcp.val().length == 0 || txtcp.val()=="") {
        alert('inside textbox');
        spncp.html('');
        spnphone.html('');
        spnmobile.html('');
        spnemail.html('');
        return false;       
    }
    else if (txtpn.val().length == 0 || txtpn.val() =="") {
        spncp.html('');
        spnphone.html('');
        spnmobile.html('');
        spnemail.html('');
        return false;         
    }
    else if (txtmn.val().length == 0 || txtmn.val =="") {
        spncp.html('');
        spnphone.html('');
        spnmobile.html('');
        spnemail.html('');
        return false;       
    }
    else if (txtemail.val().length == 0 || txtemail.length =="" ) {
        spncp.html('');
        spnphone.html('');
        spnmobile.html('');
        spnemail.html('');
        return false;        
    }
    else {
        return true;               
    }
    

}


