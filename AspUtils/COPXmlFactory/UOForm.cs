using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace COPXmlFactory
{
    namespace RTTIE035
    {
        [XmlRoot(ElementName = "UOFORM")]
        public class UOFORM : ICOPXmlTemplate
        {
            [XmlElement]
            public ERROR_INFO ERROR_INFO { set; get; }
            [XmlElement]
            public UO_ACCT UO_ACCT { set; get; }
            [XmlElement]
            public UO_AMTS UO_AMTS { set; get; }
            [XmlElement]
            public List<UO3_PAGE> UO3_PAGE { set; get; }
            [XmlElement]
            public HEADER_INFO HEADER_INFO { set; get; }
            [XmlElement]
            public DEBUG DEBUG { set; get; }
        }

        public class UO_ACCT : XmlNodeEntityBase
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
            public XmlNodeEntity USER_ID { set; get; }
            [XmlElement]
            public XmlNodeEntity RECORDING_DATE { set; get; }
            [XmlElement]
            public XmlNodeEntity SEQUENCE { set; get; }
            [XmlElement]
            public XmlNodeEntity ADJUSTMENT_REF_NO { set; get; }
            [XmlElement]
            public XmlNodeEntity RATE { set; get; }
            [XmlElement]
            public XmlNodeEntity BRT_NUMBER { set; get; }
            [XmlElement]
            public XmlNodeEntity LOCATION { set; get; }
            [XmlElement]
            public XmlNodeEntity DUE_DATE { set; get; }
            [XmlElement]
            public XmlNodeEntity ASSESSED_VALUE { set; get; }
            [XmlElement]
            public XmlNodeEntity FREQUENCY { set; get; }
            [XmlElement]
            public XmlNodeEntity PERIOD_CODE { set; get; }
            [XmlElement]
            public XmlNodeEntity PERIOD_YY { set; get; }
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

        public class UO_AMTS : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity MAX_TAX { set; get; }
            [XmlElement]
            public XmlNodeEntity VACANCY { set; get; }
            [XmlElement]
            public XmlNodeEntity EXEMPT { set; get; }
            [XmlElement]
            public XmlNodeEntity RESIDENTIAL { set; get; }
            [XmlElement]
            public XmlNodeEntity DELINQUENT { set; get; }
            [XmlElement]
            public XmlNodeEntity KOZ_CREDIT { set; get; }
            [XmlElement]
            public XmlNodeEntity TOTAL_DEDUCTIONS { set; get; }
            [XmlElement]
            public XmlNodeEntity PERIOD_TAX { set; get; }
            [XmlElement]
            public XmlNodeEntity DISCOUNT { set; get; }
            [XmlElement]
            public XmlNodeEntity TAX_DUE { set; get; }
            [XmlElement]
            public XmlNodeEntity INTEREST_PENALTY { set; get; }
            [XmlElement]
            public XmlNodeEntity TOTAL_DUE { set; get; }
            [XmlElement]
            public XmlNodeEntity DELINQUENT_TENANT_COUNT { set; get; }
        }

        public class UO3_PAGE : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity PROCESS_CODE { set; get; }
            [XmlElement]
            public XmlNodeEntity TENANT_NAME { set; get; }
            [XmlElement]
            public XmlNodeEntity TENANT_ID { set; get; }
            [XmlElement]
            public XmlNodeEntity ACCOUNT_ID { set; get; }
            [XmlElement]
            public XmlNodeEntity AMOUNT { set; get; }
        }
    }
}
