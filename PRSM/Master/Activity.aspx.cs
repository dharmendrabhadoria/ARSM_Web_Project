using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PRSMBAL;
using Entity;
using Utility;
using System.Data;
using UserRoleWiseAcess;
using PRSMBAL;
using PRSMDAL;
public partial class Master_ServiceActivity : PageBase
{
    public PRSMBAL.MasterBAL objPRSMBAL = new MasterBAL();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (UserId == 0)
        {
            Response.Redirect("~/User/Login.aspx", false);
        }
        if (!IsPostBack)
        {
            hdneditid.Value = "1"; // 1(default ) = Edit ,0 =not edit
            hdnActivityId.Value = "0";
            BindServiceCategory();
            BindActivity();           
            SetRolewiseAcessfuncationality();
            ddlServiceCategory.Focus();
        }
    }
    protected void BindServiceCategory()
    {
  
        ddlServiceCategory.DataSource = null;
        ddlServiceCategory.DataBind();
        ddlServiceCategory.DataSource = objPRSMBAL.GetServiceCategory(0);
        ddlServiceCategory.DataValueField = "ServiceCategoryId";
        ddlServiceCategory.DataTextField = "SCName";
        ddlServiceCategory.DataBind();
        ddlServiceCategory.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });



        ddlfiltersearchbyCategory.DataSource = null;
        ddlfiltersearchbyCategory.DataBind();
        ddlfiltersearchbyCategory.DataSource = objPRSMBAL.GetServiceCategory(0);
        ddlfiltersearchbyCategory.DataValueField = "ServiceCategoryId";
        ddlfiltersearchbyCategory.DataTextField = "SCName";
        ddlfiltersearchbyCategory.DataBind();
        ddlfiltersearchbyCategory.Items.Insert(0, new ListItem { Text = "--All--", Value = "0" });
      
    }
    protected void clearfield()
    {
        txtActivityName.Text = string.Empty;
        txtRemark.Text = string.Empty;
        if (ddlServiceCategory.Items.Count > 0)
        {
            ddlServiceCategory.SelectedIndex = 0; 
        }
        hdneditid.Value = "1"; 
        hdnActivityId.Value = "0";
        rbtnUnit.SelectedIndex = 0;
        
    }
    protected void BindActivity()
    {
        List<Activity> lst = objPRSMBAL.GetActivity(0);
        if (lst != null)
        {
            if (lst.Count > 0)
            {

                if (Convert.ToInt16(ddlfiltersearchbyCategory.SelectedItem.Value) != 0)
                {
                    int ISelectedCategory = Convert.ToInt16(ddlfiltersearchbyCategory.SelectedItem.Value);

                    var query =
                                        from order in lst.AsEnumerable()
                                        where order.ServiceCategoryId == ISelectedCategory
                                        select order;
                    gdvActivity.DataSource = query.ToList();
                    gdvActivity.DataBind();
                }
                else
                {
                    gdvActivity.DataSource = lst;
                    gdvActivity.DataBind();
                }
            }
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            Validate();
            Activity ObjActivity = new Activity
            {
                ActivityId = Convert.ToByte(hdnActivityId.Value),
                ServiceCategoryId = Convert.ToInt16(ddlServiceCategory.SelectedItem.Value),
                ActivityName = txtActivityName.Text.Trim(),
                Remark = txtRemark.Text.Trim(),
                IsEdit = Convert.ToByte(hdneditid.Value),
                UserId = UserId,
                Unit=Convert.ToInt32(rbtnUnit.SelectedValue),
                UnitCount=0,
                IsShowinRateCard=0

            };

            lblMessage.Visible = true;
            string sReturnValue = objPRSMBAL.AddUpdateActivity(ObjActivity);           
                lblMessage.Text = sReturnValue;
                clearfield();
            
            BindActivity();
            ObjActivity = null;
        }
        catch (Exception ex)
        {
            lblMessage.Visible = true;
            lblMessage.Text = ex.ToString();
            ErrorHandler.WriteLog(ex);
        }
     
    }
    protected void gdvActivity_RowDataBound(object sender, GridViewRowEventArgs e)
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
                    lnkbtnEdit.OnClientClick = "return  EditActivity(this.id);";
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
    protected void gdvActivity_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
       // lblMessage.Visible = false;
        gdvActivity.PageIndex = e.NewPageIndex;
        BindActivity();
    }

   
    protected void ddlfiltersearchbyCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlfiltersearchbyCategory.SelectedIndex > 0)
        {
            lblMessage.Text = "";
            BindActivity();
        }
        else
        {
            BindActivity();
            // lblMessage.Text = "";
        }
    }
    #region [Rolewise access page funcationality]
    public void SetRolewiseAcessfuncationality()
    {
        UserRolewiseAcess objUserRoleWiseAcessDAL = new UserRolewiseAcess();
        DataTable dtPageId = objUserRoleWiseAcessDAL.GetApplicationCodeDetails("Page_Name", "Activity").Tables[0];
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
        if (gdvActivity.Rows.Count > 0 && IsEditGrid == false)
        {
            for (int i = 0; i < gdvActivity.Rows.Count; i++)
            {
                LinkButton lnkbtnEdit = (LinkButton)gdvActivity.Rows[i].FindControl("lnkbtnEdit");
                if (lnkbtnEdit != null)
                {
                    lnkbtnEdit.Visible = false;
                }
            }
        }
    }
    #endregion

}