using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PluxeePetADS4.Funcionario
{
    public partial class LoginFuncionario : System.Web.UI.Page
    {
        private readonly string connectionString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=PluxeePet;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["FuncionarioId"] == null)
                {
                    OcultarTodosConteudos();
                    pnlLoginFuncionario.Visible = true;
                }
                else
                {
                    // Se já estiver logado, vai para as opções do funcionário
                    OcultarTodosConteudos();
                    pnlOpcoesFuncionario.Visible = true;
                    string nome = Session["FuncionarioNome"] as string;
                    if (!string.IsNullOrEmpty(nome))
                    {
                        lblMensagemFuncionarioBoasVindas.Text = $"Bem-vindo(a), {nome}! Escolha uma opção:";
                    }
                }
            }
        }

        private void OcultarTodosConteudos()
        {
            pnlLoginFuncionario.Visible = false;
            pnlOpcoesFuncionario.Visible = false;
            pnlAgenda.Visible = false;
            pnlCadastroCliente.Visible = false;
            lblMensagem.Text = ""; // Limpa a mensagem geral ao trocar de painel
            lblMensagemCadastroCliente.Text = ""; // Limpa a mensagem de cadastro
        }

        private void MostrarMensagem(string texto, System.Drawing.Color cor)
        {
            lblMensagem.Text = texto;
            lblMensagem.ForeColor = cor;
        }

        protected void btnEntrar_Click(object sender, EventArgs e)
        {
            string idFuncionario = txtFuncionarioId.Text.Trim();
            string senha = txtSenha.Text.Trim();

            if (string.IsNullOrEmpty(idFuncionario) || string.IsNullOrEmpty(senha))
            {
                MostrarMensagem("Preencha ID e senha!", System.Drawing.Color.Red);
                pnlLoginFuncionario.Visible = true;
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    const string query = @"SELECT IdFuncionario, Nome FROM Funcionarios WHERE IdFuncionario = @id AND Senha = @senha";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@id", idFuncionario);
                        cmd.Parameters.AddWithValue("@senha", senha);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                int id = reader.GetInt32(0);
                                string nome = reader.GetString(1);

                                Session["FuncionarioId"] = id;
                                Session["FuncionarioNome"] = nome;

                                OcultarTodosConteudos();
                                pnlOpcoesFuncionario.Visible = true;
                                lblMensagemFuncionarioBoasVindas.Text = $"Bem-vindo(a), {nome}! Escolha uma opção:";
                                MostrarMensagem("Login efetuado com sucesso!", System.Drawing.Color.Green);
                            }
                            else
                            {
                                MostrarMensagem("ID ou senha incorretos!", System.Drawing.Color.Red);
                                pnlLoginFuncionario.Visible = true;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MostrarMensagem("Erro ao conectar ou autenticar: " + ex.Message, System.Drawing.Color.Red);
                pnlLoginFuncionario.Visible = true;
            }
        }

        protected void btnGerenciarAgenda_Click(object sender, EventArgs e)
        {
            if (Session["FuncionarioId"] == null)
            {
                MostrarMensagem("Sessão expirada. Faça login novamente.", System.Drawing.Color.Red);
                OcultarTodosConteudos();
                pnlLoginFuncionario.Visible = true;
                return;
            }
            OcultarTodosConteudos();
            pnlAgenda.Visible = true;
            CarregarAgenda();
        }

        private void CarregarAgenda()
        {
            DataTable dt = new DataTable();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    const string query = @"
                        SELECT 
                            C.IdConsulta, 
                            CL.Nome AS NomeCliente, 
                            C.Servico, 
                            C.NomePet, 
                            C.Data, 
                            C.Hora 
                        FROM Consultas C
                        INNER JOIN Clientes CL ON C.IdCliente = CL.IdCliente
                        ORDER BY C.Data ASC, C.Hora ASC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        da.Fill(dt);
                    }
                }

                if (dt.Rows.Count > 0)
                {
                    string htmlTable = @"
                        <table class='table table-bordered table-striped'>
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Cliente</th>
                                    <th>Serviço</th>
                                    <th>Pet</th>
                                    <th>Data</th>
                                    <th>Hora</th>
                                </tr>
                            </thead>
                            <tbody>";

                    foreach (DataRow row in dt.Rows)
                    {
                        string dataFormatada = Convert.ToDateTime(row["Data"]).ToShortDateString();

                        htmlTable += $@"
                            <tr>
                                <td>{row["IdConsulta"]}</td>
                                <td>{row["NomeCliente"]}</td>
                                <td>{row["Servico"]}</td>
                                <td>{row["NomePet"]}</td>
                                <td>{dataFormatada}</td>
                                <td>{row["Hora"]}</td>
                            </tr>";
                    }

                    htmlTable += "</tbody></table>";
                    lblAgendaConsultas.Text = htmlTable;
                    MostrarMensagem($"Agenda carregada. Total de {dt.Rows.Count} agendamentos.", System.Drawing.Color.Blue);
                }
                else
                {
                    lblAgendaConsultas.Text = "<p>Não há consultas agendadas para a clínica.</p>";
                    MostrarMensagem("Nenhuma consulta encontrada.", System.Drawing.Color.Orange);
                }
            }
            catch (Exception ex)
            {
                lblAgendaConsultas.Text = $"<p class='text-danger'>Erro ao carregar a agenda: {ex.Message}</p>";
            }
        }

        protected void btnCadastrarCliente_Click(object sender, EventArgs e)
        {
            if (Session["FuncionarioId"] == null)
            {
                MostrarMensagem("Sessão expirada. Faça login novamente.", System.Drawing.Color.Red);
                OcultarTodosConteudos();
                pnlLoginFuncionario.Visible = true;
                return;
            }
            OcultarTodosConteudos();
            pnlCadastroCliente.Visible = true;
            // Limpa os campos do formulário para um novo cadastro
            LimparCamposCadastroCliente();
            lblMensagemCadastroCliente.Text = "Preencha os dados do novo cliente.";
            lblMensagemCadastroCliente.ForeColor = Color.Blue;
        }

        protected void btnSalvarCliente_Click(object sender, EventArgs e)
        {
            if (Session["FuncionarioId"] == null)
            {
                lblMensagemCadastroCliente.Text = "Sessão expirada. Faça login novamente.";
                lblMensagemCadastroCliente.ForeColor = Color.Red;
                OcultarTodosConteudos();
                pnlLoginFuncionario.Visible = true;
                return;
            }

            string nome = txtNomeCliente.Text.Trim();
            string usuario = txtUsuarioCliente.Text.Trim();
            string senha = txtSenhaCliente.Text; // Senha sem trim para permitir espaços intencionais, se necessário.
            string email = txtEmailCliente.Text.Trim();
            string telefone = txtTelefoneCliente.Text.Trim();
            string endereco = txtEnderecoCliente.Text.Trim();
            int idade = 0;
            bool isIdadeValid = int.TryParse(txtIdadeCliente.Text.Trim(), out idade);

            if (string.IsNullOrEmpty(nome) || string.IsNullOrEmpty(usuario) || string.IsNullOrEmpty(senha))
            {
                lblMensagemCadastroCliente.Text = "Nome, Usuário e Senha são campos obrigatórios.";
                lblMensagemCadastroCliente.ForeColor = Color.Red;
                return;
            }

            // Você pode adicionar validações de e-mail, telefone, etc. aqui.

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    // Verifica se o usuário já existe
                    SqlCommand checkCmd = new SqlCommand("SELECT COUNT(*) FROM Clientes WHERE Usuario = @Usuario", conn);
                    checkCmd.Parameters.AddWithValue("@Usuario", usuario);
                    if ((int)checkCmd.ExecuteScalar() > 0)
                    {
                        lblMensagemCadastroCliente.Text = "Já existe um cliente com este nome de usuário. Por favor, escolha outro.";
                        lblMensagemCadastroCliente.ForeColor = Color.Red;
                        return;
                    }

                    // Insere o novo cliente
                    const string query = @"
                        INSERT INTO Clientes (Nome, Usuario, Senha, Email, Telefone, Endereco, Idade) 
                        VALUES (@Nome, @Usuario, @Senha, @Email, @Telefone, @Endereco, @Idade)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Nome", nome);
                        cmd.Parameters.AddWithValue("@Usuario", usuario);
                        cmd.Parameters.AddWithValue("@Senha", senha);
                        cmd.Parameters.AddWithValue("@Email", string.IsNullOrEmpty(email) ? (object)DBNull.Value : email);
                        cmd.Parameters.AddWithValue("@Telefone", string.IsNullOrEmpty(telefone) ? (object)DBNull.Value : telefone);
                        cmd.Parameters.AddWithValue("@Endereco", string.IsNullOrEmpty(endereco) ? (object)DBNull.Value : endereco);
                        cmd.Parameters.AddWithValue("@Idade", isIdadeValid && idade > 0 ? (object)idade : DBNull.Value);

                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            lblMensagemCadastroCliente.Text = $"Cliente '{nome}' cadastrado com sucesso!";
                            lblMensagemCadastroCliente.ForeColor = Color.Green;
                            LimparCamposCadastroCliente(); // Limpa os campos após o sucesso
                        }
                        else
                        {
                            lblMensagemCadastroCliente.Text = "Erro ao cadastrar o cliente. Tente novamente.";
                            lblMensagemCadastroCliente.ForeColor = Color.Red;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMensagemCadastroCliente.Text = $"Erro ao cadastrar cliente: {ex.Message}";
                lblMensagemCadastroCliente.ForeColor = Color.Red;
            }
        }

        private void LimparCamposCadastroCliente()
        {
            txtNomeCliente.Text = "";
            txtUsuarioCliente.Text = "";
            txtSenhaCliente.Text = "";
            txtEmailCliente.Text = "";
            txtTelefoneCliente.Text = "";
            txtEnderecoCliente.Text = "";
            txtIdadeCliente.Text = "";
        }

        protected void btnVoltarOpcoes_Click(object sender, EventArgs e)
        {
            OcultarTodosConteudos();
            pnlOpcoesFuncionario.Visible = true;
            string nome = Session["FuncionarioNome"] as string;
            lblMensagemFuncionarioBoasVindas.Text = $"Bem-vindo(a), {nome}! Escolha uma opção:";
            MostrarMensagem("Selecione uma opção.", System.Drawing.Color.Blue); // Mensagem genérica ao voltar
        }

        protected void btnSair_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect(Request.RawUrl); // Redireciona para a mesma página, reiniciando no login
        }
    }
}
