using CopRevenueGov2.Service;
using COPXmlFactory;
using COPXmlFactory.RTTIE027;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Xml;

namespace CopRevenueGov2.Helpers
{
    public class RTTIE027 : CopRestServiceBase, ICopSoapService
    {
        
        public static void Init()
        {
            
        }

        public static string CallService(string Request)
        {

            COPXmlFactory.RTTIE027.WAGERETURN xo;

            try
            {
                xo = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE027.WAGERETURN>(Request);

                xo = __Call(xo);

            }
            catch (Exception ex)
            {
                xo =
                    RevenueGovXMLFactory.GetWageReturn();

                xo.ERROR_INFO = new ERROR_INFO();
                xo.ERROR_INFO.ERROR = 11.ToString();
                xo.ERROR_INFO.MESSAGE = ex.StackTrace;
            }

            return RevenueGovXMLFactory.GetXmlString(xo);

        }

        public static XmlDocument CallService(XmlDocument Request)
        {
            COPXmlFactory.RTTIE027.WAGERETURN acct;

            try
            {
                string InnerXML = Request.InnerXml;
                acct = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE027.WAGERETURN>(InnerXML);

                acct = __Call(acct);

            }
            catch (Exception ex)
            {
                acct = RevenueGovXMLFactory.GetWageReturn();

                acct.ERROR_INFO = new ERROR_INFO();
                acct.ERROR_INFO.ERROR = 11.ToString();
                acct.ERROR_INFO.MESSAGE = ex.StackTrace;
            }

            return RevenueGovXMLFactory.GetXmlDocument(acct);
        }

        private static WAGERETURN __Call(WAGERETURN e)
        {

            switch (e.WAGE_INFO.RETURN_STATUS)
            {
                case "INQ": // fill
                   e = __RTTIE027_F_I(e);                    
                    break;
                case null: // submit
                    e = __RTTIE027_F_U(e);
                    break;

                default:
                    e.WAGE_INFO.RETURN_STATUS = "INQ";
                    e = __RTTIE027_F_I(e);                   
                    break;
            }
            return e;
        }
        
        private static COPXmlFactory.RTTIE027.WAGERETURN __RTTIE027_F_I(COPXmlFactory.RTTIE027.WAGERETURN e)
        {          

            WAGE_RTTIE027_SrvRef.RT01E027_EWAG _EWAG = new WAGE_RTTIE027_SrvRef.RT01E027_EWAG();
            WAGE_RTTIE027_SrvRef.RT01E027 serv_req = new WAGE_RTTIE027_SrvRef.RT01E027();
            WAGE_RTTIE027_SrvRef.RT01E027Response_SMA _SMAResponse = new WAGE_RTTIE027_SrvRef.RT01E027Response_SMA();
            WAGE_RTTIE027_SrvRef.RT01E027Response_EAMT _EAMTResponse = new WAGE_RTTIE027_SrvRef.RT01E027Response_EAMT();
            WAGE_RTTIE027_SrvRef.RT01E027Response_EWAG _EWAGResponse = new WAGE_RTTIE027_SrvRef.RT01E027Response_EWAG();
            WAGE_RTTIE027_SrvRef.RT01E027Response_SERR _SERRResponse = new WAGE_RTTIE027_SrvRef.RT01E027Response_SERR();

            

            _EWAG.ACCOUNTID = e.WAGE_INFO.ACCOUNT_ID;
            _EWAG.PERIODX = CopMvcUtil.ConvDateDecimalString(e.WAGE_INFO.PERIOD);
            _EWAG.RETURNSTATUS = e.WAGE_INFO.RETURN_STATUS;


            _SMAResponse = serv_req.CallRT01E027
                                            (new WAGE_RTTIE027_SrvRef.RT01E027_SMA(), _EWAG,
                                              new WAGE_RTTIE027_SrvRef.RT01E027_EAMT(),
                                              out _EWAGResponse,
                                              out _EAMTResponse,
                                              out _SERRResponse                                              
                                            );





            e = _Fill(_SMAResponse, _EWAGResponse, _EAMTResponse, _SERRResponse);
            return e;

        }

