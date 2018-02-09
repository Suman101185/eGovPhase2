using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace COPXmlFactory
{
    namespace RTTIE016
    {
        [XmlRoot(ElementName = "PAYCOUPON")]
        public class PAYCOUPON : ICOPXmlTemplate
        {
            [XmlElement]
            public ERROR_INFO ERROR_INFO { set; get; }
            [XmlElement]
            public ENTITY_INFO ENTITY_INFO { set; get; }
            [XmlElement]
            public List<TAX_ACCT> TAX_ACCT { set; get; }
            [XmlElement]
            public WAGE_NTL WAGE_NTL { set; get; }
            [XmlElement]
            public COUPON_FORM COUPON_FORM { set; get; }
            [XmlElement]
            public LOGIN_FROM LOGIN_FROM { set; get; }
        }

        public class ENTITY_INFO : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity FUNCTION_CODE { set; get; }
            [XmlElement]
            public XmlNodeEntity ENT_TYPE { set; get; }
            [XmlElement]
            public XmlNodeEntity ENTITY_ID { set; get; }
            [XmlElement]
            public XmlNodeEntity ACCT_ID { set; get; }
            [XmlElement]
            public XmlNodeEntity NAME { set; get; }
            [XmlElement]
            public XmlNodeEntity ADDRESS1 { set; get; }
            [XmlElement]
            public XmlNodeEntity ADDRESS2 { set; get; }
            [XmlElement]
            public XmlNodeEntity ADDRESS3 { set; get; }
            [XmlElement]
            public XmlNodeEntity CITY { set; get; }
            [XmlElement]
            public XmlNodeEntity STATE { set; get; }
            [XmlElement]
            public XmlNodeEntity ZIP_CODE { set; get; }
            
        }
        public class TAX_ACCT : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity FUNC_CODE { set; get; }
            [XmlElement]
            public XmlNodeEntity ACCOUNT { set; get; }
            [XmlElement]
            public XmlNodeEntity ACCOUNT_ID { set; get; }
            [XmlElement]
            public XmlNodeEntity START_DATE { set; get; }
            [XmlElement]
            public XmlNodeEntity END_DATE { set; get; }
            [XmlElement]
            public XmlNodeEntity FREQUENCY_CODE { set; get; }
            [XmlElement]
            public XmlNodeEntity BRT_ACCOUNT { set; get; }
            [XmlElement]
            public XmlNodeEntity BRT_ADDRESS1 { set; get; }
           
        }
        public class WAGE_NTL : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity ACCOUNT_ID { set; get; }
            [XmlElement]
            public XmlNodeEntity PERIOD { set; get; }
            [XmlElement]
            public XmlNodeEntity FREQUENCY_CODE { set; get; }
            [XmlElement]
            public XmlNodeEntity ADJ_REF_NO { set; get; }
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
        public class COUPON_FORM : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity CPN_ACCOUNT { set; get; }
            [XmlElement]
            public XmlNodeEntity CPN_ACCOUNT_TYPE { set; get; }
            [XmlElement]
            public XmlNodeEntity CPN_NAME { set; get; }
            [XmlElement]
            public XmlNodeEntity CPN_ADDR { set; get; }
            [XmlElement]
            public XmlNodeEntity CPN_ADDR2 { set; get; }
            [XmlElement]
            public XmlNodeEntity CPN_ADDR3 { set; get; }
            [XmlElement]
            public XmlNodeEntity CPN_CITY { set; get; }
            [XmlElement]
            public XmlNodeEntity CPN_STATE { set; get; }
            [XmlElement]
            public XmlNodeEntity CPN_ZIP_CODE { set; get; }
            [XmlElement]
            public XmlNodeEntity CPN_SCAN { set; get; }
            [XmlElement]
            public XmlNodeEntity CPN_PERIOD { set; get; }
            [XmlElement]
            public XmlNodeEntity CPN_YEAR { set; get; }
            [XmlElement]
            public XmlNodeEntity CPN_FORM { set; get; }

        }

        public class LOGIN_FROM : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity NTL_ONLY { set; get; }
           
        }


    }
}
