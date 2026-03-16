/*
  Warnings:

  - You are about to drop the column `role_id` on the `scout_profiles` table. All the data in the column will be lost.
  - Added the required column `role_id` to the `user_profiles` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "scout_profiles" DROP CONSTRAINT "scout_profiles_role_id_fkey";

-- AlterTable
ALTER TABLE "scout_profiles" DROP COLUMN "role_id";

-- AlterTable
ALTER TABLE "user_profiles" ADD COLUMN     "role_id" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "user_profiles" ADD CONSTRAINT "user_profiles_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "roles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
