-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
SHOW WARNINGS;
-- -----------------------------------------------------
-- Schema pvfc
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `pvfc` ;

-- -----------------------------------------------------
-- Schema pvfc
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pvfc` ;
SHOW WARNINGS;
USE `pvfc` ;

-- -----------------------------------------------------
-- Table `pvfc`.`Product_lines`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pvfc`.`Product_lines` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `pvfc`.`Product_lines` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `pvfc`.`Products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pvfc`.`Products` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `pvfc`.`Products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(45) NOT NULL,
  `finish` VARCHAR(45) NOT NULL,
  `unit_price` DECIMAL(10,2) NOT NULL,
  `Product_lines_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Products_Product_lines1_idx` (`Product_lines_id` ASC) VISIBLE,
  CONSTRAINT `fk_Products_Product_lines1`
    FOREIGN KEY (`Product_lines_id`)
    REFERENCES `pvfc`.`Product_lines` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `pvfc`.`Customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pvfc`.`Customers` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `pvfc`.`Customers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `pvfc`.`Orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pvfc`.`Orders` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `pvfc`.`Orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` VARCHAR(45) NOT NULL,
  `Customers_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Orders_Customers1_idx` (`Customers_id` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Customers1`
    FOREIGN KEY (`Customers_id`)
    REFERENCES `pvfc`.`Customers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `pvfc`.`Order_lines`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pvfc`.`Order_lines` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `pvfc`.`Order_lines` (
  `Products_id` INT NOT NULL,
  `Orders_id` INT NOT NULL,
  `Quantity` INT NOT NULL,
  PRIMARY KEY (`Products_id`, `Orders_id`),
  INDEX `fk_Products_has_Orders_Orders1_idx` (`Orders_id` ASC) VISIBLE,
  INDEX `fk_Products_has_Orders_Products1_idx` (`Products_id` ASC) VISIBLE,
  CONSTRAINT `fk_Products_has_Orders_Products1`
    FOREIGN KEY (`Products_id`)
    REFERENCES `pvfc`.`Products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Products_has_Orders_Orders1`
    FOREIGN KEY (`Orders_id`)
    REFERENCES `pvfc`.`Orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `pvfc`.`Territories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pvfc`.`Territories` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `pvfc`.`Territories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `pvfc`.`Does_business_in`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pvfc`.`Does_business_in` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `pvfc`.`Does_business_in` (
  `Customers_id` INT NOT NULL,
  `Territories_id` INT NOT NULL,
  PRIMARY KEY (`Customers_id`, `Territories_id`),
  INDEX `fk_Customers_has_Territories_Territories1_idx` (`Territories_id` ASC) VISIBLE,
  INDEX `fk_Customers_has_Territories_Customers1_idx` (`Customers_id` ASC) VISIBLE,
  CONSTRAINT `fk_Customers_has_Territories_Customers1`
    FOREIGN KEY (`Customers_id`)
    REFERENCES `pvfc`.`Customers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Customers_has_Territories_Territories1`
    FOREIGN KEY (`Territories_id`)
    REFERENCES `pvfc`.`Territories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `pvfc`.`Salespersons`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pvfc`.`Salespersons` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `pvfc`.`Salespersons` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `telephone` VARCHAR(45) NULL,
  `fax` VARCHAR(45) NULL,
  `Territories_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Salespersons_Territories1_idx` (`Territories_id` ASC) VISIBLE,
  CONSTRAINT `fk_Salespersons_Territories1`
    FOREIGN KEY (`Territories_id`)
    REFERENCES `pvfc`.`Territories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `pvfc`.`RawMaterials`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pvfc`.`RawMaterials` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `pvfc`.`RawMaterials` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `unitOfMeasure` VARCHAR(45) NOT NULL,
  `unitPrice` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `pvfc`.`Uses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pvfc`.`Uses` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `pvfc`.`Uses` (
  `Products_id` INT NOT NULL,
  `RawMaterials_id` INT NOT NULL,
  `GoesIntoQuantity` INT NOT NULL,
  PRIMARY KEY (`Products_id`, `RawMaterials_id`),
  INDEX `fk_Products_has_RawMaterials_RawMaterials1_idx` (`RawMaterials_id` ASC) VISIBLE,
  INDEX `fk_Products_has_RawMaterials_Products1_idx` (`Products_id` ASC) VISIBLE,
  CONSTRAINT `fk_Products_has_RawMaterials_Products1`
    FOREIGN KEY (`Products_id`)
    REFERENCES `pvfc`.`Products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Products_has_RawMaterials_RawMaterials1`
    FOREIGN KEY (`RawMaterials_id`)
    REFERENCES `pvfc`.`RawMaterials` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `pvfc`.`Vendors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pvfc`.`Vendors` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `pvfc`.`Vendors` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `pvfc`.`Supplies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pvfc`.`Supplies` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `pvfc`.`Supplies` (
  `RawMaterials_id` INT NOT NULL,
  `Vendors_id` INT NOT NULL,
  `unitPrice` DECIMAL(10,5) NOT NULL,
  PRIMARY KEY (`RawMaterials_id`, `Vendors_id`),
  INDEX `fk_RawMaterials_has_Vendors_Vendors1_idx` (`Vendors_id` ASC) VISIBLE,
  INDEX `fk_RawMaterials_has_Vendors_RawMaterials1_idx` (`RawMaterials_id` ASC) VISIBLE,
  CONSTRAINT `fk_RawMaterials_has_Vendors_RawMaterials1`
    FOREIGN KEY (`RawMaterials_id`)
    REFERENCES `pvfc`.`RawMaterials` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RawMaterials_has_Vendors_Vendors1`
    FOREIGN KEY (`Vendors_id`)
    REFERENCES `pvfc`.`Vendors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `pvfc`.`Workcenter`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pvfc`.`Workcenter` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `pvfc`.`Workcenter` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `location` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `pvfc`.`ProducedIn`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pvfc`.`ProducedIn` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `pvfc`.`ProducedIn` (
  `Products_id` INT NOT NULL,
  `Workcenter_id` INT NOT NULL,
  PRIMARY KEY (`Products_id`, `Workcenter_id`),
  INDEX `fk_Products_has_Workcenter_Workcenter1_idx` (`Workcenter_id` ASC) VISIBLE,
  INDEX `fk_Products_has_Workcenter_Products1_idx` (`Products_id` ASC) VISIBLE,
  CONSTRAINT `fk_Products_has_Workcenter_Products1`
    FOREIGN KEY (`Products_id`)
    REFERENCES `pvfc`.`Products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Products_has_Workcenter_Workcenter1`
    FOREIGN KEY (`Workcenter_id`)
    REFERENCES `pvfc`.`Workcenter` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `pvfc`.`Employees`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pvfc`.`Employees` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `pvfc`.`Employees` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `Supervisor` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Employees_Employees1_idx` (`Supervisor` ASC) VISIBLE,
  CONSTRAINT `fk_Employees_Employees1`
    FOREIGN KEY (`Supervisor`)
    REFERENCES `pvfc`.`Employees` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `pvfc`.`Skils`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pvfc`.`Skils` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `pvfc`.`Skils` (
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(145) NOT NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `pvfc`.`EmployeeCertification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pvfc`.`EmployeeCertification` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `pvfc`.`EmployeeCertification` (
  `Employees_id` INT NOT NULL,
  `Skils_name` VARCHAR(45) NOT NULL,
  `CompletedOn` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Employees_id`, `Skils_name`),
  INDEX `fk_Employees_has_Skils_Skils1_idx` (`Skils_name` ASC) VISIBLE,
  INDEX `fk_Employees_has_Skils_Employees1_idx` (`Employees_id` ASC) VISIBLE,
  CONSTRAINT `fk_Employees_has_Skils_Employees1`
    FOREIGN KEY (`Employees_id`)
    REFERENCES `pvfc`.`Employees` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employees_has_Skils_Skils1`
    FOREIGN KEY (`Skils_name`)
    REFERENCES `pvfc`.`Skils` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `pvfc`.`WorkIn`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pvfc`.`WorkIn` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `pvfc`.`WorkIn` (
  `Workcenter_id` INT NOT NULL,
  `Employees_id` INT NOT NULL,
  PRIMARY KEY (`Workcenter_id`, `Employees_id`),
  INDEX `fk_Workcenter_has_Employees_Employees1_idx` (`Employees_id` ASC) VISIBLE,
  INDEX `fk_Workcenter_has_Employees_Workcenter1_idx` (`Workcenter_id` ASC) VISIBLE,
  CONSTRAINT `fk_Workcenter_has_Employees_Workcenter1`
    FOREIGN KEY (`Workcenter_id`)
    REFERENCES `pvfc`.`Workcenter` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Workcenter_has_Employees_Employees1`
    FOREIGN KEY (`Employees_id`)
    REFERENCES `pvfc`.`Employees` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
