using COPXmlFactory.RTTIE027;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Serialization;

namespace COPXmlFactory
{
    public abstract class XMLFactory
    {


        public static string GetXmlString(ICOPXmlTemplate e)
        {
            StringWriter sww = new StringWriter();
            System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(e.GetType());
            x.Serialize(sww, e);
            return sww.ToString();
        }

        public static XmlDocument GetXmlDocument(ICOPXmlTemplate e)
        {
            string XML = GetXmlString(e);
            XmlDocument doc = new XmlDocument();
            doc.LoadXml(XML);
            return doc;
        }

        public static RTTIE010.ACCTTEMPLATE GetObjectfromXmlString(string str)
        {
         //  System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(str.GetType());
          
         //TextReader tr=new StringReader(str);
         //return x.Deserialize(tr);
            var reader = new StringReader(str);
            var serializer = new XmlSerializer(typeof(RTTIE010.ACCTTEMPLATE));
            var instance = (RTTIE010.ACCTTEMPLATE)serializer.Deserialize(reader);

            return instance;
        }

        public static RTTIE037.BPTezReturn GetObjectfromXmlStringBPTezreurn(string str)
        {
            //  System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(str.GetType());

            //TextReader tr=new StringReader(str);
            //return x.Deserialize(tr);
            var reader = new StringReader(str);
            var serializer = new XmlSerializer(typeof(RTTIE037.BPTezReturn));
            var instance = (RTTIE037.BPTezReturn)serializer.Deserialize(reader);

            return instance;
        }

        public static RTTIE030.BPTlfReturn GetObjectfromXmlStringBPTlfreurn(string str)
        {
            //  System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(str.GetType());

            //TextReader tr=new StringReader(str);
            //return x.Deserialize(tr);
            var reader = new StringReader(str);
            var serializer = new XmlSerializer(typeof(RTTIE030.BPTlfReturn));
            var instance = (RTTIE030.BPTlfReturn)serializer.Deserialize(reader);

            return instance;
        }

        public static RTTIE027.WAGERETURN GetObjectfromXmlStringWage(string str)
        {
           
            var reader = new StringReader(str);
            var serializer = new XmlSerializer(typeof(RTTIE027.WAGERETURN));
            var instance = (RTTIE027.WAGERETURN)serializer.Deserialize(reader);

            return instance;
        }

        public static T GetObject<T>(string e)
        {
            T obj;
            try
            {
                StringReader sww = new StringReader(e);
                System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(typeof(T));
                 obj = (T)x.Deserialize(sww);
                
            }
            catch(Exception ex)
            {
                throw new Exception("Invalid request");
            }
            return obj;
        }
    }

    public partial class RevenueGovXMLFactory:XMLFactory
    {
       
        //public static RTTIE010.ACCTTEMPLATE GetAcctTemplate()
        //{

        //    RTTIE010.ACCTTEMPLATE p = new RTTIE010.ACCTTEMPLATE();

        //    //ERROR_INFO
        //    p.ERROR_INFO = new ERROR_INFO();
        //    p.ERROR_INFO.Attr_TYPE = "COMPLEX";
        //    p.ERROR_INFO.LENGTH = "79";
        //    p.ERROR_INFO.OCCURS = "1";
        //    p.ERROR_INFO.EXPORT = "N";

        //    p.ERROR_INFO.PROGRAM = new XmlNodeEntity();
        //    p.ERROR_INFO.PROGRAM = "sangha";
        //    p.ERROR_INFO.PROGRAM.Attr_TYPE = "A";
        //    p.ERROR_INFO.PROGRAM.LENGTH = "8";

        //    p.ERROR_INFO.ERROR = new XmlNodeEntity();
        //    p.ERROR_INFO.ERROR = "mitra";
        //    p.ERROR_INFO.ERROR.Attr_TYPE = "N";
        //    p.ERROR_INFO.ERROR.LENGTH = "7";

        //    p.ERROR_INFO.MESSAGE = new XmlNodeEntity();
        //    p.ERROR_INFO.MESSAGE = "";
        //    p.ERROR_INFO.MESSAGE.Attr_TYPE = "A";
        //    p.ERROR_INFO.MESSAGE.LENGTH = "60";

        //    p.ERROR_INFO.LINE = new XmlNodeEntity();
        //    p.ERROR_INFO.LINE = "";
        //    p.ERROR_INFO.LINE.Attr_TYPE = "A";
        //    p.ERROR_INFO.LINE.LENGTH = "4";



        //    //ENTITY_INFO
        //    p.ENTITY_INFO = new RTTIE010.ENTITY_INFO();
        //    p.ENTITY_INFO.TYPE = "COMPLEX";
        //    p.ENTITY_INFO.OCCURS = "1";
        //    p.ENTITY_INFO.LENGTH = "85";
        //    p.ENTITY_INFO.EXPORT = "Y";

        //    p.ENTITY_INFO.FUNCTION_CODE = new XmlNodeEntity();
        //    p.ENTITY_INFO.FUNCTION_CODE = "";
        //    p.ENTITY_INFO.FUNCTION_CODE.Attr_TYPE = "A";
        //    p.ENTITY_INFO.FUNCTION_CODE.LENGTH = "1";

        //    p.ENTITY_INFO.TYPE = new XmlNodeEntity();
        //    p.ENTITY_INFO.TYPE = "";
        //    p.ENTITY_INFO.TYPE.Attr_TYPE = "N";
        //    p.ENTITY_INFO.TYPE.LENGTH = "3";

        //    p.ENTITY_INFO.ENTITY_ID = new XmlNodeEntity();
        //    p.ENTITY_INFO.ENTITY_ID = "";
        //    p.ENTITY_INFO.ENTITY_ID.Attr_TYPE = "A";
        //    p.ENTITY_INFO.ENTITY_ID.LENGTH = "11";

        //    p.ENTITY_INFO.ACCOUNT_ID = new XmlNodeEntity();
        //    p.ENTITY_INFO.ACCOUNT_ID = "";
        //    p.ENTITY_INFO.ACCOUNT_ID.Attr_TYPE = "A";
        //    p.ENTITY_INFO.ACCOUNT_ID.LENGTH = "12";

        //    p.ENTITY_INFO.NAIC_CODE = new XmlNodeEntity();
        //    p.ENTITY_INFO.NAIC_CODE = "";
        //    p.ENTITY_INFO.NAIC_CODE.Attr_TYPE = "N";
        //    p.ENTITY_INFO.NAIC_CODE.LENGTH = "6";

        //    p.ENTITY_INFO.SIC_CODE = new XmlNodeEntity();
        //    p.ENTITY_INFO.SIC_CODE = "";
        //    p.ENTITY_INFO.SIC_CODE.Attr_TYPE = "N";
        //    p.ENTITY_INFO.SIC_CODE.LENGTH = "5";

        //    p.ENTITY_INFO.SIC_CODE = new XmlNodeEntity();
        //    p.ENTITY_INFO.START_DATE = "";
        //    p.ENTITY_INFO.START_DATE.Attr_TYPE = "D";
        //    p.ENTITY_INFO.START_DATE.LENGTH = "8";

        //    p.ENTITY_INFO.ORGTYPE = new XmlNodeEntity();
        //    p.ENTITY_INFO.ORGTYPE = "";
        //    p.ENTITY_INFO.ORGTYPE.Attr_TYPE = "N";
        //    p.ENTITY_INFO.ORGTYPE.LENGTH = "3";

        //    p.ENTITY_INFO.ORIGIN = new XmlNodeEntity();
        //    p.ENTITY_INFO.ORIGIN = "";
        //    p.ENTITY_INFO.ORIGIN.Attr_TYPE = "A";
        //    p.ENTITY_INFO.ORIGIN.LENGTH = "1";

        //    p.ENTITY_INFO.GENDER = new XmlNodeEntity();
        //    p.ENTITY_INFO.GENDER = "";
        //    p.ENTITY_INFO.GENDER.Attr_TYPE = "A";
        //    p.ENTITY_INFO.GENDER.LENGTH = "1";

        //    p.ENTITY_INFO.OTHER = new XmlNodeEntity();
        //    p.ENTITY_INFO.OTHER = "";
        //    p.ENTITY_INFO.OTHER.Attr_TYPE = "A";
        //    p.ENTITY_INFO.OTHER.LENGTH = "20";

        //    p.ENTITY_INFO.PIN = new XmlNodeEntity();
        //    p.ENTITY_INFO.PIN = "";
        //    p.ENTITY_INFO.PIN.Attr_TYPE = "N";
        //    p.ENTITY_INFO.PIN.LENGTH = "13";

        //    p.ENTITY_INFO.FORCEPINCHG = new XmlNodeEntity();
        //    p.ENTITY_INFO.FORCEPINCHG = "";
        //    p.ENTITY_INFO.FORCEPINCHG.Attr_TYPE = "A";
        //    p.ENTITY_INFO.FORCEPINCHG.LENGTH = "1";

        //    //TAX_ACCT
        //    p.TAX_ACCT = new List<RTTIE010.TAX_ACCT>();
        //    foreach (RTTIE010.TAX_ACCT b in p.TAX_ACCT)
        //    {
                
        //        b.Attr_TYPE = "COMPLEX";
        //        b.LENGTH = "48";
        //        b.OCCURS = "12";
        //        b.EXPORT = "Y";

        //        b.FUNCTION_CODE = new XmlNodeEntity();
        //        b.FUNCTION_CODE = "";
        //        b.FUNCTION_CODE.Attr_TYPE = "A";
        //        b.FUNCTION_CODE.LENGTH = "1";

        //        b.ACCOUNT = new XmlNodeEntity();
        //        b.ACCOUNT = "";
        //        b.ACCOUNT.Attr_TYPE = "N";
        //        b.ACCOUNT.LENGTH = "2";

        //        b.START_DATE = new XmlNodeEntity();
        //        b.START_DATE = "";
        //        b.START_DATE.Attr_TYPE = "D";
        //        b.START_DATE.LENGTH = "8";

        //        b.WAGE_MONTHLY_GROSS = new XmlNodeEntity();
        //        b.WAGE_MONTHLY_GROSS = "";
        //        b.WAGE_MONTHLY_GROSS.Attr_TYPE = "C";
        //        b.WAGE_MONTHLY_GROSS.LENGTH = "15";

        //        b.UOL_BRT = new XmlNodeEntity();
        //        b.UOL_BRT = "";
        //        b.UOL_BRT.Attr_TYPE = "A";
        //        b.UOL_BRT.LENGTH = "11";

        //        b.PRK_ID = new XmlNodeEntity();
        //        b.PRK_ID = "";
        //        b.PRK_ID.Attr_TYPE = "A";
        //        b.PRK_ID.LENGTH = "11";
        //    }


        //    //ECHECK
        //    p.ECHECK = new RTTIE010.ECHECK();
        //    p.ECHECK.Attr_TYPE = "COMPLEX";
        //    p.ECHECK.LENGTH = "31";
        //    p.ECHECK.OCCURS = "1";
        //    p.ECHECK.EXPORT = "Y";

        //    p.ECHECK.FUNCTION_CODE = new XmlNodeEntity();
        //    p.ECHECK.FUNCTION_CODE = "";
        //    p.ECHECK.FUNCTION_CODE.Attr_TYPE = "A";
        //    p.ECHECK.FUNCTION_CODE.LENGTH = "1";

        //    p.ECHECK.ROUTING_NUMBER = new XmlNodeEntity();
        //    p.ECHECK.ROUTING_NUMBER = "";
        //    p.ECHECK.ROUTING_NUMBER.Attr_TYPE = "A";
        //    p.ECHECK.ROUTING_NUMBER.LENGTH = "9";

        //    p.ECHECK.ACCOUNT_NUMBER = new XmlNodeEntity();
        //    p.ECHECK.ACCOUNT_NUMBER = "";
        //    p.ECHECK.ACCOUNT_NUMBER.Attr_TYPE = "A";
        //    p.ECHECK.ACCOUNT_NUMBER.LENGTH = "20";

        //    p.ECHECK.ACCOUNT_TYPE = new XmlNodeEntity();
        //    p.ECHECK.ACCOUNT_TYPE = "";
        //    p.ECHECK.ACCOUNT_TYPE.Attr_TYPE = "A";
        //    p.ECHECK.ACCOUNT_TYPE.LENGTH = "1";

        //    //NAME_ADDRESS
        //    p.NAME_ADDRESS = new List<RTTIE010.NAME_ADDRESS>();
        //    foreach (RTTIE010.NAME_ADDRESS b in p.NAME_ADDRESS)
        //    {

        //        b.Attr_TYPE = "COMPLEX";
        //        b.LENGTH = "306";
        //        b.OCCURS = "21";
        //        b.EXPORT = "Y";

        //        b.FUNCTION_CODE = new XmlNodeEntity();
        //        b.FUNCTION_CODE = "";
        //        b.FUNCTION_CODE.Attr_TYPE = "A";
        //        b.FUNCTION_CODE.LENGTH = "1";

        //        b.TYPE = new XmlNodeEntity();
        //        b.TYPE = "";
        //        b.TYPE.Attr_TYPE = "N";
        //        b.TYPE.LENGTH = "3";

        //        b.ID = new XmlNodeEntity();
        //        b.ID = "";
        //        b.ID.Attr_TYPE = "A";
        //        b.ID.LENGTH = "11";

        //        b.NAME = new XmlNodeEntity();
        //        b.NAME = "";
        //        b.NAME.Attr_TYPE = "A";
        //        b.NAME.LENGTH = "40";

        //        b.TRADE_NAME = new XmlNodeEntity();
        //        b.TRADE_NAME = "";
        //        b.TRADE_NAME.Attr_TYPE = "A";
        //        b.TRADE_NAME.LENGTH = "40";

        //        b.ADDRESS_TYPE = new XmlNodeEntity();
        //        b.ADDRESS_TYPE = "";
        //        b.ADDRESS_TYPE.Attr_TYPE = "N";
        //        b.ADDRESS_TYPE.LENGTH = "3";

        //        b.RELATIONSHIP_CODE = new XmlNodeEntity();
        //        b.RELATIONSHIP_CODE = "";
        //        b.RELATIONSHIP_CODE.Attr_TYPE = "N";
        //        b.RELATIONSHIP_CODE.LENGTH = "3";

        //        b.ATTENTION = new XmlNodeEntity();
        //        b.ATTENTION = "";
        //        b.ATTENTION.Attr_TYPE = "A";
        //        b.ATTENTION.LENGTH = "30";

        //        b.ADDRESS1 = new XmlNodeEntity();
        //        b.ADDRESS1 = "";
        //        b.ADDRESS1.Attr_TYPE = "A";
        //        b.ADDRESS1.LENGTH = "30";

        //        b.ADDRESS2 = new XmlNodeEntity();
        //        b.ADDRESS2 = "";
        //        b.ADDRESS2.Attr_TYPE = "A";
        //        b.ADDRESS2.LENGTH = "30";

        //        b.CITY = new XmlNodeEntity();
        //        b.CITY = "";
        //        b.CITY.Attr_TYPE = "A";
        //        b.CITY.LENGTH = "20";

        //        b.STATE = new XmlNodeEntity();
        //        b.STATE = "";
        //        b.STATE.Attr_TYPE = "A";
        //        b.STATE.LENGTH = "2";

        //        b.ZIP = new XmlNodeEntity();
        //        b.ZIP = "";
        //        b.ZIP.Attr_TYPE = "A";
        //        b.ZIP.LENGTH = "10";

        //        b.WORK_PHONE = new XmlNodeEntity();
        //        b.WORK_PHONE = "";
        //        b.WORK_PHONE.Attr_TYPE = "P";
        //        b.WORK_PHONE.LENGTH = "10";

        //        b.WORK_PHONE_EXT = new XmlNodeEntity();
        //        b.WORK_PHONE_EXT = "";
        //        b.WORK_PHONE_EXT.Attr_TYPE = "A";
        //        b.WORK_PHONE_EXT.LENGTH = "5";

        //        b.WORK_FAX = new XmlNodeEntity();
        //        b.WORK_FAX = "";
        //        b.WORK_FAX.Attr_TYPE = "P";
        //        b.WORK_FAX.LENGTH = "10";

        //        b.OTHER_PHONE = new XmlNodeEntity();
        //        b.OTHER_PHONE = "";
        //        b.OTHER_PHONE.Attr_TYPE = "P";
        //        b.OTHER_PHONE.LENGTH = "10";

        //        b.EMAIL = new XmlNodeEntity();
        //        b.EMAIL = "";
        //        b.EMAIL.Attr_TYPE = "A";
        //        b.EMAIL.LENGTH = "40";

        //        b.TRACE_NUMBER = new XmlNodeEntity();
        //        b.TRACE_NUMBER = "";
        //        b.TRACE_NUMBER.Attr_TYPE = "N";
        //        b.TRACE_NUMBER.LENGTH = "8";
        //    }

        //        //HEADER_INFO
        //        p.HEADER_INFO = new HEADER_INFO();
        //        p.HEADER_INFO.ENVIRONMENT = "";

        //        //DEBUG
        //        p.DEBUG = new DEBUG();

        //        return p;
        //    }
            //System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(p.GetType());
            //string str = x.ToString();
            //return document;
        

        //public static RTTIE037.BPTezReturn GetBPTezReturn()
        //{
        //    RTTIE037.BPTezReturn bpt = new RTTIE037.BPTezReturn();

        //    //Errorinfo
        //    bpt.ERROR_INFO = new ERROR_INFO();
        //    bpt.ERROR_INFO.Attr_TYPE = "COMPLEX";
        //    bpt.ERROR_INFO.OCCURS = "1";
        //    bpt.ERROR_INFO.LENGTH = "79";
        //    bpt.ERROR_INFO.EXPORT = "N";

        //    bpt.ERROR_INFO.PROGRAM = new XmlNodeEntity();
        //    bpt.ERROR_INFO.PROGRAM = "";
        //    bpt.ERROR_INFO.PROGRAM.Attr_TYPE = "A";
        //    bpt.ERROR_INFO.PROGRAM.LENGTH = "8";

        //    bpt.ERROR_INFO.ERROR = new XmlNodeEntity();
        //    bpt.ERROR_INFO.ERROR = "";
        //    bpt.ERROR_INFO.ERROR.Attr_TYPE = "N";
        //    bpt.ERROR_INFO.ERROR.LENGTH = "7";

        //    bpt.ERROR_INFO.LINE = new XmlNodeEntity();
        //    bpt.ERROR_INFO.LINE = "";
        //    bpt.ERROR_INFO.LINE.Attr_TYPE = "N";
        //    bpt.ERROR_INFO.LINE.LENGTH = "4";

        //    bpt.ERROR_INFO.MESSAGE = new XmlNodeEntity();
        //    bpt.ERROR_INFO.MESSAGE = "";
        //    bpt.ERROR_INFO.MESSAGE.Attr_TYPE = "A";
        //    bpt.ERROR_INFO.MESSAGE.LENGTH = "60";

        //    //UO_ACCT
        //    bpt.BPT_INFO = new RTTIE037.BPT_INFO();
        //    bpt.BPT_INFO.Attr_TYPE = "COMPLEX";
        //    bpt.BPT_INFO.OCCURS = "1";
        //    bpt.BPT_INFO.LENGTH = "222";
        //    bpt.BPT_INFO.EXPORT = "Y";

        //    bpt.BPT_INFO.ACCOUNT_ID = new XmlNodeEntity();
        //    bpt.BPT_INFO.ACCOUNT_ID = "";
        //    bpt.BPT_INFO.ACCOUNT_ID.Attr_TYPE = "A";
        //    bpt.BPT_INFO.ACCOUNT_ID.LENGTH = "12";

        //    bpt.BPT_INFO.PERIOD = new XmlNodeEntity();
        //    bpt.BPT_INFO.PERIOD = "";
        //    bpt.BPT_INFO.PERIOD.Attr_TYPE = "D";
        //    bpt.BPT_INFO.PERIOD.LENGTH = "8";

        //    bpt.BPT_INFO.VERSION = new XmlNodeEntity();
        //    bpt.BPT_INFO.VERSION = "";
        //    bpt.BPT_INFO.VERSION.Attr_TYPE = "A";
        //    bpt.BPT_INFO.VERSION.LENGTH = "3";

        //    bpt.BPT_INFO.RETURN_STATUS = new XmlNodeEntity();
        //    bpt.BPT_INFO.RETURN_STATUS = "";
        //    bpt.BPT_INFO.RETURN_STATUS.Attr_TYPE = "A";
        //    bpt.BPT_INFO.RETURN_STATUS.LENGTH = "3";

        //    bpt.BPT_INFO.LAST_UPD_DATE = new XmlNodeEntity();
        //    bpt.BPT_INFO.LAST_UPD_DATE = "";
        //    bpt.BPT_INFO.LAST_UPD_DATE.Attr_TYPE = "D";
        //    bpt.BPT_INFO.LAST_UPD_DATE.LENGTH = "8";

        //    bpt.BPT_INFO.RECORDING_DATE = new XmlNodeEntity();
        //    bpt.BPT_INFO.RECORDING_DATE = "";
        //    bpt.BPT_INFO.RECORDING_DATE.Attr_TYPE = "D";
        //    bpt.BPT_INFO.RECORDING_DATE.LENGTH = "8";

        //    bpt.BPT_INFO.EXTENSION_DATE = new XmlNodeEntity();
        //    bpt.BPT_INFO.EXTENSION_DATE = "";
        //    bpt.BPT_INFO.EXTENSION_DATE.Attr_TYPE = "D";
        //    bpt.BPT_INFO.EXTENSION_DATE.LENGTH = "8";

        //    bpt.BPT_INFO.SEQUENCE = new XmlNodeEntity();
        //    bpt.BPT_INFO.SEQUENCE = "";
        //    bpt.BPT_INFO.SEQUENCE.Attr_TYPE = "A";
        //    bpt.BPT_INFO.SEQUENCE.LENGTH = "5";

        //    bpt.BPT_INFO.ADJUSTMENT_REF_NO = new XmlNodeEntity();
        //    bpt.BPT_INFO.ADJUSTMENT_REF_NO = "";
        //    bpt.BPT_INFO.ADJUSTMENT_REF_NO.Attr_TYPE = "A";
        //    bpt.BPT_INFO.ADJUSTMENT_REF_NO.LENGTH = "10";


        //    bpt.BPT_INFO.USER_ID = new XmlNodeEntity();
        //    bpt.BPT_INFO.USER_ID = "";
        //    bpt.BPT_INFO.USER_ID.Attr_TYPE = "A";
        //    bpt.BPT_INFO.USER_ID.LENGTH = "8";

        //    bpt.BPT_INFO.NET_RATE = new XmlNodeEntity();
        //    bpt.BPT_INFO.NET_RATE = "";
        //    bpt.BPT_INFO.NET_RATE.Attr_TYPE = "N";
        //    bpt.BPT_INFO.NET_RATE.LENGTH = "9";
        //    bpt.BPT_INFO.NET_RATE.PERCISION = "6";

        //    bpt.BPT_INFO.GROSS_RATE = new XmlNodeEntity();
        //    bpt.BPT_INFO.GROSS_RATE = "";
        //    bpt.BPT_INFO.GROSS_RATE.Attr_TYPE = "N";
        //    bpt.BPT_INFO.GROSS_RATE.LENGTH = "9";
        //    bpt.BPT_INFO.GROSS_RATE.PERCISION = "6";

