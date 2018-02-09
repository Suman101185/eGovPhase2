using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace COPXmlFactory
{
    namespace RTTIE027
    {
        [XmlRoot(ElementName = "WAGERETURN")]
        public class WAGERETURN : ICOPXmlTemplate
        {
            [XmlElement]
            public ERROR_INFO ERROR_INFO { set; get; }
            [XmlElement]
            public WAGE_INFO WAGE_INFO { set; get; }
            [XmlElement]
            public AMT_INFO AMT_INFO { set; get; }
            [XmlElement]
            public HEADER_INFO HEADER_INFO { set; get; }
            [XmlElement]
            public DEBUG DEBUG { set; get; }
        }

        public class WAGE_INFO : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity ACCOUNT_ID { set; get; }
            [XmlElement]
            public XmlNodeEntity PERIOD { set; get; }
            [XmlElement]
            public XmlNodeEntity VERSION { set; get; }
            [XmlElement]
            public XmlNodeEntity DOCUMENT_CONTROL { set; get; }
            [XmlElement]
            public XmlNodeEntity ADJ_REFNO_CONTROL { set; get; }
            [XmlElement]
            public XmlNodeEntity ENTITY_ID { set; get; }
            [XmlElement]
            public XmlNodeEntity RETURN_STATUS { set; get; }
            [XmlElement]
            public XmlNodeEntity SEQUENCE { set; get; }
            [XmlElement]
            public XmlNodeEntity LAST_UPD_DATE { set; get; }
            [XmlElement]
            public XmlNodeEntity NO_OF_RESIDENTS { set; get; }
            [XmlElement]
            public XmlNodeEntity NO_OF_NONRESIDENTS { set; get; }
            [XmlElement]
            public XmlNodeEntity PHILA_EMPLOYEES { set; get; }
            [XmlElement]
            public XmlNodeEntity TOTAL_EMPLOYEES { set; get; }
            [XmlElement]
            public XmlNodeEntity RESTAX_A { set; get; }
            [XmlElement]
            public XmlNodeEntity RESTAX_B { set; get; }
            [XmlElement]
            public XmlNodeEntity NONRESTAX_A { set; get; }
            [XmlElement]
            public XmlNodeEntity NONRESTAX_B { set; get; }
            [XmlElement]
            public XmlNodeEntity FREQUENCY { set; get; }
            [XmlElement]
            public XmlNodeEntity DUE_DATE { set; get; }
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
            public XmlNodeEntity GROSS_COMP { set; get; }
            [XmlElement]
            public XmlNodeEntity TIPS_WAGES { set; get; }
            [XmlElement]
            public XmlNodeEntity NON_TAXABLE_COMP { set; get; }
            [XmlElement]
            public XmlNodeEntity NET_COMP { set; get; }
            [XmlElement]
            public XmlNodeEntity RESIDENT_PAYROLL_A { set; get; }
            [XmlElement]
            public XmlNodeEntity RESIDENT_TAX_DUE_A { set; get; }
            [XmlElement]
            public XmlNodeEntity RESIDENT_PAYROLL_B { set; get; }
            [XmlElement]
            public XmlNodeEntity RESIDENT_TAX_DUE_B { set; get; }
            [XmlElement]
            public XmlNodeEntity NON_RES_PAYROLL_A { set; get; }
            [XmlElement]
            public XmlNodeEntity NON_RES_TAX_DUE_A { set; get; }
            [XmlElement]
            public XmlNodeEntity NON_RES_PAYROLL_B { set; get; }
            [XmlElement]
            public XmlNodeEntity NON_RES_TAX_DUE_B { set; get; }
            [XmlElement]
            public XmlNodeEntity TOTAL_GROSS_TAX_DUE { set; get; }
            [XmlElement]
            public XmlNodeEntity TAX_PAID { set; get; }
            [XmlElement]
            public XmlNodeEntity TAX_DUE { set; get; }
            [XmlElement]
            public XmlNodeEntity TAX_OVERPAID { set; get; }
            [XmlElement]
            public XmlNodeEntity POSTING_DATE { set; get; }
            [XmlElement]
            public XmlNodeEntity FILING_DATE { set; get; }
            [XmlElement]
            public XmlNodeEntity USER_ID { set; get; }
        }
    }
}
