$(document).ready(function () {
    // alert('Page ready')
    function boxValidate() {
        alert('Box validate');
        return false;
    }
});

function validbox() {
    var Res = false;
    Res = ReqFields(1);
    if (Res == false) {
        return false; 
    }
    Res = findAlreadyExistRow();
    return Res;
}
function findAlreadyExistRowinBox() {
    var Ans = true;
    var TotalRecord = parseInt($("[id^='ContentPlaceHolder1_grdBoxDetails_lblBoxCode_']").length);
    var TotalAllowedEntry = parseInt(25);
    if (TotalRecord >= TotalAllowedEntry) {
        alert('Only 25 record add at a time.')
        return false;
    } 
    $("[id^='ContentPlaceHolder1_grdBoxDetails_lblBoxCode_']").each(function () {
        var currentBoxCode = $(this).html();
        //  alert(currentBoxCode);
        var MatchBoxCode = $("#ContentPlaceHolder1_grdBoxDetails_txtBoxBarCode").val();
        if (currentBoxCode == MatchBoxCode) {
            var boxlableId = $(this).attr('id');
            var rowid = boxlableId.replace("ContentPlaceHolder1_grdBoxDetails_lblBoxCode_", "");
            //alert(parseInt(rowid) + 1);
            rowid = parseInt(rowid) + 1;
            alert('\t\t Duplicate box code entry found! \n \t Boxcode "' + MatchBoxCode + '" already entered on row ' + rowid+".");
            Ans = false;
        }

    });
    return Ans;

}

function validFiles() {
    var Res = false;
    Res = ReqFields(0);
    if (Res == false) {
        return false;
    }
    Res = findAlreadyExistRowinFiles();
    return Res;
}


function findAlreadyExistRowinFiles() {
    var Ans = true;
    var TotalRecord = parseInt($("[id^='ContentPlaceHolder1_grdFilesDetails_lblFileCode_']").length);
    var TotalAllowedEntry = parseInt(25);
    if (TotalRecord >= TotalAllowedEntry) {
        alert('Only 25 record add at a time.')
        return false;
    }
    $("[id^='ContentPlaceHolder1_grdFilesDetails_lblFileCode_']").each(function () {
        var currentBoxCode = $(this).html();
        //  alert(currentBoxCode);
        var MatchBoxCode = $("#ContentPlaceHolder1_grdFilesDetails_txtFileBarCode").val();
        if (currentBoxCode == MatchBoxCode) {
            var boxlableId = $(this).attr('id');
            var rowid = boxlableId.replace("ContentPlaceHolder1_grdFilesDetails_lblFileCode_", "");
            //alert(parseInt(rowid) + 1);
            rowid = parseInt(rowid) + 1;
            alert('\t\t Duplicate file code entry found! \n \t file code  "' + MatchBoxCode + '" already entered on row ' + rowid + ".");
            Ans = false;
        }
    });
    return Ans;

}

