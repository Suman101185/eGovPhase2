using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace COPXmlFactory
{

    namespace Code1AddressCheck
    {
        [XmlRoot(ElementName = "c1match")]
        public class c1match: ICOPXmlTemplate
        {
            [XmlElement]
            public XmlNodeEntity Message { set; get; }
            [XmlElement]
            public XmlNodeEntity Closeness { set; get; }
            [XmlElement]
            public XmlNodeEntity Address1 { set; get; }

            [XmlElement]
            public XmlNodeEntity Address2 { set; get; }
            [XmlElement]
            public XmlNodeEntity City { set; get; }
            [XmlElement]
            public XmlNodeEntity State { set; get; }

            [XmlElement]
            public XmlNodeEntity Zip { set; get; }
            [XmlElement]
            public XmlNodeEntity Zip4 { set; get; }
            [XmlElement]
            public XmlNodeEntity houseno { set; get; }

          

            [XmlElement]
            public XmlNodeEntity direction { set; get; }
            [XmlElement]
            public XmlNodeEntity designation { set; get; }
            [XmlElement]
            public XmlNodeEntity DPC { set; get; }

            [XmlElement]
            public XmlNodeEntity DPBC { set; get; }
            [XmlElement]
            public XmlNodeEntity CRT { set; get; }
            [XmlElement]
            public XmlNodeEntity street { set; get; }

        }
    }

}
