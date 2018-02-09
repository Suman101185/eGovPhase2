using CopRevenueGov2.Service;
using COPXmlFactory;
using COPXmlFactory.RTTIE039_2015;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Xml;

namespace CopRevenueGov2.Helpers
{
    public class RTTIE039_2015 : CopRestServiceBase, ICopSoapService
    {

        static RTTIE239_SrvRef.RTTIE239WS_PortTypeClient _client = null;

        public static void Init()
        {
            _client = COPServiceURLHelper.GetServiceClient_RTTIE239();
        }

        public static string CallService(string Request)
        {
            COPXmlFactory.RTTIE039_2015.NPTRETURN xo;

            try
            {
                xo = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE039_2015.NPTRETURN>(Request);

                xo = __Call(xo);

            }
            catch (Exception ex)
            {
                xo =
                    RevenueGovXMLFactory.GetNPT_2015Return();

                xo.ERROR_INFO = new ERROR_INFO();
                xo.ERROR_INFO.ERROR = 11.ToString();
                xo.ERROR_INFO.MESSAGE = ex.Message;
            }

            return RevenueGovXMLFactory.GetXmlString(xo);

        }

        public static XmlDocument CallService(XmlDocument Request)
        {
            COPXmlFactory.RTTIE039_2015.NPTRETURN acct;

            try
            {
                string InnerXML = Request.InnerXml;
                acct = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE039_2015.NPTRETURN>(InnerXML);

                acct = __Call(acct);

            }
            catch (Exception ex)
            {
                acct = RevenueGovXMLFactory.GetNPT_2015Return();

                acct.ERROR_INFO = new ERROR_INFO();
                acct.ERROR_INFO.ERROR = 11.ToString();
                acct.ERROR_INFO.MESSAGE = ex.Message;
            }

            return RevenueGovXMLFactory.GetXmlDocument(acct);
        }
        private static NPTRETURN __Call(NPTRETURN e)
        {
            switch (e.NPT_INFO.RETURN_STATUS)
            {
                case "INQ":
                    //  e = __RTTIE039_F_I(e);
                    e = __RTTIE039_F_I("D:/sanghamitra/Sanghamitra Acharya/CopPhase2/SourceCode/EGovCurrent23.5/Xml files/Npt/NPTSubmitResponse.xml");
                    break;
                case null: // submit
                    e = __RTTIE039_F_U(e);
                    break;

                default:
                    {
                        e.NPT_INFO.RETURN_STATUS = "INQ";
                        //  e = __RTTIE039_F_I(e);
                        e = __RTTIE039_F_I("D:/sanghamitra/Sanghamitra Acharya/CopPhase2/SourceCode/EGovCurrent23.5/Xml files/Npt/NPTSubmitResponse.xml");
                        break;
                    }
            }


            return e;
        }
        private static COPXmlFactory.RTTIE039_2015.NPTRETURN __RTTIE039_F_I(string ReplyXMLPath)
        {
            //Read from XML file and return the object

            CopMvcUtil utl = new CopMvcUtil();

            string xmlstring = utl.GetXMLString(ReplyXMLPath);

            COPXmlFactory.RTTIE039_2015.NPTRETURN e;

            e = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE039_2015.NPTRETURN>(
                xmlstring);


            return e;

        }
        //private static NPTRETURN __Call(NPTRETURN e)
        //{
        //    switch (e.NPT_INFO.RETURN_STATUS)
        //    {
        //        case "INQ":
        //            e = __RTTIE039_F_I(e);
        //            break;
        //        case null: // submit
        //            e = __RTTIE039_F_U(e);
        //           break;

        //        default:
        //            {
        //                e.NPT_INFO.RETURN_STATUS = "INQ";
        //                e = __RTTIE039_F_I(e);
        //                break;
        //            }
        //    }


        //    return e;
        //}

        //private static COPXmlFactory.RTTIE039_2015.NPTRETURN __RTTIE039_F_I(COPXmlFactory.RTTIE039_2015.NPTRETURN e)
        //{
        //    RTTIE239_SrvRef.RTTIE239 serv_req = new RTTIE239_SrvRef.RTTIE239();

        //    serv_req._ENPT = new RTTIE239_SrvRef._ENPT();

        //    serv_req._ENPT.ACCOUNTID = e.NPT_INFO.ACCOUNT_ID;
        //    serv_req._ENPT.PERIODX = CopMvcUtil.ConvDateDecimal(e.NPT_INFO.PERIOD).ToString();
        //    serv_req._ENPT.RETURNSTATUS = e.NPT_INFO.RETURN_STATUS;

