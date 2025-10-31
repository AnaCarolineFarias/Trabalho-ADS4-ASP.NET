using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PluxxePetADS4.ContatoAba.Contato
{
    public partial class Contato : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnEnviar_Click(object sender, EventArgs e)
        {
            // Aqui você coloca o que quer fazer quando o botão for clicado
            string email = txtEmail.Text;
            string mensagem = txtMensagem.Text;

            // Exemplo: apenas mostrar um alerta
            Response.Write("<script>alert('Mensagem enviada com sucesso!');</script>");
        }
    }
}
