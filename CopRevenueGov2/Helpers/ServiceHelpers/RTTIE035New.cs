using CopRevenueGov2.Service;
using COPXmlFactory;
using COPXmlFactory.RTTIE035new;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml;

namespace CopRevenueGov2.Helpers
{
    public class RTTIE035New : CopRestServiceBase, ICopSoapService
    {     
            

            public static void Init()
            {
               
            }

            public static string CallService(string Request)
            {
                COPXmlFactory.RTTIE035new.UOFORM xo;

                try
                {
                    xo = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE035new.UOFORM>(Request);

                    xo = __Call(xo);

                }
                catch (Exception ex)
                {
                    xo =
                        RevenueGovXMLFactory.GetUOFORMNewReturn();

                    xo.ERROR_INFO = new ERROR_INFO();
                    xo.ERROR_INFO.ERROR = 11.ToString();
                    xo.ERROR_INFO.MESSAGE = ex.Message;
                }

                return RevenueGovXMLFactory.GetXmlString(xo);

            }

            public static XmlDocument CallService(XmlDocument Request)
            {
                COPXmlFactory.RTTIE035new.UOFORM acct;

                try
                {
                    string InnerXML = Request.InnerXml;
                    acct = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE035new.UOFORM>(InnerXML);

                    acct = __Call(acct);

                }
                catch (Exception ex)
                {
                    acct = RevenueGovXMLFactory.GetUOFORMNewReturn();

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

            private static COPXmlFactory.RTTIE035new.UOFORM __RTTIE035_F_I(COPXmlFactory.RTTIE035new.UOFORM e)
            {

                
                UOForm_RTTIE035_SrvRef.RTTIE035_EUOL _EUOL = new UOForm_RTTIE035_SrvRef.RTTIE035_EUOL();
                UOForm_RTTIE035_SrvRef.RTTIE035 serv_req = new UOForm_RTTIE035_SrvRef.RTTIE035();
                UOForm_RTTIE035_SrvRef.RTTIE035Response_SMA _SMAResponse = new UOForm_RTTIE035_SrvRef.RTTIE035Response_SMA();
                UOForm_RTTIE035_SrvRef.RTTIE035Response_EUOL _EUOLResponse = new UOForm_RTTIE035_SrvRef.RTTIE035Response_EUOL();
                UOForm_RTTIE035_SrvRef.RTTIE035Response_EAMTS _EAMTSResponse = new UOForm_RTTIE035_SrvRef.RTTIE035Response_EAMTS();
                UOForm_RTTIE035_SrvRef.RTTIE035Response_EUO3 _EUO3Response = new UOForm_RTTIE035_SrvRef.RTTIE035Response_EUO3();





                _EUOL.ACCOUNTID = e.UO_ACCT.ACCOUNT_ID;
                if (e.UO_ACCT.PERIOD.Value.Contains('/'))
                {
                    _EUOL.PERIODX = CopMvcUtil.ConvDateDecimalString(e.UO_ACCT.PERIOD);
                }
                else
                {
                    _EUOL.PERIODX = e.UO_ACCT.PERIOD;
                }
                _EUOL.RETURNSTATUS = e.UO_ACCT.RETURN_STATUS;


                _SMAResponse = serv_req.CallRTTIE035
                                                (new UOForm_RTTIE035_SrvRef.RTTIE035_SMA(), _EUOL,
                                                  new UOForm_RTTIE035_SrvRef.RTTIE035_EAMTS(),
                                                  new UOForm_RTTIE035_SrvRef.RTTIE035_EUO3(),
                                                  out _EUOLResponse,
                                                  out _EAMTSResponse,
                                                  out _EUO3Response
                                                );





                e = __Fill(_SMAResponse, _EUOLResponse, _EAMTSResponse, _EUO3Response);
                return e;

            }

            private static COPXmlFactory.RTTIE035new.UOFORM __Fill(UOForm_RTTIE035_SrvRef.RTTIE035Response_SMA _SMA, UOForm_RTTIE035_SrvRef.RTTIE035Response_EUOL _EUOL, UOForm_RTTIE035_SrvRef.RTTIE035Response_EAMTS _EAMTS, UOForm_RTTIE035_SrvRef.RTTIE035Response_EUO3 _EUO3)
            {

                
                COPXmlFactory.RTTIE035new.UOFORM fobj = new UOFORM();

                //LOAD ERRORS INTO OBJECT
                fobj.ERROR_INFO = new ERROR_INFO();
                if (fobj.ERROR_INFO.LENGTH != null)
                {
                    fobj.ERROR_INFO.PROGRAM = _SMA._PROGRAM;
                    fobj.ERROR_INFO.LINE = _SMA.ERRORLINE.ToString();
                    fobj.ERROR_INFO.MESSAGE = _SMA.MESSAGE;
                    fobj.ERROR_INFO.ERROR = _SMA.SYSTEMERROR.ToString();
                }
                //LOAD UO_INFO 
                fobj.UO_ACCT = new UO_ACCT();

                if (fobj.UO_ACCT != null)
                {
                    fobj.UO_ACCT.ACCOUNT_ID = _EUOL.ACCOUNTID;
                    fobj.UO_ACCT.PERIOD = CopMvcUtil.ConvDate(_EUOL.PERIODX);
                    fobj.UO_ACCT.VERSION = _EUOL.VERSIONX;
                    fobj.UO_ACCT.RETURN_STATUS = _EUOL.RETURNSTATUS;
                    fobj.UO_ACCT.LAST_UPD_DATE = CopMvcUtil.ConvDate(_EUOL.LASTUPDATEDATEX);
                    fobj.UO_ACCT.USER_ID = _EUOL.USERID;
                    fobj.UO_ACCT.RECORDING_DATE = CopMvcUtil.ConvDate(_EUOL.RECORDINGDATEX);
                    fobj.UO_ACCT.SEQUENCE = _EUOL.SEQUENCENUM;
                    fobj.UO_ACCT.ADJUSTMENT_REF_NO = _EUOL.ADJUSTMENTREFERENCENUM;
                    fobj.UO_ACCT.RATE = CopMvcUtil.ConvDigitToCurrency(_EUOL.RATE);
                    fobj.UO_ACCT.BRT_NUMBER = _EUOL.BRTNUMBER;
                    fobj.UO_ACCT.LOCATION = _EUOL.LOCATION;
                    fobj.UO_ACCT.DUE_DATE = CopMvcUtil.ConvDate(_EUOL.DUEDATE);
                    fobj.UO_ACCT.ASSESSED_VALUE = CopMvcUtil.ConvDigitToCurrency(_EUOL.ASSESSEDVALUEX);
                    fobj.UO_ACCT.FREQUENCY = _EUOL.FREQUENCY;
                    fobj.UO_ACCT.PERIOD_CODE = _EUOL.PERIODCODE;
                    fobj.UO_ACCT.PERIOD_YY = _EUOL.PERIODYY;
                    fobj.UO_ACCT.PREPARER_NAME = _EUOL.PREPARERNAME;
                    fobj.UO_ACCT.PREPARER_PHONE = Convert.ToString(_EUOL.PREPARERPHONE);
                    fobj.UO_ACCT.PREPARER_PHONE_EXT = _EUOL.PREPARERPHONEEXT;
                    fobj.UO_ACCT.PREPARER_IP_ADDRESS = _EUOL.PREPARERIPADDRESS;
                    fobj.UO_ACCT.PREPARER_EMAIL_ADDRESS = _EUOL.PREPAREREMAILADDRESS;
                    fobj.UO_ACCT.PREPARER_WHO = _EUOL.PREPARERTYPE;
                }

                //LOAD UO_AMTS 
                fobj.UO_AMTS = new UO_AMTS();

                if (fobj.UO_AMTS != null)
                {
                    fobj.UO_AMTS.MAX_TAX = CopMvcUtil.ConvDigitToCurrency(_EAMTS.MAXTAXX);
                    fobj.UO_AMTS.VACANCY = CopMvcUtil.ConvDigitToCurrency(_EAMTS.VACANCYX);
                    fobj.UO_AMTS.EXEMPT = CopMvcUtil.ConvDigitToCurrency(_EAMTS.EXEMPTX);
                    fobj.UO_AMTS.RESIDENTIAL = CopMvcUtil.ConvDigitToCurrency(_EAMTS.RESIDENTIALX);
                    fobj.UO_AMTS.DELINQUENT = CopMvcUtil.ConvDigitToCurrency(_EAMTS.DELINQUENTX);
                    fobj.UO_AMTS.KOZ_CREDIT = CopMvcUtil.ConvDigitToCurrency(_EAMTS.EDICREDITX);
                    fobj.UO_AMTS.TOTAL_DEDUCTIONS = CopMvcUtil.ConvDigitToCurrency(_EAMTS.TOTALDEDUCTIONSX);
                    fobj.UO_AMTS.PERIOD_TAX = CopMvcUtil.ConvDigitToCurrency(_EAMTS.PERIODTAXX);
                    fobj.UO_AMTS.DISCOUNT = CopMvcUtil.ConvDigitToCurrency(_EAMTS.DISCOUNTX);
                    fobj.UO_AMTS.TAX_DUE = CopMvcUtil.ConvDigitToCurrency(_EAMTS.TAXDUEX);
                    fobj.UO_AMTS.INTEREST_PENALTY = CopMvcUtil.ConvDigitToCurrency(_EAMTS.INTERESTPENALTYX);
                    fobj.UO_AMTS.TOTAL_DUE = CopMvcUtil.ConvDigitToCurrency(_EAMTS.TOTALDUEX);
                    fobj.UO_AMTS.FIXED_EXEMPTN = CopMvcUtil.ConvDigitToCurrency(_EAMTS.FIXEDEXEMPTNX);
                    fobj.UO_AMTS.ADJUSTED_TAX = CopMvcUtil.ConvDigitToCurrency(_EAMTS.ADJUSTEDTAXX);
                    fobj.UO_AMTS.DELINQUENT_TENANT_COUNT = CopMvcUtil.ConvDigitToDouble(_EAMTS.DELINQUENTTENANTCOUNTX);
                }

                //LOAD UO3_PAGE 
                fobj.UO3_PAGE = new List<UO3_PAGE>();
                if (_EUO3._DELQs != null)
                {
                    for (int i = 0; i < _EUO3._DELQs.Length; i++)
                    {
                        fobj.UO3_PAGE.Add(COPXmlFactory.RevenueGovXMLFactory.GetUOFORMReturn_UO3_PAGENew());

                        fobj.UO3_PAGE[i].PROCESS_CODE = _EUO3._DELQs[i].PROCESSCODED;
                        fobj.UO3_PAGE[i].TENANT_NAME = _EUO3._DELQs[i].NAMED;
                        fobj.UO3_PAGE[i].TENANT_ID = _EUO3._DELQs[i].ENTITYIDD;
                        fobj.UO3_PAGE[i].ACCOUNT_ID = _EUO3._DELQs[i].ACCOUNTIDD;
                        fobj.UO3_PAGE[i].AMOUNT = _EUO3._DELQs[i].DELQAMTD;

                    }
                }

                return fobj;

            }


            private static COPXmlFactory.RTTIE035new.UOFORM __RTTIE035_F_U(COPXmlFactory.RTTIE035new.UOFORM e)
            {
                
                UOForm_RTTIE035_SrvRef.RTTIE035 serv_req = new UOForm_RTTIE035_SrvRef.RTTIE035();
                UOForm_RTTIE035_SrvRef.RTTIE035_SMA _SMA = new UOForm_RTTIE035_SrvRef.RTTIE035_SMA();
                UOForm_RTTIE035_SrvRef.RTTIE035_EUOL _EUOL = new UOForm_RTTIE035_SrvRef.RTTIE035_EUOL();
                UOForm_RTTIE035_SrvRef.RTTIE035_EAMTS _EAMTS = new UOForm_RTTIE035_SrvRef.RTTIE035_EAMTS();
                UOForm_RTTIE035_SrvRef.RTTIE035_EUO3 _EUO3 = new UOForm_RTTIE035_SrvRef.RTTIE035_EUO3();


                UOForm_RTTIE035_SrvRef.RTTIE035Response_SMA _SMAResponse = new UOForm_RTTIE035_SrvRef.RTTIE035Response_SMA();
                UOForm_RTTIE035_SrvRef.RTTIE035Response_EUOL _EUOLResponse = new UOForm_RTTIE035_SrvRef.RTTIE035Response_EUOL();
                UOForm_RTTIE035_SrvRef.RTTIE035Response_EAMTS _EAMTSResponse = new UOForm_RTTIE035_SrvRef.RTTIE035Response_EAMTS();
                UOForm_RTTIE035_SrvRef.RTTIE035Response_EUO3 _EUO3Response = new UOForm_RTTIE035_SrvRef.RTTIE035Response_EUO3();


                _EUOL.ACCOUNTID = e.UO_ACCT.ACCOUNT_ID;
                _EUOL.VERSIONX = e.UO_ACCT.VERSION;
                _EUOL.PERIODX = CopMvcUtil.ConvDateDecimal(e.UO_ACCT.PERIOD).ToString();
                _EUOL.LASTUPDATEDATEX = CopMvcUtil.ConvDateDecimal(e.UO_ACCT.LAST_UPD_DATE).ToString();
                _EUOL.USERID = e.UO_ACCT.USER_ID;
                _EUOL.RECORDINGDATEX = CopMvcUtil.ConvDateDecimal(e.UO_ACCT.RECORDING_DATE).ToString();
                _EUOL.SEQUENCENUM = e.UO_ACCT.SEQUENCE;
                _EUOL.ADJUSTMENTREFERENCENUM = e.UO_ACCT.ADJUSTMENT_REF_NO;
                _EUOL.RATE = CopMvcUtil.ConvNumberToDigit9(e.UO_ACCT.RATE);
                _EUOL.BRTNUMBER = CopMvcUtil.ConvNumberToDigit9(e.UO_ACCT.BRT_NUMBER);
                _EUOL.LOCATION = CopMvcUtil.GetString(e.UO_ACCT.LOCATION);
                _EUOL.DUEDATE = CopMvcUtil.ConvDateDecimal(e.UO_ACCT.DUE_DATE).ToString();
                _EUOL.ASSESSEDVALUEX = e.UO_ACCT.ASSESSED_VALUE;
                _EUOL.FREQUENCY = e.UO_ACCT.FREQUENCY;
                _EUOL.PERIODCODE = e.UO_ACCT.PERIOD_CODE;
                _EUOL.PERIODYY = e.UO_ACCT.PERIOD_YY;

                _EUOL.PREPARERNAME = e.UO_ACCT.PREPARER_NAME;
                _EUOL.PREPARERPHONE = CopMvcUtil.GetDecimal(e.UO_ACCT.PREPARER_PHONE);
                _EUOL.PREPARERPHONEEXT = e.UO_ACCT.PREPARER_PHONE_EXT;
                _EUOL.PREPARERIPADDRESS = e.UO_ACCT.PREPARER_IP_ADDRESS;
                _EUOL.PREPAREREMAILADDRESS = e.UO_ACCT.PREPARER_EMAIL_ADDRESS;
                _EUOL.PREPARERTYPE = e.UO_ACCT.PREPARER_WHO; ;
                _EUOL.PREPARERPHONESpecified = true;

                _EAMTS.MAXTAXX = CopMvcUtil.ConvCurrencyToDigit(e.UO_AMTS.MAX_TAX);
                _EAMTS.VACANCYX = CopMvcUtil.ConvCurrencyToDigit(e.UO_AMTS.VACANCY);
                _EAMTS.EXEMPTX = CopMvcUtil.ConvCurrencyToDigit(e.UO_AMTS.EXEMPT);
                _EAMTS.RESIDENTIALX = CopMvcUtil.ConvCurrencyToDigit(e.UO_AMTS.RESIDENTIAL);
                _EAMTS.DELINQUENTX = CopMvcUtil.ConvCurrencyToDigit(e.UO_AMTS.DELINQUENT);
                _EAMTS.EDICREDITX = CopMvcUtil.ConvCurrencyToDigit(e.UO_AMTS.KOZ_CREDIT);
                _EAMTS.TOTALDEDUCTIONSX = CopMvcUtil.ConvCurrencyToDigit(e.UO_AMTS.TOTAL_DEDUCTIONS);
                _EAMTS.PERIODTAXX = CopMvcUtil.ConvCurrencyToDigit(e.UO_AMTS.PERIOD_TAX);
                _EAMTS.DISCOUNTX = CopMvcUtil.ConvCurrencyToDigit(e.UO_AMTS.DISCOUNT);
                _EAMTS.TAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.UO_AMTS.TAX_DUE);
               // _EAMTS.FIXEDEXEMPTNX = CopMvcUtil.ConvCurrencyToDigit(e.UO_AMTS.FIXED_EXEMPTN);
                //_EAMTS.ADJUSTEDTAXX = CopMvcUtil.ConvCurrencyToDigit(e.UO_AMTS.ADJUSTED_TAX);
                _EAMTS.INTERESTPENALTYX = CopMvcUtil.ConvCurrencyToDigit(e.UO_AMTS.INTEREST_PENALTY);
                _EAMTS.TOTALDUEX = CopMvcUtil.ConvCurrencyToDigit(e.UO_AMTS.TOTAL_DUE);
                _EAMTS.DELINQUENTTENANTCOUNTX = e.UO_AMTS.DELINQUENT_TENANT_COUNT;



                if (e.UO3_PAGE.Count > 0)
                {

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
                        _EUO3._DELQs = new UOForm_RTTIE035_SrvRef.RTTIE035_EUO3_DELQ[r];
                    }
                    
                    for (int i = 0; i <= r; i++)
                    {
                        if (e.UO3_PAGE[i].ACCOUNT_ID.Value != null)
                        {

                            _EUO3._DELQs[i] = new UOForm_RTTIE035_SrvRef.RTTIE035_EUO3_DELQ();
                            _EUO3._DELQs[i].PROCESSCODED = CopMvcUtil.GetString(e.UO3_PAGE[i].PROCESS_CODE);
                            _EUO3._DELQs[i].NAMED = CopMvcUtil.GetString(e.UO3_PAGE[i].TENANT_NAME);
                            _EUO3._DELQs[i].ACCOUNTIDD = CopMvcUtil.GetString(e.UO3_PAGE[i].ACCOUNT_ID);
                            _EUO3._DELQs[i].ENTITYIDD = CopMvcUtil.GetString(e.UO3_PAGE[i].TENANT_ID);
                            _EUO3._DELQs[i].DELQAMTD = CopMvcUtil.ConvCurrencyToDigit(e.UO3_PAGE[i].AMOUNT);
                        }
                    }

                }

                _SMAResponse = serv_req.CallRTTIE035
                                                 (_SMA, _EUOL,
                                                   _EAMTS,
                                                   _EUO3,
                                                   out _EUOLResponse,
                                                   out _EAMTSResponse,
                                                   out _EUO3Response
                                                 );





                e = __Fill(_SMAResponse, _EUOLResponse, _EAMTSResponse, _EUO3Response);

                return e;
            }
        } 
    }
