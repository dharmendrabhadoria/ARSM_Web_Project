function bindevents() {
    $(function () {
        $(".datepicker").datepicker({
            changeMonth: true,
            changeYear: true,
            dateFormat: 'dd-mm-yy',
            yearRange: "-110:+10",
            beforeShow: function () {
                setTimeout(function () {
                    $('.ui-datepicker').css('z-index', 9999);
                }, 0);
            }
        });
    });
}

$('#txtpickupAddress').click(function () {
    alert('AAAAAAAAAAAAA')
    $('#divPickUpAddress').show();

});
function checkLumsumAmount(chkid) {
    var id = '';
    id = chkid;
    //$('#' + id + ':checkbox').prop('checked')
    //alert(id);
    //document.getElementById(id)
    //    alert(document.getElementById(id));
    alert(document.getElementById(id).checked);
    //    alert('#' + chkid + ':checkbox');


    if (document.getElementById(id).checked) {
        alert("Checkbox is checked.");
    }
    else {
        alert("Checkbox is unchecked.");
    }
}

function Validatefields() {

    //alert('A');

    var ErrorMsg = "Following fields are mandatory! \n "
    var ValResult = true;
    //  alert('AA');
    if ($("#ContentPlaceHolder1_ddlWareHouse").val() == "0") {
        ErrorMsg += "\t \t WareHouse \n \t\t";
        ValResult = false;

    }

    if ($("#ContentPlaceHolder1_ddlCompanyGroup").val() == "0") {
        ErrorMsg += "CompanyGroup \n \t\t";
        ValResult = false;

    }

    if ($("#ContentPlaceHolder1_ddlCustomer").val() == "0") {
        ErrorMsg += "Customer \n \t\t ";
        ValResult = false;
    }

    if ($("#ContentPlaceHolder1_ddlPickupaddress").val() == "0") {
        ErrorMsg += "Pick-Up Address \n \t\t ";
        ValResult = false;
    }

    if ($("#ContentPlaceHolder1_hdnTotalAddedActivity").val() == "0") {
        ErrorMsg += "Please add activity \n \t\t ";
        ValResult = false;

    }
    if (ValResult == false) {
        alert(ErrorMsg);
        return false;
    }
    else {

        var agree = confirm("Are you sure you want to continue?");
        if (agree) {
            return true;
        }
        else {
            return false;
        }



    }
    return false;

}

function divShowWodetails() {

    $('#divShowWodetails').show();
    $("#blocker").attr('style', 'display:block');
    $("#divShowWodetails").attr('style', 'display:block');
}

function divHideWodetails() {

    $('#divShowWodetails').hide();
    $("#divShowWodetails").attr('style', 'display:none');
    $("#blocker").attr('style', 'display:none');
}
function clearSearchfields() {
    $('#ContentPlaceHolder1_ddlSearchCG').val('0')
    $('#ContentPlaceHolder1_ddlSearchCGCustomer').val('0')
    $('#ContentPlaceHolder1_ddlSearchStatus').val('0')
    $('#ContentPlaceHolder1_txtSearchFromDate').val('')
    $('#ContentPlaceHolder1_txtSearchToDate').val('')
    $('#ContentPlaceHolder1_ddlRetrivalActivity').val('0')
    $('#ContentPlaceHolder1_txtBoxBarCode').val('')
    $('#ContentPlaceHolder1_txtFileBarCode').val('')
    return true;
}

function valdSearchWOrder() {
    var ErrorMsg = ""
    var ValResult = true;
    var FromDate = $("#ContentPlaceHolder1_txtSearchFromDate");
    var Enddate = $("#ContentPlaceHolder1_txtSearchToDate");
    if (FromDate.val() != '') {
        if (Enddate.val() == '') {
            ErrorMsg += "End Date \n \t\t ";
            ValResult = false;
        }
        var str1 = FromDate.val();
        var str2 = Enddate.val();
        var dt1 = parseInt(str1.substring(0, 2), 10);
        var mon1 = parseInt(str1.substring(3, 5), 10);
        var yr1 = parseInt(str1.substring(6, 10), 10);
        var dt2 = parseInt(str2.substring(0, 2), 10);
        var mon2 = parseInt(str2.substring(3, 5), 10);
        var yr2 = parseInt(str2.substring(6, 10), 10);
        var date1 = new Date(yr1, mon1 - 1, dt1);
        var date2 = new Date(yr2, mon2 - 1, dt2);
        var IsExist = 0;
        if (date1 == date2) {
            alert("1");
            IsExist = 1;
            ValResult = true;
        }
        if (date1 > date2 && IsExist != 1) {
            ErrorMsg += 'End Date should be greater than From Date.'
            ValResult = false;

        }
    }
    if (ErrorMsg == '') {
        ValResult = true;
    }
    if (ValResult == false) {
        alert(ErrorMsg);
        return false;
    }
    else {
        return true;
    }
}

