using CopRevenueGov2.Service;
using COPXmlFactory;
using COPXmlFactory.RTTIE036;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Xml;

namespace CopRevenueGov2.Helpers
{
    public class RTTIE036 : CopRestServiceBase, ICopSoapService
    {

        static RTTIE236_SrvRef.RTTIE236WS_PortTypeClient _client = null;

        public static void Init()
        {
            _client = COPServiceURLHelper.GetServiceClient_RTTIE236();
        }

        public static string CallService(string Request)
        {
           
            COPXmlFactory.RTTIE036.SCHOOLRETURN xo;

            try
            {
                xo = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE036.SCHOOLRETURN>(Request);

                xo = __Call(xo);

            }
            catch (Exception ex)
            {
                xo =
                    RevenueGovXMLFactory.GetSCHOOLRETURN();

                xo.ERROR_INFO = new ERROR_INFO();
                xo.ERROR_INFO.ERROR = 11.ToString();
                xo.ERROR_INFO.MESSAGE = ex.Message;
            }

            return RevenueGovXMLFactory.GetXmlString(xo);

        }

        public static XmlDocument CallService(XmlDocument Request)
        {
            COPXmlFactory.RTTIE036.SCHOOLRETURN acct;

            try
            {
                string InnerXML = Request.InnerXml;
                acct = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE036.SCHOOLRETURN>(InnerXML);

                acct = __Call(acct);

            }
            catch (Exception ex)
            {
                acct = RevenueGovXMLFactory.GetSCHOOLRETURN();

                acct.ERROR_INFO = new ERROR_INFO();
                acct.ERROR_INFO.ERROR = 11.ToString();
                acct.ERROR_INFO.MESSAGE = ex.Message;
            }

            return RevenueGovXMLFactory.GetXmlDocument(acct);
        }

        private static SCHOOLRETURN __Call(SCHOOLRETURN e)
        {
           
            switch(e.SCHOOL_INFO.RETURN_STATUS)
            {
                case "INQ": // fill
                   // e = __RTTIE036_F_I(e);
                    e = __RTTIE036_F_I("D:/sanghamitra/Sanghamitra Acharya/CopPhase2/SourceCode/EGovCurrent23.5/Xml files/school/SchoolInitResponse.xml");
                    break;
                case null: // submit
                    e = __RTTIE036_F_U(e);
                    break;

                default:
                    e = __RTTIE036_F_I("C:/Sanghamitra/Projects/COP/EGovCurrent23.5/Xml files/school/SchoolInitResponse.xml");
                    break;
            }
            return e;
        }

        //private static COPXmlFactory.RTTIE036.SCHOOLRETURN __RTTIE036_F_I(COPXmlFactory.RTTIE036.SCHOOLRETURN e)
        //{
        //    RTTIE236_SrvRef.RTTIE236 serv_req = new RTTIE236_SrvRef.RTTIE236();

        //    serv_req._ESIT = new RTTIE236_SrvRef._ESIT();

        //    serv_req._ESIT.ACCOUNTID = e.SCHOOL_INFO.ACCOUNT_ID;
        //    serv_req._ESIT.PERIODX = CopMvcUtil.ConvDateDecimal(e.SCHOOL_INFO.PERIOD).ToString();
        //    serv_req._ESIT.RETURNSTATUS = e.SCHOOL_INFO.RETURN_STATUS;

        //    RTTIE236_SrvRef.RTTIE236Response response = _client.RTTIE236(serv_req);

        //    e = _Fill(response);

