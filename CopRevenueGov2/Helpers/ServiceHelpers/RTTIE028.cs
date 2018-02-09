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
        public static void Init()
        {
           
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
                    e = __RTTIE028_F_I(e);                   
                    break;
                case null: // submit
                    e = __RTTIE028_F_U(e);
                    break;

                default:
                     e.TOBACCO_INFO.RETURN_STATUS = "INQ";
                     e = __RTTIE028_F_I(e);                   
                    break;
            }
            return e;
        }
       
       

        private static COPXmlFactory.RTTIE028.TOBACCORETURN __RTTIE028_F_I(COPXmlFactory.RTTIE028.TOBACCORETURN e)
        {          

            TOBACCO_RTTIE028_SrvRef.RT01E028_ETOB _ETOB = new TOBACCO_RTTIE028_SrvRef.RT01E028_ETOB();
            TOBACCO_RTTIE028_SrvRef.RT01E028 serv_req = new TOBACCO_RTTIE028_SrvRef.RT01E028();
            TOBACCO_RTTIE028_SrvRef.RT01E028Response_SMA _SMAResponse = new TOBACCO_RTTIE028_SrvRef.RT01E028Response_SMA();
            TOBACCO_RTTIE028_SrvRef.RT01E028Response_ETOB _ETOBResponse = new TOBACCO_RTTIE028_SrvRef.RT01E028Response_ETOB();
            TOBACCO_RTTIE028_SrvRef.RT01E028Response_EAMT _EAMTResponse = new TOBACCO_RTTIE028_SrvRef.RT01E028Response_EAMT();
           



            _ETOB.ACCOUNTID = e.TOBACCO_INFO.ACCOUNT_ID;
            _ETOB.PERIODX = CopMvcUtil.ConvDateDecimal(e.TOBACCO_INFO.PERIOD).ToString();
            _ETOB.RETURNSTATUS = e.TOBACCO_INFO.RETURN_STATUS;


            _SMAResponse = serv_req.CallRT01E028
                                            (new TOBACCO_RTTIE028_SrvRef.RT01E028_SMA(), _ETOB,
                                              new TOBACCO_RTTIE028_SrvRef.RT01E028_EAMT(),
                                              out _ETOBResponse,
                                              out _EAMTResponse                                             
                                            );





            e = __Fill(_SMAResponse, _ETOBResponse, _EAMTResponse);
            return e;
        }

        private static COPXmlFactory.RTTIE028.TOBACCORETURN __Fill(TOBACCO_RTTIE028_SrvRef.RT01E028Response_SMA _SMA,TOBACCO_RTTIE028_SrvRef.RT01E028Response_ETOB _ETOB,TOBACCO_RTTIE028_SrvRef.RT01E028Response_EAMT _EAMT)
        {
            COPXmlFactory.RTTIE028.TOBACCORETURN fobj = RevenueGovXMLFactory.GetTOBACCORETURN();

            //LOAD ERRORS INTO OBJECT
            fobj.ERROR_INFO = new ERROR_INFO();
            if (fobj.ERROR_INFO.LENGTH != null)
            {
                fobj.ERROR_INFO.PROGRAM = _SMA._PROGRAM;
                fobj.ERROR_INFO.LINE = _SMA.ERRORLINE.ToString();
                fobj.ERROR_INFO.MESSAGE = _SMA.MESSAGE;
                fobj.ERROR_INFO.ERROR = _SMA.SYSTEMERROR.ToString();
            }
            //LOAD TOBACCO_INFO 
            fobj.TOBACCO_INFO= new TOBACCO_INFO();
            
                fobj.TOBACCO_INFO.ACCOUNT_ID = _ETOB.ACCOUNTID;
                fobj.TOBACCO_INFO.PERIOD = CopMvcUtil.ConvDate(_ETOB.PERIODX);
                fobj.TOBACCO_INFO.VERSION = _ETOB.VERSIONX;
                fobj.TOBACCO_INFO.RETURN_STATUS = _ETOB.RETURNSTATUS;
                fobj.TOBACCO_INFO.LAST_UPD_DATE = CopMvcUtil.ConvDate(_ETOB.LASTUPDATEDATEX);
                fobj.TOBACCO_INFO.USER_ID = _ETOB.USERID;
                fobj.TOBACCO_INFO.RECORDING_DATE = CopMvcUtil.ConvDate(_ETOB.RECORDINGDATEX);
                fobj.TOBACCO_INFO.SEQUENCE = _ETOB.SEQUENCENUM;
                fobj.TOBACCO_INFO.ADJUSTMENT_REF_NO = _ETOB.ADJUSTMENTREFERENCENUM;
                fobj.TOBACCO_INFO.RATE_ITEM = CopMvcUtil.ConvDigitToDouble9(_ETOB.RATEITEM);
                fobj.TOBACCO_INFO.RATE_PACK = CopMvcUtil.ConvDigitToDouble9(_ETOB.RATEPACK);
                fobj.TOBACCO_INFO.RATE_PAPER = CopMvcUtil.ConvDigitToDouble9(_ETOB.RATEPAPER);
                fobj.TOBACCO_INFO.PREPARER_NAME = _ETOB.PREPARERNAME;
                fobj.TOBACCO_INFO.PREPARER_PHONE = Convert.ToString(_ETOB.PREPARERPHONE);
                fobj.TOBACCO_INFO.PREPARER_PHONE_EXT = _ETOB.PREPARERPHONEEXT;
                fobj.TOBACCO_INFO.PREPARER_IP_ADDRESS = _ETOB.PREPARERIPADDRESS;
                fobj.TOBACCO_INFO.PREPARER_EMAIL_ADDRESS = _ETOB.PREPAREREMAILADDRESS;
                fobj.TOBACCO_INFO.PREPARER_WHO = _ETOB.PREPARERTYPE;
            
        

            //LOAD AMT_INFO 
            fobj.AMT_INFO = new AMT_INFO();
           
                fobj.AMT_INFO.ITEM_TOTAL = CopMvcUtil.GetDouble(_EAMT.ITEMTOTALX).ToString();
                fobj.AMT_INFO.ITEM_NOT_PHILA = CopMvcUtil.GetDouble(_EAMT.ITEMNOTPHILAX).ToString();
                fobj.AMT_INFO.ITEM_PHILA = CopMvcUtil.GetDouble(_EAMT.ITEMPHILAX).ToString();
                fobj.AMT_INFO.ITEM_TAX_DUE = CopMvcUtil.ConvDigitToCurrency(_EAMT.ITEMTAXDUEX);
                fobj.AMT_INFO.PACK_TOTAL = CopMvcUtil.GetDouble(_EAMT.PACKTOTALX).ToString();
                fobj.AMT_INFO.PACK_NOT_PHILA = CopMvcUtil.GetDouble(_EAMT.PACKNOTPHILAX).ToString();
                fobj.AMT_INFO.PACK_PHILA = CopMvcUtil.GetDouble(_EAMT.PACKPHILAX).ToString();
                fobj.AMT_INFO.PACK_TAX_DUE = CopMvcUtil.ConvDigitToCurrency(_EAMT.PACKTAXDUEX);
                fobj.AMT_INFO.PAPER_TOTAL = CopMvcUtil.GetDouble(_EAMT.PAPERTOTALX).ToString();
                fobj.AMT_INFO.PAPER_NOT_PHILA = CopMvcUtil.GetDouble(_EAMT.PAPERNOTPHILAX).ToString();
                fobj.AMT_INFO.PAPER_PHILA = CopMvcUtil.GetDouble(_EAMT.PAPERPHILAX).ToString();
                fobj.AMT_INFO.PAPER_TAX_DUE = CopMvcUtil.ConvDigitToCurrency(_EAMT.PAPERTAXDUEX);
                fobj.AMT_INFO.TOTAL_TAX_DUE = CopMvcUtil.ConvDigitToCurrency(_EAMT.TOTALTAXDUEX);
                fobj.AMT_INFO.CREDITS = CopMvcUtil.ConvDigitToCurrency(_EAMT.CREDITSX).ToString();
                fobj.AMT_INFO.NET_TAX_DUE = CopMvcUtil.ConvDigitToCurrency(_EAMT.NETTAXDUEX);
                fobj.AMT_INFO.INTEREST_PENALTY = CopMvcUtil.ConvDigitToCurrency(_EAMT.INTERESTPENALTYX).ToString();

                fobj.AMT_INFO.TOTAL_AMOUNT_DUE = CopMvcUtil.ConvDigitToCurrency(_EAMT.TOTALAMTDUEX);
                fobj.AMT_INFO.REFUND = CopMvcUtil.ConvDigitToCurrency(_EAMT.REFUNDX).ToString();
                fobj.AMT_INFO.ROLL_FORWARD = CopMvcUtil.ConvDigitToCurrency(_EAMT.ROLLFORWARDX).ToString();
           

            
            return fobj;

        }

        private static COPXmlFactory.RTTIE028.TOBACCORETURN __RTTIE028_F_U(COPXmlFactory.RTTIE028.TOBACCORETURN e)
        {            

            TOBACCO_RTTIE028_SrvRef.RT01E028 serv_req = new TOBACCO_RTTIE028_SrvRef.RT01E028();
            TOBACCO_RTTIE028_SrvRef.RT01E028_SMA _SMA = new TOBACCO_RTTIE028_SrvRef.RT01E028_SMA();
            TOBACCO_RTTIE028_SrvRef.RT01E028_ETOB _ETOB = new TOBACCO_RTTIE028_SrvRef.RT01E028_ETOB();
            TOBACCO_RTTIE028_SrvRef.RT01E028_EAMT _EAMT = new TOBACCO_RTTIE028_SrvRef.RT01E028_EAMT();

            TOBACCO_RTTIE028_SrvRef.RT01E028Response_SMA _SMAResponse = new TOBACCO_RTTIE028_SrvRef.RT01E028Response_SMA();
            TOBACCO_RTTIE028_SrvRef.RT01E028Response_ETOB _ETOBResponse = new TOBACCO_RTTIE028_SrvRef.RT01E028Response_ETOB();
            TOBACCO_RTTIE028_SrvRef.RT01E028Response_EAMT _EAMTResponse = new TOBACCO_RTTIE028_SrvRef.RT01E028Response_EAMT();
            

            _ETOB.ACCOUNTID = e.TOBACCO_INFO.ACCOUNT_ID;
            _ETOB.VERSIONX = e.TOBACCO_INFO.VERSION;
            _ETOB.PERIODX = CopMvcUtil.ConvDateDecimal(e.TOBACCO_INFO.PERIOD).ToString();
            _ETOB.LASTUPDATEDATEX = CopMvcUtil.ConvDateDecimal(e.TOBACCO_INFO.LAST_UPD_DATE).ToString();
            _ETOB.USERID = e.TOBACCO_INFO.USER_ID;
            _ETOB.RECORDINGDATEX = CopMvcUtil.ConvDateDecimal(e.TOBACCO_INFO.RECORDING_DATE).ToString();
            _ETOB.SEQUENCENUM = e.TOBACCO_INFO.SEQUENCE;
            _ETOB.ADJUSTMENTREFERENCENUM = e.TOBACCO_INFO.ADJUSTMENT_REF_NO;
            _ETOB.RATEITEM = CopMvcUtil.ConvNumberToDigit9(e.TOBACCO_INFO.RATE_ITEM);
            _ETOB.RATEPACK = CopMvcUtil.ConvNumberToDigit9(e.TOBACCO_INFO.RATE_PACK);
            _ETOB.RATEPAPER = CopMvcUtil.ConvNumberToDigit9(e.TOBACCO_INFO.RATE_PAPER);
            _ETOB.PREPARERNAME = e.TOBACCO_INFO.PREPARER_NAME;
            _ETOB.PREPARERPHONE =CopMvcUtil.GetDecimal(e.TOBACCO_INFO.PREPARER_PHONE);
            _ETOB.PREPARERPHONEEXT = e.TOBACCO_INFO.PREPARER_PHONE_EXT;
            _ETOB.PREPARERIPADDRESS = e.TOBACCO_INFO.PREPARER_IP_ADDRESS;
            _ETOB.PREPAREREMAILADDRESS = e.TOBACCO_INFO.PREPARER_EMAIL_ADDRESS;
            _ETOB.PREPARERTYPE = e.TOBACCO_INFO.PREPARER_WHO;
            _ETOB.PREPARERPHONESpecified = true;

            
            _EAMT.ITEMTOTALX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.ITEM_TOTAL);
            _EAMT.ITEMNOTPHILAX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.ITEM_NOT_PHILA).ToString();
            _EAMT.ITEMPHILAX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.ITEM_PHILA).ToString();
            _EAMT.ITEMTAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.ITEM_TAX_DUE).ToString();
            _EAMT.PACKTOTALX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.PACK_TOTAL).ToString();
            _EAMT.PACKNOTPHILAX =CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.PACK_NOT_PHILA).ToString();
            _EAMT.PACKPHILAX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.PACK_PHILA).ToString();
            _EAMT.PACKTAXDUEX =CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.PACK_TAX_DUE).ToString();
            _EAMT.PAPERTOTALX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.PAPER_TOTAL).ToString();
            _EAMT.PAPERNOTPHILAX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.PAPER_NOT_PHILA).ToString();
            _EAMT.PAPERPHILAX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.PAPER_PHILA).ToString();
            _EAMT.PAPERTAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.PAPER_TAX_DUE).ToString();
            _EAMT.TOTALTAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.TOTAL_TAX_DUE).ToString();
            _EAMT.CREDITSX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.CREDITS).ToString();
            _EAMT.NETTAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.NET_TAX_DUE).ToString();
            _EAMT.INTERESTPENALTYX =CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.INTEREST_PENALTY).ToString();
            _EAMT.TOTALAMTDUEX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.TOTAL_AMOUNT_DUE).ToString();
            _EAMT.REFUNDX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.REFUND).ToString();
            _EAMT.ROLLFORWARDX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.ROLL_FORWARD).ToString();
            string ETOB = CopMvcUtil.GetXMlFromObject(_ETOB);
            string EAMT = CopMvcUtil.GetXMlFromObject(_EAMT);
            _SMAResponse = serv_req.CallRT01E028
                                            (_SMA, _ETOB,
                                             _EAMT,
                                              out _ETOBResponse,
                                              out _EAMTResponse
                                            );





            e = __Fill(_SMAResponse, _ETOBResponse, _EAMTResponse);
            return e;
        }
    }

}
