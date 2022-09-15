using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using PRSMBAL;
using System.Collections;

public partial class Transaction_ClientPayment : PageBase
{
    public static PRSMBAL.MasterBAL objPRSMBAL = new MasterBAL();
    PageBase objPageBase = new PageBase();
    int? n_AccountId, n_InvoiceNo, n_PaymentType, n_ChequeNumber, n_ModifiedBy, n_Status;
    decimal? n_ClientAccountNo;
    string s_TransactionNumber = string.Empty, d_TransactionDate = string.Empty, s_ClientBank = string.Empty, s_ClientBranch = string.Empty, d_ChequeDate = string.Empty, s_ReasonChequeBounced = string.Empty, s_Remarks = string.Empty;
    decimal? n_TransactionAmount;
    decimal? n_TDS;
    decimal? n_AmtReceived;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (UserId == 0)
        {
            Response.Redirect("~/User/Login.aspx", false);
        }
        if (!IsPostBack)
        {
            ResetAll();
            BindCompanyGroup(0, ddlCompanyGroup);
            GetPaymentType();
            GetPaymentStatus();
            ddlCustomer.Items.Clear();
            ddlCustomer.DataSource = null;
            ddlCustomer.DataBind();
            ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });

            txtTransactionDate.Enabled = false;
            txtTransactionNo.Enabled = false;
            txtChequeDate.Enabled = false;
            txtChequeNo.Enabled = false;
            txtBank.Enabled = false;
            txtBarnch.Enabled = false;
            txtBouncedreason.Enabled = false;
            GetInvoice(Convert.ToInt16(ddlCustomer.SelectedValue));
            ViewState["n_AccountId"] = 0;
            GetPaymentDetails();
        }
    }



    protected void ddlCompanyGroup_SelectedIndexChanged(object sender, EventArgs e)
    {


        if (ddlCompanyGroup.SelectedIndex > 0)
        {
            BindCustomer(Convert.ToByte(ddlCompanyGroup.SelectedItem.Value), ddlCustomer);
        }
        else
        {
            ddlCustomer.Items.Clear();
            ddlCustomer.DataSource = null;
            ddlCustomer.DataBind();
            ddlCustomer.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
        }
    }

    protected void ddlCustomer_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetInvoice(Convert.ToInt16(ddlCustomer.SelectedValue));
    }

    protected void rbtPaymentType_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetDisabledAsPerpaymentType(rbtPaymentType.SelectedItem.Text);
    }
    protected void BindCustomer(int iCompanyId, DropDownList ddlctrl)
    {

        ddlctrl.Items.Clear();
        DataSet dsCustomer = objPRSMBAL.GetCustomer(iCompanyId);
        ddlctrl.DataSource = dsCustomer.Tables[0];
        ddlctrl.DataValueField = "CustomerId";
        ddlctrl.DataTextField = "CustomerName";
        ddlctrl.DataBind();
        ddlctrl.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }
    protected void BindCompanyGroup(int iCompanyId, DropDownList ddlctrl)
    {
        ddlctrl.Items.Clear();
        ddlctrl.DataSource = objPRSMBAL.GetCompanyGroup(iCompanyId);
        ddlctrl.DataValueField = "CompanyGroupId";
        ddlctrl.DataTextField = "CGName";
        ddlctrl.DataBind();
        ddlctrl.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }
    protected void GetInvoice(int iCustomerId)
    {
        DataSet dsInvoice = null;
        ddlInvoice.Items.Clear();
        dsInvoice = objPRSMBAL.GetInvoice(iCustomerId);
        ddlInvoice.DataSource = dsInvoice;
        ddlInvoice.DataValueField = "n_InvoiceNo";
        ddlInvoice.DataTextField = "n_InvoiceNo";
        ddlInvoice.DataBind();
        ddlInvoice.Items.Insert(0, new ListItem { Text = "--Select--", Value = "" });
        if (/*dsInvoice.Tables[0].Rows.Count > 0 && */n_InvoiceNo != null)
        {
            //int index = dsInvoice.Tables[0].Rows.Count + 1;
            ddlInvoice.Items.Insert(ddlInvoice.Items.Count, new ListItem { Text = n_InvoiceNo.ToString(), Value = n_InvoiceNo.ToString() });
        }
    }
    protected void GetPaymentType()
    {
        rbtPaymentType.Items.Clear();
        rbtPaymentType.DataSource = objPRSMBAL.GetPaymentType();
        rbtPaymentType.DataValueField = "n_AppCodeId";
        rbtPaymentType.DataTextField = "s_AppCodeName";
        rbtPaymentType.DataBind();
    }
    protected void GetPaymentStatus()
    {
        ddlStatus.Items.Clear();
        ddlStatus.DataSource = objPRSMBAL.GetPaymentStatus();
        ddlStatus.DataValueField = "n_AppCodeId";
        ddlStatus.DataTextField = "s_AppCodeName";
        ddlStatus.DataBind();
        //ddlStatus.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });
    }


    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            Page.Validate("SaveGroup");
            if (Page.IsValid)
            {
                SaveData();
            }


        }
        catch (Exception ex)
        {

        }
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        ResetAll();
    }


    protected void gvAccountMaster_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName != "EdtUser")
            return;
        ArrayList arg = new ArrayList();
        arg.Add(e.CommandArgument.ToString().Split(';'));
        GridViewRow row = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
        int index = row.RowIndex;
        n_InvoiceNo = Convert.ToInt32(row.Cells[1].Text.Replace("&nbsp;", string.Empty));
        ViewState["n_AccountId"] = ((string[])(arg[0]))[0];
        ddlCompanyGroup.SelectedValue = ((string[])(arg[0]))[4];
        ddlCompanyGroup_SelectedIndexChanged(null, null);
        ddlCustomer.SelectedValue = ((string[])(arg[0]))[1];
        ddlCustomer_SelectedIndexChanged(null, null);
        rbtPaymentType.SelectedValue = ((string[])(arg[0]))[2];
        ddlStatus.SelectedValue = ((string[])(arg[0]))[3];
        txtTransactionDate.Text = row.Cells[5].Text.Replace("&nbsp;", string.Empty);
        txtTransactionNo.Text = row.Cells[4].Text.Replace("&nbsp;", string.Empty);
        txtChequeDate.Text = row.Cells[10].Text.Replace("&nbsp;", string.Empty);
        txtChequeNo.Text = row.Cells[9].Text.Replace("&nbsp;", string.Empty);
        txtBank.Text = row.Cells[6].Text.Replace("&nbsp;", string.Empty);
        txtBarnch.Text = row.Cells[7].Text.Replace("&nbsp;", string.Empty);
        ddlInvoice.SelectedValue = row.Cells[1].Text.Replace("&nbsp;", string.Empty);
        txtAccountNo.Text = row.Cells[8].Text.Replace("&nbsp;", string.Empty);
        txtAmount.Text = row.Cells[11].Text.Replace("&nbsp;", string.Empty);
        txt_TDS.Text = row.Cells[12].Text.Replace("&nbsp;", string.Empty);
        txt_AmtRec.Text = row.Cells[12].Text.Replace("&nbsp;", string.Empty);
        txtRemarks.Text = row.Cells[14].Text.Replace("&nbsp;", string.Empty);
        txtBouncedreason.Text = row.Cells[13].Text.Replace("&nbsp;", string.Empty);
        ddlStatus_SelectedIndexChanged(null, null);
        if (rbtPaymentType.SelectedItem.Text == "RTGS" || rbtPaymentType.SelectedItem.Text == "NEFT")
        {
            txtTransactionDate.Enabled = true;
            txtTransactionNo.Enabled = true;
            txtChequeDate.Enabled = false;
            txtChequeNo.Enabled = false;
            txtBank.Enabled = false;
            txtBarnch.Enabled = false;
            //txtBouncedreason.Enabled = false;
        }
        else
        {
            txtTransactionDate.Enabled = false;
            txtTransactionNo.Enabled = false;
            txtChequeDate.Enabled = true;
            txtChequeNo.Enabled = true;
            txtBank.Enabled = true;
            txtBarnch.Enabled = true;
            //txtBouncedreason.Enabled = true;
        }
    }

    protected void gvAccountMaster_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvAccountMaster.PageIndex = e.NewPageIndex;
        GetPaymentDetails();
    }

    protected void GetDisabledAsPerpaymentType(string strPayType)
    {
        if (strPayType == "RTGS" || strPayType == "NEFT")
        {
            ResetPaymentTypeControle();
            txtTransactionDate.Enabled = true;
            txtTransactionNo.Enabled = true;
            txtChequeDate.Enabled = false;
            txtChequeNo.Enabled = false;
            txtBank.Enabled = false;
            txtBarnch.Enabled = false;
            txtBouncedreason.Enabled = false;
        }
        else
        {
            ResetPaymentTypeControle();
            txtTransactionDate.Enabled = false;
            txtTransactionNo.Enabled = false;
            txtChequeDate.Enabled = true;
            txtChequeNo.Enabled = true;
            txtBank.Enabled = true;
            txtBarnch.Enabled = true;
            if (ddlStatus.SelectedItem.Text == "Bounced")
            {
                txtBouncedreason.Enabled = true;
            }
            else
            {
                txtBouncedreason.Enabled = false;
            }

        }
    }

    protected void ResetPaymentTypeControle()
    {
        txtTransactionDate.Text = string.Empty;
        txtTransactionNo.Text = string.Empty;
        txtChequeDate.Text = string.Empty;
        txtChequeNo.Text = string.Empty;
        txtBank.Text = string.Empty;
        txtBarnch.Text = string.Empty;
        txtBouncedreason.Text = string.Empty;
    }

    protected void ResetAll()
    {
        txtTransactionDate.Text = string.Empty;
        txtTransactionNo.Text = string.Empty;
        txtChequeDate.Text = string.Empty;
        txtChequeNo.Text = string.Empty;
        txtBank.Text = string.Empty;
        txtBarnch.Text = string.Empty;
        ddlCompanyGroup.ClearSelection();
        ddlCustomer.ClearSelection();
        ddlCustomer.Items.Clear();
        ddlInvoice.ClearSelection();
        ddlInvoice.Items.Clear();
        rbtPaymentType.ClearSelection();
        txtAccountNo.Text = string.Empty;
        txtAmount.Text = string.Empty;
        txt_TDS.Text = string.Empty;
        txt_AmtRec.Text = string.Empty;
        txt_netamt.Text = string.Empty;
        txt_diff.Text = string.Empty;
        ddlStatus.ClearSelection();
        txtRemarks.Text = string.Empty;
        txtBouncedreason.Text = string.Empty;
        ViewState["n_AccountId"] = 0;
    }
    protected void SaveData()
    {
        n_AccountId = Convert.ToInt16(ViewState["n_AccountId"]);
        n_InvoiceNo = Convert.ToInt32(ddlInvoice.SelectedValue);
        n_PaymentType = Convert.ToInt16(rbtPaymentType.SelectedValue);
        s_TransactionNumber = string.IsNullOrEmpty(txtTransactionNo.Text) ? null : txtTransactionNo.Text;
        d_TransactionDate = string.IsNullOrEmpty(txtTransactionDate.Text) ? null : txtTransactionDate.Text;
        s_ClientBank = string.IsNullOrEmpty(txtBank.Text) ? null : txtBank.Text;
        s_ClientBranch = string.IsNullOrEmpty(txtBarnch.Text) ? null : txtBarnch.Text;
        n_ClientAccountNo = string.IsNullOrEmpty(txtAccountNo.Text) ? (decimal?)null : Convert.ToDecimal(txtAccountNo.Text);
        n_ChequeNumber = string.IsNullOrEmpty(txtChequeNo.Text) ? (int?)null : Convert.ToInt32(txtChequeNo.Text);
        d_ChequeDate = string.IsNullOrEmpty(txtChequeDate.Text) ? null : txtChequeDate.Text;
        n_TransactionAmount = Convert.ToDecimal(txtAmount.Text);
        n_TDS = Convert.ToDecimal(txt_TDS.Text);
        n_AmtReceived = Convert.ToDecimal(txt_AmtRec.Text);
        n_Status = Convert.ToInt16(ddlStatus.SelectedValue);
        s_ReasonChequeBounced = string.IsNullOrEmpty(txtBouncedreason.Text) ? null : txtBouncedreason.Text;
        s_Remarks = string.IsNullOrEmpty(txtRemarks.Text) ? null : txtRemarks.Text;
        n_ModifiedBy = UserId;

        int IsSuccess = objPRSMBAL.InsertUpdatePayment(n_AccountId, n_InvoiceNo, n_PaymentType, s_TransactionNumber,
             d_TransactionDate, s_ClientBank, s_ClientBranch, n_ClientAccountNo,
                n_ChequeNumber, d_ChequeDate, n_TransactionAmount, n_TDS, n_AmtReceived, n_Status,
                s_ReasonChequeBounced, s_Remarks, n_ModifiedBy);

        if (IsSuccess > 0)
        {
            string msg = IsSuccess == 1 ? "Record Saved Successfully" : "Record Updated Successfully";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('" + msg + "')", true);
            ViewState["n_AccountId"] = 0;
            ResetAll();
            GetPaymentDetails();
        }
        else
        {
            string msg = "Record Not Saved/Updated.\\nPlease Contact to System Admin.";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('" + msg + "')", true);
        }



    }
    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlStatus.SelectedItem.Text == "Bounced" && rbtPaymentType.SelectedItem.Text == "Cheque")
        {
            //txtBouncedreason.Text = string.Empty;
            txtBouncedreason.Enabled = true;
        }
        else
        {
            //txtBouncedreason.Text = string.Empty;
            txtBouncedreason.Enabled = false;
        }
    }


    private void GetPaymentDetails()
    {
        DataSet DsPayment = null;
        DsPayment = objPRSMBAL.GetPaymentDetails();
        gvAccountMaster.DataSource = DsPayment;
        gvAccountMaster.DataBind();

    }

    protected void ddlInvoice_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtAmount.Text = Convert.ToString(objPRSMBAL.GetInvoiceAmount(Convert.ToInt64(ddlInvoice.SelectedValue)));
    }
}