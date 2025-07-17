import { Router } from "express";
import { searchPeopleByString } from "../utils/search.js"; // Asume que searchPeople es una función definida en utils
const router = Router();

router.get("/search/:query", async (req, res) => {
    const { query } = req.params;

    if (!query) {
        return res.status(400).json({ error: "Query parameter is required" });
    }

    try {
        const results = await searchPeopleByString(query); // Asume que searchPeople es una función definida en utils

        res.json(results);
    } catch (error) {
        console.error("Error during search:", error);
        res.status(500).json({ error: "Error during search" });
    }
});

export default router;
