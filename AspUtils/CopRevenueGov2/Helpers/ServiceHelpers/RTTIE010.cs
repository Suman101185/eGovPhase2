using CopRevenueGov2.Service;
using COPXmlFactory;
using COPXmlFactory.RTTIE010;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml;

namespace CopRevenueGov2.Helpers
{
    public class RTTIE010 : CopRestServiceBase, ICopSoapService
    {

        //static RTTIE010_SrvRef.RTTIE010WS_PortTypeClient _client = null;
        static RTTIE210_SrvRef.RTTIE210WS_PortTypeClient _client = null;
        public static void Init()
        {
            _client = COPServiceURLHelper.GetServiceClient_RTTIE010();
            //_client = new RTTIE010_SrvRef.RTTIE010WS_PortTypeClient();
        }

        public static string CallService(string Request)
        {
            COPXmlFactory.RTTIE010.ACCTTEMPLATE xo;

            try
            {
                xo = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE010.ACCTTEMPLATE>(
                    Request);

                xo = __Call(xo);
            }
            catch (Exception ex)
            {
                xo =
                    RevenueGovXMLFactory.GetAcctTemplate();

                xo.ERROR_INFO = new ERROR_INFO();
                xo.ERROR_INFO.ERROR = 11.ToString();
                xo.ERROR_INFO.MESSAGE = ex.Message;
            }

            return RevenueGovXMLFactory.GetXmlString(xo);

        }

        public static XmlDocument CallService(XmlDocument Request)
        {
            COPXmlFactory.RTTIE010.ACCTTEMPLATE acct;

            try
            {
                string InnerXML = Request.InnerXml;
                acct = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE010.ACCTTEMPLATE>(
                    InnerXML);

                acct = __Call(acct);

            }
            catch (Exception ex)
            {
                acct =
                    RevenueGovXMLFactory.GetAcctTemplate();

                acct.ERROR_INFO = new ERROR_INFO();
                acct.ERROR_INFO.ERROR = 11.ToString();
                acct.ERROR_INFO.MESSAGE = ex.Message;
            }

            return RevenueGovXMLFactory.GetXmlDocument(acct);
        }

