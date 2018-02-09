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
        /// This method is used to create the object of UOLIST 
        /// </summary>
        /// <returns></returns>
        /// 
        public static RTTIE034.UOLIST GetUOLISTReturn()
        {
            RTTIE034.UOLIST uo = new RTTIE034.UOLIST();

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

            //uo_INFO
            uo.UO_INFO = new RTTIE034.UO_INFO();
            uo.UO_INFO.Attr_TYPE = "COMPLEX";
            uo.UO_INFO.OCCURS = "1";
            uo.UO_INFO.LENGTH = "23";
            uo.UO_INFO.EXPORT = "Y";

            uo.UO_INFO.ENTITY_ID = new XmlNodeEntity();
            uo.UO_INFO.ENTITY_ID = "";
            uo.UO_INFO.ENTITY_ID.Attr_TYPE = "A";
            uo.UO_INFO.ENTITY_ID.LENGTH = "11";

            uo.UO_INFO.ACCOUNT_ID = new XmlNodeEntity();
            uo.UO_INFO.ACCOUNT_ID = "";
            uo.UO_INFO.ACCOUNT_ID.Attr_TYPE = "A";
            uo.UO_INFO.ACCOUNT_ID.LENGTH = "12";


            //UO_ACCT
            //uo.UO_ACCT = new List<RTTIE034.UO_ACCT>();
            


            //HEADER_INFO
            uo.HEADER_INFO = new HEADER_INFO();
            uo.HEADER_INFO.ENVIRONMENT = "";

            //DEBUG
            uo.DEBUG = new DEBUG();

            return uo;
        }

        public static RTTIE034.UO_ACCT GetUOLISTReturn_UO_ACCT()
        {
            RTTIE034.UO_ACCT ua = new RTTIE034.UO_ACCT();
            ua.Attr_TYPE = "COMPLEX";
            ua.OCCURS = "200";
            ua.LENGTH = "77";
            ua.EXPORT = "Y";

            ua.ACCOUNT_ID = "";
            ua.ACCOUNT_ID.Attr_TYPE = "A";
            ua.ACCOUNT_ID.LENGTH = "12";

            ua.BRT_NUMBER = "";
            ua.BRT_NUMBER.Attr_TYPE = "A";
            ua.BRT_NUMBER.LENGTH = "9";

            ua.LOCATION = "";
            ua.LOCATION.Attr_TYPE = "A";
            ua.LOCATION.LENGTH = "30";

            ua.START_DATE = "";
            ua.START_DATE.Attr_TYPE = "D";
            ua.START_DATE.LENGTH = "8";

            ua.END_DATE = "";
            ua.END_DATE.Attr_TYPE = "D";
            ua.END_DATE.LENGTH = "8";

            ua.FREQ_YEAR0 = "";
            ua.FREQ_YEAR0.Attr_TYPE = "A";
            ua.FREQ_YEAR0.LENGTH = "1";

            ua.FREQ_YEAR1 = "";
            ua.FREQ_YEAR1.Attr_TYPE = "A";
            ua.FREQ_YEAR1.LENGTH = "1";

            ua.FREQ_YEAR2 = "";
            ua.FREQ_YEAR2.Attr_TYPE = "A";
            ua.FREQ_YEAR2.LENGTH = "1";

            ua.FREQ_YEAR3 = "";
            ua.FREQ_YEAR3.Attr_TYPE = "A";
            ua.FREQ_YEAR3.LENGTH = "1";

            ua.FREQ_YEAR4 = "";
            ua.FREQ_YEAR4.Attr_TYPE = "A";
            ua.FREQ_YEAR4.LENGTH = "1";

            ua.FREQ_YEAR5 = "";
            ua.FREQ_YEAR5.Attr_TYPE = "A";
            ua.FREQ_YEAR5.LENGTH = "1";

            ua.FREQ_YEAR6 = "";
            ua.FREQ_YEAR6.Attr_TYPE = "A";
            ua.FREQ_YEAR6.LENGTH = "1";

            ua.FREQ_YEAR7 = "";
            ua.FREQ_YEAR7.Attr_TYPE = "A";
            ua.FREQ_YEAR7.LENGTH = "1";

            ua.FREQ_YEAR8 = "";
            ua.FREQ_YEAR8.Attr_TYPE = "A";
            ua.FREQ_YEAR8.LENGTH = "1";

            ua.FREQ_YEAR9 = "";
            ua.FREQ_YEAR9.Attr_TYPE = "A";
            ua.FREQ_YEAR9.LENGTH = "1";

            return ua;
        }
    }
}
