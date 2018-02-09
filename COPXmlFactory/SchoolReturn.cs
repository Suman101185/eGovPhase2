using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace COPXmlFactory
{
    namespace RTTIE036
    {
        [XmlRoot(ElementName = "SCHOOLRETURN")]
        public class SCHOOLRETURN : ICOPXmlTemplate
        {
            [XmlElement]
            public ERROR_INFO ERROR_INFO { set; get; }
            [XmlElement]
            public SCHOOL_INFO SCHOOL_INFO { set; get; }
            [XmlElement]
            public AMT_INFO AMT_INFO { set; get; }
            [XmlElement]
            public HEADER_INFO HEADER_INFO { set; get; }
            [XmlElement]
            public DEBUG DEBUG { set; get; }
        }

        public class SCHOOL_INFO : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity ACCOUNT_ID { set; get; }
            [XmlElement]
            public XmlNodeEntity PERIOD { set; get; }
            [XmlElement]
            public XmlNodeEntity VERSION { set; get; }
            [XmlElement]
            public XmlNodeEntity RETURN_STATUS { set; get; }
            [XmlElement]
            public XmlNodeEntity LAST_UPD_DATE { set; get; }           
            [XmlElement]
            public XmlNodeEntity RECORDING_DATE { set; get; }
            [XmlElement]
            public XmlNodeEntity EXTENSION_DATE { set; get; }
            [XmlElement]
            public XmlNodeEntity SEQUENCE { set; get; }
            [XmlElement]
            public XmlNodeEntity ADJUSTMENT_REF_NO { set; get; }
            [XmlElement]
            public XmlNodeEntity RATE { set; get; }
            [XmlElement]
            public XmlNodeEntity PREPARER_NAME { set; get; }
            [XmlElement]
            public XmlNodeEntity PREPARER_PHONE { set; get; }
            [XmlElement]
            public XmlNodeEntity PREPARER_PHONE_EXT { set; get; }
            [XmlElement]
            public XmlNodeEntity PREPARER_IP_ADDRESS { set; get; }
            [XmlElement]
            public XmlNodeEntity PREPARER_EMAIL_ADDRESS { set; get; }
            [XmlElement]
            public XmlNodeEntity PREPARER_WHO { set; get; }

        }
        public class AMT_INFO : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity NET_TAX_DIVIDENDS { set; get; }
            [XmlElement]
            public XmlNodeEntity TAXABLE_INTEREST { set; get; }
            [XmlElement]
            public XmlNodeEntity S_CORP_DISTRIBUTIONS { set; get; }
            [XmlElement]
            public XmlNodeEntity PARTNERSHIP_INCOME { set; get; }
            [XmlElement]
            public XmlNodeEntity BENEFICIARY_INCOME { set; get; }
            [XmlElement]
            public XmlNodeEntity SHORT_TERM_GAINS { set; get; }
            [XmlElement]
            public XmlNodeEntity NET_RENTAL_INCOME { set; get; }
            [XmlElement]
            public XmlNodeEntity OTHER_TAXABLE_INCOME { set; get; }
            [XmlElement]
            public XmlNodeEntity TOTAL_TAXABLE_INCOME { set; get; }
            [XmlElement]
            public XmlNodeEntity DEDUCTIBLE_EXPENSES { set; get; }
            [XmlElement]
            public XmlNodeEntity NET_TAXABLE_INCOME { set; get; }
            [XmlElement]
            public XmlNodeEntity GROSS_TAX_DUE { set; get; }
            [XmlElement]
            public XmlNodeEntity TAX_DUE { set; get; }
            [XmlElement]
            public XmlNodeEntity CREDITS { set; get; }
            [XmlElement]
            public XmlNodeEntity TAX_REFUND { set; get; }
            [XmlElement]
            public XmlNodeEntity TAX_OVERPAID { set; get; }
            [XmlElement]
            public XmlNodeEntity USER_ID { set; get; }
            
        }
    }
}
