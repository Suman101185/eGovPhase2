using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace COPXmlFactory
{

    namespace Code1Service
    {
        [XmlRoot(ElementName = "CODE1")]
        public class Code1 : ICOPXmlTemplate
        {
            [XmlElement]
            public XmlNodeEntity ADD1 { set; get; }
            [XmlElement]
            public XmlNodeEntity ADD2 { set; get; }
            [XmlElement]
            public XmlNodeEntity ZIP { set; get; }

        }
    }

}
