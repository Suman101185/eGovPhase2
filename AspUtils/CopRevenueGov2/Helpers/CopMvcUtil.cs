using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using System.Xml;
using System.Web.Mvc;
using System.IO;
using System.Text;
using AspUtils;
using System.Net;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;


namespace CopRevenueGov2.Helpers
{

    public class CopMvcUtil : AspUtils.Util
    {

        public string GetString(HttpRequest request)
        {
            CString strmContents = string.Empty;
            using (System.IO.StreamReader reader = new System.IO.StreamReader(request.InputStream))
            {
                while (reader.Peek() >= 0)
                {
                    strmContents += reader.ReadToEnd();
                }
            }
            return strmContents;
        }
        /// <summary>
        /// This method converts digit into currency and returns a string
        /// </summary>
        /// <param name="digit"></param>
        /// <returns></returns>
        public static string ConvDigitToCurrency(string digit)
        {          
            string str = null;
            if(digit.Contains('-'))
            {
                digit = digit.Replace("-", "");
                digit = "-" + digit;
            }
            int i = Util.GetInt(digit);
            double dd = (double)i / 100;
            if (dd < 0)
            {
               str = "($" + String.Format("{0:0,0.00}", Math.Abs(dd)) + ")";
               return str;
            }
            else
            {
                str = "$" + String.Format("{0:0,0.00}", dd);
                return str;
            }
        }
        /// <summary>
        /// This method takes a 15 digit no as parameter and converts it into double and returns it as string
        /// </summary>
        /// <param name="digit"></param>
        /// <returns></returns>
        public static string ConvDigitToDouble(string digit)
        {
            int i = Util.GetInt(digit);
            double dd = (double)i / 100;
            return dd.ToString();

        }
        /// <summary>
        /// This method takes a 9 digit no as parameter and converts it into double and returns it as string
        /// </summary>
        /// <param name="digit"></param>
        /// <returns></returns>
        public static string ConvDigitToDouble9(string digit)
        {
            int i = Util.GetInt(digit);
            double dd = (double)i / 1000000;
            return dd.ToString();

        }
        /// <summary>
        /// This method takes a digit no as parameter and converts it into int and returns it as string
        /// </summary>
        /// <param name="digit"></param>
        /// <returns></returns>
        public static string ConvDigitToInt(string digit)
        {
            int i = Util.GetInt(digit);
      
            return i.ToString();

        }
        /// <summary>
        /// This method takes a currency as parameter and converts it into digit and returns it as string
        /// </summary>
        /// <param name="currency"></param>
        /// <returns></returns>
        public static string ConvCurrencyToDigit(string currency)
        {
            if (string.IsNullOrEmpty(currency))
            {
                return null;
            }

            if (currency.Contains('-'))
            {

                currency = checkitReverseBasicNegetive(currency);
                currency =currency+"-";
                return currency;
            }
            else
            {
                currency = checkitReverseBasic(currency);
                return currency;
            }
            
        }
        /// <summary>
        /// This method takes a currency as string parameter and converts it into 9 digit no and returns it as string
        /// </summary>
        /// <param name="Curency"></param>
        /// <returns></returns>
        public static string ConvCurrencyToDigit9(string Curency)
        {
            if (string.IsNullOrEmpty(Curency))
            {
                return null;
            }

            if (Curency.IndexOf("(") >= 0)
            {
                Curency = Curency.Replace("(", "");
                Curency = Curency.Replace(")", "");
                Curency = checkitReverseBasic9(Curency);
                Curency = "-" + Curency;
                return Curency;
            }
            else
            {
                Curency = checkitReverseBasic9(Curency);
                return Curency;
            }
            
        }
        /// <summary>
        ///  This method takes a double number as string parameter and converts it into 9 digit no and returns it as string
        /// </summary>
        /// <param name="Number"></param>
        /// <returns></returns>
        public static string ConvNumberToDigit9(string Number)
        {
            double d = 0.00;
            string e;
            double.TryParse(Number, out d);
            e = d.ToString();
            //string e = string.Format("{0:0,0.00}", d);
            e = e.Replace(".", "");
            e= e.PadLeft(9, '0');
            return e;

        }
        /// <summary>
        /// This method takes a double number as string parameter and converts it into 7 digit no and returns it as string
        /// </summary>
        /// <param name="Number"></param>
        /// <returns></returns>
        public static string ConvNumberToDigit7(string Number)
        {
            double d = 0.00;
            string e;
            double.TryParse(Number, out d);
            e = d.ToString();
            //string e = string.Format("{0:0,0.00}", d);
            e = e.Replace(".", "");
            e = e.PadLeft(7, '0');
            return e;

        }

