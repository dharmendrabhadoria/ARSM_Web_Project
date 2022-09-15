using System;
using System.Data ;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UserRoleWiseAcess;
using PRSMDAL;

public partial class Users_UsersRights : PageBase
{  
    
    UserRolewiseAcess objUserRoleWiseAcessDAL = new UserRolewiseAcess();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
           
            BindRole();
           //Get all Pages 
            BindPages();
        }
    }
    protected void grdPageaccess_RowDataBound(object sender, GridViewRowEventArgs e)
    {
      
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField hdnPageId = (HiddenField)e.Row.FindControl("hdnPageId");
            DataList dtlistfunctionality = (DataList)e.Row.FindControl("dtlistfunctionality");
            if (hdnPageId != null)
            {
                int RoleId = 0;
                int pageid = 0;
                if (ddlRole.SelectedIndex > 0)
                {
                    RoleId = Convert.ToInt32(ddlRole.SelectedValue);  
                }
                pageid = Convert.ToInt32(hdnPageId.Value);
                DataTable dtpagefuncationalitybyRole = new DataTable();
                //Get Page funcationality by role
                dtpagefuncationalitybyRole = objUserRoleWiseAcessDAL.GetPageFunctionalityByRoleAndPageId(pageid, RoleId).Tables[0] ;
                if (dtpagefuncationalitybyRole.Rows.Count > 0)
                {
                    if (dtpagefuncationalitybyRole != null)
                    {
                        if (dtpagefuncationalitybyRole.Rows.Count > 0)
                        {
                            dtlistfunctionality.DataSource = dtpagefuncationalitybyRole;
                            dtlistfunctionality.DataBind();
                        }
                        else
                        {
                            if (ddlRole.SelectedIndex > 0)
                            {
                                e.Row.Visible = false;
                            }
                        }
                    }
                    else
                    {
                        if (ddlRole.SelectedIndex > 0)
                        {
                            e.Row.Visible = false;
                        }
                    }
                }
                else
                {
                    //For first time if funcationality not added in rolewise access table.
                    DataTable dtpagefuncationalitybypageid = objUserRoleWiseAcessDAL.GetPageFuncationality(0, pageid).Tables[0] ;
                    dtpagefuncationalitybypageid.Columns.Add("IsEnableForRole", typeof(bool));
                    //dtpagefuncationalitybypageid.Columns["IsEnableForRole"].DefaultValue = false;   
                    dtpagefuncationalitybypageid.AcceptChanges();
                    if (dtpagefuncationalitybypageid.Rows.Count > 0)
                    {
                        foreach (DataRow row in dtpagefuncationalitybypageid.Rows)
                        {
                            row["IsEnableForRole"] = false;
                        }
                        dtpagefuncationalitybypageid.AcceptChanges();
                        dtlistfunctionality.DataSource = dtpagefuncationalitybypageid;
                        dtlistfunctionality.DataBind();
                    }
                    else
                    {
                           e.Row.Visible = false;
                    }
                }
            }
        }
    }
    public void BindPages()
    {
        grdPageaccess.DataSource = null;
        grdPageaccess.DataBind(); 
        DataTable dtPageNames = objUserRoleWiseAcessDAL.GetApplicationCodeDetails("PAGE_NAME",string.Empty).Tables[0];
        grdPageaccess.DataSource = dtPageNames;
        grdPageaccess.DataBind();
      
        for (int i = 0; i < grdPageaccess.Rows.Count ; i++)
        {
            DataList dtlistfunctionality = (DataList)grdPageaccess.Rows[i].FindControl("dtlistfunctionality");
            bool Ischk = true;
            for (int j = 0; j < dtlistfunctionality.Items.Count; j++)
            {
                CheckBox chkIsEnable = (CheckBox)dtlistfunctionality.Items[j].FindControl("chkIsEnable");
                CheckBox chkRowise = (CheckBox)grdPageaccess.Rows[i].FindControl("chkRowise");

                if (chkIsEnable != null)
                {
                    if(!chkIsEnable.Checked)
                    {
                            Ischk = false;
                    }
                    string strrowiseid = "null";
                    if (chkRowise != null)
                    {
                        strrowiseid = chkRowise.ClientID;
                    }
                    //call function from javascript for enable/disable all check and row wise all 
                    string clientfunction = "javascript:disablechk('" + dtlistfunctionality.ClientID + "','" + strrowiseid + "')";
                    chkIsEnable.Attributes.Add("onclick", clientfunction);
                }
                if (chkRowise != null)
                {
                    chkRowise.Checked = Ischk;
                }
            }
        }
    }
    public void BindRole()
    {
        ddlRole.Items.Clear();  
        ddlRole.DataSource = null;
        ddlRole.DataBind();
        DataSet ds = objUserRoleWiseAcessDAL.GetApplicationCodeDetails("ROLE",string.Empty );
        ddlRole.DataSource = ds.Tables[0];
        ddlRole.DataValueField = "AppCodeId";
        ddlRole.DataTextField = "AppCodeName";
        ddlRole.DataBind();
        ddlRole.Items.Insert(0, "--Select--");  
    }

    protected void ddlRole_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindPages();
        Page page = HttpContext.Current.CurrentHandler as Page;
        page.ClientScript.RegisterStartupScript(typeof(Page), "Script", "<script language='javascript'>GridviewCheck();  </script>");
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        dt.TableName = "Root";
        dt.Columns.Add("n_RoleId", typeof(int));
        dt.Columns.Add("n_PageFunctionId", typeof(int));
        dt.Columns.Add("n_Enable", typeof(byte));
        dt.AcceptChanges();
        int RoleId = 0;
        if (ddlRole.SelectedIndex > 0)
          {
           RoleId = Convert.ToInt32(ddlRole.SelectedValue);  
          }

        for (int i = 0; i < grdPageaccess.Rows.Count; i++)
		    {
                HiddenField hdnPageId = (HiddenField)grdPageaccess.Rows[i].FindControl("hdnPageId");
                DataList dtlistfunctionality = (DataList)grdPageaccess.Rows[i].FindControl("dtlistfunctionality");
                if (dtlistfunctionality != null)
                {
                 for (int j = 0; j <  dtlistfunctionality.Items.Count  ; j++)
		           {
                        int pagefunctionid = 0;
                        byte isEnable = 0;
                        HiddenField hdnPageFunctionId = (HiddenField)dtlistfunctionality.Items[j].FindControl("hdnPageFunctionId");
                        if (hdnPageFunctionId != null)
                        {
                            pagefunctionid = Convert.ToInt32(hdnPageFunctionId.Value);  
                        }
                        CheckBox chkIsEnable = (CheckBox)dtlistfunctionality.Items[j].FindControl("chkIsEnable");
                        if (chkIsEnable != null)
                        {
                            if (chkIsEnable.Checked)
                            {
                                isEnable = 1;
                            }
                       }
                        DataRow dr = dt.NewRow();
                        dr["n_RoleId"] = RoleId;
                        dr["n_PageFunctionId"] = pagefunctionid;
                        dr["n_Enable"] = isEnable;
                        dt.Rows.Add(dr);
                        dt.AcceptChanges();
		        }
              }
		    }
         DataSet ds = new DataSet();
         ds.Tables.Add(dt);
         string xmlgetdata = ds.GetXml();
         objUserRoleWiseAcessDAL.InsertUpdateRoleWiseAccess(RoleId, xmlgetdata);
         BindPages();
         Page page = HttpContext.Current.CurrentHandler as Page;
         page.ClientScript.RegisterStartupScript(typeof(Page), "Script", "<script language='javascript'>alert('Record saved successfully.');  window.location = window.location; </script>");

      }

    public string GetclickRowfunction(object ItemId)
    {
        string GetclickRowfunction = "disablechk(" + Convert.ToInt32(ItemId) + ");";
        return GetclickRowfunction;
    }
    protected void dtlistfunctionality_ItemDataBound(object sender, DataListItemEventArgs e)
    {

        if (e.Item.ItemType == ListItemType.Item)
        {
            DataList dtlistfunctionality = (DataList)sender;
            GridViewRow gvMasterRow = (GridViewRow)dtlistfunctionality.Parent.Parent;
            if (dtlistfunctionality != null)
            {
                foreach (DataListItem  item in dtlistfunctionality.Items)
                {
                        CheckBox chkIsEnable = (CheckBox)item.FindControl("chkIsEnable");
                        if (chkIsEnable != null)
                        {
                            CheckBox chkRowise = (CheckBox)gvMasterRow.FindControl("chkRowise");
                            string strrowiseid = "null";
                            if (chkRowise != null)
                            {
                                strrowiseid = chkRowise.ClientID;
                            }
                            //call function from javascript for enable/disable all check and row wise all 
                            string clientfunction = "javascript:disablechk('" + dtlistfunctionality.ClientID + "','" + strrowiseid + "')";
                            chkIsEnable.Attributes.Add("onclick", clientfunction);
                        }
                }
               
            }
        }
    }
    protected void dtlistfunctionality_ItemCreated(object sender, DataListItemEventArgs e)
    {

    }
}
    public class TemplateHandler : ITemplate
    {
        public string ControlType { get; set; }
        public string ControlName { get; set; }

        public TemplateHandler(string controlType, string controlName)
        {
            this.ControlType = controlType;
            this.ControlName = controlName;
        }
        void ITemplate.InstantiateIn(Control container)
        {
            Label lblControl;
            CheckBox chkbox;
            switch (ControlType)
            {
                case "Lablel":
                    lblControl = new Label();
                    lblControl.ID = "lblpageName";
                    container.Controls.Add(lblControl);
                    break;
                case "CheckBox":
                    chkbox = new CheckBox();
                    chkbox.ID = ControlName;
                    chkbox.Checked = false;
                    container.Controls.Add(chkbox);
                    break;
                default:
                    break;
            }

        }

    }
