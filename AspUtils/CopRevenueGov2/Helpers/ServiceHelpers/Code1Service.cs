using CopRevenueGov2.Service;
using COPXmlFactory;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml;
using COPXmlFactory.Code1AddressCheck;

namespace CopRevenueGov2.Helpers
{

    public class Code1Service : CopRestServiceBase, ICopSoapService
    {

        static Code1_SrvRef.Service1SoapClient _client = null;

        public static void Init()
        {
            _client = new Code1_SrvRef.Service1SoapClient();
        }

        //public static string CallService(string Request)
        //{
        //    //COPXmlFactory.Code1AddressCheck.c1match xo;
        //    //string Code1response;

        //    // xo = RevenueGovXMLFactory.GetObject<COPXmlFactory.Code1AddressCheck.c1match>(Request);
        //    // Code1response=_client.Code1(xo.ADD1,xo.ADD2,xo.ZIP);
        //    //return Code1response;

        //    COPXmlFactory.Code1AddressCheck.c1match acct;

        //    try
        //    {
        //        string InnerXML = Request.inn;
        //        acct = RevenueGovXMLFactory.GetObject<COPXmlFactory.Code1AddressCheck.c1match>(InnerXML);

        //        acct = __Call(acct);

        //    }
        //    catch (Exception ex)
        //    {
        //        acct = RevenueGovXMLFactory.GetTOBACCORETURN();

        //        acct.ERROR_INFO = new ERROR_INFO();
        //        acct.ERROR_INFO.ERROR = 11.ToString();
        //        acct.ERROR_INFO.MESSAGE = ex.Message;
        //    }

        //    return RevenueGovXMLFactory.GetXmlDocument(acct);


        //}

        public static XmlDocument CallService(XmlDocument Request)
        {
            XmlDocument xm = new XmlDocument();
            COPXmlFactory.Code1AddressCheck.c1match xo;
           
            try
            {

                string InnerXML = Request.InnerXml;
               
                xo = RevenueGovXMLFactory.GetObject<COPXmlFactory.Code1AddressCheck.c1match>(InnerXML);
                xo=__Call(xo);
                //Code1response = _client.Code1(xo.Address1, "wayne", xo.Zip);
                //xo = RevenueGovXMLFactory.GetObject<COPXmlFactory.Code1AddressCheck.c1match>(Code1response);
              
                
            }
            catch (Exception ex)
            {
                xo = RevenueGovXMLFactory.GetCode1AddressCheck();
                xo.Message = ex.Message;

            }
            return RevenueGovXMLFactory.GetXmlDocument(xo);
        }
        private static c1match __Call(c1match e)
        {
             string Code1response;
             if (e.Address2.Value==null)
             {
                 e.Address2 = string.Empty;
             }
             Code1response = _client.Code1(e.Address1, e.Address2, e.Zip);
            
            e = RevenueGovXMLFactory.GetObject<COPXmlFactory.Code1AddressCheck.c1match>(Code1response);
            return e;
        }
          
        }


    }
