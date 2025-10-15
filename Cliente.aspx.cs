using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace PluxeePetADS4
{
    public partial class Cliente : System.Web.UI.Page
    {
        // String de conexão: ajuste Data Source e Initial Catalog
        private string connectionString = @"Data Source=SEU_SERVIDOR;Initial Catalog=SeuBanco;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                agendamentoDiv.Visible = false; // Esconder agendamento inicialmente
            }
        }

        // LOGIN
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string usuario = txtUsuario.Text.Trim();
            string senha = txtSenha.Text.Trim();

            if (string.IsNullOrEmpty(usuario) || string.IsNullOrEmpty(senha))
            {
                lblMensagem.Text = "Preencha usuário e senha!";
                lblMensagem.ForeColor = System.Drawing.Color.Red;
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string query = "SELECT IdCliente, Nome FROM Clientes WHERE Usuario = @usuario AND Senha = @senha";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@usuario", usuario);
                        cmd.Parameters.AddWithValue("@senha", senha);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                string nome = reader["Nome"].ToString();
                                Session["ClienteId"] = reader["IdCliente"];
                                Session["ClienteNome"] = nome;

                                lblMensagem.Text = $"Bem-vindo, {nome}!";
                                lblMensagem.ForeColor = System.Drawing.Color.Green;

                                loginDiv.Visible = false;
                                agendamentoDiv.Visible = true;
                            }
                            else
                            {
                                lblMensagem.Text = "Usuário ou senha incorretos!";
                                lblMensagem.ForeColor = System.Drawing.Color.Red;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMensagem.Text = "Erro ao conectar ao banco: " + ex.Message;
                lblMensagem.ForeColor = System.Drawing.Color.Red;
            }
        }

        // CRIAR CONTA
        protected void btnCriarConta_Click(object sender, EventArgs e)
        {
            string usuario = txtUsuario.Text.Trim();
            string senha = txtSenha.Text.Trim();

            if (string.IsNullOrEmpty(usuario) || string.IsNullOrEmpty(senha))
            {
                lblMensagem.Text = "Preencha usuário e senha para criar conta!";
                lblMensagem.ForeColor = System.Drawing.Color.Red;
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Verificar se já existe usuário
                    string checkQuery = "SELECT COUNT(*) FROM Clientes WHERE Usuario = @usuario";
                    using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@usuario", usuario);
                        int exists = (int)checkCmd.ExecuteScalar();
                        if (exists > 0)
                        {
                            lblMensagem.Text = "Este usuário já existe!";
                            lblMensagem.ForeColor = System.Drawing.Color.Red;
                            return;
                        }
                    }

                    // Inserir novo usuário
                    string insertQuery = "INSERT INTO Clientes (Usuario, Senha) VALUES (@usuario, @senha)";
                    using (SqlCommand insertCmd = new SqlCommand(insertQuery, conn))
                    {
                        insertCmd.Parameters.AddWithValue("@usuario", usuario);
                        insertCmd.Parameters.AddWithValue("@senha", senha);

                        int rows = insertCmd.ExecuteNonQuery();
                        if (rows > 0)
                        {
                            lblMensagem.Text = "Conta criada com sucesso! Faça login.";
                            lblMensagem.ForeColor = System.Drawing.Color.Green;
                        }
                        else
                        {
                            lblMensagem.Text = "Erro ao criar conta.";
                            lblMensagem.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMensagem.Text = "Erro ao conectar ao banco: " + ex.Message;
                lblMensagem.ForeColor = System.Drawing.Color.Red;
            }
        }

        // AGENDAR CONSULTA
        protected void btnAgendar_Click(object sender, EventArgs e)
        {
            if (Session["ClienteId"] == null)
            {
                lblMensagem.Text = "Faça login antes de agendar!";
                lblMensagem.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string nomePet = txtPet.Text.Trim();
            string data = txtData.Text.Trim();
            string hora = txtHora.Text.Trim();

            if (string.IsNullOrEmpty(nomePet) || string.IsNullOrEmpty(data) || string.IsNullOrEmpty(hora))
            {
                lblMensagem.Text = "Preencha todos os campos do agendamento!";
                lblMensagem.ForeColor = System.Drawing.Color.Red;
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string insertQuery = "INSERT INTO Consultas (IdCliente, NomePet, Data, Hora) VALUES (@idCliente, @nomePet, @data, @hora)";
                    using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@idCliente", Session["ClienteId"]);
                        cmd.Parameters.AddWithValue("@nomePet", nomePet);
                        cmd.Parameters.AddWithValue("@data", data);
                        cmd.Parameters.AddWithValue("@hora", hora);

                        int rows = cmd.ExecuteNonQuery();
                        if (rows > 0)
                        {
                            lblMensagem.Text = $"Consulta do pet {nomePet} agendada para {data} às {hora}!";
                            lblMensagem.ForeColor = System.Drawing.Color.Green;
                            txtPet.Text = "";
                            txtData.Text = "";
                            txtHora.Text = "";
                        }
                        else
                        {
                            lblMensagem.Text = "Erro ao agendar consulta.";
                            lblMensagem.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMensagem.Text = "Erro ao conectar ao banco: " + ex.Message;
                lblMensagem.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}