function Validatefields() {
    var ErrorMsg = "Following fields are mandatory! \n "
    var ValResult = true;
    if ($("#ContentPlaceHolder1_ddlWareHouse").val() == "0") {
        ErrorMsg += "\t \t WareHouse \n \t\t";
        ValResult = false;
    }

    if ($("#ContentPlaceHolder1_ddlCompanyGroup").val() == "0") {
        ErrorMsg += "CompanyGroup \n \t\t";
        ValResult = false;
    }

    if ($("#ContentPlaceHolder1_ddlCustomer").val() == "0") {
        ErrorMsg += "Customer \n \t\t ";
        ValResult = false;
    }

    if ($("#ContentPlaceHolder1_ddlPickupaddress").val() == "0") {
        ErrorMsg += "Pick-Up Address \n \t\t ";
        ValResult = false;
    }

    if ($("#ContentPlaceHolder1_hdnTotalAddedActivity").val() == "0") {
        ErrorMsg += "Please add activity \n \t\t ";
        ValResult = false;
    }
    if (ValResult == false) {
        alert(ErrorMsg);
        return false;
    }
    else {

        var agree = confirm("Are you sure you want to continue?");
        if (agree) {
            return true;
        }
        else {
            return false;
        }
    }
    return false;

}
function PrintDiv() {

    var divToPrint = document.getElementById('PrintdivShowWodetails');
    $("[id^='lbldivremark']").css("overflow", "none")
    $("[id^='lbldivremark']").css("height", "auto")
    $("#PrintdivShowWodetails").css("overflow", "auto")
    $("#printdiv").css("display", "none")

    $("#printdiv").html($("#PrintdivShowWodetails").html());
    var popupWin = window.open('', '_blank', 'width=1000,height=auto');
    popupWin.document.open();
    popupWin.document.write('<html><body >' + $("#printdiv").html() + '</html>');
    popupWin.document.close();
    $("#printdiv").html('')
    popupWin.print();
}

function VFilePickUpAddress() {
    alert('1');
    var Result = true;
    var ddlFilePickUpAddress = $("#ContentPlaceHolder1_ddlFilePickUpAddress option:selected").text();
    $("[id^='ContentPlaceHolder1_grdFilePickUpAddress_lblPickUpAddress_']").each(function () {
        var GridMatchpickupaddress = $(this).html();
        if (GridMatchpickupaddress == ddlFilePickUpAddress) {
            alert('Duplicate file pickup address found.');
            Result = false;
        }
    });
    return Result;
}

