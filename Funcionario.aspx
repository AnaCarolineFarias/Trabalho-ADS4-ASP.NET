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
        #pnlAgenda, #pnlCadastroCliente, #pnlCadastroFuncionario, #pnlDesativarFuncionario, #pnlDesativarCliente, #pnlOpcoesFuncionario 
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
       
        /* Botão de Desativar */
        .btn-danger {
             background-color: #e74c3c;
             color: #fff;
        }
        .btn-danger:hover {
             background-color: #c0392b;
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
        .funcionarios { color: #8e44ad; } /* NOVA COR para Funcionário */

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

        .options-grid-gerente 
        {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 25px;
            margin-top: 20px;
            margin-bottom: 40px; /* Adiciona espaço abaixo do bloco Gerente */
            padding: 20px; /* Adiciona padding para o bloco Gerente não parecer 'grudado' */
            border-radius: 15px;
            border: 1px solid #dfe6e9; /* Borda sutil para diferenciar o bloco */
        }

        .admin-card 
        {
            background: #eaf1ff; /* Um azul claro suave */
        }

        .admin-card:hover 
        {
            background: #d4e3ff; 
        }
       
        /* Estilo para o campo de busca (Desativar Funcionário/Cliente) */
        .search-group {
            display: flex;
            align-items: center; /* Alinha verticalmente label, input e botão */
            gap: 10px;
            margin-bottom: 20px;
        }
       
        /* A Label da busca deve ter uma largura definida para alinhamento */
        #pnlDesativarFuncionario .search-group label,
        #pnlDesativarCliente .search-group label {
            display: block;
            margin-bottom: 0;
            width: 100px; /* Ajuste a largura do label conforme necessário */
            text-align: right;
        }

        .search-group input {
            flex-grow: 1;
            width: auto; /* Sobrescreve a largura de 100% dos inputs genéricos */
        }
       
        .funcionario-details, .cliente-details {
            margin-top: 20px;
            border: 1px solid #ccc;
            padding: 15px;
            border-radius: 8px;
            text-align: left;
        }
       
        /* --- NOVO ESTILO PARA O GRIDVIEW DE FUNCIONÁRIOS --- */
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
            background-color: #f5f6fa; /* Fundo levemente cinza para linhas pares */
        }

        /* Oculta os detalhes que só aparecem após a busca individual (se a tabela estiver visível) */
        /* #pnlDetalhesFuncionario, #pnlDetalhesCliente {
             display: none; /* Inicia oculto e só é exibido via code-behind após busca por ID */
        /* } */
       
        .gridview-header {
            font-size: 1.1em;
            font-weight: bold;
            margin-top: 30px;
            margin-bottom: 10px;
            color: #2d3436;
            text-align: left;
        }
       
        /* Ajuste para o botão de Desativar dentro do GridView */
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

                    <%-- CARD G2: Verificar Consultas no Sistema --%>
                    <div class="option-card admin-card" onclick="<%= Page.ClientScript.GetPostBackEventReference(btnVerificarConsultasSistema, string.Empty) %>">
                        <div class="option-icon" style="color: #3498db;">📊</div>
                        <h3>Consultas Sistema</h3>
                        <p>Ver todos os agendamentos.</p>
                    </div>

                    <%-- CARD G3: Desativar Funcionários --%>
                    <div class="option-card admin-card" onclick="<%= Page.ClientScript.GetPostBackEventReference(btnDesativarFuncionario, string.Empty) %>">
                        <div class="option-icon" style="color: #e74c3c;">🚫</div>
                        <h3>Desativar Funcionário</h3>
                        <p>Suspender acesso de colaborador.</p>
                    </div>
                   
                    <%-- CARD G4: Desativar Clientes --%>
                    <div class="option-card admin-card" onclick="<%= Page.ClientScript.GetPostBackEventReference(btnDesativarCliente, string.Empty) %>">
                        <div class="option-icon" style="color: #95a5a6;">❌</div>
                        <h3>Desativar Cliente</h3>
                        <p>Bloquear acesso de cliente.</p>
                    </div>

                </div>
            </asp:Panel>

            <%-- Botões ASP.NET (ocultos) que serão disparados pelo PostBack dos cards --%>
            <asp:Button ID="btnGerenciarAgenda" runat="server" OnClick="btnGerenciarAgenda_Click" Visible="false" />
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
                <asp:Label ID="lblIdadeCliente" runat="server" Text="Idade:"></asp:Label>
                <asp:TextBox ID="txtIdadeCliente" runat="server" TextMode="Number" CssClass="form-control"></asp:TextBox>
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
                <asp:Label ID="lblSenhaFunc" runat="server" Text="Senha Inicial:"></asp:Label>
                <asp:TextBox ID="txtSenhaFunc" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblCargoFunc" runat="server" Text="Cargo/ID Cargo (Ex: 1-Veterinário, 4-Gerente):"></asp:Label>
                <asp:TextBox ID="txtCargoFunc" runat="server" TextMode="Number" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="text-center mt-4">
                <asp:Button ID="btnSalvarFuncionario" runat="server" Text="Cadastrar Funcionário" CssClass="btn btn-primary" OnClick="btnSalvarFuncionario_Click" />
                <asp:Button ID="btnVoltarCadastroFunc" runat="server" Text="Voltar às Opções" CssClass="btn btn-secondary" OnClick="btnVoltarOpcoes_Click" />
            </div>

            <asp:Label ID="lblMensagemCadastroFuncionario" runat="server" CssClass="d-block mt-3"></asp:Label>
        </asp:Panel>
       
        <%-- Painel de Desativação de Funcionário (CORRIGIDO com pnlDetalhesFuncionario e Labels) --%>
        <asp:Panel ID="pnlDesativarFuncionario" runat="server" Visible="false" Style="max-width: 800px; margin: 0 auto; text-align: left;">
            <h2>🚫 Desativar Funcionário</h2>
            <p>Pesquise o funcionário por nome ou ID, ou selecione na lista abaixo.</p>

            <%-- Área de Busca (Por Nome ou ID) --%>
            <div class="search-group">
                <asp:Label ID="lblBuscarFunc" runat="server" Text="Nome ou ID:"></asp:Label>
                <asp:TextBox ID="txtBuscarFunc" runat="server" CssClass="form-control" placeholder="Digite o nome ou ID do funcionário"></asp:TextBox>
                <asp:Button ID="btnBuscarFuncionario" runat="server" Text="🔍 Buscar" CssClass="btn btn-secondary" OnClick="btnBuscarFuncionario_Click" />
            </div>
           
            <asp:Label ID="lblMensagemDesativarFuncionario" runat="server" CssClass="d-block mt-3"></asp:Label>

            <%-- Detalhes do Funcionário (Adicionado para resolver erros) --%>
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
       
        <%-- Painel de Desativação de Cliente (CORRIGIDO com lblClienteUsuario) --%>
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
           
            <%-- Detalhes do Cliente (Inicia oculto, aparece após busca) --%>
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