        private static string checkitReverseBasic(string e)
        {
            if (string.IsNullOrEmpty(e))
            {
                return null;
            }

            e = e.Replace(".", "");
            e = e.Replace("$", "");
            e = e.Replace(",", "");
            e = e.PadLeft(15, '0');
            return e;
        }
        private static string checkitReverseBasicNegetive(string e)
        {
            if (string.IsNullOrEmpty(e))
            {
                return null;
            }

            e = e.Replace(".", "");
            e = e.Replace("$", "");
            e = e.Replace(",", "");
            e = e.Replace("-", "");
            e = e.PadLeft(14, '0');
            return e;
        }
        private static string checkitReverseBasic9(string e)
        {
            if (string.IsNullOrEmpty(e))
            {
                return null;
            }

            e = e.Replace(".", "");
            e = e.Replace("$", "");
            e = e.Replace(",", "");
            e = e.PadLeft(9, '0');
            return e;
        }
        /// <summary>
        /// This method takes an httpResponse as parameter and returns a string from its content
        /// /// </summary>
        /// <param name="response"></param>
        /// <returns></returns>
        public string GetString(HttpResponse response)
        {
            CString strmContents = string.Empty;
            using (System.IO.StreamReader reader = new System.IO.StreamReader(response.OutputStream))
            {
                while (reader.Peek() >= 0)
                {
                    strmContents += reader.ReadToEnd();
                }
            }

            return strmContents;
        }
        /// <summary>
        /// This method takes an HttpWebResponse as parameter and returns string from its content
        /// </summary>
        /// <param name="response"></param>
        /// <returns></returns>
        public string GetString(HttpWebResponse response)
        {
            CString strmContents = string.Empty;
            using (System.IO.StreamReader reader = new System.IO.StreamReader(response.GetResponseStream()))
            {
                while (reader.Peek() >= 0)
                {
                    strmContents += reader.ReadToEnd();
                }
            }

            return strmContents;
        }
        /// <summary>
        /// This method takes an HttpRequest as parameter and returns XMLstring from its content
        /// </summary>
        /// <param name="Request"></param>
        /// <returns></returns>
        public string GetXMLString(HttpRequest Request)
        {
            return GetString(Request);
        }
        /// <summary>
        /// This method takes an HttpResponse as parameter and returns XMLstring from its content
        /// </summary>
        /// <param name="Response"></param>
        /// <returns></returns>
        public string GetXMLString(HttpResponse Response)
        {
            return GetString(Response);
        }
        /// <summary>
        /// This method takes an HttpWebResponse as parameter and returns XMLstring from its content
        /// </summary>
        /// <param name="Response"></param>
        /// <returns></returns>
        public string GetXMLString(HttpWebResponse Response)
        {
            return GetString(Response);
        }
        /// <summary>
        /// This method takes a path as parameter and returns XMLstring from its content
        /// </summary>
        /// <param name="path"></param>
        /// <returns></returns>
        public string GetXMLString(string path)
        {
            XmlDocument xml = new XmlDocument();
            string xString = string.Empty;
            xml.Load(path);
            xString = xml.OuterXml;
            return xString;
        }
        /// <summary>
        /// This method takes a date of format mm/dd/yyyy and converts it into a decimal value where the date format is yyyymmdd
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static decimal? ConvDateDecimal(object value)
        {
            if (value == null)
            {
                return null;
            }
            string dt = value.ToString();
            if (string.IsNullOrEmpty(dt))
            {
                return null;
            }
            else
            {
                string m = dt.Substring(0, 2);
                string d = dt.Substring(3, 2);
                string y = dt.Substring(6, 4);
                dt = y + m + d;

                return Util.GetDecimal(dt);
            }
        }

