

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`user` ;

CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(255) NOT NULL,
  `last_name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NULL,
  `date_joined` DATETIME NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`playlist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`playlist` ;

CREATE TABLE IF NOT EXISTS `mydb`.`playlist` (
  `id` INT NOT NULL,
  `created_date` DATETIME NOT NULL,
  `playlist_name` VARCHAR(2555) NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_playlist_user_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`artist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`artist` ;

CREATE TABLE IF NOT EXISTS `mydb`.`artist` (
  `id` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `bio` VARCHAR(255) NOT NULL,
  `genre` VARCHAR(255) NOT NULL,
  `label` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`album`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`album` ;

CREATE TABLE IF NOT EXISTS `mydb`.`album` (
  `id` INT NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `release_date` DATETIME NOT NULL,
  `artist_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_album_artist1_idx` (`artist_id` ASC) VISIBLE,
  CONSTRAINT `fk_album_artist1`
    FOREIGN KEY (`artist_id`)
    REFERENCES `mydb`.`artist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`song`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`song` ;

CREATE TABLE IF NOT EXISTS `mydb`.`song` (
  `id` INT NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `length` TIME NOT NULL,
  `release_date` DATETIME NOT NULL,
  `album_id` INT NOT NULL,
  `artist_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_song_album1_idx` (`album_id` ASC) VISIBLE,
  INDEX `fk_song_artist1_idx` (`artist_id` ASC) VISIBLE,
  CONSTRAINT `fk_song_album1`
    FOREIGN KEY (`album_id`)
    REFERENCES `mydb`.`album` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_song_artist1`
    FOREIGN KEY (`artist_id`)
    REFERENCES `mydb`.`artist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`playlist_song`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`playlist_song` ;

CREATE TABLE IF NOT EXISTS `mydb`.`playlist_song` (
  `id` INT NOT NULL,
  `playlist_id` INT NOT NULL,
  `song_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_playlist_song_playlist1_idx` (`playlist_id` ASC) VISIBLE,
  INDEX `fk_playlist_song_song1_idx` (`song_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_song_playlist1`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `mydb`.`playlist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_playlist_song_song1`
    FOREIGN KEY (`song_id`)
    REFERENCES `mydb`.`song` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


