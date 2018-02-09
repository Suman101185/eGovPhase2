using CopRevenueGov2.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Xml;
using System.Net;

namespace CopRevenueGov2.Service
{

    public enum CopServiceObjectType
    {
        EOL_GencityBuffer,
        Persits_MailSender,
        EOL_Code1Form,
        EOL_BPTezForm,
        EOL_WageForm,
        EOL_SchoolForm,
        EOL_TobaccoForm,
        EOL_NPTForm,
        EOL_DelinquentForm,
        EOL_UOForm,
        EOL_CouponForm,
        EOL_LossCarryForward,
        EOL_BPTlf,
        EOL_TIPSACCT

    }

    public partial class ServiceManager
    {
        public static Service.ICopService GetObject(string TypeName)
        {
            CopServiceObjectType? type = null;

            switch (TypeName)
            {
                case "EOL.GenCityBuffer":
                    type = CopServiceObjectType.EOL_GencityBuffer;
                    break;

                case "Persits.MailSender":
                    type = CopServiceObjectType.Persits_MailSender;
                    break;

                case "EOL.Code1Form":
                    type = CopServiceObjectType.EOL_Code1Form;
                    break;

                case "EOL.BPTezForm":
                    type = CopServiceObjectType.EOL_BPTezForm;
                    break;

                case "EOL.WageForm":
                    type = CopServiceObjectType.EOL_WageForm;
                    break;

                case "EOL.SchoolForm":
                    type = CopServiceObjectType.EOL_SchoolForm;
                    break;

                case "EOL.TobaccoForm":
                    type = CopServiceObjectType.EOL_TobaccoForm;
                    break;

                case "EOL.NPTForm":
                    type = CopServiceObjectType.EOL_NPTForm;
                    break;

                case "EOL.DelinquentForm":
                    type = CopServiceObjectType.EOL_DelinquentForm;
                    break;

                case "EOL.UOForm":
                    type = CopServiceObjectType.EOL_UOForm;
                    break;

                case "EOL.CouponForm":
                    type = CopServiceObjectType.EOL_CouponForm;
                    break;

                case "EOL.LossCarryForward":
                    type = CopServiceObjectType.EOL_LossCarryForward;
                    break;

                case "EOL.BPTlf":
                    type = CopServiceObjectType.EOL_BPTlf;
                    break;

                case "EOL.TIPSACCT":
                    type = CopServiceObjectType.EOL_TIPSACCT;
                    break;

                default:
                    type = null;
                    break;
            }

            if (type != null)
            {
                CopServiceObjectType _t = (CopServiceObjectType)type;
                return GetObject(_t);
            }
            else
            {
                return null;
            }
        }

