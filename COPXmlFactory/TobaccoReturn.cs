using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace COPXmlFactory
{
    namespace RTTIE028
    {
        [XmlRoot(ElementName = "TOBACCORETURN")]
        public class TOBACCORETURN : ICOPXmlTemplate
        {
            [XmlElement]
            public ERROR_INFO ERROR_INFO { set; get; }
            [XmlElement]
            public TOBACCO_INFO TOBACCO_INFO { set; get; }
            [XmlElement]
            public AMT_INFO AMT_INFO { set; get; }
            [XmlElement]
            public HEADER_INFO HEADER_INFO { set; get; }
            [XmlElement]
            public DEBUG DEBUG { set; get; }
        }

        public class TOBACCO_INFO : XmlNodeEntityBase
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
            public XmlNodeEntity RATE_ITEM { set; get; }
            [XmlElement]
            public XmlNodeEntity RATE_PACK { set; get; }
            [XmlElement]
            public XmlNodeEntity RATE_PAPER { set; get; }
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
            public XmlNodeEntity ITEM_TOTAL { set; get; }
            [XmlElement]
            public XmlNodeEntity ITEM_NOT_PHILA { set; get; }
            [XmlElement]
            public XmlNodeEntity ITEM_PHILA { set; get; }
            [XmlElement]
            public XmlNodeEntity ITEM_TAX_DUE { set; get; }
            [XmlElement]
            public XmlNodeEntity PACK_TOTAL { set; get; }
            [XmlElement]
            public XmlNodeEntity PACK_NOT_PHILA { set; get; }
            [XmlElement]
            public XmlNodeEntity PACK_PHILA { set; get; }
            [XmlElement]
            public XmlNodeEntity PACK_TAX_DUE { set; get; }
            [XmlElement]
            public XmlNodeEntity PAPER_TOTAL { set; get; }
            [XmlElement]
            public XmlNodeEntity PAPER_NOT_PHILA { set; get; }
            [XmlElement]
            public XmlNodeEntity PAPER_PHILA { set; get; }
            [XmlElement]
            public XmlNodeEntity PAPER_TAX_DUE { set; get; }          
            [XmlElement]
            public XmlNodeEntity TOTAL_TAX_DUE { set; get; }
            [XmlElement]
            public XmlNodeEntity CREDITS { set; get; }
            [XmlElement]
            public XmlNodeEntity NET_TAX_DUE { set; get; }
            [XmlElement]
            public XmlNodeEntity INTEREST_PENALTY { set; get; }
            [XmlElement]
            public XmlNodeEntity TOTAL_AMOUNT_DUE { set; get; }
            [XmlElement]
            public XmlNodeEntity REFUND { set; get; }
            [XmlElement]
            public XmlNodeEntity ROLL_FORWARD { set; get; }
        }
    }
}
