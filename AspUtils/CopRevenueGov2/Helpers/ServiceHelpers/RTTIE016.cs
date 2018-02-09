using CopRevenueGov2.Service;
using COPXmlFactory;
using COPXmlFactory.RTTIE016;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Xml;

namespace CopRevenueGov2.Helpers
{
    public class RTTIE016 : CopRestServiceBase, ICopSoapService
    {
        static RTTIE016_SrvRef.RTTIE216WS_PortTypeClient _client = null;

        public static void Init()
        {
            _client = COPServiceURLHelper.GetServiceClient_RTTIE016();
        }

        public static string CallService(string Request)
        {
            COPXmlFactory.RTTIE016.PAYCOUPON xo;

            try
            {
                xo = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE016.PAYCOUPON>(Request);

                xo = __Call(xo);

            }
            catch (Exception ex)
            {
                xo =
                    RevenueGovXMLFactory.GetPAYCOUPON();

                xo.ERROR_INFO = new ERROR_INFO();
                xo.ERROR_INFO.ERROR = 11.ToString();
                xo.ERROR_INFO.MESSAGE = ex.StackTrace;
            }

            return RevenueGovXMLFactory.GetXmlString(xo);

        }

        public static XmlDocument CallService(XmlDocument Request)
        {
            COPXmlFactory.RTTIE016.PAYCOUPON acct;

            try
            {
                string InnerXML = Request.InnerXml;
                acct = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE016.PAYCOUPON>(InnerXML);

                acct = __Call(acct);

            }
            catch (Exception ex)
            {
                acct = RevenueGovXMLFactory.GetPAYCOUPON();

                acct.ERROR_INFO = new ERROR_INFO();
                acct.ERROR_INFO.ERROR = 11.ToString();
                acct.ERROR_INFO.MESSAGE = ex.Message;
            }

            return RevenueGovXMLFactory.GetXmlDocument(acct);
        }

        private static PAYCOUPON __Call(PAYCOUPON e)
        {
            switch (e.ENTITY_INFO.FUNCTION_CODE)
            {
                case "I": // fill
                    e = __RTTIE016_F_I(e);
                    break;
                case "N": // submit
                   
                     e = __RTTIE016_F_U(e);
                    break;

                default:
                    e = __RTTIE016_F_I(e);
                    break;
            }
            return e;
        }

        private static COPXmlFactory.RTTIE016.PAYCOUPON __RTTIE016_F_I(COPXmlFactory.RTTIE016.PAYCOUPON e)
        {
            RTTIE016_SrvRef.RTTIE216 serv_req = new RTTIE016_SrvRef.RTTIE216();

            serv_req._EMI = new RTTIE016_SrvRef._EMI();
            serv_req._EMI._ENTITYMASTERINFO = new RTTIE016_SrvRef._ENTITYMASTERINFO();
            serv_req._EMI._ENTITYMASTERINFO.ENTITYID = e.ENTITY_INFO.ENTITY_ID;
            serv_req._EMI._ENTITYMASTERINFO.FUNCTIONCODE = e.ENTITY_INFO.FUNCTION_CODE;


            RTTIE016_SrvRef.RTTIE216Response response = _client.RTTIE216(serv_req);

            e = __Fill(response);

            return e;
        }

