-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema littlelemondm
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema littlelemondm
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `littlelemondm` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `littlelemondm` ;

-- -----------------------------------------------------
-- Table `littlelemondm`.`orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `littlelemondm`.`orders` ;

CREATE TABLE IF NOT EXISTS `littlelemondm`.`orders` (
  `OrderID` VARCHAR(100) NOT NULL,
  `CustomerID` VARCHAR(100) NOT NULL,
  `MenuID` VARCHAR(100) NOT NULL,
  `StaffID` VARCHAR(45) NOT NULL,
  `Date` DATE NOT NULL,
  `Quantiy` INT NOT NULL,
  `TotalCost` DECIMAL(10,0) NOT NULL,
  PRIMARY KEY (`OrderID`, `CustomerID`),
  INDEX `MenuID` (`MenuID` ASC) INVISIBLE,
  INDEX `StaffID` (`StaffID` ASC) INVISIBLE,
  INDEX `OrderID` (`OrderID` ASC) VISIBLE,
  INDEX `CustomerID` (`CustomerID` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `littlelemondm`.`customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `littlelemondm`.`customers` ;

CREATE TABLE IF NOT EXISTS `littlelemondm`.`customers` (
  `CustomerID` VARCHAR(100) NOT NULL,
  `OrderID` VARCHAR(45) NOT NULL,
  `Phone` VARCHAR(100) NOT NULL,
  `Address` VARCHAR(100) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CustomerID`),
  INDEX `OrderID_idx` (`OrderID` ASC) VISIBLE,
  CONSTRAINT `OrderID`
    FOREIGN KEY (`OrderID`)
    REFERENCES `littlelemondm`.`orders` (`OrderID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `littlelemondm`.`bookings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `littlelemondm`.`bookings` ;

CREATE TABLE IF NOT EXISTS `littlelemondm`.`bookings` (
  `BookingID` VARCHAR(100) NOT NULL,
  `CustomerID` VARCHAR(100) NOT NULL,
  `Date` DATE NOT NULL,
  `TableNo` INT NOT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `OrderID_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `CustomerID`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `littlelemondm`.`customers` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `littlelemondm`.`menu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `littlelemondm`.`menu` ;

CREATE TABLE IF NOT EXISTS `littlelemondm`.`menu` (
  `MenuID` VARCHAR(100) NOT NULL,
  `Speciality` VARCHAR(45) NOT NULL,
  `Starter` VARCHAR(45) NOT NULL,
  `Main` VARCHAR(45) NOT NULL,
  `Dessert` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`MenuID`),
  CONSTRAINT `MenuID`
    FOREIGN KEY (`MenuID`)
    REFERENCES `littlelemondm`.`orders` (`OrderID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `littlelemondm`.`staff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `littlelemondm`.`staff` ;

CREATE TABLE IF NOT EXISTS `littlelemondm`.`staff` (
  `StaffID` VARCHAR(100) NOT NULL,
  `FullName` VARCHAR(45) NULL DEFAULT NULL,
  `Position` VARCHAR(45) NULL DEFAULT NULL,
  `Salary` DECIMAL(10,0) NULL DEFAULT NULL,
  PRIMARY KEY (`StaffID`),
  CONSTRAINT `StaffID`
    FOREIGN KEY (`StaffID`)
    REFERENCES `littlelemondm`.`orders` (`StaffID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
