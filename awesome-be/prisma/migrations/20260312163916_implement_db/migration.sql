/*
  Warnings:

  - You are about to drop the `HiTest` table. If the table is not empty, all the data it contains will be lost.

*/
-- CreateEnum
CREATE TYPE "PaymentMethod" AS ENUM ('CASH', 'ONLINE');

-- CreateEnum
CREATE TYPE "PaymentStatus" AS ENUM ('PENDING', 'REGISTERED', 'PAID', 'OVERDUE');

-- CreateEnum
CREATE TYPE "CampAttendanceStatus" AS ENUM ('UPCOMING', 'ATTENDED', 'MISSED');

-- CreateEnum
CREATE TYPE "ApprovalStatus" AS ENUM ('DRAFT', 'APPROVED', 'REJECTED');

-- CreateEnum
CREATE TYPE "LifeCycleStatus" AS ENUM ('UPCOMING', 'ACTIVE', 'INACTIVE', 'DELETED');

-- CreateEnum
CREATE TYPE "Section" AS ENUM ('BEAVER', 'CUB', 'SCOUT', 'VENTURER', 'ROVER', 'LEADER', 'PARENT');

-- CreateEnum
CREATE TYPE "UnitType" AS ENUM ('DISTRICT', 'TROOP', 'GROUP');

-- CreateEnum
CREATE TYPE "AchievementType" AS ENUM ('BADGE', 'RANK');

-- CreateEnum
CREATE TYPE "ContestFormat" AS ENUM ('INDIVIDUAL', 'TEAM');

-- CreateEnum
CREATE TYPE "ContestType" AS ENUM ('WEEKLY', 'CAMP', 'OUTING');

-- CreateEnum
CREATE TYPE "ProfileDetailType" AS ENUM ('ACHIEVEMENT', 'UNIT');

-- DropTable
DROP TABLE "HiTest";

