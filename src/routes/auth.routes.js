// src/auth.routes.js
import { Router } from "express";
import { login, register } from "../utils/auth.js"; // asegúrate de que sea .js si usas ES Modules

const router = Router();

router.post("/login", login);
router.post("/register", register); // puedes quitar esta en producción

export default router;
