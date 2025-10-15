<%@ Page Title="Área do Cliente" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cliente.aspx.cs" Inherits="PluxeePetADS4.Cliente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 30px;
            border-radius: 10px;
            background: #f5f6fa;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        h2 {
            color: #2d3436;
        }
        .form-group {
            margin: 15px 0;
            text-align: left;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input {
            width: 100%;
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        .btn {
            background-color: #6c5ce7;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #341f97;
        }
        #agendamentoDiv {
            display: none;
        }
        #lblMensagem {
            margin-top: 15px;
            font-weight: bold;
        }
    </style>

    <script src="https://accounts.google.com/gsi/client "async="async" defer="defer"> </script>

    <script>

    function handleCredentialResponse(response) {
        const base64Url = response.credential.split('.')[1];
        const base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
        const jsonPayload = decodeURIComponent(atob(base64).split('').map(function(c) {
            return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
        }).join(''));

        const user = JSON.parse(jsonPayload);

        // Mostrar nome do usuário e esconder login tradicional
        document.getElementById('<%= loginDiv.ClientID %>').style.display = 'none';
        document.getElementById('userInfo').innerHTML = `
            <p>Olá, ${user.name}!</p>
            <p>Email: ${user.email}</p>
            <img src="${user.picture}" width="100" />
        `;

        // Aqui você poderia enviar o token para o servidor se quiser criar sessão
        console.log(response.credential);
    }
    </script>

    <div class="container">
        <h2>Área do Cliente</h2>

        <!-- Login / Cadastro -->
        <asp:Panel ID="loginDiv" runat="server">
            <p>Faça login ou crie sua conta:</p>

            <div class="form-group">
                <asp:Label ID="lblUsuario" runat="server" Text="Usuário:"></asp:Label>
                <asp:TextBox ID="txtUsuario" runat="server"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Label ID="lblSenha" runat="server" Text="Senha:"></asp:Label>
                <asp:TextBox ID="txtSenha" runat="server" TextMode="Password"></asp:TextBox>
            </div>

            <asp:Button ID="btnLogin" runat="server" CssClass="btn" Text="Login" OnClick="btnLogin_Click" />
            <asp:Button ID="btnCriarConta" runat="server" CssClass="btn" Text="Criar Conta" OnClick="btnCriarConta_Click" />
            <p>Ou faça login com sua conta Google:</p>

            <div id="g_id_onload"
             data-client_id="866618764985-tv0vv5qchbd5m87msi591ufb2vvr8ksi.apps.googleusercontent.com"
             data-callback="handleCredentialResponse"
             data-auto_prompt="false">
            </div>

            <div class="g_id_signin"
            data-type="standard"
             data-shape="rectangular"
             data-theme="outline"
             data-text="sign_in_with"
             data-size="large">
            </div>

           </asp:Panel>

        <!-- Agendamento -->
        <asp:Panel ID="agendamentoDiv" runat="server">
            <p>Agende uma consulta para o seu pet:</p>

            <div class="form-group">
                <asp:Label ID="lblPet" runat="server" Text="Nome do Pet:"></asp:Label>
                <asp:TextBox ID="txtPet" runat="server"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Label ID="lblData" runat="server" Text="Data da Consulta:"></asp:Label>
                <asp:TextBox ID="txtData" runat="server" TextMode="Date"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Label ID="lblHora" runat="server" Text="Horário:"></asp:Label>
                <asp:TextBox ID="txtHora" runat="server" TextMode="Time"></asp:TextBox>
            </div>
            <asp:Button ID="btnAgendar" runat="server" CssClass="btn" Text="Agendar Consulta" OnClick="btnAgendar_Click" />
        </asp:Panel>

        <asp:Label ID="lblMensagem" runat="server" ForeColor="Green"></asp:Label>
    </div>
</asp:Content>
