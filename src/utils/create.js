import { prisma } from "../db.js";

function mapToPrismaPersonData(person) {
    return {
        firstName: person.firstName,
        lastName: person.lastName || null,
        gender: person.gender || null,
        originPlace: person.originPlace || null,
        isAlive: person.isAlive ?? true,
        birth: person.birthDate && person.birthDate !== "" ? new Date(person.birthDate) : null,
        death: person.deathDate && person.deathDate !== "" ? new Date(person.deathDate) : null,
        biography: person.biography || null,
        imageUrl: person.imageUrl || null,
    };
}

function cleanPerson(person) {
    const { id, ...rest } = person;
    return rest;
}

// Crear hijo/a
export async function createChild(referenceId, newPerson) {
    const parent = await prisma.person.findUnique({ where: { id: referenceId } });
    if (!parent) throw new Error("Persona de referencia no encontrada");

    const isMother = parent.gender === "F";
    const isFather = parent.gender === "M";

    const child = await prisma.person.create({
        data: {
            ...mapToPrismaPersonData(cleanPerson(newPerson)),
            motherId: isMother ? parent.id : parent.spouseId || undefined,
            fatherId: isFather ? parent.id : parent.spouseId || undefined,
        },
    });

    return child;
}

// Crear hermano/a
export async function createSibling(referenceId, newPerson) {
    const reference = await prisma.person.findUnique({ where: { id: referenceId } });
    if (!reference) throw new Error("Persona de referencia no encontrada");

    if (!reference.motherId && !reference.fatherId) {
        throw new Error("Referencia debe tener madre o padre para crear un hermano/a");
    }

    const sibling = await prisma.person.create({
        data: {
            ...mapToPrismaPersonData(cleanPerson(newPerson)),
            motherId: reference.motherId,
            fatherId: reference.fatherId,
        },
    });

    return sibling;
}

// Crear madre
export async function createMother(referenceId, newPerson) {
    const reference = await prisma.person.findUnique({ where: { id: referenceId } });

    let spouseId = undefined;
    if (reference && reference.fatherId) {
        spouseId = reference.fatherId;
        // También actualiza al padre para que tenga como esposa a la nueva madre
        await prisma.person.update({
            where: { id: reference.fatherId },
            data: { spouseId: undefined }, // Se actualizará después de crear la madre
        });
    }

    const mother = await prisma.person.create({
        data: {
            ...mapToPrismaPersonData(cleanPerson(newPerson)),
            gender: "F",
            spouseId: spouseId,
        },
    });

    await prisma.person.update({
        where: { id: referenceId },
        data: { motherId: mother.id },
    });

    // Si había padre, actualiza su spouseId a la nueva madre
    if (spouseId) {
        await prisma.person.update({
            where: { id: spouseId },
            data: { spouseId: mother.id },
        });
    }

    // Actualizar a los hermanos para que tengan la nueva madre
    if (reference.fatherId) {
        await prisma.person.updateMany({
            where: { fatherId: reference.fatherId },
            data: { motherId: mother.id },
        });
    }

    return mother;
}

// Crear padre
export async function createFather(referenceId, newPerson) {
    const reference = await prisma.person.findUnique({ where: { id: referenceId } });

    let spouseId = undefined;
    if (reference && reference.motherId) {
        spouseId = reference.motherId;
        // También actualiza a la madre para que tenga como esposo al nuevo padre
        await prisma.person.update({
            where: { id: reference.motherId },
            data: { spouseId: undefined }, // Se actualizará después de crear el padre
        });
    }

    const father = await prisma.person.create({
        data: {
            ...mapToPrismaPersonData(cleanPerson(newPerson)),
            gender: "M",
            spouseId: spouseId,
        },
    });

    await prisma.person.update({
        where: { id: referenceId },
        data: { fatherId: father.id },
    });

    // Si había madre, actualiza su spouseId al nuevo padre
    if (spouseId) {
        await prisma.person.update({
            where: { id: spouseId },
            data: { spouseId: father.id },
        });
    }

    // Actualizar a los hermanos para que tengan el nuevo padre
    if (reference.motherId) {
        await prisma.person.updateMany({
            where: { motherId: reference.motherId },
            data: { fatherId: father.id },
        });
    }

    return father;
}

// Crear esposo/a
export async function createSpouse(referenceId, newPerson) {
    const createdSpouse = await prisma.person.create({
        data: {
            ...mapToPrismaPersonData(cleanPerson(newPerson)),
            spouseId: referenceId,
        },
    });

    await prisma.person.update({
        where: { id: referenceId },
        data: { spouseId: createdSpouse.id },
    });

    return createdSpouse;
}

// Crear raíz sin relaciones
export async function createRoot(newPerson) {
    return await prisma.person.create({
        data: mapToPrismaPersonData(cleanPerson(newPerson)),
    });
}
