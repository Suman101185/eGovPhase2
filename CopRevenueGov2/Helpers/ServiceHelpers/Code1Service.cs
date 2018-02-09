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
            
        }        

        public static XmlDocument CallService(XmlDocument Request)
        {
            XmlDocument xm = new XmlDocument();
            COPXmlFactory.Code1AddressCheck.c1match xo;
           
            try
            {
                string InnerXML = Request.InnerXml;               
                xo = RevenueGovXMLFactory.GetObject<COPXmlFactory.Code1AddressCheck.c1match>(InnerXML);
                xo=__Call(xo);               
              
                
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
            _client = new Code1_SrvRef.Service1SoapClient();
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