        //    bpt.BPT_INFO.PREPARER_NAME = new XmlNodeEntity();
        //    bpt.BPT_INFO.PREPARER_NAME = "";
        //    bpt.BPT_INFO.PREPARER_NAME.Attr_TYPE = "A";
        //    bpt.BPT_INFO.PREPARER_NAME.LENGTH = "40";

        //    bpt.BPT_INFO.PREPARER_PHONE = new XmlNodeEntity();
        //    bpt.BPT_INFO.PREPARER_PHONE = "";
        //    bpt.BPT_INFO.PREPARER_PHONE.Attr_TYPE = "P";
        //    bpt.BPT_INFO.PREPARER_PHONE.LENGTH = "10";

        //    bpt.BPT_INFO.PREPARER_PHONE_EXT = new XmlNodeEntity();
        //    bpt.BPT_INFO.PREPARER_PHONE_EXT = "";
        //    bpt.BPT_INFO.PREPARER_PHONE_EXT.Attr_TYPE = "A";
        //    bpt.BPT_INFO.PREPARER_PHONE_EXT.LENGTH = "5";

        //    bpt.BPT_INFO.PREPARER_IP_ADDRESS = new XmlNodeEntity();
        //    bpt.BPT_INFO.PREPARER_IP_ADDRESS = "";
        //    bpt.BPT_INFO.PREPARER_IP_ADDRESS.Attr_TYPE = "A";
        //    bpt.BPT_INFO.PREPARER_IP_ADDRESS.LENGTH = "15";

        //    bpt.BPT_INFO.PREPARER_EMAIL_ADDRESS = new XmlNodeEntity();
        //    bpt.BPT_INFO.PREPARER_EMAIL_ADDRESS = "";
        //    bpt.BPT_INFO.PREPARER_EMAIL_ADDRESS.Attr_TYPE = "A";
        //    bpt.BPT_INFO.PREPARER_EMAIL_ADDRESS.LENGTH = "60";

        //    bpt.BPT_INFO.PREPARER_WHO = new XmlNodeEntity();
        //    bpt.BPT_INFO.PREPARER_WHO = "";
        //    bpt.BPT_INFO.PREPARER_WHO.Attr_TYPE = "A";
        //    bpt.BPT_INFO.PREPARER_WHO.LENGTH = "1";

        //    //BPT_PG1
        //    bpt.BPT_PG1 = new RTTIE037.BPT_PG1();
        //    bpt.BPT_PG1.Attr_TYPE = "COMPLEX";
        //    bpt.BPT_PG1.OCCURS = "1";
        //    bpt.BPT_PG1.LENGTH = "210";
        //    bpt.BPT_PG1.EXPORT = "Y";

        //    bpt.BPT_PG1.NET_TAX = new XmlNodeEntity();
        //    bpt.BPT_PG1.NET_TAX = "";
        //    bpt.BPT_PG1.NET_TAX.Attr_TYPE = "C";
        //    bpt.BPT_PG1.NET_TAX.LENGTH = "15";

        //    bpt.BPT_PG1.GROSS_TAX = new XmlNodeEntity();
        //    bpt.BPT_PG1.GROSS_TAX = "";
        //    bpt.BPT_PG1.GROSS_TAX.Attr_TYPE = "C";
        //    bpt.BPT_PG1.GROSS_TAX.LENGTH = "15";

        //    bpt.BPT_PG1.ACTUAL_TAX = new XmlNodeEntity();
        //    bpt.BPT_PG1.ACTUAL_TAX = "";
        //    bpt.BPT_PG1.ACTUAL_TAX.Attr_TYPE = "C";
        //    bpt.BPT_PG1.ACTUAL_TAX.LENGTH = "15";

        //    bpt.BPT_PG1.ESTIMATED_TAX = new XmlNodeEntity();
        //    bpt.BPT_PG1.ESTIMATED_TAX = "";
        //    bpt.BPT_PG1.ESTIMATED_TAX.Attr_TYPE = "C";
        //    bpt.BPT_PG1.ESTIMATED_TAX.LENGTH = "15";

        //    bpt.BPT_PG1.TOTAL_TAX = new XmlNodeEntity();
        //    bpt.BPT_PG1.TOTAL_TAX = "";
        //    bpt.BPT_PG1.TOTAL_TAX.Attr_TYPE = "C";
        //    bpt.BPT_PG1.TOTAL_TAX.LENGTH = "15";

        //    bpt.BPT_PG1.NPT_TAX_CREDIT = new XmlNodeEntity();
        //    bpt.BPT_PG1.NPT_TAX_CREDIT = "";
        //    bpt.BPT_PG1.NPT_TAX_CREDIT.Attr_TYPE = "C";
        //    bpt.BPT_PG1.NPT_TAX_CREDIT.LENGTH = "15";

        //    bpt.BPT_PG1.BPT_TAX_CREDIT = new XmlNodeEntity();
        //    bpt.BPT_PG1.BPT_TAX_CREDIT = "";
        //    bpt.BPT_PG1.BPT_TAX_CREDIT.Attr_TYPE = "C";
        //    bpt.BPT_PG1.BPT_TAX_CREDIT.LENGTH = "15";

        //    bpt.BPT_PG1.TOTAL_PAY_CREDITS = new XmlNodeEntity();
        //    bpt.BPT_PG1.TOTAL_PAY_CREDITS = "";
        //    bpt.BPT_PG1.TOTAL_PAY_CREDITS.Attr_TYPE = "C";
        //    bpt.BPT_PG1.TOTAL_PAY_CREDITS.LENGTH = "15";

        //    bpt.BPT_PG1.TAX_DUE = new XmlNodeEntity();
        //    bpt.BPT_PG1.TAX_DUE = "TAX_DUE";
        //    bpt.BPT_PG1.TAX_DUE.Attr_TYPE = "C";
        //    bpt.BPT_PG1.TAX_DUE.LENGTH = "15";

        //    bpt.BPT_PG1.INTEREST_PENALTY = new XmlNodeEntity();
        //    bpt.BPT_PG1.INTEREST_PENALTY = "";
        //    bpt.BPT_PG1.INTEREST_PENALTY.Attr_TYPE = "C";
        //    bpt.BPT_PG1.INTEREST_PENALTY.LENGTH = "15";

        //    bpt.BPT_PG1.AMOUNT_OWED = new XmlNodeEntity();
        //    bpt.BPT_PG1.AMOUNT_OWED = "";
        //    bpt.BPT_PG1.AMOUNT_OWED.Attr_TYPE = "C";
        //    bpt.BPT_PG1.AMOUNT_OWED.LENGTH = "15";

        //    bpt.BPT_PG1.REFUND = new XmlNodeEntity();
        //    bpt.BPT_PG1.REFUND = "";
        //    bpt.BPT_PG1.REFUND.Attr_TYPE = "C";
        //    bpt.BPT_PG1.REFUND.LENGTH = "15";

        //    bpt.BPT_PG1.NPT_OVERPAY = new XmlNodeEntity();
        //    bpt.BPT_PG1.NPT_OVERPAY = "";
        //    bpt.BPT_PG1.NPT_OVERPAY.Attr_TYPE = "C";
        //    bpt.BPT_PG1.NPT_OVERPAY.LENGTH = "15";

        //    bpt.BPT_PG1.BPT_OVERPAY = new XmlNodeEntity();
        //    bpt.BPT_PG1.BPT_OVERPAY = "";
        //    bpt.BPT_PG1.BPT_OVERPAY.Attr_TYPE = "C";
        //    bpt.BPT_PG1.BPT_OVERPAY.LENGTH = "15";

        //    //BPT_PG2
        //    bpt.BPT_PG2 = new RTTIE037.BPT_PG2();
        //    bpt.BPT_PG2.Attr_TYPE = "COMPLEX";
        //    bpt.BPT_PG2.OCCURS = "1";
        //    bpt.BPT_PG2.LENGTH = "240";
        //    bpt.BPT_PG2.EXPORT = "Y";

        //    bpt.BPT_PG2.NET_INCOME_LOSS_1 = new XmlNodeEntity();
        //    bpt.BPT_PG2.NET_INCOME_LOSS_1 = "";
        //    bpt.BPT_PG2.NET_INCOME_LOSS_1.Attr_TYPE = "C";
        //    bpt.BPT_PG2.NET_INCOME_LOSS_1.LENGTH = "15";

        //    bpt.BPT_PG2.NET_INCOME_LOSS_2 = new XmlNodeEntity();
        //    bpt.BPT_PG2.NET_INCOME_LOSS_2 = "";
        //    bpt.BPT_PG2.NET_INCOME_LOSS_2.Attr_TYPE = "C";
        //    bpt.BPT_PG2.NET_INCOME_LOSS_2.LENGTH = "15";

        //    bpt.BPT_PG2.LOSS_CARRY_FORWARD = new XmlNodeEntity();
        //    bpt.BPT_PG2.LOSS_CARRY_FORWARD = "";
        //    bpt.BPT_PG2.LOSS_CARRY_FORWARD.Attr_TYPE = "C";
        //    bpt.BPT_PG2.LOSS_CARRY_FORWARD.LENGTH = "15";

        //    bpt.BPT_PG2.TAXABLE_INCOME = new XmlNodeEntity();
        //    bpt.BPT_PG2.TAXABLE_INCOME = "";
        //    bpt.BPT_PG2.TAXABLE_INCOME.Attr_TYPE = "C";
        //    bpt.BPT_PG2.TAXABLE_INCOME.LENGTH = "15";

        //    bpt.BPT_PG2.TAX_DUE_NET = new XmlNodeEntity();
        //    bpt.BPT_PG2.TAX_DUE_NET = "";
        //    bpt.BPT_PG2.TAX_DUE_NET.Attr_TYPE = "C";
        //    bpt.BPT_PG2.TAX_DUE_NET.LENGTH = "15";

        //    bpt.BPT_PG2.SALES_RENTAL = new XmlNodeEntity();
        //    bpt.BPT_PG2.SALES_RENTAL = "";
        //    bpt.BPT_PG2.SALES_RENTAL.Attr_TYPE = "C";
        //    bpt.BPT_PG2.SALES_RENTAL.LENGTH = "15";

        //    bpt.BPT_PG2.SERVICES = new XmlNodeEntity();
        //    bpt.BPT_PG2.SERVICES = "";
        //    bpt.BPT_PG2.SERVICES.Attr_TYPE = "C";
        //    bpt.BPT_PG2.SERVICES.LENGTH = "15";

        //    bpt.BPT_PG2.RENTAL_PROPERTY = new XmlNodeEntity();
        //    bpt.BPT_PG2.RENTAL_PROPERTY = "";
        //    bpt.BPT_PG2.RENTAL_PROPERTY.Attr_TYPE = "C";
        //    bpt.BPT_PG2.RENTAL_PROPERTY.LENGTH = "15";

        //    bpt.BPT_PG2.ROYALTIES = new XmlNodeEntity();
        //    bpt.BPT_PG2.ROYALTIES = "";
        //    bpt.BPT_PG2.ROYALTIES.Attr_TYPE = "C";
        //    bpt.BPT_PG2.ROYALTIES.LENGTH = "15";

        //    bpt.BPT_PG2.CAPITAL_GAINS = new XmlNodeEntity();
        //    bpt.BPT_PG2.CAPITAL_GAINS = "";
        //    bpt.BPT_PG2.CAPITAL_GAINS.Attr_TYPE = "C";
        //    bpt.BPT_PG2.CAPITAL_GAINS.LENGTH = "15";

        //    bpt.BPT_PG2.STOCK_GAINS = new XmlNodeEntity();
        //    bpt.BPT_PG2.STOCK_GAINS = "";
        //    bpt.BPT_PG2.STOCK_GAINS.Attr_TYPE = "C";
        //    bpt.BPT_PG2.STOCK_GAINS.LENGTH = "15";

        //    bpt.BPT_PG2.DIVIDENDS = new XmlNodeEntity();
        //    bpt.BPT_PG2.DIVIDENDS = "";
        //    bpt.BPT_PG2.DIVIDENDS.Attr_TYPE = "C";
        //    bpt.BPT_PG2.DIVIDENDS.LENGTH = "15";

        //    bpt.BPT_PG2.INTEREST = new XmlNodeEntity();
        //    bpt.BPT_PG2.INTEREST = "";
        //    bpt.BPT_PG2.INTEREST.Attr_TYPE = "C";
        //    bpt.BPT_PG2.INTEREST.LENGTH = "15";

        //    bpt.BPT_PG2.OTHER = new XmlNodeEntity();
        //    bpt.BPT_PG2.OTHER = "";
        //    bpt.BPT_PG2.OTHER.Attr_TYPE = "C";
        //    bpt.BPT_PG2.OTHER.LENGTH = "15";

        //    bpt.BPT_PG2.TAXABLE_GROSS_RCPTS = new XmlNodeEntity();
        //    bpt.BPT_PG2.TAXABLE_GROSS_RCPTS = "";
        //    bpt.BPT_PG2.TAXABLE_GROSS_RCPTS.Attr_TYPE = "C";
        //    bpt.BPT_PG2.TAXABLE_GROSS_RCPTS.LENGTH = "15";

        //    bpt.BPT_PG2.TAX_DUE_GROSS = new XmlNodeEntity();
        //    bpt.BPT_PG2.TAX_DUE_GROSS = "";
        //    bpt.BPT_PG2.TAX_DUE_GROSS.Attr_TYPE = "C";
        //    bpt.BPT_PG2.TAX_DUE_GROSS.LENGTH = "15";

        //    //HEADER_INFO
        //    bpt.HEADER_INFO = new HEADER_INFO();
        //    bpt.HEADER_INFO.ENVIRONMENT = "";

        //    //DEBUG
        //    bpt.DEBUG = new DEBUG();

        //    return bpt;
        //}

    //    public static RTTIE030.BPTlfReturn GetBPTlfReturn()
    //    {
    //        RTTIE030.BPTlfReturn bpl = new RTTIE030.BPTlfReturn();

    //        //Errorinfo
    //        bpl.ERROR_INFO = new ERROR_INFO();
    //        bpl.ERROR_INFO.Attr_TYPE = "COMPLEX";
    //        bpl.ERROR_INFO.OCCURS = "1";
    //        bpl.ERROR_INFO.LENGTH = "79";
    //        bpl.ERROR_INFO.EXPORT = "N";

    //        bpl.ERROR_INFO.PROGRAM = new XmlNodeEntity();
    //        bpl.ERROR_INFO.PROGRAM = "";
    //        bpl.ERROR_INFO.PROGRAM.Attr_TYPE = "A";
    //        bpl.ERROR_INFO.PROGRAM.LENGTH = "8";

    //        bpl.ERROR_INFO.ERROR = new XmlNodeEntity();
    //        bpl.ERROR_INFO.ERROR = "";
    //        bpl.ERROR_INFO.ERROR.Attr_TYPE = "N";
    //        bpl.ERROR_INFO.ERROR.LENGTH = "7";

    //        bpl.ERROR_INFO.LINE = new XmlNodeEntity();
    //        bpl.ERROR_INFO.LINE = "";
    //        bpl.ERROR_INFO.LINE.Attr_TYPE = "N";
    //        bpl.ERROR_INFO.LINE.LENGTH = "4";

    //        bpl.ERROR_INFO.MESSAGE = new XmlNodeEntity();
    //        bpl.ERROR_INFO.MESSAGE = "";
    //        bpl.ERROR_INFO.MESSAGE.Attr_TYPE = "A";
    //        bpl.ERROR_INFO.MESSAGE.LENGTH = "60";

    //        //BPT_INFO
    //        bpl.BPT_INFO = new RTTIE030.BPT_INFO();
    //        bpl.BPT_INFO.Attr_TYPE = "COMPLEX";
    //        bpl.BPT_INFO.OCCURS = "1";
    //        bpl.BPT_INFO.LENGTH = "222";
    //        bpl.BPT_INFO.EXPORT = "Y";

    //        bpl.BPT_INFO.ACCOUNT_ID = new XmlNodeEntity();
    //        bpl.BPT_INFO.ACCOUNT_ID = "";
    //        bpl.BPT_INFO.ACCOUNT_ID.Attr_TYPE = "A";
    //        bpl.BPT_INFO.ACCOUNT_ID.LENGTH = "12";

    //        bpl.BPT_INFO.PERIOD = new XmlNodeEntity();
    //        bpl.BPT_INFO.PERIOD = "";
    //        bpl.BPT_INFO.PERIOD.Attr_TYPE = "D";
    //        bpl.BPT_INFO.PERIOD.LENGTH = "8";

    //        bpl.BPT_INFO.VERSION = new XmlNodeEntity();
    //        bpl.BPT_INFO.VERSION = "";
    //        bpl.BPT_INFO.VERSION.Attr_TYPE = "A";
    //        bpl.BPT_INFO.VERSION.LENGTH = "3";

    //        bpl.BPT_INFO.RETURN_STATUS = new XmlNodeEntity();
    //        bpl.BPT_INFO.RETURN_STATUS = "";
    //        bpl.BPT_INFO.RETURN_STATUS.Attr_TYPE = "A";
    //        bpl.BPT_INFO.RETURN_STATUS.LENGTH = "3";

    //        bpl.BPT_INFO.LAST_UPD_DATE = new XmlNodeEntity();
    //        bpl.BPT_INFO.LAST_UPD_DATE = "";
    //        bpl.BPT_INFO.LAST_UPD_DATE.Attr_TYPE = "D";
    //        bpl.BPT_INFO.LAST_UPD_DATE.LENGTH = "8";

    //        bpl.BPT_INFO.RECORDING_DATE = new XmlNodeEntity();
    //        bpl.BPT_INFO.RECORDING_DATE = "";
    //        bpl.BPT_INFO.RECORDING_DATE.Attr_TYPE = "D";
    //        bpl.BPT_INFO.RECORDING_DATE.LENGTH = "8";

    //        bpl.BPT_INFO.EXTENSION_DATE = new XmlNodeEntity();
    //        bpl.BPT_INFO.EXTENSION_DATE = "";
    //        bpl.BPT_INFO.EXTENSION_DATE.Attr_TYPE = "D";
    //        bpl.BPT_INFO.EXTENSION_DATE.LENGTH = "8";

    //        bpl.BPT_INFO.SEQUENCE = new XmlNodeEntity();
    //        bpl.BPT_INFO.SEQUENCE = "";
    //        bpl.BPT_INFO.SEQUENCE.Attr_TYPE = "A";
    //        bpl.BPT_INFO.SEQUENCE.LENGTH = "5";

    //        bpl.BPT_INFO.ADJUSTMENT_REF_NO = new XmlNodeEntity();
    //        bpl.BPT_INFO.ADJUSTMENT_REF_NO = "";
    //        bpl.BPT_INFO.ADJUSTMENT_REF_NO.Attr_TYPE = "A";
    //        bpl.BPT_INFO.ADJUSTMENT_REF_NO.LENGTH = "10";

    //        bpl.BPT_INFO.USER_ID = new XmlNodeEntity();
    //        bpl.BPT_INFO.USER_ID = "";
    //        bpl.BPT_INFO.USER_ID.Attr_TYPE = "A";
    //        bpl.BPT_INFO.USER_ID.LENGTH = "8";

    //        bpl.BPT_INFO.SCH_AB_TAX_RATE = new XmlNodeEntity();
    //        bpl.BPT_INFO.SCH_AB_TAX_RATE = "";
    //        bpl.BPT_INFO.SCH_AB_TAX_RATE.Attr_TYPE = "N";
    //        bpl.BPT_INFO.SCH_AB_TAX_RATE.LENGTH = "9";
    //        bpl.BPT_INFO.SCH_AB_TAX_RATE.PERCISION = "6";

    //        bpl.BPT_INFO.SCH_D_TAX_RATE = new XmlNodeEntity();
    //        bpl.BPT_INFO.SCH_D_TAX_RATE = "";
    //        bpl.BPT_INFO.SCH_D_TAX_RATE.Attr_TYPE = "N";
    //        bpl.BPT_INFO.SCH_D_TAX_RATE.LENGTH = "9";
    //        bpl.BPT_INFO.SCH_AB_TAX_RATE.PERCISION = "6";

    //        bpl.BPT_INFO.SCH_E_M_TAX_RATE = new XmlNodeEntity();
    //        bpl.BPT_INFO.SCH_E_M_TAX_RATE = "";
    //        bpl.BPT_INFO.SCH_E_M_TAX_RATE.Attr_TYPE = "N";
    //        bpl.BPT_INFO.SCH_E_M_TAX_RATE.LENGTH = "9";
    //        bpl.BPT_INFO.SCH_E_M_TAX_RATE.PERCISION = "6";

    //        bpl.BPT_INFO.SCH_E_W_TAX_RATE = new XmlNodeEntity();
    //        bpl.BPT_INFO.SCH_E_W_TAX_RATE = "";
    //        bpl.BPT_INFO.SCH_E_W_TAX_RATE.Attr_TYPE = "N";
    //        bpl.BPT_INFO.SCH_E_W_TAX_RATE.LENGTH = "9";
    //        bpl.BPT_INFO.SCH_E_W_TAX_RATE.PERCISION = "6";

    //        bpl.BPT_INFO.SCH_E_R_TAX_RATE = new XmlNodeEntity();
    //        bpl.BPT_INFO.SCH_E_R_TAX_RATE = "";
    //        bpl.BPT_INFO.SCH_E_R_TAX_RATE.Attr_TYPE = "N";
    //        bpl.BPT_INFO.SCH_E_R_TAX_RATE.LENGTH = "9";
    //        bpl.BPT_INFO.SCH_E_R_TAX_RATE.PERCISION = "6";

    //        bpl.BPT_INFO.LOSS_CARRY_FOWARD = new XmlNodeEntity();
    //        bpl.BPT_INFO.LOSS_CARRY_FOWARD = "";
    //        bpl.BPT_INFO.LOSS_CARRY_FOWARD.Attr_TYPE = "N";
    //        bpl.BPT_INFO.LOSS_CARRY_FOWARD.LENGTH = "15";

    //        bpl.BPT_INFO.PREPARER_NAME = new XmlNodeEntity();
    //        bpl.BPT_INFO.PREPARER_NAME = "";
    //        bpl.BPT_INFO.PREPARER_NAME.Attr_TYPE = "A";
    //        bpl.BPT_INFO.PREPARER_NAME.LENGTH = "40";

    //        bpl.BPT_INFO.PREPARER_PHONE = new XmlNodeEntity();
    //        bpl.BPT_INFO.PREPARER_PHONE = "";
    //        bpl.BPT_INFO.PREPARER_PHONE.Attr_TYPE = "P";
    //        bpl.BPT_INFO.PREPARER_PHONE.LENGTH = "10";

    //        bpl.BPT_INFO.PREPARER_PHONE_EXT = new XmlNodeEntity();
    //        bpl.BPT_INFO.PREPARER_PHONE_EXT = "";
    //        bpl.BPT_INFO.PREPARER_PHONE_EXT.Attr_TYPE = "A";
    //        bpl.BPT_INFO.PREPARER_PHONE_EXT.LENGTH = "5";

