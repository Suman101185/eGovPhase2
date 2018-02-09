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
        /// This method is used to create the object of DelinquentForm 
        /// </summary>
        /// <returns></returns>
        /// 
        public static RTTIE022.DelinquentForm GetDelinquentForm()
        {
            RTTIE022.DelinquentForm fo = new RTTIE022.DelinquentForm();

            //Errorinfo
            fo.ERROR_INFO = new ERROR_INFO();
            fo.ERROR_INFO.Attr_TYPE = "COMPLEX";
            fo.ERROR_INFO.OCCURS = "1";
            fo.ERROR_INFO.LENGTH = "79";
            fo.ERROR_INFO.EXPORT = "N";

            fo.ERROR_INFO.PROGRAM = new XmlNodeEntity();
            fo.ERROR_INFO.PROGRAM = "";
            fo.ERROR_INFO.PROGRAM.Attr_TYPE = "A";
            fo.ERROR_INFO.PROGRAM.LENGTH = "8";

            fo.ERROR_INFO.ERROR = new XmlNodeEntity();
            fo.ERROR_INFO.ERROR = "";
            fo.ERROR_INFO.ERROR.Attr_TYPE = "N";
            fo.ERROR_INFO.ERROR.LENGTH = "7";

            fo.ERROR_INFO.LINE = new XmlNodeEntity();
            fo.ERROR_INFO.LINE = "";
            fo.ERROR_INFO.LINE.Attr_TYPE = "N";
            fo.ERROR_INFO.LINE.LENGTH = "4";

            fo.ERROR_INFO.MESSAGE = new XmlNodeEntity();
            fo.ERROR_INFO.MESSAGE = "";
            fo.ERROR_INFO.MESSAGE.Attr_TYPE = "A";
            fo.ERROR_INFO.MESSAGE.LENGTH = "60";

            //WAGE_INFO
            fo.DEL_INFO = new RTTIE022.DEL_INFO();
            fo.DEL_INFO.Attr_TYPE = "COMPLEX";
            fo.DEL_INFO.OCCURS = "1";
            fo.DEL_INFO.LENGTH = "51";
            fo.DEL_INFO.EXPORT = "Y";

            fo.DEL_INFO.ENTITY_TYPE = new XmlNodeEntity();
            fo.DEL_INFO.ENTITY_TYPE = "";
            fo.DEL_INFO.ENTITY_TYPE.Attr_TYPE = "A";
            fo.DEL_INFO.ENTITY_TYPE.LENGTH = "3";

            fo.DEL_INFO.ENTITY_ID = new XmlNodeEntity();
            fo.DEL_INFO.ENTITY_ID = "";
            fo.DEL_INFO.ENTITY_ID.Attr_TYPE = "A";
            fo.DEL_INFO.ENTITY_ID.LENGTH = "11";

            fo.DEL_INFO.FUNCTION = new XmlNodeEntity();
            fo.DEL_INFO.FUNCTION = "";
            fo.DEL_INFO.FUNCTION.Attr_TYPE = "A";
            fo.DEL_INFO.FUNCTION.LENGTH = "1";

            fo.DEL_INFO.NOTICE_NUM = new XmlNodeEntity();
            fo.DEL_INFO.NOTICE_NUM = "";
            fo.DEL_INFO.NOTICE_NUM.Attr_TYPE = "A";
            fo.DEL_INFO.NOTICE_NUM.LENGTH = "13";

            fo.DEL_INFO.NEXT_ACCOUNT_TYPE = new XmlNodeEntity();
            fo.DEL_INFO.NEXT_ACCOUNT_TYPE = "";
            fo.DEL_INFO.NEXT_ACCOUNT_TYPE.Attr_TYPE = "A";
            fo.DEL_INFO.NEXT_ACCOUNT_TYPE.LENGTH = "3";

            fo.DEL_INFO.NEXT_ACCOUNT_ID = new XmlNodeEntity();
            fo.DEL_INFO.NEXT_ACCOUNT_ID = "";
            fo.DEL_INFO.NEXT_ACCOUNT_ID.Attr_TYPE = "A";
            fo.DEL_INFO.NEXT_ACCOUNT_ID.LENGTH = "12";

            fo.DEL_INFO.NEXT_PERIOD = new XmlNodeEntity();
            fo.DEL_INFO.NEXT_PERIOD = "";
            fo.DEL_INFO.NEXT_PERIOD.Attr_TYPE = "A";
            fo.DEL_INFO.NEXT_PERIOD.LENGTH = "8";

            //DEL_ACCT
            fo.DEL_ACCTs = new List<RTTIE022.DEL_ACCT>();

            fo.DEL_ACCT_DELIMITED = new RTTIE022.DEL_ACCT_DELIMITED();
            //fo.DEL_ACCT_DELIMITED = "";


            fo.DEBUG = new DEBUG();
            //fo.DEBUG = "";

            fo.HEADER_INFO = new HEADER_INFO();
            //fo.HEADER_INFO = "";

            return fo;
        }


        public static RTTIE022.DEL_ACCT GetDelinquent_DEL_ACCT()
        {
            RTTIE022.DEL_ACCT DEL_ACCT = new RTTIE022.DEL_ACCT();

            DEL_ACCT.Attr_TYPE = "COMPLEX";
            DEL_ACCT.OCCURS = "225";
            DEL_ACCT.LENGTH = "130";
            DEL_ACCT.EXPORT = "Y";

            DEL_ACCT.FUNCTION_CODE = new XmlNodeEntity();
            DEL_ACCT.FUNCTION_CODE = "";
            DEL_ACCT.FUNCTION_CODE.Attr_TYPE = "A";
            DEL_ACCT.FUNCTION_CODE.LENGTH = "1";

            DEL_ACCT.ACCOUNT_TYPE = new XmlNodeEntity();
            DEL_ACCT.ACCOUNT_TYPE = "";
            DEL_ACCT.ACCOUNT_TYPE.Attr_TYPE = "A";
            DEL_ACCT.ACCOUNT_TYPE.LENGTH = "3";

            DEL_ACCT.ACCOUNT_ID = new XmlNodeEntity();
            DEL_ACCT.ACCOUNT_ID = "";
            DEL_ACCT.ACCOUNT_ID.Attr_TYPE = "A";
            DEL_ACCT.ACCOUNT_ID.LENGTH = "12";

            DEL_ACCT.PERIOD = new XmlNodeEntity();
            DEL_ACCT.PERIOD = "";
            DEL_ACCT.PERIOD.Attr_TYPE = "A";
            DEL_ACCT.PERIOD.LENGTH = "8";

            DEL_ACCT.PRINCIPAL_DUE = new XmlNodeEntity();
            DEL_ACCT.PRINCIPAL_DUE = "";
            DEL_ACCT.PRINCIPAL_DUE.Attr_TYPE = "C";
            DEL_ACCT.PRINCIPAL_DUE.LENGTH = "13";

            DEL_ACCT.INTEREST_DUE = new XmlNodeEntity();
            DEL_ACCT.INTEREST_DUE = "";
            DEL_ACCT.INTEREST_DUE.Attr_TYPE = "C";
            DEL_ACCT.INTEREST_DUE.LENGTH = "13";

            DEL_ACCT.PENALTY_DUE = new XmlNodeEntity();
            DEL_ACCT.PENALTY_DUE = "";
            DEL_ACCT.PENALTY_DUE.Attr_TYPE = "C";
            DEL_ACCT.PENALTY_DUE.LENGTH = "13";

            DEL_ACCT.OTHER_DUE = new XmlNodeEntity();
            DEL_ACCT.OTHER_DUE = "";
            DEL_ACCT.OTHER_DUE.Attr_TYPE = "C";
            DEL_ACCT.OTHER_DUE.LENGTH = "13";

            DEL_ACCT.BRT_ENTITY = new XmlNodeEntity();
            DEL_ACCT.BRT_ENTITY = "";
            DEL_ACCT.BRT_ENTITY.Attr_TYPE = "A";
            DEL_ACCT.BRT_ENTITY.LENGTH = "11";

            DEL_ACCT.BRT_ADDRESS = new XmlNodeEntity();
            DEL_ACCT.BRT_ADDRESS = "";
            DEL_ACCT.BRT_ADDRESS.Attr_TYPE = "A";
            DEL_ACCT.BRT_ADDRESS.LENGTH = "40";

            DEL_ACCT.FILL = new XmlNodeEntity();
            DEL_ACCT.FILL = "";
            DEL_ACCT.FILL.Attr_TYPE = "A";
            DEL_ACCT.FILL.LENGTH = "3";

            return DEL_ACCT;
        }
    }
}
