import express from "express";
import dotenv from "dotenv";
import mysql from "mysql2/promise";

dotenv.config();

const app = express();

app.use(express.json());

// Conexão com o banco de dados
const db = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  port: Number(process.env.DB_PORT),
  waitForConnections: true,
  connectionLimit: 10,
});

// Verificar saúde da API
app.get("/api/health", (req, res) => {
  res.json({
    status: "ok",
  });
});

// Verificar conexão com o banco
app.get("/api/db-health", async (req, res) => {
  try {
    await db.query("SELECT 1");

    res.json({
      status: "ok",
      database: "conectado",
    });
  } catch (error) {
    console.error("Erro ao conectar ao banco:", error.message);

    res.status(500).json({
      status: "erro",
      database: "desconectado",
    });
  }
});

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`API rodando em http://localhost:${PORT}`);
});
