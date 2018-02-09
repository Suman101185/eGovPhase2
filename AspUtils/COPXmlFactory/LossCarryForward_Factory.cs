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
        /// This method is used to create the object of LossCarryForward 
        /// </summary>
        /// <returns></returns>
        /// 
        public static RTTIE031.LossCarryForward GetLossCarryForwardReturn()
        {
            RTTIE031.LossCarryForward lcf = new RTTIE031.LossCarryForward();

            //Errorinfo
            lcf.ERROR_INFO = new ERROR_INFO();
            lcf.ERROR_INFO.Attr_TYPE = "COMPLEX";
            lcf.ERROR_INFO.OCCURS = "1";
            lcf.ERROR_INFO.LENGTH = "79";
            lcf.ERROR_INFO.EXPORT = "N";

            lcf.ERROR_INFO.PROGRAM = new XmlNodeEntity();
            lcf.ERROR_INFO.PROGRAM = "";
            lcf.ERROR_INFO.PROGRAM.Attr_TYPE = "A";
            lcf.ERROR_INFO.PROGRAM.LENGTH = "12";

            lcf.ERROR_INFO.ERROR = new XmlNodeEntity();
            lcf.ERROR_INFO.ERROR = "";
            lcf.ERROR_INFO.ERROR.Attr_TYPE = "N";
            lcf.ERROR_INFO.ERROR.LENGTH = "7";

            lcf.ERROR_INFO.LINE = new XmlNodeEntity();
            lcf.ERROR_INFO.LINE = "";
            lcf.ERROR_INFO.LINE.Attr_TYPE = "N";
            lcf.ERROR_INFO.LINE.LENGTH = "4";

            lcf.ERROR_INFO.MESSAGE = new XmlNodeEntity();
            lcf.ERROR_INFO.MESSAGE = "";
            lcf.ERROR_INFO.MESSAGE.Attr_TYPE = "A";
            lcf.ERROR_INFO.MESSAGE.LENGTH = "60";

            //lcf_INFO
            lcf.LCF_INFO = new RTTIE031.LCF_INFO();
            lcf.LCF_INFO.Attr_TYPE = "COMPLEX";
            lcf.LCF_INFO.OCCURS = "1";
            lcf.LCF_INFO.LENGTH = "203";
            lcf.LCF_INFO.EXPORT = "Y";


            lcf.LCF_INFO.ACCOUNT_ID = new XmlNodeEntity();
            lcf.LCF_INFO.ACCOUNT_ID = "";
            lcf.LCF_INFO.ACCOUNT_ID.Attr_TYPE = "A";
            lcf.LCF_INFO.ACCOUNT_ID.LENGTH = "12";

            lcf.LCF_INFO.YEAR_X = new XmlNodeEntity();
            lcf.LCF_INFO.YEAR_X = "";
            lcf.LCF_INFO.YEAR_X.Attr_TYPE = "A";
            lcf.LCF_INFO.YEAR_X.LENGTH = "4";

            lcf.LCF_INFO.EST_PAID_X = new XmlNodeEntity();
            lcf.LCF_INFO.EST_PAID_X = "";
            lcf.LCF_INFO.EST_PAID_X.Attr_TYPE = "C";
            lcf.LCF_INFO.EST_PAID_X.LENGTH = "11";

            lcf.LCF_INFO.YEAR = new XmlNodeEntity();
            lcf.LCF_INFO.YEAR = "";
            lcf.LCF_INFO.YEAR.Attr_TYPE = "A";
            lcf.LCF_INFO.YEAR.LENGTH = "4";

            lcf.LCF_INFO.AMOUNT = new XmlNodeEntity();
            lcf.LCF_INFO.AMOUNT = "";
            lcf.LCF_INFO.AMOUNT.Attr_TYPE = "C";
            lcf.LCF_INFO.AMOUNT.LENGTH = "15";

            lcf.LCF_INFO.COMMENT = new XmlNodeEntity();
            lcf.LCF_INFO.COMMENT = "";
            lcf.LCF_INFO.COMMENT.Attr_TYPE = "A";
            lcf.LCF_INFO.COMMENT.LENGTH = "25";

            lcf.LCF_INFO.YEAR_1 = new XmlNodeEntity();
            lcf.LCF_INFO.YEAR_1 = "";
            lcf.LCF_INFO.YEAR_1.Attr_TYPE = "A";
            lcf.LCF_INFO.YEAR_1.LENGTH = "4";

            lcf.LCF_INFO.INCOME_1 = new XmlNodeEntity();
            lcf.LCF_INFO.INCOME_1 = "";
            lcf.LCF_INFO.INCOME_1.Attr_TYPE = "C";
            lcf.LCF_INFO.INCOME_1.LENGTH = "15";

            lcf.LCF_INFO.COMMENT_1 = new XmlNodeEntity();
            lcf.LCF_INFO.COMMENT_1 = "";
            lcf.LCF_INFO.COMMENT_1.Attr_TYPE = "A";
            lcf.LCF_INFO.COMMENT_1.LENGTH = "25";

            lcf.LCF_INFO.YEAR_2 = new XmlNodeEntity();
            lcf.LCF_INFO.YEAR_2 = "";
            lcf.LCF_INFO.YEAR_2.Attr_TYPE = "A";
            lcf.LCF_INFO.YEAR_2.LENGTH = "4";

            lcf.LCF_INFO.INCOME_2 = new XmlNodeEntity();
            lcf.LCF_INFO.INCOME_2 = "";
            lcf.LCF_INFO.INCOME_2.Attr_TYPE = "C";
            lcf.LCF_INFO.INCOME_2.LENGTH = "15";

            lcf.LCF_INFO.COMMENT_2 = new XmlNodeEntity();
            lcf.LCF_INFO.COMMENT_2 = "";
            lcf.LCF_INFO.COMMENT_2.Attr_TYPE = "A";
            lcf.LCF_INFO.COMMENT_2.LENGTH = "25";

            lcf.LCF_INFO.YEAR_3 = new XmlNodeEntity();
            lcf.LCF_INFO.YEAR_3 = "";
            lcf.LCF_INFO.YEAR_3.Attr_TYPE = "A";
            lcf.LCF_INFO.YEAR_3.LENGTH = "4";

            lcf.LCF_INFO.INCOME_3 = new XmlNodeEntity();
            lcf.LCF_INFO.INCOME_3 = "";
            lcf.LCF_INFO.INCOME_3.Attr_TYPE = "C";
            lcf.LCF_INFO.INCOME_3.LENGTH = "15";

            lcf.LCF_INFO.COMMENT_3 = new XmlNodeEntity();
            lcf.LCF_INFO.COMMENT_3 = "";
            lcf.LCF_INFO.COMMENT_3.Attr_TYPE = "A";
            lcf.LCF_INFO.COMMENT_3.LENGTH = "25";

            //HEADER_INFO
            lcf.HEADER_INFO = new HEADER_INFO();
            lcf.HEADER_INFO.ENVIRONMENT = "";

            //DEBUG
            lcf.DEBUG = new DEBUG();

            return lcf;
        }
    }
}
