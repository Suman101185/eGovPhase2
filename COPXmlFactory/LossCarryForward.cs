using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace COPXmlFactory
{
    namespace RTTIE031
    {
        [XmlRoot(ElementName = "LCF")]
        public class LossCarryForward : ICOPXmlTemplate
        {
            [XmlElement]
            public ERROR_INFO ERROR_INFO { set; get; }
            [XmlElement]
            public LCF_INFO LCF_INFO { set; get; }
            [XmlElement]
            public HEADER_INFO HEADER_INFO { set; get; }
            [XmlElement]
            public DEBUG DEBUG { set; get; }
        }

        public class LCF_INFO : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity ACCOUNT_ID { set; get; }
            [XmlElement]
            public XmlNodeEntity YEAR_X { set; get; }
            [XmlElement]
            public XmlNodeEntity EST_PAID_X { set; get; }
            [XmlElement]
            public XmlNodeEntity YEAR { set; get; }
            [XmlElement]
            public XmlNodeEntity AMOUNT { set; get; }
            [XmlElement]
            public XmlNodeEntity COMMENT { set; get; }
            [XmlElement]
            public XmlNodeEntity YEAR_1 { set; get; }
            [XmlElement]
            public XmlNodeEntity INCOME_1 { set; get; }
            [XmlElement]
            public XmlNodeEntity COMMENT_1 { set; get; }
            [XmlElement]
            public XmlNodeEntity YEAR_2 { set; get; }
            [XmlElement]
            public XmlNodeEntity INCOME_2 { set; get; }
            [XmlElement]
            public XmlNodeEntity COMMENT_2 { set; get; }
            [XmlElement]
            public XmlNodeEntity YEAR_3 { set; get; }
            [XmlElement]
            public XmlNodeEntity INCOME_3{ set; get; }
            [XmlElement]
            public XmlNodeEntity COMMENT_3 { set; get; }
        }
    }
}
