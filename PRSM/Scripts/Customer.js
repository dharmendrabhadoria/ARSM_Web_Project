

function EnableValidRateCardOnCSt(IsEnable) {
    $(document).ready(function () {
        for (i = 0; i < Page_Validators.length; i++) {

            ValidatorEnable(Page_Validators[i], IsEnable);
        }
    });
}


function ValidCustomerSaveRateAcivity() {
    EnableValidRateCardOnCSt(true);
    return true;
}



function EnablePickGroupValidationonPage(IsEnable) {   
    for (i = 0; i < Page_Validators.length; i++) {
        switch (Page_Validators[i].validationGroup) {
            case "SavePickGroup":
                ValidatorEnable(Page_Validators[i], IsEnable);               
                break;
            default:
                // your javascript code
                break;
        }
    }
}
function EnableCustomerVaildation(IsEnable) {
    for (i = 0; i < Page_Validators.length; i++) {
        switch (Page_Validators[i].validationGroup) {
            case "SaveGroupC":               
                ValidatorEnable(Page_Validators[i], IsEnable);
                break;
            default:
                // your javascript code
                break;
        }
    }
}


function GetSelectCity(Cityid) {
    var City = $('#' + Cityid);
    $("#ContentPlaceHolder1_hdnddlSelectedcity").val(City.val());
}

    function upperletterTan1(obj) {
        $("#ContentPlaceHolder1_txtTAN").val(obj.toUpperCase());
    }

    function Validatepickupaddressfields() {       
    EnablePickGroupValidationonPage(true);
    validatePhone1();
    Validatecdata();   
    return true;
    }
   
   

function SaveCustomerValid() {
    //alert($.trim($("#ContentPlaceHolder1_selectedValue").val()));
    if ($.trim($("#ContentPlaceHolder1_selectedValue").val()) == "" || $('#ContentPlaceHolder1_txtNameofthegroup').val() == "") {
        alert('Please Enter Group Name.');
        return false;
    }
    return true;
}

function ClearSaveCustomer() {
    $("#ContentPlaceHolder1_txtCustomerName").val("");
   // $("#ContentPlaceHolder1_txtNameofthegroup").val("");
    $("#ContentPlaceHolder1_ddlbillingState").val("0");
    $("#ContentPlaceHolder1_ddlbillingCity").val("0");
}

function clearCustomerSavefields() {

    EnablePickGroupValidationonPage(false);
    EnableValidationonPage(false);
    EnableCustomerVaildation(false);
    $("#ContentPlaceHolder1_txtregisteraddress").val('');
    $("#ContentPlaceHolder1_txtCustomerName").val('');
    //$("#ContentPlaceHolder1_txtNameofthegroup").val('');
    $("#ContentPlaceHolder1_ddlbillingState").val("0");
    $("#ContentPlaceHolder1_txtpickupaddress").val('0');
    $("#ContentPlaceHolder1_ddlDepartment").val('0');
    $("#ContentPlaceHolder1_ddlpickupstate").val('0');
    $("#ContentPlaceHolder1_ddlpickupcity").val('0');
    $("#ContentPlaceHolder1_txtpickupaddress").val('');
    $("#ContentPlaceHolder1_txtAuthoName").val('');
    $("#ContentPlaceHolder1_txtAuthoPhone").val('');
    $("#ContentPlaceHolder1_txtAuthoEmail").val('');
    $("#ContentPlaceHolder1_txtAuthoName1").val('');
    $("#ContentPlaceHolder1_txtAuthoPhone1").val('');
    $("#ContentPlaceHolder1_txtAuthoEmail1").val('');
    $("#ContentPlaceHolder1_txtAddress").val('');
    $("#ContentPlaceHolder1_txtPANNo").val('');
    $("#ContentPlaceHolder1_txtGroupName").val('');
    $("#ContentPlaceHolder1_txtTAN").val('');
    $("#ContentPlaceHolder1_ddlindustry").val('0');
    $("#ContentPlaceHolder1_txtContactPerson").val('');
    $("#ContentPlaceHolder1_txtPhoneNumber").val('');
    $("#ContentPlaceHolder1_txtEmail").val('');
    $("#ContentPlaceHolder1_txtContactPerson1").val('');
    $("#ContentPlaceHolder1_txtPhoneNumber1").val('');
    $("#ContentPlaceHolder1_txtEmail1").val('');
    $("#ContentPlaceHolder1_ddlState").val('0');
    $("#ContentPlaceHolder1_ddlCity").val('0');
    $("SpnInvalidPhoneNoF").html('');
    $("SpnInvalidPhoneNoS").html('');
    $("SpanMobile11").html('');
    $("spnPhone11").html('');
    $("spnContactPerson11").html('');
    $("SpanEmail11").html('');
    return true;
}

