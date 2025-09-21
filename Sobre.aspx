<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Sobre.aspx.cs" Inherits="PluxxePet_Web.ContatoAba.Sobre" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main style="max-width: 900px; margin: 50px auto; text-align: center; font-family:'Arial', sans-serif;  color: #333">
       <h2 class="fw-bold display-5">Sobre a PluxeePet</h2>

        <p style="margin-top: 20px; font-size: 18px; line-height: 1.6;">
            A PluxeePet nasceu do amor pelos animais e da vontade de oferecer cuidados veterinários de excelência. 
            Tudo começou quando nossa fundadora, Ana Luísa, percebeu que havia uma carência de clínicas que unissem carinho, profissionalismo e atenção personalizada aos pets.
            Desde o início, nosso objetivo tem sido criar um ambiente acolhedor para animais e seus donos, garantindo saúde, conforto e felicidade.
        </p>

        <p style="margin-top: 15px; font-size: 18px; line-height: 1.6;">
            Com dedicação, buscamos sempre aprimorar nossos serviços e nos manter atualizados com as melhores práticas da medicina veterinária. 
            Hoje, a PluxeePet é referência em atendimento humanizado, combinando tecnologia, cuidado e amor em cada visita.
        </p>

        <div style="display: flex; justify-content: center; gap: 40px; margin-top: 40px; flex-wrap: wrap;">
            <div style="flex: 1; min-width: 200px;">
                <img src="imagens/fundadora.jpg" alt="Fundadora PluxeePet" style="width: 100%; border-radius: 8px;">
                <h4 style="margin-top: 10px;">Nossa Fundadora</h4>
                <p>Ana Luísa, apaixonada por pets e dedicada a transformar vidas com cuidado e carinho.</p>
            </div>

            <div style="flex: 1; min-width: 200px;">
                <asp:Image ID="imgLocal" runat="server" ImageUrl="~/imagens/PluxeePet Imagem.png" AlternateText="LocalPet" style="width: 100%; border-radius: 8px;" />
                <h4 style="margin-top: 10px;">Nossa Clínica</h4>
                <p>Um espaço acolhedor e moderno, preparado para receber todos os pets com segurança e atenção.</p>
            </div>

        </div>

    </main>
</asp:Content>