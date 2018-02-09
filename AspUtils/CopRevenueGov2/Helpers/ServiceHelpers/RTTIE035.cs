using CopRevenueGov2.Service;
using COPXmlFactory;
using COPXmlFactory.RTTIE035;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Xml;

namespace CopRevenueGov2.Helpers
{
    
    public class RTTIE035 : CopRestServiceBase, ICopSoapService
    {
        static RTTIE035_SrvRef.RTTIE235WS_PortTypeClient _client = null;

        public static void Init()
        {
            _client = COPServiceURLHelper.GetServiceClient_RTTIE035();
        }

        public static string CallService(string Request)
        {
            COPXmlFactory.RTTIE035.UOFORM xo;

            try
            {
                xo = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE035.UOFORM>(Request);

                xo = __Call(xo);

            }
            catch (Exception ex)
            {
                xo =
                    RevenueGovXMLFactory.GetUOFORMReturn();

                xo.ERROR_INFO = new ERROR_INFO();
                xo.ERROR_INFO.ERROR = 11.ToString();
                xo.ERROR_INFO.MESSAGE = ex.Message;
            }

            return RevenueGovXMLFactory.GetXmlString(xo);

        }

        public static XmlDocument CallService(XmlDocument Request)
        {
            COPXmlFactory.RTTIE035.UOFORM acct;

            try
            {
                string InnerXML = Request.InnerXml;
                acct = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE035.UOFORM>(InnerXML);

                acct = __Call(acct);

            }
            catch (Exception ex)
            {
                acct = RevenueGovXMLFactory.GetUOFORMReturn();

                acct.ERROR_INFO = new ERROR_INFO();
                acct.ERROR_INFO.ERROR = 11.ToString();
                acct.ERROR_INFO.MESSAGE = ex.Message;
            }

            return RevenueGovXMLFactory.GetXmlDocument(acct);
        }

        private static UOFORM __Call(UOFORM e)
        {
            switch (e.UO_ACCT.RETURN_STATUS)
            {
                case "INQ": // fill
                    e = __RTTIE035_F_I(e);
                    break;
                case "UPD": // submit
                    e = __RTTIE035_F_U(e);
                    break;

                default:
                    e = __RTTIE035_F_I(e);
                    break;
            }
            return e;


        }

        private static COPXmlFactory.RTTIE035.UOFORM __RTTIE035_F_I(COPXmlFactory.RTTIE035.UOFORM e)
        {
            RTTIE035_SrvRef.RTTIE235 serv_req = new RTTIE035_SrvRef.RTTIE235();

            serv_req._EUOL = new RTTIE035_SrvRef._EUOL();

            serv_req._EUOL.ACCOUNTID = e.UO_ACCT.ACCOUNT_ID;
            if (e.UO_ACCT.PERIOD.Value.Contains('/'))
            {
                serv_req._EUOL.PERIODX = CopMvcUtil.ConvDateDecimalString(e.UO_ACCT.PERIOD);
            }
            else
            {
                serv_req._EUOL.PERIODX = e.UO_ACCT.PERIOD;
            }
            serv_req._EUOL.RETURNSTATUS = e.UO_ACCT.RETURN_STATUS;

          

            RTTIE035_SrvRef.RTTIE235Response response = _client.RTTIE235(serv_req);

            e = __Fill(response);

            return e;
        }

