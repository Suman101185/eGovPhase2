using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

namespace TestConsoleApp
{
    class abc
    {
        public void stringTESTACCTTEMPLATE()
        {

            COPXmlFactory.RTTIE010.ACCTTEMPLATE acct = COPXmlFactory.RevenueGovXMLFactory.GetAcctTemplate();

            string str = COPXmlFactory.RevenueGovXMLFactory.GetXmlString(acct);

            //Assert.IsFalse(false, "Success");

            //xutil.XMLToString(
        }


        public void XMLTESTACCTTEMPLATEDeserialize()
        {
            System.IO.StreamReader myFile =
                new System.IO.StreamReader("E:\\Login_Response.txt");
            string myString = myFile.ReadToEnd();

            

            myFile.Close();

            COPXmlFactory.RTTIE010.ACCTTEMPLATE acct = (COPXmlFactory.RTTIE010.ACCTTEMPLATE)COPXmlFactory.RevenueGovXMLFactory.GetObjectfromXmlString(myString);

            acct.ENTITY_INFO.ACCOUNT_ID = "333333333";

            string str = COPXmlFactory.RevenueGovXMLFactory.GetXmlString(acct);

        }
        public void stringTESTBPTEZRETURN()
        {

            COPXmlFactory.RTTIE037.BPTezReturn bpt = COPXmlFactory.RevenueGovXMLFactory.GetBPTezReturn();

            string str = COPXmlFactory.RevenueGovXMLFactory.GetXmlString(bpt);

            
        }
        public void XMLTESTBPTezReturnDeserialize()
        {
            System.IO.StreamReader myFile =
                new System.IO.StreamReader("E:\\bptez.txt");
            string myString = myFile.ReadToEnd();



            myFile.Close();
            string str = "";

            COPXmlFactory.RTTIE037.BPTezReturn acct = (COPXmlFactory.RTTIE037.BPTezReturn)COPXmlFactory.RevenueGovXMLFactory.GetObjectfromXmlStringBPTezreurn(myString);          

            string str1= COPXmlFactory.RevenueGovXMLFactory.GetXmlString(acct);

        }
        public void stringTESTBPTlfRETURN()
        {

            COPXmlFactory.RTTIE030.BPTlfReturn bpt = COPXmlFactory.RevenueGovXMLFactory.GetBPTlfReturn();

            string str = COPXmlFactory.RevenueGovXMLFactory.GetXmlString(bpt);


        }
        public void XMLTESTBPTlfReturnDeserialize()
        {
            System.IO.StreamReader myFile =
                new System.IO.StreamReader("E:\\update_request.txt");
            string myString = myFile.ReadToEnd();



            myFile.Close();
            string str = "";

            COPXmlFactory.RTTIE030.BPTlfReturn bptlf = (COPXmlFactory.RTTIE030.BPTlfReturn)COPXmlFactory.RevenueGovXMLFactory.GetObjectfromXmlStringBPTlfreurn(myString);
            bptlf.BPT_INFO.ACCOUNT_ID = "11111";
            string str1 = COPXmlFactory.RevenueGovXMLFactory.GetXmlString(bptlf);

        }

    }
}
