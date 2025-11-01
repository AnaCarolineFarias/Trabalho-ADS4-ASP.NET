using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Net;
using System.Net.Mail;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

namespace PluxeePetADS4.Cliente
{
    public partial class Cliente : System.Web.UI.Page
    {

        private readonly string connectionString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=PluxeePet;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!ClientScript.IsClientScriptBlockRegistered(this.GetType(), "__PostBackHack"))
            {
                ClientScript.GetPostBackEventReference(this, "");
            }

            if (!IsPostBack)
            {

                if (Session["ClienteId"] == null)
                {
                    OcultarConteudo();
                    pnlLogin.Visible = true;
                }
                else
                {

                    OcultarConteudo();
                    pnlOpcoes.Visible = true;
                }
            }
        }

        private void OcultarConteudo()
        {
            pnlLogin.Visible = false;
            pnlOpcoes.Visible = false;
            pnlAgendamento.Visible = false;
            pnlConsultas.Visible = false;
            pnlEditarPerfil.Visible = false;
        }

        private void MostrarMensagem(string texto, System.Drawing.Color cor)
        {
            lblMensagem.Text = texto;
            lblMensagem.ForeColor = cor;
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string usuario = txtUsuario.Text.Trim();
            string senha = txtSenha.Text.Trim();

            if (string.IsNullOrEmpty(usuario) || string.IsNullOrEmpty(senha))
            {
                MostrarMensagem("Preencha usuário e senha!", System.Drawing.Color.Red);
                pnlLogin.Visible = true; // Mantém o login visível
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    const string query = @"SELECT IdCliente, Nome FROM Clientes WHERE Usuario = @usuario AND Senha = @senha";

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

                                OcultarConteudo();
                                pnlOpcoes.Visible = true;
                                MostrarMensagem($"Bem-vindo(a), {nome}! Escolha uma opção.", System.Drawing.Color.Green);
                            }
                            else
                            {
                                MostrarMensagem("Usuário ou senha incorretos!", System.Drawing.Color.Red);
                                pnlLogin.Visible = true;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MostrarMensagem("Erro ao conectar ao banco: " + ex.Message, System.Drawing.Color.Red);
                pnlLogin.Visible = true;
            }
        }

        protected void btnCriarConta_Click(object sender, EventArgs e)
        {
            string usuario = txtUsuario.Text.Trim();
            string senha = txtSenha.Text; 
            string nome = usuario;

            if (string.IsNullOrEmpty(nome) || string.IsNullOrEmpty(usuario) || string.IsNullOrEmpty(senha))
            {
                MostrarMensagem("Por favor, preencha todos os campos para criar a conta.", Color.Red);
                return;
            }

            string connectionString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=PluxeePet;Integrated Security=True";
            string senhaParaBD = senha;
            string query = "INSERT INTO Clientes (Nome, Usuario, Senha) VALUES (@Nome, @Usuario, @Senha)";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    cmd.Parameters.AddWithValue("@Nome", nome);
                    cmd.Parameters.AddWithValue("@Usuario", usuario);
                    cmd.Parameters.AddWithValue("@Senha", senhaParaBD);

                    try
                    {
                        connection.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            txtUsuario.Text = "";
                            txtSenha.Text = "";

                            MostrarMensagem("Conta criada com sucesso! Faça login agora.", Color.Green);
                        }
                        else
                        {
                            MostrarMensagem("Erro ao criar a conta. Tente novamente.", Color.Red);
                        }
                    }
                    catch (SqlException ex)
                    {
       
                        if (ex.Number == 2627)
                        {
                            MostrarMensagem("Este Usuário já está cadastrado. Tente outro.", Color.Red);
                        }
                        else
                        {
                            MostrarMensagem($"Erro no banco de dados: {ex.Message}", Color.Red);
                        }
                    }
                    catch (Exception ex)
                    {
                        MostrarMensagem($"Erro inesperado: {ex.Message}", Color.Red);
                    }
                }
            }
        }
       

        protected void btnAgendarServico_Click(object sender, EventArgs e)
        {
            OcultarConteudo();
            pnlAgendamento.Visible = true;
            lblMensagem.Text = "Preencha o formulário de agendamento.";
        }

        protected void btnEditarPerfil_Click(object sender, EventArgs e)
        {
            OcultarConteudo();
            pnlEditarPerfil.Visible = true;
            MostrarMensagem("Atualize seus dados cadastrais.", System.Drawing.Color.Blue);
            CarregarDadosCliente();
        }

        private void CarregarDadosCliente()
        {
            if (Session["ClienteId"] == null)
            {
                MostrarMensagem("Sessão expirada. Faça login novamente.", System.Drawing.Color.Red);
                return;
            }

            int clienteId = (int)Session["ClienteId"];

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    const string query = "SELECT Nome, Email, Telefone, Endereco, Idade FROM Clientes WHERE IdCliente = @IdCliente";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@IdCliente", clienteId);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {

                                txtNomePerfil.Text = reader["Nome"] != DBNull.Value ? reader["Nome"].ToString() : "";
                                txtEmailPerfil.Text = reader["Email"] != DBNull.Value ? reader["Email"].ToString() : "";
                                txtTelefonePerfil.Text = reader["Telefone"] != DBNull.Value ? reader["Telefone"].ToString() : "";
                                txtEnderecoPerfil.Text = reader["Endereco"] != DBNull.Value ? reader["Endereco"].ToString() : "";
                                txtIdadePerfil.Text = reader["Idade"] != DBNull.Value ? reader["Idade"].ToString() : "";

                                lblFeedbackPerfil.Text = "Dados carregados. Você pode editar e salvar.";
                                lblFeedbackPerfil.ForeColor = System.Drawing.Color.Blue;
                            }
                            else
                            {
                                lblFeedbackPerfil.Text = "Erro: Dados do cliente não encontrados.";
                                lblFeedbackPerfil.ForeColor = System.Drawing.Color.Red;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblFeedbackPerfil.Text = "Erro ao carregar dados: " + ex.Message;
                lblFeedbackPerfil.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnSalvarPerfil_Click(object sender, EventArgs e)
        {
            if (Session["ClienteId"] == null)
            {
                lblFeedbackPerfil.Text = "Sessão expirada. Faça login novamente.";
                lblFeedbackPerfil.ForeColor = System.Drawing.Color.Red;
                return;
            }

            int idade = 0;
            bool isIdadeValid = int.TryParse(txtIdadePerfil.Text.Trim(), out idade);

            int clienteId = (int)Session["ClienteId"];
            string nome = txtNomePerfil.Text.Trim();
            string email = txtEmailPerfil.Text.Trim();
            string telefone = txtTelefonePerfil.Text.Trim();
            string endereco = txtEnderecoPerfil.Text.Trim();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    const string query = @"UPDATE Clientes 
                                   SET Nome = @Nome, Email = @Email, Telefone = @Telefone, Endereco = @Endereco, Idade = @Idade
                                   WHERE IdCliente = @IdCliente";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Nome", nome);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Telefone", telefone);
                        cmd.Parameters.AddWithValue("@Endereco", endereco);
                        cmd.Parameters.AddWithValue("@IdCliente", clienteId);
                        cmd.Parameters.AddWithValue("@Idade", isIdadeValid && idade > 0 ? (object)idade : DBNull.Value);

                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            lblFeedbackPerfil.Text = "Perfil atualizado com sucesso!";
                            lblFeedbackPerfil.ForeColor = System.Drawing.Color.Green;
                        }
                        else
                        {
                            lblFeedbackPerfil.Text = "Nenhuma alteração foi salva (verifique se os dados são iguais).";
                            lblFeedbackPerfil.ForeColor = System.Drawing.Color.Orange;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblFeedbackPerfil.Text = "Erro ao salvar: " + ex.Message;
                lblFeedbackPerfil.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnVerificarConsultas_Click(object sender, EventArgs e)
        {
            OcultarConteudo();
            pnlOpcoes.Visible = true;
            pnlConsultas.Visible = true;
            CarregarConsultasCliente();
        }


        private void CarregarConsultasCliente()
        {
            if (Session["ClienteId"] == null)
            {
                MostrarMensagem("Faça login para ver suas consultas!", System.Drawing.Color.Red);
                return;
            }

            int clienteId = (int)Session["ClienteId"];
            DataTable dt = new DataTable();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    const string query = @"SELECT NomePet, Data, Hora FROM Consultas WHERE IdCliente = @idCliente ORDER BY Data DESC, Hora DESC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@idCliente", clienteId);
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        da.Fill(dt);
                    }
                }

                if (dt.Rows.Count > 0)
                {
                    string htmlTable = "<table class='table table-bordered table-striped'><thead><tr><th>Pet</th><th>Data</th><th>Hora</th></tr></thead><tbody>";
                    foreach (DataRow row in dt.Rows)
                    {
                        htmlTable += $"<tr><td>{row["NomePet"]}</td><td>{Convert.ToDateTime(row["Data"]).ToShortDateString()}</td><td>{row["Hora"]}</td></tr>";
                    }
                    htmlTable += "</tbody></table>";

                    lblListaConsultas.Text = htmlTable;
                    MostrarMensagem($"Você tem {dt.Rows.Count} consultas agendadas.", System.Drawing.Color.Blue);
                }
                else
                {
                    lblListaConsultas.Text = "<p>Você não tem consultas agendadas.</p>";
                    MostrarMensagem("Nenhuma consulta encontrada.", System.Drawing.Color.Orange);
                }
            }
            catch (Exception ex)
            {
                lblListaConsultas.Text = $"<p class='text-danger'>Erro ao carregar consultas: {ex.Message}</p>";
            }
        }

        protected void btnAgendar_Click(object sender, EventArgs e)
        {
            // 1. Verificar Sessão e Coletar Dados
            if (Session["ClienteId"] == null)
            {
                MostrarMensagem("Sessão expirada. Faça login novamente.", Color.Red);
                OcultarConteudo();
                pnlLogin.Visible = true;
                return;
            }

            int clienteId = (int)Session["ClienteId"];
            string servico = ddlServico.SelectedValue;
            string nomePet = txtPet.Text.Trim();
            string data = txtData.Text.Trim();
            string hora = txtHora.Text.Trim();

            if (string.IsNullOrEmpty(servico) || string.IsNullOrEmpty(nomePet) || string.IsNullOrEmpty(data) || string.IsNullOrEmpty(hora))
            {
                MostrarMensagem("Por favor, preencha todos os campos do agendamento.", Color.Red);
                pnlAgendamento.Visible = true;
                return;
            }

            const string query = "INSERT INTO Consultas (IdCliente, Servico, NomePet, Data, Hora) VALUES (@IdCliente, @Servico, @NomePet, @Data, @Hora)";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                  
                    cmd.Parameters.AddWithValue("@IdCliente", clienteId);
                    cmd.Parameters.AddWithValue("@Servico", servico);
                    cmd.Parameters.AddWithValue("@NomePet", nomePet);
                    cmd.Parameters.AddWithValue("@Data", data); // Usando a string de data (assumindo formato válido)
                    cmd.Parameters.AddWithValue("@Hora", hora);

                    try
                    {
                        connection.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            // Limpar e retornar para o menu de opções
                            MostrarMensagem($"Consulta de {nomePet} para {servico} agendada com sucesso!", Color.Green);
                            OcultarConteudo();
                            pnlOpcoes.Visible = true;

                            // Opcional: Limpar os campos do formulário após o sucesso
                            txtPet.Text = "";
                            txtData.Text = "";
                            txtHora.Text = "";
                            ddlServico.SelectedIndex = 0;
                        }
                        else
                        {
                            MostrarMensagem("Erro ao agendar a consulta. Tente novamente.", Color.Red);
                            pnlAgendamento.Visible = true;
                        }
                    }
                    catch (Exception ex)
                    {
                        MostrarMensagem($"Erro ao agendar no banco de dados: {ex.Message}", Color.Red);
                        pnlAgendamento.Visible = true;
                    }
                }
            }
        }

        protected void btnVoltar_Click(object sender, EventArgs e)
        {
            OcultarConteudo();
            pnlOpcoes.Visible = true;
            MostrarMensagem("Selecione uma opção.", System.Drawing.Color.Blue);
        }

        protected void btnSair_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();

            OcultarConteudo();
            pnlLogin.Visible = true;
            MostrarMensagem("Você saiu do sistema com sucesso.", System.Drawing.Color.Blue);
        }
    }
}
