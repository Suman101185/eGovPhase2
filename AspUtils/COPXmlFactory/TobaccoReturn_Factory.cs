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
        /// This method is used to create the object of TOBACCORETURN 
        /// </summary>
        /// <returns></returns>
        /// 
        public static RTTIE028.TOBACCORETURN GetTOBACCORETURN()
        {
            RTTIE028.TOBACCORETURN tb = new RTTIE028.TOBACCORETURN();

            //Errorinfo
            tb.ERROR_INFO = new ERROR_INFO();
            tb.ERROR_INFO.Attr_TYPE = "COMPLEX";
            tb.ERROR_INFO.OCCURS = "1";
            tb.ERROR_INFO.LENGTH = "79";
            tb.ERROR_INFO.EXPORT = "N";

            tb.ERROR_INFO.PROGRAM = new XmlNodeEntity();
            tb.ERROR_INFO.PROGRAM = "";
            tb.ERROR_INFO.PROGRAM.Attr_TYPE = "A";
            tb.ERROR_INFO.PROGRAM.LENGTH = "8";

            tb.ERROR_INFO.ERROR = new XmlNodeEntity();
            tb.ERROR_INFO.ERROR = "";
            tb.ERROR_INFO.ERROR.Attr_TYPE = "N";
            tb.ERROR_INFO.ERROR.LENGTH = "7";

            tb.ERROR_INFO.LINE = new XmlNodeEntity();
            tb.ERROR_INFO.LINE = "";
            tb.ERROR_INFO.LINE.Attr_TYPE = "N";
            tb.ERROR_INFO.LINE.LENGTH = "4";

            tb.ERROR_INFO.MESSAGE = new XmlNodeEntity();
            tb.ERROR_INFO.MESSAGE = "";
            tb.ERROR_INFO.MESSAGE.Attr_TYPE = "A";
            tb.ERROR_INFO.MESSAGE.LENGTH = "60";

            //TOBACCO_INFO
            tb.TOBACCO_INFO = new RTTIE028.TOBACCO_INFO();
            tb.TOBACCO_INFO.Attr_TYPE = "COMPLEX";
            tb.TOBACCO_INFO.OCCURS = "1";
            tb.TOBACCO_INFO.LENGTH = "223";
            tb.TOBACCO_INFO.EXPORT = "Y";


            tb.TOBACCO_INFO.ACCOUNT_ID = new XmlNodeEntity();
            tb.TOBACCO_INFO.ACCOUNT_ID = "";
            tb.TOBACCO_INFO.ACCOUNT_ID.Attr_TYPE = "A";
            tb.TOBACCO_INFO.ACCOUNT_ID.LENGTH = "12";

            tb.TOBACCO_INFO.PERIOD = new XmlNodeEntity();
            tb.TOBACCO_INFO.PERIOD = "";
            tb.TOBACCO_INFO.PERIOD.Attr_TYPE = "D";
            tb.TOBACCO_INFO.PERIOD.LENGTH = "8";

            tb.TOBACCO_INFO.VERSION = new XmlNodeEntity();
            tb.TOBACCO_INFO.VERSION = "";
            tb.TOBACCO_INFO.VERSION.Attr_TYPE = "A";
            tb.TOBACCO_INFO.VERSION.LENGTH = "3";

            tb.TOBACCO_INFO.RETURN_STATUS = new XmlNodeEntity();
            tb.TOBACCO_INFO.RETURN_STATUS = "";
            tb.TOBACCO_INFO.RETURN_STATUS.Attr_TYPE = "A";
            tb.TOBACCO_INFO.RETURN_STATUS.LENGTH = "3";

            tb.TOBACCO_INFO.LAST_UPD_DATE = new XmlNodeEntity();
            tb.TOBACCO_INFO.LAST_UPD_DATE = "";
            tb.TOBACCO_INFO.LAST_UPD_DATE.Attr_TYPE = "D";
            tb.TOBACCO_INFO.LAST_UPD_DATE.LENGTH = "8";

            tb.TOBACCO_INFO.USER_ID = new XmlNodeEntity();
            tb.TOBACCO_INFO.USER_ID = "";
            tb.TOBACCO_INFO.USER_ID.Attr_TYPE = "A";
            tb.TOBACCO_INFO.USER_ID.LENGTH = "8";

            tb.TOBACCO_INFO.RECORDING_DATE = new XmlNodeEntity();
            tb.TOBACCO_INFO.RECORDING_DATE = "";
            tb.TOBACCO_INFO.RECORDING_DATE.Attr_TYPE = "D";
            tb.TOBACCO_INFO.RECORDING_DATE.LENGTH = "8";

            tb.TOBACCO_INFO.SEQUENCE = new XmlNodeEntity();
            tb.TOBACCO_INFO.SEQUENCE = "";
            tb.TOBACCO_INFO.SEQUENCE.Attr_TYPE = "A";
            tb.TOBACCO_INFO.SEQUENCE.LENGTH = "5";

            tb.TOBACCO_INFO.ADJUSTMENT_REF_NO = new XmlNodeEntity();
            tb.TOBACCO_INFO.ADJUSTMENT_REF_NO = "";
            tb.TOBACCO_INFO.ADJUSTMENT_REF_NO.Attr_TYPE = "A";
            tb.TOBACCO_INFO.ADJUSTMENT_REF_NO.LENGTH = "10";

            tb.TOBACCO_INFO.RATE_ITEM = new XmlNodeEntity();
            tb.TOBACCO_INFO.RATE_ITEM = "";
            tb.TOBACCO_INFO.RATE_ITEM.Attr_TYPE = "N";
            tb.TOBACCO_INFO.RATE_ITEM.LENGTH = "9";
            tb.TOBACCO_INFO.RATE_ITEM.PERCISION = "6";

            tb.TOBACCO_INFO.RATE_PACK = new XmlNodeEntity();
            tb.TOBACCO_INFO.RATE_PACK = "";
            tb.TOBACCO_INFO.RATE_PACK.Attr_TYPE = "N";
            tb.TOBACCO_INFO.RATE_PACK.LENGTH = "9";
            tb.TOBACCO_INFO.RATE_PACK.PERCISION = "6";

            tb.TOBACCO_INFO.RATE_PAPER = new XmlNodeEntity();
            tb.TOBACCO_INFO.RATE_PAPER = "";
            tb.TOBACCO_INFO.RATE_PAPER.Attr_TYPE = "N";
            tb.TOBACCO_INFO.RATE_PAPER.LENGTH = "9";
            tb.TOBACCO_INFO.RATE_PAPER.PERCISION = "6";

            tb.TOBACCO_INFO.PREPARER_NAME = new XmlNodeEntity();
            tb.TOBACCO_INFO.PREPARER_NAME = "";
            tb.TOBACCO_INFO.PREPARER_NAME.Attr_TYPE = "A";
            tb.TOBACCO_INFO.PREPARER_NAME.LENGTH = "40";

            tb.TOBACCO_INFO.PREPARER_PHONE = new XmlNodeEntity();
            tb.TOBACCO_INFO.PREPARER_PHONE = "";
            tb.TOBACCO_INFO.PREPARER_PHONE.Attr_TYPE = "P";
            tb.TOBACCO_INFO.PREPARER_PHONE.LENGTH = "10";

            tb.TOBACCO_INFO.PREPARER_PHONE_EXT = new XmlNodeEntity();
            tb.TOBACCO_INFO.PREPARER_PHONE_EXT = "";
            tb.TOBACCO_INFO.PREPARER_PHONE_EXT.Attr_TYPE = "A";
            tb.TOBACCO_INFO.PREPARER_PHONE_EXT.LENGTH = "5";

            tb.TOBACCO_INFO.PREPARER_IP_ADDRESS = new XmlNodeEntity();
            tb.TOBACCO_INFO.PREPARER_IP_ADDRESS = "";
            tb.TOBACCO_INFO.PREPARER_IP_ADDRESS.Attr_TYPE = "A";
            tb.TOBACCO_INFO.PREPARER_IP_ADDRESS.LENGTH = "15";

            tb.TOBACCO_INFO.PREPARER_EMAIL_ADDRESS = new XmlNodeEntity();
            tb.TOBACCO_INFO.PREPARER_EMAIL_ADDRESS = "";
            tb.TOBACCO_INFO.PREPARER_EMAIL_ADDRESS.Attr_TYPE = "A";
            tb.TOBACCO_INFO.PREPARER_EMAIL_ADDRESS.LENGTH = "60";

            tb.TOBACCO_INFO.PREPARER_WHO = new XmlNodeEntity();
            tb.TOBACCO_INFO.PREPARER_WHO = "";
            tb.TOBACCO_INFO.PREPARER_WHO.Attr_TYPE = "A";
            tb.TOBACCO_INFO.PREPARER_WHO.LENGTH = "1";

            //AMT_INFO
            tb.AMT_INFO = new RTTIE028.AMT_INFO();
            tb.AMT_INFO.Attr_TYPE = "COMPLEX";
            tb.AMT_INFO.OCCURS = "1";
            tb.AMT_INFO.LENGTH = "285";
            tb.AMT_INFO.EXPORT = "Y";


            tb.AMT_INFO.ITEM_TOTAL = new XmlNodeEntity();
            tb.AMT_INFO.ITEM_TOTAL = "";
            tb.AMT_INFO.ITEM_TOTAL.Attr_TYPE = "A";
            tb.AMT_INFO.ITEM_TOTAL.LENGTH = "12";

            tb.AMT_INFO.ITEM_NOT_PHILA = new XmlNodeEntity();
            tb.AMT_INFO.ITEM_NOT_PHILA = "";
            tb.AMT_INFO.ITEM_NOT_PHILA.Attr_TYPE = "N";
            tb.AMT_INFO.ITEM_NOT_PHILA.LENGTH = "15";

            tb.AMT_INFO.ITEM_PHILA = new XmlNodeEntity();
            tb.AMT_INFO.ITEM_PHILA = "";
            tb.AMT_INFO.ITEM_PHILA.Attr_TYPE = "N";
            tb.AMT_INFO.ITEM_PHILA.LENGTH = "15";

            tb.AMT_INFO.ITEM_TAX_DUE = new XmlNodeEntity();
            tb.AMT_INFO.ITEM_TAX_DUE = "";
            tb.AMT_INFO.ITEM_TAX_DUE.Attr_TYPE = "C";
            tb.AMT_INFO.ITEM_TAX_DUE.LENGTH = "15";

            tb.AMT_INFO.PACK_TOTAL = new XmlNodeEntity();
            tb.AMT_INFO.PACK_TOTAL = "";
            tb.AMT_INFO.PACK_TOTAL.Attr_TYPE = "A";
            tb.AMT_INFO.PACK_TOTAL.LENGTH = "15";

            tb.AMT_INFO.PACK_NOT_PHILA = new XmlNodeEntity();
            tb.AMT_INFO.PACK_NOT_PHILA = "";
            tb.AMT_INFO.PACK_NOT_PHILA.Attr_TYPE = "N";
            tb.AMT_INFO.PACK_NOT_PHILA.LENGTH = "15";

            tb.AMT_INFO.PACK_PHILA = new XmlNodeEntity();
            tb.AMT_INFO.PACK_PHILA = "";
            tb.AMT_INFO.PACK_PHILA.Attr_TYPE = "N";
            tb.AMT_INFO.PACK_PHILA.LENGTH = "15";

            tb.AMT_INFO.PACK_TAX_DUE = new XmlNodeEntity();
            tb.AMT_INFO.PACK_TAX_DUE = "";
            tb.AMT_INFO.PACK_TAX_DUE.Attr_TYPE = "C";
            tb.AMT_INFO.PACK_TAX_DUE.LENGTH = "15";

            tb.AMT_INFO.PAPER_TOTAL = new XmlNodeEntity();
            tb.AMT_INFO.PAPER_TOTAL = "";
            tb.AMT_INFO.PAPER_TOTAL.Attr_TYPE = "N";
            tb.AMT_INFO.PAPER_TOTAL.LENGTH = "15";

            tb.AMT_INFO.PAPER_NOT_PHILA = new XmlNodeEntity();
            tb.AMT_INFO.PAPER_NOT_PHILA = "";
            tb.AMT_INFO.PAPER_NOT_PHILA.Attr_TYPE = "N";
            tb.AMT_INFO.PAPER_NOT_PHILA.LENGTH = "15";

            tb.AMT_INFO.PAPER_PHILA = new XmlNodeEntity();
            tb.AMT_INFO.PAPER_PHILA = "";
            tb.AMT_INFO.PAPER_PHILA.Attr_TYPE = "N";
            tb.AMT_INFO.PAPER_PHILA.LENGTH = "15";

            tb.AMT_INFO.PAPER_TAX_DUE = new XmlNodeEntity();
            tb.AMT_INFO.PAPER_TAX_DUE = "";
            tb.AMT_INFO.PAPER_TAX_DUE.Attr_TYPE = "C";
            tb.AMT_INFO.PAPER_TAX_DUE.LENGTH = "15";

            tb.AMT_INFO.TOTAL_TAX_DUE = new XmlNodeEntity();
            tb.AMT_INFO.TOTAL_TAX_DUE = "";
            tb.AMT_INFO.TOTAL_TAX_DUE.Attr_TYPE = "C";
            tb.AMT_INFO.TOTAL_TAX_DUE.LENGTH = "15";

            tb.AMT_INFO.CREDITS = new XmlNodeEntity();
            tb.AMT_INFO.CREDITS = "";
            tb.AMT_INFO.CREDITS.Attr_TYPE = "C";
            tb.AMT_INFO.CREDITS.LENGTH = "15";

            tb.AMT_INFO.NET_TAX_DUE = new XmlNodeEntity();
            tb.AMT_INFO.NET_TAX_DUE = "";
            tb.AMT_INFO.NET_TAX_DUE.Attr_TYPE = "C";
            tb.AMT_INFO.NET_TAX_DUE.LENGTH = "15";

            tb.AMT_INFO.INTEREST_PENALTY = new XmlNodeEntity();
            tb.AMT_INFO.INTEREST_PENALTY = "";
            tb.AMT_INFO.INTEREST_PENALTY.Attr_TYPE = "C";
            tb.AMT_INFO.INTEREST_PENALTY.LENGTH = "15";

            tb.AMT_INFO.TOTAL_AMOUNT_DUE = new XmlNodeEntity();
            tb.AMT_INFO.TOTAL_AMOUNT_DUE = "";
            tb.AMT_INFO.TOTAL_AMOUNT_DUE.Attr_TYPE = "C";
            tb.AMT_INFO.TOTAL_AMOUNT_DUE.LENGTH = "15";

            tb.AMT_INFO.REFUND = new XmlNodeEntity();
            tb.AMT_INFO.REFUND = "";
            tb.AMT_INFO.REFUND.Attr_TYPE = "C";
            tb.AMT_INFO.REFUND.LENGTH = "15";

            tb.AMT_INFO.ROLL_FORWARD = new XmlNodeEntity();
            tb.AMT_INFO.ROLL_FORWARD = "";
            tb.AMT_INFO.ROLL_FORWARD.Attr_TYPE = "C";
            tb.AMT_INFO.ROLL_FORWARD.LENGTH = "15";

            //HEADER_INFO
            tb.HEADER_INFO = new HEADER_INFO();
            tb.HEADER_INFO.ENVIRONMENT = "";

            //DEBUG
            tb.DEBUG = new DEBUG();

            return tb;
        }
    }
}