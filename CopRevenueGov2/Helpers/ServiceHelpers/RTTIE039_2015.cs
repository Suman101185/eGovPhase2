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
         
        public static void Init()
        {
         
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
                    e = __RTTIE039_F_I(e);
                    break;
                case null: // submit
                    e = __RTTIE039_F_U(e);
                    break;

                default:
                    {
                        e.NPT_INFO.RETURN_STATUS = "INQ";
                        e = __RTTIE039_F_I(e);
                        break;
                    }
            }


            return e;
        }

        private static COPXmlFactory.RTTIE039_2015.NPTRETURN __RTTIE039_F_I(COPXmlFactory.RTTIE039_2015.NPTRETURN e)
        {

            RTTIE040_SrvRef.RT01E040_ENPT _ENPT = new RTTIE040_SrvRef.RT01E040_ENPT();
            RTTIE040_SrvRef.RT01E040 rttie040 = new RTTIE040_SrvRef.RT01E040();           
            //
            _ENPT.ACCOUNTID = e.NPT_INFO.ACCOUNT_ID;
            _ENPT.PERIODX = CopMvcUtil.ConvDateDecimal(e.NPT_INFO.PERIOD).ToString();
            _ENPT.RETURNSTATUS = e.NPT_INFO.RETURN_STATUS;
            //
            RTTIE040_SrvRef.RT01E040Response_SMA _SMAResponse = new RTTIE040_SrvRef.RT01E040Response_SMA();
            RTTIE040_SrvRef.RT01E040Response_ENPT _ENPTResponse = new RTTIE040_SrvRef.RT01E040Response_ENPT();
            RTTIE040_SrvRef.RT01E040Response_EAMTS _EAMTSResponse = new RTTIE040_SrvRef.RT01E040Response_EAMTS();
            RTTIE040_SrvRef.RT01E040Response_SERR _SERRRespose = new RTTIE040_SrvRef.RT01E040Response_SERR();
            //
            _SMAResponse = rttie040.CallRT01E040(new RTTIE040_SrvRef.RT01E040_SMA(), _ENPT, new RTTIE040_SrvRef.RT01E040_EAMTS(),new RTTIE040_SrvRef.RT01E040_SERR(),
                 out _ENPTResponse, out _EAMTSResponse, out _SERRRespose);

            e = __Fill(_SMAResponse, _ENPTResponse, _EAMTSResponse, _SERRRespose);
            return e;


        }


        private static COPXmlFactory.RTTIE039_2015.NPTRETURN __Fill(RTTIE040_SrvRef.RT01E040Response_SMA _SMA, RTTIE040_SrvRef.RT01E040Response_ENPT _ENPT,
            RTTIE040_SrvRef.RT01E040Response_EAMTS _EAMTS, RTTIE040_SrvRef.RT01E040Response_SERR _SERR)
        {
            COPXmlFactory.RTTIE039_2015.NPTRETURN fobj = RevenueGovXMLFactory.GetNPT_2015Return();

            //LOAD ERRORS INTO OBJECT
            fobj.ERROR_INFO = new ERROR_INFO();
            if (fobj.ERROR_INFO.LENGTH != null)
            {
                fobj.ERROR_INFO.PROGRAM = _SMA._PROGRAM;
                fobj.ERROR_INFO.LINE = _SMA.ERRORLINE.ToString();
                fobj.ERROR_INFO.MESSAGE = _SMA.MESSAGE;
                fobj.ERROR_INFO.ERROR = _SMA.SYSTEMERROR.ToString();
            }
            //LOAD NPT_INFO 
            fobj.NPT_INFO = new NPT_INFO();
           
                fobj.NPT_INFO.ACCOUNT_ID = _ENPT.ACCOUNTID;
                fobj.NPT_INFO.PERIOD = CopMvcUtil.ConvDate(_ENPT.PERIODX);
                fobj.NPT_INFO.VERSION = _ENPT.VERSIONX;
                fobj.NPT_INFO.RETURN_STATUS = _ENPT.RETURNSTATUS;
                fobj.NPT_INFO.LAST_UPD_DATE = CopMvcUtil.ConvDate(_ENPT.LASTUPDATEDATEX);
                fobj.NPT_INFO.RECORDING_DATE = CopMvcUtil.ConvDate(_ENPT.RECORDINGDATEX);
                fobj.NPT_INFO.EXTENSION_DATE = CopMvcUtil.ConvDate(_ENPT.EXTENSIONDATEX);
                fobj.NPT_INFO.SEQUENCE = _ENPT.SEQUENCENUMBER;
                fobj.NPT_INFO.ADJUSTMENT_REF_NO = _ENPT.ADJUSTMENTREFERENCENUM;
                fobj.NPT_INFO.USER_ID = _ENPT.USERID;

                fobj.NPT_INFO.RESIDENT_RATE = CopMvcUtil.ConvDigitToDouble9(_ENPT.RATERES);
                fobj.NPT_INFO.BASE_RESIDENT_RATE = CopMvcUtil.ConvDigitToDouble9(_ENPT.BASERATERES);
                fobj.NPT_INFO.NON_RES_RATE = CopMvcUtil.ConvDigitToDouble9(_ENPT.RATENONRES);
                fobj.NPT_INFO.BASE_NON_RES_RATE = CopMvcUtil.ConvDigitToDouble9(_ENPT.BASERATENONRES);
                //fobj.NPT_INFO.CORP_PARTNER_IND = _ENPT.CORPPARTNERIND;

                fobj.NPT_INFO.PREPARER_NAME = _ENPT.PREPARERNAME;

                if ((CopMvcUtil.GetLong(_ENPT.PREPARERPHONE) == 0))
                {
                    fobj.NPT_INFO.PREPARER_PHONE = string.Empty;
                }
                else
                {
                    fobj.NPT_INFO.PREPARER_PHONE = CopMvcUtil.GetString(_ENPT.PREPARERPHONE);
                }


                fobj.NPT_INFO.PREPARER_PHONE_EXT = _ENPT.PREPARERPHONEEXT;
                fobj.NPT_INFO.PREPARER_IP_ADDRESS = _ENPT.PREPARERIPADDRESS;
                fobj.NPT_INFO.PREPARER_EMAIL_ADDRESS = _ENPT.PREPAREREMAILADDRESS;
                fobj.NPT_INFO.PREPARER_WHO = _ENPT.PREPARERTYPE;
            
            //NPT_PG1
            fobj.NPT_PG1 = new NPT_PG1();
            //Modified and added some new fields
            //resident
           
                fobj.NPT_PG1.RESIDENT_INCOME = CopMvcUtil.ConvDigitToCurrency(_EAMTS.RESTAXABLEINCOMEX);
                fobj.NPT_PG1.RESIDENT_INCOME_TAX = CopMvcUtil.ConvDigitToCurrency(_EAMTS.RESTAXDUEX);
                fobj.NPT_PG1.RESIDENT_BASE_INCOME_TAXABLE = CopMvcUtil.ConvDigitToCurrency(_EAMTS.RESBASERATETAXABLEX);
                fobj.NPT_PG1.RESIDENT_BASE_INCOME_TAX = CopMvcUtil.ConvDigitToCurrency(_EAMTS.RESBASERATETAXX);
                fobj.NPT_PG1.RESIDENT_TOTAL_TAX = CopMvcUtil.ConvDigitToCurrency(_EAMTS.TOTALRESTAXX);
                //non resident
                fobj.NPT_PG1.NON_RES_INCOME = CopMvcUtil.ConvDigitToCurrency(_EAMTS.NONRESTAXINCOMEX);
                fobj.NPT_PG1.NON_RES_INCOME_TAX = CopMvcUtil.ConvDigitToCurrency(_EAMTS.NONRESTAXDUEX);
                fobj.NPT_PG1.NON_RES_BASE_INCOME_TAXABLE = CopMvcUtil.ConvDigitToCurrency(_EAMTS.NONRESBASERATETAXABLEX);
                fobj.NPT_PG1.NON_RES_BASE_INCOME_TAX = CopMvcUtil.ConvDigitToCurrency(_EAMTS.NONRESBASERATETAXX);
                fobj.NPT_PG1.NON_RES_TOTAL_TAX = CopMvcUtil.ConvDigitToCurrency(_EAMTS.TOTALNONRESTAXX);

                fobj.NPT_PG1.TOTAL_TAX = CopMvcUtil.ConvDigitToCurrency(_EAMTS.TOTALTAXDUE1X);
                //
                fobj.NPT_PG1.BPT_TAX_CREDIT = CopMvcUtil.ConvDigitToCurrency(_EAMTS.BPTCREDITX);
                fobj.NPT_PG1.OTHER_TAX_CREDIT = CopMvcUtil.ConvDigitToCurrency(_EAMTS.OTHERX);
                fobj.NPT_PG1.TOTAL_PAY_CREDITS = CopMvcUtil.ConvDigitToCurrency(_EAMTS.TOTALCREDITSX);
                fobj.NPT_PG1.TAX_DUE = CopMvcUtil.ConvDigitToCurrency(_EAMTS.TOTALTAXDUEX);
                fobj.NPT_PG1.INTEREST_PENALTY = CopMvcUtil.ConvDigitToCurrency(_EAMTS.INTERESTPENALTYX);
                fobj.NPT_PG1.TOTAL_DUE = CopMvcUtil.ConvDigitToCurrency(_EAMTS.TOTALAMTDUEX);
                fobj.NPT_PG1.OVERPAY = CopMvcUtil.ConvDigitToCurrency(_EAMTS.TAXOVERPAIDX);
                fobj.NPT_PG1.LINE17 = CopMvcUtil.ConvDigitToCurrency(_EAMTS.NETPROFITESTX);
                fobj.NPT_PG1.OVERPAY_AVAILABLE = CopMvcUtil.ConvDigitToCurrency(_EAMTS.OVERPAYMENTAVAILX);//newly added
                //
                fobj.NPT_PG1.REFUND = CopMvcUtil.ConvDigitToCurrency(_EAMTS.REFUNDAMTX);
                fobj.NPT_PG1.BPT_OVERPAY = CopMvcUtil.ConvDigitToCurrency(_EAMTS.BPTOVERPAYMENTX);
                fobj.NPT_PG1.NPT_OVERPAY = CopMvcUtil.ConvDigitToCurrency(_EAMTS.NPTOVERPAYMENTX);
                //added 2015 corporation Tax
                fobj.NPT_PG1.CORP_PARTNER_PERCENT = (_EAMTS.CORPPARTNERPERCENTX);
            
           
            return fobj;

        }

        private static COPXmlFactory.RTTIE039_2015.NPTRETURN __RTTIE039_F_U(COPXmlFactory.RTTIE039_2015.NPTRETURN e)
        {
            RTTIE040_SrvRef.RT01E040_ENPT _ENPT = new RTTIE040_SrvRef.RT01E040_ENPT();
            RTTIE040_SrvRef.RT01E040_EAMTS _EAMTS = new RTTIE040_SrvRef.RT01E040_EAMTS();
            RTTIE040_SrvRef.RT01E040 rttie040 = new RTTIE040_SrvRef.RT01E040();
            //
            RTTIE040_SrvRef.RT01E040Response_SMA _SMAResponse = new RTTIE040_SrvRef.RT01E040Response_SMA();
            RTTIE040_SrvRef.RT01E040Response_ENPT _ENPTResponse = new RTTIE040_SrvRef.RT01E040Response_ENPT();
            RTTIE040_SrvRef.RT01E040Response_EAMTS _EAMTSResponse = new RTTIE040_SrvRef.RT01E040Response_EAMTS();
            RTTIE040_SrvRef.RT01E040Response_SERR _SERRRespose = new RTTIE040_SrvRef.RT01E040Response_SERR();
           
            _ENPT.ACCOUNTID = e.NPT_INFO.ACCOUNT_ID;
            _ENPT.PERIODX = CopMvcUtil.ConvDateDecimalString(e.NPT_INFO.PERIOD);
            _ENPT.VERSIONX = e.NPT_INFO.VERSION;
            _ENPT.RETURNSTATUS = e.NPT_INFO.RETURN_STATUS;
            _ENPT.LASTUPDATEDATEX = CopMvcUtil.ConvDateDecimalString(e.NPT_INFO.LAST_UPD_DATE);
            _ENPT.RECORDINGDATEX = CopMvcUtil.ConvDateDecimalString(e.NPT_INFO.RECORDING_DATE);
            _ENPT.EXTENSIONDATEX = CopMvcUtil.ConvDateDecimalString(e.NPT_INFO.EXTENSION_DATE);
            _ENPT.SEQUENCENUMBER = e.NPT_INFO.SEQUENCE;
            _ENPT.ADJUSTMENTREFERENCENUM = e.NPT_INFO.ADJUSTMENT_REF_NO;
            _ENPT.USERID = e.NPT_INFO.USER_ID;

            _ENPT.RATERES = CopMvcUtil.ConvNumberToDigit9(e.NPT_INFO.RESIDENT_RATE);
            _ENPT.BASERATERES = CopMvcUtil.ConvNumberToDigit9(e.NPT_INFO.BASE_RESIDENT_RATE);
            _ENPT.RATENONRES = CopMvcUtil.ConvNumberToDigit9(e.NPT_INFO.NON_RES_RATE);
            _ENPT.BASERATENONRES = CopMvcUtil.ConvNumberToDigit9(e.NPT_INFO.BASE_NON_RES_RATE);

            _ENPT.PREPARERNAME = e.NPT_INFO.PREPARER_NAME;

            _ENPT.PREPARERPHONE = CopMvcUtil.GetDecimal(e.NPT_INFO.PREPARER_PHONE);
            _ENPT.PREPARERPHONEEXT = e.NPT_INFO.PREPARER_PHONE_EXT;



            _ENPT.PREPARERPHONEEXT = e.NPT_INFO.PREPARER_PHONE_EXT;
            _ENPT.PREPARERIPADDRESS = e.NPT_INFO.PREPARER_IP_ADDRESS;
            _ENPT.PREPAREREMAILADDRESS = e.NPT_INFO.PREPARER_EMAIL_ADDRESS;
            _ENPT.PREPARERTYPE = e.NPT_INFO.PREPARER_WHO;
            _ENPT.PREPARERPHONESpecified = true;
            //  Added some new fields
            //New column addded for save corporation TAX
            _EAMTS.CORPPARTNERPERCENTX = Convert.ToString(e.NPT_PG1.CORP_PARTNER_PERCENT);
            //resident
            _EAMTS.RESTAXABLEINCOMEX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.RESIDENT_INCOME);
            _EAMTS.RESTAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.RESIDENT_INCOME_TAX);
            _EAMTS.RESBASERATETAXABLEX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.RESIDENT_BASE_INCOME_TAXABLE);
            _EAMTS.RESBASERATETAXX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.RESIDENT_BASE_INCOME_TAX);
            _EAMTS.TOTALRESTAXX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.RESIDENT_TOTAL_TAX);
            //nonResident
            _EAMTS.NONRESTAXINCOMEX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.NON_RES_INCOME);
            _EAMTS.NONRESTAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.NON_RES_INCOME_TAX);
            _EAMTS.NONRESBASERATETAXABLEX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.NON_RES_BASE_INCOME_TAXABLE);
            _EAMTS.NONRESBASERATETAXX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.NON_RES_BASE_INCOME_TAX);
            _EAMTS.TOTALNONRESTAXX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.NON_RES_TOTAL_TAX);

            _EAMTS.TOTALTAXDUE1X = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.TOTAL_TAX);
            //
           _EAMTS.BPTCREDITX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.BPT_TAX_CREDIT);
           _EAMTS.OTHERX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.OTHER_TAX_CREDIT);
           _EAMTS.TOTALCREDITSX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.TOTAL_PAY_CREDITS);
           _EAMTS.TOTALTAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.TAX_DUE);
           _EAMTS.INTERESTPENALTYX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.INTEREST_PENALTY);
           _EAMTS.TOTALAMTDUEX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.TOTAL_DUE);
           _EAMTS.TAXOVERPAIDX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.OVERPAY);
           _EAMTS.NETPROFITESTX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.LINE17);
           _EAMTS.OVERPAYMENTAVAILX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.OVERPAY_AVAILABLE);
            //
            _EAMTS.REFUNDAMTX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.REFUND);
            _EAMTS.BPTOVERPAYMENTX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.BPT_OVERPAY);
            _EAMTS.NPTOVERPAYMENTX = CopMvcUtil.ConvCurrencyToDigit(e.NPT_PG1.NPT_OVERPAY);

            string ENPT = CopMvcUtil.GetXMlFromObject(_ENPT);
            string EAMTS = CopMvcUtil.GetXMlFromObject(_EAMTS);


            _SMAResponse = rttie040.CallRT01E040(new RTTIE040_SrvRef.RT01E040_SMA(), _ENPT, _EAMTS,new RTTIE040_SrvRef.RT01E040_SERR(),
             out _ENPTResponse, out _EAMTSResponse, out _SERRRespose);

            e = __Fill(_SMAResponse, _ENPTResponse, _EAMTSResponse, _SERRRespose);

            return e;

        }
    }
}