function ValidateRetrievalBoxFile() {
    var ErrorMsg = "Following fields are mandatory! \n "
    var ValResult = true;
    var FileActivity = $("#ContentPlaceHolder1_ddlRetrivalActivity option:selected").text();

    if ($("#ContentPlaceHolder1_ddlWareHouse").val() == "0") {
        ErrorMsg += "\t \t WareHouse \n \t\t";
        ValResult = false;
    }
    if ($("#ContentPlaceHolder1_ddlCompanyGroup").val() == "0") {
        ErrorMsg += "CompanyGroup \n \t\t";
        ValResult = false;
    }
    if ($("#ContentPlaceHolder1_ddlCustomer").val() == "0") {
        ErrorMsg += "Customer \n \t\t ";
        ValResult = false;
    }
    if ($("#ContentPlaceHolder1_ddlRetrievalPickUpAddress").val() == "0") {
        ErrorMsg += "Pick-Up Address \n \t\t ";
        ValResult = false;
    }
    if ($("#ContentPlaceHolder1_ddlRetrivalActivity").val() == "0") {
        ErrorMsg += "Retrieval Activity\n \t\t ";
        ValResult = false;
    }

    if ($("#ContentPlaceHolder1_txtBoxBarCode").val() == '') {
        ErrorMsg += "Please select Box Bar Code \n \t\t";
        ValResult = false;
    }
    if (FileActivity.substring(0, 4).toString() == 'File') {
        if ($("#ContentPlaceHolder1_txtFileBarCode").val() == '') {
            ErrorMsg += "Please select File Bar Code \n \t\t";
            ValResult = false;
        }
    }
    if (ValResult == false) {
        alert(ErrorMsg);
        return false;
    }
    else {
        var result = GetRetrivalBoxAndFileBarCode();
        if (result == false)
            return false;
        else
            return true;
    }
}
function GetRetrivalBoxAndFileBarCode() {
    var Result = true;
    var CheckFlag = 0;
    var txtBoxBarCode = $("#ContentPlaceHolder1_txtBoxBarCode");
    var txtFileBarCode = $("#ContentPlaceHolder1_txtFileBarCode");

    $("[id^='ContentPlaceHolder1_grdRetrivalActivity_lblBoxBarCode_']").each(function () {

        var GridMatchBoxBarCode = $(this).html();
        if (txtBoxBarCode.val() == GridMatchBoxBarCode && txtFileBarCode.val() == '' && CheckFlag == 0) {
            CheckFlag = 1;
            alert('Duplicate Box BarCode Found.');
            Result = false;
        }

    });

    if (txtFileBarCode.val() != '') {
        $("[id^='ContentPlaceHolder1_grdRetrivalActivity_lblFileBarCode_']").each(function () {
            var GridMatchBoxBarCode = $(this).html();
            if (txtFileBarCode.val() == GridMatchBoxBarCode && txtFileBarCode.val() != '') {
                alert('Duplicate File BarCode Found.');
                Result = false;
            }
        });
    }
    return Result;
}

function ValidatePermanentBoxFile() {

    var ErrorMsg = "Following fields are mandatory! \n "
    var ValResult = true;
    if ($("#ContentPlaceHolder1_ddlWareHouse").val() == "0") {
        ErrorMsg += "\t \t WareHouse \n \t\t";
        ValResult = false;
    }
    if ($("#ContentPlaceHolder1_ddlCompanyGroup").val() == "0") {
        ErrorMsg += "CompanyGroup \n \t\t";
        ValResult = false;
    }

    if ($("#ContentPlaceHolder1_ddlCustomer").val() == "0") {
        ErrorMsg += "Customer \n \t\t ";
        ValResult = false;
    }

    if ($("#ContentPlaceHolder1_ddlPermanentActivity").val() == "0") {
        ErrorMsg += "Permanent Activity\n \t\t ";
        ValResult = false;
    }
    if ($("#ContentPlaceHolder1_txtPermBoxBarCode").val() == '') {
        ErrorMsg += "Please select Box Bar Code \n \t\t";
        ValResult = false;
    }
    if ($("#ContentPlaceHolder1_txtPermFileBarCode").val() == '') {
        ErrorMsg += "Please select File Bar Code \n \t\t";
        ValResult = false;
    }

    if (ValResult == false) {
        alert(ErrorMsg);
        return false;
    }
    else {
        var result = GetPermannetBxFile();
        if (result == false)
            return false;
        else
            return true;
    }
}
function GetPermannetBxFile() {
    var Result = true;
    var countMiscell = 0;
    var txtBoxBarCode = $("#ContentPlaceHolder1_txtPermBoxBarCode");
    var txtFileBarCode = $("#ContentPlaceHolder1_txtPermFileBarCode");
    var ddlActivity = $("#ContentPlaceHolder1_ddlPermanentActivity option:selected").text();
    var LenGrid = $("[id^='ContentPlaceHolder1_gridPermanentActivity_lblFileBarCode_']").length;
    if (LenGrid > 0) {
        for (var i = 0; i < LenGrid; i++) {
            var ActivtyName = $('#ContentPlaceHolder1_gridPermanentActivity_lblName_' + i).html();
            var BoxBarCode = $('#ContentPlaceHolder1_gridPermanentActivity_lblBoxBarCode_' + i).html();
            var FileBarCode = $('#ContentPlaceHolder1_gridPermanentActivity_lblFileBarCode_' + i).html();
            if ((txtFileBarCode.val() == FileBarCode) && (txtBoxBarCode.val() == BoxBarCode) && (ddlActivity == ActivtyName)) {
                alert('Duplicate Activity Name  Found.');
                Result = false;
            }
        }
    }
    return Result;
}

