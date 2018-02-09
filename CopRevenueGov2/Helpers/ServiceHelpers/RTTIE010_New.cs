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
    public class RTTIE010_New : CopRestServiceBase, ICopSoapService
    {

        public static void Init()
        {

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


        private static COPXmlFactory.RTTIE010.ACCTTEMPLATE __Fill(RTTIE010_SrvRef.RTTIE010Response_SMA _SMA, RTTIE010_SrvRef.RTTIE010Response_EMI _EMI, RTTIE010_SrvRef.RTTIE010Response_ENA1 _ENA1, RTTIE010_SrvRef.RTTIE010Response_ENA2 _ENA2, RTTIE010_SrvRef.RTTIE010Response_ETA _ETA, RTTIE010_SrvRef.RTTIE010Response_ECHK _ECHK)
        {


            COPXmlFactory.RTTIE010.ACCTTEMPLATE fobj = RevenueGovXMLFactory.GetAcctTemplate();

            //LOAD ERRORS INTO OBJECT
            fobj.ERROR_INFO = new ERROR_INFO();
            if (_SMA._SYSTEMMESSAGEAREA != null)
            {
                fobj.ERROR_INFO.PROGRAM = _SMA._SYSTEMMESSAGEAREA._PROGRAM;
                fobj.ERROR_INFO.LINE = _SMA._SYSTEMMESSAGEAREA.LINE.ToString();
                fobj.ERROR_INFO.MESSAGE = _SMA._SYSTEMMESSAGEAREA.MESSAGE;
                fobj.ERROR_INFO.ERROR = _SMA._SYSTEMMESSAGEAREA.ERROR.ToString();
            }



            //LOAD ENTITY INFOS 
            fobj.ENTITY_INFO = new ENTITY_INFO();
            fobj.ENTITY_INFO.FUNCTION_CODE = _EMI._ENTITYMASTERINFO.FUNCTIONCODE;
            fobj.ENTITY_INFO.TYPE = CopMvcUtil.GetString(_EMI._ENTITYMASTERINFO.ENTITYTYPE);
            fobj.ENTITY_INFO.ENTITY_ID = _EMI._ENTITYMASTERINFO.ENTITYID;
            fobj.ENTITY_INFO.ACCOUNT_ID = _EMI._ENTITYMASTERINFO.ACCOUNTID;
            fobj.ENTITY_INFO.NAIC_CODE = CopMvcUtil.GetString(_EMI._ENTITYMASTERINFO.NAICFEDERALCODE);
            fobj.ENTITY_INFO.SIC_CODE = CopMvcUtil.GetString(_EMI._ENTITYMASTERINFO.SICFEDERALCODE);
            fobj.ENTITY_INFO.START_DATE = CopMvcUtil.ConvDate(_EMI._ENTITYMASTERINFO.BUSINESSSTARTDATE);




            fobj.ENTITY_INFO.ORGTYPE = CopMvcUtil.GetString(_EMI._ENTITYMASTERINFO.ORGANIZATIONTYPE);
            fobj.ENTITY_INFO.ORIGIN = CopMvcUtil.GetString(_EMI._ENTITYMASTERINFO.BUSINESSORIGIN);
            fobj.ENTITY_INFO.GENDER = _EMI._ENTITYMASTERINFO.BUSINESSGENDER;
            fobj.ENTITY_INFO.OTHER = _EMI._ENTITYMASTERINFO.BUSINESSOTHER;
            fobj.ENTITY_INFO.PIN = CopMvcUtil.GetString(_EMI._ENTITYMASTERINFO.PINNUMBER);
            fobj.ENTITY_INFO.FORCEPINCHG = CopMvcUtil.GetString(_EMI._ENTITYMASTERINFO.PINSWITCH);




            fobj.NAME_ADDRESS = new List<NAME_ADDRESS>();

            if (_ENA1._NAMADDR1s != null)
            {

                for (int i = 0; i < _ENA1._NAMADDR1s.Length; i++)
                {
                    //ENA1 section
                    fobj.NAME_ADDRESS.Add(RevenueGovXMLFactory.GetAcctTemplate_NAME_ADDRESS());
                    fobj.NAME_ADDRESS[i].FUNCTION_CODE = _ENA1._NAMADDR1s[i].FUNCTIONCODE;
                    fobj.NAME_ADDRESS[i].TYPE = CopMvcUtil.GetString(_ENA1._NAMADDR1s[i].ENTITYTYPE);
                    fobj.NAME_ADDRESS[i].ID = _ENA1._NAMADDR1s[i].ENTITYID;
                    fobj.NAME_ADDRESS[i].NAME = _ENA1._NAMADDR1s[i].ENTITYNAME;
                    fobj.NAME_ADDRESS[i].TRADE_NAME = _ENA1._NAMADDR1s[i].TRADENAME;
                    fobj.NAME_ADDRESS[i].ADDRESS_TYPE = CopMvcUtil.GetString(_ENA1._NAMADDR1s[i].ADDRESSTYPE);
                    fobj.NAME_ADDRESS[i].RELATIONSHIP_CODE = CopMvcUtil.GetString(_ENA1._NAMADDR1s[i].RELATIONSHIPCODE);



                    if (_ENA2._NAMADDR2s != null)
                    {
                        //ENA2 section
                        if (_ENA2._NAMADDR2s[i].ATTENTION != null)
                            fobj.NAME_ADDRESS[i].ATTENTION = _ENA2._NAMADDR2s[i].ATTENTION;
                        if (_ENA2._NAMADDR2s[i].ADDRESSLINE1 != null)
                            fobj.NAME_ADDRESS[i].ADDRESS1 = CopMvcUtil.GetString(_ENA2._NAMADDR2s[i].ADDRESSLINE1);
                        if (_ENA2._NAMADDR2s[i].ADDRESSLINE2 != null)
                            fobj.NAME_ADDRESS[i].ADDRESS2 = _ENA2._NAMADDR2s[i].ADDRESSLINE2;
                        if (_ENA2._NAMADDR2s[i].CITY != null)
                            fobj.NAME_ADDRESS[i].CITY = _ENA2._NAMADDR2s[i].CITY;
                        if (_ENA2._NAMADDR2s[i].STATE != null)
                            fobj.NAME_ADDRESS[i].STATE = _ENA2._NAMADDR2s[i].STATE;
                        if (_ENA2._NAMADDR2s[i].ZIPCODE != null)
                            fobj.NAME_ADDRESS[i].ZIP = _ENA2._NAMADDR2s[i].ZIPCODE;
                        if (_ENA2._NAMADDR2s[i].BUSINESSPHONENUMBER != null)
                            fobj.NAME_ADDRESS[i].WORK_PHONE = CopMvcUtil.GetString(_ENA2._NAMADDR2s[i].BUSINESSPHONENUMBER);
                        if (_ENA2._NAMADDR2s[i].BUSINESSPHONEEXTENSION != null)
                            fobj.NAME_ADDRESS[i].WORK_PHONE_EXT = _ENA2._NAMADDR2s[i].BUSINESSPHONEEXTENSION;
                        if (_ENA2._NAMADDR2s[i].BUSINESSFAX != null)
                            fobj.NAME_ADDRESS[i].WORK_FAX = CopMvcUtil.GetString(_ENA2._NAMADDR2s[i].BUSINESSFAX);
                        if (_ENA2._NAMADDR2s[i].OTHERPHONENUMBER != null)
                            fobj.NAME_ADDRESS[i].OTHER_PHONE = CopMvcUtil.GetString(_ENA2._NAMADDR2s[i].OTHERPHONENUMBER);
                        if (_ENA2._NAMADDR2s[i].EMAILADDR != null)
                            fobj.NAME_ADDRESS[i].EMAIL = _ENA2._NAMADDR2s[i].EMAILADDR;
                        if (_ENA2._NAMADDR2s[i].TIADRSEQUENCENUMBER != null)
                            fobj.NAME_ADDRESS[i].TRACE_NUMBER = CopMvcUtil.GetString(_ENA2._NAMADDR2s[i].TIADRSEQUENCENUMBER);
                    }

                }

            }

            //LOAD TAX ACCT s
            fobj.TAX_ACCT = new List<TAX_ACCT>();
            string Value = "";
            if (_ETA._ENTITYTAXACCOUNTSs != null)
            {

                for (int i = 0; i < _ETA._ENTITYTAXACCOUNTSs.Length; i++)
                {

                    fobj.TAX_ACCT.Add(COPXmlFactory.RevenueGovXMLFactory.GetAcctTemplate_TaxAcct());
                    if(_ETA._ENTITYTAXACCOUNTSs[i].FUNCTIONCODE!=null)
                    fobj.TAX_ACCT[i].FUNCTION_CODE = _ETA._ENTITYTAXACCOUNTSs[i].FUNCTIONCODE;
                    if(_ETA._ENTITYTAXACCOUNTSs[i].ACCOUNT!=null)
                    fobj.TAX_ACCT[i].ACCOUNT = CopMvcUtil.GetString(_ETA._ENTITYTAXACCOUNTSs[i].ACCOUNT);
                    if(_ETA._ENTITYTAXACCOUNTSs[i].STARTDATE!=null)
                    fobj.TAX_ACCT[i].START_DATE = CopMvcUtil.ConvDate(_ETA._ENTITYTAXACCOUNTSs[i].STARTDATE);
                    if(_ETA._ENTITYTAXACCOUNTSs[i].WAGMONTHLYGROSS!=null)
                    fobj.TAX_ACCT[i].WAGE_MONTHLY_GROSS = _ETA._ENTITYTAXACCOUNTSs[i].WAGMONTHLYGROSS;
                    if(_ETA._ENTITYTAXACCOUNTSs[i].BPTNEWAPPLICATION!=null)
                        if (_ETA._ENTITYTAXACCOUNTSs[i].BPTNEWAPPLICATION.BPTNAAPPLYFOREXEMPTION == "Y")
                        {
                            Value =_ETA._ENTITYTAXACCOUNTSs[i].BPTNEWAPPLICATION.BPTNAAPPLYFOREXEMPTION;
                            Value = Value + _ETA._ENTITYTAXACCOUNTSs[i].BPTNEWAPPLICATION.BPTNAREACTIVATING;
                            Value = Value + _ETA._ENTITYTAXACCOUNTSs[i].BPTNEWAPPLICATION.BPTNAAFFILIATED;
                            Value = Value + _ETA._ENTITYTAXACCOUNTSs[i].BPTNEWAPPLICATION.BPTNANEWOWNER;
                            Value = Value + _ETA._ENTITYTAXACCOUNTSs[i].BPTNEWAPPLICATION.BPTNAREALESTATE;
                            Value = Value + _ETA._ENTITYTAXACCOUNTSs[i].BPTNEWAPPLICATION.BPTNACOMPLYYEAR1;
                            Value = Value + _ETA._ENTITYTAXACCOUNTSs[i].BPTNEWAPPLICATION.BPTNACOMPLYYEAR2;
                            Value = Value + _ETA._ENTITYTAXACCOUNTSs[i].BPTNEWAPPLICATION.BPTNAACCEPTED;
                            fobj.TAX_ACCT[i].UOL_BRT = Value;

                        }                        
                        else    
                    fobj.TAX_ACCT[i].UOL_BRT = _ETA._ENTITYTAXACCOUNTSs[i].BPTNEWAPPLICATION.BPTNASTATUS;
                    if(_ETA._ENTITYTAXACCOUNTSs[i].PRKID!=null)
                    fobj.TAX_ACCT[i].PRK_ID = _ETA._ENTITYTAXACCOUNTSs[i].PRKID;


                }
            }

            //LOAD Echecks AX ACCT s
            fobj.ECHECK = new ECHECK();
            if (fobj.ECHECK.ACCOUNT_NUMBER != null)
                fobj.ECHECK.ACCOUNT_NUMBER = CopMvcUtil.GetString(_ECHK._ECHECK.BANKACCOUNTNUMBER);
            if (fobj.ECHECK.FUNCTION_CODE != null)
                fobj.ECHECK.FUNCTION_CODE = _ECHK._ECHECK.FUNCTIONCODE;
            if (fobj.ECHECK.ROUTING_NUMBER != null)
                fobj.ECHECK.ROUTING_NUMBER = CopMvcUtil.GetString(_ECHK._ECHECK.TRANSITROUTINGNUMBER);
            if (fobj.ECHECK.ACCOUNT_TYPE != null)
                fobj.ECHECK.ACCOUNT_TYPE = _ECHK._ECHECK.BANKACCOUNTTYPE;



            return fobj;

        }

        private static ACCTTEMPLATE __Call(ACCTTEMPLATE e)
        {

            switch (e.ENTITY_INFO.FUNCTION_CODE)
            {
                case "I": // Login

                    e = __RTTIE010_F_I(e);

                    break;
                case "1": // Apply account
                    e = __RTTIE010_F_1(e);
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
        //Commented on 20 Nov2015 for testing the design pages in bootstrap
        private static COPXmlFactory.RTTIE010.ACCTTEMPLATE __RTTIE010_F_1(COPXmlFactory.RTTIE010.ACCTTEMPLATE e)
        {
            RTTIE010_SrvRef.RTTIE010_EMI _EMI = new RTTIE010_SrvRef.RTTIE010_EMI();
            RTTIE010_SrvRef.RTTIE010 rttie010 = new RTTIE010_SrvRef.RTTIE010();
            RTTIE010_SrvRef.RTTIE010Response_SMA _SMAResponse = new RTTIE010_SrvRef.RTTIE010Response_SMA();
            RTTIE010_SrvRef.RTTIE010Response_EMI _EMIResponse = new RTTIE010_SrvRef.RTTIE010Response_EMI();
            RTTIE010_SrvRef.RTTIE010Response_ETA _ETAResponse = new RTTIE010_SrvRef.RTTIE010Response_ETA();
            RTTIE010_SrvRef.RTTIE010Response_ECHK _ECHKResponse = new RTTIE010_SrvRef.RTTIE010Response_ECHK();
            RTTIE010_SrvRef.RTTIE010Response_ENA1 _ENA1Response = new RTTIE010_SrvRef.RTTIE010Response_ENA1();
            RTTIE010_SrvRef.RTTIE010Response_ENA2 _ENA2Response = new RTTIE010_SrvRef.RTTIE010Response_ENA2();

            _EMI._ENTITYMASTERINFO = new RTTIE010_SrvRef.RTTIE010_EMI_ENTITYMASTERINFO();
            _EMI._ENTITYMASTERINFO.ENTITYID = e.ENTITY_INFO.ENTITY_ID;
            _EMI._ENTITYMASTERINFO.ENTITYTYPE = CopMvcUtil.ConvToDecimal(e.ENTITY_INFO.TYPE);
            _EMI._ENTITYMASTERINFO.FUNCTIONCODE = e.ENTITY_INFO.FUNCTION_CODE;
            _EMI._ENTITYMASTERINFO.ORGANIZATIONTYPESpecified = true;
            
            _SMAResponse = rttie010.CallRTTIE010 // calling the  service for Account aply...
                                            (_EMI, new RTTIE010_SrvRef.RTTIE010_ETA(),
                                              new RTTIE010_SrvRef.RTTIE010_ECHK(),
                                              new RTTIE010_SrvRef.RTTIE010_ENA1(),
                                              new RTTIE010_SrvRef.RTTIE010_ENA2(),
                                              out _EMIResponse,
                                              out _ETAResponse,
                                              out _ECHKResponse,
                                              out _ENA1Response,
                                              out _ENA2Response
                                            );



            //Assigning the reponse to the tempalte...            

            e = __Fill(_SMAResponse, _EMIResponse, _ENA1Response, _ENA2Response, _ETAResponse, _ECHKResponse);

            return e;

        }
        private static COPXmlFactory.RTTIE010.ACCTTEMPLATE __RTTIE010_F_I(COPXmlFactory.RTTIE010.ACCTTEMPLATE e)
        {



            RTTIE010_SrvRef.RTTIE010_EMI _EMI = new RTTIE010_SrvRef.RTTIE010_EMI();
            RTTIE010_SrvRef.RTTIE010 rttie010 = new RTTIE010_SrvRef.RTTIE010();
            RTTIE010_SrvRef.RTTIE010Response_SMA _SMAResponse = new RTTIE010_SrvRef.RTTIE010Response_SMA();
            RTTIE010_SrvRef.RTTIE010Response_EMI _EMIResponse = new RTTIE010_SrvRef.RTTIE010Response_EMI();
            RTTIE010_SrvRef.RTTIE010Response_ETA _ETAResponse = new RTTIE010_SrvRef.RTTIE010Response_ETA();
            RTTIE010_SrvRef.RTTIE010Response_ECHK _ECHKResponse = new RTTIE010_SrvRef.RTTIE010Response_ECHK();
            RTTIE010_SrvRef.RTTIE010Response_ENA1 _ENA1Response = new RTTIE010_SrvRef.RTTIE010Response_ENA1();
            RTTIE010_SrvRef.RTTIE010Response_ENA2 _ENA2Response = new RTTIE010_SrvRef.RTTIE010Response_ENA2();

            _EMI._ENTITYMASTERINFO = new RTTIE010_SrvRef.RTTIE010_EMI_ENTITYMASTERINFO();
            _EMI._ENTITYMASTERINFO.ENTITYID = e.ENTITY_INFO.ENTITY_ID;
            _EMI._ENTITYMASTERINFO.FUNCTIONCODE = e.ENTITY_INFO.FUNCTION_CODE;
            _EMI._ENTITYMASTERINFO.PINNUMBER = CopMvcUtil.GetDecimal(e.ENTITY_INFO.PIN);
            _EMI._ENTITYMASTERINFO.ORGANIZATIONTYPESpecified = true;
            _EMI._ENTITYMASTERINFO.PINNUMBERSpecified = true;

            string emi = CopMvcUtil.GetXMlFromObject(_EMI);


            _SMAResponse = rttie010.CallRTTIE010 // calling the  service for Login...
                                 (_EMI, new RTTIE010_SrvRef.RTTIE010_ETA(),
                                   new RTTIE010_SrvRef.RTTIE010_ECHK(),
                                   new RTTIE010_SrvRef.RTTIE010_ENA1(),
                                   new RTTIE010_SrvRef.RTTIE010_ENA2(),
                                   out _EMIResponse,
                                   out _ETAResponse,
                                   out _ECHKResponse,
                                   out _ENA1Response,
                                   out _ENA2Response
                                 );

            //Assigning the reponse to the tempalte...            

            e = __Fill(_SMAResponse, _EMIResponse, _ENA1Response, _ENA2Response, _ETAResponse, _ECHKResponse);

            return e;

        }

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




            RTTIE010_SrvRef.RTTIE010_EMI _EMI = new RTTIE010_SrvRef.RTTIE010_EMI();
            RTTIE010_SrvRef.RTTIE010_ENA1 _ENA1 = new RTTIE010_SrvRef.RTTIE010_ENA1();
            RTTIE010_SrvRef.RTTIE010_ENA2 _ENA2 = new RTTIE010_SrvRef.RTTIE010_ENA2();
            RTTIE010_SrvRef.RTTIE010_ETA _ETA = new RTTIE010_SrvRef.RTTIE010_ETA();
            RTTIE010_SrvRef.RTTIE010_ECHK _ECHK = new RTTIE010_SrvRef.RTTIE010_ECHK();
            RTTIE010_SrvRef.RTTIE010 rttie010 = new RTTIE010_SrvRef.RTTIE010();

            RTTIE010_SrvRef.RTTIE010Response_SMA _SMAResponse = new RTTIE010_SrvRef.RTTIE010Response_SMA();
            RTTIE010_SrvRef.RTTIE010Response_EMI _EMIResponse = new RTTIE010_SrvRef.RTTIE010Response_EMI();
            RTTIE010_SrvRef.RTTIE010Response_ETA _ETAResponse = new RTTIE010_SrvRef.RTTIE010Response_ETA();
            RTTIE010_SrvRef.RTTIE010Response_ECHK _ECHKResponse = new RTTIE010_SrvRef.RTTIE010Response_ECHK();
            RTTIE010_SrvRef.RTTIE010Response_ENA1 _ENA1Response = new RTTIE010_SrvRef.RTTIE010Response_ENA1();
            RTTIE010_SrvRef.RTTIE010Response_ENA2 _ENA2Response = new RTTIE010_SrvRef.RTTIE010Response_ENA2();

            _EMI._ENTITYMASTERINFO = new RTTIE010_SrvRef.RTTIE010_EMI_ENTITYMASTERINFO();
            _EMI._ENTITYMASTERINFO.ENTITYID = e.ENTITY_INFO.ENTITY_ID;
            _EMI._ENTITYMASTERINFO.FUNCTIONCODE = e.ENTITY_INFO.FUNCTION_CODE;
            _EMI._ENTITYMASTERINFO.ACCOUNTID = e.ENTITY_INFO.ACCOUNT_ID;
            _EMI._ENTITYMASTERINFO.PINNUMBER = CopMvcUtil.GetDecimal(e.ENTITY_INFO.PIN);
            _EMI._ENTITYMASTERINFO.ENTITYTYPE = CopMvcUtil.GetDecimal(e.ENTITY_INFO.TYPE);
            _EMI._ENTITYMASTERINFO.NAICFEDERALCODE = CopMvcUtil.GetDecimal(e.ENTITY_INFO.NAIC_CODE);
            _EMI._ENTITYMASTERINFO.SICFEDERALCODE = CopMvcUtil.GetDecimal(e.ENTITY_INFO.SIC_CODE);
            _EMI._ENTITYMASTERINFO.BUSINESSSTARTDATE = CopMvcUtil.ConvDateToDecimal(e.ENTITY_INFO.START_DATE);// changed method
            _EMI._ENTITYMASTERINFO.ORGANIZATIONTYPE = CopMvcUtil.GetDecimal(e.ENTITY_INFO.ORGTYPE);

            //Error fixed by SumanG-----Error code no-15
            _EMI._ENTITYMASTERINFO.BUSINESSORIGIN = CopMvcUtil.GetDecimal(e.ENTITY_INFO.ORIGIN);
            //Code End


            _EMI._ENTITYMASTERINFO.BUSINESSGENDER = CopMvcUtil.GetString(e.ENTITY_INFO.GENDER);
            _EMI._ENTITYMASTERINFO.BUSINESSOTHER = CopMvcUtil.GetString(e.ENTITY_INFO.OTHER);
            _EMI._ENTITYMASTERINFO.PINSWITCH = CopMvcUtil.GetString(e.ENTITY_INFO.FORCEPINCHG);

            _EMI._ENTITYMASTERINFO.PINNUMBERSpecified = true;          
            
            _EMI._ENTITYMASTERINFO.NAICFEDERALCODESpecified = true;
            _EMI._ENTITYMASTERINFO.SICFEDERALCODESpecified = true;
            _EMI._ENTITYMASTERINFO.BUSINESSSTARTDATESpecified = true;
            _EMI._ENTITYMASTERINFO.ORGANIZATIONTYPESpecified = true;
            _EMI._ENTITYMASTERINFO.BUSINESSORIGINSpecified = true;
            _EMI._ENTITYMASTERINFO.ENTITYTYPESpecified = true;
            
            
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

                    _ENA1._NAMADDR1s = new RTTIE010_SrvRef.RTTIE010_ENA1_NAMADDR1[r];
                    _ENA2._NAMADDR2s = new RTTIE010_SrvRef.RTTIE010_ENA2_NAMADDR2[r];
                }

                r = 0;
                for (int i = 0; i < e.NAME_ADDRESS.Count; i++)
                {
                    if (e.NAME_ADDRESS[i].ID.Value != null)
                    {
                        // ENA 1


                        _ENA1._NAMADDR1s[r] = new RTTIE010_SrvRef.RTTIE010_ENA1_NAMADDR1();
                        _ENA1._NAMADDR1s[r].FUNCTIONCODE = CopMvcUtil.GetString(e.NAME_ADDRESS[i].FUNCTION_CODE);
                        _ENA1._NAMADDR1s[r].ENTITYTYPE = CopMvcUtil.GetDecimal(e.NAME_ADDRESS[i].TYPE);
                        _ENA1._NAMADDR1s[r].ENTITYID = CopMvcUtil.GetString(e.NAME_ADDRESS[i].ID);
                        _ENA1._NAMADDR1s[r].ENTITYNAME = CopMvcUtil.GetString(e.NAME_ADDRESS[i].NAME);
                        _ENA1._NAMADDR1s[r].TRADENAME = CopMvcUtil.GetString(e.NAME_ADDRESS[i].TRADE_NAME);
                        _ENA1._NAMADDR1s[r].ADDRESSTYPE = CopMvcUtil.GetDecimal(e.NAME_ADDRESS[i].ADDRESS_TYPE);
                        _ENA1._NAMADDR1s[r].RELATIONSHIPCODE = CopMvcUtil.GetDecimal(e.NAME_ADDRESS[i].RELATIONSHIP_CODE);
                        _ENA1._NAMADDR1s[r].ADDRESSTYPESpecified = true;
                        _ENA1._NAMADDR1s[r].ENTITYTYPESpecified = true;
                        _ENA1._NAMADDR1s[r].RELATIONSHIPCODESpecified = true;
                        

                        // ENA 2

                        _ENA2._NAMADDR2s[r] = new RTTIE010_SrvRef.RTTIE010_ENA2_NAMADDR2();
                        _ENA2._NAMADDR2s[r].ATTENTION = CopMvcUtil.GetString(e.NAME_ADDRESS[i].ATTENTION);
                        _ENA2._NAMADDR2s[r].ADDRESSLINE1 = CopMvcUtil.GetString(e.NAME_ADDRESS[i].ADDRESS1);
                        _ENA2._NAMADDR2s[r].ADDRESSLINE2 = CopMvcUtil.GetString(e.NAME_ADDRESS[i].ADDRESS2);

                        _ENA2._NAMADDR2s[r].CITY = CopMvcUtil.GetString(e.NAME_ADDRESS[i].CITY);
                        _ENA2._NAMADDR2s[r].STATE = CopMvcUtil.GetString(e.NAME_ADDRESS[i].STATE);
                        _ENA2._NAMADDR2s[r].ZIPCODE = CopMvcUtil.GetString(e.NAME_ADDRESS[i].ZIP);

                        _ENA2._NAMADDR2s[r].BUSINESSPHONENUMBER = CopMvcUtil.GetDecimal(e.NAME_ADDRESS[i].WORK_PHONE);

                        _ENA2._NAMADDR2s[r].BUSINESSPHONEEXTENSION = CopMvcUtil.GetString(e.NAME_ADDRESS[i].WORK_PHONE_EXT);

                        _ENA2._NAMADDR2s[r].BUSINESSFAX = CopMvcUtil.GetDecimal(e.NAME_ADDRESS[i].WORK_FAX);

                        _ENA2._NAMADDR2s[r].OTHERPHONENUMBER = CopMvcUtil.GetDecimal(e.NAME_ADDRESS[i].OTHER_PHONE);

                        _ENA2._NAMADDR2s[r].EMAILADDR = CopMvcUtil.GetString(e.NAME_ADDRESS[i].EMAIL);

                        _ENA2._NAMADDR2s[r].TIADRSEQUENCENUMBER = CopMvcUtil.GetDecimal(e.NAME_ADDRESS[i].TRACE_NUMBER);                       
                       
                        _ENA2._NAMADDR2s[r].BUSINESSPHONENUMBERSpecified = true;
                        _ENA2._NAMADDR2s[r].OTHERPHONENUMBERSpecified = true;
                       


                        r++;
                    }
                }
            }

            //LOAD TAX ACCT s
            if (e.TAX_ACCT.Count > 0)
            {

                _ETA._ENTITYTAXACCOUNTSs = new RTTIE010_SrvRef.RTTIE010_ETA_ENTITYTAXACCOUNTS[e.TAX_ACCT.Count];

                for (int i = 0; i < e.TAX_ACCT.Count; i++)
                {
                    _ETA._ENTITYTAXACCOUNTSs[i] = new RTTIE010_SrvRef.RTTIE010_ETA_ENTITYTAXACCOUNTS();

                    _ETA._ENTITYTAXACCOUNTSs[i].FUNCTIONCODE = CopMvcUtil.GetString(e.TAX_ACCT[i].FUNCTION_CODE);


                    _ETA._ENTITYTAXACCOUNTSs[i].ACCOUNT = CopMvcUtil.GetDecimal(e.TAX_ACCT[i].ACCOUNT);

                    _ETA._ENTITYTAXACCOUNTSs[i].STARTDATE = CopMvcUtil.ConvDateToDecimal(e.TAX_ACCT[i].START_DATE); //change the method                   

                    _ETA._ENTITYTAXACCOUNTSs[i].WAGMONTHLYGROSS = CopMvcUtil.GetString(e.TAX_ACCT[i].WAGE_MONTHLY_GROSS);

                    _ETA._ENTITYTAXACCOUNTSs[i].BPTNEWAPPLICATION = new RTTIE010_SrvRef.RTTIE010_ETA_ENTITYTAXACCOUNTSBPTNEWAPPLICATION();


                    if (e.TAX_ACCT[i].UOL_BRT != null )
                    {
                        if (e.TAX_ACCT[i].UOL_BRT.Value != null)
                        {
                            if (e.TAX_ACCT[i].UOL_BRT.ToString().Substring(0, 1) == "Y")
                            {
                                _ETA._ENTITYTAXACCOUNTSs[i].BPTNEWAPPLICATION.BPTNAAPPLYFOREXEMPTION = e.TAX_ACCT[i].UOL_BRT.ToString().Substring(0, 1);
                                _ETA._ENTITYTAXACCOUNTSs[i].BPTNEWAPPLICATION.BPTNAREACTIVATING = e.TAX_ACCT[i].UOL_BRT.ToString().Substring(1, 1);
                                _ETA._ENTITYTAXACCOUNTSs[i].BPTNEWAPPLICATION.BPTNAAFFILIATED = e.TAX_ACCT[i].UOL_BRT.ToString().Substring(2, 1);
                                _ETA._ENTITYTAXACCOUNTSs[i].BPTNEWAPPLICATION.BPTNANEWOWNER = e.TAX_ACCT[i].UOL_BRT.ToString().Substring(3, 1);
                                _ETA._ENTITYTAXACCOUNTSs[i].BPTNEWAPPLICATION.BPTNAREALESTATE = e.TAX_ACCT[i].UOL_BRT.ToString().Substring(4, 1);
                                _ETA._ENTITYTAXACCOUNTSs[i].BPTNEWAPPLICATION.BPTNACOMPLYYEAR1 = e.TAX_ACCT[i].UOL_BRT.ToString().Substring(5, 1);
                                _ETA._ENTITYTAXACCOUNTSs[i].BPTNEWAPPLICATION.BPTNACOMPLYYEAR2 = e.TAX_ACCT[i].UOL_BRT.ToString().Substring(6, 1);
                                _ETA._ENTITYTAXACCOUNTSs[i].BPTNEWAPPLICATION.BPTNAACCEPTED = e.TAX_ACCT[i].UOL_BRT.ToString().Substring(7, 1);


                            }
                        }
                        _ETA._ENTITYTAXACCOUNTSs[i].BPTNEWAPPLICATION.BPTNASTATUS = CopMvcUtil.GetString(e.TAX_ACCT[i].UOL_BRT);
                    }
                    else
                        _ETA._ENTITYTAXACCOUNTSs[i].BPTNEWAPPLICATION.BPTNASTATUS = CopMvcUtil.GetString(e.TAX_ACCT[i].UOL_BRT);

                        _ETA._ENTITYTAXACCOUNTSs[i].PRKID = CopMvcUtil.GetString(e.TAX_ACCT[i].PRK_ID);
                    

                    _ETA._ENTITYTAXACCOUNTSs[i].ACCOUNTSpecified = true;
                    _ETA._ENTITYTAXACCOUNTSs[i].STARTDATESpecified = true;
                    
                }
            }


            _ECHK._ECHECK = new RTTIE010_SrvRef.RTTIE010_ECHK_ECHECK();

            _ECHK._ECHECK.FUNCTIONCODE = CopMvcUtil.GetString(e.ECHECK.FUNCTION_CODE);
            _ECHK._ECHECK.TRANSITROUTINGNUMBER = CopMvcUtil.GetString(e.ECHECK.ROUTING_NUMBER);
            _ECHK._ECHECK.BANKACCOUNTNUMBER = CopMvcUtil.GetString(e.ECHECK.ACCOUNT_NUMBER);
            _ECHK._ECHECK.BANKACCOUNTTYPE = CopMvcUtil.GetString(e.ECHECK.ACCOUNT_TYPE);

            string emi = CopMvcUtil.GetXMlFromObject(_EMI);
            string eta = CopMvcUtil.GetXMlFromObject(_ETA);
            string echk = CopMvcUtil.GetXMlFromObject(_ECHK);
            string ena = CopMvcUtil.GetXMlFromObject(_ENA1);
            string ena2 = CopMvcUtil.GetXMlFromObject(_ENA2);


            _SMAResponse = rttie010.CallRTTIE010 // calling the  service for Update/Registration...
                                  (_EMI, _ETA, _ECHK, _ENA1, _ENA2, out _EMIResponse, out _ETAResponse,
                                    out _ECHKResponse,
                                    out _ENA1Response,
                                    out _ENA2Response
                                  );

            //Assigning the reponse to the tempalte...            

            e = __Fill(_SMAResponse, _EMIResponse, _ENA1Response, _ENA2Response, _ETAResponse, _ECHKResponse);

            return e;

        }

        private static COPXmlFactory.RTTIE010.ACCTTEMPLATE __RTTIE010_F_A(COPXmlFactory.RTTIE010.ACCTTEMPLATE e)
        {
            e = __RTTIE010_F_U(e);
            return e;
        }

    }
}