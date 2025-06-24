import { prisma } from "../db.js";

import { getSiblings } from "./person.js";

async function getChildren(personId) {
    const children = await prisma.person.findMany({
        where: {
            OR: [{ fatherId: personId }, { motherId: personId }],
        },
        select: {
            id: true,
            firstName: true,
            lastName: true,
            imageUrl: true,
        },
    });

    return children;
}
async function getRelatives(id) {
    // Obtenemos padre, madre y cónyuge
    const person = await prisma.person.findUnique({
        where: { id: id },
        include: {
            spouse: {
                select: {
                    id: true,
                    firstName: true,
                    lastName: true,
                    imageUrl: true,
                },
            },
            father: {
                select: {
                    id: true,
                    firstName: true,
                    lastName: true,
                    imageUrl: true,
                },
            },
            mother: {
                select: {
                    id: true,
                    firstName: true,
                    lastName: true,
                    imageUrl: true,
                },
            },
        },
    });

    // Si no existe la persona, retornamos null
    if (!person) return null;

    // Obtenemos hermanos
    const siblings = await getSiblings(id);

    // Obtenemos hijos
    const children = await getChildren(id);

    return {
        father: person.father,
        mother: person.mother,
        spouse: person.spouse,
        siblings,
        children,
    };
}

export { getRelatives };
