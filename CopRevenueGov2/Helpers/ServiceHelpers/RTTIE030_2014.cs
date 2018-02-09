using CopRevenueGov2.Service;
using COPXmlFactory;
using COPXmlFactory.RTTIE030_2014;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Xml;

namespace CopRevenueGov2.Helpers
{
    public class RTTIE030_2014 : CopRestServiceBase, ICopSoapService
    {      

        public static void Init()
        {
          
        }

        public static string CallService(string Request)
        {
            COPXmlFactory.RTTIE030_2014.BPTlfReturn xo;

            try
            {
                xo = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE030_2014.BPTlfReturn>(Request);

                xo = __Call(xo);

            }
            catch (Exception ex)
            {
                xo = RevenueGovXMLFactory.GetBPTlf_2014Return();

                xo.ERROR_INFO = new ERROR_INFO();
                xo.ERROR_INFO.ERROR = 11.ToString();
                xo.ERROR_INFO.MESSAGE = ex.Message;
            }

            return RevenueGovXMLFactory.GetXmlString(xo);

        }

        public static XmlDocument CallService(XmlDocument Request)
        {
            COPXmlFactory.RTTIE030_2014.BPTlfReturn acct;

            try
            {
                string InnerXML = Request.InnerXml;
                acct = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE030_2014.BPTlfReturn>(InnerXML);

                acct = __Call(acct);

            }
            catch (Exception ex)
            {
                acct = RevenueGovXMLFactory.GetBPTlf_2014Return();

                acct.ERROR_INFO = new ERROR_INFO();
                acct.ERROR_INFO.ERROR = 11.ToString();
                acct.ERROR_INFO.MESSAGE = ex.Message;
            }

            return RevenueGovXMLFactory.GetXmlDocument(acct);
        }

        private static BPTlfReturn __Call(BPTlfReturn e)
        {
            switch (e.BPT_INFO.RETURN_STATUS)
            {
                case "INQ":
                    e = __RTTIE030_F_I(e);
                    break;
                case null: // submit
                    e = __RTTIE030_F_U(e);
                    break;

                default:
                    e.BPT_INFO.RETURN_STATUS = "INQ";
                    e = __RTTIE030_F_I(e);
                    break;
               
            }

            return e;
        }

        private static COPXmlFactory.RTTIE030_2014.BPTlfReturn __RTTIE030_F_I(COPXmlFactory.RTTIE030_2014.BPTlfReturn e)
        {

            RTTIE030_SrvRef.RT02E030_ELFBPT _ELFBPT = new RTTIE030_SrvRef.RT02E030_ELFBPT();
            RTTIE030_SrvRef.RT02E030 rttie030 = new RTTIE030_SrvRef.RT02E030();
            //
            RTTIE030_SrvRef.RT02E030Response_SMA _SMAResponse = new RTTIE030_SrvRef.RT02E030Response_SMA();
            RTTIE030_SrvRef.RT02E030Response_ELFBPT _ELFBPTResponse = new RTTIE030_SrvRef.RT02E030Response_ELFBPT();
            RTTIE030_SrvRef.RT02E030Response_ELFPG1 _ELFPG1Response = new RTTIE030_SrvRef.RT02E030Response_ELFPG1();
            RTTIE030_SrvRef.RT02E030Response_ELFSCHA _ELFSCHAResponse = new RTTIE030_SrvRef.RT02E030Response_ELFSCHA();
            RTTIE030_SrvRef.RT02E030Response_ELFSCHB _ELFSCHBResponse = new RTTIE030_SrvRef.RT02E030Response_ELFSCHB();
            RTTIE030_SrvRef.RT02E030Response_ELFSCHC1 _ELFSCHC1Response = new RTTIE030_SrvRef.RT02E030Response_ELFSCHC1();
            RTTIE030_SrvRef.RT02E030Response_ELFSCHD _ELFSCHDResponse = new RTTIE030_SrvRef.RT02E030Response_ELFSCHD();
            RTTIE030_SrvRef.RT02E030Response_ELFSCHE _ELFSCHEResponse = new RTTIE030_SrvRef.RT02E030Response_ELFSCHE();
            RTTIE030_SrvRef.RT02E030Response_NEW2014FIELDS _NEW2014FIELDSResponse = new RTTIE030_SrvRef.RT02E030Response_NEW2014FIELDS();
            RTTIE030_SrvRef.RT02E030Response_NEW2015FIELDS _NEW2015FIELDSResponse = new RTTIE030_SrvRef.RT02E030Response_NEW2015FIELDS();
            RTTIE030_SrvRef.RT02E030Response_SERR _SERRResponse = new RTTIE030_SrvRef.RT02E030Response_SERR();
            //
            _ELFBPT.ACCOUNTID = e.BPT_INFO.ACCOUNT_ID;
            _ELFBPT.PERIODX = CopMvcUtil.ConvDateDecimalString(e.BPT_INFO.PERIOD);
            _ELFBPT.RETURNSTATUS = e.BPT_INFO.RETURN_STATUS;
            //
            //
            _ELFBPT.ACCOUNTID = e.BPT_INFO.ACCOUNT_ID;
            _ELFBPT.PERIODX = CopMvcUtil.ConvDateDecimalString(e.BPT_INFO.PERIOD);
            _ELFBPT.RETURNSTATUS = e.BPT_INFO.RETURN_STATUS;
            //
            _SMAResponse = rttie030.CallRT02E030
                (new RTTIE030_SrvRef.RT02E030_SMA(),
                _ELFBPT,
                new RTTIE030_SrvRef.RT02E030_ELFPG1(),
                new RTTIE030_SrvRef.RT02E030_ELFSCHA(),
                new RTTIE030_SrvRef.RT02E030_ELFSCHB(),
                new RTTIE030_SrvRef.RT02E030_ELFSCHC1(),
                new RTTIE030_SrvRef.RT02E030_ELFSCHD(),
                new RTTIE030_SrvRef.RT02E030_ELFSCHE(),
                new RTTIE030_SrvRef.RT02E030_NEW2014FIELDS(),
                new RTTIE030_SrvRef.RT02E030_NEW2015FIELDS(),
                new RTTIE030_SrvRef.RT02E030_SERR(),
                //  out _SMAResponse,
                out _ELFBPTResponse,
                out _ELFPG1Response,
                out _ELFSCHAResponse,
                out _ELFSCHBResponse,
                out _ELFSCHC1Response,
                out _ELFSCHDResponse,
                out _ELFSCHEResponse,
                out _NEW2014FIELDSResponse,
                out _NEW2015FIELDSResponse,
                out _SERRResponse
                );
            e = __Fill(_SMAResponse, _ELFBPTResponse, _ELFPG1Response, _ELFSCHAResponse, _ELFSCHBResponse, _ELFSCHC1Response,
                       _ELFSCHDResponse, _ELFSCHEResponse, _NEW2014FIELDSResponse, _NEW2015FIELDSResponse, _SERRResponse
                );
            return e;
        }

