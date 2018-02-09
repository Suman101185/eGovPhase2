using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace COPXmlFactory
{
    namespace RTTIE039
    {
        [XmlRoot(ElementName = "NPTRETURN")]
        public class NPTRETURN : ICOPXmlTemplate
        {
            [XmlElement]
            public ERROR_INFO ERROR_INFO { set; get; }
            [XmlElement]
            public NPT_INFO NPT_INFO { set; get; }
            [XmlElement]
            public NPT_PG1 NPT_PG1 { set; get; }
            [XmlElement]
            public NPT_WRKA NPT_WRKA { set; get; }
            [XmlElement]
            public NPT_WRKB NPT_WRKB { set; get; }
            [XmlElement]
            public NPT_WRKC NPT_WRKC { set; get; }
            [XmlElement]
            public NPT_WRKD NPT_WRKD { set; get; }
            [XmlElement]
            public NPT_WRKE NPT_WRKE { set; get; }
            [XmlElement]
            public NPT_WRKK NPT_WRKK { set; get; }
            [XmlElement]
            public NPT_PG4 NPT_PG4 { set; get; }
            [XmlElement]
            public HEADER_INFO HEADER_INFO { set; get; }
            [XmlElement]
            public DEBUG DEBUG { set; get; }
        }

        public class NPT_INFO : XmlNodeEntityBase
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
            public XmlNodeEntity RESIDENT_RATE { set; get; }
            [XmlElement]
            public XmlNodeEntity BASE_RESIDENT_RATE { set; get; }
            [XmlElement]
            public XmlNodeEntity NON_RES_RATE { set; get; }
            [XmlElement]
            public XmlNodeEntity BASE_NON_RES_RATE { set; get; }
            [XmlElement]
            public XmlNodeEntity CORP_PARTNER_IND { set; get; }
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
        public class NPT_PG1 : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity RESIDENT_INCOME { set; get; }
            [XmlElement]
            public XmlNodeEntity RESIDENT_INCOME_TAX { set; get; }
            //--
            [XmlElement]
            public XmlNodeEntity RESIDENT_BASE_INCOME_TAXABLE { set; get; }
            [XmlElement]
            public XmlNodeEntity RESIDENT_BASE_INCOME_TAX { set; get; }
            [XmlElement]
            public XmlNodeEntity RESIDENT_TOTAL_TAX { set; get; }
            //--
            [XmlElement]
            public XmlNodeEntity NON_RES_INCOME { set; get; }
            [XmlElement]
            public XmlNodeEntity NON_RES_INCOME_TAX { set; get; }
            //
            [XmlElement]
            public XmlNodeEntity NON_RES_BASE_INCOME_TAXABLE { set; get; }
            [XmlElement]
            public XmlNodeEntity NON_RES_BASE_INCOME_TAX { set; get; }
            [XmlElement]
            public XmlNodeEntity NON_RES_TOTAL_TAX { set; get; }
            //
            [XmlElement]
            public XmlNodeEntity TOTAL_TAX { set; get; }
            [XmlElement]
            public XmlNodeEntity BPT_TAX_CREDIT { set; get; }
            [XmlElement]
            public XmlNodeEntity OTHER_TAX_CREDIT { set; get; }
            [XmlElement]
            public XmlNodeEntity TOTAL_PAY_CREDITS { set; get; }
            [XmlElement]
            public XmlNodeEntity TAX_DUE { set; get; }
            [XmlElement]
            public XmlNodeEntity INTEREST_PENALTY { set; get; }
            [XmlElement]
            public XmlNodeEntity TOTAL_DUE { set; get; }
            [XmlElement]
            public XmlNodeEntity OVERPAY { set; get; }
            [XmlElement]
            public XmlNodeEntity LINE11 { set; get; }
            //
            [XmlElement]
            public XmlNodeEntity OVERPAY_AVAILABLE { set; get; }
            //
            [XmlElement]
            public XmlNodeEntity REFUND { set; get; }
            [XmlElement]
            public XmlNodeEntity BPT_OVERPAY { set; get; }
            [XmlElement]
            public XmlNodeEntity NPT_OVERPAY { set; get; }
            //
            [XmlElement]
            public XmlNodeEntity CORP_PARTNER_PERCENT { set; get; }
        }      
        public class NPT_WRKA : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity RESIDENT_NET_INCOME { set; get; }
            [XmlElement]
            public XmlNodeEntity RESIDENT_FORM_1065 { set; get; }
            [XmlElement]
            public XmlNodeEntity RESIDENT_OTHER_INCOME { set; get; }
            [XmlElement]
            public XmlNodeEntity RESIDENT_TAXABLE_INCOME { set; get; }
            

        }
        public class NPT_WRKB : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity NON_RES_NET_INCOME { set; get; }
            [XmlElement]
            public XmlNodeEntity NON_RES_FORM_1065 { set; get; }
            [XmlElement]
            public XmlNodeEntity NON_RES_OTHER_INCOME { set; get; }
            [XmlElement]
            public XmlNodeEntity NON_RES_TOTAL_INCOME { set; get; }
            [XmlElement]
            public XmlNodeEntity NON_RES_OUTSIDE_INCOME { set; get; }
            [XmlElement]
            public XmlNodeEntity NON_RES_TAXABLE_INCOME { set; get; }
        }
        public class NPT_WRKC : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity NET_PROFITS_LIABILTY { set; get; }
            [XmlElement]
            public XmlNodeEntity BTP_TAX_CREDIT { set; get; }
            [XmlElement]
            public XmlNodeEntity ESTIMATED_PAYMENT_BASE { set; get; }
           
        }
        public class NPT_WRKD : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity PORTION_TAXABLE_INCOME { set; get; }
            [XmlElement]
            public XmlNodeEntity TOTAL_TAXABLE_INCOME { set; get; }
            [XmlElement]
            public XmlNodeEntity PERCENTAGE_TAXABLE_INCOME { set; get; }
            [XmlElement]
            public XmlNodeEntity WRKK_LINE2 { set; get; }
            [XmlElement]
            public XmlNodeEntity MULTIPLY_LINE4_PERCENTAGE { set; get; }
            [XmlElement]
            public XmlNodeEntity SUBTRACT_LINE5_LINE4 { set; get; }
            [XmlElement]
            public XmlNodeEntity PAGE1_LINE5 { set; get; }
            [XmlElement]
            public XmlNodeEntity BPT_TAX_CREDIT { set; get; }
           
        }
        public class NPT_WRKE : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity ESTIMATED_PROFIT_PAYMENT { set; get; }
            [XmlElement]
            public XmlNodeEntity PAYMENTS_WITH_EXTENSION { set; get; }
            [XmlElement]
            public XmlNodeEntity PRIOR_OVERPAYMENT_TBA { set; get; }
            [XmlElement]
            public XmlNodeEntity TOATAL_PAYMENTS_CREDITS { set; get; }
            
        }
        public class NPT_WRKK : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity BPT_PAGE1_LINE1 { set; get; }
            [XmlElement]
            public XmlNodeEntity SIXTY_PERCENT_LINE1 { set; get; }
            [XmlElement]
            public XmlNodeEntity NPT_PAGE1_LINE5 { set; get; }
            [XmlElement]
            public XmlNodeEntity BPT_TAX_CREDIT { set; get; }
            
        }
        public class NPT_PG4 : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity INVENTORY_RAW_A { set; get; }
            [XmlElement]
            public XmlNodeEntity INVENTORY_RAW_B { set; get; }
            [XmlElement]
            public XmlNodeEntity LAND_BUILDING_A { set; get; }
            [XmlElement]
            public XmlNodeEntity LAND_BUILDING_B { set; get; }
            [XmlElement]
            public XmlNodeEntity MACHINERY_EQUIP_A { set; get; }
            [XmlElement]
            public XmlNodeEntity MACHINERY_EQUIP_B { set; get; }
            [XmlElement]
            public XmlNodeEntity OTHER_ASSESTS_A { set; get; }
            [XmlElement]
            public XmlNodeEntity OTHER_ASSESTS_B { set; get; }
            [XmlElement]
            public XmlNodeEntity RENTED_PROPERTY_A { set; get; }
            [XmlElement]
            public XmlNodeEntity RENTED_PROPERTY_B { set; get; }
            [XmlElement]
            public XmlNodeEntity TOTAL_VALUE_OUTSIDE { set; get; }
            [XmlElement]
            public XmlNodeEntity TOTAL_VALUE_EVERYWHERE { set; get; }
            [XmlElement]
            public XmlNodeEntity OUTSIDE_PROPERTY_FACTOR { set; get; }
            [XmlElement]
            public XmlNodeEntity OUT_PHILLY_PAYROLL { set; get; }
            [XmlElement]
            public XmlNodeEntity PAYROLL_EVERYWHERE { set; get; }
            [XmlElement]
            public XmlNodeEntity OUTSIDE_PAYROLL_FACTOR { set; get; }
            [XmlElement]
            public XmlNodeEntity OUT_PHILLY_RECEIPTS { set; get; }
            [XmlElement]
            public XmlNodeEntity GROSS_RECEIPTS_EVERYWHERE { set; get; }
            [XmlElement]
            public XmlNodeEntity OUTSIDE_RECEIPTS_FACTOR { set; get; }
            [XmlElement]
            public XmlNodeEntity TOTAL_FACTORS { set; get; }
            [XmlElement]
            public XmlNodeEntity AVERAGE_FACTORS { set; get; }
            [XmlElement]
            public XmlNodeEntity WRKB_LINE4 { set; get; }
            [XmlElement]
            public XmlNodeEntity MULTIPLY_LINE13_LINE12 { set; get; }
          

        }
       
    }
}
