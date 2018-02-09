
using CopRevenueGov2.Helpers;
using COPXmlFactory;
using COPXmlFactory.RTTIE010;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml;

namespace CopRevenueGov2.Service
{
    public partial class ServiceManager
    {
    }
        public interface ICopSoapService
        {
        }

        public class CopSoapServiceBase
        {
            public string ServerAddress { get; set; }
            public int ErrorNumber { get; set; }
            public string ErrorMessage { get; set; }
            public string ErrorClass { get; set; }
        }



}