    //        bpl.BPT_INFO.PREPARER_IP_ADDRESS = new XmlNodeEntity();
    //        bpl.BPT_INFO.PREPARER_IP_ADDRESS = "";
    //        bpl.BPT_INFO.PREPARER_IP_ADDRESS.Attr_TYPE = "A";
    //        bpl.BPT_INFO.PREPARER_IP_ADDRESS.LENGTH = "15";

    //        bpl.BPT_INFO.PREPARER_EMAIL_ADDRESS = new XmlNodeEntity();
    //        bpl.BPT_INFO.PREPARER_EMAIL_ADDRESS = "";
    //        bpl.BPT_INFO.PREPARER_EMAIL_ADDRESS.Attr_TYPE = "A";
    //        bpl.BPT_INFO.PREPARER_EMAIL_ADDRESS.LENGTH = "60";

    //        bpl.BPT_INFO.PREPARER_WHO = new XmlNodeEntity();
    //        bpl.BPT_INFO.PREPARER_WHO = "";
    //        bpl.BPT_INFO.PREPARER_WHO.Attr_TYPE = "A";
    //        bpl.BPT_INFO.PREPARER_WHO.LENGTH = "1";

    //        //BPT_PG1
    //        bpl.BPT_PG1 = new RTTIE030.BPT_PG1();
    //        bpl.BPT_PG1.Attr_TYPE = "COMPLEX";
    //        bpl.BPT_PG1.OCCURS = "1";
    //        bpl.BPT_PG1.LENGTH = "210";
    //        bpl.BPT_PG1.EXPORT = "Y";

    //        bpl.BPT_PG1.NET_INCOME = new XmlNodeEntity();
    //        bpl.BPT_PG1.NET_INCOME = "";
    //        bpl.BPT_PG1.NET_INCOME.Attr_TYPE = "C";
    //        bpl.BPT_PG1.NET_INCOME.LENGTH = "15";

    //        bpl.BPT_PG1.GROSS_RECEIPTS = new XmlNodeEntity();
    //        bpl.BPT_PG1.GROSS_RECEIPTS = "";
    //        bpl.BPT_PG1.GROSS_RECEIPTS.Attr_TYPE = "C";
    //        bpl.BPT_PG1.GROSS_RECEIPTS.LENGTH = "15";

    //        bpl.BPT_PG1.TAX_DUE = new XmlNodeEntity();
    //        bpl.BPT_PG1.TAX_DUE = "";
    //        bpl.BPT_PG1.TAX_DUE.Attr_TYPE = "C";
    //        bpl.BPT_PG1.TAX_DUE.LENGTH = "15";

    //        bpl.BPT_PG1.ESTIMATED_TAX = new XmlNodeEntity();
    //        bpl.BPT_PG1.ESTIMATED_TAX = "";
    //        bpl.BPT_PG1.ESTIMATED_TAX.Attr_TYPE = "C";
    //        bpl.BPT_PG1.ESTIMATED_TAX.LENGTH = "15";

    //        bpl.BPT_PG1.TOTAL_TAX = new XmlNodeEntity();
    //        bpl.BPT_PG1.TOTAL_TAX = "";
    //        bpl.BPT_PG1.TOTAL_TAX.Attr_TYPE = "C";
    //        bpl.BPT_PG1.TOTAL_TAX.LENGTH = "15";

    //        bpl.BPT_PG1.NPT_TAX_CREDIT = new XmlNodeEntity();
    //        bpl.BPT_PG1.NPT_TAX_CREDIT = "";
    //        bpl.BPT_PG1.NPT_TAX_CREDIT.Attr_TYPE = "C";
    //        bpl.BPT_PG1.NPT_TAX_CREDIT.LENGTH = "15";

    //        bpl.BPT_PG1.BPT_TAX_CREDIT = new XmlNodeEntity();
    //        bpl.BPT_PG1.BPT_TAX_CREDIT = "";
    //        bpl.BPT_PG1.BPT_TAX_CREDIT.Attr_TYPE = "C";
    //        bpl.BPT_PG1.BPT_TAX_CREDIT.LENGTH = "15";

    //        bpl.BPT_PG1.TOTAL_PAY_CREDITS = new XmlNodeEntity();
    //        bpl.BPT_PG1.TOTAL_PAY_CREDITS = "";
    //        bpl.BPT_PG1.TOTAL_PAY_CREDITS.Attr_TYPE = "C";
    //        bpl.BPT_PG1.TOTAL_PAY_CREDITS.LENGTH = "15";

    //        bpl.BPT_PG1.NET_TAX = new XmlNodeEntity();
    //        bpl.BPT_PG1.NET_TAX = "";
    //        bpl.BPT_PG1.NET_TAX.Attr_TYPE = "C";
    //        bpl.BPT_PG1.NET_TAX.LENGTH = "15";

    //        bpl.BPT_PG1.INTEREST_PENALTY = new XmlNodeEntity();
    //        bpl.BPT_PG1.INTEREST_PENALTY = "";
    //        bpl.BPT_PG1.INTEREST_PENALTY.Attr_TYPE = "C";
    //        bpl.BPT_PG1.INTEREST_PENALTY.LENGTH = "15";

    //        bpl.BPT_PG1.AMOUNT_OWED = new XmlNodeEntity();
    //        bpl.BPT_PG1.AMOUNT_OWED = "";
    //        bpl.BPT_PG1.AMOUNT_OWED.Attr_TYPE = "C";
    //        bpl.BPT_PG1.AMOUNT_OWED.LENGTH = "15";

    //        bpl.BPT_PG1.REFUND = new XmlNodeEntity();
    //        bpl.BPT_PG1.REFUND = "";
    //        bpl.BPT_PG1.REFUND.Attr_TYPE = "C";
    //        bpl.BPT_PG1.REFUND.LENGTH = "15";

    //        bpl.BPT_PG1.NPT_OVERPAY = new XmlNodeEntity();
    //        bpl.BPT_PG1.NPT_OVERPAY = "";
    //        bpl.BPT_PG1.NPT_OVERPAY.Attr_TYPE = "C";
    //        bpl.BPT_PG1.NPT_OVERPAY.LENGTH = "15";

    //        bpl.BPT_PG1.BPT_OVERPAY = new XmlNodeEntity();
    //        bpl.BPT_PG1.BPT_OVERPAY = "";
    //        bpl.BPT_PG1.BPT_OVERPAY.Attr_TYPE = "C";
    //        bpl.BPT_PG1.BPT_OVERPAY.LENGTH = "15";

    //        //BPT_SCH_A
    //        bpl.BPT_SCH_A = new RTTIE030.BPT_SCH_A();
    //        bpl.BPT_SCH_A.Attr_TYPE = "COMPLEX";
    //        bpl.BPT_SCH_A.OCCURS = "1";
    //        bpl.BPT_SCH_A.LENGTH = "180";
    //        bpl.BPT_SCH_A.EXPORT = "Y";

    //        bpl.BPT_SCH_A.NI_LOSS = new XmlNodeEntity();
    //        bpl.BPT_SCH_A.NI_LOSS = "";
    //        bpl.BPT_SCH_A.NI_LOSS.Attr_TYPE = "C";
    //        bpl.BPT_SCH_A.NI_LOSS.LENGTH = "15";

    //        bpl.BPT_SCH_A.NI_PORT_ACTIVITIES = new XmlNodeEntity();
    //        bpl.BPT_SCH_A.NI_PORT_ACTIVITIES = "";
    //        bpl.BPT_SCH_A.NI_PORT_ACTIVITIES.Attr_TYPE = "C";
    //        bpl.BPT_SCH_A.NI_PORT_ACTIVITIES.LENGTH = "15";

    //        bpl.BPT_SCH_A.NI_PUC_ICC = new XmlNodeEntity();
    //        bpl.BPT_SCH_A.NI_PUC_ICC = "";
    //        bpl.BPT_SCH_A.NI_PUC_ICC.Attr_TYPE = "C";
    //        bpl.BPT_SCH_A.NI_PUC_ICC.LENGTH = "15";

    //        bpl.BPT_SCH_A.NI_PUBLIC_LAW = new XmlNodeEntity();
    //        bpl.BPT_SCH_A.NI_PUBLIC_LAW = "";
    //        bpl.BPT_SCH_A.NI_PUBLIC_LAW.Attr_TYPE = "C";
    //        bpl.BPT_SCH_A.NI_PUBLIC_LAW.LENGTH = "15";

    //        bpl.BPT_SCH_A.I_APPORTIONED = new XmlNodeEntity();
    //        bpl.BPT_SCH_A.I_APPORTIONED = "";
    //        bpl.BPT_SCH_A.I_APPORTIONED.Attr_TYPE = "C";
    //        bpl.BPT_SCH_A.I_APPORTIONED.LENGTH = "15";

    //        bpl.BPT_SCH_A.I_APPORTIONED_PERCENT = new XmlNodeEntity();
    //        bpl.BPT_SCH_A.I_APPORTIONED_PERCENT = "";
    //        bpl.BPT_SCH_A.I_APPORTIONED_PERCENT.Attr_TYPE = "C";
    //        bpl.BPT_SCH_A.I_APPORTIONED_PERCENT.LENGTH = "15";

    //        bpl.BPT_SCH_A.I_APPORTIONED_PHILA = new XmlNodeEntity();
    //        bpl.BPT_SCH_A.I_APPORTIONED_PHILA = "";
    //        bpl.BPT_SCH_A.I_APPORTIONED_PHILA.Attr_TYPE = "C";
    //        bpl.BPT_SCH_A.I_APPORTIONED_PHILA.LENGTH = "15";

    //        bpl.BPT_SCH_A.I_NONBUS_PHILA = new XmlNodeEntity();
    //        bpl.BPT_SCH_A.I_NONBUS_PHILA = "";
    //        bpl.BPT_SCH_A.I_NONBUS_PHILA.Attr_TYPE = "C";
    //        bpl.BPT_SCH_A.I_NONBUS_PHILA.LENGTH = "15";

    //        bpl.BPT_SCH_A.I_CURRENT_YEAR = new XmlNodeEntity();
    //        bpl.BPT_SCH_A.I_CURRENT_YEAR = "";
    //        bpl.BPT_SCH_A.I_CURRENT_YEAR.Attr_TYPE = "C";
    //        bpl.BPT_SCH_A.I_CURRENT_YEAR.LENGTH = "15";

    //        bpl.BPT_SCH_A.LOSS_CARRY_FORWARD = new XmlNodeEntity();
    //        bpl.BPT_SCH_A.LOSS_CARRY_FORWARD = "";
    //        bpl.BPT_SCH_A.LOSS_CARRY_FORWARD.Attr_TYPE = "C";
    //        bpl.BPT_SCH_A.LOSS_CARRY_FORWARD.LENGTH = "15";

    //        bpl.BPT_SCH_A.I_TAXABLE = new XmlNodeEntity();
    //        bpl.BPT_SCH_A.I_TAXABLE = "";
    //        bpl.BPT_SCH_A.I_TAXABLE.Attr_TYPE = "C";
    //        bpl.BPT_SCH_A.I_TAXABLE.LENGTH = "15";

    //        bpl.BPT_SCH_A.TAX_DUE = new XmlNodeEntity();
    //        bpl.BPT_SCH_A.TAX_DUE = "";
    //        bpl.BPT_SCH_A.TAX_DUE.Attr_TYPE = "C";
    //        bpl.BPT_SCH_A.TAX_DUE.LENGTH = "15";

    //        //BPT_SCH_B
    //        bpl.BPT_SCH_B = new RTTIE030.BPT_SCH_B();
    //        bpl.BPT_SCH_B.Attr_TYPE = "COMPLEX";
    //        bpl.BPT_SCH_B.OCCURS = "1";
    //        bpl.BPT_SCH_B.LENGTH = "315";
    //        bpl.BPT_SCH_B.EXPORT = "Y";

    //        bpl.BPT_SCH_B.NI_LOSS = new XmlNodeEntity();
    //        bpl.BPT_SCH_B.NI_LOSS = "";
    //        bpl.BPT_SCH_B.NI_LOSS.Attr_TYPE = "C";
    //        bpl.BPT_SCH_B.NI_LOSS.LENGTH = "15";

    //        bpl.BPT_SCH_B.ADJ_NI_INTEREST = new XmlNodeEntity();
    //        bpl.BPT_SCH_B.ADJ_NI_INTEREST = "";
    //        bpl.BPT_SCH_B.ADJ_NI_INTEREST.Attr_TYPE = "C";
    //        bpl.BPT_SCH_B.ADJ_NI_INTEREST.LENGTH = "15";

    //        bpl.BPT_SCH_B.ADJ_NI_PORT_ACTIVITIES = new XmlNodeEntity();
    //        bpl.BPT_SCH_B.ADJ_NI_PORT_ACTIVITIES = "";
    //        bpl.BPT_SCH_B.ADJ_NI_PORT_ACTIVITIES.Attr_TYPE = "C";
    //        bpl.BPT_SCH_B.ADJ_NI_PORT_ACTIVITIES.LENGTH = "15";

    //        bpl.BPT_SCH_B.ADJ_NI_PUC_ICC = new XmlNodeEntity();
    //        bpl.BPT_SCH_B.ADJ_NI_PUC_ICC = "";
    //        bpl.BPT_SCH_B.ADJ_NI_PUC_ICC.Attr_TYPE = "C";
    //        bpl.BPT_SCH_B.ADJ_NI_PUC_ICC.LENGTH = "15";

    //        bpl.BPT_SCH_B.ADJ_NI_PUBLIC_LAW = new XmlNodeEntity();
    //        bpl.BPT_SCH_B.ADJ_NI_PUBLIC_LAW = "";
    //        bpl.BPT_SCH_B.ADJ_NI_PUBLIC_LAW.Attr_TYPE = "C";
    //        bpl.BPT_SCH_B.ADJ_NI_PUBLIC_LAW.LENGTH = "15";

    //        bpl.BPT_SCH_B.ADJ_RECEIPTS_DIR = new XmlNodeEntity();
    //        bpl.BPT_SCH_B.ADJ_RECEIPTS_DIR = "";
    //        bpl.BPT_SCH_B.ADJ_RECEIPTS_DIR.Attr_TYPE = "C";
    //        bpl.BPT_SCH_B.ADJ_RECEIPTS_DIR.LENGTH = "15";

    //        bpl.BPT_SCH_B.ADJ_INCOME = new XmlNodeEntity();
    //        bpl.BPT_SCH_B.ADJ_INCOME = "";
    //        bpl.BPT_SCH_B.ADJ_INCOME.Attr_TYPE = "C";
    //        bpl.BPT_SCH_B.ADJ_INCOME.LENGTH = "15";

    //        bpl.BPT_SCH_B.ADJ_RECEIPTS_OTHER = new XmlNodeEntity();
    //        bpl.BPT_SCH_B.ADJ_RECEIPTS_OTHER = "";
    //        bpl.BPT_SCH_B.ADJ_RECEIPTS_OTHER.Attr_TYPE = "C";
    //        bpl.BPT_SCH_B.ADJ_RECEIPTS_OTHER.LENGTH = "15";

    //        bpl.BPT_SCH_B.ADJ_GROSS_RECEIPTS = new XmlNodeEntity();
    //        bpl.BPT_SCH_B.ADJ_GROSS_RECEIPTS = "";
    //        bpl.BPT_SCH_B.ADJ_GROSS_RECEIPTS.Attr_TYPE = "C";
    //        bpl.BPT_SCH_B.ADJ_GROSS_RECEIPTS.LENGTH = "15";
    //        bpl.BPT_SCH_B.ADJ_GROSS_RECEIPTS.PERCISION = "8";

    //        bpl.BPT_SCH_B.ADJ_GROSS_PERCENT = new XmlNodeEntity();
    //        bpl.BPT_SCH_B.ADJ_GROSS_PERCENT = "";
    //        bpl.BPT_SCH_B.ADJ_GROSS_PERCENT.Attr_TYPE = "C";
    //        bpl.BPT_SCH_B.ADJ_GROSS_PERCENT.LENGTH = "15";

    //        bpl.BPT_SCH_B.ADJ_TOTAL = new XmlNodeEntity();
    //        bpl.BPT_SCH_B.ADJ_TOTAL = "";
    //        bpl.BPT_SCH_B.ADJ_TOTAL.Attr_TYPE = "C";
    //        bpl.BPT_SCH_B.ADJ_TOTAL.LENGTH = "15";

    //        bpl.BPT_SCH_B.NI_ADJUSTED = new XmlNodeEntity();
    //        bpl.BPT_SCH_B.NI_ADJUSTED = "";
    //        bpl.BPT_SCH_B.NI_ADJUSTED.Attr_TYPE = "C";
    //        bpl.BPT_SCH_B.NI_ADJUSTED.LENGTH = "15";

    //        bpl.BPT_SCH_B.I_NONBUS = new XmlNodeEntity();
    //        bpl.BPT_SCH_B.I_NONBUS = "";
    //        bpl.BPT_SCH_B.I_NONBUS.Attr_TYPE = "C";
    //        bpl.BPT_SCH_B.I_NONBUS.LENGTH = "15";

    //        bpl.BPT_SCH_B.I_APPORTIONED = new XmlNodeEntity();
    //        bpl.BPT_SCH_B.I_APPORTIONED = "";
    //        bpl.BPT_SCH_B.I_APPORTIONED.Attr_TYPE = "C";
    //        bpl.BPT_SCH_B.I_APPORTIONED.LENGTH = "15";

    //        bpl.BPT_SCH_B.I_APPORTIONED_PERCENT = new XmlNodeEntity();
    //        bpl.BPT_SCH_B.I_APPORTIONED_PERCENT = "";
    //        bpl.BPT_SCH_B.I_APPORTIONED_PERCENT.Attr_TYPE = "C";
    //        bpl.BPT_SCH_B.I_APPORTIONED_PERCENT.LENGTH = "15";
    //        bpl.BPT_SCH_B.I_APPORTIONED_PERCENT.PERCISION = "8";

    //        bpl.BPT_SCH_B.I_APPORTIONED_PHILA = new XmlNodeEntity();
    //        bpl.BPT_SCH_B.I_APPORTIONED_PHILA = "";
    //        bpl.BPT_SCH_B.I_APPORTIONED_PHILA.Attr_TYPE = "C";
    //        bpl.BPT_SCH_B.I_APPORTIONED_PHILA.LENGTH = "15";

    //        bpl.BPT_SCH_B.I_NONBUS_PHILA = new XmlNodeEntity();
    //        bpl.BPT_SCH_B.I_NONBUS_PHILA = "";
    //        bpl.BPT_SCH_B.I_NONBUS_PHILA.Attr_TYPE = "C";
    //        bpl.BPT_SCH_B.I_NONBUS_PHILA.LENGTH = "15";

    //        bpl.BPT_SCH_B.I_CURRENT_YEAR = new XmlNodeEntity();
    //        bpl.BPT_SCH_B.I_CURRENT_YEAR = "";
    //        bpl.BPT_SCH_B.I_CURRENT_YEAR.Attr_TYPE = "C";
    //        bpl.BPT_SCH_B.I_CURRENT_YEAR.LENGTH = "15";

    //        bpl.BPT_SCH_B.LOSS_CARRY_FORWARD = new XmlNodeEntity();
    //        bpl.BPT_SCH_B.LOSS_CARRY_FORWARD = "";
    //        bpl.BPT_SCH_B.LOSS_CARRY_FORWARD.Attr_TYPE = "C";
    //        bpl.BPT_SCH_B.LOSS_CARRY_FORWARD.LENGTH = "15";

    //        bpl.BPT_SCH_B.I_TAXABLE = new XmlNodeEntity();
    //        bpl.BPT_SCH_B.I_TAXABLE = "";
    //        bpl.BPT_SCH_B.I_TAXABLE.Attr_TYPE = "C";
    //        bpl.BPT_SCH_B.I_TAXABLE.LENGTH = "15";

    //        bpl.BPT_SCH_B.TAX_DUE = new XmlNodeEntity();
    //        bpl.BPT_SCH_B.TAX_DUE = "";
    //        bpl.BPT_SCH_B.TAX_DUE.Attr_TYPE = "C";
    //        bpl.BPT_SCH_B.TAX_DUE.LENGTH = "15";

    //        //BPT_SCH_C1
    //        bpl.BPT_SCH_C1 = new RTTIE030.BPT_SCH_C1();
    //        bpl.BPT_SCH_C1.Attr_TYPE = "COMPLEX";
    //        bpl.BPT_SCH_C1.OCCURS = "1";
    //        bpl.BPT_SCH_C1.LENGTH = "165";
    //        bpl.BPT_SCH_C1.EXPORT = "Y";

    //        bpl.BPT_SCH_C1.TOTAL_AVG_PHILA = new XmlNodeEntity();
    //        bpl.BPT_SCH_C1.TOTAL_AVG_PHILA = "";
    //        bpl.BPT_SCH_C1.TOTAL_AVG_PHILA.Attr_TYPE = "C";
    //        bpl.BPT_SCH_C1.TOTAL_AVG_PHILA.LENGTH = "15";

    //        bpl.BPT_SCH_C1.TOTAL_AVG_ALL = new XmlNodeEntity();
    //        bpl.BPT_SCH_C1.TOTAL_AVG_ALL = "";
    //        bpl.BPT_SCH_C1.TOTAL_AVG_ALL.Attr_TYPE = "C";
    //        bpl.BPT_SCH_C1.TOTAL_AVG_ALL.LENGTH = "15";

    //        bpl.BPT_SCH_C1.PROPERTY_FACTOR_PHILA = new XmlNodeEntity();
    //        bpl.BPT_SCH_C1.PROPERTY_FACTOR_PHILA = "";
    //        bpl.BPT_SCH_C1.PROPERTY_FACTOR_PHILA.Attr_TYPE = "C";
    //        bpl.BPT_SCH_C1.PROPERTY_FACTOR_PHILA.LENGTH = "15";
    //        bpl.BPT_SCH_C1.PROPERTY_FACTOR_PHILA.LENGTH = "15";
            

    //        bpl.BPT_SCH_C1.PAYROLL_PHILA = new XmlNodeEntity();
    //        bpl.BPT_SCH_C1.PAYROLL_PHILA = "";
    //        bpl.BPT_SCH_C1.PAYROLL_PHILA.Attr_TYPE = "C";
    //        bpl.BPT_SCH_C1.PAYROLL_PHILA.LENGTH = "15";

    //        bpl.BPT_SCH_C1.PAYROLL_ALL = new XmlNodeEntity();
    //        bpl.BPT_SCH_C1.PAYROLL_ALL = "";
    //        bpl.BPT_SCH_C1.PAYROLL_ALL.Attr_TYPE = "C";
    //        bpl.BPT_SCH_C1.PAYROLL_ALL.LENGTH = "15";

    //        bpl.BPT_SCH_C1.PAYROLL_FACTOR_PHILA = new XmlNodeEntity();
    //        bpl.BPT_SCH_C1.PAYROLL_FACTOR_PHILA = "";
    //        bpl.BPT_SCH_C1.PAYROLL_FACTOR_PHILA.Attr_TYPE = "C";
    //        bpl.BPT_SCH_C1.PAYROLL_FACTOR_PHILA.LENGTH = "15";
    //        bpl.BPT_SCH_C1.PAYROLL_FACTOR_PHILA.PERCISION = "6";
            

