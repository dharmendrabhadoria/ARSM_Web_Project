function ShowdivRack() {
    $('#divRack').show();
    $("#blocker").show();
    $("#blocker").attr('style', 'display:block');
    $("#divRack").attr('style', 'display:block');
   // alert('AAAAAAAAbbbbbbbbb');
}

function HidedivRack() {
  //  alert('AAAAAAAA');
    $('#divRack').hide();
    $("#blocker").hide();
    $("#blocker").attr('style', 'display:none');
    $("#divRack").attr('style', 'display:none');

}

$(document).ready(function () {
    $('#ContentPlaceHolder1_grdFilesDetails_chkstatusAll').click(function (event) {  //on click 
        if (this.checked) { // check select status
            $('*:checkbox').each(function () { //loop through each checkbox
                this.checked = true;  //select all checkboxes with class "checkbox1"               
            });
        }
        else {
            $('*:checkbox').each(function () { //loop through each checkbox
                this.checked = false; //deselect all checkboxes with class "checkbox1"                       
            });
        }
    });
    $("#ContentPlaceHolder1_grdFilesDetails input[type=checkbox]").bind("click", function () {
        CheckSelectAll();
    });
    function CheckSelectAll() {
        var flag = true;
        $("[id^='ContentPlaceHolder1_grdFilesDetails_chkstatus_']").each(function () {
           // alert(this.id);
            if (this.checked == false)
                flag = false;
        });
        if (flag == true) {
            $("#ContentPlaceHolder1_grdFilesDetails_chkstatusAll").attr('checked', true);
        }
        else {
            $("#ContentPlaceHolder1_grdFilesDetails_chkstatusAll").removeAttr('checked');
        }
    }

    $("#ContentPlaceHolder1_grdBoxDetails_chkBoxstatusAll").bind("click", function () {
        var flag = true;
        if (this.checked == false)
        { flag = false; }
        $("[id^='ContentPlaceHolder1_grdBoxDetails_chkstatus_']").each(function () {
            //alert(this.id);
            $(this).attr('checked', flag);
        });
    });
    $("[id^='ContentPlaceHolder1_grdBoxDetails_chkstatus_']").bind("click", function () {
        var flag = true;
        $("[id^='ContentPlaceHolder1_grdBoxDetails_chkstatus_']").each(function () {
            if (this.checked == false)
            { flag = false; }
        });
        $("#ContentPlaceHolder1_grdBoxDetails_chkBoxstatusAll").attr('checked', flag)
    });
});



/* Enbale/disable page validation function */
function EnableValidOnInward(IsEnable) {
    for (i = 0; i < Page_Validators.length; i++) {
        ValidatorEnable(Page_Validators[i], IsEnable);
    }
}

/* validation on btnclick */
function confirmSubmit() {
    EnableValidOnInward(true);
    var agree = confirm("Are you sure you wish to continue?");
    if (agree)
        return true;
    else
        return false;
}


function ValidateInwardfields() {
ans = ReqInwardFields();
if (ans == true) {
    //return checkCounts();
    var Rest = true;
    Rest = checkCounts()
   // alert(Rest);
    if (Rest == true) {
        divShowBlocker();
     }
    else {
        return false;
    }
}
else {
    return false;
}

}
function checkCounts() {
    
    var msg = "Please select at least one box";
    if ($("#ContentPlaceHolder1_rbtInwardFileBox_0")[0].checked == true) {
        var totalbox = $("[id^='ContentPlaceHolder1_grdBoxDetails_chkstatus_']").length;
       // alert($("[id^='ContentPlaceHolder1_grdBoxDetails_chkstatus_']").length)
     //   alert($("[id^='ContentPlaceHolder1_grdBoxDetails_chkstatus_']:checked").length);
        if (totalbox > 0) {
            var length = $("[id^='ContentPlaceHolder1_grdBoxDetails_chkstatus_']:checked").length;
            if (length > 0) {

                return true;
            }
            else {
                alert('Please select box');
                return false;

            }
        }
        else 
        {
            alert('Please select box');
            return false;

        }

    }
    else {
        var totalbox = $("[id^='ContentPlaceHolder1_grdFilesDetails_chkstatus_']").length;
        if (totalbox > 0) {
            var length = $("[id^='ContentPlaceHolder1_grdFilesDetails_chkstatus_']:checked").length;
            if (length > 0) {

                return true;
            }
            else {
                alert('Please select file');
                return false;

            }
        } else {
            alert('Please select file');
            return false;
        }
     
        return true;
    }

}

