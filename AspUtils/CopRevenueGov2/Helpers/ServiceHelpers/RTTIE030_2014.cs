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
        static RTTIE230_SrvRef.RTTIE230WS_PortTypeClient _client = null;

        public static void Init()
        {
            _client = COPServiceURLHelper.GetServiceClient_RTTIE230();
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
                //case "INQ":
                //    e = __RTTIE030_F_I(e);
                //    break;
                //case null: // submit
                //    e = __RTTIE030_F_U(e);
                //    break;

                //default:
                //    e.BPT_INFO.RETURN_STATUS = "INQ";
                //    e = __RTTIE030_F_I(e);
                //    break;
                case "INQ":
                    // e = __RTTIE030_F_I(e);
                    e = __RTTIE030_F_I("D:/sanghamitra/Sanghamitra Acharya/CopPhase2/SourceCode/EGovCurrent23.5/Xml files/BptLf/BptLf03.xml");
                    break;
                case null: // submit
                    e = __RTTIE030_F_U(e);
                    break;

                default:
                    e.BPT_INFO.RETURN_STATUS = "INQ";
                    e = __RTTIE030_F_I("D:/sanghamitra/Sanghamitra Acharya/CopPhase2/SourceCode/EGovCurrent23.5/Xml files/BptLf/BptLf03.xml");
                    break;
            }

            return e;
        }

        //private static COPXmlFactory.RTTIE030_2014.BPTlfReturn __RTTIE030_F_I(COPXmlFactory.RTTIE030_2014.BPTlfReturn e)
       private static COPXmlFactory.RTTIE030_2014.BPTlfReturn __RTTIE030_F_I(string ReplyXMLPath)
        {
            //RTTIE230_SrvRef.RTTIE230 serv_req = new RTTIE230_SrvRef.RTTIE230();

            //serv_req._ELFBPT = new RTTIE230_SrvRef._ELFBPT();

            //serv_req._ELFBPT.ACCOUNTID = e.BPT_INFO.ACCOUNT_ID;
            //serv_req._ELFBPT.PERIODX = CopMvcUtil.ConvDateDecimalString(e.BPT_INFO.PERIOD);
            //serv_req._ELFBPT.RETURNSTATUS = e.BPT_INFO.RETURN_STATUS;

            //RTTIE230_SrvRef.RTTIE230Response response = _client.RTTIE230(serv_req);

            //e = __Fill(response);

            //return e;
            CopMvcUtil utl = new CopMvcUtil();

            string xmlstring = utl.GetXMLString(ReplyXMLPath);

            COPXmlFactory.RTTIE030_2014.BPTlfReturn acct;

            acct = RevenueGovXMLFactory.GetObject<COPXmlFactory.RTTIE030_2014.BPTlfReturn>(
                xmlstring);


            return acct;
        }

        private static COPXmlFactory.RTTIE030_2014.BPTlfReturn __Fill(RTTIE230_SrvRef.RTTIE230Response e)
        {
            COPXmlFactory.RTTIE030_2014.BPTlfReturn fobj = RevenueGovXMLFactory.GetBPTlf_2014Return();

            //LOAD ERRORS INTO OBJECT
            fobj.ERROR_INFO = new ERROR_INFO();

            fobj.ERROR_INFO.PROGRAM = e._SMA._PROGRAM;
            fobj.ERROR_INFO.LINE = e._SMA.ERRORLINE.ToString();
            fobj.ERROR_INFO.MESSAGE = e._SMA.MESSAGE;
            fobj.ERROR_INFO.ERROR = e._SMA.SYSTEMERROR.ToString();

            //LOAD BPT_INFO 
            fobj.BPT_INFO = new BPT_INFO();
            fobj.BPT_INFO.ACCOUNT_ID = e._ELFBPT.ACCOUNTID;
            fobj.BPT_INFO.VERSION = e._ELFBPT.VERSIONX;
            fobj.BPT_INFO.RETURN_STATUS = e._ELFBPT.RETURNSTATUS;
            fobj.BPT_INFO.PERIOD = CopMvcUtil.ConvDate(e._ELFBPT.PERIODX);
            fobj.BPT_INFO.LAST_UPD_DATE = CopMvcUtil.ConvDate(e._ELFBPT.LASTUPDATEDATEX);
            fobj.BPT_INFO.RECORDING_DATE = CopMvcUtil.ConvDate(e._ELFBPT.RECORDINGDATEX);
            fobj.BPT_INFO.EXTENSION_DATE = CopMvcUtil.ConvDate(e._ELFBPT.EXTENSIONDATEX);
            fobj.BPT_INFO.SEQUENCE = e._ELFBPT.SEQUENCENUM;
            fobj.BPT_INFO.ADJUSTMENT_REF_NO = e._ELFBPT.ADJREFNO;
            fobj.BPT_INFO.USER_ID = e._ELFBPT.USERID;

            fobj.BPT_INFO.SCH_AB_TAX_RATE = CopMvcUtil.ConvDigitToDouble9(e._ELFBPT.NETRATEX);
            fobj.BPT_INFO.SCH_D_TAX_RATE = CopMvcUtil.ConvDigitToDouble9(e._ELFBPT.GROSSRATEX);
            fobj.BPT_INFO.SCH_E_M_TAX_RATE = CopMvcUtil.ConvDigitToDouble9(e._ELFBPT.MANUFACTURERRATEX);
            fobj.BPT_INFO.SCH_E_W_TAX_RATE = CopMvcUtil.ConvDigitToDouble9(e._ELFBPT.WHOLESALERRATEX);
            fobj.BPT_INFO.SCH_E_R_TAX_RATE = CopMvcUtil.ConvDigitToDouble9(e._ELFBPT.RETAILERRATEX);

            fobj.BPT_INFO.LOSS_CARRY_FOWARD = e._ELFBPT.LOSSCARRYFORWARDX;
            fobj.BPT_INFO.PREPARER_NAME = e._ELFBPT.PREPARERNAME;
            fobj.BPT_INFO.PREPARER_PHONE = CopMvcUtil.ConvDecimal(e._ELFBPT.PREPARERPHONE).ToString();
            fobj.BPT_INFO.PREPARER_PHONE_EXT = e._ELFBPT.PREPARERPHONEEXT;
            fobj.BPT_INFO.PREPARER_IP_ADDRESS = e._ELFBPT.PREPARERIPADDRESS;
            fobj.BPT_INFO.PREPARER_EMAIL_ADDRESS = e._ELFBPT.PREPAREREMAILADDRESS;
            fobj.BPT_INFO.PREPARER_WHO = e._ELFBPT.PREPARERTYPE;

            //BPT_PG1
            fobj.BPT_PG1 = new BPT_PG1();
            fobj.BPT_PG1.NET_INCOME = CopMvcUtil.ConvDigitToCurrency(e._ELFPG1.TAXONNETX);
            fobj.BPT_PG1.GROSS_RECEIPTS = CopMvcUtil.ConvDigitToCurrency(e._ELFPG1.TAXONGROSSX);
            fobj.BPT_PG1.TAX_DUE = CopMvcUtil.ConvDigitToCurrency(e._ELFPG1.ACTUALTAXX);
            fobj.BPT_PG1.ESTIMATED_TAX = CopMvcUtil.ConvDigitToCurrency(e._ELFPG1.ESTIMATEDTAXX);
            fobj.BPT_PG1.TOTAL_TAX = CopMvcUtil.ConvDigitToCurrency(e._ELFPG1.TOTALTAXX);
            fobj.BPT_PG1.NPT_TAX_CREDIT = CopMvcUtil.ConvDigitToCurrency(e._ELFPG1.NPTTAXCREDITX);
            fobj.BPT_PG1.BPT_TAX_CREDIT = CopMvcUtil.ConvDigitToCurrency(e._ELFPG1.BPTTAXCREDITX);
            fobj.BPT_PG1.TOTAL_PAY_CREDITS = CopMvcUtil.ConvDigitToCurrency(e._ELFPG1.TOTALPAYMNTSCREDITSX);
            fobj.BPT_PG1.NET_TAX = CopMvcUtil.ConvDigitToCurrency(e._ELFPG1.TAXDUEAMTX);
            fobj.BPT_PG1.INTEREST_PENALTY = CopMvcUtil.ConvDigitToCurrency(e._ELFPG1.INTERESTANDPENALTYAMTX);
            fobj.BPT_PG1.AMOUNT_OWED = CopMvcUtil.ConvDigitToCurrency(e._ELFPG1.AMTOWED2X);
            fobj.BPT_PG1.REFUND = CopMvcUtil.ConvDigitToCurrency(e._ELFPG1.REFUNDAMTX);
            fobj.BPT_PG1.NPT_OVERPAY = CopMvcUtil.ConvDigitToCurrency(e._ELFPG1.NPTOVERPAYMENTX);
            fobj.BPT_PG1.BPT_OVERPAY = CopMvcUtil.ConvDigitToCurrency(e._ELFPG1.BPTOVERPAYMENTX);

            //BPT_SCH_A
            fobj.BPT_SCH_A = new BPT_SCH_A();
            fobj.BPT_SCH_A.NI_LOSS = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHA.NETINCOMELOSSX);
            fobj.BPT_SCH_A.NI_PORT_ACTIVITIES = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHA.NETINCOMEPORTACTIVITIESX);
            fobj.BPT_SCH_A.NI_PUC_ICC = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHA.NETINCOMEPUCICCX);
            fobj.BPT_SCH_A.NI_PUBLIC_LAW = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHA.NETINCOMEPUBLICLAWX);
            fobj.BPT_SCH_A.I_APPORTIONED = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHA.INCOMEAPPORTIONEDX);
            fobj.BPT_SCH_A.I_APPORTIONED_PERCENT = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHA.APPORTIONPERCENTX);
            fobj.BPT_SCH_A.I_APPORTIONED_PHILA = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHA.INCOMEAPPORTIONEDPHILAX);
            fobj.BPT_SCH_A.I_NONBUS_PHILA = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHA.INCOMENONBUSPHILAX);
            fobj.BPT_SCH_A.I_CURRENT_YEAR = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHA.INCOMECURRENTYEARX);
            fobj.BPT_SCH_A.LOSS_CARRY_FORWARD = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHA.LOSSCARRYFORWARDX);
            fobj.BPT_SCH_A.I_TAXABLE = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHA.TAXABLEINCOMEX);
            fobj.BPT_SCH_A.TAX_DUE = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHA.TAXDUEX);
            fobj.BPT_SCH_A.STAT_NET_DEDUCTION_A_X = CopMvcUtil.ConvDigitToCurrency(e._NEW2014FIELDS._STATNETDEDUCTIONAX);  //binoy

            //BPT_SCH_B
            fobj.BPT_SCH_B = new BPT_SCH_B();
            fobj.BPT_SCH_B.NI_LOSS = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHB._NETINCOMEX);
            fobj.BPT_SCH_B.ADJ_NI_INTEREST = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHB._ADJNETINCOMEINTERESTX);
            fobj.BPT_SCH_B.ADJ_NI_PORT_ACTIVITIES = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHB._ADJNETINCPORTACTIVITIESX);
            fobj.BPT_SCH_B.ADJ_NI_PUC_ICC = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHB._ADJNETINCOMEPUCICCX);
            fobj.BPT_SCH_B.ADJ_NI_PUBLIC_LAW = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHB._ADJNETINCOMEPUBLICLAWX);
            fobj.BPT_SCH_B.ADJ_RECEIPTS_DIR = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHB._ADJRECEIPTSDIRX);
            fobj.BPT_SCH_B.ADJ_INCOME = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHB._ADJUSTEDINCOMEX);
            fobj.BPT_SCH_B.ADJ_RECEIPTS_OTHER = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHB._ADJRECEIPTSOTHERX);
            fobj.BPT_SCH_B.ADJ_GROSS_RECEIPTS = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHB._ADJGROSSRECEIPTSX);
            fobj.BPT_SCH_B.ADJ_GROSS_PERCENT = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHB._GROSSPERCENTX);
            fobj.BPT_SCH_B.ADJ_TOTAL = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHB._TOTALADJUSTMENTSX);
            fobj.BPT_SCH_B.NI_ADJUSTED = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHB._NETINCOMEADJUSTEDX);
            fobj.BPT_SCH_B.I_NONBUS = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHB._NONBUSINCOMEX);
            fobj.BPT_SCH_B.I_APPORTIONED = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHB._INCOMEAPPORTIONEDX);
            fobj.BPT_SCH_B.I_APPORTIONED_PERCENT = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHB.APPORTIONPERCENTX);
            fobj.BPT_SCH_B.I_APPORTIONED_PHILA = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHB._INCOMEAPPORTIONEDPHILAX);
            fobj.BPT_SCH_B.I_NONBUS_PHILA = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHB._INCOMENONBUSPHILAX);
            fobj.BPT_SCH_B.I_CURRENT_YEAR = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHB._INCOMECURRENTYEARX);
            fobj.BPT_SCH_B.LOSS_CARRY_FORWARD = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHB._LOSSCARRYFORWARDX);
            fobj.BPT_SCH_B.I_TAXABLE = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHB._INCOMETAXABLEX);
            fobj.BPT_SCH_B.TAX_DUE = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHB._TAXDUEX);
            fobj.BPT_SCH_B.STAT_NET_DEDUCTION_B_X = CopMvcUtil.ConvDigitToCurrency(e._NEW2014FIELDS._STATNETDEDUCTIONBX);  //binoy

            //BPT_SCH_C1
            fobj.BPT_SCH_C1 = new BPT_SCH_C1();

            fobj.BPT_SCH_C1.TOTAL_AVG_PHILA = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHC1._PROPERTYPHILAX);
            fobj.BPT_SCH_C1.TOTAL_AVG_ALL = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHC1._PROPERTYALLX);

            fobj.BPT_SCH_C1.PROPERTY_FACTOR_PHILA = CopMvcUtil.ConvDigitToDouble9(e._ELFSCHC1._PROPERTYFACTORX);
            fobj.BPT_SCH_C1.PAYROLL_PHILA = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHC1._PAYROLLPHILAX);
            fobj.BPT_SCH_C1.PAYROLL_ALL = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHC1._PAYROLLALLX);
            fobj.BPT_SCH_C1.PAYROLL_FACTOR_PHILA = CopMvcUtil.ConvDigitToDouble9(e._ELFSCHC1._PAYROLLFACTORX);
            fobj.BPT_SCH_C1.RECEIPTS_PHILA = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHC1._RECEIPTSPHILAX);
            fobj.BPT_SCH_C1.RECEIPTS_ALL = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHC1._RECEIPTSALLX);
            fobj.BPT_SCH_C1.RECEIPTS_FACTOR_PHILA = CopMvcUtil.ConvDigitToDouble9(e._ELFSCHC1._RECEIPTSFACTORX);
            fobj.BPT_SCH_C1.TOTAL_FACTORS = CopMvcUtil.ConvDigitToDouble9(e._ELFSCHC1._TOTALFACTORSX);
            fobj.BPT_SCH_C1.AVERAGE_FACTORS = CopMvcUtil.ConvDigitToDouble9(e._ELFSCHC1._AVERAGEFACTORSX);

            //BPT_SCH_D
            fobj.BPT_SCH_D = new BPT_SCH_D();
            fobj.BPT_SCH_D.GR_SALES = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHD._GROSSSALESX);
            fobj.BPT_SCH_D.GR_SERVICES = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHD._GROSSSERVICESX);
            fobj.BPT_SCH_D.GR_RENTALS = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHD._GROSSRENTALSX);
            fobj.BPT_SCH_D.GR_TOTALS = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHD._TOTALRECEIPTSX);
            fobj.BPT_SCH_D.LE_SALES_OUT = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHD._LESALESOUTX);
            fobj.BPT_SCH_D.LE_SERVICES_OUT = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHD._LESERVICESOUTX);
            fobj.BPT_SCH_D.LE_RENTALS_OUT = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHD._LERENTALSOUTX);
            fobj.BPT_SCH_D.LE_OTHER = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHD._LEOTHERAMTX);
            fobj.BPT_SCH_D.NET_TAXABLE_RECEIPTS = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHD._NETTAXABLERECEIPTSX);
            fobj.BPT_SCH_D.LE_TOTAL = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHD._LEMETHODRECEIPTSX);
            fobj.BPT_SCH_D.TAXABLE_RECEIPTS = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHD._REGULARRECEIPTSX);
            fobj.BPT_SCH_D.TAX_DUE = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHD._TAXDUEREGULARX);
            fobj.BPT_SCH_D.TAX_DUE_ALT = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHD._TAXDUEALTX);
            fobj.BPT_SCH_D.TOTAL_TAX_DUE = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHD._TOTALTAXDUEX);
            fobj.BPT_SCH_D.STAT_EXCLUSION_D_X = CopMvcUtil.ConvDigitToCurrency(e._NEW2014FIELDS._STATEXCLUSIONDX);  //binoy

            //BPT_SCH_E
            fobj.BPT_SCH_E = new BPT_SCH_E();
            fobj.BPT_SCH_E.M_ALT_RECEIPTS = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHE._MALTRECEIPTSX);
            fobj.BPT_SCH_E.M_GOODS_COST = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHE._MGOODSCOSTX);
            fobj.BPT_SCH_E.M_TAX_BASE = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHE._MTAXBASEX);
            fobj.BPT_SCH_E.M_TAX_DUE = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHE._MTAXDUEX);
            fobj.BPT_SCH_E.W_ALT_RECEIPTS = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHE._WALTRECEIPTSX);
            fobj.BPT_SCH_E.W_GOODS_MATERIALS = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHE._WGOODSMATERIALSX);
            fobj.BPT_SCH_E.W_GOODS_LABOR = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHE._WGOODSLABORX);
            fobj.BPT_SCH_E.W_GOODS_COST = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHE._WGOODSCOSTX);
            fobj.BPT_SCH_E.W_TAX_BASE = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHE._WTAXBASEX);
            fobj.BPT_SCH_E.W_TAX_DUE = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHE._WTAXDUEX);
            fobj.BPT_SCH_E.R_ALT_RECEIPTS = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHE._RALTRECEIPTSX);
            fobj.BPT_SCH_E.R_GOODS_MATERIALS = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHE._RGOODSMATERIALSX);
            fobj.BPT_SCH_E.R_GOODS_LABOR = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHE._RGOODSLABORX);
            fobj.BPT_SCH_E.R_GOODS_COST = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHE._RGOODSCOSTX);
            fobj.BPT_SCH_E.R_TAX_BASE = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHE._RTAXBASEX);
            fobj.BPT_SCH_E.R_TAX_DUE = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHE._RTAXDUEX);
            fobj.BPT_SCH_E.TOTAL_TAX_DUE = CopMvcUtil.ConvDigitToCurrency(e._ELFSCHE._TOTALALTTAXDUEX);

            //BPT_TBL_C1


            return fobj;

        }

        private static COPXmlFactory.RTTIE030_2014.BPTlfReturn __RTTIE030_F_U(COPXmlFactory.RTTIE030_2014.BPTlfReturn e)
        {

            RTTIE230_SrvRef.RTTIE230 serv_req = new RTTIE230_SrvRef.RTTIE230();

            serv_req._NEW2014FIELDS = new RTTIE230_SrvRef._NEW2014FIELDS();

            serv_req._ELFBPT = new RTTIE230_SrvRef._ELFBPT();
            serv_req._ELFBPT.ACCOUNTID = e.BPT_INFO.ACCOUNT_ID;
            serv_req._ELFBPT.VERSIONX = e.BPT_INFO.VERSION;
            serv_req._ELFBPT.PERIODX = CopMvcUtil.ConvDateDecimalString(e.BPT_INFO.PERIOD);
            serv_req._ELFBPT.RETURNSTATUS = e.BPT_INFO.RETURN_STATUS;
            serv_req._ELFBPT.LASTUPDATEDATEX = CopMvcUtil.ConvDateDecimalString(e.BPT_INFO.LAST_UPD_DATE);
            serv_req._ELFBPT.RECORDINGDATEX = CopMvcUtil.ConvDateDecimalString(e.BPT_INFO.RECORDING_DATE);
            serv_req._ELFBPT.EXTENSIONDATEX = CopMvcUtil.ConvDateDecimalString(e.BPT_INFO.EXTENSION_DATE);
            serv_req._ELFBPT.SEQUENCENUM = e.BPT_INFO.SEQUENCE;
            serv_req._ELFBPT.ADJREFNO = e.BPT_INFO.ADJUSTMENT_REF_NO;
            serv_req._ELFBPT.USERID = e.BPT_INFO.USER_ID;
            serv_req._ELFBPT.NETRATEX = CopMvcUtil.ConvNumberToDigit9(e.BPT_INFO.SCH_AB_TAX_RATE);
            serv_req._ELFBPT.GROSSRATEX = CopMvcUtil.ConvNumberToDigit9(e.BPT_INFO.SCH_D_TAX_RATE);
            serv_req._ELFBPT.MANUFACTURERRATEX = CopMvcUtil.ConvNumberToDigit9(e.BPT_INFO.SCH_E_M_TAX_RATE);
            serv_req._ELFBPT.WHOLESALERRATEX = CopMvcUtil.ConvNumberToDigit9(e.BPT_INFO.SCH_E_W_TAX_RATE);
            serv_req._ELFBPT.RETAILERRATEX = CopMvcUtil.ConvNumberToDigit9(e.BPT_INFO.SCH_E_R_TAX_RATE);
            serv_req._ELFBPT.LOSSCARRYFORWARDX = e.BPT_INFO.LOSS_CARRY_FOWARD;
            serv_req._ELFBPT.PREPARERNAME = e.BPT_INFO.PREPARER_NAME;
            serv_req._ELFBPT.PREPARERPHONE = CopMvcUtil.ConvDecimal(e.BPT_INFO.PREPARER_PHONE);
            serv_req._ELFBPT.PREPARERPHONEEXT = e.BPT_INFO.PREPARER_PHONE_EXT;
            serv_req._ELFBPT.PREPARERIPADDRESS = e.BPT_INFO.PREPARER_IP_ADDRESS;
            serv_req._ELFBPT.PREPAREREMAILADDRESS = e.BPT_INFO.PREPARER_EMAIL_ADDRESS;
            serv_req._ELFBPT.PREPARERTYPE = e.BPT_INFO.PREPARER_WHO;

            serv_req._ELFPG1 = new RTTIE230_SrvRef._ELFPG1();
            serv_req._ELFPG1.TAXONNETX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.NET_INCOME);
            serv_req._ELFPG1.TAXONGROSSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.GROSS_RECEIPTS);
            serv_req._ELFPG1.ACTUALTAXX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.TAX_DUE);
            serv_req._ELFPG1.ESTIMATEDTAXX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.ESTIMATED_TAX);
            serv_req._ELFPG1.TOTALTAXX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.TOTAL_TAX);
            serv_req._ELFPG1.NPTTAXCREDITX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.NPT_TAX_CREDIT);
            serv_req._ELFPG1.BPTTAXCREDITX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.BPT_TAX_CREDIT);
            serv_req._ELFPG1.TOTALPAYMNTSCREDITSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.TOTAL_PAY_CREDITS);
            serv_req._ELFPG1.TAXDUEAMTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.NET_TAX);
            serv_req._ELFPG1.INTERESTANDPENALTYAMTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.INTEREST_PENALTY);
            serv_req._ELFPG1.AMTOWED2X = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.AMOUNT_OWED);
            serv_req._ELFPG1.REFUNDAMTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.REFUND);
            serv_req._ELFPG1.NPTOVERPAYMENTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.NPT_OVERPAY);
            serv_req._ELFPG1.BPTOVERPAYMENTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_PG1.BPT_OVERPAY);

            serv_req._ELFSCHA = new RTTIE230_SrvRef._ELFSCHA();
            serv_req._ELFSCHA.NETINCOMELOSSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_A.NI_LOSS);
            serv_req._ELFSCHA.NETINCOMEPORTACTIVITIESX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_A.NI_PORT_ACTIVITIES);
            serv_req._ELFSCHA.NETINCOMEPUCICCX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_A.NI_PUC_ICC);
            serv_req._ELFSCHA.NETINCOMEPUBLICLAWX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_A.NI_PUBLIC_LAW);
            serv_req._ELFSCHA.INCOMEAPPORTIONEDX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_A.I_APPORTIONED);
            serv_req._ELFSCHA.APPORTIONPERCENTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_A.I_APPORTIONED_PERCENT);
            serv_req._ELFSCHA.INCOMEAPPORTIONEDPHILAX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_A.I_APPORTIONED_PHILA);
            serv_req._ELFSCHA.INCOMENONBUSPHILAX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_A.I_NONBUS_PHILA);
            serv_req._ELFSCHA.INCOMECURRENTYEARX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_A.I_CURRENT_YEAR);
            serv_req._ELFSCHA.LOSSCARRYFORWARDX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_A.LOSS_CARRY_FORWARD);
            serv_req._ELFSCHA.TAXABLEINCOMEX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_A.I_TAXABLE);
            serv_req._ELFSCHA.TAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_A.TAX_DUE);
            serv_req._NEW2014FIELDS._STATNETDEDUCTIONAX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_A.STAT_NET_DEDUCTION_A_X);
          

            serv_req._ELFSCHB = new RTTIE230_SrvRef._ELFSCHB();
            serv_req._ELFSCHB._NETINCOMEX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.NI_LOSS);
            serv_req._ELFSCHB._ADJNETINCOMEINTERESTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.ADJ_NI_INTEREST);
            serv_req._ELFSCHB._ADJNETINCPORTACTIVITIESX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.ADJ_NI_PORT_ACTIVITIES);
            serv_req._ELFSCHB._ADJNETINCOMEPUCICCX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.ADJ_NI_PUC_ICC);
            serv_req._ELFSCHB._ADJNETINCOMEPUBLICLAWX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.ADJ_NI_PUBLIC_LAW);
            serv_req._ELFSCHB._ADJRECEIPTSDIRX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.ADJ_RECEIPTS_DIR);
            serv_req._ELFSCHB._ADJUSTEDINCOMEX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.ADJ_INCOME);
            serv_req._ELFSCHB._ADJRECEIPTSOTHERX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.ADJ_RECEIPTS_OTHER);
            serv_req._ELFSCHB._ADJGROSSRECEIPTSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.ADJ_GROSS_RECEIPTS);
            serv_req._ELFSCHB._GROSSPERCENTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.ADJ_GROSS_PERCENT);
            serv_req._ELFSCHB._TOTALADJUSTMENTSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.ADJ_TOTAL);
            serv_req._ELFSCHB._NETINCOMEADJUSTEDX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.NI_ADJUSTED);
            serv_req._ELFSCHB._NONBUSINCOMEX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.I_NONBUS);
            serv_req._ELFSCHB._INCOMEAPPORTIONEDX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.I_APPORTIONED);
            serv_req._ELFSCHB.APPORTIONPERCENTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.I_APPORTIONED_PERCENT);
            serv_req._ELFSCHB._INCOMEAPPORTIONEDPHILAX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.I_APPORTIONED_PHILA);
            serv_req._ELFSCHB._INCOMENONBUSPHILAX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.I_NONBUS_PHILA);
            serv_req._ELFSCHB._INCOMECURRENTYEARX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.I_CURRENT_YEAR);

            serv_req._ELFSCHB._LOSSCARRYFORWARDX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.LOSS_CARRY_FORWARD);
            serv_req._ELFSCHB._INCOMETAXABLEX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.I_TAXABLE);
            serv_req._ELFSCHB._TAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.TAX_DUE);
            serv_req._NEW2014FIELDS._STATNETDEDUCTIONBX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_B.STAT_NET_DEDUCTION_B_X);

            serv_req._ELFSCHC1 = new RTTIE230_SrvRef._ELFSCHC1();
            serv_req._ELFSCHC1._PROPERTYPHILAX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_C1.TOTAL_AVG_PHILA);
            serv_req._ELFSCHC1._PROPERTYALLX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_C1.TOTAL_AVG_ALL);
            serv_req._ELFSCHC1._PROPERTYFACTORX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_C1.PROPERTY_FACTOR_PHILA);
            serv_req._ELFSCHC1._PAYROLLPHILAX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_C1.PAYROLL_PHILA);
            serv_req._ELFSCHC1._PAYROLLALLX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_C1.PAYROLL_ALL);
            serv_req._ELFSCHC1._PAYROLLFACTORX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_C1.PAYROLL_FACTOR_PHILA);
            serv_req._ELFSCHC1._RECEIPTSPHILAX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_C1.RECEIPTS_PHILA);
            serv_req._ELFSCHC1._RECEIPTSALLX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_C1.RECEIPTS_ALL);
            serv_req._ELFSCHC1._RECEIPTSFACTORX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_C1.RECEIPTS_FACTOR_PHILA);
            serv_req._ELFSCHC1._TOTALFACTORSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_C1.TOTAL_FACTORS);
            serv_req._ELFSCHC1._AVERAGEFACTORSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_C1.AVERAGE_FACTORS);


            serv_req._ELFSCHD = new RTTIE230_SrvRef._ELFSCHD();
            serv_req._ELFSCHD._GROSSSALESX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_D.GR_SALES);
            serv_req._ELFSCHD._GROSSSERVICESX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_D.GR_SERVICES);
            serv_req._ELFSCHD._GROSSRENTALSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_D.GR_RENTALS);
            serv_req._ELFSCHD._TOTALRECEIPTSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_D.GR_TOTALS);
            serv_req._ELFSCHD._LESALESOUTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_D.LE_SALES_OUT);
            serv_req._ELFSCHD._LESERVICESOUTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_D.LE_SERVICES_OUT);
            serv_req._ELFSCHD._LERENTALSOUTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_D.LE_RENTALS_OUT);
            serv_req._ELFSCHD._LEOTHERAMTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_D.LE_OTHER);
            serv_req._ELFSCHD._NETTAXABLERECEIPTSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_D.NET_TAXABLE_RECEIPTS);
            serv_req._ELFSCHD._LEMETHODRECEIPTSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_D.LE_TOTAL);
            serv_req._ELFSCHD._REGULARRECEIPTSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_D.TAXABLE_RECEIPTS);
            serv_req._ELFSCHD._TAXDUEREGULARX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_D.TAX_DUE);
            serv_req._ELFSCHD._TAXDUEALTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_D.TAX_DUE_ALT);
            serv_req._ELFSCHD._TOTALTAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_D.TOTAL_TAX_DUE);
            serv_req._NEW2014FIELDS._STATEXCLUSIONDX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_D.STAT_EXCLUSION_D_X);

            serv_req._ELFSCHE = new RTTIE230_SrvRef._ELFSCHE();
            serv_req._ELFSCHE._MALTRECEIPTSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_E.M_ALT_RECEIPTS);
            serv_req._ELFSCHE._MGOODSCOSTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_E.M_GOODS_COST);
            serv_req._ELFSCHE._MTAXBASEX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_E.M_TAX_BASE);
            serv_req._ELFSCHE._MTAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_E.M_TAX_DUE);
            serv_req._ELFSCHE._WALTRECEIPTSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_E.W_ALT_RECEIPTS);
            serv_req._ELFSCHE._WGOODSMATERIALSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_E.W_GOODS_MATERIALS);
            serv_req._ELFSCHE._WGOODSLABORX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_E.W_GOODS_LABOR);
            serv_req._ELFSCHE._WGOODSCOSTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_E.W_GOODS_COST);
            serv_req._ELFSCHE._WTAXBASEX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_E.W_TAX_BASE);
            //serv_req._ELFSCHE.ta = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_D.LE_TOTAL);
            serv_req._ELFSCHE._WTAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_E.W_TAX_DUE);
            serv_req._ELFSCHE._RALTRECEIPTSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_E.R_ALT_RECEIPTS);
            serv_req._ELFSCHE._RGOODSMATERIALSX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_E.R_GOODS_MATERIALS);
            serv_req._ELFSCHE._RGOODSLABORX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_E.R_GOODS_LABOR);
            serv_req._ELFSCHE._RGOODSCOSTX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_E.R_GOODS_COST);
            serv_req._ELFSCHE._RTAXBASEX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_E.R_TAX_BASE);
            serv_req._ELFSCHE._RTAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_E.R_TAX_DUE);
            serv_req._ELFSCHE._TOTALALTTAXDUEX = CopMvcUtil.ConvCurrencyToDigit(e.BPT_SCH_E.TOTAL_TAX_DUE);




            RTTIE230_SrvRef.RTTIE230Response response = _client.RTTIE230(serv_req);

            e = __Fill(response);

            return e;

        }
    }
}