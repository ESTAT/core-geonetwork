
INSERT INTO settings (name, value, datatype, position, internal) VALUES ('metadata/workflow/draftWhenInGroup', '', 0, 100002, 'n');
INSERT INTO settings (name, value, datatype, position, internal) VALUES ('system/oai/maxrecords', '10', 1, 7040, 'y');

-- ALTER TABLE groups ALTER COLUMN email TYPE varchar(128);

UPDATE settings SET value='3.0.2' WHERE name='system/platform/version';
UPDATE settings SET value='SNAPSHOT' WHERE name='system/platform/subVersion';


create table HarvesterData (harvesterUuid varchar(255) not null, `key` varchar(255) not null, `value` varchar(255) not null, primary key (`harvesterUuid`, `key`)); 