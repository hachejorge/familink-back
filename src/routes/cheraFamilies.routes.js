import { Router } from "express";
import { getCheraFamilies } from "../utils/cheraFamilies.js";

const router = Router();

router.get("/", async (req, res) => {
    try {
        const families = await getCheraFamilies();
        res.status(200).json(families);
    } catch (error) {
        console.error("Error fetching families:", error);
        res.status(500).json({ error: "Error fetching families" });
    }
});

export default router;
