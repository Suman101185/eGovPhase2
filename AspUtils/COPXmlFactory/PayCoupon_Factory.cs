using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace COPXmlFactory
{
    public partial class RevenueGovXMLFactory : XMLFactory
    {
        /// <summary>
        /// This method is used to create the object of PAYCOUPON 
        /// </summary>
        /// <returns></returns>
        /// 
        public static RTTIE016.PAYCOUPON GetPAYCOUPON()
        {
            RTTIE016.PAYCOUPON tb = new RTTIE016.PAYCOUPON();

            //Errorinfo
            tb.ERROR_INFO = new ERROR_INFO();
            tb.ERROR_INFO.Attr_TYPE = "COMPLEX";
            tb.ERROR_INFO.OCCURS = "1";
            tb.ERROR_INFO.LENGTH = "79";
            tb.ERROR_INFO.EXPORT = "N";

            tb.ERROR_INFO.PROGRAM = new XmlNodeEntity();
            tb.ERROR_INFO.PROGRAM = "";
            tb.ERROR_INFO.PROGRAM.Attr_TYPE = "A";
            tb.ERROR_INFO.PROGRAM.LENGTH = "1";

            tb.ERROR_INFO.ERROR = new XmlNodeEntity();
            tb.ERROR_INFO.ERROR = "";
            tb.ERROR_INFO.ERROR.Attr_TYPE = "N";
            tb.ERROR_INFO.ERROR.LENGTH = "3";

            tb.ERROR_INFO.LINE = new XmlNodeEntity();
            tb.ERROR_INFO.LINE = "";
            tb.ERROR_INFO.LINE.Attr_TYPE = "N";
            tb.ERROR_INFO.LINE.LENGTH = "4";

            tb.ERROR_INFO.MESSAGE = new XmlNodeEntity();
            tb.ERROR_INFO.MESSAGE = "";
            tb.ERROR_INFO.MESSAGE.Attr_TYPE = "A";
            tb.ERROR_INFO.MESSAGE.LENGTH = "60";

            //ENTITY_INFO
            tb.ENTITY_INFO = new RTTIE016.ENTITY_INFO();
            tb.ENTITY_INFO.Attr_TYPE = "COMPLEX";
            tb.ENTITY_INFO.OCCURS = "1";
            tb.ENTITY_INFO.LENGTH = "219";
            tb.ENTITY_INFO.EXPORT = "Y";


            tb.ENTITY_INFO.FUNCTION_CODE = new XmlNodeEntity();
            tb.ENTITY_INFO.FUNCTION_CODE = "";
            tb.ENTITY_INFO.FUNCTION_CODE.Attr_TYPE = "A";
            tb.ENTITY_INFO.FUNCTION_CODE.LENGTH = "1";

            tb.ENTITY_INFO.ENT_TYPE = new XmlNodeEntity();
            tb.ENTITY_INFO.ENT_TYPE = "";
            tb.ENTITY_INFO.ENT_TYPE.Attr_TYPE = "N";
            tb.ENTITY_INFO.ENT_TYPE.LENGTH = "3";

            tb.ENTITY_INFO.ENTITY_ID = new XmlNodeEntity();
            tb.ENTITY_INFO.ENTITY_ID = "";
            tb.ENTITY_INFO.ENTITY_ID.Attr_TYPE = "A";
            tb.ENTITY_INFO.ENTITY_ID.LENGTH = "11";

            tb.ENTITY_INFO.ACCT_ID = new XmlNodeEntity();
            tb.ENTITY_INFO.ACCT_ID = "";
            tb.ENTITY_INFO.ACCT_ID.Attr_TYPE = "A";
            tb.ENTITY_INFO.ACCT_ID.LENGTH = "12";

            tb.ENTITY_INFO.NAME = new XmlNodeEntity();
            tb.ENTITY_INFO.NAME = "";
            tb.ENTITY_INFO.NAME.Attr_TYPE = "A";
            tb.ENTITY_INFO.NAME.LENGTH = "40";

            tb.ENTITY_INFO.ADDRESS1 = new XmlNodeEntity();
            tb.ENTITY_INFO.ADDRESS1 = "";
            tb.ENTITY_INFO.ADDRESS1.Attr_TYPE = "A";
            tb.ENTITY_INFO.ADDRESS1.LENGTH = "40";

            tb.ENTITY_INFO.ADDRESS2 = new XmlNodeEntity();
            tb.ENTITY_INFO.ADDRESS2 = "";
            tb.ENTITY_INFO.ADDRESS2.Attr_TYPE = "A";
            tb.ENTITY_INFO.ADDRESS2.LENGTH = "40";

            tb.ENTITY_INFO.ADDRESS3 = new XmlNodeEntity();
            tb.ENTITY_INFO.ADDRESS3 = "";
            tb.ENTITY_INFO.ADDRESS3.Attr_TYPE = "A";
            tb.ENTITY_INFO.ADDRESS3.LENGTH = "40";

            tb.ENTITY_INFO.CITY = new XmlNodeEntity();
            tb.ENTITY_INFO.CITY = "";
            tb.ENTITY_INFO.CITY.Attr_TYPE = "A";
            tb.ENTITY_INFO.CITY.LENGTH = "20";

            tb.ENTITY_INFO.STATE = new XmlNodeEntity();
            tb.ENTITY_INFO.STATE = "";
            tb.ENTITY_INFO.STATE.Attr_TYPE = "A";
            tb.ENTITY_INFO.STATE.LENGTH = "2";


            tb.ENTITY_INFO.ZIP_CODE = new XmlNodeEntity();
            tb.ENTITY_INFO.ZIP_CODE = "";
            tb.ENTITY_INFO.ZIP_CODE.Attr_TYPE = "A";
            tb.ENTITY_INFO.ZIP_CODE.LENGTH = "10";



            //TAX_ACCT
            //tb.TAX_ACCT = new List<RTTIE016.TAX_ACCT>();
           

            //WAGE_NTL
            tb.WAGE_NTL = new RTTIE016.WAGE_NTL();
            tb.WAGE_NTL.Attr_TYPE = "COMPLEX";
            tb.WAGE_NTL.OCCURS = "1";
            tb.WAGE_NTL.LENGTH = "285";
            tb.WAGE_NTL.EXPORT = "Y";


            tb.WAGE_NTL.ACCOUNT_ID = new XmlNodeEntity();
            tb.WAGE_NTL.ACCOUNT_ID = "";
            tb.WAGE_NTL.ACCOUNT_ID.Attr_TYPE = "A";
            tb.WAGE_NTL.ACCOUNT_ID.LENGTH = "12";

            tb.WAGE_NTL.PERIOD = new XmlNodeEntity();
            tb.WAGE_NTL.PERIOD = "";
            tb.WAGE_NTL.PERIOD.Attr_TYPE = "A";
            tb.WAGE_NTL.PERIOD.LENGTH = "8";

            tb.WAGE_NTL.FREQUENCY_CODE = new XmlNodeEntity();
            tb.WAGE_NTL.FREQUENCY_CODE = "";
            tb.WAGE_NTL.FREQUENCY_CODE.Attr_TYPE = "A";
            tb.WAGE_NTL.FREQUENCY_CODE.LENGTH = "1";

            tb.WAGE_NTL.ADJ_REF_NO = new XmlNodeEntity();
            tb.WAGE_NTL.ADJ_REF_NO = "";
            tb.WAGE_NTL.ADJ_REF_NO.Attr_TYPE = "A";
            tb.WAGE_NTL.ADJ_REF_NO.LENGTH = "10";

            tb.WAGE_NTL.PREPARER_NAME = new XmlNodeEntity();
            tb.WAGE_NTL.PREPARER_NAME = "";
            tb.WAGE_NTL.PREPARER_NAME.Attr_TYPE = "A";
            tb.WAGE_NTL.PREPARER_NAME.LENGTH = "40";

            tb.WAGE_NTL.PREPARER_PHONE = new XmlNodeEntity();
            tb.WAGE_NTL.PREPARER_PHONE = "";
            tb.WAGE_NTL.PREPARER_PHONE.Attr_TYPE = "P";
            tb.WAGE_NTL.PREPARER_PHONE.LENGTH = "10";

            tb.WAGE_NTL.PREPARER_PHONE_EXT = new XmlNodeEntity();
            tb.WAGE_NTL.PREPARER_PHONE_EXT = "";
            tb.WAGE_NTL.PREPARER_PHONE_EXT.Attr_TYPE = "A";
            tb.WAGE_NTL.PREPARER_PHONE_EXT.LENGTH = "5";

            tb.WAGE_NTL.PREPARER_IP_ADDRESS = new XmlNodeEntity();
            tb.WAGE_NTL.PREPARER_IP_ADDRESS = "";
            tb.WAGE_NTL.PREPARER_IP_ADDRESS.Attr_TYPE = "A";
            tb.WAGE_NTL.PREPARER_IP_ADDRESS.LENGTH = "15";

            tb.WAGE_NTL.PREPARER_EMAIL_ADDRESS = new XmlNodeEntity();
            tb.WAGE_NTL.PREPARER_EMAIL_ADDRESS = "";
            tb.WAGE_NTL.PREPARER_EMAIL_ADDRESS.Attr_TYPE = "A";
            tb.WAGE_NTL.PREPARER_EMAIL_ADDRESS.LENGTH = "60";

            tb.WAGE_NTL.PREPARER_WHO = new XmlNodeEntity();
            tb.WAGE_NTL.PREPARER_WHO = "";
            tb.WAGE_NTL.PREPARER_WHO.Attr_TYPE = "A";
            tb.WAGE_NTL.PREPARER_WHO.LENGTH = "1";

            //COUPON_FORM
            tb.COUPON_FORM = new RTTIE016.COUPON_FORM();
            tb.COUPON_FORM.Attr_TYPE = "COMPLEX";
            tb.COUPON_FORM.OCCURS = "1";
            tb.COUPON_FORM.LENGTH = "296";
            tb.COUPON_FORM.EXPORT = "Y";


            tb.COUPON_FORM.CPN_ACCOUNT = new XmlNodeEntity();
            tb.COUPON_FORM.CPN_ACCOUNT = "";
            tb.COUPON_FORM.CPN_ACCOUNT.Attr_TYPE = "A";
            tb.COUPON_FORM.CPN_ACCOUNT.LENGTH = "12";

            tb.COUPON_FORM.CPN_ACCOUNT_TYPE = new XmlNodeEntity();
            tb.COUPON_FORM.CPN_ACCOUNT_TYPE = "";
            tb.COUPON_FORM.CPN_ACCOUNT_TYPE.Attr_TYPE = "A";
            tb.COUPON_FORM.CPN_ACCOUNT_TYPE.LENGTH = "2";

            tb.COUPON_FORM.CPN_NAME = new XmlNodeEntity();
            tb.COUPON_FORM.CPN_NAME = "";
            tb.COUPON_FORM.CPN_NAME.Attr_TYPE = "A";
            tb.COUPON_FORM.CPN_NAME.LENGTH = "40";

            tb.COUPON_FORM.CPN_ADDR = new XmlNodeEntity();
            tb.COUPON_FORM.CPN_ADDR = "";
            tb.COUPON_FORM.CPN_ADDR.Attr_TYPE = "A";
            tb.COUPON_FORM.CPN_ADDR.LENGTH = "40";

            tb.COUPON_FORM.CPN_ADDR2 = new XmlNodeEntity();
            tb.COUPON_FORM.CPN_ADDR2 = "";
            tb.COUPON_FORM.CPN_ADDR2.Attr_TYPE = "A";
            tb.COUPON_FORM.CPN_ADDR2.LENGTH = "40";

            tb.COUPON_FORM.CPN_ADDR3 = new XmlNodeEntity();
            tb.COUPON_FORM.CPN_ADDR3 = "";
            tb.COUPON_FORM.CPN_ADDR3.Attr_TYPE = "A";
            tb.COUPON_FORM.CPN_ADDR3.LENGTH = "40";

            tb.COUPON_FORM.CPN_CITY = new XmlNodeEntity();
            tb.COUPON_FORM.CPN_CITY = "";
            tb.COUPON_FORM.CPN_CITY.Attr_TYPE = "A";
            tb.COUPON_FORM.CPN_CITY.LENGTH = "20";

            tb.COUPON_FORM.CPN_STATE = new XmlNodeEntity();
            tb.COUPON_FORM.CPN_STATE = "";
            tb.COUPON_FORM.CPN_STATE.Attr_TYPE = "A";
            tb.COUPON_FORM.CPN_STATE.LENGTH = "2";

            tb.COUPON_FORM.CPN_ZIP_CODE = new XmlNodeEntity();
            tb.COUPON_FORM.CPN_ZIP_CODE = "";
            tb.COUPON_FORM.CPN_ZIP_CODE.Attr_TYPE = "A";
            tb.COUPON_FORM.CPN_ZIP_CODE.LENGTH = "10";

            tb.COUPON_FORM.CPN_SCAN = new XmlNodeEntity();
            tb.COUPON_FORM.CPN_SCAN = "";
            tb.COUPON_FORM.CPN_SCAN.Attr_TYPE = "A";
            tb.COUPON_FORM.CPN_SCAN.LENGTH = "90";

            tb.COUPON_FORM.CPN_PERIOD = new XmlNodeEntity();
            tb.COUPON_FORM.CPN_PERIOD = "";
            tb.COUPON_FORM.CPN_PERIOD.Attr_TYPE = "A";
            tb.COUPON_FORM.CPN_PERIOD.LENGTH = "2";

            tb.COUPON_FORM.CPN_YEAR = new XmlNodeEntity();
            tb.COUPON_FORM.CPN_YEAR = "";
            tb.COUPON_FORM.CPN_YEAR.Attr_TYPE = "A";
            tb.COUPON_FORM.CPN_YEAR.LENGTH = "4";

            tb.COUPON_FORM.CPN_FORM = new XmlNodeEntity();
            tb.COUPON_FORM.CPN_FORM = "";
            tb.COUPON_FORM.CPN_FORM.Attr_TYPE = "A";
            tb.COUPON_FORM.CPN_FORM.LENGTH = "20";

            return tb;
        }

        public static RTTIE016.TAX_ACCT GetPAYCOUPON_TAX_ACCT()
        {
            RTTIE016.TAX_ACCT b = new RTTIE016.TAX_ACCT();
            b.Attr_TYPE = "COMPLEX";
            b.OCCURS = "1";
            b.LENGTH = "285";
            b.EXPORT = "Y";


            b.FUNC_CODE = new XmlNodeEntity();
            b.FUNC_CODE = "";
            b.FUNC_CODE.Attr_TYPE = "A";
            b.FUNC_CODE.LENGTH = "12";

            b.ACCOUNT = new XmlNodeEntity();
            b.ACCOUNT = "";
            b.ACCOUNT.Attr_TYPE = "N";
            b.ACCOUNT.LENGTH = "15";

            b.ACCOUNT_ID = new XmlNodeEntity();
            b.ACCOUNT_ID = "";
            b.ACCOUNT_ID.Attr_TYPE = "N";
            b.ACCOUNT_ID.LENGTH = "15";

            b.START_DATE = new XmlNodeEntity();
            b.START_DATE = "";
            b.START_DATE.Attr_TYPE = "C";
            b.START_DATE.LENGTH = "15";

            b.END_DATE = new XmlNodeEntity();
            b.END_DATE = "";
            b.END_DATE.Attr_TYPE = "A";
            b.END_DATE.LENGTH = "15";

            b.FREQUENCY_CODE = new XmlNodeEntity();
            b.FREQUENCY_CODE = "";
            b.FREQUENCY_CODE.Attr_TYPE = "N";
            b.FREQUENCY_CODE.LENGTH = "15";

            b.BRT_ACCOUNT = new XmlNodeEntity();
            b.BRT_ACCOUNT = "";
            b.BRT_ACCOUNT.Attr_TYPE = "N";
            b.BRT_ACCOUNT.LENGTH = "15";

            b.BRT_ADDRESS1 = new XmlNodeEntity();
            b.BRT_ADDRESS1 = "";
            b.BRT_ADDRESS1.Attr_TYPE = "C";
            b.BRT_ADDRESS1.LENGTH = "15";

            return b;
        }
    }
}
