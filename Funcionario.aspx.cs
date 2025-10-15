using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PluxeePetADS4.Funcionario
{
    public partial class Funcionario : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string usuario = txtUsuario.Text.Trim();
            string senha = txtSenha.Text.Trim();

            if (string.IsNullOrEmpty(usuario) || string.IsNullOrEmpty(senha))
            {
                lblMensagem.Text = "Por favor, preencha usuário e senha.";
                return;
            }

            // String de conexão: ajuste o Data Source, Initial Catalog e autenticação
            string connectionString = @"Data Source=SEU_SERVIDOR;Initial Catalog=SeuBanco;Integrated Security=True";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    string query = "SELECT COUNT(*) FROM Funcionarios WHERE Usuario = @usuario AND Senha = @senha";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@usuario", usuario);
                        cmd.Parameters.AddWithValue("@senha", senha);

                        int resultado = (int)cmd.ExecuteScalar();

                        if (resultado > 0)
                        {
                            lblMensagem.ForeColor = System.Drawing.Color.Green;
                            lblMensagem.Text = "Login efetuado com sucesso!";

                            // Redirecionar para a área do funcionário
                            Response.Redirect("~/Funcionario/Home.aspx");
                        }
                        else
                        {
                            lblMensagem.ForeColor = System.Drawing.Color.Red;
                            lblMensagem.Text = "Usuário ou senha incorretos!";
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblMensagem.ForeColor = System.Drawing.Color.Red;
                    lblMensagem.Text = "Erro ao conectar ao banco de dados: " + ex.Message;
                }
            }
        }
    }
}