        private static COPXmlFactory.RTTIE030_2014.BPTlfReturn __Fill(RTTIE030_SrvRef.RT02E030Response_SMA _SMA, RTTIE030_SrvRef.RT02E030Response_ELFBPT _ELFBPT,
          RTTIE030_SrvRef.RT02E030Response_ELFPG1 _ELFPG1, RTTIE030_SrvRef.RT02E030Response_ELFSCHA _ELFSCHA, RTTIE030_SrvRef.RT02E030Response_ELFSCHB _ELFSCHB,
          RTTIE030_SrvRef.RT02E030Response_ELFSCHC1 _ELFSCHC1, RTTIE030_SrvRef.RT02E030Response_ELFSCHD _ELFSCHD, RTTIE030_SrvRef.RT02E030Response_ELFSCHE _ELFSCHE,
          RTTIE030_SrvRef.RT02E030Response_NEW2014FIELDS _NEW2014FIELDS, RTTIE030_SrvRef.RT02E030Response_NEW2015FIELDS _NEW2015FIELDS,
          RTTIE030_SrvRef.RT02E030Response_SERR _SERR)
        {
            COPXmlFactory.RTTIE030_2014.BPTlfReturn fobj = RevenueGovXMLFactory.GetBPTlf_2014Return();
           
           // LOAD ERRORS INTO OBJECT
            fobj.ERROR_INFO = new ERROR_INFO();
            if (_SMA._PROGRAM != null)
            {
                fobj.ERROR_INFO.PROGRAM = _SMA._PROGRAM;
                fobj.ERROR_INFO.LINE = _SMA.ERRORLINE.ToString();
                fobj.ERROR_INFO.MESSAGE = _SMA.MESSAGE;
                fobj.ERROR_INFO.ERROR = _SMA.SYSTEMERROR.ToString();
            }
           

            //LOAD BPT_INFO 
            fobj.BPT_INFO = new BPT_INFO();
            fobj.BPT_INFO.ACCOUNT_ID =_ELFBPT.ACCOUNTID;
            fobj.BPT_INFO.VERSION =_ELFBPT.VERSIONX;
            fobj.BPT_INFO.RETURN_STATUS =_ELFBPT.RETURNSTATUS;
            fobj.BPT_INFO.PERIOD = CopMvcUtil.ConvDate(_ELFBPT.PERIODX);
            fobj.BPT_INFO.LAST_UPD_DATE = CopMvcUtil.ConvDate(_ELFBPT.LASTUPDATEDATEX);
            fobj.BPT_INFO.RECORDING_DATE = CopMvcUtil.ConvDate(_ELFBPT.RECORDINGDATEX);
            fobj.BPT_INFO.EXTENSION_DATE = CopMvcUtil.ConvDate(_ELFBPT.EXTENSIONDATEX);
            fobj.BPT_INFO.SEQUENCE = _ELFBPT.SEQUENCENUM;
            fobj.BPT_INFO.ADJUSTMENT_REF_NO = _ELFBPT.ADJREFNO;
            fobj.BPT_INFO.USER_ID = _ELFBPT.USERID;

            fobj.BPT_INFO.SCH_AB_TAX_RATE = CopMvcUtil.ConvDigitToDouble9(_ELFBPT.NETRATEX);
            fobj.BPT_INFO.SCH_D_TAX_RATE = CopMvcUtil.ConvDigitToDouble9(_ELFBPT.GROSSRATEX);
            fobj.BPT_INFO.SCH_E_M_TAX_RATE = CopMvcUtil.ConvDigitToDouble9(_ELFBPT.MANUFACTURERRATEX);
            fobj.BPT_INFO.SCH_E_W_TAX_RATE = CopMvcUtil.ConvDigitToDouble9(_ELFBPT.WHOLESALERRATEX);
            fobj.BPT_INFO.SCH_E_R_TAX_RATE = CopMvcUtil.ConvDigitToDouble9(_ELFBPT.RETAILERRATEX);

            fobj.BPT_INFO.LOSS_CARRY_FOWARD = CopMvcUtil.ConvDigitToCurrency(_ELFBPT.LOSSCARRYFORWARDX);
            fobj.BPT_INFO.PREPARER_NAME = _ELFBPT.PREPARERNAME;
            fobj.BPT_INFO.PREPARER_PHONE = CopMvcUtil.ConvDecimal(_ELFBPT.PREPARERPHONE).ToString();
            fobj.BPT_INFO.PREPARER_PHONE_EXT = _ELFBPT.PREPARERPHONEEXT;
            fobj.BPT_INFO.PREPARER_IP_ADDRESS = _ELFBPT.PREPARERIPADDRESS;
            fobj.BPT_INFO.PREPARER_EMAIL_ADDRESS = _ELFBPT.PREPAREREMAILADDRESS;
            fobj.BPT_INFO.PREPARER_WHO = _ELFBPT.PREPARERTYPE;

            //BPT_PG1
            fobj.BPT_PG1 = new BPT_PG1();
            fobj.BPT_PG1.NET_INCOME = CopMvcUtil.ConvDigitToCurrency(_ELFPG1.TAXONNETX);
            fobj.BPT_PG1.GROSS_RECEIPTS = CopMvcUtil.ConvDigitToCurrency(_ELFPG1.TAXONGROSSX);
            fobj.BPT_PG1.TAX_DUE = CopMvcUtil.ConvDigitToCurrency(_ELFPG1.ACTUALTAXX);
            fobj.BPT_PG1.ESTIMATED_TAX = CopMvcUtil.ConvDigitToCurrency(_ELFPG1.ESTIMATEDTAXX);
            fobj.BPT_PG1.TOTAL_TAX = CopMvcUtil.ConvDigitToCurrency(_ELFPG1.TOTALTAXX);
            fobj.BPT_PG1.NPT_TAX_CREDIT = CopMvcUtil.ConvDigitToCurrency(_ELFPG1.NPTTAXCREDITX);
            fobj.BPT_PG1.BPT_TAX_CREDIT = CopMvcUtil.ConvDigitToCurrency(_ELFPG1.BPTTAXCREDITX);
            fobj.BPT_PG1.TOTAL_PAY_CREDITS = CopMvcUtil.ConvDigitToCurrency(_ELFPG1.TOTALPAYMNTSCREDITSX);
            fobj.BPT_PG1.NET_TAX = CopMvcUtil.ConvDigitToCurrency(_ELFPG1.TAXDUEAMTX);
            fobj.BPT_PG1.INTEREST_PENALTY = CopMvcUtil.ConvDigitToCurrency(_ELFPG1.INTERESTANDPENALTYAMTX);
            fobj.BPT_PG1.AMOUNT_OWED = CopMvcUtil.ConvDigitToCurrency(_ELFPG1.AMTOWED2X);
            fobj.BPT_PG1.REFUND = CopMvcUtil.ConvDigitToCurrency(_ELFPG1.REFUNDAMTX);
            fobj.BPT_PG1.NPT_OVERPAY = CopMvcUtil.ConvDigitToCurrency(_ELFPG1.NPTOVERPAYMENTX);
            fobj.BPT_PG1.BPT_OVERPAY = CopMvcUtil.ConvDigitToCurrency(_ELFPG1.BPTOVERPAYMENTX);

            //BPT_SCH_A
            fobj.BPT_SCH_A = new BPT_SCH_A();
            if (_ELFSCHA.NETINCOMELOSSX != null)
            {
                fobj.BPT_SCH_A.NI_LOSS = CopMvcUtil.ConvDigitToCurrency(_ELFSCHA.NETINCOMELOSSX);
                fobj.BPT_SCH_A.NI_PORT_ACTIVITIES = CopMvcUtil.ConvDigitToCurrency(_ELFSCHA.NETINCOMEPORTACTIVITIESX);
                fobj.BPT_SCH_A.NI_PUC_ICC = CopMvcUtil.ConvDigitToCurrency(_ELFSCHA.NETINCOMEPUCICCX);
                fobj.BPT_SCH_A.NI_PUBLIC_LAW = CopMvcUtil.ConvDigitToCurrency(_ELFSCHA.NETINCOMEPUBLICLAWX);
                fobj.BPT_SCH_A.I_APPORTIONED = CopMvcUtil.ConvDigitToCurrency(_ELFSCHA.INCOMEAPPORTIONEDX);
                fobj.BPT_SCH_A.I_APPORTIONED_PERCENT = CopMvcUtil.ConvDigitToCurrency(_ELFSCHA.APPORTIONPERCENTX);
                fobj.BPT_SCH_A.I_APPORTIONED_PHILA = CopMvcUtil.ConvDigitToCurrency(_ELFSCHA.INCOMEAPPORTIONEDPHILAX);
                fobj.BPT_SCH_A.I_NONBUS_PHILA = CopMvcUtil.ConvDigitToCurrency(_ELFSCHA.INCOMENONBUSPHILAX);
                fobj.BPT_SCH_A.I_CURRENT_YEAR = CopMvcUtil.ConvDigitToCurrency(_ELFSCHA.INCOMECURRENTYEARX);
                fobj.BPT_SCH_A.LOSS_CARRY_FORWARD = CopMvcUtil.ConvDigitToCurrency(_ELFSCHA.LOSSCARRYFORWARDX);
                fobj.BPT_SCH_A.I_TAXABLE = CopMvcUtil.ConvDigitToCurrency(_ELFSCHA.TAXABLEINCOMEX);
                fobj.BPT_SCH_A.TAX_DUE = CopMvcUtil.ConvDigitToCurrency(_ELFSCHA.TAXDUEX);
                fobj.BPT_SCH_A.STAT_NET_DEDUCTION_A_X = CopMvcUtil.ConvDigitToCurrency(_NEW2014FIELDS._STATNETDEDUCTIONAX);  //binoy
            }
            else
            {
                fobj.BPT_SCH_A.NI_LOSS = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_A.NI_PORT_ACTIVITIES = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_A.NI_PUC_ICC = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_A.NI_PUBLIC_LAW = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_A.I_APPORTIONED = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_A.I_APPORTIONED_PERCENT = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_A.I_APPORTIONED_PHILA = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_A.I_NONBUS_PHILA = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_A.I_CURRENT_YEAR = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_A.LOSS_CARRY_FORWARD = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_A.I_TAXABLE = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_A.TAX_DUE = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_A.STAT_NET_DEDUCTION_A_X = CopMvcUtil.ConvDigitToCurrency("");
            }

            //BPT_SCH_B
            fobj.BPT_SCH_B = new BPT_SCH_B();
            if (_ELFSCHB._NETINCOMEX != null)
            {
                fobj.BPT_SCH_B.NI_LOSS = CopMvcUtil.ConvDigitToCurrency(_ELFSCHB._NETINCOMEX);
                fobj.BPT_SCH_B.ADJ_NI_INTEREST = CopMvcUtil.ConvDigitToCurrency(_ELFSCHB._ADJNETINCOMEINTERESTX);
                fobj.BPT_SCH_B.ADJ_NI_PORT_ACTIVITIES = CopMvcUtil.ConvDigitToCurrency(_ELFSCHB._ADJNETINCPORTACTIVITIESX);
                fobj.BPT_SCH_B.ADJ_NI_PUC_ICC = CopMvcUtil.ConvDigitToCurrency(_ELFSCHB._ADJNETINCOMEPUCICCX);
                fobj.BPT_SCH_B.ADJ_NI_PUBLIC_LAW = CopMvcUtil.ConvDigitToCurrency(_ELFSCHB._ADJNETINCOMEPUBLICLAWX);
                fobj.BPT_SCH_B.ADJ_RECEIPTS_DIR = CopMvcUtil.ConvDigitToCurrency(_ELFSCHB._ADJRECEIPTSDIRX);
                fobj.BPT_SCH_B.ADJ_INCOME = CopMvcUtil.ConvDigitToCurrency(_ELFSCHB._ADJUSTEDINCOMEX);
                fobj.BPT_SCH_B.ADJ_RECEIPTS_OTHER = CopMvcUtil.ConvDigitToCurrency(_ELFSCHB._ADJRECEIPTSOTHERX);
                fobj.BPT_SCH_B.ADJ_GROSS_RECEIPTS = CopMvcUtil.ConvDigitToCurrency(_ELFSCHB._ADJGROSSRECEIPTSX);
                fobj.BPT_SCH_B.ADJ_GROSS_PERCENT = CopMvcUtil.ConvDigitToCurrency(_ELFSCHB._GROSSPERCENTX);
                fobj.BPT_SCH_B.ADJ_TOTAL = CopMvcUtil.ConvDigitToCurrency(_ELFSCHB._TOTALADJUSTMENTSX);
                fobj.BPT_SCH_B.NI_ADJUSTED = CopMvcUtil.ConvDigitToCurrency(_ELFSCHB._NETINCOMEADJUSTEDX);
                fobj.BPT_SCH_B.I_NONBUS = CopMvcUtil.ConvDigitToCurrency(_ELFSCHB._NONBUSINCOMEX);
                fobj.BPT_SCH_B.I_APPORTIONED = CopMvcUtil.ConvDigitToCurrency(_ELFSCHB._INCOMEAPPORTIONEDX);
                fobj.BPT_SCH_B.I_APPORTIONED_PERCENT = CopMvcUtil.ConvDigitToCurrency(_ELFSCHB.APPORTIONPERCENTX);
                fobj.BPT_SCH_B.I_APPORTIONED_PHILA = CopMvcUtil.ConvDigitToCurrency(_ELFSCHB._INCOMEAPPORTIONEDPHILAX);
                fobj.BPT_SCH_B.I_NONBUS_PHILA = CopMvcUtil.ConvDigitToCurrency(_ELFSCHB._INCOMENONBUSPHILAX);
                fobj.BPT_SCH_B.I_CURRENT_YEAR = CopMvcUtil.ConvDigitToCurrency(_ELFSCHB._INCOMECURRENTYEARX);
                fobj.BPT_SCH_B.LOSS_CARRY_FORWARD = CopMvcUtil.ConvDigitToCurrency(_ELFSCHB._LOSSCARRYFORWARDX);
                fobj.BPT_SCH_B.I_TAXABLE = CopMvcUtil.ConvDigitToCurrency(_ELFSCHB._INCOMETAXABLEX);
                fobj.BPT_SCH_B.TAX_DUE = CopMvcUtil.ConvDigitToCurrency(_ELFSCHB._TAXDUEX);
                fobj.BPT_SCH_B.STAT_NET_DEDUCTION_B_X = CopMvcUtil.ConvDigitToCurrency(_NEW2014FIELDS._STATNETDEDUCTIONBX);  //binoy

            }
            else
            {
                fobj.BPT_SCH_B.NI_LOSS = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_B.ADJ_NI_INTEREST = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_B.ADJ_NI_PORT_ACTIVITIES = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_B.ADJ_NI_PUC_ICC = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_B.ADJ_NI_PUBLIC_LAW = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_B.ADJ_RECEIPTS_DIR = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_B.ADJ_INCOME = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_B.ADJ_RECEIPTS_OTHER = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_B.ADJ_GROSS_RECEIPTS = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_B.ADJ_GROSS_PERCENT = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_B.ADJ_TOTAL = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_B.NI_ADJUSTED = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_B.I_NONBUS = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_B.I_APPORTIONED = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_B.I_APPORTIONED_PERCENT = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_B.I_APPORTIONED_PHILA = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_B.I_NONBUS_PHILA = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_B.I_CURRENT_YEAR = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_B.LOSS_CARRY_FORWARD = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_B.I_TAXABLE = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_B.TAX_DUE = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_B.STAT_NET_DEDUCTION_B_X = CopMvcUtil.ConvDigitToCurrency(""); 
            }

            //BPT_SCH_C1
            fobj.BPT_SCH_C1 = new BPT_SCH_C1();
            if (_ELFSCHC1._PROPERTYPHILAX != null)
            {
                fobj.BPT_SCH_C1.TOTAL_AVG_PHILA = CopMvcUtil.ConvDigitToCurrency(_ELFSCHC1._PROPERTYPHILAX);
                fobj.BPT_SCH_C1.TOTAL_AVG_ALL = CopMvcUtil.ConvDigitToCurrency(_ELFSCHC1._PROPERTYALLX);

                fobj.BPT_SCH_C1.PROPERTY_FACTOR_PHILA = CopMvcUtil.ConvDigitToDouble9(_ELFSCHC1._PROPERTYFACTORX);
                fobj.BPT_SCH_C1.PAYROLL_PHILA = CopMvcUtil.ConvDigitToCurrency(_ELFSCHC1._PAYROLLPHILAX);
                fobj.BPT_SCH_C1.PAYROLL_ALL = CopMvcUtil.ConvDigitToCurrency(_ELFSCHC1._PAYROLLALLX);
                fobj.BPT_SCH_C1.PAYROLL_FACTOR_PHILA = CopMvcUtil.ConvDigitToDouble9(_ELFSCHC1._PAYROLLFACTORX);
                fobj.BPT_SCH_C1.RECEIPTS_PHILA = CopMvcUtil.ConvDigitToCurrency(_ELFSCHC1._RECEIPTSPHILAX);
                fobj.BPT_SCH_C1.RECEIPTS_ALL = CopMvcUtil.ConvDigitToCurrency(_ELFSCHC1._RECEIPTSALLX);
                fobj.BPT_SCH_C1.RECEIPTS_FACTOR_PHILA = CopMvcUtil.ConvDigitToDouble9(_ELFSCHC1._RECEIPTSFACTORX);
                fobj.BPT_SCH_C1.TOTAL_FACTORS = CopMvcUtil.ConvDigitToDouble9(_ELFSCHC1._TOTALFACTORSX);
                fobj.BPT_SCH_C1.AVERAGE_FACTORS = CopMvcUtil.ConvDigitToDouble9(_ELFSCHC1._AVERAGEFACTORSX);
            }
            else
            {
                fobj.BPT_SCH_C1.TOTAL_AVG_PHILA = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_C1.TOTAL_AVG_ALL = CopMvcUtil.ConvDigitToCurrency("");

                fobj.BPT_SCH_C1.PROPERTY_FACTOR_PHILA = CopMvcUtil.ConvDigitToDouble9("0");
                fobj.BPT_SCH_C1.PAYROLL_PHILA = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_C1.PAYROLL_ALL = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_C1.PAYROLL_FACTOR_PHILA = CopMvcUtil.ConvDigitToDouble9("0");
                fobj.BPT_SCH_C1.RECEIPTS_PHILA = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_C1.RECEIPTS_ALL = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_C1.RECEIPTS_FACTOR_PHILA = CopMvcUtil.ConvDigitToDouble9("0");
                fobj.BPT_SCH_C1.TOTAL_FACTORS = CopMvcUtil.ConvDigitToDouble9("0");
                fobj.BPT_SCH_C1.AVERAGE_FACTORS = CopMvcUtil.ConvDigitToDouble9("0");
            }

            //BPT_SCH_D
            fobj.BPT_SCH_D = new BPT_SCH_D();
            if (_ELFSCHD._GROSSSALESX != null)
            {
                fobj.BPT_SCH_D.GR_SALES = CopMvcUtil.ConvDigitToCurrency(_ELFSCHD._GROSSSALESX);
                fobj.BPT_SCH_D.GR_SERVICES = CopMvcUtil.ConvDigitToCurrency(_ELFSCHD._GROSSSERVICESX);
                fobj.BPT_SCH_D.GR_RENTALS = CopMvcUtil.ConvDigitToCurrency(_ELFSCHD._GROSSRENTALSX);
                fobj.BPT_SCH_D.GR_TOTALS = CopMvcUtil.ConvDigitToCurrency(_ELFSCHD._TOTALRECEIPTSX);
                fobj.BPT_SCH_D.LE_SALES_OUT = CopMvcUtil.ConvDigitToCurrency(_ELFSCHD._LESALESOUTX);
                fobj.BPT_SCH_D.LE_SERVICES_OUT = CopMvcUtil.ConvDigitToCurrency(_ELFSCHD._LESERVICESOUTX);
                fobj.BPT_SCH_D.LE_RENTALS_OUT = CopMvcUtil.ConvDigitToCurrency(_ELFSCHD._LERENTALSOUTX);
                fobj.BPT_SCH_D.LE_OTHER = CopMvcUtil.ConvDigitToCurrency(_ELFSCHD._LEOTHERAMTX);
                fobj.BPT_SCH_D.NET_TAXABLE_RECEIPTS = CopMvcUtil.ConvDigitToCurrency(_ELFSCHD._NETTAXABLERECEIPTSX);
                fobj.BPT_SCH_D.LE_TOTAL = CopMvcUtil.ConvDigitToCurrency(_ELFSCHD._LEMETHODRECEIPTSX);
                fobj.BPT_SCH_D.TAXABLE_RECEIPTS = CopMvcUtil.ConvDigitToCurrency(_ELFSCHD._REGULARRECEIPTSX);
                fobj.BPT_SCH_D.TAX_DUE = CopMvcUtil.ConvDigitToCurrency(_ELFSCHD._TAXDUEREGULARX);
                fobj.BPT_SCH_D.TAX_DUE_ALT = CopMvcUtil.ConvDigitToCurrency(_ELFSCHD._TAXDUEALTX);
                fobj.BPT_SCH_D.TOTAL_TAX_DUE = CopMvcUtil.ConvDigitToCurrency(_ELFSCHD._TOTALTAXDUEX);
                fobj.BPT_SCH_D.STAT_EXCLUSION_D_X = CopMvcUtil.ConvDigitToCurrency(_NEW2014FIELDS._STATEXCLUSIONDX);  //binoy
            }
            else
            {
                fobj.BPT_SCH_D.GR_SALES = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_D.GR_SERVICES = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_D.GR_RENTALS = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_D.GR_TOTALS = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_D.LE_SALES_OUT = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_D.LE_SERVICES_OUT = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_D.LE_RENTALS_OUT = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_D.LE_OTHER = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_D.NET_TAXABLE_RECEIPTS = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_D.LE_TOTAL = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_D.TAXABLE_RECEIPTS = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_D.TAX_DUE = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_D.TAX_DUE_ALT = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_D.TOTAL_TAX_DUE = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_D.STAT_EXCLUSION_D_X = CopMvcUtil.ConvDigitToCurrency("");
            }

            //BPT_SCH_E
            fobj.BPT_SCH_E = new BPT_SCH_E();
            if (_ELFSCHE._MALTRECEIPTSX != null)
            {
                fobj.BPT_SCH_E.M_ALT_RECEIPTS = CopMvcUtil.ConvDigitToCurrency(_ELFSCHE._MALTRECEIPTSX);
                fobj.BPT_SCH_E.M_GOODS_COST = CopMvcUtil.ConvDigitToCurrency(_ELFSCHE._MGOODSCOSTX);
                fobj.BPT_SCH_E.M_TAX_BASE = CopMvcUtil.ConvDigitToCurrency(_ELFSCHE._MTAXBASEX);
                fobj.BPT_SCH_E.M_TAX_DUE = CopMvcUtil.ConvDigitToCurrency(_ELFSCHE._MTAXDUEX);
                fobj.BPT_SCH_E.W_ALT_RECEIPTS = CopMvcUtil.ConvDigitToCurrency(_ELFSCHE._WALTRECEIPTSX);
                fobj.BPT_SCH_E.W_GOODS_MATERIALS = CopMvcUtil.ConvDigitToCurrency(_ELFSCHE._WGOODSMATERIALSX);
                fobj.BPT_SCH_E.W_GOODS_LABOR = CopMvcUtil.ConvDigitToCurrency(_ELFSCHE._WGOODSLABORX);
                fobj.BPT_SCH_E.W_GOODS_COST = CopMvcUtil.ConvDigitToCurrency(_ELFSCHE._WGOODSCOSTX);
                fobj.BPT_SCH_E.W_TAX_BASE = CopMvcUtil.ConvDigitToCurrency(_ELFSCHE._WTAXBASEX);
                fobj.BPT_SCH_E.W_TAX_DUE = CopMvcUtil.ConvDigitToCurrency(_ELFSCHE._WTAXDUEX);
                fobj.BPT_SCH_E.R_ALT_RECEIPTS = CopMvcUtil.ConvDigitToCurrency(_ELFSCHE._RALTRECEIPTSX);
                fobj.BPT_SCH_E.R_GOODS_MATERIALS = CopMvcUtil.ConvDigitToCurrency(_ELFSCHE._RGOODSMATERIALSX);
                fobj.BPT_SCH_E.R_GOODS_LABOR = CopMvcUtil.ConvDigitToCurrency(_ELFSCHE._RGOODSLABORX);
                fobj.BPT_SCH_E.R_GOODS_COST = CopMvcUtil.ConvDigitToCurrency(_ELFSCHE._RGOODSCOSTX);
                fobj.BPT_SCH_E.R_TAX_BASE = CopMvcUtil.ConvDigitToCurrency(_ELFSCHE._RTAXBASEX);
                fobj.BPT_SCH_E.R_TAX_DUE = CopMvcUtil.ConvDigitToCurrency(_ELFSCHE._RTAXDUEX);
                fobj.BPT_SCH_E.TOTAL_TAX_DUE = CopMvcUtil.ConvDigitToCurrency(_ELFSCHE._TOTALALTTAXDUEX);
            }
            else
            {
                fobj.BPT_SCH_E.M_ALT_RECEIPTS = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_E.M_GOODS_COST = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_E.M_TAX_BASE = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_E.M_TAX_DUE = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_E.W_ALT_RECEIPTS = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_E.W_GOODS_MATERIALS = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_E.W_GOODS_LABOR = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_E.W_GOODS_COST = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_E.W_TAX_BASE = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_E.W_TAX_DUE = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_E.R_ALT_RECEIPTS = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_E.R_GOODS_MATERIALS = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_E.R_GOODS_LABOR = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_E.R_GOODS_COST = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_E.R_TAX_BASE = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_E.R_TAX_DUE = CopMvcUtil.ConvDigitToCurrency("");
                fobj.BPT_SCH_E.TOTAL_TAX_DUE = CopMvcUtil.ConvDigitToCurrency("");
            }

            //BPT_TBL_C1
            string returnS = CopMvcUtil.GetXMlFromObject(fobj); 

            return fobj;

        }

