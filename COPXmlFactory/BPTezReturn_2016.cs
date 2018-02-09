using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace COPXmlFactory
{

    namespace RTTIE037_2016 
    {
        [XmlRoot(ElementName = "BPTRETURN")]
        public class BPTezReturn : ICOPXmlTemplate
        {
            [XmlElement]
            public ERROR_INFO ERROR_INFO { set; get; }
            [XmlElement]
            public BPT_INFO BPT_INFO { set; get; }
            [XmlElement]
            public BPT_PG1 BPT_PG1 { set; get; }
            [XmlElement]
            public BPT_PG2 BPT_PG2 { set; get; }
            [XmlElement]
            public HEADER_INFO HEADER_INFO { set; get; }
            [XmlElement]
            public DEBUG DEBUG { set; get; }
        }

        public class BPT_INFO : XmlNodeEntityBase
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
            public XmlNodeEntity USER_ID { set; get; }
            [XmlElement]
            public XmlNodeEntity NET_RATE { set; get; }
            [XmlElement]
            public XmlNodeEntity GROSS_RATE { set; get; }
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
             [XmlElement]
            public XmlNodeEntity TERMINATION_DATE { set; get; }
            
        }
        public class BPT_PG1 : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity NET_TAX { set; get; }
            [XmlElement]
            public XmlNodeEntity GROSS_TAX { set; get; }
            [XmlElement]
            public XmlNodeEntity ACTUAL_TAX { set; get; }
            [XmlElement]
            public XmlNodeEntity ESTIMATED_TAX { set; get; }
            [XmlElement]
            public XmlNodeEntity TOTAL_TAX { set; get; }
            [XmlElement]
            public XmlNodeEntity NPT_TAX_CREDIT { set; get; }
            [XmlElement]
            public XmlNodeEntity BPT_TAX_CREDIT { set; get; }
            [XmlElement]
            public XmlNodeEntity TOTAL_PAY_CREDITS { set; get; }
            [XmlElement]
            public XmlNodeEntity TAX_DUE { set; get; }
            [XmlElement]
            public XmlNodeEntity INTEREST_PENALTY { set; get; }
            [XmlElement]
            public XmlNodeEntity AMOUNT_OWED { set; get; }
            [XmlElement]
            public XmlNodeEntity REFUND { set; get; }
            [XmlElement]
            public XmlNodeEntity NPT_OVERPAY { set; get; }
            [XmlElement]
            public XmlNodeEntity BPT_OVERPAY { set; get; }
        }
        public class BPT_PG2 : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity NET_INCOME_LOSS_1 { set; get; }
            [XmlElement]
            public XmlNodeEntity NET_INCOME_LOSS_2 { set; get; }
            [XmlElement]
            public XmlNodeEntity LOSS_CARRY_FORWARD { set; get; }
            [XmlElement]
            public XmlNodeEntity TAXABLE_INCOME { set; get; }
            [XmlElement]
            public XmlNodeEntity TAX_DUE_NET { set; get; }
            [XmlElement]
            public XmlNodeEntity SALES_RENTAL { set; get; }
            [XmlElement]
            public XmlNodeEntity SERVICES { set; get; }
            [XmlElement]
            public XmlNodeEntity RENTAL_PROPERTY { set; get; }
            [XmlElement]
            public XmlNodeEntity ROYALTIES { set; get; }
            [XmlElement]
            public XmlNodeEntity CAPITAL_GAINS { set; get; }
            [XmlElement]
            public XmlNodeEntity STOCK_GAINS { set; get; }
            [XmlElement]
            public XmlNodeEntity DIVIDENDS { set; get; }
            [XmlElement]
            public XmlNodeEntity INTEREST { set; get; }
            [XmlElement]
            public XmlNodeEntity OTHER { set; get; }
            [XmlElement]
            public XmlNodeEntity TAXABLE_GROSS_RCPTS { set; get; }
            [XmlElement]
            public XmlNodeEntity TAX_DUE_GROSS { set; get; }
            [XmlElement]
            public XmlNodeEntity STAT_NET_DEDUCTION_1_X { set; get; }
            [XmlElement]
            public XmlNodeEntity TAXABLE_SUBTOTAL_EZ_X { set; get; }
            [XmlElement]
            public XmlNodeEntity STAT_EXCLUSION_EZ_X { set; get; }
        }
    }
}