        //    RTTIE239_SrvRef.RTTIE239Response response = _client.RTTIE239(serv_req);

        //    e = __Fill(response);

        //    return e;
        //}

        private static COPXmlFactory.RTTIE039_2015.NPTRETURN __Fill(RTTIE239_SrvRef.RTTIE239Response e)
        {
            COPXmlFactory.RTTIE039_2015.NPTRETURN fobj = RevenueGovXMLFactory.GetNPT_2015Return();

            //LOAD ERRORS INTO OBJECT
            fobj.ERROR_INFO = new ERROR_INFO();

            fobj.ERROR_INFO.PROGRAM = e._SMA._PROGRAM;
            fobj.ERROR_INFO.LINE = e._SMA.ERRORLINE.ToString();
            fobj.ERROR_INFO.MESSAGE = e._SMA.MESSAGE;
            fobj.ERROR_INFO.ERROR = e._SMA.SYSTEMERROR.ToString();

            //LOAD NPT_INFO 
            fobj.NPT_INFO = new NPT_INFO();
            fobj.NPT_INFO.ACCOUNT_ID = e._ENPT.ACCOUNTID;
            fobj.NPT_INFO.PERIOD = CopMvcUtil.ConvDate(e._ENPT.PERIODX);
            fobj.NPT_INFO.VERSION = e._ENPT.VERSIONX;
            fobj.NPT_INFO.RETURN_STATUS = e._ENPT.RETURNSTATUS;
            fobj.NPT_INFO.LAST_UPD_DATE = CopMvcUtil.ConvDate(e._ENPT.LASTUPDATEDATEX);
            fobj.NPT_INFO.RECORDING_DATE = CopMvcUtil.ConvDate(e._ENPT.RECORDINGDATEX);
            fobj.NPT_INFO.EXTENSION_DATE = CopMvcUtil.ConvDate(e._ENPT.EXTENSIONDATEX);
            fobj.NPT_INFO.SEQUENCE = e._ENPT.SEQUENCENUMBER;
            fobj.NPT_INFO.ADJUSTMENT_REF_NO = e._ENPT.ADJUSTMENTREFERENCENUM;
            fobj.NPT_INFO.USER_ID = e._ENPT.USERID;
            fobj.NPT_INFO.RESIDENT_RATE = CopMvcUtil.ConvDigitToDouble9(e._ENPT.RATERES);
            fobj.NPT_INFO.NON_RES_RATE = CopMvcUtil.ConvDigitToDouble9(e._ENPT.RATENONRES);
            fobj.NPT_INFO.PREPARER_NAME = e._ENPT.PREPARERNAME;

            if ((CopMvcUtil.GetLong(e._ENPT.PREPARERPHONE) == 0))
            {
                fobj.NPT_INFO.PREPARER_PHONE = string.Empty;
            }
            else
            {
                fobj.NPT_INFO.PREPARER_PHONE = CopMvcUtil.GetString(e._ENPT.PREPARERPHONE);
            }
            // fobj.NPT_INFO.PREPARER_PHONE = CopMvcUtil.GetString(e._ENPT.PREPARERPHONE);

            fobj.NPT_INFO.PREPARER_PHONE_EXT = e._ENPT.PREPARERPHONEEXT;
            fobj.NPT_INFO.PREPARER_IP_ADDRESS = e._ENPT.PREPARERIPADDRESS;
            fobj.NPT_INFO.PREPARER_EMAIL_ADDRESS = e._ENPT.PREPAREREMAILADDRESS;
            fobj.NPT_INFO.PREPARER_WHO = e._ENPT.PREPARERTYPE;

            //NPT_PG1
            fobj.NPT_PG1 = new NPT_PG1();
            //Modified and added some new fields
            fobj.NPT_PG1.RESIDENT_INCOME_NOT_ELIGIBLE = CopMvcUtil.ConvDigitToCurrency(e._EAMTS.RESTAXABLEINCOMEX);
            fobj.NPT_PG1.RESIDENT_INCOME_TAX_NOT_ELIGIBLE = CopMvcUtil.ConvDigitToCurrency(e._EAMTS.RESTAXDUEX);
            fobj.NPT_PG1.RESIDENT_INCOME_ELIGIBLE = CopMvcUtil.ConvDigitToCurrency(e._EAMTS.NONRESTAXINCOMEX);
            fobj.NPT_PG1.RES_INCOME_TAX_ELIGIBLE = CopMvcUtil.ConvDigitToCurrency(e._EAMTS.NONRESTAXDUEX);

            fobj.NPT_PG1.RESIDENT_TOTAL_TAX = CopMvcUtil.ConvDigitToCurrency(e._EAMTS.RESTAXABLEINCOMEX);
            fobj.NPT_PG1.NON_RES_INCOME_NOT_ELIGIBLE = CopMvcUtil.ConvDigitToCurrency(e._EAMTS.RESTAXDUEX);
            fobj.NPT_PG1.NON_RES_INCOME_TAX_NOT_ELIGIBLE = CopMvcUtil.ConvDigitToCurrency(e._EAMTS.NONRESTAXINCOMEX);
            fobj.NPT_PG1.NON_RES_INCOME_ELIGIBLE = CopMvcUtil.ConvDigitToCurrency(e._EAMTS.NONRESTAXDUEX);
            fobj.NPT_PG1.NON_RES_INCOME_TAX_ELIGIBLE = CopMvcUtil.ConvDigitToCurrency(e._EAMTS.RESTAXABLEINCOMEX);
            fobj.NPT_PG1.NON_RES_TOTAL_TAX = CopMvcUtil.ConvDigitToCurrency(e._EAMTS.RESTAXDUEX);
       

            fobj.NPT_PG1.TOTAL_TAX = CopMvcUtil.ConvDigitToCurrency(e._EAMTS.TOTALTAXDUE1X);
            fobj.NPT_PG1.BPT_TAX_CREDIT = CopMvcUtil.ConvDigitToCurrency(e._EAMTS.BPTCREDITX);
            fobj.NPT_PG1.OTHER_TAX_CREDIT = CopMvcUtil.ConvDigitToCurrency(e._EAMTS.OTHERX);
            fobj.NPT_PG1.TOTAL_PAY_CREDITS = CopMvcUtil.ConvDigitToCurrency(e._EAMTS.TOTALCREDITSX);
            fobj.NPT_PG1.TAX_DUE = CopMvcUtil.ConvDigitToCurrency(e._EAMTS.TOTALTAXDUEX);
            fobj.NPT_PG1.INTEREST_PENALTY = CopMvcUtil.ConvDigitToCurrency(e._EAMTS.INTERESTPENALTYX);
            fobj.NPT_PG1.TOTAL_DUE = CopMvcUtil.ConvDigitToCurrency(e._EAMTS.TOTALTAXDUEX);
            fobj.NPT_PG1.OVERPAY = CopMvcUtil.ConvDigitToCurrency(e._EAMTS.TAXOVERPAIDX);
            fobj.NPT_PG1.LINE17 = CopMvcUtil.ConvDigitToCurrency(e._EAMTS.NETPROFITESTX);
            fobj.NPT_PG1.BALANCE = CopMvcUtil.ConvDigitToCurrency(e._EAMTS.NETPROFITESTX);//newly added
            fobj.NPT_PG1.REFUND = CopMvcUtil.ConvDigitToCurrency(e._EAMTS.REFUNDAMTX);
            fobj.NPT_PG1.BPT_OVERPAY = CopMvcUtil.ConvDigitToCurrency(e._EAMTS.BPTOVERPAYMENTX);
            fobj.NPT_PG1.NPT_OVERPAY = CopMvcUtil.ConvDigitToCurrency(e._EAMTS.NPTOVERPAYMENTX);

            return fobj;

        }

