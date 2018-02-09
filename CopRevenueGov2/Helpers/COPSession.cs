using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AspUtils;
using System.Web.Http;

namespace CopRevenueGov2.Helpers
{
    public class COPSession:SessionManager
    {
        public static string SERVERIP
        {
            set
            {
                Set(value, "SERVERIP");
            }
            get
            {
                return GetString("SERVERIP");
            }
        }
        public static string APPPATH
        {
            set
            {
                Set(value, "APPPATH");
            }
            get
            {
                return GetString("APPPATH");
            }
        }

        public static string TITLE
        {
            set
            {
                Set(value, "TITLE");
            }
            get
            {
                return GetString("TITLE");
            }
        }
        public static bool DEBUG
        {
            set
            {
                Set(value, "DEBUG");
            }
            get
            {
                return GetBool("DEBUG");
            }
        }

        public static string EMAIL_PATH
        {
            set
            {
                Set(value, "EMAIL_PATH");
            }
            get
            {
                return GetString("EMAIL_PATH");
            }
        }
        public static string EMAIL_CITY_SEAL
        {
            set
            {
                Set(value, "EMAIL_CITY_SEAL");
            }
            get
            {
                return GetString("EMAIL_CITY_SEAL");
            }
        }
        public static string EMAIL_SPACER
        {
            set
            {
                Set(value, "EMAIL_SPACER");
            }
            get
            {
                return GetString("EMAIL_SPACER");
            }
        }

        public static string EMAIL_IP_ADDR
        {
            set
            {
                Set(value, "EMAIL_IP_ADDR");
            }
            get
            {
                return GetString("EMAIL_IP_ADDR");
            }
        }
        public static string EMAIL_COMMENTS_TO
        {
            set
            {
                Set(value, "EMAIL_COMMENTS_TO");
            }
            get
            {
                return GetString("EMAIL_COMMENTS_TO");
            }
        }
        public static string EMAIL_LOG_TO
        {
            set
            {
                Set(value, "EMAIL_LOG_TO");
            }
            get
            {
                return GetString("EMAIL_LOG_TO");
            }
        }
        public static string EMAIL_ERROR_TO
        {
            set
            {
                Set(value, "EMAIL_ERROR_TO");
            }
            get
            {
                return GetString("EMAIL_ERROR_TO");
            }
        }
        public static string EMAIL_FROM
        {
            set
            {
                Set(value, "EMAIL_FROM");
            }
            get
            {
                return GetString("EMAIL_FROM");
            }
        }
        public static string EMAIL_COMMENTS_CC
        {
            set
            {
                Set(value, "EMAIL_COMMENTS_CC");
            }
            get
            {
                return GetString("EMAIL_COMMENTS_CC");
            }
        }
        public static string EMAIL_ERROR_CC
        {
            set
            {
                Set(value, "EMAIL_ERROR_CC");
            }
            get
            {
                return GetString("EMAIL_ERROR_CC");
            }
        }
        public static string EMAIL_LOG_CC
        {
            set
            {
                Set(value, "EMAIL_LOG_CC");
            }
            get
            {
                return GetString("EMAIL_LOG_CC");
            }
        }
                
        public static string CC_SiteName
        {
            set
            {
                Set(value, "CC_SiteName");
            }
            get
            {
                return GetString("CC_SiteName");
            }
        }
        public static string CC_Rev_MerchantID
        {
            set
            {
                Set(value, "CC_Rev_MerchantID");
            }
            get
            {
                return GetString("CC_Rev_MerchantID");
            }
        }
        public static string CC_CF_MerchantID
        {
            set
            {
                Set(value, "CC_CF_MerchantID");
            }
            get
            {
                return GetString("CC_CF_MerchantID");
            }
        }
        public static string CC_BPT_SourceCodeIndex
        {
            set
            {
                Set(value, "CC_BPT_SourceCodeIndex");
            }
            get
            {
                return GetString("CC_BPT_SourceCodeIndex");
            }
        }
        public static string CC_BPT_LicenseFee
        {
            set
            {
                Set(value, "CC_BPT_LicenseFee");
            }
            get
            {
                return GetString("CC_BPT_LicenseFee");
            }
        }
        public static string CC_TestCardNumber
        {
            set
            {
                Set(value, "CC_TestCardNumber");
            }
            get
            {
                return GetString("CC_TestCardNumber");
            }
        }
        public static string CC_TestCardExpireDate
        {
            set
            {
                Set(value, "CC_TestCardExpireDate");
            }
            get
            {
                return GetString("CC_TestCardExpireDate");
            }
        }

