using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AspUtils;
using System.Text;
using CopRevenueGov2.Service;
using System.Net;
using System.IO;
using System.Globalization;

namespace CopRevenueGov2.Helpers
{
    public class VB
    {

        public static readonly string vbcrlf = System.Environment.NewLine;
        public static readonly string vbCrLf = System.Environment.NewLine;

        public static int len(object val)
        {
            return CopMvcUtil.GetString(val).Length;
        }

        public static string Left(object val, int len)
        {
            string x = CopMvcUtil.GetString(val);
            x = x.Substring(0, len);
            return x;
        }

        public static string Right(object val, int len)
        {
            string x = CopMvcUtil.GetString(val);
            x = x.Substring(x.Length - 1 - len, len);
            return x;
        }

        public static string mid(object val, int startIndex, int Length)
        {
            string x = CopMvcUtil.GetString(val);
            if (startIndex < x.Length)
            {
                if (Length < x.Length)
                {
                    x = x.Substring(startIndex-1, Length);
                }
            }
            return x;
        }

        public static string mid(object val, int startIndex)
        {
            string x = CopMvcUtil.GetString(val);
            if (startIndex < x.Length)
            {
                x = x.Substring(startIndex-1);
            }
            return x;
        }

        public static double CDbl(object val)
        {
            return CopMvcUtil.GetDouble(val);
        }

        public static string FormatCurrency(object val, int NumDigitsAfterDecimal)
        {
            decimal varD = decimal.Parse(Math.Round(CopMvcUtil.GetDouble(val), NumDigitsAfterDecimal).ToString());

            //string c = string.Format("{0:c}", varD);

            string c = varD.ToString();

            return c;
        }

        public static string Now()
        {
            return DateTime.Now.ToString();
        }

        public static string space(int repeatcount)
        {
            if (repeatcount > 0)
            {
                StringBuilder sb = new StringBuilder();
                sb.Append(' ', repeatcount);
                return sb.ToString();
            }
            return string.Empty;

        }

        public static string space(string repeatcount)
        {
            int count = 0;
            int.TryParse(repeatcount, out count);
            StringBuilder sb = new StringBuilder();
            sb.Append(' ', count);
            return sb.ToString();

        }

        public static bool IsNumeric(string strVal)
        {

            if (string.IsNullOrEmpty(strVal))
            {
                return false;
            }
            //IF INCOMING VALUE IS POSITIVE CURRENCY THEN THE FORMAT IS  : $1,000.00, FOR(-) IT WILL BE  : ($1,000.00)
            //SO  IF STRING CONTAINS  $,(,), <,>  SIGN THEN IT IS EXPECTED  TO BE A CURRENCY 
            string filtr_val = strVal.Replace("$", "");
            filtr_val = filtr_val.Replace("(", "");
            filtr_val = filtr_val.Replace(")", "");
            filtr_val = filtr_val.Replace("/", "");
            filtr_val = filtr_val.Replace(",", "");

            decimal result = 0;
            if (decimal.TryParse(strVal, out result))
            {
                return true;
            }
            else
            {
                return false;
            }


        }

        public static bool IsDate(string strVal)
        {
            //COP always uses mm/dd/yyyy format.
            try
            {
                DateTime x = DateTime.ParseExact(strVal, COPAppSettings.DATE_FORMAT , CultureInfo.InvariantCulture, DateTimeStyles.None);
                return true;
            }
            catch
            {
                return false;
            }
        }

        public static ICopService CreateObject(string TypeName)
        {
            ICopService obj = ServiceManager.GetObject(TypeName);
            return obj;
        }


        public static bool IsArray(object Value)
        {
            Type t = Value.GetType();
            return t.IsArray;
        }

        public static Single CSng(string value)
        {
            if (string.IsNullOrEmpty(value))
            {
                value = "0";
            }
            Single result = 0;
            Single.TryParse(value, out result);
            return result;
        }

        public static string FormatDate(string strVal)
        {
            string strDate, r;

            if (string.IsNullOrEmpty(strVal))
            {
                r = "";
            }
            else
            {
                r = mid(strVal, 5, 2) + "/" + mid(strVal, 7, 2) + "/" + mid(strVal, 1, 4);
            }
            return r;
        }

        public static int instr(int startIndex, string value, string searchString)
        {
            if (string.IsNullOrEmpty(value) || string.IsNullOrEmpty(searchString))
            {
                return -1;
            }

            return value.IndexOf(searchString, 1);

        }

        public static long Clng(object value)
        {
            string x = CopMvcUtil.GetString(value);
            long val = 0;
            long.TryParse(x, out val);
            return val;
        }

        public static string FormatDateTime(DateTime date, int format)
        {
            string r = string.Empty;

            switch (format)
            {
                case 2:
                    r = date.Date.ToString("m/d/y");
                    break;

                case 4:
                    r = date.Date.ToString("h:m");
                    break;

                default:
                    // case 2
                    r = date.Date.ToString("m/d/y");
                    break;
            }
            return r;

        }
        public static string GetHTTPResponse(string URL)
        {
            String data = string.Empty;
            
            HttpWebRequest request = HttpWebRequest.CreateHttp(URL);
            request.MaximumAutomaticRedirections = 4;
            request.MaximumResponseHeadersLength = 4;
            request.AllowAutoRedirect = true;
            request.KeepAlive = true;
            request.Method = "GET";
            request.Timeout = 2000;
            request.Credentials = CredentialCache.DefaultCredentials;
            
            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
            Stream receiveStream = response.GetResponseStream();
            // Pipes the stream to a higher level stream reader with the required encoding format. 
            StreamReader readStream = new StreamReader(receiveStream, Encoding.Default);

            data = readStream.ReadToEnd();
            response.Close();
            readStream.Close();

            return data;
        }

    }
}