        private static COPXmlFactory.RTTIE027.WAGERETURN _Fill(WAGE_RTTIE027_SrvRef.RT01E027Response_SMA _SMA,WAGE_RTTIE027_SrvRef.RT01E027Response_EWAG _EWAG,WAGE_RTTIE027_SrvRef.RT01E027Response_EAMT _EAMT,WAGE_RTTIE027_SrvRef.RT01E027Response_SERR _SERR)
        {
            COPXmlFactory.RTTIE027.WAGERETURN fobj = RevenueGovXMLFactory.GetWageReturn();

            //LOAD ERRORS INTO OBJECT
            fobj.ERROR_INFO = new ERROR_INFO();
            if (fobj.ERROR_INFO.LENGTH != null)
            {
                fobj.ERROR_INFO.PROGRAM = _SMA._PROGRAM;
                fobj.ERROR_INFO.LINE = _SMA.ERRORLINE.ToString();
                fobj.ERROR_INFO.MESSAGE = _SMA.MESSAGE;
                fobj.ERROR_INFO.ERROR = _SMA.SYSTEMERROR.ToString();

            }

            //LOAD WAGE_INFO 
            fobj.WAGE_INFO = new WAGE_INFO();
           
                fobj.WAGE_INFO.ACCOUNT_ID = _EWAG.ACCOUNTID;
                fobj.WAGE_INFO.PERIOD = CopMvcUtil.ConvDate(_EWAG.PERIODX);
                fobj.WAGE_INFO.VERSION = _EWAG.VERSIONX;
                fobj.WAGE_INFO.SEQUENCE = _EWAG.SEQUENCENUM;
                fobj.WAGE_INFO.RETURN_STATUS = _EWAG.RETURNSTATUS;
                fobj.WAGE_INFO.LAST_UPD_DATE = CopMvcUtil.ConvDate(_EWAG.LASTUPDATEDATEX);
                fobj.WAGE_INFO.DOCUMENT_CONTROL = _EWAG.DOCUMENTCONTROLX;
                fobj.WAGE_INFO.ADJ_REFNO_CONTROL = _EWAG.ADJREFNO;
                //fobj.WAGE_INFO.ENTITY_ID=e._EWA

                fobj.WAGE_INFO.NO_OF_NONRESIDENTS = CopMvcUtil.ConvDigitToInt(_EWAG.NUMBEROFNONRESIDENTSX);

                fobj.WAGE_INFO.NO_OF_RESIDENTS = CopMvcUtil.ConvDigitToInt(_EWAG.NUMBEROFRESIDENTSX);
                fobj.WAGE_INFO.PHILA_EMPLOYEES = CopMvcUtil.ConvDigitToInt(_EWAG.PHILAEMPLOYEESX);
                fobj.WAGE_INFO.TOTAL_EMPLOYEES = CopMvcUtil.ConvDigitToInt(_EWAG.TOTALEMPLOYEESX);

                fobj.WAGE_INFO.RESTAX_A = CopMvcUtil.ConvDigitToDouble9(_EWAG.RESRATEA);
                fobj.WAGE_INFO.RESTAX_B = CopMvcUtil.ConvDigitToDouble9(_EWAG.RESRATEB);
                fobj.WAGE_INFO.NONRESTAX_A = CopMvcUtil.ConvDigitToDouble9(_EWAG.NONRATEA);
                fobj.WAGE_INFO.NONRESTAX_B = CopMvcUtil.ConvDigitToDouble9(_EWAG.NONRATEB);
                fobj.WAGE_INFO.FREQUENCY = _EWAG.FREQUENCY;

                fobj.WAGE_INFO.DUE_DATE = CopMvcUtil.ConvDate(_EWAG.DUEDATE);

                fobj.WAGE_INFO.PREPARER_NAME = _EWAG.PREPARERNAME;
                fobj.WAGE_INFO.PREPARER_PHONE = Convert.ToString(_EWAG.PREPARERPHONE);
                fobj.WAGE_INFO.PREPARER_PHONE_EXT = _EWAG.PREPARERPHONEEXT;
                fobj.WAGE_INFO.PREPARER_IP_ADDRESS = _EWAG.PREPARERIPADDRESS;
                fobj.WAGE_INFO.PREPARER_EMAIL_ADDRESS = _EWAG.PREPAREREMAILADDRESS;
                fobj.WAGE_INFO.PREPARER_WHO = _EWAG.PREPARERTYPE;
            

            //LOAD AMT_INFO 
            fobj.AMT_INFO = new AMT_INFO();
           
                fobj.AMT_INFO.GROSS_COMP = CopMvcUtil.ConvDigitToCurrency(_EAMT.GROSSCOMPENSATIONX).ToString();
                fobj.AMT_INFO.TIPS_WAGES = CopMvcUtil.ConvDigitToCurrency(_EAMT.TIPSWAGESX).ToString();
                fobj.AMT_INFO.NON_TAXABLE_COMP = CopMvcUtil.ConvDigitToCurrency(_EAMT.NONTAXABLECOMPX).ToString();
                fobj.AMT_INFO.NET_COMP = CopMvcUtil.ConvDigitToCurrency(_EAMT.NETCOMPENSATIONX).ToString();
                fobj.AMT_INFO.RESIDENT_PAYROLL_A = CopMvcUtil.ConvDigitToCurrency(_EAMT.RESIDENTPAYROLLAX);
                fobj.AMT_INFO.RESIDENT_TAX_DUE_A = CopMvcUtil.ConvDigitToCurrency(_EAMT.RESIDENTTAXDUEAX).ToString();
                fobj.AMT_INFO.RESIDENT_PAYROLL_B = CopMvcUtil.ConvDigitToCurrency(_EAMT.RESIDENTPAYROLLBX).ToString();
                fobj.AMT_INFO.RESIDENT_TAX_DUE_B = CopMvcUtil.ConvDigitToCurrency(_EAMT.RESIDENTTAXDUEBX).ToString();
                fobj.AMT_INFO.NON_RES_PAYROLL_A = CopMvcUtil.ConvDigitToCurrency(_EAMT.NONRESPAYROLLAX);
                fobj.AMT_INFO.NON_RES_TAX_DUE_A = CopMvcUtil.ConvDigitToCurrency(_EAMT.NONRESTAXDUEAX).ToString();
                fobj.AMT_INFO.NON_RES_PAYROLL_B = CopMvcUtil.ConvDigitToCurrency(_EAMT.NONRESPAYROLLBX).ToString();
                fobj.AMT_INFO.NON_RES_TAX_DUE_B = CopMvcUtil.ConvDigitToCurrency(_EAMT.NONRESTAXDUEBX).ToString();
                fobj.AMT_INFO.TOTAL_GROSS_TAX_DUE = CopMvcUtil.ConvDigitToCurrency(_EAMT.TOTALGROSSTAXDUEX);
                fobj.AMT_INFO.TAX_PAID = CopMvcUtil.ConvDigitToCurrency(_EAMT.TAXPAIDX);
                fobj.AMT_INFO.TAX_DUE = CopMvcUtil.ConvDigitToCurrency(_EAMT.TAXDUEX);
                fobj.AMT_INFO.TAX_OVERPAID = CopMvcUtil.ConvDigitToCurrency(_EAMT.TAXOVERPAIDX);
                fobj.AMT_INFO.POSTING_DATE = CopMvcUtil.ConvDate(_EAMT.POSTINGDATEX);
                fobj.AMT_INFO.FILING_DATE = CopMvcUtil.ConvDate(_EAMT.FILINGDATEX);
                fobj.AMT_INFO.USER_ID = _EAMT.USERID;

            

            return fobj;

        }

