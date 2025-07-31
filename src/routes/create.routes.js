import { Router } from "express";
import {
    createRoot,
    createChild,
    createSibling,
    createMother,
    createFather,
    createSpouse,
} from "../utils/create.js";

const router = Router();

// Crear persona raíz (sin relaciones)
router.post("/create/root", async (req, res) => {
    try {
        const newPerson = await createRoot(req.body);
        res.status(201).json(newPerson);
    } catch (error) {
        console.error("Error creating root person:", error);
        res.status(500).json({ error: "Error creating root person" });
    }
});

// Crear hijo/a
router.post("/create/children/:referenceId", async (req, res) => {
    try {
        const newPerson = await createChild(parseInt(req.params.referenceId), req.body);
        res.status(201).json(newPerson);
    } catch (error) {
        console.error("Error creating child:", error);
        res.status(500).json({ error: "Error creating child" });
    }
});

// Crear hermano/a
router.post("/create/sibling/:referenceId", async (req, res) => {
    try {
        const newPerson = await createSibling(parseInt(req.params.referenceId), req.body);
        res.status(201).json(newPerson);
    } catch (error) {
        console.error("Error creating sibling:", error);
        if (error.message === "Referencia debe tener madre o padre para crear un hermano/a") {
            return res.status(400).json({ error: error.message });
        }
        res.status(500).json({ error: "Error creating sibling" });
    }
});

// Crear madre
router.post("/create/mother/:referenceId", async (req, res) => {
    try {
        const newPerson = await createMother(parseInt(req.params.referenceId), req.body);
        res.status(201).json(newPerson);
    } catch (error) {
        console.error("Error creating mother:", error);
        res.status(500).json({ error: "Error creating mother" });
    }
});

// Crear padre
router.post("/create/father/:referenceId", async (req, res) => {
    try {
        const newPerson = await createFather(parseInt(req.params.referenceId), req.body);
        res.status(201).json(newPerson);
    } catch (error) {
        console.error("Error creating father:", error);
        res.status(500).json({ error: "Error creating father" });
    }
});

// Crear cónyuge
router.post("/create/spouse/:referenceId", async (req, res) => {
    try {
        const newPerson = await createSpouse(parseInt(req.params.referenceId), req.body);
        res.status(201).json(newPerson);
    } catch (error) {
        console.error("Error creating spouse:", error);
        res.status(500).json({ error: "Error creating spouse" });
    }
});

export default router;
