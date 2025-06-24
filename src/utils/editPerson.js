import { prisma } from "../db.js";

/**
 * Modifica una persona en la base de datos a partir de los datos del frontend.
 * @param params - Objeto de tipo PersonDetails del frontend
 * @returns La persona actualizada o un error
 */
async function modifyPerson(params) {
    const {
        id,
        firstName,
        lastName,
        imageUrl,
        biography,
        originPlace,
        gender,
        isAlive,
        birthDate,
        deathDate,
    } = params;

    try {
        const updatedPerson = await prisma.person.update({
            where: { id },
            data: {
                firstName,
                lastName,
                imageUrl,
                biography,
                originPlace,
                gender,
                isAlive,
                birth: birthDate ? new Date(birthDate) : null,
                death: deathDate ? new Date(deathDate) : null,
            },
        });

        return updatedPerson;
    } catch (error) {
        console.error("Error al modificar persona:", error);
        throw new Error("No se pudo modificar la persona.");
    }
}

export { modifyPerson };
