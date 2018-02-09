using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CopRevenueGov2.Test.RTTIE230
{
    [TestFixture]
    class RTTIE230_XMLFactoryTests
    {
        [Test]
        public void stringTESTBPTlfReturn()
        {

            COPXmlFactory.RTTIE030.BPTlfReturn bptlf = COPXmlFactory.RevenueGovXMLFactory.GetBPTlfReturn();

            string str = COPXmlFactory.RevenueGovXMLFactory.GetXmlString(bptlf);

            Assert.IsNotEmpty(str);
        }
        [Test]
        public void XMLTESTBPTlfReturnDeserialize()
        {
            System.IO.StreamReader myFile = new System.IO.StreamReader(@"E:\Sanghamitra\Projects\formXml\BPTlfReturn.xml");
            string myString = myFile.ReadToEnd();
            myFile.Close();
            COPXmlFactory.RTTIE030.BPTlfReturn bptlf =
              COPXmlFactory.RevenueGovXMLFactory.GetObjectfromXmlStringBPTlfreurn(myString);

            bptlf.BPT_INFO.ACCOUNT_ID = "333333333";

            string str = COPXmlFactory.RevenueGovXMLFactory.GetXmlString(bptlf);

        }
    }
}
