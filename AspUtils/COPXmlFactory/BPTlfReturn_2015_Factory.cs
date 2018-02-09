using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace COPXmlFactory
{
 
    public partial class RevenueGovXMLFactory : XMLFactory
    {
        public static RTTIE030_2015.BPTlfReturn GetBPTlf_2015Return()
        {
            RTTIE030_2015.BPTlfReturn bpl = new RTTIE030_2015.BPTlfReturn();

            //Errorinfo
            bpl.ERROR_INFO = new ERROR_INFO();
            bpl.ERROR_INFO.Attr_TYPE = "COMPLEX";
            bpl.ERROR_INFO.OCCURS = "1";
            bpl.ERROR_INFO.LENGTH = "79";
            bpl.ERROR_INFO.EXPORT = "N";

            bpl.ERROR_INFO.PROGRAM = new XmlNodeEntity();
            bpl.ERROR_INFO.PROGRAM = "";
            bpl.ERROR_INFO.PROGRAM.Attr_TYPE = "A";
            bpl.ERROR_INFO.PROGRAM.LENGTH = "8";

            bpl.ERROR_INFO.ERROR = new XmlNodeEntity();
            bpl.ERROR_INFO.ERROR = "";
            bpl.ERROR_INFO.ERROR.Attr_TYPE = "N";
            bpl.ERROR_INFO.ERROR.LENGTH = "7";

            bpl.ERROR_INFO.LINE = new XmlNodeEntity();
            bpl.ERROR_INFO.LINE = "";
            bpl.ERROR_INFO.LINE.Attr_TYPE = "N";
            bpl.ERROR_INFO.LINE.LENGTH = "4";

            bpl.ERROR_INFO.MESSAGE = new XmlNodeEntity();
            bpl.ERROR_INFO.MESSAGE = "";
            bpl.ERROR_INFO.MESSAGE.Attr_TYPE = "A";
            bpl.ERROR_INFO.MESSAGE.LENGTH = "60";

            //BPT_INFO
            bpl.BPT_INFO = new RTTIE030_2015.BPT_INFO();
            bpl.BPT_INFO.Attr_TYPE = "COMPLEX";
            bpl.BPT_INFO.OCCURS = "1";
            bpl.BPT_INFO.LENGTH = "222";
            bpl.BPT_INFO.EXPORT = "Y";

            bpl.BPT_INFO.ACCOUNT_ID = new XmlNodeEntity();
            bpl.BPT_INFO.ACCOUNT_ID = "";
            bpl.BPT_INFO.ACCOUNT_ID.Attr_TYPE = "A";
            bpl.BPT_INFO.ACCOUNT_ID.LENGTH = "12";

            bpl.BPT_INFO.PERIOD = new XmlNodeEntity();
            bpl.BPT_INFO.PERIOD = "";
            bpl.BPT_INFO.PERIOD.Attr_TYPE = "D";
            bpl.BPT_INFO.PERIOD.LENGTH = "8";

            bpl.BPT_INFO.VERSION = new XmlNodeEntity();
            bpl.BPT_INFO.VERSION = "";
            bpl.BPT_INFO.VERSION.Attr_TYPE = "A";
            bpl.BPT_INFO.VERSION.LENGTH = "3";

            bpl.BPT_INFO.RETURN_STATUS = new XmlNodeEntity();
            bpl.BPT_INFO.RETURN_STATUS = "";
            bpl.BPT_INFO.RETURN_STATUS.Attr_TYPE = "A";
            bpl.BPT_INFO.RETURN_STATUS.LENGTH = "3";

            bpl.BPT_INFO.LAST_UPD_DATE = new XmlNodeEntity();
            bpl.BPT_INFO.LAST_UPD_DATE = "";
            bpl.BPT_INFO.LAST_UPD_DATE.Attr_TYPE = "D";
            bpl.BPT_INFO.LAST_UPD_DATE.LENGTH = "8";

            bpl.BPT_INFO.RECORDING_DATE = new XmlNodeEntity();
            bpl.BPT_INFO.RECORDING_DATE = "";
            bpl.BPT_INFO.RECORDING_DATE.Attr_TYPE = "D";
            bpl.BPT_INFO.RECORDING_DATE.LENGTH = "8";

            bpl.BPT_INFO.EXTENSION_DATE = new XmlNodeEntity();
            bpl.BPT_INFO.EXTENSION_DATE = "";
            bpl.BPT_INFO.EXTENSION_DATE.Attr_TYPE = "D";
            bpl.BPT_INFO.EXTENSION_DATE.LENGTH = "8";

            bpl.BPT_INFO.SEQUENCE = new XmlNodeEntity();
            bpl.BPT_INFO.SEQUENCE = "";
            bpl.BPT_INFO.SEQUENCE.Attr_TYPE = "A";
            bpl.BPT_INFO.SEQUENCE.LENGTH = "5";

            bpl.BPT_INFO.ADJUSTMENT_REF_NO = new XmlNodeEntity();
            bpl.BPT_INFO.ADJUSTMENT_REF_NO = "";
            bpl.BPT_INFO.ADJUSTMENT_REF_NO.Attr_TYPE = "A";
            bpl.BPT_INFO.ADJUSTMENT_REF_NO.LENGTH = "10";

            bpl.BPT_INFO.USER_ID = new XmlNodeEntity();
            bpl.BPT_INFO.USER_ID = "";
            bpl.BPT_INFO.USER_ID.Attr_TYPE = "A";
            bpl.BPT_INFO.USER_ID.LENGTH = "8";

            bpl.BPT_INFO.SCH_AB_TAX_RATE = new XmlNodeEntity();
            bpl.BPT_INFO.SCH_AB_TAX_RATE = "";
            bpl.BPT_INFO.SCH_AB_TAX_RATE.Attr_TYPE = "N";
            bpl.BPT_INFO.SCH_AB_TAX_RATE.LENGTH = "9";
            bpl.BPT_INFO.SCH_AB_TAX_RATE.PERCISION = "6";

            bpl.BPT_INFO.SCH_D_TAX_RATE = new XmlNodeEntity();
            bpl.BPT_INFO.SCH_D_TAX_RATE = "";
            bpl.BPT_INFO.SCH_D_TAX_RATE.Attr_TYPE = "N";
            bpl.BPT_INFO.SCH_D_TAX_RATE.LENGTH = "9";
            bpl.BPT_INFO.SCH_AB_TAX_RATE.PERCISION = "6";

            bpl.BPT_INFO.SCH_E_M_TAX_RATE = new XmlNodeEntity();
            bpl.BPT_INFO.SCH_E_M_TAX_RATE = "";
            bpl.BPT_INFO.SCH_E_M_TAX_RATE.Attr_TYPE = "N";
            bpl.BPT_INFO.SCH_E_M_TAX_RATE.LENGTH = "9";
            bpl.BPT_INFO.SCH_E_M_TAX_RATE.PERCISION = "6";

            bpl.BPT_INFO.SCH_E_W_TAX_RATE = new XmlNodeEntity();
            bpl.BPT_INFO.SCH_E_W_TAX_RATE = "";
            bpl.BPT_INFO.SCH_E_W_TAX_RATE.Attr_TYPE = "N";
            bpl.BPT_INFO.SCH_E_W_TAX_RATE.LENGTH = "9";
            bpl.BPT_INFO.SCH_E_W_TAX_RATE.PERCISION = "6";

            bpl.BPT_INFO.SCH_E_R_TAX_RATE = new XmlNodeEntity();
            bpl.BPT_INFO.SCH_E_R_TAX_RATE = "";
            bpl.BPT_INFO.SCH_E_R_TAX_RATE.Attr_TYPE = "N";
            bpl.BPT_INFO.SCH_E_R_TAX_RATE.LENGTH = "9";
            bpl.BPT_INFO.SCH_E_R_TAX_RATE.PERCISION = "6";

            bpl.BPT_INFO.LOSS_CARRY_FOWARD = new XmlNodeEntity();
            bpl.BPT_INFO.LOSS_CARRY_FOWARD = "";
            bpl.BPT_INFO.LOSS_CARRY_FOWARD.Attr_TYPE = "N";
            bpl.BPT_INFO.LOSS_CARRY_FOWARD.LENGTH = "15";

            bpl.BPT_INFO.PREPARER_NAME = new XmlNodeEntity();
            bpl.BPT_INFO.PREPARER_NAME = "";
            bpl.BPT_INFO.PREPARER_NAME.Attr_TYPE = "A";
            bpl.BPT_INFO.PREPARER_NAME.LENGTH = "40";

            bpl.BPT_INFO.PREPARER_PHONE = new XmlNodeEntity();
            bpl.BPT_INFO.PREPARER_PHONE = "";
            bpl.BPT_INFO.PREPARER_PHONE.Attr_TYPE = "P";
            bpl.BPT_INFO.PREPARER_PHONE.LENGTH = "10";

            bpl.BPT_INFO.PREPARER_PHONE_EXT = new XmlNodeEntity();
            bpl.BPT_INFO.PREPARER_PHONE_EXT = "";
            bpl.BPT_INFO.PREPARER_PHONE_EXT.Attr_TYPE = "A";
            bpl.BPT_INFO.PREPARER_PHONE_EXT.LENGTH = "5";

            bpl.BPT_INFO.PREPARER_IP_ADDRESS = new XmlNodeEntity();
            bpl.BPT_INFO.PREPARER_IP_ADDRESS = "";
            bpl.BPT_INFO.PREPARER_IP_ADDRESS.Attr_TYPE = "A";
            bpl.BPT_INFO.PREPARER_IP_ADDRESS.LENGTH = "15";

            bpl.BPT_INFO.PREPARER_EMAIL_ADDRESS = new XmlNodeEntity();
            bpl.BPT_INFO.PREPARER_EMAIL_ADDRESS = "";
            bpl.BPT_INFO.PREPARER_EMAIL_ADDRESS.Attr_TYPE = "A";
            bpl.BPT_INFO.PREPARER_EMAIL_ADDRESS.LENGTH = "60";

            bpl.BPT_INFO.PREPARER_WHO = new XmlNodeEntity();
            bpl.BPT_INFO.PREPARER_WHO = "";
            bpl.BPT_INFO.PREPARER_WHO.Attr_TYPE = "A";
            bpl.BPT_INFO.PREPARER_WHO.LENGTH = "1";

            //BPT_PG1
            bpl.BPT_PG1 = new RTTIE030_2015.BPT_PG1();
            bpl.BPT_PG1.Attr_TYPE = "COMPLEX";
            bpl.BPT_PG1.OCCURS = "1";
            bpl.BPT_PG1.LENGTH = "210";
            bpl.BPT_PG1.EXPORT = "Y";

            bpl.BPT_PG1.NET_INCOME = new XmlNodeEntity();
            bpl.BPT_PG1.NET_INCOME = "";
            bpl.BPT_PG1.NET_INCOME.Attr_TYPE = "C";
            bpl.BPT_PG1.NET_INCOME.LENGTH = "15";

            bpl.BPT_PG1.GROSS_RECEIPTS = new XmlNodeEntity();
            bpl.BPT_PG1.GROSS_RECEIPTS = "";
            bpl.BPT_PG1.GROSS_RECEIPTS.Attr_TYPE = "C";
            bpl.BPT_PG1.GROSS_RECEIPTS.LENGTH = "15";

            bpl.BPT_PG1.TAX_DUE = new XmlNodeEntity();
            bpl.BPT_PG1.TAX_DUE = "";
            bpl.BPT_PG1.TAX_DUE.Attr_TYPE = "C";
            bpl.BPT_PG1.TAX_DUE.LENGTH = "15";

            bpl.BPT_PG1.ESTIMATED_TAX = new XmlNodeEntity();
            bpl.BPT_PG1.ESTIMATED_TAX = "";
            bpl.BPT_PG1.ESTIMATED_TAX.Attr_TYPE = "C";
            bpl.BPT_PG1.ESTIMATED_TAX.LENGTH = "15";

            bpl.BPT_PG1.TOTAL_TAX = new XmlNodeEntity();
            bpl.BPT_PG1.TOTAL_TAX = "";
            bpl.BPT_PG1.TOTAL_TAX.Attr_TYPE = "C";
            bpl.BPT_PG1.TOTAL_TAX.LENGTH = "15";

            bpl.BPT_PG1.NPT_TAX_CREDIT = new XmlNodeEntity();
            bpl.BPT_PG1.NPT_TAX_CREDIT = "";
            bpl.BPT_PG1.NPT_TAX_CREDIT.Attr_TYPE = "C";
            bpl.BPT_PG1.NPT_TAX_CREDIT.LENGTH = "15";

            bpl.BPT_PG1.BPT_TAX_CREDIT = new XmlNodeEntity();
            bpl.BPT_PG1.BPT_TAX_CREDIT = "";
            bpl.BPT_PG1.BPT_TAX_CREDIT.Attr_TYPE = "C";
            bpl.BPT_PG1.BPT_TAX_CREDIT.LENGTH = "15";

            bpl.BPT_PG1.TOTAL_PAY_CREDITS = new XmlNodeEntity();
            bpl.BPT_PG1.TOTAL_PAY_CREDITS = "";
            bpl.BPT_PG1.TOTAL_PAY_CREDITS.Attr_TYPE = "C";
            bpl.BPT_PG1.TOTAL_PAY_CREDITS.LENGTH = "15";

            bpl.BPT_PG1.NET_TAX = new XmlNodeEntity();
            bpl.BPT_PG1.NET_TAX = "";
            bpl.BPT_PG1.NET_TAX.Attr_TYPE = "C";
            bpl.BPT_PG1.NET_TAX.LENGTH = "15";

            bpl.BPT_PG1.INTEREST_PENALTY = new XmlNodeEntity();
            bpl.BPT_PG1.INTEREST_PENALTY = "";
            bpl.BPT_PG1.INTEREST_PENALTY.Attr_TYPE = "C";
            bpl.BPT_PG1.INTEREST_PENALTY.LENGTH = "15";

            bpl.BPT_PG1.AMOUNT_OWED = new XmlNodeEntity();
            bpl.BPT_PG1.AMOUNT_OWED = "";
            bpl.BPT_PG1.AMOUNT_OWED.Attr_TYPE = "C";
            bpl.BPT_PG1.AMOUNT_OWED.LENGTH = "15";

            bpl.BPT_PG1.REFUND = new XmlNodeEntity();
            bpl.BPT_PG1.REFUND = "";
            bpl.BPT_PG1.REFUND.Attr_TYPE = "C";
            bpl.BPT_PG1.REFUND.LENGTH = "15";

            bpl.BPT_PG1.NPT_OVERPAY = new XmlNodeEntity();
            bpl.BPT_PG1.NPT_OVERPAY = "";
            bpl.BPT_PG1.NPT_OVERPAY.Attr_TYPE = "C";
            bpl.BPT_PG1.NPT_OVERPAY.LENGTH = "15";

            bpl.BPT_PG1.BPT_OVERPAY = new XmlNodeEntity();
            bpl.BPT_PG1.BPT_OVERPAY = "";
            bpl.BPT_PG1.BPT_OVERPAY.Attr_TYPE = "C";
            bpl.BPT_PG1.BPT_OVERPAY.LENGTH = "15";

            //BPT_SCH_A
            bpl.BPT_SCH_A = new RTTIE030_2015.BPT_SCH_A();
            bpl.BPT_SCH_A.Attr_TYPE = "COMPLEX";
            bpl.BPT_SCH_A.OCCURS = "1";
            bpl.BPT_SCH_A.LENGTH = "180";
            bpl.BPT_SCH_A.EXPORT = "Y";

            bpl.BPT_SCH_A.NI_LOSS = new XmlNodeEntity();
            bpl.BPT_SCH_A.NI_LOSS = "";
            bpl.BPT_SCH_A.NI_LOSS.Attr_TYPE = "C";
            bpl.BPT_SCH_A.NI_LOSS.LENGTH = "15";

            bpl.BPT_SCH_A.NI_PORT_ACTIVITIES = new XmlNodeEntity();
            bpl.BPT_SCH_A.NI_PORT_ACTIVITIES = "";
            bpl.BPT_SCH_A.NI_PORT_ACTIVITIES.Attr_TYPE = "C";
            bpl.BPT_SCH_A.NI_PORT_ACTIVITIES.LENGTH = "15";

            bpl.BPT_SCH_A.NI_PUC_ICC = new XmlNodeEntity();
            bpl.BPT_SCH_A.NI_PUC_ICC = "";
            bpl.BPT_SCH_A.NI_PUC_ICC.Attr_TYPE = "C";
            bpl.BPT_SCH_A.NI_PUC_ICC.LENGTH = "15";

            bpl.BPT_SCH_A.NI_PUBLIC_LAW = new XmlNodeEntity();
            bpl.BPT_SCH_A.NI_PUBLIC_LAW = "";
            bpl.BPT_SCH_A.NI_PUBLIC_LAW.Attr_TYPE = "C";
            bpl.BPT_SCH_A.NI_PUBLIC_LAW.LENGTH = "15";

            bpl.BPT_SCH_A.I_APPORTIONED = new XmlNodeEntity();
            bpl.BPT_SCH_A.I_APPORTIONED = "";
            bpl.BPT_SCH_A.I_APPORTIONED.Attr_TYPE = "C";
            bpl.BPT_SCH_A.I_APPORTIONED.LENGTH = "15";

            bpl.BPT_SCH_A.I_APPORTIONED_PERCENT = new XmlNodeEntity();
            bpl.BPT_SCH_A.I_APPORTIONED_PERCENT = "";
            bpl.BPT_SCH_A.I_APPORTIONED_PERCENT.Attr_TYPE = "C";
            bpl.BPT_SCH_A.I_APPORTIONED_PERCENT.LENGTH = "15";

            bpl.BPT_SCH_A.I_APPORTIONED_PHILA = new XmlNodeEntity();
            bpl.BPT_SCH_A.I_APPORTIONED_PHILA = "";
            bpl.BPT_SCH_A.I_APPORTIONED_PHILA.Attr_TYPE = "C";
            bpl.BPT_SCH_A.I_APPORTIONED_PHILA.LENGTH = "15";

            bpl.BPT_SCH_A.I_NONBUS_PHILA = new XmlNodeEntity();
            bpl.BPT_SCH_A.I_NONBUS_PHILA = "";
            bpl.BPT_SCH_A.I_NONBUS_PHILA.Attr_TYPE = "C";
            bpl.BPT_SCH_A.I_NONBUS_PHILA.LENGTH = "15";

            bpl.BPT_SCH_A.I_CURRENT_YEAR = new XmlNodeEntity();
            bpl.BPT_SCH_A.I_CURRENT_YEAR = "";
            bpl.BPT_SCH_A.I_CURRENT_YEAR.Attr_TYPE = "C";
            bpl.BPT_SCH_A.I_CURRENT_YEAR.LENGTH = "15";

            bpl.BPT_SCH_A.LOSS_CARRY_FORWARD = new XmlNodeEntity();
            bpl.BPT_SCH_A.LOSS_CARRY_FORWARD = "";
            bpl.BPT_SCH_A.LOSS_CARRY_FORWARD.Attr_TYPE = "C";
            bpl.BPT_SCH_A.LOSS_CARRY_FORWARD.LENGTH = "15";

            bpl.BPT_SCH_A.I_TAXABLE = new XmlNodeEntity();
            bpl.BPT_SCH_A.I_TAXABLE = "";
            bpl.BPT_SCH_A.I_TAXABLE.Attr_TYPE = "C";
            bpl.BPT_SCH_A.I_TAXABLE.LENGTH = "15";

            bpl.BPT_SCH_A.TAX_DUE = new XmlNodeEntity();
            bpl.BPT_SCH_A.TAX_DUE = "";
            bpl.BPT_SCH_A.TAX_DUE.Attr_TYPE = "C";
            bpl.BPT_SCH_A.TAX_DUE.LENGTH = "15";

            bpl.BPT_SCH_A.STAT_NET_DEDUCTION_A_X = new XmlNodeEntity();
            bpl.BPT_SCH_A.STAT_NET_DEDUCTION_A_X = "";
            bpl.BPT_SCH_A.STAT_NET_DEDUCTION_A_X.Attr_TYPE = "N";
            bpl.BPT_SCH_A.STAT_NET_DEDUCTION_A_X.LENGTH = "15"; //binoy

            //BPT_SCH_B
            bpl.BPT_SCH_B = new RTTIE030_2015.BPT_SCH_B();
            bpl.BPT_SCH_B.Attr_TYPE = "COMPLEX";
            bpl.BPT_SCH_B.OCCURS = "1";
            bpl.BPT_SCH_B.LENGTH = "315";
            bpl.BPT_SCH_B.EXPORT = "Y";

            bpl.BPT_SCH_B.NI_LOSS = new XmlNodeEntity();
            bpl.BPT_SCH_B.NI_LOSS = "";
            bpl.BPT_SCH_B.NI_LOSS.Attr_TYPE = "C";
            bpl.BPT_SCH_B.NI_LOSS.LENGTH = "15";

            bpl.BPT_SCH_B.ADJ_NI_INTEREST = new XmlNodeEntity();
            bpl.BPT_SCH_B.ADJ_NI_INTEREST = "";
            bpl.BPT_SCH_B.ADJ_NI_INTEREST.Attr_TYPE = "C";
            bpl.BPT_SCH_B.ADJ_NI_INTEREST.LENGTH = "15";

            bpl.BPT_SCH_B.ADJ_NI_PORT_ACTIVITIES = new XmlNodeEntity();
            bpl.BPT_SCH_B.ADJ_NI_PORT_ACTIVITIES = "";
            bpl.BPT_SCH_B.ADJ_NI_PORT_ACTIVITIES.Attr_TYPE = "C";
            bpl.BPT_SCH_B.ADJ_NI_PORT_ACTIVITIES.LENGTH = "15";

            bpl.BPT_SCH_B.ADJ_NI_PUC_ICC = new XmlNodeEntity();
            bpl.BPT_SCH_B.ADJ_NI_PUC_ICC = "";
            bpl.BPT_SCH_B.ADJ_NI_PUC_ICC.Attr_TYPE = "C";
            bpl.BPT_SCH_B.ADJ_NI_PUC_ICC.LENGTH = "15";

            bpl.BPT_SCH_B.ADJ_NI_PUBLIC_LAW = new XmlNodeEntity();
            bpl.BPT_SCH_B.ADJ_NI_PUBLIC_LAW = "";
            bpl.BPT_SCH_B.ADJ_NI_PUBLIC_LAW.Attr_TYPE = "C";
            bpl.BPT_SCH_B.ADJ_NI_PUBLIC_LAW.LENGTH = "15";

            bpl.BPT_SCH_B.ADJ_RECEIPTS_DIR = new XmlNodeEntity();
            bpl.BPT_SCH_B.ADJ_RECEIPTS_DIR = "";
            bpl.BPT_SCH_B.ADJ_RECEIPTS_DIR.Attr_TYPE = "C";
            bpl.BPT_SCH_B.ADJ_RECEIPTS_DIR.LENGTH = "15";

            bpl.BPT_SCH_B.ADJ_INCOME = new XmlNodeEntity();
            bpl.BPT_SCH_B.ADJ_INCOME = "";
            bpl.BPT_SCH_B.ADJ_INCOME.Attr_TYPE = "C";
            bpl.BPT_SCH_B.ADJ_INCOME.LENGTH = "15";

            bpl.BPT_SCH_B.ADJ_RECEIPTS_OTHER = new XmlNodeEntity();
            bpl.BPT_SCH_B.ADJ_RECEIPTS_OTHER = "";
            bpl.BPT_SCH_B.ADJ_RECEIPTS_OTHER.Attr_TYPE = "C";
            bpl.BPT_SCH_B.ADJ_RECEIPTS_OTHER.LENGTH = "15";

            bpl.BPT_SCH_B.ADJ_GROSS_RECEIPTS = new XmlNodeEntity();
            bpl.BPT_SCH_B.ADJ_GROSS_RECEIPTS = "";
            bpl.BPT_SCH_B.ADJ_GROSS_RECEIPTS.Attr_TYPE = "C";
            bpl.BPT_SCH_B.ADJ_GROSS_RECEIPTS.LENGTH = "15";
            bpl.BPT_SCH_B.ADJ_GROSS_RECEIPTS.PERCISION = "8";

            bpl.BPT_SCH_B.ADJ_GROSS_PERCENT = new XmlNodeEntity();
            bpl.BPT_SCH_B.ADJ_GROSS_PERCENT = "";
            bpl.BPT_SCH_B.ADJ_GROSS_PERCENT.Attr_TYPE = "C";
            bpl.BPT_SCH_B.ADJ_GROSS_PERCENT.LENGTH = "15";

            bpl.BPT_SCH_B.ADJ_TOTAL = new XmlNodeEntity();
            bpl.BPT_SCH_B.ADJ_TOTAL = "";
            bpl.BPT_SCH_B.ADJ_TOTAL.Attr_TYPE = "C";
            bpl.BPT_SCH_B.ADJ_TOTAL.LENGTH = "15";

            bpl.BPT_SCH_B.NI_ADJUSTED = new XmlNodeEntity();
            bpl.BPT_SCH_B.NI_ADJUSTED = "";
            bpl.BPT_SCH_B.NI_ADJUSTED.Attr_TYPE = "C";
            bpl.BPT_SCH_B.NI_ADJUSTED.LENGTH = "15";

            bpl.BPT_SCH_B.I_NONBUS = new XmlNodeEntity();
            bpl.BPT_SCH_B.I_NONBUS = "";
            bpl.BPT_SCH_B.I_NONBUS.Attr_TYPE = "C";
            bpl.BPT_SCH_B.I_NONBUS.LENGTH = "15";

            bpl.BPT_SCH_B.I_APPORTIONED = new XmlNodeEntity();
            bpl.BPT_SCH_B.I_APPORTIONED = "";
            bpl.BPT_SCH_B.I_APPORTIONED.Attr_TYPE = "C";
            bpl.BPT_SCH_B.I_APPORTIONED.LENGTH = "15";

            bpl.BPT_SCH_B.I_APPORTIONED_PERCENT = new XmlNodeEntity();
            bpl.BPT_SCH_B.I_APPORTIONED_PERCENT = "";
            bpl.BPT_SCH_B.I_APPORTIONED_PERCENT.Attr_TYPE = "C";
            bpl.BPT_SCH_B.I_APPORTIONED_PERCENT.LENGTH = "15";
            bpl.BPT_SCH_B.I_APPORTIONED_PERCENT.PERCISION = "8";

            bpl.BPT_SCH_B.I_APPORTIONED_PHILA = new XmlNodeEntity();
            bpl.BPT_SCH_B.I_APPORTIONED_PHILA = "";
            bpl.BPT_SCH_B.I_APPORTIONED_PHILA.Attr_TYPE = "C";
            bpl.BPT_SCH_B.I_APPORTIONED_PHILA.LENGTH = "15";

            bpl.BPT_SCH_B.I_NONBUS_PHILA = new XmlNodeEntity();
            bpl.BPT_SCH_B.I_NONBUS_PHILA = "";
            bpl.BPT_SCH_B.I_NONBUS_PHILA.Attr_TYPE = "C";
            bpl.BPT_SCH_B.I_NONBUS_PHILA.LENGTH = "15";

            bpl.BPT_SCH_B.I_CURRENT_YEAR = new XmlNodeEntity();
            bpl.BPT_SCH_B.I_CURRENT_YEAR = "";
            bpl.BPT_SCH_B.I_CURRENT_YEAR.Attr_TYPE = "C";
            bpl.BPT_SCH_B.I_CURRENT_YEAR.LENGTH = "15";

            bpl.BPT_SCH_B.LOSS_CARRY_FORWARD = new XmlNodeEntity();
            bpl.BPT_SCH_B.LOSS_CARRY_FORWARD = "";
            bpl.BPT_SCH_B.LOSS_CARRY_FORWARD.Attr_TYPE = "C";
            bpl.BPT_SCH_B.LOSS_CARRY_FORWARD.LENGTH = "15";

            bpl.BPT_SCH_B.I_TAXABLE = new XmlNodeEntity();
            bpl.BPT_SCH_B.I_TAXABLE = "";
            bpl.BPT_SCH_B.I_TAXABLE.Attr_TYPE = "C";
            bpl.BPT_SCH_B.I_TAXABLE.LENGTH = "15";

            bpl.BPT_SCH_B.TAX_DUE = new XmlNodeEntity();
            bpl.BPT_SCH_B.TAX_DUE = "";
            bpl.BPT_SCH_B.TAX_DUE.Attr_TYPE = "C";
            bpl.BPT_SCH_B.TAX_DUE.LENGTH = "15";

            bpl.BPT_SCH_B.STAT_NET_DEDUCTION_B_X = new XmlNodeEntity();
            bpl.BPT_SCH_B.STAT_NET_DEDUCTION_B_X = "";
            bpl.BPT_SCH_B.STAT_NET_DEDUCTION_B_X.Attr_TYPE = "N";
            bpl.BPT_SCH_B.STAT_NET_DEDUCTION_B_X.LENGTH = "15";

            //BPT_SCH_C1
            bpl.BPT_SCH_C1 = new RTTIE030_2015.BPT_SCH_C1();
            bpl.BPT_SCH_C1.Attr_TYPE = "COMPLEX";
            bpl.BPT_SCH_C1.OCCURS = "1";
            bpl.BPT_SCH_C1.LENGTH = "165";
            bpl.BPT_SCH_C1.EXPORT = "Y";

            bpl.BPT_SCH_C1.TOTAL_AVG_PHILA = new XmlNodeEntity();
            bpl.BPT_SCH_C1.TOTAL_AVG_PHILA = "";
            bpl.BPT_SCH_C1.TOTAL_AVG_PHILA.Attr_TYPE = "C";
            bpl.BPT_SCH_C1.TOTAL_AVG_PHILA.LENGTH = "15";

            bpl.BPT_SCH_C1.TOTAL_AVG_ALL = new XmlNodeEntity();
            bpl.BPT_SCH_C1.TOTAL_AVG_ALL = "";
            bpl.BPT_SCH_C1.TOTAL_AVG_ALL.Attr_TYPE = "C";
            bpl.BPT_SCH_C1.TOTAL_AVG_ALL.LENGTH = "15";

            bpl.BPT_SCH_C1.PROPERTY_FACTOR_PHILA = new XmlNodeEntity();
            bpl.BPT_SCH_C1.PROPERTY_FACTOR_PHILA = "";
            bpl.BPT_SCH_C1.PROPERTY_FACTOR_PHILA.Attr_TYPE = "C";
            bpl.BPT_SCH_C1.PROPERTY_FACTOR_PHILA.LENGTH = "15";
            bpl.BPT_SCH_C1.PROPERTY_FACTOR_PHILA.LENGTH = "15";


            bpl.BPT_SCH_C1.PAYROLL_PHILA = new XmlNodeEntity();
            bpl.BPT_SCH_C1.PAYROLL_PHILA = "";
            bpl.BPT_SCH_C1.PAYROLL_PHILA.Attr_TYPE = "C";
            bpl.BPT_SCH_C1.PAYROLL_PHILA.LENGTH = "15";

            bpl.BPT_SCH_C1.PAYROLL_ALL = new XmlNodeEntity();
            bpl.BPT_SCH_C1.PAYROLL_ALL = "";
            bpl.BPT_SCH_C1.PAYROLL_ALL.Attr_TYPE = "C";
            bpl.BPT_SCH_C1.PAYROLL_ALL.LENGTH = "15";

            bpl.BPT_SCH_C1.PAYROLL_FACTOR_PHILA = new XmlNodeEntity();
            bpl.BPT_SCH_C1.PAYROLL_FACTOR_PHILA = "";
            bpl.BPT_SCH_C1.PAYROLL_FACTOR_PHILA.Attr_TYPE = "C";
            bpl.BPT_SCH_C1.PAYROLL_FACTOR_PHILA.LENGTH = "15";
            bpl.BPT_SCH_C1.PAYROLL_FACTOR_PHILA.PERCISION = "6";


            bpl.BPT_SCH_C1.RECEIPTS_PHILA = new XmlNodeEntity();
            bpl.BPT_SCH_C1.RECEIPTS_PHILA = "";
            bpl.BPT_SCH_C1.RECEIPTS_PHILA.Attr_TYPE = "C";
            bpl.BPT_SCH_C1.RECEIPTS_PHILA.LENGTH = "15";

            bpl.BPT_SCH_C1.RECEIPTS_ALL = new XmlNodeEntity();
            bpl.BPT_SCH_C1.RECEIPTS_ALL = "";
            bpl.BPT_SCH_C1.RECEIPTS_ALL.Attr_TYPE = "C";
            bpl.BPT_SCH_C1.RECEIPTS_ALL.LENGTH = "15";

            bpl.BPT_SCH_C1.RECEIPTS_FACTOR_PHILA = new XmlNodeEntity();
            bpl.BPT_SCH_C1.RECEIPTS_FACTOR_PHILA = "";
            bpl.BPT_SCH_C1.RECEIPTS_FACTOR_PHILA.Attr_TYPE = "C";
            bpl.BPT_SCH_C1.RECEIPTS_FACTOR_PHILA.LENGTH = "15";
            bpl.BPT_SCH_C1.RECEIPTS_FACTOR_PHILA.PERCISION = "6";

            bpl.BPT_SCH_C1.TOTAL_FACTORS = new XmlNodeEntity();
            bpl.BPT_SCH_C1.TOTAL_FACTORS = "";
            bpl.BPT_SCH_C1.TOTAL_FACTORS.Attr_TYPE = "N";
            bpl.BPT_SCH_C1.TOTAL_FACTORS.LENGTH = "15";
            bpl.BPT_SCH_C1.TOTAL_FACTORS.PERCISION = "6";

            bpl.BPT_SCH_C1.AVERAGE_FACTORS = new XmlNodeEntity();
            bpl.BPT_SCH_C1.AVERAGE_FACTORS = "";
            bpl.BPT_SCH_C1.AVERAGE_FACTORS.Attr_TYPE = "N";
            bpl.BPT_SCH_C1.AVERAGE_FACTORS.LENGTH = "15";
            bpl.BPT_SCH_C1.AVERAGE_FACTORS.PERCISION = "6";

            //BPT_SCH_D
            bpl.BPT_SCH_D = new RTTIE030_2015.BPT_SCH_D();
            bpl.BPT_SCH_D.Attr_TYPE = "COMPLEX";
            bpl.BPT_SCH_D.OCCURS = "1";
            bpl.BPT_SCH_D.LENGTH = "210";
            bpl.BPT_SCH_D.EXPORT = "Y";

            bpl.BPT_SCH_D.GR_SALES = new XmlNodeEntity();
            bpl.BPT_SCH_D.GR_SALES = "";
            bpl.BPT_SCH_D.GR_SALES.Attr_TYPE = "C";
            bpl.BPT_SCH_D.GR_SALES.LENGTH = "15";

            bpl.BPT_SCH_D.GR_SERVICES = new XmlNodeEntity();
            bpl.BPT_SCH_D.GR_SERVICES = "";
            bpl.BPT_SCH_D.GR_SERVICES.Attr_TYPE = "C";
            bpl.BPT_SCH_D.GR_SERVICES.LENGTH = "15";

            bpl.BPT_SCH_D.GR_RENTALS = new XmlNodeEntity();
            bpl.BPT_SCH_D.GR_RENTALS = "";
            bpl.BPT_SCH_D.GR_RENTALS.Attr_TYPE = "C";
            bpl.BPT_SCH_D.GR_RENTALS.LENGTH = "15";

            bpl.BPT_SCH_D.GR_TOTALS = new XmlNodeEntity();
            bpl.BPT_SCH_D.GR_TOTALS = "";
            bpl.BPT_SCH_D.GR_TOTALS.Attr_TYPE = "C";
            bpl.BPT_SCH_D.GR_TOTALS.LENGTH = "15";

            bpl.BPT_SCH_D.LE_SALES_OUT = new XmlNodeEntity();
            bpl.BPT_SCH_D.LE_SALES_OUT = "";
            bpl.BPT_SCH_D.LE_SALES_OUT.Attr_TYPE = "C";
            bpl.BPT_SCH_D.LE_SALES_OUT.LENGTH = "15";

            bpl.BPT_SCH_D.LE_SERVICES_OUT = new XmlNodeEntity();
            bpl.BPT_SCH_D.LE_SERVICES_OUT = "";
            bpl.BPT_SCH_D.LE_SERVICES_OUT.Attr_TYPE = "C";
            bpl.BPT_SCH_D.LE_SERVICES_OUT.LENGTH = "15";

            bpl.BPT_SCH_D.LE_RENTALS_OUT = new XmlNodeEntity();
            bpl.BPT_SCH_D.LE_RENTALS_OUT = "";
            bpl.BPT_SCH_D.LE_RENTALS_OUT.Attr_TYPE = "C";
            bpl.BPT_SCH_D.LE_RENTALS_OUT.LENGTH = "15";

            bpl.BPT_SCH_D.LE_OTHER = new XmlNodeEntity();
            bpl.BPT_SCH_D.LE_OTHER = "";
            bpl.BPT_SCH_D.LE_OTHER.Attr_TYPE = "C";
            bpl.BPT_SCH_D.LE_OTHER.LENGTH = "15";

            bpl.BPT_SCH_D.NET_TAXABLE_RECEIPTS = new XmlNodeEntity();
            bpl.BPT_SCH_D.NET_TAXABLE_RECEIPTS = "";
            bpl.BPT_SCH_D.NET_TAXABLE_RECEIPTS.Attr_TYPE = "C";
            bpl.BPT_SCH_D.NET_TAXABLE_RECEIPTS.LENGTH = "15";

            bpl.BPT_SCH_D.LE_TOTAL = new XmlNodeEntity();
            bpl.BPT_SCH_D.LE_TOTAL = "";
            bpl.BPT_SCH_D.LE_TOTAL.Attr_TYPE = "C";
            bpl.BPT_SCH_D.LE_TOTAL.LENGTH = "15";

            bpl.BPT_SCH_D.TAXABLE_RECEIPTS = new XmlNodeEntity();
            bpl.BPT_SCH_D.TAXABLE_RECEIPTS = "";
            bpl.BPT_SCH_D.TAXABLE_RECEIPTS.Attr_TYPE = "C";
            bpl.BPT_SCH_D.TAXABLE_RECEIPTS.LENGTH = "15";

            bpl.BPT_SCH_D.TAX_DUE = new XmlNodeEntity();
            bpl.BPT_SCH_D.TAX_DUE = "";
            bpl.BPT_SCH_D.TAX_DUE.Attr_TYPE = "C";
            bpl.BPT_SCH_D.TAX_DUE.LENGTH = "15";

            bpl.BPT_SCH_D.TAX_DUE_ALT = new XmlNodeEntity();
            bpl.BPT_SCH_D.TAX_DUE_ALT = "";
            bpl.BPT_SCH_D.TAX_DUE_ALT.Attr_TYPE = "C";
            bpl.BPT_SCH_D.TAX_DUE_ALT.LENGTH = "15";

            bpl.BPT_SCH_D.TOTAL_TAX_DUE = new XmlNodeEntity();
            bpl.BPT_SCH_D.TOTAL_TAX_DUE = "";
            bpl.BPT_SCH_D.TOTAL_TAX_DUE.Attr_TYPE = "C";
            bpl.BPT_SCH_D.TOTAL_TAX_DUE.LENGTH = "15";

            bpl.BPT_SCH_D.STAT_EXCLUSION_D_X = new XmlNodeEntity();
            bpl.BPT_SCH_D.STAT_EXCLUSION_D_X = "";
            bpl.BPT_SCH_D.STAT_EXCLUSION_D_X.Attr_TYPE = "N";
            bpl.BPT_SCH_D.STAT_EXCLUSION_D_X.LENGTH = "15";
            
            //BPT_SCH_E
            bpl.BPT_SCH_E = new RTTIE030_2015.BPT_SCH_E();
            bpl.BPT_SCH_E.Attr_TYPE = "COMPLEX";
            bpl.BPT_SCH_E.OCCURS = "1";
            bpl.BPT_SCH_E.LENGTH = "255";
            bpl.BPT_SCH_E.EXPORT = "Y";

            bpl.BPT_SCH_E.M_ALT_RECEIPTS = new XmlNodeEntity();
            bpl.BPT_SCH_E.M_ALT_RECEIPTS = "";
            bpl.BPT_SCH_E.M_ALT_RECEIPTS.Attr_TYPE = "C";
            bpl.BPT_SCH_E.M_ALT_RECEIPTS.LENGTH = "15";

            bpl.BPT_SCH_E.M_GOODS_COST = new XmlNodeEntity();
            bpl.BPT_SCH_E.M_GOODS_COST = "";
            bpl.BPT_SCH_E.M_GOODS_COST.Attr_TYPE = "C";
            bpl.BPT_SCH_E.M_GOODS_COST.LENGTH = "15";

            bpl.BPT_SCH_E.M_TAX_BASE = new XmlNodeEntity();
            bpl.BPT_SCH_E.M_TAX_BASE = "";
            bpl.BPT_SCH_E.M_TAX_BASE.Attr_TYPE = "C";
            bpl.BPT_SCH_E.M_TAX_BASE.LENGTH = "15";

            bpl.BPT_SCH_E.M_TAX_DUE = new XmlNodeEntity();
            bpl.BPT_SCH_E.M_TAX_DUE = "";
            bpl.BPT_SCH_E.M_TAX_DUE.Attr_TYPE = "C";
            bpl.BPT_SCH_E.M_TAX_DUE.LENGTH = "15";

            bpl.BPT_SCH_E.W_ALT_RECEIPTS = new XmlNodeEntity();
            bpl.BPT_SCH_E.W_ALT_RECEIPTS = "";
            bpl.BPT_SCH_E.W_ALT_RECEIPTS.Attr_TYPE = "C";
            bpl.BPT_SCH_E.W_ALT_RECEIPTS.LENGTH = "15";

            bpl.BPT_SCH_E.W_GOODS_MATERIALS = new XmlNodeEntity();
            bpl.BPT_SCH_E.W_GOODS_MATERIALS = "";
            bpl.BPT_SCH_E.W_GOODS_MATERIALS.Attr_TYPE = "C";
            bpl.BPT_SCH_E.W_GOODS_MATERIALS.LENGTH = "15";

            bpl.BPT_SCH_E.W_GOODS_LABOR = new XmlNodeEntity();
            bpl.BPT_SCH_E.W_GOODS_LABOR = "";
            bpl.BPT_SCH_E.W_GOODS_LABOR.Attr_TYPE = "C";
            bpl.BPT_SCH_E.W_GOODS_LABOR.LENGTH = "15";

            bpl.BPT_SCH_E.W_GOODS_COST = new XmlNodeEntity();
            bpl.BPT_SCH_E.W_GOODS_COST = "";
            bpl.BPT_SCH_E.W_GOODS_COST.Attr_TYPE = "C";
            bpl.BPT_SCH_E.W_GOODS_COST.LENGTH = "15";

            bpl.BPT_SCH_E.W_TAX_BASE = new XmlNodeEntity();
            bpl.BPT_SCH_E.W_TAX_BASE = "";
            bpl.BPT_SCH_E.W_TAX_BASE.Attr_TYPE = "C";
            bpl.BPT_SCH_E.W_TAX_BASE.LENGTH = "15";

            bpl.BPT_SCH_E.W_TAX_DUE = new XmlNodeEntity();
            bpl.BPT_SCH_E.W_TAX_DUE = "";
            bpl.BPT_SCH_E.W_TAX_DUE.Attr_TYPE = "C";
            bpl.BPT_SCH_E.W_TAX_DUE.LENGTH = "15";

            bpl.BPT_SCH_E.R_ALT_RECEIPTS = new XmlNodeEntity();
            bpl.BPT_SCH_E.R_ALT_RECEIPTS = "";
            bpl.BPT_SCH_E.R_ALT_RECEIPTS.Attr_TYPE = "C";
            bpl.BPT_SCH_E.R_ALT_RECEIPTS.LENGTH = "15";

            bpl.BPT_SCH_E.R_GOODS_MATERIALS = new XmlNodeEntity();
            bpl.BPT_SCH_E.R_GOODS_MATERIALS = "";
            bpl.BPT_SCH_E.R_GOODS_MATERIALS.Attr_TYPE = "C";
            bpl.BPT_SCH_E.R_GOODS_MATERIALS.LENGTH = "15";

            bpl.BPT_SCH_E.R_GOODS_LABOR = new XmlNodeEntity();
            bpl.BPT_SCH_E.R_GOODS_LABOR = "";
            bpl.BPT_SCH_E.R_GOODS_LABOR.Attr_TYPE = "C";
            bpl.BPT_SCH_E.R_GOODS_LABOR.LENGTH = "15";

            bpl.BPT_SCH_E.R_GOODS_COST = new XmlNodeEntity();
            bpl.BPT_SCH_E.R_GOODS_COST = "";
            bpl.BPT_SCH_E.R_GOODS_COST.Attr_TYPE = "C";
            bpl.BPT_SCH_E.R_GOODS_COST.LENGTH = "15";

            bpl.BPT_SCH_E.R_TAX_BASE = new XmlNodeEntity();
            bpl.BPT_SCH_E.R_TAX_BASE = "";
            bpl.BPT_SCH_E.R_TAX_BASE.Attr_TYPE = "C";
            bpl.BPT_SCH_E.R_TAX_BASE.LENGTH = "15";

            bpl.BPT_SCH_E.R_TAX_DUE = new XmlNodeEntity();
            bpl.BPT_SCH_E.R_TAX_DUE = "";
            bpl.BPT_SCH_E.R_TAX_DUE.Attr_TYPE = "C";
            bpl.BPT_SCH_E.R_TAX_DUE.LENGTH = "15";

            bpl.BPT_SCH_E.TOTAL_TAX_DUE = new XmlNodeEntity();
            bpl.BPT_SCH_E.TOTAL_TAX_DUE = "";
            bpl.BPT_SCH_E.TOTAL_TAX_DUE.Attr_TYPE = "C";
            bpl.BPT_SCH_E.TOTAL_TAX_DUE.LENGTH = "15";

            //BPT_TBL_C1
            bpl.BPT_TBL_C1 = new RTTIE030_2015.BPT_TBL_C1();
            bpl.BPT_TBL_C1.Attr_TYPE = "COMPLEX";
            bpl.BPT_TBL_C1.OCCURS = "1";
            bpl.BPT_TBL_C1.LENGTH = "315";
            bpl.BPT_TBL_C1.EXPORT = "Y";

            bpl.BPT_TBL_C1.INVENTORIES_PHILA = new XmlNodeEntity();
            bpl.BPT_TBL_C1.INVENTORIES_PHILA = "";
            bpl.BPT_TBL_C1.INVENTORIES_PHILA.Attr_TYPE = "C";
            bpl.BPT_TBL_C1.INVENTORIES_PHILA.LENGTH = "15";

            bpl.BPT_TBL_C1.INVENTORIES_ALL = new XmlNodeEntity();
            bpl.BPT_TBL_C1.INVENTORIES_ALL = "";
            bpl.BPT_TBL_C1.INVENTORIES_ALL.Attr_TYPE = "C";
            bpl.BPT_TBL_C1.INVENTORIES_ALL.LENGTH = "15";

            bpl.BPT_TBL_C1.LAND_BLDGS_PHILA = new XmlNodeEntity();
            bpl.BPT_TBL_C1.LAND_BLDGS_PHILA = "";
            bpl.BPT_TBL_C1.LAND_BLDGS_PHILA.Attr_TYPE = "C";
            bpl.BPT_TBL_C1.LAND_BLDGS_PHILA.LENGTH = "15";

            bpl.BPT_TBL_C1.LAND_BLDGS_ALL = new XmlNodeEntity();
            bpl.BPT_TBL_C1.LAND_BLDGS_ALL = "";
            bpl.BPT_TBL_C1.LAND_BLDGS_ALL.Attr_TYPE = "C";
            bpl.BPT_TBL_C1.LAND_BLDGS_ALL.LENGTH = "15";

            bpl.BPT_TBL_C1.MACHINERY_PHILA = new XmlNodeEntity();
            bpl.BPT_TBL_C1.MACHINERY_PHILA = "";
            bpl.BPT_TBL_C1.MACHINERY_PHILA.Attr_TYPE = "C";
            bpl.BPT_TBL_C1.MACHINERY_PHILA.LENGTH = "15";

            bpl.BPT_TBL_C1.MACHINERY_ALL = new XmlNodeEntity();
            bpl.BPT_TBL_C1.MACHINERY_ALL = "";
            bpl.BPT_TBL_C1.MACHINERY_ALL.Attr_TYPE = "C";
            bpl.BPT_TBL_C1.MACHINERY_ALL.LENGTH = "15";

            bpl.BPT_TBL_C1.OTHER_ASSESTS_PHILA = new XmlNodeEntity();
            bpl.BPT_TBL_C1.OTHER_ASSESTS_PHILA = "";
            bpl.BPT_TBL_C1.OTHER_ASSESTS_PHILA.Attr_TYPE = "C";
            bpl.BPT_TBL_C1.OTHER_ASSESTS_PHILA.LENGTH = "15";

            bpl.BPT_TBL_C1.RENTED_PROPERTY_PHILA = new XmlNodeEntity();
            bpl.BPT_TBL_C1.RENTED_PROPERTY_PHILA = "";
            bpl.BPT_TBL_C1.RENTED_PROPERTY_PHILA.Attr_TYPE = "C";
            bpl.BPT_TBL_C1.RENTED_PROPERTY_PHILA.LENGTH = "15";

            bpl.BPT_TBL_C1.RENTED_PROPERTY_ALL = new XmlNodeEntity();
            bpl.BPT_TBL_C1.RENTED_PROPERTY_ALL = "";
            bpl.BPT_TBL_C1.RENTED_PROPERTY_ALL.Attr_TYPE = "C";
            bpl.BPT_TBL_C1.RENTED_PROPERTY_ALL.LENGTH = "15";

            bpl.BPT_TBL_C1.TOTAL_AVG_PHILA = new XmlNodeEntity();
            bpl.BPT_TBL_C1.TOTAL_AVG_PHILA = "";
            bpl.BPT_TBL_C1.TOTAL_AVG_PHILA.Attr_TYPE = "C";
            bpl.BPT_TBL_C1.TOTAL_AVG_PHILA.LENGTH = "15";

            bpl.BPT_TBL_C1.TOTAL_AVG_ALL = new XmlNodeEntity();
            bpl.BPT_TBL_C1.TOTAL_AVG_ALL = "";
            bpl.BPT_TBL_C1.TOTAL_AVG_ALL.Attr_TYPE = "C";
            bpl.BPT_TBL_C1.TOTAL_AVG_ALL.LENGTH = "15";

            // BPTLF_Worksheet

            bpl.BPT_WRKS = new RTTIE030_2015.BPT_WRKS();
            bpl.BPT_SCH_D.Attr_TYPE = "COMPLEX";
            bpl.BPT_SCH_D.OCCURS = "1";
            bpl.BPT_SCH_D.LENGTH = "210";
            bpl.BPT_SCH_D.EXPORT = "Y";

           

            bpl.BPT_WRKS.LOWERLINE_S1 = new XmlNodeEntity();
            bpl.BPT_WRKS.LOWERLINE_S1 = "";
            bpl.BPT_WRKS.LOWERLINE_S1.Attr_TYPE = "C";
            bpl.BPT_WRKS.LOWERLINE_S1.LENGTH = "15";

            bpl.BPT_WRKS.LOWERLINE_S2 = new XmlNodeEntity();
            bpl.BPT_WRKS.LOWERLINE_S2 = "";
            bpl.BPT_WRKS.LOWERLINE_S2.Attr_TYPE = "C";
            bpl.BPT_WRKS.LOWERLINE_S2.LENGTH = "15";

            bpl.BPT_WRKS.LOWERLINE_S3 = new XmlNodeEntity();
            bpl.BPT_WRKS.LOWERLINE_S3 = "";
            bpl.BPT_WRKS.LOWERLINE_S3.Attr_TYPE = "C";
            bpl.BPT_WRKS.LOWERLINE_S3.LENGTH = "15";

            bpl.BPT_WRKS.LOWERLINE_S4 = new XmlNodeEntity();
            bpl.BPT_WRKS.LOWERLINE_S4 = "";
            bpl.BPT_WRKS.LOWERLINE_S4.Attr_TYPE = "C";
            bpl.BPT_WRKS.LOWERLINE_S4.LENGTH = "15";

            bpl.BPT_WRKS.LOWERLINE_Statutory_Net_Income = new XmlNodeEntity();
            bpl.BPT_WRKS.LOWERLINE_Statutory_Net_Income = "";
            bpl.BPT_WRKS.LOWERLINE_Statutory_Net_Income.Attr_TYPE = "C";
            bpl.BPT_WRKS.LOWERLINE_Statutory_Net_Income.LENGTH = "15";

            return bpl;

        }
    }
}
