using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AspUtils;
using System.Web.Http;

namespace CopRevenueGov2.Helpers
{
    public class COPAppSettings : AppSettingsManager
    {
        public static string WEBROOT
        {
            get
            {
                return GetKeyValueOf("WEBROOT");
            }
        }

        public static string ENVIRONMENT
        {
            get
            {
                return GetKeyValueOf("ENVIRONMENT");
            }
        }

        public static string DEBUG_PATH
        {
            get
            {
                return GetKeyValueOf("DEBUG_PATH");
            }
        }

        public static string LOG_PATH
        {
            get
            {
                return GetKeyValueOf("LOG_PATH");
            }
        }

        public static string COUPON_PATH
        {
            get
            {
                return GetKeyValueOf("COUPON_PATH");
            }
        }

        public static string EMAIL_PATH
        {
            get
            {
                return GetKeyValueOf("EMAIL_PATH");
            }
        }

        public static string DATE_FORMAT
        {
            get
            {
                return GetKeyValueOf("DATE_FORMAT");
            }
        }
        
    }
}