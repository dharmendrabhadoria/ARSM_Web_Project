using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Security.Cryptography;
using System.IO;

namespace Utility
{
    public class EncryptDecrypt
    {
        static string encryptKey = "aXb2uy4z";
        public static string EncryptString(string inputString)
        {

            inputString = ReverseArray(inputString);
            MemoryStream memStream = null;
            try
            {
                byte[] key = { };
                byte[] IV = { 12, 21, 43, 17, 57, 35, 67, 27 };
                key = Encoding.UTF8.GetBytes(encryptKey);
                byte[] byteInput = Encoding.UTF8.GetBytes(inputString);
                using (DESCryptoServiceProvider provider = new DESCryptoServiceProvider())
                {
                    memStream = new MemoryStream();
                    ICryptoTransform transform = provider.CreateEncryptor(key, IV);
                    CryptoStream cryptoStream = new CryptoStream(memStream, transform, CryptoStreamMode.Write);
                    cryptoStream.Write(byteInput, 0, byteInput.Length);
                    cryptoStream.FlushFinalBlock();
                }
            }
            catch (Exception ex)
            {
                ErrorHandler.WriteLog(ex);
                return string.Empty;
            }
            return Convert.ToBase64String(memStream.ToArray());
        }

        public static string DecryptString(string inputString)
        {
            MemoryStream memStream = null;
            try
            {
                byte[] key = { };
                byte[] IV = { 12, 21, 43, 17, 57, 35, 67, 27 };
                key = Encoding.UTF8.GetBytes(encryptKey);
                byte[] byteInput = new byte[inputString.Length];
                byteInput = Convert.FromBase64String(inputString);
                DESCryptoServiceProvider provider = new DESCryptoServiceProvider();
                memStream = new MemoryStream();
                ICryptoTransform transform = provider.CreateDecryptor(key, IV);
                CryptoStream cryptoStream = new CryptoStream(memStream, transform, CryptoStreamMode.Write);
                cryptoStream.Write(byteInput, 0, byteInput.Length);
                cryptoStream.FlushFinalBlock();
            }
            catch (Exception ex)
            {
                ErrorHandler.WriteLog(ex);
                return string.Empty;
            }

            Encoding encoding1 = Encoding.UTF8;
            return ReverseArray(encoding1.GetString(memStream.ToArray()));
        }

        public static string ReverseArray(string text)
        {
            char[] array = text.ToCharArray();
            Array.Reverse(array);
            return (new string(array));
        }

    }
}
