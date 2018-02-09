using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace AspUtils
{
    public abstract class SessionManager
    {
        private static KeyValuePair<string, string>[] _Keys = null;

        private static void _RestrictKey(string ConfigKeyName)
        {
            if(_Keys == null)
            {
                throw new Exception("No session key is defined in web.config");
            }

            var key = from obj in _Keys where obj.Key == ConfigKeyName select obj.Key;
            if (key.Count() > 0)
            {
                // allow session key to be inserted into session collection
            }
            else
            {
                throw new Exception("The session key is invalid.");
            }
        }

        public static object GetObject(string Name)
        {
            return HttpContext.Current.Session[Name];
        }

        public static string GetString(string Name)
        {
            return Util.GetString(GetObject(Name));
        }

        public static int GetInt(string Name)
        {
            return Util.GetInt(GetObject(Name));
        }

        public static bool GetBool(string Name)
        {
            return Util.GetBool(GetObject(Name));
        }

        public static bool Set(object value, string Name)
        {
            _RestrictKey(Name);

            try
            {
                HttpContext.Current.Session[Name] = value;
                return true;
            }
            catch
            {
                return false;
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
            SessionKey Q = (SessionKey)ConfigManager.GetSection("DCAspWebAdvanceConfigSettings/SessionKeys");
            if (Q != null)
            {
                SessionKeyCollection c = Q.Key;
                _Keys = c.GetAllKeys1();
            }
        }

        public static string GetKeyValueOf(string ConfigKeyName)
        {
            string value = (from obj in _Keys where obj.Key == ConfigKeyName select obj.Value).Single();
            return value;
        }

        public static bool ClearAll()
        {
            try
            {
                HttpContext.Current.Session.RemoveAll();
                return true;
            }
            catch
            {
                return false;
            }
        }

    }

    class SessionKey : ConfigurationSection
    {
        [ConfigurationProperty("keys")]
        public SessionKeyCollection Key
        {
            get
            {
                return (SessionKeyCollection)this["keys"];
            }
            set
            {
                this["keys"] = value;
            }
        }
    }

    [ConfigurationCollection(typeof(KeyElement), AddItemName = "key",
        CollectionType = ConfigurationElementCollectionType.BasicMap)]
    class SessionKeyCollection : CustomKeyCollection
    {
        protected override ConfigurationElement CreateNewElement()
        {
            return new KeyElement();
        }

        protected override object GetElementKey(ConfigurationElement element)
        {
            return ((KeyElement)element).Name;
        }
    }
}