        private static COPXmlFactory.RTTIE027.WAGERETURN __RTTIE027_F_U(COPXmlFactory.RTTIE027.WAGERETURN e)
        {     

          WAGE_RTTIE027_SrvRef.RT01E027 serv_req = new WAGE_RTTIE027_SrvRef.RT01E027();
          WAGE_RTTIE027_SrvRef.RT01E027_EWAG _EWAG = new WAGE_RTTIE027_SrvRef.RT01E027_EWAG();
          WAGE_RTTIE027_SrvRef.RT01E027_EAMT _EAMT = new WAGE_RTTIE027_SrvRef.RT01E027_EAMT();
          WAGE_RTTIE027_SrvRef.RT01E027_SMA _SMA = new WAGE_RTTIE027_SrvRef.RT01E027_SMA();
          
          

          WAGE_RTTIE027_SrvRef.RT01E027Response_SMA _SMAResponse = new WAGE_RTTIE027_SrvRef.RT01E027Response_SMA();
          WAGE_RTTIE027_SrvRef.RT01E027Response_EAMT _EAMTResponse = new WAGE_RTTIE027_SrvRef.RT01E027Response_EAMT();
          WAGE_RTTIE027_SrvRef.RT01E027Response_EWAG _EWAGResponse = new WAGE_RTTIE027_SrvRef.RT01E027Response_EWAG();
          WAGE_RTTIE027_SrvRef.RT01E027Response_SERR _SERRResponse = new WAGE_RTTIE027_SrvRef.RT01E027Response_SERR();

           
            _EWAG.ACCOUNTID = e.WAGE_INFO.ACCOUNT_ID;
            _EWAG.VERSIONX = e.WAGE_INFO.VERSION;
            _EWAG.PERIODX = CopMvcUtil.ConvDateDecimalString(e.WAGE_INFO.PERIOD);
            _EWAG.DOCUMENTCONTROLX = e.WAGE_INFO.DOCUMENT_CONTROL;
            _EWAG.ADJREFNO =e.WAGE_INFO.ADJ_REFNO_CONTROL;            

            _EWAG.RETURNSTATUS = e.WAGE_INFO.RETURN_STATUS;
            _EWAG.SEQUENCENUM = e.WAGE_INFO.SEQUENCE;
            _EWAG.LASTUPDATEDATEX = CopMvcUtil.ConvDateDecimalString(e.WAGE_INFO.LAST_UPD_DATE);
            _EWAG.NUMBEROFRESIDENTSX = CopMvcUtil.ConvNumberToDigit7(e.WAGE_INFO.NO_OF_RESIDENTS);

            _EWAG.NUMBEROFNONRESIDENTSX = CopMvcUtil.ConvNumberToDigit7(e.WAGE_INFO.NO_OF_NONRESIDENTS);
            _EWAG.PHILAEMPLOYEESX = CopMvcUtil.ConvNumberToDigit7(e.WAGE_INFO.PHILA_EMPLOYEES);
            _EWAG.TOTALEMPLOYEESX = CopMvcUtil.ConvNumberToDigit7(e.WAGE_INFO.TOTAL_EMPLOYEES);
            _EWAG.RESRATEA = CopMvcUtil.ConvNumberToDigit9(e.WAGE_INFO.RESTAX_A);
            _EWAG.RESRATEB = CopMvcUtil.ConvNumberToDigit9(e.WAGE_INFO.RESTAX_B);
            _EWAG.NONRATEA = CopMvcUtil.ConvNumberToDigit9(e.WAGE_INFO.NONRESTAX_A);
            _EWAG.NONRATEB = CopMvcUtil.ConvNumberToDigit9(e.WAGE_INFO.NONRESTAX_B);
            _EWAG.FREQUENCY = e.WAGE_INFO.FREQUENCY;
            _EWAG.DUEDATE = CopMvcUtil.ConvDateDecimalString(e.WAGE_INFO.DUE_DATE);



            _EWAG.PREPARERNAME = e.WAGE_INFO.PREPARER_NAME;
            _EWAG.PREPARERPHONE = CopMvcUtil.GetDecimal(e.WAGE_INFO.PREPARER_PHONE);
            _EWAG.PREPARERPHONEEXT = e.WAGE_INFO.PREPARER_PHONE_EXT;
            _EWAG.PREPARERIPADDRESS = e.WAGE_INFO.PREPARER_IP_ADDRESS;
            _EWAG.PREPAREREMAILADDRESS = e.WAGE_INFO.PREPARER_EMAIL_ADDRESS;
            _EWAG.PREPARERTYPE = e.WAGE_INFO.PREPARER_WHO; ;
            _EWAG.PREPARERPHONESpecified = true;

            
            _EAMT.GROSSCOMPENSATIONX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.GROSS_COMP);
            