/*---- Clear field function */
function clearInwardfields() {
    EnableValidOnInward(false);
    $("#ContentPlaceHolder1_ddlWareHouse").val('0')
    $("#ContentPlaceHolder1_ddlCompanyGroup").val('0')
    $("#ContentPlaceHolder1_ddlCustomer").val('0')
    $("#ContentPlaceHolder1_ddlWorkOrder").val('0')
    $("#ContentPlaceHolder1_ddlWorkOrderActivity").val('0')
    return true;
}


function BindGrdChkUchkEvents() {
    $(document).ready(function () {
        $('#ContentPlaceHolder1_grdFilesDetails_chkstatusAll').click(function (event) {  //on click 
            if (this.checked) { // check select status
                $('*:checkbox').each(function () { //loop through each checkbox
                    this.checked = true;  //select all checkboxes with class "checkbox1"               
                });
            }
            else {
                $('*:checkbox').each(function () { //loop through each checkbox
                    this.checked = false; //deselect all checkboxes with class "checkbox1"                       
                });
            }
        });
        $("#ContentPlaceHolder1_grdFilesDetails input[type=checkbox]").bind("click", function () {
            CheckSelectAll();
        });
        function CheckSelectAll() {
            var flag = true;
            $("[id^='ContentPlaceHolder1_grdFilesDetails_chkstatus_']").each(function () {
               // alert(this.id);
                if (this.checked == false)
                    flag = false;
            });
            if (flag == true) {
                $("#ContentPlaceHolder1_grdFilesDetails_chkstatusAll").attr('checked', true);
            }
            else {
                $("#ContentPlaceHolder1_grdFilesDetails_chkstatusAll").removeAttr('checked');
            }
        }

        $("#ContentPlaceHolder1_grdBoxDetails_chkBoxstatusAll").bind("click", function () {
            var flag = true;
            if (this.checked == false)
            { flag = false; }
            $("[id^='ContentPlaceHolder1_grdBoxDetails_chkstatus_']").each(function () {
                //alert(this.id);
                $(this).attr('checked', flag);
            });
        });
        $("[id^='ContentPlaceHolder1_grdBoxDetails_chkstatus_']").bind("click", function () {
            var flag = true;
            $("[id^='ContentPlaceHolder1_grdBoxDetails_chkstatus_']").each(function () {
                if (this.checked == false)
                { flag = false; }
            });
            $("#ContentPlaceHolder1_grdBoxDetails_chkBoxstatusAll").attr('checked', flag)
        });
    });
}

function ReqInwardFieldsAll() {
    var ValResult = true;
    ValResult = ReqInwardFields();
    if (ValResult == false) {
        return false;
    }
    else {
        divShowBlocker();
        return true;

    }

}

function ReqInwardFields() {
    var ErrorMsg = "\t Following fields are mandatory! \n \t\t"
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
        ErrorMsg += "Work Order Activity  \n \t\t ";
        ValResult = false;
    }
    if (ValResult == false) {
        alert(ErrorMsg);
        return false;
    }
    else {
        return true;
    }
}

function divShowBlocker() {
    if ($("#ContentPlaceHolder1_ddlWareHouse").val() == "0") {
        alert('Please select warehouse');
        return false;
    }
    $("#blocker").attr('style', 'display:block;;z-index:10000px;');
    return true;
}

function divHideblocker() {
    $("#blocker").hide();
    $("#blocker").attr('style', 'display:none');

    return false;
}