        private static COPXmlFactory.RTTIE039_2015.NPTRETURN __RTTIE039_F_U(COPXmlFactory.RTTIE039_2015.NPTRETURN e)
        {

            RTTIE239_SrvRef.RTTIE239 serv_req = new RTTIE239_SrvRef.RTTIE239();

            serv_req._ENPT = new RTTIE239_SrvRef._ENPT();
            serv_req._ENPT.ACCOUNTID = e.NPT_INFO.ACCOUNT_ID;
            serv_req._ENPT.PERIODX = CopMvcUtil.ConvDateDecimalString(e.NPT_INFO.PERIOD);
            serv_req._ENPT.VERSIONX = e.NPT_INFO.VERSION;
            serv_req._ENPT.RETURNSTATUS = e.NPT_INFO.RETURN_STATUS;
            serv_req._ENPT.LASTUPDATEDATEX = CopMvcUtil.ConvDateDecimalString(e.NPT_INFO.LAST_UPD_DATE);
            serv_req._ENPT.RECORDINGDATEX = CopMvcUtil.ConvDateDecimalString(e.NPT_INFO.RECORDING_DATE);
            serv_req._ENPT.EXTENSIONDATEX = CopMvcUtil.ConvDateDecimalString(e.NPT_INFO.EXTENSION_DATE);
            serv_req._ENPT.SEQUENCENUMBER = e.NPT_INFO.SEQUENCE;
            serv_req._ENPT.ADJUSTMENTREFERENCENUM = e.NPT_INFO.ADJUSTMENT_REF_NO;
            serv_req._ENPT.USERID = e.NPT_INFO.USER_ID;
            serv_req._ENPT.RATERES = CopMvcUtil.ConvNumberToDigit9(e.NPT_INFO.RESIDENT_RATE);
            serv_req._ENPT.RATENONRES = CopMvcUtil.ConvNumberToDigit9(e.NPT_INFO.NON_RES_RATE);
            serv_req._ENPT.PREPARERNAME = e.NPT_INFO.PREPARER_NAME;

            serv_req._ENPT.PREPARERPHONE = CopMvcUtil.ConvDecimal(e.NPT_INFO.PREPARER_PHONE);
            serv_req._ENPT.PREPARERPHONESpecified = CopMvcUtil.IsSpecified(e.NPT_INFO.PREPARER_PHONE);



            serv_req._ENPT.PREPARERPHONEEXT = e.NPT_INFO.PREPARER_PHONE_EXT;
            serv_req._ENPT.PREPARERIPADDRESS = e.NPT_INFO.PREPARER_IP_ADDRESS;
            serv_req._ENPT.PREPAREREMAILADDRESS = e.NPT_INFO.PREPARER_EMAIL_ADDRESS;
            serv_req._ENPT.PREPARERTYPE = e.NPT_INFO.PREPARER_WHO;


            serv_req._EAMTS = new RTTIE239_SrvRef._EAMTS();
            //  Added some new fields
            serv_req._EAMTS.RESTAXABLEINCOMEX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.RESIDENT_INCOME_NOT_ELIGIBLE);
            serv_req._EAMTS.RESTAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.RESIDENT_INCOME_TAX_NOT_ELIGIBLE);
            serv_req._EAMTS.NONRESTAXINCOMEX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.RESIDENT_INCOME_ELIGIBLE);
            serv_req._EAMTS.NONRESTAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.RES_INCOME_TAX_ELIGIBLE);

            serv_req._EAMTS.NONRESTAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.RESIDENT_TOTAL_TAX);
            serv_req._EAMTS.NONRESTAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.NON_RES_INCOME_NOT_ELIGIBLE);
            serv_req._EAMTS.NONRESTAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.NON_RES_INCOME_TAX_NOT_ELIGIBLE);
            serv_req._EAMTS.NONRESTAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.NON_RES_INCOME_ELIGIBLE);
            serv_req._EAMTS.NONRESTAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.NON_RES_INCOME_TAX_ELIGIBLE);
            serv_req._EAMTS.NONRESTAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.NON_RES_TOTAL_TAX);

            serv_req._EAMTS.TOTALTAXDUE1X = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.TOTAL_TAX);
            serv_req._EAMTS.BPTCREDITX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.BPT_TAX_CREDIT);
            serv_req._EAMTS.OTHERX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.OTHER_TAX_CREDIT);
            serv_req._EAMTS.TOTALCREDITSX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.TOTAL_PAY_CREDITS);
            serv_req._EAMTS.TOTALTAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.TAX_DUE);
            serv_req._EAMTS.INTERESTPENALTYX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.INTEREST_PENALTY);
            serv_req._EAMTS.TOTALAMTDUEX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.TOTAL_DUE);
            serv_req._EAMTS.TAXOVERPAIDX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.OVERPAY);
            serv_req._EAMTS.NETPROFITESTX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.LINE17);
            serv_req._EAMTS.NETPROFITESTX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.BALANCE);

            serv_req._EAMTS.REFUNDAMTX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.REFUND);
            serv_req._EAMTS.BPTOVERPAYMENTX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.BPT_OVERPAY);
            serv_req._EAMTS.NPTOVERPAYMENTX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.NPT_OVERPAY);

            RTTIE239_SrvRef.RTTIE239Response response = _client.RTTIE239(serv_req);

            e = __Fill(response);

            return e;

        }
    }
}