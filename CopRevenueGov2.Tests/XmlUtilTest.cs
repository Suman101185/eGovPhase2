using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using CopRevenueGov2.Helpers;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web;
using System.IO;
using System.Text;
using System.Xml;


namespace CopRevenueGov2.Tests
{

    [TestClass]
    public class XmlUtilTest
    {

        private HttpContext CallUrl(string fileName, string url)
        {
            var sb = new StringBuilder();
            var sw = new StringWriter(sb);
            var hres = new HttpResponse(sw);
            var hreq = new HttpRequest(fileName, url,"");
            HttpContext httpc = new HttpContext(hreq, hres);
            return httpc;
        }

        /*
        [TestMethod]
        public void XmlToStringTest()
        {
            XMLUtil xutil = new XMLUtil();


            HttpContext response = CallUrl("accountinfo", "http://localhost:2960");

            string fromSender = string.Empty;
            using (StreamReader responseReader = new StreamReader(response.Response.OutputStream))
            {
                fromSender = responseReader.ReadToEnd();
            }
            //RequestContext requestContext = new RequestContext(resp );
            //UrlHelper urlHelper = new UrlHelper(requestContext);

            Assert.IsFalse(false, "Success");

            //xutil.XMLToString(
        }

        [TestMethod]
        public void XMLTESTACCTTEMPLATE()
        {

            COPXmlFactory.RTTIE010.ACCTTEMPLATE acct = COPXmlFactory.RevenueGovXMLFactory.GetAcctTemplate();

            XmlDocument doc = COPXmlFactory.RevenueGovXMLFactory.GetXmlDocument(acct);

            Assert.IsFalse(false, "Success");

            //xutil.XMLToString(
        }

        [TestMethod]
        public void stringTESTACCTTEMPLATE()
        {

            COPXmlFactory.RTTIE010.ACCTTEMPLATE acct = COPXmlFactory.RevenueGovXMLFactory.GetAcctTemplate();

            string str = COPXmlFactory.RevenueGovXMLFactory.GetXmlString(acct);

            Assert.IsFalse(false, "Success");

            //xutil.XMLToString(
        }

        [TestMethod]
        public void XMLTESTACCTTEMPLATEDeserialize()
        {
            string str = "";
            COPXmlFactory.RTTIE010.ACCTTEMPLATE acct = (COPXmlFactory.RTTIE010.ACCTTEMPLATE)COPXmlFactory.RevenueGovXMLFactory.GetObjectfromXmlString(str);
            Assert.IsFalse(false, "Success");

        }

        [TestMethod]
        public void XMLTESTBPTRETURN()
        {

            COPXmlFactory.RTTIE037.BPTezReturn bpt = COPXmlFactory.RevenueGovXMLFactory.GetBPTezReturn();

            XmlDocument doc = COPXmlFactory.RevenueGovXMLFactory.GetXmlDocument(bpt);

            Assert.IsFalse(false, "Success");

            //xutil.XMLToString(
        }

        [TestMethod]
        public void XMLTESTBPTlfReturn()
        {

            COPXmlFactory.RTTIE030.BPTlfReturn bpl = COPXmlFactory.RevenueGovXMLFactory.GetBPTlfReturn();

            XmlDocument doc = COPXmlFactory.RevenueGovXMLFactory.GetXmlDocument(bpl);

            Assert.IsFalse(false, "Success");

            //xutil.XMLToString(
        }
         * 
         * */
    }
}
