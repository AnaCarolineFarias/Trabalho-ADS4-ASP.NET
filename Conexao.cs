using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace PluxxePet_Web.ConexaoBanco
{
    public class Conexao
    {
        private string connectionString;

        public Conexao()
        {
            // Pega a string de conexão do Web.config
            connectionString = ConfigurationManager.ConnectionStrings["PluxeePetDB"].ConnectionString;
        }

        // Retorna uma conexão aberta
        public SqlConnection GetConnection()
        {
            SqlConnection conn = new SqlConnection(connectionString);
            conn.Open();
            return conn;
        }
    }
}