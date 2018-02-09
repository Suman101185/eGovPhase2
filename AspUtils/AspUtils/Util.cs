using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AspUtils
{
    public abstract class Util
    {

        public static decimal GetDecimal(object value)
        {
            string x = _String(value);
            decimal val = 0;
            decimal.TryParse(x, out val);
            return val;
        }

        public static double GetDouble(object value)
        {
            string x = _String(value);
            double val = 0;
            double.TryParse(x, out val);
            return val;
        }

        public static int GetInt(object value)
        {
            string x = _String(value);
            int val = 0;
            int.TryParse(x, out val);
            return val;
        }

        public static long GetLong(object value)
        {
            string x = _String(value);
            long val = 0;
            long.TryParse(x, out val);
            return val;
        }

        public static bool GetBool(object value)
        {
            if (value == null)
            {
                return false;
            }
            bool result = false;
            bool.TryParse(_String(value), out result);
            return result;
        }

        public static string GetString(object value)
        {
            return _String(value);
        }

        public static string _String(object value)
        {
            try
            {
                //if (value.ToString().Equals("0"))
                //{
                //    return string.Empty;
                //}
                    if (value == null)
                {
                    return string.Empty;
                }
            }
            catch (IndexOutOfRangeException)
            {
                return "";
            }
            catch (NullReferenceException)
            {
                return "";
            }

            return value.ToString();
        }

        public static DateTime GetDate(string Value, string Format)
        {
            try
            {
                DateTime t = DateTime.ParseExact(Value, Format, CultureInfo.InvariantCulture);
                return t;
            }
            catch
            {
                return new DateTime();
            }
            
        }

    }
}
