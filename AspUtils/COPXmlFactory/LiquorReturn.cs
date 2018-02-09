using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace COPXmlFactory
{
    namespace RTTIE029
    {
        [XmlRoot(ElementName = "LIQUORRETURN")]
        public class LIQUORRETURN : ICOPXmlTemplate
        {
            [XmlElement]
            public ERROR_INFO ERROR_INFO { set; get; }
            [XmlElement]
            public LIQUOR_INFO LIQUOR_INFO { set; get; }
            [XmlElement]
            public AMT_INFO AMT_INFO { set; get; }
            [XmlElement]
            public HEADER_INFO HEADER_INFO { set; get; }
            [XmlElement]
            public DEBUG DEBUG { set; get; }
        }

        public class LIQUOR_INFO : XmlNodeEntityBase
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
            public XmlNodeEntity SEQUENCE_NO { set; get; }
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
            public XmlNodeEntity TOTAL_GROSS { set; get; }
            [XmlElement]
            public XmlNodeEntity FOOD_EXCLUSION { set; get; }
            [XmlElement]
            public XmlNodeEntity OTHER_EXCLUSION { set; get; }
            [XmlElement]
            public XmlNodeEntity TOTAL_EXCLUSION { set; get; }
            [XmlElement]
            public XmlNodeEntity TAXABLE { set; get; }
            [XmlElement]
            public XmlNodeEntity TOTAL_TAX { set; get; }
            [XmlElement]
            public XmlNodeEntity TAX_PAID { set; get; }
            [XmlElement]
            public XmlNodeEntity NET_TAX_DUE { set; get; }
            [XmlElement]
            public XmlNodeEntity TAX_OVERPAID { set; get; }
           

        }
    }
}