    //        bpl.BPT_SCH_C1.RECEIPTS_PHILA = new XmlNodeEntity();
    //        bpl.BPT_SCH_C1.RECEIPTS_PHILA = "";
    //        bpl.BPT_SCH_C1.RECEIPTS_PHILA.Attr_TYPE = "C";
    //        bpl.BPT_SCH_C1.RECEIPTS_PHILA.LENGTH = "15";

    //        bpl.BPT_SCH_C1.RECEIPTS_ALL = new XmlNodeEntity();
    //        bpl.BPT_SCH_C1.RECEIPTS_ALL = "";
    //        bpl.BPT_SCH_C1.RECEIPTS_ALL.Attr_TYPE = "C";
    //        bpl.BPT_SCH_C1.RECEIPTS_ALL.LENGTH = "15";

    //        bpl.BPT_SCH_C1.RECEIPTS_FACTOR_PHILA = new XmlNodeEntity();
    //        bpl.BPT_SCH_C1.RECEIPTS_FACTOR_PHILA = "";
    //        bpl.BPT_SCH_C1.RECEIPTS_FACTOR_PHILA.Attr_TYPE = "C";
    //        bpl.BPT_SCH_C1.RECEIPTS_FACTOR_PHILA.LENGTH = "15";
    //        bpl.BPT_SCH_C1.RECEIPTS_FACTOR_PHILA.PERCISION = "6";

    //        bpl.BPT_SCH_C1.TOTAL_FACTORS = new XmlNodeEntity();
    //        bpl.BPT_SCH_C1.TOTAL_FACTORS = "";
    //        bpl.BPT_SCH_C1.TOTAL_FACTORS.Attr_TYPE = "N";
    //        bpl.BPT_SCH_C1.TOTAL_FACTORS.LENGTH = "15";
    //        bpl.BPT_SCH_C1.TOTAL_FACTORS.PERCISION = "6";

    //        bpl.BPT_SCH_C1.AVERAGE_FACTORS = new XmlNodeEntity();
    //        bpl.BPT_SCH_C1.AVERAGE_FACTORS = "";
    //        bpl.BPT_SCH_C1.AVERAGE_FACTORS.Attr_TYPE = "N";
    //        bpl.BPT_SCH_C1.AVERAGE_FACTORS.LENGTH = "15";
    //        bpl.BPT_SCH_C1.AVERAGE_FACTORS.PERCISION = "6";

    //        //BPT_SCH_D
    //        bpl.BPT_SCH_D = new RTTIE030.BPT_SCH_D();
    //        bpl.BPT_SCH_D.Attr_TYPE = "COMPLEX";
    //        bpl.BPT_SCH_D.OCCURS = "1";
    //        bpl.BPT_SCH_D.LENGTH = "210";
    //        bpl.BPT_SCH_D.EXPORT = "Y";

    //        bpl.BPT_SCH_D.GR_SALES = new XmlNodeEntity();
    //        bpl.BPT_SCH_D.GR_SALES = "";
    //        bpl.BPT_SCH_D.GR_SALES.Attr_TYPE = "C";
    //        bpl.BPT_SCH_D.GR_SALES.LENGTH = "15";

    //        bpl.BPT_SCH_D.GR_SERVICES = new XmlNodeEntity();
    //        bpl.BPT_SCH_D.GR_SERVICES = "";
    //        bpl.BPT_SCH_D.GR_SERVICES.Attr_TYPE = "C";
    //        bpl.BPT_SCH_D.GR_SERVICES.LENGTH = "15";

    //        bpl.BPT_SCH_D.GR_RENTALS = new XmlNodeEntity();
    //        bpl.BPT_SCH_D.GR_RENTALS = "";
    //        bpl.BPT_SCH_D.GR_RENTALS.Attr_TYPE = "C";
    //        bpl.BPT_SCH_D.GR_RENTALS.LENGTH = "15";

    //        bpl.BPT_SCH_D.GR_TOTALS = new XmlNodeEntity();
    //        bpl.BPT_SCH_D.GR_TOTALS = "";
    //        bpl.BPT_SCH_D.GR_TOTALS.Attr_TYPE = "C";
    //        bpl.BPT_SCH_D.GR_TOTALS.LENGTH = "15";

    //        bpl.BPT_SCH_D.LE_SALES_OUT = new XmlNodeEntity();
    //        bpl.BPT_SCH_D.LE_SALES_OUT = "";
    //        bpl.BPT_SCH_D.LE_SALES_OUT.Attr_TYPE = "C";
    //        bpl.BPT_SCH_D.LE_SALES_OUT.LENGTH = "15";

    //        bpl.BPT_SCH_D.LE_SERVICES_OUT = new XmlNodeEntity();
    //        bpl.BPT_SCH_D.LE_SERVICES_OUT = "";
    //        bpl.BPT_SCH_D.LE_SERVICES_OUT.Attr_TYPE = "C";
    //        bpl.BPT_SCH_D.LE_SERVICES_OUT.LENGTH = "15";

    //        bpl.BPT_SCH_D.LE_RENTALS_OUT = new XmlNodeEntity();
    //        bpl.BPT_SCH_D.LE_RENTALS_OUT = "";
    //        bpl.BPT_SCH_D.LE_RENTALS_OUT.Attr_TYPE = "C";
    //        bpl.BPT_SCH_D.LE_RENTALS_OUT.LENGTH = "15";

    //        bpl.BPT_SCH_D.LE_OTHER = new XmlNodeEntity();
    //        bpl.BPT_SCH_D.LE_OTHER = "";
    //        bpl.BPT_SCH_D.LE_OTHER.Attr_TYPE = "C";
    //        bpl.BPT_SCH_D.LE_OTHER.LENGTH = "15";

    //        bpl.BPT_SCH_D.NET_TAXABLE_RECEIPTS = new XmlNodeEntity();
    //        bpl.BPT_SCH_D.NET_TAXABLE_RECEIPTS = "";
    //        bpl.BPT_SCH_D.NET_TAXABLE_RECEIPTS.Attr_TYPE = "C";
    //        bpl.BPT_SCH_D.NET_TAXABLE_RECEIPTS.LENGTH = "15";

    //        bpl.BPT_SCH_D.LE_TOTAL = new XmlNodeEntity();
    //        bpl.BPT_SCH_D.LE_TOTAL = "";
    //        bpl.BPT_SCH_D.LE_TOTAL.Attr_TYPE = "C";
    //        bpl.BPT_SCH_D.LE_TOTAL.LENGTH = "15";

    //        bpl.BPT_SCH_D.TAXABLE_RECEIPTS = new XmlNodeEntity();
    //        bpl.BPT_SCH_D.TAXABLE_RECEIPTS = "";
    //        bpl.BPT_SCH_D.TAXABLE_RECEIPTS.Attr_TYPE = "C";
    //        bpl.BPT_SCH_D.TAXABLE_RECEIPTS.LENGTH = "15";

    //        bpl.BPT_SCH_D.TAX_DUE = new XmlNodeEntity();
    //        bpl.BPT_SCH_D.TAX_DUE = "";
    //        bpl.BPT_SCH_D.TAX_DUE.Attr_TYPE = "C";
    //        bpl.BPT_SCH_D.TAX_DUE.LENGTH = "15";

    //        bpl.BPT_SCH_D.TAX_DUE_ALT = new XmlNodeEntity();
    //        bpl.BPT_SCH_D.TAX_DUE_ALT = "";
    //        bpl.BPT_SCH_D.TAX_DUE_ALT.Attr_TYPE = "C";
    //        bpl.BPT_SCH_D.TAX_DUE_ALT.LENGTH = "15";

    //        bpl.BPT_SCH_D.TOTAL_TAX_DUE = new XmlNodeEntity();
    //        bpl.BPT_SCH_D.TOTAL_TAX_DUE = "";
    //        bpl.BPT_SCH_D.TOTAL_TAX_DUE.Attr_TYPE = "C";
    //        bpl.BPT_SCH_D.TOTAL_TAX_DUE.LENGTH = "15";

    //        //BPT_SCH_E
    //        bpl.BPT_SCH_E = new RTTIE030.BPT_SCH_E();
    //        bpl.BPT_SCH_E.Attr_TYPE = "COMPLEX";
    //        bpl.BPT_SCH_E.OCCURS = "1";
    //        bpl.BPT_SCH_E.LENGTH = "255";
    //        bpl.BPT_SCH_E.EXPORT = "Y";

    //        bpl.BPT_SCH_E.M_ALT_RECEIPTS = new XmlNodeEntity();
    //        bpl.BPT_SCH_E.M_ALT_RECEIPTS = "";
    //        bpl.BPT_SCH_E.M_ALT_RECEIPTS.Attr_TYPE = "C";
    //        bpl.BPT_SCH_E.M_ALT_RECEIPTS.LENGTH = "15";

    //        bpl.BPT_SCH_E.M_GOODS_COST = new XmlNodeEntity();
    //        bpl.BPT_SCH_E.M_GOODS_COST = "";
    //        bpl.BPT_SCH_E.M_GOODS_COST.Attr_TYPE = "C";
    //        bpl.BPT_SCH_E.M_GOODS_COST.LENGTH = "15";

    //        bpl.BPT_SCH_E.M_TAX_BASE = new XmlNodeEntity();
    //        bpl.BPT_SCH_E.M_TAX_BASE = "";
    //        bpl.BPT_SCH_E.M_TAX_BASE.Attr_TYPE = "C";
    //        bpl.BPT_SCH_E.M_TAX_BASE.LENGTH = "15";

    //        bpl.BPT_SCH_E.M_TAX_DUE = new XmlNodeEntity();
    //        bpl.BPT_SCH_E.M_TAX_DUE = "";
    //        bpl.BPT_SCH_E.M_TAX_DUE.Attr_TYPE = "C";
    //        bpl.BPT_SCH_E.M_TAX_DUE.LENGTH = "15";

    //        bpl.BPT_SCH_E.W_ALT_RECEIPTS = new XmlNodeEntity();
    //        bpl.BPT_SCH_E.W_ALT_RECEIPTS = "";
    //        bpl.BPT_SCH_E.W_ALT_RECEIPTS.Attr_TYPE = "C";
    //        bpl.BPT_SCH_E.W_ALT_RECEIPTS.LENGTH = "15";

    //        bpl.BPT_SCH_E.W_GOODS_MATERIALS = new XmlNodeEntity();
    //        bpl.BPT_SCH_E.W_GOODS_MATERIALS = "";
    //        bpl.BPT_SCH_E.W_GOODS_MATERIALS.Attr_TYPE = "C";
    //        bpl.BPT_SCH_E.W_GOODS_MATERIALS.LENGTH = "15";

    //        bpl.BPT_SCH_E.W_GOODS_LABOR = new XmlNodeEntity();
    //        bpl.BPT_SCH_E.W_GOODS_LABOR = "";
    //        bpl.BPT_SCH_E.W_GOODS_LABOR.Attr_TYPE = "C";
    //        bpl.BPT_SCH_E.W_GOODS_LABOR.LENGTH = "15";

    //        bpl.BPT_SCH_E.W_GOODS_COST = new XmlNodeEntity();
    //        bpl.BPT_SCH_E.W_GOODS_COST = "";
    //        bpl.BPT_SCH_E.W_GOODS_COST.Attr_TYPE = "C";
    //        bpl.BPT_SCH_E.W_GOODS_COST.LENGTH = "15";

    //        bpl.BPT_SCH_E.W_TAX_BASE = new XmlNodeEntity();
    //        bpl.BPT_SCH_E.W_TAX_BASE = "";
    //        bpl.BPT_SCH_E.W_TAX_BASE.Attr_TYPE = "C";
    //        bpl.BPT_SCH_E.W_TAX_BASE.LENGTH = "15";

    //        bpl.BPT_SCH_E.W_TAX_DUE = new XmlNodeEntity();
    //        bpl.BPT_SCH_E.W_TAX_DUE = "";
    //        bpl.BPT_SCH_E.W_TAX_DUE.Attr_TYPE = "C";
    //        bpl.BPT_SCH_E.W_TAX_DUE.LENGTH = "15";

    //        bpl.BPT_SCH_E.R_ALT_RECEIPTS = new XmlNodeEntity();
    //        bpl.BPT_SCH_E.R_ALT_RECEIPTS = "";
    //        bpl.BPT_SCH_E.R_ALT_RECEIPTS.Attr_TYPE = "C";
    //        bpl.BPT_SCH_E.R_ALT_RECEIPTS.LENGTH = "15";

    //        bpl.BPT_SCH_E.R_GOODS_MATERIALS = new XmlNodeEntity();
    //        bpl.BPT_SCH_E.R_GOODS_MATERIALS = "";
    //        bpl.BPT_SCH_E.R_GOODS_MATERIALS.Attr_TYPE = "C";
    //        bpl.BPT_SCH_E.R_GOODS_MATERIALS.LENGTH = "15";

    //        bpl.BPT_SCH_E.R_GOODS_LABOR = new XmlNodeEntity();
    //        bpl.BPT_SCH_E.R_GOODS_LABOR = "";
    //        bpl.BPT_SCH_E.R_GOODS_LABOR.Attr_TYPE = "C";
    //        bpl.BPT_SCH_E.R_GOODS_LABOR.LENGTH = "15";

    //        bpl.BPT_SCH_E.R_GOODS_COST = new XmlNodeEntity();
    //        bpl.BPT_SCH_E.R_GOODS_COST = "";
    //        bpl.BPT_SCH_E.R_GOODS_COST.Attr_TYPE = "C";
    //        bpl.BPT_SCH_E.R_GOODS_COST.LENGTH = "15";

    //        bpl.BPT_SCH_E.R_TAX_BASE = new XmlNodeEntity();
    //        bpl.BPT_SCH_E.R_TAX_BASE = "";
    //        bpl.BPT_SCH_E.R_TAX_BASE.Attr_TYPE = "C";
    //        bpl.BPT_SCH_E.R_TAX_BASE.LENGTH = "15";

    //        bpl.BPT_SCH_E.R_TAX_DUE = new XmlNodeEntity();
    //        bpl.BPT_SCH_E.R_TAX_DUE = "";
    //        bpl.BPT_SCH_E.R_TAX_DUE.Attr_TYPE = "C";
    //        bpl.BPT_SCH_E.R_TAX_DUE.LENGTH = "15";

    //        bpl.BPT_SCH_E.TOTAL_TAX_DUE = new XmlNodeEntity();
    //        bpl.BPT_SCH_E.TOTAL_TAX_DUE = "";
    //        bpl.BPT_SCH_E.TOTAL_TAX_DUE.Attr_TYPE = "C";
    //        bpl.BPT_SCH_E.TOTAL_TAX_DUE.LENGTH = "15";

    //        //BPT_TBL_C1
    //        bpl.BPT_TBL_C1 = new RTTIE030.BPT_TBL_C1();
    //        bpl.BPT_TBL_C1.Attr_TYPE = "COMPLEX";
    //        bpl.BPT_TBL_C1.OCCURS = "1";
    //        bpl.BPT_TBL_C1.LENGTH = "315";
    //        bpl.BPT_TBL_C1.EXPORT = "Y";

    //        bpl.BPT_TBL_C1.INVENTORIES_PHILA = new XmlNodeEntity();
    //        bpl.BPT_TBL_C1.INVENTORIES_PHILA = "";
    //        bpl.BPT_TBL_C1.INVENTORIES_PHILA.Attr_TYPE = "C";
    //        bpl.BPT_TBL_C1.INVENTORIES_PHILA.LENGTH = "15";

    //        bpl.BPT_TBL_C1.INVENTORIES_ALL = new XmlNodeEntity();
    //        bpl.BPT_TBL_C1.INVENTORIES_ALL = "";
    //        bpl.BPT_TBL_C1.INVENTORIES_ALL.Attr_TYPE = "C";
    //        bpl.BPT_TBL_C1.INVENTORIES_ALL.LENGTH = "15";

    //        bpl.BPT_TBL_C1.LAND_BLDGS_PHILA = new XmlNodeEntity();
    //        bpl.BPT_TBL_C1.LAND_BLDGS_PHILA = "";
    //        bpl.BPT_TBL_C1.LAND_BLDGS_PHILA.Attr_TYPE = "C";
    //        bpl.BPT_TBL_C1.LAND_BLDGS_PHILA.LENGTH = "15";

    //        bpl.BPT_TBL_C1.LAND_BLDGS_ALL = new XmlNodeEntity();
    //        bpl.BPT_TBL_C1.LAND_BLDGS_ALL = "";
    //        bpl.BPT_TBL_C1.LAND_BLDGS_ALL.Attr_TYPE = "C";
    //        bpl.BPT_TBL_C1.LAND_BLDGS_ALL.LENGTH = "15";

    //        bpl.BPT_TBL_C1.MACHINERY_PHILA = new XmlNodeEntity();
    //        bpl.BPT_TBL_C1.MACHINERY_PHILA = "";
    //        bpl.BPT_TBL_C1.MACHINERY_PHILA.Attr_TYPE = "C";
    //        bpl.BPT_TBL_C1.MACHINERY_PHILA.LENGTH = "15";

    //        bpl.BPT_TBL_C1.MACHINERY_ALL = new XmlNodeEntity();
    //        bpl.BPT_TBL_C1.MACHINERY_ALL = "";
    //        bpl.BPT_TBL_C1.MACHINERY_ALL.Attr_TYPE = "C";
    //        bpl.BPT_TBL_C1.MACHINERY_ALL.LENGTH = "15";

    //        bpl.BPT_TBL_C1.OTHER_ASSESTS_PHILA = new XmlNodeEntity();
    //        bpl.BPT_TBL_C1.OTHER_ASSESTS_PHILA = "";
    //        bpl.BPT_TBL_C1.OTHER_ASSESTS_PHILA.Attr_TYPE = "C";
    //        bpl.BPT_TBL_C1.OTHER_ASSESTS_PHILA.LENGTH = "15";

    //        bpl.BPT_TBL_C1.RENTED_PROPERTY_PHILA = new XmlNodeEntity();
    //        bpl.BPT_TBL_C1.RENTED_PROPERTY_PHILA = "";
    //        bpl.BPT_TBL_C1.RENTED_PROPERTY_PHILA.Attr_TYPE = "C";
    //        bpl.BPT_TBL_C1.RENTED_PROPERTY_PHILA.LENGTH = "15";

    //        bpl.BPT_TBL_C1.RENTED_PROPERTY_ALL = new XmlNodeEntity();
    //        bpl.BPT_TBL_C1.RENTED_PROPERTY_ALL = "";
    //        bpl.BPT_TBL_C1.RENTED_PROPERTY_ALL.Attr_TYPE = "C";
    //        bpl.BPT_TBL_C1.RENTED_PROPERTY_ALL.LENGTH = "15";

    //        bpl.BPT_TBL_C1.TOTAL_AVG_PHILA = new XmlNodeEntity();
    //        bpl.BPT_TBL_C1.TOTAL_AVG_PHILA = "";
    //        bpl.BPT_TBL_C1.TOTAL_AVG_PHILA.Attr_TYPE = "C";
    //        bpl.BPT_TBL_C1.TOTAL_AVG_PHILA.LENGTH = "15";

    //        bpl.BPT_TBL_C1.TOTAL_AVG_ALL = new XmlNodeEntity();
    //        bpl.BPT_TBL_C1.TOTAL_AVG_ALL = "";
    //        bpl.BPT_TBL_C1.TOTAL_AVG_ALL.Attr_TYPE = "C";
    //        bpl.BPT_TBL_C1.TOTAL_AVG_ALL.LENGTH = "15";

    //        return bpl;
        
    //}

        //public static RTTIE031.LossCarryForward GetLossCarryForwardReturn()
        //{
        //    RTTIE031.LossCarryForward lcf = new RTTIE031.LossCarryForward();

        //    //Errorinfo
        //    lcf.ERROR_INFO = new ERROR_INFO();
        //    lcf.ERROR_INFO.Attr_TYPE = "COMPLEX";
        //    lcf.ERROR_INFO.OCCURS = "1";
        //    lcf.ERROR_INFO.LENGTH = "79";
        //    lcf.ERROR_INFO.EXPORT = "N";

        //    lcf.ERROR_INFO.PROGRAM = new XmlNodeEntity();
        //    lcf.ERROR_INFO.PROGRAM = "";
        //    lcf.ERROR_INFO.PROGRAM.Attr_TYPE = "A";
        //    lcf.ERROR_INFO.PROGRAM.LENGTH = "12";

        //    lcf.ERROR_INFO.ERROR = new XmlNodeEntity();
        //    lcf.ERROR_INFO.ERROR = "";
        //    lcf.ERROR_INFO.ERROR.Attr_TYPE = "N";
        //    lcf.ERROR_INFO.ERROR.LENGTH = "7";

        //    lcf.ERROR_INFO.LINE = new XmlNodeEntity();
        //    lcf.ERROR_INFO.LINE = "";
        //    lcf.ERROR_INFO.LINE.Attr_TYPE = "N";
        //    lcf.ERROR_INFO.LINE.LENGTH = "4";

        //    lcf.ERROR_INFO.MESSAGE = new XmlNodeEntity();
        //    lcf.ERROR_INFO.MESSAGE = "";
        //    lcf.ERROR_INFO.MESSAGE.Attr_TYPE = "A";
        //    lcf.ERROR_INFO.MESSAGE.LENGTH = "60";

        //    //lcf_INFO
        //    lcf.LCF_INFO = new RTTIE031.LCF_INFO();
        //    lcf.LCF_INFO.Attr_TYPE = "COMPLEX";
        //    lcf.LCF_INFO.OCCURS = "1";
        //    lcf.LCF_INFO.LENGTH = "203";
        //    lcf.LCF_INFO.EXPORT = "Y";


        //    lcf.LCF_INFO.ACCOUNT_ID = new XmlNodeEntity();
        //    lcf.LCF_INFO.ACCOUNT_ID = "";
        //    lcf.LCF_INFO.ACCOUNT_ID.Attr_TYPE = "A";
        //    lcf.LCF_INFO.ACCOUNT_ID.LENGTH = "12";

        //    lcf.LCF_INFO.YEAR_X = new XmlNodeEntity();
        //    lcf.LCF_INFO.YEAR_X = "";
        //    lcf.LCF_INFO.YEAR_X.Attr_TYPE = "A";
        //    lcf.LCF_INFO.YEAR_X.LENGTH = "4";

        //    lcf.LCF_INFO.EST_PAID_X = new XmlNodeEntity();
        //    lcf.LCF_INFO.EST_PAID_X = "";
        //    lcf.LCF_INFO.EST_PAID_X.Attr_TYPE = "C";
        //    lcf.LCF_INFO.EST_PAID_X.LENGTH = "11";

        //    lcf.LCF_INFO.YEAR = new XmlNodeEntity();
        //    lcf.LCF_INFO.YEAR = "";
        //    lcf.LCF_INFO.YEAR.Attr_TYPE = "A";
        //    lcf.LCF_INFO.YEAR.LENGTH = "4";

        //    lcf.LCF_INFO.AMOUNT = new XmlNodeEntity();
        //    lcf.LCF_INFO.AMOUNT = "";
        //    lcf.LCF_INFO.AMOUNT.Attr_TYPE = "C";
        //    lcf.LCF_INFO.AMOUNT.LENGTH = "15";

