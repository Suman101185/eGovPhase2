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
        public static Code1Service.Code1 GetCode1()
        {
            Code1Service.Code1 cd = new Code1Service.Code1();

            cd.ADD1 = new XmlNodeEntity();
            cd.ADD1 = "";
            cd.ADD2 = new XmlNodeEntity();
            cd.ADD2 = "";
            cd.ZIP = new XmlNodeEntity();
            cd.ZIP = "";

            return cd;

        }

    }
}
