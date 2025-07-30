/*
  Warnings:

  - You are about to drop the column `rootPerson` on the `User` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "User" DROP COLUMN "rootPerson",
ADD COLUMN     "rootPersonId" INTEGER;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_rootPersonId_fkey" FOREIGN KEY ("rootPersonId") REFERENCES "Person"("id") ON DELETE SET NULL ON UPDATE CASCADE;
