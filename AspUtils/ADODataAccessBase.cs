using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using AspUtils;

namespace AspUtils
{
    public class ADODataAccessBaseUtil
    {

        #region Private variables
        static SqlConnection __DataConnection = null;
        static string __ConnectionString = string.Empty;
        #endregion

        #region Protected properties
        static string ConnectionString
        {
            set
            {
                __ConnectionString = value;
            }
            get
            {
                return __ConnectionString;
            }
        }
        protected static SqlConnection DataConnection
        {
            get
            {
                if (__DataConnection == null)
                {
                    __DataConnection = new SqlConnection(ConnectionString);
                }
                return __DataConnection;
            }
        }
        #endregion

        #region Public methods
        public static void Init(string ConnectionStringName)
        {
            ConnectionString = AppSettingsManager.GetConnectionStringByName(ConnectionStringName);
        }
        #endregion

        #region Protected Methods
        protected static SqlParameter GetParameter(string Name, SqlDbType Type, int Size, ParameterDirection Direction, object Value)
        {
            SqlParameter Parameter = new SqlParameter();
            Parameter.ParameterName = Name;
            Parameter.SqlDbType = Type;
            Parameter.Size = Size;
            Parameter.Direction = Direction;
            Parameter.Value = Value;
            return Parameter;
        }

        protected static SqlParameter GetParameter(string Name, SqlDbType Type, ParameterDirection Direction, object Value)
        {
            SqlParameter Parameter = new SqlParameter();
            Parameter.ParameterName = Name;
            Parameter.SqlDbType = Type;
            Parameter.Direction = Direction;
            Parameter.Value = Value;
            return Parameter;
        }

        protected static SqlParameter GetParameter(string Name, SqlDbType Type, ParameterDirection Direction)
        {
            SqlParameter Parameter = new SqlParameter();
            Parameter.ParameterName = Name;
            Parameter.SqlDbType = Type;
            Parameter.Direction = Direction;
            return Parameter;
        }

        protected static SqlParameter GetParameter(string Name, SqlDbType Type, int Size, object Value)
        {
            SqlParameter Parameter = new SqlParameter();
            Parameter.ParameterName = Name;
            Parameter.SqlDbType = Type;
            Parameter.Size = Size;
            Parameter.Value = Value;
            return Parameter;
        }

        protected static SqlParameter GetParameter(string Name, SqlDbType Type, object Value)
        {
            SqlParameter Parameter = new SqlParameter();
            Parameter.ParameterName = Name;
            Parameter.SqlDbType = Type;
            Parameter.Value = Value;
            return Parameter;
        }

        protected static SqlParameter GetParameter(string Name, object Value)
        {
            SqlParameter Parameter = new SqlParameter();
            Parameter.ParameterName = Name;
            Parameter.Value = Value;
            return Parameter;
        }

        protected static int ExecuteSPNonQuery(string SpName, SqlParameter[] parameters)
        {
            int result = 0;
            OpenConnection();
            using (SqlCommand com = new SqlCommand())
            {
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = SpName;
                for (int i = 0; i < parameters.Length; i++)
                {
                    com.Parameters.Add(parameters[i]);
                }
                com.Connection = DataConnection;
                result = com.ExecuteNonQuery();


            }
            return result;
        }

        protected static DataSet ExecuteSPQuery(string SpName, SqlParameter[] parameters)
        {
            OpenConnection();
            DataSet dset = new DataSet();
            using (SqlCommand com = new SqlCommand())
            {
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = SpName;
                for (int i = 0; i < parameters.Length; i++)
                {
                    com.Parameters.Add(parameters[i]);
                }
                com.Connection = DataConnection;

                using (SqlDataAdapter da = new SqlDataAdapter(com))
                {
                    da.Fill(dset);
                }
            }
            return dset;
        }

        protected static DataSet ExecuteSPQuery(string SpName)
        {
            OpenConnection();
            DataSet dset = new DataSet();
            using (SqlCommand com = new SqlCommand())
            {
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = SpName;
                com.Connection = DataConnection;

                using (SqlDataAdapter da = new SqlDataAdapter(com))
                {
                    da.Fill(dset);
                }
            }
            return dset;
        }

        protected static void OpenConnection()
        {
            if (DataConnection.State == ConnectionState.Closed)
            {
                DataConnection.Open();
            }
        }

        protected static void CloseConnection()
        {
            if (DataConnection.State == ConnectionState.Open || DataConnection.State == ConnectionState.Broken)
            {
                DataConnection.Close();
            }
        }
        #endregion

    }
}