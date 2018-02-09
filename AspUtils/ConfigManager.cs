using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Configuration;

namespace AspUtils
{
    public class ConfigManager
    {
        private static ConfigManager _threadsafe = new ConfigManager();
        static Configuration _config = null;

        private static Configuration _OpenConfigFile(string VirtualConfigPath)
        {
            lock (_threadsafe)
            {
                WebConfigurationFileMap webConfigFileMap = new WebConfigurationFileMap();
                Configuration config = null; 
                config = WebConfigurationManager.OpenWebConfiguration(VirtualConfigPath);
                return config;
            }
        }

        public static object GetSection(string SectionPath)
        {
            lock (_threadsafe)
            {
                object ConfigSection = _config.GetSection(SectionPath);
                return ConfigSection;
            }
        }

        public static AppSettingsSection GetAppSettingsSection()
        {
            lock (_threadsafe)
            {
                return _config.AppSettings;
            }
        }

        public static ConnectionStringsSection GetConnectrionStringsSection()
        {
            lock (_threadsafe)
            {
                return _config.ConnectionStrings;
            }
        }

        public static void Initialize(string ConfigFilePath)
        {
            _config = _OpenConfigFile(ConfigFilePath);
        }

        public static void Initialize()
        {
            _config = _OpenConfigFile(null);
        }
    }

    public class CustomKeyCollection : ConfigurationElementCollection
    {

        public KeyElement this[int index]
        {
            get
            {
                return base.BaseGet(index) as KeyElement;
            }
        }

        public KeyValuePair<string, string>[] GetAllKeys1()
        {


            KeyElement[] elements = new KeyElement[base.Count];

            KeyValuePair<string, string>[] keys = new KeyValuePair<string, string>[elements.Length];

            for (int i = 0; elements != null && i < elements.Length; i++)
            {
                KeyElement k = (KeyElement)base.BaseGet(i);

                keys[i] = new KeyValuePair<string, string>(k.Name, k.Value);
            }
            return keys;
        }

        public Dictionary<string, string> GetAllKeys2()
        {

            KeyElement[] elements = new KeyElement[base.Count];

            Dictionary<string, string> keys = new Dictionary<string, string>(elements.Length);

            for (int i = 0; elements != null && i < elements.Length; i++)
            {
                KeyElement k = (KeyElement)base.BaseGet(i);

                keys.Add(k.Name, k.Value);
            }
            return keys;
        }

        protected override ConfigurationElement CreateNewElement()
        {
            throw new NotImplementedException();
        }

        protected override object GetElementKey(ConfigurationElement element)
        {
            throw new NotImplementedException();
        }
    }

    public class KeyElement : ConfigurationElement
    {
        [ConfigurationProperty("name", DefaultValue = "", IsRequired = true)]
        //[StringValidator(InvalidCharacters = "~!@#$%^&*()[]{}/;'\"|\\", MinLength = 1, MaxLength = 26)]
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

        [ConfigurationProperty("value", DefaultValue = "", IsRequired = false)]
        //[StringValidator(InvalidCharacters = "~!@#$%^&*()[]{}/;'\"|\\", MinLength = 1, MaxLength = 26)]
        public String Value
        {
            get
            {
                return AspUtils.Util.GetString(this["value"]);
            }
            set
            {
                this["value"] = value;
            }
        }
    }
}
