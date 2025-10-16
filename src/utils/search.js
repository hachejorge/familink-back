import { prisma } from "../db.js";

export async function searchPeopleByString(searchString, familyId) {
    if (!searchString || searchString.trim() === "" || !familyId) {
        return [];
    }

    const searchTerms = searchString
        .split(" ")
        .map((term) => term.trim())
        .filter((term) => term !== "");

    const whereConditions = searchTerms.map((term) => ({
        OR: [
            { firstName: { contains: term, mode: "insensitive" } },
            { lastName: { contains: term, mode: "insensitive" } },
            { originPlace: { contains: term, mode: "insensitive" } },
        ],
        AND: { familyId: familyId },
    }));

    return await prisma.person.findMany({
        where: {
            AND: whereConditions,
        },
        select: {
            id: true,
            firstName: true,
            lastName: true,
            imageUrl: true,
        },
        take: 10,
    });
}
