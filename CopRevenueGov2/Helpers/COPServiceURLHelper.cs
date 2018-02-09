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