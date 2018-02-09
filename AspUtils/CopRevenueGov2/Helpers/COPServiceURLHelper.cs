using AspUtils;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace CopRevenueGov2.Helpers
{

    public abstract class COPServiceURLHelper
    {

        private static URLElement [] _Keys = null;

        private static void _RestrictKey(string ConfigKeyName)
        {
            if (_Keys == null)
            {
                throw new Exception("No url key is defined in web.config");
            }

            var key = from obj in _Keys where obj.Name == ConfigKeyName select obj.Name;
            if (key.Count() > 0)
            {
                // allow session key to be inserted into session collection
            }
            else
            {
                throw new Exception("The url key is invalid.");
            }
        }

        public static void Initialize(string ConfigFilePath)
        {
            ConfigManager.Initialize(ConfigFilePath);
            _GetKeyFromWebConfig();
        }

        public static void Initialize()
        {
            //default value for any asp.net app
            Initialize("~/Web.config");
        }

        private static void _GetKeyFromWebConfig()
        {
            URLKey Q = null;

            switch(COPSession.ENVIRONMENT)
            {
                case "D":
                    Q = (URLKey)ConfigManager.GetSection("DCAspWebAdvanceConfigSettings/DevelopmentServiceURLs");
                    break;

                case "S":
                    Q = (URLKey)ConfigManager.GetSection("DCAspWebAdvanceConfigSettings/TestingServiceURLs");
                    break;

                case "P":
                    Q = (URLKey)ConfigManager.GetSection("DCAspWebAdvanceConfigSettings/ProductionServiceURLs");
                    break;

                default:            
                    Q = (URLKey)ConfigManager.GetSection("DCAspWebAdvanceConfigSettings/DevelopmentServiceURLs");
                    break;
            }

            if (Q != null)
            {
                URLKeyCollection c = Q.Key;
                _Keys = c.GetAllKeys();
            }
        }

        public static string GetUrlValueOf(string name)
        {
            string value = (from obj in _Keys where obj.Name == name select obj.Url).Single();
            return value;
        }

        public static string GetConfigNameValueOf(string name)
        {
            string value = (from obj in _Keys where obj.Name == name select obj.ConfigName).Single();
            return value;
        }

        public static RTTIE210_SrvRef.RTTIE210WS_PortTypeClient GetServiceClient_RTTIE010()
        {
            string sname = "RTTIE210";
            string url = GetUrlValueOf(sname);
            string bindername = GetConfigNameValueOf(sname);

             RTTIE210_SrvRef.RTTIE210WS_PortTypeClient newclient =
                 new RTTIE210_SrvRef.RTTIE210WS_PortTypeClient(bindername, url);
             return newclient;
        }
       

        public static RTTIE031_SrvRef.RTTIE231WS_PortTypeClient GetServiceClient_RTTIE031()
        {
            string sname = "RTTIE031";
            string url = GetUrlValueOf(sname);
            string bindername = GetConfigNameValueOf(sname);

            RTTIE031_SrvRef.RTTIE231WS_PortTypeClient newclient =
                new RTTIE031_SrvRef.RTTIE231WS_PortTypeClient(bindername, url);
            return newclient;
        }

        public static RTTIE034_SrvRef.RTTIE234WS_PortTypeClient GetServiceClient_RTTIE034()
        {
            string sname = "RTTIE234";
            string url = GetUrlValueOf(sname);
            string bindername = GetConfigNameValueOf(sname);

            RTTIE034_SrvRef.RTTIE234WS_PortTypeClient newclient =
                new RTTIE034_SrvRef.RTTIE234WS_PortTypeClient(bindername, url);
            return newclient;
        }

        public static RTTIE237_SrvRef.RTTIE237WS_PortTypeClient GetServiceClient_RTTIE037()
        {
            string sname = "RTTIE237";
            string url = GetUrlValueOf(sname);
            string bindername = GetConfigNameValueOf(sname);

            RTTIE237_SrvRef.RTTIE237WS_PortTypeClient newclient =
                new RTTIE237_SrvRef.RTTIE237WS_PortTypeClient(bindername, url);
            return newclient;
        }

        public static RTTIE228_SrvRef.RTTIE228WS_PortTypeClient GetServiceClient_RTTIE228()
        {
            string sname = "RTTIE228";
            string url = GetUrlValueOf(sname);
            string bindername = GetConfigNameValueOf(sname);

            RTTIE228_SrvRef.RTTIE228WS_PortTypeClient newclient =
                new RTTIE228_SrvRef.RTTIE228WS_PortTypeClient(bindername, url);
            return newclient;
        }

        public static RTTIE236_SrvRef.RTTIE236WS_PortTypeClient GetServiceClient_RTTIE236()
        {
            string sname = "RTTIE236";
            string url = GetUrlValueOf(sname);
            string bindername = GetConfigNameValueOf(sname);

            RTTIE236_SrvRef.RTTIE236WS_PortTypeClient newclient =
                new RTTIE236_SrvRef.RTTIE236WS_PortTypeClient(bindername, url);
            return newclient;
        }

        public static RTTIE227_Srvref.RTTIE227WS_PortTypeClient GetServiceClient_RTTIE227()
        {
            string sname = "RTTIE227";
            string url = GetUrlValueOf(sname);
            string bindername = GetConfigNameValueOf(sname);

            RTTIE227_Srvref.RTTIE227WS_PortTypeClient newclient =
                new RTTIE227_Srvref.RTTIE227WS_PortTypeClient(bindername, url);
            return newclient;
        }

        public static RTTIE035_SrvRef.RTTIE235WS_PortTypeClient GetServiceClient_RTTIE035()
        {
            string sname = "RTTIE235";
            string url = GetUrlValueOf(sname);
            string bindername = GetConfigNameValueOf(sname);

            RTTIE035_SrvRef.RTTIE235WS_PortTypeClient newclient =
                new RTTIE035_SrvRef.RTTIE235WS_PortTypeClient(bindername, url);
            return newclient;
        }

        public static RTTIE230_SrvRef.RTTIE230WS_PortTypeClient GetServiceClient_RTTIE230()
        {
            string sname = "RTTIE230";
            string url = GetUrlValueOf(sname);
            string bindername = GetConfigNameValueOf(sname);

            RTTIE230_SrvRef.RTTIE230WS_PortTypeClient newclient =
                new RTTIE230_SrvRef.RTTIE230WS_PortTypeClient(bindername, url);
            return newclient;
        }

        public static RTTIE229_SrvRef.RTTIE229WS_PortTypeClient GetServiceClient_RTTIE229()
        {
            string sname = "RTTIE229";
            string url = GetUrlValueOf(sname);
            string bindername = GetConfigNameValueOf(sname);

            RTTIE229_SrvRef.RTTIE229WS_PortTypeClient newclient =
                new RTTIE229_SrvRef.RTTIE229WS_PortTypeClient(bindername, url);
            return newclient;
        }

        public static RTTIE222_SrvRef.RTTIE222WS_PortTypeClient GetServiceClient_RTTIE222()
        {
            string sname = "RTTIE222";
            string url = GetUrlValueOf(sname);
            string bindername = GetConfigNameValueOf(sname);

            RTTIE222_SrvRef.RTTIE222WS_PortTypeClient newclient =
                new RTTIE222_SrvRef.RTTIE222WS_PortTypeClient(bindername, url);
            return newclient;
        }

        public static RTTIE016_SrvRef.RTTIE216WS_PortTypeClient GetServiceClient_RTTIE016()
        {
            string sname = "RTTIE016";
            string url = GetUrlValueOf(sname);
            string bindername = GetConfigNameValueOf(sname);

            RTTIE016_SrvRef.RTTIE216WS_PortTypeClient newclient =
                new RTTIE016_SrvRef.RTTIE216WS_PortTypeClient(bindername, url);
            return newclient;
        }

        public static RTTIE239_SrvRef.RTTIE239WS_PortTypeClient GetServiceClient_RTTIE239()
        {
            string sname = "RTTIE239";
            string url = GetUrlValueOf(sname);
            string bindername = GetConfigNameValueOf(sname);

            RTTIE239_SrvRef.RTTIE239WS_PortTypeClient newclient =
                new RTTIE239_SrvRef.RTTIE239WS_PortTypeClient(bindername, url);
            return newclient;
        }

    }

    class URLKey : ConfigurationSection
    {
        [ConfigurationProperty("urls")]
        public URLKeyCollection Key
        {
            get
            {
                return (URLKeyCollection)this["urls"];
            }
        }
    }

    //[ConfigurationCollection(typeof(URLElement), AddItemName = "url",
    //    CollectionType = ConfigurationElementCollectionType.BasicMap)]
    //class URLKeyCollection : CustomKeyCollection
    //{
    //    protected override ConfigurationElement CreateNewElement()
    //    {
    //        return new URLElement();
    //    }

    //    protected override object GetElementKey(ConfigurationElement element)
    //    {
    //        return ((URLElement)element).Name;
    //    }
    //}

    public class URLElement : ConfigurationElement
    {
        [ConfigurationProperty("name", DefaultValue = "FFFFFF", IsRequired = true)]
        [StringValidator(InvalidCharacters = "~!@#$%^*()[]{};'\"|\\")]
        public String Name
        {
            get
            {
                return AspUtils.Util.GetString(this["name"]); 
            }
            set
            {
                this["name"] = value;
            }
        }

        [ConfigurationProperty("cname", DefaultValue = "", IsRequired = true)]
        [StringValidator(InvalidCharacters = "~!@#$%^*()[]{};'\"|\\")]
        public String ConfigName
        {
            get
            {
                return AspUtils.Util.GetString(this["cname"]);
            }
            set
            {
                this["cname"] = value;
            }
        }

        [ConfigurationProperty("url", DefaultValue = "", IsRequired = true)]
        [StringValidator(InvalidCharacters = "~!@#$%^*()[]{};'\"|\\")]
        public String Url
        {
            get
            {
                return  AspUtils.Util.GetString(this["url"]);
            }
            set
            {
                this["url"] = value;
            }
        }

    }

    [ConfigurationCollection(typeof(URLElement), AddItemName = "url",
        CollectionType = ConfigurationElementCollectionType.BasicMap)]
    public class URLKeyCollection : ConfigurationElementCollection
    {

        public URLElement this[int index]
        {
            get
            {
                return base.BaseGet(index) as URLElement;
            }
        }

        public URLElement[] GetAllKeys()
        {


            URLElement[] elements = new URLElement[base.Count];

            URLElement[] keys = new URLElement[elements.Length];

            for (int i = 0; elements != null && i < elements.Length; i++)
            {
                URLElement k = (URLElement)base.BaseGet(i);

                keys[i] = new URLElement();
                keys[i].Name =  k.Name;
                keys[i].ConfigName =  k.ConfigName;
                keys[i].Url =  k.Url;
            }
            return keys;
        }

        protected override ConfigurationElement CreateNewElement()
        {
            return new URLElement();
        }

        protected override object GetElementKey(ConfigurationElement element)
        {
            return ((URLElement)element).Name;
        }
    }
}