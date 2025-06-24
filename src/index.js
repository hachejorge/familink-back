import express from "express";
import cors from "cors";
import { authenticateToken } from "./utils/authMiddleware.js";

const app = express();

app.use(cors({ origin: "http://localhost:4200" }));

app.use(express.json());

import authRoutes from "./routes/auth.routes.js";
app.use(authRoutes);

import personRoutes from "./routes/person.routes.js";
app.use("/persons", authenticateToken, personRoutes);

import editRoutes from "./routes/edit.routes.js";
app.use(authenticateToken, editRoutes);

import relativesRoutes from "./routes/relatives.routes.js";
app.use(authenticateToken, relativesRoutes);

import createRoutes from "./routes/create.routes.js";
app.use(authenticateToken, createRoutes);

import deleteRoutes from "./routes/delete.routes.js";
app.use(authenticateToken, deleteRoutes);

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
