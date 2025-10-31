<%@Page Title="Início" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="PluxeePetADS4.Default"%>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .banner-buttons {
            display: flex;
            justify-content: center;
            margin: 20px 0 40px 0;
            gap: 20px;
        }

        .btn-area {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 250px;
            height: 70px;
            font-size: 18px;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: 0.3s;
            color: white;
        }
        .btn-area-func {
            background-color: #6c7aa6;
        }
        .btn-area-client {
            background-color: #56c6e9;
        }
        .btn-area:hover {
            opacity: 0.9;
            transform: scale(1.05);
        }

        .about-section {
            display: flex;
            justify-content: center;
            align-items: flex-start;
            gap: 40px;
            margin: 40px auto;
            max-width: 1000px;
        }
        .about-section img {
            max-width: 350px;
            border-radius: 10px;
        }
        .about-text {
            max-width: 500px;
        }
        .about-text h2 {
            text-align: center;
            margin-bottom: 15px;
        }
        .about-text p {
            text-align: center;
            margin-bottom: 30px;
        }

        .info-cards {
            display: flex;
            justify-content: space-around;
            text-align: center;
            gap: 30px;
        }
        .info-item img {
            width: 40px;
            margin-bottom: 10px;
        }
        .info-item h3 {
            margin-bottom: 5px;
        }

    </style>

    <!-- Botões de Funcionários / Clientes -->
    <div class="banner-buttons">
        <asp:Button ID="btnFuncionario" runat="server" Text="Área de Funcionários" CssClass="btn-area btn-area-func" PostBackUrl="~/Funcionario/LoginFunc.aspx" />
        <asp:Button ID="btnCliente" runat="server" Text="Área de Clientes" CssClass="btn-area btn-area-client" PostBackUrl="~/Cliente/Cliente.aspx" />
    </div>

    <!-- Seção Quem Somos -->
    <div class="about-section">
        <!-- Imagem -->
        <asp:Image ID="imgVeterinaria" runat="server" ImageUrl="~/imagens/Veterinaria.png" AlternateText="Veterinária atendendo cachorro" />

        <!-- Texto e Informações -->
        <div class="about-text">
            <h2>Quem Somos</h2>
            <p>
                A Clínica PluxeePet oferece serviços veterinários de qualidade, com atenção e cuidado para o seu pet.
            </p>

            <div class="info-cards">
                <div class="info-item">
                    <img src="https://cdn-icons-png.flaticon.com/512/2966/2966485.png" alt="Atendimento" />
                    <h3>Atendimento</h3>
                    <p>Atendimento veterinário especializado.</p>
                </div>

                <div class="info-item">
                    <img src="https://cdn-icons-png.flaticon.com/512/684/684908.png" alt="Localização" />
                    <h3>Localização</h3>
                    <p>Rua: José Guerreiro<br />Bairro: J.S Carvalho<br />Nº: 164</p>
                </div>

                <div class="info-item">
                    <img src="https://cdn-icons-png.flaticon.com/512/1827/1827272.png" alt="Horário" />
                    <h3>Horário</h3>
                    <p>Aberto de Segunda a Sábado das 8:00 às 18:00</p>
                </div>

            </div>

        </div>

    </div>

</asp:Content>
