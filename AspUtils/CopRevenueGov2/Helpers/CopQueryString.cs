using AspUtils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CopRevenueGov2.Helpers
{
    public class CopQueryString:QueryStringManager
    {
        private static string _AddArray( string [] Value, string Key , string Url )
        {
            return AppendQueryStringValue(Value, Key, "|", Url);
        }

        public static string AddSMA(string Value, string Url)
        {
            return AppendQueryStringValue(Value, "SMA", Url);
        }

        public static string AddEMI(string Value, string Url)
        {
            return AppendQueryStringValue(Value, "EMI", Url);
        }

        public static string AddETA(string[] Value, string Url)
        {
            return _AddArray(Value, "ETA", Url);
        }

        public static string AddECHK(string Value, string Url)
        {
            return AppendQueryStringValue(Value, "ECHK", Url);
        }

        public static string AddENA1(string[] Value, string Url)
        {
            return _AddArray(Value, "ENA-1", Url);
        }

        public static string AddENA2(string[] Value, string Url)
        {
            return _AddArray(Value, "ENA-2", Url);
        }

        public static string AddBPT(string Value, string Url)
        {
            return AppendQueryStringValue(Value, "E-BPT", Url);
        }

        public static string AddPAGE1(string Value, string Url)
        {
            return AppendQueryStringValue(Value, "E-PG1", Url);
        }

        public static string AddPAGE2(string Value, string Url)
        {
            return AppendQueryStringValue(Value, "E-EZ-PG2", Url);
        }





        public static string Add_E_LF_BPT(string Value, string Url)
        {
            return AppendQueryStringValue(Value, "E-LF-BPT", Url);
        }

        public static string Add_E_LF_PG1(string Value, string Url)
        {
            return AppendQueryStringValue(Value, "E-LF-PG1", Url);
        }

        public static string Add_E_LF_SCHA(string Value, string Url)
        {
            return AppendQueryStringValue(Value, "E-LF-SCHA", Url);
        }

        public static string Add_E_LF_SCHB(string Value, string Url)
        {
            return AppendQueryStringValue(Value, "E-LF-SCHB", Url);
        }

        public static string Add_E_LF_SCHC1(string Value, string Url)
        {
            return AppendQueryStringValue(Value, "E-LF-SCHC1", Url);
        }

        public static string Add_E_LF_SCHD(string Value, string Url)
        {
            return AppendQueryStringValue(Value, "E-LF-SCHD", Url);
        }

        public static string Add_E_LF_SCHE(string Value, string Url)
        {
            return AppendQueryStringValue(Value, "E-LF-SCHE", Url);
        }


    }
}