// 1 =box 0= files
function ReqFields(IsBox) {
    var ErrorMsg = "\t Following fields are mandatory! \n "
    var ValResult = true;

    if ($("#ContentPlaceHolder1_ddlWareHouse").val() == "0") {
        ErrorMsg += "WareHouse \n \t\t";
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


    if ($("#ContentPlaceHolder1_ddlWorkOrder").val() == "0") {

        ErrorMsg += "Work Order \n \t\t ";
        ValResult = false;


    }

    if ($("#ContentPlaceHolder1_ddlWorkOrderActivity").val() == "0") {
        //ErrorMsg += "WorkOrder Activity  \n \t\t ";
        ErrorMsg += "Pickup Address  \n \t\t ";
        ValResult = false;

    }

    if (IsBox == 1) {
        if ($.trim($("#ContentPlaceHolder1_grdBoxDetails_txtBoxBarCode").val()) == "") {
            ErrorMsg += "Box Code \n \t\t ";
            ValResult = false;
        }
    } else {

        if ($.trim($("#ContentPlaceHolder1_grdBoxDetails_txtBoxBarCode").val()) == "") {
            ErrorMsg += "Box Code \n \t\t ";
            ValResult = false;
        }

        if ($.trim($("#ContentPlaceHolder1_grdFilesDetails_txtFileCode").val()) == "") {
            ErrorMsg += "File Code \n \t\t ";
            ValResult = false;
        }

    }

    if (ValResult == false) {
        alert(ErrorMsg);
        return false;
    }
}

function validateFreshPickupall() {
    var Res = false;
    var ErrorMsg = "\t Following fields are mandatory! \n \t\t"
    var ValResult = true;

    if ($("#ContentPlaceHolder1_ddlWareHouse").val() == "0") {
        ErrorMsg += " WareHouse \n \t\t";
        ValResult = false;

    }

    if ($("#ContentPlaceHolder1_ddlCompanyGroup").val() == "0") {
        ErrorMsg += " CompanyGroup \n \t\t";
        ValResult = false;

    }

    if ($("#ContentPlaceHolder1_ddlCustomer").val() == "0") {
        ErrorMsg += " Customer \n \t\t ";
        ValResult = false;

    }
    if ($("#ContentPlaceHolder1_ddlWorkOrder").val() == "0") {

        ErrorMsg += "Work Order \n \t\t ";
        ValResult = false;


    }

    if ($("#ContentPlaceHolder1_ddlWorkOrderActivity").val() == "0") {
        //  ErrorMsg += "Work Order Activity  \n \t\t ";
        ErrorMsg += "Pickup Address  \n \t\t ";
        ValResult = false;

    }

    if (ValResult == false) {
        alert(ErrorMsg);
        return false;
    }

    var grdfiles = false;
    grdfiles = $('#ContentPlaceHolder1_rbtactivityType_0').attr('checked');
    //alert(grdfiles);
    if (grdfiles == true) {
        Res = CheckFileOrBoxEntry(true);
    }
    else {
        Res = CheckFileOrBoxEntry(false);
    }

    if (Res == true) {


        Res = confirm('Are you sure to continue?');
    }
    return Res;
}



function validateModifyMaker() {
    var Res = false;
    var ErrorMsg = "\t Following fields are mandatory! \n \t\t"
    var ValResult = true;

  
    if ($("#ContentPlaceHolder1_ddlWorkOrderModify").val() == "0") {

        ErrorMsg += " Work Order \n \t\t ";
        ValResult = false;


    }

    var grdfiles = false;
    grdfiles = $('#ContentPlaceHolder1_rbtactivityTypeModify_0').attr('checked');
    
    if (grdfiles == false && ValResult == true) {
        var chkboxrowcount = $("#ContentPlaceHolder1_grdFilesDetailsModify input[id*='cbSelect']:checkbox:checked").size();
        if (chkboxrowcount == 0) {
            ErrorMsg += " please select at least one record! \n \t\t";
            ValResult = false;
        }
    }
    else if (grdfiles == true && ValResult == true) {
        var chkboxrowcount = $("#ContentPlaceHolder1_grdboxdetailsModify input[id*='cbSelect']:checkbox:checked").size();
        if (chkboxrowcount == 0) {
            ErrorMsg += " please select at least one record! \n \t\t";
            ValResult = false;
        }
    }

    if (ValResult == false) {
        alert(ErrorMsg);
        return false;
    }

   
    //alert(grdfiles);
    if (grdfiles == true) {
        Res = CheckFileOrBoxEntryModify(true);
    }
    else {
        Res = CheckFileOrBoxEntryModify(false);
    }

    if (Res == true) {


        Res = confirm('Are you sure to continue?');
    }
    return Res;
}







function validateChecker() {
    var Res = false;
    var ErrorMsg = "\t Following fields are mandatory! \n \t\t"
    var ValResult = true;


    if ($("#ContentPlaceHolder1_ddlWorkOrderChecker").val() == "0") {

        ErrorMsg += "Work Order \n \t\t ";
        ValResult = false;


    }

    if (ValResult == false) {
        alert(ErrorMsg);
        return false;
    }

    var grdfiles = false;
    grdfiles = $('#ContentPlaceHolder1_rbtactivityTypeChecker_0').attr('checked');
    //alert(grdfiles);
    if (grdfiles == true) {
        //Res = CheckFileOrBoxEntryChecker(true);
        Res = true;
    }
    else {
        // Res = CheckFileOrBoxEntryChecker(false);
        Res = true;
    }

    if (Res == true) {

        Res = confirm('Are you sure to continue?');
    }
    return Res;
}


function CheckFileOrBoxEntry(IsBoxDetails) {
    var res = false;
    if (IsBoxDetails == false) {
        $("[id^='ContentPlaceHolder1_grdFilesDetails_txtFileBarCode_']").each(function () {
            if ($.trim($(this).val()) != "") {
                res = true;
            }
        });
    } else {
        $("[id^='ContentPlaceHolder1_grdboxdetails_txtBoxBarCode_']").each(function () {
            if ($.trim($(this).val()) != "") {
                res = true;
            }
        });
    }
    if (res == false )
        {
            alert('Please add at least one entry.')
            return false;
        }
    return true;
}

function CheckFileOrBoxEntryModify(IsBoxDetails) {
    var res = false;
    if (IsBoxDetails == false) {
        $("[id^='ContentPlaceHolder1_grdFilesDetailsModify_txtFileBarCode_']").each(function () {
            if ($.trim($(this).val()) != "") {
                res = true;
            }
        });
    } else {
        $("[id^='ContentPlaceHolder1_grdboxdetailsModify_txtBoxBarCode_']").each(function () {
            if ($.trim($(this).val()) != "") {
                res = true;
            }
        });
    }
    if (res == false) {
        alert('Please add at least one entry.')
        return false;
    }
    return true;
}



function disablevalidAll() {
    for (i = 0; i < Page_Validators.length; i++) {
        
          ValidatorEnable(Page_Validators[i], false);
      }
          if (typeof (Page_ClientValidate) == 'function') {
        Page_ClientValidate();
    }
    if (Page_IsValid) {
        return  true;
    }
    return true;
    }

    function HidedivDuplicate() {
        $("#divDuplicateRecord").hide()
        $("#divDuplicateRecord").html("");
        $("#divDuplicateRecord").attr('style', 'display:none');
        $("#blocker").hide();
        $("#blocker").attr('style', 'display:none');
    }

    function ShowdivDuplicate() {
        $("#divDuplicateRecord").attr('style', 'display:block');
        $("#divDuplicateRecord").show();
        $("#blocker").show();
        $("#blocker").attr('style', 'display:block');

    }

    function findDuplicateBoxInFiles(id) {
        var MatchFileCode = $("#" + id);
        //alert(MatchFileCode.val());
        if (MatchFileCode.val() != "") {
            $("[id^='ContentPlaceHolder1_grdFilesDetails_txtBoxBarCode_']").each(function () {
                var currentFileCode = $(this).val();
                var CurrentId = $(this).attr("id");
                if (CurrentId != id) {
                    if (currentFileCode == MatchFileCode.val()) {
                        var boxlableId = $(this).attr('id');
                        var rowid = boxlableId.replace("ContentPlaceHolder1_grdFilesDetails_txtBoxBarCode_", "");
                        rowid = parseInt(rowid) + 1;
                        alert('\t\t Box Barcode  "' + MatchFileCode.val() + '" already entered on row ' + rowid + ".");
                        MatchFileCode.val("");
                        return false;
                    }
                }
            });
        }
    }
    function findduplicatefileName(id,grd) {
        var MatchFileCode = $("#"+id);
        //alert(MatchFileCode.val());
        if (MatchFileCode.val() != "") {
            $("[id^='ContentPlaceHolder1_" + grd + "_txtFileBarCode_']").each(function () {
                var currentFileCode = $(this).val();
                var CurrentId = $(this).attr("id");
                if (CurrentId != id) {
                    if ($.trim(currentFileCode) == $.trim(MatchFileCode.val())) {
                        //alert(MatchFileCode.val());
                        var boxlableId = $(this).attr('id');
                        var rowid = boxlableId.replace("ContentPlaceHolder1_" + grd + "_txtFileBarCode_", "");
                        rowid = parseInt(rowid) + 1;
                        alert('\t\t File code  "' + MatchFileCode.val() + '" already entered on row ' + rowid + ".");
                        //if (grd == 'grdFilesDetails') {
                            MatchFileCode.val("");
                        //}
                        return false;
                    }
                }

            });
        }
    }

    function findDuplicateBox(id, grd) {
       
        var MatchFileCode = $("#" + id);
        //alert(MatchFileCode.val());
        if (MatchFileCode.val() != "") {
            $("[id^='ContentPlaceHolder1_" + grd + "_txtBoxBarCode_']").each(function () {
                var currentFileCode = $(this).val();
                var CurrentId = $(this).attr("id");
                if (CurrentId != id) {
                    if ($.trim(currentFileCode) ==$.trim(MatchFileCode.val())) {
                        var boxlableId = $(this).attr('id');
                        var rowid = boxlableId.replace("ContentPlaceHolder1_" + grd + "_txtBoxBarCode_", "");
                        rowid = parseInt(rowid) + 1;
                        alert('\t\t Box Barcode  "' + MatchFileCode.val() + '" already entered on row ' + rowid + ".");
                        MatchFileCode.val("");
                        return false;
                    }
                }
            });
        }
    }

    // findDupBoxLocode 
    function  findDupBoxLocode(id,grd) {
        var MatchFileCode = $("#" + id);
        if (MatchFileCode.val() != "") {
            $("[id^='ContentPlaceHolder1_" + grd + "_txtBoxLocCode_']").each(function () {
                var currentFileCode = $(this).val();
                var CurrentId = $(this).attr("id");
                if (CurrentId != id) {
                    if (currentFileCode == MatchFileCode.val()) {
                        var boxlableId = $(this).attr('id');
                        var rowid = boxlableId.replace("ContentPlaceHolder1_" + grd + "_txtBoxLocCode_", "");
                        rowid = parseInt(rowid) + 1;
                        alert('\t\t Box Location code  "' + MatchFileCode.val() + '" already entered on row ' + rowid + ".");
                        MatchFileCode.val("");
                        return false;
                    }
                }
            });
        }
    }

    function divShowWoActivityDetails() {

        $('#divWoActivityDetails').show();
        $("#blocker").attr('style', 'display:block');
        $("#divWoActivityDetails").attr('style', 'display:block;width:800px;');

        return false;
    }

    function HidedivWoActivityDetails() {

        $('#divWoActivityDetails').hide();
        $("#divWoActivityDetails").attr('style', 'display:none');
        $("#blocker").attr('style', 'display:none');

    }

    function changeCells(obj, objid, event) {
        var strid = "#" + objid;
        var row = $(strid).parent().parent();
        var cell = $(strid).parent();
        var colIndex = $(strid).parent().index();
        //alert(colIndex);
        var totalrows = 25;
        var changeCellindex = colIndex;
        if (event.keyCode == 40) //Down 
        {
            var txt = $(strid).parent().parent().next().children().eq(changeCellindex).children();
            if(txt !=null){
            txt.focus();
            }
            return;
        }
        if (event.keyCode == 38) //Up 
        {
            var txt = $(strid).parent().parent().prev().children().eq(changeCellindex).children();
           if(txt !=null){
            txt.focus();
            }
            return;
        }
//        if (event.keyCode == 37) //Left 
//        {
//            changeCellindex = parseInt(changeCellindex) - 1;
//            if (changeCellindex > 0)
//                var txt = $(strid).parent().parent().children().eq(changeCellindex).children().focus();
//            if(txt !=null){
//            txt.focus();
//            }
//            return;
//        }
//        if (event.keyCode == 39) //Right 
//        {            
//            changeCellindex = parseInt(changeCellindex) + 1;
//            var txt = $(strid).parent().parent().children().eq(changeCellindex).children().focus();
//             if(txt !=null){
//            txt.focus();
//            }
//            return;
//        }
        return; 
    }


    function divShowBoxDetails( Ishide) {
    if(Ishide == 1)
    {
        $('#table-containerBox').show();
        $("#table-containerBox").attr('style', 'display:block');
     }
     else {
         $('#table-containerBox').hide();
         $("#table-containerBox").attr('style', 'display:none');
         alert('File hide');
        }
        return false;
    }
   

    function FHeader() {
        $("[id^='ContentPlaceHolder1_grdFilesDetails_txtFileBarCode_']").each(function () {
            var CurrentId = $(this).attr("id");
            alert(CurrentId);
            return false;
        });
    }



function SelectAllCheckboxes(chk,Grd) {
    $('#ContentPlaceHolder1_'+Grd+' >tbody >tr >td >input:checkbox').attr('checked', chk.checked);
}


function CheckSelectAll(Grd) {
        var flag = true;
        $("[id^='ContentPlaceHolder1_"+Grd+"_cbSelect_']").each(function () {
           // alert(this.id);
            if (this.checked == false)
                flag = false;
        });
        if (flag == true) {
            $("#ContentPlaceHolder1_"+Grd+"_chkSelectAll").attr('checked', true);
        }
        else {
            $("#ContentPlaceHolder1_"+Grd+"_chkSelectAll").removeAttr('checked');
        }
    }

   



function BindBoxBarcodeEvents() {
    //Fresh Checker
    //var txtBoxIdBoxCode = '#ContentPlaceHolder1_txtBoxBarCode'
   // var SetSelectedValueBoxCodeHidden = '#ContentPlaceHolder1_selectedValue'
    //var txtFileBarCode = '#ContentPlaceHolder1_txtOtherServicesFileBarcode'
   // AutoCompleAtPageLoad(txtBoxIdBoxCode, SetSelectedValueBoxCodeHidden, 0);
   // AutoCompleAtPageLoadFileBarcode(txtFileBarCode, txtFileBarCode, SetSelectedValueBoxCodeHidden, 0);
   FreshGridAutoComplete();
}



function FreshGridAutoComplete() {
    $("[id^='ContentPlaceHolder1_grdboxdetails_txtBoxBarCode_']").each(function () {
        var currentBoxCode = $(this).html();
        var boxlableId = "#" + $(this).attr('id');
        var rowid = boxlableId.replace("#ContentPlaceHolder1_grdboxdetails_txtBoxBarCode_", "");
        var hiddenId = '#ContentPlaceHolder1_grdboxdetails_selectedValue_' + rowid;
        //var txtFileBarCode = '#ContentPlaceHolder1_grdboxdetails_txtOtherServicesFileBarcode_' + rowid;
         AutoCompleAtPageLoad(boxlableId, hiddenId, 0);
        //AutoCompleAtPageLoadFileBarcode(txtFileBarCode, txtFileBarCode, hiddenId, 0);
    });
}

function AutoCompleAtPageLoad(txtBoxId, SetSelectedValue,nBoxFileStatus) {
    //alert(SetSelectedValue.val());
    $(function () {
        $(txtBoxId).autocomplete({
            source: function (request, response) {
                $.ajax({
                    url: 'MakerAndChecker.aspx/GetBoxBarCode',
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
                    //$(txtFilBarCode).val('');
//                    $('#ContentPlaceHolder1_txtFileBarCode').val('');
//                    $('#ContentPlaceHolder1_txtPermFileBarCode').val('');
//                    $('#ContentPlaceHolder1_txtDestructionFileBarCode').val('');
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
//    if ('ContentPlaceHolder1_txtPermBoxBarCode' == txtid) {
//        nBoxFileStatus = 1;
//    }
//    else
//        nBoxFileStatus = $('#ContentPlaceHolder1_hdnboxfilestatus').val();

    if (txtBoxBarCode.val() != '') {
        $.ajax({
            url: 'MakerAndChecker.aspx/GetBoxBarCode',
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
                    txtBoxBarCode.val('');
                    response([{ label: 'No results found.', val: -1}]);
                }
            },
            select: function (e, u) {
                if (u.item.val == -1) {

                    return false;
                }
                else {
                    if (SetSelectedValue != null) {
//                        $('#ContentPlaceHolder1_txtFileBarCode').val('');
//                        $('#ContentPlaceHolder1_txtPermFileBarCode').val('');
//                        $('#ContentPlaceHolder1_txtDestructionFileBarCode').val('');
                        $(SetSelectedValue).val(item.value);
                    }
                }
            }
        });
    }
}
