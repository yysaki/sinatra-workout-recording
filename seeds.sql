DROP TABLE IF EXISTS activities;
DROP TABLE IF EXISTS menus;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id MEDIUMINT NOT NULL AUTO_INCREMENT,
  name VARCHAR(20),
  password VARCHAR(20),
  PRIMARY KEY (id)
);

CREATE TABLE categories (
  id MEDIUMINT NOT NULL AUTO_INCREMENT,
  name VARCHAR(20),
  PRIMARY KEY (id)
);

CREATE TABLE menus (
  id MEDIUMINT NOT NULL AUTO_INCREMENT,
  category_id MEDIUMINT,
  name VARCHAR(20),
  level TINYINT,
  PRIMARY KEY (id),
  FOREIGN KEY (category_id)
    REFERENCES categories(id)
    ON DELETE CASCADE
);

CREATE TABLE activities (
  id MEDIUMINT NOT NULL AUTO_INCREMENT,
  user_id MEDIUMINT,
  menu_id MEDIUMINT,
  reps TINYINT,
  sets TINYINT,
  acted_at datetime,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id)
    REFERENCES users(id)
    ON DELETE CASCADE,
  FOREIGN KEY (menu_id)
    REFERENCES menus(id)
    ON DELETE CASCADE
);

INSERT INTO categories (name) VALUES ('Leg raise');

INSERT INTO menus (category_id, level, name)
SELECT c.id, 1, 'Knee tuck'
FROM categories c;

INSERT INTO menus (category_id, level, name)
SELECT c.id, 2, 'Flat Knee raise'
FROM categories c;

INSERT INTO menus (category_id, level, name)
SELECT c.id, 3, 'Flat bent leg raise'
FROM categories c;
