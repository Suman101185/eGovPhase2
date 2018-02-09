using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using COPXmlFactory.RTTIE027;

namespace COPXmlFactory
{
    public partial class RevenueGovXMLFactory : XMLFactory
    {
        /// <summary>
        /// This method is used to create the object of WAGERETURN 
        /// </summary>
        /// <returns></returns>
        /// 
        public static RTTIE027.WAGERETURN GetWageReturn()
        {
            RTTIE027.WAGERETURN wg = new RTTIE027.WAGERETURN();

            //Errorinfo
            wg.ERROR_INFO = new ERROR_INFO();
            wg.ERROR_INFO.Attr_TYPE = "COMPLEX";
            wg.ERROR_INFO.OCCURS = "1";
            wg.ERROR_INFO.LENGTH = "79";
            wg.ERROR_INFO.EXPORT = "N";

            wg.ERROR_INFO.PROGRAM = new XmlNodeEntity();
            wg.ERROR_INFO.PROGRAM = "";
            wg.ERROR_INFO.PROGRAM.Attr_TYPE = "A";
            wg.ERROR_INFO.PROGRAM.LENGTH = "8";

            wg.ERROR_INFO.ERROR = new XmlNodeEntity();
            wg.ERROR_INFO.ERROR = "";
            wg.ERROR_INFO.ERROR.Attr_TYPE = "N";
            wg.ERROR_INFO.ERROR.LENGTH = "7";

            wg.ERROR_INFO.LINE = new XmlNodeEntity();
            wg.ERROR_INFO.LINE = "";
            wg.ERROR_INFO.LINE.Attr_TYPE = "N";
            wg.ERROR_INFO.LINE.LENGTH = "4";

            wg.ERROR_INFO.MESSAGE = new XmlNodeEntity();
            wg.ERROR_INFO.MESSAGE = "";
            wg.ERROR_INFO.MESSAGE.Attr_TYPE = "A";
            wg.ERROR_INFO.MESSAGE.LENGTH = "60";

            //WAGE_INFO
            wg.WAGE_INFO = new WAGE_INFO();
            wg.WAGE_INFO.Attr_TYPE = "COMPLEX";
            wg.WAGE_INFO.OCCURS = "1";
            wg.WAGE_INFO.LENGTH = "271";
            wg.WAGE_INFO.EXPORT = "Y";

            wg.WAGE_INFO.ACCOUNT_ID = new XmlNodeEntity();
            wg.WAGE_INFO.ACCOUNT_ID = "";
            wg.WAGE_INFO.ACCOUNT_ID.Attr_TYPE = "A";
            wg.WAGE_INFO.ACCOUNT_ID.LENGTH = "12";

            wg.WAGE_INFO.PERIOD = new XmlNodeEntity();
            wg.WAGE_INFO.PERIOD = "";
            wg.WAGE_INFO.PERIOD.Attr_TYPE = "D";
            wg.WAGE_INFO.PERIOD.LENGTH = "8";

            wg.WAGE_INFO.VERSION = new XmlNodeEntity();
            wg.WAGE_INFO.VERSION = "";
            wg.WAGE_INFO.VERSION.Attr_TYPE = "A";
            wg.WAGE_INFO.VERSION.LENGTH = "3";

            wg.WAGE_INFO.DOCUMENT_CONTROL = new XmlNodeEntity();
            wg.WAGE_INFO.DOCUMENT_CONTROL = "";
            wg.WAGE_INFO.DOCUMENT_CONTROL.Attr_TYPE = "A";
            wg.WAGE_INFO.DOCUMENT_CONTROL.LENGTH = "9";

            wg.WAGE_INFO.ADJ_REFNO_CONTROL = new XmlNodeEntity();
            wg.WAGE_INFO.ADJ_REFNO_CONTROL = "";
            wg.WAGE_INFO.ADJ_REFNO_CONTROL.Attr_TYPE = "A";
            wg.WAGE_INFO.ADJ_REFNO_CONTROL.LENGTH = "10";

            wg.WAGE_INFO.ENTITY_ID = new XmlNodeEntity();
            wg.WAGE_INFO.ENTITY_ID = "";
            wg.WAGE_INFO.ENTITY_ID.Attr_TYPE = "A";
            wg.WAGE_INFO.ENTITY_ID.LENGTH = "9";

            wg.WAGE_INFO.RETURN_STATUS = new XmlNodeEntity();
            wg.WAGE_INFO.RETURN_STATUS = "";
            wg.WAGE_INFO.RETURN_STATUS.Attr_TYPE = "A";
            wg.WAGE_INFO.RETURN_STATUS.LENGTH = "3";

            wg.WAGE_INFO.SEQUENCE = new XmlNodeEntity();
            wg.WAGE_INFO.SEQUENCE = "";
            wg.WAGE_INFO.SEQUENCE.Attr_TYPE = "A";
            wg.WAGE_INFO.SEQUENCE.LENGTH = "5";

            wg.WAGE_INFO.LAST_UPD_DATE = new XmlNodeEntity();
            wg.WAGE_INFO.LAST_UPD_DATE = "";
            wg.WAGE_INFO.LAST_UPD_DATE.Attr_TYPE = "D";
            wg.WAGE_INFO.LAST_UPD_DATE.LENGTH = "8";

            wg.WAGE_INFO.NO_OF_RESIDENTS = new XmlNodeEntity();
            wg.WAGE_INFO.NO_OF_RESIDENTS = "";
            wg.WAGE_INFO.NO_OF_RESIDENTS.Attr_TYPE = "N";
            wg.WAGE_INFO.NO_OF_RESIDENTS.LENGTH = "7";

            wg.WAGE_INFO.NO_OF_NONRESIDENTS = new XmlNodeEntity();
            wg.WAGE_INFO.NO_OF_NONRESIDENTS = "";
            wg.WAGE_INFO.NO_OF_NONRESIDENTS.Attr_TYPE = "N";
            wg.WAGE_INFO.NO_OF_NONRESIDENTS.LENGTH = "7";

            wg.WAGE_INFO.PHILA_EMPLOYEES = new XmlNodeEntity();
            wg.WAGE_INFO.PHILA_EMPLOYEES = "";
            wg.WAGE_INFO.PHILA_EMPLOYEES.Attr_TYPE = "N";
            wg.WAGE_INFO.PHILA_EMPLOYEES.LENGTH = "7";

            wg.WAGE_INFO.TOTAL_EMPLOYEES = new XmlNodeEntity();
            wg.WAGE_INFO.TOTAL_EMPLOYEES = "";
            wg.WAGE_INFO.TOTAL_EMPLOYEES.Attr_TYPE = "N";
            wg.WAGE_INFO.TOTAL_EMPLOYEES.LENGTH = "7";

            wg.WAGE_INFO.RESTAX_A = new XmlNodeEntity();
            wg.WAGE_INFO.RESTAX_A = "";
            wg.WAGE_INFO.RESTAX_A.Attr_TYPE = "N";
            wg.WAGE_INFO.RESTAX_A.LENGTH = "9";
            wg.WAGE_INFO.RESTAX_A.PERCISION = "6";

            wg.WAGE_INFO.RESTAX_B = new XmlNodeEntity();
            wg.WAGE_INFO.RESTAX_B = "";
            wg.WAGE_INFO.RESTAX_B.Attr_TYPE = "N";
            wg.WAGE_INFO.RESTAX_B.LENGTH = "7";
            wg.WAGE_INFO.RESTAX_B.PERCISION = "6";

            wg.WAGE_INFO.NONRESTAX_A = new XmlNodeEntity();
            wg.WAGE_INFO.NONRESTAX_A = "";
            wg.WAGE_INFO.NONRESTAX_A.Attr_TYPE = "N";
            wg.WAGE_INFO.NONRESTAX_A.LENGTH = "9";
            wg.WAGE_INFO.NONRESTAX_A.PERCISION = "6";

            wg.WAGE_INFO.NONRESTAX_B = new XmlNodeEntity();
            wg.WAGE_INFO.NONRESTAX_B = "";
            wg.WAGE_INFO.NONRESTAX_B.Attr_TYPE = "N";
            wg.WAGE_INFO.NONRESTAX_B.LENGTH = "9";
            wg.WAGE_INFO.NONRESTAX_B.PERCISION = "6";

            wg.WAGE_INFO.FREQUENCY = new XmlNodeEntity();
            wg.WAGE_INFO.FREQUENCY = "";
            wg.WAGE_INFO.FREQUENCY.Attr_TYPE = "A";
            wg.WAGE_INFO.FREQUENCY.LENGTH = "1";

            wg.WAGE_INFO.DUE_DATE = new XmlNodeEntity();
            wg.WAGE_INFO.DUE_DATE = "";
            wg.WAGE_INFO.DUE_DATE.Attr_TYPE = "D";
            wg.WAGE_INFO.DUE_DATE.LENGTH = "8";

            wg.WAGE_INFO.PREPARER_NAME = new XmlNodeEntity();
            wg.WAGE_INFO.PREPARER_NAME = "";
            wg.WAGE_INFO.PREPARER_NAME.Attr_TYPE = "A";
            wg.WAGE_INFO.PREPARER_NAME.LENGTH = "40";

            wg.WAGE_INFO.PREPARER_PHONE = new XmlNodeEntity();
            wg.WAGE_INFO.PREPARER_PHONE = "";
            wg.WAGE_INFO.PREPARER_PHONE.Attr_TYPE = "P";
            wg.WAGE_INFO.PREPARER_PHONE.LENGTH = "10";

            wg.WAGE_INFO.PREPARER_PHONE_EXT = new XmlNodeEntity();
            wg.WAGE_INFO.PREPARER_PHONE_EXT = "";
            wg.WAGE_INFO.PREPARER_PHONE_EXT.Attr_TYPE = "A";
            wg.WAGE_INFO.PREPARER_PHONE_EXT.LENGTH = "5";

            wg.WAGE_INFO.PREPARER_IP_ADDRESS = new XmlNodeEntity();
            wg.WAGE_INFO.PREPARER_IP_ADDRESS = "";
            wg.WAGE_INFO.PREPARER_IP_ADDRESS.Attr_TYPE = "A";
            wg.WAGE_INFO.PREPARER_IP_ADDRESS.LENGTH = "15";

            wg.WAGE_INFO.PREPARER_EMAIL_ADDRESS = new XmlNodeEntity();
            wg.WAGE_INFO.PREPARER_EMAIL_ADDRESS = "";
            wg.WAGE_INFO.PREPARER_EMAIL_ADDRESS.Attr_TYPE = "A";
            wg.WAGE_INFO.PREPARER_EMAIL_ADDRESS.LENGTH = "60";

            wg.WAGE_INFO.PREPARER_WHO = new XmlNodeEntity();
            wg.WAGE_INFO.PREPARER_WHO = "";
            wg.WAGE_INFO.PREPARER_WHO.Attr_TYPE = "A";
            wg.WAGE_INFO.PREPARER_WHO.LENGTH = "1";

            //AMT_INFO
            wg.AMT_INFO = new AMT_INFO();
            wg.AMT_INFO.Attr_TYPE = "COMPLEX";
            wg.AMT_INFO.OCCURS = "1";
            wg.AMT_INFO.LENGTH = "249";
            wg.AMT_INFO.EXPORT = "Y";

            wg.AMT_INFO.GROSS_COMP = new XmlNodeEntity();
            wg.AMT_INFO.GROSS_COMP = "";
            wg.AMT_INFO.GROSS_COMP.Attr_TYPE = "C";
            wg.AMT_INFO.GROSS_COMP.LENGTH = "15";

            wg.AMT_INFO.NON_TAXABLE_COMP = new XmlNodeEntity();
            wg.AMT_INFO.NON_TAXABLE_COMP = "";
            wg.AMT_INFO.NON_TAXABLE_COMP.Attr_TYPE = "C";
            wg.AMT_INFO.NON_TAXABLE_COMP.LENGTH = "15";

            wg.AMT_INFO.RESIDENT_PAYROLL_A = new XmlNodeEntity();
            wg.AMT_INFO.RESIDENT_PAYROLL_A = "";
            wg.AMT_INFO.RESIDENT_PAYROLL_A.Attr_TYPE = "C";
            wg.AMT_INFO.RESIDENT_PAYROLL_A.LENGTH = "15";

            wg.AMT_INFO.RESIDENT_TAX_DUE_A = new XmlNodeEntity();
            wg.AMT_INFO.RESIDENT_TAX_DUE_A = "";
            wg.AMT_INFO.RESIDENT_TAX_DUE_A.Attr_TYPE = "C";
            wg.AMT_INFO.RESIDENT_TAX_DUE_A.LENGTH = "15";

            wg.AMT_INFO.RESIDENT_PAYROLL_B = new XmlNodeEntity();
            wg.AMT_INFO.RESIDENT_PAYROLL_B = "";
            wg.AMT_INFO.RESIDENT_PAYROLL_B.Attr_TYPE = "C";
            wg.AMT_INFO.RESIDENT_PAYROLL_B.LENGTH = "15";

            wg.AMT_INFO.RESIDENT_TAX_DUE_B = new XmlNodeEntity();
            wg.AMT_INFO.RESIDENT_TAX_DUE_B = "";
            wg.AMT_INFO.RESIDENT_TAX_DUE_B.Attr_TYPE = "C";
            wg.AMT_INFO.RESIDENT_TAX_DUE_B.LENGTH = "15";

            wg.AMT_INFO.NON_RES_PAYROLL_A = new XmlNodeEntity();
            wg.AMT_INFO.NON_RES_PAYROLL_A = "";
            wg.AMT_INFO.NON_RES_PAYROLL_A.Attr_TYPE = "C";
            wg.AMT_INFO.NON_RES_PAYROLL_A.LENGTH = "15";

            wg.AMT_INFO.NON_RES_TAX_DUE_A = new XmlNodeEntity();
            wg.AMT_INFO.NON_RES_TAX_DUE_A = "";
            wg.AMT_INFO.NON_RES_TAX_DUE_A.Attr_TYPE = "C";
            wg.AMT_INFO.NON_RES_TAX_DUE_A.LENGTH = "15";

            wg.AMT_INFO.NON_RES_PAYROLL_B = new XmlNodeEntity();
            wg.AMT_INFO.NON_RES_PAYROLL_B = "";
            wg.AMT_INFO.NON_RES_PAYROLL_B.Attr_TYPE = "C";
            wg.AMT_INFO.NON_RES_PAYROLL_B.LENGTH = "15";

            wg.AMT_INFO.NON_RES_TAX_DUE_B = new XmlNodeEntity();
            wg.AMT_INFO.NON_RES_TAX_DUE_B = "";
            wg.AMT_INFO.NON_RES_TAX_DUE_B.Attr_TYPE = "C";
            wg.AMT_INFO.NON_RES_TAX_DUE_B.LENGTH = "15";

            wg.AMT_INFO.NON_RES_TAX_DUE_B = new XmlNodeEntity();
            wg.AMT_INFO.NON_RES_TAX_DUE_B = "";
            wg.AMT_INFO.NON_RES_TAX_DUE_B.Attr_TYPE = "C";
            wg.AMT_INFO.NON_RES_TAX_DUE_B.LENGTH = "15";

            wg.AMT_INFO.TOTAL_GROSS_TAX_DUE = new XmlNodeEntity();
            wg.AMT_INFO.TOTAL_GROSS_TAX_DUE = "";
            wg.AMT_INFO.TOTAL_GROSS_TAX_DUE.Attr_TYPE = "C";
            wg.AMT_INFO.TOTAL_GROSS_TAX_DUE.LENGTH = "15";

            wg.AMT_INFO.TAX_PAID = new XmlNodeEntity();
            wg.AMT_INFO.TAX_PAID = "";
            wg.AMT_INFO.TAX_PAID.Attr_TYPE = "C";
            wg.AMT_INFO.TAX_PAID.LENGTH = "15";

            wg.AMT_INFO.TAX_DUE = new XmlNodeEntity();
            wg.AMT_INFO.TAX_DUE = "";
            wg.AMT_INFO.TAX_DUE.Attr_TYPE = "C";
            wg.AMT_INFO.TAX_DUE.LENGTH = "15";

            wg.AMT_INFO.TAX_OVERPAID = new XmlNodeEntity();
            wg.AMT_INFO.TAX_OVERPAID = "";
            wg.AMT_INFO.TAX_OVERPAID.Attr_TYPE = "C";
            wg.AMT_INFO.TAX_OVERPAID.LENGTH = "15";

            wg.AMT_INFO.POSTING_DATE = new XmlNodeEntity();
            wg.AMT_INFO.POSTING_DATE = "";
            wg.AMT_INFO.POSTING_DATE.Attr_TYPE = "D";
            wg.AMT_INFO.POSTING_DATE.LENGTH = "8";

            wg.AMT_INFO.FILING_DATE = new XmlNodeEntity();
            wg.AMT_INFO.FILING_DATE = "";
            wg.AMT_INFO.FILING_DATE.Attr_TYPE = "D";
            wg.AMT_INFO.FILING_DATE.LENGTH = "8";

            wg.AMT_INFO.USER_ID = new XmlNodeEntity();
            wg.AMT_INFO.USER_ID = "";
            wg.AMT_INFO.USER_ID.Attr_TYPE = "A";
            wg.AMT_INFO.USER_ID.LENGTH = "8";

           
            return wg;
        }
    }
}
