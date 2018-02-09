using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Configuration;

namespace AspUtils
{
    public abstract class AppSettingsManager
    {
        private static KeyValueConfigurationCollection _Keys = null;
        private static ConnectionStringSettingsCollection _Conns = null;

        public static void Initialize(string ConfigFilePath)
        {
            ConfigManager.Initialize(ConfigFilePath);
            _GetKeyFromWebConfig();
            _GetConnectrionStringsFromWebConfig();
        }

        public static void Initialize()
        {
            //default value for any asp.net app
            Initialize("~/Web.config");
        }

        private static void _GetKeyFromWebConfig()
        {
            AppSettingsSection Q = ConfigManager.GetAppSettingsSection();
            if (Q != null)
            {
                _Keys = Q.Settings;                
            }
        }

        private static void _GetConnectrionStringsFromWebConfig()
        {
            ConnectionStringsSection Q = ConfigManager.GetConnectrionStringsSection();
            if (Q != null)
            {
                _Conns = Q.ConnectionStrings;
            }
        }

        public static string GetKeyValueOf(string ConfigKeyName)
        {
            return Util.GetString(_Keys[ConfigKeyName].Value);
        }

        public static string GetConnectionStringByName(string Name)
        {
            return Util.GetString(_Conns[Name].ConnectionString);
        }
    }
}
