import { Router } from "express";
import { searchPeopleByString } from "../utils/search.js";
const router = Router();

router.get("/search/:query", async (req, res) => {
    const { query } = req.params;
    const familyId = parseInt(
        Array.isArray(req.query.familyId) ? req.query.familyId[0] : req.query.familyId,
        10
    );

    if (!query) {
        return res.status(400).json({ error: "Query parameter is required" });
    }

    try {
        const results = await searchPeopleByString(query, familyId);

        res.json(results);
    } catch (error) {
        console.error("Error during search:", error);
        res.status(500).json({ error: "Error during search" });
    }
});

export default router;
