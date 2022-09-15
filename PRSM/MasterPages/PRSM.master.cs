using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using UserRoleWiseAcess;
using System.Web.UI.WebControls;

using System.Data;
public partial class MasterPages_Home : System.Web.UI.MasterPage
{

    UserRolewiseAcess objUserRoleWiseAcessDAL = new UserRolewiseAcess();
    protected void Page_Init(object sender, EventArgs e)
    {
        if (Session["UserId"] == null)
        {
            Response.Redirect("~/User/Login.aspx", false);
        }
    }
    PageBase objpagebase = new PageBase();
    protected void Page_Load(object sender, EventArgs e)
    {


        if (!IsPostBack)
        {
            //  lblUserName.Text 
            lblUserName.InnerText = objpagebase.UserName;
            int roleid = objpagebase.RoleId;
            DisableMenus(roleid);
        }
    }
    public void DisableMenus(int RoleId)
    {

        List<LinkButton> LstMenu = new List<LinkButton>();
        List<string> lstMenuName = new List<string>();
        DataTable dtenablemeunus = objUserRoleWiseAcessDAL.GetMenu(RoleId).Tables[0];
        if (dtenablemeunus != null)
        {
            for (int i = 0; i < dtenablemeunus.Rows.Count; i++)
            {
                string strmenuName = Convert.ToString(dtenablemeunus.Rows[i]["Menu"]).Trim();
                lstMenuName.Add(strmenuName.ToUpper());
            }
        }
        var lstmenu = EnumerateControlsRecursive(nav).ToList();
        foreach (Control item in lstmenu)
        {
            string strType = item.GetType().ToString();
            if (strType == "System.Web.UI.WebControls.LinkButton")
            {
                LinkButton lnkbtn = (LinkButton)item;
                if (!lstMenuName.Contains(lnkbtn.Text.Trim().ToUpper()))
                {
                    LstMenu.Add((LinkButton)item);
                }
            }
        }
        for (int j = 0; j < LstMenu.Count; j++)
        {
            LstMenu[j].Enabled = false;
        }

    }
    protected void lnkbtnLogout_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Session.Clear();
        Response.Redirect("~/User/Login.aspx", false);
    }
    IEnumerable<Control> EnumerateControlsRecursive(Control parent)
    {
        foreach (Control child in parent.Controls)
        {
            yield return child;
            foreach (Control descendant in EnumerateControlsRecursive(child))
                yield return descendant;
        }
    }
    protected void lnkbtnCompanygroup_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Master/CompanyGroup.aspx", false);
    }
    protected void lnkbtnCustomer_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Master/Customer.aspx", false);
    }
    protected void lnkbtnServiceCategory_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Master/ServiceCategory.aspx", false);
    }
    protected void lnkbtnActivity_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Master/Activity.aspx", false);
    }
    protected void lnkbtnWareHouse_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Master/WareHouse.aspx", false);
    }
    //protected void lnkbtnRack_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("~/Master/Rack.aspx", false);
    //}
    protected void lnkbtnShelfbox_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Master/ShelfBox.aspx", false);
    }
    protected void lnkbtnContract_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Master/Contract.aspx", false);
    }
    protected void lnkbtnRateCard_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Master/Rate.aspx", false);
    }
    protected void lnbtnVertical_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Master/Vertical.aspx", false);
    }
    protected void lnkbtnRequest_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Transaction/Request.aspx", false);
    }
    protected void lnkbtnUserMaster_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/User/UserMaster.aspx", false);
    }
    protected void lnkbtnCity_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Master/City.aspx", false);
    }
    protected void lnkbtnCustomerlist_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Master/SearchCustomer.aspx", false);
    }
    protected void lnkbtnWorkOrder_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Transaction/WorkOrders.aspx", false);
    }
    protected void lnkbtnInward_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Transaction/Inward.aspx", false);
    }
    protected void lnkbtnMonthlyInvoice_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Transaction/Invoice.aspx", false);
    }
    protected void lnkbtnFreshpickup_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Transaction/FreshPickup.aspx", false);
    }
    protected void lnkbtnOtherServices_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Transaction/OtherServices.aspx", false);
    }
    protected void lnkbtnPermantreturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Transaction/PermanentReturn.aspx", false);

    }
    protected void lnkbtnViewContract_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Master/ViewContract.aspx", false);
    }
    protected void lnkbtnUserRights_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/User/UsersRights.aspx", false);
    }
    protected void lnkbtnCompanyMaster_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Master/CompanyMaster.aspx", false);
    }

    protected void lnkbtnviewboxlocation_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Master/ViewLocation.aspx", false);
    }
    protected void lnkbtnInhouseManagement_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Transaction/InHouseMangement.aspx", false);
    }
    protected void lnkbtngenerateinvoice_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Transaction/MonthlyInvoice.aspx", false);
    }
    protected void lnkbtngenerateinvoice_New_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Transaction/MonthlyInvoice_New.aspx", false);
    }
    protected void lbtnReptFilePickup_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Reports/FilePickUpReport.aspx", false);
    }
    protected void lbtnReptClientWiseFileDetails_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Reports/CustomerWiseFileDetails.aspx", false);
    }
    protected void lnkbtnRowMaster_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Master/RowMaster.aspx", false);
    }
    protected void lbtnReptInventory_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Reports/InventoryReportAsOnDate.aspx", false);
    }
    //protected void lblInventoryReportSummary_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("~/Reports/InventoryReportSummary.aspx", false);
    //}
    protected void lbtnReptRetrieval_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Reports/FileRestoreRetrievalReport.aspx", false);
    }

    
    protected void lbtnReptOtherServices_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Reports/OtherServices.aspx", false);
    }


    protected void lnkServiceCompletionReport_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Reports/ServiceCompletionReport.aspx", false);
    }
    protected void lnkbtnMakerCheckerNEW_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Transaction/MakerAndChecker_New.aspx", false);
    }
    protected void lnkbtnMakerChecker_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Transaction/MakerAndChecker.aspx", false);
    }

    protected void lnkbtnCustomerUser_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/User/CustomerCreation.aspx", false);
    }


    protected void lnkbtnCloseServiceRequest_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Transaction/CloseServiceRequest.aspx", false);
    }
    protected void lnkSearchBoxesFiles_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Transaction/FreshPickupSearch.aspx", false);
    }

    protected void lnkbtnInvoicePayment_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Transaction/ClientPayment.aspx", false);
    }

    
    //lnkbtnCloseServiceRequest_Click    

    protected void lnkbtnUploadPickupData_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Transaction/UploadPickupData.aspx", false);
    }

    protected void lblInventoryReportSummary_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Reports/InventoryReportSummary.aspx", false);
    }
}