        private static COPXmlFactory.RTTIE016.PAYCOUPON __Fill(RTTIE016_SrvRef.RTTIE216Response e)
        {
            COPXmlFactory.RTTIE016.PAYCOUPON fobj = RevenueGovXMLFactory.GetPAYCOUPON();

            //LOAD ERRORS INTO OBJECT
            fobj.ERROR_INFO = new ERROR_INFO();

            fobj.ERROR_INFO.PROGRAM = e._SMA._SYSTEMMESSAGEAREA._PROGRAM;
            fobj.ERROR_INFO.LINE = e._SMA._SYSTEMMESSAGEAREA.ERROR.ToString();
            fobj.ERROR_INFO.MESSAGE = e._SMA._SYSTEMMESSAGEAREA.MESSAGE;
            fobj.ERROR_INFO.ERROR = e._SMA._SYSTEMMESSAGEAREA.ERROR.ToString();

            //LOAD ENTITY_INFO 
            fobj.ENTITY_INFO = new ENTITY_INFO();
            fobj.ENTITY_INFO.FUNCTION_CODE = e._EMI._ENTITYMASTERINFO.FUNCTIONCODE;
            fobj.ENTITY_INFO.ENT_TYPE =CopMvcUtil.GetDouble(e._EMI._ENTITYMASTERINFO.ENTITYTYPE).ToString();
            fobj.ENTITY_INFO.ENTITY_ID = e._EMI._ENTITYMASTERINFO.ENTITYID;
            fobj.ENTITY_INFO.ACCT_ID = e._EMI._ENTITYMASTERINFO.ACCTID;
            fobj.ENTITY_INFO.NAME = e._EMI._ENTITYMASTERINFO.ENTITYNAME;
            fobj.ENTITY_INFO.ADDRESS1 = e._EMI._ENTITYMASTERINFO.ADDRESSLINE;
            fobj.ENTITY_INFO.ADDRESS2 = e._EMI._ENTITYMASTERINFO.ADDRESSLINE2;
            fobj.ENTITY_INFO.ADDRESS3 = e._EMI._ENTITYMASTERINFO.ADDRESSLINE3;
            fobj.ENTITY_INFO.CITY = e._EMI._ENTITYMASTERINFO.CITY;
            fobj.ENTITY_INFO.STATE = e._EMI._ENTITYMASTERINFO.STATE;
            fobj.ENTITY_INFO.ZIP_CODE = e._EMI._ENTITYMASTERINFO.ZIPCODE;

            //LOAD TAX ACCT s
            fobj.TAX_ACCT = new List<TAX_ACCT>();
            for (int i = 0; i < e._ETA._ENTITYTAXACCOUNTSs.Length; i++)
            {
                fobj.TAX_ACCT.Add(COPXmlFactory.RevenueGovXMLFactory.GetPAYCOUPON_TAX_ACCT());
                fobj.TAX_ACCT[i].FUNC_CODE = e._ETA._ENTITYTAXACCOUNTSs[i].FUNCTIONCODE;
                fobj.TAX_ACCT[i].ACCOUNT = CopMvcUtil.GetDecimal(e._ETA._ENTITYTAXACCOUNTSs[i].ACCOUNT).ToString();
                fobj.TAX_ACCT[i].ACCOUNT_ID =e._ETA._ENTITYTAXACCOUNTSs[i].ACCOUNTID;
                fobj.TAX_ACCT[i].START_DATE = CopMvcUtil.ConvDate(e._ETA._ENTITYTAXACCOUNTSs[i].STARTDATE);
                fobj.TAX_ACCT[i].END_DATE = CopMvcUtil.ConvDate(e._ETA._ENTITYTAXACCOUNTSs[i].ENDDATE);
               // fobj.TAX_ACCT[i].BRT_ACCOUNT = e._ETA._ENTITYTAXACCOUNTSs[i].br
                fobj.TAX_ACCT[i].BRT_ADDRESS1 = e._ETA._ENTITYTAXACCOUNTSs[i].BRTADDRESS;
                fobj.TAX_ACCT[i].FREQUENCY_CODE = e._ETA._ENTITYTAXACCOUNTSs[i].FREQUENCY;
               
            }

            //LOAD WAGE_NTL 
            fobj.WAGE_NTL = new WAGE_NTL();
            fobj.WAGE_NTL.ACCOUNT_ID = e._EWAGNTL.ACCOUNTID;
            fobj.WAGE_NTL.PERIOD = CopMvcUtil.ConvDate(e._EWAGNTL.PERIODX.PERIOD);
            fobj.WAGE_NTL.FREQUENCY_CODE = e._EWAGNTL.FREQUENCY;
            fobj.WAGE_NTL.ADJ_REF_NO = e._EWAGNTL.ADJREFNO;
            fobj.WAGE_NTL.PREPARER_NAME = e._EWAGNTL.PREPARERNAME;
            fobj.WAGE_NTL.PREPARER_PHONE = e._EWAGNTL.PREPARERPHONE;
            fobj.WAGE_NTL.PREPARER_PHONE_EXT = e._EWAGNTL.PREPARERPHONEEXT;
            fobj.WAGE_NTL.PREPARER_IP_ADDRESS = e._EWAGNTL.PREPARERIPADDRESS;
            fobj.WAGE_NTL.PREPARER_EMAIL_ADDRESS = e._EWAGNTL.PREPAREREMAIL;
            fobj.WAGE_NTL.PREPARER_WHO = e._EWAGNTL.PREPARERTYPE;

            ////LOAD COUPON_FORM 
            //fobj.COUPON_FORM = new COUPON_FORM();
            //fobj.COUPON_FORM.CPN_ACCOUNT =
            //fobj.COUPON_FORM.CPN_ACCOUNT_TYPE = CopMvcUtil.ConvDate(e._EWAGNTL.PERIODX.PERIOD);
            //fobj.COUPON_FORM.CPN_NAME = e._EWAGNTL.FREQUENCY;
            //fobj.COUPON_FORM.CPN_ADDR = e._EWAGNTL.ADJREFNO;
            //fobj.COUPON_FORM.CPN_ADDR2 = e._EWAGNTL.PREPARERNAME;
            //fobj.COUPON_FORM.CPN_ADDR3 = e._EWAGNTL.PREPARERPHONE;
            //fobj.COUPON_FORM.CPN_CITY = e._EWAGNTL.PREPARERPHONEEXT;
            //fobj.COUPON_FORM.CPN_STATE = e._EWAGNTL.PREPARERIPADDRESS;
            //fobj.COUPON_FORM.CPN_ZIP_CODE = e._EWAGNTL.PREPAREREMAIL;
            //fobj.COUPON_FORM.CPN_SCAN = e._EWAGNTL.PREPARERTYPE;
            //fobj.COUPON_FORM.CPN_PERIOD = e._EWAGNTL.PREPARERIPADDRESS;
            //fobj.COUPON_FORM.CPN_YEAR = e._EWAGNTL.PREPAREREMAIL;
            //fobj.COUPON_FORM.CPN_FORM = e._EWAGNTL.PREPARERTYPE;

            //LOAD LOGIN_FROM 
            //fobj.LOGIN_FROM = new LOGIN_FROM();
            //fobj.LOGIN_FROM.NTL_ONLY = e.;
         
            return fobj;

        }

