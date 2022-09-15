function ValidateNumberOnly() {
    if ((event.keyCode < 48 || event.keyCode > 57)) {
        alert("Please enter only numbers.")
        event.returnValue = false;
    }
}
function ShowdivRack() {
    $('#divRack').show();
    $("#blocker").show();
}
function HidedivRack() {
    $('#divRack').hide();
    $("#blocker").hide();
    EnableValidationonPage(false);
    return false;
}