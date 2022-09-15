using System;
using System.Data ;
using System.Data.SqlClient ;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.Services;
using UserRoleWiseAcess;
using Entity;
using PRSMBAL;
using PRSMDAL;
public partial class Master_ServiceCategory : PageBase
{
    PRSMBAL.MasterBAL objPRSMBAL = new MasterBAL();
    UserRolewiseAcess objUserRoleWiseAcessDAL = new UserRolewiseAcess();
    PageBase objpagebase = new PageBase();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (UserId == 0)
        {
            Response.Redirect("~/User/Login.aspx", false);
        }
        if (!IsPostBack)
        {
            BindServiceCategory();
            hdneditid.Value = "1"; // 1(default ) = Edit ,0 =not edit
            hdnCategoryid.Value = "0";
            SetRolewiseAcessfuncationality();
        }
    }
    protected void clearfield()
    {
        txtSCName.Text = string.Empty;
        txtRemark.Text = string.Empty;
        hdneditid.Value = "1";
        hdnCategoryid.Value = "0";
    }

    protected void BindServiceCategory()
    {
        gdvSearchCategory.DataSource = objPRSMBAL.GetServiceCategory(0);
        gdvSearchCategory.DataBind();

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        //string strNAme=txtSCName.Text.repalce
        ServiceCategory ObjServiceCategory = new ServiceCategory
        {
            
            ServiceCategoryId = Convert.ToByte(hdnCategoryid.Value),
            SCName =txtSCName.Text.Trim(),
            Remark =txtRemark.Text.Trim(),
            IsEdit = Convert.ToByte(hdneditid.Value),
            UserId = UserId
        };
        string sReturnValue = objPRSMBAL.AddUpdateServiceCategory(ObjServiceCategory);
        lblMessage.Visible = true;
        if (sReturnValue == "Record saved successfully.")
        {
            lblMessage.Text = sReturnValue;
            clearfield();
        }
        BindServiceCategory();
        ObjServiceCategory = null;

    }


    protected void gdvSearchCategory_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //Disable link buton when record  is not allow  edit else enable to edit.
            HiddenField hdnEditid = (HiddenField)e.Row.FindControl("hdnEditid");
            LinkButton lnkbtnEdit = (LinkButton)e.Row.FindControl("lnkbtnEdit");
            if (hdnEditid != null)
            {
                if (lnkbtnEdit != null)
                {
                    lnkbtnEdit.OnClientClick = "return  EditCategory(this.id);";
                    lnkbtnEdit.Attributes.Add("style", "color:blue;text-decoration:none;");
                }
                Byte bIsEdit = Convert.ToByte(hdnEditid.Value);
                if (bIsEdit == 0)
                {
                    lnkbtnEdit.OnClientClick = "return false;";
                    lnkbtnEdit.Attributes.Add("style", "cursor:default;color:Gray;text-decoration:none");
                }
            }
        }
    }
    protected void gdvSearchCategory_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gdvSearchCategory.PageIndex = e.NewPageIndex;
        BindServiceCategory();
    }
    #region [Rolewise access page funcationality]
    public void SetRolewiseAcessfuncationality()
    {
        UserRolewiseAcess objUserRoleWiseAcessDAL = new UserRolewiseAcess();
        DataTable dtPageId = objUserRoleWiseAcessDAL.GetApplicationCodeDetails("Page_Name", "Service Category").Tables[0];
        int PageId = 0;
        if (dtPageId.Rows.Count > 0)
        {
            PageId = Convert.ToInt32(dtPageId.Rows[0][0]);
        }
        DataTable dtPagefuncationality = objUserRoleWiseAcessDAL.GetPageFunctionalityByRoleAndPageId(PageId, RoleId).Tables[0];
        btnSave.Visible = false;
        btnCancel.Visible = false;

        if (dtPagefuncationality != null)
        {
            string PageFuncationality = string.Empty;
            for (int i = 0; i < dtPagefuncationality.Rows.Count; i++)
            {
                if (Convert.ToBoolean(dtPagefuncationality.Rows[i]["IsEnableForRole"]))
                {
                    PageFuncationality = Convert.ToString(dtPagefuncationality.Rows[i]["Functionality"]);
                    switch (PageFuncationality)
                    {
                        case "Save":
                            btnSave.Visible = true;
                            break;
                        case "Edit":
                            ViewState["IsEditGrid"] = true;
                            break;
                        case "Clear":
                            btnCancel.Visible = true;
                            break;
                        default:
                            break;
                    }
                }
            }
        }

        disablegrid(Convert.ToBoolean(ViewState["IsEditGrid"]));
    }

    protected void disablegrid(bool IsEditGrid)
    {
        if (gdvSearchCategory.Rows.Count > 0 && IsEditGrid == false)
        {
            for (int i = 0; i < gdvSearchCategory.Rows.Count; i++)
            {
                LinkButton lnkbtnEdit = (LinkButton)gdvSearchCategory.Rows[i].FindControl("lnkbtnEdit");
                if (lnkbtnEdit != null)
                {
                    lnkbtnEdit.Visible = false;
                }
            }
        }
    }
    #endregion

}

