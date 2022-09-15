using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PRSMBAL;
using Entity;
using UserRoleWiseAcess;
using System.Data;
using System.Drawing;

public partial class Master_City : PageBase
{
    MasterBAL objPRSMBAL = new MasterBAL();

    #region Private Properties
    public int CurrentPage
    {

        get
        {
            if (this.ViewState["CurrentPage"] == null)
                return 0;
            else
                return Convert.ToInt16(this.ViewState["CurrentPage"].ToString());
        }

        set
        {
            this.ViewState["CurrentPage"] = value;
        }

    }
    private int fistIndex
    {
        get
        {
            int _FirstIndex = 0;
            if (ViewState["_FirstIndex"] == null)
            {
                _FirstIndex = 0;
            }
            else
            {
                _FirstIndex = Convert.ToInt32(ViewState["_FirstIndex"]);
            }
            return _FirstIndex;
        }
        set { ViewState["_FirstIndex"] = value; }
    }
    private int lastIndex
    {
        get
        {
            int _LastIndex = 0;
            if (ViewState["_LastIndex"] == null)
            {
                _LastIndex = 0;
            }
            else
            {
                _LastIndex = Convert.ToInt32(ViewState["_LastIndex"]);
            }
            return _LastIndex;
        }
        set { ViewState["_LastIndex"] = value; }
    }
    #endregion
    #region PagedDataSource
    PagedDataSource pds = new PagedDataSource();
    #endregion
    protected void Page_Load(object sender, EventArgs e)
    {
        if (UserId == 0)
            Response.Redirect("~/User/Login.aspx");

        if (!IsPostBack)
        {
            ViewState["CityId"] = "0";
            BindState();
            Bindgrid(0);
            SetRolewiseAcessfuncationality();
        }
        lblMessage.Text = "";
    }

    private void doPaging()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("PageIndex");
        dt.Columns.Add("PageText");
        if (dlistcity.Items.Count > 0)
        {
            for (int i = 0; i < pds.PageCount; i++)
            {
                DataRow dr = dt.NewRow();
                dr[0] = i;
                dr[1] = i + 1;
                dt.Rows.Add(dr);
            }
        }

        dlPaging.DataSource = dt;
        dlPaging.DataBind();
    }
    protected void BindState()
    {
        ddlState.DataSource = objPRSMBAL.GetState(0);
        ddlState.DataTextField = "StateName";
        ddlState.DataValueField = "StateId";
        ddlState.DataBind();
        ddlState.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        lblMessage.Text = "";
    }

    protected void Bindgrid(Int16 stateId)
    {
        DataTable dt = objPRSMBAL.GetCity(stateId).Tables[0];
        pds.DataSource = dt.DefaultView;
        pds.AllowPaging = true;
        pds.PageSize = Convert.ToInt16(hfPagesize.Value);
        pds.CurrentPageIndex = CurrentPage;

        dlistcity.DataSource = pds;
        dlistcity.DataBind();

        doPaging();
    }
    protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtCity.Text = "";
        Int16 iStateid = 0;
        if (ddlState.SelectedIndex > 0)
        {
            iStateid = Convert.ToInt16(ddlState.SelectedItem.Value);
        }
        Bindgrid(iStateid);
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        int CityId = Convert.ToInt32(ViewState["CityId"]);
        string CityName = txtCity.Text.ToString().Trim();

        if (ddlState.SelectedIndex > 0)
        {
            Int16 ChekCityMasterExist = objPRSMBAL.IsCityMasterExist(CityId,CityName,Convert.ToInt32(ddlState.SelectedValue));

            //Isdisplaymsg(true);
            if (ChekCityMasterExist == 2)
            {
                string Msg = "City Id already used by another user. ";
                lblMessage.Text = Msg;
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            objPRSMBAL.AddUpdateCityMaster(new City
            {
                CityId = Convert.ToInt32(ViewState["CityId"]),
                CityName = txtCity.Text,
                StateId = Convert.ToInt32(ddlState.SelectedValue),
                UserId = UserId,
            });
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('Record Saved Successfully.');", true);
            Reset();
            Int16 iStateid = 0;
            if (ddlState.SelectedIndex > 0)
            {
                iStateid = Convert.ToInt16(ddlState.SelectedItem.Value);
            }
            Bindgrid(iStateid);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Reset();
        Int16 iStateid = 0;
        if (ddlState.SelectedIndex > 0)
        {
            iStateid = Convert.ToInt16(ddlState.SelectedItem.Value);
        }
        Bindgrid(iStateid);
    }
    private void Reset()
    {
        txtCity.Text = "";
        ddlState.SelectedIndex = 0;
        ViewState["CityId"] = "0";
        Bindgrid(0);
    }
    protected void dlistcity_ItemCommand(object source, DataListCommandEventArgs e)
    {
        if (e.CommandName == "Select")
        {
            //ViewState["CityId"] = UserId;
            DataListItem gr = (DataListItem)(((LinkButton)e.CommandSource).NamingContainer);
            ddlState.SelectedValue = ((HiddenField)gr.FindControl("hdnStateId")).Value;
            txtCity.Text = ((Label)gr.FindControl("lblCityName")).Text;
            ViewState["CityId"] = ((HiddenField)gr.FindControl("hdnCityId")).Value;
        }
    }

    protected void dlPaging_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        LinkButton lnkbtnPage = (LinkButton)e.Item.FindControl("lnkbtnPaging");
        if (lnkbtnPage.CommandArgument.ToString() == CurrentPage.ToString())
        {
            lnkbtnPage.Enabled = false;
            lnkbtnPage.Font.Bold = true;
        }
    }
    protected void dlPaging_ItemCommand1(object source, DataListCommandEventArgs e)
    {
        if (e.CommandName.Equals("lnkbtnPaging"))
        {
            CurrentPage = Convert.ToInt16(e.CommandArgument.ToString());
            Int16 iStateid = 0;
            if (ddlState.SelectedIndex > 0)
            {
                iStateid = Convert.ToInt16(ddlState.SelectedItem.Value);
            }
            Bindgrid(iStateid);
        }
    }
    #region [Rolewise access page funcationality]
    public void SetRolewiseAcessfuncationality()
    {
        UserRolewiseAcess objUserRoleWiseAcessDAL = new UserRolewiseAcess();
        DataTable dtPageId = objUserRoleWiseAcessDAL.GetApplicationCodeDetails("Page_Name", "City").Tables[0];
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
        if (dlistcity.Items.Count > 0 && IsEditGrid == false)
        {
            for (int i = 0; i < dlistcity.Items.Count; i++)
            {

                LinkButton lnkbtnEdit = (LinkButton)dlistcity.Items[i].FindControl("lnkbtnEdit");
                if (lnkbtnEdit != null)
                {
                    lnkbtnEdit.Visible = false;
                }
            }
        }
    }
    #endregion
}