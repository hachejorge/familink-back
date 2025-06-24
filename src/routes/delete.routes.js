import { Router } from "express";
import { deletePerson } from "../utils/delete.js";

const router = new Router();

router.delete("/person/:id", async (req, res) => {
    const personId = parseInt(req.params.id, 10);

    if (isNaN(personId)) {
        return res.status(400).json({ error: "Invalid ID" });
    }
    const result = await deletePerson(personId);

    if (result.success) {
        res.status(200).json({ message: "Persona eliminada correctamente." });
    } else {
        res.status(500).json({ error: result.error || "No se pudo eliminar la persona." });
    }
});

export default router;
