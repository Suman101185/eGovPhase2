using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace COPXmlFactory
{
    public class ERROR_INFO : XmlNodeEntityBase
    {
        [XmlElement]
        public XmlNodeEntity PROGRAM { set; get; }
        [XmlElement]
        public XmlNodeEntity ERROR { set; get; }
        [XmlElement]
        public XmlNodeEntity LINE { set; get; }
        [XmlElement]
        public XmlNodeEntity MESSAGE { set; get; }
    }

    public class HEADER_INFO : XmlNodeEntity
    {

    }

    public class DEBUG : XmlNodeEntity
    {

    }
}