        //    return e;
        //}
        private static COPXmlFactory.RTTIE036.SCHOOLRETURN __RTTIE036_F_I(string ReplyXMLPath)
        {
            //Read from XML file and return the object

            CopMvcUtil utl = new CopMvcUtil();

            string xmlstring = utl.GetXMLString(ReplyXMLPath);

            COPXmlFactory.RTTIE036.SCHOOLRETURN sch;

            sch = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE036.SCHOOLRETURN>(
                xmlstring);


            return sch;

        }
        private static COPXmlFactory.RTTIE036.SCHOOLRETURN _Fill(RTTIE236_SrvRef.RTTIE236Response e)
        {
            COPXmlFactory.RTTIE036.SCHOOLRETURN fobj = new SCHOOLRETURN();

            //LOAD ERRORS INTO OBJECT
            fobj.ERROR_INFO = new ERROR_INFO();

            fobj.ERROR_INFO.PROGRAM = e._SMA._PROGRAM;
            fobj.ERROR_INFO.LINE = e._SMA.ERRORLINE.ToString();
            fobj.ERROR_INFO.MESSAGE = e._SMA.MESSAGE;
            fobj.ERROR_INFO.ERROR = e._SMA.SYSTEMERROR.ToString();

            //LOAD SCHOOL_INFO 
            fobj.SCHOOL_INFO = new SCHOOL_INFO();
            fobj.SCHOOL_INFO.ACCOUNT_ID = e._ESIT.ACCOUNTID;
            fobj.SCHOOL_INFO.PERIOD = CopMvcUtil.ConvDate(e._ESIT.PERIODX);
            fobj.SCHOOL_INFO.VERSION = e._ESIT.VERSIONX;
            fobj.SCHOOL_INFO.RETURN_STATUS = e._ESIT.RETURNSTATUS;
            fobj.SCHOOL_INFO.LAST_UPD_DATE = CopMvcUtil.ConvDate(e._ESIT.LASTUPDATEDATEX);

            fobj.SCHOOL_INFO.RECORDING_DATE = CopMvcUtil.ConvDate(e._ESIT.RECORDINGDATEX);
            fobj.SCHOOL_INFO.SEQUENCE = e._ESIT.SEQUENCENUM;
            fobj.SCHOOL_INFO.ADJUSTMENT_REF_NO = e._ESIT.ADJUSTMENTREFERENCENUM;
            fobj.SCHOOL_INFO.RATE = CopMvcUtil.ConvDigitToDouble9(e._ESIT.RATE);
            fobj.SCHOOL_INFO.EXTENSION_DATE = CopMvcUtil.ConvDate(e._ESIT.EXTENSIONDATEX);       
            fobj.SCHOOL_INFO.PREPARER_NAME = e._ESIT.PREPARERNAME;
            fobj.SCHOOL_INFO.PREPARER_PHONE = e._ESIT.PREPARERPHONE;
            fobj.SCHOOL_INFO.PREPARER_PHONE_EXT = e._ESIT.PREPARERPHONEEXT;
            fobj.SCHOOL_INFO.PREPARER_IP_ADDRESS = e._ESIT.PREPARERIPADDRESS;
            fobj.SCHOOL_INFO.PREPARER_EMAIL_ADDRESS = e._ESIT.PREPAREREMAILADDRESS;
            fobj.SCHOOL_INFO.PREPARER_WHO = e._ESIT.PREPARERTYPE;

            //   fobj.SCHOOL_INFO.PREPARER_WHO = e._ETOB.;

            //LOAD AMT_INFO 
            fobj.AMT_INFO = new AMT_INFO();
            fobj.AMT_INFO.NET_TAX_DIVIDENDS = CopMvcUtil.ConvDigitToCurrency(e._EAMT.NETTAXABLEDIVIDENDSX).ToString();
            fobj.AMT_INFO.TAXABLE_INTEREST = CopMvcUtil.ConvDigitToCurrency(e._EAMT.TAXABLEINTERESTX).ToString();
            fobj.AMT_INFO.S_CORP_DISTRIBUTIONS = CopMvcUtil.ConvDigitToCurrency(e._EAMT.SCORPDISTRIBUTIONSX).ToString();
            fobj.AMT_INFO.PARTNERSHIP_INCOME = CopMvcUtil.ConvDigitToCurrency(e._EAMT.PARTNERSHIPINCOMEX);
            fobj.AMT_INFO.BENEFICIARY_INCOME = CopMvcUtil.ConvDigitToCurrency(e._EAMT.BENEFICIARYINCOMEX).ToString();
            fobj.AMT_INFO.SHORT_TERM_GAINS = CopMvcUtil.ConvDigitToCurrency(e._EAMT.SHORTTERMGAINSX).ToString();
            fobj.AMT_INFO.NET_RENTAL_INCOME = CopMvcUtil.ConvDigitToCurrency(e._EAMT.NETRENTALINCOMEX).ToString();
            fobj.AMT_INFO.OTHER_TAXABLE_INCOME = CopMvcUtil.ConvDigitToCurrency(e._EAMT.OTHERTAXABLEINCOMEX);
            fobj.AMT_INFO.TOTAL_TAXABLE_INCOME = CopMvcUtil.ConvDigitToCurrency(e._EAMT.TOTALTAXABLEINCOMEX).ToString();
            fobj.AMT_INFO.DEDUCTIBLE_EXPENSES = CopMvcUtil.ConvDigitToCurrency(e._EAMT.DEDUCTIBLEEXPENSESX).ToString();
            fobj.AMT_INFO.NET_TAXABLE_INCOME = CopMvcUtil.ConvDigitToCurrency(e._EAMT.NETTAXABLEINCOMEX).ToString();
            fobj.AMT_INFO.GROSS_TAX_DUE = CopMvcUtil.ConvDigitToCurrency(e._EAMT.GROSSTAXDUEX);
            fobj.AMT_INFO.CREDITS = CopMvcUtil.ConvDigitToCurrency(e._EAMT.CREDITSX);
            fobj.AMT_INFO.TAX_DUE = CopMvcUtil.ConvDigitToCurrency(e._EAMT.TAXDUEX).ToString();
            fobj.AMT_INFO.TAX_REFUND = CopMvcUtil.ConvDigitToCurrency(e._EAMT.REFUNDAMTX);
            fobj.AMT_INFO.TAX_OVERPAID = CopMvcUtil.ConvDigitToCurrency(e._EAMT.OVERPAYMENTX).ToString();

            fobj.AMT_INFO.USER_ID = CopMvcUtil.ConvDigitToCurrency(e._EAMT.USERID);
          
            return fobj;

        }

