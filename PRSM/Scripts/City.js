function validate() {

    if ($('#ContentPlaceHolder1_ddlState').val() == "0") {
        document.getElementById("SpnddlState").innerHTML = "Please Select State.";
        return false;
    }
    if ($('#ContentPlaceHolder1_txtCity').val() == "") {
        document.getElementById("spntxtCity").innerHTML = "Please Enter City.";
        return false;
    }
    return true;
}