        public static Service.ICopService GetObject(CopServiceObjectType Type)
        {
            ICopService obj;

            switch (Type)
            {
                case CopServiceObjectType.EOL_GencityBuffer:
                    obj = new EOLGenCityBuffer() { RestMethodUrlFragment = "RTTIE010/REST" };
                    break;

                case CopServiceObjectType.Persits_MailSender:
                    obj = new Persits_MailSender();
                    break;

                case CopServiceObjectType.EOL_Code1Form:
                    obj = new EOL_Code1Form() { RestMethodUrlFragment = "RTTIE010/REST" };
                    break;

                case CopServiceObjectType.EOL_BPTezForm:
                    obj = new EOL_BPTezForm() { RestMethodUrlFragment = "RTTIE037/REST" };
                    break;

                case CopServiceObjectType.EOL_WageForm:
                    obj = new EOL_WageForm() { RestMethodUrlFragment = "RTTIE010/REST" };
                    break;

                case CopServiceObjectType.EOL_SchoolForm:
                    obj = new EOL_SchoolForm() { RestMethodUrlFragment = "RTTIE010/REST" };
                    break;

                case CopServiceObjectType.EOL_TobaccoForm:
                    obj = new EOL_TobaccoForm() { RestMethodUrlFragment = "RTTIE010/REST" };
                    break;

                case CopServiceObjectType.EOL_NPTForm:
                    obj = new EOL_NPTForm() { RestMethodUrlFragment = "RTTIE010/REST" };
                    break;

                case CopServiceObjectType.EOL_DelinquentForm:
                    obj = new EOL_DelinquentForm() { RestMethodUrlFragment = "RTTIE010/REST" };
                    break;

                case CopServiceObjectType.EOL_UOForm:
                    obj = new EOL_UOForm() { RestMethodUrlFragment = "RTTIE010/REST" };
                    break;

                case CopServiceObjectType.EOL_CouponForm:
                    obj = new EOL_UOForm() { RestMethodUrlFragment = "RTTIE010/REST" };
                    break;

                case CopServiceObjectType.EOL_LossCarryForward:
                    obj = new EOL_LossCarryForward() { RestMethodUrlFragment = "RTTIE010/REST" };
                    break;

                case CopServiceObjectType.EOL_BPTlf:
                    obj = new EOL_BPTlf() { RestMethodUrlFragment = "RTTIE030/REST" };
                    break;

                case CopServiceObjectType.EOL_TIPSACCT:
                    obj = new EOL_TIPSACCT() { RestMethodUrlFragment = "RTTIE010/REST" };
                    break;

                default:
                    obj = null;
                    break;
            }

            return obj;
        }
    }

    public  interface ICopService
    {

    }

    public class CopRestServiceBase
    {
        public string RestMethodUrlFragment { get; set; }
        public string ServerAddress { get; set; }
        public int ErrorNumber { get; set; }
        public string ErrorMessage { get; set; }
        public string ErrorClass { get; set; }
        public bool Send()
        {
            return true;
        }

        protected void FilterForXMLStringNodes(ref string[] StringValueArray)
        {
            for (int i = 0; StringValueArray != null && i < StringValueArray.Length; i++)
            {
                StringValueArray[i] = StringValueArray[i].Replace("<string>", "");
                StringValueArray[i] = StringValueArray[i].Replace("</string>", "");
            }
        }

        protected void FilterForXMLStringNodes(ref string StringValue)
        {
            StringValue = StringValue.Replace("<string>", "");
            StringValue = StringValue.Replace("</string>", "");
        }

        protected XmlDocument SendRESTRequest(string RequestUrl)
        {
            XmlDocument xdoc = new XmlDocument();
            try
            {
                WebClient r = new WebClient();
                xdoc.LoadXml(r.DownloadString(ServerAddress));
            }
            catch (Exception ex)
            {
                ErrorMessage = ex.Message;
                /* just a non zero number for now */
                ErrorNumber = 1;
            }

            return xdoc;
        }

        protected string GetSingleSectionValue(XmlDocument oXML, string sSection)
        {
            XmlNodeList l = oXML.SelectNodes("//*/" + sSection);
            string vData = string.Empty;
            if (l.Count > 0)
            {
                vData = l[0].InnerXml;
                FilterForXMLStringNodes(ref vData);
            }
            return vData;
        }

        protected string[] GetSectionValues(XmlDocument oXML, string sSection)
        {
            XmlNodeList l = oXML.SelectNodes("//*/" + sSection);

            if (l.Count < 0)
            {
                return new string[] { "" };
            }

            string[] vData = new string[l[0].ChildNodes.Count];

            for (int i = 0; i < l[0].ChildNodes.Count; i++)
            {
                vData[i] = l[0].ChildNodes[i].InnerXml;
                FilterForXMLStringNodes(ref vData[i]);
            }
            return vData;
        }

        protected string JoinArray(string[] value, string separetor)
        {
            CString result = string.Empty;

            for (int i = 0; i < value.Length - 1; i++)
            {
                result += value[i] + separetor;
            }
            return result;
        }
    }

    public class EOLGenCityBuffer : CopRestServiceBase, ICopService
    {
        public string SMA { get; set; }
        public string EMI { get; set; }
        public string[] ETA { get; set; }
        public string ECHK { get; set; }
        public string[] ENA_1 { get; set; }
        public string[] ENA_2 { get; set; }

