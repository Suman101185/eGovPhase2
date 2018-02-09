using CopRevenueGov2.Service;
using COPXmlFactory;
using COPXmlFactory.RTTIE010;
using COPXmlFactory.RTTIE037_2015;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml;

namespace CopRevenueGov2.Helpers
{
    public class RTTIE037_2015 : CopRestServiceBase, ICopSoapService
    {
        public static void Init()
        {
            
        }

        public static string CallService(string Request)
        {
            COPXmlFactory.RTTIE037_2015.BPTezReturn xo;

            try
            {
                xo = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE037_2015.BPTezReturn>(
                    Request);

                xo = __Call(xo);

            }
            catch (Exception ex)
            {
                xo =
                    RevenueGovXMLFactory.GetBPTez_2015Return();

                xo.ERROR_INFO = new ERROR_INFO();
                xo.ERROR_INFO.ERROR = 11.ToString();
                xo.ERROR_INFO.MESSAGE = ex.Message;
            }

            return RevenueGovXMLFactory.GetXmlString(xo);

        }

        public static XmlDocument CallService(XmlDocument Request)
        {
            COPXmlFactory.RTTIE037_2015.BPTezReturn acct;

            try
            {
                string InnerXML = Request.InnerXml;
                acct = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE037_2015.BPTezReturn>(
                    InnerXML);

                acct = __Call(acct);

            }
            catch (Exception ex)
            {
                acct =
                    RevenueGovXMLFactory.GetBPTez_2015Return();

                acct.ERROR_INFO = new ERROR_INFO();
                acct.ERROR_INFO.ERROR = 11.ToString();
                acct.ERROR_INFO.MESSAGE = ex.Message;
            }

            return RevenueGovXMLFactory.GetXmlDocument(acct);
        }
        private static BPTezReturn __Call(BPTezReturn e)
        {

            switch (e.BPT_INFO.RETURN_STATUS)
            {
                case "INQ":
                     e = __RTTIE037_F_I(e);   

                    break;
                case null: // submit
                    e = __RTTIE037_F_U(e);

                    break;

                default:
                    {
                        e.BPT_INFO.RETURN_STATUS = "INQ";
                          e = __RTTIE037_F_I(e);                       
                        break;
                    }
            }
           


            return e;
        }
        private static COPXmlFactory.RTTIE037_2015.BPTezReturn __RTTIE037_F_I(COPXmlFactory.RTTIE037_2015.BPTezReturn e)
        {    

            BPTLFEZ_RT01E037_SrvRef.RT01E037_EBPT _EBPT = new BPTLFEZ_RT01E037_SrvRef.RT01E037_EBPT();
            BPTLFEZ_RT01E037_SrvRef.RT01E037 serv_req = new BPTLFEZ_RT01E037_SrvRef.RT01E037();
            BPTLFEZ_RT01E037_SrvRef.RT01E037Response_SMA _SMAResponse = new BPTLFEZ_RT01E037_SrvRef.RT01E037Response_SMA();
            BPTLFEZ_RT01E037_SrvRef.RT01E037Response_EBPT _EBPTResponse = new BPTLFEZ_RT01E037_SrvRef.RT01E037Response_EBPT();
            BPTLFEZ_RT01E037_SrvRef.RT01E037Response_EPG1 _EPG1Response = new BPTLFEZ_RT01E037_SrvRef.RT01E037Response_EPG1();
            BPTLFEZ_RT01E037_SrvRef.RT01E037Response_EEZPG2 _EEZPG2Response = new BPTLFEZ_RT01E037_SrvRef.RT01E037Response_EEZPG2();
            BPTLFEZ_RT01E037_SrvRef.RT01E037Response_NEW2014FIELDS _NEW2014FIELDSResponse = new BPTLFEZ_RT01E037_SrvRef.RT01E037Response_NEW2014FIELDS();


            _EBPT.ACCOUNTID = e.BPT_INFO.ACCOUNT_ID;
            _EBPT.PERIODX = CopMvcUtil.ConvDateDecimalString(e.BPT_INFO.PERIOD);
            _EBPT.RETURNSTATUS = e.BPT_INFO.RETURN_STATUS;
            


            _SMAResponse = serv_req.CallRT01E037
                                            (new BPTLFEZ_RT01E037_SrvRef.RT01E037_SMA(), _EBPT,
                                              new BPTLFEZ_RT01E037_SrvRef.RT01E037_EPG1(),
                                              new BPTLFEZ_RT01E037_SrvRef.RT01E037_EEZPG2(),
                                             new BPTLFEZ_RT01E037_SrvRef.RT01E037_NEW2014FIELDS(),
                                              out _EBPTResponse,
                                              out _EPG1Response,
                                              out _EEZPG2Response,
                                              out _NEW2014FIELDSResponse
                                            );





            e = __Fill(_SMAResponse, _EBPTResponse, _EPG1Response, _EEZPG2Response, _NEW2014FIELDSResponse);
            return e;

        }

     

