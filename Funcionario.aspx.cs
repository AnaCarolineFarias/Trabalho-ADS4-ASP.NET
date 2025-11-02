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
                    // Se já estiver logado, vai para as opções do funcionário
                    OcultarTodosConteudos();
                    pnlOpcoesFuncionario.Visible = true;
                    ConfigurarOpcoesFuncionario();
                }
            }
            else
            {
                // Se for PostBack e estiver logado, reconfigura o painel do gerente
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
                    // Lógica para montar a tabela HTML (já existente)
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
            int idade = 0;
            bool isIdadeValid = int.TryParse(txtIdadeCliente.Text.Trim(), out idade);

            if (string.IsNullOrEmpty(nome) || string.IsNullOrEmpty(usuario) || string.IsNullOrEmpty(senha))
            {
                lblMensagemCadastroCliente.Text = "Nome, Usuário e Senha são campos obrigatórios.";
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
                             INSERT INTO Clientes (Nome, Usuario, Senha, Email, Telefone, Endereco, Idade, Ativo) 
                             VALUES (@Nome, @Usuario, @Senha, @Email, @Telefone, @Endereco, @Idade, 1)"; // NOVO: Adicionado Ativo=1 por padrão

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
            txtCargoFunc.Text = "";
            lblMensagemCadastroFuncionario.Text = "Preencha os dados do novo funcionário.";
            lblMensagemCadastroFuncionario.ForeColor = Color.Blue;
        }

        protected void btnSalvarFuncionario_Click(object sender, EventArgs e)
        {
       
            if (Session["FuncionarioId"] == null)
            {
                lblMensagemCadastroFuncionario.Text = "Sessão expirada.";
                OcultarTodosConteudos();
                pnlLoginFuncionario.Visible = true;
                return;
            }

            string nome = txtNomeFunc.Text.Trim();
            string senha = txtSenhaFunc.Text;
            int IdFuncionario = 0;
            bool isCargoValid = int.TryParse(txtCargoFunc.Text.Trim(), out IdFuncionario);

            if (string.IsNullOrEmpty(nome) || string.IsNullOrEmpty(senha) || !isCargoValid || IdFuncionario <= 0)
            {
                lblMensagemCadastroFuncionario.Text = "Nome, Senha e ID do Cargo (número válido) são obrigatórios.";
                lblMensagemCadastroFuncionario.ForeColor = Color.Red;
                return;
            }

            if (IdFuncionario == 4 && (int)Session["FuncionarioId"] == 4)
            {
            
                try
                {
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        conn.Open();
                        SqlCommand checkGerenteCmd = new SqlCommand("SELECT COUNT(*) FROM Funcionarios WHERE IdFuncionario = 4 AND Ativo = 1", conn);
                        checkGerenteCmd.Parameters.AddWithValue("@IdFuncionario", (int)Session["FuncionarioId"]);

                        if ((int)checkGerenteCmd.ExecuteScalar() > 0)
                        {
                            lblMensagemCadastroFuncionario.Text = "Já existe outro Gerente (ID 4) ativo no sistema. Não é permitido cadastrar múltiplos gerentes.";
                            lblMensagemCadastroFuncionario.ForeColor = Color.Red;
                            return;
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblMensagemCadastroFuncionario.Text = $"Erro ao verificar cargo de gerente: {ex.Message}";
                    lblMensagemCadastroFuncionario.ForeColor = Color.Red;
                    return;
                }
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                  
                    SqlCommand checkCargoCmd = new SqlCommand("SELECT COUNT(*) FROM Funcionarios WHERE CargoId = @CargoId", conn);
                    checkCargoCmd.Parameters.AddWithValue("@IdFuncionario", IdFuncionario);
                    if ((int)checkCargoCmd.ExecuteScalar() == 0)
                    {
                        lblMensagemCadastroFuncionario.Text = $"O Cargo ID {IdFuncionario} não existe na tabela de Cargos.";
                        lblMensagemCadastroFuncionario.ForeColor = Color.Red;
                        return;
                    }

                    const string query = @"
                             INSERT INTO Funcionarios (Nome, Senha, CargoId, Ativo) 
                             OUTPUT INSERTED.IdFuncionario
                             VALUES (@Nome, @Senha, @CargoId, 1)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Nome", nome);
                        cmd.Parameters.AddWithValue("@Senha", senha);
                        cmd.Parameters.AddWithValue("@IdFuncionario", IdFuncionario);

                        int novoId = (int)cmd.ExecuteScalar();

                        if (novoId > 0)
                        {
                            lblMensagemCadastroFuncionario.Text = $"✅ Funcionário **{nome}** cadastrado com sucesso! Novo ID: {novoId}";
                            lblMensagemCadastroFuncionario.ForeColor = Color.Green;
                            txtNomeFunc.Text = "";
                            txtSenhaFunc.Text = "";
                            txtCargoFunc.Text = "";
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

                    const string query = @"
                        SELECT IdFuncionario, Nome, Cargo, Ativo 
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

                                // Proteção para evitar que o Gerente logado se desative
                                if (Session["FuncionarioId"] != null && (int)Session["FuncionarioId"] == id)
                                {
                                    btnConfirmarDesativacaoFunc.Visible = false;
                                    lblMensagemDesativarFuncionario.Text = "Você não pode desativar sua própria conta de funcionário.";
                                    lblMensagemDesativarFuncionario.ForeColor = System.Drawing.Color.Red;
                                }
                            }
                            else
                            {
                                lblMensagemDesativarFuncionario.Text = $"Funcionário {termoBusca} não encontrado.";
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
                        // Busca por ID
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
                        // Busca por Nome (não case-sensitive)
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
                        WHERE IdFuncionario = @id AND Ativo = 1"; //

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
