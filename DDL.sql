-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Table `Users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Users` ;

CREATE TABLE IF NOT EXISTS `Users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(255) NOT NULL,
  `last_name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NULL,
  `date_joined` DATETIME NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Playlists`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Playlists` ;

CREATE TABLE IF NOT EXISTS `Playlists` (
  `playlist_id` INT NOT NULL,
  `created_date` DATETIME NOT NULL,
  `playlist_name` VARCHAR(2555) NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`playlist_id`),
  INDEX `fk_playlist_user_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `Users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Albums`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Albums` ;

CREATE TABLE IF NOT EXISTS `Albums` (
  `album_id` INT NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `release_date` DATETIME NOT NULL,
  PRIMARY KEY (`album_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Songs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Songs` ;

CREATE TABLE IF NOT EXISTS `Songs` (
  `song_id` INT NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `length` TIME NOT NULL,
  `release_date` DATETIME NOT NULL,
  `album_id` INT NULL,
  PRIMARY KEY (`song_id`),
  INDEX `fk_song_album1_idx` (`album_id` ASC) VISIBLE,
  CONSTRAINT `fk_song_album1`
    FOREIGN KEY (`album_id`)
    REFERENCES `Albums` (`album_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Playlists_Songs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Playlists_Songs` ;

CREATE TABLE IF NOT EXISTS `Playlists_Songs` (
  `playlist_song_id` INT NOT NULL,
  `playlist_id` INT NOT NULL,
  `song_id` INT NOT NULL,
  PRIMARY KEY (`playlist_song_id`),
  INDEX `fk_playlist_song_playlist1_idx` (`playlist_id` ASC) VISIBLE,
  INDEX `fk_playlist_song_song1_idx` (`song_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_song_playlist1`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `Playlists` (`playlist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_playlist_song_song1`
    FOREIGN KEY (`song_id`)
    REFERENCES `Songs` (`song_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Artists`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Artists` ;

CREATE TABLE IF NOT EXISTS `Artists` (
  `artist_id` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `bio` VARCHAR(255) NOT NULL,
  `genre` VARCHAR(255) NOT NULL,
  `label` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`artist_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Artists_Songs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Artists_Songs` ;

CREATE TABLE IF NOT EXISTS `Artists_Songs` (
  `artist_song_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `artist_id` INT NOT NULL,
  `song_id` INT NOT NULL,
  PRIMARY KEY (`artist_song_id`),
  INDEX `fk_Artists_Songs_Artists1_idx` (`artist_id` ASC) VISIBLE,
  INDEX `fk_Artists_Songs_Songs1_idx` (`song_id` ASC) VISIBLE,
  CONSTRAINT `fk_Artists_Songs_Artists1`
    FOREIGN KEY (`artist_id`)
    REFERENCES `Artists` (`artist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Artists_Songs_Songs1`
    FOREIGN KEY (`song_id`)
    REFERENCES `Songs` (`song_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Artists_Albums`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Artists_Albums` ;

CREATE TABLE IF NOT EXISTS `Artists_Albums` (
  `artist_album_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `artist_id` INT NOT NULL,
  `album_id` INT NOT NULL,
  PRIMARY KEY (`artist_album_id`),
  INDEX `fk_Artists_Albums_Artists1_idx` (`artist_id` ASC) VISIBLE,
  INDEX `fk_Artists_Albums_Albums1_idx` (`album_id` ASC) VISIBLE,
  CONSTRAINT `fk_Artists_Albums_Artists1`
    FOREIGN KEY (`artist_id`)
    REFERENCES `Artists` (`artist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Artists_Albums_Albums1`
    FOREIGN KEY (`album_id`)
    REFERENCES `Albums` (`album_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;