using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace COPXmlFactory
{
    namespace RTTIE034
    {
        [XmlRoot(ElementName = "UOLIST")]
        public class UOLIST : ICOPXmlTemplate
        {
            [XmlElement]
            public ERROR_INFO ERROR_INFO { set; get; }
            [XmlElement]
            public UO_INFO UO_INFO { set; get; }
            [XmlElement]
            public List<UO_ACCT> UO_ACCT { set; get; }
            [XmlElement]
            public HEADER_INFO HEADER_INFO { set; get; }
            [XmlElement]
            public DEBUG DEBUG { set; get; }
        }

        public class UO_INFO : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity ENTITY_ID { set; get; }
            [XmlElement]
            public XmlNodeEntity ACCOUNT_ID { set; get; }
        }
        public class UO_ACCT : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity ACCOUNT_ID { set; get; }
            [XmlElement]
            public XmlNodeEntity BRT_NUMBER { set; get; }
            [XmlElement]
            public XmlNodeEntity LOCATION { set; get; }
            [XmlElement]
            public XmlNodeEntity START_DATE { set; get; }
            [XmlElement]
            public XmlNodeEntity END_DATE { set; get; }
            [XmlElement]
            public XmlNodeEntity FREQ_YEAR0 { set; get; }
            [XmlElement]
            public XmlNodeEntity FREQ_YEAR1 { set; get; }
            [XmlElement]
            public XmlNodeEntity FREQ_YEAR2 { set; get; }
            [XmlElement]
            public XmlNodeEntity FREQ_YEAR3 { set; get; }
            [XmlElement]
            public XmlNodeEntity FREQ_YEAR4 { set; get; }
            [XmlElement]
            public XmlNodeEntity FREQ_YEAR5 { set; get; }
            [XmlElement]
            public XmlNodeEntity FREQ_YEAR6 { set; get; }
            [XmlElement]
            public XmlNodeEntity FREQ_YEAR7 { set; get; }
            [XmlElement]
            public XmlNodeEntity FREQ_YEAR8 { set; get; }
            [XmlElement]
            public XmlNodeEntity FREQ_YEAR9 { set; get; }
        }
    }
}
