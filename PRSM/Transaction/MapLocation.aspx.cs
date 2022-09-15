using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using UserRoleWiseAcess;
using PRSMBAL;
using Entity;
using Utility;
public partial class Transaction_MapLocation : PageBase 
{
    PRSMBAL.MasterBAL objPRSMBAL = new MasterBAL();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindDdlWareHouse();
            BindCompanyGroup(0);
            ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
           rbtsearchType.Items[0].Selected = true;
           disableSubmit();
            ViewState["DataMapLocations"] = objPRSMBAL.GetBoxLocation(0, "-1", 0, 0);
            
           
        }
    }
    protected void disableSubmit()
    {
        btnsubmit.Visible = false;
        
        if (rbtsearchType.SelectedItem.Value == "2")
        {
            btnsubmit.Visible = true;     
        }
        SetRolewiseAcessfuncationality();
    }
    protected void BindCompanyGroup(int iCompanyId)
    {
        ddlCompanyGroup.DataSource = null;
        ddlCompanyGroup.DataBind();
        ddlCompanyGroup.DataSource = objPRSMBAL.GetCompanyGroup(iCompanyId);
        ddlCompanyGroup.DataValueField = "CompanyGroupId";
        ddlCompanyGroup.DataTextField = "CGName";
        ddlCompanyGroup.DataBind();
        ddlCompanyGroup.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }
    private void BindDdlWareHouse()
    {
        ddlWareHouse.DataSource = objPRSMBAL.GetWareHouse(0);
        ddlWareHouse.DataValueField = "WareHouseId";
        ddlWareHouse.DataTextField = "WarehouseName";
        ddlWareHouse.DataBind();
        ddlWareHouse.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        FilterSearch();
    }

    protected void FilterSearch()
    {
        
        if (ViewState["DataMapLocations"] == null)
        {
          ViewState["DataMapLocations"] =  objPRSMBAL.GetBoxLocation(0, "-1", 0, 0);
        }
        string strfliterExpression = "";

        if (rbtsearchType.SelectedItem.Value == "2")
        {
            strfliterExpression += "BoxLocationCode ='' ";
        }
        if (ddlWareHouse.SelectedIndex > 0)
        {
        int     iwarehouseId = Convert.ToInt16(ddlWareHouse.SelectedItem.Value);
                strfliterExpression += " AND  ";
                strfliterExpression += "WareHouseId =" + iwarehouseId;
        }
        if (ddlCompanyGroup.SelectedIndex > 0)
        {
            int icompanyGroup = Convert.ToInt16(ddlCompanyGroup.SelectedItem.Value);
            strfliterExpression += " AND  ";
            strfliterExpression += "CompanyGroupId =" + icompanyGroup;
        }
        if (ddlCustomer.SelectedIndex > 0)
        {
            int icustomerId = Convert.ToInt16(ddlCustomer.SelectedItem.Value);
            strfliterExpression += " AND  ";
            strfliterExpression += "CustomerId =" + icustomerId;
        }
        strfliterExpression = strfliterExpression.Trim();
        if (strfliterExpression.Trim().StartsWith("AND"))
        {
            strfliterExpression = strfliterExpression.Substring(3);
        }
        if (strfliterExpression.Trim().EndsWith("AND"))
        {
            strfliterExpression = strfliterExpression.Substring(0 , strfliterExpression.Length - 4);
        }
       
        DataSet dsDataMapLocations = (DataSet)ViewState["DataMapLocations"];
        DataRow [] dr = dsDataMapLocations.Tables[0].Select(strfliterExpression);
        DataTable dt = new DataTable();
        dt = dsDataMapLocations.Tables[0].Clone();
        //dr.r
        dr.CopyToDataTable<DataRow>(dt, LoadOption.Upsert);
        dt.AcceptChanges();
        grdboxlocation.DataSource = null;
        grdboxlocation.DataBind();
        grdboxlocation.DataSource = dt;
        grdboxlocation.DataBind();
    
    }
    protected void BindCustomer(int iCompanyId)
    {
        ddlCustomer.Items.Clear();
        ddlCustomer.DataSource = null;
        ddlCustomer.DataBind();
        ddlCustomer.DataSource = objPRSMBAL.GetCustomer(iCompanyId);
        ddlCustomer.DataValueField = "CustomerId";
        ddlCustomer.DataTextField = "CustomerName";
        ddlCustomer.DataBind();
        ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }
    protected void ddlCompanyGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        grdboxlocation.DataSource = null;
        grdboxlocation.DataBind();
        if (ddlCompanyGroup.SelectedIndex > 0)
        {
            BindCustomer(Convert.ToByte(ddlCompanyGroup.SelectedItem.Value));
        }
        else
        {
            ddlCustomer.Items.Clear();
            ddlCustomer.DataSource = null;
            ddlCustomer.DataBind();
            ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
    }

    protected void rbtsearchType_SelectedIndexChanged(object sender, EventArgs e)
    {
        disableSubmit();
        grdboxlocation.DataSource = null;
        grdboxlocation.DataBind();
    }
    protected void ddlCustomer_SelectedIndexChanged(object sender, EventArgs e)
    {
        grdboxlocation.DataSource = null;
        grdboxlocation.DataBind();
    }
    protected void grdboxlocation_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox lblBoxLocationCode = (TextBox)e.Row.FindControl("lblBoxLocationCode");
            if (rbtsearchType.SelectedItem.Value == "2")
            {
                //btnsubmit.Visible = true;
                if (lblBoxLocationCode != null)
                {
                    lblBoxLocationCode.ReadOnly = false;
                }
            }
            else
            {
                if (lblBoxLocationCode != null)
                {
                    lblBoxLocationCode.ReadOnly = true;
                }
            }
        }
    }

    protected DataTable BoxLocationCodesTable()
    {
        DataTable BoxLocationCodesTable = new DataTable();
        if (ViewState["BoxLocationCodesTable"] == null)
        {
            BoxLocationCodesTable.TableName = "Root";
            BoxLocationCodesTable.Columns.Add("BoxId", typeof(int));
            BoxLocationCodesTable.Columns.Add("LocationCode", typeof(String));
            BoxLocationCodesTable.AcceptChanges();
        }
        else
        {
            BoxLocationCodesTable = (DataTable)ViewState["BoxLocationCodesTable"];
        }
        return BoxLocationCodesTable;
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            DataTable dtBoxLocationCodesTable = BoxLocationCodesTable();

            for (int i = 0; i < grdboxlocation.Rows.Count   ; i++)
            {
                TextBox lblBoxLocationCode = (TextBox)grdboxlocation.Rows[i].FindControl("lblBoxLocationCode");
                HiddenField hdnboxid = (HiddenField)grdboxlocation.Rows[i].FindControl("hdnboxid");
                if (!string.IsNullOrEmpty(lblBoxLocationCode.Text.Trim())  )
                {
                    DataRow dr = dtBoxLocationCodesTable.NewRow();
                    dr["BoxId"] = Convert.ToInt32(hdnboxid.Value );
                    dr["LocationCode"] = lblBoxLocationCode.Text.Trim();
                    dtBoxLocationCodesTable.Rows.Add(dr);
                    dtBoxLocationCodesTable.AcceptChanges(); 
                }
            }
            DataSet ds = new DataSet();
            ds.Tables.Add(dtBoxLocationCodesTable);
            string strxmlmaplocation = ds.GetXml();
            string msg = objPRSMBAL.UpdateMaplocation(strxmlmaplocation);
            ViewState["DataMapLocations"] = objPRSMBAL.GetBoxLocation(0, "-1", 0, 0);
            if (ddlWareHouse.Items.Count > 0)
            {
                ddlWareHouse.SelectedIndex = 0;
            }
            if (ddlCompanyGroup.Items.Count > 0)
            {
                ddlCompanyGroup.SelectedIndex = 0;
            }
            ddlCustomer.Items.Clear();
            ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            disableSubmit();
            grdboxlocation.DataSource = null;
            grdboxlocation.DataBind();
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('"+msg+"')", true);
        }
    }

    #region [Rolewise access page funcationality]
    public void SetRolewiseAcessfuncationality()
    {
        UserRolewiseAcess objUserRoleWiseAcessDAL = new UserRolewiseAcess();
        DataTable dtPageId = objUserRoleWiseAcessDAL.GetApplicationCodeDetails("Page_Name", "Box Location").Tables[0];
        int PageId = 0;
        if (dtPageId.Rows.Count > 0)
        {
            PageId = Convert.ToInt32(dtPageId.Rows[0][0]);
        }
        DataTable dtPagefuncationality = objUserRoleWiseAcessDAL.GetPageFunctionalityByRoleAndPageId(PageId, RoleId).Tables[0];
        btnSearch.Visible = false;
        btnsubmit.Visible = false ;

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
                        case "Search":
                            btnSearch.Visible = true;
                            break;
                        case "Submit":
                            btnsubmit.Visible = true;
                            break;
                        default:
                            break;
                    }
                }
            }
        }

    }


    #endregion
}