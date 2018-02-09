using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace COPXmlFactory
{
    namespace RTTIE030_2015
    {
        [XmlRoot(ElementName = "BPTRETURN")]
        public class BPTlfReturn : ICOPXmlTemplate
        {

            [XmlElement]
            public ERROR_INFO ERROR_INFO { set; get; }

            [XmlElement]
            public BPT_INFO BPT_INFO { set; get; }

            [XmlElement]
            public BPT_PG1 BPT_PG1 { set; get; }

            [XmlElement]
            public BPT_SCH_A BPT_SCH_A { set; get; }

            [XmlElement]
            public BPT_SCH_B BPT_SCH_B { set; get; }

            [XmlElement]
            public BPT_SCH_C1 BPT_SCH_C1 { set; get; }

            [XmlElement]
            public BPT_SCH_D BPT_SCH_D { set; get; }

            [XmlElement]
            public BPT_SCH_E BPT_SCH_E { set; get; }

            [XmlElement]
            public BPT_TBL_C1 BPT_TBL_C1 { set; get; }

            [XmlElement]
            public HEADER_INFO HEADER_INFO { set; get; }

            [XmlElement]
            public BPT_WRKS BPT_WRKS { set; get; }

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
            public XmlNodeEntity SCH_AB_TAX_RATE { set; get; }
            [XmlElement]
            public XmlNodeEntity SCH_D_TAX_RATE { set; get; }
            [XmlElement]
            public XmlNodeEntity SCH_E_M_TAX_RATE { set; get; }
            [XmlElement]
            public XmlNodeEntity SCH_E_W_TAX_RATE { set; get; }
            [XmlElement]
            public XmlNodeEntity SCH_E_R_TAX_RATE { set; get; }
            [XmlElement]
            public XmlNodeEntity LOSS_CARRY_FOWARD { set; get; }
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
        public class BPT_PG1 : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity NET_INCOME { set; get; }
            [XmlElement]
            public XmlNodeEntity GROSS_RECEIPTS { set; get; }
            [XmlElement]
            public XmlNodeEntity TAX_DUE { set; get; }
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
            public XmlNodeEntity NET_TAX { set; get; }
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
        public class BPT_SCH_A : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity NI_LOSS { set; get; }
            [XmlElement]
            public XmlNodeEntity NI_PORT_ACTIVITIES { set; get; }
            [XmlElement]
            public XmlNodeEntity NI_PUC_ICC { set; get; }
            [XmlElement]
            public XmlNodeEntity NI_PUBLIC_LAW { set; get; }
            [XmlElement]
            public XmlNodeEntity I_APPORTIONED { set; get; }
            [XmlElement]
            public XmlNodeEntity I_APPORTIONED_PERCENT { set; get; }
            [XmlElement]
            public XmlNodeEntity I_APPORTIONED_PHILA { set; get; }
            [XmlElement]
            public XmlNodeEntity I_NONBUS_PHILA { set; get; }
            [XmlElement]
            public XmlNodeEntity I_CURRENT_YEAR { set; get; }
            [XmlElement]
            public XmlNodeEntity LOSS_CARRY_FORWARD { set; get; }
            [XmlElement]
            public XmlNodeEntity I_TAXABLE { set; get; }
            [XmlElement]
            public XmlNodeEntity TAX_DUE { set; get; }
            [XmlElement]
            public XmlNodeEntity STAT_NET_DEDUCTION_A_X { set; get; }
            
        }

        public class BPT_SCH_B : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity NI_LOSS { set; get; }
            [XmlElement]
            public XmlNodeEntity ADJ_NI_INTEREST { set; get; }
            [XmlElement]
            public XmlNodeEntity ADJ_NI_PORT_ACTIVITIES { set; get; }
            [XmlElement]
            public XmlNodeEntity ADJ_NI_PUC_ICC { set; get; }
            [XmlElement]
            public XmlNodeEntity ADJ_NI_PUBLIC_LAW { set; get; }
            [XmlElement]
            public XmlNodeEntity ADJ_RECEIPTS_DIR { set; get; }
            [XmlElement]
            public XmlNodeEntity ADJ_INCOME { set; get; }
            [XmlElement]
            public XmlNodeEntity ADJ_RECEIPTS_OTHER { set; get; }
            [XmlElement]
            public XmlNodeEntity ADJ_GROSS_RECEIPTS { set; get; }
            [XmlElement]
            public XmlNodeEntity ADJ_GROSS_PERCENT { set; get; }
            [XmlElement]
            public XmlNodeEntity ADJ_TOTAL { set; get; }
            [XmlElement]
            public XmlNodeEntity NI_ADJUSTED { set; get; }
            [XmlElement]
            public XmlNodeEntity I_NONBUS { set; get; }
            [XmlElement]
            public XmlNodeEntity I_APPORTIONED { set; get; }
            [XmlElement]
            public XmlNodeEntity I_APPORTIONED_PERCENT { set; get; }
            [XmlElement]
            public XmlNodeEntity I_APPORTIONED_PHILA { set; get; }
            [XmlElement]
            public XmlNodeEntity I_NONBUS_PHILA { set; get; }
            [XmlElement]
            public XmlNodeEntity I_CURRENT_YEAR { set; get; }
            [XmlElement]
            public XmlNodeEntity LOSS_CARRY_FORWARD { set; get; }
            [XmlElement]
            public XmlNodeEntity I_TAXABLE { set; get; }
            [XmlElement]
            public XmlNodeEntity TAX_DUE { set; get; }
            [XmlElement]
            public XmlNodeEntity STAT_NET_DEDUCTION_B_X { set; get; }

        }
        public class BPT_SCH_C1 : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity TOTAL_AVG_PHILA { set; get; }
            [XmlElement]
            public XmlNodeEntity TOTAL_AVG_ALL { set; get; }
            [XmlElement]
            public XmlNodeEntity PROPERTY_FACTOR_PHILA { set; get; }
            [XmlElement]
            public XmlNodeEntity PAYROLL_PHILA { set; get; }
            [XmlElement]
            public XmlNodeEntity PAYROLL_ALL { set; get; }
            [XmlElement]
            public XmlNodeEntity PAYROLL_FACTOR_PHILA { set; get; }
            [XmlElement]
            public XmlNodeEntity RECEIPTS_PHILA { set; get; }
            [XmlElement]
            public XmlNodeEntity RECEIPTS_ALL { set; get; }
            [XmlElement]
            public XmlNodeEntity RECEIPTS_FACTOR_PHILA { set; get; }
            [XmlElement]
            public XmlNodeEntity TOTAL_FACTORS { set; get; }
            [XmlElement]
            public XmlNodeEntity AVERAGE_FACTORS { set; get; }

        }
        public class BPT_SCH_D : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity GR_SALES { set; get; }
            [XmlElement]
            public XmlNodeEntity GR_SERVICES { set; get; }
            [XmlElement]
            public XmlNodeEntity GR_RENTALS { set; get; }
            [XmlElement]
            public XmlNodeEntity GR_TOTALS { set; get; }
            [XmlElement]
            public XmlNodeEntity LE_SALES_OUT { set; get; }
            [XmlElement]
            public XmlNodeEntity LE_SERVICES_OUT { set; get; }
            [XmlElement]
            public XmlNodeEntity LE_RENTALS_OUT { set; get; }
            [XmlElement]
            public XmlNodeEntity LE_OTHER { set; get; }
            [XmlElement]
            public XmlNodeEntity NET_TAXABLE_RECEIPTS { set; get; }
            [XmlElement]
            public XmlNodeEntity LE_TOTAL { set; get; }
            [XmlElement]
            public XmlNodeEntity TAXABLE_RECEIPTS { set; get; }
            [XmlElement]
            public XmlNodeEntity TAX_DUE { set; get; }
            [XmlElement]
            public XmlNodeEntity TAX_DUE_ALT { set; get; }
            [XmlElement]
            public XmlNodeEntity TOTAL_TAX_DUE { set; get; }
            [XmlElement]
            public XmlNodeEntity STAT_EXCLUSION_D_X { set; get; }

        }
        public class BPT_SCH_E : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity M_ALT_RECEIPTS { set; get; }
            [XmlElement]
            public XmlNodeEntity M_GOODS_COST { set; get; }
            [XmlElement]
            public XmlNodeEntity M_TAX_BASE { set; get; }
            [XmlElement]
            public XmlNodeEntity M_TAX_DUE { set; get; }
            [XmlElement]
            public XmlNodeEntity W_ALT_RECEIPTS { set; get; }
            [XmlElement]
            public XmlNodeEntity W_GOODS_MATERIALS { set; get; }
            [XmlElement]
            public XmlNodeEntity W_GOODS_LABOR { set; get; }
            [XmlElement]
            public XmlNodeEntity W_GOODS_COST { set; get; }
            [XmlElement]
            public XmlNodeEntity W_TAX_BASE { set; get; }
            [XmlElement]
            public XmlNodeEntity W_TAX_DUE { set; get; }
            [XmlElement]
            public XmlNodeEntity R_ALT_RECEIPTS { set; get; }
            [XmlElement]
            public XmlNodeEntity R_GOODS_MATERIALS { set; get; }
            [XmlElement]
            public XmlNodeEntity R_GOODS_LABOR { set; get; }
            [XmlElement]
            public XmlNodeEntity R_GOODS_COST { set; get; }
            [XmlElement]
            public XmlNodeEntity R_TAX_BASE { set; get; }
            [XmlElement]
            public XmlNodeEntity R_TAX_DUE { set; get; }
            [XmlElement]
            public XmlNodeEntity TOTAL_TAX_DUE { set; get; }




        }
        public class BPT_TBL_C1 : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity INVENTORIES_PHILA { set; get; }
            [XmlElement]
            public XmlNodeEntity INVENTORIES_ALL { set; get; }
            [XmlElement]
            public XmlNodeEntity LAND_BLDGS_PHILA { set; get; }
            [XmlElement]
            public XmlNodeEntity LAND_BLDGS_ALL { set; get; }
            [XmlElement]
            public XmlNodeEntity MACHINERY_PHILA { set; get; }
            [XmlElement]
            public XmlNodeEntity MACHINERY_ALL { set; get; }
            [XmlElement]
            public XmlNodeEntity OTHER_ASSESTS_PHILA { set; get; }
            [XmlElement]
            public XmlNodeEntity OTHER_ASSESTS_ALL { set; get; }
            [XmlElement]
            public XmlNodeEntity RENTED_PROPERTY_PHILA { set; get; }
            [XmlElement]
            public XmlNodeEntity RENTED_PROPERTY_ALL { set; get; }
            [XmlElement]
            public XmlNodeEntity TOTAL_AVG_PHILA { set; get; }
            [XmlElement]
            public XmlNodeEntity TOTAL_AVG_ALL { set; get; }

        }
        public class BPT_WRKS : XmlNodeEntityBase
        {
            [XmlElement]
            public XmlNodeEntity LOWERLINE_S1 { set; get; }
            [XmlElement]
            public XmlNodeEntity LOWERLINE_S2 { set; get; }
            [XmlElement]
            public XmlNodeEntity LOWERLINE_S3 { set; get; }
            [XmlElement]
            public XmlNodeEntity LOWERLINE_S4 { set; get; }
            [XmlElement]
            public XmlNodeEntity LOWERLINE_Statutory_Net_Income { set; get; }

        }
    }
}
