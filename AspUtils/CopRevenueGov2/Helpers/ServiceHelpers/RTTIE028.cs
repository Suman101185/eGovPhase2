using CopRevenueGov2.Service;
using COPXmlFactory;
using COPXmlFactory.RTTIE028;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Xml;

namespace CopRevenueGov2.Helpers
{
    public class RTTIE028 : CopRestServiceBase, ICopSoapService
    {

        static RTTIE228_SrvRef.RTTIE228WS_PortTypeClient _client = null;

        public static void Init()
        {
            _client = COPServiceURLHelper.GetServiceClient_RTTIE228();
        }

        public static string CallService(string Request)
        {
            COPXmlFactory.RTTIE028.TOBACCORETURN xo;

            try
            {
                xo = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE028.TOBACCORETURN>(Request);

                xo = __Call(xo);

            }
            catch (Exception ex)
            {
                xo =
                    RevenueGovXMLFactory.GetTOBACCORETURN();

                xo.ERROR_INFO = new ERROR_INFO();
                xo.ERROR_INFO.ERROR = 11.ToString();
                xo.ERROR_INFO.MESSAGE = ex.Message;
            }

            return RevenueGovXMLFactory.GetXmlString(xo);

        }

        public static XmlDocument CallService(XmlDocument Request)
        {
            COPXmlFactory.RTTIE028.TOBACCORETURN acct;

            try
            {
                string InnerXML = Request.InnerXml;
                acct = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE028.TOBACCORETURN>(InnerXML);

                acct = __Call(acct);

            }
            catch (Exception ex)
            {
                acct = RevenueGovXMLFactory.GetTOBACCORETURN();

                acct.ERROR_INFO = new ERROR_INFO();
                acct.ERROR_INFO.ERROR = 11.ToString();
                acct.ERROR_INFO.MESSAGE = ex.Message;
            }

            return RevenueGovXMLFactory.GetXmlDocument(acct);
        }
        private static TOBACCORETURN __Call(TOBACCORETURN e)
        {
            switch (e.TOBACCO_INFO.RETURN_STATUS)
            {
                case "INQ": // fill
                    // e = __RTTIE028_F_I(e);
                    e = __RTTIE028_F_I("D:/sanghamitra/Sanghamitra Acharya/CopPhase2/SourceCode/EGovCurrent23.5/Xml files/Tobacco/tobaccoInitResponse.xml");
                    //D:\sanghamitra\Sanghamitra Acharya\CopPhase2\SourceCode\EGovCurrent23.5\Xml files\Tobacco
                    break;
                case null: // submit
                    e = __RTTIE028_F_U(e);
                    break;

                default:
                    // e = __RTTIE028_F_I(e);
                    e = __RTTIE028_F_I("D:/sanghamitra/Sanghamitra Acharya/CopPhase2/SourceCode/EGovCurrent23.5/Xml files/Tobacco/tobaccoInitResponse.xml");
                    break;
            }
            return e;
        }
        private static COPXmlFactory.RTTIE028.TOBACCORETURN __RTTIE028_F_I(string ReplyXMLPath)
        {
            //Read from XML file and return the object

            CopMvcUtil utl = new CopMvcUtil();

            string xmlstring = utl.GetXMLString(ReplyXMLPath);

            COPXmlFactory.RTTIE028.TOBACCORETURN e;

            e = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE028.TOBACCORETURN>(
                xmlstring);


            return e;

        }
        //private static TOBACCORETURN __Call(TOBACCORETURN e)
        //{
        //    switch (e.TOBACCO_INFO.RETURN_STATUS)
        //    {
        //        case "INQ": // fill
        //            e = __RTTIE028_F_I(e);
        //            break;
        //        case null: // submit
        //            e = __RTTIE028_F_U(e);
        //            break;
               
        //        default:
        //            e = __RTTIE028_F_I(e);
        //            break;
        //    }
        //    return e;
        //}

