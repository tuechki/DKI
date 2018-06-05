-- function

DROP FUNCTION changeCity;

DELIMITER $$
 
CREATE FUNCTION changeCity(name varchar(64)) RETURNS VARCHAR(64)
BEGIN
    IF name = 'Sofia' THEN
	SET name = 'Lovech';
    END IF;
 RETURN (name);
END$$

DELIMITER ;


-- procedure 


DROP PROCEDURE selectCity;

DELIMITER $$

CREATE PROCEDURE selectCity() 
BEGIN
  SELECT * FROM 12b_01_alexander_verbovskiy.city;
END$$

DELIMITER ;

CALL selectCity();


-- trigger 

DROP TRIGGER addPopulation;

DELIMITER $$

CREATE TRIGGER addPopulation BEFORE INSERT ON city
FOR EACH ROW
BEGIN
IF new.population < 10000 THEN
  SET new.population = 10000;
  END IF;
END$$


DELIMITER ;



-- select


SELECT team.name AS Team, country.name AS Country, city.name AS City, changeCity(city.name, team.name) 
AS realCity FROM city INNER JOIN country ON city.country_id = country.id INNER JOIN team ON team.country_id = country.id AND team.city_id = city.id;


-- tables 

DROP DATABASE 12b_01_alexander_verbovskiy;
CREATE DATABASE 12b_01_alexander_verbovskiy;
USE 12b_01_alexander_verbovskiy;

CREATE TABLE country (

  id int NOT NULL AUTO_INCREMENT,
  name varchar(64) UNIQUE NOT NULL,
  population int DEFAULT NULL,
  
  PRIMARY KEY (id)
);

CREATE TABLE city (

  id int NOT NULL AUTO_INCREMENT,
  country_id int DEFAULT NULL,
  name varchar(64) NOT NULL,
  population int DEFAULT NULL,
  
  PRIMARY KEY (id)
);

CREATE TABLE competition_type (

  id int(11) NOT NULL AUTO_INCREMENT,
  type varchar(64) UNIQUE DEFAULT NULL,
  
  PRIMARY KEY (id)
);

CREATE TABLE event_type (

  id int NOT NULL AUTO_INCREMENT,
  type varchar(16) UNIQUE DEFAULT NULL,
  
  PRIMARY KEY (id)
);

CREATE TABLE player_position (

  id int NOT NULL AUTO_INCREMENT,
  position varchar(16) UNIQUE DEFAULT NULL,
  
  PRIMARY KEY (id)
);

CREATE TABLE team (

  id int NOT NULL AUTO_INCREMENT,
  country_id int NOT NULL,
  city_id int DEFAULT NULL,
  name varchar(64) NOT NULL,
  abbreviature varchar(5) NOT NULL,
  
  PRIMARY KEY (id),
  FOREIGN KEY (country_id) REFERENCES country(id),
  FOREIGN KEY (city_id) REFERENCES city(id)
);

CREATE TABLE player (

  id int NOT NULL AUTO_INCREMENT,
  team_id int NOT NULL,
  nationality_id int DEFAULT NULL,
  player_position_id int DEFAULT NULL,
  first_name varchar(64) NOT NULL,
  last_name varchar(64) NOT NULL,
  shirt_name varchar(64) NOT NULL,
  number tinyint NOT NULL,
  
  PRIMARY KEY (id),
  FOREIGN KEY (team_id) REFERENCES team(id),
  FOREIGN KEY (nationality_id) REFERENCES country(id),
  FOREIGN KEY  (player_position_id) REFERENCES player_position(id)
);

CREATE TABLE stadium (

  id int NOT NULL AUTO_INCREMENT,
  team_id int DEFAULT NULL,
  city_id int DEFAULT NULL,
  name varchar(64) NOT NULL,
  capacity int DEFAULT NULL,
  
  PRIMARY KEY (id),
  FOREIGN KEY (team_id) REFERENCES team(id),
  FOREIGN KEY (city_id) REFERENCES city(id)
);

CREATE TABLE competition (

  id int NOT NULL AUTO_INCREMENT,
  country_id int DEFAULT NULL,
  competition_type_id int DEFAULT NULL,
  name varchar(64) NOT NULL,
  rounds int DEFAULT NULL,
  
  PRIMARY KEY (id),
  FOREIGN KEY (country_id) REFERENCES country(id), 
  FOREIGN KEY (competition_type_id) REFERENCES competition_type(id)
);

CREATE TABLE event (

  match_id int NOT NULL,
  team_id int NOT NULL,
  event_type_id int NOT NULL,
  minute int NOT NULL,
  message varchar(64) NOT NULL,
  
  PRIMARY KEY (match_id,team_id,event_type_id,minute),
  FOREIGN KEY (team_id) REFERENCES team(id),
  FOREIGN KEY (event_type_id) REFERENCES event_type(id)
);

CREATE TABLE match_info (

  id int NOT NULL AUTO_INCREMENT,
  competition_id int NOT NULL,
  isActive boolean DEFAULT false,
  venue int NOT NULL,
  date date NOT NULL,
  time time NOT NULL,
  home int NOT NULL,
  away int NOT NULL,
  halfLength tinyint NOT NULL,
  
  PRIMARY KEY (id),
  FOREIGN KEY (home) REFERENCES team(id),
  FOREIGN KEY (away) REFERENCES team(id),
  FOREIGN KEY (venue) REFERENCES stadium(id),
  FOREIGN KEY (competition_id) REFERENCES competition(id)
);