        //    lcf.LCF_INFO.COMMENT = new XmlNodeEntity();
        //    lcf.LCF_INFO.COMMENT = "";
        //    lcf.LCF_INFO.COMMENT.Attr_TYPE = "A";
        //    lcf.LCF_INFO.COMMENT.LENGTH = "25";

        //    lcf.LCF_INFO.YEAR_1 = new XmlNodeEntity();
        //    lcf.LCF_INFO.YEAR_1 = "";
        //    lcf.LCF_INFO.YEAR_1.Attr_TYPE = "A";
        //    lcf.LCF_INFO.YEAR_1.LENGTH = "4";

        //    lcf.LCF_INFO.INCOME_1 = new XmlNodeEntity();
        //    lcf.LCF_INFO.INCOME_1 = "";
        //    lcf.LCF_INFO.INCOME_1.Attr_TYPE = "C";
        //    lcf.LCF_INFO.INCOME_1.LENGTH = "15";

        //    lcf.LCF_INFO.COMMENT_1 = new XmlNodeEntity();
        //    lcf.LCF_INFO.COMMENT_1 = "";
        //    lcf.LCF_INFO.COMMENT_1.Attr_TYPE = "A";
        //    lcf.LCF_INFO.COMMENT_1.LENGTH = "25";

        //    lcf.LCF_INFO.YEAR_2 = new XmlNodeEntity();
        //    lcf.LCF_INFO.YEAR_2 = "";
        //    lcf.LCF_INFO.YEAR_2.Attr_TYPE = "A";
        //    lcf.LCF_INFO.YEAR_2.LENGTH = "4";

        //    lcf.LCF_INFO.INCOME_2 = new XmlNodeEntity();
        //    lcf.LCF_INFO.INCOME_2 = "";
        //    lcf.LCF_INFO.INCOME_2.Attr_TYPE = "C";
        //    lcf.LCF_INFO.INCOME_2.LENGTH = "15";

        //    lcf.LCF_INFO.COMMENT_2 = new XmlNodeEntity();
        //    lcf.LCF_INFO.COMMENT_2 = "";
        //    lcf.LCF_INFO.COMMENT_2.Attr_TYPE = "A";
        //    lcf.LCF_INFO.COMMENT_2.LENGTH = "25";

        //    lcf.LCF_INFO.YEAR_3 = new XmlNodeEntity();
        //    lcf.LCF_INFO.YEAR_3 = "";
        //    lcf.LCF_INFO.YEAR_3.Attr_TYPE = "A";
        //    lcf.LCF_INFO.YEAR_3.LENGTH = "4";

        //    lcf.LCF_INFO.INCOME_3 = new XmlNodeEntity();
        //    lcf.LCF_INFO.INCOME_3 = "";
        //    lcf.LCF_INFO.INCOME_3.Attr_TYPE = "C";
        //    lcf.LCF_INFO.INCOME_3.LENGTH = "15";

        //    lcf.LCF_INFO.COMMENT_3 = new XmlNodeEntity();
        //    lcf.LCF_INFO.COMMENT_3 = "";
        //    lcf.LCF_INFO.COMMENT_3.Attr_TYPE = "A";
        //    lcf.LCF_INFO.COMMENT_3.LENGTH = "25";

        //    //HEADER_INFO
        //    lcf.HEADER_INFO = new HEADER_INFO();
        //    lcf.HEADER_INFO.ENVIRONMENT = "";

        //    //DEBUG
        //    lcf.DEBUG = new DEBUG();

        //    return lcf;
        //}

        //public static RTTIE034.UOLIST GetUOLISTReturn()
        //{
        //    RTTIE034.UOLIST uo = new RTTIE034.UOLIST();

        //    //Errorinfo
        //    uo.ERROR_INFO = new ERROR_INFO();
        //    uo.ERROR_INFO.Attr_TYPE = "COMPLEX";
        //    uo.ERROR_INFO.OCCURS = "1";
        //    uo.ERROR_INFO.LENGTH = "79";
        //    uo.ERROR_INFO.EXPORT = "N";

        //    uo.ERROR_INFO.PROGRAM = new XmlNodeEntity();
        //    uo.ERROR_INFO.PROGRAM = "";
        //    uo.ERROR_INFO.PROGRAM.Attr_TYPE = "A";
        //    uo.ERROR_INFO.PROGRAM.LENGTH = "8";

        //    uo.ERROR_INFO.ERROR = new XmlNodeEntity();
        //    uo.ERROR_INFO.ERROR = "";
        //    uo.ERROR_INFO.ERROR.Attr_TYPE = "N";
        //    uo.ERROR_INFO.ERROR.LENGTH = "7";

        //    uo.ERROR_INFO.LINE = new XmlNodeEntity();
        //    uo.ERROR_INFO.LINE = "";
        //    uo.ERROR_INFO.LINE.Attr_TYPE = "N";
        //    uo.ERROR_INFO.LINE.LENGTH = "4";

        //    uo.ERROR_INFO.MESSAGE = new XmlNodeEntity();
        //    uo.ERROR_INFO.MESSAGE = "";
        //    uo.ERROR_INFO.MESSAGE.Attr_TYPE = "A";
        //    uo.ERROR_INFO.MESSAGE.LENGTH = "60";

        //    //uo_INFO
        //    uo.UO_INFO = new RTTIE034.UO_INFO();
        //    uo.UO_INFO.Attr_TYPE = "COMPLEX";
        //    uo.UO_INFO.OCCURS = "1";
        //    uo.UO_INFO.LENGTH = "23";
        //    uo.UO_INFO.EXPORT = "Y";

        //    uo.UO_INFO.ENTITY_ID = new XmlNodeEntity();
        //    uo.UO_INFO.ENTITY_ID = "";
        //    uo.UO_INFO.ENTITY_ID.Attr_TYPE = "A";
        //    uo.UO_INFO.ENTITY_ID.LENGTH = "11";

        //    uo.UO_INFO.ACCOUNT_ID = new XmlNodeEntity();
        //    uo.UO_INFO.ACCOUNT_ID = "";
        //    uo.UO_INFO.ACCOUNT_ID.Attr_TYPE = "A";
        //    uo.UO_INFO.ACCOUNT_ID.LENGTH = "12";


        //    //UO_ACCT
        //    uo.UO_ACCT = new List<RTTIE034.UO_ACCT>();
        //    foreach (RTTIE034.UO_ACCT ua in uo.UO_ACCT)
        //    {           
        //        ua.Attr_TYPE = "COMPLEX";
        //        ua.OCCURS = "200";
        //        ua.LENGTH = "77";
        //        ua.EXPORT = "Y";
               
        //        ua.ACCOUNT_ID = "";
        //        ua.ACCOUNT_ID.Attr_TYPE = "A";
        //        ua.ACCOUNT_ID.LENGTH = "12";
              
        //        ua.BRT_NUMBER.Attr_TYPE = "A";
        //        ua.BRT_NUMBER.LENGTH = "9";
              
        //        ua.LOCATION.Attr_TYPE = "A";
        //        ua.LOCATION.LENGTH = "30";

             
        //        ua.START_DATE.Attr_TYPE = "D";
        //        ua.START_DATE.LENGTH = "8";
          
        //        ua.END_DATE.Attr_TYPE = "D";
        //        ua.END_DATE.LENGTH = "8";
             
        //        ua.FREQ_YEAR0.Attr_TYPE = "A";
        //        ua.FREQ_YEAR0.LENGTH = "1";

        //        ua.FREQ_YEAR1.Attr_TYPE = "A";
        //        ua.FREQ_YEAR1.LENGTH = "1";

        //        ua.FREQ_YEAR2.Attr_TYPE = "A";
        //        ua.FREQ_YEAR2.LENGTH = "1";

        //        ua.FREQ_YEAR3.Attr_TYPE = "A";
        //        ua.FREQ_YEAR3.LENGTH = "1";

        //        ua.FREQ_YEAR4.Attr_TYPE = "A";
        //        ua.FREQ_YEAR4.LENGTH = "1";

        //        ua.FREQ_YEAR5.Attr_TYPE = "A";
        //        ua.FREQ_YEAR5.LENGTH = "1";

        //        ua.FREQ_YEAR6.Attr_TYPE = "A";
        //        ua.FREQ_YEAR6.LENGTH = "1";

        //        ua.FREQ_YEAR7.Attr_TYPE = "A";
        //        ua.FREQ_YEAR7.LENGTH = "1";

        //        ua.FREQ_YEAR8.Attr_TYPE = "A";
        //        ua.FREQ_YEAR8.LENGTH = "1";

        //        ua.FREQ_YEAR9.Attr_TYPE = "A";
        //        ua.FREQ_YEAR9.LENGTH = "1";
        //    }

  



        //    //HEADER_INFO
        //    uo.HEADER_INFO = new HEADER_INFO();
        //    uo.HEADER_INFO.ENVIRONMENT = "";

        //    //DEBUG
        //    uo.DEBUG = new DEBUG();

        //    return uo;
        //}

        //public static RTTIE035.UOFORM GetUOFORMReturn()
        //{
        //    RTTIE035.UOFORM uo = new RTTIE035.UOFORM();

        //    //Errorinfo
        //    uo.ERROR_INFO = new ERROR_INFO();
        //    uo.ERROR_INFO.Attr_TYPE = "COMPLEX";
        //    uo.ERROR_INFO.OCCURS = "1";
        //    uo.ERROR_INFO.LENGTH = "79";
        //    uo.ERROR_INFO.EXPORT = "N";

        //    uo.ERROR_INFO.PROGRAM = new XmlNodeEntity();
        //    uo.ERROR_INFO.PROGRAM = "";
        //    uo.ERROR_INFO.PROGRAM.Attr_TYPE = "A";
        //    uo.ERROR_INFO.PROGRAM.LENGTH = "8";

        //    uo.ERROR_INFO.ERROR = new XmlNodeEntity();
        //    uo.ERROR_INFO.ERROR = "";
        //    uo.ERROR_INFO.ERROR.Attr_TYPE = "N";
        //    uo.ERROR_INFO.ERROR.LENGTH = "7";

        //    uo.ERROR_INFO.LINE = new XmlNodeEntity();
        //    uo.ERROR_INFO.LINE = "";
        //    uo.ERROR_INFO.LINE.Attr_TYPE = "N";
        //    uo.ERROR_INFO.LINE.LENGTH = "4";

        //    uo.ERROR_INFO.MESSAGE = new XmlNodeEntity();
        //    uo.ERROR_INFO.MESSAGE = "";
        //    uo.ERROR_INFO.MESSAGE.Attr_TYPE = "A";
        //    uo.ERROR_INFO.MESSAGE.LENGTH = "60";

        //    //UO_ACCT
        //    uo.UO_ACCT = new RTTIE035.UO_ACCT();

        //    uo.UO_ACCT.Attr_TYPE = "COMPLEX";
        //    uo.UO_ACCT.OCCURS = "1";
        //    uo.UO_ACCT.EXPORT = "Y";

        //    uo.UO_ACCT.ACCOUNT_ID = "";
        //    uo.UO_ACCT.ACCOUNT_ID.Attr_TYPE = "A";
        //    uo.UO_ACCT.ACCOUNT_ID.LENGTH = "12";

        //    uo.UO_ACCT.PERIOD.Attr_TYPE = "A";
        //    uo.UO_ACCT.PERIOD.LENGTH = "8";

        //    uo.UO_ACCT.VERSION.Attr_TYPE = "A";
        //    uo.UO_ACCT.VERSION.LENGTH = "3";

        //    uo.UO_ACCT.RETURN_STATUS.Attr_TYPE = "D";
        //    uo.UO_ACCT.RETURN_STATUS.LENGTH = "3";

        //    uo.UO_ACCT.LAST_UPD_DATE.Attr_TYPE = "A";
        //    uo.UO_ACCT.LAST_UPD_DATE.LENGTH = "8";

        //    uo.UO_ACCT.USER_ID.Attr_TYPE = "A";
        //    uo.UO_ACCT.USER_ID.LENGTH = "8";

        //    uo.UO_ACCT.RECORDING_DATE.Attr_TYPE = "D";
        //    uo.UO_ACCT.RECORDING_DATE.LENGTH = "8";

        //    uo.UO_ACCT.SEQUENCE.Attr_TYPE = "A";
        //    uo.UO_ACCT.SEQUENCE.LENGTH = "5";

        //    uo.UO_ACCT.ADJUSTMENT_REF_NO.Attr_TYPE = "A";
        //    uo.UO_ACCT.ADJUSTMENT_REF_NO.LENGTH = "10";

        //    uo.UO_ACCT.RATE.Attr_TYPE = "N";
        //    uo.UO_ACCT.RATE.LENGTH = "9";

        //    uo.UO_ACCT.BRT_NUMBER.Attr_TYPE = "A";
        //    uo.UO_ACCT.BRT_NUMBER.LENGTH = "9";

        //    uo.UO_ACCT.LOCATION.Attr_TYPE = "A";
        //    uo.UO_ACCT.LOCATION.LENGTH = "30";

        //    uo.UO_ACCT.DUE_DATE.Attr_TYPE = "D";
        //    uo.UO_ACCT.DUE_DATE.LENGTH = "8";

        //    uo.UO_ACCT.ASSESSED_VALUE.Attr_TYPE = "C";
        //    uo.UO_ACCT.ASSESSED_VALUE.LENGTH = "15";
        //    uo.UO_ACCT.ASSESSED_VALUE.PERCISION = "2";

        //    uo.UO_ACCT.FREQUENCY.Attr_TYPE = "A";
        //    uo.UO_ACCT.FREQUENCY.LENGTH = "1";

        //    uo.UO_ACCT.PERIOD_CODE.Attr_TYPE = "A";
        //    uo.UO_ACCT.PERIOD_CODE.LENGTH = "2";

        //    uo.UO_ACCT.PERIOD_YY.Attr_TYPE = "A";
        //    uo.UO_ACCT.PERIOD_YY.LENGTH = "2";

        //    uo.UO_ACCT.PREPARER_NAME.Attr_TYPE = "A";
        //    uo.UO_ACCT.PREPARER_NAME.LENGTH = "40";

        //    uo.UO_ACCT.PREPARER_PHONE.Attr_TYPE = "P";
        //    uo.UO_ACCT.PREPARER_PHONE.LENGTH = "10";

        //    uo.UO_ACCT.PREPARER_PHONE_EXT.Attr_TYPE = "A";
        //    uo.UO_ACCT.PREPARER_PHONE_EXT.LENGTH = "5";

        //    uo.UO_ACCT.PREPARER_IP_ADDRESS.Attr_TYPE = "A";
        //    uo.UO_ACCT.PREPARER_IP_ADDRESS.LENGTH = "15";

        //    uo.UO_ACCT.PREPARER_EMAIL_ADDRESS.Attr_TYPE = "A";
        //    uo.UO_ACCT.PREPARER_EMAIL_ADDRESS.LENGTH = "60";

        //    uo.UO_ACCT.PREPARER_WHO.Attr_TYPE = "A";
        //    uo.UO_ACCT.PREPARER_WHO.LENGTH = "1";

        //    //UO_AMTS
        //    uo.UO_AMTS = new RTTIE035.UO_AMTS();

        //    uo.UO_AMTS.Attr_TYPE = "COMPLEX";
        //    uo.UO_AMTS.OCCURS = "1";
        //    uo.UO_AMTS.EXPORT = "Y";

        //    uo.UO_AMTS.MAX_TAX = "";
        //    uo.UO_AMTS.MAX_TAX.Attr_TYPE = "A";
        //    uo.UO_AMTS.MAX_TAX.LENGTH = "12";

        //    uo.UO_AMTS.VACANCY.Attr_TYPE = "A";
        //    uo.UO_AMTS.VACANCY.LENGTH = "8";

        //    uo.UO_AMTS.EXEMPT.Attr_TYPE = "A";
        //    uo.UO_AMTS.EXEMPT.LENGTH = "3";

        //    uo.UO_AMTS.RESIDENTIAL.Attr_TYPE = "D";
        //    uo.UO_AMTS.RESIDENTIAL.LENGTH = "3";

        //    uo.UO_AMTS.DELINQUENT.Attr_TYPE = "A";
        //    uo.UO_AMTS.DELINQUENT.LENGTH = "8";

        //    uo.UO_AMTS.KOZ_CREDIT.Attr_TYPE = "A";
        //    uo.UO_AMTS.KOZ_CREDIT.LENGTH = "8";

        //    uo.UO_AMTS.TOTAL_DEDUCTIONS.Attr_TYPE = "D";
        //    uo.UO_AMTS.TOTAL_DEDUCTIONS.LENGTH = "8";

        //    uo.UO_AMTS.PERIOD_TAX.Attr_TYPE = "A";
        //    uo.UO_AMTS.PERIOD_TAX.LENGTH = "5";

        //    uo.UO_AMTS.DISCOUNT.Attr_TYPE = "A";
        //    uo.UO_AMTS.DISCOUNT.LENGTH = "10";

        //    uo.UO_AMTS.TAX_DUE.Attr_TYPE = "N";
        //    uo.UO_AMTS.TAX_DUE.LENGTH = "9";

        //    uo.UO_AMTS.INTEREST_PENALTY.Attr_TYPE = "A";
        //    uo.UO_AMTS.INTEREST_PENALTY.LENGTH = "9";

        //    uo.UO_AMTS.TOTAL_DUE.Attr_TYPE = "A";
        //    uo.UO_AMTS.TOTAL_DUE.LENGTH = "30";

        //    uo.UO_AMTS.DELINQUENT_TENANT_COUNT.Attr_TYPE = "D";
        //    uo.UO_AMTS.DELINQUENT_TENANT_COUNT.LENGTH = "8";

        //    //UO_AMTS
        //    uo.UO3_PAGE = new List<RTTIE035.UO3_PAGE>();
        //    uo.UO3_PAGE.Add(new RTTIE035.UO3_PAGE());

        //    foreach (RTTIE035.UO3_PAGE ua in uo.UO3_PAGE)
        //    {
        //        ua.Attr_TYPE = "COMPLEX";
        //        ua.OCCURS = "10";
        //        ua.LENGTH = "80";
        //        ua.EXPORT = "Y";

        //        ua.PROCESS_CODE = "";
        //        ua.PROCESS_CODE.Attr_TYPE = "A";
        //        ua.PROCESS_CODE.LENGTH = "2";

        //        ua.TENANT_NAME = "";
        //        ua.TENANT_NAME.Attr_TYPE = "A";
        //        ua.TENANT_NAME.LENGTH = "40";

        //        ua.TENANT_ID = "";
        //        ua.TENANT_ID.Attr_TYPE = "A";
        //        ua.TENANT_ID.LENGTH = "11";

        //        ua.ACCOUNT_ID = "";
        //        ua.ACCOUNT_ID.Attr_TYPE = "A";
        //        ua.ACCOUNT_ID.LENGTH = "12";

        //        ua.AMOUNT = "";
        //        ua.AMOUNT.Attr_TYPE = "C";
        //        ua.AMOUNT.LENGTH = "15";                
        //    }


        //    //HEADER_INFO
        //    uo.HEADER_INFO = new HEADER_INFO();
        //    uo.HEADER_INFO.ENVIRONMENT = "";

        //    //DEBUG
        //    uo.DEBUG = new DEBUG();

        //    return uo;
        //}

        //public static RTTIE028.TOBACCORETURN GetTOBACCORETURN()
        //{
        //    RTTIE028.TOBACCORETURN tb = new RTTIE028.TOBACCORETURN();

        //    //Errorinfo
        //    tb.ERROR_INFO = new ERROR_INFO();
        //    tb.ERROR_INFO.Attr_TYPE = "COMPLEX";
        //    tb.ERROR_INFO.OCCURS = "1";
        //    tb.ERROR_INFO.LENGTH = "79";
        //    tb.ERROR_INFO.EXPORT = "N";

        //    tb.ERROR_INFO.PROGRAM = new XmlNodeEntity();
        //    tb.ERROR_INFO.PROGRAM = "";
        //    tb.ERROR_INFO.PROGRAM.Attr_TYPE = "A";
        //    tb.ERROR_INFO.PROGRAM.LENGTH = "8";

        //    tb.ERROR_INFO.ERROR = new XmlNodeEntity();
        //    tb.ERROR_INFO.ERROR = "";
        //    tb.ERROR_INFO.ERROR.Attr_TYPE = "N";
        //    tb.ERROR_INFO.ERROR.LENGTH = "7";

        //    tb.ERROR_INFO.LINE = new XmlNodeEntity();
        //    tb.ERROR_INFO.LINE = "";
        //    tb.ERROR_INFO.LINE.Attr_TYPE = "N";
        //    tb.ERROR_INFO.LINE.LENGTH = "4";

        //    tb.ERROR_INFO.MESSAGE = new XmlNodeEntity();
        //    tb.ERROR_INFO.MESSAGE = "";
        //    tb.ERROR_INFO.MESSAGE.Attr_TYPE = "A";
        //    tb.ERROR_INFO.MESSAGE.LENGTH = "60";

        //    //TOBACCO_INFO
        //    tb.TOBACCO_INFO = new RTTIE028.TOBACCO_INFO();
        //    tb.TOBACCO_INFO.Attr_TYPE = "COMPLEX";
        //    tb.TOBACCO_INFO.OCCURS = "1";
        //    tb.TOBACCO_INFO.LENGTH = "223";
        //    tb.TOBACCO_INFO.EXPORT = "Y";


        //    tb.TOBACCO_INFO.ACCOUNT_ID = new XmlNodeEntity();
        //    tb.TOBACCO_INFO.ACCOUNT_ID = "";
        //    tb.TOBACCO_INFO.ACCOUNT_ID.Attr_TYPE = "A";
        //    tb.TOBACCO_INFO.ACCOUNT_ID.LENGTH = "12";

        //    tb.TOBACCO_INFO.PERIOD = new XmlNodeEntity();
        //    tb.TOBACCO_INFO.PERIOD = "";
        //    tb.TOBACCO_INFO.PERIOD.Attr_TYPE = "D";
        //    tb.TOBACCO_INFO.PERIOD.LENGTH = "8";

        //    tb.TOBACCO_INFO.VERSION = new XmlNodeEntity();
        //    tb.TOBACCO_INFO.VERSION = "";
        //    tb.TOBACCO_INFO.VERSION.Attr_TYPE = "A";
        //    tb.TOBACCO_INFO.VERSION.LENGTH = "3";

        //    tb.TOBACCO_INFO.RETURN_STATUS = new XmlNodeEntity();
        //    tb.TOBACCO_INFO.RETURN_STATUS = "";
        //    tb.TOBACCO_INFO.RETURN_STATUS.Attr_TYPE = "A";
        //    tb.TOBACCO_INFO.RETURN_STATUS.LENGTH = "3";

        //    tb.TOBACCO_INFO.LAST_UPD_DATE = new XmlNodeEntity();
        //    tb.TOBACCO_INFO.LAST_UPD_DATE = "";
        //    tb.TOBACCO_INFO.LAST_UPD_DATE.Attr_TYPE = "D";
        //    tb.TOBACCO_INFO.LAST_UPD_DATE.LENGTH = "8";

