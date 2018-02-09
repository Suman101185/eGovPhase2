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
        /// This method is used to create the object of UOFORM 
        /// </summary>
        /// <returns></returns>
        /// 
        public static RTTIE035.UOFORM GetUOFORMReturn()
        {
            RTTIE035.UOFORM uo = new RTTIE035.UOFORM();

            //Errorinfo
            uo.ERROR_INFO = new ERROR_INFO();
            uo.ERROR_INFO.Attr_TYPE = "COMPLEX";
            uo.ERROR_INFO.OCCURS = "1";
            uo.ERROR_INFO.LENGTH = "79";
            uo.ERROR_INFO.EXPORT = "N";

            uo.ERROR_INFO.PROGRAM = new XmlNodeEntity();
            uo.ERROR_INFO.PROGRAM = "";
            uo.ERROR_INFO.PROGRAM.Attr_TYPE = "A";
            uo.ERROR_INFO.PROGRAM.LENGTH = "8";

            uo.ERROR_INFO.ERROR = new XmlNodeEntity();
            uo.ERROR_INFO.ERROR = "";
            uo.ERROR_INFO.ERROR.Attr_TYPE = "N";
            uo.ERROR_INFO.ERROR.LENGTH = "7";

            uo.ERROR_INFO.LINE = new XmlNodeEntity();
            uo.ERROR_INFO.LINE = "";
            uo.ERROR_INFO.LINE.Attr_TYPE = "N";
            uo.ERROR_INFO.LINE.LENGTH = "4";

            uo.ERROR_INFO.MESSAGE = new XmlNodeEntity();
            uo.ERROR_INFO.MESSAGE = "";
            uo.ERROR_INFO.MESSAGE.Attr_TYPE = "A";
            uo.ERROR_INFO.MESSAGE.LENGTH = "60";

            //UO_ACCT
            uo.UO_ACCT = new RTTIE035.UO_ACCT();

            uo.UO_ACCT.Attr_TYPE = "COMPLEX";
            uo.UO_ACCT.OCCURS = "1";
            uo.UO_ACCT.EXPORT = "Y";

            uo.UO_ACCT.ACCOUNT_ID = "";
            uo.UO_ACCT.ACCOUNT_ID.Attr_TYPE = "A";
            uo.UO_ACCT.ACCOUNT_ID.LENGTH = "12";

            uo.UO_ACCT.PERIOD = "";
            uo.UO_ACCT.PERIOD.Attr_TYPE = "A";
            uo.UO_ACCT.PERIOD.LENGTH = "8";

            uo.UO_ACCT.VERSION = "";
            uo.UO_ACCT.VERSION.Attr_TYPE = "A";
            uo.UO_ACCT.VERSION.LENGTH = "3";

            uo.UO_ACCT.RETURN_STATUS = "";
            uo.UO_ACCT.RETURN_STATUS.Attr_TYPE = "D";
            uo.UO_ACCT.RETURN_STATUS.LENGTH = "3";

            uo.UO_ACCT.LAST_UPD_DATE = "";
            uo.UO_ACCT.LAST_UPD_DATE.Attr_TYPE = "A";
            uo.UO_ACCT.LAST_UPD_DATE.LENGTH = "8";

            uo.UO_ACCT.USER_ID = "";
            uo.UO_ACCT.USER_ID.Attr_TYPE = "A";
            uo.UO_ACCT.USER_ID.LENGTH = "8";

            uo.UO_ACCT.RECORDING_DATE = "";
            uo.UO_ACCT.RECORDING_DATE.Attr_TYPE = "D";
            uo.UO_ACCT.RECORDING_DATE.LENGTH = "8";

            uo.UO_ACCT.SEQUENCE = "";
            uo.UO_ACCT.SEQUENCE.Attr_TYPE = "A";
            uo.UO_ACCT.SEQUENCE.LENGTH = "5";

            uo.UO_ACCT.ADJUSTMENT_REF_NO = "";
            uo.UO_ACCT.ADJUSTMENT_REF_NO.Attr_TYPE = "A";
            uo.UO_ACCT.ADJUSTMENT_REF_NO.LENGTH = "10";

            uo.UO_ACCT.RATE = "";
            uo.UO_ACCT.RATE.Attr_TYPE = "N";
            uo.UO_ACCT.RATE.LENGTH = "9";

            uo.UO_ACCT.BRT_NUMBER = "";
            uo.UO_ACCT.BRT_NUMBER.Attr_TYPE = "A";
            uo.UO_ACCT.BRT_NUMBER.LENGTH = "9";

            uo.UO_ACCT.LOCATION = "";
            uo.UO_ACCT.LOCATION.Attr_TYPE = "A";
            uo.UO_ACCT.LOCATION.LENGTH = "30";

            uo.UO_ACCT.DUE_DATE = "";
            uo.UO_ACCT.DUE_DATE.Attr_TYPE = "D";
            uo.UO_ACCT.DUE_DATE.LENGTH = "8";

            uo.UO_ACCT.ASSESSED_VALUE = "";
            uo.UO_ACCT.ASSESSED_VALUE.Attr_TYPE = "C";
            uo.UO_ACCT.ASSESSED_VALUE.LENGTH = "15";
            uo.UO_ACCT.ASSESSED_VALUE.PERCISION = "2";

            uo.UO_ACCT.FREQUENCY = "";
            uo.UO_ACCT.FREQUENCY.Attr_TYPE = "A";
            uo.UO_ACCT.FREQUENCY.LENGTH = "1";

            uo.UO_ACCT.PERIOD_CODE = "";
            uo.UO_ACCT.PERIOD_CODE.Attr_TYPE = "A";
            uo.UO_ACCT.PERIOD_CODE.LENGTH = "2";

            uo.UO_ACCT.PERIOD_YY = "";
            uo.UO_ACCT.PERIOD_YY.Attr_TYPE = "A";
            uo.UO_ACCT.PERIOD_YY.LENGTH = "2";

            uo.UO_ACCT.PREPARER_NAME = "";
            uo.UO_ACCT.PREPARER_NAME.Attr_TYPE = "A";
            uo.UO_ACCT.PREPARER_NAME.LENGTH = "40";

            uo.UO_ACCT.PREPARER_PHONE = "";
            uo.UO_ACCT.PREPARER_PHONE.Attr_TYPE = "P";
            uo.UO_ACCT.PREPARER_PHONE.LENGTH = "10";

            uo.UO_ACCT.PREPARER_PHONE_EXT = "";
            uo.UO_ACCT.PREPARER_PHONE_EXT.Attr_TYPE = "A";
            uo.UO_ACCT.PREPARER_PHONE_EXT.LENGTH = "5";

            uo.UO_ACCT.PREPARER_IP_ADDRESS = "";
            uo.UO_ACCT.PREPARER_IP_ADDRESS.Attr_TYPE = "A";
            uo.UO_ACCT.PREPARER_IP_ADDRESS.LENGTH = "15";

            uo.UO_ACCT.PREPARER_EMAIL_ADDRESS = "";
            uo.UO_ACCT.PREPARER_EMAIL_ADDRESS.Attr_TYPE = "A";
            uo.UO_ACCT.PREPARER_EMAIL_ADDRESS.LENGTH = "60";

            uo.UO_ACCT.PREPARER_WHO = "";
            uo.UO_ACCT.PREPARER_WHO.Attr_TYPE = "A";
            uo.UO_ACCT.PREPARER_WHO.LENGTH = "1";

            //UO_AMTS
            uo.UO_AMTS = new RTTIE035.UO_AMTS();

            uo.UO_AMTS.Attr_TYPE = "COMPLEX";
            uo.UO_AMTS.OCCURS = "1";
            uo.UO_AMTS.EXPORT = "Y";

            uo.UO_AMTS.MAX_TAX = "";
            uo.UO_AMTS.MAX_TAX.Attr_TYPE = "A";
            uo.UO_AMTS.MAX_TAX.LENGTH = "12";

            uo.UO_AMTS.VACANCY = "";
            uo.UO_AMTS.VACANCY.Attr_TYPE = "A";
            uo.UO_AMTS.VACANCY.LENGTH = "8";

            uo.UO_AMTS.EXEMPT = "";
            uo.UO_AMTS.EXEMPT.Attr_TYPE = "A";
            uo.UO_AMTS.EXEMPT.LENGTH = "3";

            uo.UO_AMTS.RESIDENTIAL = "";
            uo.UO_AMTS.RESIDENTIAL.Attr_TYPE = "D";
            uo.UO_AMTS.RESIDENTIAL.LENGTH = "3";

            uo.UO_AMTS.DELINQUENT = "";
            uo.UO_AMTS.DELINQUENT.Attr_TYPE = "A";
            uo.UO_AMTS.DELINQUENT.LENGTH = "8";

            uo.UO_AMTS.KOZ_CREDIT = "";
            uo.UO_AMTS.KOZ_CREDIT.Attr_TYPE = "A";
            uo.UO_AMTS.KOZ_CREDIT.LENGTH = "8";

            uo.UO_AMTS.TOTAL_DEDUCTIONS = "";
            uo.UO_AMTS.TOTAL_DEDUCTIONS.Attr_TYPE = "D";
            uo.UO_AMTS.TOTAL_DEDUCTIONS.LENGTH = "8";

            uo.UO_AMTS.PERIOD_TAX = "";
            uo.UO_AMTS.PERIOD_TAX.Attr_TYPE = "A";
            uo.UO_AMTS.PERIOD_TAX.LENGTH = "5";

            uo.UO_AMTS.DISCOUNT = "";
            uo.UO_AMTS.DISCOUNT.Attr_TYPE = "A";
            uo.UO_AMTS.DISCOUNT.LENGTH = "10";

            uo.UO_AMTS.TAX_DUE = "";
            uo.UO_AMTS.TAX_DUE.Attr_TYPE = "N";
            uo.UO_AMTS.TAX_DUE.LENGTH = "9";

            uo.UO_AMTS.INTEREST_PENALTY = "";
            uo.UO_AMTS.INTEREST_PENALTY.Attr_TYPE = "A";
            uo.UO_AMTS.INTEREST_PENALTY.LENGTH = "9";

            uo.UO_AMTS.TOTAL_DUE = "";
            uo.UO_AMTS.TOTAL_DUE.Attr_TYPE = "A";
            uo.UO_AMTS.TOTAL_DUE.LENGTH = "30";

            uo.UO_AMTS.DELINQUENT_TENANT_COUNT = "";
            uo.UO_AMTS.DELINQUENT_TENANT_COUNT.Attr_TYPE = "D";
            uo.UO_AMTS.DELINQUENT_TENANT_COUNT.LENGTH = "8";

            //UO_AMTS
            //uo.UO3_PAGE = new List<RTTIE035.UO3_PAGE>();
            //uo.UO3_PAGE.Add(new RTTIE035.UO3_PAGE());

           
            //HEADER_INFO
            uo.HEADER_INFO = new HEADER_INFO();
            uo.HEADER_INFO.ENVIRONMENT = "";

            //DEBUG
            uo.DEBUG = new DEBUG();

            return uo;
        }


        public static RTTIE035.UO3_PAGE GetUOFORMReturn_UO3_PAGE()
        {
            RTTIE035.UO3_PAGE ua = new RTTIE035.UO3_PAGE();

            ua.Attr_TYPE = "COMPLEX";
            ua.OCCURS = "10";
            ua.LENGTH = "80";
            ua.EXPORT = "Y";

            ua.PROCESS_CODE = "";
            ua.PROCESS_CODE.Attr_TYPE = "A";
            ua.PROCESS_CODE.LENGTH = "2";

            ua.TENANT_NAME = "";
            ua.TENANT_NAME.Attr_TYPE = "A";
            ua.TENANT_NAME.LENGTH = "40";

            ua.TENANT_ID = "";
            ua.TENANT_ID.Attr_TYPE = "A";
            ua.TENANT_ID.LENGTH = "11";

            ua.ACCOUNT_ID = "";
            ua.ACCOUNT_ID.Attr_TYPE = "A";
            ua.ACCOUNT_ID.LENGTH = "12";

            ua.AMOUNT = "";
            ua.AMOUNT.Attr_TYPE = "C";
            ua.AMOUNT.LENGTH = "15";

            return ua;
        }
    }
}