function ValidateDestructionBoxFile() {

    var ErrorMsg = "Following fields are mandatory! \n "
    var ValResult = true;

    if ($("#ContentPlaceHolder1_ddlWareHouse").val() == "0") {
        ErrorMsg += "\t \t WareHouse \n \t\t";
        ValResult = false;
    }
    if ($("#ContentPlaceHolder1_ddlCompanyGroup").val() == "0") {
        ErrorMsg += "CompanyGroup \n \t\t";
        ValResult = false;
    }
    if ($("#ContentPlaceHolder1_ddlCustomer").val() == "0") {
        ErrorMsg += "Customer \n \t\t ";
        ValResult = false;
    }

    if ($("#ContentPlaceHolder1_ddlDestructionActivity").val() == "0") {
        ErrorMsg += "Destruction Activity\n \t\t ";
        ValResult = false;
    }
    if ($("#ContentPlaceHolder1_txtDestructionBoxBarCode").val() == '') {
        ErrorMsg += "Please select Box Bar Code \n \t\t";
        ValResult = false;
    }
    if ($("#ContentPlaceHolder1_txtDestructionFileBarCode").val() == '') {
        ErrorMsg += "Please select File Bar Code \n \t\t";
        ValResult = false;
    }

    if ($("#ContentPlaceHolder1_ddlDestructionActivity").val() == "19" || $("#ContentPlaceHolder1_ddlDestructionActivity").val() == "18") {
        if ($("#ContentPlaceHolder1_txtDestructionFileCount").val() == '' || $("#ContentPlaceHolder1_txtDestructionFileCount").val() == 0) {
            ErrorMsg += "Please enter file count greater than zero. \n \t\t";
            ValResult = false;
        }
    }

    if (ValResult == false) {
        alert(ErrorMsg);
        return false;
    }
    else {
        var result = GetDestructionBoxAndFileBarCode();
        if (result == false)
            return false;
        else
            return true;
    }
}
function GetDestructionBoxAndFileBarCode() {
    var Result = true;
    var countMiscell = 0;
    var txtBoxBarCode = $("#ContentPlaceHolder1_txtDestructionBoxBarCode");
    var txtFileBarCode = $("#ContentPlaceHolder1_txtDestructionFileBarCode");
    var ddlActivity = $("#ContentPlaceHolder1_ddlDestructionActivity option:selected").text();
    if (ddlActivity != 'destruction of file') {
        $("[id^='ContentPlaceHolder1_GridDestructionActivity_lblName_']").each(function () {
            var CurrntActivityName = $(this).html();
            if (CurrntActivityName == ddlActivity && countMiscell == 0) {
                countMiscell += 1;
                alert('Duplicate Activity File Count Found.');
                Result = false;
            }
            else
                Result = true;

        });
    }
    $("[id^='ContentPlaceHolder1_GridDestructionActivity_lblFileBarCode_']").each(function () {
        var GridMatchBoxBarCode = $(this).html();
        if (txtFileBarCode.val() == GridMatchBoxBarCode && txtFileBarCode.val() != '') {
            alert('Duplicate File BarCode Found.');
            Result = false;
        }
    });

    return Result;
}

///////////////////////////////////////////// For New Work Order AutoCompletes////////////////////////////////