        //private static COPXmlFactory.RTTIE028.TOBACCORETURN __RTTIE028_F_I(COPXmlFactory.RTTIE028.TOBACCORETURN e)
        //{
        //    RTTIE228_SrvRef.RTTIE228 serv_req = new RTTIE228_SrvRef.RTTIE228();

        //    serv_req._ETOB= new RTTIE228_SrvRef._ETOB();

        //    serv_req._ETOB.ACCOUNTID = e.TOBACCO_INFO.ACCOUNT_ID;
        //    serv_req._ETOB.PERIODX = CopMvcUtil.ConvDateDecimal(e.TOBACCO_INFO.PERIOD).ToString();
        //    serv_req._ETOB.RETURNSTATUS = e.TOBACCO_INFO.RETURN_STATUS;

        //    RTTIE228_SrvRef.RTTIE228Response response = _client.RTTIE228(serv_req);

        //    e = __Fill(response);

        //    return e;
        //}

        private static COPXmlFactory.RTTIE028.TOBACCORETURN __Fill(RTTIE228_SrvRef.RTTIE228Response e)
        {
            COPXmlFactory.RTTIE028.TOBACCORETURN fobj = RevenueGovXMLFactory.GetTOBACCORETURN();

            //LOAD ERRORS INTO OBJECT
            fobj.ERROR_INFO = new ERROR_INFO();

            fobj.ERROR_INFO.PROGRAM = e._SMA._PROGRAM;
            fobj.ERROR_INFO.LINE = e._SMA.ERRORLINE.ToString();
            fobj.ERROR_INFO.MESSAGE = e._SMA.MESSAGE;
            fobj.ERROR_INFO.ERROR = e._SMA.SYSTEMERROR.ToString();

            //LOAD TOBACCO_INFO 
            fobj.TOBACCO_INFO= new TOBACCO_INFO();
            fobj.TOBACCO_INFO.ACCOUNT_ID = e._ETOB.ACCOUNTID;
            fobj.TOBACCO_INFO.PERIOD = CopMvcUtil.ConvDate(e._ETOB.PERIODX);
            fobj.TOBACCO_INFO.VERSION = e._ETOB.VERSIONX;
            fobj.TOBACCO_INFO.RETURN_STATUS = e._ETOB.RETURNSTATUS;
            fobj.TOBACCO_INFO.LAST_UPD_DATE = CopMvcUtil.ConvDate(e._ETOB.LASTUPDATEDATEX);
            fobj.TOBACCO_INFO.USER_ID = e._ETOB.USERID;
            fobj.TOBACCO_INFO.RECORDING_DATE =CopMvcUtil.ConvDate(e._ETOB.RECORDINGDATEX);
            fobj.TOBACCO_INFO.SEQUENCE = e._ETOB.SEQUENCENUM;
            fobj.TOBACCO_INFO.ADJUSTMENT_REF_NO = e._ETOB.ADJUSTMENTREFERENCENUM;
            fobj.TOBACCO_INFO.RATE_ITEM = CopMvcUtil.ConvDigitToDouble9(e._ETOB.RATEITEM);
            fobj.TOBACCO_INFO.RATE_PACK = CopMvcUtil.ConvDigitToDouble9(e._ETOB.RATEPACK);
            fobj.TOBACCO_INFO.RATE_PAPER = CopMvcUtil.ConvDigitToDouble9(e._ETOB.RATEPAPER);
            fobj.TOBACCO_INFO.PREPARER_NAME = e._ETOB.PREPARERNAME;
            fobj.TOBACCO_INFO.PREPARER_PHONE = e._ETOB.PREPARERPHONE;
            fobj.TOBACCO_INFO.PREPARER_PHONE_EXT = e._ETOB.PREPARERPHONEEXT;
            fobj.TOBACCO_INFO.PREPARER_IP_ADDRESS = e._ETOB.PREPARERIPADDRESS;
            fobj.TOBACCO_INFO.PREPARER_EMAIL_ADDRESS = e._ETOB.PREPAREREMAILADDRESS;
            fobj.TOBACCO_INFO.PREPARER_WHO = e._ETOB.PREPARERTYPE;

         //   fobj.TOBACCO_INFO.PREPARER_WHO = e._ETOB.;

            //LOAD AMT_INFO 
            fobj.AMT_INFO = new AMT_INFO();
            fobj.AMT_INFO.ITEM_TOTAL = CopMvcUtil.GetDouble(e._EAMT.ITEMTOTALX).ToString();
            fobj.AMT_INFO.ITEM_NOT_PHILA = CopMvcUtil.GetDouble(e._EAMT.ITEMNOTPHILAX).ToString();
            fobj.AMT_INFO.ITEM_PHILA = CopMvcUtil.GetDouble(e._EAMT.ITEMPHILAX).ToString();
            fobj.AMT_INFO.ITEM_TAX_DUE = CopMvcUtil.ConvDigitToCurrency(e._EAMT.ITEMTAXDUEX);
            fobj.AMT_INFO.PACK_TOTAL = CopMvcUtil.GetDouble(e._EAMT.PACKTOTALX).ToString();
            fobj.AMT_INFO.PACK_NOT_PHILA = CopMvcUtil.GetDouble(e._EAMT.PACKNOTPHILAX).ToString();
            fobj.AMT_INFO.PACK_PHILA = CopMvcUtil.GetDouble(e._EAMT.PACKPHILAX).ToString();
            fobj.AMT_INFO.PACK_TAX_DUE =CopMvcUtil.ConvDigitToCurrency(e._EAMT.PACKTAXDUEX);
            fobj.AMT_INFO.PAPER_TOTAL =CopMvcUtil.GetDouble(e._EAMT.PAPERTOTALX).ToString();
            fobj.AMT_INFO.PAPER_NOT_PHILA = CopMvcUtil.GetDouble(e._EAMT.PAPERNOTPHILAX).ToString();
            fobj.AMT_INFO.PAPER_PHILA = CopMvcUtil.GetDouble(e._EAMT.PAPERPHILAX).ToString();
            fobj.AMT_INFO.PAPER_TAX_DUE = CopMvcUtil.ConvDigitToCurrency(e._EAMT.PAPERTAXDUEX);
            fobj.AMT_INFO.TOTAL_TAX_DUE = CopMvcUtil.ConvDigitToCurrency(e._EAMT.TOTALTAXDUEX);
            fobj.AMT_INFO.CREDITS = CopMvcUtil.ConvDigitToCurrency(e._EAMT.CREDITSX).ToString();
            fobj.AMT_INFO.NET_TAX_DUE = CopMvcUtil.ConvDigitToCurrency(e._EAMT.NETTAXDUEX);
            fobj.AMT_INFO.INTEREST_PENALTY = CopMvcUtil.ConvDigitToCurrency(e._EAMT.INTERESTPENALTYX).ToString();

            fobj.AMT_INFO.TOTAL_AMOUNT_DUE =CopMvcUtil.ConvDigitToCurrency(e._EAMT.TOTALAMTDUEX);
            fobj.AMT_INFO.REFUND = CopMvcUtil.ConvDigitToCurrency(e._EAMT.REFUNDX).ToString();
            fobj.AMT_INFO.ROLL_FORWARD = CopMvcUtil.ConvDigitToCurrency(e._EAMT.ROLLFORWARDX).ToString();
          

            
            return fobj;

        }

