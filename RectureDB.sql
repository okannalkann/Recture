-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema rectureDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema rectureDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `rectureDB` DEFAULT CHARACTER SET utf8 ;
USE `rectureDB` ;

-- -----------------------------------------------------
-- Table `rectureDB`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rectureDB`.`User` (
  `idUser` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `userType` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `email` VARCHAR(70) NOT NULL,
  `ImageUrl` VARCHAR(45) NULL,
  PRIMARY KEY (`idUser`),
  UNIQUE INDEX `idUser_UNIQUE` (`idUser` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rectureDB`.`Premium`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rectureDB`.`Premium` (
  `idPremium` INT NOT NULL AUTO_INCREMENT,
  `User_idUser` INT NOT NULL,
  PRIMARY KEY (`idPremium`, `User_idUser`),
  UNIQUE INDEX `idPremium_UNIQUE` (`idPremium` ASC) VISIBLE,
  INDEX `fk_Premium_User1_idx` (`User_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_Premium_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `rectureDB`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rectureDB`.`card`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rectureDB`.`card` (
  `idCard` INT NOT NULL AUTO_INCREMENT,
  `Card_no` VARCHAR(100) NOT NULL,
  `Card_password` VARCHAR(45) NOT NULL,
  `Card_date` VARCHAR(45) NOT NULL,
  `Card_cvc` VARCHAR(45) NOT NULL,
  `Card_name` VARCHAR(45) NOT NULL,
  `Premium_idPremium` INT NOT NULL,
  `Premium_User_idUser` INT NOT NULL,
  PRIMARY KEY (`idCard`),
  UNIQUE INDEX `idPremium_UNIQUE` (`idCard` ASC) VISIBLE,
  UNIQUE INDEX `Card_no_UNIQUE` (`Card_no` ASC) VISIBLE,
  INDEX `fk_card_Premium1_idx` (`Premium_idPremium` ASC, `Premium_User_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_card_Premium1`
    FOREIGN KEY (`Premium_idPremium` , `Premium_User_idUser`)
    REFERENCES `rectureDB`.`Premium` (`idPremium` , `User_idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rectureDB`.`Instructor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rectureDB`.`Instructor` (
  `idInstructor` INT NOT NULL AUTO_INCREMENT,
  `Iban_no` VARCHAR(200) NOT NULL,
  `cv` LONGTEXT NOT NULL,
  `User_idUser` INT NOT NULL,
  `course` DATETIME NULL,
  `Score` DOUBLE NOT NULL,
  PRIMARY KEY (`idInstructor`, `User_idUser`),
  UNIQUE INDEX `idInstructor_UNIQUE` (`idInstructor` ASC) VISIBLE,
  INDEX `fk_Instructor_User1_idx` (`User_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_Instructor_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `rectureDB`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rectureDB`.`MessageForPanel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rectureDB`.`MessageForPanel` (
  `idMessageForPanel` INT NOT NULL AUTO_INCREMENT,
  `User_idUser` INT NOT NULL,
  `ReportNum` INT NOT NULL DEFAULT 0,
  `Imageurl` VARCHAR(120) NULL,
  `Date` DATETIME NULL,
  `messages` LONGTEXT NOT NULL,
  PRIMARY KEY (`idMessageForPanel`),
  UNIQUE INDEX `idMessageForPanel_UNIQUE` (`idMessageForPanel` ASC) VISIBLE,
  INDEX `fk_MessageForPanel_User1_idx` (`User_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_MessageForPanel_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `rectureDB`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rectureDB`.`AskToTeacher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rectureDB`.`AskToTeacher` (
  `idAskToTeacher` INT NOT NULL AUTO_INCREMENT,
  `Premium_idPremium` INT NOT NULL,
  `question` LONGTEXT NULL,
  `qUrl` VARCHAR(200) NULL,
  `answer` LONGTEXT NULL,
  `aUrl` VARCHAR(200) NULL,
  `course` VARCHAR(45) NOT NULL,
  `date` DATETIME NOT NULL,
  `Instructor_idInstructor` INT NOT NULL,
  `Instructor_User_idUser` INT NOT NULL,
  PRIMARY KEY (`idAskToTeacher`, `Premium_idPremium`, `Instructor_idInstructor`, `Instructor_User_idUser`),
  UNIQUE INDEX `idAskToTeacher_UNIQUE` (`idAskToTeacher` ASC) VISIBLE,
  INDEX `fk_AskToTeacher_Premium1_idx` (`Premium_idPremium` ASC) VISIBLE,
  INDEX `fk_AskToTeacher_Instructor1_idx` (`Instructor_idInstructor` ASC, `Instructor_User_idUser` ASC) VISIBLE,
  UNIQUE INDEX `Instructor_idInstructor_UNIQUE` (`Instructor_idInstructor` ASC) VISIBLE,
  UNIQUE INDEX `Instructor_User_idUser_UNIQUE` (`Instructor_User_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_AskToTeacher_Premium1`
    FOREIGN KEY (`Premium_idPremium`)
    REFERENCES `rectureDB`.`Premium` (`idPremium`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AskToTeacher_Instructor1`
    FOREIGN KEY (`Instructor_idInstructor` , `Instructor_User_idUser`)
    REFERENCES `rectureDB`.`Instructor` (`idInstructor` , `User_idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rectureDB`.`Video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rectureDB`.`Video` (
  `idCourseVideo` INT NOT NULL AUTO_INCREMENT,
  `Instructor_idInstructor` INT NOT NULL,
  `Description` LONGTEXT NOT NULL,
  `Title` VARCHAR(45) NOT NULL,
  `date` DATETIME NOT NULL,
  `VideoUrl` LONGTEXT NOT NULL,
  `Category` VARCHAR(45) NULL,
  PRIMARY KEY (`idCourseVideo`, `Instructor_idInstructor`),
  UNIQUE INDEX `idCourseVideo_UNIQUE` (`idCourseVideo` ASC) VISIBLE,
  INDEX `fk_CourseVideo_Instructor1_idx` (`Instructor_idInstructor` ASC) VISIBLE,
  CONSTRAINT `fk_CourseVideo_Instructor1`
    FOREIGN KEY (`Instructor_idInstructor`)
    REFERENCES `rectureDB`.`Instructor` (`idInstructor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rectureDB`.`Course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rectureDB`.`Course` (
  `idCourse` INT NOT NULL AUTO_INCREMENT,
  `category` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCourse`),
  UNIQUE INDEX `idCourse_UNIQUE` (`idCourse` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rectureDB`.`CourseLink`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rectureDB`.`CourseLink` (
  `idCourseLink` INT NOT NULL AUTO_INCREMENT,
  `CourseLinkcol` VARCHAR(45) NULL,
  `Instructor_idInstructor` INT NOT NULL,
  `Instructor_User_idUser` INT NOT NULL,
  PRIMARY KEY (`idCourseLink`, `Instructor_idInstructor`, `Instructor_User_idUser`),
  UNIQUE INDEX `idCourseLink_UNIQUE` (`idCourseLink` ASC) VISIBLE,
  INDEX `fk_CourseLink_Instructor1_idx` (`Instructor_idInstructor` ASC, `Instructor_User_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_CourseLink_Instructor1`
    FOREIGN KEY (`Instructor_idInstructor` , `Instructor_User_idUser`)
    REFERENCES `rectureDB`.`Instructor` (`idInstructor` , `User_idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rectureDB`.`Course_has_Instructor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rectureDB`.`Course_has_Instructor` (
  `Course_idCourse` INT NOT NULL,
  `Instructor_idInstructor` INT NOT NULL,
  `Instructor_User_idUser` INT NOT NULL,
  PRIMARY KEY (`Course_idCourse`, `Instructor_idInstructor`, `Instructor_User_idUser`),
  INDEX `fk_Course_has_Instructor_Instructor1_idx` (`Instructor_idInstructor` ASC, `Instructor_User_idUser` ASC) VISIBLE,
  INDEX `fk_Course_has_Instructor_Course1_idx` (`Course_idCourse` ASC) VISIBLE,
  CONSTRAINT `fk_Course_has_Instructor_Course1`
    FOREIGN KEY (`Course_idCourse`)
    REFERENCES `rectureDB`.`Course` (`idCourse`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Course_has_Instructor_Instructor1`
    FOREIGN KEY (`Instructor_idInstructor` , `Instructor_User_idUser`)
    REFERENCES `rectureDB`.`Instructor` (`idInstructor` , `User_idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rectureDB`.`Premium_has_CourseLink`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rectureDB`.`Premium_has_CourseLink` (
  `Premium_idPremium` INT NOT NULL,
  `Premium_User_idUser` INT NOT NULL,
  `CourseLink_idCourseLink` INT NOT NULL,
  `CourseLink_Instructor_idInstructor` INT NOT NULL,
  `CourseLink_Instructor_User_idUser` INT NOT NULL,
  PRIMARY KEY (`Premium_idPremium`, `Premium_User_idUser`, `CourseLink_idCourseLink`, `CourseLink_Instructor_idInstructor`, `CourseLink_Instructor_User_idUser`),
  INDEX `fk_Premium_has_CourseLink_CourseLink1_idx` (`CourseLink_idCourseLink` ASC, `CourseLink_Instructor_idInstructor` ASC, `CourseLink_Instructor_User_idUser` ASC) VISIBLE,
  INDEX `fk_Premium_has_CourseLink_Premium1_idx` (`Premium_idPremium` ASC, `Premium_User_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_Premium_has_CourseLink_Premium1`
    FOREIGN KEY (`Premium_idPremium` , `Premium_User_idUser`)
    REFERENCES `rectureDB`.`Premium` (`idPremium` , `User_idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Premium_has_CourseLink_CourseLink1`
    FOREIGN KEY (`CourseLink_idCourseLink` , `CourseLink_Instructor_idInstructor` , `CourseLink_Instructor_User_idUser`)
    REFERENCES `rectureDB`.`CourseLink` (`idCourseLink` , `Instructor_idInstructor` , `Instructor_User_idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rectureDB`.`application`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rectureDB`.`application` (
  `idapplication` INT NOT NULL AUTO_INCREMENT,
  `cv` LONGTEXT NOT NULL,
  `Description` LONGTEXT NOT NULL,
  `IsApproved` INT NULL,
  `name` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `ImageUrl` VARCHAR(45) NULL,
  PRIMARY KEY (`idapplication`),
  UNIQUE INDEX `idapplication_UNIQUE` (`idapplication` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rectureDB`.`Contact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rectureDB`.`Contact` (
  `idContact` INT NOT NULL AUTO_INCREMENT,
  `Message` LONGTEXT NOT NULL,
  `name` VARCHAR(45) NULL,
  `email` VARCHAR(100) NULL,
  `message` LONGTEXT NULL,
  `messageType` VARCHAR(45) NOT NULL,
  `Date` DATETIME NULL,
  PRIMARY KEY (`idContact`),
  UNIQUE INDEX `idContact_UNIQUE` (`idContact` ASC) VISIBLE,
  INDEX `fk_Contact_User1_idx` (`name` ASC) VISIBLE,
  UNIQUE INDEX `User_idUser_UNIQUE` (`name` ASC) VISIBLE,
  CONSTRAINT `fk_Contact_User1`
    FOREIGN KEY (`name`)
    REFERENCES `rectureDB`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
