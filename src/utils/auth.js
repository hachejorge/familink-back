// src/auth.js
import { prisma } from "../db.js";
import jwt from "jsonwebtoken";
import bcrypt from "bcrypt";

const JWT_SECRET = process.env.JWT_SECRET;

export async function login(req, res) {
    const { username, password } = req.body;

    try {
        const user = await prisma.user.findUnique({ where: { username } });
        if (!user) return res.status(401).json({ error: "Usuario no encontrado" });

        const valid = await bcrypt.compare(password, user.password);
        if (!valid) return res.status(401).json({ error: "Contraseña incorrecta" });

        const token = jwt.sign(
            { userId: user.id, username: user.username, role: user.role },
            JWT_SECRET,
            {
                expiresIn: "2h",
            }
        );

        const rootPerson = user.rootPersonId;

        console.log("rootPerson:", rootPerson);

        res.status(200).json({ token, rootPerson });
    } catch (err) {
        console.error("Error en login:", err);
        res.status(500).json({ error: "Error interno del servidor" });
    }
}

export async function register(req, res) {
    const { username, password, role = "GUEST" } = req.body;

    try {
        const existing = await prisma.user.findUnique({ where: { username } });
        if (existing) return res.status(400).json({ error: "Usuario ya existe" });

        const hashed = await bcrypt.hash(password, 10);
        const user = await prisma.user.create({
            data: { username, password: hashed, role },
        });

        res.status(201).json({
            message: "Usuario creado",
            data: { id: user.id, username: user.username, role: user.role },
        });
    } catch (err) {
        console.error("Error en registro:", err);
        res.status(500).json({ error: "Error interno del servidor" });
    }
}