        RevFuncSrv r = new RevFuncSrv();

        public XmlDocument RTTIE010()
        {
            XmlDocument xml = new XmlDocument();

            /* send xml to base.ServerAddress */

            string x = string.Empty;

            x = "sma :" + SMA + Environment.NewLine;
            x += "emi :" + EMI + Environment.NewLine;
            x += "eta :" + base.JoinArray(ETA, "|") + Environment.NewLine;
            x += "echk :" + ECHK + Environment.NewLine;
            x += "ena1 :" + base.JoinArray(ENA_1, "|") + Environment.NewLine;
            x += "ena2 :" + base.JoinArray(ENA_2, "|") + Environment.NewLine;

            r.WriteDebugFile("RTTIE010_PARAMETER_SEND_VALUES.txt", x);

            base.ServerAddress += base.RestMethodUrlFragment;
            base.ServerAddress = CopQueryString.AddSMA(SMA, base.ServerAddress);
            base.ServerAddress = CopQueryString.AddEMI(EMI, base.ServerAddress);
            base.ServerAddress = CopQueryString.AddETA(ETA, base.ServerAddress);
            base.ServerAddress = CopQueryString.AddECHK(ECHK, base.ServerAddress);
            base.ServerAddress = CopQueryString.AddENA1(ENA_1, base.ServerAddress);
            base.ServerAddress = CopQueryString.AddENA2(ENA_2, base.ServerAddress);

            xml = base.SendRESTRequest(base.ServerAddress);
            /* dev env. may not have web access and_ 
             * in that case it will try to supply demo XML from local file to simulate the service call 
             */
            base.ErrorNumber = 1;

            if (base.ErrorNumber != 0)
            {
                CopMvcUtil util = new CopMvcUtil();
                string path = HttpContext.Current.Server.MapPath(@"~\");
                path += @"TestRestServiceReturnXMLs\RTTIE010_555555187_expected.xml";

                string xml_string = util.GetXMLString(path);
                xml.LoadXml(xml_string);
                base.ErrorNumber = 0;
            }

            return xml;
        }

        public bool RTTIE010(ref string _SMA, ref string _EMI, ref string[] _ETA, ref string _ECHK, ref string[] _ENA_1, ref string[] _ENA_2)
        {
            this.SMA = _SMA;
            this.EMI = _EMI;
            this.ETA = _ETA;
            this.ECHK = _ECHK;
            this.ENA_1 = _ENA_1;
            this.ENA_2 = _ENA_2;
   
                
                //RevFuncSrv rev = new RevFuncSrv();
                try
                {
                    XmlDocument XResponse = RTTIE010();
                /* Read for parameter values from XML data */

                /* sma */
                
                _SMA = base.GetSingleSectionValue(XResponse, "SMA" );

                /* emi */

                _EMI = base.GetSingleSectionValue(XResponse, "EMI");

                /* ETA */

                _ETA = base.GetSectionValues(XResponse, "ETA" );
                //base.FilterArrayForXMLStringNodes(ref _ETA);

                /* echk */

                _ECHK = base.GetSingleSectionValue(XResponse, "ECHK");

                /* ENA1 */

                _ENA_1 = base.GetSectionValues(XResponse, "ENA-1");
                //base.FilterArrayForXMLStringNodes(ref _ENA_1);

                /* ENA2 */

                _ENA_2 = base.GetSectionValues(XResponse, "ENA-2" );
                //base.FilterArrayForXMLStringNodes(ref _ENA_2);

                this.SMA = _SMA;
                this.EMI = _EMI;
                this.ETA = _ETA;
                this.ECHK = _ECHK;
                this.ENA_1 = _ENA_1;
                this.ENA_2 = _ENA_2;

                string x = string.Empty;

                x = "sma :" + SMA + Environment.NewLine;
                x += "emi :" + EMI + Environment.NewLine;
                x += "eta :" + base.JoinArray(ETA, "|") + Environment.NewLine;
                x += "echk :" + ECHK + Environment.NewLine;
                x += "ena1 :" + base.JoinArray( ENA_1, "|") + Environment.NewLine;
                x += "ena2 :" + base.JoinArray( ENA_2, "|") + Environment.NewLine;

                r.WriteDebugFile("RTTIE010_PARAMETER_RECEIVED_VALUES.txt", x);

                /*******************************************/
                return true;
            }
            catch (Exception ex)
            {
                /* Error numbers were implimented by previous system where connection to mainframe was by AGP dlls
                 * And those COM dll used to return a error number on connection errors 
                 * but in new system this numbers are imporper and we need to impliment in manually so carry same meaning
                 * so on Exception we are putting here a random number
                 */
                base.ErrorNumber = 1;
                base.ErrorMessage = ex.Message;
                return false;
            }
        }
    }

