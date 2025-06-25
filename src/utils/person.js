import { prisma } from "../db.js";

function formatDateToDDMMYYYY(date) {
    const day = String(date.getDate()).padStart(2, "0");
    const month = String(date.getMonth() + 1).padStart(2, "0"); // ¡Meses empiezan en 0!
    const year = date.getFullYear();
    return `${day}-${month}-${year}`;
}

async function getPersonDetails(personId) {
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
        biography: person.biography ?? null,
        originPlace: person.originPlace ?? null,
        gender: person.gender ?? null,
        isAlive: person.isAlive ?? null,
        imageUrl: person.imageUrl ?? undefined,
        birthDate: person.birth ? formatDateToDDMMYYYY(new Date(person.birth)) : null,
        deathDate: person.death ? formatDateToDDMMYYYY(new Date(person.death)) : null,
        fatherId: person.fatherId ?? null,
        motherId: person.motherId ?? null,
    };

    return personData;
}

async function getSiblings(personId) {
    // 1. Obtener los IDs de los padres de la persona
    const person = await prisma.person.findUnique({
        where: { id: personId },
        select: {
            fatherId: true,
            motherId: true,
        },
    });

    if (!person) return [];

    // 2. Buscar personas que compartan el padre o la madre, excluyendo al propio personId
    // Si ambos padres son null o undefined, no hay hermanos biológicos que mostrar
    if (!person.fatherId && !person.motherId) {
        return [];
    }

    const siblings = await prisma.person.findMany({
        where: {
            AND: [
                { id: { not: personId } },
                {
                    OR: [
                        person.fatherId ? { fatherId: person.fatherId } : undefined,
                        person.motherId ? { motherId: person.motherId } : undefined,
                    ].filter(Boolean),
                },
            ],
        },
        orderBy: {
            birth: "asc",
        },
    });

    return siblings.map((sibling) => ({
        id: sibling.id,
        firstName: sibling.firstName,
        lastName: sibling.lastName,
        imageUrl: sibling.imageUrl ?? undefined,
    }));
}

async function getFirstCousins(personId) {
    // 1. Obtener la persona con IDs de sus padres
    const person = await prisma.person.findUnique({
        where: { id: personId },
        select: {
            father: {
                select: {
                    id: true,
                    fatherId: true,
                    motherId: true,
                },
            },
            mother: {
                select: {
                    id: true,
                    fatherId: true,
                    motherId: true,
                },
            },
        },
    });

    if (!person) return [];

    const paternalGrandfatherId = person.father?.fatherId;
    const paternalGrandmotherId = person.father?.motherId;
    const maternalGrandfatherId = person.mother?.fatherId;
    const maternalGrandmotherId = person.mother?.motherId;

    // Construir condiciones solo si ambos IDs de abuelos existen
    const orConditions = [];
    if (paternalGrandfatherId || paternalGrandmotherId) {
        orConditions.push({
            ...(paternalGrandfatherId && { fatherId: paternalGrandfatherId }),
            ...(paternalGrandmotherId && { motherId: paternalGrandmotherId }),
        });
    }
    if (maternalGrandfatherId || maternalGrandmotherId) {
        orConditions.push({
            ...(maternalGrandfatherId && { fatherId: maternalGrandfatherId }),
            ...(maternalGrandmotherId && { motherId: maternalGrandmotherId }),
        });
    }

    if (orConditions.length === 0) return [];

    // 2. Obtener todos los hijos de los abuelos paternos y maternos (tíos + padres)
    const unclesAndAunts = await prisma.person.findMany({
        where: {
            OR: orConditions,
        },
    });

    // 3. Excluir a los padres
    const uncleOrAuntIds = unclesAndAunts
        .filter(
            (p) =>
                p.id !== person.father?.id &&
                p.id !== person.mother?.id &&
                p.id !== undefined &&
                p.id !== null
        )
        .map((p) => p.id);

    if (uncleOrAuntIds.length === 0) return [];

    // 4. Obtener hijos de los tíos → primos hermanos
    const cousins = await prisma.person.findMany({
        where: {
            OR: uncleOrAuntIds.flatMap((id) => [{ fatherId: id }, { motherId: id }]),
        },
    });

    // 5. Mapear a formato de salida
    return cousins.map((cousin) => ({
        id: cousin.id,
        firstName: cousin.firstName,
        lastName: cousin.lastName,
        imageUrl: cousin.imageUrl ?? undefined,
    }));
}

async function getSecondCousins(personId) {
    // 1. Obtener los padres del individuo
    const person = await prisma.person.findUnique({
        where: { id: personId },
        select: {
            father: {
                select: {
                    id: true,
                    fatherId: true,
                    motherId: true,
                },
            },
            mother: {
                select: {
                    id: true,
                    fatherId: true,
                    motherId: true,
                },
            },
        },
    });

    console.log("Nombre del padre:", person.father?.id);
    console.log("Nombre de la madre:", person.mother?.id);

    // 2. Obtener los Primos Hermanos (primos de primer grado)
    const fatherFirstCousins = await getFirstCousins(person.father?.id);
    const motherFirstCousins = await getFirstCousins(person.mother?.id);

    console.log("Primos de mi padre:", fatherFirstCousins);
    console.log("Primos de mi madre:", motherFirstCousins);

    // 3. Obtener los hijos de los primos hermanos (segundos primos)
    const firstCousinIds = [...fatherFirstCousins, ...motherFirstCousins].map(
        (cousin) => cousin.id
    );

    if (firstCousinIds.length === 0) return [];

    const secondCousins = await prisma.person.findMany({
        where: {
            OR: firstCousinIds.flatMap((id) => [{ fatherId: id }, { motherId: id }]),
        },
    });

    // 4. Mapear resultado
    return secondCousins.map((cousin) => ({
        id: cousin.id,
        firstName: cousin.firstName,
        lastName: cousin.lastName,
        imageUrl: cousin.imageUrl ?? undefined,
    }));
}

async function getBirthDatesAlive() {
    const birhtDates = await prisma.person.findMany({
        where: {
            isAlive: true,
            birth: {
                not: null,
            },
        },
        select: {
            id: true,
            firstName: true,
            lastName: true,
            imageUrl: true,
            birth: true,
        },
        orderBy: {
            birth: "desc",
        },
    });

    return birhtDates;
}

export { getPersonDetails, getSiblings, getFirstCousins, getSecondCousins, getBirthDatesAlive };
