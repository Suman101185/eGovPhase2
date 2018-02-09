using CopRevenueGov2.Service;
using COPXmlFactory;
using COPXmlFactory.RTTIE022;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Xml;

namespace CopRevenueGov2.Helpers
{
    public class RTTIE022 : CopRestServiceBase, ICopSoapService
    {        

        public static void Init()
        {
           
        }

        public static string CallService(string Request)
        {

            COPXmlFactory.RTTIE022.DelinquentForm xo;

            try
            {
                xo = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE022.DelinquentForm>(Request);

                xo = __Call(xo);

            }
            catch (Exception ex)
            {
                xo =
                    RevenueGovXMLFactory.GetDelinquentForm();

                xo.ERROR_INFO = new ERROR_INFO();
                xo.ERROR_INFO.ERROR = 11.ToString();
                xo.ERROR_INFO.MESSAGE = ex.Message;
            }

            return RevenueGovXMLFactory.GetXmlString(xo);

        }

        public static XmlDocument CallService(XmlDocument Request)
        {
            COPXmlFactory.RTTIE022.DelinquentForm acct;

            try
            {
                string InnerXML = Request.InnerXml;
                acct = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE022.DelinquentForm>(InnerXML);

                acct = __Call(acct);

            }
            catch (Exception ex)
            {
                acct = RevenueGovXMLFactory.GetDelinquentForm();

                acct.ERROR_INFO = new ERROR_INFO();
                acct.ERROR_INFO.ERROR = 11.ToString();
                acct.ERROR_INFO.MESSAGE = ex.Message;
            }

            return RevenueGovXMLFactory.GetXmlDocument(acct);
        }

        private static DelinquentForm __Call(DelinquentForm e)
        {

            switch (e.DEL_INFO.FUNCTION)
            {
                case "I": // fill
                    e = __RTTIE222_F_I(e);
                    break;
                case null: // submit
                    e = __RTTIE222_F_U(e);
                    break;

                default:
                    e = __RTTIE222_F_I(e);
                    break;
            }
            return e;
        }

        private static COPXmlFactory.RTTIE022.DelinquentForm __RTTIE222_F_I(COPXmlFactory.RTTIE022.DelinquentForm e)
        {

            
            RTTIE022_SrvRef.RTTIE022_EMI _EMI = new RTTIE022_SrvRef.RTTIE022_EMI();
            RTTIE022_SrvRef.RTTIE022 rttie022 = new RTTIE022_SrvRef.RTTIE022();

            RTTIE022_SrvRef.RTTIE022Response_EMI _EMIResponse = new RTTIE022_SrvRef.RTTIE022Response_EMI();
            RTTIE022_SrvRef.RTTIE022Response_SMA _SMAResponse = new RTTIE022_SrvRef.RTTIE022Response_SMA();
            RTTIE022_SrvRef.RTTIE022Response_ETA _ETAResponse = new RTTIE022_SrvRef.RTTIE022Response_ETA();        


           

            _EMI._ENTITYMASTERINFO = new RTTIE022_SrvRef.RTTIE022_EMI_ENTITYMASTERINFO();

           
            _EMI._ENTITYMASTERINFO.ENTITYTYPE = CopMvcUtil.GetDecimal(e.DEL_INFO.ENTITY_TYPE);
            _EMI._ENTITYMASTERINFO.ENTITYID = e.DEL_INFO.ENTITY_ID;
            _EMI._ENTITYMASTERINFO.FUNCTION = e.DEL_INFO.FUNCTION;
            _EMI._ENTITYMASTERINFO.ENTITYTYPESpecified = true;
               
          
            _SMAResponse = rttie022.CallRTTIE022( //calling the service for status...
                                             new RTTIE022_SrvRef.RTTIE022_SMA(), 
                                             _EMI, 
                                             new RTTIE022_SrvRef.RTTIE022_ETA(),                                              
                                             out _EMIResponse, 
                                             out _ETAResponse
                                             );
            e = _Fill(_SMAResponse, _EMIResponse, _ETAResponse);

            return e;
        }


