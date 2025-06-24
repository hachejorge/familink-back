import { prisma } from "../db.js";

async function deletePerson(id) {
    try {
        // Primero quitamos las referencias de otros registros a esta persona
        await prisma.person.updateMany({
            where: {
                OR: [{ fatherId: id }, { motherId: id }, { spouseId: id }],
            },
            data: {
                fatherId: null,
                motherId: null,
                spouseId: null,
            },
        });

        // Luego eliminamos a la persona
        await prisma.person.delete({
            where: { id: Number(id) },
        });

        return { success: true };
    } catch (error) {
        console.error("Error al eliminar persona:", error);
        return { success: false, error: error.message };
    }
}

export { deletePerson };