    public class Persits_MailSender : ICopService
    {

        SmtpClient smtpClient = null;
        MailMessage mailMsg = null;

        public string AttachmentFilePath { get; set; }
        public string Host { get; set; }
        public string From { get; set; }
        public string Subject { get; set; }
        public string Body { get; set; }
        List<string> ToAddress { get; set; }
        List<string> CCAddress { get; set; }
        public bool IsHTML { get; set; }


        public void AddCC(string value)
        {
            if (CCAddress == null)
            {
                CCAddress = new List<string>();
            }

            CCAddress.Add(value);
        }

        public void AddAddress(string value)
        {
            if (ToAddress == null)
            {
                ToAddress = new List<string>();
            }

            ToAddress.Add(value);
        }

        public void  Send()
        {
            smtpClient = new SmtpClient(Host);
            mailMsg = new MailMessage();

            for (int i = 0; ToAddress != null && i < ToAddress.Count; i++)
            {
                mailMsg.To.Add(ToAddress[i]);
            }

            for (int i = 0; CCAddress != null && i < CCAddress.Count; i++)
            {
                mailMsg.CC.Add(CCAddress[i]);
            }

            if (mailMsg.To.Count > 0)
            {
                mailMsg.Subject = Subject;
                mailMsg.Body = Body;
                mailMsg.From = new MailAddress(From, "phila.gov");
                if (AttachmentFilePath != null)
                {
                    Attachment attachFile = new Attachment(AttachmentFilePath);
                    mailMsg.Attachments.Add(attachFile);
                }
                mailMsg.IsBodyHtml = IsHTML;
                try
                {
                    smtpClient.Send(mailMsg);
                }
                catch (Exception ex)
                {
                    RevFuncSrv rev = new RevFuncSrv();
                    rev.WriteDebugFile("MAIL_SEND_FAILED", mailMsg +
                        Environment.NewLine + Environment.NewLine + "ERROR : *****************************" +
                        ex.StackTrace.ToString());
                }
            }

        }





    }

    public class EOL_Code1Form : CopRestServiceBase, ICopService
    {
        public CString SMA { get; set; }
        public CString EMI { get; set; }
        public CString ETA { get; set; }
        public CString ECHK { get; set; }
        public CString ENA_1 { get; set; }
        public CString ENA_2 { get; set; }

        public bool RTTIE050()
        {
            /* send xml to base.ServerAddress */
            return true;
        }

        public bool RTTIE050(ref string _SMA, ref string _EMI, ref string _ETA, ref string _ECHK)
        {
            this.SMA = _SMA;
            this.EMI = _EMI;
            this.ETA = _ETA;
            this.ECHK = _ECHK;           

            return RTTIE050();
        }

    }

    public class EOL_BPTezForm : CopRestServiceBase, ICopService
    {
        public string SMA { get; set; }
        public string BPT { get; set; }
        public string PAGE1 { get; set; }
        public string PAGE2 { get; set; }

        RevFuncSrv r = new RevFuncSrv();


