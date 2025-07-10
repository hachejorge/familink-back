import { prisma } from "../db.js";

async function getCheraFamilies() {
    const families = await prisma.cheraFamily.findMany({
        select: {
            id: true,
            name: true,
            description: true,
            familyHeadId: true,
        },
    });

    return families;
}

export { getCheraFamilies };
