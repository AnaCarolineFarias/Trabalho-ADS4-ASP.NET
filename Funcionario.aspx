<%@ Page Title="Login Funcionário" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LoginFunc.aspx.cs" Inherits="PluxeePetADS4.Funcionario.LoginFuncionario" EnableEventValidation="false"%>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        /* CSS REPLICADO DO CLIENTE.ASPX */
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

        /* === REGRAS CORRIGIDAS PARA O LOGIN HORIZONTAL (LABEL AO LADO DO CAMPO) === */
        #pnlLoginFuncionario
        {
            max-width: 400px; /* Limita a largura do formulário de login */
            margin: 0 auto; /* Centraliza o bloco de login dentro do container maior */
            text-align: center; /* Centraliza o título e o botão */
        }
        
        /* Aplica Flexbox para alinhamento horizontal (Label e Input lado a lado) */
        #pnlLoginFuncionario .form-group 
        {
            text-align: left;
            display: flex; /* CHAVE: Habilita o alinhamento horizontal */
            align-items: center; /* Centraliza verticalmente */
            margin: 15px 0;
        }

        #pnlLoginFuncionario .form-group label 
        {
            display: inline-block;
            width: 120px; /* Largura fixa para o label */
            text-align: right; /* Alinha o texto do label perto do input */
            margin-right: 15px; /* Espaço entre o label e o input */
            margin-bottom: 0; /* Essencial para evitar quebra de linha */
            color: #2d3436; /* Mantém a cor do texto do label */
        }

        /* Garante que o input utilize o restante do espaço */
        #pnlLoginFuncionario .form-group input,
        #pnlLoginFuncionario .form-group select
        {
            /* CHAVE: Usa calc para garantir que o input preencha o espaço restante */
            width: calc(100% - 135px); /* 100% - largura da label (120px) - margem (15px) */
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #ccc;
            box-sizing: border-box;
            display: block;
        }
        
        /* O botão Entrar deve ter 100% da largura do painel de login */
        #pnlLoginFuncionario .btn-primary 
        {
            width: 100%;
            margin-top: 25px; 
        }
        /* === FIM DAS REGRAS CORRIGIDAS === */

        /* Estilo para painéis de conteúdo como pnlAgenda e pnlCadastroCliente */
        #pnlAgenda, #pnlCadastroCliente, #pnlOpcoesFuncionario 
        {
            max-width: 800px; /* Alarga um pouco para a agenda e cadastro */
            margin: 0 auto;
        }


        #lblMensagem
        {
            text-align:center;
            font-weight: bold;
            color: #2d3436;
            margin-top: 20px;
            display: block; /* Garante que a mensagem ocupe sua própria linha */
        }

        h2
        {
            color: #2d3436;
            font-weight: bold;
            margin-bottom: 20px;
        }

        /* Botões gerais */
        .btn
        {
            padding: 10px 22px;
            border-radius: 8px;
            border: none;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
            margin: 5px; /* Margem entre botões */
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

        /* Regras genéricas para form-group (usadas fora do pnlLoginFuncionario) */
        .form-group {
            margin: 15px 0;
            text-align: left; /* Ajustado para left, pois center estava causando problemas */
        }

        /* Labels genéricas (sobrescritas no pnlLoginFuncionario, mas aplicadas no pnlCadastroCliente) */
        .form-group label
        {
            display: block;
            margin-bottom: 5px;
            color: #2d3436;
        }

        /* Inputs genéricos (sobrescritas no pnlLoginFuncionario, mas aplicadas no pnlCadastroCliente) */
        .form-group input, .form-group select
        {
            width: 100%;
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        /* Estilo para os cartões de opção */
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

        .consultas { color: #0984e3; } /* Cor para agenda */
        .cadastro { color: #00b894; } /* Cor para cadastro */
        .logout { color: #e84393; } /* Cor para sair */

        .option-card h3
        {
            color: #2d3436;
        }

        /* Ajustes para inputs dentro de pnlCadastroCliente (PODE SER SIMPLIFICADO AGORA) */
        #pnlCadastroCliente .form-group input {
            width: 100%; /* Ajusta para preencher o painel de cadastro */
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        #lblMensagem
        {
            text-align:center;
           font-weight: bold;
           color: #2d3436; /* Cor atual da label no seu CSS */
           margin-top: 20px;
           display: block;
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

        <%-- NOVO Painel de Opções do Funcionário (Visível após login) --%>
        <asp:Panel ID="pnlOpcoesFuncionario" runat="server" Visible="false">
            <asp:Label ID="lblMensagemFuncionarioBoasVindas" runat="server" CssClass="d-block" Style="margin-bottom: 20px; font-size: 1.2em;"></asp:Label>
            <p>Selecione uma das opções abaixo:</p>

            <div class="options-grid">
                
                <%-- CARD 1: Gerenciar Agenda (CORRIGIDO PARA CLICAR) --%>
                <div class="option-card" onclick="<%= Page.ClientScript.GetPostBackEventReference(btnGerenciarAgenda, string.Empty) %>">
                    <div class="option-icon consultas">📅</div>
                    <h3>Gerenciar Agenda</h3>
                    <p>Visualize e organize os agendamentos.</p>
                </div>

                <%-- CARD 2: Cadastrar Clientes (CORRIGIDO PARA CLICAR) --%>
                <div class="option-card" onclick="<%= Page.ClientScript.GetPostBackEventReference(btnCadastrarCliente, string.Empty) %>">
                    <div class="option-icon cadastro">👥</div>
                    <h3>Cadastrar Clientes</h3>
                    <p>Registre novos clientes no sistema.</p>
                </div>

                <%-- CARD 3: Sair (CORRIGIDO PARA CLICAR) --%>
                <div class="option-card" onclick="<%= Page.ClientScript.GetPostBackEventReference(btnSair, string.Empty) %>">
                    <div class="option-icon logout">🚪</div>
                    <h3>Sair</h3>
                    <p>Encerre sua sessão administrativa.</p>
                </div>
            </div>

            <%-- Botões ASP.NET (ocultos) que serão disparados pelo PostBack dos cards --%>
            <asp:Button ID="btnGerenciarAgenda" runat="server" OnClick="btnGerenciarAgenda_Click" Visible="false" />
            <asp:Button ID="btnCadastrarCliente" runat="server" OnClick="btnCadastrarCliente_Click" Visible="false" />
            <asp:Button ID="btnSair" runat="server" OnClick="btnSair_Click" Visible="false" />
        </asp:Panel>

        <%-- Painel da Agenda de Consultas (Visível quando selecionado em opções) --%>
        <asp:Panel ID="pnlAgenda" runat="server" Visible="false">
            <h2>Agenda de Consultas</h2>
            <asp:Label ID="lblAgendaConsultas" runat="server" Text="Carregando agenda..."></asp:Label>
            
            <div class="text-center mt-4">
                <asp:Button ID="btnVoltarAgenda" runat="server" Text="Voltar às Opções" CssClass="btn btn-secondary" OnClick="btnVoltarOpcoes_Click" />
            </div>
        </asp:Panel>

        <%-- NOVO Painel de Cadastro de Clientes --%>
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
                <asp:Label ID="lblIdadeCliente" runat="server" Text="Idade:"></asp:Label>
                <asp:TextBox ID="txtIdadeCliente" runat="server" TextMode="Number" CssClass="form-control"></asp:TextBox>
            </div>
            
            <div class="text-center mt-4">
                <asp:Button ID="btnSalvarCliente" runat="server" Text="Cadastrar Cliente" CssClass="btn btn-primary" OnClick="btnSalvarCliente_Click" />
                <asp:Button ID="btnVoltarCadastro" runat="server" Text="Voltar às Opções" CssClass="btn btn-secondary" OnClick="btnVoltarOpcoes_Click" />
            </div>
            <asp:Label ID="lblMensagemCadastroCliente" runat="server" CssClass="d-block mt-3"></asp:Label>
        </asp:Panel>


        <asp:Label ID="lblMensagem" runat="server"></asp:Label>

    </div>
</asp:Content>
