using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace COPXmlFactory
{
    namespace RTTIE022
    {
        [XmlRoot(ElementName = "DELINQ")]
        public class DelinquentForm : ICOPXmlTemplate
        {
            [XmlElement]
            public ERROR_INFO ERROR_INFO { set; get; }
            [XmlElement]
            public DEL_INFO DEL_INFO { set; get; }
            [XmlElement(ElementName = "DEL_ACCT")]
            public List<DEL_ACCT> DEL_ACCTs { set; get; }
            [XmlElement]
            public DEL_ACCT_DELIMITED DEL_ACCT_DELIMITED { set; get; }
            [XmlElement]
            public HEADER_INFO HEADER_INFO { set; get; }
            [XmlElement]
            public DEBUG DEBUG { set; get; }
        }

        public class DEL_INFO : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity ENTITY_TYPE { set; get; }
            [XmlElement]
            public XmlNodeEntity ENTITY_ID { set; get; }
            [XmlElement]
            public XmlNodeEntity FUNCTION { set; get; }
            [XmlElement]
            public XmlNodeEntity NOTICE_NUM { set; get; }
            [XmlElement]
            public XmlNodeEntity NEXT_ACCOUNT_TYPE { set; get; }
            [XmlElement]
            public XmlNodeEntity NEXT_ACCOUNT_ID { set; get; }
            [XmlElement]
            public XmlNodeEntity NEXT_PERIOD { set; get; }
        }

        public class DEL_ACCT : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity FUNCTION_CODE { set; get; }
            [XmlElement]
            public XmlNodeEntity ACCOUNT_TYPE { set; get; }
            [XmlElement]
            public XmlNodeEntity ACCOUNT_ID { set; get; }
            [XmlElement]
            public XmlNodeEntity PERIOD { set; get; }
            [XmlElement]
            public XmlNodeEntity PRINCIPAL_DUE { set; get; }
            [XmlElement]
            public XmlNodeEntity INTEREST_DUE { set; get; }
            [XmlElement]
            public XmlNodeEntity PENALTY_DUE { set; get; }
            [XmlElement]
            public XmlNodeEntity OTHER_DUE { set; get; }
            [XmlElement]
            public XmlNodeEntity BRT_ENTITY { set; get; }
            [XmlElement]
            public XmlNodeEntity BRT_ADDRESS { set; get; }
            [XmlElement]
            public XmlNodeEntity FILL { set; get; }
        }

        public class DEL_ACCT_DELIMITED : XmlNodeEntity
        {
        }
    }
  
}
