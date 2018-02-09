using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace COPXmlFactory
{
    public class XmlNodeEntity : XmlNodeEntityBase
    {
        [XmlText]
        public string Value { set; get; }


        public XmlNodeEntity()
        {
        }

        XmlNodeEntity(string e)
        {
            this.Value = e;
        }

        public static implicit operator XmlNodeEntity(string e)
        {
            if (e == null)
            {
                return null;
            }

            XmlNodeEntity o = new XmlNodeEntity(e);
            return o;
        }

        public static implicit operator string(XmlNodeEntity e)
        {
            if (e == null)
            {
                return null;
            }
            return e.Value;
        }

        public override string ToString()
        {
            return this.Value;
        }
    }

    public class XmlNodeEntityBase
    {
        [XmlAttribute]
        public string OCCURS { set; get; }
        [XmlAttribute]
        public string LENGTH { set; get; }
        [XmlAttribute]
        public string EXPORT { set; get; }
        [XmlAttribute(AttributeName = "TYPE")]
        public string Attr_TYPE { set; get; }
        [XmlAttribute]
        public string ENVIRONMENT { set; get; }
        [XmlAttribute]
        public string PERCISION { set; get; }

    }
}