-- CreateTable
CREATE TABLE "user_profiles" (
    "id" SERIAL NOT NULL,
    "mail" TEXT NOT NULL,
    "username" TEXT,
    "password_hash" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "life_cycle_status" "LifeCycleStatus" NOT NULL,

    CONSTRAINT "user_profiles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "scout_profiles" (
    "id" SERIAL NOT NULL,
    "code" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "first_name" TEXT NOT NULL,
    "phone" TEXT,
    "address" TEXT NOT NULL,
    "dob" TIMESTAMP(3) NOT NULL,
    "citizen_id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "life_cycle_status" "LifeCycleStatus" NOT NULL,
    "section" "Section" NOT NULL,
    "user_profile_id" INTEGER NOT NULL,
    "role_id" INTEGER NOT NULL,

    CONSTRAINT "scout_profiles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "profile_details" (
    "id" SERIAL NOT NULL,
    "image_url" TEXT,
    "description" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "life_cycle_status" "LifeCycleStatus" NOT NULL,
    "type" "ProfileDetailType" NOT NULL,
    "scout_profile_id" INTEGER NOT NULL,
    "achievement_id" INTEGER NOT NULL,
    "unit_id" INTEGER NOT NULL,

    CONSTRAINT "profile_details_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "achievements" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "image_url" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "life_cycle_status" "LifeCycleStatus" NOT NULL,
    "type" "AchievementType" NOT NULL,
    "section" "Section" NOT NULL,

    CONSTRAINT "achievements_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "units" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(50) NOT NULL,
    "description" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "life_cycle_status" "LifeCycleStatus" NOT NULL,
    "section" "Section",
    "unit_type" "UnitType" NOT NULL,
    "parentId" INTEGER,

    CONSTRAINT "units_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "permissions" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "life_cycle_status" "LifeCycleStatus" NOT NULL,

    CONSTRAINT "permissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "roles" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "life_cycle_status" "LifeCycleStatus" NOT NULL,

    CONSTRAINT "roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "weekly_attendances" (
    "id" SERIAL NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "is_present" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "approval_status" "ApprovalStatus" NOT NULL,
    "attendee_id" INTEGER NOT NULL,
    "approved_by_id" INTEGER NOT NULL,

    CONSTRAINT "weekly_attendances_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "seasons" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "image_url" TEXT,
    "start_date" TIMESTAMP(3),
    "end_date" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "life_cycle_status" "LifeCycleStatus" NOT NULL,
    "unit_id" INTEGER NOT NULL,

    CONSTRAINT "seasons_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "season_records" (
    "id" SERIAL NOT NULL,
    "count_in_season" INTEGER NOT NULL,
    "actual_point" DOUBLE PRECISION NOT NULL,
    "ovr_place" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "approval_status" "ApprovalStatus" NOT NULL,
    "contest_id" INTEGER NOT NULL,
    "scout_profile_id" INTEGER NOT NULL,
    "approved_by_id" INTEGER,

    CONSTRAINT "season_records_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "contests" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "image_url" TEXT,
    "count_in_season" INTEGER NOT NULL,
    "point" DOUBLE PRECISION NOT NULL,
    "start_date" TIMESTAMP(3),
    "end_date" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "life_cycle_status" "LifeCycleStatus" NOT NULL,
    "contest_format" "ContestFormat" NOT NULL,
    "contest_type" "ContestType" NOT NULL,
    "season_id" INTEGER NOT NULL,

    CONSTRAINT "contests_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "challenges" (
    "id" SERIAL NOT NULL,
    "description" TEXT NOT NULL,
    "image_url" TEXT,
    "point_weight" DOUBLE PRECISION NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "life_cycle_status" "LifeCycleStatus" NOT NULL,
    "contest_id" INTEGER NOT NULL,
    "rank_id" INTEGER,

    CONSTRAINT "challenges_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "challenge_records" (
    "id" SERIAL NOT NULL,
    "proof_url" TEXT,
    "comment" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "approval_status" "ApprovalStatus" NOT NULL,
    "challenge_id" INTEGER NOT NULL,
    "scout_profile_id" INTEGER NOT NULL,
    "approved_by_id" INTEGER,

    CONSTRAINT "challenge_records_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "camps" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "image_url" TEXT,
    "location" TEXT NOT NULL,
    "start_date" TIMESTAMP(3) NOT NULL,
    "end_date" TIMESTAMP(3) NOT NULL,
    "day_count" INTEGER NOT NULL,
    "night_count" INTEGER NOT NULL,
    "transportation_cut_off" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "approval_status" "ApprovalStatus" NOT NULL,
    "leader_id" INTEGER NOT NULL,

    CONSTRAINT "camps_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "camp_fees" (
    "id" SERIAL NOT NULL,
    "amount" INTEGER NOT NULL,
    "due_date" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "approval_status" "ApprovalStatus" NOT NULL,
    "section" "Section" NOT NULL,
    "camp_id" INTEGER NOT NULL,

    CONSTRAINT "camp_fees_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "camp_attendance" (
    "id" SERIAL NOT NULL,
    "is_independent" BOOLEAN NOT NULL DEFAULT false,
    "actual_fee" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "camp_attendance_status" "CampAttendanceStatus" NOT NULL,
    "payment_method" "PaymentMethod" NOT NULL,
    "payment_status" "PaymentStatus" NOT NULL,
    "camp_id" INTEGER NOT NULL,
    "attendee_id" INTEGER NOT NULL,
    "approved_by_id" INTEGER NOT NULL,

    CONSTRAINT "camp_attendance_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "camp_transactions" (
    "id" SERIAL NOT NULL,
    "amount" INTEGER NOT NULL,
    "note" TEXT,
    "transaction_date" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "payment_method" "PaymentMethod" NOT NULL,
    "payment_status" "PaymentStatus" NOT NULL,
    "camp_attendance_id" INTEGER,
    "camp_expense_id" INTEGER,

    CONSTRAINT "camp_transactions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "camp_expenses" (
    "id" SERIAL NOT NULL,
    "amount" INTEGER NOT NULL,
    "reason" TEXT,
    "expense_date" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "payment_method" "PaymentMethod" NOT NULL,
    "payment_status" "PaymentStatus" NOT NULL,
    "camp_id" INTEGER NOT NULL,
    "attendee_id" INTEGER NOT NULL,
    "approved_by_id" INTEGER NOT NULL,

    CONSTRAINT "camp_expenses_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_PermissionToRole" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_PermissionToRole_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE UNIQUE INDEX "user_profiles_mail_key" ON "user_profiles"("mail");

-- CreateIndex
CREATE UNIQUE INDEX "user_profiles_username_key" ON "user_profiles"("username");

-- CreateIndex
CREATE UNIQUE INDEX "scout_profiles_code_key" ON "scout_profiles"("code");

-- CreateIndex
CREATE UNIQUE INDEX "scout_profiles_citizen_id_key" ON "scout_profiles"("citizen_id");

-- CreateIndex
CREATE UNIQUE INDEX "scout_profiles_user_profile_id_key" ON "scout_profiles"("user_profile_id");

-- CreateIndex
CREATE UNIQUE INDEX "permissions_name_key" ON "permissions"("name");

-- CreateIndex
CREATE UNIQUE INDEX "roles_name_key" ON "roles"("name");

-- CreateIndex
CREATE UNIQUE INDEX "weekly_attendances_date_attendee_id_key" ON "weekly_attendances"("date", "attendee_id");

-- CreateIndex
CREATE UNIQUE INDEX "seasons_name_key" ON "seasons"("name");

-- CreateIndex
CREATE UNIQUE INDEX "season_records_contest_id_scout_profile_id_key" ON "season_records"("contest_id", "scout_profile_id");

-- CreateIndex
CREATE UNIQUE INDEX "contests_name_season_id_key" ON "contests"("name", "season_id");

-- CreateIndex
CREATE UNIQUE INDEX "challenge_records_challenge_id_scout_profile_id_key" ON "challenge_records"("challenge_id", "scout_profile_id");

-- CreateIndex
CREATE UNIQUE INDEX "camp_transactions_camp_attendance_id_key" ON "camp_transactions"("camp_attendance_id");

-- CreateIndex
CREATE UNIQUE INDEX "camp_transactions_camp_expense_id_key" ON "camp_transactions"("camp_expense_id");

-- CreateIndex
CREATE INDEX "_PermissionToRole_B_index" ON "_PermissionToRole"("B");

-- AddForeignKey
ALTER TABLE "scout_profiles" ADD CONSTRAINT "scout_profiles_user_profile_id_fkey" FOREIGN KEY ("user_profile_id") REFERENCES "user_profiles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "scout_profiles" ADD CONSTRAINT "scout_profiles_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "roles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "profile_details" ADD CONSTRAINT "profile_details_scout_profile_id_fkey" FOREIGN KEY ("scout_profile_id") REFERENCES "scout_profiles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "profile_details" ADD CONSTRAINT "profile_details_achievement_id_fkey" FOREIGN KEY ("achievement_id") REFERENCES "achievements"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "profile_details" ADD CONSTRAINT "profile_details_unit_id_fkey" FOREIGN KEY ("unit_id") REFERENCES "units"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "units" ADD CONSTRAINT "units_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "units"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "weekly_attendances" ADD CONSTRAINT "weekly_attendances_attendee_id_fkey" FOREIGN KEY ("attendee_id") REFERENCES "scout_profiles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "weekly_attendances" ADD CONSTRAINT "weekly_attendances_approved_by_id_fkey" FOREIGN KEY ("approved_by_id") REFERENCES "scout_profiles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "seasons" ADD CONSTRAINT "seasons_unit_id_fkey" FOREIGN KEY ("unit_id") REFERENCES "units"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "season_records" ADD CONSTRAINT "season_records_contest_id_fkey" FOREIGN KEY ("contest_id") REFERENCES "contests"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "season_records" ADD CONSTRAINT "season_records_scout_profile_id_fkey" FOREIGN KEY ("scout_profile_id") REFERENCES "scout_profiles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "season_records" ADD CONSTRAINT "season_records_approved_by_id_fkey" FOREIGN KEY ("approved_by_id") REFERENCES "scout_profiles"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contests" ADD CONSTRAINT "contests_season_id_fkey" FOREIGN KEY ("season_id") REFERENCES "seasons"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "challenges" ADD CONSTRAINT "challenges_contest_id_fkey" FOREIGN KEY ("contest_id") REFERENCES "contests"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "challenges" ADD CONSTRAINT "challenges_rank_id_fkey" FOREIGN KEY ("rank_id") REFERENCES "achievements"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "challenge_records" ADD CONSTRAINT "challenge_records_challenge_id_fkey" FOREIGN KEY ("challenge_id") REFERENCES "challenges"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "challenge_records" ADD CONSTRAINT "challenge_records_scout_profile_id_fkey" FOREIGN KEY ("scout_profile_id") REFERENCES "scout_profiles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "challenge_records" ADD CONSTRAINT "challenge_records_approved_by_id_fkey" FOREIGN KEY ("approved_by_id") REFERENCES "scout_profiles"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "camps" ADD CONSTRAINT "camps_leader_id_fkey" FOREIGN KEY ("leader_id") REFERENCES "scout_profiles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "camp_fees" ADD CONSTRAINT "camp_fees_camp_id_fkey" FOREIGN KEY ("camp_id") REFERENCES "camps"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "camp_attendance" ADD CONSTRAINT "camp_attendance_camp_id_fkey" FOREIGN KEY ("camp_id") REFERENCES "camps"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "camp_attendance" ADD CONSTRAINT "camp_attendance_attendee_id_fkey" FOREIGN KEY ("attendee_id") REFERENCES "scout_profiles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "camp_attendance" ADD CONSTRAINT "camp_attendance_approved_by_id_fkey" FOREIGN KEY ("approved_by_id") REFERENCES "scout_profiles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "camp_transactions" ADD CONSTRAINT "camp_transactions_camp_attendance_id_fkey" FOREIGN KEY ("camp_attendance_id") REFERENCES "camp_attendance"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "camp_transactions" ADD CONSTRAINT "camp_transactions_camp_expense_id_fkey" FOREIGN KEY ("camp_expense_id") REFERENCES "camp_expenses"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "camp_expenses" ADD CONSTRAINT "camp_expenses_camp_id_fkey" FOREIGN KEY ("camp_id") REFERENCES "camps"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "camp_expenses" ADD CONSTRAINT "camp_expenses_attendee_id_fkey" FOREIGN KEY ("attendee_id") REFERENCES "scout_profiles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "camp_expenses" ADD CONSTRAINT "camp_expenses_approved_by_id_fkey" FOREIGN KEY ("approved_by_id") REFERENCES "scout_profiles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PermissionToRole" ADD CONSTRAINT "_PermissionToRole_A_fkey" FOREIGN KEY ("A") REFERENCES "permissions"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PermissionToRole" ADD CONSTRAINT "_PermissionToRole_B_fkey" FOREIGN KEY ("B") REFERENCES "roles"("id") ON DELETE CASCADE ON UPDATE CASCADE;
