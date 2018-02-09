using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CopRevenueGov2.Test.RTTIE210
{
    [TestFixture]
    class RTTIE210_XMLFactoryTests
    {
        [Test]
        public void stringTESTACCTTEMPLATE()
        {

            COPXmlFactory.RTTIE010.ACCTTEMPLATE acct = COPXmlFactory.RevenueGovXMLFactory.GetAcctTemplate();

            string str = COPXmlFactory.RevenueGovXMLFactory.GetXmlString(acct);

            Assert.IsNotEmpty(str);        
        }
        [Test]
        public void XMLTESTACCTTEMPLATEDeserialize()
        {
            System.IO.StreamReader myFile =
                new System.IO.StreamReader(@"E:\Sanghamitra\Projects\formXml\AcctTemplate.xml");
            string myString = myFile.ReadToEnd();

            myFile.Close();

            COPXmlFactory.RTTIE010.ACCTTEMPLATE acct = (COPXmlFactory.RTTIE010.ACCTTEMPLATE)COPXmlFactory.RevenueGovXMLFactory.GetObjectfromXmlString(myString);

            acct.ENTITY_INFO.ACCOUNT_ID = "333333333";

            string str = COPXmlFactory.RevenueGovXMLFactory.GetXmlString(acct);

        }
    }
}
