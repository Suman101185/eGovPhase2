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
        /// This method is used to create the object of SCHOOLRETURN 
        /// </summary>
        /// <returns></returns>
        /// 
        public static RTTIE036.SCHOOLRETURN GetSCHOOLRETURN()
        {
            RTTIE036.SCHOOLRETURN sc = new RTTIE036.SCHOOLRETURN();

            //Errorinfo
            sc.ERROR_INFO = new ERROR_INFO();
            sc.ERROR_INFO.Attr_TYPE = "COMPLEX";
            sc.ERROR_INFO.OCCURS = "1";
            sc.ERROR_INFO.LENGTH = "79";
            sc.ERROR_INFO.EXPORT = "N";

            sc.ERROR_INFO.PROGRAM = new XmlNodeEntity();
            sc.ERROR_INFO.PROGRAM = "";
            sc.ERROR_INFO.PROGRAM.Attr_TYPE = "A";
            sc.ERROR_INFO.PROGRAM.LENGTH = "8";

            sc.ERROR_INFO.ERROR = new XmlNodeEntity();
            sc.ERROR_INFO.ERROR = "";
            sc.ERROR_INFO.ERROR.Attr_TYPE = "N";
            sc.ERROR_INFO.ERROR.LENGTH = "7";

            sc.ERROR_INFO.LINE = new XmlNodeEntity();
            sc.ERROR_INFO.LINE = "";
            sc.ERROR_INFO.LINE.Attr_TYPE = "N";
            sc.ERROR_INFO.LINE.LENGTH = "4";

            sc.ERROR_INFO.MESSAGE = new XmlNodeEntity();
            sc.ERROR_INFO.MESSAGE = "";
            sc.ERROR_INFO.MESSAGE.Attr_TYPE = "A";
            sc.ERROR_INFO.MESSAGE.LENGTH = "60";

            //SCHOOL_INFO
            sc.SCHOOL_INFO = new RTTIE036.SCHOOL_INFO();
            sc.SCHOOL_INFO.Attr_TYPE = "COMPLEX";
            sc.SCHOOL_INFO.OCCURS = "1";
            sc.SCHOOL_INFO.LENGTH = "223";
            sc.SCHOOL_INFO.EXPORT = "Y";


            sc.SCHOOL_INFO.ACCOUNT_ID = new XmlNodeEntity();
            sc.SCHOOL_INFO.ACCOUNT_ID = "";
            sc.SCHOOL_INFO.ACCOUNT_ID.Attr_TYPE = "A";
            sc.SCHOOL_INFO.ACCOUNT_ID.LENGTH = "12";

            sc.SCHOOL_INFO.PERIOD = new XmlNodeEntity();
            sc.SCHOOL_INFO.PERIOD = "";
            sc.SCHOOL_INFO.PERIOD.Attr_TYPE = "D";
            sc.SCHOOL_INFO.PERIOD.LENGTH = "8";

            sc.SCHOOL_INFO.VERSION = new XmlNodeEntity();
            sc.SCHOOL_INFO.VERSION = "";
            sc.SCHOOL_INFO.VERSION.Attr_TYPE = "A";
            sc.SCHOOL_INFO.VERSION.LENGTH = "3";

            sc.SCHOOL_INFO.RETURN_STATUS = new XmlNodeEntity();
            sc.SCHOOL_INFO.RETURN_STATUS = "";
            sc.SCHOOL_INFO.RETURN_STATUS.Attr_TYPE = "A";
            sc.SCHOOL_INFO.RETURN_STATUS.LENGTH = "3";

            sc.SCHOOL_INFO.LAST_UPD_DATE = new XmlNodeEntity();
            sc.SCHOOL_INFO.LAST_UPD_DATE = "";
            sc.SCHOOL_INFO.LAST_UPD_DATE.Attr_TYPE = "D";
            sc.SCHOOL_INFO.LAST_UPD_DATE.LENGTH = "8";


            sc.SCHOOL_INFO.RECORDING_DATE = new XmlNodeEntity();
            sc.SCHOOL_INFO.RECORDING_DATE = "";
            sc.SCHOOL_INFO.RECORDING_DATE.Attr_TYPE = "D";
            sc.SCHOOL_INFO.RECORDING_DATE.LENGTH = "8";

            sc.SCHOOL_INFO.SEQUENCE = new XmlNodeEntity();
            sc.SCHOOL_INFO.SEQUENCE = "";
            sc.SCHOOL_INFO.SEQUENCE.Attr_TYPE = "A";
            sc.SCHOOL_INFO.SEQUENCE.LENGTH = "5";

            sc.SCHOOL_INFO.ADJUSTMENT_REF_NO = new XmlNodeEntity();
            sc.SCHOOL_INFO.ADJUSTMENT_REF_NO = "";
            sc.SCHOOL_INFO.ADJUSTMENT_REF_NO.Attr_TYPE = "A";
            sc.SCHOOL_INFO.ADJUSTMENT_REF_NO.LENGTH = "10";

            sc.SCHOOL_INFO.RATE = new XmlNodeEntity();
            sc.SCHOOL_INFO.RATE = "";
            sc.SCHOOL_INFO.RATE.Attr_TYPE = "N";
            sc.SCHOOL_INFO.RATE.LENGTH = "9";
            sc.SCHOOL_INFO.RATE.PERCISION = "6";


            sc.SCHOOL_INFO.PREPARER_NAME = new XmlNodeEntity();
            sc.SCHOOL_INFO.PREPARER_NAME = "";
            sc.SCHOOL_INFO.PREPARER_NAME.Attr_TYPE = "A";
            sc.SCHOOL_INFO.PREPARER_NAME.LENGTH = "40";

            sc.SCHOOL_INFO.PREPARER_PHONE = new XmlNodeEntity();
            sc.SCHOOL_INFO.PREPARER_PHONE = "";
            sc.SCHOOL_INFO.PREPARER_PHONE.Attr_TYPE = "P";
            sc.SCHOOL_INFO.PREPARER_PHONE.LENGTH = "10";

            sc.SCHOOL_INFO.PREPARER_PHONE_EXT = new XmlNodeEntity();
            sc.SCHOOL_INFO.PREPARER_PHONE_EXT = "";
            sc.SCHOOL_INFO.PREPARER_PHONE_EXT.Attr_TYPE = "A";
            sc.SCHOOL_INFO.PREPARER_PHONE_EXT.LENGTH = "5";

            sc.SCHOOL_INFO.PREPARER_IP_ADDRESS = new XmlNodeEntity();
            sc.SCHOOL_INFO.PREPARER_IP_ADDRESS = "";
            sc.SCHOOL_INFO.PREPARER_IP_ADDRESS.Attr_TYPE = "A";
            sc.SCHOOL_INFO.PREPARER_IP_ADDRESS.LENGTH = "15";

            sc.SCHOOL_INFO.PREPARER_EMAIL_ADDRESS = new XmlNodeEntity();
            sc.SCHOOL_INFO.PREPARER_EMAIL_ADDRESS = "";
            sc.SCHOOL_INFO.PREPARER_EMAIL_ADDRESS.Attr_TYPE = "A";
            sc.SCHOOL_INFO.PREPARER_EMAIL_ADDRESS.LENGTH = "60";

            sc.SCHOOL_INFO.PREPARER_WHO = new XmlNodeEntity();
            sc.SCHOOL_INFO.PREPARER_WHO = "";
            sc.SCHOOL_INFO.PREPARER_WHO.Attr_TYPE = "A";
            sc.SCHOOL_INFO.PREPARER_WHO.LENGTH = "1";

            //AMT_INFO
            sc.AMT_INFO = new RTTIE036.AMT_INFO();
            sc.AMT_INFO.Attr_TYPE = "COMPLEX";
            sc.AMT_INFO.OCCURS = "1";
            sc.AMT_INFO.LENGTH = "285";
            sc.AMT_INFO.EXPORT = "Y";


            sc.AMT_INFO.NET_TAX_DIVIDENDS = new XmlNodeEntity();
            sc.AMT_INFO.NET_TAX_DIVIDENDS = "";
            sc.AMT_INFO.NET_TAX_DIVIDENDS.Attr_TYPE = "C";
            sc.AMT_INFO.NET_TAX_DIVIDENDS.LENGTH = "15";

            sc.AMT_INFO.TAXABLE_INTEREST = new XmlNodeEntity();
            sc.AMT_INFO.TAXABLE_INTEREST = "";
            sc.AMT_INFO.TAXABLE_INTEREST.Attr_TYPE = "C";
            sc.AMT_INFO.TAXABLE_INTEREST.LENGTH = "15";

            sc.AMT_INFO.PARTNERSHIP_INCOME = new XmlNodeEntity();
            sc.AMT_INFO.PARTNERSHIP_INCOME = "";
            sc.AMT_INFO.PARTNERSHIP_INCOME.Attr_TYPE = "C";
            sc.AMT_INFO.PARTNERSHIP_INCOME.LENGTH = "15";

            sc.AMT_INFO.BENEFICIARY_INCOME = new XmlNodeEntity();
            sc.AMT_INFO.BENEFICIARY_INCOME = "";
            sc.AMT_INFO.BENEFICIARY_INCOME.Attr_TYPE = "C";
            sc.AMT_INFO.BENEFICIARY_INCOME.LENGTH = "15";

            sc.AMT_INFO.SHORT_TERM_GAINS = new XmlNodeEntity();
            sc.AMT_INFO.SHORT_TERM_GAINS = "";
            sc.AMT_INFO.SHORT_TERM_GAINS.Attr_TYPE = "C";
            sc.AMT_INFO.SHORT_TERM_GAINS.LENGTH = "15";

            sc.AMT_INFO.NET_RENTAL_INCOME = new XmlNodeEntity();
            sc.AMT_INFO.NET_RENTAL_INCOME = "";
            sc.AMT_INFO.NET_RENTAL_INCOME.Attr_TYPE = "C";
            sc.AMT_INFO.NET_RENTAL_INCOME.LENGTH = "15";

            sc.AMT_INFO.OTHER_TAXABLE_INCOME = new XmlNodeEntity();
            sc.AMT_INFO.OTHER_TAXABLE_INCOME = "";
            sc.AMT_INFO.OTHER_TAXABLE_INCOME.Attr_TYPE = "C";
            sc.AMT_INFO.OTHER_TAXABLE_INCOME.LENGTH = "15";

            sc.AMT_INFO.TOTAL_TAXABLE_INCOME = new XmlNodeEntity();
            sc.AMT_INFO.TOTAL_TAXABLE_INCOME = "";
            sc.AMT_INFO.TOTAL_TAXABLE_INCOME.Attr_TYPE = "C";
            sc.AMT_INFO.TOTAL_TAXABLE_INCOME.LENGTH = "15";

            sc.AMT_INFO.DEDUCTIBLE_EXPENSES = new XmlNodeEntity();
            sc.AMT_INFO.DEDUCTIBLE_EXPENSES = "";
            sc.AMT_INFO.DEDUCTIBLE_EXPENSES.Attr_TYPE = "C";
            sc.AMT_INFO.DEDUCTIBLE_EXPENSES.LENGTH = "15";

            sc.AMT_INFO.NET_TAXABLE_INCOME = new XmlNodeEntity();
            sc.AMT_INFO.NET_TAXABLE_INCOME = "";
            sc.AMT_INFO.NET_TAXABLE_INCOME.Attr_TYPE = "C";
            sc.AMT_INFO.NET_TAXABLE_INCOME.LENGTH = "15";

            sc.AMT_INFO.GROSS_TAX_DUE = new XmlNodeEntity();
            sc.AMT_INFO.GROSS_TAX_DUE = "";
            sc.AMT_INFO.GROSS_TAX_DUE.Attr_TYPE = "C";
            sc.AMT_INFO.GROSS_TAX_DUE.LENGTH = "15";

            sc.AMT_INFO.CREDITS = new XmlNodeEntity();
            sc.AMT_INFO.CREDITS = "";
            sc.AMT_INFO.CREDITS.Attr_TYPE = "C";
            sc.AMT_INFO.CREDITS.LENGTH = "15";


            sc.AMT_INFO.TAX_DUE = new XmlNodeEntity();
            sc.AMT_INFO.TAX_DUE = "";
            sc.AMT_INFO.TAX_DUE.Attr_TYPE = "C";
            sc.AMT_INFO.TAX_DUE.LENGTH = "15";

            sc.AMT_INFO.TAX_REFUND = new XmlNodeEntity();
            sc.AMT_INFO.TAX_REFUND = "";
            sc.AMT_INFO.TAX_REFUND.Attr_TYPE = "C";
            sc.AMT_INFO.TAX_REFUND.LENGTH = "15";

            sc.AMT_INFO.TAX_OVERPAID = new XmlNodeEntity();
            sc.AMT_INFO.TAX_OVERPAID = "";
            sc.AMT_INFO.TAX_OVERPAID.Attr_TYPE = "C";
            sc.AMT_INFO.TAX_OVERPAID.LENGTH = "15";

            sc.AMT_INFO.USER_ID = new XmlNodeEntity();
            sc.AMT_INFO.USER_ID = "";
            sc.AMT_INFO.USER_ID.Attr_TYPE = "C";
            sc.AMT_INFO.USER_ID.LENGTH = "15";


            //HEADER_INFO
            sc.HEADER_INFO = new HEADER_INFO();
            sc.HEADER_INFO.ENVIRONMENT = "";

            //DEBUG
            sc.DEBUG = new DEBUG();

            return sc;
        }
    }
}
