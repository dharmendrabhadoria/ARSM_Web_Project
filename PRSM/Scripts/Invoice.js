$(document).ready(function () {
    $('#ContentPlaceHolder1_chkBoxstatusAll').click(function (event) {  //on click 
        if (this.checked) { // check select status
            $('*:checkbox').each(function () { //loop through each checkbox
                this.checked = true;  //select all checkboxes with class "checkbox1"               
            });
        } else {
            $('*:checkbox').each(function () { //loop through each checkbox
                this.checked = false; //deselect all checkboxes with class "checkbox1"                       
            });
        }
    });
    $("[id^='ContentPlaceHolder1_chklstCustomer'] input").bind("click", function () {
        if ($("[id^='ContentPlaceHolder1_chklstCustomer'] input:checked").length == $("[id^='ContentPlaceHolder1_chklstCustomer'] input").length) {
            //$("#ContentPlaceHolder1_chkall").attr("checked", "checked");
            $("[id*=ContentPlaceHolder1_chklstCustomer]").attr("checked", "checked");

            this.checked = true;
            //  alert('b')
        } else {
            //  $("#ContentPlaceHolder1_chkall").removeAttr("checked");
            $('#ContentPlaceHolder1_chkBoxstatusAll').removeAttr("checked");
            // alert($('#ContentPlaceHolder1_chkall'));
            //  alert('A')
        }
    });
});

function onlyonedot(ids, evv,lesthan) {
    var e = event || evt;
    var charCode = e.which || e.keyCode;
    var curchar = String.fromCharCode(charCode);
    var mainstring = $("#" + ids).val();
    //alert($("#" + ids).val());
    if (mainstring.indexOf('.') > -1) {
        if (mainstring.split('.').length > 2) {
            //  var strm = mainstring.split('.');
            alert(mainstring);
            alert(mainstring.indexOf('.'));
            var strval = mainstring.substring(0, parseInt(mainstring.lastIndexOf('.')));
            //  alert("After" + strval);
            $("#" + ids).val(strval);
            return false;
        }
    }
    
        if (lesthan == true) {
            if (parseInt($("#" + ids).val()) >=100) {
                $("#" + ids).val("99");
                return false; 
            }
       
    }

}


  $(document).ready(function () {
    $('#ContentPlaceHolder1_grdCustomer_chkBoxstatusAll').click(function (event) {  //on click 
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


    $("#ContentPlaceHolder1_grdCustomer input[type=checkbox]").bind("click", function () {
        CheckSelectAll();
    });
    function CheckSelectAll() {
        var flag = true;
        $("[id^='ContentPlaceHolder1_grdCustomer_chkstatus_']").each(function () {
           // alert(this.id);
            if (this.checked == false)
                flag = false;
        });
        if (flag == true) {
            $("#ContentPlaceHolder1_grdCustomer_chkBoxstatusAll").prop("checked", true);
        }
        else {
            $("#ContentPlaceHolder1_grdCustomer_chkBoxstatusAll").prop("checked", false);
        }
    }
});


function divShowResult() {
   // alert('A');
    $('#divShowResult').show();
    $("#blocker").attr('style', 'display:block');
    $("#divShowResult").attr('style', 'display:block;width: 400px;height:20px !imp;');
    return false;
}

function HidedivShowResult() {

    $('#divShowResult').hide();
    $("#divShowResult").attr('style', 'display:none');
    $("#blocker").attr('style', 'display:none');

}

function validateInvoice() {

    var Res = false;
    var ErrorMsg = "\t Following fields are mandatory! \n \t\t"
    var ValResult = true;

    if ($("#ContentPlaceHolder1_ddlWareHouse").val() == "0") {
        ErrorMsg += " WareHouse \n \t\t";
        ValResult = false;
    }

    if ($("#ContentPlaceHolder1_ddlYear").val() == "0") {
        ErrorMsg += " Year \n \t\t";
        ValResult = false;
    }

    if ($("#ContentPlaceHolder1_ddlMonth").val() == "0") {
        ErrorMsg += " Month \n \t\t ";
        ValResult = false;
    }
    if (ValResult == false) {
        alert(ErrorMsg);
        return false;
    }

    Res = checkCustomer();

    if (Res == true) {
        Res = confirm('Are you sure to continue?');
    }
    return Res;

}

function checkCustomer() {
    var totalbox = $("[id^='ContentPlaceHolder1_grdCustomer_chkstatus_']").length;
   // alert(totalbox);
    if (totalbox > 0) {
        var length = $("[id^='ContentPlaceHolder1_grdCustomer_chkstatus_']:checked").length;
        if (length > 0) {
            return true;
        }
        else {
            alert('Please Select Customer');
            return false;
        }
    }
    else {
        alert('Please Select Customer');
        return false;
    }

}