function BindBoxBarcodeEvents() {
    //Retrival
    var nBoxFileStatus = $('#ContentPlaceHolder1_hdnboxfilestatus').val();
    var nFileStatus = $('#ContentPlaceHolder1_hdnfilestatus').val();
    var txtBoxIdBoxCode = $('#ContentPlaceHolder1_txtBoxBarCode');
    var SetSelectedValueBoxCodeHidden = $('#ContentPlaceHolder1_selectedValue');
    var txtFileBarCode = $('#ContentPlaceHolder1_txtFileBarCode');
    AutoCompleAtPageLoad(txtBoxIdBoxCode, SetSelectedValueBoxCodeHidden, nBoxFileStatus, txtFileBarCode);
    AutoCompleAtPageLoadFileBarcode(txtFileBarCode, txtFileBarCode, SetSelectedValueBoxCodeHidden, nFileStatus);
    //Permanent
    var txtBoxIdBoxCode = '#ContentPlaceHolder1_txtPermBoxBarCode'
    var SetSelectedValueBoxCodeHidden = '#ContentPlaceHolder1_hdnPermaBoxBarCode'
    var txtFileBarCode = '#ContentPlaceHolder1_txtPermFileBarCode'
    nBoxFileStatus = 1; //1 -In 2-Out 0 -all
    nFileStatus = 1; //1 -In 2-Out 0 -all
    AutoCompleAtPageLoad(txtBoxIdBoxCode, SetSelectedValueBoxCodeHidden, nBoxFileStatus, txtFileBarCode);
    AutoCompleAtPageLoadFileBarcode(txtFileBarCode, txtFileBarCode, SetSelectedValueBoxCodeHidden, nFileStatus);
    //Destruction
    var txtBoxIdBoxCode = '#ContentPlaceHolder1_txtDestructionBoxBarCode'
    var SetSelectedValueBoxCodeHidden = '#ContentPlaceHolder1_hdnDestructionBoxbarid'
    var txtFileBarCode = '#ContentPlaceHolder1_txtDestructionFileBarCode'
    AutoCompleAtPageLoad(txtBoxIdBoxCode, SetSelectedValueBoxCodeHidden, 0, txtFileBarCode);
    AutoCompleAtPageLoadFileBarcode(txtFileBarCode, txtFileBarCode, SetSelectedValueBoxCodeHidden, 0);

    //Other Services

    var txtBoxIdBoxCode = '#ContentPlaceHolder1_txtotherServicesBoxBarCode'
    var SetSelectedValueBoxCodeHidden = '#ContentPlaceHolder1_selectedValueOtherServices'
    var txtFileBarCode = '#ContentPlaceHolder1_txtOtherServicesFileBarcode'
    AutoCompleAtPageLoad(txtBoxIdBoxCode, SetSelectedValueBoxCodeHidden, 0, txtFileBarCode);
    AutoCompleAtPageLoadFileBarcode(txtFileBarCode, txtFileBarCode, SetSelectedValueBoxCodeHidden, 0);
    OtherServicesGridAutoComplete();
}

function OtherServicesGridAutoComplete() {
    $("[id^='ContentPlaceHolder1_grdOtherServicesFiles_txtotherServicesBoxBarCode_']").each(function () {
        var currentBoxCode = $(this).html();
        var boxlableId = "#" + $(this).attr('id');
        var rowid = boxlableId.replace("#ContentPlaceHolder1_grdOtherServicesFiles_txtotherServicesBoxBarCode_", "");
        var hiddenId = '#ContentPlaceHolder1_grdOtherServicesFiles_selectedValueOtherServices_' + rowid;
        var txtFileBarCode = '#ContentPlaceHolder1_grdOtherServicesFiles_txtOtherServicesFileBarcode_' + rowid;
        AutoCompleAtPageLoad(boxlableId, hiddenId, 0, txtFileBarCode);
        AutoCompleAtPageLoadFileBarcode(txtFileBarCode, txtFileBarCode, hiddenId, 0);
    });
}

function AutoCompleAtPageLoad(txtBoxId, SetSelectedValue, nBoxFileStatus, txtFilBarCode) {
    //alert(SetSelectedValue.val());
    $(function () {
        $(txtBoxId).autocomplete({
            source: function (request, response) {
                $.ajax({
                    url: 'WorkOrders.aspx/GetBoxBarCode',
                    data: "{ 'prefix': '" + request.term + "', 'CustomerId': '" + $('#ContentPlaceHolder1_ddlCustomer').val() + "', 'BoxFileStatus': " + nBoxFileStatus + "}",
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
                                if (SetSelectedValue != null) {
                                    $(SetSelectedValue).val(item.value);
                                }
                            }))
                        } else {
                            response([{ label: 'No results found.', val: -1}]);
                            // SetSelectedValue.val('');
                        }
                    }
                });
            },
            select: function (e, u) {
                if (u.item.val == -1) {
                    return false;
                }
                else {
                    $(txtFilBarCode).val('');
                    $('#ContentPlaceHolder1_txtFileBarCode').val('');
                    $('#ContentPlaceHolder1_txtPermFileBarCode').val('');
                    $('#ContentPlaceHolder1_txtDestructionFileBarCode').val('');
                    $(SetSelectedValue).val(u.item.val);

                }
            }
        });
    });
}


