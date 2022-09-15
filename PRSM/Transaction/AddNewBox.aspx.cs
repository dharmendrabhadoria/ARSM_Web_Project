using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PRSMBAL;
using Utility;
using System.Web.Services;
using System.Data;
using Entity;
using UserRoleWiseAcess;
using System.Web.SessionState;
using System.Collections;
using System.Drawing;
using System.Web.Caching;
using System.Globalization;
using System.Xml;


public partial class Transaction_AddNewBox : PageBase //System.Web.UI.Page
{
    public static PRSMBAL.MasterBAL objPRSMBAL = new MasterBAL();
    public static PRSMBAL.TransactionBAL objPRSMTransBAL = new TransactionBAL();
    public static PRSMBAL.TransactionBAL objTRANSStBAL = new TransactionBAL();
    private System.Globalization.CultureInfo enGB = new System.Globalization.CultureInfo("en-GB");

    MakerSearch objMakerSearch = new MakerSearch();
    PageBase objPageBase = new PageBase();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (UserId == 0)
        {
            Response.Redirect("~/User/Login.aspx", false); 
        }
        
    }
    protected void btnAddBox_Click(object sender, EventArgs e)
    {
        try
        {
            #region start
            Page.Validate("SaveGroup");
            if (Page.IsValid)
            {

                int isExist = 0;
                bool Status;
                //int FileId = 0;

                int ActivityId = 0;
                DataSet dsWoActivityId = null;

                Int16 iWareHousId = Convert.ToInt16(Session["WarehouseID"]); //iwarehouseid = Convert.ToInt32(ddlWareHouse.SelectedItem.Value);
                int iCustId = Convert.ToInt32(Session["CustomerId"]); //ddlCustWorkOrder.SelectedItem.Value 
                int WorkOrderNo = Convert.ToInt32(Session["WorkOrderNo"]); ////ddlCustWorkOrder.SelectedItem.Value 
                if ((Request.QueryString["Mode"].ToString()) == "EditBox" || (Request.QueryString["Mode"].ToString()) == "AddBox")
                    ActivityId = 1;
                else
                    ActivityId = 2; 

                dsWoActivityId = objPRSMTransBAL.GetWoActivityId(WorkOrderNo, ActivityId);
                int WoActivityId = Convert.ToInt32(dsWoActivityId.Tables[0].Rows[0]["WoActivityId"]);
                int BranchId = Convert.ToInt32(dsWoActivityId.Tables[0].Rows[0]["BranchId"]);

                objMakerSearch.CustId = iCustId;
                objMakerSearch.WareHouseId = iWareHousId;                
                objMakerSearch.WoActivityId = WoActivityId;
                objMakerSearch.ModifiedBy = 1;
                objMakerSearch.BoxBarcode = txtBoxBarCode.Text.Trim();
                objMakerSearch.BoxLocationCode = txtBoxLocCode.Text.Trim();
                objMakerSearch.ImageDrive = DBNull.Value.ToString();
                objMakerSearch.ImageFolder = DBNull.Value.ToString();

                Status = objPRSMTransBAL.InsertUpdBoxDetails(objMakerSearch, out isExist);

                if (isExist == 1 && (Request.QueryString["Mode"].ToString()) == "EditBox" && Status == true)
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Record Updated Successfully.')", true);                    
                }
                else if (isExist == 2 && (Request.QueryString["Mode"].ToString()) == "AddBox" && Status == true)
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Box Details : " + objMakerSearch.BoxBarcode + " is Inserted Successfully.')", true);
                }
                else if (isExist == -1 && (Request.QueryString["Mode"].ToString()) == "AddBox" && Status == false)
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Box Barcode : " + objMakerSearch.BoxBarcode + " is already exist.')", true);
                }            
            }
            txtBoxBarCode.Text = "";
            txtBoxLocCode.Text = "";
        #endregion
        }
        catch (Exception ex)
        {
            ErrorHandler.WriteLog(ex);
        }
    }
}