        private static COPXmlFactory.RTTIE022.DelinquentForm _Fill(RTTIE022_SrvRef.RTTIE022Response_SMA _SMA, RTTIE022_SrvRef.RTTIE022Response_EMI _EMI, RTTIE022_SrvRef.RTTIE022Response_ETA _ETA)
        {
            COPXmlFactory.RTTIE022.DelinquentForm fobj = RevenueGovXMLFactory.GetDelinquentForm();

            //LOAD ERRORS INTO OBJECT
            fobj.ERROR_INFO = new ERROR_INFO();
            if (fobj.ERROR_INFO.LENGTH != null)
            {
                fobj.ERROR_INFO.PROGRAM = _SMA._SYSTEMMESSAGEAREA._PROGRAM;
                fobj.ERROR_INFO.LINE = _SMA._SYSTEMMESSAGEAREA.LINE.ToString();
                fobj.ERROR_INFO.MESSAGE = _SMA._SYSTEMMESSAGEAREA.MESSAGE;
                fobj.ERROR_INFO.ERROR = _SMA._SYSTEMMESSAGEAREA.ERROR.ToString();
            }
            
            //LOAD DEL_INFO 
            fobj.DEL_INFO = new DEL_INFO();
            
                fobj.DEL_INFO.ENTITY_TYPE = _EMI._ENTITYMASTERINFO.ENTITYTYPE.ToString();
                fobj.DEL_INFO.ENTITY_ID = _EMI._ENTITYMASTERINFO.ENTITYID.ToString();
                fobj.DEL_INFO.FUNCTION = _EMI._ENTITYMASTERINFO.FUNCTION;
                fobj.DEL_INFO.NOTICE_NUM = _EMI._ENTITYMASTERINFO.NOTICENUM;
                fobj.DEL_INFO.NEXT_ACCOUNT_TYPE = _EMI._ENTITYMASTERINFO.NEXTACCOUNT.ToString();
                fobj.DEL_INFO.NEXT_ACCOUNT_ID = _EMI._ENTITYMASTERINFO.NEXTACCOUNTID.ToString();
                fobj.DEL_INFO.NEXT_PERIOD = _EMI._ENTITYMASTERINFO.NEXTPERIOD.ToString();

                //LOAD DEL_INFO 
                for (int i = 0; i < _ETA._ENTITYTAXACCOUNTSs.Length; i++)
                {
                    fobj.DEL_ACCTs.Add(RevenueGovXMLFactory.GetDelinquent_DEL_ACCT());

                    fobj.DEL_ACCTs[i].FUNCTION_CODE = _ETA._ENTITYTAXACCOUNTSs[i].FUNCTIONCODE;
                    fobj.DEL_ACCTs[i].ACCOUNT_TYPE = CopMvcUtil.GetString(_ETA._ENTITYTAXACCOUNTSs[i].ACCOUNT);
                    fobj.DEL_ACCTs[i].ACCOUNT_ID = _ETA._ENTITYTAXACCOUNTSs[i].ACCOUNTID;
                    fobj.DEL_ACCTs[i].PERIOD = CopMvcUtil.ConvDate(_ETA._ENTITYTAXACCOUNTSs[i].PERIODX);
                    fobj.DEL_ACCTs[i].PRINCIPAL_DUE = CopMvcUtil.ConvDigitToCurrency(_ETA._ENTITYTAXACCOUNTSs[i].PRINCIPALX);
                    fobj.DEL_ACCTs[i].INTEREST_DUE = CopMvcUtil.ConvDigitToCurrency(_ETA._ENTITYTAXACCOUNTSs[i].INTERESTX);
                    fobj.DEL_ACCTs[i].PENALTY_DUE = CopMvcUtil.ConvDigitToCurrency(_ETA._ENTITYTAXACCOUNTSs[i].PENALTYX);
                    fobj.DEL_ACCTs[i].OTHER_DUE = CopMvcUtil.ConvDigitToCurrency(_ETA._ENTITYTAXACCOUNTSs[i].OTHERX);
                    fobj.DEL_ACCTs[i].BRT_ENTITY = _ETA._ENTITYTAXACCOUNTSs[i].BRTENTITY;
                    fobj.DEL_ACCTs[i].BRT_ADDRESS = _ETA._ENTITYTAXACCOUNTSs[i].BRTADDRESS;
                    fobj.DEL_ACCTs[i].FILL = _ETA._ENTITYTAXACCOUNTSs[i].FILL;
                }
            


            return fobj;

        }

        private static COPXmlFactory.RTTIE022.DelinquentForm __RTTIE222_F_U(COPXmlFactory.RTTIE022.DelinquentForm e)
        {

            RTTIE022_SrvRef.RTTIE022 rttie022 = new RTTIE022_SrvRef.RTTIE022();            
            return e;

        }
    }
}