        private static COPXmlFactory.RTTIE028.TOBACCORETURN __RTTIE028_F_U(COPXmlFactory.RTTIE028.TOBACCORETURN e)
        {

            RTTIE228_SrvRef.RTTIE228 serv_req = new RTTIE228_SrvRef.RTTIE228();

            serv_req._ETOB = new RTTIE228_SrvRef._ETOB();
            serv_req._ETOB.ACCOUNTID = e.TOBACCO_INFO.ACCOUNT_ID;
            serv_req._ETOB.VERSIONX = e.TOBACCO_INFO.VERSION;
            serv_req._ETOB.PERIODX = CopMvcUtil.ConvDateDecimal(e.TOBACCO_INFO.PERIOD).ToString();
            serv_req._ETOB.LASTUPDATEDATEX = CopMvcUtil.ConvDateDecimal(e.TOBACCO_INFO.LAST_UPD_DATE).ToString();
            serv_req._ETOB.USERID = e.TOBACCO_INFO.USER_ID;
            serv_req._ETOB.RECORDINGDATEX = CopMvcUtil.ConvDateDecimal(e.TOBACCO_INFO.RECORDING_DATE).ToString();
            serv_req._ETOB.SEQUENCENUM = e.TOBACCO_INFO.SEQUENCE;
            serv_req._ETOB.ADJUSTMENTREFERENCENUM = e.TOBACCO_INFO.ADJUSTMENT_REF_NO;
            serv_req._ETOB.RATEITEM = CopMvcUtil.ConvNumberToDigit9(e.TOBACCO_INFO.RATE_ITEM);
            serv_req._ETOB.RATEPACK = CopMvcUtil.ConvNumberToDigit9(e.TOBACCO_INFO.RATE_PACK);
            serv_req._ETOB.RATEPAPER = CopMvcUtil.ConvNumberToDigit9(e.TOBACCO_INFO.RATE_PAPER);
            serv_req._ETOB.PREPARERNAME = e.TOBACCO_INFO.PREPARER_NAME;
            serv_req._ETOB.PREPARERPHONE = e.TOBACCO_INFO.PREPARER_PHONE;
            serv_req._ETOB.PREPARERPHONEEXT = e.TOBACCO_INFO.PREPARER_PHONE_EXT;
            serv_req._ETOB.PREPARERIPADDRESS = e.TOBACCO_INFO.PREPARER_IP_ADDRESS;
            serv_req._ETOB.PREPAREREMAILADDRESS = e.TOBACCO_INFO.PREPARER_EMAIL_ADDRESS;
            serv_req._ETOB.PREPARERTYPE = e.TOBACCO_INFO.PREPARER_WHO; ;
            

            serv_req._EAMT = new RTTIE228_SrvRef._EAMT();
            serv_req._EAMT.ITEMTOTALX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.ITEM_TOTAL);
            serv_req._EAMT.ITEMNOTPHILAX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.ITEM_NOT_PHILA).ToString();
            serv_req._EAMT.ITEMPHILAX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.ITEM_PHILA).ToString();
            serv_req._EAMT.ITEMTAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.ITEM_TAX_DUE).ToString();
            serv_req._EAMT.PACKTOTALX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.PACK_TOTAL).ToString();
            serv_req._EAMT.PACKNOTPHILAX =CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.PACK_NOT_PHILA).ToString();
            serv_req._EAMT.PACKPHILAX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.PACK_PHILA).ToString();
            serv_req._EAMT.PACKTAXDUEX =CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.PACK_TAX_DUE).ToString();
            serv_req._EAMT.PAPERTOTALX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.PAPER_TOTAL).ToString();
            serv_req._EAMT.PAPERNOTPHILAX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.PAPER_NOT_PHILA).ToString();
            serv_req._EAMT.PAPERPHILAX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.PAPER_PHILA).ToString();
            serv_req._EAMT.PAPERTAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.PAPER_TAX_DUE).ToString();
            serv_req._EAMT.TOTALTAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.TOTAL_TAX_DUE).ToString();
            serv_req._EAMT.CREDITSX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.CREDITS).ToString();
            serv_req._EAMT.NETTAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.NET_TAX_DUE).ToString();
            serv_req._EAMT.INTERESTPENALTYX =CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.INTEREST_PENALTY).ToString();
            serv_req._EAMT.TOTALAMTDUEX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.TOTAL_AMOUNT_DUE).ToString();
            serv_req._EAMT.REFUNDX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.REFUND).ToString();
            serv_req._EAMT.ROLLFORWARDX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.ROLL_FORWARD).ToString();



            
            RTTIE228_SrvRef.RTTIE228Response response = _client.RTTIE228(serv_req);

            e = __Fill(response);

            return e;

        }
    }

}
