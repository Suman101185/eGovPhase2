using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Xml;

namespace CopRevenueGov2.Helpers
{
    public class XMLUtil
    {
        public string XMLToString(XmlDocument xdoc)
        {
            string xmlstring;
            StringWriter stringWriter = new StringWriter();
            XmlTextWriter xmlTextWriter = new XmlTextWriter(stringWriter);
            xdoc.WriteTo(xmlTextWriter);
            xmlstring = stringWriter.ToString();
            return xmlstring;
        }

        public static string sXMLToString(XmlDocument xdoc)
        {
            string xmlstring;
            StringWriter stringWriter = new StringWriter();
            XmlTextWriter xmlTextWriter = new XmlTextWriter(stringWriter);
            xdoc.WriteTo(xmlTextWriter);
            xmlstring = stringWriter.ToString();
            return xmlstring;
        }

        public string ispXmlGetFieldVal(XmlDocument oXML, string sElementSearchPath, string sAttrib, int iRecordNo)
        {

            if (iRecordNo <= 0)
            {
                iRecordNo = 0;
            }

            if (string.IsNullOrEmpty(sElementSearchPath))
            {
                sElementSearchPath = null;
            }

            if (string.IsNullOrEmpty(sAttrib))
            {
                sAttrib = null;
            }

            if (sElementSearchPath == null)
            {
                return "Missing sElement value...";
            }

            //remove root from xpath
            XmlNodeList xlist = oXML.SelectNodes("//*/" + sElementSearchPath);

            //XmlNodeList xlist = oXML.SelectNodes(sElementSearchPath);
          
            if (xlist.Count > 0)
            {
                XmlNode xnode = xlist[iRecordNo];
                if (sAttrib != null)
                {
                    return xnode.Attributes[sAttrib].InnerText;

                }
                return xnode.InnerText;
            }
            return "";
        }

        public string ispXmlSetFieldVal(XmlDocument oXML, string sValue, string sElementSearchPath, string sAttrib, int iRecordNo)
        {

            if (iRecordNo <= 0)
            {
                iRecordNo = 0;
            }

            if (string.IsNullOrEmpty(sElementSearchPath))
            {
                sElementSearchPath = null;
            }

            if (string.IsNullOrEmpty(sAttrib))
            {
                sAttrib = null;
            }

            if (sElementSearchPath == null)
            {
                return "Missing sElement value...";
            }

            XmlNodeList xlist = oXML.SelectNodes("//*/" + sElementSearchPath);

            if (xlist.Count>iRecordNo && xlist.Count > 0)
            {

                XmlNode xnode = xlist[iRecordNo];
                if (sAttrib != null)
                {
                    xnode.Attributes[sAttrib].InnerText = sValue;

                }
                xnode.InnerText = sValue;
            }

            return string.Empty;
        }

        public string ispXmlGetRecordXml(XmlDocument oXML, string sElementSearchPath, int iRecordNo)
        {
            XmlNodeList xlist = oXML.SelectNodes("//*/" + sElementSearchPath);

            if (xlist.Count > 0)
            {
                XmlNode xnode = xlist[iRecordNo];
                return xnode.OuterXml;
            }

            return string.Empty;
        }

        public string ispXmlGetRecCount(XmlDocument oXML, string sElementSearchPath, string sAttrib)
        {

            if (string.IsNullOrEmpty(sElementSearchPath))
            {
                sElementSearchPath = null;
            }

            if (string.IsNullOrEmpty(sAttrib) || sAttrib.ToUpper() != "Y")
            {
                sAttrib = null;
            }

            if (sElementSearchPath == null)
            {
                return "Missing sElement value...";
            }

            XmlNodeList xlist = oXML.SelectNodes("//*/" + sElementSearchPath);

            if (xlist.Count > 0)
            {

                if (sAttrib != null)
                {
                    XmlNode xnode = xlist[0];
                    return xnode.Attributes.Count.ToString();

                }
                return xlist.Count.ToString();
            }
            return "0";
        }

        public string ispXmlAddBlankRecs(XmlDocument oXML, string sElementSearchPath, int iRecNos)
        {

            XmlNodeList xlist = oXML.SelectNodes("//*/" + sElementSearchPath);

            if (xlist.Count > 0)
            {

                XmlNode xnode = xlist[0];
                XmlNode clone = xnode.CloneNode(true);
                XmlNode parent = xnode.ParentNode;

                parent.AppendChild(clone);
            }

            return string.Empty;
        }

        public string ispXmlReplaceNode(
            ref XmlDocument oXmlTo, string sElementToSearchPath, int iRecNoTo, 
            XmlDocument oXmlFrom, string sElementFromSearchPath, int iRecNoFrom)
        {
            XmlNode NewNode = oXmlFrom.GetElementsByTagName(sElementFromSearchPath).Item(iRecNoFrom);
            XmlNode OldNode = oXmlTo.GetElementsByTagName(sElementToSearchPath).Item(iRecNoTo);

            if (NewNode != null && OldNode != null)
            {
                OldNode.ParentNode.ReplaceChild(oXmlTo.ImportNode(NewNode, true), OldNode);
			}
            return string.Empty;
        }

        public string ispAppendNodeXml(
           ref XmlDocument oXmlTo, string sElementToSearchPath, int iRecNoTo,
           XmlDocument oXmlFrom, string sElementFromSearchPath, int iRecNoFrom)
        {

            XmlNode NewNode = null;
            XmlNode OldNode = null;

            NewNode = oXmlFrom.GetElementsByTagName(sElementFromSearchPath).Item(iRecNoFrom);
            OldNode = oXmlTo.GetElementsByTagName(sElementToSearchPath).Item(iRecNoTo);

            if (NewNode != null && OldNode != null)
            {
                XmlNode NodeToBeInserted = oXmlTo.ImportNode(NewNode, true);
                oXmlTo.DocumentElement.AppendChild(NodeToBeInserted);
            }
            return string.Empty;           
        }

    }

}