        public XmlDocument RTTIE037()
        {
            XmlDocument xml = new XmlDocument();

            /* send xml to base.ServerAddress */

            string x = string.Empty;

            x = "sma :" + SMA + Environment.NewLine;
            x += "ebpt :" + BPT + Environment.NewLine;
            x += "page1 :" + PAGE1 + Environment.NewLine;
            x += "page2 :" + PAGE2 + Environment.NewLine;


            r.WriteDebugFile("RTTIE037_PARAMETER_SEND_VALUES.txt", x);



            base.ServerAddress += base.RestMethodUrlFragment;
            base.ServerAddress = CopQueryString.AddSMA(SMA, base.ServerAddress);
            base.ServerAddress = CopQueryString.AddBPT(BPT, base.ServerAddress);
            base.ServerAddress = CopQueryString.AddPAGE1(PAGE1, base.ServerAddress);
            base.ServerAddress = CopQueryString.AddPAGE2(PAGE2, base.ServerAddress);


            xml = base.SendRESTRequest(base.ServerAddress);
            /* dev env. may not have web access and_ 
             * in that case it will try to supply demo XML from local file to simulate the service call 
             */

            if (base.ErrorNumber != 0)
            {
                CopMvcUtil util = new CopMvcUtil();
                string path = HttpContext.Current.Server.MapPath(@"~\");
                path += @"TestRestServiceReturnXMLs\RTTIE037_555555187_expected.xml";

                string xml_string = util.GetXMLString(path);
                xml.LoadXml(xml_string);
                base.ErrorNumber = 0;
            }

            return xml;        
        }

        public bool RTTIE037(ref string _SMA, ref string _BPT, ref string _PAGE1, ref string _PAGE2)
        {
            this.SMA = _SMA;
            this.BPT = _BPT;
            this.PAGE1 = _PAGE1;
            this.PAGE2 = _PAGE2;

            //RevFuncSrv rev = new RevFuncSrv();
            try
            {
                XmlDocument XResponse = RTTIE037();
                /* Read for parameter values from XML data */

                _SMA = base.GetSingleSectionValue(XResponse, "SMA");
                //_SMA = _SMA.Replace("RTTIE037", VB.space(8));
                _BPT = base.GetSingleSectionValue(XResponse, "E-BPT");
                _PAGE1 = base.GetSingleSectionValue(XResponse, "E-PG1");
                _PAGE2 = base.GetSingleSectionValue(XResponse, "E-EZ-PG2");

                this.SMA = _SMA;
                this.BPT = _BPT;
                this.PAGE1 = _PAGE1;
                this.PAGE2 = _PAGE2;

                string x = string.Empty;

                x = "sma :" + SMA + Environment.NewLine;
                x += "ebpt :" + BPT + Environment.NewLine;
                x += "page1 :" + PAGE1 + Environment.NewLine;
                x += "page2 :" + PAGE2 + Environment.NewLine;

                r.WriteDebugFile("RTTIE037_PARAMETER_RECEIVED_VALUES.txt", x);

                /*******************************************/
                return true;
            }
            catch (Exception ex)
            {
                /* Error numbers were implimented by previous system where connection to mainframe was by AGP dlls
                 * And those COM dll used to return a error number on connection errors 
                 * but in new system this numbers are imporper and we need to impliment in manually so carry same meaning
                 * so on Exception we are putting here a random number
                 */
                base.ErrorNumber = 1;
                base.ErrorMessage = ex.Message;
                return false;
            }
        }

    }

    public class EOL_WageForm : CopRestServiceBase, ICopService
    {
        public CString SMA { get; set; }
        public CString WAGE { get; set; }
        public CString AMT { get; set; }


        public bool RTTIE027()
        {
            /* send xml to base.ServerAddress */
            return true;
        }

        public bool RTTIE027(ref string _SMA, ref string _WAGE, ref string _AMT)
        {
            this.SMA = _SMA;
            this.WAGE = _WAGE;
            this.AMT = _AMT;

            return RTTIE027();
        }
    }

