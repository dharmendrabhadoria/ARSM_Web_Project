
function bindevents() {
    $(function () {
        $('#ContentPlaceHolder1_txtFromDateRate').attr('readonly', 'readonly');
        $('#ContentPlaceHolder1_txtEndDateRate').attr('readonly', 'readonly');
        $(".datepicker").datepicker({
            changeMonth: true,
            changeYear: true,
            dateFormat: 'dd-mm-yy',
            yearRange: "-110:+15",
            beforeShow: function () {
                setTimeout(function () {
                    $('.ui-datepicker').css('z-index', 999999);
                }, 0);
            }
        });
    })
}

function EnableValidRateCard(IsEnable) {
    $(document).ready(function () {
        for (i = 0; i < Page_Validators.length; i++) {

            ValidatorEnable(Page_Validators[i], IsEnable);
        }
    });
}

function ClearRateC() {
    EnableValidRateCard(false);
    $('#ContentPlaceHolder1_ddlCompanyGroup').val('0')
    $('#ContentPlaceHolder1_ddlCustomer').val('0')
    document.getElementById("SpnddlCompanyGroup").innerHTML = "";
    document.getElementById("SpnddlCustomer").innerHTML = "";
    if ($("#ContentPlaceHolder1_lblMessage") != null) {
        $("#ContentPlaceHolder1_lblMessage").css('display', 'none')
    }
    return true;
}

function validRateCardOnly() {

    if ($('#ContentPlaceHolder1_ddlCompanyGroup').val() == "0") {
        document.getElementById("SpnddlCompanyGroup").innerHTML = "Please Select Company Group.";
        return false;
    }
    if ($('#ContentPlaceHolder1_ddlCustomer').val() == "0") {
        document.getElementById("SpnddlCustomer").innerHTML = "Please Select Customer.";
        return false;
    }
    EnableValidRateCard(true);
    return true;
}

//function validatetxtbx(Val,evv) {
//    var e = event || evt;
//    var charCode = e.which || e.keyCode;
//    if (!(charCode == 46 || (charCode >= 48 && charCode <= 57))) {
//        alert("Only numeric and dot allowed");
//        return false;
//    }
//    var curchar = String.fromCharCode(charCode);
//    var mainstring = Val.value + curchar;
//    if (mainstring.indexOf('.') > -1) {
//        if (mainstring.split('.').length > 2) {
//            alert("Only one dot allowed");
//            return false;
//        }
//    }
//    var beforeDecimal = mainstring;
//    if (mainstring.indexOf('.') != -1) {
//        beforeDecimal = mainstring.substring(0, mainstring.indexOf('.'));
//    }
//    var afterDecimal = '';
//    if (mainstring.indexOf('.') != -1) {
//        afterDecimal = mainstring.substring(mainstring.indexOf('.') + 1, mainstring.length);
//    }
//    if (beforeDecimal.length > 10) {
//        alert("Maximum 10 digit allowed before decimal");
//        return false;
//    }
//    var Pos = doGetCaretPosition(Val);
//    if (beforeDecimal.length = 10 && Pos < mainstring.indexOf('.')) {
//        alert("Maximum 10 digit allowed before decimal");
//        return false;
//    }
//    if (afterDecimal.length > 2 && Pos > mainstring.indexOf('.')) {
//        alert("Only two decimal places allowed");
//        return false;
//    }
//    return true;
//}

//function doGetCaretPosition(oField) {
//    var iCaretPos = 0;
//    if (document.selection) {
//        oField.focus();
//        var oSel = document.selection.createRange();
//        oSel.moveStart('character', -oField.value.length);
//        iCaretPos = oSel.text.length;
//    }
//    else if (oField.selectionStart || oField.selectionStart == '0')
//        iCaretPos = oField.selectionStart;
//    return (iCaretPos);
//}

//function clearRatefields() {
//     EnableValidateActvRate(false);
//     return true;
//}