        private static COPXmlFactory.RTTIE035.UOFORM __Fill(RTTIE035_SrvRef.RTTIE235Response e)
        {
            COPXmlFactory.RTTIE035.UOFORM fobj = new UOFORM();

            //LOAD ERRORS INTO OBJECT
            fobj.ERROR_INFO = new ERROR_INFO();

            fobj.ERROR_INFO.PROGRAM = e._SMA._PROGRAM;
            fobj.ERROR_INFO.LINE = e._SMA.ERRORLINE.ToString();
            fobj.ERROR_INFO.MESSAGE = e._SMA.MESSAGE;
            fobj.ERROR_INFO.ERROR = e._SMA.SYSTEMERROR.ToString();

            //LOAD UO_INFO 
            fobj.UO_ACCT = new UO_ACCT();
            fobj.UO_ACCT.ACCOUNT_ID = e._EUOL.ACCOUNTID;
            fobj.UO_ACCT.PERIOD = CopMvcUtil.ConvDate(e._EUOL.PERIODX);
            fobj.UO_ACCT.VERSION = e._EUOL.VERSIONX;
            fobj.UO_ACCT.RETURN_STATUS = e._EUOL.RETURNSTATUS;
            fobj.UO_ACCT.LAST_UPD_DATE = CopMvcUtil.ConvDate(e._EUOL.LASTUPDATEDATEX);
            fobj.UO_ACCT.USER_ID = e._EUOL.USERID;
            fobj.UO_ACCT.RECORDING_DATE = CopMvcUtil.ConvDate(e._EUOL.RECORDINGDATEX);
            fobj.UO_ACCT.SEQUENCE = e._EUOL.SEQUENCENUM;
            fobj.UO_ACCT.ADJUSTMENT_REF_NO = e._EUOL.ADJUSTMENTREFERENCENUM;
            fobj.UO_ACCT.RATE = CopMvcUtil.ConvDigitToCurrency(e._EUOL.RATE);
            fobj.UO_ACCT.BRT_NUMBER = e._EUOL.BRTNUMBER;
            fobj.UO_ACCT.LOCATION = e._EUOL.LOCATION;
            fobj.UO_ACCT.DUE_DATE = CopMvcUtil.ConvDate(e._EUOL.DUEDATE);
            fobj.UO_ACCT.ASSESSED_VALUE = CopMvcUtil.ConvDigitToCurrency(e._EUOL.ASSESSEDVALUEX);
            fobj.UO_ACCT.FREQUENCY = e._EUOL.FREQUENCY;
            fobj.UO_ACCT.PERIOD_CODE = e._EUOL.PERIODCODE;
            fobj.UO_ACCT.PERIOD_YY = e._EUOL.PERIODYY;
            fobj.UO_ACCT.PREPARER_NAME = e._EUOL.PREPARERNAME;
            fobj.UO_ACCT.PREPARER_PHONE = e._EUOL.PREPARERPHONE;
            fobj.UO_ACCT.PREPARER_PHONE_EXT = e._EUOL.PREPARERPHONEEXT;
            fobj.UO_ACCT.PREPARER_IP_ADDRESS = e._EUOL.PREPARERIPADDRESS;
            fobj.UO_ACCT.PREPARER_EMAIL_ADDRESS = e._EUOL.PREPAREREMAILADDRESS;
            fobj.UO_ACCT.PREPARER_WHO = e._EUOL.PREPARERTYPE;

            //LOAD UO_AMTS 
            fobj.UO_AMTS = new UO_AMTS();
            fobj.UO_AMTS.MAX_TAX = CopMvcUtil.ConvDigitToCurrency(e._EAMTS.MAXTAXX);
            fobj.UO_AMTS.VACANCY = CopMvcUtil.ConvDigitToCurrency(e._EAMTS.VACANCYX);
            fobj.UO_AMTS.EXEMPT = CopMvcUtil.ConvDigitToCurrency(e._EAMTS.EXEMPTX);
            fobj.UO_AMTS.RESIDENTIAL = CopMvcUtil.ConvDigitToCurrency(e._EAMTS.RESIDENTIALX);
            fobj.UO_AMTS.DELINQUENT = CopMvcUtil.ConvDigitToCurrency(e._EAMTS.DELINQUENTX);
            fobj.UO_AMTS.KOZ_CREDIT = CopMvcUtil.ConvDigitToCurrency(e._EAMTS.EDICREDITX);
            fobj.UO_AMTS.TOTAL_DEDUCTIONS = CopMvcUtil.ConvDigitToCurrency(e._EAMTS.TOTALDEDUCTIONSX);
            fobj.UO_AMTS.PERIOD_TAX = CopMvcUtil.ConvDigitToCurrency(e._EAMTS.PERIODTAXX);
            fobj.UO_AMTS.DISCOUNT = CopMvcUtil.ConvDigitToCurrency(e._EAMTS.DISCOUNTX);
            fobj.UO_AMTS.TAX_DUE = CopMvcUtil.ConvDigitToCurrency(e._EAMTS.TAXDUEX);
            fobj.UO_AMTS.INTEREST_PENALTY = CopMvcUtil.ConvDigitToCurrency(e._EAMTS.INTERESTPENALTYX);
            fobj.UO_AMTS.TOTAL_DUE = CopMvcUtil.ConvDigitToCurrency(e._EAMTS.TOTALDUEX);
            fobj.UO_AMTS.DELINQUENT_TENANT_COUNT = CopMvcUtil.ConvDigitToDouble(e._EAMTS.DELINQUENTTENANTCOUNTX);


            //LOAD UO3_PAGE 
            fobj.UO3_PAGE = new List<UO3_PAGE>();
            for (int i = 0; i < e._EUO3._DELQs.Length; i++)
            {
                fobj.UO3_PAGE.Add(COPXmlFactory.RevenueGovXMLFactory.GetUOFORMReturn_UO3_PAGE());

                fobj.UO3_PAGE[i].PROCESS_CODE = e._EUO3._DELQs[i].PROCESSCODED;
                fobj.UO3_PAGE[i].TENANT_NAME = e._EUO3._DELQs[i].NAMED;
                fobj.UO3_PAGE[i].TENANT_ID = e._EUO3._DELQs[i].ENTITYIDD;
                fobj.UO3_PAGE[i].ACCOUNT_ID = e._EUO3._DELQs[i].ACCOUNTIDD;
                fobj.UO3_PAGE[i].AMOUNT = e._EUO3._DELQs[i].DELQAMTD;

            }

            return fobj;

        }


