using CopRevenueGov2.Service;
using COPXmlFactory;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml;
using COPXmlFactory.RTTIE029;

namespace CopRevenueGov2.Helpers
{
    public class RTTIE029 : CopRestServiceBase, ICopSoapService
    {
         static RTTIE229_SrvRef.RTTIE229WS_PortTypeClient _client = null;

        public static void Init()
        {
            _client = COPServiceURLHelper.GetServiceClient_RTTIE229();
        }

        public static string CallService(string Request)
        {
            COPXmlFactory.RTTIE029.LIQUORRETURN xo;

            try
            {
                xo = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE029.LIQUORRETURN>(Request);

                xo = __Call(xo);

            }
            catch (Exception ex)
            {
                xo =
                    RevenueGovXMLFactory.GetLIQUORRETURN();

                xo.ERROR_INFO = new ERROR_INFO();
                xo.ERROR_INFO.ERROR = 11.ToString();
                xo.ERROR_INFO.MESSAGE = ex.Message;
            }

            return RevenueGovXMLFactory.GetXmlString(xo);

        }

        public static XmlDocument CallService(XmlDocument Request)
        {
            COPXmlFactory.RTTIE029.LIQUORRETURN acct;

            try
            {
                string InnerXML = Request.InnerXml;
                acct = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE029.LIQUORRETURN>(InnerXML);

                acct = __Call(acct);

            }
            catch (Exception ex)
            {
                acct = RevenueGovXMLFactory.GetLIQUORRETURN();

                acct.ERROR_INFO = new ERROR_INFO();
                acct.ERROR_INFO.ERROR = 11.ToString();
                acct.ERROR_INFO.MESSAGE = ex.Message;
            }

            return RevenueGovXMLFactory.GetXmlDocument(acct);
        }

        private static LIQUORRETURN __Call(LIQUORRETURN e)
        {
            switch (e.LIQUOR_INFO.RETURN_STATUS)
            {
                case "INQ": // fill
                    e = __RTTIE029_F_I(e);
                    break;
                case null: // submit
                    e = __RTTIE029_F_U(e);
                    break;
               
                default:
                    e = __RTTIE029_F_I(e);
                    break;
            }
            return e;
        }

        private static COPXmlFactory.RTTIE029.LIQUORRETURN __RTTIE029_F_I(COPXmlFactory.RTTIE029.LIQUORRETURN e)
        {
            RTTIE229_SrvRef.RTTIE229 serv_req = new RTTIE229_SrvRef.RTTIE229();

            serv_req._ELIQ= new RTTIE229_SrvRef._ELIQ();

           // serv_req._ELIQ.ACCOUNTID = e.LIQUOR_INFO.ACCOUNT_ID;
            serv_req._ELIQ.ACCOUNTID = "9916537";
            serv_req._ELIQ.PERIODX = CopMvcUtil.ConvDateDecimal(e.LIQUOR_INFO.PERIOD).ToString();
            serv_req._ELIQ.RETURNSTATUS = e.LIQUOR_INFO.RETURN_STATUS;

            RTTIE229_SrvRef.RTTIE229Response response = _client.RTTIE229(serv_req);

            e = __Fill(response);

            return e;
        }

        private static COPXmlFactory.RTTIE029.LIQUORRETURN __Fill(RTTIE229_SrvRef.RTTIE229Response e)
        {
            COPXmlFactory.RTTIE029.LIQUORRETURN fobj = RevenueGovXMLFactory.GetLIQUORRETURN();

            //LOAD ERRORS INTO OBJECT
            fobj.ERROR_INFO = new ERROR_INFO();

            fobj.ERROR_INFO.PROGRAM = e._SMA._PROGRAM;
            fobj.ERROR_INFO.LINE = e._SMA.ERRORLINE.ToString();
            fobj.ERROR_INFO.MESSAGE = e._SMA.MESSAGE;
            fobj.ERROR_INFO.ERROR = e._SMA.SYSTEMERROR.ToString();

            //LOAD LIQUOR_INFO 
            fobj.LIQUOR_INFO= new LIQUOR_INFO();
            fobj.LIQUOR_INFO.ACCOUNT_ID = e._ELIQ.ACCOUNTID;
            fobj.LIQUOR_INFO.PERIOD = CopMvcUtil.ConvDate(e._ELIQ.PERIODX);
            fobj.LIQUOR_INFO.VERSION = e._ELIQ.VERSIONX;
            fobj.LIQUOR_INFO.RETURN_STATUS = e._ELIQ.RETURNSTATUS;
            fobj.LIQUOR_INFO.LAST_UPD_DATE = CopMvcUtil.ConvDate(e._ELIQ.LASTUPDATEDATEX);
            fobj.LIQUOR_INFO.USER_ID = e._ELIQ.USERID;
            fobj.LIQUOR_INFO.RECORDING_DATE =CopMvcUtil.ConvDate(e._ELIQ.RECORDINGDATEX);
            fobj.LIQUOR_INFO.SEQUENCE_NO = e._ELIQ.SEQUENCENUM;
            fobj.LIQUOR_INFO.ADJUSTMENT_REF_NO = e._ELIQ.ADJUSTMENTREFERENCENUM;
            fobj.LIQUOR_INFO.RATE = CopMvcUtil.ConvDigitToDouble9(e._ELIQ.RATE);
           
            fobj.LIQUOR_INFO.PREPARER_NAME = e._ELIQ.PREPARERNAME;
            fobj.LIQUOR_INFO.PREPARER_PHONE = CopMvcUtil.ConvDecimal(e._ELIQ.PREPARERPHONE).ToString();
            fobj.LIQUOR_INFO.PREPARER_PHONE_EXT = e._ELIQ.PREPARERPHONEEXT;
            fobj.LIQUOR_INFO.PREPARER_IP_ADDRESS = e._ELIQ.PREPARERIPADDRESS;
            fobj.LIQUOR_INFO.PREPARER_EMAIL_ADDRESS = e._ELIQ.PREPAREREMAILADDRESS;
            fobj.LIQUOR_INFO.PREPARER_WHO = e._ELIQ.PREPARERTYPE;

         

            //LOAD AMT_INFO 
            fobj.AMT_INFO = new AMT_INFO();
            fobj.AMT_INFO.TOTAL_GROSS = CopMvcUtil.GetDouble(e._EAMT.TOTALGROSSX).ToString();
            fobj.AMT_INFO.FOOD_EXCLUSION = CopMvcUtil.GetDouble(e._EAMT.FOODEXCLUSIONX).ToString();
            fobj.AMT_INFO.OTHER_EXCLUSION = CopMvcUtil.GetDouble(e._EAMT.OTHEREXCLUSIONX).ToString();
            fobj.AMT_INFO.TOTAL_EXCLUSION = CopMvcUtil.ConvDigitToCurrency(e._EAMT.TOTALEXCLUSIONX);
            fobj.AMT_INFO.TAXABLE = CopMvcUtil.GetDouble(e._EAMT.TAXABLEX).ToString();
            fobj.AMT_INFO.TOTAL_TAX = CopMvcUtil.GetDouble(e._EAMT.TOTALTAXX).ToString();
            fobj.AMT_INFO.TAX_PAID = CopMvcUtil.GetDouble(e._EAMT.TAXPAIDX).ToString();
            fobj.AMT_INFO.NET_TAX_DUE =CopMvcUtil.ConvDigitToCurrency(e._EAMT.NETTAXDUEX);
            fobj.AMT_INFO.TAX_OVERPAID =CopMvcUtil.GetDouble(e._EAMT.TAXOVERPAIDX).ToString();
           

            
            return fobj;

        }

