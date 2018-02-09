using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace COPXmlFactory
{
    public partial class RevenueGovXMLFactory : XMLFactory
    {
        /// <summary>
        /// This method is used to create the object of NPTRETURN 
        /// </summary>
        /// <returns></returns>
        /// 
        public static RTTIE039_2015.NPTRETURN GetNPT_2015Return()
        {
            RTTIE039_2015.NPTRETURN npt = new RTTIE039_2015.NPTRETURN();

            //Errorinfo
            npt.ERROR_INFO = new ERROR_INFO();
            npt.ERROR_INFO.Attr_TYPE = "COMPLEX";
            npt.ERROR_INFO.OCCURS = "1";
            npt.ERROR_INFO.LENGTH = "79";
            npt.ERROR_INFO.EXPORT = "N";

            npt.ERROR_INFO.PROGRAM = new XmlNodeEntity();
            npt.ERROR_INFO.PROGRAM = "";
            npt.ERROR_INFO.PROGRAM.Attr_TYPE = "A";
            npt.ERROR_INFO.PROGRAM.LENGTH = "8";

            npt.ERROR_INFO.ERROR = new XmlNodeEntity();
            npt.ERROR_INFO.ERROR = "";
            npt.ERROR_INFO.ERROR.Attr_TYPE = "N";
            npt.ERROR_INFO.ERROR.LENGTH = "7";

            npt.ERROR_INFO.LINE = new XmlNodeEntity();
            npt.ERROR_INFO.LINE = "";
            npt.ERROR_INFO.LINE.Attr_TYPE = "N";
            npt.ERROR_INFO.LINE.LENGTH = "4";

            npt.ERROR_INFO.MESSAGE = new XmlNodeEntity();
            npt.ERROR_INFO.MESSAGE = "";
            npt.ERROR_INFO.MESSAGE.Attr_TYPE = "A";
            npt.ERROR_INFO.MESSAGE.LENGTH = "60";

            //NPT_PG1
            npt.NPT_INFO = new RTTIE039_2015.NPT_INFO();
            npt.NPT_INFO.Attr_TYPE = "COMPLEX";
            npt.NPT_INFO.OCCURS = "1";
            npt.NPT_INFO.LENGTH = "222";
            npt.NPT_INFO.EXPORT = "Y";


            npt.NPT_INFO.ACCOUNT_ID = new XmlNodeEntity();
            npt.NPT_INFO.ACCOUNT_ID = "";
            npt.NPT_INFO.ACCOUNT_ID.Attr_TYPE = "A";
            npt.NPT_INFO.ACCOUNT_ID.LENGTH = "12";

            npt.NPT_INFO.PERIOD = new XmlNodeEntity();
            npt.NPT_INFO.PERIOD = "";
            npt.NPT_INFO.PERIOD.Attr_TYPE = "D";
            npt.NPT_INFO.PERIOD.LENGTH = "8";

            npt.NPT_INFO.VERSION = new XmlNodeEntity();
            npt.NPT_INFO.VERSION = "";
            npt.NPT_INFO.VERSION.Attr_TYPE = "A";
            npt.NPT_INFO.VERSION.LENGTH = "3";

            npt.NPT_INFO.RETURN_STATUS = new XmlNodeEntity();
            npt.NPT_INFO.RETURN_STATUS = "";
            npt.NPT_INFO.RETURN_STATUS.Attr_TYPE = "A";
            npt.NPT_INFO.RETURN_STATUS.LENGTH = "3";

            npt.NPT_INFO.LAST_UPD_DATE = new XmlNodeEntity();
            npt.NPT_INFO.LAST_UPD_DATE = "";
            npt.NPT_INFO.LAST_UPD_DATE.Attr_TYPE = "D";
            npt.NPT_INFO.LAST_UPD_DATE.LENGTH = "8";

            npt.NPT_INFO.RECORDING_DATE = new XmlNodeEntity();
            npt.NPT_INFO.RECORDING_DATE = "";
            npt.NPT_INFO.RECORDING_DATE.Attr_TYPE = "D";
            npt.NPT_INFO.RECORDING_DATE.LENGTH = "8";

            npt.NPT_INFO.EXTENSION_DATE = new XmlNodeEntity();
            npt.NPT_INFO.EXTENSION_DATE = "";
            npt.NPT_INFO.EXTENSION_DATE.Attr_TYPE = "D";
            npt.NPT_INFO.EXTENSION_DATE.LENGTH = "8";

            npt.NPT_INFO.SEQUENCE = new XmlNodeEntity();
            npt.NPT_INFO.SEQUENCE = "";
            npt.NPT_INFO.SEQUENCE.Attr_TYPE = "A";
            npt.NPT_INFO.SEQUENCE.LENGTH = "5";

            npt.NPT_INFO.ADJUSTMENT_REF_NO = new XmlNodeEntity();
            npt.NPT_INFO.ADJUSTMENT_REF_NO = "";
            npt.NPT_INFO.ADJUSTMENT_REF_NO.Attr_TYPE = "A";
            npt.NPT_INFO.ADJUSTMENT_REF_NO.LENGTH = "10";

            npt.NPT_INFO.USER_ID = new XmlNodeEntity();
            npt.NPT_INFO.USER_ID = "";
            npt.NPT_INFO.USER_ID.Attr_TYPE = "A";
            npt.NPT_INFO.USER_ID.LENGTH = "4";

            npt.NPT_INFO.RESIDENT_RATE = new XmlNodeEntity();
            npt.NPT_INFO.RESIDENT_RATE = "";
            npt.NPT_INFO.RESIDENT_RATE.Attr_TYPE = "N";
            npt.NPT_INFO.RESIDENT_RATE.LENGTH = "9";
            npt.NPT_INFO.RESIDENT_RATE.PERCISION = "6";

            npt.NPT_INFO.NON_RES_RATE = new XmlNodeEntity();
            npt.NPT_INFO.NON_RES_RATE = "";
            npt.NPT_INFO.NON_RES_RATE.Attr_TYPE = "A";
            npt.NPT_INFO.NON_RES_RATE.LENGTH = "25";
            npt.NPT_INFO.NON_RES_RATE.PERCISION = "6";

            npt.NPT_INFO.PREPARER_NAME = new XmlNodeEntity();
            npt.NPT_INFO.PREPARER_NAME = "";
            npt.NPT_INFO.PREPARER_NAME.Attr_TYPE = "A";
            npt.NPT_INFO.PREPARER_NAME.LENGTH = "40";

            npt.NPT_INFO.PREPARER_PHONE = new XmlNodeEntity();
            npt.NPT_INFO.PREPARER_PHONE = "";
            npt.NPT_INFO.PREPARER_PHONE.Attr_TYPE = "P";
            npt.NPT_INFO.PREPARER_PHONE.LENGTH = "10";

            npt.NPT_INFO.PREPARER_PHONE_EXT = new XmlNodeEntity();
            npt.NPT_INFO.PREPARER_PHONE_EXT = "";
            npt.NPT_INFO.PREPARER_PHONE_EXT.Attr_TYPE = "A";
            npt.NPT_INFO.PREPARER_PHONE_EXT.LENGTH = "5";

            npt.NPT_INFO.PREPARER_IP_ADDRESS = new XmlNodeEntity();
            npt.NPT_INFO.PREPARER_IP_ADDRESS = "";
            npt.NPT_INFO.PREPARER_IP_ADDRESS.Attr_TYPE = "A";
            npt.NPT_INFO.PREPARER_IP_ADDRESS.LENGTH = "15";

            npt.NPT_INFO.PREPARER_EMAIL_ADDRESS = new XmlNodeEntity();
            npt.NPT_INFO.PREPARER_EMAIL_ADDRESS = "";
            npt.NPT_INFO.PREPARER_EMAIL_ADDRESS.Attr_TYPE = "A";
            npt.NPT_INFO.PREPARER_EMAIL_ADDRESS.LENGTH = "60";

            npt.NPT_INFO.PREPARER_WHO = new XmlNodeEntity();
            npt.NPT_INFO.PREPARER_WHO = "";
            npt.NPT_INFO.PREPARER_WHO.Attr_TYPE = "A";
            npt.NPT_INFO.PREPARER_WHO.LENGTH = "1";

            //NPT_PG1
            npt.NPT_PG1 = new RTTIE039_2015.NPT_PG1();
            npt.NPT_PG1.Attr_TYPE = "COMPLEX";
            npt.NPT_PG1.OCCURS = "1";
            npt.NPT_PG1.LENGTH = "240";
            npt.NPT_PG1.EXPORT = "Y";


            npt.NPT_PG1.RESIDENT_INCOME_NOT_ELIGIBLE = new XmlNodeEntity();
            npt.NPT_PG1.RESIDENT_INCOME_NOT_ELIGIBLE = "";
            npt.NPT_PG1.RESIDENT_INCOME_NOT_ELIGIBLE.Attr_TYPE = "C";
            npt.NPT_PG1.RESIDENT_INCOME_NOT_ELIGIBLE.LENGTH = "15";

            npt.NPT_PG1.RESIDENT_INCOME_TAX_NOT_ELIGIBLE = new XmlNodeEntity();
            npt.NPT_PG1.RESIDENT_INCOME_TAX_NOT_ELIGIBLE = "";
            npt.NPT_PG1.RESIDENT_INCOME_TAX_NOT_ELIGIBLE.Attr_TYPE = "C";
            npt.NPT_PG1.RESIDENT_INCOME_TAX_NOT_ELIGIBLE.LENGTH = "15";

            npt.NPT_PG1.RESIDENT_INCOME_ELIGIBLE = new XmlNodeEntity();
            npt.NPT_PG1.RESIDENT_INCOME_ELIGIBLE = "";
            npt.NPT_PG1.RESIDENT_INCOME_ELIGIBLE.Attr_TYPE = "C";
            npt.NPT_PG1.RESIDENT_INCOME_ELIGIBLE.LENGTH = "15";

            npt.NPT_PG1.RES_INCOME_TAX_ELIGIBLE = new XmlNodeEntity();
            npt.NPT_PG1.RES_INCOME_TAX_ELIGIBLE = "";
            npt.NPT_PG1.RES_INCOME_TAX_ELIGIBLE.Attr_TYPE = "C";
            npt.NPT_PG1.RES_INCOME_TAX_ELIGIBLE.LENGTH = "15";

            npt.NPT_PG1.RESIDENT_TOTAL_TAX = new XmlNodeEntity();
            npt.NPT_PG1.RESIDENT_TOTAL_TAX = "";
            npt.NPT_PG1.RESIDENT_TOTAL_TAX.Attr_TYPE = "C";
            npt.NPT_PG1.RESIDENT_TOTAL_TAX.LENGTH = "15";

            npt.NPT_PG1.NON_RES_INCOME_NOT_ELIGIBLE = new XmlNodeEntity();
            npt.NPT_PG1.NON_RES_INCOME_NOT_ELIGIBLE = "";
            npt.NPT_PG1.NON_RES_INCOME_NOT_ELIGIBLE.Attr_TYPE = "C";
            npt.NPT_PG1.NON_RES_INCOME_NOT_ELIGIBLE.LENGTH = "15";

            npt.NPT_PG1.NON_RES_INCOME_TAX_NOT_ELIGIBLE = new XmlNodeEntity();
            npt.NPT_PG1.NON_RES_INCOME_TAX_NOT_ELIGIBLE = "";
            npt.NPT_PG1.NON_RES_INCOME_TAX_NOT_ELIGIBLE.Attr_TYPE = "C";
            npt.NPT_PG1.NON_RES_INCOME_TAX_NOT_ELIGIBLE.LENGTH = "15";

            npt.NPT_PG1.NON_RES_INCOME_ELIGIBLE = new XmlNodeEntity();
            npt.NPT_PG1.NON_RES_INCOME_ELIGIBLE = "";
            npt.NPT_PG1.NON_RES_INCOME_ELIGIBLE.Attr_TYPE = "C";
            npt.NPT_PG1.NON_RES_INCOME_ELIGIBLE.LENGTH = "15";

            npt.NPT_PG1.NON_RES_INCOME_TAX_ELIGIBLE = new XmlNodeEntity();
            npt.NPT_PG1.NON_RES_INCOME_TAX_ELIGIBLE = "";
            npt.NPT_PG1.NON_RES_INCOME_TAX_ELIGIBLE.Attr_TYPE = "C";
            npt.NPT_PG1.NON_RES_INCOME_TAX_ELIGIBLE.LENGTH = "15";
         
            npt.NPT_PG1.NON_RES_TOTAL_TAX = new XmlNodeEntity();
            npt.NPT_PG1.NON_RES_TOTAL_TAX = "";
            npt.NPT_PG1.NON_RES_TOTAL_TAX.Attr_TYPE = "C";
            npt.NPT_PG1.NON_RES_TOTAL_TAX.LENGTH = "15";

            npt.NPT_PG1.TOTAL_TAX = new XmlNodeEntity();
            npt.NPT_PG1.TOTAL_TAX = "";
            npt.NPT_PG1.TOTAL_TAX.Attr_TYPE = "C";
            npt.NPT_PG1.TOTAL_TAX.LENGTH = "15";

            npt.NPT_PG1.BPT_TAX_CREDIT = new XmlNodeEntity();
            npt.NPT_PG1.BPT_TAX_CREDIT = "";
            npt.NPT_PG1.BPT_TAX_CREDIT.Attr_TYPE = "C";
            npt.NPT_PG1.BPT_TAX_CREDIT.LENGTH = "15";

            npt.NPT_PG1.OTHER_TAX_CREDIT = new XmlNodeEntity();
            npt.NPT_PG1.OTHER_TAX_CREDIT = "";
            npt.NPT_PG1.OTHER_TAX_CREDIT.Attr_TYPE = "C";
            npt.NPT_PG1.OTHER_TAX_CREDIT.LENGTH = "15";

            npt.NPT_PG1.TOTAL_PAY_CREDITS = new XmlNodeEntity();
            npt.NPT_PG1.TOTAL_PAY_CREDITS = "";
            npt.NPT_PG1.TOTAL_PAY_CREDITS.Attr_TYPE = "C";
            npt.NPT_PG1.TOTAL_PAY_CREDITS.LENGTH = "15";

            npt.NPT_PG1.TAX_DUE = new XmlNodeEntity();
            npt.NPT_PG1.TAX_DUE = "";
            npt.NPT_PG1.TAX_DUE.Attr_TYPE = "C";
            npt.NPT_PG1.TAX_DUE.LENGTH = "15";

            npt.NPT_PG1.INTEREST_PENALTY = new XmlNodeEntity();
            npt.NPT_PG1.INTEREST_PENALTY = "";
            npt.NPT_PG1.INTEREST_PENALTY.Attr_TYPE = "C";
            npt.NPT_PG1.INTEREST_PENALTY.LENGTH = "15";

            npt.NPT_PG1.TOTAL_DUE = new XmlNodeEntity();
            npt.NPT_PG1.TOTAL_DUE = "";
            npt.NPT_PG1.TOTAL_DUE.Attr_TYPE = "C";
            npt.NPT_PG1.TOTAL_DUE.LENGTH = "15";

            npt.NPT_PG1.OVERPAY = new XmlNodeEntity();
            npt.NPT_PG1.OVERPAY = "";
            npt.NPT_PG1.OVERPAY.Attr_TYPE = "C";
            npt.NPT_PG1.OVERPAY.LENGTH = "15";

            npt.NPT_PG1.LINE17 = new XmlNodeEntity();
            npt.NPT_PG1.LINE17 = "";
            npt.NPT_PG1.LINE17.Attr_TYPE = "C";
            npt.NPT_PG1.LINE17.LENGTH = "15";
           
            npt.NPT_PG1.BALANCE = new XmlNodeEntity();
            npt.NPT_PG1.BALANCE = "";
            npt.NPT_PG1.BALANCE.Attr_TYPE = "C";
            npt.NPT_PG1.BALANCE.LENGTH = "15";

            npt.NPT_PG1.REFUND = new XmlNodeEntity();
            npt.NPT_PG1.REFUND = "";
            npt.NPT_PG1.REFUND.Attr_TYPE = "C";
            npt.NPT_PG1.REFUND.LENGTH = "15";

            npt.NPT_PG1.BPT_OVERPAY = new XmlNodeEntity();
            npt.NPT_PG1.BPT_OVERPAY = "";
            npt.NPT_PG1.BPT_OVERPAY.Attr_TYPE = "C";
            npt.NPT_PG1.BPT_OVERPAY.LENGTH = "15";

            npt.NPT_PG1.NPT_OVERPAY = new XmlNodeEntity();
            npt.NPT_PG1.NPT_OVERPAY = "";
            npt.NPT_PG1.NPT_OVERPAY.Attr_TYPE = "C";
            npt.NPT_PG1.NPT_OVERPAY.LENGTH = "15";

            ////NPT_WRKA
            //npt.NPT_WRKA = new RTTIE039.NPT_WRKA();
            //npt.NPT_WRKA.Attr_TYPE = "COMPLEX";
            //npt.NPT_WRKA.OCCURS = "1";
            //npt.NPT_WRKA.LENGTH = "210";
            //npt.NPT_WRKA.EXPORT = "Y";

            //npt.NPT_WRKA.RESIDENT_NET_INCOME = new XmlNodeEntity();
            //npt.NPT_WRKA.RESIDENT_NET_INCOME = "";
            //npt.NPT_WRKA.RESIDENT_NET_INCOME.Attr_TYPE = "C";
            //npt.NPT_WRKA.RESIDENT_NET_INCOME.LENGTH = "15";

            //npt.NPT_WRKA.RESIDENT_FORM_1065 = new XmlNodeEntity();
            //npt.NPT_WRKA.RESIDENT_FORM_1065 = "";
            //npt.NPT_WRKA.RESIDENT_FORM_1065.Attr_TYPE = "C";
            //npt.NPT_WRKA.RESIDENT_FORM_1065.LENGTH = "15";

            //npt.NPT_WRKA.RESIDENT_OTHER_INCOME = new XmlNodeEntity();
            //npt.NPT_WRKA.RESIDENT_OTHER_INCOME = "";
            //npt.NPT_WRKA.RESIDENT_OTHER_INCOME.Attr_TYPE = "C";
            //npt.NPT_WRKA.RESIDENT_OTHER_INCOME.LENGTH = "15";

            //npt.NPT_WRKA.RESIDENT_TAXABLE_INCOME = new XmlNodeEntity();
            //npt.NPT_WRKA.RESIDENT_TAXABLE_INCOME = "";
            //npt.NPT_WRKA.RESIDENT_TAXABLE_INCOME.Attr_TYPE = "C";
            //npt.NPT_WRKA.RESIDENT_TAXABLE_INCOME.LENGTH = "15";

            ////NPT_WRKB
            //npt.NPT_WRKB = new RTTIE039.NPT_WRKB();
            //npt.NPT_WRKB.Attr_TYPE = "COMPLEX";
            //npt.NPT_WRKB.OCCURS = "1";
            //npt.NPT_WRKB.LENGTH = "210";
            //npt.NPT_WRKB.EXPORT = "Y";

            //npt.NPT_WRKB.NON_RES_NET_INCOME = new XmlNodeEntity();
            //npt.NPT_WRKB.NON_RES_NET_INCOME = "";
            //npt.NPT_WRKB.NON_RES_NET_INCOME.Attr_TYPE = "C";
            //npt.NPT_WRKB.NON_RES_NET_INCOME.LENGTH = "15";

            //npt.NPT_WRKB.NON_RES_FORM_1065 = new XmlNodeEntity();
            //npt.NPT_WRKB.NON_RES_FORM_1065 = "";
            //npt.NPT_WRKB.NON_RES_FORM_1065.Attr_TYPE = "C";
            //npt.NPT_WRKB.NON_RES_FORM_1065.LENGTH = "15";

            //npt.NPT_WRKB.NON_RES_OTHER_INCOME = new XmlNodeEntity();
            //npt.NPT_WRKB.NON_RES_OTHER_INCOME = "";
            //npt.NPT_WRKB.NON_RES_OTHER_INCOME.Attr_TYPE = "C";
            //npt.NPT_WRKB.NON_RES_OTHER_INCOME.LENGTH = "15";

            //npt.NPT_WRKB.NON_RES_TOTAL_INCOME = new XmlNodeEntity();
            //npt.NPT_WRKB.NON_RES_TOTAL_INCOME = "";
            //npt.NPT_WRKB.NON_RES_TOTAL_INCOME.Attr_TYPE = "C";
            //npt.NPT_WRKB.NON_RES_TOTAL_INCOME.LENGTH = "15";

            //npt.NPT_WRKB.NON_RES_OUTSIDE_INCOME = new XmlNodeEntity();
            //npt.NPT_WRKB.NON_RES_OUTSIDE_INCOME = "";
            //npt.NPT_WRKB.NON_RES_OUTSIDE_INCOME.Attr_TYPE = "C";
            //npt.NPT_WRKB.NON_RES_OUTSIDE_INCOME.LENGTH = "15";

            //npt.NPT_WRKB.NON_RES_TAXABLE_INCOME = new XmlNodeEntity();
            //npt.NPT_WRKB.NON_RES_TAXABLE_INCOME = "";
            //npt.NPT_WRKB.NON_RES_TAXABLE_INCOME.Attr_TYPE = "C";
            //npt.NPT_WRKB.NON_RES_TAXABLE_INCOME.LENGTH = "15";

            ////NPT_WRKC
            //npt.NPT_WRKC = new RTTIE039.NPT_WRKC();
            //npt.NPT_WRKC.Attr_TYPE = "COMPLEX";
            //npt.NPT_WRKC.OCCURS = "1";
            //npt.NPT_WRKC.LENGTH = "210";
            //npt.NPT_WRKC.EXPORT = "Y";

            //npt.NPT_WRKC.NET_PROFITS_LIABILTY = new XmlNodeEntity();
            //npt.NPT_WRKC.NET_PROFITS_LIABILTY = "";
            //npt.NPT_WRKC.NET_PROFITS_LIABILTY.Attr_TYPE = "C";
            //npt.NPT_WRKC.NET_PROFITS_LIABILTY.LENGTH = "15";

            //npt.NPT_WRKC.BTP_TAX_CREDIT = new XmlNodeEntity();
            //npt.NPT_WRKC.BTP_TAX_CREDIT = "";
            //npt.NPT_WRKC.BTP_TAX_CREDIT.Attr_TYPE = "C";
            //npt.NPT_WRKC.BTP_TAX_CREDIT.LENGTH = "15";

            //npt.NPT_WRKC.ESTIMATED_PAYMENT_BASE = new XmlNodeEntity();
            //npt.NPT_WRKC.ESTIMATED_PAYMENT_BASE = "";
            //npt.NPT_WRKC.ESTIMATED_PAYMENT_BASE.Attr_TYPE = "C";
            //npt.NPT_WRKC.ESTIMATED_PAYMENT_BASE.LENGTH = "15";

            ////NPT_WRKD
            //npt.NPT_WRKD = new RTTIE039.NPT_WRKD();
            //npt.NPT_WRKD.Attr_TYPE = "COMPLEX";
            //npt.NPT_WRKD.OCCURS = "1";
            //npt.NPT_WRKD.LENGTH = "210";
            //npt.NPT_WRKD.EXPORT = "Y";

            //npt.NPT_WRKD.PORTION_TAXABLE_INCOME = new XmlNodeEntity();
            //npt.NPT_WRKD.PORTION_TAXABLE_INCOME = "";
            //npt.NPT_WRKD.PORTION_TAXABLE_INCOME.Attr_TYPE = "C";
            //npt.NPT_WRKD.PORTION_TAXABLE_INCOME.LENGTH = "15";

            //npt.NPT_WRKD.TOTAL_TAXABLE_INCOME = new XmlNodeEntity();
            //npt.NPT_WRKD.TOTAL_TAXABLE_INCOME = "";
            //npt.NPT_WRKD.TOTAL_TAXABLE_INCOME.Attr_TYPE = "C";
            //npt.NPT_WRKD.TOTAL_TAXABLE_INCOME.LENGTH = "15";

            //npt.NPT_WRKD.PERCENTAGE_TAXABLE_INCOME = new XmlNodeEntity();
            //npt.NPT_WRKD.PERCENTAGE_TAXABLE_INCOME = "";
            //npt.NPT_WRKD.PERCENTAGE_TAXABLE_INCOME.Attr_TYPE = "C";
            //npt.NPT_WRKD.PERCENTAGE_TAXABLE_INCOME.LENGTH = "15";

            //npt.NPT_WRKD.WRKK_LINE2 = new XmlNodeEntity();
            //npt.NPT_WRKD.WRKK_LINE2 = "";
            //npt.NPT_WRKD.WRKK_LINE2.Attr_TYPE = "C";
            //npt.NPT_WRKD.WRKK_LINE2.LENGTH = "15";

            //npt.NPT_WRKD.MULTIPLY_LINE4_PERCENTAGE = new XmlNodeEntity();
            //npt.NPT_WRKD.MULTIPLY_LINE4_PERCENTAGE = "";
            //npt.NPT_WRKD.MULTIPLY_LINE4_PERCENTAGE.Attr_TYPE = "C";
            //npt.NPT_WRKD.MULTIPLY_LINE4_PERCENTAGE.LENGTH = "15";

            //npt.NPT_WRKD.SUBTRACT_LINE5_LINE4 = new XmlNodeEntity();
            //npt.NPT_WRKD.SUBTRACT_LINE5_LINE4 = "";
            //npt.NPT_WRKD.SUBTRACT_LINE5_LINE4.Attr_TYPE = "C";
            //npt.NPT_WRKD.SUBTRACT_LINE5_LINE4.LENGTH = "15";

            //npt.NPT_WRKD.PAGE1_LINE5 = new XmlNodeEntity();
            //npt.NPT_WRKD.PAGE1_LINE5 = "";
            //npt.NPT_WRKD.PAGE1_LINE5.Attr_TYPE = "C";
            //npt.NPT_WRKD.PAGE1_LINE5.LENGTH = "15";

            //npt.NPT_WRKD.BPT_TAX_CREDIT = new XmlNodeEntity();
            //npt.NPT_WRKD.BPT_TAX_CREDIT = "";
            //npt.NPT_WRKD.BPT_TAX_CREDIT.Attr_TYPE = "C";
            //npt.NPT_WRKD.BPT_TAX_CREDIT.LENGTH = "15";

            ////NPT_WRKE
            //npt.NPT_WRKE = new RTTIE039.NPT_WRKE();
            //npt.NPT_WRKE.Attr_TYPE = "COMPLEX";
            //npt.NPT_WRKE.OCCURS = "1";
            //npt.NPT_WRKE.LENGTH = "210";
            //npt.NPT_WRKE.EXPORT = "Y";

            //npt.NPT_WRKE.ESTIMATED_PROFIT_PAYMENT = new XmlNodeEntity();
            //npt.NPT_WRKE.ESTIMATED_PROFIT_PAYMENT = "";
            //npt.NPT_WRKE.ESTIMATED_PROFIT_PAYMENT.Attr_TYPE = "C";
            //npt.NPT_WRKE.ESTIMATED_PROFIT_PAYMENT.LENGTH = "15";

            //npt.NPT_WRKE.PAYMENTS_WITH_EXTENSION = new XmlNodeEntity();
            //npt.NPT_WRKE.PAYMENTS_WITH_EXTENSION = "";
            //npt.NPT_WRKE.PAYMENTS_WITH_EXTENSION.Attr_TYPE = "C";
            //npt.NPT_WRKE.PAYMENTS_WITH_EXTENSION.LENGTH = "15";

            //npt.NPT_WRKE.PRIOR_OVERPAYMENT_TBA = new XmlNodeEntity();
            //npt.NPT_WRKE.PRIOR_OVERPAYMENT_TBA = "";
            //npt.NPT_WRKE.PRIOR_OVERPAYMENT_TBA.Attr_TYPE = "C";
            //npt.NPT_WRKE.PRIOR_OVERPAYMENT_TBA.LENGTH = "15";

            //npt.NPT_WRKE.TOATAL_PAYMENTS_CREDITS = new XmlNodeEntity();
            //npt.NPT_WRKE.TOATAL_PAYMENTS_CREDITS = "";
            //npt.NPT_WRKE.TOATAL_PAYMENTS_CREDITS.Attr_TYPE = "C";
            //npt.NPT_WRKE.TOATAL_PAYMENTS_CREDITS.LENGTH = "15";

            ////NPT_WRKK
            //npt.NPT_WRKK = new RTTIE039.NPT_WRKK();
            //npt.NPT_WRKK.Attr_TYPE = "COMPLEX";
            //npt.NPT_WRKK.OCCURS = "1";
            //npt.NPT_WRKK.LENGTH = "210";
            //npt.NPT_WRKK.EXPORT = "Y";

            //npt.NPT_WRKK.BPT_PAGE1_LINE1 = new XmlNodeEntity();
            //npt.NPT_WRKK.BPT_PAGE1_LINE1 = "";
            //npt.NPT_WRKK.BPT_PAGE1_LINE1.Attr_TYPE = "C";
            //npt.NPT_WRKK.BPT_PAGE1_LINE1.LENGTH = "15";

            //npt.NPT_WRKK.SIXTY_PERCENT_LINE1 = new XmlNodeEntity();
            //npt.NPT_WRKK.SIXTY_PERCENT_LINE1 = "";
            //npt.NPT_WRKK.SIXTY_PERCENT_LINE1.Attr_TYPE = "C";
            //npt.NPT_WRKK.SIXTY_PERCENT_LINE1.LENGTH = "15";

            //npt.NPT_WRKK.NPT_PAGE1_LINE5 = new XmlNodeEntity();
            //npt.NPT_WRKK.NPT_PAGE1_LINE5 = "";
            //npt.NPT_WRKK.NPT_PAGE1_LINE5.Attr_TYPE = "C";
            //npt.NPT_WRKK.NPT_PAGE1_LINE5.LENGTH = "15";

            //npt.NPT_WRKK.BPT_TAX_CREDIT = new XmlNodeEntity();
            //npt.NPT_WRKK.BPT_TAX_CREDIT = "";
            //npt.NPT_WRKK.BPT_TAX_CREDIT.Attr_TYPE = "C";
            //npt.NPT_WRKK.BPT_TAX_CREDIT.LENGTH = "15";

            ////NPT_PG4
            //npt.NPT_PG4 = new RTTIE039.NPT_PG4();
            //npt.NPT_PG4.Attr_TYPE = "COMPLEX";
            //npt.NPT_PG4.OCCURS = "1";
            //npt.NPT_PG4.LENGTH = "210";
            //npt.NPT_PG4.EXPORT = "Y";

            //npt.NPT_PG4.INVENTORY_RAW_A = new XmlNodeEntity();
            //npt.NPT_PG4.INVENTORY_RAW_A = "";
            //npt.NPT_PG4.INVENTORY_RAW_A.Attr_TYPE = "C";
            //npt.NPT_PG4.INVENTORY_RAW_A.LENGTH = "15";

            //npt.NPT_PG4.INVENTORY_RAW_B = new XmlNodeEntity();
            //npt.NPT_PG4.INVENTORY_RAW_B = "";
            //npt.NPT_PG4.INVENTORY_RAW_B.Attr_TYPE = "C";
            //npt.NPT_PG4.INVENTORY_RAW_B.LENGTH = "15";

            //npt.NPT_PG4.LAND_BUILDING_A = new XmlNodeEntity();
            //npt.NPT_PG4.LAND_BUILDING_A = "";
            //npt.NPT_PG4.LAND_BUILDING_A.Attr_TYPE = "C";
            //npt.NPT_PG4.LAND_BUILDING_A.LENGTH = "15";

            //npt.NPT_PG4.LAND_BUILDING_B = new XmlNodeEntity();
            //npt.NPT_PG4.LAND_BUILDING_B = "";
            //npt.NPT_PG4.LAND_BUILDING_B.Attr_TYPE = "C";
            //npt.NPT_PG4.LAND_BUILDING_B.LENGTH = "15";

            //npt.NPT_PG4.MACHINERY_EQUIP_A = new XmlNodeEntity();
            //npt.NPT_PG4.MACHINERY_EQUIP_A = "";
            //npt.NPT_PG4.MACHINERY_EQUIP_A.Attr_TYPE = "C";
            //npt.NPT_PG4.MACHINERY_EQUIP_A.LENGTH = "15";

            //npt.NPT_PG4.MACHINERY_EQUIP_B = new XmlNodeEntity();
            //npt.NPT_PG4.MACHINERY_EQUIP_B = "";
            //npt.NPT_PG4.MACHINERY_EQUIP_B.Attr_TYPE = "C";
            //npt.NPT_PG4.MACHINERY_EQUIP_B.LENGTH = "15";

            //npt.NPT_PG4.OTHER_ASSESTS_A = new XmlNodeEntity();
            //npt.NPT_PG4.OTHER_ASSESTS_A = "";
            //npt.NPT_PG4.OTHER_ASSESTS_A.Attr_TYPE = "C";
            //npt.NPT_PG4.OTHER_ASSESTS_A.LENGTH = "15";

            //npt.NPT_PG4.OTHER_ASSESTS_B = new XmlNodeEntity();
            //npt.NPT_PG4.OTHER_ASSESTS_B = "";
            //npt.NPT_PG4.OTHER_ASSESTS_B.Attr_TYPE = "C";
            //npt.NPT_PG4.OTHER_ASSESTS_B.LENGTH = "15";

            //npt.NPT_PG4.RENTED_PROPERTY_A = new XmlNodeEntity();
            //npt.NPT_PG4.RENTED_PROPERTY_A = "";
            //npt.NPT_PG4.RENTED_PROPERTY_A.Attr_TYPE = "C";
            //npt.NPT_PG4.RENTED_PROPERTY_A.LENGTH = "15";

            //npt.NPT_PG4.RENTED_PROPERTY_B = new XmlNodeEntity();
            //npt.NPT_PG4.RENTED_PROPERTY_B = "";
            //npt.NPT_PG4.RENTED_PROPERTY_B.Attr_TYPE = "C";
            //npt.NPT_PG4.RENTED_PROPERTY_B.LENGTH = "15";

            //npt.NPT_PG4.TOTAL_VALUE_OUTSIDE = new XmlNodeEntity();
            //npt.NPT_PG4.TOTAL_VALUE_OUTSIDE = "";
            //npt.NPT_PG4.TOTAL_VALUE_OUTSIDE.Attr_TYPE = "C";
            //npt.NPT_PG4.TOTAL_VALUE_OUTSIDE.LENGTH = "15";

            //npt.NPT_PG4.TOTAL_VALUE_EVERYWHERE = new XmlNodeEntity();
            //npt.NPT_PG4.TOTAL_VALUE_EVERYWHERE = "";
            //npt.NPT_PG4.TOTAL_VALUE_EVERYWHERE.Attr_TYPE = "C";
            //npt.NPT_PG4.TOTAL_VALUE_EVERYWHERE.LENGTH = "15";

            //npt.NPT_PG4.OUTSIDE_PROPERTY_FACTOR = new XmlNodeEntity();
            //npt.NPT_PG4.OUTSIDE_PROPERTY_FACTOR = "";
            //npt.NPT_PG4.OUTSIDE_PROPERTY_FACTOR.Attr_TYPE = "C";
            //npt.NPT_PG4.OUTSIDE_PROPERTY_FACTOR.LENGTH = "15";

            //npt.NPT_PG4.OUT_PHILLY_PAYROLL = new XmlNodeEntity();
            //npt.NPT_PG4.OUT_PHILLY_PAYROLL = "";
            //npt.NPT_PG4.OUT_PHILLY_PAYROLL.Attr_TYPE = "C";
            //npt.NPT_PG4.OUT_PHILLY_PAYROLL.LENGTH = "15";

            //npt.NPT_PG4.PAYROLL_EVERYWHERE = new XmlNodeEntity();
            //npt.NPT_PG4.PAYROLL_EVERYWHERE = "";
            //npt.NPT_PG4.PAYROLL_EVERYWHERE.Attr_TYPE = "C";
            //npt.NPT_PG4.PAYROLL_EVERYWHERE.LENGTH = "15";

            //npt.NPT_PG4.OUTSIDE_PAYROLL_FACTOR = new XmlNodeEntity();
            //npt.NPT_PG4.OUTSIDE_PAYROLL_FACTOR = "";
            //npt.NPT_PG4.OUTSIDE_PAYROLL_FACTOR.Attr_TYPE = "C";
            //npt.NPT_PG4.OUTSIDE_PAYROLL_FACTOR.LENGTH = "15";

            //npt.NPT_PG4.OUT_PHILLY_RECEIPTS = new XmlNodeEntity();
            //npt.NPT_PG4.OUT_PHILLY_RECEIPTS = "";
            //npt.NPT_PG4.OUT_PHILLY_RECEIPTS.Attr_TYPE = "C";
            //npt.NPT_PG4.OUT_PHILLY_RECEIPTS.LENGTH = "15";

            //npt.NPT_PG4.GROSS_RECEIPTS_EVERYWHERE = new XmlNodeEntity();
            //npt.NPT_PG4.GROSS_RECEIPTS_EVERYWHERE = "";
            //npt.NPT_PG4.GROSS_RECEIPTS_EVERYWHERE.Attr_TYPE = "C";
            //npt.NPT_PG4.GROSS_RECEIPTS_EVERYWHERE.LENGTH = "15";

            //npt.NPT_PG4.OUTSIDE_RECEIPTS_FACTOR = new XmlNodeEntity();
            //npt.NPT_PG4.OUTSIDE_RECEIPTS_FACTOR = "";
            //npt.NPT_PG4.OUTSIDE_RECEIPTS_FACTOR.Attr_TYPE = "C";
            //npt.NPT_PG4.OUTSIDE_RECEIPTS_FACTOR.LENGTH = "15";

            //npt.NPT_PG4.TOTAL_FACTORS = new XmlNodeEntity();
            //npt.NPT_PG4.TOTAL_FACTORS = "";
            //npt.NPT_PG4.TOTAL_FACTORS.Attr_TYPE = "C";
            //npt.NPT_PG4.TOTAL_FACTORS.LENGTH = "15";

            //npt.NPT_PG4.AVERAGE_FACTORS = new XmlNodeEntity();
            //npt.NPT_PG4.AVERAGE_FACTORS = "";
            //npt.NPT_PG4.AVERAGE_FACTORS.Attr_TYPE = "C";
            //npt.NPT_PG4.AVERAGE_FACTORS.LENGTH = "15";

            //npt.NPT_PG4.WRKB_LINE4 = new XmlNodeEntity();
            //npt.NPT_PG4.WRKB_LINE4 = "";
            //npt.NPT_PG4.WRKB_LINE4.Attr_TYPE = "C";
            //npt.NPT_PG4.WRKB_LINE4.LENGTH = "15";

            //npt.NPT_PG4.MULTIPLY_LINE13_LINE12 = new XmlNodeEntity();
            //npt.NPT_PG4.MULTIPLY_LINE13_LINE12 = "";
            //npt.NPT_PG4.MULTIPLY_LINE13_LINE12.Attr_TYPE = "C";
            //npt.NPT_PG4.MULTIPLY_LINE13_LINE12.LENGTH = "15";
            ////HEADER_INFO
            //npt.HEADER_INFO = new HEADER_INFO();
            //npt.HEADER_INFO.ENVIRONMENT = "";

            ////DEBUG
            //npt.DEBUG = new DEBUG();

            return npt;
        }
    }
}
