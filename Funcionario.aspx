<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginFunc.aspx.cs" Inherits="PluxeePetADS4.Funcionario.LoginFunc" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .container {
            max-width: 400px;
            margin: 50px auto;
            padding: 30px;
            border-radius: 10px;
            background: #f5f6fa;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        h2 {
            color: #2d3436;
            margin-bottom: 20px;
        }
        .form-group { margin: 15px 0; text-align: left; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: bold; }
        .form-group input { width: 100%; padding: 8px; border-radius: 5px; border: 1px solid #ccc; }
        .btn {
            width: 100%;
            background-color: #6c5ce7;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }
        .btn:hover { background-color: #341f97; }
        #lblMensagem { margin-top: 15px; font-weight: bold; display:block; color:red; }
        #agendaDiv { margin-top:20px; }
        table { width:100%; border-collapse: collapse; margin-top:10px; }
        table, th, td { border: 1px solid #ccc; padding:8px; text-align:center; }
    </style>

    <div class="container">
        <h2>Login Funcionário</h2>

        <asp:Panel ID="loginDiv" runat="server">

            <div class="form-group">
                <asp:Label ID="lblUsuario" runat="server" Text="ID Funcionário:" AssociatedControlID="txtUsuario"></asp:Label>
                <asp:TextBox ID="txtUsuario" runat="server"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblSenha" runat="server" Text="Senha:" AssociatedControlID="txtSenha"></asp:Label>
                <asp:TextBox ID="txtSenha" runat="server" TextMode="Password"></asp:TextBox>
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="Entrar" CssClass="btn" OnClick="btnLogin_Click" />
            <asp:Label ID="lblMensagem" runat="server"></asp:Label>
        </asp:Panel>

        <asp:Panel ID="agendaDiv" runat="server" Visible="false">
            <h3>Agenda de Consultas</h3>
            <asp:GridView ID="gridAgenda" runat="server" AutoGenerateColumns="true"></asp:GridView>
        </asp:Panel>

    </div>
</asp:Content>
