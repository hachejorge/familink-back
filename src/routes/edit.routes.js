import { Router } from "express";
import multer from "multer";
import { uploadMultimedia } from "../utils/multimedia.js";
import { modifyPerson } from "../utils/editPerson.js"; // ajusta la ruta si es distinta

const storage = multer.memoryStorage();
const upload = multer({ storage });
const router = Router();

// Subida de imágenes
router.post("/upload/multimedia", upload.single("file"), async (req, res) => {
    try {
        if (!req.file) {
            return res.status(400).json({ error: "No se ha proporcionado ningún archivo." });
        }

        const base64Image = `data:${req.file.mimetype};base64,${req.file.buffer.toString(
            "base64"
        )}`;
        const result = await uploadMultimedia(base64Image);

        res.status(200).json({
            message: "Archivo subido con éxito",
            data: result,
        });
    } catch (error) {
        console.error("Error en el endpoint:", error);
        res.status(500).json({ error: "Error al subir la imagen" });
    }
});

// Modificación de persona
router.post("/person/modify", async (req, res) => {
    try {
        const personData = req.body;
        if (!personData.id || !personData.firstName) {
            return res
                .status(400)
                .json({ error: "Datos insuficientes para modificar la persona." });
        }

        const updatedPerson = await modifyPerson(personData);
        res.status(200).json({
            message: "Persona actualizada con éxito.",
            data: updatedPerson,
        });
    } catch (error) {
        console.error("Error al modificar persona:", error);
        res.status(500).json({ error: "Error al modificar la persona." });
    }
});

export default router;