    public class EOL_SchoolForm : CopRestServiceBase, ICopService
    {
        public CString SMA { get; set; }
        public CString SIT { get; set; }
        public CString AMT { get; set; }


        public bool RTTIE036()
        {
            /* send xml to base.ServerAddress */
            return true;
        }

        public bool RTTIE036(ref string _SMA, ref string _SIT, ref string _AMT)
        {
            this.SMA = _SMA;
            this.SIT = _SIT;
            this.AMT = _AMT;

            return RTTIE036();
        }
    }

    public class EOL_TobaccoForm : CopRestServiceBase, ICopService
    {
        public CString SMA { get; set; }
        public CString TOB { get; set; }
        public CString AMT { get; set; }


        public bool RTTIE028()
        {
            /* send xml to base.ServerAddress */
            return true;
        }

        public bool RTTIE028(ref string _SMA, ref string _TOB, ref string _AMT)
        {
            this.SMA = _SMA;
            this.TOB = _TOB;
            this.AMT = _AMT;

            return RTTIE028();
        }
    }

    public class EOL_NPTForm : CopRestServiceBase, ICopService
    {
        public CString SMA { get; set; }
        public CString NPT { get; set; }
        public CString AMTS { get; set; }


        public bool RTTIE039()
        {
            /* send xml to base.ServerAddress */
            return true;
        }

        public bool RTTIE039(ref string _SMA, ref string _NPT, ref string _AMTS)
        {
            this.SMA = _SMA;
            this.NPT = _NPT;
            this.AMTS = _AMTS;

            return RTTIE039();
        }
    }

    public class EOL_DelinquentForm : CopRestServiceBase, ICopService
    {
        public CString SMA { get; set; }
        public CString EMI { get; set; }
        public string[] ETA { get; set; }


        public bool RTTIE022()
        {
/*
12:12:38  Parameter   RTTIP022 Library TIPSACCP    2013-08-06
 0010     1 #SMA                             A   79
 0020   R 1 #SMA
 0030     2 #SYSTEM-MESSAGE-AREA
 0040     3 PROGRAM                          A    8
 0050     3 ERROR                            N    7
 0060     3 LINE                             N    4
 0070     3 MESSAGE                          A   60
 0080     1 #EMI                             A   51
 0090   R 1 #EMI
 0100     2 #ENTITY-MASTER-INFO
 0110     3 ENTITY-TYPE                      N    3
 0120     3 ENTITY-ID                        A   11
 0130     3 FUNCTION                         A    1
 0140     3 NOTICE-NUM                       A   13
 0150     3 NEXT-ACCOUNT                     A    3
 0160     3 NEXT-ACCOUNT-ID                  A   12
 0170     3 NEXT-PERIOD                      A    8
 0180     1 #ETA                             A  130 (1:225)
 0190   R 1 #ETA
 0200     2 #ENTITY-TAX-ACCOUNTS                    (1:225)
 0210     3 FUNCTION-CODE                    A    1
 0220     3 ACCOUNT                          A    3
 0230     3 ACCOUNT-ID                       A   12
 0240     3 PERIOD-X                         A    8
 0250     3 PRINCIPAL-X                      A   13
 0260     3 INTEREST-X                       A   13
 0270     3 PENALTY-X                        A   13
 0280     3 OTHER-X                          A   13
 0290     3 BRT-ENTITY                       A   11
 0300     3 BRT-ADDRESS                      A   40
 0310     3 FILL                             A    3
 * */
            return true;
        }

        public bool RTTIE022(ref string _SMA, ref string _EMI, ref string[] _ETA)
        {
            this.SMA = _SMA;
            this.EMI = _EMI;
            this.ETA = _ETA;

            return RTTIE022();
        }
    }

    public class EOL_UOForm : CopRestServiceBase, ICopService
    {


        public CString SMA { get; set; }
        public CString ACCT { get; set; }
        public CString AMTS { get; set; }
        public string[] UO3 { get; set; }


        public bool RTTIE035()
        {
            /* send xml to base.ServerAddress */
            return true;
        }