            _EAMT.NONTAXABLECOMPX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.NON_TAXABLE_COMP);
            _EAMT.TIPSWAGESX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.TIPS_WAGES);// "000000000000000";
             _EAMT.NETCOMPENSATIONX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.NET_COMP);
            _EAMT.RESIDENTPAYROLLAX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.RESIDENT_PAYROLL_A);
            _EAMT.RESIDENTTAXDUEAX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.RESIDENT_TAX_DUE_A);
            _EAMT.RESIDENTPAYROLLBX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.RESIDENT_PAYROLL_B);
            _EAMT.RESIDENTTAXDUEBX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.RESIDENT_TAX_DUE_B);
            _EAMT.NONRESPAYROLLAX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.NON_RES_PAYROLL_A);
            _EAMT.NONRESTAXDUEAX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.NON_RES_TAX_DUE_A);
            _EAMT.NONRESPAYROLLBX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.NON_RES_PAYROLL_B);
            _EAMT.NONRESTAXDUEBX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.NON_RES_TAX_DUE_B);
            _EAMT.TOTALGROSSTAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.TOTAL_GROSS_TAX_DUE);
            _EAMT.TAXPAIDX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.TAX_PAID);
            _EAMT.TAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.TAX_DUE);
            _EAMT.TAXOVERPAIDX = CopMvcUtil.ConvCurrencyToDigit(e.AMT_INFO.TAX_OVERPAID);
            _EAMT.POSTINGDATEX = CopMvcUtil.ConvDateDecimalString(e.AMT_INFO.POSTING_DATE);
            _EAMT.FILINGDATEX = CopMvcUtil.ConvDateDecimalString(e.AMT_INFO.FILING_DATE);
            _EAMT.USERID =e.AMT_INFO.USER_ID;

            string s = CopMvcUtil.GetXMlFromObject(_EWAG);
            string s1 = CopMvcUtil.GetXMlFromObject(_EAMT);

            _SMAResponse = serv_req.CallRT01E027
                                            (_SMA, _EWAG,
                                              _EAMT,
                                              out _EWAGResponse,
                                              out _EAMTResponse,
                                              out _SERRResponse
                                            );





            e = _Fill(_SMAResponse, _EWAGResponse, _EAMTResponse, _SERRResponse);
            return e;


        }
    }
}