        private static COPXmlFactory.RTTIE030_2014.BPTlfReturn __RTTIE030_F_U(COPXmlFactory.RTTIE030_2014.BPTlfReturn e)
        {

            RTTIE030_SrvRef.RT02E030_SMA _SMA = new RTTIE030_SrvRef.RT02E030_SMA();
            RTTIE030_SrvRef.RT02E030_ELFBPT _ELFBPT = new RTTIE030_SrvRef.RT02E030_ELFBPT();
            RTTIE030_SrvRef.RT02E030_ELFPG1 _ELFPG1 = new RTTIE030_SrvRef.RT02E030_ELFPG1();
            RTTIE030_SrvRef.RT02E030_ELFSCHA _ELFSCHA = new RTTIE030_SrvRef.RT02E030_ELFSCHA();
            RTTIE030_SrvRef.RT02E030_ELFSCHB _ELFSCHB = new RTTIE030_SrvRef.RT02E030_ELFSCHB();
            RTTIE030_SrvRef.RT02E030_ELFSCHC1 _ELFSCHC1 = new RTTIE030_SrvRef.RT02E030_ELFSCHC1();
            RTTIE030_SrvRef.RT02E030_ELFSCHD _ELFSCHD = new RTTIE030_SrvRef.RT02E030_ELFSCHD();
            RTTIE030_SrvRef.RT02E030_ELFSCHE _ELFSCHE = new RTTIE030_SrvRef.RT02E030_ELFSCHE();
            RTTIE030_SrvRef.RT02E030_NEW2014FIELDS _NEW2014FIELDS = new RTTIE030_SrvRef.RT02E030_NEW2014FIELDS();
            RTTIE030_SrvRef.RT02E030_NEW2015FIELDS _NEW2015FIELDS = new RTTIE030_SrvRef.RT02E030_NEW2015FIELDS();
            //
            RTTIE030_SrvRef.RT02E030 rttie030 = new RTTIE030_SrvRef.RT02E030();
            //
            RTTIE030_SrvRef.RT02E030Response_SMA _SMAResponse = new RTTIE030_SrvRef.RT02E030Response_SMA();
            RTTIE030_SrvRef.RT02E030Response_ELFBPT _ELFBPTResponse = new RTTIE030_SrvRef.RT02E030Response_ELFBPT();
            RTTIE030_SrvRef.RT02E030Response_ELFPG1 _ELFPG1Response = new RTTIE030_SrvRef.RT02E030Response_ELFPG1();
            RTTIE030_SrvRef.RT02E030Response_ELFSCHA _ELFSCHAResponse = new RTTIE030_SrvRef.RT02E030Response_ELFSCHA();
            RTTIE030_SrvRef.RT02E030Response_ELFSCHB _ELFSCHBResponse = new RTTIE030_SrvRef.RT02E030Response_ELFSCHB();
            RTTIE030_SrvRef.RT02E030Response_ELFSCHC1 _ELFSCHC1Response = new RTTIE030_SrvRef.RT02E030Response_ELFSCHC1();
            RTTIE030_SrvRef.RT02E030Response_ELFSCHD _ELFSCHDResponse = new RTTIE030_SrvRef.RT02E030Response_ELFSCHD();
            RTTIE030_SrvRef.RT02E030Response_ELFSCHE _ELFSCHEResponse = new RTTIE030_SrvRef.RT02E030Response_ELFSCHE();
            RTTIE030_SrvRef.RT02E030Response_NEW2014FIELDS _NEW2014FIELDSResponse = new RTTIE030_SrvRef.RT02E030Response_NEW2014FIELDS();
            RTTIE030_SrvRef.RT02E030Response_NEW2015FIELDS _NEW2015FIELDSResponse = new RTTIE030_SrvRef.RT02E030Response_NEW2015FIELDS();
            RTTIE030_SrvRef.RT02E030Response_SERR _SERRResponse = new RTTIE030_SrvRef.RT02E030Response_SERR(); 
            //
           _ELFBPT.ACCOUNTID = e.BPT_INFO.ACCOUNT_ID;
           _ELFBPT.VERSIONX = e.BPT_INFO.VERSION;
           _ELFBPT.PERIODX = CopMvcUtil.ConvDateDecimalString(e.BPT_INFO.PERIOD);
           _ELFBPT.RETURNSTATUS = e.BPT_INFO.RETURN_STATUS;
           _ELFBPT.LASTUPDATEDATEX = CopMvcUtil.ConvDateDecimalString(e.BPT_INFO.LAST_UPD_DATE);
           _ELFBPT.RECORDINGDATEX = CopMvcUtil.ConvDateDecimalString(e.BPT_INFO.RECORDING_DATE);
           _ELFBPT.EXTENSIONDATEX = CopMvcUtil.ConvDateDecimalString(e.BPT_INFO.EXTENSION_DATE);
           _ELFBPT.SEQUENCENUM = e.BPT_INFO.SEQUENCE;
           _ELFBPT.ADJREFNO = e.BPT_INFO.ADJUSTMENT_REF_NO;
           _ELFBPT.USERID = e.BPT_INFO.USER_ID;
           _ELFBPT.NETRATEX = CopMvcUtil.ConvNumberToDigit9(e.BPT_INFO.SCH_AB_TAX_RATE);
           _ELFBPT.GROSSRATEX = CopMvcUtil.ConvNumberToDigit9(e.BPT_INFO.SCH_D_TAX_RATE);
           _ELFBPT.MANUFACTURERRATEX = CopMvcUtil.ConvNumberToDigit9(e.BPT_INFO.SCH_E_M_TAX_RATE);
           _ELFBPT.WHOLESALERRATEX = CopMvcUtil.ConvNumberToDigit9(e.BPT_INFO.SCH_E_W_TAX_RATE);
           _ELFBPT.RETAILERRATEX = CopMvcUtil.ConvNumberToDigit9(e.BPT_INFO.SCH_E_R_TAX_RATE);
           _ELFBPT.LOSSCARRYFORWARDX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_INFO.LOSS_CARRY_FOWARD);
           _ELFBPT.PREPARERNAME = e.BPT_INFO.PREPARER_NAME;
           _ELFBPT.PREPARERPHONE = CopMvcUtil.GetDecimal(e.BPT_INFO.PREPARER_PHONE);
           _ELFBPT.PREPARERPHONEEXT = e.BPT_INFO.PREPARER_PHONE_EXT;
           _ELFBPT.PREPARERIPADDRESS = e.BPT_INFO.PREPARER_IP_ADDRESS;
           _ELFBPT.PREPAREREMAILADDRESS = e.BPT_INFO.PREPARER_EMAIL_ADDRESS;
           _ELFBPT.PREPARERTYPE = e.BPT_INFO.PREPARER_WHO;
           _ELFBPT.PREPARERPHONESpecified = true;
           