        public bool RTTIE035(ref string _SMA, ref string _ACCT, ref string _AMTS, ref string[] _UO3)
        {
            this.SMA = _SMA;
            this.ACCT = _ACCT;
            this.AMTS = _AMTS;
            this.UO3 = _UO3;

            return RTTIE035();
        }
    }

    public class EOL_UOList : CopRestServiceBase, ICopService
    {


        public CString SMA { get; set; }
        public CString INFO { get; set; }
        public string[] ACCT { get; set; }


        public bool RTTIE034()
        {
            /* send xml to base.ServerAddress */
            return true;
        }

        public bool RTTIE034(ref string _SMA, ref string _INFO, ref string[] _ACCT)
        {
            this.SMA = _SMA;
            this.ACCT = _ACCT;
            this.INFO = _INFO;

            return RTTIE034();
        }
    }

    public class EOL_CouponForm : CopRestServiceBase, ICopService
    {


        public CString SMA { get; set; }
        public CString EMI { get; set; }
        public string[] ETA { get; set; }
        public CString WNTL { get; set; }

        public bool RTTIE016()
        {
            /* send xml to base.ServerAddress */
            return true;
        }

        public bool RTTIE016(ref string _SMA, ref string _EMI, ref string[] _ETA, ref string _WNTL)
        {
            this.SMA = _SMA;
            this.EMI = _EMI;
            this.ETA = _ETA;
            this.WNTL = _WNTL;

            return RTTIE016();
        }
    }

    public class EOL_LossCarryForward : CopRestServiceBase, ICopService
    {

        public CString SMA { get; set; }
        public CString LCF { get; set; }

        public bool RTTIE031()
        {
            /* send xml to base.ServerAddress */
            return true;
        }

        public bool RTTIE031(ref string _SMA, ref string _LCF)
        {
            this.SMA = _SMA;
            this.LCF = _LCF;
            return RTTIE031();
        }

    }

    public class EOL_BPTlf : CopRestServiceBase, ICopService
    {

        public string SMA { get; set; }
        public string INFO { get; set; }
        public string PG1 { get; set; }
        public string SHCA { get; set; }
        public string SCHB { get; set; }
        public string SCHC1 { get; set; }
        public string SCHD { get; set; }
        public string SCHE { get; set; }
        RevFuncSrv r = new RevFuncSrv();

