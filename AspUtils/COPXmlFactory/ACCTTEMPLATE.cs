using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace COPXmlFactory
{

    public interface ICOPXmlTemplate
    {
    }

    public class COPXmlTemplateBase : ICOPXmlTemplate
    {


    }

    namespace RTTIE010
    {
        [XmlRoot]
        public class ACCTTEMPLATE : COPXmlTemplateBase
        {
            [XmlElement]
            public ERROR_INFO ERROR_INFO { set; get; }

            [XmlElement]
            public ENTITY_INFO ENTITY_INFO { set; get; }

            [XmlElement]
            public List<TAX_ACCT> TAX_ACCT { set; get; }


            [XmlElement]
            public ECHECK ECHECK { set; get; }

            [XmlElement]
            public List<NAME_ADDRESS> NAME_ADDRESS { set; get; }

            [XmlElement]
            public HEADER_INFO HEADER_INFO { set; get; }

            [XmlElement]
            public DEBUG DEBUG { set; get; }
        }

        //public class ERROR_INFO : XmlNodeEntityBase
        //{
        //    [XmlElement]
        //    public XmlNodeEntity PROGRAM { set; get; }
        //    [XmlElement]
        //    public XmlNodeEntity ERROR { set; get; }
        //    [XmlElement]
        //    public XmlNodeEntity LINE { set; get; }
        //    [XmlElement]
        //    public XmlNodeEntity MESSAGE { set; get; }
        //}

        public class ENTITY_INFO : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity FUNCTION_CODE { set; get; }
            [XmlElement]
            public XmlNodeEntity TYPE { set; get; }
            [XmlElement]
            public XmlNodeEntity ENTITY_ID { set; get; }
            [XmlElement]
            public XmlNodeEntity ACCOUNT_ID { set; get; }
            [XmlElement]
            public XmlNodeEntity NAIC_CODE { set; get; }
            [XmlElement]
            public XmlNodeEntity SIC_CODE { set; get; }
            [XmlElement]
            public XmlNodeEntity START_DATE { set; get; }
            [XmlElement]
            public XmlNodeEntity ORGTYPE { set; get; }
            [XmlElement]
            public XmlNodeEntity ORIGIN { set; get; }
            [XmlElement]
            public XmlNodeEntity GENDER { set; get; }
            [XmlElement]
            public XmlNodeEntity OTHER { set; get; }
            [XmlElement]
            public XmlNodeEntity PIN { set; get; }
            [XmlElement]
            public XmlNodeEntity FORCEPINCHG { set; get; }
        }

        public class TAX_ACCT : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity FUNCTION_CODE { set; get; }
            [XmlElement]
            public XmlNodeEntity ACCOUNT { set; get; }
            [XmlElement]
            public XmlNodeEntity START_DATE { set; get; }
            [XmlElement]
            public XmlNodeEntity WAGE_MONTHLY_GROSS { set; get; }
            [XmlElement]
            public XmlNodeEntity UOL_BRT { set; get; }
            [XmlElement]
            public XmlNodeEntity PRK_ID { set; get; }

            //[XmlAttribute]
            //public XmlNodeEntity XmlNodeEntity { set; get; }

        }

        public class ECHECK : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity FUNCTION_CODE { set; get; }
            [XmlElement]
            public XmlNodeEntity ROUTING_NUMBER { set; get; }
            [XmlElement]
            public XmlNodeEntity ACCOUNT_NUMBER { set; get; }
            [XmlElement]
            public XmlNodeEntity ACCOUNT_TYPE { set; get; }

            //[XmlAttribute]
            //public XmlNodeEntity XmlNodeEntity { set; get; }
        }

        public class NAME_ADDRESS : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity FUNCTION_CODE { set; get; }
            [XmlElement]
            public XmlNodeEntity TYPE { set; get; }
            [XmlElement]
            public XmlNodeEntity ID { set; get; }
            [XmlElement]
            public XmlNodeEntity NAME { set; get; }
            [XmlElement]
            public XmlNodeEntity TRADE_NAME { set; get; }
            [XmlElement]
            public XmlNodeEntity ADDRESS_TYPE { set; get; }
            [XmlElement]
            public XmlNodeEntity RELATIONSHIP_CODE { set; get; }
            [XmlElement]
            public XmlNodeEntity ATTENTION { set; get; }
            [XmlElement]
            public XmlNodeEntity ADDRESS1 { set; get; }
            [XmlElement]
            public XmlNodeEntity ADDRESS2 { set; get; }
            [XmlElement]
            public XmlNodeEntity CITY { set; get; }
            [XmlElement]
            public XmlNodeEntity STATE { set; get; }
            [XmlElement]
            public XmlNodeEntity ZIP { set; get; }
            [XmlElement]
            public XmlNodeEntity WORK_PHONE { set; get; }
            [XmlElement]
            public XmlNodeEntity WORK_PHONE_EXT { set; get; }
            [XmlElement]
            public XmlNodeEntity WORK_FAX { set; get; }
            [XmlElement]
            public XmlNodeEntity OTHER_PHONE { set; get; }
            [XmlElement]
            public XmlNodeEntity EMAIL { set; get; }
            [XmlElement]
            public XmlNodeEntity TRACE_NUMBER { set; get; }

        }
    }

    //public class HEADER_INFO : XmlNodeEntityBase
    //{

    //}

    //public class DEBUG : XmlNodeEntityBase
    //{

    //}
}