function editpickup(editid) {
    // alert(editid);
    EnablePickGroupValidationonPage(false);
    EnableValidationonPage(false);
    var Editbtn = $("#"+editid)
    var row_index = parseInt(Editbtn.closest('td').parent()[0].sectionRowIndex) - 1;
    var lblAddress = $("#ContentPlaceHolder1_gdvCustomerpickup_lblAddress_" + row_index);
    var hdnStateId = $("#ContentPlaceHolder1_gdvCustomerpickup_hdnStateId_" + row_index);
    var hdnCityId = $("#ContentPlaceHolder1_gdvCustomerpickup_hdnCityId_" + row_index);
    //var hdnDepartment = $("#ContentPlaceHolder1_gdvCustomerpickup_hdnDepartment_" + row_index);
    var lblPhoneNo = $("#ContentPlaceHolder1_gdvCustomerpickup_lblPhoneNo_" + row_index);
    var lblAuthorisedPerson = $("#ContentPlaceHolder1_gdvCustomerpickup_lblAuthorisedPerson_" + row_index);
    var lblEmail = $("#ContentPlaceHolder1_gdvCustomerpickup_lblEmail_" + row_index);
    var lblPhoneNo1 = $("#ContentPlaceHolder1_gdvCustomerpickup_lblPhoneNo1_" + row_index);
    var lblAuthorisedPerson1 = $("#ContentPlaceHolder1_gdvCustomerpickup_lblAuthorisedPerson1_" + row_index);
    var lblEmail1 = $("#ContentPlaceHolder1_gdvCustomerpickup_lblEmail1_" + row_index);
    $("#ContentPlaceHolder1_txtpickupaddress").text(lblAddress.text());
    $("#ContentPlaceHolder1_txtAuthoName").val(lblAuthorisedPerson.html());
    $("#ContentPlaceHolder1_txtAuthoPhone").val(lblPhoneNo.html());
    $("#ContentPlaceHolder1_txtAuthoEmail").val(lblEmail.html());
    $("#ContentPlaceHolder1_txtAuthoName1").val(lblAuthorisedPerson1.html());
    $("#ContentPlaceHolder1_txtAuthoPhone1").val(lblPhoneNo1.html());
    $("#ContentPlaceHolder1_txtAuthoEmail1").val(lblEmail1.html());
    return true;
}

$(function () {
    $("[id*=ContentPlaceHolder1_txtNameofthegroup]").autocomplete({
        source: function (request, response) {
            $.ajax({
                url: 'Customer.aspx/GetCompany',
                data: "{ 'prefix': '" + request.term + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d.length > 0) {
                        // alert(data.d);
                        response($.map(data.d, function (item) {
                            return {

                                label: item.label,
                                val: item.value

                            };
                            $('#ContentPlaceHolder1_selectedValue').val(item.value);
                        }))
                    } else {
                        //alert('no found');
                        response([{ label: 'No results found.', val: -1}]);
                        $('#ContentPlaceHolder1_txtNameofthegroup').val('');
                    }
                }
            });
        },
        select: function (e, u) {
            if (u.item.val == -1) {
                return false;
            }
            else {
                $('#ContentPlaceHolder1_selectedValue').val(u.item.val);
            }
        }
    });
});

$(document).ready(function () {
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);

    function EndRequestHandler(sender, args) {
        $("[id*=ContentPlaceHolder1_txtNameofthegroup]").autocomplete({
            source: function (request, response) {
                $.ajax({
                    url: 'Customer.aspx/GetCompany',
                    data: "{ 'prefix': '" + request.term + "'}",
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d.length > 0) {
                            // alert(data.d);
                            response($.map(data.d, function (item) {
                                return {

                                    label: item.label,
                                    val: item.value

                                };
                                $('#ContentPlaceHolder1_selectedValue').val(item.value);
                            }))
                        } else {
                            //alert('no found');
                            response([{ label: 'No results found.', val: -1}]);
                            $('#ContentPlaceHolder1_txtNameofthegroup').val('');
                        }
                    }
                });
            },
            select: function (e, u) {
                if (u.item.val == -1) {
                    return false;
                }
                else {
                    $('#ContentPlaceHolder1_selectedValue').val(u.item.val);
                }
            }
        });
    }
});

function BindEvents() {
    $(document).ready(function () {
        $("[id*=ContentPlaceHolder1_txtNameofthegroup]").autocomplete({
            source: function (request, response) {
                $.ajax({
                    url: 'Customer.aspx/GetCompany',
                    data: "{ 'prefix': '" + request.term + "'}",
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d.length > 0) {
                            // alert(data.d);
                            response($.map(data.d, function (item) {
                                return {

                                    label: item.label,
                                    val: item.value

                                };
                                $('#ContentPlaceHolder1_selectedValue').val(item.value);
                            }))
                        } else {
                            //alert('no found');
                            response([{ label: 'No results found.', val: -1}]);
                            $('#ContentPlaceHolder1_txtNameofthegroup').val('');
                        }
                    }
                });
            },
            select: function (e, u) {
                if (u.item.val == -1) {
                    return false;
                }
                else {
                    $('#ContentPlaceHolder1_selectedValue').val(u.item.val);
                }
            }
        });
        });
}

