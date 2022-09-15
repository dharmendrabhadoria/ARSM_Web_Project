

function BindDates() {
    $(function () {
        $('#ContentPlaceHolder1_txtfromDate').attr('readonly', 'readonly');
        $('#ContentPlaceHolder1_txttodate').attr('readonly', 'readonly');
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


   function Validate() {
    var selectedValues = 0;
    var ErrorMsg = " Following fields are mandatory! \n ";
    var ValResult = true;
    $("[id^='ContentPlaceHolder1_rdlstbtnReport'] input:checked").each(function () {
        selectedValues = $(this).val();
    });
    //alert(selectedValues);
    var CompanyGroup = $('#ContentPlaceHolder1_ddlCompanyGroup').val();
    var CustomerId = $('#ContentPlaceHolder1_ddlCustomer').val();
    if (selectedValues == 2 || selectedValues == 3) {
      
        //alert(CompanyGroup);
        if (CompanyGroup == '0') {
            ErrorMsg += "Please select company group \n ";
            ValResult = false;
        }

        if (CustomerId == '0') {
            ErrorMsg += "Please select customer";
            ValResult = false;
        }

    }  
    else {
        if (CompanyGroup != '0' && CustomerId == '0') {
            alert('Please select customer')
            return false;
        }
    }
    if (ValResult == false) {
        alert(ErrorMsg);
        return false;
    }
    else {
        return validateDate();
    }
    return true;
}
function validateDate() {
    var ErrorMsg = "\t Following fields are mandatory! \n \t\t"
    var ValResult = true;
    var FromDate = $("#ContentPlaceHolder1_txtfromDate");
    var Enddate = $("#ContentPlaceHolder1_txttodate");
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
        if (date1 > date2) {
            ErrorMsg += 'End Date should be greater than From Date.'
            ValResult = false;
        }
    }
    if (ValResult == false) {
        alert(ErrorMsg);
        return false;
    }
    else
        return true;
}