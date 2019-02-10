DROP TABLE IF EXISTS comments;
create table comments (
  id mediumint not null auto_increment,
  body text,
  PRIMARY KEY (id)
);

INSERT INTO comments (body) values ('comment 1');
INSERT INTO comments (body) values ('comment 2');
INSERT INTO comments (body) values ('comment 3');