        public static string CC_BP_Lic_ePay_ID
        {
            set
            {
                Set(value, "CC_BP_Lic_ePay_ID");
            }
            get
            {
                return GetString("CC_BP_Lic_ePay_ID");
            }
        }
        public static string CC_School_ePay_ID
        {
            set
            {
                Set(value, "CC_School_ePay_ID");
            }
            get
            {
                return GetString("CC_School_ePay_ID");
            }
        }
        public static string CC_Wage_ePay_ID
        {
            set
            {
                Set(value, "CC_Wage_ePay_ID");
            }
            get
            {
                return GetString("CC_Wage_ePay_ID");
            }
        }
        public static string CC_NPT_ePay_ID
        {
            set
            {
                Set(value, "CC_NPT_ePay_ID");
            }
            get
            {
                return GetString("CC_NPT_ePay_ID");
            }
        }
        public static string CC_BPT_ePay_ID
        {
            set
            {
                Set(value, "CC_BPT_ePay_ID");
            }
            get
            {
                return GetString("CC_BPT_ePay_ID");
            }
        }
        public static string CC_TOBACCO_ePay_ID
        {
            set
            {
                Set(value, "CC_TOBACCO_ePay_ID");
            }
            get
            {
                return GetString("CC_TOBACCO_ePay_ID");
            }
        }
        public static string CC_UO_ePay_ID
        {
            set
            {
                Set(value, "CC_UO_ePay_ID");
            }
            get
            {
                return GetString("CC_UO_ePay_ID");
            }
        }


        //Added by SumanG for ePayment
        public static string CC_Earnings_ePay_ID
        {
            set
            {
                Set(value, "CC_Earnings_ePay_ID");
            }
            get
            {
                return GetString("CC_Earnings_ePay_ID");
            }
        }
        

        public static string CC_Amusement_ePay_ID
        {
            set
            {
                Set(value, "CC_Amusement_ePay_ID");
            }
            get
            {
                return GetString("CC_Amusement_ePay_ID");
            }
        }

        public static string CC_Parking_ePay_ID
        {
            set
            {
                Set(value, "CC_Parking_ePay_ID");
            }
            get
            {
                return GetString("CC_Parking_ePay_ID");
            }
        }

        public static string CC_Rental_ePay_ID
        {
            set
            {
                Set(value, "CC_Rental_ePay_ID");
            }
            get
            {
                return GetString("CC_Rental_ePay_ID");
            }
        }       

        public static string CC_Liquor_ePay_ID
        {
            set
            {
                Set(value, "CC_Liquor_ePay_ID");
            }
            get
            {
                return GetString("CC_Liquor_ePay_ID");
            }
        }

        public static string CC_Valet_ePay_ID
        {
            set
            {
                Set(value, "CC_Valet_ePay_ID");
            }
            get
            {
                return GetString("CC_Valet_ePay_ID");
            }
        }

        public static string CC_Outdoor_ePay_ID
        {
            set
            {
                Set(value, "CC_Outdoor_ePay_ID");
            }
            get
            {
                return GetString("CC_Outdoor_ePay_ID");
            }
        }
        //End

        public static string CC_DB_ePay_ID
        {
            set
            {
                Set(value, "CC_DB_ePay_ID");
            }
            get
            {
                return GetString("CC_DB_ePay_ID");
            }
        }

        public static string CC_Hotel_ePay_ID
        {
            set
            {
                Set(value, "CC_Hotel_ePay_ID");
            }
            get
            {
                return GetString("CC_Hotel_ePay_ID");
            }
        }
        

        public static string EOLFORMXML
        {
            set
            {
                Set(value, "EOLFORMXML");
            }
            get
            {
                return GetString("EOLFORMXML");
            }
        }
        public static string WsAddress
        {
            set
            {
                Set(value, "WsAddress");
            }
            get
            {
                return GetString("WsAddress");
            }
        }
        public static string SagAddress
        {
            set
            {
                Set(value, "SagAddress");
            }
            get
            {
                return GetString("SagAddress");
            }
        }
        
        public static string ENVIRONMENT
        {
            set
            {
                Set(value, "ENVIRONMENT");
            }
            get
            {
                return GetString("ENVIRONMENT");
            }
        }
        public static string UserID
        {
            set
            {
                Set(value, "UserID");
            }
            get
            {
                return GetString("UserID");
            }
        }





 
    }
}