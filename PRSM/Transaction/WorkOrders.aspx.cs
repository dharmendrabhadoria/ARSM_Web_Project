using System;
using System.Text;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PRSMBAL;
using System.Drawing;
using Utility;
using System.Web.Services;
using System.Data;
using Entity;
using UserRoleWiseAcess;
using System.Web.SessionState;
using System.Globalization;
using System.IO;
using System.Net.Mail;
using System.Configuration;
using PRSMBAL;
using System.Data.SqlClient;
using System.Data.OleDb;
using System.Drawing;


public partial class Transaction_WorkOrders : PageBase
{
    private System.Globalization.CultureInfo enGB = new System.Globalization.CultureInfo("en-GB");
    public static PRSMBAL.MasterBAL objPRSMBAL = new MasterBAL();
    public static PRSMBAL.TransactionBAL objTRANSBAL = new TransactionBAL();
    PageBase objPageBase = new PageBase();
    public static PRSMBAL.MasterBAL objstPRSMBAL = new MasterBAL();
    public static PRSMBAL.TransactionBAL objTRANSStBAL = new TransactionBAL();
    const string _LOGOIMAGE = "@imagepath@";
    const string _LOGOIMAGE1 = "@imagepath1@";
    const string _ServiceCateg = "@ServiceCateg@";
    const string _CustomerName = "@Name@";
    const string _WONo = "@WONo@";
    const string _Address = "@Address@";
    const string _Date = "@Date@";
    const string _WoCloseDate = "@WoCloseDate@";
    const string _Time = "@Time@";
    const string _ContactPerson = "@ContactPerson@";
    const string _ContactNumber = "@ContactNumber@";
    const string _TableOtherServices = "@TableOtherServices@";
    const string _WOSUMMARY = "@WOSUMMARY@";
    const string _RequestedActivity = "@TableRequestedActivity@";
    const string _WoStatus = "@WoStatus@";


