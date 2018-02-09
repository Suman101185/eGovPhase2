using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NUnit.Framework;
using CopRevenueGov2.Helpers;
using CopRevenueGov2.RTTIE010_SrvRef;

namespace CopRevenueGov2.NUnitTests
{
    [TestFixture]
    public class WebServiceTests
    {

        [Test]
        public void AcctInfo_LoginTest1()
        {

            COPXmlFactory.RTTIE010.ACCTTEMPLATE xo = COPXmlFactory.RevenueGovXMLFactory.GetAcctTemplate();
            xo.ENTITY_INFO.ENTITY_ID = "4002655";
            xo.ENTITY_INFO.PIN = "1234";
            xo.ENTITY_INFO.FUNCTION_CODE = "I";

            string request = COPXmlFactory.RevenueGovXMLFactory.GetXmlString(xo);

            CopRevenueGov2.Helpers.RTTIE010.Init();
            string x = CopRevenueGov2.Helpers.RTTIE010.CallService(request);
            Console.WriteLine(x);
            Assert.IsNotEmpty(x);
        }

        [Test]
        public void BPTEz_InitTest1()
        {

            COPXmlFactory.RTTIE037.BPTezReturn xo = COPXmlFactory.RevenueGovXMLFactory.GetBPTezReturn();
            xo.BPT_INFO.ACCOUNT_ID = "1002484";
            xo.BPT_INFO.RETURN_STATUS = "INQ";
            xo.BPT_INFO.PERIOD = "12/31/2012";

            string request = COPXmlFactory.RevenueGovXMLFactory.GetXmlString(xo);

            CopRevenueGov2.Helpers.RTTIE037.Init();
            string x = CopRevenueGov2.Helpers.RTTIE037.CallService(request);
            Console.WriteLine(x);
            Assert.IsNotEmpty(x);
        }
        [Test]
        public void BPTlf_InitTest1()
        {

            COPXmlFactory.RTTIE030.BPTlfReturn xo = COPXmlFactory.RevenueGovXMLFactory.GetBPTlfReturn();
            xo.BPT_INFO.ACCOUNT_ID = "222222240";
            xo.BPT_INFO.RETURN_STATUS = "INQ";
            xo.BPT_INFO.PERIOD = "12/31/2012";

            string request = COPXmlFactory.RevenueGovXMLFactory.GetXmlString(xo);

            CopRevenueGov2.Helpers.RTTIE030.Init();
            string x = CopRevenueGov2.Helpers.RTTIE030.CallService(request);
            Console.WriteLine(x);
            Assert.IsNotEmpty(x);
        }
        [Test]
        public void DelinquentForm_InitTest1()
        {

            COPXmlFactory.RTTIE022.DelinquentForm xo = COPXmlFactory.RevenueGovXMLFactory.GetDelinquentForm();
            xo.DEL_INFO.ENTITY_ID = "1004498";
            xo.DEL_INFO.ENTITY_TYPE = "002";
           
            string request = COPXmlFactory.RevenueGovXMLFactory.GetXmlString(xo);

            CopRevenueGov2.Helpers.RTTIE022.Init();
            string x = CopRevenueGov2.Helpers.RTTIE022.CallService(request);
            Console.WriteLine(x);
            Assert.IsNotEmpty(x);
        }
        [Test]
        public void LossCarryForward_InitTest1()
        {

            COPXmlFactory.RTTIE031.LossCarryForward xo = COPXmlFactory.RevenueGovXMLFactory.GetLossCarryForwardReturn();
            xo.LCF_INFO.ACCOUNT_ID = "1002609";
            xo.LCF_INFO.YEAR_X = "2012";

            string request = COPXmlFactory.RevenueGovXMLFactory.GetXmlString(xo);

            CopRevenueGov2.Helpers.RTTIE031.Init();
            string x = CopRevenueGov2.Helpers.RTTIE031.CallService(request);
            Console.WriteLine(x);
            Assert.IsNotEmpty(x);
        }
        [Test]
        public void SCHOOLRETURN_InitTest1()
        {

            COPXmlFactory.RTTIE036.SCHOOLRETURN xo = COPXmlFactory.RevenueGovXMLFactory.GetSCHOOLRETURN();
            xo.SCHOOL_INFO.ACCOUNT_ID = "222222240";
            xo.SCHOOL_INFO.PERIOD = "12/31/2012";
            xo.SCHOOL_INFO.RETURN_STATUS = "INQ";
            string request = COPXmlFactory.RevenueGovXMLFactory.GetXmlString(xo);

            CopRevenueGov2.Helpers.RTTIE036.Init();
            string x = CopRevenueGov2.Helpers.RTTIE036.CallService(request);
            Console.WriteLine(x);
            Assert.IsNotEmpty(x);
        }
        [Test]
        public void TobaccoReturn_InitTest1()
        {

            COPXmlFactory.RTTIE028.TOBACCORETURN xo = COPXmlFactory.RevenueGovXMLFactory.GetTOBACCORETURN();
            xo.TOBACCO_INFO.ACCOUNT_ID = "222222242";
            xo.TOBACCO_INFO.PERIOD = "12/31/2012";
            xo.TOBACCO_INFO.RETURN_STATUS = "INQ";
            string request = COPXmlFactory.RevenueGovXMLFactory.GetXmlString(xo);

            CopRevenueGov2.Helpers.RTTIE028.Init();
            string x = CopRevenueGov2.Helpers.RTTIE028.CallService(request);
            Console.WriteLine(x);
            Assert.IsNotEmpty(x);
        }
        [Test]
        public void UOForm_InitTest1()
        {

            COPXmlFactory.RTTIE035.UOFORM xo = COPXmlFactory.RevenueGovXMLFactory.GetUOFORMReturn();
            xo.UO_ACCT.ACCOUNT_ID = "0011692";
            xo.UO_ACCT.PERIOD = "12/31/2012";
            xo.UO_ACCT.RETURN_STATUS = "INQ";
            string request = COPXmlFactory.RevenueGovXMLFactory.GetXmlString(xo);

            CopRevenueGov2.Helpers.RTTIE035.Init();
            string x = CopRevenueGov2.Helpers.RTTIE035.CallService(request);
            Console.WriteLine(x);
            Assert.IsNotEmpty(x);
        }
        [Test]
        public void UOList_InitTest1()
        {

            COPXmlFactory.RTTIE034.UOLIST xo = COPXmlFactory.RevenueGovXMLFactory.GetUOLISTReturn();
            xo.UO_INFO.ENTITY_ID = "232472345";
            xo.UO_INFO.ACCOUNT_ID = "5684378";
          
            string request = COPXmlFactory.RevenueGovXMLFactory.GetXmlString(xo);

            CopRevenueGov2.Helpers.RTTIE034.Init();
            string x = CopRevenueGov2.Helpers.RTTIE034.CallService(request);
            Console.WriteLine(x);
            Assert.IsNotEmpty(x);
        }
        [Test]
        public void WageReturn_InitTest1()
        {

            COPXmlFactory.RTTIE027.WAGERETURN xo = COPXmlFactory.RevenueGovXMLFactory.GetWageReturn();
            xo.WAGE_INFO.PERIOD = "12/31/2012";
            xo.WAGE_INFO.RETURN_STATUS = "INQ";
            xo.WAGE_INFO.ACCOUNT_ID = "222222242";

            string request = COPXmlFactory.RevenueGovXMLFactory.GetXmlString(xo);

            CopRevenueGov2.Helpers.RTTIE027.Init();
            string x = CopRevenueGov2.Helpers.RTTIE027.CallService(request);
            Console.WriteLine(x);
            Assert.IsNotEmpty(x);
        }
        [Test]
        public void PAYCOUPON_InitTest1()
        {

            COPXmlFactory.RTTIE016.PAYCOUPON xo = COPXmlFactory.RevenueGovXMLFactory.GetPAYCOUPON();
            xo.ENTITY_INFO.ENTITY_ID = "222222242";
          
            string request = COPXmlFactory.RevenueGovXMLFactory.GetXmlString(xo);

            CopRevenueGov2.Helpers.RTTIE016.Init();
            string x = CopRevenueGov2.Helpers.RTTIE016.CallService(request);
            Console.WriteLine(x);
            Assert.IsNotEmpty(x);
        }

    }
}