        private static COPXmlFactory.RTTIE035.UOFORM __RTTIE035_F_U(COPXmlFactory.RTTIE035.UOFORM e)
        {

            RTTIE035_SrvRef.RTTIE235 serv_req = new RTTIE035_SrvRef.RTTIE235();
           
            serv_req._EUOL = new RTTIE035_SrvRef._EUOL();
            serv_req._EUOL.ACCOUNTID = e.UO_ACCT.ACCOUNT_ID;
            serv_req._EUOL.VERSIONX = e.UO_ACCT.VERSION;
           // serv_req._EUOL.PERIODX = CopMvcUtil.ConvDateDecimal("12/31/2012").ToString();
            serv_req._EUOL.PERIODX = CopMvcUtil.ConvDateDecimal(e.UO_ACCT.PERIOD).ToString();
            serv_req._EUOL.LASTUPDATEDATEX = CopMvcUtil.ConvDateDecimal(e.UO_ACCT.LAST_UPD_DATE).ToString();
            serv_req._EUOL.USERID = e.UO_ACCT.USER_ID;
            serv_req._EUOL.RECORDINGDATEX = CopMvcUtil.ConvDateDecimal(e.UO_ACCT.RECORDING_DATE).ToString();
            serv_req._EUOL.SEQUENCENUM = e.UO_ACCT.SEQUENCE;
            serv_req._EUOL.ADJUSTMENTREFERENCENUM = e.UO_ACCT.ADJUSTMENT_REF_NO;
            serv_req._EUOL.RATE = CopMvcUtil.ConvNumberToDigit9(e.UO_ACCT.RATE);
            serv_req._EUOL.BRTNUMBER = CopMvcUtil.ConvNumberToDigit9(e.UO_ACCT.BRT_NUMBER);
            serv_req._EUOL.LOCATION = CopMvcUtil.GetString(e.UO_ACCT.LOCATION);
            serv_req._EUOL.DUEDATE = CopMvcUtil.ConvDateDecimal(e.UO_ACCT.DUE_DATE).ToString();
            serv_req._EUOL.ASSESSEDVALUEX = e.UO_ACCT.ASSESSED_VALUE;
            serv_req._EUOL.FREQUENCY = e.UO_ACCT.FREQUENCY;
            serv_req._EUOL.PERIODCODE = e.UO_ACCT.PERIOD_CODE;
            serv_req._EUOL.PERIODYY = e.UO_ACCT.PERIOD_YY;

            serv_req._EUOL.PREPARERNAME = e.UO_ACCT.PREPARER_NAME;
            serv_req._EUOL.PREPARERPHONE = e.UO_ACCT.PREPARER_PHONE;
            serv_req._EUOL.PREPARERPHONEEXT = e.UO_ACCT.PREPARER_PHONE_EXT;
            serv_req._EUOL.PREPARERIPADDRESS = e.UO_ACCT.PREPARER_IP_ADDRESS;
            serv_req._EUOL.PREPAREREMAILADDRESS = e.UO_ACCT.PREPARER_EMAIL_ADDRESS;
            serv_req._EUOL.PREPARERTYPE = e.UO_ACCT.PREPARER_WHO; ;       

            serv_req._EAMTS = new RTTIE035_SrvRef._EAMTS();
            serv_req._EAMTS.MAXTAXX = CopMvcUtil.ConvCurrencyToDigit(e.UO_AMTS.MAX_TAX);
            serv_req._EAMTS.VACANCYX =  CopMvcUtil.ConvCurrencyToDigit(e.UO_AMTS.VACANCY);
            serv_req._EAMTS.EXEMPTX =  CopMvcUtil.ConvCurrencyToDigit(e.UO_AMTS.EXEMPT);
            serv_req._EAMTS.RESIDENTIALX =  CopMvcUtil.ConvCurrencyToDigit(e.UO_AMTS.RESIDENTIAL);
            serv_req._EAMTS.DELINQUENTX = CopMvcUtil.ConvCurrencyToDigit(e.UO_AMTS.DELINQUENT);
            serv_req._EAMTS.EDICREDITX =  CopMvcUtil.ConvCurrencyToDigit(e.UO_AMTS.KOZ_CREDIT);
            serv_req._EAMTS.TOTALDEDUCTIONSX = CopMvcUtil.ConvCurrencyToDigit(e.UO_AMTS.TOTAL_DEDUCTIONS);
            serv_req._EAMTS.PERIODTAXX = CopMvcUtil.ConvCurrencyToDigit(e.UO_AMTS.PERIOD_TAX);
            serv_req._EAMTS.DISCOUNTX = CopMvcUtil.ConvCurrencyToDigit(e.UO_AMTS.DISCOUNT);
            serv_req._EAMTS.TAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.UO_AMTS.TAX_DUE);
            serv_req._EAMTS.INTERESTPENALTYX = CopMvcUtil.ConvCurrencyToDigit(e.UO_AMTS.INTEREST_PENALTY);
            serv_req._EAMTS.TOTALDUEX = CopMvcUtil.ConvCurrencyToDigit(e.UO_AMTS.TOTAL_DUE);
            serv_req._EAMTS.DELINQUENTTENANTCOUNTX = e.UO_AMTS.DELINQUENT_TENANT_COUNT;

