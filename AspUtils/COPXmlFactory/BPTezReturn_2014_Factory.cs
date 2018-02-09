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
        /// This method is used to create the object of BPTezReturn 
        /// </summary>
        /// <returns></returns>
        public static RTTIE037_2014.BPTezReturn GetBPTez_2014Return()
        {
            RTTIE037_2014.BPTezReturn bpt = new RTTIE037_2014.BPTezReturn();

            //Errorinfo
            bpt.ERROR_INFO = new ERROR_INFO();
            bpt.ERROR_INFO.Attr_TYPE = "COMPLEX";
            bpt.ERROR_INFO.OCCURS = "1";
            bpt.ERROR_INFO.LENGTH = "79";
            bpt.ERROR_INFO.EXPORT = "N";

            bpt.ERROR_INFO.PROGRAM = new XmlNodeEntity();
            bpt.ERROR_INFO.PROGRAM = "";
            bpt.ERROR_INFO.PROGRAM.Attr_TYPE = "A";
            bpt.ERROR_INFO.PROGRAM.LENGTH = "8";

            bpt.ERROR_INFO.ERROR = new XmlNodeEntity();
            bpt.ERROR_INFO.ERROR = "";
            bpt.ERROR_INFO.ERROR.Attr_TYPE = "N";
            bpt.ERROR_INFO.ERROR.LENGTH = "7";

            bpt.ERROR_INFO.LINE = new XmlNodeEntity();
            bpt.ERROR_INFO.LINE = "";
            bpt.ERROR_INFO.LINE.Attr_TYPE = "N";
            bpt.ERROR_INFO.LINE.LENGTH = "4";

            bpt.ERROR_INFO.MESSAGE = new XmlNodeEntity();
            bpt.ERROR_INFO.MESSAGE = "";
            bpt.ERROR_INFO.MESSAGE.Attr_TYPE = "A";
            bpt.ERROR_INFO.MESSAGE.LENGTH = "60";

            //UO_ACCT
            bpt.BPT_INFO = new RTTIE037_2014.BPT_INFO();
            bpt.BPT_INFO.Attr_TYPE = "COMPLEX";
            bpt.BPT_INFO.OCCURS = "1";
            bpt.BPT_INFO.LENGTH = "222";
            bpt.BPT_INFO.EXPORT = "Y";

            bpt.BPT_INFO.ACCOUNT_ID = new XmlNodeEntity();
            bpt.BPT_INFO.ACCOUNT_ID = "";
            bpt.BPT_INFO.ACCOUNT_ID.Attr_TYPE = "A";
            bpt.BPT_INFO.ACCOUNT_ID.LENGTH = "12";

            bpt.BPT_INFO.PERIOD = new XmlNodeEntity();
            bpt.BPT_INFO.PERIOD = "";
            bpt.BPT_INFO.PERIOD.Attr_TYPE = "D";
            bpt.BPT_INFO.PERIOD.LENGTH = "8";

            bpt.BPT_INFO.VERSION = new XmlNodeEntity();
            bpt.BPT_INFO.VERSION = "";
            bpt.BPT_INFO.VERSION.Attr_TYPE = "A";
            bpt.BPT_INFO.VERSION.LENGTH = "3";

            bpt.BPT_INFO.RETURN_STATUS = new XmlNodeEntity();
            bpt.BPT_INFO.RETURN_STATUS = "";
            bpt.BPT_INFO.RETURN_STATUS.Attr_TYPE = "A";
            bpt.BPT_INFO.RETURN_STATUS.LENGTH = "3";

            bpt.BPT_INFO.LAST_UPD_DATE = new XmlNodeEntity();
            bpt.BPT_INFO.LAST_UPD_DATE = "";
            bpt.BPT_INFO.LAST_UPD_DATE.Attr_TYPE = "D";
            bpt.BPT_INFO.LAST_UPD_DATE.LENGTH = "8";

            bpt.BPT_INFO.RECORDING_DATE = new XmlNodeEntity();
            bpt.BPT_INFO.RECORDING_DATE = "";
            bpt.BPT_INFO.RECORDING_DATE.Attr_TYPE = "D";
            bpt.BPT_INFO.RECORDING_DATE.LENGTH = "8";

            bpt.BPT_INFO.EXTENSION_DATE = new XmlNodeEntity();
            bpt.BPT_INFO.EXTENSION_DATE = "";
            bpt.BPT_INFO.EXTENSION_DATE.Attr_TYPE = "D";
            bpt.BPT_INFO.EXTENSION_DATE.LENGTH = "8";

            bpt.BPT_INFO.SEQUENCE = new XmlNodeEntity();
            bpt.BPT_INFO.SEQUENCE = "";
            bpt.BPT_INFO.SEQUENCE.Attr_TYPE = "A";
            bpt.BPT_INFO.SEQUENCE.LENGTH = "5";

            bpt.BPT_INFO.ADJUSTMENT_REF_NO = new XmlNodeEntity();
            bpt.BPT_INFO.ADJUSTMENT_REF_NO = "";
            bpt.BPT_INFO.ADJUSTMENT_REF_NO.Attr_TYPE = "A";
            bpt.BPT_INFO.ADJUSTMENT_REF_NO.LENGTH = "10";


            bpt.BPT_INFO.USER_ID = new XmlNodeEntity();
            bpt.BPT_INFO.USER_ID = "";
            bpt.BPT_INFO.USER_ID.Attr_TYPE = "A";
            bpt.BPT_INFO.USER_ID.LENGTH = "8";

            bpt.BPT_INFO.NET_RATE = new XmlNodeEntity();
            bpt.BPT_INFO.NET_RATE = "";
            bpt.BPT_INFO.NET_RATE.Attr_TYPE = "N";
            bpt.BPT_INFO.NET_RATE.LENGTH = "9";
            bpt.BPT_INFO.NET_RATE.PERCISION = "6";

            bpt.BPT_INFO.GROSS_RATE = new XmlNodeEntity();
            bpt.BPT_INFO.GROSS_RATE = "";
            bpt.BPT_INFO.GROSS_RATE.Attr_TYPE = "N";
            bpt.BPT_INFO.GROSS_RATE.LENGTH = "9";
            bpt.BPT_INFO.GROSS_RATE.PERCISION = "6";

            bpt.BPT_INFO.PREPARER_NAME = new XmlNodeEntity();
            bpt.BPT_INFO.PREPARER_NAME = "";
            bpt.BPT_INFO.PREPARER_NAME.Attr_TYPE = "A";
            bpt.BPT_INFO.PREPARER_NAME.LENGTH = "40";

            bpt.BPT_INFO.PREPARER_PHONE = new XmlNodeEntity();
            bpt.BPT_INFO.PREPARER_PHONE = "";
            bpt.BPT_INFO.PREPARER_PHONE.Attr_TYPE = "P";
            bpt.BPT_INFO.PREPARER_PHONE.LENGTH = "10";

            bpt.BPT_INFO.PREPARER_PHONE_EXT = new XmlNodeEntity();
            bpt.BPT_INFO.PREPARER_PHONE_EXT = "";
            bpt.BPT_INFO.PREPARER_PHONE_EXT.Attr_TYPE = "A";
            bpt.BPT_INFO.PREPARER_PHONE_EXT.LENGTH = "5";

            bpt.BPT_INFO.PREPARER_IP_ADDRESS = new XmlNodeEntity();
            bpt.BPT_INFO.PREPARER_IP_ADDRESS = "";
            bpt.BPT_INFO.PREPARER_IP_ADDRESS.Attr_TYPE = "A";
            bpt.BPT_INFO.PREPARER_IP_ADDRESS.LENGTH = "15";

            bpt.BPT_INFO.PREPARER_EMAIL_ADDRESS = new XmlNodeEntity();
            bpt.BPT_INFO.PREPARER_EMAIL_ADDRESS = "";
            bpt.BPT_INFO.PREPARER_EMAIL_ADDRESS.Attr_TYPE = "A";
            bpt.BPT_INFO.PREPARER_EMAIL_ADDRESS.LENGTH = "60";

            bpt.BPT_INFO.PREPARER_WHO = new XmlNodeEntity();
            bpt.BPT_INFO.PREPARER_WHO = "";
            bpt.BPT_INFO.PREPARER_WHO.Attr_TYPE = "A";
            bpt.BPT_INFO.PREPARER_WHO.LENGTH = "1";

            //BPT_PG1
            bpt.BPT_PG1 = new RTTIE037_2014.BPT_PG1();
            bpt.BPT_PG1.Attr_TYPE = "COMPLEX";
            bpt.BPT_PG1.OCCURS = "1";
            bpt.BPT_PG1.LENGTH = "210";
            bpt.BPT_PG1.EXPORT = "Y";

            bpt.BPT_PG1.NET_TAX = new XmlNodeEntity();
            bpt.BPT_PG1.NET_TAX = "";
            bpt.BPT_PG1.NET_TAX.Attr_TYPE = "C";
            bpt.BPT_PG1.NET_TAX.LENGTH = "15";

            bpt.BPT_PG1.GROSS_TAX = new XmlNodeEntity();
            bpt.BPT_PG1.GROSS_TAX = "";
            bpt.BPT_PG1.GROSS_TAX.Attr_TYPE = "C";
            bpt.BPT_PG1.GROSS_TAX.LENGTH = "15";

            bpt.BPT_PG1.ACTUAL_TAX = new XmlNodeEntity();
            bpt.BPT_PG1.ACTUAL_TAX = "";
            bpt.BPT_PG1.ACTUAL_TAX.Attr_TYPE = "C";
            bpt.BPT_PG1.ACTUAL_TAX.LENGTH = "15";

            bpt.BPT_PG1.ESTIMATED_TAX = new XmlNodeEntity();
            bpt.BPT_PG1.ESTIMATED_TAX = "";
            bpt.BPT_PG1.ESTIMATED_TAX.Attr_TYPE = "C";
            bpt.BPT_PG1.ESTIMATED_TAX.LENGTH = "15";

            bpt.BPT_PG1.TOTAL_TAX = new XmlNodeEntity();
            bpt.BPT_PG1.TOTAL_TAX = "";
            bpt.BPT_PG1.TOTAL_TAX.Attr_TYPE = "C";
            bpt.BPT_PG1.TOTAL_TAX.LENGTH = "15";

            bpt.BPT_PG1.NPT_TAX_CREDIT = new XmlNodeEntity();
            bpt.BPT_PG1.NPT_TAX_CREDIT = "";
            bpt.BPT_PG1.NPT_TAX_CREDIT.Attr_TYPE = "C";
            bpt.BPT_PG1.NPT_TAX_CREDIT.LENGTH = "15";

            bpt.BPT_PG1.BPT_TAX_CREDIT = new XmlNodeEntity();
            bpt.BPT_PG1.BPT_TAX_CREDIT = "";
            bpt.BPT_PG1.BPT_TAX_CREDIT.Attr_TYPE = "C";
            bpt.BPT_PG1.BPT_TAX_CREDIT.LENGTH = "15";

            bpt.BPT_PG1.TOTAL_PAY_CREDITS = new XmlNodeEntity();
            bpt.BPT_PG1.TOTAL_PAY_CREDITS = "";
            bpt.BPT_PG1.TOTAL_PAY_CREDITS.Attr_TYPE = "C";
            bpt.BPT_PG1.TOTAL_PAY_CREDITS.LENGTH = "15";

            bpt.BPT_PG1.TAX_DUE = new XmlNodeEntity();
            bpt.BPT_PG1.TAX_DUE = "TAX_DUE";
            bpt.BPT_PG1.TAX_DUE.Attr_TYPE = "C";
            bpt.BPT_PG1.TAX_DUE.LENGTH = "15";

            bpt.BPT_PG1.INTEREST_PENALTY = new XmlNodeEntity();
            bpt.BPT_PG1.INTEREST_PENALTY = "";
            bpt.BPT_PG1.INTEREST_PENALTY.Attr_TYPE = "C";
            bpt.BPT_PG1.INTEREST_PENALTY.LENGTH = "15";

            bpt.BPT_PG1.AMOUNT_OWED = new XmlNodeEntity();
            bpt.BPT_PG1.AMOUNT_OWED = "";
            bpt.BPT_PG1.AMOUNT_OWED.Attr_TYPE = "C";
            bpt.BPT_PG1.AMOUNT_OWED.LENGTH = "15";

            bpt.BPT_PG1.REFUND = new XmlNodeEntity();
            bpt.BPT_PG1.REFUND = "";
            bpt.BPT_PG1.REFUND.Attr_TYPE = "C";
            bpt.BPT_PG1.REFUND.LENGTH = "15";

            bpt.BPT_PG1.NPT_OVERPAY = new XmlNodeEntity();
            bpt.BPT_PG1.NPT_OVERPAY = "";
            bpt.BPT_PG1.NPT_OVERPAY.Attr_TYPE = "C";
            bpt.BPT_PG1.NPT_OVERPAY.LENGTH = "15";

            bpt.BPT_PG1.BPT_OVERPAY = new XmlNodeEntity();
            bpt.BPT_PG1.BPT_OVERPAY = "";
            bpt.BPT_PG1.BPT_OVERPAY.Attr_TYPE = "C";
            bpt.BPT_PG1.BPT_OVERPAY.LENGTH = "15";

            //BPT_PG2
            bpt.BPT_PG2 = new RTTIE037_2014.BPT_PG2();
            bpt.BPT_PG2.Attr_TYPE = "COMPLEX";
            bpt.BPT_PG2.OCCURS = "1";
            bpt.BPT_PG2.LENGTH = "240";
            bpt.BPT_PG2.EXPORT = "Y";

            bpt.BPT_PG2.NET_INCOME_LOSS_1 = new XmlNodeEntity();
            bpt.BPT_PG2.NET_INCOME_LOSS_1 = "";
            bpt.BPT_PG2.NET_INCOME_LOSS_1.Attr_TYPE = "C";
            bpt.BPT_PG2.NET_INCOME_LOSS_1.LENGTH = "15";

            bpt.BPT_PG2.NET_INCOME_LOSS_2 = new XmlNodeEntity();
            bpt.BPT_PG2.NET_INCOME_LOSS_2 = "";
            bpt.BPT_PG2.NET_INCOME_LOSS_2.Attr_TYPE = "C";
            bpt.BPT_PG2.NET_INCOME_LOSS_2.LENGTH = "15";

            bpt.BPT_PG2.LOSS_CARRY_FORWARD = new XmlNodeEntity();
            bpt.BPT_PG2.LOSS_CARRY_FORWARD = "";
            bpt.BPT_PG2.LOSS_CARRY_FORWARD.Attr_TYPE = "C";
            bpt.BPT_PG2.LOSS_CARRY_FORWARD.LENGTH = "15";

            bpt.BPT_PG2.TAXABLE_INCOME = new XmlNodeEntity();
            bpt.BPT_PG2.TAXABLE_INCOME = "";
            bpt.BPT_PG2.TAXABLE_INCOME.Attr_TYPE = "C";
            bpt.BPT_PG2.TAXABLE_INCOME.LENGTH = "15";

            bpt.BPT_PG2.TAX_DUE_NET = new XmlNodeEntity();
            bpt.BPT_PG2.TAX_DUE_NET = "";
            bpt.BPT_PG2.TAX_DUE_NET.Attr_TYPE = "C";
            bpt.BPT_PG2.TAX_DUE_NET.LENGTH = "15";

            bpt.BPT_PG2.SALES_RENTAL = new XmlNodeEntity();
            bpt.BPT_PG2.SALES_RENTAL = "";
            bpt.BPT_PG2.SALES_RENTAL.Attr_TYPE = "C";
            bpt.BPT_PG2.SALES_RENTAL.LENGTH = "15";

            bpt.BPT_PG2.SERVICES = new XmlNodeEntity();
            bpt.BPT_PG2.SERVICES = "";
            bpt.BPT_PG2.SERVICES.Attr_TYPE = "C";
            bpt.BPT_PG2.SERVICES.LENGTH = "15";

            bpt.BPT_PG2.RENTAL_PROPERTY = new XmlNodeEntity();
            bpt.BPT_PG2.RENTAL_PROPERTY = "";
            bpt.BPT_PG2.RENTAL_PROPERTY.Attr_TYPE = "C";
            bpt.BPT_PG2.RENTAL_PROPERTY.LENGTH = "15";

            bpt.BPT_PG2.ROYALTIES = new XmlNodeEntity();
            bpt.BPT_PG2.ROYALTIES = "";
            bpt.BPT_PG2.ROYALTIES.Attr_TYPE = "C";
            bpt.BPT_PG2.ROYALTIES.LENGTH = "15";

            bpt.BPT_PG2.CAPITAL_GAINS = new XmlNodeEntity();
            bpt.BPT_PG2.CAPITAL_GAINS = "";
            bpt.BPT_PG2.CAPITAL_GAINS.Attr_TYPE = "C";
            bpt.BPT_PG2.CAPITAL_GAINS.LENGTH = "15";

            bpt.BPT_PG2.STOCK_GAINS = new XmlNodeEntity();
            bpt.BPT_PG2.STOCK_GAINS = "";
            bpt.BPT_PG2.STOCK_GAINS.Attr_TYPE = "C";
            bpt.BPT_PG2.STOCK_GAINS.LENGTH = "15";

            bpt.BPT_PG2.DIVIDENDS = new XmlNodeEntity();
            bpt.BPT_PG2.DIVIDENDS = "";
            bpt.BPT_PG2.DIVIDENDS.Attr_TYPE = "C";
            bpt.BPT_PG2.DIVIDENDS.LENGTH = "15";

            bpt.BPT_PG2.INTEREST = new XmlNodeEntity();
            bpt.BPT_PG2.INTEREST = "";
            bpt.BPT_PG2.INTEREST.Attr_TYPE = "C";
            bpt.BPT_PG2.INTEREST.LENGTH = "15";

            bpt.BPT_PG2.OTHER = new XmlNodeEntity();
            bpt.BPT_PG2.OTHER = "";
            bpt.BPT_PG2.OTHER.Attr_TYPE = "C";
            bpt.BPT_PG2.OTHER.LENGTH = "15";

            bpt.BPT_PG2.TAXABLE_GROSS_RCPTS = new XmlNodeEntity();
            bpt.BPT_PG2.TAXABLE_GROSS_RCPTS = "";
            bpt.BPT_PG2.TAXABLE_GROSS_RCPTS.Attr_TYPE = "C";
            bpt.BPT_PG2.TAXABLE_GROSS_RCPTS.LENGTH = "15";

            bpt.BPT_PG2.TAX_DUE_GROSS = new XmlNodeEntity();
            bpt.BPT_PG2.TAX_DUE_GROSS = "";
            bpt.BPT_PG2.TAX_DUE_GROSS.Attr_TYPE = "C";
            bpt.BPT_PG2.TAX_DUE_GROSS.LENGTH = "15";

            bpt.BPT_PG2.STAT_NET_DEDUCTION_1_X = new XmlNodeEntity();
            bpt.BPT_PG2.STAT_NET_DEDUCTION_1_X = "";
            bpt.BPT_PG2.STAT_NET_DEDUCTION_1_X.Attr_TYPE = "C";
            bpt.BPT_PG2.STAT_NET_DEDUCTION_1_X.LENGTH = "15";

            bpt.BPT_PG2.TAXABLE_SUBTOTAL_EZ_X = new XmlNodeEntity();
            bpt.BPT_PG2.TAXABLE_SUBTOTAL_EZ_X = "";
            bpt.BPT_PG2.TAXABLE_SUBTOTAL_EZ_X.Attr_TYPE = "C";
            bpt.BPT_PG2.TAXABLE_SUBTOTAL_EZ_X.LENGTH = "15";

            bpt.BPT_PG2.STAT_EXCLUSION_EZ_X = new XmlNodeEntity();
            bpt.BPT_PG2.STAT_EXCLUSION_EZ_X = "";
            bpt.BPT_PG2.STAT_EXCLUSION_EZ_X.Attr_TYPE = "C";
            bpt.BPT_PG2.STAT_EXCLUSION_EZ_X.LENGTH = "15";

            //HEADER_INFO
            bpt.HEADER_INFO = new HEADER_INFO();
            bpt.HEADER_INFO.ENVIRONMENT = "";

            //DEBUG
            bpt.DEBUG = new DEBUG();

            return bpt;
        }
    }
}
