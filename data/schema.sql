CREATE TABLE `BoredEvent` (
  `idBoredEvent` INT NOT NULL ,
  `fk_idBoredInterest` INT NULL ,
  `EventTitle` VARCHAR(45) NULL ,
  `fk_idBuilding` VARCHAR(5) NULL ,
  PRIMARY KEY (`idBoredEvent`) ,
  CONSTRAINT `fk_idBoredInterest`
    FOREIGN KEY (`fk_idBoredInterest` )
    REFERENCES `BoredInterest` (`idBoredInterest` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_idBuilding`
    FOREIGN KEY (`fk_idBuilding` )
    REFERENCES `Building` (`idBuilding` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE TABLE `BoredInterest` (
  `idBoredInterest` INT NOT NULL  ,
  `InterestName` VARCHAR(45) NULL ,
  `Interested` TINYINT(1)  NULL ,
  PRIMARY KEY (`idBoredInterest`) );
CREATE TABLE `Building` (
  `idBuilding` VARCHAR(5) NOT NULL ,
  `Name` VARCHAR(45) NULL ,
  `fk_idGPS` INT NULL ,

  PRIMARY KEY (`idBuilding`) ,
  CONSTRAINT `fk_idGPS`
    FOREIGN KEY (`fk_idGPS` )
    REFERENCES `GPS` (`idGPS` )
    ON DELETE CASCADE
    ON UPDATE CASCADE);
CREATE TABLE `Classroom` (
  `idClassroom` INT NOT NULL ,
  `fk_idBuilding` INT NULL ,
  `RoomNumber` VARCHAR(20) NULL ,
  PRIMARY KEY (`idClassroom`) ,

  CONSTRAINT `fk_idBuilding`
    FOREIGN KEY (`fk_idBuilding` )
    REFERENCES `Building` (`idBuilding` )
    ON DELETE CASCADE
    ON UPDATE CASCADE);
CREATE TABLE `Course` (
  `id` INTEGER PRIMARY KEY,
  `number` VARCHAR(5) NOT NULL ,
  `title` VARCHAR(45) NULL ,
  `subject_id` INTEGER NOT NULL ,
  CONSTRAINT `subject_id`
    FOREIGN KEY (`subject_id` )
    REFERENCES `Subject` (`id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE);
CREATE TABLE `CourseSection` (
  `idCRN` INT NOT NULL ,
  `fk_idSemester` INT NULL ,
  `SectionNum` CHAR(2) NULL ,
  `StartTime` DATETIME NULL ,
  `EndTime` DATETIME NULL ,
  `Days` BIT NULL ,
  `fk_idClassRoom` INT NULL ,
  `InstructorLName` VARCHAR(45) NULL ,
  `fk_idCourse` INT NULL ,
  PRIMARY KEY (`idCRN`) ,

  CONSTRAINT `fk_idCourse`
    FOREIGN KEY (`fk_idCourse` )
    REFERENCES `Course` (`idCourse` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_idClassroom`
    FOREIGN KEY (`fk_idClassRoom` )
    REFERENCES `Classroom` (`idClassroom` )
    ON DELETE CASCADe
    ON UPDATE CASCADE,
  CONSTRAINT `fk_idSemester`
    FOREIGN KEY (`fk_idSemester` )
    REFERENCES `Semester` (`idSemester` )
    ON DELETE CASCADE
    ON UPDATE CASCADE);
CREATE TABLE `GPS` (
  `idGPS` INT NOT NULL ,
  `Latitude` DECIMAL(9,6) NULL ,
  `Longitude` DECIMAL(9,6) NULL ,
  `Radius` INT NULL ,
  PRIMARY KEY (`idGPS`) );
CREATE TABLE `Semester` (
  `idSemester` INT NOT NULL ,
  `Year` INT NULL ,
  `Season` CHAR(2) NULL ,
  PRIMARY KEY (`idSemester`) );
CREATE TABLE `Student` (
  `idStudent` INT NOT NULL ,
  `LName` VARCHAR(45) NULL ,
  `FName` VARCHAR(45) NULL ,
  `Email` VARCHAR(45) NULL ,
  PRIMARY KEY (`idStudent`) );
CREATE TABLE `StudyBuddy` (
  `idStudyBuddy` INT NOT NULL  ,
  `SBFName` VARCHAR(45) NULL ,
  `SBLName` VARCHAR(45) NULL ,
  `fk_idCRN` INT NULL ,
  PRIMARY KEY (`idStudyBuddy`) ,
  CONSTRAINT `fk_idCRN`
    FOREIGN KEY (`fk_idCRN` )
    REFERENCES `CourseSection` (`idCRN` )
    ON DELETE CASCADE
    ON UPDATE CASCADE);
CREATE TABLE `Subject` (
  id INTEGER PRIMARY KEY,
  abbr VARCHAR(5) NOT NULL ,
  title VARCHAR(100) NULL
);