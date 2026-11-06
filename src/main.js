import "./style.css";

document.querySelector("#app").innerHTML = `
  <main class="container">
    <h1>Projeto ONG</h1>

    <p>Monitoramento da conexão com o servidor</p>

    <div class="status-card">
      <span id="status-indicator">⏳</span>
      <h2 id="api-status">Verificando API...</h2>
      <p id="data-hora"></p>
    </div>
  </main>
`;

async function verificarAPI() {
  const status = document.querySelector("#api-status");
  const indicador = document.querySelector("#status-indicator");

  try {
    const resposta = await fetch("/api/health");

    if (!resposta.ok) {
      throw new Error("Falha na comunicação");
    }

    const dados = await resposta.json();

    status.textContent = `Status da API: ${dados.status}`;
    indicador.textContent = "🟢";
  } catch (erro) {
    status.textContent = "Status da API: indisponível";
    indicador.textContent = "🔴";
  }

  document.querySelector("#data-hora").textContent =
    `Última verificação: ${new Date().toLocaleString("pt-BR")}`;
}

verificarAPI();
