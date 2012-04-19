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
    id INTEGER PRIMARY KEY,
  `abbr` VARCHAR(5) NOT NULL ,
  `name` VARCHAR(45) NULL ,
  gps_id INT NOT NULL,

  CONSTRAINT gps_id
    FOREIGN KEY (`gps_id` )
    REFERENCES `GPS` (`idGPS` )
    ON DELETE CASCADE
    ON UPDATE CASCADE);
CREATE TABLE `Classroom` (
  id INTEGER PRIMARY KEY,
  room VARCHAR(20) NULL,
  building_id INTEGER NOT NULL,
  CONSTRAINT building_id
    FOREIGN KEY (building_id)
    REFERENCES Building(id)
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
  id INTEGER PRIMARY KEY,
  crn INTEGER NOT NULL,
  number VARCHAR(2) NOT NULL,
  start_time CHAR(4) NULL,
  end_time CHAR(4) NULL,
  days INTEGER NULL,
  course_id INTEGER NOT NULL,
  classroom_id INTEGER NOT NULL,
  semester_id INTEGER NOT NULL,
  CONSTRAINT course_id    FOREIGN KEY (course_id)    REFERENCES Course(id)
  CONSTRAINT classroom_id FOREIGN KEY (classroom_id) REFERENCES Classroom(id),
  CONSTRAINT semester_id  FOREIGN KEY (semester_id)  REFERENCES Semester(id)
);
CREATE TABLE `GPS` (
  `idGPS` INTEGER PRIMARY KEY,
  `Latitude` DECIMAL(9,6) NULL ,
  `Longitude` DECIMAL(9,6) NULL ,
  `Radius` INT NULL);
CREATE TABLE `Semester` (
  `id` INTEGER PRIMARY KEY ,
  `year` INTEGER NOT NULL ,
  `season` CHAR(2) NOT NULL);
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