function autocompDrop(txtid, SetSelectedValue) {
    // alert($('#ContentPlaceHolder1_hdnboxfilestatus').val());
    //BoxFileStatus 0 All 1 - In 2 -Out 
    var txtBoxBarCode = $("#" + txtid);
    var nBoxFileStatus = 0;
    if ('ContentPlaceHolder1_txtPermBoxBarCode' == txtid) {
        nBoxFileStatus = 1;
    }
    else
        nBoxFileStatus;



    if (txtBoxBarCode.val() != '') {
        $.ajax({
            url: 'WorkOrders.aspx/GetBoxBarCode',
            data: "{ 'prefix': '" + txtBoxBarCode.val() + "', 'CustomerId': '" + $('#ContentPlaceHolder1_ddlCustomer').val() + "', 'BoxFileStatus': " + nBoxFileStatus + "}",
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

                    }))
                } else {

                    $(txtBoxBarCode).val('');
                    response([{ label: 'No results found.', val: -1}]);
                }
            },
            select: function (e, u) {
                if (u.item.val == -1) {
                    $(txtBoxBarCode).val('');
                    return false;
                }
            }
        });
    }
}

function AutoCompleAtPageLoadFileBarcode(txtFileBarCode, txtBoxId, SelectedValue, nFileStatus) {
    $(function () {
        $(txtBoxId).autocomplete({
            source: function (request, response) {
                $.ajax({
                    url: 'WorkOrders.aspx/GetFileBaCode',
                    data: "{ 'prefix': '" + $(txtFileBarCode).val() + "', 'CustomerId': '" + $('#ContentPlaceHolder1_ddlCustomer').val() + "', 'BoxId': '" + $(SelectedValue).val() + "','FileStatus': " + nFileStatus + "}",
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
                            }))
                        } else {
                            $(txtFileBarCode).val('');
                            response([{ label: 'No results found.', val: -1}]);
                            $("#" + txtBoxId).val('');
                        }
                    }
                });
            },
            select: function (e, u) {
                //  alert("here");
                if (u.item.val == -1) {
                    $(this).val("");
                    return false;
                }
            }
        });
    });
}
function autocompDropFile(txtid, SelectedValue) {
    var txtFileBarCode = $("#" + txtid);
    //alert(txtFileBarCode.val());
    var nFileStatus = 0;
    if ('ContentPlaceHolder1_txtPermBoxBarCode' == txtid)
        nFileStatus = 1;
    else
        nFileStatus = $('#ContentPlaceHolder1_hdnfilestatus').val();

    if (txtFileBarCode.val() != '') {

        $.ajax({
            url: 'WorkOrders.aspx/GetFileBaCode',
            data: "{ 'prefix': '" + txtFileBarCode.val() + "', 'CustomerId': '" + $('#ContentPlaceHolder1_ddlCustomer').val() + "', 'BoxId': '" + $(SelectedValue).val() + "', 'FileStatus': " + nFileStatus + "}",
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
                    }))
                }
                else {
                    $(txtFileBarCode).val('');
                    response([{ label: 'No results found.', val: -1}]);
                }
            },

            select: function (e, u) {
                if (u.item.val == -1) {
                    //   alert(txtFileBarCode.val());
                    $(txtFileBarCode).val('');
                    return false;
                }
            }
        });
    }
}

function ValidationOtherServices() {

    var ErrorMsg = "Following fields are mandatory! \n "
    var ValResult = true;

    if ($("#ContentPlaceHolder1_ddlWareHouse").val() == "0") {
        ErrorMsg += "\t \t WareHouse \n \t\t";
        ValResult = false;
    }
    if ($("#ContentPlaceHolder1_ddlCompanyGroup").val() == "0") {
        ErrorMsg += "\t \t CompanyGroup \n \t\t";
        ValResult = false;
    }
    if ($("#ContentPlaceHolder1_ddlCustomer").val() == "0") {
        ErrorMsg += "\t \t Customer \n \t\t ";
        ValResult = false;
    }
    if ($("#ContentPlaceHolder1_ddlOtherServices").val() == "0") {
        ErrorMsg += "\t \t Other Services Activity\n \t\t ";
        ValResult = false;
    }

    if ($("#ContentPlaceHolder1_txtotherServicesBoxBarCode").val() == '') {
        ErrorMsg += "\t \t Please select Box Bar Code \n \t\t";
        ValResult = false;
    }
    if ($("#ContentPlaceHolder1_txtOtherServicesFileBarcode").val() == '') {
        ErrorMsg += "\t \t Please select File Bar Code \n \t\t";
        ValResult = false;
    }

    if (ValResult == false) {
        alert(ErrorMsg);
        return false;
    }
    else {
        var result = VaildateOtherSrvcBoxFileBCode();
        if (result == false)
            return false;
        else
            return true;
    }
}