        private static COPXmlFactory.RTTIE037_2015.BPTezReturn __Fill(BPTLFEZ_RT01E037_SrvRef.RT01E037Response_SMA _SMA, BPTLFEZ_RT01E037_SrvRef.RT01E037Response_EBPT _EBPT, BPTLFEZ_RT01E037_SrvRef.RT01E037Response_EPG1 _EPG1, BPTLFEZ_RT01E037_SrvRef.RT01E037Response_EEZPG2 _EEZPG2, BPTLFEZ_RT01E037_SrvRef.RT01E037Response_NEW2014FIELDS _NEW2014FIELDS)
        {
            COPXmlFactory.RTTIE037_2015.BPTezReturn fobj = new BPTezReturn();

            //LOAD ERRORS INTO OBJECT
            fobj.ERROR_INFO = new ERROR_INFO();
            if (_SMA != null)
            {
                fobj.ERROR_INFO.PROGRAM = _SMA._PROGRAM;
                fobj.ERROR_INFO.LINE = _SMA.ERRORLINE.ToString();
                fobj.ERROR_INFO.MESSAGE = _SMA.MESSAGE;
                fobj.ERROR_INFO.ERROR = _SMA.SYSTEMERROR.ToString();
            }
            //LOAD BPT INFOS 
            fobj.BPT_INFO = new BPT_INFO();
            if (_EBPT != null)
            {
                fobj.BPT_INFO.ACCOUNT_ID = _EBPT.ACCOUNTID;
                fobj.BPT_INFO.ADJUSTMENT_REF_NO = _EBPT.ADJUSTMENTREFERENCENUM;
                fobj.BPT_INFO.PERIOD = CopMvcUtil.ConvDate(CopMvcUtil.GetDecimal(_EBPT.PERIODX));
                fobj.BPT_INFO.VERSION = _EBPT.VERSIONX;
                fobj.BPT_INFO.RETURN_STATUS = _EBPT.RETURNSTATUS;
                fobj.BPT_INFO.LAST_UPD_DATE = CopMvcUtil.ConvDate(CopMvcUtil.GetDecimal(_EBPT.LASTUPDATEDATEX));
                fobj.BPT_INFO.RECORDING_DATE = CopMvcUtil.ConvDate(CopMvcUtil.GetDecimal(_EBPT.RECORDINGDATEX));
                fobj.BPT_INFO.EXTENSION_DATE = CopMvcUtil.ConvDate(CopMvcUtil.GetDecimal(_EBPT.EXTENSIONDATEX));
                fobj.BPT_INFO.SEQUENCE = _EBPT.SEQUENCENUM;
                fobj.BPT_INFO.USER_ID = _EBPT.USERID;
                fobj.BPT_INFO.NET_RATE = CopMvcUtil.ConvDigitToDouble9(_EBPT.NETRATE);
                fobj.BPT_INFO.GROSS_RATE = CopMvcUtil.ConvDigitToDouble9(_EBPT.GROSSRATE);
                fobj.BPT_INFO.PREPARER_NAME = _EBPT.PREPARERNAME;
                fobj.BPT_INFO.TERMINATION_DATE = CopMvcUtil.ConvDate(CopMvcUtil.GetDecimal(_EBPT.EXTENSIONDATEX));



                if ((CopMvcUtil.GetLong(_EBPT.PREPARERPHONE) == 0))
                {
                    fobj.BPT_INFO.PREPARER_PHONE = string.Empty;
                }
                else
                {
                    fobj.BPT_INFO.PREPARER_PHONE = CopMvcUtil.GetString(_EBPT.PREPARERPHONE);
                }

                fobj.BPT_INFO.PREPARER_PHONE_EXT = _EBPT.PREPARERPHONEEXT;
                fobj.BPT_INFO.PREPARER_IP_ADDRESS = _EBPT.PREPARERIPADDRESS;
                fobj.BPT_INFO.PREPARER_EMAIL_ADDRESS = _EBPT.PREPAREREMAILADDRESS;
                fobj.BPT_INFO.PREPARER_WHO = _EBPT.PREPARERTYPE;

            }
            //LOAD BPT_PG1

            fobj.BPT_PG1 = new BPT_PG1();
            if (_EPG1 != null)
            {
                fobj.BPT_PG1.NET_TAX = CopMvcUtil.ConvDigitToCurrency(_EPG1.TAXONNETX);
                fobj.BPT_PG1.GROSS_TAX = CopMvcUtil.ConvDigitToCurrency(_EPG1.TAXONGROSSX);
                fobj.BPT_PG1.ACTUAL_TAX = CopMvcUtil.ConvDigitToCurrency(_EPG1.ACTUALTAXX);
                fobj.BPT_PG1.ESTIMATED_TAX = CopMvcUtil.ConvDigitToCurrency(_EPG1.ESTIMATEDTAXX);
                fobj.BPT_PG1.TOTAL_TAX = CopMvcUtil.ConvDigitToCurrency(_EPG1.TOTALTAXX);
                fobj.BPT_PG1.NPT_TAX_CREDIT = CopMvcUtil.ConvDigitToCurrency(_EPG1.NPTTAXCREDITX);
                fobj.BPT_PG1.BPT_TAX_CREDIT = CopMvcUtil.ConvDigitToCurrency(_EPG1.BPTTAXCREDITX);

                fobj.BPT_PG1.TOTAL_PAY_CREDITS = CopMvcUtil.ConvDigitToCurrency(_EPG1.TOTALPAYMNTSCREDITSX);
                fobj.BPT_PG1.TAX_DUE = CopMvcUtil.ConvDigitToCurrency(_EPG1.TOTALTAXX);
                fobj.BPT_PG1.INTEREST_PENALTY = CopMvcUtil.ConvDigitToCurrency(_EPG1.INTERESTANDPENALTYAMTX);
                fobj.BPT_PG1.AMOUNT_OWED = CopMvcUtil.ConvDigitToCurrency(_EPG1.AMTOWED2X);
                fobj.BPT_PG1.REFUND = CopMvcUtil.ConvDigitToCurrency(_EPG1.REFUNDAMTX);
                fobj.BPT_PG1.NPT_OVERPAY = CopMvcUtil.ConvDigitToCurrency(_EPG1.NPTOVERPAYMENTX);
                fobj.BPT_PG1.BPT_OVERPAY = CopMvcUtil.ConvDigitToCurrency(_EPG1.BPTOVERPAYMENTX);
            }
            //LOAD BPT_PG2

            fobj.BPT_PG2 = new BPT_PG2();

            if (_EEZPG2 != null)
            {
                fobj.BPT_PG2.NET_INCOME_LOSS_1 = CopMvcUtil.ConvDigitToCurrency(_EEZPG2.NETINCOMELOSS1X);
                fobj.BPT_PG2.NET_INCOME_LOSS_2 = CopMvcUtil.ConvDigitToCurrency(_EEZPG2.NETINCOMELOSS2X);
                fobj.BPT_PG2.LOSS_CARRY_FORWARD = CopMvcUtil.ConvDigitToCurrency(_EEZPG2.LOSSCARRYFORWARDX);
                fobj.BPT_PG2.TAXABLE_INCOME = CopMvcUtil.ConvDigitToCurrency(_EEZPG2.TAXABLEINCOMEX);

                fobj.BPT_PG2.TAX_DUE_NET = CopMvcUtil.ConvDigitToCurrency(_EEZPG2.TAXDUEXNET);
                fobj.BPT_PG2.SALES_RENTAL = CopMvcUtil.ConvDigitToCurrency(_EEZPG2.SALESRENTALSX);
                fobj.BPT_PG2.SERVICES = CopMvcUtil.ConvDigitToCurrency(_EEZPG2.SERVICESX);
                fobj.BPT_PG2.RENTAL_PROPERTY = CopMvcUtil.ConvDigitToCurrency(_EEZPG2.RENTALPROPERTYX);

                fobj.BPT_PG2.ROYALTIES = CopMvcUtil.ConvDigitToCurrency(_EEZPG2.ROYALTIESX);
                fobj.BPT_PG2.CAPITAL_GAINS = CopMvcUtil.ConvDigitToCurrency(_EEZPG2.CAPITALGAINSX);
                fobj.BPT_PG2.STOCK_GAINS = CopMvcUtil.ConvDigitToCurrency(_EEZPG2.STOCKGAINSX);
                fobj.BPT_PG2.DIVIDENDS = CopMvcUtil.ConvDigitToCurrency(_EEZPG2.DIVIDENDSX);
                fobj.BPT_PG2.INTEREST = CopMvcUtil.ConvDigitToDouble(_EEZPG2.INTERESTX);
                fobj.BPT_PG2.OTHER = CopMvcUtil.ConvDigitToCurrency(_EEZPG2.OTHERX);
                fobj.BPT_PG2.TAXABLE_GROSS_RCPTS = CopMvcUtil.ConvDigitToCurrency(_EEZPG2.TAXABLEGROSSRECEIPTSX);
                fobj.BPT_PG2.TAX_DUE_GROSS = CopMvcUtil.ConvDigitToCurrency(_EEZPG2.TAXDUEXGROSS);
                if(_NEW2014FIELDS.STATEXCLUSIONEZX==null)                
                fobj.BPT_PG2.STAT_EXCLUSION_EZ_X = CopMvcUtil.ConvDigitToCurrency("");
                else
                fobj.BPT_PG2.STAT_EXCLUSION_EZ_X = CopMvcUtil.ConvDigitToCurrency(_NEW2014FIELDS.STATEXCLUSIONEZX);
                if(_NEW2014FIELDS.STATNETDEDUCTION1X==null)
                fobj.BPT_PG2.STAT_NET_DEDUCTION_1_X = CopMvcUtil.ConvDigitToCurrency("");
                else
                fobj.BPT_PG2.STAT_NET_DEDUCTION_1_X = CopMvcUtil.ConvDigitToCurrency(_NEW2014FIELDS.STATNETDEDUCTION1X);
                if(_NEW2014FIELDS.TAXABLESUBTOTALEZX==null)
                fobj.BPT_PG2.TAXABLE_SUBTOTAL_EZ_X = CopMvcUtil.ConvDigitToCurrency("");
                else
                fobj.BPT_PG2.TAXABLE_SUBTOTAL_EZ_X = CopMvcUtil.ConvDigitToCurrency(_NEW2014FIELDS.TAXABLESUBTOTALEZX);
            }
            return fobj;

        }
        private static COPXmlFactory.RTTIE037_2015.BPTezReturn __RTTIE037_F_U(COPXmlFactory.RTTIE037_2015.BPTezReturn e)
        {

            BPTLFEZ_RT01E037_SrvRef.RT01E037 serv_req = new BPTLFEZ_RT01E037_SrvRef.RT01E037();
            BPTLFEZ_RT01E037_SrvRef.RT01E037_SMA _SMA = new BPTLFEZ_RT01E037_SrvRef.RT01E037_SMA();
            BPTLFEZ_RT01E037_SrvRef.RT01E037_EBPT _EBPT = new BPTLFEZ_RT01E037_SrvRef.RT01E037_EBPT();
            BPTLFEZ_RT01E037_SrvRef.RT01E037_EPG1 _EPG1 = new BPTLFEZ_RT01E037_SrvRef.RT01E037_EPG1();
            BPTLFEZ_RT01E037_SrvRef.RT01E037_EEZPG2 _EEZPG2 = new BPTLFEZ_RT01E037_SrvRef.RT01E037_EEZPG2();
            BPTLFEZ_RT01E037_SrvRef.RT01E037_NEW2014FIELDS _NEW2014FIELDS = new BPTLFEZ_RT01E037_SrvRef.RT01E037_NEW2014FIELDS();

            BPTLFEZ_RT01E037_SrvRef.RT01E037Response_SMA _SMAResponse = new BPTLFEZ_RT01E037_SrvRef.RT01E037Response_SMA();
            BPTLFEZ_RT01E037_SrvRef.RT01E037Response_EBPT _EBPTResponse = new BPTLFEZ_RT01E037_SrvRef.RT01E037Response_EBPT();
            BPTLFEZ_RT01E037_SrvRef.RT01E037Response_EPG1 _EPG1Response = new BPTLFEZ_RT01E037_SrvRef.RT01E037Response_EPG1();
            BPTLFEZ_RT01E037_SrvRef.RT01E037Response_EEZPG2 _EEZPG2Response = new BPTLFEZ_RT01E037_SrvRef.RT01E037Response_EEZPG2();
            BPTLFEZ_RT01E037_SrvRef.RT01E037Response_NEW2014FIELDS _NEW2014FIELDSResponse = new BPTLFEZ_RT01E037_SrvRef.RT01E037Response_NEW2014FIELDS();

            _SMA.ERRORLINE = string.Empty;
            _SMA.MESSAGE = string.Empty;
            _SMA.SYSTEMERROR = string.Empty;

            _EBPT.ACCOUNTID = e.BPT_INFO.ACCOUNT_ID;
            _EBPT.VERSIONX = "";
            _EBPT.PERIODX = CopMvcUtil.ConvDateDecimalString(e.BPT_INFO.PERIOD);
            _EBPT.RETURNSTATUS = ""; 
            _EBPT.LASTUPDATEDATEX = "";
            _EBPT.RECORDINGDATEX = "";
            _EBPT.EXTENSIONDATEX = "";
            _EBPT.SEQUENCENUM = "";
            _EBPT.ADJUSTMENTREFERENCENUM = "";
            _EBPT.USERID = "";
            _EBPT.NETRATE = e.BPT_INFO.NET_RATE;
            _EBPT.GROSSRATE = e.BPT_INFO.GROSS_RATE;
            _EBPT.PREPARERNAME = e.BPT_INFO.PREPARER_NAME;
            _EBPT.PREPARERPHONESpecified = true;
            
            _EBPT.PREPARERPHONE = CopMvcUtil.GetDecimal(e.BPT_INFO.PREPARER_PHONE.ToString());


            _EBPT.PREPARERPHONEEXT = e.BPT_INFO.PREPARER_PHONE_EXT;
            _EBPT.PREPARERIPADDRESS = e.BPT_INFO.PREPARER_IP_ADDRESS;
            _EBPT.PREPAREREMAILADDRESS = e.BPT_INFO.PREPARER_EMAIL_ADDRESS;
            _EBPT.PREPARERTYPE = e.BPT_INFO.PREPARER_WHO;

            _EPG1.TAXONNETX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.NET_TAX);
            _EPG1.TAXONGROSSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.GROSS_TAX);
            _EPG1.ACTUALTAXX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.ACTUAL_TAX);
            _EPG1.ESTIMATEDTAXX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.ESTIMATED_TAX);
            _EPG1.TOTALTAXX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.TOTAL_TAX);
            _EPG1.NPTTAXCREDITX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.NPT_TAX_CREDIT);
            _EPG1.BPTTAXCREDITX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.BPT_TAX_CREDIT);
            _EPG1.TOTALPAYMNTSCREDITSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.TOTAL_PAY_CREDITS);
            _EPG1.TAXDUEAMTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.TAX_DUE);
            _EPG1.INTERESTANDPENALTYAMTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.INTEREST_PENALTY);
            _EPG1.AMTOWED2X = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.AMOUNT_OWED);
            _EPG1.REFUNDAMTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.REFUND);
            _EPG1.NPTOVERPAYMENTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.NPT_OVERPAY);
            _EPG1.BPTOVERPAYMENTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.BPT_OVERPAY);

            _EEZPG2.NETINCOMELOSS1X = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG2.NET_INCOME_LOSS_1);
            _EEZPG2.NETINCOMELOSS2X = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG2.NET_INCOME_LOSS_2);
            _EEZPG2.LOSSCARRYFORWARDX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG2.LOSS_CARRY_FORWARD);
            _EEZPG2.TAXABLEINCOMEX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG2.TAXABLE_INCOME);
            _EEZPG2.TAXDUEXNET = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG2.TAX_DUE_NET);
            _EEZPG2.SALESRENTALSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG2.SALES_RENTAL);
            _EEZPG2.SERVICESX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG2.SERVICES);
            _EEZPG2.RENTALPROPERTYX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG2.RENTAL_PROPERTY);
            _EEZPG2.ROYALTIESX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG2.ROYALTIES);
            _EEZPG2.CAPITALGAINSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG2.CAPITAL_GAINS);
            _EEZPG2.STOCKGAINSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG2.STOCK_GAINS);
            _EEZPG2.DIVIDENDSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG2.DIVIDENDS);
            _EEZPG2.INTERESTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG2.INTEREST);
            _EEZPG2.OTHERX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG2.OTHER);
            _EEZPG2.TAXABLEGROSSRECEIPTSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG2.TAXABLE_GROSS_RCPTS);
            _EEZPG2.TAXDUEXGROSS = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG2.TAX_DUE_GROSS);

            _NEW2014FIELDS.STATEXCLUSIONEZX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG2.STAT_EXCLUSION_EZ_X);
            _NEW2014FIELDS.STATNETDEDUCTION1X = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG2.STAT_NET_DEDUCTION_1_X);
            _NEW2014FIELDS.TAXABLESUBTOTALEZX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG2.TAXABLE_SUBTOTAL_EZ_X);





            string SMA = CopMvcUtil.GetXMlFromObject(_SMA);
            string EBPT = CopMvcUtil.GetXMlFromObject(_EBPT);
            string EPG1 = CopMvcUtil.GetXMlFromObject(_EPG1);
            string EEZPG2 = CopMvcUtil.GetXMlFromObject(_EEZPG2);
            string NEW2014FIELDS = CopMvcUtil.GetXMlFromObject(_NEW2014FIELDS);
            

            _SMAResponse = serv_req.CallRT01E037
                                 (_SMA, _EBPT, _EPG1, _EEZPG2, _NEW2014FIELDS, out _EBPTResponse,
                                  out _EPG1Response,
                                  out _EEZPG2Response,
                                  out _NEW2014FIELDSResponse
                                );



            e = __Fill(_SMAResponse, _EBPTResponse, _EPG1Response, _EEZPG2Response, _NEW2014FIELDSResponse);

            return e;

        }
    }
}