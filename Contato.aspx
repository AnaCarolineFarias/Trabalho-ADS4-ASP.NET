<%@ Page Title="Contato" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contato.aspx.cs" Inherits="PluxeePetADS4.ContatoAba.Contato" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

        <p style="text-align:center; font-size:1.1rem; margin-bottom:40px;">
            Entre em contato conosco! Estamos prontos para cuidar do seu pet com atenção e carinho.
        </p>

        <section style="display:flex; justify-content: space-between; flex-wrap:wrap; gap:30px;">

            <!-- Cartão Endereço -->
            <div style="flex:1; min-width:250px; background:#EDF2F7; padding:25px; border-radius:12px; box-shadow:0 4px 8px rgba(0,0,0,0.1); text-align:center;">
                <img src="https://cdn-icons-png.flaticon.com/512/684/684908.png" alt="Localização" style="width:50px; margin-bottom:15px;"/>
                <h3>Localização</h3>
                <p>Rua: José Guerreiro<br/>Bairro: J.S Carvalho<br/>N°: 164</p>
            </div>

            <!-- Cartão Contato -->
            <div style="flex:1; min-width:250px; background:#EDF2F7; padding:25px; border-radius:12px; box-shadow:0 4px 8px rgba(0,0,0,0.1); text-align:center;">
                <asp:Image ID="imgEmail" runat="server" ImageUrl="~/imagens/gmail.png" AlternateText="Icone Gmail" style="width:50px; margin-bottom:15px;" />
                <h3>E-mails</h3>
                <p><strong>Suporte:</strong> <a href="mailto:Suporte@PluxeePet.com" style="color:#2B6CB0; text-decoration:none;">Suporte@PluxeePet.com</a><br/>
                   <strong>Marketing:</strong> <a href="mailto:Marketing@PluxeePet.com" style="color:#2B6CB0; text-decoration:none;">Marketing@PluxeePet.com</a></p>
            </div>

            <!-- Cartão Telefone -->
            <div style="flex:1; min-width:250px; background:#EDF2F7; padding:25px; border-radius:12px; box-shadow:0 4px 8px rgba(0,0,0,0.1); text-align:center;">
                <asp:Image ID="imgTel" runat="server" ImageUrl="~/imagens/telefone.png" AlternateText="Icone Tel" style="width:50px; margin-bottom:15px;" />
                <h3>Telefone</h3>
                <p>+55 15 996685625</p>
            </div>
        </section>

        <!-- Formulário -->
        <section style="margin-top:50px;">
            <h3 style="text-align:center; margin-bottom:20px;">Envie uma Mensagem</h3>
            <asp:TextBox ID="txtNome" runat="server" CssClass="input-field" Placeholder="Seu Nome" />
            <asp:TextBox ID="txtEmail" runat="server" CssClass="input-field" Placeholder="Seu E-mail" TextMode="Email" />
            <asp:TextBox ID="txtMensagem" runat="server" CssClass="input-field" TextMode="MultiLine" Rows="5" Placeholder="Sua Mensagem" />
            <asp:Button ID="btnEnviar" runat="server" Text="Enviar Mensagem" CssClass="btn-send" OnClick="btnEnviar_Click" />
        </section>

        <style>
        .input-field 
        {
            padding: 12px 15px;
            border-radius: 8px;
            border: 1px solid #CBD5E0;
            font-size: 1rem;
            width: 100%;
            max-width: 600px; /* limita a largura */
            margin: 10px auto; /* centraliza e dá espaçamento vertical */
            display: block;
            box-sizing: border-box;
        }

        .input-field:focus 
        {
        border-color: #2B6CB0;
        outline: none;
        box-shadow: 0 0 0 2px rgba(43,108,176,0.2);
        }

        .btn-send 
        {
            padding: 10px 25px; /* menor tamanho */
            background-color: #2B6CB0;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            cursor: pointer;
            transition: background 0.3s ease;
            margin: 15px auto 0; /* espaçamento do campo acima e centralizado */
            display: block;
        }

        .btn-send:hover 
        {
            background-color: #1A4D8C;
        }
        </style>
</asp:Content>
