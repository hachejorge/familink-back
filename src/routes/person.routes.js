import { Router } from "express";
import { buildAscendantTree, buildDescendantTree } from "../utils/trees.js"; // Asegúrate de que esta función esté definida en utils
import {
    getPersonDetails,
    getSiblings,
    getFirstCousins,
    getSecondCousins,
    getBirthDatesAlive,
} from "../utils/person.js"; // Asegúrate de que esta función esté definida en utils

const router = Router();

router.get("/ascendant-tree/:id", async (req, res) => {
    const personId = parseInt(req.params.id, 10);

    if (isNaN(personId)) {
        return res.status(400).json({ error: "Invalid ID" });
    }

    try {
        const tree = await buildAscendantTree(personId);
        if (!tree) {
            return res.status(404).json({ error: "Person not found" });
        }
        res.json(tree);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Server error" });
    }
});

router.get("/descendant-tree/:id", async (req, res) => {
    const personId = parseInt(req.params.id, 10);

    if (isNaN(personId)) {
        return res.status(400).json({ error: "Invalid ID" });
    }

    try {
        const tree = await buildDescendantTree(personId);
        if (!tree) {
            return res.status(404).json({ error: "Person not found" });
        }
        res.json(tree);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Server error" });
    }
});

router.get("/person-details/:id", async (req, res) => {
    const personId = parseInt(req.params.id, 10);

    if (isNaN(personId)) {
        return res.status(400).json({ error: "Invalid ID" });
    }

    try {
        const details = await getPersonDetails(personId);
        const siblings = await getSiblings(personId);
        if (!details) {
            return res.status(404).json({ error: "Person not found" });
        }
        res.json({
            id: details.id,
            firstName: details.firstName,
            lastName: details.lastName,
            birthDate: details.birthDate,
            deathDate: details.deathDate,
            originPlace: details.originPlace,
            imageUrl: details.imageUrl,
            biography: details.biography,
            gender: details.gender,
            isAlive: details.isAlive,
            siblings: siblings,
        });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Server error" });
    }
});

router.get("/siblings/:id", async (req, res) => {
    const personId = parseInt(req.params.id, 10);

    if (isNaN(personId)) {
        return res.status(400).json({ error: "Invalid ID" });
    }

    try {
        const siblings = await getSiblings(personId);
        res.json(siblings);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Server error" });
    }
});

router.get("/cousins1grade/:id", async (req, res) => {
    const personId = parseInt(req.params.id, 10);

    if (isNaN(personId)) {
        return res.status(400).json({ error: "Invalid ID" });
    }

    try {
        const cousins = await getFirstCousins(personId);
        res.json(cousins);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Server error" });
    }
});

router.get("/cousins2grade/:id", async (req, res) => {
    const personId = parseInt(req.params.id, 10);

    if (isNaN(personId)) {
        return res.status(400).json({ error: "Invalid ID" });
    }

    try {
        const cousins = await getSecondCousins(personId);
        res.json(cousins);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Server error" });
    }
});

router.get("/birthdates", async (req, res) => {
    try {
        const birthDates = await getBirthDatesAlive();
        res.json(birthDates);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Server error" });
    }
});

export default router;