        //    tb.TOBACCO_INFO.USER_ID = new XmlNodeEntity();
        //    tb.TOBACCO_INFO.USER_ID = "";
        //    tb.TOBACCO_INFO.USER_ID.Attr_TYPE = "A";
        //    tb.TOBACCO_INFO.USER_ID.LENGTH = "8";

        //    tb.TOBACCO_INFO.RECORDING_DATE = new XmlNodeEntity();
        //    tb.TOBACCO_INFO.RECORDING_DATE = "";
        //    tb.TOBACCO_INFO.RECORDING_DATE.Attr_TYPE = "D";
        //    tb.TOBACCO_INFO.RECORDING_DATE.LENGTH = "8";

        //    tb.TOBACCO_INFO.SEQUENCE = new XmlNodeEntity();
        //    tb.TOBACCO_INFO.SEQUENCE = "";
        //    tb.TOBACCO_INFO.SEQUENCE.Attr_TYPE = "A";
        //    tb.TOBACCO_INFO.SEQUENCE.LENGTH = "5";

        //    tb.TOBACCO_INFO.ADJUSTMENT_REF_NO = new XmlNodeEntity();
        //    tb.TOBACCO_INFO.ADJUSTMENT_REF_NO = "";
        //    tb.TOBACCO_INFO.ADJUSTMENT_REF_NO.Attr_TYPE = "A";
        //    tb.TOBACCO_INFO.ADJUSTMENT_REF_NO.LENGTH = "10";

        //    tb.TOBACCO_INFO.RATE_ITEM = new XmlNodeEntity();
        //    tb.TOBACCO_INFO.RATE_ITEM = "";
        //    tb.TOBACCO_INFO.RATE_ITEM.Attr_TYPE = "N";
        //    tb.TOBACCO_INFO.RATE_ITEM.LENGTH = "9";
        //    tb.TOBACCO_INFO.RATE_ITEM.PERCISION = "6";

        //    tb.TOBACCO_INFO.RATE_PACK = new XmlNodeEntity();
        //    tb.TOBACCO_INFO.RATE_PACK = "";
        //    tb.TOBACCO_INFO.RATE_PACK.Attr_TYPE = "N";
        //    tb.TOBACCO_INFO.RATE_PACK.LENGTH = "9";
        //    tb.TOBACCO_INFO.RATE_PACK.PERCISION = "6";

        //    tb.TOBACCO_INFO.RATE_PAPER = new XmlNodeEntity();
        //    tb.TOBACCO_INFO.RATE_PAPER = "";
        //    tb.TOBACCO_INFO.RATE_PAPER.Attr_TYPE = "N";
        //    tb.TOBACCO_INFO.RATE_PAPER.LENGTH = "9";
        //    tb.TOBACCO_INFO.RATE_PAPER.PERCISION = "6";

        //    tb.TOBACCO_INFO.PREPARER_NAME = new XmlNodeEntity();
        //    tb.TOBACCO_INFO.PREPARER_NAME = "";
        //    tb.TOBACCO_INFO.PREPARER_NAME.Attr_TYPE = "A";
        //    tb.TOBACCO_INFO.PREPARER_NAME.LENGTH = "40";

        //    tb.TOBACCO_INFO.PREPARER_PHONE = new XmlNodeEntity();
        //    tb.TOBACCO_INFO.PREPARER_PHONE = "";
        //    tb.TOBACCO_INFO.PREPARER_PHONE.Attr_TYPE = "P";
        //    tb.TOBACCO_INFO.PREPARER_PHONE.LENGTH = "10";

        //    tb.TOBACCO_INFO.PREPARER_PHONE_EXT = new XmlNodeEntity();
        //    tb.TOBACCO_INFO.PREPARER_PHONE_EXT = "";
        //    tb.TOBACCO_INFO.PREPARER_PHONE_EXT.Attr_TYPE = "A";
        //    tb.TOBACCO_INFO.PREPARER_PHONE_EXT.LENGTH = "5";

        //    tb.TOBACCO_INFO.PREPARER_IP_ADDRESS = new XmlNodeEntity();
        //    tb.TOBACCO_INFO.PREPARER_IP_ADDRESS = "";
        //    tb.TOBACCO_INFO.PREPARER_IP_ADDRESS.Attr_TYPE = "A";
        //    tb.TOBACCO_INFO.PREPARER_IP_ADDRESS.LENGTH = "15";

        //    tb.TOBACCO_INFO.PREPARER_EMAIL_ADDRESS = new XmlNodeEntity();
        //    tb.TOBACCO_INFO.PREPARER_EMAIL_ADDRESS = "";
        //    tb.TOBACCO_INFO.PREPARER_EMAIL_ADDRESS.Attr_TYPE = "A";
        //    tb.TOBACCO_INFO.PREPARER_EMAIL_ADDRESS.LENGTH = "60";

        //    tb.TOBACCO_INFO.PREPARER_WHO = new XmlNodeEntity();
        //    tb.TOBACCO_INFO.PREPARER_WHO = "";
        //    tb.TOBACCO_INFO.PREPARER_WHO.Attr_TYPE = "A";
        //    tb.TOBACCO_INFO.PREPARER_WHO.LENGTH = "1";

        //    //AMT_INFO
        //    tb.AMT_INFO = new RTTIE028.AMT_INFO();
        //    tb.AMT_INFO.Attr_TYPE = "COMPLEX";
        //    tb.AMT_INFO.OCCURS = "1";
        //    tb.AMT_INFO.LENGTH = "285";
        //    tb.AMT_INFO.EXPORT = "Y";


        //    tb.AMT_INFO.ITEM_TOTAL = new XmlNodeEntity();
        //    tb.AMT_INFO.ITEM_TOTAL = "";
        //    tb.AMT_INFO.ITEM_TOTAL.Attr_TYPE = "A";
        //    tb.AMT_INFO.ITEM_TOTAL.LENGTH = "12";

        //    tb.AMT_INFO.ITEM_NOT_PHILA = new XmlNodeEntity();
        //    tb.AMT_INFO.ITEM_NOT_PHILA = "";
        //    tb.AMT_INFO.ITEM_NOT_PHILA.Attr_TYPE = "N";
        //    tb.AMT_INFO.ITEM_NOT_PHILA.LENGTH = "15";

        //    tb.AMT_INFO.ITEM_PHILA = new XmlNodeEntity();
        //    tb.AMT_INFO.ITEM_PHILA = "";
        //    tb.AMT_INFO.ITEM_PHILA.Attr_TYPE = "N";
        //    tb.AMT_INFO.ITEM_PHILA.LENGTH = "15";

        //    tb.AMT_INFO.ITEM_TAX_DUE = new XmlNodeEntity();
        //    tb.AMT_INFO.ITEM_TAX_DUE = "";
        //    tb.AMT_INFO.ITEM_TAX_DUE.Attr_TYPE = "C";
        //    tb.AMT_INFO.ITEM_TAX_DUE.LENGTH = "15";

        //    tb.AMT_INFO.PACK_TOTAL = new XmlNodeEntity();
        //    tb.AMT_INFO.PACK_TOTAL = "";
        //    tb.AMT_INFO.PACK_TOTAL.Attr_TYPE = "A";
        //    tb.AMT_INFO.PACK_TOTAL.LENGTH = "15";

        //    tb.AMT_INFO.PACK_NOT_PHILA = new XmlNodeEntity();
        //    tb.AMT_INFO.PACK_NOT_PHILA = "";
        //    tb.AMT_INFO.PACK_NOT_PHILA.Attr_TYPE = "N";
        //    tb.AMT_INFO.PACK_NOT_PHILA.LENGTH = "15";

        //    tb.AMT_INFO.PACK_PHILA = new XmlNodeEntity();
        //    tb.AMT_INFO.PACK_PHILA = "";
        //    tb.AMT_INFO.PACK_PHILA.Attr_TYPE = "N";
        //    tb.AMT_INFO.PACK_PHILA.LENGTH = "15";

        //    tb.AMT_INFO.PACK_TAX_DUE = new XmlNodeEntity();
        //    tb.AMT_INFO.PACK_TAX_DUE = "";
        //    tb.AMT_INFO.PACK_TAX_DUE.Attr_TYPE = "C";
        //    tb.AMT_INFO.PACK_TAX_DUE.LENGTH = "15";

        //    tb.AMT_INFO.PAPER_TOTAL = new XmlNodeEntity();
        //    tb.AMT_INFO.PAPER_TOTAL = "";
        //    tb.AMT_INFO.PAPER_TOTAL.Attr_TYPE = "N";
        //    tb.AMT_INFO.PAPER_TOTAL.LENGTH = "15";

        //    tb.AMT_INFO.PAPER_NOT_PHILA = new XmlNodeEntity();
        //    tb.AMT_INFO.PAPER_NOT_PHILA = "";
        //    tb.AMT_INFO.PAPER_NOT_PHILA.Attr_TYPE = "N";
        //    tb.AMT_INFO.PAPER_NOT_PHILA.LENGTH = "15";

        //    tb.AMT_INFO.PAPER_PHILA = new XmlNodeEntity();
        //    tb.AMT_INFO.PAPER_PHILA = "";
        //    tb.AMT_INFO.PAPER_PHILA.Attr_TYPE = "N";
        //    tb.AMT_INFO.PAPER_PHILA.LENGTH = "15";

        //    tb.AMT_INFO.PAPER_TAX_DUE = new XmlNodeEntity();
        //    tb.AMT_INFO.PAPER_TAX_DUE = "";
        //    tb.AMT_INFO.PAPER_TAX_DUE.Attr_TYPE = "C";
        //    tb.AMT_INFO.PAPER_TAX_DUE.LENGTH = "15";

        //    tb.AMT_INFO.TOTAL_TAX_DUE = new XmlNodeEntity();
        //    tb.AMT_INFO.TOTAL_TAX_DUE = "";
        //    tb.AMT_INFO.TOTAL_TAX_DUE.Attr_TYPE = "C";
        //    tb.AMT_INFO.TOTAL_TAX_DUE.LENGTH = "15";

        //    tb.AMT_INFO.CREDITS = new XmlNodeEntity();
        //    tb.AMT_INFO.CREDITS = "";
        //    tb.AMT_INFO.CREDITS.Attr_TYPE = "C";
        //    tb.AMT_INFO.CREDITS.LENGTH = "15";

        //    tb.AMT_INFO.NET_TAX_DUE = new XmlNodeEntity();
        //    tb.AMT_INFO.NET_TAX_DUE = "";
        //    tb.AMT_INFO.NET_TAX_DUE.Attr_TYPE = "C";
        //    tb.AMT_INFO.NET_TAX_DUE.LENGTH = "15";

        //    tb.AMT_INFO.INTEREST_PENALTY = new XmlNodeEntity();
        //    tb.AMT_INFO.INTEREST_PENALTY = "";
        //    tb.AMT_INFO.INTEREST_PENALTY.Attr_TYPE = "C";
        //    tb.AMT_INFO.INTEREST_PENALTY.LENGTH = "15";

        //    tb.AMT_INFO.TOTAL_AMOUNT_DUE = new XmlNodeEntity();
        //    tb.AMT_INFO.TOTAL_AMOUNT_DUE = "";
        //    tb.AMT_INFO.TOTAL_AMOUNT_DUE.Attr_TYPE = "C";
        //    tb.AMT_INFO.TOTAL_AMOUNT_DUE.LENGTH = "15";

        //    tb.AMT_INFO.REFUND = new XmlNodeEntity();
        //    tb.AMT_INFO.REFUND = "";
        //    tb.AMT_INFO.REFUND.Attr_TYPE = "C";
        //    tb.AMT_INFO.REFUND.LENGTH = "15";

        //    tb.AMT_INFO.ROLL_FORWARD = new XmlNodeEntity();
        //    tb.AMT_INFO.ROLL_FORWARD = "";
        //    tb.AMT_INFO.ROLL_FORWARD.Attr_TYPE = "C";
        //    tb.AMT_INFO.ROLL_FORWARD.LENGTH = "15";

        //    //HEADER_INFO
        //    tb.HEADER_INFO = new HEADER_INFO();
        //    tb.HEADER_INFO.ENVIRONMENT = "";

        //    //DEBUG
        //    tb.DEBUG = new DEBUG();

        //    return tb;
        //}

        //public static RTTIE036.SCHOOLRETURN GetSCHOOLRETURN()
        //{
        //    RTTIE036.SCHOOLRETURN sc = new RTTIE036.SCHOOLRETURN();

        //    //Errorinfo
        //    sc.ERROR_INFO = new ERROR_INFO();
        //    sc.ERROR_INFO.Attr_TYPE = "COMPLEX";
        //    sc.ERROR_INFO.OCCURS = "1";
        //    sc.ERROR_INFO.LENGTH = "79";
        //    sc.ERROR_INFO.EXPORT = "N";

        //    sc.ERROR_INFO.PROGRAM = new XmlNodeEntity();
        //    sc.ERROR_INFO.PROGRAM = "";
        //    sc.ERROR_INFO.PROGRAM.Attr_TYPE = "A";
        //    sc.ERROR_INFO.PROGRAM.LENGTH = "8";

        //    sc.ERROR_INFO.ERROR = new XmlNodeEntity();
        //    sc.ERROR_INFO.ERROR = "";
        //    sc.ERROR_INFO.ERROR.Attr_TYPE = "N";
        //    sc.ERROR_INFO.ERROR.LENGTH = "7";

        //    sc.ERROR_INFO.LINE = new XmlNodeEntity();
        //    sc.ERROR_INFO.LINE = "";
        //    sc.ERROR_INFO.LINE.Attr_TYPE = "N";
        //    sc.ERROR_INFO.LINE.LENGTH = "4";

        //    sc.ERROR_INFO.MESSAGE = new XmlNodeEntity();
        //    sc.ERROR_INFO.MESSAGE = "";
        //    sc.ERROR_INFO.MESSAGE.Attr_TYPE = "A";
        //    sc.ERROR_INFO.MESSAGE.LENGTH = "60";

        //    //SCHOOL_INFO
        //    sc.SCHOOL_INFO = new RTTIE036.SCHOOL_INFO();
        //    sc.SCHOOL_INFO.Attr_TYPE = "COMPLEX";
        //    sc.SCHOOL_INFO.OCCURS = "1";
        //    sc.SCHOOL_INFO.LENGTH = "223";
        //    sc.SCHOOL_INFO.EXPORT = "Y";


        //    sc.SCHOOL_INFO.ACCOUNT_ID = new XmlNodeEntity();
        //    sc.SCHOOL_INFO.ACCOUNT_ID = "";
        //    sc.SCHOOL_INFO.ACCOUNT_ID.Attr_TYPE = "A";
        //    sc.SCHOOL_INFO.ACCOUNT_ID.LENGTH = "12";

        //    sc.SCHOOL_INFO.PERIOD = new XmlNodeEntity();
        //    sc.SCHOOL_INFO.PERIOD = "";
        //    sc.SCHOOL_INFO.PERIOD.Attr_TYPE = "D";
        //    sc.SCHOOL_INFO.PERIOD.LENGTH = "8";

        //    sc.SCHOOL_INFO.VERSION = new XmlNodeEntity();
        //    sc.SCHOOL_INFO.VERSION = "";
        //    sc.SCHOOL_INFO.VERSION.Attr_TYPE = "A";
        //    sc.SCHOOL_INFO.VERSION.LENGTH = "3";

        //    sc.SCHOOL_INFO.RETURN_STATUS = new XmlNodeEntity();
        //    sc.SCHOOL_INFO.RETURN_STATUS = "";
        //    sc.SCHOOL_INFO.RETURN_STATUS.Attr_TYPE = "A";
        //    sc.SCHOOL_INFO.RETURN_STATUS.LENGTH = "3";

        //    sc.SCHOOL_INFO.LAST_UPD_DATE = new XmlNodeEntity();
        //    sc.SCHOOL_INFO.LAST_UPD_DATE = "";
        //    sc.SCHOOL_INFO.LAST_UPD_DATE.Attr_TYPE = "D";
        //    sc.SCHOOL_INFO.LAST_UPD_DATE.LENGTH = "8";

          
        //    sc.SCHOOL_INFO.RECORDING_DATE = new XmlNodeEntity();
        //    sc.SCHOOL_INFO.RECORDING_DATE = "";
        //    sc.SCHOOL_INFO.RECORDING_DATE.Attr_TYPE = "D";
        //    sc.SCHOOL_INFO.RECORDING_DATE.LENGTH = "8";

        //    sc.SCHOOL_INFO.SEQUENCE = new XmlNodeEntity();
        //    sc.SCHOOL_INFO.SEQUENCE = "";
        //    sc.SCHOOL_INFO.SEQUENCE.Attr_TYPE = "A";
        //    sc.SCHOOL_INFO.SEQUENCE.LENGTH = "5";

        //    sc.SCHOOL_INFO.ADJUSTMENT_REF_NO = new XmlNodeEntity();
        //    sc.SCHOOL_INFO.ADJUSTMENT_REF_NO = "";
        //    sc.SCHOOL_INFO.ADJUSTMENT_REF_NO.Attr_TYPE = "A";
        //    sc.SCHOOL_INFO.ADJUSTMENT_REF_NO.LENGTH = "10";

        //    sc.SCHOOL_INFO.RATE = new XmlNodeEntity();
        //    sc.SCHOOL_INFO.RATE = "";
        //    sc.SCHOOL_INFO.RATE.Attr_TYPE = "N";
        //    sc.SCHOOL_INFO.RATE.LENGTH = "9";
        //    sc.SCHOOL_INFO.RATE.PERCISION = "6";
         

        //    sc.SCHOOL_INFO.PREPARER_NAME = new XmlNodeEntity();
        //    sc.SCHOOL_INFO.PREPARER_NAME = "";
        //    sc.SCHOOL_INFO.PREPARER_NAME.Attr_TYPE = "A";
        //    sc.SCHOOL_INFO.PREPARER_NAME.LENGTH = "40";

        //    sc.SCHOOL_INFO.PREPARER_PHONE = new XmlNodeEntity();
        //    sc.SCHOOL_INFO.PREPARER_PHONE = "";
        //    sc.SCHOOL_INFO.PREPARER_PHONE.Attr_TYPE = "P";
        //    sc.SCHOOL_INFO.PREPARER_PHONE.LENGTH = "10";

        //    sc.SCHOOL_INFO.PREPARER_PHONE_EXT = new XmlNodeEntity();
        //    sc.SCHOOL_INFO.PREPARER_PHONE_EXT = "";
        //    sc.SCHOOL_INFO.PREPARER_PHONE_EXT.Attr_TYPE = "A";
        //    sc.SCHOOL_INFO.PREPARER_PHONE_EXT.LENGTH = "5";

        //    sc.SCHOOL_INFO.PREPARER_IP_ADDRESS = new XmlNodeEntity();
        //    sc.SCHOOL_INFO.PREPARER_IP_ADDRESS = "";
        //    sc.SCHOOL_INFO.PREPARER_IP_ADDRESS.Attr_TYPE = "A";
        //    sc.SCHOOL_INFO.PREPARER_IP_ADDRESS.LENGTH = "15";

        //    sc.SCHOOL_INFO.PREPARER_EMAIL_ADDRESS = new XmlNodeEntity();
        //    sc.SCHOOL_INFO.PREPARER_EMAIL_ADDRESS = "";
        //    sc.SCHOOL_INFO.PREPARER_EMAIL_ADDRESS.Attr_TYPE = "A";
        //    sc.SCHOOL_INFO.PREPARER_EMAIL_ADDRESS.LENGTH = "60";

        //    sc.SCHOOL_INFO.PREPARER_WHO = new XmlNodeEntity();
        //    sc.SCHOOL_INFO.PREPARER_WHO = "";
        //    sc.SCHOOL_INFO.PREPARER_WHO.Attr_TYPE = "A";
        //    sc.SCHOOL_INFO.PREPARER_WHO.LENGTH = "1";

        //    //AMT_INFO
        //    sc.AMT_INFO = new RTTIE036.AMT_INFO();
        //    sc.AMT_INFO.Attr_TYPE = "COMPLEX";
        //    sc.AMT_INFO.OCCURS = "1";
        //    sc.AMT_INFO.LENGTH = "285";
        //    sc.AMT_INFO.EXPORT = "Y";


        //    sc.AMT_INFO.NET_TAX_DIVIDENDS = new XmlNodeEntity();
        //    sc.AMT_INFO.NET_TAX_DIVIDENDS = "";
        //    sc.AMT_INFO.NET_TAX_DIVIDENDS.Attr_TYPE = "C";
        //    sc.AMT_INFO.NET_TAX_DIVIDENDS.LENGTH = "15";

        //    sc.AMT_INFO.TAXABLE_INTEREST = new XmlNodeEntity();
        //    sc.AMT_INFO.TAXABLE_INTEREST = "";
        //    sc.AMT_INFO.TAXABLE_INTEREST.Attr_TYPE = "C";
        //    sc.AMT_INFO.TAXABLE_INTEREST.LENGTH = "15";

        //    sc.AMT_INFO.PARTNERSHIP_INCOME = new XmlNodeEntity();
        //    sc.AMT_INFO.PARTNERSHIP_INCOME = "";
        //    sc.AMT_INFO.PARTNERSHIP_INCOME.Attr_TYPE = "C";
        //    sc.AMT_INFO.PARTNERSHIP_INCOME.LENGTH = "15";

        //    sc.AMT_INFO.BENEFICIARY_INCOME = new XmlNodeEntity();
        //    sc.AMT_INFO.BENEFICIARY_INCOME = "";
        //    sc.AMT_INFO.BENEFICIARY_INCOME.Attr_TYPE = "C";
        //    sc.AMT_INFO.BENEFICIARY_INCOME.LENGTH = "15";

        //    sc.AMT_INFO.SHORT_TERM_GAINS = new XmlNodeEntity();
        //    sc.AMT_INFO.SHORT_TERM_GAINS = "";
        //    sc.AMT_INFO.SHORT_TERM_GAINS.Attr_TYPE = "C";
        //    sc.AMT_INFO.SHORT_TERM_GAINS.LENGTH = "15";

        //    sc.AMT_INFO.NET_RENTAL_INCOME = new XmlNodeEntity();
        //    sc.AMT_INFO.NET_RENTAL_INCOME = "";
        //    sc.AMT_INFO.NET_RENTAL_INCOME.Attr_TYPE = "C";
        //    sc.AMT_INFO.NET_RENTAL_INCOME.LENGTH = "15";

        //    sc.AMT_INFO.OTHER_TAXABLE_INCOME = new XmlNodeEntity();
        //    sc.AMT_INFO.OTHER_TAXABLE_INCOME = "";
        //    sc.AMT_INFO.OTHER_TAXABLE_INCOME.Attr_TYPE = "C";
        //    sc.AMT_INFO.OTHER_TAXABLE_INCOME.LENGTH = "15";

        //    sc.AMT_INFO.TOTAL_TAXABLE_INCOME = new XmlNodeEntity();
        //    sc.AMT_INFO.TOTAL_TAXABLE_INCOME = "";
        //    sc.AMT_INFO.TOTAL_TAXABLE_INCOME.Attr_TYPE = "C";
        //    sc.AMT_INFO.TOTAL_TAXABLE_INCOME.LENGTH = "15";

