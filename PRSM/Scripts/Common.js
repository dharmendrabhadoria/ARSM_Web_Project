function textboxMultilineMaxNumber(txtid, maxLen) {
    try {
        var strvalue = $('#'+txtid).val();
        if (strvalue.length > maxLen) {
            $('#' + txtid).val(strvalue.substring(0, parseInt(maxLen)))
        }

    } catch (e) {
    }
}

function ToupperFun(obj) {
    obj.value = obj.value.toUpperCase();

}

function trim() {
    return this.replace(/^\s+|\s+$/g, '');
}

$(document).ready(function () {
    $("#loading-div-background").css({ opacity: 0.8 });

});

function ShowProgressAnimation() {
    $("#loading-div-background").show();
}
function HideProgressAnimation() {
    $("#loading-div-background").hide();
}
