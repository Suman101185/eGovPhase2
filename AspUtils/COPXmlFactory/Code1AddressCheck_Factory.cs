using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace COPXmlFactory
{
   
        public partial class RevenueGovXMLFactory : XMLFactory
    {
         /// <summary>
        /// This method is used to create the object of Code1Service
        /// </summary>
        /// <returns></returns>
        public static Code1AddressCheck.c1match GetCode1AddressCheck()
        {
            Code1AddressCheck.c1match cd = new Code1AddressCheck.c1match();

            cd.Message = new XmlNodeEntity();
            cd.Message = "";
            cd.Closeness = new XmlNodeEntity();
            cd.Closeness = "";
            cd.Address1 = new XmlNodeEntity();
            cd.Address1 = "";
            cd.Address2 = new XmlNodeEntity();
            cd.Address2 = "";
            cd.City = new XmlNodeEntity();
            cd.City = "";
            cd.State = new XmlNodeEntity();
            cd.State = "";
            cd.Zip = new XmlNodeEntity();
            cd.Zip = "";
            cd.Zip4 = new XmlNodeEntity();
            cd.Zip4 = "";
            cd.houseno = new XmlNodeEntity();
            cd.houseno = "";
            cd.direction = new XmlNodeEntity();
            cd.direction = "";
            cd.designation = new XmlNodeEntity();
            cd.designation = "";
            cd.DPC = new XmlNodeEntity();
            cd.DPC = "";
            cd.DPBC = new XmlNodeEntity();
            cd.DPBC = "";
            cd.CRT = new XmlNodeEntity();
            cd.CRT = "";
            cd.street = new XmlNodeEntity();
            cd.street = "";
            

            return cd;

        }

    }
}
    