        //    sc.AMT_INFO.DEDUCTIBLE_EXPENSES = new XmlNodeEntity();
        //    sc.AMT_INFO.DEDUCTIBLE_EXPENSES = "";
        //    sc.AMT_INFO.DEDUCTIBLE_EXPENSES.Attr_TYPE = "C";
        //    sc.AMT_INFO.DEDUCTIBLE_EXPENSES.LENGTH = "15";

        //    sc.AMT_INFO.NET_TAXABLE_INCOME = new XmlNodeEntity();
        //    sc.AMT_INFO.NET_TAXABLE_INCOME = "";
        //    sc.AMT_INFO.NET_TAXABLE_INCOME.Attr_TYPE = "C";
        //    sc.AMT_INFO.NET_TAXABLE_INCOME.LENGTH = "15";

        //    sc.AMT_INFO.GROSS_TAX_DUE = new XmlNodeEntity();
        //    sc.AMT_INFO.GROSS_TAX_DUE = "";
        //    sc.AMT_INFO.GROSS_TAX_DUE.Attr_TYPE = "C";
        //    sc.AMT_INFO.GROSS_TAX_DUE.LENGTH = "15";

        //    sc.AMT_INFO.CREDITS = new XmlNodeEntity();
        //    sc.AMT_INFO.CREDITS = "";
        //    sc.AMT_INFO.CREDITS.Attr_TYPE = "C";
        //    sc.AMT_INFO.CREDITS.LENGTH = "15";


        //    sc.AMT_INFO.TAX_DUE = new XmlNodeEntity();
        //    sc.AMT_INFO.TAX_DUE = "";
        //    sc.AMT_INFO.TAX_DUE.Attr_TYPE = "C";
        //    sc.AMT_INFO.TAX_DUE.LENGTH = "15";

        //    sc.AMT_INFO.TAX_REFUND = new XmlNodeEntity();
        //    sc.AMT_INFO.TAX_REFUND = "";
        //    sc.AMT_INFO.TAX_REFUND.Attr_TYPE = "C";
        //    sc.AMT_INFO.TAX_REFUND.LENGTH = "15";

        //    sc.AMT_INFO.TAX_OVERPAID = new XmlNodeEntity();
        //    sc.AMT_INFO.TAX_OVERPAID = "";
        //    sc.AMT_INFO.TAX_OVERPAID.Attr_TYPE = "C";
        //    sc.AMT_INFO.TAX_OVERPAID.LENGTH = "15";

        //    sc.AMT_INFO.USER_ID = new XmlNodeEntity();
        //    sc.AMT_INFO.USER_ID = "";
        //    sc.AMT_INFO.USER_ID.Attr_TYPE = "C";
        //    sc.AMT_INFO.USER_ID.LENGTH = "15";

          
        //    //HEADER_INFO
        //    sc.HEADER_INFO = new HEADER_INFO();
        //    sc.HEADER_INFO.ENVIRONMENT = "";

        //    //DEBUG
        //    sc.DEBUG = new DEBUG();

        //    return sc;
        //}

        //public static RTTIE027.WAGERETURN GetWageReturn()
        //{
        //    RTTIE027.WAGERETURN wg = new RTTIE027.WAGERETURN();

        //    //Errorinfo
        //    wg.ERROR_INFO = new ERROR_INFO();
        //    wg.ERROR_INFO.Attr_TYPE = "COMPLEX";
        //    wg.ERROR_INFO.OCCURS = "1";
        //    wg.ERROR_INFO.LENGTH = "79";
        //    wg.ERROR_INFO.EXPORT = "N";

        //    wg.ERROR_INFO.PROGRAM = new XmlNodeEntity();
        //    wg.ERROR_INFO.PROGRAM = "";
        //    wg.ERROR_INFO.PROGRAM.Attr_TYPE = "A";
        //    wg.ERROR_INFO.PROGRAM.LENGTH = "8";

        //    wg.ERROR_INFO.ERROR = new XmlNodeEntity();
        //    wg.ERROR_INFO.ERROR = "";
        //    wg.ERROR_INFO.ERROR.Attr_TYPE = "N";
        //    wg.ERROR_INFO.ERROR.LENGTH = "7";

        //    wg.ERROR_INFO.LINE = new XmlNodeEntity();
        //    wg.ERROR_INFO.LINE = "";
        //    wg.ERROR_INFO.LINE.Attr_TYPE = "N";
        //    wg.ERROR_INFO.LINE.LENGTH = "4";

        //    wg.ERROR_INFO.MESSAGE = new XmlNodeEntity();
        //    wg.ERROR_INFO.MESSAGE = "";
        //    wg.ERROR_INFO.MESSAGE.Attr_TYPE = "A";
        //    wg.ERROR_INFO.MESSAGE.LENGTH = "60";

        //    //WAGE_INFO
        //    wg.WAGE_INFO = new WAGE_INFO();
        //    wg.WAGE_INFO.Attr_TYPE = "COMPLEX";
        //    wg.WAGE_INFO.OCCURS = "1";
        //    wg.WAGE_INFO.LENGTH = "271";
        //    wg.WAGE_INFO.EXPORT = "Y";

        //    wg.WAGE_INFO.ACCOUNT_ID = new XmlNodeEntity();
        //    wg.WAGE_INFO.ACCOUNT_ID = "";
        //    wg.WAGE_INFO.ACCOUNT_ID.Attr_TYPE = "A";
        //    wg.WAGE_INFO.ACCOUNT_ID.LENGTH = "12";

        //    wg.WAGE_INFO.PERIOD = new XmlNodeEntity();
        //    wg.WAGE_INFO.PERIOD = "";
        //    wg.WAGE_INFO.PERIOD.Attr_TYPE = "D";
        //    wg.WAGE_INFO.PERIOD.LENGTH = "8";

        //    wg.WAGE_INFO.VERSION = new XmlNodeEntity();
        //    wg.WAGE_INFO.VERSION = "";
        //    wg.WAGE_INFO.VERSION.Attr_TYPE = "A";
        //    wg.WAGE_INFO.VERSION.LENGTH = "3";

        //    wg.WAGE_INFO.DOCUMENT_CONTROL = new XmlNodeEntity();
        //    wg.WAGE_INFO.DOCUMENT_CONTROL = "";
        //    wg.WAGE_INFO.DOCUMENT_CONTROL.Attr_TYPE = "A";
        //    wg.WAGE_INFO.DOCUMENT_CONTROL.LENGTH = "9";

        //    wg.WAGE_INFO.ADJ_REFNO_CONTROL = new XmlNodeEntity();
        //    wg.WAGE_INFO.ADJ_REFNO_CONTROL = "";
        //    wg.WAGE_INFO.ADJ_REFNO_CONTROL.Attr_TYPE = "A";
        //    wg.WAGE_INFO.ADJ_REFNO_CONTROL.LENGTH = "10";

        //    wg.WAGE_INFO.ENTITY_ID = new XmlNodeEntity();
        //    wg.WAGE_INFO.ENTITY_ID = "";
        //    wg.WAGE_INFO.ENTITY_ID.Attr_TYPE = "A";
        //    wg.WAGE_INFO.ENTITY_ID.LENGTH = "9";

        //    wg.WAGE_INFO.RETURN_STATUS = new XmlNodeEntity();
        //    wg.WAGE_INFO.RETURN_STATUS = "";
        //    wg.WAGE_INFO.RETURN_STATUS.Attr_TYPE = "A";
        //    wg.WAGE_INFO.RETURN_STATUS.LENGTH = "3";

        //    wg.WAGE_INFO.SEQUENCE = new XmlNodeEntity();
        //    wg.WAGE_INFO.SEQUENCE = "";
        //    wg.WAGE_INFO.SEQUENCE.Attr_TYPE = "A";
        //    wg.WAGE_INFO.SEQUENCE.LENGTH = "5";

        //    wg.WAGE_INFO.LAST_UPD_DATE = new XmlNodeEntity();
        //    wg.WAGE_INFO.LAST_UPD_DATE = "";
        //    wg.WAGE_INFO.LAST_UPD_DATE.Attr_TYPE = "D";
        //    wg.WAGE_INFO.LAST_UPD_DATE.LENGTH = "8";

        //    wg.WAGE_INFO.NO_OF_RESIDENTS = new XmlNodeEntity();
        //    wg.WAGE_INFO.NO_OF_RESIDENTS = "";
        //    wg.WAGE_INFO.NO_OF_RESIDENTS.Attr_TYPE = "N";
        //    wg.WAGE_INFO.NO_OF_RESIDENTS.LENGTH = "7";

        //    wg.WAGE_INFO.NO_OF_NONRESIDENTS = new XmlNodeEntity();
        //    wg.WAGE_INFO.NO_OF_NONRESIDENTS = "";
        //    wg.WAGE_INFO.NO_OF_NONRESIDENTS.Attr_TYPE = "N";
        //    wg.WAGE_INFO.NO_OF_NONRESIDENTS.LENGTH = "7";

        //    wg.WAGE_INFO.PHILA_EMPLOYEES = new XmlNodeEntity();
        //    wg.WAGE_INFO.PHILA_EMPLOYEES = "";
        //    wg.WAGE_INFO.PHILA_EMPLOYEES.Attr_TYPE = "N";
        //    wg.WAGE_INFO.PHILA_EMPLOYEES.LENGTH = "7";

        //    wg.WAGE_INFO.TOTAL_EMPLOYEES = new XmlNodeEntity();
        //    wg.WAGE_INFO.TOTAL_EMPLOYEES = "";
        //    wg.WAGE_INFO.TOTAL_EMPLOYEES.Attr_TYPE = "N";
        //    wg.WAGE_INFO.TOTAL_EMPLOYEES.LENGTH = "7";

        //    wg.WAGE_INFO.RESTAX_A = new XmlNodeEntity();
        //    wg.WAGE_INFO.RESTAX_A = "";
        //    wg.WAGE_INFO.RESTAX_A.Attr_TYPE = "N";
        //    wg.WAGE_INFO.RESTAX_A.LENGTH = "9";
        //    wg.WAGE_INFO.RESTAX_A.PERCISION = "6";

        //    wg.WAGE_INFO.RESTAX_B = new XmlNodeEntity();
        //    wg.WAGE_INFO.RESTAX_B = "";
        //    wg.WAGE_INFO.RESTAX_B.Attr_TYPE = "N";
        //    wg.WAGE_INFO.RESTAX_B.LENGTH = "7";
        //    wg.WAGE_INFO.RESTAX_B.PERCISION = "6";

        //    wg.WAGE_INFO.NONRESTAX_A = new XmlNodeEntity();
        //    wg.WAGE_INFO.NONRESTAX_A = "";
        //    wg.WAGE_INFO.NONRESTAX_A.Attr_TYPE = "N";
        //    wg.WAGE_INFO.NONRESTAX_A.LENGTH = "9";
        //    wg.WAGE_INFO.NONRESTAX_A.PERCISION = "6";

        //    wg.WAGE_INFO.NONRESTAX_B = new XmlNodeEntity();
        //    wg.WAGE_INFO.NONRESTAX_B = "";
        //    wg.WAGE_INFO.NONRESTAX_B.Attr_TYPE = "N";
        //    wg.WAGE_INFO.NONRESTAX_B.LENGTH = "9";
        //    wg.WAGE_INFO.NONRESTAX_B.PERCISION = "6";

        //    wg.WAGE_INFO.FREQUENCY = new XmlNodeEntity();
        //    wg.WAGE_INFO.FREQUENCY = "";
        //    wg.WAGE_INFO.FREQUENCY.Attr_TYPE = "A";
        //    wg.WAGE_INFO.FREQUENCY.LENGTH = "1";

        //    wg.WAGE_INFO.DUE_DATE = new XmlNodeEntity();
        //    wg.WAGE_INFO.DUE_DATE = "";
        //    wg.WAGE_INFO.DUE_DATE.Attr_TYPE = "D";
        //    wg.WAGE_INFO.DUE_DATE.LENGTH = "8";

        //    wg.WAGE_INFO.PREPARER_NAME = new XmlNodeEntity();
        //    wg.WAGE_INFO.PREPARER_NAME = "";
        //    wg.WAGE_INFO.PREPARER_NAME.Attr_TYPE = "A";
        //    wg.WAGE_INFO.PREPARER_NAME.LENGTH = "40";

        //    wg.WAGE_INFO.PREPARER_PHONE = new XmlNodeEntity();
        //    wg.WAGE_INFO.PREPARER_PHONE = "";
        //    wg.WAGE_INFO.PREPARER_PHONE.Attr_TYPE = "P";
        //    wg.WAGE_INFO.PREPARER_PHONE.LENGTH = "10";

        //    wg.WAGE_INFO.PREPARER_PHONE_EXT = new XmlNodeEntity();
        //    wg.WAGE_INFO.PREPARER_PHONE_EXT = "";
        //    wg.WAGE_INFO.PREPARER_PHONE_EXT.Attr_TYPE = "A";
        //    wg.WAGE_INFO.PREPARER_PHONE_EXT.LENGTH = "5";

        //    wg.WAGE_INFO.PREPARER_IP_ADDRESS = new XmlNodeEntity();
        //    wg.WAGE_INFO.PREPARER_IP_ADDRESS = "";
        //    wg.WAGE_INFO.PREPARER_IP_ADDRESS.Attr_TYPE = "A";
        //    wg.WAGE_INFO.PREPARER_IP_ADDRESS.LENGTH = "15";

        //    wg.WAGE_INFO.PREPARER_EMAIL_ADDRESS = new XmlNodeEntity();
        //    wg.WAGE_INFO.PREPARER_EMAIL_ADDRESS = "";
        //    wg.WAGE_INFO.PREPARER_EMAIL_ADDRESS.Attr_TYPE = "A";
        //    wg.WAGE_INFO.PREPARER_EMAIL_ADDRESS.LENGTH = "60";

        //    wg.WAGE_INFO.PREPARER_WHO = new XmlNodeEntity();
        //    wg.WAGE_INFO.PREPARER_WHO = "";
        //    wg.WAGE_INFO.PREPARER_WHO.Attr_TYPE = "A";
        //    wg.WAGE_INFO.PREPARER_WHO.LENGTH = "1";

        //    //AMT_INFO
        //    wg.AMT_INFO = new AMT_INFO();
        //    wg.AMT_INFO.Attr_TYPE = "COMPLEX";
        //    wg.AMT_INFO.OCCURS = "1";
        //    wg.AMT_INFO.LENGTH = "249";
        //    wg.AMT_INFO.EXPORT = "Y";

        //    wg.AMT_INFO.GROSS_COMP = new XmlNodeEntity();
        //    wg.AMT_INFO.GROSS_COMP = "";
        //    wg.AMT_INFO.GROSS_COMP.Attr_TYPE = "C";
        //    wg.AMT_INFO.GROSS_COMP.LENGTH = "15";

        //    wg.AMT_INFO.NON_TAXABLE_COMP = new XmlNodeEntity();
        //    wg.AMT_INFO.NON_TAXABLE_COMP = "";
        //    wg.AMT_INFO.NON_TAXABLE_COMP.Attr_TYPE = "C";
        //    wg.AMT_INFO.NON_TAXABLE_COMP.LENGTH = "15";

        //    wg.AMT_INFO.RESIDENT_PAYROLL_A = new XmlNodeEntity();
        //    wg.AMT_INFO.RESIDENT_PAYROLL_A = "";
        //    wg.AMT_INFO.RESIDENT_PAYROLL_A.Attr_TYPE = "C";
        //    wg.AMT_INFO.RESIDENT_PAYROLL_A.LENGTH = "15";

        //    wg.AMT_INFO.RESIDENT_TAX_DUE_A = new XmlNodeEntity();
        //    wg.AMT_INFO.RESIDENT_TAX_DUE_A = "";
        //    wg.AMT_INFO.RESIDENT_TAX_DUE_A.Attr_TYPE = "C";
        //    wg.AMT_INFO.RESIDENT_TAX_DUE_A.LENGTH = "15";

        //    wg.AMT_INFO.RESIDENT_PAYROLL_B = new XmlNodeEntity();
        //    wg.AMT_INFO.RESIDENT_PAYROLL_B = "";
        //    wg.AMT_INFO.RESIDENT_PAYROLL_B.Attr_TYPE = "C";
        //    wg.AMT_INFO.RESIDENT_PAYROLL_B.LENGTH = "15";

        //    wg.AMT_INFO.RESIDENT_TAX_DUE_B = new XmlNodeEntity();
        //    wg.AMT_INFO.RESIDENT_TAX_DUE_B = "";
        //    wg.AMT_INFO.RESIDENT_TAX_DUE_B.Attr_TYPE = "C";
        //    wg.AMT_INFO.RESIDENT_TAX_DUE_B.LENGTH = "15";

        //    wg.AMT_INFO.NON_RES_PAYROLL_A = new XmlNodeEntity();
        //    wg.AMT_INFO.NON_RES_PAYROLL_A = "";
        //    wg.AMT_INFO.NON_RES_PAYROLL_A.Attr_TYPE = "C";
        //    wg.AMT_INFO.NON_RES_PAYROLL_A.LENGTH = "15";

        //    wg.AMT_INFO.NON_RES_TAX_DUE_A = new XmlNodeEntity();
        //    wg.AMT_INFO.NON_RES_TAX_DUE_A = "";
        //    wg.AMT_INFO.NON_RES_TAX_DUE_A.Attr_TYPE = "C";
        //    wg.AMT_INFO.NON_RES_TAX_DUE_A.LENGTH = "15";

        //    wg.AMT_INFO.NON_RES_PAYROLL_B = new XmlNodeEntity();
        //    wg.AMT_INFO.NON_RES_PAYROLL_B = "";
        //    wg.AMT_INFO.NON_RES_PAYROLL_B.Attr_TYPE = "C";
        //    wg.AMT_INFO.NON_RES_PAYROLL_B.LENGTH = "15";

        //    wg.AMT_INFO.NON_RES_TAX_DUE_B = new XmlNodeEntity();
        //    wg.AMT_INFO.NON_RES_TAX_DUE_B = "";
        //    wg.AMT_INFO.NON_RES_TAX_DUE_B.Attr_TYPE = "C";
        //    wg.AMT_INFO.NON_RES_TAX_DUE_B.LENGTH = "15";

        //    wg.AMT_INFO.NON_RES_TAX_DUE_B = new XmlNodeEntity();
        //    wg.AMT_INFO.NON_RES_TAX_DUE_B = "";
        //    wg.AMT_INFO.NON_RES_TAX_DUE_B.Attr_TYPE = "C";
        //    wg.AMT_INFO.NON_RES_TAX_DUE_B.LENGTH = "15";

        //    wg.AMT_INFO.TOTAL_GROSS_TAX_DUE = new XmlNodeEntity();
        //    wg.AMT_INFO.TOTAL_GROSS_TAX_DUE = "";
        //    wg.AMT_INFO.TOTAL_GROSS_TAX_DUE.Attr_TYPE = "C";
        //    wg.AMT_INFO.TOTAL_GROSS_TAX_DUE.LENGTH = "15";

        //    wg.AMT_INFO.TAX_PAID = new XmlNodeEntity();
        //    wg.AMT_INFO.TAX_PAID = "";
        //    wg.AMT_INFO.TAX_PAID.Attr_TYPE = "C";
        //    wg.AMT_INFO.TAX_PAID.LENGTH = "15";

        //    wg.AMT_INFO.TAX_DUE = new XmlNodeEntity();
        //    wg.AMT_INFO.TAX_DUE = "";
        //    wg.AMT_INFO.TAX_DUE.Attr_TYPE = "C";
        //    wg.AMT_INFO.TAX_DUE.LENGTH = "15";

        //    wg.AMT_INFO.TAX_OVERPAID = new XmlNodeEntity();
        //    wg.AMT_INFO.TAX_OVERPAID = "";
        //    wg.AMT_INFO.TAX_OVERPAID.Attr_TYPE = "C";
        //    wg.AMT_INFO.TAX_OVERPAID.LENGTH = "15";

        //    wg.AMT_INFO.POSTING_DATE = new XmlNodeEntity();
        //    wg.AMT_INFO.POSTING_DATE = "";
        //    wg.AMT_INFO.POSTING_DATE.Attr_TYPE = "D";
        //    wg.AMT_INFO.POSTING_DATE.LENGTH = "8";

        //    wg.AMT_INFO.FILING_DATE = new XmlNodeEntity();
        //    wg.AMT_INFO.FILING_DATE = "";
        //    wg.AMT_INFO.FILING_DATE.Attr_TYPE = "D";
        //    wg.AMT_INFO.FILING_DATE.LENGTH = "8";

        //    wg.AMT_INFO.USER_ID = new XmlNodeEntity();
        //    wg.AMT_INFO.USER_ID = "";
        //    wg.AMT_INFO.USER_ID.Attr_TYPE = "A";
        //    wg.AMT_INFO.USER_ID.LENGTH = "8";

        //    return wg;
        //}

        //public static RTTIE022.DelinquentForm GetDelinquentForm()
        //{
        //    RTTIE022.DelinquentForm fo = new RTTIE022.DelinquentForm();

        //    //Errorinfo
        //    fo.ERROR_INFO = new ERROR_INFO();
        //    fo.ERROR_INFO.Attr_TYPE = "COMPLEX";
        //    fo.ERROR_INFO.OCCURS = "1";
        //    fo.ERROR_INFO.LENGTH = "79";
        //    fo.ERROR_INFO.EXPORT = "N";

        //    fo.ERROR_INFO.PROGRAM = new XmlNodeEntity();
        //    fo.ERROR_INFO.PROGRAM = "";
        //    fo.ERROR_INFO.PROGRAM.Attr_TYPE = "A";
        //    fo.ERROR_INFO.PROGRAM.LENGTH = "8";

        //    fo.ERROR_INFO.ERROR = new XmlNodeEntity();
        //    fo.ERROR_INFO.ERROR = "";
        //    fo.ERROR_INFO.ERROR.Attr_TYPE = "N";
        //    fo.ERROR_INFO.ERROR.LENGTH = "7";

        //    fo.ERROR_INFO.LINE = new XmlNodeEntity();
        //    fo.ERROR_INFO.LINE = "";
        //    fo.ERROR_INFO.LINE.Attr_TYPE = "N";
        //    fo.ERROR_INFO.LINE.LENGTH = "4";

        //    fo.ERROR_INFO.MESSAGE = new XmlNodeEntity();
        //    fo.ERROR_INFO.MESSAGE = "";
        //    fo.ERROR_INFO.MESSAGE.Attr_TYPE = "A";
        //    fo.ERROR_INFO.MESSAGE.LENGTH = "60";

        //    //WAGE_INFO
        //    fo.DEL_INFO = new RTTIE022.DEL_INFO();
        //    fo.DEL_INFO.Attr_TYPE = "COMPLEX";
        //    fo.DEL_INFO.OCCURS = "1";
        //    fo.DEL_INFO.LENGTH = "51";
        //    fo.DEL_INFO.EXPORT = "Y";

        //    fo.DEL_INFO.ENTITY_TYPE = new XmlNodeEntity();
        //    fo.DEL_INFO.ENTITY_TYPE = "";
        //    fo.DEL_INFO.ENTITY_TYPE.Attr_TYPE = "A";
        //    fo.DEL_INFO.ENTITY_TYPE.LENGTH = "3";

