
using CopRevenueGov2.Service;
using COPXmlFactory;
using COPXmlFactory.RTTIE010;
using COPXmlFactory.RTTIE037;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml;

namespace CopRevenueGov2.Helpers
{
    public class RTTIE037 : CopRestServiceBase, ICopSoapService
    {
        
     static RTTIE237_SrvRef.RTTIE237WS_PortTypeClient _client = null;

        public static void Init()
        {
            _client = COPServiceURLHelper.GetServiceClient_RTTIE037();
        }

        public static string CallService(string Request)
        {
            COPXmlFactory.RTTIE037.BPTezReturn xo;

            try
            {
                xo = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE037.BPTezReturn>(
                    Request);

                xo =   __Call(xo);

            }
            catch (Exception ex)
            {
                xo =
                    RevenueGovXMLFactory.GetBPTezReturn();

                xo.ERROR_INFO = new ERROR_INFO();
                xo.ERROR_INFO.ERROR = 11.ToString();
                xo.ERROR_INFO.MESSAGE = ex.Message;
            }

            return RevenueGovXMLFactory.GetXmlString(xo);

        }

        public static XmlDocument CallService(XmlDocument Request)
        {
            COPXmlFactory.RTTIE037.BPTezReturn acct;

            try
            {
                string InnerXML = Request.InnerXml;
                acct = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE037.BPTezReturn>(
                    InnerXML);

                acct = __Call(acct);

            }
            catch (Exception ex)
            {
                acct =
                    RevenueGovXMLFactory.GetBPTezReturn();

                acct.ERROR_INFO = new ERROR_INFO();
                acct.ERROR_INFO.ERROR = 11.ToString();
                acct.ERROR_INFO.MESSAGE = ex.Message;
            }

            return RevenueGovXMLFactory.GetXmlDocument(acct);
        }
        private static BPTezReturn __Call(BPTezReturn e)
        {

            switch (e.BPT_INFO.RETURN_STATUS)
            {
                case "INQ":
                    // e = __RTTIE037_F_I(e);
                    e = __RTTIE037_F_I("D:/sanghamitra/Sanghamitra Acharya/CopPhase2/SourceCode/EGovCurrent23.5/Xml files/BptEz/BptEzInitResponse.xml");

                    break;
                case null: // submit
                    e = __RTTIE037_F_U(e);

                    break;

                default:
                    {
                        e.BPT_INFO.RETURN_STATUS = "INQ";
                        //  e = __RTTIE037_F_I(e);
                        e = __RTTIE037_F_I("D:/sanghamitra/Sanghamitra Acharya/CopPhase2/SourceCode/EGovCurrent23.5/Xml files/BptEz/BptEzInitResponse.xml");
                        break;
                    }
            }


            return e;
        }
        private static COPXmlFactory.RTTIE037.BPTezReturn __RTTIE037_F_I(string ReplyXMLPath)
        {
            //Read from XML file and return the object

            CopMvcUtil utl = new CopMvcUtil();

            string xmlstring = utl.GetXMLString(ReplyXMLPath);

            COPXmlFactory.RTTIE037.BPTezReturn e;

            e = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE037.BPTezReturn>(
                xmlstring);


            return e;

        }
        //private static BPTezReturn __Call(BPTezReturn e)
        //{

        //    switch (e.BPT_INFO.RETURN_STATUS)
        //    {
        //        case "INQ":
        //            e = __RTTIE037_F_I(e);
        //            break;
        //        case null: // submit
        //            e = __RTTIE037_F_U(e);
        //            break;

        //        default:
        //            {
        //            e.BPT_INFO.RETURN_STATUS = "INQ";
        //            e = __RTTIE037_F_I(e);
        //            break;
        //            }
        //    }
           

        //    return e;
        //}
        //private static COPXmlFactory.RTTIE037.BPTezReturn __RTTIE037_F_I(COPXmlFactory.RTTIE037.BPTezReturn e)
        //{
        //    RTTIE237_SrvRef.RTTIE237 serv_req = new RTTIE237_SrvRef.RTTIE237();

        //    serv_req._EBPT = new RTTIE237_SrvRef._EBPT();
           
        //    serv_req._EBPT.ACCOUNTID= e.BPT_INFO.ACCOUNT_ID;
        //    serv_req._EBPT.PERIODX = CopMvcUtil.ConvDateDecimal(e.BPT_INFO.PERIOD).ToString();
        //    serv_req._EBPT.RETURNSTATUS = e.BPT_INFO.RETURN_STATUS;
        //    serv_req._EBPT.PREPARERPHONESpecified = true;

            
        //     RTTIE237_SrvRef.RTTIE237Response response = _client.RTTIE237(serv_req);

        //    e = __Fill(response);

        //    return e;

