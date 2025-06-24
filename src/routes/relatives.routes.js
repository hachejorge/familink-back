import { Router } from "express";
import { getRelatives } from "../utils/relatives.js";

const router = Router();

router.get("/relatives/:id", async (req, res) => {
    const personId = parseInt(req.params.id, 10);

    if (isNaN(personId)) {
        return res.status(400).json({ error: "Invalid ID" });
    }

    try {
        const relatives = await getRelatives(personId);
        if (!relatives) {
            return res.status(404).json({ error: "Person not found" });
        }
        res.json(relatives);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Server error" });
    }
});

export default router;
