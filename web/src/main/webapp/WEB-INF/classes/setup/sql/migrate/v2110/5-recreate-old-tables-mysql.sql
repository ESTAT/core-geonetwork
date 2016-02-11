-- Drop the old tables (that are being migrated to an enum) and create them again with new definition

-- Update UserGroups profiles to be one of the enumerated profiles

DROP TABLE usergroups;
CREATE TABLE USERGROUPS
  (
    userId   int          not null,
    groupId  int          not null,
    profile  int          not null,

    primary key(userId,groupId,profile),

--    foreign key(userId) references users(id),
    foreign key(groupId) references groups(id)
  );
-- Update UserGroups profiles to be one of the enumerated profiles

INSERT INTO USERGROUPS SELECT * FROM USERGROUPS_TMP;
DROP TABLE USERGROUPS_TMP;


-- Convert Profile column to the profile enumeration ordinal

ALTER TABLE groups DROP FOREIGN KEY `groups_ibfk_1`;
ALTER TABLE metadata DROP FOREIGN KEY `metadata_ibfk_1`;
ALTER TABLE metadatastatus DROP FOREIGN KEY `metadatastatus_ibfk_3`;

DROP TABLE users;
CREATE TABLE users
  (
    id            int           not null,
    username      varchar(256)  not null,
    password      varchar(120)  not null,
    surname       varchar(32),
    name          varchar(32),
    profile       int not null,
    organisation  varchar(128),
    kind          varchar(16),
    security      varchar(128)  default '',
    authtype      varchar(32),
    primary key(id),
    unique(username)
  );
-- Convert Profile column to the profile enumeration ordinal

INSERT INTO users SELECT * FROM USERS_TMP;
DROP TABLE USERS_TMP;
  
ALTER TABLE USERGROUPS ADD CONSTRAINT foreign key(userId) references users(id);
ALTER TABLE groups ADD CONSTRAINT `groups_ibfk_1` FOREIGN KEY (`referrer`) REFERENCES `users` (`id`);
ALTER TABLE metadata ADD CONSTRAINT `metadata_ibfk_1` FOREIGN KEY (`owner`) REFERENCES `users` (`id`);
ALTER TABLE metadatastatus ADD CONSTRAINT `metadatastatus_ibfk_3` FOREIGN KEY (`userId`) REFERENCES `users` (`id`);
ALTER TABLE UserAddress ADD CONSTRAINT foreign key(userId) references users(id);
ALTER TABLE Email ADD CONSTRAINT foreign key(user_id) references users(id);


-- ----  Change notifier actions column to map to the MetadataNotificationAction enumeration

DROP TABLE metadatanotifications;
CREATE TABLE MetadataNotifications
  (
    metadataId         int            not null,
    notifierId         int            not null,
    notified           char(1)        default 'n' not null,
    metadataUuid       varchar(250)   not null,
    action             int        not null,
    errormsg           text,
    primary key(metadataId,notifierId)
  );

-- ----  Change notifier actions column to map to the MetadataNotificationAction enumeration

INSERT INTO MetadataNotifications SELECT * FROM MetadataNotifications_Tmp;
DROP TABLE MetadataNotifications_Tmp;

-- ----  Change params querytype column to map to the LuceneQueryParamType enumeration

DROP TABLE params;

CREATE TABLE Params
  (
    id          int           not null,
    requestId   int,
    queryType   int,
    termField   varchar(128),
    termText    varchar(128),
    similarity  float,
    lowerText   varchar(128),
    upperText   varchar(128),
    inclusive   char(1),
    primary key(id),
    foreign key(requestId) references requests(id)
  );

-- ----  Change params querytype column to map to the LuceneQueryParamType enumeration

INSERT INTO Params SELECT * FROM Params_TEMP;
DROP TABLE Params_TEMP;

CREATE INDEX ParamsNDX1 ON Params(requestId);
CREATE INDEX ParamsNDX2 ON Params(queryType);
CREATE INDEX ParamsNDX3 ON Params(termField);
CREATE INDEX ParamsNDX4 ON Params(termText);
