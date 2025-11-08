<%@ Page Title="Login Funcionário" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LoginFunc.aspx.cs" Inherits="PluxeePetADS4.Funcionario.LoginFuncionario" EnableEventValidation="false"%>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        body
        {
            background-color: #f5f6fa;
        }

        .container
        {
            max-width: 900px;
            margin: 60px auto;
            padding: 40px;
            border-radius: 15px;
            background: #fff;
            box-shadow: 0 4px 25px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        #pnlLoginFuncionario
        {
            max-width: 400px; 
            margin: 0 auto; 
            text-align: center; 
        }
       
        #pnlLoginFuncionario .form-group 
        {
            text-align: left;
            display: flex; 
            align-items: center; 
            margin: 15px 0;
        }

        #pnlLoginFuncionario .form-group label 
        {
            display: inline-block;
            width: 120px; 
            text-align: right; 
            margin-right: 15px; 
            margin-bottom: 0; 
            color: #2d3436; 
        }

        #pnlLoginFuncionario .form-group input,
        #pnlLoginFuncionario .form-group select
        {
            width: calc(100% - 135px); 
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #ccc;
            box-sizing: border-box;
            display: block;
        }
       
        #pnlLoginFuncionario .btn-primary 
        {
            width: 100%;
            margin-top: 25px; 
        }

        #pnlAgenda, #pnlCadastroCliente, #pnlCadastroFuncionario, #pnlDesativarFuncionario, #pnlDesativarCliente, #pnlOpcoesFuncionario 
        {
            max-width: 800px; 
            margin: 0 auto;
        }


        #lblMensagem
        {
            text-align:center;
            font-weight: bold;
            color: #2d3436;
            margin-top: 20px;
            display: block;
        }

        h2
        {
            color: #2d3436;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .btn
        {
            padding: 10px 22px;
            border-radius: 8px;
            border: none;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
            margin: 5px; 
        }

        .btn-primary
        {
            background-color: #6c5ce7;
            color: #fff;
        }

        .btn-primary:hover {
            background-color: #341f97;
        }

        .btn-secondary
        {
            background-color: #b2bec3;
            color: #2d3436;
        }

        .btn-secondary:hover
        {
            background-color: #636e72;
            color: #fff;
        }
       
        .btn-danger {
             background-color: #e74c3c;
             color: #fff;
        }
        .btn-danger:hover {
             background-color: #c0392b;
        }

        .form-group {
            margin: 15px 0;
            text-align: left; 
        }

        .form-group label
        {
            display: block;
            margin-bottom: 5px;
            color: #2d3436;
        }

        .form-group input, .form-group select
        {
            width: 100%;
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        .options-grid
        {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }

        .option-card
        {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .option-card:hover
        {
            transform: translateY(-5px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
        }

        .option-icon
        {
            font-size: 50px;
            margin-bottom: 15px;
        }

        .consultas { color: #0984e3; } 
        .cadastro { color: #00b894; } 
        .logout { color: #e84393; } 
        .funcionarios { color: #8e44ad; } 

        .option-card h3
        {
            color: #2d3436;
        }

        #pnlCadastroCliente .form-group input {
            width: 100%; 
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        #lblMensagem
        {
            text-align:center;
            font-weight: bold;
            color: #2d3436; 
            margin-top: 20px;
            display: block;
        }

        .options-grid-gerente 
        {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 25px;
            margin-top: 20px;
            margin-bottom: 40px; 
            padding: 20px; 
            border-radius: 15px;
            border: 1px solid #dfe6e9; 
        }

        .admin-card 
        {
            background: #eaf1ff; 
        }

        .admin-card:hover 
        {
            background: #d4e3ff; 
        }
       
        .search-group {
            display: flex;
            align-items: center; 
            gap: 10px;
            margin-bottom: 20px;
        }
       
        #pnlDesativarFuncionario .search-group label,
        #pnlDesativarCliente .search-group label {
            display: block;
            margin-bottom: 0;
            width: 100px; 
            text-align: right;
        }

        .search-group input {
            flex-grow: 1;
            width: auto; 
        }
       
        .funcionario-details, .cliente-details {
            margin-top: 20px;
            border: 1px solid #ccc;
            padding: 15px;
            border-radius: 8px;
            text-align: left;
        }
       
        .funcionario-grid, .cliente-grid {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .funcionario-grid th, .cliente-grid th {
            background-color: #6c5ce7;
            color: #fff;
            padding: 12px;
            text-align: left;
            font-weight: bold;
            border: 1px solid #5444b0;
        }

        .funcionario-grid td, .cliente-grid td {
            padding: 10px 12px;
            border: 1px solid #dfe6e9;
            text-align: left;
            background-color: #fff;
        }

        .funcionario-grid tr:nth-child(even) td, .cliente-grid tr:nth-child(even) td {
            background-color: #f5f6fa; 
        }

        .gridview-header {
            font-size: 1.1em;
            font-weight: bold;
            margin-top: 30px;
            margin-bottom: 10px;
            color: #2d3436;
            text-align: left;
        }
       
        .gridview-desativar-btn {
            padding: 5px 10px;
            font-size: 14px;
        }

    </style>

    <div class="container">

        <%-- Painel de Login do Funcionário (Visível por padrão, oculto após login) --%>
        <asp:Panel ID="pnlLoginFuncionario" runat="server">
            <h2>Login Funcionário</h2>
            <p>Insira seu ID e senha para acessar a área administrativa.</p>

            <div class="form-group">
                <asp:Label ID="lblFuncionarioId" runat="server" Text="ID Funcionário:"></asp:Label>
                <asp:TextBox ID="txtFuncionarioId" runat="server"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblSenha" runat="server" Text="Senha:"></asp:Label>
                <asp:TextBox ID="txtSenha" runat="server" TextMode="Password"></asp:TextBox>
            </div>

            <asp:Button ID="btnEntrar" runat="server" CssClass="btn btn-primary" Text="Entrar" OnClick="btnEntrar_Click" />
        </asp:Panel>

        <%-- Painel de Opções do Funcionário (Visível após login) --%>
        <asp:Panel ID="pnlOpcoesFuncionario" runat="server" Visible="false">
            <asp:Label ID="lblMensagemFuncionarioBoasVindas" runat="server" CssClass="d-block" Style="margin-bottom: 20px; font-size: 1.2em;"></asp:Label>
            <p>Selecione uma das opções abaixo:</p>

            <div class="options-grid">
               
                <%-- CARD 1: Gerenciar Agenda --%>
                <div class="option-card" onclick="<%= Page.ClientScript.GetPostBackEventReference(btnGerenciarAgenda, string.Empty) %>">
                    <div class="option-icon consultas">📅</div>
                    <h3>Gerenciar Agenda</h3>
                    <p>Visualize e organize os agendamentos.</p>
                </div>

                <%-- CARD 2: Cadastrar Clientes --%>
                <div class="option-card" onclick="<%= Page.ClientScript.GetPostBackEventReference(btnCadastrarCliente, string.Empty) %>">
                    <div class="option-icon cadastro">👥</div>
                    <h3>Cadastrar Clientes</h3>
                    <p>Registre novos clientes no sistema.</p>
                </div>

                <%-- CARD 3: Sair --%>
                <div class="option-card" onclick="<%= Page.ClientScript.GetPostBackEventReference(btnSair, string.Empty) %>">
                    <div class="option-icon logout">🚪</div>
                    <h3>Sair</h3>
                    <p>Encerre sua sessão administrativa.</p>
                </div>
            </div>

            <%-- Painel de Opções de Gerente (APENAS ID 4) --%>
            <asp:Panel ID="pnlOpcoesGerente" runat="server" Visible="false">
                <h3 style="margin-top: 40px; color: #6c5ce7;">🚀 Opções de Gerenciamento</h3>
                <p>Ações administrativas exclusivas.</p>

                <div class="options-grid-gerente">
                   
                    <%-- CARD G1: Cadastrar Funcionário --%>
                    <div class="option-card admin-card" onclick="<%= Page.ClientScript.GetPostBackEventReference(btnCadastrarFuncionario, string.Empty) %>">
                        <div class="option-icon funcionarios">👩‍💼</div>
                        <h3>Cadastrar Funcionário</h3>
                        <p>Registre novos colaboradores.</p>
                    </div>

                    <%-- CARD G2: EDITAR PERFIL DO FUNCIONÁRIO --%>
                <div class="option-card admin-card" onclick="<%= Page.ClientScript.GetPostBackEventReference(btnAcessarEdicaoFuncionario, string.Empty) %>">
                    <div class="option-icon" style="color: #f39c12;">✍️</div>
                    <h3>Editar Funcionário</h3>
                    <p>Alterar dados do colaborador.</p>
                </div>

                    <%-- CARD G3: EDITAR PERFIL DO CLIENTE --%>
                 <div class="option-card admin-card" onclick="<%= Page.ClientScript.GetPostBackEventReference(btnAcessarEdicaoCliente, string.Empty) %>">
                    <div class="option-icon" style="color: #6c5ce7;">📝</div>
                    <h3>Editar Cliente</h3>
                    <p>Alterar dados cadastrais de um cliente.</p>
                </div>

                    <%-- CARD G3: Verificar Consultas no Sistema --%>
                    <div class="option-card admin-card" onclick="<%= Page.ClientScript.GetPostBackEventReference(btnVerificarConsultasSistema, string.Empty) %>">
                        <div class="option-icon" style="color: #3498db;">📊</div>
                        <h3>Consultas Sistema</h3>
                        <p>Ver todos os agendamentos.</p>
                    </div>

                    <%-- CARD G4: Desativar Funcionários --%>
                    <div class="option-card admin-card" onclick="<%= Page.ClientScript.GetPostBackEventReference(btnDesativarFuncionario, string.Empty) %>">
                        <div class="option-icon" style="color: #e74c3c;">🚫</div>
                        <h3>Desativar Funcionário</h3>
                        <p>Suspender acesso de colaborador.</p>
                    </div>
                   
                    <%-- CARD G5: Desativar Clientes --%>
                    <div class="option-card admin-card" onclick="<%= Page.ClientScript.GetPostBackEventReference(btnDesativarCliente, string.Empty) %>">
                        <div class="option-icon" style="color: #95a5a6;">❌</div>
                        <h3>Desativar Cliente</h3>
                        <p>Bloquear acesso de cliente.</p>
                    </div>

                </div>

            </asp:Panel>

            <%-- Botões ASP.NET (ocultos) que serão disparados pelo PostBack dos cards --%>
            <asp:Button ID="btnGerenciarAgenda" runat="server" OnClick="btnGerenciarAgenda_Click" Visible="false" />
            <asp:Button ID="btnAcessarEdicaoFuncionario" runat="server" OnClick="btnAcessarEdicaoFuncionario_Click" Visible="false" />
            <asp:Button ID="btnAcessarEdicaoCliente" runat="server" OnClick="btnAcessarEdicaoCliente_Click" Visible="false" />
            <asp:Button ID="btnCadastrarCliente" runat="server" OnClick="btnCadastrarCliente_Click" Visible="false" />
            <asp:Button ID="btnSair" runat="server" OnClick="btnSair_Click" Visible="false" />
            <asp:Button ID="btnCadastrarFuncionario" runat="server" OnClick="btnCadastrarFuncionario_Click" Visible="false" />
            <asp:Button ID="btnVerificarConsultasSistema" runat="server" OnClick="btnVerificarConsultasSistema_Click" Visible="false" />
            <asp:Button ID="btnDesativarFuncionario" runat="server" OnClick="btnDesativarFuncionario_Click" Visible="false" />
            <asp:Button ID="btnDesativarCliente" runat="server" OnClick="btnDesativarCliente_Click" Visible="false" />
        </asp:Panel>

        <%-- Painel da Agenda de Consultas --%>
        <asp:Panel ID="pnlAgenda" runat="server" Visible="false">
            <h2>Agenda de Consultas</h2>
            <asp:Label ID="lblAgendaConsultas" runat="server" Text="Carregando agenda..."></asp:Label>
           
            <div class="text-center mt-4">
                <asp:Button ID="btnVoltarAgenda" runat="server" Text="Voltar às Opções" CssClass="btn btn-secondary" OnClick="btnVoltarOpcoes_Click" />
            </div>
        </asp:Panel>

        <%-- Painel de Cadastro de Clientes --%>
        <asp:Panel ID="pnlCadastroCliente" runat="server" Visible="false" Style="max-width: 500px; margin: 0 auto; text-align: left;">
            <h2>Cadastrar Novo Cliente</h2>
            <p>Preencha os dados do novo cliente:</p>

            <div class="form-group">
                <asp:Label ID="lblNomeCliente" runat="server" Text="Nome Completo:"></asp:Label>
                <asp:TextBox ID="txtNomeCliente" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblUsuarioCliente" runat="server" Text="Usuário (login):"></asp:Label>
                <asp:TextBox ID="txtUsuarioCliente" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblSenhaCliente" runat="server" Text="Senha:"></asp:Label>
                <asp:TextBox ID="txtSenhaCliente" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblEmailCliente" runat="server" Text="E-mail:"></asp:Label>
                <asp:TextBox ID="txtEmailCliente" runat="server" TextMode="Email" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblTelefoneCliente" runat="server" Text="Telefone:"></asp:Label>
                <asp:TextBox ID="txtTelefoneCliente" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblEnderecoCliente" runat="server" Text="Endereço:"></asp:Label>
                <asp:TextBox ID="txtEnderecoCliente" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblIdadeCliente" runat="server" Text="Data de Nascimento:"></asp:Label>
                <asp:TextBox ID="txtIdadeCliente" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
            </div>
           
            <div class="text-center mt-4">
                <asp:Button ID="btnSalvarCliente" runat="server" Text="Cadastrar Cliente" CssClass="btn btn-primary" OnClick="btnSalvarCliente_Click" />
                <asp:Button ID="btnVoltarCadastro" runat="server" Text="Voltar às Opções" CssClass="btn btn-secondary" OnClick="btnVoltarOpcoes_Click" />
            </div>

            <asp:Label ID="lblMensagemCadastroCliente" runat="server" CssClass="d-block mt-3"></asp:Label>
        </asp:Panel>

        <%-- Painel de Cadastro de Funcionário --%>
        <asp:Panel ID="pnlCadastroFuncionario" runat="server" Visible="false" Style="max-width: 500px; margin: 0 auto; text-align: left;">
            <h2>Cadastrar Novo Funcionário</h2>
            <p>Preencha os dados do novo colaborador:</p>

            <div class="form-group">
                <asp:Label ID="lblNomeFunc" runat="server" Text="Nome Completo:"></asp:Label>
                <asp:TextBox ID="txtNomeFunc" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblCpfFunc" runat="server" Text="CPF:"></asp:Label>
                <asp:TextBox ID="txtCpfFunc" runat="server" CssClass="form-control" MaxLength="14" placeholder="000.000.000-00"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblSenhaFunc" runat="server" Text="Senha Inicial:"></asp:Label>
                <asp:TextBox ID="txtSenhaFunc" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="text-center mt-4">
                <asp:Button ID="btnSalvarFuncionario" runat="server" Text="Cadastrar Funcionário" CssClass="btn btn-primary" OnClick="btnSalvarFuncionario_Click" />
                <asp:Button ID="btnVoltarCadastroFunc" runat="server" Text="Voltar às Opções" CssClass="btn btn-secondary" OnClick="btnVoltarOpcoes_Click" />
            </div>

            <asp:Label ID="lblMensagemCadastroFuncionario" runat="server" CssClass="d-block mt-3"></asp:Label>
        </asp:Panel>

        <asp:Panel ID="pnlEditarFuncionario" runat="server" Visible="false" Style="max-width: 600px; margin: 0 auto; text-align: left;">
    <h2>✍️ Editar Perfil de Funcionário</h2>

    <%-- 1. Pesquisa/Seleção do Funcionário --%>
    <div class="card p-3 mb-4">
        <h4 class="card-title">Buscar Funcionário para Edição</h4>
        <div class="form-group row">

            <asp:Label ID="lblFuncIdPesquisa" runat="server" Text="Nome do Funcionário:" CssClass="col-sm-4 col-form-label"></asp:Label>
            <div class="col-sm-5">
                <asp:TextBox ID="txtFuncIdPesquisa" runat="server" CssClass="form-control" placeholder="Digite o nome ou ID"></asp:TextBox>
            </div>

            <div class="col-sm-3">
                <asp:Button ID="Button1" runat="server" Text="Buscar" CssClass="btn btn-info btn-block" OnClick="btnBuscarFuncionarioParaEdicao_Click" />
            </div>

        </div>
        <asp:Label ID="lblStatusBuscaFuncionario" runat="server" CssClass="d-block mt-2"></asp:Label>
    </div>

    <%-- 2. Formulário de Edição (Inicialmente Oculto) --%>
    <asp:Panel ID="pnlFormularioEdicaoFuncionario" runat="server" Visible="false">
        <h4 style="margin-top: 20px;">Editando Funcionário ID: <asp:Label ID="lblIdFuncionarioEdicao" runat="server" Font-Bold="true"></asp:Label></h4>
        <hr/>

        <div class="form-group">
            <asp:Label ID="lblNomeEdicao" runat="server" Text="Nome Completo:"></asp:Label>
            <asp:TextBox ID="txtNomeEdicao" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        
        <div class="form-group">
            <asp:Label ID="lblCpfEdicao" runat="server" Text="CPF:"></asp:Label>
            <asp:TextBox ID="txtCpfEdicao" runat="server" CssClass="form-control" MaxLength="14"></asp:TextBox>
        </div>

        <div class="form-group">
            <asp:Label ID="lblEmailEdicao" runat="server" Text="Email:"></asp:Label>
            <asp:TextBox ID="txtEmailEdicao" runat="server" TextMode="Email" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="form-group">
            <asp:Label ID="lblTelefoneEdicao" runat="server" Text="Telefone:"></asp:Label>
            <asp:TextBox ID="txtTelefoneEdicao" runat="server" CssClass="form-control" MaxLength="20" placeholder="(99) 99999-9999"></asp:TextBox>
        </div>
        
        <div class="form-group">
            <asp:Label ID="lblDataAdmissaoEdicao" runat="server" Text="Data de Admissão:"></asp:Label>
            <asp:TextBox ID="txtDataAdmissaoEdicao" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="form-group">
            <asp:Label ID="lblNovaSenhaEdicao" runat="server" Text="Nova Senha (Deixe em branco para manter a atual):"></asp:Label>
            <asp:TextBox ID="txtNovaSenhaEdicao" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="text-center mt-4">
            <asp:Button ID="btnSalvarEdicaoFuncionario" runat="server" Text="Salvar Alterações" CssClass="btn btn-success" OnClick="btnSalvarEdicaoFuncionario_Click" />
            <asp:Button ID="btnCancelarEdicaoFuncionario" runat="server" Text="Voltar" CssClass="btn btn-secondary" OnClick="btnVoltarOpcoes_Click" />
        </div>

        <asp:Label ID="lblMensagemEdicaoFuncionario" runat="server" CssClass="d-block mt-3"></asp:Label>
    </asp:Panel>

</asp:Panel>

        <%-- Painel de Edição de Clientes (Somente Gerente) --%>
        <asp:Panel ID="pnlEditarCliente" runat="server" Visible="false" Style="max-width: 600px; margin: 0 auto; text-align: left;">
    
    <h2><span style="font-size: 1.5em;">✍️</span> Editar Perfil de Cliente</h2>

    <div class="card p-3 mb-4">
        <h4 class="card-title">Buscar Cliente para Edição</h4>
        
        <asp:Panel ID="pnlBuscaCliente" runat="server" DefaultButton="btnBuscarCliente">
            <div class="form-group row">

                <asp:Label ID="lblBuscaCliente" runat="server" Text="Nome do Cliente:" CssClass="col-sm-4 col-form-label"></asp:Label>
                <div class="col-sm-5">
                    <asp:TextBox ID="txtClienteNomeOuIdPesquisa" runat="server" CssClass="form-control" placeholder="Digite o nome ou ID"></asp:TextBox>
                </div>

                <div class="col-sm-3">
                    <asp:Button ID="btnBuscarCliente" runat="server" Text="Buscar" CssClass="btn btn-primary btn-block" OnClick="btnBuscarCliente_Click" />
                </div>
                
            </div>
        </asp:Panel>
        <asp:Label ID="lblStatusBuscaCliente" runat="server" CssClass="d-block mt-2"></asp:Label>
    </div>

    <%-- 2. Formulário de Edição (Inicialmente Oculto) --%>
    <asp:Panel ID="pnlFormularioEdicaoCliente" runat="server" Visible="false">
        <h4 style="margin-top: 20px;">Editando Cliente ID: <asp:Label ID="lblIdClienteEdicao" runat="server" FontBold="true"></asp:Label></h4>
        <hr/>

        <div class="form-group">
            <asp:Label ID="lblNomeClienteEdit" runat="server" Text="Nome Completo:"></asp:Label>
            <asp:TextBox ID="txtNomeEdicaoCliente" runat="server" CssClass="form-control" required="required"></asp:TextBox>
        </div>
        
        <div class="form-group">
            <asp:Label ID="lblEmailClienteEdit" runat="server" Text="Email:"></asp:Label>
            <asp:TextBox ID="txtEmailEdicaoCliente" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
        </div>
        
        <div class="form-group">
            <asp:Label ID="lblTelClienteEdit" runat="server" Text="Telefone:"></asp:Label>
            <asp:TextBox ID="txtTelefoneEdicaoCliente" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        
        <div class="form-group">
            <asp:Label ID="lblEnderecoClienteEdit" runat="server" Text="Endereço:"></asp:Label>
            <asp:TextBox ID="txtEnderecoEdicaoCliente" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        
        <div class="form-group">
            <asp:Label ID="lbDataNascimentoClienteEdit" runat="server" Text="Data de Nascimento:"></asp:Label>
            <asp:TextBox ID="txtDataNascimentoEdicaoCliente" runat="server" CssClass="form-control" TextMode="Date" required="required"></asp:TextBox>
        </div>

        <div class="text-center mt-4">
            <asp:Button ID="btnSalvarEdicaoCliente" runat="server" Text="Salvar Alterações" CssClass="btn btn-success" OnClick="btnSalvarEdicaoCliente_Click" />
            <asp:Button ID="btnVoltarEdicaoCliente" runat="server" Text="Voltar" CssClass="btn btn-secondary" OnClick="btnVoltarOpcoesGerente_Click" />
        </div>
        
        <asp:Label ID="lblMensagemEdicaoCliente" runat="server" CssClass="d-block mt-3"></asp:Label>

    </asp:Panel>
    
</asp:Panel>

        <%-- Painel de Desativação de Funcionário (CORRIGIDO com pnlDetalhesFuncionario e Labels) --%>
        <asp:Panel ID="pnlDesativarFuncionario" runat="server" Visible="false" Style="max-width: 800px; margin: 0 auto; text-align: left;">
            <h2>🚫 Desativar Funcionário</h2>
            <p>Pesquise o funcionário por nome ou ID.</p>

            <%-- Área de Busca (Por Nome ou ID) --%>
            <div class="search-group">
                <asp:Label ID="lblBuscarFunc" runat="server" Text="Nome ou ID:"></asp:Label>
                <asp:TextBox ID="txtBuscarFunc" runat="server" CssClass="form-control" placeholder="Digite o nome ou ID do funcionário"></asp:TextBox>
                <asp:Button ID="btnBuscarFuncionario" runat="server" Text="🔍 Buscar" CssClass="btn btn-secondary" OnClick="btnBuscarFuncionario_Click" />
            </div>
           
            <asp:Label ID="lblMensagemDesativarFuncionario" runat="server" CssClass="d-block mt-3"></asp:Label>

            <%-- Detalhes do Funcionário --%>
            <asp:Panel ID="pnlDetalhesFuncionario" runat="server" Visible="false" CssClass="funcionario-details">
                <p style="font-weight: bold; margin-bottom: 5px;">Detalhes do Funcionário:</p>
                <asp:Label ID="lblFuncionarioNome" runat="server" Style="display: block; font-weight: bold;"></asp:Label>
                <asp:Label ID="lblFuncionarioCargo" runat="server" Style="display: block;"></asp:Label>
                <asp:Label ID="lblFuncionarioStatus" runat="server" Style="display: block; margin-top: 5px;"></asp:Label>
               
                <div class="text-center mt-3">
                    <asp:Button ID="btnConfirmarDesativacaoFunc" runat="server" Text="Confirmar Desativação" CssClass="btn btn-danger" 
                        CommandArgument="0" OnClick="btnConfirmarDesativacaoFunc_Click" Visible="false" />
                </div>

            </asp:Panel>

            <%-- Tabela/Grid de Funcionários --%>
            <div class="gridview-header"></div>
            <asp:GridView ID="gvFuncionarios" runat="server"
                AutoGenerateColumns="False"
                DataKeyNames="IdFuncionario"
                CssClass="funcionario-grid"
                GridLines="None"
                OnRowCommand="gvFuncionarios_RowCommand"
                AllowPaging="True"
                PageSize="10">
                <Columns>
                    <asp:BoundField DataField="IdFuncionario" HeaderText="ID" SortExpression="IdFuncionario" ItemStyle-Width="50px" />
                    <asp:BoundField DataField="Nome" HeaderText="Nome" SortExpression="Nome" />
                    <asp:BoundField DataField="Cargo" HeaderText="Cargo" SortExpression="Cargo" ItemStyle-Width="150px" />
                    <asp:BoundField DataField="Ativo" HeaderText="Ativo" SortExpression="Ativo" ItemStyle-Width="100px" />
                    <asp:TemplateField HeaderText="Ação" ItemStyle-Width="120px">
                        <ItemTemplate>
                            <asp:Button ID="btnDesativar" runat="server" Text="Desativar" CssClass="btn btn-danger gridview-desativar-btn"
                                CommandName="DesativarFuncionario" CommandArgument='<%# Eval("IdFuncionario") %>' 
                                OnClientClick='<%# (bool)Eval("Ativo") ? "return confirm(\"Tem certeza que deseja desativar o funcionário ID: " + Eval("IdFuncionario") + "?\");" : "return false;" %>'
                                Enabled='<%# Eval("Ativo") %>' />
                            <asp:Label ID="lblInativo" runat="server" Text="Inativo" Visible='<%# !(bool)Eval("Ativo") %>' ForeColor="#e74c3c" Font-Bold="true" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
           
            <div class="text-center mt-4">
                <asp:Button ID="btnVoltarDesativarFunc" runat="server" Text="Voltar às Opções" CssClass="btn btn-secondary" OnClick="btnVoltarOpcoes_Click" />
            </div>
        </asp:Panel>
       
        <%-- Painel de Desativação de Cliente --%>
        <asp:Panel ID="pnlDesativarCliente" runat="server" Visible="false" Style="max-width: 800px; margin: 0 auto; text-align: left;">
            <h2>❌ Desativar Cliente</h2>
            <p>Pesquise o cliente por ID, ou selecione na lista abaixo.</p>

            <%-- Área de Busca de Clientes --%>
            <div class="search-group">
                <asp:Label ID="lblBuscarClienteId" runat="server" Text="Nome do cliente:"></asp:Label>
                <asp:TextBox ID="txtBuscarClienteId" runat="server" CssClass="form-control" placeholder="Digite o nome do cliente"></asp:TextBox>
                <asp:Button ID="btnBuscarClienteDesativar" runat="server" Text="🔍 Buscar" CssClass="btn btn-secondary" OnClick="btnBuscarClienteParaDesativar_Click" />
            </div>

            <asp:Label ID="lblMensagemDesativarCliente" runat="server" CssClass="d-block mt-3"></asp:Label>
           
            <%-- Detalhes do Cliente --%>
            <asp:Panel ID="pnlDetalhesCliente" runat="server" Visible="false" CssClass="cliente-details">
                <p style="font-weight: bold; margin-bottom: 5px;">Detalhes do Cliente:</p>
                <asp:Label ID="lblClienteNome" runat="server" Style="display: block; font-weight: bold;"></asp:Label>
                <asp:Label ID="lblClienteUsuario" runat="server" Style="display: block;"></asp:Label> 
                <asp:Label ID="lblClienteStatus" runat="server" Style="display: block; margin-top: 5px;"></asp:Label>
               
                <div class="text-center mt-3">
                    <asp:Button ID="btnConfirmarDesativacaoCliente" runat="server" Text="Confirmar Desativação" CssClass="btn btn-danger" 
                        CommandArgument="0" OnClick="btnConfirmarDesativacaoCliente_Click" Visible="false" />
                </div>
            </asp:Panel>

            <%-- Gridview de Clientes Ativos --%>
            <div class="gridview-header"></div>
            <asp:GridView ID="gvClientes" runat="server"
                AutoGenerateColumns="False"
                DataKeyNames="IdCliente"
                CssClass="cliente-grid"
                GridLines="None"
                OnRowCommand="gvClientes_RowCommand"
                AllowPaging="True"
                PageSize="10">
                <Columns>
                    <asp:BoundField DataField="IdCliente" HeaderText="ID" SortExpression="IdCliente" ItemStyle-Width="50px" />
                    <asp:BoundField DataField="Nome" HeaderText="Nome" SortExpression="Nome" />
                    <asp:BoundField DataField="Usuario" HeaderText="Usuário" SortExpression="Usuario" />
                    <asp:BoundField DataField="Ativo" HeaderText="Ativo" SortExpression="Ativo" ItemStyle-Width="100px" />
                    <asp:TemplateField HeaderText="Ação" ItemStyle-Width="120px">
                        <ItemTemplate>
                            <asp:Button ID="btnDesativarClienteGrid" runat="server" Text="Desativar" CssClass="btn btn-danger gridview-desativar-btn"
                                CommandName="DesativarCliente" CommandArgument='<%# Eval("IdCliente") %>' 
                                OnClientClick='<%# (bool)Eval("Ativo") ? "return confirm(\"Tem certeza que deseja desativar o cliente ID: " + Eval("IdCliente") + "?\");" : "return false;" %>'
                                Enabled='<%# Eval("Ativo") %>' />
                            <asp:Label ID="lblInativoClienteGrid" runat="server" Text="Inativo" Visible='<%# !(bool)Eval("Ativo") %>' ForeColor="#e74c3c" Font-Bold="true" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <div class="text-center mt-4">
                <asp:Button ID="btnVoltarDesativarCliente" runat="server" Text="Voltar às Opções" CssClass="btn btn-secondary" OnClick="btnVoltarOpcoes_Click" />
            </div>
        </asp:Panel>
       
        <asp:Label ID="lblMensagem" runat="server"></asp:Label>

    </div>
</asp:Content>
