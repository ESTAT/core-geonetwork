-- Creates New tables required for this version

CREATE TABLE HarvesterSettings
  (
    id        int            not null AUTO_INCREMENT,
    parentId  int,
    name      varchar(64)    not null,
    value     longtext,

    primary key(id),

    foreign key(parentId) references HarvesterSettings(id) on delete cascade
  );

CREATE TABLE Address
(
	id			  int 			not null AUTO_INCREMENT,
	address       varchar(128),
	city          varchar(128),
	state         varchar(64),
	zip           varchar(16),
	country       varchar(128),
	primary key(id)
);

CREATE TABLE UserAddress
(
	userId 	int not null AUTO_INCREMENT,
	addressId int not null,
	primary key(userId,addressId),
--    foreign key(userId) references users(id),
    foreign key(addressId) references Address(id)
);

CREATE TABLE Email
(
	user_id			  int 			not null,
	email         varchar(128),

	primary key(user_id)
--    foreign key(user_id) references users(id)
);