        private static COPXmlFactory.RTTIE029.LIQUORRETURN __RTTIE029_F_U(COPXmlFactory.RTTIE029.LIQUORRETURN e)
        {

            RTTIE229_SrvRef.RTTIE229 serv_req = new RTTIE229_SrvRef.RTTIE229();

            serv_req._ELIQ = new RTTIE229_SrvRef._ELIQ();
            serv_req._ELIQ.ACCOUNTID = e.LIQUOR_INFO.ACCOUNT_ID;
            serv_req._ELIQ.VERSIONX = e.LIQUOR_INFO.VERSION;
            serv_req._ELIQ.PERIODX = CopMvcUtil.ConvDateDecimal(e.LIQUOR_INFO.PERIOD).ToString();
            serv_req._ELIQ.LASTUPDATEDATEX = CopMvcUtil.ConvDateDecimal(e.LIQUOR_INFO.LAST_UPD_DATE).ToString();
            serv_req._ELIQ.USERID = e.LIQUOR_INFO.USER_ID;
            serv_req._ELIQ.RECORDINGDATEX = CopMvcUtil.ConvDateDecimal(e.LIQUOR_INFO.RECORDING_DATE).ToString();
            serv_req._ELIQ.SEQUENCENUM = e.LIQUOR_INFO.SEQUENCE_NO;
            serv_req._ELIQ.ADJUSTMENTREFERENCENUM = e.LIQUOR_INFO.ADJUSTMENT_REF_NO;
            serv_req._ELIQ.RATE = CopMvcUtil.ConvNumberToDigit9(e.LIQUOR_INFO.RATE);
           
            serv_req._ELIQ.PREPARERNAME = e.LIQUOR_INFO.PREPARER_NAME;
            serv_req._ELIQ.PREPARERPHONE = CopMvcUtil.ConvDecimal(e.LIQUOR_INFO.PREPARER_PHONE);
            serv_req._ELIQ.PREPARERPHONEEXT = e.LIQUOR_INFO.PREPARER_PHONE_EXT;
            serv_req._ELIQ.PREPARERIPADDRESS = e.LIQUOR_INFO.PREPARER_IP_ADDRESS;
            serv_req._ELIQ.PREPAREREMAILADDRESS = e.LIQUOR_INFO.PREPARER_EMAIL_ADDRESS;
            serv_req._ELIQ.PREPARERTYPE = e.LIQUOR_INFO.PREPARER_WHO; ;
            

            serv_req._EAMT = new RTTIE229_SrvRef._EAMT();
            serv_req._EAMT.TOTALGROSSX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.TOTAL_GROSS);
            serv_req._EAMT.FOODEXCLUSIONX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.FOOD_EXCLUSION).ToString();
            serv_req._EAMT.OTHEREXCLUSIONX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.OTHER_EXCLUSION).ToString();
            serv_req._EAMT.TOTALEXCLUSIONX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.TOTAL_EXCLUSION).ToString();
            serv_req._EAMT.TAXABLEX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.TAXABLE).ToString();
            serv_req._EAMT.TOTALTAXX =CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.TOTAL_TAX).ToString();
            serv_req._EAMT.TAXPAIDX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.TAX_PAID).ToString();
            serv_req._EAMT.NETTAXDUEX =CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.NET_TAX_DUE).ToString();
            serv_req._EAMT.TAXOVERPAIDX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.TAX_OVERPAID).ToString();
          
           
            RTTIE229_SrvRef.RTTIE229Response response = _client.RTTIE229(serv_req);

            e = __Fill(response);

            return e;

        }
    }

    }
