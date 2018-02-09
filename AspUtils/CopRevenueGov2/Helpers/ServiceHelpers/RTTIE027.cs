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

        static RTTIE227_Srvref.RTTIE227WS_PortTypeClient _client = null;

        public static void Init()
        {
            _client = COPServiceURLHelper.GetServiceClient_RTTIE227();
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
                   // e = __RTTIE027_F_I(e);
                    e = __RTTIE027_F_I("D:/sanghamitra/Sanghamitra Acharya/CopPhase2/SourceCode/EGovCurrent23.5/Xml files/Wage/WageSubmitResponse1.xml");
                    break;
                case null: // submit
                    e = __RTTIE027_F_U(e);
                    break;

                default:
                    e = __RTTIE027_F_I("D:/sanghamitra/Sanghamitra Acharya/CopPhase2/SourceCode/EGovCurrent23.5/Xml files/Wage/WageSubmitResponse1.xml");
                    break;
            }
            return e;
        }
        private static COPXmlFactory.RTTIE027.WAGERETURN __RTTIE027_F_I(string ReplyXMLPath)
        {
            //Read from XML file and return the object

            CopMvcUtil utl = new CopMvcUtil();

            string xmlstring = utl.GetXMLString(ReplyXMLPath);

            COPXmlFactory.RTTIE027.WAGERETURN e;

            e = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE027.WAGERETURN>(
                xmlstring);


            return e;

        }
        //private static COPXmlFactory.RTTIE027.WAGERETURN __RTTIE027_F_I(COPXmlFactory.RTTIE027.WAGERETURN e)
        //{
        //    RTTIE227_Srvref.RTTIE027 serv_req = new RTTIE227_Srvref.RTTIE027();

        //    serv_req._EWAG = new RTTIE227_Srvref._EWAG();

        //    serv_req._EWAG.ACCOUNTID = e.WAGE_INFO.ACCOUNT_ID;
        //    serv_req._EWAG.PERIODX = CopMvcUtil.ConvDateDecimalString(e.WAGE_INFO.PERIOD);
        //    serv_req._EWAG.RETURNSTATUS = e.WAGE_INFO.RETURN_STATUS;
           
        //    RTTIE227_Srvref.RTTIE027Response response = _client.RTTIE027(serv_req);

        //    e = _Fill(response);

        //    return e;
        //}

        private static COPXmlFactory.RTTIE027.WAGERETURN _Fill(RTTIE227_Srvref.RTTIE227Response e)
        {
            COPXmlFactory.RTTIE027.WAGERETURN fobj = RevenueGovXMLFactory.GetWageReturn();

            //LOAD ERRORS INTO OBJECT
            fobj.ERROR_INFO = new ERROR_INFO();

            fobj.ERROR_INFO.PROGRAM = e._SMA._PROGRAM;
            fobj.ERROR_INFO.LINE = e._SMA.ERRORLINE.ToString();
            fobj.ERROR_INFO.MESSAGE = e._SMA.MESSAGE;
            fobj.ERROR_INFO.ERROR = e._SMA.SYSTEMERROR.ToString();

            //LOAD WAGE_INFO 
            fobj.WAGE_INFO = new WAGE_INFO();
            fobj.WAGE_INFO.ACCOUNT_ID = e._EWAG.ACCOUNTID;
            fobj.WAGE_INFO.PERIOD = CopMvcUtil.ConvDate(e._EWAG.PERIODX);
            fobj.WAGE_INFO.VERSION = e._EWAG.VERSIONX;
            fobj.WAGE_INFO.SEQUENCE=e._EWAG.SEQUENCENUM;
            fobj.WAGE_INFO.RETURN_STATUS = e._EWAG.RETURNSTATUS;
            fobj.WAGE_INFO.LAST_UPD_DATE = CopMvcUtil.ConvDate(e._EWAG.LASTUPDATEDATEX);
            fobj.WAGE_INFO.DOCUMENT_CONTROL = e._EWAG.DOCUMENTCONTROLX;
            fobj.WAGE_INFO.ADJ_REFNO_CONTROL = e._EWAG.ADJREFNO;
            //fobj.WAGE_INFO.ENTITY_ID=e._EWA

            fobj.WAGE_INFO.NO_OF_NONRESIDENTS= CopMvcUtil.ConvDigitToInt(e._EWAG.NUMBEROFNONRESIDENTSX);
          
            fobj.WAGE_INFO.NO_OF_RESIDENTS = CopMvcUtil.ConvDigitToInt(e._EWAG.NUMBEROFRESIDENTSX);
            fobj.WAGE_INFO.PHILA_EMPLOYEES = CopMvcUtil.ConvDigitToInt(e._EWAG.PHILAEMPLOYEESX);
            fobj.WAGE_INFO.TOTAL_EMPLOYEES = CopMvcUtil.ConvDigitToInt(e._EWAG.TOTALEMPLOYEESX);

            fobj.WAGE_INFO.RESTAX_A = CopMvcUtil.ConvDigitToDouble9(e._EWAG.RESRATEA);
            fobj.WAGE_INFO.RESTAX_B = CopMvcUtil.ConvDigitToDouble9(e._EWAG.RESRATEB);
            fobj.WAGE_INFO.NONRESTAX_A = CopMvcUtil.ConvDigitToDouble9(e._EWAG.NONRATEA);
            fobj.WAGE_INFO.NONRESTAX_B = CopMvcUtil.ConvDigitToDouble9(e._EWAG.NONRATEB);
            fobj.WAGE_INFO.FREQUENCY = e._EWAG.FREQUENCY;

            fobj.WAGE_INFO.DUE_DATE =CopMvcUtil.ConvDate(e._EWAG.DUEDATE);
           
            fobj.WAGE_INFO.PREPARER_NAME = e._EWAG.PREPARERNAME;
            fobj.WAGE_INFO.PREPARER_PHONE = e._EWAG.PREPARERPHONE;
            fobj.WAGE_INFO.PREPARER_PHONE_EXT = e._EWAG.PREPARERPHONEEXT;
            fobj.WAGE_INFO.PREPARER_IP_ADDRESS = e._EWAG.PREPARERIPADDRESS;
            fobj.WAGE_INFO.PREPARER_EMAIL_ADDRESS = e._EWAG.PREPAREREMAILADDRESS;
            fobj.WAGE_INFO.PREPARER_WHO = e._EWAG.PREPARERTYPE;
            //   fobj.WAGE_INFO.PREPARER_WHO = e._ETOB.;

            //LOAD AMT_INFO 
            fobj.AMT_INFO = new AMT_INFO();
            fobj.AMT_INFO.GROSS_COMP = CopMvcUtil.ConvDigitToCurrency(e._EAMT.GROSSCOMPENSATIONX).ToString();
            fobj.AMT_INFO.NON_TAXABLE_COMP = CopMvcUtil.ConvDigitToCurrency(e._EAMT.NONTAXABLECOMPX).ToString();
            fobj.AMT_INFO.NET_COMP = CopMvcUtil.ConvDigitToCurrency(e._EAMT.NETCOMPENSATIONX).ToString();
            fobj.AMT_INFO.RESIDENT_PAYROLL_A = CopMvcUtil.ConvDigitToCurrency(e._EAMT.RESIDENTPAYROLLAX);
            fobj.AMT_INFO.RESIDENT_TAX_DUE_A = CopMvcUtil.ConvDigitToCurrency(e._EAMT.RESIDENTTAXDUEAX).ToString();
            fobj.AMT_INFO.RESIDENT_PAYROLL_B = CopMvcUtil.ConvDigitToCurrency(e._EAMT.RESIDENTPAYROLLBX).ToString();
            fobj.AMT_INFO.RESIDENT_TAX_DUE_B = CopMvcUtil.ConvDigitToCurrency(e._EAMT.RESIDENTTAXDUEBX).ToString();
            fobj.AMT_INFO.NON_RES_PAYROLL_A = CopMvcUtil.ConvDigitToCurrency(e._EAMT.NONRESPAYROLLAX);
            fobj.AMT_INFO.NON_RES_TAX_DUE_A = CopMvcUtil.ConvDigitToCurrency(e._EAMT.NONRESTAXDUEAX).ToString();
            fobj.AMT_INFO.NON_RES_PAYROLL_B = CopMvcUtil.ConvDigitToCurrency(e._EAMT.NONRESPAYROLLBX).ToString();
            fobj.AMT_INFO.NON_RES_TAX_DUE_B = CopMvcUtil.ConvDigitToCurrency(e._EAMT.NONRESTAXDUEBX).ToString();
            fobj.AMT_INFO.TOTAL_GROSS_TAX_DUE = CopMvcUtil.ConvDigitToCurrency(e._EAMT.TOTALGROSSTAXDUEX);
            fobj.AMT_INFO.TAX_PAID = CopMvcUtil.ConvDigitToCurrency(e._EAMT.TAXPAIDX);
            fobj.AMT_INFO.TAX_DUE = CopMvcUtil.ConvDigitToCurrency(e._EAMT.TAXDUEX);
            fobj.AMT_INFO.TAX_OVERPAID = CopMvcUtil.ConvDigitToCurrency(e._EAMT.TAXOVERPAIDX);
            fobj.AMT_INFO.POSTING_DATE = CopMvcUtil.ConvDate(e._EAMT.POSTINGDATEX);
             fobj.AMT_INFO.FILING_DATE = CopMvcUtil.ConvDate(e._EAMT.FILINGDATEX);
            fobj.AMT_INFO.USER_ID =e._EAMT.USERID;

            return fobj;

        }

        private static COPXmlFactory.RTTIE027.WAGERETURN __RTTIE027_F_U(COPXmlFactory.RTTIE027.WAGERETURN e)
        {

            RTTIE227_Srvref.RTTIE227 serv_req = new RTTIE227_Srvref.RTTIE227();

            serv_req._EWAG = new RTTIE227_Srvref._EWAG();
            serv_req._EWAG.ACCOUNTID = e.WAGE_INFO.ACCOUNT_ID;
            serv_req._EWAG.VERSIONX = e.WAGE_INFO.VERSION;
            serv_req._EWAG.PERIODX = CopMvcUtil.ConvDateDecimalString(e.WAGE_INFO.PERIOD);
            serv_req._EWAG.DOCUMENTCONTROLX = e.WAGE_INFO.DOCUMENT_CONTROL;
            serv_req._EWAG.ADJREFNO =e.WAGE_INFO.ADJ_REFNO_CONTROL;

         //   serv_req._EWAG.en = e.WAGE_INFO.ENTITY_ID;

            serv_req._EWAG.RETURNSTATUS = e.WAGE_INFO.RETURN_STATUS;
            serv_req._EWAG.SEQUENCENUM = e.WAGE_INFO.SEQUENCE;
            serv_req._EWAG.LASTUPDATEDATEX = CopMvcUtil.ConvDateDecimalString(e.WAGE_INFO.LAST_UPD_DATE);
            serv_req._EWAG.NUMBEROFRESIDENTSX = CopMvcUtil.ConvNumberToDigit7(e.WAGE_INFO.NO_OF_RESIDENTS);
        
            serv_req._EWAG.NUMBEROFNONRESIDENTSX = CopMvcUtil.ConvNumberToDigit7(e.WAGE_INFO.NO_OF_NONRESIDENTS);
            serv_req._EWAG.PHILAEMPLOYEESX = CopMvcUtil.ConvNumberToDigit7(e.WAGE_INFO.PHILA_EMPLOYEES);
            serv_req._EWAG.TOTALEMPLOYEESX = CopMvcUtil.ConvNumberToDigit7(e.WAGE_INFO.TOTAL_EMPLOYEES);
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


            serv_req._EAMT = new RTTIE227_Srvref._EAMT();
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



            RTTIE227_Srvref.RTTIE227Response response = _client.RTTIE227(serv_req);

            e = _Fill(response);

            return e;

        }
    }
}
