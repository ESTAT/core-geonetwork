insert into Settings (select max(id) + 1, 1, 'statistics', NULL from Settings);
insert into Settings (select id+1, id, 'snippet', '' from Settings where name like 'statistics');
UPDATE Settings SET value='2.10.3.1' WHERE name='version';
UPDATE Settings SET value='SNAPSHOT' WHERE name='subVersion';