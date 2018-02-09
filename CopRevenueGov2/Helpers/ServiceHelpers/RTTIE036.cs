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
        
        public static void Init()
        {
           
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
                   e = __RTTIE036_F_I(e);                    
                    break;
                case null: // submit
                    e = __RTTIE036_F_U(e);
                    break;

                default:
                    e.SCHOOL_INFO.RETURN_STATUS = "INQ";
                    e = __RTTIE036_F_I(e);                    
                    break;
            }
            return e;
        }

        private static COPXmlFactory.RTTIE036.SCHOOLRETURN __RTTIE036_F_I(COPXmlFactory.RTTIE036.SCHOOLRETURN e)
        {
            SIT_RTTIE036_SrvRef.RTTIE036_ESIT _ESIT = new SIT_RTTIE036_SrvRef.RTTIE036_ESIT();
            SIT_RTTIE036_SrvRef.RTTIE036 serv_req = new SIT_RTTIE036_SrvRef.RTTIE036();

            SIT_RTTIE036_SrvRef.RTTIE036Response_SMA _SMAResponse = new SIT_RTTIE036_SrvRef.RTTIE036Response_SMA();
            SIT_RTTIE036_SrvRef.RTTIE036Response_ESIT _ESITResponse = new SIT_RTTIE036_SrvRef.RTTIE036Response_ESIT();
            SIT_RTTIE036_SrvRef.RTTIE036Response_EAMT _EAMTResponse = new SIT_RTTIE036_SrvRef.RTTIE036Response_EAMT();

           _ESIT.ACCOUNTID = e.SCHOOL_INFO.ACCOUNT_ID;
           _ESIT.PERIODX = CopMvcUtil.ConvDateDecimal(e.SCHOOL_INFO.PERIOD).ToString();
           _ESIT.RETURNSTATUS = e.SCHOOL_INFO.RETURN_STATUS;


            _SMAResponse = serv_req.CallRTTIE036
                                            (new SIT_RTTIE036_SrvRef.RTTIE036_SMA(), _ESIT,
                                              new SIT_RTTIE036_SrvRef.RTTIE036_EAMT(),                                              
                                              out _ESITResponse,
                                              out _EAMTResponse
                                            );





            e = _Fill(_SMAResponse, _ESITResponse, _EAMTResponse);

            return e;
            
        }
        
        private static COPXmlFactory.RTTIE036.SCHOOLRETURN _Fill(SIT_RTTIE036_SrvRef.RTTIE036Response_SMA _SMA,SIT_RTTIE036_SrvRef.RTTIE036Response_ESIT _ESIT,SIT_RTTIE036_SrvRef.RTTIE036Response_EAMT _EAMT)
        {
            COPXmlFactory.RTTIE036.SCHOOLRETURN fobj = new SCHOOLRETURN();

            //LOAD ERRORS INTO OBJECT
            fobj.ERROR_INFO = new ERROR_INFO();
            if (fobj.ERROR_INFO.LENGTH != null)
            {
                fobj.ERROR_INFO.PROGRAM = _SMA._PROGRAM;
                fobj.ERROR_INFO.LINE = _SMA.ERRORLINE.ToString();
                fobj.ERROR_INFO.MESSAGE = _SMA.MESSAGE;
                fobj.ERROR_INFO.ERROR = _SMA.SYSTEMERROR.ToString();
            }
            //LOAD SCHOOL_INFO 
            fobj.SCHOOL_INFO = new SCHOOL_INFO();
            
                fobj.SCHOOL_INFO.ACCOUNT_ID = _ESIT.ACCOUNTID;
                fobj.SCHOOL_INFO.PERIOD = CopMvcUtil.ConvDate(_ESIT.PERIODX);
                fobj.SCHOOL_INFO.VERSION = _ESIT.VERSIONX;
                fobj.SCHOOL_INFO.RETURN_STATUS = _ESIT.RETURNSTATUS;
                fobj.SCHOOL_INFO.LAST_UPD_DATE = CopMvcUtil.ConvDate(_ESIT.LASTUPDATEDATEX);

                fobj.SCHOOL_INFO.RECORDING_DATE = CopMvcUtil.ConvDate(_ESIT.RECORDINGDATEX);
                fobj.SCHOOL_INFO.SEQUENCE = _ESIT.SEQUENCENUM;
                fobj.SCHOOL_INFO.ADJUSTMENT_REF_NO = _ESIT.ADJUSTMENTREFERENCENUM;
                fobj.SCHOOL_INFO.RATE = CopMvcUtil.ConvDigitToDouble9(_ESIT.RATE);
                fobj.SCHOOL_INFO.EXTENSION_DATE = CopMvcUtil.ConvDate(_ESIT.EXTENSIONDATEX);
                fobj.SCHOOL_INFO.PREPARER_NAME = _ESIT.PREPARERNAME;
                fobj.SCHOOL_INFO.PREPARER_PHONE = Convert.ToString(_ESIT.PREPARERPHONE);
                fobj.SCHOOL_INFO.PREPARER_PHONE_EXT = _ESIT.PREPARERPHONEEXT;
                fobj.SCHOOL_INFO.PREPARER_IP_ADDRESS = _ESIT.PREPARERIPADDRESS;
                fobj.SCHOOL_INFO.PREPARER_EMAIL_ADDRESS = _ESIT.PREPAREREMAILADDRESS;
                fobj.SCHOOL_INFO.PREPARER_WHO = _ESIT.PREPARERTYPE;
           

            //LOAD AMT_INFO 
            fobj.AMT_INFO = new AMT_INFO();

            
                fobj.AMT_INFO.NET_TAX_DIVIDENDS = CopMvcUtil.ConvDigitToCurrency(_EAMT.NETTAXABLEDIVIDENDSX).ToString();
                fobj.AMT_INFO.TAXABLE_INTEREST = CopMvcUtil.ConvDigitToCurrency(_EAMT.TAXABLEINTERESTX).ToString();
                fobj.AMT_INFO.S_CORP_DISTRIBUTIONS = CopMvcUtil.ConvDigitToCurrency(_EAMT.SCORPDISTRIBUTIONSX).ToString();
                fobj.AMT_INFO.PARTNERSHIP_INCOME = CopMvcUtil.ConvDigitToCurrency(_EAMT.PARTNERSHIPINCOMEX);
                fobj.AMT_INFO.BENEFICIARY_INCOME = CopMvcUtil.ConvDigitToCurrency(_EAMT.BENEFICIARYINCOMEX).ToString();
                fobj.AMT_INFO.SHORT_TERM_GAINS = CopMvcUtil.ConvDigitToCurrency(_EAMT.SHORTTERMGAINSX).ToString();
                fobj.AMT_INFO.NET_RENTAL_INCOME = CopMvcUtil.ConvDigitToCurrency(_EAMT.NETRENTALINCOMEX).ToString();
                fobj.AMT_INFO.OTHER_TAXABLE_INCOME = CopMvcUtil.ConvDigitToCurrency(_EAMT.OTHERTAXABLEINCOMEX);
                fobj.AMT_INFO.TOTAL_TAXABLE_INCOME = CopMvcUtil.ConvDigitToCurrency(_EAMT.TOTALTAXABLEINCOMEX).ToString();
                fobj.AMT_INFO.DEDUCTIBLE_EXPENSES = CopMvcUtil.ConvDigitToCurrency(_EAMT.DEDUCTIBLEEXPENSESX).ToString();
                fobj.AMT_INFO.NET_TAXABLE_INCOME = CopMvcUtil.ConvDigitToCurrency(_EAMT.NETTAXABLEINCOMEX).ToString();
                fobj.AMT_INFO.GROSS_TAX_DUE = CopMvcUtil.ConvDigitToCurrency(_EAMT.GROSSTAXDUEX);
                fobj.AMT_INFO.CREDITS = CopMvcUtil.ConvDigitToCurrency(_EAMT.CREDITSX);
                fobj.AMT_INFO.TAX_DUE = CopMvcUtil.ConvDigitToCurrency(_EAMT.TAXDUEX).ToString();
                fobj.AMT_INFO.TAX_REFUND = CopMvcUtil.ConvDigitToCurrency(_EAMT.REFUNDAMTX);
                fobj.AMT_INFO.TAX_OVERPAID = CopMvcUtil.ConvDigitToCurrency(_EAMT.OVERPAYMENTX).ToString();

                fobj.AMT_INFO.USER_ID = _EAMT.USERID;
            
          
            return fobj;

        }

        private static COPXmlFactory.RTTIE036.SCHOOLRETURN __RTTIE036_F_U(COPXmlFactory.RTTIE036.SCHOOLRETURN e)
        {
            
            SIT_RTTIE036_SrvRef.RTTIE036 serv_req = new SIT_RTTIE036_SrvRef.RTTIE036();
            SIT_RTTIE036_SrvRef.RTTIE036_SMA _SMA = new SIT_RTTIE036_SrvRef.RTTIE036_SMA();
            SIT_RTTIE036_SrvRef.RTTIE036_ESIT _ESIT = new SIT_RTTIE036_SrvRef.RTTIE036_ESIT();
            SIT_RTTIE036_SrvRef.RTTIE036_EAMT _EAMT = new SIT_RTTIE036_SrvRef.RTTIE036_EAMT();


            SIT_RTTIE036_SrvRef.RTTIE036Response_SMA _SMAResponse = new SIT_RTTIE036_SrvRef.RTTIE036Response_SMA();
            SIT_RTTIE036_SrvRef.RTTIE036Response_ESIT _ESITResponse = new SIT_RTTIE036_SrvRef.RTTIE036Response_ESIT();
            SIT_RTTIE036_SrvRef.RTTIE036Response_EAMT _EAMTResponse = new SIT_RTTIE036_SrvRef.RTTIE036Response_EAMT();

           
            _ESIT.ACCOUNTID = e.SCHOOL_INFO.ACCOUNT_ID;
            _ESIT.VERSIONX = e.SCHOOL_INFO.VERSION;
            _ESIT.PERIODX = CopMvcUtil.ConvDateDecimal(e.SCHOOL_INFO.PERIOD).ToString();
            _ESIT.LASTUPDATEDATEX = CopMvcUtil.ConvDateDecimal(e.SCHOOL_INFO.LAST_UPD_DATE).ToString();
            _ESIT.EXTENSIONDATEX = CopMvcUtil.ConvDateDecimal(e.SCHOOL_INFO.EXTENSION_DATE).ToString();
            _ESIT.RECORDINGDATEX = CopMvcUtil.ConvDateDecimal(e.SCHOOL_INFO.RECORDING_DATE).ToString();
            _ESIT.SEQUENCENUM = e.SCHOOL_INFO.SEQUENCE;
            _ESIT.ADJUSTMENTREFERENCENUM = e.SCHOOL_INFO.ADJUSTMENT_REF_NO;
            _ESIT.RATE = CopMvcUtil.ConvNumberToDigit9(e.SCHOOL_INFO.RATE);         
            _ESIT.PREPARERNAME = e.SCHOOL_INFO.PREPARER_NAME;
            _ESIT.PREPARERPHONE =CopMvcUtil.GetDecimal(e.SCHOOL_INFO.PREPARER_PHONE);
            _ESIT.PREPARERPHONEEXT = e.SCHOOL_INFO.PREPARER_PHONE_EXT;
            _ESIT.PREPARERIPADDRESS = e.SCHOOL_INFO.PREPARER_IP_ADDRESS;
            _ESIT.PREPAREREMAILADDRESS = e.SCHOOL_INFO.PREPARER_EMAIL_ADDRESS;
            _ESIT.PREPARERTYPE = e.SCHOOL_INFO.PREPARER_WHO; ;
            _ESIT.PREPARERPHONESpecified = true;

            
            _EAMT.NETTAXABLEDIVIDENDSX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.NET_TAX_DIVIDENDS);
            _EAMT.TAXABLEINTERESTX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.TAXABLE_INTEREST).ToString();
            _EAMT.SCORPDISTRIBUTIONSX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.S_CORP_DISTRIBUTIONS).ToString();
            _EAMT.PARTNERSHIPINCOMEX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.PARTNERSHIP_INCOME).ToString();
            _EAMT.BENEFICIARYINCOMEX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.BENEFICIARY_INCOME).ToString();
            _EAMT.SHORTTERMGAINSX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.SHORT_TERM_GAINS).ToString();
            _EAMT.NETRENTALINCOMEX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.NET_RENTAL_INCOME).ToString();
            _EAMT.OTHERTAXABLEINCOMEX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.OTHER_TAXABLE_INCOME).ToString();
            _EAMT.TOTALTAXABLEINCOMEX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.TOTAL_TAXABLE_INCOME).ToString();
            _EAMT.DEDUCTIBLEEXPENSESX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.DEDUCTIBLE_EXPENSES).ToString();
            _EAMT.NETTAXABLEINCOMEX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.NET_TAXABLE_INCOME).ToString();
            _EAMT.GROSSTAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.GROSS_TAX_DUE).ToString();

            _EAMT.CREDITSX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.CREDITS).ToString();
            _EAMT.TAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.TAX_DUE).ToString();
            _EAMT.REFUNDAMTX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.TAX_REFUND).ToString();
            _EAMT.OVERPAYMENTX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.TAX_OVERPAID).ToString();
            _EAMT.USERID = e.AMT_INFO.USER_ID;

            string _ESITT = CopMvcUtil.GetXMlFromObject(_ESIT);
            string _EAMTT = CopMvcUtil.GetXMlFromObject(_EAMT);

            _SMAResponse = serv_req.CallRTTIE036
                                 (_SMA, _ESIT, _EAMT, out _ESITResponse,
                                  out _EAMTResponse
                                 
                                );



            e = _Fill(_SMAResponse, _ESITResponse, _EAMTResponse);

            return e;
        }

    }
}
