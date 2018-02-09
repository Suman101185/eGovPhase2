using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CopRevenueGov2.Test.RTTIE227
{
    [TestFixture]
    class RTTIE227_XMLFactoryTests
    {
        [Test]
        public void stringTESTWage()
        {

            COPXmlFactory.RTTIE027.WAGERETURN wage = COPXmlFactory.RevenueGovXMLFactory.GetWageReturn();

            string str = COPXmlFactory.RevenueGovXMLFactory.GetXmlString(wage);

            Assert.IsNotEmpty(str);
        }
        [Test]
        public void XMLTESTWageDeserialize()
        {
            System.IO.StreamReader myFile = new System.IO.StreamReader(@"E:\Sanghamitra\Projects\formXml\WageReturn.xml");
            string myString = myFile.ReadToEnd();
            myFile.Close();
            COPXmlFactory.RTTIE027.WAGERETURN wage =
              COPXmlFactory.RevenueGovXMLFactory.GetObjectfromXmlStringWage(myString);

            wage.WAGE_INFO.ACCOUNT_ID = "333333333";

            string str = COPXmlFactory.RevenueGovXMLFactory.GetXmlString(wage);

        }
    }
}
