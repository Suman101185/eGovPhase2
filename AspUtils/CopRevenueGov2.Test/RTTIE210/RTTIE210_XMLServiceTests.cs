using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CopRevenueGov2.Test.RTTIE210
{
    [TestFixture]
    class RTTIE210_XMLServiceTests
    {
        [Test]
        public void AcctInfo_LoginTest1()
        {

            COPXmlFactory.RTTIE010.ACCTTEMPLATE xo = COPXmlFactory.RevenueGovXMLFactory.GetAcctTemplate();
            xo.ENTITY_INFO.ENTITY_ID = "1054352";
            xo.ENTITY_INFO.PIN = "1234";
            xo.ENTITY_INFO.FUNCTION_CODE = "I";

            string request = COPXmlFactory.RevenueGovXMLFactory.GetXmlString(xo);

            CopRevenueGov2.Helpers.RTTIE010.Init();
            string x = CopRevenueGov2.Helpers.RTTIE010.CallService(request);
            Console.WriteLine(x);
            Assert.IsNotEmpty(x);
        }
    }
}