function autocompDrop(txtid) {
    var txtCompanygroup = $("#" + txtid);
   // alert(txtCompanygroup.val().trim());
    if (txtCompanygroup.val() != '') {
        $.ajax({
            url: 'Customer.aspx/GetCompany',
            data: "{ 'prefix': '" + txtCompanygroup.val() + "'}",
            dataType: "json",
            type: "POST",
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                if (data.d.length > 0) {
                     //alert(data.d);

                    response($.map(data.d, function (item) {
                        return {
                        
                            label: item.label,
                            val: item.value
                        };
                      
                    }))
                } else {
//                    alert('no found');
                    response([{ label: 'No results found.', val: -1}]);
                    $('#ContentPlaceHolder1_txtNameofthegroup').val('');
                }
            },
            select:function (e, u) {
                if (u.item.val == -1) {
               
                    return false;
                }
                else {
                    $('#ContentPlaceHolder1_selectedValue').val(u.item.val);
                }
            }
        });
    }
}

function ShowdivCompanyGroup() {
     $('#divCustomerGroup').show();
     $("#blocker").show();
 }

function HidedivCompanyGroup() {
    $('#divCustomerGroup').hide();
    $("#blocker").hide();
    clearCustomerSavefields();
    
    return false;
}

function ShowdivActivityRate() {

    $('#divActivityRate').show();
    $("#divActivityRate").attr('style', 'display:block;z-index: 100;');
    $("#blocker").attr('style', 'display:block;');
    $("#ui-datepicker-div").css("z-index", "10000")
    $("#blocker").show();
  //  ValidationGroup = "ValRateGroup"
    for (i = 0; i < Page_Validators.length; i++) {
        switch (Page_Validators[i].validationGroup) {
            case "ValRateGroup":
                ValidatorEnable(Page_Validators[i], false);
                break;
            default:
                // your javascript code
                break;
        }
    }
}

function HidedivActivityRate() {

    $("#blocker").attr('style', 'display:none');
    $('#divActivityRate').hide();
    $("#blocker").hide();
    return false;
}

function upperletter(obj) {
    $("#ContentPlaceHolder1_txtPANNo").val(obj.toUpperCase());
}


function BindGroupEvents() {
    $(document).ready(function () {
        $("[id*=ContentPlaceHolder1_txtSeach]").autocomplete({
            source: function (request, response) {
                $.ajax({
                    url: 'Customer.aspx/GetCustomerOnSameGrpName',
                    data: "{ 'prefix': '" + request.term + "'}",
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d.length > 0) {
                            response($.map(data.d, function (item) {
                                return {

                                    label: item.label,
                                    val: item.value
                                };
                                $('#ContentPlaceHolder1_hdnSearcheCustId').val(item.value);
                            }))
                        } else {
                            response([{ label: 'No results found.', val: -1}]);
                            $('#GetCustomerOnSameGrpName').val('');
                        }
                    }
                });
            },
            select: function (e, u) {
                if (u.item.val == -1) {
                    return false;
                }
                else {
                    $('#ContentPlaceHolder1_hdnSearcheCustId').val(u.item.val);
                    
                }
            }
        });
    });
}

function divShowhideSaveMsg() {
    $("#blocker").show();
    $("#blocker").attr('style', 'display:block');
    $("#divSaveMsg").fadeIn('slow').delay(2000).fadeOut(1000, function () {
        $("#blocker").attr('style', 'display:none');
        $("#blocker").hide();
        var url = '../Master/Customer.aspx';
        $(location).attr('href', url);
    });
} 

function ValidatePhonePick1(source, args) {
    var number = $("#ContentPlaceHolder1_txtAuthoPhone").val();
    var Zerovalid1 = number/1;
    if (Zerovalid1 == '0') {
        args.IsValid = false;
    }
    else {
        args.IsValid = true;
    }
}

function ValidatePhonePick2(source, args) {
    var number = $("#ContentPlaceHolder1_txtAuthoPhone1").val();
    var Zerovalid2 = number/1;
    if (Zerovalid2 == '0') {
        args.IsValid = false;
    }
    else {
        args.IsValid = true;
    }
}


function ValidateMobilePick1(source, args) {
    var number = $("#ContentPlaceHolder1_txtMobileNo").val();
    var Zerovalid1 = number / 1;
    if (Zerovalid1 == '0') {
        args.IsValid = false;
    }
    else {
        args.IsValid = true;
    }
}

