using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using PRSMBAL;
using System.Drawing;
using System.Text.RegularExpressions;

public partial class Transaction_UploadExcelData : System.Web.UI.Page
{

    public static PRSMBAL.TransactionBAL objPRSMBAL = new TransactionBAL();
    string consString = ConfigurationManager.ConnectionStrings["PRSMDataBaseConnection"].ConnectionString;
    DataTable dtExcelData = new DataTable();
    DataTable sqlTable = new DataTable();
    DataSet ds = new DataSet();
    
    string strErrorMsg = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            FillWorkorder();
        }
    }
    private void FillWorkorder()
    {
        ddlWorkorderNumber.DataSource = objPRSMBAL.Customerworkorder(0);
        ddlWorkorderNumber.DataValueField = "WorkorderNo";
        ddlWorkorderNumber.DataTextField = "CustomerWorkorder";
        ddlWorkorderNumber.DataBind();
        ddlWorkorderNumber.Items.Insert(0, new ListItem { Text = "--Select--", Value = "0" });

        //using (SqlConnection con1 = new SqlConnection(consString))
        //{
        //    using (SqlCommand cmd1 = new SqlCommand())
        //    {
        //        cmd1.CommandType = CommandType.StoredProcedure;

        //        SqlDataAdapter adp = new SqlDataAdapter(cmd1);
        //        DataTable table = new DataTable();
        //        con1.Open();
        //        cmd1.Connection = con1;
        //        SqlParameter prm = new SqlParameter();

        //        prm.ParameterName = "@WareHouseId";
        //        cmd1.CommandText = "usp_GetCustomer_WorkOrder";
        //        prm.SqlDbType = SqlDbType.Int;
        //        prm.Value = 1;
        //        cmd1.Parameters.Add(prm);

        //        adp.Fill(table);
        //        con1.Close();

        //        ddlWorkorderNumber.DataSource = table;
        //        ddlWorkorderNumber.DataTextField = "CustomerWorkorder";
        //        ddlWorkorderNumber.DataValueField = "WorkorderNo";
        //        ddlWorkorderNumber.DataBind();
        //        ddlWorkorderNumber.Items.Insert(0, new ListItem("--Select--", "0"));

        //    }
        //}
    }
    protected void Upload(object sender, EventArgs e)
    {
        grdError.DataSource = null;
        grdError.DataBind();
        try
        {
            ////STEP 0 : Upload Excel File
            if (Upload_File(strErrorMsg) == false)
            {
                Display_Message(strErrorMsg,false);
                return;
            }
            ////STEP 1 : Truncate table TempData in database
            if (Truncate_TempData(strErrorMsg) == false)
            {
                Display_Message(strErrorMsg, false);
                return;
            }

            ////STEP 2 : Code to get the SQL Table in DataTable & check columns 
            if (Check_Columns() == false)
            {
                Display_Message(strErrorMsg, false);
                return;
            }
                
            //STEP 3: Validate Tempdata
            if (Validate_TempData() == false)
            {
                Display_Message(strErrorMsg, false);
                return;
            }
    
            //STEP 4 : Check and populate dept in tempdata
            if (Check_Department(strErrorMsg) == false)
            {
                Display_Message(strErrorMsg, false);
                return;
            }
            
            //STEP 5 : Finally import the data
            if (Import_Data(strErrorMsg) == false)
            {
                Display_Message(strErrorMsg, false);
                return;
            }
            else
            {
                Display_Message(ds.Tables[0].Rows.Count + "\t" + "Files uploaded successfully.", true); 
            }
        }
        catch (Exception ex )
        {
            Display_Message(ex.Message, false);
        }
    }
    public void Display_Message(string Errormsg,bool Success)
    {
        lblValidationMessage.Text = Errormsg;
        if (Success == false)
        {
            lblValidationMessage.ForeColor = Color.Red;
        }
        else 
        {
            lblAddDepartmentMessage.Text = "";
            lblValidationMessage.ForeColor = Color.Green; 
        }
    }
    public bool Upload_File(string ErrorMsg)
    {
        try
        {
            //Upload and save the file
            string excelPath = Server.MapPath("~/Files/") + Path.GetFileName(FileUpload_Pickup.PostedFile.FileName);
            FileUpload_Pickup.SaveAs(excelPath);
            

            string conString = string.Empty;
            string extension = Path.GetExtension(FileUpload_Pickup.PostedFile.FileName);
            if (extension != String.Empty)
            {
                if (extension.Trim() == ".xls")
                {
                    conString = ConfigurationManager.ConnectionStrings["Excel03ConString"].ConnectionString;
                }
                else if (extension.Trim() == ".xlsx")
                {
                    conString = ConfigurationManager.ConnectionStrings["Excel07+ConString"].ConnectionString;
                }
                else
                {
                    //ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please upload the correct .xls Or .xlsx file format')", true);
                    //return false;
                   
                }
            }


            conString = string.Format(conString, excelPath);
            using (OleDbConnection excel_con = new OleDbConnection(conString))
            {
                excel_con.Open();
                string sheet1 = excel_con.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null).Rows[0]["TABLE_NAME"].ToString();
               
                //[OPTIONAL]: It is recommended as otherwise the data will be considered as String by default.
                //dtExcelData.Columns.AddRange(new DataColumn[14] { new DataColumn("CLIENT NAME", typeof(string)),
                //new DataColumn("BOX BARCODE", typeof(string)),
                //new DataColumn("FILE BARCODE",typeof(string)), 
                //new DataColumn("LOCATION",typeof(string)),
                //new DataColumn("FILE NAME 1",typeof(string)),
                //new DataColumn("FILE NAME 2",typeof(string)),
                //new DataColumn("DEPT",typeof(string)),
                //new DataColumn("YEAR",typeof(string)),
                //new DataColumn("FROM DATE",typeof(DateTime)),
                //new DataColumn("TO DATE",typeof(DateTime)),
                //new DataColumn("FILE TYPE",typeof(string)),
                //new DataColumn("FROM NO",typeof(string)),
                //new DataColumn("TO NO",typeof(string)),
                //new DataColumn("DESTRUCTION DUE DATE",typeof(string))});

                using (OleDbDataAdapter oda = new OleDbDataAdapter("SELECT * FROM [" + sheet1 + "]", excel_con))
                {
                    oda.Fill(dtExcelData);
                }

                using (OleDbCommand cmd = new OleDbCommand("SELECT * FROM [" + sheet1 + "]", excel_con))
                {                  
                    OleDbDataAdapter oda1 = new OleDbDataAdapter(cmd);               
                    ds = new DataSet();
                    oda1.Fill(ds);                 
                }
               
                excel_con.Close();
            }
            return true;
        }
        catch (Exception ex)
        {
            strErrorMsg = ex.Message;
            //lblValidationMessage.Text = "Invalid name of excel sheet" + ex.Message;
            return false;
        }

    }
    public bool Truncate_TempData(string ErrorMsg)
    {
        try
        {
            //STEP 1 : Truncate table TempData in database
            using (SqlConnection con = new SqlConnection(consString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "truncate table TempData";
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    return true;
                }
            }
        }
        catch (Exception ex)
        {
            ErrorMsg = ex.Message;
            return false;
        }

    }
    public bool Check_Columns()
    {  
        try
        {
            
                using (SqlConnection conn = new SqlConnection(consString))
                {
                    using (SqlCommand cmd = new SqlCommand("SELECT * From TempData", conn))
                    {
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            da.Fill(sqlTable);
                        }
                    }
                }

                 //***************Code to get the SQL Table in DataTable End*************//

                if (sqlTable.Columns.Count - 1 > dtExcelData.Columns.Count)
                {
                    strErrorMsg = "Your Excel file does not match with Standard Format.";
                    return false;
                }
                
            /*****column names**/

                List<string> colnames = new List<string>();
                foreach (DataColumn col in dtExcelData.Columns)
                    colnames.Add(col.ColumnName.ToUpper());
                string ErrorMessage = "Excel Sheet does not contain the columns :";
                if (!colnames.Contains("CLIENT NAME")) ErrorMessage = ErrorMessage + (ErrorMessage.EndsWith(":") ? "" : ",") + "CLIENT NAME";
                if (!colnames.Contains("BOX BARCODE")) ErrorMessage = ErrorMessage + (ErrorMessage.EndsWith(":") ? "" : ",")  + "BOX BARCODE";
                if (!colnames.Contains("FILE BARCODE")) ErrorMessage = ErrorMessage + (ErrorMessage.EndsWith(":") ? "" : ",")  + "FILE BARCODE";
                if (!colnames.Contains("LOCATION")) ErrorMessage = ErrorMessage + (ErrorMessage.EndsWith(":") ? "" : ",")  + "LOCATION";
                if (!colnames.Contains("FILE NAME 1")) ErrorMessage = ErrorMessage + (ErrorMessage.EndsWith(":") ? "" : ",")  + "FILE NAME 1";
                if (!colnames.Contains("FILE NAME 2")) ErrorMessage = ErrorMessage + (ErrorMessage.EndsWith(":") ? "" : ",")  + "FILE NAME 2";
                if (!colnames.Contains("DEPT")) ErrorMessage = ErrorMessage + (ErrorMessage.EndsWith(":") ? "" : ",") + "DEPT";
                if (!colnames.Contains("YEAR")) ErrorMessage = ErrorMessage + (ErrorMessage.EndsWith(":") ? "" : ",")  + "YEAR";
                if (!colnames.Contains("FROM DATE")) ErrorMessage = ErrorMessage + (ErrorMessage.EndsWith(":") ? "" : ",")  + "FROM DATE";
                if (!colnames.Contains("TO DATE")) ErrorMessage = ErrorMessage +(ErrorMessage.EndsWith(":") ? "" : ",")  + "TO DATE";
                if (!colnames.Contains("FILE TYPE")) ErrorMessage = ErrorMessage + (ErrorMessage.EndsWith(":") ? "" : ",")  + "FILE TYPE";
                if (!colnames.Contains("FROM NO")) ErrorMessage = ErrorMessage + (ErrorMessage.EndsWith(":") ? "" : ",")  + "FROM NO";
                if (!colnames.Contains("TO NO")) ErrorMessage = ErrorMessage + (ErrorMessage.EndsWith(":") ? "" : ",")  + "TO NO";
                if (!colnames.Contains("DESTRUCTION DUE DATE")) ErrorMessage = ErrorMessage + (ErrorMessage.EndsWith(":") ? "" : ",")  + "DESTRUCTION DUE DATE";


                if (!ErrorMessage.EndsWith(":"))
                {
                    strErrorMsg = ErrorMessage;
                    return false;
                }
            /*******/

            /****column types**/
                if (dtExcelData.Columns["CLIENT NAME"].DataType.FullName != "System.String")
                {
                    strErrorMsg = "CLIENT NAME field is of type " + dtExcelData.Columns["CLIENT NAME"].DataType.Name + ". It must be TEXT.";
                    return false;
                }
                if (dtExcelData.Columns["BOX BARCODE"].DataType.FullName != "System.String")
                {
                    strErrorMsg = "BOX BARCODE field is of type " + dtExcelData.Columns["BOX BARCODE"].DataType.Name + ". It must be TEXT.";
                    return false;
                }
                if (dtExcelData.Columns["FILE BARCODE"].DataType.FullName != "System.String")
                {
                    strErrorMsg = "FILE BARCODE field is of type " + dtExcelData.Columns["FILE BARCODE"].DataType.Name + ". It must be TEXT.";
                    return false;
                }
                if (dtExcelData.Columns["LOCATION"].DataType.FullName != "System.String")
                {
                    strErrorMsg = "LOCATION field is of type " + dtExcelData.Columns["LOCATION"].DataType.Name + ". It must be TEXT.";
                    return false;
                }
                if (dtExcelData.Columns["FILE NAME 1"].DataType.FullName != "System.String")
                {
                    strErrorMsg = "FILE NAME 1 field is of type " + dtExcelData.Columns["FILE NAME 1"].DataType.Name + ". It must be TEXT.";
                    return false;
                }
                if (dtExcelData.Columns["FILE NAME 2"].DataType.FullName != "System.String")
                {
                    strErrorMsg = "FILE NAME 2 field is of type " + dtExcelData.Columns["FILE NAME 2"].DataType.Name + ". It must be TEXT.";
                    return false;
                }
                if (dtExcelData.Columns["DEPT"].DataType.FullName != "System.String")
                {
                    strErrorMsg = "DEPT field is of type " + dtExcelData.Columns["DEPT"].DataType.Name + ". It must be TEXT.";
                    return false;
                }

                //if (dtExcelData.Columns["YEAR"].DataType.FullName != "System.String")
                //{
                //    DataRow[] IsExist = dtExcelData.Select("YEAR is not null");
                //    if (IsExist.Count() > 0)
                //    {
                //    strErrorMsg = "YEAR field is of type " + dtExcelData.Columns["YEAR"].DataType.Name + ". It must be String.";
                //    return false;
                //    }
                //}
                var yearErr = dtExcelData.AsEnumerable().Where(a => !(Regex.IsMatch(a["YEAR"].ToString().Trim(), "^[0-9-]+$") || a["YEAR"].ToString().Trim().Equals(""))).ToList();
                if (yearErr.Count() > 0)
                {
                    strErrorMsg = "YEAR field contains invalid data. Only numerics 1 to 9 and hyphen(-) allowed.";
                    return false;
                }
               
                if (dtExcelData.Columns["FROM DATE"].DataType.FullName != "System.DateTime")
                {
                    DataRow[] IsExist = dtExcelData.Select("[FROM DATE] is not null");
                    if (IsExist.Count() > 0)
                    {
                        strErrorMsg = "FROM DATE field is of type " + dtExcelData.Columns["FROM DATE"].DataType.Name + ". It must be Date.";
                        return false;
                    }
                }
                if (dtExcelData.Columns["TO DATE"].DataType.FullName != "System.DateTime")
                {
                    DataRow[] IsExist = dtExcelData.Select("[TO DATE] is not null");
                    if (IsExist.Count() > 0)
                    {
                        strErrorMsg = "TO DATE field is of type " + dtExcelData.Columns["TO DATE"].DataType.Name + ". It must be Date.";
                        return false;
                    }
                }
                if (dtExcelData.Columns["FILE TYPE"].DataType.FullName != "System.String")
                {
                    strErrorMsg = "FILE TYPE  field is of type " + dtExcelData.Columns["FILE TYPE"].DataType.Name + ". It must be TEXT.";
                    return false;
                }
                if (dtExcelData.Columns["FROM NO"].DataType.FullName != "System.String")
                {
                    strErrorMsg = "FROM NO field is of type " + dtExcelData.Columns["FROM NO"].DataType.Name + ". It must be TEXT.";
                    return false;
                }
                if (dtExcelData.Columns["TO NO"].DataType.FullName != "System.String")
                {
                    strErrorMsg = "TO NO field is of type " + dtExcelData.Columns["TO NO"].DataType.Name + ". It must be TEXT.";
                    return false;
                }
                if (dtExcelData.Columns["DESTRUCTION DUE DATE"].DataType.FullName != "System.DateTime")
                {
                    DataRow[] IsExist = dtExcelData.Select("[DESTRUCTION DUE DATE] is not null");
                    if (IsExist.Count() > 0)
                    {
                        strErrorMsg = "DESTRUCTION DUE DATE field is of type " + dtExcelData.Columns["DESTRUCTION DUE DATE"].DataType.Name + ". It must be Date.";
                        return false;
                    }
                }
                //if (dtExcelData.Columns["DESTRUCTION DUE DATE"].DataType.FullName != "System.String")
                //{
                //    strErrorMsg = "DESTRUCTION DUE DATE field is of type " + dtExcelData.Columns["DESTRUCTION DUE DATE"].DataType.Name + ". It must be TEXT.";
                //    return false;
                //}
            /******/


            /** copy table to database */
                using (SqlConnection con = new SqlConnection(consString))
                {
                    using (SqlBulkCopy sqlBulkCopy = new SqlBulkCopy(con))
                    {
                        //Set the database table name
                        sqlBulkCopy.DestinationTableName = "dbo.TempData";

                        //[OPTIONAL]: Map the Excel columns with that of the database table
                        sqlBulkCopy.ColumnMappings.Add("CLIENT NAME", "CLIENTNAME");
                        sqlBulkCopy.ColumnMappings.Add("BOX BARCODE", "BOX BARCODE");
                        sqlBulkCopy.ColumnMappings.Add("FILE BARCODE", "FILE BARCODE");
                        sqlBulkCopy.ColumnMappings.Add("LOCATION", "LOCATION");
                        sqlBulkCopy.ColumnMappings.Add("FILE NAME 1", "FILE NAME 1");
                        sqlBulkCopy.ColumnMappings.Add("FILE NAME 2", "FILE NAME 2");
                        sqlBulkCopy.ColumnMappings.Add("DEPT", "DEPT");
                        sqlBulkCopy.ColumnMappings.Add("YEAR", "YEAR");
                        sqlBulkCopy.ColumnMappings.Add("FROM DATE", "FROM DATE");
                        sqlBulkCopy.ColumnMappings.Add("TO DATE", "TO DATE");
                        sqlBulkCopy.ColumnMappings.Add("FILE TYPE", "FILE TYPE");
                        sqlBulkCopy.ColumnMappings.Add("FROM NO", "FROM NO");
                        sqlBulkCopy.ColumnMappings.Add("TO NO", "TO NO");
                        sqlBulkCopy.ColumnMappings.Add("DESTRUCTION DUE DATE", "DESTRUCTION DUE DATE");
                        con.Open();
                        sqlBulkCopy.WriteToServer(dtExcelData);
                        con.Close();
                        //return true;

                    }
                }
                return true;
        }
        catch(Exception ex)
        {
            strErrorMsg = ex.Message;
            return false;
        }
    }
    public bool Validate_TempData()
    {
        try
        {
            using (SqlConnection con = new SqlConnection(consString))
            {
                using (SqlCommand cmd = new SqlCommand("usp_xlImp_ValidateTempData", con))
                {

                    con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlParameter prm = new SqlParameter();

                    prm.ParameterName = "@n_WorkOrderNo";
                    prm.SqlDbType = SqlDbType.Int;
                    prm.Value = ddlWorkorderNumber.SelectedValue;
                    cmd.Parameters.Add(prm);
                    DataTable dt = new DataTable();
                    dt.Load(cmd.ExecuteReader());
                    con.Close();

                    if (dt.Rows.Count > 0)
                    {
                        strErrorMsg = "Please correct the following errors in the Excel sheet and then try again.";
                        grdError.DataSource = dt;
                        grdError.DataBind();
                        return false;
                    }
                    else
                    {
                        return true;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            strErrorMsg = ex.Message;
            return false;
        }

    }
    public bool Check_Department(string ErrorMsg)
    {
        try
        {
            DataSet ds = objPRSMBAL.xlImp_CheckDepartment();
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    string msg = null;
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        msg = msg + row[0].ToString() + ",";
                    }
                    if (msg != null)
                    {
                        msg = msg.Remove(msg.Length - 1);
                        strErrorMsg = "Following Departments do not exist in system:  " + msg;
                        btnAddDepartments.Visible = true;
                        return false;
                    }
                    else
                    {
                        return true;
                    }
                }
                else
                {
                    return true;
                }
            }
            else
            {
                btnAddDepartments.Visible = false;
                return true;
            }
        }
        catch (Exception ex)
        {
            strErrorMsg = ex.Message;
            return false;
        }

    }
    public bool Import_Data(string ErrorMsg)
    {
        try
        {
            using (SqlConnection con2 = new SqlConnection(consString))
            {
                using (SqlCommand cmd2 = new SqlCommand())
                {
                    cmd2.CommandType = CommandType.StoredProcedure;
                    con2.Open();
                    cmd2.Connection = con2;
                    SqlParameter prm = new SqlParameter();

                    prm.ParameterName = "@n_WorkOrderNo";
                    cmd2.CommandText = "usp_InsertClientData";
                    prm.SqlDbType = SqlDbType.Int;
                    prm.Value = ddlWorkorderNumber.SelectedValue;
                    cmd2.Parameters.Add(prm);
                    cmd2.ExecuteNonQuery();
                    con2.Close();
                    return true;
                }
            }
        }
        catch (Exception ex)
        {
            strErrorMsg = ex.Message;
            return false;
        }

    }
    protected void btnAddDepartments_Click(object sender, EventArgs e)
    {
        if (Cache["Department"] != null)
        {
            Cache.Remove("Department");
        }
        
        lblValidationMessage.Visible = false;
        // string consString = ConfigurationManager.ConnectionStrings["PRSMDataBaseConnection"].ConnectionString;    
        DataTable dt1 = new DataTable();
        using (SqlConnection con = new SqlConnection(consString))
        {
            using (SqlCommand cmd = new SqlCommand("usp_xlImp_CheckDepartment", con))
            {
                con.Open();
                dt1.Load(cmd.ExecuteReader());
                con.Close();
                btnAddDepartments.Visible = false;
            }

            using (SqlConnection con1 = new SqlConnection(consString))
            {
                foreach (DataRow row in dt1.Rows)
                {

                    using (SqlCommand cmd1 = new SqlCommand())
                    {
                        cmd1.CommandType = CommandType.StoredProcedure;
                        con1.Open();
                        cmd1.Connection = con1;
                        SqlParameter prm = new SqlParameter();
                        prm.ParameterName = "@departmentcode";
                        cmd1.CommandText = "usp_xlImp_InsertDepartment";
                        prm.SqlDbType = SqlDbType.VarChar;
                        prm.Value = row[0].ToString();
                        cmd1.Parameters.Add(prm);
                        cmd1.ExecuteNonQuery();
                        lblAddDepartmentMessage.Text = "New Department Added Successfully.";
                        con1.Close();
                    }
                }
            }
        }
    }
    protected void ddlWorkorderNumber_SelectedIndexChanged(object sender, EventArgs e)
    {
    }
}