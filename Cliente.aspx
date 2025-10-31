<%@ Page Title="Área do Cliente" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cliente.aspx.cs" Inherits="PluxeePetADS4.Cliente.Cliente" EnableEventValidation="false"%>

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

        #pnlLogin
        {
        max-width: 400px; /* Limita a largura do formulário de login */
        margin: 0 auto; /* Centraliza o bloco de login dentro do container maior */
        }

        /* Limita a largura dos campos de texto dentro do login para o novo max-width */
        #pnlLogin .form-group input, #pnlLogin .form-group select
        {
            width: 100%;
        }

        /* Ajusta o tamanho dos botões */
        #pnlLogin .btn
        {
        width: 100%;
        margin: 10px 0;
        }

        #lblMensagem
        {
           text-align:center;
           font-weight: bold;
           color: #2d3436;
           margin-top: 20px;
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

        .btn-outline-success
        {
            background-color: transparent;
            color: #00b894;
            border: 2px solid #00b894;
        }

        .btn-outline-success:hover
        {
            background-color: #00b894;
            color: #fff;
        }

        .btn-outline-primary
        {
            background-color: transparent;
            color: #0984e3;
            border: 2px solid #0984e3;
        }

        .btn-outline-primary:hover
        {
            background-color: #0984e3;
            color: #fff;
        }

        .btn-outline-info
        {
            background-color: transparent;
            color: #6c5ce7;
            border: 2px solid #6c5ce7;
        }

        .btn-outline-info:hover
        {
            background-color: #6c5ce7;
            color: #fff;
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
        .vacinacao { color: #e84393; }
        .banho { color: #00b894; }

        .option-card h3
        {
            color: #2d3436;
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

        .form-group input, .form-select
        {
            width: 100%;
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #ccc;
            box-sizing: border-box; /* Adicionado para consistência */
        }
        
        /* Ajuste para centralizar dropdown e textbox no painel de agendamento */
        #pnlAgendamento .form-group input, #pnlAgendamento .form-group select {
            width: 50%;
            margin-left: auto;
            margin-right: auto;
            display: block;
        }
        
        /* Corrigido para todos os form-group que usam 100% de largura por padrão */
        #pnlLogin .form-group input, #pnlLogin .form-group select,
        #pnlEditarPerfil .form-group input, #pnlEditarPerfil .form-group select
        {
             width: 100%;
             margin-left: 0;
             margin-right: 0;
             display: block;
        }

        #lblMensagem
        {
            display: block;
            margin-top: 20px;
            font-weight: bold;
            color: #2d3436;
        }

        .ocultar-via-css
        {
        display: none !important;
        }

        .password-field
        {
        padding-right: 40px !important; /* Espaço para o ícone */
        }

        .password-toggle
        {
        position: absolute; /* O FILHO é absoluto */
        top: 50%; /* Alinha o topo do ícone com 50% da altura do wrapper */
        right: 10px;
        transform: translateY(-50%); /* Move o ícone para cima em 50% da sua altura */
        cursor: pointer;
        font-size: 18px;
        color: #6c5ce7;
        user-select: none;
        pointer-events: auto; /* Garante que o clique funcione no ícone */
        z-index: 10; /* Garante que o ícone esteja acima da caixa de texto */
        }

        .password-input-wrapper
        {
        position: relative; /* O PAI é relativo */
        width: 100%;
        }

    </style>

    <div class="container">

        <!-- Painel de Login -->
       <asp:Panel ID="pnlLogin" runat="server">
    <h2>Área do Cliente</h2>
    <p>Faça login ou crie sua conta:</p>

    <div class="form-group">
        <asp:Label ID="lblUsuario" runat="server" Text="Usuário:"></asp:Label>
        <asp:TextBox ID="txtUsuario" runat="server"></asp:TextBox>
    </div>

    <div class="form-group">
        <asp:Label ID="lblSenha" runat="server" Text="Senha:"></asp:Label>
        <div class="password-input-wrapper">
            <asp:TextBox ID="txtSenha" runat="server" TextMode="Password" CssClass="password-field"></asp:TextBox>
            <span class="password-toggle" onclick="togglePasswordVisibility('<%= txtSenha.ClientID %>')">
                👁️
            </span>
        </div>
    </div>

    <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-primary" Text="Login" OnClick="btnLogin_Click" />
    <asp:Button ID="btnCriarConta" runat="server" CssClass="btn btn-secondary" Text="Criar Conta" OnClick="btnCriarConta_Click" />

</asp:Panel>

        <%-- Painel de Opções (Cartões) --%>
        <asp:Panel ID="pnlOpcoes" runat="server" Visible="false">
            <h2>Escolha um serviço</h2>
            <p>Selecione uma das opções abaixo para continuar:</p>

            <div class="options-grid">
                <%-- CARD 1: Agendar Serviço --%>
                <div class="option-card" onclick="__doPostBack('<%= btnAgendarServico.UniqueID %>', '')">
                    <div class="option-icon consultas">🩺</div>
                    <h3>Agendar Serviço</h3>
                    <p>Marque consultas, vacinas e outros serviços.</p>
                </div>

                <%-- CARD 2: Editar Perfil --%>
                <div class="option-card" onclick="__doPostBack('<%= btnEditarPerfil.UniqueID %>', '')">
                    <div class="option-icon vacinacao">👤</div>
                    <h3>Editar Perfil</h3>
                    <p>Atualize suas informações pessoais.</p>
                </div>

                <%-- CARD 3: Verificar Consultas --%>
                <div class="option-card" onclick="__doPostBack('<%= btnVerificarConsultas.UniqueID %>', '')">
                    <div class="option-icon banho">📅</div>
                    <h3>Verificar Consultas</h3>
                    <p>Veja seus agendamentos anteriores.</p>
                </div>
            </div>

            <asp:Button ID="btnAgendarServico" runat="server" OnClick="btnAgendarServico_Click" Visible="false" />
            <asp:Button ID="btnEditarPerfil" runat="server" OnClick="btnEditarPerfil_Click" Visible="false" />
            <asp:Button ID="btnVerificarConsultas" runat="server" OnClick="btnVerificarConsultas_Click" Visible="false" />
            
        </asp:Panel>

        <!-- Painel de Agendamento -->
        <asp:Panel ID="pnlAgendamento" runat="server" Visible="false" CssClass="mt-4">
            <h2>Agendar Serviço</h2>
            <p>Escolha o serviço desejado e preencha os dados:</p>

            <%-- Os campos de agendamento já estavam centralizados via CSS --%>
            <div class="form-group text-center">
                <label for="<%= ddlServico.ClientID %>">Serviço:</label>
                <asp:DropDownList ID="ddlServico" runat="server" CssClass="form-select">
                    <asp:ListItem Text="Selecione um serviço" Value="" />
                    <asp:ListItem Text="Consultas veterinárias" Value="Consultas veterinárias" />
                    <asp:ListItem Text="Vacinação" Value="Vacinação" />
                    <asp:ListItem Text="Banho e tosa" Value="Banho e tosa" />
                    <asp:ListItem Text="Cirurgias" Value="Castração" />
                    <asp:ListItem Text="Exames laboratoriais" Value="Exames laboratoriais" />
                </asp:DropDownList>
            </div>

            <div class="form-group text-center">
                <label for="<%= txtPet.ClientID %>">Nome do Pet:</label>
                <asp:TextBox ID="txtPet" runat="server" CssClass="form-control" />
            </div>

            <div class="form-group text-center">
                <label for="<%= txtData.ClientID %>">Data da Consulta:</label>
                <asp:TextBox ID="txtData" runat="server" TextMode="Date" CssClass="form-control" />
            </div>

            <div class="form-group text-center">
                <label for="<%= txtHora.ClientID %>">Horário:</label>
                <asp:TextBox ID="txtHora" runat="server" TextMode="Time" CssClass="form-control" />
            </div>

            <div class="text-center mt-4">
                <asp:Button ID="btnAgendar" runat="server" Text="Agendar Consulta" CssClass="btn btn-primary" OnClick="btnAgendar_Click" />
                <asp:Button ID="btnVoltarAgendamento" runat="server" Text="Voltar" CssClass="btn btn-secondary" OnClick="btnVoltar_Click" />
            </div>
        </asp:Panel>

        <!-- Painel de Consultas -->
        <asp:Panel ID="pnlConsultas" runat="server" Visible="false" CssClass="mt-4">
            <h2>Minhas Consultas Agendadas</h2>
            <asp:Label ID="lblListaConsultas" runat="server" Text="Nenhuma consulta encontrada."></asp:Label>
            <div class="text-center mt-3">
                <asp:Button ID="btnVoltarConsultas" runat="server" Text="Voltar" CssClass="btn btn-secondary" OnClick="btnVoltar_Click" />
            </div>
        </asp:Panel>

        <!-- Painel de Edição de Perfil -->
        <asp:Panel ID="pnlEditarPerfil" runat="server" Visible="false" CssClass="mt-4" Style="max-width: 500px; margin: 0 auto; text-align: left;">
            <h2>Editar Perfil</h2>
            <p>Atualize seus dados cadastrais (nome, telefone, endereço, etc.).</p>
            
            <div class="form-group">
                <asp:Label ID="lblNome" runat="server" Text="Nome Completo:"></asp:Label>
                <asp:TextBox ID="txtNomePerfil" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblEmail" runat="server" Text="E-mail:"></asp:Label>
                <asp:TextBox ID="txtEmailPerfil" runat="server" TextMode="Email" CssClass="form-control"></asp:TextBox>
            </div>
            
            <%-- Adicionado label para o campo Idade --%>
            <div class="form-group">
                <asp:Label ID="lblIdade" runat="server" Text="Idade:"></asp:Label>
                <asp:TextBox ID="txtIdadePerfil" runat="server" TextMode="Number" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblTelefone" runat="server" Text="Telefone:"></asp:Label>
                <asp:TextBox ID="txtTelefonePerfil" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        
            <div class="form-group">
                <asp:Label ID="lblEndereco" runat="server" Text="Endereço:"></asp:Label>
                <asp:TextBox ID="txtEnderecoPerfil" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <asp:Label ID="lblFeedbackPerfil" runat="server" CssClass="d-block mt-3"></asp:Label>
        
            <div class="text-center mt-4">
                <asp:Button ID="btnSalvarPerfil" runat="server" Text="Salvar Alterações" CssClass="btn btn-primary" OnClick="btnSalvarPerfil_Click" />
                <asp:Button ID="Button1" runat="server" Text="Voltar" CssClass="btn btn-secondary" OnClick="btnVoltar_Click" />
            </div>
        </asp:Panel>

        <asp:Label ID="lblMensagem" runat="server"></asp:Label>

        </div>

</asp:Content>
