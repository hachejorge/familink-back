import { prisma } from "../db.js";

// Función recursiva para construir el árbol
async function buildAscendantTree(personId) {
    const person = await prisma.person.findUnique({
        where: { id: personId },
        include: {
            father: true,
            mother: true,
        },
    });

    if (!person) return null;

    const personData = {
        id: person.id,
        firstName: person.firstName,
        lastName: person.lastName,
        imageUrl: person.imageUrl ?? undefined,
    };

    const [fatherTree, motherTree] = await Promise.all([
        person.fatherId ? buildAscendantTree(person.fatherId) : null,
        person.motherId ? buildAscendantTree(person.motherId) : null,
    ]);

    return {
        root: personData,
        father: fatherTree,
        mother: motherTree,
    };
}

async function buildDescendantTree(personId) {
    const person = await prisma.person.findUnique({
        where: { id: personId },
        include: {
            spouse: true,
            childrenOfFather: {
                select: {
                    id: true,
                    firstName: true,
                    lastName: true,
                    imageUrl: true,
                    birth: true, // Asegúrate de incluir el campo birth
                },
            },
            childrenOfMother: {
                select: {
                    id: true,
                    firstName: true,
                    lastName: true,
                    imageUrl: true,
                    birth: true, // También aquí
                },
            },
        },
    });

    if (!person) return null;

    const personData = {
        id: person.id,
        firstName: person.firstName,
        lastName: person.lastName,
        imageUrl: person.imageUrl ?? undefined,
    };

    const spouseData = person.spouse
        ? {
              id: person.spouse.id,
              firstName: person.spouse.firstName,
              lastName: person.spouse.lastName,
              imageUrl: person.spouse.imageUrl ?? undefined,
          }
        : null;

    const children = [...(person.childrenOfFather ?? []), ...(person.childrenOfMother ?? [])];

    // Eliminar duplicados si un hijo aparece en ambas listas
    const uniqueChildren = Array.from(new Map(children.map((c) => [c.id, c])).values());

    // Ordenar por fecha de nacimiento ascendente
    uniqueChildren.sort((a, b) => new Date(a.birth) - new Date(b.birth));

    const childrenTrees = await Promise.all(
        uniqueChildren.map((child) => buildDescendantTree(child.id))
    );

    return {
        root: personData,
        spouse: spouseData,
        children: childrenTrees.length > 0 ? childrenTrees : null,
    };
}

export { buildAscendantTree, buildDescendantTree };
