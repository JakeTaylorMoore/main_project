# TEAM CAT GROUP 126
# MEMBERS: Michelle Myers & Jacob Moore

-- MySQL Workbench Forward Engineering
USE `wqu793vt17ypbptl`;
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
  `created_at` DATE NULL,
  `password` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Playlists`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Playlists` ;

CREATE TABLE IF NOT EXISTS `Playlists` (
  `playlist_id` INT NOT NULL AUTO_INCREMENT,
  `created_at` DATE NULL,
  `title` VARCHAR(2555) NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`playlist_id`),
  INDEX `fk_playlist_user_idx` (`user_id` ASC) VISIBLE,
  UNIQUE INDEX `playlist_id_UNIQUE` (`playlist_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `Users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Albums`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Albums` ;

CREATE TABLE IF NOT EXISTS `Albums` (
  `album_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `release_date` DATE NULL,
  PRIMARY KEY (`album_id`),
  UNIQUE INDEX `album_id_UNIQUE` (`album_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Songs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Songs` ;

CREATE TABLE IF NOT EXISTS `Songs` (
  `song_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `length` VARCHAR(255) NULL,
  `release_date` DATE NULL,
  `album_id` INT NULL,
  PRIMARY KEY (`song_id`),
  INDEX `fk_song_album1_idx` (`album_id` ASC) VISIBLE,
  UNIQUE INDEX `song_id_UNIQUE` (`song_id` ASC) VISIBLE,
  CONSTRAINT `fk_song_album1`
    FOREIGN KEY (`album_id`)
    REFERENCES `Albums` (`album_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Playlists_Songs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Playlists_Songs` ;

CREATE TABLE IF NOT EXISTS `Playlists_Songs` (
  `playlist_song_id` INT NOT NULL AUTO_INCREMENT,
  `playlist_id` INT NOT NULL,
  `song_id` INT NOT NULL,
  PRIMARY KEY (`playlist_song_id`),
  INDEX `fk_playlist_song_playlist1_idx` (`playlist_id` ASC) VISIBLE,
  INDEX `fk_playlist_song_song1_idx` (`song_id` ASC) VISIBLE,
  UNIQUE INDEX `playlist_song_id_UNIQUE` (`playlist_song_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_song_playlist1`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `Playlists` (`playlist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_playlist_song_song1`
    FOREIGN KEY (`song_id`)
    REFERENCES `Songs` (`song_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Artists`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Artists` ;

CREATE TABLE IF NOT EXISTS `Artists` (
  `artist_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `bio` VARCHAR(255) NULL,
  `genre` VARCHAR(255) NULL,
  `label` VARCHAR(255) NULL,
  PRIMARY KEY (`artist_id`),
  UNIQUE INDEX `artist_id_UNIQUE` (`artist_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Artists_Songs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Artists_Songs` ;

CREATE TABLE IF NOT EXISTS `Artists_Songs` (
  `artist_song_id` INT NOT NULL AUTO_INCREMENT,
  `artist_id` INT NOT NULL,
  `song_id` INT NOT NULL,
  PRIMARY KEY (`artist_song_id`),
  INDEX `fk_Artists_Songs_Artists1_idx` (`artist_id` ASC) VISIBLE,
  INDEX `fk_Artists_Songs_Songs1_idx` (`song_id` ASC) VISIBLE,
  UNIQUE INDEX `artist_song_id_UNIQUE` (`artist_song_id` ASC) VISIBLE,
  CONSTRAINT `fk_Artists_Songs_Artists1`
    FOREIGN KEY (`artist_id`)
    REFERENCES `Artists` (`artist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Artists_Songs_Songs1`
    FOREIGN KEY (`song_id`)
    REFERENCES `Songs` (`song_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- EXAMPLE VALUES
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Insert into 'Users'
-- -----------------------------------------------------
INSERT INTO `Users` (`first_name`, `last_name`, `email`, `created_at`, `password`)
VALUES
(
  'Dejounte', 'Murray', 'dj@example.com', '2018-11-20', 'ThisIsMyPassword5'
),
(
  'Leonard', 'Moore', 'leonard@example.com', '2022-01-01', 'IsADog'
),
(
  'Brad', 'Pitt', 'brad@example.com', '2020-05-30', 'MattDamon1!'
),
(
  'Tom', 'Morello', 'tmo@example.com', '2019-02-04', 'Gu3rri11aRadi0'
),
(
  'Robert', 'Bobbie', 'robob@example.com', '2021-07-04', 'BobbyRob!!'
);

-- -----------------------------------------------------
-- Insert into 'Playlists'
-- -----------------------------------------------------
INSERT INTO `Playlists` (`created_at`, `title`, `user_id`)
VALUES
(
  '2022-10-03', 'Money Ball', '3'
),
(
  '2022-05-06', 'Sleep Music', '5'
),
(
  '2021-02-02', "Rollin' Down Rodeo", '4'
),
(
  '2021-02-01', 'Simple Plan Entire Discography', '4'
),
(
  '2021-01-05', 'Songs for Dogs', '2'
);

-- -----------------------------------------------------
-- Insert into 'Playlists_Songs'
-- -----------------------------------------------------
INSERT INTO `Playlists_Songs` (`playlist_id`, `song_id`)
VALUES
(
  '5', '3'
),
(
  '1', '4'
),
(
  '4', '1'
),
(
  '2', '3'
),
(
  '3', '2'
);

-- -----------------------------------------------------
-- Insert into 'Songs'
-- -----------------------------------------------------
INSERT INTO `Songs` (`title`, `length`, `release_date`, `album_id`)
VALUES
(
  'Generation', '00:03:03', '2008-02-12', '3'
),
(
  'Your Love Is a Lie', '00:03:42', '2008-02-12', '3'
),
(
  'Fireflies', '00:03:48', '2009-07-14', '1'
),
(
  "Ice Is Workin' It", '00:04:36', '1990-09-03', '2'
),
(
  'Walk This Way', '00:03:38', '1986-07-04', '4'
);

-- -----------------------------------------------------
-- Insert into 'Artists_Songs'
-- -----------------------------------------------------
INSERT INTO `Artists_Songs` (`artist_id`, `song_id`)
VALUES
(
  '1', '1'
),
(
  '1', '2'
),
(
  '2', '3'
),
(
  '3', '4'
),
(
  '4', '5'
),
(
  '5', '5'
);

-- -----------------------------------------------------
-- Insert into 'Albums'
-- -----------------------------------------------------
INSERT INTO `Albums` (`title`, `release_date`)
VALUES
(
  'Ocean Eyes', '2009-07-28'
),
(
  'To the Extreme', '1990-09-03'
),
(
  'Simple Plan', '2008-02-12'
),
(
  'Raising Hell', '1996-07-04'
);

-- -- -----------------------------------------------------
-- -- Insert into 'Artists_Albums'
-- -- -----------------------------------------------------
-- INSERT INTO `Artists_Albums` (`artist_id`, `album_id`)
-- VALUES
-- (
--   '2', '1'
-- ),
-- (
--   '3', '2'
-- ),
-- (
--   '1', '3'
-- ),
-- (
--   '4', '4'
-- ),
-- (
--   '5', '4'
-- );

-- -----------------------------------------------------
-- Insert into 'Artists'
-- -----------------------------------------------------
INSERT INTO `Artists` (`title`, `bio`, `genre`, `label`)
VALUES
(
  'Simple Plan',
  'Simple Plan is a Canadian rock band from Montreal, Quebec formed in 1999.',
  'Pop Punk', 'Atlantic'
),
(
  'Owl City',
  'Owl City is an American electronic music project created in 2007 in Owatonna, Minnesota.',
  'Synth Pop', 'Republic'
),
(
  'Vanilla Ice',
  'Robert Matthew Van Winkle (born October 31, 1967), known professionally as Vanilla Ice, is an American rapper, actor, and television host.',
  'Hip Hop', 'SBK'
),
(
  'Run-DMC',
  'Run-DMC (also spelled Run-D.M.C.) was an American hip hop group from Hollis, Queens, New York City, founded in 1983 by Joseph Simmons, Darryl McDaniels, and Jason Mizell.',
  'Hip Hop', 'Profile'
),
(
  'Aerosmith',
  'Aerosmith is an American rock band formed in Boston in 1970.',
  'Hard Rock', 'Columbia'
);


-- -----------------------------------------------------
-- TEST QUERIES
-- -----------------------------------------------------
select * from Users;
select * from Playlists;
select * from Playlists_Songs;
select * from Songs;
select * from Artists_Songs;
select * from Artists;
select * from Albums;
-- -----------------------------------------------------
-- TEST QUERIES
-- -----------------------------------------------------


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;