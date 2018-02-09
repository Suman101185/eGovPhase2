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
       

        public static void Init()
        {
          
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

            RTTIE016_SrvRef.RTTIE016 rttie016 = new RTTIE016_SrvRef.RTTIE016();
            RTTIE016_SrvRef.RTTIE016_EMI _EMI = new RTTIE016_SrvRef.RTTIE016_EMI();
            RTTIE016_SrvRef.RTTIE016Response_SMA _SMAReponse = new RTTIE016_SrvRef.RTTIE016Response_SMA();
            RTTIE016_SrvRef.RTTIE016Response_EMI _EMIResponse = new RTTIE016_SrvRef.RTTIE016Response_EMI();
            RTTIE016_SrvRef.RTTIE016Response_ETA _ETAResponse = new RTTIE016_SrvRef.RTTIE016Response_ETA();
            RTTIE016_SrvRef.RTTIE016Response_EWAGNTL _EWAGNTLResponse = new RTTIE016_SrvRef.RTTIE016Response_EWAGNTL();

            _EMI._ENTITYMASTERINFO = new RTTIE016_SrvRef.RTTIE016_EMI_ENTITYMASTERINFO();
            _EMI._ENTITYMASTERINFO.ENTITYID = e.ENTITY_INFO.ENTITY_ID;
            _EMI._ENTITYMASTERINFO.FUNCTIONCODE = e.ENTITY_INFO.ENT_TYPE;

           _SMAReponse = rttie016.CallRTTIE016(
                                                 new RTTIE016_SrvRef.RTTIE016_SMA(), 
                                                 _EMI, 
                                                 new RTTIE016_SrvRef.RTTIE016_ETA(), 
                                                 new RTTIE016_SrvRef.RTTIE016_EWAGNTL(), 
                                                 out _EMIResponse, 
                                                 out _ETAResponse, 
                                                 out  _EWAGNTLResponse                                                 
            
                                                 );

           e = __Fill(_SMAReponse, _EMIResponse, _ETAResponse, _EWAGNTLResponse);

            return e;
        }

        private static COPXmlFactory.RTTIE016.PAYCOUPON __Fill(RTTIE016_SrvRef.RTTIE016Response_SMA _SMA,RTTIE016_SrvRef.RTTIE016Response_EMI _EMI,RTTIE016_SrvRef.RTTIE016Response_ETA _ETA,RTTIE016_SrvRef.RTTIE016Response_EWAGNTL _EWAGNTL)
        {
            COPXmlFactory.RTTIE016.PAYCOUPON fobj = RevenueGovXMLFactory.GetPAYCOUPON();

            //LOAD ERRORS INTO OBJECT
            fobj.ERROR_INFO = new ERROR_INFO();
            if (_SMA._SYSTEMMESSAGEAREA != null)
            {
                fobj.ERROR_INFO.PROGRAM = _SMA._SYSTEMMESSAGEAREA._PROGRAM;
                fobj.ERROR_INFO.LINE = _SMA._SYSTEMMESSAGEAREA.ERROR.ToString();
                fobj.ERROR_INFO.MESSAGE = _SMA._SYSTEMMESSAGEAREA.MESSAGE;
                fobj.ERROR_INFO.ERROR = _SMA._SYSTEMMESSAGEAREA.ERROR.ToString();

            }

            //LOAD ENTITY_INFO 
            fobj.ENTITY_INFO = new ENTITY_INFO();
            fobj.ENTITY_INFO.FUNCTION_CODE = _EMI._ENTITYMASTERINFO.FUNCTIONCODE;
            fobj.ENTITY_INFO.ENT_TYPE =CopMvcUtil.GetDouble(_EMI._ENTITYMASTERINFO.ENTITYTYPE).ToString();
            fobj.ENTITY_INFO.ENTITY_ID = _EMI._ENTITYMASTERINFO.ENTITYID;
            fobj.ENTITY_INFO.ACCT_ID = _EMI._ENTITYMASTERINFO.ACCTID;
            fobj.ENTITY_INFO.NAME = _EMI._ENTITYMASTERINFO.ENTITYNAME;
            fobj.ENTITY_INFO.ADDRESS1 = _EMI._ENTITYMASTERINFO.ADDRESSLINE;
            fobj.ENTITY_INFO.ADDRESS2 = _EMI._ENTITYMASTERINFO.ADDRESSLINE2;
            fobj.ENTITY_INFO.ADDRESS3 = _EMI._ENTITYMASTERINFO.ADDRESSLINE3;
            fobj.ENTITY_INFO.CITY = _EMI._ENTITYMASTERINFO.CITY;
            fobj.ENTITY_INFO.STATE = _EMI._ENTITYMASTERINFO.STATE;
            fobj.ENTITY_INFO.ZIP_CODE = _EMI._ENTITYMASTERINFO.ZIPCODE;

            //LOAD TAX ACCT s
            fobj.TAX_ACCT = new List<TAX_ACCT>();
            if (_ETA._ENTITYTAXACCOUNTSs != null)
            {
                for (int i = 0; i < _ETA._ENTITYTAXACCOUNTSs.Length; i++)
                {
                    fobj.TAX_ACCT.Add(COPXmlFactory.RevenueGovXMLFactory.GetPAYCOUPON_TAX_ACCT());
                    fobj.TAX_ACCT[i].FUNC_CODE = _ETA._ENTITYTAXACCOUNTSs[i].FUNCTIONCODE;
                    fobj.TAX_ACCT[i].ACCOUNT = CopMvcUtil.GetDecimal(_ETA._ENTITYTAXACCOUNTSs[i].ACCOUNT).ToString();
                    fobj.TAX_ACCT[i].ACCOUNT_ID = _ETA._ENTITYTAXACCOUNTSs[i].ACCOUNTID;
                    fobj.TAX_ACCT[i].START_DATE = CopMvcUtil.ConvDate(_ETA._ENTITYTAXACCOUNTSs[i].STARTDATE);
                    fobj.TAX_ACCT[i].END_DATE = CopMvcUtil.ConvDate(_ETA._ENTITYTAXACCOUNTSs[i].ENDDATE);
                    fobj.TAX_ACCT[i].BRT_ADDRESS1 = _ETA._ENTITYTAXACCOUNTSs[i].BRTADDRESS;
                    fobj.TAX_ACCT[i].FREQUENCY_CODE = _ETA._ENTITYTAXACCOUNTSs[i].FREQUENCY;

                }
            }

            //LOAD WAGE_NTL 
            fobj.WAGE_NTL = new WAGE_NTL();
            if (_EWAGNTL.ACCOUNTID != null)
            {
                fobj.WAGE_NTL.ACCOUNT_ID = _EWAGNTL.ACCOUNTID;
                fobj.WAGE_NTL.PERIOD = CopMvcUtil.ConvDate(_EWAGNTL.PERIODX.PERIOD);
                fobj.WAGE_NTL.FREQUENCY_CODE = _EWAGNTL.FREQUENCY;
                fobj.WAGE_NTL.ADJ_REF_NO = _EWAGNTL.ADJREFNO;
                fobj.WAGE_NTL.PREPARER_NAME = _EWAGNTL.PREPARERNAME;
                fobj.WAGE_NTL.PREPARER_PHONE = _EWAGNTL.PREPARERPHONE;
                fobj.WAGE_NTL.PREPARER_PHONE_EXT = _EWAGNTL.PREPARERPHONEEXT;
                fobj.WAGE_NTL.PREPARER_IP_ADDRESS = _EWAGNTL.PREPARERIPADDRESS;
                fobj.WAGE_NTL.PREPARER_EMAIL_ADDRESS = _EWAGNTL.PREPAREREMAIL;
                fobj.WAGE_NTL.PREPARER_WHO = _EWAGNTL.PREPARERTYPE;
            }
            else
            {
                fobj.WAGE_NTL.ACCOUNT_ID = "";
                fobj.WAGE_NTL.PERIOD = "";
                fobj.WAGE_NTL.FREQUENCY_CODE = "";
                fobj.WAGE_NTL.ADJ_REF_NO = "";
                fobj.WAGE_NTL.PREPARER_NAME = "";
                fobj.WAGE_NTL.PREPARER_PHONE = "";
                fobj.WAGE_NTL.PREPARER_PHONE_EXT ="";
                fobj.WAGE_NTL.PREPARER_IP_ADDRESS = "";
                fobj.WAGE_NTL.PREPARER_EMAIL_ADDRESS ="";
                fobj.WAGE_NTL.PREPARER_WHO ="";
            }
            //LOAD COUPON_FORM 
            fobj.COUPON_FORM = new COUPON_FORM();
            if (_EWAGNTL.ACCOUNTID != null)
            {
                fobj.COUPON_FORM.CPN_ACCOUNT = "";
                fobj.COUPON_FORM.CPN_ACCOUNT_TYPE = "";
                fobj.COUPON_FORM.CPN_NAME ="";
                fobj.COUPON_FORM.CPN_ADDR = "";
                fobj.COUPON_FORM.CPN_ADDR2 = "";
                fobj.COUPON_FORM.CPN_ADDR3 = "";
                fobj.COUPON_FORM.CPN_CITY = "";
                fobj.COUPON_FORM.CPN_STATE = "";
                fobj.COUPON_FORM.CPN_ZIP_CODE = "";
                fobj.COUPON_FORM.CPN_SCAN = "";
                fobj.COUPON_FORM.CPN_PERIOD = "";
                fobj.COUPON_FORM.CPN_YEAR = "";
                fobj.COUPON_FORM.CPN_FORM = "";
            }
         
            return fobj;

        }

        private static COPXmlFactory.RTTIE016.PAYCOUPON __RTTIE016_F_U(COPXmlFactory.RTTIE016.PAYCOUPON e)
        {


            RTTIE016_SrvRef.RTTIE016 rttie016 = new RTTIE016_SrvRef.RTTIE016();
            RTTIE016_SrvRef.RTTIE016_EMI _EMI = new RTTIE016_SrvRef.RTTIE016_EMI();
            RTTIE016_SrvRef.RTTIE016_ETA _ETA = new RTTIE016_SrvRef.RTTIE016_ETA();
            RTTIE016_SrvRef.RTTIE016_EWAGNTL _EWAGNTL = new RTTIE016_SrvRef.RTTIE016_EWAGNTL();

            RTTIE016_SrvRef.RTTIE016Response_SMA _SMAReponse = new RTTIE016_SrvRef.RTTIE016Response_SMA();
            RTTIE016_SrvRef.RTTIE016Response_EMI _EMIResponse = new RTTIE016_SrvRef.RTTIE016Response_EMI();
            RTTIE016_SrvRef.RTTIE016Response_ETA _ETAResponse = new RTTIE016_SrvRef.RTTIE016Response_ETA();
            RTTIE016_SrvRef.RTTIE016Response_EWAGNTL _EWAGNTLResponse = new RTTIE016_SrvRef.RTTIE016Response_EWAGNTL();


            //LOAD ENTITY_INFO 
            _EMI._ENTITYMASTERINFO = new RTTIE016_SrvRef.RTTIE016_EMI_ENTITYMASTERINFO();
            
            _EMI._ENTITYMASTERINFO.FUNCTIONCODE = e.ENTITY_INFO.FUNCTION_CODE;
            _EMI._ENTITYMASTERINFO.ENTITYTYPE =CopMvcUtil.GetDecimal(e.ENTITY_INFO.ENT_TYPE);
            _EMI._ENTITYMASTERINFO.ENTITYID = e.ENTITY_INFO.ENTITY_ID;
            _EMI._ENTITYMASTERINFO.ACCTID = e.ENTITY_INFO.ACCT_ID;
            _EMI._ENTITYMASTERINFO.ENTITYNAME = e.ENTITY_INFO.NAME;
            _EMI._ENTITYMASTERINFO.ADDRESSLINE = e.ENTITY_INFO.ADDRESS1;
            _EMI._ENTITYMASTERINFO.ADDRESSLINE2 = e.ENTITY_INFO.ADDRESS2;
            _EMI._ENTITYMASTERINFO.ADDRESSLINE3 = e.ENTITY_INFO.ADDRESS3;
            _EMI._ENTITYMASTERINFO.CITY = e.ENTITY_INFO.CITY;
            _EMI._ENTITYMASTERINFO.STATE = e.ENTITY_INFO.STATE;
            _EMI._ENTITYMASTERINFO.ZIPCODE = e.ENTITY_INFO.ZIP_CODE;

            if (e.TAX_ACCT.Count > 0)
            {
                
                _ETA._ENTITYTAXACCOUNTSs = new RTTIE016_SrvRef.RTTIE016_ETA_ENTITYTAXACCOUNTS[e.TAX_ACCT.Count];

                for (int i = 0; i < e.TAX_ACCT.Count; i++)
                {
                    _ETA._ENTITYTAXACCOUNTSs[i] = new RTTIE016_SrvRef.RTTIE016_ETA_ENTITYTAXACCOUNTS();

                    _ETA._ENTITYTAXACCOUNTSs[i].FUNCTIONCODE = CopMvcUtil.GetString(e.TAX_ACCT[i].FUNC_CODE);

                   
                   _ETA._ENTITYTAXACCOUNTSs[i].ACCOUNT = CopMvcUtil.GetDecimal(e.TAX_ACCT[i].ACCOUNT);

                    _ETA._ENTITYTAXACCOUNTSs[i].ACCOUNTID = e.TAX_ACCT[i].ACCOUNT_ID;

                    
                    _ETA._ENTITYTAXACCOUNTSs[i].STARTDATE = CopMvcUtil.GetDecimal(e.TAX_ACCT[i].START_DATE);

                   
                    _ETA._ENTITYTAXACCOUNTSs[i].ENDDATE = CopMvcUtil.GetDecimal(e.TAX_ACCT[i].END_DATE);

                    _ETA._ENTITYTAXACCOUNTSs[i].BRTADDRESS = CopMvcUtil.GetString(e.TAX_ACCT[i].BRT_ADDRESS1);

                    _ETA._ENTITYTAXACCOUNTSs[i].FREQUENCY = e.TAX_ACCT[i].FREQUENCY_CODE;

                }
            }
           
            _EWAGNTL.ACCOUNTID = e.WAGE_NTL.ACCOUNT_ID;



            _EWAGNTL.FREQUENCY = e.WAGE_NTL.FREQUENCY_CODE;
            _EWAGNTL.ADJREFNO = e.WAGE_NTL.ADJ_REF_NO;
            _EWAGNTL.PREPARERNAME = e.WAGE_NTL.PREPARER_NAME;
            _EWAGNTL.PREPARERPHONE = e.WAGE_NTL.PREPARER_PHONE;
            _EWAGNTL.PREPARERPHONEEXT = e.WAGE_NTL.PREPARER_PHONE_EXT;
            _EWAGNTL.PREPARERIPADDRESS = e.WAGE_NTL.PREPARER_IP_ADDRESS;
            _EWAGNTL.PREPAREREMAIL = e.WAGE_NTL.PREPARER_EMAIL_ADDRESS;
            _EWAGNTL.PREPARERTYPE = e.WAGE_NTL.PREPARER_WHO;

            _EMI._ENTITYMASTERINFO.FUNCTIONCODE = e.ENTITY_INFO.FUNCTION_CODE;
            _EMI._ENTITYMASTERINFO.ENTITYTYPE = CopMvcUtil.GetDecimal(e.ENTITY_INFO.ENT_TYPE);
            _EMI._ENTITYMASTERINFO.ENTITYID = e.ENTITY_INFO.ENTITY_ID;
            _EMI._ENTITYMASTERINFO.ACCTID = e.ENTITY_INFO.ACCT_ID;
            _EMI._ENTITYMASTERINFO.ENTITYNAME = e.ENTITY_INFO.NAME;
            _EMI._ENTITYMASTERINFO.ADDRESSLINE = e.ENTITY_INFO.ADDRESS1;
            _EMI._ENTITYMASTERINFO.ADDRESSLINE2 = e.ENTITY_INFO.ADDRESS2;
            _EMI._ENTITYMASTERINFO.ADDRESSLINE3 = e.ENTITY_INFO.ADDRESS3;
            _EMI._ENTITYMASTERINFO.CITY = e.ENTITY_INFO.CITY;
            _EMI._ENTITYMASTERINFO.STATE = e.ENTITY_INFO.STATE;
            _EMI._ENTITYMASTERINFO.ZIPCODE = e.ENTITY_INFO.ZIP_CODE;

            _EWAGNTL.PERIODX = new RTTIE016_SrvRef.RTTIE016_EWAGNTLPERIODX();
            
            _EWAGNTL.PERIODX.PERIOD = CopMvcUtil.GetDecimal(e.WAGE_NTL.PERIOD);
            _EWAGNTL.PERIODX.PERIODSpecified = true;
            _SMAReponse = rttie016.CallRTTIE016(
                                                 new RTTIE016_SrvRef.RTTIE016_SMA(),
                                                 _EMI,
                                                 _ETA,
                                                 _EWAGNTL,
                                                 out _EMIResponse,
                                                 out _ETAResponse,
                                                 out  _EWAGNTLResponse

                                                 );

            e = __Fill(_SMAReponse, _EMIResponse, _ETAResponse, _EWAGNTLResponse);
           

            return e;

        }
    }
}
