delete from Settings where id = 232;
insert into Settings (select 232, id, 'ignore', 'operatesOn,featureCatalogueCitation,Anchor,specification' from Settings where name like 'xlinkResolver');
UPDATE Settings SET value='2.10.3.2' WHERE name='version';
UPDATE Settings SET value='SNAPSHOT' WHERE name='subVersion';