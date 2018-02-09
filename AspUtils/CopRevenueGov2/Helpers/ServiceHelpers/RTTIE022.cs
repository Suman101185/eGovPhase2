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

        
        static RTTIE222_SrvRef.RTTIE222WS_PortTypeClient _client = null;

        public static void Init()
        {
            _client = COPServiceURLHelper.GetServiceClient_RTTIE222();
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
            
            RTTIE222_SrvRef.RTTIE222 serv_req = new RTTIE222_SrvRef.RTTIE222();

            serv_req._EMI = new RTTIE222_SrvRef._EMI();

            serv_req._EMI._ENTITYMASTERINFO = new RTTIE222_SrvRef._ENTITYMASTERINFO();

            serv_req._EMI._ENTITYMASTERINFO.ENTITYTYPESpecified = CopMvcUtil.IsSpecified(e.DEL_INFO.ENTITY_TYPE);
            serv_req._EMI._ENTITYMASTERINFO.ENTITYTYPE = CopMvcUtil.ConvDecimal(e.DEL_INFO.ENTITY_TYPE);
            serv_req._EMI._ENTITYMASTERINFO.ENTITYID = e.DEL_INFO.ENTITY_ID;
            serv_req._EMI._ENTITYMASTERINFO.FUNCTION = e.DEL_INFO.FUNCTION;
           
            RTTIE222_SrvRef.RTTIE222Response response = _client.RTTIE2222(serv_req);

            e = _Fill(response);

            return e;
        }

        private static COPXmlFactory.RTTIE022.DelinquentForm _Fill(RTTIE222_SrvRef.RTTIE222Response e)
        {
            COPXmlFactory.RTTIE022.DelinquentForm fobj = RevenueGovXMLFactory.GetDelinquentForm();

            //LOAD ERRORS INTO OBJECT
            fobj.ERROR_INFO = new ERROR_INFO();

            fobj.ERROR_INFO.PROGRAM = e._SMA._SYSTEMMESSAGEAREA._PROGRAM;
            fobj.ERROR_INFO.LINE = e._SMA._SYSTEMMESSAGEAREA.LINE.ToString() ;
            fobj.ERROR_INFO.MESSAGE = e._SMA._SYSTEMMESSAGEAREA.MESSAGE;
            fobj.ERROR_INFO.ERROR = e._SMA._SYSTEMMESSAGEAREA.ERROR.ToString();

            //LOAD DEL_INFO 
            fobj.DEL_INFO = new DEL_INFO();
            fobj.DEL_INFO.ENTITY_TYPE = e._EMI._ENTITYMASTERINFO.ENTITYTYPE.ToString();
            fobj.DEL_INFO.ENTITY_ID = e._EMI._ENTITYMASTERINFO.ENTITYID.ToString();
            fobj.DEL_INFO.FUNCTION = e._EMI._ENTITYMASTERINFO.FUNCTION.ToString();
            fobj.DEL_INFO.NOTICE_NUM = e._EMI._ENTITYMASTERINFO.NOTICENUM.ToString();
            fobj.DEL_INFO.NEXT_ACCOUNT_TYPE = e._EMI._ENTITYMASTERINFO.NEXTACCOUNT.ToString();
            fobj.DEL_INFO.NEXT_ACCOUNT_ID = e._EMI._ENTITYMASTERINFO.NEXTACCOUNTID.ToString();
            fobj.DEL_INFO.NEXT_PERIOD = e._EMI._ENTITYMASTERINFO.NEXTPERIOD.ToString();

            //LOAD DEL_INFO 
            for (int i = 0; i < e._ETA._ENTITYTAXACCOUNTSs.Length; i++)
            {
                fobj.DEL_ACCTs.Add(RevenueGovXMLFactory.GetDelinquent_DEL_ACCT());

                fobj.DEL_ACCTs[i].FUNCTION_CODE = e._ETA._ENTITYTAXACCOUNTSs[i].FUNCTIONCODE;
                fobj.DEL_ACCTs[i].ACCOUNT_TYPE = e._ETA._ENTITYTAXACCOUNTSs[i].ACCOUNT;
                fobj.DEL_ACCTs[i].ACCOUNT_ID = e._ETA._ENTITYTAXACCOUNTSs[i].ACCOUNTID;
                fobj.DEL_ACCTs[i].PERIOD = CopMvcUtil.ConvDate(e._ETA._ENTITYTAXACCOUNTSs[i].PERIODX);
                fobj.DEL_ACCTs[i].PRINCIPAL_DUE = CopMvcUtil.ConvDigitToCurrency(e._ETA._ENTITYTAXACCOUNTSs[i].PRINCIPALX);
                fobj.DEL_ACCTs[i].INTEREST_DUE = CopMvcUtil.ConvDigitToCurrency(e._ETA._ENTITYTAXACCOUNTSs[i].INTERESTX);
                fobj.DEL_ACCTs[i].PENALTY_DUE = CopMvcUtil.ConvDigitToCurrency(e._ETA._ENTITYTAXACCOUNTSs[i].PENALTYX);
                fobj.DEL_ACCTs[i].OTHER_DUE = CopMvcUtil.ConvDigitToCurrency(e._ETA._ENTITYTAXACCOUNTSs[i].OTHERX);
                fobj.DEL_ACCTs[i].BRT_ENTITY = e._ETA._ENTITYTAXACCOUNTSs[i].BRTENTITY;
                fobj.DEL_ACCTs[i].BRT_ADDRESS = e._ETA._ENTITYTAXACCOUNTSs[i].BRTADDRESS;
                fobj.DEL_ACCTs[i].FILL = e._ETA._ENTITYTAXACCOUNTSs[i].FILL;
            }


            return fobj;

        }

        private static COPXmlFactory.RTTIE022.DelinquentForm __RTTIE222_F_U(COPXmlFactory.RTTIE022.DelinquentForm e)
        {
            
            RTTIE222_SrvRef.RTTIE222 serv_req = new RTTIE222_SrvRef.RTTIE222();
            /*
            serv_req._EWAG = new RTTIE022_SrvRef._EWAG();
            serv_req._EWAG.ACCOUNTID = e.WAGE_INFO.ACCOUNT_ID;
            serv_req._EWAG.VERSIONX = e.WAGE_INFO.VERSION;
            serv_req._EWAG.PERIODX = CopMvcUtil.ConvDateDecimalString(e.WAGE_INFO.PERIOD);
            serv_req._EWAG.DOCUMENTCONTROLX = e.WAGE_INFO.DOCUMENT_CONTROL;
            serv_req._EWAG.ADJREFNO =e.WAGE_INFO.ADJ_REFNO_CONTROL;

         //   serv_req._EWAG.en = e.WAGE_INFO.ENTITY_ID;

            serv_req._EWAG.RETURNSTATUS = e.WAGE_INFO.RETURN_STATUS;
            serv_req._EWAG.SEQUENCENUM = e.WAGE_INFO.SEQUENCE;
            serv_req._EWAG.LASTUPDATEDATEX = CopMvcUtil.ConvDateDecimalString(e.WAGE_INFO.LAST_UPD_DATE);
            serv_req._EWAG.NUMBEROFRESIDENTSX = e.WAGE_INFO.NO_OF_RESIDENTS;
            serv_req._EWAG.NUMBEROFNONRESIDENTSX = e.WAGE_INFO.NO_OF_NONRESIDENTS;
            serv_req._EWAG.PHILAEMPLOYEESX = e.WAGE_INFO.PHILA_EMPLOYEES;
            serv_req._EWAG.TOTALEMPLOYEESX = e.WAGE_INFO.TOTAL_EMPLOYEES;
            serv_req._EWAG.RESRATEA = CopMvcUtil.ConvNumberToDigit9(e.WAGE_INFO.RESTAX_A);
            serv_req._EWAG.RESRATEB = CopMvcUtil.ConvNumberToDigit9(e.WAGE_INFO.RESTAX_B);
            serv_req._EWAG.NONRATEA = CopMvcUtil.ConvNumberToDigit9(e.WAGE_INFO.NONRESTAX_A);
            serv_req._EWAG.NONRATEB = CopMvcUtil.ConvNumberToDigit9(e.WAGE_INFO.NONRESTAX_B);
            serv_req._EWAG.FREQUENCY = e.WAGE_INFO.FREQUENCY;
            serv_req._EWAG.DUEDATE = CopMvcUtil.ConvDateDecimalString(e.WAGE_INFO.DUE_DATE);



            serv_req._EWAG.PREPARERNAME = e.WAGE_INFO.PREPARER_NAME;
            serv_req._EWAG.PREPARERPHONE = e.WAGE_INFO.PREPARER_PHONE;
            serv_req._EWAG.PREPARERPHONEEXT = e.WAGE_INFO.PREPARER_PHONE_EXT;
            serv_req._EWAG.PREPARERIPADDRESS = e.WAGE_INFO.PREPARER_IP_ADDRESS;
            serv_req._EWAG.PREPAREREMAILADDRESS = e.WAGE_INFO.PREPARER_EMAIL_ADDRESS;
            serv_req._EWAG.PREPARERTYPE = e.WAGE_INFO.PREPARER_WHO; ;


            serv_req._EAMT = new RTTIE022_Srvref._EAMT();
            serv_req._EAMT.GROSSCOMPENSATIONX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.GROSS_COMP);
            serv_req._EAMT.NONTAXABLECOMPX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.NON_TAXABLE_COMP);
            serv_req._EAMT.NETCOMPENSATIONX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.NET_COMP);
            serv_req._EAMT.RESIDENTPAYROLLAX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.RESIDENT_PAYROLL_A);
            serv_req._EAMT.RESIDENTTAXDUEAX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.RESIDENT_TAX_DUE_A);
            serv_req._EAMT.RESIDENTPAYROLLBX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.RESIDENT_PAYROLL_B);
            serv_req._EAMT.RESIDENTTAXDUEBX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.RESIDENT_TAX_DUE_B);
            serv_req._EAMT.NONRESPAYROLLAX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.NON_RES_PAYROLL_A);
            serv_req._EAMT.NONRESTAXDUEAX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.NON_RES_TAX_DUE_A);
            serv_req._EAMT.NONRESPAYROLLBX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.NON_RES_PAYROLL_B);
            serv_req._EAMT.NONRESTAXDUEBX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.NON_RES_TAX_DUE_B);
            serv_req._EAMT.TOTALGROSSTAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.TOTAL_GROSS_TAX_DUE);
            serv_req._EAMT.TAXPAIDX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.TAX_PAID);
            serv_req._EAMT.TAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.TAX_DUE);
            serv_req._EAMT.TAXOVERPAIDX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.TAX_OVERPAID);
            serv_req._EAMT.POSTINGDATEX = CopMvcUtil.ConvDateDecimalString(e.AMT_INFO.POSTING_DATE);
            serv_req._EAMT.FILINGDATEX = CopMvcUtil.ConvDateDecimalString(e.AMT_INFO.FILING_DATE);
            serv_req._EAMT.USERID =e.AMT_INFO.USER_ID;



            RTTIE022_Srvref.RTTIE022Response response = _client.RTTIE022(serv_req);

            e = _Fill(response);
            */
            return e;

        }
    }
}