           _ELFPG1.TAXONNETX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.NET_INCOME);
           _ELFPG1.TAXONGROSSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.GROSS_RECEIPTS);
           _ELFPG1.ACTUALTAXX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.TAX_DUE);
           _ELFPG1.ESTIMATEDTAXX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.ESTIMATED_TAX);
           _ELFPG1.TOTALTAXX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.TOTAL_TAX);
           _ELFPG1.NPTTAXCREDITX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.NPT_TAX_CREDIT);
           _ELFPG1.BPTTAXCREDITX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.BPT_TAX_CREDIT);
           _ELFPG1.TOTALPAYMNTSCREDITSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.TOTAL_PAY_CREDITS);
           _ELFPG1.TAXDUEAMTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.NET_TAX);
           _ELFPG1.INTERESTANDPENALTYAMTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.INTEREST_PENALTY);
           _ELFPG1.AMTOWED2X = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.AMOUNT_OWED);
           _ELFPG1.REFUNDAMTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.REFUND);
           _ELFPG1.NPTOVERPAYMENTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.NPT_OVERPAY);
           _ELFPG1.BPTOVERPAYMENTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.BPT_OVERPAY);
            
           _ELFSCHA.NETINCOMELOSSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_A.NI_LOSS);
           _ELFSCHA.NETINCOMEPORTACTIVITIESX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_A.NI_PORT_ACTIVITIES);
           _ELFSCHA.NETINCOMEPUCICCX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_A.NI_PUC_ICC);
           _ELFSCHA.NETINCOMEPUBLICLAWX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_A.NI_PUBLIC_LAW);
           _ELFSCHA.INCOMEAPPORTIONEDX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_A.I_APPORTIONED);
           _ELFSCHA.APPORTIONPERCENTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_A.I_APPORTIONED_PERCENT);
           _ELFSCHA.INCOMEAPPORTIONEDPHILAX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_A.I_APPORTIONED_PHILA);
           _ELFSCHA.INCOMENONBUSPHILAX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_A.I_NONBUS_PHILA);
           _ELFSCHA.INCOMECURRENTYEARX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_A.I_CURRENT_YEAR);
           _ELFSCHA.LOSSCARRYFORWARDX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_A.LOSS_CARRY_FORWARD);
           _ELFSCHA.TAXABLEINCOMEX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_A.I_TAXABLE);
           _ELFSCHA.TAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_A.TAX_DUE);
           _NEW2014FIELDS._STATNETDEDUCTIONAX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_A.STAT_NET_DEDUCTION_A_X);
           
           _ELFSCHB._NETINCOMEX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.NI_LOSS);
           _ELFSCHB._ADJNETINCOMEINTERESTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.ADJ_NI_INTEREST);
           _ELFSCHB._ADJNETINCPORTACTIVITIESX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.ADJ_NI_PORT_ACTIVITIES);
           _ELFSCHB._ADJNETINCOMEPUCICCX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.ADJ_NI_PUC_ICC);
           _ELFSCHB._ADJNETINCOMEPUBLICLAWX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.ADJ_NI_PUBLIC_LAW);
           _ELFSCHB._ADJRECEIPTSDIRX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.ADJ_RECEIPTS_DIR);
           _ELFSCHB._ADJUSTEDINCOMEX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.ADJ_INCOME);
           _ELFSCHB._ADJRECEIPTSOTHERX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.ADJ_RECEIPTS_OTHER);
           _ELFSCHB._ADJGROSSRECEIPTSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.ADJ_GROSS_RECEIPTS);
           _ELFSCHB._GROSSPERCENTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.ADJ_GROSS_PERCENT);
           _ELFSCHB._TOTALADJUSTMENTSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.ADJ_TOTAL);
           _ELFSCHB._NETINCOMEADJUSTEDX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.NI_ADJUSTED);
           _ELFSCHB._NONBUSINCOMEX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.I_NONBUS);
           _ELFSCHB._INCOMEAPPORTIONEDX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.I_APPORTIONED);
           _ELFSCHB.APPORTIONPERCENTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.I_APPORTIONED_PERCENT);
           _ELFSCHB._INCOMEAPPORTIONEDPHILAX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.I_APPORTIONED_PHILA);
           _ELFSCHB._INCOMENONBUSPHILAX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.I_NONBUS_PHILA);
           _ELFSCHB._INCOMECURRENTYEARX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.I_CURRENT_YEAR);

           _ELFSCHB._LOSSCARRYFORWARDX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.LOSS_CARRY_FORWARD);
           _ELFSCHB._INCOMETAXABLEX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.I_TAXABLE);
           _ELFSCHB._TAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.TAX_DUE);
           _NEW2014FIELDS._STATNETDEDUCTIONBX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.STAT_NET_DEDUCTION_B_X);

           
           _ELFSCHC1._PROPERTYPHILAX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_C1.TOTAL_AVG_PHILA);
           _ELFSCHC1._PROPERTYALLX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_C1.TOTAL_AVG_ALL);
           _ELFSCHC1._PROPERTYFACTORX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_C1.PROPERTY_FACTOR_PHILA);
           _ELFSCHC1._PAYROLLPHILAX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_C1.PAYROLL_PHILA);
           _ELFSCHC1._PAYROLLALLX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_C1.PAYROLL_ALL);
           _ELFSCHC1._PAYROLLFACTORX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_C1.PAYROLL_FACTOR_PHILA);
           _ELFSCHC1._RECEIPTSPHILAX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_C1.RECEIPTS_PHILA);
           _ELFSCHC1._RECEIPTSALLX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_C1.RECEIPTS_ALL);
           _ELFSCHC1._RECEIPTSFACTORX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_C1.RECEIPTS_FACTOR_PHILA);
           _ELFSCHC1._TOTALFACTORSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_C1.TOTAL_FACTORS);
            _ELFSCHC1._AVERAGEFACTORSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_C1.AVERAGE_FACTORS);
           
            _ELFSCHD._GROSSSALESX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_D.GR_SALES);
            _ELFSCHD._GROSSSERVICESX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_D.GR_SERVICES);
            _ELFSCHD._GROSSRENTALSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_D.GR_RENTALS);
            _ELFSCHD._TOTALRECEIPTSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_D.GR_TOTALS);
            _ELFSCHD._LESALESOUTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_D.LE_SALES_OUT);
            _ELFSCHD._LESERVICESOUTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_D.LE_SERVICES_OUT);
            _ELFSCHD._LERENTALSOUTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_D.LE_RENTALS_OUT);
            _ELFSCHD._LEOTHERAMTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_D.LE_OTHER);
            _ELFSCHD._NETTAXABLERECEIPTSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_D.NET_TAXABLE_RECEIPTS);
            _ELFSCHD._LEMETHODRECEIPTSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_D.LE_TOTAL);
            _ELFSCHD._REGULARRECEIPTSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_D.TAXABLE_RECEIPTS);
            _ELFSCHD._TAXDUEREGULARX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_D.TAX_DUE);
            _ELFSCHD._TAXDUEALTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_D.TAX_DUE_ALT);
            _ELFSCHD._TOTALTAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_D.TOTAL_TAX_DUE);
            _NEW2014FIELDS._STATEXCLUSIONDX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_D.STAT_EXCLUSION_D_X);
            
            _ELFSCHE._MALTRECEIPTSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_E.M_ALT_RECEIPTS);
            _ELFSCHE._MGOODSCOSTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_E.M_GOODS_COST);
            _ELFSCHE._MTAXBASEX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_E.M_TAX_BASE);
            _ELFSCHE._MTAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_E.M_TAX_DUE);
            _ELFSCHE._WALTRECEIPTSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_E.W_ALT_RECEIPTS);
            _ELFSCHE._WGOODSMATERIALSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_E.W_GOODS_MATERIALS);
            _ELFSCHE._WGOODSLABORX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_E.W_GOODS_LABOR);
            _ELFSCHE._WGOODSCOSTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_E.W_GOODS_COST);
            _ELFSCHE._WTAXBASEX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_E.W_TAX_BASE);            
           _ELFSCHE._WTAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_E.W_TAX_DUE);
           _ELFSCHE._RALTRECEIPTSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_E.R_ALT_RECEIPTS);
           _ELFSCHE._RGOODSMATERIALSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_E.R_GOODS_MATERIALS);
           _ELFSCHE._RGOODSLABORX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_E.R_GOODS_LABOR);
           _ELFSCHE._RGOODSCOSTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_E.R_GOODS_COST);
           _ELFSCHE._RTAXBASEX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_E.R_TAX_BASE);
           _ELFSCHE._RTAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_E.R_TAX_DUE);
           _ELFSCHE._TOTALALTTAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_E.TOTAL_TAX_DUE);
          
           //_NEW2014FIELDS
           _NEW2014FIELDS._STATNETDEDUCTIONAX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_A.STAT_NET_DEDUCTION_A_X); //12 A
           _NEW2014FIELDS._STATNETDEDUCTIONBX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.STAT_NET_DEDUCTION_B_X); //10 B
           _NEW2014FIELDS._STATEXCLUSIONDX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_D.STAT_EXCLUSION_D_X); //6 D
            //
           string ELFBPT = CopMvcUtil.GetXMlFromObject(_ELFBPT);
           string ELFPG1 = CopMvcUtil.GetXMlFromObject(_ELFPG1);
           string ELFSCHA = CopMvcUtil.GetXMlFromObject(_ELFSCHA);
           string ELFSCHB = CopMvcUtil.GetXMlFromObject(_ELFSCHB);
           string ELFSCHC1 = CopMvcUtil.GetXMlFromObject(_ELFSCHC1);
           string ELFSCHD = CopMvcUtil.GetXMlFromObject(_ELFSCHD);
           string ELFSCHE = CopMvcUtil.GetXMlFromObject(_ELFSCHE);
           string NEW2014FIELDS = CopMvcUtil.GetXMlFromObject(_NEW2014FIELDS);
           string NEW2015FIELDS = CopMvcUtil.GetXMlFromObject(_NEW2015FIELDS);
           //
           _SMAResponse = rttie030.CallRT02E030(new RTTIE030_SrvRef.RT02E030_SMA(), _ELFBPT, _ELFPG1, _ELFSCHA, _ELFSCHB, _ELFSCHC1, _ELFSCHD,
               _ELFSCHE, _NEW2014FIELDS, _NEW2015FIELDS, new RTTIE030_SrvRef.RT02E030_SERR(),
               out _ELFBPTResponse, out _ELFPG1Response, out _ELFSCHAResponse, out _ELFSCHBResponse, out _ELFSCHC1Response, out _ELFSCHDResponse,
               out _ELFSCHEResponse, out _NEW2014FIELDSResponse, out _NEW2015FIELDSResponse, out _SERRResponse);

           e = __Fill(_SMAResponse, _ELFBPTResponse, _ELFPG1Response, _ELFSCHAResponse, _ELFSCHBResponse, _ELFSCHC1Response,
                      _ELFSCHDResponse, _ELFSCHEResponse, _NEW2014FIELDSResponse, _NEW2015FIELDSResponse, _SERRResponse
               );

           return e;
        }
    }
}