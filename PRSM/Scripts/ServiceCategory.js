//Servcie Category page validations

/* Enbale/disable page validation function */
function EnableValidationonPage(IsEnable) {
    for (i = 0; i < Page_Validators.length; i++) {

        ValidatorEnable(Page_Validators[i], IsEnable);
    }

}

/*---- Clear field function */
function clearfields() {
       $('#ContentPlaceHolder1_txtSCName').val('');
       $('#ContentPlaceHolder1_txtRemark').val('');
       if ($("#ContentPlaceHolder1_lblMessage") != null) {
           $("#ContentPlaceHolder1_lblMessage").css('display', 'none')
       }
       $('#ContentPlaceHolder1_hdneditid').val("1")
       $('#ContentPlaceHolder1_hdnCategoryid').val("0");
       EnableValidationonPage(false);
}

/* validation on btnclick */
function Validatefields() {
    EnableValidationonPage(true);
    if (typeof (Page_ClientValidate) == 'function') {
        Page_ClientValidate('SaveGroup');
        }

    if (Page_IsValid) {
        return true;
        }
    return false;
}

function EditCategory(Editid) {
    //alert($('#ContentPlaceHolder1_hdneditid').val());
    EnableValidationonPage(false);
    var Editbtn = $("#" + Editid)
    var row_index = parseInt(Editbtn.closest('td').parent()[0].sectionRowIndex)-1;
    var lblName = $("#ContentPlaceHolder1_gdvSearchCategory_lblName_" + row_index);
    var namestr = lblName.text();
    var lblRemark = $("#ContentPlaceHolder1_gdvSearchCategory_lblRemark_" + row_index);
    var remarkStr = lblRemark.text();
    $('#ContentPlaceHolder1_txtSCName').val(namestr);
    $('#ContentPlaceHolder1_txtRemark').val(remarkStr);
    var hdneditid = $("#ContentPlaceHolder1_gdvSearchCategory_hdnEditid_" + row_index);
    $('#ContentPlaceHolder1_hdneditid').val(hdneditid.val())
    var CategoryId = $("#ContentPlaceHolder1_gdvSearchCategory_hdnCategoryid_"+row_index).val();
    $('#ContentPlaceHolder1_hdnCategoryid').val(CategoryId);
    if ($("#ContentPlaceHolder1_lblMessage") != null) {
        $("#ContentPlaceHolder1_lblMessage").css('display', 'none')
    }
    return false; 
}
