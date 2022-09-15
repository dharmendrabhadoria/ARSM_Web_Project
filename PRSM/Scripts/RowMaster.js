function ValidateNoOfShelf(source, args) {
    var number = $("#ContentPlaceHolder1_txtnoshelf").val();
    if (number >= 8) {
        args.IsValid = false;
    }
    else {
        args.IsValid = true;
    }
}

function ValidateNoOfLocationPerself(source, args) {
    var number = $("#ContentPlaceHolder1_txtNofLocationPerSelf").val();
   if (number >= 999) {
        args.IsValid = false;
    }
    else {
        args.IsValid = true;
    }
}