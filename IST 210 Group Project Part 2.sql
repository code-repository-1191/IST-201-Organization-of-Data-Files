CREATE SCHEMA IF NOT EXISTS `GroupProject` DEFAULT CHARACTER SET utf8 ;
USE `GroupProject` ;

-- -----------------------------------------------------
-- Table `Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GroupProject`.`Customer` (
  `id` INT NOT NULL,
  `first_name` VARCHAR(30) NOT NULL,
  `last_name` VARCHAR(30) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `zip_code` VARCHAR(5) NOT NULL,
  `state` VARCHAR(25) NOT NULL,
  `dob` DATE NULL,
  `identification` ENUM('Liscense', 'Passport', 'Social Security Card') NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `Region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GroupProject`.`Region` (
  `id` INT NOT NULL,
  `hq_state` VARCHAR(25) NOT NULL,
  `hq_city` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GroupProject`.`Category` (
  `category_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`category_id`));


-- -----------------------------------------------------
-- Table `Facility`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GroupProject`.`Facility` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(50) NOT NULL,
  `capacity` INT NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` CHAR(2) NOT NULL,
  `zip` INT NOT NULL,
  `Region_id` INT NOT NULL,
  `Category_category_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Facility_Region1_idx` (`Region_id` ASC) VISIBLE,
  INDEX `fk_Facility_Category1_idx` (`Category_category_id` ASC) VISIBLE,
  CONSTRAINT `fk_Facility_Region1`
    FOREIGN KEY (`Region_id`)
    REFERENCES `mydb`.`Region` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Facility_Category1`
    FOREIGN KEY (`Category_category_id`)
    REFERENCES `mydb`.`Category` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `Booking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GroupProject`.`Booking` (
  `id` INT NOT NULL,
  `begDate` DATE NULL,
  `endDate` TIME NULL,
  `Purpose` VARCHAR(45) NOT NULL,
  `Customer_customer_id` INT NOT NULL,
  `Facility_facility_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Booking_Customer1_idx` (`Customer_customer_id` ASC) VISIBLE,
  INDEX `fk_Booking_Facility1_idx` (`Facility_facility_id` ASC) VISIBLE,
  CONSTRAINT `fk_Booking_Customer1`
    FOREIGN KEY (`Customer_customer_id`)
    REFERENCES `mydb`.`Customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Booking_Facility1`
    FOREIGN KEY (`Facility_facility_id`)
    REFERENCES `mydb`.`Facility` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GroupProject`.`Payment` (
  `method` ENUM('Cash', 'Check', 'Debit Card', 'Credit Card') NOT NULL,
  `amount` INT NOT NULL,
  `date` DATE NULL,
  `Booking_ID` INT NOT NULL,
  `Customer_customer_id` INT NOT NULL,
  PRIMARY KEY (`Booking_ID`, `Customer_customer_id`),
  INDEX `fk_Payment_Booking1_idx` (`Booking_ID` ASC) VISIBLE,
  INDEX `fk_Payment_Customer1_idx` (`Customer_customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_Payment_Booking1`
    FOREIGN KEY (`Booking_ID`)
    REFERENCES `mydb`.`Booking` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Payment_Customer1`
    FOREIGN KEY (`Customer_customer_id`)
    REFERENCES `mydb`.`Customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `Department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GroupProject`.`Department` (
  `id` INT NOT NULL,
  `department_name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GroupProject`.`Employee` (
  `id` INT NOT NULL,
  `first_name` VARCHAR(30) NOT NULL,
  `last_name` VARCHAR(30) NOT NULL,
  `date_hired` DATE NULL,
  `phone` VARCHAR(10) NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `state` VARCHAR(25) NOT NULL,
  `city` VARCHAR(30) NOT NULL,
  `zip` INT NOT NULL,
  `Department_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Employee_Department1_idx` (`Department_id` ASC) VISIBLE,
  CONSTRAINT `fk_Employee_Department1`
    FOREIGN KEY (`Department_id`)
    REFERENCES `mydb`.`Department` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `Strike`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GroupProject`.`Strike` (
  `date` DATE NULL,
  `reason` VARCHAR(45) NOT NULL,
  `Customer_customer_id` INT NOT NULL,
  `Facility_facility_id` INT NOT NULL,
  `Employee_employee_id` INT NOT NULL,
  INDEX `fk_Strike_Customer1_idx` (`Customer_customer_id` ASC) VISIBLE,
  INDEX `fk_Strike_Facility1_idx` (`Facility_facility_id` ASC) VISIBLE,
  INDEX `fk_Strike_Employee1_idx` (`Employee_employee_id` ASC) VISIBLE,
  PRIMARY KEY (`Facility_facility_id`, `Employee_employee_id`, `Customer_customer_id`),
  CONSTRAINT `fk_Strike_Customer1`
    FOREIGN KEY (`Customer_customer_id`)
    REFERENCES `mydb`.`Customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Strike_Facility1`
    FOREIGN KEY (`Facility_facility_id`)
    REFERENCES `mydb`.`Facility` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Strike_Employee1`
    FOREIGN KEY (`Employee_employee_id`)
    REFERENCES `mydb`.`Employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table `Maintenance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GroupProject`.`Maintenance` (
  `id` INT NOT NULL,
  `mainDate` DATE NULL,
  `condition` ENUM('Good', 'Fair', 'Poor', 'Bad') NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `Facility_id` INT NOT NULL,
  `Employee_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Maintenance_Facility1_idx` (`Facility_id` ASC) VISIBLE,
  INDEX `fk_Maintenance_Employee1_idx` (`Employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_Maintenance_Facility1`
    FOREIGN KEY (`Facility_id`)
    REFERENCES `mydb`.`Facility` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Maintenance_Employee1`
    FOREIGN KEY (`Employee_id`)
    REFERENCES `mydb`.`Employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);