        public XmlDocument RTTIE030()
        {

        //http://isdev:5555/rest/RTTIE030/REST?E-LF-BPT=??????&E-LF-PG1=??????&E-LF-SCHA=??????&E-LF-SCHB=??????&E-LF-SCHC1=??????&E-LF-SCHD=??????&E-LF-SCHE=???????
            XmlDocument xml = new XmlDocument();

            /* send xml to base.ServerAddress */

            string x = string.Empty;

            x = "INFO :" + INFO + Environment.NewLine;
            x += "PG1 :" + PG1 + Environment.NewLine;
            x += "SHCA :" + SHCA + Environment.NewLine;
            x += "SCHB :" + SCHB + Environment.NewLine;
            x += "SCHC1 :" + SCHC1 + Environment.NewLine;
            x += "SCHD :" + SCHD + Environment.NewLine;
            x += "SCHE :" + SCHE + Environment.NewLine;

            r.WriteDebugFile("RTTIE030_PARAMETER_SEND_VALUES.txt", x);


            base.ServerAddress += base.RestMethodUrlFragment;
            base.ServerAddress = CopQueryString.Add_E_LF_BPT(INFO, base.ServerAddress);
            base.ServerAddress = CopQueryString.Add_E_LF_PG1(PG1, base.ServerAddress);
            base.ServerAddress = CopQueryString.Add_E_LF_SCHA(SHCA, base.ServerAddress);
            base.ServerAddress = CopQueryString.Add_E_LF_SCHB(SCHB, base.ServerAddress);
            base.ServerAddress = CopQueryString.Add_E_LF_SCHC1(SCHC1, base.ServerAddress);
            base.ServerAddress = CopQueryString.Add_E_LF_SCHD(SCHD, base.ServerAddress);
            base.ServerAddress = CopQueryString.Add_E_LF_SCHE(SCHE, base.ServerAddress);

            xml = base.SendRESTRequest(base.ServerAddress);
            /* dev env. may not have web access and_ 
             * in that case it will try to supply demo XML from local file to simulate the service call 
             */

            if (base.ErrorNumber != 0)
            {
                
                CopMvcUtil util = new CopMvcUtil();
                string path = HttpContext.Current.Server.MapPath(@"~\");
                path += @"TestRestServiceReturnXMLs\RTTIE030_555555187.xml";
                string xml_string = util.GetXMLString(path);
                xml.LoadXml(xml_string);
                base.ErrorNumber = 0;               
            }
            return xml;        
        }

        public bool RTTIE030(ref string _SMA, ref string _INFO, ref string _PG1, ref string _SHCA, ref string _SCHB, ref string _SCHC1, ref string _SCHD, ref string _SCHE)
        {
            this.SMA = _SMA;
            this.INFO = _INFO;
            this.PG1 = _PG1;
            this.SHCA = _SHCA;
            this.SCHB = _SCHB;
            this.SCHC1 = _SCHC1;
            this.SCHD = _SCHD;
            this.SCHE = _SCHE;

            
            try
            {
                XmlDocument XResponse = RTTIE030();
                /* Read for parameter values from XML data */

               
                _INFO = base.GetSingleSectionValue(XResponse, "E_LF_BPT");               
                _PG1 = base.GetSingleSectionValue(XResponse, "E_LF_PG1");
                _SHCA = base.GetSingleSectionValue(XResponse, "E_LF_BPT");
                _SCHB = base.GetSingleSectionValue(XResponse, "E_LF_BPT");
                _SCHC1 = base.GetSingleSectionValue(XResponse, "E_LF_BPT");
                _SCHD = base.GetSingleSectionValue(XResponse, "E_LF_BPT");
                _SCHE = base.GetSingleSectionValue(XResponse, "E_LF_BPT");

                this.SMA = _SMA;
                this.INFO = _INFO;
                this.PG1 = _PG1;
                this.SHCA = _SHCA;
                this.SHCA = _SCHB;
                this.SHCA = _SCHC1;
                this.SCHD = _SCHD;
                this.SCHE = _SCHE;

                string x = string.Empty;

                x = "INFO :" + INFO + Environment.NewLine;
                x += "PG1 :" + PG1 + Environment.NewLine;
                x += "SHCA :" + SHCA + Environment.NewLine;
                x += "SCHB :" + SCHB + Environment.NewLine;
                x += "SCHC1 :" + SCHC1 + Environment.NewLine;
                x += "SCHD :" + SCHD + Environment.NewLine;
                x += "SCHE :" + SCHE + Environment.NewLine;

                r.WriteDebugFile("RTTIE030_PARAMETER_RECEIVED_VALUES.txt", x);

                /*******************************************/
                return true;
            }
            catch (Exception ex)
            {
                /* Error numbers were implimented by previous system where connection to mainframe was by AGP dlls
                 * And those COM dll used to return a error number on connection errors 
                 * but in new system this numbers are imporper and we need to impliment in manually so carry same meaning
                 * so on Exception we are putting here a random number
                 */
                base.ErrorNumber = 1;
                base.ErrorMessage = ex.Message;
                return false;
            }
        }
    }

    public class EOL_TIPSACCT : CopRestServiceBase, ICopService
    {
        string ACCNO = string.Empty;
        string[] ACCDATA = new string[1];

        public bool RTTIE002()
        {
            /* send xml to base.ServerAddress */
            return true;
        }

        public bool RTTIE002(string _ACCNO, ref string[] _ACCDATA)
        {
            this.ACCNO = _ACCNO;
            this.ACCDATA = _ACCDATA;


            return RTTIE002();
        }
    }


}


