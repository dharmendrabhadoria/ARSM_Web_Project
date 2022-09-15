using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.IO;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using System.Security.Cryptography;

namespace Utility
{
    public static class ErrorHandler
    {
        static string sFileName = "";
        //public static string sPath;

        public static void WriteLog(DataSet ds)
        {
            sFileName = HttpContext.Current.Server.MapPath(@"~/ErrorLog") + "\\Error" + DateTime.Now.ToString("dd-MMM-yyyy") + ".txt";

            //sFileName = sPath + @"\ErrorLog" + DateTime.Today.ToString("dd-MM-yyyy") + ".txt";

            if (!File.Exists(sFileName))
            {
                // Create a file to write to.
                FileStream filetowrite = new FileStream(sFileName, FileMode.Create, FileAccess.Write, FileShare.Write);
                filetowrite.Close();
                filetowrite.Dispose();
                using (StreamWriter sw = new StreamWriter(sFileName))
                {
                    sw.WriteLine("------------------Error Number: " + ds.Tables[0].Rows[0][0].ToString() + " ------------------");
                    sw.WriteLine("Procedure Name: " + ds.Tables[0].Rows[0][3].ToString());
                    sw.WriteLine("Line No: " + ds.Tables[0].Rows[0][4].ToString());
                    sw.WriteLine("Error Message: " + ds.Tables[0].Rows[0][5].ToString());
                    sw.WriteLine("Time: " + Convert.ToString(DateTime.Now.ToString()));
                }
            }
            else
            {
                using (FileStream f = new FileStream(sFileName, FileMode.Append, FileAccess.Write, FileShare.Write))
                {

                    using (StreamWriter sw = new StreamWriter(f))
                    {

                        sw.WriteLine("------------------Error Number: " + ds.Tables[0].Rows[0][0].ToString() + " ------------------");
                        sw.WriteLine("Procedure Name: " + ds.Tables[0].Rows[0][3].ToString());
                        sw.WriteLine("Line No: " + ds.Tables[0].Rows[0][4].ToString());
                        sw.WriteLine("Error Message: " + ds.Tables[0].Rows[0][5].ToString());
                        sw.WriteLine("Time: " + Convert.ToString(DateTime.Now.ToString()  ) );
                    }
                }
            }
        }

        public static void WriteLog(Exception ex)
        {
            sFileName = HttpContext.Current.Server.MapPath(@"~/ErrorLog") + "\\Error" + DateTime.Now.ToString("dd-MMM-yyyy") + ".txt";
            if (!File.Exists(sFileName))
            {
                // Create a file to write to.
                FileStream filetowrite = new FileStream(sFileName, FileMode.Create, FileAccess.Write, FileShare.Write);
                filetowrite.Close();
                filetowrite.Dispose();
                using (StreamWriter sw = new StreamWriter(sFileName, true))
                {
                    sw.WriteLine("------------------Error Source: " + ex.Source + " ------------------");
                    sw.WriteLine("Error Message: " + ex.Message);
                    sw.WriteLine("Error StackTrace: " + ex.StackTrace);
                    sw.WriteLine("Time: " + Convert.ToString(DateTime.Now.ToString()));
                }
            }
            else
            {
                using (FileStream f = new FileStream(sFileName, FileMode.Append, FileAccess.Write, FileShare.Write))
                {
                    using (StreamWriter sw = new StreamWriter(f))
                    {
                        sw.WriteLine("------------------Error Source: " + ex.Source + " ------------------");
                        sw.WriteLine("Error Message: " + ex.Message);
                        sw.WriteLine("Error StackTrace: " + ex.StackTrace);
                        sw.WriteLine("Time: " + Convert.ToString(DateTime.Now.ToString()));
                    }
                }
            }
        }

        public static void WriteIPNLog(String Message)
        {
            sFileName = HttpContext.Current.Server.MapPath(@"~/ErrorLog") + "\\IPNLog" + DateTime.Now.ToString("dd-MMM-yyyy") + ".txt";
            if (!File.Exists(sFileName))
            {
                // Create a file to write to.
                FileStream filetowrite = new FileStream(sFileName, FileMode.Create, FileAccess.Write, FileShare.Write);
                filetowrite.Close();
                filetowrite.Dispose();
                using (StreamWriter sw = new StreamWriter(sFileName, true))
                {
                    sw.WriteLine("------------------IPN Handler Steps Logg  ------------------");
                    sw.WriteLine(Message);
                }
            }
            else
            {
                using (FileStream f = new FileStream(sFileName, FileMode.Append, FileAccess.Write, FileShare.Write))
                {
                    using (StreamWriter sw = new StreamWriter(f))
                    {
                        sw.WriteLine("------------------IPN Handler Steps Logg  ------------------");
                        sw.WriteLine(Message);
                    }
                }
            }
        }
    
    }



}