        private static COPXmlFactory.RTTIE016.PAYCOUPON __RTTIE016_F_U(COPXmlFactory.RTTIE016.PAYCOUPON e)
        {

            RTTIE016_SrvRef.RTTIE216 serv_req = new RTTIE016_SrvRef.RTTIE216();

            //LOAD ENTITY_INFO 
             serv_req._EMI = new RTTIE016_SrvRef._EMI();
            serv_req._EMI._ENTITYMASTERINFO = new RTTIE016_SrvRef._ENTITYMASTERINFO();
            serv_req._EMI._ENTITYMASTERINFO.FUNCTIONCODE = e.ENTITY_INFO.FUNCTION_CODE;
            serv_req._EMI._ENTITYMASTERINFO.ENTITYTYPE = CopMvcUtil.ConvDecimal(e.ENTITY_INFO.ENT_TYPE);
            serv_req._EMI._ENTITYMASTERINFO.ENTITYID = e.ENTITY_INFO.ENTITY_ID;
            serv_req._EMI._ENTITYMASTERINFO.ACCTID = e.ENTITY_INFO.ACCT_ID;
            serv_req._EMI._ENTITYMASTERINFO.ENTITYNAME = e.ENTITY_INFO.NAME;
            serv_req._EMI._ENTITYMASTERINFO.ADDRESSLINE = e.ENTITY_INFO.ADDRESS1;
            serv_req._EMI._ENTITYMASTERINFO.ADDRESSLINE2 = e.ENTITY_INFO.ADDRESS2;
            serv_req._EMI._ENTITYMASTERINFO.ADDRESSLINE3 = e.ENTITY_INFO.ADDRESS3;
            serv_req._EMI._ENTITYMASTERINFO.CITY = e.ENTITY_INFO.CITY;
            serv_req._EMI._ENTITYMASTERINFO.STATE = e.ENTITY_INFO.STATE;
            serv_req._EMI._ENTITYMASTERINFO.ZIPCODE = e.ENTITY_INFO.ZIP_CODE;

            

            if (e.TAX_ACCT.Count > 0)
            {
                serv_req._ETA = new RTTIE016_SrvRef._ETA();
                serv_req._ETA._ENTITYTAXACCOUNTSs = new RTTIE016_SrvRef._ENTITYTAXACCOUNTS[e.TAX_ACCT.Count];

                for (int i = 0; i < e.TAX_ACCT.Count; i++)
                {
                    serv_req._ETA._ENTITYTAXACCOUNTSs[i] = new RTTIE016_SrvRef._ENTITYTAXACCOUNTS();

                    serv_req._ETA._ENTITYTAXACCOUNTSs[i].FUNCTIONCODE = CopMvcUtil.GetString(e.TAX_ACCT[i].FUNC_CODE);

                    serv_req._ETA._ENTITYTAXACCOUNTSs[i].ACCOUNTSpecified = CopMvcUtil.IsSpecified(e.TAX_ACCT[i].ACCOUNT);
                    serv_req._ETA._ENTITYTAXACCOUNTSs[i].ACCOUNT = CopMvcUtil.GetDecimal(e.TAX_ACCT[i].ACCOUNT);

                    serv_req._ETA._ENTITYTAXACCOUNTSs[i].ACCOUNTID = e.TAX_ACCT[i].ACCOUNT_ID;

                    serv_req._ETA._ENTITYTAXACCOUNTSs[i].STARTDATESpecified = CopMvcUtil.IsSpecified(e.TAX_ACCT[i].START_DATE);
                    serv_req._ETA._ENTITYTAXACCOUNTSs[i].STARTDATE = CopMvcUtil.ConvDateDecimal(e.TAX_ACCT[i].START_DATE);

                    serv_req._ETA._ENTITYTAXACCOUNTSs[i].ENDDATESpecified = CopMvcUtil.IsSpecified(e.TAX_ACCT[i].END_DATE);
                    serv_req._ETA._ENTITYTAXACCOUNTSs[i].ENDDATE = CopMvcUtil.ConvDateDecimal(e.TAX_ACCT[i].END_DATE);

                    serv_req._ETA._ENTITYTAXACCOUNTSs[i].BRTADDRESS = CopMvcUtil.GetString(e.TAX_ACCT[i].BRT_ADDRESS1);

                    serv_req._ETA._ENTITYTAXACCOUNTSs[i].FREQUENCY = e.TAX_ACCT[i].FREQUENCY_CODE;
                   
                }
            }

           
            serv_req._EWAGNTL = new RTTIE016_SrvRef._EWAGNTL();
            serv_req._EWAGNTL.ACCOUNTID = e.WAGE_NTL.ACCOUNT_ID;

           

            serv_req._EWAGNTL.FREQUENCY = e.WAGE_NTL.FREQUENCY_CODE;
            serv_req._EWAGNTL.ADJREFNO = e.WAGE_NTL.ADJ_REF_NO;
            serv_req._EWAGNTL.PREPARERNAME = e.WAGE_NTL.PREPARER_NAME;
            serv_req._EWAGNTL.PREPARERPHONE = e.WAGE_NTL.PREPARER_PHONE;
            serv_req._EWAGNTL.PREPARERPHONEEXT = e.WAGE_NTL.PREPARER_PHONE_EXT;
            serv_req._EWAGNTL.PREPARERIPADDRESS = e.WAGE_NTL.PREPARER_IP_ADDRESS;
            serv_req._EWAGNTL.PREPAREREMAIL = e.WAGE_NTL.PREPARER_EMAIL_ADDRESS;
            serv_req._EWAGNTL.PREPARERTYPE = e.WAGE_NTL.PREPARER_WHO;

            serv_req._EMI._ENTITYMASTERINFO.FUNCTIONCODE = e.ENTITY_INFO.FUNCTION_CODE;
            serv_req._EMI._ENTITYMASTERINFO.ENTITYTYPE = CopMvcUtil.ConvDecimal(e.ENTITY_INFO.ENT_TYPE);
            serv_req._EMI._ENTITYMASTERINFO.ENTITYID = e.ENTITY_INFO.ENTITY_ID;
            serv_req._EMI._ENTITYMASTERINFO.ACCTID = e.ENTITY_INFO.ACCT_ID;
            serv_req._EMI._ENTITYMASTERINFO.ENTITYNAME = e.ENTITY_INFO.NAME;
            serv_req._EMI._ENTITYMASTERINFO.ADDRESSLINE = e.ENTITY_INFO.ADDRESS1;
            serv_req._EMI._ENTITYMASTERINFO.ADDRESSLINE2 = e.ENTITY_INFO.ADDRESS2;
            serv_req._EMI._ENTITYMASTERINFO.ADDRESSLINE3 = e.ENTITY_INFO.ADDRESS3;
            serv_req._EMI._ENTITYMASTERINFO.CITY = e.ENTITY_INFO.CITY;
            serv_req._EMI._ENTITYMASTERINFO.STATE = e.ENTITY_INFO.STATE;
            serv_req._EMI._ENTITYMASTERINFO.ZIPCODE = e.ENTITY_INFO.ZIP_CODE;

            serv_req._EWAGNTL.PERIODX = new RTTIE016_SrvRef.PERIODX();
            serv_req._EWAGNTL.PERIODX.PERIODSpecified = CopMvcUtil.IsSpecified(e.WAGE_NTL.PERIOD);
            serv_req._EWAGNTL.PERIODX.PERIOD = CopMvcUtil.ConvDecimal(e.WAGE_NTL.PERIOD);



            RTTIE016_SrvRef.RTTIE216Response response = _client.RTTIE216(serv_req);

            e = __Fill(response);

            return e;

        }
    }
}