        private static COPXmlFactory.RTTIE010.ACCTTEMPLATE __Fill(RTTIE210_SrvRef.RTTIE210Response e)
        {
            COPXmlFactory.RTTIE010.ACCTTEMPLATE fobj = RevenueGovXMLFactory.GetAcctTemplate();

            //LOAD ERRORS INTO OBJECT
            fobj.ERROR_INFO = new ERROR_INFO();

            fobj.ERROR_INFO.PROGRAM = e._SMA._SYSTEMMESSAGEAREA._PROGRAM;
            fobj.ERROR_INFO.LINE = e._SMA._SYSTEMMESSAGEAREA.LINE.ToString();
            fobj.ERROR_INFO.MESSAGE = e._SMA._SYSTEMMESSAGEAREA.MESSAGE;
            fobj.ERROR_INFO.ERROR = e._SMA._SYSTEMMESSAGEAREA.ERROR.ToString();

            //LOAD ENTITY INFOS 
            fobj.ENTITY_INFO = new ENTITY_INFO();
            fobj.ENTITY_INFO.FUNCTION_CODE = e._EMI._ENTITYMASTERINFO.FUNCTIONCODE;
            fobj.ENTITY_INFO.TYPE = CopMvcUtil.GetString(e._EMI._ENTITYMASTERINFO.ENTITYTYPE);
            fobj.ENTITY_INFO.ENTITY_ID = e._EMI._ENTITYMASTERINFO.ENTITYID;
            fobj.ENTITY_INFO.ACCOUNT_ID = e._EMI._ENTITYMASTERINFO.ACCOUNTID;
            fobj.ENTITY_INFO.NAIC_CODE = CopMvcUtil.GetString(e._EMI._ENTITYMASTERINFO.NAICFEDERALCODE);
            fobj.ENTITY_INFO.SIC_CODE = CopMvcUtil.GetString(e._EMI._ENTITYMASTERINFO.SICFEDERALCODE);
            fobj.ENTITY_INFO.START_DATE = CopMvcUtil.ConvDate(e._EMI._ENTITYMASTERINFO.BUSINESSSTARTDATE);

            fobj.ENTITY_INFO.ORGTYPE = CopMvcUtil.GetString(e._EMI._ENTITYMASTERINFO.ORGANIZATIONTYPE);
            fobj.ENTITY_INFO.ORIGIN = CopMvcUtil.GetString(e._EMI._ENTITYMASTERINFO.BUSINESSORIGIN);
            fobj.ENTITY_INFO.GENDER = e._EMI._ENTITYMASTERINFO.BUSINESSGENDER;
            fobj.ENTITY_INFO.OTHER = e._EMI._ENTITYMASTERINFO.BUSINESSOTHER;
            fobj.ENTITY_INFO.PIN = CopMvcUtil.GetString(e._EMI._ENTITYMASTERINFO.PINNUMBER);
            fobj.ENTITY_INFO.FORCEPINCHG = CopMvcUtil.GetString(e._EMI._ENTITYMASTERINFO.PINSWITCH);
            // Unused : fobj.ENTITY_INFO.FORCEPINCHG = ???

            //LOAD NAME ADDRESS INFOS 
            //fobj.NAME_ADDRESS = new List<NAME_ADDRESS>(e._ENA1._NAMADDR1s.Length);
            fobj.NAME_ADDRESS = new List<NAME_ADDRESS>();


            for (int i = 0; i < e._ENA1._NAMADDR1s.Length; i++)
            {
                //ENA1 section
                fobj.NAME_ADDRESS.Add(RevenueGovXMLFactory.GetAcctTemplate_NAME_ADDRESS());
                fobj.NAME_ADDRESS[i].FUNCTION_CODE = e._ENA1._NAMADDR1s[i].FUNCTIONCODE;
                fobj.NAME_ADDRESS[i].TYPE = CopMvcUtil.GetString(e._ENA1._NAMADDR1s[i].ENTITYTYPE);
                fobj.NAME_ADDRESS[i].ID = e._ENA1._NAMADDR1s[i].ENTITYID;
                fobj.NAME_ADDRESS[i].NAME = e._ENA1._NAMADDR1s[i].ENTITYNAME;
                fobj.NAME_ADDRESS[i].TRADE_NAME = e._ENA1._NAMADDR1s[i].TRADENAME;
                fobj.NAME_ADDRESS[i].ADDRESS_TYPE = CopMvcUtil.GetString(e._ENA1._NAMADDR1s[i].ADDRESSTYPE);
                fobj.NAME_ADDRESS[i].RELATIONSHIP_CODE = CopMvcUtil.GetString(e._ENA1._NAMADDR1s[i].RELATIONSHIPCODE);

                //ENA2 section
                fobj.NAME_ADDRESS[i].ATTENTION = e._ENA2._NAMADDR2s[i].ATTENTION;
                fobj.NAME_ADDRESS[i].ADDRESS1 = CopMvcUtil.GetString(e._ENA2._NAMADDR2s[i].ADDRESSLINE1);
                fobj.NAME_ADDRESS[i].ADDRESS2 = e._ENA2._NAMADDR2s[i].ADDRESSLINE2;
                fobj.NAME_ADDRESS[i].CITY = e._ENA2._NAMADDR2s[i].CITY;
                fobj.NAME_ADDRESS[i].STATE = e._ENA2._NAMADDR2s[i].STATE;
                fobj.NAME_ADDRESS[i].ZIP = e._ENA2._NAMADDR2s[i].ZIPCODE;
                fobj.NAME_ADDRESS[i].WORK_PHONE = CopMvcUtil.GetString(e._ENA2._NAMADDR2s[i].BUSINESSPHONENUMBER);
                fobj.NAME_ADDRESS[i].WORK_PHONE_EXT = e._ENA2._NAMADDR2s[i].BUSINESSPHONEEXTENSION;
                fobj.NAME_ADDRESS[i].WORK_FAX = CopMvcUtil.GetString(e._ENA2._NAMADDR2s[i].BUSINESSFAX);
                fobj.NAME_ADDRESS[i].OTHER_PHONE = CopMvcUtil.GetString(e._ENA2._NAMADDR2s[i].OTHERPHONENUMBER);
                fobj.NAME_ADDRESS[i].EMAIL = e._ENA2._NAMADDR2s[i].EMAILADDR;
                fobj.NAME_ADDRESS[i].TRACE_NUMBER = CopMvcUtil.GetString(e._ENA2._NAMADDR2s[i].TIADRSEQUENCENUMBER);
            }

            //LOAD TAX ACCT s
            fobj.TAX_ACCT = new List<TAX_ACCT>();
            for (int i = 0; i < e._ETA._ENTITYTAXACCOUNTSs.Length; i++)
            {
                fobj.TAX_ACCT.Add(COPXmlFactory.RevenueGovXMLFactory.GetAcctTemplate_TaxAcct());
                fobj.TAX_ACCT[i].FUNCTION_CODE = e._ETA._ENTITYTAXACCOUNTSs[i].FUNCTIONCODE;
                fobj.TAX_ACCT[i].ACCOUNT = CopMvcUtil.GetString(e._ETA._ENTITYTAXACCOUNTSs[i].ACCOUNT);
                fobj.TAX_ACCT[i].START_DATE = CopMvcUtil.ConvDate(e._ETA._ENTITYTAXACCOUNTSs[i].STARTDATE);
                fobj.TAX_ACCT[i].WAGE_MONTHLY_GROSS = e._ETA._ENTITYTAXACCOUNTSs[i].WAGMONTHLYGROSS;
                fobj.TAX_ACCT[i].UOL_BRT = e._ETA._ENTITYTAXACCOUNTSs[i].BPTNEWAPPLICATION.BPTNASTATUS;
                fobj.TAX_ACCT[i].PRK_ID = e._ETA._ENTITYTAXACCOUNTSs[i].PRKID;
            }

            //LOAD Echecks AX ACCT s
            fobj.ECHECK = new ECHECK();
            fobj.ECHECK.FUNCTION_CODE = e._ECHK._ECHECK.FUNCTIONCODE;
            fobj.ECHECK.ROUTING_NUMBER = CopMvcUtil.GetString(e._ECHK._ECHECK.TRANSITROUTINGNUMBER);
            fobj.ECHECK.ACCOUNT_NUMBER = CopMvcUtil.GetString(e._ECHK._ECHECK.BANKACCOUNTNUMBER);
            fobj.ECHECK.ACCOUNT_TYPE = e._ECHK._ECHECK.BANKACCOUNTTYPE;

            return fobj;

        }