function VaildateOtherSrvcBoxFileBCode() {
    var Result = true;
    var CheckFlag = 0;
    var ddlActivity = $("#ContentPlaceHolder1_ddlOtherServices option:selected").text();
    var txtBoxBarCode = $("#ContentPlaceHolder1_txtotherServicesBoxBarCode");
    var txtFileBarCode = $("#ContentPlaceHolder1_txtOtherServicesFileBarcode");
    var LenGrid = $("[id^='ContentPlaceHolder1_grdOtherServicesFiles_lblFileBarCode_']").length;
    if (LenGrid > 0) {
        for (var i = 0; i < LenGrid; i++) {
            var ActivtyName = $('#ContentPlaceHolder1_grdOtherServicesFiles_lblName_' + i).html();
            var BoxBarCode = $('#ContentPlaceHolder1_grdOtherServicesFiles_lblBoxBarCode_' + i).html();
            var FileBarCode = $('#ContentPlaceHolder1_grdOtherServicesFiles_lblFileBarCode_' + i).html();
            if ((txtFileBarCode.val() == FileBarCode) && (txtBoxBarCode.val() == BoxBarCode) && (ddlActivity == ActivtyName))
                if (ddlActivity == ActivtyName && txtFileBarCode.val() == FileBarCode) {
                    alert('Duplicate File BarCode Found.');
                    Result = false;
                }
    }
}
return Result;
}
function showFiledetails() {
    if ($("#ContentPlaceHolder1_chkaddfileacessDetails").prop('checked')) {
        $('#divotherservicefiledetails').show();
        $("#divotherservicefiledetails").attr('style', 'display:block');
        $("#divotherservicefiledetails").attr('style', 'display:block');
    }
    else {
        $('#divotherservicefiledetails').hide();
        $("#divotherservicefiledetails").attr('style', 'display:none');
        $("#divotherservicefiledetails").attr('style', 'display:none');
    }
}

function ValidDDLOtherServices(id, val) {
    var LenGrid = $("[id^='ContentPlaceHolder1_grdOtherAddServiceActivity_txtNoOfServices_']").length;
    var strAppend = ""
    $('#ContentPlaceHolder1_ddlOtherServices').html('');
    if (LenGrid > 0) {
        for (var i = 0; i < LenGrid; i++) {
            var NoOfServices = $('#ContentPlaceHolder1_grdOtherAddServiceActivity_txtNoOfServices_' + i).val();
            var ActivtyName = $('#ContentPlaceHolder1_grdOtherAddServiceActivity_lblName_' + i).html();
            var ActivityId = $('#ContentPlaceHolder1_grdOtherAddServiceActivity_hdnActivityid_' + i).html();
            alert(NoOfServices);
            if (val != NoOfServices) {
                if (strAppend == "") {
                    strAppend = '<option value=0>-select-</option>';
                }
                else {
                    strAppend = strAppend + '<option value=' + ActivityId + '>' + ActivtyName + '</option>';
                    $('#ContentPlaceHolder1_ddlOtherServices').append(strAppend);
                }
            }
        }

    }
}

function CompareDocumentSearchingFileCount() {
    alert('0');
    var Result = true;
    var LenGrid = $("[id^='ContentPlaceHolder1_grdOtherAddServiceActivity_txtNoOfServices_']").length;
    if (LenGrid > 0) {
        for (var i = 0; i < LenGrid; i++) {
            var ActivtyName = $('#ContentPlaceHolder1_grdOtherAddServiceActivity_lblName_' + i).html();
            var NoOfServices = $('#ContentPlaceHolder1_grdOtherAddServiceActivity_txtNoOfServices_' + i).html();
            if (ActivtyName == 'Document Searching & Insertion' && NoOfServices != '') {
                alert('1');
                //alert('Duplicate Activity Name  Found.');
                Result = false;
            }
        }
    }
    return Result;
}

