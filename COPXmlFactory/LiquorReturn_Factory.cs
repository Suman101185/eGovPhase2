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
        /// This method is used to create the object of LIQUORRETURN 
        /// </summary>
        /// <returns></returns>
        /// 
      
        public static RTTIE029.LIQUORRETURN GetLIQUORRETURN()
        {
            RTTIE029.LIQUORRETURN lq = new RTTIE029.LIQUORRETURN();
      
            //Errorinfo
     
            lq.ERROR_INFO = new ERROR_INFO();
            lq.ERROR_INFO.Attr_TYPE = "COMPLEX";
            lq.ERROR_INFO.OCCURS = "1";
            lq.ERROR_INFO.LENGTH = "79";
            lq.ERROR_INFO.EXPORT = "N";

            lq.ERROR_INFO.PROGRAM = new XmlNodeEntity();
            lq.ERROR_INFO.PROGRAM = "";
            lq.ERROR_INFO.PROGRAM.Attr_TYPE = "A";
            lq.ERROR_INFO.PROGRAM.LENGTH = "8";

            lq.ERROR_INFO.ERROR = new XmlNodeEntity();
            lq.ERROR_INFO.ERROR = "";
            lq.ERROR_INFO.ERROR.Attr_TYPE = "N";
            lq.ERROR_INFO.ERROR.LENGTH = "7";

            lq.ERROR_INFO.LINE = new XmlNodeEntity();
            lq.ERROR_INFO.LINE = "";
            lq.ERROR_INFO.LINE.Attr_TYPE = "N";
            lq.ERROR_INFO.LINE.LENGTH = "4";

            lq.ERROR_INFO.MESSAGE = new XmlNodeEntity();
            lq.ERROR_INFO.MESSAGE = "";
            lq.ERROR_INFO.MESSAGE.Attr_TYPE = "A";
            lq.ERROR_INFO.MESSAGE.LENGTH = "60";

            //LIQUOR_INFO
            lq.LIQUOR_INFO = new RTTIE029.LIQUOR_INFO();
            lq.LIQUOR_INFO.Attr_TYPE = "COMPLEX";
            lq.LIQUOR_INFO.OCCURS = "1";
            lq.LIQUOR_INFO.LENGTH = "205";
            lq.LIQUOR_INFO.EXPORT = "Y";


            lq.LIQUOR_INFO.ACCOUNT_ID = new XmlNodeEntity();
            lq.LIQUOR_INFO.ACCOUNT_ID = "";
            lq.LIQUOR_INFO.ACCOUNT_ID.Attr_TYPE = "A";
            lq.LIQUOR_INFO.ACCOUNT_ID.LENGTH = "12";

            lq.LIQUOR_INFO.PERIOD = new XmlNodeEntity();
            lq.LIQUOR_INFO.PERIOD = "";
            lq.LIQUOR_INFO.PERIOD.Attr_TYPE = "D";
            lq.LIQUOR_INFO.PERIOD.LENGTH = "8";

            lq.LIQUOR_INFO.VERSION = new XmlNodeEntity();
            lq.LIQUOR_INFO.VERSION = "";
            lq.LIQUOR_INFO.VERSION.Attr_TYPE = "A";
            lq.LIQUOR_INFO.VERSION.LENGTH = "3";

            lq.LIQUOR_INFO.RETURN_STATUS = new XmlNodeEntity();
            lq.LIQUOR_INFO.RETURN_STATUS = "";
            lq.LIQUOR_INFO.RETURN_STATUS.Attr_TYPE = "A";
            lq.LIQUOR_INFO.RETURN_STATUS.LENGTH = "3";

            lq.LIQUOR_INFO.LAST_UPD_DATE = new XmlNodeEntity();
            lq.LIQUOR_INFO.LAST_UPD_DATE = "";
            lq.LIQUOR_INFO.LAST_UPD_DATE.Attr_TYPE = "D";
            lq.LIQUOR_INFO.LAST_UPD_DATE.LENGTH = "8";

            lq.LIQUOR_INFO.USER_ID = new XmlNodeEntity();
            lq.LIQUOR_INFO.USER_ID = "";
            lq.LIQUOR_INFO.USER_ID.Attr_TYPE = "A";
            lq.LIQUOR_INFO.USER_ID.LENGTH = "8";

            lq.LIQUOR_INFO.RECORDING_DATE = new XmlNodeEntity();
            lq.LIQUOR_INFO.RECORDING_DATE = "";
            lq.LIQUOR_INFO.RECORDING_DATE.Attr_TYPE = "D";
            lq.LIQUOR_INFO.RECORDING_DATE.LENGTH = "8";


            lq.LIQUOR_INFO.SEQUENCE_NO = new XmlNodeEntity();
            lq.LIQUOR_INFO.SEQUENCE_NO = "";
            lq.LIQUOR_INFO.SEQUENCE_NO.Attr_TYPE = "A";
            lq.LIQUOR_INFO.SEQUENCE_NO.LENGTH = "5";

            lq.LIQUOR_INFO.ADJUSTMENT_REF_NO = new XmlNodeEntity();
            lq.LIQUOR_INFO.ADJUSTMENT_REF_NO = "";
            lq.LIQUOR_INFO.ADJUSTMENT_REF_NO.Attr_TYPE = "A";
            lq.LIQUOR_INFO.ADJUSTMENT_REF_NO.LENGTH = "10";

            lq.LIQUOR_INFO.RATE = new XmlNodeEntity();
            lq.LIQUOR_INFO.RATE = "";
            lq.LIQUOR_INFO.RATE.Attr_TYPE = "N";
            lq.LIQUOR_INFO.RATE.LENGTH = "9";
            lq.LIQUOR_INFO.RATE.PERCISION = "6";


            lq.LIQUOR_INFO.PREPARER_NAME = new XmlNodeEntity();
            lq.LIQUOR_INFO.PREPARER_NAME = "";
            lq.LIQUOR_INFO.PREPARER_NAME.Attr_TYPE = "A";
            lq.LIQUOR_INFO.PREPARER_NAME.LENGTH = "40";

            lq.LIQUOR_INFO.PREPARER_PHONE = new XmlNodeEntity();
            lq.LIQUOR_INFO.PREPARER_PHONE = "";
            lq.LIQUOR_INFO.PREPARER_PHONE.Attr_TYPE = "P";
            lq.LIQUOR_INFO.PREPARER_PHONE.LENGTH = "10";

            lq.LIQUOR_INFO.PREPARER_PHONE_EXT = new XmlNodeEntity();
            lq.LIQUOR_INFO.PREPARER_PHONE_EXT = "";
            lq.LIQUOR_INFO.PREPARER_PHONE_EXT.Attr_TYPE = "A";
            lq.LIQUOR_INFO.PREPARER_PHONE_EXT.LENGTH = "5";

            lq.LIQUOR_INFO.PREPARER_IP_ADDRESS = new XmlNodeEntity();
            lq.LIQUOR_INFO.PREPARER_IP_ADDRESS = "";
            lq.LIQUOR_INFO.PREPARER_IP_ADDRESS.Attr_TYPE = "A";
            lq.LIQUOR_INFO.PREPARER_IP_ADDRESS.LENGTH = "15";

            lq.LIQUOR_INFO.PREPARER_EMAIL_ADDRESS = new XmlNodeEntity();
            lq.LIQUOR_INFO.PREPARER_EMAIL_ADDRESS = "";
            lq.LIQUOR_INFO.PREPARER_EMAIL_ADDRESS.Attr_TYPE = "A";
            lq.LIQUOR_INFO.PREPARER_EMAIL_ADDRESS.LENGTH = "60";

            lq.LIQUOR_INFO.PREPARER_WHO = new XmlNodeEntity();
            lq.LIQUOR_INFO.PREPARER_WHO = "";
            lq.LIQUOR_INFO.PREPARER_WHO.Attr_TYPE = "A";
            lq.LIQUOR_INFO.PREPARER_WHO.LENGTH = "1";

            //AMT_INFO
            lq.AMT_INFO = new RTTIE029.AMT_INFO();
            lq.AMT_INFO.Attr_TYPE = "COMPLEX";
            lq.AMT_INFO.OCCURS = "1";
            lq.AMT_INFO.LENGTH = "135";
            lq.AMT_INFO.EXPORT = "Y";


            lq.AMT_INFO.TOTAL_GROSS = new XmlNodeEntity();
            lq.AMT_INFO.TOTAL_GROSS = "";
            lq.AMT_INFO.TOTAL_GROSS.Attr_TYPE = "C";
            lq.AMT_INFO.TOTAL_GROSS.LENGTH = "15";

            lq.AMT_INFO.FOOD_EXCLUSION = new XmlNodeEntity();
            lq.AMT_INFO.FOOD_EXCLUSION = "";
            lq.AMT_INFO.FOOD_EXCLUSION.Attr_TYPE = "C";
            lq.AMT_INFO.FOOD_EXCLUSION.LENGTH = "15";

            lq.AMT_INFO.OTHER_EXCLUSION = new XmlNodeEntity();
            lq.AMT_INFO.OTHER_EXCLUSION = "";
            lq.AMT_INFO.OTHER_EXCLUSION.Attr_TYPE = "C";
            lq.AMT_INFO.OTHER_EXCLUSION.LENGTH = "15";

            lq.AMT_INFO.TOTAL_EXCLUSION = new XmlNodeEntity();
            lq.AMT_INFO.TOTAL_EXCLUSION = "";
            lq.AMT_INFO.TOTAL_EXCLUSION.Attr_TYPE = "C";
            lq.AMT_INFO.TOTAL_EXCLUSION.LENGTH = "15";

            lq.AMT_INFO.TAXABLE = new XmlNodeEntity();
            lq.AMT_INFO.TAXABLE = "";
            lq.AMT_INFO.TAXABLE.Attr_TYPE = "C";
            lq.AMT_INFO.TAXABLE.LENGTH = "15";

            lq.AMT_INFO.TOTAL_TAX = new XmlNodeEntity();
            lq.AMT_INFO.TOTAL_TAX = "";
            lq.AMT_INFO.TOTAL_TAX.Attr_TYPE = "C";
            lq.AMT_INFO.TOTAL_TAX.LENGTH = "15";

            lq.AMT_INFO.TAX_PAID = new XmlNodeEntity();
            lq.AMT_INFO.TAX_PAID = "";
            lq.AMT_INFO.TAX_PAID.Attr_TYPE = "C";
            lq.AMT_INFO.TAX_PAID.LENGTH = "15";

            lq.AMT_INFO.NET_TAX_DUE = new XmlNodeEntity();
            lq.AMT_INFO.NET_TAX_DUE = "";
            lq.AMT_INFO.NET_TAX_DUE.Attr_TYPE = "C";
            lq.AMT_INFO.NET_TAX_DUE.LENGTH = "15";

            lq.AMT_INFO.TAX_OVERPAID = new XmlNodeEntity();
            lq.AMT_INFO.TAX_OVERPAID = "";
            lq.AMT_INFO.TAX_OVERPAID.Attr_TYPE = "C";
            lq.AMT_INFO.TAX_OVERPAID.LENGTH = "15";

          

            //HEADER_INFO
            lq.HEADER_INFO = new HEADER_INFO();
            lq.HEADER_INFO.ENVIRONMENT = "";

            //DEBUG
            lq.DEBUG = new DEBUG();

            return lq;
        }
    }
}
