//Rack  page validations

/* Enbale/disable page validation function */
function EnableValidationonPage(IsEnable) {
    $(document).ready(function () {
        for (i = 0; i < Page_Validators.length; i++) {
            ValidatorEnable(Page_Validators[i], IsEnable);
        }
    });
}

function clearfields() {
  //  EnableValidationonPage(false);
    if ($("#ContentPlaceHolder1_lblMessageRack") != null) {
        $("#ContentPlaceHolder1_lblMessageRack").css('display', 'none')
    }
    $('#ContentPlaceHolder1_txtrackName').val('')
    $('#ContentPlaceHolder1_ddlWareHouse').val('0');
    $('#ContentPlaceHolder1_txtrowName').val('');
    $('#ContentPlaceHolder1_txtNoofRacks').val('');
    $('#ContentPlaceHolder1_txtTotalboxes').val('');         
    $('#ContentPlaceHolder1_txtnoshelf').val('')
    $('#ContentPlaceHolder1_txttotalboxpershelf').val('')  
    $('#ContentPlaceHolder1_txtBoxEndNo').val('')
    $('#ContentPlaceHolder1_txtRemark').val('')
    $('#ContentPlaceHolder1_txtHeight').val('')
    $('#ContentPlaceHolder1_txtDepth').val('')
    $('#ContentPlaceHolder1_txtwidth').val('')
    $('#ContentPlaceHolder1_lblMessageRack').innerhtml = '';
    $('#ContentPlaceHolder1_lblMessage').innerhtml = '';
    $('#ContentPlaceHolder1_txtRowId').val('')
    $('#ContentPlaceHolder1_txtboxStartNo').val('')
    return true ;
}

/* validation on btnclick */
function Validatefields()
 {
//        var Res = false;
//        Res = confirm('Are you sure to continue?');
//        return Res;
  }

  function GetBoxEndNoOnNoShelf(obj1) {
      var NoofRacks = 0 ;
      if ($.trim($("#ContentPlaceHolder1_txtNoofRacks").val()) != "") {
          NoofRacks = parseInt($("#ContentPlaceHolder1_txtNoofRacks").val());
      }
    var BoxPerShell = $("#ContentPlaceHolder1_txttotalboxpershelf").val();
    var BoxStartNo = $("#ContentPlaceHolder1_txtboxStartNo").val();
    if (obj1 == '' || BoxPerShell == '' || BoxStartNo == '') {
        $("#ContentPlaceHolder1_txtBoxEndNo").val('');
    }
    else if (obj1 == '0' || BoxPerShell == '0' || BoxStartNo == '0') {
    return false;
    }
    else {
        var BoxEndNo = parseInt(obj1 * BoxPerShell) + parseInt(BoxStartNo);
        var nBoxEndNo = $("#ContentPlaceHolder1_txtBoxEndNo").val(BoxEndNo - 1);

    }
    $("#ContentPlaceHolder1_txtTotalboxes").val($("#ContentPlaceHolder1_txtBoxEndNo").val());
}

function GetBoxEndNoOnTotalBoxPerShelf(obj2) {
    var ShellNo = $("#ContentPlaceHolder1_txtnoshelf").val();
    var BoxStartNo = $("#ContentPlaceHolder1_txtboxStartNo").val();

    if (obj2 == '' || ShellNo == '' || BoxStartNo == '') {
        $("#ContentPlaceHolder1_txtBoxEndNo").val('');
    }
    else if (obj2 == '0' || ShellNo == '0' || BoxStartNo == '0') {
        $("#ContentPlaceHolder1_txtBoxEndNo").val('');
    }
    else {
        var BoxEndNo = parseInt(obj2 * ShellNo) + parseInt(BoxStartNo);
        var nBoxEndNo = $("#ContentPlaceHolder1_txtBoxEndNo").val(BoxEndNo - 1);

    }
    $("#ContentPlaceHolder1_txtTotalboxes").val($("#ContentPlaceHolder1_txtBoxEndNo").val());
}

function GetBoxEndNo(obj) {
    //  alert('A');
    var warehouse = $.trim($("#ContentPlaceHolder1_ddlWareHouse").val());
    if( warehouse == "0") {
        obj.value = "";
        alert('Select Warehouse');
      return false; 
    }
    var ShellNo = $.trim($("#ContentPlaceHolder1_txtnoshelf").val());
    var BoxPerShell =$.trim( $("#ContentPlaceHolder1_txttotalboxpershelf").val());
    var NoofRacks = $.trim($("#ContentPlaceHolder1_txtNoofRacks").val())
    var BoxStartNo = $("#ContentPlaceHolder1_txtboxStartNo").val();
    if (NoofRacks == '' || ShellNo == '' || BoxPerShell == '') {
        $("#ContentPlaceHolder1_txtBoxEndNo").val('');
    }
    else if (NoofRacks == '0' || ShellNo == '0' || BoxPerShell == '0') {
        $("#ContentPlaceHolder1_txtBoxEndNo").val('');
    }
    else {
        //alert(NoofRacks);
        //alert(ShellNo);
        //alert(BoxPerShell);
        var TotalshelfinRows = 0;
        TotalshelfinRows = parseInt(NoofRacks) * parseInt(ShellNo)
        TotalshelfinRows = TotalshelfinRows * parseInt(BoxPerShell)
        //alert(TotalshelfinRows);
        //alert(BoxStartNo);
        var EndNo = 0;
        EndNo = parseInt(BoxStartNo) + TotalshelfinRows;
        EndNo = EndNo -1
        //alert(EndNo);
        var BoxEndNo = TotalshelfinRows + parseInt(BoxStartNo);
        var nBoxEndNo = $("#ContentPlaceHolder1_txtBoxEndNo").val(EndNo);
    }
    $("#ContentPlaceHolder1_txtTotalboxes").val(TotalshelfinRows);
}










function ValdEvenZeroAtBegining(key) {
    var t = key.t ? key.t : key.srcElement;
    var keycode = (key.which) ? key.which : key.keyCode;
    if (keycode == 48 && t.value.length == 0) {
        return false;
    }
    else if (keycode > 31 && (keycode < 48 || keycode > 57)) {
        return false;
    }
    else
        return true;
}

function onlyonedot(ids, evv, lesthan) {
    var e = event || evt;
    var charCode = e.which || e.keyCode;
    var curchar = String.fromCharCode(charCode);
    var mainstring = $("#" + ids).val();
    if (mainstring.indexOf('.') > -1) {
        if (mainstring.split('.').length > 2) {
            var strval = mainstring.substring(0, parseInt(mainstring.lastIndexOf('.')));
            $("#" + ids).val(strval);
            return false;
        }
    }

    if (lesthan == true) {
        if (parseInt($("#" + ids).val()) >= 100) {
            $("#" + ids).val("99");
            return false;
        }

    }

}

