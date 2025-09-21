<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Servicos.aspx.cs" MasterPageFile="~/Site.Master" Inherits="PluxxePet_Web.Servicos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container py-5">
        <div class="text-center mb-5">
            <h2 class="fw-bold display-5">Nossos Serviços</h2>
            <p class="lead text-muted">Cuidamos do seu pet com amor, dedicação e profissionais qualificados.</p>
        </div>

        <div class="row row-cols-1 row-cols-md-3 g-4">
            <!-- Consultas -->
            <div class="col">
                <div class="card h-100 shadow-sm border-0 text-center p-4 service-card">
                    <img src="https://cdn-icons-png.flaticon.com/512/616/616408.png" class="mx-auto mb-3" width="80" alt="Consultas" />
                    <h5 class="fw-semibold mb-2">Consultas Veterinárias</h5>
                    <p class="text-muted">Atendimento clínico completo para cães e gatos, garantindo saúde e bem-estar.</p>
                </div>
            </div>

            <!-- Vacinação -->
            <div class="col">
                <div class="card h-100 shadow-sm border-0 text-center p-4 service-card">
                    <img src="https://cdn-icons-png.flaticon.com/512/2966/2966486.png" class="mx-auto mb-3" width="80" alt="Vacinação" />
                    <h5 class="fw-semibold mb-2">Vacinação</h5>
                    <p class="text-muted">Protocolos de vacinação atualizados para manter seu pet protegido contra doenças.</p>
                </div>
            </div>

            <!-- Banho e Tosa -->
            <div class="col">
                <div class="card h-100 shadow-sm border-0 text-center p-4 service-card">
                    <img src="https://cdn-icons-png.flaticon.com/512/616/616408.png" class="mx-auto mb-3" width="80" alt="Banho e Tosa" />
                    <h5 class="fw-semibold mb-2">Banho e Tosa</h5>
                    <p class="text-muted">Serviço estético e higiênico de qualidade, deixando seu pet limpo e feliz.</p>
                </div>
            </div>

            <!-- Cirurgias -->
            <div class="col">
                <div class="card h-100 shadow-sm border-0 text-center p-4 service-card">
                    <img src="https://cdn-icons-png.flaticon.com/512/2966/2966327.png" class="mx-auto mb-3" width="80" alt="Cirurgias" />
                    <h5 class="fw-semibold mb-2">Cirurgias</h5>
                    <p class="text-muted">Centro cirúrgico preparado para procedimentos de baixa e média complexidade.</p>
                </div>
            </div>

            <!-- Exames -->
            <div class="col">
                <div class="card h-100 shadow-sm border-0 text-center p-4 service-card">
                    <img src="https://cdn-icons-png.flaticon.com/512/2966/2966500.png" class="mx-auto mb-3" width="80" alt="Exames" />
                    <h5 class="fw-semibold mb-2">Exames Laboratoriais</h5>
                    <p class="text-muted">Exames rápidos e precisos para auxiliar no diagnóstico do seu pet.</p>
                </div>
            </div>

            <!-- Internação -->
            <div class="col">
                <div class="card h-100 shadow-sm border-0 text-center p-4 service-card">
                    <img src="https://cdn-icons-png.flaticon.com/512/616/616430.png" class="mx-auto mb-3" width="80" alt="Internação" />
                    <h5 class="fw-semibold mb-2">Internação</h5>
                    <p class="text-muted">Ambiente seguro e confortável para pets que necessitam de cuidados intensivos.</p>
                </div>
            </div>
        </div>
    </div>

    <style>
        /* Hover moderno nos cards */
        .service-card {
            transition: transform 0.3s, box-shadow 0.3s;
            border-radius: 15px;
            background: #fff;
        }

        .service-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.12);
        }

        /* Tipografia */
        h5 {
            color: #333;
        }

        p {
            font-size: 0.95rem;
        }
    </style>

</asp:Content>