        //}
        private static COPXmlFactory.RTTIE037.BPTezReturn __Fill(RTTIE237_SrvRef.RTTIE237Response  e)
        {
            COPXmlFactory.RTTIE037.BPTezReturn fobj = new BPTezReturn();

            //LOAD ERRORS INTO OBJECT
            fobj.ERROR_INFO = new ERROR_INFO();

            fobj.ERROR_INFO.PROGRAM = e._SMA._PROGRAM;
            fobj.ERROR_INFO.LINE = e._SMA.ERRORLINE.ToString();
            fobj.ERROR_INFO.MESSAGE = e._SMA.MESSAGE;
            fobj.ERROR_INFO.ERROR = e._SMA.SYSTEMERROR.ToString();

            //LOAD BPT INFOS 
            fobj.BPT_INFO = new BPT_INFO();
            fobj.BPT_INFO.ACCOUNT_ID = e._EBPT.ACCOUNTID;
            fobj.BPT_INFO.ADJUSTMENT_REF_NO = e._EBPT.ADJUSTMENTREFERENCENUM;
            fobj.BPT_INFO.PERIOD = CopMvcUtil.ConvDate(CopMvcUtil.GetDecimal(e._EBPT.PERIODX));
            fobj.BPT_INFO.VERSION = e._EBPT.VERSIONX;        
            fobj.BPT_INFO.RETURN_STATUS = e._EBPT.RETURNSTATUS;
            fobj.BPT_INFO.LAST_UPD_DATE = CopMvcUtil.ConvDate(CopMvcUtil.GetDecimal(e._EBPT.LASTUPDATEDATEX));
            fobj.BPT_INFO.RECORDING_DATE = CopMvcUtil.ConvDate(CopMvcUtil.GetDecimal(e._EBPT.RECORDINGDATEX));
            fobj.BPT_INFO.EXTENSION_DATE = CopMvcUtil.ConvDate(CopMvcUtil.GetDecimal(e._EBPT.EXTENSIONDATEX));
            fobj.BPT_INFO.SEQUENCE = e._EBPT.SEQUENCENUM;
            fobj.BPT_INFO.USER_ID =e._EBPT.USERID;
            fobj.BPT_INFO.NET_RATE = CopMvcUtil.ConvDigitToDouble9(e._EBPT.NETRATE);
            fobj.BPT_INFO.GROSS_RATE = CopMvcUtil.ConvDigitToDouble9(e._EBPT.GROSSRATE);
            fobj.BPT_INFO.PREPARER_NAME = e._EBPT.PREPARERNAME;



            if ((CopMvcUtil.GetLong(e._EBPT.PREPARERPHONE) == 0))
            {
                fobj.BPT_INFO.PREPARER_PHONE = string.Empty;
            }
            else
            {
                fobj.BPT_INFO.PREPARER_PHONE = CopMvcUtil.GetString(e._EBPT.PREPARERPHONE);
            }
           
            fobj.BPT_INFO.PREPARER_PHONE_EXT = e._EBPT.PREPARERPHONEEXT;
            fobj.BPT_INFO.PREPARER_IP_ADDRESS = e._EBPT.PREPARERIPADDRESS;
            fobj.BPT_INFO.PREPARER_EMAIL_ADDRESS = e._EBPT.PREPAREREMAILADDRESS;
            fobj.BPT_INFO.PREPARER_WHO = e._EBPT.PREPARERTYPE;
            // Unused : fobj.BPT_INFO.PREPARER_WHO = ???

            //LOAD BPT_PG1

            fobj.BPT_PG1 = new BPT_PG1();

            fobj.BPT_PG1.NET_TAX = CopMvcUtil.ConvDigitToCurrency(e._EPG1.TAXONNETX);
            fobj.BPT_PG1.GROSS_TAX = CopMvcUtil.ConvDigitToCurrency(e._EPG1.TAXONGROSSX);
            fobj.BPT_PG1.ACTUAL_TAX = CopMvcUtil.ConvDigitToCurrency(e._EPG1.ACTUALTAXX);
            fobj.BPT_PG1.ESTIMATED_TAX = CopMvcUtil.ConvDigitToCurrency(e._EPG1.ESTIMATEDTAXX);
            fobj.BPT_PG1.TOTAL_TAX = CopMvcUtil.ConvDigitToCurrency(e._EPG1.TOTALTAXX);
            fobj.BPT_PG1.NPT_TAX_CREDIT = CopMvcUtil.ConvDigitToCurrency(e._EPG1.NPTTAXCREDITX);
            fobj.BPT_PG1.BPT_TAX_CREDIT = CopMvcUtil.ConvDigitToCurrency(e._EPG1.BPTTAXCREDITX);

            fobj.BPT_PG1.TOTAL_PAY_CREDITS =CopMvcUtil.ConvDigitToCurrency(e._EPG1.TOTALPAYMNTSCREDITSX);
            fobj.BPT_PG1.TAX_DUE = CopMvcUtil.ConvDigitToCurrency(e._EPG1.TOTALTAXX);
            fobj.BPT_PG1.INTEREST_PENALTY = CopMvcUtil.ConvDigitToCurrency(e._EPG1.INTERESTANDPENALTYAMTX);
            fobj.BPT_PG1.AMOUNT_OWED = CopMvcUtil.ConvDigitToCurrency(e._EPG1.AMTOWED2X);
            fobj.BPT_PG1.REFUND = CopMvcUtil.ConvDigitToCurrency(e._EPG1.REFUNDAMTX);
            fobj.BPT_PG1.NPT_OVERPAY=CopMvcUtil.ConvDigitToCurrency(e._EPG1.NPTOVERPAYMENTX);
            fobj.BPT_PG1.BPT_OVERPAY=CopMvcUtil.ConvDigitToCurrency(e._EPG1.BPTOVERPAYMENTX);

            //LOAD BPT_PG2
           
            fobj.BPT_PG2 = new BPT_PG2();
            fobj.BPT_PG2.NET_INCOME_LOSS_1 = CopMvcUtil.ConvDigitToCurrency(e._EEZPG2.NETINCOMELOSS1X);
            fobj.BPT_PG2.NET_INCOME_LOSS_2 = CopMvcUtil.ConvDigitToCurrency(e._EEZPG2.NETINCOMELOSS2X);
            fobj.BPT_PG2.LOSS_CARRY_FORWARD = CopMvcUtil.ConvDigitToCurrency(e._EEZPG2.LOSSCARRYFORWARDX);
            fobj.BPT_PG2.TAXABLE_INCOME = CopMvcUtil.ConvDigitToCurrency(e._EEZPG2.TAXABLEINCOMEX);

            fobj.BPT_PG2.TAX_DUE_NET = CopMvcUtil.ConvDigitToCurrency(e._EEZPG2.TAXDUEXNET);
            fobj.BPT_PG2.SALES_RENTAL = CopMvcUtil.ConvDigitToCurrency(e._EEZPG2.SALESRENTALSX);
            fobj.BPT_PG2.SERVICES = CopMvcUtil.ConvDigitToCurrency(e._EEZPG2.SERVICESX);
            fobj.BPT_PG2.RENTAL_PROPERTY = CopMvcUtil.ConvDigitToCurrency(e._EEZPG2.RENTALPROPERTYX);

            fobj.BPT_PG2.ROYALTIES = CopMvcUtil.ConvDigitToCurrency(e._EEZPG2.ROYALTIESX);
            fobj.BPT_PG2.CAPITAL_GAINS = CopMvcUtil.ConvDigitToCurrency(e._EEZPG2.CAPITALGAINSX);
            fobj.BPT_PG2.STOCK_GAINS =  CopMvcUtil.ConvDigitToCurrency(e._EEZPG2.STOCKGAINSX);
            fobj.BPT_PG2.DIVIDENDS =  CopMvcUtil.ConvDigitToCurrency(e._EEZPG2.DIVIDENDSX);
            fobj.BPT_PG2.INTEREST = CopMvcUtil.ConvDigitToDouble(e._EEZPG2.INTERESTX);
            fobj.BPT_PG2.OTHER = CopMvcUtil.ConvDigitToCurrency(e._EEZPG2.OTHERX);
            fobj.BPT_PG2.TAXABLE_GROSS_RCPTS = CopMvcUtil.ConvDigitToCurrency(e._EEZPG2.TAXABLEGROSSRECEIPTSX);
            fobj.BPT_PG2.TAX_DUE_GROSS = CopMvcUtil.ConvDigitToCurrency(e._EEZPG2.TAXDUEXGROSS);
            return fobj;

        }
        private static COPXmlFactory.RTTIE037.BPTezReturn __RTTIE037_F_U(COPXmlFactory.RTTIE037.BPTezReturn e)
        {

            RTTIE237_SrvRef.RTTIE237 serv_req = new RTTIE237_SrvRef.RTTIE237();
            
            serv_req._EBPT = new RTTIE237_SrvRef._EBPT();
            serv_req._EBPT.ACCOUNTID = e.BPT_INFO.ACCOUNT_ID;
            serv_req._EBPT.VERSIONX = e.BPT_INFO.VERSION;
            serv_req._EBPT.PERIODX = CopMvcUtil.ConvDateDecimalString(e.BPT_INFO.PERIOD);
            serv_req._EBPT.RETURNSTATUS = e.BPT_INFO.RETURN_STATUS;
            serv_req._EBPT.LASTUPDATEDATEX =CopMvcUtil.ConvDateDecimalString(e.BPT_INFO.LAST_UPD_DATE);
            serv_req._EBPT.RECORDINGDATEX = CopMvcUtil.ConvDateDecimalString(e.BPT_INFO.RECORDING_DATE);
            serv_req._EBPT.EXTENSIONDATEX = CopMvcUtil.ConvDateDecimalString(e.BPT_INFO.EXTENSION_DATE);
            serv_req._EBPT.SEQUENCENUM = e.BPT_INFO.SEQUENCE;
            serv_req._EBPT.ADJUSTMENTREFERENCENUM = e.BPT_INFO.ADJUSTMENT_REF_NO;
            serv_req._EBPT.USERID = e.BPT_INFO.USER_ID;
            serv_req._EBPT.NETRATE = e.BPT_INFO.NET_RATE;
            serv_req._EBPT.GROSSRATE = e.BPT_INFO.GROSS_RATE;
            serv_req._EBPT.PREPARERNAME = e.BPT_INFO.PREPARER_NAME;


            serv_req._EBPT.PREPARERPHONESpecified = CopMvcUtil.IsSpecified(e.BPT_INFO.PREPARER_PHONE);
            serv_req._EBPT.PREPARERPHONE = CopMvcUtil.ConvDecimal(e.BPT_INFO.PREPARER_PHONE);

          
            serv_req._EBPT.PREPARERPHONEEXT=e.BPT_INFO.PREPARER_PHONE_EXT;
            serv_req._EBPT.PREPARERIPADDRESS = e.BPT_INFO.PREPARER_IP_ADDRESS;         
            serv_req._EBPT.PREPAREREMAILADDRESS = e.BPT_INFO.PREPARER_EMAIL_ADDRESS;
            serv_req._EBPT.PREPARERTYPE = e.BPT_INFO.PREPARER_WHO;

            serv_req._EPG1 = new RTTIE237_SrvRef._EPG1();
            serv_req._EPG1.TAXONNETX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.NET_TAX);
            serv_req._EPG1.TAXONGROSSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.GROSS_TAX);
            serv_req._EPG1.ACTUALTAXX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.ACTUAL_TAX);
            serv_req._EPG1.ESTIMATEDTAXX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.ESTIMATED_TAX);
            serv_req._EPG1.TOTALTAXX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.TOTAL_TAX);
            serv_req._EPG1.NPTTAXCREDITX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.NPT_TAX_CREDIT);
            serv_req._EPG1.BPTTAXCREDITX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.BPT_TAX_CREDIT);
            serv_req._EPG1.TOTALPAYMNTSCREDITSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.TOTAL_PAY_CREDITS);
            serv_req._EPG1.TAXDUEAMTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.TAX_DUE);
            serv_req._EPG1.INTERESTANDPENALTYAMTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.INTEREST_PENALTY);
            serv_req._EPG1.AMTOWED2X = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.AMOUNT_OWED);
            serv_req._EPG1.REFUNDAMTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.REFUND);
            serv_req._EPG1.NPTOVERPAYMENTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.NPT_OVERPAY);
            serv_req._EPG1.BPTOVERPAYMENTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.BPT_OVERPAY);

            serv_req._EEZPG2 = new RTTIE237_SrvRef._EEZPG2();
            serv_req._EEZPG2.NETINCOMELOSS1X = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG2.NET_INCOME_LOSS_1);
            serv_req._EEZPG2.NETINCOMELOSS2X = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG2.NET_INCOME_LOSS_2);
            serv_req._EEZPG2.LOSSCARRYFORWARDX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG2.LOSS_CARRY_FORWARD);
            serv_req._EEZPG2.TAXABLEINCOMEX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG2.TAXABLE_INCOME);
            serv_req._EEZPG2.TAXDUEXNET = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG2.TAX_DUE_NET);
            serv_req._EEZPG2.SALESRENTALSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG2.SALES_RENTAL);
            serv_req._EEZPG2.SERVICESX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG2.SERVICES);
            serv_req._EEZPG2.RENTALPROPERTYX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG2.RENTAL_PROPERTY);
            serv_req._EEZPG2.ROYALTIESX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG2.ROYALTIES);
            serv_req._EEZPG2.CAPITALGAINSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG2.CAPITAL_GAINS);
            serv_req._EEZPG2.STOCKGAINSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG2.STOCK_GAINS);
            serv_req._EEZPG2.DIVIDENDSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG2.DIVIDENDS);
            serv_req._EEZPG2.INTERESTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG2.INTEREST);
            serv_req._EEZPG2.OTHERX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG2.OTHER);
            serv_req._EEZPG2.TAXABLEGROSSRECEIPTSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG2.TAXABLE_GROSS_RCPTS);
            serv_req._EEZPG2.TAXDUEXGROSS = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG2.TAX_DUE_GROSS);

            RTTIE237_SrvRef.RTTIE237Response response = _client.RTTIE237(serv_req);

            e = __Fill(response);
         
            return e;

        }
    }
}
