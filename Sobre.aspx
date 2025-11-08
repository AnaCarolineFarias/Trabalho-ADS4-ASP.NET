<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Sobre.aspx.cs" Inherits="PluxeePetADS4.ContatoAba.Sobre" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main style="max-width: 900px; margin: 50px auto; text-align: center; font-family:'Arial', sans-serif; color: #333">
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
           
                    <div style="width: 45%; 
                        min-width: 300px; 
                        border-radius: 8px; 
                        overflow: hidden; 
                        box-shadow: 0 4px 8px rgba(0,0,0,0.1); 
                        background-color: #fff; 
                        text-align: center; 
                        display: flex; 
                        flex-direction: column;">
                
                <img src="/Imagens/Fundadora.png" alt="Fundadora PluxeePet" style="width: 100%; height: 250px; object-fit: cover;"/>
                
                <div style="padding: 15px;">
                    <h4 style="margin-top: 10px; margin-bottom: 5px;">Nossa Fundadora</h4>
                    <p style="font-size: 0.9em; color: #555;">Ana Luísa, apaixonada por pets e dedicada a transformar vidas com cuidado e carinho.</p>
                </div>
            </div>

                    <div style="width: 45%;
                        min-width: 300px; 
                        border-radius: 8px; 
                        overflow: hidden; 
                        box-shadow: 0 4px 8px rgba(0,0,0,0.1); 
                        background-color: #fff; 
                        text-align: center; 
                        display: flex; 
                        flex-direction: column;">
                
                <img src="/Imagens/PluxeePet Imagem.png" alt="Nossa Clínica PluxeePet" style="width: 100%; height: 250px; object-fit: cover;"/>
                
                <div style="padding: 15px;">
                    <h4 style="margin-top: 10px; margin-bottom: 5px;">Nossa Clínica</h4>
                    <p style="font-size: 0.9em; color: #555;">Um espaço acolhedor e moderno, preparado para receber todos os pets com segurança e atenção.</p>
                </div>
            </div>

        </div>
    </main>
</asp:Content>
