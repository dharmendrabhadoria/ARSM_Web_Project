
$(document).ready(function () {
    function boxValidate() {

        alert('Box validate')
        return false;
    }
    function validbox() {
        var Res = false;
        alert('Box validate')
        for (i = 0; i < Page_Validators.length; i++) {
            switch (Page_Validators[i].validationGroup) {
                case "SaveGroupboxAdd":
                    ValidatorEnable(Page_Validators[i], true);
                    break;
                default:
                    // your javascript code
                    break;
            }
        }
        if (typeof (Page_ClientValidate) == 'function') {
            Page_ClientValidate('SaveGroupboxAdd');
        }
        if (Page_IsValid) {
            Res = true;
        }


        return Res;
    }
    });
