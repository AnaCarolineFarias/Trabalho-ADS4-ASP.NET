using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace PluxeePetADS4
{
    public class Conexao
    {
        private SqlConnection con;

        // Construtor - define a string de conexão
        public Conexao()
        {
            // Caminho para o seu LocalDB
            string connectionString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=PluxeePetDB;Integrated Security=True";
            con = new SqlConnection(connectionString);
        }

        // Abrir conexão
        public SqlConnection AbrirConexao()
        {
            if (con.State == System.Data.ConnectionState.Closed)
                con.Open();
            return con;
        }

        // Fechar conexão
        public void FecharConexao()
        {
            if (con.State == System.Data.ConnectionState.Open)
                con.Close();
        }
    }
}