    DataSet ds = new DataSet();
    PRSMBAL.TransactionBAL ObjPRSMBAL = new TransactionBAL();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (objPageBase.UserId == 0)
        {
            Response.Redirect("~/User/Login.aspx", false);
        }
        ViewState["iSrNo"] = 0;
        if (!IsPostBack)
        {
            BindNewWorkOrder();
            BindDdlWareHouse();
            hdnTotalAddedActivity.Value = "0";
            SetRolewiseAcessfuncationality();
            BindsearchStatus();
            BidDefaultGirdAcitvitySetting();
            ddlRetrievalPickUpAddress.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlFilePickUpAddress.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlRequestedService.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlSearchStatus.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlSearchCGCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlServiceRequest.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            disableServiceRequestsCategory();
            BindDepartment();
            ShowHideUploadControls(false, false);
            txtnoofboxes.Visible = false;
            txtnooffiles.Visible = false;
            chkboxesconfirm.Visible = false;
            FileUpload3.Visible = false;
            Lbllfile.Visible = false;
            btnFile.Visible = false;
            hlOtherServices.Visible = false;
            //HyperLink5.Visible = false;

        }
    }
    protected void BidWOList()
    {
        string SplitServiceCatIds = "";
        string strSplitCategIds = "";
        if (ViewState["WorkOrderNo"] != null)
        {
            int WONo = Convert.ToInt32(ViewState["WorkOrderNo"].ToString());
            DataSet dsGetWorkOrder = objTRANSBAL.GetWoActivity(0, WONo, 0, "Work Order", 0);
            DataTable dtServiceCategory = dsGetWorkOrder.Tables[0].DefaultView.ToTable(true, "ServiceCategoryId");
            if (dtServiceCategory.Rows.Count > 0)
            {

                for (int i = 0; i < dtServiceCategory.Rows.Count; i++)
                {
                    SplitServiceCatIds = SplitServiceCatIds + dtServiceCategory.Rows[i]["ServiceCategoryId"] + ",";
                }
            }

            strSplitCategIds = SplitServiceCatIds.TrimEnd(',');
            List<ServiceCategory> ServicerCatgList = objPRSMBAL.GetServiceCategory(0);
            DataTable dt = ConvertListToDataTable(ServicerCatgList);
            DataTable dtServiceCatg = dt.Clone();

            string[] CatId = strSplitCategIds.Split(',');

            foreach (string Id in CatId)
            {
                if (Id != "")
                {
                    DataRow[] ddr = dt.Select("ServiceCategoryId=" + Id);

                    if (ddr.Length > 0)
                        foreach (DataRow NewDr in ddr)
                        {
                            dtServiceCatg.ImportRow(NewDr);
                        }
                }
            }

            ViewState["RequestedActivity"] = dtServiceCatg;
            chkRequestedActivity.DataSource = dtServiceCatg;
            chkRequestedActivity.DataTextField = "SCName";
            chkRequestedActivity.DataValueField = "ServiceCategoryId";
            chkRequestedActivity.DataBind();

            if (dtServiceCatg.Rows.Count > 0)
            {
                foreach (ListItem listItem in chkRequestedActivity.Items)
                {
                    listItem.Selected = true;
                }
            }

        }

    }

    public void BindServiceRequests()
    {
        diviewFilepickup.Style["display"] = "none";
        diviewRetrival.Style["display"] = "none";
        diviewOtherServices.Style["display"] = "none";
        diviewOtherServices.Style["display"] = "none";
        diviewDestruction.Style["display"] = "none";
        diviewPerRetn.Style["display"] = "none";
        DataTable dt = new DataTable();
        int iServiceCategoryId = 0;
        grdOtherServiceActivity.DataSource = null;
        grdOtherServiceActivity.DataBind();
        if (ViewState["RequestedActivity"] != null)
        {
            DataTable dtReqActivityDet = (DataTable)(ViewState["RequestedActivity"]);

            if (dtReqActivityDet.Rows.Count > 0)
            {
                for (int i = 0; i < dtReqActivityDet.Rows.Count; i++)
                {
                    if (dtReqActivityDet.Rows[i]["SCName"].ToString() == "File Pick Up")
                    {
                        try
                        {
                            DataTable dtFilePickup = new DataTable();
                            diviewFilepickup.Style["display"] = "block";
                            int WONo = Convert.ToInt32(ViewState["WorkOrderNo"].ToString());
                            iServiceCategoryId = Convert.ToInt32(chkRequestedActivity.Items.FindByText("File Pick Up").Value);
                            DataSet dsGetWoActivityByServiceCatg = objTRANSBAL.GetWoActivitiesByServiceCategory(WONo, "Work Order", iServiceCategoryId);

                            if (dsGetWoActivityByServiceCatg.Tables[0].Rows.Count > 0)
                            {

                                grdFPActivityDetails.DataSource = dsGetWoActivityByServiceCatg;
                                grdFPActivityDetails.DataBind();
                            }
                            else
                            {
                                grdFPActivityDetails.DataSource = null;
                                grdFPActivityDetails.DataBind();
                            }
                        }
                        catch (Exception ex)
                        {

                            ErrorHandler.WriteLog(ex);
                        }

                    }

                    if (dtReqActivityDet.Rows[i]["SCName"].ToString() == "Retrieval")
                    {
                        diviewRetrival.Style["display"] = "block";
                        DataTable dtRetrieval = new DataTable();
                        iServiceCategoryId = Convert.ToInt32(chkRequestedActivity.Items.FindByText("Retrieval").Value);
                        dtRetrieval = objPRSMBAL.GetActivitybyCategory(iServiceCategoryId).Tables[0];
                        int WONo = Convert.ToInt32(ViewState["WorkOrderNo"].ToString());
                        DataTable dtRetrievalboxFile = new DataTable();
                        DataSet ds = objTRANSBAL.GetRetrivalBoxFileDetails(WONo, 0, 0, iServiceCategoryId);
                        dtRetrievalboxFile = ds.Tables[0];
                        grddisplayRetrivalActivity.DataSource = dtRetrievalboxFile;
                        grddisplayRetrivalActivity.DataBind();
                        var query = from s in dtRetrievalboxFile.AsEnumerable()
                                    group s by new
                                    {
                                        PickupAddress = s.Field<string>("PickUpAddress"),
                                        sActivityName = s.Field<string>("ActivityName"),
                                        sActivityStatus = s.Field<string>("WoActivityStatus"),
                                    }
                                        into grp
                                        orderby grp.Key.sActivityName
                                        select new { PickupAddress = grp.Key.PickupAddress, ActivityName = grp.Key.sActivityName, WoActivityStatus = grp.Key.sActivityStatus, ActivityCount = grp.Count() };

                        grddisplayActivityCount.DataSource = query.ToList();
                        grddisplayActivityCount.DataBind();

                    }

                    if (dtReqActivityDet.Rows[i]["SCName"].ToString() == "Other services")
                    {
                        DataTable dtOtherServices = new DataTable();
                        diviewOtherServices.Style["display"] = "block";
                        int WONo = Convert.ToInt32(ViewState["WorkOrderNo"].ToString());
                        DataSet dsGetWorkOrder = objTRANSBAL.GetWoActivity(0, WONo, 0, "Work Order", 0);
                        iServiceCategoryId = Convert.ToInt32(chkRequestedActivity.Items.FindByText("Other services").Value);
                        dtOtherServices = dsGetWorkOrder.Tables[0].AsEnumerable().Where(a => a.Field<Byte>("ServiceCategoryId").Equals(Convert.ToByte(iServiceCategoryId))).CopyToDataTable();

                        grdOtherServiceActivity.DataSource = dtOtherServices;
                        grdOtherServiceActivity.DataBind();
                        int iWorkOrderActvId = Convert.ToInt32(dtOtherServices.Rows[0]["WoActivityId"].ToString());
                        DataSet ds = objTRANSBAL.GetRetrivalBoxFileDetails(WONo, 0, 0, iServiceCategoryId);
                        grdOtherServiceActivities.DataSource = ds.Tables[0];
                        grdOtherServiceActivities.DataBind();

                    }

                    if (dtReqActivityDet.Rows[i]["SCName"].ToString() == "Destruction")
                    {
                        DataSet dsDest = new DataSet();
                        DataTable dtDestruction = new DataTable();
                        diviewDestruction.Style["display"] = "block";
                        int WONo = Convert.ToInt32(ViewState["WorkOrderNo"].ToString());
                        dsDest = objTRANSBAL.GetRetrivalBoxFileDetails(WONo, 0, 0, 0);
                        dtDestruction = dsDest.Tables[0];
                        gvDestructionActivity.DataSource = dtDestruction;
                        gvDestructionActivity.DataBind();
                        var queryDestruction = from s in dtDestruction.AsEnumerable()
                                               group s by new
                                               {
                                                   sActivityName = s.Field<string>("ActivityName"),
                                                   sActivityStatus = s.Field<string>("WoActivityStatus"),
                                               }
                                                   into grp
                                                   orderby grp.Key.sActivityName
                                                   select new { ActivityName = grp.Key.sActivityName, WoActivityStatus = grp.Key.sActivityStatus, ActivityCount = grp.Count() };

                        gvDestructionActivityCount.DataSource = queryDestruction.ToList();
                        gvDestructionActivityCount.DataBind();
                    }

                    if (dtReqActivityDet.Rows[i]["SCName"].ToString() == "Permanent Return")
                    {
                        DataSet dsPerRet = new DataSet();
                        DataTable dtPerRetn = new DataTable();
                        diviewPerRetn.Style["display"] = "block";
                        int WONo = Convert.ToInt32(ViewState["WorkOrderNo"].ToString());
                        dsPerRet = objTRANSBAL.GetRetrivalBoxFileDetails(WONo, 0, 0, 0);
                        dtPerRetn = dsPerRet.Tables[0];
                        gvParmanentReturnActivity.DataSource = dtPerRetn;
                        gvParmanentReturnActivity.DataBind();
                        var queryPerRetn = from s in dtPerRetn.AsEnumerable()
                                           group s by new
                                           {
                                               sActivityName = s.Field<string>("ActivityName"),
                                               sActivityStatus = s.Field<string>("WoActivityStatus"),
                                           }
                                               into grp
                                               orderby grp.Key.sActivityName
                                               select new { ActivityName = grp.Key.sActivityName, WoActivityStatus = grp.Key.sActivityStatus, ActivityCount = grp.Count() };

                        gvParmanentReturnActivityCount.DataSource = queryPerRetn.ToList();
                        gvParmanentReturnActivityCount.DataBind();
                    }
                }
            }

        }
    }
    protected void chkRequestedActivity_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindServiceRequests();
    }
    static DataTable ConvertListToDataTable(List<ServiceCategory> ServicerCatgList)
    {
        DataTable table = new DataTable();
        table.Columns.Add("ServiceCategoryId", typeof(Int16));
        table.Columns.Add("SCName", typeof(string));
        foreach (var array in ServicerCatgList)
        {
            DataRow dr = table.NewRow();

            dr["ServiceCategoryId"] = array.ServiceCategoryId;
            dr["SCName"] = array.SCName;

            table.Rows.Add(dr);
        }

        return table;
    }

    protected void lstWorkOrder_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        if (e.Item.ItemType == ListViewItemType.DataItem)
        {
            GridView grd1 = (GridView)e.Item.FindControl("gdvSearchWorkOrder");
            if (grd1 != null)
            {
                if (ViewState["WorkOrderNo"] != null)
                {
                    int WONo = Convert.ToInt32(ViewState["WorkOrderNo"].ToString());
                    DataSet dsGetWorkOrder = objTRANSBAL.GetWoActivity(0, WONo, 0, "Work Order", 0);
                    Label lb1CatId = (Label)e.Item.FindControl("lb1CatId");
                    var v = dsGetWorkOrder.Tables[0].AsEnumerable().Where(a => a.Field<Byte>("ServiceCategoryId").Equals(Convert.ToByte(lb1CatId.Text))).CopyToDataTable();
                    grd1.DataSource = v;
                    grd1.DataBind();
                }

            }
        }
    }
    protected void BindNewWorkOrder()
    {
        divNewOrder.Style["display"] = "block";
        divSearchOrder.Style["display"] = "none";
        divUpdateWoActivity.Style["display"] = "none";
        ViewState["RequestId"] = 0;
        txtWorkOrderDate.Text = DateTime.Now.ToString("dd-MMM-yyyy", enGB);
        txtWorkOrderDate.Enabled = false;
        BindCompanyGroup(0);
        BindServiceCategory(0);
        BindServiceStaus();
        ddlServiceStatus.Enabled = false;
        ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        hdnboxfilestatus.Value = "0";

        if (ddlServiceStatus.Items.Count > 0)
        {
            //ddlServiceStatus.SelectedIndex = 1;
            ddlServiceStatus.SelectedIndex = ddlServiceStatus.Items.IndexOf(ddlServiceStatus.Items.FindByText("Open"));
        }
        lnkbtnSearchOrder.Style["color"] = "#4f4f4f !important;";
        lnkbtnUpdateWOActivity.Style["color"] = "#4f4f4f !important;";
        lnkbtnNewWorkOrder.Style["color"] = "blue !important;";
    }


    protected Int16 GetWorkActivityStatus(string Status)
    {
        DataSet dsActivityStatus = objPRSMBAL.GetApplicationCodeDetails("ACTIVITY_STATUS", "");
        Int16 istatus = 0;
        for (int i = 0; i < dsActivityStatus.Tables[0].Rows.Count; i++)
        {
            if (Convert.ToString(dsActivityStatus.Tables[0].Rows[i]["AppCodeName"]).ToUpper() == Status.ToUpper())
            {
                istatus = Convert.ToInt16(dsActivityStatus.Tables[0].Rows[i]["AppCodeId"]);
                break;
            }
        }
        return istatus;
    }

    protected void BindWorkOrderActivites(int WoActivityId, int iWorkorderNo, int istatus)
    {

        ddlRequestedService.DataSource = null;
        DataSet dsWOActivity = objTRANSBAL.GetWoActivity(0, iWorkorderNo, istatus, "Work Order", 0);
        DataTable dtWOActivity = dsWOActivity.Tables[0];
        var distinctRows = (from DataRow dRow in dtWOActivity.Rows
                            select new { ServiceCategoryId = dRow["ServiceCategoryId"], SCName = dRow["SCName"] }).Distinct();
        if (dsWOActivity.Tables[0].Rows.Count > 0)
        {
            ddlRequestedService.DataSource = distinctRows.ToList();
            ddlRequestedService.DataValueField = "ServiceCategoryId";
            ddlRequestedService.DataTextField = "SCName";
            ddlRequestedService.DataBind();
            ddlRequestedService.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
    }

    //protected void BindWorkOrderActivites(int WoActivityId, int iWorkorderNo, int istatus)
    //{
    //    ddlWorkOrderActivity.DataSource = null;
    //    DataSet dsWOActivity = objTRANSBAL.GetWoActivity(0, iWorkorderNo, istatus, "Work Order");
    //    if (dsWOActivity.Tables[0].Rows.Count > 0)
    //    {
    //        ddlWorkOrderActivity.DataSource = dsWOActivity.Tables[0];
    //        ddlWorkOrderActivity.DataValueField = "WOActivityId";
    //        ddlWorkOrderActivity.DataTextField = "ActivityName";
    //        ddlWorkOrderActivity.DataBind();
    //        ddlWorkOrderActivity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    //    }
    //}
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Status"> Open,Closed</param>
    /// <returns></returns>
    protected Int16 GetWorkStatus(string Status)
    {
        DataSet dsCodeDetails = objPRSMBAL.GetApplicationCodeDetails("WORKORDER_STATUS", "");
        Int16 istatus = 0;
        for (int i = 0; i < dsCodeDetails.Tables[0].Rows.Count; i++)
        {
            if (Convert.ToString(dsCodeDetails.Tables[0].Rows[i]["AppCodeName"]).ToUpper() == Status.ToUpper())
            {
                istatus = Convert.ToInt16(dsCodeDetails.Tables[0].Rows[i]["AppCodeId"]);
                break;
            }
        }
        return istatus;
    }
    protected Int16 GetActivityStatus(string Status)
    {
        DataSet dsActivityStatus = objPRSMBAL.GetApplicationCodeDetails("ACTIVITY_STATUS", "");
        Int16 istatus = 0;
        for (int i = 0; i < dsActivityStatus.Tables[0].Rows.Count; i++)
        {
            if (Convert.ToString(dsActivityStatus.Tables[0].Rows[i]["AppCodeName"]).ToUpper() == Status.ToUpper())
            {
                istatus = Convert.ToInt16(dsActivityStatus.Tables[0].Rows[i]["AppCodeId"]);
                break;
            }
        }
        return istatus;
    }
    protected void BindCompanyGroupUpdate(int iCompanyId)
    {
        ddlCompanyGroupUpdate.DataSource = null;
        ddlCompanyGroupUpdate.DataBind();
        ddlCompanyGroupUpdate.DataSource = objPRSMBAL.GetCompanyGroup(iCompanyId);
        ddlCompanyGroupUpdate.DataValueField = "CompanyGroupId";
        ddlCompanyGroupUpdate.DataTextField = "CGName";
        ddlCompanyGroupUpdate.DataBind();
        ddlCompanyGroupUpdate.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }
    private void BindDdlWareHouseUpdate()
    {
        ddlWareHouseUpdate.DataSource = objPRSMBAL.GetWareHouse(0);
        ddlWareHouseUpdate.DataValueField = "WareHouseId";
        ddlWareHouseUpdate.DataTextField = "WarehouseName";
        ddlWareHouseUpdate.DataBind();
        ddlWareHouseUpdate.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }
    private void BindDdlWareHouse()
    {
        ddlWareHouse.DataSource = objPRSMBAL.GetWareHouse(0);
        ddlWareHouse.DataValueField = "WareHouseId";
        ddlWareHouse.DataTextField = "WarehouseName";
        ddlWareHouse.DataBind();
        ddlWareHouse.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }

    protected void BindsearchStatus()
    {
        string sWorkOrderStatus = "WORKORDER_STATUS";
        ddlSearchStatus.DataSource = objPRSMBAL.GetApplicationCodeDetails(sWorkOrderStatus, string.Empty);
        ddlSearchStatus.DataValueField = "AppCodeId";
        ddlSearchStatus.DataTextField = "AppCodeName";
        ddlSearchStatus.DataBind();
    }
    protected void BindServiceStaus()
    {
        string sWorkOrderStatus = "WORKORDER_STATUS";
        ddlServiceStatus.DataSource = objPRSMBAL.GetApplicationCodeDetails(sWorkOrderStatus, string.Empty);
        ddlServiceStatus.DataValueField = "AppCodeId";
        ddlServiceStatus.DataTextField = "AppCodeName";
        ddlServiceStatus.DataBind();
        ddlServiceStatus.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });

    }

    protected void BidDefaultGirdAcitvitySetting()
    {
        DataSet dsGetWorkOrderNew = objTRANSBAL.GetWorkOrder(0, Convert.ToInt32(ddlSearchCG.SelectedItem.Value), Convert.ToInt32(ddlSearchCGCustomer.SelectedItem.Value), 0, Convert.ToInt16(ddlSearchStatus.SelectedItem.Value), null, null);
        gdvSearchWorkOrder.DataSource = dsGetWorkOrderNew.Tables[0];
        gdvSearchWorkOrder.DataBind();
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

        ddlSearchCG.DataSource = null;
        ddlSearchCG.DataBind();
        ddlSearchCG.DataSource = objPRSMBAL.GetCompanyGroup(iCompanyId);
        ddlSearchCG.DataValueField = "CompanyGroupId";
        ddlSearchCG.DataTextField = "CGName";
        ddlSearchCG.DataBind();
        ddlSearchCG.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });

    }

    protected void BindCustomer(int iCompanyId)
    {
        ddlCustomer.DataSource = null;
        ddlCustomer.DataBind();
        ddlCustomer.DataSource = objPRSMBAL.GetCustomer(iCompanyId);
        ddlCustomer.DataValueField = "CustomerId";
        ddlCustomer.DataTextField = "CustomerName";
        ddlCustomer.DataBind();
        ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlSearchCGCustomer.DataSource = null;
        ddlSearchCGCustomer.DataBind();
        ddlSearchCGCustomer.DataSource = objPRSMBAL.GetCustomer(iCompanyId);
        ddlSearchCGCustomer.DataValueField = "CustomerId";
        ddlSearchCGCustomer.DataTextField = "CustomerName";
        ddlSearchCGCustomer.DataBind();
        ddlSearchCGCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });

    }
    protected void BindCustomerUpdate(int iCompanyId)
    {
        ddlCustomerUpdate.DataSource = null;
        ddlCustomerUpdate.DataBind();
        ddlCustomerUpdate.DataSource = objPRSMBAL.GetCustomer(iCompanyId);
        ddlCustomerUpdate.DataValueField = "CustomerId";
        ddlCustomerUpdate.DataTextField = "CustomerName";
        ddlCustomerUpdate.DataBind();
        ddlCustomerUpdate.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }

    protected void BindPickUpAddress(int iCustomerId)
    {
        DataSet dsPickUpAddress = objPRSMBAL.GetPickUpAddress(iCustomerId);
        if (dsPickUpAddress != null)
        {
            if (dsPickUpAddress.Tables[0].Rows.Count > 0)
            {
                ddlFilePickUpAddress.DataSource = dsPickUpAddress.Tables[0];
                ddlFilePickUpAddress.DataValueField = "PickupAddressId";
                ddlFilePickUpAddress.DataTextField = "Address";
                ddlFilePickUpAddress.DataBind();
                ddlFilePickUpAddress.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });

                ddlRetrievalPickUpAddress.DataSource = dsPickUpAddress.Tables[0];
                ddlRetrievalPickUpAddress.DataValueField = "PickupAddressId";
                ddlRetrievalPickUpAddress.DataTextField = "Address";
                ddlRetrievalPickUpAddress.DataBind();
                ddlRetrievalPickUpAddress.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            }
            else
            {
                ddlFilePickUpAddress.Items.Clear();
                ddlFilePickUpAddress.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
                ddlRetrievalPickUpAddress.Items.Clear();
                ddlRetrievalPickUpAddress.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            }
        }
    }

    protected void BindServiceRequests(int iCustomerId)
    {
        DataSet dsServiceRequests = objPRSMBAL.GetServiceRequestByCustomer(iCustomerId);
        if (dsServiceRequests != null && dsServiceRequests.Tables.Count > 0 && dsServiceRequests.Tables[0].Rows.Count > 0)
        {
            ddlServiceRequest.DataSource = dsServiceRequests.Tables[0];
            ddlServiceRequest.DataValueField = "ServiceRequestNo";
            ddlServiceRequest.DataTextField = "ServiceRequestNo";
            ddlServiceRequest.DataBind();
            ddlServiceRequest.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
        else
        {
            ddlServiceRequest.Items.Clear();
            ddlServiceRequest.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlServiceRequest.Items.Clear();
            ddlServiceRequest.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
    }

    protected void ddlCompanyGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (lblMessage.Text.Length > 0)
        {
            lblMessage.Text = "";
        }
        if (ddlCompanyGroup.SelectedIndex > 0)
        {
            BindCustomer(Convert.ToByte(ddlCompanyGroup.SelectedItem.Value));
            BindServiceRequests(0);
            ClearServiceRequestDetails();
        }
        else
        {
            ddlCustomer.Items.Clear();
            ddlCustomer.DataSource = null;
            ddlCustomer.DataBind();
            ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }


    }

    protected void lnkbtnNewWorkOrder_Click(object sender, EventArgs e)
    {
        ClearAll();
        hdnTotalAddedActivity.Value = "0";
        BindNewWorkOrder();
        lblMessage.Visible = false;
    }

    protected void btnSearchClear_Click(object sender, EventArgs e)
    {
        ddlSearchStatus.SelectedIndex = 1;
        gdvSearchWorkOrder.DataSource = null;
        gdvSearchWorkOrder.DataBind();
        DataSet dsGetWorkOrderNew = objTRANSBAL.GetWorkOrder(0, 0, 0, 0, Convert.ToInt16(ddlSearchStatus.SelectedItem.Value), null, null);
        gdvSearchWorkOrder.DataSource = dsGetWorkOrderNew.Tables[0];
        gdvSearchWorkOrder.DataBind();

    }
    protected void lnkbtnSearchOrder_Click(object sender, EventArgs e)
    {
        lblMessage.Text = "";
        gdvSearchWorkOrder.DataSource = null;
        gdvSearchWorkOrder.DataBind();
        divNewOrder.Style["display"] = "none";
        divUpdateWoActivity.Style["display"] = "none";
        divSearchOrder.Style["display"] = "block";
        lnkbtnSearchOrder.Style["color"] = "blue !important;";
        lnkbtnUpdateWOActivity.Style["color"] = "#4f4f4f !important;";
        lnkbtnNewWorkOrder.Style["color"] = "#4f4f4f !important;";
        try
        {
            gdvSearchWorkOrder.DataSource = null;
            gdvSearchWorkOrder.DataBind();
            DataSet dsGetWorkOrderNew = objTRANSBAL.GetWorkOrder(0, Convert.ToInt32(ddlSearchCG.SelectedItem.Value), Convert.ToInt32(ddlSearchCGCustomer.SelectedItem.Value), 0, Convert.ToInt16(ddlSearchStatus.SelectedItem.Value), null, null);
            gdvSearchWorkOrder.DataSource = dsGetWorkOrderNew.Tables[0];
            gdvSearchWorkOrder.DataBind();
        }
        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }
        ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "changesearch('ContentPlaceHolder1_ddlSearchRequestby');", true);
        SetRolewiseAcessfuncationality();
        lblMessage.Visible = false;
    }
    protected void bindSearchWorkOrder()
    {
        gdvSearchWorkOrder.DataSource = null;
        gdvSearchWorkOrder.DataBind();

        DataSet dsGetWorkOrder = objTRANSBAL.GetWorkOrder(0, 0, 0, 0, 0, null, null);
        if (dsGetWorkOrder.Tables[0].Rows.Count > 0)
        {
            gdvSearchWorkOrder.DataSource = dsGetWorkOrder.Tables[0];
            gdvSearchWorkOrder.DataBind();
        }
        else
        {
            gdvSearchWorkOrder.DataSource = null;
            gdvSearchWorkOrder.DataBind();
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            DateTime? dFromDate;
            DateTime? dToDate;
            gdvSearchWorkOrder.DataSource = null;
            gdvSearchWorkOrder.DataBind();
            if (txtSearchFromDate.Text == "")
                dFromDate = null;
            else
                dFromDate = Convert.ToDateTime(txtSearchFromDate.Text.ToString(), enGB);
            if (txtSearchToDate.Text == "")
                dToDate = null;
            else
                dToDate = Convert.ToDateTime(txtSearchToDate.Text.ToString(), enGB);
            divUpdateWoActivity.Style["display"] = "none";

            if (Convert.ToInt32(ddlSearchCG.SelectedValue) == 0 && Convert.ToInt32(ddlSearchCGCustomer.SelectedValue) == 0 && dFromDate == null && dToDate == null)
            {
                DataSet dsGetWorkOrderNew = objTRANSBAL.GetWorkOrder(0, 0, 0, 0, Convert.ToInt32(ddlSearchStatus.SelectedValue), null, null);
                ViewState["SearchCustomer"] = dsGetWorkOrderNew.Tables[0].Rows[0]["CustomerName"].ToString();
                gdvSearchWorkOrder.DataSource = dsGetWorkOrderNew.Tables[0];
                gdvSearchWorkOrder.DataBind();
            }

            else if (Convert.ToInt32(ddlSearchCG.SelectedValue) == 0 && Convert.ToInt32(ddlSearchCGCustomer.SelectedValue) == 0 && dFromDate != null && dToDate != null)
            {
                DataSet dsGetWorkOrderNew = objTRANSBAL.GetWorkOrder(0, 0, 0, 0, Convert.ToInt32(ddlSearchStatus.SelectedValue), dFromDate, dToDate);
                ViewState["SearchCustomer"] = dsGetWorkOrderNew.Tables[0].Rows[0]["CustomerName"].ToString();
                gdvSearchWorkOrder.DataSource = dsGetWorkOrderNew.Tables[0];
                gdvSearchWorkOrder.DataBind();
            }

            else if (Convert.ToInt32(ddlSearchCG.SelectedValue) != 0 && Convert.ToInt32(ddlSearchCGCustomer.SelectedValue) == 0)
            {
                DataSet dsGetWorkOrderNew = objTRANSBAL.GetWorkOrder(0, Convert.ToInt32(ddlSearchCG.SelectedValue), 0, 0, Convert.ToInt32(ddlSearchStatus.SelectedValue), dFromDate, dToDate);
                ViewState["SearchCustomer"] = dsGetWorkOrderNew.Tables[0].Rows[0]["CustomerName"].ToString();
                gdvSearchWorkOrder.DataSource = dsGetWorkOrderNew.Tables[0];
                gdvSearchWorkOrder.DataBind();
            }
            else if (Convert.ToInt32(ddlSearchCG.SelectedValue) == 0 && Convert.ToInt32(ddlSearchCGCustomer.SelectedValue) != 0)
            {
                DataSet dsGetWorkOrderNew = objTRANSBAL.GetWorkOrder(0, 0, Convert.ToInt32(ddlSearchCGCustomer.SelectedValue), 0, Convert.ToInt32(ddlSearchStatus.SelectedValue), dFromDate, dToDate);
                ViewState["SearchCustomer"] = dsGetWorkOrderNew.Tables[0].Rows[0]["CustomerName"].ToString();
                gdvSearchWorkOrder.DataSource = dsGetWorkOrderNew.Tables[0];
                gdvSearchWorkOrder.DataBind();
            }
            else
            {
                DataSet dsGetWorkOrderNew = objTRANSBAL.GetWorkOrder(0, Convert.ToInt32(ddlSearchCG.SelectedValue), Convert.ToInt32(ddlSearchCGCustomer.SelectedValue), 0, Convert.ToInt16(ddlSearchStatus.SelectedValue), dFromDate, dToDate);
                gdvSearchWorkOrder.DataSource = dsGetWorkOrderNew.Tables[0];
                gdvSearchWorkOrder.DataBind();
            }

            ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "changesearch('ContentPlaceHolder1_ddlSearchRequestby');", true);

        }
        catch (Exception ex)
        {

            ErrorHandler.WriteLog(ex);
        }
    }

    #region Activites
    protected DataTable ActivitesTable()
    {
        DataTable dtActivitiesTable = new DataTable();
        if (ViewState["ActivitesTable"] == null)
        {
            dtActivitiesTable.TableName = "Root";
            dtActivitiesTable.Columns.Add("SrNo", typeof(int));
            dtActivitiesTable.Columns["SrNo"].AutoIncrement = true;
            dtActivitiesTable.Columns["SrNo"].AutoIncrementSeed = 0;
            dtActivitiesTable.Columns.Add("SCName", typeof(String));
            dtActivitiesTable.Columns.Add("ActivityName", typeof(String));
            dtActivitiesTable.Columns.Add("ActivityId", typeof(String));
            dtActivitiesTable.Columns.Add("ActivityStatus", typeof(int));
            dtActivitiesTable.Columns.Add("Remark", typeof(String));
            dtActivitiesTable.Columns.Add("ActivityDate", typeof(String));
            dtActivitiesTable.Columns.Add("NoOfBox", typeof(int));
            dtActivitiesTable.Columns.Add("NoOfFile", typeof(int));
            dtActivitiesTable.Columns.Add("WorkOrderNo", typeof(int));
            dtActivitiesTable.Columns.Add("UserId", typeof(int));
            dtActivitiesTable.Columns.Add("DepartmentId", typeof(int));
            dtActivitiesTable.Columns.Add("PickUpAddressId", typeof(int));
            dtActivitiesTable.AcceptChanges();
        }
        else
        {
            dtActivitiesTable = (DataTable)ViewState["ActivitesTable"];
        }
        return dtActivitiesTable;
    }
    protected void AddActivites(int iSrNo, int iActivityId, int iServiceCategoryId, string strSCName, string strActivityName, string strRemark, String strActivityDate, int iNoOfBox, int WorkOrderNo, int UserId, int iNoOfFile, int iDepartmentId, int iPickUpAddressId)
    {
        DataTable dtActivitiesTable;
        DataRow drActivityRow;
        int iActivityStatus = GetActivityStatus("Open");
        dtActivitiesTable = ActivitesTable();
        try
        {
            drActivityRow = dtActivitiesTable.NewRow();
            if (iSrNo == -1)
            {
                drActivityRow["ActivityId"] = iActivityId;
                drActivityRow["ActivityStatus"] = iActivityStatus;
                drActivityRow["SCName"] = strSCName;
                drActivityRow["ActivityName"] = strActivityName;
                drActivityRow["Remark"] = strRemark;
                drActivityRow["ActivityDate"] = strActivityDate;
                drActivityRow["NoOfBox"] = iNoOfBox;
                drActivityRow["NoOfFile"] = iNoOfFile;
                drActivityRow["WorkOrderNo"] = WorkOrderNo;
                drActivityRow["UserID"] = UserId;
                drActivityRow["DepartmentId"] = iDepartmentId;
                drActivityRow["PickUpAddressId"] = iPickUpAddressId;
                dtActivitiesTable.Rows.Add(drActivityRow);
                dtActivitiesTable.AcceptChanges();
                ViewState["WORE"] = iActivityId;
            }

            if (dtActivitiesTable.Rows.Count > 1)
            {
                if (Convert.ToInt16(dtActivitiesTable.Rows[0]["ActivityId"]) == 0)
                {
                    dtActivitiesTable.Rows[0].Delete();
                    dtActivitiesTable.AcceptChanges();
                }
            }
            ViewState["ActivitesTable"] = dtActivitiesTable;
        }
        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }
    }
    protected string WActivitiesXML
    {
        get
        {
            return Convert.ToString(ViewState["WActivitiesXML"]);
        }
        set
        {
            ViewState["WActivitiesXML"] = value;
        }
    }
    protected string RetrivalBoxFilelistXML
    {
        get
        {
            return Convert.ToString(ViewState["dtRetrvalBoxFileDetailsTable"]);
        }
        set
        {
            ViewState["dtRetrvalBoxFileDetailsTable"] = value;
        }
    }

    #endregion
    protected void ClearAll()
    {
        ClearNewOrderDetails();
        txtWorkOrderDate.Text = string.Empty;
        ddlWareHouse.SelectedIndex = 0;
        ddlCompanyGroup.SelectedIndex = 0;
        ddlCustomer.SelectedIndex = 0;
        txtRemark.Text = "";
        txtnoofboxes.Text = "";
        txtnooffiles.Text = "";
        txtdateofPickup.Text = "";
        lblBoxErrorMsg.Text = "";
        lblFileErrorMsg.Text = "";
        chkboxesconfirm.Checked = false;
        ddlCustomer.Items.Clear();
        ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlServiceRequest.Items.Clear();
        ddlServiceRequest.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        gvFilePickUpSRtoWO.DataSource = null;
        gvFilePickUpSRtoWO.DataBind();
        gvFilePickUpSRtoWO.Visible = false;
        gvRetreivalSRtoWO.DataSource = null;
        gvRetreivalSRtoWO.DataBind();
        gvRetreivalSRtoWO.Visible = false;
        gvOtherServicesSRtoWO.DataSource = null;
        gvOtherServicesSRtoWO.DataBind();
        gvOtherServicesSRtoWO.Visible = false;
    }
    protected int iRowId
    {
        get
        {
            return Convert.ToInt32(ViewState["iRowId"]);
        }
        set
        {
            ViewState["iRowId"] = value;
        }
    }
    protected int iActivityResult
    {
        get
        {
            return Convert.ToInt32(ViewState["iActivityResult"]);
        }
        set
        {
            ViewState["iActivityResult"] = value;
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        ClearAll();
        hdnTotalAddedActivity.Value = "0";
        lblMessage.Text = "";
        txtWorkOrderDate.Text = DateTime.Now.ToString("dd-MMM-yyyy", enGB);
        txtWorkOrderDate.Enabled = false;
    }
    protected void lnkbtnUpdateWOActivity_Click(object sender, EventArgs e)
    {
        BindUpdateWOActivity();
        lblMessage.Visible = false;
        lblMessage.Text = "";
    }
    protected void BindUpdateWOActivity()
    {
        divNewOrder.Style["display"] = "none";
        divSearchOrder.Style["display"] = "none";
        divUpdateWoActivity.Style["display"] = "block";
        lnkbtnSearchOrder.Style["color"] = "#4f4f4f !important;";
        lnkbtnUpdateWOActivity.Style["color"] = "blue !important;";
        lnkbtnNewWorkOrder.Style["color"] = "#4f4f4f !important;";

        BindDdlWareHouseUpdate();
        BindActivityStatusUpdate();
        BindCompanyGroupUpdate(0);
        ddlCustomerUpdate.Items.Clear();
        ddlWorkOrder.Items.Clear();

        ddlCustomerUpdate.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });

        if (ddlStatusUpdate.Items.Count > 0)
        {
            ddlStatusUpdate.SelectedIndex = 1;
        }

        if (ddlCompanyGroupUpdate.Items.Count > 0)
        {
            ddlCompanyGroupUpdate.SelectedIndex = 0;
        }
    }
    protected void BindActivityStatusUpdate()
    {
        string sAs = "ACTIVITY_STATUS";
        ddlStatusUpdate.DataSource = objPRSMBAL.GetApplicationCodeDetails(sAs, string.Empty);
        ddlStatusUpdate.DataValueField = "AppCodeId";
        ddlStatusUpdate.DataTextField = "AppCodeName";
        ddlStatusUpdate.DataBind();
        ddlStatusUpdate.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }
    protected void BindWorkOrder(int iworkorder, int icustomerid, int iwarehouseid, int istatus, DateTime? dFromDate, DateTime? dToDate)
    {
        DataSet dsGetWorkOrderData = objTRANSBAL.GetWorkOrder(0, 0, icustomerid, iwarehouseid, istatus, null, null);
        ddlWorkOrder.Items.Clear();
        ddlWorkOrder.DataSource = null;
        ddlWorkOrder.DataBind();
        if (dsGetWorkOrderData != null)
        {
            if (dsGetWorkOrderData.Tables.Count > 0)
            {
                ddlWorkOrder.DataSource = dsGetWorkOrderData.Tables[0];
                ddlWorkOrder.DataValueField = "WorkorderNo";
                ddlWorkOrder.DataTextField = "WorkorderNo";
                ddlWorkOrder.DataBind();
            }
        }
        ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }
    protected void ddlCompanyGroupUpdate_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlCompanyGroupUpdate.SelectedIndex > 0)
        {
            BindCustomerUpdate(Convert.ToByte(ddlCompanyGroupUpdate.SelectedItem.Value));
            ddlWorkOrder.Items.Clear();
            ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });

            txtActivityRemarkUpdate.Text = string.Empty;
        }
        else
        {
            ddlCustomerUpdate.Items.Clear();
            ddlCustomerUpdate.DataSource = null;
            ddlCustomerUpdate.DataBind();
            ddlCustomerUpdate.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlWorkOrder.Items.Clear();

            txtActivityRemarkUpdate.Text = string.Empty;
            ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlRequestedService.Items.Clear();
            ddlRequestedService.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }

    }
    protected void ddlWorkOrder_SelectedIndexChanged(object sender, EventArgs e)
    {
        int istatus = GetWorkActivityStatus("Open");
        if (ddlWorkOrder.SelectedIndex > 0)
        {
            txtActivityRemarkUpdate.Text = string.Empty;
            //ddlRequestedService.Items.Clear();
            BindWorkOrderActivites(0, Convert.ToInt32(ddlWorkOrder.SelectedValue), istatus);
        }
        else
        {
            txtActivityRemarkUpdate.Text = string.Empty;
            ddlRequestedService.Items.Clear();
            ddlRequestedService.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }

    }
    protected void BindDemoServiceRequests_close(int iWORK_ORDER)
    {
        DataSet dsServiceRequests2 = objPRSMBAL.GetServiceRequestDetailsByWorkorder(iWORK_ORDER);
        if (dsServiceRequests2 != null && dsServiceRequests2.Tables.Count > 0 && dsServiceRequests2.Tables[0].Rows.Count > 0)
        {
            hfRSemailid.Value = dsServiceRequests2.Tables[0].Rows[0]["CustomerEmail"].ToString();
            hfRequestedService.Value = dsServiceRequests2.Tables[0].Rows[0]["n_RequestNo"].ToString();
            hfcustusername.Value = dsServiceRequests2.Tables[0].Rows[0]["CustomerUserName"].ToString();
        }
    }
    protected void ddlCustomerUpdate_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlCustomerUpdate.SelectedIndex > 0)
        {
            int istatus = GetWorkStatus("Open");
            BindWorkOrder(0, Convert.ToInt32(ddlCustomerUpdate.SelectedValue), Convert.ToInt32(ddlWareHouseUpdate.SelectedValue), istatus, null, null);
            txtActivityRemarkUpdate.Text = string.Empty;
        }
        else
        {
            txtActivityRemarkUpdate.Text = string.Empty;
            ddlWorkOrder.Items.Clear();
            ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
    }

    protected string FPAllApproved()
    {
        string msg = "";
        DataSet ds;

        if (ddlRequestedService.SelectedItem.Text.Trim() == "File Pick Up")
        {
            if (Convert.ToInt32(ddlWorkOrder.SelectedValue) > 0)
            {
                ds = objTRANSBAL.CheckFilePickupAllApproved(Convert.ToInt32(ddlWorkOrder.SelectedValue), 1);
                if (ds != null && ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                        msg = ds.Tables[0].Rows[0][1].ToString();
                    if (ds.Tables[0].Rows.Count > 1)
                        msg = msg + " " + ds.Tables[0].Rows[1][1].ToString();
                }
            }
        }
        /*Retrieval File Pick Up Other services*/
        if (ddlRequestedService.SelectedItem.Text.Trim() == "Other services")
        {
            if (Convert.ToInt32(ddlWorkOrder.SelectedValue) > 0)
            {
                ds = objTRANSBAL.CheckFilePickupAllApproved(Convert.ToInt32(ddlWorkOrder.SelectedValue), 2);
                if (ds != null && ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                        msg = ds.Tables[0].Rows[0][1].ToString();
                    if (ds.Tables[0].Rows.Count > 1)
                        msg = msg + " " + ds.Tables[0].Rows[1][1].ToString();
                }
            }
        }
        if (ddlRequestedService.SelectedItem.Text.Trim() == "Retrieval")
        {
            if (Convert.ToInt32(ddlWorkOrder.SelectedValue) > 0)
            {
                ds = objTRANSBAL.CheckFilePickupAllApproved(Convert.ToInt32(ddlWorkOrder.SelectedValue), 3);
                if (ds != null && ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                        msg = ds.Tables[0].Rows[0][1].ToString();
                    if (ds.Tables[0].Rows.Count > 1)
                        msg = msg + " " + ds.Tables[0].Rows[1][1].ToString();
                }
            }
        }
        return msg;
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            try
            {
                string msg = "";
                if (ddlStatusUpdate.SelectedItem.Text == "Closed")
                {
                    msg = FPAllApproved();
                    msg = msg.Trim();
                }
                if (msg == "")
                {
                    string Returnstring = string.Empty;
                    int iActivityStatus = GetActivityStatus("Closed");
                    int? filecount = null;
                    int? boxcount = null;
                    boxcount = 0;
                    filecount = 0;
                    string WoActivitylist = GenrateUpdateWorkOrderActivity(ddlRequestedService.SelectedItem.Text);
                    // WoActivityId = 0 For  Insert 1  For Update
                    Returnstring = objTRANSBAL.AddUpdateWorkOrderActivities(WoActivitylist, 1, Convert.ToInt32(objPageBase.UserId), Convert.ToInt32(ddlStatusUpdate.SelectedItem.Value), boxcount, filecount, 0);
                    if (ddlRequestedService.SelectedItem.Text.Trim() == "File Pick Up")
                    {
                        try
                        {
                            for (int i = 0; i < grdWoOrderUpdFilePickupActivities.Rows.Count; i++)
                            {
                                CheckBox chkActual = (CheckBox)grdWoOrderUpdFilePickupActivities.Rows[i].FindControl("chkActual");
                                if (chkActual != null)
                                {
                                    chkActual.Visible = false;
                                    if (chkActual.Checked == true)
                                    {
                                        TextBox txtUpdateLumsumAount = (TextBox)grdWoOrderUpdFilePickupActivities.Rows[i].FindControl("txtUpdateLumsumAount");
                                        HiddenField hdnWoActivityId = (HiddenField)grdWoOrderUpdFilePickupActivities.Rows[i].FindControl("hdnWoActivityId");
                                        string sres = objTRANSBAL.InsertOtherTransactions(0, Convert.ToInt32(hdnWoActivityId.Value), 1, "", Convert.ToInt32(objPageBase.UserId), Convert.ToDecimal(txtUpdateLumsumAount.Text));
                                    }
                                }
                            }

                        }
                        catch (Exception ex)
                        {
                            ErrorHandler.WriteLog(ex);
                        }
                    }
                    lblMessage.Visible = true;
                    lblMessage.Text = Returnstring;
                    if (ddlStatusUpdate.SelectedItem.Text == "Closed")
                    {
                        BindDemoServiceRequests_close(Convert.ToInt32(ddlWorkOrder.SelectedValue));
                        if (hfRSemailid.Value.Trim().Length > 0 && hfRequestedService.Value.Trim().Length > 0)
                        {
                            sendMail_to_customer_statusclose();
                        }

                    }
                    ClearWOActivity();
                    if (ddlStatusUpdate.Items.Count > 0)
                    {
                        ddlStatusUpdate.SelectedIndex = 1;
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('" + msg + "')", true);

                    ClearAllForCheckClose();
                    return;
                }
            }
            catch (Exception ex)
            {
                ErrorHandler.WriteLog(ex);
            }
            finally { ClearUpdateRequstedServices(); }
        }
    }
    protected void sendMail_to_customer_statusclose()
    {
        string AdminMaidId = System.Configuration.ConfigurationManager.AppSettings["AdminEmail"].ToString();
        string strNote = "*** This is autogenerated mail, please do not reply ***";

        //create the mail message
        MailMessage mail = new MailMessage();

        //set the addresses
        //mail.From = new MailAddress(txtemailid.Text.ToString());
        mail.From = new MailAddress(AdminMaidId);

        string BCCEmailIds = string.Empty;
        //set customer mail id
        mail.To.Add(hfRSemailid.Value);
        //mail.Bcc.Add(System.Configuration.ConfigurationManager.AppSettings["AdminEmail"].ToString());
        ds = ObjPRSMBAL.GetEmailIds();
        if (ds.Tables.Count > 0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    if (ds.Tables[0].Rows[i]["EmailType"].ToString() == "R_Email_To")
                    {
                        mail.To.Add(ds.Tables[0].Rows[i]["EmailId"].ToString());
                    }
                    if (ds.Tables[0].Rows[i]["EmailType"].ToString() == "R_Email_Bcc")
                    {
                        mail.Bcc.Add(ds.Tables[0].Rows[i]["EmailId"].ToString());
                    }
                    if (ds.Tables[0].Rows[i]["EmailType"].ToString() == "R_Email_cc")
                    {
                        mail.CC.Add(ds.Tables[0].Rows[i]["EmailId"].ToString());
                    }
                }
            }
        }

        //set the content
        mail.Subject = "Work Order No. " + ddlWorkOrder.SelectedValue + " closed against Service Request No. " + hfRequestedService.Value + " ";
        string MailText = "Dear " + hfcustusername.Value + ",<br /><br />" + "We have closed work order - " + ddlWorkOrder.SelectedValue + ", kindly find below the details.<br /><br />";
        MailText += "WorkOrder Details : <br />";
        //MailText += "<table width='610px'  border='0' cellspacing='0' cellpadding='5' bgcolor='#F1EFFD'>";
        //MailText += "<tr>";
        MailText += "<table width='600px'  border='0' cellspacing='0' cellpadding='3'  bgcolor='#F1EFFD'>";
        MailText += "<tr>";
        MailText += "<td >UserName</td>";
        MailText += "<td>:</td>";
        MailText += "<td colspan='4'>";
        MailText += " " + hfcustusername.Value + " ";
        MailText += "</td>";
        MailText += "</tr>";

        MailText += "<tr>";
        MailText += "<td >Date</td>";
        MailText += "<td>:</td>";
        MailText += "<td colspan='4'>";
        MailText += txtWorkOrderDate.Text;
        //DateTime.Parse(txtWorkOrderDate.Text.Trim()).ToString("dd-MMM-yyyy", CultureInfo.InvariantCulture)
        MailText += "</td>";
        MailText += "</tr>";

        //MailText += "<tr>";
        //MailText += "<td >WareHouse</td>";
        //MailText += "<td>:</td>";
        //MailText += "<td colspan='4'>";
        //MailText += "" + ddlWareHouseUpdate.SelectedItem.ToString() + " ";
        //MailText += "</td>";
        //MailText += "</tr>";

        MailText += "<tr>";
        MailText += "<td >Customer</td>";
        MailText += "<td>:</td>";
        MailText += "<td colspan='4'>";
        MailText += "" + ddlCustomerUpdate.SelectedItem.ToString() + " ";
        MailText += "</td>";
        MailText += "</tr>";

        MailText += "<tr>";
        MailText += "<td >Service Request</td>";
        MailText += "<td>:</td>";
        MailText += "<td colspan='4'>";
        MailText += "" + hfRequestedService.Value + " ";
        MailText += "</td>";
        MailText += "</tr>";

        MailText += "<tr>";
        MailText += "<td >Type of Service Request</td>";
        MailText += "<td>:</td>";
        MailText += "<td colspan='4'>";
        MailText += "" + ddlRequestedService.SelectedItem.ToString() + " ";
        MailText += "</td>";
        MailText += "</tr>";

        MailText += "<tr>";
        MailText += "<td >Status</td>";
        MailText += "<td>:</td>";
        MailText += "<td colspan='4'>";
        MailText += "<b>Completed</b> ";
        MailText += "</td>";
        MailText += "</tr>";

        MailText += "<tr>";
        MailText += "<td >Work Order</td>";
        MailText += "<td>:</td>";
        MailText += "<td colspan='4'>";
        MailText += "" + ddlWorkOrder.SelectedValue + " ";
        MailText += "</td>";
        MailText += "</tr>";

        if (hdPickup_filecount.Value.Trim() != "" && hdPickup_filecount.Value.Trim() != "0")
        {
            MailText += "<tr>";
            MailText += "<td >Pickup File Count</td>";
            MailText += "<td>:</td>";
            MailText += "<td colspan='4'>";
            MailText += "" + hdPickup_filecount.Value + " ";
            MailText += "</td>";
            MailText += "</tr>";
        }

        if (hdPickup_boxcount.Value.Trim() != "" && hdPickup_boxcount.Value.Trim() != "0")
        {
            MailText += "<tr>";
            MailText += "<td >Pickup Box Count</td>";
            MailText += "<td>:</td>";
            MailText += "<td colspan='4'>";
            MailText += "" + hdPickup_boxcount.Value + " ";
            MailText += "</td>";
            MailText += "</tr>";
        }
        if (hdRetrival_filecount.Value.Trim() != "" && hdRetrival_filecount.Value.Trim() != "0")
        {
            MailText += "<tr>";
            MailText += "<td >Retrival File Count</td>";
            MailText += "<td>:</td>";
            MailText += "<td colspan='4'>";
            MailText += "" + hdRetrival_filecount.Value + " ";
            MailText += "</td>";
            MailText += "</tr>";
        }
        if (hdRetrival_boxcount.Value.Trim() != "" && hdRetrival_boxcount.Value.Trim() != "0")
        {
            MailText += "<tr>";
            MailText += "<td >Retrival Box Count</td>";
            MailText += "<td>:</td>";
            MailText += "<td colspan='4'>";
            MailText += "" + hdRetrival_boxcount.Value + " ";
            MailText += "</td>";
            MailText += "</tr>";
        }

        MailText += "<tr>";
        MailText += "<td width='100'>Email</td>";
        MailText += "<td width='10'>:</td>";
        MailText += "<td width='250'>";
        MailText += " " + hfRSemailid.Value + " ";
        MailText += "</td>";
        MailText += "<td ></td>";
        MailText += "<td></td>";
        MailText += "<td>";
        MailText += "  ";
        MailText += "</td>";
        MailText += "</tr>";

        MailText += "</table>";
        MailText += "<br /><br />Regards,<br /><strong>" + Regards + "</strong><br /><br />";
        MailText += "<br />" + strNote + "<br /><br />";
        mail.Body = MailText;
        mail.IsBodyHtml = true;
        //send the message
        SmtpClient smtp = new SmtpClient("smtp3.netcore.co.in", GetSMTPPort());
        smtp.UseDefaultCredentials = false;
        smtp.Credentials = new System.Net.NetworkCredential("pul@panoramicworld.biz", "$0Lut!0n");
        smtp.Send(mail);


    }
    public void ClearAllForCheckClose()
    {
        ddlCustomerUpdate.Items.Clear();
        ddlWorkOrder.Items.Clear();
        ddlRequestedService.Items.Clear();

        ddlCustomerUpdate.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlRequestedService.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });

        ddlWareHouseUpdate.SelectedIndex = 0;
        ddlCompanyGroupUpdate.SelectedIndex = 0;
        ddlCustomerUpdate.SelectedIndex = 0;
        ddlWorkOrder.SelectedIndex = 0;
        ddlRequestedService.SelectedIndex = 0;
        ddlStatusUpdate.SelectedIndex = 0;
        lblMessage.Text = "";
    }
    protected void ClearUpdateRequstedServices()
    {
        grdWoOrderUpdFilePickupActivities.DataSource = null;
        grdWoOrderUpdFilePickupActivities.DataBind();
    }
    protected void ddlRequestedService_SelectedIndexChanged(object sender, EventArgs e)
    {
        int istatus = GetActivityStatus("Open");
        grdWoOrderUpdFilePickupActivities.DataSource = null;
        grdWoOrderUpdFilePickupActivities.DataBind();
        if (ddlRequestedService.SelectedIndex > 0)
        {
            int iRequestedService = Convert.ToInt32(ddlRequestedService.SelectedItem.Value);
            DataSet dsWOActivity = objTRANSBAL.GetWoActivity(0, Convert.ToInt32(ddlWorkOrder.SelectedValue), istatus, "Work Order", iRequestedService);
            if (ddlRequestedService.SelectedIndex > 0)
            {
                if (dsWOActivity.Tables[0].Rows.Count > 0)
                {
                    //hfRSemailid.Value = dsServiceRequests2.Tables[0].Rows[0]["CustomerEmail"].ToString();
                    hdPickup_filecount.Value = dsWOActivity.Tables[0].Compute("Sum(FileCount)", "ActivityId = 2").ToString();
                    hdPickup_boxcount.Value = dsWOActivity.Tables[0].Compute("Sum(BoxCount)", "ActivityId = 1").ToString();
                    hdRetrival_filecount.Value = dsWOActivity.Tables[0].Compute("Sum(FileCount)", "ActivityId In (8,9,10,11,12,13,14,15)").ToString();
                    hdRetrival_boxcount.Value = dsWOActivity.Tables[0].Compute("Sum(BoxCount)", "ActivityId In (8,9,10,11,12,13,14,15)").ToString();
                    //hdRestore_filecount.Value = dsWOActivity.Tables[0].Compute("Sum(FileCount)", "ActivityId = 2").ToString();
                    //hdRestore_boxcount.Value = dsWOActivity.Tables[0].Compute("Sum(BoxCount)", "ActivityId = 1").ToString();

                    grdWoOrderUpdFilePickupActivities.DataSource = dsWOActivity.Tables[0];
                    grdWoOrderUpdFilePickupActivities.DataBind();
                }
            }
        }

        if (ddlStatusUpdate.SelectedItem.Text == "Closed")
        {
            if (ddlRequestedService.SelectedItem.Text == "File Pick Up")
            {
                int n_PendingCount = 0;
                n_PendingCount = objTRANSBAL.GetPendingFreshFilePickupCountByWorkorderNo(Convert.ToInt32(ddlWorkOrder.SelectedValue));


                if (n_PendingCount > 0)
                {
                    ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('" + n_PendingCount + " Files pending for approval\\nWork Order can not be closed at this time')", true);
                    btnSubmit.Visible = false;
                    return;
                }

            }
            btnSubmit.Visible = true;
        }
    }
    protected string GenrateUpdateWorkOrderActivity(string ServiceName)
    {
        StringBuilder sbGenrateXml = new StringBuilder();
        int iWorkorderNo = 0;
        if (ddlWorkOrder.SelectedIndex > 0)
        {
            iWorkorderNo = Convert.ToInt32(ddlWorkOrder.SelectedItem.Value);
        }
        sbGenrateXml.Append("<NewDataSet> ");
        for (int i = 0; i < grdWoOrderUpdFilePickupActivities.Rows.Count; i++)
        {
            int iNoOfBox = 0, iNoOfFile = 0, iWoActivityId = 0; bool Ischecked = false;
            HiddenField hdnWoActivityId = (HiddenField)grdWoOrderUpdFilePickupActivities.Rows[i].FindControl("hdnWoActivityId");
            TextBox txtBoxCount = (TextBox)grdWoOrderUpdFilePickupActivities.Rows[i].FindControl("txtBoxCount");
            TextBox txtFileCount = (TextBox)grdWoOrderUpdFilePickupActivities.Rows[i].FindControl("txtFileCount");
            CheckBox chkActual = (CheckBox)grdWoOrderUpdFilePickupActivities.Rows[i].FindControl("chkActual");
            Label lblActivity = (Label)grdWoOrderUpdFilePickupActivities.Rows[i].FindControl("lblActivity");
            if (lblActivity != null)
                if (lblActivity.Text.Trim().ToUpper() == "Standard Box Transportation".ToUpper())
                {
                    Ischecked = false;
                    if (chkActual != null)
                    {
                        if (chkActual.Checked == true)
                        {
                            Ischecked = true;
                        }
                    }
                }

            if (hdnWoActivityId != null)
            {
                iWoActivityId = Convert.ToInt32(hdnWoActivityId.Value);
            }
            if (hdnWoActivityId != null)
            {
                if (Ischecked == false)
                {
                    iNoOfBox = Convert.ToInt32(txtBoxCount.Text);
                }
            }
            if (txtFileCount != null)
            {
                if (Ischecked == false)
                {
                    iNoOfFile = Convert.ToInt32(txtFileCount.Text);
                }
                else
                {
                    iNoOfFile = 0;
                }
            }
            sbGenrateXml.Append("<Root>");
            sbGenrateXml.Append("<WorkOrderNo>" + iWorkorderNo + "</WorkOrderNo>");
            sbGenrateXml.Append("<WoActivityId>" + iWoActivityId + " </WoActivityId>");
            sbGenrateXml.Append("<NoOfBox>" + iNoOfBox + " </NoOfBox>");
            sbGenrateXml.Append("<NoOfFile>" + iNoOfFile + " </NoOfFile>");
            sbGenrateXml.Append("</Root>");
        }
        sbGenrateXml.Append("</NewDataSet>");
        return sbGenrateXml.ToString();

    }
    protected void ClearWOActivity()
    {
        ddlWareHouseUpdate.SelectedIndex = 0;
        ddlCompanyGroupUpdate.SelectedIndex = 0;
        ddlCustomerUpdate.Items.Clear();
        ddlCustomerUpdate.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlWorkOrder.Items.Clear();
        ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        ddlRequestedService.Items.Clear();
        ddlRequestedService.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        txtActivityRemarkUpdate.Text = string.Empty;
    }
    protected void BtnClear_Click(object sender, EventArgs e)
    {
        ClearWOActivity();
        lblMessage.Text = "";
        btnSubmit.Enabled = true;
    }
    protected void gdvSearchWorkOrder_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "lnkview")
        {
            int iworkorderno = Convert.ToInt32(e.CommandArgument.ToString());
            ViewState["WorkOrderNo"] = iworkorderno;
            HttpContext.Current.Session["WorkOrderNo"] = iworkorderno;
            DataSet dsGetWorkOrder = objTRANSBAL.GetWorkOrder(0, 0, 0, 0, 0, null, null);
            try
            {
                if (dsGetWorkOrder.Tables.Count > 0)
                {
                    if (dsGetWorkOrder.Tables[0].Rows.Count > 0)
                    {
                        DataTable dt;
                        DataView dvWo = new DataView();
                        dvWo = dsGetWorkOrder.Tables[0].DefaultView;
                        dvWo.RowFilter = "WorkorderNo=" + e.CommandArgument.ToString();
                        dt = dvWo.ToTable();
                        if (dt.Rows.Count > 0)
                        {
                            lb1CustomerAddress.Text = dt.Rows[0]["BillingAddress"].ToString();
                            lblSearchCustomer.Text = dt.Rows[0]["CustomerName"].ToString();

                            if (!string.IsNullOrEmpty(Convert.ToString(dt.Rows[0]["WorkOrderDate"].ToString())))
                            {
                                lblSearchDate.Text = Convert.ToString(dt.Rows[0]["WorkOrderDate"].ToString());
                            }
                            lblSearchStatus.Text = dt.Rows[0]["WoStatus"].ToString();
                            //lblPickAddress.Text = dt.Rows[0]["Address"].ToString();
                            if (dt.Rows[0]["WoStatus"].ToString() == "Open")
                            {
                                lblClosdate.Text = "Closed Date";
                                lblClosdate.Visible = false;
                                lblWoCloseDate.Visible = false;
                            }
                            else
                            {
                                lblClosdate.Visible = true;
                                lblWoCloseDate.Visible = true;
                                if (!string.IsNullOrEmpty(Convert.ToString(dt.Rows[0]["ModificationDate"].ToString())))
                                {
                                    lblWoCloseDate.Text = Convert.ToString(dt.Rows[0]["ModificationDate"].ToString());
                                }

                            }

                        }
                    }

                    lbldisplayWorkororderNo.Text = e.CommandArgument.ToString();
                    DataSet dsWOActivity = objTRANSBAL.GetWoActivity(0, iworkorderno, 0, "Work Order", 0);
                    if (dsWOActivity != null)
                    {
                        if (dsWOActivity.Tables.Count > 0)
                        {
                            BidWOList();
                            BindServiceRequests();
                        }
                    }

                    ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "changesearch('ContentPlaceHolder1_ddlSearchRequestby');divShowWodetails();", true);
                }
            }
            catch (Exception ex)
            {
                ErrorHandler.WriteLog(ex);
            }
        }
    }
    #region [Rolewise access page funcationality]
    public void SetRolewiseAcessfuncationality()
    {
        UserRolewiseAcess objUserRoleWiseAcessDAL = new UserRolewiseAcess();
        DataTable dtPageId = objUserRoleWiseAcessDAL.GetApplicationCodeDetails("Page_Name", "Work Order").Tables[0];
        int PageId = 0;
        if (dtPageId.Rows.Count > 0)
        {
            PageId = Convert.ToInt32(dtPageId.Rows[0][0]);
        }
        DataTable dtPagefuncationality = objUserRoleWiseAcessDAL.GetPageFunctionalityByRoleAndPageId(PageId, RoleId).Tables[0];
        btnSave.Visible = false;
        btnCancel.Visible = false;
        btnSearch.Visible = false;

        btnSubmit.Visible = false;
        BtnClear.Visible = false;

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
                            btnSubmit.Visible = true;
                            break;
                        case "View Details":
                            ViewState["IsEditGrid"] = true;
                            break;
                        case "Clear":
                            btnCancel.Visible = true;
                            BtnClear.Visible = true;
                            break;
                        case "Add":
                            //  btnAddActivity.Visible = true;
                            break;
                        case "Search":
                            btnSearch.Visible = true;
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
        if (gdvSearchWorkOrder.Rows.Count > 0 && IsEditGrid == false)
        {
            for (int i = 0; i < gdvSearchWorkOrder.Rows.Count; i++)
            {
                LinkButton lnkbtnview = (LinkButton)gdvSearchWorkOrder.Rows[i].FindControl("lnkbtnview");
                if (lnkbtnview != null)
                {
                    lnkbtnview.Visible = false;
                }
            }
        }
    }
    #endregion
    protected void ddlWareHouseUpdate_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlWareHouseUpdate.SelectedIndex > 0)
        {
            BindCompanyGroupUpdate(0);
            ddlCustomerUpdate.Items.Clear();
            ddlCustomerUpdate.DataSource = null;
            ddlCustomerUpdate.DataBind();
            ddlCustomerUpdate.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlWorkOrder.Items.Clear();
            ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            clearWoActiviyDropDown();
        }
        else
        {
            ddlCompanyGroupUpdate.Items.Clear();
            ddlCustomerUpdate.Items.Clear();
            ddlCustomerUpdate.DataSource = null;
            ddlCustomerUpdate.DataBind();
            ddlCompanyGroupUpdate.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlCustomerUpdate.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            ddlWorkOrder.Items.Clear();
            ddlWorkOrder.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
            clearWoActiviyDropDown();
        }
    }
    protected void clearWoActiviyDropDown()
    {
        txtActivityRemarkUpdate.Text = string.Empty;
        ddlCustomerUpdate.Items.Clear();
        ddlCustomerUpdate.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });

    }
    protected void ddlCustomer_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlCustomer.SelectedIndex > 0)
        {
            int iCustomerId = Convert.ToInt32(ddlCustomer.SelectedValue);
            BindPickUpAddress(iCustomerId);
            BindServiceRequests(iCustomerId);
            Session["WorkOrder_ActivityList"] = null;
            ClearServiceRequestDetails();
        }


    }
    protected void ddlSearchCG_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlSearchCG.SelectedIndex > 0)
        {
            BindCustomer(Convert.ToByte(ddlSearchCG.SelectedItem.Value));
        }
        else
        {
            ddlSearchCGCustomer.Items.Clear();
            ddlSearchCGCustomer.DataSource = null;
            ddlSearchCGCustomer.DataBind();
            ddlSearchCGCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
    }
    protected void gdvSearchWorkOrder_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gdvSearchWorkOrder.PageIndex = e.NewPageIndex;
        BidDefaultGirdAcitvitySetting();
    }
    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        Director director = new Director();
        IBuilder b1 = new ConcreteBuilder();
        int WONo = 0;
        if (ViewState["WorkOrderNo"] != null)
        {
            WONo = Convert.ToInt32(ViewState["WorkOrderNo"].ToString());
        }
        b1.WorkOrderNo = WONo;
        try
        {
            director.Construct(b1);
            Product p1 = b1.GetResult();
            p1.Show();
        }
        catch (Exception ex)
        {

            ErrorHandler.WriteLog(ex); ;
        }
    }
    #region Save New WorkOrders details

    protected void txtNoOfServices(object sender, EventArgs eventArgs)
    {
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "ShowInfo", "showFiledetails();", true);
        ViewState["OtherServicesActivityList"] = null;
        grdOtherServicesFiles.DataSource = null;
        grdOtherServicesFiles.DataBind();
        int iOtherServicesServiceCategId = 0;
        int iCustomerId = Convert.ToInt32(ddlCustomer.SelectedValue);
        if (!string.IsNullOrEmpty(rdblst.Items.FindByText("Other services").Value))
        {
            iOtherServicesServiceCategId = Convert.ToInt32(rdblst.Items.FindByText("Other services").Value);
        }
        foreach (GridViewRow row in grdOtherAddServiceActivity.Rows)
        {
            TextBox txtNoOfServices = (TextBox)row.FindControl("txtNoOfServices");
            Label lblActivityName = (Label)row.FindControl("lblName");
            if (txtNoOfServices.Text.Trim() != "" && lblActivityName.Text.Trim() == "File Retrieval")
            {
                int count = txtNoOfServices.Text == "" ? 0 : Convert.ToInt32(txtNoOfServices.Text);
                for (int k = 0; k < count; k++)
                {

                    HiddenField hdnActivityid = (HiddenField)row.FindControl("hdnActivityid");
                    Label lblName = (Label)row.FindControl("lblName");
                    AddOtherServicesActivitylist(iOtherServicesServiceCategId, Convert.ToInt32(hdnActivityid.Value), lblName.Text, "", "", "");
                }
            }
        }
        divotherservicefiledetails.Style["display"] = "block";
        grdOtherServicesFiles.DataSource = lstOtherServicesActivityList.ToList();
        grdOtherServicesFiles.DataBind();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {

        if (ddlWareHouse.SelectedIndex > 0 && ddlCompanyGroup.SelectedIndex > 0 && ddlCustomer.SelectedIndex > 0)
        {
            if (rdblst.SelectedIndex == -1)
            {
                lblMessage.Visible = true;
                lblMessage.Text = "Please select at least one service!";
                return;
            }
        }
        if (Page.IsValid)
        {

            int CountFileAccess = 0;
            int CountAuditRoomValue = 0;
            int CountFileDocumentInsertion = 0;
            int photocopy = 0;
            int CountFaxStd = 0;
            int ScanningEmail = 0;
            int Faxlocal = 0;
            for (int i = 0; i < rdblst.Items.Count; i++)
            {
                if (rdblst.Items[i].Selected)
                {
                    string ServiceName = rdblst.Items[i].Text.Trim();
                    if (ddlServiceRequest.SelectedValue == "0")
                    {
                        if (ServiceName.Trim() == "Other services")
                        {
                            foreach (GridViewRow row in grdOtherAddServiceActivity.Rows)
                            {
                                //count = 0;
                                TextBox txtNoOfServices = (TextBox)row.FindControl("txtNoOfServices");
                                Label lblActivityName = (Label)row.FindControl("lblName");
                                if (txtNoOfServices.Text.Trim() != "" && lblActivityName.Text.Trim() == "Audit Room Charges")
                                {
                                    CountAuditRoomValue = Convert.ToInt32(txtNoOfServices.Text.Trim());
                                }
                                if (txtNoOfServices.Text.Trim() != "" && lblActivityName.Text.Trim() == "Document Searching & Insertion")
                                {
                                    CountFileDocumentInsertion = Convert.ToInt32(txtNoOfServices.Text.Trim());
                                }
                                if (txtNoOfServices.Text.Trim() != "" && lblActivityName.Text.Trim() == "File Retrieval")
                                {
                                    CountFileAccess = Convert.ToInt32(txtNoOfServices.Text.Trim());
                                }
                                if (txtNoOfServices.Text.Trim() != "" && lblActivityName.Text.Trim() == "Photocopy")
                                {
                                    photocopy = Convert.ToInt32(txtNoOfServices.Text.Trim());
                                }
                                if (txtNoOfServices.Text.Trim() != "" && lblActivityName.Text.Trim() == "Scanning & Email")
                                {
                                    ScanningEmail = Convert.ToInt32(txtNoOfServices.Text.Trim());
                                }
                                if (txtNoOfServices.Text.Trim() != "" && lblActivityName.Text.Trim() == "Fax – local")
                                {
                                    Faxlocal = Convert.ToInt32(txtNoOfServices.Text.Trim());
                                }
                                if (txtNoOfServices.Text.Trim() != "" && lblActivityName.Text.Trim() == "Fax – STD")
                                {
                                    CountFaxStd = Convert.ToInt32(txtNoOfServices.Text.Trim());
                                }
                            }
                            int flagfileaccess = 0;
                            if (photocopy == 0 && ScanningEmail == 0 && Faxlocal == 0 && CountFaxStd == 0 && CountFileDocumentInsertion == 0 && CountAuditRoomValue == 0 && CountFileAccess > 0)
                            {
                                flagfileaccess = 1;
                            }
                            if (flagfileaccess != 1)
                            {
                                if (photocopy > 0 || ScanningEmail > 0 || Faxlocal > 0 || CountFaxStd > 0 || CountFileDocumentInsertion >= 0 && (CountAuditRoomValue == 0))
                                {
                                    if (CountFileAccess < 1)
                                    {
                                        if (CountFileAccess == 0 || CountFileDocumentInsertion == 0)
                                        {
                                            ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('Please enter same no of services count for File Retrieval and Document Searching & Insertion.')", true);
                                            return;
                                        }
                                    }
                                    if (CountFileAccess > 0)
                                    {
                                        if (CountFileDocumentInsertion == 0)
                                        {
                                            ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('Please enter same no of services count for File Retrieval and Document Searching & Insertion.')", true);
                                            return;
                                        }
                                    }

                                }
                            }

                            if (CountFileDocumentInsertion != CountFileAccess && CountFileDocumentInsertion > 0 && CountFileAccess > 0)
                            {
                                ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('Please enter same no of services count for File Retrieval and Document Searching & Insertion.')", true);
                                return;
                            }

                            if (CountFileAccess > 0)
                            {
                                if (grdOtherServicesFiles.Rows.Count > 0)
                                {
                                    foreach (GridViewRow row in grdOtherServicesFiles.Rows)
                                    {
                                        TextBox txtNoofServices = (TextBox)row.FindControl("txtOtherServicesFileBarcode");
                                        if (txtNoofServices.Text == "")
                                        {
                                            ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('Please Select  Box Bar Code ,File Bar Code.')", true);
                                            return;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            string sReturnString = string.Empty;
            string sReturnStringwoAct = string.Empty;

            WorkOrder objwo = new WorkOrder();
            objwo.WorkorderNo = 0;
            objwo.WoDate = Convert.ToDateTime(txtWorkOrderDate.Text.ToString(), enGB);
            objwo.CustomerId = Convert.ToInt32(ddlCustomer.SelectedValue.ToString());
            objwo.Remark = txtRemark.Text;
            objwo.wareHouseId = Convert.ToInt32(ddlWareHouse.SelectedValue.ToString());
            objwo.StatuseId = Convert.ToInt32(ddlServiceStatus.SelectedValue.ToString());
            objwo.UserId = Convert.ToInt16(objPageBase.UserId);
            AddWorkOrderServices();
            // string RetrivalBoxFilelistXML = "";
            if (ddlServiceRequest.SelectedValue == "0")
            {
                DataTable dtRemovedColumn = (DataTable)(ViewState["ActivitesTable"]);
                dtRemovedColumn.TableName = "Root";
                DataSet dsNewSet = new DataSet();
                dsNewSet.Tables.Add(dtRemovedColumn);
                WActivitiesXML = "<NewDataSet/>";
                if (dtRemovedColumn != null)
                {
                    WActivitiesXML = dsNewSet.GetXml();
                }

                DataTable dtRetrvalBoxFileDetailsTable = (DataTable)(ViewState["dtRetrvalBoxFileDetailsTable"]);
                if (dtRetrvalBoxFileDetailsTable != null)
                {
                    dtRetrvalBoxFileDetailsTable.TableName = "Root";
                    DataSet dsNewSetRetrival = new DataSet();
                    dsNewSetRetrival.Tables.Add(dtRetrvalBoxFileDetailsTable);
                    RetrivalBoxFilelistXML = "<NewDataSet/>";
                    if (dtRetrvalBoxFileDetailsTable != null)
                    {
                        RetrivalBoxFilelistXML = dsNewSetRetrival.GetXml();
                    }
                    DataSet dsRetrvalBoxF = new DataSet();
                    //if (dtRetrvalBoxFileDetailsTable != null)
                    //{
                    //    dsRetrvalBoxF.Tables.Add(dtRetrvalBoxFileDetailsTable);
                    //    RetrivalBoxFilelistXML = dsRetrvalBoxF.GetXml();
                    //}
                }
                else
                {
                    RetrivalBoxFilelistXML = "<NewDataSet/>";
                }
            }
            else
            {
                //WActivitiesXML = "";
                DataTable dtRemovedColumn = (DataTable)(ViewState["ActivitesTable"]);
                dtRemovedColumn.TableName = "Root";
                DataSet dsNewSet = new DataSet();
                dsNewSet.Tables.Add(dtRemovedColumn);
                WActivitiesXML = "<NewDataSet/>";
                if (dtRemovedColumn != null)
                {
                    WActivitiesXML = dsNewSet.GetXml();
                }
                DataTable dtRetrvalBoxFileDetailsTable = (DataTable)(ViewState["dtRetrvalBoxFileDetailsTable"]);
                if (dtRetrvalBoxFileDetailsTable != null)
                {
                    dtRetrvalBoxFileDetailsTable.TableName = "Root";
                    DataSet dsNewSetRetrival = new DataSet();
                    dsNewSetRetrival.Tables.Add(dtRetrvalBoxFileDetailsTable);
                    RetrivalBoxFilelistXML = "<NewDataSet/>";
                    if (dtRetrvalBoxFileDetailsTable != null)
                    {
                        RetrivalBoxFilelistXML = dsNewSetRetrival.GetXml();
                    }
                    //RetrivalBoxFilelistXML = "<NewDataSet/>";
                }
                else
                {
                    RetrivalBoxFilelistXML = "<NewDataSet/>";
                }
            }
            int iActivityStatus = GetActivityStatus("Open");
            try
            {
                objwo.ActivityStatus = iActivityStatus;
                objwo.x_WorkorderList = WActivitiesXML;
                objwo.x_RetrivalFileBoxList = RetrivalBoxFilelistXML;
                objwo.ServiceRequestNo = Convert.ToInt32(ddlServiceRequest.SelectedValue);
                sReturnString = objTRANSBAL.AddUpdateWorkOrder(objwo);
                lblMessage.Visible = true;
                lblMessage.Text = sReturnString;

                lblMessage.ForeColor = System.Drawing.Color.Green;

                if (ddlServiceRequest.SelectedIndex > 0)
                {
                    //int iServiceRequest = Convert.ToInt32(ddlServiceRequest.SelectedValue);
                    BindDemoServiceRequests(Convert.ToInt32(sReturnString.Substring(47, 10)));

                }
                if (ddlServiceRequest.SelectedIndex > 0)
                {
                    txtWO.Text = sReturnString.Substring(47, 10);
                    sendMail_to_customer();
                    ClearAll();
                    txtWorkOrderDate.Text = DateTime.Now.ToString("dd-MMM-yyyy", enGB);
                    txtWorkOrderDate.Enabled = false;
                }
                else
                {

                    ClearAll();
                    txtWorkOrderDate.Text = DateTime.Now.ToString("dd-MMM-yyyy", enGB);
                    txtWorkOrderDate.Enabled = false;
                }
            }
            catch (Exception ex)
            {
                ErrorHandler.WriteLog(ex);
                lblMessage.Visible = true;
                lblMessage.Text = "Error in Saving : " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }


        }
    }
    public void BindDemoServiceRequests(int iServiceRequest)
    {
        DataSet dsServiceRequests1 = objPRSMBAL.GetServiceRequestDetailsByWorkorder(iServiceRequest);
        if (dsServiceRequests1 != null && dsServiceRequests1.Tables.Count > 0 && dsServiceRequests1.Tables[0].Rows.Count > 0)
        {
            hfemailid.Value = dsServiceRequests1.Tables[0].Rows[0]["CustomerEmail"].ToString();
            hfcustusername.Value = dsServiceRequests1.Tables[0].Rows[0]["CustomerUserName"].ToString();
        }
    }
    protected void sendMail_to_customer()
    {

        string AdminMaidId = System.Configuration.ConfigurationManager.AppSettings["AdminEmail"].ToString();
        string strNote = "*** This is autogenerated mail, please do not reply ***";

        string TypeofServiceRequired = string.Empty;
        foreach (ListItem item in rdblst.Items)
        {
            if (item.Selected == true)
            {
                item.Selected = false;
                TypeofServiceRequired += "," + item.Text.ToString();
            }
        }

        ViewState["TypeofServiceRequired"] = TypeofServiceRequired.ToString().TrimStart(',');


        //create the mail message
        MailMessage mail = new MailMessage();

        //set the addresses
        //mail.From = new MailAddress(txtemailid.Text.ToString());
        mail.From = new MailAddress(AdminMaidId);

        string BCCEmailIds = string.Empty;
        //set customer mail id
        mail.To.Add(hfemailid.Value);
        //mail.Bcc.Add(System.Configuration.ConfigurationManager.AppSettings["AdminEmail"].ToString());
        ds = ObjPRSMBAL.GetEmailIds();
        if (ds.Tables.Count > 0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    if (ds.Tables[0].Rows[i]["EmailType"].ToString() == "R_Email_To")
                    {
                        mail.To.Add(ds.Tables[0].Rows[i]["EmailId"].ToString());
                    }
                    if (ds.Tables[0].Rows[i]["EmailType"].ToString() == "R_Email_Bcc")
                    {
                        mail.Bcc.Add(ds.Tables[0].Rows[i]["EmailId"].ToString());
                    }
                    if (ds.Tables[0].Rows[i]["EmailType"].ToString() == "R_Email_cc")
                    {
                        mail.CC.Add(ds.Tables[0].Rows[i]["EmailId"].ToString());
                    }
                }
            }
        }

        //set the content
        mail.Subject = "Work Order No. " + txtWO.Text + " created against Service Request No. " + ddlServiceRequest.SelectedValue + " ";
        string MailText = "Dear " + hfcustusername.Value + ",<br /><br />" + "We have raised work order against your service request, kindly find below the details.<br /><br />";
        MailText += "WorkOrder Details : <br />";
        //MailText += "<table width='610px'  border='0' cellspacing='0' cellpadding='5' bgcolor='#F1EFFD'>";
        //MailText += "<tr>";
        MailText += "<table width='600px'  border='0' cellspacing='0' cellpadding='3'  bgcolor='#F1EFFD'>";
        MailText += "<tr>";
        MailText += "<td >UserName</td>";
        MailText += "<td>:</td>";
        MailText += "<td colspan='4'>";
        MailText += " " + hfcustusername.Value + " ";
        MailText += "</td>";
        MailText += "</tr>";

        //MailText += "<tr>";
        //MailText += "<td >WareHouse</td>";
        //MailText += "<td>:</td>";
        //MailText += "<td colspan='4'>";
        //MailText += "" + ddlWareHouse.SelectedItem.ToString() + " ";
        //MailText += "</td>";
        //MailText += "</tr>";

        MailText += "<tr>";
        MailText += "<td >Date</td>";
        MailText += "<td>:</td>";
        MailText += "<td colspan='4'>";
        MailText += "" + DateTime.Parse(txtWorkOrderDate.Text.Trim()).ToString("dd-MMM-yyyy") + " ";
        MailText += "</td>";
        MailText += "</tr>";

        MailText += "<tr>";
        MailText += "<td >Customer</td>";
        MailText += "<td>:</td>";
        MailText += "<td colspan='4'>";
        MailText += "" + ddlCustomer.SelectedItem.ToString() + " ";
        MailText += "</td>";
        MailText += "</tr>";

        MailText += "<tr>";
        MailText += "<td >Service Request</td>";
        MailText += "<td>:</td>";
        MailText += "<td colspan='4'>";
        MailText += "" + ddlServiceRequest.SelectedValue + " ";
        MailText += "</td>";
        MailText += "</tr>";

        MailText += "<tr>";
        MailText += "<td >Type of Service Request</td>";
        MailText += "<td>:</td>";
        MailText += "<td colspan='4'>";
        MailText += TypeofServiceRequired.ToString().TrimStart(',') + " ";
        MailText += "</td>";
        MailText += "</tr>";

        MailText += "<tr>";
        MailText += "<td >Status</td>";
        MailText += "<td>:</td>";
        MailText += "<td colspan='4'>";
        MailText += "<b>Work Order Created</b>";
        MailText += "</td>";
        MailText += "</tr>";

        MailText += "<tr>";
        MailText += "<td >Work Order</td>";
        MailText += "<td>:</td>";
        MailText += "<td colspan='4'>";
        MailText += "" + txtWO.Text + " ";
        MailText += "</td>";
        MailText += "</tr>";

        MailText += "<tr>";
        MailText += "<td width='100'>Email</td>";
        MailText += "<td width='10'>:</td>";
        MailText += "<td width='250'>";
        MailText += " " + hfemailid.Value + " ";
        MailText += "</td>";
        MailText += "<td ></td>";
        MailText += "<td></td>";
        MailText += "<td>";
        MailText += "  ";
        MailText += "</td>";
        MailText += "</tr>";

        MailText += "</table>";
        MailText += "<br /><br />Regards,<br /><strong>" + Regards + "</strong><br /><br />";
        MailText += "<br />" + strNote + "<br /><br />";
        mail.Body = MailText;
        mail.IsBodyHtml = true;
        //send the message
        SmtpClient smtp = new SmtpClient("smtp3.netcore.co.in", GetSMTPPort());
        smtp.UseDefaultCredentials = false;
        smtp.Credentials = new System.Net.NetworkCredential("pul@panoramicworld.biz", "$0Lut!0n");
        smtp.Send(mail);


    }
    //public void SendRequestEmail_ToCustomer()
    //{
    //        string msg = "*** This is autogenerated mail, please do not reply ***";
    //         msg = msg +  GenerateRequestCustomer_EmailHeader();
    //         msg = msg +  GenerateEmailBody();
    //         msg = msg +  GenerateEmailFooter();
    //         msg = msg +  GetEmail('To');
    //         msg = msg +  GetEmail('CC');
    //         msg = msg +  GetEmail('Bcc');
    //         mail.Send(msg);
    //}
    //string GenerateRequestCustomer_EmailHeader() ;
    //string GenerateEmailHeader();
    //string GenerateEmailBody();
    //string GenerateEmailFooter();
    //string GetEmail(type);
    string ResortTitle
    {
        get { return ConfigurationManager.AppSettings["ResortTitle"]; }
    }
    string Regards
    {
        get { return "PRSM Team"; }
    }
    public int GetSMTPPort()
    {
        int SMPTPort = 25;
        return SMPTPort;
    }
    protected void AddWorkOrderServices()
    {
        try
        {
            //if (ddlServiceRequest.SelectedIndex < 0 || ViewState["PickUpAddress"] != null)
            //{
            DataTable dtactivity = new DataTable();
            for (int i = 0; i < rdblst.Items.Count; i++)
            {
                if (rdblst.Items[i].Selected)
                {
                    string ServiceName = rdblst.Items[i].Text.Trim();
                    switch (ServiceName)
                    {
                        case "File Pick Up":
                            dtactivity = objPRSMBAL.GetActivitybyCategory(Convert.ToInt32(rdblst.Items[i].Value)).Tables[0];
                            int iActivityId = 0;
                            string PickUpActivityName = "";
                            int iServiceCategoryId = Convert.ToInt32(dtactivity.Rows[0]["ServiceCategoryId"]);
                            int iNoofBoxes = 0;
                            int iNooffiles = 0;
                            //btnAddFPickUpAddress_Click(null,null);
                            //List<FilePickUpAddress> LstFilePickupAddress = (List<FilePickUpAddress>)ViewState["PickUpAddress"];
                            //if (ddlServiceRequest.SelectedIndex > 0)
                            //{
                            //    //List<FilePickUpAddress> LstFilePickupAddress = new List<FilePickUpAddress>();
                            //    //if (ViewState["PickUpAddress"] != null)
                            //    //{
                            //    //    LstFilePickupAddress = (List<FilePickUpAddress>)ViewState["PickUpAddress"];
                            //    //}
                            //    LstFilePickupAddress.Add(new FilePickUpAddress
                            //    {
                            //        FDepartmentId = Convert.ToInt32(ddlDepartment.SelectedValue.ToString()),
                            //        FDepartmentName = ddlDepartment.SelectedItem.ToString(),
                            //        FNoOfBoxes = Convert.ToInt32(txtnoofboxes.Text),
                            //        FNoOfFiles = Convert.ToInt32(txtnooffiles.Text),
                            //        FPickUpAddressId = Convert.ToInt32(ddlFilePickUpAddress.SelectedValue.ToString()),
                            //        FPickUpAddress = ddlFilePickUpAddress.SelectedItem.Text
                            //    });
                            //}
                            if (!string.IsNullOrEmpty(txtnoofboxes.Text.Trim()))
                                iNoofBoxes = Convert.ToInt32(txtnoofboxes.Text.Trim());
                            if (!string.IsNullOrEmpty(txtnooffiles.Text.Trim()))
                                iNooffiles = Convert.ToInt32(txtnooffiles.Text.Trim());
                            string dPickUpdate = "";
                            if (txtdateofPickup.Text.Trim() != "")
                                dPickUpdate = txtdateofPickup.Text;

                            //if (ddlServiceRequest.SelectedIndex > 0)
                            //{
                            //   // DataSet dsServiceRequests = objPRSMBAL.GetServiceRequestWorkOrder(Convert.ToInt32(ddlServiceRequest.SelectedValue));
                            //    ViewState["PickUpAddress"] = gvFilePickUpSRtoWO;
                            //    //gvFilePickUpSRtoWO.DataSource = dsServiceRequests.Tables[1];
                            //    //gvFilePickUpSRtoWO.DataBind();
                            //    //gvFilePickUpSRtoWO.Visible = true;
                            //}
                            List<FilePickUpAddress> LstFilePickupAddress = (List<FilePickUpAddress>)ViewState["PickUpAddress"];
                            for (int j = 0; j < LstFilePickupAddress.Count; j++)
                            {
                                if (ddlServiceRequest.SelectedIndex > 0)
                                {
                                    dPickUpdate = ((TextBox)gvFilePickUpSRtoWO.Rows[j].Cells[4].Controls[1]).Text;
                                }
                                for (int k = 0; k < dtactivity.Rows.Count; k++)
                                {
                                    iActivityId = Convert.ToInt32(dtactivity.Rows[k]["ActivityId"]);
                                    PickUpActivityName = dtactivity.Rows[k]["ActivityName"].ToString();
                                    if (PickUpActivityName == "Bar-coding & Data Entry (File & Box)")
                                        AddActivites(-1, iActivityId, iServiceCategoryId, "", "", "", /*LstFilePickupAddress[j].FPickUpDate.ToString()*/dPickUpdate, 0, 0, Convert.ToInt32(objPageBase.UserId), Convert.ToInt32(LstFilePickupAddress[j].FNoOfFiles.ToString()), Convert.ToInt32(LstFilePickupAddress[j].FDepartmentId.ToString()), Convert.ToInt32(LstFilePickupAddress[j].FPickUpAddressId.ToString()));
                                    else
                                        AddActivites(-1, iActivityId, iServiceCategoryId, "", "", "", /*LstFilePickupAddress[j].FPickUpDate.ToString()*/dPickUpdate, Convert.ToInt32(LstFilePickupAddress[j].FNoOfBoxes.ToString()), 0, Convert.ToInt32(objPageBase.UserId), 0, Convert.ToInt32(LstFilePickupAddress[j].FDepartmentId.ToString()), Convert.ToInt32(LstFilePickupAddress[j].FPickUpAddressId.ToString()));

                                }
                            }
                            break;
                        case "Retrieval":

                            int iRetrivalServiceCategoryId = 0;

                            if (!string.IsNullOrEmpty(rdblst.Items.FindByText("Retrieval").Value))
                            {
                                iRetrivalServiceCategoryId = Convert.ToInt32(rdblst.Items.FindByText("Retrieval").Value);
                            }
                            List<ActivityListCount> DistinctRetrivalActivitylst = new List<ActivityListCount>();
                            DistinctRetrivalActivitylst = GetAcitivityCountByCategory(iRetrivalServiceCategoryId);
                            int iActivityidRegularDelivery = 0;
                            int iActivityidExpessDelivery = 0;
                            int RetPickUpId = 0;
                            int RetExpressPickUpId = 0;
                            int RetRegularPickUpId = 0;

                            for (int k = 0; k < DistinctRetrivalActivitylst.Count; k++)
                            {
                                RetPickUpId = Convert.ToInt32(DistinctRetrivalActivitylst[k].RetrPickUpAddressId.ToString());
                                string ActivityName = DistinctRetrivalActivitylst[k].ActivityName.ToString();
                                if (ActivityName.Contains("Express"))
                                    RetExpressPickUpId = Convert.ToInt32(DistinctRetrivalActivitylst[k].RetrPickUpAddressId.ToString());
                                else
                                    RetRegularPickUpId = Convert.ToInt32(DistinctRetrivalActivitylst[k].RetrPickUpAddressId.ToString());


                                if (ActivityName.Contains("Box") == true)
                                    AddActivites(-1, Convert.ToInt32(DistinctRetrivalActivitylst[k].ActivityId), 0, "", "", "", "", Convert.ToInt32(DistinctRetrivalActivitylst[k].ActivityCount), 0, Convert.ToInt32(objPageBase.UserId), 0, 0, RetPickUpId);
                                else
                                    AddActivites(-1, Convert.ToInt32(DistinctRetrivalActivitylst[k].ActivityId), 0, "", "", "", "", 0, 0, Convert.ToInt32(objPageBase.UserId), Convert.ToInt32(DistinctRetrivalActivitylst[k].ActivityCount), 0, RetPickUpId);
                            }
                            DataTable dtResult = objPRSMBAL.GetActivitybyCategory(Convert.ToInt32(rdblst.Items.FindByText("Retrieval").Value)).Tables[0];

                            for (int k = 0; k < dtResult.Rows.Count; k++)
                            {
                                if (Convert.ToString(dtResult.Rows[2]["Activityid"]).Trim().ToUpper() == Convert.ToString(ViewState["WORE"]).ToUpper() || Convert.ToString(dtResult.Rows[6]["Activityid"]).Trim().ToUpper() == Convert.ToString(ViewState["WORE"]).ToUpper())
                                {
                                    if (Convert.ToString(dtResult.Rows[k]["ActivityName"]).Trim().ToUpper() == Convert.ToString("Retrievals Hand Delivery Charges Express [(Within 12 hours) Max 4 box files / One Full Box]").ToUpper())
                                    {
                                        iActivityidExpessDelivery = Convert.ToInt32(dtResult.Rows[k]["Activityid"]);
                                    }
                                }
                                if (Convert.ToString(dtResult.Rows[3]["Activityid"]).Trim().ToUpper() == Convert.ToString(ViewState["WORE"]).ToUpper() || Convert.ToString(dtResult.Rows[7]["Activityid"]).Trim().ToUpper() == Convert.ToString(ViewState["WORE"]).ToUpper())
                                {
                                    if (Convert.ToString(dtResult.Rows[k]["ActivityName"]).Trim().ToUpper() == Convert.ToString("Retrievals Hand Delivery Charges Regular [(Within 24 hours) Max 4 box files / One Full Box]").ToUpper())
                                    {
                                        iActivityidRegularDelivery = Convert.ToInt32(dtResult.Rows[k]["Activityid"]);
                                    }
                                }
                                if (Convert.ToString(dtResult.Rows[0]["Activityid"]).Trim().ToUpper() == Convert.ToString(ViewState["WORE"]).ToUpper() || Convert.ToString(dtResult.Rows[4]["Activityid"]).Trim().ToUpper() == Convert.ToString(ViewState["WORE"]).ToUpper())
                                {
                                    if (Convert.ToString(dtResult.Rows[k]["ActivityName"]).Trim().ToUpper() == Convert.ToString("Restore   Hand Delivery Charges Express [(Within 12 hours) Max 4 box files / One Full Box]").ToUpper())
                                    {
                                        iActivityidExpessDelivery = Convert.ToInt32(dtResult.Rows[k]["Activityid"]);
                                    }
                                }
                                if (Convert.ToString(dtResult.Rows[1]["Activityid"]).Trim().ToUpper() == Convert.ToString(ViewState["WORE"]).ToUpper() || Convert.ToString(dtResult.Rows[5]["Activityid"]).Trim().ToUpper() == Convert.ToString(ViewState["WORE"]).ToUpper())
                                {
                                    if (Convert.ToString(dtResult.Rows[k]["ActivityName"]).Trim().ToUpper() == Convert.ToString("Restore   Hand Delivery Charges Regular [(Within 24 hours) Max 4 box files / One Full Box]").ToUpper())
                                    {
                                        iActivityidRegularDelivery = Convert.ToInt32(dtResult.Rows[k]["Activityid"]);
                                    }
                                }
                                //if (Convert.ToString(dtResult.Rows[k]["ActivityName"]).Trim().ToUpper() == Convert.ToString("Retrievals Hand Delivery Charges Regular [(Within 24 hours) Max 4 box files / One Full Box]").ToUpper())
                                //{
                                //    iActivityidRegularDelivery = Convert.ToInt32(dtResult.Rows[k]["Activityid"]);
                                //}
                                //if (Convert.ToString(dtResult.Rows[k]["ActivityName"]).Trim().ToUpper() == Convert.ToString("Retrievals Hand Delivery Charges Express [(Within 12 hours) Max 4 box files / One Full Box]").ToUpper())
                                //{
                                //    iActivityidExpessDelivery = Convert.ToInt32(dtResult.Rows[k]["Activityid"]);
                                //}
                            }
                            //Retrival
                            int nboxCountExpress = FileBoxCount("Box Retrievals   Express");
                            int nfileCountExpress = FileBoxCount("File Retrievals  Express");
                            int nboxCountRegular = FileBoxCount("Box Retrievals   Regular");
                            int nfileCountRegular = FileBoxCount("File Retrievals  Regular");
                            if (nboxCountExpress > 0 || nfileCountExpress > 0)
                            {
                                AddActivites(-1, iActivityidExpessDelivery, 0, "", "", "", "", nboxCountExpress, 0, Convert.ToInt32(objPageBase.UserId), nfileCountExpress, 0, RetExpressPickUpId);
                            }
                            if (nboxCountRegular > 0 || nfileCountRegular > 0)
                            {
                                AddActivites(-1, iActivityidRegularDelivery, 0, "", "", "", "", nboxCountRegular, 0, Convert.ToInt32(objPageBase.UserId), nfileCountRegular, 0, RetRegularPickUpId);
                            }

                            //Restore
                            int nboxCountExpressRestre = FileBoxCount("Box  Restore Express");
                            int nfileCountExpressRestre = FileBoxCount("File Restore Express");
                            int nboxCountRegularRestre = FileBoxCount("Box  Restore Regular");
                            int nfileCountRegularRestre = FileBoxCount("File Restore Regular");
                            if (nboxCountExpressRestre > 0 || nfileCountExpressRestre > 0)
                            {
                                AddActivites(-1, iActivityidExpessDelivery, 0, "", "", "", "", nboxCountExpressRestre, 0, Convert.ToInt32(objPageBase.UserId), nfileCountExpressRestre, 0, RetExpressPickUpId);
                            }
                            if (nboxCountRegularRestre > 0 || nfileCountRegularRestre > 0)
                            {
                                AddActivites(-1, iActivityidRegularDelivery, 0, "", "", "", "", nboxCountRegularRestre, 0, Convert.ToInt32(objPageBase.UserId), nfileCountRegularRestre, 0, RetRegularPickUpId);
                            }

                            List<ActivityList> lstRetrivalActivitylst = GetActivitylist(iRetrivalServiceCategoryId).DefaultIfEmpty().ToList();
                            for (int k = 0; k < lstRetrivalActivitylst.Count; k++)
                            {
                                AddRetrvalBoxFileDetailsTable(-1, lstRetrivalActivitylst[k].ActivityId, lstRetrivalActivitylst[k].BoxBarCode, lstRetrivalActivitylst[k].FileBarCode, lstRetrivalActivitylst[k].RetrPickUpAddressId);
                            }
                            break;
                        case "Permanent Return":

                            int iPermanentServiceCategoryId = 0;
                            if (!string.IsNullOrEmpty(rdblst.Items.FindByText("Permanent Return").Value))
                            {
                                iPermanentServiceCategoryId = Convert.ToInt32(rdblst.Items.FindByText("Permanent Return").Value);
                            }
                            List<ActivityListCount> DistinctPermanentActivitylst = new List<ActivityListCount>();
                            DistinctPermanentActivitylst = GetAcitivityCountByCategory(iPermanentServiceCategoryId);
                            for (int k = 0; k < DistinctPermanentActivitylst.Count; k++)
                            {
                                //Box Count will be always 0 
                                AddActivites(-1, Convert.ToInt32(DistinctPermanentActivitylst[k].ActivityId), 0, "", "", "", "", 0, 0, Convert.ToInt32(objPageBase.UserId), Convert.ToInt32(DistinctPermanentActivitylst[k].ActivityCount), 0, 0);
                            }
                            List<ActivityList> lstPermanentActivitylst = GetActivitylist(iPermanentServiceCategoryId).DefaultIfEmpty().ToList();
                            for (int k = 0; k < lstPermanentActivitylst.Count; k++)
                            {
                                AddRetrvalBoxFileDetailsTable(-1, lstPermanentActivitylst[k].ActivityId, lstPermanentActivitylst[k].BoxBarCode, lstPermanentActivitylst[k].FileBarCode, 0);
                            }

                            break;
                        case "Other services":
                            for (int j = 0; j < grdOtherAddServiceActivity.Rows.Count; j++)
                            {
                                TextBox txtNoOfServices = (TextBox)grdOtherAddServiceActivity.Rows[j].FindControl("txtNoOfServices");
                                if (!string.IsNullOrEmpty(txtNoOfServices.Text.Trim()))
                                {
                                    HiddenField hdnActivityid = (HiddenField)grdOtherAddServiceActivity.Rows[j].FindControl("hdnActivityid");
                                    HiddenField hdhServiceCategoryId = (HiddenField)grdOtherAddServiceActivity.Rows[j].FindControl("hdhServiceCategoryId");
                                    AddActivites(-1, Convert.ToInt32(hdnActivityid.Value), Convert.ToInt32(hdhServiceCategoryId.Value), "", "", "", "", 0, 0, Convert.ToInt32(objPageBase.UserId), Convert.ToInt32(txtNoOfServices.Text), 0, 0);
                                }
                            }
                            int iOtherServiceCategoryId = 0;
                            if (!string.IsNullOrEmpty(rdblst.Items.FindByText("Other services").Value))
                            {
                                iOtherServiceCategoryId = Convert.ToInt32(rdblst.Items.FindByText("Other services").Value);
                            }

                            foreach (GridViewRow row in grdOtherServicesFiles.Rows)
                            {

                                HiddenField hdnActivityid = (HiddenField)row.FindControl("hdnActivityid");
                                //HiddenField hdnActivityid = new HiddenField();
                                //hdnActivityid.Value = "40";
                                TextBox BoxBarCode = (TextBox)row.FindControl("txtotherServicesBoxBarCode");
                                TextBox FileBarCode = (TextBox)row.FindControl("txtOtherServicesFileBarcode");
                                if (BoxBarCode.Text != "")
                                    AddRetrvalBoxFileDetailsTable(-1, Convert.ToInt32(hdnActivityid.Value), BoxBarCode.Text, FileBarCode.Text, 0);
                            }

                            break;
                        case "Destruction":
                           
                            int iDestructionServiceCategoryId = 0;

                            if (!string.IsNullOrEmpty(rdblst.Items.FindByText("Destruction").Value))
                            {
                                iDestructionServiceCategoryId = Convert.ToInt32(rdblst.Items.FindByText("Destruction").Value);
                            }
                            List<DestructionActivityListCount> DistinctDestructionActivitylst = new List<DestructionActivityListCount>();
                          
                            DistinctDestructionActivitylst = GetDestructionAcitivityCountByCategory(iDestructionServiceCategoryId);
                            for (int k = 0; k < DistinctDestructionActivitylst.Count; k++)
                            {
                                string ActivityName = DistinctDestructionActivitylst[k].ActivityName.ToString();
                                //if (ActivityName.Trim() == "File Shredding")
                                if (ActivityName.Contains("File Shredding") == true)
                                {
                                    AddActivites(-1, Convert.ToInt32(DistinctDestructionActivitylst[k].ActivityId), 0, "", "", "", "", Convert.ToInt32(DistinctDestructionActivitylst[k].ActivityCount), 0, Convert.ToInt32(objPageBase.UserId), Convert.ToInt32(DistinctDestructionActivitylst[k].ActivityCount), 0, 0);
                                }
                                else
                                    AddActivites(-1, Convert.ToInt32(DistinctDestructionActivitylst[k].ActivityId), 0, "", "", "", "", 0, 0, Convert.ToInt32(objPageBase.UserId), Convert.ToInt32(DistinctDestructionActivitylst[k].ActivityCount), 0, 0);
                            }
                            List<DestructionActivityList> lstDestructionActivitylst = GetDestructionActivitylist(iDestructionServiceCategoryId).DefaultIfEmpty().ToList();
                            for (int k = 0; k < lstDestructionActivitylst.Count; k++)
                            {
                                AddRetrvalBoxFileDetailsTable(-1, lstDestructionActivitylst[k].ActivityId, lstDestructionActivitylst[k].BoxBarCode, lstDestructionActivitylst[k].FileBarCode, 0);
                            }
                           
                            //int iDestructionServiceCategoryId = 0;
                            //if (!string.IsNullOrEmpty(rdblst.Items.FindByText("Destruction").Value))
                            //{
                            //    iDestructionServiceCategoryId = Convert.ToInt32(rdblst.Items.FindByText("Destruction").Value);
                            //}

                            //List<DestructionActivityListCount> DistinctDestructionActivitylst = new List<DestructionActivityListCount>();

                            //DistinctDestructionActivitylst = GetDestructionAcitivityCountByCategory(iDestructionServiceCategoryId);
                            //for (int k = 0; k < DistinctDestructionActivitylst.Count; k++)
                            //{
                            //    string ActivityName = DistinctDestructionActivitylst[k].ActivityName.ToString();
                            //    if (ActivityName.Trim() == "destruction of file")
                            //    {
                            //        AddActivites(-1, Convert.ToInt32(DistinctDestructionActivitylst[k].ActivityId), 0, "", "", "", "", Convert.ToInt32(DistinctDestructionActivitylst[k].ActivityCount), 0, Convert.ToInt32(objPageBase.UserId), Convert.ToInt32(DistinctDestructionActivitylst[k].ActivityCount), 0, 0);
                            //    }
                            //    else
                            //        AddActivites(-1, Convert.ToInt32(DistinctDestructionActivitylst[k].ActivityId), 0, "", "", "", "", 0, 0, Convert.ToInt32(objPageBase.UserId), Convert.ToInt32(DistinctDestructionActivitylst[k].FileCount), 0, 0);

                            //}
                            //List<DestructionActivityList> lstDestructionActivitylst = GetDestructionActivitylist(iDestructionServiceCategoryId).DefaultIfEmpty().ToList();
                            //for (int k = 0; k < lstDestructionActivitylst.Count; k++)
                            //{
                            //    AddRetrvalBoxFileDetailsTable(-1, lstDestructionActivitylst[k].ActivityId, lstDestructionActivitylst[k].BoxBarCode, lstDestructionActivitylst[k].FileBarCode, 0);
                            //}

                            break;
                        case "In-House management":
                            break;
                        default:
                            break;
                    }
                }
            }
            //}
        }
        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }
    }

    protected int FileBoxCount(string ActivitNames)
    {
        var qryBoxCount = from cust in lstActivitylist.ToList().DefaultIfEmpty()
                          where cust.ActivityName.Contains(ActivitNames)
                          select cust.ActivityId;
        return qryBoxCount.Count();
    }
    protected void ClearNewOrderDetails()
    {
        divFilepickup.Style["display"] = "none";
        divRetrival.Style["display"] = "none";
        divOtherServices.Style["display"] = "none";
        divPermanentReturn.Style["display"] = "none";
        divDestruction.Style["display"] = "none";
        grdRetrivalActivity.DataSource = null;
        grdRetrivalActivity.DataBind();
        grdRetrivalActivityCount.DataSource = null;
        grdRetrivalActivityCount.DataBind();
        gridPermanentActivity.DataSource = null;
        gridPermanentActivity.DataBind();
        gridPermanentActivityCount.DataSource = null;
        gridPermanentActivityCount.DataBind();
        GridDestructionActivity.DataSource = null;
        GridDestructionActivity.DataBind();
        GridDestructionActivityCount.DataSource = null;
        GridDestructionActivityCount.DataBind();
        grdFilePickUpAddress.DataSource = null;
        grdFilePickUpAddress.DataBind();
        grdOtherServicesFiles.DataSource = null;
        grdOtherServicesFiles.DataBind();
        Session["WorkOrder_ActivityList"] = null;
        ViewState["ActivitesTable"] = null;
        ViewState["DestructionActivityList"] = null;
        ViewState["WActivitiesXML"] = null;
        ViewState["PickUpAddress"] = null;
        ViewState["OtherServicesActivityList"] = null;
        ViewState["dtRetrvalBoxFileDetailsTable"] = null;
        foreach (ListItem item in rdblst.Items)
        {
            if (item.Selected == true)
            {
                item.Selected = false;
            }
        }
        ddlRetrievalPickUpAddress.SelectedIndex = 0;
        txtBoxBarCode.Text = "";
        txtPermBoxBarCode.Text = "";
        //txtDestructionBoxBarCode.Text = "";
        //  txtotherServicesBoxBarCode.Text = "";
        // txtOtherServicesFileBarcode.Text = "";
    }
    #endregion Save WorkOrders details
    #region Temp table to store BoxFileDetailsTable
    protected DataTable RetrvalBoxFileDetailsTable()
    {
        DataTable dtRetrvalBoxFileDetailsTable = new DataTable();
        if (ViewState["dtRetrvalBoxFileDetailsTable"] == null)
        {
            dtRetrvalBoxFileDetailsTable.TableName = "Root";
            dtRetrvalBoxFileDetailsTable.Columns.Add("SrNo", typeof(int));
            dtRetrvalBoxFileDetailsTable.Columns["SrNo"].AutoIncrement = true;
            dtRetrvalBoxFileDetailsTable.Columns["SrNo"].AutoIncrementSeed = 0;
            dtRetrvalBoxFileDetailsTable.Columns.Add("ActivityId", typeof(int));
            dtRetrvalBoxFileDetailsTable.Columns.Add("BoxBarCode", typeof(String));
            dtRetrvalBoxFileDetailsTable.Columns.Add("FileBarCode", typeof(String));
            dtRetrvalBoxFileDetailsTable.Columns.Add("PickUpAddressId", typeof(int));
            dtRetrvalBoxFileDetailsTable.AcceptChanges();
        }
        else
        {
            dtRetrvalBoxFileDetailsTable = (DataTable)ViewState["dtRetrvalBoxFileDetailsTable"];
        }
        return dtRetrvalBoxFileDetailsTable;
    }
    protected void AddRetrvalBoxFileDetailsTable(int iSrNo, int iActivityId, string strboxCode, string strFileCode, int nPickUpAddressId)
    {
        DataTable dtRetrvalBoxFileDetailsTable;
        DataRow drActivityRow;
        dtRetrvalBoxFileDetailsTable = RetrvalBoxFileDetailsTable();
        try
        {
            drActivityRow = dtRetrvalBoxFileDetailsTable.NewRow();
            if (iSrNo == -1)
            {
                drActivityRow["ActivityId"] = iActivityId;
                drActivityRow["BoxBarCode"] = strboxCode;
                drActivityRow["FileBarCode"] = strFileCode;
                drActivityRow["PickUpAddressId"] = nPickUpAddressId;
                dtRetrvalBoxFileDetailsTable.Rows.Add(drActivityRow);
                dtRetrvalBoxFileDetailsTable.AcceptChanges();
            }
            ViewState["dtRetrvalBoxFileDetailsTable"] = dtRetrvalBoxFileDetailsTable;

        }
        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }
    }
    #endregion Temp table to store BoxFileDetailsTable
    #region Add Retrieval
    protected void btnAddRetrival_Click(object sender, EventArgs e)
    {
        DataTable dtExcelData = new DataTable();
        int iRetrivalServiceCategoryId = 0;
        string msg = "";
        if (!string.IsNullOrEmpty(rdblst.Items.FindByText("Retrieval").Value))
        {
            iRetrivalServiceCategoryId = Convert.ToInt32(rdblst.Items.FindByText("Retrieval").Value);
            if (ddlRetrivalActivity.SelectedItem.Text.Contains("Retrievals").ToString() == "True")
            {
                if (ddlRetrivalActivity.SelectedItem.Text.Contains("File").ToString() == "True")
                {
                    if (lstActivitylist != null)
                    {
                        if (lstActivitylist.Exists(res => res.BoxBarCode.Trim().Equals(txtBoxBarCode.Text.Trim()) && res.FileBarCode.Trim() == "") == true)
                        {
                            msg = msg + "<br>" + " Box Bar Code " + txtBoxBarCode.Text.Trim() + " (or some of its files) already added to the list";
                        }
                        else
                        {
                            if (lstActivitylist.Exists(res => res.FileBarCode.Trim().Equals(txtFileBarCode.Text.Trim())) == true)
                            {
                                msg = msg + "<br>" + " File Bar Code " + txtFileBarCode.Text.Trim() + " is already added to the list";
                            }
                            else
                            {
                                AddActivitylist(Convert.ToInt32(ddlRetrievalPickUpAddress.SelectedValue), ddlRetrievalPickUpAddress.SelectedItem.Text, iRetrivalServiceCategoryId, Convert.ToInt32(ddlRetrivalActivity.SelectedItem.Value), ddlRetrivalActivity.SelectedItem.Text.Trim(), txtBoxBarCode.Text.Trim(), txtFileBarCode.Text.Trim());
                            }
                        }
                    }
                    else
                    {
                        AddActivitylist(Convert.ToInt32(ddlRetrievalPickUpAddress.SelectedValue), ddlRetrievalPickUpAddress.SelectedItem.Text, iRetrivalServiceCategoryId, Convert.ToInt32(ddlRetrivalActivity.SelectedItem.Value), ddlRetrivalActivity.SelectedItem.Text.Trim(), txtBoxBarCode.Text.Trim(), txtFileBarCode.Text.Trim());
                    }
                }

                if (ddlRetrivalActivity.SelectedItem.Text.Contains("Box").ToString() == "True")
                {
                    AddActivitylist(Convert.ToInt32(ddlRetrievalPickUpAddress.SelectedValue), ddlRetrievalPickUpAddress.SelectedItem.Text, iRetrivalServiceCategoryId, Convert.ToInt32(ddlRetrivalActivity.SelectedItem.Value), ddlRetrivalActivity.SelectedItem.Text.Trim(), txtBoxBarCode.Text.Trim(), "");
                }
            }
            if (ddlRetrivalActivity.SelectedItem.Text.Contains("Restore").ToString() == "True")
            {
                if (ddlRetrivalActivity.SelectedItem.Text.Contains("File").ToString() == "True")
                {
                    if (lstActivitylist != null)
                    {
                        if (lstActivitylist.Exists(res => res.BoxBarCode.Trim().Equals(txtBoxBarCode.Text.Trim()) && res.FileBarCode.Trim() == "") == true)
                        {
                            msg = msg + "<br>" + " Box Bar Code " + txtBoxBarCode.Text.Trim() + " (or some of its files) already added to the list";
                        }
                        else
                        {
                            if (lstActivitylist.Exists(res => res.FileBarCode.Trim().Equals(txtFileBarCode.Text.Trim())) == true)
                            {
                                msg = msg + "<br>" + " File Bar Code " + txtFileBarCode.Text.Trim() + " is already added to the list";
                            }
                            else
                            {
                                AddActivitylist(Convert.ToInt32(ddlRetrievalPickUpAddress.SelectedValue), ddlRetrievalPickUpAddress.SelectedItem.Text, iRetrivalServiceCategoryId, Convert.ToInt32(ddlRetrivalActivity.SelectedItem.Value), ddlRetrivalActivity.SelectedItem.Text.Trim(), txtBoxBarCode.Text.Trim(), txtFileBarCode.Text.Trim());
                            }
                        }
                    }
                    else
                    {
                        AddActivitylist(Convert.ToInt32(ddlRetrievalPickUpAddress.SelectedValue), ddlRetrievalPickUpAddress.SelectedItem.Text, iRetrivalServiceCategoryId, Convert.ToInt32(ddlRetrivalActivity.SelectedItem.Value), ddlRetrivalActivity.SelectedItem.Text.Trim(), txtBoxBarCode.Text.Trim(), txtFileBarCode.Text.Trim());
                    }
                }

                if (ddlRetrivalActivity.SelectedItem.Text.Contains("Box").ToString() == "True")
                {
                    AddActivitylist(Convert.ToInt32(ddlRetrievalPickUpAddress.SelectedValue), ddlRetrievalPickUpAddress.SelectedItem.Text, iRetrivalServiceCategoryId, Convert.ToInt32(ddlRetrivalActivity.SelectedItem.Value), ddlRetrivalActivity.SelectedItem.Text.Trim(), txtBoxBarCode.Text.Trim(), "");
                }
            }
        }

        if (msg != "")
        {
            lblFileErrorMsg.Text = msg;
            lblFileErrorMsg.ForeColor = Color.Red;

        }

        //AddActivitylist(Convert.ToInt32(ddlRetrievalPickUpAddress.SelectedValue), ddlRetrievalPickUpAddress.SelectedItem.Text, iRetrivalServiceCategoryId, Convert.ToInt32(ddlRetrivalActivity.SelectedItem.Value), ddlRetrivalActivity.SelectedItem.Text.Trim(), txtBoxBarCode.Text.Trim(), txtFileBarCode.Text.Trim());
        grdRetrivalActivity.DataSource = lstActivitylist.ToList().Where(res => res.ServiceCategoryId == iRetrivalServiceCategoryId).DefaultIfEmpty();
        grdRetrivalActivity.DataBind();
        grdRetrivalActivityCount.DataSource = GetAcitivityCountByCategory(iRetrivalServiceCategoryId);
        grdRetrivalActivityCount.DataBind();
        ddlRetrivalActivity.SelectedIndex = 0;
        txtBoxBarCode.Text = "";
        txtFileBarCode.Text = "";

        //foreach (DataRow dr in dtExcelData.Rows)
        //{

        //    if (lstActivitylist != null)
        //    {
        //        // Adding Box 
        //        if (dr["FILE_BARCODE"].ToString().Trim() == "")
        //        {
        //            if (lstActivitylist.Exists(res => res.BoxBarCode.Trim().Equals(dr["BOX_BARCODE"].ToString().Trim())) == true)
        //            {
        //                msg = msg + "<br>" + " Box Bar Code " + dr["BOX_BARCODE"].ToString().Trim() + " (or some of its files) already added to the list";
        //            }
        //        }
        //        //Adding File 
        //        else if (lstActivitylist.Exists(res => res.FileBarCode.Trim().Equals(dr["FILE_BARCODE"].ToString().Trim())) == true)
        //        {
        //            msg = msg + "<br>" + " File Bar Code " + dr["FILE_BARCODE"].ToString().Trim() + " is already added to the list";
        //        }
        //        else if (lstActivitylist.Exists(res => res.BoxBarCode.Trim().Equals(dr["BOX_BARCODE"].ToString().Trim()) && res.FileBarCode.ToString().Trim() == "") == true)
        //        {
        //            msg = msg + "<br>" + " File Bar Code " + dr["FILE_BARCODE"].ToString().Trim() + " is already included in Box Retrieval for Box " + dr["BOX_BARCODE"].ToString().Trim();
        //        }
        //        else
        //            AddActivitylist(Convert.ToInt32(ddlRetrievalPickUpAddress.SelectedValue), ddlRetrievalPickUpAddress.SelectedItem.Text, iRetrivalServiceCategoryId, Convert.ToInt32(ddlRetrivalActivity.SelectedItem.Value), ddlRetrivalActivity.SelectedItem.Text.Trim(), dr["BOX_BARCODE"].ToString(), dr["FILE_BARCODE"].ToString());

        //    }
        //    else
        //    { //lstActivityList is null no need of checking anything.
        //        AddActivitylist(Convert.ToInt32(ddlRetrievalPickUpAddress.SelectedValue), ddlRetrievalPickUpAddress.SelectedItem.Text, iRetrivalServiceCategoryId, Convert.ToInt32(ddlRetrivalActivity.SelectedItem.Value), ddlRetrivalActivity.SelectedItem.Text.Trim(), dr["BOX_BARCODE"].ToString(), dr["FILE_BARCODE"].ToString());
        //    }
        //}
    }


    protected void Validate_Retrival(object sender, ServerValidateEventArgs e)
    {
        if (grdRetrivalActivity.Rows.Count > 0)
            e.IsValid = true;
        else
            e.IsValid = false;
    }

    #endregion PermanentBoxFileDetailsTable
    #region Add PermanentBoxFileDetailsTable
    protected void btnPermanent_Click(object sender, EventArgs e)
    {

        int iRetrivalServiceCategoryId = 0;
        if (!string.IsNullOrEmpty(rdblst.Items.FindByText("Permanent Return").Value))
        {
            iRetrivalServiceCategoryId = Convert.ToInt32(rdblst.Items.FindByText("Permanent Return").Value);
        }

        AddActivitylist(0, "", iRetrivalServiceCategoryId, Convert.ToInt32(ddlPermanentActivity.SelectedItem.Value), ddlPermanentActivity.SelectedItem.Text.Trim(), txtPermBoxBarCode.Text.Trim(), txtPermFileBarCode.Text.Trim());
        gridPermanentActivity.DataSource = lstActivitylist.ToList().Where(res => res.ServiceCategoryId == iRetrivalServiceCategoryId).DefaultIfEmpty();
        gridPermanentActivity.DataBind();

        gridPermanentActivityCount.DataSource = GetAcitivityCountByCategory(iRetrivalServiceCategoryId);
        gridPermanentActivityCount.DataBind();
        txtPermFileBarCode.Text = "";
    }
    protected void Validate_Permanent(object sender, ServerValidateEventArgs e)
    {
        if (gridPermanentActivity.Rows.Count > 0)
            e.IsValid = true;
        else
            e.IsValid = false;

    }
    #endregion PermanentBoxFileDetailsTable
    #region DestructionBoxFileDetailsTable
    protected void btnDestruction_Click(object sender, EventArgs e)
    {
        DataTable dtExcelData = new DataTable();
        int iDestructionServiceCategId = 0;
        string msg = "";
        if (!string.IsNullOrEmpty(rdblst.Items.FindByText("Destruction").Value))
        {
            iDestructionServiceCategId = Convert.ToInt32(rdblst.Items.FindByText("Destruction").Value);
            if (ddlDestructionActivity.SelectedItem.Text.Contains("File Shredding").ToString() == "True")
            {
                if (ddlDestructionActivity.SelectedItem.Text.Contains("File").ToString() == "True")
                {
                    if (lstDestructionActivitylist != null)
                    {
                        if (lstDestructionActivitylist.Exists(res => res.BoxBarCode.Trim().Equals(txtDestrBoxBarCode.Text.Trim()) && res.FileBarCode.Trim() == "") == true)
                        {
                            msg = msg + "<br>" + " Box Bar Code " + txtDestrBoxBarCode.Text.Trim() + " (or some of its files) already added to the list";
                        }
                        else
                        {
                            if (lstDestructionActivitylist.Exists(res => res.FileBarCode.Trim().Equals(txtDestrFileBarCode.Text.Trim())) == true)
                            {
                                msg = msg + "<br>" + " File Bar Code " + txtDestrFileBarCode.Text.Trim() + " is already added to the list";
                            }
                            else
                            {
                                AddDesructionActivitylist(iDestructionServiceCategId, Convert.ToInt32(ddlDestructionActivity.SelectedItem.Value), ddlDestructionActivity.SelectedItem.Text.Trim(), txtDestrBoxBarCode.Text.Trim(), txtDestrFileBarCode.Text.Trim());
                            }
                        }
                    }
                    else
                    {
                        AddDesructionActivitylist(iDestructionServiceCategId, Convert.ToInt32(ddlDestructionActivity.SelectedItem.Value), ddlDestructionActivity.SelectedItem.Text.Trim(), txtDestrBoxBarCode.Text.Trim(), txtDestrFileBarCode.Text.Trim());
                    }
                }
            }
            if (msg != "")
            {
                lblFileErrorMsg.Text = msg;
                lblFileErrorMsg.ForeColor = Color.Red;

            }

            //AddActivitylist(Convert.ToInt32(ddlRetrievalPickUpAddress.SelectedValue), ddlRetrievalPickUpAddress.SelectedItem.Text, iRetrivalServiceCategoryId, Convert.ToInt32(ddlRetrivalActivity.SelectedItem.Value), ddlRetrivalActivity.SelectedItem.Text.Trim(), txtBoxBarCode.Text.Trim(), txtFileBarCode.Text.Trim());
            GridDestructionActivity.DataSource = lstDestructionActivitylist.ToList().Where(res => res.ServiceCategoryId == iDestructionServiceCategId).DefaultIfEmpty();
            GridDestructionActivity.DataBind();

            List<DestructionActivityList> resultActivitylist = lstDestructionActivitylist.Where(res => res.ServiceCategoryId == iDestructionServiceCategId).DefaultIfEmpty().ToList();
            List<DestructionActivityListCount> GetDestructionAcitivityCountByCateg = GetDestructionAcitivityCountByCategory(iDestructionServiceCategId).ToList();
            var ResActivityCount = (from res in lstDestructionActivitylist
                                    join Activitylist in GetDestructionAcitivityCountByCateg on res.ActivityId equals Activitylist.ActivityId
                                    select new DestructionActivityListCount { ActivityName = res.ActivityName, ActivityId = res.ActivityId, FileCount = Activitylist.FileCount, ActivityCount = Activitylist.ActivityCount }).Distinct();

            var GetDestructActivityCount = from DestructionActivity in ResActivityCount.ToList()
                                           group DestructionActivity by
                                           new { DestructionActivity.ActivityName, DestructionActivity.ActivityId, DestructionActivity.FileCount } into grpDestruction
                                           select new DestructionActivityListCount
                                           {
                                               ActivityName = grpDestruction.Key.ActivityName,
                                               ActivityId = grpDestruction.Key.ActivityId,
                                               ActivityCount = grpDestruction.Count(),
                                               FileCount = grpDestruction.Key.FileCount
                                           };
            GridDestructionActivityCount.DataSource = GetDestructActivityCount;
            GridDestructionActivityCount.DataBind();

            txtDestrBoxBarCode.Text = "";
            txtDestrFileBarCode.Text = "";



            //GridDestructionActivityCount.DataSource = GetAcitivityCountByCategory(iDestructionServiceCategId);
            //GridDestructionActivityCount.DataBind();
            //ddlDestructionActivity.SelectedIndex = 0;
            //txtDestrBoxBarCode.Text = "";
            //txtDestrFileBarCode.Text = "";

        }
    }


    //    int iDestructionServiceCategId = 0;
    //    int iFileCount = 0;
    //    int iCustomerId = Convert.ToInt32(ddlCustomer.SelectedValue);
    //    DataSet dsGetFileBarCodeCount = objTRANSBAL.GetFileBarCodeCount(iCustomerId);
    //    //if (!string.IsNullOrEmpty(txtDestructionFileCount.Text))
    //    //{
    //    //    iFileCount = Convert.ToInt32(txtDestructionFileCount.Text);
    //    //}
    //    if (dsGetFileBarCodeCount.Tables[0].Rows.Count > 0)
    //    {
    //        int iFromDBFileBarCodeCount = Convert.ToInt32(dsGetFileBarCodeCount.Tables[0].Rows[0]["FileCount"].ToString());
    //        if (iFileCount > iFromDBFileBarCodeCount)
    //        {
    //            ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('Please enter no. of files less than " + iFromDBFileBarCodeCount + " ')", true);
    //            return;
    //        }
    //    }

    //    if (!string.IsNullOrEmpty(rdblst.Items.FindByText("Destruction").Value))
    //    {
    //        iDestructionServiceCategId = Convert.ToInt32(rdblst.Items.FindByText("Destruction").Value);
    //    }

    //    AddDesructionActivitylist(iDestructionServiceCategId, Convert.ToInt32(ddlDestructionActivity.SelectedItem.Value), ddlDestructionActivity.SelectedItem.Text.Trim(), txtDestructionBoxBarCode.Text.Trim(), txtDestructionFileBarCode.Text.Trim(), txtDestructionFileCount.Text.Trim());
    //    GridDestructionActivity.DataSource = lstDestructionActivitylist.ToList().Where(res => res.ServiceCategoryId == iDestructionServiceCategId).DefaultIfEmpty();
    //    GridDestructionActivity.DataBind();

    //    List<DestructionActivityList> resultActivitylist = lstDestructionActivitylist.Where(res => res.ServiceCategoryId == iDestructionServiceCategId).DefaultIfEmpty().ToList();
    //    List<DestructionActivityListCount> GetDestructionAcitivityCountByCateg = GetDestructionAcitivityCountByCategory(iDestructionServiceCategId).ToList();
    //    var ResActivityCount = (from res in lstDestructionActivitylist
    //                            join Activitylist in GetDestructionAcitivityCountByCateg on res.ActivityId equals Activitylist.ActivityId
    //                            select new DestructionActivityListCount { ActivityName = res.ActivityName, ActivityId = res.ActivityId, FileCount = Activitylist.FileCount, ActivityCount = Activitylist.ActivityCount }).Distinct();

    //    var GetDestructActivityCount = from DestructionActivity in ResActivityCount.ToList()
    //                                   group DestructionActivity by
    //                                   new { DestructionActivity.ActivityName, DestructionActivity.ActivityId, DestructionActivity.FileCount } into grpDestruction
    //                                   select new DestructionActivityListCount
    //                                   {
    //                                       ActivityName = grpDestruction.Key.ActivityName,
    //                                       ActivityId = grpDestruction.Key.ActivityId,
    //                                       ActivityCount = grpDestruction.Count(),
    //                                       FileCount = grpDestruction.Key.FileCount
    //                                   };
    //    GridDestructionActivityCount.DataSource = GetDestructActivityCount;
    //    GridDestructionActivityCount.DataBind();
    //    //txtDestructionFileBarCode.Text = "";
    //    //txtDestructionFileCount.Text = "";

    protected void Validate_Destruction(object sender, ServerValidateEventArgs e)
    {
        if (GridDestructionActivity.Rows.Count > 0)
            e.IsValid = true;
        else
            e.IsValid = false;
    }
    #endregion DestructionBoxFileDetailsTable
    #region ActivityList Count list
    protected List<ActivityListCount> GetAcitivityCountByCategory(int iServiceCategoryId)
    {
        var qry = from cust in lstActivitylist.ToList().DefaultIfEmpty()
                  where cust.ServiceCategoryId == iServiceCategoryId
                  group cust by new { cust.RetrPickUpAddressId, cust.RetrPickUpAddress, cust.ActivityName, cust.ActivityId }
                      into grp
                      select new ActivityListCount
                      {
                          RetrPickUpAddressId = grp.Key.RetrPickUpAddressId,
                          RetrPickUpAddress = grp.Key.RetrPickUpAddress,
                          ActivityName = grp.Key.ActivityName,
                          ActivityId = grp.Key.ActivityId,
                          ActivityCount = grp.Count(),
                      };
        List<ActivityListCount> duplicateEmployees = qry.Except(qry.GroupBy(i => i).Select(ss => ss.FirstOrDefault())).ToList();
        return (List<ActivityListCount>)qry.ToList();
    }

    //protected List<DestructionActivityListCount> GetDistrAcitivityCountByCategory(int iServiceCategoryId)
    //{
    //    var qry = from cust in lstDestructionActivitylist.ToList().DefaultIfEmpty()
    //              where cust.ServiceCategoryId == iServiceCategoryId
    //              group cust by new { cust.ActivityName, cust.ActivityId }
    //                  into grp
    //                  select new DestructionActivityListCount
    //                  {
    //                      ActivityName = grp.Key.ActivityName,
    //                      ActivityId = grp.Key.ActivityId,
    //                      ActivityCount = grp.Count(),
    //                  };
    //    List<DestructionActivityListCount> duplicateEmployees = qry.Except(qry.GroupBy(i => i).Select(ss => ss.FirstOrDefault())).ToList();
    //    return (List<DestructionActivityListCount>)qry.ToList();
    //}


    protected List<ActivityList> GetActivitylist(int iServiceCategoryId)
    {
        var qry = from cust in lstActivitylist.ToList().DefaultIfEmpty()
                  where cust.ServiceCategoryId == iServiceCategoryId
                  select cust;
        return (List<ActivityList>)qry.ToList();
    }
    protected void AddActivitylist(int iPickUpAddressId, string strPickUpAddress, int iServiceCategoryId, int iActivityId, string strActivityName, string strBoxBarCode, string strFileBarCode)
    {
        List<ActivityList> _lstActivityList = new List<ActivityList>();
        if (Session["WorkOrder_ActivityList"] != null)
        {
            _lstActivityList = (List<ActivityList>)Session["WorkOrder_ActivityList"];
        }
        _lstActivityList.Add(new ActivityList
        {
            RetrPickUpAddressId = iPickUpAddressId,
            RetrPickUpAddress = strPickUpAddress,
            ActivityId = iActivityId,
            ActivityName = strActivityName,
            BoxBarCode = strBoxBarCode,
            FileBarCode = strFileBarCode,
            ServiceCategoryId = iServiceCategoryId,
        });
        lstActivitylist = _lstActivityList;
    }
    protected void AddDesructionActivitylist(int iServiceCategoryId, int iActivityId, string strActivityName, string strBoxBarCode, string strFileBarCode)
    {
        List<DestructionActivityList> _lstdestrActivityList = new List<DestructionActivityList>();
        if (ViewState["DestructionActivityList"] != null)
        {
            _lstdestrActivityList = (List<DestructionActivityList>)ViewState["DestructionActivityList"];
        }
        _lstdestrActivityList.Add(new DestructionActivityList
        {
            ActivityId = iActivityId,
            ActivityName = strActivityName,
            BoxBarCode = strBoxBarCode,
            FileBarCode = strFileBarCode,
            ServiceCategoryId = iServiceCategoryId,
        });
        lstDestructionActivitylist = _lstdestrActivityList;
    }
    protected List<ActivityList> lstActivitylist
    {
        get
        {
            List<ActivityList> lstRetrivalActivityList = new List<ActivityList>();
            lstRetrivalActivityList = null;
            if (Session["WorkOrder_ActivityList"] != null)
            {
                lstRetrivalActivityList = (List<ActivityList>)(Session["WorkOrder_ActivityList"]);
                return lstRetrivalActivityList.ToList();
            }
            else return null;
        }
        set
        {
            Session["WorkOrder_ActivityList"] = value;
        }
    }

    protected List<DestructionActivityList> GetDestructionActivitylist(int iServiceCategoryId)
    {

        var qry = from cust in lstDestructionActivitylist.ToList().DefaultIfEmpty()
                  where cust.ServiceCategoryId == iServiceCategoryId
                  select cust;
        return (List<DestructionActivityList>)qry.ToList();
    }

   
    protected List<DestructionActivityList> lstDestructionActivitylist
    {
        get
        {
            List<DestructionActivityList> lstDestructionActivityList = new List<DestructionActivityList>();
            lstDestructionActivityList = null;
            if (ViewState["DestructionActivityList"] != null)
            {
                lstDestructionActivityList = (List<DestructionActivityList>)(ViewState["DestructionActivityList"]);
                return lstDestructionActivityList.ToList();
            }
            else return null;
        }
        set
        {
            ViewState["DestructionActivityList"] = value;
        }
    }

    protected List<OtherServicesActivityList> GetOtherServicesActivityList(int iServiceCategoryId)
    {

        var qry = from cust in lstOtherServicesActivityList.ToList().DefaultIfEmpty()
                  where cust.ServiceCategoryId == iServiceCategoryId
                  select cust;
        return (List<OtherServicesActivityList>)qry.ToList();
    }

    protected void AddOtherServicesActivitylist(int iServiceCategoryId, int iActivityId, string strActivityName, string strBoxBarCode, string strFileBarCode, string sFileCount)
    {
        List<OtherServicesActivityList> _lstActivityList = new List<OtherServicesActivityList>();
        if (ViewState["OtherServicesActivityList"] != null)
        {
            _lstActivityList = (List<OtherServicesActivityList>)ViewState["OtherServicesActivityList"];
        }
        _lstActivityList.Add(new OtherServicesActivityList
        {
            ActivityId = iActivityId,
            ActivityName = strActivityName,
            BoxBarCode = strBoxBarCode,
            FileBarCode = strFileBarCode,
            ServiceCategoryId = iServiceCategoryId,
            FileCount = sFileCount
        });
        lstOtherServicesActivityList = _lstActivityList;
    }

    protected List<DestructionActivityListCount> GetDestructionAcitivityCountByCategory(int iServiceCategoryId)
    {
        var AddDestrucActivityCount = from cust in lstDestructionActivitylist.ToList().DefaultIfEmpty()
                                      where cust.ServiceCategoryId == iServiceCategoryId
                                      group cust by new { cust.ActivityName, cust.ActivityId, cust.FileCount }
                                          into grp
                                          select new DestructionActivityListCount
                                          {
                                              ActivityName = grp.Key.ActivityName,
                                              ActivityId = grp.Key.ActivityId,
                                              ActivityCount = grp.Count(),
                                              FileCount = grp.Key.FileCount
                                          };
        List<DestructionActivityListCount> duplicateEmployees = AddDestrucActivityCount.Except(AddDestrucActivityCount.GroupBy(i => i).Select(ss => ss.FirstOrDefault())).ToList();
        return (List<DestructionActivityListCount>)AddDestrucActivityCount.ToList();
    }


    protected List<OtherServicesActivityList> lstOtherServicesActivityList
    {
        get
        {
            List<OtherServicesActivityList> lstOtherServicesActivityList = new List<OtherServicesActivityList>();
            if (ViewState["OtherServicesActivityList"] != null)
            {
                lstOtherServicesActivityList = (List<OtherServicesActivityList>)(ViewState["OtherServicesActivityList"]);
            }
            return lstOtherServicesActivityList.ToList();
        }
        set
        {
            ViewState["OtherServicesActivityList"] = value;
        }
    }

    //protected List<DestructionActivityList> lstDestructionActivitylist
    //{
    //    get
    //    {
    //        List<DestructionActivityList> lstDestructionActivityList = new List<DestructionActivityList>();
    //        lstDestructionActivityList = null;
    //        if (ViewState["DestructionActivityList"] != null)
    //        {
    //            lstDestructionActivityList = (List<DestructionActivityList>)(ViewState["DestructionActivityList"]);
    //        }
    //        return lstDestructionActivityList.ToList();
    //    }
    //    set
    //    {
    //        ViewState["DestructionActivityList"] = value;
    //    }
    //}



    #endregion ActivityList and ActivityListCount
    #region Autocomplete extender for Box BarCode And File Barcode
    [System.Web.Services.WebMethod]
    [System.Web.Script.Services.ScriptMethod()]
    public static List<Autocomplete> GetBoxBarCode(string prefix, string CustomerId, int BoxFileStatus)
    {
        short iInOutStatus = 0;
        switch (Convert.ToInt16(BoxFileStatus))
        {
            case 1: ;
                iInOutStatus = Convert.ToInt16(GetBoxFileStatus("In"));
                break;
            case 2:
                iInOutStatus = Convert.ToInt16(GetBoxFileStatus("Out"));
                break;
            default:
                break;
        }
        DataSet ds = objTRANSStBAL.GetBoxbarCode(Convert.ToInt32(CustomerId), iInOutStatus);
        List<Autocomplete> result = new List<Autocomplete>();
        if (ds.Tables.Count > 0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    result.Add(new Autocomplete
                    {
                        label = Convert.ToString(ds.Tables[0].Rows[i]["BoxBarCode"]),
                        value = Convert.ToInt32(ds.Tables[0].Rows[i]["BoxId"])
                    });
                }
            }
        }
        var res = result.ToList().Where(r => r.label.ToLower().IndexOf(prefix.ToLower()) != -1);
        return res.ToList();
    }
    [System.Web.Services.WebMethod]
    [System.Web.Script.Services.ScriptMethod()]
    public static List<Autocomplete> GetFileBaCode(string prefix, string CustomerId, string BoxId, int FileStatus)
    {
        short iInOutStatus = 0;
        switch (Convert.ToInt16(FileStatus))
        {
            case 1:
                iInOutStatus = Convert.ToInt16(GetBoxFileStatus("In"));
                break;
            case 2:
                iInOutStatus = Convert.ToInt16(GetBoxFileStatus("Out"));
                break;
            default:
                break;
        }

        int iBoxId = 0;
        if (!string.IsNullOrEmpty(BoxId))
        {
            iBoxId = Convert.ToInt32(BoxId);
        }
        DataSet ds = objTRANSStBAL.GetFileBarCode(Convert.ToInt32(CustomerId), iBoxId, iInOutStatus);
        List<Autocomplete> result = new List<Autocomplete>();
        if (ds.Tables.Count > 0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    result.Add(new Autocomplete
                    {
                        label = Convert.ToString(ds.Tables[0].Rows[i]["FileBarCode"]),
                        value = Convert.ToInt32(ds.Tables[0].Rows[i]["FileId"])
                    });
                }
            }
        }
        var res = result.ToList().Where(r => r.label.ToLower().IndexOf(prefix.ToLower()) != -1);
        return res.ToList();
    }

    #endregion Autocomplete extender for Box BarCode And Filre Barcode
    protected void BindDepartment()
    {
        DataSet dsdepartment = objPRSMBAL.GetApplicationCodeDetails("DEPARTMENT", "");
        if (dsdepartment.Tables[0].Rows.Count > 0)
        {
            ddlDepartment.DataSource = dsdepartment.Tables[0];
            ddlDepartment.DataValueField = "AppCodeId";
            ddlDepartment.DataTextField = "AppCodeName";
            ddlDepartment.DataBind();
            ddlDepartment.Items.Insert(0, new ListItem("--Select--", "0"));
        }
    }
    protected void rdblst_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblMessage.Text = "";
        disableServiceRequestsCategory();


    }
    protected void BindServiceCategory(byte bServiceCategoryId)
    {
        List<ServiceCategory> lstCategory = objPRSMBAL.GetServiceCategory(bServiceCategoryId);
        lstCategory = lstCategory.Where(m => m.DisplayOrder != 0).ToList();
        rdblst.DataSource = null;
        rdblst.DataBind();
        rdblst.DataSource = lstCategory;
        rdblst.DataValueField = "ServiceCategoryId";
        rdblst.DataTextField = "SCName";
        rdblst.DataBind();


    }
    public void disableServiceRequestsCategory()
    {
        divFilepickup.Style["display"] = "none";
        divRetrival.Style["display"] = "none";
        divOtherServices.Style["display"] = "none";
        divPermanentReturn.Style["display"] = "none";
        divDestruction.Style["display"] = "none";
        int iServiceCategoryId = 0;
        CstmValidOtherServiceGrd.Visible = false;
        customvalidateRetrival.Visible = false;
        customvalidatePermannet.Visible = false;
        customvalidateDestruction.Visible = false;
        cstmValidFilePickUpAddr.Visible = false;
        //rfvnoBoxes.Visible = false;
        rfvnDatePickUp.Visible = false;
        //rfvnoFiles.Visible = false;

        if (rdblst.Items.FindByText("File Pick Up").Selected)
        {
            grdOtherServicesFiles.Visible = false;
            hlOtherServices.Visible = false;
            FileUpload3.Visible = false;
            Lbllfile.Visible = false;
            btnFile.Visible = false;

            grdErrors.DataSource = null;
            grdErrors.DataBind();

            cstmValidFilePickUpAddr.Visible = true;
            divFilepickup.Style["display"] = "block";
            //rfvnoBoxes.Visible = true;
            rfvnDatePickUp.Visible = true;
            //rfvnoFiles.Visible = true;
            ddlDepartment.SelectedIndex = 0;

        }
        else
        {
            //grdOtherServiceActivity.DataSource = null;
            //grdOtherServiceActivity.DataBind();
            //divFilepickup.Style["display"] = "none";
            //txtdateofPickup.Text = "";
            //txtnoofboxes.Text = "";
            //txtnooffiles.Text = "";
            //ddlDepartment.SelectedIndex = 0;
            //chkboxesconfirm.Checked = false;
            //grdFilePickUpAddress.DataSource = null;
            //grdFilePickUpAddress.DataBind();
            //ddlFilePickUpAddress.SelectedIndex = 0;
            //ViewState["PickUpAddress"] = null;
        }
        if (rdblst.Items.FindByText("Retrieval").Selected)
        {
            grdOtherServicesFiles.Visible = false;
            hlOtherServices.Visible = false;
            FileUpload3.Visible = false;
            Lbllfile.Visible = false;
            btnFile.Visible = false;

            grdErrors.DataSource = null;
            grdErrors.DataBind();

            customvalidateRetrival.Visible = true;
            divRetrival.Style["display"] = "block";
            ddlRetrivalActivity.DataSource = null;
            ddlRetrivalActivity.DataBind();
            DataTable dtRetrieval = objPRSMBAL.GetActivitybyCategory(Convert.ToInt32(rdblst.Items.FindByText("Retrieval").Value)).Tables[0];
            Cache["dtResult"] = dtRetrieval;
            DataRow[] foundrows = dtRetrieval.Select("ActivityName not in ('Hand Delivery Charges Regular [(Within 24 hours) Max 4 box files / One Full Box]','Hand Delivery Charges Express [(Within 12 hours) Max 4 box files / One Full Box]')");
            if (foundrows.Length > 0)
            {
                dtRetrieval = foundrows.CopyToDataTable<DataRow>();
            }
            dtRetrieval.AcceptChanges();
            ddlRetrivalActivity.DataSource = dtRetrieval;
            ddlRetrivalActivity.DataTextField = "ActivityName";
            ddlRetrivalActivity.DataValueField = "ActivityId";
            ddlRetrivalActivity.DataBind();
            ddlRetrivalActivity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
        else
        {
            //grdRetrivalActivityCount.DataSource = null;
            //grdRetrivalActivityCount.DataBind();
            //grdRetrivalActivity.DataSource = null;
            //grdRetrivalActivity.DataBind();
            //divRetrival.Style["display"] = "none";
            //ddlRetrievalPickUpAddress.SelectedIndex = 0;
            //txtBoxBarCode.Text = "";
            //txtFileBarCode.Text = "";
        }

        if (rdblst.Items.FindByText("Permanent Return").Selected)
        {
            grdOtherServicesFiles.Visible = false;
            hlOtherServices.Visible = false;
            FileUpload3.Visible = false;
            Lbllfile.Visible = false;
            btnFile.Visible = false;

            grdErrors.DataSource = null;
            grdErrors.DataBind();

            customvalidatePermannet.Visible = true;
            divPermanentReturn.Style["display"] = "block";
            ddlPermanentActivity.DataSource = null;
            ddlPermanentActivity.DataBind();
            DataTable dtResultPermanent = objPRSMBAL.GetActivitybyCategory(Convert.ToInt32(rdblst.Items.FindByText("Permanent Return").Value)).Tables[0];
            ddlPermanentActivity.DataSource = dtResultPermanent;
            ddlPermanentActivity.DataTextField = "ActivityName";
            ddlPermanentActivity.DataValueField = "ActivityId";
            ddlPermanentActivity.DataBind();
            ddlPermanentActivity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
        else
        {

            //gridPermanentActivityCount.DataSource = null;
            //gridPermanentActivityCount.DataBind();
            //gridPermanentActivity.DataSource = null;
            //gridPermanentActivity.DataBind();
            //divPermanentReturn.Style["display"] = "none";
            //txtPermBoxBarCode.Text = "";
            //txtPermFileBarCode.Text = "";

        }

        if (rdblst.Items.FindByText("Destruction").Selected)
        {
            grdOtherServicesFiles.Visible = false;
            hlOtherServices.Visible = false;
            FileUpload3.Visible = false;
            Lbllfile.Visible = false;
            btnFile.Visible = false;

            grdErrors.DataSource = null;
            grdErrors.DataBind();

            grdDestrErr.DataSource = null;
            grdDestrErr.DataBind();

            //customvalidateDestruction.Visible = true;
            divDestruction.Style["display"] = "block";
            ddlDestructionActivity.DataSource = null;
            ddlDestructionActivity.DataBind();
            DataTable dtDestruction = objPRSMBAL.GetActivitybyCategory(Convert.ToInt32(rdblst.Items.FindByText("Destruction").Value)).Tables[0];
            ddlDestructionActivity.DataSource = dtDestruction;
            ddlDestructionActivity.DataTextField = "ActivityName";
            ddlDestructionActivity.DataValueField = "ActivityId";
            ddlDestructionActivity.DataBind();
            ddlDestructionActivity.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });

            //ddlDestructionActivity.Items.Remove(ddlDestructionActivity.Items.FindByValue("Destruction – Miscellaneous service"));
        }
        else
        {
            //GridDestructionActivity.DataSource = null;
            //GridDestructionActivity.DataBind();
            //GridDestructionActivityCount.DataSource = null;
            //GridDestructionActivityCount.DataBind();
            //divDestruction.Style["display"] = "none";
            //txtDestructionBoxBarCode.Text = "";
            //txtDestructionFileBarCode.Text = "";
        }

        if (rdblst.Items.FindByText("Other services").Selected)
        {
            grdOtherServicesFiles.Visible = true;
            hlOtherServices.Visible = true;
            FileUpload3.Visible = true;
            Lbllfile.Visible = true;
            btnFile.Visible = true;
            //HyperLink5.Visible = true;

            grdErrors.DataSource = null;
            grdErrors.DataBind();

            CstmValidOtherServiceGrd.Visible = true;
            divOtherServices.Style["display"] = "block";
            iServiceCategoryId = Convert.ToInt32(rdblst.Items.FindByText("Other services").Value);
            DataTable dtResult = objPRSMBAL.GetActivitybyCategory(iServiceCategoryId).Tables[0];
            grdOtherAddServiceActivity.DataSource = dtResult;
            grdOtherAddServiceActivity.DataBind();

        }
        else
        {
            //grdOtherAddServiceActivity.DataSource = null;
            //grdOtherAddServiceActivity.DataBind();
            //grdOtherServicesFiles.DataSource = null;
            //grdOtherServicesFiles.DataBind();
            //divOtherServices.Style["display"] = "none";
            //ViewState["OtherServicesActivityList"] = null;
        }
    }
    protected void Validate_OtherServices(object sender, ServerValidateEventArgs e)
    {
        for (int j = 0; j < grdOtherAddServiceActivity.Rows.Count; j++)
        {
            TextBox txtNoOfServices = (TextBox)grdOtherAddServiceActivity.Rows[j].FindControl("txtNoOfServices");
            if (txtNoOfServices.Text != "")
            {
                e.IsValid = true;
                break;
            }
            else
                e.IsValid = false;
        }
    }
    protected void ddlRetrivalActivity_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtBoxBarCode.Text = "";
        txtFileBarCode.Text = "";
        if (ddlRetrivalActivity.SelectedItem.Text.Contains("Select").ToString() == "True")
        {
            ShowHideUploadControls(false, false);
        }
        if (ddlRetrivalActivity.SelectedItem.Text.Contains("Restore").ToString() == "True")
        {
            ShowHideUploadControls(false, false);
            hdnboxfilestatus.Value = "2";
            hdnfilestatus.Value = "2";
        }
        if (ddlRetrivalActivity.SelectedItem.Text.Contains("Retrievals").ToString() == "True")
        {
            if (ddlRetrivalActivity.SelectedItem.Text.Contains("Box").ToString() == "True")
            {
                ShowHideUploadControls(true, false);
            }
            else
            {
                ShowHideUploadControls(false, true);
            }
            hdnboxfilestatus.Value = "1";
            hdnfilestatus.Value = "1";

        }

        if (ddlRetrivalActivity.SelectedItem.Text.Contains("Box").ToString() == "True")
            txtFileBarCode.Enabled = false;
        else
            txtFileBarCode.Enabled = true;
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Status">In,Out,Permanent Out,Destroy</param>
    /// <returns></returns>
    protected static Int16 GetBoxFileStatus(string Status)
    {
        DataSet ds = objPRSMBAL.GetApplicationCodeDetails("BOXFILE_STATUS", "");
        Int16 istatus = 0;
        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
        {
            if (Convert.ToString(ds.Tables[0].Rows[i]["AppCodeName"]).ToUpper() == Status.ToUpper())
            {
                istatus = Convert.ToInt16(ds.Tables[0].Rows[i]["AppCodeId"]);
                break;
            }
        }
        return istatus;
    }
    protected void ddlPermanentActivity_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtPermBoxBarCode.Text = "";
        txtPermFileBarCode.Text = "";
    }
    protected void ddlDestructionActivity_SelectedIndexChanged(object sender, EventArgs e)
    {
        ////txtDestructionBoxBarCode.Text = "";
        ////txtDestructionFileBarCode.Text = "";
        ////txtDestructionFileCount.Text = "";
        //if (ddlDestructionActivity.SelectedItem.Text.Trim() == "destruction of file")
        //{
        //    //lblBoxbarcode.Visible = true;
        //    lblFilebarCode.Visible = true;
        //    txtDestructionBoxBarCode.Visible = true;
        //    txtDestructionFileBarCode.Visible = true;
        //    //lblFileCount.Visible = false;
        //    //txtDestructionFileCount.Visible = false;
        //}
        //if (ddlDestructionActivity.SelectedItem.Text.Trim() == "Destruction – Miscellaneous service")
        //{
        //    //lblBoxbarcode.Visible = false;
        //    lblFilebarCode.Visible = false;
        //    txtDestructionBoxBarCode.Visible = false;
        //    txtDestructionFileBarCode.Visible = false;
        //    //lblFileCount.Visible = true;
        //    //txtDestructionFileCount.Visible = true;
        //}
        //if (ddlDestructionActivity.SelectedItem.Text.Trim() == "File Shredding")
        //{
        //    //lblBoxbarcode.Visible = false;
        //    lblFilebarCode.Visible = false;
        //    txtDestructionBoxBarCode.Visible = false;
        //    txtDestructionFileBarCode.Visible = false;
        //    //lblFileCount.Visible = true;
        //    //txtDestructionFileCount.Visible = true;
        //}
    }
    protected void btnAddFPickUpAddress_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow Gvr in grdFilePickUpAddress.Rows)
        {
            Label lblPickUpAddress = (Label)Gvr.FindControl("lblPickUpAddress");
            if (lblPickUpAddress.Text == ddlFilePickUpAddress.SelectedItem.Text)
            {
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('Duplicate pickup address found.')", true);
                return;
            }
        }
        List<FilePickUpAddress> LstFilePickupAddress = new List<FilePickUpAddress>();
        if (ViewState["PickUpAddress"] != null)
        {
            LstFilePickupAddress = (List<FilePickUpAddress>)ViewState["PickUpAddress"];
        }
        LstFilePickupAddress.Add(new FilePickUpAddress
        {
            FDepartmentId = Convert.ToInt32(ddlDepartment.SelectedValue.ToString()),
            FDepartmentName = ddlDepartment.SelectedItem.ToString(),
            FNoOfBoxes = txtnoofboxes.Text.Trim().Length == 0 ? 0 : Convert.ToInt32(txtnoofboxes.Text),
            FNoOfFiles = txtnooffiles.Text.Trim().Length == 0 ? 0 : Convert.ToInt32(txtnooffiles.Text),
            //FNoOfBoxes = Convert.ToInt32(txtnoofboxes.Text),
            //FNoOfFiles = Convert.ToInt32(txtnooffiles.Text),
            FPickUpAddressId = Convert.ToInt32(ddlFilePickUpAddress.SelectedValue.ToString()),
            FPickUpAddress = ddlFilePickUpAddress.SelectedItem.Text,
            FPickUpDate = txtdateofPickup.Text
        });
        grdFilePickUpAddress.DataSource = LstFilePickupAddress;
        grdFilePickUpAddress.DataBind();
        ViewState["PickUpAddress"] = LstFilePickupAddress;
        ddlDepartment.SelectedIndex = 0;
        txtnoofboxes.Text = "0";
        txtnooffiles.Text = "0";
        ddlFilePickUpAddress.SelectedIndex = 0;

    }
    protected void Validate_FilePickUpAddress(object sender, ServerValidateEventArgs e)
    {
        if (grdFilePickUpAddress.Rows.Count > 0)
            e.IsValid = true;
        else
            e.IsValid = false;
    }
    protected string GetFunctionForBoxBarCode(object IndexNo)
    {


        foreach (GridViewRow row in grdOtherServicesFiles.Rows)
        {

            TextBox txtotherServicesBoxBarCode = (TextBox)row.FindControl("txtotherServicesBoxBarCode");
            TextBox txtOtherServicesFileBarcode = (TextBox)row.FindControl("txtOtherServicesFileBarcode");
            if (txtotherServicesBoxBarCode.Text == "")
            {
                txtOtherServicesFileBarcode.Text = "";
            }
        }

        string strIndexNo = "#ContentPlaceHolder1_grdOtherServicesFiles_selectedValueOtherServices_" + Convert.ToString(IndexNo);
        string functionName = "autocompDrop(this.id,'" + strIndexNo + "');";
        return functionName;
    }
    protected string GetFunctionForFileBarCode(object IndexNo)
    {
        string strIndexNo = "#ContentPlaceHolder1_grdOtherServicesFiles_selectedValueOtherServices_" + Convert.ToString(IndexNo);
        string functionName = "autocompDropFile(this.id,'" + strIndexNo + "');";
        return functionName;
    }
    protected void grdWoOrderUpdFilePickupActivities_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            CheckBox chkActual = (CheckBox)e.Row.FindControl("chkActual");
            Label lblActivity = (Label)e.Row.FindControl("lblActivity");
            TextBox txtUpdateLumsumAount = (TextBox)e.Row.FindControl("txtUpdateLumsumAount");
            if (lblActivity != null)
            {
                if (chkActual != null)
                {
                    chkActual.Visible = false;
                    txtUpdateLumsumAount.Visible = false;
                    if (lblActivity.Text.Trim().ToUpper() == "Standard Box Transportation".ToUpper())
                    {
                        chkActual.Visible = true;
                        //  chkActual.Checked = false;
                        // chkActual.InputAttributes.Add("onchange", "checkLumsumAmount('"+txtUpdateLumsumAount.ClientID  +"')");  
                        txtUpdateLumsumAount.Visible = true;
                    }
                }
            }
        }
    }

    protected void ddlStatusUpdate_SelectedIndexChanged(object sender, EventArgs e)
    {

        for (int i = 0; i < grdWoOrderUpdFilePickupActivities.Rows.Count; i++)
        {
            CheckBox chkActual = (CheckBox)grdWoOrderUpdFilePickupActivities.Rows[i].FindControl("chkActual");
            Label lblActivity = (Label)grdWoOrderUpdFilePickupActivities.Rows[i].FindControl("lblActivity");
            TextBox txtUpdateLumsumAount = (TextBox)grdWoOrderUpdFilePickupActivities.Rows[i].FindControl("txtUpdateLumsumAount");
            TextBox txtBoxCount = (TextBox)grdWoOrderUpdFilePickupActivities.Rows[i].FindControl("txtBoxCount");
            TextBox txtFileCount = (TextBox)grdWoOrderUpdFilePickupActivities.Rows[i].FindControl("txtFileCount");


            if (lblActivity != null)
            {
                if (chkActual != null)
                {
                    chkActual.Visible = false;
                    txtUpdateLumsumAount.Visible = false;
                    if (ddlStatusUpdate.SelectedItem.Text == "Closed")
                    {
                        if (ddlRequestedService.SelectedItem.Text == "File Pick Up")
                        {
                            int n_PendingCount = 0;
                            n_PendingCount = objTRANSBAL.GetPendingFreshFilePickupCountByWorkorderNo(Convert.ToInt32(ddlWorkOrder.SelectedValue));


                            if (n_PendingCount > 0)
                            {
                                ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('" + n_PendingCount + " Files pending for approval\\nWork Order can not be closed at this time')", true);
                                btnSubmit.Visible = false;
                                return;
                            }

                        }

                        if (lblActivity.Text.Trim().ToUpper() == "Standard Box Transportation".ToUpper())
                        {
                            chkActual.Visible = true;
                            txtUpdateLumsumAount.Visible = true;
                            txtUpdateLumsumAount.Enabled = false;
                            chkActual.Enabled = true;
                            //  txtBoxCount.Enabled = false;
                            //txtBoxCount.Text = "0";
                            //txtFileCount.Text = "0";
                            //txtFileCount.Enabled = false;
                            txtUpdateLumsumAount.Text = "0";
                        }

                    }
                    else if (ddlStatusUpdate.SelectedItem.Text == "Open")
                    {
                        btnSubmit.Visible = true;
                        if (lblActivity.Text.Trim().ToUpper() == "Standard Box Transportation".ToUpper())
                        {

                            txtUpdateLumsumAount.Enabled = false;
                            chkActual.Checked = false;
                            chkActual.Enabled = false;
                            chkActual.Visible = true;
                            txtFileCount.Enabled = true;
                            txtBoxCount.Enabled = true;
                            txtUpdateLumsumAount.Text = string.Empty;
                            int istatus = GetActivityStatus("Open");
                            grdWoOrderUpdFilePickupActivities.DataSource = null;
                            grdWoOrderUpdFilePickupActivities.DataBind();
                            if (ddlRequestedService.SelectedIndex > 0)
                            {
                                int iRequestedService = Convert.ToInt32(ddlRequestedService.SelectedItem.Value);
                                DataSet dsWOActivity = objTRANSBAL.GetWoActivity(0, Convert.ToInt32(ddlWorkOrder.SelectedValue), istatus, "Work Order", iRequestedService);
                                if (ddlRequestedService.SelectedIndex > 0)
                                {
                                    if (dsWOActivity.Tables[0].Rows.Count > 0)
                                    {
                                        grdWoOrderUpdFilePickupActivities.DataSource = dsWOActivity.Tables[0];
                                        grdWoOrderUpdFilePickupActivities.DataBind();
                                    }
                                }
                            }
                        }
                    }

                    if (ddlStatusUpdate.SelectedIndex == 0)
                    {
                        if (lblActivity.Text.Trim().ToUpper() == "Standard Box Transportation".ToUpper())
                        {
                            txtUpdateLumsumAount.Enabled = false;
                            chkActual.Checked = false;
                            chkActual.Enabled = false;
                            chkActual.Visible = true;
                            txtFileCount.Enabled = true;
                            txtBoxCount.Enabled = true;
                            txtUpdateLumsumAount.Text = string.Empty;
                        }
                    }

                }

            }
        }
    }

    protected void CustomValLumSumAmount_ServerValidate(object sender, ServerValidateEventArgs e)
    {
        long zeroValidate = Convert.ToInt64(e.Value.ToString().Replace(" ", "").Trim());
        if (zeroValidate == 0)
            e.IsValid = false;
        else
            e.IsValid = true;
    }

    protected void chkActual_CheckedChanged(object sender, EventArgs e)
    {
        for (int i = 0; i < grdWoOrderUpdFilePickupActivities.Rows.Count; i++)
        {
            TextBox txtUpdateLumsumAount = (TextBox)grdWoOrderUpdFilePickupActivities.Rows[i].FindControl("txtUpdateLumsumAount");
            Label lblActivity = (Label)grdWoOrderUpdFilePickupActivities.Rows[i].FindControl("lblActivity");
            CheckBox chkActual = (CheckBox)grdWoOrderUpdFilePickupActivities.Rows[i].FindControl("chkActual");
            TextBox txtBoxCount = (TextBox)grdWoOrderUpdFilePickupActivities.Rows[i].FindControl("txtBoxCount");
            TextBox txtFileCount = (TextBox)grdWoOrderUpdFilePickupActivities.Rows[i].FindControl("txtFileCount");
            txtUpdateLumsumAount.Text = string.Empty;

            if (chkActual.Checked == true && lblActivity.Text.Trim().ToUpper() == "Standard Box Transportation".ToUpper())
            {
                if (txtBoxCount.Text.ToString() != "0")
                {
                    ViewState["BoxCount"] = txtBoxCount.Text;
                }
                if (txtFileCount.Text.ToString() != "0")
                {
                    ViewState["FileCount"] = txtFileCount.Text;
                }

                txtBoxCount.Enabled = false;
                txtFileCount.Enabled = false;
                txtUpdateLumsumAount.Visible = true;
                txtUpdateLumsumAount.Enabled = true;
                txtBoxCount.Text = "0";
                txtFileCount.Text = "0";
            }
            else
            {
                if (lblActivity.Text.Trim().ToUpper() == "Standard Box Transportation".ToUpper())
                {
                    if (ViewState["BoxCount"] != null)
                    {
                        txtBoxCount.Text = ViewState["BoxCount"].ToString();
                    }
                    if (ViewState["FileCount"] != null)
                    {
                        txtFileCount.Text = ViewState["FileCount"].ToString();
                    }
                }

                txtBoxCount.Visible = true;
                txtFileCount.Visible = true;
                txtBoxCount.Enabled = true;
                txtFileCount.Enabled = true;
                txtUpdateLumsumAount.Visible = false;

            }
        }

    }

    public void ClearServiceRequestDetails()
    {
        rdblst.ClearSelection();
        rdblst.Enabled = true;
        gvFilePickUpSRtoWO.Visible = false;
        gvRetreivalSRtoWO.Visible = false;
        gvOtherServicesSRtoWO.Visible = false;
    }
    protected void ddlServiceRequest_SelectedIndexChanged(object sender, EventArgs e)
    {
        //if (ddlServiceRequest.SelectedIndex > 0)
        //{
        //    int iCustomerId = Convert.ToInt32(ddlServiceRequest.SelectedValue);
        //    BindDemoServiceRequests(iCustomerId);

        //}

        rdblst.ClearSelection();
        if (ddlServiceRequest.SelectedIndex > 0)
        {
            DataSet dsServiceRequests = objPRSMBAL.GetServiceRequestWorkOrder(Convert.ToInt32(ddlServiceRequest.SelectedValue));
            if (dsServiceRequests != null && dsServiceRequests.Tables.Count > 0)
            {
                if (dsServiceRequests.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in dsServiceRequests.Tables[0].Rows)
                    {
                        //rdblst.Items.FindByValue(dr["s_SCName"].ToString()).Selected = true;
                        rdblst.Items.FindByText(dr["s_SCName"].ToString()).Selected = true;
                    }
                    rdblst.Enabled = false;
                }
                if (dsServiceRequests.Tables[1].Rows.Count > 0)
                {
                    List<FilePickUpAddress> LstFilePickupAddress = new List<FilePickUpAddress>();
                    for (int i = 0; dsServiceRequests.Tables[1].Rows.Count > i; i++)
                    {

                        LstFilePickupAddress.Add(new FilePickUpAddress
                                {
                                    FDepartmentId = Convert.ToInt32(/*ddlDepartment.SelectedValue.ToString()*/dsServiceRequests.Tables[1].Rows[i]["DeptId"]),
                                    FDepartmentName = dsServiceRequests.Tables[1].Rows[i]["Department"].ToString(),
                                    FNoOfBoxes = Convert.ToInt32(dsServiceRequests.Tables[1].Rows[i]["No. of Boxes"]),
                                    FNoOfFiles = Convert.ToInt32(dsServiceRequests.Tables[1].Rows[i]["No. of Files"]),//Convert.ToInt32(txtnooffiles.Text),
                                    FPickUpAddressId = Convert.ToInt32(/*ddlFilePickUpAddress.SelectedValue.ToString()*/dsServiceRequests.Tables[1].Rows[i]["PickAddressID"]),
                                    FPickUpAddress = dsServiceRequests.Tables[1].Rows[i]["PickUp Address"].ToString(),
                                    FPickUpDate = dsServiceRequests.Tables[1].Rows[i]["Date"].ToString()
                                });
                    }
                    ViewState["PickUpAddress"] = LstFilePickupAddress;
                    gvFilePickUpSRtoWO.DataSource = dsServiceRequests.Tables[1];
                    gvFilePickUpSRtoWO.DataBind();
                    gvFilePickUpSRtoWO.Visible = true;

                }
                else
                {
                    gvFilePickUpSRtoWO.DataSource = null;
                    gvFilePickUpSRtoWO.DataBind();
                    gvFilePickUpSRtoWO.Visible = false;
                }
                if (dsServiceRequests.Tables[2].Rows.Count > 0)
                {
                    if (dsServiceRequests.Tables[2].Rows.Count > 0)
                    {

                        for (int i = 0; i < dsServiceRequests.Tables[2].Rows.Count; i++)
                        {
                            AddActivitylist(
                            Convert.ToInt32(dsServiceRequests.Tables[2].Rows[i]["PickUpAddressId"].ToString()),
                            dsServiceRequests.Tables[2].Rows[i]["Pickup Address"].ToString(),
                            Convert.ToInt32(dsServiceRequests.Tables[0].Select("s_SCName='Retrieval'")[0]["n_ServiceCategoryId"].ToString())/*iRetrivalServiceCategoryId*//*6*/,
                            Convert.ToInt32(dsServiceRequests.Tables[2].Rows[i]["n_ActivityId"].ToString()),
                            dsServiceRequests.Tables[2].Rows[i]["Activity Name"].ToString(),
                            dsServiceRequests.Tables[2].Rows[i]["Box Bar Code"].ToString(), "");
                        }

                        gvRetreivalSRtoWO.DataSource = dsServiceRequests.Tables[2];
                        gvRetreivalSRtoWO.DataBind();
                        gvRetreivalSRtoWO.Visible = true;
                    }

                }
                else
                {
                    gvRetreivalSRtoWO.DataSource = null;
                    gvRetreivalSRtoWO.DataBind();
                    gvRetreivalSRtoWO.Visible = false;
                }
                if (dsServiceRequests.Tables[3].Rows.Count > 0)
                {
                    gvOtherServicesSRtoWO.DataSource = dsServiceRequests.Tables[3];
                    gvOtherServicesSRtoWO.DataBind();
                    gvOtherServicesSRtoWO.Visible = true;
                }
                else
                {
                    gvOtherServicesSRtoWO.DataSource = null;
                    gvOtherServicesSRtoWO.DataBind();
                    gvOtherServicesSRtoWO.Visible = false;
                }
            }
        }
        else
        {
            ClearServiceRequestDetails();
        }


    }
    //protected void BindDemoServiceRequests(int iCustomerId)
    //{
    //    DataSet dsServiceRequests1 = objPRSMBAL.GetServiceRequestDetailsByWorkorder(iCustomerId);
    //    if (dsServiceRequests1 != null && dsServiceRequests1.Tables.Count > 0 && dsServiceRequests1.Tables[0].Rows.Count > 0)
    //    {
    //        hfemailid.Value = dsServiceRequests1.Tables[0].Rows[0]["s_EmailId"].ToString();           
    //    } 
    //}
    protected void btnBoxUpload_Click(object sender, EventArgs e)
    {

        lblBoxErrorMsg.Text = "";
        grdErrors.DataSource = null;
        grdErrors.DataBind();

        DataTable dtExcelData1 = new DataTable();
        string consString = ConfigurationManager.ConnectionStrings["PRSMDataBaseConnection"].ConnectionString;
        try
        {
            //Upload and save the file
            string excelPath = Server.MapPath("~/Files/") + Path.GetFileName(FileUpload1.PostedFile.FileName);
            FileUpload1.PostedFile.SaveAs(excelPath);
            string conString = string.Empty;
            string extension = Path.GetExtension(FileUpload1.PostedFile.FileName);
            switch (extension)
            {
                case ".xls": //Excel 97-03
                    conString = ConfigurationManager.ConnectionStrings["Excel03ConString"].ConnectionString;
                    break;
                case ".xlsx": //Excel 07 or higher
                    conString = ConfigurationManager.ConnectionStrings["Excel07+ConString"].ConnectionString;
                    break;
            }
            conString = string.Format(conString, excelPath);
            using (OleDbConnection excel_con1 = new OleDbConnection(conString))
            {
                excel_con1.Open();
                string sheet1 = excel_con1.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null).Rows[0]["TABLE_NAME"].ToString();


                dtExcelData1.Columns.AddRange(new DataColumn[1] { new DataColumn("BOX_BARCODE", typeof(string)) });

                using (OleDbDataAdapter oda = new OleDbDataAdapter("SELECT * FROM [" + sheet1 + "]", excel_con1))
                {
                    oda.Fill(dtExcelData1);
                }
                excel_con1.Close();
            }
            //STEP 1 : Truncate table TempData in database
            using (SqlConnection con = new SqlConnection(consString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "truncate table tbl_BoxInfo";
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            //STEP 2 : Get the data from Excel to database

            // string consString = ConfigurationManager.ConnectionStrings["Sameeha"].ConnectionString;
            using (SqlConnection con1 = new SqlConnection(consString))
            {
                using (SqlBulkCopy sqlBulkCopy = new SqlBulkCopy(con1))
                {
                    sqlBulkCopy.DestinationTableName = "dbo.tbl_BoxInfo";
                    sqlBulkCopy.ColumnMappings.Add("BOX_BARCODE", "BOX_BARCODE");
                    con1.Open();
                    sqlBulkCopy.WriteToServer(dtExcelData1);
                    //Label1.Text = "Data Inserted Successfully";
                    con1.Close();
                }
            }
            // Step 3:Validate Tempdata
            DataTable dtBoxBarcode = new DataTable();
            using (SqlConnection con = new SqlConnection(consString))
            {
                using (SqlCommand cmd = new SqlCommand("usp_xlRetr_ValidateBox", con))
                {

                    con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlParameter prm = new SqlParameter();

                    prm.ParameterName = "@custid";
                    prm.SqlDbType = SqlDbType.Int;
                    prm.Value = ddlCustomer.SelectedValue;
                    cmd.Parameters.Add(prm);
                    DataTable dt = new DataTable();
                    SqlDataReader sqdr = cmd.ExecuteReader();
                    dt.Load(sqdr);
                    //sqdr.NextResult();
                    //dtBoxBarcode.Load(sqdr);
                    // dt.Load(cmd.ExecuteReader());
                    con.Close();

                    if (dt.Rows.Count > 0)
                    {
                        //strErrorMsg = "Please correct the following errors in the Excel sheet and then try again.";
                        grdErrors.DataSource = dt;
                        grdErrors.DataBind();
                        return;
                    }
                    //con.Open();
                    //DataTable dt = new DataTable();
                    //SqlDataReader sqdr = cmd.ExecuteReader();
                    //dt.Load(sqdr);
                    ////sqdr.NextResult();
                    //dtBoxBarcode.Load(sqdr);
                    //con.Close();
                    //if (dt.Rows.Count > 0)
                    //{
                    //    //lblmsg.Text = "Please correct the following errors in the Excel sheet and then try again.";
                    //    //GridView1.DataSource = dt;
                    //    //GridView1.DataBind();
                    //    grdErrors.DataSource = dt;
                    //    grdErrors.DataBind();
                    //    return;
                    //}
                }
            }

            //Step 4:Bind the data to gridview
            {
                int iRetrivalServiceCategoryId = 0;
                if (!string.IsNullOrEmpty(rdblst.Items.FindByText("Retrieval").Value))
                {
                    iRetrivalServiceCategoryId = Convert.ToInt32(rdblst.Items.FindByText("Retrieval").Value);
                }
                foreach (DataRow dr in dtExcelData1.Rows)
                {
                    //str = str + dr["FILE_BARCODE"].ToString() + " ";
                    //file = file + dr["FILE_BARCODE"].ToString() + "";
                    if ((lstActivitylist != null && lstActivitylist.Exists(res => res.BoxBarCode.Trim().Equals(dr["BOX_BARCODE"].ToString().Trim()) && res.FileBarCode.Trim().Equals("")) == false)
                        || (lstActivitylist != null && lstActivitylist.Exists(res => res.FileBarCode.Trim().Equals(dr["FILE_BARCODE"].ToString().Trim())) == false)
                        || lstActivitylist == null)
                    {
                        AddActivitylist(Convert.ToInt32(ddlRetrievalPickUpAddress.SelectedValue), ddlRetrievalPickUpAddress.SelectedItem.Text, iRetrivalServiceCategoryId, Convert.ToInt32(ddlRetrivalActivity.SelectedItem.Value), ddlRetrivalActivity.SelectedItem.Text.Trim(), dr["BOX_BARCODE"].ToString(), "");
                    }
                }
                grdRetrivalActivity.DataSource = lstActivitylist.ToList().Where(res => res.ServiceCategoryId == iRetrivalServiceCategoryId).DefaultIfEmpty();
                grdRetrivalActivity.DataBind();
                grdRetrivalActivityCount.DataSource = GetAcitivityCountByCategory(iRetrivalServiceCategoryId);
                grdRetrivalActivityCount.DataBind();
                ddlRetrivalActivity.SelectedIndex = 0;
                txtBoxBarCode.Text = "";
                txtFileBarCode.Text = "";
            }
        }
        catch (Exception ex)
        {

            //lblBoxErrorMsg.Text = ex.Message;
            //lblBoxErrorMsg.ForeColor = System.Drawing.Color.Red;
        }
    }
    /// <summary>
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>

    protected void btnFileUpload_Click1(object sender, EventArgs e)
    {
        lblFileErrorMsg.Text = "";
        grdErrors.DataSource = null;
        grdErrors.DataBind();

        DataTable dtExcelData = new DataTable();
        string consString = ConfigurationManager.ConnectionStrings["PRSMDataBaseConnection"].ConnectionString;

        try
        {
            //Upload and save the file
            string excelPath = Server.MapPath("~/Files/") + Path.GetFileName(FileUpload2.PostedFile.FileName);
            FileUpload2.SaveAs(excelPath);
            string conString = string.Empty;
            string extension = Path.GetExtension(FileUpload2.PostedFile.FileName);
            switch (extension)
            {
                case ".xls": //Excel 97-03
                    conString = ConfigurationManager.ConnectionStrings["Excel03ConString"].ConnectionString;
                    break;
                case ".xlsx": //Excel 07 or higher
                    conString = ConfigurationManager.ConnectionStrings["Excel07+ConString"].ConnectionString;
                    break;
            }
            conString = string.Format(conString, excelPath);
            using (OleDbConnection excel_con = new OleDbConnection(conString))
            {
                excel_con.Open();
                string sheet1 = excel_con.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null).Rows[0]["TABLE_NAME"].ToString();

                //dtExcelData.Columns.AddRange(new DataColumn[1] { new DataColumn("FILE_BARCODE", typeof(string)) });

                using (OleDbDataAdapter oda = new OleDbDataAdapter("SELECT * FROM [" + sheet1 + "]", excel_con))
                {
                    oda.Fill(dtExcelData);
                }
                excel_con.Close();
            }
            using (SqlConnection con = new SqlConnection(consString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "truncate table tbl_FileInfo";
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }


            using (SqlConnection con1 = new SqlConnection(consString))
            {
                using (SqlBulkCopy sqlBulkCopy = new SqlBulkCopy(con1))
                {

                    sqlBulkCopy.DestinationTableName = "dbo.tbl_FileInfo";
                    //sqlBulkCopy.ColumnMappings.Add("BOX_BARCODE", "BOX_BARCODE");
                    sqlBulkCopy.ColumnMappings.Add("FILE_BARCODE", "FILE_BARCODE");
                    con1.Open();
                    sqlBulkCopy.WriteToServer(dtExcelData);
                    //lblmsg.Text = "Data Inserted successfully";
                    con1.Close();
                }
            }

            DataTable dtFileBoxBarcode = new DataTable();
            using (SqlConnection con = new SqlConnection(consString))
            {
                using (SqlCommand cmd = new SqlCommand("usp_xlRetr_ValidateFile", con))
                {

                    con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlParameter prm = new SqlParameter();

                    prm.ParameterName = "@custid";
                    prm.SqlDbType = SqlDbType.Int;
                    prm.Value = ddlCustomer.SelectedValue;
                    cmd.Parameters.Add(prm);
                    DataTable dt = new DataTable();
                    SqlDataReader sqdr = cmd.ExecuteReader();
                    dt.Load(sqdr);
                    //sqdr.NextResult(); 
                    if (!sqdr.IsClosed)
                        dtFileBoxBarcode.Load(sqdr);
                    // dt.Load(cmd.ExecuteReader());
                    con.Close();

                    if (dt.Rows.Count > 0)
                    {
                        //strErrorMsg = "Please correct the following errors in the Excel sheet and then try again.";
                        grdErrors.DataSource = dt;
                        grdErrors.DataBind();
                        return;
                    }
                    //con.Open();
                    //DataTable dt = new DataTable();
                    //SqlDataReader sqdr = cmd.ExecuteReader();
                    //dt.Load(sqdr);
                    //sqdr.NextResult();
                    //dtFileBoxBarcode.Load(sqdr);
                    //con.Close();
                    //if (dt.Rows.Count > 0)
                    //{
                    //    //lblmsg.Text = "Please correct the following errors in the Excel sheet and then try again.";
                    //    //GridView1.DataSource = dt;
                    //    //GridView1.DataBind();
                    //    grdErrors.DataSource = dt;
                    //    grdErrors.DataBind();
                    //    return;
                    //}
                }
            }
            //Step 4:Bind data to gridview
            {

                //string file="";
                int iRetrivalServiceCategoryId = 0;
                if (!string.IsNullOrEmpty(rdblst.Items.FindByText("Retrieval").Value))
                {
                    iRetrivalServiceCategoryId = Convert.ToInt32(rdblst.Items.FindByText("Retrieval").Value);
                }
                string msg = "";
                foreach (DataRow dr in dtFileBoxBarcode.Rows)
                {
                    //str = str + dr["FILE_BARCODE"].ToString() + " ";
                    //file = file + dr["FILE_BARCODE"].ToString() + "";

                    //if ((lstActivitylist != null && lstActivitylist.Exists(res => res.FileBarCode.Trim().Equals(dr["FILE_BARCODE"].ToString().Trim())) == false) || lstActivitylist == null)
                    //    AddActivitylist(Convert.ToInt32(ddlRetrievalPickUpAddress.SelectedValue), ddlRetrievalPickUpAddress.SelectedItem.Text, iRetrivalServiceCategoryId, Convert.ToInt32(ddlRetrivalActivity.SelectedItem.Value), ddlRetrivalActivity.SelectedItem.Text.Trim(), " ", dr["FILE_BARCODE"].ToString());

                    if (lstActivitylist != null)
                    {
                        // Adding Box 
                        //if (dr["FileBarCode"].ToString().Trim() == "")
                        //{
                        //    if (lstActivitylist.Exists(res => res.BoxBarCode.Trim().Equals(dr["BoxBarCode"].ToString().Trim())) == true)
                        //    {
                        //        msg = msg + "<br>" + " Box Bar Code " + dr["BoxBarCode"].ToString().Trim() + " (or some of its files) already added to the list";
                        //    }
                        //}
                        //Adding File else
                        if (lstActivitylist.Exists(res => res.FileBarCode.Trim().Equals(dr["FileBarCode"].ToString().Trim())) == true)
                        {
                            msg = msg + "<br>" + " File Bar Code " + dr["FileBarCode"].ToString().Trim() + " is already added to the list";
                        }

                        //else if (lstActivitylist.Exists(res => res.BoxBarCode.Trim().Equals(dr["BoxBarCode"].ToString().Trim())) == true)
                        //{
                        //    msg = msg + "<br>" + " Box Bar Code " + dr["BoxBarCode"].ToString().Trim() + " (or some of its files) already added to the list";
                        //}

                        else if (lstActivitylist.Exists(res => res.BoxBarCode.Trim().Equals(dr["BoxBarCode"].ToString().Trim()) && res.FileBarCode.ToString().Trim() == "") == true)
                        {
                            msg = msg + "<br>" + " File Bar Code " + dr["FileBarCode"].ToString().Trim() + " is already included in Box Retrieval for Box " + dr["BOX_BARCODE"].ToString().Trim();
                        }
                        else
                            AddActivitylist(Convert.ToInt32(ddlRetrievalPickUpAddress.SelectedValue), ddlRetrievalPickUpAddress.SelectedItem.Text, iRetrivalServiceCategoryId, Convert.ToInt32(ddlRetrivalActivity.SelectedItem.Value), ddlRetrivalActivity.SelectedItem.Text.Trim(), dr["BoxBarCode"].ToString(), dr["FileBarCode"].ToString());
                    }
                    else
                    { //lstActivityList is null no need of checking anything.
                        AddActivitylist(Convert.ToInt32(ddlRetrievalPickUpAddress.SelectedValue), ddlRetrievalPickUpAddress.SelectedItem.Text, iRetrivalServiceCategoryId, Convert.ToInt32(ddlRetrivalActivity.SelectedItem.Value), ddlRetrivalActivity.SelectedItem.Text.Trim(), dr["BoxBarCode"].ToString(), dr["FileBarCode"].ToString());
                    }
                    //if ((lstActivitylist != null && lstActivitylist.Exists(res => res.FileBarCode.Trim().Equals(dr["FILE_BARCODE"].ToString().Trim())) == false) || lstActivitylist == null)
                    //    AddActivitylist(Convert.ToInt32(ddlRetrievalPickUpAddress.SelectedValue), ddlRetrievalPickUpAddress.SelectedItem.Text, iRetrivalServiceCategoryId, Convert.ToInt32(ddlRetrivalActivity.SelectedItem.Value), ddlRetrivalActivity.SelectedItem.Text.Trim(), dr["BOX_BARCODE"].ToString(), dr["FILE_BARCODE"].ToString());
                    //else
                    //{
                    //    if (lstActivitylist != null)
                    //    {
                    //        msg = msg + "<br>" + " File Bar Code " + dr["FILE_BARCODE"].ToString().Trim() + " is already added to the list";
                    //    }

                    //}

                }
                if (msg != "")
                {
                    lblFileErrorMsg.Text = msg;
                    lblFileErrorMsg.ForeColor = Color.Red;
                }
                grdRetrivalActivity.DataSource = lstActivitylist.ToList().Where(res => res.ServiceCategoryId == iRetrivalServiceCategoryId).DefaultIfEmpty();
                grdRetrivalActivity.DataBind();
                grdRetrivalActivityCount.DataSource = GetAcitivityCountByCategory(iRetrivalServiceCategoryId);
                grdRetrivalActivityCount.DataBind();
                ddlRetrivalActivity.SelectedIndex = 0;
                txtBoxBarCode.Text = "";
                txtFileBarCode.Text = "";
                //GridView1.Caption = Path.GetFileName(excelPath);
                //GridView1.DataSource = dtExcelData;
                //GridView1.DataBind();
            }

        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message);
            //lblFileErrorMsg.Text = ex.Message;
            //lblFileErrorMsg.ForeColor = System.Drawing.Color.Red;
        }
    }
    public void ShowMessage(string msg)
    {
        lblFileErrorMsg.Visible = true;
        lblFileErrorMsg.Text = msg;
        lblFileErrorMsg.ForeColor = Color.Red;
    }
    public void ShowHideUploadControls(Boolean box, Boolean file)
    {
        //divBoxUploadControls.Visible = box;
        //LblBox.Visible = box;
        //FileUpload1.Visible = box;
        //btnBoxUpload.Visible = box;
        //HyperLink2.Visible = box;
        //lblBoxErrorMsg.Visible = box;
        //divFileUploadControls.Visible = file;
        //lblFile.Visible = file;
        //FileUpload2.Visible = file;
        //btnFileUpload.Visible = file;
        //HyperLink3.Visible = file;
        //lblFileErrorMsg.Visible = file;
        divBoxUploadControls.Disabled = !box;
        LblBox.Enabled = box;
        FileUpload1.Enabled = box;
        btnBoxUpload.Enabled = box;
        HyperLink2.Enabled = box;
        lblBoxErrorMsg.Enabled = box;
        divFileUploadControls.Disabled = !file;
        lblFile.Enabled = file;
        FileUpload2.Enabled = file;
        btnFileUpload.Enabled = file;
        HyperLink3.Enabled = file;
        lblFileErrorMsg.Enabled = file;
    }


    protected void grdRetrivalActivity_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int index = Convert.ToInt32(e.RowIndex);
        List<ActivityList> lst = lstActivitylist;
        lst.RemoveAt(e.RowIndex);
        lstActivitylist = lst;
        grdRetrivalActivity.DataSource = lstActivitylist;
        grdRetrivalActivity.DataBind();
        int iRetrivalServiceCategoryId = 0;
        if (!string.IsNullOrEmpty(rdblst.Items.FindByText("Retrieval").Value))
        {
            iRetrivalServiceCategoryId = Convert.ToInt32(rdblst.Items.FindByText("Retrieval").Value);
        }
        if (lstActivitylist != null && lstActivitylist.Count > 0)
        {
            grdRetrivalActivityCount.DataSource = GetAcitivityCountByCategory(iRetrivalServiceCategoryId);
            grdRetrivalActivityCount.DataBind();
        }
        else
        {
            grdRetrivalActivityCount.DataSource = null;
            grdRetrivalActivityCount.DataBind();
        }

    }
    protected void btnFile_Click(object sender, EventArgs e)
    {
        //lblFileOtherServices.Text = "";
        //gvOtherFileErr.DataSource = null;
        //gvOtherFileErr.DataBind();

        DataTable dtExceldatafile = new DataTable();
        string consString = ConfigurationManager.ConnectionStrings["PRSMDataBaseConnection"].ConnectionString;
        try
        {
            //Upload and save the file
            string excelPath = Server.MapPath("~/Files/") + Path.GetFileName(FileUpload3.PostedFile.FileName);
            FileUpload3.SaveAs(excelPath);
            string conString = string.Empty;
            string extension = Path.GetExtension(FileUpload3.PostedFile.FileName);
            switch (extension)
            {
                case ".xls": //Excel 97-03
                    conString = ConfigurationManager.ConnectionStrings["Excel03ConString"].ConnectionString;
                    break;
                case ".xlsx": //Excel 07 or higher
                    conString = ConfigurationManager.ConnectionStrings["Excel07+ConString"].ConnectionString;
                    break;
            }
            //ClientScript.RegisterStartupScript(GetType(), "popup", "PopupFiles()", true);
            conString = string.Format(conString, excelPath);
            using (OleDbConnection excel_con = new OleDbConnection(conString))
            {
                excel_con.Open();
                string sheet1 = excel_con.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null).Rows[0]["TABLE_NAME"].ToString();

                //dtExcelData.Columns.AddRange(new DataColumn[1] { new DataColumn("FILE_BARCODE", typeof(string)) });

                using (OleDbDataAdapter oda = new OleDbDataAdapter("SELECT * FROM [" + sheet1 + "]", excel_con))
                {
                    oda.Fill(dtExceldatafile);
                }
                excel_con.Close();

            }
            using (SqlConnection con = new SqlConnection(consString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "truncate table tbl_FileInfo";
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            using (SqlConnection con2 = new SqlConnection(consString))
            {
                using (SqlBulkCopy sqlBulkCopy = new SqlBulkCopy(con2))
                {

                    sqlBulkCopy.DestinationTableName = "dbo.tbl_FileInfo";
                    //sqlBulkCopy.ColumnMappings.Add("BOX_BARCODE", "BOX_BARCODE");
                    sqlBulkCopy.ColumnMappings.Add("FILE_BARCODE", "FILE_BARCODE");
                    con2.Open();
                    sqlBulkCopy.WriteToServer(dtExceldatafile);
                    //lblmsg.Text = "Data Inserted successfully";
                    con2.Close();
                }
            }
            DataTable dtFileBarcode = new DataTable();
            using (SqlConnection con = new SqlConnection(consString))
            {
                using (SqlCommand cmd = new SqlCommand("usp_xlRetr_ValidateFile", con))
                {
                    con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlParameter prm = new SqlParameter();

                    prm.ParameterName = "@custid";
                    prm.SqlDbType = SqlDbType.Int;
                    prm.Value = ddlCustomer.SelectedValue;
                    cmd.Parameters.Add(prm);
                    DataTable dt = new DataTable();
                    SqlDataReader sqdr = cmd.ExecuteReader();
                    dt.Load(sqdr);
                    //sqdr.NextResult(); 
                    if (!sqdr.IsClosed)
                        dtFileBarcode.Load(sqdr);
                    // dt.Load(cmd.ExecuteReader());
                    con.Close();

                    if (dt.Rows.Count > 0)
                    {
                        //strErrorMsg = "Please correct the following errors in the Excel sheet and then try again.";
                        gvOtherFileErr.DataSource = dt;
                        gvOtherFileErr.DataBind();
                        return;
                    }
                }
            }
            //Bind to gridview         
            {
                if (dtFileBarcode != null)
                {
                    int iOtherServicesServiceCategId = 0;

                    if (!string.IsNullOrEmpty(rdblst.Items.FindByText("Other services").Value))
                    {
                        iOtherServicesServiceCategId = Convert.ToInt32(rdblst.Items.FindByText("Other services").Value);
                    }
                    for (int i = 0; i < dtFileBarcode.Rows.Count; i++)
                    {
                        AddOtherServicesActivitylist(iOtherServicesServiceCategId, Int32.Parse((((HiddenField)grdOtherServicesFiles.Rows[i].FindControl("hdnActivityid"))).Value), "File Retrieval", dtFileBarcode.Rows[i]["BoxBARCODE"].ToString(), dtFileBarcode.Rows[i]["FILEBARCODE"].ToString(), "");

                    }
                    //int j=lstOtherServicesActivityList.RemoveAll(m => m.BoxBarCode.ToString().Trim().Length == 0  && m.FileBarCode.ToString().Trim().Length == 0);
                    List<OtherServicesActivityList> temp = lstOtherServicesActivityList;
                    temp.RemoveAll(m => m.BoxBarCode.ToString().Trim().Length == 0 && m.FileBarCode.ToString().Trim().Length == 0);
                    lstOtherServicesActivityList = temp;
                    grdOtherServicesFiles.DataSource = lstOtherServicesActivityList.ToList();
                    grdOtherServicesFiles.DataBind();
                }

            }

        }
        catch (Exception ex)
        {
            lblFileOtherServices.Text = ex.Message;
            lblFileOtherServices.ForeColor = Color.Red;
        }
    }

    protected void grdOtherAddServiceActivity_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }
    protected void grdOtherAddServiceActivity_DataBound(object sender, EventArgs e)
    {
        for (int i = 0; i < grdOtherAddServiceActivity.Rows.Count; i++)
        {
            if (i != 1 && i != 4)
            {
                Control ctl = grdOtherAddServiceActivity.Rows[i].FindControl("lnkOtherServices");
                ctl.Visible = false;
            }
        }
    }

    protected void btnDestrFileUpload_Click(object sender, EventArgs e)
    {
        lblDstrFileErrorMsg.Text = "";
        grdDestrErr.DataSource = null;
        grdDestrErr.DataBind();

        DataTable dtExcelData = new DataTable();
        string consString = ConfigurationManager.ConnectionStrings["PRSMDataBaseConnection"].ConnectionString;

        try
        {
            //Upload and save the file
            string excelPath = Server.MapPath("~/Files/") + Path.GetFileName(FileUpload5.PostedFile.FileName);
            FileUpload5.SaveAs(excelPath);
            string conString = string.Empty;
            string extension = Path.GetExtension(FileUpload5.PostedFile.FileName);
            switch (extension)
            {
                case ".xls": //Excel 97-03
                    conString = ConfigurationManager.ConnectionStrings["Excel03ConString"].ConnectionString;
                    break;
                case ".xlsx": //Excel 07 or higher
                    conString = ConfigurationManager.ConnectionStrings["Excel07+ConString"].ConnectionString;
                    break;
            }
            conString = string.Format(conString, excelPath);
            using (OleDbConnection excel_con = new OleDbConnection(conString))
            {
                excel_con.Open();
                string sheet1 = excel_con.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null).Rows[0]["TABLE_NAME"].ToString();
                using (OleDbDataAdapter oda = new OleDbDataAdapter("SELECT * FROM [" + sheet1 + "]", excel_con))
                {
                    oda.Fill(dtExcelData);
                }
                excel_con.Close();
            }
            using (SqlConnection con = new SqlConnection(consString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "truncate table tbl_FileInfo";
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            using (SqlConnection con1 = new SqlConnection(consString))
            {
                using (SqlBulkCopy sqlBulkCopy = new SqlBulkCopy(con1))
                {

                    sqlBulkCopy.DestinationTableName = "dbo.tbl_FileInfo";
                    sqlBulkCopy.ColumnMappings.Add("FILE_BARCODE", "FILE_BARCODE");
                    con1.Open();
                    sqlBulkCopy.WriteToServer(dtExcelData);
                    con1.Close();
                }
            }
            DataTable dtdestrFileBoxBarcode = new DataTable();
            using (SqlConnection con = new SqlConnection(consString))
            {
                using (SqlCommand cmd = new SqlCommand("usp_xlRetr_ValidateFile", con))
                {
                    con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlParameter prm = new SqlParameter();
                    prm.ParameterName = "@custid";
                    prm.SqlDbType = SqlDbType.Int;
                    prm.Value = ddlCustomer.SelectedValue;
                    cmd.Parameters.Add(prm);
                    DataTable dt = new DataTable();
                    SqlDataReader sqdr = cmd.ExecuteReader();
                    dt.Load(sqdr);

                    if (!sqdr.IsClosed)
                        dtdestrFileBoxBarcode.Load(sqdr);

                    con.Close();

                    if (dt.Rows.Count > 0)
                    { 
                        grdDestrErr.DataSource = dt;
                        grdDestrErr.DataBind();
                        return;
                    }
                }
            }
            //Step 4:Bind data to gridview
            {
                int iDestructionServiceCategId = 0;
                if (!string.IsNullOrEmpty(rdblst.Items.FindByText("Destruction").Value))
                {
                    iDestructionServiceCategId = Convert.ToInt32(rdblst.Items.FindByText("Destruction").Value);
                }
                string msg = "";
                foreach (DataRow dr in dtdestrFileBoxBarcode.Rows)
                {
                    if (lstDestructionActivitylist != null)
                    {

                        if (lstDestructionActivitylist.Exists(res => res.FileBarCode.Trim().Equals(dr["FileBarCode"].ToString().Trim())) == true)
                        {
                            msg = msg + "<br>" + " File Bar Code " + dr["FileBarCode"].ToString().Trim() + " is already added to the list";
                        }

                        else if (lstDestructionActivitylist.Exists(res => res.BoxBarCode.Trim().Equals(dr["BoxBarCode"].ToString().Trim()) && res.FileBarCode.ToString().Trim() == "") == true)
                        {
                            msg = msg + "<br>" + " File Bar Code " + dr["FileBarCode"].ToString().Trim() + " is already included in Box Retrieval for Box " + dr["BOX_BARCODE"].ToString().Trim();
                        }
                        else
                            AddDesructionActivitylist(iDestructionServiceCategId, Convert.ToInt32(ddlDestructionActivity.SelectedItem.Value), ddlDestructionActivity.SelectedItem.Text.Trim(), dr["BoxBarCode"].ToString(), dr["FileBarCode"].ToString());
                    }
                    else
                    {
                        AddDesructionActivitylist(iDestructionServiceCategId, Convert.ToInt32(ddlDestructionActivity.SelectedItem.Value), ddlDestructionActivity.SelectedItem.Text.Trim(), dr["BoxBarCode"].ToString(), dr["FileBarCode"].ToString());
                    }
                }
                if (msg != "")
                {
                    lblDstrFileErrorMsg.Text = msg;
                    lblDstrFileErrorMsg.ForeColor = Color.Red;
                }
                GridDestructionActivity.DataSource = lstDestructionActivitylist.ToList().Where(res => res.ServiceCategoryId == iDestructionServiceCategId).DefaultIfEmpty();
                GridDestructionActivity.DataBind();

                List<DestructionActivityList> resultActivitylist = lstDestructionActivitylist.Where(res => res.ServiceCategoryId == iDestructionServiceCategId).DefaultIfEmpty().ToList();
                List<DestructionActivityListCount> GetDestructionAcitivityCountByCateg = GetDestructionAcitivityCountByCategory(iDestructionServiceCategId).ToList();
                var ResActivityCount = (from res in lstDestructionActivitylist
                                        join Activitylist in GetDestructionAcitivityCountByCateg on res.ActivityId equals Activitylist.ActivityId
                                        select new DestructionActivityListCount { ActivityName = res.ActivityName, ActivityId = res.ActivityId, FileCount = Activitylist.FileCount, ActivityCount = Activitylist.ActivityCount }).Distinct();

                var GetDestructActivityCount = from DestructionActivity in ResActivityCount.ToList()
                                               group DestructionActivity by
                                               new { DestructionActivity.ActivityName, DestructionActivity.ActivityId } into grpDestruction
                                               select new DestructionActivityListCount
                                               {
                                                   ActivityName = grpDestruction.Key.ActivityName,
                                                   ActivityId = grpDestruction.Key.ActivityId,
                                                   ActivityCount = grpDestruction.Count(), 
                                               };
                GridDestructionActivityCount.DataSource = GetDestructActivityCount;
                GridDestructionActivityCount.DataBind();

                //grdRetrivalActivityCount.DataSource = GetAcitivityCountByCategory(iDestructionServiceCategId);
                //grdRetrivalActivityCount.DataBind();
                //ddlRetrivalActivity.SelectedIndex = 0;
                //txtBoxBarCode.Text = "";
                //txtFileBarCode.Text = "";
                ////GridView1.Caption = Path.GetFileName(excelPath);
                ////GridView1.DataSource = dtExcelData;
                ////GridView1.DataBind();
            }
        }
        catch (Exception ex)
        {
            ShowMessage1(ex.Message);
        }

    }
    public void ShowMessage1(string msg)
    {
        lblDstrFileErrorMsg.Visible = true;
        lblDstrFileErrorMsg.Text = msg;
        lblDstrFileErrorMsg.ForeColor = Color.Red;
    }

    [Serializable]
    public class OtherServiceActivityNameId
    {
        public int ActivityId { get; set; }
        public string ActivityName { get; set; }
    }

    #region ActivityList  ActivityListCount Classes
    [Serializable]
    public class ActivityList
    {
        public int RetrPickUpAddressId { get; set; }
        public string RetrPickUpAddress { get; set; }
        public int ServiceCategoryId { get; set; }
        public int ActivityId { get; set; }
        public string ActivityName { get; set; }
        public string BoxBarCode { get; set; }
        public string FileBarCode { get; set; }
        public string FileCount { get; set; }

    }
    [Serializable]
    public class ActivityListCount
    {
        public int RetrPickUpAddressId { get; set; }
        public string RetrPickUpAddress { get; set; }
        public int ActivityId { get; set; }
        public int ActivityCount { get; set; }
        public string ActivityName { get; set; }
        public string FileCount { get; set; }

    }

    [Serializable]
    public class DestructionActivityList
    {
        public int ActivityId { get; set; }
        public string ActivityName { get; set; }
        public string BoxBarCode { get; set; }
        public string FileBarCode { get; set; }
        public int ServiceCategoryId { get; set; }
        public string FileCount { get; set; }

    }
    [Serializable]
    public class DestructionActivityListCount
    {
        public int ActivityId { get; set; }
        public int ActivityCount { get; set; }
        public string ActivityName { get; set; }
        public string FileCount { get; set; }

    }


    [Serializable]
    public class OtherServicesActivityList
    {
        public int ActivityId { get; set; }
        public string ActivityName { get; set; }
        public string BoxBarCode { get; set; }
        public string FileBarCode { get; set; }
        public int ServiceCategoryId { get; set; }
        public string FileCount { get; set; }

    }
    #endregion ActivityListCount

    #region PickUpAddress
    [Serializable]
    public class FilePickUpAddress
    {
        public int FDepartmentId { get; set; }
        public string FDepartmentName { get; set; }
        public int FNoOfBoxes { get; set; }
        public int FNoOfFiles { get; set; }
        public int FPickUpAddressId { get; set; }
        public string FPickUpAddress { get; set; }
        public string FPickUpDate { get; set; }
    }
    #endregion PickUpAddress

    #region [Genrate Work Order PDF by using bulider pattern]
    /// <summary>
    /// This class is used for create the pdf
    /// </summary>
    class Director
    {
        // Builder uses a complex series of steps 
        public void Construct(IBuilder builder)
        {
            builder.GetRequestService();
            builder.BuildFilePickup();
            builder.BuildFileRetrival();
            builder.BuilOtherServices();
            builder.BuilDestruction();
            builder.BuildParmanentReturn();
        }
    }
    /// <summary>
    /// Impliment Ibulider interface and adding the  parts to the product i.e. Work order PDF
    /// </summary>
    public class ConcreteBuilder : System.Web.UI.Page, IBuilder
    {
        /*======================Constants================================= */
        const string _LOGOIMAGE = "@imagepath@";
        const string _LOGOIMAGE1 = "@imagepath1@";
        const string _ServiceCateg = "@ServiceCateg@";
        const string _CustomerName = "@Name@";
        const string _WONo = "@WONo@";
        const string _Address = "@Address@";
        const string _Date = "@Date@";
        const string _WoCloseDate = "@WoCloseDate@";
        const string _Time = "@Time@";
        const string _ContactPerson = "@ContactPerson@";
        const string _ContactNumber = "@ContactNumber@";
        const string _TableOtherServices = "@TableOtherServices@";
        const string _WOSUMMARY = "@WOSUMMARY@";
        const string _RequestedActivity = "@TableRequestedActivity@";
        const string _WoStatus = "@WoStatus@";
        const string FullFilePath = "~/Reports/WorkOrder.htm";
        //const string LogoImagePath = "~/images/prsm-logo.png";
        //const string LogoImagePath1 = "~/images/panoramic-group-logo1.png";
        const string LogoImagePath = "~/images/apaar-logo.png";
        const string LogoImagePath1 = "~/images/apaar-logo.png";
        const string chkServiceCateg = "~/images/chkCategory.png";
        const string strPathToBeConfirm = "~/images/chkCategory.png";
        public static PRSMBAL.TransactionBAL objTRANSBAL = new TransactionBAL();

        //======================================================================

        private Product product = new Product();
        public PRSMBAL.MasterBAL objPRSMBAL = new MasterBAL();
        private GetPDFTables ObjPdfTAbles = new GetPDFTables();
        public byte IsNew { get; set; }
        private int TotalServices { get; set; }
        private int CurrentService { get; set; }
        public int WorkOrderNo { get; set; }
        List<ReqestedServices> RequestedServiceslist = new List<ReqestedServices>();

        DataTable GetWorkOrderActivity(int ServiceCateGoeryId, int WorkOrderNo, bool isfilepickup)
        {
            DataTable dtServices = new DataTable();
            if (isfilepickup)
            {
                dtServices = objTRANSBAL.GetWoActivitiesByServiceCategory(WorkOrderNo, "Work Order", ServiceCateGoeryId).Tables[0];
            }
            else
            {
                dtServices = objTRANSBAL.GetRetrivalBoxFileDetails(WorkOrderNo, 0, 0, ServiceCateGoeryId).Tables[0];
            }
            return dtServices;
        }

        DataTable GetWorkOrderActivitOtherServices(int ServiceCateGoeryId, int WorkOrderNo, bool isfilepickup)
        {
            DataTable dtOs = new DataTable();
            dtOs = objTRANSBAL.GetWoActivity(0, WorkOrderNo, 0, "Work Order", ServiceCateGoeryId).Tables[0];
            return dtOs;
        }

        DataTable GetWorkOrder(int WorkOrderNo)
        {
            DataTable dtWorkOrderDet = new DataTable();
            dtWorkOrderDet = objTRANSBAL.GetWorkOrder(WorkOrderNo, 0, 0, 0, 0, null, null).Tables[0];
            return dtWorkOrderDet;
        }

        public void SetRequestedServices()
        {
            var list = (from DataRow row in objTRANSBAL.GetWoActivity(0, WorkOrderNo, 0, "Work Order", 0).Tables[0].Rows
                        select new
                        {
                            ServiceId = Convert.ToInt32(row["ServiceCategoryId"].ToString()),
                            ServiceName = row["SCName"].ToString(),
                        }).ToList().Distinct();
            foreach (var item in list)
            {
                RequestedServiceslist.Add(new ReqestedServices()
                {
                    ServiceId = item.ServiceId,
                    ServiceName = item.ServiceName
                });
            }
            TotalServices = RequestedServiceslist.Count;
            product.WorkOrderNo = WorkOrderNo;
        }
        public void GetRequestService()
        {
            SetRequestedServices();
            product.Initlize();
        }
        public void BuildFilePickup()
        {
            int iRequestedService = 0;
            iRequestedService = (from c in RequestedServiceslist
                                 where c.ServiceName == "File Pick Up"
                                 select c.ServiceId).FirstOrDefault();
            iTextSharp.text.pdf.PdfPTable TableFilePickupDetails = null;
            if (iRequestedService > 0)
            {
                CurrentService = CurrentService + 1;
                TableFilePickupDetails = ObjPdfTAbles.GetFilePickup(GetWorkOrderActivity(iRequestedService, WorkOrderNo, true), CurrentService, TotalServices);
                product.Add(TableFilePickupDetails, GetWoHeader(), 0);
                IsNew = 1;

            }

        }
        public void BuildFileRetrival()
        {
            int iRequestedService = 0;
            iRequestedService = (from c in RequestedServiceslist
                                 where c.ServiceName == "Retrieval"
                                 select c.ServiceId).FirstOrDefault();
            iTextSharp.text.pdf.PdfPTable TableFileRetrival = null;
            if (iRequestedService > 0)
            {
                CurrentService = CurrentService + 1;
                TableFileRetrival = ObjPdfTAbles.GetFileRetrival(GetWorkOrderActivity(iRequestedService, WorkOrderNo, false), CurrentService, TotalServices);
                product.Add(TableFileRetrival, GetWoHeader(), IsNew);
                IsNew = 1;

            }
        }
        public void BuildParmanentReturn()
        {
            int iRequestedService = 0;
            iRequestedService = (from c in RequestedServiceslist
                                 where c.ServiceName == "Permanent Return"
                                 select c.ServiceId).FirstOrDefault();
            iTextSharp.text.pdf.PdfPTable TableParmanentReturn = null;
            if (iRequestedService > 0)
            {
                CurrentService = CurrentService + 1;
                TableParmanentReturn = ObjPdfTAbles.GetParmanentReturn(GetWorkOrderActivity(iRequestedService, WorkOrderNo, false), CurrentService, TotalServices);
                product.Add(TableParmanentReturn, GetWoHeader(), IsNew);
            }
        }
        public void BuilOtherServices()
        {
            int iRequestedService = 0;
            iRequestedService = (from c in RequestedServiceslist
                                 where c.ServiceName == "Other services"
                                 select c.ServiceId).FirstOrDefault();
            iTextSharp.text.pdf.PdfPTable TableOtherServices = null;
            if (iRequestedService > 0)
            {
                HttpContext.Current.Session["ServiceRequestId"] = iRequestedService;
                CurrentService = CurrentService + 1;
                TableOtherServices = ObjPdfTAbles.GetOtherServices(GetWorkOrderActivitOtherServices(iRequestedService, WorkOrderNo, false), CurrentService, TotalServices);
                product.Add(TableOtherServices, GetWoHeader(), IsNew);
                IsNew = 1;
            }
        }
        public void BuilDestruction()
        {
            int iRequestedService = 0;
            iRequestedService = (from c in RequestedServiceslist
                                 where c.ServiceName == "Destruction"
                                 select c.ServiceId).FirstOrDefault();
            iTextSharp.text.pdf.PdfPTable TableDestruction = null;
            if (iRequestedService > 0)
            {
                CurrentService = CurrentService + 1;
                TableDestruction = ObjPdfTAbles.GetDestruction(GetWorkOrderActivity(iRequestedService, WorkOrderNo, false), CurrentService, TotalServices);
                product.Add(TableDestruction, GetWoHeader(), IsNew);
                IsNew = 1;

            }
        }
        public string GetRequestedServicesList(int iWorkorderNo)
        {
            DataSet dsWOActivity = objTRANSBAL.GetWoActivity(0, iWorkorderNo, 0, "Work Order", 0);
            DataTable distinctTable = dsWOActivity.Tables[0].AsEnumerable()
                                .GroupBy(r => r.Field<string>("SCName"))
                                .Select(g => g.First())
                                .CopyToDataTable();

            ViewState["dsWOActivity"] = dsWOActivity;
            string strServicesList = string.Empty;
            if (distinctTable != null)
            {

                for (int i = 0; i < distinctTable.Rows.Count; )
                {
                    strServicesList += "<tr> ";
                    strServicesList += " <td width='190' align='left'><img src=" + Server.MapPath(chkServiceCateg) + "  width='10' height='11'/> &nbsp; &nbsp;" + distinctTable.Rows[i]["SCName"] + "</td> ";
                    i = i + 1;
                    if (i < distinctTable.Rows.Count)
                    {
                        strServicesList += "";
                        strServicesList += "<td width='206'  align='left'><img src=" + Server.MapPath(chkServiceCateg) + "  width='10' height='11'/> &nbsp; &nbsp; " + distinctTable.Rows[i]["SCName"] + "</td>  </tr>";
                        i = i + 1;
                    }
                    else
                    {
                        strServicesList += " <td width='206'  align='left'> </td> </tr>";
                    }

                }

            }

            return strServicesList;

        }
       
        public Product GetResult()
        {
            return product;
        }
        public List<iTextSharp.text.IElement> GetWoHeader()
        {
            DataSet dsWOActivity = objTRANSBAL.GetCompanyImage(WorkOrderNo);

            string strTableList = string.Empty;
            strTableList = GetRequestedServicesList(WorkOrderNo);
            string contents = File.ReadAllText(Server.MapPath(FullFilePath));
            contents = contents.Replace(_LOGOIMAGE, dsWOActivity.Tables[0].Rows[0]["Image"].ToString());
            //contents = contents.Replace(_LOGOIMAGE1, Server.MapPath(LogoImagePath1));
            contents = contents.Replace(_RequestedActivity, strTableList);
            List<iTextSharp.text.IElement> _lst = new List<iTextSharp.text.IElement>();
            var parsedHtmlElements = iTextSharp.text.html.simpleparser.HTMLWorker.ParseToList(new StringReader(contents), null);
            foreach (var htmlElement in parsedHtmlElements)
            {
                if (_lst.Count == 1)
                {
                    _lst.Add(ObjPdfTAbles.GetWorkOrderDetails(GetWorkOrder(WorkOrderNo)));
                }
                _lst.Add(htmlElement as iTextSharp.text.IElement);
            }
            return _lst;
        }

    }
    public interface IBuilder
    {
        void GetRequestService();
        void BuildFilePickup();
        void BuildFileRetrival();
        void BuilOtherServices();
        void BuilDestruction();
        void BuildParmanentReturn();
        int WorkOrderNo { get; set; }
        Product GetResult();
    }

    public class Product : System.Web.UI.Page
    {
        iTextSharp.text.Document _document;
        MemoryStream _output;
        iTextSharp.text.pdf.PdfWriter _writer;
        public int WorkOrderNo { get; set; }
        public void Initlize()
        {
            _document = new iTextSharp.text.Document(iTextSharp.text.PageSize.A4, 30, 30, 10, 10);
            _output = new MemoryStream();
            _writer = iTextSharp.text.pdf.PdfWriter.GetInstance(_document, _output);
            _writer.PageEvent = new WorkOrderFooter();
            _document.Open();
            _document.NewPage();
        }
        public void Add(iTextSharp.text.IElement htmlElementpage, List<iTextSharp.text.IElement> htmlelementHeader, byte Isnew)
        {
            if (Isnew == 1)
            {
                _document.NewPage();
            }

            for (int i = 0; i < htmlelementHeader.Count; i++)
            {
                _document.Add(htmlelementHeader[i]);
                if (i == 0 || i == 2)
                {
                    iTextSharp.text.pdf.PdfPTable tableBorder = new iTextSharp.text.pdf.PdfPTable(5);
                    float[] widthstableBorder = new float[] { 300f, 133f, 301f, 133f, 133f };
                    tableBorder.SetWidths(widthstableBorder);
                    tableBorder.WidthPercentage = 100;
                    iTextSharp.text.pdf.PdfPCell cell = new iTextSharp.text.pdf.PdfPCell(new iTextSharp.text.Phrase(" "));
                    cell.Colspan = 5;
                    cell.BorderWidthLeft = 0f;
                    cell.BorderWidthRight = 0f;
                    cell.BorderWidthTop = 0f;
                    cell.BorderWidth = 0f;
                    cell.BorderWidthBottom = 0.1f;
                    tableBorder.AddCell(cell);
                    _document.Add(tableBorder);
                }
            }
            _document.Add(htmlElementpage);
        }

        public void Show()
        {
            _document.Close();
            HttpContext.Current.Response.ContentType = "application/pdf";
            HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment;filename=WO_{0}.pdf", WorkOrderNo.ToString().Replace(" ", "_")));
            HttpContext.Current.Response.BinaryWrite(_output.ToArray());
        }
    }
    public class ReqestedServices
    {
        public int ServiceId { get; set; }
        public string ServiceName { get; set; }
    }
}

#endregion