function ValidateMobilePick2(source, args) {
    var number = $("#ContentPlaceHolder1_txtMobileNo1").val();
    var Zerovalid2 = number / 1;
    if (Zerovalid2 == '0') {
        args.IsValid = false;
    }
    else {
        args.IsValid = true;
    }
}



function ValidatePhoneNumberOnCG(source, args) {
    var number = $("#ContentPlaceHolder1_txtPhoneNumber").val();
    var Zerovalid3 = number/1;
    if (Zerovalid3 == '0') {
        args.IsValid = false;
    }
    else {
        args.IsValid = true;
    }
}

function ValidateCustomerPinCode(source, args) {
    var number = $("#ContentPlaceHolder1_txtCustomerPinCode").val();
    var Zerovalid3 = number / 1;
    if (Zerovalid3 == '0') {
        args.IsValid = false;
    }
    else {
        args.IsValid = true;
    }
}

function ValidatePickUpPinCode(source, args) {
    var number = $("#ContentPlaceHolder1_txtPickUpPincode").val();
    var Zerovalid3 = number / 1;
    if (Zerovalid3 == '0') {
        args.IsValid = false;
    }
    else {
        args.IsValid = true;
    }
}


function ValidateCorpPinCodeOnPopup(source, args) {
    var number = $("#ContentPlaceHolder1_txtcorporatepincode").val();
    var Zerovalid3 = number / 1;
    if (Zerovalid3 == '0') {
        args.IsValid = false;
    }
    else {
        args.IsValid = true;
    }
}
function ValidateRegPinCodeOnPopup(source, args) {
    var number = $("#ContentPlaceHolder1_txtpincode").val();
    var Zerovalid3 = number / 1;
    if (Zerovalid3 == '0') {
        args.IsValid = false;
    }
    else {
        args.IsValid = true;
    }
}

function ValidatePhoneNumberOnPopup(source, args) {
    var number = $("#ContentPlaceHolder1_txtPhoneNumber1").val();
    var Zerovalid3 = number / 1;
    if (Zerovalid3 == '0') {
        args.IsValid = false;
    }
    else {
        args.IsValid = true;
    }
}
function ValidateCompanyfields() {
    EnableValidationonPage(true);
    if (typeof (Page_ClientValidate) == 'function') {
        Page_ClientValidate('SaveCompanyGroup');
    }

    if (Page_IsValid) {
        return true;
    }
    return false;
}
function EnableValidationonPage(IsEnable) {
    $(document).ready(function () {
        for (i = 0; i < Page_Validators.length; i++) {

            ValidatorEnable(Page_Validators[i], IsEnable);
        }
    });
}
function Validatecdata(source, args) {

    var txtcp = $('#ContentPlaceHolder1_txtAuthoName1');
    var txtpn = $('#ContentPlaceHolder1_txtAuthoPhone1');
    var txtmn = $('#ContentPlaceHolder1_txtMobileNo1');
    var txtemail = $('#ContentPlaceHolder1_txtAuthoEmail1');
    var spncp = $('#spnContactPerson1');
    var spnphone = $('#spnPhone1');
    var spnmobile = $('#SpanMobile1');
    var spnemail = $('#SpanEmail1');
    spncp.html('');
    spnphone.html('');
    spnmobile.html('');
    spnemail.html('');

    if (txtcp.val().length > 0 && txtpn.val().length > 0 && txtmn.val().length > 0 && txtemail.val().length > 0) {
        args.IsValid = true;
    }
    else if (txtcp.val().length == 0 && txtpn.val().length == 0 && txtmn.val().length == 0 && txtemail.val().length == 0) {
        args.IsValid = true;
    }

    else {
        var ValResult = false;
        if (txtcp.val().length == 0) {
            spncp.html('Please Enter Name.');
            spncp.css('color', 'red');         
            ValResult = false;
        }
        if (txtpn.val().length == 0) {
            spnphone.html('Please Enter Phone Number.');
            spnphone.css('color', 'red');
            ValResult = false;
        }
        if (txtmn.val().length == 0) {
            spnmobile.html('Please Enter Mobile Number.');
            spnmobile.css('color', 'red');
            ValResult = false;
        }
        if (txtemail.val().length == 0) {
            spnemail.html('Please Enter Email.');
            spnemail.css('color', 'red');
            ValResult = false;
        }
        if (ValResult == false) {
            args.IsValid = false;           
        }
    }
}

function ClearAll(obj) {

    var NameId = $("#" + obj);
    var spncp = $('#spnContactPerson1');
    var spnphone = $('#spnPhone1');
    var spnmobile = $('#SpanMobile1');
    var spnemail = $('#SpanEmail1');
    if (NameId.val() == '') {
        spncp.html('');
        spnphone.html('');
        spnmobile.html('');
        spnemail.html('');
    }
}