        private static COPXmlFactory.RTTIE036.SCHOOLRETURN __RTTIE036_F_U(COPXmlFactory.RTTIE036.SCHOOLRETURN e)
        {

            RTTIE236_SrvRef.RTTIE236 serv_req = new RTTIE236_SrvRef.RTTIE236();

            serv_req._ESIT = new RTTIE236_SrvRef._ESIT();
            serv_req._ESIT.ACCOUNTID = e.SCHOOL_INFO.ACCOUNT_ID;
            serv_req._ESIT.VERSIONX = e.SCHOOL_INFO.VERSION;
            serv_req._ESIT.PERIODX = CopMvcUtil.ConvDateDecimal(e.SCHOOL_INFO.PERIOD).ToString();
            serv_req._ESIT.LASTUPDATEDATEX = CopMvcUtil.ConvDateDecimal(e.SCHOOL_INFO.LAST_UPD_DATE).ToString();
            serv_req._ESIT.EXTENSIONDATEX = CopMvcUtil.ConvDateDecimal(e.SCHOOL_INFO.EXTENSION_DATE).ToString();
            serv_req._ESIT.RECORDINGDATEX = CopMvcUtil.ConvDateDecimal(e.SCHOOL_INFO.RECORDING_DATE).ToString();
            serv_req._ESIT.SEQUENCENUM = e.SCHOOL_INFO.SEQUENCE;
            serv_req._ESIT.ADJUSTMENTREFERENCENUM = e.SCHOOL_INFO.ADJUSTMENT_REF_NO;
            serv_req._ESIT.RATE = CopMvcUtil.ConvNumberToDigit9(e.SCHOOL_INFO.RATE);         
            serv_req._ESIT.PREPARERNAME = e.SCHOOL_INFO.PREPARER_NAME;
            serv_req._ESIT.PREPARERPHONE = e.SCHOOL_INFO.PREPARER_PHONE;
            serv_req._ESIT.PREPARERPHONEEXT = e.SCHOOL_INFO.PREPARER_PHONE_EXT;
            serv_req._ESIT.PREPARERIPADDRESS = e.SCHOOL_INFO.PREPARER_IP_ADDRESS;
            serv_req._ESIT.PREPAREREMAILADDRESS = e.SCHOOL_INFO.PREPARER_EMAIL_ADDRESS;
            serv_req._ESIT.PREPARERTYPE = e.SCHOOL_INFO.PREPARER_WHO; ;


            serv_req._EAMT = new RTTIE236_SrvRef._EAMT();
            serv_req._EAMT.NETTAXABLEDIVIDENDSX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.NET_TAX_DIVIDENDS);
            serv_req._EAMT.TAXABLEINTERESTX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.TAXABLE_INTEREST).ToString();
            serv_req._EAMT.SCORPDISTRIBUTIONSX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.S_CORP_DISTRIBUTIONS).ToString();
            serv_req._EAMT.PARTNERSHIPINCOMEX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.PARTNERSHIP_INCOME).ToString();
            serv_req._EAMT.BENEFICIARYINCOMEX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.BENEFICIARY_INCOME).ToString();
            serv_req._EAMT.SHORTTERMGAINSX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.SHORT_TERM_GAINS).ToString();
            serv_req._EAMT.NETRENTALINCOMEX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.NET_RENTAL_INCOME).ToString();
            serv_req._EAMT.OTHERTAXABLEINCOMEX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.OTHER_TAXABLE_INCOME).ToString();
            serv_req._EAMT.TOTALTAXABLEINCOMEX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.TOTAL_TAXABLE_INCOME).ToString();
            serv_req._EAMT.DEDUCTIBLEEXPENSESX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.DEDUCTIBLE_EXPENSES).ToString();
            serv_req._EAMT.NETTAXABLEINCOMEX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.NET_TAXABLE_INCOME).ToString();
            serv_req._EAMT.GROSSTAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.GROSS_TAX_DUE).ToString();
          
            serv_req._EAMT.CREDITSX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.CREDITS).ToString();
            serv_req._EAMT.TAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.TAX_DUE).ToString();
            serv_req._EAMT.REFUNDAMTX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.TAX_REFUND).ToString();
            serv_req._EAMT.OVERPAYMENTX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.TAX_OVERPAID).ToString();
            serv_req._EAMT.USERID = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.USER_ID).ToString();
           


            RTTIE236_SrvRef.RTTIE236Response response = _client.RTTIE236(serv_req);

            e = _Fill(response);

            return e;

        }

    }
}
