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
        /// This method is used to create the object of ACCTTEMPLATE 
        /// </summary>
        /// <returns></returns>
        public static RTTIE010.ACCTTEMPLATE GetAcctTemplate()
        {

            RTTIE010.ACCTTEMPLATE p = new RTTIE010.ACCTTEMPLATE();

            //ERROR_INFO
            p.ERROR_INFO = new ERROR_INFO();
            p.ERROR_INFO.Attr_TYPE = "COMPLEX";
            p.ERROR_INFO.LENGTH = "79";
            p.ERROR_INFO.OCCURS = "1";
            p.ERROR_INFO.EXPORT = "N";

            p.ERROR_INFO.PROGRAM = new XmlNodeEntity();
            p.ERROR_INFO.PROGRAM = "";
            p.ERROR_INFO.PROGRAM.Attr_TYPE = "A";
            p.ERROR_INFO.PROGRAM.LENGTH = "8";

            p.ERROR_INFO.ERROR = new XmlNodeEntity();
            p.ERROR_INFO.ERROR = "";
            p.ERROR_INFO.ERROR.Attr_TYPE = "N";
            p.ERROR_INFO.ERROR.LENGTH = "7";

            p.ERROR_INFO.MESSAGE = new XmlNodeEntity();
            p.ERROR_INFO.MESSAGE = "";
            p.ERROR_INFO.MESSAGE.Attr_TYPE = "A";
            p.ERROR_INFO.MESSAGE.LENGTH = "60";

            p.ERROR_INFO.LINE = new XmlNodeEntity();
            p.ERROR_INFO.LINE = "";
            p.ERROR_INFO.LINE.Attr_TYPE = "A";
            p.ERROR_INFO.LINE.LENGTH = "4";



            //ENTITY_INFO
            p.ENTITY_INFO = new RTTIE010.ENTITY_INFO();
            p.ENTITY_INFO.TYPE = "COMPLEX";
            p.ENTITY_INFO.OCCURS = "1";
            p.ENTITY_INFO.LENGTH = "85";
            p.ENTITY_INFO.EXPORT = "Y";

            p.ENTITY_INFO.FUNCTION_CODE = new XmlNodeEntity();
            p.ENTITY_INFO.FUNCTION_CODE = "";
            p.ENTITY_INFO.FUNCTION_CODE.Attr_TYPE = "A";
            p.ENTITY_INFO.FUNCTION_CODE.LENGTH = "1";

            p.ENTITY_INFO.TYPE = new XmlNodeEntity();
            p.ENTITY_INFO.TYPE = "";
            p.ENTITY_INFO.TYPE.Attr_TYPE = "N";
            p.ENTITY_INFO.TYPE.LENGTH = "3";

            p.ENTITY_INFO.ENTITY_ID = new XmlNodeEntity();
            p.ENTITY_INFO.ENTITY_ID = "";
            p.ENTITY_INFO.ENTITY_ID.Attr_TYPE = "A";
            p.ENTITY_INFO.ENTITY_ID.LENGTH = "11";

            p.ENTITY_INFO.ACCOUNT_ID = new XmlNodeEntity();
            p.ENTITY_INFO.ACCOUNT_ID = "";
            p.ENTITY_INFO.ACCOUNT_ID.Attr_TYPE = "A";
            p.ENTITY_INFO.ACCOUNT_ID.LENGTH = "12";

            p.ENTITY_INFO.NAIC_CODE = new XmlNodeEntity();
            p.ENTITY_INFO.NAIC_CODE = "";
            p.ENTITY_INFO.NAIC_CODE.Attr_TYPE = "N";
            p.ENTITY_INFO.NAIC_CODE.LENGTH = "6";

            p.ENTITY_INFO.SIC_CODE = new XmlNodeEntity();
            p.ENTITY_INFO.SIC_CODE = "";
            p.ENTITY_INFO.SIC_CODE.Attr_TYPE = "N";
            p.ENTITY_INFO.SIC_CODE.LENGTH = "5";

            p.ENTITY_INFO.START_DATE = new XmlNodeEntity();
            p.ENTITY_INFO.START_DATE = "";
            p.ENTITY_INFO.START_DATE.Attr_TYPE = "D";
            p.ENTITY_INFO.START_DATE.LENGTH = "8";

            p.ENTITY_INFO.ORGTYPE = new XmlNodeEntity();
            p.ENTITY_INFO.ORGTYPE = "";
            p.ENTITY_INFO.ORGTYPE.Attr_TYPE = "N";
            p.ENTITY_INFO.ORGTYPE.LENGTH = "3";

            p.ENTITY_INFO.ORIGIN = new XmlNodeEntity();
            p.ENTITY_INFO.ORIGIN = "";
            p.ENTITY_INFO.ORIGIN.Attr_TYPE = "A";
            p.ENTITY_INFO.ORIGIN.LENGTH = "1";

            p.ENTITY_INFO.GENDER = new XmlNodeEntity();
            p.ENTITY_INFO.GENDER = "";
            p.ENTITY_INFO.GENDER.Attr_TYPE = "A";
            p.ENTITY_INFO.GENDER.LENGTH = "1";

            p.ENTITY_INFO.OTHER = new XmlNodeEntity();
            p.ENTITY_INFO.OTHER = "";
            p.ENTITY_INFO.OTHER.Attr_TYPE = "A";
            p.ENTITY_INFO.OTHER.LENGTH = "20";

            p.ENTITY_INFO.PIN = new XmlNodeEntity();
            p.ENTITY_INFO.PIN = "";
            p.ENTITY_INFO.PIN.Attr_TYPE = "N";
            p.ENTITY_INFO.PIN.LENGTH = "13";

            p.ENTITY_INFO.FORCEPINCHG = new XmlNodeEntity();
            p.ENTITY_INFO.FORCEPINCHG = "";
            p.ENTITY_INFO.FORCEPINCHG.Attr_TYPE = "A";
            p.ENTITY_INFO.FORCEPINCHG.LENGTH = "1";

            //TAX_ACCT
           // p.TAX_ACCT.Add(GetAcctTemplate_TaxAcct());
            


            //ECHECK
            p.ECHECK = new RTTIE010.ECHECK();
            p.ECHECK.Attr_TYPE = "COMPLEX";
            p.ECHECK.LENGTH = "31";
            p.ECHECK.OCCURS = "1";
            p.ECHECK.EXPORT = "Y";

            p.ECHECK.FUNCTION_CODE = new XmlNodeEntity();
            p.ECHECK.FUNCTION_CODE = "";
            p.ECHECK.FUNCTION_CODE.Attr_TYPE = "A";
            p.ECHECK.FUNCTION_CODE.LENGTH = "1";

            p.ECHECK.ROUTING_NUMBER = new XmlNodeEntity();
            p.ECHECK.ROUTING_NUMBER = "";
            p.ECHECK.ROUTING_NUMBER.Attr_TYPE = "A";
            p.ECHECK.ROUTING_NUMBER.LENGTH = "9";

            p.ECHECK.ACCOUNT_NUMBER = new XmlNodeEntity();
            p.ECHECK.ACCOUNT_NUMBER = "";
            p.ECHECK.ACCOUNT_NUMBER.Attr_TYPE = "A";
            p.ECHECK.ACCOUNT_NUMBER.LENGTH = "20";

            p.ECHECK.ACCOUNT_TYPE = new XmlNodeEntity();
            p.ECHECK.ACCOUNT_TYPE = "";
            p.ECHECK.ACCOUNT_TYPE.Attr_TYPE = "A";
            p.ECHECK.ACCOUNT_TYPE.LENGTH = "1";

            //NAME_ADDRESS
            p.NAME_ADDRESS = new List<RTTIE010.NAME_ADDRESS>();
            foreach (RTTIE010.NAME_ADDRESS b in p.NAME_ADDRESS)
            {

               
            }

            //HEADER_INFO
            p.HEADER_INFO = new HEADER_INFO();
            p.HEADER_INFO.ENVIRONMENT = "";

            //DEBUG
            p.DEBUG = new DEBUG();

            return p;
        }

        public static RTTIE010.TAX_ACCT GetAcctTemplate_TaxAcct()
        {
          RTTIE010.TAX_ACCT b= new RTTIE010.TAX_ACCT();

            b.Attr_TYPE = "COMPLEX";
            b.LENGTH = "48";
            b.OCCURS = "12";
            b.EXPORT = "Y";

            b.FUNCTION_CODE = new XmlNodeEntity();
            b.FUNCTION_CODE = "";
            b.FUNCTION_CODE.Attr_TYPE = "A";
            b.FUNCTION_CODE.LENGTH = "1";

            b.ACCOUNT = new XmlNodeEntity();
            b.ACCOUNT = "";
            b.ACCOUNT.Attr_TYPE = "N";
            b.ACCOUNT.LENGTH = "2";

            b.START_DATE = new XmlNodeEntity();
            b.START_DATE = "";
            b.START_DATE.Attr_TYPE = "D";
            b.START_DATE.LENGTH = "8";

            b.WAGE_MONTHLY_GROSS = new XmlNodeEntity();
            b.WAGE_MONTHLY_GROSS = "";
            b.WAGE_MONTHLY_GROSS.Attr_TYPE = "C";
            b.WAGE_MONTHLY_GROSS.LENGTH = "15";

            b.UOL_BRT = new XmlNodeEntity();
            b.UOL_BRT = "";
            b.UOL_BRT.Attr_TYPE = "A";
            b.UOL_BRT.LENGTH = "11";

            b.PRK_ID = new XmlNodeEntity();
            b.PRK_ID = "";
            b.PRK_ID.Attr_TYPE = "A";
            b.PRK_ID.LENGTH = "11";

            return b;
        }

        public static RTTIE010.NAME_ADDRESS GetAcctTemplate_NAME_ADDRESS()
        {
            RTTIE010.NAME_ADDRESS b = new RTTIE010.NAME_ADDRESS();
            b.Attr_TYPE = "COMPLEX";
            b.LENGTH = "306";
            b.OCCURS = "21";
            b.EXPORT = "Y";

            b.FUNCTION_CODE = new XmlNodeEntity();
            b.FUNCTION_CODE = "";
            b.FUNCTION_CODE.Attr_TYPE = "A";
            b.FUNCTION_CODE.LENGTH = "1";

            b.TYPE = new XmlNodeEntity();
            b.TYPE = "";
            b.TYPE.Attr_TYPE = "N";
            b.TYPE.LENGTH = "3";

            b.ID = new XmlNodeEntity();
            b.ID = "";
            b.ID.Attr_TYPE = "A";
            b.ID.LENGTH = "11";

            b.NAME = new XmlNodeEntity();
            b.NAME = "";
            b.NAME.Attr_TYPE = "A";
            b.NAME.LENGTH = "40";

            b.TRADE_NAME = new XmlNodeEntity();
            b.TRADE_NAME = "";
            b.TRADE_NAME.Attr_TYPE = "A";
            b.TRADE_NAME.LENGTH = "40";

            b.ADDRESS_TYPE = new XmlNodeEntity();
            b.ADDRESS_TYPE = "";
            b.ADDRESS_TYPE.Attr_TYPE = "N";
            b.ADDRESS_TYPE.LENGTH = "3";

            b.RELATIONSHIP_CODE = new XmlNodeEntity();
            b.RELATIONSHIP_CODE = "";
            b.RELATIONSHIP_CODE.Attr_TYPE = "N";
            b.RELATIONSHIP_CODE.LENGTH = "3";

            b.ATTENTION = new XmlNodeEntity();
            b.ATTENTION = "";
            b.ATTENTION.Attr_TYPE = "A";
            b.ATTENTION.LENGTH = "30";

            b.ADDRESS1 = new XmlNodeEntity();
            b.ADDRESS1 = "";
            b.ADDRESS1.Attr_TYPE = "A";
            b.ADDRESS1.LENGTH = "30";

            b.ADDRESS2 = new XmlNodeEntity();
            b.ADDRESS2 = "";
            b.ADDRESS2.Attr_TYPE = "A";
            b.ADDRESS2.LENGTH = "30";

            b.CITY = new XmlNodeEntity();
            b.CITY = "";
            b.CITY.Attr_TYPE = "A";
            b.CITY.LENGTH = "20";

            b.STATE = new XmlNodeEntity();
            b.STATE = "";
            b.STATE.Attr_TYPE = "A";
            b.STATE.LENGTH = "2";

            b.ZIP = new XmlNodeEntity();
            b.ZIP = "";
            b.ZIP.Attr_TYPE = "A";
            b.ZIP.LENGTH = "10";

            b.WORK_PHONE = new XmlNodeEntity();
            b.WORK_PHONE = "";
            b.WORK_PHONE.Attr_TYPE = "P";
            b.WORK_PHONE.LENGTH = "10";

            b.WORK_PHONE_EXT = new XmlNodeEntity();
            b.WORK_PHONE_EXT = "";
            b.WORK_PHONE_EXT.Attr_TYPE = "A";
            b.WORK_PHONE_EXT.LENGTH = "5";

            b.WORK_FAX = new XmlNodeEntity();
            b.WORK_FAX = "";
            b.WORK_FAX.Attr_TYPE = "P";
            b.WORK_FAX.LENGTH = "10";

            b.OTHER_PHONE = new XmlNodeEntity();
            b.OTHER_PHONE = "";
            b.OTHER_PHONE.Attr_TYPE = "P";
            b.OTHER_PHONE.LENGTH = "10";

            b.EMAIL = new XmlNodeEntity();
            b.EMAIL = "";
            b.EMAIL.Attr_TYPE = "A";
            b.EMAIL.LENGTH = "40";

            b.TRACE_NUMBER = new XmlNodeEntity();
            b.TRACE_NUMBER = "";
            b.TRACE_NUMBER.Attr_TYPE = "N";
            b.TRACE_NUMBER.LENGTH = "8";

            return b;
        }
    }
}
