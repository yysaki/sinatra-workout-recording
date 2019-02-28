DROP TABLE IF EXISTS activities;
DROP TABLE IF EXISTS menus;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id mediumint not null auto_increment,
  name varchar(20),
  password varchar(20),
  PRIMARY KEY (id)
);

CREATE TABLE categories (
  id mediumint not null auto_increment,
  name varchar(20),
  PRIMARY KEY (id)
);

CREATE TABLE menus (
  id mediumint not null auto_increment,
  category_id mediumint,
  name varchar(20),
  level tinyint,
  PRIMARY KEY (id),
  FOREIGN KEY (category_id)
    REFERENCES categories(id)
    ON DELETE CASCADE
);

CREATE TABLE activities (
  id mediumint not null auto_increment,
  user_id mediumint,
  menu_id mediumint,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id)
    REFERENCES users(id)
    ON DELETE CASCADE,
  FOREIGN KEY (menu_id)
    REFERENCES menus(id)
    ON DELETE CASCADE
);

INSERT INTO categories (name) values ('Leg raise');

INSERT INTO menus (category_id, level, name)
SELECT c.id, 1, 'Knee tuck'
FROM categories c;

INSERT INTO menus (category_id, level, name)
SELECT c.id, 2, 'Flat Knee raise'
FROM categories c;

INSERT INTO menus (category_id, level, name)
SELECT c.id, 3, 'Flat bent leg raise'
FROM categories c;