        /// <summary>
        /// This method converts any value into decimal
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static decimal? ConvDecimal(object value)
        {
            if (value == null)
            {
                return null;
            }
            string dt = value.ToString();
            if (string.IsNullOrEmpty(dt))
            {
                return null;
            }
            else
            {
                return Util.GetDecimal(dt);
            }
        }

        /// <summary>
        /// This method takes a date of format mm/dd/yyyy and converts it into a string value where the date format is yyyymmdd
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static string ConvDateDecimalString(object value)
        {
            decimal? e = ConvDateDecimal(value);
            if (e.HasValue)
            {
                return e.ToString();
            }
            return null;
        }
        /// <summary>
        /// This method takes path as parameter and returns an html string in it
        /// </summary>
        /// <param name="path"></param>
        /// <returns></returns>
        public string GetHTMLString(string path)
        {
            return GetStringFromFile(path);
        }
        /// <summary>
        /// This method takes path of a text file as parameter and reads the whole file and returns string in it
        /// </summary>
        /// <param name="path"></param>
        /// <returns></returns>
        public static string GetStringFromFile(string path)
        {
            System.IO.FileInfo fi = new System.IO.FileInfo(path);

            string strContents = string.Empty;

            if (System.IO.File.Exists(path))
            {
                using (System.IO.StreamReader sr = System.IO.File.OpenText(path))
                {
                    strContents = sr.ReadToEnd();
                }
            }
            return strContents;
        }
        /// <summary>
        /// This method is used to delete a file
        /// </summary>
        /// <param name="Path"></param>
        /// <returns></returns>
        public bool DeleteFile(string Path)
        {
            try
            {
                FileInfo TheFile = new FileInfo(Path);
                if (TheFile.Exists)
                {
                    File.Delete(Path);
                    return true;
                }
                else
                {
                    return false;

                }
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        /// <summary>
        /// This method is used to create a file
        /// </summary>
        /// <param name="Path"></param>
        /// <returns></returns>
        public bool CreateFile(string Path)
        {
            try
            {
                FileInfo TheFile = new FileInfo(Path);
                if (TheFile.Exists)
                {
                    //do nothing
                    return true;
                }
                else
                {
                    return false;

                }
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        /// <summary>
        /// This method returns session value from session collection
        /// </summary>
        /// <param name="SessionVariableName"></param>
        /// <returns></returns>
        public static string Session(string SessionVariableName)
        {
            return SessionManager.GetString(SessionVariableName);
        }
        /// <summary>
        /// This method returns value from session collection using session key
        /// </summary>
        /// <param name="sessionKeyName"></param>
        /// <returns></returns>
        public static string GetSession(string sessionKeyName)
        {
            if (!string.IsNullOrEmpty(sessionKeyName))
            {
                return SessionManager.GetString(sessionKeyName.Trim());

            }
            else
            {
                return "";
            }

        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="Value"></param>
        /// <returns></returns>
        public static DateTime GetDate(string Value)
        {
            return Util.GetDate(Value, COPAppSettings.DATE_FORMAT);
        }
        /// <summary>
        /// This method takes a date in the format yyyymmdd as decimal and returns the date in the format mm/dd/yyyy as string
        /// </summary>
        /// <param name="x"></param>
        /// <returns></returns>
        public static string ConvDate(decimal Value)
        {
            string x = Util.GetString(Value);
            return ConvDate(x);
        }
        /// <summary>
        /// This method takes a date in the format yyyymmdd as nullable decimal and returns the date in the format mm/dd/yyyy as string
        /// </summary>
        /// <param name="x"></param>
        /// <returns></returns>
        public static string ConvDate(decimal? Value)
        {
            if (Value.HasValue)
            {
                decimal d = Value.Value;
                return ConvDate(d);
            }
            return null;
        }
        public static string ConvDateNew(decimal? Value)
        {
            if (Value.HasValue)
            {
                decimal d = Value.Value;
                return ConvDate(d);
            }
            return string.Empty;
        }
        /// <summary>
        /// This method takes a date in the format yyyymmdd as string and returns the date in the format mm/dd/yyyy as string
        /// </summary>
        /// <param name="x"></param>
        /// <returns></returns>
        public static string ConvDate(string x)
        {
            if (x == null)
            {
                return null;
            }

            if (x.Length == 8)
            {
                string y = x.Substring(0, 4);
                string m = x.Substring(4, 2);
                string d = x.Substring(6, 2);

                string dt = m + "/" + d + "/" + y;
                return dt;
            }
            //return null;//Sangha
            return string.Empty;//Sangha
        }
        /// <summary>
        /// This method is used in case of decimal fields.In case of each decimal field there is a property DecimalalFieldNameIsSpecified.IsSpecified(string value) will return the value of this property.
        /// Eg:AgeIsSpecified=IsSpecified(x);
        ///    Age=x;
        ///    Age is a decimal field
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static bool IsSpecified(string value)
        {
            if (string.IsNullOrEmpty(value))
                return false;
            else
                return true;
        }


        /*
Function FormatCurrency(
   ByVal Expression As Object,
   Optional ByVal NumDigitsAfterDecimal As Integer = -1,
   Optional ByVal IncludeLeadingDigit As TriState = TriState.UseDefault,
   Optional ByVal UseParensForNegativeNumbers As TriState = TriState.UseDefault,
   Optional ByVal GroupDigits As TriState = TriState.UseDefault
) As String
         * 
         * */

    }

    public class CopMvcPDFUtil
    {
        public string PdfFilePath {get;set;}
        public string HtmlFilePath {get;set;}
        public string OptionsString { get; set; }

        public void CallVeryPDF()
        {
            ConvertUsingCOM();
        }


        private void ConvertUsingCOM()
        {
            string _input =  HtmlFilePath;
            string _output = PdfFilePath;
            string _options = OptionsString;
            ConvertUsingITextSharp(_input, _output);
            //eGovUtils.eGovVeryPDF pdf = new eGovUtils.eGovVeryPDF();
            //pdf.CallVeryPDF(ref _input, ref _output, ref _options);
        }

        private void ConvertUsingITextSharp(string _input,string _output)
        {
            //try
            //{
                HtmlToPdf(_input,_output);
            //}
            //catch (Exception ex)
            //{

            //    throw ex;
            //}
        }
        private void HtmlToPdf(string inputpath, string outputpath)
        {

            Document pdfDoc = new Document(PageSize.A4, 10, 10, 10, 10);
            FileStream fs = new FileStream(outputpath, FileMode.Create);

            PdfWriter.GetInstance(pdfDoc, fs);

            pdfDoc.Open();
            string contents;

            using (StreamReader sr = File.OpenText(inputpath))
            {
                contents = sr.ReadToEnd();
                sr.Close();
            }
            System.Collections.Generic.Dictionary<string, object> providers = new System.Collections.Generic.Dictionary<string, object>();
            // iTextSharp.text.html.simpleparser.HTMLWorker.IMG_BASEURL=@"E:\Sanghamitra\Projects\eGov2\Source Codes\CopRevenueGov2";
            providers.Add(HTMLWorker.IMG_BASEURL, @"E:\Sanghamitra\Projects\eGov2\Source Codes\CopRevenueGov2\Content");

            iTextSharp.text.html.simpleparser.HTMLWorker hw =
                         new iTextSharp.text.html.simpleparser.HTMLWorker(pdfDoc);
            hw.SetProviders(providers);
            hw.Parse(new StringReader(contents));

            pdfDoc.Close();

        }
    }

    public class CString
    {
        StringBuilder sb = null;

        public CString(string Text)
        {
            if (sb == null)
            {
                sb = new StringBuilder();
            }
            sb.Append(Text);
        }

        public CString(StringBuilder Text)
        {
            sb = Text;
        }

        public static implicit operator string(CString Text)
        {
            return Text.ToString();
        }

        public static implicit operator CString(StringBuilder Text)
        {
            return new CString(Text);
        }

        public static implicit operator CString(string Text)
        {
            return new CString(Text);
        }

        public static CString operator +(CString sbw, string Text)
        {
            if (sbw.sb == null)
            {
                sbw.sb = new StringBuilder();
            }
            sbw.sb.Append(Text);

            return sbw;
        }

        public static CString operator +(CString sbw, CString Text)
        {
            if (sbw.sb == null)
            {
                sbw.sb = new StringBuilder();
            }
            sbw.sb.Append(Text);

            return sbw;
        }

        public override string ToString()
        {
            return sb.ToString();
        }

    }
}