        private static ACCTTEMPLATE __Call(ACCTTEMPLATE e)
        {

            switch (e.ENTITY_INFO.FUNCTION_CODE)
            {
                case "I": // Login

                    // COmmented for testing the design page in bootstrap
                   // e = __RTTIE010_F_I(e);

                    e = __RTTIE010_F_I("D:/sanghamitra/Sanghamitra Acharya/CopPhase2/SourceCode/EGovCurrent23.5/Xml files/acctTemplate/Acct03Response.xml");
                    break;
                case "1": // Apply account
                    //e = __RTTIE010_F_1(e);
                    break;
                case "3": //Pin apply and Profile update
                    e = __RTTIE010_F_U(e);
                    break;
                case "A": //Registration
                    e = __RTTIE010_F_A(e);
                    break;
                default:
                    e = __RTTIE010_F_U(e);
                    break;
            }

            return e;
        }

        private static COPXmlFactory.RTTIE010.ACCTTEMPLATE __RTTIE010_F_I(COPXmlFactory.RTTIE010.ACCTTEMPLATE e)
        {
            RTTIE210_SrvRef.RTTIE210 serv_req = new RTTIE210_SrvRef.RTTIE210();

            serv_req._EMI = new RTTIE210_SrvRef._EMI();
            serv_req._EMI._ENTITYMASTERINFO = new RTTIE210_SrvRef._ENTITYMASTERINFO();
            serv_req._EMI._ENTITYMASTERINFO.ENTITYID = e.ENTITY_INFO.ENTITY_ID;
            serv_req._EMI._ENTITYMASTERINFO.FUNCTIONCODE = e.ENTITY_INFO.FUNCTION_CODE;

            serv_req._EMI._ENTITYMASTERINFO.PINNUMBERSpecified = CopMvcUtil.IsSpecified(e.ENTITY_INFO.PIN);
            serv_req._EMI._ENTITYMASTERINFO.PINNUMBER = CopMvcUtil.GetDecimal(e.ENTITY_INFO.PIN);

            RTTIE210_SrvRef.RTTIE210Response response = _client.RTTIE210(serv_req);

            e = __Fill(response);

            return e;

        }
        // Commented on 20 Nov2015 for testing the design pages in bootstrap
        //private static COPXmlFactory.RTTIE010.ACCTTEMPLATE __RTTIE010_F_1(COPXmlFactory.RTTIE010.ACCTTEMPLATE e)
        //{
        //    RTTIE210_SrvRef.RTTIE210 serv_req = new RTTIE210_SrvRef.RTTIE210();

