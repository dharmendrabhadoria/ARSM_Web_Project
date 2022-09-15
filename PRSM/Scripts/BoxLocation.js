function divShowBlocker() {
  //  alert('Yahoooooooooo');
    if ($("#ContentPlaceHolder1_ddlWareHouse").val() == "0") {
        alert('Please select warehouse');
        return false;
    }

    $("#blocker").attr('style', 'display:block');
    return true;
}

function divHideblocker() {
    $("#blocker").hide();
    //alert('Chhhhhhhhhhh');
    $("#blocker").attr('style', 'display:none');
    
    return false;
}

function BindBoxBarcodeEvents() {
    //Retrival
    var nBoxFileStatus = $('#ContentPlaceHolder1_hdnboxfilestatus').val();
    var nFileStatus = $('#ContentPlaceHolder1_hdnfilestatus').val();
    var txtBoxIdBoxCode = $('#ContentPlaceHolder1_txtSearchLocation');
    var SetSelectedValueBoxCodeHidden = $('#ContentPlaceHolder1_selectedValue');
    var txtFileBarCode = $('#ContentPlaceHolder1_txtSearchLocation');
    
    AutoCompleAtPageLoadFileBarcode(txtFileBarCode, txtFileBarCode, SetSelectedValueBoxCodeHidden, 0);
}
function AutoCompleAtPageLoadFileBarcode(txtFileBarCode, txtBoxId, SelectedValue, nFileStatus) {
    $(function () {
        $(txtBoxId).autocomplete({
            source: function (request, response) {
                $.ajax({
                    //  url: '../Transaction/WorkOrders.aspx/GetLocation',
                    url: 'ViewLocation.aspx/GetLocation',
                    data: "{ 'prefix': '" + $(txtFileBarCode).val() + "', 'WareHouseId': '" + $('#ContentPlaceHolder1_ddlWareHouseSearch').val() + "', 'BoxId': '" + $('#ContentPlaceHolder1_ddlRowSearch').val() + "','FileStatus': " + nFileStatus + "}",
                    type: "POST",
                    
                    dataType: "json",
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
            url: 'ViewLocation.aspx/GetLocation',
            data: "{ 'prefix': '" + $(txtFileBarCode).val() + "', 'WareHouseId': '" + $('#ContentPlaceHolder1_ddlWareHouseSearch').val() + "', 'BoxId': '" + $('#ContentPlaceHolder1_ddlRowSearch').val() + "','FileStatus': " + nFileStatus + "}",
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


function validateFileUpload()
 {
    var uplSheet = document.getElementById('ContentPlaceHolder1_fiuploadExcel');
   // alert(uplSheet.value.trim());
    var extn = uplSheet.value.substring(uplSheet.value.lastIndexOf('.') + 1).toLowerCase();
    if (uplSheet.value.trim() == "")
     {
        alert('Please Select File To Upload');
        return false;
    }
    var i = 1;
    if (uplSheet.value.trim() == "") {
        alert('Please Select File To Upload');
        return false;
    }
    else {
        if (uplSheet.value.trim() != "") {
            // var i = 1;
            if (extn == 'xls' || extn == 'xlsx') {
                i = 0;
            }
        }
    }
    if (i == 1) {
        uplSheet.value = '';
        alert('You can upload file with xls,xlsx extensions only.');
        return false;
    }
    return true;
}