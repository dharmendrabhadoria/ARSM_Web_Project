
function changesearch(ddlsearch) {
    var Selcddlsearch = $('#'+ddlsearch);
    if (Selcddlsearch.val() == "0") {
        $('#ContentPlaceHolder1_ddlSearchservicestatus').val('0');
        $('#ContentPlaceHolder1_txtSearchFromDate').val('');
        $('#ContentPlaceHolder1_txtSearchToDate').val('');
        $('#ContentPlaceHolder1_txtSearchCustomer').attr('style', 'display:none');
        $('#ContentPlaceHolder1_txtSearchrequestNO').attr('style', 'display:none;float:left; ');
        $('#ContentPlaceHolder1_ddlSearchservicestatus').attr('style', 'display:none;float:left; ');
        $('#ContentPlaceHolder1_txtSearchFromDate').attr('style', 'display:none;float:left; ');
        $('#ContentPlaceHolder1_txtSearchToDate').attr('style', 'display:none;float:left; ');
        $('#lblFromDate').attr('style', 'display:none;float:left;margin:7px');
        $('#lblToDate').attr('style', 'display:none;float:left;margin:7px');
    }
    if (Selcddlsearch.val() == "1") {
        // for request number
        $('#ContentPlaceHolder1_ddlSearchservicestatus').val('0');
        $('#ContentPlaceHolder1_txtSearchFromDate').val('');
        $('#ContentPlaceHolder1_txtSearchToDate').val('');
        $('#ContentPlaceHolder1_txtSearchrequestNO').attr('style', 'display:block;float:left; ');
        $('#ContentPlaceHolder1_txtSearchrequestNO').val("");
        $('#ContentPlaceHolder1_txtSearchCustomer').attr('style', 'display:none');
       $('#ContentPlaceHolder1_txtSearchCustomer').val('');
        $('#ContentPlaceHolder1_ddlSearchservicestatus').attr('style', 'display:none;float:left; ');
        $('#ContentPlaceHolder1_txtSearchFromDate').attr('style', 'display:none;float:left; ');
        $('#ContentPlaceHolder1_txtSearchToDate').attr('style', 'display:none;float:left; ');
        $('#lblFromDate').attr('style', 'display:none;float:left;margin:7px');
        $('#lblToDate').attr('style', 'display:none;float:left;margin:7px');
        }
    if (Selcddlsearch.val() == "2") {
        // for Date 
           $('#ContentPlaceHolder1_ddlSearchservicestatus').val('0');
           $('#ContentPlaceHolder1_txtSearchCustomer').attr('style', 'display:none');
           $('#ContentPlaceHolder1_txtSearchrequestNO').attr('style', 'display:none');
            $('#ContentPlaceHolder1_ddlSearchservicestatus').attr('style', 'display:none');
            $('#ContentPlaceHolder1_txtSearchFromDate').attr('style', 'display:block;float:left; ');
            $('#ContentPlaceHolder1_txtSearchToDate').attr('style', 'display:block;float:left; ');
            $('#lblFromDate').attr('style', 'display:block;float:left;margin:7px');
            $('#lblToDate').attr('style', 'display:block;float:left;margin:7px');

        }

        if (Selcddlsearch.val() == "3") {
            // for status 
            $('#ContentPlaceHolder1_txtSearchFromDate').val('');
            $('#ContentPlaceHolder1_txtSearchToDate').val('');
            $('#ContentPlaceHolder1_ddlSearchservicestatus').attr('style', 'display:block;float:left; ');
            $('#ContentPlaceHolder1_txtSearchCustomer').attr('style', 'display:none');
            $('#ContentPlaceHolder1_txtSearchrequestNO').attr('style', 'display:none');
            $('#ContentPlaceHolder1_txtSearchFromDate').attr('style', 'display:none');
            $('#ContentPlaceHolder1_txtSearchToDate').attr('style', 'display:none');
            $('#lblFromDate').attr('style', 'display:none');
            $('#lblToDate').attr('style', 'display:none');

        }

        if (Selcddlsearch.val() == "4") {
            // for customer 
            $('#ContentPlaceHolder1_ddlSearchservicestatus').val('0');
            $('#ContentPlaceHolder1_txtSearchFromDate').val('');
            $('#ContentPlaceHolder1_txtSearchToDate').val('');
            $('#ContentPlaceHolder1_txtSearchrequestNO').attr('style', 'display:none');
            $('#ContentPlaceHolder1_txtSearchCustomer').attr('style', 'display:block');
            $('#ContentPlaceHolder1_txtSearchrequestNO').val('');
            $('#ContentPlaceHolder1_ddlSearchservicestatus').attr('style', 'display:none;float:left; ');
            $('#ContentPlaceHolder1_txtSearchFromDate').attr('style', 'display:none');
            $('#ContentPlaceHolder1_txtSearchToDate').attr('style', 'display:none');
            $('#lblFromDate').attr('style', 'display:none');
            $('#lblToDate').attr('style', 'display:none');

        }
    }

    function validate()
     {

                var FDate = $('#ContentPlaceHolder1_txtSearchFromDate').val();
                var TDate = $('#ContentPlaceHolder1_txtSearchToDate').val();
                var CustId=$('#ContentPlaceHolder1_txtSearchCustomer').val();
                var RequestId = $('#ContentPlaceHolder1_txtSearchrequestNO').val();
                var status = $('#ContentPlaceHolder1_ddlSearchservicestatus').val();
                var Request = $('#ContentPlaceHolder1_ddlSearchRequestby').val();

                    if (FDate == '' && Request ==2) {
                    alert("Please Enter From Date.");
                    return false;
                    }
                    if (TDate == '' && Request == 2) {
                        alert("Please Enter To Date.");
                        return false;
                    }
                    if (CustId == '' && RequestId == '' && Request == 1) {
                    alert("Please enter work order number.");
                    return false;
                    }
                    if (CustId == '' && RequestId == '' && Request == 4) {
                        alert("Please enter customer name.");
                    return false;
                }
                if (status==0 && Request == 3) {
                    alert("Please select  at least one option.");
                    return false;
                }
                var dt1 = parseInt(FDate.substring(0, 2), 10);
                var mon1 = parseInt(FDate.substring(3, 5), 10);
                var yr1 = parseInt(FDate.substring(6, 10), 10);
                var dt2 = parseInt(TDate.substring(0, 2), 10);
                var mon2 = parseInt(TDate.substring(3, 5), 10);
                var yr2 = parseInt(TDate.substring(6, 10), 10);
                var date1 = new Date(yr1, mon1, dt1);
                var date2 = new Date(yr2, mon2, dt2);
                if (date1 >= date2) {
                    alert("To Date should be greater than From date.");
                    return false;
                }

            return true;
          }
           

    function autocompOnRequest(txtid) {
        var txtCompanygroup = $("#" + txtid);
        if (txtCompanygroup.val() != '') {
            $.ajax({
                url: 'Request.aspx/GetRequestNumber',
                data: "{ 'prefix': '" + txtCompanygroup.val() + "'}",
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
                            $('#ContentPlaceHolder1_selectedValue').val(item.value);
                            $('#ContentPlaceHolder1_txtSearchrequestNO1').val('');
                        }))
                    }
                    else {
                        response([{ label: 'No results found.', val: -1}]);
                        $('#ContentPlaceHolder1_txtSearchrequestNO').val('');
                    }
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
    }


    function BindRequest() {
        $(document).ready(function () {
            $("[id*=ContentPlaceHolder1_txtSearchrequestNO121212121]").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: 'Request.aspx/GetRequestNumber',
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
                           
                                    $('#ContentPlaceHolder1_hdnSearcheSrequestId').val(item.value);
                                    $('#ContentPlaceHolder1_txtSearchrequestNO').val('');
                                }))
                            }

                            else
                            {
                                response([{ label: 'No results found.', val: -1}]);
                                $('#ContentPlaceHolder1_txtSearchrequestNO').val('');
                            }
                        }
                    });
                },
                select: function (e, u) {
                    if (u.item.val == -1) {
                        return false;
                    }
                    else
                     {
                        $('#ContentPlaceHolder1_hdnSearcheSrequestId').val(u.item.val);

                    }
                }
            });
        });
    }

    function autocompOnCustomer(txtid) {
        var txtCustomer = $("#" + txtid);
        if (txtCustomer.val() != '') {
            $.ajax({
                url: 'Request.aspx/GetCustomer',
                data: "{ 'prefix': '" + txtCustomer.val() + "'}",
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
                         
                            $('#ContentPlaceHolder1_hdnSearchCustId').val(item.value);
                            $('#ContentPlaceHolder1_txtSearchCustomer').val('');
                        }))
                    }
                    else
                     {
                        response([{ label: 'No results found.', val: -1}]);
                        $('#ContentPlaceHolder1_txtSearchCustomer').val('');
                    }
                },
                select: function (e, u) {
                    if (u.item.val == -1) {

                        return false;
                    }
                    else
                     {
                        $('#ContentPlaceHolder1_hdnSearchCustId').val(item.value);
                    }
                }
            });
        }
    }


    function BindCustomer() {
        $(document).ready(function () {
            $("[id*=ContentPlaceHolder1_txtSearchCustomer1212]").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: 'Request.aspx/GetCustomer',
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
                  
                                    $('#ContentPlaceHolder1_hdnSearchCustId').val(item.value);
                                    $('#ContentPlaceHolder1_txtSearchCustomer').val('');
                                }))
                            }
                            else 
                             {
                                response([{ label: 'No results found.', val: -1}]);
                                $('#ContentPlaceHolder1_txtSearchCustomer').val('');
                            }
                        }
                    });
                },
                select: function (e, u) {
                    if (u.item.val == -1) {
                        return false;
                    }
                    else
                     {
                        $('#ContentPlaceHolder1_hdnSearchCustId').val(u.item.val);

                    }
                }
            });
        });
    }


    function bindDatevents() {
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