        //    serv_req._EMI = new RTTIE210_SrvRef._EMI();
        //    serv_req._EMI._ENTITYMASTERINFO = new RTTIE210_SrvRef._ENTITYMASTERINFO();
        //    serv_req._EMI._ENTITYMASTERINFO.ENTITYID = e.ENTITY_INFO.ENTITY_ID;
        //    serv_req._EMI._ENTITYMASTERINFO.FUNCTIONCODE = e.ENTITY_INFO.FUNCTION_CODE;

        //    RTTIE210_SrvRef.RTTIE210Response response = _client.RTTIE210(serv_req);

        //    e = __Fill(response);

        //    return e;

        //}
        private static COPXmlFactory.RTTIE010.ACCTTEMPLATE __RTTIE010_F_I(string ReplyXMLPath)
        {
            //Read from XML file and return the object

            CopMvcUtil utl = new CopMvcUtil();

            string xmlstring = utl.GetXMLString(ReplyXMLPath);

            COPXmlFactory.RTTIE010.ACCTTEMPLATE acct;

            acct = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE010.ACCTTEMPLATE>(
                xmlstring);


            return acct;

        }
        private static COPXmlFactory.RTTIE010.ACCTTEMPLATE __RTTIE010_F_U(COPXmlFactory.RTTIE010.ACCTTEMPLATE e)
        {
            RTTIE210_SrvRef.RTTIE210 serv_req = new RTTIE210_SrvRef.RTTIE210();

            serv_req._EMI = new RTTIE210_SrvRef._EMI();
            serv_req._EMI._ENTITYMASTERINFO = new RTTIE210_SrvRef._ENTITYMASTERINFO();
            serv_req._EMI._ENTITYMASTERINFO.FUNCTIONCODE = e.ENTITY_INFO.FUNCTION_CODE;
            serv_req._EMI._ENTITYMASTERINFO.ENTITYID = e.ENTITY_INFO.ENTITY_ID;
            serv_req._EMI._ENTITYMASTERINFO.ACCOUNTID = CopMvcUtil.GetString(e.ENTITY_INFO.ACCOUNT_ID);

            serv_req._EMI._ENTITYMASTERINFO.ENTITYTYPESpecified = CopMvcUtil.IsSpecified(e.ENTITY_INFO.TYPE);
            serv_req._EMI._ENTITYMASTERINFO.ENTITYTYPE = CopMvcUtil.GetDecimal(e.ENTITY_INFO.TYPE);

            serv_req._EMI._ENTITYMASTERINFO.NAICFEDERALCODESpecified = CopMvcUtil.IsSpecified(e.ENTITY_INFO.NAIC_CODE);
            serv_req._EMI._ENTITYMASTERINFO.NAICFEDERALCODE = CopMvcUtil.GetDecimal(e.ENTITY_INFO.NAIC_CODE);

            serv_req._EMI._ENTITYMASTERINFO.SICFEDERALCODESpecified = CopMvcUtil.IsSpecified(e.ENTITY_INFO.SIC_CODE);
            serv_req._EMI._ENTITYMASTERINFO.SICFEDERALCODE = CopMvcUtil.GetDecimal(e.ENTITY_INFO.SIC_CODE);

            serv_req._EMI._ENTITYMASTERINFO.BUSINESSSTARTDATESpecified = CopMvcUtil.IsSpecified(e.ENTITY_INFO.START_DATE);
          serv_req._EMI._ENTITYMASTERINFO.BUSINESSSTARTDATE = CopMvcUtil.ConvDateDecimal(e.ENTITY_INFO.START_DATE);
           //serv_req._EMI._ENTITYMASTERINFO.BUSINESSSTARTDATE = CopMvcUtil.ConvDateDecimal("05/05/2010");

            

            serv_req._EMI._ENTITYMASTERINFO.ORGANIZATIONTYPESpecified = CopMvcUtil.IsSpecified(e.ENTITY_INFO.ORGTYPE);
            serv_req._EMI._ENTITYMASTERINFO.ORGANIZATIONTYPE = CopMvcUtil.GetDecimal(e.ENTITY_INFO.ORGTYPE);

            serv_req._EMI._ENTITYMASTERINFO.BUSINESSGENDER = CopMvcUtil.GetString(e.ENTITY_INFO.GENDER);
            serv_req._EMI._ENTITYMASTERINFO.BUSINESSOTHER = CopMvcUtil.GetString(e.ENTITY_INFO.OTHER);


            serv_req._EMI._ENTITYMASTERINFO.PINNUMBERSpecified = CopMvcUtil.IsSpecified(e.ENTITY_INFO.PIN);
            serv_req._EMI._ENTITYMASTERINFO.PINNUMBER = CopMvcUtil.GetDecimal(e.ENTITY_INFO.PIN);

            serv_req._EMI._ENTITYMASTERINFO.PINSWITCH = CopMvcUtil.GetString(e.ENTITY_INFO.FORCEPINCHG);

            //serv_req._EMI._ENTITYMASTERINFO.for


            //serv_req._ENA1 = new RTTIE010_SrvRef._ENA1();
            if (e.NAME_ADDRESS.Count > 0)
            {
                //e.NAME_ADDRESS.Count
                int r = 0;

                for (int s = 0; s < e.NAME_ADDRESS.Count; s++)
                {
                    if (e.NAME_ADDRESS[s].ID.Value != null)
                    {
                        r++;
                    }
                }

                if (r > 0)
                {
                    serv_req._ENA1 = new RTTIE210_SrvRef._ENA1();
                    serv_req._ENA1._NAMADDR1s = new RTTIE210_SrvRef._NAMADDR1[r];
                    serv_req._ENA2 = new RTTIE210_SrvRef._ENA2();
                    serv_req._ENA2._NAMADDR2s = new RTTIE210_SrvRef._NAMADDR2[r];
                }

                r = 0;
                for (int i = 0; i < e.NAME_ADDRESS.Count; i++)
                {
                    if (e.NAME_ADDRESS[i].ID.Value != null)
                    {
                        // ENA 1
                        serv_req._ENA1._NAMADDR1s[r] = new RTTIE210_SrvRef._NAMADDR1();


                        serv_req._ENA1._NAMADDR1s[r].FUNCTIONCODE = CopMvcUtil.GetString(e.NAME_ADDRESS[i].FUNCTION_CODE);
                        serv_req._ENA1._NAMADDR1s[r].ENTITYTYPESpecified = CopMvcUtil.IsSpecified(e.NAME_ADDRESS[i].TYPE);
                        serv_req._ENA1._NAMADDR1s[r].ENTITYTYPE = CopMvcUtil.GetDecimal(e.NAME_ADDRESS[i].TYPE);
                        serv_req._ENA1._NAMADDR1s[r].ENTITYID = CopMvcUtil.GetString(e.NAME_ADDRESS[i].ID);
                        serv_req._ENA1._NAMADDR1s[r].ENTITYNAME = CopMvcUtil.GetString(e.NAME_ADDRESS[i].NAME);
                        serv_req._ENA1._NAMADDR1s[r].TRADENAME = CopMvcUtil.GetString(e.NAME_ADDRESS[i].TRADE_NAME);

                        serv_req._ENA1._NAMADDR1s[r].ADDRESSTYPESpecified = CopMvcUtil.IsSpecified(e.NAME_ADDRESS[i].ADDRESS_TYPE);
                        serv_req._ENA1._NAMADDR1s[r].ADDRESSTYPE = CopMvcUtil.GetDecimal(e.NAME_ADDRESS[i].ADDRESS_TYPE);

                        serv_req._ENA1._NAMADDR1s[r].RELATIONSHIPCODESpecified = CopMvcUtil.IsSpecified(e.NAME_ADDRESS[i].RELATIONSHIP_CODE);
                        serv_req._ENA1._NAMADDR1s[r].RELATIONSHIPCODE = CopMvcUtil.GetDecimal(e.NAME_ADDRESS[i].RELATIONSHIP_CODE);


                        // ENA 2
                        serv_req._ENA2._NAMADDR2s[r] = new RTTIE210_SrvRef._NAMADDR2();

                        serv_req._ENA2._NAMADDR2s[r].ATTENTION = CopMvcUtil.GetString(e.NAME_ADDRESS[i].ATTENTION);
                        serv_req._ENA2._NAMADDR2s[r].ADDRESSLINE1 = CopMvcUtil.GetString(e.NAME_ADDRESS[i].ADDRESS1);
                        serv_req._ENA2._NAMADDR2s[r].ADDRESSLINE2 =  CopMvcUtil.GetString(e.NAME_ADDRESS[i].ADDRESS2);
                      
                        serv_req._ENA2._NAMADDR2s[r].CITY =  CopMvcUtil.GetString(e.NAME_ADDRESS[i].CITY);
                        serv_req._ENA2._NAMADDR2s[r].STATE =  CopMvcUtil.GetString(e.NAME_ADDRESS[i].STATE);
                        serv_req._ENA2._NAMADDR2s[r].ZIPCODE =  CopMvcUtil.GetString(e.NAME_ADDRESS[i].ZIP);

                        serv_req._ENA2._NAMADDR2s[r].BUSINESSPHONENUMBERSpecified = CopMvcUtil.IsSpecified(e.NAME_ADDRESS[i].WORK_PHONE);
                        serv_req._ENA2._NAMADDR2s[r].BUSINESSPHONENUMBER = CopMvcUtil.GetDecimal(e.NAME_ADDRESS[i].WORK_PHONE);

                        serv_req._ENA2._NAMADDR2s[r].BUSINESSPHONEEXTENSION = CopMvcUtil.GetString(e.NAME_ADDRESS[i].WORK_PHONE);

                        serv_req._ENA2._NAMADDR2s[r].BUSINESSFAXSpecified = CopMvcUtil.IsSpecified(e.NAME_ADDRESS[i].WORK_FAX);
                        serv_req._ENA2._NAMADDR2s[r].BUSINESSFAX = CopMvcUtil.GetDecimal(e.NAME_ADDRESS[i].WORK_FAX);

                        serv_req._ENA2._NAMADDR2s[r].OTHERPHONENUMBERSpecified = CopMvcUtil.IsSpecified(e.NAME_ADDRESS[i].OTHER_PHONE);
                        serv_req._ENA2._NAMADDR2s[r].OTHERPHONENUMBER = CopMvcUtil.GetDecimal(e.NAME_ADDRESS[i].OTHER_PHONE);

                        serv_req._ENA2._NAMADDR2s[r].EMAILADDR = CopMvcUtil.GetString(e.NAME_ADDRESS[i].EMAIL);

                        serv_req._ENA2._NAMADDR2s[r].TIADRSEQUENCENUMBERSpecified = CopMvcUtil.IsSpecified(e.NAME_ADDRESS[i].TRACE_NUMBER);
                        serv_req._ENA2._NAMADDR2s[r].TIADRSEQUENCENUMBER = CopMvcUtil.GetDecimal(e.NAME_ADDRESS[i].TRACE_NUMBER);

                        
                        
                        r++;
                    }
                }
            }

            //LOAD TAX ACCT s
            if (e.TAX_ACCT.Count > 0)
            {
                serv_req._ETA = new RTTIE210_SrvRef._ETA();
                serv_req._ETA._ENTITYTAXACCOUNTSs = new RTTIE210_SrvRef._ENTITYTAXACCOUNTS[e.TAX_ACCT.Count];

                for (int i = 0; i < e.TAX_ACCT.Count; i++)
                {
                    serv_req._ETA._ENTITYTAXACCOUNTSs[i] = new RTTIE210_SrvRef._ENTITYTAXACCOUNTS();

                    serv_req._ETA._ENTITYTAXACCOUNTSs[i].FUNCTIONCODE = CopMvcUtil.GetString(e.TAX_ACCT[i].FUNCTION_CODE);

                    serv_req._ETA._ENTITYTAXACCOUNTSs[i].ACCOUNTSpecified = CopMvcUtil.IsSpecified(e.TAX_ACCT[i].ACCOUNT);
                    serv_req._ETA._ENTITYTAXACCOUNTSs[i].ACCOUNT = CopMvcUtil.GetDecimal(e.TAX_ACCT[i].ACCOUNT);

                    serv_req._ETA._ENTITYTAXACCOUNTSs[i].STARTDATESpecified = CopMvcUtil.IsSpecified(e.TAX_ACCT[i].START_DATE);
                   serv_req._ETA._ENTITYTAXACCOUNTSs[i].STARTDATE = CopMvcUtil.ConvDateDecimal(e.TAX_ACCT[i].START_DATE);
                   // serv_req._ETA._ENTITYTAXACCOUNTSs[i].STARTDATE = CopMvcUtil.ConvDateDecimal("05/05/2010");

                    serv_req._ETA._ENTITYTAXACCOUNTSs[i].WAGMONTHLYGROSS = CopMvcUtil.GetString(e.TAX_ACCT[i].WAGE_MONTHLY_GROSS);

                    serv_req._ETA._ENTITYTAXACCOUNTSs[i].BPTNEWAPPLICATION = new RTTIE210_SrvRef.BPTNEWAPPLICATION();
                    serv_req._ETA._ENTITYTAXACCOUNTSs[i].BPTNEWAPPLICATION.BPTNASTATUS = CopMvcUtil.GetString(e.TAX_ACCT[i].UOL_BRT);
                    serv_req._ETA._ENTITYTAXACCOUNTSs[i].PRKID =CopMvcUtil.GetString(e.TAX_ACCT[i].PRK_ID);
                }
            }

            serv_req._ECHK = new RTTIE210_SrvRef._ECHK();
            serv_req._ECHK._ECHECK = new RTTIE210_SrvRef._ECHECK();

            serv_req._ECHK._ECHECK.FUNCTIONCODE = CopMvcUtil.GetString(e.ECHECK.FUNCTION_CODE);
            serv_req._ECHK._ECHECK.TRANSITROUTINGNUMBER = CopMvcUtil.GetString(e.ECHECK.ROUTING_NUMBER);
            serv_req._ECHK._ECHECK.BANKACCOUNTNUMBER = CopMvcUtil.GetString(e.ECHECK.ACCOUNT_NUMBER);
            serv_req._ECHK._ECHECK.BANKACCOUNTTYPE = CopMvcUtil.GetString(e.ECHECK.ACCOUNT_TYPE);
           

            RTTIE210_SrvRef.RTTIE210Response response = _client.RTTIE210(serv_req);

            e = __Fill(response);

            return e;

        }

        private static COPXmlFactory.RTTIE010.ACCTTEMPLATE __RTTIE010_F_A(COPXmlFactory.RTTIE010.ACCTTEMPLATE e)
        {
           e= __RTTIE010_F_U(e);
           return e;
        }

    }
}