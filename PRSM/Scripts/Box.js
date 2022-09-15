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


    $(document).ready(function () {
        $("[id*=ContentPlaceHolder1_txtSeachFrom]").autocomplete({
            source: function (request, response) {
                $.ajax({
                    url: 'Box.aspx/GetBox',
                    data: "{ 'Searchfield': '" + request.term + "'}",
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
                                $('#ContentPlaceHolder1_hdnFromSearch').val(item.value);
                            }))
                        } else {
                            response([{ label: 'No results found.', val: -1}]);
                            //$('#GetCustomerOnSameGrpName').val('');
                        }
                    }
                });
            },
            select: function (e, u) {
                if (u.item.val == -1) {
                    return false;
                }
                else {
                    $('#ContentPlaceHolder1_hdnFromSearch').val(u.item.val);

                }
            }
        });
    });


    $(document).ready(function () {
        $("[id*=ContentPlaceHolder1_txtSearchTo]").autocomplete({
            source: function (request, response) {
                $.ajax({
                    url: 'Box.aspx/GetBox',
                    data: "{ 'Searchfield': '" + request.term + "'}",
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
                                $('#ContentPlaceHolder1_hdnTosearch').val(item.value);
                            }))
                        } else {
                            response([{ label: 'No results found.', val: -1}]);
                            //$('#GetCustomerOnSameGrpName').val('');
                        }
                    }
                });
            },
            select: function (e, u) {
                if (u.item.val == -1) {
                    return false;
                }
                else {
                    $('#ContentPlaceHolder1_hdnTosearch').val(u.item.val);

                }
            }
        });
    });