            //serv_req._EAMTS.FIXEDEXEMPTNX = "000000000000000";
           // serv_req._EAMTS.ADJUSTEDTAXX = "000000000000000";
          



            if (e.UO3_PAGE.Count > 0)
            {
                serv_req._EUO3 = new RTTIE035_SrvRef._EUO3();
                int r = 0;

                for (int s = 0; s < e.UO3_PAGE.Count; s++)
                {
                    if (e.UO3_PAGE[s].ACCOUNT_ID.Value != null)
                    {
                        r++;
                    }
                }

                if (r > 0)
                {
                    serv_req._EUO3._DELQs = new RTTIE035_SrvRef._DELQ[r];
                }
                r = 0;
                for (int i = 0; i < e.UO3_PAGE.Count; i++)
                {
                    if (e.UO3_PAGE[i].ACCOUNT_ID.Value != null)
                    {

                        serv_req._EUO3._DELQs[r] = new RTTIE035_SrvRef._DELQ();

                        serv_req._EUO3._DELQs[r].PROCESSCODED = CopMvcUtil.GetString(e.UO3_PAGE[i].PROCESS_CODE);
                        serv_req._EUO3._DELQs[r].NAMED = CopMvcUtil.GetString(e.UO3_PAGE[i].TENANT_NAME);
                        serv_req._EUO3._DELQs[r].ACCOUNTIDD = CopMvcUtil.GetString(e.UO3_PAGE[i].ACCOUNT_ID);
                        serv_req._EUO3._DELQs[r].ENTITYIDD = CopMvcUtil.GetString(e.UO3_PAGE[i].TENANT_ID);
                        serv_req._EUO3._DELQs[r].DELQAMTD = CopMvcUtil.ConvCurrencyToDigit(e.UO3_PAGE[i].AMOUNT);
                    }
                }
            }

           
            RTTIE035_SrvRef.RTTIE235Response response = _client.RTTIE235(serv_req);

            e = __Fill(response);

            return e;

        }
    } 
}
