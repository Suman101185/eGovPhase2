using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Collections.Specialized;
using System.Web;
using System.Configuration;
using System.Web.Configuration;

namespace AspUtils
{
    public abstract class QueryStringManager
    {
        private static KeyValuePair<string, string> [] _Keys = null;

        private static bool _IsQueryStringExists(string url)
        {
            if (url.IndexOf("?") <= 0)
            {
                return false;
            }
            return true;
        }

        private static void _RestrictKey(string ConfigKeyName)
        {
            if (_Keys == null)
            {
                throw new Exception("No querystring key is defined in web.config");
            }

            var key = from obj in _Keys where obj.Key == ConfigKeyName select obj.Key;
            if (key.Count() > 0)
            {
                // allow query string key to be inserted into url
            }
            else
            {
                throw new Exception("The query string key is invalid.");
            }
        }

        public static string AppendQueryStringValue(string Value, string Name, string url)
        {
            _RestrictKey(Name);

            if (!_IsQueryStringExists(url))
            {
                url = url + "?" + Name + "=" + Value;
            }
            else
            {
                url = url + "&" + Name + "=" + Value;
            }

            //url = HttpUtility.UrlEncode(url);

            return url;
        }

        public static string AppendQueryStringValue(string[] Value, string Name,string Separator,  string url )
        {
            _RestrictKey(Name);

            if (!_IsQueryStringExists(url))
            {
                url = url + "?" + Name + "=" ;
            }
            else
            {
                url = url + "&" + Name + "=";
            }


            for (int i = 0; Value != null && i < Value.Length; i++)
            {
                url += Value[i];

                if (i < Value.Length - 1)
                {
                    url += Separator;
                }
            }
            //HttpUtility.UrlEncode(url);
            return url;

        }

        public static string GetString(string Name, NameValueCollection QueryString)
        {
            string val = Util.GetString(QueryString[Name]);

            return val;
        }

        public static string GetString(string Name)
        {
            string val = Util.GetString(HttpContext.Current.Request.QueryString[Name]);

            return val;
        }

        public static int GetInt(string Name, NameValueCollection QueryString)
        {
            return Util.GetInt(GetString(Name, QueryString));
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
            QueryStringKey Q = (QueryStringKey)ConfigManager.GetSection("DCAspWebAdvanceConfigSettings/QueryStringKeys");
            if (Q != null)
            {
                QueryStringKeyCollection c = Q.Key;
                _Keys = c.GetAllKeys1();
            }
        }

        public static string GetKeyValueOf(string ConfigKeyName)
        {
            string value = (from obj in _Keys where obj.Key == ConfigKeyName select obj.Value).Single();
            return value;
        }
    }

    class QueryStringKey : ConfigurationSection
    {
        [ConfigurationProperty("keys")]
        public QueryStringKeyCollection Key
        {
            get
            {
                return (QueryStringKeyCollection)this["keys"];
            }
            set
            {
                this["keys"] = value;
            }
        }
    }

    [ConfigurationCollection(typeof(KeyElement), AddItemName = "key",
        CollectionType = ConfigurationElementCollectionType.BasicMap)]
    class QueryStringKeyCollection : CustomKeyCollection
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




