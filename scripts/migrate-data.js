import { PrismaClient as SQLiteClient } from "../prisma/generated-sqlite/index.js";
import { PrismaClient as PostgresClient } from "../prisma/generated-postgres/index.js";

const sqlite = new SQLiteClient();
const postgres = new PostgresClient();

async function main() {
    const users = await sqlite.user.findMany();
    const people = await sqlite.person.findMany();

    console.log(`Migrando ${users.length} usuarios y ${people.length} personas...`);

    // Paso 1: Usuarios
    for (const user of users) {
        await postgres.user.create({
            data: {
                username: user.username,
                password: user.password,
                role: user.role,
                createdAt: user.createdAt,
            },
        });
    }

    // Paso 2: Insertar personas sin relaciones (relaciones se actualizan luego)
    for (const person of people) {
        await postgres.person.create({
            data: {
                id: person.id, // esto es clave para mantener los mismos IDs
                firstName: person.firstName,
                lastName: person.lastName,
                birth: person.birth,
                death: person.death,
                imageUrl: person.imageUrl,
                biography: person.biography,
                gender: person.gender,
                isAlive: person.isAlive,
                originPlace: person.originPlace,
            },
        });
    }

    // Paso 3: Actualizar relaciones
    for (const person of people) {
        await postgres.person.update({
            where: { id: person.id },
            data: {
                spouseId: person.spouseId,
                fatherId: person.fatherId,
                motherId: person.motherId,
            },
        });
    }

    console.log("✅ Migración completada con éxito.");
}

main()
    .catch((e) => {
        console.error("❌ Error en migración:", e);
    })
    .finally(async () => {
        await sqlite.$disconnect();
        await postgres.$disconnect();
    });
