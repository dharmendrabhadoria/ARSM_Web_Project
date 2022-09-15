function validateFileUpload() {
        var uplSheet = document.getElementById('ContentPlaceHolder1_fileContractDocPath');
        var extn = uplSheet.value.substring(uplSheet.value.lastIndexOf('.') + 1).toLowerCase();
        var hfIsFilePath = document.getElementById('ContentPlaceHolder1_fileContractDocPath');
        var i = 1;
        if (hfIsFilePath.value == "") {
            if (uplSheet.value.trim() == "") {
                //lbl.innerHTML = "Please Select File To Upload";
                return false;
            }

            if (extn == 'doc' || extn == 'docx' || extn == 'pdf') {
                i = 0;
            }
        }
        else {
            if (uplSheet.value.trim() != "") {
                // var i = 1;
                if (extn == 'doc' || extn == 'docx' || extn == 'pdf') {
                    i = 0;
                }
            }
        }
        
        if (i == 1) {
            uplSheet.value = '';
            //lbl.innerHTML = "You can upload file with jpg,jpeg,xls,xlsx,doc,docx extensions only.";
            alert('You can upload file with doc,docx,pdf extensions only.');
            return false;
        }
        hfIsFilePath.value = uplSheet.value;
         return true;
     }

function clearContractfields() {
//    $('#ContentPlaceHolder1_txtContractNo').val('');
//    $('#ContentPlaceHolder1_txtContractNo').attr('disabled', false);
    $('#ContentPlaceHolder1_txtFromDateContract').val('')
    $('#ContentPlaceHolder1_txtEndDateContract').val('')
    $('#ContentPlaceHolder1_txtRemark').val('')
    $('#ContentPlaceHolder1_txtDocumentName').val('')
    $('#ContentPlaceHolder1_fileContractDocPath').val('')
    $('#ContentPlaceHolder1_fileContractDocPath').innerhtml = '';
    $('#ContentPlaceHolder1_txtBillingAddress1').val('')
    $('#ContentPlaceHolder1_txtBillingAddress1').val('')
    if ($("#ContentPlaceHolder1_lblContrDocMsg") != null) {
        $("#ContentPlaceHolder1_lblContrDocMsg").css('display', 'none')
    }
   return false;

}

function validateContractSave() {
    var ErrorMsg = "\t Following fields are mandatory! \n \t\t"
    var ValResult = true;
    var contrNo = $('#ContentPlaceHolder1_txtContractNo').val();
    var FromDate = $("#ContentPlaceHolder1_txtFromDateContract");
    var Enddate = $("#ContentPlaceHolder1_txtEndDateContract");
//    var Remark = $('#ContentPlaceHolder1_txtRemark').val();
//    if (contrNo =='') {
//        ErrorMsg += "Contract Number \n \t\t";
//        ValResult = false;
//    }
    if (FromDate.val() =='') {
        ErrorMsg += "From Date \n \t\t";
        ValResult = false;
    }

    if (Enddate.val() =='') {
        ErrorMsg += "End Date \n \t\t ";
        ValResult = false;
    }

    if (Enddate.val() != '' && FromDate.val() != '') {
        var str1 = FromDate.val();
        var str2 = Enddate.val();
        var dt1 = parseInt(str1.substring(0, 2), 10);
        var mon1 = parseInt(str1.substring(3, 5), 10);
        var yr1 = parseInt(str1.substring(6, 10), 10);
        var dt2 = parseInt(str2.substring(0, 2), 10);
        var mon2 = parseInt(str2.substring(3, 5), 10);
        var yr2 = parseInt(str2.substring(6, 10), 10);
        var date1 = new Date(yr1, mon1, dt1);
        var date2 = new Date(yr2, mon2, dt2);
        if (date1 >= date2) {
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

function BindContractDate() {
    $(function () {
        $('#ContentPlaceHolder1_txtFromDateContract').attr('readonly', 'readonly');
        $('#ContentPlaceHolder1_txtEndDateContract').attr('readonly', 'readonly');
        $(".datepicker1").datepicker({
            changeMonth: true,
            changeYear: true,
            dateFormat: 'dd-mm-yy',
            yearRange: "-110:+15",
            beforeShow: function () {
                setTimeout(function () {
                    $('.ui-datepicker1').css('z-index', 100);
                }, 0);
            }
        });
    })
}


function ShowdivContract() {
    $('#divContract').show();
    $("#blocker").attr('style', 'display:block');
    $("#blocker").show();
}

function HidedivContract() {

    if ($("#ContentPlaceHolder1_lblContrDocMsg") != null) {
        $("#ContentPlaceHolder1_lblContrDocMsg").val('');
    }
    $('#ContentPlaceHolder1_txtContractNo').val('')
    $('#ContentPlaceHolder1_txtFromDateContract').val('')
    $('#ContentPlaceHolder1_txtEndDateContract').val('')
    $('#ContentPlaceHolder1_txtRemark').val('')
    $('#ContentPlaceHolder1_txtDocumentName').val('')
    $('#ContentPlaceHolder1_fileContractDocPath').val('')
    $('#divContract').hide();
    $("#blocker").attr('style', 'display:none');
    $('#divContract').hide();
    $("#blocker").hide();
    return false;
}