        //    fo.DEL_INFO.ENTITY_ID = new XmlNodeEntity();
        //    fo.DEL_INFO.ENTITY_ID = "";
        //    fo.DEL_INFO.ENTITY_ID.Attr_TYPE = "A";
        //    fo.DEL_INFO.ENTITY_ID.LENGTH = "11";

        //    fo.DEL_INFO.FUNCTION = new XmlNodeEntity();
        //    fo.DEL_INFO.FUNCTION = "";
        //    fo.DEL_INFO.FUNCTION.Attr_TYPE = "A";
        //    fo.DEL_INFO.FUNCTION.LENGTH = "1";

        //    fo.DEL_INFO.NOTICE_NUM = new XmlNodeEntity();
        //    fo.DEL_INFO.NOTICE_NUM = "";
        //    fo.DEL_INFO.NOTICE_NUM.Attr_TYPE = "A";
        //    fo.DEL_INFO.NOTICE_NUM.LENGTH = "13";

        //    fo.DEL_INFO.NEXT_ACCOUNT_TYPE = new XmlNodeEntity();
        //    fo.DEL_INFO.NEXT_ACCOUNT_TYPE = "";
        //    fo.DEL_INFO.NEXT_ACCOUNT_TYPE.Attr_TYPE = "A";
        //    fo.DEL_INFO.NEXT_ACCOUNT_TYPE.LENGTH = "3";

        //    fo.DEL_INFO.NEXT_ACCOUNT_ID = new XmlNodeEntity();
        //    fo.DEL_INFO.NEXT_ACCOUNT_ID = "";
        //    fo.DEL_INFO.NEXT_ACCOUNT_ID.Attr_TYPE = "A";
        //    fo.DEL_INFO.NEXT_ACCOUNT_ID.LENGTH = "12";

        //    fo.DEL_INFO.NEXT_PERIOD = new XmlNodeEntity();
        //    fo.DEL_INFO.NEXT_PERIOD = "";
        //    fo.DEL_INFO.NEXT_PERIOD.Attr_TYPE = "A";
        //    fo.DEL_INFO.NEXT_PERIOD.LENGTH = "8";

        //    //DEL_ACCT
        //    fo.DEL_ACCTs = new List<RTTIE022.DEL_ACCT>();

        //    fo.DEL_ACCT_DELIMITED = new RTTIE022.DEL_ACCT_DELIMITED();
        //    //fo.DEL_ACCT_DELIMITED = "";


        //    fo.DEBUG = new DEBUG();
        //    //fo.DEBUG = "";

        //    fo.HEADER_INFO = new HEADER_INFO();
        //    //fo.HEADER_INFO = "";

        //    return fo;
        //}


        //public static RTTIE022.DEL_ACCT GetDelinquent_DEL_ACCT()
        //{
        //    RTTIE022.DEL_ACCT DEL_ACCT = new RTTIE022.DEL_ACCT();

        //    DEL_ACCT.Attr_TYPE = "COMPLEX";
        //    DEL_ACCT.OCCURS = "225";
        //    DEL_ACCT.LENGTH = "130";
        //    DEL_ACCT.EXPORT = "Y";

        //    DEL_ACCT.FUNCTION_CODE = new XmlNodeEntity();
        //    DEL_ACCT.FUNCTION_CODE = "";
        //    DEL_ACCT.FUNCTION_CODE.Attr_TYPE = "A";
        //    DEL_ACCT.FUNCTION_CODE.LENGTH = "1";

        //    DEL_ACCT.ACCOUNT_TYPE = new XmlNodeEntity();
        //    DEL_ACCT.ACCOUNT_TYPE = "";
        //    DEL_ACCT.ACCOUNT_TYPE.Attr_TYPE = "A";
        //    DEL_ACCT.ACCOUNT_TYPE.LENGTH = "3";

        //    DEL_ACCT.ACCOUNT_ID = new XmlNodeEntity();
        //    DEL_ACCT.ACCOUNT_ID = "";
        //    DEL_ACCT.ACCOUNT_ID.Attr_TYPE = "A";
        //    DEL_ACCT.ACCOUNT_ID.LENGTH = "12";

        //    DEL_ACCT.PERIOD = new XmlNodeEntity();
        //    DEL_ACCT.PERIOD = "";
        //    DEL_ACCT.PERIOD.Attr_TYPE = "A";
        //    DEL_ACCT.PERIOD.LENGTH = "8";

        //    DEL_ACCT.PRINCIPAL_DUE = new XmlNodeEntity();
        //    DEL_ACCT.PRINCIPAL_DUE = "";
        //    DEL_ACCT.PRINCIPAL_DUE.Attr_TYPE = "C";
        //    DEL_ACCT.PRINCIPAL_DUE.LENGTH = "13";

        //    DEL_ACCT.INTEREST_DUE = new XmlNodeEntity();
        //    DEL_ACCT.INTEREST_DUE = "";
        //    DEL_ACCT.INTEREST_DUE.Attr_TYPE = "C";
        //    DEL_ACCT.INTEREST_DUE.LENGTH = "13";

        //    DEL_ACCT.PENALTY_DUE = new XmlNodeEntity();
        //    DEL_ACCT.PENALTY_DUE = "";
        //    DEL_ACCT.PENALTY_DUE.Attr_TYPE = "C";
        //    DEL_ACCT.PENALTY_DUE.LENGTH = "13";

        //    DEL_ACCT.OTHER_DUE = new XmlNodeEntity();
        //    DEL_ACCT.OTHER_DUE = "";
        //    DEL_ACCT.OTHER_DUE.Attr_TYPE = "C";
        //    DEL_ACCT.OTHER_DUE.LENGTH = "13";

        //    DEL_ACCT.BRT_ENTITY = new XmlNodeEntity();
        //    DEL_ACCT.BRT_ENTITY = "";
        //    DEL_ACCT.BRT_ENTITY.Attr_TYPE = "A";
        //    DEL_ACCT.BRT_ENTITY.LENGTH = "11";

        //    DEL_ACCT.BRT_ADDRESS = new XmlNodeEntity();
        //    DEL_ACCT.BRT_ADDRESS = "";
        //    DEL_ACCT.BRT_ADDRESS.Attr_TYPE = "A";
        //    DEL_ACCT.BRT_ADDRESS.LENGTH = "40";

        //    DEL_ACCT.FILL = new XmlNodeEntity();
        //    DEL_ACCT.FILL = "";
        //    DEL_ACCT.FILL.Attr_TYPE = "A";
        //    DEL_ACCT.FILL.LENGTH = "3";

        //    return DEL_ACCT;
        //}

        //public static RTTIE016.PAYCOUPON GetPAYCOUPON()
        //{
        //    RTTIE016.PAYCOUPON tb = new RTTIE016.PAYCOUPON();

        //    //Errorinfo
        //    tb.ERROR_INFO = new ERROR_INFO();
        //    tb.ERROR_INFO.Attr_TYPE = "COMPLEX";
        //    tb.ERROR_INFO.OCCURS = "1";
        //    tb.ERROR_INFO.LENGTH = "79";
        //    tb.ERROR_INFO.EXPORT = "N";

        //    tb.ERROR_INFO.PROGRAM = new XmlNodeEntity();
        //    tb.ERROR_INFO.PROGRAM = "";
        //    tb.ERROR_INFO.PROGRAM.Attr_TYPE = "A";
        //    tb.ERROR_INFO.PROGRAM.LENGTH = "1";

        //    tb.ERROR_INFO.ERROR = new XmlNodeEntity();
        //    tb.ERROR_INFO.ERROR = "";
        //    tb.ERROR_INFO.ERROR.Attr_TYPE = "N";
        //    tb.ERROR_INFO.ERROR.LENGTH = "3";

        //    tb.ERROR_INFO.LINE = new XmlNodeEntity();
        //    tb.ERROR_INFO.LINE = "";
        //    tb.ERROR_INFO.LINE.Attr_TYPE = "N";
        //    tb.ERROR_INFO.LINE.LENGTH = "4";

        //    tb.ERROR_INFO.MESSAGE = new XmlNodeEntity();
        //    tb.ERROR_INFO.MESSAGE = "";
        //    tb.ERROR_INFO.MESSAGE.Attr_TYPE = "A";
        //    tb.ERROR_INFO.MESSAGE.LENGTH = "60";

        //    //ENTITY_INFO
        //    tb.ENTITY_INFO = new RTTIE016.ENTITY_INFO();
        //    tb.ENTITY_INFO.Attr_TYPE = "COMPLEX";
        //    tb.ENTITY_INFO.OCCURS = "1";
        //    tb.ENTITY_INFO.LENGTH = "219";
        //    tb.ENTITY_INFO.EXPORT = "Y";


        //    tb.ENTITY_INFO.FUNCTION_CODE = new XmlNodeEntity();
        //    tb.ENTITY_INFO.FUNCTION_CODE = "";
        //    tb.ENTITY_INFO.FUNCTION_CODE.Attr_TYPE = "A";
        //    tb.ENTITY_INFO.FUNCTION_CODE.LENGTH = "1";

        //    tb.ENTITY_INFO.ENT_TYPE = new XmlNodeEntity();
        //    tb.ENTITY_INFO.ENT_TYPE = "";
        //    tb.ENTITY_INFO.ENT_TYPE.Attr_TYPE = "N";
        //    tb.ENTITY_INFO.ENT_TYPE.LENGTH = "3";

        //    tb.ENTITY_INFO.ENTITY_ID = new XmlNodeEntity();
        //    tb.ENTITY_INFO.ENTITY_ID = "";
        //    tb.ENTITY_INFO.ENTITY_ID.Attr_TYPE = "A";
        //    tb.ENTITY_INFO.ENTITY_ID.LENGTH = "11";

        //    tb.ENTITY_INFO.ACCT_ID = new XmlNodeEntity();
        //    tb.ENTITY_INFO.ACCT_ID = "";
        //    tb.ENTITY_INFO.ACCT_ID.Attr_TYPE = "A";
        //    tb.ENTITY_INFO.ACCT_ID.LENGTH = "12";

        //    tb.ENTITY_INFO.NAME = new XmlNodeEntity();
        //    tb.ENTITY_INFO.NAME = "";
        //    tb.ENTITY_INFO.NAME.Attr_TYPE = "A";
        //    tb.ENTITY_INFO.NAME.LENGTH = "40";

        //    tb.ENTITY_INFO.ADDRESS1 = new XmlNodeEntity();
        //    tb.ENTITY_INFO.ADDRESS1 = "";
        //    tb.ENTITY_INFO.ADDRESS1.Attr_TYPE = "A";
        //    tb.ENTITY_INFO.ADDRESS1.LENGTH = "40";

        //    tb.ENTITY_INFO.ADDRESS2 = new XmlNodeEntity();
        //    tb.ENTITY_INFO.ADDRESS2 = "";
        //    tb.ENTITY_INFO.ADDRESS2.Attr_TYPE = "A";
        //    tb.ENTITY_INFO.ADDRESS2.LENGTH = "40";

        //    tb.ENTITY_INFO.ADDRESS3 = new XmlNodeEntity();
        //    tb.ENTITY_INFO.ADDRESS3 = "";
        //    tb.ENTITY_INFO.ADDRESS3.Attr_TYPE = "A";
        //    tb.ENTITY_INFO.ADDRESS3.LENGTH = "40";

        //    tb.ENTITY_INFO.CITY = new XmlNodeEntity();
        //    tb.ENTITY_INFO.CITY = "";
        //    tb.ENTITY_INFO.CITY.Attr_TYPE = "A";
        //    tb.ENTITY_INFO.CITY.LENGTH = "20";

        //    tb.ENTITY_INFO.STATE = new XmlNodeEntity();
        //    tb.ENTITY_INFO.STATE = "";
        //    tb.ENTITY_INFO.STATE.Attr_TYPE = "A";
        //    tb.ENTITY_INFO.STATE.LENGTH = "2";
        

        //    tb.ENTITY_INFO.ZIP_CODE = new XmlNodeEntity();
        //    tb.ENTITY_INFO.ZIP_CODE = "";
        //    tb.ENTITY_INFO.ZIP_CODE.Attr_TYPE = "A";
        //    tb.ENTITY_INFO.ZIP_CODE.LENGTH = "10";



        //    //TAX_ACCT
        //    tb.TAX_ACCT = new List<RTTIE016.TAX_ACCT>();
        //    foreach (RTTIE016.TAX_ACCT b in tb.TAX_ACCT)
        //    {
 
        //        b.Attr_TYPE = "COMPLEX";
        //        b.OCCURS = "1";
        //        b.LENGTH = "285";
        //        b.EXPORT = "Y";


        //        b.FUNC_CODE = new XmlNodeEntity();
        //        b.FUNC_CODE = "";
        //        b.FUNC_CODE.Attr_TYPE = "A";
        //        b.FUNC_CODE.LENGTH = "12";

        //        b.ACCOUNT = new XmlNodeEntity();
        //        b.ACCOUNT = "";
        //        b.ACCOUNT.Attr_TYPE = "N";
        //        b.ACCOUNT.LENGTH = "15";

        //        b.ACCOUNT_ID = new XmlNodeEntity();
        //        b.ACCOUNT_ID = "";
        //        b.ACCOUNT_ID.Attr_TYPE = "N";
        //        b.ACCOUNT_ID.LENGTH = "15";

        //        b.START_DATE = new XmlNodeEntity();
        //        b.START_DATE = "";
        //        b.START_DATE.Attr_TYPE = "C";
        //        b.START_DATE.LENGTH = "15";

        //        b.END_DATE = new XmlNodeEntity();
        //        b.END_DATE = "";
        //        b.END_DATE.Attr_TYPE = "A";
        //        b.END_DATE.LENGTH = "15";

        //        b.FREQUENCY_CODE = new XmlNodeEntity();
        //        b.FREQUENCY_CODE = "";
        //        b.FREQUENCY_CODE.Attr_TYPE = "N";
        //        b.FREQUENCY_CODE.LENGTH = "15";

        //        b.BRT_ACCOUNT = new XmlNodeEntity();
        //        b.BRT_ACCOUNT = "";
        //        b.BRT_ACCOUNT.Attr_TYPE = "N";
        //        b.BRT_ACCOUNT.LENGTH = "15";

        //        b.BRT_ADDRESS1 = new XmlNodeEntity();
        //        b.BRT_ADDRESS1 = "";
        //        b.BRT_ADDRESS1.Attr_TYPE = "C";
        //        b.BRT_ADDRESS1.LENGTH = "15";
        //    }

        //    //WAGE_NTL
        //    tb.WAGE_NTL = new RTTIE016.WAGE_NTL();
        //    tb.WAGE_NTL.Attr_TYPE = "COMPLEX";
        //    tb.WAGE_NTL.OCCURS = "1";
        //    tb.WAGE_NTL.LENGTH = "285";
        //    tb.WAGE_NTL.EXPORT = "Y";


        //    tb.WAGE_NTL.ACCOUNT_ID = new XmlNodeEntity();
        //    tb.WAGE_NTL.ACCOUNT_ID = "";
        //    tb.WAGE_NTL.ACCOUNT_ID.Attr_TYPE = "A";
        //    tb.WAGE_NTL.ACCOUNT_ID.LENGTH = "12";

        //    tb.WAGE_NTL.PERIOD = new XmlNodeEntity();
        //    tb.WAGE_NTL.PERIOD = "";
        //    tb.WAGE_NTL.PERIOD.Attr_TYPE = "A";
        //    tb.WAGE_NTL.PERIOD.LENGTH = "8";

        //    tb.WAGE_NTL.FREQUENCY_CODE = new XmlNodeEntity();
        //    tb.WAGE_NTL.FREQUENCY_CODE = "";
        //    tb.WAGE_NTL.FREQUENCY_CODE.Attr_TYPE = "A";
        //    tb.WAGE_NTL.FREQUENCY_CODE.LENGTH = "1";

        //    tb.WAGE_NTL.ADJ_REF_NO = new XmlNodeEntity();
        //    tb.WAGE_NTL.ADJ_REF_NO = "";
        //    tb.WAGE_NTL.ADJ_REF_NO.Attr_TYPE = "A";
        //    tb.WAGE_NTL.ADJ_REF_NO.LENGTH = "10";

        //    tb.WAGE_NTL.PREPARER_NAME = new XmlNodeEntity();
        //    tb.WAGE_NTL.PREPARER_NAME = "";
        //    tb.WAGE_NTL.PREPARER_NAME.Attr_TYPE = "A";
        //    tb.WAGE_NTL.PREPARER_NAME.LENGTH = "40";        

        //    tb.WAGE_NTL.PREPARER_PHONE = new XmlNodeEntity();
        //    tb.WAGE_NTL.PREPARER_PHONE = "";
        //    tb.WAGE_NTL.PREPARER_PHONE.Attr_TYPE = "P";
        //    tb.WAGE_NTL.PREPARER_PHONE.LENGTH = "10";

        //    tb.WAGE_NTL.PREPARER_PHONE_EXT = new XmlNodeEntity();
        //    tb.WAGE_NTL.PREPARER_PHONE_EXT = "";
        //    tb.WAGE_NTL.PREPARER_PHONE_EXT.Attr_TYPE = "A";
        //    tb.WAGE_NTL.PREPARER_PHONE_EXT.LENGTH = "5";

        //    tb.WAGE_NTL.PREPARER_IP_ADDRESS = new XmlNodeEntity();
        //    tb.WAGE_NTL.PREPARER_IP_ADDRESS = "";
        //    tb.WAGE_NTL.PREPARER_IP_ADDRESS.Attr_TYPE = "A";
        //    tb.WAGE_NTL.PREPARER_IP_ADDRESS.LENGTH = "15";

        //    tb.WAGE_NTL.PREPARER_EMAIL_ADDRESS = new XmlNodeEntity();
        //    tb.WAGE_NTL.PREPARER_EMAIL_ADDRESS = "";
        //    tb.WAGE_NTL.PREPARER_EMAIL_ADDRESS.Attr_TYPE = "A";
        //    tb.WAGE_NTL.PREPARER_EMAIL_ADDRESS.LENGTH = "60";

        //    tb.WAGE_NTL.PREPARER_WHO = new XmlNodeEntity();
        //    tb.WAGE_NTL.PREPARER_WHO = "";
        //    tb.WAGE_NTL.PREPARER_WHO.Attr_TYPE = "A";
        //    tb.WAGE_NTL.PREPARER_WHO.LENGTH = "1";

        //    //COUPON_FORM
        //    tb.COUPON_FORM = new RTTIE016.COUPON_FORM();
        //    tb.COUPON_FORM.Attr_TYPE = "COMPLEX";
        //    tb.COUPON_FORM.OCCURS = "1";
        //    tb.COUPON_FORM.LENGTH = "296";
        //    tb.COUPON_FORM.EXPORT = "Y";


        //    tb.COUPON_FORM.CPN_ACCOUNT = new XmlNodeEntity();
        //    tb.COUPON_FORM.CPN_ACCOUNT = "";
        //    tb.COUPON_FORM.CPN_ACCOUNT.Attr_TYPE = "A";
        //    tb.COUPON_FORM.CPN_ACCOUNT.LENGTH = "12";

        //    tb.COUPON_FORM.CPN_ACCOUNT_TYPE = new XmlNodeEntity();
        //    tb.COUPON_FORM.CPN_ACCOUNT_TYPE = "";
        //    tb.COUPON_FORM.CPN_ACCOUNT_TYPE.Attr_TYPE = "A";
        //    tb.COUPON_FORM.CPN_ACCOUNT_TYPE.LENGTH = "2";

        //    tb.COUPON_FORM.CPN_NAME = new XmlNodeEntity();
        //    tb.COUPON_FORM.CPN_NAME = "";
        //    tb.COUPON_FORM.CPN_NAME.Attr_TYPE = "A";
        //    tb.COUPON_FORM.CPN_NAME.LENGTH = "40";

        //    tb.COUPON_FORM.CPN_ADDR = new XmlNodeEntity();
        //    tb.COUPON_FORM.CPN_ADDR = "";
        //    tb.COUPON_FORM.CPN_ADDR.Attr_TYPE = "A";
        //    tb.COUPON_FORM.CPN_ADDR.LENGTH = "40";

        //    tb.COUPON_FORM.CPN_ADDR2 = new XmlNodeEntity();
        //    tb.COUPON_FORM.CPN_ADDR2 = "";
        //    tb.COUPON_FORM.CPN_ADDR2.Attr_TYPE = "A";
        //    tb.COUPON_FORM.CPN_ADDR2.LENGTH = "40";

        //    tb.COUPON_FORM.CPN_ADDR3 = new XmlNodeEntity();
        //    tb.COUPON_FORM.CPN_ADDR3 = "";
        //    tb.COUPON_FORM.CPN_ADDR3.Attr_TYPE = "A";
        //    tb.COUPON_FORM.CPN_ADDR3.LENGTH = "40";

        //    tb.COUPON_FORM.CPN_CITY = new XmlNodeEntity();
        //    tb.COUPON_FORM.CPN_CITY = "";
        //    tb.COUPON_FORM.CPN_CITY.Attr_TYPE = "A";
        //    tb.COUPON_FORM.CPN_CITY.LENGTH = "20";

        //    tb.COUPON_FORM.CPN_STATE = new XmlNodeEntity();
        //    tb.COUPON_FORM.CPN_STATE = "";
        //    tb.COUPON_FORM.CPN_STATE.Attr_TYPE = "A";
        //    tb.COUPON_FORM.CPN_STATE.LENGTH = "2";

        //    tb.COUPON_FORM.CPN_ZIP_CODE = new XmlNodeEntity();
        //    tb.COUPON_FORM.CPN_ZIP_CODE = "";
        //    tb.COUPON_FORM.CPN_ZIP_CODE.Attr_TYPE = "A";
        //    tb.COUPON_FORM.CPN_ZIP_CODE.LENGTH = "10";

        //    tb.COUPON_FORM.CPN_SCAN = new XmlNodeEntity();
        //    tb.COUPON_FORM.CPN_SCAN = "";
        //    tb.COUPON_FORM.CPN_SCAN.Attr_TYPE = "A";
        //    tb.COUPON_FORM.CPN_SCAN.LENGTH = "90";

        //    tb.COUPON_FORM.CPN_PERIOD = new XmlNodeEntity();
        //    tb.COUPON_FORM.CPN_PERIOD = "";
        //    tb.COUPON_FORM.CPN_PERIOD.Attr_TYPE = "A";
        //    tb.COUPON_FORM.CPN_PERIOD.LENGTH = "2";

        //    tb.COUPON_FORM.CPN_YEAR = new XmlNodeEntity();
        //    tb.COUPON_FORM.CPN_YEAR = "";
        //    tb.COUPON_FORM.CPN_YEAR.Attr_TYPE = "A";
        //    tb.COUPON_FORM.CPN_YEAR.LENGTH = "4";

        //    tb.COUPON_FORM.CPN_FORM = new XmlNodeEntity();
        //    tb.COUPON_FORM.CPN_FORM = "";
        //    tb.COUPON_FORM.CPN_FORM.Attr_TYPE = "A";
        //    tb.COUPON_FORM.CPN_FORM.LENGTH = "20";
           
        //    return tb;
        //}
    }


}
