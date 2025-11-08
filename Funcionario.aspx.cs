using PluxeePetADS4.Cliente;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
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
                    
                    OcultarTodosConteudos();
                    pnlOpcoesFuncionario.Visible = true;
                    ConfigurarOpcoesFuncionario();
                }
            }
            else
            {
                
                if (Session["FuncionarioId"] != null)
                {
                    ConfigurarOpcoesFuncionario();
                }
            }
        }

        private void ConfigurarOpcoesFuncionario()
        {
            int id = (int)Session["FuncionarioId"];
            string nome = Session["FuncionarioNome"] as string;

            if (id == 4)
            {
                pnlOpcoesGerente.Visible = true;
                lblMensagemFuncionarioBoasVindas.Text = $"Bem-vindo(a), {nome}! Escolha uma opção:";
            }
            else
            {
                pnlOpcoesGerente.Visible = false;
                lblMensagemFuncionarioBoasVindas.Text = $"Bem-vindo(a), {nome}! Escolha uma opção:";
            }
        }

        private void OcultarTodosConteudos()
        {
            pnlLoginFuncionario.Visible = false;
            pnlOpcoesFuncionario.Visible = false;
            pnlAgenda.Visible = false;
            pnlCadastroCliente.Visible = false;
            pnlOpcoesGerente.Visible = false;

            if (pnlCadastroFuncionario != null)
            {
                pnlCadastroFuncionario.Visible = false;
            }

            if (pnlDesativarFuncionario != null)
            {
                pnlDesativarFuncionario.Visible = false;
            }

            if (pnlDesativarCliente != null)
            {
                pnlDesativarCliente.Visible = false;
            }

            lblMensagem.Text = "";
            lblMensagemCadastroCliente.Text = "";

            if (lblMensagemCadastroFuncionario != null)
            {
                lblMensagemCadastroFuncionario.Text = "";
            }

            if (lblMensagemDesativarFuncionario != null)
            {
                lblMensagemDesativarFuncionario.Text = "";
            }

            if (lblMensagemDesativarCliente != null)
            {
                lblMensagemDesativarCliente.Text = "";
            }

            if (pnlDetalhesFuncionario != null)
            {
                pnlDetalhesFuncionario.Visible = false;
            }

            if (pnlDetalhesCliente != null)
            {
                pnlDetalhesCliente.Visible = false;
            }

            if (pnlEditarFuncionario != null)
            {
                pnlEditarFuncionario.Visible = false;
            }

            if (pnlEditarCliente != null)
            {
                pnlEditarCliente.Visible = false;
            }
        }

        private void MostrarMensagem(string texto, System.Drawing.Color cor)
        {
            lblMensagem.Text = texto;
            lblMensagem.ForeColor = cor;
        }

        protected void btnEntrar_Click(object sender, EventArgs e)
        {
            string idFuncionarioStr = txtFuncionarioId.Text.Trim();
            string senha = txtSenha.Text.Trim();

            if (string.IsNullOrEmpty(idFuncionarioStr) || string.IsNullOrEmpty(senha))
            {
                MostrarMensagem("Preencha ID e senha!", System.Drawing.Color.Red);
                pnlLoginFuncionario.Visible = true;
                return;
            }

            if (!int.TryParse(idFuncionarioStr, out int idFuncionario))
            {
                MostrarMensagem("ID de Funcionário deve ser um número válido.", System.Drawing.Color.Red);
                pnlLoginFuncionario.Visible = true;
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    const string query = @"SELECT IdFuncionario, Nome FROM Funcionarios WHERE IdFuncionario = @id AND Senha = @senha AND Ativo = 1";

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

                                ConfigurarOpcoesFuncionario();

                                MostrarMensagem("Login efetuado com sucesso!", System.Drawing.Color.Green);
                            }
                            else
                            {
                                MostrarMensagem("ID, senha incorretos ou funcionário inativo!", System.Drawing.Color.Red);
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
            AbrePainelCadastroCliente();
        }

        protected void btnAcessarEdicaoCliente_Click(object sender, EventArgs e)
        {
            OcultarTodosConteudos();
            pnlEditarCliente.Visible = true; 
            lblStatusBuscaCliente.Text = string.Empty;
            pnlFormularioEdicaoCliente.Visible = false;
            txtClienteNomeOuIdPesquisa.Text = string.Empty;
        }

        protected void btnBuscarCliente_Click(object sender, EventArgs e)
        {
            pnlFormularioEdicaoCliente.Visible = false;
            lblStatusBuscaCliente.Text = string.Empty;
            lblMensagemEdicaoCliente.Text = string.Empty;

            string termoBusca = txtClienteNomeOuIdPesquisa.Text.Trim();

            if (string.IsNullOrEmpty(termoBusca))
            {
                lblStatusBuscaCliente.Text = "⚠️ Por favor, insira o Nome ou ID do cliente para buscar.";
                lblStatusBuscaCliente.ForeColor = System.Drawing.Color.Red;
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    const string query = @"
                        SELECT
                        IdCliente,
                        Nome,
                        Email,
                        Telefone,
                        Endereco,
                        DataNascimento
                        FROM Clientes
                        WHERE Ativo = 1 AND (IdCliente = @termoId OR Nome LIKE @termoNome)"; // Garante que busca apenas clientes ativos

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        int clienteId;

                        if (int.TryParse(termoBusca, out clienteId))
                        {
                            cmd.Parameters.AddWithValue("@termoId", clienteId);
                            cmd.Parameters.AddWithValue("@termoNome", DBNull.Value);
                        }
                        else
                        {
                            cmd.Parameters.AddWithValue("@termoId", DBNull.Value);
                            cmd.Parameters.AddWithValue("@termoNome", "%" + termoBusca + "%");
                        }

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                int id = reader.GetInt32(reader.GetOrdinal("IdCliente"));
                                string nome = reader["Nome"].ToString();

                                lblIdClienteEdicao.Text = id.ToString();
                                txtNomeEdicaoCliente.Text = nome;
                                txtEmailEdicaoCliente.Text = reader["Email"] == DBNull.Value ? string.Empty : reader["Email"].ToString();
                                txtTelefoneEdicaoCliente.Text = reader["Telefone"] == DBNull.Value ? string.Empty : reader["Telefone"].ToString();
                                txtEnderecoEdicaoCliente.Text = reader["Endereco"] == DBNull.Value ? string.Empty : reader["Endereco"].ToString();

                                if (reader["DataNascimento"] != DBNull.Value)
                                {
                                    txtDataNascimentoEdicaoCliente.Text = ((DateTime)reader["DataNascimento"]).ToString("yyyy-MM-dd");
                                }
                                else
                                {
                                    txtDataNascimentoEdicaoCliente.Text = string.Empty;
                                }

                                pnlFormularioEdicaoCliente.Visible = true;
                                lblStatusBuscaCliente.Text = $"✅ Cliente {nome} (ID {id}) carregado para edição.";
                                lblStatusBuscaCliente.ForeColor = System.Drawing.Color.Green;
                            }
                            else
                            {
                                lblStatusBuscaCliente.Text = $"❌ Cliente '{termoBusca}' não encontrado ou inativo.";
                                lblStatusBuscaCliente.ForeColor = System.Drawing.Color.Red;
                                pnlFormularioEdicaoCliente.Visible = false;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblStatusBuscaCliente.Text = $"🛑 ERRO CRÍTICO NO BANCO/CÓDIGO: {ex.Message}";
                lblStatusBuscaCliente.ForeColor = System.Drawing.Color.DarkRed;
                pnlFormularioEdicaoCliente.Visible = false;
            }
        }

        protected void btnSalvarEdicaoCliente_Click(object sender, EventArgs e)
        {
            lblMensagemEdicaoCliente.Text = string.Empty;

            if (!int.TryParse(lblIdClienteEdicao.Text, out int idCliente))
            {
                lblMensagemEdicaoCliente.Text = "ID de cliente para edição não está definido. Busque novamente.";
                lblMensagemEdicaoCliente.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string novoNome = txtNomeEdicaoCliente.Text.Trim();
            string novoEmail = txtEmailEdicaoCliente.Text.Trim();
            string novoTelefone = txtTelefoneEdicaoCliente.Text.Trim();
            string novaDataNascimentoStr = txtDataNascimentoEdicaoCliente.Text.Trim();
            string novoEndereco = txtEnderecoEdicaoCliente.Text.Trim();
            DateTime novaDataNascimento;

            if (string.IsNullOrEmpty(novoNome) || string.IsNullOrEmpty(novaDataNascimentoStr))
            {
                lblMensagemEdicaoCliente.Text = "Nome e Data de Nascimento são obrigatórios.";
                lblMensagemEdicaoCliente.ForeColor = System.Drawing.Color.Red;
                return;
            }

            if (!DateTime.TryParse(novaDataNascimentoStr, out novaDataNascimento))
            {
                lblMensagemEdicaoCliente.Text = "Data de Nascimento inválida. Use o formato AAAA-MM-DD.";
                lblMensagemEdicaoCliente.ForeColor = System.Drawing.Color.Red;
                return;
            }

            try
            {
                int rowsAffected = 0;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    const string updateQuery = @"
                    UPDATE Clientes 
                    SET Nome = @Nome, 
                    Email = @Email, 
                    Telefone = @Telefone, 
                    Endereco = @Endereco, 
                    DataNascimento = @DataNascimento 
                    WHERE IdCliente = @IdCliente";

                    using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@IdCliente", idCliente);
                        cmd.Parameters.AddWithValue("@Nome", novoNome);
                        cmd.Parameters.AddWithValue("@Email", string.IsNullOrEmpty(novoEmail) ? (object)DBNull.Value : novoEmail);
                        cmd.Parameters.AddWithValue("@Telefone", string.IsNullOrEmpty(novoTelefone) ? (object)DBNull.Value : novoTelefone);
                        cmd.Parameters.AddWithValue("@Endereco", string.IsNullOrEmpty(novoEndereco) ? (object)DBNull.Value : novoEndereco);
                        cmd.Parameters.AddWithValue("@DataNascimento", novaDataNascimento);

                        rowsAffected = cmd.ExecuteNonQuery();
                    }
                }

                // 3. Verifica o resultado da execução (rowsAffected)
                if (rowsAffected > 0)
                {
                    OcultarTodosConteudos();
                    lblMensagemEdicaoCliente.Text = $"✅ Cliente ID {idCliente} atualizado com sucesso!";
                    lblMensagemEdicaoCliente.ForeColor = System.Drawing.Color.Green;

                    btnVoltarOpcoesGerente_Click(null, null);
                }
                else
                {
                    lblMensagemEdicaoCliente.Text = "Nenhuma alteração realizada ou cliente não encontrado.";
                    lblMensagemEdicaoCliente.ForeColor = System.Drawing.Color.Red;
                }
            }
            catch (Exception ex)
            {
                lblMensagemEdicaoCliente.Text = $"Erro ao salvar edições: {ex.Message}";
                lblMensagemEdicaoCliente.ForeColor = System.Drawing.Color.DarkRed;
            }
        }

        protected void btnCadastrarClienteGerente_Click(object sender, EventArgs e)
        {
            AbrePainelCadastroCliente();
        }

        private void AbrePainelCadastroCliente()
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
            string senha = txtSenhaCliente.Text;
            string email = txtEmailCliente.Text.Trim();
            string telefone = txtTelefoneCliente.Text.Trim();
            string endereco = txtEnderecoCliente.Text.Trim();

            string dataNascimentoStr = txtIdadeCliente.Text.Trim();
            DateTime dataNascimento;

            if (string.IsNullOrEmpty(nome) || string.IsNullOrEmpty(usuario) || string.IsNullOrEmpty(senha) || string.IsNullOrEmpty(dataNascimentoStr))
            {
                lblMensagemCadastroCliente.Text = "Nome, Usuário, Senha e Data de Nascimento são campos obrigatórios.";
                lblMensagemCadastroCliente.ForeColor = Color.Red;
                return;
            }

            if (!DateTime.TryParse(dataNascimentoStr, out dataNascimento))
            {
                lblMensagemCadastroCliente.Text = "Data de Nascimento inválida. Use o formato AAAA-MM-DD (ou o formato esperado pelo controle).";
                lblMensagemCadastroCliente.ForeColor = Color.Red;
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand checkCmd = new SqlCommand("SELECT COUNT(*) FROM Clientes WHERE Usuario = @Usuario", conn);
                    checkCmd.Parameters.AddWithValue("@Usuario", usuario);
                    if ((int)checkCmd.ExecuteScalar() > 0)
                    {
                        lblMensagemCadastroCliente.Text = "Já existe um cliente com este nome de usuário. Por favor, escolha outro.";
                        lblMensagemCadastroCliente.ForeColor = Color.Red;
                        return;
                    }

                    const string query = @"
                    INSERT INTO Clientes (Nome, Usuario, Senha, Email, Telefone, Endereco, DataNascimento, Ativo) 
                    VALUES (@Nome, @Usuario, @Senha, @Email, @Telefone, @Endereco, @DataNascimento, 1)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Nome", nome);
                        cmd.Parameters.AddWithValue("@Usuario", usuario);
                        cmd.Parameters.AddWithValue("@Senha", senha);
                        cmd.Parameters.AddWithValue("@Email", string.IsNullOrEmpty(email) ? (object)DBNull.Value : email);
                        cmd.Parameters.AddWithValue("@Telefone", string.IsNullOrEmpty(telefone) ? (object)DBNull.Value : telefone);
                        cmd.Parameters.AddWithValue("@Endereco", string.IsNullOrEmpty(endereco) ? (object)DBNull.Value : endereco);
                        cmd.Parameters.AddWithValue("@DataNascimento", dataNascimento);

                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            lblMensagemCadastroCliente.Text = $"Cliente '{nome}' cadastrado com sucesso!";
                            lblMensagemCadastroCliente.ForeColor = Color.Green;
                            LimparCamposCadastroCliente();
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

        protected void btnVoltarOpcoesGerente_Click(object sender, EventArgs e)
        {
            OcultarTodosConteudos();
            if (pnlOpcoesFuncionario != null) pnlOpcoesFuncionario.Visible = true;
            if (pnlOpcoesGerente != null) pnlOpcoesGerente.Visible = true;
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
            ConfigurarOpcoesFuncionario();
            MostrarMensagem("Selecione uma opção.", System.Drawing.Color.Blue);
        }

        protected void btnSair_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect(Request.RawUrl);
        }

        protected void btnCadastrarFuncionario_Click(object sender, EventArgs e)
        {
            if (Session["FuncionarioId"] == null)
            {
                MostrarMensagem("Sessão expirada. Faça login novamente.", System.Drawing.Color.Red);
                OcultarTodosConteudos();
                pnlLoginFuncionario.Visible = true;
                return;
            }
            OcultarTodosConteudos();
            pnlCadastroFuncionario.Visible = true;
            txtNomeFunc.Text = "";
            txtSenhaFunc.Text = "";
            lblMensagemCadastroFuncionario.Text = "Preencha os dados do novo funcionário.";
            lblMensagemCadastroFuncionario.ForeColor = Color.Blue;
        }

        protected void btnSalvarFuncionario_Click(object sender, EventArgs e)
        {

            if (Session["FuncionarioId"] == null)
            {
                lblMensagemCadastroFuncionario.Text = "Sessão expirada. Faça login novamente.";
                lblMensagemCadastroFuncionario.ForeColor = Color.Red;
                OcultarTodosConteudos();
                pnlLoginFuncionario.Visible = true;
                return;
            }

            string nome = txtNomeFunc.Text.Trim();
            string senha = txtSenhaFunc.Text;
            string cpf = txtCpfFunc.Text.Trim();

            if (string.IsNullOrEmpty(nome) || string.IsNullOrEmpty(senha) || string.IsNullOrEmpty(cpf))
            {
                lblMensagemCadastroFuncionario.Text = "Nome, Senha e CPF são obrigatórios.";
                lblMensagemCadastroFuncionario.ForeColor = Color.Red;
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    const string query = @"
                INSERT INTO Funcionarios (Nome, Senha, CPF, Ativo) 
                OUTPUT INSERTED.IdFuncionario
                VALUES (@Nome, @Senha, @CPF, 1)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Nome", nome);
                        cmd.Parameters.AddWithValue("@Senha", senha);
                        cmd.Parameters.AddWithValue("@CPF", cpf); 

                        int novoId = (int)cmd.ExecuteScalar();

                        if (novoId > 0)
                        {
                            lblMensagemCadastroFuncionario.Text = $"✅ Funcionário **{nome}** (CPF: {cpf}) cadastrado com sucesso! Novo ID: {novoId}.";
                            lblMensagemCadastroFuncionario.ForeColor = Color.Green;

                            txtNomeFunc.Text = "";
                            txtSenhaFunc.Text = "";
                            txtCpfFunc.Text = ""; 
                        }
                        else
                        {
                            lblMensagemCadastroFuncionario.Text = "Erro ao cadastrar o funcionário. Tente novamente.";
                            lblMensagemCadastroFuncionario.ForeColor = Color.Red;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMensagemCadastroFuncionario.Text = $"Erro ao cadastrar funcionário: {ex.Message}";
                lblMensagemCadastroFuncionario.ForeColor = Color.Red;
            }
        }

        protected void btnVerificarConsultasSistema_Click(object sender, EventArgs e)
        {
            btnGerenciarAgenda_Click(sender, e);
        }

        protected void btnDesativarFuncionario_Click(object sender, EventArgs e)
        {
            if (Session["FuncionarioId"] == null)
            {
                MostrarMensagem("Sessão expirada. Faça login novamente.", System.Drawing.Color.Red);
                OcultarTodosConteudos();
                pnlLoginFuncionario.Visible = true;
                return;
            }

            OcultarTodosConteudos();
            pnlDesativarFuncionario.Visible = true;
            txtBuscarFunc.Text = string.Empty;
            pnlDetalhesFuncionario.Visible = false;
            lblMensagemDesativarFuncionario.Text = "Insira o ID do funcionário que deseja desativar.";
            lblMensagemDesativarFuncionario.ForeColor = Color.Blue;
        }

        protected void gvFuncionarios_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            lblMensagemDesativarFuncionario.Text = string.Empty;
            pnlDetalhesFuncionario.Visible = false;

            if (e.CommandName == "DesativarFuncionario")
            {

                if (!int.TryParse(e.CommandArgument.ToString(), out int idFuncionario))
                {
                    lblMensagemDesativarCliente.Text = "❌ Erro: ID de funcionário inválido.";
                    lblMensagemDesativarCliente.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                try
                {

                    const string queryUpdate = "UPDATE Funcionarios SET Ativo = 0 WHERE IdFuncionario = @id";

                    using (SqlConnection conn = new SqlConnection(connectionString))
                    using (SqlCommand cmd = new SqlCommand(queryUpdate, conn))
                    {
                        cmd.Parameters.AddWithValue("@id", idFuncionario);
                        conn.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            lblMensagemDesativarCliente.Text = $"✅ Funcionário ID {idFuncionario} desativado com sucesso!";
                            lblMensagemDesativarCliente.ForeColor = System.Drawing.Color.Green;
                        }
                        else
                        {
                            lblMensagemDesativarCliente.Text = $"⚠️ Aviso: Funcionário ID {idFuncionario} não foi desativado.";
                            lblMensagemDesativarCliente.ForeColor = System.Drawing.Color.Orange;
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblMensagemDesativarCliente.Text = $"❌ Erro de BD ao desativar: {ex.Message}";
                    lblMensagemDesativarCliente.ForeColor = System.Drawing.Color.Red;
                }

            }
        }

        protected void btnBuscarFuncionarioParaEdicao_Click(object sender, EventArgs e)
        {
           
            pnlFormularioEdicaoFuncionario.Visible = false;
            lblStatusBuscaFuncionario.Text = string.Empty;
            lblMensagemEdicaoFuncionario.Text = string.Empty;

            string termoBusca = txtFuncIdPesquisa.Text.Trim();

            if (string.IsNullOrEmpty(termoBusca))
            {
                lblStatusBuscaFuncionario.Text = "⚠️ Por favor, insira o Nome do funcionário para buscar.";
                lblStatusBuscaFuncionario.ForeColor = System.Drawing.Color.Red;
                return;
            }

            try
            {

                string telefoneBruto = txtTelefoneEdicao.Text.Trim();
                string telefoneLimpo = System.Text.RegularExpressions.Regex.Replace(telefoneBruto, "[^0-9]", "");

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    const string query = @"
                    SELECT 
                    IdFuncionario, 
                    Nome, 
                    CPF, 
                    Email, 
                    Telefone, 
                    DataAdmissao 
                    FROM Funcionarios 
                    WHERE (IdFuncionario = @termoId OR Nome LIKE @termoNome)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                      
                        if (int.TryParse(termoBusca, out int funcionarioId))
                        {
                            cmd.Parameters.AddWithValue("@termoId", funcionarioId);
                            cmd.Parameters.AddWithValue("@termoNome", DBNull.Value);
                        }
                        else
                        {
                            cmd.Parameters.AddWithValue("@termoId", DBNull.Value);
                            cmd.Parameters.AddWithValue("@termoNome", "%" + termoBusca + "%");
                        }

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                       
                                int id = reader.GetInt32(reader.GetOrdinal("IdFuncionario"));

                                lblIdFuncionarioEdicao.Text = id.ToString();
                                txtNomeEdicao.Text = reader["Nome"].ToString();
                                txtCpfEdicao.Text = reader["CPF"].ToString();
                                txtEmailEdicao.Text = reader["Email"].ToString();
                                txtTelefoneEdicao.Text = reader["Telefone"] == DBNull.Value ? string.Empty : reader["Telefone"].ToString();

                                if (reader["DataAdmissao"] != DBNull.Value)
                                {
                                    txtDataAdmissaoEdicao.Text = ((DateTime)reader["DataAdmissao"]).ToString("yyyy-MM-dd");
                                }
                                else
                                {
                                    txtDataAdmissaoEdicao.Text = string.Empty;
                                }

                                txtNovaSenhaEdicao.Text = string.Empty;

                                pnlFormularioEdicaoFuncionario.Visible = true;
                                lblStatusBuscaFuncionario.Text = $"✅ Funcionário {reader["Nome"]} (ID {id}) carregado. Edite os dados abaixo.";
                                lblStatusBuscaFuncionario.ForeColor = System.Drawing.Color.Green;
                            }
                            else
                            {
                                lblStatusBuscaFuncionario.Text = $"❌ Funcionário '{termoBusca}' não encontrado.";
                                lblStatusBuscaFuncionario.ForeColor = System.Drawing.Color.Red;
                                pnlFormularioEdicaoFuncionario.Visible = false;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblStatusBuscaFuncionario.Text = $"🛑 ERRO CRÍTICO NO BANCO/CÓDIGO: {ex.Message}";
                lblStatusBuscaFuncionario.ForeColor = System.Drawing.Color.DarkRed;
            }
        }

        protected void btnBuscarFuncionario_Click(object sender, EventArgs e)
        {
            pnlDetalhesFuncionario.Visible = false;
            lblMensagemDesativarFuncionario.Text = string.Empty;
            gvFuncionarios.Visible = false;

            string termoBusca = txtBuscarFunc.Text.Trim();

            if (string.IsNullOrEmpty(termoBusca))
            {
                lblMensagemDesativarFuncionario.Text = "Por favor, insira o ID ou o Nome do funcionário para buscar.";
                lblMensagemDesativarFuncionario.ForeColor = System.Drawing.Color.Red;
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    DataTable dt = new DataTable();

                    bool isIdSearch = int.TryParse(termoBusca, out int funcionarioId);

                    string query;
                    if (isIdSearch)
                    {
                        query = "SELECT IdFuncionario, Nome, Cargo, Ativo FROM Funcionarios WHERE IdFuncionario = @termo";
                    }
                    else
                    {
                        query = "SELECT IdFuncionario, Nome, Cargo, Ativo FROM Funcionarios WHERE Nome LIKE @termo";
                    }

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        if (isIdSearch)
                        {
                            cmd.Parameters.AddWithValue("@termo", funcionarioId);
                        }
                        else
                        {
                            cmd.Parameters.AddWithValue("@termo", "%" + termoBusca + "%");
                        }

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                           
                                int id = reader.GetInt32(0);
                                string nome = reader.GetString(1);
                                string nomeCargo = reader.GetString(2);
                                bool ativo = reader.GetBoolean(3);

                                lblFuncionarioNome.Text = $"Nome: {nome} (ID: {id})";
                                lblFuncionarioCargo.Text = $"Cargo: {nomeCargo}";
                                pnlDetalhesFuncionario.Visible = true;

                                if (ativo)
                                {
                                    lblFuncionarioStatus.Text = "<span style='color: green; font-weight: bold;'>Status: ATIVO</span>";
                                    btnConfirmarDesativacaoFunc.Visible = true;
                                    btnConfirmarDesativacaoFunc.CommandArgument = id.ToString();
                                    lblMensagemDesativarFuncionario.Text = $"Funcionário {nome} encontrado. Confirme a desativação.";
                                    lblMensagemDesativarFuncionario.ForeColor = System.Drawing.Color.Orange;
                                }
                                else
                                {
                                    lblFuncionarioStatus.Text = "<span style='color: red; font-weight: bold;'>Status: INATIVO</span>";
                                    btnConfirmarDesativacaoFunc.Visible = false;
                                    lblMensagemDesativarFuncionario.Text = $"Funcionário {nome} já está inativo no sistema.";
                                    lblMensagemDesativarFuncionario.ForeColor = System.Drawing.Color.Red;
                                }

                                if (Session["FuncionarioId"] != null && (int)Session["FuncionarioId"] == id)
                                {
                                    btnConfirmarDesativacaoFunc.Visible = false;
                                    lblMensagemDesativarFuncionario.Text = "Você não pode desativar sua própria conta de funcionário.";
                                    lblMensagemDesativarFuncionario.ForeColor = System.Drawing.Color.Red;
                                }
                            }
                            else
                            {
                                lblMensagemDesativarFuncionario.Text = $"Funcionário '{termoBusca}' não encontrado.";
                                lblMensagemDesativarFuncionario.ForeColor = System.Drawing.Color.Red;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMensagemDesativarFuncionario.Text = $"Erro ao buscar funcionário: {ex.Message}";
                lblMensagemDesativarFuncionario.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnAcessarEdicaoFuncionario_Click(object sender, EventArgs e)
        {
           
            OcultarTodosConteudos();
            pnlEditarFuncionario.Visible = true;

            lblStatusBuscaFuncionario.Text = string.Empty;
            lblMensagemEdicaoFuncionario.Text = string.Empty;
            txtFuncIdPesquisa.Text = string.Empty;
            pnlFormularioEdicaoFuncionario.Visible = false;
        }

        protected void btnSalvarEdicaoFuncionario_Click(object sender, EventArgs e)
        {
            lblMensagemEdicaoFuncionario.Text = string.Empty;
            if (!int.TryParse(lblIdFuncionarioEdicao.Text, out int idFuncionario))
            {
                lblMensagemEdicaoFuncionario.Text = "ID de funcionário para edição não está definido. Busque novamente.";
                lblMensagemEdicaoFuncionario.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string novoNome = txtNomeEdicao.Text.Trim();
            string novoCpf = txtCpfEdicao.Text.Trim();
            string novoEmail = txtEmailEdicao.Text.Trim();
            string novoTelefoneBruto = txtTelefoneEdicao.Text.Trim();
            string novaDataAdmissaoStr = txtDataAdmissaoEdicao.Text;
            string novaSenha = txtNovaSenhaEdicao.Text;

            if (string.IsNullOrEmpty(novoNome) || string.IsNullOrEmpty(novoCpf) || string.IsNullOrEmpty(novoEmail) || string.IsNullOrEmpty(novaDataAdmissaoStr))
            {
                lblMensagemEdicaoFuncionario.Text = "Nome, CPF, Email e Data de Admissão são obrigatórios.";
                lblMensagemEdicaoFuncionario.ForeColor = System.Drawing.Color.Red;
                return;
            }

            if (!DateTime.TryParse(novaDataAdmissaoStr, out DateTime novaDataAdmissao))
            {
                lblMensagemEdicaoFuncionario.Text = "Data de Admissão inválida. Use o formato AAAA-MM-DD.";
                lblMensagemEdicaoFuncionario.ForeColor = System.Drawing.Color.Red;
                return;
            }

            try
            {

                string telefoneLimpo = System.Text.RegularExpressions.Regex.Replace(novoTelefoneBruto, "[^0-9]", "");
                object telefoneParametro = string.IsNullOrEmpty(telefoneLimpo) ? (object)DBNull.Value : telefoneLimpo;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string updateQuery = @"
                    UPDATE Funcionarios 
                    SET Nome = @Nome, 
                    CPF = @CPF, 
                    Email = @Email,  
                    Telefone = @Telefone, 
                    DataAdmissao = @DataAdmissao"
                        + (string.IsNullOrEmpty(novaSenha) ? "" : ", Senha = @Senha")
                        + " WHERE IdFuncionario = @IdFuncionario";

                    using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                    {
                      
                        cmd.Parameters.AddWithValue("@IdFuncionario", idFuncionario);
                        cmd.Parameters.AddWithValue("@Nome", novoNome);
                        cmd.Parameters.AddWithValue("@CPF", novoCpf);
                        cmd.Parameters.AddWithValue("@Email", novoEmail);
                        cmd.Parameters.AddWithValue("@Telefone", telefoneParametro); 
                        cmd.Parameters.AddWithValue("@DataAdmissao", novaDataAdmissao);

                        if (!string.IsNullOrEmpty(novaSenha))
                        {
                            cmd.Parameters.AddWithValue("@Senha", novaSenha);
                        }

                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            lblMensagemEdicaoFuncionario.Text = $"✅ Funcionário ID {idFuncionario} atualizado com sucesso!";
                            lblMensagemEdicaoFuncionario.ForeColor = System.Drawing.Color.Green;

                            txtFuncIdPesquisa.Text = string.Empty;
                            lblStatusBuscaFuncionario.Text = string.Empty;
                            lblMensagemEdicaoFuncionario.Text = string.Empty;

                            OcultarTodosConteudos();

                            pnlFormularioEdicaoFuncionario.Visible = false;

                            if (pnlOpcoesFuncionario != null) 
                            {
                                pnlOpcoesFuncionario.Visible = true;
                            }

                            if (pnlOpcoesGerente != null)
                            {
                                pnlOpcoesGerente.Visible = true;
                            }

                        }
                        else
                        {
                            lblMensagemEdicaoFuncionario.Text = "Nenhuma alteração realizada ou funcionário não encontrado.";
                            lblMensagemEdicaoFuncionario.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                }
            }
            catch (SqlException sqlEx)
            {
                lblMensagemEdicaoFuncionario.Text = $"🛑 Erro ao salvar edições (SQL Error): {sqlEx.Message}";
                lblMensagemEdicaoFuncionario.ForeColor = System.Drawing.Color.DarkRed;
            }
            catch (Exception ex)
            {
                lblMensagemEdicaoFuncionario.Text = $"Erro ao salvar edições: {ex.Message}";
                lblMensagemEdicaoFuncionario.ForeColor = System.Drawing.Color.DarkRed;
            }
        }

        protected void gvClientes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            lblMensagemDesativarCliente.Text = string.Empty;
            pnlDetalhesCliente.Visible = true;

            if (e.CommandName == "DesativarCliente")
            {

                if (!int.TryParse(e.CommandArgument.ToString(), out int idCliente))
                {
                    lblMensagemDesativarCliente.Text = "❌ Erro: ID de cliente inválido.";
                    lblMensagemDesativarCliente.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                try
                {

                    const string queryUpdate = "UPDATE Clientes SET Ativo = 0 WHERE IdCliente = @id";

                    using (SqlConnection conn = new SqlConnection(connectionString))
                    using (SqlCommand cmd = new SqlCommand(queryUpdate, conn))
                    {
                        cmd.Parameters.AddWithValue("@id", idCliente);
                        conn.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            lblMensagemDesativarCliente.Text = $"✅ Cliente ID {idCliente} desativado com sucesso!";
                            lblMensagemDesativarCliente.ForeColor = System.Drawing.Color.Green;
                        }
                        else
                        {
                            lblMensagemDesativarCliente.Text = $"⚠️ Aviso: Cliente ID {idCliente} não foi desativado.";
                            lblMensagemDesativarCliente.ForeColor = System.Drawing.Color.Orange;
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblMensagemDesativarCliente.Text = $"❌ Erro de BD ao desativar: {ex.Message}";
                    lblMensagemDesativarCliente.ForeColor = System.Drawing.Color.Red;
                }

            }
        }

        protected void btnBuscarClienteParaDesativar_Click(object sender, EventArgs e)
        {
            lblMensagemDesativarCliente.Text = string.Empty;
            pnlDetalhesCliente.Visible = true;
            gvClientes.Visible = false;

            string termoBusca = txtBuscarClienteId.Text.Trim();

            if (string.IsNullOrWhiteSpace(termoBusca))
            {
                lblMensagemDesativarCliente.Text = "⚠️ Por favor, digite o Nome do cliente para buscar.";
                lblMensagemDesativarCliente.ForeColor = System.Drawing.Color.OrangeRed;
                return;
            }

            try
            {
                DataRow clienteRow = BuscarClientePorNomeOuId(termoBusca);

                if (clienteRow != null)
                {

                    int idClienteBusca = Convert.ToInt32(clienteRow["IdCliente"]);
                    string nomeCliente = clienteRow["Nome"].ToString();
                    string usuarioCliente = clienteRow["Usuario"].ToString();
                    bool clienteAtivo = Convert.ToBoolean(clienteRow["Ativo"]);

                    lblClienteNome.Text = $"Nome: {nomeCliente} (ID: {idClienteBusca})";
                    lblClienteUsuario.Text = $"Usuário: {usuarioCliente}";

                    if (clienteAtivo)
                    {
                        lblClienteStatus.Text = "Status: Ativo";
                        lblClienteStatus.ForeColor = System.Drawing.Color.Green;
                        btnConfirmarDesativacaoCliente.Visible = true;
                        btnConfirmarDesativacaoCliente.CommandArgument = idClienteBusca.ToString();
                    }
                    else
                    {
                        lblClienteStatus.Text = "Status: INATIVO";
                        lblClienteStatus.ForeColor = System.Drawing.Color.Red;
                        btnConfirmarDesativacaoCliente.Visible = false;
                        lblMensagemDesativarCliente.Text = $"Cliente ID {idClienteBusca} já está inativo.";
                        lblMensagemDesativarCliente.ForeColor = System.Drawing.Color.OrangeRed;
                    }

                    pnlDetalhesCliente.Visible = true;
                }
                else
                {
                    lblMensagemDesativarCliente.Text = $"❌ Cliente com termo de busca '{termoBusca}' não encontrado.";
                    lblMensagemDesativarCliente.ForeColor = System.Drawing.Color.Red;
                }

            }
            catch (Exception ex)
            {
                lblMensagemDesativarCliente.Text = $"❌ Erro ao buscar o cliente: {ex.InnerException?.Message ?? ex.Message}";
                lblMensagemDesativarCliente.ForeColor = System.Drawing.Color.Red;
            }
        }

        private DataRow BuscarClientePorNomeOuId(string termoBusca)
        {
            DataTable dt = new DataTable();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    if (int.TryParse(termoBusca, out int idCliente))
                    {
                        const string queryId = @"
                        SELECT IdCliente, Nome, Usuario, Ativo 
                        FROM Clientes 
                        WHERE IdCliente = @TermoBusca";

                        using (SqlCommand cmd = new SqlCommand(queryId, conn))
                        {
                            cmd.Parameters.AddWithValue("@TermoBusca", idCliente);
                            new SqlDataAdapter(cmd).Fill(dt);
                        }
                    }
                    else
                    {
                        const string queryNome = @"
                        SELECT IdCliente, Nome, Usuario, Ativo 
                        FROM Clientes 
                        WHERE LOWER(Nome) LIKE LOWER(@TermoBusca)";

                        using (SqlCommand cmd = new SqlCommand(queryNome, conn))
                        {
                            cmd.Parameters.AddWithValue("@TermoBusca", "%" + termoBusca + "%");
                            new SqlDataAdapter(cmd).Fill(dt);
                        }
                    }
                }

                return dt.Rows.Count > 0 ? dt.Rows[0] : null;
            }
            catch (Exception ex)
            {
                throw new Exception("Falha ao buscar cliente no BD.", ex);
            }
        }


        protected void btnConfirmarDesativacaoFunc_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            if (!int.TryParse(btn.CommandArgument, out int funcionarioIdParaDesativar))
            {
                lblMensagemDesativarFuncionario.Text = "Erro: ID do funcionário para desativação não encontrado.";
                lblMensagemDesativarFuncionario.ForeColor = Color.Red;
                pnlDetalhesFuncionario.Visible = false;
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    const string query = @"
                        UPDATE Funcionarios 
                        SET Ativo = 0 
                        WHERE IdFuncionario = @id AND Ativo = 1"; 

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@id", funcionarioIdParaDesativar);

                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            lblMensagemDesativarFuncionario.Text = $"✅ Funcionário com ID {funcionarioIdParaDesativar} desativado com sucesso!";
                            lblMensagemDesativarFuncionario.ForeColor = Color.Green;
                        }
                        else
                        {
                            lblMensagemDesativarFuncionario.Text = $"O Funcionário com ID {funcionarioIdParaDesativar} já estava inativo ou não pôde ser atualizado.";
                            lblMensagemDesativarFuncionario.ForeColor = Color.Orange;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMensagemDesativarFuncionario.Text = $"Erro ao desativar funcionário: {ex.Message}";
                lblMensagemDesativarFuncionario.ForeColor = Color.Red;
            }

            pnlDetalhesFuncionario.Visible = false;
            btnConfirmarDesativacaoFunc.Visible = false;
            txtBuscarFunc.Text = string.Empty;
        }

        protected void btnDesativarCliente_Click(object sender, EventArgs e)
        {
            if (Session["FuncionarioId"] == null)
            {
                MostrarMensagem("Sessão expirada. Faça login novamente.", System.Drawing.Color.Red);
                OcultarTodosConteudos();
                pnlLoginFuncionario.Visible = true;
                return;
            }

            OcultarTodosConteudos();

            if (pnlDesativarCliente != null)
            {
                pnlDesativarCliente.Visible = true;
            }

            txtBuscarFunc.Text = string.Empty;
            pnlDetalhesCliente.Visible = false;
            lblMensagemDesativarCliente.Text = "Insira o ID do cliente que deseja desativar.";
            lblMensagemDesativarCliente.ForeColor = Color.Blue;
        }


        protected void btnConfirmarDesativacaoCliente_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            if (!int.TryParse(btn.CommandArgument, out int clienteIdParaDesativar))
            {
                lblMensagemDesativarCliente.Text = "Erro: ID do cliente para desativação não encontrado.";
                lblMensagemDesativarCliente.ForeColor = Color.Red;
                pnlDetalhesCliente.Visible = false;
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    const string query = @"
                        UPDATE Clientes 
                        SET Ativo = 0 
                        WHERE IdCliente = @id AND Ativo = 1";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@id", clienteIdParaDesativar);

                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            lblMensagemDesativarCliente.Text = $"✅ Cliente ID {clienteIdParaDesativar} desativado com sucesso!";
                            lblMensagemDesativarCliente.ForeColor = Color.Green;
                        }
                        else
                        {
                            lblMensagemDesativarCliente.Text = $"O cliente ID {clienteIdParaDesativar} já estava inativo ou não pôde ser atualizado.";
                            lblMensagemDesativarCliente.ForeColor = Color.Orange;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMensagemDesativarCliente.Text = $"Erro ao desativar cliente: {ex.Message}";
                lblMensagemDesativarCliente.ForeColor = Color.Red;
            }

            pnlDetalhesCliente.Visible = false;
            btnConfirmarDesativacaoCliente.Visible = false;
            txtBuscarFunc.Text = string.Empty;
        }
    }
}
